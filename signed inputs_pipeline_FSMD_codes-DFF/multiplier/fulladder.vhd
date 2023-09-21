------------------------------------------------------
-- Library Name : QJQ
-- Unit Name : Full_Adder
------------------------------------------------------
-- Date : Sat. Oct. 15th 2022
-- Designer : Yijun Li
-- Description : Basic Full Adder Block
------------------------------------------------------
    
library ieee;
use ieee.std_logic_1164.all;

entity full_adder is
port(
    I0 : in std_logic;          --first input
	I1 : in std_logic;          --second input
	I2 : in std_logic;          --previous carry "jinwei"
	Os : out std_logic;        --sum "he"
	Oc : out std_logic);       --carry "jinwei"
end full_adder;

architecture arc_full_adder of full_adder is
begin
    Os <= (I0 xor I1) xor I2;
	Oc <= (I0 and I1) or (I0 and I2) or (I1 and I2);
end arc_full_adder;