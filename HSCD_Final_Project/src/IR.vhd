library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity IR is
	generic (
		REG_DATA_WIDTH : integer := 7
	);
	port (
	CLK,LD : in std_logic;		
	RIN : in std_logic_vector(REG_DATA_WIDTH-1 downto 0);
	ROUT : out std_logic_vector(REG_DATA_WIDTH-1 downto 0)
	); 
	
end IR;

architecture behaviour of IR is															  
   signal zero : std_logic_vector(REG_DATA_WIDTH-1 downto 0) := (others => '0');
   signal temp : std_logic_vector(REG_DATA_WIDTH-1 downto 0) := (others => '0');
begin
	
	-----------------------------------------------------------------------------------------------------------------
	----LOAD DATA
	PROCESS(RIN,LD)
   	BEGIN     
		--IF (CLK'EVENT AND CLK='1') THEN
  			if LD='1' then
				ROUT <= RIN;
      		end if;
		--END IF;  
	END PROCESS;


end behaviour;