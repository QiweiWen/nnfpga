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

constant ntcols: integer := 5;
constant ncols : integer := ntcols;
constant dfifo : integer := 10;
constant data_width : integer := 16;

constant period: time := 100 ns;

component trow_processor is
generic (
    ncols: integer := 100
);
port(
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

signal all1_readen  : std_logic;
signal all1_dataout : std_logic_vector (data_width - 1 downto 0);
signal all1_ackout  : std_logic;
signal all1_validout: std_logic;

signal apll1_readen  : std_logic;
signal apll1_dataout : std_logic_vector (data_width - 1 downto 0);
signal apll1_ackout  : std_logic;
signal apll1_validout: std_logic;

signal dl_readen  : std_logic;
signal dl_dataout : std_logic_vector (data_width - 1 downto 0);
signal dl_ackout  : std_logic;
signal dl_validout: std_logic;

signal deltaout: std_logic_vector (15 downto 0);
signal l1_rdata: std_logic_vector (15 downto 0);

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

-- testbench signals

signal rst: std_logic;
signal bp_rst: std_logic;

signal l1_write_mux: std_logic := '0';

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

l1_wren <= l1_wren_bp when l1_write_mux = '1' else l1_wren_tb;
l1_waddr <= l1_waddr_bp when l1_write_mux = '1' else l1_waddr_tb;
l1_wdata <= l1_wdata_bp when l1_write_mux = '1' else l1_wdata_tb;

clk <= not clk after period/2; 

debug_process: process (clk, rst) is
begin
    if (rising_edge(clk)) then
        if (rst = '0') then
            deltaout_debug <= -42.0;
            l1_wdata_debug <= -42.0;
            l1_rdata_debug <= -42.0;
        else
            if (trow_validout = '1') then
                deltaout_debug <= to_real (to_sfixed(deltaout, PARAM_DEC - 1, -PARAM_FRC));
            end if;

            if (l1_vin = '1') then
                l1_rdata_debug <= to_real (to_sfixed(l1_rdata, PARAM_DEC - 1, -PARAM_FRC));
            end if;

            if (l1_wren = '1') then
                l1_wdata_debug <= to_real (to_sfixed(l1_wdata, PARAM_DEC - 1, -PARAM_FRC));
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
    clk   => clk,
    alrst => bp_rst,
    dl_datain => dl_dataout,
    dl_validin => dl_validout,
    dl_ack  => dl_ackout,
    dl_req  =>  dl_readen,
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
    l1_write_mux    <= '0';
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

    wait;
end process;


end Behavioral;
