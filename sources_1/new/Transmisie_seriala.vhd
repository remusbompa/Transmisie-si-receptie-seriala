----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.11.2018 21:26:31
-- Design Name: 
-- Module Name: Transmisie_seriala - Behavioral
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

entity Transmisie_seriala is
Port (
 D: in std_logic_vector(7 downto 0);
 ceas,reset,start: in std_logic;
 rxrdy,dreq: in std_logic;
 date_seriale: out std_logic;
 gata_operatie: out std_logic

 );
end Transmisie_seriala;

architecture Behavioral of Transmisie_seriala is

component CB4CLE is
Port (
    D0,D1,D2,D3: in std_logic;
    L,CE,CLK,CLR: in std_logic;
    Q0,Q1,Q2,Q3: out std_logic;
    CEO,TC: out std_logic
 );
end component;

component FDCE is
Port (
    D,CE,CLK,CLR: in std_logic;
    Q: out std_logic

 );
end component;

component FDRSE is
Port ( 
    S,D,CE,CLK,R: in std_logic;
    Q: out std_logic
);
end component;

component X74_194 is
Port (
SLI: in std_logic;
A,B,C,D: in std_logic;
SRI: in std_logic;
S0,S1: in std_logic;
CLK: in std_logic;
CLR: in std_logic;
QA,QB,QC,QD: out std_logic
 );
 
end component;

component H2 is
Port (
start,rxrdy,num12,dreq,reset,ceas: in std_logic;
txrdy,rdy,incarca,depl,ddisp: out std_logic
 );
end component;

signal paritate: std_logic;
signal incarca,depl,txrdy: std_logic;
signal Qst,QAst,QAdr,Q0,Q1,Q2,Q3: std_logic;

signal Sst,Rst,S1,CLRcb,num12: std_logic;

signal gata_op: std_logic;
begin
    paritate <= ( D(0) xor D(1) xor D(2) xor D(3) xor D(4) xor D(5) xor D(6) xor D(7));
    
    Sst <= paritate and incarca;
    Rst <= (not paritate) and incarca;
    FDRSEst: FDRSE port map (S => Sst, D => '1', CE => depl, CLK => ceas, R => Rst, Q => Qst);
    FDRSEdr: FDRSE port map (S => reset, D => QAdr, CE => depl, CLK => ceas, R => incarca, Q => date_seriale);
    
    S1 <= depl or incarca;
    X74_194st: X74_194 port map (SLI => Qst, A => D(4), B => D(5), C => D(6), D => D(7), SRI => '0',
                S0 => incarca, S1 => S1, CLK => ceas, CLR => reset, QA => QAst);
    X74_194dr: X74_194 port map (SLI => QAst, A => D(0), B => D(1), C => D(2), D => D(3), SRI => '0',
                                S0 => incarca, S1 => S1, CLK => ceas, CLR => reset, QA => QAdr);
    
    CLRcb <= reset or txrdy;
    CB4CLEuut: CB4CLE port map (D0 => '0', D1 => '0', D2 => '0', D3 => '0', L => '0', CE => depl,
                CLK => ceas, CLR => CLRcb, Q0 => Q0, Q1 => Q1, Q2 =>Q2, Q3 =>Q3);
    
    num12 <= (not(Q0)) and (not(Q1)) and Q2 and Q3;
    H2uut: H2 port map (start => start, rxrdy => rxrdy, reset =>  reset, num12 => num12, dreq => dreq,
                ceas => ceas, txrdy => txrdy, incarca => incarca, depl => depl);
                
    FDCEuut: FDCE port map (D => '1', CE => txrdy, CLK => ceas, CLR => reset, Q => gata_op);
    gata_operatie <= gata_op;
end Behavioral;
