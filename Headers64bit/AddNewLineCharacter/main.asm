; input - r9 as a pointer to the memory
_addNewLineCharacter:
	mov rsi, 10
        mov [r9], si
	inc r9
        ret
