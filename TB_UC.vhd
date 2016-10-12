LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY TB_UC IS
END TB_UC;
 
ARCHITECTURE behavior OF TB_UC IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT UC
    PORT(
         op : IN  std_logic_vector(1 downto 0);
         op3 : IN  std_logic_vector(5 downto 0);
         ALUOP : OUT  std_logic_vector(5 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal op : std_logic_vector(1 downto 0) := (others => '0');
   signal op3 : std_logic_vector(5 downto 0) := (others => '0');
	
 	--Outputs
   signal ALUOP : std_logic_vector(5 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: UC PORT MAP (
          op => op,
          op3 => op3,
          ALUOP => ALUOP
        );
 

   -- Stimulus process
   stim_proc: process
   begin		
      op <= "10";
		op3 <= "000000" ;
		wait for 100 ns;
		op <= "10";
		op3 <= "000110" ;
		wait for 100 ns;
		op <= "10";
		op3 <= "000100" ;
		wait;
   end process;

END;
