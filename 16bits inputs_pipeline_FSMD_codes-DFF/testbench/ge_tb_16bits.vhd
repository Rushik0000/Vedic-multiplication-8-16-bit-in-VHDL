--------------------------------------------------------------------------
-- Library Name : testbench 16 bits generator 
-- Unit Name : ge_tb_16bits
--------------------------------------------------------------------------
-- Date : Nov. 22, 2022
-- Designer : Yijun li & Ning Lin
-- Description : testbench for 8 bits regisger for multiplicand
--list possible 10 combinations for inputs A & B (16 bits)
--particularly 0*16383(3FFF),1*8191(1FFF),1*1,max65535(FFFF)*max(FFFF)
--generic 4660(1234)*43981(ABCD),22136(5678)*52719(CDEF),then A exchange with B
--------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ge_tb_16bits is
port(
     clk : out std_logic;
	 load : out std_logic;
	 clear : out std_logic;
	 A : out unsigned(15 downto 0);
	 B : out unsigned(15 downto 0));
end ge_tb_16bits;

architecture arc_ge_tb_16bits of ge_tb_16bits is
    --signal clk_dq,rst_dq,en_dq : std_logic;
	
component ge_tb_en_16 is
	port(
		clk: out std_logic;
		rst: out std_logic;
		en: out std_logic);
end component;

begin
-- generator of clock load reset
en_gene: ge_tb_en_16
 port map(clk => clk,rst => clear,en => load);
-- generate A B for 10 cases	
process
	begin
		    
	A <= X"0000"; B <= X"3FFF";
    wait for 360 ns;
	A <= X"3FFF"; B <= X"0000";
    wait for 360 ns;
	A <= X"0001"; B <= X"1FFF";
    wait for 360 ns;
	A <= X"1FFF"; B <= X"0001";
    wait for 360 ns;
	A <= X"0001"; B <= X"0001";
    wait for 360 ns;
	A <= X"FFFF"; B <= X"FFFF";
    wait for 360 ns;
	A <= X"1234"; B <= X"ABCD";
    wait for 360 ns;
	A <= X"ABCD"; B <= X"1234";
    wait for 360 ns;
	A <= X"5678"; B <= X"CDEF";
    wait for 360 ns;
	A <= X"CDEF"; B <= X"5678";
    wait;
  -- 360ns/20ns(clk)=18-even not odd  
end process;
		
end arc_ge_tb_16bits;