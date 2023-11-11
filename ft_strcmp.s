section .text
	global ft_strcmp

ft_strcmp:
	mov rcx, -1
loop:
	inc rcx
	lodsb
	cmp al, 0
	jz .end
	cmp byte [rdi + rcx], 0
	jz .end
	cmp byte [rdi + rcx], al
	jnz .end
	jmp loop

.end:
	xor r8,r8
	mov r8b, al
	xor rax, rax
	mov al, byte [rdi + rcx]
	cmp rax, r8
	jz .nd
	sub rax, r8
	ret
.nd:
	ret
