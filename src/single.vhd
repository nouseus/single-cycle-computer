library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity single is
port(
	clk : in std_logic
);
end single;  

architecture Behavioral of single is

	signal zero_fill_sig,a_bus_sig,b1_sig,b2_sig,d1_sig,d2_sig,memory_out_sig:std_logic_vector(15 downto 0);
	signal da,ba,aa:std_logic_vector(2 downto 0);
	signal fs:std_logic_vector(3 downto 0);
	signal mb,md,rw,mw:std_logic;	
	signal V,C,N,Z:std_logic;	
	

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
				V,C,N,Z : in  std_logic;
				zerofill_out: out std_logic_vector(15 downto 0);
				a_in: in std_logic_vector(15 downto 0);
				da_out, ba_out, aa_out	: out std_logic_vector(2 downto 0);
				mb_out, md_out, rw_out, mw_out: out std_logic;
				fs_out: out std_logic_vector(3 downto 0)
	);
	end component; 	
	
	
	component func_unit is
    Port ( 
			  a_in 	: in  STD_LOGIC_VECTOR (15 downto 0);
           b_in 	: in  STD_LOGIC_VECTOR (15 downto 0);
           data_out 	: out  STD_LOGIC_VECTOR (15 downto 0);
           fs 	: in  STD_LOGIC_VECTOR (3 downto 0);
			  V,C,N,Z	: out std_logic
			  );
	end component;
	
	component DataMemory is
    Port ( MW : in  STD_LOGIC;									
           Data_in : in  STD_LOGIC_VECTOR (15 downto 0);			
           Address : in  STD_LOGIC_VECTOR (15 downto 0);				
           Data_out : out  STD_LOGIC_VECTOR (15 downto 0);	
			  clk		: in std_LOGIC);	
	end component;

begin

	muxb:Mux2x1_16bit port map(		
				I1	=> zero_fill_sig,
				I0	=>b1_sig,
				S	=>mb,
				O	=>b2_sig
	);	
	
	muxd:Mux2x1_16bit port map(		
				I1	=>memory_out_sig,
				I0	=>d1_sig,
				S	=>md,
				O	=>d2_sig
	);	

   reg_file:reg Port map( 
				rw =>rw,
				da =>da,
				aa =>aa,
				ba=>ba,
				data_in =>d2_sig,
				a_out =>a_bus_sig,
				b_out =>b1_sig,
				clk=>clk
	);		

	control:control_unit port map(
				clk =>clk,
				zerofill_out=>zero_fill_sig,
				da_out=>da,
				ba_out=>ba,
				aa_out=>aa,
				mb_out=>mb ,
				md_out=>md ,
				rw_out=>rw ,
				fs_out=>fs,
				mw_out=>mw,
				V=>V,
				C=>C,
				N=>N,
				Z=>Z,
				a_in=>a_bus_sig
	);		
	
   alu:func_unit Port map( 
				a_in =>a_bus_sig,
				b_in =>b2_sig,
				data_out =>d1_sig,
				fs =>fs,
				V=>V,
				C=>C,
				N=>N,
				Z=>Z				
	);
	
	memory:DataMemory Port map( 
				MW 		=> mw,				
				Data_in 	=> b2_sig,
				Address	=> a_bus_sig,
				Data_out	=> memory_out_sig,
				clk		=> clk	
	);	

   
	
end Behavioral;
