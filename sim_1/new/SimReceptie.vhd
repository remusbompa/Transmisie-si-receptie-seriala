----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.11.2018 17:39:15
-- Design Name: 
-- Module Name: SimReceptie - Behavioral
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

entity SimReceptie is
--  Port ( );
end SimReceptie;

architecture Behavioral of SimReceptie is

component Transmisie_seriala is
Port (
 D: in std_logic_vector(7 downto 0);
 ceas,reset,start: in std_logic;
 rxrdy,dreq: in std_logic;
 date_seriale: out std_logic;
 gata_operatie: out std_logic

 );
end component;

component Receptie_seriala is
Port (
ds,start,ceas_e,reset,preld: in std_logic;
rdy,sr,da,pe,se: out std_logic;
D: out std_logic_vector(7 downto 0)
 );
end component;

---transmisie

signal ceas: std_logic := '0';
constant perioada_ceas: time := 10ns;

signal reset: std_logic;
signal start, rxrdy, dreq: std_logic;
signal date_seriale, gata_operatie: std_logic;

signal D: std_logic_vector(7 downto 0);

---receptie

signal ceas_e: std_logic := '0';
constant perioada_ceas_e: time := perioada_ceas / 8;

signal preld: std_logic := '1';
signal rdy,sr,da,pe,se: std_logic;

signal Drecept: std_logic_vector(7 downto 0);

begin

CLK_proc: process begin
    ceas <= '1';
    wait for perioada_ceas / 2;
    ceas <= '0';
    wait for perioada_ceas / 2;
end process;

CLK_proc_e: process begin
    ceas_e <= '1';
    wait for perioada_ceas_e / 2;
    ceas_e <= '0';
    wait for perioada_ceas_e / 2;
end process;

reset_proc: process begin
    reset <= '1';
    wait for 3 * perioada_ceas;
    reset <= '0';
    wait for 15 * perioada_ceas;
end process;

comenzi_proc: process begin
    start <= '0';
    rxrdy <= '0';
    dreq <= '0';
    wait for 5 * perioada_ceas;
    start <= '1';
    rxrdy <= '1';
    dreq <= '1';
    wait for 13 * perioada_ceas;
end process;

data_proc: process begin
    D <= "11100001";
    wait for 18 * perioada_ceas;
    D <= "00110011";
    wait for 18 * perioada_ceas;
end process;

Transmisie_serialauut: Transmisie_seriala port map (ceas => ceas, reset => reset, start => start, rxrdy => rxrdy, dreq => dreq,
                        D => D, date_seriale => date_seriale, gata_operatie => gata_operatie);

Receptie_serialauut: Receptie_seriala port map (ceas_e => ceas_e, reset => reset, preld => preld,
                    ds => date_seriale, start => start, rdy => rdy, sr => sr, da => da, pe => pe, se => se, D => Drecept);
                        
end Behavioral;
