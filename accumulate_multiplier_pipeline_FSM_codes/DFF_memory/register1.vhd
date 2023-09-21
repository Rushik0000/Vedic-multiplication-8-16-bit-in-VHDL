-----------------------------------------------------------------------
-- Library Name : pipeline of register1
-- Unit Name : register1
-----------------------------------------------------------------------
-- Date : Nov. 29, 2022
-- Designer : Yijun Li
-- Description : obtain the values of A B from typecasting of inputs
-- when the current state is transfer_in  
-- A and B become std_logic_vector type
-----------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity register1 is 
	port(
		a_r1d : in std_logic_vector(7 downto 0);
		b_r1d : in std_logic_vector(7 downto 0);
		st: in std_logic_vector(13 downto 0);
		-- st is the value of state_reg, current state
		a_r1 : out std_logic_vector(7 downto 0);
		b_r1 : out std_logic_vector(7 downto 0));
end register1;

architecture arc_register1 of register1 is 

-- innitialized of values of Q
signal a_r1q, b_r1q : std_logic_vector(7 downto 0) := (others=>'0');

begin
    -- register A and register B
	-- DFF D Flip-Flop
	process(st)
	begin
	    -- st(1) = signal of state : transfer_in
		if rising_edge(st(1)) then 
		   a_r1q <= a_r1d; --q_a<=d_a
		   b_r1q <= b_r1d; --q_b<=d_b
		end if;
	end process;
	-- output logic
	a_r1 <= a_r1q;
	b_r1 <= b_r1q;
	
end arc_register1;	
