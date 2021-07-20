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

ENTITY aes128keyWrapper IS
	PORT(
		reset : IN  std_logic;
		clock : IN  std_logic;
		input : IN  std_logic_vector(31 downto 0); -- key or plain
		cipher : OUT  std_logic_vector(31 downto 0);
		mr,mw : IN std_logic; 
		keyOrPlain : IN std_logic_vector(31 downto 0)
		);
END aes128keyWrapper;

ARCHITECTURE behavior OF aes128keyWrapper IS 

	COMPONENT aes128key
	PORT(
		reset : IN  std_logic;
		clock : IN  std_logic;
		empty : OUT  std_logic;
		load : IN  std_logic;
		key : IN  std_logic_vector(127 downto 0);
		plain : IN  std_logic_vector(127 downto 0);
		ready : OUT  std_logic;
		cipher : OUT  std_logic_vector(127 downto 0)
		);
	END COMPONENT;

	signal load, ready, empty : std_logic;
	signal keyBuffer, plainBuffer, cipherBuffer : std_logic_vector(127 downto 0);
	signal keyCount, plainCount, cipherCount : integer;

	constant busWidth : integer := 32;
BEGIN

	-- Instantiate the Unit Under Test (UUT)
	uut: aes128key PORT MAP (
		reset => reset,
		clock => clock,
		empty => empty,
		load => load,
		key => keyBuffer,
		plain => plainBuffer,
		ready => ready,
		cipher => cipherBuffer
		);

mainFSM: process(clock)
begin
	if rising_edge(clock) then
		if reset = '1' or keyOrPlain = x"20000002" then
			keyBuffer <= x"00000000000000000000000000000000";
			plainBuffer <= x"00000000000000000000000000000000";
--			cipherBuffer <= x"00000000000000000000000000000000";
			keyCount <= 0;
			plainCount <= 0;
			cipherCount <= 0;
--			empty <= '0';
			load <= '0';
--			ready <= '0';
		else
			-- accumulating input data
			if mw = '1' then
				if keyOrPlain = x"20000000" then -- 0x20000000 = key | 0x20000001 = plain
					keyBuffer((keyCount+1)*busWidth-1 downto keyCount*busWidth) <= input;
					keyCount <= keyCount + 1;
				elsif keyOrPlain = x"20000001" then
					plainBuffer((plainCount+1)*busWidth-1 downto plainCount*busWidth) <= input;
					plainCount <= plainCount + 1;
				end if;

			-- send output to bus in 4 cycles
			elsif mr = '1' then
				if (ready = '1' or empty = '1') and cipherCount < 4 then
					cipher <= cipherBuffer((cipherCount+1)*busWidth-1 downto cipherCount*busWidth);
					cipherCount <= cipherCount + 1;
				end if;
			end if;
			
			-- load only needs to be asserted for 1 cycle
			if load = '1' then
				load <= '0';
				keyCount <= 0;
				plainCount <= 0;
				-- need to reset cipherCount before each use
				cipherCount <= 0;
			
			-- tell AES to start working if both input buffers are full
			elsif keyCount = 4 and plainCount = 4 then
				load <= '1';
			end if;
		end if;
	end if;
end process;

END;
