library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library ieee_proposed;
use work.fixed_pkg.all;

use ieee.math_real.all;

use work.helperpkg.all;
use work.nn_arith_package.all;

entity trow_testbench is
end trow_testbench;

architecture Behavioral of trow_testbench is

constant ntests: natural := 10;

constant ncols : natural := 5;
constant ram_depth : natural := ncols;
constant dfifo : natural := ntests;
constant data_width : natural := 16;

constant period: time := 100 ns;

type testcase_t is array (natural range <>) of real;
signal dl_testcases: testcase_t (0 to ntests * ncols - 1) :=
(0.583486,0.574348,0.319676,-0.797673,0.450610,
0.611267,0.572265,-0.667909,0.192147,0.437322,
-0.378571,0.548800,0.311309,0.187077,0.443624,
0.592730,0.591352,0.335260,0.196285,-0.553438,
0.593162,0.567203,0.336407,0.190221,-0.579405,
-0.392324,0.555430,0.321170,0.193191,0.436045,
0.601545,0.548151,0.326464,0.202326,-0.555112,
0.591166,0.575220,0.334778,-0.805444,0.441277,
0.584197,0.578320,0.329827,-0.798744,0.451349,
0.607979,-0.440198,0.327813,0.195254,0.441677);

signal all1_testcases: testcase_t (0 to ntests - 1) :=
(0.387906,0.376820,0.274759,0.445996,0.319601,
0.322106,0.237987,0.313754,0.360545,0.315768);

signal apll1_testcases: testcase_t (0 to ntests - 1) :=
(0.237435,0.234827,0.199266,0.247084,0.217456,
0.218354,0.181349,0.215313,0.230552,0.216059);

signal initial_weight: testcase_t (0 to ncols - 1) :=
(-0.139193,0.251833,-0.375736,-0.132665,-0.059883);

component trow_processor is
generic (
    ncols: natural := 100
);
port(
    clk: in std_logic;
    alrst: in std_logic;
    ready : out std_logic;
    dl_datain: in std_logic_vector (15 downto 0);
    dl_validin: in std_logic;
    deltaout: out std_logic_vector (15 downto 0);
    validout: out std_logic;
    validfwd: out std_logic;
    deltafwd: out std_logic_vector (15 downto 0);
    wram_rden: out std_logic;
    wram_din : in std_logic_vector (15 downto 0);
    wram_vin : in std_logic;
    wram_rdy : in std_logic;
    wram_wren: out std_logic;
    wram_waddr: out natural range 0 to ncols - 1;
    wram_wdata: out std_logic_vector (15 downto 0);
    bias_change_dout: out std_logic_vector (15 downto 0);
    bias_change_vout: out std_logic;
    all1_datain: in std_logic_vector (15 downto 0);
    all1_validin: in std_logic;
    all1_rden: out std_logic;
    all1_empty: in std_logic;
    apll1_datain: in std_logic_vector (15 downto 0);
    apll1_validin: in std_logic;
    apll1_rden: out std_logic;
    apll1_empty: in std_logic
);
end component trow_processor;

component cached_fifo is
generic
(
    fifo_depth : natural := 128
);
port
(
    clk     : in std_logic;
    alrst   : in std_logic;
    writeen	: in  std_logic;
    datain	: in  std_logic_vector (15 downto 0);
    readen	: in  std_logic;
    dataout	: out std_logic_vector (15 downto 0);
    validout: out std_logic;
    empty	: out std_logic;
    full	: out std_logic
);
end component cached_fifo;

component weight_memory is
generic (
    depth : natural := 128
);
port
(
    clk : in std_logic;
    alrst : in std_logic;
    rdy : out std_logic;
    re_fwd: in std_logic;
    vout_fwd : out std_logic;
    dout_fwd : out std_logic_vector(15 downto 0);
    re_bkwd: in std_logic;
    vout_bkwd : out std_logic;
    dout_bkwd : out std_logic_vector(15 downto 0);
    we_bkwd : in std_logic;
    din_bkwd : in std_logic_vector(15 downto 0);
    waddr_bkwd : in natural range 0 to ram_depth - 1;
    ps_load : in std_logic;
    ps_we : in std_logic;
    ps_re : in std_logic;
    ps_addr : in natural range 0 to ram_depth - 1;
    ps_din : in std_logic_vector(15 downto 0);
    ps_dout : out std_logic_vector(15 downto 0);
    ps_vout : out std_logic
);
end component weight_memory;

-- weight memory signals
signal clk : std_logic := '0';
signal alrst : std_logic;
signal wram_rdy : std_logic;
signal re_bkwd : std_logic;
signal vout_bkwd : std_logic;
signal dout_bkwd : std_logic_vector(15 downto 0);
signal ps_load : std_logic;
signal ps_we : std_logic;
signal ps_addr : natural range 0 to ram_depth - 1;
signal ps_din : std_logic_vector(15 downto 0);

-- all1 fifo signals
signal all1_writeen : std_logic;
signal all1_datain : std_logic_vector (15 downto 0);
signal all1_readen : std_logic;
signal all1_dataout : std_logic_vector (15 downto 0);
signal all1_validout : std_logic;
signal all1_empty : std_logic;

-- apll1 fifo signals
signal apll1_writeen : std_logic;
signal apll1_datain : std_logic_vector (15 downto 0);
signal apll1_readen : std_logic;
signal apll1_dataout : std_logic_vector (15 downto 0);
signal apll1_validout : std_logic;
signal apll1_empty : std_logic;

-- backprop output and debug signals
signal wram_wren_bp: std_logic;
signal wram_waddr_bp: natural range 0 to ncols - 1;
signal wram_wdata_bp: std_logic_vector (15 downto 0);
signal deltaout : std_logic_vector (15 downto 0);
signal trow_validout : std_logic;

signal deltaout_debug: real;
signal wram_wdata_debug: real;
signal wram_rdata_debug: real;

-- misc. trow signals
signal trow_ready: std_logic;

signal dl_datain: std_logic_vector(15 downto 0);
signal dl_validin: std_logic;

signal bias_change_dout: std_logic_vector(15 downto 0);
signal bias_change_vout: std_logic;

begin

clk <= not clk after period/2;

debug_process: process (clk, alrst) is
begin
    if (rising_edge(clk)) then
        if (alrst = '0') then
            deltaout_debug <= -42.0;
            wram_wdata_debug <= -42.0;
            wram_rdata_debug <= -42.0;
        else
            if (trow_validout = '1') then
                deltaout_debug <= to_real(to_sfixed(deltaout, PARAM_DEC - 1, -PARAM_FRC));
            end if;

            if (vout_bkwd = '1') then
                wram_rdata_debug <= to_real(to_sfixed(dout_bkwd, PARAM_DEC - 1, -PARAM_FRC));
            end if;

            if (wram_wren_bp = '1') then
                wram_wdata_debug <= to_real(to_sfixed(wram_wdata_bp, PARAM_DEC - 1, -PARAM_FRC));
            end if;

        end if;
    end if;
end process;

uut: trow_processor
generic map (ncols => ncols)
port map (
    clk                 => clk,
    alrst               => alrst,
    ready               => trow_ready,
    dl_datain           => dl_datain,
    dl_validin          => dl_validin,
    deltaout            => deltaout,
    validout            => trow_validout,
    validfwd            => open,
    deltafwd            => open,
    wram_rden           => re_bkwd,
    wram_din            => dout_bkwd,
    wram_vin            => vout_bkwd,
    wram_rdy            => wram_rdy,
    wram_wren           => wram_wren_bp,
    wram_waddr          => wram_waddr_bp,
    wram_wdata          => wram_wdata_bp,
    bias_change_dout    => bias_change_dout,
    bias_change_vout    => bias_change_vout,
    all1_datain         => all1_dataout,
    all1_validin        => all1_validout,
    all1_rden           => all1_readen,
    all1_empty          => all1_empty,
    apll1_datain        => apll1_dataout,
    apll1_validin       => apll1_validout,
    apll1_rden          => apll1_readen,
    apll1_empty         => apll1_empty
);

weightram: weight_memory
generic map (depth => ram_depth)
port map (
    clk                 => clk,
    alrst               => alrst,
    rdy                 => wram_rdy,
    re_fwd              => '0',
    vout_fwd            => open,
    dout_fwd            => open,
    re_bkwd             => re_bkwd,
    vout_bkwd           => vout_bkwd,
    dout_bkwd           => dout_bkwd,
    we_bkwd             => '0',
    din_bkwd            => (others => '0'),
    waddr_bkwd          => 0,
    ps_load             => ps_load,
    ps_we               => ps_we,
    ps_re               => '0',
    ps_addr             => ps_addr,
    ps_din              => ps_din,
    ps_dout             => open,
    ps_vout             => open
);

all1_fifo: cached_fifo
generic map (fifo_depth => dfifo * ncols)
port map (
    clk                 => clk,
    alrst               => alrst,
    writeen             => all1_writeen,
    datain              => all1_datain,
    readen              => all1_readen,
    dataout             => all1_dataout,
    validout            => all1_validout,
    empty               => all1_empty,
    full                => open
);

apll1_fifo: cached_fifo
generic map (fifo_depth => dfifo * ncols)
port map (
    clk                 => clk,
    alrst               => alrst,
    writeen             => apll1_writeen,
    datain              => apll1_datain,
    readen              => apll1_readen,
    dataout             => apll1_dataout,
    validout            => apll1_validout,
    empty               => apll1_empty,
    full                => open
);

stimuli: process
    procedure param_put (
        signal target: out std_logic_vector (15 downto 0);
        constant value : real
    )is
    begin
        target <= slv_16_t (to_sfixed (value, PARAM_DEC - 1, -PARAM_FRC));
    end procedure;
begin
    alrst <= '0';
    wait for 100 ns;
    alrst <= '1';
    ps_load <= '1';
    dl_validin <= '0';
    wait for 100 ns;

    ps_we <= '1';
    -- set up initial weight
    for i in 0 to ncols - 1 loop
        ps_addr <= i;
        param_put (ps_din, initial_weight (i));
        wait for 100 ns;
    end loop;
    ps_we <= '0';
    ps_load <= '0';

    all1_writeen <= '1';
    apll1_writeen <= '1';
    -- set up sigmoid and sigmoid prime fifos
    for i in 0 to ntests - 1 loop
        param_put (all1_datain, all1_testcases (i));
        param_put (apll1_datain, apll1_testcases (i));
        wait for 100 ns;
    end loop;
    all1_writeen <= '0';
    apll1_writeen <= '0';

    if trow_ready /= '1' then
        wait until trow_ready = '1';
    end if;

    dl_validin <= '1';
    -- set up delta input vector fifo
    for i in 0 to ntests * ncols - 1 loop
        param_put (dl_datain, dl_testcases (i));
        wait for 100 ns;
    end loop;
    dl_validin <= '0';

    wait;
end process;


end Behavioral;
