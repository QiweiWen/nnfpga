----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.10.2017 20:19:50
-- Design Name: 
-- Module Name: sigmoidfull - Behavioral
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
library ieee_proposed;
use ieee_proposed.fixed_pkg.all;

use work.helperpkg.all;

entity sigmoidfull is
port (
    clk: in std_logic;
    datain: in std_logic_vector (16 - 1 downto 0);
    validin: in std_logic;
    dataout: 
        out std_logic_vector (16 - 1 downto 0);
    validout: out std_logic);
end sigmoidfull;

architecture Behavioral of sigmoidfull is

component sigmoid is
port (
    clk: in std_logic;
    datain: in std_logic_vector (16 - 2 downto 0);
    validin: in std_logic;
    dataout: 
        out std_logic_vector (16 - 2 downto 0);
    validout: out std_logic);
end component sigmoid;

signal inabsval: std_logic_vector 
    (16 - 1 downto 0);
signal insign  : std_logic;
signal innegative: std_logic_vector
    (16 - 1 downto 0);

signal sigmoidout:
    std_logic_vector (16 - 2 downto 0);
signal signdelay: std_logic;
signal outcompliment:
    std_logic_vector (16 - 2 downto 0);

signal stdvec_one: std_logic_vector 
(16 - 2 downto 0) :=
            (PARAM_FRC => '1',
            others    => '0');

begin

insign <= datain (16 - 1);

activate:
sigmoid port map
(
    clk => clk,
    datain => inabsval (16 - 2 downto 0),
    validin => validin,
    dataout => sigmoidout,
    validout => validout
);

innegative <= std_logic_vector
              (to_signed((-1* to_integer(signed(datain))),
                        innegative'length));
inabsval <= datain when insign = '0' else
            innegative;

sign_delay:
process (clk)
begin
    if (clk'event and clk = '1') then
        signdelay <= insign;
    end if;
end process;

outcompliment <=
std_logic_vector
    (to_signed( to_integer(signed(stdvec_one)) - 
                to_integer(signed(sigmoidout)),
                outcompliment'length));
dataout <= '0' & sigmoidout when signdelay = '0' else
           '0' & outcompliment; 

end Behavioral;



