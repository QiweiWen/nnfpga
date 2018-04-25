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
    wraddr_c            : in integer range 0 to depth - 1
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

-- tdp signals, controlled by system state
signal tdp_datain_a     : std_logic_vector (15 downto 0); 
signal tdp_datain_b     : std_logic_vector (15 downto 0); 
signal tdp_dataout_a    : std_logic_vector (15 downto 0); 
signal tdp_dataout_b    : std_logic_vector (15 downto 0); 
signal tdp_we_a         : std_logic; 
signal tdp_we_b         : std_logic; 
signal tdp_addr_a       : integer range 0 to depth - 1;
signal tdp_addr_b       : integer range 0 to depth - 1;

type state_t is (do_read, do_update);
signal this_state: state_t;
signal next_state: state_t;

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

-- state change process
next_state <= do_read when update = '0' else do_update; 
next_state_proc: process (clk, alrst)
begin
    if (rising_edge(clk)) then
        if (alrst = '0') then
            this_state <= do_read;
        else
            this_state <= next_state;
        end if;
    end if;
end process;




end Behavioral;
