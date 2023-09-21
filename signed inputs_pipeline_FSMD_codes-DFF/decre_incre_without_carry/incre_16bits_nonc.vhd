-----------------------------------------------------------------------
-- Library Name : 16bits Incrementor (+1) without carry
-- Unit Name : incre_16bits_nonc
-----------------------------------------------------------------------
-- Date : Dec. 6, 2022
-- Designer : Yijun Li
-- Description : 16bit incrementer (Z+1) without carry
-----------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity incre_16bits_nonc is 
port( Z : in std_logic_vector(15 downto 0);       
      --Input the previous value of Z 8bits
      Z_inc : out std_logic_vector(15 downto 0)); 
	  --output (16 bits) after +1
end incre_16bits_nonc;

architecture arc_incre_16bits_nonc of incre_16bits_nonc is

begin
process(Z)
variable c : std_logic;
-- half_adder, Z+1
begin
-- unit of adder
-- a+b: truth table
-- a=0,b=0->carry=0,sum=0
-- a=0,b=1->carry=0,sum=1
-- a=1,b=0->carry=0,sum=1
-- a=1,b=1->carry=1,sum=0
    Z_inc(0) <= Z(0) xor '1';   
    c := Z(0) and '1';
	for i in 1 to 15 loop
	  Z_inc(i) <= Z(i) xor c; -- sum of half_adder
      c := Z(i) and c;        -- carry of half_adder
	end loop;
	-- plus 1,(+1)
	-- end the unit of adder
  end process;

end arc_incre_16bits_nonc;