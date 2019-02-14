----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.11.2018 09:13:56
-- Design Name: 
-- Module Name: SimTransmitere - Behavioral
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

entity SimTransmitere is
--  Port ( );
end SimTransmitere;

architecture Behavioral of SimTransmitere is

component Transmisie_seriala is
Port (
 D: in std_logic_vector(7 downto 0);
 ceas,reset,start: in std_logic;
 rxrdy,dreq: in std_logic;
 date_seriale: out std_logic;
 gata_operatie: out std_logic

 );
end component;

signal ceas: std_logic := '0';
constant perioada_ceas: time := 10ns;

signal reset: std_logic;
signal start, rxrdy, dreq: std_logic;
signal date_seriale, gata_operatie: std_logic;

signal D: std_logic_vector(7 downto 0);

begin

CLK_proc: process begin
    ceas <= '1';
    wait for perioada_ceas / 2;
    ceas <= '0';
    wait for perioada_ceas / 2;
end process;

reset_proc: process begin
    reset <= '1';
    wait for 3 * perioada_ceas;
    reset <= '0';
    wait for 17 * perioada_ceas;
end process;

comenzi_proc: process begin
    start <= '0';
    dreq <= '0';
    wait for 5 * perioada_ceas;
    start <= '1';
    wait for 2 * perioada_ceas;
    dreq <= '1';
    wait for perioada_ceas;
    dreq <= '0';
    wait for 12 * perioada_ceas;
end process;

rxrdy_proc: process begin
    rxrdy <= '0';
    wait for 19 * perioada_ceas;
    rxrdy <= '1';
    wait for perioada_ceas;
end process;

data_proc: process begin
    D <= "10000111";
    wait for 20 * perioada_ceas;
    D <= "01010101";
    wait for 20 * perioada_ceas;
end process;

Transmisie_serialauut: Transmisie_seriala port map (ceas => ceas, reset => reset, start => start, rxrdy => rxrdy, dreq => dreq,
                        D => D, date_seriale => date_seriale, gata_operatie => gata_operatie);
end Behavioral;
