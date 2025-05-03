section .text
	global ft_list_sort

;typedef struct s_list
;{
;	void *data;
;	struct s_list *next;
;} t_list;

;ft_sort_list(t_list **head, int (cmp*)()) 

;rdi head
;rsi function de comparaison

ft_list_sort:
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

.loop2:
	mov r10, [r10 + 8] ; met le next dans r10
	test r10, r10
	jz .end_loop2
	xor rdi, rdi
	mov rdi, [r8]
	xor rsi, rsi
	mov rsi, [r10]
	call r9
	test eax, eax
	js .loop2 ; if negative
	jz .loop2 ; if zero
	jmp .swap ; store the biggest diff, and its corresponding addr

.end_loop2:
	mov r8, [r8 + 8] ; modifie le buffer pointer sur le prochain element
	jmp .loop1

.end:
	ret

.swap:
	mov rax, [r10]
	mov rdi, [r8]
	mov [r8], rax
	mov [r10], rdi
	jmp .loop1
