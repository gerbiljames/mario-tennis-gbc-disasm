FillMenuGridCellTile:
	push af ; $6dc2
	push bc ; $6dc3
	push de ; $6dc4
	push hl ; $6dc5
	ld d, c ; $6dc6
	ld e, b ; $6dc7
	ld b, $03 ; $6dc8
	ld c, $03 ; $6dca
	ld a, d ; $6dcc
	or a ; $6dcd
	jr z, .zero ; $6dce
	ld h, $0c ; $6dd0
	jr .step2 ; $6dd2
.zero:
	ld h, $0d ; $6dd4
.step2:
	push hl ; $6dd6
	ld hl, FillMenuGridCellTileTable ; $6dd7
	ld a, e ; $6dda
	add a ; $6ddb
	add l ; $6ddc
	ld l, a ; $6ddd
	jr nc, .read ; $6dde
	inc h ; $6de0
.read:
	ld a, [hl+] ; $6de1
	ld d, [hl] ; $6de2
	ld e, a ; $6de3
	pop hl ; $6de4
	farcall FillTilemapRect ; $6de5
	pop hl ; $6de8
	pop de ; $6de9
	pop bc ; $6dea
	pop af ; $6deb
	ret ; $6dec
FillMenuGridCellTileTable:
	; $6ded, 12 bytes (ram_ptrs:3)
	dw wShadowAttrmap + 4 * TILEMAP_WIDTH + 2 ; record 0
	dw wShadowAttrmap + 4 * TILEMAP_WIDTH + 8 ; record 1
	dw wShadowAttrmap + 4 * TILEMAP_WIDTH + 14 ; record 2
	dw wShadowAttrmap + 9 * TILEMAP_WIDTH + 5 ; record 3
	dw wShadowAttrmap + 9 * TILEMAP_WIDTH + 11 ; record 4
	dw wShadowAttrmap + 9 * TILEMAP_WIDTH + 11 ; record 5
MoveMinigameGridCursor:
	ld a, [wMenuCursorY] ; $6df9
	or a ; $6dfc
	jr nz, .checkMenuInputPressed ; $6dfd
	ld a, [wMenuInputPressed] ; $6dff
	bit PADB_RIGHT, a ; $6e02
	jr nz, .checkMenuCursorX ; $6e04
	bit 5, a ; $6e06
	jr nz, .checkMenuCursorX2 ; $6e08
	bit 6, a ; $6e0a
	jr nz, .checkMenuCursorX3 ; $6e0c
	bit 7, a ; $6e0e
	jr nz, .checkMenuCursorX3 ; $6e10
	xor a ; $6e12
	jp .done ; $6e13
.checkMenuCursorX:
	ld a, [wMenuCursorX] ; $6e16
	inc a ; $6e19
	add a ; $6e1a
	jr nc, .noCarry ; $6e1b
	ld a, $03 ; $6e1d
	dec a ; $6e1f
	jr .store ; $6e20
.noCarry:
	rra ; $6e22
	cp $03 ; $6e23
	jr c, .store ; $6e25
	xor a ; $6e27
.store:
	ld [wMenuCursorX], a ; $6e28
	ld a, $01 ; $6e2b
	jp .done ; $6e2d
.checkMenuCursorX2:
	ld a, [wMenuCursorX] ; $6e30
	dec a ; $6e33
	add a ; $6e34
	jr nc, .noCarry2 ; $6e35
	ld a, $03 ; $6e37
	dec a ; $6e39
	jr .store2 ; $6e3a
.noCarry2:
	rra ; $6e3c
	cp $03 ; $6e3d
	jr c, .store2 ; $6e3f
	xor a ; $6e41
.store2:
	ld [wMenuCursorX], a ; $6e42
	ld a, $01 ; $6e45
	jr .done ; $6e47
.checkMenuCursorX3:
	ld a, [wMenuCursorX] ; $6e49
	ld hl, MoveMinigameGridCursorTable0 ; $6e4c
	add l ; $6e4f
	ld l, a ; $6e50
	jr nc, .read ; $6e51
	inc h ; $6e53
.read:
	ld a, [hl] ; $6e54
	ld [wMenuCursorX], a ; $6e55
	ld a, [wMenuCursorY] ; $6e58
	xor $01 ; $6e5b
	ld [wMenuCursorY], a ; $6e5d
	ld a, $01 ; $6e60
	jr .done ; $6e62
.checkMenuInputPressed:
	ld a, [wMenuInputPressed] ; $6e64
	bit PADB_RIGHT, a ; $6e67
	jr nz, .checkMenuCursorX4 ; $6e69
	bit 5, a ; $6e6b
	jr nz, .checkMenuCursorX5 ; $6e6d
	bit 6, a ; $6e6f
	jr nz, .checkMenuCursorX6 ; $6e71
	bit 7, a ; $6e73
	jr nz, .checkMenuCursorX6 ; $6e75
	xor a ; $6e77
	jr .done ; $6e78
.checkMenuCursorX4:
	ld a, [wMenuCursorX] ; $6e7a
	or a ; $6e7d
	jr z, .zero ; $6e7e
	xor a ; $6e80
	jr .store3 ; $6e81
.zero:
	ld a, $02 ; $6e83
.store3:
	ld [wMenuCursorX], a ; $6e85
	ld a, $01 ; $6e88
	jr .done ; $6e8a
.checkMenuCursorX5:
	ld a, [wMenuCursorX] ; $6e8c
	or a ; $6e8f
	jr z, .zero2 ; $6e90
	xor a ; $6e92
	jr .store4 ; $6e93
.zero2:
	ld a, $02 ; $6e95
.store4:
	ld [wMenuCursorX], a ; $6e97
	ld a, $01 ; $6e9a
	jr .done ; $6e9c
.checkMenuCursorX6:
	ld a, [wMenuCursorX] ; $6e9e
	ld hl, MoveMinigameGridCursorTable1 ; $6ea1
	add l ; $6ea4
	ld l, a ; $6ea5
	jr nc, .readB ; $6ea6
	inc h ; $6ea8
.readB:
	ld a, [hl] ; $6ea9
	ld [wMenuCursorX], a ; $6eaa
	ld a, [wMenuCursorY] ; $6ead
	xor $01 ; $6eb0
	ld [wMenuCursorY], a ; $6eb2
	ld a, $01 ; $6eb5
	jr .done ; $6eb7
.done:
	ret ; $6eb9
MoveMinigameGridCursorTable0:
	; $6eba, 3 bytes (bytes:3)
	db $00, $02, $02 ; 0x00
MoveMinigameGridCursorTable1:
	; $6ebd, 3 bytes (bytes:3)
	db $00, $02, $02 ; 0x00
InitNumberSpriteGfx:
	push af ; $6ec0
	push bc ; $6ec1
	push de ; $6ec2
	push hl ; $6ec3
	ld hl, wDigitSpriteSlots ; $6ec4
	ld bc, wDigitSpriteSlots_SIZE ; $6ec7
	call ClearBytes ; $6eca
	xor a ; $6ecd
	ld [wDigitSpriteTileBase], a ; $6ece
	ld [wDigitSpriteAttr], a ; $6ed1
	pop hl ; $6ed4
	pop de ; $6ed5
	pop bc ; $6ed6
	pop af ; $6ed7
	ld a, $08 ; $6ed8
	ld [wDigitSpriteAttr], a ; $6eda
	ld a, $00 ; $6edd
	ld [wDigitSpriteTileBase], a ; $6edf
	ld a, c ; $6ee2
	or a ; $6ee3
	jr nz, InitNumberSpriteGfxWide ; $6ee4
	push bc ; $6ee6
	ld b, TILEBLOCK_NumberSpriteGfx ; $6ee7
	ld c, NumberSpriteGfx_SIZE / 16 ; $6ee9
	farcall LoadCompressedTileBlock ; $6eeb
	pop bc ; $6eee
	ld hl, NumberSpritePalette ; $6eef
	ld d, b ; $6ef2
	ld e, $01 ; $6ef3
	call LoadPaletteShadow ; $6ef5
	ret ; $6ef8
InitNumberSpriteGfxWide:
	push bc ; $6ef9
	ld b, TILEBLOCK_NumberSpriteGfxWideGfx ; $6efa
	ld c, NumberSpriteGfxWideGfx_SIZE / 16 ; $6efc
	farcall LoadCompressedTileBlock ; $6efe
	pop bc ; $6f01
	ld c, $0c ; $6f02
	farcall LoadIndexedPalette ; $6f04
	ret ; $6f07
NumberSpritePalette:
	INCLUDE "data/bank_039/NumberSpritePalette.asm" ; $6f08, 8 bytes (palettes)
DrawDecimalNumberSprites_39:
	push af ; $6f10
	push bc ; $6f11
	push de ; $6f12
	push hl ; $6f13
	push_wram_bank WRAM_COURT_PLANES ; $6f14
	push de ; $6f1d
	ld de, wDigitSpriteSlots ; $6f1e
	ld a, $00 ; $6f21
	call FormatDecimalNumber ; $6f23
	pop de ; $6f26
	ld b, $00 ; $6f27
	ld hl, wDigitSpriteSlots ; $6f29
.lenLoop:
	ld a, [hl] ; $6f2c
	or a ; $6f2d
	jr z, .atEnd ; $6f2e
	inc b ; $6f30
	inc hl ; $6f31
	jr .lenLoop ; $6f32
.atEnd:
	dec hl ; $6f34
.digitLoop:
	ld a, [hl-] ; $6f35
	sub $30 ; $6f36
	ld c, a ; $6f38
	call DrawDigitSprite_39 ; $6f39
	ld a, d ; $6f3c
	sub $08 ; $6f3d
	ld d, a ; $6f3f
	dec b ; $6f40
	jr z, .done ; $6f41
	jr .digitLoop ; $6f43
.done:
	pop_wram_bank ; $6f45
	pop hl ; $6f4a
	pop de ; $6f4b
	pop bc ; $6f4c
	pop af ; $6f4d
	ret ; $6f4e
DrawDigitSprite_39:
	push af ; $6f4f
	push bc ; $6f50
	push de ; $6f51
	push hl ; $6f52
	ld a, [wDigitSpriteTileBase] ; $6f53
	ld b, a ; $6f56
	ld a, c ; $6f57
	add a ; $6f58
	add b ; $6f59
	ld c, a ; $6f5a
	ld a, [wDigitSpriteAttr] ; $6f5b
	ld b, a ; $6f5e
	call QueueSprite ; $6f5f
	pop hl ; $6f62
	pop de ; $6f63
	pop bc ; $6f64
	pop af ; $6f65
	ret ; $6f66
UpdateCheatCodeEntry:
	push_wram_bank WRAM_STAGING ; $6f67
	ld a, [wCheatUnlockTriggered] ; $6f70
	or a ; $6f73
	jr nz, .restore ; $6f74
	ldh a, [hInputRisingEdge] ; $6f76
	bit PADB_A, a ; $6f78
	jr z, .zero ; $6f7a
	ld c, $00 ; $6f7c
.loop:
	ld hl, wDecompBuffer ; $6f7e
	ld a, c ; $6f81
	add l ; $6f82
	ld l, a ; $6f83
	jr nc, .read ; $6f84
	inc h ; $6f86
.read:
	ld d, [hl] ; $6f87
	ld a, c ; $6f88
	ld hl, CheatCodeEntryTable ; $6f89
	add l ; $6f8c
	ld l, a ; $6f8d
	jr nc, .readB ; $6f8e
	inc h ; $6f90
.readB:
	ld a, [hl] ; $6f91
	cp d ; $6f92
	jr nz, .restore ; $6f93
	inc c ; $6f95
	ld a, c ; $6f96
	cp $20 ; $6f97
	jr nz, .loop ; $6f99
	call TriggerCheatUnlock ; $6f9b
	ld a, $01 ; $6f9e
	ld [wCheatUnlockTriggered], a ; $6fa0
	jr .restore ; $6fa3
.zero:
	ldh a, [hInputRisingEdge] ; $6fa5
	or a ; $6fa7
	jr z, .restore ; $6fa8
	ld b, a ; $6faa
	ld a, [wCheatCodeLength] ; $6fab
	and $1f ; $6fae
	ld hl, wDecompBuffer ; $6fb0
	add l ; $6fb3
	ld l, a ; $6fb4
	jr nc, .store ; $6fb5
	inc h ; $6fb7
.store:
	ld [hl], b ; $6fb8
	ld a, [wCheatCodeLength] ; $6fb9
	inc a ; $6fbc
	ld [wCheatCodeLength], a ; $6fbd
.restore:
	pop_wram_bank ; $6fc0
	ret ; $6fc5
CheatCodeEntryTable:
	; $6fc6, 33 bytes (bytes:16)
	db $80, $80, $10, $10, $40, $40, $20, $04, $04, $04, $10, $80, $80, $20, $20, $40 ; 0x00
	db $40, $10, $04, $20, $80, $80, $10, $10, $40, $40, $20, $04, $04, $00, $00, $00 ; 0x10
	db $00 ; 0x20
ResetCheatCodeBuffer:
	push_wram_bank WRAM_STAGING ; $6fe7
	xor a ; $6ff0
	ld [wCheatCodeLength], a ; $6ff1
	ld hl, wDecompBuffer ; $6ff4
	ld bc, $0020 ; $6ff7
	call ClearBytes ; $6ffa
	pop_wram_bank ; $6ffd
	ret ; $7002
TriggerCheatUnlock:
	sound SFX_LOGO_JINGLE ; $7003
	farcall ApplyUnlockEverythingCheat ; $7005
	ret ; $7008
RacketShoesChoiceGfx0:
	INCBIN "data/bank_039/lz_RacketShoesChoiceGfx0.bin" ; $7009, 178 bytes
RacketShoesChoiceGfx1:
	INCBIN "data/bank_039/lz_RacketShoesChoiceGfx1.bin" ; $70bb, 194 bytes
MenuArrowGfx0:
	INCBIN "data/bank_039/lz_MenuArrowGfx0.bin" ; $717d, 57 bytes
MenuArrowGfx1:
	INCBIN "data/bank_039/lz_MenuArrowGfx1.bin" ; $71b6, 50 bytes
MenuArrowGfx2:
	INCBIN "data/bank_039/lz_MenuArrowGfx2.bin" ; $71e8, 59 bytes
MenuArrowGfx3:
	INCBIN "data/bank_039/lz_MenuArrowGfx3.bin" ; $7223, 58 bytes
CharGridGfx2:
	INCBIN "data/bank_039/lz_CharGridGfx2.bin" ; $725d, 241 bytes
DigitFontTiles:
	INCBIN "data/bank_039/lz_DigitFontTiles.bin" ; $734e, 249 bytes
	ret ; $7447
Unused_39_PushPopNop_1:
	push af ; $7448
	push bc ; $7449
	push de ; $744a
	push hl ; $744b
	pop hl ; $744c
	pop de ; $744d
	pop bc ; $744e
	pop af ; $744f
	ret ; $7450
Unused_39_PushPopNop_2:
	push af ; $7451
	push bc ; $7452
	push de ; $7453
	push hl ; $7454
	pop hl ; $7455
	pop de ; $7456
	pop bc ; $7457
	pop af ; $7458
	ret ; $7459
FillIncrementingBytes:
	ld a, b ; $745a
	ld [hl+], a ; $745b
	inc b ; $745c
	dec c ; $745d
	ld a, c ; $745e
	or a ; $745f
	jr nz, FillIncrementingBytes ; $7460
	ret ; $7462
	; $7463, 2973 bytes fill to bank end (linker-padded)
