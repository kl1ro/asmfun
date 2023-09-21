;
;	Puts zeros into memory
;
;	Input:
;		- rdi as a pointer to memory
;
;		- rcx as amount of bytes to clear
;
;	Output:
;		- ax is equal to 0
;
;		- rdi points to the memory + rcx
;
;		- rcx remains the same
;
_memclrw:
	xor ax, ax
	mov [rdi], ax
	add rdi, 2 
	loop _memclrw
	ret
