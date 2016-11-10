library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity DataMemory is
    Port ( 
				clk : in  STD_LOGIC;
				RdEnMem : in  STD_LOGIC;
				reset : in STD_LOGIC;
				cRD : in  STD_LOGIC_VECTOR (31 downto 0);
				address : in STD_LOGIC_VECTOR (31 downto 0);				
				WrEnMem : in  STD_LOGIC;
				DataToMem : out  STD_LOGIC_VECTOR (31 downto 0));
end DataMemory;

architecture ARQ_DataMemory of DataMemory is
	
	type ram_type is array (0 to 63) of std_logic_vector (31 downto 0);
	signal ramMemory : ram_type:=(others => x"00000000");

begin

	process(clk,reset,cRD,address,WrEnMem,RdEnMem)
	begin
		if(rising_edge(clk))then
			if(RdEnMem = '1') then
				if(reset = '1')then
					DataToMem <= (others => '0');
					ramMemory <= (others => x"00000000");
				else
					if(WrEnMem = '0')then
						DataToMem <= ramMemory(conv_integer(address(5 downto 0)));
					else
						ramMemory(conv_integer(address(5 downto 0))) <= cRD;
					end if;
				end if;
			end if;
		end if;
	end process;
	
end ARQ_DataMemory;
