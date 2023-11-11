section .text
	global ft_strlen

ft_strlen:
	mov rsi, rdi
	xor rcx, rcx
loop:
	lodsb
	inc rcx
	cmp al, 0
	jnz loop
	dec rcx
	xor rax, rax
	mov rax, rcx
	ret
