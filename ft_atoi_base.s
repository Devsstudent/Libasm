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

	push rdi 
	push rsi

	mov rdi, rsi 
	call check_base
	CMP_A_B_JMP rax, 1, .err  ; if err in base return 0
 
	pop r8					; Will store base into r8
	mov rdi, r8				; Get back in rdi the base (setup first argument of my function)
	call get_len_str
	mov r10, rax				; Store into r10 the len of my base
	pop rsi					; Get back str into rsi
	push 0
	CLEAR_REG r9
	CLEAR_REG r13
	.loop_post:
		lodsb
		CMP_A_B_JMP al, 32, .loop_post
		CMP_A_B_JMP al, 43, .loop_post
		CMP_A_B_JMP al, 45, .is_negative_sign
		jmp .first_turn
		
	.loop_str:
		lodsb
	.first_turn:
		CHECK_ZERO al, .end_str
		mov dl, al
		push rsi			; Save rsi current state
		mov rsi, r8
		call get_index_elem
		pop rsi
		CMP_A_B_JMP rax, -1, .err_loop	; Means the char doesn't exist in the base
		imul r13, r10
		add r13, rax
		jmp .loop_str
		
	

	.is_negative_sign:			; If negative sign we add 1 to the pushed reference value that we will use at the end
		pop r9
		add r9, 1
		push r9
		jmp .loop_post

	.end_str:				; End case when everything is good
		pop rax
		CLEAR_REG rcx
		CLEAR_REG rdx
		mov rcx, 2
		div rcx
		cmp rdx, 0
		jne .mul_sign
		mov rax, r13
		ret

	.mul_sign:
		imul r13, -1
		mov rax, r13
		ret

	.err_loop:
		pop r9
		mov rax, 0
		ret


; case emtpy base ou len(base) = 1
; base has duplicate character
; base containe whitespace or "+" et "-"
	.err:
		pop rdi
		pop rsi
		mov rax, 0
		ret

; rdi elem
; rsi string
get_index_elem:					; will use get_index to check if char is in base
	CLEAR_REG ecx
	.get_index_elem.loop:
		lodsb
		CMP_A_B_JMP al, dl, .get_index_elem.ret
		CHECK_ZERO al, .index_not_found
		add ecx, 1
		jmp .get_index_elem.loop

	.index_not_found:
		mov rax, -1
		ret

	.get_index_elem.ret:
		mov rax, rcx
		ret
	


get_len_str:
	mov  rsi, rdi	; put the first argument rdi into rdi
	CLEAR_REG ecx

	.get_len_str.loop:
		lodsb
		CHECK_ZERO al, .get_len_str.ret
		add ecx, 1
		jmp .get_len_str.loop
	.get_len_str.ret:
		mov eax, ecx
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

	.check_base.end_good:
		mov rax, 0
		ret


