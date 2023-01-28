; input - rbx as an integer
_factorial:
        mov rax, 1
        cmp rbx, 0
        je _break

_factorialCycle:
        mul ebx
        dec ebx
        cmp rbx, 1
        jne _factorialCycle
        ret
