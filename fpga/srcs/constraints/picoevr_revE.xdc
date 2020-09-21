# =============================================================================
# @file   picoevr_revE.xdc
# @brief  Top constraint file for the PicoEVR golden firmware
# -----------------------------------------------------------------------------
# @author Felipe Torres González <felipe.torresgonzalez@ess.eu>
# @author Ross Elliot <ross.elliot@ess.eu>
# @company European Spallation Source ERIC
# @date 20200729
#
# Platform:       picoZED 7030
# Carrier board:  Tallinn picoZED carrier board (aka FPGA-based IOC) revE
# Based on the AVNET xdc file for the picozed 7z030 RevC v2
# =============================================================================

# =============================================================================
# Clocks
# =============================================================================
# From Si5332A-D-GM1 Out 2
set_property -dict {PACKAGE_PIN Y18 IOSTANDARD LVCMOS33} [get_ports i_ZYNQ_MRCC1]
# From Si5332A-D-GM1 Out 0
set_property -dict {PACKAGE_PIN Y14 IOSTANDARD LVCMOS33} [get_ports i_ZYNQ_MRCC2]

# From Si5332A-D-GM1 Out 3
set_property PACKAGE_PIN V5 [get_ports i_ZYNQ_CLKREF1_N]
# From Si5332A-D-GM1 Out 4
set_property PACKAGE_PIN V9 [get_ports i_ZYNQ_CLKREF0_N]

# =============================================================================
# OpenEVR
# =============================================================================
set_property -dict {PACKAGE_PIN H5 IOSTANDARD LVCMOS18} [get_ports o_EVR_LINK_LED]
set_property -dict {PACKAGE_PIN H6 IOSTANDARD LVCMOS18} [get_ports o_EVR_EVNT_LED]
set_property -dict {PACKAGE_PIN AB3} [get_ports o_EVR_TX_N]
set_property -dict {PACKAGE_PIN AB7} [get_ports i_EVR_RX_N]
set_property -dict {PACKAGE_PIN V13 IOSTANDARD LVCMOS33} [get_ports i_EVR_SFP_MOD_0]
set_property -dict {PACKAGE_PIN Y13 IOSTANDARD LVCMOS33} [get_ports o_EVR_TX_DISABLE]

# =============================================================================
# MRF Universal Module Socket
# =============================================================================
set_property -dict {PACKAGE_PIN G3   IOSTANDARD LVCMOS18} [get_ports o_MRF_UNIVMOD_OUT0]; # IO_L22P_T3_AD7P_35
set_property -dict {PACKAGE_PIN G2   IOSTANDARD LVCMOS18} [get_ports o_MRF_UNIVMOD_OUT1]; # IO_L22N_T3_AD7N_35
set_property -dict {PACKAGE_PIN G4   IOSTANDARD LVCMOS18} [get_ports i_MRF_UNIVMOD_IN0];  # IO_L20P_T3_AD6P_35
set_property -dict {PACKAGE_PIN F4   IOSTANDARD LVCMOS18} [get_ports i_MRF_UNIVMOD_IN1];  # IO_L20N_T3_AD6N_35

set_property -dict {PACKAGE_PIN AA14 IOSTANDARD LVCMOS33} [get_ports   MRF_UNIVMOD_DIS];  # IO_L11P_T1_SRCC_13
set_property -dict {PACKAGE_PIN AA15 IOSTANDARD LVCMOS33} [get_ports   MRF_UNIVMOD_LCLK]; # IO_L11N_T1_SRCC_13
set_property -dict {PACKAGE_PIN U19  IOSTANDARD LVCMOS33} [get_ports   MRF_UNIVMOD_SCLK]; # IO_L20P_T3_13
set_property -dict {PACKAGE_PIN V19  IOSTANDARD LVCMOS33} [get_ports   MRF_UNIVMOD_DIN];  # IO_L20N_T3_13

# =============================================================================
# LEMO Connectors
# =============================================================================
set_property -dict {PACKAGE_PIN N8 IOSTANDARD LVCMOS18} [get_ports {b_LEMO_IO[0]}]
set_property -dict {PACKAGE_PIN AB18 IOSTANDARD LVCMOS33} [get_ports {o_LEMO_DIR[0]}]
set_property -dict {PACKAGE_PIN P8 IOSTANDARD LVCMOS18} [get_ports {b_LEMO_IO[1]}]
set_property -dict {PACKAGE_PIN AB19 IOSTANDARD LVCMOS33} [get_ports {o_LEMO_DIR[1]}]
set_property -dict {PACKAGE_PIN M8 IOSTANDARD LVCMOS18} [get_ports {b_LEMO_IO[2]}]
set_property -dict {PACKAGE_PIN AB21 IOSTANDARD LVCMOS33} [get_ports {o_LEMO_DIR[2]}]
set_property -dict {PACKAGE_PIN M7 IOSTANDARD LVCMOS18} [get_ports {b_LEMO_IO[3]}]
set_property -dict {PACKAGE_PIN AB22 IOSTANDARD LVCMOS33} [get_ports {o_LEMO_DIR[3]}]

create_debug_core u_ila_0 ila
set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_0]
set_property ALL_PROBE_SAME_MU_CNT 4 [get_debug_cores u_ila_0]
set_property C_ADV_TRIGGER true [get_debug_cores u_ila_0]
set_property C_DATA_DEPTH 8192 [get_debug_cores u_ila_0]
set_property C_EN_STRG_QUAL true [get_debug_cores u_ila_0]
set_property C_INPUT_PIPE_STAGES 2 [get_debug_cores u_ila_0]
set_property C_TRIGIN_EN false [get_debug_cores u_ila_0]
set_property C_TRIGOUT_EN false [get_debug_cores u_ila_0]
set_property port_width 1 [get_debug_ports u_ila_0/clk]
connect_debug_port u_ila_0/clk [get_nets [list picoevr_system_arch_i/ESS_OpenEVR/U0/debug_clk]]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe0]
set_property port_width 16 [get_debug_ports u_ila_0/probe0]
connect_debug_port u_ila_0/probe0 [get_nets [list {picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/rx_data[0]} {picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/rx_data[1]} {picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/rx_data[2]} {picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/rx_data[3]} {picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/rx_data[4]} {picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/rx_data[5]} {picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/rx_data[6]} {picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/rx_data[7]} {picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/rx_data[8]} {picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/rx_data[9]} {picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/rx_data[10]} {picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/rx_data[11]} {picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/rx_data[12]} {picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/rx_data[13]} {picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/rx_data[14]} {picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/rx_data[15]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe1]
set_property port_width 2 [get_debug_ports u_ila_0/probe1]
connect_debug_port u_ila_0/probe1 [get_nets [list {picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/tx_charisk[0]} {picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/tx_charisk[1]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe2]
set_property port_width 8 [get_debug_ports u_ila_0/probe2]
connect_debug_port u_ila_0/probe2 [get_nets [list {picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/databuf_rxd_i[0]} {picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/databuf_rxd_i[1]} {picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/databuf_rxd_i[2]} {picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/databuf_rxd_i[3]} {picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/databuf_rxd_i[4]} {picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/databuf_rxd_i[5]} {picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/databuf_rxd_i[6]} {picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/databuf_rxd_i[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe3]
set_property port_width 16 [get_debug_ports u_ila_0/probe3]
connect_debug_port u_ila_0/probe3 [get_nets [list {picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/tx_data[0]} {picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/tx_data[1]} {picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/tx_data[2]} {picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/tx_data[3]} {picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/tx_data[4]} {picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/tx_data[5]} {picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/tx_data[6]} {picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/tx_data[7]} {picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/tx_data[8]} {picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/tx_data[9]} {picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/tx_data[10]} {picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/tx_data[11]} {picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/tx_data[12]} {picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/tx_data[13]} {picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/tx_data[14]} {picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/tx_data[15]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe4]
set_property port_width 8 [get_debug_ports u_ila_0/probe4]
connect_debug_port u_ila_0/probe4 [get_nets [list {picoevr_system_arch_i/ESS_OpenEVR/U0/event_rxd[0]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_rxd[1]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_rxd[2]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_rxd[3]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_rxd[4]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_rxd[5]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_rxd[6]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_rxd[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe5]
set_property port_width 32 [get_debug_ports u_ila_0/probe5]
connect_debug_port u_ila_0/probe5 [get_nets [list {picoevr_system_arch_i/ESS_OpenEVR/U0/delay_comp_value[0]} {picoevr_system_arch_i/ESS_OpenEVR/U0/delay_comp_value[1]} {picoevr_system_arch_i/ESS_OpenEVR/U0/delay_comp_value[2]} {picoevr_system_arch_i/ESS_OpenEVR/U0/delay_comp_value[3]} {picoevr_system_arch_i/ESS_OpenEVR/U0/delay_comp_value[4]} {picoevr_system_arch_i/ESS_OpenEVR/U0/delay_comp_value[5]} {picoevr_system_arch_i/ESS_OpenEVR/U0/delay_comp_value[6]} {picoevr_system_arch_i/ESS_OpenEVR/U0/delay_comp_value[7]} {picoevr_system_arch_i/ESS_OpenEVR/U0/delay_comp_value[8]} {picoevr_system_arch_i/ESS_OpenEVR/U0/delay_comp_value[9]} {picoevr_system_arch_i/ESS_OpenEVR/U0/delay_comp_value[10]} {picoevr_system_arch_i/ESS_OpenEVR/U0/delay_comp_value[11]} {picoevr_system_arch_i/ESS_OpenEVR/U0/delay_comp_value[12]} {picoevr_system_arch_i/ESS_OpenEVR/U0/delay_comp_value[13]} {picoevr_system_arch_i/ESS_OpenEVR/U0/delay_comp_value[14]} {picoevr_system_arch_i/ESS_OpenEVR/U0/delay_comp_value[15]} {picoevr_system_arch_i/ESS_OpenEVR/U0/delay_comp_value[16]} {picoevr_system_arch_i/ESS_OpenEVR/U0/delay_comp_value[17]} {picoevr_system_arch_i/ESS_OpenEVR/U0/delay_comp_value[18]} {picoevr_system_arch_i/ESS_OpenEVR/U0/delay_comp_value[19]} {picoevr_system_arch_i/ESS_OpenEVR/U0/delay_comp_value[20]} {picoevr_system_arch_i/ESS_OpenEVR/U0/delay_comp_value[21]} {picoevr_system_arch_i/ESS_OpenEVR/U0/delay_comp_value[22]} {picoevr_system_arch_i/ESS_OpenEVR/U0/delay_comp_value[23]} {picoevr_system_arch_i/ESS_OpenEVR/U0/delay_comp_value[24]} {picoevr_system_arch_i/ESS_OpenEVR/U0/delay_comp_value[25]} {picoevr_system_arch_i/ESS_OpenEVR/U0/delay_comp_value[26]} {picoevr_system_arch_i/ESS_OpenEVR/U0/delay_comp_value[27]} {picoevr_system_arch_i/ESS_OpenEVR/U0/delay_comp_value[28]} {picoevr_system_arch_i/ESS_OpenEVR/U0/delay_comp_value[29]} {picoevr_system_arch_i/ESS_OpenEVR/U0/delay_comp_value[30]} {picoevr_system_arch_i/ESS_OpenEVR/U0/delay_comp_value[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe6]
set_property port_width 1 [get_debug_ports u_ila_0/probe6]
connect_debug_port u_ila_0/probe6 [get_nets [list picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_wr_en]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe7]
set_property port_width 1 [get_debug_ports u_ila_0/probe7]
connect_debug_port u_ila_0/probe7 [get_nets [list {picoevr_system_arch_i/ESS_OpenEVR/U0/gt0_resets[gbl_async]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe8]
set_property port_width 1 [get_debug_ports u_ila_0/probe8]
connect_debug_port u_ila_0/probe8 [get_nets [list {picoevr_system_arch_i/ESS_OpenEVR/U0/gt0_resets[rx_async]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe9]
set_property port_width 1 [get_debug_ports u_ila_0/probe9]
connect_debug_port u_ila_0/probe9 [get_nets [list {picoevr_system_arch_i/ESS_OpenEVR/U0/gt0_resets[tx_async]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe10]
set_property port_width 1 [get_debug_ports u_ila_0/probe10]
connect_debug_port u_ila_0/probe10 [get_nets [list {picoevr_system_arch_i/ESS_OpenEVR/U0/gt0_status[link_up]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe11]
set_property port_width 1 [get_debug_ports u_ila_0/probe11]
connect_debug_port u_ila_0/probe11 [get_nets [list {picoevr_system_arch_i/ESS_OpenEVR/U0/gt0_status[pll_locked]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe12]
set_property port_width 1 [get_debug_ports u_ila_0/probe12]
connect_debug_port u_ila_0/probe12 [get_nets [list picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/link_ok]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe13]
set_property port_width 1 [get_debug_ports u_ila_0/probe13]
connect_debug_port u_ila_0/probe13 [get_nets [list picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/rx_error]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe14]
set_property port_width 1 [get_debug_ports u_ila_0/probe14]
connect_debug_port u_ila_0/probe14 [get_nets [list picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/rxcdrreset]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe15]
set_property port_width 1 [get_debug_ports u_ila_0/probe15]
connect_debug_port u_ila_0/probe15 [get_nets [list picoevr_system_arch_i/ESS_OpenEVR/U0/delay_comp_update]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe16]
set_property port_width 1 [get_debug_ports u_ila_0/probe16]
connect_debug_port u_ila_0/probe16 [get_nets [list picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/delay_update_out]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe17]
set_property port_width 1 [get_debug_ports u_ila_0/probe17]
connect_debug_port u_ila_0/probe17 [get_nets [list picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/up_delay_dec]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe18]
set_property port_width 1 [get_debug_ports u_ila_0/probe18]
connect_debug_port u_ila_0/probe18 [get_nets [list picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/up_delay_inc]]
set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
connect_debug_port dbg_hub/clk [get_nets u_ila_0_debug_clk]
