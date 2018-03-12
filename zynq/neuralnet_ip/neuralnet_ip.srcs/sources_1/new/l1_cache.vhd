----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.02.2018 11:54:20
-- Design Name: 
-- Module Name: l1_cache - Behavioral
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

entity l1_cache is
generic(
    nitems: integer := 10
);
port (
    clk: in std_logic;
    alrst: in std_logic;
-- input side from l2 cache
    streamin: in std_logic;
    datain: in std_logic_vector (15 downto 0);
-- output side to the row processing element
    streamout: in std_logic;
    dataout: out std_logic_vector (15 downto 0);
    validout: out std_logic
);
end l1_cache;

architecture Behavioral of l1_cache is
    signal read_ptr: integer range nitems - 1 downto 0;
    signal write_ptr: integer range nitems - 1 downto 0;
    type memarray_t is array (nitems - 1 downto 0) of std_logic_vector (15 downto 0);
    signal memarray: memarray_t;
    signal blockram_out: std_logic_vector (15 downto 0);

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
    signal delaybuf_in: std_logic_vector (0 downto 0);
    signal delaybuf_out: std_logic_vector (0 downto 0);
begin

read_addr_proc:
process (clk, alrst) is
begin
    if (rising_edge(clk)) then
        if (alrst = '0') then
            read_ptr <= nitems - 1;
        else
            if (streamout = '1') then
                read_ptr <= (read_ptr - 1) mod nitems;
            end if;
        end if;
    end if;
end process;

write_addr_proc:
process (clk, alrst) is
begin
    if (rising_edge(clk)) then
        if (streamin = '0' or alrst = '0') then
            write_ptr <= 0;
        else
            if (streamin = '1') then
                write_ptr <= (write_ptr + 1) mod nitems;
            end if;
        end if;
    end if;
end process;

blockram_write_proc:
process (clk) is
begin
    if (rising_edge(clk)) then
        if (streamin = '1') then
            memarray (write_ptr) <= datain;
        end if;
    end if;
end process;

blockram_read_proc:
process (clk) is
begin
    if (rising_edge (clk)) then
        if (streamout = '1') then
            blockram_out <= memarray (read_ptr);
        end if;
        dataout <= blockram_out; 
    end if;
end process;

validout_delay:
delay_buffer
generic map(
    width => 1,
    ncycles => 2
)
port map(
    clk => clk,
    rst => alrst,
    din => delaybuf_in,
    dout => delaybuf_out 
);

delaybuf_in (0) <= streamout;
validout <= delaybuf_out (0); 

end Behavioral;
