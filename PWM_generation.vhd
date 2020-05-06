-- Se describe un circuito que genera una señal de PWM correspondiente a la entrada de 8 bits
-- Es importante señalar que el periodo de la señal de salida es T = 256*Tclk


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;						-- Para usar conversion de tipos de datos

entity PWM_generation is 
port( 	S: 	out 	std_logic :='1'; 
			En: 	in 	std_logic;
			clk: 	in 	std_logic;
			E: 	in 	std_logic_vector(7 downto 0)
);
end PWM_generation;

architecture Arq1 of PWM_generation is 
signal S_A: 	std_logic := '1'; 						-- Auxiliar signal definition (internal cable)
signal Count_H: 	integer range 0 to 255 := 0;
begin
process (En, clk)
begin
	if En = '0' then 
		S_A <= '0';								-- Coloca en cero la salida si En = 0
	elsif (rising_edge(clk)) then 
	
		if Count_H = to_integer(unsigned(E))  then 
			S_A 		<= '0';				 	-- Coloca en bajo S_A
			if Count_H /= 255 then 
				Count_H <= Count_H + 1;			-- Incrementa Count_H
			else 
				Count_H 	<= 0;						-- Reinicia Count_H
			end if;	
		elsif Count_H 	= 255 then 			--
			Count_H 	<= 0;						-- Reinicia Count_H
			S_A 		<= '1';					-- Coloca en alto S_A	
		else
			Count_H <= Count_H + 1;			-- Incrementa Count_H
		end if;
		
	end if;
	

end process;
-- Asignación de señales:
S <= S_A;
end Arq1;
