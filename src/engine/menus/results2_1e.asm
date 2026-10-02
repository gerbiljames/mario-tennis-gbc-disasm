ClearRoundLabelRow:
	wram_bank WRAM_SCREEN ; $4867
	ld a, $03 ; $486d
	ld [wShadowTilemap + 13 * TILEMAP_WIDTH + 10], a ; $486f
	ld hl, wShadowTilemap + 14 * TILEMAP_WIDTH + 10 ; $4872
	ld a, $20 ; $4875
	ld [hl+], a ; $4877
	ld [hl+], a ; $4878
	ld [hl+], a ; $4879
	ld [hl+], a ; $487a
	ld [hl+], a ; $487b
	ld [hl+], a ; $487c
	ld [hl+], a ; $487d
	ld [hl+], a ; $487e
	ld [hl], a ; $487f
	ret ; $4880
DrawPracticeMatchLabel:
	ld hl, Text_31_224 ; $4881
	ld de, wScreenAttrmap + 14 * TILEMAP_WIDTH + 11 ; $4884
	ld bc, $0020 ; $4887
	call DrawProportionalTextLine ; $488a
	ret ; $488d
DrawMarioExhibitionLabel:
	ld hl, Text_31_234 ; $488e
	ld de, wScreenAttrmap + 14 * TILEMAP_WIDTH + 1 ; $4891
	ld bc, $0020 ; $4894
	call DrawProportionalTextLine ; $4897
	ret ; $489a
DrawPlayerNameAndLevel:
	ld a, [wGameMode] ; $489b
	cp GAMEMODE_EXHIBITION ; $489e
	ret z ; $48a0
	wram_bank WRAM_STAGING ; $48a1
	ld hl, ResultsPlayerPanelTilemap_1e ; $48a7
	ld de, wDecompBuffer ; $48aa
	call DecompressData ; $48ad
	ld hl, ResultsPlayerPanelAttrmap_1e ; $48b0
	ld de, wDecompBuffer + 12 * TILE_SIZE + 8 ; $48b3
	call DecompressData ; $48b6
	ld hl, wDecompBuffer ; $48b9
	ld de, wDecompBuffer + 10 * TILE_SIZE ; $48bc
	ld c, $08 ; $48bf
	call CopyTilesAndAttrsRun ; $48c1
	ld de, wScreenAttrmap + 6 * TILEMAP_WIDTH ; $48c4
	ld c, $08 ; $48c7
	call CopyTilesAndAttrsRun ; $48c9
	ld de, wScreenAttrmap + 7 * TILEMAP_WIDTH ; $48cc
	ld c, $08 ; $48cf
	call CopyTilesAndAttrsRun ; $48d1
	ld de, wScreenAttrmap + 8 * TILEMAP_WIDTH ; $48d4
	ld c, $08 ; $48d7
	call CopyTilesAndAttrsRun ; $48d9
	ld de, wScreenAttrmap + 9 * TILEMAP_WIDTH ; $48dc
	ld c, $08 ; $48df
	call CopyTilesAndAttrsRun ; $48e1
	wram_bank WRAM_SCREEN ; $48e4
	ld a, $20 ; $48ea
	ld hl, wShadowTilemap + 5 * TILEMAP_WIDTH ; $48ec
	call Fill7Bytes ; $48ef
	ld hl, wShadowTilemap + 6 * TILEMAP_WIDTH ; $48f2
	call Fill7Bytes ; $48f5
	ld hl, wShadowTilemap + 7 * TILEMAP_WIDTH ; $48f8
	call Fill7Bytes ; $48fb
	ld hl, wShadowTilemap + 8 * TILEMAP_WIDTH ; $48fe
	call Fill7Bytes ; $4901
	ld hl, wStoryModeNameOfMainCharacter ; $4904
	call CopyStringToTextBuffer ; $4907
	ld de, wShadowTilemap + 6 * TILEMAP_WIDTH ; $490a
	ld bc, $0020 ; $490d
	call WriteTextToTilemap ; $4910
	ld hl, Text_31_228 ; $4913
	ld de, wShadowTilemap + 8 * TILEMAP_WIDTH + 1 ; $4916
	ld bc, $0020 ; $4919
	call FetchAndDrawDialogueText ; $491c
	ld a, [wStoryMainCharExpTier] ; $491f
	ld h, $00 ; $4922
	ld l, a ; $4924
	ld a, $02 ; $4925
	ld de, wTextBuffer ; $4927
	call FormatDecimalNumberUnsigned ; $492a
	ld hl, wTextBuffer ; $492d
	ld de, wShadowTilemap + 8 * TILEMAP_WIDTH + 4 ; $4930
	ld bc, $0020 ; $4933
	call WriteTextToTilemap ; $4936
	wram_bank WRAM_COURT_PLANES ; $4939
	ld a, $04 ; $493f
	ld hl, wScreenAttrmap + 5 * TILEMAP_WIDTH ; $4941
	call Fill7Bytes ; $4944
	ld hl, wScreenAttrmap + 6 * TILEMAP_WIDTH ; $4947
	call Fill7Bytes ; $494a
	ld hl, wScreenAttrmap + 7 * TILEMAP_WIDTH ; $494d
	call Fill7Bytes ; $4950
	ld hl, wScreenAttrmap + 8 * TILEMAP_WIDTH ; $4953
	call Fill7Bytes ; $4956
	ret ; $4959
Fill7Bytes:
	ld [hl+], a ; $495a
	ld [hl+], a ; $495b
	ld [hl+], a ; $495c
	ld [hl+], a ; $495d
	ld [hl+], a ; $495e
	ld [hl+], a ; $495f
	ld [hl], a ; $4960
	ret ; $4961
CopyTilesAndAttrsRun:
	wram_bank WRAM_STAGING ; $4962
	ld b, [hl] ; $4968
	wram_bank WRAM_SCREEN ; $4969
	ld a, b ; $496f
	ld [de], a ; $4970
	wram_bank WRAM_STAGING ; $4971
	push hl ; $4977
	ld a, $c8 ; $4978
	add l ; $497a
	ld l, a ; $497b
	jr nc, .readAttr ; $497c
	inc h ; $497e
.readAttr:
	ld b, [hl] ; $497f
	wram_bank WRAM_COURT_PLANES ; $4980
	ld a, b ; $4986
	ld [de], a ; $4987
	pop hl ; $4988
	inc hl ; $4989
	inc de ; $498a
	dec c ; $498b
	jr nz, CopyTilesAndAttrsRun ; $498c
	ret ; $498e
InitResultsScreenCharacters:
	ld a, [wLinkMatchRole] ; $498f
	srl a ; $4992
	add $04 ; $4994
	ld a, a ; $4996
	wram_bank ; $4997
	ld bc, wCharPosX ; $499b
	ld a, [wGameMode] ; $499e
	or a ; $49a1
	jr nz, .nonZero ; $49a2
	ld a, [wStoryModeMainCharacterOverworldSprite] ; $49a4
	ld d, a ; $49a7
	ld a, [wStoryModeMainCharacterOverworldSpriteColor] ; $49a8
	ld e, a ; $49ab
	jr .initChar ; $49ac
.nonZero:
	ld a, [wLinkMatchRole] ; $49ae
	srl a ; $49b1
	or a ; $49b3
	jr nz, .checkPlayer2CurrentMainCharacter ; $49b4
	ld a, [wPlayer1CurrentMainCharacter] ; $49b6
	ld d, a ; $49b9
	ld a, [wPlayer1MainPalette] ; $49ba
	ld e, a ; $49bd
	jr .initChar ; $49be
.checkPlayer2CurrentMainCharacter:
	ld a, [wPlayer2CurrentMainCharacter] ; $49c0
	ld d, a ; $49c3
	ld a, [wPlayer2MainPalette] ; $49c4
	ld e, a ; $49c7
.initChar:
	ld a, d ; $49c8
	push af ; $49c9
	ld a, $00 ; $49ca
	farcall InitChar ; $49cc
	ld a, $0f ; $49cf
	ld [wCharSpriteAttr], a ; $49d1
	ld de, vTiles0 + VRAM_BANK1 ; $49d4
	ld hl, wCharFrameVramDest ; $49d7
	ld a, e ; $49da
	ld [hl+], a ; $49db
	ld [hl], d ; $49dc
	ld hl, wCharTileBase ; $49dd
	ld [hl], $00 ; $49e0
	ld bc, wCharPosX ; $49e2
	ld d, CHARANIM_CELEBRATE ; $49e5
	farcall SetCharAnimation ; $49e7
	pop af ; $49ea
	farcall GetCharPaletteIndex ; $49eb
	ld_obj_pals de, 7, 1 ; $49ee
	farcall LoadIndexedPaletteThunk ; $49f1
	wram_bank WRAM_SCENE ; $49f4
	ld a, [wContinuePromptKind] ; $49fa
	or a ; $49fd
	jr nz, .nonZero2 ; $49fe
	wram_bank WRAM_ACTORS ; $4a00
	test_flag FLAG_TEMP_RESULTS_SCREEN_OPEN ; $4a06
	ret z ; $4a09
.nonZero2:
	ld a, [wLinkMatchRole] ; $4a0a
	srl a ; $4a0d
	add $06 ; $4a0f
	ld a, a ; $4a11
	wram_bank ; $4a12
	ld bc, wCharPosX ; $4a16
	ld a, [wGameMode] ; $4a19
	or a ; $4a1c
	jr nz, .nonZero3 ; $4a1d
	ld a, [wStoryModePartnerCharacterOverworldSprite] ; $4a1f
	ld d, a ; $4a22
	ld a, [wStoryModePartnerCharacterOverworldSpriteColor] ; $4a23
	ld e, a ; $4a26
	jr .initChar2 ; $4a27
.nonZero3:
	ld a, [wLinkMatchRole] ; $4a29
	srl a ; $4a2c
	or a ; $4a2e
	jr nz, .checkPlayer2CurrentPartnerCharacter ; $4a2f
	ld a, [wPlayer1CurrentPartnerCharacter] ; $4a31
	ld d, a ; $4a34
	ld a, [wPlayer1PartnerPalette] ; $4a35
	ld e, a ; $4a38
	jr .initChar2 ; $4a39
.checkPlayer2CurrentPartnerCharacter:
	ld a, [wPlayer2CurrentPartnerCharacter] ; $4a3b
	ld d, a ; $4a3e
	ld a, [wPlayer2PartnerPalette] ; $4a3f
	ld e, a ; $4a42
.initChar2:
	ld a, d ; $4a43
	push af ; $4a44
	ld a, $02 ; $4a45
	farcall InitChar ; $4a47
	ld a, $0e ; $4a4a
	ld [wCharSpriteAttr], a ; $4a4c
	ld de, vTiles0 + $10 * TILE_SIZE + VRAM_BANK1 ; $4a4f
	ld hl, wCharFrameVramDest ; $4a52
	ld a, e ; $4a55
	ld [hl+], a ; $4a56
	ld [hl], d ; $4a57
	ld hl, wCharTileBase ; $4a58
	ld [hl], $10 ; $4a5b
	ld bc, wCharPosX ; $4a5d
	ld d, CHARANIM_CELEBRATE ; $4a60
	farcall SetCharAnimation ; $4a62
	pop af ; $4a65
	farcall GetCharPaletteIndex ; $4a66
	ld_obj_pals de, 6, 1 ; $4a69
	farcall LoadIndexedPaletteThunk ; $4a6c
	wram_bank WRAM_CHAR0 ; $4a6f
	ret ; $4a75
DrawResultsCharSprites:
	wram_bank WRAM_CHAR0 ; $4a76
	xor a ; $4a7c
	call UpdateResultsCharSprite ; $4a7d
	ld hl, wCharSpriteSlot ; $4a80
	farcall DrawCharSprite ; $4a83
	wram_bank WRAM_CHAR0 ; $4a86
	test_flag FLAG_TEMP_RESULTS_SCREEN_OPEN ; $4a8c
	ret z ; $4a8f
	wram_bank WRAM_CHAR2 ; $4a90
	ld a, $01 ; $4a96
	call UpdateResultsCharSprite ; $4a98
	ld hl, wCharSpriteSlot ; $4a9b
	farcall DrawCharSprite ; $4a9e
	wram_bank WRAM_CHAR0 ; $4aa1
	ret ; $4aa7
UpdateResultsCharSprite:
	push af ; $4aa8
	ld hl, wCharPosX ; $4aa9
	ld b, h ; $4aac
	ld c, l ; $4aad
	farcall StepCharAnimation ; $4aae
	ld d, $00 ; $4ab1
	push de ; $4ab3
	farcall ReloadCharFacingTiles ; $4ab4
	pop de ; $4ab7
	ld a, d ; $4ab8
	ld_hl_indexed UpdateResultsCharSpriteTable ; $4ab9
	ld b, [hl] ; $4ac0
	pop af ; $4ac1
	push af ; $4ac2
	or a ; $4ac3
	jr nz, .nonZero ; $4ac4
	ld a, [wPlayer1MainLeftHanded] ; $4ac6
	jr .compare ; $4ac9
.nonZero:
	ld a, [wPlayer2MainLeftHanded] ; $4acb
.compare:
	or a ; $4ace
	jr z, .zero ; $4acf
	ld a, $20 ; $4ad1
	xor b ; $4ad3
	ld b, a ; $4ad4
.zero:
	ld hl, wCharTileBase ; $4ad5
	ld a, [hl+] ; $4ad8
	ld c, a ; $4ad9
	ld a, [hl] ; $4ada
	or b ; $4adb
	ld b, a ; $4adc
	pop af ; $4add
	push af ; $4ade
	push bc ; $4adf
	push de ; $4ae0
	or a ; $4ae1
	jr nz, .nonZero2 ; $4ae2
	test_flag FLAG_TEMP_RESULTS_SCREEN_OPEN ; $4ae4
	jr z, .notTempResultsScreenOpen ; $4ae7
	ld d, $48 ; $4ae9
	ld e, $56 ; $4aeb
	jr .step5 ; $4aed
.notTempResultsScreenOpen:
	ld d, $54 ; $4aef
	ld e, $56 ; $4af1
	jr .step5 ; $4af3
.nonZero2:
	ld d, $60 ; $4af5
	ld e, $56 ; $4af7
.step5:
	ld a, d ; $4af9
	ld [wCharScreenX], a ; $4afa
	ld a, e ; $4afd
	ld [wCharScreenY], a ; $4afe
	pop hl ; $4b01
	add hl, hl ; $4b02
	add hl, hl ; $4b03
	add hl, hl ; $4b04
	pop bc ; $4b05
	pop af ; $4b06
	push hl ; $4b07
	ld hl, wCharSpriteSlot ; $4b08
	ld a, c ; $4b0b
	ld [hl+], a ; $4b0c
	ld a, b ; $4b0d
	ld [hl+], a ; $4b0e
	ld a, e ; $4b0f
	ld [hl+], a ; $4b10
	ld a, d ; $4b11
	ld [hl+], a ; $4b12
	ld a, [wCharSpriteFrame + 2] ; $4b13
	ld [hl+], a ; $4b16
	ld a, [wCharSpriteFrame + 1] ; $4b17
	ld [hl+], a ; $4b1a
	ld a, [wCharSpriteFrame] ; $4b1b
	ld [hl+], a ; $4b1e
	pop af ; $4b1f
	add $80 ; $4b20
	ld [hl+], a ; $4b22
	ret ; $4b23
UpdateResultsCharSpriteTable:
	; $4b24, 8 bytes (bytes:8)
	db $00, $00, $00, $20, $20, $20, $00, $00 ; 0x00
RunContinuePrompt:
	call DrawContinuePromptCursor ; $4b2c
	call AdvanceFrame ; $4b2f
	ldh a, [hInputRisingEdge] ; $4b32
	bit PADB_UP, a ; $4b34
	jr nz, DrawContinuePromptCursor.playSfx ; $4b36
	bit 7, a ; $4b38
	jr nz, DrawContinuePromptCursor.playSfx ; $4b3a
	bit 0, a ; $4b3c
	jr nz, DrawContinuePromptCursor.playSfx2 ; $4b3e
	bit 1, a ; $4b40
	jr nz, DrawContinuePromptCursor.playSfx3 ; $4b42
	jr RunContinuePrompt ; $4b44
DrawContinuePromptCursor:
	wram_bank WRAM_SCENE ; $4b46
	ld a, [wContinuePromptRow] ; $4b4c
	or a ; $4b4f
	jr nz, .nonZero ; $4b50
	ld_xy de, $7a, $3c ; $4b52
	jr .queueSprite ; $4b55
.nonZero:
	ld_xy de, $7a, $44 ; $4b57
.queueSprite:
	ld_oam bc, OAM_BANK1, $8e ; $4b5a
	call QueueSprite ; $4b5d
	ret ; $4b60
.playSfx:
	sound SFX_MENU_MOVE ; $4b61
	wram_bank WRAM_SCENE ; $4b63
	ld a, [wContinuePromptRow] ; $4b69
	xor $01 ; $4b6c
	ld [wContinuePromptRow], a ; $4b6e
	jr RunContinuePrompt ; $4b71
.playSfx2:
	sound SFX_MENU_SELECT ; $4b73
	wram_bank WRAM_SCENE ; $4b75
	ld a, [wContinuePromptPage] ; $4b7b
	or a ; $4b7e
	jr nz, .nonZero2 ; $4b7f
	ld a, [wContinuePromptRow] ; $4b81
	or a ; $4b84
	jr z, .zero ; $4b85
	ld a, $01 ; $4b87
	ld [wContinuePromptPage], a ; $4b89
	call RefreshContinuePromptText ; $4b8c
	jr RunContinuePrompt ; $4b8f
.nonZero2:
	ld a, [wContinuePromptRow] ; $4b91
	or a ; $4b94
	jr z, .zero2 ; $4b95
.loop:
	xor a ; $4b97
	ld [wContinuePromptPage], a ; $4b98
	call RefreshContinuePromptText ; $4b9b
	jr RunContinuePrompt ; $4b9e
.zero:
	ld a, $01 ; $4ba0
	ld [wContinuePromptResult], a ; $4ba2
	ret ; $4ba5
.zero2:
	ld a, [wContinuePromptPage] ; $4ba6
	add $ff ; $4ba9
	ld [wContinuePromptResult], a ; $4bab
	ret ; $4bae
.playSfx3:
	sound SFX_MENU_CANCEL ; $4baf
	wram_bank WRAM_SCENE ; $4bb1
	ld a, [wContinuePromptPage] ; $4bb7
	or a ; $4bba
	jr nz, .nonZero3 ; $4bbb
	ld a, $ff ; $4bbd
	ld [wContinuePromptResult], a ; $4bbf
	ld a, MENUSLIDE_BACK ; $4bc2
	ld [wMenuSlideDirection], a ; $4bc4
	ret ; $4bc7
.nonZero3:
	jr .loop ; $4bc8
RefreshContinuePromptText:
	ld a, [wContinuePromptPage] ; $4bca
	or a ; $4bcd
	jr nz, .nonZero ; $4bce
	xor a ; $4bd0
	ld [wContinuePromptRow], a ; $4bd1
	call ClearContinuePromptRows ; $4bd4
	ld hl, wContinuePromptTilemapRow2 + 1 ; $4bd7
	call DrawContinuePromptText ; $4bda
	ld hl, wContinuePromptKind ; $4bdd
	ld de, vBGMap0 ; $4be0
	ld c, $08 ; $4be3
	call QueueVRAMCopy ; $4be5
	wram_bank WRAM_SCENE ; $4be8
	ret ; $4bee
.nonZero:
	ld a, $01 ; $4bef
	ld [wContinuePromptRow], a ; $4bf1
	call ClearContinuePromptRows ; $4bf4
	ld hl, wContinuePromptTilemapRow1 + 1 ; $4bf7
	call DrawSaveWarningTextLine1 ; $4bfa
	ld hl, wContinuePromptTilemapRow3 + 1 ; $4bfd
	call DrawSaveWarningTextLine2 ; $4c00
	ld hl, wContinuePromptKind ; $4c03
	ld de, vBGMap0 ; $4c06
	ld c, $08 ; $4c09
	call QueueVRAMCopy ; $4c0b
	wram_bank WRAM_SCENE ; $4c0e
	ret ; $4c14
ClearContinuePromptRows:
	wram_bank WRAM_SCREEN ; $4c15
	ld a, $03 ; $4c1b
	ld hl, wShadowTilemap + 1 ; $4c1d
	ld c, $12 ; $4c20
	call FillMemoryC ; $4c22
	ld a, $20 ; $4c25
	ld hl, wShadowTilemap + 1 * TILEMAP_WIDTH + 1 ; $4c27
	ld c, $12 ; $4c2a
	call FillMemoryC ; $4c2c
	ld hl, wShadowTilemap + 2 * TILEMAP_WIDTH + 1 ; $4c2f
	ld c, $12 ; $4c32
	call FillMemoryC ; $4c34
	ld hl, wShadowTilemap + 3 * TILEMAP_WIDTH + 1 ; $4c37
	ld c, $12 ; $4c3a
	call FillMemoryC ; $4c3c
	ret ; $4c3f
