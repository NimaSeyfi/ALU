library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity MUX21 is
	generic (
		REG_DATA_WIDTH : integer := 7
	);
	port (
	S : in std_logic;		
	I0, I1 : in std_logic_vector(REG_DATA_WIDTH-1 downto 0);
	MUXOUT : out std_logic_vector(REG_DATA_WIDTH-1 downto 0)
	); 
	
end MUX21;

architecture behaviour of MUX21 is															  
begin
	
	-----------------------------------------------------------------------------------------------------------------
	----ROUTE DATA
	PROCESS(S,I0,I1)
	BEGIN
	MUXOUT <= I0; --Avoid Latches
		if S='0' then
			MUXOUT <= I0;
		elsif S='1' then
			MUXOUT <= I1; 
		end if;
	
	END PROCESS;
	----------------------------------------------------------------------------------------------------------

end behaviour;