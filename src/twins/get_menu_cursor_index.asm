; GetMenuCursorIndex_<bank>: one routine assembled into banks $16, $1b, $38, $3b, $3e through
; `twin_in get_menu_cursor_index, <Label>, <bank>` -- {TWIN_LABEL} is the copy's name
; (Unused_<bank>_GetMenuCursorIndex where nothing calls it) and {TWIN} the bank suffix, so the labels and the
; bank-local references become that bank's. No per-instruction addresses:
; the `twin_in` line in each bank carries the member's address. Every member's
; note is above its `twin_in` line. A fix here lands in every bank.

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
