;
;	Exits from the user program utlizing the syscall
;
;	Input:
;		- nothing
;
;	Output:
;		- nothing
;
_exit:
	mov rax, 60
	mov rdi, 0
	syscall