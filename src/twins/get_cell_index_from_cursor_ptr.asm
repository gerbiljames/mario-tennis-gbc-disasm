; Shared by Unused_3b_GetCellIndexFromCursorPtr,
; Unused_16_GetCellIndexFromCursorPtr, Unused_3e_GetCellIndexFromCursorPtr
; (banks $16, $3b, $3e).

{TWIN_LABEL}:
	push bc
	ld a, [hl-]
	ld b, a
	xor a
	inc b
.loop:
	dec b
	jr z, .countDone
	add c
	jr .loop
.countDone:
	ld b, a
	ld a, [hl]
	add b
	pop bc
	ret
