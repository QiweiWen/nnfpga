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
-- sum from its neighbout, performs a multiplication-addition, and
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
-- l1 (column weight) read address
    signal sig_l1_raddr_curr: integer range 0 to nrows - 1;
    signal sig_l1_raddr_next: integer range 0 to nrows - 1;
begin

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
                                           1 when ve_validin = '1' else 0;

end Behavioral;
