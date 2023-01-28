; Input - r9 as a pointer to string
_strCapitalize:
	mov al, [r9]
	cmp al, 0
	je _break
	cmp al, 97
	jl _nextStrCapitalize
	cmp al, 122
	ja _nextStrCapitalize
	and al, 0DFh 
	mov [r9], al
	jmp _nextStrCapitalize
	
_nextStrCapitalize:
	inc r9
	jmp _strCapitalize
