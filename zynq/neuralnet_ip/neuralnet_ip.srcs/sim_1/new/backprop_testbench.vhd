library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library ieee_proposed;
use ieee_proposed.fixed_pkg.all;

use ieee.math_real.all;

use work.helperpkg.all;
use work.nn_arith_package.all;

entity backprop_testbench is
end backprop_testbench;

architecture Behavioral of backprop_testbench is

constant ntests: integer := 10;

constant ntcols: integer := 5;
constant ncols : integer := ntcols;
constant dfifo : integer := ntests;
constant data_width : integer := 16;

constant period: time := 100 ns;

type testcase_t is array (integer range <>) of real; 
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
    ncols: integer := 100
);
port(
    debug : out std_logic_vector (16 downto 0);
    clk: in std_logic;
    alrst: in std_logic;
-- delta vector input channel
    dl_datain: in std_logic_vector (15 downto 0);
    dl_validin: in std_logic;
    dl_ack     : in std_logic;
    dl_req     : out std_logic;
-- product terms output channel
    deltaout: out std_logic_vector (15 downto 0);
    validout: out std_logic;
-- vector input forwarded to the adjacent row processor down the line
    validfwd: out std_logic;
    deltafwd: out std_logic_vector (15 downto 0);
-- weight memory read ports 
    l1_rden: out std_logic;
    l1_raddr: out integer range 0 to ncols - 1; 
    l1_din : in std_logic_vector (15 downto 0);
    l1_vin : in std_logic;
-- weight memory write ports
    l1_wren: out std_logic;
    l1_waddr: out integer range 0 to ncols - 1;
    l1_wdata: out std_logic_vector (15 downto 0);
-- bias unit write ports
    bias_change_dout: out std_logic_vector (15 downto 0);
    bias_change_vout: out std_logic;
-- aL-1 input for derivative calculation
    all1_datain: in std_logic_vector (15 downto 0);
    all1_validin: in std_logic;
    all1_req: out std_logic;
-- sigmoid-prime L-1 input for backprop
    apll1_datain: in std_logic_vector (15 downto 0);
    apll1_validin: in std_logic;
    apll1_req: out std_logic
);
end component trow_processor;

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

signal deltaout_debug: real;
signal l1_wdata_debug: real;
signal l1_rdata_debug: real;
signal gradient_descent_step: real;

signal all1_readen  : std_logic;
signal all1_dataout : std_logic_vector (data_width - 1 downto 0);
signal all1_ackout  : std_logic;
signal all1_validout: std_logic;

signal apll1_readen  : std_logic;
signal apll1_dataout : std_logic_vector (data_width - 1 downto 0);
signal apll1_ackout  : std_logic;
signal apll1_validout: std_logic;

signal dl_readen  : std_logic;
signal dl_readen_bp: std_logic;
signal dl_dataout : std_logic_vector (data_width - 1 downto 0);
signal dl_ackout  : std_logic;
signal dl_validout: std_logic;

signal deltaout: std_logic_vector (15 downto 0);

signal trow_validout: std_logic;

signal l1_rden: std_logic;
signal l1_raddr: integer range 0 to ncols - 1; 
signal l1_din : std_logic_vector (15 downto 0);
signal l1_vin : std_logic;

signal l1_wren: std_logic;
signal l1_waddr: integer range 0 to ncols - 1;
signal l1_wdata: std_logic_vector (15 downto 0);

signal l1_wren_bp: std_logic;
signal l1_waddr_bp: integer range 0 to ncols - 1;
signal l1_wdata_bp: std_logic_vector (15 downto 0);

signal bp_debug: std_logic_vector (16 downto 0);

-- testbench signals

signal rst: std_logic;
signal bp_rst: std_logic;


signal l1_wren_tb: std_logic;
signal l1_waddr_tb: integer range 0 to ncols - 1;
signal l1_wdata_tb: std_logic_vector (15 downto 0);

signal apll1_writeen : std_logic;
signal apll1_datain  : std_logic_vector (data_width - 1 downto 0);

signal dl_writeen : std_logic;
signal dl_datain  : std_logic_vector (data_width - 1 downto 0);

signal all1_writeen : std_logic;
signal all1_datain  : std_logic_vector (data_width - 1 downto 0);


begin

l1_wren <= l1_wren_tb;
l1_waddr <= l1_waddr_tb;
l1_wdata <= l1_wdata_tb;

clk <= not clk after period/2; 

debug_process: process (clk, rst) is
begin
    if (rising_edge(clk)) then
        if (rst = '0') then
            deltaout_debug <= -42.0;
            l1_wdata_debug <= -42.0;
            l1_rdata_debug <= -42.0;
            gradient_descent_step <= -42.0;
        else
            if (trow_validout = '1') then
                deltaout_debug <= to_real (to_sfixed(deltaout, PARAM_DEC - 1, -PARAM_FRC));
            end if;

            if (l1_vin = '1') then
                l1_rdata_debug <= to_real (to_sfixed(l1_din, PARAM_DEC - 1, -PARAM_FRC));
            end if;

            if (l1_wren_bp = '1') then
                l1_wdata_debug <= to_real (to_sfixed(l1_wdata_bp, PARAM_DEC - 1, -PARAM_FRC));
            end if;

            if (bp_debug (16) = '1') then
                gradient_descent_step <= to_real (to_sfixed (bp_debug(15 downto 0),
                                                  PARAM_DEC - 1, -PARAM_FRC));
            end if;

        end if;
    end if;
end process;

dl_fifo: std_fifo
generic map (data_width => 16, fifo_depth => dfifo * ntcols)  
port map (
    clk => clk,
    rst => rst,
    writeen => dl_writeen,
    datain => dl_datain,
    readen => dl_readen,
    dataout => dl_dataout,
    ackout => dl_ackout,
    validout => dl_validout,
    empty => open,
    full => open
);

dl_readen <= dl_readen_bp;

all1_fifo: std_fifo
generic map (data_width => 16, fifo_depth => dfifo)  
port map (
    clk => clk,
    rst => rst,
    writeen => all1_writeen,
    datain => all1_datain,
    readen => all1_readen,
    dataout => all1_dataout,
    ackout => all1_ackout,
    validout => all1_validout,
    empty => open,
    full => open
);

apll1_fifo: std_fifo
generic map (data_width => 16, fifo_depth => dfifo)  
port map (
    clk => clk,
    rst => rst,
    writeen => apll1_writeen,
    datain => apll1_datain,
    readen => apll1_readen,
    dataout => apll1_dataout,
    ackout => apll1_ackout,
    validout => apll1_validout,
    empty => open,
    full => open
);

backprop: trow_processor
generic map (ncols => ntcols)
port map (
    debug => bp_debug,    

    clk   => clk,
    alrst => bp_rst,
    dl_datain => dl_dataout,
    dl_validin => dl_validout,
    dl_ack  => dl_ackout,
    dl_req  =>  dl_readen_bp,
    deltaout => deltaout,
    validout => trow_validout,
    
    validfwd => open,
    deltafwd => open,
    
    l1_rden => l1_rden,
    l1_raddr => l1_raddr,
    l1_din => l1_din,
    l1_vin => l1_vin,

    l1_wren => l1_wren_bp,
    l1_waddr => l1_waddr_bp,
    l1_wdata => l1_wdata_bp,

    bias_change_dout => open,
    bias_change_vout => open,

    all1_datain => all1_dataout,
    all1_validin => all1_validout,
    all1_req => all1_readen,

    apll1_datain => apll1_dataout,
    apll1_validin => apll1_validout,
    apll1_req => apll1_readen
);

weight_memory: three_port_ram
generic map (width => 16, depth => ntcols)
port map (
    clk     => clk,
    alrst   => rst,
    
    re_a    => l1_rden,
    addr_a  => l1_raddr,
    vout_a  => l1_vin,
    dout_a  => l1_din,

    re_b    => '0',
    addr_b  => 0,
    vout_b  => open,
    dout_b  => open,

    addr_c  => l1_waddr,
    vin_c   => l1_wren,
    din_c   => l1_wdata
);

stimuli: process
    procedure param_put (
        signal target: out std_logic_vector (15 downto 0); 
        constant value : real 
    )is
        subtype word_t is std_logic_vector (15 downto 0);
    begin
        target <= word_t (to_sfixed (value, PARAM_DEC - 1, -PARAM_FRC));
    end procedure;
begin

-- hold trow_processor reset signal low, set up parameters
    rst             <= '0';
    bp_rst          <= '0';
    l1_wren_tb      <= '0';
    l1_waddr_tb     <= 0;
    l1_wdata_tb     <= (others => '0');
    apll1_writeen   <= '0';
    apll1_datain    <= (others => '0');
    dl_writeen      <= '0';
    dl_datain       <= (others => '0');
    all1_writeen    <= '0';
    all1_datain     <= (others => '0');
    wait for period;
    rst <= '1';
    wait for period;
    l1_wren_tb <= '1';
    -- set up initial weight
    for i in 0 to ncols - 1 loop
        l1_waddr_tb <= i;
        param_put (l1_wdata_tb, initial_weight (i)); 
        wait for 100 ns;
    end loop;
    l1_wren_tb <= '0';
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
    dl_writeen <= '1';
    -- set up delta input vector fifo
    for i in 0 to ntests * ncols - 1 loop
        param_put (dl_datain, dl_testcases (i));
        wait for 100 ns;
    end loop;
    dl_writeen <= '0';
    bp_rst <= '1';
    wait for 100 ns;
    -- go on and let trow do its thing
    wait;
end process;


end Behavioral;
