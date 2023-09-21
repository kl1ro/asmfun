;
;	Puts a cpu core into a waiting state. The cpu now
;	only responds to interrupts.
;
;	Input:
;		- nothing
;
;	Output:
;		- nothing
;
_chill:
	hlt 
	jmp _chill