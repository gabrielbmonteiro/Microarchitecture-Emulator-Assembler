 goto main
 wb 0
 
r ww 0  # resultado
b ww 2  # potencia (n)
c ww 10  # base (x)
u ww 1  # redutor de 1
d ww 0  # copia da base
e ww 0  # aux_copia

main add x, c
     mov x, d
     mov x, e
     sub x, d
     add x, b
     jz x, caso0
     sub x, u
     jz x, caso1
     mov x, b
     sub x, b
     goto mul

caso0 add x, u
      mov x, r
      halt

caso1 add x, e
      mov x, r
      halt

mul  add x, c
     jz x, pot
     sub x, c
     add x, d
     add x, r
     mov x, r
     sub x, r
     add x, c
     sub x, u
     mov x, c
     sub x, c
     goto mul

pot add x, b
    sub x, u
    jz x, final
    mov x, b
    sub x, b
    add x, e
    mov x, c
    sub x, c
    add x, r
    mov x, d
    sub x, d
    mov x, r
    goto mul

final halt 