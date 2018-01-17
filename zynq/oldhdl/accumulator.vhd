----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.01.2018 01:12:52
-- Design Name: 
-- Module Name: accumulator - Behavioral
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
use work.const_package.all;
use work.helperpkg.all;
use work.nn_arith_package.all;
library ieee_proposed;
use ieee_proposed.fixed_pkg.all;

-- only the first matrix (row-major) will need to consume
-- data at 4 bytes per cycle. subsequent layers can be simper
-- and consume one parameter per cycle, because the first
-- layer only produces one vector element per cycle anyway
entity accumulator is
    Port ( 
        clk : in STD_LOGIC;
        rst : in STD_LOGIC;
        validin: in std_logic;
        lastone: in std_logic;
        datain: in std_logic_vector (FIFO_WIDTH - 1 downto 0);
        strobein: in std_logic_vector (PARAM_PER_CHUNK - 1 downto 0);
        dataout: out std_logic_vector (FIFO_WIDTH - 1 downto 0);
        validout: out std_logic
    );
end accumulator;

architecture Behavioral of accumulator is

signal sig_sum_carry:sfixed (PARAM_DEC downto -PARAM_FRC);
signal sig_sum: std_logic_vector (PARAM_WIDTH - 1 downto 0); 

signal validout_in : std_logic;
signal sig_validout: std_logic;

signal wordsum: std_logic_vector (PARAM_WIDTH - 1 downto 0);

subtype param_type_stdvec is std_logic_vector (PARAM_WIDTH - 1 downto 0);
subtype param_carry_type_stdvec is std_logic_vector (PARAM_WIDTH downto 0);

function fun_word_sum (
    datain: std_logic_vector (FIFO_WIDTH - 1 downto 0);
    strobein: std_logic_vector (PARAM_PER_CHUNK - 1 downto 0)
)return std_logic_vector is
variable sum_fixed: sfixed (PARAM_DEC downto -PARAM_FRC);
variable var_ret_fixed: sfixed (PARAM_DEC - 1 downto -PARAM_FRC);
variable var_ret: std_logic_vector (PARAM_WIDTH - 1 downto 0);
begin
    var_ret_fixed := to_sfixed (0.0, var_ret_fixed);
    var_ret := (others => '0');
    
    for I in 0 to PARAM_PER_CHUNK - 1 loop
        if (strobein(I) = '1') then
            sum_fixed := var_ret_fixed + 
                         to_sfixed(datain((I+1)*PARAM_WIDTH - 1 downto I*PARAM_WIDTH), 
                                   PARAM_DEC - 1, -PARAM_FRC);
            var_ret_fixed := sum_fixed (PARAM_DEC - 1 downto -PARAM_FRC);
        end if;
    end loop;
    var_ret := param_type_stdvec (var_ret_fixed);
    return var_ret;

end function;

begin

dataout (PARAM_WIDTH - 1 downto 0) <= sig_sum;
dataout (FIFO_WIDTH - 1 downto PARAM_WIDTH) <= (others => '0');

validout_in <= '1' when (lastone = '1' and validin = '1') else '0';

proc_validout:
process (clk, rst) is
begin
    if (clk'event and clk = '1') then
        if (rst = '0') then
            sig_validout <= '0'; 
        else
            sig_validout <= validout_in;
        end if;
    end if;
end process;
validout <= sig_validout;

proc_accu:
process (clk, rst) is
begin
    if (clk'event and clk = '1') then
        if (rst = '0' or sig_validout = '1') then
            sig_sum_carry <= to_sfixed(0.0, sig_sum_carry);
        elsif (validin = '1') then
            sig_sum_carry <= 
                (to_sfixed (sig_sum, PARAM_DEC - 1, -PARAM_FRC) +
                to_sfixed (wordsum, PARAM_DEC - 1, -PARAM_FRC));
        end if;
    end if;
end process;
sig_sum <= fun_add_truncate (param_carry_type_stdvec(sig_sum_carry));
wordsum <= fun_word_sum(datain, strobein);
end Behavioral;
