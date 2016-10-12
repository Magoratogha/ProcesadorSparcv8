LIBRARY ieee;
USE ieee.std_logic_1164.ALL; 

ENTITY TB_PC IS
END TB_PC;
 
ARCHITECTURE behavior OF TB_PC IS 
 
 
    COMPONENT PC
    PORT(
         address : IN  std_logic_vector(31 downto 0);
         clk : IN  std_logic;
         reset : IN  std_logic;
         nextInst : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal address : std_logic_vector(31 downto 0) := (others => '0');
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';

 	--Outputs
   signal nextInst : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant clk_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: PC PORT MAP (
          address => address,
          clk => clk,
          reset => reset,
          nextInst => nextInst
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
      wait for 20 ns;	
		address <= x"00000000"; 
      reset <= '0'; 
		wait for 20 ns;
		address <= x"00000001";
		wait for 20 ns;
		address <= x"00000002";
		wait for 20 ns;
		address <= x"00000003";
      wait;
   end process;

END;
