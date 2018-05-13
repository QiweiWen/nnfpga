-- Testbench automatically generated online
-- at http://vhdl.lapinoo.net
-- Generation date : 13.5.2018 01:47:06 GMT

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.helperpkg.all;
use work.nn_arith_package.all;
library ieee_proposed;
use ieee_proposed.fixed_pkg.all;
use ieee.math_real.all;

entity tb_cpe_massive is
end tb_cpe_massive;

architecture tb of tb_cpe_massive is
    
    constant nrows: integer := 5;
    constant dfifo: integer := 256;
    constant fifo_rate: integer := 15;

    component fifo_cpe_bundle
        generic (nrows: integer; dfifo: integer);
        port (clk     : in std_logic;
              alrst   : in std_logic;
              writeen : in std_logic;
              datain  : in std_logic_vector (15 downto 0);
              full   : out std_logic;
              osync   : out std_logic;
              isync   : in std_logic;
              ivfwd   : in std_logic;
              idfwd   : in std_logic_vector (31 downto 0);
              ovfwd   : out std_logic;
              odfwd   : out std_logic_vector (31 downto 0));
    end component;

    signal clk     : std_logic;
    signal alrst   : std_logic;
    signal writeen : std_logic;
    signal datain  : std_logic_vector (15 downto 0);
    signal full    : std_logic;
    signal osync   : std_logic;
    signal isync   : std_logic := '1';
    signal ivfwd   : std_logic := '1';
    signal idfwd   : std_logic_vector (31 downto 0) := X"00010000";
    signal ovfwd   : std_logic;
    signal odfwd   : std_logic_vector (31 downto 0);

    constant TbPeriod : time := 100 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

    signal latched_partial_sum: real;

begin

    debug:
    process (clk, alrst) is
    begin
        if (rising_edge(clk)) then
            if (alrst = '0') then
                latched_partial_sum <= 0.0; 
            else
                if (ovfwd = '1') then
                    latched_partial_sum <= 
                        to_real(to_sfixed(odfwd, 2*PARAM_DEC - 1, -2*PARAM_FRC));
                end if;
            end if;
        end if;
    end process;

    dut : fifo_cpe_bundle
    generic map (nrows => nrows, dfifo => dfifo)
    port map (clk     => clk,
              alrst   => alrst,
              writeen => writeen,
              datain  => datain,
              full    => full,
              osync   => osync,
              isync   => isync,
              ivfwd   => ivfwd,
              idfwd   => idfwd,
              ovfwd   => ovfwd,
              odfwd   => odfwd);

    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    clk <= TbClock;

    do_reset : process
    begin
        alrst <= '0';
        wait for 100 ns;
        alrst <= '1';
        wait for 100 ns;

        wait;
    end process;

    fifo_populate: process (clk, alrst)
        variable cycle: integer;
        variable data: integer;
    begin
        if (rising_edge(clk)) then
            if (alrst = '0') then
                cycle := 0;
                data := 0;
            else
                cycle := (cycle + 1) mod fifo_rate;
            end if;
            
            if (cycle = fifo_rate - 1) then
                writeen <= '1'; 
                datain <= std_logic_vector (to_unsigned(data, 8)) & X"00";
                data := (data + 1) mod 128;
            else
                writeen <= '0'; 
            end if;

        end if;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_cpe_massive of tb_cpe_massive is
    for tb
    end for;
end cfg_tb_cpe_massive;
