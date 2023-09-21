-----------------------------------------------------------------------
-- Library Name : 8bits Decrementor (-1) without carry
-- Unit Name : decre_8bits_nonc
-----------------------------------------------------------------------
-- Date : Dec. 6, 2022
-- Designer : Yijun Li
-- Description : 8bit decrementer (Z-1) without carry (borrow)
-----------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity decre_8bits_nonc is 
port( Z : in std_logic_vector(7 downto 0);       
      --Input the previous value of Z 8bits
      Z_dec : out std_logic_vector(7 downto 0)); 
	  --output (8 bits) after -1
end decre_8bits_nonc;

architecture arc_decre_8bits_nonc of decre_8bits_nonc is

begin
process(Z)
variable c : std_logic;
-- Differential half_subtractor, Z-1
begin
-- unit of subtractor
-- a-b: truth table
-- a=0,b=0->carry=0,sub=0
-- a=0,b=1->carry=1,sub=1
-- a=1,b=0->carry=0,sub=1
-- a=1,b=1->carry=0,sub=0
    Z_dec(0) <= Z(0) xor '1';   
    c := (not Z(0)) and '1';
	for i in 1 to 7 loop
	  Z_dec(i) <= Z(i) xor c;       -- subtracter of half_subtractor
      c := (not Z(i)) and c;        -- borrow of half_subtractor
	end loop;
	-- minus 1,(-1)
	-- end the unit of subtractor
  end process;

end arc_decre_8bits_nonc;