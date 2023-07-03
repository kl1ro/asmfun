;
; Adds \n character to the memory
;
; Input:
;       rdi as a pointer to the memory
;
; Output:
;	bl equals to 10
;
; 	string is modified 
;
;	rdi is incremented
; 	
_addNewLineCharacter:
	mov bl, 10
        mov [rdi], bl
	inc rdi
        ret
