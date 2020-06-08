----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:14:47 11/21/2019 
-- Design Name: 
-- Module Name:    clock_generator - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity clock_generator is
		Port ( clk : in  STD_LOGIC;
				timer_clock : out STD_LOGIC;
           Sevseg_clock : out  STD_LOGIC;
			  Stepmotor_clock : out STD_LOGIC);
end clock_generator;

architecture Behavioral of clock_generator is




SIGNAL counter : integer := 0;
SIGNAL counters : integer := 0;
SIGNAL counters2 : integer := 0;
signal temp : std_logic := '0';
signal temps: std_logic := '0';
signal temps2: std_logic := '0';

begin

clk_process : process(clk)

begin 

if rising_edge(clk) then 
	counter <= counter + 1;
	if counter<50000 then 
	temp <= '1';
	else 
	temp <= '0';
	counter <= 0; 
	end if ;
	
	counters <= counters + 1;
	if counters < 100000000 then
	temps <= '1';
	else
	temps <= '0';
	counters <= 0;
	end if;
	
	counters2 <= counters2 + 1;
	if counters2 < 1250000 then
	temps2 <= '1';
	else
	temps2 <= '0';
	counters2 <= 0;
	end if;
	
end if;




end process;

Sevseg_clock <= temp;
timer_clock <= temps;
Stepmotor_clock <= temps2;

end Behavioral;
