-- Testbench automatically generated online
-- at http://vhdl.lapinoo.net
-- Generation date : 13.5.2018 01:47:06 GMT

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.helperpkg.all;
use work.nn_arith_package.all;
library ieee_proposed;
use work.fixed_pkg.all;
use ieee.math_real.all;

entity tb_cpe_massive is
end tb_cpe_massive;

architecture tb of tb_cpe_massive is
    
    constant nrows: integer := 5;
    constant dfifo: integer := 256;
    constant fifo_rate: integer := 5;
    constant ncols: integer := 3;

    component fifo_cpe_bundle
        generic (nrows: integer; dfifo: integer; offset: integer := 0);
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
    
    type std_logic_arr is array (ncols - 1 downto 0) of std_logic;
    type std_logic_v16_arr is array (ncols - 1 downto 0) of std_logic_vector(15 downto 0);
    type std_logic_v32_arr is array (ncols - 1 downto 0) of std_logic_vector(31 downto 0);

    signal clk     : std_logic;
    signal alrst   : std_logic;
    signal writeen : std_logic_arr;
    signal datain  : std_logic_v16_arr;
    signal full    : std_logic_arr;
    signal osync   : std_logic_arr;
    signal isync   : std_logic_arr;
    signal ivfwd   : std_logic_arr;
    signal idfwd   : std_logic_v32_arr;
    signal ovfwd   : std_logic_arr;
    signal odfwd   : std_logic_v32_arr;

    constant TbPeriod : time := 100 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

    signal latched_partial_sum: real;

begin
    dutgen:
    for I in ncols - 1 downto 0 generate 
        dut : fifo_cpe_bundle
        generic map (nrows => nrows, dfifo => dfifo, offset => I)
        port map (clk     => clk,
                  alrst   => alrst,
                  writeen => writeen(I),
                  datain  => datain(I),
                  full    => full(I),
                  osync   => osync(I),
                  isync   => isync(I),
                  ivfwd   => ivfwd(I),
                  idfwd   => idfwd(I),
                  ovfwd   => ovfwd(I),
                  odfwd   => odfwd(I));
    
        isync(I) <= '1' when I = 0 else osync(I - 1); 
        ivfwd(I) <= '1' when I = 0 else ovfwd(I - 1);
        idfwd(I) <= (others => '0') when I = 0 else odfwd(I - 1);
  
    end generate;

    debug:
    process (clk, alrst) is
    begin
        if (rising_edge(clk)) then
            if (alrst = '0') then
                latched_partial_sum <= -42.0; 
            else
                if (ovfwd(ncols - 1) = '1') then
                    latched_partial_sum <= 
                        to_real(to_sfixed(odfwd(ncols - 1), 2*PARAM_DEC - 1, -2*PARAM_FRC));
                end if;
            end if;
        end if;
    end process;

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
    begin
        if (rising_edge(clk)) then
            if (alrst = '0') then
                cycle := 0;
            else
                cycle := (cycle + 1) mod fifo_rate;
            end if;
            for I in ncols - 1 downto 0 loop   
                if ((cycle + I) mod fifo_rate = fifo_rate - 1) then
                    writeen(I) <= '1'; 
                    datain(I) <= std_logic_vector (to_unsigned(I, 8)) & X"00";
                else
                    writeen(I) <= '0'; 
                end if;
            end loop;
        end if;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_cpe_massive of tb_cpe_massive is
    for tb
    end for;
end cfg_tb_cpe_massive;
