library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity myLightTB1 is
end entity;

architecture structural of myLightTB1 is

component lightController
port (bl, lit, clk: in std_logic;
		lon, loff, light: out std_logic);
end component;

signal stim_bl, stim_lit : std_logic:='0';
signal stim_clk : std_logic := '0';
signal watch_lon, watch_loff, watch_light : std_logic;
signal finished : std_logic:='0'; --signal to indicate when finished

constant half_period: time:= 10 ns;

begin

	u1 : lightController port map (stim_bl, stim_lit, stim_clk, watch_lon, watch_loff, watch_light);
	
	stim_clk <= not stim_clk after half_period when finished /= '1' else '0'; --set up clock
	
	process
	begin
		wait for 20 ns; --wait for state change from s0 to s1
		stim_bl <='1'; stim_lit <= '0'; wait for 40 ns;
		stim_bl <= '1'; stim_lit <='1'; wait for 40 ns;
		finished <= '1';
		wait;
	end process;
	
end architecture;

	