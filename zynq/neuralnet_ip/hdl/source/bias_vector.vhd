library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.helperpkg.all;
use work.nn_arith_package.all;
library ieee_proposed;
use work.fixed_pkg.all;
use ieee.math_real.all;

entity bias_vector is
generic (nrows: natural := 100);
port (
    clk: in std_logic;
    alrst: in std_logic; 
-- product vector from column vectors
    unbiased: in std_logic_vector (31 downto 0);
    vin:  in std_logic;
-- result with biased added
-- goes to sigmoid unit and fifos
    biased: out std_logic_vector (15 downto 0);
    vout: out std_logic;
-- bias update channel from transpose row processor
    updated: in std_logic_vector (15 downto 0);
    uvin: in std_logic
);
end bias_vector;

architecture Behavioral of bias_vector is

component delay_buffer is
    generic(
        ncycles: natural;
        width:   natural
    );
    port(
        clk: in std_logic;
        rst: in std_logic;
        din: in std_logic_vector (width - 1 downto 0);
        dout: out std_logic_vector (width - 1 downto 0)
    );
end component delay_buffer;

component three_port_ram is
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
end component three_port_ram;

signal unbiased_truncated: std_logic_vector (15 downto 0);
signal unbiased_pipe: std_logic_vector (15 downto 0);
signal unbiased_delayed: std_logic_vector (15 downto 0);

signal fp_rdata : std_logic_vector (15 downto 0);

-- block ram read address for inference
signal fp_raddr: natural range 0 to nrows - 1;
-- block ram read address when updating during training
signal bp_raddr: natural range 0 to nrows - 1;
-- existing bias read from bram
signal bp_rdata: std_logic_vector (15 downto 0);
-- block ram write address, lags raddr by 2 cycles
signal bp_waddr: natural range 0 to nrows - 1;
-- updated bias written back during training
signal bp_wdata: std_logic_vector (15 downto 0);

signal bp_raddr_pipe: natural range 0 to nrows - 1;

signal upd_data_pipe_in : std_logic_vector (16 downto 0);
signal upd_data_pipe_out : std_logic_vector (16 downto 0);

signal vout_pipe: std_logic;

begin


unbiased_align: process (clk, alrst) is
    begin
        if (rising_edge(clk)) then
            if (alrst = '0') then
                unbiased_delayed <= (others => '0');
                unbiased_truncated <= (others => '0');
            else
                unbiased_delayed <= unbiased_truncated;
                unbiased_truncated <= fun_mul_truncate (unbiased, 2* PARAM_FRC - 1);
            end if;
        end if;
    end process;

validout_align: process (clk, alrst) is
    begin
        if (rising_edge(clk)) then
            if (alrst = '0') then
                vout <= '0';
                vout_pipe <= '0';
            else
                vout <= vout_pipe;
                vout_pipe <= vin;
            end if;
        end if;
    end process;

biased <= func_safe_sum (unbiased_delayed, fp_rdata);

memaddr_proc: process (clk, alrst) is
    begin
        if (rising_edge(clk)) then
            if (alrst = '0') then
                fp_raddr <= 0;
                bp_raddr <= 0;
                bp_waddr <= 0;
                bp_raddr_pipe <= 0;
            else
                if (vin = '1') then
                    fp_raddr <= (fp_raddr + 1) mod nrows;
                end if;

                if (uvin = '1') then
                    bp_raddr <= (bp_raddr + 1) mod nrows;
                end if;
                bp_raddr_pipe <= bp_raddr;
                bp_waddr <= bp_raddr_pipe;
            end if;
        end if;
    end process;

-- bias read and write-back
upd_data_pipe_in (15 downto 0) <= updated; 
upd_data_pipe_in (16)          <= uvin;

upd_data_pipe: delay_buffer
generic map (ncycles => 2, width => 17)
port map (
    clk => clk,
    rst => alrst,
    din => upd_data_pipe_in,
    dout => upd_data_pipe_out
);

bp_wdata <= func_safe_sum (upd_data_pipe_out (15 downto 0),
                                                 bp_rdata);

-- three port ram port map
-- port a: inference read
-- port b: training read
-- port c: training write

bias_memory: three_port_ram
generic map (width => 16, depth => nrows)
port map (
    clk         => clk,
    alrst       => alrst,
    re_a        => vin,
    addr_a      => fp_raddr,
    vout_a      => open,
    dout_a      => fp_rdata,

    re_b        => uvin,
    addr_b      => bp_raddr,
    vout_b      => open,
    dout_b      => bp_rdata,

    addr_c      => bp_waddr,
    vin_c       => upd_data_pipe_out (16),
    din_c       => bp_wdata

);

end Behavioral;
