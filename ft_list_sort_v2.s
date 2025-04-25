section .text
	global ft_list_sort_v2

;typedef struct s_list
;{
;	void *data;
;	struct s_list *next;
;} t_list;

;ft_sort_list(t_list **head, int (cmp*)()) 

;rdi head
;rsi function de comparaison

ft_list_sort_v2:
	; Loop 1 sur toutes la list
	; Loop 2 pour place l'element
	;push rdi
	mov r8, [rdi] ; r8 va etre le registre buffer de la list
	mov r9, rsi   ; r9 le registre contenant l'addresse de la fonction de comparaison
	test r8, r8
	jz .end
	test rsi, rsi
	jz .end

.loop1:
	test r8, r8 ;check si le ptr est pas null
	jz .end
	mov r10, r8 ; new buffer for loop2
	xor r11, r11
	push 0

.loop2:
	mov r10, [r10 + 8] ; met le next dans r10
	test r10, r10
	jz .end_loop2
	mov rdi, [r8]
	mov rsi, [r10]
	call r9
	test eax, eax
	js .loop2 ; if negative
	jz .loop2 ; if zero
	jmp .storing ; store the biggest diff, and its corresponding addr

.end_loop2:
	pop rdi
	cmp rdi, 0
	jg .swap

.continue_loop1:
	mov r8, [r8 + 8] ; modifie le buffer pointer sur le prochain element
	jmp .loop1

.end:
	ret

.storing:
	pop rdi      ; get back the pushed value
	cmp rax, rdi
	jg .bigger_dif
	push rdi
	jmp .loop2

.bigger_dif:
	mov r11, r10
	push rax
	jmp .loop2

.swap:
	mov rax, [r11]
	mov rdi, [r8]
	mov [r8], rax
	mov [r11], rdi
	jmp .continue_loop1
