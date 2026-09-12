DrawCharViewerCharSprite:
	lb bc, $07, $70 ; $7012 attr, tile
	lb de, $46, $15 ; $7015 x, y
	call QueueSprite ; $7018
	lb bc, $07, $72 ; $701b attr, tile
	lb de, $4e, $15 ; $701e x, y
	call QueueSprite ; $7021
	wram_bank WRAM_CHAR0 ; $7024
	ld hl, wCharPosX ; $702a
	ld b, h ; $702d
	ld c, l ; $702e
	farcall StepCharAnimation ; $702f
	wram_bank WRAM_SCENE ; $7032
	ld a, [wCharDataNewLevels] ; $7038
	ld d, a ; $703b
	wram_bank WRAM_CHAR0 ; $703c
	push de ; $7042
	farcall ReloadCharFacingTiles ; $7043
	pop de ; $7046
	ld a, d ; $7047
	ld_hl_indexed DrawCharViewerCharSprite_CharScreenPosTable ; $7048
	ld b, [hl] ; $704f
	ld hl, wCharTileBase ; $7050
	ld a, [hl+] ; $7053
	ld c, a ; $7054
	ld a, [hl] ; $7055
	or b ; $7056
	ld b, a ; $7057
	push bc ; $7058
	push de ; $7059
	ld d, $20 ; $705a
	ld e, $68 ; $705c
	ld a, d ; $705e
	ld [wCharScreenX], a ; $705f
	ld a, e ; $7062
	ld [wCharScreenY], a ; $7063
	pop hl ; $7066
	add hl, hl ; $7067
	add hl, hl ; $7068
	add hl, hl ; $7069
	pop bc ; $706a
	push hl ; $706b
	ld hl, wCharSpriteSlot ; $706c
	ld a, c ; $706f
	ld [hl+], a ; $7070
	ld a, b ; $7071
	ld [hl+], a ; $7072
	ld a, e ; $7073
	ld [hl+], a ; $7074
	ld a, d ; $7075
	ld [hl+], a ; $7076
	ld a, [wCharSpriteFrame + 2] ; $7077
	ld [hl+], a ; $707a
	ld a, [wCharSpriteFrame + 1] ; $707b
	ld [hl+], a ; $707e
	ld a, [wCharSpriteFrame] ; $707f
	ld [hl+], a ; $7082
	pop af ; $7083
	add $80 ; $7084
	ld [hl+], a ; $7086
	ld hl, wCharSpriteSlot ; $7087
	farcall DrawCharSprite ; $708a
	ret ; $708d
DrawCharViewerCharSprite_CharScreenPosTable:
	; $708e, 8 bytes (bytes:8)
	db $00, $00, $00, $20, $20, $20, $00, $00 ; 0x00
LoadCharViewerMugshot:
	xor a ; $7096
	lb de, $07, $01 ; $7097 palette index, count
	farcall LoadIndexedPaletteThunk ; $709a
	wram_bank WRAM_SCENE ; $709d
	ld a, [wCharDataFlushChunk] ; $70a3
	ld b, a ; $70a6
	wram_bank WRAM_STAGING ; $70a7
	ld a, b ; $70ad
	ld de, wDecompBuffer ; $70ae
	farcall DecompressCharMugshot ; $70b1
	ld hl, wDecompBuffer ; $70b4
	ld de, vTiles2 + $10 * TILE_SIZE + VRAM_BANK1 ; $70b7
	ld c, $09 ; $70ba
	call QueueVRAMCopy ; $70bc
	ret ; $70bf
ApplyCharViewerPalette:
	wram_bank WRAM_SCENE ; $70c0
	ld a, [wCharDataLevel] ; $70c6
	lb de, $07, $01 ; $70c9 palette index, count
	farcall LoadIndexedPaletteThunk ; $70cc
	ld a, [wCharDataLevel] ; $70cf
	lb de, $0f, $01 ; $70d2 palette index, count
	farcall LoadIndexedPaletteThunk ; $70d5
	ret ; $70d8
Palette_1a_0:
	INCLUDE "data/bank_01a/Palette_1a_0.asm" ; $70d9, 64 bytes (palettes)
CharViewerScreenGfx0:
	INCBIN "data/bank_01a/lz_CharViewerScreenGfx0.bin" ; $7119, 1636 bytes
CharViewerScreenGfx1:
	INCBIN "data/bank_01a/lz_CharViewerScreenGfx1.bin" ; $777d, 180 bytes
CharViewerScreenGfx2:
	INCBIN "data/bank_01a/lz_CharViewerScreenGfx2.bin" ; $7831, 129 bytes
CharViewerGridTilemap0:
	INCBIN "data/bank_01a/lz_CharViewerGridTilemap0.bin" ; $78b2, 58 bytes
CharViewerGridTilemap1:
	INCBIN "data/bank_01a/lz_CharViewerGridTilemap1.bin" ; $78ec, 67 bytes
CharViewerInputLoopTable:
	; $792f, 22 bytes (bytes:16)
	db $00, $01, $02, $03, $04, $05, $06, $07, $08, $09, $0a, $0b, $0c, $0d, $0e, $0f ; 0x00
	db $10, $11, $12, $0b, $0c, $0d ; 0x10
RunCharDataConfirmScreen:
	farcall InitCharDataScreenVideo ; $7945
	farcall LoadCharDataScreenTilemaps ; $7948
	wram_bank WRAM_STAGING ; $794b
	ld hl, CharDataConfirmScreenGfx1 ; $7951
	ld de, wTextTileBuffer + 106 * TILE_SIZE ; $7954
	call DecompressData ; $7957
	ld hl, wTextTileBuffer + 106 * TILE_SIZE ; $795a
	ld bc, $002a ; $795d
	call CopyBank1ToBank3BufferAlt ; $7960
	wram_bank WRAM_STAGING ; $7963
	ld hl, CharDataConfirmScreenGfx2 ; $7969
	ld de, wTextTileBuffer + 106 * TILE_SIZE ; $796c
	call DecompressData ; $796f
	ld hl, wTextTileBuffer + 106 * TILE_SIZE ; $7972
	ld bc, $002a ; $7975
	call CopyBank1ToBank2BufferAlt ; $7978
	ld hl, CharDataConfirmScreenTable0 ; $797b
	ld bc, wTextTileBuffer + 106 * TILE_SIZE ; $797e
	call ApplyTilemapPatchList_1a ; $7981
	farcall DrawCharDataConfirmPrompt ; $7984
	wram_bank WRAM_SCREEN ; $7987
	ld hl, wShadowTilemap ; $798d
	ld de, vBGMap0 ; $7990
	ld c, $24 ; $7993
	call QueueVRAMCopy ; $7995
	wram_bank WRAM_COURT_PLANES ; $7998
	ld hl, wScreenAttrmap ; $799e
	ld de, vBGMap0 + VRAM_BANK1 ; $79a1
	ld c, $24 ; $79a4
	call QueueVRAMCopy ; $79a6
	call EnableLCD ; $79a9
	call AdvanceFrame ; $79ac
	farcall StartCharDataScreenAnimTask ; $79af
	farcall StartCharDataValuesSyncTask ; $79b2
	script_fade_in $10 ; $79b5
	call WaitFadeEnd ; $79ba
	wram_bank WRAM_SCENE ; $79bd
	ld a, $01 ; $79c3
	ld [wCharDataConfirmState], a ; $79c5
.loop:
	call DrawConfirmSelectionCursor_1a ; $79c8
	call AdvanceFrame ; $79cb
	ldh a, [hInputRisingEdge] ; $79ce
	bit PADB_A, a ; $79d0
	jr nz, .step ; $79d2
	bit 1, a ; $79d4
	jr nz, .beginFadeOut2 ; $79d6
	and $c0 ; $79d8
	jr z, .loop ; $79da
	sound SFX_MENU_MOVE ; $79dc
	ld a, [wCharDataConfirmState] ; $79de
	xor $01 ; $79e1
	ld [wCharDataConfirmState], a ; $79e3
	jr .loop ; $79e6
.step:
	wram_bank WRAM_SCENE ; $79e8
	ld a, [wCharDataConfirmState] ; $79ee
	or a ; $79f1
	jr nz, .beginFadeOut2 ; $79f2
	sound SFX_MENU_SELECT ; $79f4
	jr .beginFadeOut ; $79f6
.beginFadeOut2:
	wram_bank WRAM_SCENE ; $79f8
	ld a, $01 ; $79fe
	ld [wCharDataConfirmState], a ; $7a00
	sound SFX_MENU_CANCEL ; $7a03
.beginFadeOut:
	ld c, $10 ; $7a05
	call BeginFadeOut ; $7a07
	call WaitFadeEnd ; $7a0a
	farcall StopCharDataValuesSyncTask ; $7a0d
	farcall StopCharDataScreenAnimTask ; $7a10
	wram_bank WRAM_SCENE ; $7a13
	ld a, [wCharDataConfirmState] ; $7a19
	ret ; $7a1c
; Instruction-identical to DrawConfirmSelectionCursor_1c and DrawConfirmSelectionCursor_1d (one copy per bank); a change here belongs in every copy.
	twin draw_confirm_selection_cursor, 1a ; $7a1d DrawConfirmSelectionCursor_1a
CopyBank1ToBank3BufferAlt:
	wram_bank WRAM_STAGING ; $7a3d
	ld d, [hl] ; $7a43
	wram_bank WRAM_SCREEN ; $7a44
	ld [hl], d ; $7a4a
	inc hl ; $7a4b
	dec bc ; $7a4c
	ld a, b ; $7a4d
	or c ; $7a4e
	jr nz, CopyBank1ToBank3BufferAlt ; $7a4f
	ret ; $7a51
CopyBank1ToBank2BufferAlt:
	wram_bank WRAM_STAGING ; $7a52
	ld d, [hl] ; $7a58
	wram_bank WRAM_COURT_PLANES ; $7a59
	ld [hl], d ; $7a5f
	inc hl ; $7a60
	dec bc ; $7a61
	ld a, b ; $7a62
	or c ; $7a63
	jr nz, CopyBank1ToBank2BufferAlt ; $7a64
	ret ; $7a66
ApplyTilemapPatchList_1a:
	ld a, [hl] ; $7a67
	cp $ff ; $7a68
	ret z ; $7a6a
	push hl ; $7a6b
	ld d, [hl] ; $7a6c
	inc hl ; $7a6d
	ld e, [hl] ; $7a6e
	push hl ; $7a6f
	ld hl, wCharDataScreenCell ; $7a70
	add hl, de ; $7a73
	ld d, h ; $7a74
	ld e, l ; $7a75
	pop hl ; $7a76
	inc hl ; $7a77
	push hl ; $7a78
	ld a, [hl] ; $7a79
	ld h, b ; $7a7a
	ld l, c ; $7a7b
	add l ; $7a7c
	ld l, a ; $7a7d
	jr nc, .gotPtr ; $7a7e
	inc h ; $7a80
.gotPtr:
	wram_bank WRAM_SCENE ; $7a81
	ld a, l ; $7a87
	ld [wCharDataNumberBuffer], a ; $7a88
	ld a, h ; $7a8b
	ld [wCharDataNumberBuffer + 1], a ; $7a8c
	pop hl ; $7a8f
	push bc ; $7a90
	inc hl ; $7a91
	ld c, [hl] ; $7a92
	ld hl, wCharDataNumberBuffer ; $7a93
	ld a, [hl+] ; $7a96
	ld h, [hl] ; $7a97
	ld l, a ; $7a98
.loop:
	wram_bank WRAM_SCREEN ; $7a99
	ld a, [hl] ; $7a9f
	ld [de], a ; $7aa0
	wram_bank WRAM_COURT_PLANES ; $7aa1
	ld a, [hl+] ; $7aa7
	ld [de], a ; $7aa8
	inc de ; $7aa9
	dec c ; $7aaa
	jr nz, .loop ; $7aab
	pop bc ; $7aad
	pop hl ; $7aae
	inc hl ; $7aaf
	inc hl ; $7ab0
	inc hl ; $7ab1
	inc hl ; $7ab2
	jr ApplyTilemapPatchList_1a ; $7ab3
CharDataScreen_BuildStats:
	ld a, [wStoryCharacterSlot] ; $7ab5
	or a ; $7ab8
	ret nz ; $7ab9
	wram_bank WRAM_SCENE ; $7aba
	xor a ; $7ac0
	ld hl, wCharDataRacketDeltas ; $7ac1
	ld [hl+], a ; $7ac4
	ld [hl+], a ; $7ac5
	ld [hl+], a ; $7ac6
	ld [hl+], a ; $7ac7
	ld [hl+], a ; $7ac8
	ld [hl+], a ; $7ac9
	ld [hl+], a ; $7aca
	ld [hl+], a ; $7acb
	ld [hl+], a ; $7acc
	ld [hl+], a ; $7acd
	ld [hl+], a ; $7ace
	ld a, [wEquippedRacket] ; $7acf
	or a ; $7ad2
	ret z ; $7ad3
	farcall RecomputeStatsWithoutRacket ; $7ad4
	ld hl, wStoryMainCharStats ; $7ad7
	ld de, wCharDataStatsNoRacket ; $7ada
	ld a, [hl+] ; $7add
	ld [de], a ; $7ade
	inc de ; $7adf
	ld a, [hl+] ; $7ae0
	ld [de], a ; $7ae1
	inc de ; $7ae2
	ld a, [hl+] ; $7ae3
	ld [de], a ; $7ae4
	inc de ; $7ae5
	ld a, [hl+] ; $7ae6
	ld [de], a ; $7ae7
	inc de ; $7ae8
	ld a, [hl+] ; $7ae9
	ld [de], a ; $7aea
	inc de ; $7aeb
	ld a, [hl+] ; $7aec
	ld [de], a ; $7aed
	inc de ; $7aee
	ld a, [hl+] ; $7aef
	ld [de], a ; $7af0
	inc de ; $7af1
	ld a, [hl+] ; $7af2
	ld [de], a ; $7af3
	inc de ; $7af4
	ld a, [hl+] ; $7af5
	ld [de], a ; $7af6
	inc de ; $7af7
	ld a, [hl+] ; $7af8
	ld [de], a ; $7af9
	inc de ; $7afa
	ld a, [hl] ; $7afb
	ld [de], a ; $7afc
	ld hl, wCharDataStatsNoRacket ; $7afd
	ld c, [hl] ; $7b00
	ld a, [wCharDataStats] ; $7b01
	dec a ; $7b04
	sub c ; $7b05
	ld [wCharDataRacketDeltas], a ; $7b06
	ld hl, wCharDataStatsNoRacket + 1 ; $7b09
	ld c, [hl] ; $7b0c
	ld a, [wCharDataStats + 1] ; $7b0d
	dec a ; $7b10
	sub c ; $7b11
	ld [wCharDataRacketDeltas + 1], a ; $7b12
	ld hl, wCharDataStatsNoRacket + 2 ; $7b15
	ld c, [hl] ; $7b18
	ld a, [wCharDataStats + 2] ; $7b19
	dec a ; $7b1c
	sub c ; $7b1d
	ld [wCharDataRacketDeltas + 2], a ; $7b1e
	ld hl, wCharDataStatsNoRacket + 3 ; $7b21
	ld c, [hl] ; $7b24
	ld a, [wCharDataStats + 3] ; $7b25
	dec a ; $7b28
	sub c ; $7b29
	ld [wCharDataRacketDeltas + 3], a ; $7b2a
	ld hl, wCharDataStatsNoRacket + 4 ; $7b2d
	ld c, [hl] ; $7b30
	ld a, [wCharDataStats + 4] ; $7b31
	dec a ; $7b34
	sub c ; $7b35
	ld [wCharDataRacketDeltas + 4], a ; $7b36
	ld hl, wCharDataStatsNoRacket + 5 ; $7b39
	ld c, [hl] ; $7b3c
	ld a, [wCharDataStats + 5] ; $7b3d
	dec a ; $7b40
	sub c ; $7b41
	ld [wCharDataRacketDeltas + 5], a ; $7b42
	ld hl, wCharDataStatsNoRacket + 6 ; $7b45
	ld c, [hl] ; $7b48
	ld a, [wCharDataStats + 6] ; $7b49
	dec a ; $7b4c
	sub c ; $7b4d
	ld [wCharDataRacketDeltas + 6], a ; $7b4e
	ld hl, wCharDataStatsNoRacket + 7 ; $7b51
	ld c, [hl] ; $7b54
	ld a, [wCharDataStats + 7] ; $7b55
	dec a ; $7b58
	sub c ; $7b59
	ld [wCharDataRacketDeltas + 7], a ; $7b5a
	ld hl, wCharDataStatsNoRacket + 8 ; $7b5d
	ld c, [hl] ; $7b60
	ld a, [wCharDataStats + 8] ; $7b61
	dec a ; $7b64
	sub c ; $7b65
	ld [wCharDataRacketDeltas + 8], a ; $7b66
	ld hl, wCharDataStatsNoRacket + 9 ; $7b69
	ld c, [hl] ; $7b6c
	ld a, [wCharDataStats + 9] ; $7b6d
	dec a ; $7b70
	sub c ; $7b71
	ld [wCharDataRacketDeltas + 9], a ; $7b72
	ld hl, wCharDataStatsNoRacket + 10 ; $7b75
	ld c, [hl] ; $7b78
	ld a, [wCharDataStats + 10] ; $7b79
	dec a ; $7b7c
	sub c ; $7b7d
	ld [wCharDataRacketDeltas + 10], a ; $7b7e
	farcall RefreshMainCharacterStats ; $7b81
	ret ; $7b84
CharDataScreen_LoadGfx:
	ld hl, CharDataScreen_LoadPalette ; $7b85
	lb de, $0c, $02 ; $7b88 palette index, count
	call LoadPaletteShadow ; $7b8b
	wram_bank WRAM_STAGING ; $7b8e
	ld hl, CharDataScreenGfx0 ; $7b94
	ld de, wDecompBuffer ; $7b97
	call DecompressData ; $7b9a
	ld hl, wDecompBuffer ; $7b9d
	ld de, vTiles0 + $78 * TILE_SIZE + VRAM_BANK1 ; $7ba0
	ld c, CharDataScreenGfx0_SIZE / 16 ; $7ba3
	call QueueVRAMCopy ; $7ba5
	ld hl, CharDataScreenGfx1 ; $7ba8
	ld de, wDecompBuffer ; $7bab
	call DecompressData ; $7bae
	ld hl, wDecompBuffer ; $7bb1
	ld de, vTiles0 + $7a * TILE_SIZE + VRAM_BANK1 ; $7bb4
	ld c, CharDataScreenGfx1_SIZE / 16 ; $7bb7
	call QueueVRAMCopy ; $7bb9
	ld hl, CharDataScreenGfx2 ; $7bbc
	ld de, wDecompBuffer ; $7bbf
	call DecompressData ; $7bc2
	ld hl, wDecompBuffer ; $7bc5
	ld de, vTiles0 + $7c * TILE_SIZE + VRAM_BANK1 ; $7bc8
	ld c, CharDataScreenGfx2_SIZE / 16 ; $7bcb
	call QueueVRAMCopy ; $7bcd
	ld hl, CharDataScreenGfx3 ; $7bd0
	ld de, wDecompBuffer ; $7bd3
	call DecompressData ; $7bd6
	ld hl, wDecompBuffer ; $7bd9
	ld de, vTiles0 + $7e * TILE_SIZE + VRAM_BANK1 ; $7bdc
	ld c, CharDataScreenGfx3_SIZE / 16 ; $7bdf
	call QueueVRAMCopy ; $7be1
	ret ; $7be4
DrawStatChangeArrows:
	wram_bank WRAM_SCENE ; $7be5
	ld a, [wCharDataPageArrowMode] ; $7beb
	dec a ; $7bee
	ret nz ; $7bef
	ld hl, wCharDataStatsSlideX ; $7bf0
	ld a, [hl+] ; $7bf3
	ld h, [hl] ; $7bf4
	ld l, a ; $7bf5
	ld a, h ; $7bf6
	or l ; $7bf7
	ret nz ; $7bf8
	ldh a, [hVBlankCounter] ; $7bf9
	and $18 ; $7bfb
	ret z ; $7bfd
	ld a, [wCharDataRacketDeltas] ; $7bfe
	or a ; $7c01
	jr z, .getStatArrowSpriteAttr ; $7c02
	call GetStatArrowSpriteAttr ; $7c04
	call GetStatArrowTile ; $7c07
	push af ; $7c0a
	ld a, [wCharDataStatsNoRacket] ; $7c0b
	ld l, a ; $7c0e
	ld a, [wCharDataStatDeltas] ; $7c0f
	add l ; $7c12
	ld de, $142c ; $7c13
	call ComputeStatArrowSpriteX ; $7c16
	push de ; $7c19
	call QueueSprite ; $7c1a
	pop de ; $7c1d
	pop af ; $7c1e
	or a ; $7c1f
	jr z, .getStatArrowSpriteAttr ; $7c20
	call GetStatArrowExtraTile ; $7c22
	call OffsetStatArrowSpriteX ; $7c25
	call QueueSprite ; $7c28
.getStatArrowSpriteAttr:
	ld a, [wCharDataRacketDeltas + 1] ; $7c2b
	or a ; $7c2e
	jr z, .getStatArrowSpriteAttr2 ; $7c2f
	call GetStatArrowSpriteAttr ; $7c31
	call GetStatArrowTile ; $7c34
	push af ; $7c37
	ld a, [wCharDataStatsNoRacket + 1] ; $7c38
	ld l, a ; $7c3b
	ld a, [wCharDataStatDeltas + 1] ; $7c3c
	add l ; $7c3f
	ld de, $143c ; $7c40
	call ComputeStatArrowSpriteX ; $7c43
	push de ; $7c46
	call QueueSprite ; $7c47
	pop de ; $7c4a
	pop af ; $7c4b
	or a ; $7c4c
	jr z, .getStatArrowSpriteAttr2 ; $7c4d
	call GetStatArrowExtraTile ; $7c4f
	call OffsetStatArrowSpriteX ; $7c52
	call QueueSprite ; $7c55
.getStatArrowSpriteAttr2:
	ld a, [wCharDataRacketDeltas + 2] ; $7c58
	or a ; $7c5b
	jr z, .getStatArrowSpriteAttr3 ; $7c5c
	call GetStatArrowSpriteAttr ; $7c5e
	call GetStatArrowTile ; $7c61
	push af ; $7c64
	ld a, [wCharDataStatsNoRacket + 2] ; $7c65
	ld l, a ; $7c68
	ld a, [wCharDataStatDeltas + 2] ; $7c69
	add l ; $7c6c
	ld de, $1454 ; $7c6d
	call ComputeStatArrowSpriteX ; $7c70
	push de ; $7c73
	call QueueSprite ; $7c74
	pop de ; $7c77
	pop af ; $7c78
	or a ; $7c79
	jr z, .getStatArrowSpriteAttr3 ; $7c7a
	call GetStatArrowExtraTile ; $7c7c
	call OffsetStatArrowSpriteX ; $7c7f
	call QueueSprite ; $7c82
.getStatArrowSpriteAttr3:
	ld a, [wCharDataRacketDeltas + 3] ; $7c85
	or a ; $7c88
	jr z, .getStatArrowSpriteAttr4 ; $7c89
	call GetStatArrowSpriteAttr ; $7c8b
	call GetStatArrowTile ; $7c8e
	push af ; $7c91
	ld a, [wCharDataStatsNoRacket + 3] ; $7c92
	ld l, a ; $7c95
	ld a, [wCharDataStatDeltas + 3] ; $7c96
	add l ; $7c99
	ld de, $1464 ; $7c9a
	call ComputeStatArrowSpriteX ; $7c9d
	push de ; $7ca0
	call QueueSprite ; $7ca1
	pop de ; $7ca4
	pop af ; $7ca5
	or a ; $7ca6
	jr z, .getStatArrowSpriteAttr4 ; $7ca7
	call GetStatArrowExtraTile ; $7ca9
	call OffsetStatArrowSpriteX ; $7cac
	call QueueSprite ; $7caf
.getStatArrowSpriteAttr4:
	ld a, [wCharDataRacketDeltas + 4] ; $7cb2
	or a ; $7cb5
	jr z, .getStatArrowSpriteAttr5 ; $7cb6
	call GetStatArrowSpriteAttr ; $7cb8
	call GetStatArrowTile ; $7cbb
	push af ; $7cbe
	ld a, [wCharDataStatsNoRacket + 4] ; $7cbf
	ld l, a ; $7cc2
	ld a, [wCharDataStatDeltas + 4] ; $7cc3
	add l ; $7cc6
	ld de, $1474 ; $7cc7
	call ComputeStatArrowSpriteX ; $7cca
	push de ; $7ccd
	call QueueSprite ; $7cce
	pop de ; $7cd1
	pop af ; $7cd2
	or a ; $7cd3
	jr z, .getStatArrowSpriteAttr5 ; $7cd4
	call GetStatArrowExtraTile ; $7cd6
	call OffsetStatArrowSpriteX ; $7cd9
	call QueueSprite ; $7cdc
.getStatArrowSpriteAttr5:
	ld a, [wCharDataRacketDeltas + 5] ; $7cdf
	or a ; $7ce2
	jr z, .getStatArrowSpriteAttr6 ; $7ce3
	call GetStatArrowSpriteAttr ; $7ce5
	call GetStatArrowTile ; $7ce8
	push af ; $7ceb
	ld a, [wCharDataStatsNoRacket + 5] ; $7cec
	ld l, a ; $7cef
	ld a, [wCharDataStatDeltas + 5] ; $7cf0
	add l ; $7cf3
	ld de, $642c ; $7cf4
	call ComputeStatArrowSpriteX ; $7cf7
	push de ; $7cfa
	call QueueSprite ; $7cfb
	pop de ; $7cfe
	pop af ; $7cff
	or a ; $7d00
	jr z, .getStatArrowSpriteAttr6 ; $7d01
	call GetStatArrowExtraTile ; $7d03
	call OffsetStatArrowSpriteX ; $7d06
	call QueueSprite ; $7d09
.getStatArrowSpriteAttr6:
	ld a, [wCharDataRacketDeltas + 6] ; $7d0c
	or a ; $7d0f
	jr z, .getStatArrowSpriteAttr7 ; $7d10
	call GetStatArrowSpriteAttr ; $7d12
	call GetStatArrowTile ; $7d15
	push af ; $7d18
	ld a, [wCharDataStatsNoRacket + 6] ; $7d19
	ld l, a ; $7d1c
	ld a, [wCharDataStatDeltas + 6] ; $7d1d
	add l ; $7d20
	ld de, $643c ; $7d21
	call ComputeStatArrowSpriteX ; $7d24
	push de ; $7d27
	call QueueSprite ; $7d28
	pop de ; $7d2b
	pop af ; $7d2c
	or a ; $7d2d
	jr z, .getStatArrowSpriteAttr7 ; $7d2e
	call GetStatArrowExtraTile ; $7d30
	call OffsetStatArrowSpriteX ; $7d33
	call QueueSprite ; $7d36
.getStatArrowSpriteAttr7:
	ld a, [wCharDataRacketDeltas + 7] ; $7d39
	or a ; $7d3c
	jr z, .getStatArrowSpriteAttr8 ; $7d3d
	call GetStatArrowSpriteAttr ; $7d3f
	call GetStatArrowTile ; $7d42
	push af ; $7d45
	ld a, [wCharDataStatsNoRacket + 7] ; $7d46
	ld l, a ; $7d49
	ld a, [wCharDataStatDeltas + 7] ; $7d4a
	add l ; $7d4d
	ld de, $6454 ; $7d4e
	call ComputeStatArrowSpriteX ; $7d51
	push de ; $7d54
	call QueueSprite ; $7d55
	pop de ; $7d58
	pop af ; $7d59
	or a ; $7d5a
	jr z, .getStatArrowSpriteAttr8 ; $7d5b
	call GetStatArrowExtraTile ; $7d5d
	call OffsetStatArrowSpriteX ; $7d60
	call QueueSprite ; $7d63
.getStatArrowSpriteAttr8:
	ld a, [wCharDataRacketDeltas + 8] ; $7d66
	or a ; $7d69
	jr z, .getStatArrowSpriteAttr9 ; $7d6a
	call GetStatArrowSpriteAttr ; $7d6c
	call GetStatArrowTile ; $7d6f
	push af ; $7d72
	ld a, [wCharDataStatsNoRacket + 8] ; $7d73
	ld l, a ; $7d76
	ld a, [wCharDataStatDeltas + 8] ; $7d77
	add l ; $7d7a
	ld de, $6464 ; $7d7b
	call ComputeStatArrowSpriteX ; $7d7e
	push de ; $7d81
	call QueueSprite ; $7d82
	pop de ; $7d85
	pop af ; $7d86
	or a ; $7d87
	jr z, .getStatArrowSpriteAttr9 ; $7d88
	call GetStatArrowExtraTile ; $7d8a
	call OffsetStatArrowSpriteX ; $7d8d
	call QueueSprite ; $7d90
.getStatArrowSpriteAttr9:
	ld a, [wCharDataRacketDeltas + 9] ; $7d93
	or a ; $7d96
	jr z, .getStatArrowSpriteAttr10 ; $7d97
	call GetStatArrowSpriteAttr ; $7d99
	call GetStatArrowTile ; $7d9c
	push af ; $7d9f
	ld a, [wCharDataStatsNoRacket + 9] ; $7da0
	ld l, a ; $7da3
	ld a, [wCharDataStatDeltas + 9] ; $7da4
	add l ; $7da7
	ld de, $6474 ; $7da8
	call ComputeStatArrowSpriteX ; $7dab
	push de ; $7dae
	call QueueSprite ; $7daf
	pop de ; $7db2
	pop af ; $7db3
	or a ; $7db4
	jr z, .getStatArrowSpriteAttr10 ; $7db5
	call GetStatArrowExtraTile ; $7db7
	call OffsetStatArrowSpriteX ; $7dba
	call QueueSprite ; $7dbd
.getStatArrowSpriteAttr10:
	ld a, [wCharDataRacketDeltas + 10] ; $7dc0
	or a ; $7dc3
	jr z, .done ; $7dc4
	call GetStatArrowSpriteAttr ; $7dc6
	call GetStatArrowTile ; $7dc9
	push af ; $7dcc
	ld a, [wCharDataStatsNoRacket + 10] ; $7dcd
	ld l, a ; $7dd0
	ld a, [wCharDataStatDeltas + 10] ; $7dd1
	add l ; $7dd4
	ld de, $6484 ; $7dd5
	call ComputeStatArrowSpriteX ; $7dd8
	push de ; $7ddb
	call QueueSprite ; $7ddc
	pop de ; $7ddf
	pop af ; $7de0
	or a ; $7de1
	jr z, .done ; $7de2
	call GetStatArrowExtraTile ; $7de4
	call OffsetStatArrowSpriteX ; $7de7
	call QueueSprite ; $7dea
.done:
	ret ; $7ded
GetStatArrowSpriteAttr:
	ld b, $0c ; $7dee
	bit 7, a ; $7df0
	ret z ; $7df2
	inc b ; $7df3
	ret ; $7df4
GetStatArrowTile:
	bit 7, a ; $7df5
	jr nz, .down ; $7df7
	dec a ; $7df9
	jr z, .upSingle ; $7dfa
	dec a ; $7dfc
	ld c, $7e ; $7dfd
	ld h, $02 ; $7dff
	ret ; $7e01
.upSingle:
	ld c, $7c ; $7e02
	ld h, $02 ; $7e04
	ret ; $7e06
.down:
	inc a ; $7e07
	jr z, .downSingle ; $7e08
	inc a ; $7e0a
	ld c, $7a ; $7e0b
	ld h, $01 ; $7e0d
	ret ; $7e0f
.downSingle:
	ld c, $78 ; $7e10
	ld h, $01 ; $7e12
	ret ; $7e14
GetStatArrowExtraTile:
	bit 7, a ; $7e15
	jr nz, .down ; $7e17
	ld c, $7c ; $7e19
	ld h, $03 ; $7e1b
	ret ; $7e1d
.down:
	ld c, $78 ; $7e1e
	ld h, $00 ; $7e20
	ret ; $7e22
ComputeStatArrowSpriteX:
	inc a ; $7e23
	rlca ; $7e24
	rlca ; $7e25
	add d ; $7e26
	ld d, a ; $7e27
	ld a, h ; $7e28
	ld_hl_indexed ComputeStatArrowSpriteXTable ; $7e29
	ld a, [hl] ; $7e30
	add d ; $7e31
	ld d, a ; $7e32
	ret ; $7e33
ComputeStatArrowSpriteXTable:
	; $7e34, 4 bytes (bytes:4)
	db $f0, $f8, $00, $08 ; 0x00
OffsetStatArrowSpriteX:
	bit 7, a ; $7e38
	jr nz, .shiftLeft ; $7e3a
	ld a, $08 ; $7e3c
	add d ; $7e3e
	ld d, a ; $7e3f
	ret ; $7e40
.shiftLeft:
	ld a, $f8 ; $7e41
	add d ; $7e43
	ld d, a ; $7e44
	ret ; $7e45
CharDataConfirmScreenTable0:
	; $7e46, 13 bytes (bytes:13)
	db $00, $00, $00, $0e, $00, $20, $0e, $0e, $00, $40, $1c, $0e, $ff ; 0x00
CharDataConfirmScreenGfx1:
	INCBIN "data/bank_01a/lz_CharDataConfirmScreenGfx1.bin" ; $7e53, 34 bytes
CharDataConfirmScreenGfx2:
	INCBIN "data/bank_01a/lz_CharDataConfirmScreenGfx2.bin" ; $7e75, 9 bytes
CharDataScreen_LoadPalette:
	INCLUDE "data/bank_01a/CharDataScreen_LoadPalette.asm" ; $7e7e, 16 bytes (palettes)
CharDataScreenGfx0:
	INCBIN "data/bank_01a/lz_CharDataScreenGfx0.bin" ; $7e8e, 11 bytes
	INCLUDE "data/bank_01a/lz_CharDataScreenGfx0.inc" ; DEF CharDataScreenGfx0_SIZE EQU its decoded length, generated from the .bin by make
CharDataScreenGfx1:
	INCBIN "data/bank_01a/lz_CharDataScreenGfx1.bin" ; $7e99, 11 bytes
	INCLUDE "data/bank_01a/lz_CharDataScreenGfx1.inc" ; DEF CharDataScreenGfx1_SIZE EQU its decoded length, generated from the .bin by make
CharDataScreenGfx2:
	INCBIN "data/bank_01a/lz_CharDataScreenGfx2.bin" ; $7ea4, 11 bytes
	INCLUDE "data/bank_01a/lz_CharDataScreenGfx2.inc" ; DEF CharDataScreenGfx2_SIZE EQU its decoded length, generated from the .bin by make
CharDataScreenGfx3:
	INCBIN "data/bank_01a/lz_CharDataScreenGfx3.bin" ; $7eaf, 11 bytes
	INCLUDE "data/bank_01a/lz_CharDataScreenGfx3.inc" ; DEF CharDataScreenGfx3_SIZE EQU its decoded length, generated from the .bin by make
	; $7eba, 326 bytes fill to bank end (linker-padded)
