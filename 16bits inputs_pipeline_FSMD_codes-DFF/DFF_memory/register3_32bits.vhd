-----------------------------------------------------------------------
-- Library Name : pipeline of register3_32bits
-- Unit Name : register3_32bits
-----------------------------------------------------------------------
-- Date : Nov. 29, 2022
-- Designer : Yijun Li
-- Description : obtain the values of Z from typecasting of outputs
-- when the current state is transfer_out
-- store the final value of Z
-- to keep the Z and end_flag output at the same time(next step)
-----------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity register3_32bits is 
	port(
		R_r3d : in signed(31 downto 0);
		st: in std_logic_vector(7 downto 0);
		-- st is the value of state_reg, current state
		R_r3 : out signed(31 downto 0)
		);
end register3_32bits;

architecture arc_register3 of register3_32bits is 

-- innitialized of values of Q
signal R_r3q : signed(31 downto 0) := (others=>'0');

begin
    -- register result of Z
	-- DFF D Flip-Flop
	process(st)
	begin
	    if rising_edge(st(5)) then
	    -- st(5) = signal of state : transfer_out
		   R_r3q <= R_r3d; --q_z<=d_z
		end if;
	end process;
	-- output logic
	R_r3 <= R_r3q;

end arc_register3;