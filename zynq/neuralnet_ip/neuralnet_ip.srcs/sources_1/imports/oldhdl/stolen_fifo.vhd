-- stolen from deathbylogic.com

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity std_fifo is
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
end std_fifo;

architecture behavioral of std_fifo is

    signal validout_next: std_logic;
    signal sig_empty: std_logic;

begin
    -- delay readen and empty for one cycle to drive output valid flag
    validout_next <= '1' when readen = '1' and sig_empty = '0' else '0';
    ackout <= validout_next;
    vout_proc: process (clk, rst)
    begin
        if (rising_edge(clk)) then
            if (rst = '0') then
                validout <= '0';
            else
                validout <= validout_next;
            end if;
        end if;
    end process;
    
    empty <= sig_empty;
	-- memory pointer process
	fifo_proc : process (clk)
		type fifo_memory is array (0 to fifo_depth - 1) of std_logic_vector (data_width - 1 downto 0);
		variable memory : fifo_memory;
		
		variable head : natural range 0 to fifo_depth - 1;
		variable tail : natural range 0 to fifo_depth - 1;
		
		variable looped : boolean;
	begin
		if rising_edge(clk) then
			if rst = '0' then
				head := 0;
				tail := 0;
				
				looped := false;
				
				full  <= '0';
				sig_empty <=  '1';
			else
				if (readen = '1') then
					if ((looped = true) or (head /= tail)) then
						-- update data output
						dataout <= memory(tail);
						
						-- update tail pointer as needed
						if (tail = fifo_depth - 1) then
							tail := 0;
							
							looped := false;
						else
							tail := tail + 1;
						end if;
						
						
					end if;
				end if;
				
				if (writeen = '1') then
					if ((looped = false) or (head /= tail)) then
						-- write data to memory
						memory(head) := datain;
						
						-- increment head pointer as needed
						if (head = fifo_depth - 1) then
							head := 0;
							
							looped := true;
						else
							head := head + 1;
						end if;
					end if;
				end if;
				
				-- update empty and full flags
				if (head = tail) then
					if looped then
						full <= '1';
					else
						sig_empty <=  '1';
					end if;
				else
					sig_empty <=  '0';
					full	<= '0';
				end if;
			end if;
		end if;
	end process;
		
end Behavioral;
