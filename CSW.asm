 goto main
 wb 0
 
r ww 1  # resposta
a ww 4  
b ww 4  
c ww 2 

main add x, c      # x = c
     sub x, a      # x = c - a
     jz x, caso1   # se x = 0, então a = c
     add x, a      # x = c - a + a = c
     mov x, a      # a <- x = c
     halt


caso1 mov x, r    # r <- x = 0
      add x, b    # x = b
      mov x, c    # c <- x = b
      halt