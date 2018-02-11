-- Testbench automatically generated online
-- at http://vhdl.lapinoo.net
-- Generation date : 10.2.2018 02:05:12 GMT

library ieee;
use ieee.std_logic_1164.all;
use work.helperpkg.all;

entity tb_feeder_array is
end tb_feeder_array;

architecture tb of tb_feeder_array is
    constant nrows: integer := 2;
    constant ncols: integer := 2;
    
    component feeder_array
        generic (
            nrows: integer := 10;
            ncols: integer := 10
        );
        port (clk      : in std_logic;
              alrst    : in std_logic;
              datain   : in std_logic_vector (15 downto 0);
              validin  : in std_logic;
              dataout  : out wordarr_t (nrows - 1 downto 0);
              validout : out std_logic_vector (nrows - 1 downto 0));
    end component;

    signal clk      : std_logic;
    signal alrst    : std_logic;
    signal datain   : std_logic_vector (15 downto 0);
    signal validin  : std_logic;
    signal dataout  : wordarr_t (nrows - 1 downto 0);
    signal validout : std_logic_vector (nrows - 1 downto 0);

    constant TbPeriod : time := 100 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';
    
    signal debug: std_logic_vector (15 downto 0); 
begin
    debugproc:
    process  (clk) is
    begin
        if (rising_edge(clk)) then
            if (validout(0) = '1') then
                debug <= dataout (0);
            end if;
        end if;
    end process;

    dut : feeder_array
    generic map (nrows => nrows, ncols => ncols)
    port map (clk      => clk,
              alrst    => alrst,
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

        -- Reset generation
        -- EDIT: Check that alrst is really your reset signal
        alrst <= '0';
        wait for 100 ns;
        alrst <= '1';
        wait for 100 ns;
        validin <= '1';
        for I in 50 downto 1 loop
            datain <= X"dead";
            wait for 100 ns;
            datain <= X"beef";
            wait for 100 ns;
        end loop;
        validin <= '0';
        -- EDIT Add stimuli here
        wait for 100 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_feeder_array of tb_feeder_array is
    for tb
    end for;
end cfg_tb_feeder_array;
