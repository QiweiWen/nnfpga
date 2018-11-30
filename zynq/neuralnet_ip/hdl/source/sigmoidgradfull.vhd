
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.helperpkg.all;


entity sigmoidgradfull is
port (
    clk: in std_logic;
    rst: in std_logic;
    datain: in std_logic_vector (16 - 1 downto 0);
    validin: in std_logic;
    dataout:
        out std_logic_vector (16 - 1 downto 0);
    validout: out std_logic);
end sigmoidgradfull;

architecture Behavioral of sigmoidgradfull is

component sigmoidgrad is
port (
    clk: in std_logic;
    rst: in std_logic;
    datain: in std_logic_vector (16 - 2 downto 0);
    validin: in std_logic;
    dataout: out std_logic_vector (16 - 2 downto 0);
    validout: out std_logic);
end component sigmoidgrad;

signal inabsval: std_logic_vector (14 downto 0);
signal innegative: std_logic_vector (14 downto 0);

signal sigmoidgrad_dout: std_logic_vector (15 downto 0);
signal sigmoidgrad_vout: std_logic;

begin

in_absval_proc: process (datain) is
    variable in_inverse: std_logic_vector(14 downto 0);
begin
    in_inverse := not (datain(14 downto 0));
    innegative <= std_logic_vector (unsigned (in_inverse) + 1);
end process;

inabsval <= innegative when datain (15) = '1' else datain (14 downto 0);

postitive_half:
sigmoidgrad port map
(
    clk => clk,
    rst  => rst,
    datain => inabsval,
    validin => validin,
    dataout => sigmoidgrad_dout(14 downto 0),
    validout => sigmoidgrad_vout
);

sigmoidgrad_dout (15) <= '0';

outproc: process (clk, rst) is
begin
    if (rising_edge(clk)) then
        if (rst = '0') then
            validout <= '0';
            dataout <= (others => '0');
        else
            validout <= sigmoidgrad_vout;
            dataout  <= sigmoidgrad_dout;
        end if;
    end if;
end process;

end Behavioral;
