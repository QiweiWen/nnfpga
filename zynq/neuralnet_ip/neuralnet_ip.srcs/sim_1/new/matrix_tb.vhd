-- Testbench automatically generated online
-- at http://vhdl.lapinoo.net
-- Generation date : 18.3.2018 20:33:31 GMT

library ieee;
use ieee.std_logic_1164.all;

library ieee_proposed;
use ieee_proposed.fixed_pkg.all;
use work.helperpkg.all;

use ieee.math_real.all;


entity tb_matrix is
end tb_matrix;

architecture tb of tb_matrix is
    constant ncols: integer := 3; 
    constant nrows: integer := 4;

    component matrix
        generic (ncols: integer := 400;
                 nrows: integer := 100);
        port (clk            : in std_logic;
              alrst          : in std_logic;
              datain_weight  : in std_logic_vector (15 downto 0);
              validin_weight : in std_logic;
              datain_vector  : in std_logic_vector (15 downto 0);
              validin_vector : in std_logic;
              arrayout       : out wordarr_t (nrows - 1 downto 0);
              validout       : out std_logic_vector (nrows - 1 downto 0);
              finished       : out std_logic);
    end component;

    signal clk            : std_logic;
    signal alrst          : std_logic;
    signal datain_weight  : std_logic_vector (15 downto 0);
    signal validin_weight : std_logic;
    signal datain_vector  : std_logic_vector (15 downto 0);
    signal validin_vector : std_logic;
    signal arrayout       : wordarr_t (nrows - 1 downto 0);
    signal validout       : std_logic_vector (nrows - 1 downto 0);
    signal finished       : std_logic;

    type   realarr is array (nrows - 1 downto 0) of real;
    signal arrayout_real : realarr;

    constant TbPeriod : time := 100 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

    subtype param_type is std_logic_vector (15 downto 0);
begin
    
realgen:
    for I in nrows - 1 downto 0 generate
        arrayout_real(I) <= to_real (to_sfixed(arrayout(I), PARAM_DEC - 1, -PARAM_FRC)); 
    end generate;

    dut : matrix
    generic map (ncols => ncols, nrows => nrows)
    port map (clk            => clk,
              alrst          => alrst,
              datain_weight  => datain_weight,
              validin_weight => validin_weight,
              datain_vector  => datain_vector,
              validin_vector => validin_vector,
              arrayout       => arrayout,
              validout       => validout,
              finished       => finished);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
    procedure put_weight (
        constant val: real
    )is
    begin
        datain_weight <= param_type(to_sfixed(val, PARAM_DEC - 1, -PARAM_FRC));
        wait for 100 ns; 
    end procedure;

    procedure put_vector_element (
        constant val: real
    )is
    begin
        datain_vector <= param_type(to_sfixed(val, PARAM_DEC - 1, -PARAM_FRC));
        wait for 100 ns; 
    end procedure;
    begin
        -- EDIT Adapt initialization as needed
        datain_weight <= (others => '0');
        validin_weight <= '0';
        datain_vector <= (others => '0');
        validin_vector <= '0';

        -- Reset generation
        -- EDIT: Check that alrst is really your reset signal
        alrst <= '0';
        wait for 100 ns;
        alrst <= '1';
        wait for 100 ns;
        -- 1 2 3 * (7 6 5)
        -- 4 5 6
        -- 5 6 7
        -- 6 7 8
        -- EDIT Add stimuli here
        validin_weight <= '1';
        put_weight (6.0);
        put_weight (7.0);
        put_weight (8.0);
        put_weight (5.0);
        put_weight (6.0);
        put_weight (7.0);
        put_weight (4.0);
        put_weight (5.0);
        put_weight (6.0);
        put_weight (1.0);
        put_weight (2.0);
        put_weight (3.0);
        validin_weight <= '0';
        validin_vector <= '1';
        put_vector_element (5.0);
        put_vector_element (6.0);
        put_vector_element (7.0);
        validin_vector <= '0';
        wait for 1000 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_matrix of tb_matrix is
    for tb
    end for;
end cfg_tb_matrix;
