library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

library work; 
use work.all;

entity rom is
	port(
		clk : in STD_LOGIC;
		ADDR : in std_logic_vector(15 downto 0);
		DATA_OUT : out std_logic_vector(15 downto 0)
	);
end rom;

architecture Behavioral of rom is
	type mem_storage is array (0 to 1024) of std_logic_vector(15 downto 0);
	signal rom_store: mem_storage := (others => x"0000");

	begin
		process(clk)
		begin
			if rising_edge(clk) then
					DATA_OUT <= rom_store(to_integer(unsigned(ADDR(9 downto 0))));
			end if;
		end process;
		
end Behavioral;