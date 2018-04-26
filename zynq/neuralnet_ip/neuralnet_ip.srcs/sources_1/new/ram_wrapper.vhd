-- wrapper over true dual port ram
-- modes of operation:
-- 1. read mode
--    Both ports used for reading
--
-- 2. update mode
--    One port used for reading, the other port used for writing modified
--    data

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.helperpkg.all;
use work.nn_arith_package.all;

entity ram_wrapper is
generic (
    depth: integer := 128
);
port (
    clk                 : in std_logic;
    alrst               : in std_logic;
-- mode selection pin
-- low = read, high = update
    update              : in std_logic;
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
end ram_wrapper;

architecture Behavioral of ram_wrapper is

-- underlying ram module
component true_dpram_sclk is
    generic (
        width: integer := 16;
        depth: integer := 128
    );
    port 
    (	
            data_a	: in std_logic_vector(width - 1 downto 0);
            data_b	: in std_logic_vector(width - 1 downto 0);
            addr_a	: in integer range 0 to depth - 1;
            addr_b	: in integer range 0 to depth - 1;
            we_a	: in std_logic;
            we_b	: in std_logic;
            clk		: in std_logic;
            q_a		: out std_logic_vector(width - 1 downto 0);
            q_b		: out std_logic_vector(width - 1 downto 0)
    );
end component true_dpram_sclk;

component delay_buffer is
    generic(
        ncycles: integer;
        width:   integer
    );
    port(
        clk: in std_logic;
        rst: in std_logic;
        din: in std_logic_vector (width - 1 downto 0);
        dout: out std_logic_vector (width - 1 downto 0)
    );
end component delay_buffer;

-- tdp signals, controlled by system state
signal tdp_datain_a     : std_logic_vector (15 downto 0); 
signal tdp_datain_b     : std_logic_vector (15 downto 0); 
signal tdp_dataout_a    : std_logic_vector (15 downto 0); 
signal tdp_dataout_b    : std_logic_vector (15 downto 0); 
signal tdp_we_a         : std_logic; 
signal tdp_we_b         : std_logic; 
signal tdp_addr_a       : integer range 0 to depth - 1;
signal tdp_addr_b       : integer range 0 to depth - 1;

-- C (update) channel addresses
signal upd_addr_read    : integer range 0 to depth - 1;
signal upd_addr_write   : integer range 0 to depth - 1;

-- delayed vout signals
signal vout_array       : std_logic_vector (1 downto 0);
signal rden_array       : std_logic_vector (1 downto 0);

-- update pipeline
type address_pipeline_type is array (1 downto 0) of integer range 0 to depth - 1;
signal upd_addr_pipeline: address_pipeline_type;
signal upd_data_pipe_in : std_logic_vector (16 downto 0);
signal upd_data_pipe_out : std_logic_vector (16 downto 0);

begin

tdp: true_dpram_sclk
generic map ( width => 16, depth => depth)
port map (
    data_a    => tdp_datain_a,
    data_b    => tdp_datain_b,
    addr_a    => tdp_addr_a,
    addr_b    => tdp_addr_b,
    we_a      => tdp_we_a,
    we_b      => tdp_we_b,
    clk       => clk,
    q_a       => tdp_dataout_a,
    q_b       => tdp_dataout_b
);

tdp_addr_a <= rdaddr_a when (update = '0') else upd_addr_read; 
tdp_addr_b <= rdaddr_b when (update = '0') else upd_addr_write;
dout_a     <= tdp_dataout_a when (update = '0') else (others => '0');
dout_b     <= tdp_dataout_b when (update = '0') else (others => '0');

vout_drive: delay_buffer
generic map (ncycles => 2, width => 2)
port map (
    clk => clk,
    rst => alrst,
    din => rden_array,
    dout => vout_array
);
rden_array(0) <= rden_a;
rden_array(1) <= rden_b;
vout_a        <= vout_array(0);
vout_b        <= vout_array(1);

-- TODO:
-- put udp_addr_read, vin_c and din_c through 2 pipeline stages
-- use pipeline output to drive port B in update mode


end Behavioral;
