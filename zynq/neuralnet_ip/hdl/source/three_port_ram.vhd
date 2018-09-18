library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity three_port_ram is
    generic (
        width: natural := 16;
        depth: natural := 128
    );
    port (
        clk: in std_logic;
        alrst: in std_logic;
        -- read port A
        re_a: in std_logic;
        addr_a: in natural range 0 to depth - 1;
        vout_a: out std_logic;
        dout_a: out std_logic_vector (width - 1 downto 0); 
        -- read port B
        re_b: in std_logic;
        addr_b: in natural range 0 to depth - 1;
        vout_b: out std_logic;
        dout_b: out std_logic_vector (width - 1 downto 0); 
        -- write port C
        addr_c: in natural range 0 to depth - 1;
        vin_c: in std_logic;
        din_c: in std_logic_vector (width - 1 downto 0)
    );
end three_port_ram;

architecture Behavioral of three_port_ram is
    component true_dpram_sclk is
        generic (
            width: natural := 16;
            depth: natural := 128
        );
        port 
        (	
            data_a	: in std_logic_vector(width - 1 downto 0);
            data_b	: in std_logic_vector(width - 1 downto 0);
            addr_a	: in natural range 0 to depth - 1;
            addr_b	: in natural range 0 to depth - 1;
            we_a	: in std_logic;
            we_b	: in std_logic;
            clk		: in std_logic;
            q_a		: out std_logic_vector(width - 1 downto 0);
            q_b		: out std_logic_vector(width - 1 downto 0)
        );
    end component true_dpram_sclk;
    
    signal re_a_pipe, re_b_pipe: std_logic;
    signal r1_colliding: std_logic;
    signal r2_colliding: std_logic;
begin
-- delay re to drive vout
    vout_proc: process (clk, alrst) is
    begin
        if (rising_edge(clk)) then
            if (alrst = '0') then
                re_a_pipe <= '0';
                re_b_pipe <= '0';
                vout_a <= '0';
                vout_b <= '0';
            else
                re_a_pipe <= re_a;
                vout_a <= re_a_pipe;

                re_b_pipe <= re_b;
                vout_b <= re_b_pipe;
            end if;
        end if;
    end process;

-- allocate ports to block ram
ram_1: true_dpram_sclk
    generic map (width => width, depth => depth)
    port map (
        data_a => din_c,
        data_b => din_c,
        addr_a => addr_a,
        addr_b => addr_c,
        we_a   => r1_colliding,
        we_b   => vin_c,
        clk    => clk,
        q_a    => dout_a,
        q_b    => open
    );

ram_2: true_dpram_sclk
    generic map (width => width, depth => depth)
    port map (
        data_a => din_c,
        data_b => din_c,
        addr_a => addr_b,
        addr_b => addr_c,
        we_a   => r2_colliding,
        we_b   => vin_c,
        clk    => clk,
        q_a    => dout_b,
        q_b    => open
    );

-- collision avoidance logic
r1_colliding <= '1' when addr_a = addr_c and vin_c = '1' else '0'; 
r2_colliding <= '1' when addr_b = addr_c and vin_c = '1' else '0';


end Behavioral;
