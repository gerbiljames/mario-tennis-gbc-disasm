; ReadSceneTilemapTile_<bank>, one copy in each of banks $0f, $10.

ReadSceneTilemapTile_{TWIN}:
	wram_bank WRAM_COURT_PLANES
	ld h, e
	ld l, $00
	srl h
	rr l
	srl h
	rr l
	ld a, d
	add l
	ld l, a
	jr nc, .read
	inc h
.read:
	ld d, h
	ld e, l
	ld l, c
	ld h, b
	add hl, de
	ld a, [hl]
	ret
