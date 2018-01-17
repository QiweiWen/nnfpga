
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use ieee.math_real.all;

package const_package is
    constant FIFO_WIDTH: integer;
    constant PARAM_WIDTH: integer;
    constant PARAM_DEC: integer;
    constant PARAM_FRC: integer;
    constant PARAM_PER_CHUNK: integer;
    -- used for generic-sized input and output
    type wordarr_t is array (integer range <>) of std_logic_vector (31 downto 0);
end package;

package body const_package is
    constant FIFO_WIDTH: integer := 32;
    constant PARAM_WIDTH: integer := 16;
    constant PARAM_DEC: integer := 8;
    constant PARAM_FRC: integer := 8;
    constant PARAM_PER_CHUNK: integer := 
                   (FIFO_WIDTH / PARAM_WIDTH);
end package body;
