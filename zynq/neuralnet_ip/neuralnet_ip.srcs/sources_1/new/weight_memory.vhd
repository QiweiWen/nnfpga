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
use ieee.math_real.all;

-- A wrapper over the blockram unit that holds the matrix weights for a single layer
entity weight_memory is
generic (
    nrows: integer := 100;
    ncols: integer := 100
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
    signal word_ptr: integer range 3 downto 0;
    signal read_ptr: integer  range nwords - 1 downto 0;
    signal read_enable: std_logic;
    signal bram_out: std_logic_vector (63 downto 0);
    signal write_ptr: integer range nwords - 1 downto 0;
    signal memarray: memarray_t;
    attribute ram_style: string;
    attribute ram_style of memarray: signal is "auto";
    --input pipeline registers
    signal validin_delayed: std_logic;
    signal datain_delayed: std_logic_vector (63 downto 0);
    --output pipeline registers
    signal sig_validout: std_logic;
    signal sig_dataout: std_logic_vector (15 downto 0);
    signal validout_delayed: std_logic;
    signal dataout_delayed: std_logic_vector (15 downto 0);
begin
    -- put everything here between pipeline registers
    -- to improve block ram performance
    io_delay:
    process (clk, alrst) is
    begin
        if (rising_edge(clk)) then
            if (alrst = '0') then
                validin_delayed <= '0';
                datain_delayed <= (others => '0');
                validout_delayed <= '0';
                dataout_delayed <= (others => '0');
            else
                validin_delayed <= validin;
                datain_delayed <= datain;
                validout_delayed <= sig_validout;
                dataout_delayed <= sig_dataout;
            end if;
        end if;
    end process;

    blockram_read:
    process (clk, alrst) is
    begin
        if (rising_edge(clk)) then
            if (alrst = '0') then
                bram_out <= (others => '0');
            else
                if (read_enable = '1') then
                    bram_out <= memarray (read_ptr);
                    sig_validout <= '1';
                else
                    sig_validout <= '0'; 
                end if;
            end if;
        end if;
    end process;

    blockram_write:
    process (clk, alrst) is
    begin
        if (rising_edge(clk)) then
            if (validin_delayed = '1') then
                memarray (write_ptr) <= datain;
            end if;
        end if;
    end process;
    
    rwaddr_proc:
    process (clk, alrst) is
    begin
        if (rising_edge(clk)) then
            if (alrst = '0') then
                write_ptr <= 0;
                read_ptr <= 0;
            else
                if (validin_delayed = '1') then
                    write_ptr <= (write_ptr + 1) mod nwords;
                elsif (flush = '1') then
                    write_ptr <= 0;
                end if;

                if (read_enable = '1') then
                    read_ptr <= (read_ptr + 1) mod nwords;
                elsif (flush = '0') then
                    read_ptr <= 0;
                end if;

            end if;
        end if;
    end process;

--word pointer incrementing process
    wordptr_proc:
    process (clk, alrst) is
    begin
        if (rising_edge(clk)) then
            if (alrst = '0' or flush = '0') then
                word_ptr <= 3;
            else
                word_ptr <= (word_ptr + 1) mod 4;
            end if;
        end if;
    end process;
    read_enable <= '1' when (word_ptr = 3 and flush = '1') else '0';
    sig_dataout <= bram_out ((word_ptr + 1)* 16 - 1 downto word_ptr * 16);

    dataout <= dataout_delayed;
    validout <= validout_delayed;

end Behavioral;
