------------------------------------------------------------
-- Library Name : 2 bit multiplier
-- Unit Name : multiplier2bit
------------------------------------------------------------
-- Date : oct 29 Nov 2022
-- Designer : RUSHIK SHINGALA
-- Description : using half addder and And gate design 2 bit multiplier.
library IEEE;
use IEEE.std_logic_1164.all;
use work.all;
entity multiplier2bit is 
port (
a,b: in std_logic_vector(1 downto 0);
output: out std_logic_vector(3 downto 0));
end multiplier2bit;

architecture multi of multiplier2bit is 
component full_adder port(a,b,cin : in std_logic; co,o: out std_logic);
end component;
component half_adder port(a,b: in std_logic; co,o: out std_logic);
end component;
for ha0: half_adder use entity
work.half_adder(imp);
for ha1: half_adder use entity
work.half_adder(imp);
signal c0,c1:std_logic;
signal s0,s1,s2:std_logic;

begin 
output(0)<=a(0) and b(0);
s0<=a(1) and b(0);
s1<=a(0) and b(1);
s2<=a(1) and b(1);
ha0: half_adder port map(s0,s1,c0,output(1));
ha1: half_adder port map(s2,c0,c1,output(2));
output(3)<=c1;
end multi;
