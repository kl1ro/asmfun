; load ax sectors to ES : BX from drive DL
_diskLoad:
	mov si, ax
	; Store ax in si so later we can recall
	; how many sectors were request to be read ,
	; even if it is altered in the meantime
	mov ah , 0x02
	; BIOS read sector function
	mov ch , 0x00
	; Select cylinder 0
	mov dh , 0x00
	; Select head 0
	mov cl , 0x02
	; Start reading from second sector ( i.e.
	; after the boot sector )
	int 0x13
	; BIOS interrupt
	jc _diskLoadError	; Jump if error ( i.e. carry flag set )
	and ax, 0xFF
	mov di, ax
	cmp si, di
	jne _diskMismatch
	ret

;display error message
_diskLoadError:
	mov si, diskLoadFailed
	call _printText
	jmp _waitForKeyAndReboot

_diskMismatch:
	mov si, diskLoadMismatch
	call _printText
	mov si, diskLoadFailed
	call _printText
	jmp _waitForKeyAndReboot

%include "../../AsmFun/Headers16bit/DiskLoadRes/main.asm"
