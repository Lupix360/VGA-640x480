----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:09:07 05/22/2017 
-- Design Name: 
-- Module Name:    clkdiv - Behavioral 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity clkdiv is
		Port ( 	mclk : in  STD_LOGIC;
				clr : in  STD_LOGIC;
				clk25 : out std_logic);
end clkdiv;

architecture Behavioral of clkdiv is
	signal q: std_logic_vector(1 downto 0);

begin
	process (mclk, clr)
	begin
		if (clr = '1') then
			q <= "00";
		elsif (rising_edge(mclk)) then
			q <= q+1;
		end if;
	end process;
	clk25 <= q(1);		--25 Mhz

end Behavioral;

