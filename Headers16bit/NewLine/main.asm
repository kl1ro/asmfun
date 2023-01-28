bits 16

; Input: bh is a current page
_newLine:	
	mov ah, 03h
	int 10h
	mov ah, 02h
	xor dl, dl
	inc dh
	int 10h
	ret
