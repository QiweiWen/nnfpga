-- Testbench automatically generated online
-- at http://vhdl.lapinoo.net
-- Generation date : 6.5.2018 09:14:23 GMT

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


library ieee_proposed;
use ieee_proposed.fixed_pkg.all;

use ieee.math_real.all;


use work.helperpkg.all;

entity tb_multadd is
end tb_multadd;

architecture tb of tb_multadd is

    component multadd
        port (A : in std_logic_vector (15 downto 0);
              B : in std_logic_vector (15 downto 0);
              C : in std_logic_vector (15 downto 0);
              P : out std_logic_vector (15 downto 0));
    end component;

    signal A : std_logic_vector (15 downto 0);
    signal B : std_logic_vector (15 downto 0);
    signal C : std_logic_vector (15 downto 0);
    signal P : std_logic_vector (15 downto 0);

    subtype param_type is std_logic_vector (15 downto 0);
    
    signal P_real: real;

begin

    P_real <= to_real (to_sfixed (P, PARAM_DEC - 1, -PARAM_FRC));

    dut : multadd
    port map (A => A,
              B => B,
              C => C,
              P => P);

    stimuli : process
    procedure do_mult_add (
        constant a_real: real;
        constant b_real: real;
        constant c_real: real
    )is
    begin
        A <= param_type(to_sfixed (a_real, PARAM_DEC - 1, -PARAM_FRC));  
        B <= param_type(to_sfixed (b_real, PARAM_DEC - 1, -PARAM_FRC));  
        C <= param_type(to_sfixed (c_real, PARAM_DEC - 1, -PARAM_FRC));  
        wait for 100 ns;
    end procedure;
    begin
        -- trivial test
        do_mult_add (4.0, 2.0, 3.0);
        do_mult_add (5.0, 6.0, 12.5);
        do_mult_add (-5.0, 1.0, 7.3);
        do_mult_add (-5.0, -1.0, 7.3);


        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_multadd of tb_multadd is
    for tb
    end for;
end cfg_tb_multadd;
