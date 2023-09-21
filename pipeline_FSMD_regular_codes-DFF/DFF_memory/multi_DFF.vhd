-----------------------------------------------------------------------
-- Library Name : Multiplier with DFF
-- Unit Name : multi_DFF
-----------------------------------------------------------------------
-- Date : Nov. 23, 2022
-- Designer : Yijun Li
-- Description : sequential statement + multiplier
-- obtain the value of A B first, when current state is register1
-- then run D-latch and multiplier
-----------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity multi_DFF is 
	port(
		a_md : in std_logic_vector(7 downto 0);
		b_md : in std_logic_vector(7 downto 0);
		st: in std_logic_vector(13 downto 0);
		-- st is the value of state_reg, current state
		Z_m : out std_logic_vector(15 downto 0));
end multi_DFF;

architecture arc_multi_dff of multi_DFF is 

component multiplier_8_8_array is
port(
     X : in std_logic_vector(7 downto 0);
     Y : in std_logic_vector(7 downto 0);	
     Z : out std_logic_vector(15 downto 0));
end component;

signal A_mq,B_mq : std_logic_vector(7 downto 0) := (others=>'0');
begin
-- D latch
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
unit: multiplier_8_8_array
port map(X => A_mq, Y => B_mq, Z => Z_m);
	
end arc_multi_dff;	