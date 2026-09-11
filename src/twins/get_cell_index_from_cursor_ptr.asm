; GetCellIndexFromCursorPtr_<bank>: one routine assembled into banks $16, $3b, $3e through
; `twin get_cell_index_from_cursor_ptr, <bank>` -- {TWIN} is the bank suffix, so the labels and the
; bank-local references become that bank's. No per-instruction addresses:
; the `twin` line in each bank carries the member's address. Every member's
; note is above its `twin` line. A fix here lands in every bank.

GetCellIndexFromCursorPtr_{TWIN}:
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
