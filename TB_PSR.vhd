LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY TB_PSR IS
END TB_PSR;
 
ARCHITECTURE behavior OF TB_PSR IS 
 
   COMPONENT PSR
    PORT(
         CLK : IN  std_logic;
         Reset : IN  std_logic;
         nzvc : IN  std_logic_vector(3 downto 0);
         nCWP : IN  std_logic;
         CWP : OUT  std_logic;
         c : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal Reset : std_logic := '0';
   signal nzvc : std_logic_vector(3 downto 0) := (others => '0');
   signal nCWP : std_logic := '0';

 	--Outputs
   signal CWP : std_logic;
   signal c : std_logic;

   -- Clock period definitions
   constant CLK_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: PSR PORT MAP (
          CLK => CLK,
          Reset => Reset,
          nzvc => nzvc,
          nCWP => nCWP,
          CWP => CWP,
          c => c
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      Reset <= '1';
		wait for 100 ns;
		
		Reset <= '0';
		nzvc<= "1010";
		nCWP <= '1';
		wait for 100 ns;
		
		nzvc <= "0000";
		nCWP <= '0';
		wait for 100 ns;
		
		nzvc <= "1111";
		nCWP <= '0';
		wait for 100 ns;
		
		nzvc <= "0010";
		nCWP <= '1';

      wait;
   end process;

END;
