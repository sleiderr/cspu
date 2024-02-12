library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

library work; 
use work.all;

entity ram is
	port(
		clk : in STD_LOGIC;
		W_EN : in STD_LOGIC;
		ADDR : in std_logic_vector(15 downto 0);
		DATA_IN : in std_logic_vector(15 downto 0);
		DATA_OUT : out std_logic_vector(15 downto 0)
	);
end ram;

architecture Behavioral of ram is
	type mem_storage is array (0 to 1024) of std_logic_vector(15 downto 0);
	signal ram_store: mem_storage := (others => x"0000");

	begin
		process(clk)
		begin
			if rising_edge(clk) then
				if W_EN = '1' then
					ram_store(to_integer(unsigned(ADDR(9 downto 0)))) <= DATA_IN;
				else
					DATA_OUT <= ram_store(to_integer(unsigned(ADDR(9 downto 0))));
				end if;
			end if;
		end process;
		
end Behavioral;