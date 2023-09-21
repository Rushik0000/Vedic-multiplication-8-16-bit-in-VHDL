------------------------------------------------------------
-- Library Name : 16 bit multiplier 
-- Unit Name : multiplier16bit
------------------------------------------------------------
-- Date : Nov 12 2022
-- Designer : RUSHIK SHINGALA
-- Description : using ripple carry adder and 8 bit multiplier design 16 bit multiplier
library IEEE;
use IEEE.std_logic_1164.all;
-- 16bits inputs A B multiplier
entity multiplier16bit is 
port (
a,b: in std_logic_vector(15 downto 0);
output: out std_logic_vector(31 downto 0));
end multiplier16bit;

architecture multi of multiplier16bit is                                                           
component multiplier8bit port(a,b: in std_logic_vector(7 downto 0); output: out std_logic_vector(15 downto 0));
end component;
component half_adder_16bit port(a,b: in std_logic_vector(15 downto 0); cout:out std_logic;sum: out std_logic_vector(15 downto 0));
end component;
component half_adder_24bit port(a,b: in std_logic_vector(23 downto 0); cout:out std_logic;sum: out std_logic_vector(23 downto 0));
end component;
component half_adder_32bit port(a,b: in std_logic_vector(31 downto 0); cout: out std_logic; sum: out std_logic_vector(31 downto 0));
end component;

for fa160: half_adder_16bit use entity
work.half_adder_16bit(struc);
for fa240: half_adder_24bit use entity
work.half_adder_24bit(struc);
for fa241: half_adder_24bit use entity
work.half_adder_24bit(struc);
--for fa320: half_adder_32bit use entity
--work.half_adder_32bit(struc);



for m1: multiplier8bit use entity
work.multiplier8bit(multi);
for m2: multiplier8bit use entity
work.multiplier8bit(multi);
for m3: multiplier8bit use entity
work.multiplier8bit(multi);
for m4: multiplier8bit use entity
work.multiplier8bit(multi);

signal c0,c1,c2:std_logic;
-- c2 always be 0 in 16bits inputs caculation
signal s0,s1,s2,s3,s4,s5,s6:std_logic_vector(15 downto 0);
signal f1,f2,f3,f4,f5: std_logic_vector(23 downto 0);
--signal eq,final_eq,a1,a2:std_logic_vector(31 downto 0);
signal output_mul : std_logic_vector(31 downto 0);


begin 
m1: multiplier8bit port map(a(7 downto 0),b(7 downto 0),s0(15 downto 0));
m2: multiplier8bit port map(a(7 downto 0),b(15 downto 8),s1(15 downto 0));
m3: multiplier8bit port map(a(15 downto 8),b(7 downto 0),s2(15 downto 0));
m4: multiplier8bit port map(a(15 downto 8),b(15 downto 8),s3(15 downto 0));

s6<="00000000"&s0(15 downto 8);
fa160: half_adder_16bit port map(s1(15 downto 0),s6,c0,s4(15 downto 0));
f1<="00000000"&s2;
f2<=s3&"00000000";
fa240: half_adder_24bit port map(f1,f2,c2,f3);
f4<="0000000"&c0&s4;
fa241: half_adder_24bit port map(f3,f4,c2,f5); 
output_mul(7 downto 0)<= s0(7 downto 0);
output_mul(31 downto 8)<=f5;

output <= f5&s0(7 downto 0);
-- 1/4 division and +1 incrementor
--a1<=f5&s0(7 downto 0);
--eq<="00"&a1(31 downto 2);
--a2<="00000000000000000000000000000001";    
--fa320: half_adder_32bit port map(eq,a2,c3,output); 
end multi; 