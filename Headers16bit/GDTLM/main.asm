GDTLM:
	.Null: equ $ - GDTLM
		dq 0
	
	.Code: equ $ - GDTLM
		dw 0xffff
		dw 0
		db 0
		db 10011010b
		db 10101111b
		db 0
	
	.Data: equ $ - GDTLM
		dw 0xffff
		dw 0
		db 0
		db 10010010b
		db 10001111b
		db 0

	.UserCode: equ $ - GDTLM
		dw 0xffff
		dw 0
		db 0
		db 11111110b
		db 10101111b
		db 0

	.UserData: equ $ - GDTLM
		dw 0xffff
		dw 0
		db 0
		db 11110010b
		db 10001111b
		db 0
	
	.Pointer:
		dw $ - GDTLM - 1
		dq GDTLM
