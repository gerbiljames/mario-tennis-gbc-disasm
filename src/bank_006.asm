SECTION "ROM Bank $06", ROMX[$4000], BANK[$06]

	farptr RunMatchPauseMenu ; $4000
	farptr RunDebugStatsEditor ; $4002
	farptr ShowMessageWindow ; $4004
	farptr ShowMatchScoreboardScreen ; $4006
	farptr RunStoryModeMenu ; $4008
	farptr FlushTilemapToVram ; $400a
	farptr RunMinigameEndMenu ; $400c
RunMinigameEndMenu:
	ldh a, [hWramBank] ; $400e
	push af ; $4010
	farcall StepMatchFrame ; $4011
	call PrepareScoreboardGfx ; $4014
	farcall StepMatchFrame ; $4017
	call LoadScoreboardModeGfx ; $401a
	ld hl, ScoreboardModeGfxTail ; $401d
	ld de, $8640 ; $4020
	ld c, $04 ; $4023
	call QueueVRAMCopy ; $4025
	farcall StepMatchFrame ; $4028
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
	farcall StepMatchFrame ; $406b
	pop af ; $406e
	wram_bank ; $406f
	ret ; $4073
RunMatchPauseMenu:
	ldh a, [hWramBank] ; $4074
	push af ; $4076
	ldh a, [$ffdd] ; $4077
	push af ; $4079
	farcall StepMatchFrame ; $407a
	farcall StepMatchFrame ; $407d
	sound $63 ; $4080
	xor a, a ; $4082
	ld [wMatchMenuSelection], a ; $4083
	ld a, $02 ; $4086
	ldh [$ffdd], a ; $4088
	call PrepareScoreboardGfx ; $408a
	farcall StepMatchFrame ; $408d
	call LoadScoreboardModeGfx ; $4090
	ld hl, ScoreboardModeGfxTail ; $4093
	ld de, $8640 ; $4096
	ld c, $04 ; $4099
	call QueueVRAMCopy ; $409b
	farcall StepMatchFrame ; $409e
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
	ld hl, Func_06_40e5 ; $40d5
	push hl ; $40d8
	ld a, [wMatchMenuSelection] ; $40d9
	rst Rst00 ; $40dc
	dw MatchPauseMenu_CheckRules ; $40dd jumptable
	dw MatchPauseMenu_ReviewControls ; $40df jumptable
	dw MatchPauseMenu_ChangeOptions ; $40e1 jumptable
	dw MatchPauseMenu_SaveQuit ; $40e3 jumptable
Func_06_40e5:
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
	farcall StepMatchFrame ; $4101
	farcall StepMatchFrame ; $4104
	pop af ; $4107
	ldh [$ffdd], a ; $4108
	pop af ; $410a
	wram_bank ; $410b
	ret ; $410f
MatchPauseMenu_CheckRules:
	ld hl, Func_06_506a ; $4110
	call UnregisterFrameTask ; $4113
	call RestoreBgTilemap ; $4116
	ld hl, Func_06_412f ; $4119
	push hl ; $411c
	ld a, [wGameMode] ; $411d
	cp a, $08 ; $4120
	jp z, ShowMinigameRulesPages ; $4122
	ld a, [$c8f5] ; $4125
	cp a, $02 ; $4128
	jp z, ShowTrainingRulesPages ; $412a
	jr ShowMatchRulesPages ; $412d
Func_06_412f:
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
MatchRulesPageLists:
	; $4165, 24 bytes (rules_pages:4)
	rules_pages_stride 4
	rules_pages $00, $06 ; list 0
	rules_pages $01, $07 ; list 1
	rules_pages $02, $06 ; list 2
	rules_pages $03, $07 ; list 3
	rules_pages $04, $06 ; list 4
	rules_pages $05, $07 ; list 5
ShowTrainingRulesPages:
	ld a, [wCurrentMinigameStoryMatch + 1] ; $417d
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
TrainingRulesPageLists:
	; $41a9, 116 bytes (rules_pages:4)
	rules_pages_stride 4
	rules_pages $00 ; list 0
	rules_pages $01 ; list 1
	rules_pages $02 ; list 2
	rules_pages $03 ; list 3
	rules_pages $04 ; list 4
	rules_pages $05 ; list 5
	rules_pages $06 ; list 6
	rules_pages $07 ; list 7
	rules_pages $08 ; list 8
	rules_pages $09 ; list 9
	rules_pages $0a ; list 10
	rules_pages $0b ; list 11
	rules_pages $0c, $1c ; list 12
	rules_pages $0d, $1c ; list 13
	rules_pages $0e, $1c ; list 14
	rules_pages $0f ; list 15
	rules_pages $10 ; list 16
	rules_pages $11 ; list 17
	rules_pages $12 ; list 18
	rules_pages $13 ; list 19
	rules_pages $14 ; list 20
	rules_pages $15 ; list 21
	rules_pages $16 ; list 22
	rules_pages $17 ; list 23
	rules_pages $18 ; list 24
	rules_pages $19 ; list 25
	rules_pages $1a ; list 26
	rules_pages $1b ; list 27
	rules_pages $1c ; list 28
ShowMinigameRulesPages:
	ld a, [wCurrentMinigameStoryMatch + 1] ; $421d
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
	ld a, [wCurrentMinigameStoryMatch + 1] ; $423a
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
MinigameRulesTextIdBases:
	; $4262, 18 bytes (records:2)
	dw $2c87 ; record 0
	dw $2c8d ; record 1
	dw $2c92 ; record 2
	dw $2c96 ; record 3
	dw $2c9f ; record 4
	dw $2ca2 ; record 5
	dw $2ca5 ; record 6
	dw $2cb1 ; record 7
	dw $2cbd ; record 8
MinigameRulesPageLists:
	; $4274, 162 bytes (rules_pages:6)
	rules_pages_stride 6
	rules_pages $00, $01 ; list 0
	rules_pages $02, $03 ; list 1
	rules_pages $04, $05 ; list 2
	rules_pages $00, $01 ; list 3
	rules_pages $02, $03 ; list 4
	rules_pages $04, $05 ; list 5
	rules_pages $00 ; list 6
	rules_pages $01 ; list 7
	rules_pages $02, $03 ; list 8
	rules_pages $00, $01, $02 ; list 9
	rules_pages $03, $04, $05 ; list 10
	rules_pages $06, $07, $08 ; list 11
	rules_pages $00 ; list 12
	rules_pages $01 ; list 13
	rules_pages $02 ; list 14
	rules_pages $00 ; list 15
	rules_pages $01 ; list 16
	rules_pages $02 ; list 17
	rules_pages $00, $01, $02, $03 ; list 18
	rules_pages $04, $05, $06, $07 ; list 19
	rules_pages $08, $09, $0a, $0b ; list 20
	rules_pages $00, $01, $02, $03 ; list 21
	rules_pages $04, $05, $06, $07 ; list 22
	rules_pages $08, $09, $0a, $0b ; list 23
	rules_pages $00, $01, $02 ; list 24
	rules_pages $03, $04, $05 ; list 25
	rules_pages $06, $07, $08 ; list 26
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
	farcall PrepareGlyphBuffer ; $432a
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
	farcall StepMatchFrame ; $4354
	farcall UploadGlyphBuffer ; $4357
	call FlushTilemapToVram ; $435a
Label_06_435d:
	farcall StepMatchFrame ; $435d
	farcall ReadMatchInputPressed ; $4360
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
	farcall AddBobbingOffsetY ; $4376
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
	farcall PrepareGlyphBuffer ; $4392
	ld de, $0103 ; $4395
	ld hl, $0157 ; $4398
	call DrawMenuTextLine ; $439b
	ld de, $060a ; $439e
	ld hl, $0158 ; $43a1
	call DrawMenuTextLine ; $43a4
	ld de, $010c ; $43a7
	ld hl, $0159 ; $43aa
	call DrawMenuTextLine ; $43ad
	farcall UploadGlyphBuffer ; $43b0
	call FlushTilemapToVram ; $43b3
	farcall StepMatchFrame ; $43b6
Label_06_43b9:
	farcall ReadMatchInputPressed ; $43b9
	and a, $03 ; $43bc
	jr nz, Label_06_43e8 ; $43be
	farcall ReadMatchInputPressed ; $43c0
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
	farcall StepMatchFrame ; $43e3
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
	ld hl, Func_06_4417 ; $440b
	push hl ; $440e
	ld a, [wMatchMenuSelection] ; $440f
	rst Rst00 ; $4412
	dw MatchPauseMenu_CameraSelect ; $4413 jumptable
	dw MatchPauseMenu_MusicToggle ; $4415 jumptable
Func_06_4417:
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
	farcall SetStorySlotFlagB ; $4436
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
	farcall SetStorySlotFlagA ; $445e
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
SaveQuitMenuIdByGameMode:
	; $44f3, 11 bytes (bytes:1)
	db $0d ; 0x00
	db $05 ; 0x01
	db $05 ; 0x02
	db $05 ; 0x03
	db $06 ; 0x04
	db $07 ; 0x05
	db $09 ; 0x06
	db $0a ; 0x07
	db $0b ; 0x08
	db $0c ; 0x09
	db $05 ; 0x0a
ShowMessageWindow:
	push af ; $44fe
	push bc ; $44ff
	push de ; $4500
	push hl ; $4501
	ldh a, [hWramBank] ; $4502
	push af ; $4504
	wram_bank $02 ; $4505
	ld a, $01 ; $450b
	ld [wMatchSimFrozen], a ; $450d
	farcall StepMatchFrame ; $4510
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
	farcall PrepareGlyphBuffer ; $4528
	push hl ; $452b
	inc d ; $452c
	inc e ; $452d
	call GetShadowTilemapAddr ; $452e
	ld c, b ; $4531
	dec c ; $4532
	dec c ; $4533
	pop hl ; $4534
	farcall RenderProportionalTextAt ; $4535
	farcall UploadGlyphBuffer ; $4538
	call FlushTilemapToVram ; $453b
	ld a, $1e ; $453e
	farcall StepMatchFrames ; $4540
Label_06_4543:
	farcall StepMatchFrame ; $4543
	farcall ReadMatchInputPressed ; $4546
	and a, $0f ; $4549
	jr z, Label_06_4543 ; $454b
	call RestoreBgTilemap ; $454d
	call FlushTilemapToVram ; $4550
	farcall StepMatchFrame ; $4553
	xor a, a ; $4556
	ld [wMatchSimFrozen], a ; $4557
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
	call RenderProportionalMenuText ; $457b
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
	call RenderProportionalMenuText ; $45a6
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
MatchMenuDefs:
	; $466f, 120 bytes (menu_def:MATCHMENUITEM)
	menu_def MATCHMENUITEM_RULES, MATCHMENUITEM_CONTROLS, MATCHMENUITEM_OPTIONS, MATCHMENUITEM_SAVE ; menu 0
	menu_def MATCHMENUITEM_RULES, MATCHMENUITEM_CONTROLS, MATCHMENUITEM_MUSIC, MATCHMENUITEM_SAVE ; menu 1
	menu_def MATCHMENUITEM_CAMERA_MODE, MATCHMENUITEM_MUSIC ; menu 2
	menu_def MATCHMENUITEM_CAMERA_NORMAL, MATCHMENUITEM_CAMERA_PLAYER ; menu 3
	menu_def MATCHMENUITEM_MUSIC_ON, MATCHMENUITEM_MUSIC_OFF ; menu 4
	menu_def MATCHMENUITEM_SAVE_GAME, MATCHMENUITEM_QUIT_GAME, MATCHMENUITEM_CANCEL ; menu 5
	menu_def MATCHMENUITEM_SAVE_GAME, MATCHMENUITEM_TO_MAIN_MENU, MATCHMENUITEM_CANCEL ; menu 6
	menu_def MATCHMENUITEM_RETRY_MINIGAME, MATCHMENUITEM_QUIT_MATCH, MATCHMENUITEM_CANCEL ; menu 7
	menu_def MATCHMENUITEM_RETRY_PRACTICE, MATCHMENUITEM_QUIT_PRACTICE, MATCHMENUITEM_CANCEL ; menu 8
	menu_def MATCHMENUITEM_RETRY_MACHINE, MATCHMENUITEM_QUIT_MACHINE, MATCHMENUITEM_CANCEL ; menu 9
	menu_def MATCHMENUITEM_RETRY_PRACTICE_ALT, MATCHMENUITEM_QUIT_PRACTICE_ALT, MATCHMENUITEM_CANCEL ; menu 10
	menu_def MATCHMENUITEM_RETRY_GAME, MATCHMENUITEM_TO_LEVEL_SELECT, MATCHMENUITEM_TO_MAIN_MENU, MATCHMENUITEM_CANCEL ; menu 11
	menu_def MATCHMENUITEM_TO_MAIN_MENU, MATCHMENUITEM_CANCEL ; menu 12
	menu_def MATCHMENUITEM_SAVE_GAME, MATCHMENUITEM_TO_MAIN_MENU, MATCHMENUITEM_CANCEL ; menu 13
	menu_def MATCHMENUITEM_RETRY_GAME, MATCHMENUITEM_TO_LEVEL_SELECT, MATCHMENUITEM_TO_MAIN_MENU ; menu 14
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
	farcall ReadMatchInputPressed ; $4701
	and a, $0a ; $4704
	jr z, Label_06_4711 ; $4706
	sound $62 ; $4708
	ld a, $ff ; $470a
	ld [wMatchMenuSelection], a ; $470c
	jr Label_06_4776 ; $470f
Label_06_4711:
	farcall ReadMatchInputPressed ; $4711
	and a, $01 ; $4714
	jr z, Label_06_471c ; $4716
	sound $5f ; $4718
	jr Label_06_4776 ; $471a
Label_06_471c:
	farcall ReadMatchInputRepeat ; $471c
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
	farcall PrepareGlyphBuffer ; $4733
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
	farcall UploadGlyphBuffer ; $4762
	farcall StepMatchFrame ; $4765
	call FlushTilemapToVram ; $4768
	farcall StepMatchFrame ; $476b
Label_06_476e:
	call DrawMatchMenuCursor ; $476e
	farcall StepMatchFrame ; $4771
	jr Label_06_4701 ; $4774
Label_06_4776:
	farcall StepMatchFrame ; $4776
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
MatchMenuItemPosPointers:
	; $4857, 10 bytes (records:2)
	dw MatchMenuItemPos2Items ; record 0
	dw MatchMenuItemPos2Items ; record 1
	dw MatchMenuItemPos2Items ; record 2
	dw MatchMenuItemPos3Items ; record 3
	dw MatchMenuItemPos4Items ; record 4
MatchMenuItemPos2Items:
	; $4861, 4 bytes (bytes:2)
	db $0a, $05 ; 0x00
	db $0a, $0b ; 0x02
MatchMenuItemPos3Items:
	; $4865, 6 bytes (bytes:2)
	db $0a, $04 ; 0x00
	db $0a, $08 ; 0x02
	db $0a, $0c ; 0x04
MatchMenuItemPos4Items:
	; $486b, 8 bytes (bytes:2)
	db $0a, $03 ; 0x00
	db $0a, $06 ; 0x02
	db $0a, $09 ; 0x04
	db $0a, $0c ; 0x06
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
MatchMenuCursorPosPointers:
	; $4891, 10 bytes (records:2)
	dw MatchMenuCursorPos2Items ; record 0
	dw MatchMenuCursorPos2Items ; record 1
	dw MatchMenuCursorPos2Items ; record 2
	dw MatchMenuCursorPos3Items ; record 3
	dw MatchMenuCursorPos4Items ; record 4
MatchMenuCursorPos2Items:
	; $489b, 4 bytes (bytes:2)
	db $60, $18 ; 0x00
	db $60, $48 ; 0x02
MatchMenuCursorPos3Items:
	; $489f, 6 bytes (bytes:2)
	db $60, $10 ; 0x00
	db $60, $30 ; 0x02
	db $60, $50 ; 0x04
MatchMenuCursorPos4Items:
	; $48a5, 8 bytes (bytes:2)
	db $60, $08 ; 0x00
	db $60, $20 ; 0x02
	db $60, $38 ; 0x04
	db $60, $50 ; 0x06
ShowMatchScoreboardScreen:
	ldh a, [hWramBank] ; $48ad
	push af ; $48af
	farcall StepMatchFrame ; $48b0
	call PrepareScoreboardGfx ; $48b3
	farcall StepMatchFrame ; $48b6
	ld a, $05 ; $48b9
	ld [$c4e3], a ; $48bb
	call LoadScoreboardModeGfx ; $48be
	ld b, $01 ; $48c1
	call DrawScoreboard ; $48c3
	farcall PrepareGlyphBuffer ; $48c6
	call DrawScoreboardCaption ; $48c9
	farcall UploadGlyphBuffer ; $48cc
	ld a, $0a ; $48cf
	ld hl, Func_06_506a ; $48d1
	call RegisterFrameTask ; $48d4
	ld a, $0a ; $48d7
	ld hl, Func_06_69c8 ; $48d9
	call RegisterFrameTask ; $48dc
	farcall StepMatchFrame ; $48df
	call FlushTilemapToVram ; $48e2
	farcall StepMatchFrame ; $48e5
	wram_bank $02 ; $48e8
Label_06_48ee:
	farcall ReadMatchInputPressed ; $48ee
	and a, $0f ; $48f1
	jr nz, Label_06_48fa ; $48f3
	farcall StepMatchFrame ; $48f5
	jr Label_06_48ee ; $48f8
Label_06_48fa:
	ld hl, Func_06_506a ; $48fa
	call UnregisterFrameTask ; $48fd
	ld hl, Func_06_69c8 ; $4900
	call UnregisterFrameTask ; $4903
	call RestoreBgTilemap ; $4906
	call FlushTilemapToVram ; $4909
	farcall StepMatchFrame ; $490c
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
	farcall ReloadCharFrameGfx ; $4949
Label_06_494c:
	wram_bank $07 ; $494c
	farcall ReloadCharFrameGfx ; $4952
Label_06_4955:
	wram_bank $05 ; $4955
	farcall ReloadCharFrameGfx ; $495b
Label_06_495e:
	wram_bank $04 ; $495e
	farcall ReloadCharFrameGfx ; $4964
	farcall StepMatchFrame ; $4967
	ld a, [$c8f5] ; $496a
	cp a, $02 ; $496d
	jr z, Label_06_49a0 ; $496f
	ld a, [wPlayer1GamesWon] ; $4971
	ld b, $01 ; $4974
	ld de, $8700 ; $4976
	farcall LoadScoreDigitGfx ; $4979
	ld a, [wPlayer1SetsWon] ; $497c
	ld b, $01 ; $497f
	ld de, $8680 ; $4981
	farcall LoadScoreDigitGfx ; $4984
	ld a, [wPlayer2GamesWon] ; $4987
	ld b, $01 ; $498a
	ld de, $8740 ; $498c
	farcall LoadScoreDigitGfx ; $498f
	ld a, [wPlayer2SetsWon] ; $4992
	ld b, $01 ; $4995
	ld de, $86c0 ; $4997
	farcall LoadScoreDigitGfx ; $499a
	farcall StepMatchFrame ; $499d
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
	ld hl, Func_06_4a2f ; $4a1e
	push hl ; $4a21
	ld a, c ; $4a22
	and a, $03 ; $4a23
	ld a, a ; $4a25
	rst Rst00 ; $4a26
	dw Label_00_03ae ; $4a27 jumptable
	dw DrawScoreboardPipFilled ; $4a29 jumptable
	dw DrawScoreboardPipAlt ; $4a2b jumptable
	dw DrawScoreboardPipAlt ; $4a2d jumptable
Func_06_4a2f:
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
	ld hl, ScoreboardPipFilledRect ; $4a6e
	call CopyTextRectPair ; $4a71
	ret ; $4a74
DrawScoreboardPipAlt:
	ld hl, ScoreboardPipAltRect ; $4a75
	call CopyTextRectPair ; $4a78
	ret ; $4a7b
DrawScoreboardPipEmpty:
	ld hl, ScoreboardPipEmptyRect ; $4a7c
	call CopyTextRectPair ; $4a7f
	ret ; $4a82
ScoreboardPipTilesFilled:
	; $4a83, 4 bytes (tilemap:2)
	tilemap_begin 2, 2
	tilemap_row $0a, $0b ; row 0
	tilemap_row $1a, $1b ; row 1
	tilemap_end
ScoreboardPipTilesAlt:
	; $4a87, 4 bytes (tilemap:2)
	tilemap_begin 2, 2
	tilemap_row $0c, $0d ; row 0
	tilemap_row $1c, $1d ; row 1
	tilemap_end
ScoreboardPipTilesEmpty:
	; $4a8b, 4 bytes (tilemap:2)
	tilemap_begin 2, 2
	tilemap_row $0e, $0f ; row 0
	tilemap_row $1e, $1f ; row 1
	tilemap_end
ScoreboardPipAttrsFilled:
	; $4a8f, 4 bytes (tilemap:2)
	tilemap_begin 2, 2
	tilemap_row $01, $01 ; row 0
	tilemap_row $01, $01 ; row 1
	tilemap_end
ScoreboardPipAttrsAlt:
	; $4a93, 4 bytes (tilemap:2)
	tilemap_begin 2, 2
	tilemap_row $01, $01 ; row 0
	tilemap_row $01, $01 ; row 1
	tilemap_end
ScoreboardPipAttrsEmpty:
	; $4a97, 4 bytes (tilemap:2)
	tilemap_begin 2, 2
	tilemap_row $01, $01 ; row 0
	tilemap_row $01, $01 ; row 1
	tilemap_end
ScoreboardPipFilledRect:
	; $4a9b, 6 bytes (rect_pair)
	rect_pair 2, 2, ScoreboardPipTilesFilled, ScoreboardPipAttrsFilled
ScoreboardPipAltRect:
	; $4aa1, 6 bytes (rect_pair)
	rect_pair 2, 2, ScoreboardPipTilesAlt, ScoreboardPipAttrsAlt
ScoreboardPipEmptyRect:
	; $4aa7, 6 bytes (rect_pair)
	rect_pair 2, 2, ScoreboardPipTilesEmpty, ScoreboardPipAttrsEmpty
ScoreboardTilemap0:
	; $4aad, 133 bytes (tilemap:19)
	tilemap_begin 19, 7
	tilemap_row $02, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $04 ; row 0
	tilemap_row $05, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $06 ; row 1
	tilemap_row $05, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $06 ; row 2
	tilemap_row $05, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $06 ; row 3
	tilemap_row $05, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $06 ; row 4
	tilemap_row $05, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $06 ; row 5
	tilemap_row $07, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $09 ; row 6
	tilemap_end
ScoreboardTilemap1:
	; $4b32, 95 bytes (tilemap:19)
	tilemap_begin 19, 5
	tilemap_row $02, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $04 ; row 0
	tilemap_row $05, $20, $20, $20, $20, $31, $20, $32, $20, $33, $20, $34, $20, $20, $20, $20, $20, $20, $06 ; row 1
	tilemap_row $05, $20, $20, $20, $20, $15, $15, $15, $15, $15, $15, $15, $15, $20, $15, $16, $16, $15, $06 ; row 2
	tilemap_row $05, $20, $20, $20, $20, $15, $15, $15, $15, $15, $15, $15, $15, $20, $15, $16, $16, $15, $06 ; row 3
	tilemap_row $07, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $09 ; row 4
	tilemap_end
ScoreboardTilemap2:
	; $4b91, 133 bytes (tilemap:19)
	tilemap_begin 19, 7
	tilemap_row $02, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $04 ; row 0
	tilemap_row $05, $20, $20, $20, $20, $31, $20, $32, $20, $33, $20, $34, $20, $20, $20, $20, $20, $20, $06 ; row 1
	tilemap_row $05, $20, $20, $20, $20, $15, $15, $15, $15, $15, $15, $15, $15, $20, $15, $16, $16, $15, $06 ; row 2
	tilemap_row $05, $20, $20, $20, $20, $15, $15, $15, $15, $15, $15, $15, $15, $20, $15, $16, $16, $15, $06 ; row 3
	tilemap_row $05, $20, $20, $20, $20, $15, $15, $15, $15, $15, $15, $15, $15, $20, $15, $16, $16, $15, $06 ; row 4
	tilemap_row $05, $20, $20, $20, $20, $15, $15, $15, $15, $15, $15, $15, $15, $20, $15, $16, $16, $15, $06 ; row 5
	tilemap_row $07, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $09 ; row 6
	tilemap_end
ScoreboardTilemap3:
	; $4c16, 133 bytes (tilemap:19)
	tilemap_begin 19, 7
	tilemap_row $02, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $04 ; row 0
	tilemap_row $05, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $06 ; row 1
	tilemap_row $05, $20, $20, $15, $15, $15, $15, $15, $15, $15, $15, $15, $15, $20, $15, $16, $16, $15, $06 ; row 2
	tilemap_row $05, $20, $20, $15, $15, $15, $15, $15, $15, $15, $15, $15, $15, $20, $15, $16, $16, $15, $06 ; row 3
	tilemap_row $05, $20, $20, $15, $15, $15, $15, $15, $15, $15, $15, $15, $15, $20, $15, $16, $16, $15, $06 ; row 4
	tilemap_row $05, $20, $20, $15, $15, $15, $15, $15, $15, $15, $15, $15, $15, $20, $15, $16, $16, $15, $06 ; row 5
	tilemap_row $07, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $09 ; row 6
	tilemap_end
ScoreboardTilemap4:
	; $4c9b, 98 bytes (tilemap:14)
	tilemap_begin 14, 7
	tilemap_row $02, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $04 ; row 0
	tilemap_row $05, $20, $20, $20, $20, $20, $20, $20, $20, $15, $16, $16, $15, $06 ; row 1
	tilemap_row $05, $20, $20, $20, $20, $20, $20, $20, $20, $15, $16, $16, $15, $06 ; row 2
	tilemap_row $05, $30, $30, $30, $30, $30, $30, $30, $30, $30, $30, $30, $30, $06 ; row 3
	tilemap_row $05, $20, $20, $20, $20, $20, $20, $20, $20, $15, $16, $16, $15, $06 ; row 4
	tilemap_row $05, $20, $20, $20, $20, $20, $20, $20, $20, $15, $16, $16, $15, $06 ; row 5
	tilemap_row $07, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $09 ; row 6
	tilemap_end
ScoreboardTilemap5:
	; $4cfd, 98 bytes (tilemap:14)
	tilemap_begin 14, 7
	tilemap_row $02, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $04 ; row 0
	tilemap_row $05, $20, $20, $20, $20, $20, $20, $20, $20, $15, $16, $16, $15, $06 ; row 1
	tilemap_row $05, $20, $20, $20, $20, $20, $20, $20, $20, $15, $16, $16, $15, $06 ; row 2
	tilemap_row $05, $30, $30, $30, $30, $30, $30, $30, $30, $30, $30, $30, $30, $06 ; row 3
	tilemap_row $05, $20, $20, $20, $20, $20, $20, $20, $20, $15, $16, $16, $15, $06 ; row 4
	tilemap_row $05, $20, $20, $20, $20, $20, $20, $20, $20, $15, $16, $16, $15, $06 ; row 5
	tilemap_row $07, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $09 ; row 6
	tilemap_end
ScoreboardAttrmap0:
	; $4d5f, 133 bytes (tilemap:19)
	tilemap_begin 19, 7
	tilemap_row $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; row 0
	tilemap_row $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; row 1
	tilemap_row $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; row 2
	tilemap_row $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; row 3
	tilemap_row $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; row 4
	tilemap_row $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; row 5
	tilemap_row $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; row 6
	tilemap_end
ScoreboardAttrmap1:
	; $4de4, 95 bytes (tilemap:19)
	tilemap_begin 19, 5
	tilemap_row $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; row 0
	tilemap_row $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; row 1
	tilemap_row $00, $00, $00, $00, $00, $01, $21, $01, $21, $01, $21, $01, $21, $00, $01, $01, $01, $21, $00 ; row 2
	tilemap_row $00, $00, $00, $00, $00, $41, $61, $41, $61, $41, $61, $41, $61, $00, $41, $41, $41, $61, $00 ; row 3
	tilemap_row $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; row 4
	tilemap_end
ScoreboardAttrmap2:
	; $4e43, 133 bytes (tilemap:19)
	tilemap_begin 19, 7
	tilemap_row $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; row 0
	tilemap_row $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; row 1
	tilemap_row $00, $00, $00, $00, $00, $01, $21, $01, $21, $01, $21, $01, $21, $00, $01, $01, $01, $21, $00 ; row 2
	tilemap_row $00, $00, $00, $00, $00, $41, $61, $41, $61, $41, $61, $41, $61, $00, $41, $41, $41, $61, $00 ; row 3
	tilemap_row $00, $00, $00, $00, $00, $01, $21, $01, $21, $01, $21, $01, $21, $00, $01, $01, $01, $21, $00 ; row 4
	tilemap_row $00, $00, $00, $00, $00, $41, $61, $41, $61, $41, $61, $41, $61, $00, $41, $41, $41, $61, $00 ; row 5
	tilemap_row $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; row 6
	tilemap_end
ScoreboardAttrmap3:
	; $4ec8, 133 bytes (tilemap:19)
	tilemap_begin 19, 7
	tilemap_row $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; row 0
	tilemap_row $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; row 1
	tilemap_row $00, $00, $00, $01, $21, $01, $21, $01, $21, $01, $21, $01, $21, $00, $01, $01, $01, $21, $00 ; row 2
	tilemap_row $00, $00, $00, $41, $61, $41, $61, $41, $61, $41, $61, $41, $61, $00, $41, $41, $41, $61, $00 ; row 3
	tilemap_row $00, $00, $00, $01, $21, $01, $21, $01, $21, $01, $21, $01, $21, $00, $01, $01, $01, $21, $00 ; row 4
	tilemap_row $00, $00, $00, $41, $61, $41, $61, $41, $61, $41, $61, $41, $61, $00, $41, $41, $41, $61, $00 ; row 5
	tilemap_row $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; row 6
	tilemap_end
ScoreboardAttrmap4:
	; $4f4d, 98 bytes (tilemap:14)
	tilemap_begin 14, 7
	tilemap_row $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; row 0
	tilemap_row $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $01, $01, $21, $00 ; row 1
	tilemap_row $00, $00, $00, $00, $00, $00, $00, $00, $00, $41, $41, $41, $61, $00 ; row 2
	tilemap_row $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; row 3
	tilemap_row $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $01, $01, $21, $00 ; row 4
	tilemap_row $00, $00, $00, $00, $00, $00, $00, $00, $00, $41, $41, $41, $61, $00 ; row 5
	tilemap_row $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; row 6
	tilemap_end
ScoreboardAttrmap5:
	; $4faf, 98 bytes (tilemap:14)
	tilemap_begin 14, 7
	tilemap_row $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; row 0
	tilemap_row $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $01, $01, $21, $00 ; row 1
	tilemap_row $00, $00, $00, $00, $00, $00, $00, $00, $00, $41, $41, $41, $61, $00 ; row 2
	tilemap_row $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; row 3
	tilemap_row $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $01, $01, $21, $00 ; row 4
	tilemap_row $00, $00, $00, $00, $00, $00, $00, $00, $00, $41, $41, $41, $61, $00 ; row 5
	tilemap_row $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; row 6
	tilemap_end
ScoreboardTilemapDesc0:
	; $5011, 6 bytes (rect_pair)
	rect_pair 7, 19, ScoreboardTilemap0, ScoreboardAttrmap0
ScoreboardTilemapDesc1:
	; $5017, 6 bytes (rect_pair)
	rect_pair 5, 19, ScoreboardTilemap1, ScoreboardAttrmap1
ScoreboardTilemapDesc2:
	; $501d, 6 bytes (rect_pair)
	rect_pair 7, 19, ScoreboardTilemap2, ScoreboardAttrmap2
ScoreboardTilemapDesc3:
	; $5023, 6 bytes (rect_pair)
	rect_pair 7, 19, ScoreboardTilemap3, ScoreboardAttrmap3
ScoreboardTilemapDesc4:
	; $5029, 6 bytes (rect_pair)
	rect_pair 7, 14, ScoreboardTilemap4, ScoreboardAttrmap4
ScoreboardTilemapDesc5:
	; $502f, 6 bytes (rect_pair)
	rect_pair 7, 14, ScoreboardTilemap5, ScoreboardAttrmap5
ScoreboardTilemapPointers:
	; $5035, 16 bytes (records:2)
	dw ScoreboardTilemapDesc0 ; record 0
	dw ScoreboardTilemapDesc0 ; record 1
	dw ScoreboardTilemapDesc0 ; record 2
	dw ScoreboardTilemapDesc1 ; record 3
	dw ScoreboardTilemapDesc2 ; record 4
	dw ScoreboardTilemapDesc3 ; record 5
	dw ScoreboardTilemapDesc4 ; record 6
	dw ScoreboardTilemapDesc5 ; record 7
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
ScoreboardSpriteTemplatePointers:
	; $509c, 16 bytes (records:2)
	dw SpriteTemplate_06_50e2 ; record 0
	dw SpriteTemplate_06_5123 ; record 1
	dw SpriteTemplate_06_516c ; record 2
	dw SpriteTemplate_06_51ff ; record 3
	dw SpriteTemplate_06_51bd ; record 4
	dw SpriteTemplate_06_51de ; record 5
	dw SpriteTemplate_06_5210 ; record 6
	dw SpriteTemplate_06_5210 ; record 7
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
	farcall DrawNumberWithSprites ; $50c0
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
	farcall DrawNumberWithSprites ; $50de
	ret ; $50e1
SpriteTemplate_06_50e2:
	; $50e2, 65 bytes (sprite_template)
	oam_sprite $20, $18, $00, $04
	oam_sprite $20, $20, $02, $04
	oam_sprite $20, $40, $68, $01
	oam_sprite $20, $48, $6a, $01
	oam_sprite $20, $60, $70, $01
	oam_sprite $20, $68, $72, $01
	oam_sprite $20, $80, $78, $01
	oam_sprite $20, $88, $7a, $01
	oam_sprite $30, $18, $08, $05
	oam_sprite $30, $20, $0a, $05
	oam_sprite $30, $40, $6c, $01
	oam_sprite $30, $48, $6e, $01
	oam_sprite $30, $60, $74, $01
	oam_sprite $30, $68, $76, $01
	oam_sprite $30, $80, $7c, $01
	oam_sprite $30, $88, $7e, $01
	oam_sprite_end
SpriteTemplate_06_5123:
	; $5123, 73 bytes (sprite_template)
	oam_sprite $20, $18, $00, $04
	oam_sprite $20, $20, $02, $04
	oam_sprite $20, $40, $68, $01
	oam_sprite $20, $48, $6a, $01
	oam_sprite $20, $60, $70, $01
	oam_sprite $20, $68, $72, $01
	oam_sprite $20, $80, $78, $01
	oam_sprite $20, $88, $7a, $01
	oam_sprite $30, $10, $08, $05
	oam_sprite $30, $18, $0a, $05
	oam_sprite $30, $20, $18, $07
	oam_sprite $30, $28, $1a, $07
	oam_sprite $30, $40, $6c, $01
	oam_sprite $30, $48, $6e, $01
	oam_sprite $30, $60, $74, $01
	oam_sprite $30, $68, $76, $01
	oam_sprite $30, $80, $7c, $01
	oam_sprite $30, $88, $7e, $01
	oam_sprite_end
SpriteTemplate_06_516c:
	; $516c, 81 bytes (sprite_template)
	oam_sprite $20, $10, $00, $04
	oam_sprite $20, $18, $02, $04
	oam_sprite $20, $20, $10, $06
	oam_sprite $20, $28, $12, $06
	oam_sprite $20, $40, $68, $01
	oam_sprite $20, $48, $6a, $01
	oam_sprite $20, $60, $70, $01
	oam_sprite $20, $68, $72, $01
	oam_sprite $20, $80, $78, $01
	oam_sprite $20, $88, $7a, $01
	oam_sprite $30, $10, $08, $05
	oam_sprite $30, $18, $0a, $05
	oam_sprite $30, $20, $18, $07
	oam_sprite $30, $28, $1a, $07
	oam_sprite $30, $40, $6c, $01
	oam_sprite $30, $48, $6e, $01
	oam_sprite $30, $60, $74, $01
	oam_sprite $30, $68, $76, $01
	oam_sprite $30, $80, $7c, $01
	oam_sprite $30, $88, $7e, $01
	oam_sprite_end
SpriteTemplate_06_51bd:
	; $51bd, 33 bytes (sprite_template)
	oam_sprite $20, $18, $00, $04
	oam_sprite $20, $20, $02, $04
	oam_sprite $20, $80, $78, $01
	oam_sprite $20, $88, $7a, $01
	oam_sprite $30, $18, $08, $05
	oam_sprite $30, $20, $0a, $05
	oam_sprite $30, $80, $7c, $01
	oam_sprite $30, $88, $7e, $01
	oam_sprite_end
SpriteTemplate_06_51de:
	; $51de, 33 bytes (sprite_template)
	oam_sprite $20, $0e, $00, $04
	oam_sprite $20, $16, $02, $04
	oam_sprite $20, $80, $78, $01
	oam_sprite $20, $88, $7a, $01
	oam_sprite $30, $0e, $08, $05
	oam_sprite $30, $16, $0a, $05
	oam_sprite $30, $80, $7c, $01
	oam_sprite $30, $88, $7e, $01
	oam_sprite_end
SpriteTemplate_06_51ff:
	; $51ff, 17 bytes (sprite_template)
	oam_sprite $20, $18, $00, $04
	oam_sprite $20, $20, $02, $04
	oam_sprite $20, $80, $78, $01
	oam_sprite $20, $88, $7a, $01
	oam_sprite_end
SpriteTemplate_06_5210:
	; $5210, 9 bytes (sprite_template)
	oam_sprite $18, $14, $00, $04
	oam_sprite $18, $1c, $02, $04
	oam_sprite_end
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
MatchMenuItemGfxPointers:
	; $5244, 48 bytes (records:2)
	dw MatchMenuItemGfx_Rules ; record 0
	dw MatchMenuItemGfx_Controls ; record 1
	dw MatchMenuItemGfx_Options ; record 2
	dw MatchMenuItemGfx_Save ; record 3
	dw MatchMenuItemGfx_CameraMode ; record 4
	dw MatchMenuItemGfx_Music ; record 5
	dw MatchMenuItemGfx_Normal ; record 6
	dw MatchMenuItemGfx_Player ; record 7
	dw MatchMenuItemGfx_On ; record 8
	dw MatchMenuItemGfx_Off ; record 9
	dw MatchMenuItemGfx_Cancel ; record 10
	dw MatchMenuItemGfx_SaveNarrow ; record 11
	dw MatchMenuItemGfx_ToMainMenu ; record 12
	dw MatchMenuItemGfx_ToLevelSelect ; record 13
	dw MatchMenuItemGfx_TryAgain ; record 14
	dw MatchMenuItemGfx_TryAgain ; record 15
	dw MatchMenuItemGfx_TryAgain ; record 16
	dw MatchMenuItemGfx_TryAgain ; record 17
	dw MatchMenuItemGfx_TryAgain ; record 18
	dw MatchMenuItemGfx_QuitMatch ; record 19
	dw MatchMenuItemGfx_QuitMinigame ; record 20
	dw MatchMenuItemGfx_QuitMinigame ; record 21
	dw MatchMenuItemGfx_QuitMinigame ; record 22
	dw MatchMenuItemGfx_QuitMinigame ; record 23
	; $5274, 12 bytes (bytes:12)
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; 0x00
ScoreboardModeGfxTail:
	INCBIN "data/bank_006/d_5280.bin" ; $5280, 64 bytes
MatchMenuItemGfx_Rules:
	INCBIN "data/bank_006/d_52c0.bin" ; $52c0, 130 bytes
MatchMenuItemGfx_Controls:
	INCBIN "data/bank_006/d_5342.bin" ; $5342, 192 bytes
MatchMenuItemGfx_Options:
	INCBIN "data/bank_006/d_5402.bin" ; $5402, 147 bytes
MatchMenuItemGfx_Save:
	INCBIN "data/bank_006/d_5495.bin" ; $5495, 132 bytes
MatchMenuItemGfx_CameraMode:
	INCBIN "data/bank_006/d_5519.bin" ; $5519, 172 bytes
MatchMenuItemGfx_Music:
	INCBIN "data/bank_006/d_55c5.bin" ; $55c5, 131 bytes
MatchMenuItemGfx_Normal:
	INCBIN "data/bank_006/d_5648.bin" ; $5648, 121 bytes
MatchMenuItemGfx_Player:
	INCBIN "data/bank_006/d_56c1.bin" ; $56c1, 132 bytes
MatchMenuItemGfx_On:
	INCBIN "data/bank_006/d_5745.bin" ; $5745, 124 bytes
MatchMenuItemGfx_Off:
	INCBIN "data/bank_006/d_57c1.bin" ; $57c1, 131 bytes
MatchMenuItemGfx_Cancel:
	INCBIN "data/bank_006/d_5844.bin" ; $5844, 129 bytes
MatchMenuItemGfx_SaveNarrow:
	INCBIN "data/bank_006/d_58c5.bin" ; $58c5, 115 bytes
MatchMenuItemGfx_ToMainMenu:
	INCBIN "data/bank_006/d_5938.bin" ; $5938, 176 bytes
MatchMenuItemGfx_ToLevelSelect:
	INCBIN "data/bank_006/d_59e8.bin" ; $59e8, 178 bytes
MatchMenuItemGfx_TryAgain:
	INCBIN "data/bank_006/d_5a9a.bin" ; $5a9a, 155 bytes
MatchMenuItemGfx_QuitMatch:
	INCBIN "data/bank_006/d_5b35.bin" ; $5b35, 165 bytes
MatchMenuItemGfx_QuitMinigame:
	INCBIN "data/bank_006/d_5bda.bin" ; $5bda, 176 bytes
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
	ld a, [wCurrentMinigameStoryMatch + 1] ; $5c9b
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
ScoreboardModeGfxPointers:
	; $5cc9, 22 bytes (records:2)
	dw ScoreboardModeGfx_RankingMatch ; record 0
	dw ScoreboardModeGfx_RankingMatch ; record 1
	dw ScoreboardModeGfx_IslandOpen ; record 2
	dw ScoreboardModeGfx_PracticeMatch ; record 3
	dw ScoreboardModeGfx_Exhibition ; record 4
	dw ScoreboardModeGfx_MiniGames ; record 5
	dw ScoreboardModeGfx_TennisMachine ; record 6
	dw ScoreboardModeGfx_WallPractice ; record 7
	dw ScoreboardModeGfx_MarioMiniGames ; record 8
	dw ScoreboardModeGfx_LinkedMatch ; record 9
	dw ScoreboardModeGfx_Exhibition ; record 10
ScoreboardMinigameGfxPointers:
	; $5cdf, 84 bytes (records:2)
	dw ScoreboardModeGfx_ServiceMatch ; record 0
	dw ScoreboardModeGfx_ServiceMatch ; record 1
	dw ScoreboardModeGfx_ServiceMatch ; record 2
	dw ScoreboardModeGfx_ServicePractice ; record 3
	dw ScoreboardModeGfx_ServicePractice ; record 4
	dw ScoreboardModeGfx_ServicePractice ; record 5
	dw ScoreboardModeGfx_NetPlayMatch ; record 6
	dw ScoreboardModeGfx_NetPlayMatch ; record 7
	dw ScoreboardModeGfx_NetPlayMatch ; record 8
	dw ScoreboardModeGfx_NetPlayPractice ; record 9
	dw ScoreboardModeGfx_NetPlayPractice ; record 10
	dw ScoreboardModeGfx_NetPlayPractice ; record 11
	dw ScoreboardModeGfx_StrokeMatch ; record 12
	dw ScoreboardModeGfx_StrokeMatch ; record 13
	dw ScoreboardModeGfx_StrokeMatch ; record 14
	dw ScoreboardModeGfx_StrokePractice ; record 15
	dw ScoreboardModeGfx_StrokePractice ; record 16
	dw ScoreboardModeGfx_StrokePractice ; record 17
	dw ScoreboardModeGfx_MarioMiniGames ; record 18
	dw ScoreboardModeGfx_MarioMiniGames ; record 19
	dw ScoreboardModeGfx_MarioMiniGames ; record 20
	dw ScoreboardModeGfx_MarioMiniGames ; record 21
	dw ScoreboardModeGfx_MarioMiniGames ; record 22
	dw ScoreboardModeGfx_MarioMiniGames ; record 23
	dw ScoreboardModeGfx_MarioMiniGames ; record 24
	dw ScoreboardModeGfx_MarioMiniGames ; record 25
	dw ScoreboardModeGfx_MarioMiniGames ; record 26
	dw ScoreboardModeGfx_MarioMiniGames ; record 27
	dw ScoreboardModeGfx_MarioMiniGames ; record 28
	dw ScoreboardModeGfx_MarioMiniGames ; record 29
	dw ScoreboardModeGfx_MarioMiniGames ; record 30
	dw ScoreboardModeGfx_MarioMiniGames ; record 31
	dw ScoreboardModeGfx_MarioMiniGames ; record 32
	dw ScoreboardModeGfx_MarioMiniGames ; record 33
	dw ScoreboardModeGfx_MarioMiniGames ; record 34
	dw ScoreboardModeGfx_MarioMiniGames ; record 35
	dw ScoreboardModeGfx_MarioMiniGames ; record 36
	dw ScoreboardModeGfx_MarioMiniGames ; record 37
	dw ScoreboardModeGfx_MarioMiniGames ; record 38
	dw ScoreboardModeGfx_MarioMiniGames ; record 39
	dw ScoreboardModeGfx_MarioMiniGames ; record 40
	dw ScoreboardModeGfx_MarioMiniGames ; record 41
	; $5d33, 13 bytes (bytes:13)
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; 0x00
ScoreboardModeGfx_RankingMatch:
	INCBIN "data/bank_006/d_5d40.bin" ; $5d40, 181 bytes
ScoreboardModeGfx_IslandOpen:
	INCBIN "data/bank_006/d_5df5.bin" ; $5df5, 188 bytes
ScoreboardModeGfx_PracticeMatch:
	INCBIN "data/bank_006/d_5eb1.bin" ; $5eb1, 197 bytes
ScoreboardModeGfx_Exhibition:
	INCBIN "data/bank_006/d_5f76.bin" ; $5f76, 129 bytes
ScoreboardModeGfx_MiniGames:
	INCBIN "data/bank_006/d_5ff7.bin" ; $5ff7, 148 bytes
ScoreboardModeGfx_TennisMachine:
	INCBIN "data/bank_006/d_608b.bin" ; $608b, 179 bytes
ScoreboardModeGfx_WallPractice:
	INCBIN "data/bank_006/d_613e.bin" ; $613e, 184 bytes
ScoreboardModeGfx_MarioMiniGames:
	INCBIN "data/bank_006/d_61f6.bin" ; $61f6, 197 bytes
ScoreboardModeGfx_LinkedMatch:
	INCBIN "data/bank_006/d_62bb.bin" ; $62bb, 170 bytes
ScoreboardModeGfx_ServiceMatch:
	INCBIN "data/bank_006/d_6365.bin" ; $6365, 173 bytes
ScoreboardModeGfx_ServicePractice:
	INCBIN "data/bank_006/d_6412.bin" ; $6412, 202 bytes
ScoreboardModeGfx_NetPlayMatch:
	INCBIN "data/bank_006/d_64dc.bin" ; $64dc, 211 bytes
ScoreboardModeGfx_NetPlayPractice:
	INCBIN "data/bank_006/d_65af.bin" ; $65af, 216 bytes
ScoreboardModeGfx_StrokeMatch:
	INCBIN "data/bank_006/d_6687.bin" ; $6687, 173 bytes
ScoreboardModeGfx_StrokePractice:
	INCBIN "data/bank_006/d_6734.bin" ; $6734, 206 bytes
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
MatchMenuItemRectPointers:
	; $6835, 96 bytes (rect_ptrs)
	rect_ptrs MatchMenuItemRect_Rules, MatchMenuItemAttr_Rules ; item 0
	rect_ptrs MatchMenuItemRect_Controls, MatchMenuItemAttr_Controls ; item 1
	rect_ptrs MatchMenuItemRect_Options, MatchMenuItemAttr_Options ; item 2
	rect_ptrs MatchMenuItemRect_Save, MatchMenuItemAttr_Save ; item 3
	rect_ptrs MatchMenuItemRect_CameraMode, MatchMenuItemAttr_CameraMode ; item 4
	rect_ptrs MatchMenuItemRect_Music, MatchMenuItemAttr_Music ; item 5
	rect_ptrs MatchMenuItemRect_Normal, MatchMenuItemAttr_Normal ; item 6
	rect_ptrs MatchMenuItemRect_Player, MatchMenuItemAttr_Player ; item 7
	rect_ptrs MatchMenuItemRect_On, MatchMenuItemAttr_On ; item 8
	rect_ptrs MatchMenuItemRect_Off, MatchMenuItemAttr_Off ; item 9
	rect_ptrs MatchMenuItemRect_Cancel, MatchMenuItemAttr_Cancel ; item 10
	rect_ptrs MatchMenuItemRect_SaveNarrow, MatchMenuItemAttr_SaveNarrow ; item 11
	rect_ptrs MatchMenuItemRect_ToMainMenu, MatchMenuItemAttr_ToMainMenu ; item 12
	rect_ptrs MatchMenuItemRect_ToLevelSelect, MatchMenuItemAttr_ToLevelSelect ; item 13
	rect_ptrs MatchMenuItemRect_TryAgain, MatchMenuItemAttr_TryAgain ; item 14
	rect_ptrs MatchMenuItemRect_TryAgain, MatchMenuItemAttr_TryAgain ; item 15
	rect_ptrs MatchMenuItemRect_TryAgain, MatchMenuItemAttr_TryAgain ; item 16
	rect_ptrs MatchMenuItemRect_TryAgain, MatchMenuItemAttr_TryAgain ; item 17
	rect_ptrs MatchMenuItemRect_TryAgain, MatchMenuItemAttr_TryAgain ; item 18
	rect_ptrs MatchMenuItemRect_Quit, MatchMenuItemAttr_Quit ; item 19
	rect_ptrs MatchMenuItemRect_Quit, MatchMenuItemAttr_Quit ; item 20
	rect_ptrs MatchMenuItemRect_Quit, MatchMenuItemAttr_Quit ; item 21
	rect_ptrs MatchMenuItemRect_Quit, MatchMenuItemAttr_Quit ; item 22
	rect_ptrs MatchMenuItemRect_Quit, MatchMenuItemAttr_Quit ; item 23
MatchMenuItemRect_Rules:
	; $6895, 6 bytes (tilemap:3)
	tilemap_begin 3, 2
	tilemap_row $44, $45, $46 ; row 0
	tilemap_row $54, $55, $56 ; row 1
	tilemap_end
MatchMenuItemRect_Controls:
	; $689b, 6 bytes (tilemap:3)
	tilemap_begin 3, 2
	tilemap_row $47, $48, $49 ; row 0
	tilemap_row $57, $58, $59 ; row 1
	tilemap_end
MatchMenuItemRect_Options:
	; $68a1, 6 bytes (tilemap:3)
	tilemap_begin 3, 2
	tilemap_row $40, $41, $40 ; row 0
	tilemap_row $50, $51, $50 ; row 1
	tilemap_end
MatchMenuItemRect_Save:
	; $68a7, 6 bytes (tilemap:3)
	tilemap_begin 3, 2
	tilemap_row $67, $68, $69 ; row 0
	tilemap_row $77, $78, $79 ; row 1
	tilemap_end
MatchMenuItemRect_CameraMode:
	; $68ad, 6 bytes (tilemap:3)
	tilemap_begin 3, 2
	tilemap_row $2a, $2b, $2c ; row 0
	tilemap_row $3a, $3b, $3c ; row 1
	tilemap_end
MatchMenuItemRect_Music:
	; $68b3, 6 bytes (tilemap:3)
	tilemap_begin 3, 2
	tilemap_row $2d, $2e, $2f ; row 0
	tilemap_row $3d, $3e, $3f ; row 1
	tilemap_end
MatchMenuItemRect_Normal:
	; $68b9, 6 bytes (tilemap:3)
	tilemap_begin 3, 2
	tilemap_row $17, $18, $29 ; row 0
	tilemap_row $37, $38, $39 ; row 1
	tilemap_end
MatchMenuItemRect_Player:
	; $68bf, 6 bytes (tilemap:3)
	tilemap_begin 3, 2
	tilemap_row $27, $28, $29 ; row 0
	tilemap_row $37, $38, $39 ; row 1
	tilemap_end
MatchMenuItemRect_On:
	; $68c5, 6 bytes (tilemap:3)
	tilemap_begin 3, 2
	tilemap_row $60, $61, $60 ; row 0
	tilemap_row $70, $71, $70 ; row 1
	tilemap_end
MatchMenuItemRect_Off:
	; $68cb, 6 bytes (tilemap:3)
	tilemap_begin 3, 2
	tilemap_row $62, $63, $62 ; row 0
	tilemap_row $72, $73, $72 ; row 1
	tilemap_end
MatchMenuItemRect_Cancel:
	; $68d1, 6 bytes (tilemap:3)
	tilemap_begin 3, 2
	tilemap_row $6d, $6e, $6f ; row 0
	tilemap_row $7d, $7e, $7f ; row 1
	tilemap_end
MatchMenuItemRect_SaveNarrow:
	; $68d7, 6 bytes (tilemap:3)
	tilemap_begin 3, 2
	tilemap_row $46, $42, $43 ; row 0
	tilemap_row $56, $52, $53 ; row 1
	tilemap_end
MatchMenuItemRect_ToMainMenu:
	; $68dd, 6 bytes (tilemap:3)
	tilemap_begin 3, 2
	tilemap_row $4a, $4b, $4c ; row 0
	tilemap_row $5a, $5b, $5c ; row 1
	tilemap_end
MatchMenuItemRect_ToLevelSelect:
	; $68e3, 6 bytes (tilemap:3)
	tilemap_begin 3, 2
	tilemap_row $4d, $4e, $4f ; row 0
	tilemap_row $5d, $5e, $5f ; row 1
	tilemap_end
MatchMenuItemRect_TryAgain:
	; $68e9, 6 bytes (tilemap:3)
	tilemap_begin 3, 2
	tilemap_row $6a, $6b, $6c ; row 0
	tilemap_row $7a, $7b, $7c ; row 1
	tilemap_end
MatchMenuItemRect_Quit:
	; $68ef, 6 bytes (tilemap:3)
	tilemap_begin 3, 2
	tilemap_row $64, $65, $66 ; row 0
	tilemap_row $74, $75, $76 ; row 1
	tilemap_end
MatchMenuItemAttr_Rules:
	; $68f5, 6 bytes (tilemap:3)
	tilemap_begin 3, 2
	tilemap_row $00, $00, $00 ; row 0
	tilemap_row $00, $00, $00 ; row 1
	tilemap_end
MatchMenuItemAttr_Controls:
	; $68fb, 6 bytes (tilemap:3)
	tilemap_begin 3, 2
	tilemap_row $00, $00, $00 ; row 0
	tilemap_row $00, $00, $00 ; row 1
	tilemap_end
MatchMenuItemAttr_Options:
	; $6901, 6 bytes (tilemap:3)
	tilemap_begin 3, 2
	tilemap_row $00, $00, $20 ; row 0
	tilemap_row $00, $00, $20 ; row 1
	tilemap_end
MatchMenuItemAttr_Save:
	; $6907, 6 bytes (tilemap:3)
	tilemap_begin 3, 2
	tilemap_row $00, $00, $00 ; row 0
	tilemap_row $00, $00, $00 ; row 1
	tilemap_end
MatchMenuItemAttr_CameraMode:
	; $690d, 6 bytes (tilemap:3)
	tilemap_begin 3, 2
	tilemap_row $00, $00, $00 ; row 0
	tilemap_row $00, $00, $00 ; row 1
	tilemap_end
MatchMenuItemAttr_Music:
	; $6913, 6 bytes (tilemap:3)
	tilemap_begin 3, 2
	tilemap_row $00, $00, $00 ; row 0
	tilemap_row $00, $00, $00 ; row 1
	tilemap_end
MatchMenuItemAttr_Normal:
	; $6919, 6 bytes (tilemap:3)
	tilemap_begin 3, 2
	tilemap_row $00, $00, $00 ; row 0
	tilemap_row $00, $00, $00 ; row 1
	tilemap_end
MatchMenuItemAttr_Player:
	; $691f, 6 bytes (tilemap:3)
	tilemap_begin 3, 2
	tilemap_row $00, $00, $00 ; row 0
	tilemap_row $00, $00, $00 ; row 1
	tilemap_end
MatchMenuItemAttr_On:
	; $6925, 6 bytes (tilemap:3)
	tilemap_begin 3, 2
	tilemap_row $00, $00, $20 ; row 0
	tilemap_row $00, $00, $20 ; row 1
	tilemap_end
MatchMenuItemAttr_Off:
	; $692b, 6 bytes (tilemap:3)
	tilemap_begin 3, 2
	tilemap_row $00, $00, $20 ; row 0
	tilemap_row $00, $00, $20 ; row 1
	tilemap_end
MatchMenuItemAttr_Cancel:
	; $6931, 6 bytes (tilemap:3)
	tilemap_begin 3, 2
	tilemap_row $00, $00, $00 ; row 0
	tilemap_row $00, $00, $00 ; row 1
	tilemap_end
MatchMenuItemAttr_SaveNarrow:
	; $6937, 6 bytes (tilemap:3)
	tilemap_begin 3, 2
	tilemap_row $20, $00, $00 ; row 0
	tilemap_row $20, $00, $00 ; row 1
	tilemap_end
MatchMenuItemAttr_ToMainMenu:
	; $693d, 6 bytes (tilemap:3)
	tilemap_begin 3, 2
	tilemap_row $00, $00, $00 ; row 0
	tilemap_row $00, $00, $00 ; row 1
	tilemap_end
MatchMenuItemAttr_ToLevelSelect:
	; $6943, 6 bytes (tilemap:3)
	tilemap_begin 3, 2
	tilemap_row $00, $00, $00 ; row 0
	tilemap_row $00, $00, $00 ; row 1
	tilemap_end
MatchMenuItemAttr_TryAgain:
	; $6949, 6 bytes (tilemap:3)
	tilemap_begin 3, 2
	tilemap_row $00, $00, $00 ; row 0
	tilemap_row $00, $00, $00 ; row 1
	tilemap_end
MatchMenuItemAttr_Quit:
	; $694f, 6 bytes (tilemap:3)
	tilemap_begin 3, 2
	tilemap_row $00, $00, $00 ; row 0
	tilemap_row $00, $00, $00 ; row 1
	tilemap_end
MenuItemAttrRect3x2:
	; $6955, 6 bytes (tilemap:3)
	tilemap_begin 3, 2
	tilemap_row $00, $00, $00 ; row 0
	tilemap_row $00, $00, $00 ; row 1
	tilemap_end
TextRect_06_695b:
	; $695b, 24 bytes (tilemap:12)
	tilemap_begin 12, 2
	tilemap_row $49, $4a, $4b, $14, $15, $16, $17, $18, $19, $1a, $1b, $1c ; row 0
	tilemap_row $59, $5a, $5b, $24, $25, $26, $27, $28, $29, $2a, $2b, $2c ; row 1
	tilemap_end
TextRectAttrs_06_6973:
	; $6973, 24 bytes (tilemap:12)
	tilemap_begin 12, 2
	tilemap_row $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; row 0
	tilemap_row $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; row 1
	tilemap_end
Func_06_698b:
	ld de, $030a ; $698b
	call GetShadowTilemapAddr ; $698e
	ld hl, TextRect_06_695b ; $6991
	ld bc, $0c02 ; $6994
	call CopyTextRect ; $6997
	ld de, $030a ; $699a
	call GetShadowAttrmapAddr ; $699d
	ld hl, TextRectAttrs_06_6973 ; $69a0
	ld bc, $0c02 ; $69a3
	call CopyTextRect ; $69a6
	ld a, [$c4c8] ; $69a9
	and a, a ; $69ac
	ret z ; $69ad
	ld a, $05 ; $69ae
	ld de, $090a ; $69b0
	call DrawMatchMenuItem ; $69b3
	ret ; $69b6
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
	farcall AddBobbingOffsetYLarge ; $69d7
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
DebugStatNamePointers:
	; $6a39, 30 bytes (records:2)
	dw DebugStatName_Speed ; record 0
	dw DebugStatName_Add ; record 1
	dw DebugStatName_Brake ; record 2
	dw DebugStatName_Turn ; record 3
	dw DebugStatName_Angle ; record 4
	dw DebugStatName_Place ; record 5
	dw DebugStatName_Stroke ; record 6
	dw DebugStatName_Serve ; record 7
	dw DebugStatName_Volley ; record 8
	dw DebugStatName_Top ; record 9
	dw DebugStatName_Slice ; record 10
	dw DebugStatName_High ; record 11
	dw DebugStatName_Reach ; record 12
	dw DebugStatName_Jump ; record 13
	dw DebugStatName_Dive ; record 14
DebugStatName_Speed:
	INCLUDE "data/bank_006/text_6a57.asm" ; $6a57, 7 bytes
DebugStatName_Add:
	INCLUDE "data/bank_006/text_6a5e.asm" ; $6a5e, 5 bytes
DebugStatName_Brake:
	INCLUDE "data/bank_006/text_6a63.asm" ; $6a63, 7 bytes
DebugStatName_Turn:
	INCLUDE "data/bank_006/text_6a6a.asm" ; $6a6a, 6 bytes
DebugStatName_Angle:
	INCLUDE "data/bank_006/text_6a70.asm" ; $6a70, 7 bytes
DebugStatName_Place:
	INCLUDE "data/bank_006/text_6a77.asm" ; $6a77, 7 bytes
DebugStatName_Stroke:
	INCLUDE "data/bank_006/text_6a7e.asm" ; $6a7e, 8 bytes
DebugStatName_Serve:
	INCLUDE "data/bank_006/text_6a86.asm" ; $6a86, 7 bytes
DebugStatName_Volley:
	INCLUDE "data/bank_006/text_6a8d.asm" ; $6a8d, 8 bytes
DebugStatName_Top:
	INCLUDE "data/bank_006/text_6a95.asm" ; $6a95, 5 bytes
DebugStatName_Slice:
	INCLUDE "data/bank_006/text_6a9a.asm" ; $6a9a, 7 bytes
DebugStatName_High:
	INCLUDE "data/bank_006/text_6aa1.asm" ; $6aa1, 6 bytes
DebugStatName_Reach:
	INCLUDE "data/bank_006/text_6aa7.asm" ; $6aa7, 7 bytes
DebugStatName_Jump:
	INCLUDE "data/bank_006/text_6aae.asm" ; $6aae, 6 bytes
DebugStatName_Dive:
	INCLUDE "data/bank_006/text_6ab4.asm" ; $6ab4, 6 bytes
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
	farcall StepMatchFrame ; $6b87
	farcall Func_01_50d6 ; $6b8a
	wram_bank $04 ; $6b8d
	ld hl, wCharPosX ; $6b93
	ld de, $c700 ; $6b96
	ld c, $08 ; $6b99
	call CopyMemoryFast ; $6b9b
	wram_bank $02 ; $6b9e
	farcall StepMatchFrame ; $6ba4
	xor a, a ; $6ba7
	ld [wMatchMenuSelection], a ; $6ba8
	call DrawDebugStatsLabels ; $6bab
	call DrawDebugStatsValues ; $6bae
	call FlushTilemapToVram ; $6bb1
	farcall StepMatchFrame ; $6bb4
Label_06_6bb7:
	farcall ReadMatchInputPressed ; $6bb7
	and a, $0d ; $6bba
	jr nz, Label_06_6bc9 ; $6bbc
	call HandleDebugStatsInput ; $6bbe
	call FlushTilemapToVramIfDirty ; $6bc1
	farcall StepMatchFrame ; $6bc4
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
	farcall StepMatchFrame ; $6bdc
	wram_bank $04 ; $6bdf
	ld hl, $c700 ; $6be5
	ld de, wCharPosX ; $6be8
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
StoryMenuDefs:
	; $6ce0, 48 bytes (menu_def:STORYMENUITEM)
	menu_def STORYMENUITEM_STATUS, STORYMENUITEM_CLEAR_STATUS, STORYMENUITEM_OPTIONS, STORYMENUITEM_SAVE ; menu 0
	menu_def STORYMENUITEM_CHAR_DATA, STORYMENUITEM_ITEMS ; menu 1
	menu_def STORYMENUITEM_MESSAGES, STORYMENUITEM_MUSIC ; menu 2
	menu_def STORYMENUITEM_MSG_SLOW, STORYMENUITEM_MSG_NORMAL, STORYMENUITEM_MSG_FAST ; menu 3
	menu_def STORYMENUITEM_MUSIC_ON, STORYMENUITEM_MUSIC_OFF ; menu 4
	menu_def STORYMENUITEM_SAVE_GAME, STORYMENUITEM_TO_MAIN_MENU, STORYMENUITEM_CANCEL ; menu 5
RunStoryMenu:
	call GetStoryMenuItemCount ; $6d10
	ld [$c4e7], a ; $6d13
	call DrawStoryMenuItems ; $6d16
	jr Label_06_6d4d ; $6d19
Label_06_6d1b:
	farcall ReadMatchInputPressed ; $6d1b
	and a, $0a ; $6d1e
	jr z, Label_06_6d2b ; $6d20
	sound $62 ; $6d22
	ld a, $ff ; $6d24
	ld [wMatchMenuSelection], a ; $6d26
	jr Label_06_6d70 ; $6d29
Label_06_6d2b:
	farcall ReadMatchInputPressed ; $6d2b
	and a, $01 ; $6d2e
	jr z, Label_06_6d36 ; $6d30
	sound $5f ; $6d32
	jr Label_06_6d70 ; $6d34
Label_06_6d36:
	farcall ReadMatchInputRepeat ; $6d36
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
StoryMenuItemPosPointers:
	; $6dc1, 10 bytes (records:2)
	dw StoryMenuItemPos2Items ; record 0
	dw StoryMenuItemPos2Items ; record 1
	dw StoryMenuItemPos2Items ; record 2
	dw StoryMenuItemPos3Items ; record 3
	dw StoryMenuItemPos4Items ; record 4
StoryMenuItemPos2Items:
	; $6dcb, 4 bytes (bytes:2)
	db $0a, $05 ; 0x00
	db $0a, $0b ; 0x02
StoryMenuItemPos3Items:
	; $6dcf, 6 bytes (bytes:2)
	db $0a, $04 ; 0x00
	db $0a, $08 ; 0x02
	db $0a, $0c ; 0x04
StoryMenuItemPos4Items:
	; $6dd5, 8 bytes (bytes:2)
	db $0a, $03 ; 0x00
	db $0a, $06 ; 0x02
	db $0a, $09 ; 0x04
	db $0a, $0c ; 0x06
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
StoryMenuCursorPosPointers:
	; $6dfb, 10 bytes (records:2)
	dw StoryMenuCursorPos2Items ; record 0
	dw StoryMenuCursorPos2Items ; record 1
	dw StoryMenuCursorPos2Items ; record 2
	dw StoryMenuCursorPos3Items ; record 3
	dw StoryMenuCursorPos4Items ; record 4
StoryMenuCursorPos2Items:
	; $6e05, 4 bytes (bytes:2)
	db $60, $18 ; 0x00
	db $60, $48 ; 0x02
StoryMenuCursorPos3Items:
	; $6e09, 6 bytes (bytes:2)
	db $60, $10 ; 0x00
	db $60, $30 ; 0x02
	db $60, $50 ; 0x04
StoryMenuCursorPos4Items:
	; $6e0f, 8 bytes (bytes:2)
	db $60, $08 ; 0x00
	db $60, $20 ; 0x02
	db $60, $38 ; 0x04
	db $60, $50 ; 0x06
RunStoryModeMenu:
	ldh a, [hWramBank] ; $6e17
	push af ; $6e19
	farcall StopSceneTileAnimations ; $6e1a
	ldh a, [$ffdd] ; $6e1d
	push af ; $6e1f
	call AdvanceFrame ; $6e20
	sound $63 ; $6e23
	xor a, a ; $6e25
	ld [wMatchMenuSelection], a ; $6e26
	ld a, $02 ; $6e29
	ldh [$ffdd], a ; $6e2b
	farcall InitTextWindows ; $6e2d
	ld a, $81 ; $6e30
	ld [wWindowTileAttr], a ; $6e32
	set_flag $02, 4 ; $6e35
	farcall LoadMatchStoryGfx ; $6e38
	call RestoreStoryTilemapNoPriority ; $6e3b
	ld d, $00 ; $6e3e
	ld e, $0e ; $6e40
	ld b, $13 ; $6e42
	ld c, $03 ; $6e44
	farcall CreateWindowFromScreenRect ; $6e46
	call AdvanceFrame ; $6e49
	wram_bank $05 ; $6e4c
Label_06_6e52:
	ld hl, ScoreboardModeGfxTail ; $6e52
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
	ld hl, Func_06_6e7d ; $6e6d
	push hl ; $6e70
	ld a, [wMatchMenuSelection] ; $6e71
	rst Rst00 ; $6e74
	dw StoryPauseMenu_PlayerData ; $6e75 jumptable
	dw StoryPauseMenu_GameProgress ; $6e77 jumptable
	dw StoryPauseMenu_Options ; $6e79 jumptable
	dw StoryPauseMenu_SaveQuit ; $6e7b jumptable
Func_06_6e7d:
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
	farcall Func_01_50ec ; $6ea0
	pop af ; $6ea3
	ldh [$ffdd], a ; $6ea4
	farcall InitTextWindows ; $6ea6
	farcall InitSceneTileAnimations ; $6ea9
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
	farcall InitSceneTileAnimations ; $6ebe
	pop af ; $6ec1
	wram_bank ; $6ec2
	ret ; $6ec6
	call Func_06_7863 ; $6ec7
	ld hl, ScoreboardModeGfxTail ; $6eca
	ld de, $8640 ; $6ecd
	ld c, $04 ; $6ed0
	call QueueVRAMCopy ; $6ed2
	jr Label_06_6f07 ; $6ed5
Label_06_6ed7:
	farcall ReadMatchInputPressed ; $6ed7
	and a, $0e ; $6eda
	jr z, Label_06_6ee7 ; $6edc
	sound $62 ; $6ede
	ld a, $ff ; $6ee0
	ld [wMatchMenuSelection], a ; $6ee2
	jr Label_06_6f36 ; $6ee5
Label_06_6ee7:
	farcall ReadMatchInputPressed ; $6ee7
	and a, $01 ; $6eea
	jr z, Label_06_6ef2 ; $6eec
	sound $5f ; $6eee
	jr Label_06_6f36 ; $6ef0
Label_06_6ef2:
	farcall ReadMatchInputRepeat ; $6ef2
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
StoryPauseMenuCursorPositions:
	; $6f3a, 8 bytes (bytes:2)
	db $60, $08 ; 0x00
	db $60, $20 ; 0x02
	db $60, $38 ; 0x04
	db $60, $50 ; 0x06
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
	farcall ShowCharDataScreen ; $6f7f
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
	farcall ShowEquipmentStatusScreen ; $6f9b
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
	farcall ShowGameProgressScreen ; $6fb7
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
	ld hl, Func_06_6fe3 ; $6fd7
	push hl ; $6fda
	ld a, [wMatchMenuSelection] ; $6fdb
	rst Rst00 ; $6fde
	dw StoryPauseMenu_MessageSpeed ; $6fdf jumptable
	dw StoryPauseMenu_MusicToggle ; $6fe1 jumptable
Func_06_6fe3:
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
	farcall SetStorySlotFlagA ; $702b
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
	farcall SaveStoryReturnPoint ; $706a
	farcall SaveStorySlotWithTimer ; $706d
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
	farcall ReadMatchInputPressed ; $7105
	and a, $02 ; $7108
	jr z, Label_06_7115 ; $710a
	sound $62 ; $710c
	ld a, $ff ; $710e
	ld [wMatchMenuSelection], a ; $7110
	jr Label_06_7172 ; $7113
Label_06_7115:
	farcall ReadMatchInputPressed ; $7115
	and a, $01 ; $7118
	jr z, Label_06_7120 ; $711a
	sound $5f ; $711c
	jr Label_06_7172 ; $711e
Label_06_7120:
	farcall ReadMatchInputRepeat ; $7120
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
StoryTwoOptionCursorPositions:
	; $7176, 4 bytes (bytes:2)
	db $60, $18 ; 0x00
	db $60, $48 ; 0x02
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
	farcall ReadMatchInputPressed ; $71bf
	and a, $02 ; $71c2
	jr z, Label_06_71cf ; $71c4
	sound $62 ; $71c6
	ld a, $ff ; $71c8
	ld [wMatchMenuSelection], a ; $71ca
	jr Label_06_722a ; $71cd
Label_06_71cf:
	farcall ReadMatchInputPressed ; $71cf
	and a, $01 ; $71d2
	jr z, Label_06_71da ; $71d4
	sound $5f ; $71d6
	jr Label_06_722a ; $71d8
Label_06_71da:
	farcall ReadMatchInputRepeat ; $71da
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
StoryThreeOptionCursorPositions:
	; $7231, 6 bytes (bytes:2)
	db $60, $08 ; 0x00
	db $60, $30 ; 0x02
	db $60, $58 ; 0x04
RedrawStoryTilemapRows:
	wram_bank $05 ; $7237
	farcall RedrawAllTilemapRows ; $723d
	ret ; $7240
RestoreStoryShadowTilemap:
	farcall RestoreShadowTilemap ; $7241
	ret ; $7244
RestoreStoryTilemapNoPriority:
	farcall RestoreShadowTilemap ; $7245
	call ClearStoryAttrPriorityBits ; $7248
	farcall RedrawAllTilemapRows ; $724b
	ret ; $724e
DrawStoryMenuCaption:
	push hl ; $724f
	farcall PrepareGlyphBuffer ; $7250
	xor a, a ; $7253
	farcall DrawTextWindowFrame ; $7254
	ld hl, $0101 ; $7257
	add hl, de ; $725a
	ld e, l ; $725b
	ld d, h ; $725c
	call GetShadowTilemapAddr ; $725d
	pop hl ; $7260
	ld c, $11 ; $7261
	farcall RenderProportionalTextAt ; $7263
	farcall UploadGlyphBuffer ; $7266
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
StoryMenuItemGfxPointers:
	; $72ae, 32 bytes (records:2)
	dw StoryMenuItemGfx_Status ; record 0
	dw StoryMenuItemGfx_ClearStatus ; record 1
	dw MatchMenuItemGfx_Options ; record 2
	dw MatchMenuItemGfx_Save ; record 3
	dw StoryMenuItemGfx_Messages ; record 4
	dw MatchMenuItemGfx_Music ; record 5
	dw StoryMenuItemGfx_Slow ; record 6
	dw StoryMenuItemGfx_Normal ; record 7
	dw StoryMenuItemGfx_Fast ; record 8
	dw MatchMenuItemGfx_On ; record 9
	dw MatchMenuItemGfx_Off ; record 10
	dw MatchMenuItemGfx_SaveNarrow ; record 11
	dw MatchMenuItemGfx_ToMainMenu ; record 12
	dw MatchMenuItemGfx_Cancel ; record 13
	dw StoryMenuItemGfx_CharData ; record 14
	dw StoryMenuItemGfx_Items ; record 15
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
	; $7308, 8 bytes (bytes:8)
	db $00, $00, $00, $00, $00, $00, $00, $00 ; 0x00
StoryMenuItemGfx_Status:
	INCBIN "data/bank_006/d_7310.bin" ; $7310, 160 bytes
StoryMenuItemGfx_ClearStatus:
	INCBIN "data/bank_006/d_73b0.bin" ; $73b0, 183 bytes
StoryMenuItemGfx_Messages:
	INCBIN "data/bank_006/d_7467.bin" ; $7467, 171 bytes
StoryMenuItemGfx_Slow:
	INCBIN "data/bank_006/d_7512.bin" ; $7512, 118 bytes
StoryMenuItemGfx_Fast:
	INCBIN "data/bank_006/d_7588.bin" ; $7588, 121 bytes
StoryMenuItemGfx_CharData:
	INCBIN "data/bank_006/d_7601.bin" ; $7601, 175 bytes
StoryMenuItemGfx_Items:
	INCBIN "data/bank_006/d_76b0.bin" ; $76b0, 125 bytes
StoryMenuItemGfx_Normal:
	INCBIN "data/bank_006/d_772d.bin" ; $772d, 121 bytes
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
	ld hl, MenuItemAttrRect3x2 ; $77c1
	ld bc, $0302 ; $77c4
	call CopyTileRectToShadowAttrmap ; $77c7
	ret ; $77ca
StoryMenuItemRectPointers:
	; $77cb, 32 bytes (records:2)
	dw StoryMenuItemRect_Status ; record 0
	dw StoryMenuItemRect_ClearStatus ; record 1
	dw StoryMenuItemRect_Options ; record 2
	dw StoryMenuItemRect_Save ; record 3
	dw StoryMenuItemRect_Messages ; record 4
	dw StoryMenuItemRect_Music ; record 5
	dw StoryMenuItemRect_Slow ; record 6
	dw StoryMenuItemRect_Normal ; record 7
	dw StoryMenuItemRect_Fast ; record 8
	dw StoryMenuItemRect_On ; record 9
	dw StoryMenuItemRect_Off ; record 10
	dw StoryMenuItemRect_SaveNarrow ; record 11
	dw StoryMenuItemRect_ToMainMenu ; record 12
	dw StoryMenuItemRect_Cancel ; record 13
	dw StoryMenuItemRect_CharData ; record 14
	dw StoryMenuItemRect_Items ; record 15
StoryMenuItemRect_Status:
	; $77eb, 6 bytes (tilemap:3)
	tilemap_begin 3, 2
	tilemap_row $49, $4a, $4b ; row 0
	tilemap_row $59, $5a, $5b ; row 1
	tilemap_end
StoryMenuItemRect_ClearStatus:
	; $77f1, 6 bytes (tilemap:3)
	tilemap_begin 3, 2
	tilemap_row $14, $15, $16 ; row 0
	tilemap_row $24, $25, $26 ; row 1
	tilemap_end
StoryMenuItemRect_Options:
	; $77f7, 6 bytes (tilemap:3)
	tilemap_begin 3, 2
	tilemap_row $17, $18, $19 ; row 0
	tilemap_row $27, $28, $29 ; row 1
	tilemap_end
StoryMenuItemRect_Save:
	; $77fd, 6 bytes (tilemap:3)
	tilemap_begin 3, 2
	tilemap_row $1a, $1b, $1c ; row 0
	tilemap_row $2a, $2b, $2c ; row 1
	tilemap_end
StoryMenuItemRect_Messages:
	; $7803, 6 bytes (tilemap:3)
	tilemap_begin 3, 2
	tilemap_row $1d, $1e, $1f ; row 0
	tilemap_row $2d, $2e, $2f ; row 1
	tilemap_end
StoryMenuItemRect_Music:
	; $7809, 6 bytes (tilemap:3)
	tilemap_begin 3, 2
	tilemap_row $e0, $e1, $e2 ; row 0
	tilemap_row $f0, $f1, $f2 ; row 1
	tilemap_end
StoryMenuItemRect_Slow:
	; $780f, 6 bytes (tilemap:3)
	tilemap_begin 3, 2
	tilemap_row $4c, $4d, $4e ; row 0
	tilemap_row $5c, $5d, $5e ; row 1
	tilemap_end
StoryMenuItemRect_Normal:
	; $7815, 6 bytes (tilemap:3)
	tilemap_begin 3, 2
	tilemap_row $e9, $ea, $eb ; row 0
	tilemap_row $f9, $fa, $fb ; row 1
	tilemap_end
StoryMenuItemRect_Fast:
	; $781b, 6 bytes (tilemap:3)
	tilemap_begin 3, 2
	tilemap_row $ec, $ed, $ee ; row 0
	tilemap_row $fc, $fd, $fe ; row 1
	tilemap_end
StoryMenuItemRect_On:
	; $7821, 6 bytes (tilemap:3)
	tilemap_begin 3, 2
	tilemap_row $e3, $e4, $e5 ; row 0
	tilemap_row $f3, $f4, $f5 ; row 1
	tilemap_end
StoryMenuItemRect_Off:
	; $7827, 6 bytes (tilemap:3)
	tilemap_begin 3, 2
	tilemap_row $e6, $e7, $e8 ; row 0
	tilemap_row $f6, $f7, $f8 ; row 1
	tilemap_end
StoryMenuItemRect_SaveNarrow:
	; $782d, 6 bytes (tilemap:3)
	tilemap_begin 3, 2
	tilemap_row $43, $44, $45 ; row 0
	tilemap_row $53, $54, $55 ; row 1
	tilemap_end
StoryMenuItemRect_ToMainMenu:
	; $7833, 6 bytes (tilemap:3)
	tilemap_begin 3, 2
	tilemap_row $46, $47, $48 ; row 0
	tilemap_row $56, $57, $58 ; row 1
	tilemap_end
StoryMenuItemRect_Cancel:
	; $7839, 6 bytes (tilemap:3)
	tilemap_begin 3, 2
	tilemap_row $60, $61, $62 ; row 0
	tilemap_row $63, $64, $65 ; row 1
	tilemap_end
StoryMenuItemRect_CharData:
	; $783f, 6 bytes (tilemap:3)
	tilemap_begin 3, 2
	tilemap_row $40, $41, $42 ; row 0
	tilemap_row $50, $51, $52 ; row 1
	tilemap_end
StoryMenuItemRect_Items:
	; $7845, 6 bytes (tilemap:3)
	tilemap_begin 3, 2
	tilemap_row $12, $13, $4f ; row 0
	tilemap_row $22, $23, $5f ; row 1
	tilemap_end
TextRect_06_784b:
	; $784b, 24 bytes (tilemap:12)
	tilemap_begin 12, 2
	tilemap_row $49, $4a, $4b, $14, $15, $16, $17, $18, $19, $1a, $1b, $1c ; row 0
	tilemap_row $59, $5a, $5b, $24, $25, $26, $27, $28, $29, $2a, $2b, $2c ; row 1
	tilemap_end
Func_06_7863:
	ld de, $030a ; $7863
	call GetShadowTilemapAddr ; $7866
	ld hl, TextRect_06_784b ; $7869
	ld bc, $0c02 ; $786c
	call CopyTileRectToShadowTilemap ; $786f
	ld de, $030a ; $7872
	call GetShadowAttrmapAddr ; $7875
	ld hl, TextRectAttrs_06_6973 ; $7878
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
