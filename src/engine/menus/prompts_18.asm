Unused_18_InitPlayerRecordForCharacter:
	push af ; $463b
	ld d, a ; $463c
	ldh a, [hPlayerInputFlags] ; $463d
	bit PADB_SELECT, a ; $463f
	jr z, .fromTemplate ; $4641
	ldh a, [hDebugStepMode] ; $4643
	or a ; $4645
	jr z, .fromTemplate ; $4646
	ld a, b ; $4648
	farcall Unused_02_LoadMainCharacterFromRoster ; $4649
	jr .storeRecord ; $464c
.fromTemplate:
	ld a, b ; $464e
	farcall InitPlayerRecordFromTemplate ; $464f
.storeRecord:
	pop af ; $4652
	add a ; $4653
	add $c0 ; $4654
	ld l, a ; $4656
	adc $c7 ; $4657
	sub l ; $4659
	ld h, a ; $465a
	ld d, h ; $465b
	ld e, l ; $465c
	push af ; $465d
	ld hl, wStoryModeNameOfMainCharacter ; $465e
	ld a, [wStoryCharacterSlot] ; $4661
	or a ; $4664
	jr z, .partnerSlot ; $4665
	ld l, $40 ; $4667
.partnerSlot:
	pop af ; $4669
	ld b, h ; $466a
	ld c, l ; $466b
	ld a, [de] ; $466c
	inc de ; $466d
	ld hl, $000e ; $466e
	add hl, bc ; $4671
	ld [hl], a ; $4672
	ld a, [de] ; $4673
	ld hl, $000c ; $4674
	add hl, bc ; $4677
	ld [hl], a ; $4678
	ret ; $4679
ConfirmScreenGfx0:
	INCBIN "data/bank_018/lz_ConfirmScreenGfx0.bin" ; $467a, 2233 bytes
ConfirmScreenPalette0:
	INCLUDE "data/bank_018/ConfirmScreenPalette0.asm" ; $4f33, 64 bytes (palettes)
ConfirmScreenGfx1:
	INCBIN "data/bank_018/lz_ConfirmScreenGfx1.bin" ; $4f73, 347 bytes
ConfirmScreenGfx2:
	INCBIN "data/bank_018/lz_ConfirmScreenGfx2.bin" ; $50ce, 138 bytes
ThreeOptionLabelsData0:
	INCBIN "data/bank_018/ThreeOptionLabelsData0.bin" ; $5158, 16 bytes
ThreeOptionLabelsData1:
	INCBIN "data/bank_018/ThreeOptionLabelsData1.bin" ; $5168, 16 bytes
ThreeOptionLabelsData2:
	INCBIN "data/bank_018/ThreeOptionLabelsData2.bin" ; $5178, 16 bytes
ThreeOptionLabelsData3:
	INCBIN "data/bank_018/ThreeOptionLabelsData3.bin" ; $5188, 16 bytes
ThreeOptionLabelsData4:
	INCBIN "data/bank_018/ThreeOptionLabelsData4.bin" ; $5198, 16 bytes
ThreeOptionLabelsData5:
	INCBIN "data/bank_018/ThreeOptionLabelsData5.bin" ; $51a8, 16 bytes
YesNoLabels0:
	; $51b8, 16 bytes (bytes:16)
	db $8b, $8b, $dd, $de, $df, $8b, $8b, $bd, $be, $bf, $8b, $8b, $ff, $ff, $ff, $ff ; 0x00
YesNoLabels1:
	; $51c8, 16 bytes (bytes:16)
	db $8b, $8b, $ed, $ee, $ef, $8b, $8b, $cd, $ce, $cf, $8b, $8b, $ff, $ff, $ff, $ff ; 0x00
YesNoLabels2:
	; $51d8, 16 bytes (bytes:16)
	db $08, $08, $0e, $0e, $0e, $08, $08, $0e, $0e, $0e, $08, $08, $09, $09, $09, $09 ; 0x00
YesNoLabels3:
	; $51e8, 16 bytes (bytes:16)
	db $08, $08, $0e, $0e, $0e, $08, $08, $0e, $0e, $0e, $08, $08, $09, $09, $09, $09 ; 0x00
ConfirmScreenGfx3:
	INCBIN "data/bank_018/lz_ConfirmScreenGfx3.bin" ; $51f8, 206 bytes
	INCLUDE "data/bank_018/lz_ConfirmScreenGfx3.inc" ; DEF ConfirmScreenGfx3_SIZE EQU its decoded length, generated from the .bin by make
ConfirmScreenPalette1:
	INCLUDE "data/bank_018/ConfirmScreenPalette1.asm" ; $52c6, 24 bytes (palettes)
Unused_18_InitConfirmScreen:
	call ClearFrameTasks ; $52de
	call ClearSpriteQueue ; $52e1
	call Unused_18_ClearTileVramBothBanks ; $52e4
	call Unused_18_LoadScorePanelValue ; $52e7
	xor a ; $52ea
	ld [wScorePanelBobActive], a ; $52eb
	ld [wScorePanelBobStep], a ; $52ee
	ld hl, ConfirmScreenGfx0 ; $52f1
	ld de, wDecompBuffer ; $52f4
	call DecompressData ; $52f7
	ld hl, wDecompBuffer ; $52fa
	ld de, vTiles2 + VRAM_BANK1 ; $52fd
	ld c, $80 ; $5300 -- 128 of ConfirmScreenGfx0's 256 tiles
	call QueueVRAMCopy ; $5302
	ld hl, wTextTileBuffer ; $5305
	ld de, vTiles1 + VRAM_BANK1 ; $5308
	ld c, $80 ; $530b
	call QueueVRAMCopy ; $530d
	ld hl, ConfirmScreenPalette0 ; $5310
	ld_bg_pals de, 0, 8 ; $5313
	call LoadPaletteShadow ; $5316
	ld hl, ConfirmScreenGfx2 ; $5319
	ld de, wTextTileBuffer + 64 * TILE_SIZE ; $531c
	call DecompressData ; $531f
	ld hl, ConfirmScreenGfx1 ; $5322
	ld de, wTextTileBuffer ; $5325
	call DecompressData ; $5328
	call Unused_18_LoadFontTiles ; $532b
	call Unused_18_DrawConfirmScreenBox ; $532e
	ld hl, ConfirmScreenGfx3 ; $5331
	ld de, wDecompBuffer ; $5334
	call DecompressData ; $5337
	ld hl, wDecompBuffer ; $533a
	ld de, vTiles0 + $30 * TILE_SIZE ; $533d
	ld c, ConfirmScreenGfx3_SIZE / 16 ; $5340
	call QueueVRAMCopy ; $5342
	ld hl, ConfirmScreenPalette1 ; $5345
	ld_obj_pals de, 1, 3 ; $5348
	call LoadPaletteShadow ; $534b
	ld hl, vTiles0 + $50 * TILE_SIZE ; $534e
	ld de, $0e01 ; $5351
	call LoadMenuHandCursorGfx ; $5354
	call Unused_18_LoadConfirmScreenSpriteGfx ; $5357
	call Unused_18_SetupScoreboardDisplay ; $535a
	ld hl, wMinigameHighScoreMode ; $535d
	ld b, [hl] ; $5360
	call Unused_18_StubNop_18_1 ; $5361
	ret ; $5364
Unused_18_DrawConfirmScreenBox:
	ld hl, wTextTileBuffer + 26 * TILE_SIZE ; $5365
	ld de, wTextTileBuffer + 90 * TILE_SIZE ; $5368
	ld bc, $0e05 ; $536b
	call Unused_18_DrawBox ; $536e
	ret ; $5371
Unused_18_LoadScorePanelValue:
	ld a, [wStoryMainCharExpTier] ; $5372
	ld [wScorePanelExpTier], a ; $5375
	ret ; $5378
Unused_18_StubNop_18_1:
	ret ; $5379
Unused_18_SetupScoreboardDisplay:
	ld a, [wScorePanelValues] ; $537a
	call Unused_18_GetTextSlotPointer ; $537d
	ld de, wTextTileBuffer + 4 * TILE_SIZE + 11 ; $5380
	call Unused_18_DrawTileBlock6x2ToTilemap ; $5383
	ld a, [wScorePanelValues + 1] ; $5386
	call Unused_18_GetTextSlotPointer ; $5389
	ld de, wTextTileBuffer + 8 * TILE_SIZE + 11 ; $538c
	call Unused_18_DrawTileBlock6x2ToTilemap ; $538f
	ld a, [wScorePanelValues + 2] ; $5392
	call Unused_18_GetTextSlotPointer ; $5395
	ld de, wTextTileBuffer + 12 * TILE_SIZE + 11 ; $5398
	call Unused_18_DrawTileBlock6x2ToTilemap ; $539b
	ld a, [wTargetZoneX1] ; $539e
	call Unused_18_GetTextSlotPointer ; $53a1
	ld de, wTextTileBuffer + 16 * TILE_SIZE + 11 ; $53a4
	call Unused_18_DrawTileBlock6x2ToTilemap ; $53a7
	ld a, $0a ; $53aa
	ld hl, Unused_18_DrawScoreNumbersTask ; $53ac
	call RegisterFrameTask ; $53af
	ret ; $53b2
Unused_18_DrawScoreNumbersTask:
	ld a, [wScorePanelExpTier] ; $53b3
	ld h, $00 ; $53b6
	ld l, a ; $53b8
	ld de, $4404 ; $53b9
	ld b, $03 ; $53bc
	ld a, $02 ; $53be
	call Unused_18_DrawDecimalNumberSprites ; $53c0
	ld a, [wScorePanelBobStep] ; $53c3
	cp $03 ; $53c6
	jr nz, .draw ; $53c8
	ld a, $01 ; $53ca
	ld [wScorePanelBobActive], a ; $53cc
.draw:
	ld hl, wScorePanelScore ; $53cf
	ld a, [hl+] ; $53d2
	ld h, [hl] ; $53d3
	ld l, a ; $53d4
	ld de, $4454 ; $53d5
	ld b, $01 ; $53d8
	ld a, $03 ; $53da
	call Unused_18_DrawDecimalNumberSprites ; $53dc
	xor a ; $53df
	ld [wScorePanelBobActive], a ; $53e0
	ret ; $53e3
Unused_18_GetTextSlotPointer:
	add $04 ; $53e4
	and $0f ; $53e6
	add a ; $53e8
	ld_hl_indexed TextSlotPointerTable ; $53e9
	ld a, [hl+] ; $53f0
	ld h, [hl] ; $53f1
	ld l, a ; $53f2
	ld de, wTextTileBuffer ; $53f3
	add hl, de ; $53f6
	ret ; $53f7
TextSlotPointerTable:
	; $53f8, 32 bytes (records:2)
	dw $0016 ; record 0
	dw $0056 ; record 1
	dw $0096 ; record 2
	dw $00d6 ; record 3
	dw $0116 ; record 4
	dw $0156 ; record 5
	dw $0196 ; record 6
	dw $01d6 ; record 7
	dw $0216 ; record 8
	dw $0016 ; record 9
	dw $0016 ; record 10
	dw $0016 ; record 11
	dw $0016 ; record 12
	dw $0016 ; record 13
	dw $0016 ; record 14
	dw $0016 ; record 15
Unused_18_ForceFlushBgMapToVram:
	ld a, $ff ; $5418
	ld [wBgMapShadowDirty], a ; $541a
	call Unused_18_FlushBgMapShadowToVram ; $541d
	ret ; $5420
Unused_18_RunTwoOptionSelect:
	ldh a, [hInputRisingEdge] ; $5421
	and PADF_LEFT ; $5423
	jr z, .inputLoop ; $5425
	ld b, $00 ; $5427
	sound SFX_MENU_MOVE ; $5429
.inputLoop:
	ldh a, [hInputRisingEdge] ; $542b
	and PADF_RIGHT ; $542d
	jr z, .checkUp ; $542f
	ld b, $01 ; $5431
	sound SFX_MENU_MOVE ; $5433
.checkUp:
	ldh a, [hInputRisingEdge] ; $5435
	and PADF_A ; $5437
	jr nz, .confirm ; $5439
	ldh a, [hInputRisingEdge] ; $543b
	and PADF_B ; $543d
	jr z, .checkDown ; $543f
	ld b, $ff ; $5441
	jr .confirm ; $5443
.checkDown:
	ld de, $128e ; $5445
	ld a, b ; $5448
	and a ; $5449
	jr z, .redraw ; $544a
	ld de, $3a8e ; $544c
.redraw:
	call Unused_18_AddBobbingOffsetXY ; $544f
	push bc ; $5452
	ld_oam bc, 6, $50 ; $5453
	call QueueSprite16 ; $5456
	pop bc ; $5459
	call AdvanceFrame ; $545a
	jr Unused_18_RunTwoOptionSelect ; $545d
.confirm:
	ld a, b ; $545f
	and a ; $5460
	jr z, .done ; $5461
	sound SFX_MENU_CANCEL ; $5463
	ret ; $5465
.done:
	sound SFX_MENU_SELECT ; $5466
	ret ; $5468
Unused_18_RunTwoOptionSelectB:
	ldh a, [hInputRisingEdge] ; $5469
	and PADF_LEFT ; $546b
	jr z, .inputLoop ; $546d
	ld b, $00 ; $546f
	sound SFX_MENU_MOVE ; $5471
.inputLoop:
	ldh a, [hInputRisingEdge] ; $5473
	and PADF_RIGHT ; $5475
	jr z, .checkUp ; $5477
	ld b, $01 ; $5479
	sound SFX_MENU_MOVE ; $547b
.checkUp:
	ldh a, [hInputRisingEdge] ; $547d
	and PADF_A ; $547f
	jr nz, .confirm ; $5481
	ldh a, [hInputRisingEdge] ; $5483
	and PADF_B ; $5485
	jr z, .checkDown ; $5487
	ld b, $ff ; $5489
	jr .confirm ; $548b
.checkDown:
	ld de, $2892 ; $548d
	ld a, b ; $5490
	and a ; $5491
	jr z, .redraw ; $5492
	ld de, TwoOptionSelectBTable ; $5494
.redraw:
	call Unused_18_AddBobbingOffsetXY ; $5497
	push bc ; $549a
	ld_oam bc, 6, $50 ; $549b
	call QueueSprite16 ; $549e
	pop bc ; $54a1
	call AdvanceFrame ; $54a2
	jr Unused_18_RunTwoOptionSelectB ; $54a5
.confirm:
	ld a, b ; $54a7
	and a ; $54a8
	jr z, .done ; $54a9
	sound SFX_MENU_CANCEL ; $54ab
	ret ; $54ad
.done:
	sound SFX_MENU_SELECT ; $54ae
	ret ; $54b0
Unused_18_DrawDecimalNumberSprites:
	push af ; $54b1
	push bc ; $54b2
	push hl ; $54b3
	add sp, -10 ; $54b4
	push bc ; $54b6
	push de ; $54b7
	ld c, l ; $54b8
	ld b, h ; $54b9
	ld hl, sp + 4 ; $54ba
	ld e, l ; $54bc
	ld d, h ; $54bd
	ld l, c ; $54be
	ld h, b ; $54bf
	ld c, e ; $54c0
	ld b, d ; $54c1
	call FormatDecimalNumber ; $54c2
	ld l, c ; $54c5
	ld h, b ; $54c6
	pop de ; $54c7
	pop bc ; $54c8
	call Unused_18_DrawStringSprites ; $54c9
	add sp, 10 ; $54cc
	pop hl ; $54ce
	pop bc ; $54cf
	pop af ; $54d0
	ret ; $54d1
Unused_18_DrawStringSprites:
	ld a, [hl+] ; $54d2
	and a ; $54d3
	jr z, .done ; $54d4
	call Unused_18_DrawGlyphSprite ; $54d6
	jr Unused_18_DrawStringSprites ; $54d9
.done:
	ret ; $54db
Unused_18_DrawGlyphSprite:
	sub $30 ; $54dc
	jr c, .advance ; $54de
	push de ; $54e0
	push hl ; $54e1
	add a ; $54e2
	add $30 ; $54e3
	ld c, a ; $54e5
	ld a, [wScorePanelBobActive] ; $54e6
	and a ; $54e9
	jr z, .queue ; $54ea
	ld a, d ; $54ec
	ld hl, hVBlankCounter ; $54ed
	sub [hl] ; $54f0
	and $1f ; $54f1
	ld_hl_indexed UnusedBobRamp_18 ; $54f3
	ld a, [hl] ; $54fa
	add e ; $54fb
	ld e, a ; $54fc
.queue:
	call QueueSprite ; $54fd
	pop hl ; $5500
	pop de ; $5501
.advance:
	ld a, d ; $5502
	add $08 ; $5503
	ld d, a ; $5505
	ret ; $5506
UnusedBobRamp_18:
	INCBIN "data/bank_018/UnusedBobRamp_18.bin" ; $5507, 32 bytes
Unused_18_DrawThreeOptionLabels:
	call Unused_18_DrawConfirmScreenBox ; $5527
	ld hl, ThreeOptionLabelsData3 ; $552a
	ld de, $ddc1 ; $552d
	call Unused_18_CopyBytes11 ; $5530
	ld hl, ThreeOptionLabelsData4 ; $5533
	ld de, $dde1 ; $5536
	call Unused_18_CopyBytes11 ; $5539
	ld hl, ThreeOptionLabelsData5 ; $553c
	ld de, $de01 ; $553f
	call Unused_18_CopyBytes11 ; $5542
	ld hl, ThreeOptionLabelsData0 ; $5545
	ld de, $d9c1 ; $5548
	call Unused_18_CopyBytes11 ; $554b
	ld hl, ThreeOptionLabelsData1 ; $554e
	ld de, $d9e1 ; $5551
	call Unused_18_CopyBytes11 ; $5554
	ld hl, ThreeOptionLabelsData2 ; $5557
	ld de, $da01 ; $555a
	call Unused_18_CopyBytes11 ; $555d
	ret ; $5560
Unused_18_DrawYesNoLabels:
	ld hl, YesNoLabels2 ; $5561
	ld de, $dde1 ; $5564
	call Unused_18_CopyBytes11 ; $5567
	ld hl, YesNoLabels3 ; $556a
	ld de, $de01 ; $556d
	call Unused_18_CopyBytes11 ; $5570
	ld hl, YesNoLabels0 ; $5573
	ld de, $d9e1 ; $5576
	call Unused_18_CopyBytes11 ; $5579
	ld hl, YesNoLabels1 ; $557c
	ld de, $da01 ; $557f
	call Unused_18_CopyBytes11 ; $5582
	ret ; $5585
Unused_18_DrawTileBlock6x2ToTilemap:
	ld a, [hl+] ; $5586
	ld [de], a ; $5587
	inc de ; $5588
	ld a, [hl+] ; $5589
	ld [de], a ; $558a
	inc de ; $558b
	ld a, [hl+] ; $558c
	ld [de], a ; $558d
	inc de ; $558e
	ld a, [hl+] ; $558f
	ld [de], a ; $5590
	inc de ; $5591
	ld a, [hl+] ; $5592
	ld [de], a ; $5593
	inc de ; $5594
	ld a, [hl+] ; $5595
	ld [de], a ; $5596
	inc de ; $5597
	ld a, $1a ; $5598
	add l ; $559a
	ld l, a ; $559b
	jr nc, .gotSource ; $559c
	inc h ; $559e
.gotSource:
	ld a, $1a ; $559f
	add e ; $55a1
	ld e, a ; $55a2
	jr nc, .copyRows ; $55a3
	inc d ; $55a5
.copyRows:
	ld a, [hl+] ; $55a6
	ld [de], a ; $55a7
	inc de ; $55a8
	ld a, [hl+] ; $55a9
	ld [de], a ; $55aa
	inc de ; $55ab
	ld a, [hl+] ; $55ac
	ld [de], a ; $55ad
	inc de ; $55ae
	ld a, [hl+] ; $55af
	ld [de], a ; $55b0
	inc de ; $55b1
	ld a, [hl+] ; $55b2
	ld [de], a ; $55b3
	inc de ; $55b4
	ld a, [hl+] ; $55b5
	ld [de], a ; $55b6
	inc de ; $55b7
	ret ; $55b8
