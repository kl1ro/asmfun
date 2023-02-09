;
; This takes a string from a keyboard enter
; and puts it into ram
;
; Input:
;	- rsi as a pointer to memory
;	
;	- rdi as a maximum amount of characters 
;	in a string	
;
; Output:
;	- string being pointed by rsi
;	is modified
;
;	- rax equals to the length of a string with \0 character
;
;	- rdx remains the same
;
;	- rsi is modified
;
;	- r11 is modified
;
_input:
        xor rax, rax
	xor rdi, rdi
        syscall
        ret
