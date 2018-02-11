
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.math_real.all;
use ieee.numeric_std.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity l2_cache_weight is
    generic (
        nrows: integer := 10;
        ncols: integer := 10
    );
    port (
        clk: in std_logic;
        alrst: in std_logic;
        -- port B, 64 bits
        datain_B: in std_logic_vector (63 downto 0);
        dataout_B: out std_logic_vector (63 downto 0);
        flushout: in std_logic;
        streamin: in std_logic;
        validout_B: out std_logic;
        -- port A, 16 bits
        datain_A: in std_logic_vector (15 downto 0);
        we_A: in std_logic;
        re_A: in std_logic;
        dataout_A: out std_logic_vector (15 downto 0);
        row_A: in integer range nrows - 1 downto 0;
        col_A: in integer range ncols - 1 downto 0;
        validout_A: out std_logic
    );
end l2_cache_weight;

architecture Behavioral of l2_cache_weight is

component l2_cache is
    generic (
        nrows: integer := 10;
        ncols: integer := 10
    );
    port (
        clk: in std_logic;
        alrst: in std_logic;
        -- port B, 64 bits
        datain_B: in std_logic_vector (63 downto 0);
        dataout_B: out std_logic_vector (63 downto 0);
        flushout: in std_logic;
        streamin: in std_logic;
        validout_B: out std_logic;
        -- port A, 16 bits
        datain_A: in std_logic_vector (15 downto 0);
        we_A: in std_logic;
        re_A: in std_logic;
        dataout_A: out std_logic_vector (15 downto 0);
        row_A: in integer range nrows - 1 downto 0;
        col_A: in integer range ncols - 1 downto 0;
        validout_A: out std_logic
    );
end component l2_cache;

begin

    wrapped : l2_cache
    generic map (nrows => nrows, ncols => ncols)
    port map (clk        => clk,
              alrst      => alrst,
              datain_B   => datain_B,
              dataout_B  => dataout_B,
              flushout   => flushout,
              streamin   => streamin,
              validout_B => validout_B,
              datain_A   => datain_A,
              we_A       => we_A,
              re_A       => re_A,
              dataout_A  => dataout_A,
              row_A      => row_A,
              col_A      => col_A,
              validout_A => validout_A);

end Behavioral;
