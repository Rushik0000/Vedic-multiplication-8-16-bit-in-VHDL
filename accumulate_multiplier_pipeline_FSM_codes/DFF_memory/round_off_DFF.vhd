-----------------------------------------------------------------------
-- Library Name : Roundingoff with DFF
-- Unit Name : round_off_DFF
-----------------------------------------------------------------------
-- Date : Nov. 23, 2022
-- Designer : Yijun Li
-- Description : sequential statement + Roundingoff
-- obtain the value of Z first from register4 (after incrementor)
-- when current state is register4
-- then run D-latch and rounding off 16bits
-- judge if Z need plus 1 again or not
-----------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity round_off_DFF is 
	port(
		Z_rod : in std_logic_vector(15 downto 0);
		--Z value from register4 (after increment)
		Zc_rod : in std_logic;
		--carry from register4 (after increment)
		Zr_rod : in std_logic_vector(1 downto 0);
		--Z remainder Z(1) & Z(0)
		st: in std_logic_vector(13 downto 0);
		-- st is the value of state_reg, current state
		Z_rsl : out std_logic_vector(15 downto 0);
		--Z value after rounding off
		Z_rsl_carry : out std_logic);
		-- carry of rounding off
end round_off_DFF;

architecture arc_round_off_DFF of round_off_DFF is 

component rounding_off_incre2_16bits is
port(
     Z : in std_logic_vector(15 downto 0); 
	 Z_c : in std_logic;
	 Z_rem : in std_logic_vector(1 downto 0);
     Z_rsl : out std_logic_vector(15 downto 0);
     Z_rsl_carry : out std_logic);
end component;

signal Z_roq : std_logic_vector(15 downto 0) := (others=>'0');
signal Zc_roq : std_logic := '0';
signal Zr_roq : std_logic_vector(1 downto 0) := (others=>'0');
begin
-- DFF D Flip-Flop
	process(st)
	begin
	    if rising_edge(st(8)) then
	    -- st(8) = signal of state : register4
		   Z_roq <= Z_rod;   --q_z<=d_z
		   Zc_roq <= Zc_rod; --q_c<=d_c
		   Zr_roq <= Zr_rod; --q_rem<=d_rem
		end if;
	end process;
-- output logic	
--judge if Z need plus 1 again according to Rounding off
unit: rounding_off_incre2_16bits
port map(Z => Z_roq, Z_c => Zc_roq, Z_rem => Zr_roq, Z_rsl => Z_rsl, Z_rsl_carry => Z_rsl_carry);
	
end arc_round_off_DFF;	