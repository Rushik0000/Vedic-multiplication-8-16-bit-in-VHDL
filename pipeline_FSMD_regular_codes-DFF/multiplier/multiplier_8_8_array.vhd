------------------------------------------------------
-- Library Name : 8*8Multiplier_array
-- Unit Name : Multiplier_8times8_array
------------------------------------------------------
-- Date : Mon. Oct. 24th 2022
-- Designer : Yijun Li
-- Description : Array Architecture of 8*8 Multiplier Block
------------------------------------------------------
    
library ieee;
use ieee.std_logic_1164.all;

entity multiplier_8_8_array is
port(
    X : in std_logic_vector(7 downto 0);
    Y : in std_logic_vector(7 downto 0);	
    Z : out std_logic_vector(15 downto 0));
end multiplier_8_8_array;

architecture arc_multiplier8_array of multiplier_8_8_array is

component half_adder
port(
    I0,I1 : in std_logic;
    Oc,Os : out std_logic);
end component;

component full_adder
port(
    I0,I1,I2 : in std_logic;
    Oc,Os : out std_logic);
end component;

signal X0Y,X1Y,X2Y,X3Y,X4Y,X5Y,X6Y,X7Y : std_logic_vector(7 downto 0);
signal C_U1,S_U21,S_U131 : std_logic;
signal C_U2,C_U13,S_U3,S_U12 : std_logic_vector(2 downto 1);
signal C_U3,C_U12,S_U4,S_U11 : std_logic_vector(3 downto 1);
signal C_U4,C_U11,S_U5,S_U10 : std_logic_vector(4 downto 1);
signal C_U5,C_U10,S_U6,S_U9 : std_logic_vector(5 downto 1);
signal C_U6,C_U9,S_U7,S_U8 : std_logic_vector(6 downto 1);
signal C_U7,C_U8 : std_logic_vector(7 downto 1);

begin
  process(X,Y)
    begin
      for i in 7 downto 0 loop
        X7Y(i) <= X(7) and Y(i);
        X6Y(i) <= X(6) and Y(i);
        X5Y(i) <= X(5) and Y(i);
        X4Y(i) <= X(4) and Y(i);
		X3Y(i) <= X(3) and Y(i);
        X2Y(i) <= X(2) and Y(i);
        X1Y(i) <= X(1) and Y(i);
        X0Y(i) <= X(0) and Y(i);
      end loop;
  end process;
  
  Z(0) <= X0Y(0);
  u1: half_adder
  port map(I0 => X1Y(0), I1 => X0Y(1), Oc => C_U1, Os => Z(1));
  U2_1: full_adder
  port map(I0 => X2Y(0), I1 => X1Y(1), I2 => C_U1, Oc => C_U2(1), Os => S_U21);
  U3_1: full_adder
  port map(I0 => X3Y(0), I1 => X2Y(1), I2 => C_U2(1), Oc => C_U3(1), Os => S_U3(1));
  U4_1: full_adder
  port map(I0 => X4Y(0), I1 => X3Y(1), I2 => C_U3(1), Oc => C_U4(1), Os => S_U4(1));
  U5_1: full_adder
  port map(I0 => X5Y(0), I1 => X4Y(1), I2 => C_U4(1), Oc => C_U5(1), Os => S_U5(1));
  U6_1: full_adder
  port map(I0 => X6Y(0), I1 => X5Y(1), I2 => C_U5(1), Oc => C_U6(1), Os => S_U6(1));
  U7_1: full_adder
  port map(I0 => X7Y(0), I1 => X6Y(1), I2 => C_U6(1), Oc => C_U7(1), Os => S_U7(1));
  U2_2: half_adder
  port map(I0 => S_U21, I1 => X0Y(2), Oc => C_U2(2), Os => Z(2));
  U3_2: full_adder
  port map(I0 => S_U3(1), I1 => X1Y(2), I2 => C_U2(2), Oc => C_U3(2), Os => S_U3(2));
  U4_2: full_adder
  port map(I0 => S_U4(1), I1 => X2Y(2), I2 => C_U3(2), Oc => C_U4(2), Os => S_U4(2));
  U5_2: full_adder
  port map(I0 => S_U5(1), I1 => X3Y(2), I2 => C_U4(2), Oc => C_U5(2), Os => S_U5(2));
  U6_2: full_adder
  port map(I0 => S_U6(1), I1 => X4Y(2), I2 => C_U5(2), Oc => C_U6(2), Os => S_U6(2));
  U7_2: full_adder
  port map(I0 => S_U7(1), I1 => X5Y(2), I2 => C_U6(2), Oc => C_U7(2), Os => S_U7(2));
  U8_1: full_adder
  port map(I0 => C_U7(1), I1 => X7Y(1), I2 => C_U7(2), Oc => C_U8(1), Os => S_U8(1));
  U3_3: half_adder
  port map(I0 => S_U3(2), I1 => X0Y(3), Oc => C_U3(3), Os => Z(3));
  U4_3: full_adder
  port map(I0 => S_U4(2), I1 => X1Y(3), I2  => C_U3(3), Oc => C_U4(3), Os => S_U4(3));
  U5_3: full_adder
  port map(I0 => S_U5(2), I1 => X2Y(3), I2  => C_U4(3), Oc => C_U5(3), Os => S_U5(3));
  U6_3: full_adder
  port map(I0 => S_U6(2), I1 => X3Y(3), I2  => C_U5(3), Oc => C_U6(3), Os => S_U6(3));
  U7_3: full_adder
  port map(I0 => S_U7(2), I1 => X4Y(3), I2  => C_U6(3), Oc => C_U7(3), Os => S_U7(3));
  U8_2: full_adder
  port map(I0 => S_U8(1), I1 => X6Y(2), I2  => C_U7(3), Oc => C_U8(2), Os => S_U8(2));
  U9_1: full_adder
  port map(I0 => C_U8(1), I1 => X7Y(2), I2  => C_U8(2), Oc => C_U9(1), Os => S_U9(1));
  U4_4: half_adder
  port map(I0 => S_U4(3), I1 => X0Y(4), Oc => C_U4(4), Os => Z(4));
  U5_4: full_adder
  port map(I0 => S_U5(3), I1 => X1Y(4), I2 => C_U4(4), Oc => C_U5(4), Os => S_U5(4));
  U6_4: full_adder
  port map(I0 => S_U6(3), I1 => X2Y(4), I2 => C_U5(4), Oc => C_U6(4), Os => S_U6(4));
  U7_4: full_adder
  port map(I0 => S_U7(3), I1 => X3Y(4), I2 => C_U6(4), Oc => C_U7(4), Os => S_U7(4));
  U8_3: full_adder
  port map(I0 => S_U8(2), I1 => X5Y(3), I2 => C_U7(4), Oc => C_U8(3), Os => S_U8(3));
  U9_2: full_adder
  port map(I0 => S_U9(1), I1 => X6Y(3), I2 => C_U8(3), Oc => C_U9(2), Os => S_U9(2));
  U10_1: full_adder
  port map(I0 => C_U9(1), I1 => X7Y(3), I2 => C_U9(2), Oc => C_U10(1), Os => S_U10(1));
  U5_5: half_adder
  port map(I0 => S_U5(4), I1 => X0Y(5), Oc => C_U5(5), Os => Z(5));
  U6_5: full_adder
  port map(I0 => S_U6(4), I1 => X1Y(5), I2 => C_U5(5), Oc => C_U6(5), Os => S_U6(5));
  U7_5: full_adder
  port map(I0 => S_U7(4), I1 => X2Y(5), I2 => C_U6(5), Oc => C_U7(5), Os => S_U7(5));
  U8_4: full_adder
  port map(I0 => S_U8(3), I1 => X4Y(4), I2 => C_U7(5), Oc => C_U8(4), Os => S_U8(4));
  U9_3: full_adder
  port map(I0 => S_U9(2), I1 => X5Y(4), I2 => C_U8(4), Oc => C_U9(3), Os => S_U9(3));
  U10_2: full_adder
  port map(I0 => S_U10(1), I1 => X6Y(4), I2  => C_U9(3), Oc => C_U10(2), Os => S_U10(2));
  U11_1: full_adder
  port map(I0 => C_U10(1), I1 => X7Y(4), I2  => C_U10(2), Oc => C_U11(1), Os => S_U11(1));
  U6_6: half_adder
  port map(I0 => S_U6(5), I1 => X0Y(6), Oc => C_U6(6), Os => Z(6));
  U7_6: full_adder
  port map(I0 => S_U7(5), I1 => X1Y(6), I2 => C_U6(6), Oc => C_U7(6), Os => S_U7(6));
  U8_5: full_adder
  port map(I0 => S_U8(4), I1 => X3Y(5), I2 => C_U7(6), Oc => C_U8(5), Os => S_U8(5));
  U9_4: full_adder
  port map(I0 => S_U9(3), I1 => X4Y(5), I2 => C_U8(5), Oc => C_U9(4), Os => S_U9(4));
  U10_3: full_adder
  port map(I0 => S_U10(2), I1 => X5Y(5), I2  => C_U9(4), Oc => C_U10(3), Os => S_U10(3));
  U11_2: full_adder
  port map(I0 => S_U11(1), I1 => X6Y(5), I2  => C_U10(3), Oc => C_U11(2), Os => S_U11(2));
  U12_1: full_adder
  port map(I0 => C_U11(1), I1 => X7Y(5), I2  => C_U11(2), Oc => C_U12(1), Os => S_U12(1));
  U7_7: half_adder
  port map(I0 => S_U7(6), I1 => X0Y(7), Oc => C_U7(7), Os => Z(7));
  U8_6: full_adder
  port map(I0 => S_U8(5), I1 => X2Y(6), I2 => C_U7(7), Oc => C_U8(6), Os => S_U8(6));
  U9_5: full_adder
  port map(I0 => S_U9(4), I1 => X3Y(6), I2 => C_U8(6), Oc => C_U9(5), Os => S_U9(5));
  U10_4: full_adder
  port map(I0 => S_U10(3), I1 => X4Y(6), I2  => C_U9(5), Oc => C_U10(4), Os => S_U10(4));
  U11_3: full_adder
  port map(I0 => S_U11(2), I1 => X5Y(6), I2  => C_U10(4), Oc => C_U11(3), Os => S_U11(3));
  U12_2: full_adder
  port map(I0 => S_U12(1), I1 => X6Y(6), I2  => C_U11(3), Oc => C_U12(2), Os => S_U12(2));
  U13_1: full_adder
  port map(I0 => C_U12(1), I1 => X7Y(6), I2  => C_U12(2), Oc => C_U13(1), Os => S_U131);
  U8_7: half_adder
  port map(I0 => S_U8(6), I1 => X1Y(7), Oc => C_U8(7), Os => Z(8));
  U9_6: full_adder
  port map(I0 => S_U9(5), I1 => X2Y(7), I2 => C_U8(7), Oc => C_U9(6), Os => Z(9));
  U10_5: full_adder
  port map(I0 => S_U10(4), I1 => X3Y(7), I2  => C_U9(6), Oc => C_U10(5), Os => Z(10));
  U11_4: full_adder
  port map(I0 => S_U11(3), I1 => X4Y(7), I2  => C_U10(5), Oc => C_U11(4), Os => Z(11));
  U12_3: full_adder
  port map(I0 => S_U12(2), I1 => X5Y(7), I2  => C_U11(4), Oc => C_U12(3), Os => Z(12));
  U13_2: full_adder
  port map(I0 => S_U131, I1 => X6Y(7), I2  => C_U12(3), Oc => C_U13(2), Os => Z(13));
  U14: full_adder
  port map(I0 => C_U13(1), I1 => X7Y(7), I2  => C_U13(2), Oc => Z(15), Os => Z(14));
  
end arc_multiplier8_array;