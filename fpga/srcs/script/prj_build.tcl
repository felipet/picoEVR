#
# TCL source of the project 
#
#
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

proc empty_file { name } {
    # Detect if a file is empty or not
    set f [open $name]
    set dummy [gets $f]
    if {[eof $f]} {
        return 1
    }
    return 0
}

proc check_key_exists { arr key } {
    upvar $arr tmpArray
    
    set exists 0
    if {[info exists tmpArray($key)]} {
         set exists 1
    } 
    return $exists
}

proc add_files_if_ne args {
    # add a file, if list not empty
    set has_opts 0
    if {[ llength $args] > 1} {
        set opts [lindex $args 1]
        set name [lindex $args 2]
        set has_opts 1
    } else {
        set name [lindex $args 1]
    }
    if { $name ne "" } { 
        puts "name = $name"
        if { $has_opts ne 0 } {
            add_files $opts $name 
        } else {
            add_files $name
        }
    }
}

proc default_value { key } {
    
    switch $key {
        "directory.src"                   { return "." }
        "directory.output"                { return "fpga/output" }
        "directory.build"                 { return "fpga/output/build" }
        "directory.log"                   { return "fpga/output/log" }
        "project.fileset.src"             { return "sources_1" }
        "project.fileset.con"             { return "constrs_1" }
        "project.fileset.sim_1"           { return "sim_1" }
        "project.top"                     { return "gen_from_bd" } 
        "project.runs.synthesis.name"     { return "synthesis" } 
        "project.runs.synthesis.flow"     { return "Vivado Synthesis 2019" } 
        "project.runs.synthesis.strategy" { return "Default" }
         default {
            puts "ERROR: No default value found for key '$key'\n"
            return 1
        }        
    }

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

proc make_project { name proc } {
    array set optArray {}

	read_options $opt_fn optArray

    # Import files
    set hdlFiles [read_files  "$optArray(files.hdl)"   $optArray(directory.src)]
    set ipFiles  [read_files  "$optArray(files.ip)"    $optArray(directory.src)]
    set xdcFiles [read_files  "$optArray(files.xdc)"   $optArray(directory.src)]
    set simFiles [read_files  "$optArray(files.sim)"   $optArray(directory.src)]

    set emptySim [empty_file $optArray(files.hdl)]

    # create project
    set proj_dir $optArray(directory.output)/$optArray(project.dir)
    create_project  "$optArray(project.name)" $proj_dir -part $optArray(project.part)

    # Some parameters taken from Vivado's definition of the project
    set_param project.singleFileAddWarning.threshold 0
    set_property ip_cache_permissions {read write} [current_project]
    set_property XPM_LIBRARIES {XPM_CDC XPM_MEMORY} [current_project]

    # Set project properties
    set obj [get_projects $optArray(project.name)]
    set_property "part"             $optArray(project.part) $obj
    set_property "target_language"  "VHDL"                  $obj
    set_property "target_simulator" "ModelSim"              $obj
    set_property "ip_output_repo"   $optArray(directory.build) $obj

    # Create 'sources_1' fileset (if not found)
    if {[string equal [get_filesets -quiet sources_1] ""]} {
        create_fileset -srcset sources_1
    }
    set obj [get_filesets $optArray(project.fileset.src)]
    add_files -norecurse -fileset $obj $hdlFiles
    add_files -norecurse -fileset $obj $ipFiles

    set_property "top" $optArray(project.top) $obj

    set obj [get_filesets $optArray(project.fileset.con)]
    add_files -norecurse -fileset $obj $xdcFiles
    set_property "name" $optArray(project.fileset.con) $obj
    
    create_run -name $optArray(project.runs.synthesis.name) -part $optArray(project.part) -flow $optArray(project.runs.synthesis.flow) -constrset $optArray(project.fileset.con)
    current_run -synthesis [get_runs  $optArray(project.runs.synthesis.name)]

    set obj [get_runs $optArray(project.runs.synthesis.name)]
    set_property "srcset"  $optArray(project.fileset.src)  $obj

    create_run -name $optArray(project.runs.implementation.name) -part $optArray(project.part) -flow $optArray(project.runs.implementation.flow) -constrset $optArray(project.fileset.con) -parent_run $optArray(project.runs.synthesis.name)
    current_run -implementation [get_runs $optArray(project.runs.implementation.name)]
    
    launch_runs synthesis      -jobs 8 -scripts_only
    launch_runs implementation -jobs 4 -scripts_only
}

#
# Function to make the synthesis in non-project mode
#

proc synthesize { name debug onlyReports opt_fn } {
    array set optArray {}
    set dcpFiles [list]
	read_options $opt_fn optArray    

    # Get values
    set top         [ check_key_then_default optArray "project.top" ]
    set build_dir   [ check_key_then_default optArray "directory.build" ]
    set log_dir     [ check_key_then_default optArray "directory.log" ]
    set part        [ check_key_then_default optArray "project.part" ]
    set synth_strat [ check_key_then_default optArray "project.runs.synthesis.strategy" ]


    if { $onlyReports == 1 } {
        open_checkpoint $build_dir/$top.dcp
        report_utilization -file $log_dir/${top}_utilization_synth.rpt -pb $log_dir/${top}_utilization_synth.pb
        report_timing_summary $optArray(reports.timing.flags) -file $log_dir/${top}_synth_timing.rpt
        return 0
    }

    # 1. Create a "in memory" project and set common parameters
    create_project -in_memory -ip -part $part $build_dir

    set_property default_lib xil_defaultlib [current_project]
    set_property XPM_LIBRARIES {XPM_CDC XPM_MEMORY} [current_project]
    set_property target_language VHDL [current_project]

    set_param    project.compositeFile.enableAutoGeneration 0
    set_param    synth.vivado.isSynthRun true

    # 2. Add files to the project (sources, IPs, constraints,...)
    set hdlFiles [read_files  optArray "files.hdl"  $optArray(directory.src)]
    set ipFiles  [read_files  optArray "files.ip"   $optArray(directory.src)]
    set xdcFiles [read_files  optArray "files.xdc"  $optArray(directory.src)]
    set coeFiles [read_files  optArray "files.coe"  $optArray(directory.src)]
    
    if { $ipFiles ne "" } {
        foreach el $ipFiles {
            regsub -- {.*/([^/]*)\.[^\.]*$} $el {\1} elDcp
            lappend dcpFiles [ file normalize "./$build_dir/ip/$elDcp.dcp" ]
        }
    } 
    add_files_if_ne $dcpFiles

    foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
        set_property used_in_implementation false $dcp
    }
    
    if { $hdlFiles ne ""} {
        read_vhdl -library xil_defaultlib $hdlFiles
    }    
    
    add_files_if_ne -norecurse $coeFiles
    
    if { $ipFiles ne "" } {
        read_ip  $ipFiles
    }
    
    if { $xdcFiles ne "" } {
        read_xdc $xdcFiles
    }

    # 3. Set parameters for the added files
    foreach dcp [get_files -quiet -all *.dcp] {
        set_property used_in_implementation false $dcp
    }

    foreach xci [get_files -quiet -all *.xci] {
        set_property used_in_implementation false $xci
    }
    
    foreach xdc [get_files -quiet -all *.xdc] {
        set_property used_in_implementation false $dcp
    }

    # 4. Run synthesis
    if { $top == "gen_from_bd" } {
        # Generate top-level wrapper from block diagram, and import
        set bd_name [get_bd_designs]
        make_wrapper -files [get_files $bd_name] -top -import
    }

    synth_design -top $top -part $part -fanout_limit 100 -fsm_extraction one_hot -keep_equivalent_registers -resource_sharing off -no_lc -shreg_min_size 5 -directive $synth_strat) -retiming
    write_checkpoint -force -noxdef $build_dir/$top.dcp

    if { $debug == 1 } {
        catch {
        report_utilization -file $optArray(directory.log)/$optArray(project.top)_utilization_synth.rpt -pb $optArray(directory.log)/$optArray(project.top)_utilization_synth.pb
        report_timing_summary $optArray(reports.timing.flags) -file $optArray(directory.log)/$optArray(project.top)_synth_timing.rpt
        }
    }
}

#
# Function to make the implementation in non-project mode
#

proc implement { name debug onlyReports opt_fn } {
    array set optArray {}
    set dcpFiles [list]
	read_options $opt_fn optArray
    
    if { $onlyReports == 1 } {
        open_checkpoint $optArray(directory.build)/$optArray(project.top)_routed.dcp
        report_timing_summary $optArray(reports.timing.flags) -file $optArray(directory.log)/$optArray(project.top)_routed_timing.rpt
        return 0
    }

    # 1. Create a "in memory" project and set common parameters
    set outputdir $optArray(directory.build)
    create_project -in_memory -ip -part $optArray(project.part) $optArray(directory.build)

    set_param project.singleFileAddWarning.threshold 0
    set_property design_mode GateLvl [current_fileset]
    set_param project.singleFileAddWarning.threshold 0
    set_property XPM_LIBRARIES {XPM_CDC XPM_MEMORY} [current_project]

    # 2. Add files to the project (sources, IPs, constraints,...)
    set xdcFiles [read_files  "$optArray(files.xdc)"  $optArray(directory.src)]
    set ipFiles  [read_files  "$optArray(files.ip)"   $optArray(directory.src)]
    
    add_files $optArray(directory.build)/$optArray(project.top).dcp

    foreach el $ipFiles {
        regsub -- {.*/([^/]*)\.[^\.]*$} $el {\1} ipBareName
        lappend dcpFiles [ file normalize "./$optArray(directory.build)/ip/$ipBareName.dcp" ]
    }
    add_files $dcpFiles
    read_xdc  $xdcFiles

    link_design -top  $optArray(project.top) -part $optArray(project.part)
    write_hwdef -force -file $optArray(directory.build)/$optArray(project.top).hwdef

    opt_design
    write_checkpoint -force $optArray(directory.build)/$optArray(project.top)_opt.dcp

    #implement_debug_core
    place_design -directive $optArray(project.runs.implementation.place)
    write_checkpoint -force $optArray(directory.build)/$optArray(project.top)_placed.dcp

    if {[get_property SLACK [get_timing_paths -max_paths 1 -nworst 1 -setup]] < 0} {
        puts "Found setup timing violations => running physical optimization"
        phys_opt_design -directive Explore
        write_checkpoint -force $optArray(directory.build)/$optArray(project.top)_physopt.dcp
    }

    route_design -directive $optArray(project.runs.implementation.route)
    write_checkpoint -force $optArray(directory.build)/$optArray(project.top)_routed.dcp
}

#
# Function to generate the bitstream
#

proc bitstream { name opt_fn } {
    array set optArray {}
	read_options $opt_fn optArray

    create_project -in_memory -ip -part $optArray(project.part) $optArray(directory.build)

    add_files $optArray(directory.build)/$optArray(project.top)_routed.dcp
    set_property netlist_only true [get_files *.dcp]
    link_design -top  $optArray(project.top) -part $optArray(project.part)

    # Not needed by now
    if { [file exists tcl/pre.bitstream.tcl] == 1 } {
        source tcl/pre.bitstream.tcl
    }

#    write_debug_probes -force -file $optArray(directory.build)/$optArray(project.top).ltx

#    write_mem_info  -force          $optArray(directory.build)/$optArray(project.top).mmi
    write_bitstream -force -verbose $optArray(directory.build)/$optArray(project.top).bit
}

#
# Function to generate all the IPs
#
proc generate_all_ip { name lIdx hIdx opt_fn} {
    array set optArray {}
	read_options $opt_fn optArray

    set ipFiles  [read_files  "$optArray(files.ip)"    $optArray(directory.src)]

    # Workflow for OOC IPs
    # 1. Check if DCP already exists in the project hierarchy.
    # 2. If exists, check if the XCIX timestamp is more recent than the one from
    #    the XCI file.
    # 3. If it does not exists, or the ts is older, generate the DCP.
    # 4. Otherwise, skip the IP file.
    for {set i $lIdx} {$i <= $hIdx} {incr i} {
        set ip [lindex $ipFiles $i]
        regsub -- {.*/([^/]*)\.[^\.]*$} $ip {\1} ipBareName
        set dcpFile [ file normalize "./$optArray(directory.build)/ip/$ipBareName.dcp" ]

        puts "-----------------------------------------------------------------"
        puts "Building IP $ipBareName"
        puts "-----------------------------------------------------------------"
        if {([file exists $dcpFile] == 0) || [expr {[file mtime $ip ] > [file mtime $dcpFile ]}]} {
            create_project -in_memory -part $optArray(project.part)
            read_ip $ip
            upgrade_ip [get_ips]
            
            generate_target -force all [get_ips]
            synth_design -top $ipBareName -part $optArray(project.part) -mode out_of_context
            rename_ref -prefix_all "$ipBareName\_"
            write_checkpoint -force -noxdef "$dcpFile"
            puts "Writting result in $dcpFile ---------------------------------"
        } else { puts "\t$ipBareName up to date"}
    }
}

#
# Main
#

set name       ""
set ipFileName ""
set action     "help"

if { $::argc > 0 } {
    for {set i 0} {$i < [llength $::argv]} {incr i} {
        set option [string trim [lindex $::argv $i]]
        switch -regexp -- $option {
            "--name"           { incr i; set name [lindex $::argv $i] }
            "--make_project"   { set action "make_project" }
            "--synthesis"      { set action "syn" }
            "--implementation" { set action "imp" }
            "--bitstream"      { set action "bit" }
            "--generate-ip"    { set action "ip" }
            "--opt"            { incr i; set opt_fn [ lindex $::argv $i ] }
            "--debug"          { incr i; set debug [lindex $::argv $i] }
            "--import-dcp"     { incr i; set import [ lindex $::argv $i ] }
            "--index"          { incr i; set lIdx [ lindex $::argv $i ];
                               incr i; set hIdx [ lindex $::argv $i ] }
            #"--help"         { set action "hhhh" }
            default {
            if { [regexp {^-} $option] } {
                puts "ERROR: Unknown option '$option' specified, please type '$script_file -tclargs --help' for usage info.\n"
                return 1
            }
            }
        }
    }
}

if { [string equal $action "make_project"] } {
  make_project $name $opt_fn
}

if { [string equal $action "syn"] } {
	synthesize $name $debug $import $opt_fn
}

if { [string equal $action "imp"] } {
	implement $name $debug $import $opt_fn
}

if { [string equal $action "bit"] } {
  bitstream $name $opt_fn
}

if { [string equal $action "ip"] } {
	generate_all_ip $name $lIdx $hIdx $opt_fn
}
