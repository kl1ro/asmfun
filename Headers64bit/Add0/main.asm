;
; Adds a \0 character to the memory
;
; Input: 
; 	- rdi as a pointer to string 
;
; Output:
;	- al equals to 0
;
;	- string is modified
;
_add0:
        xor al, al
        mov [rdi], al
        ret
