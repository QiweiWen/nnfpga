----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.02.2018 12:12:37
-- Design Name: 
-- Module Name: l2_cache_bias - Behavioral
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

entity l2_cache_bias is
    generic (
        nrows: integer := 100
    );
    port (
        clk: in std_logic;
        alrst: in std_logic;
        -- port B, 64 bits
        datain_B: in std_logic_vector (63 downto 0);
        dataout_B: out std_logic_vector (63 downto 0);
        flushout: in std_logic;
        streamin: in std_logic;
        validout_B: out std_logic;
        -- port A, 16 bits
        datain_A: in std_logic_vector (15 downto 0);
        we_A: in std_logic;
        re_A: in std_logic;
        dataout_A: out std_logic_vector (15 downto 0);
        row_A: in integer range nrows - 1 downto 0;
        validout_A: out std_logic
    );
end l2_cache_bias;

architecture Behavioral of l2_cache_bias is
component l2_cache_core is
    generic (
        nrows: integer := 10;
        ncols: integer := 10
    );
    port (
        clk: in std_logic;
        alrst: in std_logic;
        -- port B, 64 bits
        datain_B: in std_logic_vector (63 downto 0);
        dataout_B: out std_logic_vector (63 downto 0);
        flushout: in std_logic;
        streamin: in std_logic;
        validout_B: out std_logic;
        -- port A, 16 bits
        datain_A: in std_logic_vector (15 downto 0);
        we_A: in std_logic;
        re_A: in std_logic;
        dataout_A: out std_logic_vector (15 downto 0);
        row_A: in integer range nrows - 1 downto 0;
        col_A: in integer range ncols - 1 downto 0;
        validout_A: out std_logic
    );
end component l2_cache_core;
begin

    wrapped : l2_cache_core
    generic map (nrows => nrows, ncols => 1)
    port map (clk        => clk,
              alrst      => alrst,
              datain_B   => datain_B,
              dataout_B  => dataout_B,
              flushout   => flushout,
              streamin   => streamin,
              validout_B => validout_B,
              datain_A   => datain_A,
              we_A       => we_A,
              re_A       => re_A,
              dataout_A  => dataout_A,
              row_A      => row_A,
              col_A      => 0,
              validout_A => validout_A);

end Behavioral;
