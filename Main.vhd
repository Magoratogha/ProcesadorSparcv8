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
				c : in  STD_LOGIC;
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
				rs1 : in  STD_LOGIC_VECTOR (5 downto 0);
				rs2 : in  STD_LOGIC_VECTOR (5 downto 0);
				rd: in  STD_LOGIC_VECTOR (5 downto 0);
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
	
	
	COMPONENT PSR
		Port ( 
				CLK : in  STD_LOGIC;
				Reset : in  STD_LOGIC;
				nzvc : in  STD_LOGIC_VECTOR (3 downto 0);
				nCWP : in  STD_LOGIC;
				CWP : out  STD_LOGIC;
				c: out STD_LOGIC);
	END COMPONENT;
	
	
	COMPONENT PSRModifier
		Port ( 
				rst : in STD_LOGIC;
				aluResult : in STD_LOGIC_VECTOR (31 downto 0);
				operando1 : in STD_LOGIC_VECTOR (31 downto 0);
				operando2 : in STD_LOGIC_VECTOR (31 downto 0);
				aluOp : in STD_LOGIC_VECTOR (5 downto 0);
				nzvc : out STD_LOGIC_VECTOR (3 downto 0));
	END COMPONENT;
	
	
	COMPONENT WindowsManager
		Port ( 
				rs1 : in  STD_LOGIC_VECTOR (4 downto 0);
				rs2 : in  STD_LOGIC_VECTOR (4 downto 0);
				rd : in  STD_LOGIC_VECTOR (4 downto 0);
				cwp : in  STD_LOGIC;
				op : in  STD_LOGIC_VECTOR (1 downto 0);
				op3 : in  STD_LOGIC_VECTOR (5 downto 0);
				ncwp : out  STD_LOGIC;
				nrs1 : out  STD_LOGIC_VECTOR (5 downto 0);
				nrs2 : out  STD_LOGIC_VECTOR (5 downto 0);
				nrd : out  STD_LOGIC_VECTOR (5 downto 0));
	END COMPONENT;
	
	
	signal SumNPC, NpcPc, PCIM, IMO, RFALU, RFMUX, SEUMUX, MUXALU, ALURF : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000000";
	signal CUALU, WMRF1, WMRF2, WMRF3 : STD_LOGIC_VECTOR (5 downto 0) := "000000";
	signal ICC : STD_LOGIC_VECTOR (3 downto 0) := "0000";
	signal WMPSR, PSRWM, PSRALU : STD_LOGIC := '0';
	
	
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
				rs1 => WMRF1,
				rs2 => WMRF2,
				rd => WMRF3,
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
				c => PSRALU,
				operando1 => RFALU,
				operando2 => MUXALU,
				aluOP => CUALU,
				AluResult => ALURF
        );
	ALUResult <= ALURF;
		  
	
	PSR1: PSR PORT MAP (
				CLK => Clk,
				Reset => Rst,
				nzvc => ICC,
				nCWP => WMPSR,
				CWP => PSRWM,
				c => PSRALU
        );
		  
		  
	PSRM: PSRModifier PORT MAP (
				rst => Rst,
				aluResult => ALURF,
				operando1 => RFALU,
				operando2 => MUXALU,
				aluOp => CUALU,
				nzvc => ICC
        );
		  
		  
	WM: WindowsManager PORT MAP (
				rs1 => IMO(18 downto 14),
				rs2 => IMO(4 downto 0),
				rd => IMO(29 downto 25),
				cwp => PSRWM,
				op => IMO(31 downto 30),
				op3 => IMO(24 downto 19),
				ncwp => WMPSR,
				nrs1 => WMRF1,
				nrs2 => WMRF2,
				nrd => WMRF3
        );
		  


end SPARCV8;

