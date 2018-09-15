library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.helperpkg.all;
use work.nn_arith_package.all;
library ieee_proposed;
use work.fixed_pkg.all;
use ieee.math_real.all;

entity column_processor is
generic (
    nrows: integer := 100
);
port(
    clk: in std_logic;
    alrst: in std_logic;
-- wram cache external interface
    wram_rden: out std_logic;
    wram_raddr: out integer range 0 to nrows - 1; 
    wram_din : in std_logic_vector (15 downto 0);
    wram_vin : in std_logic;
-- vector element input channel
    ve_datain: in std_logic_vector (15 downto 0);
    ve_validin: in std_logic;
    ve_req     : out std_logic;
    ve_ack     : in std_logic; 
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
end column_processor;

architecture Behavioral of column_processor is
    signal sig_wram_raddr_curr: integer range 0 to nrows - 1;
    signal sig_wram_raddr_next: integer range 0 to nrows - 1;

    -- we latch a vector element and compute a partial
    -- product vector
    signal vector_element: std_logic_vector (15 downto 0);

    signal sig_ve_req: std_logic; 

    signal odfwd_next: std_logic_vector (31 downto 0);
    signal ovfwd_next: std_logic;
    signal sig_A: std_logic_vector (15 downto 0);
    signal sig_ve_ack_last: std_logic;

    signal sig_product: std_logic_vector (31 downto 0);
    signal sig_product_latched: std_logic_vector (31 downto 0);
    subtype product_type is std_logic_vector (31 downto 0);
    subtype fullsum_type is std_logic_vector (32 downto 0);
    signal full_sum: fullsum_type;

    signal product_valid: std_logic;
    signal product_valid_next: std_logic;
begin

-- latch the status of ve_ack in the last cycle
ve_ack_latch: process (clk, alrst) is
begin
    if (rising_edge(clk)) then
        if (alrst = '0') then
            sig_ve_ack_last <= '0';
        else
            sig_ve_ack_last <= ve_ack; 
        end if;
    end if;
end process;

-- FIFO read synchronisation
sig_ve_req <= '1' when sig_wram_raddr_curr = 0 else '0';
ve_req <= '1' when sig_ve_req = '1' and isync = '1' and alrst = '1' else '0';

osync_proc: process (clk, alrst) is
begin
    if (rising_edge(clk)) then
        if (alrst = '0') then
            osync <= '0';
        else
            osync <= ve_ack;
        end if;
    end if;
end process;

-- vector element latching
ve_latch: process (clk, alrst) is
begin
    if (rising_edge(clk)) then
        if (alrst = '0') then
            vector_element <= (others => '0');
        elsif ve_validin = '1' then
            vector_element <= ve_datain;
        end if;
    end if;
end process;

-- wram (column weight) read address
-- latches at 0 until FIFO becomes ready to read
wram_raddr_proc:
process (clk, alrst) is
begin
    if (rising_edge(clk)) then
        if (alrst = '0') then
            sig_wram_raddr_curr <= 0;
        else
            sig_wram_raddr_curr <= sig_wram_raddr_next;
        end if;
    end if;
end process;

wram_raddr <= sig_wram_raddr_curr;
sig_wram_raddr_next <= (sig_wram_raddr_curr + 1) mod nrows when sig_wram_raddr_curr /= 0 else 
                                                     1 when ve_ack = '1' else 0;

wram_rden <= '1' when sig_wram_raddr_curr /= 0 else
           '1' when ve_ack = '1' else '0';

sig_A <= ve_datain when ve_validin = '1' else vector_element;
-- sig_B === wram_din

sig_product <= product_type (to_sfixed (sig_A, PARAM_DEC - 1, -PARAM_FRC) *
                             to_sfixed (wram_din, PARAM_DEC - 1, -PARAM_FRC));

sum_product_align: process (clk, alrst) is
begin
    if (rising_edge(clk)) then
        if (alrst = '0') then
            sig_product_latched <= (others => '0');
            product_valid <= '0';
        else
            sig_product_latched <= sig_product;
            product_valid <= product_valid_next;
        end if;
    end if;
end process;

product_valid_next <= wram_vin;
                   
full_sum   <= fullsum_type (to_sfixed (idfwd,               2*PARAM_DEC - 1, -2*PARAM_FRC) +
                            to_sfixed (sig_product_latched, 2*PARAM_DEC - 1, -2*PARAM_FRC));

odfwd_next <= fun_add_truncate(full_sum);
ovfwd_next <= '1' when product_valid = '1' and ivfwd = '1' else '0';

partial_sum_forwarding: process (clk, alrst) is
begin
    if (rising_edge(clk)) then
        if (alrst = '0') then
            odfwd <= (others => '0');
            ovfwd <= '0';
        else
            odfwd <= odfwd_next;
            ovfwd <= ovfwd_next;
        end if;
    end if;
end process;


end Behavioral;
