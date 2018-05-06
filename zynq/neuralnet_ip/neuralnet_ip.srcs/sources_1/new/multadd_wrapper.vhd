library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity multadd_wrapper is
port (
    A: in std_logic_vector (15 downto 0);
    B: in std_logic_vector (15 downto 0);
    C: in std_logic_vector (15 downto 0);
    P: out std_logic_vector (15 downto 0)
);
end multadd_wrapper;

architecture Behavioral of multadd_wrapper is

component xbip_multadd_0 IS
  PORT (
    A : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    B : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    C : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    SUBTRACT : IN STD_LOGIC;
    P : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
    PCOUT : OUT STD_LOGIC_VECTOR(47 DOWNTO 0)
  );
END component xbip_multadd_0;

begin

port_trim: xbip_multadd_0
port map (
    A => A,
    B => B,
    C => C,
    SUBTRACT => '0',
    P => P,
    PCOUT => open
);

end Behavioral;
