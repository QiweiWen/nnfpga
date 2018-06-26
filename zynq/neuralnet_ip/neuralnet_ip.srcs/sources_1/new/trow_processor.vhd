-- Whatever on earth is a "trow", you ask?
-- a Transpose ROW.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.helperpkg.all;
use work.nn_arith_package.all;
library ieee_proposed;
use ieee_proposed.fixed_pkg.all;
use ieee.math_real.all;

-- preserve all row processor ports
-- add duplicated aL-1 input, weight memory write ports
-- and zL-1 FIFO input
entity trow_processor is
generic (
    ncols: integer := 100
);
port(
    clk: in std_logic;
    alrst: in std_logic;
-- delta vector input channel
    dl_datain: in std_logic_vector (15 downto 0);
    dl_validin: in std_logic;
    dl_ack     : in std_logic;
    dl_req     : out std_logic;
-- product terms output channel
    deltaout: out std_logic_vector (15 downto 0);
    validout: out std_logic;
-- vector input forwarded to the adjacent row processor down the line
    validfwd: out std_logic;
    deltafwd: out std_logic_vector (15 downto 0);
-- weight memory read ports 
    l1_rden: out std_logic;
    l1_raddr: out integer range 0 to ncols - 1; 
    l1_din : in std_logic_vector (15 downto 0);
    l1_vin : in std_logic;
-- weight memory write ports
    l1_wren: out std_logic;
    l1_waddr: out integer range 0 to ncols - 1;
    l1_wdata: out std_logic_vector (15 downto 0);
-- bias unit write ports
    bias_dout: out std_logic_vector (15 downto 0);
    bias_vout: out std_logic;
-- zL-1 input for backprop
    zll1_datain: in std_logic_vector (15 downto 0);
    zll1_validin: in std_logic;
    zll1_req: out std_logic
);
end trow_processor;

architecture Behavioral of trow_processor is

-- dl and l1 are shared between row processor
-- and derivative unit
signal sig_l1_rden : std_logic;
-- i.e. product almost ready, fetch last level
-- unactivated output right now
-- multiplication result
signal prod_dout: std_logic_vector (31 downto 0);
signal prod_vout: std_logic;

signal dll1_full: std_logic_vector (31 downto 0);
subtype dll1_full_t is std_logic_vector (31 downto 0);

-- sigmoid (zL-1) and sigmoid'(zL-1)
signal sigmoid_dout: std_logic_vector (15 downto 0);
signal sigmoid_vout: std_logic;
signal sigmoid_latched: std_logic_vector (15 downto 0);

signal all1: std_logic_vector (15 downto 0);

signal sigmoid_prime_dout: std_logic_vector (15 downto 0);
signal sigmoid_prime_vout: std_logic;
signal sigmoid_prime_latched: std_logic_vector (15 downto 0);

signal sigmoid_prime_ll1: std_logic_vector (15 downto 0);

-- state variable for reading from zL-1 fifo
signal derivative_multcnt: integer range 0 to ncols - 1; 

-- learning rate
signal learning_rate: std_logic_vector (15 downto 0);
signal lambda_dl: std_logic_vector (15 downto 0);
signal lambda_dl_valid: std_logic;

-- dL and zL-1 are clocked in at the same time
-- activating zL-1 = 2 cycles, multiplying dL by lambda = 1 cycle
-- therefore, delay lambda_dl by one cycle
signal lambda_dl_delayed: std_logic_vector (15 downto 0);
signal lambda_dl_delayed_valid: std_logic;

-- weight update amount
signal weight_adj: std_logic_vector (15 downto 0);
signal weight_adj_valid: std_logic;

-- l1 cache read data pipeline register
signal l1_pipe_in: std_logic_vector (16 downto 0);
signal l1_pipe_out: std_logic_vector (16 downto 0);
signal l1_data_delayed: std_logic_vector (15 downto 0);
signal l1_valid_delayed: std_logic;

-- l1 cache read address pipeline registers
signal sig_l1_raddr: integer range 0 to ncols - 1;
type raddr_pipe_t is array (4 downto 0) of integer range 0 to ncols - 1; 
signal l1_raddr_pipe: raddr_pipe_t;

subtype full_prod_t is std_logic_vector (31 downto 0);
subtype word_t is std_logic_vector (15 downto 0);

component sigmoidfull is
port (
    clk: in std_logic;
    rst: in std_logic;
    datain: in std_logic_vector (16 - 1 downto 0);
    validin: in std_logic;
    dataout: out std_logic_vector (16 - 1 downto 0);
    validout: out std_logic);
end component sigmoidfull;

component sigmoidgradfull is
port (
    clk: in std_logic;
    rst: in std_logic;
    datain: in std_logic_vector (16 - 1 downto 0);
    validin: in std_logic;
    dataout: out std_logic_vector (16 - 1 downto 0);
    validout: out std_logic);
end component sigmoidgradfull;

component row_processor is
generic (
    ncols: integer := 100
);
port(
    clk: in std_logic;
    alrst: in std_logic;
-- l1 cache external interface
    l1_rden: out std_logic;
    l1_raddr: out integer range 0 to ncols - 1; 
    l1_din : in std_logic_vector (15 downto 0);
    l1_vin : in std_logic;
-- vector input channel
    ve_datain: in std_logic_vector (15 downto 0);
    ve_validin: in std_logic;
    ve_ack     : in std_logic;
    ve_req     : out std_logic;
-- product terms output channel
    dataout: out std_logic_vector (31 downto 0);
    validout: out std_logic;
-- vector input forwarded to the adjacent row processor down the line
    validfwd: out std_logic;
    datafwd: out std_logic_vector (15 downto 0)
);
end component row_processor;

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

begin
    l1_rden <= sig_l1_rden;
    l1_raddr <= sig_l1_raddr;
    -- backprop part
    backprop: row_processor
    generic map (ncols => ncols)
    port map (
        clk         => clk,
        alrst       => alrst,
        l1_rden     => sig_l1_rden,
        l1_raddr    => sig_l1_raddr,
        l1_din      => l1_din,
        l1_vin      => l1_vin,
        ve_datain   => dl_datain,
        ve_validin  => dl_validin,
        ve_ack      => dl_ack,
        ve_req      => dl_req,
        dataout     => prod_dout,
        validout    => prod_vout,
        validfwd    => validfwd,
        datafwd     => deltafwd
    );

    activate: sigmoidfull
    port map (
        clk         => clk,
        rst         => alrst,
        datain      => zll1_datain,
        validin     => zll1_validin,
        dataout     => sigmoid_dout,
        validout    => sigmoid_vout
    );

    sigmoid_prime: sigmoidgradfull
    port map (
        clk         => clk,
        rst         => alrst,
        datain      => zll1_datain,
        validin     => zll1_validin,
        dataout     => sigmoid_prime_dout,
        validout    => sigmoid_prime_vout
    );

    sigmoid_latching: process (clk, alrst) is
    begin
        if (rising_edge(clk)) then
            if (alrst = '0') then
                sigmoid_latched <= (others => '0');
                sigmoid_prime_latched <= (others => '0');
            else 
                if (sigmoid_vout = '1') then
                    sigmoid_latched <= sigmoid_dout;
                end if;

                if (sigmoid_prime_vout = '1') then
                    sigmoid_prime_latched <= sigmoid_prime_dout;
                end if;
            end if;
        end if;
    end process;

    -- all1 is the newly computed sigmoid value when it's there
    -- otherwise use the latched value
    all1 <= sigmoid_latched when sigmoid_vout = '0' else sigmoid_dout;
    sigmoid_prime_ll1 <= sigmoid_prime_latched when sigmoid_prime_vout = '0' else
                         sigmoid_prime_dout;
    
    -- pulse zll1_req high for a cycle when we just requested
    -- the last element in the dL vector
    zll1_req <= '1' when sig_l1_raddr = 0 and dl_ack = '1' else '0';  

    multcnt_proc: process (clk, alrst) is
    begin
        if (rising_edge(clk)) then
            if (alrst = '0') then
                derivative_multcnt <= 0;
            elsif (dL_ack = '1') then
                derivative_multcnt <= (derivative_multcnt + 1) mod ncols;
            end if;
        end if;
    end process;

    -- multiply dL by learning rate and share with bias unit
    -- lambda_dl and all1 are then valid on the same cycle 
    learning_rate <= word_t(to_sfixed (LEARN_RATE, PARAM_DEC -1, -PARAM_FRC)); 

    learning_rate_proc: process (clk, alrst) is
        variable lambda_dl_full: std_logic_vector (31 downto 0);
    begin
        if (rising_edge (clk)) then
            if (alrst = '0') then
                lambda_dl <= (others => '0');
                lambda_dl_valid <= '0';

                lambda_dl_delayed <= (others => '0');
                lambda_dl_delayed_valid <= '0'; 
            else
                lambda_dl_full :=  full_prod_t (to_sfixed (dl_datain, PARAM_DEC - 1, -PARAM_FRC) *
                                            to_sfixed (LEARN_RATE, PARAM_DEC - 1, -PARAM_FRC));
                lambda_dl <= lambda_dl_full (2 * PARAM_FRC + PARAM_DEC - 1 downto PARAM_FRC);
                lambda_dl_valid <= dl_validin;

                lambda_dl_delayed <= lambda_dl;
                lambda_dl_delayed_valid <= lambda_dl_valid;
            end if;
        end if;
    end process;

    bias_dout <= lambda_dl;
    bias_vout <= lambda_dl_valid;
    
    -- compute weight adjustment
    weight_adj_proc: process (clk, alrst) is
        variable weight_change_full: std_logic_vector (31 downto 0);
    begin
        if (rising_edge(clk)) then
            if (alrst = '0') then
                weight_adj <= (others => '0');
                weight_adj_valid <= '0';
            else
                weight_change_full := full_prod_t (to_sfixed (all1, PARAM_DEC - 1, -PARAM_FRC) *
                                                   to_sfixed (lambda_dl_delayed, PARAM_DEC - 1, -PARAM_FRC));
                weight_adj <= weight_change_full (2 * PARAM_FRC + PARAM_DEC - 1 downto PARAM_FRC);
                weight_adj_valid <= lambda_dl_delayed_valid;
            end if;
        end if;
    end process;

    -- dl_ack drives l1 cache read.
    -- delay l1 data by 2 cycles and compute l1 write data
    l1_data_delayed <= l1_pipe_out (15 downto 0);
    l1_valid_delayed <= l1_pipe_out (16);
    l1_pipe_in (15 downto 0) <= l1_din;
    l1_pipe_in (16) <= l1_vin;

    l1_align: delay_buffer 
    generic map (ncycles => 3, width => 17)
    port map (
        clk     => clk,
        rst     => alrst,
        din     => l1_pipe_in,
        dout    => l1_pipe_out
    );

    l1_write_generate: process (clk, alrst) is
        subtype full_sum_t is std_logic_vector (16 downto 0);
        variable full_l1_wdata: std_logic_vector (16 downto 0);
    begin
        if (rising_edge(clk)) then
            if (alrst = '0') then
                l1_wdata <= (others => '0');  
                l1_wren  <= '0';
            else
                full_l1_wdata := full_sum_t 
                                   (to_sfixed (l1_data_delayed,PARAM_DEC - 1, -PARAM_FRC) +
                                    to_sfixed (weight_adj     ,PARAM_DEC - 1, -PARAM_FRC));
                l1_wdata <= fun_add_truncate (full_l1_wdata); 
                
                if (l1_valid_delayed = '1' and weight_adj_valid = '1') then
                    l1_wren <= '1';
                else
                    l1_wren <= '0';
                end if;
            end if;
        end if;
    end process;
    l1_waddr <= l1_raddr_pipe(4);

    l1_raddr_delay: process (clk, alrst) is
    begin
        if (rising_edge(clk)) then
            if (alrst = '0') then
                for I in 0 to 4 loop
                    l1_raddr_pipe(I) <= 0;
                end loop;
            else
                l1_raddr_pipe(0) <= sig_l1_raddr;
                for I in 1 to 4 loop
                    l1_raddr_pipe(I) <= l1_raddr_pipe(I - 1);
                end loop;
            end if;
        end if;
    end process;


end Behavioral;
