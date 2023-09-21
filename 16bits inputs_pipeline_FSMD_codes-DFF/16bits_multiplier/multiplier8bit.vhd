------------------------------------------------------------
-- Library Name : 8 bit multiplier
-- Unit Name : multiplier8bit
------------------------------------------------------------
-- Date : 10 Nov 2022
-- Designer : RUSHIK SHINGALA
-- Description : using ripple carry adder and 4 bit multiplier design 8 bit multiplier.

library IEEE;
use IEEE.std_logic_1164.all;
entity multiplier8bit is 
port (
a,b: in std_logic_vector(7 downto 0);
output: out std_logic_vector(15 downto 0));
end multiplier8bit;

architecture multi of multiplier8bit is                                                           
component multiplier4bit port(a,b: in std_logic_vector(3 downto 0); output: out std_logic_vector(7 downto 0));
end component;
component half_adder_8bit port(a,b: in std_logic_vector(7 downto 0); cout:out std_logic;sum: out std_logic_vector(7 downto 0));
end component;
component half_adder_12bit port(a,b: in std_logic_vector(11 downto 0); cout:out std_logic;sum: out std_logic_vector(11 downto 0));
end component;

for fa80: half_adder_8bit use entity
work.half_adder_8bit(struc);
for fa100: half_adder_12bit use entity
work.half_adder_12bit(struc);
for fa101: half_adder_12bit use entity
work.half_adder_12bit(struc);

for m1: multiplier4bit use entity
work.multiplier4bit(multi);
for m2: multiplier4bit use entity
work.multiplier4bit(multi);
for m3: multiplier4bit use entity
work.multiplier4bit(multi);
for m4: multiplier4bit use entity
work.multiplier4bit(multi);

signal c0,c1,c2,c3:std_logic;
signal s0,s1,s2,s3,s4,s5,s6:std_logic_vector(7 downto 0);
signal f1,f2,f3,f4: std_logic_vector(11 downto 0);


begin 
m1: multiplier4bit port map(a(3 downto 0),b(3 downto 0),s0(7 downto 0));
m2: multiplier4bit port map(a(7 downto 4),b(3 downto 0),s1(7 downto 0));
m3: multiplier4bit port map(a(3 downto 0),b(7 downto 4),s2(7 downto 0));
m4: multiplier4bit port map(a(7 downto 4),b(7 downto 4),s3(7 downto 0));

s6<="0000"&s0(7 downto 4);
fa80: half_adder_8bit port map(s1(7 downto 0),s6,c0,s4(7 downto 0));
f1<="0000"&s2;
f2<=s3&"0000";
fa100: half_adder_12bit port map(f1,f2,c2,f3);
f4<="000"&c0&s4;
fa101: half_adder_12bit port map(f3,f4,c3,output(15 downto 4)); 
output(3 downto 0)<= s0(3 downto 0);

end multi;