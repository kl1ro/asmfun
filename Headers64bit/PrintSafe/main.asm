;
; Prints a text string with
; saving all registers
;
; Input:
;	- rsi is a pointer to string
;
; Output:
;	- nothing but text is printed
;
_printSafe:
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
        
	call _print

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
        ret

