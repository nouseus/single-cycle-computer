library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity single is
port(
	clk : in std_logic;
	data_in:in std_logic_vector(15 downto 0)
);
end single;  

architecture Behavioral of single is

	signal zero_fill_ara,a_bus_ara,b1_ara,b2_ara,d1_ara,d2_ara:std_logic_vector(15 downto 0);
	signal da,ba,aa:std_logic_vector(2 downto 0);
	signal fs:std_logic_vector(3 downto 0);
	signal mb,md,rw:std_logic;	
	

	component Mux2x1_16bit is
	port(		I1	: 	in std_logic_vector(15 downto 0);
				I0	: 	in std_logic_vector(15 downto 0);
				S	:	in std_logic;
				O	:	out std_logic_vector(15 downto 0)
	);
	end component; 
	
	component reg is
    Port ( rw : in  STD_LOGIC;		
           da : in  STD_LOGIC_VECTOR (2 downto 0);
           aa : in  STD_LOGIC_VECTOR (2 downto 0);	
           ba : in  STD_LOGIC_VECTOR (2 downto 0);	
           data_in : in  STD_LOGIC_VECTOR (15 downto 0);	
           a_out : out  STD_LOGIC_VECTOR (15 downto 0);	
           b_out : out  STD_LOGIC_VECTOR (15 downto 0);	
           clk : in  STD_LOGIC);		
	end component;
	
	component control_unit is
	port(
				clk : in  STD_LOGIC;
				zerofill_out: out std_logic_vector(15 downto 0);
				da_out, ba_out, aa_out	: out std_logic_vector(2 downto 0);
				mb_out, md_out, rw_out  : out std_logic;
				fs_out: out std_logic_vector(3 downto 0)
	);
	end component; 
	
	component func_unit is
    Port ( a_in : in  STD_LOGIC_VECTOR (15 downto 0);
           b_in : in  STD_LOGIC_VECTOR (15 downto 0);
           data_out : out  STD_LOGIC_VECTOR (15 downto 0);
           fs : in  STD_LOGIC_VECTOR (3 downto 0));
	end component;

begin

	muxb:Mux2x1_16bit port map(		
				I1	=> zero_fill_ara,
				I0	=>b1_ara,
				S	=>mb,
				O	=>b2_ara
	);	
	
	muxd:Mux2x1_16bit port map(		
				I1	=>data_in,
				I0	=>d1_ara,
				S	=>md,
				O	=>d2_ara
	);	

   reg_file:reg Port map( 
				rw =>rw,
				da =>da,
				aa =>aa,
				ba=>ba,
				data_in =>d2_ara,
				a_out =>a_bus_ara,
				b_out =>b1_ara,
				clk=>clk
	);		

	control:control_unit port map(
				clk =>clk,
				zerofill_out=>zero_fill_ara,
				da_out=>da,
				ba_out=>ba,
				aa_out=>aa,
				mb_out=>mb ,
				md_out=>md ,
				rw_out=>rw ,
				fs_out=>fs
	);	

   alu:func_unit Port map( 
				a_in =>a_bus_ara,
				b_in =>b2_ara,
				data_out =>d1_ara,
				fs =>fs
	);

   
	
end Behavioral;
