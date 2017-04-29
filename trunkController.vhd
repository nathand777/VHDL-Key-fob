library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity trunkController is
port (br, clk : in std_logic;
	trl, trul : out std_logic);
end entity;

architecture behav of trunkController is

type states is (s0, s1, s2, s3,s4,s5);
signal state: states:=s0;
signal nextstate: states;

begin

	trl <= '1' when state = s4 else '0';
	trul <= '1' when state = s5 else '0';
	
	process(state, br , clk)
	begin
		if rising_edge(clk) then 
			case state is
				when s0 => if br = '1' then nextstate <= s1;
							end if;
				when s1 => if br = '1' then nextstate <= s2;
							else nextstate <= s5;
							end if;
				when s2 => if br = '1' then nextstate <= s3;
							else nextstate <= s5;
							end if;
				when s3 => if br = '1' then nextstate <= s4;
							else nextstate <= s5;
							end if;
				when s4 => nextstate <= s0;
				when s5 => if br = '0' then nextstate <= s0;
							end if;
			end case;
		end if;
	end process;
	
	state <= nextstate;

end architecture;