LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
 
ENTITY TB_RF IS
END TB_RF;
 
ARCHITECTURE behavior OF TB_RF IS 
 
 
    COMPONENT RF
    PORT(
         reset : IN  std_logic;
         rs1 : IN  std_logic_vector(4 downto 0);
         rs2 : IN  std_logic_vector(4 downto 0);
         rd : IN  std_logic_vector(4 downto 0);
         dato : IN  std_logic_vector(31 downto 0);
         crs1 : OUT  std_logic_vector(31 downto 0);
         crs2 : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal reset : std_logic := '0';
   signal rs1 : std_logic_vector(4 downto 0) := (others => '0');
   signal rs2 : std_logic_vector(4 downto 0) := (others => '0');
   signal rd : std_logic_vector(4 downto 0) := (others => '0');
   signal dato : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal crs1 : std_logic_vector(31 downto 0);
   signal crs2 : std_logic_vector(31 downto 0);

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: RF PORT MAP (
          reset => reset,
          rs1 => rs1,
          rs2 => rs2,
          rd => rd,
          dato => dato,
          crs1 => crs1,
          crs2 => crs2
        );


   -- Stimulus process
   stim_proc: process
   begin
		reset <= '0';
      dato<= x"10100001";
		rd <= "10110";
      wait for 100 ns;
		reset <= '0';
		rs1 <= "10110";
      wait;
   end process;

END;
