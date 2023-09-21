;
;	Switches the system from ring 0 to ring 3
;
;	Input:
;		- rsi as an user mode enter point
;
;	Output:
;		- ax is modified
;
;		- ds is modified
;
;		- es is modified
;
;		- gs is modified
;
;		- fs is modified
;
_switchToUserMode:
	mov ax, 0x23
	mov ds, ax
	mov es, ax
	mov gs, ax
	mov fs, ax
	push ax
	push rsp
	pushfq
	push 0x1b
	push rsi
	iretq