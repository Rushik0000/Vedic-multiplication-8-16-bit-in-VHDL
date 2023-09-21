------------------------------------------------------
-- Library Name : BJQ
-- Unit Name : Half_subtractor
------------------------------------------------------
-- Date : Sun. Dec. 11th 2022
-- Designer : Yijun Li
-- Description : Basic Half Subtractor Block
------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity half_subtractor is 
port( 
    I0 : in std_logic;    --first input-subtrahend
	I1 : in std_logic;    --second input-minuend
	Os : out std_logic;   --sub(difference) "cha"
	Oc : out std_logic);  --carry(borrow) "jiewei"
end half_subtractor;

architecture arc_half_subtractor of half_subtractor is

begin

  Os <= I0 xor I1;
  Oc <= (not I0) and I1;

end arc_half_subtractor;