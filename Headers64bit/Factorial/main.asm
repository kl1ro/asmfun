; Calculates the factorial
;
; Input:
;	rbx as an integer
;
; Output:
;	- rax equals to factorial of rax
;
;	- rax is -1 if factorial 
;	doesn't exist
;

_factorial:
        mov rax, 1
        cmp rbx, 0
        je _break
	jl _negate

_factorialCycle:
        mul ebx
        dec ebx
        cmp rbx, 1
        jne _factorialCycle
        ret
