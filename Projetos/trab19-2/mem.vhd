-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- UFPR, BCC, ci210 2019-2 trabalho semestral, autor: Roberto Hexsel, 14nov
-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

use work.p_wires.all;

entity mem_prog is
  port (ender : in  reg7;
        instr : out reg32);

  type t_prog_mem is array (0 to 127) of reg32;

  -- memoria de programa contem somente 128 palavras
  constant program : t_prog_mem := (
    x"00000000", -- nop                         0x00

    x"800efffe", -- MAIN:  addi r14, 0,-2       0x01     inicializando pilha
    x"80040004", --        addi r4, 0, 0004     0x02     i <- 4
    x"c400000d", -- FOR:   bran r4,r0,FIM       0x03     (i == 0) -> FIM
    x"b040ffff", --        show r4              0x04     
    x"14020000", --        add a0,0,r4          0x05     a0 <- i
    x"80030004", --        addi a1,0,0004       0x06     a1 <- 4
    x"d00f000e", --        jal r15, POWER       0x07     Guarda o endereço de retorno e vai para POWER 
    x"1102ffff", --        add a0,v0,zero       0x08     a0 do log2 <- power(i, 4)
    x"d00f001c", --        jal r15, LOG2        0x09     Guarda o endereço de retorno e vai para POWER
    x"b010ffff", --        show v0              0x0a     
    x"8404ffff", --        addi r4, r4, -1      0x0b     i <- i - 1
    x"c0000003", --        bran 0, 0, FOR       0x0c     j for
    x"f0000000", -- FIM:   halt                 0x0d
  
    x"80050001", -- POWER: addi r5,0,1          0x0e     r5 <- 1
    x"c350001a", --        bran a1,r5,ELSE      0x0f     (exp == 1) -> ELSE
    x"8e0efffe", --        addi r14,r14,-2      0x10     abre um espaco no stack
    x"bef00000", --        st   r15, 0(r14)     0x11     guarda enderaco de retorno na stack     
    x"be300001", --        st   a1,  1(r14)     0x12     Guarda o exp na pilha
    x"8303ffff", --        addi a1, a1, -1      0x13     exp <- exp - 1
    x"d00f000e", --        jal POWER            0x14     
    x"31210000", --        mult v0, v0, a0      0x15     v0 <- n * power(n, exp - 1)
    x"ae0f0000", --        ld r15, 0(r14)       0x16     Voltando para o endereço anterior
    x"ae030001", --        ld  a1, 1(r14)       0x17     Atualiza o a1 para o valor certo
    x"8e0e0002", --        addi  r14, r14, 2    0x18     remove o espaco da stack
    x"ef000000", --        jr r15               0x19     Volta para o endereço anterior a função 
    x"10210000", -- ELSE:  add v0,0,a0          0x1a     v0 <- n
    x"ef000000", --        jr  r15              0x1b     Volta para o endereço anterior a função  

    x"80060001", -- LOG2:  r6, r0, 1            0x1c     r6 <- 1
    x"c2600028", --        bran a0, r6, THEN    0x1d     (n == 1) -> THEN
    x"8e0efffe", -- ELSE:  addi r14, r14, -2    0x1e     abre um espaco na stack
    x"bef00000", --        st r15, 0(sp)        0x1f     guarda enderaco de retorno na stack
    x"be200001", --        st a0, 1(r14)        0x20     Guarda o n na pilha
    x"92620000", --        sra a0, a0, r6       0x21     a0 <- n/2
    x"d00f001c", --        jal log2             0x22     
    x"81010001", --        addi v0, v0, 1       0x23     v0 <- 1 + v0
    x"ae0f0000", --        ld r15, 0(r14)       0x24     Voltando para o endereço anterior 
    x"ae020001", --        ld a0, 1(r14)        0x25     Atualiza o a1 para o valor certo 
    x"8e0e0002", --        addi r14, r14, 2     0x26     remove o espaco da stack
    x"ef000000", --        jr r15               0x27     Volta para o endereço anterior a função  
    x"10010000", -- THEN:  add v0, r0, r0       0x28     v0 <- 0
    x"ef000000", --        jr r15               0x29     Volta para o endereço anterior a função 

    x"00000000", 
    x"00000000",
    x"00000000",
    x"00000000",
    x"00000000",
    x"00000000",
    x"00000000",
    x"00000000",
    x"00000000",
    x"00000000",
    x"00000000",
    x"00000000",
    x"00000000",
    x"00000000",
    x"00000000",
    x"00000000",
    x"00000000",
    x"00000000",
    x"00000000",
    x"00000000",
    x"00000000",
    x"00000000",

    x"00000000",
    x"00000000",
    x"00000000",
    x"00000000",
    x"00000000",
    x"00000000",
    x"00000000",
    x"00000000",
    x"00000000",
    x"00000000",
    x"00000000",
    x"00000000",
    x"00000000",
    x"00000000",
    x"00000000",
    x"00000000",
    x"00000000",
    x"00000000",
    x"00000000",
    x"00000000",
    x"00000000",
    x"00000000",
    x"00000000",
    x"00000000",
    x"00000000",
    x"00000000",
    x"00000000",
    x"00000000",
    x"00000000",
    x"00000000",
    x"00000000",
    x"00000000",

    x"00000000",
    x"00000000",
    x"00000000",
    x"00000000",
    x"00000000",
    x"00000000",
    x"00000000",
    x"00000000",
    x"00000000",
    x"00000000",
    x"00000000",
    x"00000000",
    x"00000000",
    x"00000000",
    x"00000000",
    x"00000000",
    x"00000000",
    x"00000000",
    x"00000000",
    x"00000000",
    x"00000000",
    x"00000000",
    x"00000000",
    x"00000000",
    x"00000000",
    x"00000000",
    x"00000000",
    x"00000000",
    x"00000000",
    x"00000000",
    x"00000000",
    x"00000000"
  );


  function BV2INT7(S: reg7) return integer is
    variable result: integer;
  begin
    for i in S'range loop
      result := result * 2;
      if S(i) = '1' then
        result := result + 1;
      end if;
    end loop;
    return result;
  end BV2INT7;
  
end mem_prog;

-- nao altere esta arquitetura
architecture tabela of mem_prog is
begin  -- tabela

  instr <= program( BV2INT7(ender) );

end tabela;

