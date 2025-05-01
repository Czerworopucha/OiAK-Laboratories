.global getCounter
.text

getCounter:

push %ebp
mov %esp, %ebp
push %ebx

mov 12(%ebp), %ecx
cmpl $1, 8(%ebp)
je wariant_1

wariant_0:
xor %eax, %eax
push %ecx
cpuid
pop %ecx
rdtsc
loop wariant_0
jmp koniec

wariant_1:
xor %eax, %eax
push %ecx
rdtscp
pop %ecx
loop wariant_1

koniec:
pop %ebx
pop %ebp
ret