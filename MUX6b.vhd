library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX6b is
    Port ( Crs2 : in  STD_LOGIC_VECTOR (5 downto 0);
           SEUOperando : in  STD_LOGIC_VECTOR (5 downto 0);
           habImm : in  STD_LOGIC;
           OperandoALU : out  STD_LOGIC_VECTOR (5 downto 0));
end MUX6b;

architecture arqMUX6b of MUX6b is

begin
	
	OperandoALU <= Crs2 when habImm ='0' else SEUOperando;
	
end arqMUX6b;
