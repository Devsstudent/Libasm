section .text
	global ft_list_sort

;ft_sort_list(t_list **head, int (cmp*)()) 

ft_list_sort:
	;head stocker sur la stack pour pouvoir reset
	push rbp
	mov rbp, rsp
	sub rsp, 32
	push rdi
	mov r9, [rdi]
	push rsi
	test r9, r9
	jz .end
	test rsi, rsi
	jz .end
;	lea r13, [r9]
	mov [rbp - 8], r9
	xor r9, r9
.loop:
	xor rdi, rdi
	mov rdi, [rbp - 8]
	mov r10, [rdi + 8]
	test r10, r10 ;case je n'ai pas de next dans mon actual (je suis a la fin)
	jz .end
	xor rdi, rdi
	xor rsi, rsi
	mov rdi, [rbp - 8]
	mov rsi, r10
	xor r8, r8
	pop r8
	push r8
	push r10
	xor r10, r10
	call r8
	pop r10
	cmp eax, 0
	jg .swap
	mov [rbp - 8], r10
	jmp .loop

.swap:
	;r9 j'ai actual r10 j'ai next
	xor r8, r8
	pop r8
	pop r12
	push r12
	push r8
	
	xor rdi, rdi
	xor r9, r9
	mov r9, [rbp - 8]
	cmp r9, [r12]
	jz .first
	jmp .getprevious
.back_swap:
	xor rdi, rdi
	mov rdi, [r10 + 8]
	test rdi, rdi
	jz .last
	xor rsi, rsi
	mov rdi, [r10 + 8]
	lea rsi, [r10 + 8]
	mov [rsi], r9
	lea rsi, [r9 + 8]
	mov [rsi], rdi
	lea rsi, [r8 + 8]
	mov [rsi], r10
	mov [rbp - 8], r8
	jmp .loop

.first:
	mov rdi, [r10 + 8] ;store next next
	lea rsi, [r10 + 8]
	mov [rsi], r9 ;set next->next to actual
	mov [r9 + 8], rdi ;set acutal->next a next next (instead of next)
	xor r8, r8
	pop r8
	pop r12
	mov [r12], r10
	push r12
	push r8
;	mov r9, r10 ;set the loop register to the first value and continue
	;maywork without the reset because not need for the first but in case
	jmp .loop

.last:
	xor rsi, rsi
	lea rdi, [r10 + 8]
	mov [rdi], r9
	lea rdi, [r8 + 8]
	mov [rdi], r10
	lea rdi, [r9 + 8]
	mov [rdi], rsi
	mov [rbp - 8], r8
	jmp .loop

.getprevious:
	;get the stacks value
	pop r8
	pop r12
	push r12
	push r8
	mov r8, [r12] ;set the head into r8 to loop
.get_prev_loop:
	test r8, r8;test si on a une value
	jz .null
	mov rsi, [r8 + 8]
	test rsi, rsi ;test si next != null
	jz .null
	cmp rsi, r9 ;si next is the actual then r8 is correclty set to previous
	jz .back_swap
	jmp .get_prev_loop

.null:
	jmp .back_swap

.end:
	pop r8
	pop r12
	add rsp, 32
	mov rsp, rbp
	pop rbp
	ret
