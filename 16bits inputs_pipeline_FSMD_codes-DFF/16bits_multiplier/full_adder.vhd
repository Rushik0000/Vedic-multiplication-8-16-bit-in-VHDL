------------------------------------------------------------
-- Library Name : Full adder 
-- Unit Name : Full_adder
------------------------------------------------------------
-- Date : Oct.3 2022
-- Designer : RUSHIK SHINGALA
-- Description : using XOR and And gate design Full adder
------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity full_adder is 
port(
  a:in std_logic;
  b: in std_logic;
  cin: in std_logic;
  o: out std_logic;
  co: out std_logic);
end full_adder;

architecture imp of full_adder is
begin 
  o<=(a xor b) xor cin;
  co<= (a and b) or ((a xor b) and cin);
end imp;
