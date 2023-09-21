------------------------------------------------------
-- Library Name : BJQ
-- Unit Name : Half_Adder
------------------------------------------------------
-- Date : Tues. Oct. 18th 2022
-- Designer : Yijun Li
-- Description : Basic Half Adder Block
------------------------------------------------------
    
library ieee;
use ieee.std_logic_1164.all;

entity half_adder is
port(
    I0 : in std_logic;    --first input
	I1 : in std_logic;    --second input
	Os : out std_logic;   --sum "he"
	Oc : out std_logic);  --carry "jinwei"
end half_adder;

architecture arc_half_adder of half_adder is
begin
    Os <= I0 xor I1;
	Oc <= I0 and I1;
end arc_half_adder;