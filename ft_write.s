section .text
	global ft_write
	extern __errno_location

;rdi fd
;rsi char *str
;rdx char size

ft_write:
	mov rax, 1
	syscall
	cmp rax, 0
	jl .error
	ret

.error:
	neg rax
	mov rdx, rax
	call __errno_location wrt ..plt
	mov [rax], rdx
	mov rax, -1
	ret
