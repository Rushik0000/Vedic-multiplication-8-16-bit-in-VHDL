-----------------------------------------------------------------------
-- Library Name : FSM with control path
-- Unit Name : fsm_16bits_control_path
-----------------------------------------------------------------------
-- Date : Nov. 30, 2022
-- Designer : Yijun Li
-- Description : control path of FSM
-- transition of different states
-- output the end_flag
-- send the state to the data path
-----------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fsm_16bits_control_path is 
	port(
	     clock : in std_logic;
	     load : in std_logic;
	     clear : in std_logic;
         state_now : out std_logic_vector(7 downto 0);
		 -- send state_reg to data path of FSM
		 end_flag : out std_logic);
end fsm_16bits_control_path;

architecture arc_fsm_16bits_control_path of fsm_16bits_control_path is 
-- encode each state (clever Moore FSM)
constant idle             : std_logic_vector(7 downto 0) := "00000000";
constant load_en          : std_logic_vector(7 downto 0) := "00000001";
constant transfer_in      : std_logic_vector(7 downto 0) := "00000010";
constant register1        : std_logic_vector(7 downto 0) := "00000100";
constant multi_div_inc    : std_logic_vector(7 downto 0) := "00001000";
constant register2        : std_logic_vector(7 downto 0) := "00010000";
constant transfer_out     : std_logic_vector(7 downto 0) := "00100000";
constant register3        : std_logic_vector(7 downto 0) := "01000000";
constant out_rsl          : std_logic_vector(7 downto 0) := "10000000";
-- define 8 states
signal state_next,state_reg : std_logic_vector(7 downto 0);

begin
-- control path
-- DFF: D Flip_Flop
process(clock,clear)
 begin
  if clear='1' then
     state_reg <= idle;
  elsif rising_edge(clock) then
     state_reg <= state_next;
  end if;
end process;

-- next-state logic ( states transition )
process(load, state_reg)
begin
-- states changes
 case state_reg is
    
	when idle =>
	  
	  -- enable state to change to load_en state
	  -- load=1 -> state_reg(0)='1'
	  -- then data path: read the value from registers of A B
	  if load ='1' then
	    state_next <= load_en;
	  else
        state_next <= idle;
      end if;
	  
	when load_en =>
	  state_next <= transfer_in;
	  
	when transfer_in =>
	  state_next <= register1;
	  
	when register1 =>
	  state_next <= multi_div_inc;
	  
	when multi_div_inc =>
	  state_next <= register2;
	  
    when register2 =>
	  state_next <= transfer_out;
	  
	when transfer_out =>
	  state_next <= register3;
	  
    when register3 =>
	  state_next <= out_rsl;
	  
	when out_rsl =>
	  state_next <= idle;
	
	when others =>
	  state_next <= idle;
	-- include all possible cases  
	  
 end case;
end process;
 
-- output logic:

-- 1.send the current state (state_reg) to the data path
   state_now <= state_reg;
   
-- 2. Mealy output the end_flag directly when current state is register3
   end_flag <= '1' when (state_reg=register3) or (state_reg=out_rsl) else
               '0';-- initialise each outputs
	
end arc_fsm_16bits_control_path;	