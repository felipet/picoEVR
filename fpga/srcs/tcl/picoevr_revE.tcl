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
  set i_ZYNQ_CLKREF0_N [ create_bd_port -dir I i_ZYNQ_CLKREF0_N ]
  set i_ZYNQ_CLKREF0_P [ create_bd_port -dir I i_ZYNQ_CLKREF0_P ]
  set i_ZYNQ_MRCC1 [ create_bd_port -dir I i_ZYNQ_MRCC1 ]
  set i_ZYNQ_MRCC2 [ create_bd_port -dir I i_ZYNQ_MRCC2 ]
  set o_EVR_EVNT_LED [ create_bd_port -dir O o_EVR_EVNT_LED ]
  set o_EVR_LINK_LED [ create_bd_port -dir O o_EVR_LINK_LED ]
  set o_EVR_TX_N [ create_bd_port -dir O o_EVR_TX_N ]
  set o_EVR_TX_P [ create_bd_port -dir O o_EVR_TX_P ]
  set o_EVR_TX_DISABLE [ create_bd_port -dir O o_EVR_TX_DISABLE ]
  set o_LEMO_DIR [ create_bd_port -dir O -from 0 -to 3 o_LEMO_DIR ]
  set b_LEMO_IO [ create_bd_port -dir IO -from 0 -to 3 b_LEMO_IO ]
  set i_EVR_TX_FAULT [ create_bd_port -dir I i_EVR_TX_FAULT ]
  set i_EVR_RX_LOS [ create_bd_port -dir I i_EVR_RX_LOS ]
  # MRF UNIV IO socket
  set o_MRF_UNIVMOD_OUT0 [ create_bd_port -dir O o_MRF_UNIVMOD_OUT0 ]
  set o_MRF_UNIVMOD_OUT1 [ create_bd_port -dir O o_MRF_UNIVMOD_OUT1 ]
  set i_MRF_UNIVMOD_IN0  [ create_bd_port -dir I i_MRF_UNIVMOD_IN0 ]
  set i_MRF_UNIVMOD_IN1  [ create_bd_port -dir I i_MRF_UNIVMOD_IN1 ]

  # Create instance: ESS_OpenEVR, and set properties
  set ESS_OpenEVR [ create_bd_cell -type ip -vlnv ESS:ess:ess_openEVR:0.2 ESS_OpenEVR ]
  # Create instance: picoEVR channel mapper
  set ch_mapper [ create_bd_cell -type module -reference picoevr_channel_mapper_top channel_mapper ]

  # Enable debug clock in the OpenEVR IP
  # Forgive me for using global variables, I hate TCL.
  global carrier_hw_rev
  puts "Setting carrier hw revision to $carrier_hw_rev"
  set_property -dict [list \
    CONFIG.g_CARRIER_VER $carrier_hw_rev \
    CONFIG.g_HAS_DEBUG_CLK {true} \
  ] $ESS_OpenEVR

  # Create instance: EVR_TX_DISABLE, and set properties
  set GND [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 GND ]
  set_property -dict [ list \
    CONFIG.CONST_VAL {0} \
    CONFIG.CONST_WIDTH {1} \
  ] $GND

  # Create instance: ch_mapper_rst, and set properties
  set ch_mapper_rst [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 ch_mapper_rst ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {0} \
   CONFIG.CONST_WIDTH {1} \
 ] $ch_mapper_rst

 set voutput_slice_0to1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 voutput_slice_0to1 ]
 set_property -dict [ list \
   CONFIG.DIN_FROM {1} \
   CONFIG.DIN_WIDTH {4} \
   CONFIG.DOUT_WIDTH {2} \
 ] $voutput_slice_0to1

  # Create instance: LEMO_IO_concat, and set properties
  set vinput_concat [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 vinput_concat ]
  set_property -dict [ list \
   CONFIG.IN0_WIDTH.VALUE_SRC USER \
   CONFIG.IN1_WIDTH.VALUE_SRC USER \
   CONFIG.IN2_WIDTH.VALUE_SRC USER \
   CONFIG.NUM_PORTS {3} \
   CONFIG.IN1_WIDTH {2} \
 ] $vinput_concat

  # Create instance: processing_system7_0, and set properties
  set processing_system7_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:processing_system7:5.5 processing_system7_0 ]
  set where [file dirname [info script]]
  source [file join $where zynq_config_${carrier_hw_rev}.tcl]

  # Create instance: ps7_0_axi_periph, and set properties
  set ps7_0_axi_periph [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 ps7_0_axi_periph ]
  set_property -dict [ list \
   CONFIG.NUM_MI {4} \
 ] $ps7_0_axi_periph

  # Create instance: rst_ps7_0_100M, and set properties
  set rst_ps7_0_100M [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 rst_ps7_0_100M ]

   # Create instance: mapping_ram_X, and set properties
   set mapping_RAM_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 mapping_ram_0 ]
   set mapping_RAM_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 mapping_ram_1 ]

   # Specify where are located the initialization file for the BRAM
   set script_path [ file dirname [ file normalize [ info script ] ] ]
   set coeFile0loc ${script_path}/../coe/event_decoder_map0.coe

   set_property -dict [list \
      CONFIG.Memory_Type {True_Dual_Port_RAM} \
      CONFIG.Enable_32bit_Address {false} \
      CONFIG.Use_Byte_Write_Enable {false} \
      CONFIG.Byte_Size {9} CONFIG.Write_Depth_A {1024} \
      CONFIG.Write_Width_B {128} CONFIG.Read_Width_B {128} \
      CONFIG.Enable_B {Use_ENB_Pin} CONFIG.Register_PortA_Output_of_Memory_Primitives {true} \
      CONFIG.Register_PortB_Output_of_Memory_Primitives {false} CONFIG.Load_Init_File {true} \
      CONFIG.Fill_Remaining_Memory_Locations {true} \
      CONFIG.Use_RSTA_Pin {false} CONFIG.Port_B_Clock {100} \
      CONFIG.Coe_File $coeFile0loc \
      CONFIG.Port_B_Write_Rate {50} \
      CONFIG.Port_B_Enable_Rate {100} \
      CONFIG.use_bram_block {Stand_Alone} \
      CONFIG.EN_SAFETY_CKT {false} \
   ] $mapping_RAM_0
   set coeFile1loc ${script_path}/../coe/event_decoder_map1.coe
   set_property -dict [list \
      CONFIG.Memory_Type {True_Dual_Port_RAM} \
      CONFIG.Enable_32bit_Address {false} \
      CONFIG.Use_Byte_Write_Enable {false} \
      CONFIG.Byte_Size {9} CONFIG.Write_Depth_A {1024} \
      CONFIG.Write_Width_B {128} CONFIG.Read_Width_B {128} \
      CONFIG.Enable_B {Use_ENB_Pin} CONFIG.Register_PortA_Output_of_Memory_Primitives {true} \
      CONFIG.Register_PortB_Output_of_Memory_Primitives {false} CONFIG.Load_Init_File {true} \
      CONFIG.Fill_Remaining_Memory_Locations {true} \
      CONFIG.Use_RSTA_Pin {false} CONFIG.Port_B_Clock {100} \
      CONFIG.Coe_File $coeFile1loc \
      CONFIG.Port_B_Write_Rate {50} \
      CONFIG.Port_B_Enable_Rate {100} \
      CONFIG.use_bram_block {Stand_Alone} \
      CONFIG.EN_SAFETY_CKT {false} \
   ] $mapping_RAM_1

   # Create instance: AXI Bram controller
   set axi_bram_ctrl_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_bram_ctrl:4.1 axi_bram_ctrl_0 ]
   set axi_bram_ctrl_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_bram_ctrl:4.1 axi_bram_ctrl_1 ]
   set_property -dict [list CONFIG.PROTOCOL {AXI4LITE} CONFIG.SINGLE_PORT_BRAM {1} CONFIG.ECC_TYPE {0}] $axi_bram_ctrl_0
   set_property -dict [list CONFIG.PROTOCOL {AXI4LITE} CONFIG.SINGLE_PORT_BRAM {1} CONFIG.ECC_TYPE {0}] $axi_bram_ctrl_1

  # Create interface connections
  connect_bd_intf_net -intf_net processing_system7_0_DDR [get_bd_intf_ports DDR] [get_bd_intf_pins processing_system7_0/DDR]
  connect_bd_intf_net -intf_net processing_system7_0_FIXED_IO [get_bd_intf_ports FIXED_IO] [get_bd_intf_pins processing_system7_0/FIXED_IO]
  connect_bd_intf_net -intf_net processing_system7_0_M_AXI_GP0 [get_bd_intf_pins processing_system7_0/M_AXI_GP0] [get_bd_intf_pins ps7_0_axi_periph/S00_AXI]
  connect_bd_intf_net -intf_net ps7_0_axi_periph_M00_AXI [get_bd_intf_pins ESS_OpenEVR/s_axi] [get_bd_intf_pins ps7_0_axi_periph/M00_AXI]
  connect_bd_intf_net [get_bd_intf_pins channel_mapper/s_axi] -boundary_type upper [get_bd_intf_pins ps7_0_axi_periph/M01_AXI]
  connect_bd_intf_net [get_bd_intf_pins mapping_ram_0/BRAM_PORTA] [get_bd_intf_pins axi_bram_ctrl_0/BRAM_PORTA]
  connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ps7_0_axi_periph/M02_AXI] [get_bd_intf_pins axi_bram_ctrl_0/S_AXI]
  connect_bd_intf_net [get_bd_intf_pins mapping_ram_1/BRAM_PORTA] [get_bd_intf_pins axi_bram_ctrl_1/BRAM_PORTA]
  connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ps7_0_axi_periph/M03_AXI] [get_bd_intf_pins axi_bram_ctrl_1/S_AXI]
  connect_bd_intf_net [get_bd_intf_pins ESS_OpenEVR/o_EVNT_RAM_0] [get_bd_intf_pins mapping_ram_0/BRAM_PORTB]
  connect_bd_intf_net [get_bd_intf_pins ESS_OpenEVR/o_EVNT_RAM_1] [get_bd_intf_pins mapping_ram_1/BRAM_PORTB]

  # Create port connections
  connect_bd_net -net ESS_OpenEVR_o_EVR_EVNT_LED [get_bd_ports o_EVR_EVNT_LED] [get_bd_pins ESS_OpenEVR/o_EVR_EVNT_LED]
  connect_bd_net -net ESS_OpenEVR_o_EVR_LINK_LED [get_bd_ports o_EVR_LINK_LED] [get_bd_pins ESS_OpenEVR/o_EVR_LINK_LED]
  connect_bd_net -net ESS_OpenEVR_o_EVR_TX_N [get_bd_ports o_EVR_TX_N] [get_bd_pins ESS_OpenEVR/o_EVR_TX_N]
  connect_bd_net -net ESS_OpenEVR_o_EVR_TX_P [get_bd_ports o_EVR_TX_P] [get_bd_pins ESS_OpenEVR/o_EVR_TX_P]
  connect_bd_net -net i_EVR_SFP_MOD_0 [get_bd_ports i_EVR_SFP_MOD_0] [get_bd_pins ESS_OpenEVR/i_EVR_MOD_0]
  connect_bd_net -net i_ZYNQ_CLKREF0_N_1 [get_bd_ports i_ZYNQ_CLKREF0_N] [get_bd_pins ESS_OpenEVR/i_ZYNQ_CLKREF0_N]
  connect_bd_net -net i_ZYNQ_CLKREF0_P_0_1 [get_bd_ports i_ZYNQ_CLKREF0_P] [get_bd_pins ESS_OpenEVR/i_ZYNQ_CLKREF0_P]
  connect_bd_net -net ESS_OpenEVR_i_MRCC1_CLK [get_bd_ports i_ZYNQ_MRCC1] [get_bd_pins ESS_OpenEVR/i_ZYNQ_MRCC1]
  connect_bd_net -net ESS_OpenEVR_i_MRCC2_CLK [get_bd_ports i_ZYNQ_MRCC2] [get_bd_pins ESS_OpenEVR/i_DEBUG_clk]
  connect_bd_net -net i_EVR_RX_N_0_1 [get_bd_ports i_EVR_RX_N] [get_bd_pins ESS_OpenEVR/i_EVR_RX_N]
  connect_bd_net -net i_EVR_RX_P_0_1 [get_bd_ports i_EVR_RX_P] [get_bd_pins ESS_OpenEVR/i_EVR_RX_P]
  connect_bd_net -net processing_system7_0_FCLK_CLK0 \
      [get_bd_pins ESS_OpenEVR/s_axi_aclk] [get_bd_pins processing_system7_0/FCLK_CLK0] \
      [get_bd_pins processing_system7_0/M_AXI_GP0_ACLK] [get_bd_pins ps7_0_axi_periph/ACLK] \
      [get_bd_pins ps7_0_axi_periph/M00_ACLK] [get_bd_pins ps7_0_axi_periph/M01_ACLK] \
      [get_bd_pins ps7_0_axi_periph/M02_ACLK] [get_bd_pins ps7_0_axi_periph/M03_ACLK] \
      [get_bd_pins ps7_0_axi_periph/S00_ACLK] [get_bd_pins rst_ps7_0_100M/slowest_sync_clk] \
      [get_bd_pins axi_bram_ctrl_0/s_axi_aclk] [get_bd_pins axi_bram_ctrl_1/s_axi_aclk]
  connect_bd_net -net processing_system7_0_FCLK_RESET0_N [get_bd_pins processing_system7_0/FCLK_RESET0_N] [get_bd_pins rst_ps7_0_100M/ext_reset_in]
  connect_bd_net -net rst_ps7_0_100M_peripheral_aresetn \
      [get_bd_pins ESS_OpenEVR/s_axi_aresetn] [get_bd_pins ps7_0_axi_periph/ARESETN] \
      [get_bd_pins ps7_0_axi_periph/M00_ARESETN] [get_bd_pins ps7_0_axi_periph/M01_ARESETN] \
      [get_bd_pins ps7_0_axi_periph/M02_ARESETN] [get_bd_pins ps7_0_axi_periph/M03_ARESETN] \
      [get_bd_pins ps7_0_axi_periph/S00_ARESETN] [get_bd_pins rst_ps7_0_100M/peripheral_aresetn] \
      [get_bd_pins axi_bram_ctrl_0/s_axi_aresetn] [get_bd_pins axi_bram_ctrl_1/s_axi_aresetn]
  connect_bd_net -net ESS_OpenEVR_i_EVR_TX_FAULT [get_bd_ports i_EVR_TX_FAULT] [get_bd_pins ESS_OpenEVR/i_EVR_TX_FAULT]
  connect_bd_net -net ESS_OpenEVR_i_EVR_RX_LOS [get_bd_ports i_EVR_RX_LOS] [get_bd_pins ESS_OpenEVR/i_EVR_RX_LOS]
  connect_bd_net -net ESS_OpenEVR_o_EVR_TX_DISABLE [get_bd_ports o_EVR_TX_DISABLE] [get_bd_pins ESS_OpenEVR/o_EVR_TX_DISABLE]
  connect_bd_net -net ESS_OpenEVR_o_MRF_UNIVMOD_OUT0 [get_bd_ports o_MRF_UNIVMOD_OUT0] [get_bd_pins ESS_OpenEVR/o_MRF_UNIVMOD_OUT0]
  connect_bd_net -net ESS_OpenEVR_o_MRF_UNIVMOD_OUT1 [get_bd_ports o_MRF_UNIVMOD_OUT1] [get_bd_pins ESS_OpenEVR/o_MRF_UNIVMOD_OUT1]
  connect_bd_net -net ESS_OpenEVR_i_MRF_UNIVMOD_IN0 [get_bd_ports i_MRF_UNIVMOD_IN0] [get_bd_pins ESS_OpenEVR/i_MRF_UNIVMOD_IN0]
  connect_bd_net -net ESS_OpenEVR_i_MRF_UNIVMOD_IN1 [get_bd_ports i_MRF_UNIVMOD_IN1] [get_bd_pins ESS_OpenEVR/i_MRF_UNIVMOD_IN1]
  connect_bd_net -net ESS_OpenEVR_o_IRQ [get_bd_pins ESS_OpenEVR/o_IRQ] [get_bd_pins processing_system7_0/IRQ_F2P]

  # Create port connections for the channel mapper
  connect_bd_net [get_bd_ports i_ZYNQ_MRCC1] [get_bd_pins channel_mapper/i_ref0_clk]
  connect_bd_net [get_bd_pins ESS_OpenEVR/o_EVR_EVENT_CLK] [get_bd_pins channel_mapper/i_ref1_clk]
  connect_bd_net [get_bd_pins channel_mapper/s_axi_aclk] [get_bd_pins processing_system7_0/FCLK_CLK0]
  connect_bd_net [get_bd_pins channel_mapper/s_axi_aresetn] [get_bd_pins rst_ps7_0_100M/peripheral_aresetn]
  connect_bd_net [get_bd_ports b_LEMO_IO] [get_bd_pins channel_mapper/b_phy_ch]
  connect_bd_net [get_bd_ports o_LEMO_DIR] [get_bd_pins channel_mapper/o_phy_ch_dir]
  connect_bd_net [get_bd_pins vinput_concat/In1] [get_bd_pins ESS_OpenEVR/o_FP_OUT]
  connect_bd_net [get_bd_pins GND/dout] [get_bd_pins vinput_concat/In0] [get_bd_pins vinput_concat/In2] [get_bd_pins ESS_OpenEVR/i_TS_req]
  connect_bd_net [get_bd_pins vinput_concat/dout] [get_bd_pins channel_mapper/i_virt_in_ch]
  connect_bd_net [get_bd_pins ch_mapper_rst/dout] [get_bd_pins channel_mapper/i_reset]
  connect_bd_net [get_bd_pins channel_mapper/o_virt_out_ch] [get_bd_pins voutput_slice_0to1/Din]
  connect_bd_net [get_bd_pins voutput_slice_0to1/Dout] [get_bd_pins ESS_OpenEVR/i_FP_IN]

  # Create address segments
  assign_bd_address -offset 0x43C00000 -range 0x00000800 -target_address_space [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs ESS_OpenEVR/s_axi/reg0]
  assign_bd_address -offset 0x43C04000 -range 0x00001000 -target_address_space [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs axi_bram_ctrl_0/S_AXI/Mem0]
  assign_bd_address -offset 0x43C05000 -range 0x00001000 -target_address_space [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs axi_bram_ctrl_1/S_AXI/Mem0]
  assign_bd_address -offset 0x43C10000 -range 0x00000100 -target_address_space [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs channel_mapper/s_axi/reg0]

  # Restore current instance
  current_bd_instance $oldCurInst

  validate_bd_design
  save_bd_design
  close_bd_design $design_name
}
