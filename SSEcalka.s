liczbaP = 1000

.text
.global calka

calka:
push %ebp
movl %esp, %ebp
push %ebx

distance:
movups zera, %xmm0              #0,0,0,0 -> xmm0 (tu beda wyniki)
movups czworki, %xmm2           #4,4,4,4 -> xmm2
movss n, %xmm5                  #n -> xmm5
movups po_kolei, %xmm6          #4,3,2,1 -> xmm6
movups jedyneczka, %xmm7
movss x_p, %xmm3
movss x_k, %xmm4
subss %xmm3, %xmm4
divss %xmm5, %xmm4              #dx -> xmm4
shufps $0x00, %xmm4, %xmm4      #dx,dx,dx,dx -> xmm4
movss x_p, %xmm5
shufps $0x00, %xmm5, %xmm5      #xp,xp,xp,xp -> xmm5

xor %edx, %edx
movl $liczbaP, %eax
movl $4, %ecx
div %ecx
movl %eax, %ecx                 #250 -> ecx

                                #wolne xmm: 0, 1, 3

petla:
movaps %xmm6, %xmm3             #kopia i
mulps %xmm4, %xmm3              #i*dx -> xmm3
addps %xmm5, %xmm3              #xp + i*dx -> xmm3

funkcja:
mulps %xmm3, %xmm3              #x^2 -> xmm3
addps %xmm7, %xmm3              #x^2 + 1 -> xmm3
sqrtps %xmm3, %xmm3             #sqrt(x^2 + 1) -> xmm3

dodanie:
addps %xmm3, %xmm0              # poprzednie wyniki + aktualne

addps %xmm2, %xmm6              #i+4 kazde -> xmm6

loop petla

last_calc:                      #
mulps %xmm4, %xmm0

koniec_calka:
extractps $0, %xmm0, wynik
flds wynik
extractps $1, %xmm0, wynik
fadds wynik
extractps $2, %xmm0, wynik
fadds wynik
extractps $3, %xmm0, wynik
fadds wynik

xor %eax, %eax
pop %ebx
pop %ebp

ret

.data

x_p: .float 0.0
x_k: .float 1.0
wynik: .float 0.0
jedyneczka: .float 1.0, 1.0, 1.0, 1.0
zera: .float 0.0, 0.0, 0.0, 0.0
czworki: .float 4.0, 4.0, 4.0, 4.0
po_kolei: .float 4.0, 3.0, 2.0, 1.0
n: .float 1000.0
                                                                                                                                                                                         78,1          Bot
                                                                                                                                                                                         1,1           Top