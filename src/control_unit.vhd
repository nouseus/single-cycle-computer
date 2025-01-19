library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---------------------------------------------------
--control unit; 
--only unit that requires clk in single cycle.
--
--related to program counter and ROM, determines
--
--da, aa, ba addresses 
--mb, md, fs selections
--rw, mw  controls.
--
--zero fill output which means constant in input.
---------------------------------------------------

entity control_unit is
port(
			clk : in  STD_LOGIC;
			zerofill_out: out std_logic_vector(15 downto 0);
			da_out, ba_out, aa_out	: out std_logic_vector(2 downto 0);
			mb_out, md_out, rw_out  : out std_logic;
			fs_out: out std_logic_vector(3 downto 0)
);
end control_unit;  

architecture Behavioral of control_unit is


	signal count : std_logic_vector(2 downto 0):="000";

--ROM definitions
	type rom_type is array (0 to 15) of std_logic_vector (15 downto 0);
	

	-- edit here to give instructions to processes (max 16 processes):
signal rom : rom_type :=(											--example processes:
									"0001110000000111",				--0th process  r0<=sl r7
									"0001101001000110",				--1st process  r1<=sr r6
									"0000101000001000",				--2nd process  r0<=r1-r0
									"0000010111000100",				--3rd process  r7<=r0+r4
									"0001011011011000",				--4th process  r3<=not r3
									"1000001011011000",				--5th process  r3<=r3+1
									"0000010110111011",				--6th process  r6<=r7+r3
									others => "xxxxxxxxxxxxxxxx"	);

	
	signal instruction : std_logic_vector(15 downto 0);

begin

	--program counter processes
	pc:process (clk) 
		begin
			if rising_edge(clk) then
				count <= count + "001";
			end if;
		end process;
		
	--ROM processes
		instruction<=rom(conv_integer(count));
		
	--decoder processes
		da_out<=instruction(8 downto 6);
		ba_out<=instruction(2 downto 0);
		aa_out<=instruction(5 downto 3);
		mb_out<=instruction(15);
		fs_out<=instruction(12 downto 9);
		md_out<=instruction(13);
		rw_out<= not(instruction(14));
		
	--zerofill processes
		zerofill_out<="0000000000000"&instruction(2 downto 0);
		
	
end Behavioral;
