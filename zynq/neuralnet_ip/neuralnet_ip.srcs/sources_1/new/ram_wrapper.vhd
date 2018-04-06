library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- wrapper over true dual port ram that supports reading from one port,
-- performing some operations on the data, and writing into another port
entity ram_wrapper is
generic (
    nitems: integer := 10
);
port (
    clk: in std_logic;
    alrst: in std_logic
);
end ram_wrapper;

architecture Behavioral of ram_wrapper is

begin


end Behavioral;
