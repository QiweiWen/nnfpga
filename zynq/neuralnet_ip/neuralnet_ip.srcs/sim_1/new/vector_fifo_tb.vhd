-- Testbench automatically generated online
-- at http://vhdl.lapinoo.net
-- Generation date : 3.4.2018 02:26:55 GMT

library ieee;
use ieee.std_logic_1164.all;

library ieee_proposed;
use ieee_proposed.fixed_pkg.all;
use work.helperpkg.all;

use ieee.math_real.all;

entity tb_vector_fifo is
end tb_vector_fifo;

architecture tb of tb_vector_fifo is
    component vector_fifo
        generic (nvecs: integer := 100; veclen: integer := 50);
        port (clk          : in std_logic;
              alrst        : in std_logic;
              wren         : in std_logic;
              rden         : in std_logic;
              datain       : in std_logic_vector (15 downto 0);
              dataout      : out std_logic_vector (15 downto 0);
              vector_empty : out std_logic;
              vector_full  : out std_logic);
    end component;
    
    constant nvecs: integer := 5;
    constant veclen: integer := 3;
    signal clk          : std_logic;
    signal alrst        : std_logic;
    signal wren         : std_logic;
    signal rden         : std_logic;
    signal datain       : std_logic_vector (15 downto 0);
    signal dataout      : std_logic_vector (15 downto 0);
    signal vector_empty : std_logic;
    signal vector_full  : std_logic;

    constant TbPeriod : time := 100 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';
    subtype param_type is std_logic_vector (15 downto 0);

begin

    dut : vector_fifo
    generic map (nvecs => nvecs, veclen => veclen)
    port map (clk          => clk,
              alrst        => alrst,
              wren         => wren,
              rden         => rden,
              datain       => datain,
              dataout      => dataout,
              vector_empty => vector_empty,
              vector_full  => vector_full);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
    procedure put_element (
        constant val: real
    )is
    begin
        datain <= param_type(to_sfixed(val, PARAM_DEC - 1, -PARAM_FRC));
        wait for 100 ns;
    end procedure;
    begin
        -- EDIT Adapt initialization as needed
        wren <= '0';
        rden <= '0';
        datain <= (others => '0');

        -- Reset generation
        -- EDIT: Check that alrst is really your reset signal
        alrst <= '0';
        wait for 100 ns;
        alrst <= '1';
        wait for 100 ns;
        wren <= '1';
        -- full and empty signal test
        for I in 0 to 14 loop
            put_element (1.0*real(I + 1));
        end loop;
        wren <= '0';
        rden <= '1';
        for I in 0 to 14 loop
            wait for 100 ns;
        end loop;
        rden <= '0';

        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_vector_fifo of tb_vector_fifo is
    for tb
    end for;
end cfg_tb_vector_fifo;
