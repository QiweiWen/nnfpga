----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06.02.2018 21:25:46
-- Design Name: 
-- Module Name: param_feeder - Behavioral
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

entity param_feeder is
generic map(
    ncols: integer := 10
);
port (
    clk: in std_logic;
    alrst: in std_logic;
-- input data, either from the last unit or
-- directly from L2 cache
    datain: in std_logic_vector (15 downto 0);
    validin: in std_logic;
-- data forwarded to the next row feeder
    datafwd: out std_logic_vector (15 downto 0);
    validfwd: out std_logic;
-- data passed to the row processor    
    dataout: out std_logic_vector (15 downto 0);
    validout: out std_logic;
-- flag passed to the last row feeder
    full : out std_logic;
-- flag passed from the next row feeder
    slave_full: in std_logic
);
end param_feeder;

architecture Behavioral of param_feeder is

-- finished filling the cache of this row processor
signal sig_full: std_logic;
-- how many words we've forwarded to the row processor
signal nwords_written: integer range ncols downto 0;
-- whether new data is forwarded downwards or into the row processor
signal keep_datain: std_logic;

begin


end Behavioral;
