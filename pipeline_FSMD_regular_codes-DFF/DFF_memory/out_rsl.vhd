------------------------------------------------------------
-- Library Name : Outputs value
-- Unit Name : out_rsl
------------------------------------------------------------
-- Date : Nov. 23, 2022
-- Designer : Yijun Li
-- Description : Output the final value
-- first obtain the value from register6 (after transfer_out)
-- then output Z directly
-- and then send carry to control path
-- end_flag also is given by control path
-- can keep output the end_flag at the same time
-- this state is the last part of data path
------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity out_rsl is 
	port(
		R_od : in signed(15 downto 0);
		C_od : in std_logic;
		st: in std_logic_vector(13 downto 0);
		-- st is the value of state_reg, current state
		Z : out signed(15 downto 0);
		carry_z : out std_logic);
		-- conect with Z_c
		-- always be 0,check in control path
end out_rsl;

architecture arc_out_rsl of out_rsl is 

signal R_oq : signed(15 downto 0) := (others=>'0');
signal C_oq : std_logic := '0';
begin

-- DFF D Flip-Flop
	process(st)
	begin
	    if rising_edge(st(12)) then
	    -- st(12) = signal of state : register6
		   R_oq <= R_od;   --q_z<=d_z
		   C_oq <= C_od;   --q_c<=d_c
		end if;
	end process;
    -- output logic
	-- output final value of Z
    -- send the carry to the control path simultaneously
	Z <= R_oq;
	carry_z <= C_oq;

end arc_out_rsl;	