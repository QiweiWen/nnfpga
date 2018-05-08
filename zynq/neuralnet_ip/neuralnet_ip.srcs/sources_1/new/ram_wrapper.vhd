-- wrapper over true dual port ram
-- modes of operation:
-- 1. read mode
--    Both ports used for reading
--
-- 2. update mode
--    One port used for reading, the other port used for writing modified
--    data
-- 
-- 3. write-through mode:
--    One port used for writing initial data

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
            data_a     : in std_logic_vector(width - 1 downto 0);
            data_b     : in std_logic_vector(width - 1 downto 0);
            addr_a     : in integer range 0 to depth - 1;
            addr_b     : in integer range 0 to depth - 1;
            we_a     : in std_logic;
            we_b     : in std_logic;
            clk          : in std_logic;
            q_a          : out std_logic_vector(width - 1 downto 0);
            q_b          : out std_logic_vector(width - 1 downto 0)
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

-- tdp signals
signal tdp_datain_a     : std_logic_vector (15 downto 0); 
signal tdp_datain_b     : std_logic_vector (15 downto 0); 
signal tdp_dataout_a    : std_logic_vector (15 downto 0); 
signal tdp_dataout_b    : std_logic_vector (15 downto 0); 
signal tdp_we_a         : std_logic; 
signal tdp_we_b         : std_logic; 
signal tdp_addr_a       : integer range 0 to depth - 1;
signal tdp_addr_b       : integer range 0 to depth - 1;

-- C (update) channel addresses
signal upd_addr_write   : integer range 0 to depth - 1;

-- delayed vout signals
signal vout_array       : std_logic_vector (1 downto 0);
signal rden_array       : std_logic_vector (1 downto 0);

-- update pipeline
signal upd_addr_pipeline: integer range 0 to depth - 1;
signal upd_data_pipe_in : std_logic_vector (16 downto 0);
signal upd_data_pipe_out : std_logic_vector (16 downto 0);

-- writeback date
signal upd_data_writeback: std_logic_vector (15 downto 0);

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

tdp_addr_a <= rdaddr_a when (update = '0' and write = '0') else wraddr_c; 
tdp_addr_b <= rdaddr_b when (tdp_we_b = '0') else upd_addr_write;
dout_a     <= tdp_dataout_a; 
dout_b     <= tdp_dataout_b;

vout_drive: delay_buffer
generic map (ncycles => 1, width => 2)
port map (
    clk => clk,
    rst => alrst,
    din => rden_array,
    dout => vout_array
);
rden_array(0) <= '1' when rden_a = '1' and update = '0' and write = '0' else '0';
rden_array(1) <= '1' when rden_b = '1' and update = '0' and write = '0' else '0';
vout_a        <= vout_array(0);
vout_b        <= vout_array(1);

-- put udp_addr_read, vin_c and din_c through a pipeline stage1
-- because read takes one cycle therefore writeback signals
-- lag read signals by 1 cycle
-- use pipeline output to drive port B in update mode

write_addr_pipe:
process (clk, alrst) is
begin
    if (rising_edge(clk)) then
        if (alrst = '0') then
            upd_addr_pipeline <= 0; 
        else
            upd_addr_write    <= wraddr_c;
        end if;
    end if;
end process;


upd_data_pipe_in (16) <= '1' when vin_c = '1' and update = '1' and write = '0' 
                             else '0'; 
upd_data_pipe_in (15 downto 0) <= din_c; 

upd_data_pipe: delay_buffer
generic map (ncycles => 1, width => 17)
port map (
    clk => clk,
    rst => alrst,
    din => upd_data_pipe_in,
    dout => upd_data_pipe_out
);

upd_data_writeback <= func_safe_sum (upd_data_pipe_out (15 downto 0),
                                                      tdp_dataout_a);
tdp_we_a <= '1' when vin_c = '1' and write = '1' and update = '0' else '0';
tdp_we_b <= upd_data_pipe_out (16);
ack_c    <= tdp_we_b;

tdp_datain_a <= din_c; 
tdp_datain_b <= upd_data_writeback;

end Behavioral;
