LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY TB_MuxALU IS
END TB_MuxALU;
 
ARCHITECTURE behavior OF TB_MuxALU IS 
 
 
    COMPONENT MUX_ALU
    PORT(
         Crs2 : IN  std_logic_vector(31 downto 0);
         SEUOperando : IN  std_logic_vector(31 downto 0);
         habImm : IN  std_logic;
         OperandoALU : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Crs2 : std_logic_vector(31 downto 0) := (others => '0');
   signal SEUOperando : std_logic_vector(31 downto 0) := (others => '0');
   signal habImm : std_logic := '0';

 	--Outputs
   signal OperandoALU : std_logic_vector(31 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MUX_ALU PORT MAP (
          Crs2 => Crs2,
          SEUOperando => SEUOperando,
          habImm => habImm,
          OperandoALU => OperandoALU
        );
 

   -- Stimulus process
   stim_proc: process
   begin		
      Crs2 <= "00001010101010100000000001111111";
		SEUOperando <= "11111111111100000011111111111111";
		habImm <= '1';
		wait for 20 ns;	
		
		Crs2 <= "00001010101010100000000001111111";
		SEUOperando <= "11111111111100000011111111111111";
		habImm <= '0';
		wait for 20 ns;

      wait;
   end process;

END;
