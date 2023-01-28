[bits 32]

; Prints a string pointed to by esi and edx to video memory
_printTextPM:	

_printTextLoopPM:
	mov al, [esi]
	cmp al, 0
	je _break
	mov ah, 0x0f			; White on black style
	mov [edx], ax
	inc esi
	add edx, 2
	jmp _printTextLoopPM
