;
;   This function copies the string 
;   pointed by rsi to rdi
;
;   Input:
;       - rsi as pointer to memory
;
;       - rdi as pointer to memory
;
;
;   Output:
;       - rsi is modified
;
;       - rdi is modified
;
_strcpy:
    mov al, [rsi]
    test al, al
    jz _break
    mov [rdi], al
    inc rsi
    inc rdi
    jmp _strcpy