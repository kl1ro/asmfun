;
; This is a function that loads
; memory from the source to the 
; destination
;
; Input:
;	r8 is a pointer to source
; 	r9 is a pointer to the destination
;	rcx is amount of bytes to copy
;
_memcpy:
	mov al, [r8]
	mov [r9], al
	inc r9
	inc r8
	loop _memcpy
	ret
