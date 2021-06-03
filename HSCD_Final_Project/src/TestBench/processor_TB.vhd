library ieee;
use ieee.NUMERIC_STD.all;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...

entity processor_tb is
	-- Generic declarations of the tested unit
		generic(
		PC_DATA_WIDTH : INTEGER := 7;
		REGISTER_DATA_WIDTH : INTEGER := 7;
		IR_DATA_WIDTH : INTEGER := 7 );
end processor_tb;

architecture TB_ARCHITECTURE of processor_tb is
	-- Component declaration of the tested unit
	component processor
		generic(
		PC_DATA_WIDTH : INTEGER := 7;
		REGISTER_DATA_WIDTH : INTEGER := 7;
		IR_DATA_WIDTH : INTEGER := 7 );
	port(
		clk : in STD_LOGIC;
		ControlRST : in STD_LOGIC );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal clk : STD_LOGIC;
	signal ControlRST : STD_LOGIC;
	-- Observed signals - signals mapped to the output ports of tested entity

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : processor
		generic map (
			PC_DATA_WIDTH => PC_DATA_WIDTH,
			REGISTER_DATA_WIDTH => REGISTER_DATA_WIDTH,
			IR_DATA_WIDTH => IR_DATA_WIDTH
		)

		port map (
			clk => clk,
			ControlRST => ControlRST
		);

	-- Add your stimulus here ...
clk_process :process
	   begin
		   clk <= '0';  
	        wait for 5ns;
	        clk <= '1';  
	        wait for 5ns;
	   end process;
	   
ControlRST <='0','1' after 5ns ,'0' after 10ns;	

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_processor of processor_tb is
	for TB_ARCHITECTURE
		for UUT : processor
			use entity work.processor(behaviour);
		end for;
	end for;
end TESTBENCH_FOR_processor;

