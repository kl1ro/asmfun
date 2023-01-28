bits 16
_printText:                             ; Routine: output reading in si to screen
        mov ah, 0x0e                    ; int 10h 'print char' function

_printTextCycle:
        lodsb                           ; Get character from reading
        or al, al
        jz _break                       ; If char is zero, end of reading
        int 10h                         ; Otherwise, print it
        jmp _printTextCycle
