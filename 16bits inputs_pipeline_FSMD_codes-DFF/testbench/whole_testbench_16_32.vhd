-----------------------------------------------------------------------
-- Library Name : whole testbench for 16 bits unsigned
-- Unit Name : whole_testbench_16_32
------------------------------------------------------------------------
-- Date : Nov. 24, 2022
-- Designer : Yijun li
-- Description : testbench for 16 bits inputs A B and 32bits output Z
-- include : generator, main part, monitor
------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity whole_testbench_16_32 is
end whole_testbench_16_32;

architecture arc_whole_testbench_16_32 of whole_testbench_16_32 is

--generator
component ge_tb_16bits is
port(
     clk : out std_logic;
	 load : out std_logic;
	 clear : out std_logic;
	 A : out unsigned(15 downto 0);
	 B : out unsigned(15 downto 0));
end component;

--main part
component fsmd_16bits_project is 
	port(
	     clock : in std_logic;
	     load : in std_logic;
	     clear : in std_logic;
	     A : in unsigned(15 downto 0);
	     B : in unsigned(15 downto 0);
		 end_flag : out std_logic;
	     Z : out signed(31 downto 0));
end component;

--monitor
component mo_tb_32bits is
port(
	 A : in unsigned(15 downto 0);
	 B : in unsigned(15 downto 0);
	 end_flag : in std_logic;
	 Z : in signed(31 downto 0));
end component;

signal clock, clear, load, end_flag : std_logic;
signal A, B : unsigned(15 downto 0);
signal Z : signed(31 downto 0);

begin
    
-- test generator
unit_ge: ge_tb_16bits
port map(clock, load, clear, A, B);

-- body part(main part)
unit_fsmd: fsmd_16bits_project
port map(clock, load, clear, A, B, end_flag, Z);
  
-- test verifier
unit_mo: mo_tb_32bits
port map(A, B, end_flag, Z);
		
end arc_whole_testbench_16_32;