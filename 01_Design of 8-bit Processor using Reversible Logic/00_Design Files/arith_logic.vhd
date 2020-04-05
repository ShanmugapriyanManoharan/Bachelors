---------------------------------------------------
--------architecture name: toffoligate
--------date: 28/12/2013
---------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity toffoligate is
    Port ( a : in std_logic;
           b : in std_logic;
           p : out std_logic;
           q : out std_logic;
           r : out std_logic);
end toffoligate;

architecture Behavioral of toffoligate is

begin

	p <= a;
	q <= b;
	r <= (a and b)xor'0';

end Behavioral;

---------------------------------------------------
--------architecture name: fredkingate
--------date: 28/12/2013
---------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity fredkingate is
    Port ( a : in std_logic;
           b : in std_logic;
           p : out std_logic;
           q : out std_logic;
           r : out std_logic);
end fredkingate;

architecture Behavioral of fredkingate is

begin

	  p <= a;
	  q <=((not a)and '1')or(a and b); 
	  r <=(a and '1')or((not a)and b);
	  	
end Behavioral;



---------------------------------------------------
--------architecture name: ctsg_sub 
--------date: 28/12/2013
---------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity ctsg_sub is
    Port ( a : in std_logic;	  -- input bit
           b : in std_logic; 		--	input bit
           Cin : in std_logic;	-- carry
           p : out std_logic;	
           q : out std_logic;
           r : out std_logic;		 -- out bit sum
           s : out std_logic;			  -- outbit	 carry
           w : out std_logic);
end ctsg_sub;

architecture Behavioral of ctsg_sub is

begin
 	p <= a ;
	q <= a xor b;
	
	r <= a xor b xor Cin;		  -- sum
  	s <=((not(a xor b))and Cin) xor ((not a) and b); -- carry
	
	w <=	a xor b xor Cin xor '1';

end Behavioral;


---------------------------------------------------
--------architecture name: twopairrail
--------date: 28/12/2013
---------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity twopairrail is
    Port ( x0 : in std_logic;
           y0 : in std_logic;
			  x1 : in std_logic;
           y1 : in std_logic;
           e1 : out std_logic;
           e2 : out std_logic);
end twopairrail;

architecture Behavioral of twopairrail is
component toffoligate
    Port ( a : in std_logic;
           b : in std_logic;
           p : out std_logic;
           q : out std_logic;
           r : out std_logic);
end component;
component fredkingate
    Port ( a : in std_logic;
           b : in std_logic;
           p : out std_logic;
           q : out std_logic;
           r : out std_logic);
end component;
signal v1,v2,v3,v4,v5,v6: std_logic;
signal z1,z2 :std_logic;

begin
A1: toffoligate port map(x0,x1,v1,v2,v3);
A2: toffoligate port map(y0,y1,v4,v5,v6);
A3: toffoligate port map(v1,v5,open,open,z1);
A4: toffoligate port map(v4,v2,open,open,z2);

A5: fredkingate port map(z1,z2,open,open,e1);
A6: fredkingate port map(v3,v6,open,open,e2);


end Behavioral;



library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;



entity ctsg is
    Port ( a : in std_logic;	  -- input bit
           b : in std_logic; 		--	input bit
           Cin : in std_logic;	-- carry
           p : out std_logic;	
           q : out std_logic;
           r : out std_logic;		 -- out bit sum
           s : out std_logic;			  -- outbit	 carry
           w : out std_logic);
end ctsg;

architecture Behavioral of ctsg is

begin
 	p <= a ;
	q <= a xor b;
	
	r <= a xor b xor Cin;		  -- sum
  	s <=((a xor b)and Cin) xor (a and b); -- carry
	
	w <=	a xor b xor Cin xor '1';

end Behavioral;


---------------------------------------------------
--------architecture name: ripplecarryad
--------date: 28/12/2013
---------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;



entity ripplecarryad is
	  port( x : in std_logic_vector(3 downto 0);
           y : in std_logic_vector(3 downto 0);
           Cin : in std_logic;
			  s :out std_logic_vector(3 downto 0);
			  Cout:out std_logic;
			  z: out std_logic_vector(3 downto 0);
		 	  d: out std_logic_vector(3 downto 0);
			  ee1,ee2: out std_logic);
			  
end ripplecarryad;

architecture Behavioral of ripplecarryad is

signal c:std_logic_vector(3 downto 0);
signal r,w :std_logic_vector(3 downto 0);
signal e1,e2,e3,e4:std_logic;
component ctsg
 Port ( a : in std_logic;
        b : in std_logic;
        Cin : in std_logic;
        p : out std_logic;
        q : out std_logic;
        r : out std_logic;
        s : out std_logic;
        w : out std_logic);
end component; 
component twopairrail
  Port ( x0 : in std_logic;
           y0 : in std_logic;
			  x1 : in std_logic;
           y1 : in std_logic;
           e1 : out std_logic;
           e2 : out std_logic);
end component;	  		   
begin

    C1: ctsg port map(y(0),x(0),Cin,open,open,r(0),c(0),w(0)); 
	 C2: ctsg port map(y(1),x(1),c(0),open,open,r(1),c(1),w(1));
	 C3: ctsg port map(y(2),x(2),c(1),open,open,r(2),c(2),w(2));
	 C4: ctsg port map(y(3),x(3),c(2),open,open,r(3),c(3),w(3));
 	
	  Cout <= c(3);
	  s(0) <= r(0); 
	  s(1) <= r(1);
	  s(2) <= r(2);
	  s(3) <= r(3);
	  z(3 downto 0) <= r(3 downto 0);
	  d(3 downto 0) <= w(3 downto 0);

T1 : twopairrail port map(r(0),w(0),r(1),w(1),e1,e2);
T2 : twopairrail port map(r(2),w(2),r(3),w(3),e3,e4);
T3  : twopairrail port map(e1,e2,e3,e4,ee1,ee2);



end Behavioral;


---------------------------------------------------
--------architecture name: ripplecarrysub_8x8 
--------date: 28/12/2013
---------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity ripplecarrysub_8x8 is
	  port( x : in std_logic_vector(7 downto 0);
           y : in std_logic_vector(7 downto 0);
           Cin : in std_logic;
			  s :out std_logic_vector(7 downto 0);
			  Cout:out std_logic;
			  z: out std_logic_vector(7 downto 0);
		 	  d: out std_logic_vector(7 downto 0);
			  er1,er2: out std_logic);
			  
end ripplecarrysub_8x8;

architecture Behavioral of ripplecarrysub_8x8 is

signal c:std_logic_vector(7 downto 0);
signal r,w :std_logic_vector(7 downto 0);
signal e1,e2,e3,e4,e5,e6,e7,e8,e9,e10,ee1,ee2,ee3,ee4 : std_logic := '0';
component ctsg_sub
 Port ( a : in std_logic;
        b : in std_logic;
        Cin : in std_logic;
        p : out std_logic;
        q : out std_logic;
        r : out std_logic;
        s : out std_logic;
        w : out std_logic);
end component; 
component twopairrail
  Port ( x0 : in std_logic;
           y0 : in std_logic;
			  x1 : in std_logic;
           y1 : in std_logic;
           e1 : out std_logic;
           e2 : out std_logic);
end component;	  		   
begin

    C1: ctsg_sub port map(y(0),x(0),Cin,open,open,r(0),c(0),w(0)); 
	 C2: ctsg_sub port map(y(1),x(1),c(0),open,open,r(1),c(1),w(1));
	 C3: ctsg_sub port map(y(2),x(2),c(1),open,open,r(2),c(2),w(2));
	 C4: ctsg_sub port map(y(3),x(3),c(2),open,open,r(3),c(3),w(3));
    C5: ctsg_sub port map(y(4),x(4),c(3),open,open,r(4),c(4),w(4)); 
	 C6: ctsg_sub port map(y(5),x(5),c(4),open,open,r(5),c(5),w(5));
	 C7: ctsg_sub port map(y(6),x(6),c(5),open,open,r(6),c(6),w(6));
	 C8: ctsg_sub port map(y(7),x(7),c(6),open,open,r(7),c(7),w(7));
 	
	  Cout <= c(7);
	  s(0) <= r(0); 
	  s(1) <= r(1);
	  s(2) <= r(2);
	  s(3) <= r(3);
	  s(4) <= r(4); 
	  s(5) <= r(5);
	  s(6) <= r(6);
	  s(7) <= r(7);
	  z(7 downto 0) <= r(7 downto 0);
	  d(7 downto 0) <= w(7 downto 0);

T1 : twopairrail port map(r(0),w(0),r(1),w(1),e1,e2);
T2 : twopairrail port map(r(2),w(2),r(3),w(3),e3,e4);
T3 : twopairrail port map(r(4),w(4),r(5),w(5),e5,e6);
T4 : twopairrail port map(r(6),w(6),r(7),w(7),e7,e8);

T5 : twopairrail port map(e1,e2,e3,e4,ee1,ee2);
T6 : twopairrail port map(e5,e6,e7,e8,ee3,ee4);
T7 : twopairrail port map(ee1,ee2,ee3,ee4,er1,er2);



end Behavioral;


---------------------------------------------------
--------architecture name: ripplecarryad_8x8 
--------date: 28/12/2013
---------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity ripplecarryad_8x8 is
	  port( x : in std_logic_vector(7 downto 0);
           y : in std_logic_vector(7 downto 0);
           Cin : in std_logic;
			  s :out std_logic_vector(7 downto 0);
			  Cout:out std_logic;
			  z: out std_logic_vector(7 downto 0);
		 	  d: out std_logic_vector(7 downto 0);
			  er1,er2: out std_logic);
			  
end ripplecarryad_8x8;

architecture Behavioral of ripplecarryad_8x8 is

signal c:std_logic_vector(7 downto 0);
signal r,w :std_logic_vector(7 downto 0);
signal e1,e2,e3,e4,e5,e6,e7,e8,e9,e10,ee1,ee2,ee3,ee4 : std_logic := '0';
component ctsg
 Port ( a : in std_logic;
        b : in std_logic;
        Cin : in std_logic;
        p : out std_logic;
        q : out std_logic;
        r : out std_logic;
        s : out std_logic;
        w : out std_logic);
end component; 
component twopairrail
  Port ( x0 : in std_logic;
           y0 : in std_logic;
			  x1 : in std_logic;
           y1 : in std_logic;
           e1 : out std_logic;
           e2 : out std_logic);
end component;	  		   
begin

    C1: ctsg port map(y(0),x(0),Cin,open,open,r(0),c(0),w(0)); 
	 C2: ctsg port map(y(1),x(1),c(0),open,open,r(1),c(1),w(1));
	 C3: ctsg port map(y(2),x(2),c(1),open,open,r(2),c(2),w(2));
	 C4: ctsg port map(y(3),x(3),c(2),open,open,r(3),c(3),w(3));
    C5: ctsg port map(y(4),x(4),c(3),open,open,r(4),c(4),w(4)); 
	 C6: ctsg port map(y(5),x(5),c(4),open,open,r(5),c(5),w(5));
	 C7: ctsg port map(y(6),x(6),c(5),open,open,r(6),c(6),w(6));
	 C8: ctsg port map(y(7),x(7),c(6),open,open,r(7),c(7),w(7));
 	
	  Cout <= c(7);
	  s(0) <= r(0); 
	  s(1) <= r(1);
	  s(2) <= r(2);
	  s(3) <= r(3);
	  s(4) <= r(4); 
	  s(5) <= r(5);
	  s(6) <= r(6);
	  s(7) <= r(7);
	  z(7 downto 0) <= r(7 downto 0);
	  d(7 downto 0) <= w(7 downto 0);

T1 : twopairrail port map(r(0),w(0),r(1),w(1),e1,e2);
T2 : twopairrail port map(r(2),w(2),r(3),w(3),e3,e4);
T3 : twopairrail port map(r(4),w(4),r(5),w(5),e5,e6);
T4 : twopairrail port map(r(6),w(6),r(7),w(7),e7,e8);

T5 : twopairrail port map(e1,e2,e3,e4,ee1,ee2);
T6 : twopairrail port map(e5,e6,e7,e8,ee3,ee4);
T7 : twopairrail port map(ee1,ee2,ee3,ee4,er1,er2);



end Behavioral;

---------------------------------------------------
--------architecture name: mux_logic_out
--------date: 28/12/2013
---------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
entity mux_logic_out_byte is
  port(clk,reset:in std_logic;
       con:in std_logic_vector(3 downto 0);
       cout_aand:in std_logic_vector(7 downto 0);
       cout_oor:in std_logic_vector(7 downto 0);
       cout_eeor:in std_logic_vector(7 downto 0);
       cout_xxnor:in std_logic_vector(7 downto 0);
       cout_nnand:in std_logic_vector(7 downto 0);
       cout_nnor:in std_logic_vector(7 downto 0);
       cout_logic:out std_logic_vector(7 downto 0)
       );
     end;
     architecture RTL of mux_logic_out_byte is
     begin
       process(clk,reset)
         begin
           if reset='0' then
             cout_logic<=(others=>'0');
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
    
                    cout_logic<=(others=>'0');
                     
                     
           end case;
   end if;
         end process;
       end;


---------------------------------------------------
--------architecture name: mux
--------date: 28/12/2013
---------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
entity mux is
  port(clk,reset:in std_logic;
       A,b:in std_logic_vector(7 downto 0);
       con:in std_logic_vector(3 downto 0);
       A_bcd_adder:out std_logic_vector(7 downto 0);
       B_bcd_adder:out std_logic_vector(7 downto 0);
       A_carry_adder:out std_logic_vector(7 downto 0);
       B_carry_adder:out std_logic_vector(7 downto 0);
       A_ripple_adder:out std_logic_vector(7 downto 0);
       B_ripple_adder:out std_logic_vector(7 downto 0);
       A_bcd_sub:out std_logic_vector(7 downto 0);
       B_bcd_sub:out std_logic_vector(7 downto 0);
       A_carry_sub:out std_logic_vector(7 downto 0);
       B_carry_sub:out std_logic_vector(7 downto 0);
       A_ripple_sub:out std_logic_vector(7 downto 0);
       B_ripple_sub:out std_logic_vector(7 downto 0);
       A_comp:out std_logic_vector(7 downto 0);
       B_comp:out std_logic_vector(7 downto 0)
       );
     end;
     architecture RTL of mux is
     begin
       process(clk,reset)
         begin
          if reset='0' then
           A_bcd_adder<=(others=>'0');
           B_bcd_adder<=(others=>'0');
		
		a_carry_adder<=(others=>'0');
		b_carry_adder<=(others=>'0');
           B_carry_adder<=(others=>'0');
           A_ripple_adder<=(others=>'0');
           B_ripple_adder<=(others=>'0');
           A_bcd_sub<=(others=>'0');
           B_bcd_sub<=(others=>'0');
           A_carry_sub<=(others=>'0');
           B_carry_sub<=(others=>'0');
           A_ripple_sub<=(others=>'0');
           B_ripple_sub<=(others=>'0');
           A_comp<=(others=>'0');
           B_comp<=(others=>'0');
          elsif clk'event and clk='1' then

           case con is
           when "0000"=> 
                     A_bcd_adder<=A;
                     B_bcd_adder<=B;
                     
                     A_carry_adder<=(others=>'0');
                     B_carry_adder<=(others=>'0');
                     A_ripple_adder<=(others=>'0');
                     B_ripple_adder<=(others=>'0');
                     A_bcd_sub<=(others=>'0');
                     B_bcd_sub<=(others=>'0');
                     A_carry_sub<=(others=>'0');
                     B_carry_sub<=(others=>'0');
                     A_ripple_sub<=(others=>'0');
                     B_ripple_sub<=(others=>'0');
                     A_comp<=(others=>'0');
                     B_comp<=(others=>'0');
           when "0001"=>
                     A_carry_adder<=A;
                     B_carry_adder<=B;
                     A_bcd_adder<=(others=>'0');
                     B_bcd_adder<=(others=>'0');
                     A_ripple_adder<=(others=>'0');
                     B_ripple_adder<=(others=>'0');
                     A_bcd_sub<=(others=>'0');
                     B_bcd_sub<=(others=>'0');
                     A_carry_sub<=(others=>'0');
                     B_carry_sub<=(others=>'0');
                     A_ripple_sub<=(others=>'0');
                     B_ripple_sub<=(others=>'0');
                     A_comp<=(others=>'0');
                     B_comp<=(others=>'0');
          when "0010"=>
                     A_ripple_adder<=A;
                     B_ripple_adder<=B;
                     A_bcd_adder<=(others=>'0');
                     B_bcd_adder<=(others=>'0');
                     A_carry_adder<=(others=>'0');
                     B_carry_adder<=(others=>'0');
                     A_bcd_sub<=(others=>'0');
                     B_bcd_sub<=(others=>'0');
                     A_carry_sub<=(others=>'0');
                     B_carry_sub<=(others=>'0');
                     A_ripple_sub<=(others=>'0');
                     B_ripple_sub<=(others=>'0');
                     A_comp<=(others=>'0');
                     B_comp<=(others=>'0');
                     
          when "0011"=>
                     A_bcd_sub<=B;
                     B_bcd_sub<=A;
                     A_bcd_adder<=(others=>'0');
                     B_bcd_adder<=(others=>'0');
                     A_carry_adder<=(others=>'0');
                     B_carry_adder<=(others=>'0');
                     A_ripple_adder<=(others=>'0');
                     B_ripple_adder<=(others=>'0');
                     A_carry_sub<=(others=>'0');
                     B_carry_sub<=(others=>'0');
                     A_ripple_sub<=(others=>'0');
                     B_ripple_sub<=(others=>'0');
                     A_comp<=(others=>'0');
                     B_comp<=(others=>'0');
          when "0100"=>
                     A_carry_sub<=A;
                     B_carry_sub<=B;
                     A_bcd_adder<=(others=>'0');
                     B_bcd_adder<=(others=>'0');
                     A_carry_adder<=(others=>'0');
                     B_carry_adder<=(others=>'0');
                     A_ripple_adder<=(others=>'0');
                     B_ripple_adder<=(others=>'0');
                     A_bcd_sub<=(others=>'0');
                     B_bcd_sub<=(others=>'0');
                     A_ripple_sub<=(others=>'0');
                     B_ripple_sub<=(others=>'0');
                     A_comp<=(others=>'0');
                     B_comp<=(others=>'0');
                     
        when "0101"=>
                    A_ripple_sub<=A;
                    B_ripple_sub<=B;
                    A_bcd_adder<=(others=>'0');
                     B_bcd_adder<=(others=>'0');
                     A_carry_adder<=(others=>'0');
                     B_carry_adder<=(others=>'0');
                     A_ripple_adder<=(others=>'0');
                     B_ripple_adder<=(others=>'0');
                     A_bcd_sub<=(others=>'0');
                     B_bcd_sub<=(others=>'0');
                     A_carry_sub<=(others=>'0');
                     B_carry_sub<=(others=>'0');
                     A_comp<=(others=>'0');
                     B_comp<=(others=>'0');

      when "0111"=>
                    A_comp<=A;
                    B_comp<=B;
                    A_bcd_adder<=(others=>'0');
                     B_bcd_adder<=(others=>'0');
                     A_carry_adder<=(others=>'0');
                     B_carry_adder<=(others=>'0');
                     A_ripple_adder<=(others=>'0');
                     B_ripple_adder<=(others=>'0');
                     A_bcd_sub<=(others=>'0');
                     B_bcd_sub<=(others=>'0');
                     A_carry_sub<=(others=>'0');
                     B_carry_sub<=(others=>'0');
                     A_ripple_sub<=(others=>'0');
                     B_ripple_sub<=(others=>'0');
                     
    when others=>
      A_bcd_adder<=(others=>'0');
                     B_bcd_adder<=(others=>'0');
                     A_carry_adder<=(others=>'0');
                     B_carry_adder<=(others=>'0');
                     A_ripple_adder<=(others=>'0');
                     B_ripple_adder<=(others=>'0');
                     A_bcd_sub<=(others=>'0');
                     B_bcd_sub<=(others=>'0');
                     A_carry_sub<=(others=>'0');
                     B_carry_sub<=(others=>'0');
                     A_ripple_sub<=(others=>'0');
                     B_ripple_sub<=(others=>'0');
                     A_comp<=(others=>'0');
                     B_comp<=(others=>'0');
           end case;
         end if;
          end process;
       end;

---------------------------------------------------
--------architecture name: ctsg1
--------date: 28/12/2013
---------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity ctsg1 is
    Port ( a : in std_logic;	  -- input bit
           b : in std_logic; 		--	input bit
           Cin : in std_logic;	-- carry
           p : out std_logic;	
           q : out std_logic;
           r : out std_logic;		 -- out bit sum
           s : out std_logic;			  -- outbit	 carry
           w : out std_logic);
end ctsg1;

architecture Behavioral of ctsg1 is

begin
 	p <= a;
	q <= a xor b;
	r <= a xor b xor Cin  ;
	s <= ((a xor b)and Cin)xor(a and b);
	--((a and b)xor'1');
	w <=	a xor b xor Cin xor '1';

end Behavioral;


---------------------------------------------------
--------architecture name: carryskipsub_8x8
--------date: 28/12/2013
---------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity carryskipsub_8x8 is
    Port ( x : in std_logic_vector(7 downto 0);
           y : in std_logic_vector(7 downto 0);
           Cin : in std_logic;
           s:out std_logic_vector(7 downto 0);
			  Cout : out std_logic;
			  z : out std_logic_vector(21 downto 0);
			  d : out std_logic_vector(21 downto 0);
			  ee1,ee2:out std_logic);
end carryskipsub_8x8;

architecture Behavioral of carryskipsub_8x8 is
	 signal p,pcin:std_logic;
	 signal po,pcino:std_logic;
	 signal q :std_logic_vector(5 downto 0);
	 signal c: std_logic_vector(7 downto 0);
	 signal qq :std_logic_vector(5 downto 0);
	 signal cc: std_logic_vector(7 downto 0);
    signal r,w :std_logic_vector(10 downto 0);
    signal rr,ww :std_logic_vector(10 downto 0);
signal e10,e20,e30,e40,e50,e60,e70,e80,e90,e100,e110,e120,e130,e140,ee10,ee20 : std_logic;
signal e11,e21,e31,e41,e51,e61,e71,e81,e91,e101,e111,e121,e131,e141,ee11,ee21 : std_logic;

component ctsg_sub 
    Port ( a : in std_logic;
           b : in std_logic;
           Cin : in std_logic;
           p : out std_logic;
           q : out std_logic;
           r : out std_logic;
           s : out std_logic;
           w : out std_logic);
end component;

component ctsg1 
    Port ( a : in std_logic;
           b : in std_logic;
           Cin : in std_logic;
           p : out std_logic;
           q : out std_logic;
           r : out std_logic;
           s : out std_logic;
           w : out std_logic);
end component;

component twopairrail
  Port ( x0 : in std_logic;
           y0 : in std_logic;
			  x1 : in std_logic;
           y1 : in std_logic;
           e1 : out std_logic;
           e2 : out std_logic);
end component;

begin
-------------------------------------------------------------------------
	 cc0: ctsg_sub port map(Cin,'0','0',p,q(0),r(0),open,w(0));
    C10: ctsg_sub port map(y(0),x(0),p,open,q(1),r(1),c(0),w(1)); 
	 C20: ctsg_sub port map(y(1),x(1),c(0),open,q(2),r(2),c(1),w(2));
	 C30: ctsg_sub port map(y(2),x(2),c(1),open,q(3),r(3),c(2),w(3));
	 C40: ctsg_sub port map(y(3),x(3),c(2),open,q(4),r(4),c(3),w(4));
	 
	 C50: ctsg_sub port map(q(1),q(2),'0',open,open,r(5),c(4),w(5));
	 C60: ctsg_sub port map(q(3),q(4),'0',open,open,r(6),c(5),w(6));
	 
	 C70: ctsg_sub port map(c(4),c(5),'0',open,open,r(7),c(6),w(7));
	 C80: ctsg1 port map(c(6),q(0),'0',open,open,r(8),pcin,w(8));
	 
	 C90: ctsg_sub port map(c(3),'1','0',open,q(5),r(9),open,w(9));
	C100: ctsg1 port map(q(5),pcin,'0',open,open,r(10),c(7),w(10)); 
-------------------------------------------------------------------------
	 cc1: ctsg_sub port map(C(7),'0','0',po,qq(0),rr(0),open,ww(0));
    C11: ctsg_sub port map(y(4),x(4),po,open,qq(1),rr(1),cc(0),ww(1)); 
	 C21: ctsg_sub port map(y(5),x(5),cc(0),open,qq(2),rr(2),cc(1),ww(2));
	 C31: ctsg_sub port map(y(6),x(6),cc(1),open,qq(3),rr(3),cc(2),ww(3));
	 C41: ctsg_sub port map(y(7),x(7),cc(2),open,qq(4),rr(4),cc(3),ww(4));
	 
	 C51: ctsg_sub port map(qq(1),qq(2),'0',open,open,rr(5),cc(4),ww(5));
	 C61: ctsg_sub port map(qq(3),qq(4),'0',open,open,rr(6),cc(5),ww(6));
	 
	 C71: ctsg_sub port map(cc(4),cc(5),'0',open,open,rr(7),cc(6),ww(7));
	 C81: ctsg1 port map(cc(6),qq(0),'0',open,open,rr(8),pcino,ww(8));
	 
	 C91: ctsg_sub port map(cc(3),'1','0',open,qq(5),rr(9),open,ww(9));
	C101: ctsg1 port map(qq(5),pcino,'0',open,open,rr(10),cc(7),ww(10));
------------------------------------------------------------------------
	
	
   Cout <= cc(7);
	s(0) <= r(1);
   s(1) <= r(2);
	s(2) <= r(3);
	s(3) <= r(4);
	s(4) <= rr(1);
   s(5) <= rr(2);
	s(6) <= rr(3);
	s(7) <= rr(4);
	
	z(10 downto 0) <= r(10 downto 0);
	d(10 downto 0) <= w(10 downto 0);



T10 : twopairrail port map(r(0),w(0),r(1),w(1),e10,e20);
T20 : twopairrail port map(r(2),w(2),r(3),w(3),e30,e40);
T30 : twopairrail port map(r(4),w(4),r(5),w(5),e50,e60);
T40 : twopairrail port map(r(6),w(6),r(7),w(7),e70,e80);   
T50 : twopairrail port map(r(8),w(8),r(9),w(9),e90,e100);


T80  : twopairrail port map(e10,e20,e30,e40,e110,e120);
T90  : twopairrail port map(e50,e60,e70,e80,e130,e140);
T100 : twopairrail port map(e110,e120,e130,e140,ee10,ee20);


	z(21 downto 11) <= rr(10 downto 0);
	d(21 downto 11) <= ww(10 downto 0);


T11 : twopairrail port map(rr(0),ww(0),rr(1),ww(1),e11,e21);
T21 : twopairrail port map(rr(2),ww(2),rr(3),ww(3),e31,e41);
T31 : twopairrail port map(rr(4),ww(4),rr(5),ww(5),e51,e61);
T41 : twopairrail port map(rr(6),ww(6),rr(7),ww(7),e71,e81);   
T51 : twopairrail port map(rr(8),ww(8),rr(9),ww(9),e91,e101);


T81  : twopairrail port map(e11,e21,e31,e41,e111,e121);
T91  : twopairrail port map(e51,e61,e71,e81,e131,e141);
T101 : twopairrail port map(e111,e121,e131,e141,ee11,ee21);

TT101 : twopairrail port map(ee10,ee20,ee11,ee21,ee1,ee2);

end Behavioral;
--------------------------
-------------------------------
library ieee;
use ieee.std_logic_1164.all;
entity fb is
  port(a,b,c:in std_logic;
       diff,borrow:out std_logic);
     end;
     architecture RTL of fb is
     signal x,x1,x2,x3:std_logic;
     begin
       x<=a xor b;
       x1<= a and b;
       diff<=x xor c;
       x2<=not x and c;
       borrow<=x2 or x1;
       x3<=x2 xor x1;
     end;


---------------------------------------------------
--------architecture name: carryskipadd_8x8
--------date: 28/12/2013
---------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity carryskipadd_8x8 is
    Port ( x : in std_logic_vector(7 downto 0);
           y : in std_logic_vector(7 downto 0);
           Cin : in std_logic;
           s:out std_logic_vector(7 downto 0);
			  Cout : out std_logic;
			  z : out std_logic_vector(21 downto 0);
			  d : out std_logic_vector(21 downto 0);
			  ee1,ee2:out std_logic);
end carryskipadd_8x8;

architecture Behavioral of carryskipadd_8x8 is
	 signal p,pcin:std_logic;
	 signal po,pcino:std_logic;
	 signal q :std_logic_vector(5 downto 0);
	 signal c: std_logic_vector(7 downto 0);
	 signal qq :std_logic_vector(5 downto 0);
	 signal cc: std_logic_vector(7 downto 0);
    signal r,w :std_logic_vector(10 downto 0);
    signal rr,ww :std_logic_vector(10 downto 0);
signal e10,e20,e30,e40,e50,e60,e70,e80,e90,e100,e110,e120,e130,e140,ee10,ee20 : std_logic;
signal e11,e21,e31,e41,e51,e61,e71,e81,e91,e101,e111,e121,e131,e141,ee11,ee21 : std_logic;

component ctsg 
    Port ( a : in std_logic;
           b : in std_logic;
           Cin : in std_logic;
           p : out std_logic;
           q : out std_logic;
           r : out std_logic;
           s : out std_logic;
           w : out std_logic);
end component;

component ctsg1 
    Port ( a : in std_logic;
           b : in std_logic;
           Cin : in std_logic;
           p : out std_logic;
           q : out std_logic;
           r : out std_logic;
           s : out std_logic;
           w : out std_logic);
end component;

component twopairrail
  Port ( x0 : in std_logic;
           y0 : in std_logic;
			  x1 : in std_logic;
           y1 : in std_logic;
           e1 : out std_logic;
           e2 : out std_logic);
end component;

begin
-------------------------------------------------------------------------
	 cc0: ctsg port map(Cin,'0','0',p,q(0),r(0),open,w(0));
    C10: ctsg port map(y(0),x(0),p,open,q(1),r(1),c(0),w(1)); 
	 C20: ctsg port map(y(1),x(1),c(0),open,q(2),r(2),c(1),w(2));
	 C30: ctsg port map(y(2),x(2),c(1),open,q(3),r(3),c(2),w(3));
	 C40: ctsg port map(y(3),x(3),c(2),open,q(4),r(4),c(3),w(4));
	 
	 C50: ctsg port map(q(1),q(2),'0',open,open,r(5),c(4),w(5));
	 C60: ctsg port map(q(3),q(4),'0',open,open,r(6),c(5),w(6));
	 
	 C70: ctsg port map(c(4),c(5),'0',open,open,r(7),c(6),w(7));
	 C80: ctsg1 port map(c(6),q(0),'0',open,open,r(8),pcin,w(8));
	 
	 C90: ctsg port map(c(3),'1','0',open,q(5),r(9),open,w(9));
	C100: ctsg1 port map(q(5),pcin,'0',open,open,r(10),c(7),w(10)); 
-------------------------------------------------------------------------
	 cc1: ctsg port map(C(7),'0','0',po,qq(0),rr(0),open,ww(0));
    C11: ctsg port map(y(4),x(4),po,open,qq(1),rr(1),cc(0),ww(1)); 
	 C21: ctsg port map(y(5),x(5),cc(0),open,qq(2),rr(2),cc(1),ww(2));
	 C31: ctsg port map(y(6),x(6),cc(1),open,qq(3),rr(3),cc(2),ww(3));
	 C41: ctsg port map(y(7),x(7),cc(2),open,qq(4),rr(4),cc(3),ww(4));
	 
	 C51: ctsg port map(qq(1),qq(2),'0',open,open,rr(5),cc(4),ww(5));
	 C61: ctsg port map(qq(3),qq(4),'0',open,open,rr(6),cc(5),ww(6));
	 
	 C71: ctsg port map(cc(4),cc(5),'0',open,open,rr(7),cc(6),ww(7));
	 C81: ctsg1 port map(cc(6),qq(0),'0',open,open,rr(8),pcino,ww(8));
	 
	 C91: ctsg port map(cc(3),'1','0',open,qq(5),rr(9),open,ww(9));
	C101: ctsg1 port map(qq(5),pcino,'0',open,open,rr(10),cc(7),ww(10));
------------------------------------------------------------------------
	
	
   Cout <= cc(7);
	s(0) <= r(1);
   s(1) <= r(2);
	s(2) <= r(3);
	s(3) <= r(4);
	s(4) <= rr(1);
   s(5) <= rr(2);
	s(6) <= rr(3);
	s(7) <= rr(4);
	
	z(10 downto 0) <= r(10 downto 0);
	d(10 downto 0) <= w(10 downto 0);



T10 : twopairrail port map(r(0),w(0),r(1),w(1),e10,e20);
T20 : twopairrail port map(r(2),w(2),r(3),w(3),e30,e40);
T30 : twopairrail port map(r(4),w(4),r(5),w(5),e50,e60);
T40 : twopairrail port map(r(6),w(6),r(7),w(7),e70,e80);   
T50 : twopairrail port map(r(8),w(8),r(9),w(9),e90,e100);


T80  : twopairrail port map(e10,e20,e30,e40,e110,e120);
T90  : twopairrail port map(e50,e60,e70,e80,e130,e140);
T100 : twopairrail port map(e110,e120,e130,e140,ee10,ee20);


	z(21 downto 11) <= rr(10 downto 0);
	d(21 downto 11) <= ww(10 downto 0);


T11 : twopairrail port map(rr(0),ww(0),rr(1),ww(1),e11,e21);
T21 : twopairrail port map(rr(2),ww(2),rr(3),ww(3),e31,e41);
T31 : twopairrail port map(rr(4),ww(4),rr(5),ww(5),e51,e61);
T41 : twopairrail port map(rr(6),ww(6),rr(7),ww(7),e71,e81);   
T51 : twopairrail port map(rr(8),ww(8),rr(9),ww(9),e91,e101);


T81  : twopairrail port map(e11,e21,e31,e41,e111,e121);
T91  : twopairrail port map(e51,e61,e71,e81,e131,e141);
T101 : twopairrail port map(e111,e121,e131,e141,ee11,ee21);

TT101 : twopairrail port map(ee10,ee20,ee11,ee21,ee1,ee2);

end Behavioral;
----------------------------------------

---------------------------------------------------
--------architecture name: bcdadder
--------date: 28/12/2013
---------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity bcdadder is
    Port ( x : in std_logic_vector(3 downto 0);
           y : in std_logic_vector(3 downto 0);
           Cin : in std_logic;
           Cout : out std_logic;
			  ee1,ee2: out std_logic;
           s : out std_logic_vector(3 downto 0);
           z : out std_logic_vector(14 downto 0);
			  d : out std_logic_vector(14 downto 0));
			   
end bcdadder;

architecture Behavioral of bcdadder is

signal c : std_logic_vector(10 downto 1);
signal p : std_logic_vector(3 downto 0);
signal q : std_logic_vector(2 downto 0);
signal r,w : std_logic_vector(15 downto 1);
signal oc : std_logic;
signal e1,e2,e3,e4,e5,e6,e7,e8,e9,e10,e11,e12,e13,e14,e15,e16,e17,e18,e19,e20,e21,e22,e23,e24,e25,e26:std_logic;
component ctsg 
    Port ( a : in std_logic;
           b : in std_logic;
           Cin : in std_logic;
           p : out std_logic;
           q : out std_logic;
           r : out std_logic;
           s : out std_logic;
           w : out std_logic);
end component;

component ctsg1 
    Port ( a : in std_logic;
           b : in std_logic;
           Cin : in std_logic;
           p : out std_logic;
           q : out std_logic;
           r : out std_logic;
           s : out std_logic;
           w : out std_logic);
end component;

component twopairrail
  Port ( x0 : in std_logic;
           y0 : in std_logic;
			  x1 : in std_logic;
           y1 : in std_logic;
           e1 : out std_logic;
           e2 : out std_logic);
end component;

begin
	  A1: ctsg port map(x(0),y(0),Cin,open,open,r(1),c(1),w(1));
	  A2: ctsg port map(x(1),y(1),c(1),open,open,r(2),c(2),w(2));
	  A3: ctsg port map(x(2),y(2),c(2),open,open,r(3),c(3),w(3));
	  A4: ctsg port map(x(3),y(3),c(3),open,open,r(4),c(4),w(4));
	 
	  A5: ctsg port map(c(4),'1','0',open,q(2),r(5),open,w(5));
	  
	  A6: ctsg port map(r(2),'0','0',p(0),q(0),r(6),open,w(6)); 
	  A7: ctsg port map(r(3),'0','0',p(1),q(1),r(7),open,w(7));
	  
	  A8: ctsg1 port map(r(4),q(0),'0',p(2),open,r(8),c(5),w(8));
	  A9: ctsg1 port map(r(4),q(1),'0',p(3),open,r(9),c(6),w(9));
	  A10: ctsg port map(c(5),c(6),'0',open,open,r(10),c(7),w(10)); 
	  A11: ctsg1 port map(c(7),q(2),'0',open,open,r(11),oc,w(11));
		
	 A12: ctsg port map(r(1),'0','0',open,open,r(12),c(8),w(12));
	 A13: ctsg port map(p(0),oc,c(8),open,open,r(13),c(9),w(13));
	 A14: ctsg port map(p(1),oc,c(9),open,open,r(14),c(10),w(14));
	 A15: ctsg port map(r(4),'0',c(10),open,open,r(15),open,w(15));
	 
	 Cout <= oc; 
	 s(0) <= r(12);
	 s(1) <= r(13);
	 s(2) <= r(14);
	 s(3) <= r(15);
	 z(14 downto 0) <= r( 15 downto 1);
	 d(14 downto 0) <= w(15 downto 1);	  


T1 : twopairrail port map(r(1),w(1),r(2),w(2),e1,e2);

T2 : twopairrail port map(r(3),w(3),r(4),w(4),e3,e4);
T3 : twopairrail port map(r(5),w(5),r(6),w(6),e5,e6);
T4 : twopairrail port map(r(7),w(7),r(8),w(8),e7,e8);   

T5 : twopairrail port map(r(9),w(9),r(10),w(10),e9,e10);
T6 : twopairrail port map(r(11),w(11),r(12),w(12),e11,e12);
T7 : twopairrail port map(r(13),w(13),r(14),w(14),e13,e14);

T8  : twopairrail port map(e1,e2,e3,e4,e15,e16);
T9  : twopairrail port map(e5,e6,e7,e8,e17,e18);
T10 : twopairrail port map(e9,e10,e11,e12,e19,e20);

T11 : twopairrail port map(r(15),w(15),e13,e14,e21,e22);
T12 : twopairrail port map(e15,e16,e17,e18,e23,e24);   
T13 : twopairrail port map(e19,e20,e21,e22,e25,e26);  

T14 : twopairrail port map(e23,e24,e25,e26,ee1,ee2);  
 


end Behavioral;


---------------------------------------------------
--------architecture name: bcdsub_8x8
--------date: 28/12/2013
---------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity bcdsub_8x8 is
    Port ( x : in std_logic_vector(7 downto 0);
           y : in std_logic_vector(7 downto 0);
           Cin : in std_logic;
           Cout : out std_logic;
			  ee1,ee2: out std_logic;
           s : out std_logic_vector(7 downto 0);
           z : out std_logic_vector(29 downto 0);
			  d : out std_logic_vector(29 downto 0));
			   
end bcdsub_8x8;

architecture Behavioral of bcdsub_8x8 is


signal c:std_logic_vector(7 downto 0);
signal r,w :std_logic_vector(7 downto 0);
signal e1,e2,e3,e4,e5,e6,e7,e8,e9,e10,ee3,ee4,er1,er2,ee5,ee6 : std_logic := '0';
component ctsg_sub
 Port ( a : in std_logic;
        b : in std_logic;
        Cin : in std_logic;
        p : out std_logic;
        q : out std_logic;
        r : out std_logic;
        s : out std_logic;
        w : out std_logic);
end component; 
component twopairrail
  Port ( x0 : in std_logic;
           y0 : in std_logic;
			  x1 : in std_logic;
           y1 : in std_logic;
           e1 : out std_logic;
           e2 : out std_logic);
end component;	  		   
begin

    C1: ctsg_sub port map(y(0),x(0),Cin,open,open,r(0),c(0),w(0)); 
	 C2: ctsg_sub port map(y(1),x(1),c(0),open,open,r(1),c(1),w(1));
	 C3: ctsg_sub port map(y(2),x(2),c(1),open,open,r(2),c(2),w(2));
	 C4: ctsg_sub port map(y(3),x(3),c(2),open,open,r(3),c(3),w(3));
    C5: ctsg_sub port map(y(4),x(4),c(3),open,open,r(4),c(4),w(4)); 
	 C6: ctsg_sub port map(y(5),x(5),c(4),open,open,r(5),c(5),w(5));
	 C7: ctsg_sub port map(y(6),x(6),c(5),open,open,r(6),c(6),w(6));
	 C8: ctsg_sub port map(y(7),x(7),c(6),open,open,r(7),c(7),w(7));
 	
	  Cout <= c(7);
	  s(0) <= r(0); 
	  s(1) <= r(1);
	  s(2) <= r(2);
	  s(3) <= r(3);
	  s(4) <= r(4); 
	  s(5) <= r(5);
	  s(6) <= r(6);
	  s(7) <= r(7);
	  z(7 downto 0) <= r(7 downto 0);
	  d(7 downto 0) <= w(7 downto 0);

T1 : twopairrail port map(r(0),w(0),r(1),w(1),e1,e2);
T2 : twopairrail port map(r(2),w(2),r(3),w(3),e3,e4);
T3 : twopairrail port map(r(4),w(4),r(5),w(5),e5,e6);
T4 : twopairrail port map(r(6),w(6),r(7),w(7),e7,e8);

T5 : twopairrail port map(e1,e2,e3,e4,ee5,ee6);
T6 : twopairrail port map(e5,e6,e7,e8,ee3,ee4);
T7 : twopairrail port map(ee5,ee6,ee3,ee4,er1,er2);

end Behavioral;



---------------------------------------------------
--------architecture name: bcdadder
--------date: 28/12/2013
---------------------------------------------------



library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity bcdadder is
    Port ( x : in std_logic_vector(3 downto 0);
           y : in std_logic_vector(3 downto 0);
           Cin : in std_logic;
           Cout : out std_logic;
			  ee1,ee2: out std_logic;
           s : out std_logic_vector(3 downto 0);
           z : out std_logic_vector(14 downto 0);
			  d : out std_logic_vector(14 downto 0));
			   
end bcdadder;

architecture Behavioral of bcdadder is

signal c : std_logic_vector(10 downto 1);
signal p : std_logic_vector(3 downto 0);
signal q : std_logic_vector(2 downto 0);
signal r,w : std_logic_vector(15 downto 1);
signal oc : std_logic;
signal e1,e2,e3,e4,e5,e6,e7,e8,e9,e10,e11,e12,e13,e14,e15,e16,e17,e18,e19,e20,e21,e22,e23,e24,e25,e26:std_logic;
component ctsg 
    Port ( a : in std_logic;
           b : in std_logic;
           Cin : in std_logic;
           p : out std_logic;
           q : out std_logic;
           r : out std_logic;
           s : out std_logic;
           w : out std_logic);
end component;

component ctsg1 
    Port ( a : in std_logic;
           b : in std_logic;
           Cin : in std_logic;
           p : out std_logic;
           q : out std_logic;
           r : out std_logic;
           s : out std_logic;
           w : out std_logic);
end component;

component twopairrail
  Port ( x0 : in std_logic;
           y0 : in std_logic;
			  x1 : in std_logic;
           y1 : in std_logic;
           e1 : out std_logic;
           e2 : out std_logic);
end component;

begin
	  A1: ctsg port map(x(0),y(0),Cin,open,open,r(1),c(1),w(1));
	  A2: ctsg port map(x(1),y(1),c(1),open,open,r(2),c(2),w(2));
	  A3: ctsg port map(x(2),y(2),c(2),open,open,r(3),c(3),w(3));
	  A4: ctsg port map(x(3),y(3),c(3),open,open,r(4),c(4),w(4));
	 
	  A5: ctsg port map(c(4),'1','0',open,q(2),r(5),open,w(5));
	  
	  A6: ctsg port map(r(2),'0','0',p(0),q(0),r(6),open,w(6)); 
	  A7: ctsg port map(r(3),'0','0',p(1),q(1),r(7),open,w(7));
	  
	  A8: ctsg1 port map(r(4),q(0),'0',p(2),open,r(8),c(5),w(8));
	  A9: ctsg1 port map(r(4),q(1),'0',p(3),open,r(9),c(6),w(9));
	  A10: ctsg port map(c(5),c(6),'0',open,open,r(10),c(7),w(10)); 
	  A11: ctsg1 port map(c(7),q(2),'0',open,open,r(11),oc,w(11));
		
	 A12: ctsg port map(r(1),'0','0',open,open,r(12),c(8),w(12));
	 A13: ctsg port map(p(0),oc,c(8),open,open,r(13),c(9),w(13));
	 A14: ctsg port map(p(1),oc,c(9),open,open,r(14),c(10),w(14));
	 A15: ctsg port map(r(4),'0',c(10),open,open,r(15),open,w(15));
	 
	 Cout <= oc; 
	 s(0) <= r(12);
	 s(1) <= r(13);
	 s(2) <= r(14);
	 s(3) <= r(15);
	 z(14 downto 0) <= r( 15 downto 1);
	 d(14 downto 0) <= w(15 downto 1);	  


T1 : twopairrail port map(r(1),w(1),r(2),w(2),e1,e2);

T2 : twopairrail port map(r(3),w(3),r(4),w(4),e3,e4);
T3 : twopairrail port map(r(5),w(5),r(6),w(6),e5,e6);
T4 : twopairrail port map(r(7),w(7),r(8),w(8),e7,e8);   

T5 : twopairrail port map(r(9),w(9),r(10),w(10),e9,e10);
T6 : twopairrail port map(r(11),w(11),r(12),w(12),e11,e12);
T7 : twopairrail port map(r(13),w(13),r(14),w(14),e13,e14);

T8  : twopairrail port map(e1,e2,e3,e4,e15,e16);
T9  : twopairrail port map(e5,e6,e7,e8,e17,e18);
T10 : twopairrail port map(e9,e10,e11,e12,e19,e20);

T11 : twopairrail port map(r(15),w(15),e13,e14,e21,e22);
T12 : twopairrail port map(e15,e16,e17,e18,e23,e24);   
T13 : twopairrail port map(e19,e20,e21,e22,e25,e26);  

T14 : twopairrail port map(e23,e24,e25,e26,ee1,ee2);  
 


end Behavioral;
--------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity bcdadder_8x8 is
    Port ( x : in std_logic_vector(7 downto 0);
           y : in std_logic_vector(7 downto 0);
           Cin : in std_logic;
           Cout : out std_logic;
			  ee1,ee2: out std_logic;
           s : out std_logic_vector(7 downto 0);
           z : out std_logic_vector(29 downto 0);
			  d : out std_logic_vector(29 downto 0));
			   
end bcdadder_8x8;

architecture Behavioral of bcdadder_8x8 is

signal c : std_logic_vector(10 downto 1);
signal p : std_logic_vector(3 downto 0);
signal q : std_logic_vector(2 downto 0);
signal r,w : std_logic_vector(15 downto 1);
signal oc : std_logic;
signal e1,e2,e3,e4,e5,e6,e7,e8,e9,e10,e11,e12,e13,e14,e15,e16,e17,e18,e19,e20,e21,e22,e23,e24,e25,e26:std_logic;

signal cc : std_logic_vector(10 downto 1);
signal pp : std_logic_vector(3 downto 0);
signal qq : std_logic_vector(2 downto 0);
signal rr,ww : std_logic_vector(15 downto 1);
signal occ : std_logic;
signal f11,f21,f31,f41,f51,f61,f71,f81,f91,f101,f111,f121,f131,f141,f151,f161,f171,f181,f191,f201,f211,f221,f231,f241,f251,f261:std_logic;
signal ee11,ee21,ee10,ee20: std_logic;

component ctsg 
    Port ( a : in std_logic;
           b : in std_logic;
           Cin : in std_logic;
           p : out std_logic;
           q : out std_logic;
           r : out std_logic;
           s : out std_logic;
           w : out std_logic);
end component;

component ctsg1 
    Port ( a : in std_logic;
           b : in std_logic;
           Cin : in std_logic;
           p : out std_logic;
           q : out std_logic;
           r : out std_logic;
           s : out std_logic;
           w : out std_logic);
end component;

component twopairrail
  Port ( x0 : in std_logic;
           y0 : in std_logic;
			  x1 : in std_logic;
           y1 : in std_logic;
           e1 : out std_logic;
           e2 : out std_logic);
end component;

begin
    
	  A10: ctsg port map(x(0),y(0),Cin,open,open,r(1),c(1),w(1));
	  A20: ctsg port map(x(1),y(1),c(1),open,open,r(2),c(2),w(2));
	  A30: ctsg port map(x(2),y(2),c(2),open,open,r(3),c(3),w(3));
	  A40: ctsg port map(x(3),y(3),c(3),open,open,r(4),c(4),w(4));
	 
	  A50: ctsg port map(c(4),'1','0',open,q(2),r(5),open,w(5));
	  
	  A60: ctsg port map(r(2),'0','0',p(0),q(0),r(6),open,w(6)); 
	  A70: ctsg port map(r(3),'0','0',p(1),q(1),r(7),open,w(7));
	  
	  A80: ctsg1 port map(r(4),q(0),'0',p(2),open,r(8),c(5),w(8));
	  A90: ctsg1 port map(r(4),q(1),'0',p(3),open,r(9),c(6),w(9));
	  A100: ctsg port map(c(5),c(6),'0',open,open,r(10),c(7),w(10)); 
	  A110: ctsg1 port map(c(7),q(2),'0',open,open,r(11),oc,w(11));
		
	 A120: ctsg port map(r(1),'0','0',open,open,r(12),c(8),w(12));
	 A130: ctsg port map(p(0),oc,c(8),open,open,r(13),c(9),w(13));
	 A140: ctsg port map(p(1),oc,c(9),open,open,r(14),c(10),w(14));
	 A150: ctsg port map(r(4),'0',c(10),open,open,r(15),open,w(15));

 	  A11: ctsg port map(x(4),y(4),oc,open,open,rr(1),cc(1),ww(1));
	  A21: ctsg port map(x(5),y(5),cc(1),open,open,rr(2),cc(2),ww(2));
	  A31: ctsg port map(x(6),y(6),cc(2),open,open,rr(3),cc(3),ww(3));
	  A41: ctsg port map(x(7),y(7),cc(3),open,open,rr(4),cc(4),ww(4));
	 
	  A51: ctsg port map(cc(4),'1','0',open,qq(2),rr(5),open,ww(5));
	  
	  A61: ctsg port map(rr(2),'0','0',pp(0),qq(0),rr(6),open,ww(6)); 
	  A71: ctsg port map(rr(3),'0','0',pp(1),qq(1),rr(7),open,ww(7));
	  
	  A81: ctsg1 port map(rr(4),qq(0),'0',pp(2),open,rr(8),cc(5),ww(8));
	  A91: ctsg1 port map(rr(4),qq(1),'0',pp(3),open,rr(9),cc(6),ww(9));
	  A101: ctsg port map(cc(5),cc(6),'0',open,open,rr(10),cc(7),ww(10)); 
	  A111: ctsg1 port map(cc(7),qq(2),'0',open,open,rr(11),occ,ww(11));
		
	 A121: ctsg port map(rr(1),'0','0',open,open,rr(12),cc(8),ww(12));
	 A131: ctsg port map(pp(0),occ,cc(8),open,open,rr(13),cc(9),ww(13));
	 A141: ctsg port map(pp(1),occ,cc(9),open,open,rr(14),cc(10),ww(14));
	 A151: ctsg port map(rr(4),'0',cc(10),open,open,rr(15),open,ww(15));
	 
	 Cout <= occ; 
    s(0) <= r(12);
    s(1) <= r(13);
	 s(2) <= r(14);
	 s(3) <= r(15);
    s(4) <= rr(12);
    s(5) <= rr(13);
	 s(6) <= rr(14);
	 s(7) <= rr(15);
	 

 	 z(14 downto 0) <= r(15 downto 1);
	 d(14 downto 0) <= w(15 downto 1);
 	 z(29 downto 15) <= rr(15 downto 1);
	 d(29 downto 15) <= ww(15 downto 1);	  
	  


T1 : twopairrail port map(r(1),w(1),r(2),w(2),e1,e2);

T2 : twopairrail port map(r(3),w(3),r(4),w(4),e3,e4);
T3 : twopairrail port map(r(5),w(5),r(6),w(6),e5,e6);
T4 : twopairrail port map(r(7),w(7),r(8),w(8),e7,e8);   

T5 : twopairrail port map(r(9),w(9),r(10),w(10),e9,e10);
T6 : twopairrail port map(r(11),w(11),r(12),w(12),e11,e12);
T7 : twopairrail port map(r(13),w(13),r(14),w(14),e13,e14);

T8  : twopairrail port map(e1,e2,e3,e4,e15,e16);
T9  : twopairrail port map(e5,e6,e7,e8,e17,e18);
T10 : twopairrail port map(e9,e10,e11,e12,e19,e20);

T11 : twopairrail port map(r(15),w(15),e13,e14,e21,e22);
T12 : twopairrail port map(e15,e16,e17,e18,e23,e24);   
T13 : twopairrail port map(e19,e20,e21,e22,e25,e26);  

T14 : twopairrail port map(e23,e24,e25,e26,ee10,ee20);  


TT1 : twopairrail port map(rr(1),ww(1),rr(2),ww(2),f11,f21);

TT2 : twopairrail port map(rr(3),ww(3),rr(4),ww(4),f31,f41);
TT3 : twopairrail port map(rr(5),ww(5),rr(6),ww(6),f51,f61);
TT4 : twopairrail port map(rr(7),ww(7),rr(8),ww(8),f71,f81);   

TT5 : twopairrail port map(rr(9),ww(9),rr(10),ww(10),f91,f101);
TT6 : twopairrail port map(rr(11),ww(11),rr(12),ww(12),f111,f121);
TT7 : twopairrail port map(rr(13),ww(13),rr(14),ww(14),f131,f141);

TT8  : twopairrail port map(f11,f21,f31,f41,f151,f161);
TT9  : twopairrail port map(f51,f61,f71,f81,f171,f181);
TT10 : twopairrail port map(f91,f101,f111,f121,f191,f201);

TT11 : twopairrail port map(rr(15),ww(15),f131,f141,f211,f221);
TT12 : twopairrail port map(f151,f161,f171,f181,f231,f241);   
TT13 : twopairrail port map(f191,f201,f211,f221,f251,f261);  

TT14 : twopairrail port map(f231,f241,f251,f261,ee11,ee21);  
 
TTT14 : twopairrail port map(ee10,ee20,ee11,ee21,ee1,ee2);

end Behavioral;

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
             
             

--------------------------------------------



---------------------------------------------------
--------architecture name: arith_logic
--------date: 28/12/2013
---------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
entity arith_logic is
  port(clk,reset:in std_logic;
       control_pin:in std_logic_vector(3 downto 0);
       ain:in std_logic_vector(7 downto 0);
       bin:in std_logic_vector(7 downto 0);
       cout:out std_logic_vector(7 downto 0));
 end;

architecture RTL of arith_logic is
component bcdadder_8x8
    Port ( x : in std_logic_vector(7 downto 0);
           y : in std_logic_vector(7 downto 0);
           Cin : in std_logic;
           Cout : out std_logic;
		ee1,ee2: out std_logic;
           s : out std_logic_vector(7 downto 0);
           z : out std_logic_vector(29 downto 0);
		d : out std_logic_vector(29 downto 0));		   
end component;

component bcdsub_8x8 
    Port ( x : in std_logic_vector(7 downto 0);
           y : in std_logic_vector(7 downto 0);
           Cin : in std_logic;
           Cout : out std_logic;
		ee1,ee2: out std_logic;
           s : out std_logic_vector(7 downto 0);
           z : out std_logic_vector(29 downto 0);
		d : out std_logic_vector(29 downto 0));		   
end component;

component carryskipadd_8x8 
    Port ( x : in std_logic_vector(7 downto 0);
           y : in std_logic_vector(7 downto 0);
           Cin : in std_logic;
           s:out std_logic_vector(7 downto 0);
		Cout : out std_logic;
		z : out std_logic_vector(21 downto 0);
		d : out std_logic_vector(21 downto 0);
		ee1,ee2:out std_logic);
end component;

component carryskipsub_8x8 
    Port ( x : in std_logic_vector(7 downto 0);
           y : in std_logic_vector(7 downto 0);
           Cin : in std_logic;
           s:out std_logic_vector(7 downto 0);
		Cout : out std_logic;
		z : out std_logic_vector(21 downto 0);
		d : out std_logic_vector(21 downto 0);
		ee1,ee2:out std_logic);
end component;

component ripplecarryad_8x8 
	  port( x : in std_logic_vector(7 downto 0);
             y : in std_logic_vector(7 downto 0);
             Cin : in std_logic;
		  s :out std_logic_vector(7 downto 0);
		  Cout:out std_logic;
		  z: out std_logic_vector(7 downto 0);
		  d: out std_logic_vector(7 downto 0);
		  er1,er2: out std_logic);
 end component;
 
component ripplecarrysub_8x8 
	  port( x : in std_logic_vector(7 downto 0);
             y : in std_logic_vector(7 downto 0);
  	        Cin : in std_logic;
		  s :out std_logic_vector(7 downto 0);
		  Cout:out std_logic;
		  z: out std_logic_vector(7 downto 0);
		  d: out std_logic_vector(7 downto 0);
		  er1,er2: out std_logic);
 end component;

component mux 
  port(clk,reset:in std_logic;
       A,b:in std_logic_vector(7 downto 0);
       con:in std_logic_vector(3 downto 0);
       A_bcd_adder:out std_logic_vector(7 downto 0);
       B_bcd_adder:out std_logic_vector(7 downto 0);
       A_carry_adder:out std_logic_vector(7 downto 0);
       B_carry_adder:out std_logic_vector(7 downto 0);
       A_ripple_adder:out std_logic_vector(7 downto 0);
       B_ripple_adder:out std_logic_vector(7 downto 0);
       A_bcd_sub:out std_logic_vector(7 downto 0);
       B_bcd_sub:out std_logic_vector(7 downto 0);
       A_carry_sub:out std_logic_vector(7 downto 0);
       B_carry_sub:out std_logic_vector(7 downto 0);
       A_ripple_sub:out std_logic_vector(7 downto 0);
       B_ripple_sub:out std_logic_vector(7 downto 0);
       A_comp:out std_logic_vector(7 downto 0);
       B_comp:out std_logic_vector(7 downto 0)
       );
     end component;
component mux_logic_out_byte 
  port(clk,reset:in std_logic;
       con:in std_logic_vector(3 downto 0);
       cout_aand:in std_logic_vector(7 downto 0);
       cout_oor:in std_logic_vector(7 downto 0);
       cout_eeor:in std_logic_vector(7 downto 0);
       cout_xxnor:in std_logic_vector(7 downto 0);
       cout_nnand:in std_logic_vector(7 downto 0);
       cout_nnor:in std_logic_vector(7 downto 0);
       cout_logic:out std_logic_vector(7 downto 0)
       );
     end component;
     component bcd_6 
  port(clk,reset:in std_logic;
       datain:in std_logic_vector(7 downto 0);
       ain,bin:out std_logic_vector(7 downto 0));
     end component;
signal Cin:std_logic:='0';
signal ain_sub,bin_sub,cout_BCD_add_tmp,a_bcd_adder,b_bcd_adder,a_carry_adder,b_carry_adder,a_ripple_adder,b_ripple_adder,a_bcd_sub,b_bcd_sub,a_carry_sub,b_carry_sub,a_ripple_sub,b_ripple_sub:std_logic_vector(7 downto 0);
signal cout_BCD_add,cout_BCD_sub,cout_carry_add,cout_carry_sub,cout_ripple_add,cout_ripple_sub,a_comp,b_comp:std_logic_vector(7 downto 0);
begin

c00:mux 
  port map(clk=>clk,
       reset=>reset,
       A=>ain,
       b=>bin,
       con=>control_pin,
       A_bcd_adder=>a_bcd_adder,
       B_bcd_adder=>B_bcd_adder,
       A_carry_adder=>A_carry_adder,
       B_carry_adder=>B_carry_adder,
       A_ripple_adder=>A_ripple_adder,
       B_ripple_adder=>B_ripple_adder,
       A_bcd_sub=>A_bcd_sub,
       B_bcd_sub=>B_bcd_sub,
       A_carry_sub=>A_carry_sub,
       B_carry_sub=>B_carry_sub,
       A_ripple_sub=>A_ripple_sub,
       B_ripple_sub=>B_ripple_sub,
       A_comp=>A_comp,
       B_comp=>B_comp
       );
c01:bcdadder_8x8 
    Port map ( x =>a_bcd_adder,
           y =>b_bcd_adder,
           Cin =>Cin,
           Cout =>open,
		ee1=>open,
           ee2=>open,
           s =>cout_BCD_add_tmp,
           z =>open,
		d =>open);	
		
	c0001:bcd_6 
  port map(clk=>clk,
           reset=>reset,
           datain=>cout_BCD_add_tmp,
           ain=>ain_sub,
           bin=>bin_sub);
   c00006:ripplecarryad_8x8 
	  port map( x =>bin_sub,
             y =>ain_sub,
  	        Cin =>Cin,
		  s =>cout_BCD_add,
		  Cout=>open,
		  z=>open,
		  d=>open,
		  er1=>open,
             er2=>open);        
           
     
c02:bcdsub_8x8 
    Port map ( x =>A_bcd_sub,
           y =>B_bcd_sub,
           Cin =>Cin,
           Cout =>open,
		       ee1=>open,
           ee2=>open,
           s =>cout_BCD_sub,
           z =>open,
           d =>open);	   

		
c03:carryskipadd_8x8 
    Port map ( x =>A_carry_adder,
           y =>B_carry_adder,
           Cin =>Cin,
           s=>cout_carry_add,
		Cout=>open,
		z =>open,
		d =>open,
		ee1=>open,
           ee2=>open);
c04:carryskipsub_8x8 
    Port map( x =>B_carry_sub,
           y =>A_carry_sub,
           Cin=>Cin,
           s=>cout_carry_sub, 
		Cout=>open,
		z =>open,
		d =>open,
		ee1=>open,
		ee2=>open);
c05:ripplecarryad_8x8 
	  
	  port map( x=>A_ripple_adder,
             y=>B_ripple_adder,
             Cin=>Cin,
		  s =>cout_ripple_add,
		  Cout=>open,
		  z=>open,
		  d=>open,
		  er1=>open,
		  er2=>open);
c06:ripplecarrysub_8x8 
	  port map( x =>B_ripple_sub,
             y =>A_ripple_sub,
  	        Cin =>Cin,
		  s =>cout_ripple_sub,
		  Cout=>open,
		  z=>open,
		  d=>open,
		  er1=>open,
             er2=>open);
c07:mux_logic_out_byte 
  port map(clk=>clk,
       reset=>reset,
       con=>control_pin,
       cout_aand=>cout_carry_add,
       cout_oor=>cout_BCD_add,
       cout_eeor=>cout_ripple_add,
       cout_xxnor=>cout_BCD_sub,
       cout_nnand=>cout_carry_sub, 
       cout_nnor=>cout_ripple_sub,
       cout_logic=>cout
       );
end;




