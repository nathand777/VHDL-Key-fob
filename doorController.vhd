library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity doorController is
port (tr, tl, clk: in std_logic;
	drul, drl, dul, dl : out std_logic);
end entity;

architecture behav11 of doorController is

type states is (s0, s1, s2, s3,s4);
signal state: states:=s0;
signal nextstate: states;

signal waspressed: std_logic:='0';

begin

	drl <= '1' when state = s1 else '0';
	dl <= '1' when state = s1 else '0';
	
	dul <= '1' when state = s4 else '0';
	drul <= '1' when state = s3 or state = s4
				else '0';

	process (clk, state, tl, tr)
	begin
	
		if tl = '1' then nextstate <= s1;
		elsif rising_edge(clk) then
			case state is
				when s0 => if tr = '1' then nextstate <= s2;
							end if;
				when s1 => nextstate <= s0;
				when s2 => if tr = '1' then nextstate <= s4;
							else nextstate <= s3;
							end if;
				when s3 => nextstate <= s0;
				when s4 =>  nextstate <= s0;
			end case;
		end if;
	end process;

	state <= nextstate;
	
end architecture;