library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.helperpkg.all;
use work.nn_arith_package.all;
library ieee_proposed;
use ieee_proposed.fixed_pkg.all;
use ieee.math_real.all;

entity bias_vector is
generic (nrows: integer := 100);
port (
    clk: in std_logic;
-- product vector from column vectors
    unbiased: in std_logic_vector (31 downto 0);
    vin:  in std_logic;
-- result with biased added
-- goes to sigmoid unit and fifos
    biased: out std_logic_vector (15 downto 0);
    vout: out std_logic;
-- bias update channel from delta fifo
    updated: in std_logic_vector (15 downto 0);
    uvin: in std_logic
);
end bias_vector;

architecture Behavioral of bias_vector is

component ram_wrapper is
generic (
    depth: integer := 128
);
port (
    clk                 : in std_logic;
    alrst               : in std_logic;
-- mode selection pins
-- both low = read
-- high = read-add-writeback
    update              : in std_logic;
-- high = channel c write-through to port a
    write               : in std_logic;
-- read channel a
    rden_a              : in std_logic;
    rdaddr_a            : in integer range 0 to depth - 1; 
    dout_a              : out std_logic_vector (15 downto 0);
    vout_a              : out std_logic;
-- read channel b
    rden_b              : in std_logic;
    rdaddr_b            : in integer range 0 to depth - 1;
    dout_b              : out std_logic_vector (15 downto 0);
    vout_b              : out std_logic;
-- update channel
    vin_c               : in std_logic; 
    din_c               : in std_logic_vector (15 downto 0);
    wraddr_c            : in integer range 0 to depth - 1;
    ack_c               : out std_logic
);
end component ram_wrapper;

signal unbiased_truncated: std_logic_vector (15 downto 0);
signal unbiased_delayed: std_logic_vector (15 downto 0);

signal vin_pipe: std_logic;
signal vin_align: std_logic;

signal biased_full: std_logic_vector (16 downto 0);
signal dout_a : std_logic_vector (15 downto 0);

begin

unbiased_align: process (clk, alrst) is
    begin
        if (rising_edge(clk)) then
            if (alrst = '0') then
                unbiased_truncated <= (others => '0');
                unbiased_delayed <= (others => '0');
            else
                unbiased_truncated <= fun_mul_truncate (unbiased); 
                unbiased_delayed <= unbiased_truncated;
            end if;
        end if;
    end process;

validout_align: process (clk, alrst) is
    begin
        if (rising_edge(clk)) then
            if (alrst = '0') then
                vin_pipe <= '0';
                vin_align <= '0';
            else
                vin_pipe <= vin;
                vin_align <= vin_pipe;
            end if;
        end if;
    end process;

biased_full <= fun_safe_sum (unbiased_delayed, dout_a);
vout <= vin_align;

memory: ram_wrapper
generic map (depth => nrows)
port map (
    clk => clk,
    alrst => alrst,
    update => uvin,
    write => '0',
    rden_a => vin,
    rdaddr_a => open, -- TODO: add row pointer logic 
    dout_a => dout_a,
    vout_a => open,
    rden_b => '0',
    rdaddr_b => 0,
    dout_b => open,
    vout_b => open,
    vin_c => uvin,
    din_c => updated,
    wraddr_c => open, -- TODO: add write row poitner logic
    ack_c => open
);

end Behavioral;
