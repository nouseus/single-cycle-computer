library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity func_unit is
    Port ( a_in : in  STD_LOGIC_VECTOR (15 downto 0);
           b_in : in  STD_LOGIC_VECTOR (15 downto 0);
           data_out : out  STD_LOGIC_VECTOR (15 downto 0);
           fs : in  STD_LOGIC_VECTOR (3 downto 0));
end func_unit;

architecture Behavioral of func_unit is

begin


process (fs,a_in,b_in)
begin
   case fs is									
      when "0000" => data_out <= a_in;		
      when "0001" => data_out <= a_in+x"0001";  	
		when "0010" => data_out <= a_in+b_in;
		when "0011" => data_out <= a_in+b_in+x"0001";	
		when "0100" => data_out <= a_in + not(b_in);	
      when "0101" => data_out <= a_in + not(b_in)+x"0001";	
		when "0110" => data_out <= a_in-x"0001";			
		when "0111" => data_out <= a_in ;	
		
		when "1000" => data_out <= a_in and b_in;		
      when "1001" => data_out <= a_in or b_in;  	
		when "1010" => data_out <= a_in xor b_in;
		when "1011" => data_out <= not a_in;
		when "1100" => data_out <= b_in;	
		
		when "1101" => data_out <= '0'&b_in(15 downto 1);	--shift right
		when "1110" => data_out <= b_in(14 downto 0)&'0';	--shift left
		
      when others => data_out <= "XXXXXXXXXXXXXXXX";
   end case;
end process;


end Behavioral;
