-----------------------------------------------------------------------
-- Library Name : pipeline of register2
-- Unit Name : register2
-----------------------------------------------------------------------
-- Date : Nov. 29, 2022
-- Designer : Yijun Li
-- Description : obtain the values of Z from multiplier
-- when the current state is multiplier
-- store the value of Z
-----------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity register2 is 
	port(
		Z_r2d : in std_logic_vector(15 downto 0);
		st: in std_logic_vector(13 downto 0);
		-- st is the value of state_reg, current state
		Z_r2 : out std_logic_vector(15 downto 0));
end register2;

architecture arc_register2 of register2 is 

-- innitialized of values of Q
signal Z_r2q : std_logic_vector(15 downto 0) := (others=>'0');

begin
    -- register Z
	-- DFF D Flip-Flop
	process(st)
	begin
	    if rising_edge(st(3)) then
	    -- st(3) = signal of state : multiplier
		   Z_r2q <= Z_r2d; --q_z<=d_z
		end if;
	end process;
	-- output logic
	Z_r2 <= Z_r2q;
	
end arc_register2;	