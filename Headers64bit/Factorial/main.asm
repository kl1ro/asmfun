;
;	Calculates the factorial
;
;	Input:
;		- rbx as an integer
;
;	Output:
;		- rax is equal to the factorial of rax
;
;		- rax = -1 if the factorial doesn't exist
;
_factorial:
	mov rax, 1
	cmp rbx, 0
	ja _factorialCycle
	je _break 
	neg rax
	ret

	._factorialCycle:
		mul ebx
		dec ebx
		cmp rbx, 1
		jne _factorialCycle
	
	ret