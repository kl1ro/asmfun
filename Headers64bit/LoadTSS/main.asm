;
; This function is used to load the Task
; State Segment into the Task State Register
; The TSS is the fifth entry of the GDTLM
;
; Input:
;   - nothing
;
; Output:
;   - ax equals to 40
;
_loadTSS:
    mov ax, (5 * 8)
    ltr ax
    ret