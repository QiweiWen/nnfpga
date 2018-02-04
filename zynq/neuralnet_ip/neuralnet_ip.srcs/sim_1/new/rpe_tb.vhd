-- Testbench automatically generated online
-- at http://vhdl.lapinoo.net
-- Generation date : 4.2.2018 01:28:59 GMT

library ieee;
use ieee.std_logic_1164.all;

library ieee_proposed;
use ieee_proposed.fixed_pkg.all;

use ieee.math_real.all;

use work.helperpkg.all;

entity tb_row_processor is
end tb_row_processor;

architecture tb of tb_row_processor is

    component row_processor
        generic (
            ncols: integer := 100
        );
        port (clk         : in std_logic;
              alrst       : in std_logic;
              l1_streamin : in std_logic;
              l1_datain   : in std_logic_vector (15 downto 0);
              ve_datain   : in std_logic_vector (15 downto 0);
              ve_validin  : in std_logic;
              dataout     : out std_logic_vector (15 downto 0);
              validout    : out std_logic;
              finished    : out std_logic;
              validfwd    : out std_logic;
              datafwd     : out std_logic_vector (15 downto 0));
    end component;

    signal clk         : std_logic;
    signal alrst       : std_logic;
    signal l1_streamin : std_logic;
    signal l1_datain   : std_logic_vector (15 downto 0);
    signal ve_datain   : std_logic_vector (15 downto 0);
    signal ve_validin  : std_logic;
    signal dataout     : std_logic_vector (15 downto 0);
    signal validout    : std_logic;
    signal finished    : std_logic;
    signal validfwd    : std_logic;
    signal datafwd     : std_logic_vector (15 downto 0);
    
    subtype param_type is std_logic_vector (15 downto 0);

    constant TbPeriod : time := 100 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';
    constant ncols : integer := 10;

    signal latched_product: std_logic_vector (15 downto 0);
    signal latched_product_sfixed: sfixed (PARAM_DEC - 1 downto -PARAM_FRC);
    signal latched_product_real: real;

    signal final_element: std_logic_vector (15 downto 0);
begin
    debug_proc:
    process (clk, alrst) is
    begin
        if (rising_edge(clk)) then
            if (alrst = '0')  then
                latched_product <= (others =>  '0');
                final_element <= (others => '0');
            else
                if (validout = '1') then
                    latched_product <= dataout;
                end if;

                if (finished = '1') then
                    final_element <= dataout;
                end if;
            end if;
        end if;
    end process;
    latched_product_sfixed <= to_sfixed (latched_product, PARAM_DEC - 1, -PARAM_FRC);
    latched_product_real   <= to_real (latched_product_sfixed);

    dut : row_processor
    generic map (ncols => ncols)
    port map (clk         => clk,
              alrst       => alrst,
              l1_streamin => l1_streamin,
              l1_datain   => l1_datain,
              ve_datain   => ve_datain,
              ve_validin  => ve_validin,
              dataout     => dataout,
              validout    => validout,
              finished    => finished,
              validfwd    => validfwd,
              datafwd     => datafwd);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
        variable val: real;
    begin

        -- EDIT Adapt initialization as needed
        l1_streamin <= '0';
        l1_datain <= (others => '0');
        ve_datain <= (others => '0');
        ve_validin <= '0';

        -- Reset generation
        -- EDIT: Check that alrst is really your reset signal
        alrst <= '0';
        wait for 100 ns;
        alrst <= '1';
        wait for 100 ns;
        l1_streamin <= '1';
        for I in ncols downto 1 loop
            val := 1.0 + 0.1 * real(I); 
            l1_datain <= param_type(to_sfixed (val, PARAM_DEC - 1, -PARAM_FRC)); 
            wait for 100 ns;
        end loop;
        l1_streamin <= '0';
        ve_validin <= '1';
        for I in ncols downto 1 loop
            val := 2.0 + 0.1 * real(I); 
            ve_datain <= param_type(to_sfixed (val, PARAM_DEC - 1, -PARAM_FRC)); 
            wait for 100 ns;
        end loop;
        ve_validin <= '0';
        wait for 700 ns;
        ve_validin <= '1';
        for I in ncols downto 1 loop
            val := 3.0 + 0.1 * real(I); 
            ve_datain <= param_type(to_sfixed (val, PARAM_DEC - 1, -PARAM_FRC)); 
            wait for 100 ns;
        end loop;
        ve_validin <= '0';
        -- EDIT Add stimuli here
        wait for 100 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_row_processor of tb_row_processor is
    for tb
    end for;
end cfg_tb_row_processor;
