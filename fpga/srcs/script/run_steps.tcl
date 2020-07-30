###################################################################
# run_steps.tcl
#
# TCL file to run the various steps, up-to bitstream creation:
#  - synthesis, implementation, bitgen
#
# Requires the project to already be created
#
# How to call:
# $vivado -mode batch -source run_steps -tclargs <project_file> <step_to_run>
###################################################################

proc default_value { key } {

    switch $key {
        "directory.src"                   { return "." }
        "directory.output"                { return "fpga/output" }
        "directory.build"                 { return "fpga/output/build" }
        "directory.bin"                   { return "fpga/output/build/binaries"}
        "directory.log"                   { return "fpga/output/log" }
        "project.fileset.src"             { return "sources_1" }
        "project.fileset.con"             { return "constrs_1" }
        "project.fileset.sim_1"           { return "sim_1" }
        "project.top"                     { return "gen_from_bd" }
        "project.name"                    { return "vivado_prj" }
        "project.board"                   { return "picozed" }
        "project.dir"                     { return "vivado_project" }
        "project.runs.synthesis.name"     { return "synthesis" }
        "project.runs.synthesis.flow"     { return "Vivado Synthesis 2019" }
        "project.runs.synthesis.strategy" { return "Default" }
         default {
            puts "ERROR: No default value found for key '$key'\n"
            return 1
        }
    }
}

proc check_key_exists { arr key } {
    upvar $arr tmpArray

    set exists 0
    if {[info exists tmpArray($key)]} {
         set exists 1
    }
    return $exists
}

proc check_key_then_default { arr key } {
    upvar $arr tmpArray

    if { [ check_key_exists tmpArray $key ] } {
        return $tmpArray($key)
    } else {
        set def_val [ default_value $key ]
        puts "No value for key '$key' found in project options. Using default value ($def_val)"
        return $def_val
    }
}

proc read_files { arr key root_dir } {
    upvar $arr tmpArray
    set ret ""

    # Only attempt to read file if array key exists
    if {[info exists tmpArray($key)]} {
        set name $tmpArray($key)
        puts "name = $name"
        set file_ptr  [open $name r]
        set file_data [read $file_ptr]
        close $file_ptr

        set tempList0 [split $file_data]
        set tempList1 [list]

        foreach i $tempList0 {
            if {$i ne ""  && [string range $i 0 0 ] ne "#"} {
                lappend tempList1 [ file normalize "$root_dir/$i" ]
            }
        }
        set ret $tempList1
    }
    return $ret
}
proc read_options { name target } {
    upvar $target tempArray

    set file_ptr  [open $name r]
    set file_data [read $file_ptr]
    close $file_ptr

    set tempList0 [split $file_data "\n"]
    set optName ""
    set optVal  ""

    foreach i $tempList0 {
        if {$i ne ""  && [string range $i 0 0 ] ne "#"} {
            regexp {[ ]*([^:]+)[ ]*:[ ]*(.+)} $i -> optName optVal
            set tempArray($optName) $optVal
        }
    }
}

proc run_step { step } {
    if { [get_property PROGRESS [get_runs $step ]] != "100%" } {
        puts "Running $step ..."
        launch_runs -jobs 4 $step
        wait_on_run -timeout 60 $step
    } else {
        puts "Step $step already completed. Skipping..."
    }
}

#
# Main
#

# Parse input arguments
if { $argc > 0 } {
    set step [lindex $argv 0]
    puts "Setting step to $step"
    if { $argc > 1 } {
      set fw_carrier [lindex $argv 1]
      puts "Compiling for the carrier board $fw_carrier"
    }
} else {
    set step "synth"
    puts "No step string provided. Setting to \"$step\""
}

set scripts_dir [file dirname [info script]]
set opt_fn $scripts_dir/project.options

array set optArray {}
read_options $opt_fn optArray

# Import files
set outdir     [ check_key_then_default optArray "directory.output" ]
set build_dir  [ check_key_then_default optArray "directory.build" ]
set bin_dir    [ check_key_then_default optArray "directory.bin" ]
set prj_name   [ check_key_then_default optArray "project.name" ]
set prj_dir    [ check_key_then_default optArray "project.dir" ]
set prj_file   $outdir/$prj_dir/$prj_name.xpr
set board      [ check_key_then_default optArray "project.board" ]
set top_dir    $scripts_dir/..

# Check for project
if { [file exists $prj_file] == 0 } {
    puts "ERROR: Project $prj_file not found"
    exit 1
}

# Set flags for steps to run
set runsynth 0
set runimpl 0
set runbitgen 0
switch $step {
    synth {
        set runsynth  1
    }
    impl {
        set runsynth  1
        set runimpl   1
    }
    bitstream {
        set runsynth  1
        set runimpl   1
        set runbitgen 1
    }
    default     {
        puts "ERROR: Unrecognised step \"$step\". Exiting"
        exit
    }
}


# Open vivado project in subdirectory
open_project $prj_file

if { $runsynth == 1 } {
    run_step {synth_1}
    open_run synth_1
    write_checkpoint -force -noxdef $build_dir/${prj_name}_${fw_carrier}.dcp
}
if { $runimpl == 1 } {
    run_step {impl_1}
    open_run impl_1
    write_checkpoint -force -noxdef $build_dir/${prj_name}_${fw_carrier}_routed.dcp
}
if { $runbitgen == 1 } {
    puts "Running bitstream generation..."
    open_run impl_1
    write_debug_probes -force -quiet $bin_dir/${prj_name}_${fw_carrier}.ltx
    write_bitstream -force $bin_dir/${prj_name}_${fw_carrier}.bit
}
