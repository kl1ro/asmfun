;
;	Copies the number to the first n characters of the string
;
;	Input:
;		- rdi as a string pointer
;
;		- al as the character to copy
;
;		- rcx as n
;
;	Output:
;		- rcx equals to 0
;
;		- al stays the same
;
;		- rdi is increased by n
;
_memset:
	mov [rdi], al
	inc rdi
	loop _memset