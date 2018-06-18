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
    -- master dL read-enable and dL empty signals
    -- use them to determine when it's safe to
    -- begin reading from the FIFOs
        master_rden:in std_logic; 
        -- ^ from row or column backprop processor's ve_req signal
        dL_empty:   in std_logic;
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
    subtype full_prod_t is std_logic_vector (31 downto 0);

begin

end Behavioral;
