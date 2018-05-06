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
          C : in std_logic_vector (15 downto 0);
          P : out std_logic_vector (15 downto 0));
end multadd;

architecture Behavioral of multadd is
component xbip_multadd_0 IS
  PORT (
    A : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    B : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    C : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    SUBTRACT : IN STD_LOGIC;
    P : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
    PCOUT : OUT STD_LOGIC_VECTOR(47 DOWNTO 0)
  );
END component xbip_multadd_0;

signal c_sign_extend: std_logic_vector (31 downto 0);
signal full_sum: std_logic_vector (47 downto 0);

signal sign_extend_bits: std_logic_vector (PARAM_DEC - 1 downto 0);
signal dummy_bits: std_logic_vector (PARAM_FRC - 1 downto 0);

begin

sign_extend_bits <= (others => '1') when C(15) = '1' else
                    (others => '0');
dummy_bits <= (others => '0');
c_sign_extend <= sign_extend_bits & C & dummy_bits; 

xillinx_dsp_multadd: xbip_multadd_0
port map(
    A => A,
    B => B,
    C => c_sign_extend,
    subtract => '0',
    P => open,
    pcout => full_sum
);

--these are the bits of interest
--P <= full_sum (23 downto 8);

P <= fun_mul_truncate (full_sum);

end Behavioral;
