
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_unsigned.all;
use std.textio.all;


entity DataMemory is
    Port ( reset : in  STD_LOGIC;
           cRD : in  STD_LOGIC_VECTOR (31 downto 0);
           addres : in  STD_LOGIC_VECTOR (4 downto 0);
           wrenmem : in  STD_LOGIC;
           datatomem : out  STD_LOGIC_VECTOR (31 downto 0));
end DataMemory;

architecture Behavioral of DataMemory is

type reg is array (0 to 31) of std_logic_vector (31 downto 0);

signal myReg: reg; 

begin
process(wrenmem,reset,addres,cRD)
	begin
		
		if(reset = '1') then 
			myReg <= (others => x"00000000");
		else
			if(wrenmem = '1') then --puede escribir, es un store
				Myreg(conv_integer(addres)) <= cRD;
			end if;
		end if;
		
		datatomem <= Myreg(conv_integer(addres));
			
end process;

end Behavioral;

