;
; Exits from the user program
;
; Input:
;	- nothing
;
; Output:
;	- nothing but program is terminated
;
_exit:
        mov rax, 60
        mov rdi, 0
        syscall

