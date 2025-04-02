section .text
	global ft_strcpy

;rdi dest
;rsi src
;stpcpy(char * dst, const char * src);

ft_strcpy:
	push rdi          ; push the address of the first character of the src string
.loop:
	lodsb             ; load the src char on by one
	stosb             ; cpy the al into the destination rdi first etc
	cmp al, 0         ; check we didn't reach the end of the src string
	jnz .loop
	xor rax, rax
	pop rax           ; get back the pointer to the first string of destination into the return register
	ret 
