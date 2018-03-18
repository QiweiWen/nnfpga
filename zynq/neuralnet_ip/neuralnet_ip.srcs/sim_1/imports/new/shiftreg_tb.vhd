-- Testbench automatically generated online
-- at http://vhdl.lapinoo.net
-- Generation date : 30.1.2018 10:54:03 GMT

library ieee;
use ieee.std_logic_1164.all;
use work.helperpkg.all;


entity tb_vector_shifter is
end tb_vector_shifter;

architecture tb of tb_vector_shifter is
    
    constant nrows : integer := 5;
    
    component vector_shifter
        generic(
            nrows: integer
        );
        port (
            clk: in std_logic;
            alrst: in std_logic;
            array_in: in wordarr_t (nrows - 1 downto 0);
            valid_in: in std_logic_vector (nrows - 1 downto 0); 
            valid_out_sigmoid: out std_logic;
            activated_out: out std_logic_vector (15 downto 0);
            valid_out_unactivated: out std_logic;
            unactivated_out: out std_logic_vector (15 downto 0)
        );
    end component;

    signal clk             : std_logic;
    signal alrst           : std_logic;
    signal array_in        : wordarr_t (nrows - 1 downto 0);
    signal valid_in        : std_logic_vector (nrows - 1 downto 0);
    signal valid_out_sigmoid       : std_logic;
    signal activated_out   : std_logic_vector (15 downto 0);
    signal valid_out_unactivated: std_logic;
    signal unactivated_out : std_logic_vector (15 downto 0);

    constant TbPeriod : time := 100 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : vector_shifter
    generic map (
        nrows => nrows
    )
    port map (clk             => clk,
              alrst           => alrst,
              array_in        => array_in,
              valid_in        => valid_in,
              valid_out_sigmoid => valid_out_sigmoid,
              activated_out => activated_out,
              valid_out_unactivated => valid_out_unactivated,
              unactivated_out => unactivated_out);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process is
    procedure put_element  (
        constant index: integer;
        stuff: in std_logic_vector (15 downto 0)
    ) is
    begin
        for I in 0 to nrows - 1 loop
            valid_in (I) <= '0';
        end loop;
        valid_in (index) <= '1';
        array_in (index) <= stuff;
    end procedure;

    begin
        -- EDIT Adapt initialization as needed
        array_in <= (others => (others => '0'));
        valid_in <= (others => '0');

        -- Reset generation
        -- EDIT: Check that alrst is really your reset signal
        alrst <= '0';
        wait for 100 ns;
        alrst <= '1';
        wait for 100 ns;
        put_element (0, x"0001");
        wait for 100 ns;
        put_element (1, x"0002");
        wait for 100 ns;
        put_element (2, x"0003");
        wait for 100 ns;
        put_element (3, x"0004");
        wait for 100 ns;
        put_element (4, x"0005");
        wait for 100 ns;
        put_element (0, x"0005");
        wait for 100 ns;
        valid_in <= (others => '0');
        wait for 500 ns;
        put_element (1, x"0004");
        wait for 100 ns;
        put_element (2, x"0003");
        wait for 100 ns;
        put_element (3, x"0002");
        wait for 100 ns;
        put_element (4, x"0001");
        wait for 100 ns;
        valid_in <= (others => '0');
        -- EDIT Add stimuli here
        wait for 100 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_vector_shifter of tb_vector_shifter is
    for tb
    end for;
end cfg_tb_vector_shifter;
