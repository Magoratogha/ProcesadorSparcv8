
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity MUXRF is
    Port ( a : in  STD_LOGIC_VECTOR (5 downto 0);
           b : in  STD_LOGIC_VECTOR (5 downto 0);
           sel : in  STD_LOGIC;
           salida : out  STD_LOGIC_VECTOR (5 downto 0));
end MUXRF;

architecture Behavioral of MUXRF is

begin
process(sel,a,b)
	begin
		if (sel='0') then --saca RD
			salida <= a;
		elsif (sel='1') then --saca %O7
			salida <= b;
		end if;
end process;

end Behavioral;

