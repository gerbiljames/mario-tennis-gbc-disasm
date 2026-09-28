; GetCellIndexFromCursorPtr_<bank>: one routine assembled into banks $16, $3b, $3e through
; `twin_in get_cell_index_from_cursor_ptr, <Label>, <bank>` -- {TWIN_LABEL} is the copy's name
; (Unused_<bank>_GetCellIndexFromCursorPtr where nothing calls it) and {TWIN} the bank suffix, so the labels and the
; bank-local references become that bank's. No per-instruction addresses:
; the `twin_in` line in each bank carries the member's address. Every member's
; note is above its `twin_in` line. A fix here lands in every bank.

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
