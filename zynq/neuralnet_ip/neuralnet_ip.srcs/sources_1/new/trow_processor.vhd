-- Whatever on earth is a "trow", you ask?
-- a Transpose ROW.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.helperpkg.all;
use work.nn_arith_package.all;
library ieee_proposed;
use ieee_proposed.fixed_pkg.all;
use ieee.math_real.all;

-- preserve all row processor ports
-- add duplicated aL-1 input, weight memory write ports
-- and zL-1 FIFO input
entity trow_processor is
generic (
    ncols: integer := 100
);
port(
    clk: in std_logic;
    alrst: in std_logic;
-- delta vector input channel
    dl_datain: in std_logic_vector (15 downto 0);
    dl_validin: in std_logic;
    dl_ack     : in std_logic;
    dl_req     : out std_logic;
-- product terms output channel
    deltaout: out std_logic_vector (15 downto 0);
    validout: out std_logic;
-- vector input forwarded to the adjacent row processor down the line
    validfwd: out std_logic;
    deltafwd: out std_logic_vector (15 downto 0);
-- weight memory read ports 
    l1_rden: out std_logic;
    l1_raddr: out integer range 0 to ncols - 1; 
    l1_din : in std_logic_vector (15 downto 0);
    l1_vin : in std_logic;
-- weight memory write ports
    l1_wren: out std_logic;
    l1_waddr: out integer range 0 to ncols - 1;
    l1_wdata: out std_logic_vector (15 downto 0);
-- aL-1 input for derivative calculation
    all1_datain: in std_logic_vector (15 downto 0);
    all1_validin: in std_logic;
    all1_req: out std_logic;
-- zL-1 input for backprop
    zll1_datain: in std_logic_vector (15 downto 0);
    zll1_validin: in std_logic;
    zll1_req: out std_logic
);
end trow_processor;

architecture Behavioral of trow_processor is

-- dl and l1 are shared between row processor
-- and derivative unit
signal dl_req_backprop: std_logic;
signal dl_req_derivative: std_logic;
signal sig_l1_rden : std_logic;
-- i.e. product almost ready, fetch last level
-- unactivated output right now
-- multiplication result
signal prod_dout: std_logic_vector (31 downto 0);
signal prod_vout: std_logic;
signal delta_validout_next: std_logic;
signal dll1_full: std_logic_vector (47 downto 0);
subtype dll1_full_t is std_logic_vector (47 downto 0);

component row_processor is
generic (
    ncols: integer := 100
);
port(
    clk: in std_logic;
    alrst: in std_logic;
-- l1 cache external interface
    l1_rden: out std_logic;
    l1_raddr: out integer range 0 to ncols - 1; 
    l1_din : in std_logic_vector (15 downto 0);
    l1_vin : in std_logic;
-- vector input channel
    ve_datain: in std_logic_vector (15 downto 0);
    ve_validin: in std_logic;
    ve_ack     : in std_logic;
    ve_req     : out std_logic;
-- product terms output channel
    dataout: out std_logic_vector (31 downto 0);
    validout: out std_logic;
    fvalid: out std_logic;
-- vector input forwarded to the adjacent row processor down the line
    validfwd: out std_logic;
    datafwd: out std_logic_vector (15 downto 0)
);
end component row_processor;
begin
    dl_req <= '1' when dl_req_backprop = '1' and
                       dl_req_derivative = '1' else '0'; 
    l1_rden <= sig_l1_rden;
    -- TODO:
    -- stops synthesis tool from being a cunt
    -- remove later
    dl_req_derivative <= '1';

    backprop: row_processor
    generic map (ncols => ncols)
    port map (
        clk         => clk,
        alrst       => alrst,
        l1_rden     => sig_l1_rden,
        l1_raddr    => l1_raddr,
        l1_din      => l1_din,
        l1_vin      => l1_vin,
        ve_datain   => dl_datain,
        ve_validin  => dl_validin,
        ve_ack      => dl_ack,
        ve_req      => dl_req_backprop,
        dataout     => prod_dout,
        validout    => prod_vout,
        fvalid      => zll1_req,
        validfwd    => validfwd,
        datafwd     => deltafwd
    );
    -- drive deltaout and validout 
    dll1_full <= dll1_full_t (to_sfixed (prod_dout, 2*PARAM_DEC - 1, -2*PARAM_FRC) *
                              to_sfixed (zll1_datain, PARAM_DEC - 1, -PARAM_FRC));
    validout <= '1' when zll1_validin = '1' and prod_vout = '1' else '0';
    deltaout <= dll1_full (PARAM_FRC * 3 + PARAM_DEC - 1 downto 2*PARAM_FRC);
   
end Behavioral;
