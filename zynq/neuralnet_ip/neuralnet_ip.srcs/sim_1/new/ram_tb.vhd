-- Testbench automatically generated online
-- at http://vhdl.lapinoo.net
-- Generation date : 27.4.2018 00:54:00 GMT

library ieee;
use ieee.std_logic_1164.all;

use ieee.numeric_std.all;

entity tb_ram_wrapper is
end tb_ram_wrapper;

architecture tb of tb_ram_wrapper is

    component ram_wrapper
        generic (
            depth: integer := 128
        );
        port (clk      : in std_logic;
              alrst    : in std_logic;
              update   : in std_logic;
              write    : in std_logic;
              rden_a   : in std_logic;
              rdaddr_a : in integer;
              dout_a   : out std_logic_vector (15 downto 0);
              vout_a   : out std_logic;
              rden_b   : in std_logic;
              rdaddr_b : in integer;
              dout_b   : out std_logic_vector (15 downto 0);
              vout_b   : out std_logic;
              vin_c    : in std_logic;
              din_c    : in std_logic_vector (15 downto 0);
              wraddr_c : in integer;
              ack_c    : out std_logic);
    end component;

    signal clk      : std_logic;
    signal alrst    : std_logic;
    signal update   : std_logic;
    signal write    : std_logic;
    signal rden_a   : std_logic;
    signal rdaddr_a : integer;
    signal dout_a   : std_logic_vector (15 downto 0);
    signal vout_a   : std_logic;
    signal rden_b   : std_logic;
    signal rdaddr_b : integer;
    signal dout_b   : std_logic_vector (15 downto 0);
    signal vout_b   : std_logic;
    signal vin_c    : std_logic;
    signal din_c    : std_logic_vector (15 downto 0);
    signal wraddr_c : integer;
    signal ack_c    : std_logic;

    constant TbPeriod : time := 100 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';
    constant depth : integer := 10;

    signal debug_latch_A: std_logic_vector (15 downto 0);
    signal debug_latch_B: std_logic_vector (15 downto 0);

begin

    debug_proc:
    process (clk, alrst) is
    begin
        if (rising_edge(clk)) then
            if (vout_a = '1') then
                debug_latch_A <= dout_a;
            end if;
            if (vout_b = '1') then
                debug_latch_B <= dout_b;
            end if;
        end if;
    end process;

    dut : ram_wrapper
    generic map (depth => depth)
    port map (clk      => clk,
              alrst    => alrst,
              update   => update,
              write    => write,
              rden_a   => rden_a,
              rdaddr_a => rdaddr_a,
              dout_a   => dout_a,
              vout_a   => vout_a,
              rden_b   => rden_b,
              rdaddr_b => rdaddr_b,
              dout_b   => dout_b,
              vout_b   => vout_b,
              vin_c    => vin_c,
              din_c    => din_c,
              wraddr_c => wraddr_c,
              ack_c    => ack_c);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        update <= '0';
        write  <= '0';
        rden_a <= '0';
        rdaddr_a <= 0;
        rden_b <= '0';
        rdaddr_b <= 0;
        vin_c <= '0';
        din_c <= (others => '0');
        wraddr_c <= 0;

        -- Reset generation
        -- EDIT: Check that alrst is really your reset signal
        alrst <= '0';
        wait for 100 ns;
        alrst <= '1';
        wait for 100 ns;
        
        -- initial value
        update <= '0';
        write <= '1';
        vin_c <= '1';
        for i in 0 to depth - 1 loop
            wraddr_c <= i;
            din_c <= std_logic_vector(to_unsigned(i, 16)); 
            wait for 100 ns;
        end loop;

        vin_c <= '0';
        write <= '0';
        -- read back
        rden_a   <= '1';
        rden_b   <= '1';
        for i in 0 to depth - 1 loop
            rdaddr_a <= i;
            rdaddr_b <= depth - 1 - i;
            wait for 100 ns;
        end loop;
        rden_a   <= '0';
        rden_b   <= '0';

        -- add 5
        update <= '1';
        vin_c  <= '1';
        for i in 0 to depth - 1 loop
            wraddr_c <= i;
            din_c    <= X"0005";
            wait for 100 ns;
        end loop;

        update <= '0';
        vin_c  <= '0';
        wait for 100 ns;
        
        -- read back
        rden_a   <= '1';
        rden_b   <= '1';
        for i in 0 to depth - 1 loop
            rdaddr_a <= i;
            rdaddr_b <= depth - 1 - i;
            wait for 100 ns;
        end loop;
        rden_a   <= '0';
        rden_b   <= '0';

        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_ram_wrapper of tb_ram_wrapper is
    for tb
    end for;
end cfg_tb_ram_wrapper;
