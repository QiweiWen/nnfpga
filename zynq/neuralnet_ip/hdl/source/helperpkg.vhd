library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.math_real.all;

package helperpkg is
constant PARAM_DEC: natural;
constant PARAM_FRC: natural;
constant LEARN_RATE: real;
constant DFIFO: natural;
subtype slv_16_t is std_logic_vector(15 downto 0);
subtype slv_32_t is std_logic_vector(31 downto 0);
subtype slv_17_t is std_logic_vector(16 downto 0);
subtype slv_33_t is std_logic_vector(32 downto 0);
end package;

package body helperpkg is
constant PARAM_DEC: natural := 8;
constant PARAM_FRC: natural := 8;
constant LEARN_RATE: real := 0.1;
constant DFIFO: natural := 256;
end package body;
