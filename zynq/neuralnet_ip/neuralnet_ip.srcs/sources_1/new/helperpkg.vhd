----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.01.2018 21:09:08
-- Design Name: 
-- Module Name: helperpkg - Behavioral
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

package helperpkg is
    constant PARAM_DEC: integer;
    constant PARAM_FRC: integer;
    type wordarr_t is array (integer range <>) of std_logic_vector (15 downto 0);
end package;

package body helperpkg is
    constant PARAM_DEC: integer := 8;
    constant PARAM_FRC: integer := 8;
end package body;
