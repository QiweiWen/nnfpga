-- Testbench automatically generated online
-- at http://vhdl.lapinoo.net
-- Generation date : 7.5.2018 04:45:41 GMT

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


library ieee_proposed;
use ieee_proposed.fixed_pkg.all;

use ieee.math_real.all;


use work.helperpkg.all;


entity tb_multaccu is
end tb_multaccu;

architecture tb of tb_multaccu is

    component multaccu
        port (clk   : in std_logic;
              alrst : in std_logic;
              A     : in std_logic_vector (15 downto 0);
              B     : in std_logic_vector (15 downto 0);
              vin   : in std_logic;
              fin   : in std_logic;
              P     : out std_logic_vector (15 downto 0);
              vout  : out std_logic);
    end component;

    signal clk   : std_logic;
    signal alrst : std_logic;
    signal A     : std_logic_vector (15 downto 0);
    signal B     : std_logic_vector (15 downto 0);
    signal vin   : std_logic;
    signal fin   : std_logic;
    signal P     : std_logic_vector (15 downto 0);
    signal vout  : std_logic;

    constant TbPeriod : time := 100 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

    subtype param_type is std_logic_vector (15 downto 0);

    signal P_real: real;

begin
    
    debug_proc: process (clk, alrst) is
    begin
        if (rising_edge(clk)) then
            P_real <= 0.0;
        elsif (vout = '1') then
            P_real <= to_real (to_sfixed (P, PARAM_DEC - 1, -PARAM_FRC));
        end if;
    end process;

    dut : multaccu
    port map (clk   => clk,
              alrst => alrst,
              A     => A,
              B     => B,
              vin   => vin,
              fin   => fin,
              P     => P,
              vout  => vout);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process

    procedure do_mult_add (
        constant a_real: real;
        constant b_real: real
    )is
    begin
        A <= param_type(to_sfixed (a_real, PARAM_DEC - 1, -PARAM_FRC));  
        B <= param_type(to_sfixed (b_real, PARAM_DEC - 1, -PARAM_FRC));  
        wait for 100 ns;
    end procedure;
    begin
        -- EDIT Adapt initialization as needed
        A <= (others => '0');
        B <= (others => '0');
        vin <= '0';
        fin <= '0';

        -- Reset generation
        -- EDIT: Check that alrst is really your reset signal
        alrst <= '0';
        wait for 100 ns;
        alrst <= '1';
        wait for 100 ns;

        vin <= '1';
        do_mult_add (1.0, 2.0);
        do_mult_add (2.0, 3.0);
        fin <= '1';
        do_mult_add (-5.0, 1.5);
        vin <= '0';
        fin <= '0';

        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_multaccu of tb_multaccu is
    for tb
    end for;
end cfg_tb_multaccu;
