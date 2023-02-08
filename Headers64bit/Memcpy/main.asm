;
; This is a function that loads
; memory from the source to the 
; destination
;
; Input:
;	rsi is a pointer to source
; 	rdi is a pointer to the destination
;	rcx is amount of bytes to copy
;
_memcpy:
	mov al, [rsi]
	mov [rdi], al
	inc rsi
	inc rdi
	loop _memcpy
	ret
