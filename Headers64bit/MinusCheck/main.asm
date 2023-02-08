;
; Checks if rax is negative and if
; it is takes its absolute value
; and adds "-" character to a given string
;
; Input:
; 	- rax as integer
;
; 	- rdi as a pointer to the 
;	destination string
;	
;
; Output:
;       - r15b equals to 45 
;	if rax is negative
;
;       - string is modified
;
;       - rdi is incremented
;	if "-" was written to
;	a string
;
_minusCheck:
	test rax, rax
        js _minusConfirmed
        ret

_minusConfirmed:
        call _addMinus
        call _negate
        ret
