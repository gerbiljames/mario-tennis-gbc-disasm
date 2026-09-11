; One body under 2 names (banks $3b, $3e), assembled through
; `twin_named flush_match_format_row_to_vram, <Label>` -- {TWIN_LABEL} is the label the bank gives it.
; No per-instruction addresses: the `twin_named` line carries the member's.
; A fix here lands in every copy.

{TWIN_LABEL}:
	push af
	push bc
	push de
	push hl
	ld a, b
	or a
	jr nz, .row1
	ld hl, wShadowAttrmap + 3 * TILEMAP_WIDTH
	ld de, vBGMap0 + 3 * TILEMAP_WIDTH + VRAM_BANK1
	ld c, $06
	call QueueVRAMCopy
	jr .done
.row1:
	cp $01
	jr nz, .row2
	ld hl, wShadowAttrmap + 7 * TILEMAP_WIDTH
	ld de, vBGMap0 + 7 * TILEMAP_WIDTH + VRAM_BANK1
	ld c, $06
	call QueueVRAMCopy
	jr .done
.row2:
	ld hl, wShadowAttrmap + 11 * TILEMAP_WIDTH
	ld de, vBGMap0 + 11 * TILEMAP_WIDTH + VRAM_BANK1
	ld c, $06
	call QueueVRAMCopy
.done:
	pop hl
	pop de
	pop bc
	pop af
	ret
