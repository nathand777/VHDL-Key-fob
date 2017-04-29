library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity myTrunkTB1 is
end entity;

architecture structur of myTrunkTB1 is

component trunkController
port (br, clk : in std_logic;
	trl, trul : out std_logic);
end component;

signal finished : std_logic:='0'; --signal to indicate when finished
signal stim_clk : std_logic := '0';
signal stim_br : std_logic:='0';
signal watch_trl, watch_trul : std_logic;

constant half_period: time:=10 ns;

begin

	u1 : trunkController port map (stim_br, stim_clk, watch_trl, watch_trul);
	
	stim_clk <= not stim_clk after half_period when finished /= '1' else '0'; --set up clock
	
	process
	begin
		wait for 20 ns;
		stim_br <= '1'; wait for 20 ns;
		stim_br <= '0'; wait for 40 ns;
		stim_br <= '1'; wait for 40 ns;
		stim_br <= '0'; wait for 20 ns;
		stim_br <= '1'; wait for 80 ns;
		stim_br <= '0'; wait for 20 ns;
		finished <= '1';
		wait;
	end process;
end architecture;
		