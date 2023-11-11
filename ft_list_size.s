section .text
	global ft_list_size

;rdi t_list *begin
ft_list_size:
	xor rcx, rcx
	cmp rdi, 0
	jle .empty
	mov r10, rdi
.loop:
	inc rcx
	mov r8, [r10 + 8]
	mov rax, r8
	cmp rax, 0
	jle .end
	mov r10, r8
	jmp .loop
.end:
	mov rax, rcx
	ret
.empty:
	xor rax, rax
	ret
