;
; Converts int value to a string
;
; Input: 
;	- rax as an integer
;
;	- rdi as a pointer to destination string
;
; Output:
;	- rax is modified
;
;	- rcx is modified
;
;	- rdx is modified
;
;	- rsi is modified
;
;	- rdi points to the end of the string
;
_intToString:
	;
	; First things first we need
	; to check if a number is negative
	; and if it is we put a "-" character 
	; to a memory, increment pointer to memory
	; and negate a number just to get its 
	; absolute value
	;
	call _minusCheck

	;
	; Then we need to save pointer to memory
	; for further usage
	;
	mov rsi, rdi

	;
	; Put to rdi a pointer to temp
	; to form a string value of a number
	; being in rax, rbx is 10 because we
	; use decimal number system
	; 
	mov rdi, temp
	mov rbx, 10
    call _assignFlippedIntegerPortion

	;
	; Then we need to put our decimal value
	; to a string and thus we restore the old rdi value
	;
	mov rdi, rsi
	mov rsi, temp
    call _flipString

	;
	; Save rdi value again
	;
	mov rsi, rdi

	;
	; And finally we clear temp memory
	; and return
	;
	mov rcx, 19
	mov rdi, temp
	call _memclrb

	;
	; Restore rdi value
	;
	mov rdi, rsi
    ret
