
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.NUMERIC_STD.ALL;
use work.const_package.all;

library ieee_proposed;
use ieee_proposed.fixed_pkg.all;

entity PE_tb is
end PE_tb;

architecture Behavioral of PE_tb is

component rPE is
generic(
    -- number of parameters held by this PE
    LENGTH: integer
);
port (
    clk: in std_logic;
    rst: in std_logic;
    --parameter update: data, valid flag, strobe
    update: in std_logic;   
    strobein: in std_logic_vector (
            PARAM_PER_CHUNK - 1 downto 0); 
    --input data to multiply/acumulate
    validin: in std_logic;
    datain: in std_logic_vector
                (FIFO_WIDTH - 1 downto 0);
    --whether the input data is the last
    lastone: in std_logic;
    -- forward to next PE
    validfwd: out std_logic;
    datafwd: out std_logic_vector
                (FIFO_WIDTH - 1 downto 0);
    --output data and valid
    validout: out std_logic;
    dataout: out std_logic_vector
                (FIFO_WIDTH - 1 downto 0);
    --number of valid output
    strobeout: out std_logic_vector (
            PARAM_PER_CHUNK - 1 downto 0); 
    outputfin: out std_logic
);

end component rPE;

signal sig_clk  :std_logic;
signal sig_rst  :std_logic;
signal sig_update  :std_logic;   
signal sig_strobein  :std_logic_vector (
            PARAM_PER_CHUNK - 1 downto 0); 
signal sig_validin  :std_logic;
signal sig_datain  :std_logic_vector
                (FIFO_WIDTH - 1 downto 0);
signal sig_lastone  :std_logic;
signal sig_validfwd  :std_logic;
signal sig_datafwd  :std_logic_vector
                (FIFO_WIDTH - 1 downto 0);
signal sig_validout  :std_logic;
signal sig_dataout  :std_logic_vector
                (FIFO_WIDTH - 1 downto 0);
signal sig_strobeout  :std_logic_vector (
            PARAM_PER_CHUNK - 1 downto 0); 
signal sig_outputfin  :std_logic;
subtype fixed_type is std_logic_vector
        (PARAM_WIDTH - 1 downto 0);
begin

uut: rPE
generic map (
    LENGTH => 5
)
port map (
    clk => sig_clk,
    rst => sig_rst,
    update => sig_update,
    strobein => sig_strobein
        (PARAM_PER_CHUNK - 1 downto 0), 
    --input data to multiply/acumulate
    validin => sig_validin,
    datain => sig_datain
                (FIFO_WIDTH - 1 downto 0),
    --whether the input data is the last
    lastone => sig_lastone,
    -- forward to next PE
    validfwd => sig_validfwd,
    datafwd => sig_datafwd
                (FIFO_WIDTH - 1 downto 0),
    --output data and valid
    validout => sig_validout,
    dataout => sig_dataout
                (FIFO_WIDTH - 1 downto 0),
    --number of valid output
    strobeout => sig_strobeout
        (PARAM_PER_CHUNK - 1 downto 0), 
    outputfin => sig_outputfin
);

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
procedure param_put(
    constant n1: real;
    constant n2: real;
    constant num: natural)
is
begin
    sig_update <= '1';
    sig_datain <= 
    fixed_type(to_sfixed(n1,PARAM_DEC - 1, -PARAM_FRC))
   &fixed_type(to_sfixed(n2,PARAM_DEC - 1, -PARAM_FRC));
    
    if (num = 2) then
        sig_strobein <= "11";
    elsif (num = 1) then
        sig_strobein <= "01";
    else
        sig_strobein <= "00";
    end if;
 
end procedure;

procedure operand_stream(
    constant n1: real;
    constant n2: real;
    constant num: natural)
is
begin
    sig_validin <= '1';
    sig_datain <= 
    fixed_type(to_sfixed(n1,PARAM_DEC - 1, -PARAM_FRC))
   &fixed_type(to_sfixed(n2,PARAM_DEC - 1, -PARAM_FRC));
    
    if (num = 2) then
        sig_strobein <= "11";
    elsif (num = 1) then
        sig_strobein <= "01";
    else
        sig_strobein <= "00";
    end if;
end procedure;


begin
    wait for 10 ns;
    sig_rst <= '0';
    wait for 100 ns;
    sig_rst <= '1';
    sig_update <= '0';
    sig_datain <= (others => '0');
    sig_validin <= '0';
    sig_lastone <= '0';
    param_put(1.23,2.34,2);
    wait for 100 ns;
    param_put(5.67,3.45,2);
    wait for 100 ns;
    param_put(0.0,-5.67, 1);
    wait for 100 ns;
    sig_update <= '0';
    operand_stream (1.0,1.0,2);
    wait for 100 ns;   
    operand_stream (1.1,1.1,2);
    wait for 100 ns;
    sig_lastone <= '1';
    operand_stream (1.1,1.5,1);
    wait for 100 ns;
    sig_validin <= '0';
    sig_lastone <= '0';
    wait;
wait;
end process;

end Behavioral;
