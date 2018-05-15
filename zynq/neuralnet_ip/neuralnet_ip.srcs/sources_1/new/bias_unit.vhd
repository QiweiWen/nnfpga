library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.helperpkg.all;
use work.nn_arith_package.all;
library ieee_proposed;
use ieee_proposed.fixed_pkg.all;
use ieee.math_real.all;


-- single bias unit for forward propagation row processors
entity bias_unit is
port (
    clk: in std_logic;
    alrst: in std_logic;
    unbiased: in std_logic_vector (15 downto 0);
    biased : out std_logic_vector (15 downto 0)
);
end bias_unit;

architecture Behavioral of bias_unit is

begin


end Behavioral;
