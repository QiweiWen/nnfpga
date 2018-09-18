-- stolen from deathbylogic.com
-- re-wrote because it was shit
-- mate, stop writing tutorials

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity std_fifo is
    generic (
        constant data_width  : positive := 8;
        constant fifo_depth	: positive := 256
    );
    port ( 
        clk		: in  std_logic;
        rst		: in  std_logic;
        writeen	: in  std_logic;
        datain	: in  std_logic_vector (data_width - 1 downto 0);
        readen	: in  std_logic;
        dataout	: out std_logic_vector (data_width - 1 downto 0);
        ackout  : out std_logic;
        validout: out std_logic;
        empty	: out std_logic;
        full	: out std_logic
    );
end std_fifo;

architecture behavioral of std_fifo is

    signal sig_empty: std_logic;
    signal sig_full: std_logic;
    signal validout_pipe: std_logic;

    component true_dpram_sclk is
        generic (
            width: natural := 16;
            depth: natural := 128
        );
        port 
        (	
            data_a	: in std_logic_vector(width - 1 downto 0);
            data_b	: in std_logic_vector(width - 1 downto 0);
            addr_a	: in natural range 0 to depth - 1;
            addr_b	: in natural range 0 to depth - 1;
            we_a	: in std_logic;
            we_b	: in std_logic;
            clk		: in std_logic;
            q_a		: out std_logic_vector(width - 1 downto 0);
            q_b		: out std_logic_vector(width - 1 downto 0)
        );
        
    end component true_dpram_sclk;

    signal rdptr: natural range 0 to fifo_depth - 1;
    signal wrptr: natural range 0 to fifo_depth - 1;
    signal size: natural range 0 to fifo_depth;

    signal do_read: std_logic;
    signal do_write: std_logic;

begin
    -- delay readen and empty for two cycles to drive output valid flag
    do_read <= '1' when readen = '1' and sig_empty = '0' else '0';
    do_write <= '1' when writeen = '1' and sig_full = '0' else '0';
    ackout <= do_read;
    vout_proc: process (clk, rst)
    begin
        if (rising_edge(clk)) then
            if (rst = '0') then
                validout <= '0';
                validout_pipe <= '0';
            else
                validout_pipe <= do_read;
                validout <= validout_pipe;
            end if;
        end if;
    end process;
    
    empty <= sig_empty;
    full  <= sig_full;
    sig_empty <= '1' when size = 0 else '0';
    sig_full  <= '1' when size = fifo_depth else '0';

    capacity_proc: process (clk, rst) is
    begin
        if (rising_edge(clk)) then
            if (rst = '0') then
                rdptr <= 0;
                wrptr <= 0;
            else
                if (do_read = '1') then
                    rdptr <= (rdptr + 1) mod fifo_depth;
                end if;

                if (do_write = '1') then
                    wrptr <= (wrptr + 1) mod fifo_depth;
                end if;

                if (do_write = '1' and do_read = '0') then
                    size <= (size + 1) mod (fifo_depth + 1);
                elsif (do_write = '0' and do_read = '1') then
                    size <= (size - 1) mod (fifo_depth + 1);
                end if;

            end if;
        end if;
    end process;
    
    memory_module: true_dpram_sclk
    generic map (width => data_width, depth => fifo_depth)
    port map(
        data_a => (others => '0'),
        addr_a => rdptr,
        we_a   => '0', 
        q_a    => dataout,
        data_b => datain, 
        addr_b => wrptr,
        we_b   => do_write,
        clk    => clk,
        q_b    => open
    );
		
end Behavioral;
