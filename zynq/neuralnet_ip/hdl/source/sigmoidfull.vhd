library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
library ieee_proposed;
use work.fixed_pkg.all;

use work.helperpkg.all;

entity sigmoidfull is
port (
    clk: in std_logic;
    rst: in std_logic;
    datain: in std_logic_vector (15 downto 0);
    validin: in std_logic;
    dataout: out std_logic_vector (15 downto 0);
    validout: out std_logic);
end sigmoidfull;

architecture Behavioral of sigmoidfull is

component sigmoid is
port (
    clk: in std_logic;
    rst: in std_logic;
    datain: in std_logic_vector (14 downto 0);
    validin: in std_logic;
    dataout: out std_logic_vector (14 downto 0);
    validout: out std_logic);
end component sigmoid;

signal inabsval: std_logic_vector (14 downto 0);
signal innegative: std_logic_vector (14 downto 0);

signal insign_delayed: std_logic;

signal sigmoid_vout: std_logic;
signal sigmoid_dout: std_logic_vector (15 downto 0);
signal sigmoid_compliment: std_logic_vector (15 downto 0);

signal dout_pipe: std_logic_vector (15 downto 0);

signal sfixed_one: std_logic_vector (15 downto 0); 

begin
    sfixed_one <= (PARAM_FRC => '1', others => '0');
    
    in_absval_proc: process (datain) is
        variable in_inverse: std_logic_vector(14 downto 0);
    begin
        in_inverse := not (datain(14 downto 0)); 
        innegative <= std_logic_vector (unsigned (in_inverse) + 1);
    end process;

    inabsval <= innegative when datain (15) = '1' else datain (14 downto 0);

    activate: sigmoid port map (
        clk => clk,
        rst => rst,
        datain => inabsval,
        validin => validin, 
        dataout => sigmoid_dout(14 downto 0),
        validout => sigmoid_vout
    );

    sigmoid_dout (15) <= '0';

    sigmoid_compliment <= std_logic_vector (unsigned (sfixed_one) -
                                            unsigned (sigmoid_dout));
    dout_pipe <= sigmoid_dout when insign_delayed = '0' else
                 sigmoid_compliment;
    
    outproc: process (clk, rst) is
    begin
        if (rising_edge(clk)) then
            if (rst = '0') then
                validout <= '0';
                dataout <= (others => '0');
                insign_delayed <= '0';
            else
                validout <= sigmoid_vout;
                dataout  <= dout_pipe;
                insign_delayed <= datain(15);
            end if;
        end if;
    end process;

end Behavioral;



