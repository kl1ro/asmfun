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
	; Division by 0 fault (id 0)
	;
	mov rsi, _divisionBy0Handler
	mov rdi, IDTInterruptGatePattern
	call _defineIDTInterruptGate
	mov rbx, 1
	mov rdi, IDT_OFFSET
	call _loadIDTCycle
	
	;
	; Empty idt gates	
	;
	add rdi, 5 * 16

	;
	; Invalid opcode fault (id 6)
	;
	mov rbx, rdi
	mov rsi, _invalidOpcodeInterruptHandler
	mov rdi, IDTInterruptGatePattern
	call _defineIDTInterruptGate
	mov rdi, rbx
	mov rbx, 1
	call _loadIDTCycle

	;
	; Device not available fault (id 7)
	;
	mov rbx, rdi
	mov rsi, _deviceNotAvailableInterruptHandler
	mov rdi, IDTInterruptGatePattern
	call _defineIDTInterruptGate
	mov rdi, rbx
	mov rbx, 1
	call _loadIDTCycle

	;
	; Empty idt gates	
	;
	add rdi, 2 * 16

	;
	; Invalid TSS fault (id 10)
	;
	mov rbx, rdi
	mov rsi, _invalidTSSInterruptHandler
	mov rdi, IDTInterruptGatePattern
	call _defineIDTInterruptGate
	mov rdi, rbx
	mov rbx, 1
	call _loadIDTCycle

	;
	; Segment not present fault (id 11)
	;
	mov rbx, rdi
	mov rsi, _segmentNotPresentInterruptHandler
	mov rdi, IDTInterruptGatePattern
	call _defineIDTInterruptGate
	mov rdi, rbx
	mov rbx, 1
	call _loadIDTCycle

	;
	; Stack-segment fault (id 12)
	;
	mov rbx, rdi
	mov rsi, _stackSegmentFaultInterruptHandler
	mov rdi, IDTInterruptGatePattern
	call _defineIDTInterruptGate
	mov rdi, rbx
	mov rbx, 1
	call _loadIDTCycle

	;
	; General protection fault (id 13)
	;
	mov rbx, rdi
	mov rsi, _generalProtectionFaultInterruptHandler
	mov rdi, IDTInterruptGatePattern
	call _defineIDTInterruptGate
	mov rdi, rbx
	mov rbx, 1
	call _loadIDTCycle

	;
	; Page fault (id 14)
	;
	mov rbx, rdi
	mov rsi, _pageFaultInterruptHandler
	mov rdi, IDTInterruptGatePattern
	call _defineIDTInterruptGate
	mov rdi, rbx
	mov rbx, 1
	call _loadIDTCycle

	;
	; Empty idt gate	
	;
	add rdi, 16

	;
	; x87 Floating-point exception (id 16)	
	;
	mov rbx, rdi
	mov rsi, _floatingPointExceptionHandler
	mov rdi, IDTInterruptGatePattern
	call _defineIDTInterruptGate
	mov rdi, rbx
	mov rbx, 1
	call _loadIDTCycle

	;
	; Empty idt gates	
	;
	add rdi, 15 * 16

	;
	; Clock interrupt handler idt gate (id 32)	
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
	; Empty idt gates
	;	
	add rdi, 94 * 16

	;
	; System call interrupt (id 128)
	;	
	mov rbx, rdi
	mov rsi, _syscallHandler
	mov rdi, IDTInterruptGatePattern
	call _defineIDTInterruptGate			
	mov rdi, rbx
	mov rbx, 1
	call _loadIDTCycle	
	
	;	
	; Then go 127 empty idt gates
	;		
	; ...
	;

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

IDTPointer:
	dw 4096
	dq IDT_OFFSET
