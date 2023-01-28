; input - r9 as a pointer to string
; Counts length of the string without \0, and \n
_strLen:
	xor rcx, rcx
	call _strLenCycle
	ret
	
_strLenCycle:
	inc rcx
	inc r9
	mov al, [r9]
	cmp al, 10
	je _break
	cmp al, 0
	jne _strLenCycle
	ret
