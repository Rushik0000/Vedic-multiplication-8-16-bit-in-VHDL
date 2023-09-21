-----------------------------------------------------------------------
-- Library Name : pipeline of register2_32bits
-- Unit Name : register2_32bits
-----------------------------------------------------------------------
-- Date : Nov. 29, 2022
-- Designer : Yijun Li
-- Description : obtain the values of Z from multi_div_inc
-- when the current state is multi_div_inc
-- store the value of Z
-----------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity register2_32bits is 
	port(
		Z_r2d : in std_logic_vector(31 downto 0);
		st: in std_logic_vector(7 downto 0);
		-- st is the value of state_reg, current state
		Z_r2 : out std_logic_vector(31 downto 0));
end register2_32bits;

architecture arc_register2 of register2_32bits is 

-- innitialized of values of Q
signal Z_r2q : std_logic_vector(31 downto 0) := (others=>'0');

begin
    -- register Z
	-- DFF D Flip-Flop
	process(st)
	begin
	    if rising_edge(st(3)) then
	    -- st(3) = signal of state : multi_div_inc
		   Z_r2q <= Z_r2d; --q_z<=d_z
		end if;
	end process;
	-- output logic
	Z_r2 <= Z_r2q;
	
end arc_register2;	