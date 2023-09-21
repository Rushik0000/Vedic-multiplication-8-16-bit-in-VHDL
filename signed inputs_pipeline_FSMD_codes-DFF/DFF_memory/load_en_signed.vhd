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

entity load_en_signed is 
	port(
		A : in integer;
		B : in integer;
		st: in std_logic_vector(13 downto 0);
		-- st is the value of state_reg, current state
		A_reg : out integer;
		B_reg : out integer);
end load_en_signed;

architecture arc_load_en_signed of load_en_signed is 

-- innitialized of values of Q
signal a_q, b_q : integer := 0;

begin
    -- register A and register B
	-- DFF D Flip-Flop
	process(st)
	begin
	    if rising_edge(st(0)) then
	    -- st(0) = load
		   a_q <= A; --q_a<=d_a
		   b_q <= B; --q_b<=d_b
		end if;
	end process;
	-- output logic
	A_reg <= a_q;
	B_reg <= b_q;
	
end arc_load_en_signed;	
