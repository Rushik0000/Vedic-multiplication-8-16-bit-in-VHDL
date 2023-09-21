------------------------------------------------------------
-- Library Name : Ripple carry adder for 32bit 
-- Unit Name : Half_adder_32bit
------------------------------------------------------------
-- Date : Nov 1, 2022
-- Designer : RUSHIK SHINGALA
-- Description : using half_adder and full_adder design ripple carry adder
------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use work.all;
--two 32bits inputs : A B 
entity half_adder_32bit is 
port (
a,b: in std_logic_vector(31 downto 0);
cout: out std_logic;
sum: out std_logic_vector(31 downto 0));
end half_adder_32bit;

architecture struc of half_adder_32bit is 
component full_adder port(a,b,cin : in std_logic; co,o: out std_logic);
end component;
component half_adder port(a,b: in std_logic; co,o: out std_logic);
end component;

signal c0,c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13,c14,c15,c16,c17,c18,c19,c20,c21,c22,c23,c24,c25,c26,c27,c28,c29,c30:std_logic;

begin 
ha0:  half_adder port map(a(0),b(0),c0,sum(0));
fa1:  full_adder port map(a(1),b(1),c0,c1,sum(1));
fa2:  full_adder port map(a(2),b(2),c1,c2,sum(2));
fa3:  full_adder port map(a(3),b(3),c2,c3,sum(3));
fa4:  full_adder port map(a(4),b(4),c3,c4,sum(4));
fa5:  full_adder port map(a(5),b(5),c4,c5,sum(5));
fa6:  full_adder port map(a(6),b(6),c5,c6,sum(6));
fa7:  full_adder port map(a(7),b(7),c6,c7,sum(7));
fa8:  full_adder port map(a(8),b(8),c7,c8,sum(8));
fa9:  full_adder port map(a(9),b(9),c8,c9,sum(9));
fa10: full_adder port map(a(10),b(10),c9,c10,sum(10));
fa11: full_adder port map(a(11),b(11),c10,c11,sum(11));
fa12: full_adder port map(a(12),b(12),c11,c12,sum(12));
fa13: full_adder port map(a(13),b(13),c12,c13,sum(13));
fa14: full_adder port map(a(14),b(14),c13,c14,sum(14));
fa15: full_adder port map(a(15),b(15),c14,c15,sum(15));
fa16: full_adder port map(a(16),b(16),c15,c16,sum(16));
fa17: full_adder port map(a(17),b(17),c16,c17,sum(17));
fa18: full_adder port map(a(18),b(18),c17,c18,sum(18));
fa19: full_adder port map(a(19),b(19),c18,c19,sum(19));
fa20: full_adder port map(a(20),b(20),c19,c20,sum(20));
fa21: full_adder port map(a(21),b(21),c20,c21,sum(21));
fa22: full_adder port map(a(22),b(22),c21,c22,sum(22));
fa23: full_adder port map(a(23),b(23),c22,c23,sum(23));
fa24: full_adder port map(a(24),b(24),c23,c24,sum(24));
fa25: full_adder port map(a(25),b(25),c24,c25,sum(25));
fa26: full_adder port map(a(26),b(26),c25,c26,sum(26));
fa27: full_adder port map(a(27),b(27),c26,c27,sum(27));
fa28: full_adder port map(a(28),b(28),c27,c28,sum(28));
fa29: full_adder port map(a(29),b(29),c28,c29,sum(29));
fa30: full_adder port map(a(30),b(30),c29,c30,sum(30));
fa31: full_adder port map(a(31),b(31),c30,cout,sum(31));
end struc;
