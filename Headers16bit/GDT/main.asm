; GDT
gdtStart:

gdtNull:	 	; The mandatory null descriptor
	dd 0x0
	dd 0x0

gdtCode: 		; The code segment descriptor

		; Base = 0x0, limit = 0xfffff,
		; 1st flags: (present)1 (privilege)00 - full (descriptor type)1 -> 1001b
		; Type flags: (code)1 (conforiming)0 (readable)1 (accessed)0 -> 1010b
		; 2nd flags: (granularity)1 (32-bit defalult)1 (64-bit seg)0 (AVL)0 - > 1100b

	dw 0ffffh	; Limit (bits 0 - 15)
	dw 0x0		; Base (bits 0 - 15)
	db 0x0		; Base (bits 16 - 23)
	db 10011010b	; 1st flags, type flags
	db 11001111b 	; 2nd flags, Limit (bits 16 - 19)
	db 0x0		; Base (bits 24 - 31)

gdtData: 		; The data segment descriptor

		; Same as code segment except for the type flags:
		; Type flags: (code)0 (expand down)0 (writable)1 (accessed)0 -> 0010b

	dw 0ffffh       ; Limit (bits 0 - 15)
        dw 0x0          ; Base (bits 0 - 15)
        db 0x0          ; Base (bits 16 - 23)
	db 10010010b	; 1st flags, type flags
	db 11001111b 	; 2nd flags, Limit (bits 16-19)
	db 0x0		; Base (bits 24-31)

gdtCode16:
	dw 0ffffh       ; Limit (bits 0 - 15)
        dw 0x0          ; Base (bits 0 - 15)
        db 0x0          ; Base (bits 16 - 23)
        db 10010010b    ; 1st flags, type flags
        db 00001111b    ; 2nd flags, Limit (bits 16-19)
        db 0x0          ; Base (bits 24-31)	

gdtData16:
	dw 0ffffh       ; Limit (bits 0 - 15)
        dw 0x0          ; Base (bits 0 - 15)
        db 0x0          ; Base (bits 16 - 23)
        db 10010010b    ; 1st flags, type flags
        db 00001111b    ; 2nd flags, Limit (bits 16-19)
        db 0x0          ; Base (bits 24-31)
	
gdtEnd:
	
	; The reason for putting a label at the end of the
	; GDT is so we can have the assembler calculate
	; the size of the GDT for the GDT decriptor (below)

; GDT descriptor
gdtDescriptor:
	dw gdtEnd - gdtStart - 1	; Size of our GDT, always less one
					; of the true size
	dd gdtStart			; Start address of our GDT

; Define some handy constants for the GDT segment descriptor offsets, which
; are what segment registers must contain when in protected mode. For example,
; when we set DS = 0x10 in PM, the CPU knows that we mean it to use the
; segment described at offset 0x10 (i.e. 16 bytes) in our GDT, which in our
; case is the DATA segment (0x0 -> NULL; 0x08 -> CODE; 0x10 -> DATA)
CODE_SEG equ gdtCode - gdtStart
DATA_SEG equ gdtData - gdtStart
