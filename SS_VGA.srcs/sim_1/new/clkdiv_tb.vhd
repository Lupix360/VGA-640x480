----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.07.2022 18:57:13
-- Design Name: 
-- Module Name: clkdiv_tb - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity clkdiv_tb is
end clkdiv_tb;

architecture tb of clkdiv_tb is

    component clkdiv
        port (mclk  : in std_logic;
              clr   : in std_logic;
              clk25 : out std_logic);
    end component;

    signal mclk  : std_logic;
    signal clr   : std_logic;
    signal clk25 : std_logic;

    constant TbPeriod : time := 10 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : clkdiv
    port map (mclk  => mclk,
              clr   => clr,
              clk25 => clk25);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that mclk is really your main clock signal
    mclk <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        mclk <= '1';
        -- Reset generation
        -- EDIT: Check that clr is really your reset signal
        clr <= '1';
        wait for 100 ns;
        clr <= '0';
        wait for 100 ns;

        -- EDIT Add stimuli here
        wait for 100 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

