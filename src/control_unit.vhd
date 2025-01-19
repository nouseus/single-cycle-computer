library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity control_unit is
port(
			clk : in  STD_LOGIC;
			V,C,N,Z : in  std_logic;
			zerofill_out: out std_logic_vector(15 downto 0);
			a_in: in std_logic_vector(15 downto 0);
			da_out, ba_out, aa_out	: out std_logic_vector(2 downto 0);
			mb_out, md_out, rw_out, mw_out: out std_logic;
			fs_out: out std_logic_vector(3 downto 0)
);
end control_unit;  

architecture Behavioral of control_unit is

	signal count,AD : std_logic_vector(5 downto 0):="000000";
	signal pl,jb,bc : std_logic;

--ROM definitions. Due to the 6 bits limitation of program counter (count), the capacity of ROM sis 64 rows.
	type rom_type is array (0 to 63) of std_logic_vector (15 downto 0);

signal rom : rom_type :=(	
			others => "0000000000000000"	);			
	
	signal instruction : std_logic_vector(15 downto 0);

begin
	-- edit here to give instructions to processes (max 16 processes):
rom(0)<="1001100111000001";	--(0)R7<-1 
rom(1)<="1100000101101010";	--(1)BRZ, R5, 2
rom(2)<="0000000000100000";	--(2)R0<-R4
rom(3)<="0000010100000100";	--(3)R4<-R0+R4
rom(4)<="0000110101101000";	--(4)R5<-R5-1
rom(5)<="1110000000111000";	--(5)JUMP, R7

	--program counter processes
	pc:process (clk) 
		begin		
			if rising_edge(clk) then			
				if pl='0' then 
					count <= count + "000001"; --count up
				else
					if jb='1' then 
						count<= a_in(5 downto 0);	--Jump
					else
						if bc='1' then 								
							if N='1' then
								count <= count + AD; --branch on negative	
							else
								count <= count + "000001"; 
							end if;
						else 
							if Z='1' then
								count <= count + AD; --branch on zero
							else
								count <= count + "000001"; 
							end if;				
						end if;
					end if;
				end if;	
			end if;
		end process;	
		
		
	--ROM processes
		instruction<=rom(conv_integer(count));
		
	--decoder processes
		da_out <= instruction(8 downto 6);
		ba_out <= instruction(2 downto 0);
		aa_out <= instruction(5 downto 3);
		mb_out <= instruction(15);
		md_out <= instruction(13);
		rw_out <= not(instruction(14));
		mw_out <= instruction(14) and not(instruction(15));	
		fs_out <= instruction(12 downto 10)&(instruction(9)and not(instruction(14) and instruction(15)));
		pl <= instruction(14) and instruction(15);	
		jb <= instruction(13);
		bc <= instruction(9);
		
	--zerofill processes
		zerofill_out<="0000000000000"&instruction(2 downto 0);
	--extend process
		AD<=instruction(8 downto 6)&instruction(2 downto 0);
		
end Behavioral;
