; SetMenuCursorFromIndex_<bank>: one routine assembled into banks $16, $38, $3b, $3e through
; `twin set_menu_cursor_from_index, <bank>` -- {TWIN} is the bank suffix, so the labels and the
; bank-local references become that bank's. No per-instruction addresses:
; the `twin` line in each bank carries the member's address. Every member's
; note is above its `twin` line. A fix here lands in every bank.

SetMenuCursorFromIndex_{TWIN}:
	ld d, $00
	ld a, c
.divLoop:
	cp b
	jr c, .store
	inc d
	sub b
	jr .divLoop
.store:
	ld [wMenuCursorX], a
	ld a, d
	ld [wMenuCursorY], a
	ret
