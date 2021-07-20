LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY tbSRAM IS
END tbSRAM;

ARCHITECTURE behavior OF tbSRAM IS
        COMPONENT SRAM
                GENERIC ( addr_size : integer := 11;
                        word_size: integer := 32;
                        signal_active : std_logic := '0');
                PORT (  clk        :   in  std_logic;
                        rdn,wrn    :   in  std_logic;
                        address    :   in  std_logic_vector(addr_size-1 downto 0);
	         	bit_wen    :   in  std_logic_vector(word_size-1 downto 0);
                        data_in    :   in  std_logic_vector(word_size-1 downto 0);
                        data_out   :   out std_logic_vector(word_size-1 downto 0)
                        );
        END COMPONENT;

        constant addr_size : integer := 11;
        constant word_size : integer := 32;
        --Inputs
        signal clk : std_logic := '1';
        signal rdn: std_logic := '0';
        signal wrn : std_logic := '1';
        signal address : std_logic_vector(addr_size-1 downto 0);
        signal bit_wen : std_logic_vector(word_size-1 downto 0);
        signal data_in : std_logic_vector(word_size-1 downto 0);

        --Outputs
        signal data_out : std_logic_vector(word_size-1 downto 0);

        --Clock period definitions
        constant period : time := 10 ns;

BEGIN
        -- Instantiate the Unit Under Test (UUT)
        uut: SRAM
        GENERIC MAP(
                addr_size => 11,
                word_size => 32,
                signal_active => '0'
                )
        PORT MAP (
                clk => clk,
                rdn => rdn,
                wrn => wrn,
                address => address,
                bit_wen => bit_wen,
                data_in => data_in,
                data_out => data_out
                );

        clk <= not clk after period / 2;

        -- Stimulus process
        stimulus: process
        begin
        -- hold reset state for 100 ns for global reset.
        wait for 100 ns;

	data_in <= x"00000000";

        address  <= x"00000000";

        bit_wen <= b"0000000000";

        wrn <= b"0000000001";

        rdn  <= b"0000000001";

        wait for 20 ns;

        data_in  <= x"00000000";

        address  <= x"00000000";

        wait for 20 ns;

        data_in  <= x"00000001";

        address  <= x"00000001";

        wait for 20 ns;

        data_in  <= x"00001010";

        address  <= x"00000011";

        wait for 20 ns;

        data_in  <= x"00000110";

        address  <= x"00000011";

        wait for 20 ns

        data_in  <= x"00001100";

        address  <= x"00000100";

        wait for 40 ns;

        address  <= x"00000000";

        wrn <= b"0000000000";

        rdn  <= b"0000000001";

        wait for 20 ns;

        address  <= x"00000001";

        wait for 20 ns;
          
        address  <= x"00000010";

        wait for 20 ns;

        address   <= x"00000011";

        wait for 20 ns;

        address   <= x"00000100";

              wait;
        end process;
END;


