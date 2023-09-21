-----------------------------------------------------------------------
-- Library Name : pipeline of register6
-- Unit Name : register6
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

entity register6 is 
	port(
		R_r6d : in signed(15 downto 0);
		C_r6d : in std_logic;
		st: in std_logic_vector(13 downto 0);
		-- st is the value of state_reg, current state
		R_r6 : out signed(15 downto 0);
		C_r6 : out std_logic);
end register6;

architecture arc_register6 of register6 is 

-- innitialized of values of Q
signal R_r6q : signed(15 downto 0) := (others=>'0');
signal C_r6q : std_logic := '0';

begin
    -- register result of Z and carry(always be 0)
	-- DFF D Flip-Flop
	process(st)
	begin
	    if rising_edge(st(11)) then
	    -- st(11) = signal of state : transfer_out
		   R_r6q <= R_r6d; --q_z<=d_z
		   C_r6q <= C_r6d; --q_c<=d_c
		end if;
	end process;
	-- output logic
	R_r6 <= R_r6q;
	C_r6 <= C_r6q;

end arc_register6;