PopulateObjectArrayA:
	ld c, $00 ; $7c27
	ld hl, ObjectArrayASpawnTable ; $7c29
	ld de, wScreenScratch ; $7c2c
.spawnLoop:
	push af ; $7c2f
	push bc ; $7c30
	push de ; $7c31
	push hl ; $7c32
	ld bc, $000b ; $7c33
	call CopyMemoryBC ; $7c36
	pop hl ; $7c39
	pop de ; $7c3a
	pop bc ; $7c3b
	pop af ; $7c3c
	push hl ; $7c3d
	ld hl, $0010 ; $7c3e
	add hl, de ; $7c41
	ld d, h ; $7c42
	ld e, l ; $7c43
	pop hl ; $7c44
	ld a, $0b ; $7c45
	add l ; $7c47
	ld l, a ; $7c48
	jr nc, .read ; $7c49
	inc h ; $7c4b
.read:
	inc c ; $7c4c
	ld a, c ; $7c4d
	cp $10 ; $7c4e
	jr nz, .spawnLoop ; $7c50
	ret ; $7c52
ObjectArrayASpawnTable:
	; $7c53, 176 bytes (records:11:ptr9)
; 16 records x 11 bytes (dw callback at +$9)
	db $01, $00, $14, $00, $00, $40, $a0, $00, $00 ; record 0
	dw ObjectArrayAUpdateCallback_18
	db $02, $00, $24, $00, $18, $50, $c3, $04, $01 ; record 1
	dw ObjectArrayAUpdateCallback_18
	db $03, $00, $a3, $00, $3c, $45, $85, $08, $02 ; record 2
	dw ObjectArrayAUpdateCallback_18
	db $01, $00, $d0, $00, $00, $70, $ff, $0c, $01 ; record 3
	dw ObjectArrayAUpdateCallback_18
	db $02, $00, $54, $00, $24, $40, $b3, $10, $03 ; record 4
	dw ObjectArrayAUpdateCallback_18
	db $03, $00, $48, $00, $48, $80, $c5, $14, $01 ; record 5
	dw ObjectArrayAUpdateCallback_18
	db $01, $00, $9c, $00, $24, $30, $d2, $18, $00 ; record 6
	dw ObjectArrayAUpdateCallback_18
	db $02, $00, $66, $00, $10, $45, $82, $1c, $01 ; record 7
	dw ObjectArrayAUpdateCallback_18
	db $03, $00, $44, $00, $14, $61, $90, $20, $03 ; record 8
	dw ObjectArrayAUpdateCallback_18
	db $01, $00, $c2, $00, $28, $4f, $a4, $24, $00 ; record 9
	dw ObjectArrayAUpdateCallback_18
	db $02, $00, $5a, $00, $4c, $43, $55, $28, $01 ; record 10
	dw ObjectArrayAUpdateCallback_18
	db $03, $00, $30, $00, $60, $42, $b4, $2c, $02 ; record 11
	dw ObjectArrayAUpdateCallback_18
	db $01, $00, $63, $00, $44, $64, $f0, $00, $01 ; record 12
	dw ObjectArrayAUpdateCallback_18
	db $02, $00, $18, $00, $98, $34, $52, $00, $02 ; record 13
	dw ObjectArrayAUpdateCallback_18
	db $03, $00, $8c, $00, $0c, $45, $c0, $00, $01 ; record 14
	dw ObjectArrayAUpdateCallback_18
	db $01, $00, $a0, $00, $30, $55, $a0, $00, $00 ; record 15
	dw ObjectArrayAUpdateCallback_18
InitObjectSceneB:
	push_wram_bank $03 ; $7d03
	ld hl, wScreenScratch ; $7d0c
	ld bc, $0100 ; $7d0f
	call ClearBytes ; $7d12
	call PopulateObjectArrayB ; $7d15
	call LoadObjectSceneBTiles ; $7d18
	ret ; $7d1b
LoadObjectSceneBTiles:
	ld b, TILEBLOCK_ObjectSceneBGfx0 ; $7d1c
	ld c, ObjectSceneBGfx0_SIZE / 16 ; $7d1e
	ld de, vTiles0 ; $7d20
	farcall LoadCompressedTileBlock ; $7d23
	ld b, TILEBLOCK_ObjectSceneBGfx1 ; $7d26
	ld c, ObjectSceneBGfx1_SIZE / 16 ; $7d28
	ld de, vTiles0 + $10 * TILE_SIZE ; $7d2a
	farcall LoadCompressedTileBlock ; $7d2d
	ld b, TILEBLOCK_ObjectSceneBGfx2 ; $7d30
	ld c, ObjectSceneBGfx2_SIZE / 16 ; $7d32
	ld de, vTiles0 + $20 * TILE_SIZE ; $7d34
	farcall LoadCompressedTileBlock ; $7d37
	ld hl, ObjectSceneBPalette ; $7d3a
	lb de, $09, $03 ; $7d3d palette index, count
	call LoadPaletteShadow ; $7d40
	ret ; $7d43
ObjectSceneBPalette:
	INCLUDE "data/bank_018/ObjectSceneBPalette.asm" ; $7d44, 24 bytes (palettes)
PopulateObjectArrayB:
	ld c, $00 ; $7d5c
	ld hl, ObjectArrayBSpawnTable ; $7d5e
	ld de, wScreenScratch ; $7d61
.spawnLoop:
	push af ; $7d64
	push bc ; $7d65
	push de ; $7d66
	push hl ; $7d67
	ld bc, $000b ; $7d68
	call CopyMemoryBC ; $7d6b
	pop hl ; $7d6e
	pop de ; $7d6f
	pop bc ; $7d70
	pop af ; $7d71
	push hl ; $7d72
	ld hl, $0010 ; $7d73
	add hl, de ; $7d76
	ld d, h ; $7d77
	ld e, l ; $7d78
	pop hl ; $7d79
	ld a, $0b ; $7d7a
	add l ; $7d7c
	ld l, a ; $7d7d
	jr nc, .read ; $7d7e
	inc h ; $7d80
.read:
	inc c ; $7d81
	ld a, c ; $7d82
	cp $10 ; $7d83
	jr nz, .spawnLoop ; $7d85
	ret ; $7d87
ObjectArrayBSpawnTable:
	; $7d88, 176 bytes (records:11:ptr9)
; 16 records x 11 bytes (dw callback at +$9)
	db $01, $00, $44, $00, $00, $40, $a0, $00, $00 ; record 0
	dw ObjectArrayBUpdateCallback_18
	db $02, $00, $34, $00, $18, $50, $63, $04, $01 ; record 1
	dw ObjectArrayBUpdateCallback_18
	db $03, $00, $43, $00, $3c, $45, $95, $08, $02 ; record 2
	dw ObjectArrayBUpdateCallback_18
	db $01, $00, $60, $00, $00, $70, $ff, $0c, $01 ; record 3
	dw ObjectArrayBUpdateCallback_18
	db $02, $00, $44, $00, $84, $40, $b3, $10, $03 ; record 4
	dw ObjectArrayBUpdateCallback_18
	db $03, $00, $38, $00, $1a, $80, $ca, $14, $01 ; record 5
	dw ObjectArrayBUpdateCallback_18
	db $01, $00, $2c, $00, $84, $30, $d2, $18, $00 ; record 6
	dw ObjectArrayBUpdateCallback_18
	db $02, $00, $56, $00, $10, $45, $52, $1c, $01 ; record 7
	dw ObjectArrayBUpdateCallback_18
	db $03, $00, $44, $00, $14, $61, $c4, $20, $03 ; record 8
	dw ObjectArrayBUpdateCallback_18
	db $01, $00, $1f, $00, $88, $4f, $b4, $24, $00 ; record 9
	dw ObjectArrayBUpdateCallback_18
	db $02, $00, $2a, $00, $4c, $43, $55, $28, $01 ; record 10
	dw ObjectArrayBUpdateCallback_18
	db $03, $00, $80, $00, $23, $42, $b4, $2c, $02 ; record 11
	dw ObjectArrayBUpdateCallback_18
	db $01, $00, $73, $00, $14, $64, $f0, $00, $01 ; record 12
	dw ObjectArrayBUpdateCallback_18
	db $02, $00, $3a, $00, $28, $34, $82, $00, $02 ; record 13
	dw ObjectArrayBUpdateCallback_18
	db $03, $00, $8c, $00, $9c, $45, $d0, $00, $01 ; record 14
	dw ObjectArrayBUpdateCallback_18
	db $01, $00, $33, $00, $30, $55, $b0, $00, $00 ; record 15
	dw ObjectArrayBUpdateCallback_18
ObjectArrayAUpdateCallback_18:
	ldh a, [hVBlankCounter] ; $7e38
	add c ; $7e3a
	and $1f ; $7e3b
	ld hl, ObjectArrayAWaveTable_18 ; $7e3d
	add l ; $7e40
	ld l, a ; $7e41
	jr nc, .read ; $7e42
	inc h ; $7e44
.read:
	ld d, [hl] ; $7e45
	ld hl, $0005 ; $7e46
	add hl, bc ; $7e49
	ld [hl], d ; $7e4a
	ld hl, $0008 ; $7e4b
	add hl, bc ; $7e4e
	ld d, [hl] ; $7e4f
	ldh a, [hVBlankCounter] ; $7e50
	sub d ; $7e52
	and $07 ; $7e53
	jr nz, .done ; $7e55
	ld hl, $0007 ; $7e57
	add hl, bc ; $7e5a
	ld a, [hl] ; $7e5b
	add $04 ; $7e5c
	and $0f ; $7e5e
	ld d, a ; $7e60
	ld a, [hl] ; $7e61
	and $f0 ; $7e62
	or d ; $7e64
	ld [hl], a ; $7e65
.done:
	jp ObjectUpdateLoopTail_18 ; $7e66
ObjectArrayAWaveTable_18:
	INCBIN "data/bank_018/ObjectArrayAWaveTable_18.bin" ; $7e69, 32 bytes
ObjectArrayBUpdateCallback_18:
	ldh a, [hVBlankCounter] ; $7e89
	add c ; $7e8b
	and $03 ; $7e8c
	ld d, a ; $7e8e
	ld hl, $0005 ; $7e8f
	add hl, bc ; $7e92
	ld [hl], d ; $7e93
	ldh a, [hVBlankCounter] ; $7e94
	add c ; $7e96
	and $1f ; $7e97
	ld hl, ObjectArrayBDriftTable_18 ; $7e99
	add l ; $7e9c
	ld l, a ; $7e9d
	jr nc, .read ; $7e9e
	inc h ; $7ea0
.read:
	ld d, [hl] ; $7ea1
	ld hl, $0002 ; $7ea2
	add hl, bc ; $7ea5
	ld a, [hl] ; $7ea6
	add d ; $7ea7
	ld [hl], a ; $7ea8
	ld hl, $0008 ; $7ea9
	add hl, bc ; $7eac
	ld d, [hl] ; $7ead
	ldh a, [hVBlankCounter] ; $7eae
	sub d ; $7eb0
	and $07 ; $7eb1
	jr nz, .done ; $7eb3
	ld hl, $0007 ; $7eb5
	add hl, bc ; $7eb8
	ld d, [hl] ; $7eb9
	ld a, d ; $7eba
	add $04 ; $7ebb
	and $0f ; $7ebd
	ld d, a ; $7ebf
	ld a, [hl] ; $7ec0
	and $f0 ; $7ec1
	or d ; $7ec3
	ld [hl], d ; $7ec4
.done:
	jp ObjectUpdateLoopTail_18 ; $7ec5
ObjectArrayBDriftTable_18:
	INCBIN "data/bank_018/ObjectArrayBDriftTable_18.bin" ; $7ec8, 45 bytes
	; $7ef5, 267 bytes fill to bank end (linker-padded)
