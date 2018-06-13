library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.helperpkg.all;
use work.nn_arith_package.all;
library ieee_proposed;
use ieee_proposed.fixed_pkg.all;


--
-- A derivative processor computes one of the rows or columns of the
-- weight derivative matrix. A backprop stage has as many derivative units
-- as there are transpose matrix multiplication processors.
--
-- They are organised like so:
--
-- 
-- serial fifo ---> DU ---> DU ---> DU ...
--                  ^       ^       ^
--                  |       |       |
--                  (parallel fifos)
--
-- If the forward propagation stage is row-major (i.e made of row processors),
-- then a(l-1) input is serial. Furthermore, the transpose matrix is column major,
-- meaning that d(l) input is parallel. Therefore, "parallel fifos" in the above
-- ascii art correspond to delta-L from last backward stage, and "serial fifo" is
-- the duplicated a(l - 1) fifo from the last forward stage.
--
-- If the forward stage is col-major, then a(l - 1) input is parallel. With the transpose
-- matrix being row-major, the d(l) input is serial. Therefore the mapping is the opposite.

entity derivative_processor is
    generic (width: integer := 100);
    port (
        clk:        in std_logic;
        alrst:      in std_logic;
    -- parallel side
        p_din:      in std_logic_vector (15 downto 0);
        p_vin:      in std_logic;
        p_ren:      out std_logic;
    -- serial side
        s_din:      in std_logic_vector (15 downto 0);
        s_vin:      in std_logic;
        s_ren:      out std_logic;
        -- to the next unit down the line
        s_dfwd:     out std_logic_vector (15 downto 0);
        s_vfwd:     out std_logic;
    -- output stream
        dataout:    out std_logic_vector (15 downto 0);
        validout:   out std_logic
    );
end derivative_processor;

architecture Behavioral of derivative_processor is
    signal wptr: integer range 0 to width - 1;
    -- both parallel and serial sides must survive starvation initially
    -- (when they come from dL fifos)
    -- but not gaps once the flow of parameters starts
    type state_t is (init, wait_p, wait_s, stream);
    signal this_state: state_t;
    signal next_state: state_t;
    -- multiplication results
    subtype full_prod_t is std_logic_vector (31 downto 0);
    signal prod_full: std_logic_vector (31 downto 0); 
begin
-- serial data forwarding
    fwd_proc:
    process (clk, alrst) is
    begin
        if (rising_edge(clk)) then
            if (alrst = '0') then
                s_dfwd <= (others => '0');
                s_vfwd <= '0';
            else
                s_dfwd <= s_din;
                s_vfwd <= s_vin;
            end if;
        end if;
    end process;

-- width pointer process
    wptr_proc:
    process (clk, alrst) is
    begin
        if (rising_edge (clk)) then
            if (alrst = '0') then
                wptr <= 0;
            elsif (s_vin = '1') then
                wptr <= (wptr + 1) mod width;
            end if;
        end if;
    end process;

-- product stream generation
-- TODO: add validout pipeline registers
--       etc etc multiply, truncate, etc
    mult_proc:
    process (clk, alrst) is
    begin
        if (rising_edge (clk)) then
            if (alrst = '0') then
                prod_full <= (others => '0'); 
                validout <= (others => '0');
                dataout <= (others => '0');
            else

            end if;
        end if;
    end process;

-- state transition process;
    stat_proc: 
    process (clk, alsrt) is
    begin
        if (rising_edge(clk)) then
            if (alrst = '0') then
                this_state <= init;
            else
                this_state <= next_state;
            end if;
        end if;
    end process;

-- output logic;
    output_proc:
    process (clk, alrst, this_state, p_vin, s_vin, wptr) is
    begin
        if (rising_edge (clk) and alrst = '0') then
            p_ren <= '1';
            s_ren <= '1';
        else
            case this_state is
                when init =>
                    if (p_vin = '1' and s_vin = '1') then
                        s_ren <= '0';
                        p_ren <= '1';
                        next_state <= stream;
                    elsif (p_vin = '1') then
                        p_ren <= '0';
                        s_ren <= '1';
                        next_state <= wait_s;
                    elsif (s_vin = '1') then
                        p_ren <= '1';
                        s_ren <= '0';
                        next_state <= wait_p;
                    else
                        p_ren <= '1';
                        s_ren <= '1';
                        next_state <= init;
                    end if;
                when wait_p =>
                    if (p_vin = '1') then
                        p_ren <= '1';
                        s_ren <= '0';
                        next_state <= stream;
                    else
                        p_ren <= '1';
                        s_ren <= '0';
                        next_state <= wait_p; 
                    end if;
                when wait_s =>
                    if (s_vin = '1') then
                        s_ren <= '1';
                        p_ren <= '0';
                        next_state <= stream;
                    else
                        s_ren <= '1';
                        p_ren <= '0';
                        next_state <= wait_s; 
                    end if;
                when stream =>
                    if (wptr = 0) then
                        s_ren <= '1';
                        p_ren <= '1';
                        next_state <= init;
                    else
                        s_ren <= '1';
                        p_ren <= '0';
                        next_state <= stream;
                    end if;
            end case;
        end if;
    end process;


end Behavioral;
