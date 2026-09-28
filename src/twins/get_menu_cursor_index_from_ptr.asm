; GetMenuCursorIndexFromPtr_<bank>: one routine assembled into banks $1b, $38 through
; `twin_in get_menu_cursor_index_from_ptr, <Label>, <bank>` -- {TWIN_LABEL} is the copy's name
; (Unused_<bank>_GetMenuCursorIndexFromPtr where nothing calls it) and {TWIN} the bank suffix, so the labels and the
; bank-local references become that bank's. No per-instruction addresses:
; the `twin_in` line in each bank carries the member's address. Every member's
; note is above its `twin_in` line. A fix here lands in every bank.

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
