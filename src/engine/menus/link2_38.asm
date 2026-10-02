DrawEnteredName:
	push_wram_bank WRAM_SCREEN ; $728f
	ld a, $20 ; $7298
	ld hl, wShadowTilemap + 6 * TILEMAP_WIDTH + 7 ; $729a
	ld [hl+], a ; $729d
	ld [hl+], a ; $729e
	ld [hl+], a ; $729f
	ld [hl+], a ; $72a0
	ld [hl+], a ; $72a1
	ld [hl+], a ; $72a2
	ld [hl+], a ; $72a3
	ld hl, wNameEntryBuffer ; $72a4
	ld de, wShadowTilemap + 6 * TILEMAP_WIDTH + 7 ; $72a7
	call DrawNameWithDiacritics_38 ; $72aa
	pop_wram_bank ; $72ad
	ret ; $72b2
AppendCharToName:
	push_wram_bank WRAM_SCREEN ; $72b3
	ld hl, wNameEntryBuffer ; $72bc
.findEnd:
	ld a, [hl] ; $72bf
	cp $00 ; $72c0
	jr z, .lookupChar ; $72c2
	inc hl ; $72c4
	jr .findEnd ; $72c5
.lookupChar:
	push hl ; $72c7
	ld c, $0f ; $72c8
	call GetMenuCursorIndex_38 ; $72ca
	ld d, a ; $72cd
	ld hl, NameEntryCharset_38 ; $72ce
	wram_bank WRAM_COURT_PLANES ; $72d1
	ld a, [wScreenAttrmap] ; $72d7
	or a ; $72da
	jr z, .indexCharset ; $72db
	ld hl, NameEntryCharset_38 ; $72dd
.indexCharset:
	ld a, d ; $72e0
	add l ; $72e1
	ld l, a ; $72e2
	jr nc, .checkMark ; $72e3
	inc h ; $72e5
.checkMark:
	ld d, [hl] ; $72e6
	ld a, d ; $72e7
	cp $9e ; $72e8
	jr z, .plainChar ; $72ea
	cp $9f ; $72ec
	jr z, .plainChar ; $72ee
	jr .store ; $72f0
.plainChar:
	add $40 ; $72f2
	ld d, a ; $72f4
.store:
	pop hl ; $72f5
	wram_bank WRAM_SCREEN ; $72f6
	call IsNameBufferFull ; $72fc
	or a ; $72ff
	jr z, .queueVram ; $7300
	dec hl ; $7302
	ld a, [hl] ; $7303
	cp $de ; $7304
	jr z, .redraw ; $7306
	cp $df ; $7308
	jr z, .redraw ; $730a
	jr .queueVram ; $730c
.redraw:
	ld [hl], $00 ; $730e
	dec hl ; $7310
.queueVram:
	ld [hl], d ; $7311
	call DrawEnteredName ; $7312
	ld hl, wShadowTilemap + 5 * TILEMAP_WIDTH ; $7315
	ld de, vBGMap0 + 5 * TILEMAP_WIDTH ; $7318
	ld c, $04 ; $731b
	call QueueVRAMCopy ; $731d
	sound SFX_MENU_SELECT ; $7320
	call GetEnteredNameLength ; $7322
	cp $07 ; $7325
	jr nz, .done ; $7327
	ld a, $05 ; $7329
	ld [wMenuCursorY], a ; $732b
	ld a, $0a ; $732e
	ld [wMenuCursorX], a ; $7330
.done:
	pop_wram_bank ; $7333
	ret ; $7338
	ld [hl], $00 ; $7339
	pop_wram_bank ; $733b
	ret ; $7340
DeleteLastNameChar:
	ldh a, [hWramBank] ; $7341
	push af ; $7343
	call GetEnteredNameLength ; $7344
	and a ; $7347
	jr z, .done ; $7348
	wram_bank WRAM_SCREEN ; $734a
	ld hl, wNameEntryBuffer ; $7350
.findEnd:
	ld a, [hl+] ; $7353
	cp $00 ; $7354
	jr nz, .findEnd ; $7356
	dec hl ; $7358
.deleteChar:
	dec hl ; $7359
	ld a, [hl] ; $735a
	ld [hl], $00 ; $735b
	cp $de ; $735d
	jr z, .deleteChar ; $735f
	cp $df ; $7361
	jr z, .deleteChar ; $7363
	call DrawEnteredName ; $7365
	ld hl, wShadowTilemap + 5 * TILEMAP_WIDTH ; $7368
	ld de, vBGMap0 + 5 * TILEMAP_WIDTH ; $736b
	ld c, $04 ; $736e
	call QueueVRAMCopy ; $7370
.done:
	pop_wram_bank ; $7373
	ret ; $7378
IsNameBufferFull:
	call GetEnteredNameLength ; $7379
	cp $07 ; $737c
	jr c, .notFull ; $737e
	ld a, $ff ; $7380
	ret ; $7382
.notFull:
	xor a ; $7383
	ret ; $7384
DrawNameEntryUnderlineSprites:
	ld c, $00 ; $7385
	ld de, $3c38 ; $7387
	call GetEnteredNameLength ; $738a
	ld b, a ; $738d
.cellLoop:
	push bc ; $738e
	ld a, b ; $738f
	cp c ; $7390
	jr nz, .drawCursor ; $7391
	ldh a, [hVBlankCounter] ; $7393
	and $10 ; $7395
	jr z, .next ; $7397
.drawCursor:
	ld c, $10 ; $7399
	ld b, OAM_BANK1 | 2 ; $739b
	push de ; $739d
	call QueueSprite ; $739e
	pop de ; $73a1
.next:
	pop bc ; $73a2
	ld a, $08 ; $73a3
	add d ; $73a5
	ld d, a ; $73a6
	inc c ; $73a7
	ld a, c ; $73a8
	cp $07 ; $73a9
	jr nz, .cellLoop ; $73ab
	ret ; $73ad
TrimTrailingSpacesFromName:
	push_wram_bank WRAM_SCREEN ; $73ae
	ld hl, wNameEntryBuffer + 10 ; $73b7
.scanLoop:
	ld a, [hl] ; $73ba
	cp $20 ; $73bb
	jr nz, .checkEnd ; $73bd
	xor a ; $73bf
	ld [hl-], a ; $73c0
	jr .scanLoop ; $73c1
.checkEnd:
	or a ; $73c3
	jr nz, .done ; $73c4
	dec hl ; $73c6
	jr .scanLoop ; $73c7
.done:
	pop_wram_bank ; $73c9
	ret ; $73ce
GetEnteredNameLength:
	push bc ; $73cf
	push hl ; $73d0
	push_wram_bank WRAM_SCREEN ; $73d1
	ld hl, wNameEntryBuffer ; $73da
	ld c, $00 ; $73dd
.charLoop:
	ld a, [hl+] ; $73df
	cp $00 ; $73e0
	jr z, .done ; $73e2
	cp $de ; $73e4
	jr z, .charLoop ; $73e6
	cp $df ; $73e8
	jr z, .charLoop ; $73ea
	inc c ; $73ec
	jr .charLoop ; $73ed
.done:
	ld a, c ; $73ef
	ld b, a ; $73f0
	pop_wram_bank ; $73f1
	ld a, b ; $73f6
	pop hl ; $73f7
	pop bc ; $73f8
	ret ; $73f9
GetActiveStoryNameBuffer:
	ld a, [wStoryCharacterSlot] ; $73fa
	or a ; $73fd
	jr nz, .partner ; $73fe
	ld bc, wStoryModeNameOfMainCharacter ; $7400
	ret ; $7403
.partner:
	ld bc, wStoryModeNameOfPartnerCharacter ; $7404
	ret ; $7407
RunLinkMatchSequence:
	push bc ; $7408
	push de ; $7409
	push hl ; $740a
.waitReady:
	farcall RunLinkMatchRulesMenu ; $740b
	cp $ff ; $740e
	jp z, .done ; $7410
	ld c, $10 ; $7413
	call BeginFadeOut ; $7415
	call WaitFadeEnd ; $7418
.startMatch:
	push_wram_bank WRAM_SCREEN ; $741b
	ld hl, wCharGridEntries ; $7424
	ld bc, wCharGridEntries_SIZE ; $7427
	call ClearBytes ; $742a
	call BuildCharUnlockFlags ; $742d
	call PackUnlockFlagsForLink ; $7430
	call ExchangeLinkUnlockFlags ; $7433
	call MergeLinkUnlockFlags ; $7436
	call UnpackUnlockFlagsFromLink ; $7439
	pop_wram_bank ; $743c
	call ApplyMatchTypeSettingsLink ; $7441
	farcall RunLinkCharSelectScreen ; $7444
	push af ; $7447
	ld a, GAMEMODE_LINK_MATCH ; $7448
	ld [wGameMode], a ; $744a
	call StoreLinkMatchCharInfo ; $744d
	pop af ; $7450
	cp $ff ; $7451
	jr nz, .afterMatch ; $7453
	farcall RestoreMenuScreenAndFadeIn ; $7455
	ld a, MENUSLIDE_BACK ; $7458
	ld [wMenuSlideDirection], a ; $745a
	jr .waitReady ; $745d
.afterMatch:
	farcall ComputeUnlockedCourtFlags ; $745f
	ld c, $00 ; $7462
	call ExchangeLinkCharSelection ; $7464
	call DisableLCDSafely ; $7467
	farcall LoadMenuFontGfx ; $746a
	farcall ResetScreenAndTextWindows ; $746d
	farcall LoadCourtSelectGraphics ; $7470
	call EnableLCD ; $7473
	script_fade_in $10 ; $7476
	xor a ; $747b
	ldh [hLinkExchangeActive], a ; $747c
	call ResetSerialState ; $747e
	ld a, MENUSLIDE_FORWARD ; $7481
	ld [wMenuSlideDirection], a ; $7483
	call ApplyMatchTypeSettingsLink ; $7486
	ld a, [wUnlockedCourtMask] ; $7489
	ld d, a ; $748c
	ld a, [wLinkPartnerCourtMask] ; $748d
	or d ; $7490
	jr nz, .rematch ; $7491
	farcall RunLinkCourtSelect4Menu ; $7493
	cp $ff ; $7496
	jr z, .startMatch ; $7498
	jr .exchangeResult ; $749a
.rematch:
	farcall RunLinkCourtSelect9Menu ; $749c
	cp $ff ; $749f
	jp z, .startMatch ; $74a1
.exchangeResult:
	ld d, a ; $74a4
	ld a, d ; $74a5
	ld [wCurrentlyUsedCourt], a ; $74a6
	ld c, $10 ; $74a9
	call BeginFadeOut ; $74ab
	call WaitFadeEnd ; $74ae
	ld a, CHAR_NINA ; $74b1
	ld [wMatchPlayerChar], a ; $74b3
	ld [wMatchOpponentChar], a ; $74b6
	ld a, [wMatchIsDoubles] ; $74b9
	or a ; $74bc
	jr z, .cleanup ; $74bd
	ld c, $40 ; $74bf
	call ExchangeLinkCharSelection ; $74c1
.cleanup:
	call ClearFrameTasks ; $74c4
	xor a ; $74c7
	ldh [hLinkExchangeActive], a ; $74c8
	call ResetSerialState ; $74ca
	call EnableTimerInterrupt ; $74cd
	ld a, $01 ; $74d0
	ld [wLinkSessionActive], a ; $74d2
	farcall RunMatch ; $74d5
	ld a, $01 ; $74d8
.done:
	push af ; $74da
	call InitSerialLink ; $74db
	pop af ; $74de
	pop hl ; $74df
	pop de ; $74e0
	pop bc ; $74e1
	ret ; $74e2
ApplyMatchTypeSettingsLink:
	ld hl, MatchTypeSettingsLinkTable0 ; $74e3
	ld a, [wMatchFormatSets] ; $74e6
	add l ; $74e9
	ld l, a ; $74ea
	jr nc, .readSets ; $74eb
	inc h ; $74ed
.readSets:
	ld a, [hl] ; $74ee
	ld [wMatchTypeNumberOfSets], a ; $74ef
	ld hl, MatchTypeSettingsLinkTable1 ; $74f2
	ld a, [wMatchFormatGames] ; $74f5
	add l ; $74f8
	ld l, a ; $74f9
	jr nc, .readGames ; $74fa
	inc h ; $74fc
.readGames:
	ld a, [hl] ; $74fd
	ld [wMatchTypeNumberOfGames], a ; $74fe
	ld a, [wMatchFormatDoubles] ; $7501
	ld [wMatchIsDoubles], a ; $7504
	or a ; $7507
	jr z, .singles ; $7508
	ld a, $04 ; $750a
	ld [wOnCourtCharCount], a ; $750c
	set_flag FLAG_DOUBLES ; $750f
	jr .done ; $7512
.singles:
	ld a, $02 ; $7514
	ld [wOnCourtCharCount], a ; $7516
	clear_flag FLAG_DOUBLES ; $7519
.done:
	ret ; $751c
MatchTypeSettingsLinkTable0:
	; $751d, 3 bytes (bytes:3)
	db $01, $03, $05 ; 0x00
MatchTypeSettingsLinkTable1:
	; $7520, 2 bytes (bytes:2)
	db $02, $06 ; 0x00
ExchangeLinkCharSelection:
	push bc ; $7522
	call ClearFrameTasks ; $7523
	xor a ; $7526
	ldh [hLinkExchangeActive], a ; $7527
	call ResetSerialState ; $7529
	sound SFX_STOP ; $752c
	sound BGM_NONE ; $752e
	farcall ResyncLinkSession ; $7530
	push af ; $7533
	farcall RunLinkInputFrame ; $7534
	pop af ; $7537
	push af ; $7538
	farcall RunLinkInputFrame ; $7539
	pop af ; $753c
	xor a ; $753d
	ldh [hLinkExchangeActive], a ; $753e
	call ResetSerialState ; $7540
	ldh a, [hLinkState] ; $7543
	cp LINKSTATE_MASTER ; $7545
	jr nz, .checkTag ; $7547
	call WaitVBlank ; $7549
.checkTag:
	pop bc ; $754c
	push bc ; $754d
	ld a, c ; $754e
	or a ; $754f
	jr z, .pickBuffers ; $7550
	cp $40 ; $7552
	jr z, .pickBuffers ; $7554
	call LinkErrorReset ; $7556
.pickBuffers:
	ldh a, [hLinkState] ; $7559
	cp LINKSTATE_SLAVE ; $755b
	jr z, .asSlave ; $755d
	cp LINKSTATE_MASTER ; $755f
	jr z, .asMaster ; $7561
	call LinkErrorReset ; $7563
.asMaster:
	ld hl, wPlayer2CurrentMainCharacter ; $7566
	ld de, wPlayer1CurrentMainCharacter ; $7569
	jr .checkCancel ; $756c
.asSlave:
	ld hl, wPlayer1CurrentMainCharacter ; $756e
	ld de, wPlayer2CurrentMainCharacter ; $7571
.checkCancel:
	ld a, c ; $7574
	or a ; $7575
	jr nz, .sendSelection ; $7576
	dec hl ; $7578
	dec de ; $7579
	push af ; $757a
	push bc ; $757b
	push de ; $757c
	push hl ; $757d
	push de ; $757e
	push af ; $757f
	ld a, [wPlayer1CurrentMainCharacter] ; $7580
	ld_cell de, $0a, $01 ; $7583
	call PrintHexByte ; $7586
	pop af ; $7589
	pop de ; $758a
	push de ; $758b
	push af ; $758c
	ld a, [wPlayer2CurrentMainCharacter] ; $758d
	ld_cell de, $0a, $02 ; $7590
	call PrintHexByte ; $7593
	pop af ; $7596
	pop de ; $7597
	pop hl ; $7598
	pop de ; $7599
	pop bc ; $759a
	pop af ; $759b
	ld a, [wUnlockedCourtMask] ; $759c
	ld [de], a ; $759f
	ld b, $26 ; $75a0
	jr .storeCommand ; $75a2
.sendSelection:
	push af ; $75a4
	push bc ; $75a5
	push de ; $75a6
	push hl ; $75a7
	push de ; $75a8
	push af ; $75a9
	ld a, [wPlayer1CurrentPartnerCharacter] ; $75aa
	ld_cell de, $0a, $03 ; $75ad
	call PrintHexByte ; $75b0
	pop af ; $75b3
	pop de ; $75b4
	push de ; $75b5
	push af ; $75b6
	ld a, [wPlayer2CurrentPartnerCharacter] ; $75b7
	ld_cell de, $0a, $04 ; $75ba
	call PrintHexByte ; $75bd
	pop af ; $75c0
	pop de ; $75c1
	pop hl ; $75c2
	pop de ; $75c3
	pop bc ; $75c4
	pop af ; $75c5
	ld b, $25 ; $75c6
.storeCommand:
	ld a, c ; $75c8
	add l ; $75c9
	ld l, a ; $75ca
	jr nc, .writeSlot ; $75cb
	inc h ; $75cd
.writeSlot:
	ld a, c ; $75ce
	add e ; $75cf
	ld e, a ; $75d0
	jr nc, .send ; $75d1
	inc d ; $75d3
.send:
	push bc ; $75d4
	ld c, b ; $75d5
	farcall ExchangeLinkDataBlock ; $75d6
	pop bc ; $75d9
	ld a, b ; $75da
	cp $26 ; $75db
	jr nz, .done ; $75dd
	ldh a, [hLinkState] ; $75df
	cp LINKSTATE_SLAVE ; $75e1
	jr z, .replyOk ; $75e3
	cp LINKSTATE_MASTER ; $75e5
	jr z, .checkReply ; $75e7
	call LinkErrorReset ; $75e9
.checkReply:
	ld a, [wPlayer2MainLinkCourtMask] ; $75ec
	ld [wLinkPartnerCourtMask], a ; $75ef
	jr .retry ; $75f2
.replyOk:
	ld a, [wPlayer1MainLinkCourtMask] ; $75f4
	ld [wLinkPartnerCourtMask], a ; $75f7
.retry:
	xor a ; $75fa
	ld [wPlayer1MainLinkCourtMask], a ; $75fb
	ld [wPlayer2MainLinkCourtMask], a ; $75fe
.done:
	pop bc ; $7601
	ret ; $7602
ExchangeLinkUnlockFlags:
	push af ; $7603
	push bc ; $7604
	push de ; $7605
	push hl ; $7606
	call ClearFrameTasks ; $7607
	xor a ; $760a
	ldh [hLinkExchangeActive], a ; $760b
	call ResetSerialState ; $760d
	sound SFX_STOP ; $7610
	sound BGM_NONE ; $7612
	farcall ResyncLinkSession ; $7614
	push af ; $7617
	farcall RunLinkInputFrame ; $7618
	pop af ; $761b
	push af ; $761c
	farcall RunLinkInputFrame ; $761d
	pop af ; $7620
	xor a ; $7621
	ldh [hLinkExchangeActive], a ; $7622
	call ResetSerialState ; $7624
	ldh a, [hLinkState] ; $7627
	cp LINKSTATE_MASTER ; $7629
	jr nz, .send ; $762b
	call WaitVBlank ; $762d
.send:
	ld hl, wLinkUnlockFlagsRecv ; $7630
	ld de, wLinkUnlockFlagsSend ; $7633
	ld c, $04 ; $7636
	farcall ExchangeLinkDataBlock ; $7638
	xor a ; $763b
	ldh [hLinkExchangeActive], a ; $763c
	call ResetSerialState ; $763e
	pop hl ; $7641
	pop de ; $7642
	pop bc ; $7643
	pop af ; $7644
	ret ; $7645
StoreLinkMatchCharInfo:
	push af ; $7646
	push_wram_bank WRAM_SCREEN ; $7647
	ld hl, wCharSelectSlotChars ; $7650
	ld de, wMatchSlotCharRefs ; $7653
	ld a, [hl+] ; $7656
	ld [de], a ; $7657
	inc de ; $7658
	ld a, [hl+] ; $7659
	ld [de], a ; $765a
	inc de ; $765b
	ld a, [hl+] ; $765c
	ld [de], a ; $765d
	inc de ; $765e
	ld a, [hl+] ; $765f
	ld [de], a ; $7660
	ldh a, [hLinkState] ; $7661
	ld [wLinkMatchRole], a ; $7663
	ld a, [wMatchSlotCharRefs + 2] ; $7666
	bit 7, a ; $7669
	jr z, .restore ; $766b
	and $07 ; $766d
	ld h, $00 ; $766f
	ld l, a ; $7671
	add hl, hl ; $7672
	add hl, hl ; $7673
	add hl, hl ; $7674
	add hl, hl ; $7675
	add hl, hl ; $7676
	ld de, wCreatedCharRecords + 2 ; $7677
	add hl, de ; $767a
	ld a, [hl] ; $767b
	ld [wLinkMatchCharLevel], a ; $767c
.restore:
	pop_wram_bank ; $767f
	pop af ; $7684
	ret ; $7685
PackUnlockFlagsForLink:
	ld hl, wLinkUnlockFlagsSend ; $7686
	ld bc, wLinkUnlockFlagsSend_SIZE ; $7689
	call ClearBytes ; $768c
	ld hl, wLinkUnlockFlagsRecv ; $768f
	ld bc, wLinkUnlockFlagsRecv_SIZE ; $7692
	call ClearBytes ; $7695
	ld c, $00 ; $7698
	ld b, $01 ; $769a
	ld hl, wCharUnlockFlags ; $769c
	ld d, $00 ; $769f
.charLoop:
	ld a, [hl+] ; $76a1
	or a ; $76a2
	jr z, .nextChar ; $76a3
	ld a, b ; $76a5
	or d ; $76a6
	ld d, a ; $76a7
.nextChar:
	sla b ; $76a8
	inc c ; $76aa
	ld a, c ; $76ab
	cp $08 ; $76ac
	jr nz, .charLoop ; $76ae
	ld hl, wLinkUnlockFlagsSend ; $76b0
	ld [hl], d ; $76b3
	ld hl, wCharUnlockFlags + 8 ; $76b4
	ld a, [hl] ; $76b7
	or a ; $76b8
	jr z, .storeCharFlags ; $76b9
	ld a, $01 ; $76bb
.storeCharFlags:
	ld hl, wLinkUnlockFlagsSend + 1 ; $76bd
	ld [hl], a ; $76c0
	ld c, $00 ; $76c1
	ld b, $01 ; $76c3
	ld hl, wCharUnlockFlags + 15 ; $76c5
	ld d, $00 ; $76c8
.courtLoop:
	ld a, [hl+] ; $76ca
	or a ; $76cb
	jr z, .nextCourt ; $76cc
	ld a, b ; $76ce
	or d ; $76cf
	ld d, a ; $76d0
.nextCourt:
	sla b ; $76d1
	inc c ; $76d3
	ld a, c ; $76d4
	cp $08 ; $76d5
	jr nz, .courtLoop ; $76d7
	ld hl, wLinkUnlockFlagsSend + 2 ; $76d9
	ld [hl], d ; $76dc
	ld c, $00 ; $76dd
	ld b, $01 ; $76df
	ld hl, wCharUnlockFlags + 23 ; $76e1
	ld d, $00 ; $76e4
.itemLoop:
	ld a, [hl+] ; $76e6
	or a ; $76e7
	jr z, .nextItem ; $76e8
	ld a, b ; $76ea
	or d ; $76eb
	ld d, a ; $76ec
.nextItem:
	sla b ; $76ed
	inc c ; $76ef
	ld a, c ; $76f0
	cp $08 ; $76f1
	jr nz, .itemLoop ; $76f3
	ld hl, wLinkUnlockFlagsSend + 3 ; $76f5
	ld [hl], d ; $76f8
	ret ; $76f9
UnpackUnlockFlagsFromLink:
	ld hl, wCharUnlockFlags ; $76fa
	ld bc, wCharUnlockFlags_SIZE ; $76fd
	call ClearBytes ; $7700
	ld hl, wLinkUnlockFlagsSend ; $7703
	ld b, $01 ; $7706
	ld c, $00 ; $7708
.charBitLoop:
	ld a, [hl] ; $770a
	and b ; $770b
	jr z, .nextCharBit ; $770c
	push hl ; $770e
	ld hl, wCharUnlockFlags ; $770f
	ld a, c ; $7712
	add l ; $7713
	ld l, a ; $7714
	jr nc, .markChar ; $7715
	inc h ; $7717
.markChar:
	ld a, $01 ; $7718
	ld [hl], a ; $771a
	pop hl ; $771b
.nextCharBit:
	sla b ; $771c
	inc c ; $771e
	ld a, c ; $771f
	cp $08 ; $7720
	jr nz, .charBitLoop ; $7722
	ld a, [wLinkUnlockFlagsSend + 1] ; $7724
	or a ; $7727
	jr z, .courtFlags ; $7728
	ld hl, wCharUnlockFlags + 8 ; $772a
	ld a, $01 ; $772d
	ld [hl], a ; $772f
.courtFlags:
	ld hl, wLinkUnlockFlagsSend + 2 ; $7730
	ld b, $01 ; $7733
	ld c, $00 ; $7735
.courtBitLoop:
	ld a, [hl] ; $7737
	and b ; $7738
	jr z, .nextCourtBit ; $7739
	push hl ; $773b
	ld hl, wCharUnlockFlags + 15 ; $773c
	ld a, c ; $773f
	add l ; $7740
	ld l, a ; $7741
	jr nc, .markCourt ; $7742
	inc h ; $7744
.markCourt:
	ld a, $01 ; $7745
	ld [hl], a ; $7747
	pop hl ; $7748
.nextCourtBit:
	sla b ; $7749
	inc c ; $774b
	ld a, c ; $774c
	cp $08 ; $774d
	jr nz, .courtBitLoop ; $774f
	ld hl, wLinkUnlockFlagsSend + 3 ; $7751
	ld b, $01 ; $7754
	ld c, $00 ; $7756
.itemFlags:
	ld a, [hl] ; $7758
	and b ; $7759
	jr z, .done ; $775a
	push hl ; $775c
	ld hl, wCharUnlockFlags + 23 ; $775d
	ld a, c ; $7760
	add l ; $7761
	ld l, a ; $7762
	jr nc, .markItem ; $7763
	inc h ; $7765
.markItem:
	ld a, $01 ; $7766
	ld [hl], a ; $7768
	pop hl ; $7769
.done:
	sla b ; $776a
	inc c ; $776c
	ld a, c ; $776d
	cp $08 ; $776e
	jr nz, .itemFlags ; $7770
	ret ; $7772
MergeLinkUnlockFlags:
	ld hl, wLinkUnlockFlagsSend ; $7773
	ld de, wLinkUnlockFlagsRecv ; $7776
	ld c, $00 ; $7779
.loop:
	ld a, [hl] ; $777b
	ld b, a ; $777c
	ld a, [de] ; $777d
	inc de ; $777e
	or b ; $777f
	ld [hl+], a ; $7780
	inc c ; $7781
	ld a, c ; $7782
	cp $04 ; $7783
	jr nz, .loop ; $7785
	ret ; $7787
	; $7788, 2168 bytes fill to bank end (linker-padded)
