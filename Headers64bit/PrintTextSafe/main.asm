; Input - r9 as a pointer to string
_printTextSafe:
	push rdi
	push rax
	push rcx
	push rsi
	push rdx
	push r11
	push r9
        xor rdi, rdi
	mov rax, r9

_stringCountLoopSafe:
        inc r9
        inc rdi
        mov cl, [r9]
        cmp cl, 0
        jne _stringCountLoopSafe
	mov rsi, rax
        mov rax, 1
	mov rdx, rdi
        mov rdi, 1
        syscall
	pop r9
	pop r11
	pop rdx
	pop rsi
	pop rcx
	pop rax
	pop rdi
        ret
