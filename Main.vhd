library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Main is
    Port ( Rst : in  STD_LOGIC;
           Clk : in  STD_LOGIC;
           ALUResult : out  STD_LOGIC_VECTOR (31 downto 0));
end Main;

architecture SPARCV8 of Main is

	COMPONENT ALU
		Port ( 
				operando1 : in  STD_LOGIC_VECTOR (31 downto 0);
				operando2 : in  STD_LOGIC_VECTOR (31 downto 0);
				aluOP : in  STD_LOGIC_VECTOR (5 downto 0);
				AluResult : out  STD_LOGIC_VECTOR (31 downto 0));
	END COMPONENT;
	

	COMPONENT EX_SIG
		Port ( 
				DATO : in  STD_LOGIC_VECTOR (12 downto 0);
				SALIDA : out  STD_LOGIC_VECTOR (31 downto 0));
	END COMPONENT;
	
	
	COMPONENT IM
		Port ( 
			  	address : in  STD_LOGIC_VECTOR (31 downto 0);
           		  	reset : in  STD_LOGIC;
           			outInst : out  STD_LOGIC_VECTOR (31 downto 0));
	END COMPONENT;
	
	
	COMPONENT MUX_ALU
		Port ( 
				Crs2 : in  STD_LOGIC_VECTOR (31 downto 0);
				SEUOperando : in  STD_LOGIC_VECTOR (31 downto 0);
				habImm : in  STD_LOGIC;
				OperandoALU : out  STD_LOGIC_VECTOR (31 downto 0));
	END COMPONENT;
	
	
	COMPONENT PC
		Port ( 
				address : in  STD_LOGIC_VECTOR (31 downto 0);
				clk : in  STD_LOGIC;
				reset : in  STD_LOGIC;
				nextInst : out  STD_LOGIC_VECTOR (31 downto 0));
	END COMPONENT;
	
	
	COMPONENT RF
		Port ( 
				reset : in  STD_LOGIC;
				rs1 : in  STD_LOGIC_VECTOR (4 downto 0);
				rs2 : in  STD_LOGIC_VECTOR (4 downto 0);
				rd: in  STD_LOGIC_VECTOR (4 downto 0);
				dato : in STD_LOGIC_VECTOR (31 downto 0);
				crs1 : out  STD_LOGIC_VECTOR (31 downto 0);
				crs2 : out  STD_LOGIC_VECTOR (31 downto 0));
	END COMPONENT;
	
	
	COMPONENT Sum32
		Port ( 
				op1 : in  STD_LOGIC_VECTOR (31 downto 0);
				op2 : in  STD_LOGIC_VECTOR (31 downto 0);
				res : out  STD_LOGIC_VECTOR (31 downto 0));
	END COMPONENT;
	
	
	COMPONENT UC
		Port ( 
				op : in  STD_LOGIC_VECTOR (1 downto 0);
				op3 : in  STD_LOGIC_VECTOR (5 downto 0);
				ALUOP : out  STD_LOGIC_VECTOR (5 downto 0));
	END COMPONENT;
	
	
	signal SumNPC, NpcPc, PCIM, IMO, RFALU, RFMUX, SEUMUX, MUXALU, ALURF : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000000";
	signal CUALU : STD_LOGIC_VECTOR (5 downto 0) := "000000";
	
	
begin


	nPC: PC PORT MAP (
				address => SumNPC,
				clk => Clk,
				reset => Rst,
				nextInst => NpcPc
        );

	
	PC1: PC PORT MAP (
				address => NpcPc,
				clk => Clk,
				reset => Rst,
				nextInst => PCIM
        );


	SUM: Sum32 PORT MAP (
				op1 => "00000000000000000000000000000001",
				op2 => NpcPc,
				res => SumNPC
        );
		  
		  
	IM1: IM PORT MAP (
				address => PCIM,
				reset => Rst,
				outInst =>IMO
        );
		  
		  
	RF1: RF PORT MAP (
				reset => Rst,
				rs1 => IMO(18 downto 14),
				rs2 => IMO(4 downto 0),
				rd => IMO(29 downto 25),
				dato => ALURF,
				crs1 => RFALU,
				crs2=> RFMUX
        );
		  
	
	MUX: MUX_ALU PORT MAP (
				Crs2 => RFMUX,
				SEUOperando => SEUMUX,
				habImm => IMO(13),
				OperandoALU => MUXALU
        );
		  
		  
	SEU: EX_SIG PORT MAP (
				DATO => IMO(12 downto 0),
				SALIDA => SEUMUX
        );
		  
		  
	CU: UC PORT MAP (
				op => IMO(31 downto 30),
				op3 => IMO(24 downto 19),
				ALUOP => CUALU
        );
		  
	
	ALU1: ALU PORT MAP (
				operando1 => RFALU,
				operando2 => MUXALU,
				aluOP => CUALU,
				AluResult => ALURF
        );
		  
	ALUResult <= ALURF;


end SPARCV8;

