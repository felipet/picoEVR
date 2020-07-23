# =============================================================================
# @file   picoevr.xdc
# @brief  Top constraint file for the PicoEVR firmware
# -----------------------------------------------------------------------------
# @author Felipe Torres González <felipe.torresgonzalez@ess.eu>
# @author Ross Elliot <ross.elliot@ess.eu>
# @company European Spallation Source ERIC
# @date 20200117
#
# Platform:       picoZED 7030
# Carrier board:  Tallinn picoZED carrier board (aka FPGA-based IOC) rev B
# Based on the AVNET xdc file for the picozed 7z030 RevC v2
# =============================================================================


# =============================================================================
# Clocks
# =============================================================================
# From Si5346 Out0 - 88.0525 MHz - MGT0 REF CLOCK
set_property PACKAGE_PIN V9 [get_ports i_ZYNQ_CLKREF0_N]
# From Si5346 Out1 - MHz (NOT used) - MGT1 REF CLOCK
set_property PACKAGE_PIN V5  [get_ports i_ZYNQ_CLKREF1_N   ];   # "V5.MGTREFCLKC1_N"
# From Si5346 Out2 - 100 MHz - MAIN PL CLOCK
set_property PACKAGE_PIN Y19 [get_ports i_ZYNQ_MRCC_LVDS_N]
#set_property PACKAGE_PIN AB5  [get_ports {i_DP0_M2C_N        }];  # "AB5.MGTTX2_N"


# =============================================================================
# Si5346
# =============================================================================

# Si5346 Loss of signal alarm on the XA/XB pins
set_property -dict {PACKAGE_PIN H3 IOSTANDARD LVCMOS18 } [get_ports i_SI5346_LOL_XAXB ]; # "H3.JX1_LVDS_0_N"
# Si5346 Output Enable 1
set_property -dict {PACKAGE_PIN E5 IOSTANDARD LVCMOS18 } [get_ports o_SI5346_OE1      ]; # "E5.JX1_LVDS_1_N"
# Si5346 Output Enable 0
set_property -dict {PACKAGE_PIN F5 IOSTANDARD LVCMOS18 } [get_ports o_SI5346_OE0      ]; # "F5.JX1_LVDS_1_P"
# Si5346 Loss of lock A - H: Locked | L: Out of lock
set_property -dict {PACKAGE_PIN G3 IOSTANDARD LVCMOS18 } [get_ports i_SI5346_LOL_A    ]; # "G3.JX1_LVDS_2_P"
# Si5346 Loss of lock B - H: Locked | L: Out of lock
set_property -dict {PACKAGE_PIN G2 IOSTANDARD LVCMOS18 } [get_ports i_SI5346_LOL_B    ]; # "G2.JX1_LVDS_2_N"
# Si5346 Device reset (active low)
set_property -dict {PACKAGE_PIN G4 IOSTANDARD LVCMOS18} [get_ports o_SI5346_RST_rn]
# Si5346 Interrupt pin (asserted low)
set_property -dict {PACKAGE_PIN F4 IOSTANDARD LVCMOS18 } [get_ports i_SI5346_INT_n    ]; # "F4.JX1_LVDS_4_N"

# =============================================================================
# SY87739 - Deprecated
# =============================================================================
# Data In (Microwire interface)
set_property -dict {PACKAGE_PIN AB18 IOSTANDARD LVCMOS33} [get_ports o_SY87730_PROGDI]
# Chip select (Microwire interface)
set_property -dict {PACKAGE_PIN AB19 IOSTANDARD LVCMOS33} [get_ports {o_SY87730_PROGCS[0]}]
# Locked signal
set_property -dict {PACKAGE_PIN AB21 IOSTANDARD LVCMOS33} [get_ports i_SY87730_LOCKED]
# Serial clock (Microwire interface)
set_property -dict {PACKAGE_PIN AB22 IOSTANDARD LVCMOS33} [get_ports o_SY87730_PROGSK]



# =============================================================================
# FMC
# =============================================================================

#set_property PACKAGE_PIN C5   [get_ports {i_CLK1_M2C_N   }];  # "C5.JX1_LVDS_10_N"
#set_property PACKAGE_PIN L4   [get_ports {i_CLK0_M2C_N   }];  # "L4.JX2_LVDS_11_N"

#set_property PACKAGE_PIN AB9  [get_ports {o_DP0_C2M_N    }];  # "AB9.MGTRX2_N"

# Low when a mezzanine board is connected?
#set_property PACKAGE_PIN Y14  [get_ports {i_FMC_PRSNT_N  }];  # "Y14.BANK13_LVDS_1_P"


# =============================================================================
# I2C
# =============================================================================
set_property -dict {PACKAGE_PIN T16  IOSTANDARD LVCMOS33 } [get_ports o_ZYNQ_I2C_BUS_MASTER_RST_rn]; # "T16.BANK13_SE_0"

set_property -dict {PACKAGE_PIN AA20 IOSTANDARD LVCMOS33 } [get_ports b_FMC_SCL ];                   # "AA20.BANK13_LVDS_6_N"
set_property -dict {PACKAGE_PIN AA19 IOSTANDARD LVCMOS33 } [get_ports b_FMC_SDA ];                   # "AA19.BANK13_LVDS_6_P"

#
#set_property -dict {PACKAGE_PIN V18  IOSTANDARD LVCMOS33 } [get_ports SVC_I2C_MASTER_REQ   ];        # "V18.BANK13_LVDS_3_P"
#set_property -dict {PACKAGE_PIN W18  IOSTANDARD LVCMOS33 } [get_ports SVC_I2C_MASTER_GRANT ];        # "W18.BANK13_LVDS_3_N"

# I2C Zynq-SVC (managment)
set_property -dict {PACKAGE_PIN C13 IOSTANDARD LVCMOS18 } [get_ports b_ZYNQ_I2C_SDA        ];       # PS_MIO51
set_property -dict {PACKAGE_PIN B13 IOSTANDARD LVCMOS18 } [get_ports b_ZYNQ_I2C_SCL        ];       # PS_MIO50

#set_property -dict {PACKAGE_PIN AA16 [get_ports {i_ZYNQ_BUS_MASTER_I2C_INT_n    }];  # "AA16.BANK13_LVDS_8_P"
#set_property -dict {PACKAGE_PIN D15 IOSTANDARD LVCMOS18 } [get_ports {o_ZYNQ_I2C_BUS_SWITCH_RESET_rn }]; # PS_MIO41



# =============================================================================
# OpenEVR
# =============================================================================

# EVR enable
set_property -dict {PACKAGE_PIN W16 IOSTANDARD LVCMOS33} [get_ports o_EVR_ENABLE]
# Rx signal from SFP
set_property -dict {PACKAGE_PIN AB7} [get_ports i_EVR_RX_N]
# EVR Link LED
set_property -dict {PACKAGE_PIN H5 IOSTANDARD LVCMOS18} [get_ports o_EVR_LINK_LED]
set_property -dict {PACKAGE_PIN H6 IOSTANDARD LVCMOS18} [get_ports o_EVR_EVNT_LED]

#set_property -dict{PACKAGE_PIN Y13  IOSTANDARD  } [get_ports EVR_RX_RATE     ];  # "Y13.BANK13_LVDS_10_N"
#set_property -dict{PACKAGE_PIN Y12  IOSTANDARD  } [get_ports EVR_RX_LOS      ];  # "Y12.BANK13_LVDS_10_P"
#set_property -dict{PACKAGE_PIN V13  IOSTANDARD  } [get_ports EVR_MOD_DEF_0   ];  # "V13.BANK13_LVDS_12_P"
set_property -dict {PACKAGE_PIN AB3} [get_ports o_EVR_TX_N]
#set_property -dict{PACKAGE_PIN AB11 IOSTANDARD  } [get_ports EVR_TX_DISABLE  ];  # "AB11.BANK13_LVDS_9_N"
#set_property -dict{PACKAGE_PIN AA11 IOSTANDARD  } [get_ports EVR_TX_FAULT    ];  # "AA11.BANK13_LVDS_9_P"
#set_property -dict{PACKAGE_PIN V11  IOSTANDARD  } [get_ports EVR_MOD_DEF_1   ];  # "V11.BANK13_LVDS_11_P"
#set_property -dict{PACKAGE_PIN W11  IOSTANDARD  } [get_ports EVR_MOD_DEF_2   ];  # "W11.BANK13_LVDS_11_N"

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

# =============================================================================
# Secondary SFP port
# =============================================================================

# COM RX signal from SFP
#set_property PACKAGE_PIN Y8   [get_ports {i_COM_RX_N      }];  # "Y8.MGTRX1_N"
#set_property PACKAGE_PIN V14  [get_ports {COM_RX_LOS      }];  # "V14.BANK13_LVDS_12_N"
#set_property PACKAGE_PIN T17  [get_ports {COM_MOD_DEF_0   }];  # "T17.BANK13_LVDS_14_N"
#set_property PACKAGE_PIN R17  [get_ports {COM_RX_RATE     }];  # "R17.BANK13_LVDS_14_P"
#set_property PACKAGE_PIN Y4   [get_ports {COM_TX_N        }];  # "Y4.MGTTX1_N"
#set_property PACKAGE_PIN W13  [get_ports {COM_TX_DISABLE  }];  # "W13.BANK13_LVDS_13_N"
#set_property PACKAGE_PIN W12  [get_ports {COM_TX_FAULT    }];  # "W12.BANK13_LVDS_13_P"
#set_property PACKAGE_PIN W15  [get_ports {COM_MOD_DEF_2   }];  # "W15.BANK13_LVDS_15_N"
#set_property PACKAGE_PIN V15  [get_ports {COM_MOD_DEF_1   }];  # "V15.BANK13_LVDS_15_P"


# =============================================================================
# General I/O
# =============================================================================

set_property -dict {PACKAGE_PIN B14 IOSTANDARD LVCMOS18} [get_ports o_FPGA_RUN_LED  ];  # PS_MIO45

# =============================================================================
# UART
# =============================================================================
set_property -dict {PACKAGE_PIN B13 IOSTANDARD  LVCMOS18} [get_ports o_ZYNQ_UART_TX          ]; # PS_MIO47
set_property -dict {PACKAGE_PIN D12 IOSTANDARD  LVCMOS18} [get_ports o_SVC_UART_TX           ]; # PS_MIO48
set_property -dict {PAKCAGE_PIN C9  IOSTANDARD  LVCMOS18} [get_ports i_SVC_UART_RX           ]; # PS_MIO49
set_property -dict {PACKAGE_PIN D11 IOSTANDARD  LVCMOS18} [get_ports i_ZYNQ_UART_RX          ]; # PS_MIO46
set_property -dict {PACKAGE_PIN AA17 IOSTANDARD LVCMOS33} [get_ports o_ZYNQ_UART_SWITCH_FPGA ]; # "AA17.BANK13_LVDS_8_N"


connect_debug_port dbg_hub/clk [get_nets u_ila_0_FCLK_CLK0]



create_debug_core u_ila_0 ila
set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_0]
set_property ALL_PROBE_SAME_MU_CNT 4 [get_debug_cores u_ila_0]
set_property C_ADV_TRIGGER true [get_debug_cores u_ila_0]
set_property C_DATA_DEPTH 16384 [get_debug_cores u_ila_0]
set_property C_EN_STRG_QUAL true [get_debug_cores u_ila_0]
set_property C_INPUT_PIPE_STAGES 0 [get_debug_cores u_ila_0]
set_property C_TRIGIN_EN false [get_debug_cores u_ila_0]
set_property C_TRIGOUT_EN false [get_debug_cores u_ila_0]
set_property port_width 1 [get_debug_ports u_ila_0/clk]
connect_debug_port u_ila_0/clk [get_nets [list picoevr_system_arch_i/ESS_OpenEVR/U0/debug_clk]]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe0]
set_property port_width 2 [get_debug_ports u_ila_0/probe0]
connect_debug_port u_ila_0/probe0 [get_nets [list {picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/rx_disperr[0]} {picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/rx_disperr[1]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe1]
set_property port_width 8 [get_debug_ports u_ila_0/probe1]
connect_debug_port u_ila_0/probe1 [get_nets [list {picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/databuf_rxd_i[0]} {picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/databuf_rxd_i[1]} {picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/databuf_rxd_i[2]} {picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/databuf_rxd_i[3]} {picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/databuf_rxd_i[4]} {picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/databuf_rxd_i[5]} {picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/databuf_rxd_i[6]} {picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/databuf_rxd_i[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe2]
set_property port_width 2 [get_debug_ports u_ila_0/probe2]
connect_debug_port u_ila_0/probe2 [get_nets [list {picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/tx_charisk[0]} {picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/tx_charisk[1]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe3]
set_property port_width 16 [get_debug_ports u_ila_0/probe3]
connect_debug_port u_ila_0/probe3 [get_nets [list {picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/rx_data[0]} {picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/rx_data[1]} {picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/rx_data[2]} {picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/rx_data[3]} {picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/rx_data[4]} {picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/rx_data[5]} {picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/rx_data[6]} {picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/rx_data[7]} {picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/rx_data[8]} {picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/rx_data[9]} {picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/rx_data[10]} {picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/rx_data[11]} {picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/rx_data[12]} {picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/rx_data[13]} {picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/rx_data[14]} {picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/rx_data[15]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe4]
set_property port_width 2 [get_debug_ports u_ila_0/probe4]
connect_debug_port u_ila_0/probe4 [get_nets [list {picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/rx_notintable[0]} {picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/rx_notintable[1]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe5]
set_property port_width 16 [get_debug_ports u_ila_0/probe5]
connect_debug_port u_ila_0/probe5 [get_nets [list {picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/tx_data[0]} {picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/tx_data[1]} {picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/tx_data[2]} {picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/tx_data[3]} {picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/tx_data[4]} {picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/tx_data[5]} {picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/tx_data[6]} {picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/tx_data[7]} {picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/tx_data[8]} {picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/tx_data[9]} {picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/tx_data[10]} {picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/tx_data[11]} {picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/tx_data[12]} {picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/tx_data[13]} {picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/tx_data[14]} {picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/tx_data[15]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe6]
set_property port_width 32 [get_debug_ports u_ila_0/probe6]
connect_debug_port u_ila_0/probe6 [get_nets [list {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/seconds_latch[0]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/seconds_latch[1]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/seconds_latch[2]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/seconds_latch[3]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/seconds_latch[4]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/seconds_latch[5]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/seconds_latch[6]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/seconds_latch[7]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/seconds_latch[8]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/seconds_latch[9]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/seconds_latch[10]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/seconds_latch[11]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/seconds_latch[12]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/seconds_latch[13]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/seconds_latch[14]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/seconds_latch[15]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/seconds_latch[16]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/seconds_latch[17]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/seconds_latch[18]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/seconds_latch[19]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/seconds_latch[20]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/seconds_latch[21]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/seconds_latch[22]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/seconds_latch[23]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/seconds_latch[24]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/seconds_latch[25]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/seconds_latch[26]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/seconds_latch[27]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/seconds_latch[28]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/seconds_latch[29]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/seconds_latch[30]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/seconds_latch[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe7]
set_property port_width 32 [get_debug_ports u_ila_0/probe7]
connect_debug_port u_ila_0/probe7 [get_nets [list {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/seconds_shift_reg[0]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/seconds_shift_reg[1]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/seconds_shift_reg[2]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/seconds_shift_reg[3]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/seconds_shift_reg[4]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/seconds_shift_reg[5]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/seconds_shift_reg[6]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/seconds_shift_reg[7]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/seconds_shift_reg[8]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/seconds_shift_reg[9]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/seconds_shift_reg[10]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/seconds_shift_reg[11]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/seconds_shift_reg[12]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/seconds_shift_reg[13]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/seconds_shift_reg[14]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/seconds_shift_reg[15]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/seconds_shift_reg[16]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/seconds_shift_reg[17]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/seconds_shift_reg[18]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/seconds_shift_reg[19]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/seconds_shift_reg[20]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/seconds_shift_reg[21]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/seconds_shift_reg[22]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/seconds_shift_reg[23]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/seconds_shift_reg[24]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/seconds_shift_reg[25]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/seconds_shift_reg[26]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/seconds_shift_reg[27]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/seconds_shift_reg[28]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/seconds_shift_reg[29]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/seconds_shift_reg[30]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/seconds_shift_reg[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe8]
set_property port_width 32 [get_debug_ports u_ila_0/probe8]
connect_debug_port u_ila_0/probe8 [get_nets [list {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ts_latch[0]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ts_latch[1]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ts_latch[2]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ts_latch[3]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ts_latch[4]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ts_latch[5]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ts_latch[6]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ts_latch[7]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ts_latch[8]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ts_latch[9]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ts_latch[10]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ts_latch[11]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ts_latch[12]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ts_latch[13]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ts_latch[14]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ts_latch[15]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ts_latch[16]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ts_latch[17]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ts_latch[18]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ts_latch[19]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ts_latch[20]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ts_latch[21]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ts_latch[22]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ts_latch[23]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ts_latch[24]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ts_latch[25]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ts_latch[26]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ts_latch[27]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ts_latch[28]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ts_latch[29]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ts_latch[30]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ts_latch[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe9]
set_property port_width 2 [get_debug_ports u_ila_0/probe9]
connect_debug_port u_ila_0/probe9 [get_nets [list {picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/rx_charisk[0]} {picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/rx_charisk[1]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe10]
set_property port_width 8 [get_debug_ports u_ila_0/probe10]
connect_debug_port u_ila_0/probe10 [get_nets [list {picoevr_system_arch_i/ESS_OpenEVR/U0/event_rxd[0]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_rxd[1]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_rxd[2]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_rxd[3]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_rxd[4]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_rxd[5]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_rxd[6]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_rxd[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe11]
set_property port_width 64 [get_debug_ports u_ila_0/probe11]
connect_debug_port u_ila_0/probe11 [get_nets [list {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_data[0]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_data[1]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_data[2]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_data[3]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_data[4]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_data[5]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_data[6]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_data[7]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_data[8]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_data[9]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_data[10]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_data[11]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_data[12]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_data[13]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_data[14]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_data[15]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_data[16]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_data[17]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_data[18]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_data[19]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_data[20]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_data[21]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_data[22]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_data[23]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_data[24]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_data[25]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_data[26]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_data[27]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_data[28]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_data[29]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_data[30]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_data[31]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_data[32]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_data[33]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_data[34]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_data[35]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_data[36]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_data[37]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_data[38]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_data[39]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_data[40]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_data[41]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_data[42]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_data[43]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_data[44]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_data[45]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_data[46]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_data[47]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_data[48]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_data[49]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_data[50]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_data[51]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_data[52]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_data[53]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_data[54]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_data[55]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_data[56]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_data[57]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_data[58]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_data[59]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_data[60]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_data[61]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_data[62]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_data[63]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe12]
set_property port_width 72 [get_debug_ports u_ila_0/probe12]
connect_debug_port u_ila_0/probe12 [get_nets [list {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_out[0]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_out[1]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_out[2]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_out[3]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_out[4]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_out[5]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_out[6]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_out[7]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_out[8]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_out[9]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_out[10]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_out[11]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_out[12]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_out[13]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_out[14]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_out[15]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_out[16]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_out[17]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_out[18]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_out[19]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_out[20]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_out[21]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_out[22]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_out[23]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_out[24]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_out[25]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_out[26]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_out[27]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_out[28]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_out[29]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_out[30]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_out[31]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_out[32]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_out[33]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_out[34]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_out[35]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_out[36]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_out[37]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_out[38]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_out[39]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_out[40]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_out[41]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_out[42]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_out[43]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_out[44]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_out[45]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_out[46]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_out[47]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_out[48]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_out[49]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_out[50]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_out[51]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_out[52]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_out[53]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_out[54]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_out[55]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_out[56]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_out[57]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_out[58]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_out[59]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_out[60]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_out[61]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_out[62]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_out[63]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_out[64]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_out[65]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_out[66]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_out[67]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_out[68]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_out[69]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_out[70]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_out[71]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe13]
set_property port_width 64 [get_debug_ports u_ila_0/probe13]
connect_debug_port u_ila_0/probe13 [get_nets [list {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[1][0]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[1][1]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[1][2]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[1][3]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[1][4]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[1][5]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[1][6]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[1][7]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[1][8]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[1][9]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[1][10]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[1][11]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[1][12]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[1][13]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[1][14]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[1][15]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[1][16]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[1][17]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[1][18]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[1][19]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[1][20]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[1][21]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[1][22]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[1][23]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[1][24]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[1][25]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[1][26]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[1][27]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[1][28]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[1][29]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[1][30]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[1][31]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[1][32]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[1][33]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[1][34]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[1][35]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[1][36]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[1][37]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[1][38]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[1][39]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[1][40]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[1][41]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[1][42]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[1][43]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[1][44]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[1][45]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[1][46]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[1][47]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[1][48]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[1][49]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[1][50]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[1][51]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[1][52]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[1][53]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[1][54]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[1][55]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[1][56]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[1][57]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[1][58]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[1][59]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[1][60]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[1][61]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[1][62]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[1][63]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe14]
set_property port_width 64 [get_debug_ports u_ila_0/probe14]
connect_debug_port u_ila_0/probe14 [get_nets [list {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[0][0]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[0][1]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[0][2]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[0][3]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[0][4]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[0][5]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[0][6]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[0][7]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[0][8]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[0][9]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[0][10]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[0][11]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[0][12]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[0][13]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[0][14]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[0][15]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[0][16]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[0][17]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[0][18]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[0][19]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[0][20]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[0][21]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[0][22]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[0][23]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[0][24]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[0][25]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[0][26]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[0][27]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[0][28]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[0][29]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[0][30]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[0][31]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[0][32]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[0][33]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[0][34]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[0][35]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[0][36]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[0][37]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[0][38]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[0][39]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[0][40]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[0][41]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[0][42]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[0][43]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[0][44]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[0][45]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[0][46]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[0][47]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[0][48]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[0][49]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[0][50]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[0][51]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[0][52]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[0][53]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[0][54]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[0][55]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[0][56]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[0][57]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[0][58]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[0][59]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[0][60]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[0][61]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[0][62]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_tdl[0][63]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe15]
set_property port_width 72 [get_debug_ports u_ila_0/probe15]
connect_debug_port u_ila_0/probe15 [get_nets [list {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_in[0]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_in[1]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_in[2]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_in[3]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_in[4]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_in[5]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_in[6]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_in[7]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_in[8]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_in[9]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_in[10]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_in[11]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_in[12]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_in[13]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_in[14]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_in[15]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_in[16]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_in[17]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_in[18]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_in[19]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_in[20]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_in[21]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_in[22]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_in[23]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_in[24]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_in[25]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_in[26]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_in[27]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_in[28]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_in[29]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_in[30]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_in[31]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_in[32]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_in[33]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_in[34]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_in[35]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_in[36]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_in[37]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_in[38]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_in[39]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_in[40]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_in[41]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_in[42]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_in[43]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_in[44]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_in[45]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_in[46]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_in[47]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_in[48]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_in[49]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_in[50]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_in[51]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_in[52]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_in[53]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_in[54]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_in[55]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_in[56]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_in[57]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_in[58]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_in[59]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_in[60]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_in[61]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_in[62]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_in[63]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_in[64]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_in[65]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_in[66]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_in[67]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_in[68]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_in[69]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_in[70]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_event_data_in[71]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe16]
set_property port_width 32 [get_debug_ports u_ila_0/probe16]
connect_debug_port u_ila_0/probe16 [get_nets [list {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ts_event_count[0]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ts_event_count[1]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ts_event_count[2]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ts_event_count[3]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ts_event_count[4]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ts_event_count[5]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ts_event_count[6]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ts_event_count[7]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ts_event_count[8]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ts_event_count[9]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ts_event_count[10]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ts_event_count[11]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ts_event_count[12]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ts_event_count[13]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ts_event_count[14]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ts_event_count[15]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ts_event_count[16]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ts_event_count[17]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ts_event_count[18]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ts_event_count[19]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ts_event_count[20]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ts_event_count[21]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ts_event_count[22]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ts_event_count[23]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ts_event_count[24]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ts_event_count[25]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ts_event_count[26]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ts_event_count[27]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ts_event_count[28]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ts_event_count[29]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ts_event_count[30]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ts_event_count[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe17]
set_property port_width 32 [get_debug_ports u_ila_0/probe17]
connect_debug_port u_ila_0/probe17 [get_nets [list {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/seconds_reg[0]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/seconds_reg[1]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/seconds_reg[2]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/seconds_reg[3]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/seconds_reg[4]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/seconds_reg[5]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/seconds_reg[6]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/seconds_reg[7]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/seconds_reg[8]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/seconds_reg[9]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/seconds_reg[10]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/seconds_reg[11]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/seconds_reg[12]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/seconds_reg[13]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/seconds_reg[14]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/seconds_reg[15]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/seconds_reg[16]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/seconds_reg[17]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/seconds_reg[18]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/seconds_reg[19]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/seconds_reg[20]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/seconds_reg[21]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/seconds_reg[22]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/seconds_reg[23]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/seconds_reg[24]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/seconds_reg[25]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/seconds_reg[26]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/seconds_reg[27]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/seconds_reg[28]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/seconds_reg[29]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/seconds_reg[30]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/seconds_reg[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe18]
set_property port_width 9 [get_debug_ports u_ila_0/probe18]
connect_debug_port u_ila_0/probe18 [get_nets [list {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_count[0]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_count[1]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_count[2]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_count[3]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_count[4]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_count[5]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_count[6]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_count[7]} {picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_count[8]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe19]
set_property port_width 1 [get_debug_ports u_ila_0/probe19]
connect_debug_port u_ila_0/probe19 [get_nets [list picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/align_error]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe20]
set_property port_width 1 [get_debug_ports u_ila_0/probe20]
connect_debug_port u_ila_0/probe20 [get_nets [list picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/CPLLRESET_in]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe21]
set_property port_width 1 [get_debug_ports u_ila_0/probe21]
connect_debug_port u_ila_0/probe21 [get_nets [list picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/databuf_rx_k_i]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe22]
set_property port_width 1 [get_debug_ports u_ila_0/probe22]
connect_debug_port u_ila_0/probe22 [get_nets [list picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/ext_trig_ts_valid]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe23]
set_property port_width 1 [get_debug_ports u_ila_0/probe23]
connect_debug_port u_ila_0/probe23 [get_nets [list picoevr_system_arch_i/ESS_OpenEVR/U0/ext_ts_trig]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe24]
set_property port_width 1 [get_debug_ports u_ila_0/probe24]
connect_debug_port u_ila_0/probe24 [get_nets [list picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_buffer_valid]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe25]
set_property port_width 1 [get_debug_ports u_ila_0/probe25]
connect_debug_port u_ila_0/probe25 [get_nets [list picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_empty]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe26]
set_property port_width 1 [get_debug_ports u_ila_0/probe26]
connect_debug_port u_ila_0/probe26 [get_nets [list picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_full]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe27]
set_property port_width 1 [get_debug_ports u_ila_0/probe27]
connect_debug_port u_ila_0/probe27 [get_nets [list picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_rd_en]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe28]
set_property port_width 1 [get_debug_ports u_ila_0/probe28]
connect_debug_port u_ila_0/probe28 [get_nets [list picoevr_system_arch_i/ESS_OpenEVR/U0/event_timestamp/fifo_wr_en]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe29]
set_property port_width 1 [get_debug_ports u_ila_0/probe29]
connect_debug_port u_ila_0/probe29 [get_nets [list picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/GTRXRESET_in]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe30]
set_property port_width 1 [get_debug_ports u_ila_0/probe30]
connect_debug_port u_ila_0/probe30 [get_nets [list picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/GTTXRESET_in]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe31]
set_property port_width 1 [get_debug_ports u_ila_0/probe31]
connect_debug_port u_ila_0/probe31 [get_nets [list picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/link_ok]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe32]
set_property port_width 1 [get_debug_ports u_ila_0/probe32]
connect_debug_port u_ila_0/probe32 [get_nets [list picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/rx_error]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe33]
set_property port_width 1 [get_debug_ports u_ila_0/probe33]
connect_debug_port u_ila_0/probe33 [get_nets [list picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/RXCDRLOCK_out]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe34]
set_property port_width 1 [get_debug_ports u_ila_0/probe34]
connect_debug_port u_ila_0/probe34 [get_nets [list picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/rxcdrreset]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe35]
set_property port_width 1 [get_debug_ports u_ila_0/probe35]
connect_debug_port u_ila_0/probe35 [get_nets [list picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/RXPCSRESET_in]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe36]
set_property port_width 1 [get_debug_ports u_ila_0/probe36]
connect_debug_port u_ila_0/probe36 [get_nets [list picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/RXPMARESET_in]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe37]
set_property port_width 1 [get_debug_ports u_ila_0/probe37]
connect_debug_port u_ila_0/probe37 [get_nets [list picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/RXRESETDONE_out]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe38]
set_property port_width 1 [get_debug_ports u_ila_0/probe38]
connect_debug_port u_ila_0/probe38 [get_nets [list picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/RXUSERRDY_in]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe39]
set_property port_width 1 [get_debug_ports u_ila_0/probe39]
connect_debug_port u_ila_0/probe39 [get_nets [list picoevr_system_arch_i/ESS_OpenEVR/U0/i_evr_dc/i_upstream/TXUSERRDY_in]]
set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
connect_debug_port dbg_hub/clk [get_nets u_ila_0_debug_clk]
