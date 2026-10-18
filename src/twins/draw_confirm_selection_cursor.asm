; DrawConfirmSelectionCursor_<bank>, one copy in each of banks $1a, $1c, $1d.

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
