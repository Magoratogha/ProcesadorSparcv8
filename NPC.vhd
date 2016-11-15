
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity nPC is
    Port ( reset : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           data : in  STD_LOGIC_VECTOR (31 downto 0);
           data_out : out  STD_LOGIC_VECTOR (31 downto 0));
end nPC;

architecture Behavioral of nPC is

signal aux: std_logic_vector(31 downto 0):=(others=>'0');

begin
	process(reset,clk,data)
	begin
		if reset='1' then
			data_out<=aux;
		else
			if rising_edge(clk) then
				data_out<=data;
			end if;
		end if;
	end process;

end Behavioral;

