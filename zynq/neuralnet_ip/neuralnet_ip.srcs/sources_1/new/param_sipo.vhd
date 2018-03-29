library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.helperpkg.all;

-- serial in, parallel out parameter feeder that converts
-- the output from a row-major l2 cache to column major 
entity param_sipo is
generic (
    nrows: integer := 10
);
port (
    clk:       in std_logic;
    alrst:     in std_logic;
    datain:    in std_logic_vector (15 downto 0);
    validin:   in std_logic;
    arrayout: out wordarr_t (nrows - 1 downto 0);
    validout: out std_logic_vector (nrows - 1 downto 0) 
);
end param_sipo;

architecture Behavioral of param_sipo is
-- main shift register
signal shift_register: wordarr_t (nrows - 2 downto 0);
-- row count, global valid flag
signal row_count     : integer range nrows - 1 downto 0;
signal all_rows_valid: std_logic;

begin
-- output wiring
arrayout (nrows - 2 downto 0) <= shift_register;
arrayout (nrows - 1)          <= datain;
validout <= (others => '1') when all_rows_valid = '1' else (others => '0');

-- count the number of rows that are ready
rowcountproc:
process (clk, alrst) is
begin
    if (rising_edge (clk)) then
        if (alrst = '0') then
            row_count <= 0;
        elsif (validin = '1') then
            row_count <= (row_count + 1) mod nrows;
        end if;
    end if;
end process;

-- main shift register process
shiftproc:
process (clk, alrst) is
begin
    if (rising_edge (clk)) then
        if (alrst = '0') then
            for I in nrows - 2 downto 0 loop
                shift_register (I) <= (others => '0');
            end loop;
        else
            for I in nrows - 3 downto 0 loop
                shift_register (I) <= shift_register (I + 1);
            end loop;
            shift_register (nrows - 2) <= datain;
        end if;
    end if;
end process;

all_rows_valid <= '1' when (row_count = nrows - 1) else '0';

end Behavioral;
