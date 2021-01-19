# Timing Constraints ---------------------------------------------------------

# Clock definition
create_clock -period 10.000 -name sys_clk -waveform {0.000 5.000} [get_ports i_ZYNQ_MRCC1]
create_clock -period 10.000 -name dbg_clk -waveform {0.000 5.000} [get_ports i_ZYNQ_MRCC2]
create_clock -period 10.000 -name axi_clk -waveform {0.000 5.000} [get_pins {picoevr_system_arch_i/processing_system7_0/inst/PS7_i/FCLKCLK[0]}]
create_clock -period 11.357 -name gt0_rxclk -waveform {0.000 5.679} [get_pins picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/gt0_x0y0/U0/z7_gtx_evr_i/gt0_z7_gtx_evr_i/gtxe2_i/RXOUTCLK]
create_clock -period 11.357 -name gt0_txclk -waveform {0.000 5.679} [get_pins picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/gt0_x0y0/U0/z7_gtx_evr_i/gt0_z7_gtx_evr_i/gtxe2_i/TXOUTCLK]
create_clock -period 11.357 -name gt0_refclk -waveform {0.000 5.679} [get_ports i_ZYNQ_CLKREF0_P]

create_generated_clock -name chmapper_ref1 -source [get_pins picoevr_system_arch_i/channel_mapper/U0/clk_mux/I1] -multiply_by 1 -add -master_clock mmcm_clk0 [get_pins picoevr_system_arch_i/channel_mapper/U0/clk_mux/O]
create_generated_clock -name chmapper_ref0 -source [get_pins picoevr_system_arch_i/channel_mapper/U0/clk_mux/I0] -multiply_by 1 -add -master_clock sys_clk [get_pins picoevr_system_arch_i/channel_mapper/U0/clk_mux/O]

# Relations between clocks

# The axi_clk is derived from a PS's PLL and it's async to any other clock in the system
set_clock_groups -asynchronous -group [get_clocks axi_clk]

# These clocks are driven from a clock mux: only one will be active at a time
set_clock_groups -physically_exclusive \
      -group [get_clocks -include_generated_clock chmapper_ref0] \
      -group [get_clocks -include_generated_clock chmapper_ref1]

# Clocks derived from the received data at the GT vs clocks derived from the internal reference for the GT
set_clock_groups -physically_exclusive \
      -group [get_clocks -include_generated_clock gt0_rxclk] \
      -group [get_clocks -include_generated_clock gt0_txclk]
      
# By now, the sys_clk is 100 MHz and the Tx clk is 88.0825
set_clock_groups -physically_exclusive \
      -group [get_clocks -include_generated_clock sys_clk] \
      -group [get_clocks -include_generated_clock gt0_txclk]
      
set_clock_groups -physically_exclusive \
      -group [get_clocks -include_generated_clock sys_clk] \
      -group [get_clocks -include_generated_clock gt0_rxclk]
