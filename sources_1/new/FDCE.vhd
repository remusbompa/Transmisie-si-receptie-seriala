----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.11.2018 00:08:36
-- Design Name: 
-- Module Name: FDCE - Behavioral
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

entity FDCE is
Port (
    D,CE,CLK,CLR: in std_logic;
    Q: out std_logic

 );
end FDCE;

architecture Behavioral of FDCE is

begin

process(D,CE,CLK,CLR) begin
    if(CLR = '1') then
        Q <= '0';
    elsif(CE = '1' and rising_edge(CLK)) then
        Q <= D;
    end if;
end process;

end Behavioral;
