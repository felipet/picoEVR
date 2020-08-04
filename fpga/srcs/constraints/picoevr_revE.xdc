# =============================================================================
# @file   picoevr.xdc
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
set_property -dict {PACKAGE_PIN Y18 IOSTANDARD LVCMOS33} [get_ports i_ZYNQ_MRCC1];
# From Si5332A-D-GM1 Out 0
set_property -dict {PACKAGE_PIN Y14 IOSTANDARD LVCMOS33} [get_ports i_ZYNQ_MRCC2];

# From Si5332A-D-GM1 Out 3
# set_property PACKAGE_PIN V5 [get_ports i_ZYNQ_CLKREF1_N]; # MGTREFCLK1N_112
# From Si5332A-D-GM1 Out 4
set_property PACKAGE_PIN V9 [get_ports i_ZYNQ_CLKREF0_N]; # MGTREFCLK0N_112

# =============================================================================
# OpenEVR
# =============================================================================
set_property -dict {PACKAGE_PIN H5 IOSTANDARD LVCMOS18} [get_ports o_EVR_LINK_LED];
set_property -dict {PACKAGE_PIN H6 IOSTANDARD LVCMOS18} [get_ports o_EVR_EVNT_LED];
set_property -dict {PACKAGE_PIN AB3} [get_ports o_EVR_TX_N];
set_property -dict {PACKAGE_PIN AB7} [get_ports i_EVR_RX_N];


# =============================================================================
# MRF Universal Module Socket
# =============================================================================
set_property -dict {PACKAGE_PIN G3   IOSTANDARD LVCMOS18} [get_ports o_MRF_UNIVMOD_OUT0]; # IO_L22P_T3_AD7P_35
set_property -dict {PACKAGE_PIN G2   IOSTANDARD LVCMOS18} [get_ports o_MRF_UNIVMOD_OUT1]; # IO_L22N_T3_AD7P_35
set_property -dict {PACKAGE_PIN G4   IOSTANDARD LVCMOS18} [get_ports i_MRF_UNIVMOD_IN0];  # IO_L20P_T3_AD6P_35
set_property -dict {PACKAGE_PIN F4   IOSTANDARD LVCMOS18} [get_ports i_MRF_UNIVMOD_IN1];  # IO_L20N_T3_AD6P_35

set_property -dict {PACKAGE_PIN AA14 IOSTANDARD LVCMOS33} [get_ports   MRF_UNIVMOD_DIS];  # IO_L11P_T1_SRCC_13
set_property -dict {PACKAGE_PIN AA15 IOSTANDARD LVCMOS33} [get_ports   MRF_UNIVMOD_LCLK]; # IO_L11N_T1_SRCC_13
set_property -dict {PACKAGE_PIN U19  IOSTANDARD LVCMOS33} [get_ports   MRF_UNIVMOD_SCLK]; # IO_L20P_T3_13
set_property -dict {PACKAGE_PIN V19  IOSTANDARD LVCMOS33} [get_ports   MRF_UNIVMOD_DIN];  # IO_L20N_T3_13

# =============================================================================
# LEMO Connectors
# =============================================================================
set_property -dict {PACKAGE_PIN N8   IOSTANDARD LVCMOS18} [get_ports {b_LEMO_IO[0]}];  # IO_L5P_T0_34
set_property -dict {PACKAGE_PIN P8   IOSTANDARD LVCMOS18} [get_ports {o_LEMO_DIR[0]}]; # IO_L5N_T0_34
set_property -dict {PACKAGE_PIN AB18 IOSTANDARD LVCMOS33} [get_ports {b_LEMO_IO[1]}];  # IO_L16P_T2_13
set_property -dict {PACKAGE_PIN AB19 IOSTANDARD LVCMOS33} [get_ports {o_LEMO_DIR[1]}]; # IO_L16N_T2_13
set_property -dict {PACKAGE_PIN M8   IOSTANDARD LVCMOS18} [get_ports {b_LEMO_IO[2]}];  # IO_L6P_T0_34
set_property -dict {PACKAGE_PIN M7   IOSTANDARD LVCMOS18} [get_ports {o_LEMO_DIR[2]}]; # IO_L6N_T0_VREF_34
set_property -dict {PACKAGE_PIN AB21 IOSTANDARD LVCMOS33} [get_ports {b_LEMO_IO[3]}];  # IO_L15P_T2_DQS_13
set_property -dict {PACKAGE_PIN AB22 IOSTANDARD LVCMOS33} [get_ports {o_LEMO_DIR[3]}]; # IO_L15P_T2_DQS_13

# =============================================================================
# DIO FMC CARD
# =============================================================================

# Differential clock from the FMC
set_property -dict {PACKAGE_PIN D5 IOSTANDARD LVDS DIFF_TERM 1} [get_ports dio_clk_n_in_0];
set_property -dict {PACKAGE_PIN C4 IOSTANDARD LVDS DIFF_TERM 1} [get_ports dio_clk_p_in_0];

# DIO LEDs
set_property -dict {PACKAGE_PIN U2 IOSTANDARD LVCMOS18} [get_ports dio_led_bot_out_0];
set_property -dict {PACKAGE_PIN U1 IOSTANDARD LVCMOS18} [get_ports dio_led_top_out_0];

# DIO Differential Outputs -- Input/Output names switched in Schematic
set_property -dict {PACKAGE_PIN A5 IOSTANDARD LVDS} [get_ports {dio_p_in_0[0]}];
set_property -dict {PACKAGE_PIN D7 IOSTANDARD LVDS} [get_ports {dio_p_in_0[1]}];
set_property -dict {PACKAGE_PIN K4 IOSTANDARD LVDS} [get_ports {dio_p_in_0[2]}];
set_property -dict {PACKAGE_PIN M2 IOSTANDARD LVDS} [get_ports {dio_p_in_0[3]}];
set_property -dict {PACKAGE_PIN L2 IOSTANDARD LVDS} [get_ports {dio_p_in_0[4]}];

set_property -dict {PACKAGE_PIN A4 IOSTANDARD LVDS} [get_ports {dio_n_in_0[0]}];
set_property -dict {PACKAGE_PIN D6 IOSTANDARD LVDS} [get_ports {dio_n_in_0[1]}];
set_property -dict {PACKAGE_PIN K3 IOSTANDARD LVDS} [get_ports {dio_n_in_0[2]}];
set_property -dict {PACKAGE_PIN M1 IOSTANDARD LVDS} [get_ports {dio_n_in_0[3]}];
set_property -dict {PACKAGE_PIN L1 IOSTANDARD LVDS} [get_ports {dio_n_in_0[4]}];

# DIO Differential Inputs -- Input/Output names switched in Schematic
set_property -dict {PACKAGE_PIN C8 IOSTANDARD LVDS DIFF_TERM 1} [get_ports {dio_p_out_0[0]}];
set_property -dict {PACKAGE_PIN E4 IOSTANDARD LVDS DIFF_TERM 1} [get_ports {dio_p_out_0[1]}];
set_property -dict {PACKAGE_PIN J8 IOSTANDARD LVDS DIFF_TERM 1} [get_ports {dio_p_out_0[2]}];
set_property -dict {PACKAGE_PIN P7 IOSTANDARD LVDS DIFF_TERM 1} [get_ports {dio_p_out_0[3]}];
set_property -dict {PACKAGE_PIN T2 IOSTANDARD LVDS DIFF_TERM 1} [get_ports {dio_p_out_0[4]}];

set_property -dict {PACKAGE_PIN B8 IOSTANDARD LVDS DIFF_TERM 1} [get_ports {dio_n_out_0[0]}];
set_property -dict {PACKAGE_PIN E3 IOSTANDARD LVDS DIFF_TERM 1} [get_ports {dio_n_out_0[1]}];
set_property -dict {PACKAGE_PIN K8 IOSTANDARD LVDS DIFF_TERM 1} [get_ports {dio_n_out_0[2]}];
set_property -dict {PACKAGE_PIN R7 IOSTANDARD LVDS DIFF_TERM 1} [get_ports {dio_n_out_0[3]}];
set_property -dict {PACKAGE_PIN T1 IOSTANDARD LVDS DIFF_TERM 1} [get_ports {dio_n_out_0[4]}];

# DIO OneWire and I2C
set_property -dict {PACKAGE_PIN D8 IOSTANDARD LVCMOS18} [get_ports dio_onewire_b_0];

# DIO Output Enables
set_property -dict {PACKAGE_PIN G8 IOSTANDARD LVCMOS18} [get_ports {dio_oe_n_out_0[0]}];
set_property -dict {PACKAGE_PIN G1 IOSTANDARD LVCMOS18} [get_ports {dio_oe_n_out_0[1]}];
set_property -dict {PACKAGE_PIN P5 IOSTANDARD LVCMOS18} [get_ports {dio_oe_n_out_0[2]}];
set_property -dict {PACKAGE_PIN L6 IOSTANDARD LVCMOS18} [get_ports {dio_oe_n_out_0[3]}];
set_property -dict {PACKAGE_PIN N4 IOSTANDARD LVCMOS18} [get_ports {dio_oe_n_out_0[4]}];

# DIO Termination Enables
set_property -dict {PACKAGE_PIN G7 IOSTANDARD LVCMOS18} [get_ports {dio_term_en_out_0[0]}];
set_property -dict {PACKAGE_PIN P2 IOSTANDARD LVCMOS18} [get_ports {dio_term_en_out_0[1]}];
set_property -dict {PACKAGE_PIN N3 IOSTANDARD LVCMOS18} [get_ports {dio_term_en_out_0[2]}];
set_property -dict {PACKAGE_PIN N1 IOSTANDARD LVCMOS18} [get_ports {dio_term_en_out_0[3]}];
set_property -dict {PACKAGE_PIN P1 IOSTANDARD LVCMOS18} [get_ports {dio_term_en_out_0[4]}];
