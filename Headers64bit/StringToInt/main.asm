; input - r9 as pointer to string
_stringToInt:
	mov rcx, 0
	xor r8, r8
	call _stringToIntCycle
	jmp _stringToIntNext

_stringToIntCycle:
        mov al, [r9]
	cmp al, 32
	je _break	
	cmp al, 45
	je _stringToIntMinus
	cmp al, 10
	je _break
        cmp al, 0
        je _break
        cmp al, 48
        jl _stringToIntCycle
        cmp al, 57
        ja _stringToIntCycle
	inc rcx
	inc r9
	jmp _stringToIntCycle

_stringToIntMinus:
	inc r9
	cmp r8, 0
	je _stringToIntAddMinus
	jne _stringToIntRemoveMinus

_stringToIntAddMinus:
	inc r8
	jmp _stringToIntCycle

_stringToIntRemoveMinus:
	dec r8
	jmp _stringToIntCycle

_stringToIntNext:
	dec r9
	dec rcx
	xor rsi, rsi
	xor rdx, rdx
	mov sil, [r9]
	sub rsi, 48
	mov r10, 10
	mov r11, 10
	cmp rcx, 0
	jne _stringToIntSecondCycle
	mov rax, rsi
	cmp r8, 1
	je _negate
	ret		

_stringToIntSecondCycle:
	dec r9 
	mov rax, r10
	mov dil, [r9]
	sub dil, 48
	mul edi
	add rsi, rax
	mov rax, r10
	mul r11d
	mov r10, rax
	dec rcx
	cmp rcx, 0
	jne _stringToIntSecondCycle
	mov rax, rsi
	cmp r8, 1	
	je _negate
	ret
	

