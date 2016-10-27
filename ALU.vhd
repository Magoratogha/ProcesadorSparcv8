library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity ALU is
    Port ( c : in  STD_LOGIC;
			  operando1 : in  STD_LOGIC_VECTOR (31 downto 0);
           operando2 : in  STD_LOGIC_VECTOR (31 downto 0);
           aluOP : in  STD_LOGIC_VECTOR (5 downto 0);
           AluResult : out  STD_LOGIC_VECTOR (31 downto 0));
end ALU;

architecture arqALU of ALU is

begin

	process(operando1,operando2,aluOP)
	begin
	   case aluOP is 
			when "000000" => -- add
				AluResult <= operando1 + operando2;
			when "000001" => -- sub
				AluResult <= operando1 - operando2;
			when "000010" => -- or
				AluResult <= operando1 or operando2;
			when "000011" => -- and
				AluResult <= operando1 and operando2;
			when "000100" => -- xor
				AluResult <= operando1 xor operando2;
			when "000101" => -- orn
				AluResult <= operando1 or not(operando2);
			when "000110" => -- andn
				AluResult <= operando1 and not(operando2);
			when "000111" => --xnor
				AluResult <= operando1 xnor operando2;
				
			when "001000" => -- ADDcc
				AluResult <= operando1 + operando2;
			when "001001" => -- SUBcc
				AluResult <= operando1 - operando2;
			when "001010" => -- ADDx
				AluResult <= operando1 + operando2 + c;
			when "001011" => -- ADDxcc
				AluResult <= operando1 + operando2 + c;
			when "001100" => -- SUBx
				AluResult <= operando1 - operando2 - c;
			when "001101" => -- SUBxcc
				AluResult <= operando1 - operando2 - c;
			when "001110" => -- ORcc
				AluResult <= operando1 or operando2;
			when "001111" => -- ANDcc
				AluResult <= operando1 and operando2;
			when "010000" => -- XORcc
				AluResult <= operando1 xor operando2;
			when "010001" => -- ANDNcc
				AluResult <= operando1 and not(operando2);
			when "010010" => -- ORNcc
				AluResult <= operando1 or not(operando2);
			when "010011" => -- XNORcc
				AluResult <= operando1 xnor operando2;					
				
			when others => -- Cae el nop
				AluResult <= "00000000000000000000000000000000";
		end case;
	end process;
end arqALU;
