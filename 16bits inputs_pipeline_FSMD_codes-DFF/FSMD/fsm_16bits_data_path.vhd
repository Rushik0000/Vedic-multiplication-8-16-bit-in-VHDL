-----------------------------------------------------------------------
-- Library Name : FSM with data path connection
-- Unit Name : fsm_16bits_data_path
-----------------------------------------------------------------------
-- Date : Nov. 30, 2022
-- Designer : Yijun Li
-- Description : connect each component in data path of FSM
-----------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fsm_16bits_data_path is 
	port(
	     A : in unsigned(15 downto 0);
	     B : in unsigned(15 downto 0);
         state_now : in std_logic_vector(7 downto 0);
	     Z : out signed(31 downto 0)
		);
end fsm_16bits_data_path;

architecture arc_fsm_16bits_data_path of fsm_16bits_data_path is 

component load_en_16bits is 
	port(
		A : in unsigned(15 downto 0);
		B : in unsigned(15 downto 0);
		st: in std_logic_vector(7 downto 0);
		A_reg : out unsigned(15 downto 0);
		B_reg : out unsigned(15 downto 0));
end component;

component transfer_in_16bits is 
	port(
		A_us : in unsigned(15 downto 0);
		B_us : in unsigned(15 downto 0);
		A_std : out std_logic_vector(15 downto 0);
		B_std : out std_logic_vector(15 downto 0));
end component;

component register1_16bits is 
	port(
		a_r1d : in std_logic_vector(15 downto 0);
		b_r1d : in std_logic_vector(15 downto 0);
		st: in std_logic_vector(7 downto 0);
		a_r1 : out std_logic_vector(15 downto 0);
		b_r1 : out std_logic_vector(15 downto 0));
end component;

component multi_div_inc_DFF is 
	port(
		a_md : in std_logic_vector(15 downto 0);
		b_md : in std_logic_vector(15 downto 0);
		st: in std_logic_vector(7 downto 0);
		Z_m : out std_logic_vector(31 downto 0));
end component;

component register2_32bits is 
	port(
		Z_r2d : in std_logic_vector(31 downto 0);
		st: in std_logic_vector(7 downto 0);
		Z_r2 : out std_logic_vector(31 downto 0));
end component;

component transfer_out_32bits is 
	port(
		Z_td : in std_logic_vector(31 downto 0);
		st: in std_logic_vector(7 downto 0);
		Z_sig : out signed(31 downto 0)
		);
end component;

component register3_32bits is 
	port(
		R_r3d : in signed(31 downto 0);
		st: in std_logic_vector(7 downto 0);
		R_r3 : out signed(31 downto 0)
		);
end component;

component out_rsl_32bits is 
	port(
		R_od : in signed(31 downto 0);
		st: in std_logic_vector(7 downto 0);
		Z : out signed(31 downto 0)
		);
end component;

-- essential signals to connect each component
signal a_tr, b_tr : unsigned(15 downto 0);
signal a_me1, b_me1 : std_logic_vector(15 downto 0);
signal a_mul, b_mul : std_logic_vector(15 downto 0);
signal z_me2 : std_logic_vector(31 downto 0);
signal z_trans : std_logic_vector(31 downto 0);
signal R_me3 : signed(31 downto 0);
signal R_out_rsl : signed(31 downto 0);

begin

U1: load_en_16bits
    port map(A, B, state_now, a_tr, b_tr);
U2: transfer_in_16bits
    port map(a_tr, b_tr, a_me1, b_me1);
U3: register1_16bits
    port map(a_me1, b_me1, state_now, a_mul, b_mul);
U4: multi_div_inc_DFF
    port map(a_mul, b_mul, state_now, z_me2);
U5: register2_32bits
    port map(z_me2, state_now, z_trans);
U6: transfer_out_32bits
    port map(z_trans, state_now, R_me3);
U7: register3_32bits
    port map(R_me3, state_now, R_out_rsl);
U8: out_rsl_32bits
    port map(R_out_rsl, state_now, Z);
	
end arc_fsm_16bits_data_path;	