--Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2019.2 (lin64) Build 2708876 Wed Nov  6 21:39:14 MST 2019
--Date        : Wed Dec  2 17:15:29 2020
--Host        : OptiPlex running 64-bit Ubuntu 20.04.1 LTS
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
    b_LEMO_IO : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    i_EVR_RX_LOS : in STD_LOGIC;
    i_EVR_RX_N : in STD_LOGIC;
    i_EVR_RX_P : in STD_LOGIC;
    i_EVR_SFP_MOD_0 : in STD_LOGIC;
    i_EVR_TX_FAULT : in STD_LOGIC;
    i_MRF_UNIVMOD_IN0 : in STD_LOGIC;
    i_MRF_UNIVMOD_IN1 : in STD_LOGIC;
    i_ZYNQ_CLKREF0_N : in STD_LOGIC;
    i_ZYNQ_CLKREF0_P : in STD_LOGIC;
    i_ZYNQ_MRCC1 : in STD_LOGIC;
    i_ZYNQ_MRCC2 : in STD_LOGIC;
    o_EVR_EVNT_LED : out STD_LOGIC;
    o_EVR_LINK_LED : out STD_LOGIC;
    o_EVR_TX_DISABLE : out STD_LOGIC;
    o_EVR_TX_N : out STD_LOGIC;
    o_EVR_TX_P : out STD_LOGIC;
    o_LEMO_DIR : out STD_LOGIC_VECTOR ( 3 downto 0 );
    o_MRF_UNIVMOD_OUT0 : out STD_LOGIC;
    o_MRF_UNIVMOD_OUT1 : out STD_LOGIC
  );
end picoevr_system_arch_wrapper;

architecture STRUCTURE of picoevr_system_arch_wrapper is
  component picoevr_system_arch is
  port (
    i_EVR_RX_N : in STD_LOGIC;
    i_EVR_RX_P : in STD_LOGIC;
    i_EVR_SFP_MOD_0 : in STD_LOGIC;
    i_ZYNQ_CLKREF0_N : in STD_LOGIC;
    i_ZYNQ_CLKREF0_P : in STD_LOGIC;
    i_ZYNQ_MRCC1 : in STD_LOGIC;
    i_ZYNQ_MRCC2 : in STD_LOGIC;
    o_EVR_EVNT_LED : out STD_LOGIC;
    o_EVR_LINK_LED : out STD_LOGIC;
    o_EVR_TX_N : out STD_LOGIC;
    o_EVR_TX_P : out STD_LOGIC;
    o_EVR_TX_DISABLE : out STD_LOGIC;
    o_LEMO_DIR : out STD_LOGIC_VECTOR ( 3 downto 0 );
    i_EVR_TX_FAULT : in STD_LOGIC;
    i_EVR_RX_LOS : in STD_LOGIC;
    o_MRF_UNIVMOD_OUT0 : out STD_LOGIC;
    o_MRF_UNIVMOD_OUT1 : out STD_LOGIC;
    i_MRF_UNIVMOD_IN0 : in STD_LOGIC;
    i_MRF_UNIVMOD_IN1 : in STD_LOGIC;
    b_LEMO_IO : inout STD_LOGIC_VECTOR ( 3 downto 0 );
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
    FIXED_IO_mio : inout STD_LOGIC_VECTOR ( 53 downto 0 );
    FIXED_IO_ddr_vrn : inout STD_LOGIC;
    FIXED_IO_ddr_vrp : inout STD_LOGIC;
    FIXED_IO_ps_srstb : inout STD_LOGIC;
    FIXED_IO_ps_clk : inout STD_LOGIC;
    FIXED_IO_ps_porb : inout STD_LOGIC
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
      b_LEMO_IO(3 downto 0) => b_LEMO_IO(3 downto 0),
      i_EVR_RX_LOS => i_EVR_RX_LOS,
      i_EVR_RX_N => i_EVR_RX_N,
      i_EVR_RX_P => i_EVR_RX_P,
      i_EVR_SFP_MOD_0 => i_EVR_SFP_MOD_0,
      i_EVR_TX_FAULT => i_EVR_TX_FAULT,
      i_MRF_UNIVMOD_IN0 => i_MRF_UNIVMOD_IN0,
      i_MRF_UNIVMOD_IN1 => i_MRF_UNIVMOD_IN1,
      i_ZYNQ_CLKREF0_N => i_ZYNQ_CLKREF0_N,
      i_ZYNQ_CLKREF0_P => i_ZYNQ_CLKREF0_P,
      i_ZYNQ_MRCC1 => i_ZYNQ_MRCC1,
      i_ZYNQ_MRCC2 => i_ZYNQ_MRCC2,
      o_EVR_EVNT_LED => o_EVR_EVNT_LED,
      o_EVR_LINK_LED => o_EVR_LINK_LED,
      o_EVR_TX_DISABLE => o_EVR_TX_DISABLE,
      o_EVR_TX_N => o_EVR_TX_N,
      o_EVR_TX_P => o_EVR_TX_P,
      o_LEMO_DIR(3 downto 0) => o_LEMO_DIR(3 downto 0),
      o_MRF_UNIVMOD_OUT0 => o_MRF_UNIVMOD_OUT0,
      o_MRF_UNIVMOD_OUT1 => o_MRF_UNIVMOD_OUT1
    );
end STRUCTURE;
