-- Testbench automatically generated online
-- at http://vhdl.lapinoo.net
-- Generation date : 16.9.2018 01:56:08 GMT

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library ieee_proposed;
use work.fixed_pkg.all;

use ieee.math_real.all;

use work.helperpkg.all;
use work.nn_arith_package.all;

entity tb_fifo_cache is
end tb_fifo_cache;

architecture tb of tb_fifo_cache is

    constant fifo_depth : natural := 10;
    constant data_width : natural := 16;

    component fifo_cache is
    generic
    (
        fifo_depth: natural := 128
    );
    port
    (
        clk:        in std_logic;
        alrst:      in std_logic;
        cache_empty:out std_logic;
        rden:       in std_logic;
        rdata:      out std_logic_vector(15 downto 0);
        vout:       out std_logic;
        fifo_empty: in std_logic;
        fifo_rden:   out std_logic;
        fifo_rdata:  in std_logic_vector(15 downto 0);
        fifo_vin  :  in std_logic
    );
    end component fifo_cache;

    component std_fifo is
        generic (
            constant data_width  : positive := 8;
            constant fifo_depth	: positive := 256
        );
        port ( 
            clk		: in  std_logic;
            rst		: in  std_logic;
            writeen	: in  std_logic;
            datain	: in  std_logic_vector (data_width - 1 downto 0);
            readen	: in  std_logic;
            dataout	: out std_logic_vector (data_width - 1 downto 0);
            ackout  : out std_logic;
            validout: out std_logic;
            empty	: out std_logic;
            full	: out std_logic
        );
    end component std_fifo;

    signal clk       : std_logic;
    signal alrst     : std_logic;
    signal cache_empty: std_logic;
    signal rden      : std_logic;
    signal rdata     : std_logic_vector (15 downto 0);
    signal vout      : std_logic;
    signal fifo_rden  : std_logic;
    signal fifo_empty: std_logic;
    signal fifo_rdata : std_logic_vector (15 downto 0);
    signal fifo_vin   : std_logic;
--
    signal fifo_writeen     : std_logic;
    signal fifo_datain     : std_logic_vector(15 downto 0);
-- 
    signal sig_debug : std_logic_vector(15 downto 0);
--
    signal cache_reset: std_logic;

    constant TbPeriod : time := 100 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin
    dbg_proc: process(clk)
    begin
        if (rising_edge(clk)) then
            if (alrst = '0') then
                sig_debug <= X"dead"; 
            else
                if (vout = '1') then
                    sig_debug <= rdata;
                else
                    sig_debug <= X"beef";
                end if;
            end if;
        end if;
    end process;

    dut : fifo_cache
    generic map (fifo_depth => fifo_depth)
    port map (clk       => clk,
              alrst     => cache_reset,
              cache_empty => cache_empty,
              rden      => rden,
              rdata     => rdata,
              vout      => vout,
              fifo_empty => fifo_empty,
              fifo_rden  => fifo_rden,
              fifo_rdata => fifo_rdata,
              fifo_vin   => fifo_vin);

    dut_fifo: std_fifo
    generic map (data_width => data_width,
                 fifo_depth => fifo_depth)
    port map
    (
        clk         => clk,
        rst         => alrst,
        writeen     => fifo_writeen,
        datain      => fifo_datain,
        readen      => fifo_rden,
        dataout     => fifo_rdata,
        ackout      => open,
        validout    => fifo_vin,
        empty       => fifo_empty,
        full        => open
    );


    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that clk is really your main clock signal
    clk <= TbClock;

    rden <= '1' when cache_empty = '0' and cache_reset = '1' else '0';

    stimuli : process
        procedure param_put (
            signal target: out std_logic_vector (15 downto 0);
            constant value : natural
        )is
        begin
            target <= std_logic_vector(to_unsigned(value, 16));
        end procedure;
    begin
        fifo_writeen <= '0';
        fifo_datain <= (others => '0');
        alrst <= '0';
        cache_reset <= '0';
        wait for 100 ns;
        alrst <= '1';
        wait for 100 ns;
        fifo_writeen <= '1';
        for i in 0 to fifo_depth - 1 loop
            param_put(fifo_datain, (i + 1));
            wait for 100 ns;
        end loop;
        cache_reset <= '1';
        fifo_writeen <= '0';
        wait for 2000 ns;
        fifo_writeen <= '1';
        param_put(fifo_datain, 11);
        wait for 100 ns;
        fifo_writeen <= '0';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_fifo_cache of tb_fifo_cache is
    for tb
    end for;
end cfg_tb_fifo_cache;
