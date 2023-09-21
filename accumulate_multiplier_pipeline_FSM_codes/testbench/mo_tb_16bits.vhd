------------------------------------------------------------------------
-- Library Name : testbench 16 bits monitor
-- Unit Name : mo_tb_16bits
------------------------------------------------------------------------
-- Date : Nov. 22, 2022
-- Designer : Yijun li & Ning lin
-- Description : testbench for 16 bits regisger output with end_flag 
--test possible 10 combinations for inputs A & B (8 bits)
--[rounding off] result A:1010 B:1011 C:1100 D:1101 E:1110 F:1111
--1.0*63(3F)=0->0->1(0 0001)
--2.63(3F)*0=0->0->1; +: 2(0 0002)
--3.1*31(1F)=001F->7->8[->9]; +: 11(0 000B)
--4.31(1F)*1=001F->7->8[->9]; +: 20(0 0014)
--5.1*1=1->0->1; +: 21(0 0015)
--6.maxFF*maxFF=FE01->3F80->16257(3F81); +: 16278(0 3F96)
--7.171(AB)*205(CD)=88EF->223B->223C[->8765(223D)]; +: 37293(0 61D3)
--8.205(CD)*239(EF)=BF63->2FD8->2FD9[->12250(2FDA)]; +: 46058(0 91AD)
--9.221(DD)*238(EE)=CD76->335D->335E[->13151(335F)]; +: 59209(0 C50C)
--10.238(EE)*255(FF)=ED12->3B44->3B45[->15174(3B46)]; +: 74383(1 0052)
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
	 Z : in signed(19 downto 0));
end mo_tb_16bits;

architecture arc_mo_tb_16bits of mo_tb_16bits is
signal A_B : std_logic_vector(15 downto 0);
signal Z_test : std_logic_vector(19 downto 0);
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
       if ((A_B=X"003F" and Z_test=X"00001") or
           (A_B=X"3F00" and Z_test=X"00002") or
           (A_B=X"011F" and Z_test=X"0000B") or
	   	   (A_B=X"1F01" and Z_test=X"00014") or
		   (A_B=X"0101" and Z_test=X"00015") or
	       (A_B=X"FFFF" and Z_test=X"03F96") or
		   (A_B=X"ABCD" and Z_test=X"061D3") or
 	   	   (A_B=X"CDEF" and Z_test=X"091AD") or
		   (A_B=X"DDEE" and Z_test=X"0C50C") or
		   (A_B=X"EEFF" and Z_test=X"10052")) 
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