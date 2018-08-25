-- Whatever on earth is a "trow", you ask?
-- a Transpose ROW.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.helperpkg.all;
use work.nn_arith_package.all;
library ieee_proposed;
use work.fixed_pkg.all;
use ieee.math_real.all;

-- preserve all row processor ports
-- add duplicated aL-1 input, weight memory write ports
-- and sigmoid prime (L-1) FIFO input

-- note: foward stage is column major, so all1 and apll1 are parallel FIFOs
--       i.e. made up of as many fifos are there are col-/trow-processors
--       each holding a queue of single vector elements
--
-- Also note: only the bias_change_dout and bias_change_vout output from the
--            trow processor is used, the others are redundant and will be trimmed
entity trow_processor is
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
end trow_processor;

architecture Behavioral of trow_processor is

-- dl and l1 are shared between row processor
-- and derivative unit
signal sig_l1_rden : std_logic;
signal sig_l1_raddr: integer range 0 to ncols - 1;
-- i.e. product almost ready, fetch last level
-- unactivated output right now
-- multiplication result
signal prod_dout: std_logic_vector (31 downto 0);
signal prod_trunc: std_logic_vector (15 downto 0);
signal prod_vout: std_logic;
signal prod_vtrunc: std_logic;

signal delta_validout_next: std_logic;
signal dll1_full: std_logic_vector (31 downto 0);
subtype full_prod_t is std_logic_vector (31 downto 0);
subtype word_t is std_logic_vector (15 downto 0);
-- delay prefetch signal by one cycle to account
-- for truncation
signal apll1_req_pipe: std_logic;
-- all1 (previous activated result) signals
signal all1_latched: std_logic_vector (15 downto 0); 
signal all1_final: std_logic_vector (15 downto 0);
signal minus_lambda_dl: std_logic_vector (15 downto 0); 
-- minus_lambda_dl * all1
signal weight_adj_data: std_logic_vector (15 downto 0);
signal weight_adj_valid: std_logic;
-- delay l1 read address by 3 cycles to become l1 writeback address
-- delay l1 read data by 1 cycle to align with weight_adj_data
type l1_raddr_pipe_t is array (3 downto 0) of integer range 0 to ncols - 1;
signal l1_raddr_pipe: l1_raddr_pipe_t;
signal l1_din_delayed: std_logic_vector (15 downto 0);

component row_processor is
generic (
    ncols: integer := 100
);
port(
    clk: in std_logic;
    alrst: in std_logic;
-- l1 cache external interface
    l1_rden: out std_logic;
    l1_raddr: out integer range 0 to ncols - 1; 
    l1_din : in std_logic_vector (15 downto 0);
    l1_vin : in std_logic;
-- vector input channel
    ve_datain: in std_logic_vector (15 downto 0);
    ve_validin: in std_logic;
    ve_ack     : in std_logic;
    ve_req     : out std_logic;
-- product terms output channel
    dataout: out std_logic_vector (31 downto 0);
    validout: out std_logic;
    fvalid: out std_logic;
-- vector input forwarded to the adjacent row processor down the line
    validfwd: out std_logic;
    datafwd: out std_logic_vector (15 downto 0)
);
end component row_processor;
begin

    l1_rden <= sig_l1_rden;
    l1_raddr <= sig_l1_raddr;
    
    -- backprop part
    backprop: row_processor
    generic map (ncols => ncols)
    port map (
        clk         => clk,
        alrst       => alrst,
        l1_rden     => sig_l1_rden,
        l1_raddr    => sig_l1_raddr,
        l1_din      => l1_din,
        l1_vin      => l1_vin,
        ve_datain   => dl_datain,
        ve_validin  => dl_validin,
        ve_ack      => dl_ack,
        ve_req      => dl_req,
        dataout     => prod_dout,
        validout    => prod_vout,
        fvalid      => apll1_req_pipe,
        validfwd    => validfwd,
        datafwd     => deltafwd
    );

    delta_validout_next <= '1' when apll1_validin = '1' and prod_vtrunc = '1' else '0';
    deltaout <= dll1_full (PARAM_FRC * 2 + PARAM_DEC - 1 downto PARAM_FRC);

    hadamard_process: process (clk, alrst) is
    begin
        if (rising_edge(clk)) then
            if (alrst = '0') then
                apll1_req <= '0';
                prod_trunc <= (others => '0');
                prod_vtrunc <= '0';
                dll1_full <= (others => '0');
                validout <= '0';
            else
                apll1_req <= apll1_req_pipe;
                prod_trunc <= fun_mul_truncate (prod_dout, 15);
                prod_vtrunc <= prod_vout;
                dll1_full <= full_prod_t (to_sfixed (prod_trunc,  PARAM_DEC - 1, -PARAM_FRC) *
                                          to_sfixed (apll1_datain, PARAM_DEC - 1, -PARAM_FRC));
                validout <= delta_validout_next;
            end if;
        end if;
    end process;
    -- derivative calculation and weight update part

    -- read new activated vector element when new dl is being read
    -- all1 and dl occur, then, at the same cycle
    all1_req <= '1' when sig_l1_raddr = 0 and dl_ack = '1' else '0';
    all1_latch: process (clk, alrst) is
    begin
        if (rising_edge(clk)) then
            if (alrst = '0') then
                all1_latched <= (others => '0');
            elsif (all1_validin = '1') then
                all1_latched <= all1_datain;
            end if;
        end if;
    end process;
    all1_final <= all1_latched when all1_validin = '0' else all1_datain;
    
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

    minus_lambda_dl_process: process (dl_datain) is
        constant shift_amount : integer := fraction_to_shift (LEARN_RATE);
        variable padding : std_logic_vector (shift_amount - 1 downto 0);
        variable lambda_dl: std_logic_vector (15 downto 0);
    begin
        padding := (others => dl_datain(15));
        lambda_dl := padding & dl_datain (15 downto shift_amount); 
        minus_lambda_dl <= std_logic_vector(unsigned(not (lambda_dl)) + 1); 
    end process;

    -- weight adjustment calculation
    weight_adj_proc: process (clk, alrst) is
        variable weight_adj_full: full_prod_t;
    begin
        if (rising_edge(clk)) then
            if (alrst = '0') then
                weight_adj_data <= (others => '0'); 
                weight_adj_valid <= '0';
            else
                weight_adj_valid <= dl_validin;
                weight_adj_full := full_prod_t(to_sfixed(minus_lambda_dl, PARAM_DEC - 1, -PARAM_FRC) *
                                               to_sfixed(all1_final,PARAM_DEC - 1, -PARAM_FRC));
                weight_adj_data <= weight_adj_full 
                                   (2 * PARAM_FRC + PARAM_DEC - 1 downto PARAM_FRC);
            end if;
        end if;
    end process;

    -- new memory content
    l1_writeback_proc: process (clk, alrst) is
    begin
        if (rising_edge(clk)) then
            if (alrst = '0') then
                l1_din_delayed <= (others => '0');
                l1_wdata <= (others => '0');
                l1_wren <= '0';
            else
                l1_din_delayed <= l1_din;
                l1_wdata <= func_safe_sum (l1_din_delayed, weight_adj_data);
                l1_wren <= weight_adj_valid;
            end if;
        end if;
    end process;

    -- weight memory write address generation
    l1_wraddr_proc: process (clk, alrst) is
    begin
        if (rising_edge (clk)) then
            if (alrst = '0') then
                for I in 3 downto 0 loop
                    l1_raddr_pipe (I) <= 0;
                end loop;
            else
                l1_raddr_pipe (3) <= sig_l1_raddr;
                for I in 2 downto 0 loop
                    l1_raddr_pipe (I) <= l1_raddr_pipe (I + 1);
                end loop;
            end if;
        end if;
    end process;

    l1_waddr <= l1_raddr_pipe (0);
    

end Behavioral;
