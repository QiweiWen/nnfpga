-- Testbench automatically generated online
-- at http://vhdl.lapinoo.net
-- Generation date : 1.5.2018 06:32:08 GMT

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library ieee_proposed;
use ieee_proposed.fixed_pkg.all;

use ieee.math_real.all;

use work.helperpkg.all;

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
              ve_ack     : in std_logic;
              ve_req      : out std_logic;
              dataout    : out std_logic_vector (31 downto 0);
              validout   : out std_logic;
              fvalid     : out std_logic;
              validfwd   : out std_logic;
              datafwd    : out std_logic_vector (15 downto 0));
    end component;
    
    constant data_width : integer := 16;
    component std_fifo is
        generic (
            constant data_width  : positive := 8;
            constant fifo_depth	: positive := 256
        );
        port ( 
            clk		: in  std_logic;
            rst		: in  std_logic;
            writeen	: in  std_logic;
            datain	: in  std_logic_vector (data_width - 1 downto 0);
            readen	: in  std_logic;
            dataout	: out std_logic_vector (data_width - 1 downto 0);
            ackout  : out std_logic;
            validout: out std_logic;
            empty	: out std_logic;
            full	: out std_logic
        );
    end component std_fifo;

    component three_port_ram is
        generic (
            width: integer := 16;
            depth: integer := 128
        );
        port (
            clk: in std_logic;
            alrst: in std_logic;
            -- read port A
            re_a: in std_logic;
            addr_a: in integer range 0 to depth - 1;
            vout_a: out std_logic;
            dout_a: out std_logic_vector (width - 1 downto 0); 
            -- read port B
            re_b: in std_logic;
            addr_b: in integer range 0 to depth - 1;
            vout_b: out std_logic;
            dout_b: out std_logic_vector (width - 1 downto 0); 
            -- write port C
            addr_c: in integer range 0 to depth - 1;
            vin_c: in std_logic;
            din_c: in std_logic_vector (width - 1 downto 0)
        );
    end component three_port_ram;
    
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
    signal ve_req     : std_logic;
    signal ve_ack     : std_logic;
    signal dataout    : std_logic_vector (31 downto 0);
    signal validout   : std_logic;
    signal validfwd   : std_logic;
    signal datafwd    : std_logic_vector (15 downto 0);
    signal fvalid     : std_logic;

    -- l1 cache signals
    signal re_a: std_logic;
    signal addr_a: integer range 0 to ncols - 1;
    signal vout_a: std_logic;
    signal dout_a: std_logic_vector (16 - 1 downto 0); 
    signal re_b: std_logic;
    signal addr_b: integer range 0 to ncols - 1;
    signal vout_b: std_logic;
    signal dout_b: std_logic_vector (16 - 1 downto 0); 
    signal addr_c: integer range 0 to ncols - 1;
    signal vin_c: std_logic;
    signal din_c: std_logic_vector (16 - 1 downto 0);

    --fifo signals
    signal writeen	:   std_logic;
    signal datain	:   std_logic_vector (data_width - 1 downto 0);
    signal readen	:   std_logic;
    signal fifo_dataout	:  std_logic_vector (data_width - 1 downto 0);
    signal ackout  :  std_logic;
    signal fifo_validout:  std_logic;
    signal empty	:  std_logic;
    signal full	:  std_logic;

    

    signal debug_product_latch: real; 

    constant TbPeriod : time := 100 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';
    
    subtype param_type is std_logic_vector (15 downto 0);

begin

    debug:
    process (clk, alrst) is
    begin
        if (rising_edge(clk)) then
            if (alrst = '0') then
                debug_product_latch <= 0.0; 
            else
                if (validout = '1') then
                    debug_product_latch <= 
                        to_real(to_sfixed(dataout, 2*PARAM_DEC - 1, -2*PARAM_FRC));
                end if;
            end if;
        end if;
    end process;

    -- connect row processor to channel A
    re_a <= l1_rden;
    addr_a <= l1_raddr;
    l1_din  <= dout_a;
    l1_vin  <= vout_a;

    ve_ack <= ackout;
    readen <= ve_req;
    ve_datain <= fifo_dataout;
    ve_validin <= fifo_validout;

    dut_fifo: std_fifo
    generic map (data_width => 16)
    port map (
        clk	 => clk,
        rst	 => alrst,
        writeen	 => writeen,
        datain	 => datain,
        readen	 => readen,
        dataout	 => fifo_dataout,
        ackout   => ackout,
        validout => fifo_validout,
        empty	 => empty,
        full	 => full);

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
              ve_ack     => ve_ack,
              ve_req     => ve_req,
              dataout    => dataout,
              validout   => validout,
              fvalid     => fvalid,
              validfwd   => validfwd,
              datafwd    => datafwd);

    dut_ram : three_port_ram 
    generic map (depth => ncols)
    port map (
        clk => clk,
        alrst => alrst,
        -- read port A
        re_a => re_a,
        addr_a => addr_a,
        vout_a => vout_a,
        dout_a => dout_a,
        -- read port B
        re_b => re_b,
        addr_b => addr_b,
        vout_b => vout_b,
        dout_b => dout_b,
        -- write port C
        addr_c => addr_c,
        vin_c => vin_c,
        din_c => din_c 
    );

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
    begin
        re_b <= '0';
        addr_b <= 0;
        vin_c <= '0';
        din_c <= (others => '0');
        addr_c <= 0;

        -- Reset generation
        alrst <= '0';
        wait for 100 ns;
        alrst <= '1';
        wait for 100 ns;

        -- initial value
        vin_c <= '1';
        for i in 0 to ncols - 1 loop
            addr_c <= i;
            din_c <= param_type(to_sfixed (i, PARAM_DEC - 1, -PARAM_FRC)); 
            wait for 100 ns;
        end loop;
        vin_c <= '0';
        
        -- multiplication test
        writeen <= '1';
        for i in 0 to 7 loop
            datain <= param_type(to_sfixed (i, PARAM_DEC - 1, -PARAM_FRC));
            wait for 100 ns;
        end loop;

        writeen <= '0';
        wait for 500 ns;
            
        writeen <= '1';
        for i in 0 to 1 loop
            datain <= param_type(to_sfixed (i, PARAM_DEC - 1, -PARAM_FRC));
            wait for 100 ns;
        end loop;

        writeen <= '0';

        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_row_processor of tb_row_processor is
    for tb
    end for;
end cfg_tb_row_processor;
