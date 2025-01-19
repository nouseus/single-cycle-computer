library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity func_unit is
    Port ( 
			  a_in 	: in  STD_LOGIC_VECTOR (15 downto 0);
           b_in 	: in  STD_LOGIC_VECTOR (15 downto 0);
           data_out 	: out  STD_LOGIC_VECTOR (15 downto 0);
           fs 	: in  STD_LOGIC_VECTOR (3 downto 0);
			  V,C,N,Z	: out std_logic
			  );
end func_unit;

architecture Behavioral of func_unit is 
	signal buffer_value:std_LOGIC_VECTOR(16 downto 0);
begin


process (a_in,b_in,fs)
begin
   case fs is	-- operators
      when "0000" => buffer_value <= '0'&a_in;
      when "0001" => buffer_value <= ('0'&a_in)+1;
		when "0010" => buffer_value <= ('0'&a_in)+('0'&b_in);
		when "0011" => buffer_value <= ('0'&a_in)+('0'&b_in)+1;
		when "0100" => buffer_value <= ('0'&a_in)+not(('0'&b_in));
      when "0101" => buffer_value <= ('0'&a_in)+not(('0'&b_in))+1;
		when "0110" => buffer_value <= ('0'&a_in)-1;
		when "0111" => buffer_value <= ('0'&a_in);
		when "1000" => buffer_value <= '0'&(a_in and b_in);
      when "1001" => buffer_value <= '0'&(a_in or b_in);
		when "1010" => buffer_value <= '0'&(a_in xor b_in);
		when "1011" => buffer_value <= '0'& not(a_in);
		when "1100" => buffer_value <= '0'&b_in;
      when "1101" => buffer_value <= '0'&('0'&b_in(15 downto 1));--srB
		when "1110" => buffer_value <= '0'&(b_in(14 downto 0)&'0');--rlB
      when others => buffer_value <= "XXXXXXXXXXXXXXXXX";
   end case;
end process;

process (buffer_value)
begin
	if (buffer_value(15 downto 0)="0000000000000000") then
		Z<='1';
	else
		Z<='0';
	end if;
end process;

process (a_in,b_in,buffer_value)
begin
	if (a_in(15)='1' and b_in(15)='1' and buffer_value(15)='0') then
		V<='1';
	elsif (a_in(15)='0' and b_in(15)='0' and buffer_value(15)='1') then
		V<='1';
	else
		V<='0';
	end if;
end process;

C<=buffer_value(16);
N<=buffer_value(15);

data_out<=buffer_value(15 downto 0);



end Behavioral;
