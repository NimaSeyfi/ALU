library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity PC is
	generic (
		REG_DATA_WIDTH : integer := 7
	);
	port (
	CLK,LD,INC,CLR : in std_logic;		
	RIN : in std_logic_vector(REG_DATA_WIDTH-1 downto 0) := (others => '0');
	ROUT : out std_logic_vector(REG_DATA_WIDTH-1 downto 0):= (others => '0')
	); 
	
end PC;

architecture behaviour of PC is															  
   signal zero : std_logic_vector(REG_DATA_WIDTH-1 downto 0) := (others => '0');
   signal temp : std_logic_vector(REG_DATA_WIDTH-1 downto 0) := (others => '0');
begin
	
	-----------------------------------------------------------------------------------------------------------------
	----LOAD OR RESET DATA
	PROCESS (CLK)
   	BEGIN     
		IF (CLK'EVENT AND CLK='1') THEN
			if CLR='1' then	 --synchronized reset
				temp <= zero;
			elsif INC='1' then
				temp <= std_logic_vector(unsigned(temp) + 1); --synchronized INC	
  			elsif LD='1' then
				temp <= RIN;
      		end if;
		
		END IF; 
	 
	END PROCESS;
	ROUT <= temp;

end behaviour;