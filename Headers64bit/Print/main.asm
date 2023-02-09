;
; Print a text string
;
; Input:
;	- rsi as a pointer to
;	a source string
;
; Output:
;	- rax equals to length of the string
;
;	- rcx is modified
;
;       - rdx equals to length of the string
;
;       - rsi is modified
;
;	- rdi equals to 1
;
;       - r11 is modified
;
_print:
        xor rdi, rdi
	mov rax, rsi

_stringCountLoop:
        inc rsi
        inc rdi
        mov cl, [rsi]
        cmp cl, 0
        jne _stringCountLoop
	mov rsi, rax
        mov rax, 1
	mov rdx, rdi
        mov rdi, 1
	syscall
        ret
