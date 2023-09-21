;
; Converts the value being stored
; in the string to float and puts it
; to the st(0)
;
; Input:
;	- rsi as a string
;
; Output:
;	- st(0) contains the float value
;
_stringToFloat:
	;
	; First things first we 
	; get the integer portion 
	; from a string and save it
	; in r11
	;
	; We need to use the r12 too
	; because it will contain the 
	; number of binary digits of the 
	; integer portion of the mantissa
	;
	call _stringToInt
	mov r11, rax

	;
	; The exponential part is contained in
	; the decimal portion of the mantissa
	; so let's calculate it. And exp += 127;
	; I'll do that later I promise.
	;

	call _calculateExponentialPart

	;
	; Then we increment the pointer
	; to the string to avoid the "." symbol
	; and we get the decimal floating
	; portion
	;
	inc rdi
	mov rsi, rdi
	call _stringToInt

	;
	; Then we define that the r12 register
	; will contain the answer. Our first 
	; mantissa part is already assembled
	; and it is contained in r11 now so
	; then all the mantissa will be 
	; contained in there
	;

	;
    ; Then we need to calculate the
    ; floating portion of the mantissa
    ;
	call _intToFloatingPortion

	;
	; First we shift r10 to the right.
	; And then we shift r11 to the left
	; by the number of the digits of
	; the floating portion of the 
	; mantissa
	;
	mov rcx, r9
	shr r10, cl

	mov r9, 24
	sub r9, rcx
	sub r9, r12
	mov rcx, r9
	btr r11, r12
	shl r11, cl
	
	;
	; Then we copy the floating portion 
	; value to the r11 and now it is clear
	; that the mantissa is done
	;
	or r11, r10
	mov rcx, 23
	sub rcx, r9
	sub rcx, r12
	shl r11, cl

	add r12, 127
	shl r12, 23

	;
	; Assemble the mantissa and exponent
	; together
	;
	or r12, r11

	;
	; And store the answer
	;
	mov [ans], r12
	fld dword [ans]
	ret

;
; This function will convert the 
; integer representation of floating
; portion of the mantissa to the real 
; floating portion of the mantissa
;
; Input:
;	- rax as an integer representation
;	of the floating portion of the mantissa
;
;	- r10b as a number of decimal digits
;
; Output:
;	- r10 will contain the real floating
;	portion of the mantissa
;
;	- r9 will contain the number of binary
;	digits in floating portion
;
_intToFloatingPortion:
	;
	; Clear the necessary registers
	;
	xor rbx, rbx	
	xor rcx, rcx

	;
	; First we have to calculate the
	; 10 ^ (length of the integer 
	; representation of floating portion)
	; because after that we will divide by
	; that number
	;

	;
	; Save the floating portion
	;
	mov r8, rax

	;
	; Then calculate 10 ^ x.
	; We will contain that number 
	; in the rbx register
	;
	mov rax, 10
	mov cl, r10b
	xor r10, r10
	call _power
	mov rbx, rax

	;
	; Restore the floating portion
	;
	mov rax, r8

	;
	; We set the rcx register to 0 and
	; count to 23 because the maximum 
	; amount of multiplications will be 23
	; (mantissa is 23 bits in length)
	;
	mov rcx, 23
	sub rcx, r12

	_intToFloatingPortionCycle:
		;
		; The algorithm is that we 
		; multiply the number being in rax
		; by two and then devide rax by 10 ^ x
		; so that the answer after that division
		; is 0 or 1. We contain this bit in rax
		; with shifting it by rcx. And we 
		; need to save the index of the first 1
		; in the r9 so that we know how many shifts
		; to make in r11 register to contain the 
		; floating portion
		;
		shl rax, 1
		
		;
		; In each iteration we have to
		; save the number contained in 
		; rax register
		;
		mov r8, rax

		xor rdx, rdx
		div rbx
		bt ax, 0
		jnc ._elseRemainderNotZero
	
	  ; ._ifRemainderNotZero:
			mov r9, rcx
			sub r8, rbx

		._elseRemainderNotZero:
			shl rax, cl
			or r10, rax
			test rdx, rdx
			jz _break
			mov rax, r8
			loop _intToFloatingPortionCycle
			ret
	
;
; Input:
; 	- rax as a decimal portion
; 	of the mantissa
;
; Output:
;	- r12 contains the (number of
;	binary digits in rax) - 1
;
_calculateExponentialPart:
	xor rcx, rcx

	_calculateExponentialPartCycle:
		bt rax, rcx
		cmovc r12, rcx
		inc rcx
		cmp rcx, 23
		jl _calculateExponentialPartCycle
		ret
