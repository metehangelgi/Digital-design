----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:29:35 11/21/2019 
-- Design Name: 
-- Module Name:    sevseg_decoder - Behavioral 
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

entity sevseg_decoder is
PORT ( INPUT : IN STD_LOGIC_VECTOR (4 DOWNTO 0);
           sevseg_numbers : OUT  STD_LOGIC_VECTOR (7 DOWNTO 0));
end sevseg_decoder;

architecture Behavioral of sevseg_decoder is

begin
--harfler olusturulacak ascii code için 
WITH INPUT SELECT sevseg_numbers <=
	"00000011" when "00000", --0
	"10011111" when "00001", --1
	"00100101" when "00010", --2
	"00001101" when "00011", --3
	"10011001" when "00100", --4
	"01001001" when "00101", --5
	"01000001" when "00110", --6
	"00011111" when "00111", --7
	"00000001" when "01000", --8
	"00001001" when "01001", --9
	"00010001" when "01010", --A
	"11000001" when "01011", --B
	"11100101" when "01100", --c
	"10000101" when "01101", --d
	"01100001" when "01110", --E
	"01110001" when "01111", --F
	"01000011" when "10000", --G
	"10010001" when "10001", --H
	"11110011" when "10010", --I
	"10001111" when "10011", --J
	"11100011" when "10100", --L
	"01100001" when "10101", --m
	"11010101" when "10110", --n
	"11000101" when "10111", --o
	"00110001" when "11000", --P
	"11110101" when "11001", --r
	"11100001" when "11010", --t
	"10000011" when "11011", --U
	"10001001" when "11100", --y
	"00011001" when "11101", --q
	"11111110" when "11110", -- .
	"11111101" when "11111", -- -
	
	
	

	"00001001" WHEN OTHERS;

end Behavioral;

