library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

library ieee_proposed;
use ieee_proposed.fixed_pkg.all;
use work.helperpkg.all;

use work.nn_arith_package.all;

entity multadd is
    port (A : in std_logic_vector (15 downto 0);
          B : in std_logic_vector (15 downto 0);
          C : in std_logic_vector (47 downto 0);
          P : out std_logic_vector (47 downto 0));
end multadd;

architecture Behavioral of multadd is
component xbip_multadd_0 IS
  PORT (
    A : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    B : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    C : IN STD_LOGIC_VECTOR(47 DOWNTO 0);
    SUBTRACT : IN STD_LOGIC;
    P : OUT STD_LOGIC_VECTOR(47 DOWNTO 0);
    PCOUT : OUT STD_LOGIC_VECTOR(47 DOWNTO 0)
  );
END component xbip_multadd_0;

signal full_sum: std_logic_vector (47 downto 0);

begin

xillinx_dsp_multadd: xbip_multadd_0
port map(
    A => A,
    B => B,
    C => C,
    subtract => '0',
    P => full_sum,
    pcout => open
);


--P <= fun_mul_truncate (full_sum);
P <= full_sum;

end Behavioral;
