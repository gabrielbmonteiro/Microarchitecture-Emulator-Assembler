 goto main
 wb 0
 
r ww 0  # resultado
c ww 10  # fatorial (n)
u ww 1  # redutor de 1
d ww 0  # cach
e ww 0  # contador

main add x, c
     jz x, caso0
     mov x, d
     mov x, e
     mov x, r
     sub x, r
     goto fat

caso0 add x, u
      mov x, r
      halt

mul  add x, c
     jz x, fat
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

fat add x, e
    sub x, u
    jz x, final
    mov x, e

    mov x, c
    sub x, c

    add x, r
    mov x, d
    sub x, d

    mov x, r
    goto mul

final halt