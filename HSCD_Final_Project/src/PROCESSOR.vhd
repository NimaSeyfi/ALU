library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity PROCESSOR is
	generic (
	PC_DATA_WIDTH : integer := 7;
	REGISTER_DATA_WIDTH : integer := 7;
	IR_DATA_WIDTH : integer := 7
	);
	port (
	clk, ControlRST : in std_logic								
	); 
	
end PROCESSOR;

architecture behaviour of PROCESSOR is															  
signal ld0 : std_logic;
signal ld1 : std_logic;
signal ld2 : std_logic;
signal ld3 : std_logic;
signal ldpc : std_logic;
signal ldir : std_logic;
signal s00 : std_logic;
signal s01 : std_logic;
signal s10 : std_logic;
signal s11 : std_logic;
signal bus_sel : std_logic;
signal cmd : std_logic_vector(1 downto 0);
signal inc : std_logic;
signal rst : std_logic;

signal zr0 : std_logic;
signal zr1 : std_logic;
signal zr2 : std_logic;
signal zr3 : std_logic;

signal ROUT0 : std_logic_vector(REGISTER_DATA_WIDTH-1 downto 0);
signal ROUT1 : std_logic_vector(REGISTER_DATA_WIDTH-1 downto 0);
signal ROUT2 : std_logic_vector(REGISTER_DATA_WIDTH-1 downto 0);
signal ROUT3 : std_logic_vector(REGISTER_DATA_WIDTH-1 downto 0);
signal ROUTPC : std_logic_vector(PC_DATA_WIDTH-1 downto 0);
signal ROUTIR : std_logic_vector(IR_DATA_WIDTH-1 downto 0);

signal MData : std_logic_vector(REGISTER_DATA_WIDTH-1 downto 0);

signal BUS_DATA : std_logic_vector(REGISTER_DATA_WIDTH-1 downto 0);
signal MUX0_DATA : std_logic_vector(REGISTER_DATA_WIDTH-1 downto 0);
signal MUX1_DATA : std_logic_vector(REGISTER_DATA_WIDTH-1 downto 0);

signal ALURes : std_logic_vector(REGISTER_DATA_WIDTH-1 downto 0);


	Component Reg is
		generic (
			REG_DATA_WIDTH : integer := 7
		);
		port (
		CLK,LD : in std_logic;		
		RIN : in std_logic_vector(REG_DATA_WIDTH-1 downto 0);
		ZR : out std_logic;
		ROUT : out std_logic_vector(REG_DATA_WIDTH-1 downto 0)
		);
	end component; 
	
	component PC is
		generic (
			REG_DATA_WIDTH : integer := 7
		);
		port (
		CLK,LD,INC,CLR : in std_logic;		
		RIN : in std_logic_vector(REG_DATA_WIDTH-1 downto 0);
		ROUT : out std_logic_vector(REG_DATA_WIDTH-1 downto 0)
		);
	end component;
		
	component IR is
		generic (
			REG_DATA_WIDTH : integer := 7
		);
		port (
		CLK,LD : in std_logic;		
		RIN : in std_logic_vector(REG_DATA_WIDTH-1 downto 0);
		ROUT : out std_logic_vector(REG_DATA_WIDTH-1 downto 0)
		); 
		
	end component;
		
	component ROM is
		generic (
			DATA_WIDTH : integer := 7;
			ADDR_WIDTH : integer := 6
		);
		port (		  	   						   				   
		Addr : in std_logic_vector (ADDR_WIDTH-1 downto 0);
		Data : inout std_logic_vector (DATA_WIDTH-1 downto 0)
		);
		
	end component;
		
	component ALU is
		generic (
			REG_DATA_WIDTH : integer := 7
		);
		port (
		CMD : in std_logic_vector(1 downto 0);		
		I0, I1 : in std_logic_vector(REG_DATA_WIDTH-1 downto 0);
		Result : out std_logic_vector(REG_DATA_WIDTH-1 downto 0)
		); 
		
	end component;
	
	component MUX41 is
		generic (
			REG_DATA_WIDTH : integer := 7
		);
		port (
		S1, S0 : in std_logic;		
		I0, I1, I2, I3 : in std_logic_vector(REG_DATA_WIDTH-1 downto 0);
		MUXOUT : out std_logic_vector(REG_DATA_WIDTH-1 downto 0)
		); 
	end component;

	component MUX21 is
		generic (
			REG_DATA_WIDTH : integer := 7
		);
		port (
		S : in std_logic;		
		I0, I1 : in std_logic_vector(REG_DATA_WIDTH-1 downto 0);
		MUXOUT : out std_logic_vector(REG_DATA_WIDTH-1 downto 0)
		); 
	end component;
	
	component Control is
		generic (
			IR_DATA_WIDTH : integer := 7
		);
		port (
		clock,reset : in std_logic;		
		ZR0,ZR1,ZR2,ZR3 : in std_logic;
		CROUTIR : in std_logic_vector(IR_DATA_WIDTH-1 downto 0);
		LD0,LD1,LD2,LD3,LDPC,LDIR,S00,S01,S10,S11,BUS_Sel,INC,RST : out std_logic;
		CMD : out std_logic_vector(1 downto 0)
		); 
	end component;
	
begin

	----memory instance
REG1 : Reg 
	generic map (REG_DATA_WIDTH => REGISTER_DATA_WIDTH)
	port map(CLK => clk ,LD => ld0, RIN => BUS_DATA , ZR => zr0 , ROUT => ROUT0);	

REG2 : Reg 
	generic map (REG_DATA_WIDTH => REGISTER_DATA_WIDTH)
	port map(CLK => clk ,LD => ld1, RIN => BUS_DATA , ZR => zr1 , ROUT => ROUT1);	
	
REG3 : Reg 
	generic map (REG_DATA_WIDTH => REGISTER_DATA_WIDTH)
	port map(CLK => clk ,LD => ld2, RIN => BUS_DATA , ZR => zr2 , ROUT => ROUT2);	
	
REG4 : Reg 
	generic map (REG_DATA_WIDTH => REGISTER_DATA_WIDTH)
	port map(CLK => clk ,LD => ld3, RIN => BUS_DATA , ZR => zr3 , ROUT => ROUT3);	
	
PCUNIT : PC 
	generic map (REG_DATA_WIDTH => PC_DATA_WIDTH)
	port map(CLK => clk ,LD => ldpc, INC => inc, CLR => rst, RIN => BUS_DATA , ROUT => ROUTPC);	
	
IRUNIT : IR 
	generic map (REG_DATA_WIDTH => IR_DATA_WIDTH)
	port map(CLK => clk ,LD => ldir, RIN => BUS_DATA ,ROUT => ROUTIR);	

ROMUNIT : ROM 						 	
	generic map (DATA_WIDTH => REGISTER_DATA_WIDTH , ADDR_WIDTH => IR_DATA_WIDTH)
	port map(Addr => ROUTPC, Data => MData);
	
MUX0 : MUX41 
	generic map (REG_DATA_WIDTH => REGISTER_DATA_WIDTH)
	port map(I0 => ROUT0, I1 => ROUT1, I2 => ROUT2, I3 => ROUT3, MUXOUT => MUX0_DATA,S1 => s01, S0 => s00);

MUX1 : MUX41 
	generic map (REG_DATA_WIDTH => REGISTER_DATA_WIDTH)
	port map(I0 => ROUT0, I1 => ROUT1, I2 => ROUT2, I3 => ROUT3, MUXOUT => MUX1_DATA,S1 => s11, S0 => s10);

MUXBUS : MUX21 
	generic map (REG_DATA_WIDTH => REGISTER_DATA_WIDTH)
	port map(I0 => MData, I1 => ALURes, MUXOUT => BUS_DATA,S => BUS_Sel);

ALUUNIT : ALU 
	generic map (REG_DATA_WIDTH => REGISTER_DATA_WIDTH)
	port map(I0 => MUX0_DATA, I1 => MUX1_DATA, CMD => cmd, Result => ALURes); 
	
CONTROLLER : Control
		generic map (
			IR_DATA_WIDTH => IR_DATA_WIDTH
		)
		port map (
		clock => clk ,reset => ControlRST,		
		ZR0 => zr0,ZR1 => zr1,ZR2 => zr2,ZR3 => zr3,
		CROUTIR => ROUTIR,
		LD0 => ld0,LD1 => ld1,LD2 => ld2,LD3 => ld3,LDPC => ldpc,LDIR => ldir,S00 => s00,S01 => s01,S10 => s10,S11 => s11,BUS_Sel => bus_sel,
		CMD => cmd,INC => inc,RST => rst); 
		
end behaviour;