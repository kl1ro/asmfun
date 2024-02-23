;
;	Loads memory from the source to the destination
;
;	Input:
;		- rsi is a pointer to source
;
;		- rdi is a pointer to the destination
;
;		- rcx is amount of quadwords to copy
;
;	Output:
;		- rax is modified
;
;		- rsi points to the rsi + rcx
;
;		- rdi points to the rdi + rcx
;
_memcpyq:
	mov rax, [rsi]
	mov [rdi], rax
	add rsi, 8
	add rdi, 8
	loop _memcpyq
	ret

