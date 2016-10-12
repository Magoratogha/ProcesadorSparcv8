LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY TB_Main IS
END TB_Main;
 
ARCHITECTURE behavior OF TB_Main IS 
 
    COMPONENT Main
    PORT(
         Rst : IN  std_logic;
         Clk : IN  std_logic;
         ALUResult : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Rst : std_logic := '0';
   signal Clk : std_logic := '0';

 	--Outputs
   signal ALUResult : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant Clk_period : time := 20 ns;
 
BEGIN
 
  uut: Main PORT MAP (
          Rst => Rst,
          Clk => Clk,
          ALUResult => ALUResult
        );

   -- Clock process definitions
   Clk_process :process
   begin
		Clk <= '0';
		wait for Clk_period/2;
		Clk <= '1';
		wait for Clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      Rst <= '1';
      wait for 10 ns;
		Rst <= '0';
		wait;
   end process;

END;
