
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

--USE ieee.numeric_std.ALL;
 
ENTITY Processor4_TB IS
END Processor4_TB;
 
ARCHITECTURE behavior OF Processor4_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT tercerProcesador
    PORT(
         reset : IN  std_logic;
         result : OUT  std_logic_vector(31 downto 0);
         clk : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal reset : std_logic := '0';
   signal clk : std_logic := '0';

 	--Outputs
   signal result : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant clk_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: tercerProcesador PORT MAP (
          reset => reset,
          result => result,
          clk => clk
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      reset <= '1';
		
      wait for 100 ns;	

		reset <= '0';
		wait for 1 ms;

      wait;
   end process;

END;
