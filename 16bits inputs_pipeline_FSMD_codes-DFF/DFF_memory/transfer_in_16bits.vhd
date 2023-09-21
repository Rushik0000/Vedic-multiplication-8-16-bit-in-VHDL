------------------------------------------------------------
-- Library Name : Inputs typecasting
-- Unit Name : transfer_in_16bits
------------------------------------------------------------
-- Date : Nov. 23, 2022
-- Designer : Yijun Li
-- Description : Typecasting for A B 
-- from unsigned to std_logic_vector
------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity transfer_in_16bits is 
	port(
		A_us : in unsigned(15 downto 0);
		B_us : in unsigned(15 downto 0);
		A_std : out std_logic_vector(15 downto 0);
		B_std : out std_logic_vector(15 downto 0));
end transfer_in_16bits;

architecture arc_transfer_in of transfer_in_16bits is
begin
	--typecasting of A and B
	A_std <= std_logic_vector(A_us);
	B_std <= std_logic_vector(B_us);
	
end arc_transfer_in;	