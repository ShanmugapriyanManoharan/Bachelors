library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity tof is
    Port ( a : in std_logic;
           b : in std_logic;
           p : out std_logic;
           q : out std_logic;
           r : out std_logic;
           inver_r : out std_logic);
end tof;

architecture Behavioral of tof is
signal tmp:std_logic;
begin

	p <= a;
	q <= b;
	tmp <= (a and b)xor'0';
  inver_r<=not tmp;
  r<=tmp;
end Behavioral;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity fred is
    Port ( a : in std_logic;
           b : in std_logic;
           p : out std_logic;
           q : out std_logic;
           r : out std_logic;
           inver_r:out std_logic);
end fred;



architecture Behavioral of fred is
signal tmp:std_logic;
begin

	  p <= a;
	  q <=((not a)and '1')or(a and b); 
	  tmp <=(a and '1')or((not a)and b);
	  inver_r<=not tmp;
	  r<=tmp;
	  	
end Behavioral;

library ieee;
use ieee.std_logic_1164.all;
entity compine_xor is
   port(a : in std_logic;
           b : in std_logic;
           p : out std_logic;
           q: out std_logic);
end compine_xor;

architecture RTL of compine_xor is
signal tmp:std_logic;
begin
  tmp<=(((not a) and b) or ((not b) and a));
  q<=not tmp;
  p<=tmp;
end;


library ieee;
use ieee.std_logic_1164.all;
entity top is
  port(clk,reset:in std_logic;
       a,b:in std_logic;
       and_cout:out std_logic;
       nand_cout:out std_logic;
       or_cout:out std_logic;
       nor_cout:out std_logic;
       xor_cout:out std_logic;
       xnor_cout:out std_logic);
     end;
     architecture RTL of top is
     
   
     component tof 
    Port ( a : in std_logic;
           b : in std_logic;
           p : out std_logic;
           q : out std_logic;
           r : out std_logic;
           inver_r : out std_logic);
end component; 

component fred
    Port ( a : in std_logic;
           b : in std_logic;
           p : out std_logic;
           q : out std_logic;
           r : out std_logic;
           inver_r : out std_logic);
end component;
 
 component compine_xor
   port(a : in std_logic;
           b : in std_logic;
           p : out std_logic;
           q : out std_logic);
         end component;
     begin
       c001:tof 
    Port map ( a=>a,
           b =>b,
           p =>open,
           q =>open,
           r =>and_cout,
           inver_r=>nand_cout);
       coo2:fred 
    Port map ( a=>a,
           b=>b,
           p =>open,
           q =>open,
           r =>or_cout,
           inver_r=>nor_cout);
       coo3:compine_xor
   port map(a =>a,
           b =>b,
           p =>xor_cout,
           q=>xnor_cout);
           
       
end;
  
 ---------------------------------------------------------
   library ieee;
use ieee.std_logic_1164.all;
entity mux_logic is
  port(clk,reset:in std_logic;
       A,b:in std_logic;
       con:in std_logic_vector(3 downto 0);
       A_aand:out std_logic;
       B_aand:out std_logic;
       A_oor:out std_logic;
       B_oor:out std_logic;
       A_eeor:out std_logic;
       B_eeor:out std_logic;
       A_xxnor:out std_logic;
       B_xxnor:out std_logic;
       A_nnand:out std_logic;
       B_nnand:out std_logic;
       A_nnor:out std_logic;
       B_nnor:out std_logic
       );
     end;
     architecture RTL of mux_logic is
     begin
       process(clk,reset)
         begin
           if reset='0' then
              A_aand<='0';
              B_aand<='0';
              A_oor<='0';
              B_oor<='0';
              A_eeor<='0';
              B_eeor<='0';
              A_xxnor<='0';
              B_xxnor<='0';
              A_nnand<='0';
              B_nnand<='0';
              A_nnor<='0';
              B_nnor<='0';
         elsif clk'event and clk='1' then  
           case con is
           when "0000"=> 
                     A_oor<=A;
                     B_oor<=B;
                     
                  
                     A_aand<='0';
                     B_aand<='0';
                     A_eeor<='0';
                     B_eeor<='0';
                     A_xxnor<='0';
                     B_xxnor<='0';
                     A_nnand<='0';
                     B_nnand<='0';
                     A_nnor<='0';
                     B_nnor<='0';
                     
           when "0001"=>
                     A_aand<=A;
                     B_aand<=B;
                     A_oor<='0';
                     B_oor<='0';
                     
                     A_eeor<='0';
                     B_eeor<='0';
                     A_xxnor<='0';
                     B_xxnor<='0';
                     A_nnand<='0';
                     B_nnand<='0';
                     A_nnor<='0';
                     B_nnor<='0';
                     
          when "0010"=>
                     A_eeor<=A;
                     B_eeor<=B;
                        A_aand<='0';
                     B_aand<='0';
                     A_oor<='0';
                     B_oor<='0';
                   
                     A_xxnor<='0';
                     B_xxnor<='0';
                     A_nnand<='0';
                     B_nnand<='0';
                     A_nnor<='0';
                     B_nnor<='0';
                     
          when "0011"=>
                     A_xxnor<=A;
                     B_xxnor<=B;
                        A_aand<='0';
                     B_aand<='0';
                     A_oor<='0';
                     B_oor<='0';
                     A_eeor<='0';
                     B_eeor<='0';
                    
                     A_nnand<='0';
                     B_nnand<='0';
                     A_nnor<='0';
                     B_nnor<='0';
          when "0100"=>
                     A_nnand<=A;
                     B_nnand<=B;
                         A_aand<='0';
                     B_aand<='0';
                     A_oor<='0';
                     B_oor<='0';
                     A_eeor<='0';
                     B_eeor<='0';
                     A_xxnor<='0';
                     B_xxnor<='0';
                    
                     A_nnor<='0';
                     B_nnor<='0';
                     
        when "0101"=>
                    A_nnor<=A;
                    B_nnor<=B;
                      A_aand<='0';
                     B_aand<='0';
                     A_oor<='0';
                     B_oor<='0';
                     A_eeor<='0';
                     B_eeor<='0';
                     A_xxnor<='0';
                     B_xxnor<='0';
                     A_nnand<='0';
                     B_nnand<='0';
                     
                         
                     
    when others=>
      A_aand<='0';
                     B_aand<='0';
                     A_oor<='0';
                     B_oor<='0';
                     A_eeor<='0';
                     B_eeor<='0';
                     A_xxnor<='0';
                     B_xxnor<='0';
                     A_nnand<='0';
                     B_nnand<='0';
                     A_nnor<='0';
                     B_nnor<='0';
                     
           end case;
         end if;
         end process;
       end;
--------------------------------------------------------------------------
  library ieee;
use ieee.std_logic_1164.all;
entity mux_logic_out is
  port(clk,reset:in std_logic;
       con:in std_logic_vector(3 downto 0);
       cout_aand:in std_logic;
       cout_oor:in std_logic;
       cout_eeor:in std_logic;
       cout_xxnor:in std_logic;
       cout_nnand:in std_logic;
       cout_nnor:in std_logic;
       cout_logic:out std_logic
       );
     end;
     architecture RTL of mux_logic_out is
     begin
       process(clk,reset)
         begin
           if reset='0' then
             cout_logic<='0';
           elsif clk'event and clk='1' then
           case con is
           when "0000"=> 
                      cout_logic<=cout_oor;
            when "0001"=>
                     cout_logic<=cout_aand;
            when "0010"=>
                     cout_logic<=cout_eeor;
            when "0011"=>
                     cout_logic<=cout_xxnor;
            when "0100"=>
                     cout_logic<=cout_nnand;
            when "0101"=>
                     cout_logic<=cout_nnor;
            when others=>
                     cout_logic<='0';
          end case;
        end if;
         end process;
       end;
-----------------------------------------------------------
     

library ieee;
use ieee.std_logic_1164.all;
entity top_logic is
  port(clk,reset:in std_logic;
       ain,bin:in std_logic;
       control_pin:in std_logic_vector(3 downto 0);
       cout:out std_logic);
     end;
     architecture RTL of top_logic is
     component mux_logic 
  port(clk,reset:in std_logic;
       A,b:in std_logic;
       con:in std_logic_vector(3 downto 0);
       A_aand:out std_logic;
       B_aand:out std_logic;
       A_oor:out std_logic;
       B_oor:out std_logic;
       A_eeor:out std_logic;
       B_eeor:out std_logic;
       A_xxnor:out std_logic;
       B_xxnor:out std_logic;
       A_nnand:out std_logic;
       B_nnand:out std_logic;
       A_nnor:out std_logic;
       B_nnor:out std_logic
       );
     end component;
     
     component top
  port(clk,reset:in std_logic;
       a,b:in std_logic;
       and_cout:out std_logic;
       nand_cout:out std_logic;
       or_cout:out std_logic;
       nor_cout:out std_logic;
       xor_cout:out std_logic;
       xnor_cout:out std_logic);
     end component;
     
     component mux_logic_out 
  port(clk,reset:in std_logic;
       con:in std_logic_vector(3 downto 0);
       cout_aand:in std_logic;
       cout_oor:in std_logic;
       cout_eeor:in std_logic;
       cout_xxnor:in std_logic;
       cout_nnand:in std_logic;
       cout_nnor:in std_logic;
       cout_logic:out std_logic
       );
     end component;
         signal cout_aand,cout_oor,cout_eeor,cout_xxnor,cout_nnand,cout_nnor:std_logic;
      
     
     begin
       --c01:mux_logic 
--  port map(clk=>clk,
--           reset=>reset,
--           A=>ain,
--           b=>bin,
--           con=>control_pin,
--       A_aand=>t_aand,
--       B_aand=>s_aand,
--       A_oor=>t_oor,
--       B_oor=>s_oor,
--       A_eeor=>t_eeor,
--       B_eeor=>s_eeor,
--       A_xxnor=>t_xxnor,
--       B_xxnor=>s_xxnor,
--       A_nnand=>t_nnand,
--       B_nnand=>s_nnand,
--       A_nnor=>t_nnor,
--       B_nnor=>s_nnor
--       );
--    

  coo1: top
  port map(clk=>clk,
       reset=>reset,
       a=>ain,
       b=>bin,
       and_cout=>cout_aand,
       nand_cout=>cout_nnand,
       or_cout=>cout_oor,
       nor_cout=>cout_nnor,
       xor_cout=>cout_eeor,
       xnor_cout=>cout_xxnor);
     
      c08:    mux_logic_out 
  port map(clk=>clk,
           reset=>reset,
       con=>control_pin,
       cout_aand=>cout_aand,
       cout_oor=>cout_oor,
       cout_eeor=>cout_eeor,
       cout_xxnor=>cout_xxnor,
       cout_nnand=>cout_nnand,
       cout_nnor=>cout_nnor,
       cout_logic=>cout
       );
     end;


