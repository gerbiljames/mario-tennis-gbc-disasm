	farptr RunMatchPauseMenu ; $4000
	farptr Unused_06_RunDebugStatsEditor ; $4002
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
	ld de, vTiles0 + $64 * TILE_SIZE ; $4020
	ld c, (MatchMenuItemGfx_Rules - ScoreboardModeGfxTail) / 16 ; $4023
	call QueueVRAMCopy ; $4025
	farcall StepMatchFrame ; $4028
	wram_bank WRAM_COURT_PLANES ; $402b
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
	pop_wram_bank ; $406e
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
	ld de, vTiles0 + $64 * TILE_SIZE ; $4096
	ld c, (MatchMenuItemGfx_Rules - ScoreboardModeGfxTail) / 16 ; $4099
	call QueueVRAMCopy ; $409b
	farcall StepMatchFrame ; $409e
	wram_bank WRAM_COURT_PLANES ; $40a1
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
	pop_wram_bank ; $410a
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
	cp MATCHCONTEXT_MINIGAME ; $4128
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
	ld_de_indexed Text_26_37 ; $413f
	ld hl, wRulesTitleTextId ; $4146
	ld a, e ; $4149
	ld [hl+], a ; $414a
	ld [hl], d ; $414b
	ld de, Text_26_98 ; $414c
	ld hl, wRulesFirstPageTextId ; $414f
	ld a, e ; $4152
	ld [hl+], a ; $4153
	ld [hl], d ; $4154
	ld a, [wRulesPageListIndex] ; $4155
	add a ; $4158
	add a ; $4159
	ld_hl_indexed MatchRulesPageLists ; $415a
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
	ld_de_indexed Text_26_43 ; $4183
	ld hl, wRulesTitleTextId ; $418a
	ld a, e ; $418d
	ld [hl+], a ; $418e
	ld [hl], d ; $418f
	ld de, Text_26_106 ; $4190
	ld hl, wRulesFirstPageTextId ; $4193
	ld a, e ; $4196
	ld [hl+], a ; $4197
	ld [hl], d ; $4198
	ld a, [wRulesPageListIndex] ; $4199
	add a ; $419c
	add a ; $419d
	ld_hl_indexed TrainingRulesPageLists ; $419e
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
	ld_de_indexed Text_26_71 ; $422d
	ld hl, wRulesTitleTextId ; $4234
	ld a, e ; $4237
	ld [hl+], a ; $4238
	ld [hl], d ; $4239
	ld a, [wCurrentMinigameStoryMatch + 1] ; $423a
	sub MINIGAME_BOO_BLAST ; $423d
	add a ; $423f
	ld_hl_indexed MinigameRulesTextIdBases ; $4240
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
	ld_hl_indexed MinigameRulesPageLists ; $4257
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
	ld_cell de, $00, $02 ; $4333
	call DrawMenuCaptionWindow ; $4336
	ld_cell de, $00, $05 ; $4339
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
	ld_cell de, $01, $06 ; $434e
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
	ld_xy de, $90, $80 ; $4373
	farcall AddBobbingOffsetY ; $4376
	ld_oam bc, OAM_BANK1 | 2, $70 ; $4379
	call QueueSprite16 ; $437c
	ret ; $437f
MatchPauseMenu_ReviewControls:
	ld hl, DrawScoreboardSprites ; $4380
	call UnregisterFrameTask ; $4383
	call RestoreBgTilemap ; $4386
	ld_cell de, $00, $02 ; $4389
	ld bc, $130e ; $438c
	call DrawWindowFrameAt ; $438f
	farcall PrepareGlyphBuffer ; $4392
	ld_cell de, $01, $03 ; $4395
	ld hl, Text_30_343 ; $4398
	call DrawMenuTextLine ; $439b
	ld_cell de, $06, $0a ; $439e
	ld hl, Text_30_344 ; $43a1
	call DrawMenuTextLine ; $43a4
	ld_cell de, $01, $0c ; $43a7
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
	push_wram_bank WRAM_CHAR0 ; $43cc
	ld hl, wCharInputSource ; $43d5
	ld a, [hl] ; $43d8
	xor $01 ; $43d9
	ld [hl], a ; $43db
	pop_wram_bank ; $43dc
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
	ld_hl_indexed SaveQuitMenuIdByGameMode ; $4468
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
