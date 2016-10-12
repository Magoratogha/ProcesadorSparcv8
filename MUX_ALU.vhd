library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX_ALU is
    Port ( Crs2 : in  STD_LOGIC_VECTOR (31 downto 0);
           SEUOperando : in  STD_LOGIC_VECTOR (31 downto 0);
           habImm : in  STD_LOGIC;
           OperandoALU : out  STD_LOGIC_VECTOR (31 downto 0));
end MUX_ALU;

architecture arqMUX_ALU of MUX_ALU is

begin
	
	OperandoALU <= Crs2 when habImm ='0' else SEUOperando;
	
end arqMUX_ALU;
