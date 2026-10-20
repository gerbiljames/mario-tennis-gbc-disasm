; Unused_<bank>_GetMenuCursorIndexFromPtr, one copy in each of banks $16, $1b,
; $38, $3b, $3e.

{TWIN_LABEL}:
	push bc
	ld a, [hl-]
	ld b, a
	xor a
	inc b
.mulLoop:
	dec b
	jr z, .addColumn
	add c
	jr .mulLoop
.addColumn:
	ld b, a
	ld a, [hl]
	add b
	pop bc
	ret
