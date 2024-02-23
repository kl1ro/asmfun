;
;	Finds the length of the string	
;
;	Input:
;		- rsi as a pointer to string
;
;	Output:
;		- rcx is equal to the length of the string
;
;		- al is modified
;
;		- rsi points to the end of the string
;
_strlen:
	xor rcx, rcx

	._strlenCycle:
		inc rcx
		inc rsi
		mov al, [rsi]
		cmp al, 10
		je ._strlenCycle
		cmp al, 0
		jne ._strlenCycle

	ret