; input - rax as integer
; and rcx as integer exponential
_power:
	mov rbx, rax
	dec rcx

_powerCycle:	
	mul ebx
	loop _powerCycle
	ret
