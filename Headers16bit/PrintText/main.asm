bits 16
_print:                                 ; Routine: output reading in si to screen
        mov ah, 0x0e                    ; int 10h 'print char' function

_printCycle:
        lodsb                           ; Get character from reading
        or al, al
        jz _break                       ; If char is zero, end of reading
        int 10h                         ; Otherwise, print it
        jmp _printCycle
