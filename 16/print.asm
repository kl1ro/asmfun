;
;   Prints a line to the screen
;
;   Input:
;       - si as a pointer to screen
;
;   Output:
;       - ax is modified
;
;       - si is modified
;
;       Bios also can modify registers
;
_print:                                 
    mov ah, 0x0e                    
    
    ._printCycle:
        lodsb                           
        or al, al
        jz _break                       
        int 10h                         
        jmp ._printCycle
