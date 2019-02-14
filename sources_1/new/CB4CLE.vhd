----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.11.2018 23:35:31
-- Design Name: 
-- Module Name: CB4CLE - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity CB4CLE is
Port (
    D0,D1,D2,D3: in std_logic;
    L,CE,CLK,CLR: in std_logic;
    Q0,Q1,Q2,Q3: out std_logic;
    CEO,TC: out std_logic
 );
end CB4CLE;

architecture Behavioral of CB4CLE is

signal q0s,q1s,q2s,q3s: std_logic;
signal tcs: std_logic;

signal counter,new_counter: std_logic_vector(3 downto 0);

begin

counter(0) <= q0s;
counter(1) <= q1s;
counter(2) <= q2s;
counter(3) <= q3s;
new_counter <= std_logic_vector(unsigned(counter) + 1);

process(D0,D1,D2,D3,L,CE,CLK,CLR,new_counter) begin
    if(CLR = '1') then
        q0s <= '0';
        q1s <= '0';
        q2s <= '0';
        q3s <= '0';
    elsif(rising_edge(CLK)) then
        if(L = '1') then
            q0s <= D0;
            q1s <= D1;
            q2s <= D2;
            q3s <= D3;
        elsif(CE = '1') then
            q0s <= new_counter(0);
            q1s <= new_counter(1);
            q2s <= new_counter(2);
            q3s <= new_counter(3);
        end if;
    end if;
end process;

Q0 <= q0s;
Q1 <= q1s;
Q2 <= q2s;
Q3 <= q3s;
tcs <= q0s and q1s and q2s and q3s;

TC <= tcs;
CEO <= tcs and CE;

end Behavioral;
