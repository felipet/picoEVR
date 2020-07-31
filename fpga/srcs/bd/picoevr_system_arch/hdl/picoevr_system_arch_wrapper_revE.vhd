--Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2019.2.1 (lin64) Build 2729669 Thu Dec  5 04:48:12 MST 2019
--Date        : Fri Jul 31 13:50:56 2020
--Host        : ftglaptop running 64-bit Ubuntu 20.04 LTS
--Command     : generate_target picoevr_system_arch_wrapper.bd
--Design      : picoevr_system_arch_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity picoevr_system_arch_wrapper is
  port (
    DDR_addr : inout STD_LOGIC_VECTOR ( 14 downto 0 );
    DDR_ba : inout STD_LOGIC_VECTOR ( 2 downto 0 );
    DDR_cas_n : inout STD_LOGIC;
    DDR_ck_n : inout STD_LOGIC;
    DDR_ck_p : inout STD_LOGIC;
    DDR_cke : inout STD_LOGIC;
    DDR_cs_n : inout STD_LOGIC;
    DDR_dm : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_dq : inout STD_LOGIC_VECTOR ( 31 downto 0 );
    DDR_dqs_n : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_dqs_p : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_odt : inout STD_LOGIC;
    DDR_ras_n : inout STD_LOGIC;
    DDR_reset_n : inout STD_LOGIC;
    DDR_we_n : inout STD_LOGIC;
    FIXED_IO_ddr_vrn : inout STD_LOGIC;
    FIXED_IO_ddr_vrp : inout STD_LOGIC;
    FIXED_IO_mio : inout STD_LOGIC_VECTOR ( 53 downto 0 );
    FIXED_IO_ps_clk : inout STD_LOGIC;
    FIXED_IO_ps_porb : inout STD_LOGIC;
    FIXED_IO_ps_srstb : inout STD_LOGIC;
    dio_clk_n_in_0 : in STD_LOGIC;
    dio_clk_p_in_0 : in STD_LOGIC;
    dio_led_bot_out_0 : out STD_LOGIC;
    dio_led_top_out_0 : out STD_LOGIC;
    dio_n_in_0 : out STD_LOGIC_VECTOR ( 4 downto 0 );
    dio_n_out_0 : in STD_LOGIC_VECTOR ( 4 downto 0 );
    dio_oe_n_out_0 : out STD_LOGIC_VECTOR ( 4 downto 0 );
    dio_onewire_b_0 : inout STD_LOGIC;
    dio_p_in_0 : out STD_LOGIC_VECTOR ( 4 downto 0 );
    dio_p_out_0 : in STD_LOGIC_VECTOR ( 4 downto 0 );
    dio_term_en_out_0 : out STD_LOGIC_VECTOR ( 4 downto 0 );
    i_EVR_RX_N : in STD_LOGIC;
    i_EVR_RX_P : in STD_LOGIC;
    i_ZYNQ_CLKREF0_N : in STD_LOGIC;
    i_ZYNQ_CLKREF0_P : in STD_LOGIC;
    i_ZYNQ_MRCC1 : in STD_LOGIC;
    i_ZYNQ_MRCC2 : in STD_LOGIC;
    o_EVR_EVNT_LED : out STD_LOGIC_VECTOR ( 0 to 0 );
    o_EVR_LINK_LED : out STD_LOGIC_VECTOR ( 0 to 0 );
    o_EVR_TX_N : out STD_LOGIC;
    o_EVR_TX_P : out STD_LOGIC
  );
end picoevr_system_arch_wrapper;

architecture STRUCTURE of picoevr_system_arch_wrapper is
  component picoevr_system_arch is
  port (
    dio_clk_n_in_0 : in STD_LOGIC;
    dio_clk_p_in_0 : in STD_LOGIC;
    dio_led_bot_out_0 : out STD_LOGIC;
    dio_led_top_out_0 : out STD_LOGIC;
    dio_n_in_0 : out STD_LOGIC_VECTOR ( 4 downto 0 );
    dio_n_out_0 : in STD_LOGIC_VECTOR ( 4 downto 0 );
    dio_oe_n_out_0 : out STD_LOGIC_VECTOR ( 4 downto 0 );
    dio_onewire_b_0 : inout STD_LOGIC;
    dio_p_in_0 : out STD_LOGIC_VECTOR ( 4 downto 0 );
    dio_p_out_0 : in STD_LOGIC_VECTOR ( 4 downto 0 );
    dio_term_en_out_0 : out STD_LOGIC_VECTOR ( 4 downto 0 );
    i_EVR_RX_N : in STD_LOGIC;
    i_EVR_RX_P : in STD_LOGIC;
    i_ZYNQ_CLKREF0_N : in STD_LOGIC;
    i_ZYNQ_CLKREF0_P : in STD_LOGIC;
    o_EVR_EVNT_LED : out STD_LOGIC_VECTOR ( 0 to 0 );
    o_EVR_LINK_LED : out STD_LOGIC_VECTOR ( 0 to 0 );
    o_EVR_TX_N : out STD_LOGIC;
    o_EVR_TX_P : out STD_LOGIC;
    FIXED_IO_mio : inout STD_LOGIC_VECTOR ( 53 downto 0 );
    FIXED_IO_ddr_vrn : inout STD_LOGIC;
    FIXED_IO_ddr_vrp : inout STD_LOGIC;
    FIXED_IO_ps_srstb : inout STD_LOGIC;
    FIXED_IO_ps_clk : inout STD_LOGIC;
    FIXED_IO_ps_porb : inout STD_LOGIC;
    DDR_cas_n : inout STD_LOGIC;
    DDR_cke : inout STD_LOGIC;
    DDR_ck_n : inout STD_LOGIC;
    DDR_ck_p : inout STD_LOGIC;
    DDR_cs_n : inout STD_LOGIC;
    DDR_reset_n : inout STD_LOGIC;
    DDR_odt : inout STD_LOGIC;
    DDR_ras_n : inout STD_LOGIC;
    DDR_we_n : inout STD_LOGIC;
    DDR_ba : inout STD_LOGIC_VECTOR ( 2 downto 0 );
    DDR_addr : inout STD_LOGIC_VECTOR ( 14 downto 0 );
    DDR_dm : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_dq : inout STD_LOGIC_VECTOR ( 31 downto 0 );
    DDR_dqs_n : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_dqs_p : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    i_ZYNQ_MRCC2 : in STD_LOGIC;
    i_ZYNQ_MRCC1 : in STD_LOGIC
  );
  end component picoevr_system_arch;
begin
picoevr_system_arch_i: component picoevr_system_arch
     port map (
      DDR_addr(14 downto 0) => DDR_addr(14 downto 0),
      DDR_ba(2 downto 0) => DDR_ba(2 downto 0),
      DDR_cas_n => DDR_cas_n,
      DDR_ck_n => DDR_ck_n,
      DDR_ck_p => DDR_ck_p,
      DDR_cke => DDR_cke,
      DDR_cs_n => DDR_cs_n,
      DDR_dm(3 downto 0) => DDR_dm(3 downto 0),
      DDR_dq(31 downto 0) => DDR_dq(31 downto 0),
      DDR_dqs_n(3 downto 0) => DDR_dqs_n(3 downto 0),
      DDR_dqs_p(3 downto 0) => DDR_dqs_p(3 downto 0),
      DDR_odt => DDR_odt,
      DDR_ras_n => DDR_ras_n,
      DDR_reset_n => DDR_reset_n,
      DDR_we_n => DDR_we_n,
      FIXED_IO_ddr_vrn => FIXED_IO_ddr_vrn,
      FIXED_IO_ddr_vrp => FIXED_IO_ddr_vrp,
      FIXED_IO_mio(53 downto 0) => FIXED_IO_mio(53 downto 0),
      FIXED_IO_ps_clk => FIXED_IO_ps_clk,
      FIXED_IO_ps_porb => FIXED_IO_ps_porb,
      FIXED_IO_ps_srstb => FIXED_IO_ps_srstb,
      dio_clk_n_in_0 => dio_clk_n_in_0,
      dio_clk_p_in_0 => dio_clk_p_in_0,
      dio_led_bot_out_0 => dio_led_bot_out_0,
      dio_led_top_out_0 => dio_led_top_out_0,
      dio_n_in_0(4 downto 0) => dio_n_in_0(4 downto 0),
      dio_n_out_0(4 downto 0) => dio_n_out_0(4 downto 0),
      dio_oe_n_out_0(4 downto 0) => dio_oe_n_out_0(4 downto 0),
      dio_onewire_b_0 => dio_onewire_b_0,
      dio_p_in_0(4 downto 0) => dio_p_in_0(4 downto 0),
      dio_p_out_0(4 downto 0) => dio_p_out_0(4 downto 0),
      dio_term_en_out_0(4 downto 0) => dio_term_en_out_0(4 downto 0),
      i_EVR_RX_N => i_EVR_RX_N,
      i_EVR_RX_P => i_EVR_RX_P,
      i_ZYNQ_CLKREF0_N => i_ZYNQ_CLKREF0_N,
      i_ZYNQ_CLKREF0_P => i_ZYNQ_CLKREF0_P,
      i_ZYNQ_MRCC1 => i_ZYNQ_MRCC1,
      i_ZYNQ_MRCC2 => i_ZYNQ_MRCC2,
      o_EVR_EVNT_LED(0) => o_EVR_EVNT_LED(0),
      o_EVR_LINK_LED(0) => o_EVR_LINK_LED(0),
      o_EVR_TX_N => o_EVR_TX_N,
      o_EVR_TX_P => o_EVR_TX_P
    );
end STRUCTURE;
