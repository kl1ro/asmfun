;
; This function hults machine
; (meaning it stops it)
;
_haltMachine:
	cli 		; This way now we can't go out of hlt
	hlt
