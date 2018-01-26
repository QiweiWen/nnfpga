----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.01.2018 14:52:22
-- Design Name: 
-- Module Name: l2_cache - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.math_real.all;
use ieee.numeric_std.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity l2_cache is

    generic (
        nrows: integer := 400;
        ncols: integer := 100
    );
    port (
        clk: in std_logic;
        alrst: in std_logic;
        -- port B, 64 bits
        datain_B: in std_logic_vector (63 downto 0);
        dataout_B: out std_logic_vector (63 downto 0);
        flushout: in std_logic;
        streamin: in std_logic;
        validout_B: out std_logic;
        -- port A, 16 bits
        datain_A: in std_logic_vector (15 downto 0);
        we_A: in std_logic;
        re_A: in std_logic;
        dataout_A: out std_logic_vector (15 downto 0);
        row_A: in integer range nrows - 1 downto 0;
        col_A: in integer range ncols - 1 downto 0;
        validout_A: out std_logic
    );
end l2_cache;

architecture Behavioral of l2_cache is
    function log2( i : natural) return integer is
    variable temp    : integer := i;
    variable ret_val : integer := 0; 
    begin					
        while temp > 1 loop
            ret_val := ret_val + 1;
            temp    := temp / 2;     
        end loop;
        return ret_val;
    end function;
    -- generic map parameters
    constant widtha: integer := 16;
    constant nqwords: integer
        := integer (ceil( real(ncols * nrows)/real(4)));
    constant nwords: integer := nqwords * 4;
    constant sizea: integer := nwords;
    constant addrwidtha: integer := log2(sizea); 
    constant widthb: integer := 64;
    constant sizeb: integer := nqwords;
    constant addrwidthb: integer := log2(sizeb);
    -- channel A is the 16-bit channel
    -- channel B is the 64-bit channel
    component asymmetric_ram_2b is
        generic (
            WIDTHA : integer;
            SIZEA : integer;
            ADDRWIDTHA : integer;
            WIDTHB : integer;
            SIZEB : integer;
            ADDRWIDTHB : integer
        );
        port (
             clkA : in std_logic;
             clkB : in std_logic;
             enA : in std_logic;
             enB : in std_logic;
             weA : in std_logic;
             weB : in std_logic;
             addrA : in std_logic_vector(ADDRWIDTHA-1 downto 0);
             addrB : in std_logic_vector(ADDRWIDTHB-1 downto 0);
             diA : in std_logic_vector(WIDTHA-1 downto 0);
             diB : in std_logic_vector(WIDTHB-1 downto 0);
             doA : out std_logic_vector(WIDTHA-1 downto 0);
             doB : out std_logic_vector(WIDTHB-1 downto 0)
        );
    end component asymmetric_ram_2b;

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

     signal sig_enA :  std_logic;
     signal sig_enB :  std_logic;
     signal sig_weA :  std_logic;
     signal sig_weB :  std_logic;
     signal sig_addrA :  std_logic_vector(ADDRWIDTHA-1 downto 0);
     signal sig_addrB :  std_logic_vector(ADDRWIDTHB-1 downto 0);
     signal sig_diA :  std_logic_vector(WIDTHA-1 downto 0);
     signal sig_diB :  std_logic_vector(WIDTHB-1 downto 0);
     signal sig_doA :  std_logic_vector(WIDTHA-1 downto 0);
     signal sig_doB :  std_logic_vector(WIDTHB-1 downto 0);
     
     -- a high-to-low transition in "flushout" or "streamin" resets addrB
     signal last_streamin: std_logic;
     signal last_flushout: std_logic;
     signal addrB_rst: std_logic;
     signal addrB_next: std_logic_vector(ADDRWIDTHB-1 downto 0);

     signal re_in: std_logic_vector (1 downto 0);
     signal re_out: std_logic_vector (1 downto 0);

begin
    blockram_portmap:
    asymmetric_ram_2b
    generic map(
        WIDTHA  => WIDTHA,
        SIZEA  => SIZEA,
        ADDRWIDTHA  => ADDRWIDTHA,
        WIDTHB  => WIDTHB,
        SIZEB  => SIZEB,
        ADDRWIDTHB  => ADDRWIDTHB
    )
    port map(
        clkA => clk,
        clkB => clk,
        enA  => sig_enA ,
        enB  => sig_enB ,
        weA  => sig_weA ,
        weB  => sig_weB ,
        addrA  => sig_addrA ,
        addrB  => sig_addrB ,
        diA  => sig_diA ,
        diB  => sig_diB ,
        doA  => sig_doA ,
        doB  => sig_doB 
    );
    
    sig_enA <= '1' when (we_A = '1' or re_A = '1') else '0'; 
    sig_enB <= '1' when (flushout = '1' or streamin = '1') else '0'; 
    sig_weA <= we_A;
    sig_weB <= streamin;

    sig_addrA <= std_logic_vector(to_unsigned(row_A * ncols + col_A,
                                                  sig_addrA'length));

    -- sig_addrB generation logic
    addrB_reset_proc:
    process (clk, alrst) is
    begin
        if (rising_edge (clk)) then
            if (alrst = '0') then
                last_streamin <= '0';
                last_flushout <= '0';
            else
                last_streamin <= streamin;
                last_flushout <= flushout;
            end if;
        end if;
    end process;

    addrB_rst <= '0' when ((streamin = '0' and last_streamin = '1') or
                           (flushout = '0' and last_flushout = '1')) else '1';
    addrB_next <= std_logic_vector
                    (to_unsigned((to_integer(unsigned(sig_addrB)) + 1), 
                                 sig_addrB'length)) 
                  when (streamin = '1' or flushout = '1') else (others => '0'); 

    addrB_gen_proc:
    process (clk, alrst) is
    begin
        if (rising_edge (clk)) then
            if (alrst = '0' or addrB_rst = '0') then
                sig_addrB <= (others => '0');
            else
                sig_addrB <= addrB_next;
            end if;
        end if;
    end process;

    sig_diA <= datain_A; 
    sig_diB <= datain_B;
    
    dataout_A <= sig_doA;
    dataout_B <= sig_doB;

    -- data is valid two cycles after read enable signals
    -- becauses of output pipeline register
    re_in (0) <= flushout;
    re_in (1) <= re_A;

    validout_delay: delay_buffer
    generic map(
        ncycles => 2,
        width => 2
    )
    port map (
        clk => clk,
        rst => alrst,
        din => re_in,
        dout => re_out
    );
    
    validout_B <= re_out (0);
    validout_A <= re_out (1);
    
end Behavioral;
