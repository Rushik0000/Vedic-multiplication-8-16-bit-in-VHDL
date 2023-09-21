------------------------------------------------------------
-- Library Name : Outputs value
-- Unit Name : out_rsl_32bits
------------------------------------------------------------
-- Date : Nov. 23, 2022
-- Designer : Yijun Li
-- Description : Output the final value
-- first obtain the value from register6 (after transfer_out)
-- then output Z directly
-- end_flag will be given by control path
-- can keep output the end_flag at the same time
-- this state is the last part of data path
------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity out_rsl_32bits is 
	port(
		R_od : in signed(31 downto 0);
		st: in std_logic_vector(7 downto 0);
		-- st is the value of state_reg, current state
		Z : out signed(31 downto 0)
		);
end out_rsl_32bits;

architecture arc_out_rsl of out_rsl_32bits is 

signal R_oq : signed(31 downto 0) := (others=>'0');

begin

-- DFF D Flip-Flop
	process(st)
	begin
	    if rising_edge(st(6)) then
	    -- st(6) = signal of state : register3_32bits
		   R_oq <= R_od;   --q_z<=d_z
		end if;
	end process;
    -- output logic
	-- output final value of Z
	Z <= R_oq;

end arc_out_rsl;	