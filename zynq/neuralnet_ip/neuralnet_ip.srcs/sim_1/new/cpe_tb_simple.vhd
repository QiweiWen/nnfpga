-- Testbench automatically generated online
-- at http://vhdl.lapinoo.net
-- Generation date : 11.5.2018 03:09:02 GMT

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library ieee_proposed;
use ieee_proposed.fixed_pkg.all;

use ieee.math_real.all;

use work.helperpkg.all;

entity tb_column_processor is
end tb_column_processor;

architecture tb of tb_column_processor is
    constant nrows : integer := 5;

    component column_processor
        generic (nrows: integer);
        port (clk        : in std_logic;
              alrst      : in std_logic;
              l1_rden    : out std_logic;
              l1_raddr   : out integer range 0 to nrows - 1; 
              l1_din     : in std_logic_vector (15 downto 0);
              l1_vin     : in std_logic;
              ve_datain  : in std_logic_vector (15 downto 0);
              ve_validin : in std_logic;
              ve_req     : out std_logic;
              ve_ack     : in std_logic;
              osync      : out std_logic;
              isync      : in std_logic;
              ivfwd      : in std_logic;
              idfwd      : in std_logic_vector (31 downto 0);
              ovfwd      : out std_logic;
              odfwd      : out std_logic_vector (31 downto 0));
    end component;

    signal clk        : std_logic;
    signal alrst      : std_logic;
    signal l1_rden    : std_logic;
    signal l1_raddr   : integer range 0 to nrows - 1;
    signal l1_din     : std_logic_vector (15 downto 0);
    signal l1_vin     : std_logic;
    signal ve_datain  : std_logic_vector (15 downto 0);
    signal ve_validin : std_logic;
    signal ve_req     : std_logic;
    signal ve_ack     : std_logic;
    signal osync      : std_logic;
    signal isync      : std_logic := '1';
    signal ivfwd      : std_logic := '1';
    signal idfwd      : std_logic_vector (31 downto 0) := (others => '0');
    signal ovfwd      : std_logic;
    signal odfwd      : std_logic_vector (31 downto 0);


    constant TbPeriod : time := 100 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

    signal latched_partial_sum: real;

begin

    debug:
    process (clk, alrst) is
    begin
        if (rising_edge(clk)) then
            if (alrst = '0') then
                latched_partial_sum <= 0.0; 
            else
                if (ovfwd = '1') then
                    latched_partial_sum <= 
                        to_real(to_sfixed(odfwd, 2*PARAM_DEC - 1, -2*PARAM_FRC));
                end if;
            end if;
        end if;
    end process;
    
    fake_data: process (clk) is
    begin
        if (rising_edge (clk)) then
            l1_vin <= l1_rden;
            if (l1_rden = '1') then
                l1_din <= std_logic_vector (to_unsigned(l1_raddr, 8)) & X"00";
            end if;

            ve_validin <= ve_req;
            if (ve_req = '1') then
                ve_datain <= X"0200";
            else
                ve_datain <= X"0000";
            end if;
        end if;
    end process;
    ve_ack <= ve_req;

    dut : column_processor
    generic map (nrows => nrows)
    port map (clk        => clk,
              alrst      => alrst,
              l1_rden    => l1_rden,
              l1_raddr   => l1_raddr,
              l1_din     => l1_din,
              l1_vin     => l1_vin,
              ve_datain  => ve_datain,
              ve_validin => ve_validin,
              ve_req     => ve_req,
              ve_ack     => ve_ack,
              osync      => osync,
              isync      => isync,
              ivfwd      => ivfwd,
              idfwd      => idfwd,
              ovfwd      => ovfwd,
              odfwd      => odfwd);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
    begin
        -- Reset generation
        -- EDIT: Check that alrst is really your reset signal
        alrst <= '0';
        wait for 100 ns;
        alrst <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_column_processor of tb_column_processor is
    for tb
    end for;
end cfg_tb_column_processor;
