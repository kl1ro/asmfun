;
; Converts string value of number
; to decimal integer value
;
; Input: 
;	- rsi as pointer to string
;
; Output:
;	- rax is a number received from string
;
; 	- rbx is modified
;
;	- ch equals to 1 if number is negative
;	else 0
;
;	- cl equals to 0
;
; 	- r8 equals to 10
;
;	- r9 is modified
;
; 	- r10b stores the number
;	of digits
;
;	- rdx is modified
;
; 	- rsi points to the stirng
;
;	- rdi points to the place of the
;	string where the program has ended
;	for some reason (e.g. ".", " ", "\0" etc)
;	has ended the execution
;
_stringToInt:
	;
	; cl counts number of characters
	;
	xor cl, cl
	
	;
	; ch shows if number is negative
	;
	xor ch, ch 
		
	;
	; r8 is a multiplier
	;
	mov r8, 10
	
	;
	; r9 stores the product
	;
	mov r9, 1
	
	;
	; rbx stores the answer
	;
	xor rbx, rbx
	
	;
	; rdx needs to be cleared
	;
	xor rdx, rdx
	
	call _stringToIntCycle1
	mov rdi, rsi
	
	;
	; r10b will store the number 
	; of digits
	;
	mov r10b, cl
	jmp _stringToIntCycle2

_stringToIntCycle1:
	;	
	; First we need to calculate the 
	; length of a string except \0, \n, 
	; \32 (which is space). In other words we 
	; need to calculate the length of a string
	; that contains only digits.
	;
    mov al, [rsi]
	cmp al, 32
	je _break	
	cmp al, 45
	je _stringToIntMinus
	cmp al, 10
	je _break
	cmp al, 46
	je _break
    cmp al, 0
    je _break
    cmp al, 48
    jl _stringToIntCycle1
    cmp al, 57
    ja _stringToIntCycle1
	inc cl
	inc rsi
	
	;
	; Now rsi is presumed to contain
	; a pointer to \0 of a string
	;
	jmp _stringToIntCycle1

_stringToIntMinus:
	inc rsi
	test ch, ch
	jz _stringToIntAddMinus
	jnz _stringToIntRemoveMinus

_stringToIntAddMinus:
	inc ch
	jmp _stringToIntCycle1

_stringToIntRemoveMinus:
	dec ch
	jmp _stringToIntCycle1

_stringToIntCycle2:
	dec rsi	
	dec cl
	mov dl, [rsi]
	mov rax, rdx
	sub al, 48
	mul r9
	add rbx, rax	
	mov rax, r9
	mul r8
	mov r9, rax
	cmp cl, 0
	jne _stringToIntCycle2
	mov rax, rbx
	test ch, ch
	jnz _negate
	ret
