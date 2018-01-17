
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use work.const_package.all;

package helperpkg is

function fun_strobecount (
    datain: std_logic_vector
        (PARAM_PER_CHUNK - 1 downto 0)
)return integer;

type strobe_pair_type is array (1 downto 0)
    of std_logic_vector (PARAM_PER_CHUNK - 1 downto 0);
function fun_get_strobes (
    ncols: integer;
    nticks: integer;
    strobein: std_logic_vector (PARAM_PER_CHUNK - 1 downto 0)
)return strobe_pair_type;

type int_array_type is array (1 downto 0)
    of integer;
type row_pointer_t is record
    inds: int_array_type;
    wrap: std_logic;
end record;
function fun_put_param (
    ncols: integer;
    nrows: integer;
    nticks: integer
)return row_pointer_t;

end package;

package body helperpkg is

function fun_strobecount (
    datain: std_logic_vector
        (PARAM_PER_CHUNK - 1 downto 0)
)return integer is 
variable var_ret: integer
    range PARAM_PER_CHUNK downto 0;
begin
    var_ret := 0;
    for I in 0 to PARAM_PER_CHUNK - 1 loop
        if (datain(I) = '1') then
            var_ret := var_ret + 1;
        end if;
    end loop; 
    return var_ret;
end function;

function fun_count2strobe (
   num: integer;
   upper: std_logic
)return std_logic_vector is
variable var_ret: std_logic_vector (PARAM_PER_CHUNK - 1 downto 0);
variable starting_index: integer;
variable ending_index: integer;
begin
    var_ret := (others => '0');
    if (upper = '0') then
        starting_index := num - 1;
    else
        starting_index := PARAM_PER_CHUNK - 1;
    end if;
    ending_index := starting_index - num + 1;

    for I in 0 to PARAM_PER_CHUNK - 1 loop
        if (I <= starting_index and I >= ending_index) then
            var_ret (I) := '1';    
        else
            var_ret (I) := '0';
        end if;
    end loop;

    return var_ret;
end function;

function fun_get_strobes (
    ncols: integer;
    nticks: integer;
    strobein: std_logic_vector (PARAM_PER_CHUNK - 1 downto 0)
)return strobe_pair_type is
variable res: strobe_pair_type;
variable chunklen: integer;
variable nleft: integer; --number of elements left in this row
begin
    chunklen := PARAM_PER_CHUNK;
    nleft := ncols - (((nticks) * chunklen) mod ncols);
    if (nleft >= chunklen) then
        res(0) := strobein; 
        res(1) := (others => '0');
    else
        res(0) := fun_count2strobe(nleft, '0'); 
        res(1) := fun_count2strobe(chunklen - nleft, '1');
    end if; 
    return res;
end function;

function fun_put_param (
    ncols: integer;
    nrows: integer;
    nticks: integer
)return row_pointer_t is
variable res: row_pointer_t;
variable chunklen: integer;
variable nleft: integer; --number of elements left in this row
begin
    chunklen := PARAM_PER_CHUNK;
    nleft := ncols - (((nticks) * chunklen) mod ncols);
    if (nleft >= chunklen) then
        res.inds(0) := ((nticks) * chunklen)/ncols; 
        res.inds(1) := 0; 
        res.wrap := '0';
    else
        res.inds(0) := ((nticks) * chunklen)/ncols; 
        if (res.inds(0) = nrows - 1) then
            res.inds(1) := 0;
            res.wrap := '0';
        else
            res.inds(1) := res.inds(0) + 1;
            res.wrap := '1';
        end if;
    end if; 
    return res;
end function;

end package body;
