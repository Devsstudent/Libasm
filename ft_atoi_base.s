section .text
	global ft_atoi_base

;	int ft_atoi_base(char *str, char *base);

;len(base) = 16 (dans ce cas)

;a -> 0 * 16 + pos a (10) = 10
;a -> 10 * 16 + pos a (10) = 170
;f -> 170 * 16 + pos f (15) = 2720 + 15 2735

;rdi *str
;rsi *base

%macro CLEAR_REG 1
	xor %1, %1
%endmacro

%macro CHECK_ZERO 2 ; 2 is the number of arguments
	cmp %1, 0
	jz %2
%endmacro

%macro CMP_A_B_JMP 3
	cmp %1, %2
	jz %3
%endmacro
;%%label is the label syntax in macro

ft_atoi_base:

	mov rdi, rsi 
	call check_base
	; Possible to make a macro on the test
	CMP_A_B_JMP rax, 1, .err
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
	CLEAR_REG ecx
.check_base.loop:
	lodsb
	CHECK_ZERO al, .check_base.end_good
	CMP_A_B_JMP al, 32, .check_base.end_bad		; check ' '
	CMP_A_B_JMP al, 43, .check_base.end_bad		; check '+'
	CMP_A_B_JMP al, 45, .check_base.end_bad		; check '-'
	add ecx, 1
	push rsi
	push rcx
	mov rsi, rdi ; copy that start address of base into rsi
	mov r13, rax ; store dans r13b al
	mov edx, ecx ; edx prend le current index
	sub edx, 1 ; max = current_index - 1
	CLEAR_REG ecx
	.loop_duplicate:			; Loop on the base to check if current char as not duplicate
		lodsb

		cmp ecx, edx

		jz  .end_loop_duplicate

		cmp al, r13b ; cmp that actual char to all the previous one
		jz .loop_duplicate.bad

		add ecx, 1
		jmp .loop_duplicate

		.end_loop_duplicate:
			pop rcx
			pop rsi
			jmp .check_base.loop
		

		.loop_duplicate.bad:
			pop rcx
			pop rsi
		; then go to end bad

	.check_base.end_bad:
		mov rax, 1
		ret

	.check_base.end_good
		mov rax, 0
		ret


