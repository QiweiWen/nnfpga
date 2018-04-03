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
    empty => vector_empty,
    full => vector_full
);

end Behavioral;
