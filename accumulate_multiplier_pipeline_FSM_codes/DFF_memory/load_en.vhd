-----------------------------------------------------------------------
-- Library Name : the load process
-- Unit Name : load_en
-----------------------------------------------------------------------
-- Date : Nov. 23, 2022
-- Designer : Yijun Li & Ning Lin
-- Description : read the registers of the A and B sychronously
-- when the current state is load_en
-----------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity load_en is 
	port(
		A : in unsigned(7 downto 0);
		B : in unsigned(7 downto 0);
		st: in std_logic_vector(13 downto 0);
		-- st is the value of state_reg, current state
		A_reg : out unsigned(7 downto 0);
		B_reg : out unsigned(7 downto 0));
end load_en;

architecture arc_load_en of load_en is 

-- innitialized of values of Q
signal a_q, b_q : unsigned(7 downto 0) := (others=>'0');

begin
    -- register A and register B
	-- DFF D Flip-Flop
	process(st)
	begin
	    -- st(0) = load_en
		if rising_edge(st(0)) then 
		   a_q <= A; --q_a<=d_a
		   b_q <= B; --q_b<=d_b
		end if;
	end process;
	-- output logic
	A_reg <= a_q;
	B_reg <= b_q;
	
end arc_load_en;	
