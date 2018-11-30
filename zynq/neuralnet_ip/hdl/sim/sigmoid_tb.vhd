-- Testbench automatically generated online
-- at http://vhdl.lapinoo.net
-- Generation date : 26.6.2018 07:06:23 GMT
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library ieee_proposed;
use work.fixed_pkg.all;

use ieee.math_real.all;
use work.helperpkg.all;

entity tb_sigmoidgradfull is
end tb_sigmoidgradfull;

architecture tb of tb_sigmoidgradfull is

    component sigmoidgradfull
        port (clk      : in std_logic;
              rst      : in std_logic;
              datain   : in std_logic_vector (15 downto 0);
              validin  : in std_logic;
              dataout  : out std_logic_vector (15 downto 0);
              validout : out std_logic);
    end component;

    signal clk      : std_logic;
    signal rst      : std_logic;
    signal datain   : std_logic_vector (15 downto 0);
    signal validin  : std_logic;
    signal dataout  : std_logic_vector (15 downto 0);
    signal validout : std_logic;

    constant TbPeriod : time := 100 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

    signal debug: real;

begin

    debug_proc: process (clk, rst) is
    begin
        if (rising_edge(clk)) then
            if (rst = '0') then
                debug <= -2.0;
            elsif (validout = '1') then
                debug <= to_real (to_sfixed(dataout, PARAM_DEC - 1, -PARAM_FRC));
            end if;
        end if;
    end process;

    dut : sigmoidgradfull
    port map (clk      => clk,
              rst      => rst,
              datain   => datain,
              validin  => validin,
              dataout  => dataout,
              validout => validout);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        datain <= (others => '0');
        validin <= '0';
        rst <= '0';
        wait for 100 ns;
        rst <= '1';
        wait for 100 ns;
        validin <= '1';
        for i in -5 to 5 loop
            datain <= slv_16_t(to_sfixed (real(i), PARAM_DEC - 1, -PARAM_FRC));
            wait for 100 ns;
        end loop;
        validin <= '0';

        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_sigmoidgradfull of tb_sigmoidgradfull is
    for tb
    end for;
end cfg_tb_sigmoidgradfull;
