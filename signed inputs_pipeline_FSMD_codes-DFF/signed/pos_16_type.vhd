------------------------------------------------------
-- Library Name : positive 16bit type casting
-- Unit Name : pos_16_type
------------------------------------------------------
-- Date : Nov. 16, 2022
-- Designer : Yijun Li
-- Description : 16bit std_logic_vector -> unsigned -> integer -> signed
-- if Z_neg is 0,Z should be positive
-- keep the value of Z
------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity pos_16_type is 
port( Z_pre : in std_logic_vector(15 downto 0);       
      --Input the previous value of previous Z
	  Z_signed : out signed(15 downto 0)); 
	  --output (16 bits) after typecasting
end pos_16_type;

architecture arc_pos_16_type of pos_16_type is
signal Z_integer : integer;     
begin
 
  Z_integer <= to_integer(unsigned(Z_pre));
  -- because Z is positive
  Z_signed <= to_signed(to_integer(unsigned(Z_pre)),16);
  -- data typecasting
       
end arc_pos_16_type;