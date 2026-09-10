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
	ld c, (MatchMenuItemGfx_Rules - ScoreboardModeGfxTail) / 16 ; $4023
	call QueueVRAMCopy ; $4025
	farcall StepMatchFrame ; $4028
	wram_bank $02 ; $402b
	ld b, $00 ; $4031
	call DrawScoreboard ; $4033
	ld a, $0a ; $4036
	ld hl, DrawScoreboardSprites ; $4038
	call RegisterFrameTask ; $403b
	ld a, $0a ; $403e
	ld hl, DrawScoreboardModeTitle ; $4040
	call RegisterFrameTask ; $4043
.loop:
	xor a ; $4046
	ld [wMatchMenuSelection], a ; $4047
	ld a, $0e ; $404a
	ld [wPauseMenuId], a ; $404c
	call RunMatchQuitMenu ; $404f
	ld a, [wMatchMenuSelection] ; $4052
	cp MATCHMENUSEL_CANCELLED ; $4055
	jr z, .loop ; $4057
	ld hl, DrawScoreboardSprites ; $4059
	call UnregisterFrameTask ; $405c
	ld hl, DrawScoreboardModeTitle ; $405f
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
	ldh a, [hLinkPayloadKind] ; $4077
	push af ; $4079
	farcall StepMatchFrame ; $407a
	farcall StepMatchFrame ; $407d
	sound SFX_PAUSE_MENU ; $4080
	xor a ; $4082
	ld [wMatchMenuSelection], a ; $4083
	ld a, $02 ; $4086
	ldh [hLinkPayloadKind], a ; $4088
	call PrepareScoreboardGfx ; $408a
	farcall StepMatchFrame ; $408d
	call LoadScoreboardModeGfx ; $4090
	ld hl, ScoreboardModeGfxTail ; $4093
	ld de, $8640 ; $4096
	ld c, (MatchMenuItemGfx_Rules - ScoreboardModeGfxTail) / 16 ; $4099
	call QueueVRAMCopy ; $409b
	farcall StepMatchFrame ; $409e
	wram_bank $02 ; $40a1
.loop:
	ld b, $00 ; $40a7
	call DrawScoreboard ; $40a9
	ld a, $0a ; $40ac
	ld hl, DrawScoreboardSprites ; $40ae
	call RegisterFrameTask ; $40b1
	ld a, $0a ; $40b4
	ld hl, DrawScoreboardModeTitle ; $40b6
	call RegisterFrameTask ; $40b9
	ld b, $00 ; $40bc
	ld a, [wCourtViewLocked] ; $40be
	and a ; $40c1
	jr z, .zero ; $40c2
	ld b, $01 ; $40c4
.zero:
	ld a, b ; $40c6
	ld [wPauseMenuId], a ; $40c7
	call RunMatchMenu ; $40ca
	ld a, [wMatchMenuSelection] ; $40cd
	cp MATCHMENUSEL_CANCELLED ; $40d0
	jr z, MatchPauseMenu_AfterItem.unregisterFrameTask ; $40d2
	push af ; $40d4
	ld hl, MatchPauseMenu_AfterItem ; $40d5
	push hl ; $40d8
	ld a, [wMatchMenuSelection] ; $40d9
	rst Rst00 ; $40dc
	dw MatchPauseMenu_CheckRules ; $40dd jumptable
	dw MatchPauseMenu_ReviewControls ; $40df jumptable
	dw MatchPauseMenu_ChangeOptions ; $40e1 jumptable
	dw MatchPauseMenu_SaveQuit ; $40e3 jumptable
MatchPauseMenu_AfterItem:
	pop af ; $40e5
	ld [wMatchMenuSelection], a ; $40e6
	ld a, [wMatchAbortFlag] ; $40e9
	and a ; $40ec
	jr z, RunMatchPauseMenu.loop ; $40ed
.unregisterFrameTask:
	ld hl, DrawScoreboardSprites ; $40ef
	call UnregisterFrameTask ; $40f2
	ld hl, DrawScoreboardModeTitle ; $40f5
	call UnregisterFrameTask ; $40f8
	call RestoreBgTilemap ; $40fb
	call FlushTilemapToVram ; $40fe
	farcall StepMatchFrame ; $4101
	farcall StepMatchFrame ; $4104
	pop af ; $4107
	ldh [hLinkPayloadKind], a ; $4108
	pop af ; $410a
	wram_bank ; $410b
	ret ; $410f
MatchPauseMenu_CheckRules:
	ld hl, DrawScoreboardSprites ; $4110
	call UnregisterFrameTask ; $4113
	call RestoreBgTilemap ; $4116
	ld hl, MatchPauseMenu_AfterRules ; $4119
	push hl ; $411c
	ld a, [wGameMode] ; $411d
	cp GAMEMODE_MARIO_MINIGAME ; $4120
	jp z, ShowMinigameRulesPages ; $4122
	ld a, [wMatchContext] ; $4125
	cp $02 ; $4128
	jp z, ShowTrainingRulesPages ; $412a
	jr ShowMatchRulesPages ; $412d
MatchPauseMenu_AfterRules:
	call RestoreBgTilemap ; $412f
	ret ; $4132
ShowMatchRulesPages:
	ld a, [wRulesGamesIndex] ; $4133
	ld b, a ; $4136
	ld a, [wRulesSetsIndex] ; $4137
	add a ; $413a
	add b ; $413b
	ld [wRulesPageListIndex], a ; $413c
	add $25 ; $413f
	ld e, a ; $4141
	adc $2c ; $4142
	sub e ; $4144
	ld d, a ; $4145
	ld hl, wRulesTitleTextId ; $4146
	ld a, e ; $4149
	ld [hl+], a ; $414a
	ld [hl], d ; $414b
	ld de, $2c62 ; $414c
	ld hl, wRulesFirstPageTextId ; $414f
	ld a, e ; $4152
	ld [hl+], a ; $4153
	ld [hl], d ; $4154
	ld a, [wRulesPageListIndex] ; $4155
	add a ; $4158
	add a ; $4159
	add LOW(MatchRulesPageLists) ; $415a
	ld l, a ; $415c
	adc HIGH(MatchRulesPageLists) ; $415d
	sub l ; $415f
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
	ld [wRulesPageListIndex], a ; $4180
	add $2b ; $4183
	ld e, a ; $4185
	adc $2c ; $4186
	sub e ; $4188
	ld d, a ; $4189
	ld hl, wRulesTitleTextId ; $418a
	ld a, e ; $418d
	ld [hl+], a ; $418e
	ld [hl], d ; $418f
	ld de, $2c6a ; $4190
	ld hl, wRulesFirstPageTextId ; $4193
	ld a, e ; $4196
	ld [hl+], a ; $4197
	ld [hl], d ; $4198
	ld a, [wRulesPageListIndex] ; $4199
	add a ; $419c
	add a ; $419d
	add LOW(TrainingRulesPageLists) ; $419e
	ld l, a ; $41a0
	adc HIGH(TrainingRulesPageLists) ; $41a1
	sub l ; $41a3
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
	sub MINIGAME_BOO_BLAST ; $4220
	ld b, a ; $4222
	add a ; $4223
	add b ; $4224
	ld b, a ; $4225
	ld a, [wMinigameLevel] ; $4226
	add b ; $4229
	ld [wRulesPageListIndex], a ; $422a
	add $47 ; $422d
	ld e, a ; $422f
	adc $2c ; $4230
	sub e ; $4232
	ld d, a ; $4233
	ld hl, wRulesTitleTextId ; $4234
	ld a, e ; $4237
	ld [hl+], a ; $4238
	ld [hl], d ; $4239
	ld a, [wCurrentMinigameStoryMatch + 1] ; $423a
	sub MINIGAME_BOO_BLAST ; $423d
	add a ; $423f
	add LOW(MinigameRulesTextIdBases) ; $4240
	ld l, a ; $4242
	adc HIGH(MinigameRulesTextIdBases) ; $4243
	sub l ; $4245
	ld h, a ; $4246
	ld a, [hl+] ; $4247
	ld d, [hl] ; $4248
	ld e, a ; $4249
	ld hl, wRulesFirstPageTextId ; $424a
	ld a, e ; $424d
	ld [hl+], a ; $424e
	ld [hl], d ; $424f
	ld a, [wRulesPageListIndex] ; $4250
	add a ; $4253
	ld b, a ; $4254
	add a ; $4255
	add b ; $4256
	add LOW(MinigameRulesPageLists) ; $4257
	ld l, a ; $4259
	adc HIGH(MinigameRulesPageLists) ; $425a
	sub l ; $425c
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
	cp $ff ; $4317
	jr z, .done ; $4319
	push hl ; $431b
	push af ; $431c
	ld a, [hl] ; $431d
	cp $ff ; $431e
	jr z, .prepareGlyphBuffer ; $4320
	ld a, $01 ; $4322
	ld hl, DrawRulesNextPageArrow_06 ; $4324
	call RegisterFrameTask ; $4327
.prepareGlyphBuffer:
	farcall PrepareGlyphBuffer ; $432a
	ld hl, wRulesTitleTextId ; $432d
	ld a, [hl+] ; $4330
	ld h, [hl] ; $4331
	ld l, a ; $4332
	ld de, $0002 ; $4333
	call DrawMenuCaptionWindow ; $4336
	ld de, $0005 ; $4339
	ld bc, $130b ; $433c
	call DrawWindowFrameAt ; $433f
	ld hl, wRulesFirstPageTextId ; $4342
	ld a, [hl+] ; $4345
	ld h, [hl] ; $4346
	ld l, a ; $4347
	pop af ; $4348
	add l ; $4349
	ld l, a ; $434a
	jr nc, .drawMenuTextLine ; $434b
	inc h ; $434d
.drawMenuTextLine:
	ld de, $0106 ; $434e
	call DrawMenuTextLine ; $4351
	farcall StepMatchFrame ; $4354
	farcall UploadGlyphBuffer ; $4357
	call FlushTilemapToVram ; $435a
.loop:
	farcall StepMatchFrame ; $435d
	farcall ReadMatchInputPressed ; $4360
	and $03 ; $4363
	jr z, .loop ; $4365
	sound SFX_MENU_SELECT ; $4367
	ld hl, DrawRulesNextPageArrow_06 ; $4369
	call UnregisterFrameTask ; $436c
	pop hl ; $436f
	jr ShowRulesPageSequence ; $4370
.done:
	ret ; $4372
DrawRulesNextPageArrow_06:
	ld de, $9080 ; $4373
	farcall AddBobbingOffsetY ; $4376
	ld bc, $0a70 ; $4379
	call QueueSprite16 ; $437c
	ret ; $437f
MatchPauseMenu_ReviewControls:
	ld hl, DrawScoreboardSprites ; $4380
	call UnregisterFrameTask ; $4383
	call RestoreBgTilemap ; $4386
	ld de, $0002 ; $4389
	ld bc, $130e ; $438c
	call DrawWindowFrameAt ; $438f
	farcall PrepareGlyphBuffer ; $4392
	ld de, $0103 ; $4395
	ld hl, Text_30_343 ; $4398
	call DrawMenuTextLine ; $439b
	ld de, $060a ; $439e
	ld hl, Text_30_344 ; $43a1
	call DrawMenuTextLine ; $43a4
	ld de, $010c ; $43a7
	ld hl, Text_30_345 ; $43aa
	call DrawMenuTextLine ; $43ad
	farcall UploadGlyphBuffer ; $43b0
	call FlushTilemapToVram ; $43b3
	farcall StepMatchFrame ; $43b6
.loop:
	farcall ReadMatchInputPressed ; $43b9
	and $03 ; $43bc
	jr nz, .restoreBgTilemap ; $43be
	farcall ReadMatchInputPressed ; $43c0
	and $40 ; $43c3
	jr z, .stepMatchFrame ; $43c5
	ldh a, [hDebugStepMode] ; $43c7
	and a ; $43c9
	jr z, .stepMatchFrame ; $43ca
	ldh a, [hWramBank] ; $43cc
	push af ; $43ce
	wram_bank $04 ; $43cf
	ld hl, wCharInputSource ; $43d5
	ld a, [hl] ; $43d8
	xor $01 ; $43d9
	ld [hl], a ; $43db
	pop af ; $43dc
	wram_bank ; $43dd
	jr .restoreBgTilemap ; $43e1
.stepMatchFrame:
	farcall StepMatchFrame ; $43e3
	jr .loop ; $43e6
.restoreBgTilemap:
	call RestoreBgTilemap ; $43e8
	sound SFX_MENU_CANCEL ; $43eb
	ret ; $43ed
MatchPauseMenu_ChangeOptions:
	call RestoreBgTilemapRegion ; $43ee
	ld a, [wCourtViewLocked] ; $43f1
	and a ; $43f4
	jr nz, MatchPauseMenu_MusicToggle ; $43f5
	xor a ; $43f7
	ld [wMatchMenuSelection], a ; $43f8
.loop:
	ld a, $02 ; $43fb
	ld [wPauseMenuId], a ; $43fd
	call RunMatchMenu ; $4400
	ld a, [wMatchMenuSelection] ; $4403
	cp MATCHMENUSEL_CANCELLED ; $4406
	jr z, MatchOptionsMenu_AfterItem.done ; $4408
	push af ; $440a
	ld hl, MatchOptionsMenu_AfterItem ; $440b
	push hl ; $440e
	ld a, [wMatchMenuSelection] ; $440f
	rst Rst00 ; $4412
	dw MatchPauseMenu_CameraSelect ; $4413 jumptable
	dw MatchPauseMenu_MusicToggle ; $4415 jumptable
MatchOptionsMenu_AfterItem:
	pop af ; $4417
	ld [wMatchMenuSelection], a ; $4418
	jr MatchPauseMenu_ChangeOptions.loop ; $441b
.done:
	ret ; $441d
MatchPauseMenu_CameraSelect:
	ld a, [wCourtViewOption] ; $441e
	ld [wMatchMenuSelection], a ; $4421
	ld a, $03 ; $4424
	ld [wPauseMenuId], a ; $4426
	call RunMatchMenu ; $4429
	ld a, [wMatchMenuSelection] ; $442c
	cp MATCHMENUSEL_CANCELLED ; $442f
	jr z, .done ; $4431
	ld [wCourtViewOption], a ; $4433
	farcall SetStorySlotFlagB ; $4436
.done:
	ret ; $4439
MatchPauseMenu_MusicToggle:
	ldh a, [hMusic] ; $443a
	and $01 ; $443c
	ld [wMatchMenuSelection], a ; $443e
	ld a, $04 ; $4441
	ld [wPauseMenuId], a ; $4443
	call RunMatchMenu ; $4446
	ld a, [wMatchMenuSelection] ; $4449
	cp MATCHMENUSEL_CANCELLED ; $444c
	jr z, .done ; $444e
	call SetMusicMuted ; $4450
	ld a, [wGameMode] ; $4453
	cp GAMEMODE_LINK_MATCH ; $4456
	jr z, .done ; $4458
	ldh a, [hMusic] ; $445a
	and $01 ; $445c
	farcall SetStorySlotFlagA ; $445e
.done:
	ret ; $4461
MatchPauseMenu_SaveQuit:
	call RestoreBgTilemapRegion ; $4462
	ld a, [wGameMode] ; $4465
	add LOW(SaveQuitMenuIdByGameMode) ; $4468
	ld l, a ; $446a
	adc HIGH(SaveQuitMenuIdByGameMode) ; $446b
	sub l ; $446d
	ld h, a ; $446e
	ld a, [hl] ; $446f
	ld [wPauseMenuId], a ; $4470
	ld a, [wDrillIsPracticeLesson] ; $4473
	and a ; $4476
	jr z, .getMatchMenuItemCount ; $4477
	ld a, $08 ; $4479
	ld [wPauseMenuId], a ; $447b
.getMatchMenuItemCount:
	call GetMatchMenuItemCount ; $447e
	dec a ; $4481
	ld [wMatchMenuSelection], a ; $4482
RunMatchQuitMenu:
	call RunMatchMenu ; $4485
	ld a, [wMatchMenuSelection] ; $4488
	cp MATCHMENUSEL_CANCELLED ; $448b
	ret z ; $448d
	call GetMatchMenuItemId ; $448e
	sub $0a ; $4491
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
	ld [wSaveAndQuitRequest], a ; $44b7
	ld a, MATCHABORT_ALL ; $44ba
	ld [wMatchAbortFlag], a ; $44bc
	ld [wMatchFramesAbort], a ; $44bf
	ret ; $44c2
MatchQuitMenu_Retry:
	ld a, $01 ; $44c3
	ld [wMatchRetryRequest], a ; $44c5
	ld [wMatchExitRequest], a ; $44c8
	ld a, MATCHABORT_ALL ; $44cb
	ld [wMatchAbortFlag], a ; $44cd
	ld [wMatchFramesAbort], a ; $44d0
	ret ; $44d3
MatchQuitMenu_SelectNewLevel:
	ld a, $01 ; $44d4
	ld [wMatchSelectNewLevelRequest], a ; $44d6
	ld [wMatchExitRequest], a ; $44d9
	ld a, MATCHABORT_ALL ; $44dc
	ld [wMatchAbortFlag], a ; $44de
	ld [wMatchFramesAbort], a ; $44e1
	ret ; $44e4
MatchQuitMenu_Quit:
	ld a, $01 ; $44e5
	ld [wMatchExitRequest], a ; $44e7
	ld a, MATCHABORT_ALL ; $44ea
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
.waitInput:
	farcall StepMatchFrame ; $4543
	farcall ReadMatchInputPressed ; $4546
	and $0f ; $4549
	jr z, .waitInput ; $454b
	call RestoreBgTilemap ; $454d
	call FlushTilemapToVram ; $4550
	farcall StepMatchFrame ; $4553
	xor a ; $4556
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
	ld hl, wCourtTilemapSaved ; $45aa
	ld de, wCourtTilemap ; $45ad
	ld c, $40 ; $45b0
	call CopyMemoryFast ; $45b2
	ld hl, wCourtAttrmapSaved ; $45b5
	ld de, wCourtAttrmap ; $45b8
	ld c, $40 ; $45bb
	call CopyMemoryFast ; $45bd
	ret ; $45c0
RestoreBgTilemapRegion:
	ld e, $0a ; $45c1
	call GetScrolledTilemapRowOffset ; $45c3
	ld c, l ; $45c6
	ld b, h ; $45c7
	push bc ; $45c8
	ld hl, wCourtTilemap ; $45c9
	add hl, bc ; $45cc
	ld e, l ; $45cd
	ld d, h ; $45ce
	ld hl, wCourtTilemapSaved ; $45cf
	add hl, bc ; $45d2
	ld c, $0e ; $45d3
	call CopyMemoryFast ; $45d5
	pop bc ; $45d8
	ld hl, wCourtAttrmap ; $45d9
	add hl, bc ; $45dc
	ld e, l ; $45dd
	ld d, h ; $45de
	ld hl, wCourtAttrmapSaved ; $45df
	add hl, bc ; $45e2
	ld c, $0e ; $45e3
	call CopyMemoryFast ; $45e5
	ret ; $45e8
ClearAttrPriorityRegion:
	ld a, [hl] ; $45e9
	and $7f ; $45ea
	ld [hl+], a ; $45ec
	dec bc ; $45ed
	ld a, b ; $45ee
	or c ; $45ef
	jr nz, ClearAttrPriorityRegion ; $45f0
	ret ; $45f2
FlushTilemapToVramIfDirty:
	ld a, [wTilemapDirtyFlag] ; $45f3
	and a ; $45f6
	ret z ; $45f7
FlushTilemapToVram:
	xor a ; $45f8
	ld [wTilemapDirtyFlag], a ; $45f9
	ld e, $00 ; $45fc
	call GetScrolledTilemapRowOffset ; $45fe
	ld c, l ; $4601
	ld b, h ; $4602
	push bc ; $4603
	ld hl, $9800 ; $4604
	add hl, bc ; $4607
	ld e, l ; $4608
	ld d, h ; $4609
	ld hl, wCourtTilemap ; $460a
	add hl, bc ; $460d
	ld c, $22 ; $460e
	call QueueVRAMCopy ; $4610
	pop bc ; $4613
	ld hl, $9800 + VRAM_BANK1 ; $4614
	add hl, bc ; $4617
	ld e, l ; $4618
	ld d, h ; $4619
	ld hl, wCourtAttrmap ; $461a
	add hl, bc ; $461d
	ld c, $22 ; $461e
	call QueueVRAMCopy ; $4620
	ret ; $4623
GetShadowTilemapAddr:
	call GetScrolledTilemapOffset ; $4624
	ld de, wActiveTilemap ; $4627
	add hl, de ; $462a
	ld e, l ; $462b
	ld d, h ; $462c
	ret ; $462d
GetShadowAttrmapAddr:
	call GetScrolledTilemapOffset ; $462e
	ld de, wActiveAttrmap ; $4631
	add hl, de ; $4634
	ld e, l ; $4635
	ld d, h ; $4636
	ret ; $4637
GetScrolledTilemapOffset:
	call GetScrolledTilemapRowOffset ; $4638
	ldh a, [hScrollX] ; $463b
	add $07 ; $463d
	rrca ; $463f
	rrca ; $4640
	rrca ; $4641
	add d ; $4642
	and $1f ; $4643
	add l ; $4645
	ld l, a ; $4646
	jr nc, .done ; $4647
	inc h ; $4649
.done:
	ret ; $464a
GetScrolledTilemapRowOffset:
	ldh a, [hScrollY] ; $464b
	add $07 ; $464d
	rrca ; $464f
	rrca ; $4650
	rrca ; $4651
	add e ; $4652
	and $1f ; $4653
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
	and $07 ; $4662
	add d ; $4664
	ld d, a ; $4665
	ldh a, [hScrollY] ; $4666
	cpl ; $4668
	inc a ; $4669
	and $07 ; $466a
	add e ; $466c
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
	ld [wPauseMenuItemCount], a ; $46ea
	call DrawMatchMenuItems ; $46ed
	ld e, $0c ; $46f0
	call GetScrolledTilemapRowOffset ; $46f2
	ld de, wCourtAttrmap ; $46f5
	add hl, de ; $46f8
	ld bc, $0040 ; $46f9
	call ClearAttrPriorityRegion ; $46fc
	jr .redraw ; $46ff
.inputLoop:
	farcall ReadMatchInputPressed ; $4701
	and $0a ; $4704
	jr z, .checkA ; $4706
	sound SFX_MENU_CANCEL ; $4708
	ld a, MATCHMENUSEL_CANCELLED ; $470a
	ld [wMatchMenuSelection], a ; $470c
	jr .done ; $470f
.checkA:
	farcall ReadMatchInputPressed ; $4711
	and $01 ; $4714
	jr z, .checkLeftRight ; $4716
	sound SFX_MENU_SELECT ; $4718
	jr .done ; $471a
.checkLeftRight:
	farcall ReadMatchInputRepeat ; $471c
	and $30 ; $471f
	jr z, .drawCursor ; $4721
	ld b, a ; $4723
	ld a, [wPauseMenuItemCount] ; $4724
	ld c, a ; $4727
	ld a, [wMatchMenuSelection] ; $4728
	call MoveCursorHorizontal ; $472b
	ld [wMatchMenuSelection], a ; $472e
	sound SFX_MENU_MOVE ; $4731
.redraw:
	farcall PrepareGlyphBuffer ; $4733
	ld hl, wGlyphPenX ; $4736
	ld de, $2000 ; $4739
	ld a, e ; $473c
	ld [hl+], a ; $473d
	ld [hl], d ; $473e
	ld a, $40 ; $473f
	ld hl, wTextRowColumn ; $4741
	ld [hl+], a ; $4744
	ld [hl+], a ; $4745
	ld [hl+], a ; $4746
	ld a, [wMatchMenuSelection] ; $4747
	call GetMatchMenuItemId ; $474a
	push af ; $474d
	call LoadMatchMenuItemGfx ; $474e
	pop af ; $4751
	add $3f ; $4752
	ld l, a ; $4754
	adc $01 ; $4755
	sub l ; $4757
	ld h, a ; $4758
	ld de, $000e ; $4759
	call DrawMenuCaptionWindow ; $475c
	call DrawScoreboardCaption ; $475f
	farcall UploadGlyphBuffer ; $4762
	farcall StepMatchFrame ; $4765
	call FlushTilemapToVram ; $4768
	farcall StepMatchFrame ; $476b
.drawCursor:
	call DrawMatchMenuCursor ; $476e
	farcall StepMatchFrame ; $4771
	jr .inputLoop ; $4774
.done:
	farcall StepMatchFrame ; $4776
	ret ; $4779
DrawScoreboardCaption:
	ld a, [wScoreboardLayout] ; $477a
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
	ld hl, wScoreboardOrigin ; $478e
	ld a, [hl+] ; $4791
	ld b, [hl] ; $4792
	ld c, a ; $4793
	ld hl, $0701 ; $4794
	add hl, bc ; $4797
	ld e, l ; $4798
	ld d, h ; $4799
	ld hl, Text_30_346 ; $479a
	call DrawMenuTextLine ; $479d
	ret ; $47a0
ScoreboardCaption_Total:
	ld hl, wScoreboardOrigin ; $47a1
	ld a, [hl+] ; $47a4
	ld b, [hl] ; $47a5
	ld c, a ; $47a6
	ld hl, $0e01 ; $47a7
	add hl, bc ; $47aa
	ld e, l ; $47ab
	ld d, h ; $47ac
	ld hl, Text_30_347 ; $47ad
	call DrawMenuTextLine ; $47b0
	ret ; $47b3
ScoreboardCaption_ScoreTarget:
	ld hl, wScoreboardOrigin ; $47b4
	ld a, [hl+] ; $47b7
	ld b, [hl] ; $47b8
	ld c, a ; $47b9
	ld hl, $0502 ; $47ba
	add hl, bc ; $47bd
	ld e, l ; $47be
	ld d, h ; $47bf
	ld hl, Text_30_348 ; $47c0
	call DrawMenuTextLine ; $47c3
	ld hl, $0304 ; $47c6
	add hl, bc ; $47c9
	ld e, l ; $47ca
	ld d, h ; $47cb
	ld hl, Text_30_349 ; $47cc
	call DrawMenuTextLine ; $47cf
	ld hl, $0505 ; $47d2
	add hl, bc ; $47d5
	ld e, l ; $47d6
	ld d, h ; $47d7
	ld hl, Text_30_348 ; $47d8
	call DrawMenuTextLine ; $47db
	ret ; $47de
ScoreboardCaption_ScoreHigh:
	ld hl, wScoreboardOrigin ; $47df
	ld a, [hl+] ; $47e2
	ld b, [hl] ; $47e3
	ld c, a ; $47e4
	ld hl, $0502 ; $47e5
	add hl, bc ; $47e8
	ld e, l ; $47e9
	ld d, h ; $47ea
	ld hl, Text_30_348 ; $47eb
	call DrawMenuTextLine ; $47ee
	ld hl, $0404 ; $47f1
	add hl, bc ; $47f4
	ld e, l ; $47f5
	ld d, h ; $47f6
	ld hl, Text_30_350 ; $47f7
	call DrawMenuTextLine ; $47fa
	ld hl, $0505 ; $47fd
	add hl, bc ; $4800
	ld e, l ; $4801
	ld d, h ; $4802
	ld hl, Text_30_348 ; $4803
	call DrawMenuTextLine ; $4806
	ret ; $4809
GetMatchMenuItemId:
	ld b, a ; $480a
	ld a, [wPauseMenuId] ; $480b
	add a ; $480e
	add a ; $480f
	add a ; $4810
	add $6f ; $4811
	ld l, a ; $4813
	adc $46 ; $4814
	sub l ; $4816
	ld h, a ; $4817
	ld a, b ; $4818
	add l ; $4819
	ld l, a ; $481a
	jr nc, .read ; $481b
	inc h ; $481d
.read:
	ld a, [hl] ; $481e
	ret ; $481f
GetMatchMenuItemCount:
	ld a, [wPauseMenuId] ; $4820
	add a ; $4823
	add a ; $4824
	add a ; $4825
	add LOW(MatchMenuDefs + 4) ; $4826
	ld l, a ; $4828
	adc HIGH(MatchMenuDefs + 4) ; $4829
	sub l ; $482b
	ld h, a ; $482c
	ld a, [hl] ; $482d
	ret ; $482e
DrawMatchMenuItems:
	ld a, [wPauseMenuItemCount] ; $482f
	add a ; $4832
	add LOW(MatchMenuItemPosPointers) ; $4833
	ld l, a ; $4835
	adc HIGH(MatchMenuItemPosPointers) ; $4836
	sub l ; $4838
	ld h, a ; $4839
	ld a, [hl+] ; $483a
	ld h, [hl] ; $483b
	ld l, a ; $483c
	ld a, [wPauseMenuItemCount] ; $483d
	ld c, a ; $4840
	ld b, $00 ; $4841
.loop:
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
	jr nz, .loop ; $4854
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
	ld a, [wPauseMenuItemCount] ; $4873
	add a ; $4876
	add LOW(MatchMenuCursorPosPointers) ; $4877
	ld l, a ; $4879
	adc HIGH(MatchMenuCursorPosPointers) ; $487a
	sub l ; $487c
	ld h, a ; $487d
	ld a, [hl+] ; $487e
	ld h, [hl] ; $487f
	ld l, a ; $4880
	ld a, [wMatchMenuSelection] ; $4881
	add a ; $4884
	add l ; $4885
	ld l, a ; $4886
	jr nc, .read ; $4887
	inc h ; $4889
.read:
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
	ld [wScoreboardOrigin], a ; $48bb
	call LoadScoreboardModeGfx ; $48be
	ld b, $01 ; $48c1
	call DrawScoreboard ; $48c3
	farcall PrepareGlyphBuffer ; $48c6
	call DrawScoreboardCaption ; $48c9
	farcall UploadGlyphBuffer ; $48cc
	ld a, $0a ; $48cf
	ld hl, DrawScoreboardSprites ; $48d1
	call RegisterFrameTask ; $48d4
	ld a, $0a ; $48d7
	ld hl, DrawScoreboardModeTitle ; $48d9
	call RegisterFrameTask ; $48dc
	farcall StepMatchFrame ; $48df
	call FlushTilemapToVram ; $48e2
	farcall StepMatchFrame ; $48e5
	wram_bank $02 ; $48e8
.loop:
	farcall ReadMatchInputPressed ; $48ee
	and $0f ; $48f1
	jr nz, .maskSet ; $48f3
	farcall StepMatchFrame ; $48f5
	jr .loop ; $48f8
.maskSet:
	ld hl, DrawScoreboardSprites ; $48fa
	call UnregisterFrameTask ; $48fd
	ld hl, DrawScoreboardModeTitle ; $4900
	call UnregisterFrameTask ; $4903
	call RestoreBgTilemap ; $4906
	call FlushTilemapToVram ; $4909
	farcall StepMatchFrame ; $490c
	pop af ; $490f
	wram_bank ; $4910
	ret ; $4914
PrepareScoreboardGfx:
	ld a, $00 ; $4915
	ld [wScoreboardOrigin + 1], a ; $4917
	ld a, $02 ; $491a
	ld [wScoreboardOrigin], a ; $491c
	ld a, [wScoreboardLayout] ; $491f
	cp $06 ; $4922
	jr nz, .checkScoreboardLayout ; $4924
	ld a, $02 ; $4926
	ld [wScoreboardOrigin + 1], a ; $4928
.checkScoreboardLayout:
	ld a, [wScoreboardLayout] ; $492b
	cp $07 ; $492e
	jr nz, .checkOnCourtCharCountMinus1 ; $4930
	ld a, $02 ; $4932
	ld [wScoreboardOrigin + 1], a ; $4934
.checkOnCourtCharCountMinus1:
	ld a, [wOnCourtCharCountMinus1] ; $4937
	rst Rst00 ; $493a
	dw PrepareScoreboardGfx.reloadCharFrameGfx4 ; $493b jumptable
	dw PrepareScoreboardGfx.reloadCharFrameGfx3 ; $493d jumptable
	dw PrepareScoreboardGfx.reloadCharFrameGfx2 ; $493f jumptable
	dw PrepareScoreboardGfx.reloadCharFrameGfx ; $4941 jumptable
.reloadCharFrameGfx:
	wram_bank $06 ; $4943
	farcall ReloadCharFrameGfx ; $4949
.reloadCharFrameGfx2:
	wram_bank $07 ; $494c
	farcall ReloadCharFrameGfx ; $4952
.reloadCharFrameGfx3:
	wram_bank $05 ; $4955
	farcall ReloadCharFrameGfx ; $495b
.reloadCharFrameGfx4:
	wram_bank $04 ; $495e
	farcall ReloadCharFrameGfx ; $4964
	farcall StepMatchFrame ; $4967
	ld a, [wMatchContext] ; $496a
	cp $02 ; $496d
	jr z, .eq02 ; $496f
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
.eq02:
	wram_bank $02 ; $49a0
	ret ; $49a6
DrawScoreboard:
	push bc ; $49a7
	ld hl, wScoreboardOrigin ; $49a8
	ld a, [hl+] ; $49ab
	ld d, [hl] ; $49ac
	ld e, a ; $49ad
	ld a, [wScoreboardLayout] ; $49ae
	add a ; $49b1
	add LOW(ScoreboardTilemapPointers) ; $49b2
	ld l, a ; $49b4
	adc HIGH(ScoreboardTilemapPointers) ; $49b5
	sub l ; $49b7
	ld h, a ; $49b8
	ld a, [hl+] ; $49b9
	ld h, [hl] ; $49ba
	ld l, a ; $49bb
	call CopyTextRectPair ; $49bc
	pop bc ; $49bf
	ld a, [wScoreboardLayout] ; $49c0
	rst Rst00 ; $49c3
	dw RetStub ; $49c4 jumptable
	dw RetStub ; $49c6 jumptable
	dw RetStub ; $49c8 jumptable
	dw DrawScoreboardDrillResultRow ; $49ca jumptable
	dw DrawScoreboardDrillResultRows ; $49cc jumptable
	dw DrawScoreboardPointPips ; $49ce jumptable
	dw RetStub ; $49d0 jumptable
	dw RetStub ; $49d2 jumptable
	ret ; $49d4
DrawScoreboardDrillResultRows:
	ld de, $0504 ; $49d5
	ld c, $04 ; $49d8
	call DrawScoreboardEmptyPips ; $49da
	ld a, [wDrillShotResultBits + 1] ; $49dd
	ld c, a ; $49e0
	call DrawScoreboardPackedPips ; $49e1
DrawScoreboardDrillResultRow:
	ld de, $0502 ; $49e4
	ld c, $04 ; $49e7
	call DrawScoreboardEmptyPips ; $49e9
	ld a, [wDrillShotResultBits] ; $49ec
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
	ld hl, wScoreboardOrigin ; $4a13
	ld a, [hl+] ; $4a16
	ld h, [hl] ; $4a17
	ld l, a ; $4a18
	add hl, de ; $4a19
	ld e, l ; $4a1a
	ld d, h ; $4a1b
.loop:
	push bc ; $4a1c
	push de ; $4a1d
	ld hl, DrawScoreboardPackedPipsNext ; $4a1e
	push hl ; $4a21
	ld a, c ; $4a22
	and $03 ; $4a23
	ld a, a ; $4a25
	rst Rst00 ; $4a26
	dw RetStub ; $4a27 jumptable
	dw DrawScoreboardPipFilled ; $4a29 jumptable
	dw DrawScoreboardPipAlt ; $4a2b jumptable
	dw DrawScoreboardPipAlt ; $4a2d jumptable
DrawScoreboardPackedPipsNext:
	pop de ; $4a2f
	pop bc ; $4a30
	inc d ; $4a31
	inc d ; $4a32
	srl c ; $4a33
	srl c ; $4a35
	jr nz, DrawScoreboardPackedPips.loop ; $4a37
	ret ; $4a39
DrawScoreboardFilledPips:
	inc c ; $4a3a
	dec c ; $4a3b
	ret z ; $4a3c
	ld hl, wScoreboardOrigin ; $4a3d
	ld a, [hl+] ; $4a40
	ld h, [hl] ; $4a41
	ld l, a ; $4a42
	add hl, de ; $4a43
	ld e, l ; $4a44
	ld d, h ; $4a45
.loop:
	push bc ; $4a46
	push de ; $4a47
	call DrawScoreboardPipFilled ; $4a48
	pop de ; $4a4b
	pop bc ; $4a4c
	inc d ; $4a4d
	inc d ; $4a4e
	dec c ; $4a4f
	jr nz, .loop ; $4a50
	ret ; $4a52
DrawScoreboardEmptyPips:
	inc b ; $4a53
	dec b ; $4a54
	ret z ; $4a55
	push de ; $4a56
	ld hl, wScoreboardOrigin ; $4a57
	ld a, [hl+] ; $4a5a
	ld h, [hl] ; $4a5b
	ld l, a ; $4a5c
	add hl, de ; $4a5d
	ld e, l ; $4a5e
	ld d, h ; $4a5f
.pipLoop:
	push bc ; $4a60
	push de ; $4a61
	call DrawScoreboardPipEmpty ; $4a62
	pop de ; $4a65
	pop bc ; $4a66
	inc d ; $4a67
	inc d ; $4a68
	dec c ; $4a69
	jr nz, .pipLoop ; $4a6a
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
DrawScoreboardSprites:
	ld a, [wScoreboardOrigin + 1] ; $506a
	ld h, a ; $506d
	ld a, [wScoreboardOrigin] ; $506e
	ld l, a ; $5071
	add hl, hl ; $5072
	add hl, hl ; $5073
	add hl, hl ; $5074
	ld e, l ; $5075
	ld d, h ; $5076
	push de ; $5077
	call AdjustSpriteCoordsForScroll ; $5078
	ld a, [wScoreboardLayout] ; $507b
	add a ; $507e
	add LOW(ScoreboardSpriteTemplatePointers) ; $507f
	ld l, a ; $5081
	adc HIGH(ScoreboardSpriteTemplatePointers) ; $5082
	sub l ; $5084
	ld h, a ; $5085
	ld a, [hl+] ; $5086
	ld h, [hl] ; $5087
	ld l, a ; $5088
	ld bc, $0000 ; $5089
	call QueueSpriteTemplate ; $508c
	pop de ; $508f
	ld a, [wScoreboardLayout] ; $5090
	cp $06 ; $5093
	jr z, ScoreboardSpriteTemplatePointers.adjustSpriteCoordsForScroll ; $5095
	cp $07 ; $5097
	jr z, ScoreboardSpriteTemplatePointers.adjustSpriteCoordsForScroll ; $5099
	ret ; $509b
ScoreboardSpriteTemplatePointers:
	; $509c, 16 bytes (records:2)
	dw ScoreboardSpriteTemplate0 ; record 0
	dw ScoreboardSpriteTemplate1 ; record 1
	dw ScoreboardSpriteTemplate2 ; record 2
	dw ScoreboardSpriteTemplate5 ; record 3
	dw ScoreboardSpriteTemplate3 ; record 4
	dw ScoreboardSpriteTemplate4 ; record 5
	dw ScoreboardSpriteTemplate6 ; record 6
	dw ScoreboardSpriteTemplate6 ; record 7
.adjustSpriteCoordsForScroll:
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
	add $18 ; $50c5
	ld e, a ; $50c7
	call AdjustSpriteCoordsForScroll ; $50c8
	ld a, [wMinigameHighScoreMode] ; $50cb
	and a ; $50ce
	ld hl, wMinigameHighScore ; $50cf
	jr nz, .read ; $50d2
	ld hl, wMinigamesTargetScore ; $50d4
.read:
	ld a, [hl+] ; $50d7
	ld h, [hl] ; $50d8
	ld l, a ; $50d9
	ld b, $02 ; $50da
	ld a, $04 ; $50dc
	farcall DrawNumberWithSprites ; $50de
	ret ; $50e1
ScoreboardSpriteTemplate0:
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
ScoreboardSpriteTemplate1:
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
ScoreboardSpriteTemplate2:
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
ScoreboardSpriteTemplate3:
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
ScoreboardSpriteTemplate4:
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
ScoreboardSpriteTemplate5:
	; $51ff, 17 bytes (sprite_template)
	oam_sprite $20, $18, $00, $04
	oam_sprite $20, $20, $02, $04
	oam_sprite $20, $80, $78, $01
	oam_sprite $20, $88, $7a, $01
	oam_sprite_end
ScoreboardSpriteTemplate6:
	; $5210, 9 bytes (sprite_template)
	oam_sprite $18, $14, $00, $04
	oam_sprite $18, $1c, $02, $04
	oam_sprite_end
LoadMatchMenuItemGfx:
	add a ; $5219
	add LOW(MatchMenuItemGfxPointers) ; $521a
	ld l, a ; $521c
	adc HIGH(MatchMenuItemGfxPointers) ; $521d
	sub l ; $521f
	ld h, a ; $5220
	ld a, [hl+] ; $5221
	ld h, [hl] ; $5222
	ld l, a ; $5223
	ld de, wDecompBuffer ; $5224
	ldh a, [hWramBank] ; $5227
	push af ; $5229
	wram_bank $01 ; $522a
	call DecompressData ; $5230
	ld hl, wDecompBuffer ; $5233
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
	INCBIN "data/bank_006/lz_52c0.bin" ; $52c0, 130 bytes
MatchMenuItemGfx_Controls:
	INCBIN "data/bank_006/lz_5342.bin" ; $5342, 192 bytes
MatchMenuItemGfx_Options:
	INCBIN "data/bank_006/lz_5402.bin" ; $5402, 147 bytes
MatchMenuItemGfx_Save:
	INCBIN "data/bank_006/lz_5495.bin" ; $5495, 132 bytes
MatchMenuItemGfx_CameraMode:
	INCBIN "data/bank_006/lz_5519.bin" ; $5519, 172 bytes
MatchMenuItemGfx_Music:
	INCBIN "data/bank_006/lz_55c5.bin" ; $55c5, 131 bytes
MatchMenuItemGfx_Normal:
	INCBIN "data/bank_006/lz_5648.bin" ; $5648, 121 bytes
MatchMenuItemGfx_Player:
	INCBIN "data/bank_006/lz_56c1.bin" ; $56c1, 132 bytes
MatchMenuItemGfx_On:
	INCBIN "data/bank_006/lz_5745.bin" ; $5745, 124 bytes
MatchMenuItemGfx_Off:
	INCBIN "data/bank_006/lz_57c1.bin" ; $57c1, 131 bytes
MatchMenuItemGfx_Cancel:
	INCBIN "data/bank_006/lz_5844.bin" ; $5844, 129 bytes
MatchMenuItemGfx_SaveNarrow:
	INCBIN "data/bank_006/lz_58c5.bin" ; $58c5, 115 bytes
MatchMenuItemGfx_ToMainMenu:
	INCBIN "data/bank_006/lz_5938.bin" ; $5938, 176 bytes
MatchMenuItemGfx_ToLevelSelect:
	INCBIN "data/bank_006/lz_59e8.bin" ; $59e8, 178 bytes
MatchMenuItemGfx_TryAgain:
	INCBIN "data/bank_006/lz_5a9a.bin" ; $5a9a, 155 bytes
MatchMenuItemGfx_QuitMatch:
	INCBIN "data/bank_006/lz_5b35.bin" ; $5b35, 165 bytes
MatchMenuItemGfx_QuitMinigame:
	INCBIN "data/bank_006/lz_5bda.bin" ; $5bda, 176 bytes
LoadScoreboardModeGfx:
	ld a, [wGameMode] ; $5c8a
	cp GAMEMODE_TRAINING_DRILL ; $5c8d
	jr z, .eq05 ; $5c8f
	add a ; $5c91
	add $c9 ; $5c92
	ld l, a ; $5c94
	adc $5c ; $5c95
	sub l ; $5c97
	ld h, a ; $5c98
	jr .checkWramBank ; $5c99
.eq05:
	ld a, [wCurrentMinigameStoryMatch + 1] ; $5c9b
	add a ; $5c9e
	add LOW(ScoreboardMinigameGfxPointers) ; $5c9f
	ld l, a ; $5ca1
	adc HIGH(ScoreboardMinigameGfxPointers) ; $5ca2
	sub l ; $5ca4
	ld h, a ; $5ca5
.checkWramBank:
	ldh a, [hWramBank] ; $5ca6
	push af ; $5ca8
	wram_bank $01 ; $5ca9
	ld a, [hl+] ; $5caf
	ld h, [hl] ; $5cb0
	ld l, a ; $5cb1
	ld de, wDecompBuffer ; $5cb2
	call DecompressData ; $5cb5
	ld hl, wDecompBuffer ; $5cb8
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
	INCBIN "data/bank_006/lz_5d40.bin" ; $5d40, 181 bytes
ScoreboardModeGfx_IslandOpen:
	INCBIN "data/bank_006/lz_5df5.bin" ; $5df5, 188 bytes
ScoreboardModeGfx_PracticeMatch:
	INCBIN "data/bank_006/lz_5eb1.bin" ; $5eb1, 197 bytes
ScoreboardModeGfx_Exhibition:
	INCBIN "data/bank_006/lz_5f76.bin" ; $5f76, 129 bytes
ScoreboardModeGfx_MiniGames:
	INCBIN "data/bank_006/lz_5ff7.bin" ; $5ff7, 148 bytes
ScoreboardModeGfx_TennisMachine:
	INCBIN "data/bank_006/lz_608b.bin" ; $608b, 179 bytes
ScoreboardModeGfx_WallPractice:
	INCBIN "data/bank_006/lz_613e.bin" ; $613e, 184 bytes
ScoreboardModeGfx_MarioMiniGames:
	INCBIN "data/bank_006/lz_61f6.bin" ; $61f6, 197 bytes
ScoreboardModeGfx_LinkedMatch:
	INCBIN "data/bank_006/lz_62bb.bin" ; $62bb, 170 bytes
ScoreboardModeGfx_ServiceMatch:
	INCBIN "data/bank_006/lz_6365.bin" ; $6365, 173 bytes
ScoreboardModeGfx_ServicePractice:
	INCBIN "data/bank_006/lz_6412.bin" ; $6412, 202 bytes
ScoreboardModeGfx_NetPlayMatch:
	INCBIN "data/bank_006/lz_64dc.bin" ; $64dc, 211 bytes
ScoreboardModeGfx_NetPlayPractice:
	INCBIN "data/bank_006/lz_65af.bin" ; $65af, 216 bytes
ScoreboardModeGfx_StrokeMatch:
	INCBIN "data/bank_006/lz_6687.bin" ; $6687, 173 bytes
ScoreboardModeGfx_StrokePractice:
	INCBIN "data/bank_006/lz_6734.bin" ; $6734, 206 bytes
DrawMatchMenuItem:
	push af ; $6802
	push de ; $6803
	add a ; $6804
	add a ; $6805
	add LOW(MatchMenuItemRectPointers) ; $6806
	ld l, a ; $6808
	adc HIGH(MatchMenuItemRectPointers) ; $6809
	sub l ; $680b
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
	add a ; $681d
	add a ; $681e
	add LOW(MatchMenuItemRectPointers + 2) ; $681f
	ld l, a ; $6821
	adc HIGH(MatchMenuItemRectPointers + 2) ; $6822
	sub l ; $6824
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
Unused_06_DrawMusicMenuRowTextRect:
	; $695b, 24 bytes (tilemap:12)
	tilemap_begin 12, 2
	tilemap_row $49, $4a, $4b, $14, $15, $16, $17, $18, $19, $1a, $1b, $1c ; row 0
	tilemap_row $59, $5a, $5b, $24, $25, $26, $27, $28, $29, $2a, $2b, $2c ; row 1
	tilemap_end
TextRectAttrs_06:
	; $6973, 24 bytes (tilemap:12)
	tilemap_begin 12, 2
	tilemap_row $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; row 0
	tilemap_row $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; row 1
	tilemap_end
Unused_06_DrawMusicMenuRow:
	ld de, $030a ; $698b
	call GetShadowTilemapAddr ; $698e
	ld hl, Unused_06_DrawMusicMenuRowTextRect ; $6991
	ld bc, $0c02 ; $6994
	call CopyTextRect ; $6997
	ld de, $030a ; $699a
	call GetShadowAttrmapAddr ; $699d
	ld hl, TextRectAttrs_06 ; $69a0
	ld bc, $0c02 ; $69a3
	call CopyTextRect ; $69a6
	ld a, [wCourtViewLocked] ; $69a9
	and a ; $69ac
	ret z ; $69ad
	ld a, $05 ; $69ae
	ld de, $090a ; $69b0
	call DrawMatchMenuItem ; $69b3
	ret ; $69b6
QueueMatchMenuCursorSprite:
	ld a, d ; $69b7
	add $fc ; $69b8
	ld d, a ; $69ba
	call AdjustSpriteCoordsForScroll ; $69bb
	ld hl, QueueMatchMenuCursorSprite_SpriteTemplate ; $69be
	ld bc, $0000 ; $69c1
	call QueueSpriteTemplate ; $69c4
	ret ; $69c7
DrawScoreboardModeTitle:
	ld h, $05 ; $69c8
	ld a, [wScoreboardOrigin] ; $69ca
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
	ld hl, DrawScoreboardModeTitle_SpriteTemplate ; $69dd
	ld bc, $0000 ; $69e0
	call QueueSpriteTemplate ; $69e3
	ret ; $69e6
QueueMatchMenuCursorSprite_SpriteTemplate:
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
DrawScoreboardModeTitle_SpriteTemplate:
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
.loop:
	push bc ; $6ad3
	push de ; $6ad4
	push bc ; $6ad5
	call GetShadowTilemapAddr ; $6ad6
	pop bc ; $6ad9
	ld a, c ; $6ada
	add a ; $6adb
	add LOW(DebugStatNamePointers) ; $6adc
	ld l, a ; $6ade
	adc HIGH(DebugStatNamePointers) ; $6adf
	sub l ; $6ae1
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
	cp $0f ; $6aee
	jr nz, .loop ; $6af0
	ret ; $6af2
DrawDebugStatsValues:
	ld de, $0a01 ; $6af3
	call GetShadowTilemapAddr ; $6af6
	ld hl, wDebugStatWords ; $6af9
	ld a, [hl+] ; $6afc
	ld h, [hl] ; $6afd
	ld l, a ; $6afe
	call DrawDebugStatWord ; $6aff
	ld hl, wDebugStatWords + 4 ; $6b02
	ld a, [hl+] ; $6b05
	ld h, [hl] ; $6b06
	ld l, a ; $6b07
	call DrawDebugStatWord ; $6b08
	ld hl, wDebugStatWords + 6 ; $6b0b
	ld a, [hl+] ; $6b0e
	ld h, [hl] ; $6b0f
	ld l, a ; $6b10
	call DrawDebugStatWord ; $6b11
	ld a, [wDebugStatBytes] ; $6b14
	call DrawDebugStatByte ; $6b17
	ld a, [wDebugStatBytes + 1] ; $6b1a
	call DrawDebugStatByte ; $6b1d
	ld a, [wDebugStatBytes + 2] ; $6b20
	call DrawDebugStatByte ; $6b23
	ld a, [wDebugStatBytes + 3] ; $6b26
	call DrawDebugStatByte ; $6b29
	ld a, [wDebugStatBytes + 4] ; $6b2c
	call DrawDebugStatByte ; $6b2f
	ld a, [wDebugStatBytes + 5] ; $6b32
	call DrawDebugStatByte ; $6b35
	ld a, [wDebugStatBytes + 6] ; $6b38
	call DrawDebugStatByte ; $6b3b
	ld a, [wDebugStatBytes + 7] ; $6b3e
	call DrawDebugStatByte ; $6b41
	ld hl, wDebugStatWords2 ; $6b44
	ld a, [hl+] ; $6b47
	ld h, [hl] ; $6b48
	ld l, a ; $6b49
	call DrawDebugStatWord ; $6b4a
	ld hl, wDebugStatWords2 + 2 ; $6b4d
	ld a, [hl+] ; $6b50
	ld h, [hl] ; $6b51
	ld l, a ; $6b52
	call DrawDebugStatWord ; $6b53
	ld hl, wDebugStatWords2 + 4 ; $6b56
	ld a, [hl+] ; $6b59
	ld h, [hl] ; $6b5a
	ld l, a ; $6b5b
	call DrawDebugStatWord ; $6b5c
	ld hl, wDebugStatWords2 + 6 ; $6b5f
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
	farcall LoadMenuTilesBChunk2 ; $6b8a
	wram_bank $04 ; $6b8d
	ld hl, wCharPosX ; $6b93
	ld de, wDebugMenuWindowId ; $6b96
	ld c, $08 ; $6b99
	call CopyMemoryFast ; $6b9b
	wram_bank $02 ; $6b9e
	farcall StepMatchFrame ; $6ba4
	xor a ; $6ba7
	ld [wMatchMenuSelection], a ; $6ba8
	call DrawDebugStatsLabels ; $6bab
	call DrawDebugStatsValues ; $6bae
	call FlushTilemapToVram ; $6bb1
	farcall StepMatchFrame ; $6bb4
.loop:
	farcall ReadMatchInputPressed ; $6bb7
	and $0d ; $6bba
	jr nz, .maskSet ; $6bbc
	call HandleDebugStatsInput ; $6bbe
	call FlushTilemapToVramIfDirty ; $6bc1
	farcall StepMatchFrame ; $6bc4
	jr .loop ; $6bc7
.maskSet:
	and $08 ; $6bc9
	jr z, .restoreBgTilemap ; $6bcb
	ld de, $270b ; $6bcd
	ld hl, wMinigamesCurrentScore ; $6bd0
	ld a, e ; $6bd3
	ld [hl+], a ; $6bd4
	ld [hl], d ; $6bd5
.restoreBgTilemap:
	call RestoreBgTilemap ; $6bd6
	call FlushTilemapToVram ; $6bd9
	farcall StepMatchFrame ; $6bdc
	wram_bank $04 ; $6bdf
	ld hl, wDebugMenuWindowId ; $6be5
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
	ld [wTilemapDirtyFlag], a ; $6c0f
	ret ; $6c12
QueueDebugStatsCursorSprites:
	ld de, $0c0c ; $6c13
	call AdjustSpriteCoordsForScroll ; $6c16
	ld a, [wMatchMenuSelection] ; $6c19
	add a ; $6c1c
	add a ; $6c1d
	add a ; $6c1e
	add e ; $6c1f
	ld e, a ; $6c20
	ld bc, $0942 ; $6c21
	call QueueSprite ; $6c24
	ld a, d ; $6c27
	add $40 ; $6c28
	ld d, a ; $6c2a
	ld bc, $0942 ; $6c2b
	call QueueSprite ; $6c2e
	ret ; $6c31
AdjustSelectedDebugStat:
	ld a, [wMatchMenuSelection] ; $6c32
	rst Rst00 ; $6c35
	dw AdjustSelectedDebugStat.adjustDebugStatWord ; $6c36 jumptable
	dw AdjustSelectedDebugStat.adjustDebugStatWord2 ; $6c38 jumptable
	dw AdjustSelectedDebugStat.adjustDebugStatWord3 ; $6c3a jumptable
	dw AdjustSelectedDebugStat.adjustDebugStatByte ; $6c3c jumptable
	dw AdjustSelectedDebugStat.adjustDebugStatByte2 ; $6c3e jumptable
	dw AdjustSelectedDebugStat.adjustDebugStatByte3 ; $6c40 jumptable
	dw AdjustSelectedDebugStat.adjustDebugStatDigit ; $6c42 jumptable
	dw AdjustSelectedDebugStat.adjustDebugStatDigit2 ; $6c44 jumptable
	dw AdjustSelectedDebugStat.adjustDebugStatDigit3 ; $6c46 jumptable
	dw AdjustSelectedDebugStat.adjustDebugStatDigit4 ; $6c48 jumptable
	dw AdjustSelectedDebugStat.adjustDebugStatDigit5 ; $6c4a jumptable
.adjustDebugStatWord:
	ld hl, wDebugStatWords ; $6c4c
	ld bc, $0010 ; $6c4f
	jp AdjustDebugStatWord ; $6c52
.adjustDebugStatWord2:
	ld hl, wDebugStatWords + 4 ; $6c55
	ld bc, $0010 ; $6c58
	jp AdjustDebugStatWord ; $6c5b
.adjustDebugStatWord3:
	ld hl, wDebugStatWords + 6 ; $6c5e
	ld bc, $0010 ; $6c61
	jp AdjustDebugStatWord ; $6c64
.adjustDebugStatByte:
	ld hl, wDebugStatBytes ; $6c67
	ld b, $02 ; $6c6a
	jp AdjustDebugStatByte ; $6c6c
.adjustDebugStatByte2:
	ld hl, wDebugStatBytes + 1 ; $6c6f
	ld b, $08 ; $6c72
	jp AdjustDebugStatByte ; $6c74
.adjustDebugStatByte3:
	ld hl, wDebugStatBytes + 2 ; $6c77
	ld b, $02 ; $6c7a
	jp AdjustDebugStatByte ; $6c7c
.adjustDebugStatDigit:
	ld hl, wDebugStatBytes + 3 ; $6c7f
	jp AdjustDebugStatDigit ; $6c82
.adjustDebugStatDigit2:
	ld hl, wDebugStatBytes + 4 ; $6c85
	jp AdjustDebugStatDigit ; $6c88
.adjustDebugStatDigit3:
	ld hl, wDebugStatBytes + 5 ; $6c8b
	jp AdjustDebugStatDigit ; $6c8e
.adjustDebugStatDigit4:
	ld hl, wDebugStatBytes + 6 ; $6c91
	jp AdjustDebugStatDigit ; $6c94
.adjustDebugStatDigit5:
	ld hl, wDebugStatBytes + 7 ; $6c97
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
	jr nz, .read ; $6cac
	bit 4, a ; $6cae
	jr nz, .readB ; $6cb0
	ret ; $6cb2
.read:
	ld a, [hl] ; $6cb3
	sub b ; $6cb4
	ld [hl], a ; $6cb5
	ret ; $6cb6
.readB:
	ld a, [hl] ; $6cb7
	add b ; $6cb8
	ld [hl], a ; $6cb9
	ret ; $6cba
AdjustDebugStatWord:
	ldh a, [hInputPressed] ; $6cbb
	bit PADB_LEFT, a ; $6cbd
	jr nz, .read ; $6cbf
	bit 4, a ; $6cc1
	jr nz, .readB ; $6cc3
	ret ; $6cc5
.read:
	ld a, [hl+] ; $6cc6
	ld e, a ; $6cc7
	ld d, [hl] ; $6cc8
	ld a, e ; $6cc9
	sub c ; $6cca
	ld e, a ; $6ccb
	ld a, d ; $6ccc
	sbc b ; $6ccd
	ld d, a ; $6cce
	ld a, d ; $6ccf
	ld [hl-], a ; $6cd0
	ld [hl], e ; $6cd1
	ret ; $6cd2
.readB:
	ld a, [hl+] ; $6cd3
	ld e, a ; $6cd4
	ld d, [hl] ; $6cd5
	ld a, e ; $6cd6
	add c ; $6cd7
	ld e, a ; $6cd8
	ld a, d ; $6cd9
	adc b ; $6cda
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
	ld [wPauseMenuItemCount], a ; $6d13
	call DrawStoryMenuItems ; $6d16
	jr .redraw ; $6d19
.inputLoop:
	farcall ReadMatchInputPressed ; $6d1b
	and $0a ; $6d1e
	jr z, .checkA ; $6d20
	sound SFX_MENU_CANCEL ; $6d22
	ld a, MATCHMENUSEL_CANCELLED ; $6d24
	ld [wMatchMenuSelection], a ; $6d26
	jr .done ; $6d29
.checkA:
	farcall ReadMatchInputPressed ; $6d2b
	and $01 ; $6d2e
	jr z, .checkLeftRight ; $6d30
	sound SFX_MENU_SELECT ; $6d32
	jr .done ; $6d34
.checkLeftRight:
	farcall ReadMatchInputRepeat ; $6d36
	and $30 ; $6d39
	jr z, .drawCursor ; $6d3b
	ld b, a ; $6d3d
	ld a, [wPauseMenuItemCount] ; $6d3e
	ld c, a ; $6d41
	ld a, [wMatchMenuSelection] ; $6d42
	call MoveCursorHorizontal ; $6d45
	ld [wMatchMenuSelection], a ; $6d48
	sound SFX_MENU_MOVE ; $6d4b
.redraw:
	ld a, [wMatchMenuSelection] ; $6d4d
	call GetStoryMenuItemId ; $6d50
	push af ; $6d53
	call LoadStoryMenuItemGfx ; $6d54
	pop af ; $6d57
	add LOW(CallHLInBankA + 4) ; $6d58
	ld l, a ; $6d5a
	adc HIGH(CallHLInBankA + 4) ; $6d5b
	sub l ; $6d5d
	ld h, a ; $6d5e
	ld de, $000e ; $6d5f
	call DrawStoryMenuCaption ; $6d62
	call RedrawStoryTilemapRows ; $6d65
.drawCursor:
	call DrawStoryMenuCursor ; $6d68
	call AdvanceFrame ; $6d6b
	jr .inputLoop ; $6d6e
.done:
	call AdvanceFrame ; $6d70
	ret ; $6d73
GetStoryMenuItemId:
	ld b, a ; $6d74
	ld a, [wPauseMenuId] ; $6d75
	add a ; $6d78
	add a ; $6d79
	add a ; $6d7a
	add $e0 ; $6d7b
	ld l, a ; $6d7d
	adc $6c ; $6d7e
	sub l ; $6d80
	ld h, a ; $6d81
	ld a, b ; $6d82
	add l ; $6d83
	ld l, a ; $6d84
	jr nc, .read ; $6d85
	inc h ; $6d87
.read:
	ld a, [hl] ; $6d88
	ret ; $6d89
GetStoryMenuItemCount:
	ld a, [wPauseMenuId] ; $6d8a
	add a ; $6d8d
	add a ; $6d8e
	add a ; $6d8f
	add LOW(StoryMenuDefs + 4) ; $6d90
	ld l, a ; $6d92
	adc HIGH(StoryMenuDefs + 4) ; $6d93
	sub l ; $6d95
	ld h, a ; $6d96
	ld a, [hl] ; $6d97
	ret ; $6d98
DrawStoryMenuItems:
	ld a, [wPauseMenuItemCount] ; $6d99
	add a ; $6d9c
	add LOW(StoryMenuItemPosPointers) ; $6d9d
	ld l, a ; $6d9f
	adc HIGH(StoryMenuItemPosPointers) ; $6da0
	sub l ; $6da2
	ld h, a ; $6da3
	ld a, [hl+] ; $6da4
	ld h, [hl] ; $6da5
	ld l, a ; $6da6
	ld a, [wPauseMenuItemCount] ; $6da7
	ld c, a ; $6daa
	ld b, $00 ; $6dab
.loop:
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
	jr nz, .loop ; $6dbe
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
	ld a, [wPauseMenuItemCount] ; $6ddd
	add a ; $6de0
	add LOW(StoryMenuCursorPosPointers) ; $6de1
	ld l, a ; $6de3
	adc HIGH(StoryMenuCursorPosPointers) ; $6de4
	sub l ; $6de6
	ld h, a ; $6de7
	ld a, [hl+] ; $6de8
	ld h, [hl] ; $6de9
	ld l, a ; $6dea
	ld a, [wMatchMenuSelection] ; $6deb
	add a ; $6dee
	add l ; $6def
	ld l, a ; $6df0
	jr nc, .read ; $6df1
	inc h ; $6df3
.read:
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
	ldh a, [hLinkPayloadKind] ; $6e1d
	push af ; $6e1f
	call AdvanceFrame ; $6e20
	sound SFX_PAUSE_MENU ; $6e23
	xor a ; $6e25
	ld [wMatchMenuSelection], a ; $6e26
	ld a, $02 ; $6e29
	ldh [hLinkPayloadKind], a ; $6e2b
	farcall InitTextWindows ; $6e2d
	ld a, TILEATTR_PRIORITY | TILEATTR_PAL1 ; $6e30
	ld [wWindowTileAttr], a ; $6e32
	set_flag FLAG_HIDE_OVERWORLD_ACTORS ; $6e35
	farcall LoadMatchStoryGfx ; $6e38
	call RestoreStoryTilemapNoPriority ; $6e3b
	ld d, $00 ; $6e3e
	ld e, $0e ; $6e40
	ld b, $13 ; $6e42
	ld c, $03 ; $6e44
	farcall CreateWindowFromScreenRect ; $6e46
	call AdvanceFrame ; $6e49
	wram_bank $05 ; $6e4c
.loop:
	ld hl, ScoreboardModeGfxTail ; $6e52
	ld de, $8640 ; $6e55
	ld c, (MatchMenuItemGfx_Rules - ScoreboardModeGfxTail) / 16 ; $6e58
	call QueueVRAMCopy ; $6e5a
	ld a, $00 ; $6e5d
	ld [wPauseMenuId], a ; $6e5f
	call RunStoryMenu ; $6e62
	ld a, [wMatchMenuSelection] ; $6e65
	cp MATCHMENUSEL_CANCELLED ; $6e68
	jr z, StoryPauseMenu_AfterItem.restoreStoryShadowTilemap ; $6e6a
	push af ; $6e6c
	ld hl, StoryPauseMenu_AfterItem ; $6e6d
	push hl ; $6e70
	ld a, [wMatchMenuSelection] ; $6e71
	rst Rst00 ; $6e74
	dw StoryPauseMenu_PlayerData ; $6e75 jumptable
	dw StoryPauseMenu_GameProgress ; $6e77 jumptable
	dw StoryPauseMenu_Options ; $6e79 jumptable
	dw StoryPauseMenu_SaveQuit ; $6e7b jumptable
StoryPauseMenu_AfterItem:
	ld b, a ; $6e7d
	pop af ; $6e7e
	ld [wMatchMenuSelection], a ; $6e7f
	cp $02 ; $6e82
	jr c, .runStoryModeMenu ; $6e84
	cp $03 ; $6e86
	jr nz, .checkMatchAbortFlag ; $6e88
	ld a, b ; $6e8a
	or a ; $6e8b
	jr nz, .runStoryModeMenu ; $6e8c
.checkMatchAbortFlag:
	ld a, [wMatchAbortFlag] ; $6e8e
	and a ; $6e91
	jr z, RunStoryModeMenu.loop ; $6e92
.restoreStoryShadowTilemap:
	call RestoreStoryShadowTilemap ; $6e94
	call RedrawStoryTilemapRows ; $6e97
	call AdvanceFrame ; $6e9a
	clear_flag FLAG_HIDE_OVERWORLD_ACTORS ; $6e9d
	farcall LoadMenuFontGfxStaged ; $6ea0
	pop af ; $6ea3
	ldh [hLinkPayloadKind], a ; $6ea4
	farcall InitTextWindows ; $6ea6
	farcall InitSceneTileAnimations ; $6ea9
	pop af ; $6eac
	wram_bank ; $6ead
	ret ; $6eb1
.runStoryModeMenu:
	ld a, b ; $6eb2
	cp $ff ; $6eb3
	jp z, RunStoryModeMenu.loop ; $6eb5
	pop af ; $6eb8
	ldh [hLinkPayloadKind], a ; $6eb9
	clear_flag FLAG_HIDE_OVERWORLD_ACTORS ; $6ebb
	farcall InitSceneTileAnimations ; $6ebe
	pop af ; $6ec1
	wram_bank ; $6ec2
	ret ; $6ec6
UnusedStoryMenuRedrawReentry:
	call DrawStoryMenuItemRow ; $6ec7
	ld hl, ScoreboardModeGfxTail ; $6eca
	ld de, $8640 ; $6ecd
	ld c, (MatchMenuItemGfx_Rules - ScoreboardModeGfxTail) / 16 ; $6ed0
	call QueueVRAMCopy ; $6ed2
	jr .checkMatchMenuSelection ; $6ed5
.loop:
	farcall ReadMatchInputPressed ; $6ed7
	and $0e ; $6eda
	jr z, .readMatchInputPressed ; $6edc
	sound SFX_MENU_CANCEL ; $6ede
	ld a, MATCHMENUSEL_CANCELLED ; $6ee0
	ld [wMatchMenuSelection], a ; $6ee2
	jr .advanceFrame ; $6ee5
.readMatchInputPressed:
	farcall ReadMatchInputPressed ; $6ee7
	and $01 ; $6eea
	jr z, .readMatchInputRepeat ; $6eec
	sound SFX_MENU_SELECT ; $6eee
	jr .advanceFrame ; $6ef0
.readMatchInputRepeat:
	farcall ReadMatchInputRepeat ; $6ef2
	and $30 ; $6ef5
	jr z, .checkMatchMenuSelection2 ; $6ef7
	ld b, a ; $6ef9
	ld c, $04 ; $6efa
	ld a, [wMatchMenuSelection] ; $6efc
	call MoveCursorHorizontal ; $6eff
	ld [wMatchMenuSelection], a ; $6f02
	sound SFX_MENU_MOVE ; $6f05
.checkMatchMenuSelection:
	ld a, [wMatchMenuSelection] ; $6f07
	call LoadStoryMenuItemGfx ; $6f0a
	ld a, [wMatchMenuSelection] ; $6f0d
	add LOW(CallHLInBankA + 4) ; $6f10
	ld l, a ; $6f12
	adc HIGH(CallHLInBankA + 4) ; $6f13
	sub l ; $6f15
	ld h, a ; $6f16
	ld de, $000e ; $6f17
	call DrawStoryMenuCaption ; $6f1a
	call RedrawStoryTilemapRows ; $6f1d
.checkMatchMenuSelection2:
	ld a, [wMatchMenuSelection] ; $6f20
	add a ; $6f23
	add LOW(StoryPauseMenuCursorPositions) ; $6f24
	ld l, a ; $6f26
	adc HIGH(StoryPauseMenuCursorPositions) ; $6f27
	sub l ; $6f29
	ld h, a ; $6f2a
	ld a, [hl+] ; $6f2b
	ld d, [hl] ; $6f2c
	ld e, a ; $6f2d
	call QueueStoryMenuCursorSprite ; $6f2e
	call AdvanceFrame ; $6f31
	jr .loop ; $6f34
.advanceFrame:
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
	xor a ; $6f45
	ld [wMatchMenuSelection], a ; $6f46
	ld a, $01 ; $6f49
	ld [wPauseMenuId], a ; $6f4b
	call RunStoryMenu ; $6f4e
	ld a, [wMatchMenuSelection] ; $6f51
	cp MATCHMENUSEL_CANCELLED ; $6f54
	jr z, .restoreStoryTilemapNoPriority ; $6f56
	ld a, [wMatchMenuSelection] ; $6f58
	rst Rst00 ; $6f5b
	dw StoryPauseMenu_CharPartnerData ; $6f5c jumptable
	dw StoryPauseMenu_Equipment ; $6f5e jumptable
.restoreStoryTilemapNoPriority:
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
	ld [wUnusedExitTriggerIdMirror], a ; $6f77
	ld [wStoryModeExitTriggerRequest], a ; $6f7a
	ld a, $01 ; $6f7d
	farcall ShowCharDataScreen ; $6f7f
	xor a ; $6f82
	ret ; $6f83
StoryPauseMenu_Equipment:
	ld hl, wStoryModePlayersXPosition ; $6f84
	ld de, wStoryModeSpawnPosition ; $6f87
	ld bc, $0005 ; $6f8a
	call CopyMemoryBC ; $6f8d
	ld a, $ff ; $6f90
	ld [wStoryModeEntryPoint], a ; $6f92
	ld [wUnusedExitTriggerIdMirror], a ; $6f95
	ld [wStoryModeExitTriggerRequest], a ; $6f98
	farcall ShowEquipmentStatusScreen ; $6f9b
	xor a ; $6f9e
	ret ; $6f9f
StoryPauseMenu_GameProgress:
	ld hl, wStoryModePlayersXPosition ; $6fa0
	ld de, wStoryModeSpawnPosition ; $6fa3
	ld bc, $0005 ; $6fa6
	call CopyMemoryBC ; $6fa9
	ld a, $ff ; $6fac
	ld [wStoryModeEntryPoint], a ; $6fae
	ld [wUnusedExitTriggerIdMirror], a ; $6fb1
	ld [wStoryModeExitTriggerRequest], a ; $6fb4
	farcall ShowGameProgressScreen ; $6fb7
	xor a ; $6fba
	ret ; $6fbb
StoryPauseMenu_Options:
	call RestoreStoryTilemapNoPriority ; $6fbc
	ld a, [wCourtViewLocked] ; $6fbf
	and a ; $6fc2
	xor a ; $6fc3
	ld [wMatchMenuSelection], a ; $6fc4
.loop:
	ld a, $02 ; $6fc7
	ld [wPauseMenuId], a ; $6fc9
	call RunStoryMenu ; $6fcc
	ld a, [wMatchMenuSelection] ; $6fcf
	cp MATCHMENUSEL_CANCELLED ; $6fd2
	jr z, StoryOptionsMenu_AfterItem.done ; $6fd4
	push af ; $6fd6
	ld hl, StoryOptionsMenu_AfterItem ; $6fd7
	push hl ; $6fda
	ld a, [wMatchMenuSelection] ; $6fdb
	rst Rst00 ; $6fde
	dw StoryPauseMenu_MessageSpeed ; $6fdf jumptable
	dw StoryPauseMenu_MusicToggle ; $6fe1 jumptable
StoryOptionsMenu_AfterItem:
	pop af ; $6fe3
	ld [wMatchMenuSelection], a ; $6fe4
	jr StoryPauseMenu_Options.loop ; $6fe7
.done:
	ret ; $6fe9
UnusedRunStoryPlayerDataMenu:
	ld a, STORYMENUITEM_CHAR_DATA ; $6fea
	ld [wStoryMenuFirstItem], a ; $6fec
	ld a, $01 ; $6fef
	ld [wPauseMenuId], a ; $6ff1
	jp RunStoryMenu ; $6ff4
StoryPauseMenu_MessageSpeed:
	ld a, [wMessageSpeed] ; $6ff7
	ld b, a ; $6ffa
	ld a, $02 ; $6ffb
	sub b ; $6ffd
	ld [wMatchMenuSelection], a ; $6ffe
	call RunMessageSpeedMenu ; $7001
	ld a, [wMatchMenuSelection] ; $7004
	cp MATCHMENUSEL_CANCELLED ; $7007
	jr z, .done ; $7009
	ld b, a ; $700b
	ld a, $02 ; $700c
	sub b ; $700e
	ld [wMessageSpeed], a ; $700f
.done:
	ret ; $7012
StoryPauseMenu_MusicToggle:
	ldh a, [hMusic] ; $7013
	and $01 ; $7015
	ld [wMatchMenuSelection], a ; $7017
	call RunMusicOnOffMenu ; $701a
	ld a, [wMatchMenuSelection] ; $701d
	cp MATCHMENUSEL_CANCELLED ; $7020
	jr z, .done ; $7022
	call SetMusicMuted ; $7024
	ldh a, [hMusic] ; $7027
	and $01 ; $7029
	farcall SetStorySlotFlagA ; $702b
.done:
	ret ; $702e
StoryPauseMenu_SaveQuit:
	call RestoreStoryTilemapNoPriority ; $702f
	ld hl, Text_30_370 ; $7032
	ld de, $000e ; $7035
	call DrawStoryMenuCaption ; $7038
	ld a, $02 ; $703b
	ld [wMatchMenuSelection], a ; $703d
	ld a, $05 ; $7040
	ld [wPauseMenuId], a ; $7042
	call RunStoryMenu ; $7045
	ld a, [wMatchMenuSelection] ; $7048
	cp MATCHMENUSEL_CANCELLED ; $704b
	jr z, StoryPauseMenu_ReturnToMainMenu.storeStoryMenuFirstItem ; $704d
	cp $02 ; $704f
	jr z, StoryPauseMenu_ReturnToMainMenu.storeStoryMenuFirstItem ; $7051
	ld a, [wMatchMenuSelection] ; $7053
	cp $01 ; $7056
	jr z, StoryPauseMenu_ReturnToMainMenu ; $7058
	ld a, $01 ; $705a
	ld [wSaveAndQuitRequest], a ; $705c
	ld a, [wMessageSpeed] ; $705f
	res 7, a ; $7062
	ld [wMessageSpeed], a ; $7064
	ld bc, $ffff ; $7067
	farcall SaveStoryReturnPoint ; $706a
	farcall SaveStorySlotWithTimer ; $706d
	ld a, STORYLOC_MAIN_MENU ; $7070
	ld [wStoryModeCurrentLocation], a ; $7072
	ld a, $01 ; $7075
	ld [wStoryModeEntryPoint], a ; $7077
	ld a, $ff ; $707a
	ld [wUnusedExitTriggerIdMirror], a ; $707c
	ld [wStoryModeExitTriggerRequest], a ; $707f
	ld a, $01 ; $7082
	jr StoryPauseMenu_ReturnToMainMenu.done ; $7084
StoryPauseMenu_ReturnToMainMenu:
	call WaitFramesCmd ; $7086
	db $08 ; $7089 inline arg
	ld a, $01 ; $708a
	ld [wMatchExitRequest], a ; $708c
	ld a, MATCHABORT_ALL ; $708f
	ld [wMatchAbortFlag], a ; $7091
	ld a, STORYLOC_MAIN_MENU ; $7094
	ld [wStoryModeCurrentLocation], a ; $7096
	ld a, $01 ; $7099
	ld [wStoryModeEntryPoint], a ; $709b
	ld a, $ff ; $709e
	ld [wUnusedExitTriggerIdMirror], a ; $70a0
	ld [wStoryModeExitTriggerRequest], a ; $70a3
	ld a, $01 ; $70a6
.done:
	ret ; $70a8
.storeStoryMenuFirstItem:
	ld a, $00 ; $70a9
	ret ; $70ab
UnusedRunMessagesMusicMenu:
	ld a, STORYMENUITEM_MESSAGES ; $70ac
	ld [wStoryMenuFirstItem], a ; $70ae
	jp RunStoryTwoOptionMenu ; $70b1
RunMessageSpeedMenu:
	ld a, STORYMENUITEM_MSG_SLOW ; $70b4
	ld [wStoryMenuFirstItem], a ; $70b6
	jp RunStoryThreeOptionMenu ; $70b9
RunMusicOnOffMenu:
	ld a, STORYMENUITEM_MUSIC_ON ; $70bc
	ld [wStoryMenuFirstItem], a ; $70be
	jp RunStoryTwoOptionMenu ; $70c1
UnusedRunSaveQuitMenu:
	ld a, STORYMENUITEM_SAVE_GAME ; $70c4
	ld [wStoryMenuFirstItem], a ; $70c6
	jp RunStoryTwoOptionMenu ; $70c9
RunStoryTwoOptionMenu:
	ld a, [wStoryMenuFirstItem] ; $70cc
	ld de, $050a ; $70cf
	call DrawStoryMenuItem ; $70d2
	ld a, [wStoryMenuFirstItem] ; $70d5
	inc a ; $70d8
	ld de, $0b0a ; $70d9
	call DrawStoryMenuItem ; $70dc
	ld a, [wStoryMenuFirstItem] ; $70df
	cp STORYMENUITEM_SAVE_GAME ; $70e2
	jr z, .redrawStoryTilemapRows ; $70e4
	ld hl, wMatchMenuSelection ; $70e6
	add [hl] ; $70e9
	ld hl, $0162 ; $70ea
	add l ; $70ed
	ld l, a ; $70ee
	jr nc, .drawStoryMenuCaption ; $70ef
	inc h ; $70f1
.drawStoryMenuCaption:
	ld de, $000e ; $70f2
	call DrawStoryMenuCaption ; $70f5
.redrawStoryTilemapRows:
	call RedrawStoryTilemapRows ; $70f8
	ld a, [wMatchMenuSelection] ; $70fb
	ld hl, wStoryMenuFirstItem ; $70fe
	add [hl] ; $7101
	call LoadStoryMenuItemGfx ; $7102
.loop:
	farcall ReadMatchInputPressed ; $7105
	and $02 ; $7108
	jr z, .readMatchInputPressed ; $710a
	sound SFX_MENU_CANCEL ; $710c
	ld a, MATCHMENUSEL_CANCELLED ; $710e
	ld [wMatchMenuSelection], a ; $7110
	jr .advanceFrame ; $7113
.readMatchInputPressed:
	farcall ReadMatchInputPressed ; $7115
	and $01 ; $7118
	jr z, .readMatchInputRepeat ; $711a
	sound SFX_MENU_SELECT ; $711c
	jr .advanceFrame ; $711e
.readMatchInputRepeat:
	farcall ReadMatchInputRepeat ; $7120
	and $30 ; $7123
	jr z, .checkMatchMenuSelection2 ; $7125
	ld b, a ; $7127
	ld c, $02 ; $7128
	ld a, [wMatchMenuSelection] ; $712a
	call MoveCursorHorizontal ; $712d
	ld [wMatchMenuSelection], a ; $7130
	sound SFX_MENU_MOVE ; $7133
	ld a, [wStoryMenuFirstItem] ; $7135
	cp STORYMENUITEM_SAVE_GAME ; $7138
	jr z, .checkMatchMenuSelection ; $713a
	ld hl, wMatchMenuSelection ; $713c
	add [hl] ; $713f
	ld hl, $0162 ; $7140
	add l ; $7143
	ld l, a ; $7144
	jr nc, .drawStoryMenuCaption2 ; $7145
	inc h ; $7147
.drawStoryMenuCaption2:
	ld de, $000e ; $7148
	call DrawStoryMenuCaption ; $714b
	call RedrawStoryTilemapRows ; $714e
.checkMatchMenuSelection:
	ld a, [wMatchMenuSelection] ; $7151
	ld hl, wStoryMenuFirstItem ; $7154
	add [hl] ; $7157
	call LoadStoryMenuItemGfx ; $7158
.checkMatchMenuSelection2:
	ld a, [wMatchMenuSelection] ; $715b
	add a ; $715e
	add LOW(StoryTwoOptionCursorPositions) ; $715f
	ld l, a ; $7161
	adc HIGH(StoryTwoOptionCursorPositions) ; $7162
	sub l ; $7164
	ld h, a ; $7165
	ld a, [hl+] ; $7166
	ld d, [hl] ; $7167
	ld e, a ; $7168
	call QueueStoryMenuCursorSprite ; $7169
	call AdvanceFrame ; $716c
	jp .loop ; $716f
.advanceFrame:
	call AdvanceFrame ; $7172
	ret ; $7175
StoryTwoOptionCursorPositions:
	; $7176, 4 bytes (bytes:2)
	db $60, $18 ; 0x00
	db $60, $48 ; 0x02
RunStoryThreeOptionMenu:
	call RestoreStoryTilemapNoPriority ; $717a
	ld a, [wStoryMenuFirstItem] ; $717d
	ld de, $030a ; $7180
	call DrawStoryMenuItem ; $7183
	ld a, [wStoryMenuFirstItem] ; $7186
	inc a ; $7189
	ld de, $080a ; $718a
	call DrawStoryMenuItem ; $718d
	ld a, [wStoryMenuFirstItem] ; $7190
	inc a ; $7193
	inc a ; $7194
	ld de, $0d0a ; $7195
	call DrawStoryMenuItem ; $7198
	ld a, [wStoryMenuFirstItem] ; $719b
	cp $06 ; $719e
	ld hl, wMatchMenuSelection ; $71a0
	add [hl] ; $71a3
	ld hl, $0162 ; $71a4
	add l ; $71a7
	ld l, a ; $71a8
	jr nc, .drawStoryMenuCaption ; $71a9
	inc h ; $71ab
.drawStoryMenuCaption:
	ld de, $000e ; $71ac
	call DrawStoryMenuCaption ; $71af
	call RedrawStoryTilemapRows ; $71b2
	ld a, [wMatchMenuSelection] ; $71b5
	ld hl, wStoryMenuFirstItem ; $71b8
	add [hl] ; $71bb
	call LoadStoryMenuItemGfx ; $71bc
.loop:
	farcall ReadMatchInputPressed ; $71bf
	and $02 ; $71c2
	jr z, .readMatchInputPressed ; $71c4
	sound SFX_MENU_CANCEL ; $71c6
	ld a, MATCHMENUSEL_CANCELLED ; $71c8
	ld [wMatchMenuSelection], a ; $71ca
	jr .restoreStoryTilemapNoPriority ; $71cd
.readMatchInputPressed:
	farcall ReadMatchInputPressed ; $71cf
	and $01 ; $71d2
	jr z, .readMatchInputRepeat ; $71d4
	sound SFX_MENU_SELECT ; $71d6
	jr .restoreStoryTilemapNoPriority ; $71d8
.readMatchInputRepeat:
	farcall ReadMatchInputRepeat ; $71da
	and $30 ; $71dd
	jr z, .checkMatchMenuSelection ; $71df
	ld b, a ; $71e1
	ld c, $03 ; $71e2
	ld a, [wMatchMenuSelection] ; $71e4
	call MoveCursorHorizontal ; $71e7
	ld [wMatchMenuSelection], a ; $71ea
	sound SFX_MENU_MOVE ; $71ed
	ld a, [wStoryMenuFirstItem] ; $71ef
	cp $06 ; $71f2
	ld hl, wMatchMenuSelection ; $71f4
	add [hl] ; $71f7
	ld hl, $0162 ; $71f8
	add l ; $71fb
	ld l, a ; $71fc
	jr nc, .drawStoryMenuCaption2 ; $71fd
	inc h ; $71ff
.drawStoryMenuCaption2:
	ld de, $000e ; $7200
	call DrawStoryMenuCaption ; $7203
	call RedrawStoryTilemapRows ; $7206
	ld a, [wMatchMenuSelection] ; $7209
	ld hl, wStoryMenuFirstItem ; $720c
	add [hl] ; $720f
	call LoadStoryMenuItemGfx ; $7210
.checkMatchMenuSelection:
	ld a, [wMatchMenuSelection] ; $7213
	add a ; $7216
	add LOW(StoryThreeOptionCursorPositions) ; $7217
	ld l, a ; $7219
	adc HIGH(StoryThreeOptionCursorPositions) ; $721a
	sub l ; $721c
	ld h, a ; $721d
	ld a, [hl+] ; $721e
	ld d, [hl] ; $721f
	ld e, a ; $7220
	call QueueStoryMenuCursorSprite ; $7221
	call AdvanceFrame ; $7224
	jp .loop ; $7227
.restoreStoryTilemapNoPriority:
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
	xor a ; $7253
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
.loop:
	res 7, [hl] ; $727a
	inc hl ; $727c
	dec bc ; $727d
	ld a, b ; $727e
	or c ; $727f
	jr nz, .loop ; $7280
	ret ; $7282
LoadStoryMenuItemGfx:
	add a ; $7283
	add LOW(StoryMenuItemGfxPointers) ; $7284
	ld l, a ; $7286
	adc HIGH(StoryMenuItemGfxPointers) ; $7287
	sub l ; $7289
	ld h, a ; $728a
	ld a, [hl+] ; $728b
	ld h, [hl] ; $728c
	ld l, a ; $728d
	ld de, wDecompBuffer ; $728e
	ldh a, [hWramBank] ; $7291
	push af ; $7293
	wram_bank $01 ; $7294
	call DecompressData ; $729a
	ld hl, wDecompBuffer ; $729d
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
	add $fc ; $72cf
	ld d, a ; $72d1
	call AdjustSpriteCoordsForScroll ; $72d2
	ld hl, QueueStoryMenuCursorSprite_SpriteTemplate ; $72d5
	ld bc, $0000 ; $72d8
	call QueueSpriteTemplate ; $72db
	ret ; $72de
QueueStoryMenuCursorSprite_SpriteTemplate:
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
	INCBIN "data/bank_006/lz_7310.bin" ; $7310, 160 bytes
StoryMenuItemGfx_ClearStatus:
	INCBIN "data/bank_006/lz_73b0.bin" ; $73b0, 183 bytes
StoryMenuItemGfx_Messages:
	INCBIN "data/bank_006/lz_7467.bin" ; $7467, 171 bytes
StoryMenuItemGfx_Slow:
	INCBIN "data/bank_006/lz_7512.bin" ; $7512, 118 bytes
StoryMenuItemGfx_Fast:
	INCBIN "data/bank_006/lz_7588.bin" ; $7588, 121 bytes
StoryMenuItemGfx_CharData:
	INCBIN "data/bank_006/lz_7601.bin" ; $7601, 175 bytes
StoryMenuItemGfx_Items:
	INCBIN "data/bank_006/lz_76b0.bin" ; $76b0, 125 bytes
StoryMenuItemGfx_Normal:
	INCBIN "data/bank_006/lz_772d.bin" ; $772d, 121 bytes
DrawStoryMenuItem:
	push de ; $77a6
	add a ; $77a7
	add LOW(StoryMenuItemRectPointers) ; $77a8
	ld l, a ; $77aa
	adc HIGH(StoryMenuItemRectPointers) ; $77ab
	sub l ; $77ad
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
StoryMenuItemRowTextRect:
	; $784b, 24 bytes (tilemap:12)
	tilemap_begin 12, 2
	tilemap_row $49, $4a, $4b, $14, $15, $16, $17, $18, $19, $1a, $1b, $1c ; row 0
	tilemap_row $59, $5a, $5b, $24, $25, $26, $27, $28, $29, $2a, $2b, $2c ; row 1
	tilemap_end
DrawStoryMenuItemRow:
	ld de, $030a ; $7863
	call GetShadowTilemapAddr ; $7866
	ld hl, StoryMenuItemRowTextRect ; $7869
	ld bc, $0c02 ; $786c
	call CopyTileRectToShadowTilemap ; $786f
	ld de, $030a ; $7872
	call GetShadowAttrmapAddr ; $7875
	ld hl, TextRectAttrs_06 ; $7878
	ld bc, $0c02 ; $787b
	call CopyTileRectToShadowAttrmap ; $787e
	ret ; $7881
CopyTileRectToShadowTilemap:
	push bc ; $7882
	push de ; $7883
.loop:
	ld a, [hl+] ; $7884
	and a ; $7885
	ld [de], a ; $7886
	inc de ; $7887
	push hl ; $7888
	ld a, e ; $7889
	and $1f ; $788a
	jr nz, .restore ; $788c
	ld h, d ; $788e
	ld l, e ; $788f
	ld de, $ffe0 ; $7890
	add hl, de ; $7893
	ld d, h ; $7894
	ld e, l ; $7895
.restore:
	pop hl ; $7896
	dec b ; $7897
	jr nz, .loop ; $7898
	pop de ; $789a
	pop bc ; $789b
	ld a, $20 ; $789c
	add e ; $789e
	ld e, a ; $789f
	jr nc, .gotPtr ; $78a0
	inc d ; $78a2
.gotPtr:
	ld a, d ; $78a3
	and $f3 ; $78a4
	ld d, a ; $78a6
	dec c ; $78a7
	jr nz, CopyTileRectToShadowTilemap ; $78a8
	ret ; $78aa
CopyTileRectToShadowAttrmap:
	push bc ; $78ab
	push de ; $78ac
.loop:
	ld a, [hl+] ; $78ad
	and a ; $78ae
	ld [de], a ; $78af
	inc de ; $78b0
	push hl ; $78b1
	ld a, e ; $78b2
	and $1f ; $78b3
	jr nz, .restore ; $78b5
	ld h, d ; $78b7
	ld l, e ; $78b8
	ld de, $ffe0 ; $78b9
	add hl, de ; $78bc
	ld d, h ; $78bd
	ld e, l ; $78be
.restore:
	pop hl ; $78bf
	dec b ; $78c0
	jr nz, .loop ; $78c1
	pop de ; $78c3
	pop bc ; $78c4
	ld a, $20 ; $78c5
	add e ; $78c7
	ld e, a ; $78c8
	jr nc, .gotPtr ; $78c9
	inc d ; $78cb
.gotPtr:
	ld a, d ; $78cc
	cp $d8 ; $78cd
	jr c, .ltd8 ; $78cf
	ld d, $d4 ; $78d1
.ltd8:
	dec c ; $78d3
	jr nz, CopyTileRectToShadowAttrmap ; $78d4
	ret ; $78d6
	; $78d7, 1833 bytes fill to bank end (linker-padded)
