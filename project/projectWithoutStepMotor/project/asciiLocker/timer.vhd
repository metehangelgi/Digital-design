----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:33:58 11/21/2019 
-- Design Name: 
-- Module Name:    timer - Behavioral 
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

entity timer is

Port (clk: IN std_logic;
		rst : IN std_logic;
	-- 3 outputs for decoder
    digitone : out std_logic_vector(4 downto 0) ;
    digittwo : out std_logic_vector(4 downto 0);
    digitthree : out std_logic_vector(4 downto 0));
end timer;

architecture Behavioral of timer is

--cronometer
 SIGNAL s1 : STD_LOGIC_VECTOR(4 DOWNTO 0) := "00000";
 SIGNAL s2 : STD_LOGIC_VECTOR(4 DOWNTO 0) := "00000";
 SIGNAL m : STD_LOGIC_VECTOR(4 DOWNTO 0) := "00001";
 
--showing on sevSeg(4 left-most-bit leds) 
 SIGNAL r1 : STD_LOGIC_VECTOR(4 DOWNTO 0) := "00000";
 SIGNAL r2 : STD_LOGIC_VECTOR(4 DOWNTO 0) := "00000";
 SIGNAL r3 : STD_LOGIC_VECTOR(4 DOWNTO 0) := "00000";
begin


countback_process : PROCESS(clk, rst,m,s1,s2)

begin

if(rising_edge(clk))then
	if (s1="00000") and (s2="00000") and (m="00000") then
		s1<="00000";
		s2<="00000";
		m<="00000";
	else
		if(s1 < "01011") then
				s1 <= s1 - 1;
				if(s1 = "00000") then
					s1<="01001";
					s2 <= s2 - 1;
					if(s2 = "00000") then
						m <= m - 1;
						s2 <= "00101";
					end if;
				end if;
			end if;
		end if;
	
		if (rst = '1') THEN
			m<="00001";
			s2<="00000";
			s1<="00000";
		end if;
end if;

 r1<=m;
 r2<=s2;
 r3<=s1;

end process;

  digitone <=r1;
  digittwo <=r2 ;
  digitthree <=r3;
end Behavioral;

