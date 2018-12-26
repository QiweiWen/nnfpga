library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.helperpkg.all;
use work.nn_arith_package.all;
library ieee_proposed;
use work.fixed_pkg.all;
use ieee.math_real.all;

entity tcol_processor is
generic (
    nrows: natural := 100
);
port (
    clk:    in std_logic;
    alrst:  in std_logic;
-- weight memory read ports
    wram_rden: out std_logic;
    wram_din : in std_logic_vector (15 downto 0);
    wram_vin : in std_logic;
    wram_rdy : in std_logic;
-- delta input ports
    dl_datain: in std_logic_vector (15 downto 0);
    dl_validin: in std_logic;
    dl_req     : out std_logic;
-- synchronisation signals
    osync:   out std_logic;
    isync:   in std_logic;
-- partial result input from the last column processor
    ivfwd: in std_logic;
    idfwd: in std_logic_vector (31 downto 0);
-- partial result accumulation output to the next column processor
    ovfwd: out std_logic;
    odfwd: out std_logic_vector (31 downto 0);
-- dll1 output from the last column processor
-- left unconnected for all other transpose
-- column processors so it can be trimmed
    validout: out std_logic;
    deltaout: out std_logic_vector (15 downto 0);
-- weight memory write ports
    wram_wren: out std_logic;
    wram_waddr: out natural range 0 to nrows - 1;
    wram_wdata: out std_logic_vector (15 downto 0);
-- bias unit write ports
    bias_change_dout: out std_logic_vector (15 downto 0);
    bias_change_vout: out std_logic;
-- aL-1 input for derivative calculation
    all1_datain: in std_logic_vector (15 downto 0);
    all1_validin: in std_logic;
    all1_req: out std_logic;
    all1_empty : in std_logic;
    all1_fwd: out std_logic_vector (15 downto 0);
    all1_vfwd: out std_logic;
-- sigmoid-prime L-1 input for backprop
    apll1_datain: in std_logic_vector (15 downto 0);
    apll1_validin: in std_logic;
    apll1_req: out std_logic;
    apll1_empty: in std_logic
);
end tcol_processor;

architecture Behavioral of tcol_processor is

component column_processor is
generic (
    nrows: natural := 100
);
port(
    clk: in std_logic;
    alrst: in std_logic;
-- wram cache external interface
    wram_rden: out std_logic;
    wram_raddr: out natural range 0 to nrows - 1;
    wram_din : in std_logic_vector (15 downto 0);
    wram_vin : in std_logic;
    wram_rdy : in std_logic;
-- vector element input channel
    ve_datain: in std_logic_vector (15 downto 0);
    ve_validin: in std_logic;
    ve_req     : out std_logic;
-- synchronisation signals
    osync:   out std_logic;
    isync:   in std_logic;
-- partial result input from the last column processor
    ivfwd: in std_logic;
    idfwd: in std_logic_vector (31 downto 0);
-- partial result accumulation output to the next column processor
-- or to be truncated and committed to the FIFO
    ovfwd: out std_logic;
    odfwd: out std_logic_vector (31 downto 0)
);
end component column_processor;

signal ve_req: std_logic;
signal sig_wram_raddr: natural range 0 to nrows - 1;
signal dl_latched: std_logic_vector (15 downto 0);
signal dl_final: std_logic_vector (15 downto 0);
signal minus_lambda_dl: std_logic_vector (15 downto 0);
signal minus_all1_datain: std_logic_vector (15 downto 0);
signal lambda_dl: std_logic_vector (15 downto 0);
-- minus_lambda_dl * all1
signal weight_adj_data: std_logic_vector (15 downto 0);
signal weight_adj_valid: std_logic;
-- delay wram read address by 2 cycles to become wram writeback address
-- delay wram read data by 1 cycle to align with weight_adj_data
type wram_raddr_pipe_t is array (1 downto 0) of natural range 0 to nrows - 1;
signal wram_raddr_pipe: wram_raddr_pipe_t;
signal wram_din_delayed: std_logic_vector (15 downto 0);

signal prod_trunc: std_logic_vector (15 downto 0);
signal prod_vtrunc: std_logic;

signal sig_ovfwd: std_logic;
signal sig_odfwd: std_logic_vector (31 downto 0);

signal delta_validout_next: std_logic;
signal dll1_full: std_logic_vector (31 downto 0);

begin

backprop: column_processor
generic map (nrows => nrows)
port map (
    clk             => clk,
    alrst           => alrst,
    wram_rden         => wram_rden,
    wram_raddr        => sig_wram_raddr,
    wram_din          => wram_din,
    wram_vin          => wram_vin,
    wram_rdy        => wram_rdy,
    ve_datain       => dl_datain,
    ve_validin      => dl_validin,
    ve_req          => ve_req,
    osync           => osync,
    isync           => isync,
    ivfwd           => ivfwd,
    idfwd           => idfwd,
    ovfwd           => sig_ovfwd,
    odfwd           => sig_odfwd
);

dl_req <= '1' when all1_empty = '0' and apll1_empty = '0' and ve_req = '1' else '0';

odfwd <= sig_odfwd;
ovfwd <= sig_ovfwd;

all1_req <= '1' when sig_wram_raddr /= 0 or dl_validin = '1' else '0';

dl_latch: process (clk, alrst) is
begin
    if (rising_edge(clk)) then
        if (alrst = '0') then
            dl_latched <= (others => '0');
        elsif (dl_validin = '1') then
            dl_latched <= dl_datain;
        end if;
    end if;
end process;

dl_final <= dl_latched when dl_validin = '0' else dl_datain;

bias_derivative_process: process (clk) is
begin
    if (rising_edge(clk)) then
        if (alrst = '0') then
            bias_change_vout <= '0';
            bias_change_dout <= (others => '0');
        else
            bias_change_vout <= dl_validin;
            bias_change_dout <= minus_lambda_dl;
        end if;
    end if;
end process;

lambda_dl_process: process (dl_final) is
    constant shift_amount : natural := fraction_to_shift (LEARN_RATE);
    variable padding : std_logic_vector (shift_amount - 1 downto 0);
begin
    padding := (others => dl_final(15));
    lambda_dl <= padding & dl_final (15 downto shift_amount);
end process;
minus_lambda_dl <= std_logic_vector(unsigned(not (lambda_dl)) + 1);
minus_all1_datain <= std_logic_vector(unsigned(not (all1_datain)) + 1);

-- weight adjustment calculation
weight_adj_proc: process (clk, alrst) is
    variable weight_adj_full: slv_32_t;
begin
    if (rising_edge(clk)) then
        if (alrst = '0') then
            weight_adj_data <= (others => '0');
            weight_adj_valid <= '0';
        else
            weight_adj_valid <= all1_validin;
            weight_adj_full := slv_32_t(to_sfixed(lambda_dl,PARAM_DEC - 1,-PARAM_FRC) *
                                           to_sfixed(minus_all1_datain,PARAM_DEC - 1,-PARAM_FRC));
            weight_adj_data <= weight_adj_full
                               (2 * PARAM_FRC + PARAM_DEC - 1 downto PARAM_FRC);
        end if;
    end if;
end process;
-- new memory content
wram_writeback_proc: process (clk, alrst) is
begin
    if (rising_edge(clk)) then
        if (alrst = '0') then
            wram_din_delayed <= (others => '0');
            wram_wdata <= (others => '0');
            wram_wren <= '0';
        else
            wram_din_delayed <= wram_din;
            wram_wdata <= func_safe_sum (wram_din_delayed, weight_adj_data);
            wram_wren <= weight_adj_valid;
        end if;
    end if;
end process;
-- weight memory write address generation
wram_wraddr_proc: process (clk, alrst) is
begin
    if (rising_edge (clk)) then
        if (alrst = '0') then
            wram_raddr_pipe (1) <= 0;
            wram_raddr_pipe (0) <= 0;
        else
            wram_raddr_pipe (1) <= sig_wram_raddr;
            wram_raddr_pipe (0) <= wram_raddr_pipe (1);
        end if;
    end if;
end process;

wram_waddr <= wram_raddr_pipe (0);

-- Backprop part
all1_fwd_proc: process (clk, alrst) is
begin
    if (rising_edge(clk)) then
        if (alrst = '0') then
            all1_fwd <= (others => '0');
            all1_vfwd <= '0';
        else
            all1_fwd <= all1_datain;
            all1_vfwd <= all1_validin;
        end if;
    end if;
end process;

apll1_req <= prod_vtrunc;
delta_validout_next <= '1' when apll1_validin = '1' and prod_vtrunc = '1' else '0';
deltaout <= dll1_full (PARAM_FRC * 2 + PARAM_DEC - 1 downto PARAM_FRC);

hadamard_process: process (clk, alrst) is
begin
    if (rising_edge(clk)) then
        if (alrst = '0') then
            prod_trunc <= (others => '0');
            prod_vtrunc <= '0';
            dll1_full <= (others => '0');
            validout <= '0';
        else
            prod_trunc <= fun_mul_truncate (sig_odfwd, 15);
            prod_vtrunc <= sig_ovfwd;
            dll1_full <= slv_32_t (to_sfixed (prod_trunc,  PARAM_DEC - 1, -PARAM_FRC) *
                                   to_sfixed (apll1_datain, PARAM_DEC - 1, -PARAM_FRC));
            validout <= delta_validout_next;
        end if;
    end if;
end process;

end Behavioral;
