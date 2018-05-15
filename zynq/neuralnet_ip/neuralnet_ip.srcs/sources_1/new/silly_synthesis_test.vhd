library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity silly_synthesis_test is
    port (
        clk: in std_logic;
        A: in std_logic_vector (47 downto 0);
        B: out std_logic_vector (47 downto 0) 
    );
end silly_synthesis_test;

architecture Behavioral of silly_synthesis_test is

component multadd is
    port (A : in std_logic_vector (15 downto 0);
          B : in std_logic_vector (15 downto 0);
          C : in std_logic_vector (47 downto 0);
          P : out std_logic_vector (47 downto 0));
end component multadd;

constant big_arse_number: integer := 400;
type stupid_type is array (big_arse_number downto 0) of 
    std_logic_vector (47 downto 0);
signal stupid_array: stupid_type;
signal stupid_array_next: stupid_type;

begin

stupid_array (0) <= A;
B <= stupid_array (big_arse_number);

stupid_shit_gen:
for I in 1 to big_arse_number generate
    dsp_slice: multadd
    port map(
        A => stupid_array (I - 1) (15 downto 0),
        B => stupid_array (I - 1) (31 downto 16),
        C => stupid_array (I - 1),
        P => stupid_array_next (I)
    );
end generate;

registers:
process (clk) is
begin
    if (rising_edge(clk)) then
        for I in 1 to big_arse_number loop
            stupid_array(I) <= stupid_array_next (I);
        end loop;
    end if;
end process;

end Behavioral;
