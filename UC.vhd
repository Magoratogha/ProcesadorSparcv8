library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity UC is
    Port ( 
			  op : in  STD_LOGIC_VECTOR (1 downto 0);
			  op2 : in  STD_LOGIC_VECTOR (2 downto 0);
           op3 : in  STD_LOGIC_VECTOR (5 downto 0);
			  cond : in  STD_LOGIC_VECTOR (3 downto 0);
			  icc : in  STD_LOGIC_VECTOR (3 downto 0);
			  RdEnMem : out STD_LOGIC;
			  RfDest : out  STD_LOGIC;
			  RfSource : out  STD_LOGIC_VECTOR (1 downto 0);
			  PcSource : out STD_LOGIC_VECTOR (1 downto 0);
			  WrEnMem : out  STD_LOGIC;
			  WrEnRF : out  STD_LOGIC;
           ALUOP : out  STD_LOGIC_VECTOR (5 downto 0):= (others => '0'));
end UC;

architecture arqUC of UC is

begin
	process(op, op2, op3, cond, icc)
	begin
			if(op = "01")then --CALL
				PcSource <= "01"; 
				WrEnRF <= '1'; 
				RfSource <= "10"; -- PC
				RdEnMem <= '1';
				RfDest <= '1'; -- r[15]
				WrEnMem <= '0';
				ALUOP <= "111111"; 
			
--#########################################################################################				
			
			elsif(op = "00")then
				if(op2 = "010")then -- BRANCH
					case cond is
						when "1000" => -- Branch Always
							PcSource <= "10"; -- Se salta a PC + (4 x seu(disp22)) 
							WrEnRF <= '0';
							RdEnMem <= '1';
							RfSource <= "00"; 
							RfDest <= '0'; 
							WrEnMem <= '0'; 
							ALUOP <= "111111";
						
						when "1001" => -- Branch on Not Equal
							if(not(icc(2)) = '1') then -- not Z
								PcSource <= "10"; -- Se salta a PC + (4 x seu(disp22))
								WrEnRF <= '0';
								RdEnMem <= '1';
								RfSource <= "00"; 
								RfDest <= '0'; 
								WrEnMem <= '0';
								ALUOP <= "111111";
							else
								PcSource <= "11"; -- Se salta a PC + 4
								WrEnRF <= '0';
								RdEnMem <= '1';
								RfSource <= "00"; 
								RfDest <= '0'; 
								WrEnMem <= '0'; 
								ALUOP <= "111111";
							end if;
						
						when "0001" => -- Branch on Equal
							if(icc(2) = '1') then --  Z
								PcSource <= "10"; -- Se salta a PC + (4 x seu(disp22))
								WrEnRF <= '0';
								RdEnMem <= '1';
								RfSource <= "00"; 
								RfDest <= '0'; 
								WrEnMem <= '0';
								ALUOP <= "111111";
							else
								PcSource <= "11"; -- Se salta a PC + 4
								WrEnRF <= '0';
								RdEnMem <= '1';
								RfSource <= "00";
								RfDest <= '0'; 
								WrEnMem <= '0';
								ALUOP <= "111111";
							end if;
							
						when "1010" => -- Branch on Greater
							if((not(icc(2) or (icc(3) xor icc(1)))) = '1') then -- not(Z or (N xor V))
								PcSource <= "10"; -- Se salta a PC + (4 x seu(disp22))
								WrEnRF <= '0';
								RdEnMem <= '1';
								RfSource <= "00"; 
								RfDest <= '0'; 
								WrEnMem <= '0'; 
								ALUOP <= "111111";
							else
								PcSource <= "11"; -- Se salta a PC + 4
								WrEnRF <= '0';
								RdEnMem <= '1';
								RfSource <= "00"; 
								RfDest <= '0';
								WrEnMem <= '0';
								ALUOP <= "111111";
							end if;
							
						when "0010" => -- Branch on Less or Equal
							if((icc(2) or (icc(3) xor icc(1))) = '1') then -- Z or (N xor V)
								PcSource <= "10"; -- Salta a PC + (4 x seu(disp22))
								WrEnRF <= '0';
								RdEnMem <= '1';
								RfSource <= "00"; 
								RfDest <= '0'; 
								WrEnMem <= '0'; 
								ALUOP <= "111111";
							else
								PcSource <= "11"; -- Se salta a PC + 4
								WrEnRF <= '0';
								RdEnMem <= '1';
								RfSource <= "00";
								RfDest <= '0'; 
								WrEnMem <= '0';
								ALUOP <= "111111";
							end if;
						
						when "1011" => -- Branch on Greater or Equal
							if((not(icc(3) xor icc(1))) = '1') then -- not (N xor V)
								PcSource <= "10"; -- Se salta a PC + (4 x seu(disp22))
								WrEnRF <= '0';
								RdEnMem <= '1';
								RfSource <= "00"; 
								RfDest <= '0'; 
								WrEnMem <= '0';
								ALUOP <= "111111";
							else
								PcSource <= "11"; -- Se salta a PC + 4
								WrEnRF <= '0';
								RdEnMem <= '1';
								RfSource <= "00";
								RfDest <= '0'; 
								WrEnMem <= '0'; 
								ALUOP <= "111111";
							end if;
						
						when "0011" => -- Branch on Less
							if((icc(3) xor icc(1)) = '1') then -- (N xor V)
								PcSource <= "10"; -- Se salta a PC + (4 x seu(disp22))
								WrEnRF <= '0';
								RdEnMem <= '1';
								RfSource <= "00";
								RfDest <= '0'; 
								WrEnMem <= '0';
								ALUOP <= "111111";
							else
								PcSource <= "11"; -- Se salta a PC + 4
								WrEnRF <= '0';
								RdEnMem <= '1';
								RfSource <= "00"; 
								RfDest <= '0'; 
								WrEnMem <= '0';
								ALUOP <= "111111";
							end if;
						
						when others => 
								PcSource <= "00";
								WrEnRF <= '0';
								RdEnMem <= '1';
								RfSource <= "00";
								RfDest <= '0'; -- r[15]
								WrEnMem <= '0'; 
								ALUOP <= "111111";
					end case;
					
				elsif(op2 = "100")then -- NOP
					PcSource <= "11"; -- Se salta a PC + 4
					WrEnRF <= '0'; -- Se guarda en el Register File el valor de 
					RfSource <= "01"; -- Debe ser el resultado de la operacion
					RfDest <= '0'; -- No importa este Valor pues no se permitira escritura en el Register File
					WrEnMem <= '0'; -- El dato es leido de memoria pero no se toma en cuenta
					ALUOP <= "111111";
					RdEnMem <= '1';
				end if;

--#########################################################################################		
				
			elsif(op = "10") then				
					case op3 is
						when "000000" => -- ADD
							PcSource <= "11"; -- Se salta a PC + 4
							WrEnRF <= '1'; -- Se guarda en el Register File el valor de la Operacion
							RfSource <= "01"; -- Debe ser el resultado de la operacion
							RfDest <= '0'; 
							WrEnMem <= '0'; 
							ALUOP <= "000000";
							RdEnMem <= '1';
						
						when "000100" => -- SUB
							PcSource <= "11"; -- Se salta a PC + 4
							WrEnRF <= '1'; 
							RfSource <= "01";
							RfDest <= '0'; 
							WrEnMem <= '0';
							ALUOP <= "000001";
							RdEnMem <= '1';
							
						when "000010" => -- OR
							PcSource <= "11"; -- Se salta a PC + 4
							WrEnRF <= '1'; 
							RfSource <= "01";
							RfDest <= '0'; 
							WrEnMem <= '0';
							ALUOP <= "000010";
							RdEnMem <= '1';
						
						when "000001" => -- AND
							PcSource <= "11"; -- Se salta a PC + 4
							WrEnRF <= '1'; 
							RfSource <= "01";
							RfDest <= '0'; 
							WrEnMem <= '0';
							ALUOP <= "000011";
							RdEnMem <= '1';
						
						when "000011" => -- XOR
							PcSource <= "11"; -- Se salta a PC + 4
							WrEnRF <= '1'; 
							RfSource <= "01";
							RfDest <= '0'; 
							WrEnMem <= '0';
							ALUOP <= "000100";
							RdEnMem <= '1';
						
						when "000110" => -- ORN
							PcSource <= "11"; -- Se salta a PC + 4
							WrEnRF <= '1'; 
							RfSource <= "01";
							RfDest <= '0'; 
							WrEnMem <= '0';
							ALUOP <= "000101";
							RdEnMem <= '1';
						
						when "000101" => -- ANDN
							PcSource <= "11"; -- Se salta a PC + 4
							WrEnRF <= '1'; 
							RfSource <= "01";
							RfDest <= '0'; 
							WrEnMem <= '0';
							ALUOP <= "000110";
							RdEnMem <= '1';
						
						when "000111" => -- XNOR
							PcSource <= "11"; -- Se salta a PC + 4
							WrEnRF <= '1'; 
							RfSource <= "01";
							RfDest <= '0'; 
							WrEnMem <= '0';
							ALUOP <= "000111";
							RdEnMem <= '1';
															
						when "010000" => -- ADDcc
							PcSource <= "11"; -- Se salta a PC + 4
							WrEnRF <= '1'; 
							RfSource <= "01";
							RfDest <= '0'; 
							WrEnMem <= '0';
							ALUOP <= "001000";
							RdEnMem <= '1';
						
						when "010100" => -- SUBcc
							PcSource <= "11"; -- Se salta a PC + 4
							WrEnRF <= '1'; 
							RfSource <= "01";
							RfDest <= '0'; 
							WrEnMem <= '0';
							ALUOP <= "001001";
							RdEnMem <= '1';
						
						when "001000" => -- ADDx
							PcSource <= "11"; -- Se salta a PC + 4
							WrEnRF <= '1'; 
							RfSource <= "01";
							RfDest <= '0'; 
							WrEnMem <= '0';
							ALUOP <= "001010";
							RdEnMem <= '1';
						
						when "011000" => -- ADDxcc
							PcSource <= "11"; -- Se salta a PC + 4
							WrEnRF <= '1'; 
							RfSource <= "01";
							RfDest <= '0'; 
							WrEnMem <= '0';
							ALUOP <= "001011";
							RdEnMem <= '1';
						
						when "001100" => -- SUBx
							PcSource <= "11"; -- Se salta a PC + 4
							WrEnRF <= '1'; 
							RfSource <= "01";
							RfDest <= '0'; 
							WrEnMem <= '0';
							ALUOP <= "001100";
							RdEnMem <= '1';
						
						when "011100" => -- SUBxcc
							PcSource <= "11"; -- Se salta a PC + 4
							WrEnRF <= '1'; 
							RfSource <= "01";
							RfDest <= '0'; 
							WrEnMem <= '0';
							ALUOP <= "001101";
							RdEnMem <= '1';
						
						when "010010" => -- ORcc
							PcSource <= "11"; -- Se salta a PC + 4
							WrEnRF <= '1'; 
							RfSource <= "01";
							RfDest <= '0'; 
							WrEnMem <= '0';
							ALUOP <= "001110";
							RdEnMem <= '1';
						
						when "010001" => -- ANDcc
							PcSource <= "11"; -- Se salta a PC + 4
							WrEnRF <= '1'; 
							RfSource <= "01";
							RfDest <= '0'; 
							WrEnMem <= '0';
							ALUOP <= "001111";
							RdEnMem <= '1';
						
						when "010011" => -- XORcc
							PcSource <= "11"; -- Se salta a PC + 4
							WrEnRF <= '1'; 
							RfSource <= "01";
							RfDest <= '0'; 
							WrEnMem <= '0';
							ALUOP <= "010000";
							RdEnMem <= '1';
						
						when "010101" => -- ANDNcc
							PcSource <= "11"; -- Se salta a PC + 4
							WrEnRF <= '1'; 
							RfSource <= "01";
							RfDest <= '0'; 
							WrEnMem <= '0';
							ALUOP <= "010001";
							RdEnMem <= '1';
						
						when "010110" => -- ORNcc
							PcSource <= "11"; -- Se salta a PC + 4
							WrEnRF <= '1'; 
							RfSource <= "01";
							RfDest <= '0'; 
							WrEnMem <= '0';
							ALUOP <= "010010";
							RdEnMem <= '1';
						
						when "010111" => -- XNORcc
							PcSource <= "11"; -- Se salta a PC + 4
							WrEnRF <= '1'; 
							RfSource <= "01";
							RfDest <= '0'; 
							WrEnMem <= '0';
							ALUOP <= "010011";
							RdEnMem <= '1';
							
						when "111100" => -- SAVE
							PcSource <= "11"; -- Se salta a PC + 4
							WrEnRF <= '1'; 
							RfSource <= "01";
							RfDest <= '0'; 
							WrEnMem <= '0';
							ALUOP <= "000000"; -- El save es igual a un add pero modifica CWP
							RdEnMem <= '1';
								
						when "111101" => -- RESTORE
							PcSource <= "11"; -- Se salta a PC + 4
							WrEnRF <= '1'; 
							RfSource <= "01"; 
							RfDest <= '0'; 
							WrEnMem <= '0';
							ALUOP <= "000000"; -- El restore es igual a un add pero modifica CWP
							RdEnMem <= '1';
							
						when "111000" => -- JMPL
							PcSource <= "00"; -- Se salta a la dirección calculada.
							WrEnRF <= '1'; -- Se guarda en el Register File el valor del PC
							RfSource <= "10"; -- Debe ser el valor del PC
							RfDest <= '0'; -- Debe ser el valor de nRD
							WrEnMem <= '0';
							ALUOP <= "000000"; -- Se deben sumar los dos operandos que entren a la ALU que determinan la dirección del salto
							RdEnMem <= '1';
							
						when others => 
							PcSource <= "11"; 
							WrEnRF <= '0'; 
							RfSource <= "01";
							RfDest <= '0'; 
							WrEnMem <= '0';
							ALUOP <= "111111";
							RdEnMem <= '1';
					end case;	
			end if;
	end process;

end arqUC;