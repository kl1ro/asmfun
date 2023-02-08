;
; Converts int value to a string
;
; Input: 
;	- rax as integer
;
;	- rdi as a destination string
;
; Output:
; 
;	
_intToString:
	call _minusCheck
	mov r8, rdi
	mov rdi, temp
	mov rbx, 10
        call _assignFlippedIntegerPortion
	mov rsi, temp
	mov rdi, r8
        call _flipString
	mov rcx, 19
	mov rdi, temp
	call _memclr
        ret
