IDT_OFFSET equ 0x0

;
; This function is for your operating system development
; pleasure. This loads the idt table into address 0x0
; and sets it up so the cpu can access it.
;
; Input:
;	- nothing at all
;
; Output:
;	- rax is modified
;
;	- rbx is 0
;
;	- rcx is 0
;
;	- rsi is modified
;
;   - rdi points to the end of the IDT
;
_loadIDT:
	;
	; Division by 0 interrupt (id 0)
	;
	mov rsi, _divisionBy0Handler
	mov rdi, IDTInterruptGatePattern
	call _defineIDTInterruptGate
	mov rbx, 1
	mov rdi, IDT_OFFSET
	call _loadIDTCycle
	
	;
	; Define an empty idt gate	
	;
	mov rbx, rdi
	mov rsi, _ignoreInterruptHandler
	mov rdi, IDTInterruptGatePattern
	call _defineIDTInterruptGate
	mov rdi, rbx
	mov rbx, 31
	call _loadIDTCycle

	;
	; Define a clock interrupt handler idt gate (id 32)	
	;
	mov rbx, rdi
	mov rsi, _clockInterruptHandler
	mov rdi, IDTInterruptGatePattern
	call _defineIDTInterruptGate
	mov rdi, rbx
	mov rbx, 1
	call _loadIDTCycle

	;
	; Keyboard interrupt handler (id 33)
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
	mov rbx, 94
	call _loadIDTCycle	

	;
	; Load system call interrupt
	;	
	mov rbx, rdi
	mov rsi, _syscallHandler
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
	mov rbx, 127
	call _loadIDTCycle	

	;
	; Set up the PIC
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
;    	- rsi shifted by 16 bit to the right
;
;	    - rax is modified
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

%include "../../Utilities/Oasis/src/interrupts/interruptServiceRoutines/DivisionBy0Handler/main.asm"
%include "../../Utilities/Oasis/src/interrupts/interruptServiceRoutines/IgnoreInterruptHandler/main.asm"
%include "../../Utilities/Oasis/src/interrupts/interruptServiceRoutines/KeyboardInterruptHandler/main.asm"
%include "../../Utilities/Oasis/src/interrupts/interruptServiceRoutines/ClockInterruptHandler/main.asm"
%include "../../Utilities/Oasis/src/interrupts/interruptServiceRoutines/SyscallHandler/main.asm"
%include "../../Utilities/Oasis/src/interrupts/resources/IDTInterruptGatePattern/main.asm"

IDTPointer:
	dw 4096
	dq IDT_OFFSET
