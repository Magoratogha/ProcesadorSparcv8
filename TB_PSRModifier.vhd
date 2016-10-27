LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY TB_PSRModifier IS
END TB_PSRModifier;
 
ARCHITECTURE behavior OF TB_PSRModifier IS 
 
    COMPONENT PSRModifier
    PORT(
			rst : in STD_LOGIC;
         aluResult : IN  std_logic_vector(31 downto 0);
         operando1 : IN  std_logic_vector(31 downto 0);
         operando2 : IN  std_logic_vector(31 downto 0);
         aluOp : IN  std_logic_vector(5 downto 0);
         nzvc : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
	signal rst : STD_LOGIC := '0';
   signal aluResult : std_logic_vector(31 downto 0) := (others => '0');
   signal operando1 : std_logic_vector(31 downto 0) := (others => '0');
   signal operando2 : std_logic_vector(31 downto 0) := (others => '0');
   signal aluOp : std_logic_vector(5 downto 0) := (others => '0');

 	--Outputs
   signal nzvc : std_logic_vector(3 downto 0);
  
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: PSRModifier PORT MAP (
			 rst => rst,
          aluResult => aluResult,
          operando1 => operando1,
          operando2 => operando2,
          aluOp => aluOp,
          nzvc => nzvc
        );

   -- Stimulus process
   stim_proc: process
   begin		
      rst <= '1';
      wait for 100 ns;
		

		rst <= '0';
		operando1<= "00000000000000000000000000000000";
		operando2 <= "00000000000000000000000000000000";
		aluOp <= "001000";
		aluResult <= "00000000000000000000000000000000";
      wait for 100 ns;	

		rst <= '0';
		operando1<= "00000000000000000000000000000000";
		operando2 <= "00000000000000000000000000000000";
		aluOp <= "001000";
		aluResult <= "00000000000000000000000000000000";
      wait for 100 ns;	

		rst <= '0';
		operando1<= "00000000000000000000000000000000";
		operando2 <= "00000000000000000000000000000000";
		aluOp <= "001001";
		aluResult <= "00000000000000000000000000000000";
      wait for 100 ns;


      wait;
   end process;

END;
