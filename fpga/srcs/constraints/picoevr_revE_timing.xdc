# Timing Constraints
create_clock -period 10.000 -name sys_clk -waveform {0.000 5.000} [get_ports i_ZYNQ_MRCC1]
create_clock -period 10.000 -name dbg_clk -waveform {0.000 5.000} [get_ports i_ZYNQ_MRCC2]
create_clock -period 10.000 -name axi_clk -waveform {0.000 5.000} [get_nets {picoevr_system_arch_i/processing_system7_0/inst/FCLK_CLK_unbuffered[0]}]
create_clock -period 11.357 -name gt0_rxclk -waveform {0.000 5.679} [get_pins picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/gt0_x0y0/U0/z7_gtx_evr_i/gt0_z7_gtx_evr_i/gtxe2_i/RXOUTCLK]
create_clock -period 11.357 -name gt0_txclk -waveform {0.000 5.679} [get_pins picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/gt0_x0y0/U0/z7_gtx_evr_i/gt0_z7_gtx_evr_i/gtxe2_i/TXOUTCLK]
create_clock -period 11.357 -name gt0_refclk -waveform {0.000 5.679} [get_ports i_ZYNQ_CLKREF0_P]
create_generated_clock -name event_clk [get_pins picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/mmc_i/CLKOUT0]

set_clock_groups -asynchronous -group sys_clk -group axi_clk
set_clock_groups -asynchronous -group sys_clk -group gt0_refclk
set_clock_groups -asynchronous -group gt0_txclk -group sys_clk

# RXRESETDONE

# Info data in the register interface
set_false_path -from [get_pins {picoevr_system_arch_i/ESS_OpenEVR/U0/databuf_dc/topology_addr_reg[*]/C}] -to [get_pins {picoevr_system_arch_i/ESS_OpenEVR/U0/logic_return_t_0_reg[TopologyID][*]/D}]

# Check this one!
set_false_path -from [get_pins {picoevr_system_arch_i/ESS_OpenEVR/U0/databuf_dc/delay_comp_rx_reg[*]/C}] -to [get_pins {picoevr_system_arch_i/ESS_OpenEVR/U0/logic_return_t_0_reg[DCRxValue][*]/D}]
set_false_path -from [get_pins {picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/dbus_rxd_reg[*]/C}] -to [get_pins {picoevr_system_arch_i/ESS_OpenEVR/U0/logic_return_t_0_reg[Status][*]/D}]

# DC mode is mostly a fixed value

# False paths for the status register
set_false_path -from [get_pins {picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/o_gt_status_reg[link_up]/C}] -to [get_pins {picoevr_system_arch_i/ESS_OpenEVR/U0/logic_return_t_0_reg[Status][6]/D}]
set_false_path -from [get_pins {picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/o_gt_status_reg[fbclk_lost]/C}] -to [get_pins {picoevr_system_arch_i/ESS_OpenEVR/U0/logic_return_t_0_reg[ESSStatus][2]/D}]
set_false_path -from [get_pins {picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/o_gt_status_reg[event_rcv]/C}] -to [get_pins {picoevr_system_arch_i/ESS_OpenEVR/U0/logic_return_t_0_reg[ESSStatus][7]/D}]
set_false_path -from [get_pins {picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/o_gt_status_reg[tx_fsm_done]/C}] -to [get_pins {picoevr_system_arch_i/ESS_OpenEVR/U0/logic_return_t_0_reg[ESSStatus][0]/D}]
set_false_path -from [get_pins {picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/o_gt_status_reg[pll_locked]/C}] -to [get_pins {picoevr_system_arch_i/ESS_OpenEVR/U0/logic_return_t_0_reg[ESSStatus][3]/D}]
set_false_path -from [get_pins {picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/o_gt_status_reg[rx_fsm_done]/C}] -to [get_pins {picoevr_system_arch_i/ESS_OpenEVR/U0/logic_return_t_0_reg[ESSStatus][1]/D}]

# The delay status is steady enough
set_false_path -from [get_pins {picoevr_system_arch_i/ESS_OpenEVR/U0/databuf_dc/delay_comp_status_reg[*]/C}] -to [get_pins {picoevr_system_arch_i/ESS_OpenEVR/U0/logic_return_t_0_reg[DCStatus][*]/D}]

set_false_path -setup -from [get_pins picoevr_system_arch_i/ESS_OpenEVR/U0/dc_mode_r_reg/C] -to [get_pins picoevr_system_arch_i/ESS_OpenEVR/U0/dc_mode_0_reg/D]

set_false_path -from [get_pins {{picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/dbus_rxd_reg[0]/C} {picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/dbus_rxd_reg[1]/C} {picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/dbus_rxd_reg[2]/C} {picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/dbus_rxd_reg[3]/C} {picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/dbus_rxd_reg[4]/C} {picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/dbus_rxd_reg[5]/C} {picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/dbus_rxd_reg[6]/C} {picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/dbus_rxd_reg[7]/C}}] -to [get_pins {{picoevr_system_arch_i/ESS_OpenEVR/U0/logic_return_t_0_reg[Status][24]/D} {picoevr_system_arch_i/ESS_OpenEVR/U0/logic_return_t_0_reg[Status][25]/D} {picoevr_system_arch_i/ESS_OpenEVR/U0/logic_return_t_0_reg[Status][26]/D} {picoevr_system_arch_i/ESS_OpenEVR/U0/logic_return_t_0_reg[Status][27]/D} {picoevr_system_arch_i/ESS_OpenEVR/U0/logic_return_t_0_reg[Status][28]/D} {picoevr_system_arch_i/ESS_OpenEVR/U0/logic_return_t_0_reg[Status][29]/D} {picoevr_system_arch_i/ESS_OpenEVR/U0/logic_return_t_0_reg[Status][30]/D} {picoevr_system_arch_i/ESS_OpenEVR/U0/logic_return_t_0_reg[Status][31]/D} {picoevr_system_arch_i/ESS_OpenEVR/U0/logic_return_t_0_reg[Status][6]/D} {picoevr_system_arch_i/ESS_OpenEVR/U0/logic_return_t_0_reg[Status][7]/D}}]
set_false_path -from [get_pins {{picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/o_gt_status_reg[event_rcv]/C} {picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/o_gt_status_reg[fbclk_lost]/C} {picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/o_gt_status_reg[link_up]/C} {picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/o_gt_status_reg[pll_locked]/C} {picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/o_gt_status_reg[rx_fsm_done]/C} {picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/o_gt_status_reg[tx_fsm_done]/C}}] -to [get_pins picoevr_system_arch_i/ESS_OpenEVR/U0/gbl_reset_0_reg/D]
