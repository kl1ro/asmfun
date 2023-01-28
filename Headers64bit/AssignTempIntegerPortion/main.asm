; Input - rax as integer, r8 as pointer to temp
_assignTempIntegerPortion:
        xor rdx, rdx
        div rcx
        add rdx, 48
        mov [r8], dl
        inc r8
        cmp rax, 0
        jne _assignTempIntegerPortion
        ret
