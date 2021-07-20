--Implementation based upon http://nvlpubs.nist.gov/nistpubs/FIPS/NIST.FIPS.197.pdf

--MIT License
--
--Copyright (c) 2018 Balazs Valer Fekete
--
--Permission is hereby granted, free of charge, to any person obtaining a copy
--of this software and associated documentation files (the "Software"), to deal
--in the Software without restriction, including without limitation the rights
--to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
--copies of the Software, and to permit persons to whom the Software is
--furnished to do so, subject to the following conditions:
--
--The above copyright notice and this permission notice shall be included in all
--copies or substantial portions of the Software.
--
--THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
--IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
--FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
--AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
--LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
--OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
--SOFTWARE.

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY aes128keyWrapperTB IS
END aes128keyWrapperTB;

ARCHITECTURE behavior OF aes128keyWrapperTB IS 

	COMPONENT aes128keyWrapper
	PORT(
		reset : IN  std_logic;
		clock : IN  std_logic;
		input : IN  std_logic_vector(31 downto 0);
		cipher : OUT  std_logic_vector(31 downto 0);
		mr,mw : IN std_logic;
		keyOrPlain : IN std_logic_vector(31 downto 0)
		);
	END COMPONENT;

	--Inputs
	signal reset : std_logic := '0';
	signal clock : std_logic := '0';
	signal input : std_logic_vector(31 downto 0) := (others => '0');
	signal mr : std_logic := '0';
	signal mw : std_logic := '0';
	signal keyOrPlain : std_logic_vector(31 downto 0) := x"00000000";

	--Outputs
	signal cipher : std_logic_vector(31 downto 0);
	
	-- Clock period definitions
	constant clock_period : time := 10 ns;
 	constant realKey : std_logic_vector(127 downto 0) := x"000102030405060708090a0b0c0d0e0f";
 	constant realPlain : std_logic_vector(127 downto 0) := x"00112233445566778899aabbccddeeff";
	constant realCipher : std_logic_vector(127 downto 0) := x"69C4E0D86A7B0430D8CDB78070B4C55A";
	constant busWidth : integer := 32; 

	-- Internal Signals 
	signal simBus : std_logic_vector(127 downto 0); 
	signal keyCount, plainCount : integer := 0;

BEGIN

	-- Instantiate the Unit Under Test (UUT)
	uut: aes128keyWrapper PORT MAP (
		reset => reset,
		clock => clock,
		input => input, 
		cipher => cipher,
		mr => mr,
		mw => mw,
		keyOrPlain => keyOrPlain
		);

	-- Clock process definitions
	clock <= not clock after clock_period/2;  

	-- Stimulus process
	stim_proc: process
	begin		
		-- hold reset state for 100 ns.
		reset		<= '1';
		wait for 100 ns;	
		reset		<= '0';
		
		-- begin testing
		-- Case 1: write to keyBuffer in 4 clock cycles
		keyOrPlain <= x"20000000";
		mw <= '1';
		--keyCount <= 0; 
		
		-- need to simulate for 4 clock cycles
		while keyCount < 4 loop
			input <= realKey((keyCount+1)*busWidth-1 downto keyCount*busWidth); 
			keyCount <= keyCount + 1;
			wait for clock_period;   
		end loop; 		 
		
		--assert1 : assert uut.keyBuffer = realKey; 
		
		mw <= '0';
		wait for 2*clock_period; 

		-- Case 2: write to plainBuffer in 4 clock cycles
		keyOrPlain <= x"20000001";
		mw<= '1';
		plainCount <= 0;
		
		-- takes 4 clock cycles
		while plainCount < 4 loop
			input <= realPlain((plainCount+1)*busWidth-1 downto plainCount*busWidth); 
			plainCount <= plainCount + 1;
			wait for clock_period;   
		end loop; 		 
		
		--assert2 : assert uut.plainBuffer = realPlain; 
		
		mw <= '0'; 
		wait for 2*clock_period; 
		
		-- Wait some time for AES
		wait for 40*clock_period; 

		-- Case 3: receive output from AES core
		mr <= '1'; 
		
		
		wait for clock_period; 

		-- Data will be read in 4 clock cycles 
		assert3 : assert cipher = realCipher(31 downto 0);
		wait for clock_period; 

		assert4 : assert cipher = realCipher(63 downto 32);
		wait for clock_period; 

		assert5 : assert cipher = realCipher(95 downto 64); 
		wait for clock_period; 

		assert6 : assert cipher = realCipher(127 downto 96); 
		
		wait;
	end process;

END;
