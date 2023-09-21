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
_flipString:
	mov rbx, rsi

	._flipStringCycle1:
		inc rsi
		mov al, [rsi]
		test al, al
		jnz ._flipStringCycle1

	._flipStringCycle2:
		dec rsi
		mov al, [rsi]
		mov [rdi], al
		inc rdi
		cmp rsi, rbx
		jne ._flipStringCycle2

	ret
