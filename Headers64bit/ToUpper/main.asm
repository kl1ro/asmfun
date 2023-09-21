;
;	Changes all letters in the string to uppercase
;
;	Input:
;		- rsi as a pointer to a string
;
;	Output:
;		- al is modified
;
;		- rsi points to the end of the string 
;
;		- string is modified
;
_toUpper:
	mov al, [rsi]
	cmp al, 0
	je _break
	cmp al, 97
	jl ._nextStrCapitalize
	cmp al, 122
	ja ._nextStrCapitalize
	and al, 0xdf
	mov [rsi], al
	jmp ._nextStrCapitalize
	
	._nextStrCapitalize:
		inc rsi
		jmp _toUpper
