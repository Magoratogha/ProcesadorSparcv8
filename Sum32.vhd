library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity Sum32 is
    Port ( op1 : in  STD_LOGIC_VECTOR (31 downto 0);
           op2 : in  STD_LOGIC_VECTOR (31 downto 0);
           res : out  STD_LOGIC_VECTOR (31 downto 0):= (others => '0'));
end Sum32;

architecture arqSum32 of Sum32 is

begin
	process(op1,op2)
		begin
			res <= op1 + op2;
	end process;

end arqSum32;