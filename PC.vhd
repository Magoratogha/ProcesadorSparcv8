library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity PC is
    Port ( address : in  STD_LOGIC_VECTOR (31 downto 0);
           clk : in  STD_LOGIC;
			  reset : in  STD_LOGIC;
           nextInst : out  STD_LOGIC_VECTOR (31 downto 0):= (others => '0'));
end PC;

architecture arqPC of PC is

begin
	process(clk,reset)
	begin
		if(reset = '1')then
			nextInst <= (others=>'0');
		elsif rising_edge(clk) then
			nextInst <= address;
		end if;
	end process;
end arqPC;
