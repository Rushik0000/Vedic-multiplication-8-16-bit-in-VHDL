-----------------------------------------------------------------------
-- Library Name : pipeline of multiply accumulate & register5
-- Unit Name : acc_mul_reg5
-----------------------------------------------------------------------
-- Date : Dec. 6, 2022
-- Designer : Yijun Li
-- Description : combination two parts ( acc_mul & register5)
-- accumulation of each caculation result
-- sum of Z1, Z2, Z3, Z4..Z10
-- 1.obtain the values of Z from rounding-off
-- when the current state is [rounding_off]
-- 2.store the previous value with DFF
-- when the surrent state is [acc_mul]
-- then plus the previous value of Z
-- accumulation of each caculation result
-- sum of Z1, Z2, Z3, Z4..Z10
-----------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity acc_mul_reg5 is 
	port(
		Z_acc_d : in std_logic_vector(15 downto 0);
		Zc_acc : in std_logic;
		st: in std_logic_vector(13 downto 0);
		-- st is the value of state_reg, current state
		Z_r5 : out std_logic_vector(19 downto 0));
		-- 16 bits Z1 + Z2 ->10 times (FF*FF=FE01)*10=9EC0A (20 bits)
end acc_mul_reg5;

architecture arc_acc_mul_reg5 of acc_mul_reg5 is 

component half_adder_16bit is 
port (
      a,b: in std_logic_vector(15 downto 0);
      cout: out std_logic;
      sum: out std_logic_vector(15 downto 0));
end component;

component half_adder_4bit is 
port (
      a,b: in std_logic_vector(3 downto 0);
      cout: out std_logic;
      sum: out std_logic_vector(3 downto 0));
end component;

-- innitialized of values of Q
-- DFF: when current state is rounding_off
signal Z_acc_q : std_logic_vector(15 downto 0) := (others=>'0');
-- DFF: when current state is acc_mul
-- 16 bits half adder : sum
signal Z_next : std_logic_vector(15 downto 0);
signal Z_reg : std_logic_vector(15 downto 0) := (others=>'0');
-- 4 bits adder : sum 
signal Zcs_next : std_logic_vector(3 downto 0);
signal Zcs_reg : std_logic_vector(3 downto 0):= (others=>'0');
-- 16 bits half adder : carry
-- 1 bit -> 4 bits : 000 & C
-- concatenation
signal Zc_1bit : std_logic;
signal Zc_4bits : std_logic_vector(3 downto 0);
-- Zc_acc always be 0-> Zc_acc=Zc1
-- cout form half_adder_4bit always be 0->cout=Zc2
signal Zc1, Zc2 : std_logic;

begin
-- register Z
	-- DFF 1 D-Flip-Flop
	process(st)
	begin
	    if rising_edge(st(9)) then
	    -- st(9) = signal of state : rounding_off
		   Z_acc_q <= Z_acc_d;   --q_z<=d_z
		end if;
	end process;
	-- output logic
	Zc1 <= Zc_acc;

-- acc_mul part 
    -- next-state logic of DFF 2 
    unit_16bits_adder: half_adder_16bit
    port map(a => Z_reg, b => Z_acc_q, sum => Z_next, cout => Zc_1bit);
    -- concatenation
    Zc_4bits <= "000" & Zc_1bit;
    unit_4bits_adder: half_adder_4bit
    port map(a => Zcs_reg, b => Zc_4bits, sum => Zcs_next, cout => Zc2);
-- registers of Z sum(16bits) and carry(4bits)
-- DFF 2 D-Flip-Flop
	process(st)
	begin
	    if rising_edge(st(10)) then
	    -- st(10) = signal of state : acc_mul
		   Z_reg <= Z_next;     --q_sum<=d_sum
		   Zcs_reg <= Zcs_next; --q_carry<=d_carry
		end if;
	end process;
	-- output logic
	-- concatenation C(3 downto 0) & Z(15 downto 0)
	Z_r5 <= Zcs_reg & Z_reg;

end arc_acc_mul_reg5;