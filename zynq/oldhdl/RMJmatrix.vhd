library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.const_package.all;
use work.helperpkg.all;
use work.nn_arith_package.all;
use ieee.math_real.all;

-- row major matrix
-- made up of row processing elements
-- serial input, parallel output
entity RMJmatrix is
generic (
    nrows: integer := 10;
    ncols: integer := 10
);
port(
    clk: in std_logic;
    rst: in std_logic;
    -- pin to control parameter update
    update: in std_logic;
    -- pins associated with serial input
    datain: in std_logic_vector (FIFO_WIDTH - 1 downto 0);
    validin: in std_logic;
    lastone: in std_logic;
    strobein: in std_logic_vector 
        (PARAM_PER_CHUNK - 1 downto 0); 
    -- pins associated with parallel output
    strobeout: out std_logic_vector (nrows - 1 downto 0);
    arrayout: out wordarr_t (nrows - 1 downto 0);
    vectorfin: out std_logic
);
end RMJmatrix;

architecture Behavioral of RMJmatrix is
constant UPDATE_CYCLES: integer
    := integer (ceil( real(ncols * nrows)/real(PARAM_PER_CHUNK) ));
-- individual row processing element
component rPE is
generic(
    -- number of parameters held by this PE
    LENGTH: integer := 9;
    lastrow: std_logic := '0'
);
port (
    clk: in std_logic;
    rst: in std_logic;
    --parameter update: data, valid flag, strobe
    update: in std_logic;   
    strobein: in std_logic_vector 
           (PARAM_PER_CHUNK - 1 downto 0); 
    --input data to multiply/acumulate
    validin: in std_logic;
    datain: in std_logic_vector
                (FIFO_WIDTH - 1 downto 0);
    --whether the input data is the last
    lastone: in std_logic;
    -- forward to next PE
    validfwd: out std_logic;
    datafwd: out std_logic_vector
                (FIFO_WIDTH - 1 downto 0);
    lastfwd: out std_logic;
    --output data and valid
    validout: out std_logic;
    dataout: out std_logic_vector
                (FIFO_WIDTH - 1 downto 0);
    --number of valid output
    strobeout: out std_logic_vector (
            PARAM_PER_CHUNK - 1 downto 0); 
    outputfin: out std_logic;
    --this marks that a complete vector has
    --been computed
    vectorfin: out std_logic
);
end component rPE;

-- dot product accumulator
component accumulator is
    Port ( 
        clk : in STD_LOGIC;
        rst : in STD_LOGIC;
        validin: in std_logic;
        lastone: in std_logic;
        datain: in std_logic_vector (FIFO_WIDTH - 1 downto 0);
        strobein: in std_logic_vector (PARAM_PER_CHUNK - 1 downto 0);
        dataout: out std_logic_vector (FIFO_WIDTH - 1 downto 0);
        validout: out std_logic
    );
end component;

signal strobe_pair: strobe_pair_type;

signal update_ticks: integer range UPDATE_CYCLES downto 0;  

-- record containing indexes in datain_update array
-- where datain is mapped
signal rptr: row_pointer_t;

type strobe_array_t is array (nrows - 1 downto 0) of
	 std_logic_vector (PARAM_PER_CHUNK - 1 downto 0);
type datain_array_t is array (nrows - 1 downto 0) of
	 std_logic_vector (FIFO_WIDTH - 1 downto 0);
type update_array_t is array (nrows - 1 downto 0) of
	 std_logic;   
type validin_array_t is array (nrows - 1 downto 0) of
	 std_logic;
type lastone_array_t is array (nrows - 1 downto 0) of
	 std_logic;
type validfwd_array_t is array (nrows - 1 downto 0) of
	 std_logic;
type datafwd_array_t is array (nrows - 1 downto 0) of
	 std_logic_vector(FIFO_WIDTH - 1 downto 0);
type lastfwd_array_t is array (nrows - 1 downto 0) of
	 std_logic;
type validout_array_t is array (nrows - 1 downto 0) of
	 std_logic;
type dataout_array_t is array (nrows - 1 downto 0) of
	 std_logic_vector(FIFO_WIDTH - 1 downto 0);
type strobeout_array_t is array (nrows - 1 downto 0) of
	 std_logic_vector (PARAM_PER_CHUNK - 1 downto 0); 
type outputfin_array_t is array (nrows - 1 downto 0) of
	 std_logic;

-- datain and strobein will need to be multiplexed between update and
-- multiplication states
signal sig_strobein_arr: strobe_array_t;
signal strobein_update: strobe_array_t;
signal strobein_mult: strobe_array_t;
signal sig_datain_arr: datain_array_t;
signal datain_update: datain_array_t;
signal datain_mult: datain_array_t;
-- other arrays for port mapping
signal sig_update_arr: update_array_t;   
signal sig_validin_arr: validin_array_t;
signal sig_lastone_arr: lastone_array_t;
signal sig_validfwd_arr: validfwd_array_t;
signal sig_datafwd_arr: datafwd_array_t;
signal sig_lastfwd_arr: lastfwd_array_t;
signal sig_validout_arr: validout_array_t;
signal sig_dataout_arr: dataout_array_t;
signal sig_strobeout_arr: strobeout_array_t; 
signal sig_outputfin_arr: outputfin_array_t;

signal sig_vectorfin: std_logic;
signal sig_vectorfin_delay: std_logic;

begin

--datain and strobein multiplexing
sig_datain_arr <= datain_update when update = '1' else datain_mult;
sig_strobein_arr <= strobein_update when update = '1' else strobein_mult;
--this-row and next-row strobes
strobe_pair <= fun_get_strobes (ncols, update_ticks, strobein);
--update cycle count
ticks_update:
process (rst, clk) is
begin
    if (clk'event and clk = '1') then
        if (rst = '0' or validin = '1') then
            update_ticks <= 0;
        elsif (update = '1') then
            update_ticks <= (update_ticks + 1) mod (UPDATE_CYCLES + 1);
        end if;
    end if;
end process;
--parameter update data and strobe routing
rptr <= fun_put_param (ncols, nrows, update_ticks);
update_array_gen:
for I in 0 to nrows - 1 generate
    datain_update(I) <= datain when ((rptr.wrap = '1' and 
                                        (rptr.inds(0) = I or rptr.inds(1) = I))
                                    or
                                     (rptr.wrap = '0' and
                                         rptr.inds(0) = I))
                               else (others => '0');
    strobein_update(I) <= strobe_pair(0) when (rptr.inds(0) = I) else
                       strobe_pair(1) when (rptr.inds(1) = I and rptr.wrap = '1') else
                       (others => '0');
    sig_update_arr(I) <= update when
                            ((rptr.inds(0) = I) or (rptr.inds(1) = I and rptr.wrap = '1'))
                             else '0';
    -- feed vector to first row processing element
    datain_mult(I) <= datain when (I = 0) else sig_datafwd_arr (I - 1); 
    sig_validin_arr(I) <= validin when (I = 0) else sig_validfwd_arr (I - 1); 
    sig_lastone_arr(I) <= lastone when (I = 0) else sig_lastfwd_arr (I - 1); 
    strobein_mult(I) <= strobein when (I = 0) else sig_strobeout_arr (I - 1);
end generate;

--row processors port map
pe_gen:
for I in 0 to nrows - 2 generate
    rows_portmap:rPE 
    generic map (
        length => ncols,
        lastrow => '0' 
    )
    port map (
        clk => clk,
        rst => rst,
        update => sig_update_arr(I),
        strobein => sig_strobein_arr(I),
        validin => sig_validin_arr(I),
        datain => sig_datain_arr(I),
        lastone => sig_lastone_arr(I),
        validfwd => sig_validfwd_arr(I),
        datafwd => sig_datafwd_arr(I),
        lastfwd => sig_lastfwd_arr(I),
        validout => sig_validout_arr(I),
        dataout => sig_dataout_arr(I),
        strobeout => sig_strobeout_arr(I),
        outputfin => sig_outputfin_arr(I),
        vectorfin => open
    );
end generate;

lastrow_portmap: rPE
generic map(
    length => ncols,
    lastrow => '1'
)
port map (
    clk => clk,
    rst => rst,
    update => sig_update_arr (nrows - 1),
    strobein => sig_strobein_arr (nrows - 1),
    validin => sig_validin_arr (nrows - 1),
    datain => sig_datain_arr (nrows - 1),
    lastone => sig_lastone_arr (nrows - 1),
    validfwd => sig_validfwd_arr (nrows - 1),
    datafwd => sig_datafwd_arr (nrows - 1),
    lastfwd => sig_lastfwd_arr (nrows - 1),
    validout => sig_validout_arr (nrows - 1),
    dataout => sig_dataout_arr (nrows - 1),
    strobeout => sig_strobeout_arr (nrows - 1),
    outputfin => sig_outputfin_arr (nrows - 1),
    vectorfin => sig_vectorfin
);

proc_vectorfin:
process (clk, rst) is
begin
    if (clk'event and clk = '1') then
        if (rst = '0') then
            sig_vectorfin_delay <= '0';
        else
            sig_vectorfin_delay <= sig_vectorfin;
        end if;
    end if;
end process;

vectorfin <= sig_vectorfin_delay;

accumulator_gen:
for I in 0 to nrows - 1 generate
    accumulators_portmap: accumulator 
    port map (
        clk  => clk,
        rst  => rst, 
        validin => sig_validout_arr(I),
        lastone => sig_lastfwd_arr(I), 
        datain => sig_dataout_arr(I),
        strobein => sig_strobeout_arr(I),
        dataout => arrayout(I),
        validout => strobeout (I)
    );
end generate;

end Behavioral;
