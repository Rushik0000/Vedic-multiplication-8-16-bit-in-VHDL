------------------------------------------------------------
-- Library Name : whole project process with FSMD
-- Unit Name : fsmd_16bits_project
------------------------------------------------------------
-- Date : Nov. 30, 2022
-- Designer : Yijun Li
-- Description : using FSM with data path and control path
-- connect data path and control path of FSMD
------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fsmd_16bits_project is 
	port(
	     clock : in std_logic;
	     load : in std_logic;
	     clear : in std_logic;
	     A : in unsigned(15 downto 0);
	     B : in unsigned(15 downto 0);
		 end_flag : out std_logic;
	     Z : out signed(31 downto 0));
end fsmd_16bits_project;

architecture arc_fsmd_16bits_project of fsmd_16bits_project is

component fsm_16bits_data_path is 
	port(
	     A : in unsigned(15 downto 0);
	     B : in unsigned(15 downto 0);
         state_now : in std_logic_vector(7 downto 0);
	     Z : out signed(31 downto 0));
end component;

component fsm_16bits_control_path is 
	port(
	     clock : in std_logic;
	     load : in std_logic;
	     clear : in std_logic;
         state_now : out std_logic_vector(7 downto 0);
		 end_flag : out std_logic);
end component;

signal state_cur : std_logic_vector(7 downto 0);

begin

U_data_path: fsm_16bits_data_path
port map(A, B, state_cur, Z);

U_control_path: fsm_16bits_control_path
port map(clock, load, clear, state_cur, end_flag);

end arc_fsmd_16bits_project;