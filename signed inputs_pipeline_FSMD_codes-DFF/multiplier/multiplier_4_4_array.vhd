------------------------------------------------------
-- Library Name : 4*4Multiplier_array
-- Unit Name : Multiplier_4times4_array
------------------------------------------------------
-- Date : Tues. Oct. 18th 2022
-- Designer : Yijun Li
-- Description : Array Architecture of 4*4 Multiplier Block
------------------------------------------------------
    
library ieee;
use ieee.std_logic_1164.all;

entity multiplier_4_4_array is
port(
    X : in std_logic_vector(3 downto 0);
    Y : in std_logic_vector(3 downto 0);	
  Z : out std_logic_vector(7 downto 0));
end multiplier_4_4_array;

architecture arc_multiplier4_array of multiplier_4_4_array is

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

signal X0Y,X1Y,X2Y,X3Y : std_logic_vector(3 downto 0);
signal C_U1,C_U21,C_U22,C_U31,C_U32,C_U33,C_U41,C_U42,C_U43,C_U51,C_U52 : std_logic;
signal S_U21,S_U31,S_U32,S_U41,S_U42,S_U51 : std_logic;

begin
  process(X,Y)
    begin
      for i in 3 downto 0 loop
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
  port map(I0 => X2Y(0), I1 => X1Y(1), I2 => C_U1, Oc => C_U21, Os => S_U21);
  U3_1: full_adder
  port map(I0 => X3Y(0), I1 => X2Y(1), I2 => C_U21, Oc => C_U31, Os => S_U31);
  U2_2: half_adder
  port map(I0 => S_U21, I1 => X0Y(2), Oc => C_U22, Os => Z(2));
  U3_2: full_adder
  port map(I0 => S_U31, I1 => X1Y(2), I2 => C_U22, Oc => C_U32, Os => S_U32);
  U4_1: full_adder
  port map(I0 => C_U31, I1 => X3Y(1), I2 => C_U32, Oc => C_U41, Os => S_U41);
  U3_3: half_adder
  port map(I0 => S_U32, I1 => X0Y(3), Oc => C_U33, Os => Z(3));
  U4_2: full_adder
  port map(I0 => S_U41, I1 => X2Y(2), I2  => C_U33, Oc => C_U42, Os => S_U42);
  U5_1: full_adder
  port map(I0 => C_U41, I1 => X3Y(2), I2  => C_U42, Oc => C_U51, Os => S_U51);
  U4_3: half_adder
  port map(I0 => S_U42, I1 => X1Y(3), Oc => C_U43, Os => Z(4));
  U5_2: full_adder
  port map(I0 => S_U51, I1 => X2Y(3), I2 => C_U43, Oc => C_U52, Os => Z(5));
  U6: full_adder
  port map(I0 => C_U51, I1 => X3Y(3), I2 => C_U52, Oc => Z(7), Os => Z(6));   
end arc_multiplier4_array;