------------------------------------------------------------
-- Library Name : half adder 
-- Unit Name : half_adder
------------------------------------------------------------
-- Date : Oct.1 2022
-- Designer : RUSHIK SHINGALA
-- Description : using XOR and And gate design half adder
------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity half_adder is 
port(
  a: in std_logic;  
  
  b: in std_logic;
  --cin: in std_logic;
  o: out std_logic;
  co: out std_logic);
end half_adder;

architecture imp of half_adder is
begin 
  o<=a xor b;
  co<= a and b;
end imp;
