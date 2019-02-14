----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.11.2018 23:21:39
-- Design Name: 
-- Module Name: FDRSE - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity FDRSE is
Port ( 
    S,D,CE,CLK,R: in std_logic;
    Q: out std_logic
);
end FDRSE;

architecture Behavioral of FDRSE is
   
begin

process(S,D,CE,CLK,R) begin
    if(rising_edge(CLK)) then
        if(R = '1') then
            Q <= '0';
        elsif(S = '1') then
            Q <= '1';
        elsif(CE = '1') then
            Q <= D;
        end if;
    end if;        
end process;

end Behavioral;
