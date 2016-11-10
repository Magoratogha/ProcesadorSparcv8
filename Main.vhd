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
	
	
	COMPONENT EX_SIG2
		Port ( 
				DATO : in  STD_LOGIC_VECTOR (21 downto 0);
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
	
	
	COMPONENT MUX6b
		Port ( 
				Crs2 : in  STD_LOGIC_VECTOR (5 downto 0);
				SEUOperando : in  STD_LOGIC_VECTOR (5 downto 0);
				habImm : in  STD_LOGIC;
				OperandoALU : out  STD_LOGIC_VECTOR (5 downto 0));
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
				WE : in  STD_LOGIC;
				dato : in STD_LOGIC_VECTOR (31 downto 0);
				crs1 : out  STD_LOGIC_VECTOR (31 downto 0);
				crs2 : out  STD_LOGIC_VECTOR (31 downto 0);
				crd : out  STD_LOGIC_VECTOR (31 downto 0));
	END COMPONENT;
	
	
	COMPONENT Sum32
		Port ( 
				op1 : in  STD_LOGIC_VECTOR (31 downto 0);
				op2 : in  STD_LOGIC_VECTOR (31 downto 0);
				res : out  STD_LOGIC_VECTOR (31 downto 0));
	END COMPONENT;

	
	COMPONENT Sum32X
		Port ( 
				op1 : in  STD_LOGIC_VECTOR (29 downto 0);
				op2 : in  STD_LOGIC_VECTOR (31 downto 0);
				res : out  STD_LOGIC_VECTOR (31 downto 0));
	END COMPONENT;

	
	COMPONENT UC
		Port ( 
				op : in  STD_LOGIC_VECTOR (1 downto 0);
				op2 : in  STD_LOGIC_VECTOR (2 downto 0);
				op3 : in  STD_LOGIC_VECTOR (5 downto 0);
				cond : in  STD_LOGIC_VECTOR (3 downto 0);
				icc : in  STD_LOGIC_VECTOR (3 downto 0);
				RdEnMem : out STD_LOGIC;
				RfDest : out  STD_LOGIC;
				RfSource : out  STD_LOGIC_VECTOR (1 downto 0);
				PcSource : out STD_LOGIC_VECTOR (1 downto 0);
				WrEnMem : out  STD_LOGIC;
				WrEnRF : out  STD_LOGIC;
				ALUOP : out  STD_LOGIC_VECTOR (5 downto 0):= (others => '0'));
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
	
	
	COMPONENT DataMemory
		Port ( 
				clk : in  STD_LOGIC;
				RdEnMem : in  STD_LOGIC;
				reset : in STD_LOGIC;
				cRD : in  STD_LOGIC_VECTOR (31 downto 0);
				address : in STD_LOGIC_VECTOR (31 downto 0);				
				WrEnMem : in  STD_LOGIC;
				DataToMem : out  STD_LOGIC_VECTOR (31 downto 0));
	END COMPONENT;
	
	
	COMPONENT MUX4
		Port ( 
				op1 : in  STD_LOGIC_VECTOR (31 downto 0);
				op2 : in  STD_LOGIC_VECTOR (31 downto 0);
				op3 : in  STD_LOGIC_VECTOR (31 downto 0);
				op4 : in  STD_LOGIC_VECTOR (31 downto 0);
				hab : in  STD_LOGIC_VECTOR (1 downto 0);
				Salida : out  STD_LOGIC_VECTOR (31 downto 0));
	END COMPONENT;
	
	
	signal MUXNPC, NPCPC, SUMMUX, SUMMUX2, SUMMUX3, PCIM, IMO, SEUSUM, SEUMUX, CRS2, CRS1, MUXALU, CRD, ALUR, DTM, MUXO 	: STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000000";
	signal RD, NRD, NRS1, NRS2, ALUOP : STD_LOGIC_VECTOR (5 downto 0) := "000000";
	signal ICC : STD_LOGIC_VECTOR (3 downto 0) := "0000";
	signal PCSOURCE, RFSOURCE: STD_LOGIC_VECTOR (1 downto 0) := "00";
	signal NCWP, CWP, C, RFDEST, WE, WRENMEM, RDENMEM : STD_LOGIC := '0';
	
	
begin


	nPC: PC PORT MAP (
				address => MUXNPC,
				clk => Clk,
				reset => Rst,
				nextInst => NPCPC 
        );

	
	PC1: PC PORT MAP (
				address => NPCPC,
				clk => Clk,
				reset => Rst,
				nextInst => PCIM
        );


	SUM: Sum32 PORT MAP (
				op1 => NPCPC,
				op2 => "00000000000000000000000000000001",
				res => SUMMUX
        );
		  
		  
	SUM2: Sum32 PORT MAP (
				op1 => PCIM,
				op2 => SEUSUM,
				res => SUMMUX2
        );
		  
		  
	SUM3: Sum32X PORT MAP (
				op1 => IMO(29 downto 0),
				op2 => PCIM,
				res => SUMMUX3
        );
		  
		  
	IM1: IM PORT MAP (
				address => PCIM,
				reset => Rst,
				outInst => IMO
        );
		  
		  
	RF1: RF PORT MAP (
				reset => Rst,
				rs1 => NRS1,
				rs2 => NRS2,
				rd => NRD,
				WE => WE,
				dato => MUXO,
				crs1 => CRS1,
				crs2=> CRS2,
				crd => CRD 
        );
		  
	
	MUX0: MUX_ALU PORT MAP (
				Crs2 => CRS2,
				SEUOperando => SEUMUX,
				habImm => IMO(13),
				OperandoALU => MUXALU
        );
		  
		  
	MUX1: MUX6b PORT MAP (
				Crs2 => RD,
				SEUOperando => "001111",
				habImm => RFDEST,
				OperandoALU => NRD 
        );
		  
		  
	MUX2: MUX4 PORT MAP (
				op1 => SUMMUX3,
				op2 => SUMMUX2,
				op3 => SUMMUX,
				op4 => ALUR,
				hab => PCSOURCE,
				Salida => MUXNPC
        );
		  
		  
	MUX3: MUX4 PORT MAP (
				op1 => DTM,
				op2 => ALUR,
				op3 => "00000000000000000000000000000000",
				op4 => PCIM,
				hab => RFSOURCE,
				Salida => MUXO 
        );
		  
	ALUResult <= MUXO;
		  
		  
	DM: DataMemory PORT MAP (
				clk => Clk,
				RdEnMem => RDENMEM,
				reset => Rst,
				cRD => CRD,
				address => ALUR,				
				WrEnMem => WRENMEM,
				DataToMem => DTM 
        );
	
	
	SEU: EX_SIG PORT MAP (
				DATO => IMO(12 downto 0),
				SALIDA => SEUMUX 
        );
		  
	
	SEU2: EX_SIG2 PORT MAP (
				DATO => IMO(21 downto 0),
				SALIDA => SEUSUM
        );
		  
		  
	CU: UC PORT MAP (
				op => IMO(31 downto 30),
			   op2 => IMO(24 downto 22),
            op3 => IMO(24 downto 19),
			   cond => IMO(28 downto 25),
				icc => ICC,
				RdEnMem => RDENMEM,
				RfDest => RFDEST,
				RfSource => RFSOURCE,
				PcSource => PCSOURCE,
				WrEnMem => WRENMEM,
				WrEnRF => WE,
				ALUOP => ALUOP
        );
		  
	
	ALU1: ALU PORT MAP (
				c => C,
				operando1 => CRS1,
				operando2 => MUXALU,
				aluOP => ALUOP,
				AluResult => ALUR
        );
		  
	
	PSR1: PSR PORT MAP (
				CLK => Clk,
				Reset => Rst,
				nzvc => ICC,
				nCWP => NCWP,
				CWP => CWP,
				c => C 
        );
		  
		  
	PSRM: PSRModifier PORT MAP (
				rst => Rst,
				aluResult => ALUR,
				operando1 => CRS1,
				operando2 => MUXALU,
				aluOp => ALUOP,
				nzvc => ICC 
        );
		  
		  
	WM: WindowsManager PORT MAP (
				rs1 => IMO(18 downto 14),
				rs2 => IMO(4 downto 0),
				rd => IMO(29 downto 25),
				cwp => CWP,
				op => IMO(31 downto 30),
				op3 => IMO(24 downto 19),
				ncwp => NCWP,
				nrs1 => NRS1,
				nrs2 => NRS2,
				nrd => RD 
        );
	

end SPARCV8;

