library ieee;
use ieee.std_logic_1164.all;
entity bcd_6 is
  port(clk,reset:in std_logic;
       datain:in std_logic_vector(7 downto 0);
       ain,bin:out std_logic_vector(7 downto 0));
     end;
     architecture RTL of bcd_6 is
    
 
 signal A_ripple_sub:std_logic_vector(7 downto 0):="00000110";
 signal Cin:std_logic:='0';
 signal datain_tmp,dataout_tmp:std_logic_vector(7 downto 0);
 constant data:std_logic_vector(7 downto 0):="00001001";
     begin
     
             
             process(clk,reset)
               begin
                 if reset='0' then
                ain<=(others=>'0');
                     bin<="00000110";
                
                 elsif clk'event and clk='1' then
                   if datain<data then
                     ain<=datain;
                                          bin<="00000000";
                     
                 else
                   ain<=datain;
                   bin<="00000110";
                    end if;
                 end if;
               end process;
             end;
             
             