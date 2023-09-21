;
;	Working on it. Don't use!
;
; Prints a debug string with all registers values
;
; Input:
;	- all registers
;
; Output:
; 	- all registers saved and 
;	their values are printed to
;	the screen
;
_getDebugString:
	;
	; Save all registers
	;
	call _pusha
	call _pusha
	
	;
	; Form a debug string
	;
	mov rdi, debugString + 6
	mov r9, rdi
	call _intToString
	mov rcx, 13
	add r9, 27	

_debugCycle:
	pop rax    
	mov rdi, r9	
	mov r10, rcx
        call _intToString
	mov rcx, r10
	add r9, 27
	loop _debugCycle
	
	;
        ; Print the debug string
        ;
        mov rsi, debugString
        call _print
	
	mov rdi, debugString + 5
	mov rcx, 14
	mov rax, 0x2020202020202020

_debugStringClearCycle:
	mov [rdi], rax
	add rdi, 8
	mov [rdi], rax
	add rdi, 19
	loop _debugStringClearCycle
	
	call _popa
	ret
