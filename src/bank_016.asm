SECTION "ROM Bank $16", ROMX[$4000], BANK[$16]

	farptr RunMatchWinLoseScreen ; $4000
	farptr RunMatchStatsScreen ; $4002
	farptr DecompressCharacterPortrait ; $4004
	push de ; $4006
	push bc ; $4007
	ld c, $00 ; $4008
	call ApplySpriteWobbleX_16 ; $400a
	ld c, $00 ; $400d
	call ApplySpriteWobbleY_16 ; $400f
	ld c, $00 ; $4012
	ld b, $08 ; $4014
DrawWobblingCornerBrackets:
	call QueueSprite ; $4016
	pop bc ; $4019
	pop de ; $401a
	push de ; $401b
	push bc ; $401c
	ld a, b ; $401d
	add a, d ; $401e
	ld d, a ; $401f
	push de ; $4020
	ld c, $01 ; $4021
	call ApplySpriteWobbleX_16 ; $4023
	ld c, $00 ; $4026
	call ApplySpriteWobbleY_16 ; $4028
	ld c, $00 ; $402b
	ld b, $28 ; $402d
	call QueueSprite ; $402f
	pop de ; $4032
	pop bc ; $4033
	pop de ; $4034
	push de ; $4035
	push bc ; $4036
	ld a, c ; $4037
	add a, e ; $4038
	ld e, a ; $4039
	ld a, b ; $403a
	add a, d ; $403b
	ld d, a ; $403c
	push de ; $403d
	ld c, $01 ; $403e
	call ApplySpriteWobbleX_16 ; $4040
	ld c, $01 ; $4043
	call ApplySpriteWobbleY_16 ; $4045
	ld c, $00 ; $4048
	ld b, $68 ; $404a
	call QueueSprite ; $404c
	pop de ; $404f
	pop bc ; $4050
	pop de ; $4051
	ld a, e ; $4052
	add a, c ; $4053
	ld e, a ; $4054
	push de ; $4055
	ld c, $00 ; $4056
	call ApplySpriteWobbleX_16 ; $4058
	ld c, $01 ; $405b
	call ApplySpriteWobbleY_16 ; $405d
	ld c, $00 ; $4060
	ld b, $48 ; $4062
	call QueueSprite ; $4064
	pop de ; $4067
	ret ; $4068
ApplySpriteWobbleX_16:
	ldh a, [hVBlankCounter] ; $4069
	and a, $0f ; $406b
	ld hl, $4083 ; $406d
	add a, l ; $4070
	ld l, a ; $4071
	jr nc, Label_16_4075 ; $4072
	inc h ; $4074
Label_16_4075:
	ld a, [hl] ; $4075
	ld b, a ; $4076
	ld a, c ; $4077
	or a, a ; $4078
	jr z, Label_16_407f ; $4079
	ld a, b ; $407b
	add a, d ; $407c
	ld d, a ; $407d
	ret ; $407e
Label_16_407f:
	ld a, d ; $407f
	sub a, b ; $4080
	ld d, a ; $4081
	ret ; $4082
	INCBIN "data/bank_016/d_4083.bin" ; $4083, 16 bytes
ApplySpriteWobbleY_16:
	ldh a, [hVBlankCounter] ; $4093
	and a, $0f ; $4095
	ld hl, $40ad ; $4097
	add a, l ; $409a
	ld l, a ; $409b
	jr nc, Label_16_409f ; $409c
	inc h ; $409e
Label_16_409f:
	ld a, [hl] ; $409f
	ld b, a ; $40a0
	ld a, c ; $40a1
	or a, a ; $40a2
	jr z, Label_16_40a9 ; $40a3
	ld a, b ; $40a5
	add a, e ; $40a6
	ld e, a ; $40a7
	ret ; $40a8
Label_16_40a9:
	ld a, e ; $40a9
	sub a, b ; $40aa
	ld e, a ; $40ab
	ret ; $40ac
	INCBIN "data/bank_016/d_40ad.bin" ; $40ad, 32 bytes
DrawCornerBrackets:
	INCBIN "data/bank_016/d_40cd.bin" ; $40cd, 59 bytes
MoveMenuCursorGrid_17:
	INCBIN "data/bank_016/d_4108.bin" ; $4108, 126 bytes
MoveMenuCursorGridAlt_17:
	INCBIN "data/bank_016/d_4186.bin" ; $4186, 125 bytes
MoveMenuCursorGridLink_17:
	INCBIN "data/bank_016/d_4203.bin" ; $4203, 203 bytes
MoveLinkPartnerCursorGrid_17:
	INCBIN "data/bank_016/d_42ce.bin" ; $42ce, 201 bytes
GetMenuCursorIndex_17:
	INCBIN "data/bank_016/d_4397.bin" ; $4397, 18 bytes
GetCursorIndexFromPair:
	INCBIN "data/bank_016/d_43a9.bin" ; $43a9, 16 bytes
SetMenuCursorFromIndex_17:
	INCBIN "data/bank_016/d_43b9.bin" ; $43b9, 18 bytes
SetCursorPairFromIndex:
	INCBIN "data/bank_016/d_43cb.bin" ; $43cb, 14 bytes
ClearWram3Buffer64:
	INCBIN "data/bank_016/d_43d9.bin" ; $43d9, 29 bytes
UpdateResultScreenAnimatedTilesTask:
	farcall UpdateAnimatedTiles ; $43f6
	ret ; $43f9
	push af ; $43fa
	push bc ; $43fb
Label_16_43fc:
	ld a, [hl] ; $43fc
	cp a, $00 ; $43fd
	jr z, Label_16_4430 ; $43ff
	ld [de], a ; $4401
	inc hl ; $4402
	ld a, [hl] ; $4403
	cp a, $de ; $4404
CourtDiagramBaseTask:
	jr z, Label_16_440c ; $4406
	cp a, $df ; $4408
	jr nz, Label_16_4421 ; $440a
Label_16_440c:
	push hl ; $440c
	push bc ; $440d
	ld h, d ; $440e
	ld l, e ; $440f
	ld bc, $ffe0 ; $4410
	add hl, bc ; $4413
	ld b, a ; $4414
	ld a, [hl] ; $4415
	cp a, $03 ; $4416
	ld a, b ; $4418
	jr nz, Label_16_441d ; $4419
	sub a, $d0 ; $441b
Label_16_441d:
	ld [hl], a ; $441d
	pop bc ; $441e
	pop hl ; $441f
	inc hl ; $4420
Label_16_4421:
	inc de ; $4421
	ld a, e ; $4422
	and a, $1f ; $4423
	jr nz, Label_16_43fc ; $4425
	push hl ; $4427
	ld h, d ; $4428
	ld l, e ; $4429
	add hl, de ; $442a
	ld d, h ; $442b
	ld e, l ; $442c
	pop hl ; $442d
	jr Label_16_43fc ; $442e
Label_16_4430:
	pop bc ; $4430
	pop af ; $4431
	ret ; $4432
	push af ; $4433
	push bc ; $4434
	push hl ; $4435
	add sp, -10 ; $4436
	push bc ; $4438
	push de ; $4439
	ld c, l ; $443a
	ld b, h ; $443b
	ld hl, sp + 4 ; $443c
	ld e, l ; $443e
	ld d, h ; $443f
	ld l, c ; $4440
	ld h, b ; $4441
	ld c, e ; $4442
PrintDecimalNumber:
	ld b, d ; $4443
	call FormatDecimalNumber ; $4444
	ld l, c ; $4447
	ld h, b ; $4448
	pop de ; $4449
	pop bc ; $444a
	call PrintNumberString_16 ; $444b
	add sp, 10 ; $444e
	pop hl ; $4450
	pop bc ; $4451
	pop af ; $4452
	ret ; $4453
PrintNumberString_16:
	ld a, [hl+] ; $4454
	and a, a ; $4455
	jr z, Label_16_445d ; $4456
	call PrintNumberStringChar_16 ; $4458
	jr PrintNumberString_16 ; $445b
Label_16_445d:
	ret ; $445d
PrintNumberStringChar_16:
	push hl ; $445e
	ld hl, $d240 ; $445f
	sub a, $30 ; $4462
	jr c, Label_16_4474 ; $4464
	add a, $30 ; $4466
	ld b, a ; $4468
	wram_bank $03 ; $4469
	ld a, b ; $446f
	ld [de], a ; $4470
	inc de ; $4471
	pop hl ; $4472
	ret ; $4473
Label_16_4474:
	inc de ; $4474
	pop hl ; $4475
	ret ; $4476
RunMatchWinLoseScreen:
	ld a, [wMatchAbortFlag] ; $4477
	bit 7, a ; $447a
	ret nz ; $447c
	call DisableLCDSafely ; $447d
	call ClearFrameTasks ; $4480
	wram_bank $03 ; $4483
	ld a, [wGameMode] ; $4489
	cp a, $04 ; $448c
	jr z, Label_16_4496 ; $448e
	cp a, $09 ; $4490
	jr z, Label_16_4496 ; $4492
	jr Label_16_449a ; $4494
Label_16_4496:
	ld a, $01 ; $4496
	jr Label_16_449b ; $4498
Label_16_449a:
	xor a, a ; $449a
Label_16_449b:
	ld [$d800], a ; $449b
	ld [$d801], a ; $449e
	ld a, [wMatchWinLoseFlag] ; $44a1
	ld [$cb73], a ; $44a4
	call MaybeInvertMatchWinLoseFlag ; $44a7
	ld a, $ff ; $44aa
	ld a, [wMatchWinLoseFlag] ; $44ac
	cp a, $ff ; $44af
	jr z, Label_16_44b7 ; $44b1
	sound $09 ; $44b3
	jr Label_16_44b9 ; $44b5
Label_16_44b7:
	sound $0a ; $44b7
Label_16_44b9:
	call InitMatchWinLoseScreen ; $44b9
	farcall UpdateAnimatedTiles ; $44bc
	ld a, $01 ; $44bf
	ld hl, UpdateResultScreenAnimatedTilesTask ; $44c1
	call RegisterFrameTask ; $44c4
	ld a, $01 ; $44c7
	ld hl, QueueResultScreenSprites ; $44c9
	call RegisterFrameTask ; $44cc
	call EnableLCD ; $44cf
	script_fade_in $10 ; $44d2
	call WaitFadeEnd ; $44d7
	ld a, $08 ; $44da
	ldh [rSTAT], a ; $44dc
	ld hl, rIE ; $44de
	set 1, [hl] ; $44e1
	ld a, $48 ; $44e3
	ld [$cb02], a ; $44e5
	ld a, $57 ; $44e8
	ld [$cb03], a ; $44ea
	xor a, a ; $44ed
	ld [$cb01], a ; $44ee
	ld a, $01 ; $44f1
	ld hl, AdvanceResultScreenTimer ; $44f3
	call RegisterFrameTask ; $44f6
Label_16_44f9:
	call AdvanceFrame ; $44f9
	ld a, [wCurrentMinigameStoryMatch + 1] ; $44fc
	push de ; $44ff
	push af ; $4500
	ld a, a ; $4501
	ld de, $0303 ; $4502
	call PrintDecimalByte ; $4505
	pop af ; $4508
	pop de ; $4509
	ldh a, [hInputPressed] ; $450a
	ld [wMenuInputPressed], a ; $450c
	bit PADB_A, a ; $450f
	jr nz, Label_16_451d ; $4511
	bit 1, a ; $4513
	jr nz, Label_16_451d ; $4515
	bit 4, a ; $4517
	jr nz, Label_16_453b ; $4519
	jr Label_16_44f9 ; $451b
Label_16_451d:
	sound $5f ; $451d
	call ClearFrameTasks ; $451f
	ld c, $40 ; $4522
	call BeginFadeOut ; $4524
	call WaitFadeEnd ; $4527
	ld hl, rIE ; $452a
	res 1, [hl] ; $452d
	ld a, $03 ; $452f
	ld [wAnimatedTilePeriod], a ; $4531
	ld a, [$cb73] ; $4534
	ld [wMatchWinLoseFlag], a ; $4537
	ret ; $453a
Label_16_453b:
	ld c, $40 ; $453b
	call BeginFadeOut ; $453d
	call WaitFadeEnd ; $4540
	ld hl, rIE ; $4543
	res 1, [hl] ; $4546
	call ClearFrameTasks ; $4548
	call RunMatchStatsScreen ; $454b
	push af ; $454e
	ld a, [$cb73] ; $454f
	ld [wMatchWinLoseFlag], a ; $4552
	pop af ; $4555
	cp a, $ff ; $4556
	jp nz, RunMatchWinLoseScreen ; $4558
	call ClearFrameTasks ; $455b
	ld c, $08 ; $455e
	call BeginFadeOut ; $4560
	call WaitFadeEnd ; $4563
	ld hl, rIE ; $4566
	res 1, [hl] ; $4569
	ld a, $03 ; $456b
	ld [wAnimatedTilePeriod], a ; $456d
	ret ; $4570
InitMatchWinLoseScreen:
	call ClearFrameTasks ; $4571
	xor a, a ; $4574
	ldh [hScrollX], a ; $4575
	ldh [hScrollY], a ; $4577
	call LoadWinLoseScreenAssets ; $4579
	wram_bank $03 ; $457c
	ld de, $d560 ; $4582
	ld b, $14 ; $4585
	ld c, $05 ; $4587
	ld h, $0a ; $4589
	farcall FillTilemapRect ; $458b
	ld a, $00 ; $458e
	ld d, $04 ; $4590
	farcall LoadIndexedPalette_18 ; $4592
	ld a, $00 ; $4595
	ld d, $05 ; $4597
	farcall LoadIndexedPalette_18 ; $4599
	ld a, $00 ; $459c
	ld d, $06 ; $459e
	farcall LoadIndexedPalette_18 ; $45a0
	ld a, $00 ; $45a3
	ld d, $07 ; $45a5
	farcall LoadIndexedPalette_18 ; $45a7
	call LoadMatchResultPalettes ; $45aa
	call AdjustResultTilemapForLoss ; $45ad
	call LoadResultScreenTileGraphics ; $45b0
	call SetWinLosePortraitPaletteAttrs ; $45b3
	ld c, $00 ; $45b6
	call LoadResultScreenPortraits ; $45b8
	ldh a, [hWramBank] ; $45bb
	push af ; $45bd
	wram_bank $01 ; $45be
	ld hl, $4608 ; $45c4
	ld de, $d000 ; $45c7
	call DecompressData ; $45ca
	ld hl, $d000 ; $45cd
	ld de, $a000 ; $45d0
	ld c, $20 ; $45d3
	call QueueVRAMCopy ; $45d5
	ld hl, $4784 ; $45d8
	ld de, $d000 ; $45db
	call DecompressData ; $45de
	ld hl, $d000 ; $45e1
	ld de, $a200 ; $45e4
	ld c, $20 ; $45e7
	call QueueVRAMCopy ; $45e9
	ld hl, $48f4 ; $45ec
	ld de, $0803 ; $45ef
	call LoadPaletteShadow ; $45f2
	ld b, $09 ; $45f5
	ld c, $04 ; $45f7
	ld de, $a400 ; $45f9
	farcall LoadCompressedTileBlock ; $45fc
	pop af ; $45ff
	wram_bank ; $4600
	farcall QueueWram3MapToVRAM ; $4604
	ret ; $4607
	INCBIN "data/bank_016/d_4608.bin" ; $4608, 110 bytes
DiagramHighlightPaletteTask:
	INCBIN "data/bank_016/d_4676.bin" ; $4676, 108 bytes
DiagramNearFigureSpriteTask:
	INCBIN "data/bank_016/d_46e2.bin" ; $46e2, 42 bytes
DiagramFarFigureSpriteTask:
	INCBIN "data/bank_016/d_470c.bin" ; $470c, 42 bytes
DiagramMarkerSpriteTask:
	INCBIN "data/bank_016/d_4736.bin" ; $4736, 30 bytes
DiagramBallSpriteTask:
	INCBIN "data/bank_016/d_4754.bin" ; $4754, 58 bytes
DiagramSwingFigureSpriteTask:
	INCBIN "data/bank_016/d_478e.bin" ; $478e, 97 bytes
DiagramPolePairSpriteTask:
	INCBIN "data/bank_016/d_47ef.bin" ; $47ef, 135 bytes
DiagramSpotMarkerSpriteTask:
	INCBIN "data/bank_016/d_4876.bin" ; $4876, 75 bytes
DiagramTargetBracketsSpriteTask:
	INCBIN "data/bank_016/d_48c1.bin" ; $48c1, 75 bytes
LoadWinLoseScreenAssets:
	ld a, [$d800] ; $490c
	or a, a ; $490f
	jr z, Label_16_4919 ; $4910
	ld c, $14 ; $4912
	farcall LoadScreenAssetRecord ; $4914
	jr Label_16_4920 ; $4917
Label_16_4919:
	ld c, $13 ; $4919
	farcall LoadScreenAssetRecord ; $491b
	jr Label_16_4920 ; $491e
Label_16_4920:
	ld de, $002f ; $4920
	call TestGameFlagByNumber ; $4923
	jr nz, Label_16_4962 ; $4926
	wram_bank $03 ; $4928
	ld hl, $d280 ; $492e
	ld de, $d08b ; $4931
	ld b, $09 ; $4934
	ld c, $05 ; $4936
	farcall CopyTilemapRect ; $4938
	ld hl, $d680 ; $493b
	ld de, $d48b ; $493e
	ld b, $09 ; $4941
	ld c, $05 ; $4943
	farcall CopyTilemapRect ; $4945
	ld hl, $d289 ; $4948
	ld de, $d161 ; $494b
	ld b, $08 ; $494e
	ld c, $05 ; $4950
	farcall CopyTilemapRect ; $4952
	ld hl, $d689 ; $4955
	ld de, $d561 ; $4958
	ld b, $08 ; $495b
	ld c, $05 ; $495d
	farcall CopyTilemapRect ; $495f
Label_16_4962:
	ret ; $4962
SetWinLosePortraitPaletteAttrs:
	ld a, [$d801] ; $4963
	or a, a ; $4966
	jr nz, Label_16_49bc ; $4967
	ld de, $002f ; $4969
	call TestGameFlagByNumber ; $496c
	jr z, Label_16_49a3 ; $496f
	ld de, $d48b ; $4971
	ld b, $04 ; $4974
	ld c, $04 ; $4976
	ld h, $0c ; $4978
	farcall FillTilemapRect ; $497a
	ld de, $d48f ; $497d
	ld b, $04 ; $4980
	ld c, $04 ; $4982
	ld h, $0d ; $4984
	farcall FillTilemapRect ; $4986
	ld de, $d582 ; $4989
	ld b, $03 ; $498c
	ld c, $03 ; $498e
	ld h, $0e ; $4990
	farcall FillTilemapRect ; $4992
	ld de, $d585 ; $4995
	ld b, $03 ; $4998
	ld c, $03 ; $499a
	ld h, $0f ; $499c
	farcall FillTilemapRect ; $499e
	jr Label_16_49bb ; $49a1
Label_16_49a3:
	ld de, $d48d ; $49a3
	ld b, $04 ; $49a6
	ld c, $04 ; $49a8
	ld h, $0c ; $49aa
	farcall FillTilemapRect ; $49ac
	ld de, $d583 ; $49af
	ld b, $03 ; $49b2
	ld c, $03 ; $49b4
	ld h, $0e ; $49b6
	farcall FillTilemapRect ; $49b8
Label_16_49bb:
	ret ; $49bb
Label_16_49bc:
	ld de, $002f ; $49bc
	call TestGameFlagByNumber ; $49bf
	jr z, Label_16_49f6 ; $49c2
	ld de, $d4ac ; $49c4
	ld b, $03 ; $49c7
	ld c, $03 ; $49c9
	ld h, $0c ; $49cb
	farcall FillTilemapRect ; $49cd
	ld de, $d4af ; $49d0
	ld b, $03 ; $49d3
	ld c, $03 ; $49d5
	ld h, $0d ; $49d7
	farcall FillTilemapRect ; $49d9
	ld de, $d582 ; $49dc
	ld b, $03 ; $49df
	ld c, $03 ; $49e1
	ld h, $0e ; $49e3
	farcall FillTilemapRect ; $49e5
	ld de, $d585 ; $49e8
	ld b, $03 ; $49eb
	ld c, $03 ; $49ed
	ld h, $0f ; $49ef
	farcall FillTilemapRect ; $49f1
	jr Label_16_4a0e ; $49f4
Label_16_49f6:
	ld de, $d4ad ; $49f6
	ld b, $03 ; $49f9
	ld c, $03 ; $49fb
	ld h, $0c ; $49fd
	farcall FillTilemapRect ; $49ff
	ld de, $d583 ; $4a02
	ld b, $03 ; $4a05
	ld c, $03 ; $4a07
	ld h, $0e ; $4a09
	farcall FillTilemapRect ; $4a0b
Label_16_4a0e:
	ret ; $4a0e
LoadMatchResultPalettes:
	ld a, [wMatchWinLoseFlag] ; $4a0f
	cp a, $ff ; $4a12
	jr z, Label_16_4a2e ; $4a14
	ld a, $02 ; $4a16
	ld [wAnimatedTileSet], a ; $4a18
	ld hl, $4a4e ; $4a1b
	ld de, $0101 ; $4a1e
	call LoadPaletteShadow ; $4a21
	ld hl, $4a46 ; $4a24
	ld de, $0201 ; $4a27
	call LoadPaletteShadow ; $4a2a
	ret ; $4a2d
Label_16_4a2e:
	ld a, $03 ; $4a2e
	ld [wAnimatedTileSet], a ; $4a30
	ld hl, $4a4e ; $4a33
	ld de, $0201 ; $4a36
	call LoadPaletteShadow ; $4a39
	ld hl, $4a46 ; $4a3c
	ld de, $0101 ; $4a3f
	call LoadPaletteShadow ; $4a42
	ret ; $4a45
	; $4a46, 16 bytes (palettes)
; GBC palettes (BGR555), 4 colors each
	dw $7de0, $5160, $2900, $2900 ; pal 0: #007bff #005aa4 #004152 #004152
	dw $5a9f, $39bf, $009f, $001f ; pal 1: #ffa4b4 #ff6a73 #ff2000 #ff0000
AdjustResultTilemapForLoss:
	ld a, [wMatchWinLoseFlag] ; $4a56
	cp a, $ff ; $4a59
	jr nz, Label_16_4a6f ; $4a5b
	ld hl, $d240 ; $4a5d
	ld de, $d120 ; $4a60
	ld b, $20 ; $4a63
	ld c, $02 ; $4a65
	farcall CopyTilemapRect ; $4a67
	ld a, $06 ; $4a6a
	ld [wAnimatedTilePeriod], a ; $4a6c
Label_16_4a6f:
	ret ; $4a6f
	ret ; $4a70
BuildMatchResultTilemap:
	ld a, [wCurrentMinigameStoryMatch + 1] ; $4a71
	add a, a ; $4a74
	ld hl, MatchResultTilemapScripts_16 ; $4a75
	add a, l ; $4a78
	ld l, a ; $4a79
	jr nc, Label_16_4a7d ; $4a7a
	inc h ; $4a7c
Label_16_4a7d:
	ld a, [hl+] ; $4a7d
	ld h, [hl] ; $4a7e
	ld l, a ; $4a7f
Label_16_4a80:
	ld a, [hl+] ; $4a80
	ld d, [hl] ; $4a81
	ld e, a ; $4a82
	ld a, d ; $4a83
	or a, e ; $4a84
	jr z, Label_16_4a99 ; $4a85
	inc hl ; $4a87
	ld a, [hl+] ; $4a88
	ld b, [hl] ; $4a89
	ld c, a ; $4a8a
	inc hl ; $4a8b
	ld a, [hl+] ; $4a8c
	push hl ; $4a8d
	ld h, b ; $4a8e
	ld l, c ; $4a8f
	ld b, a ; $4a90
	ld c, $02 ; $4a91
	farcall CopyTilemapRect ; $4a93
	pop hl ; $4a96
	jr Label_16_4a80 ; $4a97
Label_16_4a99:
	ld a, [wCurrentMinigameStoryMatch] ; $4a99
	cp a, $01 ; $4a9c
	jr nz, Label_16_4aaf ; $4a9e
	ld hl, $d3c7 ; $4aa0
	ld de, $d200 ; $4aa3
	ld b, $06 ; $4aa6
	ld c, $02 ; $4aa8
	farcall CopyTilemapRect ; $4aaa
	jr Label_16_4abc ; $4aad
Label_16_4aaf:
	ld hl, $d3c0 ; $4aaf
	ld de, $d200 ; $4ab2
	ld b, $07 ; $4ab5
	ld c, $02 ; $4ab7
	farcall CopyTilemapRect ; $4ab9
Label_16_4abc:
	ret ; $4abc
MatchResultTilemapScripts_16:
	; $4abd, 480 bytes (tilemap_scripts)
	dw .script0 ; 0
	dw .script1 ; 1
	dw .script2 ; 2
	dw .script3 ; 3
	dw .script4 ; 4
	dw .script5 ; 5
	dw .script6 ; 6
	dw .script7 ; 7
	dw .script8 ; 8
	dw .script9 ; 9
	dw .script10 ; 10
	dw .script11 ; 11
	dw .script12 ; 12
	dw .script13 ; 13
	dw .script14 ; 14
	dw .script15 ; 15
	dw .script16 ; 16
	dw .script17 ; 17
	dw .script18 ; 18
	dw .script19 ; 19
.script0:
	tilemap_copy $d000, $d2c0, 10
	tilemap_copy $d00b, $d2ca, 9
	tilemap_copy $d20a, $d3cd, 9
	tilemap_copy_end
.script1:
	tilemap_copy $d000, $d2c0, 10
	tilemap_copy $d00b, $d2ca, 9
	tilemap_copy $d209, $d380, 7
	tilemap_copy $d210, $d393, 4
	tilemap_copy_end
.script2:
	tilemap_copy $d000, $d2c0, 10
	tilemap_copy $d00b, $d2ca, 9
	tilemap_copy $d209, $d380, 7
	tilemap_copy $d210, $d38f, 4
	tilemap_copy_end
.script3:
	tilemap_copy $d000, $d2c0, 10
	tilemap_copy $d00b, $d2ca, 9
	tilemap_copy $d209, $d380, 7
	tilemap_copy $d210, $d38b, 4
	tilemap_copy_end
.script4:
	tilemap_copy $d000, $d2c0, 10
	tilemap_copy $d00b, $d2ca, 9
	tilemap_copy $d209, $d380, 7
	tilemap_copy $d210, $d388, 3
	tilemap_copy_end
.script5:
	tilemap_copy $d000, $d2c0, 10
	tilemap_copy $d00b, $d2d3, 8
	tilemap_copy $d20a, $d3cd, 9
	tilemap_copy_end
.script6:
	tilemap_copy $d000, $d2c0, 10
	tilemap_copy $d00b, $d2d3, 8
	tilemap_copy $d209, $d380, 7
	tilemap_copy $d210, $d393, 4
	tilemap_copy_end
.script7:
	tilemap_copy $d000, $d2c0, 10
	tilemap_copy $d00b, $d2d3, 8
	tilemap_copy $d209, $d380, 7
	tilemap_copy $d210, $d38f, 4
	tilemap_copy_end
.script8:
	tilemap_copy $d000, $d2c0, 10
	tilemap_copy $d00b, $d2d3, 8
	tilemap_copy $d209, $d380, 7
	tilemap_copy $d210, $d38b, 4
	tilemap_copy_end
.script9:
	tilemap_copy $d000, $d2c0, 10
	tilemap_copy $d00b, $d2d3, 8
	tilemap_copy $d209, $d380, 7
	tilemap_copy $d210, $d388, 3
	tilemap_copy_end
.script10:
	tilemap_copy $d000, $d2c0, 10
	tilemap_copy $d00a, $d300, 10
	tilemap_copy $d20a, $d3cd, 9
	tilemap_copy_end
.script11:
	tilemap_copy $d000, $d2c0, 10
	tilemap_copy $d00a, $d300, 10
	tilemap_copy $d209, $d380, 7
	tilemap_copy $d210, $d393, 4
	tilemap_copy_end
.script12:
	tilemap_copy $d000, $d2c0, 10
	tilemap_copy $d00a, $d300, 10
	tilemap_copy $d209, $d380, 7
	tilemap_copy $d210, $d38f, 4
	tilemap_copy_end
.script13:
	tilemap_copy $d000, $d2c0, 10
	tilemap_copy $d00a, $d300, 10
	tilemap_copy $d209, $d380, 7
	tilemap_copy $d210, $d38b, 4
	tilemap_copy_end
.script14:
	tilemap_copy $d000, $d2c0, 10
	tilemap_copy $d00a, $d300, 10
	tilemap_copy $d209, $d380, 7
	tilemap_copy $d210, $d388, 3
	tilemap_copy_end
.script15:
	tilemap_copy $d000, $d280, 20
	tilemap_copy $d20a, $d3cd, 9
	tilemap_copy_end
.script16:
	tilemap_copy $d000, $d280, 20
	tilemap_copy $d20a, $d340, 7
	tilemap_copy_end
.script17:
	tilemap_copy $d000, $d280, 20
	tilemap_copy $d209, $d380, 7
	tilemap_copy $d20a, $d347, 8
	tilemap_copy_end
.script18:
	tilemap_copy $d000, $d280, 20
	tilemap_copy $d209, $d34f, 10
	tilemap_copy_end
.script19:
	tilemap_copy $d000, $d280, 20
	tilemap_copy $d20c, $d359, 7
	tilemap_copy_end
AdvanceResultScreenTimer:
	ld a, [wMatchWinLoseFlag] ; $4c9d
	cp a, $ff ; $4ca0
	jr nz, Label_16_4ca9 ; $4ca2
	ldh a, [hVBlankCounter] ; $4ca4
	and a, $01 ; $4ca6
	ret z ; $4ca8
Label_16_4ca9:
	ld a, [$cb01] ; $4ca9
	inc a ; $4cac
	ld [$cb01], a ; $4cad
	ret ; $4cb0
QueueResultScreenSprites:
	ld a, [wMatchWinLoseFlag] ; $4cb1
	cp a, $ff ; $4cb4
	jr z, Label_16_4cd1 ; $4cb6
	ld de, $0824 ; $4cb8
	call QueueResultPortraitTop ; $4cbb
	ld de, $502c ; $4cbe
	call Func_16_4d96 ; $4cc1
	ld de, $5060 ; $4cc4
	call QueueResultPortraitBottom ; $4cc7
	ld de, $4e68 ; $4cca
	call Func_16_4dad ; $4ccd
	ret ; $4cd0
Label_16_4cd1:
	ld de, $5860 ; $4cd1
	call QueueResultPortraitTop ; $4cd4
	ld de, $5068 ; $4cd7
	call Func_16_4dc7 ; $4cda
	ld de, $0024 ; $4cdd
	call QueueResultPortraitBottom ; $4ce0
	ld de, $482c ; $4ce3
	call Func_16_4dba ; $4ce6
	ret ; $4ce9
QueueResultPortraitTop:
	call GetResultSpriteWobbleOffset ; $4cea
	ld b, a ; $4ced
	ld a, d ; $4cee
	sub a, b ; $4cef
	ld d, a ; $4cf0
	ld c, $00 ; $4cf1
	ld b, $08 ; $4cf3
	ldh a, [hVBlankCounter] ; $4cf5
	and a, $10 ; $4cf7
	jr z, Label_16_4cfd ; $4cf9
	ld b, $0a ; $4cfb
Label_16_4cfd:
	ld hl, ResultSpriteTemplateLeft_16 ; $4cfd
	call QueueSpriteTemplate ; $4d00
	ret ; $4d03
ResultSpriteTemplateLeft_16:
	; $4d04, 65 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $20, $08, $02, $00
	oam_sprite $10, $10, $04, $00
	oam_sprite $20, $10, $06, $00
	oam_sprite $10, $18, $08, $00
	oam_sprite $20, $18, $0a, $00
	oam_sprite $10, $20, $0c, $00
	oam_sprite $20, $20, $0e, $00
	oam_sprite $10, $28, $10, $00
	oam_sprite $20, $28, $12, $00
	oam_sprite $10, $30, $14, $00
	oam_sprite $20, $30, $16, $00
	oam_sprite $10, $38, $18, $00
	oam_sprite $20, $38, $1a, $00
	oam_sprite $10, $40, $1c, $00
	oam_sprite $20, $40, $1e, $00
	oam_sprite_end
QueueResultPortraitBottom:
	call GetResultSpriteWobbleOffset ; $4d45
	add a, d ; $4d48
	ld d, a ; $4d49
	ld c, $20 ; $4d4a
	ld b, $09 ; $4d4c
	ld hl, ResultSpriteTemplateRight_16 ; $4d4e
	call QueueSpriteTemplate ; $4d51
	ret ; $4d54
ResultSpriteTemplateRight_16:
	; $4d55, 65 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $20, $08, $02, $00
	oam_sprite $10, $10, $04, $00
	oam_sprite $20, $10, $06, $00
	oam_sprite $10, $18, $08, $00
	oam_sprite $20, $18, $0a, $00
	oam_sprite $10, $20, $0c, $00
	oam_sprite $20, $20, $0e, $00
	oam_sprite $10, $28, $10, $00
	oam_sprite $20, $28, $12, $00
	oam_sprite $10, $30, $14, $00
	oam_sprite $20, $30, $16, $00
	oam_sprite $10, $38, $18, $00
	oam_sprite $20, $38, $1a, $00
	oam_sprite $10, $40, $1c, $00
	oam_sprite $20, $40, $1e, $00
	oam_sprite_end
Func_16_4d96:
	call GetResultSpriteWobbleOffset ; $4d96
	ld b, a ; $4d99
	ld a, d ; $4d9a
	sub a, b ; $4d9b
	ld d, a ; $4d9c
	ld c, $40 ; $4d9d
	ld b, $08 ; $4d9f
	ldh a, [hVBlankCounter] ; $4da1
	and a, $10 ; $4da3
	jr z, Label_16_4da9 ; $4da5
	ld b, $0a ; $4da7
Label_16_4da9:
	call QueueSprite ; $4da9
	ret ; $4dac
Func_16_4dad:
	call GetResultSpriteWobbleOffset ; $4dad
	add a, d ; $4db0
	ld d, a ; $4db1
	ld c, $42 ; $4db2
	ld b, $09 ; $4db4
	call QueueSprite ; $4db6
	ret ; $4db9
Func_16_4dba:
	call GetResultSpriteWobbleOffset ; $4dba
	add a, d ; $4dbd
	ld d, a ; $4dbe
	ld c, $40 ; $4dbf
	ld b, $09 ; $4dc1
	call QueueSprite ; $4dc3
	ret ; $4dc6
Func_16_4dc7:
	call GetResultSpriteWobbleOffset ; $4dc7
	ld b, a ; $4dca
	ld a, d ; $4dcb
	sub a, b ; $4dcc
	ld d, a ; $4dcd
	ld c, $42 ; $4dce
	ld b, $08 ; $4dd0
	ldh a, [hVBlankCounter] ; $4dd2
	and a, $10 ; $4dd4
	jr z, Label_16_4dda ; $4dd6
	ld b, $0a ; $4dd8
Label_16_4dda:
	call QueueSprite ; $4dda
	ret ; $4ddd
GetResultSpriteWobbleOffset:
	ldh a, [hVBlankCounter] ; $4dde
	srl a ; $4de0
	and a, $0f ; $4de2
	ld hl, $4dee ; $4de4
	add a, l ; $4de7
	ld l, a ; $4de8
	jr nc, Label_16_4dec ; $4de9
	inc h ; $4deb
Label_16_4dec:
	ld a, [hl] ; $4dec
	ret ; $4ded
	INCBIN "data/bank_016/d_4dee.bin" ; $4dee, 16 bytes
LoadResultScreenTileGraphics:
	ld de, $d400 ; $4dfe
	ld b, $14 ; $4e01
	ld c, $02 ; $4e03
	ld h, $0b ; $4e05
	farcall FillTilemapRect ; $4e07
	ld de, $d600 ; $4e0a
	ld b, $14 ; $4e0d
	ld c, $02 ; $4e0f
	ld h, $0b ; $4e11
	farcall FillTilemapRect ; $4e13
	ld de, $002f ; $4e16
	call TestGameFlagByNumber ; $4e19
	jr nz, Label_16_4e29 ; $4e1c
	ld hl, $542e ; $4e1e
	ld de, $9000 ; $4e21
	call DecompressData ; $4e24
	jr Label_16_4e32 ; $4e27
Label_16_4e29:
	ld hl, $54bd ; $4e29
	ld de, $9000 ; $4e2c
	call DecompressData ; $4e2f
Label_16_4e32:
	ld a, [$d800] ; $4e32
	or a, a ; $4e35
	jr z, LoadMatchResultGfxSet ; $4e36
	ld hl, $5357 ; $4e38
	ld de, $8900 ; $4e3b
	call DecompressData ; $4e3e
	ld hl, $53c1 ; $4e41
	ld de, $8a40 ; $4e44
	call DecompressData ; $4e47
	ld hl, $5bf5 ; $4e4a
	ld de, $9140 ; $4e4d
	call DecompressData ; $4e50
	ret ; $4e53
LoadMatchResultGfxSet:
	ld a, [wCurrentMinigameStoryMatch + 1] ; $4e54
	call RemapDoublesMatchGfxIndex ; $4e57
	add a, a ; $4e5a
	ld hl, GfxSetPointerTable_16 ; $4e5b
	add a, l ; $4e5e
	ld l, a ; $4e5f
	jr nc, Label_16_4e63 ; $4e60
	inc h ; $4e62
Label_16_4e63:
	ld a, [hl+] ; $4e63
	ld h, [hl] ; $4e64
	ld l, a ; $4e65
	push hl ; $4e66
	ld a, [hl+] ; $4e67
	ld h, [hl] ; $4e68
	ld l, a ; $4e69
	ld de, $8900 ; $4e6a
	call DecompressData ; $4e6d
	pop hl ; $4e70
	inc hl ; $4e71
	inc hl ; $4e72
	push hl ; $4e73
	ld a, [hl+] ; $4e74
	ld h, [hl] ; $4e75
	ld l, a ; $4e76
	ld de, $8a40 ; $4e77
	call DecompressData ; $4e7a
	pop hl ; $4e7d
	inc hl ; $4e7e
	inc hl ; $4e7f
	ld a, [hl+] ; $4e80
	ld h, [hl] ; $4e81
	ld l, a ; $4e82
	ld de, $9140 ; $4e83
	call DecompressData ; $4e86
	ret ; $4e89
RemapDoublesMatchGfxIndex:
	push af ; $4e8a
	ld de, $002f ; $4e8b
	call TestGameFlagByNumber ; $4e8e
	jr z, Label_16_4e9b ; $4e91
	cp a, $11 ; $4e93
	jr nz, Label_16_4e9b ; $4e95
	ld a, $10 ; $4e97
	pop hl ; $4e99
	ret ; $4e9a
Label_16_4e9b:
	pop af ; $4e9b
	ret ; $4e9c
GfxSetPointerTable_16:
	; $4e9d, 176 bytes (gfx_ptr_table)
	dw .rec0 ; 0
	dw .rec1 ; 1
	dw .rec2 ; 2
	dw .rec3 ; 3
	dw .rec4 ; 4
	dw .rec5 ; 5
	dw .rec6 ; 6
	dw .rec7 ; 7
	dw .rec8 ; 8
	dw .rec9 ; 9
	dw .rec10 ; 10
	dw .rec11 ; 11
	dw .rec12 ; 12
	dw .rec13 ; 13
	dw .rec14 ; 14
	dw .rec15 ; 15
	dw .rec16 ; 16
	dw .rec17 ; 17
	dw .rec18 ; 18
	dw .rec19 ; 19
	dw .rec20 ; 20
	dw .rec20 ; 21
	dw .rec20 ; 22
	dw .rec20 ; 23
	dw .rec20 ; 24
.rec0:
	gfx_set Lz_16_5093, Lz_16_52bd, Lz_16_5a4f
.rec1:
	gfx_set Lz_16_5093, Lz_16_52bd, Lz_16_59a6
.rec2:
	gfx_set Lz_16_5093, Lz_16_52bd, Lz_16_58fa
.rec3:
	gfx_set Lz_16_5093, Lz_16_52bd, Lz_16_584d
.rec4:
	gfx_set Lz_16_5093, Lz_16_52bd, Lz_16_57ac
.rec5:
	gfx_set Lz_16_5093, Lz_16_5212, Lz_16_5a4f
.rec6:
	gfx_set Lz_16_5093, Lz_16_5212, Lz_16_59a6
.rec7:
	gfx_set Lz_16_5093, Lz_16_5212, Lz_16_58fa
.rec8:
	gfx_set Lz_16_5093, Lz_16_5212, Lz_16_584d
.rec9:
	gfx_set Lz_16_5093, Lz_16_5212, Lz_16_57ac
.rec10:
	gfx_set Lz_16_5093, Lz_16_5160, Lz_16_5a4f
.rec11:
	gfx_set Lz_16_5093, Lz_16_5160, Lz_16_59a6
.rec12:
	gfx_set Lz_16_5093, Lz_16_5160, Lz_16_58fa
.rec13:
	gfx_set Lz_16_5093, Lz_16_5160, Lz_16_584d
.rec14:
	gfx_set Lz_16_5093, Lz_16_5160, Lz_16_57ac
.rec15:
	gfx_set Lz_16_4f4d, Lz_16_5014, Lz_16_5a4f
.rec16:
	gfx_set Lz_16_4f4d, Lz_16_5014, Lz_16_5642
.rec17:
	gfx_set Lz_16_4f4d, Lz_16_5014, Lz_16_56f2
.rec18:
	gfx_set Lz_16_4f4d, Lz_16_5014, Lz_16_559e
.rec19:
	gfx_set Lz_16_4f4d, Lz_16_5014, Lz_16_5541
.rec20:
	gfx_set Lz_16_5357, Lz_16_53c1, Lz_16_5bf5
Lz_16_4f4d:
	INCBIN "data/bank_016/lz_4f4d.bin" ; $4f4d, 199 bytes
Lz_16_5014:
	INCBIN "data/bank_016/lz_5014.bin" ; $5014, 127 bytes
Lz_16_5093:
	INCBIN "data/bank_016/lz_5093.bin" ; $5093, 205 bytes
Lz_16_5160:
	INCBIN "data/bank_016/lz_5160.bin" ; $5160, 178 bytes
Lz_16_5212:
	INCBIN "data/bank_016/lz_5212.bin" ; $5212, 171 bytes
Lz_16_52bd:
	INCBIN "data/bank_016/lz_52bd.bin" ; $52bd, 154 bytes
Lz_16_5357:
	INCBIN "data/bank_016/lz_5357.bin" ; $5357, 106 bytes
Lz_16_53c1:
	INCBIN "data/bank_016/lz_53c1.bin" ; $53c1, 109 bytes
Lz_16_542e:
	INCBIN "data/bank_016/lz_542e.bin" ; $542e, 143 bytes
Lz_16_54bd:
	INCBIN "data/bank_016/lz_54bd.bin" ; $54bd, 132 bytes
Lz_16_5541:
	INCBIN "data/bank_016/lz_5541.bin" ; $5541, 93 bytes
Lz_16_559e:
	INCBIN "data/bank_016/lz_559e.bin" ; $559e, 164 bytes
Lz_16_5642:
	INCBIN "data/bank_016/lz_5642.bin" ; $5642, 176 bytes
Lz_16_56f2:
	INCBIN "data/bank_016/lz_56f2.bin" ; $56f2, 186 bytes
Lz_16_57ac:
	INCBIN "data/bank_016/lz_57ac.bin" ; $57ac, 161 bytes
Lz_16_584d:
	INCBIN "data/bank_016/lz_584d.bin" ; $584d, 173 bytes
Lz_16_58fa:
	INCBIN "data/bank_016/lz_58fa.bin" ; $58fa, 172 bytes
Lz_16_59a6:
	INCBIN "data/bank_016/lz_59a6.bin" ; $59a6, 169 bytes
Lz_16_5a4f:
	INCBIN "data/bank_016/lz_5a4f.bin" ; $5a4f, 192 bytes
Lz_16_5b0f:
	INCBIN "data/bank_016/lz_5b0f.bin" ; $5b0f, 230 bytes
Lz_16_5bf5:
	INCBIN "data/bank_016/lz_5bf5.bin" ; $5bf5, 28 bytes
MaybeInvertMatchWinLoseFlag:
	ld a, [wGameMode] ; $5c11
	cp a, $09 ; $5c14
	ret nz ; $5c16
	ld a, [$c8b9] ; $5c17
	cp a, $01 ; $5c1a
	jr nz, Label_16_5c1f ; $5c1c
	ret ; $5c1e
Label_16_5c1f:
	cp a, $02 ; $5c1f
	jr nz, Label_16_5c34 ; $5c21
	ld a, [wMatchWinLoseFlag] ; $5c23
	cp a, $ff ; $5c26
	jr z, Label_16_5c2e ; $5c28
	ld a, $ff ; $5c2a
	jr Label_16_5c30 ; $5c2c
Label_16_5c2e:
	ld a, $01 ; $5c2e
Label_16_5c30:
	ld [wMatchWinLoseFlag], a ; $5c30
	ret ; $5c33
Label_16_5c34:
	ret ; $5c34
RunMatchStatsScreen:
	call DisableLCDSafely ; $5c35
	farcall LoadMenuFontGfx ; $5c38
	wram_bank $03 ; $5c3b
	ld a, $01 ; $5c41
	ld [$d801], a ; $5c43
	call InitMatchStatsScreen ; $5c46
	call LoadMatchResultPalettes ; $5c49
	ld a, $01 ; $5c4c
	ld hl, UpdateResultScreenAnimatedTilesTask ; $5c4e
	call RegisterFrameTask ; $5c51
	call EnableLCD ; $5c54
	script_fade_in $10 ; $5c57
	call WaitFadeEnd ; $5c5c
Label_16_5c5f:
	call PrintMatchSetScores ; $5c5f
	ldh a, [hInputPressed] ; $5c62
	bit PADB_LEFT, a ; $5c64
	jr nz, Label_16_5c75 ; $5c66
	bit 0, a ; $5c68
	jr nz, Label_16_5c7f ; $5c6a
	bit 1, a ; $5c6c
	jr nz, Label_16_5c7f ; $5c6e
	call AdvanceFrame ; $5c70
	jr Label_16_5c5f ; $5c73
Label_16_5c75:
	ld c, $40 ; $5c75
	call BeginFadeOut ; $5c77
	call WaitFadeEnd ; $5c7a
	xor a, a ; $5c7d
	ret ; $5c7e
Label_16_5c7f:
	ld c, $20 ; $5c7f
	call BeginFadeOut ; $5c81
	call WaitFadeEnd ; $5c84
	ld a, $ff ; $5c87
	ret ; $5c89
InitMatchStatsScreen:
	ld c, $23 ; $5c8a
	farcall LoadScreenAssetRecord ; $5c8c
	ld de, $a000 ; $5c8f
	ld c, $00 ; $5c92
	ld b, $08 ; $5c94
	farcall InitNumberSpriteGfx ; $5c96
	ld a, $00 ; $5c99
	ld d, $04 ; $5c9b
	farcall LoadIndexedPalette_18 ; $5c9d
	ld a, $00 ; $5ca0
	ld d, $05 ; $5ca2
	farcall LoadIndexedPalette_18 ; $5ca4
	ld a, $00 ; $5ca7
	ld d, $06 ; $5ca9
	farcall LoadIndexedPalette_18 ; $5cab
	ld a, $00 ; $5cae
	ld d, $07 ; $5cb0
	farcall LoadIndexedPalette_18 ; $5cb2
	wram_bank $03 ; $5cb5
	call Func_16_5f92 ; $5cbb
	call LoadResultScreenTileGraphics ; $5cbe
	ld de, $d600 ; $5cc1
	ld b, $14 ; $5cc4
	ld c, $02 ; $5cc6
	ld h, $08 ; $5cc8
	farcall FillTilemapRect ; $5cca
	call SetMatchStatsPortraitPaletteAttrs ; $5ccd
	ld c, $01 ; $5cd0
	call LoadResultScreenPortraits ; $5cd2
	call PrintMatchStatistics ; $5cd5
	farcall QueueWram3MapToVRAM ; $5cd8
	ret ; $5cdb
SetMatchStatsPortraitPaletteAttrs:
	ld de, $002f ; $5cdc
	call TestGameFlagByNumber ; $5cdf
	jr z, Label_16_5d16 ; $5ce2
	ld de, $d481 ; $5ce4
	ld b, $03 ; $5ce7
	ld c, $03 ; $5ce9
	ld h, $0c ; $5ceb
	farcall FillTilemapRect ; $5ced
	ld de, $d484 ; $5cf0
	ld b, $03 ; $5cf3
	ld c, $03 ; $5cf5
	ld h, $0d ; $5cf7
	farcall FillTilemapRect ; $5cf9
	ld de, $d48d ; $5cfc
	ld b, $03 ; $5cff
	ld c, $03 ; $5d01
	ld h, $0e ; $5d03
	farcall FillTilemapRect ; $5d05
	ld de, $d490 ; $5d08
	ld b, $03 ; $5d0b
	ld c, $03 ; $5d0d
	ld h, $0f ; $5d0f
	farcall FillTilemapRect ; $5d11
	jr Label_16_5d2e ; $5d14
Label_16_5d16:
	ld de, $d482 ; $5d16
	ld b, $03 ; $5d19
	ld c, $03 ; $5d1b
	ld h, $0c ; $5d1d
	farcall FillTilemapRect ; $5d1f
	ld de, $d48e ; $5d22
	ld b, $03 ; $5d25
	ld c, $03 ; $5d27
	ld h, $0e ; $5d29
	farcall FillTilemapRect ; $5d2b
Label_16_5d2e:
	ret ; $5d2e
PrintMatchStatistics:
	call ClearMatchStatsNumberArea ; $5d2f
	ld de, $002f ; $5d32
	call TestGameFlagByNumber ; $5d35
	jr z, Label_16_5d3f ; $5d38
	call PrintDoublesMatchStats ; $5d3a
	jr Label_16_5d42 ; $5d3d
Label_16_5d3f:
	call PrintSinglesMatchStats ; $5d3f
Label_16_5d42:
	ret ; $5d42
PrintSinglesMatchStats:
	ld a, [wCharacter1ServiceAces] ; $5d43
	ld h, $00 ; $5d46
	ld l, a ; $5d48
	ld bc, $d810 ; $5d49
	ld de, $d163 ; $5d4c
	farcall PrintNumberRightAligned ; $5d4f
	ld a, [wCharacter1SmashAces] ; $5d52
	ld h, $00 ; $5d55
	ld l, a ; $5d57
	ld bc, $d810 ; $5d58
	ld de, $d183 ; $5d5b
	farcall PrintNumberRightAligned ; $5d5e
	ld a, [wCharacter1ReturnAces] ; $5d61
	ld h, $00 ; $5d64
	ld l, a ; $5d66
	ld bc, $d810 ; $5d67
	ld de, $d1a3 ; $5d6a
	farcall PrintNumberRightAligned ; $5d6d
	ld a, [wCharacter1LobShotWinners] ; $5d70
	ld h, $00 ; $5d73
	ld l, a ; $5d75
	ld bc, $d810 ; $5d76
	ld de, $d1c3 ; $5d79
	farcall PrintNumberRightAligned ; $5d7c
	ld a, [wCharacter1DropShotWinners] ; $5d7f
	ld h, $00 ; $5d82
	ld l, a ; $5d84
	ld bc, $d810 ; $5d85
	ld de, $d1e3 ; $5d88
	farcall PrintNumberRightAligned ; $5d8b
	ld a, [wCharacter1DoubleFaults] ; $5d8e
	ld h, $00 ; $5d91
	ld l, a ; $5d93
	ld bc, $d810 ; $5d94
	ld de, $d203 ; $5d97
	farcall PrintNumberRightAligned ; $5d9a
	ld a, [wCharacter2ServiceAces] ; $5d9d
	ld h, $00 ; $5da0
	ld l, a ; $5da2
	ld bc, $d810 ; $5da3
	ld de, $d170 ; $5da6
	farcall PrintNumberRightAligned ; $5da9
	ld a, [wCharacter2SmashAces] ; $5dac
	ld h, $00 ; $5daf
	ld l, a ; $5db1
	ld bc, $d810 ; $5db2
	ld de, $d190 ; $5db5
	farcall PrintNumberRightAligned ; $5db8
	ld a, [wCharacter2ReturnAces] ; $5dbb
	ld h, $00 ; $5dbe
	ld l, a ; $5dc0
	ld bc, $d810 ; $5dc1
	ld de, $d1b0 ; $5dc4
	farcall PrintNumberRightAligned ; $5dc7
	ld a, [wCharacter2LobShotWinners] ; $5dca
	ld h, $00 ; $5dcd
	ld l, a ; $5dcf
	ld bc, $d810 ; $5dd0
	ld de, $d1d0 ; $5dd3
	farcall PrintNumberRightAligned ; $5dd6
	ld a, [wCharacter2DropShotWinners] ; $5dd9
	ld h, $00 ; $5ddc
	ld l, a ; $5dde
	ld bc, $d810 ; $5ddf
	ld de, $d1f0 ; $5de2
	farcall PrintNumberRightAligned ; $5de5
	ld a, [wCharacter2DoubleFaults] ; $5de8
	ld h, $00 ; $5deb
	ld l, a ; $5ded
	ld bc, $d810 ; $5dee
	ld de, $d210 ; $5df1
	farcall PrintNumberRightAligned ; $5df4
	ret ; $5df7
PrintDoublesMatchStats:
	ld a, [wCharacter1ServiceAces] ; $5df8
	ld h, $00 ; $5dfb
	ld l, a ; $5dfd
	ld bc, $d810 ; $5dfe
	ld de, $d162 ; $5e01
	farcall PrintNumberRightAligned ; $5e04
	ld a, [wCharacter1SmashAces] ; $5e07
	ld h, $00 ; $5e0a
	ld l, a ; $5e0c
	ld bc, $d810 ; $5e0d
	ld de, $d182 ; $5e10
	farcall PrintNumberRightAligned ; $5e13
	ld a, [wCharacter1ReturnAces] ; $5e16
	ld h, $00 ; $5e19
	ld l, a ; $5e1b
	ld bc, $d810 ; $5e1c
	ld de, $d1a2 ; $5e1f
	farcall PrintNumberRightAligned ; $5e22
	ld a, [wCharacter1LobShotWinners] ; $5e25
	ld h, $00 ; $5e28
	ld l, a ; $5e2a
	ld bc, $d810 ; $5e2b
	ld de, $d1c2 ; $5e2e
	farcall PrintNumberRightAligned ; $5e31
	ld a, [wCharacter1DropShotWinners] ; $5e34
	ld h, $00 ; $5e37
	ld l, a ; $5e39
	ld bc, $d810 ; $5e3a
	ld de, $d1e2 ; $5e3d
	farcall PrintNumberRightAligned ; $5e40
	ld a, [wCharacter1DoubleFaults] ; $5e43
	ld h, $00 ; $5e46
	ld l, a ; $5e48
	ld bc, $d810 ; $5e49
	ld de, $d202 ; $5e4c
	farcall PrintNumberRightAligned ; $5e4f
	ld a, [wCharacter3ServiceAces] ; $5e52
	ld h, $00 ; $5e55
	ld l, a ; $5e57
	ld bc, $d810 ; $5e58
	ld de, $d165 ; $5e5b
	farcall PrintNumberRightAligned ; $5e5e
	ld a, [wCharacter3SmashAces] ; $5e61
	ld h, $00 ; $5e64
	ld l, a ; $5e66
	ld bc, $d810 ; $5e67
	ld de, $d185 ; $5e6a
	farcall PrintNumberRightAligned ; $5e6d
	ld a, [wCharacter3ReturnAces] ; $5e70
	ld h, $00 ; $5e73
	ld l, a ; $5e75
	ld bc, $d810 ; $5e76
	ld de, $d1a5 ; $5e79
	farcall PrintNumberRightAligned ; $5e7c
	ld a, [wCharacter3LobShotWinners] ; $5e7f
	ld h, $00 ; $5e82
	ld l, a ; $5e84
	ld bc, $d810 ; $5e85
	ld de, $d1c5 ; $5e88
	farcall PrintNumberRightAligned ; $5e8b
	ld a, [wCharacter3DropShotWinners] ; $5e8e
	ld h, $00 ; $5e91
	ld l, a ; $5e93
	ld bc, $d810 ; $5e94
	ld de, $d1e5 ; $5e97
	farcall PrintNumberRightAligned ; $5e9a
	ld a, [wCharacter3DoubleFaults] ; $5e9d
	ld h, $00 ; $5ea0
	ld l, a ; $5ea2
	ld bc, $d810 ; $5ea3
	ld de, $d205 ; $5ea6
	farcall PrintNumberRightAligned ; $5ea9
	ld a, [wCharacter2ServiceAces] ; $5eac
	ld h, $00 ; $5eaf
	ld l, a ; $5eb1
	ld bc, $d810 ; $5eb2
	ld de, $d16f ; $5eb5
	farcall PrintNumberRightAligned ; $5eb8
	ld a, [wCharacter2SmashAces] ; $5ebb
	ld h, $00 ; $5ebe
	ld l, a ; $5ec0
	ld bc, $d810 ; $5ec1
	ld de, $d18f ; $5ec4
	farcall PrintNumberRightAligned ; $5ec7
	ld a, [wCharacter2ReturnAces] ; $5eca
	ld h, $00 ; $5ecd
	ld l, a ; $5ecf
	ld bc, $d810 ; $5ed0
	ld de, $d1af ; $5ed3
	farcall PrintNumberRightAligned ; $5ed6
	ld a, [wCharacter2LobShotWinners] ; $5ed9
	ld h, $00 ; $5edc
	ld l, a ; $5ede
	ld bc, $d810 ; $5edf
	ld de, $d1cf ; $5ee2
	farcall PrintNumberRightAligned ; $5ee5
	ld a, [wCharacter2DropShotWinners] ; $5ee8
	ld h, $00 ; $5eeb
	ld l, a ; $5eed
	ld bc, $d810 ; $5eee
	ld de, $d1ef ; $5ef1
	farcall PrintNumberRightAligned ; $5ef4
	ld a, [wCharacter2DoubleFaults] ; $5ef7
	ld h, $00 ; $5efa
	ld l, a ; $5efc
	ld bc, $d810 ; $5efd
	ld de, $d20f ; $5f00
	farcall PrintNumberRightAligned ; $5f03
	ld a, [wCharacter4ServiceAces] ; $5f06
	ld h, $00 ; $5f09
	ld l, a ; $5f0b
	ld bc, $d810 ; $5f0c
	ld de, $d172 ; $5f0f
	farcall PrintNumberRightAligned ; $5f12
	ld a, [wCharacter4SmashAces] ; $5f15
	ld h, $00 ; $5f18
	ld l, a ; $5f1a
	ld bc, $d810 ; $5f1b
	ld de, $d192 ; $5f1e
	farcall PrintNumberRightAligned ; $5f21
	ld a, [wCharacter4ReturnAces] ; $5f24
	ld h, $00 ; $5f27
	ld l, a ; $5f29
	ld bc, $d810 ; $5f2a
	ld de, $d1b2 ; $5f2d
	farcall PrintNumberRightAligned ; $5f30
	ld a, [wPlayer4LobShotWinners] ; $5f33
	ld h, $00 ; $5f36
	ld l, a ; $5f38
	ld bc, $d810 ; $5f39
	ld de, $d1d2 ; $5f3c
	farcall PrintNumberRightAligned ; $5f3f
	ld a, [wCharacter4DropShotWinners] ; $5f42
	ld h, $00 ; $5f45
	ld l, a ; $5f47
	ld bc, $d810 ; $5f48
	ld de, $d1f2 ; $5f4b
	farcall PrintNumberRightAligned ; $5f4e
	ld a, [wCharacter4DoubleFaults] ; $5f51
	ld h, $00 ; $5f54
	ld l, a ; $5f56
	ld bc, $d810 ; $5f57
	ld de, $d212 ; $5f5a
	farcall PrintNumberRightAligned ; $5f5d
	ret ; $5f60
ClearMatchStatsNumberArea:
	ld de, $d561 ; $5f61
	ld b, $05 ; $5f64
	ld c, $06 ; $5f66
	ld h, $00 ; $5f68
	farcall FillTilemapRect ; $5f6a
	ld de, $d56e ; $5f6d
	ld b, $05 ; $5f70
	ld c, $06 ; $5f72
	ld h, $00 ; $5f74
	farcall FillTilemapRect ; $5f76
	ld de, $d161 ; $5f79
	ld b, $05 ; $5f7c
	ld c, $06 ; $5f7e
	ld h, $20 ; $5f80
	farcall FillTilemapRect ; $5f82
	ld de, $d16e ; $5f85
	ld b, $05 ; $5f88
	ld c, $06 ; $5f8a
	ld h, $20 ; $5f8c
	farcall FillTilemapRect ; $5f8e
	ret ; $5f91
Func_16_5f92:
	ld de, $002f ; $5f92
	call TestGameFlagByNumber ; $5f95
	ret nz ; $5f98
	ld hl, $d240 ; $5f99
	ld de, $d080 ; $5f9c
	ld b, $08 ; $5f9f
	ld c, $04 ; $5fa1
	farcall CopyTilemapRect ; $5fa3
	ld hl, $d24c ; $5fa6
	ld de, $d08c ; $5fa9
	ld b, $08 ; $5fac
	ld c, $04 ; $5fae
	farcall CopyTilemapRect ; $5fb0
	ld hl, $d640 ; $5fb3
	ld de, $d480 ; $5fb6
	ld b, $08 ; $5fb9
	ld c, $04 ; $5fbb
	farcall CopyTilemapRect ; $5fbd
	ld hl, $d64c ; $5fc0
	ld de, $d48c ; $5fc3
	ld b, $08 ; $5fc6
	ld c, $04 ; $5fc8
	farcall CopyTilemapRect ; $5fca
	ret ; $5fcd
PrintMatchSetScores:
	ld a, [wPlayer1SetsWon] ; $5fce
	ld h, $00 ; $5fd1
	ld l, a ; $5fd3
	ld de, $1c48 ; $5fd4
	farcall DrawDecimalNumberSprites_39 ; $5fd7
	ld a, [wPlayer2SetsWon] ; $5fda
	ld h, $00 ; $5fdd
	ld l, a ; $5fdf
	ld de, $8448 ; $5fe0
	farcall DrawDecimalNumberSprites_39 ; $5fe3
	ret ; $5fe6
LoadResultScreenPortraits:
	ld a, c ; $5fe7
	or a, a ; $5fe8
	jr nz, Label_16_5ff9 ; $5fe9
	ld a, [wGameMode] ; $5feb
	cp a, $09 ; $5fee
	jr nz, Label_16_5ff9 ; $5ff0
	ld a, [$c8b9] ; $5ff2
	cp a, $02 ; $5ff5
	jr z, Label_16_6036 ; $5ff7
Label_16_5ff9:
	ld a, [wPlayer1CurrentMainCharacter] ; $5ff9
	ld d, a ; $5ffc
	ld a, [$ca0c] ; $5ffd
	ld b, a ; $6000
	ld c, $00 ; $6001
	call LoadResultPortraitSlot ; $6003
	ld a, [wPlayer2CurrentMainCharacter] ; $6006
	ld d, a ; $6009
	ld a, [$ca8c] ; $600a
	ld b, a ; $600d
	ld c, $02 ; $600e
	call LoadResultPortraitSlot ; $6010
	ld de, $002f ; $6013
	call TestGameFlagByNumber ; $6016
	jr z, Label_16_6035 ; $6019
	ld a, [wPlayer1CurrentPartnerCharacter] ; $601b
	ld d, a ; $601e
	ld a, [$ca4c] ; $601f
	ld b, a ; $6022
	ld c, $01 ; $6023
	call LoadResultPortraitSlot ; $6025
	ld a, [wPlayer2CurrentPartnerCharacter] ; $6028
	ld d, a ; $602b
	ld a, [$cacc] ; $602c
	ld b, a ; $602f
	ld c, $03 ; $6030
	call LoadResultPortraitSlot ; $6032
Label_16_6035:
	ret ; $6035
Label_16_6036:
	ld a, [wPlayer1CurrentMainCharacter] ; $6036
	ld d, a ; $6039
	ld a, [$ca0c] ; $603a
	ld b, a ; $603d
	ld c, $02 ; $603e
	call LoadResultPortraitSlot ; $6040
	ld a, [wPlayer2CurrentMainCharacter] ; $6043
	ld d, a ; $6046
	ld a, [$ca8c] ; $6047
	ld b, a ; $604a
	ld c, $00 ; $604b
	call LoadResultPortraitSlot ; $604d
	ld de, $002f ; $6050
	call TestGameFlagByNumber ; $6053
	jr z, Label_16_6072 ; $6056
	ld a, [wPlayer1CurrentPartnerCharacter] ; $6058
	ld d, a ; $605b
	ld a, [$ca4c] ; $605c
	ld b, a ; $605f
	ld c, $03 ; $6060
	call LoadResultPortraitSlot ; $6062
	ld a, [wPlayer2CurrentPartnerCharacter] ; $6065
	ld d, a ; $6068
	ld a, [$cacc] ; $6069
	ld b, a ; $606c
	ld c, $01 ; $606d
	call LoadResultPortraitSlot ; $606f
Label_16_6072:
	ret ; $6072
LoadResultPortraitSlot:
	push de ; $6073
	push bc ; $6074
	ld a, c ; $6075
	add a, $04 ; $6076
	ld d, a ; $6078
	ld a, b ; $6079
	farcall LoadIndexedPalette_18 ; $607a
	pop bc ; $607d
	pop de ; $607e
	ld b, d ; $607f
	ld a, c ; $6080
	add a, a ; $6081
	ld hl, $60b7 ; $6082
	add a, l ; $6085
	ld l, a ; $6086
	jr nc, Label_16_608a ; $6087
	inc h ; $6089
Label_16_608a:
	ld a, [hl+] ; $608a
	ld d, [hl] ; $608b
	ld e, a ; $608c
	push de ; $608d
	ld a, c ; $608e
	cp a, $02 ; $608f
	jr z, Label_16_6099 ; $6091
	cp a, $03 ; $6093
	jr z, Label_16_6099 ; $6095
	jr Label_16_609d ; $6097
Label_16_6099:
	ld c, $00 ; $6099
	jr Label_16_60b2 ; $609b
Label_16_609d:
	ld a, [$d801] ; $609d
	or a, a ; $60a0
	jr z, Label_16_60a7 ; $60a1
	ld c, $00 ; $60a3
	jr Label_16_60b2 ; $60a5
Label_16_60a7:
	ld c, $01 ; $60a7
	ld a, [wMatchWinLoseFlag] ; $60a9
	cp a, $ff ; $60ac
	jr nz, Label_16_60b2 ; $60ae
	ld c, $02 ; $60b0
Label_16_60b2:
	pop de ; $60b2
	call DecompressResultPortrait ; $60b3
	ret ; $60b6
	; $60b7, 9 bytes (records:2)
	dw $8c00 ; record 0
	dw $8d00 ; record 1
	dw $8e00 ; record 2
	dw $8f00 ; record 3
	db $c9
DecompressResultPortrait:
	ld a, c ; $60c0
	or a, a ; $60c1
	jr z, Label_16_60c8 ; $60c2
	call DecompressWinLosePortraitVariant ; $60c4
	ret ; $60c7
Label_16_60c8:
	cp a, $20 ; $60c8
	jr c, Label_16_60d1 ; $60ca
	ld a, b ; $60cc
	farcall RemapExtendedCharId ; $60cd
	ld b, a ; $60d0
Label_16_60d1:
	call DecompressCharacterPortrait ; $60d1
	ret ; $60d4
DecompressWinLosePortraitVariant:
	ld a, b ; $60d5
	add a, a ; $60d6
	and a, $07 ; $60d7
	ld b, a ; $60d9
	ld a, c ; $60da
	cp a, $01 ; $60db
	ld a, b ; $60dd
	jr z, Label_16_60e1 ; $60de
	inc a ; $60e0
Label_16_60e1:
	ld hl, WinLosePortraitVariantTable_16 ; $60e1
	add a, a ; $60e4
	add a, l ; $60e5
	ld l, a ; $60e6
	jr nc, Label_16_60ea ; $60e7
	inc h ; $60e9
Label_16_60ea:
	ld a, [hl+] ; $60ea
	ld h, [hl] ; $60eb
	ld l, a ; $60ec
	call DecompressData ; $60ed
	ret ; $60f0
WinLosePortraitVariantTable_16:
	; $60f1, 16 bytes (lz_ptr_table)
	dw Lz_16_6101 ; 0
	dw Lz_16_6214 ; 1
	dw Lz_16_6315 ; 2
	dw Lz_16_6422 ; 3
	dw Lz_16_6536 ; 4
	dw Lz_16_6634 ; 5
	dw Lz_16_6727 ; 6
	dw Lz_16_684a ; 7
Lz_16_6101:
	INCBIN "data/bank_016/lz_6101.bin" ; $6101, 275 bytes
Lz_16_6214:
	INCBIN "data/bank_016/lz_6214.bin" ; $6214, 257 bytes
Lz_16_6315:
	INCBIN "data/bank_016/lz_6315.bin" ; $6315, 269 bytes
Lz_16_6422:
	INCBIN "data/bank_016/lz_6422.bin" ; $6422, 276 bytes
Lz_16_6536:
	INCBIN "data/bank_016/lz_6536.bin" ; $6536, 254 bytes
Lz_16_6634:
	INCBIN "data/bank_016/lz_6634.bin" ; $6634, 243 bytes
Lz_16_6727:
	INCBIN "data/bank_016/lz_6727.bin" ; $6727, 291 bytes
Lz_16_684a:
	INCBIN "data/bank_016/lz_684a.bin" ; $684a, 267 bytes
DecompressCharacterPortrait:
	ld a, b ; $6955
	and a, $1f ; $6956
	add a, a ; $6958
	ld hl, CharacterPortraitTable_16 ; $6959
	add a, l ; $695c
	ld l, a ; $695d
	jr nc, Label_16_6961 ; $695e
	inc h ; $6960
Label_16_6961:
	ld a, [hl+] ; $6961
	ld h, [hl] ; $6962
	ld l, a ; $6963
	call DecompressData ; $6964
	ret ; $6967
CharacterPortraitTable_16:
	; $6968, 64 bytes (lz_ptr_table)
	dw Lz_16_69a8 ; 0
	dw Lz_16_6a46 ; 1
	dw Lz_16_6ae9 ; 2
	dw Lz_16_6b7b ; 3
	dw Lz_16_6c20 ; 4
	dw Lz_16_6ca6 ; 5
	dw Lz_16_6d3a ; 6
	dw Lz_16_6dca ; 7
	dw Lz_16_6e53 ; 8
	dw Lz_16_6ee0 ; 9
	dw Lz_16_6f73 ; 10
	dw Lz_16_7006 ; 11
	dw Lz_16_70a7 ; 12
	dw Lz_16_7148 ; 13
	dw Lz_16_71e5 ; 14
	dw Lz_16_727b ; 15
	dw Lz_16_7310 ; 16
	dw Lz_16_73b2 ; 17
	dw Lz_16_7449 ; 18
	dw Lz_16_74dc ; 19
	dw Lz_16_7555 ; 20
	dw Lz_16_7555 ; 21
	dw Lz_16_7555 ; 22
	dw Lz_16_75d3 ; 23
	dw Lz_16_766d ; 24
	dw Lz_16_7709 ; 25
	dw Lz_16_77a4 ; 26
	dw Lz_16_7846 ; 27
	dw Lz_16_78e4 ; 28
	dw Lz_16_796f ; 29
	dw Lz_16_7a14 ; 30
	dw Lz_16_7ab6 ; 31
Lz_16_69a8:
	INCBIN "data/bank_016/lz_69a8.bin" ; $69a8, 158 bytes
Lz_16_6a46:
	INCBIN "data/bank_016/lz_6a46.bin" ; $6a46, 163 bytes
Lz_16_6ae9:
	INCBIN "data/bank_016/lz_6ae9.bin" ; $6ae9, 146 bytes
Lz_16_6b7b:
	INCBIN "data/bank_016/lz_6b7b.bin" ; $6b7b, 165 bytes
Lz_16_6c20:
	INCBIN "data/bank_016/lz_6c20.bin" ; $6c20, 134 bytes
Lz_16_6ca6:
	INCBIN "data/bank_016/lz_6ca6.bin" ; $6ca6, 148 bytes
Lz_16_6d3a:
	INCBIN "data/bank_016/lz_6d3a.bin" ; $6d3a, 144 bytes
Lz_16_6dca:
	INCBIN "data/bank_016/lz_6dca.bin" ; $6dca, 137 bytes
Lz_16_6e53:
	INCBIN "data/bank_016/lz_6e53.bin" ; $6e53, 141 bytes
Lz_16_6ee0:
	INCBIN "data/bank_016/lz_6ee0.bin" ; $6ee0, 147 bytes
Lz_16_6f73:
	INCBIN "data/bank_016/lz_6f73.bin" ; $6f73, 147 bytes
Lz_16_7006:
	INCBIN "data/bank_016/lz_7006.bin" ; $7006, 161 bytes
Lz_16_70a7:
	INCBIN "data/bank_016/lz_70a7.bin" ; $70a7, 161 bytes
Lz_16_7148:
	INCBIN "data/bank_016/lz_7148.bin" ; $7148, 157 bytes
Lz_16_71e5:
	INCBIN "data/bank_016/lz_71e5.bin" ; $71e5, 150 bytes
Lz_16_727b:
	INCBIN "data/bank_016/lz_727b.bin" ; $727b, 149 bytes
Lz_16_7310:
	INCBIN "data/bank_016/lz_7310.bin" ; $7310, 162 bytes
Lz_16_73b2:
	INCBIN "data/bank_016/lz_73b2.bin" ; $73b2, 110 bytes
RulesBorderAnimTask:
	INCBIN "data/bank_016/d_7420.bin" ; $7420, 41 bytes
Lz_16_7449:
	INCBIN "data/bank_016/lz_7449.bin" ; $7449, 146 bytes
RulesSpinningBallSpriteTask:
	db $00 ; $74db
Lz_16_74dc:
	INCBIN "data/bank_016/lz_74dc.bin" ; $74dc, 121 bytes
Lz_16_7555:
	INCBIN "data/bank_016/lz_7555.bin" ; $7555, 9 bytes
RulesScrollArrowSpriteTask:
	INCBIN "data/bank_016/d_755e.bin" ; $755e, 117 bytes
Lz_16_75d3:
	INCBIN "data/bank_016/lz_75d3.bin" ; $75d3, 154 bytes
Lz_16_766d:
	INCBIN "data/bank_016/lz_766d.bin" ; $766d, 156 bytes
Lz_16_7709:
	INCBIN "data/bank_016/lz_7709.bin" ; $7709, 155 bytes
Lz_16_77a4:
	INCBIN "data/bank_016/lz_77a4.bin" ; $77a4, 162 bytes
Lz_16_7846:
	INCBIN "data/bank_016/lz_7846.bin" ; $7846, 158 bytes
Lz_16_78e4:
	INCBIN "data/bank_016/lz_78e4.bin" ; $78e4, 139 bytes
Lz_16_796f:
	INCBIN "data/bank_016/lz_796f.bin" ; $796f, 165 bytes
Lz_16_7a14:
	INCBIN "data/bank_016/lz_7a14.bin" ; $7a14, 162 bytes
Lz_16_7ab6:
	INCBIN "data/bank_016/lz_7ab6.bin" ; $7ab6, 153 bytes
	; $7b4f, 1201 bytes fill to bank end (linker-padded)
