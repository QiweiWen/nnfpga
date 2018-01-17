----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.12.2017 22:31:20
-- Design Name: 
-- Module Name: RMJ_tb - Behavioral
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
use work.const_package.all;
use ieee.math_real.all;

library ieee_proposed;
use ieee_proposed.fixed_pkg.all;

use ieee.math_real.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity RMJ_tb is
--  Port ( );
end RMJ_tb;

architecture Behavioral of RMJ_tb is

constant nrows: integer := 5;
constant ncols: integer := 5;
constant UPDATE_CYCLES: integer
    := integer (ceil( real(ncols * nrows)/real(PARAM_PER_CHUNK) ));
constant MULT_CYCLES: integer
    := integer (ceil( real(ncols)/real(PARAM_PER_CHUNK) ));
component RMJmatrix is
generic (
    nrows: integer := 10;
    ncols: integer := 10
);
port(
    clk: in std_logic;
    rst: in std_logic;
    -- pin to control parameter update
    update: in std_logic;
    -- pins associated with serial input
    datain: in std_logic_vector (FIFO_WIDTH - 1 downto 0);
    validin: in std_logic;
    lastone: in std_logic;
    strobein: in std_logic_vector 
        (PARAM_PER_CHUNK - 1 downto 0); 
    -- pins associated with parallel output
    strobeout: out std_logic_vector (nrows - 1 downto 0);
    arrayout: out wordarr_t (nrows - 1 downto 0);
    vectorfin: out std_logic
);
end component RMJmatrix;
signal sig_clk: std_logic;
signal sig_rst: std_logic;
signal sig_update: std_logic;
signal sig_datain: std_logic_vector (FIFO_WIDTH - 1 downto 0);
signal sig_validin: std_logic;
signal sig_lastone: std_logic;
signal sig_strobein: std_logic_vector 
    (PARAM_PER_CHUNK - 1 downto 0); 
signal sig_strobeout: std_logic_vector (nrows - 1 downto 0);
signal sig_arrayout: wordarr_t (nrows - 1 downto 0);
signal sig_vectorfin: std_logic;

begin

clk_process:
process is
begin
    sig_clk <= '1';
    wait for 50 ns;
    sig_clk <= '0';
    wait for 50 ns; 
end process;

test_proc:
process is

subtype param_type is std_logic_vector (PARAM_WIDTH - 1 downto 0);
procedure randomdata(
    constant rand: real;
    constant range_of_rand: real;
    halfword: out std_logic_vector (PARAM_WIDTH - 1 downto 0)
)
is
    variable rand_num: real;
begin
    rand_num := rand*range_of_rand - range_of_rand/2.0;
    halfword := param_type (to_sfixed(rand_num, PARAM_DEC - 1, -PARAM_FRC));  
end procedure;

procedure param_saturate_test(
    constant cycles: integer
)
is
    variable seed1, seed2: positive;
    variable rand: real;
    variable range_of_rand : real := 10.0;
    variable halfword0:std_logic_vector (PARAM_WIDTH - 1 downto 0);
    variable halfword1:std_logic_vector (PARAM_WIDTH - 1 downto 0);
begin
    for I in 0 to cycles - 1 loop 
        uniform(seed1, seed2, rand);
        randomdata (rand, range_of_rand, halfword0);
        uniform(seed1, seed2, rand);
        randomdata (rand, range_of_rand, halfword1);
        sig_datain <= halfword0 & halfword1;
        if ((I = cycles - 1 and (nrows * ncols) mod 2 /= 0)) then
            sig_strobein <= "01";
        else
            sig_strobein <= "11";
        end if;

        if (I = cycles - 1) then
            sig_lastone <= '1';
        else
            sig_lastone <= '0';
        end if;
        wait for 100 ns;
    end loop;
end procedure;


begin
    sig_rst <= '0';
    wait for 10 ns;
    sig_update <= '0';
    sig_validin <= '0';
    sig_lastone <= '0';
    wait for 100 ns;
    sig_rst <= '1';
    sig_update <= '1';
    
    param_saturate_test(UPDATE_CYCLES);
    sig_update <= '0';
    sig_validin <= '1';
    param_saturate_test(MULT_CYCLES);
    sig_validin <= '0';
    sig_strobein <= (others => '0');
    wait;
end process;

uut:RMJmatrix
generic map(
    nrows => nrows,
    ncols => ncols
)
port map(
    clk => sig_clk,
    rst => sig_rst,
    update => sig_update,
    datain => sig_datain,
    validin => sig_validin,
    lastone => sig_lastone,
    strobein => sig_strobein,
    strobeout => sig_strobeout,
    arrayout => sig_arrayout,
    vectorfin => sig_vectorfin
);

end Behavioral;
