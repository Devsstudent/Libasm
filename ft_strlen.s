section .text
	global ft_strlen

; ft_strlen(char *str)


ft_strlen:
	mov rsi, rdi  ;	put the address of the string into rsi, for the future lodsb usage
	xor rcx, rcx  ;	reset the counted just in case
loop:                 ;	this is the label for our loop
	lodsb         ;	lodsb, will load into al, from [sl] which also increment rsi
	inc rcx       ; increment our character counter rcx
	cmp al, 0     ; we check the character is not the '\0'
	jnz loop      ; if not zero continue to loop on our label
	dec rcx       ; decrement to not count the '\0'
	xor rax, rax  ; reset rax, just in case
	mov rax, rcx  ; character counter set into the return register
	ret
