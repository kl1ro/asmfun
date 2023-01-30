; Prints a string pointed to by esi and edx to video memory
_printTextPM:	

_printTextLoopPM:
	mov al, [esi]
	cmp al, 0
	je _break
	mov ah, 0x07			; Gray on black style (like in bios, you know)
	mov [edx], ax
	inc esi
	add edx, 2
	jmp _printTextLoopPM
