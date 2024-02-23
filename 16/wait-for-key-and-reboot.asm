;
;   Waits for user key enter and reboots the system
;   utilizing bios interrupt 0x16
;
;   Input:
;       - nothing
;
;   Output:
;       - nothing
;
_waitForKeyAndReboot:
	mov ah, 0
	int 0x16
	jmp 0ffffh:0
