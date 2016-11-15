
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity SEU is
    Port ( imm13 : in  STD_LOGIC_VECTOR (12 downto 0);
           imm32 : out  STD_LOGIC_VECTOR (31 downto 0));
end SEU;

architecture Behavioral of SEU is

signal aux1: std_logic_vector(18 downto 0):=(others=>'0');
signal aux2: std_logic_vector(18 downto 0):=(others=>'1');

begin

process(imm13)
	begin
	
		if(imm13(12) = '0') then 
			imm32 <= aux1 & imm13;
		else 
			imm32 <= aux2 & imm13;
		end if;
		
end process;
		
end Behavioral;

