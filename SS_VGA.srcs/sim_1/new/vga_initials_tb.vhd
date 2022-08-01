----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.07.2022 03:47:56
-- Design Name: 
-- Module Name: vga_initials_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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

entity vga_initials_tb is
end vga_initials_tb;

architecture Behavioral of vga_initials_tb is
 
    component vga_initials is
        Port (  vidon: in std_logic;
			    hc: in std_logic_vector (9 downto 0);
			    vc: in std_logic_vector (9 downto 0);
			    M: in std_logic_vector (0 to 31);
			    sw: in std_logic_Vector (7 downto 0);
			    rom_addr4: out std_logic_vector (3 downto 0);
			    red: out std_logic_vector (2 downto 0);
			    green: out std_logic_vector (2 downto 0);
			    blue: out std_logic_vector (1 downto 0)  );
    end component;
    
    component vga_640x480 is
        Port (  clk, clr : in STD_LOGIC;
                hsync : out STD_LOGIC;
                vsync : out STD_LOGIC;
                hc : out STD_LOGIC_VECTOR(9 downto 0);
                vc : out STD_LOGIC_VECTOR(9 downto 0);
                vidon : out STD_LOGIC   );
        end component;
        
    component clkdiv is
        Port (  mclk : in  STD_LOGIC;
			    clr : in  STD_LOGIC;
				clk25 : out std_logic   );
    end component;

signal mclk : std_logic :='1';
signal clr : std_logic :='1';
signal clk25 : std_logic :='0';
signal vidon : std_logic :='0';

signal hsync : std_logic :='0';
signal vsync : std_logic :='0';
signal hc : std_logic_vector (9 downto 0) := "0000000000";
signal vc : std_logic_vector (9 downto 0) := "0000000000";

signal clk : std_logic :='0';
signal C1 : std_logic_vector (10 downto 0) := "00000000000";
signal R1 : std_logic_vector (10 downto 0) := "00000000000";

signal btn : std_logic :='0';
signal sw : std_logic_vector (7 downto 0) := "00000000";
signal M : std_logic_vector (0 to 31) := "00000000000000000000000000000000";


signal spriteon : std_logic :='0';
signal hcs : std_logic_vector(9 downto 0) := "0000000000";
signal vcs : std_logic_vector(9 downto 0) := "0000000000";

constant TbPeriod : time := 10 ns; 
signal TbClock : std_logic := '0';
signal TbSimEnded : std_logic := '0';


begin
                
uut: vga_initials
    Port map (  vidon => vidon,
                hc => hc,
                vc => vc,
                M => M,
                sw => sw    );
                
dut: vga_640x480
    Port map (  clk => clk,
                clr => clr  );
                

cut: clkdiv
    Port map (  mclk => mclk,
                clr => clr,
                clk25 => clk25);
    
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';
    mclk <= TbClock;
    
    stimulus : process
    begin
        clr <= '1';
        vidon <= '0';
        hsync <= '0';
        vsync <= '0';
        hc <= "0000000000";
        vc <= "0000000000";
        spriteon <= '0';
        
        clk <= '0';
        C1 <= "00000000000";
        R1 <= "00000000000";

        wait for 5 ns;
        clr <= '0';
        vidon <= '1';
        hsync <= '1';
        vsync <= '1';
        hc <= "0000000001";
        vc <= "0000000001";
        spriteon <= '1';
        
        clk <= '1';
        C1 <= "00000000001";
        R1 <= "00000000001";

        wait for 100 * TbPeriod;

        TbSimEnded <= '1';
        wait;
    end process;


end Behavioral;

