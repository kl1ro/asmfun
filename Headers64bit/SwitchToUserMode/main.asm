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
	push _user
	iretq