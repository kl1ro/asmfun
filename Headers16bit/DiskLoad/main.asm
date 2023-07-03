;
; Loads ax sectors to ES : BX from drive DL
;
; Output:
; 	- ah is modified
;
;	- cx is modified
;
;	- si is modified
;
;	- dh is modified
;
;	- di is modified
;
_diskLoad:
	;
	; Store ax in si so later we can recall
	; how many sectors were request to be read,
	; even if it is altered in the meantime
	;
	mov si, ax

	;
	; BIOS read sectors function
	;
	mov ah , 0x02

	;
	; Select cylinder 0
	;
	xor ch, ch

	;
	; Select head 0
	;
	xor dh, dh

	;
	; Select the sector 2
	;
	mov cl , 0x02
	
	;
	; Start reading
	;
	int 0x13

	;
	; Jump if error ( i.e. carry flag set )
	;
	jc _diskLoadError	

	;
	; Check the sectors count
	;
	xor ah, ah
	cmp ax, si
	jne _diskMismatch
	ret

;
; Display error message
;
_diskLoadError:
	mov si, diskLoadFailed
	call _print
	jmp _waitForKeyAndReboot

_diskMismatch:
	mov si, diskLoadMismatch
	call _print
	mov si, diskLoadFailed
	call _print
	jmp _waitForKeyAndReboot

%include "../../AsmFun/Headers16bit/DiskLoadRes/main.asm"
