library IEEE;
use IEEE.std_logic_1164.all;
use work.all;
--two 4bits inputs : A B 
entity half_adder_4bit is 
port (
a,b: in std_logic_vector(3 downto 0);
cout: out std_logic;
sum: out std_logic_vector(3 downto 0));
end half_adder_4bit;

architecture struc of half_adder_4bit is 

component full_adder is
port(
    I0 : in std_logic;          --first input
	I1 : in std_logic;          --second input
	I2 : in std_logic;          --previous carry "jinwei"
	Os : out std_logic;        --sum "he"
	Oc : out std_logic);       --carry "jinwei"
end component;

component half_adder is
port(
    I0 : in std_logic;    --first input
	I1 : in std_logic;    --second input
	Os : out std_logic;   --sum "he"
	Oc : out std_logic);  --carry "jinwei"
end component;


signal c0,c1,c2:std_logic;

begin 
ha0: half_adder port map(a(0),b(0),sum(0),c0);
fa1: full_adder port map(a(1),b(1),c0,sum(1),c1);
fa2: full_adder port map(a(2),b(2),c1,sum(2),c2);
fa3: full_adder port map(a(3),b(3),c2,sum(3),cout);
end struc;
