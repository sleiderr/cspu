library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

library work; 
use work.all;

entity decoder is
	port(
		clk : in std_logic;
		-- Fetched instruction
		INST : in std_logic_vector(15 downto 0);
		-- Opcode specific to the ALU
		ALU_OP : out std_logic_vector(3 downto 0);
		-- Does this instruction use an immediate ?
		IMM_EN : out std_logic;
		
		-- Register selectors 
		REG_SEL_A : out std_logic_vector(3 downto 0);
		REG_SEL_B : out std_logic_vector(3 downto 0);
		REG_SEL_W : out std_logic_vector(3 downto 0);
		
		-- 4-bit value of the immediate, if set by the instruction
		IMM : out std_logic_vector(3 downto 0);
		
		-- 10-bit value of the long immediate, for specific branching instructions
		LONG_IMM : out std_logic_vector(9 downto 0);
	
		-- Does this instruction requires updating the value of a RegB.
		REG_W_EN : out std_logic;
		
		-- Does this instruction requires a memory read or write.
		MEM_EN : out std_logic;
		
		-- Does this instruction requires writing to memory.
		-- This also indicates whether the ADDR input of the MMU should be taken from the value inside RegA (mem read), or inside RegB (mem write)
		-- RegB is always assigned to, so no memory read can be performed at the address contained inside RegB (with RegA != RegB)
		MEM_W_EN : out std_logic;
	
		NEXT_PC : out std_logic_vector(7 downto 0)
	);
end decoder;

architecture Behavioral of decoder is
	
	begin
		process(clk)
		begin
			if rising_edge(clk) then
				IMM_EN <= INST(15);
				REG_SEL_B <= INST(3 downto 0);
				if INST(15) = '1' then
					IMM <= INST(7 downto 4);
				else
					REG_SEL_A <= INST(7 downto 4);
				end if;
				
				-- RegA should be considered as a memory address if this bit is clear (instruction requires a memory read)
				if INST(9) = '0' then
					MEM_EN <= '1';
				end if;
				
				-- RegB should be considered as a memory address if this bit is clear (instruction requires a memory write)
				if INST(8) = '0' then
					MEM_EN <= '1';
					MEM_W_EN <= '1';
				end if;
				
				if INST(14) = '0' then
					ALU_OP <= INST(13 downto 10);
				-- Instruction does not use the ALU
				else
					-- For non-ALU instructions, immediates are always long immediates (used to branch to specific immediate addresses)
					if INST(15) = '1' then
						LONG_IMM <= INST(9 downto 0);
					end if;
				end if;
			end if;
		end process;

end Behavioral;
				
		