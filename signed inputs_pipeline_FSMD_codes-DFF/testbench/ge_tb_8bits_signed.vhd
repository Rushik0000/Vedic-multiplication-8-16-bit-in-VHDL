-----------------------------------------------------------------------
-- Library Name : testbench 8 bits generator 
-- Unit Name : ge_tb_8bits_signed
-----------------------------------------------------------------------
-- Date : Nov. 30, 2022
-- Designer : Yijun li
-- Description : testbench for 8 bits regisger for multiplicand
--list possible 10 combinations for inputs A & B (8 bits signed)
--particularly 0*63(3F),1*31(1F),then A exchange with B
--min(-255)*min(-255),max(255)*max(255)
--(-+)(+-)(--)(++)
--(-171(-AB))*205(CD), 171(AB)*(-205(-CD))
--(-205(-CD))*(-239(-EF)), 205(CD)*239(EF)
-----------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ge_tb_8bits_signed is
port(
     clk : out std_logic;
	 load : out std_logic;
	 clear : out std_logic;
	 A : out integer;
	 B : out integer);
end ge_tb_8bits_signed;

architecture arc_ge_tb_8bits_signed of ge_tb_8bits_signed is
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
		    
	A <= 0; B <= 63;
    wait for 600 ns;
	A <= 63; B <= 0;
    wait for 600 ns;
	A <= 1; B <= 31;
    wait for 600 ns;
	A <= 31; B <= 1;
    wait for 600 ns;
	A <= -255; B <= -255;
    wait for 600 ns;
	A <= 255; B <= 255;
    wait for 600 ns;
	A <= -171; B <= 205;
    wait for 600 ns;
	A <= 171; B <= -205;
    wait for 600 ns;
	A <= -205; B <= -239;
    wait for 600 ns;
	A <= 205; B <= 239;
    wait;
  -- 600ns/20ns(clk)=30-even not odd  
end process;
		
end arc_ge_tb_8bits_signed;