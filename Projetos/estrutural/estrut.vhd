-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- UFPR, BCC, ci210 2013-2, autor: Roberto Hexsel, 03sep2016
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- mux2(a,b,s,z)
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
use work.p_wires.all;

entity mux2 is
  port(a,b : in  bit;                   -- entradas de dados
       s   : in  bit;                   -- entrada de selecao
       z   : out bit);                  -- saida
end mux2;

architecture estrut of mux2 is 

  -- declara componentes que sao instanciados
  component inv is
    port(A : in bit; S : out bit);
  end component inv;

  component nand2 is
    port(A,B : in bit; S : out bit);
  end component nand2;

  signal r, p, q : bit;              -- sinais internos
  
begin  -- compare ligacoes dos sinais com diagrama das portas logicas

  Ui:  inv   port map(s, r);
  Ua0: nand2 port map(a, r, p);
  Ua1: nand2 port map(b, s, q);
  Uor: nand2 port map(p, q, z);
    
end architecture estrut;
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- mux4(a,b,c,d,s0,s1,z)
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
use work.p_wires.all;

entity mux4 is
  port(a,b,c,d : in  bit;               -- quatro entradas de dados
       s0,s1   : in  bit;               -- dois sinais de selecao
       z       : out bit);              -- saida
end mux4;

architecture estrut of mux4 is 

  component mux2 is
    port(A,B : in  bit; S : in  bit; Z : out bit);
  end component mux2;

  signal p,q : bit;                     -- sinais internos
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
  port(a,b,c,d,e,f,g,h : in  bit;       -- oito entradas de dados
       s0,s1,s2        : in  bit;       -- tres sinais de controle
       z               : out bit);      -- saida
end mux8;

architecture estrut of mux8 is 

  component mux2 is
    port(A,B : in  bit; S : in  bit; Z : out bit);
  end component mux2;

  component mux4 is
    port(A,B,C,D : in  bit; S0,S1 : in  bit; Z : out bit);
  end component mux4;

  signal p,q : bit;                     -- sinais internos
  
begin
  
 	Umux1: mux4 port map (a, b, c, d, s0, s1, p);
	Umux2: mux4 port map (e, f, g, h, s0, s1, q);
	Umux3: mux2 port map (p, q, s2, z);

end architecture estrut;
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++



-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- mux8vet(entr(7downto0),sel(2downto1),z)
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
use work.p_wires.all;

entity mux8vet is
  port(entr : in  reg8;                 -- vetor de 8 bits
       sel  : in  reg3;                 -- vetor de 3 bits
       z    : out bit);
end mux8vet;

architecture estrut of mux8vet is 

  component mux2 is
    port(A,B : in  bit; S : in  bit; Z : out bit);
  end component mux2;

  component mux4 is
    port(A,B,C,D : in  bit; S0,S1 : in  bit; Z : out bit);
  end component mux4;

  signal p,q : bit;
  
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
  port(a   : in  bit;
       s   : in  bit;
       z,w : out bit);
end demux2;

architecture estrut of demux2 is

	component inv is
	 port (A : in bit; S : out bit);
	end component inv; 

	component nand2 is
	 port (A,B : in bit; S : out bit);
	end component nand2;

  -- declara componentes que sao instanciados
  	signal p,q,r : bit;             -- declare sinais internos, se precisar

begin
	Uinv: inv port map (s,p);
	Unand1: nand2 port map (a, p, q); 
  	Unand2: nand2 port map (a, s, r);
	Uinv2: inv port map (q, z);
	Uinv3: inv port map (r, w);
end architecture estrut;
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- demux4(a,s0,s1,x,y,z,w)
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
use work.p_wires.all;

entity demux4 is
  port(a       : in  bit;
       s0,s1   : in  bit;
       x,y,z,w : out bit);
end demux4;

architecture estrut of demux4 is

	component demux2 is
	 port (A : in bit; S : in bit; Z,W : out bit);
	end component demux2;
  -- declara componentes que sao instanciados

  signal p,q : bit;             -- declare sinais internos, se precisar

begin

	Udemux1: demux2 port map (a, s1, p, q);
	Udemux2: demux2 port map (p, s0, x, y);
	Udemux3: demux2 port map (q, s0, z, w);
  -- implemente com um demux2 e circuito(s) visto(s) nesta aula

end architecture estrut;
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- demux8(a,s0,s1,s2,p,q,r,s,t,u,v,w)
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
use work.p_wires.all;

entity demux8 is
  port(a               : in  bit;
       s0,s1,s2        : in  bit;
       p,q,r,s,t,u,v,w : out bit);
end demux8;

architecture estrut of demux8 is

	component demux2 is
	 port (A : in bit; S : in bit; Z,W : out bit);
	end component demux2;

	component demux4 is
	 port (A: in bit; S0,S1 : in bit; X, Y, Z, W : out bit);
	end component demux4;
  -- declara componentes que sao instanciados
  signal e,f : bit;             -- declare sinais internos, se precisar

begin

	Udemux1 : demux2 port map (a, s2, e, f);
	Udemux2 : demux4 port map (e, s0, s1, p, q, r, s);
	Udemux3 : demux4 port map (f, s0, s1, t, u, v, w);
  -- implemente com um demux2 e circuito(s) visto(s) nesta aula

end architecture estrut;
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++



-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- decod2(s,z,w)
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
use work.p_wires.all;

entity decod2 is
  port(s   : in  bit;
       z,w : out bit);
end decod2;

architecture estrut of decod2 is

	component inv is 
	port (A : in bit; S : out bit);
	end component inv;	
  -- declara componentes que sao instanciados

  signal a,b : bit;             -- declare sinais internos, se precisar

begin

	Uinv : inv port map (s,z);
	w <= s;
  -- implemente com portas logicas

end architecture estrut;
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- decod4(s0,s1,x,y,z,w)
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
use work.p_wires.all;

entity decod4 is
  port(s0,s1   : in  bit;
       x,y,z,w : out bit);
end decod4;

architecture estrut of decod4 is

	component decod2 is
	 	port (S: in bit; Z, W: out bit);
	end component decod2;

	component demux2 is
		port (A : in bit; S : in bit; Z,W : out bit);
	end component demux2;

	
  -- declara componentes que sao instanciados

  signal a,b: bit;             -- declare sinais internos, se precisar

begin

	Udecod: decod2 port map (s1,a,b);
	Udemux1: demux2 port map (a,s0,x,y);
	Udemux2: demux2 port map (b,s0,z,w);
  -- implemente com decod2 e circuito(s) visto(s) nesta aula

end architecture estrut;
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- decod8(s0,s1,s2,p,q,r,s,t,u,v,w)
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
use work.p_wires.all;

entity decod8 is
  port(s0,s1,s2        : in  bit;
       p,q,r,s,t,u,v,w : out bit);
end decod8;

architecture estrut of decod8 is

	component decod2 is
		port (S: in bit; Z,W : out bit);
	end component decod2;

	component demux4 is
	  port (A: in bit; S0,S1 : in bit; X, Y, Z, W : out bit);
	end component demux4;
  -- declara componentes que sao instanciados

  signal a,b : bit;       -- declare sinais internos, se precisar

begin
  	
	Udecod1 : decod2 port map (s2,a,b);
	Udemux1 : demux4 port map (a,s0,s1,p,q,r,s);
	Udemux2 : demux4 port map (b,s0,s1,t,u,v,w);
  -- implemente com decod2 e circuito(s) visto(s) nesta aula

end architecture estrut;
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

