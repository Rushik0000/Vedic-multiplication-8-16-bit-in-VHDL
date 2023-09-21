
------------------------------------------------------------
-- Library Name : Ripple Carry adder
-- Unit Name : half_adder_6bit
------------------------------------------------------------
-- Date : Oct.3 2022
-- Designer : RUSHIK SHINGALA
-- Description : using Full adder and Half adder design Ripple carry adder
------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use work.all;
--two 6bits inputs : A B 
entity half_adder_6bit is 
port (
a,b: in std_logic_vector(5 downto 0);
cout: out std_logic;
sum: out std_logic_vector(5 downto 0));
end half_adder_6bit;

architecture struc of half_adder_6bit is 
component full_adder port(a,b,cin : in std_logic; co,o: out std_logic);
end component;
component half_adder port(a,b: in std_logic; co,o: out std_logic);
end component;

signal c0,c1,c2,c3,c4:std_logic;

begin 
ha0: half_adder port map(a(0),b(0),c0,sum(0));
fa1: full_adder port map(a(1),b(1),c0,c1,sum(1));
fa2: full_adder port map(a(2),b(2),c1,c2,sum(2));
fa3: full_adder port map(a(3),b(3),c2,c3,sum(3));
fa4: full_adder port map(a(4),b(4),c3,c4,sum(4));
fa5: full_adder port map(a(5),b(5),c4,cout,sum(5));
end struc;
