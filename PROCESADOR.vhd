library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PROCESADOR is
    Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           OUT : out  STD_LOGIC_VECTOR (31 downto 0));
end PROCESADOR;

architecture SPARCV8 of PROCESADOR is

	COMPONENT Main
		Port ( 
				Rst : in  STD_LOGIC;
				Clk : in  STD_LOGIC;
				ALUResult : out  STD_LOGIC_VECTOR (31 downto 0));
	END COMPONENT;

begin


end SPARCV8;

