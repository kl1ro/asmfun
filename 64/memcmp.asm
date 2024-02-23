;
;	Compares two memory parts and returns:
;		- 0 if they are equal
;
;		- > 0 if the ascii codes of the
;		first string are more than codes
;		of the second string
;
;		- else < 0
;
;	Input:
;		- rsi as a pointer to the first part of memory
;
;		- rdi as a pointer to the second part of memory
;
;		- rcx as a number of bytes to compare
;
;	Output:
;		- rax is an answer
;
;		- bl is modified
;
;		- rsi points to the end of the first string
;
;		- rdi points to the end of the second string
;
;		- rcx is modified
;
_memcmp:
	xor rbx, rbx

	._memcmpCycle:
		xor rax, rax
		mov al, [rsi]
		mov bl, [rdi]
		sub rax, rbx
		test rax, rax
		jnz _break
		inc rsi
		inc rdi
		loop ._memcmpCycle