library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity silly_test is
port (
    clk: in std_logic;
    rst: in std_logic;
    din: in std_logic_vector (15 downto 0);
    dout: out std_logic_vector (15 downto 0);
    vin: in std_logic;
    vout: out std_logic
);
end silly_test;

architecture Behavioral of silly_test is
    signal vin_latched: std_logic;
    signal din_latched: std_logic_vector (15 downto 0);

    signal vout_next: std_logic;
    signal dout_next: std_logic_vector (15 downto 0);

    component sigmoidfull is
    port (
        clk: in std_logic;
        rst: in std_logic;
        datain: in std_logic_vector (15 downto 0);
        validin: in std_logic;
        dataout: out std_logic_vector (15 downto 0);
        validout: out std_logic);
    end component sigmoidfull;

begin

input_register: process (clk, rst) is
    begin
        if (rising_edge(clk)) then
            if (rst = '0') then
                vin_latched <= '0';
                din_latched <= (others => '0');
                vout <= '0';
                dout <= (others => '0');
            else
                vin_latched <= vin;
                din_latched <= din;
                vout <= vout_next;
                dout <= dout_next;
            end if;
        end if;
    end process;

activate: sigmoidfull
port map (
    clk => clk,
    rst => rst,
    datain => din_latched,
    validin => vin_latched,
    dataout => dout_next,
    validout => vout_next
);

end Behavioral;
