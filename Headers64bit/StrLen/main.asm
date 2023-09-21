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
_strLen:
	xor rcx, rcx

	._strLenCycle:
		inc rcx
		inc rsi
		mov al, [rsi]
		cmp al, 10
		je ._strLenCycle
		cmp al, 0
		jne ._strLenCycle

	ret