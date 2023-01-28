; Input - r9 as a pointer to string
_printText:
        xor rdi, rdi
	mov rax, r9

_stringCountLoop:
        inc r9
        inc rdi
        mov cl, [r9]
        cmp cl, 0
        jne _stringCountLoop
	mov rsi, rax
        mov rax, 1
	mov rdx, rdi
        mov rdi, 1
        syscall
        ret
