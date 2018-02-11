----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.02.2018 12:03:13
-- Design Name: 
-- Module Name: bias_cache - Behavioral
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
use work.helperpkg.all;

entity bias_cache is
generic (
    nrows: integer := 10
);
port (
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
end bias_cache;

architecture Behavioral of bias_cache is

begin


end Behavioral;
