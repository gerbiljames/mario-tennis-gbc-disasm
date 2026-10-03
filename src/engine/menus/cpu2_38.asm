RunCpuDifficultySubmenu:
	push_wram_bank WRAM_SCREEN ; $6216
	ld a, [wCpuDifficultyPanelOpen] ; $621f
	or a ; $6222
	jr nz, .inputLoop ; $6223
	call OpenCpuDifficultyPanel ; $6225
	call QueueCpuDifficultyPanelToVram ; $6228
	ld a, $01 ; $622b
	ld [wCpuDifficultyPanelOpen], a ; $622d
.inputLoop:
	call HandleCpuDifficultyInput ; $6230
	call DrawCpuDifficultyCursorBox ; $6233
	ld a, [wMenuInputPressed] ; $6236
	bit PADB_A, a ; $6239
	jr nz, .confirm ; $623b
	bit 1, a ; $623d
	jr nz, .cancel ; $623f
	jr .done ; $6241
.cancel:
	call CloseCpuDifficultyPanel ; $6243
	sound SFX_MENU_CANCEL ; $6246
	wram_bank WRAM_SCREEN ; $6248
	ld hl, wCharSelectSlotDifficulty ; $624e
	ld a, [wCharSelectSlot] ; $6251
	add l ; $6254
	ld l, a ; $6255
	jr nc, .clearDifficulty ; $6256
	inc h ; $6258
.clearDifficulty:
	xor a ; $6259
	ld [hl], a ; $625a
	ld hl, wCharSelectSlotLeftHanded ; $625b
	ld a, [wCharSelectSlot] ; $625e
	add l ; $6261
	ld l, a ; $6262
	jr nc, .clearTaken ; $6263
	inc h ; $6265
.clearTaken:
	xor a ; $6266
	ld [hl], a ; $6267
	ld hl, wCharSelectSlotChars ; $6268
	ld a, [wCharSelectSlot] ; $626b
	add l ; $626e
	ld l, a ; $626f
	jr nc, .readSlotChar ; $6270
	inc h ; $6272
.readSlotChar:
	ld a, [hl] ; $6273
	ld b, $00 ; $6274
	ld [hl], b ; $6276
	ld hl, wCharGridEntries ; $6277
	add a ; $627a
	add a ; $627b
	add l ; $627c
	ld l, a ; $627d
	jr nc, .clearGridEntry ; $627e
	inc h ; $6280
.clearGridEntry:
	inc hl ; $6281
	inc hl ; $6282
	xor a ; $6283
	ld [hl], a ; $6284
	call ClearPlayerSlotPortrait ; $6285
	call BuildVisiblePageSpriteList ; $6288
	jr .advanceSlot ; $628b
.confirm:
	sound SFX_MENU_SELECT ; $628d
	call CloseCpuDifficultyPanel ; $628f
	ld hl, wCharSelectSlotDifficulty ; $6292
	ld a, [wCharSelectSlot] ; $6295
	add l ; $6298
	ld l, a ; $6299
	jr nc, .storeDifficulty ; $629a
	inc h ; $629c
.storeDifficulty:
	ld a, [wCpuDifficultyCursor] ; $629d
	inc a ; $62a0
	ld [hl], a ; $62a1
	call GetGridSlotFromCursor ; $62a2
	call DrawPlayerSlotPortrait ; $62a5
	call AdvanceToNextPlayerSlot ; $62a8
	cp $ff ; $62ab
	jr nz, .advanceSlot ; $62ad
	ld a, $01 ; $62af
	ld [wCharSelectExitCode], a ; $62b1
.advanceSlot:
	call DrawCharGridSlotPrompt ; $62b4
	ld hl, wShadowTilemap + 2 * TILEMAP_WIDTH ; $62b7
	ld de, vBGMap0 + 2 * TILEMAP_WIDTH ; $62ba
	ld c, 2 * TILEMAP_WIDTH / 16 ; $62bd
	call QueueVRAMCopy ; $62bf
.done:
	pop_wram_bank ; $62c2
	ret ; $62c7
CloseCpuDifficultyPanel:
	xor a ; $62c8
	ld [wCpuDifficultyPanelOpen], a ; $62c9
	ld [wCpuDifficultyPrompt], a ; $62cc
	ld hl, wShadowTilemap + 22 * TILEMAP_WIDTH ; $62cf
	ld de, wShadowTilemap + 14 * TILEMAP_WIDTH ; $62d2
	rect_size $14, $04 ; $62d5
	farcall CopyTilemapRect ; $62d9
	ld hl, wShadowAttrmap + 22 * TILEMAP_WIDTH ; $62dc
	ld de, wShadowAttrmap + 14 * TILEMAP_WIDTH ; $62df
	rect_size $14, $04 ; $62e2
	farcall CopyTilemapRect ; $62e6
	ld de, wShadowAttrmap + 14 * TILEMAP_WIDTH + 1 ; $62e9
	rect_size $12, $03 ; $62ec
	ld h, $00 ; $62f0
	farcall FillTilemapRect ; $62f2
	call RefreshCharInfoPanel ; $62f5
	ld hl, wShadowTilemap + 17 * TILEMAP_WIDTH ; $62f8
	ld de, vBGMap0 + 17 * TILEMAP_WIDTH ; $62fb
	ld c, TILEMAP_WIDTH / 16 ; $62fe
	call QueueVRAMCopy ; $6300
	ld hl, wShadowAttrmap + 14 * TILEMAP_WIDTH ; $6303
	ld de, vBGMap0 + 14 * TILEMAP_WIDTH + VRAM_BANK1 ; $6306
	ld c, 4 * TILEMAP_WIDTH / 16 ; $6309
	call QueueVRAMCopy ; $630b
	ret ; $630e
HandleCpuDifficultyInput:
	ld a, [wMenuInputPressed] ; $630f
	bit PADB_LEFT, a ; $6312
	jr nz, .decrease ; $6314
	bit 4, a ; $6316
	jr nz, .increase ; $6318
	ret ; $631a
.decrease:
	sound SFX_MENU_MOVE ; $631b
	ld a, [wCpuDifficultyCursor] ; $631d
	dec a ; $6320
	jr .wrap ; $6321
.increase:
	sound SFX_MENU_MOVE ; $6323
	ld a, [wCpuDifficultyCursor] ; $6325
	inc a ; $6328
.wrap:
	add a ; $6329
	jr nc, .checkMax ; $632a
	ld a, $04 ; $632c
	dec a ; $632e
	jr .store ; $632f
.checkMax:
	rra ; $6331
	cp $04 ; $6332
	jr c, .store ; $6334
	xor a ; $6336
.store:
	ld [wCpuDifficultyCursor], a ; $6337
	ret ; $633a
DrawCpuDifficultyCursorBox:
	ld a, [wCpuDifficultyCursor] ; $633b
	add a ; $633e
	ld hl, CpuDifficultyCursorBoxTable0 ; $633f
	add l ; $6342
	ld l, a ; $6343
	jr nc, .read ; $6344
	inc h ; $6346
.read:
	ld a, [hl+] ; $6347
	ld d, [hl] ; $6348
	ld e, a ; $6349
	ld a, [wCpuDifficultyCursor] ; $634a
	add a ; $634d
	ld hl, CpuDifficultyCursorBoxTable1 ; $634e
	add l ; $6351
	ld l, a ; $6352
	jr nc, .readB ; $6353
	inc h ; $6355
.readB:
	ld a, [hl+] ; $6356
	ld b, [hl] ; $6357
	ld c, a ; $6358
	call DrawSelectedOptionBox ; $6359
	ret ; $635c
CpuDifficultyCursorBoxTable0:
	; $635d, 8 bytes (bytes:8)
	db $80, $04, $80, $28, $80, $56, $80, $76 ; 0x00
CpuDifficultyCursorBoxTable1:
	; $6365, 8 bytes (bytes:8)
	db $04, $20, $04, $2a, $04, $1c, $04, $27 ; 0x00
OpenCpuDifficultyPanel:
	push_wram_bank WRAM_SCREEN ; $636d
	ld hl, wShadowTilemap + 18 * TILEMAP_WIDTH ; $6376
	ld de, wShadowTilemap + 14 * TILEMAP_WIDTH ; $6379
	rect_size $14, $04 ; $637c
	farcall CopyTilemapRect ; $6380
	ld hl, wShadowAttrmap + 18 * TILEMAP_WIDTH ; $6383
	ld de, wShadowAttrmap + 14 * TILEMAP_WIDTH ; $6386
	rect_size $14, $04 ; $6389
	farcall CopyTilemapRect ; $638d
	pop_wram_bank ; $6390
	ret ; $6395
QueueCpuDifficultyPanelToVram:
	push_wram_bank WRAM_SCREEN ; $6396
	ld hl, wShadowTilemap + 14 * TILEMAP_WIDTH ; $639f
	ld de, vBGMap0 + 14 * TILEMAP_WIDTH ; $63a2
	ld c, 4 * TILEMAP_WIDTH / 16 ; $63a5
	call QueueVRAMCopy ; $63a7
	ld hl, wShadowAttrmap + 14 * TILEMAP_WIDTH ; $63aa
	ld de, vBGMap0 + 14 * TILEMAP_WIDTH + VRAM_BANK1 ; $63ad
	ld c, 4 * TILEMAP_WIDTH / 16 ; $63b0
	call QueueVRAMCopy ; $63b2
	pop_wram_bank ; $63b5
	ret ; $63ba
	ret ; $63bb
	ret ; $63bc
RunLinkCharSelectScreen:
	xor a ; $63bd
	ldh [hLinkExchangeActive], a ; $63be
	ldh [hUnusedLinkSelectByte], a ; $63c0
	ld [wMenuCursor2X], a ; $63c2
	ld [wMenuCursor2Y], a ; $63c5
	ldh [hLinkCursorPage], a ; $63c8
	call ResetSerialState ; $63ca
	call EnableTimerInterrupt ; $63cd
	sound BGM_MENU ; $63d0
	wram_bank WRAM_SCREEN ; $63d2
	ld a, $02 ; $63d8
	ld [wCharGridHandedness], a ; $63da
	ld a, [wMatchIsDoubles] ; $63dd
	or a ; $63e0
	jr nz, .doubles ; $63e1
	ldh a, [hLinkState] ; $63e3
	cp LINKSTATE_MASTER ; $63e5
	jr nz, .singlesSlave ; $63e7
	ld a, CHARSELECTMODE_LINK_SINGLES_P1 ; $63e9
	jr .storeMode ; $63eb
.singlesSlave:
	ld a, CHARSELECTMODE_LINK_SINGLES_P2 ; $63ed
	jr .storeMode ; $63ef
.doubles:
	ldh a, [hLinkState] ; $63f1
	cp LINKSTATE_MASTER ; $63f3
	jr nz, .doublesSlave ; $63f5
	ld a, CHARSELECTMODE_LINK_DOUBLES_P1 ; $63f7
	jr .storeMode ; $63f9
.doublesSlave:
	ld a, CHARSELECTMODE_LINK_DOUBLES_P2 ; $63fb
.storeMode:
	ld [wCharSelectMode], a ; $63fd
	call DisableLCDSafely ; $6400
	farcall LoadMenuFontGfx ; $6403
	xor a ; $6406
	ld [wCharSelectRemoteSlot], a ; $6407
	ld a, $ff ; $640a
	ld [wLinkSelectSlotState], a ; $640c
	ld a, [wMatchIsDoubles] ; $640f
	ld b, a ; $6412
	ld a, [wMatchTypeNumberOfSets] ; $6413
	ld c, a ; $6416
	ld a, [wMatchTypeNumberOfGames] ; $6417
	push af ; $641a
	push bc ; $641b
	call SetupCharGridScreen ; $641c
	pop bc ; $641f
	pop af ; $6420
	ld [wMatchTypeNumberOfGames], a ; $6421
	ld a, b ; $6424
	ld [wMatchIsDoubles], a ; $6425
	ld a, c ; $6428
	ld [wMatchTypeNumberOfSets], a ; $6429
	call EnableLCD ; $642c
	farcall ResyncLinkSession ; $642f
	script_fade_in $10 ; $6432
	push af ; $6437
	farcall RunLinkCommandFrame ; $6438
	pop af ; $643b
	push af ; $643c
	farcall RunLinkCommandFrame ; $643d
	pop af ; $6440
	xor a ; $6441
	ldh [hLinkPlayerCount], a ; $6442
	call InitCharGridState ; $6444
	xor a ; $6447
	ldh [hUnusedLinkSelectByte], a ; $6448
	ld [wMenuCursor2X], a ; $644a
	ld [wMenuCursor2Y], a ; $644d
	ldh [hLinkCursorPage], a ; $6450
	xor a ; $6452
	ldh [hLinkRemoteInputBuf], a ; $6453
	ldh [hLinkRemoteInput], a ; $6455
	ld [wLinkSelectCmdResult], a ; $6457
	ld [wLinkSelectStartupFrames], a ; $645a
	ld a, $01 ; $645d
	ld hl, TickMenuBgScrollTask_38 ; $645f
	call RegisterFrameTask ; $6462
	wram_bank WRAM_SCREEN ; $6465
	call RefreshCharInfoPanel ; $646b
.frameLoop:
	push af ; $646e
	farcall RunLinkCommandFrame ; $646f
	pop af ; $6472
	ldh a, [hLinkRemoteInputBuf] ; $6473
	ld [wMenuInputPressed], a ; $6475
	ld a, [wMenuInputPressed] ; $6478
	xor $0f ; $647b
	jr nz, .afterStartup ; $647d
	call JumpSoftReset ; $647f
.afterStartup:
	call WaitLinkSelectStartupFrames ; $6482
	or a ; $6485
	jr z, .frameLoop ; $6486
	ld b, $03 ; $6488
	ld c, $02 ; $648a
	call HandleCharGridDpad ; $648c
	call HandleLinkGridButtons ; $648f
	call ProcessLinkSelectCommand ; $6492
	push_wram_bank WRAM_SCREEN ; $6495
	call CheckLinkSelectionComplete ; $649e
	ld a, [wCharSelectSlot] ; $64a1
	cp $04 ; $64a4
	jr z, .waitBanner ; $64a6
	call DrawCharGridCursorBox ; $64a8
	call DrawCharGridCharSprites ; $64ab
	call DrawCharGridScrollArrows ; $64ae
	jr .refresh ; $64b1
.waitBanner:
	call DrawCharGridWaitBanner ; $64b3
.refresh:
	ld a, [wCharSelectExitCode] ; $64b6
	ld b, a ; $64b9
	pop_wram_bank ; $64ba
	ld a, b ; $64bf
	cp $01 ; $64c0
	jr z, .checkDone ; $64c2
	cp $02 ; $64c4
	jr z, .done ; $64c6
	jp .frameLoop ; $64c8
.checkDone:
	call ClearFrameTasks ; $64cb
	call ProcessLinkSelectCommand ; $64ce
	sound SFX_MENU_SELECT ; $64d1
	push af ; $64d3
	farcall SyncLinkFrame ; $64d4
	pop af ; $64d7
	xor a ; $64d8
	ldh [hLinkExchangeActive], a ; $64d9
	call ResetSerialState ; $64db
	call EnableTimerInterrupt ; $64de
	call ResolveSelectedCharIds ; $64e1
	call InitLinkMatchCharsFromSelection ; $64e4
	call ApplyHandednessToCharRecords ; $64e7
	call ApplyCpuDifficultyToCharRecords ; $64ea
	ldh a, [hLinkState] ; $64ed
	cp LINKSTATE_MASTER ; $64ef
	jr nz, .finish ; $64f1
	call WaitVBlank ; $64f3
.finish:
	ld c, $08 ; $64f6
	call BeginFadeOut ; $64f8
	call WaitFadeEnd ; $64fb
	ld hl, rIE ; $64fe
	set 2, [hl] ; $6501
	xor a ; $6503
	ret ; $6504
.done:
	call ClearFrameTasks ; $6505
	sound SFX_MENU_CANCEL ; $6508
	push af ; $650a
	farcall SyncLinkFrame ; $650b
	pop af ; $650e
	xor a ; $650f
	ldh [hLinkExchangeActive], a ; $6510
	call ResetSerialState ; $6512
	ld c, $10 ; $6515
	call BeginFadeOut ; $6517
	call WaitFadeEnd ; $651a
	call ClearFrameTasks ; $651d
	ld hl, rIE ; $6520
	set 2, [hl] ; $6523
	ld a, $ff ; $6525
	ret ; $6527
ProcessLinkSelectCommand:
	ldh a, [hLinkRemoteInput] ; $6528
	cp $20 ; $652a
	jr nz, .cmd21 ; $652c
	call JumpSoftReset ; $652e
	jp .done ; $6531
.cmd21:
	cp $21 ; $6534
	jr nz, .cmd23 ; $6536
	ld a, [wCharSelectRemoteSlot] ; $6538
	cp $02 ; $653b
	jp z, .done ; $653d
	ld a, [wLinkSelectCmdChar] ; $6540
	cp $22 ; $6543
	jp z, .done ; $6545
	ld c, a ; $6548
	call ApplyRemoteCharSelection ; $6549
	jp .done ; $654c
.cmd23:
	cp $23 ; $654f
	jr nz, .cmd28 ; $6551
	call ApplyRemoteCharCancel ; $6553
	jp .done ; $6556
.cmd28:
	cp $28 ; $6559
	jr nz, .cmd29 ; $655b
	ld a, [wCharSelectRemoteSlot] ; $655d
	cp $02 ; $6560
	jp z, .done ; $6562
	ld a, [wLinkSelectCmdChar] ; $6565
	cp $22 ; $6568
	jp z, .done ; $656a
	ld a, [wLinkSelectCmdChar] ; $656d
	ld c, a ; $6570
	call IsMarioCastCharacter ; $6571
	or a ; $6574
	jr z, .applySelection ; $6575
	ld a, [wCharSelectMode] ; $6577
	cp CHARSELECTMODE_LINK_SINGLES_P2 ; $657a
	jr z, .markOwnSlot ; $657c
	cp CHARSELECTMODE_LINK_DOUBLES_P2 ; $657e
	jr z, .markOwnSlot ; $6580
	ld a, [wCharSelectRemoteSlot] ; $6582
	ld hl, wCharSelectSlotLeftHanded + 2 ; $6585
	add l ; $6588
	ld l, a ; $6589
	jr nc, .markSlotTaken ; $658a
	inc h ; $658c
.markSlotTaken:
	ld [hl], $01 ; $658d
	jr .applySelection ; $658f
.markOwnSlot:
	ld a, [wCharSelectRemoteSlot] ; $6591
	ld hl, wCharSelectSlotLeftHanded ; $6594
	add l ; $6597
	ld l, a ; $6598
	jr nc, .markOwnSlotTaken ; $6599
	inc h ; $659b
.markOwnSlotTaken:
	ld [hl], $01 ; $659c
.applySelection:
	ld a, [wLinkSelectCmdChar] ; $659e
	ld c, a ; $65a1
	call ApplyRemoteCharSelection ; $65a2
	jr .done ; $65a5
.cmd29:
	cp $29 ; $65a7
	jr nz, .cmd24 ; $65a9
	jr .done ; $65ab
.cmd24:
	cp $24 ; $65ad
	jr nz, .cmd25 ; $65af
	ld c, $01 ; $65b1
	call StoreRemoteCpuDifficulty ; $65b3
	ld a, [wCharSelectRemoteChars + 1] ; $65b6
	ld c, a ; $65b9
	call DrawRemoteSlotPortrait ; $65ba
	xor a ; $65bd
	ld [wLinkSelectCmdResult], a ; $65be
	jr .done ; $65c1
.cmd25:
	cp $25 ; $65c3
	jr nz, .cmd26 ; $65c5
	ld c, $02 ; $65c7
	call StoreRemoteCpuDifficulty ; $65c9
	ld a, [wCharSelectRemoteChars + 1] ; $65cc
	ld c, a ; $65cf
	call DrawRemoteSlotPortrait ; $65d0
	xor a ; $65d3
	ld [wLinkSelectCmdResult], a ; $65d4
	jr .done ; $65d7
.cmd26:
	cp $26 ; $65d9
	jr nz, .cmd27 ; $65db
	ld c, $03 ; $65dd
	call StoreRemoteCpuDifficulty ; $65df
	ld a, [wCharSelectRemoteChars + 1] ; $65e2
	ld c, a ; $65e5
	call DrawRemoteSlotPortrait ; $65e6
	xor a ; $65e9
	ld [wLinkSelectCmdResult], a ; $65ea
	jr .done ; $65ed
.cmd27:
	cp $27 ; $65ef
	jr nz, .unknownCmd ; $65f1
	ld c, $04 ; $65f3
	call StoreRemoteCpuDifficulty ; $65f5
	ld a, [wCharSelectRemoteChars + 1] ; $65f8
	ld c, a ; $65fb
	call DrawRemoteSlotPortrait ; $65fc
	xor a ; $65ff
	ld [wLinkSelectCmdResult], a ; $6600
	jr .done ; $6603
.unknownCmd:
	ld [wLinkSelectCmdChar], a ; $6605
.done:
	ret ; $6608
