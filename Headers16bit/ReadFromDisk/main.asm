;
;	Error messages
;
readFromDiskFailed db "Disk load failed!", 0
readFromDiskComplete db "Disk load complete!", 0
readFromDiskMismatch db "Disk sectors mismatch! ", 0

;
;	Loads ax sectors to es:bx from dl drive starting
;	from the second sector
;
;	Input:
;		- ax as the number of sectors
;
;		- es:bx as the memory location to read the data to
;
;		- dl as the disk drive number
;
;	Output:
;		- ah is modified
;
;		- cx is modified
;
;		- si is modified
;
;		- dh is modified
;
;		- di is modified
;
;       Bios also can modify registers
;
_readFromDisk:
	;
	;	Store ax in si so later we can recall
	;	how many sectors were request to be read,
	;	even if it is altered in the meantime
	;
	mov si, ax

	;
	;	BIOS read sectors function
	;
	mov ah , 0x02

	;
	;	Select cylinder 0
	;
	xor ch, ch

	;
	;	Select head 0
	;
	xor dh, dh

	;
	;	Select the sector 2
	;
	mov cl , 0x02
	
	;
	;	Start reading
	;
	int 0x13

	;
	;	Jump to the next check if no error
	;
	jnc ._loadSuccess

	;
	;	Print load error message
	;
    mov si, readFromDiskFailed
	call _print
	jmp _waitForKeyAndReboot

	;
	;	Check the sectors count match
	;
	._loadSuccess:
	xor ah, ah
	cmp ax, si
	je ._sectorCountMatch

	;
	;	Print sector count mismatch error
	;
    mov si, readFromDiskMismatch
	call _print
	mov si, readFromDiskFailed
	call _print
	jmp _waitForKeyAndReboot

	;
	;	Continue program execution
	;
	._sectorCountMatch:
	ret