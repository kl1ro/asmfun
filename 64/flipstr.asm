;
;	Flips a string
;
;	Input: 
;		- rsi as a pointer to the source string 
;
;		- rdi as a pointer to the destination string
;
;	Output:
;		- rax is modified
;
;		- rbx is equal to rsi
;
;		- rsi remains the same
;
;		- rdi points to the end of the destination string
;
;		- source string remains the same
;
;		- destination string is a flipped source string
;
_flipstr:
	mov rbx, rsi

	._flipstrCycle1:
		inc rsi
		mov al, [rsi]
		test al, al
		jnz ._flipstrCycle1

	._flipstrCycle2:
		dec rsi
		mov al, [rsi]
		mov [rdi], al
		inc rdi
		cmp rsi, rbx
		jne ._flipstrCycle2

	ret
