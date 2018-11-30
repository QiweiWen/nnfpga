library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.helperpkg.all;
use work.nn_arith_package.all;
library ieee_proposed;
use work.fixed_pkg.all;
use ieee.math_real.all;


-- single bias unit for forward propagation row processors
entity bias_unit is
port (
    clk: in std_logic;
    alrst: in std_logic;
    unbiased: in std_logic_vector (31 downto 0);
    vin:   in std_logic;
    biased : out std_logic_vector (15 downto 0);
    vout: out std_logic;
    updated: in std_logic_vector (15 downto 0);
    uvin: in std_logic
);
end bias_unit;

architecture Behavioral of bias_unit is
    signal bias_register: std_logic_vector (15 downto 0);
    signal vout_pipe: std_logic;
    signal unbiased_trunc: std_logic_vector (15 downto 0);
begin

    bias_reg_proc: process (clk, alrst) is
    variable full_sum: slv_17_t;
    begin
        if (rising_edge(clk)) then
            if (alrst = '0') then
                bias_register <= (others => '0');
            elsif (uvin = '1') then
                full_sum := slv_17_t(to_sfixed(bias_register, PARAM_DEC - 1, -PARAM_FRC) +
                                     to_sfixed(updated,       PARAM_DEC - 1, -PARAM_FRC));
                bias_register <= fun_add_truncate (full_sum);
            end if;
        end if;
    end process;

    outproc: process (clk, alrst) is
        variable full_biased: slv_17_t;
    begin
        if (rising_edge(clk)) then
            if (alrst = '0') then
                vout_pipe <= '0';
                vout <= '0';
                biased <= (others => '0');
                unbiased_trunc <= (others => '0');
            else
                vout_pipe <= vin;
                vout <= vout_pipe;
                unbiased_trunc <= fun_mul_truncate (unbiased, 2* PARAM_FRC - 1);
                biased <= func_safe_sum (bias_register, unbiased_trunc);
            end if;
        end if;
    end process;
end Behavioral;
