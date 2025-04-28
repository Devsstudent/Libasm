section .text
	global ft_atoi_base

;	int ft_atoi_base(char *str, char *base);

;len(base) = 16 (dans ce cas)

;a -> 0 * 16 + pos a (10) = 10
;a -> 10 * 16 + pos a (10) = 170
;f -> 170 * 16 + pos f (15) = 2720 + 15 2735
;
;len(base) = 16 (dans ce cas)
;faut revert la string
;
;a -> 0 * 16 + pos a (10) = 10
;a -> 10 * 16 + pos a (10) = 170
;f -> 170 * 16 + pos f (15) = 2720 + 15 2735
;

;rsi *str
;rdi *base

ft_atoi_base:
	push rbp
	mov rbp, rsp
	sub rsp, 32

	xor rdi, rdi
	jmp check_base


	add rsp, 32
	mov rsp, rbp
	pop rbp
	ret


; case emtpy base ou len(base) = 1
; base has duplicate character
; base containe whitespace or "+" et "-"
.err:
	mov rax, 0
	ret

check_base:
	; $rsi c'est ma base
	; loop sur la base
	; lodsb load si dans al et increment esi
.check_base.loop:
	lodsb
	cmp al, 32
	jz .check_base.end_bad
	cmp al, 43
	jz .check_base.end_bad
	cmp al, 45
	jz .check_base.end_bad
	test rdi, rdi
	jz  .continue_loop
	push rsi
	mov rsi, rdi ; CETTE LIGNE OUIII
	mov r13, rax

	
	.loop_duplicate:
	lodsb		; parcours la liste rdi (du a la ligne avant) qui est la chaine de charachter des character parcouru
	cmp al, r13b ; cmp that actual char to all the previous one
	jz .check_base.end_bad
	jnz .loop_duplicate

	mov al, r13b
	pop rsi

	.continue_loop:
	; for this logic of storing the char into another string is a bit overkill, i should just rebrowse to currentIdx - 1
	; but its possible to allocate string space in the bss section, to use is a reference (not advised)
	stosb	; stor the current char into rdi
	
	mov rax, 0
	ret

	.check_base.end_bad:
	mov rax, 1
	ret



