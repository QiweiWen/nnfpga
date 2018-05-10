-- 1/5/2018
-- dug this fellow from the grave to see if it can be reused 

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.helperpkg.all;
use work.nn_arith_package.all;
library ieee_proposed;
use ieee_proposed.fixed_pkg.all;
use ieee.math_real.all;

entity row_processor is
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
    ve_req     : out std_logic;
-- product terms output channel
    dataout: out std_logic_vector (15 downto 0);
    validout: out std_logic;
-- signals forwarded to the adjacent row processor down the line
    validfwd: out std_logic;
    datafwd: out std_logic_vector (15 downto 0)
);
end row_processor;

architecture Behavioral of row_processor is

-- used to delay signals for alignment
component delay_buffer is
    generic(
        ncycles: integer;
        width:   integer
    );
    port(
        clk: in std_logic;
        rst: in std_logic;
        din: in std_logic_vector (width - 1 downto 0);
        dout: out std_logic_vector (width - 1 downto 0)
    );
end component delay_buffer;

component accumulator is
port (
    clk: in std_logic;
    alrst: in std_logic;
    datain: in std_logic_vector (31 downto 0);
    validin: in std_logic;
    lastone: in std_logic;
    dataout: out std_logic_vector (15 downto 0);
    validout: out std_logic
);
end component accumulator;

signal ve_datain_delayed: std_logic_vector (15 downto 0);
signal col_ptr: integer range 0 to ncols - 1; 
-- the intermediate product term
subtype product_type is std_logic_vector (31 downto 0);
signal product: std_logic_vector (31 downto 0);
signal sig_l1_raddr: integer range 0 to ncols - 1;

signal lastone: std_logic;

signal accumulator_pipe: std_logic_vector (33 downto 0);

begin
-- will read parameters from cache 
-- as long as we are asked to compute stuff?
l1_rden <= ve_validin;

-- row processor is always ready to consume more vector elements
ve_req <= '1';

l1_raddr <= sig_l1_raddr;
sig_l1_raddr_proc: 
process (clk, alrst) is
begin
    if (rising_edge(clk)) then
        if (alrst = '0') then
            sig_l1_raddr <= 0;
        elsif (ve_validin = '1') then
            sig_l1_raddr <= (sig_l1_raddr + 1) mod ncols;
        end if;
    end if;
end process;

-- pass stuff to the next PE down the line
fwd_proc:
process (clk, alrst) is
begin
    if (rising_edge(clk)) then
        if (alrst = '0') then
            datafwd <= (others => '0');
            validfwd <= '0';
        else
            datafwd <= ve_datain;
            validfwd <= ve_validin;
        end if;
    end if;
end process;

-- delay vector input to make up for l1 cache latency
vector_input_delay: delay_buffer
generic map(
    width => 16,
    ncycles => 1
)
port map (
    clk => clk,
    rst => alrst,
    din => ve_datain, 
    dout => ve_datain_delayed
);

colptr_proc:
process (clk, alrst) is
begin
    if (rising_edge(clk)) then
        if (alrst = '0') then
            col_ptr <= 0;
        else
            if (l1_vin = '1') then
                col_ptr <= (col_ptr + 1) mod ncols;
            end if;
        end if;
    end if;
end process;

lastone <= '1' when (col_ptr = ncols - 1) else '0';
product <= product_type (to_sfixed(ve_datain_delayed, PARAM_DEC - 1, -PARAM_FRC) * 
                         to_sfixed(l1_din,            PARAM_DEC - 1, -PARAM_FRC));

-- accumulator input pipeline
accu_pipe: 
process (clk, alrst) is
begin
    if (rising_edge(clk)) then
        if (alrst = '0') then
            accumulator_pipe <= (others => '0');
        else
            accumulator_pipe(33) <= l1_vin; 
            accumulator_pipe(32) <= lastone; 
            accumulator_pipe(31 downto 0) <= product;
        end if;
    end if;
end process;

summing: accumulator
port map(
    clk => clk,
    alrst => alrst,
    datain => accumulator_pipe(31 downto 0),
    validin => accumulator_pipe(33),     
    lastone => accumulator_pipe(32), 
    dataout => dataout,
    validout => validout
);

end Behavioral;
