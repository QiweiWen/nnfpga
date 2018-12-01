library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.helperpkg.all;
use work.nn_arith_package.all;
library ieee_proposed;
use work.fixed_pkg.all;
use ieee.math_real.all;

entity tb_row_processor is
end tb_row_processor;

architecture tb of tb_row_processor is

component row_processor is
generic (
    ncols: natural := 100
);
port(
    clk: in std_logic;
    alrst: in std_logic;
    ready    : out std_logic;
-- wram cache external interface
    wram_rden: out std_logic;
    wram_din : in std_logic_vector (15 downto 0);
    wram_vin : in std_logic;
    wram_rdy : in std_logic;
-- vector input channel
    ve_datain: in std_logic_vector (15 downto 0);
    ve_validin: in std_logic;
-- product terms output channel
    dataout: out std_logic_vector (31 downto 0);
    validout: out std_logic;
    fvalid: out std_logic;
-- vector input forwarded to the adjacent row processor down the line
    validfwd: out std_logic;
    datafwd: out std_logic_vector (15 downto 0)
);
end component row_processor;

component weight_memory is
    generic (
        depth : natural := 128
    );
    port
    (
        clk : in std_logic;
        alrst : in std_logic;
        rdy : out std_logic;
        -- forward read port
        re_fwd: in std_logic;
        vout_fwd : out std_logic;
        dout_fwd : out std_logic_vector(15 downto 0);
        -- backward read port
        re_bkwd: in std_logic;
        vout_bkwd : out std_logic;
        dout_bkwd : out std_logic_vector(15 downto 0);
        -- backward write port
        we_bkwd : in std_logic;
        din_bkwd : in std_logic_vector(15 downto 0);
        waddr_bkwd : in natural range 0 to depth - 1;
        -- ports for parameter sideload
        ps_load : in std_logic;
        ps_we : in std_logic;
        ps_re : in std_logic;
        ps_addr : in natural range 0 to depth - 1;
        ps_din : in std_logic_vector(15 downto 0);
        ps_dout : out std_logic_vector(15 downto 0);
        ps_vout : out std_logic
    );
end component weight_memory;

begin


end tb;
