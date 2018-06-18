library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.helperpkg.all;
use work.nn_arith_package.all;
library ieee_proposed;
use ieee_proposed.fixed_pkg.all;

entity tb_derivative_processor is
end tb_derivative_processor;

architecture tb of tb_derivative_processor is
    
    constant width: integer := 5;
    
    component derivative_processor
        generic (width: integer := 5);
        port (clk      : in std_logic;
              alrst    : in std_logic;
              p_din    : in std_logic_vector (15 downto 0);
              p_vin    : in std_logic;
              p_ren    : out std_logic;
              s_din    : in std_logic_vector (15 downto 0);
              s_vin    : in std_logic;
              s_ren    : out std_logic;
              s_dfwd   : out std_logic_vector (15 downto 0);
              s_vfwd   : out std_logic;
              dataout  : out std_logic_vector (15 downto 0);
              validout : out std_logic);
    end component;

    signal clk      : std_logic;
    signal alrst    : std_logic;
    signal p_din    : std_logic_vector (15 downto 0);
    signal p_vin    : std_logic;
    signal p_ren    : std_logic;
    signal s_din    : std_logic_vector (15 downto 0);
    signal s_vin    : std_logic;
    signal s_ren    : std_logic;
    signal s_dfwd   : std_logic_vector (15 downto 0);
    signal s_vfwd   : std_logic;
    signal dataout  : std_logic_vector (15 downto 0);
    signal validout : std_logic;

    constant TbPeriod : time := 100 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';
    
    signal starve_p: std_logic := '0';
    signal starve_s: std_logic := '0';

    signal next_p: real := 0.0;
    signal next_s: real := 0.0;
    
    subtype param_type is std_logic_vector (15 downto 0);
    
    signal latched_product: real := -42.0;

begin
    
    debug_proc:
    process (clk, alrst) is
    begin
        if (rising_edge(clk)) then
            if (alrst = '0') then
                latched_product <= -42.0;
            elsif (validout = '1') then
                latched_product <= to_real (to_sfixed (dataout, PARAM_DEC - 1, -PARAM_FRC));
            end if;
        end if;
    end process;

    sp_feed_proc:
    process (clk, alrst) is
    begin
        if (rising_edge(clk)) then
            if (alrst = '0') then
                p_din <= (others => '0');
                p_vin <= '0';
                s_din <= (others => '0');
                s_vin <= '0';
            else
                p_din <= param_type (to_sfixed (next_p, PARAM_DEC - 1, -PARAM_FRC));
                s_din <= param_type (to_sfixed (next_s, PARAM_DEC - 1, -PARAM_FRC));
                if (p_ren = '1' and starve_p = '0') then
                    p_vin <= '1';
                else
                    p_vin <= '0';
                end if;

                if (s_ren = '1' and starve_s = '0') then
                    s_vin <= '1';
                else
                    s_vin <= '0';
                end if;

            end if;
        end if;
    end process;

    dut : derivative_processor
    generic map (width => width)
    port map (clk      => clk,
              alrst    => alrst,
              p_din    => p_din,
              p_vin    => p_vin,
              p_ren    => p_ren,
              s_din    => s_din,
              s_vin    => s_vin,
              s_ren    => s_ren,
              s_dfwd   => s_dfwd,
              s_vfwd   => s_vfwd,
              dataout  => dataout,
              validout => validout);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
    begin
        -- Reset generation
        -- EDIT: Check that alrst is really your reset signal
        alrst <= '0';
        wait for 100 ns;
        alrst <= '1';
        -- no starvation
        -- move p in the loop to produce a surfeit of p
        -- verify that only 1.5 is used
        for i in 0 to width - 1 loop
            next_p <= real(i + 1) * 1.5;
            next_s <= real(i);
            wait for 100 ns;
        end loop;

        -- starved on serial input side
        alrst <= '0';
        wait for 100 ns;
        alrst <= '1';

        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_derivative_processor of tb_derivative_processor is
    for tb
    end for;
end cfg_tb_derivative_processor;
