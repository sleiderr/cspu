library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

library work; 
use work.all;

entity ALU is
	port(
		clk : in std_logic;
		
		ALU_OP : in std_logic_vector(3 downto 0);
		DATA_A : in std_logic_vector(15 downto 0);
		DATA_B : in std_logic_vector(15 downto 0);
		IMM : in std_logic_vector(3 downto 0);
		
		RESULT : out std_logic_vector(15 downto 0);
		FLAGS : out std_logic_vector(5 downto 0);
		MUST_BRANCH : out std_logic
	);
end ALU;

architecture Behavioral of ALU is
	constant LE:  integer := 4;
	constant GE: integer := 3;
	constant OFLW: integer := 2;
	constant CF: integer := 1;
	constant ZF:  integer := 0;

	signal s_reg_flags : std_logic_vector(5 downto 0);
	signal s_result : std_logic_vector(15 downto 0);
	signal s_must_branch : std_logic := '0';
	begin
		process(clk)
			begin
			
			if rising_edge(clk) then
				case ALU_OP is
					when X"0000" =>
						s_result <= std_logic_vector(unsigned(DATA_A) + unsigned(DATA_B));
						s_must_branch <= '0';
					when X"0001" =>
						s_result <= DATA_A or DATA_B;
						s_must_branch <= '0';
					when X"0010" =>
					  case DATA_B(3 downto 0) is
						 when "0001" =>
							s_result <= std_logic_vector(shift_right(unsigned(DATA_A), 1));
						 when "0010" =>
							s_result <= std_logic_vector(shift_right(unsigned(DATA_A), 2));
						 when "0011" =>
							s_result <= std_logic_vector(shift_right(unsigned(DATA_A), 3));
						 when "0100" =>
							s_result <= std_logic_vector(shift_right(unsigned(DATA_A), 4));
						 when "0101" =>
							s_result <= std_logic_vector(shift_right(unsigned(DATA_A), 5));
						 when "0110" =>
							s_result <= std_logic_vector(shift_right(unsigned(DATA_A), 6));
						 when "0111" =>
							s_result <= std_logic_vector(shift_right(unsigned(DATA_A), 7));
						 when "1000" =>
							s_result <= std_logic_vector(shift_right(unsigned(DATA_A), 8));
						 when "1001" =>
							s_result <= std_logic_vector(shift_right(unsigned(DATA_A), 9));
						 when "1010" =>
							s_result <= std_logic_vector(shift_right(unsigned(DATA_A), 10));
						 when "1011" =>
							s_result <= std_logic_vector(shift_right(unsigned(DATA_A), 11));
						 when "1100" =>
							s_result <= std_logic_vector(shift_right(unsigned(DATA_A), 12));
						 when "1101" =>
							s_result <= std_logic_vector(shift_right(unsigned(DATA_A), 13));
						 when "1110" =>
							s_result <= std_logic_vector(shift_right(unsigned(DATA_A), 14));
						 when "1111" =>
							s_result <= std_logic_vector(shift_right(unsigned(DATA_A), 15));
						 when others =>
							s_result <= DATA_A;
					  end case;
					  	s_must_branch <= '0';
					when X"0011" =>
					  case DATA_B(3 downto 0) is
						 when "0001" =>
							s_result <= std_logic_vector(shift_left(unsigned(DATA_A), 1));
						 when "0010" =>
							s_result <= std_logic_vector(shift_left(unsigned(DATA_A), 2));
						 when "0011" =>
							s_result <= std_logic_vector(shift_left(unsigned(DATA_A), 3));
						 when "0100" =>
							s_result <= std_logic_vector(shift_left(unsigned(DATA_A), 4));
						 when "0101" =>
							s_result <= std_logic_vector(shift_left(unsigned(DATA_A), 5));
						 when "0110" =>
							s_result <= std_logic_vector(shift_left(unsigned(DATA_A), 6));
						 when "0111" =>
							s_result <= std_logic_vector(shift_left(unsigned(DATA_A), 7));
						 when "1000" =>
							s_result <= std_logic_vector(shift_left(unsigned(DATA_A), 8));
						 when "1001" =>
							s_result <= std_logic_vector(shift_left(unsigned(DATA_A), 9));
						 when "1010" =>
							s_result <= std_logic_vector(shift_left(unsigned(DATA_A), 10));
						 when "1011" =>
							s_result <= std_logic_vector(shift_left(unsigned(DATA_A), 11));
						 when "1100" =>
							s_result <= std_logic_vector(shift_left(unsigned(DATA_A), 12));
						 when "1101" =>
							s_result <= std_logic_vector(shift_left(unsigned(DATA_A), 13));
						 when "1110" =>
							s_result <= std_logic_vector(shift_left(unsigned(DATA_A), 14));
						 when "1111" =>
							s_result <= std_logic_vector(shift_left(unsigned(DATA_A), 15));
						 when others =>
							s_result <= DATA_A;
					  end case;
					  	s_must_branch <= '0';
					when X"0100" =>
						s_result <= DATA_A xor DATA_B;
						s_must_branch <= '0';
					when X"0101" =>
						s_result <= DATA_A and DATA_B;
						s_must_branch <= '0';
					when X"0110" =>
						s_result <= std_logic_vector(unsigned(DATA_A) - unsigned(DATA_B));
						s_must_branch <= '0';
					when X"1000" =>
						s_result <= not DATA_A;
						s_must_branch <= '0';
					when X"1001" =>
						if DATA_A = DATA_B then
							 s_reg_flags(ZF) <= '1';
						else
							 s_reg_flags(ZF) <= '0';
						end if;
						if unsigned(DATA_A) < unsigned(DATA_B) then
								s_reg_flags(GE) <= '1';
								s_reg_flags(LE) <= '0';
						elsif unsigned(DATA_A) > unsigned(DATA_B) then
							s_reg_flags(LE) <= '1';
							s_reg_flags(GE) <= '0';
						end if;
				end case;
				
				if s_result = x"0000" then
					s_reg_flags(ZF) <= '1';
				end if;
				
				RESULT <= s_result;
				FLAGS <= s_reg_flags;
			end if;
		end process;
end Behavioral;