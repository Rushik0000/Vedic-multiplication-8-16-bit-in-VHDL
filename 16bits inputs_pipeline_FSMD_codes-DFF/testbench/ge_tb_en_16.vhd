------------------------------------------------------------
-- Library Name : testbench for clock,load,clear generator
-- Unit Name : ge_tb_en_16
------------------------------------------------------------
-- Date : Nov. 21, 2022
-- Designer : Yijun Li & Ning Lin
-- Description : generate enable for testbench
-- include : A,B (8bits); clear(rst);clock(clk);load(en)
-- clk frequency : 50MHz -> 20ns
-- 10 times tests
------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
-- testbench generator for clock,reset,enable
-- 8 bit register with enable;
entity ge_tb_en_16 is
port(clk: out std_logic;
    rst: out std_logic;
    en: out std_logic);
end ge_tb_en_16;

architecture arc_ge_tb_en_16 of ge_tb_en_16 is
signal clk_tem : std_logic := '0';
-- output can not be in right side of statement
-- clk_tem equals to clk
begin 
  -- first : generator of clock
  clk_tem <= not clk_tem after 20ns;
  clk <= clk_tem;
  -- 50MHz clock
  
  -- second : process generator of reset
  rst_generator:
  process
  begin
   for i in 1 to 10 loop 
   rst <= '0';
   wait for 10ns;
   rst <= '1';
   wait for 40ns;
   rst <= '0';
   -- reset '0'--10ns-->'1'--40ns-->'0'
   wait for 310ns;
   -- 360-10-40=360-50=310
   end loop;
   end process;
   
   -- third : process generator of load
  en_generator:
  process
   begin
   for j in 1 to 10 loop
   en <= '0';
   wait for 50ns;
   en <= '1';
   wait for 30ns;
   en <= '0';
   -- en '0'--50ns-->'1'--30ns-->'0'
   wait for 280ns;
   -- 360-50-30=360-80=280
   end loop;
   end process;
end arc_ge_tb_en_16;
		