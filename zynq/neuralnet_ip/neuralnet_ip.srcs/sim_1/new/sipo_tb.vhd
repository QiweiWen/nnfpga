-- Testbench automatically generated online
-- at http://vhdl.lapinoo.net
-- Generation date : 29.3.2018 02:54:23 GMT

library ieee;
use ieee.std_logic_1164.all;

library ieee_proposed;
use ieee_proposed.fixed_pkg.all;
use work.helperpkg.all;

use ieee.math_real.all;

entity tb_param_sipo is
end tb_param_sipo;

architecture tb of tb_param_sipo is

    component param_sipo
            generic (
                nrows: integer := 10
            );
        port (clk      : in std_logic;
              alrst    : in std_logic;
              datain   : in std_logic_vector (15 downto 0);
              validin  : in std_logic;
              arrayout : out wordarr_t (nrows - 1 downto 0);
              validout : out std_logic_vector (nrows - 1 downto 0));
    end component;
    
    constant nrows  : integer := 7;
    signal clk      : std_logic;
    signal alrst    : std_logic;
    signal datain   : std_logic_vector (15 downto 0);
    signal validin  : std_logic;
    signal arrayout : wordarr_t (nrows - 1 downto 0);
    signal validout : std_logic_vector (nrows - 1 downto 0);

    constant TbPeriod : time := 100 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

    subtype param_type is std_logic_vector (15 downto 0);

    signal latched_arrayout: wordarr_t (nrows - 1 downto 0);
begin
    debugproc:
    process (clk, alrst) is
    begin
        if (rising_edge(clk)) then
            if (alrst = '0') then
                latched_arrayout <= (others => (others => '0'));
            elsif (validout(0) = '1') then
                latched_arrayout <= arrayout;
            end if;
        end if;
    end process;

    dut : param_sipo
    generic map (nrows => nrows)
    port map (clk      => clk,
              alrst    => alrst,
              datain   => datain,
              validin  => validin,
              arrayout => arrayout,
              validout => validout);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
    procedure put_weight (
        constant val: real
    )is
    begin
        datain <= param_type(to_sfixed(val, PARAM_DEC - 1, -PARAM_FRC));
        wait for 100 ns;
    end procedure;
    begin
        -- EDIT Adapt initialization as needed
        datain <= (others => '0');
        validin <= '0';

        -- Reset generation
        -- EDIT: Check that alrst is really your reset signal
        alrst <= '0';
        wait for 100 ns;
        alrst <= '1';
        wait for 100 ns;
        validin <= '1';
        put_weight (1.0);
        put_weight (2.0);
        put_weight (3.0);
        put_weight (4.0);
        put_weight (5.0);
        put_weight (6.0);
        put_weight (7.0);
        put_weight (8.0);
        put_weight (9.0);
        put_weight (10.0);
        put_weight (11.0);
        put_weight (12.0);
        put_weight (13.0);
        put_weight (14.0);
        validin <= '0';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_param_sipo of tb_param_sipo is
    for tb
    end for;
end cfg_tb_param_sipo;
