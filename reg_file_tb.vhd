LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

library work; 
use work.all;

USE ieee.numeric_std.ALL;

ENTITY reg_file_tb IS
END reg_file_tb;

ARCHITECTURE behavior OF reg_file_tb IS 


    COMPONENT reg_file
    PORT(
		clk : in STD_LOGIC;
		W_EN : in STD_LOGIC;
		SEL_A: in STD_LOGIC_VECTOR(2 downto 0);
		SEL_B : in STD_LOGIC_VECTOR(2 downto 0);
		SEL_W : in STD_LOGIC_VECTOR(2 downto 0);
		DATA_IN: in STD_LOGIC_VECTOR(31 downto 0);
		DATA_OUT_A : out STD_LOGIC_VECTOR(31 downto 0);
		DATA_OUT_B : out STD_LOGIC_VECTOR(31 downto 0)
        );
    END COMPONENT;

   signal clk : std_logic := '0';
   signal DATA_IN : std_logic_vector(31 downto 0) := (others => '0');
   signal SEL_A : std_logic_vector(2 downto 0) := (others => '0');
   signal SEL_B : std_logic_vector(2 downto 0) := (others => '0');
   signal SEL_W : std_logic_vector(2 downto 0) := (others => '0');
   signal W_EN : std_logic := '0';

   signal DATA_OUT_A : std_logic_vector(31 downto 0);
   signal DATA_OUT_B : std_logic_vector(31 downto 0);

   constant clk_period : time := 10 ns;

BEGIN

   uut: reg_file PORT MAP (
          clk => clk,
          DATA_IN => DATA_IN,
          DATA_OUT_A => DATA_OUT_A,
          DATA_OUT_B => DATA_OUT_B,
          SEL_A => SEL_A,
          SEL_B => SEL_B,
          SEL_W => SEL_W,
          W_EN => W_EN
        );

   clk_process :process
   begin
    clk <= '0';
    wait for clk_period / 2;
    clk <= '1';
    wait for clk_period / 2;
   end process;

   stim_proc: process
   begin	

      wait for clk_period*10;

    SEL_A <= "000";
    SEL_B <= "001";
    SEL_W <= "000";
    DATA_IN <= X"00000002";
    W_EN <= '1';
      wait for clk_period;
		
    SEL_A <= "000";
    SEL_B <= "001";
    SEL_W <= "010";
    DATA_IN <= X"00000001";
    W_EN <= '1';
      wait for clk_period;

    SEL_A <= "000";
    SEL_B <= "001";
    SEL_W <= "010";
    DATA_IN <= X"00000003";
    W_EN <= '1';
      wait for clk_period;

    SEL_A <= "000";
    SEL_B <= "001";
    SEL_W <= "000";
    DATA_IN <= X"10000000";
    W_EN <= '0';
      wait for clk_period;


    SEL_A <= "001";
    SEL_B <= "010";
      wait for clk_period;

    SEL_A <= "011";
    SEL_B <= "100";
      wait for clk_period;

    SEL_A <= "000";
    SEL_B <= "001";
    SEL_W <= "100";
    DATA_IN <= X"00000004";
    W_EN <= '1';
      wait for clk_period;

    W_EN <= '0';
      wait for clk_period;

      wait for clk_period;

    SEL_A <= "100";
    SEL_B <= "100";
      wait for clk_period;

      wait;
   end process;

END;