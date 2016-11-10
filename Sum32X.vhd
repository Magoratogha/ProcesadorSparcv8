library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity Sum32X is
    Port ( op1 : in  STD_LOGIC_VECTOR (29 downto 0);
           op2 : in  STD_LOGIC_VECTOR (31 downto 0);
           res : out  STD_LOGIC_VECTOR (31 downto 0):= (others => '0'));
end Sum32X;

architecture arqSum32X of Sum32X is

begin
	process(op1,op2)
		begin
			if(op1(29) ='0') then
				res <= ("00" & op1) + op2;
			else 
				res <= ("11" & op1) + op2;
			end if;
	end process;

end arqSum32X;
