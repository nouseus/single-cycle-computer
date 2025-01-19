library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Mux2x1_16bit is
port(		I1	: 	in std_logic_vector(15 downto 0);
			I0	: 	in std_logic_vector(15 downto 0);
			S	:	in std_logic;
			O	:	out std_logic_vector(15 downto 0)
);
end Mux2x1_16bit;  

architecture Behavioral of Mux2x1_16bit is
begin
    process(I1,I0,S)
    begin    
        case S is
			 when '0' =>	O <= I0;
			 when '1' =>	O <= I1;
			 when others =>	O <= "XXXXXXXXXXXXXXXX";
			end case;
    end process;
end Behavioral;
