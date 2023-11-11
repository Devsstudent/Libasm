extern malloc
section .text
	global ft_list_push_front

;struct t_list -> void *data; struct s_list *next

;rdi t_list **begin_list
;rsi void *data

ft_list_push_front:
	push rdi
	push rsi
	xor rdi, rdi
	mov rdi, 16
	call malloc wrt ..plt ; a = malloc(16) -> void * 
	cmp rax, 0
	je .end
	pop r9
	pop r8
	mov QWORD [rax], r9 ; *a = void *data
	mov rdi, [r8]
	mov QWORD [rax + 8], rdi ; *(a + 8) = *begin_list
	mov [r8], rax ; *begin_list = *a
	ret

.end:
	ret
