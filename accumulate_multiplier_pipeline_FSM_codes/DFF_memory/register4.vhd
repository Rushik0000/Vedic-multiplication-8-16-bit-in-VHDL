-----------------------------------------------------------------------
-- Library Name : pipeline of register4
-- Unit Name : register4
-----------------------------------------------------------------------
-- Date : Nov. 29, 2022
-- Designer : Yijun Li
-- Description : obtain the values of Z from incrementor
-- when the current state is incrementor
-- store the value of Z
-----------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity register4 is 
	port(
		Zi_r4d : in std_logic_vector(15 downto 0);
		Zic_r4d : in std_logic;
		Zir_r4d : in std_logic_vector(1 downto 0);
		st: in std_logic_vector(13 downto 0);
		-- st is the value of state_reg, current state
		Z_r4 : out std_logic_vector(15 downto 0);
		Zc_r4 : out std_logic;
		Zr_r4 : out std_logic_vector(1 downto 0));
end register4;

architecture arc_register4 of register4 is 

-- innitialized of values of Q
signal Zi_r4q : std_logic_vector(15 downto 0) := (others=>'0');
signal Zic_r4q : std_logic := '0';
signal Zir_r4q : std_logic_vector(1 downto 0) := (others=>'0');

begin
    -- register quotient of Z and carry and remainder of Z
	-- DFF D Flip-Flop
	process(st)
	begin
	    if rising_edge(st(7)) then
	    -- st(7) = signal of state : incrementor
		   Zi_r4q <= Zi_r4d;   --q_z<=d_z
		   Zic_r4q <= Zic_r4d; --q_c<=d_c
		   Zir_r4q <= Zir_r4d; --q_rem<=d_rem
		end if;
	end process;
	-- output logic
	Z_r4 <= Zi_r4q;
	Zc_r4 <= Zic_r4q;
	Zr_r4 <= Zir_r4q;

end arc_register4;	