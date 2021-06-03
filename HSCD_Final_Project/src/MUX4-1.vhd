library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity MUX41 is
	generic (
		REG_DATA_WIDTH : integer := 7
	);
	port (
	S1, S0 : in std_logic;		
	I0, I1, I2, I3 : in std_logic_vector(REG_DATA_WIDTH-1 downto 0);
	MUXOUT : out std_logic_vector(REG_DATA_WIDTH-1 downto 0)
	); 
	
end MUX41;

architecture behaviour of MUX41 is															  
begin
	
	-----------------------------------------------------------------------------------------------------------------
	----ROUTE DATA
	PROCESS(S1,S0,I0,I1,I2,I3)
	BEGIN
	MUXOUT <= I0; --Avoid Latches
	
	if S1='0' then
		if S0='0' then
			MUXOUT <= I0;
		elsif S0='1' then
			MUXOUT <= I1; 
		end if;
	elsif S1='1' then
		if S0='0' then
			MUXOUT <= I2;
		elsif S0='1' then
			MUXOUT <= I3; 
		end if;	
	end if;
	END PROCESS;
	----------------------------------------------------------------------------------------------------------

end behaviour;