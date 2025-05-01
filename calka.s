liczbaP = 1000

.text
.global calka

calka:
push %ebp
mov %esp, %ebp
push %ebx

distance:
flds n			#st(0) = n
flds x_p 		#st(0) = n		st(1) = 0
flds x_k 		#st(0) = 1		st(1) = 0	st(1) = n
fsubp %st, %st(1)	#st(0) = 1		st(1) = n
fdivs n 		#st(0) = 1/n		
flds wynik 		#st(0) = s		st(1) = 1/n
fxch %st(1) 		#st(0) = 1/n		st(1) = s	st(2) = n

mov $liczbaP, %ecx
dec %ecx

petla:
fld %st(2)		#st(0) = n		st(1) = 1/n	st(2) = s	st(3) = n
fmul %st(1), %st	#st(0) = 1*1/n		st(1) = 1/n	st(2) = s	st(3) = n
fadds x_p		#st(0) = 0+1*1/n	st(1) = 1/n	st(2) = s	st(3) = n

funkcja:
fmul %st, %st
fadds jedyneczka
fsqrt			#st(0) = sqrt(1 + x^2)	st(1) = 1/n	st(2) = s	st(3) = n

dodanie:
faddp %st, %st(2)	#st(0) = 1/n		st(1) = s	st(2) = n

fld %st(2)		#st(0) = n		st(1) = 1/n	st(2) = s	st(3) = n
fsubs jedyneczka	#st(0) = n - 1		-||-
fxch %st(3)		#st(0) = n		-||-		-||-		st(3) = n-1
ffree %st(0)		#st(0) = 0		st(1) = 1/n	st(2) = s	st(3) = n-1
fincstp			#st(0) = 1/n		st(1) = s	st(2) = n-1

loop petla

last_calc:
flds x_p
fmul %st, %st
fadds jedyneczka
fsqrt			#st(0) = f(x_p)		st(1) = 1/n	st(2) = s	st(3) = 1

flds x_k
fmul %st, %st
fadds jedyneczka
fsqrt			#st(0) = f(x_k)		st(1) = f(x_p)	st(2) = 1/n	st(3) = s	st(4) = 1

faddp %st, %st(1)	#st(0) = f(xk)+f(xp)	st(1) = 1/n	st(2) = s	st(3) = 1
fdivs dwujeczka	#st(0) = f(xk)+f(xp)/2 	st(1) = 1/n	st(2) = s	st(3) = 1
faddp %st, %st(2)	#st(0) = 1/n		st(1) = s	st(2) = 1
fmulp %st(0), %st(1)	#st(0) = s		st(1) = 1

koniec_calka:
#xor %eax, %eax
#sub $12,%esp
#fstpt (%esp)
#push $format
#call printf

pop %ebx
pop %ebp

ret

.data

x_p: .float 0.0
x_k: .float 1.0
wynik: .float 0.0
jedyneczka: .float 1.0
dwujeczka: .float 2.0
n: .float 1000.0
format: .asciz "%Lf\n"