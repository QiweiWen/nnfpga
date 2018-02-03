----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.02.2018 21:56:29
-- Design Name: 
-- Module Name: row_processor - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.helperpkg.all;
use work.nn_arith_package.all;
library ieee_proposed;
use ieee_proposed.fixed_pkg.all;
use ieee.math_real.all;

entity row_processor is
generic (
    ncols: integer := 100
);
port(
    clk: in std_logic;
    alrst: in std_logic;
-- l1 cache input channel
    l1_re: out std_logic;
    l1_datain: in std_logic_vector (15 downto 0);
    l1_validin: in std_logic;
-- vector input channel
    ve_datain: in std_logic_vector (15 downto 0);
    ve_validin: in std_logic;
-- product terms output channel
    dataout: out std_logic_vector (15 downto 0);
    validout: out std_logic;
    -- this flags that all the products that
    -- will sum to a vector element have been computed
    finished: out std_logic; 
-- signals forwarded to the adjacent row processor down the line
    validfwd: out std_logic;
    datafwd: out std_logic_vector (15 downto 0)
);
end row_processor;

architecture Behavioral of row_processor is

component delay_buffer is
    generic(
        ncycles: integer;
        width:   integer
    );
    port(
        clk: in std_logic;
        rst: in std_logic;
        din: in std_logic_vector (width - 1 downto 0);
        dout: out std_logic_vector (width - 1 downto 0)
    );
end component delay_buffer;
signal ve_datain_delayed: std_logic_vector (15 downto 0);

begin
-- will read parameters from cache 
-- as long as we are asked to compute stuff?
l1_re <= ve_validin;
-- pass stuff to the next PE down the line
fwd_proc:
process (clk, alrst) is
begin
    if (rising_edge(clk)) then
        if (alrst = '0') then
            datafwd <= (others => '0');
            validfwd <= '0';
        else
            datafwd <= ve_datain;
            validfwd <= ve_validin;
        end if;
    end if;
end process;

-- delay vector input to make up for l1 cache latency
vector_input_delay: delay_buffer
generic map(
    width => 16,
    ncycles => 2
)
port map (
    clk => clk,
    rst => alrst,
    din => ve_datain, 
    dout => ve_datain_delayed
);

-- TODO: multiply and truncate ve_datain_delayed and l1_datain
-- use l1_validin to keep track of current column
-- delay current column to drive "finished"

end Behavioral;
