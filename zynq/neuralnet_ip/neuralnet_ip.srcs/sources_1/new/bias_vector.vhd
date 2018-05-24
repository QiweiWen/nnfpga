library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.helperpkg.all;
use work.nn_arith_package.all;
library ieee_proposed;
use ieee_proposed.fixed_pkg.all;
use ieee.math_real.all;

entity bias_vector is
generic (nrows: integer := 100);
port (
    clk: in std_logic;
-- product vector from column vectors
    unbiased: in std_logic_vector (31 downto 0);
    vin:  in std_logic;
-- result with biased added
-- goes to sigmoid unit and fifos
    biased: out std_logic_vector (15 downto 0);
    vout: out std_logic;
-- bias update channel from delta fifo
    updated: in std_logic_vector (15 downto 0);
    uvin: in std_logic
);
end bias_vector;

architecture Behavioral of bias_vector is

signal unbiased_truncated: std_logic_vector (15 downto 0);
signal unbiased_delayed: std_logic_vector (15 downto 0);

signal vin_pipe: std_logic;
signal vin_align: std_logic;

signal biased_full: std_logic_vector (16 downto 0);
signal dout_a : std_logic_vector (15 downto 0);

begin

end Behavioral;
