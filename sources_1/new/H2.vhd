----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.11.2018 00:16:11
-- Design Name: 
-- Module Name: H2 - Behavioral
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

entity H2 is
Port (
start,rxrdy,num12,dreq,reset,ceas: in std_logic;
txrdy,rdy,incarca,depl,ddisp: out std_logic
 );
end H2;

architecture Behavioral of H2 is

type state_type is (s0,s1,s2,s3,s4,s5);
signal state: state_type := s0;

begin

process(ceas,reset,start,rxrdy,num12,dreq,state) begin
    if(reset = '1') then
        state <= s0;
        txrdy <= '0';
        rdy <= '0';
        incarca <= '0';
        depl <= '0';
        ddisp <= '0';
    elsif state = s0 then
        rdy <= '1';
        if(start = '1') then
            state <= s1;
            rdy <= '0';
            incarca <= '1';
            depl <= '1';
        end if;
        
    elsif state = s2 then
        if(dreq = '1') then
           state <= s3;
           ddisp <= '0';
        end if;
        
    elsif state = s5 then
        if(rxrdy = '1') then
            state <= s0;
            txrdy <= '0';
        end if;
    elsif(rising_edge(ceas)) then
        case state is
            when s1 =>
                state <= s2;
                incarca <= '0';
                ddisp <= '1';

            when s3 =>
                state <= s4;
            when s4 =>
                if(num12 = '1') then
                    state <= s5;
                    txrdy <= '1';
                    depl <= '0';
                end if;
            when others => NULL;
        end case;
    end if;
    
end process;

end Behavioral;
