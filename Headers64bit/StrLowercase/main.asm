; Input - r9 as a pointer to string
_strLowercase:
	mov al, [r9]
	cmp al, 0
	je _break
	cmp al, 65
	jl _nextStrLowercase
	cmp al, 90
	ja _nextStrLowercase
	or al, 020h
	mov [r9], al
	jmp _nextStrLowercase
	
_nextStrLowercase:
	inc r9
	jmp _strLowercase
