; Input - r8 as pointer to end of temp, r9 as pointer to num
_flipTemp:
        dec r8
        mov cl, [r8]
        mov [r9], cl
        inc r9
        cmp r8, temp
        jne _flipTemp
        ret
