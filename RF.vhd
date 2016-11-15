
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;
use std.textio.all;


entity RF is
    Port ( rs1 : in  STD_LOGIC_VECTOR (5 downto 0);
           rs2 : in  STD_LOGIC_VECTOR (5 downto 0);
           rd : in  STD_LOGIC_VECTOR (5 downto 0);
			  dwr : in  STD_LOGIC_VECTOR (31 downto 0);
			  reset : in  STD_LOGIC;
           crs1 : out  STD_LOGIC_VECTOR (31 downto 0);
           crs2 : out  STD_LOGIC_VECTOR (31 downto 0);
			  cRD : out  STD_LOGIC_VECTOR (31 downto 0);
			  we : in std_logic);
end RF;

architecture Behavioral of RF is

type reg is array (0 to 39) of std_logic_vector (31 downto 0);


signal myReg: reg; 

begin
process(rs1,rs2,rd,dwr,reset)
	begin 
		myReg(0) <= x"00000000";
		if reset = '0' then
			if((rd/="00000") and (we = '1'))then
				Myreg(conv_integer(rd)) <= dwr; 
			end if;			
			crs1 <= Myreg(conv_integer(rs1));
			crs2 <= Myreg(conv_integer(rs2));
			cRD <= Myreg(conv_integer(rd));
		else
			myReg <= (others => x"00000000");
			crs1 <= (others => '0');
			crs2 <= (others => '0');
			cRD <= (others => '0');
		end if;
	end process;
		
end Behavioral;

