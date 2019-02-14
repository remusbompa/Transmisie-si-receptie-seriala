----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.11.2018 15:15:14
-- Design Name: 
-- Module Name: H5 - Behavioral
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

entity H5 is
Port (
   load,ds,depl,ceas_e: in std_logic;
   sli,d_se: out std_logic
 );
end H5;

architecture Behavioral of H5 is

begin

process(load,ds,depl,ceas_e) begin
    if(rising_edge(ceas_e)) then
        if(load = '1') then
            sli <= '1';
            d_se <= '0';
        elsif(depl = '1') then
            sli <= ds;
            if(ds = '0') then
                d_se <= '1';
            else d_se <= '1';
            end if;
        end if;
    end if;
end process;

end Behavioral;
