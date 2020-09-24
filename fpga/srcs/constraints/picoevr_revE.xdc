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
set_property -dict {PACKAGE_PIN Y18 IOSTANDARD LVCMOS33} [get_ports i_ZYNQ_MRCC1]; # IO_L13P_T2_MRCC_13
# From Si5332A-D-GM1 Out 0
set_property -dict {PACKAGE_PIN Y14 IOSTANDARD LVCMOS33} [get_ports i_ZYNQ_MRCC2]; # IO_L12P_T1_MRCC_13

# From Si5332A-D-GM1 Out 3 - COM Transceiver Reference Clock - Not Used
#set_property PACKAGE_PIN V5 [get_ports i_ZYNQ_CLKREF1_N]
# From Si5332A-D-GM1 Out 4
set_property PACKAGE_PIN V9 [get_ports i_ZYNQ_CLKREF0_N]

# From the FMC - IOSTANDARD shall match the chosen Vadj
#set_property PACKAGE_PIN C4 [get ports i_CLK0_M2C_N]; # IO_L12N_T1_MRCC_34

# =============================================================================
# OpenEVR (J500)
# =============================================================================
set_property -dict {PACKAGE_PIN H5 IOSTANDARD LVCMOS18} [get_ports o_EVR_LINK_LED]
set_property -dict {PACKAGE_PIN H6 IOSTANDARD LVCMOS18} [get_ports o_EVR_EVNT_LED]
set_property -dict {PACKAGE_PIN AB3} [get_ports o_EVR_TX_N]
set_property -dict {PACKAGE_PIN AB7} [get_ports i_EVR_RX_N]
# Used for SFP detection - Low when plugged
set_property -dict {PACKAGE_PIN R17 IOSTANDARD LVCMOS33} [get_ports i_EVR_SFP_MOD_0]
# Used for I2C SCL - External pull-up
#set_property -dict {PACKAGE_PIN V14 IOSTANDARD LVCMOS33} [get_ports b_EVR_SFP_MOD_1]
# Used for I2C SDA - External pull-up
# set_property -dict {PACKAGE_PIN V13 IOSTANDARD LVCMOS33} [get_ports b_EVR_SFP_MOD_2]
set_property -dict {PACKAGE_PIN Y13 IOSTANDARD LVCMOS33} [get_ports o_EVR_TX_DISABLE]
set_property -dict {PACKAGE_PIN Y12 IOSTANDARD LVCMOS33} [get_ports i_EVR_TX_FAULT]
# Rx rate optimization: Low -> 4.25 Gbs - High -> 8.5 Gbs (internally pulled-down in the SFP)
# set_property -dict {PACKAGE_PIN T17 IOSTANDARD LVCMOS33} [get_ports o_EVR_RX_RATE]
# High -> Received power is below the sensitivity of the receiver
set_property -dict {PACKAGE_PIN V16 IOSTANDARD LVCMOS33} [get_ports i_EVR_RX_LOS]

# =============================================================================
# COM SFP (J501)
# =============================================================================
set_property -dict {PACKAGE_PIN Y4} [get_ports o_COM_TX_N]; # MGTXTXN1_112
set_property -dict {PACKAGE_PIN Y8} [get_ports o_COM_RX_N]; # MGTXRXN1_112
set_property -dict {PACKAGE_PIN AA11 IOSTANDARD LVCMOS33} [get_ports i_COM_TX_FAULT]; # IO_L7P_T1_13
set_property -dict {PACKAGE_PIN AB11 IOSTANDARD LVCMOS33} [get_ports o_COM_TX_DISABLE]; # IO_L7N_T1_13
set_property -dict {PACKAGE_PIN W12 IOSTANDARD LVCMOS33} [get_ports i_COM_MOD_DEF_0]; # IO_L3P_T0_DQS_13
set_property -dict {PACKAGE_PIN W11 IOSTANDARD LVCMOS33} [get_ports b_COM_MOD_DEF_1]; # IO_L4N_T0_13
set_property -dict {PACKAGE_PIN V11 IOSTANDARD LVCMOS33} [get_ports b_COM_MOD_DEF_2]; # IO_L4P_T0_13
set_property -dict {PACKAGE_PIN W13 IOSTANDARD LVCMOS33} [get_ports o_COM_RX_RATE]; # IO_L3N_T0_DQS_13
set_property -dict {PACKAGE_PIN V15 IOSTANDARD LVCMOS33} [get_ports o_COM_RX_LOS]; # IO_L2P_T0_13

# =============================================================================
# MRF Universal Module Socket
# =============================================================================
set_property -dict {PACKAGE_PIN G3   IOSTANDARD LVCMOS18} [get_ports o_MRF_UNIVMOD_OUT0]; # IO_L22P_T3_AD7P_35
set_property -dict {PACKAGE_PIN G2   IOSTANDARD LVCMOS18} [get_ports o_MRF_UNIVMOD_OUT1]; # IO_L22N_T3_AD7N_35
set_property -dict {PACKAGE_PIN G4   IOSTANDARD LVCMOS18} [get_ports i_MRF_UNIVMOD_IN0];  # IO_L20P_T3_AD6P_35
set_property -dict {PACKAGE_PIN F4   IOSTANDARD LVCMOS18} [get_ports i_MRF_UNIVMOD_IN1];  # IO_L20N_T3_AD6N_35

# Modules with delay adjustment not supported yet
#set_property -dict {PACKAGE_PIN AA14 IOSTANDARD LVCMOS33} [get_ports   MRF_UNIVMOD_DIS];  # IO_L11P_T1_SRCC_13
#set_property -dict {PACKAGE_PIN AA15 IOSTANDARD LVCMOS33} [get_ports   MRF_UNIVMOD_LCLK]; # IO_L11N_T1_SRCC_13
#set_property -dict {PACKAGE_PIN U19  IOSTANDARD LVCMOS33} [get_ports   MRF_UNIVMOD_SCLK]; # IO_L20P_T3_13
#set_property -dict {PACKAGE_PIN V19  IOSTANDARD LVCMOS33} [get_ports   MRF_UNIVMOD_DIN];  # IO_L20N_T3_13

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

# =============================================================================
# I2C
# =============================================================================
#set_property -dict {PACKAGE_PIN V18 IOSTANDARD LVCMOS33} [get_ports o_SVC_I2C_REQ]
#set_property -dict {PACKAGE_PIN W18 IOSTANDARD LVCMOS33} [get_ports i_SVC_I2C_GRANT]
set_property -dict {PACKAGE_PIN T16 IOSTANDARD LVCMOS33} [get_ports o_ZYNQ_I2C_RST]

# =============================================================================
# FMC
# =============================================================================
set_property -dict {PACKAGE_PIN W16 IOSTANDARD LVCMOS33} [get_ports i_FMC_PRSNT_N]; # IO_L23N_T3_13
