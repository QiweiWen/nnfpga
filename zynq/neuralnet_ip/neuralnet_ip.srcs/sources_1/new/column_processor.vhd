library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.helperpkg.all;
use work.nn_arith_package.all;
library ieee_proposed;
use ieee_proposed.fixed_pkg.all;
use ieee.math_real.all;


-- 07/05/2018: 
-- the timing of this module is a little tricky
-- in a typical clock cycle, the column processor accepts a partial
-- sum from its neighbour, performs a multiplication-addition, and
-- then forwards the new partial sum to its next neighbour.
--
-- for simplicity's sake, there is no buffering and all the required
-- signals must arrive at the correct clock cycles for the sum to
-- be correct.
--
-- the "vector element input channel" are the interface ports to the input
-- FIFO. In backpropagation, the input FIFO is shared with the derivative
-- unit. Furthermore, the input FIFO can become empty depending on the
-- geometry of the matrixes, so ve_req ("vector element request") cannot
-- always be satisfied immediately. ve_ack is connected to ve_req through
-- combinational logic and notifies, in the same cycle as ve_req,
-- the column processor of whether any data is incoming from the FIFO
-- in the next clock cycle. In the next cycle after it pulses high,
-- the next column processor down the line is notified through sync_in,
-- thus initiating a read from its own FIFO.

entity column_processor is
generic (
    nrows: integer := 100
);
port(
    clk: in std_logic;
    alrst: in std_logic;
-- l1 cache external interface
    l1_rden: out std_logic;
    l1_raddr: out integer range 0 to nrows - 1; 
    l1_din : in std_logic_vector (15 downto 0);
    l1_vin : in std_logic;
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
    idfwd: in std_logic_vector (47 downto 0);
-- partial result accumulation output to the next column processor
-- or to be truncated and committed to the FIFO 
    ovfwd: out std_logic;
    odfwd: out std_logic_vector (47 downto 0)
);
end column_processor;

architecture Behavioral of column_processor is
    signal sig_l1_raddr_curr: integer range 0 to nrows - 1;
    signal sig_l1_raddr_next: integer range 0 to nrows - 1;

    component multadd is
        port (A : in std_logic_vector (15 downto 0);
              B : in std_logic_vector (15 downto 0);
              C : in std_logic_vector (47 downto 0);
              P : out std_logic_vector (47 downto 0));
    end component multadd;
    
    -- we latch a vector element and compute a partial
    -- product vector
    signal vector_element: std_logic_vector (15 downto 0);

    signal sig_ve_req: std_logic; 

    signal odfwd_next: std_logic_vector (47 downto 0);
    signal ovfwd_next: std_logic;
    signal sig_A: std_logic_vector (15 downto 0);
begin

-- FIFO read synchronisation
sig_ve_req <= '1' when sig_l1_raddr_curr = 0 else '0';
ve_req <= '1' when sig_ve_req = '1' and isync = '1' else '0';

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

-- l1 (column weight) read address
-- latches at 0 until FIFO becomes ready to read
l1_raddr_proc:
process (clk, alrst) is
begin
    if (rising_edge(clk)) then
        if (alrst = '0') then
            sig_l1_raddr_curr <= 0;
        else
            sig_l1_raddr_curr <= sig_l1_raddr_next;
        end if;
    end if;
end process;

sig_l1_raddr_next <= (sig_l1_raddr_curr + 1) when sig_l1_raddr_curr /= 0 else 
                                           1 when ve_ack = '1' else 0;

l1_rden <= '1' when sig_l1_raddr_curr /= 0 else
           '1' when ve_ack = '1' else '0';

sig_A <= ve_datain when ve_validin = '1' else vector_element;

-- core of the computation
do_mult_sum: multadd
port map(
    A => sig_A,
    B => l1_din,
    C => idfwd,
    P => odfwd_next
);

ovfwd_next <= '1' when ivfwd = '1' and l1_vin = '1' and ve_validin = '1' else '0';

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
