library ieee;
use ieee.std_logic_1164.all;
entity top_reverse is
port(clk,reset:in std_logic;
     op_code:in std_logic_vector(7 downto 0);
     ain_byte,bin_byte:in std_logic_vector(7 downto 0);
     ain_bit,bin_bit:in std_logic;
     cout_byte:out std_logic_vector(7 downto 0);
     cout_bit:out std_logic);
end;
architecture RTL of top_reverse is
component top_logic 
  port(clk,reset:in std_logic;
       ain,bin:in std_logic;
       control_pin:in std_logic_vector(3 downto 0);
       cout:out std_logic);
     end component;
component arith_logic 
  port(clk,reset:in std_logic;
       control_pin:in std_logic_vector(3 downto 0);
       ain:in std_logic_vector(7 downto 0);
       bin:in std_logic_vector(7 downto 0);
       cout:out std_logic_vector(7 downto 0));
 end component;
begin
c001:top_logic 
  port map(clk=>clk,
       reset=>reset,
       ain=>ain_bit,
       bin=>bin_bit,
       control_pin=>op_code(3 downto 0),
       cout=>cout_bit);
c002:arith_logic 
  port map(clk=>clk,
       reset=>reset,
       control_pin=>op_code(7 downto 4),
       ain=>ain_byte,
       bin=>bin_byte,
       cout=>cout_byte);
end;