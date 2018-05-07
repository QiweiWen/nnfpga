library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.helperpkg.all;
use work.nn_arith_package.all;

entity multaccu is
port (
    clk: in std_logic;
    alrst: in std_logic;
    A : in std_logic_vector (15 downto 0);
    B : in std_logic_vector (15 downto 0);
    vin : in std_logic;
    fin : in std_logic;
    P : out std_logic_vector (15 downto 0);
    vout: out std_logic
);
end multaccu;

architecture Behavioral of multaccu is
component xbip_multadd_1 IS
  PORT (
    A : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    B : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    C : IN STD_LOGIC_VECTOR(47 DOWNTO 0);
    PCIN : IN STD_LOGIC_VECTOR(47 DOWNTO 0);
    SUBTRACT : IN STD_LOGIC;
    P : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
    PCOUT : OUT STD_LOGIC_VECTOR(47 DOWNTO 0)
  );
END component xbip_multadd_1;

signal sig_A: std_logic_vector (15 downto 0);
signal sig_B: std_logic_vector (15 downto 0);

signal sig_fin: std_logic;

-- current running sum
signal curr_sum: std_logic_vector (47 downto 0);
signal next_sum: std_logic_vector (47 downto 0);

begin

sig_A <= (others => '0') when vin = '0' else A; 
sig_B <= (others => '0') when vin = '0' else B; 

sig_fin <= '1' when vin = '1' and fin = '1' else '0';

xillinx_dsp_multadd: xbip_multadd_1
port map (
    A => sig_A,
    B => sig_B,
    C => (others => '0'),
    PCIN => curr_sum,
    subtract => '0',
    PCOUT => next_sum,
    P => open
);

sum_proc: process (clk, alrst) is
begin
    if (rising_edge(clk)) then
        if (alrst = '0') then
            curr_sum <= (others => '0');
        else
            curr_sum <= next_sum;
        end if;
    end if;
end process;

vout_proc: process (clk, alrst) is
begin
    if (rising_edge(clk)) then
        if (alrst = '0') then
            vout <= '0';
        else
            vout <= sig_fin; 
        end if;
    end if;
end process;

P <= fun_mul_truncate (curr_sum);

end Behavioral;
