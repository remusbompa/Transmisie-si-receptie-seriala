----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.11.2018 16:07:54
-- Design Name: 
-- Module Name: H7 - Behavioral
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


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity H7 is
Port (
    start,sr,reset,ds,ceas_e: in std_logic;
    rdy,en_se,depl: out std_logic

 );
end H7;

architecture Behavioral of H7 is

type state_type is (s0,s1,s2,s3,s4,s5,s6,s7,s8,s9);
signal state: state_type := s0;

begin

process(start,sr,reset,ds,ceas_e,state) begin
    if(reset = '1') then
        rdy <= '1';
        en_se <= '0';
        depl <= '0';
        state <= s0;
    
    elsif state = s0 then
        rdy <= '1';
        if(start = '1') then
            state <= s1;
            rdy <= '0';
        end if;
    elsif state = s1 then
        if(ds = '0') then
            state <= s2;
        end if;
    
    elsif(rising_edge(ceas_e)) then
        case state is
            when s2 =>
                state <= s3;
            when s3 =>
                state <= s4;
                depl <= '1';
            when s4 =>
                state <= s5;
                depl <= '0';
            when s5 =>
                state <= s6;     
            when s6 =>
                state <= s7;           
            when s7 =>
                state <= s8;
            when s8 =>
                state <= s9;
                en_se <= '1';
            when s9 =>
                if(sr = '1') then
                    state <= s2;
                    en_se <= '0';
                else
                    state <= s0;
                    rdy <= '1';
                    en_se <= '0';
                end if;
        
            when others => NULL;
        end case;
    end if;
end process;

end Behavioral;

