section .text
	global ft_strcpy

;rdi
;rsi
ft_strcpy:
	push rdi
.loop:
	lodsb
	stosb
	cmp al, 0
	jnz .loop
	xor rax, rax
	pop rax
	ret
