#start_gui
open_hw_manager
# IP belongs to the mini crate for the tests in the ICS Lab 6
connect_hw_server -url 172.30.5.155:3121 -allow_non_jtag
current_hw_target [get_hw_targets */xilinx_tcf/Digilent/210299A1F24E]
set_property PARAM.FREQUENCY 10000000 [get_hw_targets */xilinx_tcf/Digilent/210299A1F24E]
open_hw_target
current_hw_device [get_hw_devices xc7z030_1]
refresh_hw_device -update_hw_probes false [lindex [get_hw_devices xc7z030_1] 0]
set debug_file [glob fpga/output/build/binaries/picoEVR_*.ltx]
set_property PROBES.FILE $debug_file [get_hw_devices xc7z030_1]
set_property FULL_PROBES.FILE $debug_file [get_hw_devices xc7z030_1]
set binary_file [glob fpga/output/build/binaries/picoEVR_*.bit]
set_property PROGRAM.FILE $binary_file [get_hw_devices xc7z030_1]
program_hw_devices [get_hw_devices xc7z030_1]
refresh_hw_device [lindex [get_hw_devices xc7z030_1] 0]
display_hw_ila_data [ get_hw_ila_data hw_ila_data_1 -of_objects [get_hw_ilas -of_objects [get_hw_devices xc7z030_1] -filter {CELL_NAME=~"picoevr_system_arch_i/ila_0"}]]
display_hw_ila_data [ get_hw_ila_data hw_ila_data_2 -of_objects [get_hw_ilas -of_objects [get_hw_devices xc7z030_1] -filter {CELL_NAME=~"u_ila_0"}]]
startgroup
set_property CONTROL.DATA_DEPTH 128 [get_hw_ilas -of_objects [get_hw_devices xc7z030_1] -filter {CELL_NAME=~"u_ila_0"}]
set_property CONTROL.TRIGGER_POSITION 127 [get_hw_ilas -of_objects [get_hw_devices xc7z030_1] -filter {CELL_NAME=~"u_ila_0"}]
endgroup
set_property CONTROL.TRIGGER_POSITION 1 [get_hw_ilas -of_objects [get_hw_devices xc7z030_1] -filter {CELL_NAME=~"u_ila_0"}]
set_property TRIGGER_COMPARE_VALUE eq16'hAA00 [get_hw_probes picoevr_system_arch_i/ESS_OpenEVR/U0/evr_mgt_wrapper/i_upstream/rx_data -of_objects [get_hw_ilas -of_objects [get_hw_devices xc7z030_1] -filter {CELL_NAME=~"u_ila_0"}]]
run_hw_ila [get_hw_ilas -of_objects [get_hw_devices xc7z030_1] -filter {CELL_NAME=~"u_ila_0"}]
wait_on_hw_ila -timeout 1 [get_hw_ilas -of_objects [get_hw_devices xc7z030_1] -filter {CELL_NAME=~"u_ila_0"}]
display_hw_ila_data [upload_hw_ila_data [get_hw_ilas -of_objects [get_hw_devices xc7z030_1] -filter {CELL_NAME=~"u_ila_0"}]]
write_hw_ila_data -csv_file {sw/test/iladata.csv} hw_ila_data_2
close_hw_manager
