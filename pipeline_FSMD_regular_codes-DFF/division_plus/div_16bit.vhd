-----------------------------------------------------------------------
-- Library Name : division 16bit
-- Unit Name : div_16bit
-----------------------------------------------------------------------
-- Date : Nov. 23, 2022
-- Designer : Yijun li
-- Description : 16 bit divided by 4 (1/4)
-----------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity div_16bit is 
port( Z_mul : in std_logic_vector(15 downto 0);       
      --Input z for division
      Z_quo : out std_logic_vector(15 downto 0); 
	  -- output "00"&X(15 downto 2)
	  Z_rem : out std_logic_vector(1 downto 0));
	  -- output X(1)&X(0)
end div_16bit;

architecture arc_div_16bit of div_16bit is
begin
 
 Z_rem <= Z_mul(1 downto 0);            -- quotient from division
 Z_quo <= "00" & Z_mul(15 downto 2);    -- remainder from division
 
 end arc_div_16bit;