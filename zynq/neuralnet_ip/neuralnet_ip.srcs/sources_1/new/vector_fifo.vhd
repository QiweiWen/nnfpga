library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use work.helperpkg.all;

-- a wrapper over the raw 16 x N FIFO memory
-- for holding vector products
entity vector_fifo is
generic (nvecs: integer := 100; veclen: integer := 50);
port(
    clk:            in std_logic;
    alrst:          in std_logic;
    wren:           in std_logic;
    rden:           in std_logic;
    datain:         in std_logic_vector (15 downto 0);
    dataout:        out std_logic_vector (15 downto 0);
    vector_empty:   out std_logic;
    vector_full:    out std_logic
);
end vector_fifo;

architecture Behavioral of vector_fifo is
component std_fifo is
generic (
    constant data_width  : positive := 8;
    constant fifo_depth	: positive := 256
);
port ( 
    clk		: in  std_logic;
    rst		: in  std_logic;
    writeen	: in  std_logic;
    datain	: in  std_logic_vector (data_width - 1 downto 0);
    readen	: in  std_logic;
    dataout	: out std_logic_vector (data_width - 1 downto 0);
    empty	: out std_logic;
    full	: out std_logic
);
end component std_fifo;

-- underlying fifo unit full and empty logic
signal fifo_empty: std_logic;
signal fifo_full:  std_logic;

-- how many vector elements in the current vector we have received
signal nelems_wr: integer range veclen - 1 downto 0;
-- how many vector elements we have clocked out
signal nelems_rd: integer range veclen - 1 downto 0;
-- how many vectors we now hold
signal nvectors : integer range nvecs downto 0;
-- whether we should increment or decrement vector count
signal nvectors_increment: std_logic;
signal nvectors_decrement: std_logic;

begin

-- standard fifo port map
underlying_fifo: std_fifo
generic map (
    data_width => 16,
    fifo_depth => nvecs * veclen
)
port map(
    clk => clk,
    rst => alrst,
    writeen => wren,
    datain => datain,
    readen => rden,
    dataout => dataout,
    empty => fifo_empty,
    full => fifo_full
);

-- element count logic
elem_count_proc:
process (clk, alrst) is
begin
    if (rising_edge (clk)) then
        if (alrst = '0') then
            nelems_rd <= 0;
            nelems_wr <= 0;
        else
            if (wren = '1' and fifo_full = '0') then 
                nelems_wr <= (nelems_wr + 1) mod (veclen);
            end if;

            if (rden = '1' and fifo_empty = '0') then
                nelems_rd <= (nelems_rd + 1) mod (veclen);
            end if;
        end if;
    end if;
end process;

--vector count process
nvectors_increment <= '1' when nelems_wr = veclen - 1 and wren = '1' else '0'; 
nvectors_decrement <= '1' when nelems_rd = veclen - 1 and rden = '1' else '0'; 
process (clk, alrst) is
begin
    if (rising_edge(clk)) then
        if (alrst = '0') then
            nvectors <= 0;
        else
            if (nvectors_increment = '1' and nvectors_decrement = '0') then
                nvectors <= (nvectors + 1) mod (nvecs + 1);
            elsif (nvectors_decrement = '1') then
                nvectors <= (nvectors - 1) mod (nvecs + 1);
            end if;
        end if;
    end if;
end process;

vector_empty <= '1' when (fifo_empty = '1' or nvectors = 0) else '0';
vector_full  <= '1' when (fifo_full  = '1' or nvectors = nvecs) else '0'; 

end Behavioral;
