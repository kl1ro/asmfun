;
;	Pushes all the general cpu registers to the stack
;
;	Input:
;		- rax
;
;		- rbx
;
;		- rcx
;
;		- rdx
;
;		- rsi
;
;		- rdi
;
;		- r8
;
;		- r9
;
;		- r10
;
;		- r11
;
;		- r12
;
;		- r13
;
;		- r14
;
;		- r15
;	
;	Output:
;		- rax is modified
;
;		- rsp is modified
;
;		- stack is modified
;	
_pusha:
	mov [rsp - 0x8], rax
	mov rax, [rsp]
	mov [rsp - 0x70], rax
	mov rax, [rsp - 0x8]
	mov [rsp], rax
	mov [rsp - 0x8], rbx
	mov [rsp - 0x10], rcx
	mov [rsp - 0x18], rdx
	mov [rsp - 0x20], rsi
	mov [rsp - 0x28], rdi
	mov [rsp - 0x30], r8
	mov [rsp - 0x38], r9
	mov [rsp - 0x40], r10
	mov [rsp - 0x48], r11
	mov [rsp - 0x50], r12
	mov [rsp - 0x58], r13
	mov [rsp - 0x60], r14
	mov [rsp - 0x68], r15
	sub rsp, 0x70
	ret