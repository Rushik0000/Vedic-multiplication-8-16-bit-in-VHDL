------------------------------------------------------
-- Library Name : Increment 16bit
-- Unit Name : Incre_16bit
------------------------------------------------------
-- Date : Nov. 2, 2022
-- Designer : Ning Lin
-- Modified by : Yijun li
-- Description : 16 bit incrementer (+1)
------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;

entity incre_16bit IS 
port( Z_qu : in std_logic_vector(15 downto 0);       
      --Input Z quotient for incrementer
	    Z_re : in std_logic_vector(1 downto 0);
	    --Input Z remaider
	    Z_r : out std_logic_vector(1 downto 0);
	    --Z_rem=Z_re,keep synchronous
      Z_inc : out std_logic_vector(15 downto 0); 
      Z_inc_carry : out std_logic);
	  --output (17 bits include carry) from incrementer
end incre_16bit;

architecture Beh_incre_16bit of incre_16bit is
begin
process(Z_qu, Z_re)
variable C_tmp : std_logic;      
-- temporary value of carry (will immediately change in each loop)
begin
  C_tmp := Z_qu(0);                  -- Z_qu(0) and 1 = Z_qu(0)
  Z_inc(0) <= (not Z_qu(0));         -- Z_qu(0) xor 1 = Z_qu(0)'
  for i in 1 to 15 loop
	  Z_inc(i) <= Z_qu(i) xor C_tmp; -- sum of half_adder
	  C_tmp := Z_qu(i) and C_tmp;    -- carry of half_adder
    end loop;
  Z_inc_carry <= C_tmp;
  end process;
  
  Z_r <= Z_re;
  --Z_r=Z_re, keep synchronous

end Beh_incre_16bit;
