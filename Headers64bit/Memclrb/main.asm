;
; Puts zeros into memory
;
; Input:
;	- rdi as a pointer to memory
;	- rcx as amount of bytes to clear
;
; Output:
;	- al equals to 0
;
;	- rdi points to the memory + rcx
;
;	- rcx remains the same
;
_memclrb:
        mov al, 0
        mov [rdi], al
        inc rdi
        loop _memclrb
        ret

