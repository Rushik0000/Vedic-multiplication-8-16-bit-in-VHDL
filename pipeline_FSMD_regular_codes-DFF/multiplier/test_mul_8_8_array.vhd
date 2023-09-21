-----------------------------------------------------------------------
-- Library Name : 8*8Multiplier_array test
-- Unit Name : test_mul_8_8_array
-----------------------------------------------------------------------
-- Date : Sun. Dec. 11st 2022
-- Designer : Yijun Li
-- Description : Test of Array Architecture of 8*8 Multiplier Block
-----------------------------------------------------------------------
    
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity test_mul_8_8_array is
port(
    X : in integer;
    Y : in integer;	
    Z : out integer);
end test_mul_8_8_array;

architecture arc_test_8_8_array of test_mul_8_8_array is

component multiplier_8_8_array is
port(
    X : in std_logic_vector(7 downto 0);
    Y : in std_logic_vector(7 downto 0);	
    Z : out std_logic_vector(15 downto 0));
end component;

signal X_std, Y_std : std_logic_vector(7 downto 0);
signal Z_std : std_logic_vector(15 downto 0);

begin
  
  X_std <= std_logic_vector(to_unsigned(X,8));
  Y_std <= std_logic_vector(to_unsigned(Y,8));
  
  unit: multiplier_8_8_array
  port map(X_std, Y_std, Z_std);

  Z <= to_integer(unsigned(Z_std));  
  
end arc_test_8_8_array;