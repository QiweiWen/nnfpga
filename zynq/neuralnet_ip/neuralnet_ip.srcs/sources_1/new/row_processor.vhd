----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.02.2018 21:56:29
-- Design Name: 
-- Module Name: row_processor - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


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
    l1_streamin: in std_logic;
    l1_datain: in std_logic_vector (15 downto 0);
-- vector input channel
    ve_datain: in std_logic_vector (15 downto 0);
    ve_validin: in std_logic;
-- product terms output channel
    dataout: out std_logic_vector (15 downto 0);
    validout: out std_logic;
    -- this flags that all the products that
    -- will sum to a vector element have been computed
    finished: out std_logic; 
-- signals forwarded to the adjacent row processor down the line
    validfwd: out std_logic;
    datafwd: out std_logic_vector (15 downto 0)
);
end row_processor;

architecture Behavioral of row_processor is

function func_safe_mult (
    A: std_logic_vector (15 downto 0);
    B: std_logic_vector (15 downto 0)
)return std_logic_vector is
    variable A_sfixed: sfixed (PARAM_DEC - 1 downto -PARAM_FRC);
    variable B_sfixed: sfixed (PARAM_DEC - 1 downto -PARAM_FRC);
    variable C_sfixed_full: sfixed (2* PARAM_DEC - 1 downto -2* PARAM_FRC); 
    variable C_stdvec_full: std_logic_vector (31 downto 0);
    subtype  mult_result_type is std_logic_vector (31 downto 0); 
    variable ret: std_logic_vector (15 downto 0);
begin
    A_sfixed := to_sfixed (A, PARAM_DEC - 1, -PARAM_FRC);
    B_sfixed := to_sfixed (B, PARAM_DEC - 1, -PARAM_FRC);
    C_sfixed_full := A_sfixed * B_sfixed; 
    C_stdvec_full := mult_result_type (C_sfixed_full);
    ret := fun_mul_truncate (C_stdvec_full);
    return ret;
end function;

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

-- used for holding row vector elements
component l1_cache is
generic(
    ncols: integer := 10
);
port (
    clk: in std_logic;
    alrst: in std_logic;
-- input side from l2 cache
    streamin: in std_logic;
    datain: in std_logic_vector (15 downto 0);
-- output side to the row processing element
    streamout: in std_logic;
    dataout: out std_logic_vector (15 downto 0);
    validout: out std_logic
);
end component l1_cache;


signal ve_datain_delayed: std_logic_vector (15 downto 0);
signal col_ptr: integer range ncols - 1 downto 0;
-- l1 cache signals
signal l1_re: std_logic;
signal l1_dataout: std_logic_vector (15 downto 0);
signal l1_validout: std_logic;
-- the intermediate product term
signal product: std_logic_vector (15 downto 0);

begin
-- will read parameters from cache 
-- as long as we are asked to compute stuff?
l1_re <= ve_validin;

weight_memory: l1_cache
generic map(
    ncols => ncols
)
port map(
    clk => clk,
    alrst => alrst,
    streamin => l1_streamin,
    datain => l1_datain,
    streamout => l1_re,
    dataout => l1_dataout,
    validout => l1_validout
);


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
    ncycles => 2
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
            if (l1_validout = '1') then
                col_ptr <= (col_ptr + 1) mod ncols;
            end if;
        end if;
    end if;
end process;

finished <= '1' when (col_ptr = ncols - 1) else '0' after 20 ns;

validout <= l1_validout after 20 ns;
product <= func_safe_mult (ve_datain_delayed, l1_dataout); 
dataout <= product;

end Behavioral;
