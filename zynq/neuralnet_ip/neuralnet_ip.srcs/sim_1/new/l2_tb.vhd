-- Testbench automatically generated online
-- at http://vhdl.lapinoo.net
-- Generation date : 26.1.2018 12:30:53 GMT

library ieee;
use ieee.std_logic_1164.all;

entity tb_l2_cache_weight is
end tb_l2_cache_weight;

architecture tb of tb_l2_cache_weight is

    component l2_cache_weight
        port (clk        : in std_logic;
              alrst      : in std_logic;
              datain_B   : in std_logic_vector (63 downto 0);
              dataout_B  : out std_logic_vector (63 downto 0);
              flushout   : in std_logic;
              streamin   : in std_logic;
              validout_B : out std_logic;
              datain_A   : in std_logic_vector (15 downto 0);
              we_A       : in std_logic;
              re_A       : in std_logic;
              dataout_A  : out std_logic_vector (15 downto 0);
              row_A      : in integer;
              col_A      : in integer;
              validout_A : out std_logic);
    end component;

    signal clk        : std_logic;
    signal alrst      : std_logic;
    signal datain_B   : std_logic_vector (63 downto 0);
    signal dataout_B  : std_logic_vector (63 downto 0);
    signal flushout   : std_logic;
    signal streamin   : std_logic;
    signal validout_B : std_logic;
    signal datain_A   : std_logic_vector (15 downto 0);
    signal we_A       : std_logic;
    signal re_A       : std_logic;
    signal dataout_A  : std_logic_vector (15 downto 0);
    signal row_A      : integer;
    signal col_A      : integer;
    signal validout_A : std_logic;

    constant TbPeriod : time := 100 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

    --debug signals
    signal latched_A: std_logic_vector (15 downto 0);
    signal latched_B: std_logic_vector (63 downto 0);

begin

    debug_proc:
    process (clk, alrst) is
    begin
        if (rising_edge(clk)) then
            if (alrst = '0') then
                latched_A <= (others => '0');
                latched_B <= (others => '0');
            else
                if (validout_A = '1') then
                    latched_A <= dataout_A;
                end if;

                if (validout_B = '1') then
                    latched_B <= dataout_B;
                end if;
            end if;
        end if;
    end process;

    dut : l2_cache_weight
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

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        datain_B <= (others => '0');
        flushout <= '0';
        streamin <= '0';
        datain_A <= (others => '0');
        we_A <= '0';
        re_A <= '0';
        row_A <= 0;
        col_A <= 0;

        -- Reset generation
        -- EDIT: Check that alrst is really your reset signal
        alrst <= '0';
        wait for 100 ns;
        alrst <= '1';
        wait for 100 ns;
        streamin <= '1';
        datain_B <= X"deadbeefaaaabbbb";
        wait for 100 ns;
        datain_B <= X"ccccddddeeeeffff";
        wait for 100 ns;
        streamin <= '0';
        flushout <= '1';
        wait for 500 ns;
        flushout <= '0';
        re_A <= '1';
        row_A <= 0;
        col_A <= 5;
        wait for 100 ns;
        row_A <= 0;
        col_A <= 3;
        wait for 100 ns;
        re_A <= '0';
        we_A <= '1';
        datain_A <= X"abcd";
        wait for 100 ns;
        we_A <= '0';
        

        -- EDIT Add stimuli here
        wait for 100 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_l2_cache_weight of tb_l2_cache_weight is
    for tb
    end for;
end cfg_tb_l2_cache_weight;
