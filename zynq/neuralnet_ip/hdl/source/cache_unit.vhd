library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.helperpkg.all;
use work.nn_arith_package.all;
library ieee_proposed;
use work.fixed_pkg.all;

entity cache is
generic
(
    ram_depth: integer := 128
);
port
(
    clk:        in std_logic;
    alrst:      in std_logic;
-- ready signal to indicate that the cache unit
-- is ready to accept read requests
    rdy:        out std_logic;
-- read side signals from column and row processors
    rden:       in std_logic;
    rdata:      out std_logic_vector(15 downto 0);
    vout:       out std_logic;
-- signals that go to the weight ram
    ram_rden:   out std_logic;
    ram_raddr:  out integer range 0 to ram_depth - 1;
    ram_rdata:  in std_logic_vector(15 downto 0);
    ram_vin  :  in std_logic
);
end cache;

architecture behavioural of cache is
-- cache registers and read/write pointers
    type regs_t is array(integer range <>) of slv_17_t;
    signal regs: regs_t(3 downto 0);
    signal rdptr: integer range 0 to 3;
    signal wrptr: integer range 0 to 3;
    signal almost_full: std_logic;
    signal full: std_logic;
--
    signal sig_rdy: std_logic;
    signal sig_vout: std_logic;
--
    signal sig_ram_rden: std_logic;
    signal sig_ram_raddr: integer range 0 to ram_depth - 1;
--
    signal preload_count: integer range 0 to 4;
begin
    almost_full <= '1' when regs(0)(16) = '1' and regs(1)(16) = '1' 
                       and regs(2)(16) = '1' else '0';

    full <= '1' when regs(0)(16) = '1' and regs(1)(16) = '1' 
                 and regs(2)(16) = '1' and regs(3)(16) = '1' else '0';
    rdy <= sig_rdy;
-- we become ready to serve read requests the first time the
-- cache fills up and remain so until being reset
rdy_proc: process(clk) is
    begin
        if (rising_edge(clk)) then
            if (alrst = '0') then
                sig_rdy <= '0';
            else
                if (sig_rdy = '1') then
                    sig_rdy <= '1';
                else
                    if (almost_full  = '1' and ram_vin = '1') then
                        sig_rdy <= '1';
                    else
                        sig_rdy <= '0';
                    end if;
                end if;
            end if;
        end if;
    end process;

-- 0-latency end to the processing elements
    rdata <= regs(rdptr)(15 downto 0);
    sig_vout <= '1' when rden = '1' and regs(rdptr)(16) = '1' else '0';
    vout <= sig_vout;

    rdptr <= 3 when (regs(0)(16) = '0' and regs(1)(16) = '0' 
                 and regs(2)(16) = '0' and regs(3)(16) = '1') else
             2 when (regs(0)(16) = '0' and regs(1)(16) = '0' and regs(2)(16) = '1') else
             1 when (regs(0)(16) = '0' and regs(1)(16) = '1') else 0;
    
    wrptr <= 3 when (regs(0)(16) = '1' and regs(1)(16) = '1' 
                 and regs(2)(16) = '1' and regs(3)(16) = '0') else 
             2 when (regs(0)(16) = '1' and regs(1)(16) = '1' and regs(2)(16) = '0') else 
             1 when (regs(0)(16) = '1' and regs(1)(16) = '0') else 0;

-- 2-cycle latency end to the blockram
    ram_rden <= sig_ram_rden;
    ram_raddr <= sig_ram_raddr;
    sig_ram_rden <= '1' when (alrst = '1') and (full = '0' or rden = '1') 
                                           and preload_count /= 4 else '0';

ram_raddr_proc:
    process(clk) is
    begin
        if (rising_edge(clk)) then
            if (alrst = '0') then
                sig_ram_raddr <= 0;
            else
                if (sig_ram_rden = '1') then
                    sig_ram_raddr <= (sig_ram_raddr + 1) mod ram_depth;
                end if;
            end if;
        end if;
    end process;

preload_count_proc:
    process(clk) is
    begin
        if (rising_edge(clk)) then
            if (alrst = '0') then
                preload_count <= 0;
            else
                if (sig_ram_rden = '1' and sig_vout = '0') then
                    preload_count <= (preload_count + 1) mod 5;
                elsif (sig_ram_rden = '0' and sig_vout = '1') then
                    preload_count <= (preload_count - 1) mod 5;
                end if;
            end if;
        end if;
    end process;

cache_populate:
    process(clk) is
    begin
        if (rising_edge(clk)) then
            if (alrst = '0') then
                regs <= (others => (others => '0'));
            else
                if (wrptr /= rdptr) then
                    if (sig_vout = '1') then
                        regs(rdptr)(16) <= '0';
                    end if;

                    if (ram_vin = '1') then
                        regs(wrptr)(16) <= ram_vin;
                        regs(wrptr)(15 downto 0) <= ram_rdata;
                    end if;
                else
                    if (ram_vin = '1') then
                        regs(wrptr)(16) <= ram_vin;
                        regs(wrptr)(15 downto 0) <= ram_rdata;
                    elsif (sig_vout = '1') then
                        regs(rdptr)(16) <= '0';
                    end if;
                end if;

            end if;
        end if;
    end process;

end behavioural;
