------------------------------------------------------------
-- Library Name : Outputs typecasting
-- Unit Name : transfer_out_32bits
------------------------------------------------------------
-- Date : Nov. 23, 2022
-- Designer : Yijun Li
-- Description : Typecasting for Z
-- obtain the value of Z first from register2 (after multi_div_inc)
-- when current state is register2
-- then from std_logic_vector to signed
-- std_logic_vector -> unsigned -> integer -> signed
------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity transfer_out_32bits is 
	port(
		Z_td : in std_logic_vector(31 downto 0);
		st: in std_logic_vector(7 downto 0);
		-- st is the value of state_reg, current state
		Z_sig : out signed(31 downto 0)
		);
end transfer_out_32bits;

architecture arc_transfer_out of transfer_out_32bits is 

signal Z_tq : std_logic_vector(31 downto 0) := (others=>'0');

begin
   -- DFF D Flip-Flop
	process(st)
	begin
	    if rising_edge(st(4)) then
	    -- st(4) = signal of state : register2
		   Z_tq <= Z_td;   --q_z<=d_z
		end if;
	end process;
    -- output logic	
    --typecasting of Z

	Z_sig <= to_signed(to_integer(unsigned(Z_tq)),32);
	
end arc_transfer_out;	