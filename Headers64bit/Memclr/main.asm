;
; Puts zeros to the memory
;
; Input:
;	- rdi as a pointer to memory
;	- rcx as amount of bytes to clear
;
; Output:
;
;
;
_memclr:
        mov al, 0
        mov [rdi], al
        inc rdi
        loop _memclr
        ret

