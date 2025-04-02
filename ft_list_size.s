section .text
	global ft_list_size

;rdi t_list *begin

ft_list_size:
	xor rcx, rcx
	cmp rdi, 0              ; check that to point to the list element is not null
	jle .empty              
	mov r10, rdi		; store the pointer to the list node into r10
.loop:
	inc rcx                 ; our counter of nodes
	mov r8, [r10 + 8]       ; load the pointer of the next elem into r8, 8 is the offset to get the *next in the struct
	mov rax, r8             ; copy it into rax
	cmp rax, 0              ; check that the *next is not null
	jle .end          
	mov r10, r8             ; set the r10 to the *next so we advance to next node
	jmp .loop               ; and we continue
.end:
	mov rax, rcx            ; put the size into the return register
	ret
.empty:
	xor rax, rax            ; if emtpy just return 0
	ret
