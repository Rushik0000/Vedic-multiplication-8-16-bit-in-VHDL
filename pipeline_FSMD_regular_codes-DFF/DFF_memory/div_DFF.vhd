-----------------------------------------------------------------------
-- Library Name : Division with DFF
-- Unit Name : div_DFF
-----------------------------------------------------------------------
-- Date : Nov. 23, 2022
-- Designer : Yijun Li
-- Description : sequential statement + Division
-- obtain the value of Z first from register2 (after multiplier)
-- when current state is register2
-- then run D-latch and 1/4
-----------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity div_DFF is 
	port(
		Z_dd : in std_logic_vector(15 downto 0);
		st: in std_logic_vector(13 downto 0);
		-- st is the value of state_reg, current state
		Z_quo : out std_logic_vector(15 downto 0);
		-- quetient of "00" & Z(15 downto 2)
		Z_rem : out std_logic_vector(1 downto 0));
		-- remainder of Z (1 downto 0)
end div_DFF;

architecture arc_div_dff of div_DFF is 

component div_16bit is
port(
     Z_mul : in std_logic_vector(15 downto 0);
     Z_quo : out std_logic_vector(15 downto 0);
	 Z_rem : out std_logic_vector(1 downto 0));
end component;

signal Z_dq : std_logic_vector(15 downto 0) := (others=>'0');
begin
	-- DFF D Flip-Flop
	process(st)
	begin
	    if rising_edge(st(4)) then
	    -- st(4) = signal of state : register2
		   Z_dq <= Z_dd; --q_z<=d_z
		end if;
	end process;

-- output logic
--division: Z/4
unit: div_16bit
port map(Z_mul => Z_dq, Z_quo => Z_quo, Z_rem => Z_rem);
	
end arc_div_dff;	