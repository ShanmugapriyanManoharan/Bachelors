library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity toffoligate_and is
    Port ( a : in std_logic;
           b : in std_logic;
           p : out std_logic;
           q : out std_logic;
           r : out std_logic;
           inver_r : out std_logic);
end toffoligate_and;

architecture Behavioral of toffoligate_and is
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

entity fredkingate is
    Port ( a : in std_logic;
           b : in std_logic;
           p : out std_logic;
           q : out std_logic;
           r : out std_logic;
           inver_r:out std_logic);
end fredkingate;



architecture Behavioral of fredkingate is
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
     
   
     component toffoligate_and 
    Port ( a : in std_logic;
           b : in std_logic;
           p : out std_logic;
           q : out std_logic;
           r : out std_logic;
           inver_r : out std_logic);
end component; 

component fredkingate 
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
       c001:toffoligate_and 
    Port map ( a=>a,
           b =>b,
           p =>open,
           q =>open,
           r =>and_cout,
           inver_r=>nand_cout);
       coo2:fredkingate 
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