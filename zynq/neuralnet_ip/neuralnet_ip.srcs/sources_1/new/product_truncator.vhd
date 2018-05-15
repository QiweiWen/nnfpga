library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.helperpkg.all;
use work.nn_arith_package.all;
library ieee_proposed;
use ieee_proposed.fixed_pkg.all;
use ieee.math_real.all;

entity product_truncator is
generic (width : integer := 32);
port (
    clk: in std_logic;
    alrst: in std_logic;   
    din: in std_logic_vector (width - 1 downto 0);
    vin: in std_logic;
    dout: out std_logic_vector (15 downto 0);
    vout: out std_logic
);
end product_truncator;

architecture Behavioral of product_truncator is
begin
    
    truncation: process (clk, alrst) is
    begin
        if (rising_edge(clk)) then
            if (alrst = '0') then
                dout <= (others => '0');
                vout <= '0';
            else
                dout <= fun_mul_truncate (din); 
                vout <= vin;
            end if;
        end if;
    end process;

end Behavioral;
