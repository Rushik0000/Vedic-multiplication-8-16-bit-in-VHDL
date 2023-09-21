-----------------------------------------------------------------------
-- Library Name : pipeline of register5
-- Unit Name : register5
-----------------------------------------------------------------------
-- Date : Nov. 29, 2022
-- Designer : Yijun Li
-- Description : obtain the values of Z from rounding-off
-- when the current state is rounding_off
-- store the value of Z
-----------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity register5 is 
	port(
		Z_r5d : in std_logic_vector(15 downto 0);
		Zc_r5d : in std_logic;
		st: in std_logic_vector(13 downto 0);
		-- st is the value of state_reg, current state
		Z_r5 : out std_logic_vector(15 downto 0);
		Zc_r5 : out std_logic);
end register5;

architecture arc_register5 of register5 is 

-- innitialized of values of Q
signal Z_r5q : std_logic_vector(15 downto 0) := (others=>'0');
signal Zc_r5q : std_logic := '0';

begin
    -- register Z and carry
	-- DFF D Flip-Flop
	process(st)
	begin
	    if rising_edge(st(9)) then
	    -- st(9) = signal of state : rounding_off
		   Z_r5q <= Z_r5d;   --q_z<=d_z
		   Zc_r5q <= Zc_r5d; --q_c<=d_c
		end if;
	end process;
	-- output logic
	Z_r5 <= Z_r5q;
	Zc_r5 <= Zc_r5q;

end arc_register5;