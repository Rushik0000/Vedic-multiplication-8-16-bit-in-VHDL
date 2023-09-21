--------------------------------------------------------------------------
-- Library Name : testbench 8 bits generator 
-- Unit Name : ge_tb_8bits
--------------------------------------------------------------------------
-- Date : Nov. 22, 2022
-- Designer : Yijun li & Ning Lin
-- Description : testbench for 8 bits regisger for multiplicand
--list possible 10 combinations for inputs A & B (8 bits)
--particularly 0*63(3F),1*31(1F),1*1,max(1111 1111=FF)*max(1111 1111=FF)
--generic 171(AB)*205(CD),205(CD)*239(EF),221(DD)*238(EE),238(EE)*255(FF)
--in order to get the carry of accumulation of Z 
--------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ge_tb_8bits is
port(
     clk : out std_logic;
	 load : out std_logic;
	 clear : out std_logic;
	 A : out unsigned(7 downto 0);
	 B : out unsigned(7 downto 0));
end ge_tb_8bits;

architecture arc_ge_tb_8bits of ge_tb_8bits is
    --signal clk_dq,rst_dq,en_dq : std_logic;
	
component ge_tb_en is
	port(
		clk: out std_logic;
		rst: out std_logic;
		en: out std_logic);
end component;

begin
-- generator of clock load reset
en_gene: ge_tb_en
 port map(clk => clk,rst => clear,en => load);
-- generate A B for 10 cases	
process
	begin
		    
	A <= X"00"; B <= X"3F";
    wait for 600 ns;
	A <= X"3F"; B <= X"00";
    wait for 600 ns;
	A <= X"01"; B <= X"1F";
    wait for 600 ns;
	A <= X"1F"; B <= X"01";
    wait for 600 ns;
	A <= X"01"; B <= X"01";
    wait for 600 ns;
	A <= X"FF"; B <= X"FF";
    wait for 600 ns;
	A <= X"AB"; B <= X"CD";
    wait for 600 ns;
	A <= X"CD"; B <= X"EF";
    wait for 600 ns;
	A <= X"DD"; B <= X"EE";
    wait for 600 ns;
	A <= X"EE"; B <= X"FF";
    wait;
  -- 600ns/20ns(clk)=30-even not odd  
end process;
		
end arc_ge_tb_8bits;