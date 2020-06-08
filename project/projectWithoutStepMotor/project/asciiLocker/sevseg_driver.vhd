----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:27:48 11/21/2019 
-- Design Name: 
-- Module Name:    sevseg_driver - Behavioral 
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
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
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

entity sevseg_driver is
PORT ( D8: IN  STD_LOGIC_VECTOR (4 DOWNTO 0);
           D7 : IN  STD_LOGIC_vector (4 DOWNTO 0);
			  D6 : IN  STD_LOGIC_VECTOR (4 DOWNTO 0);
			  D5 : IN  STD_LOGIC_VECTOR (4 DOWNTO 0);
			  D4 : IN  STD_LOGIC_VECTOR (4 DOWNTO 0);
			  D3 : IN  STD_LOGIC_VECTOR (4 DOWNTO 0);
			  D2 : IN  STD_LOGIC_VECTOR (4 DOWNTO 0);
			  D1  : IN  STD_LOGIC_VECTOR (4 DOWNTO 0);
           clk : IN  STD_LOGIC;
			  sev_seg_number : OUT  STD_LOGIC_VECTOR (4 DOWNTO 0);
           sev_seg_leds : OUT  STD_LOGIC_VECTOR (7 DOWNTO 0)
			  );
end sevseg_driver;

architecture Behavioral of sevseg_driver is
SIGNAL COUNTER : STD_LOGIC_VECTOR(2 DOWNTO 0) := "000";

begin

---mods

--INCREMENT COUNTER
process_clk : PROCESS(clk)
BEGIN
	IF(clk'EVENT AND clk = '1') THEN
			COUNTER <= COUNTER + 1;
			IF(COUNTER = "111" )THEN
			 COUNTER <= "000";
			END IF;
	END IF;
END PROCESS;

-- SEV_SEG DATA
WITH COUNTER SELECT sev_seg_number <=

	D8 WHEN "000",
	D7 WHEN "001",
	D6 WHEN "010",
	D5 WHEN "011",
	D4 WHEN "100",
	D3 WHEN "101",
	D2 WHEN "110",
	D1 WHEN "111",
	"01001" WHEN OTHERS; 
--DATA END

--SEV_SEG_CONTROLLER
WITH COUNTER SELECT sev_seg_leds <=
"01111111" WHEN "000", 
"10111111" WHEN "001", 
"11011111" WHEN "010", 
"11101111" WHEN "011", 
"11110111" WHEN "100", 
"11111011" WHEN "101",
"11111101" WHEN "110",
"11111110" WHEN "111",
"00001111" WHEN OTHERS;
--SEV_SEG CONTROLLER END

end Behavioral;

