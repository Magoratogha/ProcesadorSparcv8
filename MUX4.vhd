library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX4 is
    Port ( 
				op1 : in  STD_LOGIC_VECTOR (31 downto 0);
				op2 : in  STD_LOGIC_VECTOR (31 downto 0);
				op3 : in  STD_LOGIC_VECTOR (31 downto 0);
				op4 : in  STD_LOGIC_VECTOR (31 downto 0);
				hab : in  STD_LOGIC_VECTOR (1 downto 0);
				Salida : out  STD_LOGIC_VECTOR (31 downto 0));
end MUX4;

architecture ARQ_MUX4 of MUX4 is

begin
	
	process(hab, op1, op2, op3, op4)
	begin
		
		case hab is
			when "00" =>
				Salida <= op1;
			when "01" =>
				Salida <= op2;
			when "11" =>
				Salida <= op3;
			when "10" =>
				Salida <= op4;
			when others =>
				Salida <= (others =>'0');
		end case;
	end process;
	
end ARQ_MUX4;

