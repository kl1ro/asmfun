;
; Adds a "-" character to the memory
;
; Input:
;	- rdi as a point to a string
;
; Output:
;	- bl equals to 45
;
;	- string is modified
;
;	- rdi is incremented
;	
_addMinus:
	mov bl, 45
	mov [rdi], bl
	inc rdi
	ret
