library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.helperpkg.all;
use work.nn_arith_package.all;
library ieee_proposed;
use ieee_proposed.fixed_pkg.all;

entity accumulator is
port (
    clk: in std_logic;
    alrst: in std_logic;
    datain: in std_logic_vector (15 downto 0);
    validin: in std_logic;
    lastone: in std_logic;
    dataout: out std_logic_vector (15 downto 0);
    validout: out std_logic
);
end accumulator;

architecture Behavioral of accumulator is

function func_safe_sum (
    A: std_logic_vector (15 downto 0);
    B: std_logic_vector (15 downto 0)
)return std_logic_vector is
    variable A_sfixed: sfixed (PARAM_DEC - 1 downto -PARAM_FRC);
    variable B_sfixed: sfixed (PARAM_DEC - 1 downto -PARAM_FRC);
    variable C_sfixed_full: sfixed (PARAM_DEC downto -PARAM_FRC); 
    variable C_stdvec_full: std_logic_vector (16 downto 0);
    subtype  sum_result_type is std_logic_vector (16 downto 0);
    variable ret: std_logic_vector (15 downto 0);
begin
    A_sfixed := to_sfixed (A, PARAM_DEC - 1, -PARAM_FRC);
    B_sfixed := to_sfixed (B, PARAM_DEC - 1, -PARAM_FRC);
    C_sfixed_full := A_sfixed + B_sfixed; 
    C_stdvec_full := sum_result_type (C_sfixed_full);
    ret := fun_add_truncate (C_stdvec_full);
    return ret;
end function;

signal sig_sum: std_logic_vector (15 downto 0); 
signal sig_validout: std_logic;

begin

summing_proc:
process (clk) is
begin
    if (rising_edge(clk)) then
        if (alrst = '0') then
            sig_sum <= (others => '0');
        elsif (sig_validout = '1') then
            if (validin = '1') then
                sig_sum <= datain;
            else
                sig_sum <= (others => '0');
            end if;
        elsif (validin = '1') then
            sig_sum <= func_safe_sum (sig_sum, datain);
        end if;
    end if;
end process;

validout_proc:
process (clk) is
begin
    if (rising_edge(clk)) then
        if (alrst = '0') then
            sig_validout <= '0';
        else
            sig_validout <= lastone;  
        end if;
    end if;
end process;

validout <= sig_validout;
dataout <= sig_sum;

end Behavioral;
