;
;	Puts zeros into memory
;
;	Input:
;		- rdi as a pointer to memory
;
;		- rcx as amount of quad words to clear
;
;	Output:
;		- rax is equal to 0
;
;		- rdi points to the memory + rcx
;
;		- rcx remains the same
;
_memclrq:
	xor rax, rax
	mov [rdi], rax
	add rdi, 8
	loop _memclrq
	ret