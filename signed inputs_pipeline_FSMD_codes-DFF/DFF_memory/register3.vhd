-----------------------------------------------------------------------
-- Library Name : pipeline of register3
-- Unit Name : register3
-----------------------------------------------------------------------
-- Date : Nov. 29, 2022
-- Designer : Yijun Li
-- Description : obtain the values of Z from division
-- when the current state is division
-- store the value of Z
-----------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity register3 is 
	port(
		Zq_r3d : in std_logic_vector(15 downto 0);
		Zr_r3d : in std_logic_vector(1 downto 0);
		st: in std_logic_vector(13 downto 0);
		-- st is the value of state_reg, current state
		Zq_r3 : out std_logic_vector(15 downto 0);
		Zr_r3 : out std_logic_vector(1 downto 0));
end register3;

architecture arc_register3 of register3 is 

-- innitialized of values of Q
signal Zq_r3q : std_logic_vector(15 downto 0) := (others=>'0');
signal Zr_r3q : std_logic_vector(1 downto 0) := (others=>'0');

begin
    -- register quotient of Z and remainder of Z
	-- DFF D Flip-Flop
	process(st)
	begin
	    if rising_edge(st(5)) then
	    -- st(5) = signal of state : division
		   Zq_r3q <= Zq_r3d; --q_z<=d_z
		   Zr_r3q <= Zr_r3d; --q_z<=d_z
		end if;
	end process;
	-- output logic
	Zq_r3 <= Zq_r3q;
	Zr_r3 <= Zr_r3q;

end arc_register3;	