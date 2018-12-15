library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.helperpkg.all;
use work.nn_arith_package.all;
library ieee_proposed;
use work.fixed_pkg.all;
use ieee.math_real.all;

entity tb_row_processor is
end tb_row_processor;

architecture tb of tb_row_processor is

component row_processor is
generic (
    ncols: natural := 100
);
port(
    clk: in std_logic;
    alrst: in std_logic;
    ready    : out std_logic;
-- wram cache external interface
    wram_rden: out std_logic;
    wram_din : in std_logic_vector (15 downto 0);
    wram_vin : in std_logic;
    wram_rdy : in std_logic;
-- vector input channel
    ve_datain: in std_logic_vector (15 downto 0);
    ve_validin: in std_logic;
-- product terms output channel
    dataout: out std_logic_vector (31 downto 0);
    validout: out std_logic;
-- vector input forwarded to the adjacent row processor down the line
    validfwd: out std_logic;
    datafwd: out std_logic_vector (15 downto 0)
);
end component row_processor;

component weight_memory is
    generic (
        depth : natural := 128
    );
    port
    (
        clk : in std_logic;
        alrst : in std_logic;
        rdy : out std_logic;
        -- forward read port
        re_fwd: in std_logic;
        vout_fwd : out std_logic;
        dout_fwd : out std_logic_vector(15 downto 0);
        -- backward read port
        re_bkwd: in std_logic;
        vout_bkwd : out std_logic;
        dout_bkwd : out std_logic_vector(15 downto 0);
        -- backward write port
        we_bkwd : in std_logic;
        din_bkwd : in std_logic_vector(15 downto 0);
        waddr_bkwd : in natural range 0 to depth - 1;
        -- ports for parameter sideload
        ps_load : in std_logic;
        ps_we : in std_logic;
        ps_re : in std_logic;
        ps_addr : in natural range 0 to depth - 1;
        ps_din : in std_logic_vector(15 downto 0);
        ps_dout : out std_logic_vector(15 downto 0);
        ps_vout : out std_logic
    );
end component weight_memory;

constant ncols : natural := 5;
constant depth : natural := ncols;
constant period : time := 100 ns;

signal clk:  std_logic := '0';
signal alrst:  std_logic;
signal ready    :  std_logic;
signal wram_rden:  std_logic;
signal wram_din :  std_logic_vector (15 downto 0);
signal wram_vin :  std_logic;
signal wram_rdy :  std_logic;
signal ve_datain:  std_logic_vector (15 downto 0);
signal ve_validin:  std_logic;
signal dataout:  std_logic_vector (31 downto 0);
signal validout:  std_logic;
signal validfwd:  std_logic;
signal datafwd:  std_logic_vector (15 downto 0);

signal ps_load :  std_logic := '0';
signal ps_we :  std_logic := '0';
signal ps_addr :  natural range 0 to depth - 1;
signal ps_din :  std_logic_vector(15 downto 0);

signal debug_product_latch: real;

begin

    clk <= not clk after period/2;

    weight : weight_memory
    generic map (depth => ncols)
    port map (
        clk             => clk,
        alrst           => alrst,
        rdy             => wram_rdy,

        re_fwd          => wram_rden,
        vout_fwd        => wram_vin,
        dout_fwd        => wram_din,

        re_bkwd         => '0',
        vout_bkwd       => open,
        dout_bkwd       => open,

        we_bkwd         => '0',
        din_bkwd        => (others => '0'),
        waddr_bkwd      => 0,

        ps_load         => ps_load,
        ps_we           => ps_we,
        ps_re           => '0',
        ps_addr         => ps_addr,
        ps_din          => ps_din,

        ps_dout         => open,
        ps_vout         => open
    );

    pe : row_processor
    generic map (ncols => ncols)
    port map (
        clk             => clk,
        alrst           => alrst,
        ready           => ready,

        wram_rden       => wram_rden,
        wram_din        => wram_din,
        wram_vin        => wram_vin,
        wram_rdy        => wram_rdy,

        ve_datain       => ve_datain,
        ve_validin      => ve_validin,

        dataout         => dataout,
        validout        => validout,

        validfwd        => validfwd,
        datafwd         => datafwd
    );

    debug:
    process (clk, alrst) is
    begin
        if (rising_edge(clk)) then
            if (alrst = '0') then
                debug_product_latch <= 0.0;
            else
                if (validout = '1') then
                    debug_product_latch <=
                        to_real(to_sfixed(dataout, 2*PARAM_DEC - 1, -2*PARAM_FRC));
                end if;
            end if;
        end if;
    end process;

    stimuli : process
    begin
        alrst <= '0';
        wait for 100 ns;
        alrst <= '1';
        wait for 100 ns;

        -- initial value
        ps_load <= '1';
        ps_we <= '1';

        for i in 0 to ncols - 1 loop
            ps_addr <= i;
            ps_din <= slv_16_t(to_sfixed (i, PARAM_DEC - 1, -PARAM_FRC));
            wait for 100 ns;
        end loop;
        ps_load <= '0';
        ps_we <= '0';

        wait until ready = '1';

        -- multiplication test
        ve_validin <= '1';
        for i in 0 to 7 loop
            ve_datain <= slv_16_t(to_sfixed (i, PARAM_DEC - 1, -PARAM_FRC));
            wait for 100 ns;
        end loop;

        ve_validin <= '0';
        wait for 500 ns;

        ve_validin <= '1';
        for i in 0 to 1 loop
            ve_datain <= slv_16_t(to_sfixed (i, PARAM_DEC - 1, -PARAM_FRC));
            wait for 100 ns;
        end loop;

        ve_validin <= '0';

        ps_load <= '1';
        ps_we <= '1';

        for i in 0 to ncols - 1 loop
            ps_addr <= i;
            ps_din <= slv_16_t(to_sfixed (2 * i, PARAM_DEC - 1, -PARAM_FRC));
            wait for 100 ns;
        end loop;
        ps_load <= '0';
        ps_we <= '0';

        wait until ready = '1';

        ve_validin <= '1';
        for i in 0 to 4 loop
            ve_datain <= slv_16_t(to_sfixed (i, PARAM_DEC - 1, -PARAM_FRC));
            wait for 100 ns;
        end loop;

        ve_validin <= '0';

        wait;


    end process;

end tb;
