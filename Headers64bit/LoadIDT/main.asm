_loadIDT:
	;
	; Define an empty idt gate	
	;
	mov rsi, _ignoreInterruptHandler
	mov rdi, IDTInterruptGatePattern
	call _defineIDTInterruptGate
	
	mov rbx, 33
	mov rdi, 0x7e00
	call _loadIDTCycle

	;
	; Keyboard interrupt handler
	;
	mov rbx, rdi
	mov rsi, _keyboardInterruptHandler
	mov rdi, IDTInterruptGatePattern
	call _defineIDTInterruptGate
	mov rdi, rbx
	mov rbx, 1
	call _loadIDTCycle

	;	
	; Restore ignore interrupt handler
	;	
	mov rbx, rdi
	mov rsi, _ignoreInterruptHandler
        mov rdi, IDTInterruptGatePattern
        call _defineIDTInterruptGate
	mov rdi, rbx
	mov rbx, 222
	call _loadIDTCycle	

	;
	; Set up PIC
	;
	mov al, 0x11
        out 0x20, al
        out 0xa0, al
        mov al, 0x20
        out 0x21, al
        mov al, 0x28
        out 0xa1, al
        mov al, 0x04
        out 0x21, al
        mov al, 0x02
        out 0xa1, al
        mov al, 0x01
        out 0x21, al
        out 0xa1, al
        mov al, 0x0
        out 0x21, al
        out 0xa1, al

	;	
	; Load prepared IDT
	; 
	lidt [IDTPointer]
	
	;
	; Set interrupt flag
	;
	sti
	ret	

;
; Loads IDT vectors into IDT
;
; Input:
;	- rdi as a pointer to memory
;
;	- rbx as a counter for cycle
;
; Output:
;	- rbx equals to 0
;
;	- rcx is 2
;
;	- rsi points to the end of the 
;	IDTInterruptGatePattern
;
_loadIDTCycle:
	dec rbx	
	mov rsi, IDTInterruptGatePattern
	mov rcx, 2
	call _memcpyq
	test rbx, rbx
	jnz _loadIDTCycle
	ret

;
; Defines idt interrupt gate.
; In other words it copies a pointer
; to an interrupt service routine to 
; the already prepared interrupt idt gate
;
; Input:
;       - rsi as a pointer to an interrupt handler
;       (interrupt service routine)
;
;       - rdi as a pointer to an interrupt 
;       gate we define
;
; Output:
;       - rdi is modified
;
;	- rsi shifted by 16 bit to the right
;
;	- rax is modified
;
_defineIDTInterruptGate:
        ;
        ; Offset (0 - 15)
        ;
        mov [rdi], si
        add rdi, 6

        ;
        ; Offset (48 - 63)
        ;
        mov eax, esi
        shr eax, 16
        mov [rdi], ax
        add rdi, 2

        ;
        ; Offset (64 - 95)
        ;
        shr rsi, 32
        mov [rdi], esi
        ret

%include "../../Utilities/AsmFunOs/src/interrupts/interruptServiceRoutines/IgnoreInterruptHandler/main.asm"
%include "../../Utilities/AsmFunOs/src/interrupts/interruptServiceRoutines/KeyboardInterruptHandler/main.asm"
%include "../../Utilities/AsmFunOs/src/interrupts/resources/IDTInterruptGatePattern/main.asm"

IDTPointer:
        dw 4096
        dq 0x7e00
