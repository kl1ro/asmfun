;
; Prints a debug string with all registers values
;
; Input:
;	- all registers
;
; Output:
; 	- rsi points to the debug string
;
_getDebugString:
	;
	; Save all registers
	;
	push r15
        push r14
        push r13
        push r12
        push r11
        push r10
        push r9
        push r8
        push rdi
        push rsi
        push rdx
        push rcx
        push rbx
        push rax
	push r15
        push r14
        push r13
        push r12
        push r11
        push r10
        push r9
        push r8
        push rdi
        push rsi
        push rdx
        push rcx
        push rbx
	
	;
	; Form a debug string
	;
	mov rdi, debugString
	add rdi, 6
	mov r9, rdi
	call _intToString
	mov rcx, 13
	add r9, 20	

_debugCycle:
	pop rax    
	mov rdi, r9	
	mov r10, rcx
        call _intToString
	mov rcx, r10
	add r9, 21
	loop _debugCycle
	
	;
	; Restore all registers
	;
	pop rax
	pop rbx
	pop rcx		
	pop rdx
	pop rsi
	pop rdi
	pop r8
	pop r9
	pop r10	
	pop r11	
	pop r12
	pop r13
	pop r14
	pop r15
	;
        ; Print the debug string
        ;
        mov rsi, debugString
        call _printSafe
	ret
