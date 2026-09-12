CharSelectNavGridTable:
	; $5f7c, 32 bytes (bytes:16)
	db $ff, $ff, $ff, $ff, $ff, $ff, $fe, $fd, $ff, $00, $01, $02, $03, $ff, $fe, $fd ; 0x00
	db $ff, $ff, $ff, $ff, $ff, $ff, $fe, $fd, $ff, $ff, $ff, $ff, $ff, $ff, $fe, $fd ; 0x10
CharSelectRosterTable:
	; $5f9c, 38 bytes (bytes:16)
	db $00, $00, $00, $b5, $30, $20, $c4, $00, $01, $00, $00, $b6, $30, $38, $c7, $00 ; 0x00
	db $02, $00, $00, $b7, $30, $50, $ca, $00, $03, $00, $00, $a8, $30, $68, $cd, $00 ; 0x10
	db $ff, $00, $00, $b0, $18, $20 ; 0x20
	ld h, h ; $5fc2
	nop ; $5fc3
FindCharSelectRosterEntry:
	ld hl, wCharSelectRoster ; $5fc4
	farcall FindRosterEntry ; $5fc7
	ret ; $5fca
GetCharSelectRosterField:
	push hl ; $5fcb
	call FindCharSelectRosterEntry ; $5fcc
	ld a, [hl+] ; $5fcf
	ld d, [hl] ; $5fd0
	ld e, a ; $5fd1
	pop hl ; $5fd2
	ret ; $5fd3
LoadCharSelectNavGrid:
	ld hl, CharSelectNavGridTable ; $5fd4
	ld de, wNavGridBuffer ; $5fd7
	ld bc, $0020 ; $5fda
	call CopyMemoryBC ; $5fdd
	ret ; $5fe0
LoadCharSelectRosterTable:
	ld hl, CharSelectRosterTable ; $5fe1
	ld de, wCharSelectRoster ; $5fe4
	ld bc, $0080 ; $5fe7
	call CopyMemoryBC ; $5fea
	ret ; $5fed
; LoadUnlockDebugScreenGfx with one more decompress and CharSelectNavGridTable as its source: the character-select variant of the same screen loader. Called only from Unused_1b_RunCharSelectLoop.
Unused_1b_LoadCharSelectScreenGfx:
	ld hl, CharSelectNavGridTable ; $5fee
	ld de, $d000 ; $5ff1
	call DecompressData ; $5ff4
	ld hl, $d000 ; $5ff7
	ld de, vTiles2 + VRAM_BANK1 ; $5ffa
	ld c, $80 ; $5ffd
	call QueueVRAMCopy ; $5fff
	ld hl, $d800 ; $6002
	ld de, vTiles1 + VRAM_BANK1 ; $6005
	ld c, $80 ; $6008
	call QueueVRAMCopy ; $600a
	ld hl, CharSelectNavGridTable ; $600d
	ld de, $dc00 ; $6010
	call DecompressData ; $6013
	ld hl, CharSelectNavGridTable ; $6016
	ld de, $d800 ; $6019
	call DecompressData ; $601c
	ld hl, CharSelectNavGridTable ; $601f
	lb de, $00, $08 ; $6022 palette index, count
	call LoadPaletteShadow ; $6025
	ret ; $6028
StartCharSelectCursorTask:
	farcall LoadCharSelectCursorGfx ; $6029
	ld a, $0a ; $602c
	ld hl, UpdateCharSelectCursorTask ; $602e
	call RegisterFrameTask ; $6031
	ret ; $6034
UpdateCharSelectCursorTask:
	ld a, [wCharSelectChar] ; $6035
	ld de, $0004 ; $6038
	call GetCharSelectRosterField ; $603b
	ld a, [wCharSelectChar] ; $603e
	farcall DrawCharSelectCursor ; $6041
	ret ; $6044
Unused_1b_DrawCharSelectPrompt:
	ld hl, $d000 ; $6045
	ld de, vTiles2 ; $6048
	ld c, $10 ; $604b
	call QueueVRAMCopy ; $604d
	ld hl, $d9e0 ; $6050
	ld de, $dde0 ; $6053
	ld bc, $1403 ; $6056
	farcall DrawBox ; $6059
	ld hl, $0470 ; $605c
	ld a, [wStoryCharacterSlot] ; $605f
	or a ; $6062
	jr z, .zero ; $6063
	ld hl, Text_31_123 ; $6065
.zero:
	ld de, $da01 ; $6068
	farcall RenderProportionalTextAt32 ; $606b
	ret ; $606e
DrawCharSelectMugshots:
	farcall ResetMugshotPalettes_1b ; $606f
	ld hl, wCharSelectRoster ; $6072
.loop:
	ld a, [hl] ; $6075
	farcall LoadCharacterRecordToBuffer ; $6076
	farcall CheckCharacterUnlocked ; $6079
	jr z, .step ; $607c
	ld a, [wCharRecordScratch + 11] ; $607e
	farcall LoadCharMugshotToBuffer ; $6081
	ld a, [hl] ; $6084
	ld de, $0002 ; $6085
	call GetCharSelectRosterField ; $6088
	farcall CopyMugshotBufferToVram ; $608b
	ld a, [hl] ; $608e
	ld de, $0006 ; $608f
	call GetCharSelectRosterField ; $6092
	ld a, [wCharRecordScratch + 11] ; $6095
	add a ; $6098
	add $c1 ; $6099
	ld c, a ; $609b
	adc $c7 ; $609c
	sub c ; $609e
	ld b, a ; $609f
	ld a, [bc] ; $60a0
	farcall SetMugshotAttrs ; $60a1
.step:
	ld a, $08 ; $60a4
	add l ; $60a6
	ld l, a ; $60a7
	jr nc, .read ; $60a8
	inc h ; $60aa
.read:
	ld a, [hl] ; $60ab
	cp $ff ; $60ac
	jr nz, .loop ; $60ae
	ld a, [wCharSelectChar] ; $60b0
	farcall LoadCharacterRecordToBuffer ; $60b3
	ld a, [wCharRecordScratch + 11] ; $60b6
	farcall StubNop_1b_01 ; $60b9
	ret ; $60bc
Unused_1b_RunCharSelectLoop:
	and $01 ; $60bd
	ld [wTargetZoneX2], a ; $60bf
	call ClearFrameTasks ; $60c2
	call AdvanceFrame ; $60c5
	push de ; $60c8
	call LoadCharSelectNavGrid ; $60c9
	call LoadCharSelectRosterTable ; $60cc
	pop de ; $60cf
	ld a, d ; $60d0
	ld [wCharSelectCol], a ; $60d1
	ld a, e ; $60d4
	ld [wCharSelectRow], a ; $60d5
	farcall UpdateCharSelectSelection ; $60d8
	ld a, [wCharSelectChar] ; $60db
	ld [wCharSelectPrevChar], a ; $60de
	ld c, $20 ; $60e1
	call BeginFadeOut ; $60e3
	call WaitFadeEnd ; $60e6
	call DisableLCDSafely ; $60e9
	call Unused_1b_LoadCharSelectScreenGfx ; $60ec
	call DrawCharSelectMugshots ; $60ef
	call Unused_1b_DrawCharSelectPrompt ; $60f2
	ld hl, $dc00 ; $60f5
	ld de, vBGMap0 + VRAM_BANK1 ; $60f8
	ld c, $24 ; $60fb
	call QueueVRAMCopy ; $60fd
	ld hl, $d800 ; $6100
	ld de, vBGMap0 ; $6103
	ld c, $24 ; $6106
	call QueueVRAMCopy ; $6108
	call EnableLCD ; $610b
	script_fade_in $20 ; $610e
	call WaitFadeEnd ; $6113
	call StartCharSelectCursorTask ; $6116
.loopB:
	wram_bank WRAM_STAGING ; $6119
	ldh a, [hInputRisingEdge] ; $611f
	and PADF_START ; $6121
	jr z, .checkInputRisingEdge ; $6123
	ld a, [wTargetZoneX2] ; $6125
	ld b, a ; $6128
	ld a, [wCharSelectChar] ; $6129
	farcall InitPlayerRecordForCharacter ; $612c
	sound SFX_MENU_SELECT ; $612f
	ld a, $fe ; $6131
	jr .step4 ; $6133
.checkInputRisingEdge:
	ldh a, [hInputRisingEdge] ; $6135
	and PADF_A ; $6137
	jr z, .checkInputRisingEdge2 ; $6139
	ld a, [wTargetZoneX2] ; $613b
	ld b, a ; $613e
	ld a, [wCharSelectChar] ; $613f
	farcall InitPlayerRecordForCharacter ; $6142
	sound SFX_MENU_SELECT ; $6145
	ld a, [wCharSelectChar] ; $6147
	jr .step4 ; $614a
.checkInputRisingEdge2:
	ldh a, [hInputRisingEdge] ; $614c
	and PADF_B ; $614e
	jr z, .moveCharSelectCursor ; $6150
	sound SFX_MENU_CANCEL ; $6152
	ld a, $ff ; $6154
	jr .step4 ; $6156
.moveCharSelectCursor:
	call MoveCharSelectCursor ; $6158
	call UpdateCharSelectSelection ; $615b
	ld a, [wCharSelectChar] ; $615e
	farcall LoadCharacterRecordToBuffer ; $6161
	call AdvanceFrame ; $6164
	jr .loopB ; $6167
.step4:
	ld hl, wCharSelectCol ; $6169
	ld d, [hl] ; $616c
	ld hl, wCharSelectRow ; $616d
	ld e, [hl] ; $6170
	ret ; $6171
UpdateCharSelectSelection:
	ld a, [wCharSelectChar] ; $6172
	ld [wCharSelectPrevChar], a ; $6175
	ld a, [wCharSelectRow] ; $6178
	add a ; $617b
	add a ; $617c
	add a ; $617d
	ld hl, wCharSelectCol ; $617e
	add [hl] ; $6181
	add $a0 ; $6182
	ld l, a ; $6184
	adc $c7 ; $6185
	sub l ; $6187
	ld h, a ; $6188
	ld a, [hl] ; $6189
	cp $ff ; $618a
.storeCharSelectChar:
	jr z, .storeCharSelectChar ; $618c
	ld [wCharSelectChar], a ; $618e
	ret ; $6191
MoveCharSelectCursor:
	ldh a, [hInputPressed] ; $6192
	ld b, a ; $6194
	and $f0 ; $6195
	jr z, .done ; $6197
	sound SFX_MENU_MOVE ; $6199
	ld a, [wCharSelectCol] ; $619b
	ld d, a ; $619e
	ld a, [wCharSelectRow] ; $619f
	ld e, a ; $61a2
.loop:
	ld hl, wNavGridBuffer ; $61a3
	farcall MoveGridCursor ; $61a6
	farcall LoadCharacterRecordToBuffer ; $61a9
	farcall CheckCharacterUnlocked ; $61ac
	jr z, .loop ; $61af
	ld a, d ; $61b1
	ld [wCharSelectCol], a ; $61b2
	ld a, e ; $61b5
	ld [wCharSelectRow], a ; $61b6
.done:
	ret ; $61b9
RunNewGameSetup:
	sound BGM_MENU ; $61ba
	farcall InitStoryModeState ; $61bc
	ld a, $00 ; $61bf
	farcall RollStoryRandomByte ; $61c1
	wram_bank WRAM_STAGING ; $61c4
	ld a, $01 ; $61ca
	ld [wCharSelectCursorCol], a ; $61cc
	ld a, $01 ; $61cf
	ld [wCharSelectCursorRow], a ; $61d1
	ld hl, wNewGameRosterFields ; $61d4
	xor a ; $61d7
.loop:
	push af ; $61d8
	farcall LoadCharacterRecordToBuffer ; $61d9
	ld a, [wCharRecordBuffer + 14] ; $61dc
	ld [hl+], a ; $61df
	ld a, [wCharRecordBuffer + 12] ; $61e0
	ld [hl+], a ; $61e3
	pop af ; $61e4
	inc a ; $61e5
	cp $04 ; $61e6
	jr nz, .loop ; $61e8
	ld a, [wStoryCharacterSlot] ; $61ea
	push af ; $61ed
	xor a ; $61ee
	ld [wStoryCharacterSlot], a ; $61ef
.loopB:
	ld a, [wCharSelectCursorCol] ; $61f2
	ld d, a ; $61f5
	ld a, [wCharSelectCursorRow] ; $61f6
	ld e, a ; $61f9
	ld b, $00 ; $61fa
	farcall RunCharacterSelectScreen ; $61fc
	ld hl, wCharSelectCursorCol ; $61ff
	ld [hl], d ; $6202
	ld hl, wCharSelectCursorRow ; $6203
	ld [hl], e ; $6206
	cp $ff ; $6207
	jr nz, .compare ; $6209
	pop af ; $620b
	ld [wStoryCharacterSlot], a ; $620c
	ld a, $ff ; $620f
	jp .beginFadeOut ; $6211
.compare:
	cp $fe ; $6214
	jr nz, .loop2 ; $6216
	jr .loopB ; $6218
.loop2:
	ld a, $01 ; $621a
	farcall RollStoryRandomByte ; $621c
	ld a, $00 ; $621f
	farcall PromptCharDataConfirm ; $6221
	and a ; $6224
	jr nz, .loopB ; $6225
	ld a, $02 ; $6227
	farcall RollStoryRandomByte ; $6229
.loop3:
	xor a ; $622c
	ld [wStoryCharacterSlot], a ; $622d
	push af ; $6230
	ld hl, wStoryModeNameOfMainCharacter ; $6231
	ld a, [wStoryCharacterSlot] ; $6234
	or a ; $6237
	jr z, .zero ; $6238
	ld l, $40 ; $623a
.zero:
	ld a, l ; $623c
	add $0b ; $623d
	ld l, a ; $623f
	ld a, h ; $6240
	adc $00 ; $6241
	ld h, a ; $6243
	pop af ; $6244
	ld c, [hl] ; $6245
	ld b, $00 ; $6246
	farcall RunNameEntryScreen ; $6248
	and a ; $624b
	jr nz, .loop2 ; $624c
	pop af ; $624e
	ld [wStoryCharacterSlot], a ; $624f
	ld a, [wStoryCharacterSlot] ; $6252
	push af ; $6255
	ld a, $01 ; $6256
	ld [wStoryCharacterSlot], a ; $6258
	ld de, SAVEFLAG_OPENING_SEEN ; $625b
	farcall TestSaveFlag ; $625e
	jr nz, .loop4 ; $6261
	push af ; $6263
	ld a, [wStoryModeMainCharacterOverworldSprite] ; $6264
	inc a ; $6267
	inc a ; $6268
	ld d, a ; $6269
	ld a, [wStoryCharacterSlot] ; $626a
	farcall InitPlayerRecordFromTemplate ; $626d
	push af ; $6270
	ld hl, wStoryModeNameOfMainCharacter ; $6271
	ld a, [wStoryCharacterSlot] ; $6274
	or a ; $6277
	jr z, .zero2 ; $6278
	ld l, $40 ; $627a
.zero2:
	ld a, l ; $627c
	add $0b ; $627d
	ld l, a ; $627f
	ld a, h ; $6280
	adc $00 ; $6281
	ld h, a ; $6283
	pop af ; $6284
	ld c, [hl] ; $6285
	ld b, $01 ; $6286
	farcall RunNameEntryScreen ; $6288
	ld b, a ; $628b
	pop af ; $628c
	ld a, b ; $628d
	and a ; $628e
	jr nz, .loop3 ; $628f
	jr .restore ; $6291
.loop4:
	ld a, [wCharSelectCursorCol] ; $6293
	ld d, a ; $6296
	ld a, [wCharSelectCursorRow] ; $6297
	ld e, a ; $629a
	ld b, $01 ; $629b
	farcall RunCharacterSelectScreen ; $629d
	ld hl, wCharSelectCursorCol ; $62a0
	ld [hl], d ; $62a3
	ld hl, wCharSelectCursorRow ; $62a4
	ld [hl], e ; $62a7
	cp $ff ; $62a8
	jr nz, .compare2 ; $62aa
	pop af ; $62ac
	ld [wStoryCharacterSlot], a ; $62ad
	jp RunNewGameSetup ; $62b0
.compare2:
	cp $fe ; $62b3
	jr nz, .loop5 ; $62b5
	jr .loop4 ; $62b7
.loop5:
	ld a, $01 ; $62b9
	farcall PromptCharDataConfirm ; $62bb
	and a ; $62be
	jr nz, .loop4 ; $62bf
	push af ; $62c1
	ld hl, wStoryModeNameOfMainCharacter ; $62c2
	ld a, [wStoryCharacterSlot] ; $62c5
	or a ; $62c8
	jr z, .zero3 ; $62c9
	ld l, $40 ; $62cb
.zero3:
	ld a, l ; $62cd
	add $0b ; $62ce
	ld l, a ; $62d0
	ld a, h ; $62d1
	adc $00 ; $62d2
	ld h, a ; $62d4
	pop af ; $62d5
	ld c, [hl] ; $62d6
	ld b, $01 ; $62d7
	farcall RunNameEntryScreen ; $62d9
	and a ; $62dc
	jr nz, .loop5 ; $62dd
.restore:
	pop af ; $62df
	ld [wStoryCharacterSlot], a ; $62e0
	ld hl, wStoryModeNameOfMainCharacter ; $62e3
	ld de, wStorySlotData ; $62e6
	ld c, $08 ; $62e9
	call CopyMemoryFast ; $62eb
	xor a ; $62ee
.beginFadeOut:
	ld c, $20 ; $62ef
	call BeginFadeOut ; $62f1
	call WaitFadeEnd ; $62f4
	ret ; $62f7
Unused_1b_RunDebugSaveDataFlow:
	sound BGM_MENU ; $62f8
	ld a, $01 ; $62fa
	cp $ff ; $62fc
	jr z, Unused_1b_RunDebugSaveDataFlow ; $62fe
	or a ; $6300
	jr z, .loop ; $6301
	bit 7, a ; $6303
	jr z, Unused_1b_RunDebugSaveDataFlow ; $6305
	and $3f ; $6307
	ld [wCurrentStorySlot], a ; $6309
	ld hl, wStorySlotData ; $630c
	ld b, a ; $630f
	ld [wCurrentStorySlot], a ; $6310
	farcall CheckStorySlot ; $6313
	or a ; $6316
	jp z, .clearFrameTasks ; $6317
	call RunNewGameSetup ; $631a
	cp $ff ; $631d
	jp z, Unused_1b_RunDebugSaveDataFlow ; $631f
	ld a, $01 ; $6322
	farcall EraseStorySlotSaveData ; $6324
	farcall SaveStorySlotWithTimer ; $6327
	jp .loop2 ; $632a
.loop:
	sound BGM_MENU ; $632d
	call Unused_1b_RunDebugSaveDataMenu ; $632f
	cp $ff ; $6332
	jr z, Unused_1b_RunDebugSaveDataFlow ; $6334
	cp $01 ; $6336
	jp z, .eq01 ; $6338
	cp $ff ; $633b
	jr z, .loop ; $633d
	or a ; $633f
	jr nz, .nonZero ; $6340
	or a ; $6342
	jr nz, .loop ; $6343
	farcall ReinitSaveRamPreservingBlock6 ; $6345
	ld b, $01 ; $6348
	jr .loop ; $634a
.nonZero:
	and $3f ; $634c
	ld b, a ; $634e
	ld hl, wPlayer1MainName ; $634f
	ld [wCurrentStorySlot], a ; $6352
	farcall CheckStorySlot ; $6355
	or a ; $6358
	jr z, .zero ; $6359
	sound SFX_MENU_CANCEL ; $635b
	jr .loop ; $635d
.zero:
	push bc ; $635f
	call StubNop_1b_09 ; $6360
	pop bc ; $6363
	or a ; $6364
	jr nz, .loop ; $6365
	wram_bank WRAM_SCREEN ; $6367
	ld hl, wPlayer1MainName ; $636d
	ld de, wShadowAttrmap + 8 * TILEMAP_WIDTH ; $6370
	ld c, $0b ; $6373
.loopB:
	ld a, [hl+] ; $6375
	push hl ; $6376
	ld h, d ; $6377
	ld l, e ; $6378
	ld [hl+], a ; $6379
	ld d, h ; $637a
	ld e, l ; $637b
	pop hl ; $637c
	dec c ; $637d
	jr nz, .loopB ; $637e
	ld a, b ; $6380
	ld [wCurrentStorySlot], a ; $6381
	ld a, $00 ; $6384
	farcall EraseStorySlotSaveData ; $6386
	ld b, $01 ; $6389
	jp .loop ; $638b
.eq01:
	ld a, $00 ; $638e
	ld [wUnlockDebugSelection], a ; $6390
	farcall Unused_1b_RunMinigameFlagsDebugScreen ; $6393
	jp .loop ; $6396
.clearFrameTasks:
	call ClearFrameTasks ; $6399
	farcall ValidateN64TransferRecord ; $639c
	or a ; $639f
	jr z, .showNoN64DataFoundScreen ; $63a0
	ld hl, wPendingExpStory ; $63a2
	ld a, [hl+] ; $63a5
	ld d, [hl] ; $63a6
	ld e, a ; $63a7
	or d ; $63a8
	jr z, .step4 ; $63a9
	push_wram_bank WRAM_SCENE ; $63ab
	xor a ; $63b4
	ld [$d000], a ; $63b5
	pop_wram_bank ; $63b8
	ld h, $01 ; $63bd
	ld l, $00 ; $63bf
	ld a, $01 ; $63c1
	farcall ShowExpGainScreen ; $63c3
	ld c, $00 ; $63c6
	farcall CharDataScreen_Show ; $63c8
.step4:
	ld hl, wPendingExpTrophy ; $63cb
	ld a, [hl+] ; $63ce
	ld d, [hl] ; $63cf
	ld e, a ; $63d0
	or d ; $63d1
	jr z, .step5 ; $63d2
	push_wram_bank WRAM_SCENE ; $63d4
	xor a ; $63dd
	ld [$d000], a ; $63de
	pop_wram_bank ; $63e1
	ld h, $01 ; $63e6
	ld l, $01 ; $63e8
	ld a, $01 ; $63ea
	farcall ShowExpGainScreen ; $63ec
	ld c, $01 ; $63ef
	farcall CharDataScreen_Show ; $63f1
.step5:
	xor a ; $63f4
	ld hl, wPendingExpStory ; $63f5
	ld [hl+], a ; $63f8
	ld [hl+], a ; $63f9
	ld [hl+], a ; $63fa
	ld [hl+], a ; $63fb
	ld [hl+], a ; $63fc
	inc hl ; $63fd
	inc hl ; $63fe
	ld [hl+], a ; $63ff
	farcall SaveStorySlotWithTimer ; $6400
	jr .loop2 ; $6403
.showNoN64DataFoundScreen:
	farcall ShowNoN64DataFoundScreen ; $6405
.loop2:
	call RunLevelUpStatusTrophiesMenu ; $6408
	cp $ff ; $640b
	jp z, Unused_1b_RunDebugSaveDataFlow ; $640d
	cp $01 ; $6410
	jr z, .showCharDataScreen ; $6412
	cp $02 ; $6414
	jr z, .showTrophiesPlaceholderScreen ; $6416
	push af ; $6418
	push bc ; $6419
	push de ; $641a
	push hl ; $641b
	farcall ClearPendingExpAwards ; $641c
	ld b, $00 ; $641f
	ld c, $00 ; $6421
	ld de, $0040 ; $6423
	farcall SetPendingExpAward ; $6426
	ld b, $04 ; $6429
	ld c, $01 ; $642b
	ld de, $0077 ; $642d
	farcall SetPendingExpAward ; $6430
	ld c, $01 ; $6433
	farcall ShowMatchResultsScreen ; $6435
	farcall RunExpDistributionFlow ; $6438
	pop hl ; $643b
	pop de ; $643c
	pop bc ; $643d
	pop af ; $643e
	set_flag FLAG_CHAR_DATA_START_EXITS ; $643f
	ld c, $00 ; $6442
	farcall CharDataScreen_Show ; $6444
	clear_flag FLAG_CHAR_DATA_START_EXITS ; $6447
	set_flag FLAG_CHAR_DATA_START_EXITS ; $644a
	ld c, $01 ; $644d
	farcall CharDataScreen_Show ; $644f
	clear_flag FLAG_CHAR_DATA_START_EXITS ; $6452
	farcall SaveStorySlotWithTimer ; $6455
	jr .loop2 ; $6458
.showCharDataScreen:
	farcall ShowCharDataScreen ; $645a
	jp .loop2 ; $645d
.showTrophiesPlaceholderScreen:
	call ShowTrophiesPlaceholderScreen ; $6460
	jp .loop2 ; $6463
	ret ; $6466
