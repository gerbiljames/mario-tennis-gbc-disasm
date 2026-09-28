; SetMenuCursorFromIndexToPtr_<bank>: one routine assembled into banks $16, $38, $3e through
; `twin_in set_menu_cursor_from_index_to_ptr, <Label>, <bank>` -- {TWIN_LABEL} is the copy's name
; (Unused_<bank>_SetMenuCursorFromIndexToPtr where nothing calls it) and {TWIN} the bank suffix, so the labels and the
; bank-local references become that bank's. No per-instruction addresses:
; the `twin_in` line in each bank carries the member's address. Every member's
; note is above its `twin_in` line. A fix here lands in every bank.

{TWIN_LABEL}:
	ld d, $00
	ld a, c
.divLoop:
	cp b
	jr c, .store
	inc d
	sub b
	jr .divLoop
.store:
	ld [hl+], a
	ld a, d
	ld [hl], a
	ret
