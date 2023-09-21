------------------------------------------------------
-- Library Name : negative 8bit data decrementer & not
-- Unit Name : neg_8_decre_not
------------------------------------------------------
-- Date : Nov. 15, 2022
-- Designer : Yijun Li
-- Description : 8bit decrementer (-1) and not (abs)
-- change the negative binary data into positive data
-- or keep the positive binary data
------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity neg_8_decre_not is 
port( A_pre, B_pre : in integer;       
      --Input the previous value of A B
	  neg_Z : out std_logic;
	  --memory for Z is negative or not
      A_pos, B_pos : out std_logic_vector(7 downto 0)); 
	  --output (8 bits) after changing and typecasting
end neg_8_decre_not;

architecture arc_neg_8_decrenot of neg_8_decre_not is
signal ju_A,ju_B : std_logic;
	  --memory for A,B is negative or not
signal A_no, B_no :std_logic_vector(7 downto 0);
    -- negative binary data of A B(original data from computer:not&+1) 
signal a_new, b_new : std_logic_vector(7 downto 0);      
    -- temporary value of A_pos B_pos (will immediately change inside process)
begin
process(A_pre,B_pre,ju_A,ju_B,A_no,B_no,a_new,b_new)

variable c_a,c_b : std_logic;
-- Differential half_subtractor, A-1
begin
-- unit of subtractor
-- a-b: a=0,b=0->carry=0,sub=0;"01"->c=1,s=1;"10"->c=0,s=1;"11"->c=0,s=0
  if A_pre < 0 then
    ju_A <= '0';                             -- record A is negative
    A_no <=  std_logic_vector(to_signed(A_pre,8));
    a_new(0) <= A_no(0) xor '1';   
    c_a := (not A_no(0)) and '1';
	for i in 1 to 7 loop
	  a_new(i) <= A_no(i) xor c_a;           -- subtractor of half_subtractor
    c_a := (not A_no(i)) and c_a;            -- borrow of half_subtractor
	end loop;
	-- first minus 1,(-1)
	-- end the unit of subtractor
	A_pos <= not a_new;
	-- second not
  else
  ju_A <= '1';                               -- record A is positive
	A_pos <= std_logic_vector(to_signed(A_pre,8));
  end if;
  
  if B_pre < 0 then
    ju_B <= '0';                             -- record B is negative
    B_no <=  std_logic_vector(to_signed(B_pre,8));
    b_new(0) <= B_no(0) xor '1';
    c_b := (not B_no(0)) and '1';
	for j in 1 to 7 loop
	  b_new(j) <= B_no(j) xor c_b;           -- subtractor of half_subtractor
    c_b := (not B_no(j)) and c_b;            -- borrow of half_subtractor
	end loop;
	-- first -1
	B_pos <= not b_new;
	-- second not
  else
  ju_B <= '1';                                -- record B is positive
	B_pos <= std_logic_vector(to_signed(B_pre,8));
  end if; 
  neg_Z <= ju_A xor ju_B;   -- if one of A and B is negative, Z is negative->neg_Z=1
  end process;

end arc_neg_8_decrenot;