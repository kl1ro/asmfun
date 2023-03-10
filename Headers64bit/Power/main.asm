;
; Raises an integer to the power
;
; Input:
;	- rax as an integer
;
;	- rcx as integer exponential
;
; Output:
;
;	- rbx equals to rax at the start point
;
;	- rax is raised to the power of rcx
;
;	- rcx equals to 0
;
_power:
	mov rbx, rax
	dec rcx
	test rcx, rcx
	jz _break

_powerCycle:	
	mul ebx
	loop _powerCycle
	ret
