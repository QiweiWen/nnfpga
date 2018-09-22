library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.helperpkg.all;
use work.nn_arith_package.all;
library ieee_proposed;
use work.fixed_pkg.all;

entity fifo_cache is
generic
(
    fifo_depth: natural := 128
);
port
(
    clk:        in std_logic;
    alrst:      in std_logic;
-- read side signals from column and row processors
    cache_empty:out std_logic;
    rden:       in std_logic;
    rdata:      out std_logic_vector(15 downto 0);
    vout:       out std_logic;
-- signals that go to the bram-backed fifo 
    fifo_empty: in std_logic;
    fifo_rden:   out std_logic;
    fifo_rdata:  in std_logic_vector(15 downto 0);
    fifo_vin  :  in std_logic
);
end fifo_cache;

architecture behavioural of fifo_cache is
-- fifo_cache registers
    constant nregs: natural := 4;
    type regs_t is array(nregs - 1 downto 0) of slv_16_t;
    signal regs: regs_t;
-- fifo signals
    signal sig_empty: std_logic;
    signal rdptr: natural range 0 to nregs - 1;
    signal wrptr: natural range 0 to nregs - 1;
    signal size: natural range 0 to nregs;
    signal do_read: std_logic;
-- block ram signals
    signal sig_fifo_rden: std_logic;
-- decide whether to load more data into fifo_cache
    signal prefetch_count: natural range 0 to nregs;
    signal do_prefetch: std_logic;
begin
-- logic for serving read requests
    do_read <= '1' when rden = '1' and sig_empty = '0' else '0';
    vout <= do_read;
    rdata <= regs(rdptr);
    sig_empty <= '1' when size = 0 else '0';
    cache_empty <= sig_empty;
-- prefetch logic
    do_prefetch <= '1' when (alrst = '1') and 
                            (prefetch_count /= nregs and fifo_empty = '0') else '0';
    fifo_rden <= do_prefetch;

-- size logic
    size_proc:
    process(clk) is
    begin
        if (rising_edge(clk)) then
            if (alrst = '0') then
                size <= 0;
            elsif (fifo_vin = '1' and do_read = '0') then
                size <= (size + 1) mod (nregs + 1);
            elsif (do_read = '1' and fifo_vin = '0') then
                size <= (size - 1) mod (nregs + 1);
            end if;
        end if;
    end process;

-- read/write ptr logic
    ptr_proc:
    process(clk) is
    begin
        if (rising_edge(clk)) then
            if (alrst = '0') then
                rdptr <= 0;
                wrptr <= 0;
            else
                if (do_read = '1') then
                    rdptr <= (rdptr + 1) mod nregs;
                end if;
                if (fifo_vin = '1') then
                    wrptr <= (wrptr + 1) mod nregs;
                end if;
            end if;
        end if;
    end process;

-- populate fifo_cache
    cache_populate:
    process(clk) is
    begin
        if (rising_edge(clk)) then
            if (alrst = '0') then
                regs <= (others => (others => '0'));
            elsif (fifo_vin = '1') then
                regs(wrptr) <= fifo_rdata;
            end if;
        end if;
    end process;

-- preload count process
    prefetch_counting:
    process(clk) is
    begin
        if (rising_edge(clk)) then
            if (alrst = '0') then
                prefetch_count <= 0;
            elsif (do_prefetch = '1' and do_read = '0') then
                prefetch_count <= (prefetch_count + 1) mod (nregs + 1);
            elsif (do_read = '1' and do_prefetch = '0') then
                prefetch_count <= (prefetch_count - 1) mod (nregs + 1);
            end if;
        end if;
    end process;


end behavioural;
