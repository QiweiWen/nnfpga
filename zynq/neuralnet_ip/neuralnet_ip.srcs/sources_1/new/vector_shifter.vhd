----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.01.2018 21:02:53
-- Design Name: 
-- Module Name: vector_shifter - Behavioral
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

-- Pipelined serializer
-- Serializes the parrallel output from row processing elements
-- Fill to the brim, start flushing while filling with the next vector
entity vector_shifter is
generic(
    nrows: integer := 100
);
port (
    clk: in std_logic;
    alrst: in std_logic;
-- parallel input
    array_in: in wordarr_t (nrows - 1 downto 0);
    valid_in: in std_logic_vector (nrows - 1 downto 0); 
-- serial output
    valid_out: out std_logic;
    activated_out: out std_logic_vector (15 downto 0);
    unactivated_out: out std_logic_vector (15 downto 0)
);
end vector_shifter;

architecture Behavioral of vector_shifter is
    
    -- extra bit of valid flag
    type register_array_t is array (nrows - 1 downto 0) of std_logic_vector (16 downto 0);
    
    signal registers: register_array_t (nrows - 1 downto 0);
    -- multiplx the input signals to the registers
    -- between shifting and accepting input from matrix
    signal data_signals: register_array_t (nrows - 1 downto 0);
    signal sel_signals: std_logic_vector (nrows - 1 downto 0);
    signal data_shift: register_array_t (nrows - 1 downto 0);
    signal data_input: register_array_t (nrows - 1 downto 0);

    -- counter indicating which elements in the register
    -- we want to flush
    signal flush_counter: integer range nrows - 1 downto 0;
    signal flush_counter_next: integer range nrows - 1 downto 0;
begin

shiftgen:
for I in nrows - 1 downto 1 generate
    data_shift (I) <= data_shift (I - 1);
end generate;
data_shift (0) <= (others => '0');

inputgen:
for I in nrows - 1 downto 0 generate
    data_input (I) (16) <= valid_in (I);
    data_input (I) (15 downto 0) <= array_in (I); 
end generate;

muxgen:
for I in nrows - 1 downto 0 generate
    data_signals (I) <= data_shift(I) when sel_signals(I) = '1' else data_input(I);
end generate;

latching_proc:
process (clk, alrst) is
begin
    if (rising_edge(clk)) then
        if (alrst = '0') then
            for I in nrows - 1 downto 0 loop
                registers(I) <= (others => '0');
            end loop;
        else
            registers <= data_signals;
        end if;
    end if;
end process;

--TODO:
-- wire output to sigmoid unit
-- mux selection bit logic

flush_counter_proc:
process (clk, alrst) is
begin
    if (rising_edge(clk)) then
        if (alrst = '0') then
            flush_counter <= nrows - 1;
        else
            flush_counter <= flush_counter_next;
        end if;
    end if;
end process;

flush_counter_next <= 0 when (flush_counter = 0 and valid_in(nrows - 1) = '1') else
                      flush_counter when (flush_counter = nrows - 1) else
                      flush_counter + 1;

muxsel_gen:
for I in nrows - 1 downto 0 generate
    sel_signals (I) <= '1' when I > flush_counter else '0'; 
end generate;

end Behavioral;
