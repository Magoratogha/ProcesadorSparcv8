
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity Sumador is
    Port ( constante : in  STD_LOGIC_VECTOR (31 downto 0);
           data : in  STD_LOGIC_VECTOR (31 downto 0);
           data_out : out  STD_LOGIC_VECTOR (31 downto 0));
end Sumador;

architecture Behavioral of Sumador is

--signal constante: std_logic_vector(31 downto 0):= "00000000000000000000000000000100";
--signal aux: std_logic_vector(31 downto 0):=(others=>'0');

begin
	process (data)
		begin
			data_out<=data+constante;
	end process;

end Behavioral;

