------------------------------------------------------------------------
-- Library Name : testbench 32 bits monitor
-- Unit Name : mo_tb_32bits
------------------------------------------------------------------------
-- Date : Nov. 22, 2022
-- Designer : Yijun li & Ning lin
-- Description : testbench for 16 bits regisger output with end_flag 
--test possible 10 combinations for inputs A & B (16 bits)
--result 0*16383(3FFF)=0->0->1(0000 0001)
--1*8191(1FFF)=1FFF->2047(0000 07FF)->2048(0000 0800),
--1(0001)*1=1->0->1(0000 0001)
--max65535(FFFF)*maxFFFF=4294836225(FFFE 0001)
--->(3FFF 8000)->(3FFF 8001)
--4660(1234)*43981(ABCD)=204951460(0C37 4FA4)
--->(030D D3E9))->(030D D3EA)
--22136(5678)*52719(CDEF)=1166987784(458E D208)
--->(1163 B482)->(1163 B483)
--A:1010 B:1011 C:1100 D:1101 E:1110 F:1111
------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--judge the unsigned and signed values

entity mo_tb_32bits is
port(
	 A : in unsigned(15 downto 0);
	 B : in unsigned(15 downto 0);
	 end_flag : in std_logic;
	 Z : in signed(31 downto 0));
end mo_tb_32bits;

architecture arc_mo_tb_32bits of mo_tb_32bits is
signal A_B,Z_test : std_logic_vector(31 downto 0);
signal result: std_logic := '1';
begin
A_B <= std_logic_vector(A) & std_logic_vector(B);
Z_test <= std_logic_vector(Z);

process
begin
  for i in 1 to 10 loop
    wait for  345ns;
    -- end_flag and Z value will change at 300 ns
    if end_flag='1' then
       if ((A_B=X"00003FFF" and Z_test=X"00000001") or
           (A_B=X"3FFF0000" and Z_test=X"00000001") or
           (A_B=X"00011FFF" and Z_test=X"00000800") or
	   	   (A_B=X"1FFF0001" and Z_test=X"00000800") or
		   (A_B=X"00010001" and Z_test=X"00000001") or
	       (A_B=X"FFFFFFFF" and Z_test=X"3FFF8001") or
		   (A_B=X"1234ABCD" and Z_test=X"030DD3EA") or
		   (A_B=X"ABCD1234" and Z_test=X"030DD3EA") or
		   (A_B=X"5678CDEF" and Z_test=X"1163B483") or
		   (A_B=X"CDEF5678" and Z_test=X"1163B483")) 
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
		
end arc_mo_tb_32bits;