-----------------------------------------------------------------------
-- Library Name : If Increment Again 16bits
-- Unit Name : rounding_off_incre2_16bits
-----------------------------------------------------------------------
-- Date : Nov. 23, 2022
-- Designer : Yijun Li
-- Description : 16 bit add 0 or 1
-- test if the remainder is greater than 1 ("10" or "11") 
-- the value of Z_rem : "10" or "11"-> +1 ; "01" or "00" -> +0
-- 2/4=0.5 3/4=0.75 ; 1/4=0.25 0/4=0
-----------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity rounding_off_incre2_16bits is 
port( Z: in std_logic_vector(15 downto 0); 
      --Input the result of Z after division and increment
	  Z_c : in std_logic;
	  --Input the carry(no.17 bit) of Z after division and increment
	  Z_rem : in std_logic_vector(1 downto 0);
	  --Input the lowest 2 bits of Z after multiplier
      Z_rsl : out std_logic_vector(15 downto 0);
      Z_rsl_carry : out std_logic); 
      --result include carry,carry is always '0'
end rounding_off_incre2_16bits;

architecture arc_rdof_incre2_16bits of rounding_off_incre2_16bits is
begin
process(Z,Z_c,Z_rem)
  variable C_tmp : std_logic;      
-- temporary value of carry (will immediately change in each loop)
begin
  if (Z_rem(1) = '1') then
  
    C_tmp := Z(0);         --Z(0) and 1 = Z(0)
    Z_rsl(0) <= (not Z(0));--Z(0) xor 1 = Z(0)'
    for i in 1 to 15 loop
	   Z_rsl(i) <= Z(i) xor C_tmp; -- sum of half_adder
	   C_tmp := Z(i) and C_tmp;    -- carry of half_adder
    end loop;
-- 16bits increment (+1)
	
	Z_rsl_carry <= C_tmp xor Z_c;	 
--+1: Z_c & Z"100..00";+2: Z_rsl_carry & Z_rsl"100..01"
--+1: Z_c & Z"011..11";+2: Z_rsl_carry & Z_rsl"100..00"

   else
    Z_rsl <= Z;
    Z_rsl_carry <= Z_c;
	--inputs directly connect with qoutputs
   end if;
  end process;    
  
 end arc_rdof_incre2_16bits;