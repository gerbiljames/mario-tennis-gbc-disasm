; Shared by Unused_1b_GetMenuCursorIndexFromPtr,
; Unused_38_GetMenuCursorIndexFromPtr (banks $1b, $38).

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
