library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ROM is
	generic (
		DATA_WIDTH : integer := 7;
		ADDR_WIDTH : integer := 7
	);
	port (		  		   				   
	Addr : in std_logic_vector (ADDR_WIDTH-1 downto 0);
	Data : inout std_logic_vector (DATA_WIDTH-1 downto 0)
	);
	
end ROM;

architecture behaviour of ROM is															  
    Type MyMem is array (2** ADDR_WIDTH-1 downto 0) of std_logic_vector (DATA_WIDTH-1 downto 0);
	signal Mem  :  MyMem;	

begin 
	--even counter bellow 10
	--mem(0) <= "0000011";
	--mem(1) <= "0000000";
	--mem(2) <= "0000111";
	--mem(3) <= "0001010";
	--mem(4) <= "0001011";
	--mem(5) <= "0000010";
	--mem(6) <= "0010001";
	--mem(7) <= "0100110";
	--mem(8) <= "0110100";
	--mem(9) <= "0000110";
	--mem(10) <= "0000000";
	
	--5+3
	--mem(0) <= "0000011";
	--mem(1) <= "0000101";
	--mem(2) <= "0000111";
	--mem(3) <= "0000011";
	--mem(4) <= "0010001";
	--mem(5) <= "0000000";
	
	--7*8 without MUL
	--mem(0) <= "0000011";
	--mem(1) <= "0000111";
	--mem(2) <= "0000111";
	--mem(3) <= "0001000";
	--mem(4) <= "0001011";
	--mem(5) <= "0001000";
	--mem(6) <= "0001111";
	--mem(7) <= "0000001";
	--mem(8) <= "0100011";
	--mem(9) <= "0010110";
	--mem(10) <= "0100011";
	--mem(11) <= "0110000";
	--mem(12) <= "0001001";
	--mem(13) <= "0000000";	 
	
	--7*8  with MUL
	mem(0) <= "0000011";
	mem(1) <= "0000111";
	mem(2) <= "0000111";
	mem(3) <= "0001000";
	mem(4) <= "1000001";
	mem(5) <= "0000000";

	Data <= Mem(to_integer(unsigned(Addr)));

end behaviour;