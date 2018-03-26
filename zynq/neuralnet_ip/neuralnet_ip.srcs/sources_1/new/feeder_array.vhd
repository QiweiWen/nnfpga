library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.helperpkg.all;

entity feeder_array is
generic (
    nrows: integer := 10;
    ncols: integer := 10
);
port (
    clk: in std_logic;
    alrst: in std_logic;
-- external interface from l2 cache
    datain: in std_logic_vector (15 downto 0);
    validin: in std_logic;
-- parameters fed into row processors
    dataout: out wordarr_t (nrows - 1 downto 0);
    validout: out std_logic_vector (nrows - 1 downto 0)
);
end feeder_array;

architecture Behavioral of feeder_array is

component param_feeder is
generic(
    ncols: integer := 10
);
port (
    clk: in std_logic;
    alrst: in std_logic;
-- input data, either from the last unit or
-- directly from L2 cache
    datain: in std_logic_vector (15 downto 0);
    validin: in std_logic;
-- data forwarded to the next row feeder
    datafwd: out std_logic_vector (15 downto 0);
    validfwd: out std_logic;
-- data passed to the row processor    
    dataout: out std_logic_vector (15 downto 0);
    validout: out std_logic;
-- flag passed to the last row feeder
    full : out std_logic;
-- flag passed from the next row feeder
    slave_full: in std_logic
);
end component param_feeder;

type datain_array_type is array (nrows - 1 downto 0) of   std_logic_vector (15 downto 0);
type datafwd_array_type is array (nrows - 1 downto 0) of   std_logic_vector (15 downto 0);

signal datain_array: datain_array_type;
signal datafwd_array: datafwd_array_type;
signal validin_array: std_logic_vector (nrows - 1 downto 0);
signal validfwd_array: std_logic_vector (nrows - 1 downto 0);
signal full_array: std_logic_vector (nrows - 1 downto 0);
signal slave_full_array: std_logic_vector (nrows - 1 downto 0);

begin

portmap_gen:
for I in nrows - 1 downto 0 generate
    feeder_portmap: param_feeder
    generic map (
        ncols => ncols
    )
    port map (
        clk => clk,
        alrst => alrst,
        datain => datain_array(I),
        validin => validin_array(I),
        datafwd => datafwd_array(I),
        validfwd => validfwd_array(I),
        dataout => dataout(I),
        validout => validout(I),
        full => full_array(I),
        slave_full => slave_full_array(I)
    ); 
end generate;

wire_them_up:
for I in nrows - 1 downto 0 generate
    datain_array(I) <= datain when I = nrows - 1 else datafwd_array (I + 1); 
    validin_array(I) <= validin when I = nrows - 1 else validfwd_array (I + 1);
    slave_full_array(I) <= '1' when I = 0 else full_array (I - 1);
end generate;

end Behavioral;
