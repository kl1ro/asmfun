;
; This is a function that loads
; memory from the source to the 
; destination
;
; Input:
;       rsi is a pointer to source
;       rdi is a pointer to the destination
;       rcx is amount of words to copy
;
; Output:
;       - ax is modified
;
;       - rsi points to the rsi + rcx
;
;       - rdi points to the rdi + rcx
;
_memcpyw:
        mov ax, [rsi]
        mov [rdi], ax
        inc rsi
        inc rdi
        loop _memcpyw
        ret
