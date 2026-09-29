; DrawDecimalNumber_<bank>: one routine assembled into banks $17, $1b, $3b, $3e through
; `twin_in draw_decimal_number, <Label>, <bank>` -- {TWIN_LABEL} is the copy's name
; (Unused_<bank>_DrawDecimalNumber where nothing calls it) and {TWIN} the bank suffix, so the labels and the
; bank-local references become that bank's. No per-instruction addresses:
; the `twin_in` line in each bank carries the member's address. Every member's
; note is above its `twin_in` line. A fix here lands in every bank.

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
