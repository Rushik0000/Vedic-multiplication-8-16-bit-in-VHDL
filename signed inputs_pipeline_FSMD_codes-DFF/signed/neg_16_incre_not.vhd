------------------------------------------------------
-- Library Name : negative 16bit data not & incrementer
-- Unit Name : neg_16_incre_not
------------------------------------------------------
-- Date : Nov. 16, 2022
-- Designer : Yijun Li
-- Description : 16bit  not (+->-) and incrementer (+1)
-- if Z_neg is 1,Z should be negative
-- change the positive binary data into negative data
------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity neg_16_incre_not is 
port( Z_pre : in std_logic_vector(15 downto 0);       
      --Input the previous value of previous Z
	    Z_signed : out signed(15 downto 0)); 
	    --output (16 bits) after changing and typecasting
end neg_16_incre_not;

architecture arc_neg_16_incre_not of neg_16_incre_not is

component incre_16bit IS 
port( Z_qu : in std_logic_vector(15 downto 0);       
      --Input Z quotient for incrementer
      Z_re : in std_logic_vector(1 downto 0);
      --Input Z remaider
      Z_r : out std_logic_vector(1 downto 0);
      --Z_r=Z_re,keep synchronous
      Z_inc : out std_logic_vector(15 downto 0); 
      Z_inc_carry : out std_logic);
    --output (17 bits include carry) from incrementer
end component;

signal Z_r1 : std_logic_vector(1 downto 0) := "00";
signal Z_r2 : std_logic_vector(1 downto 0);
signal Z_c : std_logic;     --carry
signal Z_not,Z_std : std_logic_vector(15 downto 0); 
signal Z_integer : integer;   
begin
    Z_integer <= - to_integer(unsigned(Z_pre));
	-- because Z is negative
    Z_not <= not Z_pre;
    -- first not the positive value(-)
    incre: incre_16bit
    port map(Z_qu => Z_not, Z_re => Z_r1, Z_r => Z_r2, Z_inc => Z_std, Z_inc_carry => Z_c);
    -- second plus 1 (+1)
    Z_signed <= to_signed(to_integer(unsigned(Z_std)),16);
    -- data typecasting
           
end arc_neg_16_incre_not;