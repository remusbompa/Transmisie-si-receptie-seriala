----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.11.2018 21:39:34
-- Design Name: 
-- Module Name: X74_194 - Behavioral
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

entity X74_194 is
Port (
SLI: in std_logic;
A,B,C,D: in std_logic;
SRI: in std_logic;
S0,S1: in std_logic;
CLK: in std_logic;
CLR: in std_logic;
QA,QB,QC,QD: out std_logic
 );
 
end X74_194;

architecture Behavioral of X74_194 is

signal qas,qbs,qcs,qds: std_logic;
signal qao,qbo,qco,qdo: std_logic;

begin

process(SLI,A,B,C,SRI,S0,S1,CLK,CLR) begin
    if(CLR = '1') then
        qao <= '0';
        qbo <= '0'; 
        qco <= '0'; 
        qdo <= '0'; 
    elsif(rising_edge(CLK)) then
         if(S0 = '1' and S1 = '1') then
            qao <= A; 
            qbo <= B; 
            qco <= C; 
            qdo <= D; 
        elsif(S0 = '1' and S1 = '0') then
            qao <= SRI; 
            qbo <= qas;
            qco <= qbs;
            qdo <= qcs;         
        elsif(S0 = '0' and S1 = '1') then
            qao <= qbs;
            qbo <= qcs;
            qco <= qds;
            qdo <= SLI;
        end if;
    end if;
end process;

qas <= qao;
qbs <= qbo;
qcs <= qco;
qds <= qdo;

QA <= qao;
QB <= qbo;
QC <= qco;
QD <= qdo;

end Behavioral;
