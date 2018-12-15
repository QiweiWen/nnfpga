-- Testbench automatically generated online
-- at http://vhdl.lapinoo.net
-- Generation date : 24.9.2018 12:14:59 GMT

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library ieee_proposed;
use work.fixed_pkg.all;

use ieee.math_real.all;

use work.helperpkg.all;
use work.nn_arith_package.all;



entity tb_weight_memory is
end tb_weight_memory;

architecture tb of tb_weight_memory is

    constant depth : natural := 10;
    component weight_memory
        generic
        (
            depth: natural := 128
        );
        port (clk        : in std_logic;
              alrst      : in std_logic;
              rdy        : out std_logic;
              re_fwd     : in std_logic;
              vout_fwd   : out std_logic;
              dout_fwd   : out std_logic_vector (15 downto 0);
              re_bkwd    : in std_logic;
              vout_bkwd  : out std_logic;
              dout_bkwd  : out std_logic_vector (15 downto 0);
              we_bkwd    : in std_logic;
              din_bkwd   : in std_logic_vector (15 downto 0);
              waddr_bkwd : in natural;
              ps_load    : in std_logic;
              ps_we      : in std_logic;
              ps_re      : in std_logic;
              ps_addr    : in natural;
              ps_din     : in std_logic_vector (15 downto 0);
              ps_dout    : out std_logic_vector (15 downto 0);
              ps_vout    : out std_logic);
    end component;

    signal clk        : std_logic;
    signal alrst      : std_logic;
    signal rdy        : std_logic;
    signal re_fwd     : std_logic;
    signal vout_fwd   : std_logic;
    signal dout_fwd   : std_logic_vector (15 downto 0);
    signal re_bkwd    : std_logic;
    signal vout_bkwd  : std_logic;
    signal dout_bkwd  : std_logic_vector (15 downto 0);
    signal we_bkwd    : std_logic;
    signal din_bkwd   : std_logic_vector (15 downto 0);
    signal waddr_bkwd : natural;
    signal ps_load    : std_logic;
    signal ps_we      : std_logic;
    signal ps_re      : std_logic;
    signal ps_addr    : natural;
    signal ps_din     : std_logic_vector (15 downto 0);
    signal ps_dout    : std_logic_vector (15 downto 0);
    signal ps_vout    : std_logic;

    constant TbPeriod : time := 100 ns;
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : weight_memory
    generic map (depth => depth)
    port map (clk        => clk,
              alrst      => alrst,
              rdy        => rdy,
              re_fwd     => re_fwd,
              vout_fwd   => vout_fwd,
              dout_fwd   => dout_fwd,
              re_bkwd    => re_bkwd,
              vout_bkwd  => vout_bkwd,
              dout_bkwd  => dout_bkwd,
              we_bkwd    => we_bkwd,
              din_bkwd   => din_bkwd,
              waddr_bkwd => waddr_bkwd,
              ps_load    => ps_load,
              ps_we      => ps_we,
              ps_re      => ps_re,
              ps_addr    => ps_addr,
              ps_din     => ps_din,
              ps_dout    => ps_dout,
              ps_vout    => ps_vout);

      -- Clock generation
      TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

      -- EDIT: Check that clk is really your main clock signal
      clk <= TbClock;

      stimuli : process
          procedure param_put (
              signal target: out std_logic_vector (15 downto 0);
              constant value : natural
          )is
          begin
              target <= std_logic_vector(to_unsigned(value, 16));
          end procedure;
      begin
          -- EDIT Adapt initialization as needed
          re_fwd <= '0';
          re_bkwd <= '0';
          we_bkwd <= '0';
          din_bkwd <= (others => '0');
          waddr_bkwd <= 0;
          ps_load <= '1';
          ps_we <= '0';
          ps_re <= '0';
          ps_addr <= 0;
          ps_din <= (others => '0');

          alrst <= '0';
          wait for 100 ns;
          alrst <= '1';
          wait for 100 ns;
          ps_we <= '1';
          for i in 0 to depth - 1 loop
              ps_addr <= i;
              param_put(ps_din, (i + 1));
              wait for 100 ns;
          end loop;
          ps_we <= '0';
          ps_re <= '1';

          re_fwd <= '1';
          re_bkwd <= '1';

          for i in 0 to depth - 1 loop
              ps_addr <= i;
              wait for 100 ns;
          end loop;
          wait for 200 ns;
          ps_load <= '0';

          wait;
      end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_weight_memory of tb_weight_memory is
    for tb
    end for;
end cfg_tb_weight_memory;
