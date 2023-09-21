-----------------------------------------------------------------------
-- Library Name : 16*16Multiplier_vedic test
-- Unit Name : test_mul_81616_vedic
-----------------------------------------------------------------------
-- Date : Sun. Dec. 11st 2022
-- Designer : Yijun Li
-- Description : Test of Vedic Architecture of 16*16 Multiplier Block
-----------------------------------------------------------------------
    
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity test_mul_16_16_vedic is
port(
    X : in natural;
    Y : in natural;	
    Z : out natural);
end test_mul_16_16_vedic;

architecture arc_test_16_16_vedic of test_mul_16_16_vedic is

component multiplier16bit is 
port (
    a: in std_logic_vector(15 downto 0);
    b: in std_logic_vector(15 downto 0);
    output: out std_logic_vector(31 downto 0));
end component;

signal X_std, Y_std : std_logic_vector(15 downto 0);
signal Z_std : std_logic_vector(31 downto 0);

begin
  
  X_std <= std_logic_vector(to_unsigned(X,16));
  Y_std <= std_logic_vector(to_unsigned(Y,16));
  
  unit: multiplier16bit
  port map(X_std, Y_std, Z_std);

  Z <= to_integer(unsigned(Z_std));  
  
end arc_test_16_16_vedic;