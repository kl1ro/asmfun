cli		; Disable interrupts

; Clear some memory from paging
mov edi, 0x1000
mov cr3, edi
xor eax, eax
mov ecx, 4096
rep stosd
mov edi, 0x1000

; PML4T -> 0x1000
; PDPT  -> 0x2000
; PDT   -> 0x3000
; PT    -> 0x4000

; Filling
mov dword [edi], 0x2003
shl edi, 1
mov dword [edi], 0x3003
or edi, 0x1000
mov dword [edi], 0x4003
add edi, 0x1000

mov ebx, 3
mov ecx, 0x200

.setEntry:
	mov dword [edi], ebx
	add ebx, 0x1000
	add edi, 8
	loop .setEntry

; Set 5th bit in control reg 4
; Meaning Paging is on
mov eax, cr4
or eax, 1 << 5
mov cr4, eax

; We're in compatibility mode
; Meaning we have 64 bit address space
; but only 16 and 32 bit instructions
mov ecx, 0xc0000080
rdmsr
or eax, 1 << 8
wrmsr

mov eax, cr0
or eax, 0x80000001
mov cr0, eax

lgdt [GDTLM.Pointer]
jmp GDTLM.Code:_startLM
