library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity EX_SIG2 is
    Port ( DATO : in  STD_LOGIC_VECTOR (21 downto 0);
           SALIDA : out  STD_LOGIC_VECTOR (31 downto 0):= (others => '0'));
end EX_SIG2;

architecture arqEX_SIG2 of EX_SIG2 is

begin
	process(DATO)
		begin
			if(DATO(21) = '1')then
				SALIDA<= "1111111111" & DATO;
			else
				SALIDA<= "0000000000" & DATO;
			end if;
	end process;
end arqEX_SIG2;
