# =============================================================================
# ETHERCAT SLAVE FMC
# =============================================================================
# PROM I2C
set_property -dict {PACKAGE_PIN E8   IOSTANDARD LVCMOS18              } [get_ports prom_clk_o]
set_property -dict {PACKAGE_PIN D8   IOSTANDARD LVCMOS18              } [get_ports prom_data_io]

# LEDS
set_property -dict {PACKAGE_PIN N4   IOSTANDARD LVCMOS18                    } [get_ports {led_link_act_o[0]}]
set_property -dict {PACKAGE_PIN N3   IOSTANDARD LVCMOS18                    } [get_ports {led_link_act_o[1]}]
set_property -dict {PACKAGE_PIN N1   IOSTANDARD LVCMOS18                    } [get_ports led_run_o]
set_property -dict {PACKAGE_PIN R5   IOSTANDARD LVCMOS18                    } [get_ports led_err_o]

# MDIO
set_property -dict {PACKAGE_PIN F6   IOSTANDARD LVCMOS18                    } [get_ports mdio_mdio_io]
set_property -dict {PACKAGE_PIN G6   IOSTANDARD LVCMOS18                    } [get_ports mdio_mdc_o]

# PHY 0 =================================================================================================
set_property -dict {PACKAGE_PIN J5   IOSTANDARD LVCMOS18  PULLTYPE PULLUP   } [get_ports phy0_pwdn_o]
set_property -dict {PACKAGE_PIN R7   IOSTANDARD LVCMOS18  PULLTYPE PULLUP   } [get_ports phy0_an1_i]
set_property -dict {PACKAGE_PIN K4   IOSTANDARD LVCMOS18  PULLTYPE PULLDOWN } [get_ports phy0_an2_i]
set_property -dict {PACKAGE_PIN P7   IOSTANDARD LVCMOS18  PULLTYPE PULLUP   } [get_ports phy0_an_en_i]
set_property -dict {PACKAGE_PIN K3   IOSTANDARD LVCMOS18                    } [get_ports {sw_strap1_o[0]}]

# Rx Data
set_property -dict {PACKAGE_PIN E4   IOSTANDARD LVCMOS18                    } [get_ports {mii_rx_data0_i[0]}]
set_property -dict {PACKAGE_PIN E3   IOSTANDARD LVCMOS18                    } [get_ports {mii_rx_data0_i[1]}]
set_property -dict {PACKAGE_PIN B2   IOSTANDARD LVCMOS18                    } [get_ports {mii_rx_data0_i[2]}]
set_property -dict {PACKAGE_PIN B1   IOSTANDARD LVCMOS18                    } [get_ports {mii_rx_data0_i[3]}]
# Rx Control
set_property -dict {PACKAGE_PIN T2   IOSTANDARD LVCMOS18                    } [get_ports mii_rx_clk0_i]
set_property -dict {PACKAGE_PIN C6   IOSTANDARD LVCMOS18                    } [get_ports mii_rx_dv0_i]
set_property -dict {PACKAGE_PIN C5   IOSTANDARD LVCMOS18                    } [get_ports mii_rx_err0_i]
set_property -dict {PACKAGE_PIN F2   IOSTANDARD LVCMOS18                    } [get_ports mii_rx_crs0_i]
set_property -dict {PACKAGE_PIN F1   IOSTANDARD LVCMOS18                    } [get_ports mii_rx_col0_i]

# Tx Data
set_property -dict {PACKAGE_PIN L6   IOSTANDARD LVCMOS18                    } [get_ports {mii_tx_data0_o[0]}]
set_property -dict {PACKAGE_PIN M6   IOSTANDARD LVCMOS18                    } [get_ports {mii_tx_data0_o[1]}]
set_property -dict {PACKAGE_PIN P6   IOSTANDARD LVCMOS18                    } [get_ports {mii_tx_data0_o[2]}]
set_property -dict {PACKAGE_PIN P5   IOSTANDARD LVCMOS18                    } [get_ports {mii_tx_data0_o[3]}]
# Tx Control
set_property -dict {PACKAGE_PIN U2   IOSTANDARD LVCMOS18                    } [get_ports mii_tx_clk0_i]
set_property -dict {PACKAGE_PIN J8   IOSTANDARD LVCMOS18                    } [get_ports mii_tx_en0_o]

# PHY 1 =================================================================================================
set_property -dict {PACKAGE_PIN M2   IOSTANDARD LVCMOS18  PULLTYPE PULLUP   } [get_ports phy1_pwdn_o]
set_property -dict {PACKAGE_PIN K2   IOSTANDARD LVCMOS18  PULLTYPE PULLUP   } [get_ports phy1_an1_i]
set_property -dict {PACKAGE_PIN L2   IOSTANDARD LVCMOS18  PULLTYPE PULLDOWN } [get_ports phy1_an2_i]
set_property -dict {PACKAGE_PIN J3   IOSTANDARD LVCMOS18  PULLTYPE PULLUP   } [get_ports phy1_an_en_i]
set_property -dict {PACKAGE_PIN L1   IOSTANDARD LVCMOS18                    } [get_ports {sw_strap2_o[0]}]

# Rx Data
set_property -dict {PACKAGE_PIN G8   IOSTANDARD LVCMOS18                    } [get_ports {mii_rx_data1_i[0]}]
set_property -dict {PACKAGE_PIN G7   IOSTANDARD LVCMOS18                    } [get_ports {mii_rx_data1_i[1]}]
set_property -dict {PACKAGE_PIN B7   IOSTANDARD LVCMOS18                    } [get_ports {mii_rx_data1_i[2]}]
set_property -dict {PACKAGE_PIN B6   IOSTANDARD LVCMOS18                    } [get_ports {mii_rx_data1_i[3]}]
# Rx Control
set_property -dict {PACKAGE_PIN B4   IOSTANDARD LVCMOS18                    } [get_ports mii_rx_clk1_i]
set_property -dict {PACKAGE_PIN A7   IOSTANDARD LVCMOS18                    } [get_ports mii_rx_dv1_i]
set_property -dict {PACKAGE_PIN A6   IOSTANDARD LVCMOS18                    } [get_ports mii_rx_err1_i]
set_property -dict {PACKAGE_PIN C8   IOSTANDARD LVCMOS18                    } [get_ports mii_rx_crs1_i]
set_property -dict {PACKAGE_PIN B8   IOSTANDARD LVCMOS18                    } [get_ports mii_rx_col1_i]

# Tx Data
set_property -dict {PACKAGE_PIN R3   IOSTANDARD LVCMOS18                    } [get_ports {mii_tx_data1_o[0]}]
set_property -dict {PACKAGE_PIN R2   IOSTANDARD LVCMOS18                    } [get_ports {mii_tx_data1_o[1]}]
set_property -dict {PACKAGE_PIN J7   IOSTANDARD LVCMOS18                    } [get_ports {mii_tx_data1_o[2]}]
set_property -dict {PACKAGE_PIN J6   IOSTANDARD LVCMOS18                    } [get_ports {mii_tx_data1_o[3]}]
# Tx Control
set_property -dict {PACKAGE_PIN D3   IOSTANDARD LVCMOS18                    } [get_ports mii_tx_clk1_i]
set_property -dict {PACKAGE_PIN P3   IOSTANDARD LVCMOS18                    } [get_ports mii_tx_en1_o]
# =======================================================================================================

# MISC
set_property -dict {PACKAGE_PIN A5   IOSTANDARD LVCMOS18                    } [get_ports nreset_out]
set_property -dict {PACKAGE_PIN A2   IOSTANDARD LVCMOS18                    } [get_ports {fmc_clk_en_o[0]}]

# 25MHz clock from FMC ( T = 40 ns ...)
set_property -dict {PACKAGE_PIN L5   IOSTANDARD LVDS                        } [get_ports clk25_clk_p]
