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
    -- bit depth of decimal and fractional parts of data
    constant PARAM_DEC: integer;
    constant PARAM_FRC: integer;
    -- number of training examples we will handle in parallel
    constant NTRAINING: integer;
    type wordarr_t is array (integer range <>) of std_logic_vector (15 downto 0);
    function log2( i : natural) return integer;
end package;

package body helperpkg is
    constant PARAM_DEC: integer := 8;
    constant PARAM_FRC: integer := 8;
    constant NTRAINING: integer := 256;

    function log2( i : natural) return integer is
    variable temp    : integer := i;
    variable ret_val : integer := 0; 
    variable roundup: std_logic := '0';
    begin                         
        while temp > 1 loop
            if (temp mod 2 /= 0) then
                roundup := '1';
            end if;
            ret_val := ret_val + 1;
            temp    := temp / 2;     
        end loop;
        if (roundup = '1') then
            ret_val := ret_val + 1;
        end if;
        return ret_val;
    end function;
end package body;
