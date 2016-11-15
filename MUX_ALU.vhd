library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity MUX is
		PORT(  a      : IN std_logic_vector(31 DOWNTO 0); 
             b      : IN std_logic_vector(31 DOWNTO 0); 
             sel    : IN std_logic; 
             salida : OUT std_logic_vector(31 DOWNTO 0));
end MUX;

architecture Behavioral of MUX is

begin

PROCESS (sel, a, b) IS
       BEGIN
         CASE sel IS
           WHEN '0' => salida <= a; --tierra
           WHEN '1' => salida <= b; --rgb
           WHEN OTHERS => salida <= (others => '0');
         END CASE;
END PROCESS;

end Behavioral;