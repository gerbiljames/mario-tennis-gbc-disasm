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
	ld_oam bc, OAM_BANK1 | 7, $d4
	ld_xy de, $7a, $0c
	call QueueSprite
	ret
.nonZero:
	ld_oam bc, OAM_BANK1 | 7, $d4
	ld_xy de, $7a, $14
	call QueueSprite
	ret
