;
; Adds space character to the memory
;
; Input:
;   rdi as a pointer to the memory
;
; Output:
;	bl equals to 32
;
; 	string is modified 
;
;	rdi is incremented
; 	
_addSpaceCharacter:
	mov bl, 32
    mov [rdi], bl
	inc rdi
    ret
