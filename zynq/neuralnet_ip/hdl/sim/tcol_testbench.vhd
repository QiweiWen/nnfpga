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
signal dl_input: float_2d_arr_t(0 to ntests - 1, 0 to ncols - 1) :=
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

signal all1_input: float_1d_arr_t(0 to ntests * nrows - 1) :=
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

signal apll1_input: float_1d_arr_t(0 to ntests * nrows - 1) :=
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

signal tcol_weights: float_2d_arr_t(0 to ncols - 1, 0 to nrows - 1) :=
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
    wram_rden: out std_logic;
    wram_raddr: out integer range 0 to nrows - 1;
    wram_din : in std_logic_vector (15 downto 0);
    wram_vin : in std_logic;
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
    wram_wren: out std_logic;
    wram_waddr: out integer range 0 to nrows - 1;
    wram_wdata: out std_logic_vector (15 downto 0);
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

signal clk: std_logic := '0';
-- tcol reset signal
signal bp_rst: std_logic := '0';
-- other components reset signal
signal rst: std_logic;

type bram_addr_array_t is array(integer range <>) of
                          integer range 0 to nrows - 1;
type word_array_t is array(integer range <>) of
                          std_logic_vector(15 downto 0);
type dword_array_t is array(integer range <>) of
                          std_logic_vector(31 downto 0);

-- ++++++++++++++++++++++
--   ncols * block ram
-- ++++++++++++++++++++++
signal ram_re_a_array: std_logic_vector(ncols - 1 downto 0);
signal ram_addr_a_array: bram_addr_array_t(ncols - 1 downto 0);
signal ram_vout_a_array: std_logic_vector(ncols - 1 downto 0);
signal ram_dout_a_array: word_array_t(ncols - 1 downto 0);
signal ram_re_b_array: std_logic_vector(ncols - 1 downto 0);
signal ram_addr_b_array: bram_addr_array_t(ncols - 1 downto 0);
signal ram_vout_b_array: std_logic_vector(ncols - 1 downto 0);
signal ram_dout_b_array: word_array_t(ncols - 1 downto 0);
signal ram_addr_c_array: bram_addr_array_t(ncols - 1 downto 0);
signal ram_vin_c_array: std_logic_vector(ncols - 1 downto 0);
signal ram_din_c_array: word_array_t(ncols - 1 downto 0);

-- ++++++++++++++++++++++
--    ncols * dL FIFO
-- ++++++++++++++++++++++
signal dL_writeen_array: std_logic_vector(ncols - 1 downto 0);
signal dL_datain_array: word_array_t(ncols -1 downto 0);
signal dL_readen_array: std_logic_vector(ncols - 1 downto 0);
signal dL_dataout_array: word_array_t(ncols - 1 downto 0);
signal dL_ackout_array: std_logic_vector(ncols - 1 downto 0);
signal dL_validout_array: std_logic_vector(ncols - 1 downto 0);
signal dL_empty_array: std_logic_vector(ncols - 1 downto 0);
signal dL_full_array: std_logic_vector(ncols - 1 downto 0);

-- ++++++++++++++++++++++
--      1 * aLL1 FIFO
-- ++++++++++++++++++++++
signal aLL1_writeen: std_logic;
signal aLL1_datain: std_logic_vector (data_width - 1 downto 0);
signal aLL1_readen: std_logic;
signal aLL1_dataout: std_logic_vector (data_width - 1 downto 0);
signal aLL1_ackout: std_logic;
signal aLL1_validout: std_logic;
signal aLL1_empty: std_logic;
signal aLL1_full: std_logic;

-- ++++++++++++++++++++++
--      1 * apLL1 FIFO
-- ++++++++++++++++++++++
signal apLL1_writeen: std_logic;
signal apLL1_datain: std_logic_vector (data_width - 1 downto 0);
signal apLL1_readen: std_logic;
signal apLL1_dataout: std_logic_vector (data_width - 1 downto 0);
signal apLL1_ackout: std_logic;
signal apLL1_validout: std_logic;
signal apLL1_empty: std_logic;
signal apLL1_full: std_logic;

-- +++++++++++++++++++++++
--   misc. tcol signals
-- +++++++++++++++++++++++
signal tcol_osync_array: std_logic_vector(ncols - 1 downto 0);
signal tcol_isync_array: std_logic_vector(ncols - 1 downto 0);
signal tcol_ivfwd_array: std_logic_vector(ncols - 1 downto 0);
signal tcol_idfwd_array: dword_array_t(ncols - 1 downto 0);
signal tcol_ovfwd_array: std_logic_vector(ncols - 1 downto 0);
signal tcol_odfwd_array: dword_array_t(ncols - 1 downto 0);
signal tcol_validout_array: std_logic_vector(ncols - 1 downto 0);
signal tcol_deltaout_array: word_array_t(ncols - 1 downto 0);
signal tcol_wram_wren_array: std_logic_vector(ncols - 1 downto 0);
signal tcol_wram_waddr_array: bram_addr_array_t(ncols - 1 downto 0);
signal tcol_wram_wdata_array: word_array_t(ncols - 1 downto 0);
signal tcol_bias_change_dout_array: word_array_t(ncols - 1 downto 0);
signal tcol_bias_change_vout_array: std_logic_vector(ncols - 1 downto 0);
signal tcol_all1_datain_array: word_array_t(ncols - 1 downto 0);
signal tcol_all1_validin_array: std_logic_vector(ncols - 1 downto 0);
signal tcol_all1_req_array: std_logic_vector(ncols - 1 downto 0);
signal tcol_all1_fwd_array: word_array_t(ncols - 1 downto 0);
signal tcol_all1_vfwd_array: std_logic_vector(ncols - 1 downto 0);
signal tcol_apll1_datain_array: word_array_t(ncols - 1 downto 0);
signal tcol_apll1_validin_array: std_logic_vector(ncols - 1 downto 0);
signal tcol_apll1_req_array: std_logic_vector(ncols - 1 downto 0);

-- +++++++++++++++++++++++
--     Debug signals
-- +++++++++++++++++++++++
signal bias_derivative: float_1d_arr_t(ncols - 1 downto 0) := (others => 42.0);
signal weight_derivative: float_1d_arr_t(ncols - 1 downto 0) := (others => 42.0);
signal dLL1: real := 42.0;


begin
    debug_process: process(clk) is
        variable waddr: integer;
    begin
        if (rising_edge(clk)) then
            if (rst = '0') then
                bias_derivative <= (others => 42.0);
                weight_derivative <= (others => 42.0);
                dLL1 <= 42.0;
            else
                for I in 0 to ncols - 1 loop
                    if (tcol_bias_change_vout_array(I) = '1') then
                        bias_derivative(I) <= -1 *
                                              to_real(to_sfixed(tcol_bias_change_dout_array(I),
                                                      PARAM_DEC - 1, -PARAM_FRC));
                    end if;

                    if (tcol_wram_wren_array(I) = '1') then
                        waddr := tcol_wram_waddr_array(I);
                        weight_derivative(I) <= tcol_weights(I, waddr) -
                                                to_real(to_sfixed(tcol_wram_wdata_array(I),
                                                        PARAM_DEC - 1, -PARAM_FRC));
                    end if;
                end loop;

                if (tcol_validout_array(ncols - 1) = '1') then
                    dLL1 <= to_real(to_sfixed(tcol_deltaout_array(ncols - 1),
                                    PARAM_DEC - 1, -PARAM_FRC));
                end if;

            end if;
        end if;
    end process;

    clk <= not clk after period/2;

    aLL1_inst: std_fifo
    generic map (data_width => 16, fifo_depth => ntests * nrows)
    port map
    (
        clk     => clk,
        rst     => rst,
        writeen => aLL1_writeen,
        datain  => aLL1_datain,
        readen  => aLL1_readen,
        dataout => aLL1_dataout,
        ackout  => aLL1_ackout,
        validout => aLL1_validout,
        empty   => aLL1_empty,
        full    => aLL1_full
    );

    apLL1_inst: std_fifo
    generic map (data_width => 16, fifo_depth => ntests * nrows)
    port map
    (
        clk     => clk,
        rst     => rst,
        writeen => apLL1_writeen,
        datain  => apLL1_datain,
        readen  => apLL1_readen,
        dataout => apLL1_dataout,
        ackout  => apLL1_ackout,
        validout => apLL1_validout,
        empty   => apLL1_empty,
        full    => apLL1_full
    );

    dutgen:
    for I in 0 to ncols - 1 generate
        -- generate each of the word fifos and
        -- weight rams and wire them up
        dut_dl_fifo: std_fifo
        generic map (data_width => 16, fifo_depth => ntests * nrows)
        port map
        (
            clk     => clk,
            rst     => rst,
            writeen => dL_writeen_array(I),
            datain  => dL_datain_array(I),
            readen  => dL_readen_array(I),
            dataout => dL_dataout_array(I),
            ackout  => dL_ackout_array(I),
            validout => dL_validout_array(I),
            empty   => dL_empty_array(I),
            full    => dL_full_array(I)
        );

        dut_weight_ram: three_port_ram
        generic map(width => 16, depth => nrows)
        port map
        (
            clk     => clk,
            alrst   => rst,
            re_a    => ram_re_a_array(I),
            addr_a  => ram_addr_a_array(I),
            vout_a  => ram_vout_a_array(I),
            dout_a  => ram_dout_a_array(I),
            re_b    => ram_re_b_array(I),
            addr_b  => ram_addr_b_array(I),
            vout_b  => ram_vout_b_array(I),
            dout_b  => ram_dout_b_array(I),
            addr_c  => ram_addr_c_array(I),
            vin_c   => ram_vin_c_array(I),
            din_c   => ram_din_c_array(I)
        );

        dut_tcol_proc: tcol_processor
        generic map(nrows => nrows)
        port map
        (
            clk         => clk,
            alrst       => bp_rst,
            wram_rden     => ram_re_a_array(I),
            wram_raddr    => ram_addr_a_array(I),
            wram_din      => ram_dout_a_array(I),
            wram_vin      => ram_vout_a_array(I),
            dl_datain   => dL_dataout_array(I),
            dl_validin  => dL_validout_array(I),
            dl_req      => dL_readen_array(I),
            dl_ack      => dL_ackout_array(I),
            osync       => tcol_osync_array(I),
            isync       => tcol_isync_array(I),
            ivfwd       => tcol_ivfwd_array(I),
            idfwd       => tcol_idfwd_array(I),
            ovfwd       => tcol_ovfwd_array(I),
            odfwd       => tcol_odfwd_array(I),
            validout    => tcol_validout_array(I),
            deltaout    => tcol_deltaout_array(I),
            wram_wren     => tcol_wram_wren_array(I),
            wram_waddr    => tcol_wram_waddr_array(I),
            wram_wdata    => tcol_wram_wdata_array(I),
            bias_change_dout => tcol_bias_change_dout_array(I),
            bias_change_vout => tcol_bias_change_vout_array(I),
            all1_datain => tcol_all1_datain_array(I),
            all1_validin => tcol_all1_validin_array(I),
            all1_req => tcol_all1_req_array(I),
            all1_fwd => tcol_all1_fwd_array(I),
            all1_vfwd => tcol_all1_vfwd_array(I),
            apll1_datain => tcol_apll1_datain_array(I),
            apll1_validin => tcol_apll1_validin_array(I),
            apll1_req => tcol_apll1_req_array(I)
        );

        tcol_isync_array(I) <= '1' when I = 0 else tcol_osync_array(I - 1);
        tcol_ivfwd_array(I) <= '1' when I = 0 else tcol_ovfwd_array(I - 1);
        tcol_idfwd_array(I) <= (others => '0') when I = 0 else tcol_odfwd_array(I - 1);

        tcol_all1_datain_array(I) <= aLL1_dataout when I = 0 else tcol_all1_fwd_array(I - 1);
        tcol_all1_validin_array(I) <= aLL1_validout when I = 0 else tcol_all1_vfwd_array(I - 1);

        tcol_apll1_datain_array(I) <= apLL1_dataout when I = ncols - 1 else (others => '0');
        tcol_apll1_validin_array(I) <= apLL1_validout when I = ncols - 1 else '0';

    end generate;

    aLL1_readen <= tcol_all1_req_array(0);
    apLL1_readen <= tcol_apll1_req_array(ncols - 1);

    -- tie down unused ports
    ram_re_b_array <= (others => '0');
    ram_addr_b_array <= (others => 0);

    stimulus: process is
        procedure param_put (
            signal target: out std_logic_vector (15 downto 0);
            constant value : real
        )is
        begin
            target <= slv_16_t (to_sfixed (value, PARAM_DEC - 1, -PARAM_FRC));
        end procedure;
    begin
        rst <= '0';
        bp_rst <= '0';
        for I in 0 to ncols - 1 loop
            dL_writeen_array(I) <= '0';
            dL_datain_array(I) <= (others => '0');
            ram_vin_c_array(I) <= '0';
            ram_din_c_array(I) <= (others => '0');
            ram_addr_c_array(I) <= 0;
        end loop;
        aLL1_writeen <= '0';
        aLL1_datain <= (others => '0');
        apLL1_writeen <= '0';
        apLL1_datain <= (others => '0');
        wait for period;
        rst <= '1';
        -- set up all1 and apll1 fifo
        aLL1_writeen <= '1';
        apLL1_writeen <= '1';
        for I in 0 to ntests * nrows - 1 loop
            param_put(aLL1_datain, all1_input(I));
            param_put(apLL1_datain, apll1_input(I));
            wait for 100 ns;
        end loop;
        apLL1_writeen <= '0';
        aLL1_writeen <= '0';

        -- set up dL fifos
        dl_writeen_array <= (others => '1');
        for I in 0 to ntests - 1 loop
            for J in 0 to ncols - 1 loop
                param_put(dL_datain_array(J), dl_input(I, J));
            end loop;
            wait for 100 ns;
        end loop;
        dl_writeen_array <= (others => '0');

        -- set up blockram weights
        ram_vin_c_array <= (others => '1');
        for I in 0 to nrows - 1 loop
            ram_addr_c_array <= (others => I);
            for J in 0 to ncols - 1 loop
                param_put(ram_din_c_array(J), tcol_weights(J, I));
            end loop;
            wait for 100 ns;
        end loop;
        ram_vin_c_array <= (others => '0');
        bp_rst <= '1';
        wait;
    end process;

end behavioural;
