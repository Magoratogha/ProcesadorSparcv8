LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY Tb_Alu IS
END Tb_Alu;
 
ARCHITECTURE behavior OF Tb_Alu IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ALU
    PORT(
         operando1 : IN  std_logic_vector(31 downto 0);
         operando2 : IN  std_logic_vector(31 downto 0);
         aluOP : IN  std_logic_vector(5 downto 0);
         AluResult : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal operando1 : std_logic_vector(31 downto 0) := (others => '0');
   signal operando2 : std_logic_vector(31 downto 0) := (others => '0');
   signal aluOP : std_logic_vector(5 downto 0) := (others => '0');
 	--Outputs
   signal AluResult : std_logic_vector(31 downto 0);
   
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ALU PORT MAP (
          operando1 => operando1,
          operando2 => operando2,
          aluOP => aluOP,
          AluResult => AluResult
        );


   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 20 ns.
		operando1 <= x"00000005";
		operando2 <= x"00000013";
		aluOP <= "000000"; --add
      wait for 20 ns;
		
		operando1 <= x"00000005";
		operando2 <= x"00000013";
		aluOP <= "000001"; --sub
      wait for 20 ns;
		
		operando1 <= x"00000005";
		operando2 <= x"00000013";
		aluOP <= "000010"; --or
      wait for 20 ns;
		
		operando1 <= x"00000005";
		operando2 <= x"00000013";
		aluOP <= "000011"; --and
      wait for 20 ns;
		
		operando1 <= x"00000005";
		operando2 <= x"00000013";
		aluOP <= "000100"; --xor
      wait for 20 ns;
		
		operando1 <= x"00000005";
		operando2 <= x"00000013";
		aluOP <= "000101"; --orn
      wait for 20 ns;
		
		operando1 <= x"00000005";
		operando2 <= x"00000013";
		aluOP <= "000110"; --andn
      wait for 20 ns;
		
		operando1 <= x"00000005";
		operando2 <= x"00000013";
		aluOP <= "000111"; --xnor
      
      wait;
   end process;

END;
