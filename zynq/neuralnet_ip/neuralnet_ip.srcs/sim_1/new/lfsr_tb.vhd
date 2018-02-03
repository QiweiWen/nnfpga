-- Testbench automatically generated online
-- at http://vhdl.lapinoo.net
-- Generation date : 3.2.2018 08:14:45 GMT

library ieee;
use ieee.std_logic_1164.all;

entity tb_lfsr is
end tb_lfsr;

architecture tb of tb_lfsr is

    component lfsr
        port (clk       : in std_logic;
              alrst     : in std_logic;
              pseudornd : out std_logic_vector (15 downto 0));
    end component;

    signal clk       : std_logic;
    signal alrst     : std_logic;
    signal pseudornd : std_logic_vector (15 downto 0);

    constant TbPeriod : time := 100 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : lfsr
    port map (clk       => clk,
              alrst     => alrst,
              pseudornd => pseudornd);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed

        -- Reset generation
        -- EDIT: Check that alrst is really your reset signal
        alrst <= '0';
        wait for 100 ns;
        alrst <= '1';
        wait for 100 ns;

        -- EDIT Add stimuli here
        wait for 100 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_lfsr of tb_lfsr is
    for tb
    end for;
end cfg_tb_lfsr;