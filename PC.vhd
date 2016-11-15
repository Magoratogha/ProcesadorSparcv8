library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH;
use IEEE.STD_LOGIC_UNSIGNED;

entity ProgramCounter is
    Port ( clk : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           InAddress : in  STD_LOGIC_VECTOR (31 downto 0);
           OutAddress : out  STD_LOGIC_VECTOR (31 downto 0):= (others => '0'));
end ProgramCounter;

architecture Behavioral of ProgramCounter is

begin

	process(clk,Reset)

	begin

		if Reset = '1' then 
			OutAddress <= "00000000000000000000000000000000";
		elsif rising_edge(clk) then 
			OutAddress <= InAddress;
			
		end if;
	end process;




end Behavioral;

