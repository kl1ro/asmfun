;
;	Working on it. Don't use!
;
;	For this conversion I use that formula:
;	number = (1 + mantissa) * 2 ^ exponent
;
_dtoa:

    .ans resb 8
	.ans2 resb 64

	fstp qword [.ans]
	
	;	  
    ;	Get the number
    ;	  
    mov rax, [.ans]

	;
	;	Check sign
	;
	bt rax, 63
	jnc ._ifNotMinus

	mov dl, 45
	mov [rdi], dl
	inc rdi

	._ifNotMinus:

	;
	;	Get the exponent
	;
    mov rbx, 0x7FF0000000000000
    and rbx, rax 
    shr rbx, 52
    sub rbx, 127 
	mov rax, rbx
	mov rdi, ans2
	call _itoa
	mov rsi, ans2
	call _print
	jmp _exit

    ;	  
    ;	Get mantissa
    ;	  
    mov rcx, 0xFFFFFFFFFFFFF
    and rcx, rax 

	;
	;	This is 1 + mantissa
	;
	xor rdx, rdx
	mov rax, rcx
    add rax, 0x1000000000000

	;
    ;	Calculating 2 ^ exp
    ;
    mov rcx, rbx
    call _twoInThepowOfN

    mov rbx, 0x10000000000000
    div rbx 

	;
	;	Convert the integer portion 
	;	to string and save regs
	;
    mov r9, rdx 
    mov r10, rbx 
    call _itoa

	;
	;	Add "." character
	;
    mov [rdi], byte 46
    inc rdi

	;
	;	Convert the floating portion
	;
	mov rcx, 10
    mov rdx, r9
    mov rbx, r10
    mov r8, 10
    call _assignFloatingPortion
   	ret

;
;	Input:
;	  - rcx as a counter
;
;	  - rbx as a devider
;
;	  - rdx as a remainder
;
;	  - r8 as 10
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
;	Multiply with 2 ^ exp
;
_twoInThepowOfN:
    test rcx, rcx
    js _ifNegativepow
    jz _break
    jns _ifPositivepow

_ifNegativepow:
    neg rcx

_ifNegativepowCycle:
    shr rax, 1
    loop _ifNegativepowCycle
	ret

_ifPositivepow:
    shl rax, 1
    loop _ifPositivepow
	ret

