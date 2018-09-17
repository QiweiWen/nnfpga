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

entity tb_cache is
end tb_cache;

architecture tb of tb_cache is

    constant ram_depth : integer := 10;
    component cache
        generic
        (
            ram_depth: integer := 128
        );
        port (clk       : in std_logic;
              alrst     : in std_logic;
              rdy       : out std_logic;
              rden      : in std_logic;
              rdata     : out std_logic_vector (15 downto 0);
              vout      : out std_logic;
              ram_rden  : out std_logic;
              ram_raddr : out integer range 0 to ram_depth - 1;
              ram_rdata : in std_logic_vector (15 downto 0);
              ram_vin   : in std_logic);
    end component;

    component three_port_ram is
        generic (
            width: integer := 16;
            depth: integer := 128
        );
        port (
            clk: in std_logic;
            alrst: in std_logic;
            -- read port A
            re_a: in std_logic;
            addr_a: in integer range 0 to depth - 1;
            vout_a: out std_logic;
            dout_a: out std_logic_vector (width - 1 downto 0);
            -- read port B
            re_b: in std_logic;
            addr_b: in integer range 0 to depth - 1;
            vout_b: out std_logic;
            dout_b: out std_logic_vector (width - 1 downto 0);
            -- write port C
            addr_c: in integer range 0 to depth - 1;
            vin_c: in std_logic;
            din_c: in std_logic_vector (width - 1 downto 0)
        );
    end component three_port_ram;

    signal clk       : std_logic;
    signal alrst     : std_logic;
    signal rdy       : std_logic;
    signal rden      : std_logic;
    signal rdata     : std_logic_vector (15 downto 0);
    signal vout      : std_logic;
    signal ram_rden  : std_logic;
    signal ram_raddr : integer range 0 to ram_depth - 1;
    signal ram_rdata : std_logic_vector (15 downto 0);
    signal ram_vin   : std_logic;
--
    signal addr_c    : integer range 0 to ram_depth - 1;
    signal vin_c     : std_logic;
    signal din_c     : std_logic_vector(15 downto 0);
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
                end if;
            end if;
        end if;
    end process;

    dut : cache
    generic map (ram_depth => ram_depth)
    port map (clk       => clk,
              alrst     => cache_reset,
              rdy       => rdy,
              rden      => rden,
              rdata     => rdata,
              vout      => vout,
              ram_rden  => ram_rden,
              ram_raddr => ram_raddr,
              ram_rdata => ram_rdata,
              ram_vin   => ram_vin);

    dut_ram: three_port_ram
    generic map (width => 16, depth => ram_depth)
    port map
    (
        clk     => clk,
        alrst   => alrst,
        re_a    => ram_rden,
        addr_a  => ram_raddr,
        vout_a  => ram_vin,
        dout_a  => ram_rdata,

        re_b    => '0',
        addr_b  => 0,
        vout_b  => open,
        dout_b  => open,

        addr_c  => addr_c,
        vin_c   => vin_c,
        din_c   => din_c
    );

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
        procedure param_put (
            signal target: out std_logic_vector (15 downto 0);
            constant value : integer
        )is
        begin
            target <= std_logic_vector(to_unsigned(value, 16));
        end procedure;
    begin
        addr_c <= 0;
        vin_c <= '0';
        din_c <= (others => '0');
        rden <= '0';
        alrst <= '0';
        cache_reset <= '0';
        wait for 100 ns;
        alrst <= '1';
        wait for 100 ns;
        vin_c <= '1';
        for i in 0 to ram_depth - 1 loop
            addr_c <= i;
            param_put(din_c, (i + 1));
            wait for 100 ns;
        end loop;
        cache_reset <= '1';
        wait until rdy = '1';
        rden <= '1';    
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_cache of tb_cache is
    for tb
    end for;
end cfg_tb_cache;
