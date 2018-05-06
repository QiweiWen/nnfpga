library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity multadd_profiling is
    port (clk: in std_logic;
          A : in std_logic_vector (15 downto 0);
          B : in std_logic_vector (15 downto 0);
          C : in std_logic_vector (15 downto 0);
          P : out std_logic_vector (15 downto 0));
end multadd_profiling;

architecture Behavioral of multadd_profiling is

    signal A_reg: std_logic_vector (15 downto 0);
    signal B_reg: std_logic_vector (15 downto 0);
    signal C_reg: std_logic_vector (15 downto 0);
    signal P_reg: std_logic_vector (15 downto 0);

    component multadd is
    port (A : in std_logic_vector (15 downto 0);
          B : in std_logic_vector (15 downto 0);
          C : in std_logic_vector (15 downto 0);
          P : out std_logic_vector (15 downto 0));
    end component multadd;

begin

uut: multadd
port map(
    A => A_reg,
    B => B_reg,
    C => C_reg,
    P => P_reg
);

pipes: process (clk) is
begin
    if (rising_edge(clk)) then
        A_reg <= A;
        B_reg <= B;
        C_reg <= C;
        P <= P_reg;
    end if;
end process;


end Behavioral;
