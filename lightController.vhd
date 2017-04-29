library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity lightController is
port (bl, lit, clk: in std_logic;
		lon, loff, light: out std_logic);
end entity lightController;

architecture behav of lightController is 

type states is (init,s0, s1, s2, s3);
signal state: states:=s0;
signal nextstate: states;

begin

	--set up moore outputs
	lon <= '1' when state = s2 else '0';
	loff <= '1' when state = s0 else '0';

	process(state, bl, lit)
	begin
		case state is
			when init => nextstate <= s1;
			when s0 => light <= '0'; nextstate <= s1;
			when s1 => if bl = '1' and lit = '0' then  nextstate <= s2;
						else nextstate <= s1;
						end if;
			when s2 => light <= '1'; nextstate <=s3;
			when s3 => if bl = '1' and lit = '1' then nextstate <= s0;
						else nextstate <= s3;
						end if;
		end case;
	end process;
	
	process (clk)
	begin
		if rising_edge(clk) then
			state <= nextstate;
		end if;
	end process;
end architecture;



