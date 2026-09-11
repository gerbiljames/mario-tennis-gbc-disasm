; ReadSceneTilemapTile_<bank>: one routine assembled into banks $0f, $10 through
; `twin read_scene_tilemap_tile, <bank>` -- {TWIN} is the bank suffix, so the labels and the
; bank-local references become that bank's. No per-instruction addresses:
; the `twin` line in each bank carries the member's address. Every member's
; note is above its `twin` line. A fix here lands in every bank.

ReadSceneTilemapTile_{TWIN}:
	wram_bank $02
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
