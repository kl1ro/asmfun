_getDebugString:
        push r11
        push r10
        push r9
        push r8
        push rdi
        push rdx
        push rcx
	push rax
	push r15
        push r14
        push r13
        push r12
        push r11
        push r10
        push r9
        push r8
        push rdi
        push rsi
        push rdx
        push rcx
        push rbx
	mov r9, debugString
	mov r10, r9
	add r9, 6
	call _minusCheck
	mov r8, temp
	mov rcx, 10
	call _assignTempIntegerPortion
	call _flipTemp
	mov rdi, 0
	add r10, 19

_debugCycle:
	inc rdi
	pop rax    
	mov r9, r10	
        call _minusCheck
	mov rcx, 10
	mov r8, temp
        call _assignTempIntegerPortion
        call _flipTemp	
	add r10, 13
	cmp rdi, 13
	jne _debugCycle
	pop rax
	pop rcx		
	pop rdx
	pop rdi
	pop r8
	pop r9
	pop r10	
	pop r11
	ret
