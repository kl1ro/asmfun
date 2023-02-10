bits 16

;
; Puts the cursor on the screen to
; the next line
;
; Input: 
;	- dh is a current page
;
; Output:
;	- ah equals to 02h
;
;	- dl equals to 0
;
;	- dh is incremented
;
_newLine:	
	mov ah, 03h
	int 10h
	mov ah, 02h
	xor dl, dl
	inc dh
	int 10h
	ret
