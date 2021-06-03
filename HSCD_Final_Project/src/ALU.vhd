library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ALU is
	generic (
		REG_DATA_WIDTH : integer := 7
	);
	port (
	CMD : in std_logic_vector(1 downto 0);		
	I0, I1 : in std_logic_vector(REG_DATA_WIDTH-1 downto 0);
	Result : out std_logic_vector(REG_DATA_WIDTH-1 downto 0)
	); 
	
end ALU;

architecture behaviour of ALU is	

	signal MAN_Result : std_logic_vector((2*REG_DATA_WIDTH)-1 downto 0);
begin
	
	-----------------------------------------------------------------------------------------------------------------
	----CALCULATE DATA
	PROCESS(CMD,I0,I1)
	BEGIN
	Result <= I0; --Avoid Latches
		if CMD="00" then	  --AND
			Result <= std_logic_vector(unsigned(I0) + unsigned(I1)); --UNSIGNED AND
		elsif CMD="01" then --SUB
			Result <= std_logic_vector(unsigned(I0) - unsigned(I1)); --UNSIGNED SUB
		elsif CMD="10" then --MUL
			Result <= std_logic_vector(to_unsigned(to_integer(unsigned(I0)) * to_integer(unsigned(I1)), Result'length)); --UNSIGNED MUL	 
		end if;
	
	END PROCESS;
	----------------------------------------------------------------------------------------------------------

end behaviour;