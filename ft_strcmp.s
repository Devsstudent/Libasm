section .text
	global ft_strcmp

; strcmp(const char *s1 rdi, const char *s2 rsi);

ft_strcmp:
	mov rcx, -1
loop:
	inc rcx
	lodsb
	cmp al, 0                  ; Checking we are not on '\0' in s2
	jz .end
	cmp byte [rdi + rcx], 0    ; Checking we are not on '\0' in s1
	jz .end
	cmp byte [rdi + rcx], al   ; Checking it's the same character on both strings
	jnz .end
	jmp loop

.end:
	xor r8,r8
	mov r8b, al                ; Stock le dernier charcater de s2 dans r8b
	xor rax, rax
	mov al, byte [rdi + rcx]   ; Stock dans al le dernier charcter parcouru de s1
	sub rax, r8                
	ret
