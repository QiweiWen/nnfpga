library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.helperpkg.all;
use work.nn_arith_package.all;
library ieee_proposed;
use ieee_proposed.fixed_pkg.all;
use ieee.math_real.all;

entity column_processor is
generic (
    nrows: integer := 100
);
port(
    clk: in std_logic;
    alrst: in std_logic;
-- l1 cache external interface
    l1_rden: out std_logic;
    l1_raddr: out integer range 0 to nrows - 1; 
    l1_din : in std_logic_vector (15 downto 0);
    l1_vin : in std_logic;
-- vector element input channel
    ve_datain: in std_logic_vector (15 downto 0);
    ve_validin: in std_logic;
    ready     : out std_logic;
-- (partial) result accumulation output to the next column processor
    validfwd: out std_logic;
    datafwd: out std_logic_vector (15 downto 0)
);
end column_processor;

architecture Behavioral of column_processor is

begin


end Behavioral;
