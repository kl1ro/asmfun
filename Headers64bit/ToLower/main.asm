;
;	Changes all characters in the string to lowercase
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
_toLower:
	mov al, [rsi]
	cmp al, 0
	je _break
	cmp al, 65
	jl ._next
	cmp al, 90
	ja ._next
	or al, 020h
	mov [rsi], al
	jmp ._next
	
	._next:
		inc rsi
		jmp _strLowercase
