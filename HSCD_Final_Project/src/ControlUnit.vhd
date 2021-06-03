library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Control is
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
	
end Control;

architecture behaviour of Control is															  
   TYPE states IS (S0, S1, S2, S3, S4, S5, S6, S7, S8);
   SIGNAL pr_state, nx_state: states;

alias OP : std_logic_vector(2 downto 0) is CROUTIR(6 downto 4);
alias RX : std_logic_vector(1 downto 0) is CROUTIR(3 downto 2);
alias RY : std_logic_vector(1 downto 0) is CROUTIR(1 downto 0);

begin
	
	-----------------------------------------------------------------------------------------------------------------
	----control (sequential part)
	PROCESS (clock)
   
		BEGIN
      
			IF (reset='1') THEN
         
				pr_state <= S0;
      
			ELSIF (clock'EVENT AND clock='1') THEN
  
				pr_state <= nx_state;
      
			END IF;
   
		END PROCESS;
	
   	----control (combinatial part)
	PROCESS (pr_state, OP, RX, RY)  
	BEGIN	   
		LD0 <= '0';
		LD1 <= '0';
		LD2 <= '0';
		LD3 <= '0';
		LDPC <= '0';
		LDIR <= '0';
		S00 <= '0';
		S01 <= '0';
		S10 <= '0';
		S11 <= '0';
		BUS_Sel <= '0';
		CMD <= "00";
		INC <= '0';
		RST <= '0';
      		nx_state <= pr_state;
			CASE pr_state IS
         		WHEN S0 =>
					nx_state <= S1;
					RST <= '1';
					
				WHEN S1 =>	 
				LDIR <= '1';
				INC <= '1';
				BUS_SEL <= '0';
				
				if  OP = "000" then
					if RY="00" then	 -- HLT
						nx_state <= S2; --HLT State
					else
						nx_state <= S3; --Load
					end if;
				elsif OP = "001" then
					nx_state <= S4;
				elsif OP = "010" then
					nx_state <= S5;	
				elsif OP = "100" then
					nx_state <= S8;
				else 
					if RX="00" then
						if ZR0 = '1' then
							nx_state <= S7;
						else
							nx_state <= S6;
						end if;
					end if;
					if RX="01" then
						if ZR1 = '1' then
							nx_state <= S7;
						else
							nx_state <= S6;
						end if;
					end if;
					if RX="10" then
						if ZR2 = '1' then
							nx_state <= S7;
						else
							nx_state <= S6;
						end if;
					end if;
					if RX="11" then
						if ZR3 = '1' then
							nx_state <= S7;
						else
							nx_state <= S6;
						end if;
					end if;
				end if;
				
				WHEN S2 => 
				nx_state <= S2;
				
				
  				WHEN S3 => 	
				  				
				INC <= '1';
				BUS_Sel <= '0';
				if RX="00" then
					LD0<='1';
				elsif RX="01" then
					LD1<='1';
				elsif RX="10" then
					LD2<='1';
				else
					LD3<='1';
				end if;
				
				nx_state <= S1; 
				
				WHEN S4 => 
				nx_state <= S1;
				
				CMD <= "00";
				BUS_Sel <= '1';
				S00 <= RX(0);
				S01 <= RX(1);
				S10 <= RY(0);
				S11 <= RY(1);
				
				if RX="00" then
					LD0<='1';
				elsif RX="01" then
					LD1<='1';
				elsif RX="10" then
					LD2<='1';
				else
					LD3<='1';
				end if;
				
				WHEN S5 => 
				nx_state <= S1;
				
				CMD <= "01";
				BUS_Sel <= '1';
				S00 <= RX(0);
				S01 <= RX(1);
				S10 <= RY(0);
				S11 <= RY(1);
				
				if RX="00" then
					LD0<='1';
				elsif RX="01" then
					LD1<='1';
				elsif RX="10" then
					LD2<='1';
				else
					LD3<='1';
				end if;
				
				WHEN S6 => 
				nx_state <= S1; 
				
				LDPC <= '1';
				BUS_Sel <= '0';
				
      			WHEN S7 => 
				nx_state <= S1; 
				
				INC <= '1';
				
				WHEN S8 => 
				nx_state <= S1;
				
				CMD <= "10";
				BUS_Sel <= '1';
				S00 <= RX(0);
				S01 <= RX(1);
				S10 <= RY(0);
				S11 <= RY(1);
				
				if RX="00" then
					LD0<='1';
				elsif RX="01" then
					LD1<='1';
				elsif RX="10" then
					LD2<='1';
				else
					LD3<='1';
				end if;

			END CASE;
   
		END PROCESS;  
	----------------------------------------------------------------------------------------------------------

end behaviour;