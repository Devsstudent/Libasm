section .text
	global ft_read
	extern __errno_location

ft_read:
	xor rax, rax
	syscall
	cmp rax, 0
	jl .error
	ret

.error:                                 ; Handling error
	neg rax
	mov rdx, rax
	call __errno_location wrt ..plt
	mov [rax], rdx
	mov rax, -1
	ret
