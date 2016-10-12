LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 

ENTITY TB_EX_SIG IS
END TB_EX_SIG;
 
ARCHITECTURE behavior OF TB_EX_SIG IS 
 

    COMPONENT EX_SIG
    PORT(
         DATO : IN  std_logic_vector(12 downto 0);
         SALIDA : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal DATO : std_logic_vector(12 downto 0) := (others => '0');

 	--Outputs
   signal SALIDA : std_logic_vector(31 downto 0);

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: EX_SIG PORT MAP (
          DATO => DATO,
          SALIDA => SALIDA
        );

  
   -- Stimulus process
   stim_proc: process
   begin		
      DATO <= "1101010101111";
      wait for 100 ns;	
		DATO <= "0001010101111";

      wait;
   end process;

END;

