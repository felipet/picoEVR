# Custom code to generate the architecture for the revD

# Hierarchical cell: GPIO_Bus
proc create_hier_cell_GPIO_Bus { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_msg_id "BD_TCL-102" "ERROR" "create_hier_cell_GPIO_Bus() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins

  # Create pins
  create_bd_pin -dir O -from 31 -to 0 dout
  create_bd_pin -dir I -from 0 -to 0 i_SY87730_LOCKED

  # Create instance: xlconcat_0, and set properties
  set xlconcat_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 xlconcat_0 ]
  set_property -dict [ list \
   CONFIG.NUM_PORTS {32} \
 ] $xlconcat_0

  # Create port connections
  connect_bd_net -net i_SY87730_LOCKED_1 [get_bd_pins i_SY87730_LOCKED] [get_bd_pins xlconcat_0/In0]
  connect_bd_net -net xlconcat_0_dout [get_bd_pins dout] [get_bd_pins xlconcat_0/dout]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Proc to create BD picoevr_system_arch
proc cr_bd_picoevr_system_arch { parentCell bd_name} {

  upvar $bd_name design_name

  # CHANGE DESIGN NAME HERE
  set design_name picoevr_system_arch

  common::send_msg_id "BD_TCL-003" "INFO" "Currently there is no design <$design_name> in project, so creating one..."

  create_bd_design $design_name

  set bCheckIPsPassed 1
  ##################################################################
  # CHECK IPs
  ##################################################################
  set bCheckIPs 1
  if { $bCheckIPs == 1 } {
     set list_check_ips "\
  xilinx.com:ip:xlconstant:1.1\
  xilinx.com:ip:processing_system7:5.5\
  "

   set list_ips_missing ""
   common::send_msg_id "BD_TCL-006" "INFO" "Checking if the following IPs exist in the project's IP catalog: $list_check_ips ."

   foreach ip_vlnv $list_check_ips {
      set ip_obj [get_ipdefs -all $ip_vlnv]
      if { $ip_obj eq "" } {
         lappend list_ips_missing $ip_vlnv
      }
   }

   if { $list_ips_missing ne "" } {
      catch {common::send_msg_id "BD_TCL-115" "ERROR" "The following IPs are not found in the IP Catalog:\n  $list_ips_missing\n\nResolution: Please add the repository containing the IP(s) to the project." }
      set bCheckIPsPassed 0
   }

  }

  if { $bCheckIPsPassed != 1 } {
    common::send_msg_id "BD_TCL-1003" "WARNING" "Will not continue with creation of design due to the error(s) above."
    return 3
  }

  variable script_folder

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports
  set DDR [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:ddrx_rtl:1.0 DDR ]

  set FIXED_IO [ create_bd_intf_port -mode Master -vlnv xilinx.com:display_processing_system7:fixedio_rtl:1.0 FIXED_IO ]

  # Create ports
  set i_EVR_RX_N [ create_bd_port -dir I i_EVR_RX_N ]
  set i_EVR_RX_P [ create_bd_port -dir I i_EVR_RX_P ]
  set i_EVR_SFP_MOD_0 [ create_bd_port -dir I i_EVR_SFP_MOD_0 ]
  set i_SY87730_LOCKED [ create_bd_port -dir I -type data i_SY87730_LOCKED ]
  set i_ZYNQ_CLKREF0_N [ create_bd_port -dir I i_ZYNQ_CLKREF0_N ]
  set i_ZYNQ_CLKREF0_P [ create_bd_port -dir I i_ZYNQ_CLKREF0_P ]
  set i_ZYNQ_MRCC_LVDS_N [ create_bd_port -dir I i_ZYNQ_MRCC_LVDS_N ]
  set i_ZYNQ_MRCC_LVDS_P [ create_bd_port -dir I i_ZYNQ_MRCC_LVDS_P ]
  set o_EVR_ENABLE [ create_bd_port -dir O -from 0 -to 0 o_EVR_ENABLE ]
  set o_EVR_EVNT_LED [ create_bd_port -dir O -from 0 -to 0 o_EVR_EVNT_LED ]
  set o_EVR_LINK_LED [ create_bd_port -dir O -from 0 -to 0 -type data o_EVR_LINK_LED ]
  set o_EVR_TX_N [ create_bd_port -dir O o_EVR_TX_N ]
  set o_EVR_TX_P [ create_bd_port -dir O o_EVR_TX_P ]
  set o_EVR_TX_DISABLE [ create_bd_port -dir O -from 0 -to 0 o_EVR_TX_DISABLE ]
  set o_SY87730_PROGCS [ create_bd_port -dir O -from 0 -to 0 -type data o_SY87730_PROGCS ]
  set o_SY87730_PROGDI [ create_bd_port -dir O -type data o_SY87730_PROGDI ]
  set o_SY87730_PROGSK [ create_bd_port -dir O -type clk o_SY87730_PROGSK ]
  set o_SI5346_RST_rn [ create_bd_port -dir O -from 0 -to 0 o_SI5346_RST_rn ]

  # Create instance: GPIO_Bus
  create_hier_cell_GPIO_Bus [current_bd_instance .] GPIO_Bus

  # Create instance: SPI0_SS_O_Not, and set properties
  set SPI0_SS_O_Not [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 SPI0_SS_O_Not ]
  set_property -dict [ list \
   CONFIG.C_OPERATION {not} \
   CONFIG.C_SIZE {1} \
   CONFIG.LOGO_FILE {data/sym_notgate.png} \
 ] $SPI0_SS_O_Not

  # Create instance: EVR_TX_DISABLE, and set properties
  set EVR_TX_DISABLE [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 EVR_TX_DISABLE ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {0} \
   CONFIG.CONST_WIDTH {1} \
 ] $EVR_TX_DISABLE

  # Create instance: SPI0_SS_VCC, and set properties
  set SPI0_SS_VCC [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 SPI0_SS_VCC ]
  # Create instance: Si5346_RST_N, and set properties
  set Si5346_RST_N [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 Si5346_RST_N ]

  # Create instance: evr_clk_en, and set properties
  set evr_clk_en [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 evr_clk_en ]
  # Create instance: ESS_OpenEVR, and set properties
  set ESS_OpenEVR [ create_bd_cell -type ip -vlnv ESS:ess:ess_openEVR:0.1 ESS_OpenEVR ]
  # Enable debug clock in the OpenEVR IP
  # Forgive me for using global variables, I hate TCL.
  global carrier_hw_rev
  puts "Setting carrier hw revision to $carrier_hw_rev"
  set_property -dict [list \
    CONFIG.g_CARRIER_VER $carrier_hw_rev \
    CONFIG.g_HAS_DEBUG_CLK {true} \
  ] $ESS_OpenEVR

  # Create instance: processing_system7_0, and set properties
  set processing_system7_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:processing_system7:5.5 processing_system7_0 ]
  set where [file dirname [info script]]
  source [file join $where zynq_config_${carrier_hw_rev}.tcl]

  # Create instance: ps7_0_axi_periph, and set properties
  set ps7_0_axi_periph [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 ps7_0_axi_periph ]
  set_property -dict [ list \
   CONFIG.NUM_MI {1} \
 ] $ps7_0_axi_periph

  # Create instance: rst_ps7_0_100M, and set properties
  set rst_ps7_0_100M [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 rst_ps7_0_100M ]

  # Create interface connections
  connect_bd_intf_net -intf_net processing_system7_0_DDR [get_bd_intf_ports DDR] [get_bd_intf_pins processing_system7_0/DDR]
  connect_bd_intf_net -intf_net processing_system7_0_FIXED_IO [get_bd_intf_ports FIXED_IO] [get_bd_intf_pins processing_system7_0/FIXED_IO]
  connect_bd_intf_net -intf_net processing_system7_0_M_AXI_GP0 [get_bd_intf_pins processing_system7_0/M_AXI_GP0] [get_bd_intf_pins ps7_0_axi_periph/S00_AXI]
  connect_bd_intf_net -intf_net ps7_0_axi_periph_M00_AXI [get_bd_intf_pins ESS_OpenEVR/s_axi] [get_bd_intf_pins ps7_0_axi_periph/M00_AXI]

  # Create port connections
  connect_bd_net -net ESS_OpenEVR_o_EVR_EVNT_LED [get_bd_ports o_EVR_EVNT_LED] [get_bd_pins ESS_OpenEVR/o_EVR_EVNT_LED]
  connect_bd_net -net ESS_OpenEVR_o_EVR_LINK_LED [get_bd_ports o_EVR_LINK_LED] [get_bd_pins ESS_OpenEVR/o_EVR_LINK_LED]
  connect_bd_net -net ESS_OpenEVR_o_EVR_TX_N [get_bd_ports o_EVR_TX_N] [get_bd_pins ESS_OpenEVR/o_EVR_TX_N]
  connect_bd_net -net ESS_OpenEVR_o_EVR_TX_P [get_bd_ports o_EVR_TX_P] [get_bd_pins ESS_OpenEVR/o_EVR_TX_P]
  connect_bd_net -net EVR_TX_DISABLE_dout [get_bd_ports o_EVR_TX_DISABLE] [get_bd_pins EVR_TX_DISABLE/dout]
  connect_bd_net -net GPIO_Bus_dout [get_bd_pins GPIO_Bus/dout] [get_bd_pins processing_system7_0/GPIO_I]
  connect_bd_net -net Si5346_RST_N_dout [get_bd_ports o_SI5346_RST_rn] [get_bd_pins Si5346_RST_N/dout]
  connect_bd_net -net evr_clk_en_dout [get_bd_ports o_EVR_ENABLE] [get_bd_pins evr_clk_en/dout]
  connect_bd_net -net i_EVR_RX_N_0_1 [get_bd_ports i_EVR_RX_N] [get_bd_pins ESS_OpenEVR/i_EVR_RX_N]
  connect_bd_net -net i_EVR_RX_P_0_1 [get_bd_ports i_EVR_RX_P] [get_bd_pins ESS_OpenEVR/i_EVR_RX_P]
  connect_bd_net -net i_SY87730_LOCKED_1 [get_bd_ports i_SY87730_LOCKED] [get_bd_pins GPIO_Bus/i_SY87730_LOCKED]
  connect_bd_net -net i_ZYNQ_CLKREF0_N_1 [get_bd_ports i_ZYNQ_CLKREF0_N] [get_bd_pins ESS_OpenEVR/i_ZYNQ_CLKREF0_N]
  connect_bd_net -net i_ZYNQ_CLKREF0_P_0_1 [get_bd_ports i_ZYNQ_CLKREF0_P] [get_bd_pins ESS_OpenEVR/i_ZYNQ_CLKREF0_P]
  connect_bd_net -net i_ZYNQ_MRCC_LVDS_N_0_1 [get_bd_ports i_ZYNQ_MRCC_LVDS_N] [get_bd_pins ESS_OpenEVR/i_ZYNQ_MRCC_LVDS_N]
  connect_bd_net -net i_ZYNQ_MRCC_LVDS_P_0_1 [get_bd_ports i_ZYNQ_MRCC_LVDS_P] [get_bd_pins ESS_OpenEVR/i_ZYNQ_MRCC_LVDS_P]
  connect_bd_net -net processing_system7_0_FCLK_CLK0 [get_bd_pins ESS_OpenEVR/s_axi_aclk] [get_bd_pins processing_system7_0/FCLK_CLK0] [get_bd_pins processing_system7_0/M_AXI_GP0_ACLK] [get_bd_pins ps7_0_axi_periph/ACLK] [get_bd_pins ps7_0_axi_periph/M00_ACLK] [get_bd_pins ps7_0_axi_periph/S00_ACLK] [get_bd_pins rst_ps7_0_100M/slowest_sync_clk]
  connect_bd_net -net processing_system7_0_FCLK_CLK1 [get_bd_pins processing_system7_0/FCLK_CLK1] [get_bd_pins ESS_OpenEVR/i_DEBUG_clk]
  connect_bd_net -net processing_system7_0_FCLK_RESET0_N [get_bd_pins processing_system7_0/FCLK_RESET0_N] [get_bd_pins rst_ps7_0_100M/ext_reset_in]
  connect_bd_net -net processing_system7_0_SPI0_MOSI_O [get_bd_ports o_SY87730_PROGDI] [get_bd_pins processing_system7_0/SPI0_MOSI_O]
  connect_bd_net -net processing_system7_0_SPI0_SCLK_O [get_bd_ports o_SY87730_PROGSK] [get_bd_pins processing_system7_0/SPI0_SCLK_O]
  connect_bd_net -net processing_system7_0_SPI0_SS_O [get_bd_pins SPI0_SS_O_Not/Op1] [get_bd_pins processing_system7_0/SPI0_SS_O]
  connect_bd_net -net rst_ps7_0_100M_peripheral_aresetn [get_bd_pins ESS_OpenEVR/s_axi_aresetn] [get_bd_pins ps7_0_axi_periph/ARESETN] [get_bd_pins ps7_0_axi_periph/M00_ARESETN] [get_bd_pins ps7_0_axi_periph/S00_ARESETN] [get_bd_pins rst_ps7_0_100M/peripheral_aresetn]
  connect_bd_net -net spiSSTieOff_dout [get_bd_pins SPI0_SS_VCC/dout] [get_bd_pins processing_system7_0/SPI0_SS_I]
  connect_bd_net -net util_vector_logic_0_Res [get_bd_ports o_SY87730_PROGCS] [get_bd_pins SPI0_SS_O_Not/Res]

  # Create address segments
  assign_bd_address -offset 0x43C00000 -range 0x00010000 -target_address_space [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs ESS_OpenEVR/s_axi/reg0] -force


  # Restore current instance
  current_bd_instance $oldCurInst

  validate_bd_design
  save_bd_design
  close_bd_design $design_name
}
