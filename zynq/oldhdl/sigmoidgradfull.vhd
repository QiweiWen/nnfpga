
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.const_package.all;


entity sigmoidgradfull is
port (
    clk: in std_logic;
    datain: in std_logic_vector (PARAM_WIDTH - 1 downto 0);
    validin: in std_logic;
    dataout: 
        out std_logic_vector (PARAM_WIDTH - 1 downto 0);
    validout: out std_logic);
end sigmoidgradfull;

architecture Behavioral of sigmoidgradfull is

component sigmoidgrad is
port (
    clk: in std_logic;
    datain: in std_logic_vector (PARAM_WIDTH - 2 downto 0);
    validin: in std_logic;
    dataout: out std_logic_vector (PARAM_WIDTH - 2 downto 0);
    validout: out std_logic);
end component sigmoidgrad;

signal innegative: std_logic_vector
    (PARAM_WIDTH - 1 downto 0);
signal insign  : std_logic;
signal inabsval: std_logic_vector 
    (PARAM_WIDTH - 1 downto 0);

signal sigmoidgradout:
    std_logic_vector (PARAM_WIDTH - 2 downto 0);
begin

postitive_half:
sigmoidgrad port map
(
    clk => clk,
    datain => inabsval (PARAM_WIDTH - 2 downto 0),
    validin => validin,
    dataout => sigmoidgradout,
    validout => validout
);

insign <= datain (PARAM_WIDTH - 1);
innegative <= std_logic_vector
              (to_signed((-1* to_integer(signed(datain))),
                        innegative'length));
inabsval <= datain when insign = '0' else
            innegative;

dataout <= '0' & sigmoidgradout;

end Behavioral;
