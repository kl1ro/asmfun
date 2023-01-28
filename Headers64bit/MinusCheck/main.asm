_minusCheck:
	test rax, rax
        js _minusConfirmed
        ret

_minusConfirmed:
        call _addMinus
        call _negate
        ret
