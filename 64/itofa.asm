;
;	Makes a string that is the
;	flipped integer portion of a number in rax. Serves 
;	for the function _itoa. It can also
;	be used for number systems conversion if 
;	you want it to. In order to flip the number string received from this
;	function use _flipstr (check the 64-bit documentation).
;
;	Input:
;		- rax as an integer 
;
;		- rdi as a pointer to string
;
;		- rcx is a devider (for decimal it must be 10)
;
;	Output:
;		- rdx is modified
;
;		- rdi points to the end of the destination string	
;
;		- rax is equal to 0
;
;		- string being pointed to by rdi is modified
;
;		- rcx remains the same
;
_itofa:
	xor rdx, rdx
	div rcx

	cmp dl, 9
	ja ._else

	._if:
		add dl, 48
		jmp ._after

	._else:
		add dl, 55	

	._after:
		mov [rdi], dl
		inc rdi
		cmp rax, 0
		jne _itofa
		ret