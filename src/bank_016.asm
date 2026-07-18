SECTION "ROM Bank $16", ROMX[$4000], BANK[$16]

FarPtr_RunMatchWinLoseScreen:
	dw RunMatchWinLoseScreen ; $4000
FarPtr_RunMatchStatsScreen:
	dw RunMatchStatsScreen ; $4002
FarPtr_DecompressCharacterPortrait:
	dw DecompressCharacterPortrait ; $4004
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
	farcall FarPtr_39_04 ; $43f6
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
	farcall FarPtr_39_04 ; $44bc
	ld a, $01 ; $44bf
	ld hl, $43f6 ; $44c1
	call RegisterFrameTask ; $44c4
	ld a, $01 ; $44c7
	ld hl, $4cb1 ; $44c9
	call RegisterFrameTask ; $44cc
	call EnableLCD ; $44cf
	ld c, $10 ; $44d2
	call BeginFadeIn ; $44d4
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
	ld hl, $4c9d ; $44f3
	call RegisterFrameTask ; $44f6
Label_16_44f9:
	call AdvanceFrame ; $44f9
	ld a, [$c8f7] ; $44fc
	push de ; $44ff
	push af ; $4500
	ld a, a ; $4501
	ld de, $0303 ; $4502
	call PrintDecimalByte ; $4505
	pop af ; $4508
	pop de ; $4509
	ldh a, [hInputPressed] ; $450a
	ld [wMenuInputPressed], a ; $450c
	bit 0, a ; $450f
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
	ld [$cb0c], a ; $4531
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
	ld [$cb0c], a ; $456d
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
	farcall FarPtr_FillTilemapRect ; $458b
	ld a, $00 ; $458e
	ld d, $04 ; $4590
	farcall FarPtr_LoadIndexedPalette_18 ; $4592
	ld a, $00 ; $4595
	ld d, $05 ; $4597
	farcall FarPtr_LoadIndexedPalette_18 ; $4599
	ld a, $00 ; $459c
	ld d, $06 ; $459e
	farcall FarPtr_LoadIndexedPalette_18 ; $45a0
	ld a, $00 ; $45a3
	ld d, $07 ; $45a5
	farcall FarPtr_LoadIndexedPalette_18 ; $45a7
	call LoadMatchResultPalettes ; $45aa
	call Func_16_4a56 ; $45ad
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
	farcall FarPtr_LoadCompressedTileBlock ; $45fc
	pop af ; $45ff
	wram_bank ; $4600
	farcall FarPtr_QueueWram3MapToVRAM ; $4604
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
	farcall FarPtr_LoadScreenAssetRecord ; $4914
	jr Label_16_4920 ; $4917
Label_16_4919:
	ld c, $13 ; $4919
	farcall FarPtr_LoadScreenAssetRecord ; $491b
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
	farcall FarPtr_CopyTilemapRect ; $4938
	ld hl, $d680 ; $493b
	ld de, $d48b ; $493e
	ld b, $09 ; $4941
	ld c, $05 ; $4943
	farcall FarPtr_CopyTilemapRect ; $4945
	ld hl, $d289 ; $4948
	ld de, $d161 ; $494b
	ld b, $08 ; $494e
	ld c, $05 ; $4950
	farcall FarPtr_CopyTilemapRect ; $4952
	ld hl, $d689 ; $4955
	ld de, $d561 ; $4958
	ld b, $08 ; $495b
	ld c, $05 ; $495d
	farcall FarPtr_CopyTilemapRect ; $495f
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
	farcall FarPtr_FillTilemapRect ; $497a
	ld de, $d48f ; $497d
	ld b, $04 ; $4980
	ld c, $04 ; $4982
	ld h, $0d ; $4984
	farcall FarPtr_FillTilemapRect ; $4986
	ld de, $d582 ; $4989
	ld b, $03 ; $498c
	ld c, $03 ; $498e
	ld h, $0e ; $4990
	farcall FarPtr_FillTilemapRect ; $4992
	ld de, $d585 ; $4995
	ld b, $03 ; $4998
	ld c, $03 ; $499a
	ld h, $0f ; $499c
	farcall FarPtr_FillTilemapRect ; $499e
	jr Label_16_49bb ; $49a1
Label_16_49a3:
	ld de, $d48d ; $49a3
	ld b, $04 ; $49a6
	ld c, $04 ; $49a8
	ld h, $0c ; $49aa
	farcall FarPtr_FillTilemapRect ; $49ac
	ld de, $d583 ; $49af
	ld b, $03 ; $49b2
	ld c, $03 ; $49b4
	ld h, $0e ; $49b6
	farcall FarPtr_FillTilemapRect ; $49b8
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
	farcall FarPtr_FillTilemapRect ; $49cd
	ld de, $d4af ; $49d0
	ld b, $03 ; $49d3
	ld c, $03 ; $49d5
	ld h, $0d ; $49d7
	farcall FarPtr_FillTilemapRect ; $49d9
	ld de, $d582 ; $49dc
	ld b, $03 ; $49df
	ld c, $03 ; $49e1
	ld h, $0e ; $49e3
	farcall FarPtr_FillTilemapRect ; $49e5
	ld de, $d585 ; $49e8
	ld b, $03 ; $49eb
	ld c, $03 ; $49ed
	ld h, $0f ; $49ef
	farcall FarPtr_FillTilemapRect ; $49f1
	jr Label_16_4a0e ; $49f4
Label_16_49f6:
	ld de, $d4ad ; $49f6
	ld b, $03 ; $49f9
	ld c, $03 ; $49fb
	ld h, $0c ; $49fd
	farcall FarPtr_FillTilemapRect ; $49ff
	ld de, $d583 ; $4a02
	ld b, $03 ; $4a05
	ld c, $03 ; $4a07
	ld h, $0e ; $4a09
	farcall FarPtr_FillTilemapRect ; $4a0b
Label_16_4a0e:
	ret ; $4a0e
LoadMatchResultPalettes:
	ld a, [wMatchWinLoseFlag] ; $4a0f
	cp a, $ff ; $4a12
	jr z, Label_16_4a2e ; $4a14
	ld a, $02 ; $4a16
	ld [$cb0b], a ; $4a18
	ld hl, $4a4e ; $4a1b
	ld de, $0101 ; $4a1e
	call LoadPaletteShadow ; $4a21
	ld hl, $4a46 ; $4a24
	ld de, $0201 ; $4a27
	call LoadPaletteShadow ; $4a2a
	ret ; $4a2d
Label_16_4a2e:
	ld a, $03 ; $4a2e
	ld [$cb0b], a ; $4a30
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
Func_16_4a56:
	ld a, [wMatchWinLoseFlag] ; $4a56
	cp a, $ff ; $4a59
	jr nz, Label_16_4a6f ; $4a5b
	ld hl, $d240 ; $4a5d
	ld de, $d120 ; $4a60
	ld b, $20 ; $4a63
	ld c, $02 ; $4a65
	farcall FarPtr_CopyTilemapRect ; $4a67
	ld a, $06 ; $4a6a
	ld [$cb0c], a ; $4a6c
Label_16_4a6f:
	ret ; $4a6f
	ret ; $4a70
BuildMatchResultTilemap:
	ld a, [$c8f7] ; $4a71
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
	farcall FarPtr_CopyTilemapRect ; $4a93
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
	farcall FarPtr_CopyTilemapRect ; $4aaa
	jr Label_16_4abc ; $4aad
Label_16_4aaf:
	ld hl, $d3c0 ; $4aaf
	ld de, $d200 ; $4ab2
	ld b, $07 ; $4ab5
	ld c, $02 ; $4ab7
	farcall FarPtr_CopyTilemapRect ; $4ab9
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
	ld a, [wMatchWinLoseFlag] ; $4cb1
	cp a, $ff ; $4cb4
	jr z, Label_16_4cd1 ; $4cb6
	ld de, $0824 ; $4cb8
	call Func_16_4cea ; $4cbb
	ld de, $502c ; $4cbe
	call Func_16_4d96 ; $4cc1
	ld de, $5060 ; $4cc4
	call Func_16_4d45 ; $4cc7
	ld de, $4e68 ; $4cca
	call Func_16_4dad ; $4ccd
	ret ; $4cd0
Label_16_4cd1:
	ld de, $5860 ; $4cd1
	call Func_16_4cea ; $4cd4
	ld de, $5068 ; $4cd7
	call Func_16_4dc7 ; $4cda
	ld de, $0024 ; $4cdd
	call Func_16_4d45 ; $4ce0
	ld de, $482c ; $4ce3
	call Func_16_4dba ; $4ce6
	ret ; $4ce9
Func_16_4cea:
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
	ld hl, $4d04 ; $4cfd
	call QueueSpriteTemplate ; $4d00
	ret ; $4d03
	; $4d04, 65 bytes (bytes:4)
	db $10, $08, $00, $00 ; 0x00
	db $20, $08, $02, $00 ; 0x04
	db $10, $10, $04, $00 ; 0x08
	db $20, $10, $06, $00 ; 0x0c
	db $10, $18, $08, $00 ; 0x10
	db $20, $18, $0a, $00 ; 0x14
	db $10, $20, $0c, $00 ; 0x18
	db $20, $20, $0e, $00 ; 0x1c
	db $10, $28, $10, $00 ; 0x20
	db $20, $28, $12, $00 ; 0x24
	db $10, $30, $14, $00 ; 0x28
	db $20, $30, $16, $00 ; 0x2c
	db $10, $38, $18, $00 ; 0x30
	db $20, $38, $1a, $00 ; 0x34
	db $10, $40, $1c, $00 ; 0x38
	db $20, $40, $1e, $00 ; 0x3c
	db $80 ; 0x40
Func_16_4d45:
	call GetResultSpriteWobbleOffset ; $4d45
	add a, d ; $4d48
	ld d, a ; $4d49
	ld c, $20 ; $4d4a
	ld b, $09 ; $4d4c
	ld hl, $4d55 ; $4d4e
	call QueueSpriteTemplate ; $4d51
	ret ; $4d54
	; $4d55, 65 bytes (bytes:4)
	db $10, $08, $00, $00 ; 0x00
	db $20, $08, $02, $00 ; 0x04
	db $10, $10, $04, $00 ; 0x08
	db $20, $10, $06, $00 ; 0x0c
	db $10, $18, $08, $00 ; 0x10
	db $20, $18, $0a, $00 ; 0x14
	db $10, $20, $0c, $00 ; 0x18
	db $20, $20, $0e, $00 ; 0x1c
	db $10, $28, $10, $00 ; 0x20
	db $20, $28, $12, $00 ; 0x24
	db $10, $30, $14, $00 ; 0x28
	db $20, $30, $16, $00 ; 0x2c
	db $10, $38, $18, $00 ; 0x30
	db $20, $38, $1a, $00 ; 0x34
	db $10, $40, $1c, $00 ; 0x38
	db $20, $40, $1e, $00 ; 0x3c
	db $80 ; 0x40
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
	farcall FarPtr_FillTilemapRect ; $4e07
	ld de, $d600 ; $4e0a
	ld b, $14 ; $4e0d
	ld c, $02 ; $4e0f
	ld h, $0b ; $4e11
	farcall FarPtr_FillTilemapRect ; $4e13
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
	ld a, [$c8f7] ; $4e54
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
	farcall FarPtr_01_0a ; $5c38
	wram_bank $03 ; $5c3b
	ld a, $01 ; $5c41
	ld [$d801], a ; $5c43
	call InitMatchStatsScreen ; $5c46
	call LoadMatchResultPalettes ; $5c49
	ld a, $01 ; $5c4c
	ld hl, $43f6 ; $5c4e
	call RegisterFrameTask ; $5c51
	call EnableLCD ; $5c54
	ld c, $10 ; $5c57
	call BeginFadeIn ; $5c59
	call WaitFadeEnd ; $5c5c
Label_16_5c5f:
	call PrintMatchSetScores ; $5c5f
	ldh a, [hInputPressed] ; $5c62
	bit 5, a ; $5c64
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
	farcall FarPtr_LoadScreenAssetRecord ; $5c8c
	ld de, $a000 ; $5c8f
	ld c, $00 ; $5c92
	ld b, $08 ; $5c94
	farcall FarPtr_39_64 ; $5c96
	ld a, $00 ; $5c99
	ld d, $04 ; $5c9b
	farcall FarPtr_LoadIndexedPalette_18 ; $5c9d
	ld a, $00 ; $5ca0
	ld d, $05 ; $5ca2
	farcall FarPtr_LoadIndexedPalette_18 ; $5ca4
	ld a, $00 ; $5ca7
	ld d, $06 ; $5ca9
	farcall FarPtr_LoadIndexedPalette_18 ; $5cab
	ld a, $00 ; $5cae
	ld d, $07 ; $5cb0
	farcall FarPtr_LoadIndexedPalette_18 ; $5cb2
	wram_bank $03 ; $5cb5
	call Func_16_5f92 ; $5cbb
	call LoadResultScreenTileGraphics ; $5cbe
	ld de, $d600 ; $5cc1
	ld b, $14 ; $5cc4
	ld c, $02 ; $5cc6
	ld h, $08 ; $5cc8
	farcall FarPtr_FillTilemapRect ; $5cca
	call SetMatchStatsPortraitPaletteAttrs ; $5ccd
	ld c, $01 ; $5cd0
	call LoadResultScreenPortraits ; $5cd2
	call PrintMatchStatistics ; $5cd5
	farcall FarPtr_QueueWram3MapToVRAM ; $5cd8
	ret ; $5cdb
SetMatchStatsPortraitPaletteAttrs:
	ld de, $002f ; $5cdc
	call TestGameFlagByNumber ; $5cdf
	jr z, Label_16_5d16 ; $5ce2
	ld de, $d481 ; $5ce4
	ld b, $03 ; $5ce7
	ld c, $03 ; $5ce9
	ld h, $0c ; $5ceb
	farcall FarPtr_FillTilemapRect ; $5ced
	ld de, $d484 ; $5cf0
	ld b, $03 ; $5cf3
	ld c, $03 ; $5cf5
	ld h, $0d ; $5cf7
	farcall FarPtr_FillTilemapRect ; $5cf9
	ld de, $d48d ; $5cfc
	ld b, $03 ; $5cff
	ld c, $03 ; $5d01
	ld h, $0e ; $5d03
	farcall FarPtr_FillTilemapRect ; $5d05
	ld de, $d490 ; $5d08
	ld b, $03 ; $5d0b
	ld c, $03 ; $5d0d
	ld h, $0f ; $5d0f
	farcall FarPtr_FillTilemapRect ; $5d11
	jr Label_16_5d2e ; $5d14
Label_16_5d16:
	ld de, $d482 ; $5d16
	ld b, $03 ; $5d19
	ld c, $03 ; $5d1b
	ld h, $0c ; $5d1d
	farcall FarPtr_FillTilemapRect ; $5d1f
	ld de, $d48e ; $5d22
	ld b, $03 ; $5d25
	ld c, $03 ; $5d27
	ld h, $0e ; $5d29
	farcall FarPtr_FillTilemapRect ; $5d2b
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
	farcall FarPtr_PrintNumberRightAligned ; $5d4f
	ld a, [wCharacter1SmashAces] ; $5d52
	ld h, $00 ; $5d55
	ld l, a ; $5d57
	ld bc, $d810 ; $5d58
	ld de, $d183 ; $5d5b
	farcall FarPtr_PrintNumberRightAligned ; $5d5e
	ld a, [wCharacter1ReturnAces] ; $5d61
	ld h, $00 ; $5d64
	ld l, a ; $5d66
	ld bc, $d810 ; $5d67
	ld de, $d1a3 ; $5d6a
	farcall FarPtr_PrintNumberRightAligned ; $5d6d
	ld a, [wCharacter1LobShotWinners] ; $5d70
	ld h, $00 ; $5d73
	ld l, a ; $5d75
	ld bc, $d810 ; $5d76
	ld de, $d1c3 ; $5d79
	farcall FarPtr_PrintNumberRightAligned ; $5d7c
	ld a, [wCharacter1DropShotWinners] ; $5d7f
	ld h, $00 ; $5d82
	ld l, a ; $5d84
	ld bc, $d810 ; $5d85
	ld de, $d1e3 ; $5d88
	farcall FarPtr_PrintNumberRightAligned ; $5d8b
	ld a, [wCharacter1DoubleFaults] ; $5d8e
	ld h, $00 ; $5d91
	ld l, a ; $5d93
	ld bc, $d810 ; $5d94
	ld de, $d203 ; $5d97
	farcall FarPtr_PrintNumberRightAligned ; $5d9a
	ld a, [wCharacter2ServiceAces] ; $5d9d
	ld h, $00 ; $5da0
	ld l, a ; $5da2
	ld bc, $d810 ; $5da3
	ld de, $d170 ; $5da6
	farcall FarPtr_PrintNumberRightAligned ; $5da9
	ld a, [wCharacter2SmashAces] ; $5dac
	ld h, $00 ; $5daf
	ld l, a ; $5db1
	ld bc, $d810 ; $5db2
	ld de, $d190 ; $5db5
	farcall FarPtr_PrintNumberRightAligned ; $5db8
	ld a, [wCharacter2ReturnAces] ; $5dbb
	ld h, $00 ; $5dbe
	ld l, a ; $5dc0
	ld bc, $d810 ; $5dc1
	ld de, $d1b0 ; $5dc4
	farcall FarPtr_PrintNumberRightAligned ; $5dc7
	ld a, [wCharacter2LobShotWinners] ; $5dca
	ld h, $00 ; $5dcd
	ld l, a ; $5dcf
	ld bc, $d810 ; $5dd0
	ld de, $d1d0 ; $5dd3
	farcall FarPtr_PrintNumberRightAligned ; $5dd6
	ld a, [wCharacter2DropShotWinners] ; $5dd9
	ld h, $00 ; $5ddc
	ld l, a ; $5dde
	ld bc, $d810 ; $5ddf
	ld de, $d1f0 ; $5de2
	farcall FarPtr_PrintNumberRightAligned ; $5de5
	ld a, [wCharacter2DoubleFaults] ; $5de8
	ld h, $00 ; $5deb
	ld l, a ; $5ded
	ld bc, $d810 ; $5dee
	ld de, $d210 ; $5df1
	farcall FarPtr_PrintNumberRightAligned ; $5df4
	ret ; $5df7
PrintDoublesMatchStats:
	ld a, [wCharacter1ServiceAces] ; $5df8
	ld h, $00 ; $5dfb
	ld l, a ; $5dfd
	ld bc, $d810 ; $5dfe
	ld de, $d162 ; $5e01
	farcall FarPtr_PrintNumberRightAligned ; $5e04
	ld a, [wCharacter1SmashAces] ; $5e07
	ld h, $00 ; $5e0a
	ld l, a ; $5e0c
	ld bc, $d810 ; $5e0d
	ld de, $d182 ; $5e10
	farcall FarPtr_PrintNumberRightAligned ; $5e13
	ld a, [wCharacter1ReturnAces] ; $5e16
	ld h, $00 ; $5e19
	ld l, a ; $5e1b
	ld bc, $d810 ; $5e1c
	ld de, $d1a2 ; $5e1f
	farcall FarPtr_PrintNumberRightAligned ; $5e22
	ld a, [wCharacter1LobShotWinners] ; $5e25
	ld h, $00 ; $5e28
	ld l, a ; $5e2a
	ld bc, $d810 ; $5e2b
	ld de, $d1c2 ; $5e2e
	farcall FarPtr_PrintNumberRightAligned ; $5e31
	ld a, [wCharacter1DropShotWinners] ; $5e34
	ld h, $00 ; $5e37
	ld l, a ; $5e39
	ld bc, $d810 ; $5e3a
	ld de, $d1e2 ; $5e3d
	farcall FarPtr_PrintNumberRightAligned ; $5e40
	ld a, [wCharacter1DoubleFaults] ; $5e43
	ld h, $00 ; $5e46
	ld l, a ; $5e48
	ld bc, $d810 ; $5e49
	ld de, $d202 ; $5e4c
	farcall FarPtr_PrintNumberRightAligned ; $5e4f
	ld a, [wCharacter3ServiceAces] ; $5e52
	ld h, $00 ; $5e55
	ld l, a ; $5e57
	ld bc, $d810 ; $5e58
	ld de, $d165 ; $5e5b
	farcall FarPtr_PrintNumberRightAligned ; $5e5e
	ld a, [wCharacter3SmashAces] ; $5e61
	ld h, $00 ; $5e64
	ld l, a ; $5e66
	ld bc, $d810 ; $5e67
	ld de, $d185 ; $5e6a
	farcall FarPtr_PrintNumberRightAligned ; $5e6d
	ld a, [wCharacter3ReturnAces] ; $5e70
	ld h, $00 ; $5e73
	ld l, a ; $5e75
	ld bc, $d810 ; $5e76
	ld de, $d1a5 ; $5e79
	farcall FarPtr_PrintNumberRightAligned ; $5e7c
	ld a, [wCharacter3LobShotWinners] ; $5e7f
	ld h, $00 ; $5e82
	ld l, a ; $5e84
	ld bc, $d810 ; $5e85
	ld de, $d1c5 ; $5e88
	farcall FarPtr_PrintNumberRightAligned ; $5e8b
	ld a, [wCharacter3DropShotWinners] ; $5e8e
	ld h, $00 ; $5e91
	ld l, a ; $5e93
	ld bc, $d810 ; $5e94
	ld de, $d1e5 ; $5e97
	farcall FarPtr_PrintNumberRightAligned ; $5e9a
	ld a, [wCharacter3DoubleFaults] ; $5e9d
	ld h, $00 ; $5ea0
	ld l, a ; $5ea2
	ld bc, $d810 ; $5ea3
	ld de, $d205 ; $5ea6
	farcall FarPtr_PrintNumberRightAligned ; $5ea9
	ld a, [wCharacter2ServiceAces] ; $5eac
	ld h, $00 ; $5eaf
	ld l, a ; $5eb1
	ld bc, $d810 ; $5eb2
	ld de, $d16f ; $5eb5
	farcall FarPtr_PrintNumberRightAligned ; $5eb8
	ld a, [wCharacter2SmashAces] ; $5ebb
	ld h, $00 ; $5ebe
	ld l, a ; $5ec0
	ld bc, $d810 ; $5ec1
	ld de, $d18f ; $5ec4
	farcall FarPtr_PrintNumberRightAligned ; $5ec7
	ld a, [wCharacter2ReturnAces] ; $5eca
	ld h, $00 ; $5ecd
	ld l, a ; $5ecf
	ld bc, $d810 ; $5ed0
	ld de, $d1af ; $5ed3
	farcall FarPtr_PrintNumberRightAligned ; $5ed6
	ld a, [wCharacter2LobShotWinners] ; $5ed9
	ld h, $00 ; $5edc
	ld l, a ; $5ede
	ld bc, $d810 ; $5edf
	ld de, $d1cf ; $5ee2
	farcall FarPtr_PrintNumberRightAligned ; $5ee5
	ld a, [wCharacter2DropShotWinners] ; $5ee8
	ld h, $00 ; $5eeb
	ld l, a ; $5eed
	ld bc, $d810 ; $5eee
	ld de, $d1ef ; $5ef1
	farcall FarPtr_PrintNumberRightAligned ; $5ef4
	ld a, [wCharacter2DoubleFaults] ; $5ef7
	ld h, $00 ; $5efa
	ld l, a ; $5efc
	ld bc, $d810 ; $5efd
	ld de, $d20f ; $5f00
	farcall FarPtr_PrintNumberRightAligned ; $5f03
	ld a, [wCharacter4ServiceAces] ; $5f06
	ld h, $00 ; $5f09
	ld l, a ; $5f0b
	ld bc, $d810 ; $5f0c
	ld de, $d172 ; $5f0f
	farcall FarPtr_PrintNumberRightAligned ; $5f12
	ld a, [wCharacter4SmashAces] ; $5f15
	ld h, $00 ; $5f18
	ld l, a ; $5f1a
	ld bc, $d810 ; $5f1b
	ld de, $d192 ; $5f1e
	farcall FarPtr_PrintNumberRightAligned ; $5f21
	ld a, [wCharacter4ReturnAces] ; $5f24
	ld h, $00 ; $5f27
	ld l, a ; $5f29
	ld bc, $d810 ; $5f2a
	ld de, $d1b2 ; $5f2d
	farcall FarPtr_PrintNumberRightAligned ; $5f30
	ld a, [wPlayer4LobShotWinners] ; $5f33
	ld h, $00 ; $5f36
	ld l, a ; $5f38
	ld bc, $d810 ; $5f39
	ld de, $d1d2 ; $5f3c
	farcall FarPtr_PrintNumberRightAligned ; $5f3f
	ld a, [wCharacter4DropShotWinners] ; $5f42
	ld h, $00 ; $5f45
	ld l, a ; $5f47
	ld bc, $d810 ; $5f48
	ld de, $d1f2 ; $5f4b
	farcall FarPtr_PrintNumberRightAligned ; $5f4e
	ld a, [wCharacter4DoubleFaults] ; $5f51
	ld h, $00 ; $5f54
	ld l, a ; $5f56
	ld bc, $d810 ; $5f57
	ld de, $d212 ; $5f5a
	farcall FarPtr_PrintNumberRightAligned ; $5f5d
	ret ; $5f60
ClearMatchStatsNumberArea:
	ld de, $d561 ; $5f61
	ld b, $05 ; $5f64
	ld c, $06 ; $5f66
	ld h, $00 ; $5f68
	farcall FarPtr_FillTilemapRect ; $5f6a
	ld de, $d56e ; $5f6d
	ld b, $05 ; $5f70
	ld c, $06 ; $5f72
	ld h, $00 ; $5f74
	farcall FarPtr_FillTilemapRect ; $5f76
	ld de, $d161 ; $5f79
	ld b, $05 ; $5f7c
	ld c, $06 ; $5f7e
	ld h, $20 ; $5f80
	farcall FarPtr_FillTilemapRect ; $5f82
	ld de, $d16e ; $5f85
	ld b, $05 ; $5f88
	ld c, $06 ; $5f8a
	ld h, $20 ; $5f8c
	farcall FarPtr_FillTilemapRect ; $5f8e
	ret ; $5f91
Func_16_5f92:
	ld de, $002f ; $5f92
	call TestGameFlagByNumber ; $5f95
	ret nz ; $5f98
	ld hl, $d240 ; $5f99
	ld de, $d080 ; $5f9c
	ld b, $08 ; $5f9f
	ld c, $04 ; $5fa1
	farcall FarPtr_CopyTilemapRect ; $5fa3
	ld hl, $d24c ; $5fa6
	ld de, $d08c ; $5fa9
	ld b, $08 ; $5fac
	ld c, $04 ; $5fae
	farcall FarPtr_CopyTilemapRect ; $5fb0
	ld hl, $d640 ; $5fb3
	ld de, $d480 ; $5fb6
	ld b, $08 ; $5fb9
	ld c, $04 ; $5fbb
	farcall FarPtr_CopyTilemapRect ; $5fbd
	ld hl, $d64c ; $5fc0
	ld de, $d48c ; $5fc3
	ld b, $08 ; $5fc6
	ld c, $04 ; $5fc8
	farcall FarPtr_CopyTilemapRect ; $5fca
	ret ; $5fcd
PrintMatchSetScores:
	ld a, [wPlayer1SetsWon] ; $5fce
	ld h, $00 ; $5fd1
	ld l, a ; $5fd3
	ld de, $1c48 ; $5fd4
	farcall FarPtr_DrawDecimalNumberSprites_39 ; $5fd7
	ld a, [wPlayer2SetsWon] ; $5fda
	ld h, $00 ; $5fdd
	ld l, a ; $5fdf
	ld de, $8448 ; $5fe0
	farcall FarPtr_DrawDecimalNumberSprites_39 ; $5fe3
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
	farcall FarPtr_LoadIndexedPalette_18 ; $607a
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
	farcall FarPtr_RemapExtendedCharId ; $60cd
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
	ld hl, $6968 ; $6959
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
	; $6968, 2744 bytes (records:2)
	dw $69a8 ; record 0
	dw $6a46 ; record 1
	dw $6ae9 ; record 2
	dw $6b7b ; record 3
	dw $6c20 ; record 4
	dw $6ca6 ; record 5
	dw $6d3a ; record 6
	dw $6dca ; record 7
	dw $6e53 ; record 8
	dw $6ee0 ; record 9
	dw $6f73 ; record 10
	dw $7006 ; record 11
	dw $70a7 ; record 12
	dw $7148 ; record 13
	dw $71e5 ; record 14
	dw $727b ; record 15
	dw $7310 ; record 16
	dw $73b2 ; record 17
	dw $7449 ; record 18
	dw $74dc ; record 19
	dw $7555 ; record 20
	dw $7555 ; record 21
	dw $7555 ; record 22
	dw $75d3 ; record 23
	dw $766d ; record 24
	dw $7709 ; record 25
	dw $77a4 ; record 26
	dw $7846 ; record 27
	dw $78e4 ; record 28
	dw $796f ; record 29
	dw $7a14 ; record 30
	dw $7ab6 ; record 31
	dw $ffff ; record 32
	dw $8b00 ; record 33
	dw $9718 ; record 34
	dw $af30 ; record 35
	dw $ff20 ; record 36
	dw $60af ; record 37
	dw $40cf ; record 38
	dw $40ee ; record 39
	dw $41f5 ; record 40
	dw $ffff ; record 41
	dw $ff00 ; record 42
	dw $d71f ; record 43
	dw $ef10 ; record 44
	dw $bf20 ; record 45
	dw $27f3 ; record 46
	dw $3fbf ; record 47
	dw $ff7f ; record 48
	dw $e0ff ; record 49
	dw $ff00 ; record 50
	dw $9891 ; record 51
	dw $6c49 ; record 52
	dw $24b5 ; record 53
	dw $e6bd ; record 54
	dw $f3ff ; record 55
	dw $fbf2 ; record 56
	dw $fffa ; record 57
	dw $b3fe ; record 58
	dw $ff43 ; record 59
	dw $07b7 ; record 60
	dw $0ff7 ; record 61
	dw $0fff ; record 62
	dw $0fae ; record 63
	dw $aeff ; record 64
	dw $dc1f ; record 65
	dw $e47f ; record 66
	dw $fc7f ; record 67
	dw $ffff ; record 68
	dw $fff8 ; record 69
	dw $ffb0 ; record 70
	dw $ff60 ; record 71
	dw $fff0 ; record 72
	dw $38ff ; record 73
	dw $c4ff ; record 74
	dw $78ff ; record 75
	dw $ffff ; record 76
	dw $fffe ; record 77
	dw $fe3f ; record 78
	dw $fe1f ; record 79
	dw $fe0f ; record 80
	dw $fe2f ; record 81
	dw $7dff ; record 82
	dw $8dfe ; record 83
	dw $f7fc ; record 84
	dw $c8fe ; record 85
	dw $fd7f ; record 86
	dw $fec4 ; record 87
	dw $a0e0 ; record 88
	dw $dc3f ; record 89
	dw $fa1f ; record 90
	dw $9f03 ; record 91
	dw $07f3 ; record 92
	dw $00ff ; record 93
	dw $9f61 ; record 94
	dw $fee0 ; record 95
	dw $18e1 ; record 96
	dw $fffb ; record 97
	dw $9506 ; record 98
	dw $ffe0 ; record 99
	dw $6500 ; record 100
	dw $c5fe ; record 101
	dw $feff ; record 102
	dw $fe45 ; record 103
	dw $fe87 ; record 104
	dw $fc09 ; record 105
	dw $1f09 ; record 106
	dw $31f8 ; record 107
	dw $fff0 ; record 108
	dw $0000 ; record 109
	dw $0000 ; record 110
	dw $ffff ; record 111
	dw $8300 ; record 112
	dw $8c07 ; record 113
	dw $901f ; record 114
	dw $ff3f ; record 115
	dw $3fa0 ; record 116
	dw $7fa0 ; record 117
	dw $7fc0 ; record 118
	dw $7fc3 ; record 119
	dw $ff7f ; record 120
	dw $0900 ; record 121
	dw $04ff ; record 122
	dw $02ff ; record 123
	dw $e0fe ; record 124
	dw $01ff ; record 125
	dw $79ff ; record 126
	dw $a7ff ; record 127
	dw $ff8f ; record 128
	dw $ff00 ; record 129
	dw $fc99 ; record 130
	dw $fc65 ; record 131
	dw $f859 ; record 132
	dw $fca9 ; record 133
	dw $45ff ; record 134
	dw $e5fc ; record 135
	dw $93fc ; record 136
	dw $a4be ; record 137
	dw $ff7e ; record 138
	dw $7ca7 ; record 139
	dw $7ccb ; record 140
	dw $798c ; record 141
	dw $7a88 ; record 142
	dw $d7ff ; record 143
	dw $fe71 ; record 144
	dw $b677 ; record 145
	dw $fd13 ; record 146
	dw $ff01 ; record 147
	dw $00ff ; record 148
	dw $00ff ; record 149
	dw $e00f ; record 150
	dw $10cf ; record 151
	dw $dfff ; record 152
	dw $6fc0 ; record 153
	dw $eee0 ; record 154
	dw $6bb0 ; record 155
	dw $ff0e ; record 156
	dw $0efb ; record 157
	dw $0ef5 ; record 158
	dw $7605 ; record 159
	dw $8e6f ; record 160
	dw $bdff ; record 161
	dw $4d74 ; record 162
	dw $ffde ; record 163
	dw $f6aa ; record 164
	dw $ff3b ; record 165
	dw $1bcf ; record 166
	dw $49f8 ; record 167
	dw $7cbb ; record 168
	dw $0485 ; record 169
	dw $82ff ; record 170
	dw $8107 ; record 171
	dw $ff03 ; record 172
	dw $df00 ; record 173
	dw $efd1 ; record 174
	dw $d17f ; record 175
	dw $f1ee ; record 176
	dw $e0cc ; record 177
	dw $f901 ; record 178
	dw $ff0e ; record 179
	dw $84b6 ; record 180
	dw $00ff ; record 181
	dw $ee6b ; record 182
	dw $f635 ; record 183
	dw $d9ff ; record 184
	dw $e9ec ; record 185
	dw $5188 ; record 186
	dw $a118 ; record 187
	dw $0f30 ; record 188
	dw $e0c1 ; record 189
	dw $00ff ; record 190
	dw $0000 ; record 191
	dw $ff00 ; record 192
	dw $00ff ; record 193
	dw $7fff ; record 194
	dw $7fbf ; record 195
	dw $3e9c ; record 196
	dw $97ff ; record 197
	dw $9f18 ; record 198
	dw $9a10 ; record 199
	dw $9712 ; record 200
	dw $ac17 ; record 201
	dw $e0f0 ; record 202
	dw $e0ff ; record 203
	dw $00fe ; record 204
	dw $e0e8 ; record 205
	dw $fa00 ; record 206
	dw $ffe0 ; record 207
	dw $ffff ; record 208
	dw $fd00 ; record 209
	dw $f9fe ; record 210
	dw $71fc ; record 211
	dw $fff8 ; record 212
	dw $30d1 ; record 213
	dw $10f1 ; record 214
	dw $90b1 ; record 215
	dw $d0d1 ; record 216
	dw $dfff ; record 217
	dw $bb7f ; record 218
	dw $9d7f ; record 219
	dw $df7d ; record 220
	dw $df7a ; record 221
	dw $7bff ; record 222
	dw $7fdf ; record 223
	dw $fe98 ; record 224
	dw $87e0 ; record 225
	dw $ffff ; record 226
	dw $ffcf ; record 227
	dw $fda5 ; record 228
	dw $facf ; record 229
	dw $fbcf ; record 230
	dw $cfff ; record 231
	dw $48ff ; record 232
	dw $40ff ; record 233
	dw $f7ff ; record 234
	dw $fffe ; record 235
	dw $fe39 ; record 236
	dw $feb1 ; record 237
	dw $fef7 ; record 238
	dw $fefd ; record 239
	dw $f5ff ; record 240
	dw $31fe ; record 241
	dw $33fe ; record 242
	dw $f8fe ; record 243
	dw $fb7f ; record 244
	dw $1f98 ; record 245
	dw $e3fe ; record 246
	dw $1f9c ; record 247
	dw $1f9e ; record 248
	dw $bfff ; record 249
	dw $4000 ; record 250
	dw $50ff ; record 251
	dw $60ff ; record 252
	dw $e08b ; record 253
	dw $fb38 ; record 254
	dw $44ff ; record 255
	dw $e195 ; record 256
	dw $3d00 ; record 257
	dw $31fe ; record 258
	dw $7ef0 ; record 259
	dw $e3fe ; record 260
	dw $f071 ; record 261
	dw $f0f1 ; record 262
	dw $00ff ; record 263
	dw $0000 ; record 264
	dw $ff00 ; record 265
	dw $00ff ; record 266
	dw $7f80 ; record 267
	dw $7f9f ; record 268
	dw $73e6 ; record 269
	dw $fcff ; record 270
	dw $f407 ; record 271
	dw $f907 ; record 272
	dw $fb0f ; record 273
	dw $ff7f ; record 274
	dw $00ff ; record 275
	dw $ff88 ; record 276
	dw $ff10 ; record 277
	dw $ff33 ; record 278
	dw $64ff ; record 279
	dw $abfe ; record 280
	dw $d7b8 ; record 281
	dw $df70 ; record 282
	dw $ffff ; record 283
	dw $00ff ; record 284
	dw $fe01 ; record 285
	dw $fee1 ; record 286
	dw $be19 ; record 287
	dw $f5ff ; record 288
	dw $ff06 ; record 289
	dw $fd06 ; record 290
	dw $cd06 ; record 291
	dw $ffe4 ; record 292
	dw $7e94 ; record 293
	dw $7c97 ; record 294
	dw $789b ; record 295
	dw $7a9e ; record 296
	dw $8bff ; record 297
	dw $8779 ; record 298
	dw $847f ; record 299
	dw $837d ; record 300
	dw $ff7e ; record 301
	dw $f067 ; record 302
	dw $6ca3 ; record 303
	dw $7473 ; record 304
	dw $a8af ; record 305
	dw $f7ff ; record 306
	dw $efd0 ; record 307
	dw $bee8 ; record 308
	dw $ffe8 ; record 309
	dw $fff9 ; record 310
	dw $3eb5 ; record 311
	dw $de0b ; record 312
	dw $8e3b ; record 313
	dw $2ea9 ; record 314
	dw $7dff ; record 315
	dw $e95e ; record 316
	dw $bdfe ; record 317
	dw $d1fe ; record 318
	dw $fffe ; record 319
	dw $7f8a ; record 320
	dw $7f89 ; record 321
	dw $7f84 ; record 322
	dw $7f87 ; record 323
	dw $c2ff ; record 324
	dw $b17e ; record 325
	dw $8f7f ; record 326
	dw $ff1f ; record 327
	dw $ff00 ; record 328
	dw $01ff ; record 329
	dw $007f ; record 330
	dw $80bf ; record 331
	dw $c0fe ; record 332
	dw $e0ff ; record 333
	dw $300d ; record 334
	dw $ce86 ; record 335
	dw $ffe0 ; record 336
	dw $ff00 ; record 337
	dw $1e71 ; record 338
	dw $9ef5 ; record 339
	dw $9ed5 ; record 340
	dw $3ee5 ; record 341
	dw $adff ; record 342
	dw $573e ; record 343
	dw $e57e ; record 344
	dw $fff6 ; record 345
	dw $0000 ; record 346
	dw $0000 ; record 347
	dw $ffff ; record 348
	dw $8100 ; record 349
	dw $8f03 ; record 350
	dw $bf1f ; record 351
	dw $7d7f ; record 352
	dw $feff ; record 353
	dw $f8e2 ; record 354
	dw $ff7f ; record 355
	dw $ff00 ; record 356
	dw $e8ff ; record 357
	dw $f3fe ; record 358
	dw $00e0 ; record 359
	dw $e0c1 ; record 360
	dw $f8f1 ; record 361
	dw $fefd ; record 362
	dw $fffd ; record 363
	dw $e2fe ; record 364
	dw $fe0f ; record 365
	dw $7fc0 ; record 366
	dw $7fc0 ; record 367
	dw $c7ff ; record 368
	dw $fc7f ; record 369
	dw $db7e ; record 370
	dw $ef38 ; record 371
	dw $df18 ; record 372
	dw $48ff ; record 373
	dw $20b7 ; record 374
	dw $cf00 ; record 375
	dw $10e3 ; record 376
	dw $ffff ; record 377
	dw $ff30 ; record 378
	dw $fd30 ; record 379
	dw $ff02 ; record 380
	dw $0303 ; record 381
	dw $feff ; record 382
	dw $fe03 ; record 383
	dw $fefb ; record 384
	dw $4ee7 ; record 385
	dw $fffd ; record 386
	dw $ffc6 ; record 387
	dw $fdc4 ; record 388
	dw $7b04 ; record 389
	dw $df02 ; record 390
	dw $dffe ; record 391
	dw $d7e0 ; record 392
	dw $eb10 ; record 393
	dw $8678 ; record 394
	dw $810e ; record 395
	dw $03e7 ; record 396
	dw $0782 ; record 397
	dw $e0a2 ; record 398
	dw $e3fe ; record 399
	dw $ff1f ; record 400
	dw $ef00 ; record 401
	dw $80bf ; record 402
	dw $f066 ; record 403
	dw $e092 ; record 404
	dw $7f82 ; record 405
	dw $ff82 ; record 406
	dw $02fb ; record 407
	dw $06fd ; record 408
	dw $0ce5 ; record 409
	dw $38b9 ; record 410
	dw $c10f ; record 411
	dw $ffe0 ; record 412
	dw $0000 ; record 413
	dw $0000 ; record 414
	dw $ffff ; record 415
	dw $8800 ; record 416
	dw $911f ; record 417
	dw $961f ; record 418
	dw $ff3e ; record 419
	dw $3cab ; record 420
	dw $30b7 ; record 421
	dw $60af ; record 422
	dw $60df ; record 423
	dw $ffff ; record 424
	dw $7100 ; record 425
	dw $8fff ; record 426
	dw $fcdf ; record 427
	dw $fb01 ; record 428
	dw $00ff ; record 429
	dw $e5fe ; record 430
	dw $fe85 ; record 431
	dw $fe43 ; record 432
	dw $ffc3 ; record 433
	dw $41fe ; record 434
	dw $c17e ; record 435
	dw $a17e ; record 436
	dw $a17e ; record 437
	dw $3eff ; record 438
	dw $4ce3 ; record 439
	dw $48b3 ; record 440
	dw $14ab ; record 441
	dw $fffb ; record 442
	dw $b354 ; record 443
	dw $af7c ; record 444
	dw $df3c ; record 445
	dw $bf3c ; record 446
	dw $dafe ; record 447
	dw $f0e0 ; record 448
	dw $f00e ; record 449
	dw $f305 ; record 450
	dw $df08 ; record 451
	dw $28ff ; record 452
	dw $1edc ; record 453
	dw $0ffb ; record 454
	dw $0ff7 ; record 455
	dw $ffe1 ; record 456
	dw $d13e ; record 457
	dw $711e ; record 458
	dw $291e ; record 459
	dw $6bde ; record 460
	dw $8eff ; record 461
	dw $8c7d ; record 462
	dw $087f ; record 463
	dw $02fb ; record 464
	dw $ffbf ; record 465
	dw $ff40 ; record 466
	dw $df40 ; record 467
	dw $bc40 ; record 468
	dw $ae61 ; record 469
	dw $21df ; record 470
	dw $3096 ; record 471
	dw $188b ; record 472
	dw $e5aa ; record 473
	dw $803f ; record 474
	dw $1fef ; record 475
	dw $3fe0 ; record 476
	dw $9c80 ; record 477
	dw $fde1 ; record 478
	dw $fb04 ; record 479
	dw $04ff ; record 480
	dw $00fd ; record 481
	dw $1eef ; record 482
	dw $1ed1 ; record 483
	dw $1fa7 ; record 484
	dw $493e ; record 485
	dw $ff7c ; record 486
	dw $0000 ; record 487
	dw $0000 ; record 488
	dw $ff7f ; record 489
	dw $8f00 ; record 490
	dw $bf1f ; record 491
	dw $ff7f ; record 492
	dw $e2fe ; record 493
	dw $fe7f ; record 494
	dw $f07f ; record 495
	dw $ff7f ; record 496
	dw $ff00 ; record 497
	dw $e4ff ; record 498
	dw $e0f9 ; record 499
	dw $e0f5 ; record 500
	dw $e0f3 ; record 501
	dw $fd00 ; record 502
	dw $fffe ; record 503
	dw $fffe ; record 504
	dw $fefd ; record 505
	dw $fcfd ; record 506
	dw $fc09 ; record 507
	dw $f809 ; record 508
	dw $09ff ; record 509
	dw $a0f8 ; record 510
	dw $a17f ; record 511
	dw $963f ; record 512
	dw $ff3e ; record 513
	dw $1c9b ; record 514
	dw $389f ; record 515
	dw $68af ; record 516
	dw $40d7 ; record 517
	dw $ffff ; record 518
	dw $0f50 ; record 519
	dw $f7ff ; record 520
	dw $fff1 ; record 521
	dw $fec0 ; record 522
	dw $e2d5 ; record 523
	dw $fb01 ; record 524
	dw $fde4 ; record 525
	dw $f906 ; record 526
	dw $fff8 ; record 527
	dw $8ce9 ; record 528
	dw $0efd ; record 529
	dw $0afb ; record 530
	dw $0aff ; record 531
	dw $ffff ; record 532
	dw $ffca ; record 533
	dw $fb0a ; record 534
	dw $ef0a ; record 535
	dw $ff48 ; record 536
	dw $40d7 ; record 537
	dw $64ab ; record 538
	dw $3293 ; record 539
	dw $1e8e ; record 540
	dw $812f ; record 541
	dw $8003 ; record 542
	dw $a201 ; record 543
	dw $02e0 ; record 544
	dw $e0fe ; record 545
	dw $e1a7 ; record 546
	dw $0edf ; record 547
	dw $007f ; record 548
	dw $80bf ; record 549
	dw $e0a2 ; record 550
	dw $f90e ; record 551
	dw $0cff ; record 552
	dw $08e9 ; record 553
	dw $18e9 ; record 554
	dw $10d1 ; record 555
	dw $1fa1 ; record 556
	dw $4130 ; record 557
	dw $ff60 ; record 558
	dw $0000 ; record 559
	dw $0000 ; record 560
	dw $ff5f ; record 561
	dw $a000 ; record 562
	dw $c07f ; record 563
	dw $e0fe ; record 564
	dw $fe80 ; record 565
	dw $efe4 ; record 566
	dw $00ff ; record 567
	dw $ff00 ; record 568
	dw $e5fe ; record 569
	dw $ff07 ; record 570
	dw $ff38 ; record 571
	dw $ffff ; record 572
	dw $2100 ; record 573
	dw $11f0 ; record 574
	dw $11f0 ; record 575
	dw $f8ff ; record 576
	dw $f809 ; record 577
	dw $fc09 ; record 578
	dw $fcf5 ; record 579
	dw $f70d ; record 580
	dw $fffc ; record 581
	dw $fe7f ; record 582
	dw $dae3 ; record 583
	dw $f766 ; record 584
	dw $ff52 ; record 585
	dw $48fd ; record 586
	dw $48f7 ; record 587
	dw $ffc0 ; record 588
	dw $fffe ; record 589
	dw $d9ff ; record 590
	dw $7fc3 ; record 591
	dw $dd80 ; record 592
	dw $ff1c ; record 593
	dw $fe32 ; record 594
	dw $e0d1 ; record 595
	dw $0338 ; record 596
	dw $01fe ; record 597
	dw $fffe ; record 598
	dw $fffe ; record 599
	dw $0ee9 ; record 600
	dw $06f5 ; record 601
	dw $3ed7 ; record 602
	dw $2cbd ; record 603
	dw $f5ff ; record 604
	dw $df74 ; record 605
	dw $f760 ; record 606
	dw $fb78 ; record 607
	dw $ff78 ; record 608
	dw $7cfd ; record 609
	dw $7ffe ; record 610
	dw $7fbb ; record 611
	dw $3fbe ; record 612
	dw $ffef ; record 613
	dw $d700 ; record 614
	dw $a130 ; record 615
	dw $18e4 ; record 616
	dw $81bd ; record 617
	dw $fefd ; record 618
	dw $e0a2 ; record 619
	dw $7cf9 ; record 620
	dw $68a9 ; record 621
	dw $18f1 ; record 622
	dw $e17f ; record 623
	dw $4130 ; record 624
	dw $8160 ; record 625
	dw $01c0 ; record 626
	dw $e085 ; record 627
	dw $0000 ; record 628
	dw $ff00 ; record 629
	dw $00ff ; record 630
	dw $1f90 ; record 631
	dw $1f90 ; record 632
	dw $1f88 ; record 633
	dw $88ff ; record 634
	dw $840f ; record 635
	dw $830f ; record 636
	dw $8407 ; record 637
	dw $ef0e ; record 638
	dw $00ff ; record 639
	dw $ff00 ; record 640
	dw $e1fe ; record 641
	dw $ff02 ; record 642
	dw $ff05 ; record 643
	dw $1aff ; record 644
	dw $e7f8 ; record 645
	dw $fff0 ; record 646
	dw $2100 ; record 647
	dw $e0ff ; record 648
	dw $f021 ; record 649
	dw $f011 ; record 650
	dw $fc19 ; record 651
	dw $ff2d ; record 652
	dw $dbe4 ; record 653
	dw $7fea ; record 654
	dw $8b52 ; record 655
	dw $9718 ; record 656
	dw $18ff ; record 657
	dw $309f ; record 658
	dw $30af ; record 659
	dw $20af ; record 660
	dw $9f93 ; record 661
	dw $8f38 ; record 662
	dw $8f1f ; record 663
	dw $d308 ; record 664
	dw $fce2 ; record 665
	dw $bfe4 ; record 666
	dw $c0ff ; record 667
	dw $00ff ; record 668
	dw $12fb ; record 669
	dw $06f5 ; record 670
	dw $fff9 ; record 671
	dw $f90e ; record 672
	dw $f70e ; record 673
	dw $f50e ; record 674
	dw $fb04 ; record 675
	dw $06ff ; record 676
	dw $02fb ; record 677
	dw $3fbf ; record 678
	dw $60bf ; record 679
	dw $ffdf ; record 680
	dw $ff40 ; record 681
	dw $df40 ; record 682
	dw $bf40 ; record 683
	dw $af60 ; record 684
	dw $70f5 ; record 685
	dw $e0a5 ; record 686
	dw $ceff ; record 687
	dw $ffe9 ; record 688
	dw $bb00 ; record 689
	dw $ff82 ; record 690
	dw $467b ; record 691
	dw $06f5 ; record 692
	dw $0efb ; record 693
	dw $0eeb ; record 694
	dw $d53f ; record 695
	dw $a53e ; record 696
	dw $ff3e ; record 697
	dw $0000 ; record 698
	dw $0000 ; record 699
	dw $ffff ; record 700
	dw $8400 ; record 701
	dw $880f ; record 702
	dw $b81f ; record 703
	dw $ff7f ; record 704
	dw $7fd0 ; record 705
	dw $7f90 ; record 706
	dw $7f98 ; record 707
	dw $7796 ; record 708
	dw $ffef ; record 709
	dw $0000 ; record 710
	dw $feff ; record 711
	dw $02e1 ; record 712
	dw $0dff ; record 713
	dw $fdff ; record 714
	dw $f137 ; record 715
	dw $c1df ; record 716
	dw $00ff ; record 717
	dw $ef1d ; record 718
	dw $03fe ; record 719
	dw $01fe ; record 720
	dw $e6fe ; record 721
	dw $71ad ; record 722
	dw $ffaf ; record 723
	dw $bf60 ; record 724
	dw $a360 ; record 725
	dw $bb78 ; record 726
	dw $ff64 ; record 727
	dw $78ff ; record 728
	dw $64ed ; record 729
	dw $6ebf ; record 730
	dw $017f ; record 731
	dw $fefe ; record 732
	dw $e0cf ; record 733
	dw $18c7 ; record 734
	dw $20df ; record 735
	dw $1cfd ; record 736
	dw $ffff ; record 737
	dw $ff2c ; record 738
	dw $011c ; record 739
	dw $81fe ; record 740
	dw $9dfe ; record 741
	dw $feff ; record 742
	dw $726b ; record 743
	dw $2abf ; record 744
	dw $12f7 ; record 745
	dw $ffef ; record 746
	dw $fb12 ; record 747
	dw $af02 ; record 748
	dw $9c3e ; record 749
	dw $9734 ; record 750
	dw $11ff ; record 751
	dw $1a8f ; record 752
	dw $0b89 ; record 753
	dw $0c85 ; record 754
	dw $dd82 ; record 755
	dw $a506 ; record 756
	dw $1ce0 ; record 757
	dw $08eb ; record 758
	dw $e29f ; record 759
	dw $ff00 ; record 760
	dw $e0fd ; record 761
	dw $e1c6 ; record 762
	dw $06f5 ; record 763
	dw $1ef9 ; record 764
	dw $1ed7 ; record 765
	dw $b9ff ; record 766
	dw $413c ; record 767
	dw $8160 ; record 768
	dw $81c0 ; record 769
	dw $0380 ; record 770
	dw $00ff ; record 771
	dw $0000 ; record 772
	dw $ff00 ; record 773
	dw $00ff ; record 774
	dw $0e8a ; record 775
	dw $0e8b ; record 776
	dw $1e8b ; record 777
	dw $93ff ; record 778
	dw $961f ; record 779
	dw $991f ; record 780
	dw $971c ; record 781
	dw $ff18 ; record 782
	dw $00ff ; record 783
	dw $ff81 ; record 784
	dw $fe86 ; record 785
	dw $fcb9 ; record 786
	dw $cfdf ; record 787
	dw $7fe0 ; record 788
	dw $ff00 ; record 789
	dw $e2fe ; record 790
	dw $fc0d ; record 791
	dw $85fd ; record 792
	dw $e0fe ; record 793
	dw $7e43 ; record 794
	dw $3ea3 ; record 795
	dw $3ed3 ; record 796
	dw $d3ff ; record 797
	dw $9f1e ; record 798
	dw $af30 ; record 799
	dw $e830 ; record 800
	dw $ff66 ; record 801
	dw $21ee ; record 802
	dw $22fa ; record 803
	dw $65ff ; record 804
	dw $23bf ; record 805
	dw $fffb ; record 806
	dw $dc23 ; record 807
	dw $f8e1 ; record 808
	dw $f903 ; record 809
	dw $fb04 ; record 810
	dw $03ff ; record 811
	dw $05ff ; record 812
	dw $03ff ; record 813
	dw $03ff ; record 814
	dw $ffeb ; record 815
	dw $eb1e ; record 816
	dw $fb0e ; record 817
	dw $fd0e ; record 818
	dw $7b0c ; record 819
	dw $087f ; record 820
	dw $8af7 ; record 821
	dw $04fd ; record 822
	dw $04fb ; record 823
	dw $e0de ; record 824
	dw $20ff ; record 825
	dw $60ff ; record 826
	dw $20af ; record 827
	dw $309f ; record 828
	dw $d797 ; record 829
	dw $8d18 ; record 830
	dw $ae1c ; record 831
	dw $03e0 ; record 832
	dw $e3aa ; record 833
	dw $00ff ; record 834
	dw $efef ; record 835
	dw $f70c ; record 836
	dw $9e10 ; record 837
	dw $f7e3 ; record 838
	dw $f906 ; record 839
	dw $08ff ; record 840
	dw $08e9 ; record 841
	dw $18d1 ; record 842
	dw $30a1 ; record 843
	dw $01ff ; record 844
	dw $0000 ; record 845
	dw $0000 ; record 846
	dw $ffff ; record 847
	dw $8c00 ; record 848
	dw $b01f ; record 849
	dw $c17f ; record 850
	dw $ff7f ; record 851
	dw $7f81 ; record 852
	dw $7f92 ; record 853
	dw $7e9a ; record 854
	dw $7697 ; record 855
	dw $ffdf ; record 856
	dw $0000 ; record 857
	dw $08ff ; record 858
	dw $e0fe ; record 859
	dw $f714 ; record 860
	dw $9aff ; record 861
	dw $6df3 ; record 862
	dw $bf61 ; record 863
	dw $ff20 ; record 864
	dw $df00 ; record 865
	dw $fe07 ; record 866
	dw $fe03 ; record 867
	dw $fe01 ; record 868
	dw $81e2 ; record 869
	dw $fffe ; record 870
	dw $fe41 ; record 871
	dw $72db ; record 872
	dw $70df ; record 873
	dw $60bf ; record 874
	dw $b1ff ; record 875
	dw $ac26 ; record 876
	dw $9f21 ; record 877
	dw $9b30 ; record 878
	dw $ff13 ; record 879
	dw $1597 ; record 880
	dw $00fd ; record 881
	dw $04f3 ; record 882
	dw $08e7 ; record 883
	dw $efff ; record 884
	dw $f710 ; record 885
	dw $ef07 ; record 886
	dw $ff0b ; record 887
	dw $ff80 ; record 888
	dw $80bf ; record 889
	dw $3ea3 ; record 890
	dw $3cd5 ; record 891
	dw $08eb ; record 892
	dw $fdff ; record 893
	dw $fb0a ; record 894
	dw $fb02 ; record 895
	dw $ff04 ; record 896
	dw $ff00 ; record 897
	dw $40bf ; record 898
	dw $188f ; record 899
	dw $088b ; record 900
	dw $0c87 ; record 901
	dw $85ff ; record 902
	dw $8304 ; record 903
	dw $8003 ; record 904
	dw $8001 ; record 905
	dw $ff00 ; record 906
	dw $00ff ; record 907
	dw $40ff ; record 908
	dw $80ff ; record 909
	dw $c05f ; record 910
	dw $bfff ; record 911
	dw $7f20 ; record 912
	dw $bf00 ; record 913
	dw $5f8c ; record 914
	dw $ffc0 ; record 915
	dw $00ff ; record 916
	dw $42fb ; record 917
	dw $86b5 ; record 918
	dw $0c75 ; record 919
	dw $d9ff ; record 920
	dw $b92c ; record 921
	dw $d928 ; record 922
	dw $5d68 ; record 923
	dw $034c ; record 924
	dw $00ff ; record 925
	dw $0000 ; record 926
	dw $ff00 ; record 927
	dw $00ff ; record 928
	dw $0785 ; record 929
	dw $0f85 ; record 930
	dw $0f88 ; record 931
	dw $88ff ; record 932
	dw $931f ; record 933
	dw $931f ; record 934
	dw $951e ; record 935
	dw $7f3c ; record 936
	dw $00ff ; record 937
	dw $ff4b ; record 938
	dw $ff8c ; record 939
	dw $fe00 ; record 940
	dw $efe0 ; record 941
	dw $ffc0 ; record 942
	dw $7f3f ; record 943
	dw $e1f7 ; record 944
	dw $f859 ; record 945
	dw $ff69 ; record 946
	dw $09f8 ; record 947
	dw $11f8 ; record 948
	dw $d1f8 ; record 949
	dw $31f0 ; record 950
	dw $b0ff ; record 951
	dw $10d1 ; record 952
	dw $3ca7 ; record 953
	dw $3ca6 ; record 954
	dw $ffab ; record 955
	dw $ab3f ; record 956
	dw $ae38 ; record 957
	dw $ad38 ; record 958
	dw $af39 ; record 959
	dw $3bff ; record 960
	dw $7bee ; record 961
	dw $00ff ; record 962
	dw $80bf ; record 963
	dw $ffef ; record 964
	dw $fff0 ; record 965
	dw $df00 ; record 966
	dw $6fc0 ; record 967
	dw $dfa0 ; record 968
	dw $d0ff ; record 969
	dw $d17e ; record 970
	dw $18f1 ; record 971
	dw $38a9 ; record 972
	dw $ff59 ; record 973
	dw $d5cc ; record 974
	dw $bd34 ; record 975
	dw $f52c ; record 976
	dw $cb76 ; record 977
	dw $7aff ; record 978
	dw $7af7 ; record 979
	dw $13b6 ; record 980
	dw $71ff ; record 981
	dw $ffd7 ; record 982
	dw $ef10 ; record 983
	dw $bb08 ; record 984
	dw $fd08 ; record 985
	dw $837c ; record 986
	dw $07ff ; record 987
	dw $00ff ; record 988
	dw $f17f ; record 989
	dw $c09f ; record 990
	dw $ffff ; record 991
	dw $fd02 ; record 992
	dw $ff01 ; record 993
	dw $f700 ; record 994
	dw $7f07 ; record 995
	dw $99fe ; record 996
	dw $bfe0 ; record 997
	dw $fb82 ; record 998
	dw $7d42 ; record 999
	dw $b746 ; record 1000
	dw $86ff ; record 1001
	dw $0cf9 ; record 1002
	dw $18e9 ; record 1003
	dw $38b1 ; record 1004
	dw $01ff ; record 1005
	dw $0000 ; record 1006
	dw $0000 ; record 1007
	dw $ffff ; record 1008
	dw $a200 ; record 1009
	dw $a23f ; record 1010
	dw $c57f ; record 1011
	dw $ff7f ; record 1012
	dw $7ec6 ; record 1013
	dw $7c8b ; record 1014
	dw $788f ; record 1015
	dw $7e96 ; record 1016
	dw $ffff ; record 1017
	dw $2800 ; record 1018
	dw $30ff ; record 1019
	dw $ceff ; record 1020
	dw $dfff ; record 1021
	dw $31f7 ; record 1022
	dw $00de ; record 1023
	dw $feff ; record 1024
	dw $89e2 ; record 1025
	dw $7ff8 ; record 1026
	dw $fc89 ; record 1027
	dw $fc85 ; record 1028
	dw $fe85 ; record 1029
	dw $fe83 ; record 1030
	dw $ffe0 ; record 1031
	dw $fe41 ; record 1032
	dw $709f ; record 1033
	dw $7e9d ; record 1034
	dw $63aa ; record 1035
	dw $dfff ; record 1036
	dw $fd45 ; record 1037
	dw $de45 ; record 1038
	dw $af43 ; record 1039
	dw $ff62 ; record 1040
	dw $3ebf ; record 1041
	dw $0ef7 ; record 1042
	dw $00ff ; record 1043
	dw $1fde ; record 1044
	dw $edff ; record 1045
	dw $bef1 ; record 1046
	dw $ff64 ; record 1047
	dw $ee24 ; record 1048
	dw $ff20 ; record 1049
	dw $11d5 ; record 1050
	dw $7e41 ; record 1051
	dw $7ec1 ; record 1052
	dw $7ea1 ; record 1053
	dw $21ff ; record 1054
	dw $d1be ; record 1055
	dw $f3fe ; record 1056
	dw $cdfe ; record 1057
	dw $ff9e ; record 1058
	dw $1075 ; record 1059
	dw $32a6 ; record 1060
	dw $319d ; record 1061
	dw $109b ; record 1062
	dw $97ff ; record 1063
	dw $8f18 ; record 1064
	dw $8b18 ; record 1065
	dw $8508 ; record 1066
	dw $ff0c ; record 1067
	dw $00ff ; record 1068
	dw $0eee ; record 1069
	dw $80b5 ; record 1070
	dw $00ff ; record 1071
	dw $fbed ; record 1072
	dw $e1a4 ; record 1073
	dw $fef0 ; record 1074
	dw $e09e ; record 1075
	dw $12eb ; record 1076
	dw $fff5 ; record 1077
	dw $f906 ; record 1078
	dw $a13c ; record 1079
	dw $c120 ; record 1080
	dw $4160 ; record 1081
	dw $401f ; record 1082
	dw $c081 ; record 1083
	dw $00ff ; record 1084
	dw $0000 ; record 1085
	dw $7f00 ; record 1086
	dw $00ff ; record 1087
	dw $7fd0 ; record 1088
	dw $7f90 ; record 1089
	dw $fe80 ; record 1090
	dw $ffe4 ; record 1091
	dw $7fa0 ; record 1092
	dw $00ff ; record 1093
	dw $ff00 ; record 1094
	dw $ff00 ; record 1095
	dw $20f5 ; record 1096
	dw $e0fe ; record 1097
	dw $fe30 ; record 1098
	dw $28e0 ; record 1099
	dw $ffef ; record 1100
	dw $5f00 ; record 1101
	dw $fe03 ; record 1102
	dw $fe13 ; record 1103
	dw $fe09 ; record 1104
	dw $05e0 ; record 1105
	dw $e0fe ; record 1106
	dw $07f7 ; record 1107
	dw $a0fe ; record 1108
	dw $e0dc ; record 1109
	dw $7fe0 ; record 1110
	dw $3fb8 ; record 1111
	dw $d7ff ; record 1112
	dw $eb1f ; record 1113
	dw $b749 ; record 1114
	dw $df29 ; record 1115
	dw $ff21 ; record 1116
	dw $ef38 ; record 1117
	dw $ff34 ; record 1118
	dw $e734 ; record 1119
	dw $f72c ; record 1120
	dw $d7ff ; record 1121
	dw $efd7 ; record 1122
	dw $afd8 ; record 1123
	dw $bfe8 ; record 1124
	dw $fde8 ; record 1125
	dw $d807 ; record 1126
	dw $1de0 ; record 1127
	dw $e5fc ; record 1128
	dw $7dec ; record 1129
	dw $ffe4 ; record 1130
	dw $74dd ; record 1131
	dw $74d5 ; record 1132
	dw $7cfd ; record 1133
	dw $01ff ; record 1134
	dw $eeff ; record 1135
	dw $b741 ; record 1136
	dw $8f70 ; record 1137
	dw $8518 ; record 1138
	dw $ef0c ; record 1139
	dw $0783 ; record 1140
	dw $0180 ; record 1141
	dw $e0a5 ; record 1142
	dw $f7e8 ; record 1143
	dw $fef8 ; record 1144
	dw $e09f ; record 1145
	dw $ff00 ; record 1146
	dw $7f0e ; record 1147
	dw $d300 ; record 1148
	dw $ffc7 ; record 1149
	dw $00ff ; record 1150
	dw $74ed ; record 1151
	dw $04f5 ; record 1152
	dw $0cf5 ; record 1153
	dw $e9ff ; record 1154
	dw $d10c ; record 1155
	dw $6118 ; record 1156
	dw $8170 ; record 1157
	dw $03c0 ; record 1158
	dw $00ff ; record 1159
	dw $0000 ; record 1160
	dw $ff00 ; record 1161
	dw $00ff ; record 1162
	dw $3f98 ; record 1163
	dw $7fa3 ; record 1164
	dw $7dfd ; record 1165
	dw $96ff ; record 1166
	dw $9f13 ; record 1167
	dw $af37 ; record 1168
	dw $af30 ; record 1169
	dw $ff20 ; record 1170
	dw $00ff ; record 1171
	dw $ff00 ; record 1172
	dw $ff87 ; record 1173
	dw $fd3a ; record 1174
	dw $cfbf ; record 1175
	dw $3fe0 ; record 1176
	dw $ff80 ; record 1177
	dw $fe00 ; record 1178
	dw $79e1 ; record 1179
	dw $fcff ; record 1180
	dw $fcfd ; record 1181
	dw $fefd ; record 1182
	dw $fe7f ; record 1183
	dw $ff7f ; record 1184
	dw $ff7e ; record 1185
	dw $bf7e ; record 1186
	dw $bf7e ; record 1187
	dw $b320 ; record 1188
	dw $28ff ; record 1189
	dw $2ca3 ; record 1190
	dw $7fbf ; record 1191
	dw $7fc0 ; record 1192
	dw $fcff ; record 1193
	dw $e0fe ; record 1194
	dw $e0fa ; record 1195
	dw $e300 ; record 1196
	dw $e304 ; record 1197
	dw $ff1c ; record 1198
	dw $d5fc ; record 1199
	dw $ffe0 ; record 1200
	dw $00e1 ; record 1201
	dw $bfff ; record 1202
	dw $fd3e ; record 1203
	dw $ff3e ; record 1204
	dw $3eff ; record 1205
	dw $fcfb ; record 1206
	dw $fa15 ; record 1207
	dw $e42d ; record 1208
	dw $37ff ; record 1209
	dw $5bec ; record 1210
	dw $ffe8 ; record 1211
	dw $bf7f ; record 1212
	dw $ff62 ; record 1213
	dw $22ae ; record 1214
	dw $33ae ; record 1215
	dw $3195 ; record 1216
	dw $1897 ; record 1217
	dw $8bb3 ; record 1218
	dw $d918 ; record 1219
	dw $aae2 ; record 1220
	dw $40e1 ; record 1221
	dw $a2bf ; record 1222
	dw $f0e1 ; record 1223
	dw $ffff ; record 1224
	dw $b500 ; record 1225
	dw $fbc8 ; record 1226
	dw $ed02 ; record 1227
	dw $ff0e ; record 1228
	dw $18f1 ; record 1229
	dw $10d1 ; record 1230
	dw $30d1 ; record 1231
	dw $30a1 ; record 1232
	dw $ff03 ; record 1233
	dw $0000 ; record 1234
	dw $0000 ; record 1235
	dw $ff7f ; record 1236
	dw $c000 ; record 1237
	dw $c07f ; record 1238
	dw $807f ; record 1239
	dw $e2fe ; record 1240
	dw $81ff ; record 1241
	dw $837f ; record 1242
	dw $ff7f ; record 1243
	dw $0000 ; record 1244
	dw $ffff ; record 1245
	dw $ff01 ; record 1246
	dw $ff0e ; record 1247
	dw $f833 ; record 1248
	dw $e05f ; record 1249
	dw $5fff ; record 1250
	dw $3fc8 ; record 1251
	dw $fff8 ; record 1252
	dw $4500 ; record 1253
	dw $fffc ; record 1254
	dw $bea3 ; record 1255
	dw $1e53 ; record 1256
	dw $0ee9 ; record 1257
	dw $0ef9 ; record 1258
	dw $f5ff ; record 1259
	dw $fd06 ; record 1260
	dw $8506 ; record 1261
	dw $c57e ; record 1262
	dw $ff7c ; record 1263
	dw $7ccb ; record 1264
	dw $78eb ; record 1265
	dw $38df ; record 1266
	dw $48ef ; record 1267
	dw $deff ; record 1268
	dw $bf61 ; record 1269
	dw $8f21 ; record 1270
	dw $77f8 ; record 1271
	dw $ff70 ; record 1272
	dw $0cf3 ; record 1273
	dw $04fb ; record 1274
	dw $18df ; record 1275
	dw $686f ; record 1276
	dw $ffff ; record 1277
	dw $ffe8 ; record 1278
	dw $fb68 ; record 1279
	dw $fb06 ; record 1280
	dw $ff02 ; record 1281
	dw $c23f ; record 1282
	dw $827f ; record 1283
	dw $c2df ; record 1284
	dw $b2ab ; record 1285
	dw $fbff ; record 1286
	dw $fdbe ; record 1287
	dw $dfb6 ; record 1288
	dw $be21 ; record 1289
	dw $ff02 ; record 1290
	dw $60df ; record 1291
	dw $79bb ; record 1292
	dw $0d84 ; record 1293
	dw $0683 ; record 1294
	dw $82ff ; record 1295
	dw $ff03 ; record 1296
	dw $7700 ; record 1297
	dw $ee98 ; record 1298
	dw $fff1 ; record 1299
	dw $05ff ; record 1300
	dw $07fa ; record 1301
	dw $80ff ; record 1302
	dw $07f0 ; record 1303
	dw $efff ; record 1304
	dw $ff1f ; record 1305
	dw $7d00 ; record 1306
	dw $b5cc ; record 1307
	dw $ff74 ; record 1308
	dw $0cf9 ; record 1309
	dw $08e9 ; record 1310
	dw $18d1 ; record 1311
	dw $30e1 ; record 1312
	dw $610f ; record 1313
	dw $ffa0 ; record 1314
	dw $0000 ; record 1315
	dw $0000 ; record 1316
	dw $ffff ; record 1317
	dw $8b00 ; record 1318
	dw $931c ; record 1319
	dw $9c1b ; record 1320
	dw $ff3f ; record 1321
	dw $3fb0 ; record 1322
	dw $7fa0 ; record 1323
	dw $7fa0 ; record 1324
	dw $7fc0 ; record 1325
	dw $ffff ; record 1326
	dw $7f00 ; record 1327
	dw $f200 ; record 1328
	dw $0ef8 ; record 1329
	dw $f7ff ; record 1330
	dw $ff01 ; record 1331
	dw $fe00 ; record 1332
	dw $ffe2 ; record 1333
	dw $9700 ; record 1334
	dw $ff30 ; record 1335
	dw $086b ; record 1336
	dw $0ce5 ; record 1337
	dw $0655 ; record 1338
	dw $86bb ; record 1339
	dw $53df ; record 1340
	dw $4fc2 ; record 1341
	dw $c0e2 ; record 1342
	dw $e0dc ; record 1343
	dw $7fdc ; record 1344
	dw $e0ff ; record 1345
	dw $cc7f ; record 1346
	dw $d67f ; record 1347
	dw $a67b ; record 1348
	dw $eb77 ; record 1349
	dw $37ae ; record 1350
	dw $e1da ; record 1351
	dw $d21e ; record 1352
	dw $1ce0 ; record 1353
	dw $0eff ; record 1354
	dw $e7ff ; record 1355
	dw $ef1e ; record 1356
	dw $ef1e ; record 1357
	dw $e23b ; record 1358
	dw $ff2b ; record 1359
	dw $2de6 ; record 1360
	dw $1df6 ; record 1361
	dw $13fe ; record 1362
	dw $0bfe ; record 1363
	dw $fcfe ; record 1364
	dw $13e0 ; record 1365
	dw $9bfe ; record 1366
	dw $9637 ; record 1367
	dw $9133 ; record 1368
	dw $1fef ; record 1369
	dw $1f90 ; record 1370
	dw $fe88 ; record 1371
RulesBorderAnimTask:
	INCBIN "data/bank_016/d_7420.bin" ; $7420, 187 bytes
RulesSpinningBallSpriteTask:
	INCBIN "data/bank_016/d_74db.bin" ; $74db, 131 bytes
RulesScrollArrowSpriteTask:
	INCBIN "data/bank_016/d_755e.bin" ; $755e, 1521 bytes
	ds 1201, $ff ; $7b4f, fill
