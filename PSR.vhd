library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PSR is
    Port ( nzvc : in  STD_LOGIC_VECTOR (3 downto 0);
           reset : in  STD_LOGIC;
           clk : in  STD_LOGIC;
			  ncwp: in STD_LOGIC;
			  icc : out STD_LOGIC_VECTOR (3 downto 0);
           carry : out  STD_LOGIC;
			  cwp : out STD_LOGIC);
end PSR;

architecture Behavioral of PSR is

begin

	process(reset,clk,nzvc,ncwp)
	begin
		if reset='1' then
			carry <= '0';
		else
			if rising_edge(clk) then
				carry<=nzvc(0);
				icc <= nzvc;
				cwp<=ncwp;
			end if;
		end if;
	end process;
	

end Behavioral;

