
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.const_package.all;
use work.helperpkg.all;
use work.nn_arith_package.all;
library ieee_proposed;
use ieee_proposed.fixed_pkg.all;
use ieee.math_real.all;

-- Use the systolic matrix-vector multiplication
-- method outlined in (Paul, Rajopadhye 2006)
-- this is a single row processing element
entity rPE is
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
    strobein: in std_logic_vector (
            PARAM_PER_CHUNK - 1 downto 0); 
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
end rPE;

architecture Behavioral of rPE is

constant param_nchunks_real: real
    := ceil(real(LENGTH)/real(PARAM_PER_CHUNK));

constant PARAM_MEM_SIZE: integer
    := integer(param_nchunks_real)* PARAM_PER_CHUNK;

type params_t is array (PARAM_MEM_SIZE - 1 downto 0)
    of std_logic_vector (PARAM_WIDTH - 1 downto 0);

signal elements: params_t;
signal nupdated: integer range LENGTH downto 0;
signal nvalid_params: integer
        range PARAM_PER_CHUNK downto 1;

signal inputfin: std_logic; 

signal mulptr: integer
        range LENGTH - 1 downto 0;

type   fixedarr is array (PARAM_PER_CHUNK -1 downto 0)
of sfixed(PARAM_DEC - 1 downto -PARAM_FRC);

type   stdvecarr is array (PARAM_PER_CHUNK -1 downto 0)
of std_logic_vector(PARAM_WIDTH - 1 downto 0);

subtype mult_result_type is std_logic_vector
        (2*PARAM_WIDTH - 1 downto 0);
type   multresultarr is 
array (PARAM_PER_CHUNK - 1 downto 0) of mult_result_type;

subtype mult_result_fixed is sfixed
    (2 * PARAM_DEC - 1 downto -2* PARAM_FRC);

type   fixedresultarr is
array (PARAM_PER_CHUNK - 1 downto 0) of mult_result_fixed;

signal stdvec_rowelem: stdvecarr; 
signal fixed_rowelem: fixedarr;
signal fixed_dataout: fixedresultarr; 

signal stdvec_dataout: multresultarr;

signal sig_dataout: std_logic_vector
        (FIFO_WIDTH - 1 downto 0);

signal sig_validout: std_logic; 
signal sig_outputfin: std_logic;

begin
nvalid_params <= fun_strobecount (strobein);

-- parameter update process
-- gotta start somewhere!
-- TODO: separate nupdated and elements,
-- use strobe bits as valid flag
process (clk, rst, datain, validin) is
begin
    if (clk'event and clk = '1') then
        if (rst = '0' or validin = '1') then
            nupdated <= 0;
        elsif (update = '1') then
            nupdated <= (nupdated + nvalid_params)
                        mod LENGTH; 
        end if; 
    end if;
end process;

process (clk, rst, datain, strobein) is
variable upd_ptr: integer range PARAM_PER_CHUNK - 1 downto 0;
begin
    if (clk'event and clk = '1') then
        if (rst = '0') then
            for I in PARAM_MEM_SIZE - 1 downto 0 loop
                elements(I) <= (others => '0');
            end loop; 
        elsif (update = '1') then
            upd_ptr := 0;
            for I in 0 to PARAM_PER_CHUNK - 1 loop
                if (strobein(I) = '1') then
                    elements(nupdated + upd_ptr) <= 
                        datain(PARAM_WIDTH * (I + 1) - 1
                            downto PARAM_WIDTH * I);
                    upd_ptr := (upd_ptr + 1) mod (PARAM_PER_CHUNK);
                end if;
            end loop;
        end if; 
    end if;
end process;

-- forward input data and valid lines to the next PE 
-- after delay
process (clk, validin, datain) is
begin
    if (clk'event and clk = '1') then
        if (rst = '0') then
            validfwd <= '0';
            datafwd  <= (others => '0');
            lastfwd <= '0';
        else
            validfwd <= validin;
            datafwd  <= datain;      
            lastfwd <= lastone;
        end if;
    end if;
end process;  

-- output is ready one clock cycle after input
inputfin <= '1' when lastone = '1' and validin = '1'
                else '0';
process (clk, inputfin) is
begin
    if (clk'event and clk = '1') then
        if (rst = '0') then
            sig_outputfin <= '0';
        else
            sig_outputfin <= inputfin;
        end if;
    end if;
end process;
vectorfin <= '1' when sig_outputfin = '1' and
             lastrow = '1' else '0';
outputfin <= sig_outputfin;

process (clk, validin) is
begin
    if (clk'event and clk = '1') then
        if (rst = '0') then
            sig_validout <= '0';
        else
            sig_validout <= validin;
        end if;
    end if;
end process;
validout <= sig_validout;

process (clk, strobein) is
begin
    if (clk'event and clk = '1') then
        if (rst = '0') then
            strobeout <= (others => '0');
        else
            strobeout <= strobein;
        end if;
    end if;
end process;

-- dot product pointer
process (clk, rst, validin, update) is
begin
    if (clk'event and clk = '1') then
        if (rst = '0' or update = '1' or sig_outputfin = '1') then
            mulptr <= 0;
        elsif (validin = '1') then
            mulptr <= (mulptr + nvalid_params) 
                        mod LENGTH;
        end if;
    end if;
end process;

row_elem_gen:
for I in 0 to PARAM_PER_CHUNK - 1 generate 
    stdvec_rowelem(I) <= elements ((mulptr + I) mod elements'length); 
    fixed_rowelem(I) <= to_sfixed
            (stdvec_rowelem(I), PARAM_DEC - 1, -PARAM_FRC);
end generate;

dataoutgen:
for I in 0 to PARAM_PER_CHUNK - 1 generate
    process (clk, rst,datain) is
    begin
        if (clk'event and clk = '1') then
            if (rst = '0') then
                fixed_dataout(I) <= 
                    to_sfixed (0.0,fixed_dataout(I));   
            else
                fixed_dataout(I) <= 
                    fixed_rowelem(I) * to_sfixed(
                    datain((I+1)*PARAM_WIDTH - 1 downto
                               I*PARAM_WIDTH), 
                    PARAM_DEC - 1, -PARAM_FRC);   
            end if;
        end if;
    end process;
    stdvec_dataout(I) <= 
        mult_result_type (fixed_dataout(I));
    sig_dataout((I+1)*PARAM_WIDTH - 1 downto
                    I*PARAM_WIDTH) <= fun_mul_truncate (stdvec_dataout(I)); 
end generate;

dataout <= sig_dataout;

end Behavioral;

