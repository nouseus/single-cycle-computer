library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---------------------------------------------------
--register file which has 8 register, 16 bits each 
--independent from the clk, RAM architecture
---------------------------------------------------

entity reg is
    Port ( rw : in  STD_LOGIC;									--writes for rw=1 
           da : in  STD_LOGIC_VECTOR (2 downto 0);			--destination address
           aa : in  STD_LOGIC_VECTOR (2 downto 0);			--a channel reading address
           ba : in  STD_LOGIC_VECTOR (2 downto 0);			--b channel reading address
           data_in : in  STD_LOGIC_VECTOR (15 downto 0);	--write channel data input
           a_out : out  STD_LOGIC_VECTOR (15 downto 0);	--a channel data output
           b_out : out  STD_LOGIC_VECTOR (15 downto 0);  --a channel data output
			  clk		: in std_LOGIC);	
end reg;

architecture Behavioral of reg is

	type reg_type is array (7 downto 0) of std_logic_vector (15 downto 0);
	
	-- edit here to initialize registers:
	signal reg8x16: reg_type:=(							--example numbers:
											x"0031",				--r7 49
											x"0024",				--r6 36
											x"0019",				--r5 25
											x"0010",				--r4 16
											x"0009",				--r3 9
											x"0004",				--r2 4
											x"0000",				--r1 0
											x"0050");			--r0 80			

begin

	process (clk)
	begin
		if (rising_edge(clk)) then
			if (rw = '1') then
				reg8x16(conv_integer(da)) <= data_in;
			end if;
		end if;		
	end process;
	
	a_out <= reg8x16(conv_integer(aa));
	b_out <= reg8x16(conv_integer(ba));


end Behavioral;
