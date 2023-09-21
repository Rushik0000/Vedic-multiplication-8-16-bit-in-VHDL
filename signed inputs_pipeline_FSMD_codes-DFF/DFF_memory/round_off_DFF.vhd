-----------------------------------------------------------------------
-- Library Name : Roundingoff with DFF
-- Unit Name : round_off_DFF
-----------------------------------------------------------------------
-- Date : Nov. 23, 2022
-- Designer : Yijun Li
-- Description : sequential statement + Roundingoff
-- obtain the value of Z first from register4 (after incrementor)
-- when current state is register4
-- then run DFF and rounding off 16bits
-- judge if Z need plus 1 again or not
-- judge if -Z need minus 1 again or not
-----------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity round_off_DFF is 
	port(
		Z_rod : in std_logic_vector(15 downto 0);
		--Z value from register4 (after increment)
		Zr_rod : in std_logic_vector(1 downto 0);
		--Z remainder Z(1) & Z(0) (after division)
		Zn_rod : in std_logic;
		-- memory of Z is negative or not (Z_neg after trans_in)
		st: in std_logic_vector(13 downto 0);
		-- st is the value of state_reg, current state
		Z_rsl : out std_logic_vector(15 downto 0));
		--Z value after rounding off
end round_off_DFF;

architecture arc_round_off_DFF of round_off_DFF is

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
signal Z_roq : std_logic_vector(15 downto 0) := (others=>'0');
signal Zr_roq : std_logic_vector(1 downto 0) := (others=>'0');
-- negative or postive temporary value
signal Zn_roq : std_logic := '0';
-- temporary value after incrementor and decrementor
signal Z_inc_pos, Z_pos :std_logic_vector(15 downto 0);
signal Z_dec_neg, Z_neg :std_logic_vector(15 downto 0);
begin
-- DFF D Flip-Flop
	process(st)
	begin
	    if rising_edge(st(8)) then
	    -- st(8) = signal of state : register4
		   Z_roq <= Z_rod;   --q_z<=d_z
		   Zr_roq <= Zr_rod; --q_rem<=d_rem
		   Zn_roq <= Zn_rod; --q_neg_z<=d_neg_z
		end if;
	end process;
-- output logic	
-- judge if Z need plus 1 again according to Rounding off
postive_unit: incre_16bits_nonc
port map(Z => Z_roq, Z_inc => Z_inc_pos);
negative_unit: decre_16bits_nonc
port map(Z => Z_roq, Z_dec => Z_dec_neg);
-- if remainder =2,3 then +1 or -1;
-- if remainder =1,0 then keep unchanged
Z_pos <= Z_inc_pos when Zr_roq(1)='1' else
         Z_roq;
Z_neg <= Z_dec_neg when Zr_roq(1)='1' else
         Z_roq;
-- Z_neg=1 -> Z should be negative (-Z+1=-(Z-1))
-- Z_neg=0 -> Z should be postive  (Z+1)
Z_rsl <= Z_neg when Zn_roq='1' else
         Z_pos;

end arc_round_off_DFF;	