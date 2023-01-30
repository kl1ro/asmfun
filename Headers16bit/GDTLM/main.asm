GDTLM:
	.Null: equ $ - GDTLM
		dw 0
		dw 0
		db 0
		db 0
		db 0
		db 0
	
	.Code: equ $ - GDTLM
		dw 0
		dw 0
		db 0
		db 10011000b
		db 00100000b
		db 0
	
	.Data: equ $ - GDTLM
		dw 0
		dw 0
		db 0
		db 10000000b
		db 0
		db 0
	
	.Pointer:
		dw $ - GDTLM - 1
		dq GDTLM
