----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:28:29 05/26/2017 
-- Design Name: 
-- Module Name:    vga_initials_top - Behavioral 
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

entity vga_initials_top is
	Port ( mclk : in  STD_LOGIC;
           btn : in  STD_LOGIC;
           sw : in  STD_LOGIC_VECTOR (7 downto 0);
           hsync : out  STD_LOGIC;
           vsync : out  STD_LOGIC;
           red : out  STD_LOGIC_VECTOR (2 downto 0);
           green : out  STD_LOGIC_VECTOR (2 downto 0);
           blue : out  STD_LOGIC_VECTOR (1 downto 0));
end vga_initials_top;

architecture Behavioral of vga_initials_top is
	signal clr, clk25, vidon: std_logic;
	signal hc,vc: std_logic_vector(9 downto 0);
	signal M: std_logic_vector (0 to 31);
	signal rom_addr4: std_logic_vector (3 downto 0);
begin 
	clr <= btn;

	Inst_clkdiv: entity work.clkdiv PORT MAP(
		mclk => mclk,
		clr => clr,
		clk25 => clk25
	);

	Inst_vga_640x480: entity work.vga_640x480 PORT MAP(
		clk => clk25,
		clr => clr,
		hsync => hsync,
		vsync => vsync,
		hc => hc,
		vc => vc,
		vidon => vidon 
	);
	
	Inst_vga_initials: entity work.vga_initials PORT MAP(
		vidon => vidon,
		hc => hc,
		vc => vc,
		M => M,
		sw => sw,
		rom_addr4 => rom_addr4,
		red => red,
		green => green,
		blue => blue
	);

	Inst_prom_initials: entity work.prom_initials PORT MAP(
		addr => rom_addr4,
		M => M
	);
	
end Behavioral;

