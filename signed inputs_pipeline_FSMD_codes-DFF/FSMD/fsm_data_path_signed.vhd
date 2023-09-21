-----------------------------------------------------------------------
-- Library Name : FSM with data path connection
-- Unit Name : fsm_data_path_signed
-----------------------------------------------------------------------
-- Date : Nov. 30, 2022
-- Designer : Yijun Li
-- Description : connect each component in data path of FSM
-----------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fsm_data_path_signed is 
	port(
	     A : in integer;
	     B : in integer;
         state_now : in std_logic_vector(13 downto 0);
		 -- state_reg from control path of FSM
	     Z : out signed(15 downto 0));
end fsm_data_path_signed;

architecture arc_fsm_data_path_signed of fsm_data_path_signed is 

component load_en_signed is 
	port(
		A : in integer;
		B : in integer;
		st: in std_logic_vector(13 downto 0);
		A_reg : out integer;
		B_reg : out integer);
end component;

component transfer_in_signed is 
	port(
		A_s : in integer;
		B_s : in integer;
		A_pos_std : out std_logic_vector(7 downto 0);
		B_pos_std : out std_logic_vector(7 downto 0);
		neg_Z : out std_logic);
end component;

component register1 is 
	port(
		a_r1d : in std_logic_vector(7 downto 0);
		b_r1d : in std_logic_vector(7 downto 0);
		st: in std_logic_vector(13 downto 0);
		a_r1 : out std_logic_vector(7 downto 0);
		b_r1 : out std_logic_vector(7 downto 0));
end component;

component multi_DFF is 
	port(
		a_md : in std_logic_vector(7 downto 0);
		b_md : in std_logic_vector(7 downto 0);
		st: in std_logic_vector(13 downto 0);
		Z_m : out std_logic_vector(15 downto 0));
end component;

component register2 is 
	port(
		Z_r2d : in std_logic_vector(15 downto 0);
		st: in std_logic_vector(13 downto 0);
		Z_r2 : out std_logic_vector(15 downto 0));
end component;

component div_DFF is 
	port(
		Z_dd : in std_logic_vector(15 downto 0);
		st: in std_logic_vector(13 downto 0);
		Z_quo : out std_logic_vector(15 downto 0);
		Z_rem : out std_logic_vector(1 downto 0));
end component;

component register3 is 
	port(
		Zq_r3d : in std_logic_vector(15 downto 0);
		Zr_r3d : in std_logic_vector(1 downto 0);
		st: in std_logic_vector(13 downto 0);
		Zq_r3 : out std_logic_vector(15 downto 0);
		Zr_r3 : out std_logic_vector(1 downto 0));
end component;

component incre_DFF is 
	port(
		Zi_d : in std_logic_vector(15 downto 0);
		Zin_d : in std_logic;
		st: in std_logic_vector(13 downto 0);
		Z_inc : out std_logic_vector(15 downto 0));
end component;

component register4 is 
	port(
		Zi_r4d : in std_logic_vector(15 downto 0);
		st: in std_logic_vector(13 downto 0);
		Z_r4 : out std_logic_vector(15 downto 0));
end component;

component round_off_DFF is
    port(
	    Z_rod : in std_logic_vector(15 downto 0);
		Zr_rod : in std_logic_vector(1 downto 0);
		Zn_rod : in std_logic;
		st: in std_logic_vector(13 downto 0);
		Z_rsl : out std_logic_vector(15 downto 0));
end component;

component register5 is 
	port(
		Z_r5d : in std_logic_vector(15 downto 0);
		st: in std_logic_vector(13 downto 0);
		Z_r5 : out std_logic_vector(15 downto 0));
end component;

component transfer_out_signed is 
	port(
		Z_td : in std_logic_vector(15 downto 0);
		Zn_d : in std_logic;
		st: in std_logic_vector(13 downto 0);
		Z_sig : out signed(15 downto 0));
end component;

component register6 is 
	port(
		R_r6d : in signed(15 downto 0);
		st: in std_logic_vector(13 downto 0);
		R_r6 : out signed(15 downto 0));
end component;

component out_rsl is 
	port(
		R_od : in signed(15 downto 0);
		st: in std_logic_vector(13 downto 0);
		Z : out signed(15 downto 0));
end component;

-- essential signals to connect each component
signal a_tr, b_tr : integer;
signal Z_neg : std_logic;
signal a_me1, b_me1 : std_logic_vector(7 downto 0);
signal a_mul, b_mul : std_logic_vector(7 downto 0);
signal z_me2 : std_logic_vector(15 downto 0);
signal z_div : std_logic_vector(15 downto 0);
signal z_me3 : std_logic_vector(15 downto 0);
signal zr_me3 : std_logic_vector(1 downto 0);
signal zq_inc : std_logic_vector(15 downto 0);
signal z_me4 : std_logic_vector(15 downto 0); 
signal z_round : std_logic_vector(15 downto 0);
signal zr_round : std_logic_vector(1 downto 0);
signal z_me5 : std_logic_vector(15 downto 0);
signal z_trans : std_logic_vector(15 downto 0);
signal R_me6 : signed(15 downto 0);
signal R_out_rsl : signed(15 downto 0);

begin

U1: load_en_signed
    port map(A, B, state_now, a_tr, b_tr);
U2: transfer_in_signed
    port map(a_tr, b_tr, a_me1, b_me1, Z_neg);
U3: register1
    port map(a_me1, b_me1, state_now, a_mul, b_mul);
U4: multi_DFF
    port map(a_mul, b_mul, state_now, z_me2);
U5: register2
    port map(z_me2, state_now, z_div);
U6: div_DFF
    port map(z_div, state_now, z_me3, zr_me3);
U7: register3
    port map(z_me3, zr_me3, state_now, zq_inc, zr_round); 
U8: incre_DFF
    port map(zq_inc, Z_neg, state_now, z_me4);
U9: register4
    port map(z_me4, state_now, z_round);
U10: round_off_DFF
    port map(z_round, zr_round, z_neg, state_now, z_me5);
U11: register5
    port map(z_me5, state_now, z_trans); 
U12: transfer_out_signed
    port map(z_trans, Z_neg, state_now, R_me6);
U13: register6
    port map(R_me6, state_now, R_out_rsl);
U14: out_rsl
    port map(R_out_rsl, state_now, Z);
	
end arc_fsm_data_path_signed;	