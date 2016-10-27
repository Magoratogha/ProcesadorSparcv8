library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PSRModifier is
	Port (
			rst : in STD_LOGIC;
			aluResult : in STD_LOGIC_VECTOR (31 downto 0);
			operando1 : in STD_LOGIC_VECTOR (31 downto 0);
			operando2 : in STD_LOGIC_VECTOR (31 downto 0);
			aluOp : in STD_LOGIC_VECTOR (5 downto 0);
			nzvc : out STD_LOGIC_VECTOR (3 downto 0)
	);
end PSRModifier;

architecture Arq_PSRM of PSRModifier is

	begin
		process(aluResult,operando1,operando2,aluOp,rst)
		begin
		
		if(rst = '1') then
			nzvc <= "0000";
		else
			--ANDcc, ANDNcc, ORcc, ORNcc, XORcc, XNORcc
			if(aluOp = "001111" or aluOp = "010001" or aluOp ="001110" or aluOp ="010010" or aluOp ="010000" or aluOp ="010011")then
				nzvc(3) <= aluResult(31); --n 
				if(aluResult = "00000000000000000000000000000000")then
					nzvc(2) <= '1'; --z
				else
					nzvc(2) <= '0'; --z
				end if;
			nzvc(1) <='0'; --v
			nzvc(0) <= '0'; --c
			end if;
			
			--ADDcc, ADDxcc
			if(aluOp = "001000" or aluOp ="001011")then
				nzvc(3) <= aluResult(31); --n
				if(aluResult = "00000000000000000000000000000000")then
					nzvc(2) <= '1'; --z
				else
					nzvc(2) <= '0'; --z
				end if;
				nzvc(1) <= ((operando1(31) and operando2(31) and (not aluResult(31))) or ((not operando1(31)) and (not operando2(31)) and aluResult(31))); --v
				nzvc(0) <= (operando1(31) and operando2(31)) or ((not aluResult(31)) and (operando1(31) or operando2(31))); --c
			end if; 
			
			--SUBcc, SUBxcc
			if(aluOp = "001001" or aluOp = "001101")then
				nzvc(3) <= aluResult(31); --n
				if(aluResult = "00000000000000000000000000000000")then
					nzvc(2) <= '1'; --z
				else
					nzvc(2) <= '0'; --z
				end if;
				nzvc(1) <= ((operando1(31) and(not operando2(31)) and (not aluResult(31))) or (not operando1(31) and operando2(31) and aluResult(31))); --v
				nzvc(0) <= ((not operando1(31)) and operando2(31)) or (aluResult(31) and ((not operando1(31)) or operando2(31))); --c
			end if;
		end if;
		end process;
end Arq_PSRM;

