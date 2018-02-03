-- Testbench automatically generated online
-- at http://vhdl.lapinoo.net
-- Generation date : 3.2.2018 06:27:31 GMT

library ieee;
use ieee.std_logic_1164.all;

entity tb_l1_cache is
end tb_l1_cache;

architecture tb of tb_l1_cache is

    component l1_cache
        port (clk       : in std_logic;
              alrst     : in std_logic;
              streamin  : in std_logic;
              datain    : in std_logic_vector (15 downto 0);
              streamout : in std_logic;
              dataout   : out std_logic_vector (15 downto 0);
              validout  : out std_logic);
    end component;

    signal clk       : std_logic;
    signal alrst     : std_logic;
    signal streamin  : std_logic;
    signal datain    : std_logic_vector (15 downto 0);
    signal streamout : std_logic;
    signal dataout   : std_logic_vector (15 downto 0);
    signal validout  : std_logic;

    constant TbPeriod : time := 100 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : l1_cache
    port map (clk       => clk,
              alrst     => alrst,
              streamin  => streamin,
              datain    => datain,
              streamout => streamout,
              dataout   => dataout,
              validout  => validout);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        streamin <= '0';
        datain <= (others => '0');
        streamout <= '0';
   
        -- Reset generation
        -- EDIT: Check that alrst is really your reset signal
        alrst <= '0';
        wait for 100 ns;
        alrst <= '1';
        wait for 100 ns;
        streamin <= '1';
        datain <= X"dead";
        wait for 100 ns;
        datain <= X"dead";
        wait for 100 ns;
        datain <= X"dead";
        wait for 100 ns;
        datain <= X"dead";
        wait for 100 ns;
        datain <= X"dead";
        wait for 100 ns;
        datain <= X"dead";
        wait for 100 ns;
        datain <= X"dead";
        wait for 100 ns;
        datain <= X"dead";
        wait for 100 ns;
        datain <= X"beef";
        wait for 100 ns;
        datain <= X"beef";
        wait for 100 ns;
        datain <= X"beef";
        wait for 100 ns;
        streamin <= '0';
        streamout <= '1';
        wait for 1000 ns;
        streamout <= '0';

        -- EDIT Add stimuli here
        wait for 100 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_l1_cache of tb_l1_cache is
    for tb
    end for;
end cfg_tb_l1_cache;
