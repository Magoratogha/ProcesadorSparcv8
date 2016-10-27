library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PSR is
    Port ( CLK : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           nzvc : in  STD_LOGIC_VECTOR (3 downto 0);
           nCWP : in  STD_LOGIC;
           CWP : out  STD_LOGIC;
			  c: out STD_LOGIC);
end PSR;

architecture ARQ_PSR of PSR is

begin
	process(CLK, Reset, nzvc, nCWP)
	begin
	
		if(Reset = '1') then
			CWP <= '0';
			c <= '0';
		
		else
			if(rising_edge(CLK)) then
				CWP <= nCWP;
				c <= nzvc(0);
			end if;
		end if;
	end process;
	
end ARQ_PSR;


