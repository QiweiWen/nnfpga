library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.helperpkg.all;
use work.nn_arith_package.all;
library ieee_proposed;
use work.fixed_pkg.all;

entity cached_fifo is
generic
(
    fifo_depth : natural := 128
);
port
(
    clk     : in std_logic;
    alrst   : in std_logic; 
    writeen	: in  std_logic;
    datain	: in  std_logic_vector (15 downto 0);
    readen	: in  std_logic;
    dataout	: out std_logic_vector (15 downto 0);
    validout: out std_logic;
    empty	: out std_logic;
    full	: out std_logic
);
end cached_fifo;

architecture behavioural of cached_fifo is

component fifo_cache is
generic
(
    fifo_depth: natural := 128
);
port
(
    clk:        in std_logic;
    alrst:      in std_logic;
    cache_empty:out std_logic;
    rden:       in std_logic;
    rdata:      out std_logic_vector(15 downto 0);
    vout:       out std_logic;
    fifo_empty: in std_logic;
    fifo_rden:   out std_logic;
    fifo_rdata:  in std_logic_vector(15 downto 0);
    fifo_vin  :  in std_logic
);
end component fifo_cache;

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
        validout: out std_logic;
        empty	: out std_logic;
        full	: out std_logic
    );
end component std_fifo;

signal uncached_empty: std_logic;
signal uncached_rden: std_logic;
signal uncached_rdata: std_logic_vector(15 downto 0);
signal uncached_vin : std_logic;

begin

cache_inst: fifo_cache
generic map (fifo_depth => fifo_depth)
port map
(
    clk         => clk,
    alrst       => alrst,
    cache_empty => empty,
    rden        => readen,
    rdata       => dataout,
    vout        => validout,
    fifo_empty  => uncached_empty,
    fifo_rden   => uncached_rden,
    fifo_rdata  => uncached_rdata,
    fifo_vin    => uncached_vin 
);

fifo_inst: std_fifo
generic map (data_width => 16, fifo_depth => fifo_depth)
port map
(
    clk         => clk,
    rst         => alrst,
    writeen     => writeen,
    datain      => datain,
    readen      => uncached_rden,
    dataout     => uncached_rdata,
    validout    => uncached_vin,
    empty       => uncached_empty,
    full        => full
);

end behavioural; 
