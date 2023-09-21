-----------------------------------------------------------------------
-- Library Name : testbench 16 bits monitor
-- Unit Name : mo_tb_16bits_signed
-----------------------------------------------------------------------
-- Date : Nov. 22, 2022
-- Designer : Yijun li & Ning lin
-- Description : testbench for 16 bits regisger output with end_flag 
--test possible 10 combinations for inputs A & B (8 bits)
--[rounding off]
--result 0*63(3F)=0->0->1
--1*31(1F)=001F->7->8[->9],
--min(-255=0000 0001)*min(-255=0000 0001)=FE01->3F80->3F81(0011 1111 1000 0001)
--max255*max255=FE01(1111 1110 0000 0001)->3F80->3F81(0011 1111 1000 0001)
--(-171)(-AB=0101 0101)(55)*205(CD=1100 1101)=(-35055)(-88EF)
--->(-223B)--+1-->(-223A)[--+1-->(-2239)]->DDC7(1101 1101 1100 0111)
--( -X+1 = -(X-1) )--> +1 for negative equals -1 for positive
--(-205)(-CD=0011 0011)(33)*(-239)(-EF=0001 0001)(11)=48995(BF63)
--->2FD8->2FD9[->2FDA](0010 1111 1101 1010)
-----------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--judge the unsigned and signed values

entity mo_tb_16bits_signed is
port(
	 A : in integer;
	 B : in integer;
	 end_flag : in std_logic;
	 Z : in signed(15 downto 0));
end mo_tb_16bits_signed;

architecture arc_mo_tb_16bits_signed of mo_tb_16bits_signed is
signal A_B,Z_test : std_logic_vector(15 downto 0);
signal result: std_logic := '1';
begin
A_B <= std_logic_vector(to_signed(A,8)) & std_logic_vector(to_signed(B,8));
Z_test <= std_logic_vector(Z);

process
begin
  for i in 1 to 10 loop
    wait for 585 ns;
    -- end_flag and Z value will change at 540 ns
    if end_flag='1' then
       if ((A_B=X"003F" and Z_test=X"0001") or
          (A_B=X"3F00" and Z_test=X"0001") or
          (A_B=X"011F" and Z_test=X"0009") or
	   	  (A_B=X"1F01" and Z_test=X"0009") or
		  (A_B=X"0101" and Z_test=X"3F81") or
	      (A_B=X"FFFF" and Z_test=X"3F81") or
		  (A_B=X"55CD" and Z_test=X"DDC7") or
		  (A_B=X"CD55" and Z_test=X"DDC7") or
		  (A_B=X"3311" and Z_test=X"2FDA") or
		  (A_B=X"EFCD" and Z_test=X"2FDA")) 
		  then        
		  result <= '1';
        else
          result <= '0';
        end if;
   else
   result <= '0';
   end if;  
    --error reporting
    assert result='1'
        report "test failed."
        severity note;
		--result=0->report error
		wait for 15 ns;
    end loop;
    wait;
end process;
		
end arc_mo_tb_16bits_signed;