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
		Zin_d : in std_logic;
		st: in std_logic_vector(13 downto 0);
		-- st is the value of state_reg, current state
		Z_inc : out std_logic_vector(15 downto 0));
		-- Z value after increment (+1)
end incre_DFF;

architecture arc_incre_DFF of incre_DFF is

component incre_16bits_nonc is 
port( 
      Z : in std_logic_vector(15 downto 0);
      Z_inc : out std_logic_vector(15 downto 0)); 
end component;

component decre_16bits_nonc is 
port( 
      Z : in std_logic_vector(15 downto 0);       
      Z_dec : out std_logic_vector(15 downto 0)); 
end component;

-- DFF signals
signal Zi_q : std_logic_vector(15 downto 0) := (others=>'0');
signal Zin_q : std_logic := '0';
-- negative or postive temporary value
signal Z_inc_pos, Z_dec_neg : std_logic_vector(15 downto 0);
begin
-- DFF D Flip-Flop
	process(st)
	begin
	    if rising_edge(st(6)) then
	    -- st(6) = signal of state : register3
		   Zi_q <= Zi_d;   --q_z<=d_z
		   Zin_q <= Zin_d; --q_neg_z<=d_neg_z
		end if;
	end process;	
-- output logic
-- increment +1 or decrementor -1
postive_unit: incre_16bits_nonc
port map(Z => Zi_q, Z_inc => Z_inc_pos);
negative_unit: decre_16bits_nonc
port map(Z => Zi_q, Z_dec => Z_dec_neg);
-- Z_neg=1 -> Z should be negative (-Z+1=-(Z-1))
Z_inc <= Z_dec_neg when Zin_q='1' else
         Z_inc_pos;
	
end arc_incre_DFF;