----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:20:40 11/19/2019 
-- Design Name: 
-- Module Name:    stepDriver - Behavioral 
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
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity stepDriver is
port ( step_clk : IN STD_LOGIC;
			do_it : IN STD_LOGIC; --active when press button for 1 second?
			password : IN std_logic_vector(3 downto 0);
			W: OUT STD_LOGIC_VECTOR(3 downto 0));
end stepDriver;

architecture Behavioral of stepDriver is


type state is(s0,s1,s2,s3);
signal  ps_state, nx_state : state;
signal currentPassword : std_logic_vector(3 downto 0) := "0101";
signal  motor : std_logic_vector(3 downto 0);
signal counters : integer :=0; --initial to step 
signal current_Lock : integer :=1; --unlocked mode

begin




LetLock : process (step_clk,do_it)
begin

if rising_edge(step_clk)  then --equals 150 celcius(7.5 celcius each step)
	if (counters < 80) then
		ps_state <= nx_state;
		counters <= counters + 1;
		current_Lock <= current_Lock;
	elsif (do_it = '1') then 
		ps_state <= nx_state;
		counters <= 1;
		current_Lock <= current_Lock + 1;
		if (current_Lock > 1) then
			current_Lock <= 0; --current_Locked mode
		end if;
	end if;
end if;

end process;


LockingProcess : process (ps_state,currentPassword,password,current_Lock)
begin

case ps_state is 
when s0 => if (not (password= currentPassword)) then nx_state <= s0;
				elsif (current_Lock = 0 and password = currentPassword) then nx_state <= s1;
				elsif (current_Lock = 1 and password = currentPassword) then nx_state <= s3;
				end if;
when s1 => if (not (password= currentPassword)) then nx_state <= s1;
				elsif (current_Lock = 0 and password = currentPassword) then nx_state <= s2;
				elsif (current_Lock = 1 and password = currentPassword) then nx_state <= s0;
				end if;
when s2 => if (not (password= currentPassword)) then nx_state <= s2;
				elsif (current_Lock = 0 and password = currentPassword) then nx_state <= s3;
				elsif (current_Lock = 1 and password = currentPassword) then nx_state <= s1;
				end if;
when s3 => if (not (password= currentPassword)) then nx_state <= s3;
				elsif (current_Lock = 0 and password = currentPassword) then nx_state <= s0;
				elsif (current_Lock = 1 and password = currentPassword) then nx_state <= s2;
				end if;
when others => nx_state <= s0;
end case;

case ps_state is
	when s0 => motor <= "1100";
	when s1 => motor <= "0110";
	when s2 => motor <= "0011";
	when s3 => motor <= "1001";
end case;

end process;

W <= motor;

end Behavioral;

