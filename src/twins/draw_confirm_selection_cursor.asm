; DrawConfirmSelectionCursor_<bank>: one routine assembled into banks $1a, $1c, $1d through
; `twin draw_confirm_selection_cursor, <bank>` -- {TWIN} is the bank suffix, so the labels and the
; bank-local references become that bank's. No per-instruction addresses:
; the `twin` line in each bank carries the member's address. Every member's
; note is above its `twin` line. A fix here lands in every bank.

DrawConfirmSelectionCursor_{TWIN}:
	wram_bank WRAM_SCENE
	ld a, [wCharDataConfirmState]
	or a
	jr nz, .nonZero
	lb bc, $0f, $d4 ; attr, tile
	lb de, $7a, $0c ; x, y
	call QueueSprite
	ret
.nonZero:
	lb bc, $0f, $d4 ; attr, tile
	lb de, $7a, $14 ; x, y
	call QueueSprite
	ret
