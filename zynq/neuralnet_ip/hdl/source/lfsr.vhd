----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date: 03.02.2018 16:44:19
-- Design Name:
-- Module Name: lfsr - Behavioral
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

-- linear feedback shift register
-- use as a coarse-grain random number generator
entity lfsr is
port(
    clk: in std_logic;
    alrst: in std_logic;
    pseudornd: out std_logic_vector (15 downto 0)
);
end lfsr;

architecture Behavioral of lfsr is
    signal shiftreg: std_logic_vector (15 downto 0);
    signal shiftin: std_logic;
    signal shiftreg_next: std_logic_vector (15 downto 0);
begin
    shiftin <= ((shiftreg(15)) xnor shiftreg(13) xnor shiftreg(12) xnor shiftreg(10));
    shiftreg_proc:
    process(clk, alrst) is
    begin
        if (rising_edge(clk)) then
            if (alrst = '0') then
                shiftreg <= X"dead";
            else
                shiftreg(0) <= shiftin;
                for I in 15 downto 1 loop
                    shiftreg(I) <= shiftreg (I - 1);
                end loop;
            end if;
        end if;
    end process;
    pseudornd <= shiftreg;

end Behavioral;
