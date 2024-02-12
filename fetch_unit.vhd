library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

library work; 
use work.all;

entity fetch_unit is
	port(
		clk : in std_logic;
		NEW_PC : in std_logic_vector(15 downto 0);
		FETCH_INSTR : in std_logic_vector(1 downto 0);
		
		NEXT_INSTR : out std_logic_vector(15 downto 0);
	);
end fetch_unit;

architecture Behavioral of fetch_unit is
	signal PC : std_logic_vector(15 downto 0) := x"0000";
	
	begin
		process(clk)
		begin
			if rising_edge(clk)
				-- Update the program counter accordingly to the instruction given to the fetch unit
				case FETCH_INSTR is
					when X"00" =>
					when X"01" =>
						-- We use 16-bits words, hence the +2 (for byte addressing);
						PC <= std_logic_vector(unsigned(PC) + 2);
					when X"10" =>
						PC <= NEW_PC;
					when X"11" =>
						PC <= X"0000";
				end case;
			end if;
		end process;
end Behavioral;
			

			