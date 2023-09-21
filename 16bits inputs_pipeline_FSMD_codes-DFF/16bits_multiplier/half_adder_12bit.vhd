------------------------------------------------------------
-- Library Name : Ripple carry adder for 12bit 
-- Unit Name : Half_adder_12bit
------------------------------------------------------------
-- Date : Oct 15, 2022
-- Designer : RUSHIK SHINGALA
-- Description : using half_adder and full_adder design ripple carry adder
------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use work.all;
--two 12bits inputs : A B 
entity half_adder_12bit is 
port (
a,b: in std_logic_vector(11 downto 0);
cout: out std_logic;
sum: out std_logic_vector(11 downto 0));
end half_adder_12bit;

architecture struc of half_adder_12bit is 
component full_adder port(a,b,cin : in std_logic; co,o: out std_logic);
end component;
component half_adder port(a,b: in std_logic; co,o: out std_logic);
end component;

signal c0,c1,c2,c3,c4,c5,c6,c7,c8,c9,c10:std_logic;


begin 
ha0: half_adder port map(a(0),b(0),c0,sum(0));
fa1: full_adder port map(a(1),b(1),c0,c1,sum(1));
fa2: full_adder port map(a(2),b(2),c1,c2,sum(2));
fa3: full_adder port map(a(3),b(3),c2,c3,sum(3));
fa4: full_adder port map(a(4),b(4),c3,c4,sum(4));
fa5: full_adder port map(a(5),b(5),c4,c5,sum(5));
fa6: full_adder port map(a(6),b(6),c5,c6,sum(6));
fa7: full_adder port map(a(7),b(7),c6,c7,sum(7));
fa8: full_adder port map(a(8),b(8),c7,c8,sum(8));
fa9: full_adder port map(a(9),b(9),c8,c9,sum(9));
fa10: full_adder port map(a(10),b(10),c9,c10,sum(10));
fa11: full_adder port map(a(11),b(11),c10,cout,sum(11));
end struc;
