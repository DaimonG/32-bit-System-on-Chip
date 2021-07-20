-- Testbench for counter

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY counterTB IS
END counterTB;

ARCHITECTURE behavior OF counterTB IS 

	COMPONENT counter 
		GENERIC ( data_size : integer := 16;
			num_counters : integer range 1 to 16 := 4;
			signal_active : std_logic := '0');
		PORT (  clk,resetn :   in  std_logic;
        		rdn,wrn    :   in  std_logic;
			address    :   in  std_logic_vector(7 downto 0);
			data_in    :   in  std_logic_vector(data_size-1 downto 0);
			data_out   :   out std_logic_vector(data_size-1 downto 0)
			);
	END COMPONENT;

	constant data_size : integer := 16;

	--Inputs
	signal clk : std_logic := '1';
	signal resetn : std_logic := '1';
	signal rdn: std_logic := '1';
	signal wrn : std_logic := '1';
	signal address : std_logic_vector(7 downto 0);
	signal data_in : std_logic_vector(data_size-1 downto 0);

	--Outputs
	signal data_out : std_logic_vector(data_size-1 downto 0);

	-- Clock period definitions
	constant period : time := 10 ns;
 
BEGIN

	-- Instantiate the Unit Under Test (UUT)
	uut: counter
	GENERIC MAP(
		data_size => 16,
		num_counters => 1,
		signal_active => '0'
		)
	PORT MAP (
		clk => clk,
		resetn => resetn,
		rdn => rdn,
		wrn => wrn,
		address => address,
		data_in => data_in,
		data_out => data_out
		);

	clk <= not clk after period / 2;

	-- Stimulus process
	stimulus: process
	begin		
		-- hold reset state for 100 ns.
		resetn		<= '0';
		wait for 100 ns;	
		resetn		<= '1';

		--begin testing
		wait for period*10;
		
		--case 1: reset counter to custom value
		address <= x"10";
		data_in <= x"0004";

		rdn <= '1';
		wrn <= '0';

		wait for period*2;

		assert1 : assert data_out = x"0004";

		wait for period;

		--case 2: forward counting
		address <= x"20";

		wait for period*3;

		assert2 : assert data_out = x"0005";

		--case 3: idle
		address <= x"40";

		wait for period*10;

		assert3 : assert data_out = x"0007";

		--case 4: backward counting

		address <= x"30";

		wait for period*10;

		assert4 : assert data_out = x"0000";

		wait;
	end process;
END;
