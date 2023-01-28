bits 16

; Switch to a Protected Mode
_switchToPM:
	cli 			; We must switch of interrupts until we have 
				; setup the Protected Mode interrupt vector
				; otherwise interrupts will run riot
	
	lgdt [gdtDescriptor]	; Load our Global Descriptor Table, which defines
				; the protected mode segments  (e.g. for code and data)
	mov eax, cr0		; To make the switch to protected mode, we set
	or eax, 0x1		; the first bit of cr0, a control register
	mov cr0, eax
	jmp dword CODE_SEG:_initPM	; and make a far jump (i.e. to a new segment) to our 32-bit
				; code. This also forces the CPU to flush its cache of pre-fetched and real-mode 
				; decoded instructions, which cause problems

bits 32

; Initialise registers and the stuck once in PM

_initPM:	
	mov ax, DATA_SEG
    	mov ds, ax
    	mov ss, ax
    	mov es, ax
    	mov fs, ax
    	mov gs, ax
    	mov ebp , 0x90000
    	mov esp , ebp
	jmp _beginPM		; Finally, call some well-known label
