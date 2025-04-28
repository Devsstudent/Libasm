
section .text
	global ft_list_remove_if

; void ft_list_remove_if(t_list **begin_list, void *data_ref, int (*cmp)(), void (*free_fct)(void *))
; rdi -> begin_list
; rsi -> data_ref
; rdx -> cmp
; rcx -> free_fct

ft_list_remove_if:
	push rdi
	mov r8, [rdi]	;store the t_list *first_elem into r8
	mov r9, rdx	;store the comparaison function
	mov r12, rcx	;store the free function
	mov r14, rsi    ;store the data
	mov r10, r8     ; r10 will be our buffer
	mov r15, 0

;	r15 is always the previous element
.loop:
	test r10, r10	; check si l'element n'est pas null
	jz .end
	xor rdi, rdi
	mov rdi, [r10]
	mov rsi, r14
	call r9
	test eax, eax	; functoin return a int so only 32 bits
	jz .remove_node
	jmp .end_loop
.end_loop:
	mov r15, r10		; store the previous element
	mov r10, [r10 + 8]	; set r10 to the next element
	jmp .loop

; Quand pas de valeur pecedente on remplace la head

; Le probleme c'est que quando n remove l'element acutel on a pas access au precedent

; label qui fait les liaisons
.remove_node:
	test r15, r15	; Check if there is a previous
	jnz .setup_new_next
	pop rdi
	mov r13, [r10 + 8]	; get the next->elem
	mov [rdi], r13		; set la head a next elem because the first elem is removed
	push rdi		; on repush la head
	xor rdi, rdi

.elem_removed:
	mov rdi, [r10]		; setup argument pour la function
	call r12		; call la function
	mov r10, [r10 + 8]      ; setup le next 
	jmp .loop

.setup_new_next:
	mov r13, [r10 + 8]	; get then next->elem
	mov [r15 + 8], r13 ;prev->next = (remove_elem->next)
	jmp .elem_removed
	

.end:
	pop rdi
	ret

