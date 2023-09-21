-----------------------------------------------------------------------
-- Library Name : Increment with DFF
-- Unit Name : incre_DFF
-----------------------------------------------------------------------
-- Date : Nov. 23, 2022
-- Designer : Yijun Li
-- Description : sequential statement + Increment
-- obtain the value of Z first from register3 (after division)
-- when current state is register3
-- then run D-latch and (+1) 16bits
-----------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity incre_DFF is 
	port(
		Zi_d : in std_logic_vector(15 downto 0);
		Zir_d : in std_logic_vector(1 downto 0);
		st: in std_logic_vector(13 downto 0);
		-- st is the value of state_reg, current state
		Z_inc : out std_logic_vector(15 downto 0);
		-- Z value after increment (+1)
		Z_inc_carry : out std_logic;
		-- carry of increment
		Z_r : out std_logic_vector(1 downto 0));
    -- remainder of Z(1) & Z(0)
end incre_DFF;

architecture arc_incre_DFF of incre_DFF is 

component incre_16bit is
port(
     Z_qu : in std_logic_vector(15 downto 0);  
	   Z_re : in std_logic_vector(1 downto 0);
	   Z_r : out std_logic_vector(1 downto 0);
     Z_inc : out std_logic_vector(15 downto 0); 
     Z_inc_carry : out std_logic);
end component;

signal Zi_q : std_logic_vector(15 downto 0) := (others=>'0');
signal Zir_q : std_logic_vector(1 downto 0) := (others=>'0');
begin
-- DFF D Flip-Flop
	process(st)
	begin
	    if rising_edge(st(6)) then
	    -- st(6) = signal of state : register3
		   Zi_q <= Zi_d;   --q_z<=d_z
		   Zir_q <= Zir_d; --q_rem<=d_rem
		end if;
	end process;	
-- output logic
-- increment +1
unit: incre_16bit
port map(Z_qu => Zi_q, Z_re => Zir_q, Z_r => Z_r, Z_inc => Z_inc, Z_inc_carry => Z_inc_carry);
	
end arc_incre_DFF;