;
;	Raises an integer to the power of input
;
;	Input:
;		- rax as an integer
;
;		- rcx as integer exponential
;
;	Output:
;		- rbx is equal to rax at the start point
;
;		- rax is raised to the power of rcx
;
;		- rcx is equal to 0
;
_pow:
	mov rbx, rax
	dec rcx
	test rcx, rcx
	jz _break

	._powCycle:	
		mul ebx
		loop ._powCycle
	
	ret
