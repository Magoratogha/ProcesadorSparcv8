
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--Procesador3 :
-- Monociclo, soporta la generación de integer conditional codes

entity tercerProcesador is
    Port ( reset : in  STD_LOGIC;
           result : out  STD_LOGIC_VECTOR (31 downto 0) := (others => '0');
           clk : in  STD_LOGIC);
end tercerProcesador;

architecture Behavioral of tercerProcesador is

signal out_nPC: STD_LOGIC_VECTOR(31 downto 0):=(others=>'0');
signal data_in: STD_LOGIC_VECTOR(31 downto 0):=(others=>'0');
signal pc_out: STD_LOGIC_VECTOR(31 downto 0):=(others=>'0');
signal im_out: STD_LOGIC_VECTOR(31 downto 0):=(others=>'0');
signal seu_out: STD_LOGIC_VECTOR(31 downto 0):=(others=>'0');
signal imm13_aux: STD_LOGIC_VECTOR(12 downto 0):=(others=>'0');--en formato3 
																--el inmmediato va del bit 0 al 12
																
signal crs1_aux: STD_LOGIC_VECTOR(31 downto 0):=(others=>'0');			
signal crs2_aux: STD_LOGIC_VECTOR(31 downto 0):=(others=>'0');		
signal mux_out: STD_LOGIC_VECTOR(31 downto 0):=(others=>'0');			
signal cpu_out: STD_LOGIC_VECTOR(5 downto 0):=(others=>'0');
signal alu_out: STD_LOGIC_VECTOR(31 downto 0):=(others=>'0');	
signal psr_modifier_out: STD_LOGIC_VECTOR(3 downto 0):=(others=>'0');	
signal psr_out: STD_LOGIC := '0';	

signal nrs1_out_wm: STD_LOGIC_VECTOR(5 downto 0):=(others=>'0');						
signal nrs2_out_wm: STD_LOGIC_VECTOR(5 downto 0):=(others=>'0');		
signal nrd_out_wm: STD_LOGIC_VECTOR(5 downto 0):=(others=>'0');	

signal ncwp_out_wm: STD_LOGIC:='0';	
signal cwp_out_psr: STD_LOGIC:='0';

signal wrenmem_aux: STD_LOGIC:='0';
signal datatomem_aux: STD_LOGIC_VECTOR(31 downto 0):=(others=>'0');			
signal cRD_aux: STD_LOGIC_VECTOR(31 downto 0):=(others=>'0');	
signal datatoreg: STD_LOGIC_VECTOR(31 downto 0):=(others=>'0');	
signal rf_source_aux: STD_LOGIC_VECTOR(1 downto 0):=(others=>'0');	
signal O7_aux: STD_LOGIC_VECTOR(5 downto 0):=(others=>'0');	
signal rfdest_aux: STD_LOGIC:= '0'; 
signal muxRF_aux: STD_LOGIC_VECTOR(5 downto 0):=(others=>'0');	
signal imm32_out: STD_LOGIC_VECTOR(31 downto 0):=(others=>'0');	
signal adderbranchesout: STD_LOGIC_VECTOR(31 downto 0):=(others=>'0');	
signal addercallout: STD_LOGIC_VECTOR(31 downto 0):=(others=>'0');	
signal auxdisp30: STD_LOGIC_VECTOR(31 downto 0):=(others=>'0');	
signal pcsource_aux: STD_LOGIC_VECTOR(1 downto 0):=(others=>'0');
signal MUXUP_aux: STD_LOGIC_VECTOR(31 downto 0):=(others=>'0');
signal we_aux: std_logic:='0';
signal icc_aux : std_logic_vector(3 downto 0):=(others=>'0');

COMPONENT nPC
	PORT( 
		reset : IN std_logic;
		clk : IN std_logic;
		data : IN std_logic_vector(31 downto 0);          
		data_out : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT Sumador
	PORT(
		constante : IN std_logic_vector(31 downto 0);
		data : IN std_logic_vector(31 downto 0);          
		data_out : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

	COMPONENT instructionMemory
	PORT(
		cont : IN std_logic_vector(31 downto 0);     
		reset : in  STD_LOGIC;
		instruction : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT SEU
	PORT(
		imm13 : IN std_logic_vector(12 downto 0);          
		imm32 : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

	COMPONENT MUX
	PORT(
		a : IN std_logic_vector(31 downto 0);
		b : IN std_logic_vector(31 downto 0);
		sel : IN std_logic;          
		salida : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT RF
	PORT(
		rs1 : IN std_logic_vector(5 downto 0);
		rs2 : IN std_logic_vector(5 downto 0);
		rd : IN std_logic_vector(5 downto 0); 
		dwr : IN std_logic_vector(31 downto 0); 	
		reset : in  STD_LOGIC;
		crs1 : OUT std_logic_vector(31 downto 0);
		crs2 : OUT std_logic_vector(31 downto 0);
		cRD : out std_logic_vector(31 downto 0);
		we : in std_logic
		);
	END COMPONENT;
	
	COMPONENT ALU
	PORT(
		A : IN std_logic_vector(31 downto 0);
		B : IN std_logic_vector(31 downto 0);
		ALUOP : IN std_logic_vector(5 downto 0);      
		Carry : IN std_logic ;  
		Salida : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

	COMPONENT CU
	PORT(
		op : IN std_logic_vector(1 downto 0);
		op3 : IN std_logic_vector(5 downto 0);   
		icc : IN std_logic_vector(3 downto 0); 
		cond : IN std_logic_vector(3 downto 0); 
		salida : OUT std_logic_vector(5 downto 0);
		wrenmem : OUT std_logic;
		rfsource : out std_logic_vector(1 downto 0);
		rfdest: out std_logic;
		pcsource: out std_logic_vector (1 downto 0);
		we: out std_logic
		);
	END COMPONENT;
	
		COMPONENT PSR_Modifier
	PORT(
		ALUOP : IN std_logic_vector(5 downto 0);
		ALU_Result : IN std_logic_vector(31 downto 0);
		Crs1 : IN std_logic_vector(31 downto 0);
		Crs2 : IN std_logic_vector(31 downto 0);          
		nzvc : OUT std_logic_vector(3 downto 0);
		reset : in  STD_LOGIC
		);
	END COMPONENT;

	COMPONENT PSR
	PORT(
		nzvc : IN std_logic_vector(3 downto 0);
		reset : IN std_logic;
		clk : IN std_logic;   
		ncwp : IN std_logic;
		carry : OUT std_logic;
		cwp : out std_logic;
		icc : out std_logic_vector(3 downto 0)
		);
	END COMPONENT;
	
	COMPONENT WindowsManager
	PORT(
		rs1 : IN std_logic_vector(4 downto 0);
		rs2 : IN std_logic_vector(4 downto 0);
		rd : IN std_logic_vector(4 downto 0);
		cwp : IN std_logic;
		op : IN std_logic_vector(1 downto 0);
		op3 : IN std_logic_vector(5 downto 0);          
		nrs1 : OUT std_logic_vector(5 downto 0);
		nrs2 : OUT std_logic_vector(5 downto 0);
		nrd : OUT std_logic_vector(5 downto 0);
		ncwp : OUT std_logic;
		O7 : OUT std_logic_vector(5 downto 0)
		);
	END COMPONENT;
	
	COMPONENT DataMemory
	PORT(
		reset : IN std_logic;
		cRD : IN std_logic_vector(31 downto 0);
		addres : IN std_logic_vector(4 downto 0);
		wrenmem : IN std_logic;          
		datatomem : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT MuxDataMemory
	PORT(
		a : IN std_logic_vector(31 downto 0);
		b : IN std_logic_vector(31 downto 0);
		c : IN std_logic_vector(31 downto 0);
		sel : IN std_logic_vector(1 downto 0);          
		salida : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT MUXRF
	PORT(
		a : IN std_logic_vector(5 downto 0);
		b : IN std_logic_vector(5 downto 0);
		sel : IN std_logic;          
		salida : OUT std_logic_vector(5 downto 0)
		);
	END COMPONENT;
	
	COMPONENT SEU22
	PORT(
		imm22 : IN std_logic_vector(21 downto 0);          
		imm32 : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT SEU30
	PORT(
		imm30 : IN std_logic_vector(29 downto 0);          
		imm32 : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT MUXUP
	PORT(
		a : IN std_logic_vector(31 downto 0);
		b : IN std_logic_vector(31 downto 0);
		c : IN std_logic_vector(31 downto 0);
		d : IN std_logic_vector(31 downto 0);
		sel : IN std_logic_vector(1 downto 0);          
		salida : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
begin

	Inst_nPC: nPC PORT MAP(
		reset => reset,
		clk => clk,
		data => MUXUP_aux,
		data_out => out_nPC
	);
	
	Inst_PC: nPC PORT MAP(
		reset => reset,
		clk => clk,
		data => out_nPC,
		data_out => pc_out
	);
	
	Inst_Sumador: Sumador PORT MAP(
		constante => "00000000000000000000000000000001",
		data => out_nPC,
		data_out => data_in
	);
	
	Inst_InstMemo: instructionMemory PORT MAP(
		cont => pc_out,
		reset => reset,
		instruction => im_out
	);
	
	Inst_SEU: SEU PORT MAP(
		imm13 => im_out(12 downto 0),
		imm32 => seu_out
	);
	
	Inst_MUX: MUX PORT MAP(
		a => crs2_aux,
		b => seu_out,
		sel => im_out(13),
		salida => mux_out
	);
	
	Inst_RF: RF PORT MAP(
		rs1 => nrs1_out_wm,
		rs2 => nrs2_out_wm,
		rd => muxRF_aux,
		dwr => datatoreg,
		reset => reset,
		crs1 => crs1_aux,
		crs2 => crs2_aux,
		cRD => cRD_aux,
		we => we_aux
	);
	
	Inst_ALU: ALU PORT MAP(
		A => crs1_aux,
		B => mux_out,
		ALUOP => cpu_out,
		Carry => psr_out,
		Salida => alu_out
	);
	
	Inst_CU: CU PORT MAP(
		op => im_out(31 downto 30),
		op3 => im_out(24 downto 19),
		icc => icc_aux, -- conecta con el PSR
		cond => im_out(28 downto 25),
		salida => cpu_out,
		wrenmem => wrenmem_aux,
		rfsource => rf_source_aux,
		rfdest => rfdest_aux,
		pcsource => pcsource_aux,
		we => we_aux
	);
	
	Inst_PSR_Modifier: PSR_Modifier PORT MAP(
		ALUOP => cpu_out,
		ALU_Result => alu_out,
		Crs1 => crs1_aux,
		Crs2 => mux_out,
		nzvc => psr_modifier_out,
		reset => reset
	);
	
	Inst_PSR: PSR PORT MAP(
		nzvc => psr_modifier_out,
		reset => reset,
		clk => clk,
		ncwp => ncwp_out_wm,
		carry => psr_out,
		cwp => cwp_out_psr,
		icc => icc_aux
	);
	
	Inst_WindowsManager: WindowsManager PORT MAP(
		rs1 => im_out(18 downto 14),
		rs2 => im_out(4 downto 0),
		rd => im_out(29 downto 25),
		cwp => cwp_out_psr,
		op => im_out(31 downto 30),
		op3 => im_out(24 downto 19),
		nrs1 => nrs1_out_wm,
		nrs2 => nrs2_out_wm,
		nrd => nrd_out_wm,
		ncwp => ncwp_out_wm,
		O7 => O7_aux
	);
	
	Inst_DataMemory: DataMemory PORT MAP(
		reset => reset,
		cRD => cRD_aux,
		addres => alu_out(4 downto 0),
		wrenmem => wrenmem_aux,
		datatomem => datatomem_aux
	);
	
	Inst_MuxDataMemory: MuxDataMemory PORT MAP(
		a => datatomem_aux,
		b => alu_out,
		c => pc_out,
		sel => rf_source_aux,
		salida => datatoreg
	);
	
	Inst_MUXRF: MUXRF PORT MAP(
		a => nrd_out_wm,
		b => O7_aux,
		sel => rfdest_aux,
		salida => muxRF_aux
	);
	
	Inst_SEU22: SEU22 PORT MAP(
		imm22 => im_out(21 downto 0),
		imm32 => imm32_out
	);
	
	Inst_SEU30: SEU30 PORT MAP(
		imm30 => im_out(29 downto 0),
		imm32 => auxdisp30
	);
	
	Inst_Sumador22: Sumador PORT MAP(
		constante => pc_out,
		data => imm32_out,
		data_out => adderbranchesout
	);
	
	Inst_Sumador30: Sumador PORT MAP(
		constante => pc_out,
		data => auxdisp30,
		data_out => addercallout
	);
	
	Inst_MUXUP: MUXUP PORT MAP(
		a => addercallout,
		b => adderbranchesout,
		c => data_in, --salida adder normal
		d => alu_out,
		sel => pcsource_aux,
		salida => MUXUP_aux
	);

result <= alu_out;

end Behavioral;

