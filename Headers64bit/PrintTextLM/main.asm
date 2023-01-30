; Prints a string pointed to by rsi and rdx to video memory
; Note: ah is a style
_printTextLM:	

_printTextLoopLM:
	mov al, [rsi]
	test al, al
	jz _break
	mov [rdx], ax
	inc rsi
	add rdx, 2
	jmp _printTextLoopLM
