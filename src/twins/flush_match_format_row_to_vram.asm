; Shared by FlushMatchFormatRowToVram, FlushMatchRuleRowAttrs (banks $3b,
; $3e).

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
	ld c, 3 * TILEMAP_WIDTH / 16
	call QueueVRAMCopy
	jr .done
.row1:
	cp $01
	jr nz, .row2
	ld hl, wShadowAttrmap + 7 * TILEMAP_WIDTH
	ld de, vBGMap0 + 7 * TILEMAP_WIDTH + VRAM_BANK1
	ld c, 3 * TILEMAP_WIDTH / 16
	call QueueVRAMCopy
	jr .done
.row2:
	ld hl, wShadowAttrmap + 11 * TILEMAP_WIDTH
	ld de, vBGMap0 + 11 * TILEMAP_WIDTH + VRAM_BANK1
	ld c, 3 * TILEMAP_WIDTH / 16
	call QueueVRAMCopy
.done:
	pop hl
	pop de
	pop bc
	pop af
	ret
