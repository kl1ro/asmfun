%include "../../AsmFun/Headers64bit/KeyboardInterruptHandler/main.asm"
IDTPointer:
        dw 4096
        dq IDT
IDT:

