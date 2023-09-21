------------------------------------------------------------------------
-- Library Name : testbench 16 bits monitor
-- Unit Name : mo_tb_16bits
------------------------------------------------------------------------
-- Date : Nov. 22, 2022
-- Designer : Yijun li & Ning lin
-- Description : testbench for 16 bits regisger output with end_flag 
--test possible 10 combinations for inputs A & B (8 bits)
--[rounding off]
--result 0*63(3F)=0->0->1
--1*31(1F)=001F->7->8[->9],
--1*1=1->0->1
--maxFF*maxFF=FE01(1111 1110 0000 0001)->3F80(0011 1111 1000 0000)->3F81
--171(AB)*205(CD)=88EF(1000 1000 1110 1111)
--->223B(0010 0010 0011 1011)->223C(0010 0010 0011 1100)[->223D(1101)]
--205(CD)*239(EF)=BF63(1011 1111 0110 0011)
--->2FD8(0010 1111 1101 1000)->2FD9(0010 1111 1101 1001)[->2FDA(1010)]
------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--judge the unsigned and signed values

entity mo_tb_16bits is
port(
	 A : in unsigned(7 downto 0);
	 B : in unsigned(7 downto 0);
	 end_flag : in std_logic;
	 Z : in signed(15 downto 0));
end mo_tb_16bits;

architecture arc_mo_tb_16bits of mo_tb_16bits is
signal A_B,Z_test : std_logic_vector(15 downto 0);
signal result: std_logic := '1';
begin
A_B <= std_logic_vector(A) & std_logic_vector(B);
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
		  (A_B=X"0101" and Z_test=X"0001") or
	      (A_B=X"FFFF" and Z_test=X"3F81") or
		  (A_B=X"ABCD" and Z_test=X"223D") or
		  (A_B=X"CDAB" and Z_test=X"223D") or
		  (A_B=X"CDEF" and Z_test=X"2FDA") or
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
		
end arc_mo_tb_16bits;