;
;	Get's the user's input and puts it into a string
;
;	Input:
;		- rsi as a pointer to memory
;	
;		- rdx as a maximum amount of characters in a string	
;
;	Output:
;		- string being pointed by rsi is modified
;
;		- rax is modified
;
;		- rdi is modified
;
;		- operating system also can modify registers
;
_input:
    xor rax, rax
	xor rdi, rdi
	syscall
	ret
