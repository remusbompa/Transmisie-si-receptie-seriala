----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.11.2018 17:14:00
-- Design Name: 
-- Module Name: Receptie_seriala - Behavioral
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

entity Receptie_seriala is
Port (
ds,start,ceas_e,reset,preld: in std_logic;
rdy,sr,da,pe,se: out std_logic;
D: out std_logic_vector(7 downto 0)
 );
end Receptie_seriala;

architecture Behavioral of Receptie_seriala is

component H5 is
Port (
   load,ds,depl,ceas_e: in std_logic;
   sli,d_se: out std_logic
 );
end component;

component H7 is
Port (
    start,sr,reset,ds,ceas_e: in std_logic;
    rdy,en_se,depl: out std_logic

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

component FDRSE is
Port ( 
    S,D,CE,CLK,R: in std_logic;
    Q: out std_logic
);
end component;

component FDCE is
Port (
    D,CE,CLK,CLR: in std_logic;
    Q: out std_logic

 );
end component;

signal S1, Q,sli,d_se,en_se,depl,paritate,nQ, clr,dsli : std_logic;
signal QAst, QBst, QCst, QDst, QAdr, QBdr, QCdr, QDdr : std_logic;

begin

H5uut: H5 port map (load => reset, ds => ds, depl => depl, ceas_e => ceas_e, sli => sli, d_se => d_se);

s1 <= reset or depl;
X74_194st: X74_194 port map(sli => sli, A => '1', B => '1', C => '1', D => '1', sri => '1', s0 => reset, s1 => s1,
            CLK => ceas_e, CLR => '0', QA => QAst, QB => QBst, QC => QCst, QD => QDst);

X74_194dr: X74_194 port map(sli => QAst, A => '1', B => '1', C => '1', D => '1', sri => '0', s0 => reset, s1 => s1,
            CLK => ceas_e, CLR => '0', QA => QAdr, QB => QBdr, QC => QCdr, QD => QDdr);

FDRSEuut: FDRSE port map (S => clr, D => QAdr, CE => depl, CLK => ceas_e, R => '0', Q => Q);
sr <= Q;
D(0) <= QAdr;
D(1) <= QBdr;
D(2) <= QCdr;
D(3) <= QDdr;
D(4) <= QAst;
D(5) <= QBst;
D(6) <= QCst;
D(7) <= QDst;
paritate <= not( QAdr xor QBdr xor QCdr xor QDdr xor QAst xor QBst xor QCst xor QDst);

H7uut: H7 port map (start => start, sr => Q, reset => reset, ds => ds, ceas_e => ceas_e, rdy => rdy, en_se => en_se, depl => depl);

nQ <= not Q;
clr <= not( (not(reset)) and preld);
dsli <= sli xor paritate;
FDCE0: FDCE port map (D => '1', CE =>  nQ, CLK => ceas_e, CLR => clr, Q => da);
FDCE1: FDCE port map (D => dsli, CE =>  nQ, CLK => ceas_e, CLR => clr, Q => pe);
FDCE2: FDCE port map (D => d_se, CE =>  en_se, CLK => ceas_e, CLR => clr, Q => se);

end Behavioral;
