SECTION "ROM Bank $06", ROMX[$4000], BANK[$06]

FarPtr_RunMatchPauseMenu:
	dw RunMatchPauseMenu ; $4000
FarPtr_RunDebugStatsEditor:
	dw RunDebugStatsEditor ; $4002
FarPtr_ShowMessageWindow:
	dw ShowMessageWindow ; $4004
FarPtr_ShowMatchScoreboardScreen:
	dw ShowMatchScoreboardScreen ; $4006
FarPtr_RunStoryModeMenu:
	dw RunStoryModeMenu ; $4008
FarPtr_FlushTilemapToVram:
	dw FlushTilemapToVram ; $400a
FarPtr_RunMinigameEndMenu:
	dw RunMinigameEndMenu ; $400c
RunMinigameEndMenu:
	ldh a, [hWramBank] ; $400e
	push af ; $4010
	farcall FarPtr_StepMatchFrame ; $4011
	call PrepareScoreboardGfx ; $4014
	farcall FarPtr_StepMatchFrame ; $4017
	call LoadScoreboardModeGfx ; $401a
	ld hl, $5280 ; $401d
	ld de, $8640 ; $4020
	ld c, $04 ; $4023
	call QueueVRAMCopy ; $4025
	farcall FarPtr_StepMatchFrame ; $4028
	wram_bank $02 ; $402b
	ld b, $00 ; $4031
	call DrawScoreboard ; $4033
	ld a, $0a ; $4036
	ld hl, Func_06_506a ; $4038
	call RegisterFrameTask ; $403b
	ld a, $0a ; $403e
	ld hl, Func_06_69c8 ; $4040
	call RegisterFrameTask ; $4043
Label_06_4046:
	xor a, a ; $4046
	ld [wMatchMenuSelection], a ; $4047
	ld a, $0e ; $404a
	ld [$c4e6], a ; $404c
	call RunMatchQuitMenu ; $404f
	ld a, [wMatchMenuSelection] ; $4052
	cp a, $ff ; $4055
	jr z, Label_06_4046 ; $4057
	ld hl, Func_06_506a ; $4059
	call UnregisterFrameTask ; $405c
	ld hl, Func_06_69c8 ; $405f
	call UnregisterFrameTask ; $4062
	call RestoreBgTilemap ; $4065
	call FlushTilemapToVram ; $4068
	farcall FarPtr_StepMatchFrame ; $406b
	pop af ; $406e
	wram_bank ; $406f
	ret ; $4073
RunMatchPauseMenu:
	ldh a, [hWramBank] ; $4074
	push af ; $4076
	ldh a, [$ffdd] ; $4077
	push af ; $4079
	farcall FarPtr_StepMatchFrame ; $407a
	farcall FarPtr_StepMatchFrame ; $407d
	sound $63 ; $4080
	xor a, a ; $4082
	ld [wMatchMenuSelection], a ; $4083
	ld a, $02 ; $4086
	ldh [$ffdd], a ; $4088
	call PrepareScoreboardGfx ; $408a
	farcall FarPtr_StepMatchFrame ; $408d
	call LoadScoreboardModeGfx ; $4090
	ld hl, $5280 ; $4093
	ld de, $8640 ; $4096
	ld c, $04 ; $4099
	call QueueVRAMCopy ; $409b
	farcall FarPtr_StepMatchFrame ; $409e
	wram_bank $02 ; $40a1
Label_06_40a7:
	ld b, $00 ; $40a7
	call DrawScoreboard ; $40a9
	ld a, $0a ; $40ac
	ld hl, Func_06_506a ; $40ae
	call RegisterFrameTask ; $40b1
	ld a, $0a ; $40b4
	ld hl, Func_06_69c8 ; $40b6
	call RegisterFrameTask ; $40b9
	ld b, $00 ; $40bc
	ld a, [$c4c8] ; $40be
	and a, a ; $40c1
	jr z, Label_06_40c6 ; $40c2
	ld b, $01 ; $40c4
Label_06_40c6:
	ld a, b ; $40c6
	ld [$c4e6], a ; $40c7
	call RunMatchMenu ; $40ca
	ld a, [wMatchMenuSelection] ; $40cd
	cp a, $ff ; $40d0
	jr z, Label_06_40ef ; $40d2
	push af ; $40d4
	ld hl, $40e5 ; $40d5
	push hl ; $40d8
	ld a, [wMatchMenuSelection] ; $40d9
	rst Rst00 ; $40dc
	dw MatchPauseMenu_CheckRules ; $40dd jumptable
	dw MatchPauseMenu_ReviewControls ; $40df jumptable
	dw MatchPauseMenu_ChangeOptions ; $40e1 jumptable
	dw MatchPauseMenu_SaveQuit ; $40e3 jumptable
	pop af ; $40e5
	ld [wMatchMenuSelection], a ; $40e6
	ld a, [wMatchAbortFlag] ; $40e9
	and a, a ; $40ec
	jr z, Label_06_40a7 ; $40ed
Label_06_40ef:
	ld hl, Func_06_506a ; $40ef
	call UnregisterFrameTask ; $40f2
	ld hl, Func_06_69c8 ; $40f5
	call UnregisterFrameTask ; $40f8
	call RestoreBgTilemap ; $40fb
	call FlushTilemapToVram ; $40fe
	farcall FarPtr_StepMatchFrame ; $4101
	farcall FarPtr_StepMatchFrame ; $4104
	pop af ; $4107
	ldh [$ffdd], a ; $4108
	pop af ; $410a
	wram_bank ; $410b
	ret ; $410f
MatchPauseMenu_CheckRules:
	ld hl, Func_06_506a ; $4110
	call UnregisterFrameTask ; $4113
	call RestoreBgTilemap ; $4116
	ld hl, $412f ; $4119
	push hl ; $411c
	ld a, [wGameMode] ; $411d
	cp a, $08 ; $4120
	jp z, ShowMinigameRulesPages ; $4122
	ld a, [$c8f5] ; $4125
	cp a, $02 ; $4128
	jp z, ShowTrainingRulesPages ; $412a
	jr ShowMatchRulesPages ; $412d
	call RestoreBgTilemap ; $412f
	ret ; $4132
ShowMatchRulesPages:
	ld a, [$c4dc] ; $4133
	ld b, a ; $4136
	ld a, [$c4db] ; $4137
	add a, a ; $413a
	add a, b ; $413b
	ld [$c4e5], a ; $413c
	add a, $25 ; $413f
	ld e, a ; $4141
	adc a, $2c ; $4142
	sub a, e ; $4144
	ld d, a ; $4145
	ld hl, $c4ea ; $4146
	ld a, e ; $4149
	ld [hl+], a ; $414a
	ld [hl], d ; $414b
	ld de, $2c62 ; $414c
	ld hl, $c4e8 ; $414f
	ld a, e ; $4152
	ld [hl+], a ; $4153
	ld [hl], d ; $4154
	ld a, [$c4e5] ; $4155
	add a, a ; $4158
	add a, a ; $4159
	add a, $65 ; $415a
	ld l, a ; $415c
	adc a, $41 ; $415d
	sub a, l ; $415f
	ld h, a ; $4160
	call ShowRulesPageSequence ; $4161
	ret ; $4164
	; $4165, 24 bytes (bytes:4)
	db $00, $06, $ff, $ff ; 0x00
	db $01, $07, $ff, $ff ; 0x04
	db $02, $06, $ff, $ff ; 0x08
	db $03, $07, $ff, $ff ; 0x0c
	db $04, $06, $ff, $ff ; 0x10
	db $05, $07, $ff, $ff ; 0x14
ShowTrainingRulesPages:
	ld a, [$c8f7] ; $417d
	ld [$c4e5], a ; $4180
	add a, $2b ; $4183
	ld e, a ; $4185
	adc a, $2c ; $4186
	sub a, e ; $4188
	ld d, a ; $4189
	ld hl, $c4ea ; $418a
	ld a, e ; $418d
	ld [hl+], a ; $418e
	ld [hl], d ; $418f
	ld de, $2c6a ; $4190
	ld hl, $c4e8 ; $4193
	ld a, e ; $4196
	ld [hl+], a ; $4197
	ld [hl], d ; $4198
	ld a, [$c4e5] ; $4199
	add a, a ; $419c
	add a, a ; $419d
	add a, $a9 ; $419e
	ld l, a ; $41a0
	adc a, $41 ; $41a1
	sub a, l ; $41a3
	ld h, a ; $41a4
	call ShowRulesPageSequence ; $41a5
	ret ; $41a8
	; $41a9, 116 bytes (bytes:4)
	db $00, $ff, $ff, $ff ; 0x00
	db $01, $ff, $ff, $ff ; 0x04
	db $02, $ff, $ff, $ff ; 0x08
	db $03, $ff, $ff, $ff ; 0x0c
	db $04, $ff, $ff, $ff ; 0x10
	db $05, $ff, $ff, $ff ; 0x14
	db $06, $ff, $ff, $ff ; 0x18
	db $07, $ff, $ff, $ff ; 0x1c
	db $08, $ff, $ff, $ff ; 0x20
	db $09, $ff, $ff, $ff ; 0x24
	db $0a, $ff, $ff, $ff ; 0x28
	db $0b, $ff, $ff, $ff ; 0x2c
	db $0c, $1c, $ff, $ff ; 0x30
	db $0d, $1c, $ff, $ff ; 0x34
	db $0e, $1c, $ff, $ff ; 0x38
	db $0f, $ff, $ff, $ff ; 0x3c
	db $10, $ff, $ff, $ff ; 0x40
	db $11, $ff, $ff, $ff ; 0x44
	db $12, $ff, $ff, $ff ; 0x48
	db $13, $ff, $ff, $ff ; 0x4c
	db $14, $ff, $ff, $ff ; 0x50
	db $15, $ff, $ff, $ff ; 0x54
	db $16, $ff, $ff, $ff ; 0x58
	db $17, $ff, $ff, $ff ; 0x5c
	db $18, $ff, $ff, $ff ; 0x60
	db $19, $ff, $ff, $ff ; 0x64
	db $1a, $ff, $ff, $ff ; 0x68
	db $1b, $ff, $ff, $ff ; 0x6c
	db $1c, $ff, $ff, $ff ; 0x70
ShowMinigameRulesPages:
	ld a, [$c8f7] ; $421d
	sub a, $1c ; $4220
	ld b, a ; $4222
	add a, a ; $4223
	add a, b ; $4224
	ld b, a ; $4225
	ld a, [wMinigameLevel] ; $4226
	add a, b ; $4229
	ld [$c4e5], a ; $422a
	add a, $47 ; $422d
	ld e, a ; $422f
	adc a, $2c ; $4230
	sub a, e ; $4232
	ld d, a ; $4233
	ld hl, $c4ea ; $4234
	ld a, e ; $4237
	ld [hl+], a ; $4238
	ld [hl], d ; $4239
	ld a, [$c8f7] ; $423a
	sub a, $1c ; $423d
	add a, a ; $423f
	add a, $62 ; $4240
	ld l, a ; $4242
	adc a, $42 ; $4243
	sub a, l ; $4245
	ld h, a ; $4246
	ld a, [hl+] ; $4247
	ld d, [hl] ; $4248
	ld e, a ; $4249
	ld hl, $c4e8 ; $424a
	ld a, e ; $424d
	ld [hl+], a ; $424e
	ld [hl], d ; $424f
	ld a, [$c4e5] ; $4250
	add a, a ; $4253
	ld b, a ; $4254
	add a, a ; $4255
	add a, b ; $4256
	add a, $74 ; $4257
	ld l, a ; $4259
	adc a, $42 ; $425a
	sub a, l ; $425c
	ld h, a ; $425d
	call ShowRulesPageSequence ; $425e
	ret ; $4261
	; $4262, 180 bytes (records:2)
	dw $2c87 ; record 0
	dw $2c8d ; record 1
	dw $2c92 ; record 2
	dw $2c96 ; record 3
	dw $2c9f ; record 4
	dw $2ca2 ; record 5
	dw $2ca5 ; record 6
	dw $2cb1 ; record 7
	dw $2cbd ; record 8
	dw $0100 ; record 9
	dw $ffff ; record 10
	dw $ffff ; record 11
	dw $0302 ; record 12
	dw $ffff ; record 13
	dw $ffff ; record 14
	dw $0504 ; record 15
	dw $ffff ; record 16
	dw $ffff ; record 17
	dw $0100 ; record 18
	dw $ffff ; record 19
	dw $ffff ; record 20
	dw $0302 ; record 21
	dw $ffff ; record 22
	dw $ffff ; record 23
	dw $0504 ; record 24
	dw $ffff ; record 25
	dw $ffff ; record 26
	dw $ff00 ; record 27
	dw $ffff ; record 28
	dw $ffff ; record 29
	dw $ff01 ; record 30
	dw $ffff ; record 31
	dw $ffff ; record 32
	dw $0302 ; record 33
	dw $ffff ; record 34
	dw $ffff ; record 35
	dw $0100 ; record 36
	dw $ff02 ; record 37
	dw $ffff ; record 38
	dw $0403 ; record 39
	dw $ff05 ; record 40
	dw $ffff ; record 41
	dw $0706 ; record 42
	dw $ff08 ; record 43
	dw $ffff ; record 44
	dw $ff00 ; record 45
	dw $ffff ; record 46
	dw $ffff ; record 47
	dw $ff01 ; record 48
	dw $ffff ; record 49
	dw $ffff ; record 50
	dw $ff02 ; record 51
	dw $ffff ; record 52
	dw $ffff ; record 53
	dw $ff00 ; record 54
	dw $ffff ; record 55
	dw $ffff ; record 56
	dw $ff01 ; record 57
	dw $ffff ; record 58
	dw $ffff ; record 59
	dw $ff02 ; record 60
	dw $ffff ; record 61
	dw $ffff ; record 62
	dw $0100 ; record 63
	dw $0302 ; record 64
	dw $ffff ; record 65
	dw $0504 ; record 66
	dw $0706 ; record 67
	dw $ffff ; record 68
	dw $0908 ; record 69
	dw $0b0a ; record 70
	dw $ffff ; record 71
	dw $0100 ; record 72
	dw $0302 ; record 73
	dw $ffff ; record 74
	dw $0504 ; record 75
	dw $0706 ; record 76
	dw $ffff ; record 77
	dw $0908 ; record 78
	dw $0b0a ; record 79
	dw $ffff ; record 80
	dw $0100 ; record 81
	dw $ff02 ; record 82
	dw $ffff ; record 83
	dw $0403 ; record 84
	dw $ff05 ; record 85
	dw $ffff ; record 86
	dw $0706 ; record 87
	dw $ff08 ; record 88
	dw $ffff ; record 89
ShowRulesPageSequence:
	ld a, [hl+] ; $4316
	cp a, $ff ; $4317
	jr z, Label_06_4372 ; $4319
	push hl ; $431b
	push af ; $431c
	ld a, [hl] ; $431d
	cp a, $ff ; $431e
	jr z, Label_06_432a ; $4320
	ld a, $01 ; $4322
	ld hl, Func_06_4373 ; $4324
	call RegisterFrameTask ; $4327
Label_06_432a:
	farcall FarPtr_PrepareGlyphBuffer ; $432a
	ld hl, $c4ea ; $432d
	ld a, [hl+] ; $4330
	ld h, [hl] ; $4331
	ld l, a ; $4332
	ld de, $0002 ; $4333
	call DrawMenuCaptionWindow ; $4336
	ld de, $0005 ; $4339
	ld bc, $130b ; $433c
	call DrawWindowFrameAt ; $433f
	ld hl, $c4e8 ; $4342
	ld a, [hl+] ; $4345
	ld h, [hl] ; $4346
	ld l, a ; $4347
	pop af ; $4348
	add a, l ; $4349
	ld l, a ; $434a
	jr nc, Label_06_434e ; $434b
	inc h ; $434d
Label_06_434e:
	ld de, $0106 ; $434e
	call DrawMenuTextLine ; $4351
	farcall FarPtr_StepMatchFrame ; $4354
	farcall FarPtr_UploadGlyphBuffer ; $4357
	call FlushTilemapToVram ; $435a
Label_06_435d:
	farcall FarPtr_StepMatchFrame ; $435d
	farcall FarPtr_ReadMatchInputPressed ; $4360
	and a, $03 ; $4363
	jr z, Label_06_435d ; $4365
	sound $5f ; $4367
	ld hl, Func_06_4373 ; $4369
	call UnregisterFrameTask ; $436c
	pop hl ; $436f
	jr ShowRulesPageSequence ; $4370
Label_06_4372:
	ret ; $4372
Func_06_4373:
	ld de, $9080 ; $4373
	farcall FarPtr_AddBobbingOffsetY ; $4376
	ld bc, $0a70 ; $4379
	call QueueSprite16 ; $437c
	ret ; $437f
MatchPauseMenu_ReviewControls:
	ld hl, Func_06_506a ; $4380
	call UnregisterFrameTask ; $4383
	call RestoreBgTilemap ; $4386
	ld de, $0002 ; $4389
	ld bc, $130e ; $438c
	call DrawWindowFrameAt ; $438f
	farcall FarPtr_PrepareGlyphBuffer ; $4392
	ld de, $0103 ; $4395
	ld hl, $0157 ; $4398
	call DrawMenuTextLine ; $439b
	ld de, $060a ; $439e
	ld hl, $0158 ; $43a1
	call DrawMenuTextLine ; $43a4
	ld de, $010c ; $43a7
	ld hl, $0159 ; $43aa
	call DrawMenuTextLine ; $43ad
	farcall FarPtr_UploadGlyphBuffer ; $43b0
	call FlushTilemapToVram ; $43b3
	farcall FarPtr_StepMatchFrame ; $43b6
Label_06_43b9:
	farcall FarPtr_ReadMatchInputPressed ; $43b9
	and a, $03 ; $43bc
	jr nz, Label_06_43e8 ; $43be
	farcall FarPtr_ReadMatchInputPressed ; $43c0
	and a, $40 ; $43c3
	jr z, Label_06_43e3 ; $43c5
	ldh a, [hDebugStepMode] ; $43c7
	and a, a ; $43c9
	jr z, Label_06_43e3 ; $43ca
	ldh a, [hWramBank] ; $43cc
	push af ; $43ce
	wram_bank $04 ; $43cf
	ld hl, $df1e ; $43d5
	ld a, [hl] ; $43d8
	xor a, $01 ; $43d9
	ld [hl], a ; $43db
	pop af ; $43dc
	wram_bank ; $43dd
	jr Label_06_43e8 ; $43e1
Label_06_43e3:
	farcall FarPtr_StepMatchFrame ; $43e3
	jr Label_06_43b9 ; $43e6
Label_06_43e8:
	call RestoreBgTilemap ; $43e8
	sound $62 ; $43eb
	ret ; $43ed
MatchPauseMenu_ChangeOptions:
	call RestoreBgTilemapRegion ; $43ee
	ld a, [$c4c8] ; $43f1
	and a, a ; $43f4
	jr nz, MatchPauseMenu_MusicToggle ; $43f5
	xor a, a ; $43f7
	ld [wMatchMenuSelection], a ; $43f8
Label_06_43fb:
	ld a, $02 ; $43fb
	ld [$c4e6], a ; $43fd
	call RunMatchMenu ; $4400
	ld a, [wMatchMenuSelection] ; $4403
	cp a, $ff ; $4406
	jr z, Label_06_441d ; $4408
	push af ; $440a
	ld hl, $4417 ; $440b
	push hl ; $440e
	ld a, [wMatchMenuSelection] ; $440f
	rst Rst00 ; $4412
	dw MatchPauseMenu_CameraSelect ; $4413 jumptable
	dw MatchPauseMenu_MusicToggle ; $4415 jumptable
	pop af ; $4417
	ld [wMatchMenuSelection], a ; $4418
	jr Label_06_43fb ; $441b
Label_06_441d:
	ret ; $441d
MatchPauseMenu_CameraSelect:
	ld a, [$c4dd] ; $441e
	ld [wMatchMenuSelection], a ; $4421
	ld a, $03 ; $4424
	ld [$c4e6], a ; $4426
	call RunMatchMenu ; $4429
	ld a, [wMatchMenuSelection] ; $442c
	cp a, $ff ; $442f
	jr z, Label_06_4439 ; $4431
	ld [$c4dd], a ; $4433
	farcall FarPtr_SetStorySlotFlagB ; $4436
Label_06_4439:
	ret ; $4439
MatchPauseMenu_MusicToggle:
	ldh a, [hMusic] ; $443a
	and a, $01 ; $443c
	ld [wMatchMenuSelection], a ; $443e
	ld a, $04 ; $4441
	ld [$c4e6], a ; $4443
	call RunMatchMenu ; $4446
	ld a, [wMatchMenuSelection] ; $4449
	cp a, $ff ; $444c
	jr z, Label_06_4461 ; $444e
	call SetMusicMuted ; $4450
	ld a, [wGameMode] ; $4453
	cp a, $09 ; $4456
	jr z, Label_06_4461 ; $4458
	ldh a, [hMusic] ; $445a
	and a, $01 ; $445c
	farcall FarPtr_SetStorySlotFlagA ; $445e
Label_06_4461:
	ret ; $4461
MatchPauseMenu_SaveQuit:
	call RestoreBgTilemapRegion ; $4462
	ld a, [wGameMode] ; $4465
	add a, $f3 ; $4468
	ld l, a ; $446a
	adc a, $44 ; $446b
	sub a, l ; $446d
	ld h, a ; $446e
	ld a, [hl] ; $446f
	ld [$c4e6], a ; $4470
	ld a, [$c7bb] ; $4473
	and a, a ; $4476
	jr z, Label_06_447e ; $4477
	ld a, $08 ; $4479
	ld [$c4e6], a ; $447b
Label_06_447e:
	call GetMatchMenuItemCount ; $447e
	dec a ; $4481
	ld [wMatchMenuSelection], a ; $4482
RunMatchQuitMenu:
	call RunMatchMenu ; $4485
	ld a, [wMatchMenuSelection] ; $4488
	cp a, $ff ; $448b
	ret z ; $448d
	call GetMatchMenuItemId ; $448e
	sub a, $0a ; $4491
	ld a, a ; $4493
	rst Rst00 ; $4494
	dw MatchQuitMenu_ReturnToGame ; $4495 jumptable
	dw MatchQuitMenu_SaveAndQuit ; $4497 jumptable
	dw MatchQuitMenu_Quit ; $4499 jumptable
	dw MatchQuitMenu_SelectNewLevel ; $449b jumptable
	dw MatchQuitMenu_Retry ; $449d jumptable
	dw MatchQuitMenu_Retry ; $449f jumptable
	dw MatchQuitMenu_Retry ; $44a1 jumptable
	dw MatchQuitMenu_Retry ; $44a3 jumptable
	dw MatchQuitMenu_Retry ; $44a5 jumptable
	dw MatchQuitMenu_Quit ; $44a7 jumptable
	dw MatchQuitMenu_Quit ; $44a9 jumptable
	dw MatchQuitMenu_Quit ; $44ab jumptable
	dw MatchQuitMenu_Quit ; $44ad jumptable
	dw MatchQuitMenu_Quit ; $44af jumptable
MatchQuitMenu_ReturnToGame:
	ret ; $44b1
MatchQuitMenu_SaveAndQuit:
	ld a, $01 ; $44b2
	ld [wKeepMatchStatsFlag], a ; $44b4
	ld [$c8a5], a ; $44b7
	ld a, $ff ; $44ba
	ld [wMatchAbortFlag], a ; $44bc
	ld [wMatchFramesAbort], a ; $44bf
	ret ; $44c2
MatchQuitMenu_Retry:
	ld a, $01 ; $44c3
	ld [wMatchRetryRequest], a ; $44c5
	ld [wMatchExitRequest], a ; $44c8
	ld a, $ff ; $44cb
	ld [wMatchAbortFlag], a ; $44cd
	ld [wMatchFramesAbort], a ; $44d0
	ret ; $44d3
MatchQuitMenu_SelectNewLevel:
	ld a, $01 ; $44d4
	ld [wMatchSelectNewLevelRequest], a ; $44d6
	ld [wMatchExitRequest], a ; $44d9
	ld a, $ff ; $44dc
	ld [wMatchAbortFlag], a ; $44de
	ld [wMatchFramesAbort], a ; $44e1
	ret ; $44e4
MatchQuitMenu_Quit:
	ld a, $01 ; $44e5
	ld [wMatchExitRequest], a ; $44e7
	ld a, $ff ; $44ea
	ld [wMatchAbortFlag], a ; $44ec
	ld [wMatchFramesAbort], a ; $44ef
	ret ; $44f2
	INCBIN "data/bank_006/d_44f3.bin" ; $44f3, 11 bytes
ShowMessageWindow:
	push af ; $44fe
	push bc ; $44ff
	push de ; $4500
	push hl ; $4501
	ldh a, [hWramBank] ; $4502
	push af ; $4504
	wram_bank $02 ; $4505
	ld a, $01 ; $450b
	ld [$c4c0], a ; $450d
	farcall FarPtr_StepMatchFrame ; $4510
	push bc ; $4513
	push de ; $4514
	push hl ; $4515
	push bc ; $4516
	push de ; $4517
	call GetShadowAttrmapAddr ; $4518
	ld c, e ; $451b
	ld b, d ; $451c
	pop de ; $451d
	call GetShadowTilemapAddr ; $451e
	pop hl ; $4521
	call DrawWindowFramePriority ; $4522
	pop hl ; $4525
	pop de ; $4526
	pop bc ; $4527
	farcall FarPtr_PrepareGlyphBuffer ; $4528
	push hl ; $452b
	inc d ; $452c
	inc e ; $452d
	call GetShadowTilemapAddr ; $452e
	ld c, b ; $4531
	dec c ; $4532
	dec c ; $4533
	pop hl ; $4534
	farcall FarPtr_RenderProportionalTextAt ; $4535
	farcall FarPtr_UploadGlyphBuffer ; $4538
	call FlushTilemapToVram ; $453b
	ld a, $1e ; $453e
	farcall FarPtr_StepMatchFrames ; $4540
Label_06_4543:
	farcall FarPtr_StepMatchFrame ; $4543
	farcall FarPtr_ReadMatchInputPressed ; $4546
	and a, $0f ; $4549
	jr z, Label_06_4543 ; $454b
	call RestoreBgTilemap ; $454d
	call FlushTilemapToVram ; $4550
	farcall FarPtr_StepMatchFrame ; $4553
	xor a, a ; $4556
	ld [$c4c0], a ; $4557
	pop af ; $455a
	wram_bank ; $455b
	pop hl ; $455f
	pop de ; $4560
	pop bc ; $4561
	pop af ; $4562
	ret ; $4563
DrawWindowFrameAt:
	push bc ; $4564
	push de ; $4565
	call GetShadowAttrmapAddr ; $4566
	ld c, e ; $4569
	ld b, d ; $456a
	pop de ; $456b
	call GetShadowTilemapAddr ; $456c
	pop hl ; $456f
	call DrawWindowFrameNoPriority ; $4570
	ret ; $4573
DrawMenuTextLine:
	push de ; $4574
	push hl ; $4575
	push hl ; $4576
	call GetShadowTilemapAddr ; $4577
	pop hl ; $457a
	call Func_00_2a9e ; $457b
	pop hl ; $457e
	pop de ; $457f
	inc hl ; $4580
	inc e ; $4581
	inc e ; $4582
	ret ; $4583
DrawMenuCaptionWindow:
	push hl ; $4584
	push de ; $4585
	call GetShadowAttrmapAddr ; $4586
	ld c, e ; $4589
	ld b, d ; $458a
	pop de ; $458b
	push de ; $458c
	call GetShadowTilemapAddr ; $458d
	ld hl, $1303 ; $4590
	ld a, $01 ; $4593
	ld [wWindowFrameAttr], a ; $4595
	call DrawWindowFrame ; $4598
	pop de ; $459b
	ld hl, $0101 ; $459c
	add hl, de ; $459f
	ld e, l ; $45a0
	ld d, h ; $45a1
	call GetShadowTilemapAddr ; $45a2
	pop hl ; $45a5
	call Func_00_2a9e ; $45a6
	ret ; $45a9
RestoreBgTilemap:
	ld hl, $d800 ; $45aa
	ld de, $d000 ; $45ad
	ld c, $40 ; $45b0
	call CopyMemoryFast ; $45b2
	ld hl, $dc00 ; $45b5
	ld de, $d400 ; $45b8
	ld c, $40 ; $45bb
	call CopyMemoryFast ; $45bd
	ret ; $45c0
RestoreBgTilemapRegion:
	ld e, $0a ; $45c1
	call GetScrolledTilemapRowOffset ; $45c3
	ld c, l ; $45c6
	ld b, h ; $45c7
	push bc ; $45c8
	ld hl, $d000 ; $45c9
	add hl, bc ; $45cc
	ld e, l ; $45cd
	ld d, h ; $45ce
	ld hl, $d800 ; $45cf
	add hl, bc ; $45d2
	ld c, $0e ; $45d3
	call CopyMemoryFast ; $45d5
	pop bc ; $45d8
	ld hl, $d400 ; $45d9
	add hl, bc ; $45dc
	ld e, l ; $45dd
	ld d, h ; $45de
	ld hl, $dc00 ; $45df
	add hl, bc ; $45e2
	ld c, $0e ; $45e3
	call CopyMemoryFast ; $45e5
	ret ; $45e8
ClearAttrPriorityRegion:
	ld a, [hl] ; $45e9
	and a, $7f ; $45ea
	ld [hl+], a ; $45ec
	dec bc ; $45ed
	ld a, b ; $45ee
	or a, c ; $45ef
	jr nz, ClearAttrPriorityRegion ; $45f0
	ret ; $45f2
FlushTilemapToVramIfDirty:
	ld a, [$c4e2] ; $45f3
	and a, a ; $45f6
	ret z ; $45f7
FlushTilemapToVram:
	xor a, a ; $45f8
	ld [$c4e2], a ; $45f9
	ld e, $00 ; $45fc
	call GetScrolledTilemapRowOffset ; $45fe
	ld c, l ; $4601
	ld b, h ; $4602
	push bc ; $4603
	ld hl, $9800 ; $4604
	add hl, bc ; $4607
	ld e, l ; $4608
	ld d, h ; $4609
	ld hl, $d000 ; $460a
	add hl, bc ; $460d
	ld c, $22 ; $460e
	call QueueVRAMCopy ; $4610
	pop bc ; $4613
	ld hl, $b800 ; $4614
	add hl, bc ; $4617
	ld e, l ; $4618
	ld d, h ; $4619
	ld hl, $d400 ; $461a
	add hl, bc ; $461d
	ld c, $22 ; $461e
	call QueueVRAMCopy ; $4620
	ret ; $4623
GetShadowTilemapAddr:
	call GetScrolledTilemapOffset ; $4624
	ld de, $d000 ; $4627
	add hl, de ; $462a
	ld e, l ; $462b
	ld d, h ; $462c
	ret ; $462d
GetShadowAttrmapAddr:
	call GetScrolledTilemapOffset ; $462e
	ld de, $d400 ; $4631
	add hl, de ; $4634
	ld e, l ; $4635
	ld d, h ; $4636
	ret ; $4637
GetScrolledTilemapOffset:
	call GetScrolledTilemapRowOffset ; $4638
	ldh a, [hScrollX] ; $463b
	add a, $07 ; $463d
	rrca ; $463f
	rrca ; $4640
	rrca ; $4641
	add a, d ; $4642
	and a, $1f ; $4643
	add a, l ; $4645
	ld l, a ; $4646
	jr nc, Label_06_464a ; $4647
	inc h ; $4649
Label_06_464a:
	ret ; $464a
GetScrolledTilemapRowOffset:
	ldh a, [hScrollY] ; $464b
	add a, $07 ; $464d
	rrca ; $464f
	rrca ; $4650
	rrca ; $4651
	add a, e ; $4652
	and a, $1f ; $4653
	ld l, a ; $4655
	ld h, $00 ; $4656
	add hl, hl ; $4658
	add hl, hl ; $4659
	add hl, hl ; $465a
	add hl, hl ; $465b
	add hl, hl ; $465c
	ret ; $465d
AdjustSpriteCoordsForScroll:
	ldh a, [hScrollX] ; $465e
	cpl ; $4660
	inc a ; $4661
	and a, $07 ; $4662
	add a, d ; $4664
	ld d, a ; $4665
	ldh a, [hScrollY] ; $4666
	cpl ; $4668
	inc a ; $4669
	and a, $07 ; $466a
	add a, e ; $466c
	ld e, a ; $466d
	ret ; $466e
	; $466f, 120 bytes (bytes:8)
	db $00, $01, $02, $03, $04, $00, $00, $00 ; 0x00
	db $00, $01, $05, $03, $04, $00, $00, $00 ; 0x08
	db $04, $05, $00, $00, $02, $00, $00, $00 ; 0x10
	db $06, $07, $00, $00, $02, $00, $00, $00 ; 0x18
	db $08, $09, $00, $00, $02, $00, $00, $00 ; 0x20
	db $0b, $13, $0a, $00, $03, $00, $00, $00 ; 0x28
	db $0b, $0c, $0a, $00, $03, $00, $00, $00 ; 0x30
	db $0e, $14, $0a, $00, $03, $00, $00, $00 ; 0x38
	db $0f, $15, $0a, $00, $03, $00, $00, $00 ; 0x40
	db $10, $16, $0a, $00, $03, $00, $00, $00 ; 0x48
	db $11, $17, $0a, $00, $03, $00, $00, $00 ; 0x50
	db $12, $0d, $0c, $0a, $04, $00, $00, $00 ; 0x58
	db $0c, $0a, $00, $00, $02, $00, $00, $00 ; 0x60
	db $0b, $0c, $0a, $00, $03, $00, $00, $00 ; 0x68
	db $12, $0d, $0c, $00, $03, $00, $00, $00 ; 0x70
RunMatchMenu:
	call GetMatchMenuItemCount ; $46e7
	ld [$c4e7], a ; $46ea
	call DrawMatchMenuItems ; $46ed
	ld e, $0c ; $46f0
	call GetScrolledTilemapRowOffset ; $46f2
	ld de, $d400 ; $46f5
	add hl, de ; $46f8
	ld bc, $0040 ; $46f9
	call ClearAttrPriorityRegion ; $46fc
	jr Label_06_4733 ; $46ff
Label_06_4701:
	farcall FarPtr_ReadMatchInputPressed ; $4701
	and a, $0a ; $4704
	jr z, Label_06_4711 ; $4706
	sound $62 ; $4708
	ld a, $ff ; $470a
	ld [wMatchMenuSelection], a ; $470c
	jr Label_06_4776 ; $470f
Label_06_4711:
	farcall FarPtr_ReadMatchInputPressed ; $4711
	and a, $01 ; $4714
	jr z, Label_06_471c ; $4716
	sound $5f ; $4718
	jr Label_06_4776 ; $471a
Label_06_471c:
	farcall FarPtr_ReadMatchInputRepeat ; $471c
	and a, $30 ; $471f
	jr z, Label_06_476e ; $4721
	ld b, a ; $4723
	ld a, [$c4e7] ; $4724
	ld c, a ; $4727
	ld a, [wMatchMenuSelection] ; $4728
	call MoveCursorHorizontal ; $472b
	ld [wMatchMenuSelection], a ; $472e
	sound $5e ; $4731
Label_06_4733:
	farcall FarPtr_PrepareGlyphBuffer ; $4733
	ld hl, wGlyphPenX ; $4736
	ld de, $2000 ; $4739
	ld a, e ; $473c
	ld [hl+], a ; $473d
	ld [hl], d ; $473e
	ld a, $40 ; $473f
	ld hl, $c3ba ; $4741
	ld [hl+], a ; $4744
	ld [hl+], a ; $4745
	ld [hl+], a ; $4746
	ld a, [wMatchMenuSelection] ; $4747
	call GetMatchMenuItemId ; $474a
	push af ; $474d
	call LoadMatchMenuItemGfx ; $474e
	pop af ; $4751
	add a, $3f ; $4752
	ld l, a ; $4754
	adc a, $01 ; $4755
	sub a, l ; $4757
	ld h, a ; $4758
	ld de, $000e ; $4759
	call DrawMenuCaptionWindow ; $475c
	call DrawScoreboardCaption ; $475f
	farcall FarPtr_UploadGlyphBuffer ; $4762
	farcall FarPtr_StepMatchFrame ; $4765
	call FlushTilemapToVram ; $4768
	farcall FarPtr_StepMatchFrame ; $476b
Label_06_476e:
	call DrawMatchMenuCursor ; $476e
	farcall FarPtr_StepMatchFrame ; $4771
	jr Label_06_4701 ; $4774
Label_06_4776:
	farcall FarPtr_StepMatchFrame ; $4776
	ret ; $4779
DrawScoreboardCaption:
	ld a, [$c494] ; $477a
	rst Rst00 ; $477d
	dw ScoreboardCaption_SetGamePoint ; $477e jumptable
	dw ScoreboardCaption_SetGamePoint ; $4780 jumptable
	dw ScoreboardCaption_SetGamePoint ; $4782 jumptable
	dw ScoreboardCaption_Total ; $4784 jumptable
	dw ScoreboardCaption_Total ; $4786 jumptable
	dw ScoreboardCaption_Total ; $4788 jumptable
	dw ScoreboardCaption_ScoreTarget ; $478a jumptable
	dw ScoreboardCaption_ScoreHigh ; $478c jumptable
ScoreboardCaption_SetGamePoint:
	ld hl, $c4e3 ; $478e
	ld a, [hl+] ; $4791
	ld b, [hl] ; $4792
	ld c, a ; $4793
	ld hl, $0701 ; $4794
	add hl, bc ; $4797
	ld e, l ; $4798
	ld d, h ; $4799
	ld hl, $015a ; $479a
	call DrawMenuTextLine ; $479d
	ret ; $47a0
ScoreboardCaption_Total:
	ld hl, $c4e3 ; $47a1
	ld a, [hl+] ; $47a4
	ld b, [hl] ; $47a5
	ld c, a ; $47a6
	ld hl, $0e01 ; $47a7
	add hl, bc ; $47aa
	ld e, l ; $47ab
	ld d, h ; $47ac
	ld hl, $015b ; $47ad
	call DrawMenuTextLine ; $47b0
	ret ; $47b3
ScoreboardCaption_ScoreTarget:
	ld hl, $c4e3 ; $47b4
	ld a, [hl+] ; $47b7
	ld b, [hl] ; $47b8
	ld c, a ; $47b9
	ld hl, $0502 ; $47ba
	add hl, bc ; $47bd
	ld e, l ; $47be
	ld d, h ; $47bf
	ld hl, $015c ; $47c0
	call DrawMenuTextLine ; $47c3
	ld hl, $0304 ; $47c6
	add hl, bc ; $47c9
	ld e, l ; $47ca
	ld d, h ; $47cb
	ld hl, $015d ; $47cc
	call DrawMenuTextLine ; $47cf
	ld hl, $0505 ; $47d2
	add hl, bc ; $47d5
	ld e, l ; $47d6
	ld d, h ; $47d7
	ld hl, $015c ; $47d8
	call DrawMenuTextLine ; $47db
	ret ; $47de
ScoreboardCaption_ScoreHigh:
	ld hl, $c4e3 ; $47df
	ld a, [hl+] ; $47e2
	ld b, [hl] ; $47e3
	ld c, a ; $47e4
	ld hl, $0502 ; $47e5
	add hl, bc ; $47e8
	ld e, l ; $47e9
	ld d, h ; $47ea
	ld hl, $015c ; $47eb
	call DrawMenuTextLine ; $47ee
	ld hl, $0404 ; $47f1
	add hl, bc ; $47f4
	ld e, l ; $47f5
	ld d, h ; $47f6
	ld hl, $015e ; $47f7
	call DrawMenuTextLine ; $47fa
	ld hl, $0505 ; $47fd
	add hl, bc ; $4800
	ld e, l ; $4801
	ld d, h ; $4802
	ld hl, $015c ; $4803
	call DrawMenuTextLine ; $4806
	ret ; $4809
GetMatchMenuItemId:
	ld b, a ; $480a
	ld a, [$c4e6] ; $480b
	add a, a ; $480e
	add a, a ; $480f
	add a, a ; $4810
	add a, $6f ; $4811
	ld l, a ; $4813
	adc a, $46 ; $4814
	sub a, l ; $4816
	ld h, a ; $4817
	ld a, b ; $4818
	add a, l ; $4819
	ld l, a ; $481a
	jr nc, Label_06_481e ; $481b
	inc h ; $481d
Label_06_481e:
	ld a, [hl] ; $481e
	ret ; $481f
GetMatchMenuItemCount:
	ld a, [$c4e6] ; $4820
	add a, a ; $4823
	add a, a ; $4824
	add a, a ; $4825
	add a, $73 ; $4826
	ld l, a ; $4828
	adc a, $46 ; $4829
	sub a, l ; $482b
	ld h, a ; $482c
	ld a, [hl] ; $482d
	ret ; $482e
DrawMatchMenuItems:
	ld a, [$c4e7] ; $482f
	add a, a ; $4832
	add a, $57 ; $4833
	ld l, a ; $4835
	adc a, $48 ; $4836
	sub a, l ; $4838
	ld h, a ; $4839
	ld a, [hl+] ; $483a
	ld h, [hl] ; $483b
	ld l, a ; $483c
	ld a, [$c4e7] ; $483d
	ld c, a ; $4840
	ld b, $00 ; $4841
Label_06_4843:
	ld a, [hl+] ; $4843
	ld e, a ; $4844
	ld a, [hl+] ; $4845
	ld d, a ; $4846
	push bc ; $4847
	push hl ; $4848
	ld a, b ; $4849
	call GetMatchMenuItemId ; $484a
	call DrawMatchMenuItem ; $484d
	pop hl ; $4850
	pop bc ; $4851
	inc b ; $4852
	dec c ; $4853
	jr nz, Label_06_4843 ; $4854
	ret ; $4856
	; $4857, 28 bytes (records:2)
	dw $4861 ; record 0
	dw $4861 ; record 1
	dw $4861 ; record 2
	dw $4865 ; record 3
	dw $486b ; record 4
	dw $050a ; record 5
	dw $0b0a ; record 6
	dw $040a ; record 7
	dw $080a ; record 8
	dw $0c0a ; record 9
	dw $030a ; record 10
	dw $060a ; record 11
	dw $090a ; record 12
	dw $0c0a ; record 13
DrawMatchMenuCursor:
	ld a, [$c4e7] ; $4873
	add a, a ; $4876
	add a, $91 ; $4877
	ld l, a ; $4879
	adc a, $48 ; $487a
	sub a, l ; $487c
	ld h, a ; $487d
	ld a, [hl+] ; $487e
	ld h, [hl] ; $487f
	ld l, a ; $4880
	ld a, [wMatchMenuSelection] ; $4881
	add a, a ; $4884
	add a, l ; $4885
	ld l, a ; $4886
	jr nc, Label_06_488a ; $4887
	inc h ; $4889
Label_06_488a:
	ld a, [hl+] ; $488a
	ld d, [hl] ; $488b
	ld e, a ; $488c
	call QueueMatchMenuCursorSprite ; $488d
	ret ; $4890
	; $4891, 28 bytes (records:2)
	dw $489b ; record 0
	dw $489b ; record 1
	dw $489b ; record 2
	dw $489f ; record 3
	dw $48a5 ; record 4
	dw $1860 ; record 5
	dw $4860 ; record 6
	dw $1060 ; record 7
	dw $3060 ; record 8
	dw $5060 ; record 9
	dw $0860 ; record 10
	dw $2060 ; record 11
	dw $3860 ; record 12
	dw $5060 ; record 13
ShowMatchScoreboardScreen:
	ldh a, [hWramBank] ; $48ad
	push af ; $48af
	farcall FarPtr_StepMatchFrame ; $48b0
	call PrepareScoreboardGfx ; $48b3
	farcall FarPtr_StepMatchFrame ; $48b6
	ld a, $05 ; $48b9
	ld [$c4e3], a ; $48bb
	call LoadScoreboardModeGfx ; $48be
	ld b, $01 ; $48c1
	call DrawScoreboard ; $48c3
	farcall FarPtr_PrepareGlyphBuffer ; $48c6
	call DrawScoreboardCaption ; $48c9
	farcall FarPtr_UploadGlyphBuffer ; $48cc
	ld a, $0a ; $48cf
	ld hl, Func_06_506a ; $48d1
	call RegisterFrameTask ; $48d4
	ld a, $0a ; $48d7
	ld hl, Func_06_69c8 ; $48d9
	call RegisterFrameTask ; $48dc
	farcall FarPtr_StepMatchFrame ; $48df
	call FlushTilemapToVram ; $48e2
	farcall FarPtr_StepMatchFrame ; $48e5
	wram_bank $02 ; $48e8
Label_06_48ee:
	farcall FarPtr_ReadMatchInputPressed ; $48ee
	and a, $0f ; $48f1
	jr nz, Label_06_48fa ; $48f3
	farcall FarPtr_StepMatchFrame ; $48f5
	jr Label_06_48ee ; $48f8
Label_06_48fa:
	ld hl, Func_06_506a ; $48fa
	call UnregisterFrameTask ; $48fd
	ld hl, Func_06_69c8 ; $4900
	call UnregisterFrameTask ; $4903
	call RestoreBgTilemap ; $4906
	call FlushTilemapToVram ; $4909
	farcall FarPtr_StepMatchFrame ; $490c
	pop af ; $490f
	wram_bank ; $4910
	ret ; $4914
PrepareScoreboardGfx:
	ld a, $00 ; $4915
	ld [$c4e4], a ; $4917
	ld a, $02 ; $491a
	ld [$c4e3], a ; $491c
	ld a, [$c494] ; $491f
	cp a, $06 ; $4922
	jr nz, Label_06_492b ; $4924
	ld a, $02 ; $4926
	ld [$c4e4], a ; $4928
Label_06_492b:
	ld a, [$c494] ; $492b
	cp a, $07 ; $492e
	jr nz, Label_06_4937 ; $4930
	ld a, $02 ; $4932
	ld [$c4e4], a ; $4934
Label_06_4937:
	ld a, [wOnCourtCharCountMinus1] ; $4937
	rst Rst00 ; $493a
	dw Label_06_495e ; $493b jumptable
	dw Label_06_4955 ; $493d jumptable
	dw Label_06_494c ; $493f jumptable
	dw Label_06_4943 ; $4941 jumptable
Label_06_4943:
	wram_bank $06 ; $4943
	farcall FarPtr_ReloadCharFrameGfx ; $4949
Label_06_494c:
	wram_bank $07 ; $494c
	farcall FarPtr_ReloadCharFrameGfx ; $4952
Label_06_4955:
	wram_bank $05 ; $4955
	farcall FarPtr_ReloadCharFrameGfx ; $495b
Label_06_495e:
	wram_bank $04 ; $495e
	farcall FarPtr_ReloadCharFrameGfx ; $4964
	farcall FarPtr_StepMatchFrame ; $4967
	ld a, [$c8f5] ; $496a
	cp a, $02 ; $496d
	jr z, Label_06_49a0 ; $496f
	ld a, [wPlayer1GamesWon] ; $4971
	ld b, $01 ; $4974
	ld de, $8700 ; $4976
	farcall FarPtr_09_28 ; $4979
	ld a, [wPlayer1SetsWon] ; $497c
	ld b, $01 ; $497f
	ld de, $8680 ; $4981
	farcall FarPtr_09_28 ; $4984
	ld a, [wPlayer2GamesWon] ; $4987
	ld b, $01 ; $498a
	ld de, $8740 ; $498c
	farcall FarPtr_09_28 ; $498f
	ld a, [wPlayer2SetsWon] ; $4992
	ld b, $01 ; $4995
	ld de, $86c0 ; $4997
	farcall FarPtr_09_28 ; $499a
	farcall FarPtr_StepMatchFrame ; $499d
Label_06_49a0:
	wram_bank $02 ; $49a0
	ret ; $49a6
DrawScoreboard:
	push bc ; $49a7
	ld hl, $c4e3 ; $49a8
	ld a, [hl+] ; $49ab
	ld d, [hl] ; $49ac
	ld e, a ; $49ad
	ld a, [$c494] ; $49ae
	add a, a ; $49b1
	add a, $35 ; $49b2
	ld l, a ; $49b4
	adc a, $50 ; $49b5
	sub a, l ; $49b7
	ld h, a ; $49b8
	ld a, [hl+] ; $49b9
	ld h, [hl] ; $49ba
	ld l, a ; $49bb
	call CopyTextRectPair ; $49bc
	pop bc ; $49bf
	ld a, [$c494] ; $49c0
	rst Rst00 ; $49c3
	dw Label_00_03ae ; $49c4 jumptable
	dw Label_00_03ae ; $49c6 jumptable
	dw Label_00_03ae ; $49c8 jumptable
	dw DrawScoreboardDrillResultRow ; $49ca jumptable
	dw DrawScoreboardDrillResultRows ; $49cc jumptable
	dw DrawScoreboardPointPips ; $49ce jumptable
	dw Label_00_03ae ; $49d0 jumptable
	dw Label_00_03ae ; $49d2 jumptable
	ret ; $49d4
DrawScoreboardDrillResultRows:
	ld de, $0504 ; $49d5
	ld c, $04 ; $49d8
	call DrawScoreboardEmptyPips ; $49da
	ld a, [$c2fd] ; $49dd
	ld c, a ; $49e0
	call DrawScoreboardPackedPips ; $49e1
DrawScoreboardDrillResultRow:
	ld de, $0502 ; $49e4
	ld c, $04 ; $49e7
	call DrawScoreboardEmptyPips ; $49e9
	ld a, [$c2fc] ; $49ec
	ld c, a ; $49ef
	call DrawScoreboardPackedPips ; $49f0
	ret ; $49f3
DrawScoreboardPointPips:
	ld de, $0302 ; $49f4
	ld c, $05 ; $49f7
	call DrawScoreboardEmptyPips ; $49f9
	ld a, [wPlayer1PointsWon] ; $49fc
	ld c, a ; $49ff
	call DrawScoreboardFilledPips ; $4a00
	ld de, $0304 ; $4a03
	ld c, $05 ; $4a06
	call DrawScoreboardEmptyPips ; $4a08
	ld a, [wPlayer2PointsWon] ; $4a0b
	ld c, a ; $4a0e
	call DrawScoreboardFilledPips ; $4a0f
	ret ; $4a12
DrawScoreboardPackedPips:
	ld hl, $c4e3 ; $4a13
	ld a, [hl+] ; $4a16
	ld h, [hl] ; $4a17
	ld l, a ; $4a18
	add hl, de ; $4a19
	ld e, l ; $4a1a
	ld d, h ; $4a1b
Label_06_4a1c:
	push bc ; $4a1c
	push de ; $4a1d
	ld hl, $4a2f ; $4a1e
	push hl ; $4a21
	ld a, c ; $4a22
	and a, $03 ; $4a23
	ld a, a ; $4a25
	rst Rst00 ; $4a26
	dw Label_00_03ae ; $4a27 jumptable
	dw DrawScoreboardPipFilled ; $4a29 jumptable
	dw DrawScoreboardPipAlt ; $4a2b jumptable
	dw DrawScoreboardPipAlt ; $4a2d jumptable
	pop de ; $4a2f
	pop bc ; $4a30
	inc d ; $4a31
	inc d ; $4a32
	srl c ; $4a33
	srl c ; $4a35
	jr nz, Label_06_4a1c ; $4a37
	ret ; $4a39
DrawScoreboardFilledPips:
	inc c ; $4a3a
	dec c ; $4a3b
	ret z ; $4a3c
	ld hl, $c4e3 ; $4a3d
	ld a, [hl+] ; $4a40
	ld h, [hl] ; $4a41
	ld l, a ; $4a42
	add hl, de ; $4a43
	ld e, l ; $4a44
	ld d, h ; $4a45
Label_06_4a46:
	push bc ; $4a46
	push de ; $4a47
	call DrawScoreboardPipFilled ; $4a48
	pop de ; $4a4b
	pop bc ; $4a4c
	inc d ; $4a4d
	inc d ; $4a4e
	dec c ; $4a4f
	jr nz, Label_06_4a46 ; $4a50
	ret ; $4a52
DrawScoreboardEmptyPips:
	inc b ; $4a53
	dec b ; $4a54
	ret z ; $4a55
	push de ; $4a56
	ld hl, $c4e3 ; $4a57
	ld a, [hl+] ; $4a5a
	ld h, [hl] ; $4a5b
	ld l, a ; $4a5c
	add hl, de ; $4a5d
	ld e, l ; $4a5e
	ld d, h ; $4a5f
Label_06_4a60:
	push bc ; $4a60
	push de ; $4a61
	call DrawScoreboardPipEmpty ; $4a62
	pop de ; $4a65
	pop bc ; $4a66
	inc d ; $4a67
	inc d ; $4a68
	dec c ; $4a69
	jr nz, Label_06_4a60 ; $4a6a
	pop de ; $4a6c
	ret ; $4a6d
DrawScoreboardPipFilled:
	ld hl, $4a9b ; $4a6e
	call CopyTextRectPair ; $4a71
	ret ; $4a74
DrawScoreboardPipAlt:
	ld hl, $4aa1 ; $4a75
	call CopyTextRectPair ; $4a78
	ret ; $4a7b
DrawScoreboardPipEmpty:
	ld hl, $4aa7 ; $4a7c
	call CopyTextRectPair ; $4a7f
	ret ; $4a82
	; $4a83, 1474 bytes (bytes:4)
	db $0a, $0b, $1a, $1b ; 0x00
	db $0c, $0d, $1c, $1d ; 0x04
	db $0e, $0f, $1e, $1f ; 0x08
	db $01, $01, $01, $01 ; 0x0c
	db $01, $01, $01, $01 ; 0x10
	db $01, $01, $01, $01 ; 0x14
	db $02, $02, $83, $4a ; 0x18
	db $8f, $4a, $02, $02 ; 0x1c
	db $87, $4a, $93, $4a ; 0x20
	db $02, $02, $8b, $4a ; 0x24
	db $97, $4a, $02, $03 ; 0x28
	db $03, $03, $03, $03 ; 0x2c
	db $03, $03, $03, $03 ; 0x30
	db $03, $03, $03, $03 ; 0x34
	db $03, $03, $03, $03 ; 0x38
	db $04, $05, $20, $20 ; 0x3c
	db $20, $20, $20, $20 ; 0x40
	db $20, $20, $20, $20 ; 0x44
	db $20, $20, $20, $20 ; 0x48
	db $20, $20, $20, $06 ; 0x4c
	db $05, $20, $20, $20 ; 0x50
	db $20, $20, $20, $20 ; 0x54
	db $20, $20, $20, $20 ; 0x58
	db $20, $20, $20, $20 ; 0x5c
	db $20, $20, $06, $05 ; 0x60
	db $20, $20, $20, $20 ; 0x64
	db $20, $20, $20, $20 ; 0x68
	db $20, $20, $20, $20 ; 0x6c
	db $20, $20, $20, $20 ; 0x70
	db $20, $06, $05, $20 ; 0x74
	db $20, $20, $20, $20 ; 0x78
	db $20, $20, $20, $20 ; 0x7c
	db $20, $20, $20, $20 ; 0x80
	db $20, $20, $20, $20 ; 0x84
	db $06, $05, $20, $20 ; 0x88
	db $20, $20, $20, $20 ; 0x8c
	db $20, $20, $20, $20 ; 0x90
	db $20, $20, $20, $20 ; 0x94
	db $20, $20, $20, $06 ; 0x98
	db $07, $08, $08, $08 ; 0x9c
	db $08, $08, $08, $08 ; 0xa0
	db $08, $08, $08, $08 ; 0xa4
	db $08, $08, $08, $08 ; 0xa8
	db $08, $08, $09, $02 ; 0xac
	db $03, $03, $03, $03 ; 0xb0
	db $03, $03, $03, $03 ; 0xb4
	db $03, $03, $03, $03 ; 0xb8
	db $03, $03, $03, $03 ; 0xbc
	db $03, $04, $05, $20 ; 0xc0
	db $20, $20, $20, $31 ; 0xc4
	db $20, $32, $20, $33 ; 0xc8
	db $20, $34, $20, $20 ; 0xcc
	db $20, $20, $20, $20 ; 0xd0
	db $06, $05, $20, $20 ; 0xd4
	db $20, $20, $15, $15 ; 0xd8
	db $15, $15, $15, $15 ; 0xdc
	db $15, $15, $20, $15 ; 0xe0
	db $16, $16, $15, $06 ; 0xe4
	db $05, $20, $20, $20 ; 0xe8
	db $20, $15, $15, $15 ; 0xec
	db $15, $15, $15, $15 ; 0xf0
	db $15, $20, $15, $16 ; 0xf4
	db $16, $15, $06, $07 ; 0xf8
	db $08, $08, $08, $08 ; 0xfc
	db $08, $08, $08, $08 ; 0x100
	db $08, $08, $08, $08 ; 0x104
	db $08, $08, $08, $08 ; 0x108
	db $08, $09, $02, $03 ; 0x10c
	db $03, $03, $03, $03 ; 0x110
	db $03, $03, $03, $03 ; 0x114
	db $03, $03, $03, $03 ; 0x118
	db $03, $03, $03, $03 ; 0x11c
	db $04, $05, $20, $20 ; 0x120
	db $20, $20, $31, $20 ; 0x124
	db $32, $20, $33, $20 ; 0x128
	db $34, $20, $20, $20 ; 0x12c
	db $20, $20, $20, $06 ; 0x130
	db $05, $20, $20, $20 ; 0x134
	db $20, $15, $15, $15 ; 0x138
	db $15, $15, $15, $15 ; 0x13c
	db $15, $20, $15, $16 ; 0x140
	db $16, $15, $06, $05 ; 0x144
	db $20, $20, $20, $20 ; 0x148
	db $15, $15, $15, $15 ; 0x14c
	db $15, $15, $15, $15 ; 0x150
	db $20, $15, $16, $16 ; 0x154
	db $15, $06, $05, $20 ; 0x158
	db $20, $20, $20, $15 ; 0x15c
	db $15, $15, $15, $15 ; 0x160
	db $15, $15, $15, $20 ; 0x164
	db $15, $16, $16, $15 ; 0x168
	db $06, $05, $20, $20 ; 0x16c
	db $20, $20, $15, $15 ; 0x170
	db $15, $15, $15, $15 ; 0x174
	db $15, $15, $20, $15 ; 0x178
	db $16, $16, $15, $06 ; 0x17c
	db $07, $08, $08, $08 ; 0x180
	db $08, $08, $08, $08 ; 0x184
	db $08, $08, $08, $08 ; 0x188
	db $08, $08, $08, $08 ; 0x18c
	db $08, $08, $09, $02 ; 0x190
	db $03, $03, $03, $03 ; 0x194
	db $03, $03, $03, $03 ; 0x198
	db $03, $03, $03, $03 ; 0x19c
	db $03, $03, $03, $03 ; 0x1a0
	db $03, $04, $05, $20 ; 0x1a4
	db $20, $20, $20, $20 ; 0x1a8
	db $20, $20, $20, $20 ; 0x1ac
	db $20, $20, $20, $20 ; 0x1b0
	db $20, $20, $20, $20 ; 0x1b4
	db $06, $05, $20, $20 ; 0x1b8
	db $15, $15, $15, $15 ; 0x1bc
	db $15, $15, $15, $15 ; 0x1c0
	db $15, $15, $20, $15 ; 0x1c4
	db $16, $16, $15, $06 ; 0x1c8
	db $05, $20, $20, $15 ; 0x1cc
	db $15, $15, $15, $15 ; 0x1d0
	db $15, $15, $15, $15 ; 0x1d4
	db $15, $20, $15, $16 ; 0x1d8
	db $16, $15, $06, $05 ; 0x1dc
	db $20, $20, $15, $15 ; 0x1e0
	db $15, $15, $15, $15 ; 0x1e4
	db $15, $15, $15, $15 ; 0x1e8
	db $20, $15, $16, $16 ; 0x1ec
	db $15, $06, $05, $20 ; 0x1f0
	db $20, $15, $15, $15 ; 0x1f4
	db $15, $15, $15, $15 ; 0x1f8
	db $15, $15, $15, $20 ; 0x1fc
	db $15, $16, $16, $15 ; 0x200
	db $06, $07, $08, $08 ; 0x204
	db $08, $08, $08, $08 ; 0x208
	db $08, $08, $08, $08 ; 0x20c
	db $08, $08, $08, $08 ; 0x210
	db $08, $08, $08, $09 ; 0x214
	db $02, $03, $03, $03 ; 0x218
	db $03, $03, $03, $03 ; 0x21c
	db $03, $03, $03, $03 ; 0x220
	db $03, $04, $05, $20 ; 0x224
	db $20, $20, $20, $20 ; 0x228
	db $20, $20, $20, $15 ; 0x22c
	db $16, $16, $15, $06 ; 0x230
	db $05, $20, $20, $20 ; 0x234
	db $20, $20, $20, $20 ; 0x238
	db $20, $15, $16, $16 ; 0x23c
	db $15, $06, $05, $30 ; 0x240
	db $30, $30, $30, $30 ; 0x244
	db $30, $30, $30, $30 ; 0x248
	db $30, $30, $30, $06 ; 0x24c
	db $05, $20, $20, $20 ; 0x250
	db $20, $20, $20, $20 ; 0x254
	db $20, $15, $16, $16 ; 0x258
	db $15, $06, $05, $20 ; 0x25c
	db $20, $20, $20, $20 ; 0x260
	db $20, $20, $20, $15 ; 0x264
	db $16, $16, $15, $06 ; 0x268
	db $07, $08, $08, $08 ; 0x26c
	db $08, $08, $08, $08 ; 0x270
	db $08, $08, $08, $08 ; 0x274
	db $08, $09, $02, $03 ; 0x278
	db $03, $03, $03, $03 ; 0x27c
	db $03, $03, $03, $03 ; 0x280
	db $03, $03, $03, $04 ; 0x284
	db $05, $20, $20, $20 ; 0x288
	db $20, $20, $20, $20 ; 0x28c
	db $20, $15, $16, $16 ; 0x290
	db $15, $06, $05, $20 ; 0x294
	db $20, $20, $20, $20 ; 0x298
	db $20, $20, $20, $15 ; 0x29c
	db $16, $16, $15, $06 ; 0x2a0
	db $05, $30, $30, $30 ; 0x2a4
	db $30, $30, $30, $30 ; 0x2a8
	db $30, $30, $30, $30 ; 0x2ac
	db $30, $06, $05, $20 ; 0x2b0
	db $20, $20, $20, $20 ; 0x2b4
	db $20, $20, $20, $15 ; 0x2b8
	db $16, $16, $15, $06 ; 0x2bc
	db $05, $20, $20, $20 ; 0x2c0
	db $20, $20, $20, $20 ; 0x2c4
	db $20, $15, $16, $16 ; 0x2c8
	db $15, $06, $07, $08 ; 0x2cc
	db $08, $08, $08, $08 ; 0x2d0
	db $08, $08, $08, $08 ; 0x2d4
	db $08, $08, $08, $09 ; 0x2d8
	db $00, $00, $00, $00 ; 0x2dc
	db $00, $00, $00, $00 ; 0x2e0
	db $00, $00, $00, $00 ; 0x2e4
	db $00, $00, $00, $00 ; 0x2e8
	db $00, $00, $00, $00 ; 0x2ec
	db $00, $00, $00, $00 ; 0x2f0
	db $00, $00, $00, $00 ; 0x2f4
	db $00, $00, $00, $00 ; 0x2f8
	db $00, $00, $00, $00 ; 0x2fc
	db $00, $00, $00, $00 ; 0x300
	db $00, $00, $00, $00 ; 0x304
	db $00, $00, $00, $00 ; 0x308
	db $00, $00, $00, $00 ; 0x30c
	db $00, $00, $00, $00 ; 0x310
	db $00, $00, $00, $00 ; 0x314
	db $00, $00, $00, $00 ; 0x318
	db $00, $00, $00, $00 ; 0x31c
	db $00, $00, $00, $00 ; 0x320
	db $00, $00, $00, $00 ; 0x324
	db $00, $00, $00, $00 ; 0x328
	db $00, $00, $00, $00 ; 0x32c
	db $00, $00, $00, $00 ; 0x330
	db $00, $00, $00, $00 ; 0x334
	db $00, $00, $00, $00 ; 0x338
	db $00, $00, $00, $00 ; 0x33c
	db $00, $00, $00, $00 ; 0x340
	db $00, $00, $00, $00 ; 0x344
	db $00, $00, $00, $00 ; 0x348
	db $00, $00, $00, $00 ; 0x34c
	db $00, $00, $00, $00 ; 0x350
	db $00, $00, $00, $00 ; 0x354
	db $00, $00, $00, $00 ; 0x358
	db $00, $00, $00, $00 ; 0x35c
	db $00, $00, $00, $00 ; 0x360
	db $00, $00, $00, $00 ; 0x364
	db $00, $00, $00, $00 ; 0x368
	db $00, $00, $00, $00 ; 0x36c
	db $00, $00, $00, $00 ; 0x370
	db $00, $00, $00, $00 ; 0x374
	db $00, $00, $00, $00 ; 0x378
	db $00, $00, $00, $00 ; 0x37c
	db $00, $00, $00, $00 ; 0x380
	db $00, $00, $00, $00 ; 0x384
	db $00, $00, $00, $00 ; 0x388
	db $01, $21, $01, $21 ; 0x38c
	db $01, $21, $01, $21 ; 0x390
	db $00, $01, $01, $01 ; 0x394
	db $21, $00, $00, $00 ; 0x398
	db $00, $00, $00, $41 ; 0x39c
	db $61, $41, $61, $41 ; 0x3a0
	db $61, $41, $61, $00 ; 0x3a4
	db $41, $41, $41, $61 ; 0x3a8
	db $00, $00, $00, $00 ; 0x3ac
	db $00, $00, $00, $00 ; 0x3b0
	db $00, $00, $00, $00 ; 0x3b4
	db $00, $00, $00, $00 ; 0x3b8
	db $00, $00, $00, $00 ; 0x3bc
	db $00, $00, $00, $00 ; 0x3c0
	db $00, $00, $00, $00 ; 0x3c4
	db $00, $00, $00, $00 ; 0x3c8
	db $00, $00, $00, $00 ; 0x3cc
	db $00, $00, $00, $00 ; 0x3d0
	db $00, $00, $00, $00 ; 0x3d4
	db $00, $00, $00, $00 ; 0x3d8
	db $00, $00, $00, $00 ; 0x3dc
	db $00, $00, $00, $00 ; 0x3e0
	db $00, $00, $00, $00 ; 0x3e4
	db $00, $00, $00, $01 ; 0x3e8
	db $21, $01, $21, $01 ; 0x3ec
	db $21, $01, $21, $00 ; 0x3f0
	db $01, $01, $01, $21 ; 0x3f4
	db $00, $00, $00, $00 ; 0x3f8
	db $00, $00, $41, $61 ; 0x3fc
	db $41, $61, $41, $61 ; 0x400
	db $41, $61, $00, $41 ; 0x404
	db $41, $41, $61, $00 ; 0x408
	db $00, $00, $00, $00 ; 0x40c
	db $00, $01, $21, $01 ; 0x410
	db $21, $01, $21, $01 ; 0x414
	db $21, $00, $01, $01 ; 0x418
	db $01, $21, $00, $00 ; 0x41c
	db $00, $00, $00, $00 ; 0x420
	db $41, $61, $41, $61 ; 0x424
	db $41, $61, $41, $61 ; 0x428
	db $00, $41, $41, $41 ; 0x42c
	db $61, $00, $00, $00 ; 0x430
	db $00, $00, $00, $00 ; 0x434
	db $00, $00, $00, $00 ; 0x438
	db $00, $00, $00, $00 ; 0x43c
	db $00, $00, $00, $00 ; 0x440
	db $00, $00, $00, $00 ; 0x444
	db $00, $00, $00, $00 ; 0x448
	db $00, $00, $00, $00 ; 0x44c
	db $00, $00, $00, $00 ; 0x450
	db $00, $00, $00, $00 ; 0x454
	db $00, $00, $00, $00 ; 0x458
	db $00, $00, $00, $00 ; 0x45c
	db $00, $00, $00, $00 ; 0x460
	db $00, $00, $00, $00 ; 0x464
	db $00, $00, $00, $00 ; 0x468
	db $00, $00, $01, $21 ; 0x46c
	db $01, $21, $01, $21 ; 0x470
	db $01, $21, $01, $21 ; 0x474
	db $00, $01, $01, $01 ; 0x478
	db $21, $00, $00, $00 ; 0x47c
	db $00, $41, $61, $41 ; 0x480
	db $61, $41, $61, $41 ; 0x484
	db $61, $41, $61, $00 ; 0x488
	db $41, $41, $41, $61 ; 0x48c
	db $00, $00, $00, $00 ; 0x490
	db $01, $21, $01, $21 ; 0x494
	db $01, $21, $01, $21 ; 0x498
	db $01, $21, $00, $01 ; 0x49c
	db $01, $01, $21, $00 ; 0x4a0
	db $00, $00, $00, $41 ; 0x4a4
	db $61, $41, $61, $41 ; 0x4a8
	db $61, $41, $61, $41 ; 0x4ac
	db $61, $00, $41, $41 ; 0x4b0
	db $41, $61, $00, $00 ; 0x4b4
	db $00, $00, $00, $00 ; 0x4b8
	db $00, $00, $00, $00 ; 0x4bc
	db $00, $00, $00, $00 ; 0x4c0
	db $00, $00, $00, $00 ; 0x4c4
	db $00, $00, $00, $00 ; 0x4c8
	db $00, $00, $00, $00 ; 0x4cc
	db $00, $00, $00, $00 ; 0x4d0
	db $00, $00, $00, $00 ; 0x4d4
	db $00, $00, $00, $00 ; 0x4d8
	db $00, $00, $00, $00 ; 0x4dc
	db $00, $01, $01, $01 ; 0x4e0
	db $21, $00, $00, $00 ; 0x4e4
	db $00, $00, $00, $00 ; 0x4e8
	db $00, $00, $00, $41 ; 0x4ec
	db $41, $41, $61, $00 ; 0x4f0
	db $00, $00, $00, $00 ; 0x4f4
	db $00, $00, $00, $00 ; 0x4f8
	db $00, $00, $00, $00 ; 0x4fc
	db $00, $00, $00, $00 ; 0x500
	db $00, $00, $00, $00 ; 0x504
	db $00, $00, $00, $01 ; 0x508
	db $01, $01, $21, $00 ; 0x50c
	db $00, $00, $00, $00 ; 0x510
	db $00, $00, $00, $00 ; 0x514
	db $00, $41, $41, $41 ; 0x518
	db $61, $00, $00, $00 ; 0x51c
	db $00, $00, $00, $00 ; 0x520
	db $00, $00, $00, $00 ; 0x524
	db $00, $00, $00, $00 ; 0x528
	db $00, $00, $00, $00 ; 0x52c
	db $00, $00, $00, $00 ; 0x530
	db $00, $00, $00, $00 ; 0x534
	db $00, $00, $00, $00 ; 0x538
	db $00, $00, $00, $00 ; 0x53c
	db $00, $00, $00, $01 ; 0x540
	db $01, $01, $21, $00 ; 0x544
	db $00, $00, $00, $00 ; 0x548
	db $00, $00, $00, $00 ; 0x54c
	db $00, $41, $41, $41 ; 0x550
	db $61, $00, $00, $00 ; 0x554
	db $00, $00, $00, $00 ; 0x558
	db $00, $00, $00, $00 ; 0x55c
	db $00, $00, $00, $00 ; 0x560
	db $00, $00, $00, $00 ; 0x564
	db $00, $00, $00, $00 ; 0x568
	db $00, $01, $01, $01 ; 0x56c
	db $21, $00, $00, $00 ; 0x570
	db $00, $00, $00, $00 ; 0x574
	db $00, $00, $00, $41 ; 0x578
	db $41, $41, $61, $00 ; 0x57c
	db $00, $00, $00, $00 ; 0x580
	db $00, $00, $00, $00 ; 0x584
	db $00, $00, $00, $00 ; 0x588
	db $00, $00, $07, $13 ; 0x58c
	db $ad, $4a, $5f, $4d ; 0x590
	db $05, $13, $32, $4b ; 0x594
	db $e4, $4d, $07, $13 ; 0x598
	db $91, $4b, $43, $4e ; 0x59c
	db $07, $13, $16, $4c ; 0x5a0
	db $c8, $4e, $07, $0e ; 0x5a4
	db $9b, $4c, $4d, $4f ; 0x5a8
	db $07, $0e, $fd, $4c ; 0x5ac
	db $af, $4f, $11, $50 ; 0x5b0
	db $11, $50, $11, $50 ; 0x5b4
	db $17, $50, $1d, $50 ; 0x5b8
	db $23, $50, $29, $50 ; 0x5bc
	db $2f, $50 ; 0x5c0
CopyTextRectPair:
	push de ; $5045
	push hl ; $5046
	push hl ; $5047
	call GetShadowTilemapAddr ; $5048
	pop hl ; $504b
	ld a, [hl+] ; $504c
	ld c, a ; $504d
	ld a, [hl+] ; $504e
	ld b, a ; $504f
	ld a, [hl+] ; $5050
	ld h, [hl] ; $5051
	ld l, a ; $5052
	call CopyTextRect ; $5053
	pop hl ; $5056
	pop de ; $5057
	push hl ; $5058
	call GetShadowAttrmapAddr ; $5059
	pop hl ; $505c
	ld a, [hl+] ; $505d
	ld c, a ; $505e
	ld a, [hl+] ; $505f
	ld b, a ; $5060
	inc hl ; $5061
	inc hl ; $5062
	ld a, [hl+] ; $5063
	ld h, [hl] ; $5064
	ld l, a ; $5065
	call CopyTextRect ; $5066
	ret ; $5069
Func_06_506a:
	ld a, [$c4e4] ; $506a
	ld h, a ; $506d
	ld a, [$c4e3] ; $506e
	ld l, a ; $5071
	add hl, hl ; $5072
	add hl, hl ; $5073
	add hl, hl ; $5074
	ld e, l ; $5075
	ld d, h ; $5076
	push de ; $5077
	call AdjustSpriteCoordsForScroll ; $5078
	ld a, [$c494] ; $507b
	add a, a ; $507e
	add a, $9c ; $507f
	ld l, a ; $5081
	adc a, $50 ; $5082
	sub a, l ; $5084
	ld h, a ; $5085
	ld a, [hl+] ; $5086
	ld h, [hl] ; $5087
	ld l, a ; $5088
	ld bc, $0000 ; $5089
	call QueueSpriteTemplate ; $508c
	pop de ; $508f
	ld a, [$c494] ; $5090
	cp a, $06 ; $5093
	jr z, Label_06_50ac ; $5095
	cp a, $07 ; $5097
	jr z, Label_06_50ac ; $5099
	ret ; $509b
	; $509c, 16 bytes (records:2)
	dw $50e2 ; record 0
	dw $5123 ; record 1
	dw $516c ; record 2
	dw $51ff ; record 3
	dw $51bd ; record 4
	dw $51de ; record 5
	dw $5210 ; record 6
	dw $5210 ; record 7
Label_06_50ac:
	ld hl, $4c0c ; $50ac
	add hl, de ; $50af
	ld e, l ; $50b0
	ld d, h ; $50b1
	push de ; $50b2
	call AdjustSpriteCoordsForScroll ; $50b3
	ld hl, wMinigamesCurrentScore ; $50b6
	ld a, [hl+] ; $50b9
	ld h, [hl] ; $50ba
	ld l, a ; $50bb
	ld b, $01 ; $50bc
	ld a, $04 ; $50be
	farcall FarPtr_DrawNumberWithSprites ; $50c0
	pop de ; $50c3
	ld a, e ; $50c4
	add a, $18 ; $50c5
	ld e, a ; $50c7
	call AdjustSpriteCoordsForScroll ; $50c8
	ld a, [$c7bc] ; $50cb
	and a, a ; $50ce
	ld hl, $c4ec ; $50cf
	jr nz, Label_06_50d7 ; $50d2
	ld hl, wMinigamesTargetScore ; $50d4
Label_06_50d7:
	ld a, [hl+] ; $50d7
	ld h, [hl] ; $50d8
	ld l, a ; $50d9
	ld b, $02 ; $50da
	ld a, $04 ; $50dc
	farcall FarPtr_DrawNumberWithSprites ; $50de
	ret ; $50e1
	; $50e2, 311 bytes (bytes:4)
	db $20, $18, $00, $04 ; 0x00
	db $20, $20, $02, $04 ; 0x04
	db $20, $40, $68, $01 ; 0x08
	db $20, $48, $6a, $01 ; 0x0c
	db $20, $60, $70, $01 ; 0x10
	db $20, $68, $72, $01 ; 0x14
	db $20, $80, $78, $01 ; 0x18
	db $20, $88, $7a, $01 ; 0x1c
	db $30, $18, $08, $05 ; 0x20
	db $30, $20, $0a, $05 ; 0x24
	db $30, $40, $6c, $01 ; 0x28
	db $30, $48, $6e, $01 ; 0x2c
	db $30, $60, $74, $01 ; 0x30
	db $30, $68, $76, $01 ; 0x34
	db $30, $80, $7c, $01 ; 0x38
	db $30, $88, $7e, $01 ; 0x3c
	db $80, $20, $18, $00 ; 0x40
	db $04, $20, $20, $02 ; 0x44
	db $04, $20, $40, $68 ; 0x48
	db $01, $20, $48, $6a ; 0x4c
	db $01, $20, $60, $70 ; 0x50
	db $01, $20, $68, $72 ; 0x54
	db $01, $20, $80, $78 ; 0x58
	db $01, $20, $88, $7a ; 0x5c
	db $01, $30, $10, $08 ; 0x60
	db $05, $30, $18, $0a ; 0x64
	db $05, $30, $20, $18 ; 0x68
	db $07, $30, $28, $1a ; 0x6c
	db $07, $30, $40, $6c ; 0x70
	db $01, $30, $48, $6e ; 0x74
	db $01, $30, $60, $74 ; 0x78
	db $01, $30, $68, $76 ; 0x7c
	db $01, $30, $80, $7c ; 0x80
	db $01, $30, $88, $7e ; 0x84
	db $01, $80, $20, $10 ; 0x88
	db $00, $04, $20, $18 ; 0x8c
	db $02, $04, $20, $20 ; 0x90
	db $10, $06, $20, $28 ; 0x94
	db $12, $06, $20, $40 ; 0x98
	db $68, $01, $20, $48 ; 0x9c
	db $6a, $01, $20, $60 ; 0xa0
	db $70, $01, $20, $68 ; 0xa4
	db $72, $01, $20, $80 ; 0xa8
	db $78, $01, $20, $88 ; 0xac
	db $7a, $01, $30, $10 ; 0xb0
	db $08, $05, $30, $18 ; 0xb4
	db $0a, $05, $30, $20 ; 0xb8
	db $18, $07, $30, $28 ; 0xbc
	db $1a, $07, $30, $40 ; 0xc0
	db $6c, $01, $30, $48 ; 0xc4
	db $6e, $01, $30, $60 ; 0xc8
	db $74, $01, $30, $68 ; 0xcc
	db $76, $01, $30, $80 ; 0xd0
	db $7c, $01, $30, $88 ; 0xd4
	db $7e, $01, $80, $20 ; 0xd8
	db $18, $00, $04, $20 ; 0xdc
	db $20, $02, $04, $20 ; 0xe0
	db $80, $78, $01, $20 ; 0xe4
	db $88, $7a, $01, $30 ; 0xe8
	db $18, $08, $05, $30 ; 0xec
	db $20, $0a, $05, $30 ; 0xf0
	db $80, $7c, $01, $30 ; 0xf4
	db $88, $7e, $01, $80 ; 0xf8
	db $20, $0e, $00, $04 ; 0xfc
	db $20, $16, $02, $04 ; 0x100
	db $20, $80, $78, $01 ; 0x104
	db $20, $88, $7a, $01 ; 0x108
	db $30, $0e, $08, $05 ; 0x10c
	db $30, $16, $0a, $05 ; 0x110
	db $30, $80, $7c, $01 ; 0x114
	db $30, $88, $7e, $01 ; 0x118
	db $80, $20, $18, $00 ; 0x11c
	db $04, $20, $20, $02 ; 0x120
	db $04, $20, $80, $78 ; 0x124
	db $01, $20, $88, $7a ; 0x128
	db $01, $80, $18, $14 ; 0x12c
	db $00, $04, $18, $1c ; 0x130
	db $02, $04, $80 ; 0x134
LoadMatchMenuItemGfx:
	add a, a ; $5219
	add a, $44 ; $521a
	ld l, a ; $521c
	adc a, $52 ; $521d
	sub a, l ; $521f
	ld h, a ; $5220
	ld a, [hl+] ; $5221
	ld h, [hl] ; $5222
	ld l, a ; $5223
	ld de, $d000 ; $5224
	ldh a, [hWramBank] ; $5227
	push af ; $5229
	wram_bank $01 ; $522a
	call DecompressData ; $5230
	ld hl, $d000 ; $5233
	ld de, $8400 ; $5236
	ld c, $10 ; $5239
	call QueueVRAMCopy ; $523b
	pop af ; $523e
	wram_bank ; $523f
	ret ; $5243
	; $5244, 2630 bytes (records:2)
	dw $52c0 ; record 0
	dw $5342 ; record 1
	dw $5402 ; record 2
	dw $5495 ; record 3
	dw $5519 ; record 4
	dw $55c5 ; record 5
	dw $5648 ; record 6
	dw $56c1 ; record 7
	dw $5745 ; record 8
	dw $57c1 ; record 9
	dw $5844 ; record 10
	dw $58c5 ; record 11
	dw $5938 ; record 12
	dw $59e8 ; record 13
	dw $5a9a ; record 14
	dw $5a9a ; record 15
	dw $5a9a ; record 16
	dw $5a9a ; record 17
	dw $5a9a ; record 18
	dw $5b35 ; record 19
	dw $5bda ; record 20
	dw $5bda ; record 21
	dw $5bda ; record 22
	dw $5bda ; record 23
	dw $0000 ; record 24
	dw $0000 ; record 25
	dw $0000 ; record 26
	dw $0000 ; record 27
	dw $0000 ; record 28
	dw $0000 ; record 29
	dw $0000 ; record 30
	dw $0000 ; record 31
	dw $0000 ; record 32
	dw $0000 ; record 33
	dw $0000 ; record 34
	dw $0000 ; record 35
	dw $0000 ; record 36
	dw $0000 ; record 37
	dw $0000 ; record 38
	dw $0000 ; record 39
	dw $0000 ; record 40
	dw $0100 ; record 41
	dw $0100 ; record 42
	dw $0300 ; record 43
	dw $0201 ; record 44
	dw $0601 ; record 45
	dw $0000 ; record 46
	dw $0000 ; record 47
	dw $0000 ; record 48
	dw $0000 ; record 49
	dw $0000 ; record 50
	dw $0000 ; record 51
	dw $0000 ; record 52
	dw $0000 ; record 53
	dw $0000 ; record 54
	dw $0000 ; record 55
	dw $0000 ; record 56
	dw $8000 ; record 57
	dw $8000 ; record 58
	dw $c000 ; record 59
	dw $4080 ; record 60
	dw $6080 ; record 61
	dw $00fd ; record 62
	dw $ffff ; record 63
	dw $0f1f ; record 64
	dw $1f30 ; record 65
	dw $1e23 ; record 66
	dw $fe7e ; record 67
	dw $1fec ; record 68
	dw $0f23 ; record 69
	dw $0030 ; record 70
	dw $c31f ; record 71
	dw $fbe2 ; record 72
	dw $ffff ; record 73
	dw $e0fd ; record 74
	dw $ff0c ; record 75
	dw $ff04 ; record 76
	dw $7a64 ; record 77
	dw $e0fc ; record 78
	dw $fa0c ; record 79
	dw $64e0 ; record 80
	dw $66ff ; record 81
	dw $ffff ; record 82
	dw $7ee0 ; record 83
	dw $e0e6 ; record 84
	dw $0000 ; record 85
	dw $0c03 ; record 86
	dw $f807 ; record 87
	dw $e1e0 ; record 88
	dw $c9dd ; record 89
	dw $e8fe ; record 90
	dw $ff08 ; record 91
	dw $e018 ; record 92
	dw $c0e6 ; record 93
	dw $5b30 ; record 94
	dw $1fe0 ; record 95
	dw $e0c0 ; record 96
	dw $f01f ; record 97
	dw $e0fe ; record 98
	dw $faf3 ; record 99
	dw $e3e3 ; record 100
	dw $10ff ; record 101
	dw $e0fe ; record 102
	dw $e5c0 ; record 103
	dw $e5a0 ; record 104
	dw $ff30 ; record 105
	dw $bb20 ; record 106
	dw $e7ff ; record 107
	dw $e0fc ; record 108
	dw $ff30 ; record 109
	dw $f6fe ; record 110
	dw $20e0 ; record 111
	dw $e07e ; record 112
	dw $f8e9 ; record 113
	dw $0cf0 ; record 114
	dw $c4f8 ; record 115
	dw $fe78 ; record 116
	dw $f1e0 ; record 117
	dw $fef8 ; record 118
	dw $f8e0 ; record 119
	dw $f6e1 ; record 120
	dw $84e2 ; record 121
	dw $0cf0 ; record 122
	dw $0100 ; record 123
	dw $23f8 ; record 124
	dw $00ff ; record 125
	dw $0000 ; record 126
	dw $00ff ; record 127
	dw $0000 ; record 128
	dw $1f3f ; record 129
	dw $3f60 ; record 130
	dw $df47 ; record 131
	dw $4f3c ; record 132
	dw $4f38 ; record 133
	dw $fe39 ; record 134
	dw $38e4 ; record 135
	dw $ff4f ; record 136
	dw $4f3c ; record 137
	dw $473f ; record 138
	dw $601f ; record 139
	dw $3f00 ; record 140
	dw $e2de ; record 141
	dw $00e0 ; record 142
	dw $ff00 ; record 143
	dw $fdff ; record 144
	dw $30e0 ; record 145
	dw $3fff ; record 146
	dw $ff20 ; record 147
	dw $ffe6 ; record 148
	dw $3fe6 ; record 149
	dw $e0fe ; record 150
	dw $e0f6 ; record 151
	dw $30e3 ; record 152
	dw $ffff ; record 153
	dw $e6e0 ; record 154
	dw $e0e0 ; record 155
	dw $f7e6 ; record 156
	dw $ffdc ; record 157
	dw $4c5f ; record 158
	dw $44ff ; record 159
	dw $40ff ; record 160
	dw $e0fe ; record 161
	dw $f648 ; record 162
	dw $efe0 ; record 163
	dw $ffce ; record 164
	dw $fbff ; record 165
	dw $e3e0 ; record 166
	dw $0c03 ; record 167
	dw $f507 ; record 168
	dw $c0f8 ; record 169
	dw $81e1 ; record 170
	dw $e0fe ; record 171
	dw $ffe7 ; record 172
	dw $bde7 ; record 173
	dw $fef6 ; record 174
	dw $ffe5 ; record 175
	dw $c0bd ; record 176
	dw $c0e3 ; record 177
	dw $e030 ; record 178
	dw $7e1f ; record 179
	dw $e0a0 ; record 180
	dw $07fd ; record 181
	dw $02ff ; record 182
	dw $32ff ; record 183
	dw $e0fc ; record 184
	dw $06dd ; record 185
	dw $e0fa ; record 186
	dw $ff32 ; record 187
	dw $a033 ; record 188
	dw $ffed ; record 189
	dw $ef0c ; record 190
	dw $04ff ; record 191
	dw $64ff ; record 192
	dw $e4fe ; record 193
	dw $ff04 ; record 194
	dw $fc0e ; record 195
	dw $e6a0 ; record 196
	dw $e460 ; record 197
	dw $fc87 ; record 198
	dw $f88f ; record 199
	dw $f98f ; record 200
	dw $fc3e ; record 201
	dw $fce0 ; record 202
	dw $ff8f ; record 203
	dw $08ff ; record 204
	dw $e0fe ; record 205
	dw $e860 ; record 206
	dw $fcbf ; record 207
	dw $06f8 ; record 208
	dw $f2fc ; record 209
	dw $fe1c ; record 210
	dw $fce0 ; record 211
	dw $f2eb ; record 212
	dw $f83c ; record 213
	dw $9ce0 ; record 214
	dw $e0f4 ; record 215
	dw $f23c ; record 216
	dw $7ffc ; record 217
	dw $f8e2 ; record 218
	dw $0006 ; record 219
	dw $00fc ; record 220
	dw $0000 ; record 221
	dw $0000 ; record 222
	dw $00fd ; record 223
	dw $ffff ; record 224
	dw $0103 ; record 225
	dw $0306 ; record 226
	dw $0305 ; record 227
	dw $07fb ; record 228
	dw $fe02 ; record 229
	dw $03e8 ; record 230
	dw $0307 ; record 231
	dw $0105 ; record 232
	dw $06b7 ; record 233
	dw $0300 ; record 234
	dw $e2c3 ; record 235
	dw $ffff ; record 236
	dw $e0fd ; record 237
	dw $bf18 ; record 238
	dw $08ff ; record 239
	dw $49ff ; record 240
	dw $48ff ; record 241
	dw $e0fe ; record 242
	dw $1f49 ; record 243
	dw $09ff ; record 244
	dw $19ff ; record 245
	dw $ffff ; record 246
	dw $e6e0 ; record 247
	dw $c3e0 ; record 248
	dw $f7e0 ; record 249
	dw $070c ; record 250
	dw $e0f8 ; record 251
	dw $42e1 ; record 252
	dw $22ff ; record 253
	dw $fdff ; record 254
	dw $fe26 ; record 255
	dw $66e0 ; record 256
	dw $e6ff ; record 257
	dw $e6ff ; record 258
	dw $ef3f ; record 259
	dw $3fe6 ; record 260
	dw $3fff ; record 261
	dw $e3e0 ; record 262
	dw $30c0 ; record 263
	dw $9de0 ; record 264
	dw $c01f ; record 265
	dw $63e1 ; record 266
	dw $41ff ; record 267
	dw $e0c0 ; record 268
	dw $e3fe ; record 269
	dw $f841 ; record 270
	dw $e0f2 ; record 271
	dw $e5c0 ; record 272
	dw $e5a0 ; record 273
	dw $ff66 ; record 274
	dw $ff24 ; record 275
	dw $ae04 ; record 276
	dw $e0fe ; record 277
	dw $ff06 ; record 278
	dw $f607 ; record 279
	dw $34e0 ; record 280
	dw $e9e0 ; record 281
	dw $76e0 ; record 282
	dw $e0bc ; record 283
	dw $20f0 ; record 284
	dw $e0fe ; record 285
	dw $f0e0 ; record 286
	dw $f860 ; record 287
	dw $fde2 ; record 288
	dw $f820 ; record 289
	dw $e0e0 ; record 290
	dw $c0d0 ; record 291
	dw $0030 ; record 292
	dw $00e0 ; record 293
	dw $ff23 ; record 294
	dw $0000 ; record 295
	dw $7d00 ; record 296
	dw $ff00 ; record 297
	dw $01ff ; record 298
	dw $0300 ; record 299
	dw $0201 ; record 300
	dw $effe ; record 301
	dw $00f3 ; record 302
	dw $e603 ; record 303
	dw $c2e0 ; record 304
	dw $ffe1 ; record 305
	dw $00ff ; record 306
	dw $ffff ; record 307
	dw $e03f ; record 308
	dw $c07f ; record 309
	dw $cf7f ; record 310
	dw $c17f ; record 311
	dw $7fef ; record 312
	dw $7fe0 ; record 313
	dw $f6fc ; record 314
	dw $c1e0 ; record 315
	dw $ff7f ; record 316
	dw $7ffb ; record 317
	dw $e6ff ; record 318
	dw $00e0 ; record 319
	dw $0300 ; record 320
	dw $070c ; record 321
	dw $f8fd ; record 322
	dw $e0e0 ; record 323
	dw $c3ff ; record 324
	dw $81ff ; record 325
	dw $99ff ; record 326
	dw $fee2 ; record 327
	dw $81e0 ; record 328
	dw $e4f8 ; record 329
	dw $e0ff ; record 330
	dw $e2e0 ; record 331
	dw $30c0 ; record 332
	dw $ede0 ; record 333
	dw $c01f ; record 334
	dw $efe0 ; record 335
	dw $fe39 ; record 336
	dw $ffe5 ; record 337
	dw $ff11 ; record 338
	dw $833f ; record 339
	dw $c7ff ; record 340
	dw $ffff ; record 341
	dw $c07d ; record 342
	dw $a0e3 ; record 343
	dw $fbe4 ; record 344
	dw $03fe ; record 345
	dw $e0fe ; record 346
	dw $fe3f ; record 347
	dw $fc07 ; record 348
	dw $db07 ; record 349
	dw $3ffc ; record 350
	dw $e2f4 ; record 351
	dw $feff ; record 352
	dw $e6e0 ; record 353
	dw $0080 ; record 354
	dw $c037 ; record 355
	dw $4080 ; record 356
	dw $effe ; record 357
	dw $c000 ; record 358
	dw $e0e6 ; record 359
	dw $feff ; record 360
	dw $0000 ; record 361
	dw $ff00 ; record 362
	dw $0000 ; record 363
	dw $3f00 ; record 364
	dw $601f ; record 365
	dw $5f3f ; record 366
	dw $31ff ; record 367
	dw $217f ; record 368
	dw $277f ; record 369
	dw $277f ; record 370
	dw $fc7d ; record 371
	dw $e0fe ; record 372
	dw $e0f6 ; record 373
	dw $7f31 ; record 374
	dw $5f3f ; record 375
	dw $601f ; record 376
	dw $007b ; record 377
	dw $e23f ; record 378
	dw $00e0 ; record 379
	dw $ff00 ; record 380
	dw $fdff ; record 381
	dw $5fe0 ; record 382
	dw $ff8c ; record 383
	dw $ff04 ; record 384
	dw $fe24 ; record 385
	dw $04e0 ; record 386
	dw $e4f8 ; record 387
	dw $fff8 ; record 388
	dw $e6e0 ; record 389
	dw $e0e0 ; record 390
	dw $90e7 ; record 391
	dw $10ff ; record 392
	dw $13ff ; record 393
	dw $fcae ; record 394
	dw $90e0 ; record 395
	dw $93ff ; record 396
	dw $e0f4 ; record 397
	dw $e090 ; record 398
	dw $03e6 ; record 399
	dw $04f7 ; record 400
	dw $fc03 ; record 401
	dw $e0c0 ; record 402
	dw $87fd ; record 403
	dw $82ff ; record 404
	dw $ffcb ; record 405
	dw $fe92 ; record 406
	dw $86e0 ; record 407
	dw $e4f8 ; record 408
	dw $e5c0 ; record 409
	dw $20c0 ; record 410
	dw $c0fb ; record 411
	dw $a03f ; record 412
	dw $f3e0 ; record 413
	dw $fb1e ; record 414
	dw $fb0e ; record 415
	dw $4eb5 ; record 416
	dw $e0fe ; record 417
	dw $f80e ; record 418
	dw $ffe4 ; record 419
	dw $a0fb ; record 420
	dw $4ceb ; record 421
	dw $ffaf ; record 422
	dw $ff08 ; record 423
	dw $fe09 ; record 424
	dw $49e0 ; record 425
	dw $e0fe ; record 426
	dw $9c48 ; record 427
	dw $e0f2 ; record 428
	dw $ed80 ; record 429
	dw $ff61 ; record 430
	dw $6020 ; record 431
	dw $5ce2 ; record 432
	dw $20e1 ; record 433
	dw $f2fc ; record 434
	dw $60e0 ; record 435
	dw $fce8 ; record 436
	dw $06f8 ; record 437
	dw $fefc ; record 438
	dw $fa84 ; record 439
	dw $e0fe ; record 440
	dw $fa9c ; record 441
	dw $fce8 ; record 442
	dw $f8fe ; record 443
	dw $0006 ; record 444
	dw $fc07 ; record 445
	dw $0000 ; record 446
	dw $0000 ; record 447
	dw $7d00 ; record 448
	dw $ff00 ; record 449
	dw $0fff ; record 450
	dw $1807 ; record 451
	dw $110f ; record 452
	dw $effe ; record 453
	dw $07ef ; record 454
	dw $0018 ; record 455
	dw $c30f ; record 456
	dw $ffe2 ; record 457
	dw $00ff ; record 458
	dw $ffff ; record 459
	dw $39ef ; record 460
	dw $11ff ; record 461
	dw $01ff ; record 462
	dw $bfff ; record 463
	dw $ff29 ; record 464
	dw $ff39 ; record 465
	dw $ef39 ; record 466
	dw $e1fe ; record 467
	dw $fbff ; record 468
	dw $ffef ; record 469
	dw $e0e6 ; record 470
	dw $0000 ; record 471
	dw $0403 ; record 472
	dw $bd03 ; record 473
	dw $e0fc ; record 474
	dw $ffe0 ; record 475
	dw $ff33 ; record 476
	dw $fe32 ; record 477
	dw $33e2 ; record 478
	dw $f69e ; record 479
	dw $02e0 ; record 480
	dw $86ff ; record 481
	dw $ffff ; record 482
	dw $e0e0 ; record 483
	dw $c0e2 ; record 484
	dw $20d7 ; record 485
	dw $3fc0 ; record 486
	dw $e1e0 ; record 487
	dw $fe04 ; record 488
	dw $7ce0 ; record 489
	dw $95ff ; record 490
	dw $f80c ; record 491
	dw $e4e0 ; record 492
	dw $e0f4 ; record 493
	dw $e00c ; record 494
	dw $a0e6 ; record 495
	dw $ffe4 ; record 496
	dw $c1ff ; record 497
	dw $81ff ; record 498
	dw $9fff ; record 499
	dw $9fff ; record 500
	dw $f4f0 ; record 501
	dw $e0fe ; record 502
	dw $e0f6 ; record 503
	dw $e0c1 ; record 504
	dw $f0e9 ; record 505
	dw $18e0 ; record 506
	dw $3df0 ; record 507
	dw $fe08 ; record 508
	dw $e0ef ; record 509
	dw $0018 ; record 510
	dw $23f0 ; record 511
	dw $00ff ; record 512
	dw $0000 ; record 513
	dw $00fd ; record 514
	dw $ffff ; record 515
	dw $0307 ; record 516
	dw $070c ; record 517
	dw $060b ; record 518
	dw $fe7e ; record 519
	dw $07ec ; record 520
	dw $030b ; record 521
	dw $000c ; record 522
	dw $c307 ; record 523
	dw $fbe2 ; record 524
	dw $ffff ; record 525
	dw $e0fd ; record 526
	dw $ffcc ; record 527
	dw $ff48 ; record 528
	dw $9e09 ; record 529
	dw $e4fe ; record 530
	dw $ff48 ; record 531
	dw $ff6c ; record 532
	dw $e0ff ; record 533
	dw $e0e6 ; record 534
	dw $f500 ; record 535
	dw $c400 ; record 536
	dw $f8e0 ; record 537
	dw $e1e0 ; record 538
	dw $ff61 ; record 539
	dw $ff20 ; record 540
	dw $2475 ; record 541
	dw $e0fc ; record 542
	dw $fa21 ; record 543
	dw $24e0 ; record 544
	dw $64ff ; record 545
	dw $e6e0 ; record 546
	dw $c0ef ; record 547
	dw $e030 ; record 548
	dw $c01f ; record 549
	dw $93e1 ; record 550
	dw $82ff ; record 551
	dw $fea2 ; record 552
	dw $92e2 ; record 553
	dw $e4fe ; record 554
	dw $e5c0 ; record 555
	dw $e5a0 ; record 556
	dw $a219 ; record 557
	dw $49e0 ; record 558
	dw $fe54 ; record 559
	dw $a0e0 ; record 560
	dw $48e3 ; record 561
	dw $e9e0 ; record 562
	dw $bce0 ; record 563
	dw $10e0 ; record 564
	dw $e8fe ; record 565
	dw $d0fb ; record 566
	dw $fe60 ; record 567
	dw $e0e0 ; record 568
	dw $c0d0 ; record 569
	dw $0030 ; record 570
	dw $e001 ; record 571
	dw $ff23 ; record 572
	dw $0000 ; record 573
	dw $fd00 ; record 574
	dw $ff00 ; record 575
	dw $0fff ; record 576
	dw $1807 ; record 577
	dw $130f ; record 578
	dw $7e0e ; record 579
	dw $ecfe ; record 580
	dw $130f ; record 581
	dw $1807 ; record 582
	dw $0f00 ; record 583
	dw $e2c3 ; record 584
	dw $fffb ; record 585
	dw $fdff ; record 586
	dw $19e0 ; record 587
	dw $09ff ; record 588
	dw $49ff ; record 589
	dw $fcfe ; record 590
	dw $19e0 ; record 591
	dw $79ff ; record 592
	dw $78ff ; record 593
	dw $7ccf ; record 594
	dw $cfef ; record 595
	dw $c7ff ; record 596
	dw $e6ff ; record 597
	dw $00e0 ; record 598
	dw $0300 ; record 599
	dw $0cf7 ; record 600
	dw $f807 ; record 601
	dw $e0e0 ; record 602
	dw $f11f ; record 603
	dw $e03f ; record 604
	dw $3ffb ; record 605
	dw $fee4 ; record 606
	dw $e0e0 ; record 607
	dw $e03f ; record 608
	dw $24ff ; record 609
	dw $fe78 ; record 610
	dw $ffe0 ; record 611
	dw $e0e0 ; record 612
	dw $c0e2 ; record 613
	dw $e030 ; record 614
	dw $c01f ; record 615
	dw $1de1 ; record 616
	dw $fe92 ; record 617
	dw $82e2 ; record 618
	dw $c6ff ; record 619
	dw $e4fe ; record 620
	dw $e5e0 ; record 621
	dw $e5a0 ; record 622
	dw $1095 ; record 623
	dw $e0fe ; record 624
	dw $fa72 ; record 625
	dw $12e4 ; record 626
	dw $e0fe ; record 627
	dw $e8e0 ; record 628
	dw $7ff0 ; record 629
	dw $18e0 ; record 630
	dw $88f0 ; record 631
	dw $c8f0 ; record 632
	dw $fe70 ; record 633
	dw $1ee2 ; record 634
	dw $e7f8 ; record 635
	dw $18e0 ; record 636
	dw $f000 ; record 637
	dw $ff23 ; record 638
	dw $0000 ; record 639
	dw $f900 ; record 640
	dw $ff00 ; record 641
	dw $feff ; record 642
	dw $3ffd ; record 643
	dw $601f ; record 644
	dw $473f ; record 645
	dw $3cdf ; record 646
	dw $384f ; record 647
	dw $394f ; record 648
	dw $e4fe ; record 649
	dw $4f38 ; record 650
	dw $3cff ; record 651
	dw $3f4f ; record 652
	dw $1f47 ; record 653
	dw $0060 ; record 654
	dw $ff3f ; record 655
	dw $0000 ; record 656
	dw $0c03 ; record 657
	dw $f807 ; record 658
	dw $00ff ; record 659
	dw $ffff ; record 660
	dw $0ff8 ; record 661
	dw $07fc ; record 662
	dw $e7fc ; record 663
	dw $73fc ; record 664
	dw $3ce7 ; record 665
	dw $e0fe ; record 666
	dw $e0f6 ; record 667
	dw $fc0f ; record 668
	dw $eaff ; record 669
	dw $bde0 ; record 670
	dw $fd00 ; record 671
	dw $c0e0 ; record 672
	dw $e030 ; record 673
	dw $e01f ; record 674
	dw $3ce0 ; record 675
	dw $e7ff ; record 676
	dw $e33e ; record 677
	dw $e13f ; record 678
	dw $e03f ; record 679
	dw $ff3f ; record 680
	dw $3fe4 ; record 681
	dw $3fe6 ; record 682
	dw $3fe7 ; record 683
	dw $3de7 ; record 684
	dw $fff3 ; record 685
	dw $e03c ; record 686
	dw $81e3 ; record 687
	dw $fce0 ; record 688
	dw $06f8 ; record 689
	dw $ebfc ; record 690
	dw $9cf2 ; record 691
	dw $e4fe ; record 692
	dw $fe1c ; record 693
	dw $9ce2 ; record 694
	dw $fcf2 ; record 695
	dw $f21f ; record 696
	dw $06f8 ; record 697
	dw $fc00 ; record 698
	dw $ff63 ; record 699
	dw $fdff ; record 700
	dw $0000 ; record 701
	dw $f900 ; record 702
	dw $ff00 ; record 703
	dw $feff ; record 704
	dw $3ffd ; record 705
	dw $601f ; record 706
	dw $4f3f ; record 707
	dw $38ff ; record 708
	dw $305f ; record 709
	dw $335f ; record 710
	dw $335f ; record 711
	dw $fc5e ; record 712
	dw $e0fe ; record 713
	dw $e0f6 ; record 714
	dw $5f38 ; record 715
	dw $4f3f ; record 716
	dw $601f ; record 717
	dw $00ff ; record 718
	dw $003f ; record 719
	dw $0300 ; record 720
	dw $070c ; record 721
	dw $fff8 ; record 722
	dw $00ff ; record 723
	dw $ffff ; record 724
	dw $ff18 ; record 725
	dw $ff08 ; record 726
	dw $c9ff ; record 727
	dw $c8ff ; record 728
	dw $c87f ; record 729
	dw $c97f ; record 730
	dw $6fff ; record 731
	dw $ff09 ; record 732
	dw $ff19 ; record 733
	dw $e0ff ; record 734
	dw $0000 ; record 735
	dw $e0fd ; record 736
	dw $c0af ; record 737
	dw $e030 ; record 738
	dw $e01f ; record 739
	dw $08e1 ; record 740
	dw $e0e0 ; record 741
	dw $faf9 ; record 742
	dw $e0da ; record 743
	dw $fa18 ; record 744
	dw $f9e0 ; record 745
	dw $f90f ; record 746
	dw $ff0f ; record 747
	dw $0ff9 ; record 748
	dw $e3e0 ; record 749
	dw $e081 ; record 750
	dw $f8fc ; record 751
	dw $fc06 ; record 752
	dw $fdfa ; record 753
	dw $fe0c ; record 754
	dw $fce0 ; record 755
	dw $1cfa ; record 756
	dw $1cf2 ; record 757
	dw $eff2 ; record 758
	dw $f2fc ; record 759
	dw $02fc ; record 760
	dw $e1fe ; record 761
	dw $06f8 ; record 762
	dw $0100 ; record 763
	dw $63fc ; record 764
	dw $ffff ; record 765
	dw $00fd ; record 766
	dw $0000 ; record 767
	dw $00fd ; record 768
	dw $ffff ; record 769
	dw $0001 ; record 770
	dw $0103 ; record 771
	dw $0102 ; record 772
	dw $039d ; record 773
	dw $ecfe ; record 774
	dw $0002 ; record 775
	dw $e603 ; record 776
	dw $c2e0 ; record 777
	dw $ffe1 ; record 778
	dw $fffd ; record 779
	dw $e0fd ; record 780
	dw $ff8c ; record 781
	dw $ff08 ; record 782
	dw $ff39 ; record 783
	dw $39ff ; record 784
	dw $38ef ; record 785
	dw $38ef ; record 786
	dw $09ff ; record 787
	dw $f3ff ; record 788
	dw $ff89 ; record 789
	dw $e0ff ; record 790
	dw $e0e6 ; record 791
	dw $0000 ; record 792
	dw $0c03 ; record 793
	dw $07fb ; record 794
	dw $e0f8 ; record 795
	dw $6ce1 ; record 796
	dw $24ff ; record 797
	dw $20ff ; record 798
	dw $feee ; record 799
	dw $24e4 ; record 800
	dw $26ff ; record 801
	dw $e6e0 ; record 802
	dw $30c0 ; record 803
	dw $fde0 ; record 804
	dw $c01f ; record 805
	dw $c4e1 ; record 806
	dw $84ff ; record 807
	dw $9cff ; record 808
	dw $93ff ; record 809
	dw $f79c ; record 810
	dw $e0fe ; record 811
	dw $e0f6 ; record 812
	dw $c0c4 ; record 813
	dw $a0e6 ; record 814
	dw $fce4 ; record 815
	dw $27a5 ; record 816
	dw $e0fe ; record 817
	dw $fae7 ; record 818
	dw $b8e3 ; record 819
	dw $30e0 ; record 820
	dw $e9e0 ; record 821
	dw $af80 ; record 822
	dw $c000 ; record 823
	dw $4080 ; record 824
	dw $e8fe ; record 825
	dw $fec0 ; record 826
	dw $00e3 ; record 827
	dw $c001 ; record 828
	dw $e0e6 ; record 829
	dw $feff ; record 830
	dw $0000 ; record 831
	dw $f900 ; record 832
	dw $ff00 ; record 833
	dw $feff ; record 834
	dw $3ffd ; record 835
	dw $601f ; record 836
	dw $5f3f ; record 837
	dw $30df ; record 838
	dw $207f ; record 839
	dw $277f ; record 840
	dw $e0fc ; record 841
	dw $7f30 ; record 842
	dw $3efd ; record 843
	dw $e0f6 ; record 844
	dw $7f20 ; record 845
	dw $7f3f ; record 846
	dw $601f ; record 847
	dw $00ff ; record 848
	dw $003f ; record 849
	dw $0300 ; record 850
	dw $070c ; record 851
	dw $fff8 ; record 852
	dw $00ff ; record 853
	dw $ffff ; record 854
	dw $ff61 ; record 855
	dw $ff40 ; record 856
	dw $cc95 ; record 857
	dw $e0fe ; record 858
	dw $f840 ; record 859
	dw $4ce0 ; record 860
	dw $e0f6 ; record 861
	dw $e0ff ; record 862
	dw $bd00 ; record 863
	dw $fd00 ; record 864
	dw $c0e0 ; record 865
	dw $e030 ; record 866
	dw $e01f ; record 867
	dw $99e1 ; record 868
	dw $fefe ; record 869
	dw $81e6 ; record 870
	dw $c3ff ; record 871
	dw $e7ff ; record 872
	dw $ffff ; record 873
	dw $bdf9 ; record 874
	dw $e3e0 ; record 875
	dw $e081 ; record 876
	dw $f8fc ; record 877
	dw $fc06 ; record 878
	dw $f5fe ; record 879
	dw $fe04 ; record 880
	dw $3ce0 ; record 881
	dw $e8fa ; record 882
	dw $fefc ; record 883
	dw $06f8 ; record 884
	dw $0003 ; record 885
	dw $63fc ; record 886
	dw $ffff ; record 887
	dw $00fd ; record 888
	dw $0000 ; record 889
	dw $00ff ; record 890
	dw $0000 ; record 891
	dw $0307 ; record 892
	dw $070c ; record 893
	dw $bd0f ; record 894
	dw $fe04 ; record 895
	dw $06e0 ; record 896
	dw $060f ; record 897
	dw $fe0b ; record 898
	dw $07e5 ; record 899
	dw $0bdf ; record 900
	dw $0c03 ; record 901
	dw $0700 ; record 902
	dw $e0e2 ; record 903
	dw $0000 ; record 904
	dw $ffff ; record 905
	dw $00ff ; record 906
	dw $feff ; record 907
	dw $ff33 ; record 908
	dw $fb21 ; record 909
	dw $6dff ; record 910
	dw $e4fe ; record 911
	dw $ff61 ; record 912
	dw $ff73 ; record 913
	dw $f3ff ; record 914
	dw $ffde ; record 915
	dw $e0e6 ; record 916
	dw $e6e0 ; record 917
	dw $ed3f ; record 918
	dw $e13f ; record 919
	dw $fe9a ; record 920
	dw $ede0 ; record 921
	dw $e6fe ; record 922
	dw $3fff ; record 923
	dw $e3e0 ; record 924
	dw $e0a4 ; record 925
	dw $7ef8 ; record 926
	dw $e0c0 ; record 927
	dw $99ff ; record 928
	dw $09ff ; record 929
	dw $69ff ; record 930
	dw $e0fe ; record 931
	dw $09f1 ; record 932
	dw $e4f8 ; record 933
	dw $e0ff ; record 934
	dw $e2c0 ; record 935
	dw $30c0 ; record 936
	dw $1fe0 ; record 937
	dw $a056 ; record 938
	dw $fbe0 ; record 939
	dw $fe6e ; record 940
	dw $2ee0 ; record 941
	dw $e0fe ; record 942
	dw $fe4e ; record 943
	dw $f6e0 ; record 944
	dw $e1f4 ; record 945
	dw $fbff ; record 946
	dw $eaa0 ; record 947
	dw $d9ff ; record 948
	dw $10ff ; record 949
	dw $ffbf ; record 950
	dw $ff16 ; record 951
	dw $ffd6 ; record 952
	dw $fed0 ; record 953
	dw $d6e0 ; record 954
	dw $f8a8 ; record 955
	dw $c0e0 ; record 956
	dw $e0e5 ; record 957
	dw $b5e5 ; record 958
	dw $e0fe ; record 959
	dw $fe95 ; record 960
	dw $a5e0 ; record 961
	dw $feae ; record 962
	dw $b4e0 ; record 963
	dw $b6ff ; record 964
	dw $e9e0 ; record 965
	dw $9ce0 ; record 966
	dw $f0e0 ; record 967
	dw $a0fd ; record 968
	dw $e8fe ; record 969
	dw $f020 ; record 970
	dw $f060 ; record 971
	dw $d0e0 ; record 972
	dw $c03f ; record 973
	dw $0030 ; record 974
	dw $00e0 ; record 975
	dw $0000 ; record 976
	dw $0000 ; record 977
	dw $00ff ; record 978
	dw $0000 ; record 979
	dw $070f ; record 980
	dw $0f18 ; record 981
	dw $bd1f ; record 982
	dw $fe08 ; record 983
	dw $0de0 ; record 984
	dw $0d1f ; record 985
	dw $fe17 ; record 986
	dw $0fe5 ; record 987
	dw $17df ; record 988
	dw $1807 ; record 989
	dw $0f00 ; record 990
	dw $e0e2 ; record 991
	dw $0000 ; record 992
	dw $ffbf ; record 993
	dw $00ff ; record 994
	dw $fbff ; record 995
	dw $fe8e ; record 996
	dw $aee0 ; record 997
	dw $fe9c ; record 998
	dw $f4e4 ; record 999
	dw $ffe1 ; record 1000
	dw $fffb ; record 1001
	dw $e0e6 ; record 1002
	dw $e6e0 ; record 1003
	dw $f5bf ; record 1004
	dw $fee2 ; record 1005
	dw $eee0 ; record 1006
	dw $e3fa ; record 1007
	dw $22ff ; record 1008
	dw $23ff ; record 1009
	dw $ff79 ; record 1010
	dw $e0ff ; record 1011
	dw $e2e0 ; record 1012
	dw $0c03 ; record 1013
	dw $f807 ; record 1014
	dw $e0c0 ; record 1015
	dw $ffab ; record 1016
	dw $fea2 ; record 1017
	dw $aee0 ; record 1018
	dw $e2fa ; record 1019
	dw $e02e ; record 1020
	dw $62e0 ; record 1021
	dw $e0de ; record 1022
	dw $c0e6 ; record 1023
	dw $e030 ; record 1024
	dw $a01f ; record 1025
	dw $87e0 ; record 1026
	dw $effc ; record 1027
	dw $f88f ; record 1028
	dw $fb8f ; record 1029
	dw $e0fc ; record 1030
	dw $8ff8 ; record 1031
	dw $7ffe ; record 1032
	dw $38ef ; record 1033
	dw $39ef ; record 1034
	dw $ffef ; record 1035
	dw $a0ef ; record 1036
	dw $6bea ; record 1037
	dw $8bfe ; record 1038
	dw $e0fe ; record 1039
	dw $fabb ; record 1040
	dw $ffe3 ; record 1041
	dw $fe88 ; record 1042
	dw $6ce0 ; record 1043
	dw $e5a0 ; record 1044
	dw $e460 ; record 1045
	dw $8cff ; record 1046
	dw $e0ea ; record 1047
	dw $ffbb ; record 1048
	dw $e5e0 ; record 1049
	dw $8cfd ; record 1050
	dw $e9e0 ; record 1051
	dw $f0f8 ; record 1052
	dw $f80c ; record 1053
	dw $88fc ; record 1054
	dw $fe5e ; record 1055
	dw $d8e0 ; record 1056
	dw $d8fc ; record 1057
	dw $fe74 ; record 1058
	dw $f4e0 ; record 1059
	dw $e1fe ; record 1060
	dw $f8ff ; record 1061
	dw $f0f4 ; record 1062
	dw $000c ; record 1063
	dw $00f8 ; record 1064
	dw $0000 ; record 1065
	dw $0000 ; record 1066
	dw $00e5 ; record 1067
	dw $e1ff ; record 1068
	dw $fe01 ; record 1069
	dw $fff4 ; record 1070
	dw $ffe3 ; record 1071
	dw $807f ; record 1072
	dw $fff7 ; record 1073
	dw $82ff ; record 1074
	dw $e0fe ; record 1075
	dw $ffe6 ; record 1076
	dw $3fe6 ; record 1077
	dw $fe7e ; record 1078
	dw $ffe5 ; record 1079
	dw $7f3f ; record 1080
	dw $0080 ; record 1081
	dw $e0ff ; record 1082
	dw $fde3 ; record 1083
	dw $fdff ; record 1084
	dw $19e0 ; record 1085
	dw $09ff ; record 1086
	dw $49ff ; record 1087
	dw $1fff ; record 1088
	dw $ff08 ; record 1089
	dw $ff1c ; record 1090
	dw $fe4c ; record 1091
	dw $ffe2 ; record 1092
	dw $c6e0 ; record 1093
	dw $bfe0 ; record 1094
	dw $0000 ; record 1095
	dw $0c03 ; record 1096
	dw $f807 ; record 1097
	dw $e0e0 ; record 1098
	dw $dfe7 ; record 1099
	dw $ef3c ; record 1100
	dw $ef38 ; record 1101
	dw $fe39 ; record 1102
	dw $78e0 ; record 1103
	dw $b7ef ; record 1104
	dw $cf78 ; record 1105
	dw $fe79 ; record 1106
	dw $ffe0 ; record 1107
	dw $e0cf ; record 1108
	dw $c0e3 ; record 1109
	dw $30f7 ; record 1110
	dw $1fe0 ; record 1111
	dw $e0c0 ; record 1112
	dw $70df ; record 1113
	dw $20ff ; record 1114
	dw $ffef ; record 1115
	dw $ff27 ; record 1116
	dw $fe24 ; record 1117
	dw $20e2 ; record 1118
	dw $30ff ; record 1119
	dw $c014 ; record 1120
	dw $a0e6 ; record 1121
	dw $c6e5 ; record 1122
	dw $e07e ; record 1123
	dw $fe92 ; record 1124
	dw $78e0 ; record 1125
	dw $f8e1 ; record 1126
	dw $bee1 ; record 1127
	dw $e9e0 ; record 1128
	dw $01fe ; record 1129
	dw $ffff ; record 1130
	dw $8259 ; record 1131
	dw $41e0 ; record 1132
	dw $fe6e ; record 1133
	dw DrawScoreboardDrillResultRow ; record 1134
	dw $4dff ; record 1135
	dw $e080 ; record 1136
	dw $01fe ; record 1137
	dw $e460 ; record 1138
	dw $0007 ; record 1139
	dw $8000 ; record 1140
	dw $f4fe ; record 1141
	dw $e0ff ; record 1142
	dw $0000 ; record 1143
	dw $ff00 ; record 1144
	dw $0000 ; record 1145
	dw $0700 ; record 1146
	dw $0c03 ; record 1147
	dw $0907 ; record 1148
	dw $07f7 ; record 1149
	dw $060b ; record 1150
	dw $e8fe ; record 1151
	dw $0b07 ; record 1152
	dw $0907 ; record 1153
	dw $03ef ; record 1154
	dw $000c ; record 1155
	dw $e207 ; record 1156
	dw $00e0 ; record 1157
	dw $ff00 ; record 1158
	dw $ff7d ; record 1159
	dw $e0fd ; record 1160
	dw $ff19 ; record 1161
	dw $ff09 ; record 1162
	dw $fe49 ; record 1163
	dw $ffe4 ; record 1164
	dw $ff08 ; record 1165
	dw $ff1c ; record 1166
	dw $ff8f ; record 1167
	dw $f8ff ; record 1168
	dw $00ab ; record 1169
	dw $e0ff ; record 1170
	dw $24e7 ; record 1171
	dw $e0fe ; record 1172
	dw $fe26 ; record 1173
	dw $66e6 ; record 1174
	dw $ff59 ; record 1175
	dw $e0ff ; record 1176
	dw $e0c6 ; record 1177
	dw $0000 ; record 1178
	dw $e0a4 ; record 1179
	dw $c0f8 ; record 1180
	dw $ffe0 ; record 1181
	dw $3de7 ; record 1182
	dw $3ce7 ; record 1183
	dw $7ce7 ; record 1184
	dw $7ce7 ; record 1185
	dw $c7ed ; record 1186
	dw $e5fe ; record 1187
	dw $c7ff ; record 1188
	dw $e3e0 ; record 1189
	dw $30c0 ; record 1190
	dw $fde0 ; record 1191
	dw $a01f ; record 1192
	dw $7fe0 ; record 1193
	dw $ffd8 ; record 1194
	dw $ff90 ; record 1195
	dw $8a12 ; record 1196
	dw $e0fe ; record 1197
	dw $f890 ; record 1198
	dw $92e0 ; record 1199
	dw $e0fe ; record 1200
	dw $e5c0 ; record 1201
	dw $e580 ; record 1202
	dw $f3c3 ; record 1203
	dw $42ff ; record 1204
	dw $e0aa ; record 1205
	dw $e5fe ; record 1206
	dw $ff67 ; record 1207
	dw $fdff ; record 1208
	dw $e0fc ; record 1209
	dw $c4eb ; record 1210
	dw $72e1 ; record 1211
	dw $70ff ; record 1212
	dw $70df ; record 1213
	dw $69df ; record 1214
	dw $b872 ; record 1215
	dw $c0e2 ; record 1216
	dw $e0e8 ; record 1217
	dw $e09c ; record 1218
	dw $60d0 ; record 1219
	dw $ecfe ; record 1220
	dw $e0ff ; record 1221
	dw $c0d0 ; record 1222
	dw $0030 ; record 1223
	dw $00e0 ; record 1224
	dw $0000 ; record 1225
	dw $0000 ; record 1226
	dw $00ff ; record 1227
	dw $0000 ; record 1228
	dw $3f7f ; record 1229
	dw $7fc0 ; record 1230
	dw $df9f ; record 1231
	dw $bf73 ; record 1232
	dw $bf61 ; record 1233
	dw $fe6d ; record 1234
	dw $61e4 ; record 1235
	dw $ffbf ; record 1236
	dw $bf73 ; record 1237
	dw $9f79 ; record 1238
	dw $cf3f ; record 1239
	dw $7f00 ; record 1240
	dw $e25e ; record 1241
	dw $00e0 ; record 1242
	dw $ff00 ; record 1243
	dw $fdff ; record 1244
	dw $69e0 ; record 1245
	dw $e8fe ; record 1246
	dw $098f ; record 1247
	dw $99ff ; record 1248
	dw $ffff ; record 1249
	dw $e6e0 ; record 1250
	dw $e0e0 ; record 1251
	dw $f3e6 ; record 1252
	dw $1ebd ; record 1253
	dw $e0fe ; record 1254
	dw $f3be ; record 1255
	dw $e3be ; record 1256
	dw $e5fe ; record 1257
	dw $bdff ; record 1258
	dw $e0e3 ; record 1259
	dw $03e3 ; record 1260
	dw $070c ; record 1261
	dw $c0f8 ; record 1262
	dw $d2e1 ; record 1263
	dw $ffcb ; record 1264
	dw $fe12 ; record 1265
	dw $d2e0 ; record 1266
	dw $e6fe ; record 1267
	dw $e5c0 ; record 1268
	dw $30c0 ; record 1269
	dw $e0fb ; record 1270
	dw $a01f ; record 1271
	dw $fee0 ; record 1272
	dw $fed3 ; record 1273
	dw $fe53 ; record 1274
	dw $13dd ; record 1275
	dw $e2dc ; record 1276
	dw $ff13 ; record 1277
	dw $f293 ; record 1278
	dw $ffe0 ; record 1279
	dw $fefe ; record 1280
	dw $eaa0 ; record 1281
	dw $f11f ; record 1282
	dw $e13f ; record 1283
	dw $ef3f ; record 1284
	dw $fdff ; record 1285
	dw $fe29 ; record 1286
	dw $ede0 ; record 1287
	dw $e1ff ; record 1288
	dw $f13f ; record 1289
	dw $f93f ; record 1290
	dw $caff ; record 1291
	dw $80e0 ; record 1292
	dw $ffe8 ; record 1293
	dw $ff9b ; record 1294
	dw $ff08 ; record 1295
	dw $685f ; record 1296
	dw $6bff ; record 1297
	dw $0bff ; record 1298
	dw $e0fe ; record 1299
	dw $f86b ; record 1300
	dw $7ee0 ; record 1301
	dw $e860 ; record 1302
	dw $fcfe ; record 1303
	dw $fe03 ; record 1304
	dw $46fd ; record 1305
	dw $e0fe ; record 1306
	dw $5efd ; record 1307
	dw $e8fa ; record 1308
	dw $fdfe ; record 1309
	dw $03fc ; record 1310
	dw $fe00 ; record 1311
	dw $0003 ; record 1312
	dw $0000 ; record 1313
	dw $0000 ; record 1314
LoadScoreboardModeGfx:
	ld a, [wGameMode] ; $5c8a
	cp a, $05 ; $5c8d
	jr z, Label_06_5c9b ; $5c8f
	add a, a ; $5c91
	add a, $c9 ; $5c92
	ld l, a ; $5c94
	adc a, $5c ; $5c95
	sub a, l ; $5c97
	ld h, a ; $5c98
	jr Label_06_5ca6 ; $5c99
Label_06_5c9b:
	ld a, [$c8f7] ; $5c9b
	add a, a ; $5c9e
	add a, $df ; $5c9f
	ld l, a ; $5ca1
	adc a, $5c ; $5ca2
	sub a, l ; $5ca4
	ld h, a ; $5ca5
Label_06_5ca6:
	ldh a, [hWramBank] ; $5ca6
	push af ; $5ca8
	wram_bank $01 ; $5ca9
	ld a, [hl+] ; $5caf
	ld h, [hl] ; $5cb0
	ld l, a ; $5cb1
	ld de, $d000 ; $5cb2
	call DecompressData ; $5cb5
	ld hl, $d000 ; $5cb8
	ld de, $8500 ; $5cbb
	ld c, $14 ; $5cbe
	call QueueVRAMCopy ; $5cc0
	pop af ; $5cc3
	wram_bank ; $5cc4
	ret ; $5cc8
	; $5cc9, 56 bytes (records:2)
	dw $5d40 ; record 0
	dw $5d40 ; record 1
	dw $5df5 ; record 2
	dw $5eb1 ; record 3
	dw $5f76 ; record 4
	dw $5ff7 ; record 5
	dw $608b ; record 6
	dw $613e ; record 7
	dw $61f6 ; record 8
	dw $62bb ; record 9
	dw $5f76 ; record 10
	dw $6365 ; record 11
	dw $6365 ; record 12
	dw $6365 ; record 13
	dw $6412 ; record 14
	dw $6412 ; record 15
	dw $6412 ; record 16
	dw $64dc ; record 17
	dw $64dc ; record 18
	dw $64dc ; record 19
	dw $65af ; record 20
	dw $65af ; record 21
	dw $65af ; record 22
	dw $6687 ; record 23
	dw $6687 ; record 24
	dw $6687 ; record 25
	dw $6734 ; record 26
	dw $6734 ; record 27
	; $5d01, 2817 bytes (bytes:14)
	db $34, $67, $f6, $61, $f6, $61, $f6, $61, $f6, $61, $f6, $61, $f6, $61 ; 0x00
	db $f6, $61, $f6, $61, $f6, $61, $f6, $61, $f6, $61, $f6, $61, $f6, $61 ; 0x0e
	db $f6, $61, $f6, $61, $f6, $61, $f6, $61, $f6, $61, $f6, $61, $f6, $61 ; 0x1c
	db $f6, $61, $f6, $61, $f6, $61, $f6, $61, $00, $00, $00, $00, $00, $00 ; 0x2a
	db $00, $00, $00, $00, $00, $00, $00, $7f, $3f, $3f, $7f, $60, $7f, $4f ; 0x38
	db $78, $fe, $e0, $f1, $79, $fe, $e0, $f8, $e5, $f4, $e1, $7f, $4f, $7f ; 0x46
	db $60, $ff, $3f, $3f, $ff, $ff, $ff, $00, $ff, $df, $df, $71, $ff, $20 ; 0x54
	db $ff, $24, $fe, $e0, $20, $ff, $a1, $60, $f8, $e2, $f4, $e1, $e6, $e2 ; 0x62
	db $fa, $e4, $b2, $fe, $e0, $92, $92, $fe, $e0, $82, $fe, $e0, $f8, $e1 ; 0x70
	db $9a, $fe, $e0, $e0, $e9, $49, $e2, $fe, $e4, $19, $fe, $e0, $f4, $e5 ; 0x7e
	db $c0, $e9, $66, $ff, $64, $72, $a0, $e2, $04, $fe, $e0, $98, $e1, $34 ; 0x8c
	db $ff, $36, $a0, $e9, $bb, $f3, $1e, $fe, $e0, $fe, $f3, $9e, $fe, $e6 ; 0x9a
	db $1e, $df, $f3, $3e, $f3, $ff, $e3, $80, $e6, $bf, $ec, $2f, $ff, $48 ; 0xa8
	db $ff, $09, $fe, $e0, $48, $f8, $e0, $a0, $f1, $df, $61, $ff, $21, $ff ; 0xb6
	db $33, $fe, $ec, $ff, $fe, $7a, $40, $e7, $84, $86, $e0, $3c, $ff, $3c ; 0xc4
	db $e7, $fe, $e4, $fa, $78, $e0, $84, $20, $e4, $fc, $fc, $fe, $06, $fe ; 0xd2
	db $cb, $f2, $9e, $fe, $e4, $1e, $fe, $e0, $f4, $e5, $fe, $f2, $0f, $fe ; 0xe0
	db $06, $fc, $fc, $00, $00, $00, $fd, $00, $ff, $fc, $7f, $7f, $ff, $c0 ; 0xee
	db $ff, $9f, $97, $f3, $9f, $f2, $fe, $e4, $f3, $fe, $e2, $f2, $e1, $ff ; 0xfc
	db $f7, $9f, $ff, $c0, $e2, $e0, $ff, $ff, $00, $ff, $ab, $fe, $13, $fe ; 0x10a
	db $e0, $73, $fe, $e0, $33, $f6, $e0, $93, $ff, $fe, $93, $ff, $10, $ff ; 0x118
	db $38, $ff, $ff, $f9, $ef, $e6, $e0, $ff, $e1, $00, $ff, $7f, $c6, $ff ; 0x126
	db $17, $82, $ff, $92, $fe, $e0, $82, $f8, $e4, $f4, $e1, $c6, $e2, $2a ; 0x134
	db $fa, $e4, $c8, $fe, $e0, $49, $fe, $e0, $09, $fe, $e0, $f8, $e1, $79 ; 0x142
	db $68, $fe, $e0, $e0, $e8, $c3, $7e, $e7, $3c, $fe, $ec, $2f, $7e, $e7 ; 0x150
	db $ff, $c3, $c0, $e7, $30, $8e, $e0, $a0, $e1, $dd, $90, $fe, $e0, $93 ; 0x15e
	db $ff, $93, $70, $e0, $33, $fe, $fb, $ff, $fe, $a0, $e7, $c2, $ff, $42 ; 0x16c
	db $ff, $4e, $fa, $fe, $e0, $42, $f6, $e0, $ce, $ff, $ce, $7f, $c2, $f6 ; 0x17a
	db $fe, $e0, $ff, $7f, $60, $e1, $fe, $fe, $ff, $03, $57, $ff, $f9, $cf ; 0x188
	db $fe, $e0, $4f, $fe, $e0, $0f, $fe, $e0, $fa, $f8, $e1, $6f, $fe, $e0 ; 0x196
	db $ff, $f9, $ff, $03, $fe, $01, $fe, $e0, $dd, $00, $00, $00, $df, $1f ; 0x1a4
	db $1f, $3f, $30, $3f, $fd, $e0, $30, $3f, $79, $32, $fe, $e0, $f8, $e1 ; 0x1b2
	db $33, $3f, $33, $3e, $fe, $e1, $ff, $3f, $3e, $3f, $30, $1f, $1f, $ff ; 0x1c0
	db $ff, $ff, $ff, $00, $ff, $fe, $c3, $ff, $41, $ff, $fd, $49, $fe, $e0 ; 0x1ce
	db $41, $ff, $c3, $ff, $c9, $ff, $9b, $c9, $7f, $fe, $e1, $ff, $7f, $e6 ; 0x1dc
	db $e0, $ff, $e1, $00, $7f, $ff, $fb, $8e, $ff, $04, $ff, $24, $fe, $e0 ; 0x1ea
	db $9d, $04, $f8, $e4, $24, $ff, $26, $e6, $e3, $fa, $e4, $21, $de, $fe ; 0x1f8
	db $e0, $f3, $ff, $f3, $9f, $fe, $e4, $ff, $33, $f4, $fe, $e0, $e0, $e9 ; 0x206
	db $31, $de, $e0, $27, $ff, $27, $fd, $b4, $fe, $e4, $d0, $e0, $31, $c0 ; 0x214
	db $e9, $f9, $0f, $fe, $e0, $3f, $6c, $fe, $e0, $f8, $e9, $ff, $f9, $80 ; 0x222
	db $e6, $df, $76, $84, $ea, $7c, $7e, $e3, $80, $e9, $30, $ff, $10, $ff ; 0x230
	db $99, $fe, $e0, $e1, $19, $fe, $e0, $f8, $e1, $f4, $e1, $60, $e9, $c2 ; 0x23e
	db $ff, $82, $9f, $ff, $9e, $ff, $9e, $f3, $fe, $e4, $f2, $e0, $c2, $fd ; 0x24c
	db $ff, $20, $e3, $f8, $f8, $fc, $0c, $fc, $fc, $c5, $4c, $fe, $e4, $0c ; 0x25a
	db $f3, $e0, $f4, $e5, $ff, $e0, $0c, $f8, $01, $f8, $00, $00, $00, $fd ; 0x268
	db $00, $ff, $fc, $03, $03, $07, $06, $07, $05, $fe, $fe, $f4, $06, $03 ; 0x276
	db $03, $ff, $ff, $ff, $00, $f7, $ff, $ff, $09, $fe, $e0, $39, $ff, $3c ; 0x284
	db $ff, $85, $0c, $fe, $e0, $3c, $f6, $e0, $f0, $e1, $e6, $e3, $e0, $e3 ; 0x292
	db $24, $2e, $fe, $e2, $64, $ff, $60, $fe, $e0, $64, $f2, $e4, $e0, $e9 ; 0x2a0
	db $c5, $90, $fe, $e0, $92, $fe, $e0, $f8, $e9, $c0, $e9, $c8, $ff, $17 ; 0x2ae
	db $48, $ff, $4c, $fe, $e0, $cc, $fe, $e0, $f8, $e1, $f6, $e1, $aa, $a0 ; 0x2bc
	db $e9, $4c, $e0, $e0, $c9, $fe, $e8, $c8, $e0, $ec, $6c, $cb, $ff, $2c ; 0x2ca
	db $7c, $e2, $20, $fe, $e0, $74, $e1, $26, $ff, $fd, $66, $60, $e4, $c0 ; 0x2d8
	db $c0, $e0, $60, $e0, $a0, $0e, $fe, $f4, $60, $c0, $c0, $e0, $dd, $00 ; 0x2e6
	db $00, $00, $fd, $00, $ff, $fc, $07, $07, $0f, $0c, $0f, $09, $fe, $fe ; 0x2f4
	db $f4, $0c, $07, $07, $ff, $ff, $ff, $00, $7f, $ff, $df, $74, $ff, $24 ; 0x302
	db $ff, $04, $fe, $e0, $51, $24, $fe, $e8, $e6, $e2, $fa, $e4, $b2, $fe ; 0x310
	db $e0, $92, $fe, $e0, $c9, $82, $fe, $e0, $f8, $e1, $9a, $fe, $e0, $e0 ; 0x31e
	db $e8, $c7, $7c, $ff, $cf, $78, $cf, $79, $cf, $79, $ff, $49, $ee, $fe ; 0x32c
	db $e0, $79, $ff, $79, $f2, $e0, $7c, $cf, $ff, $7d, $c7, $c0, $e7, $31 ; 0x33a
	db $ff, $20, $ff, $e4, $9c, $e0, $69, $20, $f8, $e0, $9c, $e3, $64, $a0 ; 0x348
	db $e9, $ef, $ba, $a4, $e8, $7c, $fc, $e5, $80, $e9, $18, $ff, $10, $ff ; 0x356
	db $73, $fe, $e0, $95, $11, $f6, $e0, $7c, $fe, $e0, $10, $f6, $e0, $60 ; 0x364
	db $e3, $e0, $5f, $e0, $f0, $30, $f0, $90, $fe, $e4, $10, $f6, $e6, $0e ; 0x372
	db $f2, $e3, $30, $e0, $e0, $e0, $dd, $00, $00, $00, $fd, $00, $ff, $fc ; 0x380
	db $7f, $7f, $ff, $c0, $ff, $bf, $bd, $e2, $fe, $e0, $f6, $bf, $f6, $9f ; 0x38e
	db $fe, $e9, $ff, $f7, $9f, $ff, $c0, $e2, $e0, $ff, $ff, $00, $ff, $ab ; 0x39c
	db $ff, $2d, $fe, $e0, $e5, $fe, $e0, $21, $fe, $e0, $e9, $f0, $fe, $e0 ; 0x3aa
	db $f0, $e1, $e6, $e3, $e0, $e3, $6b, $ff, $6a, $ff, $7d, $2a, $fe, $e0 ; 0x3b8
	db $0a, $ff, $0b, $ff, $4b, $fe, $e0, $f9, $6a, $f0, $e0, $e0, $e8, $f7 ; 0x3c6
	db $1d, $f7, $1c, $f7, $5f, $fc, $f7, $fd, $e7, $3d, $f6, $e0, $dd, $fe ; 0x3d4
	db $e0, $bf, $1d, $f7, $3d, $f7, $ff, $e7, $c0, $e6, $fe, $7d, $b3, $a6 ; 0x3e2
	db $e0, $2d, $ff, $ad, $ff, $a1, $fe, $e0, $e9, $ad, $fe, $e4, $a0, $e9 ; 0x3f0
	db $8b, $a8, $e0, $7b, $ff, $7b, $bb, $cf, $78, $fe, $e0, $7b, $cf, $7b ; 0x3fe
	db $9a, $e0, $8b, $ba, $80, $ea, $56, $fe, $e0, $52, $ff, $50, $fe, $e2 ; 0x40c
	db $54, $f8, $fe, $e0, $f0, $e1, $46, $e3, $fe, $fe, $ff, $03, $ff, $cb ; 0x41a
	db $f9, $8f, $fe, $e0, $bf, $fe, $e0, $f8, $e9, $ff, $f9, $0f, $ff, $03 ; 0x428
	db $fe, $fe, $e0, $dd, $00, $00, $00, $7f, $07, $07, $0f, $0c, $0f, $0b ; 0x436
	db $0e, $fe, $f0, $ff, $0f, $0b, $0f, $0c, $07, $07, $ff, $ff, $ff, $ff ; 0x444
	db $00, $ff, $ff, $4c, $ff, $48, $ff, $d5, $49, $fe, $e0, $48, $f8, $e0 ; 0x452
	db $09, $fe, $e0, $49, $ff, $cf, $e9, $ff, $ff, $bf, $e6, $e1, $e0, $e2 ; 0x460
	db $fd, $67, $1b, $fd, $27, $fe, $e9, $ff, $21, $fe, $e0, $c6, $e3, $c0 ; 0x46e
	db $e2, $db, $e1, $3f, $fe, $eb, $f9, $0f, $fe, $e0, $ff, $f9, $7e, $c0 ; 0x47c
	db $e6, $ff, $0c, $ff, $04, $ff, $24, $fe, $e0, $bd, $04, $f6, $e0, $3c ; 0x48a
	db $ff, $3c, $e7, $fe, $e1, $ff, $fd, $e7, $a0, $e6, $ef, $38, $ff, $10 ; 0x498
	db $ff, $92, $8e, $fe, $e0, $10, $ff, $30, $f8, $e2, $f4, $e1, $a0, $e8 ; 0x4a6
	db $bf, $ff, $e2, $ff, $42, $ff, $4f, $ff, $4f, $f9, $de, $fe, $e4, $ff ; 0x4b4
	db $43, $ff, $63, $80, $e9, $ff, $13, $af, $ff, $12, $ff, $32, $fe, $ea ; 0x4c2
	db $33, $e0, $ea, $10, $be, $a0, $e0, $73, $ff, $73, $df, $70, $fe, $e0 ; 0x4d0
	db $73, $f3, $df, $73, $f0, $e2, $06, $e3, $c0, $c0, $e0, $60, $3b, $e0 ; 0x4de
	db $a0, $fe, $f4, $60, $c0, $c0, $00, $00, $00, $ff, $7f, $7f, $ff, $c0 ; 0x4ec
	db $ff, $f7, $dd, $ff, $97, $c9, $ff, $c1, $fe, $e0, $c9, $fe, $e8, $ff ; 0x4fa
	db $e0, $c0, $fe, $e2, $e0, $ff, $ff, $00, $ff, $ff, $8c, $ff, $17, $04 ; 0x508
	db $ff, $24, $fe, $e0, $04, $f8, $e4, $f4, $e1, $e6, $e3, $be, $e0, $e3 ; 0x516
	db $33, $ff, $12, $ff, $92, $fe, $e0, $32, $ee, $f8, $e4, $92, $ff, $93 ; 0x524
	db $e0, $e9, $f3, $1e, $fb, $f7, $0e, $fb, $4e, $fe, $e8, $0e, $fb, $1e ; 0x532
	db $fb, $fb, $ff, $f3, $c0, $e6, $bf, $e9, $ff, $49, $ff, $25, $09, $fe ; 0x540
	db $e0, $49, $fe, $e8, $a0, $e9, $64, $fe, $e0, $80, $e9, $f9, $34, $fe ; 0x54e
	db $e0, $80, $e8, $9f, $f0, $bf, $e0, $bf, $df, $e7, $bf, $f4, $ff, $94 ; 0x55c
	db $fe, $e0, $f4, $ff, $bd, $e4, $f2, $e0, $f1, $bf, $ff, $9f, $60, $e7 ; 0x56a
	db $c6, $8b, $ff, $82, $60, $e2, $82, $f8, $e4, $54, $e1, $40, $e8, $bf ; 0x578
	db $17, $e8, $ff, $48, $80, $e2, $48, $f8, $e0, $7c, $e1, $f8, $e1, $fe ; 0x586
	db $06, $e3, $fe, $fe, $ff, $03, $ff, $ff, $63, $ff, $ff, $43, $ff, $cf ; 0x594
	db $ff, $cf, $fd, $47, $fa, $f6, $e0, $f3, $47, $e0, $43, $ff, $47, $ff ; 0x5a2
	db $ff, $1f, $fd, $ff, $03, $fe, $fe, $00, $00, $00, $f7, $00, $00, $01 ; 0x5b0
	db $ff, $f8, $00, $00, $ff, $ff, $df, $ff, $80, $ff, $7b, $ce, $fe, $eb ; 0x5be
	db $7f, $c2, $46, $fe, $e0, $ff, $7f, $e6, $e0, $ff, $e1, $dc, $e0, $59 ; 0x5cc
	db $fe, $e0, $25, $49, $fe, $e0, $41, $fe, $e0, $f8, $e1, $4d, $fe, $e0 ; 0x5da
	db $e6, $e3, $fa, $e0, $e3, $24, $fe, $e0, $04, $ff, $0c, $ff, $1c, $e2 ; 0x5e8
	db $fe, $e0, $0c, $f6, $e0, $f0, $e1, $e0, $e9, $21, $ff, $20, $23, $ff ; 0x5f6
	db $e4, $fe, $e0, $d8, $e1, $f8, $e1, $20, $ee, $e0, $c0, $e8, $bf, $3b ; 0x604
	db $ee, $bf, $e4, $bf, $e0, $fe, $e0, $e4, $f6, $fe, $e8, $ff, $3f, $a0 ; 0x612
	db $e7, $c6, $ff, $82, $ff, $85, $93, $fe, $e0, $83, $fe, $e0, $f8, $e1 ; 0x620
	db $f4, $e1, $80, $e9, $18, $7f, $ff, $10, $ff, $33, $ff, $33, $fe, $fe ; 0x62e
	db $e4, $7f, $ff, $30, $ff, $38, $ff, $ff, $ef, $60, $e4, $2f, $01, $ff ; 0x63c
	db $fe, $93, $fe, $e4, $83, $fe, $e0, $f4, $e5, $7b, $ff, $fe, $e6, $e0 ; 0x64a
	db $ff, $00, $00, $80, $ff, $f8, $03, $00, $00, $00, $00, $00, $ff, $03 ; 0x658
	db $03, $07, $06, $07, $04, $07, $05, $fc, $fe, $e8, $f2, $e7, $06, $03 ; 0x666
	db $03, $ff, $ff, $ff, $ff, $00, $ff, $ff, $88, $ff, $08, $ff, $39, $af ; 0x674
	db $ff, $39, $f7, $18, $f6, $e0, $c9, $fe, $e0, $08, $e3, $ff, $18, $e7 ; 0x682
	db $e0, $e6, $e1, $e0, $e3, $43, $ff, $41, $92, $e8, $e2, $41, $f6, $e0 ; 0x690
	db $e0, $e1, $49, $fe, $e0, $e0, $e9, $24, $fe, $fe, $ea, $04, $ff, $8c ; 0x69e
	db $ff, $dc, $ff, $ff, $fd, $77, $c0, $e7, $c4, $ff, $84, $ff, $9c, $ff ; 0x6ac
	db $d3, $9c, $f7, $fe, $e4, $f2, $e0, $c4, $a0, $e9, $ee, $3b, $af, $ef ; 0x6ba
	db $39, $ef, $f8, $fe, $e0, $39, $f8, $e0, $f9, $ec, $fe, $e0, $f8, $e1 ; 0x6c8
	db $ff, $ef, $80, $e7, $b1, $ff, $20, $a2, $9c, $e2, $20, $f8, $e4, $90 ; 0x6d6
	db $e1, $60, $e9, $86, $a0, $e0, $cc, $de, $fe, $ea, $ce, $ff, $ff, $fb ; 0x6e4
	db $60, $eb, $e4, $ff, $77, $e4, $bf, $e0, $fe, $e0, $e4, $bf, $e4, $c0 ; 0x6f2
	db $e8, $bf, $c0, $c0, $e0, $60, $e0, $a0, $fe, $f4, $60, $03, $c0, $c0 ; 0x700
	db $00, $00, $00, $ff, $7f, $7f, $ff, $c0, $ff, $bf, $e2, $ff, $f7, $c2 ; 0x70e
	db $ff, $ce, $fe, $e0, $c6, $ff, $e2, $ff, $b7, $f2, $bf, $f2, $f2, $e0 ; 0x71c
	db $c6, $ff, $ff, $e0, $c0, $7e, $e2, $e0, $ff, $ff, $00, $ff, $ff, $10 ; 0x72a
	db $fe, $e0, $89, $72, $fe, $e0, $f8, $e5, $12, $fe, $e0, $e6, $e3, $e0 ; 0x738
	db $e3, $c9, $f3, $ff, $49, $fe, $e4, $f6, $e1, $41, $ff, $63, $ff, $ef ; 0x746
	db $77, $ff, $ff, $dd, $e0, $e7, $31, $ff, $21, $9f, $ff, $27, $ff, $27 ; 0x754
	db $fd, $fe, $e4, $f2, $e0, $31, $96, $c0, $e9, $fb, $0e, $fe, $e0, $3e ; 0x762
	db $fe, $e0, $f8, $e9, $ff, $5d, $fb, $a0, $e7, $18, $ff, $08, $9e, $e2 ; 0x770
	db $08, $f6, $e0, $6f, $79, $ff, $79, $cf, $fe, $e1, $ff, $cf, $80, $e7 ; 0x77e
	db $df, $71, $ff, $20, $ff, $24, $fe, $e0, $20, $ff, $f1, $60, $f8, $e2 ; 0x78c
	db $f4, $e1, $60, $e9, $c0, $ff, $80, $ff, $ef, $9c, $ff, $9c, $f7, $fe ; 0x79a
	db $e4, $ff, $84, $ff, $9d, $c4, $40, $ea, $4c, $ff, $48, $3c, $e0, $fe ; 0x7a8
	db $e7, $c8, $fb, $ff, $cc, $20, $e4, $fe, $fe, $ff, $03, $ff, $b3, $ff ; 0x7b6
	db $43, $fe, $e0, $8f, $e0, $7f, $c3, $fe, $e0, $cf, $73, $7f, $cf, $f0 ; 0x7c4
	db $e2, $df, $c0, $03, $fe, $fe, $00, $00, $00, $7f, $3f, $3f, $7f, $60 ; 0x7d2
	db $7f, $7f, $66, $fe, $e0, $15, $62, $fe, $e0, $60, $f3, $e0, $64, $fe ; 0x7e0
	db $e0, $f0, $e1, $ff, $e0, $ff, $60, $3f, $3f, $ff, $ff, $ff, $00, $ff ; 0x7ee
	db $2b, $ff, $40, $fe, $e0, $4f, $fe, $e0, $43, $fe, $e0, $f8, $e1, $b1 ; 0x7fc
	db $41, $fe, $e0, $e6, $e3, $e0, $e2, $fb, $0e, $fe, $e0, $3e, $b7, $fb ; 0x80a
	db $3e, $e3, $fe, $e9, $ff, $e3, $e0, $e6, $ff, $5f, $19, $ff, $09, $ff ; 0x818
	db $49, $fe, $e0, $09, $f6, $e0, $df, $79, $ff, $79, $cf, $78, $fe, $e0 ; 0x826
	db $ff, $cf, $7e, $c0, $e6, $1f, $f1, $3f, $e0, $3f, $e4, $fe, $e0, $cd ; 0x834
	db $e0, $f8, $e3, $ff, $24, $fe, $e0, $a0, $e8, $ff, $99, $fe, $fe, $e4 ; 0x842
	db $c3, $ff, $c3, $fe, $e7, $fe, $e7, $ed, $bc, $fe, $e1, $ff, $bc, $80 ; 0x850
	db $e6, $77, $dd, $7f, $d7, $c9, $7f, $c1, $fe, $e0, $c9, $fe, $e8, $ff ; 0x85e
	db $7f, $be, $80, $e7, $8c, $ff, $04, $ff, $26, $fe, $e0, $06, $f0, $fe ; 0x86c
	db $e0, $f8, $e1, $f4, $e1, $a0, $e9, $31, $ff, $21, $ff, $ef, $67, $ff ; 0x87a
	db $67, $fd, $fe, $e4, $ff, $61, $ff, $ef, $71, $ff, $ff, $df, $06, $e1 ; 0x888
	db $fc, $fc, $fe, $2f, $06, $fe, $fe, $26, $fe, $e4, $06, $f3, $e0, $f4 ; 0x896
	db $e5, $0e, $ff, $e0, $06, $fc, $fc, $00, $00, $00, $7f, $7f, $7f, $ff ; 0x8a4
	db $c0, $ff, $bf, $ed, $fe, $e0, $e5, $e5, $fe, $e2, $e9, $fe, $e2, $f0 ; 0x8b2
	db $e1, $ff, $bf, $ff, $dd, $c0, $e2, $e0, $ff, $ff, $00, $fd, $e1, $00 ; 0x8c0
	db $ff, $85, $7d, $fe, $e0, $0d, $fe, $e0, $f8, $e5, $e6, $e3, $e0, $e2 ; 0x8ce
	db $bf, $f7, $e3, $bf, $e1, $bc, $e1, $3f, $e1, $3f, $e3, $df, $3f, $ef ; 0x8dc
	db $3f, $ef, $39, $fe, $e1, $ff, $39, $7e, $e0, $e6, $c7, $7c, $cf, $78 ; 0x8ea
	db $cf, $7b, $fe, $e0, $cd, $78, $f8, $e3, $ff, $0b, $fe, $e0, $c0, $e8 ; 0x8f8
	db $f7, $dd, $fb, $f7, $5d, $fe, $e1, $ff, $49, $ff, $63, $ff, $6f, $77 ; 0x906
	db $fe, $77, $dc, $fe, $e1, $ff, $dc, $a0, $e6, $bf, $7f, $c6, $7f, $c2 ; 0x914
	db $7f, $da, $fe, $e0, $c2, $de, $f6, $e0, $de, $7f, $de, $73, $fe, $e1 ; 0x922
	db $ff, $73, $dc, $80, $e6, $93, $e0, $10, $ff, $d6, $fe, $e0, $10, $ff ; 0x930
	db $d7, $30, $ff, $16, $f6, $e2, $d6, $60, $e9, $7f, $c0, $7f, $ff, $80 ; 0x93e
	db $ff, $be, $ff, $be, $e3, $fe, $e4, $ef, $ff, $86, $ff, $c6, $40, $e9 ; 0x94c
	db $ff, $58, $ff, $bf, $50, $ff, $d7, $ff, $d7, $fc, $fe, $e4, $ff, $f7 ; 0x95a
	db $d0, $ff, $d8, $20, $e4, $fe, $fe, $ff, $03, $97, $ff, $fd, $87, $fe ; 0x968
	db $e0, $bf, $fe, $e0, $f8, $e9, $ff, $1f, $fd, $ff, $03, $fe, $fe, $00 ; 0x976
	db $00, $00, $ff, $07, $07, $0f, $0c, $0f, $08, $0f, $09, $fc, $fe, $e8 ; 0x984
	db $f2, $e7, $0c, $07, $07, $ff, $ff, $ff, $ff, $00, $ff, $ff, $88, $ff ; 0x992
	db $08, $ff, $3c, $be, $fe, $e0, $1c, $ff, $8c, $ff, $cc, $fe, $e0, $0c ; 0x9a0
	db $e6, $f6, $e0, $ff, $f7, $e6, $e1, $e0, $e2, $fe, $43, $ff, $77, $41 ; 0x9ae
	db $ff, $c9, $fe, $e0, $c1, $ff, $c3, $f8, $e2, $f8, $f4, $e1, $c6, $e3 ; 0x9bc
	db $c0, $e3, $8c, $ff, $04, $ff, $24, $d2, $fe, $e8, $04, $b8, $e0, $e0 ; 0x9ca
	db $e9, $90, $fe, $e0, $13, $ff, $17, $33, $ff, $70, $fe, $e0, $33, $f6 ; 0x9d8
	db $e0, $f0, $e1, $c0, $e8, $bf, $9d, $f7, $9f, $f2, $9f, $f0, $fe, $e0 ; 0x9e6
	db $f2, $56, $fe, $e8, $ff, $9f, $a0, $e7, $63, $80, $e0, $49, $fe, $e0 ; 0x9f4
	db $51, $41, $f8, $e4, $f4, $e1, $80, $e9, $0c, $40, $e0, $99, $fe, $e8 ; 0xa02
	db $c7, $98, $ff, $9c, $60, $ea, $c4, $e1, $40, $e0, $7f, $c1, $ee, $fe ; 0xa10
	db $e0, $c9, $7f, $c9, $c0, $e8, $c0, $c0, $e0, $77, $60, $e0, $20, $fe ; 0xa1e
	db $f4, $60, $c0, $c0, $00, $00, $00, $ff, $7f, $7f, $ff, $c0, $ff, $9f ; 0xa2c
	db $f1, $bf, $f7, $e1, $bf, $e7, $fe, $e0, $e3, $bf, $f1, $bf, $f7, $f9 ; 0xa3a
	db $9f, $f9, $f2, $e0, $e3, $bf, $ff, $be, $fb, $ff, $c0, $e2, $e0, $ff ; 0xa48
	db $ff, $00, $ff, $ff, $15, $08, $fe, $e0, $99, $fe, $e0, $98, $fe, $e0 ; 0xa56
	db $f8, $e1, $f4, $e1, $fc, $e6, $e3, $e0, $e2, $df, $71, $ff, $20, $ff ; 0xa64
	db $24, $ba, $fe, $e2, $64, $f8, $e2, $20, $ff, $31, $e0, $e9, $ff, $7d ; 0xa72
	db $92, $fe, $e0, $82, $ff, $86, $ff, $8e, $fe, $e0, $b1, $86, $f6, $e0 ; 0xa80
	db $f0, $e1, $c0, $e8, $f7, $1c, $fe, $e0, $7c, $ec, $fe, $e0, $f8, $e9 ; 0xa8e
	db $ff, $f7, $c0, $e7, $30, $ff, $10, $7a, $bc, $e2, $10, $f6, $e0, $f2 ; 0xa9c
	db $ff, $f2, $9f, $fe, $e1, $fb, $ff, $9f, $80, $e6, $be, $e3, $ff, $41 ; 0xaaa
	db $ff, $1d, $49, $fe, $e0, $41, $ff, $c1, $f8, $e2, $f4, $e1, $80, $e9 ; 0xab8
	db $bd, $80, $3b, $e0, $39, $ff, $39, $ef, $fe, $e4, $ff, $f7, $09, $ff ; 0xac6
	db $89, $60, $ea, $98, $ff, $90, $ff, $4f, $93, $ff, $93, $fe, $fe, $e4 ; 0xad4
	db $f2, $e0, $98, $20, $e4, $7f, $fe, $fe, $ff, $03, $ff, $fd, $87, $fe ; 0xae2
	db $e0, $f9, $9f, $fe, $e0, $f8, $e9, $ff, $fd, $ff, $03, $fe, $01, $fe ; 0xaf0
	db $00, $00, $00 ; 0xafe
DrawMatchMenuItem:
	push af ; $6802
	push de ; $6803
	add a, a ; $6804
	add a, a ; $6805
	add a, $35 ; $6806
	ld l, a ; $6808
	adc a, $68 ; $6809
	sub a, l ; $680b
	ld h, a ; $680c
	ld a, [hl+] ; $680d
	ld h, [hl] ; $680e
	ld l, a ; $680f
	push hl ; $6810
	call GetShadowTilemapAddr ; $6811
	pop hl ; $6814
	ld bc, $0302 ; $6815
	call CopyTextRect ; $6818
	pop de ; $681b
	pop af ; $681c
	add a, a ; $681d
	add a, a ; $681e
	add a, $37 ; $681f
	ld l, a ; $6821
	adc a, $68 ; $6822
	sub a, l ; $6824
	ld h, a ; $6825
	ld a, [hl+] ; $6826
	ld h, [hl] ; $6827
	ld l, a ; $6828
	push hl ; $6829
	call GetShadowAttrmapAddr ; $682a
	pop hl ; $682d
	ld bc, $0302 ; $682e
	call CopyTextRect ; $6831
	ret ; $6834
	; $6835, 386 bytes (records:2)
	dw $6895 ; record 0
	dw $68f5 ; record 1
	dw $689b ; record 2
	dw $68fb ; record 3
	dw $68a1 ; record 4
	dw $6901 ; record 5
	dw $68a7 ; record 6
	dw $6907 ; record 7
	dw $68ad ; record 8
	dw $690d ; record 9
	dw $68b3 ; record 10
	dw $6913 ; record 11
	dw $68b9 ; record 12
	dw $6919 ; record 13
	dw $68bf ; record 14
	dw $691f ; record 15
	dw $68c5 ; record 16
	dw $6925 ; record 17
	dw $68cb ; record 18
	dw $692b ; record 19
	dw $68d1 ; record 20
	dw $6931 ; record 21
	dw $68d7 ; record 22
	dw $6937 ; record 23
	dw $68dd ; record 24
	dw $693d ; record 25
	dw $68e3 ; record 26
	dw $6943 ; record 27
	dw $68e9 ; record 28
	dw $6949 ; record 29
	dw $68e9 ; record 30
	dw $6949 ; record 31
	dw $68e9 ; record 32
	dw $6949 ; record 33
	dw $68e9 ; record 34
	dw $6949 ; record 35
	dw $68e9 ; record 36
	dw $6949 ; record 37
	dw $68ef ; record 38
	dw $694f ; record 39
	dw $68ef ; record 40
	dw $694f ; record 41
	dw $68ef ; record 42
	dw $694f ; record 43
	dw $68ef ; record 44
	dw $694f ; record 45
	dw $68ef ; record 46
	dw $694f ; record 47
	dw $4544 ; record 48
	dw $5446 ; record 49
	dw $5655 ; record 50
	dw $4847 ; record 51
	dw $5749 ; record 52
	dw $5958 ; record 53
	dw $4140 ; record 54
	dw $5040 ; record 55
	dw $5051 ; record 56
	dw $6867 ; record 57
	dw $7769 ; record 58
	dw $7978 ; record 59
	dw $2b2a ; record 60
	dw $3a2c ; record 61
	dw $3c3b ; record 62
	dw $2e2d ; record 63
	dw $3d2f ; record 64
	dw $3f3e ; record 65
	dw $1817 ; record 66
	dw $3729 ; record 67
	dw $3938 ; record 68
	dw $2827 ; record 69
	dw $3729 ; record 70
	dw $3938 ; record 71
	dw $6160 ; record 72
	dw $7060 ; record 73
	dw $7071 ; record 74
	dw $6362 ; record 75
	dw $7262 ; record 76
	dw $7273 ; record 77
	dw $6e6d ; record 78
	dw $7d6f ; record 79
	dw $7f7e ; record 80
	dw $4246 ; record 81
	dw $5643 ; record 82
	dw $5352 ; record 83
	dw $4b4a ; record 84
	dw $5a4c ; record 85
	dw $5c5b ; record 86
	dw $4e4d ; record 87
	dw $5d4f ; record 88
	dw $5f5e ; record 89
	dw $6b6a ; record 90
	dw $7a6c ; record 91
	dw $7c7b ; record 92
	dw $6564 ; record 93
	dw $7466 ; record 94
	dw $7675 ; record 95
	dw $0000 ; record 96
	dw $0000 ; record 97
	dw $0000 ; record 98
	dw $0000 ; record 99
	dw $0000 ; record 100
	dw $0000 ; record 101
	dw $0000 ; record 102
	dw $0020 ; record 103
	dw $2000 ; record 104
	dw $0000 ; record 105
	dw $0000 ; record 106
	dw $0000 ; record 107
	dw $0000 ; record 108
	dw $0000 ; record 109
	dw $0000 ; record 110
	dw $0000 ; record 111
	dw $0000 ; record 112
	dw $0000 ; record 113
	dw $0000 ; record 114
	dw $0000 ; record 115
	dw $0000 ; record 116
	dw $0000 ; record 117
	dw $0000 ; record 118
	dw $0000 ; record 119
	dw $0000 ; record 120
	dw $0020 ; record 121
	dw $2000 ; record 122
	dw $0000 ; record 123
	dw $0020 ; record 124
	dw $2000 ; record 125
	dw $0000 ; record 126
	dw $0000 ; record 127
	dw $0000 ; record 128
	dw $0020 ; record 129
	dw $2000 ; record 130
	dw $0000 ; record 131
	dw $0000 ; record 132
	dw $0000 ; record 133
	dw $0000 ; record 134
	dw $0000 ; record 135
	dw $0000 ; record 136
	dw $0000 ; record 137
	dw $0000 ; record 138
	dw $0000 ; record 139
	dw $0000 ; record 140
	dw $0000 ; record 141
	dw $0000 ; record 142
	dw $0000 ; record 143
	dw $0000 ; record 144
	dw $0000 ; record 145
	dw $0000 ; record 146
	dw $4a49 ; record 147
	dw $144b ; record 148
	dw $1615 ; record 149
	dw $1817 ; record 150
	dw $1a19 ; record 151
	dw $1c1b ; record 152
	dw $5a59 ; record 153
	dw $245b ; record 154
	dw $2625 ; record 155
	dw $2827 ; record 156
	dw $2a29 ; record 157
	dw $2c2b ; record 158
	dw $0000 ; record 159
	dw $0000 ; record 160
	dw $0000 ; record 161
	dw $0000 ; record 162
	dw $0000 ; record 163
	dw $0000 ; record 164
	dw $0000 ; record 165
	dw $0000 ; record 166
	dw $0000 ; record 167
	dw $0000 ; record 168
	dw $0000 ; record 169
	dw $0000 ; record 170
	dw $0a11 ; record 171
	dw $cd03 ; record 172
	dw GetShadowTilemapAddr ; record 173
	dw $5b21 ; record 174
	dw $0169 ; record 175
	dw $0c02 ; record 176
	dw $46cd ; record 177
	dw $112b ; record 178
	dw $030a ; record 179
	dw $2ecd ; record 180
	dw $2146 ; record 181
	dw $6973 ; record 182
	dw $0201 ; record 183
	dw $cd0c ; record 184
	dw $2b46 ; record 185
	dw $c8fa ; record 186
	dw $a7c4 ; record 187
	dw $3ec8 ; record 188
	dw $1105 ; record 189
	dw $090a ; record 190
	dw $02cd ; record 191
	dw $c968 ; record 192
QueueMatchMenuCursorSprite:
	ld a, d ; $69b7
	add a, $fc ; $69b8
	ld d, a ; $69ba
	call AdjustSpriteCoordsForScroll ; $69bb
	ld hl, SpriteTemplate_06_69e7 ; $69be
	ld bc, $0000 ; $69c1
	call QueueSpriteTemplate ; $69c4
	ret ; $69c7
Func_06_69c8:
	ld h, $05 ; $69c8
	ld a, [$c4e3] ; $69ca
	ld l, a ; $69cd
	add hl, hl ; $69ce
	add hl, hl ; $69cf
	add hl, hl ; $69d0
	ld de, $fcf0 ; $69d1
	add hl, de ; $69d4
	ld e, l ; $69d5
	ld d, h ; $69d6
	farcall FarPtr_AddBobbingOffsetYLarge ; $69d7
	call AdjustSpriteCoordsForScroll ; $69da
	ld hl, SpriteTemplate_06_6a10 ; $69dd
	ld bc, $0000 ; $69e0
	call QueueSpriteTemplate ; $69e3
	ret ; $69e6
SpriteTemplate_06_69e7:
	; $69e7, 41 bytes (sprite_template)
	oam_sprite $00, $20, $64, $02
	oam_sprite $00, $28, $66, $02
	oam_sprite $10, $08, $40, $02
	oam_sprite $10, $10, $42, $02
	oam_sprite $10, $18, $44, $02
	oam_sprite $10, $20, $46, $02
	oam_sprite $10, $28, $48, $02
	oam_sprite $10, $30, $4a, $02
	oam_sprite $10, $38, $4c, $02
	oam_sprite $10, $40, $4e, $02
	oam_sprite_end
SpriteTemplate_06_6a10:
	; $6a10, 41 bytes (sprite_template)
	oam_sprite $10, $08, $50, $02
	oam_sprite $10, $10, $52, $02
	oam_sprite $10, $18, $54, $02
	oam_sprite $10, $20, $56, $02
	oam_sprite $10, $28, $58, $02
	oam_sprite $10, $30, $5a, $02
	oam_sprite $10, $38, $5c, $02
	oam_sprite $10, $40, $5e, $02
	oam_sprite $10, $48, $60, $02
	oam_sprite $10, $50, $62, $02
	oam_sprite_end
Text_06_6a39:
	INCLUDE "data/bank_006/text_6a39.asm" ; $6a39, 129 bytes
DrawDebugStatsLabels:
	ld de, $0000 ; $6aba
	call GetShadowAttrmapAddr ; $6abd
	ld c, e ; $6ac0
	ld b, d ; $6ac1
	ld de, $0000 ; $6ac2
	call GetShadowTilemapAddr ; $6ac5
	ld hl, $0f11 ; $6ac8
	call DrawWindowFrameNoPriority ; $6acb
	ld c, $00 ; $6ace
	ld de, $0101 ; $6ad0
Label_06_6ad3:
	push bc ; $6ad3
	push de ; $6ad4
	push bc ; $6ad5
	call GetShadowTilemapAddr ; $6ad6
	pop bc ; $6ad9
	ld a, c ; $6ada
	add a, a ; $6adb
	add a, $39 ; $6adc
	ld l, a ; $6ade
	adc a, $6a ; $6adf
	sub a, l ; $6ae1
	ld h, a ; $6ae2
	ld a, [hl+] ; $6ae3
	ld h, [hl] ; $6ae4
	ld l, a ; $6ae5
	call CopyTextString ; $6ae6
	pop de ; $6ae9
	pop bc ; $6aea
	inc e ; $6aeb
	inc c ; $6aec
	ld a, c ; $6aed
	cp a, $0f ; $6aee
	jr nz, Label_06_6ad3 ; $6af0
	ret ; $6af2
DrawDebugStatsValues:
	ld de, $0a01 ; $6af3
	call GetShadowTilemapAddr ; $6af6
	ld hl, $c760 ; $6af9
	ld a, [hl+] ; $6afc
	ld h, [hl] ; $6afd
	ld l, a ; $6afe
	call DrawDebugStatWord ; $6aff
	ld hl, $c764 ; $6b02
	ld a, [hl+] ; $6b05
	ld h, [hl] ; $6b06
	ld l, a ; $6b07
	call DrawDebugStatWord ; $6b08
	ld hl, $c766 ; $6b0b
	ld a, [hl+] ; $6b0e
	ld h, [hl] ; $6b0f
	ld l, a ; $6b10
	call DrawDebugStatWord ; $6b11
	ld a, [$c768] ; $6b14
	call DrawDebugStatByte ; $6b17
	ld a, [$c769] ; $6b1a
	call DrawDebugStatByte ; $6b1d
	ld a, [$c76a] ; $6b20
	call DrawDebugStatByte ; $6b23
	ld a, [$c76b] ; $6b26
	call DrawDebugStatByte ; $6b29
	ld a, [$c76c] ; $6b2c
	call DrawDebugStatByte ; $6b2f
	ld a, [$c76d] ; $6b32
	call DrawDebugStatByte ; $6b35
	ld a, [$c76e] ; $6b38
	call DrawDebugStatByte ; $6b3b
	ld a, [$c76f] ; $6b3e
	call DrawDebugStatByte ; $6b41
	ld hl, $c770 ; $6b44
	ld a, [hl+] ; $6b47
	ld h, [hl] ; $6b48
	ld l, a ; $6b49
	call DrawDebugStatWord ; $6b4a
	ld hl, $c772 ; $6b4d
	ld a, [hl+] ; $6b50
	ld h, [hl] ; $6b51
	ld l, a ; $6b52
	call DrawDebugStatWord ; $6b53
	ld hl, $c774 ; $6b56
	ld a, [hl+] ; $6b59
	ld h, [hl] ; $6b5a
	ld l, a ; $6b5b
	call DrawDebugStatWord ; $6b5c
	ld hl, $c776 ; $6b5f
	ld a, [hl+] ; $6b62
	ld h, [hl] ; $6b63
	ld l, a ; $6b64
	call DrawDebugStatWord ; $6b65
	ret ; $6b68
DrawDebugStatByte:
	push de ; $6b69
	ld l, a ; $6b6a
	ld h, $00 ; $6b6b
	call DrawHexWord ; $6b6d
	pop de ; $6b70
	ld hl, $0020 ; $6b71
	add hl, de ; $6b74
	ld e, l ; $6b75
	ld d, h ; $6b76
	ret ; $6b77
DrawDebugStatWord:
	push de ; $6b78
	call DrawHexWord ; $6b79
	pop de ; $6b7c
	ld hl, $0020 ; $6b7d
	add hl, de ; $6b80
	ld e, l ; $6b81
	ld d, h ; $6b82
	ret ; $6b83
RunDebugStatsEditor:
	ldh a, [hWramBank] ; $6b84
	push af ; $6b86
	farcall FarPtr_StepMatchFrame ; $6b87
	farcall FarPtr_01_12 ; $6b8a
	wram_bank $04 ; $6b8d
	ld hl, $df00 ; $6b93
	ld de, $c700 ; $6b96
	ld c, $08 ; $6b99
	call CopyMemoryFast ; $6b9b
	wram_bank $02 ; $6b9e
	farcall FarPtr_StepMatchFrame ; $6ba4
	xor a, a ; $6ba7
	ld [wMatchMenuSelection], a ; $6ba8
	call DrawDebugStatsLabels ; $6bab
	call DrawDebugStatsValues ; $6bae
	call FlushTilemapToVram ; $6bb1
	farcall FarPtr_StepMatchFrame ; $6bb4
Label_06_6bb7:
	farcall FarPtr_ReadMatchInputPressed ; $6bb7
	and a, $0d ; $6bba
	jr nz, Label_06_6bc9 ; $6bbc
	call HandleDebugStatsInput ; $6bbe
	call FlushTilemapToVramIfDirty ; $6bc1
	farcall FarPtr_StepMatchFrame ; $6bc4
	jr Label_06_6bb7 ; $6bc7
Label_06_6bc9:
	and a, $08 ; $6bc9
	jr z, Label_06_6bd6 ; $6bcb
	ld de, $270b ; $6bcd
	ld hl, wMinigamesCurrentScore ; $6bd0
	ld a, e ; $6bd3
	ld [hl+], a ; $6bd4
	ld [hl], d ; $6bd5
Label_06_6bd6:
	call RestoreBgTilemap ; $6bd6
	call FlushTilemapToVram ; $6bd9
	farcall FarPtr_StepMatchFrame ; $6bdc
	wram_bank $04 ; $6bdf
	ld hl, $c700 ; $6be5
	ld de, $df00 ; $6be8
	ld c, $08 ; $6beb
	call CopyMemoryFast ; $6bed
	pop af ; $6bf0
	wram_bank ; $6bf1
	ret ; $6bf5
HandleDebugStatsInput:
	ldh a, [hInputPressed] ; $6bf6
	ld b, a ; $6bf8
	ld c, $0b ; $6bf9
	ld a, [wMatchMenuSelection] ; $6bfb
	call MoveCursorVertical ; $6bfe
	ld [wMatchMenuSelection], a ; $6c01
	call AdjustSelectedDebugStat ; $6c04
	call QueueDebugStatsCursorSprites ; $6c07
	call DrawDebugStatsValues ; $6c0a
	ld a, $01 ; $6c0d
	ld [$c4e2], a ; $6c0f
	ret ; $6c12
QueueDebugStatsCursorSprites:
	ld de, $0c0c ; $6c13
	call AdjustSpriteCoordsForScroll ; $6c16
	ld a, [wMatchMenuSelection] ; $6c19
	add a, a ; $6c1c
	add a, a ; $6c1d
	add a, a ; $6c1e
	add a, e ; $6c1f
	ld e, a ; $6c20
	ld bc, $0942 ; $6c21
	call QueueSprite ; $6c24
	ld a, d ; $6c27
	add a, $40 ; $6c28
	ld d, a ; $6c2a
	ld bc, $0942 ; $6c2b
	call QueueSprite ; $6c2e
	ret ; $6c31
AdjustSelectedDebugStat:
	ld a, [wMatchMenuSelection] ; $6c32
	rst Rst00 ; $6c35
	dw Label_06_6c4c ; $6c36 jumptable
	dw Label_06_6c55 ; $6c38 jumptable
	dw Label_06_6c5e ; $6c3a jumptable
	dw Label_06_6c67 ; $6c3c jumptable
	dw Label_06_6c6f ; $6c3e jumptable
	dw Label_06_6c77 ; $6c40 jumptable
	dw Label_06_6c7f ; $6c42 jumptable
	dw Label_06_6c85 ; $6c44 jumptable
	dw Label_06_6c8b ; $6c46 jumptable
	dw Label_06_6c91 ; $6c48 jumptable
	dw Label_06_6c97 ; $6c4a jumptable
Label_06_6c4c:
	ld hl, $c760 ; $6c4c
	ld bc, $0010 ; $6c4f
	jp AdjustDebugStatWord ; $6c52
Label_06_6c55:
	ld hl, $c764 ; $6c55
	ld bc, $0010 ; $6c58
	jp AdjustDebugStatWord ; $6c5b
Label_06_6c5e:
	ld hl, $c766 ; $6c5e
	ld bc, $0010 ; $6c61
	jp AdjustDebugStatWord ; $6c64
Label_06_6c67:
	ld hl, $c768 ; $6c67
	ld b, $02 ; $6c6a
	jp AdjustDebugStatByte ; $6c6c
Label_06_6c6f:
	ld hl, $c769 ; $6c6f
	ld b, $08 ; $6c72
	jp AdjustDebugStatByte ; $6c74
Label_06_6c77:
	ld hl, $c76a ; $6c77
	ld b, $02 ; $6c7a
	jp AdjustDebugStatByte ; $6c7c
Label_06_6c7f:
	ld hl, $c76b ; $6c7f
	jp AdjustDebugStatDigit ; $6c82
Label_06_6c85:
	ld hl, $c76c ; $6c85
	jp AdjustDebugStatDigit ; $6c88
Label_06_6c8b:
	ld hl, $c76d ; $6c8b
	jp AdjustDebugStatDigit ; $6c8e
Label_06_6c91:
	ld hl, $c76e ; $6c91
	jp AdjustDebugStatDigit ; $6c94
Label_06_6c97:
	ld hl, $c76f ; $6c97
	jp AdjustDebugStatDigit ; $6c9a
AdjustDebugStatDigit:
	ldh a, [hInputPressed] ; $6c9d
	ld b, a ; $6c9f
	ld c, $0a ; $6ca0
	ld a, [hl] ; $6ca2
	call MoveCursorHorizontal ; $6ca3
	ld [hl], a ; $6ca6
	ret ; $6ca7
AdjustDebugStatByte:
	ldh a, [hInputPressed] ; $6ca8
	bit PADB_LEFT, a ; $6caa
	jr nz, Label_06_6cb3 ; $6cac
	bit 4, a ; $6cae
	jr nz, Label_06_6cb7 ; $6cb0
	ret ; $6cb2
Label_06_6cb3:
	ld a, [hl] ; $6cb3
	sub a, b ; $6cb4
	ld [hl], a ; $6cb5
	ret ; $6cb6
Label_06_6cb7:
	ld a, [hl] ; $6cb7
	add a, b ; $6cb8
	ld [hl], a ; $6cb9
	ret ; $6cba
AdjustDebugStatWord:
	ldh a, [hInputPressed] ; $6cbb
	bit PADB_LEFT, a ; $6cbd
	jr nz, Label_06_6cc6 ; $6cbf
	bit 4, a ; $6cc1
	jr nz, Label_06_6cd3 ; $6cc3
	ret ; $6cc5
Label_06_6cc6:
	ld a, [hl+] ; $6cc6
	ld e, a ; $6cc7
	ld d, [hl] ; $6cc8
	ld a, e ; $6cc9
	sub a, c ; $6cca
	ld e, a ; $6ccb
	ld a, d ; $6ccc
	sbc a, b ; $6ccd
	ld d, a ; $6cce
	ld a, d ; $6ccf
	ld [hl-], a ; $6cd0
	ld [hl], e ; $6cd1
	ret ; $6cd2
Label_06_6cd3:
	ld a, [hl+] ; $6cd3
	ld e, a ; $6cd4
	ld d, [hl] ; $6cd5
	ld a, e ; $6cd6
	add a, c ; $6cd7
	ld e, a ; $6cd8
	ld a, d ; $6cd9
	adc a, b ; $6cda
	ld d, a ; $6cdb
	ld a, d ; $6cdc
	ld [hl-], a ; $6cdd
	ld [hl], e ; $6cde
	ret ; $6cdf
	; $6ce0, 48 bytes (bytes:8)
	db $00, $01, $02, $03, $04, $00, $00, $00 ; 0x00
	db $0e, $0f, $00, $00, $02, $00, $00, $00 ; 0x08
	db $04, $05, $00, $00, $02, $00, $00, $00 ; 0x10
	db $06, $07, $08, $00, $03, $00, $00, $00 ; 0x18
	db $09, $0a, $00, $00, $02, $00, $00, $00 ; 0x20
	db $0b, $0c, $0d, $00, $03, $00, $00, $00 ; 0x28
RunStoryMenu:
	call GetStoryMenuItemCount ; $6d10
	ld [$c4e7], a ; $6d13
	call DrawStoryMenuItems ; $6d16
	jr Label_06_6d4d ; $6d19
Label_06_6d1b:
	farcall FarPtr_ReadMatchInputPressed ; $6d1b
	and a, $0a ; $6d1e
	jr z, Label_06_6d2b ; $6d20
	sound $62 ; $6d22
	ld a, $ff ; $6d24
	ld [wMatchMenuSelection], a ; $6d26
	jr Label_06_6d70 ; $6d29
Label_06_6d2b:
	farcall FarPtr_ReadMatchInputPressed ; $6d2b
	and a, $01 ; $6d2e
	jr z, Label_06_6d36 ; $6d30
	sound $5f ; $6d32
	jr Label_06_6d70 ; $6d34
Label_06_6d36:
	farcall FarPtr_ReadMatchInputRepeat ; $6d36
	and a, $30 ; $6d39
	jr z, Label_06_6d68 ; $6d3b
	ld b, a ; $6d3d
	ld a, [$c4e7] ; $6d3e
	ld c, a ; $6d41
	ld a, [wMatchMenuSelection] ; $6d42
	call MoveCursorHorizontal ; $6d45
	ld [wMatchMenuSelection], a ; $6d48
	sound $5e ; $6d4b
Label_06_6d4d:
	ld a, [wMatchMenuSelection] ; $6d4d
	call GetStoryMenuItemId ; $6d50
	push af ; $6d53
	call LoadStoryMenuItemGfx ; $6d54
	pop af ; $6d57
	add a, $62 ; $6d58
	ld l, a ; $6d5a
	adc a, $01 ; $6d5b
	sub a, l ; $6d5d
	ld h, a ; $6d5e
	ld de, $000e ; $6d5f
	call DrawStoryMenuCaption ; $6d62
	call RedrawStoryTilemapRows ; $6d65
Label_06_6d68:
	call DrawStoryMenuCursor ; $6d68
	call AdvanceFrame ; $6d6b
	jr Label_06_6d1b ; $6d6e
Label_06_6d70:
	call AdvanceFrame ; $6d70
	ret ; $6d73
GetStoryMenuItemId:
	ld b, a ; $6d74
	ld a, [$c4e6] ; $6d75
	add a, a ; $6d78
	add a, a ; $6d79
	add a, a ; $6d7a
	add a, $e0 ; $6d7b
	ld l, a ; $6d7d
	adc a, $6c ; $6d7e
	sub a, l ; $6d80
	ld h, a ; $6d81
	ld a, b ; $6d82
	add a, l ; $6d83
	ld l, a ; $6d84
	jr nc, Label_06_6d88 ; $6d85
	inc h ; $6d87
Label_06_6d88:
	ld a, [hl] ; $6d88
	ret ; $6d89
GetStoryMenuItemCount:
	ld a, [$c4e6] ; $6d8a
	add a, a ; $6d8d
	add a, a ; $6d8e
	add a, a ; $6d8f
	add a, $e4 ; $6d90
	ld l, a ; $6d92
	adc a, $6c ; $6d93
	sub a, l ; $6d95
	ld h, a ; $6d96
	ld a, [hl] ; $6d97
	ret ; $6d98
DrawStoryMenuItems:
	ld a, [$c4e7] ; $6d99
	add a, a ; $6d9c
	add a, $c1 ; $6d9d
	ld l, a ; $6d9f
	adc a, $6d ; $6da0
	sub a, l ; $6da2
	ld h, a ; $6da3
	ld a, [hl+] ; $6da4
	ld h, [hl] ; $6da5
	ld l, a ; $6da6
	ld a, [$c4e7] ; $6da7
	ld c, a ; $6daa
	ld b, $00 ; $6dab
Label_06_6dad:
	ld a, [hl+] ; $6dad
	ld e, a ; $6dae
	ld a, [hl+] ; $6daf
	ld d, a ; $6db0
	push bc ; $6db1
	push hl ; $6db2
	ld a, b ; $6db3
	call GetStoryMenuItemId ; $6db4
	call DrawStoryMenuItem ; $6db7
	pop hl ; $6dba
	pop bc ; $6dbb
	inc b ; $6dbc
	dec c ; $6dbd
	jr nz, Label_06_6dad ; $6dbe
	ret ; $6dc0
	; $6dc1, 28 bytes (records:2)
	dw $6dcb ; record 0
	dw $6dcb ; record 1
	dw $6dcb ; record 2
	dw $6dcf ; record 3
	dw $6dd5 ; record 4
	dw $050a ; record 5
	dw $0b0a ; record 6
	dw $040a ; record 7
	dw $080a ; record 8
	dw $0c0a ; record 9
	dw $030a ; record 10
	dw $060a ; record 11
	dw $090a ; record 12
	dw $0c0a ; record 13
DrawStoryMenuCursor:
	ld a, [$c4e7] ; $6ddd
	add a, a ; $6de0
	add a, $fb ; $6de1
	ld l, a ; $6de3
	adc a, $6d ; $6de4
	sub a, l ; $6de6
	ld h, a ; $6de7
	ld a, [hl+] ; $6de8
	ld h, [hl] ; $6de9
	ld l, a ; $6dea
	ld a, [wMatchMenuSelection] ; $6deb
	add a, a ; $6dee
	add a, l ; $6def
	ld l, a ; $6df0
	jr nc, Label_06_6df4 ; $6df1
	inc h ; $6df3
Label_06_6df4:
	ld a, [hl+] ; $6df4
	ld d, [hl] ; $6df5
	ld e, a ; $6df6
	call QueueStoryMenuCursorSprite ; $6df7
	ret ; $6dfa
	; $6dfb, 28 bytes (records:2)
	dw $6e05 ; record 0
	dw $6e05 ; record 1
	dw $6e05 ; record 2
	dw $6e09 ; record 3
	dw $6e0f ; record 4
	dw $1860 ; record 5
	dw $4860 ; record 6
	dw $1060 ; record 7
	dw $3060 ; record 8
	dw $5060 ; record 9
	dw $0860 ; record 10
	dw $2060 ; record 11
	dw $3860 ; record 12
	dw $5060 ; record 13
RunStoryModeMenu:
	ldh a, [hWramBank] ; $6e17
	push af ; $6e19
	farcall FarPtr_StopSceneTileAnimations ; $6e1a
	ldh a, [$ffdd] ; $6e1d
	push af ; $6e1f
	call AdvanceFrame ; $6e20
	sound $63 ; $6e23
	xor a, a ; $6e25
	ld [wMatchMenuSelection], a ; $6e26
	ld a, $02 ; $6e29
	ldh [$ffdd], a ; $6e2b
	farcall FarPtr_InitTextWindows ; $6e2d
	ld a, $81 ; $6e30
	ld [wWindowTileAttr], a ; $6e32
	set_flag $02, 4 ; $6e35
	farcall FarPtr_28_0a ; $6e38
	call RestoreStoryTilemapNoPriority ; $6e3b
	ld d, $00 ; $6e3e
	ld e, $0e ; $6e40
	ld b, $13 ; $6e42
	ld c, $03 ; $6e44
	farcall FarPtr_CreateWindowFromScreenRect ; $6e46
	call AdvanceFrame ; $6e49
	wram_bank $05 ; $6e4c
Label_06_6e52:
	ld hl, $5280 ; $6e52
	ld de, $8640 ; $6e55
	ld c, $04 ; $6e58
	call QueueVRAMCopy ; $6e5a
	ld a, $00 ; $6e5d
	ld [$c4e6], a ; $6e5f
	call RunStoryMenu ; $6e62
	ld a, [wMatchMenuSelection] ; $6e65
	cp a, $ff ; $6e68
	jr z, Label_06_6e94 ; $6e6a
	push af ; $6e6c
	ld hl, $6e7d ; $6e6d
	push hl ; $6e70
	ld a, [wMatchMenuSelection] ; $6e71
	rst Rst00 ; $6e74
	dw StoryPauseMenu_PlayerData ; $6e75 jumptable
	dw StoryPauseMenu_GameProgress ; $6e77 jumptable
	dw StoryPauseMenu_Options ; $6e79 jumptable
	dw StoryPauseMenu_SaveQuit ; $6e7b jumptable
	ld b, a ; $6e7d
	pop af ; $6e7e
	ld [wMatchMenuSelection], a ; $6e7f
	cp a, $02 ; $6e82
	jr c, Label_06_6eb2 ; $6e84
	cp a, $03 ; $6e86
	jr nz, Label_06_6e8e ; $6e88
	ld a, b ; $6e8a
	or a, a ; $6e8b
	jr nz, Label_06_6eb2 ; $6e8c
Label_06_6e8e:
	ld a, [wMatchAbortFlag] ; $6e8e
	and a, a ; $6e91
	jr z, Label_06_6e52 ; $6e92
Label_06_6e94:
	call RestoreStoryShadowTilemap ; $6e94
	call RedrawStoryTilemapRows ; $6e97
	call AdvanceFrame ; $6e9a
	clear_flag $02, 4 ; $6e9d
	farcall FarPtr_01_14 ; $6ea0
	pop af ; $6ea3
	ldh [$ffdd], a ; $6ea4
	farcall FarPtr_InitTextWindows ; $6ea6
	farcall FarPtr_InitSceneTileAnimations ; $6ea9
	pop af ; $6eac
	wram_bank ; $6ead
	ret ; $6eb1
Label_06_6eb2:
	ld a, b ; $6eb2
	cp a, $ff ; $6eb3
	jp z, Label_06_6e52 ; $6eb5
	pop af ; $6eb8
	ldh [$ffdd], a ; $6eb9
	clear_flag $02, 4 ; $6ebb
	farcall FarPtr_InitSceneTileAnimations ; $6ebe
	pop af ; $6ec1
	wram_bank ; $6ec2
	ret ; $6ec6
	call Func_06_7863 ; $6ec7
	ld hl, $5280 ; $6eca
	ld de, $8640 ; $6ecd
	ld c, $04 ; $6ed0
	call QueueVRAMCopy ; $6ed2
	jr Label_06_6f07 ; $6ed5
Label_06_6ed7:
	farcall FarPtr_ReadMatchInputPressed ; $6ed7
	and a, $0e ; $6eda
	jr z, Label_06_6ee7 ; $6edc
	sound $62 ; $6ede
	ld a, $ff ; $6ee0
	ld [wMatchMenuSelection], a ; $6ee2
	jr Label_06_6f36 ; $6ee5
Label_06_6ee7:
	farcall FarPtr_ReadMatchInputPressed ; $6ee7
	and a, $01 ; $6eea
	jr z, Label_06_6ef2 ; $6eec
	sound $5f ; $6eee
	jr Label_06_6f36 ; $6ef0
Label_06_6ef2:
	farcall FarPtr_ReadMatchInputRepeat ; $6ef2
	and a, $30 ; $6ef5
	jr z, Label_06_6f20 ; $6ef7
	ld b, a ; $6ef9
	ld c, $04 ; $6efa
	ld a, [wMatchMenuSelection] ; $6efc
	call MoveCursorHorizontal ; $6eff
	ld [wMatchMenuSelection], a ; $6f02
	sound $5e ; $6f05
Label_06_6f07:
	ld a, [wMatchMenuSelection] ; $6f07
	call LoadStoryMenuItemGfx ; $6f0a
	ld a, [wMatchMenuSelection] ; $6f0d
	add a, $62 ; $6f10
	ld l, a ; $6f12
	adc a, $01 ; $6f13
	sub a, l ; $6f15
	ld h, a ; $6f16
	ld de, $000e ; $6f17
	call DrawStoryMenuCaption ; $6f1a
	call RedrawStoryTilemapRows ; $6f1d
Label_06_6f20:
	ld a, [wMatchMenuSelection] ; $6f20
	add a, a ; $6f23
	add a, $3a ; $6f24
	ld l, a ; $6f26
	adc a, $6f ; $6f27
	sub a, l ; $6f29
	ld h, a ; $6f2a
	ld a, [hl+] ; $6f2b
	ld d, [hl] ; $6f2c
	ld e, a ; $6f2d
	call QueueStoryMenuCursorSprite ; $6f2e
	call AdvanceFrame ; $6f31
	jr Label_06_6ed7 ; $6f34
Label_06_6f36:
	call AdvanceFrame ; $6f36
	ret ; $6f39
	INCBIN "data/bank_006/d_6f3a.bin" ; $6f3a, 8 bytes
StoryPauseMenu_PlayerData:
	call RestoreStoryTilemapNoPriority ; $6f42
	xor a, a ; $6f45
	ld [wMatchMenuSelection], a ; $6f46
	ld a, $01 ; $6f49
	ld [$c4e6], a ; $6f4b
	call RunStoryMenu ; $6f4e
	ld a, [wMatchMenuSelection] ; $6f51
	cp a, $ff ; $6f54
	jr z, Label_06_6f60 ; $6f56
	ld a, [wMatchMenuSelection] ; $6f58
	rst Rst00 ; $6f5b
	dw StoryPauseMenu_CharPartnerData ; $6f5c jumptable
	dw StoryPauseMenu_Equipment ; $6f5e jumptable
Label_06_6f60:
	call RestoreStoryTilemapNoPriority ; $6f60
	ld a, $ff ; $6f63
	ret ; $6f65
StoryPauseMenu_CharPartnerData:
	ld hl, wStoryModePlayersXPosition ; $6f66
	ld de, wStoryModeSpawnPosition ; $6f69
	ld bc, $0005 ; $6f6c
	call CopyMemoryBC ; $6f6f
	ld a, $ff ; $6f72
	ld [wStoryModeEntryPoint], a ; $6f74
	ld [$c294], a ; $6f77
	ld [wStoryModeExitLocationRequest], a ; $6f7a
	ld a, $01 ; $6f7d
	farcall FarPtr_ShowCharDataScreen ; $6f7f
	xor a, a ; $6f82
	ret ; $6f83
StoryPauseMenu_Equipment:
	ld hl, wStoryModePlayersXPosition ; $6f84
	ld de, wStoryModeSpawnPosition ; $6f87
	ld bc, $0005 ; $6f8a
	call CopyMemoryBC ; $6f8d
	ld a, $ff ; $6f90
	ld [wStoryModeEntryPoint], a ; $6f92
	ld [$c294], a ; $6f95
	ld [wStoryModeExitLocationRequest], a ; $6f98
	farcall FarPtr_ShowEquipmentStatusScreen ; $6f9b
	xor a, a ; $6f9e
	ret ; $6f9f
StoryPauseMenu_GameProgress:
	ld hl, wStoryModePlayersXPosition ; $6fa0
	ld de, wStoryModeSpawnPosition ; $6fa3
	ld bc, $0005 ; $6fa6
	call CopyMemoryBC ; $6fa9
	ld a, $ff ; $6fac
	ld [wStoryModeEntryPoint], a ; $6fae
	ld [$c294], a ; $6fb1
	ld [wStoryModeExitLocationRequest], a ; $6fb4
	farcall FarPtr_ShowGameProgressScreen ; $6fb7
	xor a, a ; $6fba
	ret ; $6fbb
StoryPauseMenu_Options:
	call RestoreStoryTilemapNoPriority ; $6fbc
	ld a, [$c4c8] ; $6fbf
	and a, a ; $6fc2
	xor a, a ; $6fc3
	ld [wMatchMenuSelection], a ; $6fc4
Label_06_6fc7:
	ld a, $02 ; $6fc7
	ld [$c4e6], a ; $6fc9
	call RunStoryMenu ; $6fcc
	ld a, [wMatchMenuSelection] ; $6fcf
	cp a, $ff ; $6fd2
	jr z, Label_06_6fe9 ; $6fd4
	push af ; $6fd6
	ld hl, $6fe3 ; $6fd7
	push hl ; $6fda
	ld a, [wMatchMenuSelection] ; $6fdb
	rst Rst00 ; $6fde
	dw StoryPauseMenu_MessageSpeed ; $6fdf jumptable
	dw StoryPauseMenu_MusicToggle ; $6fe1 jumptable
	pop af ; $6fe3
	ld [wMatchMenuSelection], a ; $6fe4
	jr Label_06_6fc7 ; $6fe7
Label_06_6fe9:
	ret ; $6fe9
	ld a, $0e ; $6fea
	ld [$c4e1], a ; $6fec
	ld a, $01 ; $6fef
	ld [$c4e6], a ; $6ff1
	jp RunStoryMenu ; $6ff4
StoryPauseMenu_MessageSpeed:
	ld a, [wMessageSpeed] ; $6ff7
	ld b, a ; $6ffa
	ld a, $02 ; $6ffb
	sub a, b ; $6ffd
	ld [wMatchMenuSelection], a ; $6ffe
	call RunMessageSpeedMenu ; $7001
	ld a, [wMatchMenuSelection] ; $7004
	cp a, $ff ; $7007
	jr z, Label_06_7012 ; $7009
	ld b, a ; $700b
	ld a, $02 ; $700c
	sub a, b ; $700e
	ld [wMessageSpeed], a ; $700f
Label_06_7012:
	ret ; $7012
StoryPauseMenu_MusicToggle:
	ldh a, [hMusic] ; $7013
	and a, $01 ; $7015
	ld [wMatchMenuSelection], a ; $7017
	call RunMusicOnOffMenu ; $701a
	ld a, [wMatchMenuSelection] ; $701d
	cp a, $ff ; $7020
	jr z, Label_06_702e ; $7022
	call SetMusicMuted ; $7024
	ldh a, [hMusic] ; $7027
	and a, $01 ; $7029
	farcall FarPtr_SetStorySlotFlagA ; $702b
Label_06_702e:
	ret ; $702e
StoryPauseMenu_SaveQuit:
	call RestoreStoryTilemapNoPriority ; $702f
	ld hl, $0172 ; $7032
	ld de, $000e ; $7035
	call DrawStoryMenuCaption ; $7038
	ld a, $02 ; $703b
	ld [wMatchMenuSelection], a ; $703d
	ld a, $05 ; $7040
	ld [$c4e6], a ; $7042
	call RunStoryMenu ; $7045
	ld a, [wMatchMenuSelection] ; $7048
	cp a, $ff ; $704b
	jr z, Label_06_70a9 ; $704d
	cp a, $02 ; $704f
	jr z, Label_06_70a9 ; $7051
	ld a, [wMatchMenuSelection] ; $7053
	cp a, $01 ; $7056
	jr z, StoryPauseMenu_ReturnToMainMenu ; $7058
	ld a, $01 ; $705a
	ld [$c8a5], a ; $705c
	ld a, [wMessageSpeed] ; $705f
	res 7, a ; $7062
	ld [wMessageSpeed], a ; $7064
	ld bc, rIE ; $7067
	farcall FarPtr_SaveStoryReturnPoint ; $706a
	farcall FarPtr_SaveStorySlotWithTimer ; $706d
	ld a, $00 ; $7070
	ld [wStoryModeCurrentLocation], a ; $7072
	ld a, $01 ; $7075
	ld [wStoryModeEntryPoint], a ; $7077
	ld a, $ff ; $707a
	ld [$c294], a ; $707c
	ld [wStoryModeExitLocationRequest], a ; $707f
	ld a, $01 ; $7082
	jr Label_06_70a8 ; $7084
StoryPauseMenu_ReturnToMainMenu:
	call WaitFramesCmd ; $7086
	db $08 ; $7089 inline arg
	ld a, $01 ; $708a
	ld [wMatchExitRequest], a ; $708c
	ld a, $ff ; $708f
	ld [wMatchAbortFlag], a ; $7091
	ld a, $00 ; $7094
	ld [wStoryModeCurrentLocation], a ; $7096
	ld a, $01 ; $7099
	ld [wStoryModeEntryPoint], a ; $709b
	ld a, $ff ; $709e
	ld [$c294], a ; $70a0
	ld [wStoryModeExitLocationRequest], a ; $70a3
	ld a, $01 ; $70a6
Label_06_70a8:
	ret ; $70a8
Label_06_70a9:
	ld a, $00 ; $70a9
	ret ; $70ab
	ld a, $04 ; $70ac
	ld [$c4e1], a ; $70ae
	jp RunStoryTwoOptionMenu ; $70b1
RunMessageSpeedMenu:
	ld a, $06 ; $70b4
	ld [$c4e1], a ; $70b6
	jp RunStoryThreeOptionMenu ; $70b9
RunMusicOnOffMenu:
	ld a, $09 ; $70bc
	ld [$c4e1], a ; $70be
	jp RunStoryTwoOptionMenu ; $70c1
	ld a, $0b ; $70c4
	ld [$c4e1], a ; $70c6
	jp RunStoryTwoOptionMenu ; $70c9
RunStoryTwoOptionMenu:
	ld a, [$c4e1] ; $70cc
	ld de, $050a ; $70cf
	call DrawStoryMenuItem ; $70d2
	ld a, [$c4e1] ; $70d5
	inc a ; $70d8
	ld de, $0b0a ; $70d9
	call DrawStoryMenuItem ; $70dc
	ld a, [$c4e1] ; $70df
	cp a, $0b ; $70e2
	jr z, Label_06_70f8 ; $70e4
	ld hl, wMatchMenuSelection ; $70e6
	add a, [hl] ; $70e9
	ld hl, $0162 ; $70ea
	add a, l ; $70ed
	ld l, a ; $70ee
	jr nc, Label_06_70f2 ; $70ef
	inc h ; $70f1
Label_06_70f2:
	ld de, $000e ; $70f2
	call DrawStoryMenuCaption ; $70f5
Label_06_70f8:
	call RedrawStoryTilemapRows ; $70f8
	ld a, [wMatchMenuSelection] ; $70fb
	ld hl, $c4e1 ; $70fe
	add a, [hl] ; $7101
	call LoadStoryMenuItemGfx ; $7102
Label_06_7105:
	farcall FarPtr_ReadMatchInputPressed ; $7105
	and a, $02 ; $7108
	jr z, Label_06_7115 ; $710a
	sound $62 ; $710c
	ld a, $ff ; $710e
	ld [wMatchMenuSelection], a ; $7110
	jr Label_06_7172 ; $7113
Label_06_7115:
	farcall FarPtr_ReadMatchInputPressed ; $7115
	and a, $01 ; $7118
	jr z, Label_06_7120 ; $711a
	sound $5f ; $711c
	jr Label_06_7172 ; $711e
Label_06_7120:
	farcall FarPtr_ReadMatchInputRepeat ; $7120
	and a, $30 ; $7123
	jr z, Label_06_715b ; $7125
	ld b, a ; $7127
	ld c, $02 ; $7128
	ld a, [wMatchMenuSelection] ; $712a
	call MoveCursorHorizontal ; $712d
	ld [wMatchMenuSelection], a ; $7130
	sound $5e ; $7133
	ld a, [$c4e1] ; $7135
	cp a, $0b ; $7138
	jr z, Label_06_7151 ; $713a
	ld hl, wMatchMenuSelection ; $713c
	add a, [hl] ; $713f
	ld hl, $0162 ; $7140
	add a, l ; $7143
	ld l, a ; $7144
	jr nc, Label_06_7148 ; $7145
	inc h ; $7147
Label_06_7148:
	ld de, $000e ; $7148
	call DrawStoryMenuCaption ; $714b
	call RedrawStoryTilemapRows ; $714e
Label_06_7151:
	ld a, [wMatchMenuSelection] ; $7151
	ld hl, $c4e1 ; $7154
	add a, [hl] ; $7157
	call LoadStoryMenuItemGfx ; $7158
Label_06_715b:
	ld a, [wMatchMenuSelection] ; $715b
	add a, a ; $715e
	add a, $76 ; $715f
	ld l, a ; $7161
	adc a, $71 ; $7162
	sub a, l ; $7164
	ld h, a ; $7165
	ld a, [hl+] ; $7166
	ld d, [hl] ; $7167
	ld e, a ; $7168
	call QueueStoryMenuCursorSprite ; $7169
	call AdvanceFrame ; $716c
	jp Label_06_7105 ; $716f
Label_06_7172:
	call AdvanceFrame ; $7172
	ret ; $7175
	INCBIN "data/bank_006/d_7176.bin" ; $7176, 4 bytes
RunStoryThreeOptionMenu:
	call RestoreStoryTilemapNoPriority ; $717a
	ld a, [$c4e1] ; $717d
	ld de, $030a ; $7180
	call DrawStoryMenuItem ; $7183
	ld a, [$c4e1] ; $7186
	inc a ; $7189
	ld de, $080a ; $718a
	call DrawStoryMenuItem ; $718d
	ld a, [$c4e1] ; $7190
	inc a ; $7193
	inc a ; $7194
	ld de, $0d0a ; $7195
	call DrawStoryMenuItem ; $7198
	ld a, [$c4e1] ; $719b
	cp a, $06 ; $719e
	ld hl, wMatchMenuSelection ; $71a0
	add a, [hl] ; $71a3
	ld hl, $0162 ; $71a4
	add a, l ; $71a7
	ld l, a ; $71a8
	jr nc, Label_06_71ac ; $71a9
	inc h ; $71ab
Label_06_71ac:
	ld de, $000e ; $71ac
	call DrawStoryMenuCaption ; $71af
	call RedrawStoryTilemapRows ; $71b2
	ld a, [wMatchMenuSelection] ; $71b5
	ld hl, $c4e1 ; $71b8
	add a, [hl] ; $71bb
	call LoadStoryMenuItemGfx ; $71bc
Label_06_71bf:
	farcall FarPtr_ReadMatchInputPressed ; $71bf
	and a, $02 ; $71c2
	jr z, Label_06_71cf ; $71c4
	sound $62 ; $71c6
	ld a, $ff ; $71c8
	ld [wMatchMenuSelection], a ; $71ca
	jr Label_06_722a ; $71cd
Label_06_71cf:
	farcall FarPtr_ReadMatchInputPressed ; $71cf
	and a, $01 ; $71d2
	jr z, Label_06_71da ; $71d4
	sound $5f ; $71d6
	jr Label_06_722a ; $71d8
Label_06_71da:
	farcall FarPtr_ReadMatchInputRepeat ; $71da
	and a, $30 ; $71dd
	jr z, Label_06_7213 ; $71df
	ld b, a ; $71e1
	ld c, $03 ; $71e2
	ld a, [wMatchMenuSelection] ; $71e4
	call MoveCursorHorizontal ; $71e7
	ld [wMatchMenuSelection], a ; $71ea
	sound $5e ; $71ed
	ld a, [$c4e1] ; $71ef
	cp a, $06 ; $71f2
	ld hl, wMatchMenuSelection ; $71f4
	add a, [hl] ; $71f7
	ld hl, $0162 ; $71f8
	add a, l ; $71fb
	ld l, a ; $71fc
	jr nc, Label_06_7200 ; $71fd
	inc h ; $71ff
Label_06_7200:
	ld de, $000e ; $7200
	call DrawStoryMenuCaption ; $7203
	call RedrawStoryTilemapRows ; $7206
	ld a, [wMatchMenuSelection] ; $7209
	ld hl, $c4e1 ; $720c
	add a, [hl] ; $720f
	call LoadStoryMenuItemGfx ; $7210
Label_06_7213:
	ld a, [wMatchMenuSelection] ; $7213
	add a, a ; $7216
	add a, $31 ; $7217
	ld l, a ; $7219
	adc a, $72 ; $721a
	sub a, l ; $721c
	ld h, a ; $721d
	ld a, [hl+] ; $721e
	ld d, [hl] ; $721f
	ld e, a ; $7220
	call QueueStoryMenuCursorSprite ; $7221
	call AdvanceFrame ; $7224
	jp Label_06_71bf ; $7227
Label_06_722a:
	call RestoreStoryTilemapNoPriority ; $722a
	call AdvanceFrame ; $722d
	ret ; $7230
	INCBIN "data/bank_006/d_7231.bin" ; $7231, 6 bytes
RedrawStoryTilemapRows:
	wram_bank $05 ; $7237
	farcall FarPtr_RedrawAllTilemapRows ; $723d
	ret ; $7240
RestoreStoryShadowTilemap:
	farcall FarPtr_RestoreShadowTilemap ; $7241
	ret ; $7244
RestoreStoryTilemapNoPriority:
	farcall FarPtr_RestoreShadowTilemap ; $7245
	call ClearStoryAttrPriorityBits ; $7248
	farcall FarPtr_RedrawAllTilemapRows ; $724b
	ret ; $724e
DrawStoryMenuCaption:
	push hl ; $724f
	farcall FarPtr_PrepareGlyphBuffer ; $7250
	xor a, a ; $7253
	farcall FarPtr_DrawTextWindowFrame ; $7254
	ld hl, $0101 ; $7257
	add hl, de ; $725a
	ld e, l ; $725b
	ld d, h ; $725c
	call GetShadowTilemapAddr ; $725d
	pop hl ; $7260
	ld c, $11 ; $7261
	farcall FarPtr_RenderProportionalTextAt ; $7263
	farcall FarPtr_UploadGlyphBuffer ; $7266
	ret ; $7269
ClearStoryAttrPriorityBits:
	wram_bank $05 ; $726a
	ld hl, wShadowTilemapPtr ; $7270
	ld a, [hl+] ; $7273
	ld h, [hl] ; $7274
	ld l, a ; $7275
	ld bc, $0400 ; $7276
	add hl, bc ; $7279
Label_06_727a:
	res 7, [hl] ; $727a
	inc hl ; $727c
	dec bc ; $727d
	ld a, b ; $727e
	or a, c ; $727f
	jr nz, Label_06_727a ; $7280
	ret ; $7282
LoadStoryMenuItemGfx:
	add a, a ; $7283
	add a, $ae ; $7284
	ld l, a ; $7286
	adc a, $72 ; $7287
	sub a, l ; $7289
	ld h, a ; $728a
	ld a, [hl+] ; $728b
	ld h, [hl] ; $728c
	ld l, a ; $728d
	ld de, $d000 ; $728e
	ldh a, [hWramBank] ; $7291
	push af ; $7293
	wram_bank $01 ; $7294
	call DecompressData ; $729a
	ld hl, $d000 ; $729d
	ld de, $8700 ; $72a0
	ld c, $10 ; $72a3
	call QueueVRAMCopy ; $72a5
	pop af ; $72a8
	wram_bank ; $72a9
	ret ; $72ad
	; $72ae, 32 bytes (records:2)
	dw $7310 ; record 0
	dw $73b0 ; record 1
	dw $5402 ; record 2
	dw $5495 ; record 3
	dw $7467 ; record 4
	dw $55c5 ; record 5
	dw $7512 ; record 6
	dw $772d ; record 7
	dw $7588 ; record 8
	dw $5745 ; record 9
	dw $57c1 ; record 10
	dw $58c5 ; record 11
	dw $5938 ; record 12
	dw $5844 ; record 13
	dw $7601 ; record 14
	dw $76b0 ; record 15
QueueStoryMenuCursorSprite:
	ld a, d ; $72ce
	add a, $fc ; $72cf
	ld d, a ; $72d1
	call AdjustSpriteCoordsForScroll ; $72d2
	ld hl, SpriteTemplate_06_72df ; $72d5
	ld bc, $0000 ; $72d8
	call QueueSpriteTemplate ; $72db
	ret ; $72de
SpriteTemplate_06_72df:
	; $72df, 41 bytes (sprite_template)
	oam_sprite $00, $20, $64, $02
	oam_sprite $00, $28, $66, $02
	oam_sprite $10, $08, $70, $02
	oam_sprite $10, $10, $72, $02
	oam_sprite $10, $18, $74, $02
	oam_sprite $10, $20, $76, $02
	oam_sprite $10, $28, $78, $02
	oam_sprite $10, $30, $7a, $02
	oam_sprite $10, $38, $7c, $02
	oam_sprite $10, $40, $7e, $02
	oam_sprite_end
	INCBIN "data/bank_006/d_7308.bin" ; $7308, 1182 bytes
DrawStoryMenuItem:
	push de ; $77a6
	add a, a ; $77a7
	add a, $cb ; $77a8
	ld l, a ; $77aa
	adc a, $77 ; $77ab
	sub a, l ; $77ad
	ld h, a ; $77ae
	ld a, [hl+] ; $77af
	ld h, [hl] ; $77b0
	ld l, a ; $77b1
	push hl ; $77b2
	call GetShadowTilemapAddr ; $77b3
	pop hl ; $77b6
	ld bc, $0302 ; $77b7
	call CopyTileRectToShadowTilemap ; $77ba
	pop de ; $77bd
	call GetShadowAttrmapAddr ; $77be
	ld hl, $6955 ; $77c1
	ld bc, $0302 ; $77c4
	call CopyTileRectToShadowAttrmap ; $77c7
	ret ; $77ca
	; $77cb, 32 bytes (records:2)
	dw $77eb ; record 0
	dw $77f1 ; record 1
	dw $77f7 ; record 2
	dw $77fd ; record 3
	dw $7803 ; record 4
	dw $7809 ; record 5
	dw $780f ; record 6
	dw $7815 ; record 7
	dw $781b ; record 8
	dw $7821 ; record 9
	dw $7827 ; record 10
	dw $782d ; record 11
	dw $7833 ; record 12
	dw $7839 ; record 13
	dw $783f ; record 14
	dw $7845 ; record 15
	; $77eb, 120 bytes (bytes:6)
	db $49, $4a, $4b, $59, $5a, $5b ; 0x00
	db $14, $15, $16, $24, $25, $26 ; 0x06
	db $17, $18, $19, $27, $28, $29 ; 0x0c
	db $1a, $1b, $1c, $2a, $2b, $2c ; 0x12
	db $1d, $1e, $1f, $2d, $2e, $2f ; 0x18
	db $e0, $e1, $e2, $f0, $f1, $f2 ; 0x1e
	db $4c, $4d, $4e, $5c, $5d, $5e ; 0x24
	db $e9, $ea, $eb, $f9, $fa, $fb ; 0x2a
	db $ec, $ed, $ee, $fc, $fd, $fe ; 0x30
	db $e3, $e4, $e5, $f3, $f4, $f5 ; 0x36
	db $e6, $e7, $e8, $f6, $f7, $f8 ; 0x3c
	db $43, $44, $45, $53, $54, $55 ; 0x42
	db $46, $47, $48, $56, $57, $58 ; 0x48
	db $60, $61, $62, $63, $64, $65 ; 0x4e
	db $40, $41, $42, $50, $51, $52 ; 0x54
	db $12, $13, $4f, $22, $23, $5f ; 0x5a
	db $49, $4a, $4b, $14, $15, $16 ; 0x60
	db $17, $18, $19, $1a, $1b, $1c ; 0x66
	db $59, $5a, $5b, $24, $25, $26 ; 0x6c
	db $27, $28, $29, $2a, $2b, $2c ; 0x72
Func_06_7863:
	ld de, $030a ; $7863
	call GetShadowTilemapAddr ; $7866
	ld hl, $784b ; $7869
	ld bc, $0c02 ; $786c
	call CopyTileRectToShadowTilemap ; $786f
	ld de, $030a ; $7872
	call GetShadowAttrmapAddr ; $7875
	ld hl, $6973 ; $7878
	ld bc, $0c02 ; $787b
	call CopyTileRectToShadowAttrmap ; $787e
	ret ; $7881
CopyTileRectToShadowTilemap:
	push bc ; $7882
	push de ; $7883
Label_06_7884:
	ld a, [hl+] ; $7884
	and a, a ; $7885
	ld [de], a ; $7886
	inc de ; $7887
	push hl ; $7888
	ld a, e ; $7889
	and a, $1f ; $788a
	jr nz, Label_06_7896 ; $788c
	ld h, d ; $788e
	ld l, e ; $788f
	ld de, $ffe0 ; $7890
	add hl, de ; $7893
	ld d, h ; $7894
	ld e, l ; $7895
Label_06_7896:
	pop hl ; $7896
	dec b ; $7897
	jr nz, Label_06_7884 ; $7898
	pop de ; $789a
	pop bc ; $789b
	ld a, $20 ; $789c
	add a, e ; $789e
	ld e, a ; $789f
	jr nc, Label_06_78a3 ; $78a0
	inc d ; $78a2
Label_06_78a3:
	ld a, d ; $78a3
	and a, $f3 ; $78a4
	ld d, a ; $78a6
	dec c ; $78a7
	jr nz, CopyTileRectToShadowTilemap ; $78a8
	ret ; $78aa
CopyTileRectToShadowAttrmap:
	push bc ; $78ab
	push de ; $78ac
Label_06_78ad:
	ld a, [hl+] ; $78ad
	and a, a ; $78ae
	ld [de], a ; $78af
	inc de ; $78b0
	push hl ; $78b1
	ld a, e ; $78b2
	and a, $1f ; $78b3
	jr nz, Label_06_78bf ; $78b5
	ld h, d ; $78b7
	ld l, e ; $78b8
	ld de, $ffe0 ; $78b9
	add hl, de ; $78bc
	ld d, h ; $78bd
	ld e, l ; $78be
Label_06_78bf:
	pop hl ; $78bf
	dec b ; $78c0
	jr nz, Label_06_78ad ; $78c1
	pop de ; $78c3
	pop bc ; $78c4
	ld a, $20 ; $78c5
	add a, e ; $78c7
	ld e, a ; $78c8
	jr nc, Label_06_78cc ; $78c9
	inc d ; $78cb
Label_06_78cc:
	ld a, d ; $78cc
	cp a, $d8 ; $78cd
	jr c, Label_06_78d3 ; $78cf
	ld d, $d4 ; $78d1
Label_06_78d3:
	dec c ; $78d3
	jr nz, CopyTileRectToShadowAttrmap ; $78d4
	ret ; $78d6
	ds 1833, $ff ; $78d7, fill
