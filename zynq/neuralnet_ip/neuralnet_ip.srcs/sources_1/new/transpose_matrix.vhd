-- transpose_matrix-vector product operation
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.helperpkg.all;

entity transpose_matrix is
generic (ncols: integer := 400;
         nrows: integer := 100);
port (
    clk: in std_logic;
    alrst: in std_logic;
-- transpose_matrix weight from l2 cache
    datain_weight: in std_logic_vector (15 downto 0);
    validin_weight: in std_logic;
-- input vector
    datain_vector: in std_logic_vector (15 downto 0);
    validin_vector: in std_logic;
-- parallel output
    arrayout: out wordarr_t (nrows - 1 downto 0);
    validout: out std_logic_vector (nrows - 1 downto 0);
-- this flags that an entire vector product has been computed
    finished: out std_logic
);
end transpose_matrix;

architecture Behavioral of transpose_matrix is

component row_processor is
generic (
    ncols: integer := 100
);
port(
    clk: in std_logic;
    alrst: in std_logic;
-- l1 cache external interface
    l1_streamin: in std_logic;
    l1_datain: in std_logic_vector (15 downto 0);
-- vector input channel
    ve_datain: in std_logic_vector (15 downto 0);
    ve_validin: in std_logic;
-- product terms output channel
    dataout: out std_logic_vector (15 downto 0);
    validout: out std_logic;
    -- this flags that all the products that
    -- will sum to a vector element have been computed
    finished: out std_logic; 
-- signals forwarded to the adjacent row processor down the line
    validfwd: out std_logic;
    datafwd: out std_logic_vector (15 downto 0)
);
end component row_processor;

component param_sipo is
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
end component param_sipo;

signal param_feed: wordarr_t (nrows - 1 downto 0);
signal param_valid: std_logic_vector (nrows - 1 downto 0);

signal ve_datain_array: wordarr_t (nrows - 1 downto 0);
signal ve_validin_array: std_logic_vector (nrows - 1 downto 0);
signal validfwd_array: std_logic_vector (nrows - 1 downto 0); 
signal datafwd_array: wordarr_t (nrows - 1 downto 0);
signal finished_array: std_logic_vector (nrows - 1 downto 0);

begin

feeder: param_sipo
generic map ( nrows => nrows)
port map (
    clk => clk,
    alrst => alrst,
    datain => datain_weight, 
    validin => validin_weight, 
    arrayout => param_feed,
    validout => param_valid
);

rows_gen:
for I in nrows - 1 downto 0 generate
    rpw: row_processor
    generic map (ncols => ncols)
    port map (
        clk => clk,
        alrst => alrst,
        l1_streamin => param_valid(I),
        l1_datain => param_feed(I), 
        ve_datain => ve_datain_array(I),
        ve_validin => ve_validin_array(I),
        dataout => arrayout(I), 
        validout => validout(I),
        finished => finished_array(I),
        validfwd => validfwd_array(I),
        datafwd => datafwd_array(I)
    );
end generate;

finished <= finished_array(nrows - 1);

wire_them_up:
for I in nrows - 1 downto 0 generate
    ve_datain_array(I) <= datain_vector when I = 0 else datafwd_array(I - 1); 
    ve_validin_array(I) <= validin_vector when I = 0 else validfwd_array(I - 1);
end generate;

end Behavioral;
