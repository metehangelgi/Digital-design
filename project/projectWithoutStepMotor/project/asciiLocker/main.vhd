----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:13:45 11/22/2019 
-- Design Name: 
-- Module Name:    main - Behavioral 
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

entity main is
port (	do_it : IN STD_LOGIC;
			clk : IN STD_LOGIC;
			binaryPasswordLeft : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
			binaryPasswordRight : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
			changePassword : IN STD_LOGIC;
			SEVSEG_DATA : OUT  STD_LOGIC_VECTOR (7 DOWNTO 0);
          SEVSEG_CONTROL : OUT  STD_LOGIC_VECTOR (7 DOWNTO 0));
end main;

architecture Behavioral of main is

COMPONENT sevseg_decoder
	PORT(
		INPUT : IN std_logic_vector(4 downto 0);          
		sevseg_numbers : OUT std_logic_vector(7 downto 0)
		);
	END COMPONENT;

COMPONENT sevseg_driver
	PORT(
		D8 : IN std_logic_vector(4 downto 0);
		D7 : IN std_logic_vector(4 downto 0);
		D6 : IN std_logic_vector(4 downto 0);
		D5 : IN std_logic_vector(4 downto 0);
		D4 : IN std_logic_vector(4 downto 0);
		D3 : IN std_logic_vector(4 downto 0);
		D2 : IN std_logic_vector(4 downto 0);
		D1 : IN std_logic_vector(4 downto 0);
		clk : IN std_logic;          
		sev_seg_number : OUT std_logic_vector(4 downto 0);
		sev_seg_leds : OUT std_logic_vector(7 downto 0)
		);
	END COMPONENT;

COMPONENT clock_generator
	PORT(
		clk : IN std_logic;
		timer_clock : out STD_LOGIC;
      Sevseg_clock : out  STD_LOGIC;
		Stepmotor_clock : out STD_LOGIC
		);
	END COMPONENT;
	
COMPONENT timer
	PORT(
		clk : IN std_logic;
		rst : IN std_logic;
		digitone : OUT std_logic_vector(4 downto 0);
		digittwo : OUT std_logic_vector(4 downto 0);
		digitthree : OUT std_logic_vector(4 downto 0)
		);
	END COMPONENT;
	
COMPONENT passwordModule
	PORT(	do_it : IN std_logic;
		binaryPasswordLeft : IN std_logic_vector(4 downto 0);
		binaryPasswordRight : IN std_logic_vector(4 downto 0);
		minute : IN std_logic_vector(4 downto 0);
		second2 : IN std_logic_vector(4 downto 0);
		second1 : IN std_logic_vector(4 downto 0);
		changePassword : IN std_logic;
		rst : OUT std_logic;
		workStep : OUT std_logic;
		led_p_l : OUT std_logic_vector(4 downto 0);
		led_p_r : OUT std_logic_vector(4 downto 0);
		informationl : OUT std_logic_vector(4 downto 0);
		informationm : OUT std_logic_vector(4 downto 0);
		informationr : OUT std_logic_vector(4 downto 0)
		);
	END COMPONENT;

SIGNAL minute : STD_LOGIC_VECTOR( 4 DOWNTO 0);
SIGNAL second1 : STD_LOGIC_VECTOR( 4 DOWNTO 0);
SIGNAL second2 : STD_LOGIC_VECTOR( 4 DOWNTO 0);
SIGNAL informationl: STD_LOGIC_VECTOR(4 DOWNTO 0);
SIGNAL informationm: STD_LOGIC_VECTOR(4 DOWNTO 0);
SIGNAL informationr: STD_LOGIC_VECTOR(4 DOWNTO 0);
SIGNAL passwordL : STD_LOGIC_VECTOR( 4 DOWNTO 0);
SIGNAL passwordR : STD_LOGIC_VECTOR( 4 DOWNTO 0);

SIGNAL wire_sevseg_data : STD_LOGIC_VECTOR(4 DOWNTO 0);
SIGNAL wire_sevseg_clock: STD_LOGIC;
SIGNAL wire_timer_clock : STD_LOGIC;
SIGNAL wire_stepMotor_clock : STD_LOGIC;
SIGNAL wire_rst : STD_LOGIC;
SIGNAL wire_workstep : STD_LOGIC;


begin

Inst_decoder: sevseg_decoder PORT MAP(
		INPUT => wire_sevseg_data,
		sevseg_numbers => SEVSEG_DATA
	);

Inst_driver: sevseg_driver PORT MAP(
		D8 => minute,
		D7 => second2,
		D6 => second1,
		D5 => informationl,
		D4 => informationm,
		D3 => informationr,
		D2 => passwordL,
		D1 => passwordR,
		clk => wire_sevseg_clock,
		sev_seg_number => wire_sevseg_data,
		sev_seg_leds => SEVSEG_CONTROL
	);
	
Inst_clock_generator: clock_generator PORT MAP(
		clk => clk,
		timer_clock => wire_timer_clock,
		Sevseg_clock => wire_sevseg_clock,
		Stepmotor_clock => wire_stepMotor_clock
	);

Inst_timer: timer PORT MAP(
		clk => wire_timer_clock,
		rst => wire_rst,
		digitone => minute,
		digittwo => second2,
		digitthree => second1 
	);

Inst_passwordModule: passwordModule PORT MAP(
		do_it => do_it,
		binaryPasswordLeft => binaryPasswordLeft,
		binaryPasswordRight => binaryPasswordRight,
		minute => minute,
		second2 => second2,
		second1 => second1,
		changePassword => changePassword,
		rst => wire_rst,
		workStep => wire_workstep,
		led_p_l => passwordL,
		led_p_r => passwordR,
		informationl => informationl,
		informationm => informationm,
		informationr => informationr
	);

end Behavioral;

