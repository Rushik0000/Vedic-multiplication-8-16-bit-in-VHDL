----------------------------------------------------------------------
-- Library Name : Outputs typecasting
-- Unit Name : transfer_out_signed
----------------------------------------------------------------------
-- Date : Nov. 23, 2022
-- Designer : Yijun Li
-- Description : Typecasting for Z
-- obtain the value of Z first from register5 (after rounding_off)
-- when current state is register5
-- then from std_logic_vector to signed
-- std_logic_vector -> unsigned -> integer -> signed
-- if Z should be negative, change it to negative value
-----------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity transfer_out_signed is 
	port(
		Z_td : in std_logic_vector(15 downto 0);
		Zn_d : in std_logic;
		st: in std_logic_vector(13 downto 0);
		-- st is the value of state_reg, current state
		Z_sig : out signed(15 downto 0));
end transfer_out_signed;

architecture arc_transfer_out_signed of transfer_out_signed is 

component neg_16_incre_not is 
port( Z_pre : in std_logic_vector(15 downto 0);       
      --Input the previous value of previous Z
	  Z_signed : out signed(15 downto 0)); 
	  --output (16 bits) after changing and typecasting
end component;

component pos_16_type is 
port( Z_pre : in std_logic_vector(15 downto 0);       
      --Input the previous value of previous Z
	  Z_signed : out signed(15 downto 0)); 
	  --output (16 bits) after typecasting
end component;

signal Z_tq : std_logic_vector(15 downto 0) := (others=>'0');
signal Zn_q : std_logic := '0';
signal Z_sig_neg : signed(15 downto 0);
signal Z_sig_pos : signed(15 downto 0);

begin
    -- DFF D Flip-Flop
	process(st)
	begin
	    if rising_edge(st(10)) then
	    -- st(10) = signal of state : register5
		   Z_tq <= Z_td;   --q_z<=d_z
		   Zn_q <= Zn_d; --q_z_neg<=d_z_neg
		end if;
	end process;
-- output logic	
--change it to negative or keep postive, typecast Z inside portmap
neg: neg_16_incre_not
port map(Z_pre => Z_tq, Z_signed => Z_sig_neg);

pos: pos_16_type
port map(Z_pre => Z_tq, Z_signed => Z_sig_pos);

Z_sig <= Z_sig_neg when Zn_q = '1' else
         Z_sig_pos;
	
end arc_transfer_out_signed;	