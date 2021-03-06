-- Testbench automatically generated online
-- at http://vhdl.lapinoo.net
-- Generation date : 16.5.2018 07:27:22 GMT

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.helperpkg.all;
use work.nn_arith_package.all;
library ieee_proposed;
use work.fixed_pkg.all;
use ieee.math_real.all;

entity tb_bias_unit is
end tb_bias_unit;

architecture tb of tb_bias_unit is

    component bias_unit
        port (clk      : in std_logic;
              alrst    : in std_logic;
              unbiased : in std_logic_vector (31 downto 0);
              vin      : in std_logic;
              biased   : out std_logic_vector (15 downto 0);
              vout     : out std_logic;
              updated  : in std_logic_vector (15 downto 0);
              uvin     : in std_logic);
    end component;

    signal clk      : std_logic;
    signal alrst    : std_logic;
    signal unbiased : std_logic_vector (31 downto 0);
    signal vin      : std_logic;
    signal biased   : std_logic_vector (15 downto 0);
    signal vout     : std_logic;
    signal updated  : std_logic_vector (15 downto 0);
    signal uvin     : std_logic;

    constant TbPeriod : time := 100 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

    signal latched_debug_output: real;

begin

    debugproc: process (clk) is
    begin
        if (rising_edge(clk)) then
            if (vout = '1') then
                latched_debug_output <=
                        to_real(to_sfixed(biased, PARAM_DEC - 1, -PARAM_FRC));
            end if;
        end if;
    end process;

    dut : bias_unit
    port map (clk      => clk,
              alrst    => alrst,
              unbiased => unbiased,
              vin      => vin,
              biased   => biased,
              vout     => vout,
              updated  => updated,
              uvin     => uvin);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        unbiased <= (others => '0');
        vin <= '0';
        updated <= (others => '0');
        uvin <= '0';

        alrst <= '0';
        wait for 100 ns;
        alrst <= '1';
        wait for 100 ns;

        -- bias 0.5
        uvin <= '1';
        updated <= X"0080";
        wait for 100 ns;
        uvin <= '0';
        unbiased <= X"00010000";
        vin <= '1';
        wait for 100 ns;
        vin <= '0';
        uvin <= '1';
        -- bias 0
        updated <= X"ff80";
        wait for 100 ns;
        uvin <= '0';
        unbiased <= X"00010000";
        vin <= '1';
        wait for 100 ns;
        vin <= '0';

        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_bias_unit of tb_bias_unit is
    for tb
    end for;
end cfg_tb_bias_unit;
