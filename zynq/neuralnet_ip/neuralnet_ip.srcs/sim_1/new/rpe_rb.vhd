-- Testbench automatically generated online
-- at http://vhdl.lapinoo.net
-- Generation date : 1.5.2018 06:32:08 GMT

library ieee;
use ieee.std_logic_1164.all;

entity tb_row_processor is
end tb_row_processor;

architecture tb of tb_row_processor is

    component row_processor
        generic (
            ncols: integer := 100
        );
        port (clk        : in std_logic;
              alrst      : in std_logic;
              l1_rden    : out std_logic;
              l1_raddr   : out integer;
              l1_din     : in std_logic_vector (15 downto 0);
              l1_vin     : in std_logic;
              ve_datain  : in std_logic_vector (15 downto 0);
              ve_validin : in std_logic;
              dataout    : out std_logic_vector (15 downto 0);
              validout   : out std_logic;
              finished   : out std_logic;
              validfwd   : out std_logic;
              datafwd    : out std_logic_vector (15 downto 0));
    end component;

    component ram_wrapper
        generic (
            depth: integer := 128
        );
        port (clk      : in std_logic;
              alrst    : in std_logic;
              update   : in std_logic;
              write    : in std_logic;
              rden_a   : in std_logic;
              rdaddr_a : in integer;
              dout_a   : out std_logic_vector (15 downto 0);
              vout_a   : out std_logic;
              rden_b   : in std_logic;
              rdaddr_b : in integer;
              dout_b   : out std_logic_vector (15 downto 0);
              vout_b   : out std_logic;
              vin_c    : in std_logic;
              din_c    : in std_logic_vector (15 downto 0);
              wraddr_c : in integer;
              ack_c    : out std_logic);
    end component;
    
    constant ncols : integer := 5; 
    
    signal clk        : std_logic;
    signal alrst      : std_logic;
    -- row processor signals
    signal l1_rden    : std_logic;
    signal l1_raddr   : integer;
    signal l1_din     : std_logic_vector (15 downto 0);
    signal l1_vin     : std_logic;
    signal ve_datain  : std_logic_vector (15 downto 0);
    signal ve_validin : std_logic;
    signal dataout    : std_logic_vector (15 downto 0);
    signal validout   : std_logic;
    signal finished   : std_logic;
    signal validfwd   : std_logic;
    signal datafwd    : std_logic_vector (15 downto 0);

    -- l1 cache signals
    signal update   : std_logic;
    signal write    : std_logic;
    signal rden_a   : std_logic;
    signal rdaddr_a : integer;
    signal dout_a   : std_logic_vector (15 downto 0);
    signal vout_a   : std_logic;
    signal rden_b   : std_logic;
    signal rdaddr_b : integer;
    signal dout_b   : std_logic_vector (15 downto 0);
    signal vout_b   : std_logic;
    signal vin_c    : std_logic;
    signal din_c    : std_logic_vector (15 downto 0);
    signal wraddr_c : integer;
    signal ack_c    : std_logic;

    constant TbPeriod : time := 100 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut_pe : row_processor
    generic map (ncols   => ncols)
    port map (clk        => clk,
              alrst      => alrst,
              l1_rden    => l1_rden,
              l1_raddr   => l1_raddr,
              l1_din     => l1_din,
              l1_vin     => l1_vin,
              ve_datain  => ve_datain,
              ve_validin => ve_validin,
              dataout    => dataout,
              validout   => validout,
              finished   => finished,
              validfwd   => validfwd,
              datafwd    => datafwd);

    dut_ram : ram_wrapper
    generic map (depth => ncols)
    port map (clk      => clk,
              alrst    => alrst,
              update   => update,
              write    => write,
              rden_a   => rden_a,
              rdaddr_a => rdaddr_a,
              dout_a   => dout_a,
              vout_a   => vout_a,
              rden_b   => rden_b,
              rdaddr_b => rdaddr_b,
              dout_b   => dout_b,
              vout_b   => vout_b,
              vin_c    => vin_c,
              din_c    => din_c,
              wraddr_c => wraddr_c,
              ack_c    => ack_c);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
    begin
        -- TODO: add initialisation

        -- Reset generation
        alrst <= '0';
        wait for 100 ns;
        alrst <= '1';
        wait for 100 ns;

        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_row_processor of tb_row_processor is
    for tb
    end for;
end cfg_tb_row_processor;
