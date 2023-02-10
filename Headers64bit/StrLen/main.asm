;
; Counts length of the string except \0 and \n
;
; Input:
;	- rsi as a pointer to string
;
; Output:
;	- rcx equals to the length
;	of the string
;
;	- al is modified
;
;	- rsi points to the end 
;	of the string
;
_strLen:
	xor rcx, rcx
	call _strLenCycle
	ret
	
_strLenCycle:
	inc rcx
	inc rsi
	mov al, [rsi]
	cmp al, 10
	je _strLenCycle
	cmp al, 0
	jne _strLenCycle
	ret
