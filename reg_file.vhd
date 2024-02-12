library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

library work; 
use work.all;

-- Register file: 8 32-bits registers
-- Allows for 2 reads and a write simultaneously

entity reg_file is
	port(clk : in STD_LOGIC;
		W_EN : in STD_LOGIC;
		SEL_A: in STD_LOGIC_VECTOR(2 downto 0);
		SEL_B : in STD_LOGIC_VECTOR(2 downto 0);
		SEL_W : in STD_LOGIC_VECTOR(2 downto 0);
		DATA_IN: in STD_LOGIC_VECTOR(31 downto 0);
		DATA_OUT_A : out STD_LOGIC_VECTOR(31 downto 0);
		DATA_OUT_B : out STD_LOGIC_VECTOR(31 downto 0)
	);
end reg_file;

architecture Behavioral of reg_file is
	type reg_storage is array (0 to 7) of STD_LOGIC_VECTOR(31 downto 0);
	signal regs: reg_storage := (others => X"00000000");
begin
	process(clk)
	begin
		if rising_edge(clk) then
			DATA_OUT_A <= regs(to_integer(unsigned(SEL_A)));
			DATA_OUT_B <= regs(to_integer(unsigned(SEL_B)));
			if W_EN = '1' then
				regs(to_integer(unsigned(SEL_W))) <= DATA_IN;
			end if;
		end if;
	end process;
end Behavioral;