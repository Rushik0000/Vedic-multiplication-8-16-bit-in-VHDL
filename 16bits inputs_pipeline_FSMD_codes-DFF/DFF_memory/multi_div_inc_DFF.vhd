-----------------------------------------------------------------------
-- Library Name : Multiplier Division Incrementor with DFF
-- Unit Name : multi_div_inc_DFF
-----------------------------------------------------------------------
-- Date : Nov. 23, 2022
-- Designer : Yijun Li
-- Description : sequential statement + multiplier
-- obtain the value of A B first
-- when current state is register_ab_16bits
-- then run D-latch and multiplier, division, incrementor
-----------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity multi_div_inc_DFF is 
	port(
		a_md : in std_logic_vector(15 downto 0);
		b_md : in std_logic_vector(15 downto 0);
		st: in std_logic_vector(7 downto 0);
		-- st is the value of state_reg, current state
		Z_m : out std_logic_vector(31 downto 0));
end multi_div_inc_DFF;

architecture arc_multi_dff of multi_div_inc_DFF is 

component multiplier16bit_div_inc is
port(
     a : in std_logic_vector(15 downto 0);
     b : in std_logic_vector(15 downto 0);	
     output : out std_logic_vector(31 downto 0));
end component;

signal A_mq,B_mq : std_logic_vector(15 downto 0) := (others=>'0');
begin
-- DFF D Flip-Flop
	process(st)
	begin
	    if rising_edge(st(2)) then
	    -- st(2) = signal of state : register1
		   A_mq <= a_md; --q_a<=d_a
		   B_mq <= b_md; --q_b<=d_b
		end if;
	end process;
	
-- output logic
-- mutliplier: A times B
unit: multiplier16bit_div_inc
port map(a => A_mq, b => B_mq, output => Z_m);
	
end arc_multi_dff;	