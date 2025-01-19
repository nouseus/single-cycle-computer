library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity DataMemory is
    Port ( MW : in  STD_LOGIC;									
           Data_in : in  STD_LOGIC_VECTOR (15 downto 0);			
           Address : in  STD_LOGIC_VECTOR (15 downto 0);				
           Data_out : out  STD_LOGIC_VECTOR (15 downto 0);	
			  clk		: in std_LOGIC);	
end DataMemory;

architecture Behavioral of DataMemory is

	type mem_type is array (0 to 255) of std_logic_vector (15 downto 0);
	
	signal mem_cells: mem_type;

begin

	process (clk)
	begin
		if (rising_edge(clk)) then
			if (MW = '1') then
				mem_cells(conv_integer(Address(7 downto 0))) <= Data_in;
			end if;
		end if;		
	end process;
	
	Data_out <= mem_cells(conv_integer(Address(7 downto 0)));


end Behavioral;
