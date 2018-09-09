library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library ieee_proposed;
use work.fixed_pkg.all;

use ieee.math_real.all;

use work.helperpkg.all;
use work.nn_arith_package.all;

entity tcol_testbench is
end tcol_testbench;

architecture behavioural of tcol_testbench is

-- This TB puts an array of tcol processors to the test
-- nrows = tcol size, ncols = #instances
constant ntests: integer := 10;
constant ncols : integer := 5;
constant nrows : integer := 8;
constant data_width : integer := 16;
constant period: time := 100 ns;

type float_2d_arr_t is array (integer range <>, integer range <>) of real;
type float_1d_arr_t is array (integer range <>) of real;

-- first dimension: each test case
-- second dimension: element in each dl fifo
signal dl_input: float_2d_arr_t(ntests - 1 downto 0, ncols - 1 downto 0) :=
    ((-0.381193,0.651545,0.417554,0.589392,0.306240),
    (-0.365389,0.659172,0.395017,0.572511,0.281734),
    (0.608586,-0.345382,0.400250,0.589144,0.280464),
    (-0.384751,0.657054,0.410815,0.589974,0.288783),
    (0.620313,-0.343151,0.408126,0.579990,0.317036),
    (0.613947,0.670968,-0.600880,0.573533,0.309431),
    (0.611824,0.669123,0.399562,0.583780,-0.703021),
    (0.639112,-0.346104,0.412496,0.589801,0.307787),
    (-0.387744,0.674816,0.400102,0.581529,0.301592),
    (0.638633,0.670508,0.404044,0.584788,-0.708483));

signal all1_input: float_1d_arr_t(ntests * nrows - 1 downto 0) :=
    (0.502839,0.422817,0.599461,0.272314,0.573418,0.404518,0.199917,0.545752,
    0.440281,0.435661,0.650539,0.517641,0.571945,0.386644,0.293389,0.627112,
    0.397033,0.453427,0.635725,0.392508,0.692474,0.415871,0.319699,0.597401,
    0.394989,0.453282,0.647953,0.388254,0.641013,0.399722,0.239150,0.544242,
    0.531790,0.420005,0.523549,0.298821,0.520096,0.506789,0.262708,0.616325,
    0.456489,0.409234,0.514586,0.400829,0.607166,0.584096,0.366323,0.592547,
    0.452582,0.425404,0.578934,0.386667,0.689834,0.546842,0.345383,0.578846,
    0.645215,0.367937,0.654221,0.254769,0.588150,0.472440,0.247113,0.602358,
    0.386656,0.486426,0.549601,0.459429,0.620028,0.559125,0.269921,0.582694,
    0.507551,0.435053,0.672456,0.454738,0.632737,0.444412,0.191653,0.551874);

signal apll1_input: float_1d_arr_t(ntests * nrows - 1 downto 0) :=
    (0.249992,0.244043,0.240108,0.198159,0.244610,0.240883,0.159950,0.247907,
    0.246434,0.245860,0.227338,0.249689,0.244824,0.237150,0.207312,0.233843,
    0.239398,0.247831,0.231579,0.238445,0.212954,0.242922,0.217492,0.240513,
    0.238973,0.247817,0.228110,0.237513,0.230115,0.239944,0.181957,0.248043,
    0.248989,0.243601,0.249445,0.209527,0.249596,0.249954,0.193692,0.236469,
    0.248107,0.241761,0.249787,0.240165,0.238515,0.242928,0.232131,0.241435,
    0.247752,0.244435,0.243769,0.237156,0.213963,0.247806,0.226094,0.243783,
    0.228913,0.232559,0.226216,0.189862,0.242230,0.249240,0.186048,0.239523,
    0.237153,0.249816,0.247540,0.248354,0.235593,0.246504,0.197064,0.243162,
    0.249943,0.245782,0.220259,0.247951,0.232381,0.246910,0.154922,0.247309);

signal tcol_weights: float_2d_arr_t(ncols - 1 downto 0, nrows - 1 downto 0) :=
    ((0.324416,-0.492426,0.399589,0.368251,-0.240314,0.112991,-0.259429,0.114863),
    (0.268788,0.257569,-0.102694,0.392164,0.088052,0.345470,0.000559,-0.460112),
    (-0.170633,0.026760,0.339232,-0.348056,-0.328511,0.128848,-0.022117,-0.399690),
    (-0.332290,-0.226555,0.266364,-0.351629,0.294623,0.167614,-0.439330,0.367802),
    (0.012386,-0.209305,-0.210173,-0.242974,-0.433240,0.447950,-0.164030,-0.265589));


component tcol_processor is
generic (
    nrows: integer := 100
);
port (
    clk:    in std_logic;
    alrst:  in std_logic;
    l1_rden: out std_logic;
    l1_raddr: out integer range 0 to nrows - 1;
    l1_din : in std_logic_vector (15 downto 0);
    l1_vin : in std_logic;
    dl_datain: in std_logic_vector (15 downto 0);
    dl_validin: in std_logic;
    dl_req     : out std_logic;
    dl_ack     : in std_logic;
    osync:   out std_logic;
    isync:   in std_logic;
    ivfwd: in std_logic;
    idfwd: in std_logic_vector (31 downto 0);
    ovfwd: out std_logic;
    odfwd: out std_logic_vector (31 downto 0);
    validout: out std_logic;
    deltaout: out std_logic_vector (15 downto 0);
    l1_wren: out std_logic;
    l1_waddr: out integer range 0 to nrows - 1;
    l1_wdata: out std_logic_vector (15 downto 0);
    bias_change_dout: out std_logic_vector (15 downto 0);
    bias_change_vout: out std_logic;
    all1_datain: in std_logic_vector (15 downto 0);
    all1_validin: in std_logic;
    all1_req: out std_logic;
    all1_fwd: out std_logic_vector (15 downto 0);
    all1_vfwd: out std_logic;
    apll1_datain: in std_logic_vector (15 downto 0);
    apll1_validin: in std_logic;
    apll1_req: out std_logic
);
end component tcol_processor;

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

component std_fifo is
    generic (
        constant data_width  : positive := 8;
        constant fifo_depth  : positive := 256
    );
    port (
        clk	: in  std_logic;
        rst	: in  std_logic;
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

signal clk: std_logic;
-- reset signal for the fifos and blockram
signal param_rst: std_logic;
-- reset signal for the transpose column processor
signal bp_rst: std_logic;
begin
    clk <= not clk after period/2;

end behavioural;
