-- Testbench automatically generated online
-- at http://vhdl.lapinoo.net
-- Generation date : 2.6.2018 08:31:01 GMT

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library ieee_proposed;
use work.fixed_pkg.all;

use ieee.math_real.all;
use work.helperpkg.all;

entity tb_bias_vector is
end tb_bias_vector;

architecture tb of tb_bias_vector is
    
    component bias_vector
        generic (nrows: integer := 100);
        port (clk      : in std_logic;
              alrst    : in std_logic;
              unbiased : in std_logic_vector (31 downto 0);
              vin      : in std_logic;
              biased   : out std_logic_vector (15 downto 0);
              vout     : out std_logic;
              updated  : in std_logic_vector (15 downto 0);
              uvin     : in std_logic);
    end component;

    constant nrows: integer := 5;

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

    subtype unbiased_type is std_logic_vector (31 downto 0);
    subtype biased_type is std_logic_vector (15 downto 0);

    signal latched_biased: real;

begin
    
    debug_proc: process (clk, alrst) is
    begin
        if (rising_edge(clk)) then
            if (alrst = '0') then
                latched_biased <= 0.0;
            elsif (vout = '1') then
                latched_biased <= to_real (to_sfixed (biased, PARAM_DEC - 1, -PARAM_FRC));
            end if;
        end if;
    end process;

    dut : bias_vector
    generic map (nrows => nrows)
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
    procedure upd_put (
        constant  val: real
    ) is
    begin
        updated <= biased_type(to_sfixed (val, PARAM_DEC - 1, -PARAM_FRC)); 
    end procedure;

    procedure unbias_put (
        constant val: real
    ) is
    begin
        unbiased <= unbiased_type(to_sfixed (val, 2 * PARAM_DEC - 1, -2*PARAM_FRC)); 
    end procedure;

    begin
        -- EDIT Adapt initialization as needed
        unbiased <= (others => '0');
        vin <= '0';
        updated <= (others => '0');
        uvin <= '0';

        -- Reset generation
        --  EDIT: Replace alrst below by the name of your reset as I haven't guessed it
        alrst <= '0';
        wait for 100 ns;
        alrst <= '1';
        wait for 100 ns;
        uvin <= '1';
        for i in 1 to 5 loop
            upd_put (1.0 * real(i));
            wait for 100 ns;
        end loop;
        uvin <= '0';
    
        vin <= '1';
        for i in 1 to 10 loop
            unbias_put (1.0*real(i));
            wait for 100 ns;
        end loop;
        vin <= '0';

        uvin <= '1';
        for i in 1 to 5 loop
            upd_put (0.5 * real(i));
            wait for 100 ns;
        end loop;
        uvin <= '0';

        vin <= '1';
        for i in 1 to 5 loop
            unbias_put (1.0*real(i));
            wait for 100 ns;
        end loop;
        vin <= '0';


        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_bias_vector of tb_bias_vector is
    for tb
    end for;
end cfg_tb_bias_vector;
