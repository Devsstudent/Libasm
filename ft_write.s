section .text
	global ft_write
	extern __errno_location

;rdi fd
;rsi char *str
;rdx size_t size

ft_write:
	mov rax, 1 ; set the value of the syscal
	syscall    ; call the syscall with rdi fd, rsi buf, rdx the count (all well setup from argument here)
	cmp rax, 0 ; check no error
	jl .error
	ret

.error:            ; handling error
	neg rax
	mov rdx, rax
	call __errno_location wrt ..plt
	mov [rax], rdx
	mov rax, -1
	ret
