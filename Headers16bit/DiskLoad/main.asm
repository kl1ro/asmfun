bits 16
;
; Reads sectors from the disk
; Parameters:
; 	- ax as an Lba address
;	- cl is amount of sectors to read (up to 128)
; 	- dl is a drive number
;	- es:bx: memory address where to store read data
;
_diskLoad:
	mov si, cx
	call _lbaToChs
	mov ax, si	
	mov ah, 02h
	mov di, 3

_diskLoadCycle:
	mov si, ax
	stc
	int 13h
	mov ax, si
	jnc _break
	call _diskReset
	dec di
	test di, di
	jnz _diskLoadCycle
	
_diskLoadFailed:
        mov si, diskLoadFailed
        call _printText
        jmp _waitForKeyAndReboot

;
; Resets a disk controller
; Parameters: dl as a drive number
;
_diskReset:
	mov ah, 0
	stc
	int 13h
	jc _diskLoadFailed
	ret	


