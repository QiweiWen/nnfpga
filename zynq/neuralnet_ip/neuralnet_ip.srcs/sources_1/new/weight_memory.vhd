----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.01.2018 18:23:42
-- Design Name: 
-- Module Name: weight_memory - Behavioral
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

-- A wrapper over the blockram unit that holds the matrix weights for a single layer
entity weight_memory is
generic (
    nrows: integer;
    ncols: integer
);
port (
    clk: in std_logic;
    alrst: in std_logic;
    flush: in std_logic;
    datain: in std_logic_vector (63 downto 0);
    validin: in std_logic;
    dataout: out std_logic_vector (15 downto 0);
    validout: out std_logic
);
end weight_memory;

architecture Behavioral of weight_memory is
    constant nwords: integer
        := integer (ceil (real(ncols * nrows)/real(4)));
    type memarray_t is array (nwords - 1 downto 0) of
        std_logic_vector (63 downto 0);
    signal read_ptr: integer  range nwords - 1 downto 0;
    signal read_enable: std_logic;
    signal bram_out: std_logic_vector (63 downto 0);
    signal write_ptr: integer range nwords - 1 downto 0;
    signal memarray: memarray_t;
begin

    blockram_proc:
    process (clk, alrst) is
    begin
        if (clk'event and clk = '1') then
            if (validin = '1') then
                memarray (write_ptr) <= datain;
            end if;

            if (read_enable = '1') then
                bram_out <= memarray (read_ptr);
            end if;
        end if;
    end process;
    
    write_proc:
    process (clk, alrst) is
    begin
        if (clk'event and clk = '1') then
            if (validin = '1') then
                write_ptr <= write_ptr + 1;
            elsif (alrst = '0') then
                write_ptr <= 0;
            end if;
        end if;
    end process;



end Behavioral;
