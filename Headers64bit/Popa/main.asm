;
;	Pops all the general cpu registers from the stack
;
;	Input:
;		- nothing
;	
;	Output:
;		- rax is modified
;
;		- rbx is modified
;
;		- rcx is modified
;
;		- rdx is modified
;
;		- rsi is modified
;
;		- rdi is modified
;
;		- r8 is modified
;
;		- r9 is modified
;
;		- r10 is modified
;
;		- r11 is modified
;
;		- r12 is modified
;
;		- r13 is modified
;
;		- r14 is modified
;
;		- r15 is modified
;
;		- rsp is modified
;
;		- stack is modified
;
_popa:
	mov rax, [rsp + 0x70]
	pop rbx
	mov [rsp + 0x68], rbx
	pop r15
	pop	r14
	pop r13
	pop r12
	pop r11
	pop r10
	pop r9
	pop r8
	pop rdi
	pop rsi
	pop rdx
	pop rcx
	pop rbx
	ret