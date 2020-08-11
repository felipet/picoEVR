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
