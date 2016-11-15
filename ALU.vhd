
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--ALU soporta las siguientes operaciones

-- ADD : 000000
-- SUB : 000001
-- AND : 000010
-- ANDN (op1 and not op2) : 000011
-- OR : 000100
-- ORN : 000101
-- XOR : 000110
-- XNOR : 000111

-- SUBcc: 001000
-- SUBx : 001001
-- SUBxcc: 001010
-- ANDcc : 001011
-- ANDNcc : 001100
-- ORcc : 001101
-- ORNcc : 001110
-- XORcc : 001111
-- XNORcc : 010000
-- ADDx : 010001
-- ADDxcc : 010010
-- ADDcc : 010011

entity ALU is
    Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
           B : in  STD_LOGIC_VECTOR (31 downto 0);
			  ALUOP : in  STD_LOGIC_VECTOR (5 downto 0);
			  Carry : in STD_LOGIC;
           Salida : out  STD_LOGIC_VECTOR (31 downto 0) := (others => '0'));
end ALU;

architecture Behavioral of ALU is

begin

process(ALUOP,A,B)
	begin
		case ALUOP is
		
			when 	"000000" => --ADD
				Salida <= A + B;
			
			when 	"000001" => --SUB
				Salida <= A - B;
				
			when 	"000010" => --AND
				Salida <= A and B;
										
			when 	"000011" => --ANDN
				Salida <= A and not B;
			
			when 	"000100" => --OR
				Salida <= A or B;
										
			when 	"000101" => --ORN
				Salida <= A or not B;
			
			when 	"000110" => --XOR
				Salida <= A xor B;
										
			when 	"000111" => --XNOR
				Salida <= A xnor B;
			
			when 	"001000" => --SUBcc
				Salida <= A - B;
			
			when 	"001001" => -- SUBx
				Salida <= A - B - Carry;
			
			when 	"001010" => --SUBxcc
				Salida <= A - B - Carry;
			
			when 	"001011" => --ANDcc
				Salida <= A and B;
			
			when 	"001100" => --ANDNcc
				Salida <= A and not B;
			
			when 	"001101" => --ORcc
				Salida <= A or B;
			
			when 	"001110" => --ORNcc
				Salida <= A or not B;
			
			when 	"001111" => --XORcc
				Salida <= A xor B;
			
			when 	"010000" => --XNORcc
				Salida <= A xnor B;
			
			when 	"010001" => --ADDx
				Salida <= A + B + Carry;
			
			when 	"010010" => --ADDxcc
				Salida <= A + B + Carry;
			
			when 	"010011" => --ADDcc 
				Salida <= A + B;
				
			when others =>
				Salida <= (others=>'1'); --error
			
			end case;

	end process;	

end Behavioral;

