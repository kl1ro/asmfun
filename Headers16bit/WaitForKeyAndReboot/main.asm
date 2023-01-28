bits 16
_waitForKeyAndReboot:
	mov ah, 0
	int 16h
	jmp 0ffffh:0
