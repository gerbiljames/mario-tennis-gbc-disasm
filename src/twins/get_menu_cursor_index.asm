; Shared by Unused_16_GetMenuCursorIndex, GetMenuCursorIndex_1b,
; GetMenuCursorIndex_38, GetMenuCursorIndex_3b, GetMenuCursorIndex_3e (banks
; $16, $1b, $38, $3b, $3e).

{TWIN_LABEL}:
	ld a, [wMenuCursorY]
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
	ld a, [wMenuCursorX]
	add b
	ret
