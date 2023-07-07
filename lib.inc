PRINT_HEARTS PROC
    PUSH DX
    PUSH AX
    MOV AH, 2
    MOV DL, 3
    print_hearts_loop:
        INT 21h         
    LOOP print_hearts_loop
    POP AX
    POP DX
	RET
PRINT_HEARTS ENDP

NEW_LINE PROC
	PUSH DX
	PUSH AX
	MOV AH, 2
	MOV DL, 10
	INT 21h
	MOV DL, 13
	INT 21h
	POP DX
	POP AX
	RET
NEW_LINE ENDP