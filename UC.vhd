library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity UC is
    Port ( 
			  op : in  STD_LOGIC_VECTOR (1 downto 0);
           op3 : in  STD_LOGIC_VECTOR (5 downto 0);
           ALUOP : out  STD_LOGIC_VECTOR (5 downto 0):= (others => '0'));
end UC;

architecture arqUC of UC is

begin
	process(op, op3)
	begin
			if (op = "10") then				
					case op3 is
						when "000000" => -- ADD
							ALUOP <= "000000";
						when "000100" => -- SUB
							ALUOP <= "000001";
						when "000010" => -- OR
							ALUOP <= "000010";
						when "000001" => -- AND
							ALUOP <= "000011";
						when "000011" => -- XOR
							ALUOP <= "000100";
						when "000110" => -- ORN
							ALUOP <= "000101";
						when "000101" => -- ANDN
							ALUOP <= "000110";
						when "000111" => -- XNOR
							ALUOP <= "000111";
						when others => 
							ALUOP <= "111111";
					end case;	
			end if;
	end process;
end arqUC;