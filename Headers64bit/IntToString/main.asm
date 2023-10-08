;
;	Temporary string to store flipped number
;
temp times 20 db 0

;
;	Converts an integer value to a string
;
;	Input: 
;		- rax as an integer
;
;		- rdi as a pointer to destination string
;
;		- rcx as the number base
;
;	Output:
;		- rax is modified
;		
;		- rbx is modified
;
;		- rcx is modified
;		
;		- rdx is modified
;
;		- rsi is modified
;
;		- rdi is modified
;
_intToString:
	;
	;	First things first we need
	;	to check if the number is negative
	; 
    test rax, rax
    jns ._notNegative

    ;
    ;   If rax is negative we put a "-" character 
	;   to string, increment the pointer
	;   and negate the number to get its 
	;   absolute value
    ;
    mov bl, 45
	mov [rdi], bl
	inc rdi
    neg rax

    ._notNegative:

	;
	;	Then we need to save pointer to memory
	;	for further usage
	;
	mov rsi, rdi

	;
	;	Get the flipped number
	; 
	mov rdi, temp
	mov rbx, rcx
	call _assignFlippedIntegerPortion

	;
	;	Then we need to put our decimal value
	;	to a string and thus we restore the old rdi value
	;
	mov rdi, rsi
	mov rsi, temp
    call _flipString

	;
	;	Save rdi value again
	;
	mov rsi, rdi

	;
	;	And finally we clear temp memory
	;	and return
	;
	mov rcx, 19
	mov rdi, temp
	call _memclrb

	;
	;	Restore rdi value
	;
	mov rdi, rsi
    ret