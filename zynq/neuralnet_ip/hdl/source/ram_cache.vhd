library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.helperpkg.all;
use work.nn_arith_package.all;
library ieee_proposed;
use work.fixed_pkg.all;

entity ram_cache is
generic
(
    ram_depth: natural := 128
);
port
(
    clk:        in std_logic;
    alrst:      in std_logic;
-- ready signal to indicate that the ram_cache unit
-- is ready to accept read requests
    rdy:        out std_logic;
-- read side signals from column and row processors
    rden:       in std_logic;
    rdata:      out std_logic_vector(15 downto 0);
    vout:       out std_logic;
-- signals that go to the weight ram
    ram_rden:   out std_logic;
    ram_raddr:  out natural range 0 to ram_depth - 1;
    ram_rdata:  in std_logic_vector(15 downto 0);
    ram_vin  :  in std_logic
);
end ram_cache;

architecture behavioural of ram_cache is
    signal sig_rdy: std_logic;
-- ram_cache registers
    constant nregs: natural := 4;
    type regs_t is array(nregs - 1 downto 0) of slv_16_t;
    signal regs: regs_t;
-- fifo signals
    signal sig_empty: std_logic;
    signal sig_full: std_logic;
    signal rdptr: natural range 0 to nregs - 1;
    signal wrptr: natural range 0 to nregs - 1;
    signal size: natural range 0 to nregs;
    signal do_read: std_logic;
-- block ram signals
    signal sig_ram_rden: std_logic;
    signal sig_ram_raddr: natural range 0 to ram_depth - 1;
-- decide whether to load more data into ram_cache
    signal prefetch_count: natural range 0 to nregs;
    signal do_prefetch: std_logic;
begin
    rdy <= sig_rdy;
    rdy_proc:
    process(clk) is
    begin
        if (rising_edge(clk)) then
            if (alrst = '0') then
                sig_rdy <= '0';
            elsif (sig_rdy = '0') then 
                if (size = nregs - 1 and ram_vin = '1') then
                    sig_rdy <= '1';
                end if;
            end if;
        end if;
    end process;
-- logic for serving read requests
    do_read <= '1' when rden = '1' and sig_empty = '0' else '0';
    vout <= do_read;
    rdata <= regs(rdptr);
-- empty and full signals
    sig_empty <= '1' when size = 0 else '0';
    sig_full <= '1' when size = nregs else '0';
-- prefetch logic
    do_prefetch <= '1' when (alrst = '1') and (prefetch_count /= nregs) else '0';
    ram_rden <= do_prefetch;
    ram_raddr <= sig_ram_raddr;

    raddr_proc:
    process(clk) is
    begin
        if (rising_edge(clk)) then
            if (alrst = '0') then
                sig_ram_raddr <= 0;
            elsif (do_prefetch = '1') then
                sig_ram_raddr <= (sig_ram_raddr + 1) mod ram_depth;
            end if;
        end if;
    end process;
-- size logic
    size_proc:
    process(clk) is
    begin
        if (rising_edge(clk)) then
            if (alrst = '0') then
                size <= 0;
            elsif (ram_vin = '1' and do_read = '0') then
                size <= (size + 1) mod (nregs + 1);
            elsif (do_read = '1' and ram_vin = '0') then
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
                if (ram_vin = '1') then
                    wrptr <= (wrptr + 1) mod nregs;
                end if;
            end if;
        end if;
    end process;

-- populate ram_cache
    cache_populate:
    process(clk) is
    begin
        if (rising_edge(clk)) then
            if (alrst = '0') then
                regs <= (others => (others => '0'));
            elsif (ram_vin = '1') then
                regs(wrptr) <= ram_rdata;
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
