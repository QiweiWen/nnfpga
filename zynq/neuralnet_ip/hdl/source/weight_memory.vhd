library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- yet another wrapper over the block ram to include
-- the simple cache units for continuous parameter
-- reads as well as ports for sideloading to/from
-- the zynq PS
entity weight_memory is
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
end weight_memory;

architecture behavioural of weight_memory is

-- block ram signals
signal tpr_re_a: std_logic;
signal tpr_addr_a: natural range 0 to depth - 1;
signal tpr_vout_a: std_logic;
signal tpr_dout_a: std_logic_vector (15 downto 0);
signal tpr_re_b: std_logic;
signal tpr_addr_b: natural range 0 to depth - 1;
signal tpr_vout_b: std_logic;
signal tpr_dout_b: std_logic_vector (15 downto 0);
signal tpr_addr_c: natural range 0 to depth - 1;
signal tpr_vin_c: std_logic;
signal tpr_din_c: std_logic_vector (15 downto 0);

-- cache signals
signal fwd_cache_ram_rden: std_logic;
signal fwd_cache_ram_raddr: natural range 0 to depth - 1;
signal fwd_cache_ram_rdata: std_logic_vector(15 downto 0);
signal fwd_cache_ram_vin  : std_logic;

signal bkwd_cache_ram_rden: std_logic;
signal bkwd_cache_ram_raddr: natural range 0 to depth - 1;
signal bkwd_cache_ram_rdata: std_logic_vector(15 downto 0);
signal bkwd_cache_ram_vin  : std_logic;

component three_port_ram is
    generic (
        width: natural := 16;
        depth: natural := 128
    );
    port (
        clk: in std_logic;
        alrst: in std_logic;
        re_a: in std_logic;
        addr_a: in natural range 0 to depth - 1;
        vout_a: out std_logic;
        dout_a: out std_logic_vector (width - 1 downto 0);
        re_b: in std_logic;
        addr_b: in natural range 0 to depth - 1;
        vout_b: out std_logic;
        dout_b: out std_logic_vector (width - 1 downto 0);
        addr_c: in natural range 0 to depth - 1;
        vin_c: in std_logic;
        din_c: in std_logic_vector (width - 1 downto 0)
    );
end component three_port_ram;

component ram_cache is
    generic
    (
        ram_depth: natural := 128
    );
    port
    (
        clk:        in std_logic;
        alrst:      in std_logic;
        rdy:        out std_logic;
        rden:       in std_logic;
        rdata:      out std_logic_vector(15 downto 0);
        vout:       out std_logic;
        ram_rden:   out std_logic;
        ram_raddr:  out natural range 0 to ram_depth - 1;
        ram_rdata:  in std_logic_vector(15 downto 0);
        ram_vin  :  in std_logic
    );
end component ram_cache;

signal cache_rst : std_logic;

signal ps_load_pipe : std_logic;
signal ps_load_pipe2: std_logic;

begin

bram_inst: three_port_ram
generic map (width => 16, depth => depth)
port map
(
    clk         => clk,
    alrst       => alrst,
    re_a       => tpr_re_a,
    addr_a       => tpr_addr_a,
    vout_a       => tpr_vout_a,
    dout_a       => tpr_dout_a,
    re_b       => tpr_re_b,
    addr_b       => tpr_addr_b,
    vout_b       => tpr_vout_b,
    dout_b       => tpr_dout_b,
    addr_c       => tpr_addr_c,
    vin_c       => tpr_vin_c,
    din_c       => tpr_din_c
);

fwd_cache_inst: ram_cache
generic map (ram_depth => depth)
port map
(
    clk         => clk,
    alrst       => cache_rst,
    rdy         => rdy,
    rden        => re_fwd,
    rdata       => dout_fwd,
    vout        => vout_fwd,
    ram_rden    => fwd_cache_ram_rden,
    ram_raddr    => fwd_cache_ram_raddr,
    ram_rdata    => fwd_cache_ram_rdata,
    ram_vin      => fwd_cache_ram_vin
);

bkwd_cache_inst: ram_cache
generic map (ram_depth => depth)
port map
(
    clk         => clk,
    alrst       => cache_rst,
    rdy         => open,
    rden        => re_bkwd,
    rdata       => dout_bkwd,
    vout        => vout_bkwd,
    ram_rden    => bkwd_cache_ram_rden,
    ram_raddr    => bkwd_cache_ram_raddr,
    ram_rdata    => bkwd_cache_ram_rdata,
    ram_vin      => bkwd_cache_ram_vin
);

-- 3-port-ram port allocation

tpr_re_a <= ps_re when ps_load = '1' else fwd_cache_ram_rden;
tpr_addr_a <= ps_addr when ps_load = '1' else fwd_cache_ram_raddr;
fwd_cache_ram_vin <= tpr_vout_a when ps_load = '0' else '0';
fwd_cache_ram_rdata <= tpr_dout_a when ps_load = '0' else (others => '0');
ps_vout <= tpr_vout_a when ps_load = '1' else '0';
ps_dout <= tpr_dout_a when ps_load = '1' else (others => '0');

tpr_re_b <= '0' when ps_load = '1' else bkwd_cache_ram_rden;
tpr_addr_b <= 0 when ps_load = '1' else bkwd_cache_ram_raddr;
bkwd_cache_ram_vin <= tpr_vout_b when ps_load = '0' else '0';
bkwd_cache_ram_rdata <= tpr_dout_b when ps_load = '0' else (others => '0');

tpr_addr_c <= ps_addr when ps_load = '1' else waddr_bkwd;
tpr_vin_c <= ps_we when ps_load = '1' else we_bkwd;
tpr_din_c <= ps_din when ps_load = '1' else din_bkwd;

--
cache_rst_proc:
process(clk) is
begin
    if (rising_edge(clk)) then
        if (alrst = '0') then
            ps_load_pipe <= '0';
            ps_load_pipe2 <= '0';
        else
            ps_load_pipe <= ps_load;
            ps_load_pipe2 <= ps_load_pipe;
        end if;
    end if;
end process;

cache_rst <= '1' when alrst = '1' and ps_load = '0' and
             ps_load_pipe = '0' and ps_load_pipe2 = '0' else '0';

end behavioural;
