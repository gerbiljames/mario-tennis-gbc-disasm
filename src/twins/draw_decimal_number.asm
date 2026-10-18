; Shared by Unused_3b_DrawDecimalNumber, Unused_1b_DrawDecimalNumber,
; Unused_17_DrawDecimalNumber, Unused_3e_DrawDecimalNumber (banks $17, $1b,
; $3b, $3e).

{TWIN_LABEL}:
	push af
	push bc
	push hl
	add sp, -10
	push bc
	push de
	ld c, l
	ld b, h
	ld hl, sp + 4
	ld e, l
	ld d, h
	ld l, c
	ld h, b
	ld c, e
	ld b, d
	call FormatDecimalNumber
	ld l, c
	ld h, b
	pop de
	pop bc
	call Unused_{TWIN}_DrawAsciiDigitString
	add sp, 10
	pop hl
	pop bc
	pop af
	ret
