;
;	Prints a string to the screen using system call
;
;	Input:
;		- rsi as a pointer to a source string
;
;	Output:
;		- rax is equal to length of the string
;
;		- rcx is modified
;
;       - rdx is equal to length of the string
;
;       - rsi is modified
;
;		- rdi is equal to 1
;
;       - operating system also can modify registers
;
_print:
    xor rdi, rdi
	mov rax, rsi

	._stringCountLoop:
		inc rsi
		inc rdi
		mov cl, [rsi]
		cmp cl, 0
		jne ._stringCountLoop
		mov rsi, rax
		mov rax, 1
		mov rdx, rdi
		mov rdi, 1
		syscall
	
	ret