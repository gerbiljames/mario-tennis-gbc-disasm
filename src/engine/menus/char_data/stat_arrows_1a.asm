Unused_1a_DrawCharViewerCharSprite:
	ld_oam bc, 7, $70 ; $7012
	ld_xy de, $46, $15 ; $7015
	call QueueSprite ; $7018
	ld_oam bc, 7, $72 ; $701b
	ld_xy de, $4e, $15 ; $701e
	call QueueSprite ; $7021
	wram_bank WRAM_CHAR0 ; $7024
	ld hl, wCharStruct ; $702a
	ld b, h ; $702d
	ld c, l ; $702e
	farcall StepCharAnimation ; $702f
	wram_bank WRAM_SCENE ; $7032
	ld a, [wCharDataStartLevels + TRAINSTAT_SPIN] ; $7038
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
Unused_1a_LoadCharViewerMugshot:
	xor a ; $7096
	ld_bg_pals de, 7, 1 ; $7097
	farcall LoadIndexedPaletteThunk ; $709a
	wram_bank WRAM_SCENE ; $709d
	ld a, [wCharDataFlushChunk] ; $70a3
	ld b, a ; $70a6
	wram_bank WRAM_STAGING ; $70a7
	ld a, b ; $70ad
	ld de, wDecompBuffer ; $70ae
	farcall DecompressCharMugshot ; $70b1
	ld hl, wDecompBuffer ; $70b4
	ld de, vTiles2 tile $10 + VRAM_BANK1 ; $70b7
	ld c, 9 ; $70ba
	call QueueVRAMCopy ; $70bc
	ret ; $70bf
Unused_1a_ApplyCharViewerPalette:
	wram_bank WRAM_SCENE ; $70c0
	ld a, [wCharDataStartLevel] ; $70c6
	ld_bg_pals de, 7, 1 ; $70c9
	farcall LoadIndexedPaletteThunk ; $70cc
	ld a, [wCharDataStartLevel] ; $70cf
	ld_obj_pals de, 7, 1 ; $70d2
	farcall LoadIndexedPaletteThunk ; $70d5
	ret ; $70d8
CharViewerPalettes:
	INCLUDE "data/engine/menus/char_data/CharViewerPalettes.asm" ; $70d9, 64 bytes (palettes)
CharViewerScreenTiles:
	INCBIN "data/engine/menus/char_data/lz_CharViewerScreenTiles.bin" ; $7119, 1636 bytes
CharViewerScreenTilemap:
	INCBIN "data/engine/menus/char_data/lz_CharViewerScreenTilemap.bin" ; $777d, 180 bytes
CharViewerScreenAttrmap:
	INCBIN "data/engine/menus/char_data/lz_CharViewerScreenAttrmap.bin" ; $7831, 129 bytes
CharViewerGridTilemap0:
	INCBIN "data/engine/menus/char_data/lz_CharViewerGridTilemap0.bin" ; $78b2, 58 bytes
CharViewerGridTilemap1:
	INCBIN "data/engine/menus/char_data/lz_CharViewerGridTilemap1.bin" ; $78ec, 67 bytes
CharViewerCursorAnimIds:
	; $792f, 22 bytes (bytes:16)
	db $00, $01, $02, $03, $04, $05, $06, $07, $08, $09, $0a, $0b, $0c, $0d, $0e, $0f ; 0x00
	db $10, $11, $12, $0b, $0c, $0d ; 0x10
RunCharDataConfirmScreen:
	farcall InitCharDataScreenVideo ; $7945
	farcall LoadCharDataScreenTilemaps ; $7948
	wram_bank WRAM_STAGING ; $794b
	ld hl, CharDataConfirmScreenTopTilemap ; $7951
	ld de, wDecompBufferHigh tile 106 ; $7954
	call DecompressData ; $7957
	ld hl, wDecompBufferHigh tile 106 ; $795a
	ld bc, $002a ; $795d
	call CopyBank1ToBank3BufferAlt ; $7960
	wram_bank WRAM_STAGING ; $7963
	ld hl, CharDataConfirmScreenTopAttrmap ; $7969
	ld de, wDecompBufferHigh tile 106 ; $796c
	call DecompressData ; $796f
	ld hl, wDecompBufferHigh tile 106 ; $7972
	ld bc, $002a ; $7975
	call CopyBank1ToBank2BufferAlt ; $7978
	ld hl, CharDataConfirmScreenTopPatchList ; $797b
	ld bc, wCharDataConfirmTopRows ; $797e
	call ApplyTilemapPatchList_1a ; $7981
	farcall DrawCharDataConfirmPrompt ; $7984
	wram_bank WRAM_SCREEN ; $7987
	ld hl, wShadowTilemap ; $798d
	ld de, vBGMap0 ; $7990
	ld c, SCREEN_HEIGHT * TILEMAP_WIDTH / 16 ; $7993
	call QueueVRAMCopy ; $7995
	wram_bank WRAM_COURT_PLANES ; $7998
	ld hl, wScreenAttrmap ; $799e
	ld de, vBGMap0 + VRAM_BANK1 ; $79a1
	ld c, SCREEN_HEIGHT * TILEMAP_WIDTH / 16 ; $79a4
	call QueueVRAMCopy ; $79a6
	call EnableLCD ; $79a9
	call AdvanceFrame ; $79ac
	farcall StartCharDataScreenAnimTask ; $79af
	farcall StartCharDataSummarySpritesTask ; $79b2
	script_fade_in 16 ; $79b5
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
	bit PADB_B, a ; $79d4
	jr nz, .cancel ; $79d6
	and PADF_UP | PADF_DOWN ; $79d8
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
	jr nz, .cancel ; $79f2
	sound SFX_MENU_SELECT ; $79f4
	jr .beginFadeOut ; $79f6
.cancel:
	wram_bank WRAM_SCENE ; $79f8
	ld a, $01 ; $79fe
	ld [wCharDataConfirmState], a ; $7a00
	sound SFX_MENU_CANCEL ; $7a03
.beginFadeOut:
	script_fade_out 16 ; $7a05
	call WaitFadeEnd ; $7a0a
	farcall StopCharDataSummarySpritesTask ; $7a0d
	farcall StopCharDataScreenAnimTask ; $7a10
	wram_bank WRAM_SCENE ; $7a13
	ld a, [wCharDataConfirmState] ; $7a19
	ret ; $7a1c
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
	add_hl_a ; $7a7c
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
ComputeCharDataEquipmentDeltas:
	ld a, [wStoryCharacterSlot] ; $7ab5
	or a ; $7ab8
	ret nz ; $7ab9
	wram_bank WRAM_SCENE ; $7aba
	xor a ; $7ac0
	ld hl, wCharDataEquipmentDeltas ; $7ac1
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
	ld a, [wStoryMainEquipment] ; $7acf
	or a ; $7ad2
	ret z ; $7ad3
	farcall RecomputeStatsWithoutEquipment ; $7ad4
	ld hl, wStoryMainStats ; $7ad7
	ld de, wCharDataStatsNoEquipment ; $7ada
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
	ld hl, wCharDataStatsNoEquipment + CHARSTAT_TOP ; $7afd
	ld c, [hl] ; $7b00
	ld a, [wCharDataStats + CHARSTAT_TOP] ; $7b01
	dec a ; $7b04
	sub c ; $7b05
	ld [wCharDataEquipmentDeltas + CHARSTAT_TOP], a ; $7b06
	ld hl, wCharDataStatsNoEquipment + CHARSTAT_SLICE ; $7b09
	ld c, [hl] ; $7b0c
	ld a, [wCharDataStats + CHARSTAT_SLICE] ; $7b0d
	dec a ; $7b10
	sub c ; $7b11
	ld [wCharDataEquipmentDeltas + CHARSTAT_SLICE], a ; $7b12
	ld hl, wCharDataStatsNoEquipment + CHARSTAT_SERVE ; $7b15
	ld c, [hl] ; $7b18
	ld a, [wCharDataStats + CHARSTAT_SERVE] ; $7b19
	dec a ; $7b1c
	sub c ; $7b1d
	ld [wCharDataEquipmentDeltas + CHARSTAT_SERVE], a ; $7b1e
	ld hl, wCharDataStatsNoEquipment + CHARSTAT_STROKE ; $7b21
	ld c, [hl] ; $7b24
	ld a, [wCharDataStats + CHARSTAT_STROKE] ; $7b25
	dec a ; $7b28
	sub c ; $7b29
	ld [wCharDataEquipmentDeltas + CHARSTAT_STROKE], a ; $7b2a
	ld hl, wCharDataStatsNoEquipment + CHARSTAT_VOLLEY ; $7b2d
	ld c, [hl] ; $7b30
	ld a, [wCharDataStats + CHARSTAT_VOLLEY] ; $7b31
	dec a ; $7b34
	sub c ; $7b35
	ld [wCharDataEquipmentDeltas + CHARSTAT_VOLLEY], a ; $7b36
	ld hl, wCharDataStatsNoEquipment + CHARSTAT_ANGLE ; $7b39
	ld c, [hl] ; $7b3c
	ld a, [wCharDataStats + CHARSTAT_ANGLE] ; $7b3d
	dec a ; $7b40
	sub c ; $7b41
	ld [wCharDataEquipmentDeltas + CHARSTAT_ANGLE], a ; $7b42
	ld hl, wCharDataStatsNoEquipment + CHARSTAT_PLACEMENT ; $7b45
	ld c, [hl] ; $7b48
	ld a, [wCharDataStats + CHARSTAT_PLACEMENT] ; $7b49
	dec a ; $7b4c
	sub c ; $7b4d
	ld [wCharDataEquipmentDeltas + CHARSTAT_PLACEMENT], a ; $7b4e
	ld hl, wCharDataStatsNoEquipment + CHARSTAT_SPEED ; $7b51
	ld c, [hl] ; $7b54
	ld a, [wCharDataStats + CHARSTAT_SPEED] ; $7b55
	dec a ; $7b58
	sub c ; $7b59
	ld [wCharDataEquipmentDeltas + CHARSTAT_SPEED], a ; $7b5a
	ld hl, wCharDataStatsNoEquipment + CHARSTAT_DASH ; $7b5d
	ld c, [hl] ; $7b60
	ld a, [wCharDataStats + CHARSTAT_DASH] ; $7b61
	dec a ; $7b64
	sub c ; $7b65
	ld [wCharDataEquipmentDeltas + CHARSTAT_DASH], a ; $7b66
	ld hl, wCharDataStatsNoEquipment + CHARSTAT_REACTION ; $7b69
	ld c, [hl] ; $7b6c
	ld a, [wCharDataStats + CHARSTAT_REACTION] ; $7b6d
	dec a ; $7b70
	sub c ; $7b71
	ld [wCharDataEquipmentDeltas + CHARSTAT_REACTION], a ; $7b72
	ld hl, wCharDataStatsNoEquipment + CHARSTAT_STOP ; $7b75
	ld c, [hl] ; $7b78
	ld a, [wCharDataStats + CHARSTAT_STOP] ; $7b79
	dec a ; $7b7c
	sub c ; $7b7d
	ld [wCharDataEquipmentDeltas + CHARSTAT_STOP], a ; $7b7e
	farcall RefreshMainCharacterStats ; $7b81
	ret ; $7b84
CharDataScreen_LoadGfx:
	ld hl, StatArrowObjPalettes ; $7b85
	ld_obj_pals de, 4, 2 ; $7b88
	call LoadPaletteShadow ; $7b8b
	wram_bank WRAM_STAGING ; $7b8e
	ld hl, StatArrowDownGfx ; $7b94
	ld de, wDecompBuffer ; $7b97
	call DecompressData ; $7b9a
	ld hl, wDecompBuffer ; $7b9d
	ld de, vTiles0 tile $78 + VRAM_BANK1 ; $7ba0
	ld c, StatArrowDownGfx_SIZE / 16 ; $7ba3
	call QueueVRAMCopy ; $7ba5
	ld hl, StatArrowDownDoubleGfx ; $7ba8
	ld de, wDecompBuffer ; $7bab
	call DecompressData ; $7bae
	ld hl, wDecompBuffer ; $7bb1
	ld de, vTiles0 tile $7a + VRAM_BANK1 ; $7bb4
	ld c, StatArrowDownDoubleGfx_SIZE / 16 ; $7bb7
	call QueueVRAMCopy ; $7bb9
	ld hl, StatArrowUpGfx ; $7bbc
	ld de, wDecompBuffer ; $7bbf
	call DecompressData ; $7bc2
	ld hl, wDecompBuffer ; $7bc5
	ld de, vTiles0 tile $7c + VRAM_BANK1 ; $7bc8
	ld c, StatArrowUpGfx_SIZE / 16 ; $7bcb
	call QueueVRAMCopy ; $7bcd
	ld hl, StatArrowUpDoubleGfx ; $7bd0
	ld de, wDecompBuffer ; $7bd3
	call DecompressData ; $7bd6
	ld hl, wDecompBuffer ; $7bd9
	ld de, vTiles0 tile $7e + VRAM_BANK1 ; $7bdc
	ld c, StatArrowUpDoubleGfx_SIZE / 16 ; $7bdf
	call QueueVRAMCopy ; $7be1
	ret ; $7be4
DrawStatChangeArrows:
	wram_bank WRAM_SCENE ; $7be5
	ld a, [wCharDataStatPageView] ; $7beb
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
	ld a, [wCharDataEquipmentDeltas + CHARSTAT_TOP] ; $7bfe
	or a ; $7c01
	jr z, .sliceArrow ; $7c02
	call GetStatArrowSpriteAttr ; $7c04
	call GetStatArrowTile ; $7c07
	push af ; $7c0a
	ld a, [wCharDataStatsNoEquipment + CHARSTAT_TOP] ; $7c0b
	ld l, a ; $7c0e
	ld a, [wCharDataStatDeltas + CHARSTAT_TOP] ; $7c0f
	add l ; $7c12
	ld_xy de, $14, $2c ; $7c13
	call ComputeStatArrowSpriteX ; $7c16
	push de ; $7c19
	call QueueSprite ; $7c1a
	pop de ; $7c1d
	pop af ; $7c1e
	or a ; $7c1f
	jr z, .sliceArrow ; $7c20
	call GetStatArrowExtraTile ; $7c22
	call OffsetStatArrowSpriteX ; $7c25
	call QueueSprite ; $7c28
.sliceArrow:
	ld a, [wCharDataEquipmentDeltas + CHARSTAT_SLICE] ; $7c2b
	or a ; $7c2e
	jr z, .serveArrow ; $7c2f
	call GetStatArrowSpriteAttr ; $7c31
	call GetStatArrowTile ; $7c34
	push af ; $7c37
	ld a, [wCharDataStatsNoEquipment + CHARSTAT_SLICE] ; $7c38
	ld l, a ; $7c3b
	ld a, [wCharDataStatDeltas + CHARSTAT_SLICE] ; $7c3c
	add l ; $7c3f
	ld_xy de, $14, $3c ; $7c40
	call ComputeStatArrowSpriteX ; $7c43
	push de ; $7c46
	call QueueSprite ; $7c47
	pop de ; $7c4a
	pop af ; $7c4b
	or a ; $7c4c
	jr z, .serveArrow ; $7c4d
	call GetStatArrowExtraTile ; $7c4f
	call OffsetStatArrowSpriteX ; $7c52
	call QueueSprite ; $7c55
.serveArrow:
	ld a, [wCharDataEquipmentDeltas + CHARSTAT_SERVE] ; $7c58
	or a ; $7c5b
	jr z, .strokeArrow ; $7c5c
	call GetStatArrowSpriteAttr ; $7c5e
	call GetStatArrowTile ; $7c61
	push af ; $7c64
	ld a, [wCharDataStatsNoEquipment + CHARSTAT_SERVE] ; $7c65
	ld l, a ; $7c68
	ld a, [wCharDataStatDeltas + CHARSTAT_SERVE] ; $7c69
	add l ; $7c6c
	ld_xy de, $14, $54 ; $7c6d
	call ComputeStatArrowSpriteX ; $7c70
	push de ; $7c73
	call QueueSprite ; $7c74
	pop de ; $7c77
	pop af ; $7c78
	or a ; $7c79
	jr z, .strokeArrow ; $7c7a
	call GetStatArrowExtraTile ; $7c7c
	call OffsetStatArrowSpriteX ; $7c7f
	call QueueSprite ; $7c82
.strokeArrow:
	ld a, [wCharDataEquipmentDeltas + CHARSTAT_STROKE] ; $7c85
	or a ; $7c88
	jr z, .volleyArrow ; $7c89
	call GetStatArrowSpriteAttr ; $7c8b
	call GetStatArrowTile ; $7c8e
	push af ; $7c91
	ld a, [wCharDataStatsNoEquipment + CHARSTAT_STROKE] ; $7c92
	ld l, a ; $7c95
	ld a, [wCharDataStatDeltas + CHARSTAT_STROKE] ; $7c96
	add l ; $7c99
	ld_xy de, $14, $64 ; $7c9a
	call ComputeStatArrowSpriteX ; $7c9d
	push de ; $7ca0
	call QueueSprite ; $7ca1
	pop de ; $7ca4
	pop af ; $7ca5
	or a ; $7ca6
	jr z, .volleyArrow ; $7ca7
	call GetStatArrowExtraTile ; $7ca9
	call OffsetStatArrowSpriteX ; $7cac
	call QueueSprite ; $7caf
.volleyArrow:
	ld a, [wCharDataEquipmentDeltas + CHARSTAT_VOLLEY] ; $7cb2
	or a ; $7cb5
	jr z, .angleArrow ; $7cb6
	call GetStatArrowSpriteAttr ; $7cb8
	call GetStatArrowTile ; $7cbb
	push af ; $7cbe
	ld a, [wCharDataStatsNoEquipment + CHARSTAT_VOLLEY] ; $7cbf
	ld l, a ; $7cc2
	ld a, [wCharDataStatDeltas + CHARSTAT_VOLLEY] ; $7cc3
	add l ; $7cc6
	ld_xy de, $14, $74 ; $7cc7
	call ComputeStatArrowSpriteX ; $7cca
	push de ; $7ccd
	call QueueSprite ; $7cce
	pop de ; $7cd1
	pop af ; $7cd2
	or a ; $7cd3
	jr z, .angleArrow ; $7cd4
	call GetStatArrowExtraTile ; $7cd6
	call OffsetStatArrowSpriteX ; $7cd9
	call QueueSprite ; $7cdc
.angleArrow:
	ld a, [wCharDataEquipmentDeltas + CHARSTAT_ANGLE] ; $7cdf
	or a ; $7ce2
	jr z, .placementArrow ; $7ce3
	call GetStatArrowSpriteAttr ; $7ce5
	call GetStatArrowTile ; $7ce8
	push af ; $7ceb
	ld a, [wCharDataStatsNoEquipment + CHARSTAT_ANGLE] ; $7cec
	ld l, a ; $7cef
	ld a, [wCharDataStatDeltas + CHARSTAT_ANGLE] ; $7cf0
	add l ; $7cf3
	ld_xy de, $64, $2c ; $7cf4
	call ComputeStatArrowSpriteX ; $7cf7
	push de ; $7cfa
	call QueueSprite ; $7cfb
	pop de ; $7cfe
	pop af ; $7cff
	or a ; $7d00
	jr z, .placementArrow ; $7d01
	call GetStatArrowExtraTile ; $7d03
	call OffsetStatArrowSpriteX ; $7d06
	call QueueSprite ; $7d09
.placementArrow:
	ld a, [wCharDataEquipmentDeltas + CHARSTAT_PLACEMENT] ; $7d0c
	or a ; $7d0f
	jr z, .speedArrow ; $7d10
	call GetStatArrowSpriteAttr ; $7d12
	call GetStatArrowTile ; $7d15
	push af ; $7d18
	ld a, [wCharDataStatsNoEquipment + CHARSTAT_PLACEMENT] ; $7d19
	ld l, a ; $7d1c
	ld a, [wCharDataStatDeltas + CHARSTAT_PLACEMENT] ; $7d1d
	add l ; $7d20
	ld_xy de, $64, $3c ; $7d21
	call ComputeStatArrowSpriteX ; $7d24
	push de ; $7d27
	call QueueSprite ; $7d28
	pop de ; $7d2b
	pop af ; $7d2c
	or a ; $7d2d
	jr z, .speedArrow ; $7d2e
	call GetStatArrowExtraTile ; $7d30
	call OffsetStatArrowSpriteX ; $7d33
	call QueueSprite ; $7d36
.speedArrow:
	ld a, [wCharDataEquipmentDeltas + CHARSTAT_SPEED] ; $7d39
	or a ; $7d3c
	jr z, .dashArrow ; $7d3d
	call GetStatArrowSpriteAttr ; $7d3f
	call GetStatArrowTile ; $7d42
	push af ; $7d45
	ld a, [wCharDataStatsNoEquipment + CHARSTAT_SPEED] ; $7d46
	ld l, a ; $7d49
	ld a, [wCharDataStatDeltas + CHARSTAT_SPEED] ; $7d4a
	add l ; $7d4d
	ld_xy de, $64, $54 ; $7d4e
	call ComputeStatArrowSpriteX ; $7d51
	push de ; $7d54
	call QueueSprite ; $7d55
	pop de ; $7d58
	pop af ; $7d59
	or a ; $7d5a
	jr z, .dashArrow ; $7d5b
	call GetStatArrowExtraTile ; $7d5d
	call OffsetStatArrowSpriteX ; $7d60
	call QueueSprite ; $7d63
.dashArrow:
	ld a, [wCharDataEquipmentDeltas + CHARSTAT_DASH] ; $7d66
	or a ; $7d69
	jr z, .reactionArrow ; $7d6a
	call GetStatArrowSpriteAttr ; $7d6c
	call GetStatArrowTile ; $7d6f
	push af ; $7d72
	ld a, [wCharDataStatsNoEquipment + CHARSTAT_DASH] ; $7d73
	ld l, a ; $7d76
	ld a, [wCharDataStatDeltas + CHARSTAT_DASH] ; $7d77
	add l ; $7d7a
	ld_xy de, $64, $64 ; $7d7b
	call ComputeStatArrowSpriteX ; $7d7e
	push de ; $7d81
	call QueueSprite ; $7d82
	pop de ; $7d85
	pop af ; $7d86
	or a ; $7d87
	jr z, .reactionArrow ; $7d88
	call GetStatArrowExtraTile ; $7d8a
	call OffsetStatArrowSpriteX ; $7d8d
	call QueueSprite ; $7d90
.reactionArrow:
	ld a, [wCharDataEquipmentDeltas + CHARSTAT_REACTION] ; $7d93
	or a ; $7d96
	jr z, .stopArrow ; $7d97
	call GetStatArrowSpriteAttr ; $7d99
	call GetStatArrowTile ; $7d9c
	push af ; $7d9f
	ld a, [wCharDataStatsNoEquipment + CHARSTAT_REACTION] ; $7da0
	ld l, a ; $7da3
	ld a, [wCharDataStatDeltas + CHARSTAT_REACTION] ; $7da4
	add l ; $7da7
	ld_xy de, $64, $74 ; $7da8
	call ComputeStatArrowSpriteX ; $7dab
	push de ; $7dae
	call QueueSprite ; $7daf
	pop de ; $7db2
	pop af ; $7db3
	or a ; $7db4
	jr z, .stopArrow ; $7db5
	call GetStatArrowExtraTile ; $7db7
	call OffsetStatArrowSpriteX ; $7dba
	call QueueSprite ; $7dbd
.stopArrow:
	ld a, [wCharDataEquipmentDeltas + CHARSTAT_STOP] ; $7dc0
	or a ; $7dc3
	jr z, .done ; $7dc4
	call GetStatArrowSpriteAttr ; $7dc6
	call GetStatArrowTile ; $7dc9
	push af ; $7dcc
	ld a, [wCharDataStatsNoEquipment + CHARSTAT_STOP] ; $7dcd
	ld l, a ; $7dd0
	ld a, [wCharDataStatDeltas + CHARSTAT_STOP] ; $7dd1
	add l ; $7dd4
	ld_xy de, $64, $84 ; $7dd5
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
CharDataConfirmScreenTopPatchList:
	; $7e46, 13 bytes (bytes:13)
	db $00, $00, $00, $0e, $00, $20, $0e, $0e, $00, $40, $1c, $0e, $ff ; 0x00
CharDataConfirmScreenTopTilemap:
	INCBIN "data/engine/menus/char_data/lz_CharDataConfirmScreenTopTilemap.bin" ; $7e53, 34 bytes
CharDataConfirmScreenTopAttrmap:
	INCBIN "data/engine/menus/char_data/lz_CharDataConfirmScreenTopAttrmap.bin" ; $7e75, 9 bytes
StatArrowObjPalettes:
	INCLUDE "data/engine/menus/char_data/StatArrowObjPalettes.asm" ; $7e7e, 16 bytes (palettes)
StatArrowDownGfx:
	INCBIN "data/engine/menus/char_data/lz_StatArrowDownGfx.bin" ; $7e8e, 11 bytes
	INCLUDE "data/engine/menus/char_data/lz_StatArrowDownGfx.inc" ; DEF StatArrowDownGfx_SIZE EQU its decoded length, generated from the .bin by make
StatArrowDownDoubleGfx:
	INCBIN "data/engine/menus/char_data/lz_StatArrowDownDoubleGfx.bin" ; $7e99, 11 bytes
	INCLUDE "data/engine/menus/char_data/lz_StatArrowDownDoubleGfx.inc" ; DEF StatArrowDownDoubleGfx_SIZE EQU its decoded length, generated from the .bin by make
StatArrowUpGfx:
	INCBIN "data/engine/menus/char_data/lz_StatArrowUpGfx.bin" ; $7ea4, 11 bytes
	INCLUDE "data/engine/menus/char_data/lz_StatArrowUpGfx.inc" ; DEF StatArrowUpGfx_SIZE EQU its decoded length, generated from the .bin by make
StatArrowUpDoubleGfx:
	INCBIN "data/engine/menus/char_data/lz_StatArrowUpDoubleGfx.bin" ; $7eaf, 11 bytes
	INCLUDE "data/engine/menus/char_data/lz_StatArrowUpDoubleGfx.inc" ; DEF StatArrowUpDoubleGfx_SIZE EQU its decoded length, generated from the .bin by make
	; $7eba, 326 bytes fill to bank end (linker-padded)
