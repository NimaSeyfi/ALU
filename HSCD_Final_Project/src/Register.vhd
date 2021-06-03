library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Reg is
	generic (
		REG_DATA_WIDTH : integer := 7
	);
	port (
	CLK,LD : in std_logic;		
	RIN : in std_logic_vector(REG_DATA_WIDTH-1 downto 0);
	ZR : out std_logic;
	ROUT : out std_logic_vector(REG_DATA_WIDTH-1 downto 0)
	); 
	
end Reg;

architecture behaviour of Reg is															  
   signal zero : std_logic_vector(REG_DATA_WIDTH-1 downto 0) := (others => '0');
   signal temp : std_logic_vector(REG_DATA_WIDTH-1 downto 0);
begin
	
	-----------------------------------------------------------------------------------------------------------------
	----LOAD DATA
	PROCESS (CLK)
   	BEGIN     
		IF (CLK'EVENT AND CLK='1') THEN
  			if LD='1' then
				temp <= RIN;
				
      		end if;
		END IF;  
	END PROCESS;
	ROUT <= temp;
   	----CHECK ZERO
	ZR <= '1' when (temp=zero)
				else '0';
	----------------------------------------------------------------------------------------------------------

end behaviour;