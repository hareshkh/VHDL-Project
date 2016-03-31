LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY AC_REMOTE IS
	PORT(
		TEMPERATURE: OUT STD_LOGIC_VECTOR (5 DOWNTO 0);
		FANSPEED: OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
		RESET: IN STD_LOGIC;
		TEMPUP: IN STD_LOGIC;
		TEMPDOWN: IN STD_LOGIC;
		FANUP: IN STD_LOGIC;
		FANDOWN: IN STD_LOGIC
	);
END AC_REMOTE;

ARCHITECTURE LOGIC OF AC_REMOTE IS
SIGNAL TEMPERATURE_STORAGE : STD_LOGIC_VECTOR (5 DOWNTO 0) := (OTHERS => '0');
SIGNAL FANSPEED_STORAGE : STD_LOGIC_VECTOR (1 DOWNTO 0) := (OTHERS => '0');

BEGIN

	FANSPEED <= FANSPEED_STORAGE;
	TEMPERATURE <= TEMPERATURE_STORAGE;
	
	CHANGE : PROCESS (RESET, TEMPUP, TEMPDOWN, FANUP, FANDOWN) IS
	BEGIN		
		IF (RESET = '1') THEN
			TEMPERATURE_STORAGE(5) <= '0';
			TEMPERATURE_STORAGE(4) <= '1';
			TEMPERATURE_STORAGE(3) <= '1';
			TEMPERATURE_STORAGE(2) <= '0';
			TEMPERATURE_STORAGE(1) <= '0';
			TEMPERATURE_STORAGE(0) <= '1';
			FANSPEED_STORAGE(1) <= '1';
			FANSPEED_STORAGE(0) <= '0';
		
		ELSIF ((TEMPUP = '1' AND TEMPDOWN = '0') OR (TEMPDOWN = '1' AND TEMPUP = '0')) THEN
			IF (TEMPUP = '1' AND (UNSIGNED(TEMPERATURE_STORAGE)) < 36)THEN
				TEMPERATURE_STORAGE <= TEMPERATURE_STORAGE + 1;
			ELSIF (TEMPDOWN = '1' AND (UNSIGNED(TEMPERATURE_STORAGE)) > 16) THEN
				TEMPERATURE_STORAGE <= TEMPERATURE_STORAGE - 1;
			END IF;
		
		ELSIF ((FANUP = '1' AND FANDOWN = '0') OR (FANDOWN = '1' AND FANUP = '0')) THEN
			IF (FANUP = '1' AND (UNSIGNED(FANSPEED_STORAGE)) < 3) THEN
				FANSPEED_STORAGE <= FANSPEED_STORAGE + 1;
			ELSIF (FANDOWN = '1' AND (UNSIGNED(FANSPEED_STORAGE)) > 1) THEN
				FANSPEED_STORAGE <= FANSPEED_STORAGE - 1;
			END IF;
		END IF;
	END PROCESS CHANGE;

END LOGIC;