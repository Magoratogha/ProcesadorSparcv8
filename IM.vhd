
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;
use std.textio.all;


entity instructionMemory is
    Port ( cont : in  STD_LOGIC_VECTOR (31 downto 0);
			  reset : in  STD_LOGIC;
           instruction : out STD_LOGIC_VECTOR (31 downto 0)
			 );

end instructionMemory;

architecture Behavioral of instructionMemory is


type ram_type is array (0 to 63) of std_logic_vector (31 downto 0);

impure function fill_ram (ram_file_name: in string) return ram_type is                                                   
       FILE f : text is in ram_file_name;                       
       variable l : line;                                 
       variable ram  : ram_type;
		 variable temp : bit_vector(31 downto 0);
    begin                                                        
       for I in ram_type'range loop                                  
           readline (f, l);                             
           read (l, temp);
			  ram(I) := to_stdlogicvector(temp);  
       end loop;                                                    
       return ram;                                                  
    end function;

signal myRam: ram_type := fill_ram("test.data");


begin

process (cont,reset)
begin

	if reset = '1' then
		instruction <= (others => '0');
	else 
		instruction <= myRam(conv_integer(cont(5 downto 0)));
	end if;

end process;

end Behavioral;

