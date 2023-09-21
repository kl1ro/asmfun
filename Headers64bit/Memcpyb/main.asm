;
;	Loads memory from the source to the destination
;
;	Input:
;		- rsi is a pointer to source
;
;		- rdi is a pointer to the destination
;
;		- rcx is amount of bytes to copy
;
;	Output:
;		- al is modified
;
;		- rsi points to the rsi + rcx
;
;		- rdi points to the rdi + rcx
;
_memcpyb:
	mov al, [rsi]
	mov [rdi], al
	inc rsi
	inc rdi
	loop _memcpyb
	ret
