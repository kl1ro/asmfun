GDTLM:
	.Null: equ $ - GDTLM
		dq 0
	
	.Code: equ $ - GDTLM
		dd 0
		db 0
		db 10011000b
		db 00100000b
		db 0
	
	.Data: equ $ - GDTLM
		dd 0
		db 0
		db 10010000b
		dw 0

	.UserCode: equ $ - GDTLM
                dd 0
                db 0
                db 11111000b
                db 00100000b
                db 0

        .UserData: equ $ - GDTLM
                dd 0
                db 0
                db 11110000b
		dw 0

	
	.Pointer:
		dw $ - GDTLM - 1
		dq GDTLM
