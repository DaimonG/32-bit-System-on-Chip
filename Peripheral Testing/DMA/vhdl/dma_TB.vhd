-- Testbench for DMA Macro

library ieee;
use ieee.std_logic_1164.all;

entity DMA_TB is
end DMA_TB; 

architecture behaviour of DMA_TB is

component dma
	generic(
		signal_active : std_logic := '0'; 
		size : positive := 32; 
		addr_size : positive := 32);
	port ( -- Ports
	   CLK, reset 	       : in std_logic; 
	   -- M1 port
           M1_BUSY, M1_MR, M1_MW : out  Std_logic;
           M1_NREADY           : in   Std_logic;
           M1_ADDRBUS          : out  Std_logic_vector(addr_size-1 downto 0);
           M1_RDATABUS         : in   Std_logic_vector(size-1 downto 0);
           M1_WDATABUS         : out  Std_logic_vector(size-1 downto 0);

           -- Slave (Control) port
           S1_BUSY, S1_MR, S1_MW : in   Std_logic;
           S1_NREADY           : out  Std_logic;
           S1_ADDRBUS          : in   Std_logic_vector(3 downto 0);
           S1_RDATABUS         : out  Std_logic_vector(size-1 downto 0);
           S1_WDATABUS         : in   Std_logic_vector(size-1 downto 0) );
	end component;
	
	-- Signal Definitions
	-- Constants
	constant size : positive := 32; 
	constant addr_size : positive := 32;
	constant signal_active : std_logic := '0';
	constant signal_not_active : std_logic := not signal_active;

	-- Inputs
	signal CLK : std_logic := '1';
	signal reset : std_logic := '1'; 

	-- M1 Inputs
	signal M1_NREADY : Std_logic := '1';
	signal M1_RDATABUS : Std_logic_vector(size-1 downto 0) := (OTHERS => '0');
	
	-- M1 Outputs
	signal M1_BUSY : Std_logic; 
	signal M1_MR : Std_logic;
	signal M1_MW : Std_logic;
	signal M1_ADDRBUS : Std_logic_vector(addr_size-1 downto 0); 
	signal M1_WDATABUS : Std_logic_vector(size-1 downto 0);

	-- Slave Inputs
	signal S1_BUSY : Std_logic := '1';
	signal S1_MR : Std_logic := '1';
	signal S1_MW : Std_logic := '1';
	signal S1_ADDRBUS : Std_logic_vector(3 downto 0) := (OTHERS => '0');
	signal S1_WDATABUS : Std_logic_vector(size-1 downto 0) := (OTHERS => '0'); 

	-- Slave Outputs
	signal S1_NREADY : Std_logic;
	signal S1_RDATABUS : Std_logic_vector(size-1 downto 0);
	


	 -- Clock Period definition
	 constant period : time := 10 ns; 
begin
	UUT : dma
	generic map (
		signal_active => '0', 
		size => 32, 
		addr_size => 32)		
 	port map (CLK => CLK,
		 reset => reset,
		 M1_BUSY => M1_BUSY,
		 M1_MR => M1_MR,
		 M1_MW => M1_MW,
		 M1_NREADY => M1_NREADY,
		 M1_ADDRBUS => M1_ADDRBUS,
		 M1_RDATABUS => M1_RDATABUS,
		 M1_WDATABUS => M1_WDATABUS,
		 S1_BUSY => S1_BUSY,
		 S1_MR => S1_MR,
		 S1_MW => S1_MW,
		 S1_NREADY => S1_NREADY,
		 S1_ADDRBUS => S1_ADDRBUS,
		 S1_RDATABUS => S1_RDATABUS,
		 S1_WDATABUS => S1_WDATABUS);

	CLK <= not CLK after period/2;

	-- Begin Testing
	input_data : process
	  begin
		-- Input Values
		M1_NREADY <= '1';
		M1_RDATABUS <= (others => '0');
		
		S1_BUSY <= '1';
		S1_MR <= '1'; 
		S1_MW <= '1';
		S1_ADDRBUS <= (others => '0');	
		S1_WDATABUS <= (others => '0');

		-- enter reset state
		reset <= '0'; 
		wait for 100 ns; 
		reset <= '1';
	
		-- Enter Testing Phase
		wait for period*10; 
		
		-- Master and Slave Communication Test
		
		-- Supply Master with Data
		M1_RDATABUS <= x"0A0A0A0A"; 
				
		-- MODIFY READ REGISTER TESTS
		--Case 1: Modify the rstart_reg register
                -- Write to count
                S1_MW <= signal_active;
                S1_BUSY <= signal_not_active;
                S1_ADDRBUS <= "0100";
                S1_WDATABUS <= x"00000003";

                wait for period*2;

                -- Ensure Correct Read
                assert1 : assert S1_RDATABUS = x"00000003";
		
		wait for period*3; 

		--Case 2: Modify the rstep_reg register
                -- Write to count
                S1_MW <= signal_active;
                S1_BUSY <= signal_not_active;
                S1_ADDRBUS <= "0101";
                S1_WDATABUS <= x"00000004";

                wait for period*2;

                -- Ensure Correct Read
                assert2 : assert S1_RDATABUS = x"00000004";
                wait for period*3;
		
		-- MOPDIFY WRITE REGISTER TESTS
			
		-- Case 3: Modify the wstart_reg register
                -- Write to count
                S1_MW <= signal_active;
                S1_BUSY <= signal_not_active;
                S1_ADDRBUS <= "0110";
                S1_WDATABUS <= x"00000005";

                wait for period*2;

                -- Ensure Correct Read
                assert3 : assert S1_RDATABUS = x"00000005";
                wait for period*3;

		-- Case 4: Modify the wstep_reg register
                -- Write to count
                S1_MW <= signal_active;
                S1_BUSY <= signal_not_active;
                S1_ADDRBUS <= "0111";
                S1_WDATABUS <= x"00000006";

                wait for period*2;

                -- Ensure Correct Read
                assert4 : assert S1_RDATABUS = x"00000006";
                wait for period*3;
		
		-- Case 5: Ensure we can increment count
		-- Increment Count
		S1_MW <= signal_active; 
		S1_BUSY <= signal_not_active;
		S1_ADDRBUS <= "0000"; 
		S1_WDATABUS <= x"00000001"; 
		
		wait for period*2.5; 
		
		-- No More reading from slave inputs
		S1_MW <= signal_not_active; 
		S1_BUSY <= signal_active; 

		
		assert5 : assert S1_RDATABUS = x"00000001"; 		
		
		-- Case 6: Master in Read Mode
		-- Ensure we see the read address		
		assert6 : assert M1_ADDRBUS = x"00000003";
		assert7 : assert M1_MR = signal_active; 
		
		wait for period*2; 
		
		-- Case 7: Master in Write Mode
		assert8 : assert M1_MW = signal_active;  
		assert9 : assert M1_WDATABUS = x"0A0A0A0A";
		assert10 : assert M1_ADDRBUS = x"00000005";  
				

		wait; -- Prevent loop		
				
	end process; 
END;   
