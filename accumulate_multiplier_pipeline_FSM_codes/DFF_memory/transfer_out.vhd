------------------------------------------------------------
-- Library Name : Outputs typecasting
-- Unit Name : transfer_out
------------------------------------------------------------
-- Date : Dec. 6, 2022
-- Designer : Yijun Li
-- Description : Typecasting for Z
-- obtain the value of Z first from register5 (after register5)
-- when current state is register5
-- then from std_logic_vector to signed
-- std_logic_vector -> unsigned -> integer -> signed
------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity transfer_out is 
	port(
		Z_td : in std_logic_vector(19 downto 0);
		st: in std_logic_vector(13 downto 0);
		-- st is the value of state_reg, current state
		Z_sig : out signed(19 downto 0));
end transfer_out;

architecture arc_transfer_out of transfer_out is 

signal Z_tq : std_logic_vector(19 downto 0) := (others=>'0');

begin
    -- DFF D Flip-Flop
	process(st)
	begin
	    if rising_edge(st(11)) then
	    -- st(11) = signal of state : register5
		   Z_tq <= Z_td;   --q_z<=d_z
		end if;
	end process;
    -- output logic	
    --typecasting of Z
	Z_sig <= to_signed(to_integer(unsigned(Z_tq)),20);
	
end arc_transfer_out;	