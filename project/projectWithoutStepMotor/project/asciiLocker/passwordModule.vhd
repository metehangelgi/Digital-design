----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:26:16 11/23/2019 
-- Design Name: 
-- Module Name:    passwordModule - Behavioral 
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

entity passwordModule is
	port ( 			
			do_it : IN STD_LOGIC;
			binaryPasswordLeft : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
			binaryPasswordRight : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
			minute: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
			second2: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
			second1: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
			changePassword : IN STD_LOGIC;
			rst : OUT STD_LOGIC;
			workStep: OUT STD_LOGIC := '0';
			led_p_l: OUT STD_LOGIC_VECTOR(4 downto 0);
			led_p_r: OUT STD_LOGIC_VECTOR(4 downto 0);
			informationl: OUT STD_LOGIC_VECTOR (4 DOWNTO 0);
			informationm: OUT STD_LOGIC_VECTOR (4 DOWNTO 0);
			informationr: OUT STD_LOGIC_VECTOR (4 DOWNTO 0)
			);
end passwordModule;
		
architecture Behavioral of passwordModule is


type state is(locked,unlocked,change);
signal  ps_state : state := unlocked;
signal currentPasswordLeft : std_logic_vector(4 downto 0) := "01010";
signal currentPasswordRight : std_logic_vector(4 downto 0):= "01010";
signal counter : integer := 3;
signal pukCodeLeft : std_logic_vector(4 downto 0) := "10101";
signal pukCodeRight : std_logic_vector(4 downto 0) := "11101";
signal pre_informationl : STD_LOGIC_VECTOR (4 DOWNTO 0) := "11111";
signal pre_informationm : STD_LOGIC_VECTOR (4 DOWNTO 0) := "11111";
signal pre_informationr : STD_LOGIC_VECTOR (4 DOWNTO 0) := "11111";
signal pre_rst : STD_LOGIC := '0';
begin

testprocess : process(binaryPasswordLeft,binaryPasswordRight,do_it,changepassword,minute,second1,second2)

begin


	if(rising_edge(do_it)) then
		if (counter > 0) and (not((minute = "00000") and (second1 = "00000") and (second2 = "00000"))) then
			case ps_state is 
				when unlocked =>  if (binaryPasswordLeft = currentPasswordLeft) and (binaryPasswordRight = currentPasswordRight) then
											if (changePassword = '1') then
												ps_state <= change;
												workStep <= '0';
												pre_informationl <= "01100"; --c
												pre_informationm <= "10001"; --h
												pre_informationr <= "10110"; --n
											else
												ps_state <= locked;
												workStep <= '1';
												pre_informationl <= "10111"; -- o
												pre_informationm <= "01111"; --f
												pre_informationr <= "01111"; --f
											end if;
											pre_rst <= '1';
											counter<=3;
										else
											workStep <= '0';
											ps_state <= unlocked;
											counter <= counter - 1 ;
											
											if (counter = 1) then
											pre_informationl <= "00001"; -- 1
											elsif (counter = 2) then
											pre_informationl <= "00010"; -- 2
											else
											pre_informationl <= "00011"; -- 3
											end if;
											pre_informationm <= "10110"; --n
											pre_informationr <= "10111"; --o
											pre_rst <= '0';
										end if;
				when locked => if (binaryPasswordLeft = currentPasswordLeft) and (binaryPasswordRight = currentPasswordRight) then
											workStep <= '1';
											ps_state <= unlocked;
											pre_informationl <= "10111"; --o
											pre_informationm <= "11000"; --p
											pre_informationr <= "10110"; --n
											pre_rst <= '1';
											counter<=3;
										else
											workStep <= '0';
											ps_state <= locked;
											counter <= counter - 1 ;
											
											if (counter = 1) then
											pre_informationl <= "00001"; -- 1
											elsif (counter = 2) then
											pre_informationl <= "00010"; -- 2
											else
											pre_informationl <= "00011"; -- 3
											end if;
											pre_informationm <= "10110"; --n
											pre_informationr <= "10111"; --o
											pre_rst <= '0';
										end if;
				when change => if (changePassword = '1') then
											workStep <= '0';
											ps_state <= unlocked;
											pre_informationl <= "10111"; --o
											pre_informationm <= "11000"; --p
											pre_informationr <= "10110"; --n
											pre_rst <= '1';
											counter<=3;
											currentPasswordLeft <= binaryPasswordLeft;
											currentPasswordRight <= binaryPasswordRight;
										else
											workStep <= '0';
											ps_state <= locked;
											pre_informationl <= "10111"; -- o
											pre_informationm <= "01111"; --f
											pre_informationr <= "01111"; --f
											pre_rst <= '1';
											counter<=3;
										end if;
				when others => workStep <= '0';
			end case;

		else
			pre_informationl <= "11111";
			pre_informationm <= "11111";
			pre_informationr <= "11111";
			if (binaryPasswordLeft = pukCodeLeft) and (binaryPasswordRight = pukCodeRight) then
				counter <= 3;
				pre_rst <= '1';
			else 
				counter <= 0;
				pre_rst <= '1';
			end if;
		end if;
	end if;
	
if (minute = "00000") and (second1 = "00000") and (second2 = "00000") then 
	pre_informationl <= "11111";
	pre_informationm <= "11111";
	pre_informationr <= "11111";
end if;
end process;			
			
				
led_p_l <=binaryPasswordLeft;
led_p_r <=binaryPasswordRight;
informationl <= pre_informationl;
informationm <= pre_informationm;
informationr <= pre_informationr;
rst <= pre_rst;	

end Behavioral;

