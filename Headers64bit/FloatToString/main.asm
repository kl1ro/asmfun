;
; For this conversion I use that formula:
; number = (1 + mantissa) * 2 ^ exponent
;
_floatToString:

section .bss
    .ans resb 4

section .text
	fstp dword [.ans]
	
	;   
    ; Get the number
    ;   
    mov eax, [.ans]

	;
	; Check sign
	;
	bt eax, 31
	jnc ._ifNotMinus

	mov dl, 45
	mov [rdi], dl
	inc rdi

	._ifNotMinus:

	;
	; Get the exponent
	;
    mov rbx, 0x7F800000
    and ebx, eax 
    shr ebx, 23
    sub rbx, 127 

    ;   
    ; Get mantissa
    ;   
    mov rcx, 0x7FFFFF
    and ecx, eax 

	;
	; This is 1 + mantissa
	;
	mov rax, rcx
	or rax, 1 << 23	

	;
    ; Calculating 2 ^ exp
    ;
    mov rcx, rbx
    call _twoInThePowerOfN

    mov rbx, 8388608
	xor rdx, rdx
    div rbx 

	;
	; Convert the integer portion 
	; to string and save regs
	;
    mov r8, rdx 
    mov r9, rbx 
    call _intToString

	;
	; Add "." character
	;
    mov [rdi], byte 46
    inc rdi

	;
	; Convert the floating portion
	;
	mov rcx, 10
    mov rdx, r8
    mov rbx, r9
    mov r8, 10
    call _assignFloatingPortion
   	ret

;
; Input:
;   - rcx as a counter
;
;   - rbx as a devider
;
;   - rdx as a remainder
;
;   - r8 as 10
;
_assignFloatingPortion:
    mov rax, rdx
    mul r8
    xor rdx, rdx
    div rbx
    add al, 48
    mov [rdi], al
    inc rdi
    test rdx, rdx
    jz _break
    loop _assignFloatingPortion
    ret

;
; Multiply with 2 ^ exp
;
_twoInThePowerOfN:
    test rcx, rcx
    js _ifNegativePower
    jz _break
    jns _ifPositivePower

_ifNegativePower:
    neg rcx

_ifNegativePowerCycle:
    shr rax, 1
    loop _ifNegativePowerCycle
	ret

_ifPositivePower:
    shl rax, 1
    loop _ifPositivePower
	ret

