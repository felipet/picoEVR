--Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2019.2 (lin64) Build 2708876 Wed Nov  6 21:39:14 MST 2019
--Date        : Thu Jun 18 14:37:57 2020
--Host        : ci0020722 running 64-bit Debian GNU/Linux 10 (buster)
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

    i_EVR_RX_N : in STD_LOGIC;
    i_EVR_RX_P : in STD_LOGIC;
    i_SY87730_LOCKED : in STD_LOGIC;
    i_ZYNQ_CLKREF0_N : in STD_LOGIC;
    i_ZYNQ_CLKREF0_P : in STD_LOGIC;
    i_ZYNQ_MRCC_LVDS_N : in STD_LOGIC;
    i_ZYNQ_MRCC_LVDS_P : in STD_LOGIC;
    o_EVR_ENABLE : out STD_LOGIC_VECTOR ( 0 to 0 );
    o_EVR_EVNT_LED : out STD_LOGIC_VECTOR ( 0 to 0 );
    o_EVR_LINK_LED : out STD_LOGIC_VECTOR ( 0 to 0 );
    o_EVR_TX_N : out STD_LOGIC;
    o_EVR_TX_P : out STD_LOGIC;
    o_SI5346_RST_rn : out STD_LOGIC_VECTOR ( 0 to 0 );
    o_SY87730_PROGCS : out STD_LOGIC_VECTOR ( 0 to 0 );
    o_SY87730_PROGDI : out STD_LOGIC;
    o_SY87730_PROGSK : out STD_LOGIC;

    -- EtherCAT slave ports
    clk25_clk_n : in STD_LOGIC;
    clk25_clk_p : in STD_LOGIC;

    prom_data_io : inout STD_LOGIC;

    mii_rx_clk0_i : in STD_LOGIC;
    mii_rx_dv0_i : in STD_LOGIC;
    mii_rx_data0_i : in STD_LOGIC_VECTOR ( 3 downto 0 );
    mii_rx_err0_i : in STD_LOGIC;

    mii_rx_clk1_i : in STD_LOGIC;
    mii_rx_dv1_i : in STD_LOGIC;
    mii_rx_data1_i : in STD_LOGIC_VECTOR ( 3 downto 0 );
    mii_rx_err1_i : in STD_LOGIC;

    phy0_an1_i : in STD_LOGIC;
    phy0_an2_i : in STD_LOGIC;
    phy0_an_en_i : in STD_LOGIC;

    phy1_an1_i : in STD_LOGIC;
    phy1_an2_i : in STD_LOGIC;
    phy1_an_en_i : in STD_LOGIC;

    sw_strap2_o : out STD_LOGIC_VECTOR ( 0 to 0 );
    sw_strap1_o : out STD_LOGIC_VECTOR ( 0 to 0 );
    phy_pwdn1_o : out STD_LOGIC_VECTOR ( 0 to 0 );
    phy_pwdn2_o : out STD_LOGIC_VECTOR ( 0 to 0 );

    prom_clk_o : out STD_LOGIC;

    led_link_act_o : out STD_LOGIC_VECTOR ( 1 downto 0 );

    mii_tx_en0_o : out STD_LOGIC;
    mii_tx_data0_o : out STD_LOGIC_VECTOR ( 3 downto 0 );
    mii_tx_clk0_i : in STD_LOGIC;
    mii_tx_en1_o : out STD_LOGIC;
    mii_tx_data1_o : out STD_LOGIC_VECTOR ( 3 downto 0 );
    mii_tx_clk1_i : in STD_LOGIC;

    led_run_o : out STD_LOGIC;
    led_err_o : out STD_LOGIC;
    fmc_clk_en_o : out STD_LOGIC_VECTOR ( 0 to 0 );
    nreset_out : out STD_LOGIC
  );
end picoevr_system_arch_wrapper;

architecture STRUCTURE of picoevr_system_arch_wrapper is
  component picoevr_system_arch is
  port (
    i_EVR_RX_N : in STD_LOGIC;
    i_EVR_RX_P : in STD_LOGIC;
    i_SY87730_LOCKED : in STD_LOGIC;
    i_ZYNQ_CLKREF0_N : in STD_LOGIC;
    i_ZYNQ_CLKREF0_P : in STD_LOGIC;
    i_ZYNQ_MRCC_LVDS_N : in STD_LOGIC;
    i_ZYNQ_MRCC_LVDS_P : in STD_LOGIC;
    o_EVR_ENABLE : out STD_LOGIC_VECTOR ( 0 to 0 );
    o_EVR_EVNT_LED : out STD_LOGIC_VECTOR ( 0 to 0 );
    o_EVR_LINK_LED : out STD_LOGIC_VECTOR ( 0 to 0 );
    o_EVR_TX_N : out STD_LOGIC;
    o_EVR_TX_P : out STD_LOGIC;
    o_SY87730_PROGCS : out STD_LOGIC_VECTOR ( 0 to 0 );
    o_SY87730_PROGDI : out STD_LOGIC;
    o_SY87730_PROGSK : out STD_LOGIC;
    o_SI5346_RST_rn : out STD_LOGIC_VECTOR ( 0 to 0 );
    mii_rx_clk0_i : in STD_LOGIC;
    mii_rx_dv0_i : in STD_LOGIC;
    mii_rx_data0_i : in STD_LOGIC_VECTOR ( 3 downto 0 );
    mii_rx_err0_i : in STD_LOGIC;
    mii_rx_dv1_i : in STD_LOGIC;
    mii_rx_clk1_i : in STD_LOGIC;
    mii_rx_data1_i : in STD_LOGIC_VECTOR ( 3 downto 0 );
    mii_rx_err1_i : in STD_LOGIC;
    mii_tx_clk1_i : in STD_LOGIC;
    mii_tx_clk0_i : in STD_LOGIC;
    led_run_o : out STD_LOGIC;
    led_err_o : out STD_LOGIC;
    led_link_act_o : out STD_LOGIC_VECTOR ( 1 downto 0 );
    mii_tx_en1_o : out STD_LOGIC;
    mii_tx_data0_o : out STD_LOGIC_VECTOR ( 3 downto 0 );
    mii_tx_en0_o : out STD_LOGIC;
    mii_tx_data1_o : out STD_LOGIC_VECTOR ( 3 downto 0 );
    phy0_an1_i : in STD_LOGIC;
    phy0_an2_i : in STD_LOGIC;
    phy0_an_en_i : in STD_LOGIC;
    phy1_an1_i : in STD_LOGIC;
    phy1_an2_i : in STD_LOGIC;
    phy1_an_en_i : in STD_LOGIC;
    prom_clk_o : out STD_LOGIC;
    FIXED_IO_mio : inout STD_LOGIC_VECTOR ( 53 downto 0 );
    FIXED_IO_ddr_vrn : inout STD_LOGIC;
    FIXED_IO_ddr_vrp : inout STD_LOGIC;
    FIXED_IO_ps_srstb : inout STD_LOGIC;
    FIXED_IO_ps_clk : inout STD_LOGIC;
    FIXED_IO_ps_porb : inout STD_LOGIC;
    clk25_clk_n : in STD_LOGIC;
    clk25_clk_p : in STD_LOGIC;
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
    fmc_clk_en_o : out STD_LOGIC_VECTOR ( 0 to 0 );
    phy_pwdn1_o : out STD_LOGIC_VECTOR ( 0 to 0 );
    phy_pwdn2_o : out STD_LOGIC_VECTOR ( 0 to 0 );
    sw_strap1_o : out STD_LOGIC_VECTOR ( 0 to 0 );
    sw_strap2_o : out STD_LOGIC_VECTOR ( 0 to 0 );
    nreset_out : out STD_LOGIC;
    prom_data_ena : out STD_LOGIC;
    prom_data_in : in STD_LOGIC;
    prom_data_out : out STD_LOGIC
  );
  end component picoevr_system_arch;

  signal s_prom_data_out, s_prom_data_ena : std_logic;

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
      clk25_clk_n => clk25_clk_n,
      clk25_clk_p => clk25_clk_p,
      fmc_clk_en_o(0) => fmc_clk_en_o(0),
      i_EVR_RX_N => i_EVR_RX_N,
      i_EVR_RX_P => i_EVR_RX_P,
      i_SY87730_LOCKED => i_SY87730_LOCKED,
      i_ZYNQ_CLKREF0_N => i_ZYNQ_CLKREF0_N,
      i_ZYNQ_CLKREF0_P => i_ZYNQ_CLKREF0_P,
      i_ZYNQ_MRCC_LVDS_N => i_ZYNQ_MRCC_LVDS_N,
      i_ZYNQ_MRCC_LVDS_P => i_ZYNQ_MRCC_LVDS_P,
      led_err_o => led_err_o,
      led_link_act_o(1 downto 0) => led_link_act_o(1 downto 0),
      led_run_o => led_run_o,
      mii_rx_clk0_i => mii_rx_clk0_i,
      mii_rx_clk1_i => mii_rx_clk1_i,
      mii_rx_data0_i(3 downto 0) => mii_rx_data0_i(3 downto 0),
      mii_rx_data1_i(3 downto 0) => mii_rx_data1_i(3 downto 0),
      mii_rx_dv0_i => mii_rx_dv0_i,
      mii_rx_dv1_i => mii_rx_dv1_i,
      mii_rx_err0_i => mii_rx_err0_i,
      mii_rx_err1_i => mii_rx_err1_i,
      mii_tx_clk0_i => mii_tx_clk0_i,
      mii_tx_clk1_i => mii_tx_clk1_i,
      mii_tx_data0_o(3 downto 0) => mii_tx_data0_o(3 downto 0),
      mii_tx_data1_o(3 downto 0) => mii_tx_data1_o(3 downto 0),
      mii_tx_en0_o => mii_tx_en0_o,
      mii_tx_en1_o => mii_tx_en1_o,
      nreset_out => nreset_out,
      o_EVR_ENABLE(0) => o_EVR_ENABLE(0),
      o_EVR_EVNT_LED(0) => o_EVR_EVNT_LED(0),
      o_EVR_LINK_LED(0) => o_EVR_LINK_LED(0),
      o_EVR_TX_N => o_EVR_TX_N,
      o_EVR_TX_P => o_EVR_TX_P,
      o_SI5346_RST_rn(0) => o_SI5346_RST_rn(0),
      o_SY87730_PROGCS(0) => o_SY87730_PROGCS(0),
      o_SY87730_PROGDI => o_SY87730_PROGDI,
      o_SY87730_PROGSK => o_SY87730_PROGSK,
      phy0_an1_i => phy0_an1_i,
      phy0_an2_i => phy0_an2_i,
      phy0_an_en_i => phy0_an_en_i,
      phy1_an1_i => phy1_an1_i,
      phy1_an2_i => phy1_an2_i,
      phy1_an_en_i => phy1_an_en_i,
      phy_pwdn1_o(0) => phy_pwdn1_o(0),
      phy_pwdn2_o(0) => phy_pwdn2_o(0),
      prom_clk_o => prom_clk_o,
      prom_data_ena => s_prom_data_ena,
      prom_data_in => prom_data_io,
      prom_data_out => s_prom_data_out,
      sw_strap1_o(0) => sw_strap1_o(0),
      sw_strap2_o(0) => sw_strap2_o(0)
    );

    prom_data_io <= s_prom_data_out when s_prom_data_ena = '1' else 'Z';

end STRUCTURE;
