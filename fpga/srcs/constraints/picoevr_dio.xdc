# =============================================================================
# @file   picoevr_dio.xdc
# @brief  Constraint file for the picoevr + fmc-dio-5ch-ttl mezzanine card
# -----------------------------------------------------------------------------
# @author Felipe Torres González <felipe.torresgonzalez@ess.eu>
# @author Ross Elliot <ross.elliot@ess.eu>
# @company European Spallation Source ERIC
# @date 20200811
#
# Platform:       picoZED 7030
# Carrier board:  Tallinn picoZED carrier board (aka FPGA-based IOC)
# =============================================================================

# =============================================================================
# DIO FMC CARD
# =============================================================================

# Differential clock from the FMC
set_property -dict {PACKAGE_PIN D5 IOSTANDARD LVDS DIFF_TERM 1} [get_ports dio_clk_n_in_0]
set_property -dict {PACKAGE_PIN C4 IOSTANDARD LVDS DIFF_TERM 1} [get_ports dio_clk_p_in_0]

# DIO LEDs
set_property -dict {PACKAGE_PIN U2 IOSTANDARD LVCMOS18} [get_ports dio_led_bot_out_0]
set_property -dict {PACKAGE_PIN U1 IOSTANDARD LVCMOS18} [get_ports dio_led_top_out_0]

# DIO Differential Outputs -- Input/Output names switched in Schematic
set_property -dict {PACKAGE_PIN A5 IOSTANDARD LVDS} [get_ports {dio_p_in_0[0]}]
set_property -dict {PACKAGE_PIN D7 IOSTANDARD LVDS} [get_ports {dio_p_in_0[1]}]
set_property -dict {PACKAGE_PIN K4 IOSTANDARD LVDS} [get_ports {dio_p_in_0[2]}]
set_property -dict {PACKAGE_PIN M2 IOSTANDARD LVDS} [get_ports {dio_p_in_0[3]}]
set_property -dict {PACKAGE_PIN L2 IOSTANDARD LVDS} [get_ports {dio_p_in_0[4]}]

set_property -dict {PACKAGE_PIN A4 IOSTANDARD LVDS} [get_ports {dio_n_in_0[0]}]
set_property -dict {PACKAGE_PIN D6 IOSTANDARD LVDS} [get_ports {dio_n_in_0[1]}]
set_property -dict {PACKAGE_PIN K3 IOSTANDARD LVDS} [get_ports {dio_n_in_0[2]}]
set_property -dict {PACKAGE_PIN M1 IOSTANDARD LVDS} [get_ports {dio_n_in_0[3]}]
set_property -dict {PACKAGE_PIN L1 IOSTANDARD LVDS} [get_ports {dio_n_in_0[4]}]

# DIO Differential Inputs -- Input/Output names switched in Schematic
set_property -dict {PACKAGE_PIN C8 IOSTANDARD LVDS DIFF_TERM 1} [get_ports {dio_p_out_0[0]}]
set_property -dict {PACKAGE_PIN E4 IOSTANDARD LVDS DIFF_TERM 1} [get_ports {dio_p_out_0[1]}]
set_property -dict {PACKAGE_PIN J8 IOSTANDARD LVDS DIFF_TERM 1} [get_ports {dio_p_out_0[2]}]
set_property -dict {PACKAGE_PIN P7 IOSTANDARD LVDS DIFF_TERM 1} [get_ports {dio_p_out_0[3]}]
set_property -dict {PACKAGE_PIN T2 IOSTANDARD LVDS DIFF_TERM 1} [get_ports {dio_p_out_0[4]}]

set_property -dict {PACKAGE_PIN B8 IOSTANDARD LVDS DIFF_TERM 1} [get_ports {dio_n_out_0[0]}]
set_property -dict {PACKAGE_PIN E3 IOSTANDARD LVDS DIFF_TERM 1} [get_ports {dio_n_out_0[1]}]
set_property -dict {PACKAGE_PIN K8 IOSTANDARD LVDS DIFF_TERM 1} [get_ports {dio_n_out_0[2]}]
set_property -dict {PACKAGE_PIN R7 IOSTANDARD LVDS DIFF_TERM 1} [get_ports {dio_n_out_0[3]}]
set_property -dict {PACKAGE_PIN T1 IOSTANDARD LVDS DIFF_TERM 1} [get_ports {dio_n_out_0[4]}]

# DIO OneWire and I2C
set_property -dict {PACKAGE_PIN D8 IOSTANDARD LVCMOS18} [get_ports dio_onewire_b_0]

# DIO Output Enables
set_property -dict {PACKAGE_PIN G8 IOSTANDARD LVCMOS18} [get_ports {dio_oe_n_out_0[0]}]
set_property -dict {PACKAGE_PIN G1 IOSTANDARD LVCMOS18} [get_ports {dio_oe_n_out_0[1]}]
set_property -dict {PACKAGE_PIN P5 IOSTANDARD LVCMOS18} [get_ports {dio_oe_n_out_0[2]}]
set_property -dict {PACKAGE_PIN L6 IOSTANDARD LVCMOS18} [get_ports {dio_oe_n_out_0[3]}]
set_property -dict {PACKAGE_PIN N4 IOSTANDARD LVCMOS18} [get_ports {dio_oe_n_out_0[4]}]

# DIO Termination Enables
set_property -dict {PACKAGE_PIN G7 IOSTANDARD LVCMOS18} [get_ports {dio_term_en_out_0[0]}]
set_property -dict {PACKAGE_PIN P2 IOSTANDARD LVCMOS18} [get_ports {dio_term_en_out_0[1]}]
set_property -dict {PACKAGE_PIN N3 IOSTANDARD LVCMOS18} [get_ports {dio_term_en_out_0[2]}]
set_property -dict {PACKAGE_PIN N1 IOSTANDARD LVCMOS18} [get_ports {dio_term_en_out_0[3]}]
set_property -dict {PACKAGE_PIN P1 IOSTANDARD LVCMOS18} [get_ports {dio_term_en_out_0[4]}]
