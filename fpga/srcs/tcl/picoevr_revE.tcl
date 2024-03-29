# Custom code to generate the architecture for the revE

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
  set i_LEMO_I [ create_bd_port -dir I -from 3 -to 0 i_LEMO_I ]
  set i_ZYNQ_CLKREF0_N [ create_bd_port -dir I i_ZYNQ_CLKREF0_N ]
  set i_ZYNQ_CLKREF0_P [ create_bd_port -dir I i_ZYNQ_CLKREF0_P ]
  set i_ZYNQ_CLKREF1_N [ create_bd_port -dir I i_ZYNQ_CLKREF1_N ]
  set i_ZYNQ_CLKREF1_P [ create_bd_port -dir I i_ZYNQ_CLKREF1_P ]
  set i_ZYNQ_MRCC1 [ create_bd_port -dir I i_ZYNQ_MRCC1 ]
  set i_ZYNQ_MRCC2 [ create_bd_port -dir I i_ZYNQ_MRCC2 ]
  set o_EVR_EVNT_LED [ create_bd_port -dir O -from 0 -to 0 o_EVR_EVNT_LED ]
  set o_EVR_LINK_LED [ create_bd_port -dir O -from 0 -to 0 -type data o_EVR_LINK_LED ]
  set o_EVR_TX_N [ create_bd_port -dir O o_EVR_TX_N ]
  set o_EVR_TX_P [ create_bd_port -dir O o_EVR_TX_P ]
  set o_EVR_TX_DISABLE [ create_bd_port -dir O -from 0 -to 0 o_EVR_TX_DISABLE ]
  set o_LEMO_DIR [ create_bd_port -dir O -from 3 -to 0 o_LEMO_DIR ]
  set o_LEMO_O [ create_bd_port -dir O -from 3 -to 0 o_LEMO_O ]

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

  # Create instance: EVR_TX_DISABLE, and set properties
  set EVR_TX_DISABLE [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 EVR_TX_DISABLE ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {0} \
   CONFIG.CONST_WIDTH {1} \
 ] $EVR_TX_DISABLE

  # Create instance: LEMO_DIR, and set properties
  set LEMO_DIR [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 LEMO_DIR ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {1} \
   CONFIG.CONST_WIDTH {1} \
 ] $LEMO_DIR

  # Create instance: LEMO_DIR_concat, and set properties
  set LEMO_DIR_concat [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 LEMO_DIR_concat ]
  set_property -dict [ list \
   CONFIG.IN0_WIDTH {1} \
   CONFIG.IN1_WIDTH {1} \
   CONFIG.IN2_WIDTH {1} \
   CONFIG.IN3_WIDTH {1} \
   CONFIG.NUM_PORTS {4} \
 ] $LEMO_DIR_concat

  # Create instance: LEMO_IO_concat, and set properties
  set LEMO_IO_concat [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 LEMO_IO_concat ]
  set_property -dict [ list \
   CONFIG.NUM_PORTS {4} \
 ] $LEMO_IO_concat

  # Create instance: LEMO_OUT, and set properties
  set LEMO_OUT [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 LEMO_OUT ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {1} \
   CONFIG.CONST_WIDTH {1} \
 ] $LEMO_OUT

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
  connect_bd_net -net i_EVR_SFP_MOD_0 [get_bd_ports i_EVR_SFP_MOD_0] [get_bd_pins ESS_OpenEVR/i_EVR_MOD_0]
  connect_bd_net -net i_ZYNQ_CLKREF0_N_1 [get_bd_ports i_ZYNQ_CLKREF0_N] [get_bd_pins ESS_OpenEVR/i_ZYNQ_CLKREF0_N]
  connect_bd_net -net i_ZYNQ_CLKREF0_P_0_1 [get_bd_ports i_ZYNQ_CLKREF0_P] [get_bd_pins ESS_OpenEVR/i_ZYNQ_CLKREF0_P]
  connect_bd_net -net ESS_OpenEVR_i_MRCC1_CLK [get_bd_ports i_ZYNQ_MRCC1] [get_bd_pins ESS_OpenEVR/i_ZYNQ_MRCC1]
  connect_bd_net -net ESS_OpenEVR_i_MRCC2_CLK [get_bd_ports i_ZYNQ_MRCC2] [get_bd_pins ESS_OpenEVR/i_DEBUG_clk]
  connect_bd_net -net LEMO_DIR_concat_dout [get_bd_ports o_LEMO_DIR] [get_bd_pins LEMO_DIR_concat/dout]
  connect_bd_net -net LEMO_DIR_dout [get_bd_pins LEMO_DIR/dout] [get_bd_pins LEMO_DIR_concat/In0] [get_bd_pins LEMO_DIR_concat/In1] [get_bd_pins LEMO_DIR_concat/In2] [get_bd_pins LEMO_DIR_concat/In3]
  connect_bd_net -net LEMO_OUT_dout [get_bd_pins LEMO_IO_concat/In0] [get_bd_pins LEMO_IO_concat/In1] [get_bd_pins LEMO_IO_concat/In2] [get_bd_pins LEMO_IO_concat/In3] [get_bd_pins LEMO_OUT/dout]
  connect_bd_net -net i_EVR_RX_N_0_1 [get_bd_ports i_EVR_RX_N] [get_bd_pins ESS_OpenEVR/i_EVR_RX_N]
  connect_bd_net -net i_EVR_RX_P_0_1 [get_bd_ports i_EVR_RX_P] [get_bd_pins ESS_OpenEVR/i_EVR_RX_P]
  connect_bd_net -net processing_system7_0_FCLK_CLK0 [get_bd_pins ESS_OpenEVR/s_axi_aclk] [get_bd_pins processing_system7_0/FCLK_CLK0] [get_bd_pins processing_system7_0/M_AXI_GP0_ACLK] [get_bd_pins ps7_0_axi_periph/ACLK] [get_bd_pins ps7_0_axi_periph/M00_ACLK] [get_bd_pins ps7_0_axi_periph/S00_ACLK] [get_bd_pins rst_ps7_0_100M/slowest_sync_clk]
  connect_bd_net -net processing_system7_0_FCLK_RESET0_N [get_bd_pins processing_system7_0/FCLK_RESET0_N] [get_bd_pins rst_ps7_0_100M/ext_reset_in]
  connect_bd_net -net rst_ps7_0_100M_peripheral_aresetn [get_bd_pins ESS_OpenEVR/s_axi_aresetn] [get_bd_pins ps7_0_axi_periph/ARESETN] [get_bd_pins ps7_0_axi_periph/M00_ARESETN] [get_bd_pins ps7_0_axi_periph/S00_ARESETN] [get_bd_pins rst_ps7_0_100M/peripheral_aresetn]
  connect_bd_net -net xlconcat_0_dout [get_bd_ports o_LEMO_O] [get_bd_pins LEMO_IO_concat/dout]

  # Create address segments
  assign_bd_address -offset 0x43C00000 -range 0x00010000 -target_address_space [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs ESS_OpenEVR/s_axi/reg0] -force


  # Restore current instance
  current_bd_instance $oldCurInst

  validate_bd_design
  save_bd_design
  close_bd_design $design_name
}
