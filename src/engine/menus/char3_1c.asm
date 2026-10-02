CharDataScreen_DrawPageColumnsTable0:
	; $4e36, 20 bytes (bytes:4)
	db $60, $d0, $05, $0a ; 0x00
	db $00, $d1, $07, $0a ; 0x04
	db $6a, $d0, $05, $0a ; 0x08
	db $0a, $d1, $09, $0a ; 0x0c
	db $e0, $d1, $03, $0a ; 0x10
CharDataScreen_DrawPageColumnsTable1:
	; $4e4a, 10 bytes (records:2)
	dw CharDataScreenPage0Columns ; record 0
	dw CharDataScreenPage1Columns ; record 1
	dw CharDataScreenPage2Columns ; record 2
	dw CharDataScreenPage3Columns ; record 3
	dw CharDataScreenPage4Columns ; record 4
DrawStatValueSprites:
	wram_bank WRAM_SCENE ; $4e54
	ld b, $0e ; $4e5a
	ld a, [wCharDataLevels] ; $4e5c
	ld l, a ; $4e5f
	ld a, [wCharDataLevelPreview] ; $4e60
	or a ; $4e63
	jr nz, .digits1 ; $4e64
	ld a, [wCharDataPage] ; $4e66
	or a ; $4e69
	jr nz, .digits1 ; $4e6a
	inc l ; $4e6c
	ld b, $0f ; $4e6d
.digits1:
	ld a, l ; $4e6f
	cp $0a ; $4e70
	jr c, .lt0a ; $4e72
	push bc ; $4e74
	ld h, $00 ; $4e75
	ld a, $02 ; $4e77
	ld de, wCharDataNumberBuffer ; $4e79
	call FormatDecimalNumberUnsigned ; $4e7c
	pop bc ; $4e7f
	push bc ; $4e80
	ld a, [wCharDataNumberBuffer] ; $4e81
	sub $30 ; $4e84
	rlca ; $4e86
	ld c, a ; $4e87
	ld_xy de, $05, $1c ; $4e88
	xor a ; $4e8b
	call GetStatDigitSpritePos ; $4e8c
	call QueueSprite ; $4e8f
	pop bc ; $4e92
	ld a, [wCharDataNumberBuffer + 1] ; $4e93
	sub $30 ; $4e96
	rlca ; $4e98
	ld c, a ; $4e99
	ld_xy de, $0c, $1c ; $4e9a
	xor a ; $4e9d
	call GetStatDigitSpritePos ; $4e9e
	call QueueSprite ; $4ea1
	jr .stat2 ; $4ea4
.lt0a:
	ld a, l ; $4ea6
	rlca ; $4ea7
	ld c, a ; $4ea8
	ld_xy de, $09, $1c ; $4ea9
	xor a ; $4eac
	call GetStatDigitSpritePos ; $4ead
	call QueueSprite ; $4eb0
.stat2:
	ld b, $0e ; $4eb3
	ld a, [wCharDataLevels + 1] ; $4eb5
	ld l, a ; $4eb8
	ld a, [wCharDataLevelPreview] ; $4eb9
	or a ; $4ebc
	jr nz, .digits2 ; $4ebd
	ld a, [wCharDataPage] ; $4ebf
	cp $01 ; $4ec2
	jr nz, .digits2 ; $4ec4
	inc l ; $4ec6
	ld b, $0f ; $4ec7
.digits2:
	ld a, l ; $4ec9
	cp $0a ; $4eca
	jr c, .lt0a2 ; $4ecc
	push bc ; $4ece
	ld h, $00 ; $4ecf
	ld a, $02 ; $4ed1
	ld de, wCharDataNumberBuffer ; $4ed3
	call FormatDecimalNumberUnsigned ; $4ed6
	pop bc ; $4ed9
	push bc ; $4eda
	ld a, [wCharDataNumberBuffer] ; $4edb
	sub $30 ; $4ede
	rlca ; $4ee0
	ld c, a ; $4ee1
	ld_xy de, $05, $44 ; $4ee2
	ld a, $01 ; $4ee5
	call GetStatDigitSpritePos ; $4ee7
	call QueueSprite ; $4eea
	pop bc ; $4eed
	ld a, [wCharDataNumberBuffer + 1] ; $4eee
	sub $30 ; $4ef1
	rlca ; $4ef3
	ld c, a ; $4ef4
	ld_xy de, $0c, $44 ; $4ef5
	ld a, $01 ; $4ef8
	call GetStatDigitSpritePos ; $4efa
	call QueueSprite ; $4efd
	jr .stat3 ; $4f00
.lt0a2:
	ld a, l ; $4f02
	rlca ; $4f03
	ld c, a ; $4f04
	ld_xy de, $09, $44 ; $4f05
	ld a, $01 ; $4f08
	call GetStatDigitSpritePos ; $4f0a
	call QueueSprite ; $4f0d
.stat3:
	ld b, $0e ; $4f10
	ld a, [wCharDataLevels + 2] ; $4f12
	ld l, a ; $4f15
	ld a, [wCharDataLevelPreview] ; $4f16
	or a ; $4f19
	jr nz, .digits3 ; $4f1a
	ld a, [wCharDataPage] ; $4f1c
	cp $02 ; $4f1f
	jr nz, .digits3 ; $4f21
	inc l ; $4f23
	ld b, $0f ; $4f24
.digits3:
	ld a, l ; $4f26
	cp $0a ; $4f27
	jr c, .lt0a3 ; $4f29
	push bc ; $4f2b
	ld h, $00 ; $4f2c
	ld a, $02 ; $4f2e
	ld de, wCharDataNumberBuffer ; $4f30
	call FormatDecimalNumberUnsigned ; $4f33
	pop bc ; $4f36
	push bc ; $4f37
	ld a, [wCharDataNumberBuffer] ; $4f38
	sub $30 ; $4f3b
	rlca ; $4f3d
	ld c, a ; $4f3e
	ld_xy de, $55, $1c ; $4f3f
	ld a, $02 ; $4f42
	call GetStatDigitSpritePos ; $4f44
	call QueueSprite ; $4f47
	pop bc ; $4f4a
	ld a, [wCharDataNumberBuffer + 1] ; $4f4b
	sub $30 ; $4f4e
	rlca ; $4f50
	ld c, a ; $4f51
	ld_xy de, $5c, $1c ; $4f52
	ld a, $02 ; $4f55
	call GetStatDigitSpritePos ; $4f57
	call QueueSprite ; $4f5a
	jr .stat4 ; $4f5d
.lt0a3:
	ld a, l ; $4f5f
	rlca ; $4f60
	ld c, a ; $4f61
	ld_xy de, $59, $1c ; $4f62
	ld a, $02 ; $4f65
	call GetStatDigitSpritePos ; $4f67
	call QueueSprite ; $4f6a
.stat4:
	ld b, $0e ; $4f6d
	ld a, [wCharDataLevels + 3] ; $4f6f
	ld l, a ; $4f72
	ld a, [wCharDataLevelPreview] ; $4f73
	or a ; $4f76
	jr nz, .digits4 ; $4f77
	ld a, [wCharDataPage] ; $4f79
	cp $03 ; $4f7c
	jr nz, .digits4 ; $4f7e
	inc l ; $4f80
	ld b, $0f ; $4f81
.digits4:
	ld a, l ; $4f83
	cp $0a ; $4f84
	jr c, .lt0a4 ; $4f86
	push bc ; $4f88
	ld h, $00 ; $4f89
	ld a, $02 ; $4f8b
	ld de, wCharDataNumberBuffer ; $4f8d
	call FormatDecimalNumberUnsigned ; $4f90
	pop bc ; $4f93
	push bc ; $4f94
	ld a, [wCharDataNumberBuffer] ; $4f95
	sub $30 ; $4f98
	rlca ; $4f9a
	ld c, a ; $4f9b
	ld_xy de, $55, $44 ; $4f9c
	ld a, $03 ; $4f9f
	call GetStatDigitSpritePos ; $4fa1
	call QueueSprite ; $4fa4
	pop bc ; $4fa7
	ld a, [wCharDataNumberBuffer + 1] ; $4fa8
	sub $30 ; $4fab
	rlca ; $4fad
	ld c, a ; $4fae
	ld_xy de, $5c, $44 ; $4faf
	ld a, $03 ; $4fb2
	call GetStatDigitSpritePos ; $4fb4
	call QueueSprite ; $4fb7
	jr .drawStatChangeArrows ; $4fba
.lt0a4:
	ld a, l ; $4fbc
	rlca ; $4fbd
	ld c, a ; $4fbe
	ld_xy de, $59, $44 ; $4fbf
	ld a, $03 ; $4fc2
	call GetStatDigitSpritePos ; $4fc4
	call QueueSprite ; $4fc7
.drawStatChangeArrows:
	farcall DrawStatChangeArrows ; $4fca
	ret ; $4fcd
GetStatDigitSpritePos:
	rlca ; $4fce
	ld_hl_indexed RadialOffsetRamps_1c ; $4fcf
	ld a, [hl+] ; $4fd6
	ld h, [hl] ; $4fd7
	ld l, a ; $4fd8
	ld a, [wCharDataRevealTimer] ; $4fd9
	rlca ; $4fdc
	add l ; $4fdd
	ld l, a ; $4fde
	jr nc, .readOffsets ; $4fdf
	inc h ; $4fe1
.readOffsets:
	ld a, [hl+] ; $4fe2
	add d ; $4fe3
	ld d, a ; $4fe4
	ld a, [hl] ; $4fe5
	add e ; $4fe6
	ld e, a ; $4fe7
	ret ; $4fe8
RadialOffsetRamps_1c:
	dw RadialOffsetRamp0_1c, RadialOffsetRamp1_1c, RadialOffsetRamp2_1c, RadialOffsetRamp3_1c ; $4fe9
RadialOffsetRamp0_1c:
	INCBIN "data/bank_01c/RadialOffsetRamp0_1c.bin" ; $4ff1, 22 bytes
RadialOffsetRamp1_1c:
	INCBIN "data/bank_01c/RadialOffsetRamp1_1c.bin" ; $5007, 22 bytes
RadialOffsetRamp2_1c:
	INCBIN "data/bank_01c/RadialOffsetRamp2_1c.bin" ; $501d, 22 bytes
RadialOffsetRamp3_1c:
	INCBIN "data/bank_01c/RadialOffsetRamp3_1c.bin" ; $5033, 22 bytes
DrawRemainingPointsSprite:
	wram_bank WRAM_SCENE ; $5049
	ld a, [wCharDataPointsLeft] ; $504f
	cp $0a ; $5052
	jr c, .lt0a ; $5054
	ld h, $00 ; $5056
	ld l, a ; $5058
	ld a, $02 ; $5059
	ld de, wCharDataNumberBuffer ; $505b
	call FormatDecimalNumberUnsigned ; $505e
	ld a, [wCharDataNumberBuffer] ; $5061
	sub $30 ; $5064
	rlca ; $5066
	ld c, a ; $5067
	ld_xy de, $14, $7f ; $5068
	call OffsetStatSpriteY ; $506b
	ld b, $0f ; $506e
	call QueueSprite ; $5070
	ld a, [wCharDataNumberBuffer + 1] ; $5073
	sub $30 ; $5076
	rlca ; $5078
	ld c, a ; $5079
	ld_xy de, $1b, $7f ; $507a
	call OffsetStatSpriteY ; $507d
	ld b, $0f ; $5080
	call QueueSprite ; $5082
	ret ; $5085
.lt0a:
	rlca ; $5086
	ld c, a ; $5087
	ld_xy de, $18, $7f ; $5088
	call OffsetStatSpriteY ; $508b
	ld b, $0f ; $508e
	call QueueSprite ; $5090
	ret ; $5093
OffsetStatSpriteY:
	ld a, [wCharDataRevealStep] ; $5094
	rlca ; $5097
	rlca ; $5098
	rlca ; $5099
	add e ; $509a
	ld e, a ; $509b
	ret ; $509c
CharDataScreen_InputLoop:
	wram_bank WRAM_SCENE ; $509d
	ld a, [wCharDataViewOnly] ; $50a3
	or a ; $50a6
	jp nz, .finish ; $50a7
	call AdvanceFrame ; $50aa
	ldh a, [hInputRisingEdge] ; $50ad
	push af ; $50af
	test_flag FLAG_CHAR_DATA_START_EXITS ; $50b0
	jr z, .readInput ; $50b3
	bit 3, a ; $50b5
	jr z, .readInput ; $50b7
	pop af ; $50b9
	jp .finish ; $50ba
.readInput:
	pop af ; $50bd
	bit 0, a ; $50be
	jr nz, .pressA ; $50c0
	bit 1, a ; $50c2
	jr nz, .pressB ; $50c4
	bit 4, a ; $50c6
	jr nz, .moveRight ; $50c8
	bit 5, a ; $50ca
	jr nz, .moveLeft ; $50cc
	bit 7, a ; $50ce
	jr nz, .moveDown ; $50d0
	bit 6, a ; $50d2
	jr nz, .moveUp ; $50d4
	jr CharDataScreen_InputLoop ; $50d6
.moveUp:
	ld hl, CharDataPageUpTargets_1c ; $50d8
	call MoveCharDataScreenSelection ; $50db
	jr CharDataScreen_InputLoop ; $50de
.moveDown:
	ld hl, CharDataPageDownTargets_1c ; $50e0
	call MoveCharDataScreenSelection ; $50e3
	jr CharDataScreen_InputLoop ; $50e6
.moveLeft:
	ld hl, CharDataPageLeftTargets_1c ; $50e8
	call MoveCharDataScreenSelection ; $50eb
	jr CharDataScreen_InputLoop ; $50ee
.moveRight:
	ld hl, CharDataPageRightTargets_1c ; $50f0
	call MoveCharDataScreenSelection ; $50f3
	jp CharDataScreen_InputLoop ; $50f6
.pressB:
	wram_bank WRAM_SCENE ; $50f9
	ld a, [wCharDataPage] ; $50ff
	cp $04 ; $5102
	jr nz, .selectConfirmCell ; $5104
	call ApplyCharStatLevelUp ; $5106
	or a ; $5109
	jp nz, CharDataScreen_InputLoop ; $510a
	ld a, $01 ; $510d
	ret ; $510f
.selectConfirmCell:
	ld a, $04 ; $5110
	ld [wCharDataPage], a ; $5112
	call RestoreCharDataScreenRow ; $5115
	call LoadCharStats ; $5118
	call CharDataScreen_DrawStats ; $511b
	call DrawCharStatsAndFlush ; $511e
	call CharDataScreen_DrawPageColumns ; $5121
	call FlushCharDataTilemaps ; $5124
	jp nz, CharDataScreen_InputLoop ; $5127
.pressA:
	wram_bank WRAM_SCENE ; $512a
	ld a, [wCharDataPage] ; $5130
	cp $04 ; $5133
	jp z, CharDataScreen_InputLoop ; $5135
	sound SFX_MENU_SELECT ; $5138
	ld d, a ; $513a
	ld a, [wStoryCharacterSlot] ; $513b
	farcall LevelUpPlayer ; $513e
	wram_bank WRAM_SCENE ; $5141
	ld hl, wCharDataPointsLeft ; $5147
	dec [hl] ; $514a
	ld a, [wCharDataChoiceCount] ; $514b
	add $2a ; $514e
	ld l, a ; $5150
	adc $d0 ; $5151
	sub l ; $5153
	ld h, a ; $5154
	ld a, [wCharDataPage] ; $5155
	ld [hl], a ; $5158
	ld hl, wCharDataChoiceCount ; $5159
	inc [hl] ; $515c
	ld a, $04 ; $515d
	ld [wCharDataPage], a ; $515f
	test_flag FLAG_CHAR_DATA_START_EXITS ; $5162
	jr nz, .checkStatCap ; $5165
	ld a, [wStoryCharacterSlot] ; $5167
	farcall HasReachedNextLevelExp ; $516a
	jr nz, .finish ; $516d
	jr .redraw ; $516f
.checkStatCap:
	ld a, [wStoryCharacterSlot] ; $5171
	push af ; $5174
	ld hl, wStoryModeNameOfMainCharacter ; $5175
	ld a, [wStoryCharacterSlot] ; $5178
	or a ; $517b
	jr z, .readStatCap ; $517c
	ld l, $40 ; $517e
.readStatCap:
	ld a, l ; $5180
	add $18 ; $5181
	ld l, a ; $5183
	ld a, h ; $5184
	adc $00 ; $5185
	ld h, a ; $5187
	pop af ; $5188
	ld a, [hl] ; $5189
	cp $63 ; $518a
	jr z, .finish ; $518c
.redraw:
	call RestoreCharDataScreenRow ; $518e
	call LoadCharStats ; $5191
	call CharDataScreen_DrawStats ; $5194
	call DrawCharStatsAndFlush ; $5197
	call CharDataScreen_DrawPageColumns ; $519a
	call FlushCharDataTilemaps ; $519d
	jp CharDataScreen_InputLoop ; $51a0
.finish:
	wram_bank WRAM_SCENE ; $51a3
	ld a, [wCharDataViewOnly] ; $51a9
	or a ; $51ac
	jp nz, .skipWipe ; $51ad
	ld hl, DrawStatArrowIndicators ; $51b0
	call UnregisterFrameTask ; $51b3
	call LoadCharStats ; $51b6
	call CharDataScreen_DrawStats ; $51b9
	call RestoreCharDataScreenRow ; $51bc
	call DrawCharStatRows ; $51bf
	ld hl, CharDataBand6RunsStep2_1c ; $51c2
	ld bc, wScreenAttrmap + 29 * TILEMAP_WIDTH ; $51c5
	call BlitTilemapRunsFromTable ; $51c8
	ld hl, CharDataBand5RunsStep2_1c ; $51cb
	ld bc, wScreenAttrmap + 28 * TILEMAP_WIDTH ; $51ce
	call BlitTilemapRunsFromTable ; $51d1
	wram_bank WRAM_SCENE ; $51d4
	ld a, $01 ; $51da
	ld [wCharDataRevealStep], a ; $51dc
	ld [wCharDataConfirmState], a ; $51df
	ld [wCharDataLevelPreview], a ; $51e2
	call FlushCharDataTilemaps ; $51e5
	call RestoreCharDataScreenRow ; $51e8
	call DrawCharStatRows ; $51eb
	ld hl, CharDataBand6RunsStep1_1c ; $51ee
	ld bc, wScreenAttrmap + 29 * TILEMAP_WIDTH ; $51f1
	call BlitTilemapRunsFromTable ; $51f4
	ld hl, CharDataBand5RunsStep1_1c ; $51f7
	ld bc, wScreenAttrmap + 28 * TILEMAP_WIDTH ; $51fa
	call BlitTilemapRunsFromTable ; $51fd
	wram_bank WRAM_SCENE ; $5200
	ld a, $02 ; $5206
	ld [wCharDataRevealStep], a ; $5208
	call FlushCharDataTilemaps ; $520b
	wram_bank WRAM_SCENE ; $520e
	ld a, $03 ; $5214
	ld [wCharDataRevealStep], a ; $5216
	ld hl, DrawRemainingPointsSprite ; $5219
	call UnregisterFrameTask ; $521c
	call RestoreCharDataScreenRow ; $521f
	call DrawCharStatRows ; $5222
	call FlushCharDataTilemaps ; $5225
	call RestoreCharDataScreenRow ; $5228
	call DrawCharStatRows ; $522b
	ld hl, CharDataBand8RunsStep1_1c ; $522e
	ld bc, wCharDataPagePlane + 16 ; $5231
	call BlitTilemapRunsFromTable ; $5234
	call FlushCharDataTilemaps ; $5237
	call RestoreCharDataScreenRow ; $523a
	call DrawCharStatRows ; $523d
	ld hl, CharDataBand7RunsStep1_1c ; $5240
	ld bc, wScreenAttrmap + 31 * TILEMAP_WIDTH ; $5243
	call BlitTilemapRunsFromTable ; $5246
	ld hl, CharDataBand8RunsStep2_1c ; $5249
	ld bc, wCharDataPagePlane + 16 ; $524c
	call BlitTilemapRunsFromTable ; $524f
	call FlushCharDataTilemaps ; $5252
	call RestoreCharDataScreenRow ; $5255
	call DrawCharStatRows ; $5258
	ld hl, CharDataBand7RunsStep2_1c ; $525b
	ld bc, wScreenAttrmap + 31 * TILEMAP_WIDTH ; $525e
	call BlitTilemapRunsFromTable ; $5261
	ld hl, CharDataBand8RunsStep3_1c ; $5264
	ld bc, wCharDataPagePlane + 16 ; $5267
	call BlitTilemapRunsFromTable ; $526a
	call FlushCharDataTilemaps ; $526d
	call RestoreCharDataScreenRow ; $5270
	call DrawCharStatRows ; $5273
	ld hl, CharDataBand7RunsStep3_1c ; $5276
	ld bc, wScreenAttrmap + 31 * TILEMAP_WIDTH ; $5279
	call BlitTilemapRunsFromTable ; $527c
	ld hl, CharDataBand8RunsStep4_1c ; $527f
	ld bc, wCharDataPagePlane + 16 ; $5282
	call BlitTilemapRunsFromTable ; $5285
	call FlushCharDataTilemaps ; $5288
	jr .confirmLoop ; $528b
.skipWipe:
	xor a ; $528d
	ld [wCharDataViewOnly], a ; $528e
.confirmLoop:
	call DrawConfirmSelectionCursor_1c ; $5291
	call AdvanceFrame ; $5294
	ldh a, [hInputRisingEdge] ; $5297
	bit PADB_A, a ; $5299
	jr nz, .confirmA ; $529b
	bit 1, a ; $529d
	jr nz, .cancel ; $529f
	and $c0 ; $52a1
	jr z, .confirmLoop ; $52a3
	sound SFX_MENU_MOVE ; $52a5
	ld a, [wCharDataConfirmState] ; $52a7
	xor $01 ; $52aa
	ld [wCharDataConfirmState], a ; $52ac
	jr .confirmLoop ; $52af
.confirmA:
	wram_bank WRAM_SCENE ; $52b1
	ld a, [wCharDataConfirmState] ; $52b7
	or a ; $52ba
	jr nz, .cancel ; $52bb
	sound SFX_MENU_SELECT ; $52bd
	xor a ; $52bf
	ret ; $52c0
.cancel:
	sound SFX_MENU_CANCEL ; $52c1
	call SelectCharDataConfirmSlot ; $52c3
	call RestoreCharDataScreenRow ; $52c6
	call LoadCharStats ; $52c9
	call CharDataScreen_DrawStats ; $52cc
	call DrawCharStatRows ; $52cf
	ld hl, CharDataBand7RunsStep2_1c ; $52d2
	ld bc, wScreenAttrmap + 31 * TILEMAP_WIDTH ; $52d5
	call BlitTilemapRunsFromTable ; $52d8
	ld hl, CharDataBand8RunsStep3_1c ; $52db
	ld bc, wCharDataPagePlane + 16 ; $52de
	call BlitTilemapRunsFromTable ; $52e1
	call FlushCharDataTilemaps ; $52e4
	call RestoreCharDataScreenRow ; $52e7
	call DrawCharStatRows ; $52ea
	ld hl, CharDataBand7RunsStep1_1c ; $52ed
	ld bc, wScreenAttrmap + 31 * TILEMAP_WIDTH ; $52f0
	call BlitTilemapRunsFromTable ; $52f3
	ld hl, CharDataBand8RunsStep2_1c ; $52f6
	ld bc, wCharDataPagePlane + 16 ; $52f9
	call BlitTilemapRunsFromTable ; $52fc
	call FlushCharDataTilemaps ; $52ff
	call RestoreCharDataScreenRow ; $5302
	call DrawCharStatRows ; $5305
	ld hl, CharDataBand8RunsStep1_1c ; $5308
	ld bc, wCharDataPagePlane + 16 ; $530b
	call BlitTilemapRunsFromTable ; $530e
	call FlushCharDataTilemaps ; $5311
	call RestoreCharDataScreenRow ; $5314
	call DrawCharStatRows ; $5317
	call FlushCharDataTilemaps ; $531a
	wram_bank WRAM_SCENE ; $531d
	ld a, $03 ; $5323
	ld [wCharDataRevealStep], a ; $5325
	call FlushCharDataTilemaps ; $5328
	ld a, $01 ; $532b
	ld hl, DrawRemainingPointsSprite ; $532d
	call RegisterFrameTask ; $5330
	call RestoreCharDataScreenRow ; $5333
	call DrawCharStatRows ; $5336
	ld hl, CharDataBand6RunsStep1_1c ; $5339
	ld bc, wScreenAttrmap + 29 * TILEMAP_WIDTH ; $533c
	call BlitTilemapRunsFromTable ; $533f
	ld hl, CharDataBand5RunsStep1_1c ; $5342
	ld bc, wScreenAttrmap + 28 * TILEMAP_WIDTH ; $5345
	call BlitTilemapRunsFromTable ; $5348
	wram_bank WRAM_SCENE ; $534b
	ld a, $02 ; $5351
	ld [wCharDataRevealStep], a ; $5353
	call FlushCharDataTilemaps ; $5356
	call RestoreCharDataScreenRow ; $5359
	call DrawCharStatRows ; $535c
	ld hl, CharDataBand6RunsStep2_1c ; $535f
	ld bc, wScreenAttrmap + 29 * TILEMAP_WIDTH ; $5362
	call BlitTilemapRunsFromTable ; $5365
	ld hl, CharDataBand5RunsStep2_1c ; $5368
	ld bc, wScreenAttrmap + 28 * TILEMAP_WIDTH ; $536b
	call BlitTilemapRunsFromTable ; $536e
	wram_bank WRAM_SCENE ; $5371
	ld a, $01 ; $5377
	ld [wCharDataRevealStep], a ; $5379
	call FlushCharDataTilemaps ; $537c
	wram_bank WRAM_SCENE ; $537f
	xor a ; $5385
	ld [wCharDataLevelPreview], a ; $5386
	ld [wCharDataRevealStep], a ; $5389
	call RestoreCharDataScreenRow ; $538c
	call DrawCharStatsAndFlush ; $538f
	call CharDataScreen_DrawPageColumns ; $5392
	call FlushCharDataTilemaps ; $5395
	ld a, $01 ; $5398
	ld hl, DrawStatArrowIndicators ; $539a
	call RegisterFrameTask ; $539d
	jp CharDataScreen_InputLoop ; $53a0
