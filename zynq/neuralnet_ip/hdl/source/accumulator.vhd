library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.helperpkg.all;
use work.nn_arith_package.all;
library ieee_proposed;
use work.fixed_pkg.all;

entity accumulator is
port (
    clk: in std_logic;
    alrst: in std_logic;
    datain: in std_logic_vector (31 downto 0);
    validin: in std_logic;
    lastone: in std_logic;
    dataout: out std_logic_vector (31 downto 0);
    validout: out std_logic
);
end accumulator;

architecture Behavioral of accumulator is

signal sig_sum: std_logic_vector (31 downto 0); 
signal sig_validout: std_logic;

begin

summing_proc:
process (clk) is
subtype full_sum_type is std_logic_vector (32 downto 0);
variable full_sum: std_logic_vector (32 downto 0);
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
            full_sum := full_sum_type(to_sfixed(sig_sum, 2*PARAM_DEC - 1, -2*PARAM_FRC) + 
                                      to_sfixed(datain,  2*PARAM_DEC - 1, -2*PARAM_FRC));
            sig_sum <= fun_add_truncate (full_sum);
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
