----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.01.2018 19:58:50
-- Design Name: 
-- Module Name: delay_buffer - Behavioral
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

entity delay_buffer is
    generic(
        ncycles: natural;
        width:   natural
    );
    port(
        clk: in std_logic;
        rst: in std_logic;
        din: in std_logic_vector (width - 1 downto 0);
        dout: out std_logic_vector (width - 1 downto 0)
    );
end delay_buffer;

architecture Behavioral of delay_buffer is
    
    type shiftreg_t is array (ncycles downto 0)
        of std_logic_vector (width - 1 downto 0);
    
    signal shiftreg : shiftreg_t;
begin
    shiftgen:
    for I in ncycles downto 1 generate
        shiftproc:
        process (clk, rst) is
        begin
            if (rising_edge (clk)) then
                if (rst = '0') then
                    shiftreg(I) <= (others => '0');
                else
                    shiftreg(I) <= shiftreg (I - 1);
                end if;
            end if;
        end process;
    end generate;

    shiftreg (0) <= din;
    dout <= shiftreg (ncycles);

end Behavioral;
