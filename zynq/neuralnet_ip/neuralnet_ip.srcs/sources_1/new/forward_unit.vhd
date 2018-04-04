-- a single layer that covers matrix product, bias, activation
-- and partial result storage
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.helperpkg.all;

entity forward_unit is
generic (ncols: integer := 400;
         nrows: integer := 100);
port(
    clk: in std_logic;
    alrst: in std_logic;
-- l2 weight memory external interface
    datain_weight: in std_logic_vector (15 downto 0);
    validin_weight: in std_logic;
-- bias memory update channel 
    datain_delta_bias: in std_logic_vector (15 downto 0);
    upden_bias: in std_logic;
-- serial training input
    datain_vector: in std_logic_vector (15 downto 0);
    validin_vector: in std_logic;
-- activated output fifo
    sigmoid_empty: out std_logic;
    sigmoid_data:  out std_logic;
    sigmoid_rden:  in  std_logic;
-- unactivated output fifo
    unactivated_empty: out std_logic;
    unactivated_data:  out std_logic;
    unactivated_rden:  in  std_logic;
-- sigmoid prime fifo
    sigmoid_prime_empty: out std_logic;
    sigmoid_prime_data:  out std_logic;
    sigmoid_prime_rden:  in  std_logic;
-- serial output to the next stage
    dataout_vector: out std_logic_vector (15 downto 0);
    validout_vector: out std_logic
);
end forward_unit;

architecture Behavioral of forward_unit is

begin


end Behavioral;
