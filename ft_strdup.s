	global ft_strdup             ; name of the function
	extern malloc                ; external function malloc
	extern __errno_location      ; external macro 
section .text

; char *strdup(const char *s1)

ft_strdup:
	push rdi                     ; push l'address of the string
	mov rsi, rdi                 ; store addr into rsi
	xor rdi, rdi                 ; reset rdi to 0
get_size:
	inc rdi                      ; rdi est le registre de la size a malloc on l'incremente (c'est notre size)
	lodsb
	cmp al, 0                    ; check we are on a '\0'
	jnz get_size                 ; continue looping
	call malloc wrt ..plt        ; call a malloc of size, ici rdi
	cmp rax, 0                   ; check the return value
	jz error
	pop rsi                      ; get back the inital address of the string (not incremented by lodsb)
	push rax                     ; push the allocated addr to the stack
	mov rdx, rax                 ; store the addr into rdx
	mov rcx, -1
fill_str:
	inc rcx                      ; index in the allocated string to fill
	lodsb
	mov byte [rdx + rcx], al     ; copy from s1 to new string
	cmp al, 0                    ; check we are not on a '\0'
	jnz fill_str                 ; otherwise continue
	mov byte [rdx + rcx], al     ; copy the '\0' to the new string
	pop rax                      ; get back the initial address of the new string, to the return register
	ret

error:
	mov r15, rax
	call __errno_location wrt ..plt
	mov [rax], r15
	mov rax, 0
	ret

;section .note.GNU-stack noalloc noexec nowrite progbits
