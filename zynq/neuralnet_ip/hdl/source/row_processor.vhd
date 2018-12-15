library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.helperpkg.all;
use work.nn_arith_package.all;
library ieee_proposed;
use work.fixed_pkg.all;
use ieee.math_real.all;

entity row_processor is
generic (
    ncols: natural := 100
);
port(
    clk: in std_logic;
    alrst: in std_logic;
    ready    : out std_logic;
-- wram cache external interface
    wram_rden: out std_logic;
    wram_din : in std_logic_vector (15 downto 0);
    wram_vin : in std_logic;
    wram_rdy : in std_logic;
-- vector input channel
    ve_datain: in std_logic_vector (15 downto 0);
    ve_validin: in std_logic;
-- product terms output channel
    dataout: out std_logic_vector (31 downto 0);
    validout: out std_logic;
-- vector input forwarded to the adjacent row processor down the line
    validfwd: out std_logic;
    datafwd: out std_logic_vector (15 downto 0)
);
end row_processor;

architecture Behavioral of row_processor is

component accumulator is
port (
    clk: in std_logic;
    alrst: in std_logic;
    datain: in std_logic_vector (31 downto 0);
    validin: in std_logic;
    lastone: in std_logic;
    dataout: out std_logic_vector (31 downto 0);
    validout: out std_logic
);
end component accumulator;

signal col_ptr: natural range 0 to ncols - 1;
-- the intermediate product term
signal product: std_logic_vector (31 downto 0);

signal lastone: std_logic;

signal accumulator_pipe: std_logic_vector (33 downto 0);

begin
-- will read parameters from cache
-- as long as we are asked to compute stuff
wram_rden <= '1' when ve_validin = '1' and wram_rdy = '1' else '0';

-- row processor is always ready to consume more vector elements
ready <= '1' when alrst = '1' and wram_rdy = '1' else '0';

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

colptr_proc:
process (clk, alrst) is
begin
    if (rising_edge(clk)) then
        if (alrst = '0') then
            col_ptr <= 0;
        else
            if (wram_vin = '1') then
                col_ptr <= (col_ptr + 1) mod ncols;
            end if;
        end if;
    end if;
end process;

lastone <= '1' when (col_ptr = ncols - 1) else '0';
product <= slv_32_t (to_sfixed(ve_datain, PARAM_DEC - 1, -PARAM_FRC) *
                     to_sfixed(wram_din,    PARAM_DEC - 1, -PARAM_FRC));

-- accumulator input pipeline
accu_pipe:
process (clk, alrst) is
begin
    if (rising_edge(clk)) then
        if (alrst = '0') then
            accumulator_pipe <= (others => '0');
        else
            accumulator_pipe(33) <= wram_vin;
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
