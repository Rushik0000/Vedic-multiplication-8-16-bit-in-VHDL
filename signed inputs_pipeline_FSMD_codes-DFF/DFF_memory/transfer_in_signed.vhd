-----------------------------------------------------------------------
-- Library Name : Inputs typecasting
-- Unit Name : transfer_in_signed
-----------------------------------------------------------------------
-- Date : Nov. 23, 2022
-- Designer : Yijun Li
-- Description : Typecasting for A B 
-- from signed to std_logic_vector
-- if one of A and B is negtive, give 1 to Z_neg
-- change the negtive value to postive value (get absolute value)
-----------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity transfer_in_signed is 
	port(
		A_s : in integer;
		B_s : in integer;
		A_pos_std : out std_logic_vector(7 downto 0);
		B_pos_std : out std_logic_vector(7 downto 0);
		neg_Z : out std_logic);
-- if Z should be negative (one of A and B is negative), neg_Z=1
end transfer_in_signed;

architecture arc_transfer_in_signed of transfer_in_signed is

component decre_8bits_nonc is 
port( Z : in std_logic_vector(7 downto 0);       
      --Input the previous value of Z 8bits
      Z_dec : out std_logic_vector(7 downto 0)); 
	  --output (8 bits) after -1
end component;

signal ju_A,ju_B : std_logic;
	-- memory for A,B is negative or not
signal A_std, B_std : std_logic_vector(7 downto 0);      
    -- temporary value after typecasting of A B
signal A_dec, B_dec : std_logic_vector(7 downto 0);      
    -- temporary value after decrementor (-1) of negative A B
signal A_std_neg, B_std_neg :std_logic_vector(7 downto 0);
    -- negative binary data of A B(original data from computer:not&+1) 
begin

ju_A <= '0' when A_s<0 else
        '1';                             -- record A is negative
ju_B <= '0'when B_s<0 else
        '1';                             -- record B is negative
neg_Z <= ju_A xor ju_B;   
-- if one of A and B is negative, Z is negative->neg_Z=1	

-- typecasting A B		
A_std <=  std_logic_vector(to_signed(A_s,8));
B_std <=  std_logic_vector(to_signed(B_s,8));

-- decrementor (-1) for the negative A B
decrementor_A: decre_8bits_nonc port map(Z => A_std, Z_dec => A_dec);
decrementor_B: decre_8bits_nonc port map(Z => B_std, Z_dec => B_dec);

-- inverter (not value)
A_std_neg <= not A_dec;
B_std_neg <= not B_dec;

--output absolute value of A B
A_pos_std <= A_std_neg when A_s<0 else
             A_std;
B_pos_std <= B_std_neg when B_s<0 else
             B_std;

end arc_transfer_in_signed;	