-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- UFPR, BCC, ci210 2013-2, autor: Roberto Hexsel, 25ago2016
-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- mux2(a,b,s,z)
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
use work.p_wires.all;

entity mux2 is
  port(A,B : in  bit;                   -- entradas de dados
       S   : in  bit;                   -- entrada de selecao
       Z   : out bit);                  -- saida
end mux2;

architecture estrut of mux2 is 

  -- declara componentes que sao instanciados
  component inv is
    generic (prop : time; cont : time);
    port(A : in bit; S : out bit);
  end component inv;

  component nand2 is
    generic (prop : time; cont : time);
    port(A,B : in bit; S : out bit);
  end component nand2;

  component nor2 is
    generic (prop : time; cont : time);
    port(A,B : in bit; S : out bit);
  end component nor2;

  component nand3 is
    generic (prop : time; cont : time);
    port(A,B,C : in bit; S : out bit);
  end component nand3;


  signal p, q, r, t: bit;  -- sinais internos
  
begin  -- compare ligacoes dos sinais com diagrama das portas logicas

  Ui:  inv   generic map (t_inv,   t_cont) port map(s, r);
  Ua0: nand2 generic map (t_nand2, t_cont) port map(a, r, p);
  Ua1: nand2 generic map (t_nand2, t_cont) port map(b, s, q);
  Uor: nand2 generic map (t_nand2, t_cont) port map(p, q, z);

  --Ui:  inv   generic map (t_inv,   t_cont) port map(s, r);
  --Ua0: nand2 generic map (t_nand2, t_cont) port map(a, r, p);
  --Ua1: nand2 generic map (t_nand2, t_cont) port map(b, s, q);
  --Ua2: nand2 generic map (t_nand2, t_cont) port map(a, b, t);
  --Ua3: nand3 generic map (t_nand3, t_cont) port map(p, q, t, z);
  
end architecture estrut;
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- mux4(a,b,c,d,s0,s1,z)
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
use work.p_wires.all;

entity mux4 is
  port(A,B,C,D : in  bit;               -- quatro entradas de dados
       S0,S1   : in  bit;               -- dois sinais de selecao
       Z       : out bit);              -- saida
end mux4;

architecture estrut of mux4 is 

  component mux2 is
    port(A,B : in  bit; S : in  bit; Z : out bit);
  end component mux2;

  signal p,q,r : bit;                   -- sinais internos
begin

 	Umux1: mux2 port map(a, b, s0, p);
	Umux2: mux2 port map(c, d, s0, q);
	Umux3: mux2 port map(p, q, s1, z);

end architecture estrut;
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- mux8(a,b,c,d,e,f,g,h,s0,s1,s2,z)
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
use work.p_wires.all;

entity mux8 is
  port(A,B,C,D,E,F,G,H : in  bit;       -- oito entradas de dados
       S0,S1,S2        : in  bit;       -- tres sinais de controle
       Z               : out bit);      -- saida
end mux8;

architecture estrut of mux8 is 

  component mux2 is
    port(A,B : in  bit; S : in  bit; Z : out bit);
  end component mux2;

  component mux4 is
    port(A,B,C,D : in  bit; S0,S1 : in  bit; Z : out bit);
  end component mux4;

  signal p,q,r : bit;                   -- sinais internos
  
begin
  
  	Umux1: mux4 port map (a, b, c, d, s0, s1, p);
	Umux2: mux4 port map (e, f, g, h, s0, s1, q);
	Umux3: mux2 port map (p, q, s2, z);

end architecture estrut;
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	--architecture estrut of mux8when
	--	z <= a when (s="000") else
	--	     b when (s="001") else
	--	     c when (s="010") else
	--	     d when (s="011") else
	--	     e when (s="100") else
	--	     f when (s="101") else
	--	     g when (s="110") else
	--	     h;
	--end architecture mux8when
	-- escreva a arquitetura when-else do mux8 aqui
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	--architecture estrue of mux8select
	--with s select
	--	z<= a when "000"
	--	    b when "001"
	--	    c when "010"
	--	    d when "011"
	--	    e when "100"
	--	    f when "101"
	--	    g when "110"
	--	    h;
	--end architecture mux8select 
-- escreva a arquitetura with-select do mux8 aqui
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- mux8vet(entr(7downto0),sel(2downto1),z)
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
use work.p_wires.all;

entity mux8vet is
  port(entr : in  reg8;
       sel  : in  reg3;
       Z    : out bit);
end mux8vet;

architecture estrut of mux8vet is 

  component mux2 is
    port(A,B : in  bit; S : in  bit; Z : out bit);
  end component mux2;

  component mux4 is
    port(A,B,C,D : in  bit; S0,S1 : in  bit; Z : out bit);
  end component mux4;

  signal p,q,r : bit;                   -- sinais internos
  
begin

 	Umux1: mux4 port map (entr (0), entr (1), entr (2), entr (3), sel (0), sel (1), p);
	Umux2: mux4 port map (entr (4), entr (5), entr (6), entr (7), sel (0), sel (1), q);
	Umux3: mux2 port map (p, q, sel (2), z);

end architecture estrut;
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++




-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- demux2(a,s,z,w)
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
use work.p_wires.all;

entity demux2 is
  port(A   : in  bit;
       S   : in  bit;
       Z,W : out bit);
end demux2;

architecture estrut of demux2 is 

 	component inv is
    	 generic (prop : time; cont : time);
    	 port(A : in bit; S : out bit);
  	end component inv;

	component nand2 is
     	 generic (prop : time; cont : time);
     	 port(A,B : in bit; S : out bit);
  	end component nand2;

	signal p,q,r : bit;
  
begin

	Uinv: inv generic map (t_inv, t_cont) port map (s,p);
	Unand1: nand2 generic map (t_nand2, t_cont) port map (a, p, q); 
  	Unand2: nand2 generic map (t_nand2, t_cont) port map (a, s, r);
	Uinv2: inv generic map (t_inv, t_cont) port map (q, z);
	Uinv3: inv generic map (t_inv, t_cont) port map (r, w);

end architecture estrut;
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- demux4(a,s0,s1,x,y,z,w)
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
use work.p_wires.all;

entity demux4 is
  port(A       : in  bit;
       S0,S1   : in  bit;
       X,Y,Z,W : out bit);
end demux4;

architecture estrut of demux4 is

  	component demux2 is
	 port (A : in bit; S : in bit; Z,W : out bit);
	end component demux2;

	signal p,q : bit; 

begin

  	Udemux1: demux2 port map (a, s1, p, q);
	Udemux2: demux2 port map (p, s0, x, y);
	Udemux3: demux2 port map (q, s0, z, w);

end architecture estrut;
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- demux8(a,s0,s1,s2,p,q,r,s,t,u,v,w)
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
use work.p_wires.all;

entity demux8 is
  port(A               : in  bit;
       s0,s1,s2        : in  bit;
       P,Q,R,S,T,U,V,W : out bit);
end demux8;

architecture estrut of demux8 is

  	component demux2 is
	 port (A : in bit; S : in bit; Z,W : out bit);
	end component demux2;

	component demux4 is
	 port (A: in bit; S0,S1 : in bit; X, Y, Z, W : out bit);
	end component demux4;

	signal e,f : bit; 
  
begin

    	Udemux1 : demux2 port map (a, s2, e, f);
	Udemux2 : demux4 port map (e, s0, s1, p, q, r, s);
	Udemux3 : demux4 port map (f, s0, s1, t, u, v, w);
  
end architecture estrut;
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++



-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- decod2(s,z,w)
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
use work.p_wires.all;

entity decod2 is
  port(S   : in  bit;
       Z,W : out bit);
end decod2;

architecture estrut of decod2 is 

  	component inv is
    	generic (prop : time; cont : time);
     	port(A : in bit; S : out bit);
  	end component inv;

	signal a,b : bit;
  
begin

	Uinv : inv generic map (t_inv, t_cont) port map (s,z);
	w <= s;

end architecture estrut;
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- decod4(s0,s1,x,y,z,w)
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
use work.p_wires.all;

entity decod4 is
  port(S0,S1   : in  bit;
       X,Y,Z,W : out bit);
end decod4;

architecture estrut of decod4 is

  	component decod2 is
	 	port (S: in bit; Z, W: out bit);
	end component decod2;

	component demux2 is
		port (A : in bit; S : in bit; Z,W : out bit);
	end component demux2;

	signal a,b: bit;

begin
  
  	Udecod: decod2 port map (s1,a,b);
	Udemux1: demux2 port map (a,s0,x,y);
	Udemux2: demux2 port map (b,s0,z,w);

end architecture estrut;
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- decod8(s0,s1,s2,p,q,r,s,t,u,v,w)
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
use work.p_wires.all;

entity decod8 is
  port(S0,S1,S2        : in  bit;
       P,Q,R,S,T,U,V,W : out bit);
end decod8;

architecture estrut of decod8 is 

  	component decod2 is
		port (S: in bit; Z,W : out bit);
	end component decod2;

	component demux4 is
	  port (A: in bit; S0,S1 : in bit; X, Y, Z, W : out bit);
	end component demux4;

	signal a,b : bit;
  
begin

  	Udecod1 : decod2 port map (s2,a,b);
	Udemux1 : demux4 port map (a,s0,s1,p,q,r,s);
	Udemux2 : demux4 port map (b,s0,s1,t,u,v,w);

end architecture estrut;
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
