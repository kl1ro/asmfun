;
; Compares two strings and returns:
; 	- 0 if they are equal
;
;	- > 0 if the ascii codes of the
;	first string are more than codes
;	of the second string
;
;	- else < 0
;
; Input:
;	- rsi as a pointer to the
;	first string
;
;	- rdi as a pointer to the 
;	second string
;
; Output:
;	- rax is an answer
;
;	- bl is modified
;
;	- rsi points to the end
;	of the first string
;
;	- rdi points to the end
;	of the second string
;
;
_strcmp:
	xor rbx, rbx

	_strcmpCycle:
		xor rax, rax
		mov al, [rsi]
		mov bl, [rdi]
		test al, al
		jz _break
		test bl, bl
		jz _break
		sub rax, rbx
		test rax, rax
		jnz _break
		inc rsi
		inc rdi
		jmp _strcmpCycle
