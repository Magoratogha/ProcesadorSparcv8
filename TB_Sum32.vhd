LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
  
ENTITY TB_Sum32 IS
END TB_Sum32;
 
ARCHITECTURE behavior OF TB_Sum32 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Sum32
    PORT(
         op1 : IN  std_logic_vector(31 downto 0);
         op2 : IN  std_logic_vector(31 downto 0);
         res : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal op1 : std_logic_vector(31 downto 0) := (others => '0');
   signal op2 : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal res : std_logic_vector(31 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Sum32 PORT MAP (
          op1 => op1,
          op2 => op2,
          res => res
        );


   -- Stimulus process
   stim_proc: process
   begin		
      op1 <= "00000000000000000110000001000001";
		op2 <= "00000000000000000000010000000100";
		wait for 20 ns;
		
		op1 <= "00000000000000000000000000000011";
		op2 <= "00000000011000000000000000000100";
		wait for 20 ns; 

      wait;
   end process;

END;
