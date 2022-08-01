----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:44:19 05/25/2017 
-- Design Name: 
-- Module Name:    prom_initials - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity prom_initials is
	port (
			addr: in std_logic_vector (3 downto 0);
			M: out std_logic_vector (0 to 31)
			);
end prom_initials;

architecture Behavioral of prom_initials is
	type rom_array is array (NATURAL range<>) of std_logic_vector (0 to 31);
	constant rom: rom_array := (
	"01111111100100000000011111111000", --0
	"00000100000100000000010000000100", --1
	"00000100000100000000010000000010", --2
	"00000100000100000000010000000010", --3
	"00000100000100000000010000000010", --4
	"00000100000100000000010000000100", --5
	"00000100000100000000010000001000", --6
	"00000100000100000000011111110000", --7
	"00000100000100000000010000001000", --8
	"00000100000100000000010000000100", --9
	"00000100000100000000010000000010", --A
	"01000100000100000000010000000010", --B
	"01000100000100000000010000000010", --C
	"01000100000100000000010000000010", --D
	"01000100000100000000010000000010", --E
	"00111000000111111110011111111100"  --F
	);
	--Un "0" = pixel apagado
	--Un "1" = el pixel correspondiente aparecerá en la pantalla
begin
	process (addr)
	variable j: integer;
	begin
		j:= conv_integer(addr);
		M <= rom(j); --En M tenemos el dato leído de la dirección j
	end process;

end Behavioral;

