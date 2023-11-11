	global ft_strdup
	extern malloc
	extern __errno_location
section .text

ft_strdup:
	push rdi
	mov rsi, rdi
	xor rdi, rdi
get_size:
	inc rdi
	lodsb
	cmp al, 0
	jnz get_size
	call malloc wrt ..plt
	cmp rax, 0
	jz error
	pop rsi
	push rax
	mov rdx, rax
	mov rcx, -1
fill_str:
	inc rcx
	lodsb
	mov byte [rdx + rcx], al
	cmp al, 0
	jnz fill_str
	mov byte [rdx + rcx], al
	pop rax
	ret

error:
	mov r15, rax
	call __errno_location wrt ..plt
	mov [rax], r15
	mov rax, 0
	ret

;section .note.GNU-stack noalloc noexec nowrite progbits
