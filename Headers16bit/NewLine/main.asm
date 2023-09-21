;
;	Puts the screen cursor to the next line
;	utilizing the bios interrupt 0x10 
;
;	Input: 
;		- dh is a current page
;
;	Output:
;		- ah is equal to 0x2
;
;		- dl is equal to 0
;
;		- dh is incremented
;
;       Bios also can modify registers
;
_newLine:	
	mov ah, 0x3
	int 0x10
	mov ah, 0x2
	xor dl, dl
	inc dh
	int 0x10
	ret
