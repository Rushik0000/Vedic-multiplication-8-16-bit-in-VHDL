
------------------------------------------------------------
-- Library Name : 4 bit multiplier 
-- Unit Name : multiplier4bit
------------------------------------------------------------
-- Date : Nov 7 2022
-- Designer : RUSHIK SHINGALA
-- Description : using ripple carry adder and 2 bit multiplier design 4 bit multiplier
library IEEE;
use IEEE.std_logic_1164.all;
entity multiplier4bit is 
port (
a,b: in std_logic_vector(3 downto 0);
output: out std_logic_vector(7 downto 0));
end multiplier4bit;

architecture multi of multiplier4bit is                                                           
component full_adder port(a,b,cin : in std_logic; co,o: out std_logic);
end component;
component half_adder port(a,b: in std_logic; co,o: out std_logic);
end component;
component multiplier2bit port(a,b: in std_logic_vector(1 downto 0); output: out std_logic_vector(3 downto 0));
end component;
component half_adder_4bit port(a,b: in std_logic_vector(3 downto 0); cout:out std_logic;sum: out std_logic_vector(3 downto 0));
end component;
component half_adder_6bit port(a,b: in std_logic_vector(5 downto 0); cout:out std_logic;sum: out std_logic_vector(5 downto 0));
end component;
for fa40: half_adder_4bit use entity
work.half_adder_4bit(struc);
for fa60: half_adder_6bit use entity
work.half_adder_6bit(struc);
for fa61: half_adder_6bit use entity
work.half_adder_6bit(struc);
for m1: multiplier2bit use entity
work.multiplier2bit(multi);
for m2: multiplier2bit use entity
work.multiplier2bit(multi);
for m3: multiplier2bit use entity
work.multiplier2bit(multi);
for m4: multiplier2bit use entity
work.multiplier2bit(multi);
signal c0,c1,c2:std_logic;
signal s0,s1,s2,s3,s4,s5,s6:std_logic_vector(3 downto 0);
signal f0,f1,f3,f4,f5,f6: std_logic_vector(5 downto 0);


begin 
m1: multiplier2bit port map(a(1 downto 0),b(1 downto 0),s0(3 downto 0));
m2: multiplier2bit port map(a(3 downto 2),b(1 downto 0),s1(3 downto 0));
m3: multiplier2bit port map(a(1 downto 0),b(3 downto 2),s2(3 downto 0));
m4: multiplier2bit port map(a(3 downto 2),b(3 downto 2),s3(3 downto 0));
s6<="00"&s0(3 downto 2);
fa40: half_adder_4bit port map(s1(3 downto 0),s6,c0,s4(3 downto 0));
f4<="00"&s2;
f5<=s3&"00";
fa60: half_adder_6bit port map(f4,f5,c2,f3);
f6<="0" &C0&s4;
fa61: half_adder_6bit port map(f3,f6,c2,output(7 downto 2)); 
output(1 downto 0)<= s0(1 downto 0);

end multi;