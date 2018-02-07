

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity param_feeder is
generic(
    ncols: integer := 10
);
port (
    clk: in std_logic;
    alrst: in std_logic;
-- input data, either from the last unit or
-- directly from L2 cache
    datain: in std_logic_vector (15 downto 0);
    validin: in std_logic;
-- data forwarded to the next row feeder
    datafwd: out std_logic_vector (15 downto 0);
    validfwd: out std_logic;
-- data passed to the row processor    
    dataout: out std_logic_vector (15 downto 0);
    validout: out std_logic;
-- flag passed to the last row feeder
-- use this signal from the top most unit to
-- drive reset
    full : out std_logic;
-- flag passed from the next row feeder
    slave_full: in std_logic
);
end param_feeder;

architecture Behavioral of param_feeder is

-- finished filling the cache of this row processor
signal sig_full: std_logic;
-- how many words we've written to the row processor
signal nwords_written: integer range ncols - 1 downto 0;
-- latched signals to be forwarded next cycle
signal validin_pipeline: std_logic;
signal datain_pipeline: std_logic_vector (15 downto 0);

-- forwarding: send to next unit
-- writing: send to row processor
type state_t is (forwarding, writing);
signal this_state: state_t;
signal next_state: state_t;

begin

dataout <= datain when this_state = writing else (others => '0');
validout <= validin when this_state = writing else '0';

pipeline_proc:
process (clk) is
begin
    if (rising_edge(clk)) then
        if (alrst = '0') then
            datain_pipeline <= (others => '0'); 
            validin_pipeline <= '0';
        elsif (this_state = forwarding) then
            datain_pipeline <= datain; 
            validin_pipeline <= validin;
        end if;
    end if;
end process;

datafwd <= datain_pipeline;
validfwd <= validin_pipeline;

-- set up for the next cycle where the last chunk of our data
-- will be forwarded
sig_full <= '1' when validin = '1' and nwords_written = ncols - 1 else '0';
full <= sig_full;

nwritten_proc:
process (clk) is
begin
    if (rising_edge (clk)) then
        if (alrst = '0') then
            nwords_written <= 0;
        elsif (validin = '1' and this_state = writing) then
            nwords_written <= (nwords_written + 1) mod ncols;
        end if;
    end if;
end process;

next_state_logic:
process (sig_full, slave_full, this_state, alrst) is
begin
    if (slave_full = '1') then
        next_state <= writing;
    elsif (alrst = '0' or sig_full = '1') then
        next_state <= forwarding;
    else
        next_state <= this_state;
    end if;
end process;

state_transition:
process (clk) is
begin
    if (rising_edge(clk)) then
        this_state <= next_state;
    end if;
end process;

end Behavioral;
