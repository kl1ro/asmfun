bits 16
;
; Converts the Lba address to the Chs address
; Params: ax as the Lba address and some fat constants
; Output: cl
;	- ch - sector number
;	- cl - cylinder
;	- dh - head
;
_lbaToChs:
	mov di, dx
	xor dx, dx
	div word [bdb_sectors_per_track]
	inc dx
	mov cx, dx
	xor dx, dx
	div word [bdb_heads]
	mov dh, dl
	mov ch, al
	shl ah, 6
	or cl, ah
	mov ax, di
	mov dl, al
	ret	
