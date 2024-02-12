library IEEE;

use IEEE.STD_LOGIC_1164.all;

entity CPU is
	port(
		clock : in STD_LOGIC;
		rst : in STD_LOGIC
	);
end CPU;

architecture bdf_type of CPU is

component register_file
	port(
		clk : in STD_LOGIC;
		W_EN : in STD_LOGIC;
		SEL_A: in STD_LOGIC_VECTOR(2 downto 0);
		SEL_B : in STD_LOGIC_VECTOR(2 downto 0);
		SEL_W : in STD_LOGIC_VECTOR(2 downto 0);
		DATA_IN: in STD_LOGIC_VECTOR(31 downto 0);
		DATA_OUT_A : out STD_LOGIC_VECTOR(31 downto 0);
		DATA_OUT_B : out STD_LOGIC_VECTOR(31 downto 0)
	);
end component;

signal rf_wen : std_logic;
signal rf_sel_a : STD_LOGIC_VECTOR(2 downto 0);
signal rf_sel_b : STD_LOGIC_VECTOR(2 downto 0);
signal rf_sel_w : STD_LOGIC_VECTOR(2 downto 0);
signal rf_data_in: STD_LOGIC_VECTOR(31 downto 0);
signal rf_data_outa: STD_LOGIC_VECTOR(31 downto 0);
signal rf_data_outb: STD_LOGIC_VECTOR(31 downto 0);

begin

end bdf_type;