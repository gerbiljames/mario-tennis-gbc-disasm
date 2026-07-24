SECTION "ROM Bank $08", ROMX[$4000], BANK[$08]

	farptr InitDefaultMatchSettings ; $4000
	farptr ResetMatchState ; $4002
	farptr RunMatch ; $4004
	farptr InitMinigameMatchSettings ; $4006
	farptr RunMinigameMatch ; $4008
	farptr UpdateMatchFrame ; $400a
	farptr InitChar ; $400c
	farptr ClearSpriteSlots ; $400e
	farptr DrawCharSprite ; $4010
	farptr StepCharAnimation ; $4012
	farptr ReloadCharFacingTiles ; $4014
	farptr BuildCharSpriteSlots ; $4016
	farptr UpdateCharFacingOctant ; $4018
	farptr EaseCharFacing ; $401a
	farptr SetCharState ; $401c
	farptr ReloadCharFrameGfx ; $401e
	farptr SetCharAnimation ; $4020
	farptr SetCharPosAndTarget ; $4022
	farptr SetBallTrailColor ; $4024
	farptr SetBallVelocityPolar ; $4026
	farptr SetBallSpinComponents ; $4028
	farptr CheckBallOutOfBounds ; $402a
	farptr FindServerCharBank ; $402c
	farptr SetCameraTarget ; $402e
	farptr PredictBallXAtDepth ; $4030
	farptr MulHLByTangent ; $4032
	farptr StartBounceEffect ; $4034
	farptr AdvanceMatchRng ; $4036
	farptr ReadMatchInputHeld ; $4038
	farptr ReadMatchInputPressed ; $403a
	farptr ReadMatchInputRepeat ; $403c
	farptr StepMatchFrame ; $403e
	farptr StepMatchFrames ; $4040
	farptr StepMatchFramesSkippable ; $4042
	farptr ProjectWorldToScreen_08 ; $4044
	farptr ApplyCameraProjection ; $4046
	farptr SetModeHookTable ; $4048
	farptr SetMinigamePointTable ; $404a
	farptr SetBallGatePoint1 ; $404c
	farptr SetBallGatePoint2 ; $404e
	farptr DidBallCrossGate ; $4050
	farptr SetTargetZoneCorner1 ; $4052
	farptr SetTargetZoneCorner2 ; $4054
	farptr IsBallInTargetZone ; $4056
	farptr ResolvePointWinner ; $4058
	farptr UpdatePointStats ; $405a
	farptr AwardPoint ; $405c
	farptr StartPointEndReactions ; $405e
	farptr ResolvePointOutcome ; $4060
	farptr SetBallPosition ; $4062
	farptr HandleServeFault ; $4064
	farptr SetCharTarget ; $4066
	farptr SelectRallyShotType ; $4068
	farptr RunMatchFramesUntilInput ; $406a
	farptr CharPointEndReaction ; $406c
	farptr MulMem24ByFrac ; $406e
InitDefaultMatchSettings:
	xor a, a ; $4070
	ld [wKeepMatchStatsFlag], a ; $4071
	ld hl, wMatchMenuSelection ; $4074
	ld c, $02 ; $4077
	call ClearMemory16 ; $4079
	ld hl, wMatchTypeNumberOfSets ; $407c
	ld c, $01 ; $407f
	call ClearMemory16 ; $4081
	ld hl, $c780 ; $4084
	ld c, $08 ; $4087
	call ClearMemory16 ; $4089
	ld a, $00 ; $408c
	ld [wCurrentlyUsedCourt], a ; $408e
	ld a, $01 ; $4091
	ld [wMatchTypeNumberOfSets], a ; $4093
	ld a, $02 ; $4096
	ld [wMatchTypeNumberOfGames], a ; $4098
	ld a, $00 ; $409b
	ld [wMatchIsDoubles], a ; $409d
	ld a, $02 ; $40a0
	ld [wOnCourtCharCount], a ; $40a2
	ld a, $11 ; $40a5
	ld [wMatchBGM], a ; $40a7
	ret ; $40aa
ResetMatchState:
	wram_bank $04 ; $40ab
	ld hl, $c400 ; $40b1
	ld c, $0e ; $40b4
	call ClearMemory16 ; $40b6
	ld a, [wKeepMatchStatsFlag] ; $40b9
	and a, a ; $40bc
	jr nz, Label_08_40c7 ; $40bd
	ld hl, wCharacter1ServiceAces ; $40bf
	ld c, $03 ; $40c2
	call ClearMemory16 ; $40c4
Label_08_40c7:
	xor a, a ; $40c7
	ld [wKeepMatchStatsFlag], a ; $40c8
	ld a, $ff ; $40cb
	ld [wMatchSimFrozen], a ; $40cd
	ld a, $01 ; $40d0
	ld [wPauseDisabled], a ; $40d2
	xor a, a ; $40d5
	ld [wPlayer1PointsWon], a ; $40d6
	ld [wPlayer2PointsWon], a ; $40d9
	ld [wTotalPointsScoredInCurrentGame], a ; $40dc
	ld [wServeFaultFlag], a ; $40df
	ld [wDeuceIndicator], a ; $40e2
	ld de, $fe50 ; $40e5
	ld hl, wCourtLimitX ; $40e8
	ld a, e ; $40eb
	ld [hl+], a ; $40ec
	ld [hl], d ; $40ed
	ld de, $fb20 ; $40ee
	ld hl, wCourtLimitDepth ; $40f1
	ld a, e ; $40f4
	ld [hl+], a ; $40f5
	ld [hl], d ; $40f6
	ld de, $0060 ; $40f7
	ld hl, wNetHeight ; $40fa
	ld a, e ; $40fd
	ld [hl+], a ; $40fe
	ld [hl], d ; $40ff
	ld a, [wMatchIsDoubles] ; $4100
	and a, a ; $4103
	ld bc, $0220 ; $4104
	jr z, Label_08_410c ; $4107
	ld bc, $0320 ; $4109
Label_08_410c:
	ld hl, wAimSpreadBase ; $410c
	ld a, c ; $410f
	ld [hl+], a ; $4110
	ld [hl], b ; $4111
	ld a, [wOnCourtCharCount] ; $4112
	dec a ; $4115
	and a, $03 ; $4116
	ld [wOnCourtCharCountMinus1], a ; $4118
	ld a, [wMatchTypeNumberOfSets] ; $411b
	srl a ; $411e
	ld [wRulesSetsIndex], a ; $4120
	ld a, [wMatchTypeNumberOfGames] ; $4123
	rrca ; $4126
	rrca ; $4127
	and a, $01 ; $4128
	ld [wRulesGamesIndex], a ; $412a
	call Func_08_454b ; $412d
	ld a, [wGameMode] ; $4130
	cp a, $09 ; $4133
	ldh a, [hVBlankCounter] ; $4135
	jr nz, Label_08_413b ; $4137
	ld a, $00 ; $4139
Label_08_413b:
	ld [wMatchRngState], a ; $413b
	xor a, a ; $413e
	ldh [$ffe9], a ; $413f
	xor a, a ; $4141
	ldh [$ffdd], a ; $4142
	ret ; $4144
InitMatchScene:
	call ClearFrameTasks ; $4145
	farcall ResetTextWindowState ; $4148
	ld a, $02 ; $414b
	ld [wShadowTilemapBank], a ; $414d
	ld a, $00 ; $4150
	ld [wWindowTileAttr], a ; $4152
	call ResetMatchState ; $4155
	call InitViewFlipPreference ; $4158
	call ApplyMatchBgmPreference ; $415b
	call LoadCourtSceneData ; $415e
	wram_bank $04 ; $4161
	call ResetBallState ; $4167
	call InitAllChars ; $416a
	farcall InitAllObjSlots ; $416d
	call ClearSpriteSlots ; $4170
	call AssignCourtPositions ; $4173
	xor a, a ; $4176
	ld [wChangeEndsPending], a ; $4177
	farcall UpdatePointDigitsDisplay ; $417a
	call RefreshCourtScoreboard ; $417d
	call UploadCourtTilemap ; $4180
	call UploadCourtAttrmap ; $4183
	farcall LoadMatchGraphics ; $4186
	wram_bank $04 ; $4189
	ret ; $418f
RunMatch:
	ld c, $20 ; $4190
	call BeginFadeOut ; $4192
	call WaitFadeEnd ; $4195
	call AdvanceFrame ; $4198
	call DisableLCDSafely ; $419b
	call InitMatchScene ; $419e
	call EnableLCD ; $41a1
	farcall UpdateLinkSession ; $41a4
	ld a, [wMatchBGM] ; $41a7
	call PlaySoundManaged ; $41aa
	ld hl, $c780 ; $41ad
	ld c, $08 ; $41b0
	call ClearMemory16 ; $41b2
	ld a, $ff ; $41b5
	ld [$c7b5], a ; $41b7
	script_fade_in $20 ; $41ba
	wram_bank $04 ; $41bf
	call PlayCourtIntro ; $41c5
	xor a, a ; $41c8
	ld [wMatchSimFrozen], a ; $41c9
	call RunMatchPlayLoop ; $41cc
	ldh a, [hLinkState] ; $41cf
	ld [$c493], a ; $41d1
	farcall EndLinkSession ; $41d4
	ld a, [wGameMode] ; $41d7
	cp a, $08 ; $41da
	call z, ShowMatchResultScreens ; $41dc
	ld c, $20 ; $41df
	call BeginFadeOut ; $41e1
	call WaitFadeEnd ; $41e4
	call AdvanceFrame ; $41e7
	farcall RunMatchWinLoseScreen ; $41ea
	farcall LoadMenuFontGfx ; $41ed
	call AdvanceFrame ; $41f0
	farcall ProcessMatchRewards ; $41f3
	ret ; $41f6
UpdateMatchFrame:
	wram_bank $04 ; $41f7
	ld a, [wMatchSimFrozen] ; $41fd
	and a, a ; $4200
	jr nz, Label_08_4226 ; $4201
	call ClearSpriteSlots ; $4203
	call UpdateMatchCamera ; $4206
	call UpdateAllChars ; $4209
	call HandleBallHitEvent ; $420c
	call HandleBallTouchCharEvent ; $420f
	call UpdateBallVisuals ; $4212
	call TickRallyTimers ; $4215
	call HandleBallBounceEvent ; $4218
	ld d, $00 ; $421b
	call CallModeHook ; $421d
	ld hl, $0902 ; $4220
	call FarCallVector ; $4223
Label_08_4226:
	ld a, [wMatchDrawFrozen] ; $4226
	and a, a ; $4229
	jr nz, Label_08_422f ; $422a
	call DrawActorsByDepth ; $422c
Label_08_422f:
	ld a, [wMatchSimFrozen] ; $422f
	and a, a ; $4232
	jr nz, Label_08_4238 ; $4233
	farcall UpdateMinigameTargets ; $4235
Label_08_4238:
	ld a, [wMatchDrawFrozen] ; $4238
	and a, a ; $423b
	jr nz, Label_08_4241 ; $423c
	call DrawMarkersAndShadows ; $423e
Label_08_4241:
	ret ; $4241
TickRallyTimers:
	ld a, [wBallCrossedNetFlag] ; $4242
	and a, a ; $4245
	ret z ; $4246
	ld hl, $c4b5 ; $4247
	ld a, [hl] ; $424a
	cp a, $64 ; $424b
	jr nc, Label_08_4250 ; $424d
	inc [hl] ; $424f
Label_08_4250:
	ld a, [wRallyLength] ; $4250
	cp a, $01 ; $4253
	jr nz, Label_08_426e ; $4255
	ld a, [wPointOutcome] ; $4257
	and a, a ; $425a
	jr nz, Label_08_4262 ; $425b
	ld a, $01 ; $425d
	ld [wCameraFollowBall], a ; $425f
Label_08_4262:
	ld a, [wBallHasBouncedFlag] ; $4262
	and a, a ; $4265
	jr z, Label_08_426e ; $4266
	ld hl, $4274 ; $4268
	call ForEachCharBank ; $426b
Label_08_426e:
	ld d, $06 ; $426e
	call CallModeHook ; $4270
	ret ; $4273
	ld a, $05 ; $4274
	call SetCharState ; $4276
	ret ; $4279
HandleBallHitEvent:
	ld a, [wBallHitEvent] ; $427a
	and a, a ; $427d
	ret z ; $427e
	ld hl, wRallyLength ; $427f
	ld a, [hl] ; $4282
	cp a, $64 ; $4283
	jr nc, Label_08_4288 ; $4285
	inc [hl] ; $4287
Label_08_4288:
	xor a, a ; $4288
	ld [wBallHitEvent], a ; $4289
	ld [wBallHasBouncedFlag], a ; $428c
	ld [wLandingMarkerActive], a ; $428f
	call StartLandingMarker ; $4292
	call StartHitEffect ; $4295
	wram_bank $07 ; $4298
	call SetCharStateOnBallHit ; $429e
	wram_bank $06 ; $42a1
	call SetCharStateOnBallHit ; $42a7
	wram_bank $05 ; $42aa
	call SetCharStateOnBallHit ; $42b0
	wram_bank $04 ; $42b3
	call SetCharStateOnBallHit ; $42b9
	call Func_08_4326 ; $42bc
	ld d, $04 ; $42bf
	call CallModeHook ; $42c1
	xor a, a ; $42c4
	ld [wBallBounceCount], a ; $42c5
	ld a, [wRallyLength] ; $42c8
	cp a, $01 ; $42cb
	jr z, Label_08_42d4 ; $42cd
	cp a, $02 ; $42cf
	jr z, Label_08_42f3 ; $42d1
	ret ; $42d3
Label_08_42d4:
	ld a, [wSpecialShotFlag] ; $42d4
	and a, a ; $42d7
	jr z, Label_08_42f2 ; $42d8
	ld a, $0e ; $42da
	farcall ShowCourtBanner ; $42dc
	ld a, [wServingCharCourtPos] ; $42df
	and a, $02 ; $42e2
	ld de, $f0d8 ; $42e4
	jr z, Label_08_42ec ; $42e7
	ld de, $f000 ; $42e9
Label_08_42ec:
	ld bc, $ddb0 ; $42ec
	farcall SetObjPosition ; $42ef
Label_08_42f2:
	ret ; $42f2
Label_08_42f3:
	ld de, $fb20 ; $42f3
	ld hl, wCourtLimitDepth ; $42f6
	ld a, e ; $42f9
	ld [hl+], a ; $42fa
	ld [hl], d ; $42fb
	ld a, [wMatchIsDoubles] ; $42fc
	and a, a ; $42ff
	ld de, $fe50 ; $4300
	jr z, Label_08_4308 ; $4303
	ld de, $fdc0 ; $4305
Label_08_4308:
	ld hl, wCourtLimitX ; $4308
	ld a, e ; $430b
	ld [hl+], a ; $430c
	ld [hl], d ; $430d
	ret ; $430e
SetCharStateOnBallHit:
	ld a, [wCharState] ; $430f
	add a, $1e ; $4312
	ld l, a ; $4314
	adc a, $43 ; $4315
	sub a, l ; $4317
	ld h, a ; $4318
	ld a, [hl] ; $4319
	call SetCharState ; $431a
	ret ; $431d
	; $431e, 8 bytes (bytes:8)
	db $00, $02, $01, $02, $02, $01, $06, $07 ; 0x00
Func_08_4326:
	ld a, [wRallyLength] ; $4326
	cp a, $02 ; $4329
	jr nz, Label_08_4348 ; $432b
	ld a, [wPointOutcome] ; $432d
	and a, a ; $4330
	jr nz, Label_08_4348 ; $4331
	ld b, $08 ; $4333
	ld c, $ff ; $4335
	ld a, [wLastShotServeRole] ; $4337
	cp a, $01 ; $433a
	jr nz, Label_08_4349 ; $433c
	ld b, $07 ; $433e
	ld c, $ff ; $4340
	ld a, [wBallBounceCount] ; $4342
	and a, a ; $4345
	jr z, Label_08_4349 ; $4346
Label_08_4348:
	ret ; $4348
Label_08_4349:
	ld a, b ; $4349
	ld [wPointOutcome], a ; $434a
	ld a, c ; $434d
	ld [wPointOutcomeSide], a ; $434e
	ret ; $4351
HandleBallBounceEvent:
	ld a, [wBallBounceEvent] ; $4352
	and a, a ; $4355
	ret z ; $4356
	ld a, [wBallBounceCount] ; $4357
	cp a, $02 ; $435a
	jr nc, Label_08_4360 ; $435c
	sound $5b ; $435e
Label_08_4360:
	ld hl, wBallBounceCount ; $4360
	ld a, [hl] ; $4363
	cp a, $0a ; $4364
	jr nc, Label_08_4369 ; $4366
	inc [hl] ; $4368
Label_08_4369:
	xor a, a ; $4369
	ld [wLandingMarkerActive], a ; $436a
	call StartBounceEffect ; $436d
	call EvaluateBounceOutcome ; $4370
	ld d, $05 ; $4373
	call CallModeHook ; $4375
	ret ; $4378
EvaluateBounceOutcome:
	ld a, [wRallyLength] ; $4379
	and a, a ; $437c
	jr z, Label_08_43c9 ; $437d
	ld a, [wPointOutcome] ; $437f
	and a, a ; $4382
	jr nz, Label_08_43c9 ; $4383
	ld b, $06 ; $4385
	ld c, $01 ; $4387
	ld a, [wBallBounceCount] ; $4389
	cp a, $01 ; $438c
	jr nz, Label_08_43ca ; $438e
	ld b, $04 ; $4390
	ld c, $ff ; $4392
	ld hl, wBallQuadrantAtHit ; $4394
	ld a, [wBallCourtQuadrant] ; $4397
	xor a, [hl] ; $439a
	and a, $02 ; $439b
	jr z, Label_08_43ca ; $439d
	call CheckBallOutOfBounds ; $439f
	ld b, $05 ; $43a2
	ld c, $ff ; $43a4
	and a, a ; $43a6
	jr nz, Label_08_43ca ; $43a7
	ld a, [wRallyLength] ; $43a9
	cp a, $01 ; $43ac
	jr nz, Label_08_43c9 ; $43ae
	ld b, $05 ; $43b0
	ld c, $ff ; $43b2
	ld hl, wBallQuadrantAtHit ; $43b4
	ld a, [wBallCourtQuadrant] ; $43b7
	xor a, [hl] ; $43ba
	and a, $01 ; $43bb
	jr z, Label_08_43ca ; $43bd
	ld b, $03 ; $43bf
	ld c, $00 ; $43c1
	ld a, [wBallHasBouncedFlag] ; $43c3
	and a, a ; $43c6
	jr nz, Label_08_43ca ; $43c7
Label_08_43c9:
	ret ; $43c9
Label_08_43ca:
	ld a, b ; $43ca
	ld [wPointOutcome], a ; $43cb
	ld a, c ; $43ce
	ld [wPointOutcomeSide], a ; $43cf
	ret ; $43d2
HandleBallTouchCharEvent:
	ld a, [wBallTouchCharFlag] ; $43d3
	and a, a ; $43d6
	ret z ; $43d7
	xor a, a ; $43d8
	ld [wBallTouchCharFlag], a ; $43d9
	sound $77 ; $43dc
	call StartBallTouchCharEffect ; $43de
	call ApplyBallTouchOutcome ; $43e1
	ret ; $43e4
ApplyBallTouchOutcome:
	ld a, [wPointOutcome] ; $43e5
	and a, a ; $43e8
	jr nz, Label_08_43f5 ; $43e9
	ld a, $09 ; $43eb
	ld [wPointOutcome], a ; $43ed
	ld a, $01 ; $43f0
	ld [wPointOutcomeSide], a ; $43f2
Label_08_43f5:
	ret ; $43f5
AdvanceMatchRng:
	push hl ; $43f6
	ld a, [wMatchRngState] ; $43f7
	add a, $73 ; $43fa
	ld hl, $c409 ; $43fc
	add a, [hl] ; $43ff
	ld hl, $c401 ; $4400
	add a, [hl] ; $4403
	ld hl, $c405 ; $4404
	add a, [hl] ; $4407
	ld [wMatchRngState], a ; $4408
	pop hl ; $440b
	ret ; $440c
ReadMatchInputHeld:
	ldh a, [$ffd8] ; $440d
	and a, a ; $440f
	jr nz, ReadScriptedMatchInput ; $4410
	ldh a, [hPlayerInputFlags] ; $4412
	ret ; $4414
ReadMatchInputPressed:
	ldh a, [$ffd8] ; $4415
	and a, a ; $4417
	jr nz, ReadScriptedMatchInput ; $4418
	ldh a, [hInputRisingEdge] ; $441a
	ret ; $441c
ReadMatchInputRepeat:
	ldh a, [$ffd8] ; $441d
	and a, a ; $441f
	jr nz, ReadScriptedMatchInput ; $4420
	ldh a, [hInputPressed] ; $4422
	ret ; $4424
ReadScriptedMatchInput:
	ldh a, [hLinkInput] ; $4425
	ret ; $4427
StepMatchFrames:
	ld b, a ; $4428
Label_08_4429:
	ld a, [wMatchFramesAbort] ; $4429
	and a, a ; $442c
	jr nz, Label_08_4435 ; $442d
	call StepMatchFrame ; $442f
	dec b ; $4432
	jr nz, Label_08_4429 ; $4433
Label_08_4435:
	ret ; $4435
StepMatchFramesSkippable:
	ld b, a ; $4436
Label_08_4437:
	ld a, [wMatchFramesAbort] ; $4437
	and a, a ; $443a
	jr nz, Label_08_4451 ; $443b
	call StepMatchFrame ; $443d
	call ReadMatchInputHeld ; $4440
	and a, $03 ; $4443
	jr nz, Label_08_4451 ; $4445
	ld a, [wDebugMatchFlags] ; $4447
	bit 0, a ; $444a
	jr nz, Label_08_4437 ; $444c
	dec b ; $444e
	jr nz, Label_08_4437 ; $444f
Label_08_4451:
	ret ; $4451
RunMatchFramesUntilInput:
	ld a, [wMatchFramesAbort] ; $4452
	and a, a ; $4455
	jr nz, Label_08_4464 ; $4456
	call StepMatchFrame ; $4458
	call ReadMatchInputHeld ; $445b
	and a, $f3 ; $445e
	jr nz, Label_08_4464 ; $4460
	jr RunMatchFramesUntilInput ; $4462
Label_08_4464:
	ret ; $4464
StepMatchFrame:
	push af ; $4465
	push bc ; $4466
	push de ; $4467
	push hl ; $4468
	ldh a, [hWramBank] ; $4469
	push af ; $446b
	ldh a, [$ffd8] ; $446c
	and a, a ; $446e
	jr z, Label_08_4476 ; $446f
	farcall RunLinkMatchFrame ; $4471
	jr Label_08_4480 ; $4474
Label_08_4476:
	call AdvanceFrame ; $4476
	call UpdateMatchFrame ; $4479
	ld hl, $ffe9 ; $447c
	inc [hl] ; $447f
Label_08_4480:
	ld a, [wMatchSimFrozen] ; $4480
	and a, a ; $4483
	jr nz, Label_08_448c ; $4484
	call HandlePauseMenu ; $4486
	call CheckDebugStatsEditorHotkey ; $4489
Label_08_448c:
	pop af ; $448c
	wram_bank ; $448d
	pop hl ; $4491
	pop de ; $4492
	pop bc ; $4493
	pop af ; $4494
	ret ; $4495
HandlePauseMenu:
	call ReadMatchInputPressed ; $4496
	and a, $08 ; $4499
	ret z ; $449b
	ld a, [wPauseDisabled] ; $449c
	and a, a ; $449f
	ret nz ; $44a0
	ld a, [wMatchWinLoseFlag] ; $44a1
	and a, a ; $44a4
	ret nz ; $44a5
	ld a, $ff ; $44a6
	ld [wMatchSimFrozen], a ; $44a8
	ld [wMatchDrawFrozen], a ; $44ab
	farcall RunMatchPauseMenu ; $44ae
	call ReinitPointAfterPause ; $44b1
	ld a, $00 ; $44b4
	ld [wMatchDrawFrozen], a ; $44b6
	ld [wMatchSimFrozen], a ; $44b9
	ret ; $44bc
ReinitPointAfterPause:
	ld a, [$c4c8] ; $44bd
	and a, a ; $44c0
	ret nz ; $44c1
	call AssignCourtPositions ; $44c2
	ld a, [wCourtViewFlipChanged] ; $44c5
	and a, a ; $44c8
	ret z ; $44c9
	call RefreshCourtAfterEndChange ; $44ca
	call ResetCameraForServe ; $44cd
	call UpdateMatchCamera ; $44d0
	ld hl, $4cb2 ; $44d3
	call ForEachCharBank ; $44d6
	farcall LoadServeGfx ; $44d9
	ld a, [wServingCharWramBank] ; $44dc
	wram_bank ; $44df
	ld a, $03 ; $44e3
	call SetCharState ; $44e5
	wram_bank $04 ; $44e8
	ret ; $44ee
CheckDebugStatsEditorHotkey:
	ret ; $44ef
	call ReadMatchInputPressed ; $44f0
	and a, $04 ; $44f3
	ret z ; $44f5
	ldh a, [hDebugStepMode] ; $44f6
	and a, a ; $44f8
	ret z ; $44f9
	ld a, $ff ; $44fa
	ld [wMatchSimFrozen], a ; $44fc
	ld [wMatchDrawFrozen], a ; $44ff
	farcall RunDebugStatsEditor ; $4502
	ld a, $00 ; $4505
	ld [wMatchSimFrozen], a ; $4507
	ld [wMatchDrawFrozen], a ; $450a
	ret ; $450d
InitViewFlipPreference:
	ld a, [wGameMode] ; $450e
	cp a, $09 ; $4511
	jr z, Label_08_452e ; $4513
	ld a, [$c8f5] ; $4515
	cp a, $02 ; $4518
	jr z, Label_08_452e ; $451a
	ld a, [wGameMode] ; $451c
	cp a, $08 ; $451f
	jr z, Label_08_452e ; $4521
	farcall TestStorySlotFlagB ; $4523
	ld [wCourtViewOption], a ; $4526
	xor a, a ; $4529
	ld [$c4c8], a ; $452a
	ret ; $452d
Label_08_452e:
	ld a, $00 ; $452e
	ld [wCourtViewOption], a ; $4530
	ld a, $01 ; $4533
	ld [$c4c8], a ; $4535
	ret ; $4538
ApplyMatchBgmPreference:
	ld a, [wGameMode] ; $4539
	cp a, $09 ; $453c
	jr z, Label_08_4547 ; $453e
	farcall TestStorySlotFlagA ; $4540
	call SetMusicMuted ; $4543
	ret ; $4546
Label_08_4547:
	call ResumeBGM ; $4547
	ret ; $454a
Func_08_454b:
	ld a, [$c8f5] ; $454b
	cp a, $02 ; $454e
	jr z, Label_08_455d ; $4550
	ld a, [wOnCourtCharCount] ; $4552
	sub a, $02 ; $4555
	and a, $03 ; $4557
	ld [wScoreboardLayout], a ; $4559
	ret ; $455c
Label_08_455d:
	ld b, $03 ; $455d
	ld a, [$c7bb] ; $455f
	and a, a ; $4562
	jr nz, Label_08_4583 ; $4563
	ld b, $07 ; $4565
	ld a, [$c7bc] ; $4567
	and a, a ; $456a
	jr nz, Label_08_4583 ; $456b
	ld b, $06 ; $456d
	ld a, [$c7b9] ; $456f
	and a, a ; $4572
	jr nz, Label_08_4583 ; $4573
	ld a, [$c7b8] ; $4575
	and a, a ; $4578
	jr nz, Label_08_4583 ; $4579
	ld a, [$c7ba] ; $457b
	and a, a ; $457e
	jr nz, Label_08_4583 ; $457f
	ld b, $04 ; $4581
Label_08_4583:
	ld a, b ; $4583
	ld [wScoreboardLayout], a ; $4584
	ret ; $4587
	jp TickTimer ; $4588
SetBallPosition:
	push hl ; $458b
	xor a, a ; $458c
	ld hl, $c408 ; $458d
	ld [hl+], a ; $4590
	ld [hl+], a ; $4591
	ld a, c ; $4592
	ld [hl+], a ; $4593
	ld [hl], b ; $4594
	xor a, a ; $4595
	ld hl, $c404 ; $4596
	ld [hl+], a ; $4599
	ld [hl+], a ; $459a
	ld a, e ; $459b
	ld [hl+], a ; $459c
	ld [hl], d ; $459d
	pop de ; $459e
	xor a, a ; $459f
	ld hl, $c400 ; $45a0
	ld [hl+], a ; $45a3
	ld [hl+], a ; $45a4
	ld a, e ; $45a5
	ld [hl+], a ; $45a6
	ld [hl], d ; $45a7
	ret ; $45a8
SetBallVelocityPolar:
	ld a, l ; $45a9
	ld [$c474], a ; $45aa
	ld a, h ; $45ad
	ld [$c475], a ; $45ae
	push de ; $45b1
	call MulSinCosSigned ; $45b2
	ld c, l ; $45b5
	ld b, h ; $45b6
	xor a, a ; $45b7
	ld hl, $c426 ; $45b8
	ld [hl+], a ; $45bb
	ld a, e ; $45bc
	ld [hl+], a ; $45bd
	ld [hl], d ; $45be
	ld l, c ; $45bf
	ld h, b ; $45c0
	pop bc ; $45c1
	call MulSinCosSigned ; $45c2
	ld c, l ; $45c5
	ld b, h ; $45c6
	xor a, a ; $45c7
	ld hl, $c420 ; $45c8
	ld [hl+], a ; $45cb
	ld a, c ; $45cc
	ld [hl+], a ; $45cd
	ld [hl], b ; $45ce
	xor a, a ; $45cf
	ld hl, $c423 ; $45d0
	ld [hl+], a ; $45d3
	ld a, e ; $45d4
	ld [hl+], a ; $45d5
	ld [hl], d ; $45d6
	ret ; $45d7
SetBallSpinComponents:
	ld hl, wBallSideSpin ; $45d8
	ld a, e ; $45db
	ld [hl+], a ; $45dc
	ld [hl], d ; $45dd
	ld hl, wBallTopspin ; $45de
	ld a, c ; $45e1
	ld [hl+], a ; $45e2
	ld [hl], b ; $45e3
	ret ; $45e4
UpdateBallAnglesAndSpeed:
	ld hl, wBallVelocityX ; $45e5
	ld a, [hl+] ; $45e8
	ld d, [hl] ; $45e9
	ld e, a ; $45ea
	ld hl, wBallVelocityDepth ; $45eb
	ld a, [hl+] ; $45ee
	ld h, [hl] ; $45ef
	ld l, a ; $45f0
	call AngleFromVector16 ; $45f1
	ld hl, wBallHeadingAngle ; $45f4
	ld a, c ; $45f7
	ld [hl+], a ; $45f8
	ld [hl], b ; $45f9
	ld hl, wBallVelocityDepth ; $45fa
	ld a, [hl+] ; $45fd
	ld d, [hl] ; $45fe
	ld e, a ; $45ff
	ld hl, wBallVelocityX ; $4600
	ld a, [hl+] ; $4603
	ld h, [hl] ; $4604
	ld l, a ; $4605
	call VectorLengthFromAngle ; $4606
	ld e, l ; $4609
	ld d, h ; $460a
	ld hl, $c429 ; $460b
	xor a, a ; $460e
	ld [hl+], a ; $460f
	ld a, e ; $4610
	ld [hl+], a ; $4611
	ld [hl], d ; $4612
	ld hl, wBallVelocityHeight ; $4613
	ld a, [hl+] ; $4616
	ld h, [hl] ; $4617
	ld l, a ; $4618
	call AngleFromVector16 ; $4619
	ld hl, $c40c ; $461c
	ld a, c ; $461f
	ld [hl+], a ; $4620
	ld [hl], b ; $4621
	ld hl, wBallVelocityHeight ; $4622
	ld a, [hl+] ; $4625
	ld d, [hl] ; $4626
	ld e, a ; $4627
	ld hl, wBallSpeedHorizontal ; $4628
	ld a, [hl+] ; $462b
	ld h, [hl] ; $462c
	ld l, a ; $462d
	call VectorLengthFromAngle ; $462e
	ld e, l ; $4631
	ld d, h ; $4632
	ld hl, $c42c ; $4633
	ld a, e ; $4636
	ld [hl+], a ; $4637
	ld [hl], d ; $4638
	ret ; $4639
CheckBallOutOfBounds:
	ld d, $00 ; $463a
	ld hl, wCourtLimitX ; $463c
	ld a, [hl+] ; $463f
	ld b, [hl] ; $4640
	ld c, a ; $4641
	ld hl, wBallX ; $4642
	ld a, [hl+] ; $4645
	ld h, [hl] ; $4646
	ld l, a ; $4647
	bit 7, h ; $4648
	jr z, Label_08_4652 ; $464a
	xor a, a ; $464c
	sub a, l ; $464d
	ld l, a ; $464e
	sbc a, a ; $464f
	sub a, h ; $4650
	ld h, a ; $4651
Label_08_4652:
	add hl, bc ; $4652
	jr nc, Label_08_4657 ; $4653
	set 0, d ; $4655
Label_08_4657:
	ld hl, wCourtLimitDepth ; $4657
	ld a, [hl+] ; $465a
	ld b, [hl] ; $465b
	ld c, a ; $465c
	ld hl, wBallDepth ; $465d
	ld a, [hl+] ; $4660
	ld h, [hl] ; $4661
	ld l, a ; $4662
	bit 7, h ; $4663
	jr z, Label_08_466d ; $4665
	xor a, a ; $4667
	sub a, l ; $4668
	ld l, a ; $4669
	sbc a, a ; $466a
	sub a, h ; $466b
	ld h, a ; $466c
Label_08_466d:
	add hl, bc ; $466d
	jr nc, Label_08_4672 ; $466e
	set 1, d ; $4670
Label_08_4672:
	ld a, d ; $4672
	ld [$c4b1], a ; $4673
	ret ; $4676
GetBallHeightSign:
	ld hl, $c408 ; $4677
	ld a, [hl+] ; $467a
	or a, [hl] ; $467b
	inc hl ; $467c
	or a, [hl] ; $467d
	inc hl ; $467e
	or a, [hl] ; $467f
	jr z, Label_08_468a ; $4680
	ld a, $01 ; $4682
	bit 7, [hl] ; $4684
	jr z, Label_08_468a ; $4686
	ld a, $ff ; $4688
Label_08_468a:
	ret ; $468a
MulMem24ByFrac:
	inc hl ; $468b
	inc hl ; $468c
	ld a, [hl-] ; $468d
	ld d, a ; $468e
	ld a, [hl-] ; $468f
	ld e, a ; $4690
	ld a, [hl] ; $4691
	bit 7, d ; $4692
	jr nz, Label_08_46a0 ; $4694
	ld l, e ; $4696
	ld h, d ; $4697
	ld a, b ; $4698
	call MulHLByAFracSigned ; $4699
	xor a, a ; $469c
	ld e, l ; $469d
	ld d, h ; $469e
	ret ; $469f
Label_08_46a0:
	call NegateADE ; $46a0
	ld l, e ; $46a3
	ld h, d ; $46a4
	ld a, b ; $46a5
	call MulHLByAFracSigned ; $46a6
	xor a, a ; $46a9
	ld e, l ; $46aa
	ld d, h ; $46ab
	call NegateADE ; $46ac
	ret ; $46af
ApplyCourtBounceDamping:
	ld hl, $c420 ; $46b0
	ld a, [wCourtSurfaceFriction] ; $46b3
	ld b, a ; $46b6
	call MulMem24ByFrac ; $46b7
	ld hl, $c420 ; $46ba
	ld [hl+], a ; $46bd
	ld a, e ; $46be
	ld [hl+], a ; $46bf
	ld a, d ; $46c0
	ld [hl+], a ; $46c1
	ld hl, $c423 ; $46c2
	ld a, [wCourtSurfaceFriction] ; $46c5
	ld b, a ; $46c8
	call MulMem24ByFrac ; $46c9
	ld hl, $c423 ; $46cc
	ld [hl+], a ; $46cf
	ld a, e ; $46d0
	ld [hl+], a ; $46d1
	ld a, d ; $46d2
	ld [hl+], a ; $46d3
	ld hl, $c426 ; $46d4
	ld a, [wCourtSurfaceBounce] ; $46d7
	ld b, a ; $46da
	call MulMem24ByFrac ; $46db
	ld hl, $c426 ; $46de
	ld [hl+], a ; $46e1
	ld a, e ; $46e2
	ld [hl+], a ; $46e3
	ld a, d ; $46e4
	ld [hl+], a ; $46e5
	ret ; $46e6
FindServerCharBank:
	ld hl, wCharServeRole ; $46e7
	ld b, $04 ; $46ea
	ld a, b ; $46ec
	wram_bank ; $46ed
	ld a, [hl] ; $46f1
	and a, a ; $46f2
	jr z, Label_08_470d ; $46f3
	ld b, $05 ; $46f5
	ld a, b ; $46f7
	wram_bank ; $46f8
	ld a, [hl] ; $46fc
	and a, a ; $46fd
	jr z, Label_08_470d ; $46fe
	ld b, $06 ; $4700
	ld a, b ; $4702
	wram_bank ; $4703
	ld a, [hl] ; $4707
	and a, a ; $4708
	jr z, Label_08_470d ; $4709
	ld b, $07 ; $470b
Label_08_470d:
	wram_bank $04 ; $470d
	ret ; $4713
RunMatchPlayLoop:
	ld a, [wGameMode] ; $4714
	cp a, $02 ; $4717
	jr z, Label_08_4721 ; $4719
	ld a, [$c8f5] ; $471b
	and a, a ; $471e
	jr nz, Label_08_4726 ; $471f
Label_08_4721:
	ld hl, $c4cc ; $4721
	ld [hl], $01 ; $4724
Label_08_4726:
	call PlaySet ; $4726
	ld a, [wMatchAbortFlag] ; $4729
	and a, $80 ; $472c
	jr nz, Label_08_4736 ; $472e
	ld a, [wMatchWinLoseFlag] ; $4730
	and a, a ; $4733
	jr z, Label_08_4726 ; $4734
Label_08_4736:
	ret ; $4736
PlaySet:
	ld hl, CheckSetComplete ; $4737
	push hl ; $473a
	ld a, [wTiebreakerIndicator] ; $473b
	and a, a ; $473e
	jp z, Label_08_4758 ; $473f
	jp Label_08_4782 ; $4742
CheckSetComplete:
	ld a, [wMatchAbortFlag] ; $4745
	and a, $80 ; $4748
	jr nz, Label_08_4757 ; $474a
	ld a, [wSetWinLoseFlag] ; $474c
	and a, a ; $474f
	jr z, PlaySet ; $4750
	ld a, $01 ; $4752
	ld [$c4cc], a ; $4754
Label_08_4757:
	ret ; $4757
Label_08_4758:
	xor a, a ; $4758
	ld [$c7bd], a ; $4759
	call AssignCourtPositions ; $475c
	call RefreshCourtAfterEndChange ; $475f
	call RunChangeoverSequence ; $4762
Label_08_4765:
	call AssignCourtPositions ; $4765
	call PlayPoint ; $4768
	ld a, [wMatchAbortFlag] ; $476b
	and a, $80 ; $476e
	jr nz, Label_08_4781 ; $4770
	ld a, [wGameWinLoseFlag] ; $4772
	and a, a ; $4775
	jr z, Label_08_4765 ; $4776
	ld a, [wTiebreakerIndicator] ; $4778
	and a, a ; $477b
	jr z, Label_08_4781 ; $477c
	call WalkCharsOffCourt ; $477e
Label_08_4781:
	ret ; $4781
Label_08_4782:
	ld a, $01 ; $4782
	ld [$c7bd], a ; $4784
	call InitTiebreakPointCounter ; $4787
	ld a, $01 ; $478a
	ld [$c4cc], a ; $478c
	sound $0e ; $478f
	ld a, $0f ; $4791
	farcall ShowCourtBanner ; $4793
	ld a, $50 ; $4796
	call StepMatchFrames ; $4798
	farcall HideCourtBanner ; $479b
	ld a, $0f ; $479e
	call StepMatchFrames ; $47a0
Label_08_47a3:
	call AssignCourtPositions ; $47a3
	call RefreshCourtAfterEndChange ; $47a6
	call RunChangeoverSequence ; $47a9
	call PlayPoint ; $47ac
	ld a, [wMatchAbortFlag] ; $47af
	and a, $80 ; $47b2
	jr nz, Label_08_47c6 ; $47b4
	ld hl, wTotalPointsScoredInCurrentGame ; $47b6
	ld a, [hl] ; $47b9
	cp a, $18 ; $47ba
	jr c, Label_08_47c0 ; $47bc
	ld [hl], $00 ; $47be
Label_08_47c0:
	ld a, [wGameWinLoseFlag] ; $47c0
	and a, a ; $47c3
	jr z, Label_08_47a3 ; $47c4
Label_08_47c6:
	ld a, [wMatchBGM] ; $47c6
	call PlaySoundManaged ; $47c9
	ret ; $47cc
InitTiebreakPointCounter:
	ld a, [wTotalGamesWonInMatch] ; $47cd
	and a, $03 ; $47d0
	add a, $de ; $47d2
	ld l, a ; $47d4
	adc a, $47 ; $47d5
	sub a, l ; $47d7
	ld h, a ; $47d8
	ld a, [hl] ; $47d9
	ld [wTotalPointsScoredInCurrentGame], a ; $47da
	ret ; $47dd
	; $47de, 4 bytes (bytes:4)
	db $00, $12, $0c, $06 ; 0x00
AssignCourtPositions:
	ld hl, FinalizeServeSideOrientation ; $47e2
	push hl ; $47e5
	ld a, [wTiebreakerIndicator] ; $47e6
	and a, a ; $47e9
	jp nz, Label_08_48c9 ; $47ea
	jr Label_08_4808 ; $47ed
FinalizeServeSideOrientation:
	call CheckServerEndChanged ; $47ef
	call UpdateViewFlipState ; $47f2
	call FlipAllCharPositions ; $47f5
	call IdentifyServingPlayer ; $47f8
	ld hl, $4c99 ; $47fb
	call ForEachCharBank ; $47fe
	wram_bank $04 ; $4801
	ret ; $4807
Label_08_4808:
	ld a, [wOnCourtCharCountMinus1] ; $4808
	add a, a ; $480b
	add a, $3f ; $480c
	ld l, a ; $480e
	adc a, $48 ; $480f
	sub a, l ; $4811
	ld h, a ; $4812
	ld a, [hl+] ; $4813
	ld h, [hl] ; $4814
	ld l, a ; $4815
	ld a, [wTotalGamesWonInMatch] ; $4816
	and a, $03 ; $4819
	call LoadPositionRecord ; $481b
	ld a, [wTotalPointsScoredInCurrentGame] ; $481e
	rrca ; $4821
	ret nc ; $4822
	ld hl, FlipPartnerCourtPositions ; $4823
	push hl ; $4826
	ld a, [wOnCourtCharCountMinus1] ; $4827
	rst Rst00 ; $482a
	dw Label_08_4847 ; $482b jumptable
	dw Label_08_4847 ; $482d jumptable
	dw Label_08_4847 ; $482f jumptable
	dw Label_08_4853 ; $4831 jumptable
FlipPartnerCourtPositions:
	ld a, [wOnCourtCharCountMinus1] ; $4833
	rst Rst00 ; $4836
	dw Label_08_4888 ; $4837 jumptable
	dw Label_08_4888 ; $4839 jumptable
	dw Label_08_4894 ; $483b jumptable
	dw Label_08_4894 ; $483d jumptable
GamePositionPtrs:
	; $483f, 8 bytes (records:2)
	dw GamePositionTables ; record 0
	dw GamePositionTables ; record 1
	dw $49b9 ; record 2
	dw $4999 ; record 3
Label_08_4847:
	ld b, $01 ; $4847
	wram_bank $04 ; $4849
	call FlipCharPositionCode ; $484f
	ret ; $4852
Label_08_4853:
	wram_bank $04 ; $4853
	ld a, [wCharServeRole] ; $4859
	and a, $01 ; $485c
	jr nz, Label_08_4875 ; $485e
	ld b, $01 ; $4860
	wram_bank $04 ; $4862
	call FlipCharPositionCode ; $4868
	wram_bank $06 ; $486b
	call FlipCharPositionCode ; $4871
	ret ; $4874
Label_08_4875:
	wram_bank $04 ; $4875
	call ToggleCharCourtRow ; $487b
	wram_bank $06 ; $487e
	call ToggleCharCourtRow ; $4884
	ret ; $4887
Label_08_4888:
	ld b, $01 ; $4888
	wram_bank $05 ; $488a
	call FlipCharPositionCode ; $4890
	ret ; $4893
Label_08_4894:
	wram_bank $04 ; $4894
	ld a, [wCharServeRole] ; $489a
	and a, $01 ; $489d
	jr z, Label_08_48b6 ; $489f
	ld b, $01 ; $48a1
	wram_bank $05 ; $48a3
	call FlipCharPositionCode ; $48a9
	wram_bank $07 ; $48ac
	call FlipCharPositionCode ; $48b2
	ret ; $48b5
Label_08_48b6:
	wram_bank $05 ; $48b6
	call ToggleCharCourtRow ; $48bc
	wram_bank $07 ; $48bf
	call ToggleCharCourtRow ; $48c5
	ret ; $48c8
Label_08_48c9:
	ld a, [wOnCourtCharCountMinus1] ; $48c9
	add a, a ; $48cc
	add a, $e5 ; $48cd
	ld l, a ; $48cf
	adc a, $48 ; $48d0
	sub a, l ; $48d2
	ld h, a ; $48d3
	ld a, [hl+] ; $48d4
	ld h, [hl] ; $48d5
	ld l, a ; $48d6
	ld a, [wTotalGamesWonInMatch] ; $48d7
	bit 1, a ; $48da
	ld a, [wTotalPointsScoredInCurrentGame] ; $48dc
	jp z, LoadPositionRecord ; $48df
	jp Label_08_491a ; $48e2
TiebreakPositionPtrs:
	; $48e5, 8 bytes (records:2)
	dw TiebreakPositionTables ; record 0
	dw TiebreakPositionTables ; record 1
	dw $4b59 ; record 2
	dw $4a99 ; record 3
LoadPositionRecord:
	add a, a ; $48ed
	add a, a ; $48ee
	add a, a ; $48ef
	add a, l ; $48f0
	ld l, a ; $48f1
	jr nc, Label_08_48f5 ; $48f2
	inc h ; $48f4
Label_08_48f5:
	ld de, wCharCourtPos ; $48f5
	wram_bank $04 ; $48f8
	ld a, [hl+] ; $48fe
	ld [de], a ; $48ff
	wram_bank $05 ; $4900
	ld a, [hl+] ; $4906
	ld [de], a ; $4907
	wram_bank $06 ; $4908
	ld a, [hl+] ; $490e
	ld [de], a ; $490f
	wram_bank $07 ; $4910
	ld a, [hl+] ; $4916
	ld [de], a ; $4917
	jr Label_08_494d ; $4918
Label_08_491a:
	add a, a ; $491a
	add a, a ; $491b
	add a, a ; $491c
	add a, l ; $491d
	ld l, a ; $491e
	jr nc, Label_08_4922 ; $491f
	inc h ; $4921
Label_08_4922:
	ld de, wCharCourtPos ; $4922
	wram_bank $04 ; $4925
	ld a, [hl+] ; $492b
	xor a, $03 ; $492c
	ld [de], a ; $492e
	wram_bank $05 ; $492f
	ld a, [hl+] ; $4935
	xor a, $03 ; $4936
	ld [de], a ; $4938
	wram_bank $06 ; $4939
	ld a, [hl+] ; $493f
	xor a, $03 ; $4940
	ld [de], a ; $4942
	wram_bank $07 ; $4943
	ld a, [hl+] ; $4949
	xor a, $03 ; $494a
	ld [de], a ; $494c
Label_08_494d:
	ld de, wCharServeRole ; $494d
	wram_bank $04 ; $4950
	ld a, [hl+] ; $4956
	ld [de], a ; $4957
	wram_bank $05 ; $4958
	ld a, [hl+] ; $495e
	ld [de], a ; $495f
	wram_bank $06 ; $4960
	ld a, [hl+] ; $4966
	ld [de], a ; $4967
	wram_bank $07 ; $4968
	ld a, [hl+] ; $496e
	ld [de], a ; $496f
	ret ; $4970
ToggleCharCourtRow:
	ld hl, wCharServeRole ; $4971
	ld a, [hl] ; $4974
	xor a, $02 ; $4975
	ld [hl], a ; $4977
	ret ; $4978
GamePositionTables:
	; $4979, 96 bytes (bytes:8)
	db $00, $03, $09, $09, $00, $01, $09, $09 ; 0x00
	db $03, $00, $09, $09, $01, $00, $09, $09 ; 0x08
	db $03, $00, $09, $09, $00, $01, $09, $09 ; 0x10
	db $00, $03, $09, $09, $01, $00, $09, $09 ; 0x18
	db $00, $03, $01, $02, $00, $01, $02, $03 ; 0x20
	db $03, $00, $02, $01, $01, $00, $03, $02 ; 0x28
	db $02, $00, $03, $01, $02, $01, $00, $03 ; 0x30
	db $00, $02, $01, $03, $01, $02, $03, $00 ; 0x38
	db $00, $03, $09, $02, $00, $01, $09, $03 ; 0x40
	db $03, $00, $09, $01, $01, $00, $09, $02 ; 0x48
	db $03, $00, $09, $01, $00, $01, $09, $03 ; 0x50
	db $00, $02, $09, $03, $01, $02, $09, $00 ; 0x58
TiebreakPositionTables:
	; $49d9, 576 bytes (bytes:8)
	db $00, $03, $09, $09, $00, $01, $09, $09 ; 0x00
	db $01, $02, $09, $09, $01, $00, $09, $09 ; 0x08
	db $00, $03, $09, $09, $01, $00, $09, $09 ; 0x10
	db $01, $02, $09, $09, $00, $01, $09, $09 ; 0x18
	db $00, $03, $09, $09, $00, $01, $09, $09 ; 0x20
	db $01, $02, $09, $09, $01, $00, $09, $09 ; 0x28
	db $03, $00, $09, $09, $01, $00, $09, $09 ; 0x30
	db $02, $01, $09, $09, $00, $01, $09, $09 ; 0x38
	db $03, $00, $09, $09, $00, $01, $09, $09 ; 0x40
	db $02, $01, $09, $09, $01, $00, $09, $09 ; 0x48
	db $03, $00, $09, $09, $01, $00, $09, $09 ; 0x50
	db $02, $01, $09, $09, $00, $01, $09, $09 ; 0x58
	db $00, $03, $09, $09, $00, $01, $09, $09 ; 0x60
	db $01, $02, $09, $09, $01, $00, $09, $09 ; 0x68
	db $00, $03, $09, $09, $01, $00, $09, $09 ; 0x70
	db $01, $02, $09, $09, $00, $01, $09, $09 ; 0x78
	db $00, $03, $09, $09, $00, $01, $09, $09 ; 0x80
	db $01, $02, $09, $09, $01, $00, $09, $09 ; 0x88
	db $03, $00, $09, $09, $01, $00, $09, $09 ; 0x90
	db $02, $01, $09, $09, $00, $01, $09, $09 ; 0x98
	db $03, $00, $09, $09, $00, $01, $09, $09 ; 0xa0
	db $02, $01, $09, $09, $01, $00, $09, $09 ; 0xa8
	db $03, $00, $09, $09, $01, $00, $09, $09 ; 0xb0
	db $02, $01, $09, $09, $00, $01, $09, $09 ; 0xb8
	db $00, $03, $01, $02, $00, $01, $02, $03 ; 0xc0
	db $00, $02, $01, $03, $03, $00, $01, $02 ; 0xc8
	db $00, $03, $01, $02, $01, $00, $03, $02 ; 0xd0
	db $00, $03, $01, $02, $02, $03, $00, $01 ; 0xd8
	db $01, $03, $00, $02, $02, $01, $00, $03 ; 0xe0
	db $00, $03, $01, $02, $03, $02, $01, $00 ; 0xe8
	db $03, $01, $02, $00, $01, $02, $03, $00 ; 0xf0
	db $02, $00, $03, $01, $00, $03, $02, $01 ; 0xf8
	db $03, $00, $02, $01, $00, $01, $02, $03 ; 0x100
	db $03, $01, $02, $00, $03, $00, $01, $02 ; 0x108
	db $03, $00, $02, $01, $01, $00, $03, $02 ; 0x110
	db $03, $00, $02, $01, $02, $03, $00, $01 ; 0x118
	db $01, $03, $00, $02, $02, $01, $00, $03 ; 0x120
	db $00, $03, $01, $02, $03, $02, $01, $00 ; 0x128
	db $00, $02, $01, $03, $01, $02, $03, $00 ; 0x130
	db $01, $03, $00, $02, $00, $03, $02, $01 ; 0x138
	db $00, $03, $01, $02, $00, $01, $02, $03 ; 0x140
	db $00, $02, $01, $03, $03, $00, $01, $02 ; 0x148
	db $03, $00, $02, $01, $01, $00, $03, $02 ; 0x150
	db $03, $00, $02, $01, $02, $03, $00, $01 ; 0x158
	db $02, $00, $03, $01, $02, $01, $00, $03 ; 0x160
	db $03, $00, $02, $01, $03, $02, $01, $00 ; 0x168
	db $03, $01, $02, $00, $01, $02, $03, $00 ; 0x170
	db $02, $00, $03, $01, $00, $03, $02, $01 ; 0x178
	db $00, $03, $09, $02, $00, $01, $09, $03 ; 0x180
	db $01, $02, $09, $03, $01, $00, $09, $02 ; 0x188
	db $00, $03, $09, $02, $01, $00, $09, $02 ; 0x190
	db $01, $03, $09, $02, $00, $03, $09, $01 ; 0x198
	db $00, $03, $09, $02, $00, $01, $09, $03 ; 0x1a0
	db $01, $03, $09, $02, $01, $02, $09, $00 ; 0x1a8
	db $03, $01, $09, $00, $01, $02, $09, $00 ; 0x1b0
	db $02, $00, $09, $01, $00, $03, $09, $01 ; 0x1b8
	db $03, $00, $09, $01, $00, $01, $09, $03 ; 0x1c0
	db $02, $01, $09, $00, $01, $00, $09, $02 ; 0x1c8
	db $03, $00, $09, $01, $01, $00, $09, $02 ; 0x1d0
	db $02, $00, $09, $01, $00, $03, $09, $01 ; 0x1d8
	db $00, $03, $09, $02, $00, $01, $09, $03 ; 0x1e0
	db $01, $03, $09, $02, $01, $02, $09, $00 ; 0x1e8
	db $00, $02, $09, $03, $01, $02, $09, $00 ; 0x1f0
	db $01, $03, $09, $02, $00, $03, $09, $01 ; 0x1f8
	db $00, $03, $09, $02, $00, $01, $09, $03 ; 0x200
	db $01, $02, $09, $03, $01, $00, $09, $02 ; 0x208
	db $03, $00, $09, $01, $01, $00, $09, $02 ; 0x210
	db $02, $00, $09, $01, $00, $03, $09, $01 ; 0x218
	db $03, $00, $09, $01, $00, $01, $09, $03 ; 0x220
	db $02, $00, $09, $01, $01, $02, $09, $00 ; 0x228
	db $03, $01, $09, $00, $01, $02, $09, $00 ; 0x230
	db $02, $00, $09, $01, $00, $03, $09, $01 ; 0x238
CheckServerEndChanged:
	wram_bank $04 ; $4c19
	ld a, [wCharCourtPos] ; $4c1f
	ld b, a ; $4c22
	ld hl, $c8cf ; $4c23
	ld a, [hl] ; $4c26
	ld [hl], b ; $4c27
	xor a, b ; $4c28
	and a, $02 ; $4c29
	jr z, Label_08_4c32 ; $4c2b
	ld a, $01 ; $4c2d
	ld [wChangeEndsPending], a ; $4c2f
Label_08_4c32:
	ret ; $4c32
UpdateViewFlipState:
	ld c, $00 ; $4c33
	ld a, [wCourtViewOption] ; $4c35
	and a, a ; $4c38
	jr z, Label_08_4c44 ; $4c39
	ld a, [$c8cf] ; $4c3b
	and a, $02 ; $4c3e
	jr z, Label_08_4c44 ; $4c40
	ld c, $01 ; $4c42
Label_08_4c44:
	ld hl, wCourtViewFlipped ; $4c44
	ld a, [hl] ; $4c47
	ld [hl], c ; $4c48
	sub a, c ; $4c49
	ld [wCourtViewFlipChanged], a ; $4c4a
	ret ; $4c4d
FlipAllCharPositions:
	ld a, [wCourtViewFlipped] ; $4c4e
	and a, a ; $4c51
	ret z ; $4c52
	ld b, $03 ; $4c53
	wram_bank $07 ; $4c55
	call FlipCharPositionCode ; $4c5b
	wram_bank $06 ; $4c5e
	call FlipCharPositionCode ; $4c64
	wram_bank $05 ; $4c67
	call FlipCharPositionCode ; $4c6d
	wram_bank $04 ; $4c70
	call FlipCharPositionCode ; $4c76
	ret ; $4c79
IdentifyServingPlayer:
	call FindServerCharBank ; $4c7a
	ld a, b ; $4c7d
	wram_bank ; $4c7e
	ld a, b ; $4c82
	ld [wServingCharWramBank], a ; $4c83
	ld a, [wCharIndex] ; $4c86
	ld [wCurrentServingPlayer], a ; $4c89
	ld a, [wCharCourtPos] ; $4c8c
	ld [wServingCharCourtPos], a ; $4c8f
	wram_bank $04 ; $4c92
	ret ; $4c98
	ld a, [wCharCourtPos] ; $4c99
	add a, $ae ; $4c9c
	ld l, a ; $4c9e
	adc a, $4c ; $4c9f
	sub a, l ; $4ca1
	ld h, a ; $4ca2
	ld a, [hl] ; $4ca3
	ld [$df0c], a ; $4ca4
	ld [wCharFacingDesired], a ; $4ca7
	ld [wCharFacingShown], a ; $4caa
	ret ; $4cad
	; $4cae, 4 bytes (bytes:4)
	db $c0, $c0, $40, $40 ; 0x00
	call GetCharBaseCourtPosition ; $4cb2
	call SetCharPosAndTarget ; $4cb5
	ret ; $4cb8
ResetPointState:
	xor a, a ; $4cb9
	ld [$c4b5], a ; $4cba
	ld [wBallBounceCount], a ; $4cbd
	ld [wRallyLength], a ; $4cc0
	ld [wBallHitEvent], a ; $4cc3
	ld [wBallTouchCharFlag], a ; $4cc6
	ld [wBallHasBouncedFlag], a ; $4cc9
	ld [wServiceAceFlag], a ; $4ccc
	ld [wReturnAceFlag], a ; $4ccf
	ld [wLandingMarkerActive], a ; $4cd2
	ld [wPointWinnerShotType], a ; $4cd5
	ld [wMatchAbortFlag], a ; $4cd8
	ld [wPointOutcomeSide], a ; $4cdb
	ld [wPointOutcome], a ; $4cde
	ldh [$ffdd], a ; $4ce1
	ld [wPauseDisabled], a ; $4ce3
	ld a, $01 ; $4ce6
	ld [wOffscreenArrowsEnabled], a ; $4ce8
	call ResetBallState ; $4ceb
	ld a, [$c7b8] ; $4cee
	and a, a ; $4cf1
	ret nz ; $4cf2
	call ResetCameraForServe ; $4cf3
	ld de, $fe50 ; $4cf6
	ld hl, wCourtLimitX ; $4cf9
	ld a, e ; $4cfc
	ld [hl+], a ; $4cfd
	ld [hl], d ; $4cfe
	ld de, $fd60 ; $4cff
	ld hl, wCourtLimitDepth ; $4d02
	ld a, e ; $4d05
	ld [hl+], a ; $4d06
	ld [hl], d ; $4d07
	ld hl, $4f6f ; $4d08
	call ForEachCharBank ; $4d0b
	ret ; $4d0e
PlayPoint:
	call ResetPointState ; $4d0f
	ld hl, $c4c8 ; $4d12
	res 1, [hl] ; $4d15
	farcall LoadServeGfx ; $4d17
	call StepMatchFrame ; $4d1a
	call AnnouncePointSituation ; $4d1d
	ld hl, $4f91 ; $4d20
	call ForEachCharBank ; $4d23
Label_08_4d26:
	call StepMatchFrame ; $4d26
	ld a, [wMatchAbortFlag] ; $4d29
	and a, $01 ; $4d2c
	jr nz, Label_08_4d5b ; $4d2e
	ld a, [wPointOutcome] ; $4d30
	and a, a ; $4d33
	jr z, Label_08_4d26 ; $4d34
	ld a, [wPointOutcome] ; $4d36
	cp a, $09 ; $4d39
	jr nz, Label_08_4d42 ; $4d3b
	ld a, $28 ; $4d3d
	call StepMatchFrames ; $4d3f
Label_08_4d42:
	call EndPointBallEffects ; $4d42
	farcall UpdateScorePanelDisplay ; $4d45
	call ScorePoint ; $4d48
	call StepMatchFrame ; $4d4b
	farcall UpdatePointDigitsDisplay ; $4d4e
	call StepMatchFrame ; $4d51
	call StartPointEndReactions ; $4d54
	call ResolvePointOutcome ; $4d57
	ret ; $4d5a
Label_08_4d5b:
	ld hl, wMatchAbortFlag ; $4d5b
	ld a, [hl] ; $4d5e
	and a, $fe ; $4d5f
	ld [hl], a ; $4d61
	ret ; $4d62
SetPointSituationBgm:
	ld d, $0f ; $4d63
	ld a, [wMatchPointFlag] ; $4d65
	and a, a ; $4d68
	jr nz, Label_08_4d87 ; $4d69
	ld d, $0f ; $4d6b
	ld a, [wSetPointFlag] ; $4d6d
	and a, a ; $4d70
	jr nz, Label_08_4d87 ; $4d71
	ld d, $10 ; $4d73
	ld a, [wGamePointFlag] ; $4d75
	and a, a ; $4d78
	jr nz, Label_08_4d87 ; $4d79
	ld d, $0e ; $4d7b
	ld a, [wTiebreakerIndicator] ; $4d7d
	and a, a ; $4d80
	jr nz, Label_08_4d87 ; $4d81
	ld a, [wMatchBGM] ; $4d83
	ld d, a ; $4d86
Label_08_4d87:
	ld a, d ; $4d87
	call PlaySoundManaged ; $4d88
	ret ; $4d8b
AnnouncePointSituation:
	call EvaluatePointSituation ; $4d8c
	call SetPointSituationBgm ; $4d8f
	ld d, $0a ; $4d92
	ld a, [wMatchPointFlag] ; $4d94
	and a, a ; $4d97
	jr nz, Label_08_4dbb ; $4d98
	ld d, $09 ; $4d9a
	ld a, [wSetPointFlag] ; $4d9c
	and a, a ; $4d9f
	jr nz, Label_08_4dbb ; $4da0
	ld a, [wGamePointFlag] ; $4da2
	and a, a ; $4da5
	jr z, Label_08_4df3 ; $4da6
	ld a, [wGamePointFlag] ; $4da8
	inc a ; $4dab
	srl a ; $4dac
	ld b, a ; $4dae
	ld a, [wCurrentServingPlayer] ; $4daf
	xor a, b ; $4db2
	and a, $01 ; $4db3
	ld d, $08 ; $4db5
	jr nz, Label_08_4dbb ; $4db7
	ld d, $07 ; $4db9
Label_08_4dbb:
	ld a, d ; $4dbb
	farcall ShowCourtBanner ; $4dbc
	ld a, [wGamePointFlag] ; $4dbf
	inc a ; $4dc2
	srl a ; $4dc3
	ld b, a ; $4dc5
	wram_bank $04 ; $4dc6
	ld a, [wCharCourtPos] ; $4dcc
	rrca ; $4dcf
	xor a, b ; $4dd0
	and a, $01 ; $4dd1
	ld de, $3460 ; $4dd3
	jr nz, Label_08_4ddb ; $4dd6
	ld de, $3420 ; $4dd8
Label_08_4ddb:
	ld bc, $ddb0 ; $4ddb
	farcall SetObjPosition ; $4dde
	ld a, $0a ; $4de1
	call StepMatchFrames ; $4de3
	ld a, $1e ; $4de6
	call StepMatchFramesSkippable ; $4de8
	farcall HideCourtBanner ; $4deb
	ld a, $0a ; $4dee
	call StepMatchFrames ; $4df0
Label_08_4df3:
	ret ; $4df3
ResolvePointOutcome:
	ld hl, wMatchCameraY ; $4df4
	ld a, [hl+] ; $4df7
	ld d, [hl] ; $4df8
	ld e, a ; $4df9
	ld hl, wMatchCameraX ; $4dfa
	ld a, [hl+] ; $4dfd
	ld h, [hl] ; $4dfe
	ld l, a ; $4dff
	call SetCameraTarget ; $4e00
	call StepMatchFrame ; $4e03
	ld hl, ResolvePointResultSequence ; $4e06
	push hl ; $4e09
	ld a, [wPointOutcome] ; $4e0a
	rst Rst00 ; $4e0d
	dw Label_00_03ae ; $4e0e jumptable
	dw Label_08_4e8d ; $4e10 jumptable
	dw Label_08_4e8d ; $4e12 jumptable
	dw Label_08_4e8d ; $4e14 jumptable
	dw Label_08_4e8d ; $4e16 jumptable
	dw Label_08_4e8d ; $4e18 jumptable
	dw Label_08_4e6d ; $4e1a jumptable
	dw Label_08_4e49 ; $4e1c jumptable
	dw Label_08_4e5b ; $4e1e jumptable
	dw Label_00_03ae ; $4e20 jumptable
ResolvePointResultSequence:
	ld hl, DelayAfterPointResolution ; $4e22
	push hl ; $4e25
	ld a, [wMatchWinLoseFlag] ; $4e26
	and a, a ; $4e29
	jp nz, Label_08_4ed1 ; $4e2a
	ld a, [wSetWinLoseFlag] ; $4e2d
	and a, a ; $4e30
	jp nz, Label_08_4f0f ; $4e31
	ld a, [wGameWinLoseFlag] ; $4e34
	and a, a ; $4e37
	jp nz, Label_08_4f23 ; $4e38
	jp Label_08_4ea3 ; $4e3b
DelayAfterPointResolution:
	ld a, $46 ; $4e3e
	call StepMatchFramesSkippable ; $4e40
	ld a, $0a ; $4e43
	call StepMatchFrames ; $4e45
	ret ; $4e48
Label_08_4e49:
	ld hl, $0174 ; $4e49
	ld de, $0504 ; $4e4c
	ld bc, $0a07 ; $4e4f
	farcall ShowMessageWindow ; $4e52
	ld a, $0a ; $4e55
	call StepMatchFrames ; $4e57
	ret ; $4e5a
Label_08_4e5b:
	ld hl, $0175 ; $4e5b
	ld de, $0204 ; $4e5e
	ld bc, $0f07 ; $4e61
	farcall ShowMessageWindow ; $4e64
	ld a, $0a ; $4e67
	call StepMatchFrames ; $4e69
	ret ; $4e6c
Label_08_4e6d:
	ld a, [wPointWinnerShotType] ; $4e6d
	and a, a ; $4e70
	ret z ; $4e71
	ld a, [wPointWinnerShotType] ; $4e72
	add a, $17 ; $4e75
	farcall ShowCourtBanner ; $4e77
	ld a, $0a ; $4e7a
	call StepMatchFrames ; $4e7c
	ld a, $1e ; $4e7f
	call StepMatchFramesSkippable ; $4e81
	farcall HideCourtBanner ; $4e84
	ld a, $0a ; $4e87
	call StepMatchFrames ; $4e89
	ret ; $4e8c
Label_08_4e8d:
	ld a, [wPointOutcome] ; $4e8d
	add a, $00 ; $4e90
	farcall ShowCourtBanner ; $4e92
	ld a, $1e ; $4e95
	call StepMatchFrames ; $4e97
	farcall HideCourtBanner ; $4e9a
	ld a, $0a ; $4e9d
	call StepMatchFrames ; $4e9f
	ret ; $4ea2
Label_08_4ea3:
	ld a, [wPointWinLoseFlag] ; $4ea3
	and a, a ; $4ea6
	ret z ; $4ea7
	farcall SpawnGameScoreDisplayObjs ; $4ea8
	ld a, $0a ; $4eab
	call StepMatchFrames ; $4ead
	ld a, $0a ; $4eb0
	call StepMatchFramesSkippable ; $4eb2
	ld a, [wDeuceIndicator] ; $4eb5
	and a, a ; $4eb8
	jr z, Label_08_4ec0 ; $4eb9
	sound $69 ; $4ebb
	call StepMatchFrame ; $4ebd
Label_08_4ec0:
	farcall UpdateScorePanelDisplay ; $4ec0
	ld a, $0a ; $4ec3
	call StepMatchFrames ; $4ec5
	ld a, $1e ; $4ec8
	call StepMatchFramesSkippable ; $4eca
	farcall DismissGameScoreDisplayObjs ; $4ecd
	ret ; $4ed0
Label_08_4ed1:
	ld a, [wGameMode] ; $4ed1
	cp a, $08 ; $4ed4
	jr nz, Label_08_4eee ; $4ed6
	ld a, [wMatchWinLoseFlag] ; $4ed8
	add a, a ; $4edb
	jr nc, Label_08_4ee4 ; $4edc
	ld d, $17 ; $4ede
	farcall ShowMinigamePointResult ; $4ee0
	ret ; $4ee3
Label_08_4ee4:
	ld a, [wMinigameLevel] ; $4ee4
	add a, $12 ; $4ee7
	ld d, a ; $4ee9
	farcall ShowMinigamePointResult ; $4eea
	ret ; $4eed
Label_08_4eee:
	ld a, $0d ; $4eee
	farcall ShowCourtBanner ; $4ef0
	ld a, $0a ; $4ef3
	call StepMatchFrames ; $4ef5
	ld a, [wGameWinLoseFlag] ; $4ef8
	farcall SpawnWinLoseResultObj ; $4efb
	ld a, $0a ; $4efe
	call StepMatchFrames ; $4f00
	ld a, $2d ; $4f03
	call StepMatchFramesSkippable ; $4f05
	farcall DismissWinLoseResultObj ; $4f08
	farcall HideCourtBanner ; $4f0b
	ret ; $4f0e
Label_08_4f0f:
	ld a, [wPlayer1SetsWon] ; $4f0f
	ld b, $01 ; $4f12
	farcall LoadPlayer1ScoreDigitGfx ; $4f14
	ld a, [wPlayer2SetsWon] ; $4f17
	ld b, $01 ; $4f1a
	farcall LoadPlayer2ScoreDigitGfx ; $4f1c
	ld d, $0c ; $4f1f
	jr Label_08_4f37 ; $4f21
Label_08_4f23:
	ld a, [wPlayer1GamesWon] ; $4f23
	ld b, $01 ; $4f26
	farcall LoadPlayer1ScoreDigitGfx ; $4f28
	ld a, [wPlayer2GamesWon] ; $4f2b
	ld b, $01 ; $4f2e
	farcall LoadPlayer2ScoreDigitGfx ; $4f30
	ld d, $0b ; $4f33
	jr Label_08_4f37 ; $4f35
Label_08_4f37:
	call StepMatchFrame ; $4f37
	ld a, d ; $4f3a
	farcall ShowCourtBanner ; $4f3b
	ld a, $0a ; $4f3e
	call StepMatchFrames ; $4f40
	ld a, [wGameWinLoseFlag] ; $4f43
	farcall SpawnWinLoseResultObj ; $4f46
	ld a, $0a ; $4f49
	call StepMatchFrames ; $4f4b
	ld a, $28 ; $4f4e
	call StepMatchFramesSkippable ; $4f50
	farcall DismissWinLoseResultObj ; $4f53
	ld a, $0a ; $4f56
	call StepMatchFrames ; $4f58
	farcall SpawnGameResultObj ; $4f5b
	ld a, $0a ; $4f5e
	call StepMatchFrames ; $4f60
	ld a, $28 ; $4f63
	call StepMatchFramesSkippable ; $4f65
	farcall DismissGameResultObj ; $4f68
	farcall HideCourtBanner ; $4f6b
	ret ; $4f6e
	ld a, $00 ; $4f6f
	call SetCharState ; $4f71
	call GetCharBaseCourtPosition ; $4f74
	call SetCharPosAndTarget ; $4f77
	ld d, $01 ; $4f7a
	call SetCharAnimation ; $4f7c
	ld hl, wCharFlags ; $4f7f
	res 0, [hl] ; $4f82
	res 1, [hl] ; $4f84
	ld hl, wCharVelX ; $4f86
	xor a, a ; $4f89
	ld [hl+], a ; $4f8a
	ld [hl+], a ; $4f8b
	ld [hl+], a ; $4f8c
	ld [hl+], a ; $4f8d
	ld [hl+], a ; $4f8e
	ld [hl+], a ; $4f8f
	ret ; $4f90
	ld a, [wCharServeRole] ; $4f91
	add a, $a0 ; $4f94
	ld l, a ; $4f96
	adc a, $4f ; $4f97
	sub a, l ; $4f99
	ld h, a ; $4f9a
	ld a, [hl] ; $4f9b
	call SetCharState ; $4f9c
	ret ; $4f9f
	; $4fa0, 4 bytes (bytes:4)
	db $03, $05, $04, $05 ; 0x00
EndPointBallEffects:
	xor a, a ; $4fa4
	ld [wBallTrailEnabled], a ; $4fa5
	xor a, a ; $4fa8
	call SetBallTrailColor ; $4fa9
	xor a, a ; $4fac
	ld [wLandingMarkerActive], a ; $4fad
	ld hl, wMatchAbortFlag ; $4fb0
	ld a, [hl] ; $4fb3
	and a, $fe ; $4fb4
	ld [hl], a ; $4fb6
	ret ; $4fb7
StartPointEndReactions:
	ld hl, $4fc7 ; $4fb8
	call ForEachCharBank ; $4fbb
	call SpreadTeammateTargets ; $4fbe
	ld a, $0a ; $4fc1
	call StepMatchFrames ; $4fc3
	ret ; $4fc6
CharPointEndReaction:
	ld a, [wPointWinLoseFlag] ; $4fc7
	ld hl, wCharIndex ; $4fca
	bit 0, [hl] ; $4fcd
	jr z, Label_08_4fd3 ; $4fcf
	cpl ; $4fd1
	inc a ; $4fd2
Label_08_4fd3:
	ld [wCharPointResult], a ; $4fd3
	ld a, $07 ; $4fd6
	call SetCharState ; $4fd8
	ld hl, wCharPosDepth + 1 ; $4fdb
	ld a, [hl+] ; $4fde
	ld d, [hl] ; $4fdf
	ld e, a ; $4fe0
	ld hl, wCharPosX + 1 ; $4fe1
	ld a, [hl+] ; $4fe4
	ld h, [hl] ; $4fe5
	ld l, a ; $4fe6
	call SetCharTarget ; $4fe7
	xor a, a ; $4fea
	ld hl, wCharVelX ; $4feb
	ld [hl+], a ; $4fee
	ld [hl+], a ; $4fef
	ld [hl+], a ; $4ff0
	ld [hl+], a ; $4ff1
	ld [hl+], a ; $4ff2
	ld [hl+], a ; $4ff3
	ret ; $4ff4
SpreadTeammateTargets:
	ld a, [wOnCourtCharCountMinus1] ; $4ff5
	rst Rst00 ; $4ff8
	dw Label_00_03ae ; $4ff9 jumptable
	dw Label_00_03ae ; $4ffb jumptable
	dw SpreadFarTeamPair ; $4ffd jumptable
	dw SpreadBothTeamPairs ; $4fff jumptable
SpreadBothTeamPairs:
	wram_bank $04 ; $5001
	ld hl, wCharPosDepth + 1 ; $5007
	ld a, [hl+] ; $500a
	ld d, [hl] ; $500b
	ld e, a ; $500c
	wram_bank $06 ; $500d
	ld hl, wCharPosDepth + 1 ; $5013
	ld a, [hl+] ; $5016
	ld h, [hl] ; $5017
	ld l, a ; $5018
	call ComputePairSpread ; $5019
	wram_bank $04 ; $501c
	ld hl, wCharWalkTargetDepth ; $5022
	ld a, e ; $5025
	ld [hl+], a ; $5026
	ld [hl], d ; $5027
	wram_bank $06 ; $5028
	ld hl, wCharWalkTargetDepth ; $502e
	ld a, c ; $5031
	ld [hl+], a ; $5032
	ld [hl], b ; $5033
SpreadFarTeamPair:
	wram_bank $05 ; $5034
	ld hl, wCharPosDepth + 1 ; $503a
	ld a, [hl+] ; $503d
	ld d, [hl] ; $503e
	ld e, a ; $503f
	wram_bank $07 ; $5040
	ld hl, wCharPosDepth + 1 ; $5046
	ld a, [hl+] ; $5049
	ld h, [hl] ; $504a
	ld l, a ; $504b
	call ComputePairSpread ; $504c
	wram_bank $05 ; $504f
	ld hl, wCharWalkTargetDepth ; $5055
	ld a, e ; $5058
	ld [hl+], a ; $5059
	ld [hl], d ; $505a
	wram_bank $07 ; $505b
	ld hl, wCharWalkTargetDepth ; $5061
	ld a, c ; $5064
	ld [hl+], a ; $5065
	ld [hl], b ; $5066
	wram_bank $04 ; $5067
	ret ; $506d
ComputePairSpread:
	push hl ; $506e
	ld a, l ; $506f
	sub a, e ; $5070
	ld l, a ; $5071
	ld a, h ; $5072
	sbc a, d ; $5073
	ld h, a ; $5074
	bit 7, h ; $5075
	jr z, Label_08_507f ; $5077
	xor a, a ; $5079
	sub a, l ; $507a
	ld l, a ; $507b
	sbc a, a ; $507c
	sub a, h ; $507d
	ld h, a ; $507e
Label_08_507f:
	ld bc, $fe00 ; $507f
	add hl, bc ; $5082
	pop hl ; $5083
	jr nc, Label_08_5089 ; $5084
	ld c, l ; $5086
	ld b, h ; $5087
	ret ; $5088
Label_08_5089:
	push hl ; $5089
	bit 7, h ; $508a
	jr z, Label_08_509a ; $508c
	xor a, a ; $508e
	sub a, l ; $508f
	ld l, a ; $5090
	sbc a, a ; $5091
	sub a, h ; $5092
	ld h, a ; $5093
	xor a, a ; $5094
	sub a, e ; $5095
	ld e, a ; $5096
	sbc a, a ; $5097
	sub a, d ; $5098
	ld d, a ; $5099
Label_08_509a:
	push hl ; $509a
	add hl, de ; $509b
	sra h ; $509c
	rr l ; $509e
	ld bc, rJOYP ; $50a0
	add hl, bc ; $50a3
	ld c, l ; $50a4
	ld b, h ; $50a5
	ld hl, rJOYP ; $50a6
	add hl, bc ; $50a9
	bit 7, h ; $50aa
	jr z, Label_08_50b1 ; $50ac
	ld bc, $0100 ; $50ae
Label_08_50b1:
	pop hl ; $50b1
	ld a, l ; $50b2
	sub a, e ; $50b3
	ld l, a ; $50b4
	ld a, h ; $50b5
	sbc a, d ; $50b6
	ld h, a ; $50b7
	jr nc, Label_08_50c2 ; $50b8
	ld hl, $0200 ; $50ba
	add hl, bc ; $50bd
	ld e, l ; $50be
	ld d, h ; $50bf
	jr Label_08_50ca ; $50c0
Label_08_50c2:
	ld e, c ; $50c2
	ld d, b ; $50c3
	ld hl, $0200 ; $50c4
	add hl, de ; $50c7
	ld c, l ; $50c8
	ld b, h ; $50c9
Label_08_50ca:
	pop hl ; $50ca
	bit 7, h ; $50cb
	jr z, Label_08_50db ; $50cd
	xor a, a ; $50cf
	sub a, c ; $50d0
	ld c, a ; $50d1
	sbc a, a ; $50d2
	sub a, b ; $50d3
	ld b, a ; $50d4
	xor a, a ; $50d5
	sub a, e ; $50d6
	ld e, a ; $50d7
	sbc a, a ; $50d8
	sub a, d ; $50d9
	ld d, a ; $50da
Label_08_50db:
	ret ; $50db
BallTrailPalettes:
	; $50dc, 64 bytes (records:8)
; 8 records x 8 bytes
	dw $0180, $031f, $2a94, $0000 ; record 0
	dw $0180, $031f, $01df, $0000 ; record 1
	dw $0180, $031f, $7e00, $0000 ; record 2
	dw $0180, $031f, $589f, $0000 ; record 3
	dw $0180, $031f, $03e0, $0000 ; record 4
	dw $0180, $031f, $4009, $0000 ; record 5
	dw $0180, $031f, $7fe0, $0000 ; record 6
	dw $0180, $031f, $7ffe, $0000 ; record 7
ResetBallState:
	xor a, a ; $511c
	ld [wBallSpriteEnabled], a ; $511d
	ld [wBallShadowEnabled], a ; $5120
	ld [wBallTrailEnabled], a ; $5123
	ld [wBounceEffectTimer], a ; $5126
	ld hl, $0380 ; $5129
	ld de, $0000 ; $512c
	ld bc, $0000 ; $512f
	call SetBallPosition ; $5132
	xor a, a ; $5135
	ld hl, $c420 ; $5136
	ld [hl+], a ; $5139
	ld [hl+], a ; $513a
	ld [hl+], a ; $513b
	ld [hl+], a ; $513c
	ld [hl+], a ; $513d
	ld [hl+], a ; $513e
	ld [hl+], a ; $513f
	ld [hl+], a ; $5140
	ld [hl+], a ; $5141
	ld hl, wBallTopspin ; $5142
	ld [hl+], a ; $5145
	ld [hl+], a ; $5146
	ld [hl+], a ; $5147
	ld [hl+], a ; $5148
	ld hl, wShotAimTargetX ; $5149
	ld [hl+], a ; $514c
	ld [hl+], a ; $514d
	xor a, a ; $514e
	call SetBallTrailColor ; $514f
	ret ; $5152
UpdateBallVisuals:
	call StepBallPhysics ; $5153
	call BuildBallSlot ; $5156
	call BuildBallTrailSlots ; $5159
	call BuildBallShadowSlot ; $515c
	call BuildNetBallSlot ; $515f
	call DrawBallTouchCharEffect ; $5162
	ld a, [wMatchIsDoubles] ; $5165
	and a, a ; $5168
	jr nz, Label_08_5170 ; $5169
	ldh a, [hDebugStepMode] ; $516b
	and a, a ; $516d
	jr z, Label_08_5170 ; $516e
Label_08_5170:
	ld hl, wBallHistory + 6 ; $5170
	ld de, wBallHistory ; $5173
	ld bc, $001e ; $5176
	call CopyMemoryBC ; $5179
	ld hl, wBounceEffectTimer ; $517c
	call TickTimer ; $517f
	ld hl, wHitSparkTimer ; $5182
	call TickTimer ; $5185
	ret ; $5188
SetBallTrailColor:
	ld [wBallTrailColor], a ; $5189
	add a, a ; $518c
	add a, a ; $518d
	add a, a ; $518e
	add a, $dc ; $518f
	ld l, a ; $5191
	adc a, $50 ; $5192
	sub a, l ; $5194
	ld h, a ; $5195
	ld de, $0801 ; $5196
	call LoadPalettesImmediate ; $5199
	ret ; $519c
BuildBallSlot:
	ld hl, wBallHeight ; $519d
	ld a, [hl+] ; $51a0
	ld b, [hl] ; $51a1
	ld c, a ; $51a2
	ld hl, wBallDepth ; $51a3
	ld a, [hl+] ; $51a6
	ld d, [hl] ; $51a7
	ld e, a ; $51a8
	ld hl, wBallX ; $51a9
	ld a, [hl+] ; $51ac
	ld h, [hl] ; $51ad
	ld l, a ; $51ae
	call ProjectWorldToScreen_08 ; $51af
	push de ; $51b2
	ld e, l ; $51b3
	ld d, h ; $51b4
	ld hl, wBallHistory + 30 ; $51b5
	ld a, e ; $51b8
	ld [hl+], a ; $51b9
	ld [hl], d ; $51ba
	ld hl, wBallHistory + 32 ; $51bb
	ld a, c ; $51be
	ld [hl+], a ; $51bf
	ld [hl], b ; $51c0
	ld l, e ; $51c1
	ld h, d ; $51c2
	call ApplyCameraProjection ; $51c3
	pop hl ; $51c6
	bit 7, h ; $51c7
	jr nz, Label_08_51d7 ; $51c9
	ld a, $42 ; $51cb
	ld bc, $fe60 ; $51cd
	add hl, bc ; $51d0
	jr nc, Label_08_51e1 ; $51d1
	ld a, $44 ; $51d3
	jr Label_08_51e1 ; $51d5
Label_08_51d7:
	ld a, $42 ; $51d7
	ld bc, $01a0 ; $51d9
	add hl, bc ; $51dc
	jr c, Label_08_51e1 ; $51dd
	ld a, $40 ; $51df
Label_08_51e1:
	ld c, a ; $51e1
	ld b, $08 ; $51e2
	ld a, [wBallSpriteEnabled] ; $51e4
	and a, a ; $51e7
	jr z, Label_08_51f4 ; $51e8
	ld hl, wBallSlot ; $51ea
	ld a, c ; $51ed
	ld [hl+], a ; $51ee
	ld a, b ; $51ef
	ld [hl+], a ; $51f0
	ld a, e ; $51f1
	ld [hl+], a ; $51f2
	ld [hl], d ; $51f3
Label_08_51f4:
	ld hl, wBallHistory + 34 ; $51f4
	ld a, c ; $51f7
	add a, $08 ; $51f8
	ld [hl+], a ; $51fa
	ld [hl], b ; $51fb
	ret ; $51fc
BuildBallTrailSlots:
	ld a, [wBallTrailEnabled] ; $51fd
	and a, a ; $5200
	jr z, Label_08_5236 ; $5201
	ld hl, wBallHistory + 24 ; $5203
	ld de, wBallTrailSlots ; $5206
	call BuildTrailSlot ; $5209
	ld hl, wBallHistory + 18 ; $520c
	ld de, wBallTrailSlots + 4 ; $520f
	call BuildTrailSlot ; $5212
	ld a, [wBallTrailColor] ; $5215
	and a, a ; $5218
	jr z, Label_08_5236 ; $5219
	ld hl, wBallHistory + 12 ; $521b
	ld de, wBallTrailSlots + 8 ; $521e
	call BuildTrailSlot ; $5221
	ld hl, wBallHistory + 6 ; $5224
	ld de, wBallTrailSlots + 12 ; $5227
	call BuildTrailSlot ; $522a
	ld hl, wBallHistory ; $522d
	ld de, wBallTrailSlots + 16 ; $5230
	call BuildTrailSlot ; $5233
Label_08_5236:
	ret ; $5236
BuildTrailSlot:
	push de ; $5237
	ld a, [hl+] ; $5238
	ld e, a ; $5239
	ld a, [hl+] ; $523a
	ld d, a ; $523b
	ld a, [hl+] ; $523c
	ld c, a ; $523d
	ld a, [hl+] ; $523e
	ld b, a ; $523f
	push hl ; $5240
	ld l, e ; $5241
	ld h, d ; $5242
	call ApplyCameraProjection ; $5243
	pop hl ; $5246
	ld a, [hl+] ; $5247
	ld b, [hl] ; $5248
	ld c, a ; $5249
	pop hl ; $524a
	ld a, c ; $524b
	ld [hl+], a ; $524c
	ld a, b ; $524d
	ld [hl+], a ; $524e
	ld a, e ; $524f
	ld [hl+], a ; $5250
	ld [hl], d ; $5251
	ret ; $5252
BuildBallShadowSlot:
	ld bc, $0000 ; $5253
	ld hl, wBallDepth ; $5256
	ld a, [hl+] ; $5259
	ld d, [hl] ; $525a
	ld e, a ; $525b
	ld hl, wBallX ; $525c
	ld a, [hl+] ; $525f
	ld h, [hl] ; $5260
	ld l, a ; $5261
	call ProjectWorldToScreen_08 ; $5262
	ld e, l ; $5265
	ld d, h ; $5266
	ld hl, wBallGroundProjX ; $5267
	ld a, e ; $526a
	ld [hl+], a ; $526b
	ld [hl], d ; $526c
	ld hl, wBallGroundProjY ; $526d
	ld a, c ; $5270
	ld [hl+], a ; $5271
	ld [hl], b ; $5272
	ld l, e ; $5273
	ld h, d ; $5274
	ld a, [wBallShadowEnabled] ; $5275
	and a, a ; $5278
	jr z, Label_08_528b ; $5279
	call ApplyCameraProjection ; $527b
	ld bc, $0846 ; $527e
	ld hl, wBallShadowSlot ; $5281
	ld a, c ; $5284
	ld [hl+], a ; $5285
	ld a, b ; $5286
	ld [hl+], a ; $5287
	ld a, e ; $5288
	ld [hl+], a ; $5289
	ld [hl], d ; $528a
Label_08_528b:
	ret ; $528b
BuildNetBallSlot:
	ld a, [wPointOutcome] ; $528c
	and a, a ; $528f
	ret z ; $5290
	ld hl, wBallDepth ; $5291
	ld a, [hl+] ; $5294
	ld h, [hl] ; $5295
	ld l, a ; $5296
	bit 7, h ; $5297
	ret z ; $5299
	ld de, $01e0 ; $529a
	add hl, de ; $529d
	bit 7, h ; $529e
	ret nz ; $52a0
	ld hl, wBallX ; $52a1
	ld a, [hl+] ; $52a4
	ld h, [hl] ; $52a5
	ld l, a ; $52a6
	bit 7, h ; $52a7
	jr z, Label_08_52b1 ; $52a9
	xor a, a ; $52ab
	sub a, l ; $52ac
	ld l, a ; $52ad
	sbc a, a ; $52ae
	sub a, h ; $52af
	ld h, a ; $52b0
Label_08_52b1:
	ld de, $fdc0 ; $52b1
	add hl, de ; $52b4
	ret c ; $52b5
	ld hl, wBallHistory + 30 ; $52b6
	ld a, [hl+] ; $52b9
	ld h, [hl] ; $52ba
	ld l, a ; $52bb
	ld bc, $fe80 ; $52bc
	call ApplyCameraProjection ; $52bf
	ld a, d ; $52c2
	and a, $fe ; $52c3
	ld d, a ; $52c5
	ldh a, [hScrollX] ; $52c6
	and a, $01 ; $52c8
	or a, d ; $52ca
	ld d, a ; $52cb
	ld bc, $0b4e ; $52cc
	ld hl, wNetBallSlot ; $52cf
	ld a, c ; $52d2
	ld [hl+], a ; $52d3
	ld a, b ; $52d4
	ld [hl+], a ; $52d5
	ld a, e ; $52d6
	ld [hl+], a ; $52d7
	ld [hl], d ; $52d8
	ret ; $52d9
StartLandingMarker:
	ld a, [wCurrentShotType] ; $52da
	cp a, SHOTTYPE_LOB ; $52dd
	jr z, Label_08_52e8 ; $52df
	ld a, [wFallbackTrajectoryFlag] ; $52e1
	and a, a ; $52e4
	jr nz, Label_08_52e8 ; $52e5
	ret ; $52e7
Label_08_52e8:
	ld hl, $fec0 ; $52e8
	call OffsetFromBallLanding ; $52eb
	push hl ; $52ee
	ld l, e ; $52ef
	ld h, d ; $52f0
	bit 7, h ; $52f1
	jr z, Label_08_52fb ; $52f3
	xor a, a ; $52f5
	sub a, l ; $52f6
	ld l, a ; $52f7
	sbc a, a ; $52f8
	sub a, h ; $52f9
	ld h, a ; $52fa
Label_08_52fb:
	ld bc, $ff80 ; $52fb
	add hl, bc ; $52fe
	bit 7, h ; $52ff
	pop hl ; $5301
	ret nz ; $5302
	push hl ; $5303
	ld l, e ; $5304
	ld h, d ; $5305
	bit 7, h ; $5306
	jr z, Label_08_5310 ; $5308
	xor a, a ; $530a
	sub a, l ; $530b
	ld l, a ; $530c
	sbc a, a ; $530d
	sub a, h ; $530e
	ld h, a ; $530f
Label_08_5310:
	ld bc, rJOYP ; $5310
	add hl, bc ; $5313
	bit 7, h ; $5314
	pop hl ; $5316
	jr z, Label_08_5326 ; $5317
	ld a, [wBallTargetDepth + 1] ; $5319
	bit 7, a ; $531c
	ld de, $0100 ; $531e
	jr z, Label_08_5326 ; $5321
	ld de, rJOYP ; $5323
Label_08_5326:
	ld bc, $0000 ; $5326
	call ProjectWorldToScreen_08 ; $5329
	ld e, l ; $532c
	ld d, h ; $532d
	ld hl, wLandingMarkerX ; $532e
	ld a, e ; $5331
	ld [hl+], a ; $5332
	ld [hl], d ; $5333
	ld hl, wLandingMarkerY ; $5334
	ld a, c ; $5337
	ld [hl+], a ; $5338
	ld [hl], b ; $5339
	ld a, $01 ; $533a
	ld [wLandingMarkerActive], a ; $533c
	sound $6d ; $533f
	ret ; $5341
DrawLandingMarker:
	ld a, [wLandingMarkerActive] ; $5342
	and a, a ; $5345
	ret z ; $5346
	ld hl, wLandingMarkerY ; $5347
	ld a, [hl+] ; $534a
	ld b, [hl] ; $534b
	ld c, a ; $534c
	ld hl, wLandingMarkerX ; $534d
	ld a, [hl+] ; $5350
	ld h, [hl] ; $5351
	ld l, a ; $5352
	call ApplyCameraProjection ; $5353
	ld a, e ; $5356
	add a, $08 ; $5357
	ld e, a ; $5359
	ld bc, $097c ; $535a
	call QueueSprite16 ; $535d
	ldh a, [$ffe9] ; $5360
	and a, $0f ; $5362
	add a, $73 ; $5364
	ld l, a ; $5366
	adc a, $53 ; $5367
	sub a, l ; $5369
	ld h, a ; $536a
	ld a, [hl] ; $536b
	cp a, $ff ; $536c
	ret z ; $536e
	farcall LoadBallTouchCharEffectTilesB ; $536f
	ret ; $5372
	; $5373, 16 bytes (bytes:8)
	db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $00 ; 0x00
	db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $01 ; 0x08
StartBounceEffect:
	ld hl, wBallHeight ; $5383
	ld a, [hl+] ; $5386
	ld b, [hl] ; $5387
	ld c, a ; $5388
	ld hl, wBallDepth ; $5389
	ld a, [hl+] ; $538c
	ld d, [hl] ; $538d
	ld e, a ; $538e
	ld hl, wBallX ; $538f
	ld a, [hl+] ; $5392
	ld h, [hl] ; $5393
	ld l, a ; $5394
	call ProjectWorldToScreen_08 ; $5395
	ld e, l ; $5398
	ld d, h ; $5399
	ld hl, wBounceEffectX ; $539a
	ld a, e ; $539d
	ld [hl+], a ; $539e
	ld [hl], d ; $539f
	ld hl, wBounceEffectY ; $53a0
	ld a, c ; $53a3
	ld [hl+], a ; $53a4
	ld [hl], b ; $53a5
	ld a, $14 ; $53a6
	ld [wBounceEffectTimer], a ; $53a8
	ret ; $53ab
DrawBounceEffect:
	ld a, [wBounceEffectTimer] ; $53ac
	and a, a ; $53af
	ret z ; $53b0
	ld hl, wBounceEffectY ; $53b1
	ld a, [hl+] ; $53b4
	ld b, [hl] ; $53b5
	ld c, a ; $53b6
	ld hl, wBounceEffectX ; $53b7
	ld a, [hl+] ; $53ba
	ld h, [hl] ; $53bb
	ld l, a ; $53bc
	call ApplyCameraProjection ; $53bd
	ld bc, $0a60 ; $53c0
	ld a, [wBounceEffectTimer] ; $53c3
	cp a, $0a ; $53c6
	jr nc, Label_08_53cc ; $53c8
	inc c ; $53ca
	inc c ; $53cb
Label_08_53cc:
	call QueueSprite ; $53cc
	ret ; $53cf
StartHitEffect:
	ld hl, wBallHeight ; $53d0
	ld a, [hl+] ; $53d3
	ld b, [hl] ; $53d4
	ld c, a ; $53d5
	ld hl, wBallDepth ; $53d6
	ld a, [hl+] ; $53d9
	ld d, [hl] ; $53da
	ld e, a ; $53db
	ld hl, wBallX ; $53dc
	ld a, [hl+] ; $53df
	ld h, [hl] ; $53e0
	ld l, a ; $53e1
	call ProjectWorldToScreen_08 ; $53e2
	ld e, l ; $53e5
	ld d, h ; $53e6
	ld hl, wHitEffectX ; $53e7
	ld a, e ; $53ea
	ld [hl+], a ; $53eb
	ld [hl], d ; $53ec
	ld hl, wHitEffectY ; $53ed
	ld a, c ; $53f0
	ld [hl+], a ; $53f1
	ld [hl], b ; $53f2
	ld a, [wSpecialShotFlag] ; $53f3
	and a, a ; $53f6
	jr nz, Label_08_5406 ; $53f7
	ld a, [wShotChargeLevel] ; $53f9
	cp a, $3f ; $53fc
	jr z, Label_08_5406 ; $53fe
	ld a, $10 ; $5400
	ld [wHitSparkTimer], a ; $5402
	ret ; $5405
Label_08_5406:
	ld a, $10 ; $5406
	ld [wSpecialHitTimer], a ; $5408
	sound $55 ; $540b
	ret ; $540d
DrawHitSpark:
	ld a, [wHitSparkTimer] ; $540e
	and a, a ; $5411
	ret z ; $5412
	ld hl, wHitEffectY ; $5413
	ld a, [hl+] ; $5416
	ld b, [hl] ; $5417
	ld c, a ; $5418
	ld hl, wHitEffectX ; $5419
	ld a, [hl+] ; $541c
	ld h, [hl] ; $541d
	ld l, a ; $541e
	call ApplyCameraProjection ; $541f
	ld a, [wHitSparkTimer] ; $5422
	rra ; $5425
	rra ; $5426
	and a, $03 ; $5427
	cpl ; $5429
	add a, $04 ; $542a
	add a, a ; $542c
	add a, $68 ; $542d
	ld c, a ; $542f
	ld b, $0a ; $5430
	call QueueSprite ; $5432
	ret ; $5435
DrawSpecialHitEffect:
	ld a, [wSpecialHitTimer] ; $5436
	and a, a ; $5439
	ret z ; $543a
	ld hl, wHitEffectY ; $543b
	ld a, [hl+] ; $543e
	ld b, [hl] ; $543f
	ld c, a ; $5440
	ld hl, wHitEffectX ; $5441
	ld a, [hl+] ; $5444
	ld h, [hl] ; $5445
	ld l, a ; $5446
	call ApplyCameraProjection ; $5447
	ld a, e ; $544a
	add a, $08 ; $544b
	ld e, a ; $544d
	ld bc, $0974 ; $544e
	call QueueSprite16 ; $5451
	ld hl, wSpecialHitTimer ; $5454
	call TickTimer ; $5457
	ld a, [wSpecialHitTimer] ; $545a
	add a, $6c ; $545d
	ld l, a ; $545f
	adc a, $54 ; $5460
	sub a, l ; $5462
	ld h, a ; $5463
	ld a, [hl] ; $5464
	cp a, $ff ; $5465
	ret z ; $5467
	farcall LoadSpecialHitEffectTiles ; $5468
	ret ; $546b
	; $546c, 16 bytes (bytes:4)
	db $ff, $ff, $ff, $03 ; 0x00
	db $ff, $ff, $ff, $02 ; 0x04
	db $ff, $ff, $ff, $01 ; 0x08
	db $ff, $ff, $ff, $00 ; 0x0c
StartBallTouchCharEffect:
	ld a, $28 ; $547c
	ld [wBallTouchCharTimer], a ; $547e
	ret ; $5481
DrawBallTouchCharEffect:
	ld a, [wBallTouchCharTimer] ; $5482
	and a, a ; $5485
	ret z ; $5486
	ld a, [wBallTouchCharIndex] ; $5487
	call CharIndexToWramBank ; $548a
	ld a, a ; $548d
	wram_bank ; $548e
	ld a, [wCharScreenX] ; $5492
	add a, $08 ; $5495
	ld d, a ; $5497
	ld a, [wCharScreenY] ; $5498
	add a, $f8 ; $549b
	ld e, a ; $549d
	wram_bank $04 ; $549e
	ld bc, $0a78 ; $54a4
	call QueueSprite16 ; $54a7
	ld hl, wBallTouchCharTimer ; $54aa
	call TickTimer ; $54ad
	ld a, [wBallTouchCharTimer] ; $54b0
	add a, $c2 ; $54b3
	ld l, a ; $54b5
	adc a, $54 ; $54b6
	sub a, l ; $54b8
	ld h, a ; $54b9
	ld a, [hl] ; $54ba
	cp a, $ff ; $54bb
	ret z ; $54bd
	farcall LoadBallTouchCharEffectTilesA ; $54be
	ret ; $54c1
	; $54c2, 40 bytes (bytes:8)
	db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $00 ; 0x00
	db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $01 ; 0x08
	db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $00 ; 0x10
	db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $01 ; 0x18
	db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $00 ; 0x20
	ld bc, $0000 ; $54ea
	ld hl, wShotAimTargetDepth ; $54ed
	ld a, [hl+] ; $54f0
	ld d, [hl] ; $54f1
	ld e, a ; $54f2
	ld hl, wShotAimTargetX ; $54f3
	ld a, [hl+] ; $54f6
	ld h, [hl] ; $54f7
	ld l, a ; $54f8
	call ProjectWorldToScreen_08 ; $54f9
	call ApplyCameraProjection ; $54fc
	ld bc, $095e ; $54ff
	call QueueSprite ; $5502
	ret ; $5505
	ld bc, $0000 ; $5506
	ld hl, wBallTargetDepth ; $5509
	ld a, [hl+] ; $550c
	ld d, [hl] ; $550d
	ld e, a ; $550e
	ld hl, wBallTargetX ; $550f
	ld a, [hl+] ; $5512
	ld h, [hl] ; $5513
	ld l, a ; $5514
	call ProjectWorldToScreen_08 ; $5515
	call ApplyCameraProjection ; $5518
	ld bc, $0c5e ; $551b
	call QueueSprite ; $551e
	ret ; $5521
DrawTargetZone:
	ld a, [wTargetZoneEnabled] ; $5522
	and a, a ; $5525
	ret z ; $5526
	ld hl, wTargetZoneDepth1 ; $5527
	ld a, [hl+] ; $552a
	ld d, [hl] ; $552b
	ld e, a ; $552c
	ld hl, wTargetZoneX1 ; $552d
	ld a, [hl+] ; $5530
	ld h, [hl] ; $5531
	ld l, a ; $5532
	ld bc, $0000 ; $5533
	call ProjectWorldToScreen_08 ; $5536
	call ApplyCameraProjection ; $5539
	ld hl, SpriteTemplate_08_55a0 ; $553c
	ld bc, $0920 ; $553f
	call QueueSpriteTemplate ; $5542
	ld hl, wTargetZoneDepth1 ; $5545
	ld a, [hl+] ; $5548
	ld d, [hl] ; $5549
	ld e, a ; $554a
	ld hl, wTargetZoneX2 ; $554b
	ld a, [hl+] ; $554e
	ld h, [hl] ; $554f
	ld l, a ; $5550
	ld bc, $0000 ; $5551
	call ProjectWorldToScreen_08 ; $5554
	call ApplyCameraProjection ; $5557
	ld hl, SpriteTemplate_08_55a5 ; $555a
	ld bc, $0922 ; $555d
	call QueueSpriteTemplate ; $5560
	ld hl, wTargetZoneDepth2 ; $5563
	ld a, [hl+] ; $5566
	ld d, [hl] ; $5567
	ld e, a ; $5568
	ld hl, wTargetZoneX1 ; $5569
	ld a, [hl+] ; $556c
	ld h, [hl] ; $556d
	ld l, a ; $556e
	ld bc, $0000 ; $556f
	call ProjectWorldToScreen_08 ; $5572
	call ApplyCameraProjection ; $5575
	ld hl, SpriteTemplate_08_55aa ; $5578
	ld bc, $0924 ; $557b
	call QueueSpriteTemplate ; $557e
	ld hl, wTargetZoneDepth2 ; $5581
	ld a, [hl+] ; $5584
	ld d, [hl] ; $5585
	ld e, a ; $5586
	ld hl, wTargetZoneX2 ; $5587
	ld a, [hl+] ; $558a
	ld h, [hl] ; $558b
	ld l, a ; $558c
	ld bc, $0000 ; $558d
	call ProjectWorldToScreen_08 ; $5590
	call ApplyCameraProjection ; $5593
	ld hl, SpriteTemplate_08_55af ; $5596
	ld bc, $0926 ; $5599
	call QueueSpriteTemplate ; $559c
	ret ; $559f
SpriteTemplate_08_55a0:
	; $55a0, 5 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite_end
SpriteTemplate_08_55a5:
	; $55a5, 5 bytes (sprite_template)
	oam_sprite $10, $01, $00, $00
	oam_sprite_end
SpriteTemplate_08_55aa:
	; $55aa, 5 bytes (sprite_template)
	oam_sprite $09, $08, $00, $00
	oam_sprite_end
SpriteTemplate_08_55af:
	; $55af, 5 bytes (sprite_template)
	oam_sprite $09, $01, $00, $00
	oam_sprite_end
ApplyBallAirDrag:
	ld a, [$c42d] ; $55b4
	bit 7, a ; $55b7
	jr z, Label_08_55bd ; $55b9
	cpl ; $55bb
	inc a ; $55bc
Label_08_55bd:
	swap a ; $55bd
	and a, $0f ; $55bf
	inc a ; $55c1
	ld b, a ; $55c2
	push bc ; $55c3
	ld hl, wBallVelocityX ; $55c4
	ld a, [hl+] ; $55c7
	ld h, [hl] ; $55c8
	ld l, a ; $55c9
	sra h ; $55ca
	rr l ; $55cc
	ld a, b ; $55ce
	call MulSignedHLByAFrac ; $55cf
	ld e, l ; $55d2
	ld d, h ; $55d3
	call NegateADE ; $55d4
	ld hl, $c420 ; $55d7
	call Add24ToMem24 ; $55da
	pop bc ; $55dd
	push bc ; $55de
	ld hl, wBallVelocityDepth ; $55df
	ld a, [hl+] ; $55e2
	ld h, [hl] ; $55e3
	ld l, a ; $55e4
	sra h ; $55e5
	rr l ; $55e7
	ld a, b ; $55e9
	call MulSignedHLByAFrac ; $55ea
	ld e, l ; $55ed
	ld d, h ; $55ee
	call NegateADE ; $55ef
	ld hl, $c423 ; $55f2
	call Add24ToMem24 ; $55f5
	pop bc ; $55f8
	ld hl, wBallVelocityHeight ; $55f9
	ld a, [hl+] ; $55fc
	ld h, [hl] ; $55fd
	ld l, a ; $55fe
	sra h ; $55ff
	rr l ; $5601
	ld a, b ; $5603
	call MulSignedHLByAFrac ; $5604
	ld e, l ; $5607
	ld d, h ; $5608
	call NegateADE ; $5609
	ld hl, $c426 ; $560c
	call Add24ToMem24 ; $560f
	ret ; $5612
ApplyBallSpin:
	ld hl, wBallSideSpin ; $5613
	ld a, [hl+] ; $5616
	or a, [hl] ; $5617
	jp z, Label_08_56a9 ; $5618
	ld hl, wBallVelocityDepth ; $561b
	ld a, [hl+] ; $561e
	ld d, [hl] ; $561f
	ld e, a ; $5620
	ld hl, wBallSideSpin ; $5621
	ld a, [hl+] ; $5624
	ld h, [hl] ; $5625
	ld l, a ; $5626
	call MulHLByDEAbs ; $5627
	ldh a, [hMulResult + 1] ; $562a
	ld e, l ; $562c
	ld d, h ; $562d
	sra d ; $562e
	rr e ; $5630
	rra ; $5632
	sra d ; $5633
	rr e ; $5635
	rra ; $5637
	sra d ; $5638
	rr e ; $563a
	rra ; $563c
	sra d ; $563d
	rr e ; $563f
	rra ; $5641
	ld hl, hMathSign ; $5642
	bit 7, [hl] ; $5645
	jr nz, Label_08_564c ; $5647
	call NegateADE ; $5649
Label_08_564c:
	push af ; $564c
	push de ; $564d
	ld hl, wBallVelocityX ; $564e
	ld a, [hl+] ; $5651
	ld d, [hl] ; $5652
	ld e, a ; $5653
	ld hl, wBallSideSpin ; $5654
	ld a, [hl+] ; $5657
	ld h, [hl] ; $5658
	ld l, a ; $5659
	call MulHLByDEAbs ; $565a
	ldh a, [hMulResult + 1] ; $565d
	ld e, l ; $565f
	ld d, h ; $5660
	sra d ; $5661
	rr e ; $5663
	rra ; $5665
	sra d ; $5666
	rr e ; $5668
	rra ; $566a
	sra d ; $566b
	rr e ; $566d
	rra ; $566f
	sra d ; $5670
	rr e ; $5672
	rra ; $5674
	ld hl, hMathSign ; $5675
	bit 7, [hl] ; $5678
	jr z, Label_08_567f ; $567a
	call NegateADE ; $567c
Label_08_567f:
	ld hl, $c423 ; $567f
	call Add24ToMem24 ; $5682
	pop de ; $5685
	pop af ; $5686
	ld hl, $c420 ; $5687
	call Add24ToMem24 ; $568a
	ld hl, wBallSideSpin ; $568d
	ld a, [hl+] ; $5690
	ld h, [hl] ; $5691
	ld l, a ; $5692
	ld a, h ; $5693
	add a, a ; $5694
	sbc a, a ; $5695
	ld d, a ; $5696
	ld e, h ; $5697
	xor a, a ; $5698
	sub a, e ; $5699
	ld e, a ; $569a
	sbc a, a ; $569b
	sub a, d ; $569c
	ld d, a ; $569d
	add hl, de ; $569e
	add hl, de ; $569f
	add hl, de ; $56a0
	ld a, l ; $56a1
	ld [wBallSideSpin], a ; $56a2
	ld a, h ; $56a5
	ld [wBallSideSpin + 1], a ; $56a6
Label_08_56a9:
	ld hl, wBallTopspin ; $56a9
	ld a, [hl+] ; $56ac
	or a, [hl] ; $56ad
	jp z, Label_08_5766 ; $56ae
	ld hl, wBallVelocityHeight ; $56b1
	ld a, [hl+] ; $56b4
	ld d, [hl] ; $56b5
	ld e, a ; $56b6
	ld hl, wBallTopspin ; $56b7
	ld a, [hl+] ; $56ba
	ld h, [hl] ; $56bb
	ld l, a ; $56bc
	call MulHLByDEAbs ; $56bd
	ldh a, [hMulResult + 1] ; $56c0
	ld e, l ; $56c2
	ld d, h ; $56c3
	sra d ; $56c4
	rr e ; $56c6
	rra ; $56c8
	sra d ; $56c9
	rr e ; $56cb
	rra ; $56cd
	sra d ; $56ce
	rr e ; $56d0
	rra ; $56d2
	sra d ; $56d3
	rr e ; $56d5
	rra ; $56d7
	sra d ; $56d8
	rr e ; $56da
	rra ; $56dc
	ld d, e ; $56dd
	ld e, a ; $56de
	ld hl, hMathSign ; $56df
	bit 7, [hl] ; $56e2
	jr nz, Label_08_56ec ; $56e4
	xor a, a ; $56e6
	sub a, e ; $56e7
	ld e, a ; $56e8
	sbc a, a ; $56e9
	sub a, d ; $56ea
	ld d, a ; $56eb
Label_08_56ec:
	push de ; $56ec
	ld hl, wBallSpeedHorizontal ; $56ed
	ld a, [hl+] ; $56f0
	ld d, [hl] ; $56f1
	ld e, a ; $56f2
	ld hl, wBallTopspin ; $56f3
	ld a, [hl+] ; $56f6
	ld h, [hl] ; $56f7
	ld l, a ; $56f8
	call MulHLByDEAbs ; $56f9
	ldh a, [hMulResult + 1] ; $56fc
	ld e, l ; $56fe
	ld d, h ; $56ff
	sra d ; $5700
	rr e ; $5702
	rra ; $5704
	sra d ; $5705
	rr e ; $5707
	rra ; $5709
	sra d ; $570a
	rr e ; $570c
	rra ; $570e
	sra d ; $570f
	rr e ; $5711
	rra ; $5713
	ld hl, hMathSign ; $5714
	bit 7, [hl] ; $5717
	jr z, Label_08_571e ; $5719
	call NegateADE ; $571b
Label_08_571e:
	ld hl, $c426 ; $571e
	call Add24ToMem24 ; $5721
	ld hl, wBallHeadingAngle ; $5724
	ld a, [hl+] ; $5727
	ld b, [hl] ; $5728
	ld c, a ; $5729
	pop hl ; $572a
	call MulSinCosSigned ; $572b
	ld c, l ; $572e
	ld b, h ; $572f
	ld l, e ; $5730
	ld h, d ; $5731
	add hl, hl ; $5732
	sbc a, a ; $5733
	ld d, a ; $5734
	ld e, h ; $5735
	ld a, l ; $5736
	ld hl, $c423 ; $5737
	call Add24ToMem24 ; $573a
	ld l, c ; $573d
	ld h, b ; $573e
	add hl, hl ; $573f
	sbc a, a ; $5740
	ld d, a ; $5741
	ld e, h ; $5742
	ld a, l ; $5743
	ld hl, $c420 ; $5744
	call Add24ToMem24 ; $5747
	ld hl, wBallTopspin ; $574a
	ld a, [hl+] ; $574d
	ld h, [hl] ; $574e
	ld l, a ; $574f
	ld a, h ; $5750
	add a, a ; $5751
	sbc a, a ; $5752
	ld d, a ; $5753
	ld e, h ; $5754
	xor a, a ; $5755
	sub a, e ; $5756
	ld e, a ; $5757
	sbc a, a ; $5758
	sub a, d ; $5759
	ld d, a ; $575a
	add hl, de ; $575b
	add hl, de ; $575c
	add hl, de ; $575d
	ld a, l ; $575e
	ld [wBallTopspin], a ; $575f
	ld a, h ; $5762
	ld [wBallTopspin + 1], a ; $5763
Label_08_5766:
	ret ; $5766
StepBallPhysics:
	xor a, a ; $5767
	ld [wBallBounceEvent], a ; $5768
	ld hl, $c400 ; $576b
	ld de, $c410 ; $576e
	ld bc, $000c ; $5771
	call CopyMemoryBC ; $5774
	ld hl, $c400 ; $5777
	ld de, $c420 ; $577a
	call AddVel24ToPos32 ; $577d
	ld hl, $c404 ; $5780
	ld de, $c423 ; $5783
	call AddVel24ToPos32 ; $5786
	ld hl, $c408 ; $5789
	ld de, $c426 ; $578c
	call AddVel24ToPos32 ; $578f
	call BounceBallOffCourtFences ; $5792
	call HandleBallNetCrossing ; $5795
	ld b, $00 ; $5798
	ld a, [wBallDepth + 1] ; $579a
	add a, a ; $579d
	rl b ; $579e
	ld a, [wBallX + 1] ; $57a0
	add a, a ; $57a3
	rl b ; $57a4
	ld hl, wBallCourtQuadrant ; $57a6
	ld [hl], b ; $57a9
	call UpdateBallAnglesAndSpeed ; $57aa
	call ApplyBallAirDrag ; $57ad
	call ApplyBallSpin ; $57b0
	call GetBallHeightSign ; $57b3
	cp a, $ff ; $57b6
	jr z, Label_08_57bc ; $57b8
	jr Label_08_57c6 ; $57ba
Label_08_57bc:
	ld de, $4a00 ; $57bc
	ld hl, $c426 ; $57bf
	call AddDEToMem24 ; $57c2
	ret ; $57c5
Label_08_57c6:
	call ApplyCourtBounceDamping ; $57c6
	ld hl, $c408 ; $57c9
	ld a, [hl] ; $57cc
	cpl ; $57cd
	add a, $01 ; $57ce
	ld [hl+], a ; $57d0
	ld a, [hl] ; $57d1
	cpl ; $57d2
	adc a, $00 ; $57d3
	ld [hl+], a ; $57d5
	ld a, [hl] ; $57d6
	cpl ; $57d7
	adc a, $00 ; $57d8
	ld [hl+], a ; $57da
	ld a, [hl] ; $57db
	cpl ; $57dc
	adc a, $00 ; $57dd
	ld [hl+], a ; $57df
	call GetBallHeightSign ; $57e0
	and a, a ; $57e3
	jr z, Label_08_5813 ; $57e4
	ld a, $01 ; $57e6
	ld [wBallBounceEvent], a ; $57e8
	ld hl, $c426 ; $57eb
	ld a, [hl] ; $57ee
	cpl ; $57ef
	ld [hl+], a ; $57f0
	ld a, [hl] ; $57f1
	cpl ; $57f2
	ld [hl+], a ; $57f3
	ld a, [hl] ; $57f4
	cpl ; $57f5
	ld [hl+], a ; $57f6
	ld hl, wBallVelocityHeight ; $57f7
	ld a, [hl+] ; $57fa
	ld h, [hl] ; $57fb
	ld l, a ; $57fc
	ld de, $0250 ; $57fd
	add hl, de ; $5800
	bit 7, h ; $5801
	jr nz, Label_08_5813 ; $5803
	xor a, a ; $5805
	ld hl, $c408 ; $5806
	ld [hl+], a ; $5809
	ld [hl+], a ; $580a
	ld [hl+], a ; $580b
	ld [hl+], a ; $580c
	ld hl, $c426 ; $580d
	ld [hl+], a ; $5810
	ld [hl+], a ; $5811
	ld [hl+], a ; $5812
Label_08_5813:
	ret ; $5813
HandleBallNetCrossing:
	xor a, a ; $5814
	ld [wBallCrossedNetFlag], a ; $5815
	ld hl, wBallDepth + 1 ; $5818
	ld a, [hl] ; $581b
	ld hl, wBallPrevDepth + 1 ; $581c
	xor a, [hl] ; $581f
	bit 7, a ; $5820
	jp z, Label_08_58a2 ; $5822
	ld a, $01 ; $5825
	ld [wBallCrossedNetFlag], a ; $5827
	ld a, [$c7b9] ; $582a
	and a, a ; $582d
	jr nz, Label_08_58a2 ; $582e
	ld hl, wNetHeight ; $5830
	ld a, [hl+] ; $5833
	ld d, [hl] ; $5834
	ld e, a ; $5835
	ld hl, wBallHeight ; $5836
	ld a, [hl+] ; $5839
	ld h, [hl] ; $583a
	ld l, a ; $583b
	add hl, de ; $583c
	bit 7, h ; $583d
	jr nz, Label_08_58a2 ; $583f
	sound $5a ; $5841
	call StartBounceEffect ; $5843
	ld a, $01 ; $5846
	ld [wBallHasBouncedFlag], a ; $5848
	ld hl, $c404 ; $584b
	ld a, [hl] ; $584e
	cpl ; $584f
	ld [hl+], a ; $5850
	ld a, [hl] ; $5851
	cpl ; $5852
	ld [hl+], a ; $5853
	ld a, [hl] ; $5854
	cpl ; $5855
	ld [hl+], a ; $5856
	ld a, [hl] ; $5857
	cpl ; $5858
	ld [hl+], a ; $5859
	ld hl, wBallVelocityX ; $585a
	ld a, [hl+] ; $585d
	ld d, [hl] ; $585e
	ld e, a ; $585f
	sra d ; $5860
	rr e ; $5862
	sra d ; $5864
	rr e ; $5866
	ld hl, wBallVelocityX ; $5868
	ld a, e ; $586b
	ld [hl+], a ; $586c
	ld [hl], d ; $586d
	ld hl, wBallHeight ; $586e
	ld a, [hl+] ; $5871
	ld d, [hl] ; $5872
	ld e, a ; $5873
	ld hl, $005a ; $5874
	add hl, de ; $5877
	bit 7, h ; $5878
	jr nz, Label_08_58f5 ; $587a
	ld hl, $0058 ; $587c
	add hl, de ; $587f
	bit 7, h ; $5880
	jr nz, Label_08_58a3 ; $5882
	ld hl, wBallVelocityDepth ; $5884
	ld a, [hl+] ; $5887
	ld d, [hl] ; $5888
	ld e, a ; $5889
	xor a, a ; $588a
	sub a, e ; $588b
	ld e, a ; $588c
	sbc a, a ; $588d
	sub a, d ; $588e
	ld d, a ; $588f
	sra d ; $5890
	rr e ; $5892
	sra d ; $5894
	rr e ; $5896
	sra d ; $5898
	rr e ; $589a
	ld hl, wBallVelocityDepth ; $589c
	ld a, e ; $589f
	ld [hl+], a ; $58a0
	ld [hl], d ; $58a1
Label_08_58a2:
	ret ; $58a2
Label_08_58a3:
	ld hl, wBallVelocityDepth ; $58a3
	ld a, [hl+] ; $58a6
	ld d, [hl] ; $58a7
	ld e, a ; $58a8
	sra d ; $58a9
	rr e ; $58ab
	sra d ; $58ad
	rr e ; $58af
	sra d ; $58b1
	rr e ; $58b3
	bit 7, d ; $58b5
	jr z, Label_08_58bf ; $58b7
	xor a, a ; $58b9
	sub a, e ; $58ba
	ld e, a ; $58bb
	sbc a, a ; $58bc
	sub a, d ; $58bd
	ld d, a ; $58be
Label_08_58bf:
	call AdvanceMatchRng ; $58bf
	ld h, $00 ; $58c2
	ld l, a ; $58c4
	add hl, hl ; $58c5
	add hl, hl ; $58c6
	add hl, de ; $58c7
	ld e, l ; $58c8
	ld d, h ; $58c9
	xor a, a ; $58ca
	sub a, e ; $58cb
	ld e, a ; $58cc
	sbc a, a ; $58cd
	sub a, d ; $58ce
	ld d, a ; $58cf
	ld hl, wBallVelocityHeight ; $58d0
	ld a, e ; $58d3
	ld [hl+], a ; $58d4
	ld [hl], d ; $58d5
	ld hl, wBallVelocityDepth ; $58d6
	ld a, [hl+] ; $58d9
	ld d, [hl] ; $58da
	ld e, a ; $58db
	xor a, a ; $58dc
	sub a, e ; $58dd
	ld e, a ; $58de
	sbc a, a ; $58df
	sub a, d ; $58e0
	ld d, a ; $58e1
	sra d ; $58e2
	rr e ; $58e4
	sra d ; $58e6
	rr e ; $58e8
	sra d ; $58ea
	rr e ; $58ec
	ld hl, wBallVelocityDepth ; $58ee
	ld a, e ; $58f1
	ld [hl+], a ; $58f2
	ld [hl], d ; $58f3
	ret ; $58f4
Label_08_58f5:
	ld hl, $c408 ; $58f5
	xor a, a ; $58f8
	ld [hl+], a ; $58f9
	ld [hl+], a ; $58fa
	ld de, hPeakLY ; $58fb
	ld a, e ; $58fe
	ld [hl+], a ; $58ff
	ld [hl], d ; $5900
	ld hl, wBallVelocityDepth ; $5901
	ld a, [hl+] ; $5904
	ld d, [hl] ; $5905
	ld e, a ; $5906
	sra d ; $5907
	rr e ; $5909
	sra d ; $590b
	rr e ; $590d
	sra d ; $590f
	rr e ; $5911
	bit 7, d ; $5913
	jr z, Label_08_591d ; $5915
	xor a, a ; $5917
	sub a, e ; $5918
	ld e, a ; $5919
	sbc a, a ; $591a
	sub a, d ; $591b
	ld d, a ; $591c
Label_08_591d:
	call AdvanceMatchRng ; $591d
	ld h, $00 ; $5920
	ld l, a ; $5922
	add hl, hl ; $5923
	add hl, hl ; $5924
	add hl, de ; $5925
	ld e, l ; $5926
	ld d, h ; $5927
	xor a, a ; $5928
	sub a, e ; $5929
	ld e, a ; $592a
	sbc a, a ; $592b
	sub a, d ; $592c
	ld d, a ; $592d
	ld hl, wBallVelocityHeight ; $592e
	ld a, e ; $5931
	ld [hl+], a ; $5932
	ld [hl], d ; $5933
	ld hl, wBallVelocityDepth ; $5934
	ld a, [hl+] ; $5937
	ld d, [hl] ; $5938
	ld e, a ; $5939
	sra d ; $593a
	rr e ; $593c
	sra d ; $593e
	rr e ; $5940
	ld hl, wBallVelocityDepth ; $5942
	ld a, e ; $5945
	ld [hl+], a ; $5946
	ld [hl], d ; $5947
	ret ; $5948
BounceBallOffCourtFences:
	ld hl, wBallDepth ; $5949
	ld a, [hl+] ; $594c
	ld h, [hl] ; $594d
	ld l, a ; $594e
	bit 7, h ; $594f
	jr nz, Label_08_595b ; $5951
	ld de, $f920 ; $5953
	add hl, de ; $5956
	jr nc, Label_08_5981 ; $5957
	jr Label_08_5961 ; $5959
Label_08_595b:
	ld de, $0700 ; $595b
	add hl, de ; $595e
	jr c, Label_08_5981 ; $595f
Label_08_5961:
	ld hl, $c423 ; $5961
	ld a, [hl] ; $5964
	cpl ; $5965
	ld [hl+], a ; $5966
	ld a, [hl] ; $5967
	cpl ; $5968
	ld [hl+], a ; $5969
	ld a, [hl] ; $596a
	cpl ; $596b
	ld [hl+], a ; $596c
	ld hl, $c404 ; $596d
	ld de, $c423 ; $5970
	call AddVel24ToPos32 ; $5973
	call ApplyCourtBounceDamping ; $5976
	call ApplyCourtBounceDamping ; $5979
	ld a, $02 ; $597c
	ld [wBallBounceEvent], a ; $597e
Label_08_5981:
	ld hl, wBallX ; $5981
	ld a, [hl+] ; $5984
	ld h, [hl] ; $5985
	ld l, a ; $5986
	bit 7, h ; $5987
	jr z, Label_08_5991 ; $5989
	xor a, a ; $598b
	sub a, l ; $598c
	ld l, a ; $598d
	sbc a, a ; $598e
	sub a, h ; $598f
	ld h, a ; $5990
Label_08_5991:
	ld de, $fc60 ; $5991
	add hl, de ; $5994
	jr nc, Label_08_59b7 ; $5995
	ld hl, $c420 ; $5997
	ld a, [hl] ; $599a
	cpl ; $599b
	ld [hl+], a ; $599c
	ld a, [hl] ; $599d
	cpl ; $599e
	ld [hl+], a ; $599f
	ld a, [hl] ; $59a0
	cpl ; $59a1
	ld [hl+], a ; $59a2
	ld hl, $c400 ; $59a3
	ld de, $c420 ; $59a6
	call AddVel24ToPos32 ; $59a9
	call ApplyCourtBounceDamping ; $59ac
	call ApplyCourtBounceDamping ; $59af
	ld a, $02 ; $59b2
	ld [wBallBounceEvent], a ; $59b4
Label_08_59b7:
	ret ; $59b7
ProjectWorldToScreen_08:
	jp ProjectWorldToScreen ; $59b8
ApplyCameraProjection:
	ld e, l ; $59bb
	ld d, h ; $59bc
	ld hl, wCameraOffsetX ; $59bd
	ld a, [hl+] ; $59c0
	ld h, [hl] ; $59c1
	ld l, a ; $59c2
	add hl, de ; $59c3
	add hl, hl ; $59c4
	add hl, hl ; $59c5
	add hl, hl ; $59c6
	ld d, h ; $59c7
	ld hl, wCameraOffsetY ; $59c8
	ld a, [hl+] ; $59cb
	ld h, [hl] ; $59cc
	ld l, a ; $59cd
	add hl, bc ; $59ce
	add hl, hl ; $59cf
	add hl, hl ; $59d0
	add hl, hl ; $59d1
	ld e, h ; $59d2
	ret ; $59d3
	bit 7, h ; $59d4
	jp z, MulHLByDE ; $59d6
	xor a, a ; $59d9
	sub a, l ; $59da
	ld l, a ; $59db
	sbc a, a ; $59dc
	sub a, h ; $59dd
	ld h, a ; $59de
	call MulHLByDE ; $59df
Label_08_59e2:
	ldh a, [hMulResult] ; $59e2
	cpl ; $59e4
	add a, $01 ; $59e5
	ldh [hMulResult], a ; $59e7
	ldh a, [hMulResult + 1] ; $59e9
	cpl ; $59eb
	adc a, $00 ; $59ec
	ldh [hMulResult + 1], a ; $59ee
	ld a, l ; $59f0
	cpl ; $59f1
	adc a, $00 ; $59f2
	ld l, a ; $59f4
	ld a, h ; $59f5
	cpl ; $59f6
	adc a, $00 ; $59f7
	ld h, a ; $59f9
	ret ; $59fa
MulHLByDESigned32:
	ld a, h ; $59fb
	xor a, d ; $59fc
	ldh [hMathSign], a ; $59fd
	bit 7, h ; $59ff
	jr z, Label_08_5a09 ; $5a01
	xor a, a ; $5a03
	sub a, l ; $5a04
	ld l, a ; $5a05
	sbc a, a ; $5a06
	sub a, h ; $5a07
	ld h, a ; $5a08
Label_08_5a09:
	bit 7, d ; $5a09
	jr z, Label_08_5a13 ; $5a0b
	xor a, a ; $5a0d
	sub a, e ; $5a0e
	ld e, a ; $5a0f
	sbc a, a ; $5a10
	sub a, d ; $5a11
	ld d, a ; $5a12
Label_08_5a13:
	call MulHLByDE ; $5a13
	ldh a, [hMathSign] ; $5a16
	bit 7, a ; $5a18
	jr nz, Label_08_59e2 ; $5a1a
	ret ; $5a1c
MulHLByDEAbs:
	ld a, h ; $5a1d
	xor a, d ; $5a1e
	ldh [hMathSign], a ; $5a1f
	bit 7, h ; $5a21
	jr z, Label_08_5a2b ; $5a23
	xor a, a ; $5a25
	sub a, l ; $5a26
	ld l, a ; $5a27
	sbc a, a ; $5a28
	sub a, h ; $5a29
	ld h, a ; $5a2a
Label_08_5a2b:
	bit 7, d ; $5a2b
	jr z, Label_08_5a35 ; $5a2d
	xor a, a ; $5a2f
	sub a, e ; $5a30
	ld e, a ; $5a31
	sbc a, a ; $5a32
	sub a, d ; $5a33
	ld d, a ; $5a34
Label_08_5a35:
	call MulHLByDE ; $5a35
	ret ; $5a38
MulSignedHLByAFrac:
	bit 7, h ; $5a39
	jp z, MulHLByAFrac ; $5a3b
	ld d, a ; $5a3e
	xor a, a ; $5a3f
	sub a, l ; $5a40
	ld l, a ; $5a41
	sbc a, a ; $5a42
	sub a, h ; $5a43
	ld h, a ; $5a44
	ld a, d ; $5a45
	call MulHLByAFrac ; $5a46
	ld e, l ; $5a49
	ld d, h ; $5a4a
	call NegateADE ; $5a4b
	ld l, e ; $5a4e
	ld h, d ; $5a4f
	ret ; $5a50
MulHLByTangent:
	push hl ; $5a51
	ld l, c ; $5a52
	ld h, b ; $5a53
	call GetTangent ; $5a54
	pop de ; $5a57
	call MulHLByDESigned32 ; $5a58
	ldh a, [hMulResult + 1] ; $5a5b
	ld d, l ; $5a5d
	ld e, a ; $5a5e
	ret ; $5a5f
	bit 7, d ; $5a60
	ret z ; $5a62
NegateADE:
	cpl ; $5a63
	inc a ; $5a64
	jr nz, Label_08_5a6e ; $5a65
	sub a, e ; $5a67
	ld e, a ; $5a68
	sbc a, a ; $5a69
	sub a, d ; $5a6a
	ld d, a ; $5a6b
	xor a, a ; $5a6c
	ret ; $5a6d
Label_08_5a6e:
	push af ; $5a6e
	ld a, e ; $5a6f
	cpl ; $5a70
	ld e, a ; $5a71
	ld a, d ; $5a72
	cpl ; $5a73
	ld d, a ; $5a74
	pop af ; $5a75
	ret ; $5a76
	ld a, e ; $5a77
	add a, [hl] ; $5a78
	ld [hl+], a ; $5a79
	ld a, d ; $5a7a
	adc a, [hl] ; $5a7b
	ld [hl+], a ; $5a7c
	bit 7, d ; $5a7d
	jr nz, Label_08_5a84 ; $5a7f
	ret nc ; $5a81
	inc [hl] ; $5a82
	ret ; $5a83
Label_08_5a84:
	ret c ; $5a84
	dec [hl] ; $5a85
	ret ; $5a86
AddVel24ToPos32:
	ld a, [de] ; $5a87
	add a, [hl] ; $5a88
	ld [hl+], a ; $5a89
	inc de ; $5a8a
	ld a, [de] ; $5a8b
	adc a, [hl] ; $5a8c
	ld [hl+], a ; $5a8d
	inc de ; $5a8e
	ld a, [de] ; $5a8f
	bit 7, a ; $5a90
	jr nz, Label_08_5a99 ; $5a92
	adc a, [hl] ; $5a94
	ld [hl+], a ; $5a95
	ret nc ; $5a96
	inc [hl] ; $5a97
	ret ; $5a98
Label_08_5a99:
	adc a, [hl] ; $5a99
	ld [hl+], a ; $5a9a
	ret c ; $5a9b
	dec [hl] ; $5a9c
	ret ; $5a9d
Add24ToMem24:
	add a, [hl] ; $5a9e
	ld [hl+], a ; $5a9f
	ld a, [hl] ; $5aa0
	adc a, e ; $5aa1
	ld [hl+], a ; $5aa2
	ld a, [hl] ; $5aa3
	adc a, d ; $5aa4
	ld [hl+], a ; $5aa5
	ret ; $5aa6
AddDEToMem24:
	ld a, [hl] ; $5aa7
	add a, e ; $5aa8
	ld [hl+], a ; $5aa9
	ld a, [hl] ; $5aaa
	adc a, d ; $5aab
	ld [hl+], a ; $5aac
	bit 7, d ; $5aad
	jr nz, Label_08_5ab4 ; $5aaf
	ret nc ; $5ab1
	inc [hl] ; $5ab2
	ret ; $5ab3
Label_08_5ab4:
	ret c ; $5ab4
	dec [hl] ; $5ab5
	ret ; $5ab6
AddBCToMem24:
	ld a, [hl] ; $5ab7
	add a, c ; $5ab8
	ld [hl+], a ; $5ab9
	ld a, [hl] ; $5aba
	adc a, b ; $5abb
	ld [hl+], a ; $5abc
	bit 7, b ; $5abd
	jr nz, Label_08_5ac4 ; $5abf
	ret nc ; $5ac1
	inc [hl] ; $5ac2
	ret ; $5ac3
Label_08_5ac4:
	ret c ; $5ac4
	dec [hl] ; $5ac5
	ret ; $5ac6
AddDEToMem24IntoBC:
	ld a, [hl+] ; $5ac7
	add a, e ; $5ac8
	ld a, [hl+] ; $5ac9
	adc a, d ; $5aca
	ld c, a ; $5acb
	bit 7, d ; $5acc
	ld b, [hl] ; $5ace
	jr nz, Label_08_5ad4 ; $5acf
	ret nc ; $5ad1
	inc b ; $5ad2
	ret ; $5ad3
Label_08_5ad4:
	ret c ; $5ad4
	dec b ; $5ad5
	ret ; $5ad6
ScorePoint:
	call HandleServeFault ; $5ad7
	call FlagServiceReturnAce ; $5ada
	call ResolvePointWinner ; $5add
	ld [wPointWinLoseFlag], a ; $5ae0
	call UpdatePointStats ; $5ae3
ApplyPointToScore:
	ld a, [wTiebreakerIndicator] ; $5ae6
	and a, a ; $5ae9
	jr nz, Label_08_5b0d ; $5aea
	call AwardPoint ; $5aec
	ld b, $04 ; $5aef
	call ResetAdvantageToDeuce ; $5af1
	call CheckGameWon ; $5af4
	ld [wGameWinLoseFlag], a ; $5af7
	call AwardGame ; $5afa
	call CheckSetWon ; $5afd
	ld [wSetWinLoseFlag], a ; $5b00
	call AwardSet ; $5b03
	call CheckMatchWon ; $5b06
	ld [wMatchWinLoseFlag], a ; $5b09
	ret ; $5b0c
Label_08_5b0d:
	call AwardPoint ; $5b0d
	ld b, $07 ; $5b10
	call ResetAdvantageToDeuce ; $5b12
	call CheckTiebreakGameWon ; $5b15
	ld [wGameWinLoseFlag], a ; $5b18
	call AwardGame ; $5b1b
	call CheckSetWon ; $5b1e
	ld [wSetWinLoseFlag], a ; $5b21
	call AwardSet ; $5b24
	call CheckMatchWon ; $5b27
	ld [wMatchWinLoseFlag], a ; $5b2a
	ret ; $5b2d
EvaluatePointSituation:
	ld a, [wPlayer1PointsWon] ; $5b2e
	ld hl, wPlayer2PointsWon ; $5b31
	sub a, [hl] ; $5b34
	jr z, Label_08_5b74 ; $5b35
	bit 7, a ; $5b37
	ld a, $01 ; $5b39
	jr z, Label_08_5b3f ; $5b3b
	ld a, $ff ; $5b3d
Label_08_5b3f:
	add sp, -16 ; $5b3f
	ld hl, sp + 0 ; $5b41
	ld e, l ; $5b43
	ld d, h ; $5b44
	push de ; $5b45
	push af ; $5b46
	ld hl, wPlayer1SetsWon ; $5b47
	ld c, $01 ; $5b4a
	call CopyMemoryFast ; $5b4c
	pop af ; $5b4f
	ld [wPointWinLoseFlag], a ; $5b50
	call ApplyPointToScore ; $5b53
	ld a, [wGameWinLoseFlag] ; $5b56
	ld [wGamePointFlag], a ; $5b59
	ld a, [wSetWinLoseFlag] ; $5b5c
	ld [wSetPointFlag], a ; $5b5f
	ld a, [wMatchWinLoseFlag] ; $5b62
	ld [wMatchPointFlag], a ; $5b65
	pop hl ; $5b68
	ld de, wPlayer1SetsWon ; $5b69
	ld c, $01 ; $5b6c
	call CopyMemoryFast ; $5b6e
	add sp, 16 ; $5b71
	ret ; $5b73
Label_08_5b74:
	xor a, a ; $5b74
	ld [wGamePointFlag], a ; $5b75
	ld [wSetPointFlag], a ; $5b78
	ld [wMatchPointFlag], a ; $5b7b
	ret ; $5b7e
HandleServeFault:
	ld a, [wRallyLength] ; $5b7f
	cp a, $01 ; $5b82
	ret nz ; $5b84
	ld a, [wPointOutcomeSide] ; $5b85
	cp a, $ff ; $5b88
	ret nz ; $5b8a
	ld a, [wServeFaultFlag] ; $5b8b
	and a, a ; $5b8e
	jr nz, Label_08_5b9c ; $5b8f
	ld a, $01 ; $5b91
	ld [wServeFaultFlag], a ; $5b93
	ld a, POINTOUTCOME_FAULT ; $5b96
	ld [wPointOutcome], a ; $5b98
	ret ; $5b9b
Label_08_5b9c:
	ld a, $00 ; $5b9c
	ld [wServeFaultFlag], a ; $5b9e
	ld a, POINTOUTCOME_DOUBLE_FAULT ; $5ba1
	ld [wPointOutcome], a ; $5ba3
	ret ; $5ba6
FlagServiceReturnAce:
	ld a, [wPointOutcome] ; $5ba7
	cp a, POINTOUTCOME_WINNER ; $5baa
	ret nz ; $5bac
	ld a, [wRallyLength] ; $5bad
	cp a, $01 ; $5bb0
	jr nz, Label_08_5bb9 ; $5bb2
	ld a, $01 ; $5bb4
	ld [wServiceAceFlag], a ; $5bb6
Label_08_5bb9:
	ld a, [wRallyLength] ; $5bb9
	cp a, $02 ; $5bbc
	jr nz, Label_08_5bc5 ; $5bbe
	ld a, $01 ; $5bc0
	ld [wReturnAceFlag], a ; $5bc2
Label_08_5bc5:
	ret ; $5bc5
ResetAdvantageToDeuce:
	ld a, [wPlayer1PointsWon] ; $5bc6
	cp a, b ; $5bc9
	jr nz, Label_08_5bda ; $5bca
	ld a, [wPlayer2PointsWon] ; $5bcc
	cp a, b ; $5bcf
	jr nz, Label_08_5bda ; $5bd0
	ld a, b ; $5bd2
	dec a ; $5bd3
	ld [wPlayer1PointsWon], a ; $5bd4
	ld [wPlayer2PointsWon], a ; $5bd7
Label_08_5bda:
	ret ; $5bda
AwardSet:
	ld a, [wSetWinLoseFlag] ; $5bdb
	add a, a ; $5bde
	ret z ; $5bdf
	ld hl, wPlayer1SetsWon ; $5be0
	jr nc, Label_08_5be8 ; $5be3
	ld hl, wPlayer2SetsWon ; $5be5
Label_08_5be8:
	inc [hl] ; $5be8
	xor a, a ; $5be9
	ld [wPlayer1GamesWon], a ; $5bea
	ld [wPlayer2GamesWon], a ; $5bed
	ld [wTiebreakerIndicator], a ; $5bf0
	ret ; $5bf3
AwardGame:
	ld a, [wGameWinLoseFlag] ; $5bf4
	add a, a ; $5bf7
	ret z ; $5bf8
	ld hl, wPlayer1GamesWon ; $5bf9
	jr nc, Label_08_5c01 ; $5bfc
	ld hl, wPlayer2GamesWon ; $5bfe
Label_08_5c01:
	inc [hl] ; $5c01
	xor a, a ; $5c02
	ld [wPlayer1PointsWon], a ; $5c03
	ld [wPlayer2PointsWon], a ; $5c06
	ld [wTotalPointsScoredInCurrentGame], a ; $5c09
	ld [wDeuceIndicator], a ; $5c0c
	ld hl, wTotalGamesWonInMatch ; $5c0f
	inc [hl] ; $5c12
	ret ; $5c13
AwardPoint:
	ld a, [wPointWinLoseFlag] ; $5c14
	add a, a ; $5c17
	ret z ; $5c18
	ld hl, wPlayer1PointsWon ; $5c19
	jr nc, Label_08_5c21 ; $5c1c
	ld hl, wPlayer2PointsWon ; $5c1e
Label_08_5c21:
	inc [hl] ; $5c21
	xor a, a ; $5c22
	ld [wServeFaultFlag], a ; $5c23
	ld hl, wTotalPointsScoredInCurrentGame ; $5c26
	inc [hl] ; $5c29
	ret ; $5c2a
UpdatePointStats:
	call RecordFaultStat ; $5c2b
	call RecordDoubleFaultStat ; $5c2e
	ld a, [wPointOutcome] ; $5c31
	cp a, POINTOUTCOME_WINNER ; $5c34
	ret nz ; $5c36
	call RecordDropShotWinnerStat ; $5c37
	call RecordLobWinnerStat ; $5c3a
	call RecordSmashAceStat ; $5c3d
	call RecordReturnAceStat ; $5c40
	call RecordServiceAceStat ; $5c43
	ret ; $5c46
RecordFaultStat:
	ld a, [wPointOutcome] ; $5c47
	cp a, POINTOUTCOME_FAULT ; $5c4a
	ret nz ; $5c4c
	ld hl, wCharacter1Faults ; $5c4d
	jp Label_08_5cb2 ; $5c50
RecordDoubleFaultStat:
	ld a, [wPointOutcome] ; $5c53
	cp a, POINTOUTCOME_DOUBLE_FAULT ; $5c56
	ret nz ; $5c58
	ld hl, wCharacter1DoubleFaults ; $5c59
	jp Label_08_5cb2 ; $5c5c
RecordServiceAceStat:
	ld a, [wServiceAceFlag] ; $5c5f
	and a, a ; $5c62
	ret z ; $5c63
	ld a, POINTWINNER_SERVICE_ACE ; $5c64
	ld [wPointWinnerShotType], a ; $5c66
	ld hl, wCharacter1ServiceAces ; $5c69
	jp Label_08_5cb2 ; $5c6c
RecordReturnAceStat:
	ld a, [wReturnAceFlag] ; $5c6f
	and a, a ; $5c72
	ret z ; $5c73
	ld a, POINTWINNER_RETURN_ACE ; $5c74
	ld [wPointWinnerShotType], a ; $5c76
	ld hl, wCharacter1ReturnAces ; $5c79
	jp Label_08_5cb2 ; $5c7c
RecordSmashAceStat:
	ld a, [wCurrentShotType] ; $5c7f
	cp a, SHOTTYPE_SMASH ; $5c82
	ret nz ; $5c84
	ld a, POINTWINNER_SMASH_ACE ; $5c85
	ld [wPointWinnerShotType], a ; $5c87
	ld hl, wCharacter1SmashAces ; $5c8a
	jp Label_08_5cb2 ; $5c8d
RecordLobWinnerStat:
	ld a, [wCurrentShotType] ; $5c90
	cp a, SHOTTYPE_LOB ; $5c93
	ret nz ; $5c95
	ld a, POINTWINNER_LOB ; $5c96
	ld [wPointWinnerShotType], a ; $5c98
	ld hl, wCharacter1LobShotWinners ; $5c9b
	jp Label_08_5cb2 ; $5c9e
RecordDropShotWinnerStat:
	ld a, [wCurrentShotType] ; $5ca1
	cp a, SHOTTYPE_DROP ; $5ca4
	ret nz ; $5ca6
	ld a, POINTWINNER_DROP_SHOT ; $5ca7
	ld [wPointWinnerShotType], a ; $5ca9
	ld hl, wCharacter1DropShotWinners ; $5cac
	jp Label_08_5cb2 ; $5caf
Label_08_5cb2:
	ld a, [wLastShotCharIndex] ; $5cb2
	add a, a ; $5cb5
	add a, a ; $5cb6
	add a, a ; $5cb7
	add a, l ; $5cb8
	ld l, a ; $5cb9
	jr nc, Label_08_5cbd ; $5cba
	inc h ; $5cbc
Label_08_5cbd:
	ld a, [hl] ; $5cbd
	cp a, $63 ; $5cbe
	ret nc ; $5cc0
	inc [hl] ; $5cc1
	ret ; $5cc2
CheckMatchWon:
	ld a, [wMatchTypeNumberOfSets] ; $5cc3
	inc a ; $5cc6
	srl a ; $5cc7
	ld b, a ; $5cc9
	ld hl, wPlayer1SetsWon ; $5cca
	ld a, [hl+] ; $5ccd
	sub a, [hl] ; $5cce
	jr z, Label_08_5ce7 ; $5ccf
	bit 7, a ; $5cd1
	jr nz, Label_08_5cde ; $5cd3
	ld a, [wPlayer1SetsWon] ; $5cd5
	cp a, b ; $5cd8
	jr c, Label_08_5ce7 ; $5cd9
	ld a, $01 ; $5cdb
	ret ; $5cdd
Label_08_5cde:
	ld a, [wPlayer2SetsWon] ; $5cde
	cp a, b ; $5ce1
	jr c, Label_08_5ce7 ; $5ce2
	ld a, $ff ; $5ce4
	ret ; $5ce6
Label_08_5ce7:
	xor a, a ; $5ce7
	ret ; $5ce8
CheckSetWon:
	ld a, [wMatchTypeNumberOfGames] ; $5ce9
	cp a, $02 ; $5cec
	jp z, Label_08_5d14 ; $5cee
	ld a, [wPlayer1GamesWon] ; $5cf1
	ld d, a ; $5cf4
	cp a, $07 ; $5cf5
	jr nz, Label_08_5cfa ; $5cf7
	inc d ; $5cf9
Label_08_5cfa:
	ld a, [wPlayer2GamesWon] ; $5cfa
	ld e, a ; $5cfd
	cp a, $07 ; $5cfe
	jr nz, Label_08_5d03 ; $5d00
	inc e ; $5d02
Label_08_5d03:
	ld b, $06 ; $5d03
	ld c, $06 ; $5d05
	call EvalWinByTwo ; $5d07
	cp a, $80 ; $5d0a
	ret nz ; $5d0c
	ld a, $01 ; $5d0d
	ld [wTiebreakerIndicator], a ; $5d0f
	xor a, a ; $5d12
	ret ; $5d13
Label_08_5d14:
	ld a, [wPlayer1GamesWon] ; $5d14
	ld d, a ; $5d17
	cp a, $03 ; $5d18
	jr nz, Label_08_5d1d ; $5d1a
	inc d ; $5d1c
Label_08_5d1d:
	ld a, [wPlayer2GamesWon] ; $5d1d
	ld e, a ; $5d20
	cp a, $03 ; $5d21
	jr nz, Label_08_5d26 ; $5d23
	inc e ; $5d25
Label_08_5d26:
	ld b, $02 ; $5d26
	ld c, $02 ; $5d28
	call EvalWinByTwo ; $5d2a
	cp a, $80 ; $5d2d
	ret nz ; $5d2f
	ld a, $01 ; $5d30
	ld [wTiebreakerIndicator], a ; $5d32
	xor a, a ; $5d35
	ret ; $5d36
CheckGameWon:
	xor a, a ; $5d37
	ld [wDeuceIndicator], a ; $5d38
	ld b, $03 ; $5d3b
	ld c, $04 ; $5d3d
	ld a, [wPlayer1PointsWon] ; $5d3f
	ld d, a ; $5d42
	ld a, [wPlayer2PointsWon] ; $5d43
	ld e, a ; $5d46
	call EvalWinByTwo ; $5d47
	cp a, $80 ; $5d4a
	ret nz ; $5d4c
	ld a, $01 ; $5d4d
	ld [wDeuceIndicator], a ; $5d4f
	xor a, a ; $5d52
	ret ; $5d53
CheckTiebreakGameWon:
	xor a, a ; $5d54
	ld [wDeuceIndicator], a ; $5d55
	ld b, $06 ; $5d58
	ld c, $07 ; $5d5a
	ld a, [wPlayer1PointsWon] ; $5d5c
	ld d, a ; $5d5f
	ld a, [wPlayer2PointsWon] ; $5d60
	ld e, a ; $5d63
	call EvalWinByTwo ; $5d64
	cp a, $80 ; $5d67
	ret nz ; $5d69
	ld a, $01 ; $5d6a
	ld [wDeuceIndicator], a ; $5d6c
	xor a, a ; $5d6f
	ret ; $5d70
EvalWinByTwo:
	ld a, d ; $5d71
	sub a, e ; $5d72
	jr z, Label_08_5d91 ; $5d73
	bit 7, a ; $5d75
	jr nz, Label_08_5d84 ; $5d77
	cp a, $02 ; $5d79
	jr c, Label_08_5d98 ; $5d7b
	ld a, d ; $5d7d
	cp a, c ; $5d7e
	jr c, Label_08_5d98 ; $5d7f
	ld a, $01 ; $5d81
	ret ; $5d83
Label_08_5d84:
	cpl ; $5d84
	inc a ; $5d85
	cp a, $02 ; $5d86
	jr c, Label_08_5d98 ; $5d88
	ld a, e ; $5d8a
	cp a, c ; $5d8b
	jr c, Label_08_5d98 ; $5d8c
	ld a, $ff ; $5d8e
	ret ; $5d90
Label_08_5d91:
	ld a, e ; $5d91
	cp a, b ; $5d92
	jr nz, Label_08_5d98 ; $5d93
	ld a, $80 ; $5d95
	ret ; $5d97
Label_08_5d98:
	xor a, a ; $5d98
	ret ; $5d99
ResolvePointWinner:
	ld a, [wPointOutcome] ; $5d9a
	cp a, POINTOUTCOME_FAULT ; $5d9d
	jr z, Label_08_5dba ; $5d9f
	cp a, $03 ; $5da1
	jr z, Label_08_5dba ; $5da3
	cp a, $09 ; $5da5
	jr z, Label_08_5dbc ; $5da7
	ld a, [wLastShotCharIndex] ; $5da9
	and a, $01 ; $5dac
	jr z, Label_08_5db6 ; $5dae
	ld a, [wPointOutcomeSide] ; $5db0
	cpl ; $5db3
	inc a ; $5db4
	ret ; $5db5
Label_08_5db6:
	ld a, [wPointOutcomeSide] ; $5db6
	ret ; $5db9
Label_08_5dba:
	xor a, a ; $5dba
	ret ; $5dbb
Label_08_5dbc:
	ld a, [wBallTouchCharIndex] ; $5dbc
	and a, $01 ; $5dbf
	add a, a ; $5dc1
	dec a ; $5dc2
	ret ; $5dc3
	; $5dc4, 100 bytes (bytes:4)
	db $cd, $cd, $05, $21 ; 0x00
	db $b3, $99, $04, $22 ; 0x04
	db $e6, $99, $02, $23 ; 0x08
	db $f0, $b3, $08, $20 ; 0x0c
	db $e6, $cd, $0a, $11 ; 0x10
	db $cd, $b3, $0d, $12 ; 0x14
	db $f0, $99, $09, $13 ; 0x18
	db $e6, $e6, $0f, $16 ; 0x1c
	db $b3, $cd, $0c, $14 ; 0x20
	db $cd, $b3, $03, $25 ; 0x24
	db $cd, $b3, $06, $1e ; 0x28
	db $cd, $b3, $0e, $1f ; 0x2c
	db $e6, $99, $07, $28 ; 0x30
	db $e6, $99, $02, $27 ; 0x34
	db $cd, $b3, $00, $29 ; 0x38
	db $cd, $b3, $01, $17 ; 0x3c
	db $e6, $cd, $0a, $18 ; 0x40
	db $cd, $b3, $00, $16 ; 0x44
	db $e6, $cd, $0a, $11 ; 0x48
	db $cd, $b3, $00, $12 ; 0x4c
	db $b3, $cd, $0c, $14 ; 0x50
	db $b3, $cd, $0c, $19 ; 0x54
	db $cd, $b3, $00, $13 ; 0x58
	db $b3, $cd, $0c, $15 ; 0x5c
	db $cd, $b3, $03, $24 ; 0x60
LoadCourtSceneData:
	ldh a, [hWramBank] ; $5e28
	push af ; $5e2a
	xor a, a ; $5e2b
	ldh [hScrollX], a ; $5e2c
	xor a, a ; $5e2e
	ldh [hScrollY], a ; $5e2f
	ld a, [wCurrentlyUsedCourt] ; $5e31
	add a, a ; $5e34
	add a, a ; $5e35
	add a, $c4 ; $5e36
	ld l, a ; $5e38
	adc a, $5d ; $5e39
	sub a, l ; $5e3b
	ld h, a ; $5e3c
	ld a, [hl+] ; $5e3d
	ld [wCourtSurfaceFriction], a ; $5e3e
	ld a, [hl+] ; $5e41
	ld [wCourtSurfaceBounce], a ; $5e42
	ld a, [hl+] ; $5e45
	farcall LoadCourtSceneGraphics ; $5e46
	call SnapshotCourtTilemaps ; $5e49
	pop af ; $5e4c
	wram_bank ; $5e4d
	ret ; $5e51
SnapshotCourtTilemaps:
	wram_bank $02 ; $5e52
	ld hl, $d800 ; $5e58
	ld de, $d000 ; $5e5b
	ld c, $40 ; $5e5e
	call CopyMemoryFast ; $5e60
	ld hl, $dc00 ; $5e63
	ld de, $d400 ; $5e66
	ld c, $40 ; $5e69
	call CopyMemoryFast ; $5e6b
	ret ; $5e6e
UploadCourtTilemap:
	wram_bank $02 ; $5e6f
	ld hl, $d000 ; $5e75
	ld de, $9800 ; $5e78
	ld c, $40 ; $5e7b
	call QueueVRAMCopy ; $5e7d
	ret ; $5e80
UploadCourtAttrmap:
	wram_bank $02 ; $5e81
	ld hl, $d400 ; $5e87
	ld de, $b800 ; $5e8a
	ld c, $40 ; $5e8d
	call QueueVRAMCopy ; $5e8f
	ret ; $5e92
RefreshCourtScoreboard:
	ld a, [$c4c8] ; $5e93
	and a, $01 ; $5e96
	ret nz ; $5e98
	ld a, [wCourtViewFlipped] ; $5e99
	and a, a ; $5e9c
	jr nz, Label_08_5ec7 ; $5e9d
	ld hl, $de94 ; $5e9f
	ld de, $d99a ; $5ea2
	call CopyScoreboardTileColumn ; $5ea5
	ld hl, $debc ; $5ea8
	ld de, $dd9a ; $5eab
	call CopyScoreboardTileColumn ; $5eae
	ld hl, $de8a ; $5eb1
	ld de, $d984 ; $5eb4
	call CopyScoreboardTileColumn ; $5eb7
	ld hl, $deb2 ; $5eba
	ld de, $dd84 ; $5ebd
	call CopyScoreboardTileColumn ; $5ec0
	call SnapshotCourtTilemaps ; $5ec3
	ret ; $5ec6
Label_08_5ec7:
	ld hl, $de80 ; $5ec7
	ld de, $d984 ; $5eca
	call CopyScoreboardTileColumn ; $5ecd
	ld hl, $dea8 ; $5ed0
	ld de, $dd84 ; $5ed3
	call CopyScoreboardTileColumn ; $5ed6
	ld hl, $de9e ; $5ed9
	ld de, $d99a ; $5edc
	call CopyScoreboardTileColumn ; $5edf
	ld hl, $dec6 ; $5ee2
	ld de, $dd9a ; $5ee5
	call CopyScoreboardTileColumn ; $5ee8
	call SnapshotCourtTilemaps ; $5eeb
	ret ; $5eee
CopyScoreboardTileColumn:
	wram_bank $04 ; $5eef
	push de ; $5ef5
	ld de, wTextBuffer ; $5ef6
	ld c, $02 ; $5ef9
	call CopyMemoryFast ; $5efb
	pop de ; $5efe
	wram_bank $02 ; $5eff
	ld hl, wTextBuffer ; $5f05
	ld a, [hl+] ; $5f08
	ld [de], a ; $5f09
	inc de ; $5f0a
	ld a, [hl+] ; $5f0b
	ld [de], a ; $5f0c
	inc de ; $5f0d
	ld a, $1e ; $5f0e
	add a, e ; $5f10
	ld e, a ; $5f11
	jr nc, Label_08_5f15 ; $5f12
	inc d ; $5f14
Label_08_5f15:
	ld a, [hl+] ; $5f15
	ld [de], a ; $5f16
	inc de ; $5f17
	ld a, [hl+] ; $5f18
	ld [de], a ; $5f19
	inc de ; $5f1a
	ld a, $1e ; $5f1b
	add a, e ; $5f1d
	ld e, a ; $5f1e
	jr nc, Label_08_5f22 ; $5f1f
	inc d ; $5f21
Label_08_5f22:
	ld a, [hl+] ; $5f22
	ld [de], a ; $5f23
	inc de ; $5f24
	ld a, [hl+] ; $5f25
	ld [de], a ; $5f26
	inc de ; $5f27
	ld a, $1e ; $5f28
	add a, e ; $5f2a
	ld e, a ; $5f2b
	jr nc, Label_08_5f2f ; $5f2c
	inc d ; $5f2e
Label_08_5f2f:
	ld a, [hl+] ; $5f2f
	ld [de], a ; $5f30
	inc de ; $5f31
	ld a, [hl+] ; $5f32
	ld [de], a ; $5f33
	inc de ; $5f34
	ld a, $1e ; $5f35
	add a, e ; $5f37
	ld e, a ; $5f38
	jr nc, Label_08_5f3c ; $5f39
	inc d ; $5f3b
Label_08_5f3c:
	ld a, [hl+] ; $5f3c
	ld [de], a ; $5f3d
	inc de ; $5f3e
	ld a, [hl+] ; $5f3f
	ld [de], a ; $5f40
	inc de ; $5f41
	ret ; $5f42
RefreshCourtAfterEndChange:
	ld a, [wCourtViewFlipChanged] ; $5f43
	and a, a ; $5f46
	ret z ; $5f47
	ld a, [wMatchSimFrozen] ; $5f48
	push af ; $5f4b
	ld a, [wMatchDrawFrozen] ; $5f4c
	push af ; $5f4f
	ld a, $ff ; $5f50
	ld [wMatchSimFrozen], a ; $5f52
	ld [wMatchDrawFrozen], a ; $5f55
	call StepMatchFrame ; $5f58
	call RefreshCourtScoreboard ; $5f5b
	call StepMatchFrame ; $5f5e
	wram_bank $02 ; $5f61
	ld hl, $d180 ; $5f67
	ld de, $9980 ; $5f6a
	ld c, $0a ; $5f6d
	call QueueVRAMCopy ; $5f6f
	ld hl, $d580 ; $5f72
	ld de, $b980 ; $5f75
	ld c, $0a ; $5f78
	call QueueVRAMCopy ; $5f7a
	pop af ; $5f7d
	ld [wMatchDrawFrozen], a ; $5f7e
	pop af ; $5f81
	ld [wMatchSimFrozen], a ; $5f82
	wram_bank $04 ; $5f85
	ret ; $5f8b
RunChangeoverSequence:
	ld a, $01 ; $5f8c
	ld [wPauseDisabled], a ; $5f8e
	ld a, [$c4cc] ; $5f91
	and a, a ; $5f94
	jr nz, Label_08_5fa8 ; $5f95
	ld a, [wChangeEndsPending] ; $5f97
	and a, a ; $5f9a
	jr z, Label_08_5fb4 ; $5f9b
	call StepMatchFrame ; $5f9d
	ld a, $00 ; $5fa0
	farcall ShowCourtBanner ; $5fa2
	call StepMatchFrame ; $5fa5
Label_08_5fa8:
	call StepMatchFrame ; $5fa8
	call WalkCharsToNewEnds ; $5fab
	farcall HideCourtBanner ; $5fae
	call StepMatchFrame ; $5fb1
Label_08_5fb4:
	xor a, a ; $5fb4
	ld [$c4cc], a ; $5fb5
	ld [wChangeEndsPending], a ; $5fb8
	ret ; $5fbb
WalkCharsToNewEnds:
	xor a, a ; $5fbc
	ld [wOffscreenArrowsEnabled], a ; $5fbd
	call ResetBallState ; $5fc0
	call GetServeCameraTarget ; $5fc3
	call SnapCameraTo ; $5fc6
	ld hl, $5fe5 ; $5fc9
	call ForEachCharBank ; $5fcc
Label_08_5fcf:
	call StepMatchFrame ; $5fcf
	call ReadMatchInputPressed ; $5fd2
	and a, $0b ; $5fd5
	jr nz, Label_08_5fde ; $5fd7
	call CheckAllCharsPhaseDone ; $5fd9
	jr z, Label_08_5fcf ; $5fdc
Label_08_5fde:
	ld hl, $6003 ; $5fde
	call ForEachCharBank ; $5fe1
	ret ; $5fe4
	ld a, $06 ; $5fe5
	call SetCharState ; $5fe7
	ld a, $80 ; $5fea
	call SetCharFacing ; $5fec
	call GetCharChangeoverPosition ; $5fef
	call SetCharPosAndTarget ; $5ff2
	call GetCharBaseCourtPosition ; $5ff5
	call SetCharTarget ; $5ff8
	ld hl, wCharFlags ; $5ffb
	res 1, [hl] ; $5ffe
	res 0, [hl] ; $6000
	ret ; $6002
	call GetCharBaseCourtPosition ; $6003
	call SetCharPosAndTarget ; $6006
	ld a, [$df0c] ; $6009
	call SetCharFacing ; $600c
	ret ; $600f
WalkCharsOffCourt:
	ld a, $01 ; $6010
	ld [wPauseDisabled], a ; $6012
	xor a, a ; $6015
	ld [wOffscreenArrowsEnabled], a ; $6016
	call GetServeCameraTarget ; $6019
	call SetCameraTarget ; $601c
	ld hl, $6046 ; $601f
	call ForEachCharBank ; $6022
Label_08_6025:
	call StepMatchFrame ; $6025
	call ReadMatchInputPressed ; $6028
	and a, $0b ; $602b
	jr nz, Label_08_6034 ; $602d
	call CheckAllCharsPhaseDone ; $602f
	jr z, Label_08_6025 ; $6032
Label_08_6034:
	ld a, $14 ; $6034
	call StepMatchFrames ; $6036
	call GetServeCameraTarget ; $6039
	call SnapCameraTo ; $603c
	ld hl, $6059 ; $603f
	call ForEachCharBank ; $6042
	ret ; $6045
	ld a, $06 ; $6046
	call SetCharState ; $6048
	call GetCharChangeoverPosition ; $604b
	call SetCharTarget ; $604e
	ld hl, wCharFlags ; $6051
	res 1, [hl] ; $6054
	res 0, [hl] ; $6056
	ret ; $6058
	ld hl, $0fe0 ; $6059
	ld de, $0fe0 ; $605c
	call SetCharPosAndTarget ; $605f
	ret ; $6062
CheckAllCharsPhaseDone:
	ld de, $df19 ; $6063
	ld b, $ff ; $6066
	ld a, [wOnCourtCharCountMinus1] ; $6068
	rst Rst00 ; $606b
	dw Label_08_608f ; $606c jumptable
	dw Label_08_6086 ; $606e jumptable
	dw Label_08_607d ; $6070 jumptable
	dw Label_08_6074 ; $6072 jumptable
Label_08_6074:
	wram_bank $06 ; $6074
	ld a, [de] ; $607a
	and a, b ; $607b
	ld b, a ; $607c
Label_08_607d:
	wram_bank $07 ; $607d
	ld a, [de] ; $6083
	and a, b ; $6084
	ld b, a ; $6085
Label_08_6086:
	wram_bank $05 ; $6086
	ld a, [de] ; $608c
	and a, b ; $608d
	ld b, a ; $608e
Label_08_608f:
	wram_bank $04 ; $608f
	ld a, [de] ; $6095
	and a, b ; $6096
	ret ; $6097
GetCharBaseCourtPosition:
	ld a, [wCharServeRole] ; $6098
	add a, a ; $609b
	add a, a ; $609c
	add a, $c8 ; $609d
	ld l, a ; $609f
	adc a, $60 ; $60a0
	sub a, l ; $60a2
	ld h, a ; $60a3
	ld a, [hl+] ; $60a4
	ld c, a ; $60a5
	ld a, [hl+] ; $60a6
	ld b, a ; $60a7
	ld a, [hl+] ; $60a8
	ld d, [hl] ; $60a9
	ld e, a ; $60aa
	ld l, c ; $60ab
	ld h, b ; $60ac
	ld a, [wCharCourtPos] ; $60ad
	and a, $02 ; $60b0
	jr z, Label_08_60ba ; $60b2
	xor a, a ; $60b4
	sub a, e ; $60b5
	ld e, a ; $60b6
	sbc a, a ; $60b7
	sub a, d ; $60b8
	ld d, a ; $60b9
Label_08_60ba:
	ld a, [wCharCourtPos] ; $60ba
	and a, $01 ; $60bd
	jr z, Label_08_60c7 ; $60bf
	xor a, a ; $60c1
	sub a, l ; $60c2
	ld l, a ; $60c3
	sbc a, a ; $60c4
	sub a, h ; $60c5
	ld h, a ; $60c6
Label_08_60c7:
	ret ; $60c7
	; $60c8, 16 bytes (records:4)
; 4 records x 4 bytes
	dw $0120, $04e0 ; record 0
	dw $0140, $0460 ; record 1
	dw $00c0, $01c0 ; record 2
	dw $00c0, $0300 ; record 3
GetCharChangeoverPosition:
	ld a, [wCharServeRole] ; $60d8
	add a, a ; $60db
	add a, a ; $60dc
	add a, $07 ; $60dd
	ld l, a ; $60df
	adc a, $61 ; $60e0
	sub a, l ; $60e2
	ld h, a ; $60e3
	ld a, [hl+] ; $60e4
	ld c, a ; $60e5
	ld a, [hl+] ; $60e6
	ld b, a ; $60e7
	ld a, [hl+] ; $60e8
	ld d, [hl] ; $60e9
	ld e, a ; $60ea
	ld l, c ; $60eb
	ld h, b ; $60ec
	ld a, [wCharCourtPos] ; $60ed
	and a, $02 ; $60f0
	jr z, Label_08_60fa ; $60f2
	xor a, a ; $60f4
	sub a, e ; $60f5
	ld e, a ; $60f6
	sbc a, a ; $60f7
	sub a, d ; $60f8
	ld d, a ; $60f9
Label_08_60fa:
	ld a, [wCourtViewFlipped] ; $60fa
	and a, a ; $60fd
	jr z, Label_08_6106 ; $60fe
	xor a, a ; $6100
	sub a, l ; $6101
	ld l, a ; $6102
	sbc a, a ; $6103
	sub a, h ; $6104
	ld h, a ; $6105
Label_08_6106:
	ret ; $6106
	; $6107, 16 bytes (records:4)
; 4 records x 4 bytes
	dw $0300, $0240 ; record 0
	dw $0300, $0240 ; record 1
	dw $0300, $0180 ; record 2
	dw $0300, $0180 ; record 3
PlayCourtIntro:
	ld b, $44 ; $6117
	ld a, [$c8f5] ; $6119
	and a, a ; $611c
	jr z, Label_08_6121 ; $611d
	ld b, $45 ; $611f
Label_08_6121:
	ld a, b ; $6121
	call PlaySoundManaged ; $6122
	ld a, [wGameMode] ; $6125
	cp a, $02 ; $6128
	jr z, Label_08_6132 ; $612a
	ld a, [$c8f5] ; $612c
	and a, a ; $612f
	jr nz, Label_08_6171 ; $6130
Label_08_6132:
	ld d, $00 ; $6132
	ld e, $00 ; $6134
	ld a, d ; $6136
	ldh [hScrollX], a ; $6137
	ld a, e ; $6139
	ldh [hScrollY], a ; $613a
	ld a, $05 ; $613c
	call StepMatchFrames ; $613e
	ld b, $30 ; $6141
	ld hl, $0200 ; $6143
	call PanCamera ; $6146
	jr nz, Label_08_6171 ; $6149
	ld b, $38 ; $614b
	ld hl, $0002 ; $614d
	call PanCamera ; $6150
	jr nz, Label_08_6171 ; $6153
	ld b, $30 ; $6155
	ld hl, $fe00 ; $6157
	call PanCamera ; $615a
	jr nz, Label_08_6171 ; $615d
	ld b, $1e ; $615f
	ld hl, $00fe ; $6161
	call PanCamera ; $6164
	jr nz, Label_08_6171 ; $6167
	ld b, $1a ; $6169
	ld hl, $0200 ; $616b
	call PanCamera ; $616e
Label_08_6171:
	call ResetCameraForServe ; $6171
	call UpdateMatchCamera ; $6174
	ret ; $6177
PanCamera:
	ld a, d ; $6178
	ldh [hScrollX], a ; $6179
	ld a, e ; $617b
	ldh [hScrollY], a ; $617c
	ld a, d ; $617e
	add a, h ; $617f
	ld d, a ; $6180
	ld a, e ; $6181
	add a, l ; $6182
	ld e, a ; $6183
	call ReadMatchInputPressed ; $6184
	and a, $0b ; $6187
	jr nz, Label_08_6191 ; $6189
	call StepMatchFrame ; $618b
	dec b ; $618e
	jr nz, PanCamera ; $618f
Label_08_6191:
	ret ; $6191
ResetCameraForServe:
	call GetServeCameraTarget ; $6192
	call SnapCameraTo ; $6195
	ret ; $6198
GetServeCameraTarget:
	ld a, [wServingCharCourtPos] ; $6199
	and a, $02 ; $619c
	ld de, $fe80 ; $619e
	jr z, Label_08_61a6 ; $61a1
	ld de, $f880 ; $61a3
Label_08_61a6:
	ld hl, $0000 ; $61a6
	ret ; $61a9
SnapCameraTo:
	ld c, l ; $61aa
	ld b, h ; $61ab
	ld hl, wMatchCameraX ; $61ac
	ld a, c ; $61af
	ld [hl+], a ; $61b0
	ld [hl], b ; $61b1
	ld hl, wMatchCameraTargetX ; $61b2
	ld a, c ; $61b5
	ld [hl+], a ; $61b6
	ld [hl], b ; $61b7
	ld hl, wMatchCameraY ; $61b8
	ld a, e ; $61bb
	ld [hl+], a ; $61bc
	ld [hl], d ; $61bd
	ld hl, wMatchCameraTargetY ; $61be
	ld a, e ; $61c1
	ld [hl+], a ; $61c2
	ld [hl], d ; $61c3
	xor a, a ; $61c4
	ld [wCameraFollowBall], a ; $61c5
	ret ; $61c8
SetCameraTarget:
	ld c, l ; $61c9
	ld b, h ; $61ca
	ld hl, wMatchCameraTargetX ; $61cb
	ld a, c ; $61ce
	ld [hl+], a ; $61cf
	ld [hl], b ; $61d0
	ld hl, wMatchCameraTargetY ; $61d1
	ld a, e ; $61d4
	ld [hl+], a ; $61d5
	ld [hl], d ; $61d6
	xor a, a ; $61d7
	ld [wCameraFollowBall], a ; $61d8
	ret ; $61db
UpdateMatchCamera:
	ld a, [wCameraFollowBall] ; $61dc
	and a, a ; $61df
	jr z, Label_08_61f4 ; $61e0
	ld hl, wBallGroundProjX ; $61e2
	ld de, wMatchCameraTargetX ; $61e5
	ld a, [hl+] ; $61e8
	ld [de], a ; $61e9
	inc de ; $61ea
	ld a, [hl+] ; $61eb
	ld [de], a ; $61ec
	inc de ; $61ed
	ld a, [hl+] ; $61ee
	ld [de], a ; $61ef
	inc de ; $61f0
	ld a, [hl+] ; $61f1
	ld [de], a ; $61f2
	inc de ; $61f3
Label_08_61f4:
	ld hl, wMatchCameraX ; $61f4
	ld a, [hl+] ; $61f7
	ld b, [hl] ; $61f8
	ld c, a ; $61f9
	ld hl, wMatchCameraTargetX ; $61fa
	ld a, [hl+] ; $61fd
	ld h, [hl] ; $61fe
	ld l, a ; $61ff
	ld a, l ; $6200
	sub a, c ; $6201
	ld l, a ; $6202
	ld a, h ; $6203
	sbc a, b ; $6204
	ld h, a ; $6205
	ld e, l ; $6206
	ld d, h ; $6207
	ld hl, wMatchCameraY ; $6208
	ld a, [hl+] ; $620b
	ld b, [hl] ; $620c
	ld c, a ; $620d
	ld hl, wMatchCameraTargetY ; $620e
	ld a, [hl+] ; $6211
	ld h, [hl] ; $6212
	ld l, a ; $6213
	ld a, l ; $6214
	sub a, c ; $6215
	ld l, a ; $6216
	ld a, h ; $6217
	sbc a, b ; $6218
	ld h, a ; $6219
	push hl ; $621a
	push de ; $621b
	call AngleFromVectorCoarse ; $621c
	ld hl, $0040 ; $621f
	call VectorFromLengthAndAngleRaw ; $6222
	ld c, l ; $6225
	ld b, h ; $6226
	ld hl, wMatchCameraX ; $6227
	ld a, [hl] ; $622a
	add a, c ; $622b
	ld [hl+], a ; $622c
	ld a, [hl] ; $622d
	adc a, b ; $622e
	ld [hl+], a ; $622f
	ld hl, wMatchCameraY ; $6230
	ld a, [hl] ; $6233
	add a, e ; $6234
	ld [hl+], a ; $6235
	ld a, [hl] ; $6236
	adc a, d ; $6237
	ld [hl+], a ; $6238
	ld hl, wMatchCameraX ; $6239
	ld a, [hl+] ; $623c
	ld b, [hl] ; $623d
	ld c, a ; $623e
	ld hl, wMatchCameraTargetX ; $623f
	ld a, [hl+] ; $6242
	ld h, [hl] ; $6243
	ld l, a ; $6244
	ld a, l ; $6245
	sub a, c ; $6246
	ld l, a ; $6247
	ld a, h ; $6248
	sbc a, b ; $6249
	ld h, a ; $624a
	pop af ; $624b
	xor a, h ; $624c
	bit 7, a ; $624d
	jr z, Label_08_625d ; $624f
	ld hl, wMatchCameraTargetX ; $6251
	ld a, [hl+] ; $6254
	ld d, [hl] ; $6255
	ld e, a ; $6256
	ld hl, wMatchCameraX ; $6257
	ld a, e ; $625a
	ld [hl+], a ; $625b
	ld [hl], d ; $625c
Label_08_625d:
	ld hl, wMatchCameraY ; $625d
	ld a, [hl+] ; $6260
	ld b, [hl] ; $6261
	ld c, a ; $6262
	ld hl, wMatchCameraTargetY ; $6263
	ld a, [hl+] ; $6266
	ld h, [hl] ; $6267
	ld l, a ; $6268
	ld a, l ; $6269
	sub a, c ; $626a
	ld l, a ; $626b
	ld a, h ; $626c
	sbc a, b ; $626d
	ld h, a ; $626e
	pop af ; $626f
	xor a, h ; $6270
	bit 7, a ; $6271
	jr z, Label_08_6281 ; $6273
	ld hl, wMatchCameraTargetY ; $6275
	ld a, [hl+] ; $6278
	ld d, [hl] ; $6279
	ld e, a ; $627a
	ld hl, wMatchCameraY ; $627b
	ld a, e ; $627e
	ld [hl+], a ; $627f
	ld [hl], d ; $6280
Label_08_6281:
	ld hl, wMatchCameraX ; $6281
	ld a, [hl+] ; $6284
	ld h, [hl] ; $6285
	ld l, a ; $6286
	sra h ; $6287
	rr l ; $6289
	ld de, $f610 ; $628b
	add hl, de ; $628e
	ld de, $1010 ; $628f
	add hl, de ; $6292
	ld a, h ; $6293
	bit 7, a ; $6294
	jr z, Label_08_629b ; $6296
	ld hl, $0000 ; $6298
Label_08_629b:
	sub a, $0c ; $629b
	bit 7, a ; $629d
	jr nz, Label_08_62a5 ; $629f
	ld h, $0c ; $62a1
	ld l, $00 ; $62a3
Label_08_62a5:
	ld a, l ; $62a5
	and a, $e0 ; $62a6
	ld e, a ; $62a8
	ld d, h ; $62a9
	ld l, e ; $62aa
	ld h, d ; $62ab
	add hl, hl ; $62ac
	add hl, hl ; $62ad
	add hl, hl ; $62ae
	ld a, h ; $62af
	ldh [hScrollX], a ; $62b0
	xor a, a ; $62b2
	sub a, e ; $62b3
	ld e, a ; $62b4
	sbc a, a ; $62b5
	sub a, d ; $62b6
	ld d, a ; $62b7
	ld hl, $1010 ; $62b8
	add hl, de ; $62bb
	ld e, l ; $62bc
	ld d, h ; $62bd
	ld hl, wCameraOffsetX ; $62be
	ld a, e ; $62c1
	ld [hl+], a ; $62c2
	ld [hl], d ; $62c3
	ld hl, wMatchCameraY ; $62c4
	ld a, [hl+] ; $62c7
	ld h, [hl] ; $62c8
	ld l, a ; $62c9
	sra h ; $62ca
	rr l ; $62cc
	sra h ; $62ce
	rr l ; $62d0
	ld e, l ; $62d2
	ld d, h ; $62d3
	sra d ; $62d4
	rr e ; $62d6
	add hl, de ; $62d8
	ld de, $f710 ; $62d9
	add hl, de ; $62dc
	ld de, $1010 ; $62dd
	add hl, de ; $62e0
	ld a, l ; $62e1
	and a, $e0 ; $62e2
	ld e, a ; $62e4
	ld d, h ; $62e5
	ld l, e ; $62e6
	ld h, d ; $62e7
	add hl, hl ; $62e8
	add hl, hl ; $62e9
	add hl, hl ; $62ea
	ld a, h ; $62eb
	ldh [hScrollY], a ; $62ec
	xor a, a ; $62ee
	sub a, e ; $62ef
	ld e, a ; $62f0
	sbc a, a ; $62f1
	sub a, d ; $62f2
	ld d, a ; $62f3
	ld hl, $1010 ; $62f4
	add hl, de ; $62f7
	ld e, l ; $62f8
	ld d, h ; $62f9
	ld hl, wCameraOffsetY ; $62fa
	ld a, e ; $62fd
	ld [hl+], a ; $62fe
	ld [hl], d ; $62ff
	ret ; $6300
StandingShadowOamTemplate:
	; $6301, 13 bytes (bytes:4)
	db $02, $fc, $00, $00 ; 0x00
	db $02, $04, $02, $00 ; 0x04
	db $02, $0c, $04, $00 ; 0x08
	db $80 ; 0x0c
ClearSpriteSlots:
	ld a, $ff ; $630e
	ld [wNetBallSlot], a ; $6310
	ld [wBallSlot], a ; $6313
	ld [wBallTrailSlots], a ; $6316
	ld [wBallTrailSlots + 4], a ; $6319
	ld [wBallTrailSlots + 8], a ; $631c
	ld [wBallTrailSlots + 12], a ; $631f
	ld [wBallTrailSlots + 16], a ; $6322
	ld [wBallShadowSlot], a ; $6325
	wram_bank $07 ; $6328
	ld a, $ff ; $632e
	ld [wCharSpriteSlot], a ; $6330
	ld [wCharAirShadowSlot], a ; $6333
	ld [wCharGroundShadowSlot], a ; $6336
	wram_bank $06 ; $6339
	ld a, $ff ; $633f
	ld [wCharSpriteSlot], a ; $6341
	ld [wCharAirShadowSlot], a ; $6344
	ld [wCharGroundShadowSlot], a ; $6347
	wram_bank $05 ; $634a
	ld a, $ff ; $6350
	ld [wCharSpriteSlot], a ; $6352
	ld [wCharAirShadowSlot], a ; $6355
	ld [wCharGroundShadowSlot], a ; $6358
	wram_bank $04 ; $635b
	ld a, $ff ; $6361
	ld [wCharSpriteSlot], a ; $6363
	ld [wCharAirShadowSlot], a ; $6366
	ld [wCharGroundShadowSlot], a ; $6369
	ret ; $636c
DrawNearTeamChars:
	ld hl, wCharDepthKey ; $636d
	wram_bank $06 ; $6370
	ld b, [hl] ; $6376
	wram_bank $04 ; $6377
	ld a, [hl] ; $637d
	cp a, b ; $637e
	jr c, Label_08_63a0 ; $637f
	wram_bank $04 ; $6381
	ld hl, wCharSpriteSlot ; $6387
	call DrawCharSprite ; $638a
	wram_bank $06 ; $638d
	ld hl, wCharSpriteSlot ; $6393
	call DrawCharSprite ; $6396
	wram_bank $04 ; $6399
	ret ; $639f
Label_08_63a0:
	wram_bank $06 ; $63a0
	ld hl, wCharSpriteSlot ; $63a6
	call DrawCharSprite ; $63a9
	wram_bank $04 ; $63ac
	ld hl, wCharSpriteSlot ; $63b2
	call DrawCharSprite ; $63b5
	wram_bank $04 ; $63b8
	ret ; $63be
DrawFarTeamChars:
	ld hl, wCharDepthKey ; $63bf
	wram_bank $07 ; $63c2
	ld b, [hl] ; $63c8
	wram_bank $05 ; $63c9
	ld a, [hl] ; $63cf
	cp a, b ; $63d0
	jr c, Label_08_63f2 ; $63d1
	wram_bank $05 ; $63d3
	ld hl, wCharSpriteSlot ; $63d9
	call DrawCharSprite ; $63dc
	wram_bank $07 ; $63df
	ld hl, wCharSpriteSlot ; $63e5
	call DrawCharSprite ; $63e8
	wram_bank $04 ; $63eb
	ret ; $63f1
Label_08_63f2:
	wram_bank $07 ; $63f2
	ld hl, wCharSpriteSlot ; $63f8
	call DrawCharSprite ; $63fb
	wram_bank $05 ; $63fe
	ld hl, wCharSpriteSlot ; $6404
	call DrawCharSprite ; $6407
	wram_bank $04 ; $640a
	ret ; $6410
DrawBallAndEffects:
	call DrawHitSpark ; $6411
	call DrawSpecialHitEffect ; $6414
	ld hl, wNetBallSlot ; $6417
	call DrawSlotSprite ; $641a
	ld hl, wBallSlot ; $641d
	call DrawSlotSprite ; $6420
	ld d, $07 ; $6423
	call CallModeHook ; $6425
	ret ; $6428
DrawActorsByDepth:
	ld a, [$c7b8] ; $6429
	and a, a ; $642c
	jr nz, Label_08_6477 ; $642d
	ld hl, wCharDepthKey ; $642f
	wram_bank $05 ; $6432
	ld b, [hl] ; $6438
	wram_bank $04 ; $6439
	ld a, [hl] ; $643f
	cp a, b ; $6440
	jr nc, Label_08_645d ; $6441
	ld a, [wPointOutcome] ; $6443
	and a, a ; $6446
	jr z, Label_08_6453 ; $6447
	call DrawFarTeamChars ; $6449
	call DrawNearTeamChars ; $644c
	call DrawBallAndEffects ; $644f
	ret ; $6452
Label_08_6453:
	call DrawFarTeamChars ; $6453
	call DrawBallAndEffects ; $6456
	call DrawNearTeamChars ; $6459
	ret ; $645c
Label_08_645d:
	ld a, [wPointOutcome] ; $645d
	and a, a ; $6460
	jr z, Label_08_646d ; $6461
	call DrawNearTeamChars ; $6463
	call DrawFarTeamChars ; $6466
	call DrawBallAndEffects ; $6469
	ret ; $646c
Label_08_646d:
	call DrawNearTeamChars ; $646d
	call DrawBallAndEffects ; $6470
	call DrawFarTeamChars ; $6473
	ret ; $6476
Label_08_6477:
	call DrawNearTeamChars ; $6477
	call DrawBallAndEffects ; $647a
	call DrawFarTeamChars ; $647d
	ret ; $6480
DrawMarkersAndShadows:
	call DrawTargetZone ; $6481
	call DrawLandingMarker ; $6484
	ld hl, wBallTrailSlots ; $6487
	call DrawSlotSprite ; $648a
	ld hl, wBallTrailSlots + 4 ; $648d
	call DrawSlotSprite ; $6490
	ld hl, wBallTrailSlots + 8 ; $6493
	call DrawSlotSprite ; $6496
	ld hl, wBallTrailSlots + 12 ; $6499
	call DrawSlotSprite ; $649c
	ld hl, wBallTrailSlots + 16 ; $649f
	call DrawSlotSprite ; $64a2
	call DrawBounceEffect ; $64a5
	ld hl, wCharAirShadowSlot ; $64a8
	wram_bank $07 ; $64ab
	call DrawSlotSprite ; $64b1
	ld hl, wCharAirShadowSlot ; $64b4
	wram_bank $06 ; $64b7
	call DrawSlotSprite ; $64bd
	ld hl, wCharAirShadowSlot ; $64c0
	wram_bank $05 ; $64c3
	call DrawSlotSprite ; $64c9
	ld hl, wCharAirShadowSlot ; $64cc
	wram_bank $04 ; $64cf
	call DrawSlotSprite ; $64d5
	ld hl, wBallShadowSlot ; $64d8
	call DrawSlotSprite ; $64db
	ld hl, wCharGroundShadowSlot ; $64de
	wram_bank $05 ; $64e1
	call DrawStandingShadowSlot ; $64e7
	ld hl, wCharGroundShadowSlot ; $64ea
	wram_bank $04 ; $64ed
	call DrawStandingShadowSlot ; $64f3
	wram_bank $04 ; $64f6
	ret ; $64fc
DrawSlotSprite:
	ld a, [hl+] ; $64fd
	cp a, $ff ; $64fe
	ret z ; $6500
	ld c, a ; $6501
	ld a, [hl+] ; $6502
	ld b, a ; $6503
	ld a, [hl+] ; $6504
	ld e, a ; $6505
	ld d, [hl] ; $6506
	jp QueueSprite ; $6507
DrawCharSprite:
	ld a, [hl+] ; $650a
	cp a, $ff ; $650b
	ret z ; $650d
	ld c, a ; $650e
	ld a, [hl+] ; $650f
	ld b, a ; $6510
	ld a, [hl+] ; $6511
	ld e, a ; $6512
	ld a, [hl+] ; $6513
	ld d, a ; $6514
	ld a, [wCharSpriteFrame] ; $6515
	ld h, a ; $6518
	ld a, [wCharSpriteFrame + 1] ; $6519
	ld l, a ; $651c
	ld a, [wCharSpriteFrame + 2] ; $651d
	and a, a ; $6520
	jp z, QueueSprite24x32 ; $6521
	jp QueueSprite32x32 ; $6524
DrawStandingShadowSlot:
	ld a, [hl+] ; $6527
	cp a, $ff ; $6528
	ret z ; $652a
	ld c, a ; $652b
	ld a, [hl+] ; $652c
	ld b, a ; $652d
	ld a, [hl+] ; $652e
	ld e, a ; $652f
	ld d, [hl] ; $6530
	ld hl, StandingShadowOamTemplate ; $6531
	jp QueueSpriteTemplate ; $6534
	ld a, [hl+] ; $6537
	cp a, $ff ; $6538
	ret z ; $653a
	ld c, a ; $653b
	ld a, [hl+] ; $653c
	ld b, a ; $653d
	ld a, [hl+] ; $653e
	ld e, a ; $653f
	ld d, [hl] ; $6540
	jp QueueSprite16 ; $6541
InitMinigameMatchSettings:
	call InitDefaultMatchSettings ; $6544
	ld a, $02 ; $6547
	ld [$c8f5], a ; $6549
	ld a, $01 ; $654c
	ld [$c7bd], a ; $654e
	ld a, $ff ; $6551
	ld [$c7b5], a ; $6553
	ret ; $6556
RunMinigameMatch:
	ld c, $20 ; $6557
	call BeginFadeOut ; $6559
	call WaitFadeEnd ; $655c
	call AdvanceFrame ; $655f
	call DisableLCDSafely ; $6562
	call InitMatchScene ; $6565
	call EnableLCD ; $6568
	ld a, [wMatchBGM] ; $656b
	call PlaySoundManaged ; $656e
	script_fade_in $20 ; $6571
	xor a, a ; $6576
	ld [wMatchSimFrozen], a ; $6577
	call RunMinigamePointLoop ; $657a
	call ShowMatchResultScreens ; $657d
	ld c, $20 ; $6580
	call BeginFadeOut ; $6582
	call WaitFadeEnd ; $6585
	call AdvanceFrame ; $6588
	farcall LoadMenuFontGfx ; $658b
	call AdvanceFrame ; $658e
	ret ; $6591
ShowMatchResultScreens:
	ld a, [wMatchExitRequest] ; $6592
	and a, a ; $6595
	ret nz ; $6596
	ld a, $ff ; $6597
	ld [wMatchSimFrozen], a ; $6599
	ld [wMatchDrawFrozen], a ; $659c
	ld a, [wGameMode] ; $659f
	cp a, $08 ; $65a2
	jr nz, Label_08_65b2 ; $65a4
	ld a, [wPointWinLoseFlag] ; $65a6
	cp a, $01 ; $65a9
	jr z, Label_08_65b2 ; $65ab
	farcall RunMinigameEndMenu ; $65ad
	jr Label_08_65b5 ; $65b0
Label_08_65b2:
	farcall ShowMatchScoreboardScreen ; $65b2
Label_08_65b5:
	ld a, $00 ; $65b5
	ld [wMatchDrawFrozen], a ; $65b7
	ld [wMatchSimFrozen], a ; $65ba
	ret ; $65bd
RunMinigamePointLoop:
	wram_bank $04 ; $65be
	ld a, $00 ; $65c4
	ld [$df7f], a ; $65c6
	xor a, a ; $65c9
	ld [$df79], a ; $65ca
	ld [$df7a], a ; $65cd
	ld a, $00 ; $65d0
	ld [$df7c], a ; $65d2
	ld d, $03 ; $65d5
	call CallModeHook ; $65d7
	ld a, [wMatchAbortFlag] ; $65da
	and a, $80 ; $65dd
	jr nz, Label_08_6630 ; $65df
Label_08_65e1:
	call LoadMinigamePointLayout ; $65e1
	call ResetPointState ; $65e4
	ld d, $01 ; $65e7
	call CallModeHook ; $65e9
	ld a, [wMatchAbortFlag] ; $65ec
	and a, $80 ; $65ef
	jr nz, Label_08_6630 ; $65f1
	ld a, [$c7b8] ; $65f3
	and a, a ; $65f6
	jr nz, Label_08_65ff ; $65f7
	ld hl, $4f91 ; $65f9
	call ForEachCharBank ; $65fc
Label_08_65ff:
	call PlayMinigamePoint ; $65ff
	ld a, [wMatchAbortFlag] ; $6602
	and a, $80 ; $6605
	jr nz, Label_08_6630 ; $6607
	ld d, $02 ; $6609
	call CallModeHook ; $660b
	ld a, [wMatchAbortFlag] ; $660e
	and a, $80 ; $6611
	jr nz, Label_08_6630 ; $6613
	ld hl, $c7b0 ; $6615
	ld a, [hl+] ; $6618
	ld h, [hl] ; $6619
	ld l, a ; $661a
	ld a, [wTotalPointsScoredInCurrentGame] ; $661b
	add a, a ; $661e
	add a, a ; $661f
	add a, a ; $6620
	add a, l ; $6621
	ld l, a ; $6622
	jr nc, Label_08_6626 ; $6623
	inc h ; $6625
Label_08_6626:
	ld a, [wModeHookBank] ; $6626
	call FarReadByte ; $6629
	cp a, $ff ; $662c
	jr nz, Label_08_65e1 ; $662e
Label_08_6630:
	ret ; $6630
PlayMinigamePoint:
	farcall LoadServeGfx ; $6631
	call StepMatchFrame ; $6634
	ld a, $01 ; $6637
	ld [$c4c5], a ; $6639
Label_08_663c:
	call StepMatchFrame ; $663c
	ld a, [wMatchAbortFlag] ; $663f
	and a, $01 ; $6642
	jr nz, Label_08_664c ; $6644
	ld a, [wPointOutcome] ; $6646
	and a, a ; $6649
	jr z, Label_08_663c ; $664a
Label_08_664c:
	ld a, [wPointOutcome] ; $664c
	cp a, $09 ; $664f
	jr nz, Label_08_6658 ; $6651
	ld a, $28 ; $6653
	call StepMatchFrames ; $6655
Label_08_6658:
	call EndPointBallEffects ; $6658
	call HandleServeFault ; $665b
	call FlagServiceReturnAce ; $665e
	ret ; $6661
LoadMinigamePointLayout:
	ld a, [wModeHookBank] ; $6662
	and a, a ; $6665
	ret z ; $6666
	add sp, -8 ; $6667
	ld hl, sp + 0 ; $6669
	ld e, l ; $666b
	ld d, h ; $666c
	push hl ; $666d
	ld hl, $c7b0 ; $666e
	ld a, [hl+] ; $6671
	ld h, [hl] ; $6672
	ld l, a ; $6673
	ld a, [wTotalPointsScoredInCurrentGame] ; $6674
	add a, a ; $6677
	add a, a ; $6678
	add a, a ; $6679
	add a, l ; $667a
	ld l, a ; $667b
	jr nc, Label_08_667f ; $667c
	inc h ; $667e
Label_08_667f:
	ld a, [wModeHookBank] ; $667f
	ld bc, $0008 ; $6682
	call FarCopyBytes ; $6685
	pop hl ; $6688
	ld de, wCharCourtPos ; $6689
	wram_bank $04 ; $668c
	ld a, [hl+] ; $6692
	and a, $03 ; $6693
	ld [de], a ; $6695
	wram_bank $05 ; $6696
	ld a, [hl+] ; $669c
	and a, $03 ; $669d
	ld [de], a ; $669f
	wram_bank $06 ; $66a0
	ld a, [hl+] ; $66a6
	and a, $03 ; $66a7
	ld [de], a ; $66a9
	wram_bank $07 ; $66aa
	ld a, [hl+] ; $66b0
	and a, $03 ; $66b1
	ld [de], a ; $66b3
	ld de, wCharServeRole ; $66b4
	wram_bank $04 ; $66b7
	ld a, [hl+] ; $66bd
	and a, $03 ; $66be
	ld [de], a ; $66c0
	wram_bank $05 ; $66c1
	ld a, [hl+] ; $66c7
	and a, $03 ; $66c8
	ld [de], a ; $66ca
	wram_bank $06 ; $66cb
	ld a, [hl+] ; $66d1
	and a, $03 ; $66d2
	ld [de], a ; $66d4
	wram_bank $07 ; $66d5
	ld a, [hl+] ; $66db
	and a, $03 ; $66dc
	ld [de], a ; $66de
	wram_bank $04 ; $66df
	call IdentifyServingPlayer ; $66e5
	ld hl, $4c99 ; $66e8
	call ForEachCharBank ; $66eb
	add sp, 8 ; $66ee
	ret ; $66f0
CallModeHook:
	ld a, [wModeHookBank] ; $66f1
	and a, a ; $66f4
	ret z ; $66f5
	push af ; $66f6
	push bc ; $66f7
	push de ; $66f8
	push hl ; $66f9
	ld hl, wModeHookTable ; $66fa
	ld a, [hl+] ; $66fd
	ld h, [hl] ; $66fe
	ld l, a ; $66ff
	ld a, d ; $6700
	add a, a ; $6701
	add a, l ; $6702
	ld l, a ; $6703
	jr nc, Label_08_6707 ; $6704
	inc h ; $6706
Label_08_6707:
	ld a, [wModeHookBank] ; $6707
	call FarReadWord ; $670a
	ld l, c ; $670d
	ld h, b ; $670e
	ld a, [wModeHookBank] ; $670f
	call CallHLInBankA ; $6712
	pop hl ; $6715
	pop de ; $6716
	pop bc ; $6717
	pop af ; $6718
	ret ; $6719
SetModeHookTable:
	push af ; $671a
	push hl ; $671b
	ld [wModeHookBank], a ; $671c
	ld hl, wModeHookTable ; $671f
	ld a, e ; $6722
	ld [hl+], a ; $6723
	ld [hl], d ; $6724
	pop hl ; $6725
	pop af ; $6726
	ret ; $6727
SetMinigamePointTable:
	push hl ; $6728
	ld hl, $c7b0 ; $6729
	ld a, e ; $672c
	ld [hl+], a ; $672d
	ld [hl], d ; $672e
	pop hl ; $672f
	ret ; $6730
SetBallGatePoint1:
	ld c, l ; $6731
	ld b, h ; $6732
	ld hl, $c79a ; $6733
	ld a, e ; $6736
	ld [hl+], a ; $6737
	ld [hl], d ; $6738
	ld hl, $c798 ; $6739
	ld a, c ; $673c
	ld [hl+], a ; $673d
	ld [hl], b ; $673e
	ret ; $673f
SetBallGatePoint2:
	ld c, l ; $6740
	ld b, h ; $6741
	ld hl, $c79e ; $6742
	ld a, e ; $6745
	ld [hl+], a ; $6746
	ld [hl], d ; $6747
	ld hl, $c79c ; $6748
	ld a, c ; $674b
	ld [hl+], a ; $674c
	ld [hl], b ; $674d
	ret ; $674e
SetTargetZoneCorner1:
	ld c, l ; $674f
	ld b, h ; $6750
	ld hl, wTargetZoneDepth1 ; $6751
	ld a, e ; $6754
	ld [hl+], a ; $6755
	ld [hl], d ; $6756
	ld hl, wTargetZoneX1 ; $6757
	ld a, c ; $675a
	ld [hl+], a ; $675b
	ld [hl], b ; $675c
	ret ; $675d
SetTargetZoneCorner2:
	ld c, l ; $675e
	ld b, h ; $675f
	ld hl, wTargetZoneDepth2 ; $6760
	ld a, e ; $6763
	ld [hl+], a ; $6764
	ld [hl], d ; $6765
	ld hl, wTargetZoneX2 ; $6766
	ld a, c ; $6769
	ld [hl+], a ; $676a
	ld [hl], b ; $676b
	ret ; $676c
DidBallCrossGate:
	ld hl, $c79a ; $676d
	ld a, [hl+] ; $6770
	ld b, [hl] ; $6771
	ld c, a ; $6772
	ld hl, wBallPrevDepth ; $6773
	ld a, [hl+] ; $6776
	ld d, [hl] ; $6777
	ld e, a ; $6778
	ld a, e ; $6779
	sub a, c ; $677a
	ld e, a ; $677b
	ld a, d ; $677c
	sbc a, b ; $677d
	ld d, a ; $677e
	ld hl, wBallDepth ; $677f
	ld a, [hl+] ; $6782
	ld h, [hl] ; $6783
	ld l, a ; $6784
	ld a, l ; $6785
	sub a, c ; $6786
	ld l, a ; $6787
	ld a, h ; $6788
	sbc a, b ; $6789
	ld h, a ; $678a
	ld a, h ; $678b
	xor a, d ; $678c
	bit 7, a ; $678d
	jr z, Label_08_67c0 ; $678f
	ld hl, $c798 ; $6791
	ld a, [hl+] ; $6794
	ld d, [hl] ; $6795
	ld e, a ; $6796
	ld hl, wBallX ; $6797
	ld a, [hl+] ; $679a
	ld h, [hl] ; $679b
	ld l, a ; $679c
	ld a, l ; $679d
	sub a, e ; $679e
	ld l, a ; $679f
	ld a, h ; $67a0
	sbc a, d ; $67a1
	ld h, a ; $67a2
	bit 7, h ; $67a3
	jr nz, Label_08_67c0 ; $67a5
	ld hl, $c79c ; $67a7
	ld a, [hl+] ; $67aa
	ld d, [hl] ; $67ab
	ld e, a ; $67ac
	ld hl, wBallX ; $67ad
	ld a, [hl+] ; $67b0
	ld h, [hl] ; $67b1
	ld l, a ; $67b2
	ld a, l ; $67b3
	sub a, e ; $67b4
	ld l, a ; $67b5
	ld a, h ; $67b6
	sbc a, d ; $67b7
	ld h, a ; $67b8
	bit 7, h ; $67b9
	jr z, Label_08_67c0 ; $67bb
	xor a, a ; $67bd
	inc a ; $67be
	ret ; $67bf
Label_08_67c0:
	xor a, a ; $67c0
	ret ; $67c1
IsBallInTargetZone:
	ldh a, [hWramBank] ; $67c2
	push af ; $67c4
	wram_bank $04 ; $67c5
	ld hl, wTargetZoneX1 ; $67cb
	ld a, [hl+] ; $67ce
	ld d, [hl] ; $67cf
	ld e, a ; $67d0
	ld hl, $fff0 ; $67d1
	add hl, de ; $67d4
	ld e, l ; $67d5
	ld d, h ; $67d6
	ld hl, wBallX ; $67d7
	ld a, [hl+] ; $67da
	ld h, [hl] ; $67db
	ld l, a ; $67dc
	ld a, l ; $67dd
	sub a, e ; $67de
	ld l, a ; $67df
	ld a, h ; $67e0
	sbc a, d ; $67e1
	ld h, a ; $67e2
	bit 7, h ; $67e3
	jr nz, Label_08_6843 ; $67e5
	ld hl, wTargetZoneX2 ; $67e7
	ld a, [hl+] ; $67ea
	ld d, [hl] ; $67eb
	ld e, a ; $67ec
	ld hl, $0010 ; $67ed
	add hl, de ; $67f0
	ld e, l ; $67f1
	ld d, h ; $67f2
	ld hl, wBallX ; $67f3
	ld a, [hl+] ; $67f6
	ld h, [hl] ; $67f7
	ld l, a ; $67f8
	ld a, l ; $67f9
	sub a, e ; $67fa
	ld l, a ; $67fb
	ld a, h ; $67fc
	sbc a, d ; $67fd
	ld h, a ; $67fe
	bit 7, h ; $67ff
	jr z, Label_08_6843 ; $6801
	ld hl, wTargetZoneDepth1 ; $6803
	ld a, [hl+] ; $6806
	ld d, [hl] ; $6807
	ld e, a ; $6808
	ld hl, $fff0 ; $6809
	add hl, de ; $680c
	ld e, l ; $680d
	ld d, h ; $680e
	ld hl, wBallDepth ; $680f
	ld a, [hl+] ; $6812
	ld h, [hl] ; $6813
	ld l, a ; $6814
	ld a, l ; $6815
	sub a, e ; $6816
	ld l, a ; $6817
	ld a, h ; $6818
	sbc a, d ; $6819
	ld h, a ; $681a
	bit 7, h ; $681b
	jr nz, Label_08_6843 ; $681d
	ld hl, wTargetZoneDepth2 ; $681f
	ld a, [hl+] ; $6822
	ld d, [hl] ; $6823
	ld e, a ; $6824
	ld hl, $0010 ; $6825
	add hl, de ; $6828
	ld e, l ; $6829
	ld d, h ; $682a
	ld hl, wBallDepth ; $682b
	ld a, [hl+] ; $682e
	ld h, [hl] ; $682f
	ld l, a ; $6830
	ld a, l ; $6831
	sub a, e ; $6832
	ld l, a ; $6833
	ld a, h ; $6834
	sbc a, d ; $6835
	ld h, a ; $6836
	bit 7, h ; $6837
	jr z, Label_08_6843 ; $6839
	pop af ; $683b
	wram_bank ; $683c
	xor a, a ; $6840
	inc a ; $6841
	ret ; $6842
Label_08_6843:
	pop af ; $6843
	wram_bank ; $6844
	xor a, a ; $6848
	ret ; $6849
InitChar:
	ld [wCharIndex], a ; $684a
	ld a, d ; $684d
	ld [$df78], a ; $684e
	ld a, [$df78] ; $6851
	farcall RemapExtendedCharId ; $6854
	ld [$df7e], a ; $6857
	ld a, [$df7e] ; $685a
	farcall LookupCharSpriteSet ; $685d
	ld d, a ; $6860
	ld a, e ; $6861
	add a, $03 ; $6862
	ld e, a ; $6864
	farcall SetupCharacterSprite ; $6865
	farcall LoadCharacterAttributes ; $6868
	ld a, $00 ; $686b
	call SetCharState ; $686d
	ld hl, $03c0 ; $6870
	ld de, $0000 ; $6873
	call SetCharPosAndTarget ; $6876
	ld a, $01 ; $6879
	ld [$df1e], a ; $687b
	ret ; $687e
InitAllChars:
	wram_bank $07 ; $687f
	ld hl, wCharPosX ; $6885
	ld c, $10 ; $6888
	call ClearMemory16 ; $688a
	wram_bank $06 ; $688d
	ld hl, wCharPosX ; $6893
	ld c, $10 ; $6896
	call ClearMemory16 ; $6898
	wram_bank $05 ; $689b
	ld hl, wCharPosX ; $68a1
	ld c, $10 ; $68a4
	call ClearMemory16 ; $68a6
	wram_bank $04 ; $68a9
	ld hl, wCharPosX ; $68af
	ld c, $10 ; $68b2
	call ClearMemory16 ; $68b4
	ld b, $00 ; $68b7
	ld a, [wMatchIsDoubles] ; $68b9
	and a, a ; $68bc
	jr nz, Label_08_68c7 ; $68bd
	ld a, [$c33f] ; $68bf
	and a, a ; $68c2
	jr nz, Label_08_68c7 ; $68c3
	ld b, $01 ; $68c5
Label_08_68c7:
	ld a, b ; $68c7
	ld [wStandingShadowsEnabled], a ; $68c8
	ld a, [wOnCourtCharCountMinus1] ; $68cb
	rst Rst00 ; $68ce
	dw Label_08_6910 ; $68cf jumptable
	dw Label_08_68fd ; $68d1 jumptable
	dw Label_08_68ea ; $68d3 jumptable
	dw Label_08_68d7 ; $68d5 jumptable
Label_08_68d7:
	wram_bank $06 ; $68d7
	ld a, [wPlayer1CurrentPartnerCharacter] ; $68dd
	ld d, a ; $68e0
	ld a, [$ca4c] ; $68e1
	ld e, a ; $68e4
	ld a, $02 ; $68e5
	call InitChar ; $68e7
Label_08_68ea:
	wram_bank $07 ; $68ea
	ld a, [wPlayer2CurrentPartnerCharacter] ; $68f0
	ld d, a ; $68f3
	ld a, [$cacc] ; $68f4
	ld e, a ; $68f7
	ld a, $03 ; $68f8
	call InitChar ; $68fa
Label_08_68fd:
	wram_bank $05 ; $68fd
	ld a, [wPlayer2CurrentMainCharacter] ; $6903
	ld d, a ; $6906
	ld a, [$ca8c] ; $6907
	ld e, a ; $690a
	ld a, $01 ; $690b
	call InitChar ; $690d
Label_08_6910:
	wram_bank $04 ; $6910
	ld a, [wPlayer1CurrentMainCharacter] ; $6916
	ld d, a ; $6919
	ld a, [$ca0c] ; $691a
	ld e, a ; $691d
	ld a, $00 ; $691e
	call InitChar ; $6920
	ld a, $00 ; $6923
	ld [$df1e], a ; $6925
	farcall LoadOnCourtCharacterGfx ; $6928
	ret ; $692b
UpdateAllChars:
	wram_bank $04 ; $692c
	call UpdateChar ; $6932
	wram_bank $05 ; $6935
	call UpdateChar ; $693b
	wram_bank $06 ; $693e
	call UpdateChar ; $6944
	wram_bank $07 ; $6947
	call UpdateChar ; $694d
	wram_bank $04 ; $6950
	ret ; $6956
	ret ; $6957
UpdateChar:
	ld a, [wCharActive] ; $6958
	and a, a ; $695b
	ret z ; $695c
	call UpdateCharBallGeometry ; $695d
	call ReadCharInput ; $6960
	call UpdateCharStateMachine ; $6963
	call CheckCharBallContact ; $6966
	call UpdateCharVelocityFromInput ; $6969
	call StepCharMovement ; $696c
	call StepCharJumpPhysics ; $696f
	call EaseCharFacing ; $6972
	call StepCharAnimation ; $6975
	call UpdateCharFacingOctant ; $6978
	call ReloadCharFacingTiles ; $697b
	call BuildCharSpriteSlots ; $697e
	call UpdateChargeFlash ; $6981
	call BuildAirborneShadowSlot ; $6984
	ret ; $6987
SetCharPosAndTarget:
	ld c, l ; $6988
	ld b, h ; $6989
	ld hl, wCharPosDepth ; $698a
	xor a, a ; $698d
	ld [hl+], a ; $698e
	ld a, e ; $698f
	ld [hl+], a ; $6990
	ld [hl], d ; $6991
	ld hl, wCharWalkTargetDepth ; $6992
	ld a, e ; $6995
	ld [hl+], a ; $6996
	ld [hl], d ; $6997
	ld hl, wCharPosX ; $6998
	xor a, a ; $699b
	ld [hl+], a ; $699c
	ld a, c ; $699d
	ld [hl+], a ; $699e
	ld [hl], b ; $699f
	ld hl, wCharWalkTargetX ; $69a0
	ld a, c ; $69a3
	ld [hl+], a ; $69a4
	ld [hl], b ; $69a5
	ld hl, wCharPosHeight ; $69a6
	xor a, a ; $69a9
	ld [hl+], a ; $69aa
	ld [hl+], a ; $69ab
	ld [hl+], a ; $69ac
	ret ; $69ad
SetCharTarget:
	ld c, l ; $69ae
	ld b, h ; $69af
	ld hl, wCharWalkTargetDepth ; $69b0
	ld a, e ; $69b3
	ld [hl+], a ; $69b4
	ld [hl], d ; $69b5
	ld hl, wCharWalkTargetX ; $69b6
	ld a, c ; $69b9
	ld [hl+], a ; $69ba
	ld [hl], b ; $69bb
	ld hl, $df55 ; $69bc
	ld [hl], $00 ; $69bf
	ret ; $69c1
ReloadCharFrameGfx:
	ld a, [$df37] ; $69c2
	and a, $07 ; $69c5
	add a, $08 ; $69c7
	ld d, a ; $69c9
	ld a, [$df3a] ; $69ca
	ld b, a ; $69cd
	ld hl, $0110 ; $69ce
	call FarCallVector ; $69d1
	ret ; $69d4
LoadCharChargeFlashGfx:
	ld a, [$df37] ; $69d5
	and a, $07 ; $69d8
	add a, $08 ; $69da
	ld d, a ; $69dc
	ld a, [$df3a] ; $69dd
	add a, $08 ; $69e0
	ld b, a ; $69e2
	ld hl, $0110 ; $69e3
	call FarCallVector ; $69e6
	ret ; $69e9
SetCharAnimation:
	ld hl, $df2e ; $69ea
	ld a, [hl] ; $69ed
	cp a, d ; $69ee
	ret z ; $69ef
	ld [hl], d ; $69f0
	xor a, a ; $69f1
	ld [$df2f], a ; $69f2
	ld hl, $df37 ; $69f5
	ld a, [hl] ; $69f8
	and a, $0f ; $69f9
	ld [hl], a ; $69fb
	ld hl, $df28 ; $69fc
	ld a, [hl+] ; $69ff
	ld h, [hl] ; $6a00
	ld l, a ; $6a01
	ld a, d ; $6a02
	add a, a ; $6a03
	add a, l ; $6a04
	ld l, a ; $6a05
	jr nc, Label_08_6a09 ; $6a06
	inc h ; $6a08
Label_08_6a09:
	ld a, [wCharActive] ; $6a09
	call FarReadWordDI ; $6a0c
	ld hl, $df2a ; $6a0f
	ld a, c ; $6a12
	ld [hl+], a ; $6a13
	ld [hl], b ; $6a14
	ld hl, $df2c ; $6a15
	ld a, c ; $6a18
	ld [hl+], a ; $6a19
	ld [hl], b ; $6a1a
	ret ; $6a1b
SetCharState:
	ld hl, wCharState ; $6a1c
	ld [hl+], a ; $6a1f
	xor a, a ; $6a20
	ld [hl+], a ; $6a21
	ld [hl+], a ; $6a22
	ld hl, $df10 ; $6a23
	ld [hl+], a ; $6a26
	ld hl, $df12 ; $6a27
	ld [hl+], a ; $6a2a
	ret ; $6a2b
SetCharFacing:
	ld [wCharFacingDesired], a ; $6a2c
	ld [wCharFacingShown], a ; $6a2f
	ret ; $6a32
FlipCharPositionCode:
	ld hl, wCharCourtPos ; $6a33
	ld a, [hl] ; $6a36
	xor a, b ; $6a37
	ld [hl], a ; $6a38
	ret ; $6a39
ForEachCharBank:
	push hl ; $6a3a
	wram_bank $07 ; $6a3b
	call JumpToHL ; $6a41
	pop hl ; $6a44
	push hl ; $6a45
	wram_bank $06 ; $6a46
	call JumpToHL ; $6a4c
	pop hl ; $6a4f
	push hl ; $6a50
	wram_bank $05 ; $6a51
	call JumpToHL ; $6a57
	pop hl ; $6a5a
	wram_bank $04 ; $6a5b
	jp hl ; $6a61
UpdateCharStateMachine:
	xor a, a ; $6a62
	ld [$df56], a ; $6a63
	ld hl, $df10 ; $6a66
	ld a, [hl] ; $6a69
	and a, a ; $6a6a
	jr z, Label_08_6a6f ; $6a6b
	dec [hl] ; $6a6d
	ret ; $6a6e
Label_08_6a6f:
	ld hl, $df11 ; $6a6f
	ld a, [hl] ; $6a72
	and a, a ; $6a73
	jr z, Label_08_6a77 ; $6a74
	dec [hl] ; $6a76
Label_08_6a77:
	ld a, [wCharState] ; $6a77
	rst Rst00 ; $6a7a
	dw Label_08_6a8f ; $6a7b jumptable
	dw CharRallyState ; $6a7d jumptable
	dw Label_08_6bd9 ; $6a7f jumptable
	dw CharServeState ; $6a81 jumptable
	dw CharAwaitServeState ; $6a83 jumptable
	dw CharStandbyState ; $6a85 jumptable
	dw CharWalkState ; $6a87 jumptable
	dw CharPointEndState ; $6a89 jumptable
AdvanceCharStatePhase:
	ld hl, $df19 ; $6a8b
	inc [hl] ; $6a8e
Label_08_6a8f:
	ret ; $6a8f
Label_08_6a90:
	ld a, [$df2e] ; $6a90
	cp a, $05 ; $6a93
	jr z, Label_08_6ad0 ; $6a95
	cp a, $06 ; $6a97
	jr z, Label_08_6ad0 ; $6a99
	cp a, $07 ; $6a9b
	jr z, Label_08_6ad0 ; $6a9d
	cp a, $09 ; $6a9f
	jr z, Label_08_6ad0 ; $6aa1
	cp a, $0a ; $6aa3
	jr z, Label_08_6ad0 ; $6aa5
	cp a, $0b ; $6aa7
	jr z, Label_08_6ad0 ; $6aa9
	cp a, $12 ; $6aab
	jr z, Label_08_6ad0 ; $6aad
	ld hl, wCharFlags ; $6aaf
	bit 2, [hl] ; $6ab2
	jr nz, Label_08_6ad0 ; $6ab4
	xor a, a ; $6ab6
	ld [$df16], a ; $6ab7
	ld [$df17], a ; $6aba
	ld [$df4f], a ; $6abd
	ld [$df4b], a ; $6ac0
	ld hl, wCharFlags ; $6ac3
	res 0, [hl] ; $6ac6
	res 1, [hl] ; $6ac8
	res 5, [hl] ; $6aca
	ld hl, $df19 ; $6acc
	inc [hl] ; $6acf
Label_08_6ad0:
	xor a, a ; $6ad0
	ld [$df16], a ; $6ad1
	ld [$df17], a ; $6ad4
	ld [$df5a], a ; $6ad7
	xor a, a ; $6ada
	ld [$df51], a ; $6adb
	call EndChargeFlash ; $6ade
	ret ; $6ae1
CharServeState:
	ld a, [$df19] ; $6ae2
	rst Rst00 ; $6ae5
	dw CharServeInitPhase ; $6ae6 jumptable
	dw Label_08_6b33 ; $6ae8 jumptable
	dw CharServeTossPhase ; $6aea jumptable
	dw CharServeSwingWindowPhase ; $6aec jumptable
	dw CharServeStrikePhase ; $6aee jumptable
	dw Label_08_6a8f ; $6af0 jumptable
CharServeInitPhase:
	call ResetBallState ; $6af2
	xor a, a ; $6af5
	ld [$df16], a ; $6af6
	ld [$df17], a ; $6af9
	ld [$df4f], a ; $6afc
	ld hl, wCharFlags ; $6aff
	res 0, [hl] ; $6b02
	res 1, [hl] ; $6b04
	ld a, [$c7b8] ; $6b06
	and a, a ; $6b09
	jr nz, Label_08_6b29 ; $6b0a
	ld a, [$c7b9] ; $6b0c
	and a, a ; $6b0f
	jr nz, Label_08_6b29 ; $6b10
	ld a, [$c7ba] ; $6b12
	and a, a ; $6b15
	jr nz, Label_08_6b29 ; $6b16
	ldh a, [hWramBank] ; $6b18
	push af ; $6b1a
	wram_bank $04 ; $6b1b
	farcall SpawnServeIndicatorObjs ; $6b21
	pop af ; $6b24
	wram_bank ; $6b25
Label_08_6b29:
	ld d, $11 ; $6b29
	call SetCharAnimation ; $6b2b
	ld hl, $df19 ; $6b2e
	inc [hl] ; $6b31
	ret ; $6b32
Label_08_6b33:
	ld a, [$df2e] ; $6b33
	cp a, $10 ; $6b36
	jr nz, Label_08_6b3e ; $6b38
	ld hl, $df19 ; $6b3a
	inc [hl] ; $6b3d
Label_08_6b3e:
	ret ; $6b3e
CharServeTossPhase:
	call HandleServePositioning ; $6b3f
	ld a, [$df1f] ; $6b42
	and a, PADF_A | PADF_B ; $6b45
	jr z, Label_08_6b8c ; $6b47
	ld bc, rWBK ; $6b49
	ld hl, wCharPosDepth + 1 ; $6b4c
	ld a, [hl+] ; $6b4f
	ld d, [hl] ; $6b50
	ld e, a ; $6b51
	ld hl, wCharPosX + 1 ; $6b52
	ld a, [hl+] ; $6b55
	ld h, [hl] ; $6b56
	ld l, a ; $6b57
	call SetBallPosition ; $6b58
	ld hl, $0b00 ; $6b5b
	ld bc, $c000 ; $6b5e
	ld de, $0000 ; $6b61
	call SetBallVelocityPolar ; $6b64
	ld a, $01 ; $6b67
	ld [wBallSpriteEnabled], a ; $6b69
	ld [wBallShadowEnabled], a ; $6b6c
	ld [wBallTrailEnabled], a ; $6b6f
	ldh a, [hWramBank] ; $6b72
	push af ; $6b74
	wram_bank $04 ; $6b75
	farcall DismissServeIndicatorObjs ; $6b7b
	pop af ; $6b7e
	wram_bank ; $6b7f
	ld d, $0f ; $6b83
	call SetCharAnimation ; $6b85
	ld hl, $df19 ; $6b88
	inc [hl] ; $6b8b
Label_08_6b8c:
	ret ; $6b8c
CharServeSwingWindowPhase:
	ld hl, wBallVelocityHeight + 1 ; $6b8d
	bit 7, [hl] ; $6b90
	jr nz, Label_08_6ba9 ; $6b92
	ld hl, $df70 ; $6b94
	ld a, [hl+] ; $6b97
	ld b, [hl] ; $6b98
	ld c, a ; $6b99
	ld hl, wBallHeight ; $6b9a
	ld a, [hl+] ; $6b9d
	ld h, [hl] ; $6b9e
	ld l, a ; $6b9f
	add hl, bc ; $6ba0
	jr nc, Label_08_6ba9 ; $6ba1
	ld hl, $df19 ; $6ba3
	ld [hl], $00 ; $6ba6
	ret ; $6ba8
Label_08_6ba9:
	call BufferShotButtonPress ; $6ba9
	and a, a ; $6bac
	jr z, Label_08_6bc1 ; $6bad
	ld a, $07 ; $6baf
	ld [$df15], a ; $6bb1
	ld d, a ; $6bb4
	call SetCharAnimation ; $6bb5
	ld hl, $df19 ; $6bb8
	inc [hl] ; $6bbb
	ld hl, $c4c8 ; $6bbc
	set 1, [hl] ; $6bbf
Label_08_6bc1:
	ret ; $6bc1
CharServeStrikePhase:
	call BufferShotButtonPress ; $6bc2
	ld a, [$df11] ; $6bc5
	and a, a ; $6bc8
	jr nz, Label_08_6bd8 ; $6bc9
	call CaptureServeAim ; $6bcb
	call SelectServeShotType ; $6bce
	farcall ExecuteShot ; $6bd1
	ld hl, $df19 ; $6bd4
	inc [hl] ; $6bd7
Label_08_6bd8:
	ret ; $6bd8
Label_08_6bd9:
	ld a, [$df19] ; $6bd9
	rst Rst00 ; $6bdc
	dw Label_08_6a90 ; $6bdd jumptable
	dw Label_08_6be3 ; $6bdf jumptable
	dw Label_08_6a8f ; $6be1 jumptable
Label_08_6be3:
	call ApplyCharMovementInput ; $6be3
	call UpdateCharRunAnimation ; $6be6
	ret ; $6be9
CharRallyState:
	ld a, [$df19] ; $6bea
	rst Rst00 ; $6bed
	dw Label_08_6a90 ; $6bee jumptable
	dw CharRallyReadyPhase ; $6bf0 jumptable
	dw CharSwingWindupPhase ; $6bf2 jumptable
	dw CharSwingContactPhase ; $6bf4 jumptable
	dw Label_08_6a8f ; $6bf6 jumptable
CharRallyReadyPhase:
	ld a, $01 ; $6bf8
	ld [$df5a], a ; $6bfa
	call ApplyCharMovementInput ; $6bfd
	call UpdateCharRunAnimation ; $6c00
	call BufferShotButtonPress ; $6c03
	and a, a ; $6c06
	jr z, Label_08_6c2e ; $6c07
	call SelectForehandBackhand ; $6c09
	ld hl, $df15 ; $6c0c
	ld a, $08 ; $6c0f
	add a, [hl] ; $6c11
	ld d, a ; $6c12
	call SetCharAnimation ; $6c13
	ld hl, wCharFlags ; $6c16
	set 5, [hl] ; $6c19
	xor a, a ; $6c1b
	ld [$df4b], a ; $6c1c
	ld [$df4d], a ; $6c1f
	ld [$df4e], a ; $6c22
	ld a, $01 ; $6c25
	ld [$df51], a ; $6c27
	ld hl, $df19 ; $6c2a
	inc [hl] ; $6c2d
Label_08_6c2e:
	ret ; $6c2e
CharSwingWindupPhase:
	ld hl, $df4b ; $6c2f
	inc [hl] ; $6c32
	call ApplyCharMovementInput ; $6c33
	call BufferShotButtonPress ; $6c36
	call CheckSwingRelease ; $6c39
	and a, a ; $6c3c
	jr nz, Label_08_6c5f ; $6c3d
	ld hl, $df50 ; $6c3f
	bit 0, [hl] ; $6c42
	jr nz, Label_08_6c47 ; $6c44
	ret ; $6c46
Label_08_6c47:
	call StartCharSwing ; $6c47
	ld hl, $df15 ; $6c4a
	ld d, [hl] ; $6c4d
	call SetCharAnimation ; $6c4e
	sound $59 ; $6c51
	xor a, a ; $6c53
	ld [$df51], a ; $6c54
	call EndChargeFlash ; $6c57
	ld hl, $df19 ; $6c5a
	inc [hl] ; $6c5d
	ret ; $6c5e
Label_08_6c5f:
	ld hl, wCharFlags ; $6c5f
	res 5, [hl] ; $6c62
	xor a, a ; $6c64
	ld [$df51], a ; $6c65
	call EndChargeFlash ; $6c68
	xor a, a ; $6c6b
	ld [$df16], a ; $6c6c
	ld [$df17], a ; $6c6f
	ld [$df4f], a ; $6c72
	ld hl, $df19 ; $6c75
	dec [hl] ; $6c78
	ret ; $6c79
CharSwingContactPhase:
	ld hl, $df4b ; $6c7a
	inc [hl] ; $6c7d
	call ApplyCharMovementInput ; $6c7e
	call CaptureShotAim ; $6c81
	call ResetSwingAnimation ; $6c84
	ld hl, $df50 ; $6c87
	bit 1, [hl] ; $6c8a
	jr z, Label_08_6c98 ; $6c8c
	call SelectRallyShotType ; $6c8e
	farcall ExecuteShot ; $6c91
	ld hl, $df19 ; $6c94
	inc [hl] ; $6c97
Label_08_6c98:
	ret ; $6c98
ResetSwingAnimation:
	ld a, [$df2e] ; $6c99
	cp a, $08 ; $6c9c
	jr z, Label_08_6ca6 ; $6c9e
	cp a, $0c ; $6ca0
	jr z, Label_08_6ca6 ; $6ca2
	jr Label_08_6cb2 ; $6ca4
Label_08_6ca6:
	ld hl, wCharFlags ; $6ca6
	bit 2, [hl] ; $6ca9
	jr nz, Label_08_6cb2 ; $6cab
	ld d, $01 ; $6cad
	call SetCharAnimation ; $6caf
Label_08_6cb2:
	ld a, [$df2e] ; $6cb2
	cp a, $01 ; $6cb5
	jr nz, Label_08_6cbd ; $6cb7
	xor a, a ; $6cb9
	ld [$df19], a ; $6cba
Label_08_6cbd:
	ret ; $6cbd
CharStandbyState:
	ld a, [$df19] ; $6cbe
	rst Rst00 ; $6cc1
	dw Label_08_6a90 ; $6cc2 jumptable
	dw Label_08_6cd4 ; $6cc4 jumptable
	dw Label_08_6a8f ; $6cc6 jumptable
CharAwaitServeState:
	ld a, [$df19] ; $6cc8
	rst Rst00 ; $6ccb
	dw Label_08_6a90 ; $6ccc jumptable
	dw Label_08_6cdb ; $6cce jumptable
	dw Label_08_6cd4 ; $6cd0 jumptable
	dw Label_08_6a8f ; $6cd2 jumptable
Label_08_6cd4:
	call ApplyCharMovementInput ; $6cd4
	call UpdateCharRunAnimation ; $6cd7
	ret ; $6cda
Label_08_6cdb:
	call ApplyCharMovementInput ; $6cdb
	call UpdateCharRunAnimation ; $6cde
	ld hl, wCharPosDepth + 1 ; $6ce1
	ld a, [hl+] ; $6ce4
	ld h, [hl] ; $6ce5
	ld l, a ; $6ce6
	bit 7, h ; $6ce7
	jr z, Label_08_6cf1 ; $6ce9
	xor a, a ; $6ceb
	sub a, l ; $6cec
	ld l, a ; $6ced
	sbc a, a ; $6cee
	sub a, h ; $6cef
	ld h, a ; $6cf0
Label_08_6cf1:
	ld de, $fe00 ; $6cf1
	add hl, de ; $6cf4
	bit 7, h ; $6cf5
	jr nz, Label_08_6d0d ; $6cf7
	ldh a, [hWramBank] ; $6cf9
	push af ; $6cfb
	wram_bank $04 ; $6cfc
	farcall DismissServeIndicatorObjs ; $6d02
	pop af ; $6d05
	wram_bank ; $6d06
	jp AdvanceCharStatePhase ; $6d0a
Label_08_6d0d:
	ret ; $6d0d
CharWalkState:
	ld a, [$df19] ; $6d0e
	rst Rst00 ; $6d11
	dw CharWalkToTargetPhase ; $6d12 jumptable
	dw Label_08_6a8f ; $6d14 jumptable
CharPointEndState:
	ld a, [$df19] ; $6d16
	rst Rst00 ; $6d19
	dw Label_08_6a90 ; $6d1a jumptable
	dw CharWalkToTargetPhase ; $6d1c jumptable
	dw CharPointReactionPhase ; $6d1e jumptable
	dw Label_08_6a8f ; $6d20 jumptable
	dw Label_00_1921 ; $6d22 jumptable
	dw Label_00_34df ; $6d24 jumptable
	ret ; $6d26
CharPointReactionPhase:
	call ReloadCharFrameGfx ; $6d27
	ld a, [wCharPointResult] ; $6d2a
	add a, a ; $6d2d
	jr z, Label_08_6d39 ; $6d2e
	ld d, $03 ; $6d30
	jr nc, Label_08_6d36 ; $6d32
	ld d, $04 ; $6d34
Label_08_6d36:
	call SetCharAnimation ; $6d36
Label_08_6d39:
	ld hl, $df19 ; $6d39
	inc [hl] ; $6d3c
	ret ; $6d3d
CharWalkToTargetPhase:
	call MoveCharTowardTarget ; $6d3e
	push af ; $6d41
	call UpdateCharRunAnimation ; $6d42
	pop af ; $6d45
	and a, a ; $6d46
	jp z, AdvanceCharStatePhase ; $6d47
	ret ; $6d4a
UpdateCharRunAnimation:
	ld d, $02 ; $6d4b
	ld hl, wCharFlags ; $6d4d
	bit 4, [hl] ; $6d50
	jr nz, Label_08_6d56 ; $6d52
	ld d, $01 ; $6d54
Label_08_6d56:
	call SetCharAnimation ; $6d56
	ret ; $6d59
StartCharSwing:
	ld a, [$df90] ; $6d5a
	bit 7, a ; $6d5d
	call PredictBallLateralOffset ; $6d5f
	bit 7, h ; $6d62
	jr nz, Label_08_6d6f ; $6d64
	ld a, [$df1f] ; $6d66
	bit PADB_RIGHT, a ; $6d69
	jr z, Label_08_6da0 ; $6d6b
	jr Label_08_6d76 ; $6d6d
Label_08_6d6f:
	ld a, [$df1f] ; $6d6f
	bit PADB_LEFT, a ; $6d72
	jr z, Label_08_6da0 ; $6d74
Label_08_6d76:
	ld a, [$df72] ; $6d76
	ld e, a ; $6d79
	ld a, [$df73] ; $6d7a
	ld d, a ; $6d7d
	ld a, [$df50] ; $6d7e
	bit 4, a ; $6d81
	ld bc, $fff0 ; $6d83
	jr nz, Label_08_6d8b ; $6d86
	ld bc, $0000 ; $6d88
Label_08_6d8b:
	bit 7, h ; $6d8b
	jr z, Label_08_6d95 ; $6d8d
	xor a, a ; $6d8f
	sub a, l ; $6d90
	ld l, a ; $6d91
	sbc a, a ; $6d92
	sub a, h ; $6d93
	ld h, a ; $6d94
Label_08_6d95:
	add hl, bc ; $6d95
	ld a, l ; $6d96
	sub a, e ; $6d97
	ld l, a ; $6d98
	ld a, h ; $6d99
	sbc a, d ; $6d9a
	ld h, a ; $6d9b
	bit 7, h ; $6d9c
	jr z, Label_08_6df4 ; $6d9e
Label_08_6da0:
	ld a, [wBallVelocityHeight + 1] ; $6da0
	ld l, a ; $6da3
	add a, a ; $6da4
	sbc a, a ; $6da5
	ld h, a ; $6da6
	add hl, hl ; $6da7
	ld c, l ; $6da8
	ld b, h ; $6da9
	ld hl, $df70 ; $6daa
	ld a, [hl+] ; $6dad
	ld d, [hl] ; $6dae
	ld e, a ; $6daf
	ld hl, wBallHeight ; $6db0
	ld a, [hl+] ; $6db3
	ld h, [hl] ; $6db4
	ld l, a ; $6db5
	add hl, de ; $6db6
	add hl, de ; $6db7
	add hl, bc ; $6db8
	bit 7, h ; $6db9
	jr nz, Label_08_6dd5 ; $6dbb
	ld hl, wBallHeight ; $6dbd
	ld a, [hl+] ; $6dc0
	ld h, [hl] ; $6dc1
	ld l, a ; $6dc2
	add hl, de ; $6dc3
	sra d ; $6dc4
	rr e ; $6dc6
	add hl, de ; $6dc8
	add hl, bc ; $6dc9
	bit 7, h ; $6dca
	jr z, Label_08_6dd3 ; $6dcc
	ld hl, $df15 ; $6dce
	ld [hl], $07 ; $6dd1
Label_08_6dd3:
	jr Label_08_6e2c ; $6dd3
Label_08_6dd5:
	ld hl, wCharFlags ; $6dd5
	set 2, [hl] ; $6dd8
	ld hl, $df74 ; $6dda
	ld a, [hl+] ; $6ddd
	ld d, [hl] ; $6dde
	ld e, a ; $6ddf
	xor a, a ; $6de0
	sub a, e ; $6de1
	ld e, a ; $6de2
	sbc a, a ; $6de3
	sub a, d ; $6de4
	ld d, a ; $6de5
	ld hl, wCharVelHeight ; $6de6
	ld a, e ; $6de9
	ld [hl+], a ; $6dea
	ld [hl], d ; $6deb
	ld hl, $df15 ; $6dec
	ld [hl], $08 ; $6def
	sound $5c ; $6df1
	ret ; $6df3
Label_08_6df4:
	ld hl, $df15 ; $6df4
	ld [hl], $12 ; $6df7
	ld d, $00 ; $6df9
	ld a, [$df1f] ; $6dfb
	bit PADB_RIGHT, a ; $6dfe
	jr nz, Label_08_6e04 ; $6e00
	ld d, $80 ; $6e02
Label_08_6e04:
	ld hl, wCharFacingShown ; $6e04
	ld [hl], d ; $6e07
	ld hl, wCharFlags ; $6e08
	set 1, [hl] ; $6e0b
	res 5, [hl] ; $6e0d
	ld hl, $df76 ; $6e0f
	ld a, [hl+] ; $6e12
	ld h, [hl] ; $6e13
	ld l, a ; $6e14
	ld a, [wCharFacingDesired] ; $6e15
	call VectorFromLengthAndAngleRaw ; $6e18
	ld c, l ; $6e1b
	ld b, h ; $6e1c
	xor a, a ; $6e1d
	ld hl, wCharVelX ; $6e1e
	ld [hl+], a ; $6e21
	ld [hl], c ; $6e22
	xor a, a ; $6e23
	ld hl, wCharVelDepth ; $6e24
	ld [hl+], a ; $6e27
	ld [hl], e ; $6e28
	sound $5c ; $6e29
	ret ; $6e2b
Label_08_6e2c:
	xor a, a ; $6e2c
	ld [$df4c], a ; $6e2d
	ld a, [$df4b] ; $6e30
	cp a, $05 ; $6e33
	jr nc, Label_08_6e43 ; $6e35
	ld hl, $df15 ; $6e37
	ld a, $04 ; $6e3a
	add a, [hl] ; $6e3c
	ld [hl], a ; $6e3d
	ld a, $01 ; $6e3e
	ld [$df4c], a ; $6e40
Label_08_6e43:
	ret ; $6e43
SelectForehandBackhand:
	call PredictBallLateralOffset ; $6e44
	ld a, [$df94] ; $6e47
	and a, a ; $6e4a
	jr z, Label_08_6e50 ; $6e4b
	ld a, h ; $6e4d
	cpl ; $6e4e
	ld h, a ; $6e4f
Label_08_6e50:
	ld a, [wCharPosDepth + 2] ; $6e50
	xor a, h ; $6e53
	bit 7, a ; $6e54
	jr nz, Label_08_6e5e ; $6e56
	ld a, $05 ; $6e58
	ld [$df15], a ; $6e5a
	ret ; $6e5d
Label_08_6e5e:
	ld a, $06 ; $6e5e
	ld [$df15], a ; $6e60
	ret ; $6e63
UpdateCharBallGeometry:
	ld de, wBallX ; $6e64
	ld hl, wCharPosX + 1 ; $6e67
	ld bc, wBallRelCharX ; $6e6a
	ld a, [de] ; $6e6d
	sub a, [hl] ; $6e6e
	ld [bc], a ; $6e6f
	inc e ; $6e70
	inc l ; $6e71
	inc c ; $6e72
	ld a, [de] ; $6e73
	sbc a, [hl] ; $6e74
	ld [bc], a ; $6e75
	inc c ; $6e76
	ld de, wBallDepth ; $6e77
	ld hl, wCharPosDepth + 1 ; $6e7a
	ld a, [de] ; $6e7d
	sub a, [hl] ; $6e7e
	ld [bc], a ; $6e7f
	inc e ; $6e80
	inc l ; $6e81
	inc c ; $6e82
	ld a, [de] ; $6e83
	sbc a, [hl] ; $6e84
	ld [bc], a ; $6e85
	inc c ; $6e86
	ld de, wBallHeight ; $6e87
	ld hl, wCharPosHeight + 1 ; $6e8a
	ld a, [de] ; $6e8d
	sub a, [hl] ; $6e8e
	ld [bc], a ; $6e8f
	inc e ; $6e90
	inc l ; $6e91
	inc c ; $6e92
	ld a, [de] ; $6e93
	sbc a, [hl] ; $6e94
	ld [bc], a ; $6e95
	ld hl, wCharPosDepth + 1 ; $6e96
	ld a, [hl+] ; $6e99
	ld h, [hl] ; $6e9a
	ld l, a ; $6e9b
	bit 7, h ; $6e9c
	jr z, Label_08_6ea6 ; $6e9e
	xor a, a ; $6ea0
	sub a, l ; $6ea1
	ld l, a ; $6ea2
	sbc a, a ; $6ea3
	sub a, h ; $6ea4
	ld h, a ; $6ea5
Label_08_6ea6:
	xor a, a ; $6ea6
	ld de, $fd60 ; $6ea7
	add hl, de ; $6eaa
	jr c, Label_08_6eaf ; $6eab
	set 4, a ; $6ead
Label_08_6eaf:
	ld [$df50], a ; $6eaf
	call CheckBallInSwingRange ; $6eb2
	ld hl, $df50 ; $6eb5
	bit 0, [hl] ; $6eb8
	ret z ; $6eba
	call CheckBallContactWindow ; $6ebb
	ld hl, $df50 ; $6ebe
	bit 1, [hl] ; $6ec1
	ret z ; $6ec3
	ret ; $6ec4
CheckCharBallContact:
	ld a, [$df16] ; $6ec5
	and a, a ; $6ec8
	ret nz ; $6ec9
	ld a, [wCharState] ; $6eca
	cp a, $01 ; $6ecd
	ret nz ; $6ecf
	ld a, [wPointOutcome] ; $6ed0
	and a, a ; $6ed3
	ret nz ; $6ed4
	ld hl, wBallRelCharDepth ; $6ed5
	ld a, [hl+] ; $6ed8
	ld h, [hl] ; $6ed9
	ld l, a ; $6eda
	bit 7, h ; $6edb
	jr z, Label_08_6ee5 ; $6edd
	xor a, a ; $6edf
	sub a, l ; $6ee0
	ld l, a ; $6ee1
	sbc a, a ; $6ee2
	sub a, h ; $6ee3
	ld h, a ; $6ee4
Label_08_6ee5:
	ld de, $fff0 ; $6ee5
	add hl, de ; $6ee8
	ret c ; $6ee9
	ld hl, $df72 ; $6eea
	ld a, [hl+] ; $6eed
	ld h, [hl] ; $6eee
	ld l, a ; $6eef
	ld e, l ; $6ef0
	ld d, h ; $6ef1
	ld hl, wBallRelCharX ; $6ef2
	ld a, [hl+] ; $6ef5
	ld h, [hl] ; $6ef6
	ld l, a ; $6ef7
	bit 7, h ; $6ef8
	jr z, Label_08_6f02 ; $6efa
	xor a, a ; $6efc
	sub a, l ; $6efd
	ld l, a ; $6efe
	sbc a, a ; $6eff
	sub a, h ; $6f00
	ld h, a ; $6f01
Label_08_6f02:
	add hl, hl ; $6f02
	ld a, l ; $6f03
	sub a, e ; $6f04
	ld l, a ; $6f05
	ld a, h ; $6f06
	sbc a, d ; $6f07
	ld h, a ; $6f08
	ret nc ; $6f09
	ld hl, $df70 ; $6f0a
	ld a, [hl+] ; $6f0d
	ld h, [hl] ; $6f0e
	ld l, a ; $6f0f
	ld e, l ; $6f10
	ld d, h ; $6f11
	ld hl, wBallRelCharHeight ; $6f12
	ld a, [hl+] ; $6f15
	ld h, [hl] ; $6f16
	ld l, a ; $6f17
	bit 7, h ; $6f18
	jr z, Label_08_6f22 ; $6f1a
	xor a, a ; $6f1c
	sub a, l ; $6f1d
	ld l, a ; $6f1e
	sbc a, a ; $6f1f
	sub a, h ; $6f20
	ld h, a ; $6f21
Label_08_6f22:
	ld a, l ; $6f22
	sub a, e ; $6f23
	ld l, a ; $6f24
	ld a, h ; $6f25
	sbc a, d ; $6f26
	ld h, a ; $6f27
	ret nc ; $6f28
	ld hl, $df50 ; $6f29
	set 2, [hl] ; $6f2c
	ld a, $01 ; $6f2e
	ld [wBallTouchCharFlag], a ; $6f30
	ld a, [wCharIndex] ; $6f33
	ld [wBallTouchCharIndex], a ; $6f36
	ld hl, wCharFlags ; $6f39
	set 0, [hl] ; $6f3c
	res 5, [hl] ; $6f3e
	ld a, $00 ; $6f40
	call SetCharState ; $6f42
	ld hl, wBallVelocityDepth ; $6f45
	ld a, [hl+] ; $6f48
	ld d, [hl] ; $6f49
	ld e, a ; $6f4a
	sra d ; $6f4b
	rr e ; $6f4d
	ld hl, wCharVelDepth ; $6f4f
	ld a, e ; $6f52
	ld [hl+], a ; $6f53
	ld [hl], d ; $6f54
	ld hl, $c423 ; $6f55
	ld a, [hl] ; $6f58
	cpl ; $6f59
	ld [hl+], a ; $6f5a
	ld a, [hl] ; $6f5b
	cpl ; $6f5c
	ld [hl+], a ; $6f5d
	ld a, [hl] ; $6f5e
	cpl ; $6f5f
	ld [hl+], a ; $6f60
	ld hl, $c404 ; $6f61
	ld de, $c423 ; $6f64
	call AddVel24ToPos32 ; $6f67
	ld hl, wBallVelocityDepth ; $6f6a
	ld a, [hl+] ; $6f6d
	ld d, [hl] ; $6f6e
	ld e, a ; $6f6f
	sra d ; $6f70
	rr e ; $6f72
	sra d ; $6f74
	rr e ; $6f76
	sra d ; $6f78
	rr e ; $6f7a
	sra d ; $6f7c
	rr e ; $6f7e
	ld hl, wBallVelocityDepth ; $6f80
	ld a, e ; $6f83
	ld [hl+], a ; $6f84
	ld [hl], d ; $6f85
	ld hl, wBallVelocityX ; $6f86
	ld a, [hl+] ; $6f89
	ld d, [hl] ; $6f8a
	ld e, a ; $6f8b
	sra d ; $6f8c
	rr e ; $6f8e
	ld hl, wBallVelocityX ; $6f90
	ld a, e ; $6f93
	ld [hl+], a ; $6f94
	ld [hl], d ; $6f95
	ld hl, wBallVelocityHeight ; $6f96
	ld a, [hl+] ; $6f99
	ld d, [hl] ; $6f9a
	ld e, a ; $6f9b
	sra d ; $6f9c
	rr e ; $6f9e
	ld hl, wBallVelocityHeight ; $6fa0
	ld a, e ; $6fa3
	ld [hl+], a ; $6fa4
	ld [hl], d ; $6fa5
	ret ; $6fa6
CheckBallContactWindow:
	ld hl, wBallRelCharDepth ; $6fa7
	ld a, [hl+] ; $6faa
	ld h, [hl] ; $6fab
	ld l, a ; $6fac
	bit 7, h ; $6fad
	jr z, Label_08_6fb7 ; $6faf
	xor a, a ; $6fb1
	sub a, l ; $6fb2
	ld l, a ; $6fb3
	sbc a, a ; $6fb4
	sub a, h ; $6fb5
	ld h, a ; $6fb6
Label_08_6fb7:
	ld de, hPeakLY ; $6fb7
	add hl, de ; $6fba
	ret c ; $6fbb
	ld hl, $df72 ; $6fbc
	ld a, [hl+] ; $6fbf
	ld h, [hl] ; $6fc0
	ld l, a ; $6fc1
	ld e, l ; $6fc2
	ld d, h ; $6fc3
	ld a, [wCharFlags] ; $6fc4
	bit 1, a ; $6fc7
	jr z, Label_08_6fda ; $6fc9
	ld l, e ; $6fcb
	ld h, d ; $6fcc
	sra d ; $6fcd
	rr e ; $6fcf
	sra d ; $6fd1
	rr e ; $6fd3
	add hl, de ; $6fd5
	ld e, l ; $6fd6
	ld d, h ; $6fd7
	jr Label_08_6fed ; $6fd8
Label_08_6fda:
	ld a, [$df2e] ; $6fda
	cp a, $05 ; $6fdd
	jr z, Label_08_6fed ; $6fdf
	cp a, $06 ; $6fe1
	jr z, Label_08_6fed ; $6fe3
	cp a, $09 ; $6fe5
	jr z, Label_08_6fed ; $6fe7
	cp a, $0a ; $6fe9
	jr z, Label_08_6fed ; $6feb
Label_08_6fed:
	ld hl, wBallRelCharX ; $6fed
	ld a, [hl+] ; $6ff0
	ld h, [hl] ; $6ff1
	ld l, a ; $6ff2
	bit 7, h ; $6ff3
	jr z, Label_08_6ffd ; $6ff5
	xor a, a ; $6ff7
	sub a, l ; $6ff8
	ld l, a ; $6ff9
	sbc a, a ; $6ffa
	sub a, h ; $6ffb
	ld h, a ; $6ffc
Label_08_6ffd:
	ld a, l ; $6ffd
	sub a, e ; $6ffe
	ld l, a ; $6fff
	ld a, h ; $7000
	sbc a, d ; $7001
	ld h, a ; $7002
	ret nc ; $7003
	ld hl, $df70 ; $7004
	ld a, [hl+] ; $7007
	ld h, [hl] ; $7008
	ld l, a ; $7009
	add hl, hl ; $700a
	ld e, l ; $700b
	ld d, h ; $700c
	ld hl, wBallRelCharHeight ; $700d
	ld a, [hl+] ; $7010
	ld h, [hl] ; $7011
	ld l, a ; $7012
	bit 7, h ; $7013
	jr z, Label_08_701d ; $7015
	xor a, a ; $7017
	sub a, l ; $7018
	ld l, a ; $7019
	sbc a, a ; $701a
	sub a, h ; $701b
	ld h, a ; $701c
Label_08_701d:
	ld a, l ; $701d
	sub a, e ; $701e
	ld l, a ; $701f
	ld a, h ; $7020
	sbc a, d ; $7021
	ld h, a ; $7022
	ret nc ; $7023
	ld hl, $df50 ; $7024
	set 1, [hl] ; $7027
	ret ; $7029
CheckBallInSwingRange:
	ld hl, wBallRelCharDepth ; $702a
	ld a, [hl+] ; $702d
	ld h, [hl] ; $702e
	ld l, a ; $702f
	bit 7, h ; $7030
	jr z, Label_08_703a ; $7032
	xor a, a ; $7034
	sub a, l ; $7035
	ld l, a ; $7036
	sbc a, a ; $7037
	sub a, h ; $7038
	ld h, a ; $7039
Label_08_703a:
	ld de, $ff60 ; $703a
	add hl, de ; $703d
	ret c ; $703e
	ld hl, $df72 ; $703f
	ld a, [hl+] ; $7042
	ld h, [hl] ; $7043
	ld l, a ; $7044
	ld e, l ; $7045
	ld d, h ; $7046
	sra d ; $7047
	rr e ; $7049
	add hl, de ; $704b
	ld e, l ; $704c
	ld d, h ; $704d
	ld hl, wBallRelCharX ; $704e
	ld a, [hl+] ; $7051
	ld h, [hl] ; $7052
	ld l, a ; $7053
	bit 7, h ; $7054
	jr z, Label_08_705e ; $7056
	xor a, a ; $7058
	sub a, l ; $7059
	ld l, a ; $705a
	sbc a, a ; $705b
	sub a, h ; $705c
	ld h, a ; $705d
Label_08_705e:
	ld a, l ; $705e
	sub a, e ; $705f
	ld l, a ; $7060
	ld a, h ; $7061
	sbc a, d ; $7062
	ld h, a ; $7063
	ret nc ; $7064
	ld hl, $df50 ; $7065
	set 0, [hl] ; $7068
	ret ; $706a
SelectServeShotType:
	ld a, [$df16] ; $706b
	add a, $7a ; $706e
	ld l, a ; $7070
	adc a, $70 ; $7071
	sub a, l ; $7073
	ld h, a ; $7074
	ld a, [hl] ; $7075
	ld [$df14], a ; $7076
	ret ; $7079
	; $707a, 4 bytes (enum:SHOTTYPE:4)
	db SHOTTYPE_SERVE_TOPSPIN, SHOTTYPE_SERVE_TOPSPIN, SHOTTYPE_SERVE_SLICE, SHOTTYPE_SERVE_FLAT ; 0x00
SelectRallyShotType:
	ld a, [$df17] ; $707e
	add a, a ; $7081
	add a, a ; $7082
	ld d, a ; $7083
	ld a, [$df16] ; $7084
	add a, d ; $7087
	ld e, a ; $7088
	ld d, $00 ; $7089
	ld hl, $df50 ; $708b
	bit 4, [hl] ; $708e
	jr z, Label_08_70ab ; $7090
	ld hl, Data_08_709b ; $7092
	add hl, de ; $7095
	ld a, [hl] ; $7096
	ld [$df14], a ; $7097
	ret ; $709a
Data_08_709b:
	; $709b, 16 bytes (enum:SHOTTYPE:4)
	db SHOTTYPE_REACH_BASIC, SHOTTYPE_REACH_BASIC, SHOTTYPE_REACH_BASIC, SHOTTYPE_NEUTRAL ; 0x00
	db SHOTTYPE_REACH_BASIC, SHOTTYPE_REACH_POWER_TOPSPIN, SHOTTYPE_DROP, SHOTTYPE_NEUTRAL ; 0x04
	db SHOTTYPE_REACH_BASIC, SHOTTYPE_LOB, SHOTTYPE_REACH_POWER_SLICE, SHOTTYPE_NEUTRAL ; 0x08
	db SHOTTYPE_NEUTRAL, SHOTTYPE_NEUTRAL, SHOTTYPE_NEUTRAL, SHOTTYPE_NEUTRAL ; 0x0c
Label_08_70ab:
	ld hl, Data_08_70b4 ; $70ab
	add hl, de ; $70ae
	ld a, [hl] ; $70af
	ld [$df14], a ; $70b0
	ret ; $70b3
Data_08_70b4:
	; $70b4, 16 bytes (enum:SHOTTYPE:4)
	db SHOTTYPE_TOPSPIN, SHOTTYPE_TOPSPIN, SHOTTYPE_SLICE, SHOTTYPE_NEUTRAL ; 0x00
	db SHOTTYPE_TOPSPIN, SHOTTYPE_POWER_TOPSPIN, SHOTTYPE_DROP, SHOTTYPE_NEUTRAL ; 0x04
	db SHOTTYPE_TOPSPIN, SHOTTYPE_LOB, SHOTTYPE_POWER_SLICE, SHOTTYPE_NEUTRAL ; 0x08
	db SHOTTYPE_NEUTRAL, SHOTTYPE_NEUTRAL, SHOTTYPE_NEUTRAL, SHOTTYPE_NEUTRAL ; 0x0c
ComputeBallEtaToChar:
	ld hl, wBallVelocityDepth ; $70c4
	ld a, [hl+] ; $70c7
	ld d, [hl] ; $70c8
	ld e, a ; $70c9
	ld hl, wBallRelCharDepth + 1 ; $70ca
	bit 7, [hl] ; $70cd
	jr nz, Label_08_70e0 ; $70cf
	ld l, $00 ; $70d1
	ld a, [wBallRelCharDepth] ; $70d3
	ld h, a ; $70d6
	ld a, [wBallRelCharDepth + 1] ; $70d7
	call DivAHLByDE ; $70da
	ld e, l ; $70dd
	ld d, h ; $70de
	ret ; $70df
Label_08_70e0:
	ld l, $ff ; $70e0
	ld a, [wBallRelCharDepth] ; $70e2
	cpl ; $70e5
	ld h, a ; $70e6
	ld a, [wBallRelCharDepth + 1] ; $70e7
	cpl ; $70ea
	call DivAHLByDE ; $70eb
	ld e, l ; $70ee
	ld d, h ; $70ef
	ret ; $70f0
	call ComputeBallEtaToChar ; $70f1
	ret ; $70f4
PredictBallLateralOffset:
	ld hl, wBallHeadingAngle ; $70f5
	ld a, [hl+] ; $70f8
	ld b, [hl] ; $70f9
	ld c, a ; $70fa
	ld hl, wBallRelCharDepth ; $70fb
	ld a, [hl+] ; $70fe
	ld h, [hl] ; $70ff
	ld l, a ; $7100
	xor a, a ; $7101
	sub a, l ; $7102
	ld l, a ; $7103
	sbc a, a ; $7104
	sub a, h ; $7105
	ld h, a ; $7106
	call MulHLByTangent ; $7107
	ld hl, wBallRelCharX ; $710a
	ld a, [hl+] ; $710d
	ld h, [hl] ; $710e
	ld l, a ; $710f
	add hl, de ; $7110
	ret ; $7111
BufferShotButtonPress:
	ld a, [$df1f] ; $7112
	and a, PADF_A | PADF_B ; $7115
	ret z ; $7117
	ld b, a ; $7118
	cp a, PADF_A | PADF_B ; $7119
	jr z, Label_08_714c ; $711b
	ld a, [$df11] ; $711d
	and a, a ; $7120
	jr z, Label_08_712d ; $7121
	ld a, [$df4f] ; $7123
	cp a, b ; $7126
	jr z, Label_08_712d ; $7127
	ld b, $03 ; $7129
	jr Label_08_714c ; $712b
Label_08_712d:
	ld a, b ; $712d
	ld [$df4f], a ; $712e
	ld a, $05 ; $7131
	ld [$df11], a ; $7133
	ld a, [$df16] ; $7136
	and a, a ; $7139
	jr z, Label_08_714c ; $713a
	ld a, [$df17] ; $713c
	and a, a ; $713f
	jr z, Label_08_7143 ; $7140
	ret ; $7142
Label_08_7143:
	ld a, b ; $7143
	ld [$df17], a ; $7144
	xor a, a ; $7147
	ld [$df11], a ; $7148
	ret ; $714b
Label_08_714c:
	ld a, b ; $714c
	ld [$df16], a ; $714d
	ret ; $7150
CaptureServeAim:
	ld a, [$df1f] ; $7151
	ld b, $01 ; $7154
	bit PADB_RIGHT, a ; $7156
	jr nz, Label_08_7162 ; $7158
	ld b, $ff ; $715a
	bit PADB_LEFT, a ; $715c
	jr nz, Label_08_7162 ; $715e
	ld b, $00 ; $7160
Label_08_7162:
	ld a, b ; $7162
	ld [$df4a], a ; $7163
	ret ; $7166
CaptureShotAim:
	ld a, [$df1f] ; $7167
	cp a, PADF_LEFT ; $716a
	jr z, Label_08_717c ; $716c
	bit PADB_LEFT, a ; $716e
	jr nz, Label_08_7182 ; $7170
	cp a, PADF_RIGHT ; $7172
	jr z, Label_08_7194 ; $7174
	bit PADB_RIGHT, a ; $7176
	jr nz, Label_08_718e ; $7178
	jr Label_08_7188 ; $717a
Label_08_717c:
	ld a, $fe ; $717c
	ld [$df4a], a ; $717e
	ret ; $7181
Label_08_7182:
	ld a, $ff ; $7182
	ld [$df4a], a ; $7184
	ret ; $7187
Label_08_7188:
	ld a, $00 ; $7188
	ld [$df4a], a ; $718a
	ret ; $718d
Label_08_718e:
	ld a, $01 ; $718e
	ld [$df4a], a ; $7190
	ret ; $7193
Label_08_7194:
	ld a, $02 ; $7194
	ld [$df4a], a ; $7196
	ret ; $7199
ApplyCharMovementInput:
	ld a, [$df1f] ; $719a
	and a, $f0 ; $719d
	jr z, Label_08_71dc ; $719f
	swap a ; $71a1
	add a, $86 ; $71a3
	ld l, a ; $71a5
	adc a, $72 ; $71a6
	sub a, l ; $71a8
	ld h, a ; $71a9
	ld a, [hl] ; $71aa
	cp a, $ff ; $71ab
	jr z, Label_08_71dc ; $71ad
	ld [wCharFacingDesired], a ; $71af
	ld a, [wCharFacingDesired] ; $71b2
	ld hl, wCharFacingShown ; $71b5
	sub a, [hl] ; $71b8
	bit 7, a ; $71b9
	jr z, Label_08_71bf ; $71bb
	cpl ; $71bd
	inc a ; $71be
Label_08_71bf:
	cp a, $30 ; $71bf
	jp nc, Label_08_71dc ; $71c1
	ld a, [$df1f] ; $71c4
	and a, PADF_RIGHT | PADF_LEFT ; $71c7
	jr z, Label_08_71d0 ; $71c9
	ld hl, $df50 ; $71cb
	set 6, [hl] ; $71ce
Label_08_71d0:
	ld a, [$df1f] ; $71d0
	and a, PADF_UP | PADF_DOWN ; $71d3
	jr z, Label_08_71dc ; $71d5
	ld hl, $df50 ; $71d7
	set 7, [hl] ; $71da
Label_08_71dc:
	ret ; $71dc
HandleServePositioning:
	ld a, [$c7b9] ; $71dd
	and a, a ; $71e0
	jr nz, Label_08_7229 ; $71e1
	ld a, [$df1f] ; $71e3
	and a, PADF_RIGHT | PADF_LEFT ; $71e6
	jr z, Label_08_7228 ; $71e8
	swap a ; $71ea
	add a, $86 ; $71ec
	ld l, a ; $71ee
	adc a, $72 ; $71ef
	sub a, l ; $71f1
	ld h, a ; $71f2
	ld a, [hl] ; $71f3
	cp a, $ff ; $71f4
	jr z, Label_08_7228 ; $71f6
	ld hl, $000a ; $71f8
	call VectorFromLengthAndAngleRaw ; $71fb
	ld c, l ; $71fe
	ld b, h ; $71ff
	ld hl, wCharPosX + 1 ; $7200
	ld a, [hl+] ; $7203
	ld h, [hl] ; $7204
	ld l, a ; $7205
	add hl, bc ; $7206
	bit 7, h ; $7207
	jr z, Label_08_7211 ; $7209
	xor a, a ; $720b
	sub a, l ; $720c
	ld l, a ; $720d
	sbc a, a ; $720e
	sub a, h ; $720f
	ld h, a ; $7210
Label_08_7211:
	push hl ; $7211
	ld de, $ffe0 ; $7212
	add hl, de ; $7215
	pop hl ; $7216
	jr nc, Label_08_7228 ; $7217
	ld de, $fe80 ; $7219
	add hl, de ; $721c
	jr c, Label_08_7228 ; $721d
	ld hl, wCharPosX + 1 ; $721f
	ld a, [hl] ; $7222
	add a, c ; $7223
	ld [hl+], a ; $7224
	ld a, [hl] ; $7225
	adc a, b ; $7226
	ld [hl+], a ; $7227
Label_08_7228:
	ret ; $7228
Label_08_7229:
	ld a, [$df1f] ; $7229
	and a, PADF_RIGHT | PADF_LEFT ; $722c
	jr z, Label_08_7266 ; $722e
	swap a ; $7230
	add a, $86 ; $7232
	ld l, a ; $7234
	adc a, $72 ; $7235
	sub a, l ; $7237
	ld h, a ; $7238
	ld a, [hl] ; $7239
	cp a, $ff ; $723a
	jr z, Label_08_7266 ; $723c
	ld hl, $000a ; $723e
	call VectorFromLengthAndAngleRaw ; $7241
	ld c, l ; $7244
	ld b, h ; $7245
	ld hl, wCharPosX + 1 ; $7246
	ld a, [hl+] ; $7249
	ld h, [hl] ; $724a
	ld l, a ; $724b
	add hl, bc ; $724c
	bit 7, h ; $724d
	jr z, Label_08_7257 ; $724f
	xor a, a ; $7251
	sub a, l ; $7252
	ld l, a ; $7253
	sbc a, a ; $7254
	sub a, h ; $7255
	ld h, a ; $7256
Label_08_7257:
	ld de, $fe80 ; $7257
	add hl, de ; $725a
	jr c, Label_08_7266 ; $725b
	ld hl, wCharPosX + 1 ; $725d
	ld a, [hl] ; $7260
	add a, c ; $7261
	ld [hl+], a ; $7262
	ld a, [hl] ; $7263
	adc a, b ; $7264
	ld [hl+], a ; $7265
Label_08_7266:
	ret ; $7266
CheckSwingRelease:
	ld a, [$df1f] ; $7267
	and a, PADF_SELECT ; $726a
	jr z, Label_08_7280 ; $726c
	xor a, a ; $726e
	ld [$df4d], a ; $726f
	ld [$df4e], a ; $7272
	ld a, $01 ; $7275
	ret ; $7277
	ld a, b ; $7278
	ld [$df4d], a ; $7279
	xor a, a ; $727c
	ld [$df4e], a ; $727d
Label_08_7280:
	ld hl, $df4e ; $7280
	inc [hl] ; $7283
	xor a, a ; $7284
	ret ; $7285
	; $7286, 32 bytes (bytes:8)
	db $ff, $00, $80, $ff, $c0, $e0, $a0, $c0 ; 0x00
	db $40, $20, $60, $40, $ff, $00, $80, $ff ; 0x08
	db $10, $90, $90, $80, $80, $a0, $a0, $20 ; 0x10
	db $20, $60, $60, $40, $40, $50, $50, $10 ; 0x18
StepCharJumpPhysics:
	ld hl, wCharFlags ; $72a6
	bit 2, [hl] ; $72a9
	ret z ; $72ab
	ld hl, wCharVelHeight ; $72ac
	ld a, [hl+] ; $72af
	ld d, [hl] ; $72b0
	ld e, a ; $72b1
	ld hl, wCharPosHeight ; $72b2
	call AddDEToMem24 ; $72b5
	ld a, [wCharPosHeight + 2] ; $72b8
	bit 7, a ; $72bb
	jr z, Label_08_72cc ; $72bd
	ld hl, wCharVelHeight ; $72bf
	ld de, $0090 ; $72c2
	ld a, [hl] ; $72c5
	add a, e ; $72c6
	ld [hl+], a ; $72c7
	ld a, [hl] ; $72c8
	adc a, d ; $72c9
	ld [hl+], a ; $72ca
	ret ; $72cb
Label_08_72cc:
	xor a, a ; $72cc
	ld hl, wCharPosHeight ; $72cd
	ld [hl+], a ; $72d0
	ld [hl+], a ; $72d1
	ld [hl+], a ; $72d2
	ld hl, wCharVelHeight ; $72d3
	ld [hl+], a ; $72d6
	ld [hl+], a ; $72d7
	ld hl, wCharFlags ; $72d8
	res 2, [hl] ; $72db
	ret ; $72dd
StepCharMovement:
	ld hl, wCharVelX ; $72de
	ld a, [hl+] ; $72e1
	ld b, [hl] ; $72e2
	ld c, a ; $72e3
	ld hl, wCharVelDepth ; $72e4
	ld a, [hl+] ; $72e7
	ld d, [hl] ; $72e8
	ld e, a ; $72e9
	ld hl, wCharFlags ; $72ea
	bit 5, [hl] ; $72ed
	jr z, Label_08_7309 ; $72ef
	sra b ; $72f1
	rr c ; $72f3
	sra b ; $72f5
	rr c ; $72f7
	sra b ; $72f9
	rr c ; $72fb
	sra d ; $72fd
	rr e ; $72ff
	sra d ; $7301
	rr e ; $7303
	sra d ; $7305
	rr e ; $7307
Label_08_7309:
	ld hl, wCharFlags ; $7309
	res 6, [hl] ; $730c
	ld a, [$df1e] ; $730e
	cp a, $01 ; $7311
	jp z, Label_08_739f ; $7313
	push de ; $7316
	ld e, c ; $7317
	ld d, b ; $7318
	ld hl, wCharPosX ; $7319
	call AddDEToMem24IntoBC ; $731c
	ld hl, $fc60 ; $731f
	add hl, bc ; $7322
	bit 7, h ; $7323
	jr z, Label_08_7349 ; $7325
	ld hl, $03a0 ; $7327
	add hl, bc ; $732a
	bit 7, h ; $732b
	jr nz, Label_08_7349 ; $732d
	ld hl, $fdc0 ; $732f
	add hl, bc ; $7332
	bit 7, h ; $7333
	jr nz, Label_08_7350 ; $7335
	ld hl, wCharPosDepth + 1 ; $7337
	ld a, [hl+] ; $733a
	ld b, [hl] ; $733b
	ld c, a ; $733c
	bit 7, b ; $733d
	jr z, Label_08_7350 ; $733f
	ld hl, $02a0 ; $7341
	add hl, bc ; $7344
	bit 7, h ; $7345
	jr nz, Label_08_7350 ; $7347
Label_08_7349:
	ld hl, wCharFlags ; $7349
	set 6, [hl] ; $734c
	jr Label_08_7356 ; $734e
Label_08_7350:
	ld hl, wCharPosX ; $7350
	call AddDEToMem24 ; $7353
Label_08_7356:
	pop de ; $7356
	ld hl, wCharPosDepth ; $7357
	call AddDEToMem24IntoBC ; $735a
	bit 7, b ; $735d
	jr nz, Label_08_736f ; $735f
	ld hl, rWBK ; $7361
	add hl, bc ; $7364
	jr nc, Label_08_7391 ; $7365
	ld hl, $f920 ; $7367
	add hl, bc ; $736a
	jr c, Label_08_7391 ; $736b
	jr Label_08_7398 ; $736d
Label_08_736f:
	ld hl, $0100 ; $736f
	add hl, bc ; $7372
	jr c, Label_08_7391 ; $7373
	ld hl, $0700 ; $7375
	add hl, bc ; $7378
	jr nc, Label_08_7391 ; $7379
	ld hl, $02a0 ; $737b
	add hl, bc ; $737e
	bit 7, h ; $737f
	jr nz, Label_08_7398 ; $7381
	ld hl, wCharPosX + 1 ; $7383
	ld a, [hl+] ; $7386
	ld b, [hl] ; $7387
	ld c, a ; $7388
	ld hl, $fdc0 ; $7389
	add hl, bc ; $738c
	bit 7, h ; $738d
	jr nz, Label_08_7398 ; $738f
Label_08_7391:
	ld hl, wCharFlags ; $7391
	set 6, [hl] ; $7394
	jr Label_08_739e ; $7396
Label_08_7398:
	ld hl, wCharPosDepth ; $7398
	call AddDEToMem24 ; $739b
Label_08_739e:
	ret ; $739e
Label_08_739f:
	ld hl, wCharPosX ; $739f
	call AddBCToMem24 ; $73a2
	ld hl, wCharPosDepth ; $73a5
	call AddDEToMem24IntoBC ; $73a8
	bit 7, b ; $73ab
	jr nz, Label_08_73b7 ; $73ad
	ld hl, rWBK ; $73af
	add hl, bc ; $73b2
	jr nc, Label_08_73c4 ; $73b3
	jr Label_08_73bd ; $73b5
Label_08_73b7:
	ld hl, $0100 ; $73b7
	add hl, bc ; $73ba
	jr c, Label_08_73c4 ; $73bb
Label_08_73bd:
	ld hl, wCharPosDepth ; $73bd
	call AddDEToMem24 ; $73c0
	ret ; $73c3
Label_08_73c4:
	ld hl, wCharFlags ; $73c4
	set 6, [hl] ; $73c7
	ret ; $73c9
UpdateCharVelocityFromInput:
	ld a, [$df56] ; $73ca
	and a, a ; $73cd
	ret nz ; $73ce
	ld hl, wCharFlags ; $73cf
	bit 1, [hl] ; $73d2
	jp nz, Label_08_73de ; $73d4
	bit 0, [hl] ; $73d7
	jp nz, Label_08_73de ; $73d9
	jr Label_08_73e5 ; $73dc
Label_08_73de:
	ld hl, $df50 ; $73de
	res 6, [hl] ; $73e1
	res 7, [hl] ; $73e3
Label_08_73e5:
	ld hl, $df50 ; $73e5
	bit 6, [hl] ; $73e8
	jr z, Label_08_73f1 ; $73ea
	call AccelerateCharX ; $73ec
	jr Label_08_73f4 ; $73ef
Label_08_73f1:
	call DecelerateCharX ; $73f1
Label_08_73f4:
	ld hl, $df50 ; $73f4
	bit 7, [hl] ; $73f7
	jr z, Label_08_7400 ; $73f9
	call AccelerateCharDepth ; $73fb
	jr Label_08_7403 ; $73fe
Label_08_7400:
	call DecelerateCharDepth ; $7400
Label_08_7403:
	ld hl, $df50 ; $7403
	bit 6, [hl] ; $7406
	jr z, Label_08_740d ; $7408
	call ClampCharXSpeed ; $740a
Label_08_740d:
	ld hl, $df50 ; $740d
	bit 7, [hl] ; $7410
	jr z, Label_08_7417 ; $7412
	call ClampCharDepthSpeed ; $7414
Label_08_7417:
	ld hl, $df50 ; $7417
	res 6, [hl] ; $741a
	res 7, [hl] ; $741c
	ld hl, wCharFlags ; $741e
	set 4, [hl] ; $7421
	ld hl, wCharVelX ; $7423
	ld a, [hl+] ; $7426
	or a, [hl] ; $7427
	inc hl ; $7428
	or a, [hl] ; $7429
	inc hl ; $742a
	or a, [hl] ; $742b
	jr nz, Label_08_7440 ; $742c
	ld hl, wCharFlags ; $742e
	res 4, [hl] ; $7431
	ld a, [$df1f] ; $7433
	and a, $f0 ; $7436
	jr nz, Label_08_7440 ; $7438
	ld a, [$df0c] ; $743a
	ld [wCharFacingDesired], a ; $743d
Label_08_7440:
	ret ; $7440
AccelerateCharDepth:
	ld hl, $df64 ; $7441
	ld a, [hl+] ; $7444
	ld h, [hl] ; $7445
	ld l, a ; $7446
	ld a, [wCharFacingDesired] ; $7447
	call MulHLBySin ; $744a
	add hl, hl ; $744d
	add hl, hl ; $744e
	ld e, l ; $744f
	ld d, h ; $7450
	ld hl, wCharVelDepth ; $7451
	ld a, [hl] ; $7454
	add a, e ; $7455
	ld [hl+], a ; $7456
	ld a, [hl] ; $7457
	adc a, d ; $7458
	ld [hl+], a ; $7459
	ret ; $745a
AccelerateCharX:
	ld hl, $df64 ; $745b
	ld a, [hl+] ; $745e
	ld h, [hl] ; $745f
	ld l, a ; $7460
	ld a, [wCharFacingDesired] ; $7461
	call MulHLByCos ; $7464
	add hl, hl ; $7467
	add hl, hl ; $7468
	ld e, l ; $7469
	ld d, h ; $746a
	ld hl, wCharVelX ; $746b
	ld a, [hl] ; $746e
	add a, e ; $746f
	ld [hl+], a ; $7470
	ld a, [hl] ; $7471
	adc a, d ; $7472
	ld [hl+], a ; $7473
	ret ; $7474
DecelerateCharDepth:
	ld hl, wCharVelDepth ; $7475
	ld a, [hl+] ; $7478
	ld d, [hl] ; $7479
	ld e, a ; $747a
	ld a, d ; $747b
	or a, e ; $747c
	ret z ; $747d
	ld hl, $df66 ; $747e
	ld a, [hl+] ; $7481
	ld h, [hl] ; $7482
	ld l, a ; $7483
	bit 7, d ; $7484
	jr nz, Label_08_748e ; $7486
	xor a, a ; $7488
	sub a, l ; $7489
	ld l, a ; $748a
	sbc a, a ; $748b
	sub a, h ; $748c
	ld h, a ; $748d
Label_08_748e:
	add hl, de ; $748e
	ld a, d ; $748f
	xor a, h ; $7490
	bit 7, a ; $7491
	jr z, Label_08_7498 ; $7493
	ld hl, $0000 ; $7495
Label_08_7498:
	ld a, l ; $7498
	ld [wCharVelDepth], a ; $7499
	ld a, h ; $749c
	ld [wCharVelDepth + 1], a ; $749d
	ret ; $74a0
DecelerateCharX:
	ld hl, wCharVelX ; $74a1
	ld a, [hl+] ; $74a4
	ld d, [hl] ; $74a5
	ld e, a ; $74a6
	ld a, d ; $74a7
	or a, e ; $74a8
	ret z ; $74a9
	ld hl, $df66 ; $74aa
	ld a, [hl+] ; $74ad
	ld h, [hl] ; $74ae
	ld l, a ; $74af
	ld a, [wCharFlags] ; $74b0
	bit 1, a ; $74b3
	jr z, Label_08_74ba ; $74b5
	ld hl, $0040 ; $74b7
Label_08_74ba:
	bit 7, d ; $74ba
	jr nz, Label_08_74c4 ; $74bc
	xor a, a ; $74be
	sub a, l ; $74bf
	ld l, a ; $74c0
	sbc a, a ; $74c1
	sub a, h ; $74c2
	ld h, a ; $74c3
Label_08_74c4:
	add hl, de ; $74c4
	ld a, d ; $74c5
	xor a, h ; $74c6
	bit 7, a ; $74c7
	jr z, Label_08_74ce ; $74c9
	ld hl, $0000 ; $74cb
Label_08_74ce:
	ld a, l ; $74ce
	ld [wCharVelX], a ; $74cf
	ld a, h ; $74d2
	ld [wCharVelX + 1], a ; $74d3
	ret ; $74d6
ClampCharDepthSpeed:
	ld hl, $df62 ; $74d7
	ld a, [hl+] ; $74da
	ld h, [hl] ; $74db
	ld l, a ; $74dc
	ld a, [wCharFacingDesired] ; $74dd
	call MulHLBySinSigned ; $74e0
	ld c, l ; $74e3
	ld b, h ; $74e4
	ld e, l ; $74e5
	ld d, h ; $74e6
	ld hl, wCharVelDepth ; $74e7
	ld a, [hl+] ; $74ea
	ld h, [hl] ; $74eb
	ld l, a ; $74ec
	bit 7, h ; $74ed
	jr z, Label_08_74fd ; $74ef
	xor a, a ; $74f1
	sub a, l ; $74f2
	ld l, a ; $74f3
	sbc a, a ; $74f4
	sub a, h ; $74f5
	ld h, a ; $74f6
	xor a, a ; $74f7
	sub a, c ; $74f8
	ld c, a ; $74f9
	sbc a, a ; $74fa
	sub a, b ; $74fb
	ld b, a ; $74fc
Label_08_74fd:
	ld a, c ; $74fd
	sub a, l ; $74fe
	ld c, a ; $74ff
	ld a, b ; $7500
	sbc a, h ; $7501
	ld b, a ; $7502
	jr nc, Label_08_750b ; $7503
	ld hl, wCharVelDepth ; $7505
	ld a, e ; $7508
	ld [hl+], a ; $7509
	ld [hl], d ; $750a
Label_08_750b:
	ret ; $750b
ClampCharXSpeed:
	ld hl, $df60 ; $750c
	ld a, [hl+] ; $750f
	ld h, [hl] ; $7510
	ld l, a ; $7511
	ld a, [wCharFacingDesired] ; $7512
	call MulHLByCosSigned ; $7515
	ld c, l ; $7518
	ld b, h ; $7519
	ld e, l ; $751a
	ld d, h ; $751b
	ld hl, wCharVelX ; $751c
	ld a, [hl+] ; $751f
	ld h, [hl] ; $7520
	ld l, a ; $7521
	bit 7, h ; $7522
	jr z, Label_08_7532 ; $7524
	xor a, a ; $7526
	sub a, l ; $7527
	ld l, a ; $7528
	sbc a, a ; $7529
	sub a, h ; $752a
	ld h, a ; $752b
	xor a, a ; $752c
	sub a, c ; $752d
	ld c, a ; $752e
	sbc a, a ; $752f
	sub a, b ; $7530
	ld b, a ; $7531
Label_08_7532:
	ld a, c ; $7532
	sub a, l ; $7533
	ld c, a ; $7534
	ld a, b ; $7535
	sbc a, h ; $7536
	ld b, a ; $7537
	jr nc, Label_08_7540 ; $7538
	ld hl, wCharVelX ; $753a
	ld a, e ; $753d
	ld [hl+], a ; $753e
	ld [hl], d ; $753f
Label_08_7540:
	ret ; $7540
MoveCharTowardTarget:
	call CheckCharNearTarget ; $7541
	and a, a ; $7544
	jp nz, Label_08_7599 ; $7545
	ld hl, wCharPosX + 1 ; $7548
	ld a, [hl+] ; $754b
	ld b, [hl] ; $754c
	ld c, a ; $754d
	ld hl, wCharWalkTargetX ; $754e
	ld a, [hl+] ; $7551
	ld d, [hl] ; $7552
	ld e, a ; $7553
	ld a, e ; $7554
	sub a, c ; $7555
	ld e, a ; $7556
	ld a, d ; $7557
	sbc a, b ; $7558
	ld d, a ; $7559
	ld hl, wCharPosDepth + 1 ; $755a
	ld a, [hl+] ; $755d
	ld b, [hl] ; $755e
	ld c, a ; $755f
	ld hl, wCharWalkTargetDepth ; $7560
	ld a, [hl+] ; $7563
	ld h, [hl] ; $7564
	ld l, a ; $7565
	ld a, l ; $7566
	sub a, c ; $7567
	ld l, a ; $7568
	ld a, h ; $7569
	sbc a, b ; $756a
	ld h, a ; $756b
	call AngleFromVectorCoarse ; $756c
	ld [wCharFacingDesired], a ; $756f
	ld a, [wCharFacingDesired] ; $7572
	ld b, a ; $7575
	ld c, $00 ; $7576
	ld hl, $1000 ; $7578
	call MulSinCos ; $757b
	ld c, l ; $757e
	ld b, h ; $757f
	ld hl, wCharPosX ; $7580
	call AddBCToMem24 ; $7583
	ld hl, wCharPosDepth ; $7586
	call AddDEToMem24 ; $7589
	ld hl, wCharFlags ; $758c
	set 4, [hl] ; $758f
	ld a, $01 ; $7591
	ld [$df56], a ; $7593
	ld a, $01 ; $7596
	ret ; $7598
Label_08_7599:
	ld hl, wCharWalkTargetX ; $7599
	ld a, [hl+] ; $759c
	ld b, [hl] ; $759d
	ld c, a ; $759e
	ld hl, wCharPosX + 1 ; $759f
	ld a, c ; $75a2
	ld [hl+], a ; $75a3
	ld [hl], b ; $75a4
	ld hl, wCharWalkTargetDepth ; $75a5
	ld a, [hl+] ; $75a8
	ld b, [hl] ; $75a9
	ld c, a ; $75aa
	ld hl, wCharPosDepth + 1 ; $75ab
	ld a, c ; $75ae
	ld [hl+], a ; $75af
	ld [hl], b ; $75b0
	xor a, a ; $75b1
	ld hl, wCharVelX ; $75b2
	ld [hl+], a ; $75b5
	ld [hl+], a ; $75b6
	ld [hl+], a ; $75b7
	ld [hl+], a ; $75b8
	ld hl, wCharFlags ; $75b9
	res 4, [hl] ; $75bc
	xor a, a ; $75be
	ret ; $75bf
EaseCharFacing:
	ld hl, wCharFlags ; $75c0
	bit 1, [hl] ; $75c3
	ret nz ; $75c5
	ld a, [wCharFacingEaseRate] ; $75c6
	ld b, a ; $75c9
	ld a, [wCharFacingDesired] ; $75ca
	ld hl, wCharFacingShown ; $75cd
	sub a, [hl] ; $75d0
	ret z ; $75d1
	bit 7, a ; $75d2
	jr nz, Label_08_75dd ; $75d4
	cp a, b ; $75d6
	jr c, Label_08_75da ; $75d7
	ld a, b ; $75d9
Label_08_75da:
	add a, [hl] ; $75da
	ld [hl], a ; $75db
	ret ; $75dc
Label_08_75dd:
	cpl ; $75dd
	inc a ; $75de
	cp a, b ; $75df
	jr c, Label_08_75e3 ; $75e0
	ld a, b ; $75e2
Label_08_75e3:
	cpl ; $75e3
	inc a ; $75e4
	add a, [hl] ; $75e5
	ld [hl], a ; $75e6
	ret ; $75e7
UpdateCharFacingOctant:
	ld a, [$df2e] ; $75e8
	cp a, $02 ; $75eb
	jr z, Label_08_7608 ; $75ed
	cp a, $01 ; $75ef
	jr z, Label_08_7608 ; $75f1
	cp a, $12 ; $75f3
	jr z, Label_08_75fc ; $75f5
	ld a, [$df0c] ; $75f7
	jr Label_08_760d ; $75fa
Label_08_75fc:
	ld a, [wCharFacingShown] ; $75fc
	ld hl, $df0c ; $75ff
	sub a, [hl] ; $7602
	sra a ; $7603
	add a, [hl] ; $7605
	jr Label_08_760d ; $7606
Label_08_7608:
	ld a, [wCharFacingShown] ; $7608
	add a, $10 ; $760b
Label_08_760d:
	rlca ; $760d
	rlca ; $760e
	rlca ; $760f
	and a, $07 ; $7610
	ld d, a ; $7612
	ld hl, $df32 ; $7613
	ld a, [hl] ; $7616
	cp a, d ; $7617
	jr z, Label_08_7620 ; $7618
	ld [hl], d ; $761a
	ld hl, $df30 ; $761b
	set 6, [hl] ; $761e
Label_08_7620:
	ret ; $7620
ReloadCharFacingTiles:
	ld hl, $df30 ; $7621
	bit 6, [hl] ; $7624
	ret z ; $7626
	res 6, [hl] ; $7627
	ld a, d ; $7629
	add a, $43 ; $762a
	ld l, a ; $762c
	adc a, $76 ; $762d
	sub a, l ; $762f
	ld h, a ; $7630
	ld d, [hl] ; $7631
	ld a, [$df33] ; $7632
	ld e, a ; $7635
	add a, a ; $7636
	add a, a ; $7637
	add a, e ; $7638
	add a, d ; $7639
	ld h, $00 ; $763a
	ld l, a ; $763c
	add hl, hl ; $763d
	ld e, l ; $763e
	ld d, h ; $763f
	jp Label_00_2e6b ; $7640
	; $7643, 8 bytes (bytes:8)
	db $02, $03, $04, $03, $02, $01, $00, $01 ; 0x00
UpdateChargeFlash:
	ld a, [$df51] ; $764b
	and a, a ; $764e
	ret z ; $764f
	ld a, [$df4b] ; $7650
	cp a, $14 ; $7653
	ret c ; $7655
	and a, $04 ; $7656
	jr z, EndChargeFlash ; $7658
	ld hl, $df52 ; $765a
	ld a, [hl] ; $765d
	and a, a ; $765e
	ret nz ; $765f
	ld [hl], $01 ; $7660
	call LoadCharChargeFlashGfx ; $7662
	ret ; $7665
EndChargeFlash:
	ld hl, $df52 ; $7666
	ld a, [hl] ; $7669
	and a, a ; $766a
	ret z ; $766b
	ld [hl], $00 ; $766c
	call ReloadCharFrameGfx ; $766e
	ret ; $7671
BuildCharSpriteSlots:
	ld hl, wCharPosHeight + 1 ; $7672
	ld a, [hl+] ; $7675
	ld b, [hl] ; $7676
	ld c, a ; $7677
	ld hl, wCharPosDepth + 1 ; $7678
	ld a, [hl+] ; $767b
	ld d, [hl] ; $767c
	ld e, a ; $767d
	ld hl, wCharPosX + 1 ; $767e
	ld a, [hl+] ; $7681
	ld h, [hl] ; $7682
	ld l, a ; $7683
	call ProjectWorldToScreen_08 ; $7684
	call ApplyCameraProjection ; $7687
	ld a, d ; $768a
	ld [wCharScreenX], a ; $768b
	ld a, e ; $768e
	ld [wCharScreenY], a ; $768f
	ld a, d ; $7692
	add a, $08 ; $7693
	cp a, $b0 ; $7695
	jr nc, DrawOffscreenCharArrow ; $7697
	ld a, e ; $7699
	cp a, $a0 ; $769a
	jr nc, DrawOffscreenCharArrow ; $769c
	ld hl, wCharPosDepth + 1 ; $769e
	ld a, [hl+] ; $76a1
	ld h, [hl] ; $76a2
	ld l, a ; $76a3
	add hl, hl ; $76a4
	add hl, hl ; $76a5
	add hl, hl ; $76a6
	ld a, h ; $76a7
	add a, $80 ; $76a8
	ld [wCharDepthKey], a ; $76aa
	ld a, [$df32] ; $76ad
	add a, $fc ; $76b0
	ld l, a ; $76b2
	adc a, $76 ; $76b3
	sub a, l ; $76b5
	ld h, a ; $76b6
	ld a, [$df37] ; $76b7
	or a, $08 ; $76ba
	xor a, [hl] ; $76bc
	ld b, a ; $76bd
	ld a, [$df36] ; $76be
	ld c, a ; $76c1
	ld a, [$df32] ; $76c2
	cp a, $02 ; $76c5
	jr z, Label_08_76cf ; $76c7
	cp a, $06 ; $76c9
	jr z, Label_08_76cf ; $76cb
	jr Label_08_76d4 ; $76cd
Label_08_76cf:
	ld a, [$df94] ; $76cf
	xor a, b ; $76d2
	ld b, a ; $76d3
Label_08_76d4:
	ld hl, wCharSpriteSlot ; $76d4
	ld a, c ; $76d7
	ld [hl+], a ; $76d8
	ld a, b ; $76d9
	ld [hl+], a ; $76da
	ld a, e ; $76db
	ld [hl+], a ; $76dc
	ld [hl], d ; $76dd
	ld a, [wStandingShadowsEnabled] ; $76de
	and a, a ; $76e1
	ret z ; $76e2
	ld hl, wCharFlags ; $76e3
	bit 2, [hl] ; $76e6
	ret nz ; $76e8
	ldh a, [$ffe9] ; $76e9
	and a, $01 ; $76eb
	ret z ; $76ed
	ld hl, wCharGroundShadowSlot ; $76ee
	ld bc, $0858 ; $76f1
	ld a, c ; $76f4
	ld [hl+], a ; $76f5
	ld a, b ; $76f6
	ld [hl+], a ; $76f7
	ld a, e ; $76f8
	ld [hl+], a ; $76f9
	ld [hl], d ; $76fa
	ret ; $76fb
	; $76fc, 8 bytes (bytes:8)
	db $00, $00, $00, $20, $20, $20, $00, $00 ; 0x00
DrawOffscreenCharArrow:
	ld a, [wOffscreenArrowsEnabled] ; $7704
	and a, a ; $7707
	ret z ; $7708
	ldh a, [$ffe9] ; $7709
	and a, $01 ; $770b
	ret z ; $770d
	ld a, d ; $770e
	add a, $f8 ; $770f
	cp a, $90 ; $7711
	jr c, Label_08_7720 ; $7713
	ld a, [wCharPosX + 2] ; $7715
	bit 7, a ; $7718
	ld d, $08 ; $771a
	jr nz, Label_08_7720 ; $771c
	ld d, $98 ; $771e
Label_08_7720:
	ld a, e ; $7720
	add a, $f0 ; $7721
	cp a, $80 ; $7723
	jr c, Label_08_7732 ; $7725
	ld a, [wCharPosDepth + 2] ; $7727
	bit 7, a ; $772a
	ld e, $10 ; $772c
	jr nz, Label_08_7732 ; $772e
	ld e, $90 ; $7730
Label_08_7732:
	ld a, [$df37] ; $7732
	ld b, a ; $7735
	res 5, b ; $7736
	ld a, [wCharIndex] ; $7738
	add a, a ; $773b
	add a, a ; $773c
	add a, a ; $773d
	add a, $00 ; $773e
	ld c, a ; $7740
	call QueueSprite16 ; $7741
	ret ; $7744
BuildAirborneShadowSlot:
	ld hl, wCharFlags ; $7745
	bit 2, [hl] ; $7748
	ret z ; $774a
	ld bc, $0000 ; $774b
	ld hl, wCharPosDepth + 1 ; $774e
	ld a, [hl+] ; $7751
	ld d, [hl] ; $7752
	ld e, a ; $7753
	ld hl, wCharPosX + 1 ; $7754
	ld a, [hl+] ; $7757
	ld h, [hl] ; $7758
	ld l, a ; $7759
	call ProjectWorldToScreen_08 ; $775a
	call ApplyCameraProjection ; $775d
	ld hl, wCharPosHeight + 1 ; $7760
	ld a, [hl+] ; $7763
	ld h, [hl] ; $7764
	ld l, a ; $7765
	bit 7, h ; $7766
	jr z, Label_08_7770 ; $7768
	xor a, a ; $776a
	sub a, l ; $776b
	ld l, a ; $776c
	sbc a, a ; $776d
	sub a, h ; $776e
	ld h, a ; $776f
Label_08_7770:
	ld bc, $ffe0 ; $7770
	xor a, a ; $7773
	add hl, bc ; $7774
	jr nc, Label_08_7780 ; $7775
	inc a ; $7777
	add hl, bc ; $7778
	jr nc, Label_08_7780 ; $7779
	inc a ; $777b
	add hl, bc ; $777c
	jr nc, Label_08_7780 ; $777d
	inc a ; $777f
Label_08_7780:
	ld bc, $0850 ; $7780
	add a, a ; $7783
	add a, c ; $7784
	ld c, a ; $7785
	ld hl, wCharAirShadowSlot ; $7786
	ld a, c ; $7789
	ld [hl+], a ; $778a
	ld a, b ; $778b
	ld [hl+], a ; $778c
	ld a, e ; $778d
	ld [hl+], a ; $778e
	ld [hl], d ; $778f
	ret ; $7790
StepCharAnimation:
	ld a, [$df2f] ; $7791
	and a, a ; $7794
	jr nz, Label_08_77f6 ; $7795
Label_08_7797:
	ld hl, $df2c ; $7797
	ld a, [hl+] ; $779a
	ld h, [hl] ; $779b
	ld l, a ; $779c
	ld a, [wCharActive] ; $779d
	call FarReadWordDI ; $77a0
	ld e, c ; $77a3
	ld d, b ; $77a4
	ld a, e ; $77a5
	cp a, $f0 ; $77a6
	jr c, Label_08_77e6 ; $77a8
	cp a, $ff ; $77aa
	jr z, Label_08_77bd ; $77ac
	cp a, $fe ; $77ae
	jr z, Label_08_77cd ; $77b0
	cp a, $fb ; $77b2
	jr z, Label_08_77d2 ; $77b4
	ld a, $ff ; $77b6
	ld [$df2f], a ; $77b8
	jr Label_08_77f6 ; $77bb
Label_08_77bd:
	ld hl, $df2a ; $77bd
	ld a, [hl+] ; $77c0
	add a, d ; $77c1
	ld [$df2c], a ; $77c2
	ld a, [hl+] ; $77c5
	adc a, $00 ; $77c6
	ld [$df2d], a ; $77c8
	jr Label_08_7797 ; $77cb
Label_08_77cd:
	call SetCharAnimation ; $77cd
	jr Label_08_7797 ; $77d0
Label_08_77d2:
	ld hl, $df37 ; $77d2
	ld a, [hl] ; $77d5
	and a, $0f ; $77d6
	xor a, d ; $77d8
	ld [hl], a ; $77d9
	ld hl, $df2c ; $77da
	ld a, [hl] ; $77dd
	add a, $02 ; $77de
	ld [hl+], a ; $77e0
	jr nc, Label_08_7797 ; $77e1
	inc [hl] ; $77e3
	jr Label_08_7797 ; $77e4
Label_08_77e6:
	ld a, d ; $77e6
	ld [$df2f], a ; $77e7
	ld hl, $df2c ; $77ea
	ld a, [hl] ; $77ed
	add a, $02 ; $77ee
	ld [hl+], a ; $77f0
	jr nc, Label_08_77fa ; $77f1
	inc [hl] ; $77f3
	jr Label_08_77fa ; $77f4
Label_08_77f6:
	ld a, [$df33] ; $77f6
	ld e, a ; $77f9
Label_08_77fa:
	ld hl, $df2f ; $77fa
	dec [hl] ; $77fd
	ld hl, $df33 ; $77fe
	ld a, [hl] ; $7801
	cp a, e ; $7802
	jr z, Label_08_780b ; $7803
	ld [hl], e ; $7805
	ld hl, $df30 ; $7806
	set 6, [hl] ; $7809
Label_08_780b:
	ret ; $780b
ReadCharInput:
	xor a, a ; $780c
	ld [$df1f], a ; $780d
	ld a, [$df1e] ; $7810
	add a, a ; $7813
	add a, $1f ; $7814
	ld l, a ; $7816
	adc a, $78 ; $7817
	sub a, l ; $7819
	ld h, a ; $781a
	ld a, [hl+] ; $781b
	ld h, [hl] ; $781c
	ld l, a ; $781d
	jp hl ; $781e
	; $781f, 14 bytes (records:2)
	dw ReadCharPadInput ; record 0
	dw $7863 ; record 1
	dw ReadCharPadInput ; record 2
	dw ReadCharPadInput ; record 3
	dw $782d ; record 4
	dw $7833 ; record 5
	dw $783f ; record 6
	ldh a, [hLinkInput] ; $782d
	ld [$df1f], a ; $782f
	ret ; $7832
	ldh a, [hLinkState] ; $7833
	cp a, $02 ; $7835
	jr z, Label_08_784f ; $7837
	cp a, $01 ; $7839
	jr z, Label_08_784b ; $783b
	jr ReadCharPadInput ; $783d
	ldh a, [hLinkState] ; $783f
	cp a, $02 ; $7841
	jr z, Label_08_784b ; $7843
	cp a, $01 ; $7845
	jr z, Label_08_784f ; $7847
	jr ReadCharPadInput ; $7849
Label_08_784b:
	ldh a, [hLinkRemoteInputBuf] ; $784b
	jr Label_08_7851 ; $784d
Label_08_784f:
	ldh a, [hLinkRemoteInput] ; $784f
Label_08_7851:
	ld [$df1f], a ; $7851
	ret ; $7854
ReadCharPadInput:
	ldh a, [hPlayerInputFlags] ; $7855
	and a, $f0 ; $7857
	ld c, a ; $7859
	ldh a, [hInputRisingEdge] ; $785a
	and a, $0f ; $785c
	or a, c ; $785e
	ld [$df1f], a ; $785f
	ret ; $7862
	ld hl, $df12 ; $7863
	ld a, [hl] ; $7866
	and a, a ; $7867
	jr z, Label_08_786c ; $7868
	dec [hl] ; $786a
	ret ; $786b
Label_08_786c:
	ld hl, $df13 ; $786c
	ld a, [hl] ; $786f
	and a, a ; $7870
	jr z, Label_08_7874 ; $7871
	dec [hl] ; $7873
Label_08_7874:
	ld a, [wMatchIsDoubles] ; $7874
	and a, a ; $7877
	jr z, Label_08_78aa ; $7878
	ld a, [wCharServeRole] ; $787a
	and a, $02 ; $787d
	jp z, Label_08_7896 ; $787f
	ld a, [wCharState] ; $7882
	rst Rst00 ; $7885
	dw Label_08_796c ; $7886 jumptable
	dw AiRallyStateNetPlayer ; $7888 jumptable
	dw AiRecoverStateNetPlayer ; $788a jumptable
	dw AiServeState ; $788c jumptable
	dw Label_08_796c ; $788e jumptable
	dw Label_08_796c ; $7890 jumptable
	dw Label_08_796c ; $7892 jumptable
	dw Label_08_796c ; $7894 jumptable
Label_08_7896:
	ld a, [wCharState] ; $7896
	rst Rst00 ; $7899
	dw Label_08_796c ; $789a jumptable
	dw AiRallyStateBaseliner ; $789c jumptable
	dw AiRecoverStateBaseliner ; $789e jumptable
	dw AiServeState ; $78a0 jumptable
	dw Label_08_796c ; $78a2 jumptable
	dw Label_08_796c ; $78a4 jumptable
	dw Label_08_796c ; $78a6 jumptable
	dw Label_08_796c ; $78a8 jumptable
Label_08_78aa:
	ld a, [wCharState] ; $78aa
	rst Rst00 ; $78ad
	dw Label_08_796c ; $78ae jumptable
	dw AiRallyStateSingles ; $78b0 jumptable
	dw AiRecoverStateSingles ; $78b2 jumptable
	dw AiServeState ; $78b4 jumptable
	dw Label_08_796c ; $78b6 jumptable
	dw Label_08_796c ; $78b8 jumptable
	dw Label_08_796c ; $78ba jumptable
	dw Label_08_796c ; $78bc jumptable
CheckCharNearTarget:
	ld hl, wCharPosX + 1 ; $78be
	ld a, [hl+] ; $78c1
	ld b, [hl] ; $78c2
	ld c, a ; $78c3
	ld hl, wCharWalkTargetX ; $78c4
	ld a, [hl+] ; $78c7
	ld h, [hl] ; $78c8
	ld l, a ; $78c9
	ld a, l ; $78ca
	sub a, c ; $78cb
	ld l, a ; $78cc
	ld a, h ; $78cd
	sbc a, b ; $78ce
	ld h, a ; $78cf
	bit 7, h ; $78d0
	jr z, Label_08_78da ; $78d2
	xor a, a ; $78d4
	sub a, l ; $78d5
	ld l, a ; $78d6
	sbc a, a ; $78d7
	sub a, h ; $78d8
	ld h, a ; $78d9
Label_08_78da:
	ld de, $ffe8 ; $78da
	add hl, de ; $78dd
	jr c, Label_08_7906 ; $78de
	ld hl, wCharPosDepth + 1 ; $78e0
	ld a, [hl+] ; $78e3
	ld b, [hl] ; $78e4
	ld c, a ; $78e5
	ld hl, wCharWalkTargetDepth ; $78e6
	ld a, [hl+] ; $78e9
	ld h, [hl] ; $78ea
	ld l, a ; $78eb
	ld a, l ; $78ec
	sub a, c ; $78ed
	ld l, a ; $78ee
	ld a, h ; $78ef
	sbc a, b ; $78f0
	ld h, a ; $78f1
	bit 7, h ; $78f2
	jr z, Label_08_78fc ; $78f4
	xor a, a ; $78f6
	sub a, l ; $78f7
	ld l, a ; $78f8
	sbc a, a ; $78f9
	sub a, h ; $78fa
	ld h, a ; $78fb
Label_08_78fc:
	ld de, $ffe8 ; $78fc
	add hl, de ; $78ff
	jr c, Label_08_7906 ; $7900
	ld a, $01 ; $7902
	and a, a ; $7904
	ret ; $7905
Label_08_7906:
	xor a, a ; $7906
	ret ; $7907
AiSteerTowardTarget:
	ld hl, wCharPosX + 1 ; $7908
	ld a, [hl+] ; $790b
	ld b, [hl] ; $790c
	ld c, a ; $790d
	ld hl, wCharWalkTargetX ; $790e
	ld a, [hl+] ; $7911
	ld d, [hl] ; $7912
	ld e, a ; $7913
	ld a, e ; $7914
	sub a, c ; $7915
	ld e, a ; $7916
	ld a, d ; $7917
	sbc a, b ; $7918
	ld d, a ; $7919
	ld hl, wCharPosDepth + 1 ; $791a
	ld a, [hl+] ; $791d
	ld b, [hl] ; $791e
	ld c, a ; $791f
	ld hl, wCharWalkTargetDepth ; $7920
	ld a, [hl+] ; $7923
	ld h, [hl] ; $7924
	ld l, a ; $7925
	ld a, l ; $7926
	sub a, c ; $7927
	ld l, a ; $7928
	ld a, h ; $7929
	sbc a, b ; $792a
	ld h, a ; $792b
	call AngleFromVectorCoarse ; $792c
	swap a ; $792f
	and a, $0f ; $7931
	add a, $96 ; $7933
	ld l, a ; $7935
	adc a, $72 ; $7936
	sub a, l ; $7938
	ld h, a ; $7939
	ld a, [$df1f] ; $793a
	and a, $0f ; $793d
	or a, [hl] ; $793f
	ld [$df1f], a ; $7940
	ret ; $7943
AiSteerTowardBall:
	ld hl, wBallRelCharX ; $7944
	ld a, [hl+] ; $7947
	ld d, [hl] ; $7948
	ld e, a ; $7949
	ld hl, wBallRelCharDepth ; $794a
	ld a, [hl+] ; $794d
	ld h, [hl] ; $794e
	ld l, a ; $794f
	call AngleFromVectorCoarse ; $7950
	swap a ; $7953
	and a, $0f ; $7955
	add a, $96 ; $7957
	ld l, a ; $7959
	adc a, $72 ; $795a
	sub a, l ; $795c
	ld h, a ; $795d
	ld a, [$df1f] ; $795e
	and a, $0f ; $7961
	or a, [hl] ; $7963
	ld [$df1f], a ; $7964
	ret ; $7967
AiAdvancePhase:
	ld hl, $df1a ; $7968
	inc [hl] ; $796b
Label_08_796c:
	ret ; $796c
AiRushToBallLanding:
	ld hl, $fea0 ; $796d
	call OffsetFromBallLanding ; $7970
	bit 7, d ; $7973
	jr z, Label_08_797d ; $7975
	xor a, a ; $7977
	sub a, e ; $7978
	ld e, a ; $7979
	sbc a, a ; $797a
	sub a, d ; $797b
	ld d, a ; $797c
Label_08_797d:
	push hl ; $797d
	ld l, e ; $797e
	ld h, d ; $797f
	ld bc, rJOYP ; $7980
	add hl, bc ; $7983
	bit 7, h ; $7984
	jr z, Label_08_798b ; $7986
	ld de, $0100 ; $7988
Label_08_798b:
	pop hl ; $798b
	call SetCharTargetMirrored ; $798c
	jp AiAdvancePhase ; $798f
AiMoveBehindBallLanding:
	ld hl, $00c0 ; $7992
	call OffsetFromBallLanding ; $7995
	call SetCharTarget ; $7998
	jp AiAdvancePhase ; $799b
AiInterceptAtMidCourt:
	ld de, $0200 ; $799e
	call MirrorDepthForFarSide ; $79a1
	call PredictBallXAtDepth ; $79a4
	ld de, $0200 ; $79a7
	call SetCharTargetMirrored ; $79aa
	jp AiAdvancePhase ; $79ad
AiInterceptNearNet:
	ld de, $0100 ; $79b0
	call MirrorDepthForFarSide ; $79b3
	call PredictBallXAtDepth ; $79b6
	ld de, $0100 ; $79b9
	call SetCharTargetMirrored ; $79bc
	jp AiAdvancePhase ; $79bf
AiMoveLaterallyToBallLine:
	ld hl, wCharPosDepth + 1 ; $79c2
	ld a, [hl+] ; $79c5
	ld d, [hl] ; $79c6
	ld e, a ; $79c7
	push de ; $79c8
	call PredictBallXAtDepth ; $79c9
	pop de ; $79cc
	call SetCharTarget ; $79cd
	jp AiAdvancePhase ; $79d0
Label_08_79d3:
	call SetCharTargetMirrored ; $79d3
	jp AiAdvancePhase ; $79d6
AiIsIncomingDropOrLobShot:
	ld a, [wCurrentShotType] ; $79d9
	cp a, SHOTTYPE_DROP ; $79dc
	jr z, Label_08_79ef ; $79de
AiIsIncomingLobShot:
	ld a, [wCurrentShotType] ; $79e0
	cp a, SHOTTYPE_LOB ; $79e3
	jr z, Label_08_79ef ; $79e5
	ld a, [wFallbackTrajectoryFlag] ; $79e7
	and a, a ; $79ea
	jr nz, Label_08_79ef ; $79eb
	xor a, a ; $79ed
	ret ; $79ee
Label_08_79ef:
	ld a, $01 ; $79ef
	ret ; $79f1
AiServeState:
	ld a, [$df1a] ; $79f2
	rst Rst00 ; $79f5
	dw AiServeWalkToSpot ; $79f6 jumptable
	dw AiServeSteerToSpot ; $79f8 jumptable
	dw AiServePressToss ; $79fa jumptable
	dw AiServeStrike ; $79fc jumptable
	dw Label_08_7ae7 ; $79fe jumptable
	dw Label_08_796c ; $7a00 jumptable
AiServeWalkToSpot:
	ld a, [$df2e] ; $7a02
	cp a, $10 ; $7a05
	ret nz ; $7a07
	ld hl, $c7b6 ; $7a08
	ld a, [hl+] ; $7a0b
	ld b, [hl] ; $7a0c
	ld c, a ; $7a0d
	ld a, b ; $7a0e
	or a, c ; $7a0f
	jr nz, Label_08_7a22 ; $7a10
	call AdvanceMatchRng ; $7a12
	and a, $07 ; $7a15
	add a, a ; $7a17
	add a, $3d ; $7a18
	ld l, a ; $7a1a
	adc a, $7a ; $7a1b
	sub a, l ; $7a1d
	ld h, a ; $7a1e
	ld a, [hl+] ; $7a1f
	ld b, [hl] ; $7a20
	ld c, a ; $7a21
Label_08_7a22:
	ld hl, wCharPosDepth + 1 ; $7a22
	ld a, [hl+] ; $7a25
	ld d, [hl] ; $7a26
	ld e, a ; $7a27
	ld a, [wCharCourtPos] ; $7a28
	and a, $01 ; $7a2b
	jr z, Label_08_7a35 ; $7a2d
	xor a, a ; $7a2f
	sub a, c ; $7a30
	ld c, a ; $7a31
	sbc a, a ; $7a32
	sub a, b ; $7a33
	ld b, a ; $7a34
Label_08_7a35:
	ld l, c ; $7a35
	ld h, b ; $7a36
	call SetCharTarget ; $7a37
	jp AiAdvancePhase ; $7a3a
	; $7a3d, 16 bytes (records:2)
	dw $0020 ; record 0
	dw $0020 ; record 1
	dw $0080 ; record 2
	dw $00e0 ; record 3
	dw $0140 ; record 4
	dw $0180 ; record 5
	dw $0180 ; record 6
	dw $0180 ; record 7
AiServeSteerToSpot:
	call AiSteerTowardTarget ; $7a4d
	call CheckCharNearTarget ; $7a50
	and a, a ; $7a53
	jr z, Label_08_7a5e ; $7a54
	ld hl, $df12 ; $7a56
	ld [hl], $19 ; $7a59
	jp AiAdvancePhase ; $7a5b
Label_08_7a5e:
	ret ; $7a5e
AiServePressToss:
	ld hl, $df1f ; $7a5f
	set 0, [hl] ; $7a62
	ld a, [$c7a8] ; $7a64
	and a, a ; $7a67
	jr nz, Label_08_7a95 ; $7a68
	ld a, [wServeFaultFlag] ; $7a6a
	and a, a ; $7a6d
	jr nz, Label_08_7a95 ; $7a6e
	ld a, [$df7d] ; $7a70
	and a, $0f ; $7a73
	add a, a ; $7a75
	add a, $9d ; $7a76
	ld l, a ; $7a78
	adc a, $7a ; $7a79
	sub a, l ; $7a7b
	ld h, a ; $7a7c
	ld a, [hl+] ; $7a7d
	ld h, [hl] ; $7a7e
	ld l, a ; $7a7f
	call AdvanceMatchRng ; $7a80
	and a, $07 ; $7a83
	add a, l ; $7a85
	ld l, a ; $7a86
	jr nc, Label_08_7a8a ; $7a87
	inc h ; $7a89
Label_08_7a8a:
	ld a, [hl] ; $7a8a
	and a, a ; $7a8b
	jr z, Label_08_7a95 ; $7a8c
	ld a, $23 ; $7a8e
	ld [$df12], a ; $7a90
	jr Label_08_7a9a ; $7a93
Label_08_7a95:
	ld a, $32 ; $7a95
	ld [$df12], a ; $7a97
Label_08_7a9a:
	jp AiAdvancePhase ; $7a9a
	; $7a9d, 32 bytes (records:2)
	dw $7abd ; record 0
	dw $7ac5 ; record 1
	dw $7acd ; record 2
	dw $7ad5 ; record 3
	dw $7acd ; record 4
	dw $7acd ; record 5
	dw $7acd ; record 6
	dw $7acd ; record 7
	dw $7acd ; record 8
	dw $7acd ; record 9
	dw $7acd ; record 10
	dw $7acd ; record 11
	dw $7acd ; record 12
	dw $7acd ; record 13
	dw $7acd ; record 14
	dw $7acd ; record 15
	; $7abd, 32 bytes (bytes:8)
	db $00, $00, $00, $00, $00, $00, $00, $00 ; 0x00
	db $00, $00, $00, $00, $00, $01, $01, $01 ; 0x08
	db $00, $00, $01, $01, $01, $01, $01, $01 ; 0x10
	db $01, $01, $01, $01, $01, $01, $01, $01 ; 0x18
AiServeStrike:
	call AiPickServeButtons ; $7add
	call AiPressFirstShotButton ; $7ae0
	ld hl, $df1a ; $7ae3
	inc [hl] ; $7ae6
Label_08_7ae7:
	call AiApplyServeAim ; $7ae7
	ret ; $7aea
AiApplyServeAim:
	ld a, [$c7b5] ; $7aeb
	cp a, $ff ; $7aee
	jr z, Label_08_7af5 ; $7af0
	ld b, a ; $7af2
	jr Label_08_7b02 ; $7af3
Label_08_7af5:
	call AdvanceMatchRng ; $7af5
	and a, $07 ; $7af8
	add a, $0b ; $7afa
	ld l, a ; $7afc
	adc a, $7b ; $7afd
	sub a, l ; $7aff
	ld h, a ; $7b00
	ld b, [hl] ; $7b01
Label_08_7b02:
	ld hl, $df1f ; $7b02
	ld a, [hl] ; $7b05
	and a, $0f ; $7b06
	or a, b ; $7b08
	ld [hl], a ; $7b09
	ret ; $7b0a
	; $7b0b, 8 bytes (bytes:8)
	db $10, $10, $10, $10, $20, $20, $20, $20 ; 0x00
AiMaybeAimAwayFromChar:
	ld c, a ; $7b13
	call AdvanceMatchRng ; $7b14
	ld hl, $df7c ; $7b17
	cp a, [hl] ; $7b1a
	ld b, $00 ; $7b1b
	jr nc, Label_08_7b59 ; $7b1d
AiAimAwayFromChar:
	ldh a, [hWramBank] ; $7b1f
	push af ; $7b21
	ld a, c ; $7b22
	call CharIndexToWramBank ; $7b23
	ld a, a ; $7b26
	wram_bank ; $7b27
	ld hl, wCharVelX ; $7b2b
	ld a, [hl+] ; $7b2e
	ld d, [hl] ; $7b2f
	ld e, a ; $7b30
	ld hl, wCharPosX + 1 ; $7b31
	ld a, [hl+] ; $7b34
	ld h, [hl] ; $7b35
	ld l, a ; $7b36
	pop af ; $7b37
	wram_bank ; $7b38
	call AdvanceMatchRng ; $7b3c
	and a, $03 ; $7b3f
	jr z, Label_08_7b51 ; $7b41
	cp a, $01 ; $7b43
	jr nz, Label_08_7b4c ; $7b45
	ld a, h ; $7b47
	cpl ; $7b48
	ld h, a ; $7b49
	jr Label_08_7b51 ; $7b4a
Label_08_7b4c:
	ld a, d ; $7b4c
	or a, e ; $7b4d
	jr z, Label_08_7b51 ; $7b4e
	ld h, d ; $7b50
Label_08_7b51:
	bit 7, h ; $7b51
	ld b, $20 ; $7b53
	jr z, Label_08_7b59 ; $7b55
	ld b, $10 ; $7b57
Label_08_7b59:
	ld hl, $df1f ; $7b59
	ld a, [hl] ; $7b5c
	and a, $0f ; $7b5d
	or a, b ; $7b5f
	ld [hl], a ; $7b60
	ret ; $7b61
AiPickServeButtons:
	call AdvanceMatchRng ; $7b62
	and a, $07 ; $7b65
	add a, $73 ; $7b67
	ld l, a ; $7b69
	adc a, $7b ; $7b6a
	sub a, l ; $7b6c
	ld h, a ; $7b6d
	ld a, [hl] ; $7b6e
	ld [$df58], a ; $7b6f
	ret ; $7b72
	; $7b73, 8 bytes (bytes:8)
	db $10, $10, $10, $20, $20, $30, $30, $30 ; 0x00
AiPickShotButtons:
	ld a, [wLandingMarkerActive] ; $7b7b
	and a, a ; $7b7e
	jr z, Label_08_7b92 ; $7b7f
	ld b, $30 ; $7b81
	ld a, [$df7d] ; $7b83
	farcall DoesCharGroupRowContain ; $7b86
	and a, a ; $7b89
	jr z, Label_08_7b92 ; $7b8a
	ld a, $30 ; $7b8c
	ld [$df58], a ; $7b8e
	ret ; $7b91
Label_08_7b92:
	call AdvanceMatchRng ; $7b92
	and a, $01 ; $7b95
	jr nz, Label_08_7c00 ; $7b97
	ld hl, wBallRelCharDepth ; $7b99
	ld a, [hl+] ; $7b9c
	ld h, [hl] ; $7b9d
	ld l, a ; $7b9e
	bit 7, h ; $7b9f
	jr z, Label_08_7ba9 ; $7ba1
	xor a, a ; $7ba3
	sub a, l ; $7ba4
	ld l, a ; $7ba5
	sbc a, a ; $7ba6
	sub a, h ; $7ba7
	ld h, a ; $7ba8
Label_08_7ba9:
	ld de, $fec0 ; $7ba9
	add hl, de ; $7bac
	bit 7, h ; $7bad
	jr nz, Label_08_7c00 ; $7baf
	ld b, $12 ; $7bb1
	ld a, [$df7d] ; $7bb3
	farcall DoesCharGroupRowContain ; $7bb6
	and a, a ; $7bb9
	jr z, Label_08_7c00 ; $7bba
	ld a, [wMatchIsDoubles] ; $7bbc
	and a, a ; $7bbf
	jr z, Label_08_7bcb ; $7bc0
	call AdvanceMatchRng ; $7bc2
	and a, $03 ; $7bc5
	jr nz, Label_08_7c00 ; $7bc7
	jr Label_08_7bfa ; $7bc9
Label_08_7bcb:
	ldh a, [hWramBank] ; $7bcb
	push af ; $7bcd
	ld a, [wCharIndex] ; $7bce
	add a, $01 ; $7bd1
	and a, $01 ; $7bd3
	call CharIndexToWramBank ; $7bd5
	ld a, a ; $7bd8
	wram_bank ; $7bd9
	ld hl, wCharPosDepth + 1 ; $7bdd
	ld a, [hl+] ; $7be0
	ld h, [hl] ; $7be1
	ld l, a ; $7be2
	pop af ; $7be3
	wram_bank ; $7be4
	bit 7, h ; $7be8
	jr z, Label_08_7bf2 ; $7bea
	xor a, a ; $7bec
	sub a, l ; $7bed
	ld l, a ; $7bee
	sbc a, a ; $7bef
	sub a, h ; $7bf0
	ld h, a ; $7bf1
Label_08_7bf2:
	ld de, $fe20 ; $7bf2
	add hl, de ; $7bf5
	bit 7, h ; $7bf6
	jr z, Label_08_7c00 ; $7bf8
Label_08_7bfa:
	ld a, $12 ; $7bfa
	ld [$df58], a ; $7bfc
	ret ; $7bff
Label_08_7c00:
	call AdvanceMatchRng ; $7c00
	and a, $0f ; $7c03
	ld b, a ; $7c05
	ld a, [$df7d] ; $7c06
	farcall GetCharGroupEntry ; $7c09
	ld [$df58], a ; $7c0c
	ret ; $7c0f
AiPressFirstShotButton:
	ld a, [$df58] ; $7c10
	swap a ; $7c13
	and a, $0f ; $7c15
	ld b, a ; $7c17
	ld hl, $df1f ; $7c18
	ld a, [hl] ; $7c1b
	and a, $f0 ; $7c1c
	or a, b ; $7c1e
	ld [hl], a ; $7c1f
	ret ; $7c20
AiPressSecondShotButton:
	ld a, [$df58] ; $7c21
	and a, $0f ; $7c24
	ld b, a ; $7c26
	ld hl, $df1f ; $7c27
	ld a, [hl] ; $7c2a
	and a, $f0 ; $7c2b
	or a, b ; $7c2d
	ld [hl], a ; $7c2e
	ret ; $7c2f
CharIndexToWramBank:
	add a, $04 ; $7c30
	ret ; $7c32
MirrorDepthForFarSide:
	ld a, [wCharCourtPos] ; $7c33
	and a, $02 ; $7c36
	ret z ; $7c38
	xor a, a ; $7c39
	sub a, e ; $7c3a
	ld e, a ; $7c3b
	sbc a, a ; $7c3c
	sub a, d ; $7c3d
	ld d, a ; $7c3e
	ret ; $7c3f
GetCharRoleByIndex:
	ld b, a ; $7c40
	ldh a, [hWramBank] ; $7c41
	push af ; $7c43
	ld a, b ; $7c44
	call CharIndexToWramBank ; $7c45
	ld a, a ; $7c48
	wram_bank ; $7c49
	ld a, [wCharServeRole] ; $7c4d
	ld b, a ; $7c50
	pop af ; $7c51
	wram_bank ; $7c52
	ret ; $7c56
OffsetFromBallLanding:
	ld a, [wShotAimAngle + 1] ; $7c57
	call VectorFromLengthAndAngle ; $7c5a
	ld c, l ; $7c5d
	ld b, h ; $7c5e
	ld hl, wBallTargetDepth ; $7c5f
	ld a, [hl+] ; $7c62
	ld h, [hl] ; $7c63
	ld l, a ; $7c64
	add hl, de ; $7c65
	ld e, l ; $7c66
	ld d, h ; $7c67
	ld hl, wBallTargetX ; $7c68
	ld a, [hl+] ; $7c6b
	ld h, [hl] ; $7c6c
	ld l, a ; $7c6d
	add hl, bc ; $7c6e
	ret ; $7c6f
SetCharTargetMirrored:
	call MirrorDepthForFarSide ; $7c70
	ld c, l ; $7c73
	ld b, h ; $7c74
	ld hl, wCharWalkTargetX ; $7c75
	ld a, c ; $7c78
	ld [hl+], a ; $7c79
	ld [hl], b ; $7c7a
	ld hl, wCharWalkTargetDepth ; $7c7b
	ld a, e ; $7c7e
	ld [hl+], a ; $7c7f
	ld [hl], d ; $7c80
	xor a, a ; $7c81
	ld [$df55], a ; $7c82
	ret ; $7c85
PredictBallXAtDepth:
	ld hl, wShotAimAngle ; $7c86
	ld a, [hl+] ; $7c89
	ld b, [hl] ; $7c8a
	ld c, a ; $7c8b
	ld hl, wBallDepth ; $7c8c
	ld a, [hl+] ; $7c8f
	ld h, [hl] ; $7c90
	ld l, a ; $7c91
	xor a, a ; $7c92
	sub a, l ; $7c93
	ld l, a ; $7c94
	sbc a, a ; $7c95
	sub a, h ; $7c96
	ld h, a ; $7c97
	add hl, de ; $7c98
	call MulHLByTangent ; $7c99
	ld hl, wBallX ; $7c9c
	ld a, [hl+] ; $7c9f
	ld h, [hl] ; $7ca0
	ld l, a ; $7ca1
	add hl, de ; $7ca2
	ret ; $7ca3
AiRecoverStateSingles:
	ld a, [$df1a] ; $7ca4
	rst Rst00 ; $7ca7
	dw AiChooseHomePosition ; $7ca8 jumptable
	dw AiReturnToPositionPhase ; $7caa jumptable
	dw Label_08_796c ; $7cac jumptable
AiChooseHomePosition:
	ld a, [$df7f] ; $7cae
	rst Rst00 ; $7cb1
	dw Label_08_7cc2 ; $7cb2 jumptable
	dw Label_08_7ccc ; $7cb4 jumptable
	dw Label_08_7cc7 ; $7cb6 jumptable
	dw Label_08_7cc7 ; $7cb8 jumptable
	dw Label_08_7cc7 ; $7cba jumptable
	dw Label_08_7cc2 ; $7cbc jumptable
	dw Label_08_7cc7 ; $7cbe jumptable
	dw Label_08_7cc7 ; $7cc0 jumptable
Label_08_7cc2:
	ld de, $0460 ; $7cc2
	jr Label_08_7cdc ; $7cc5
Label_08_7cc7:
	ld de, $0180 ; $7cc7
	jr Label_08_7cdc ; $7cca
Label_08_7ccc:
	ld hl, wCharPosDepth + 1 ; $7ccc
	ld a, [hl+] ; $7ccf
	ld d, [hl] ; $7cd0
	ld e, a ; $7cd1
	bit 7, d ; $7cd2
	jr z, Label_08_7cdc ; $7cd4
	xor a, a ; $7cd6
	sub a, e ; $7cd7
	ld e, a ; $7cd8
	sbc a, a ; $7cd9
	sub a, d ; $7cda
	ld d, a ; $7cdb
Label_08_7cdc:
	ld hl, wBallTargetX ; $7cdc
	ld a, [hl+] ; $7cdf
	ld h, [hl] ; $7ce0
	ld l, a ; $7ce1
	sra h ; $7ce2
	rr l ; $7ce4
	sra h ; $7ce6
	rr l ; $7ce8
	jp Label_08_79d3 ; $7cea
AiReturnToPositionPhase:
	call AiSteerTowardTarget ; $7ced
	call CheckCharNearTarget ; $7cf0
	and a, a ; $7cf3
	jr z, Label_08_7cf9 ; $7cf4
	jp AiAdvancePhase ; $7cf6
Label_08_7cf9:
	ret ; $7cf9
AiRallyStateSingles:
	ld a, [$df1a] ; $7cfa
	rst Rst00 ; $7cfd
	dw AiSetReactionDelay ; $7cfe jumptable
	dw AiChoosePositionByStrategy ; $7d00 jumptable
	dw AiTrackBallPhase ; $7d02 jumptable
	dw AiWaitThenPickShot ; $7d04 jumptable
	dw AiSwingControlSingles ; $7d06 jumptable
	dw Label_08_796c ; $7d08 jumptable
AiSetReactionDelay:
	ld a, [$df50] ; $7d0a
	bit 4, a ; $7d0d
	ld hl, $df7a ; $7d0f
	jr z, Label_08_7d17 ; $7d12
	ld hl, $df79 ; $7d14
Label_08_7d17:
	call AdvanceMatchRng ; $7d17
	and a, $03 ; $7d1a
	add a, [hl] ; $7d1c
	ld [$df12], a ; $7d1d
	jp AiAdvancePhase ; $7d20
AiChoosePositionByStrategy:
	ld a, [$df7f] ; $7d23
	rst Rst00 ; $7d26
	dw Label_08_7d3e ; $7d27 jumptable
	dw Label_08_7d58 ; $7d29 jumptable
	dw Label_08_7d41 ; $7d2b jumptable
	dw Label_08_7d4b ; $7d2d jumptable
	dw Label_08_7d48 ; $7d2f jumptable
	dw Label_08_7d48 ; $7d31 jumptable
	dw Label_08_7d55 ; $7d33 jumptable
	dw Label_08_7d3e ; $7d35 jumptable
	call AiIsIncomingLobShot ; $7d37
	and a, a ; $7d3a
	jp nz, AiRushToBallLanding ; $7d3b
Label_08_7d3e:
	jp AiMoveBehindBallLanding ; $7d3e
Label_08_7d41:
	call AiIsIncomingDropOrLobShot ; $7d41
	and a, a ; $7d44
	jp nz, AiRushToBallLanding ; $7d45
Label_08_7d48:
	jp AiMoveLaterallyToBallLine ; $7d48
Label_08_7d4b:
	call AiIsIncomingDropOrLobShot ; $7d4b
	and a, a ; $7d4e
	jp nz, AiRushToBallLanding ; $7d4f
	jp AiInterceptAtMidCourt ; $7d52
Label_08_7d55:
	jp AiInterceptNearNet ; $7d55
Label_08_7d58:
	ld hl, $df50 ; $7d58
	bit 4, [hl] ; $7d5b
	jr z, Label_08_7d69 ; $7d5d
	call AiIsIncomingDropOrLobShot ; $7d5f
	and a, a ; $7d62
	jp nz, AiRushToBallLanding ; $7d63
	jp AiInterceptAtMidCourt ; $7d66
Label_08_7d69:
	call AiIsIncomingLobShot ; $7d69
	and a, a ; $7d6c
	jp nz, AiRushToBallLanding ; $7d6d
	jp AiMoveBehindBallLanding ; $7d70
AiTrackBallPhase:
	ld a, [wBallHasBouncedFlag] ; $7d73
	ld b, a ; $7d76
	ld a, [wBallCrossedNetFlag] ; $7d77
	and a, b ; $7d7a
	jr nz, Label_08_7d93 ; $7d7b
	ld a, [$df5a] ; $7d7d
	and a, a ; $7d80
	ret z ; $7d81
	call AiSteerTowardTarget ; $7d82
	call CheckCharNearTarget ; $7d85
	and a, a ; $7d88
	jr nz, Label_08_7da3 ; $7d89
	ld hl, $df50 ; $7d8b
	bit 0, [hl] ; $7d8e
	jr nz, Label_08_7da3 ; $7d90
	ret ; $7d92
Label_08_7d93:
	ld de, $0200 ; $7d93
	call MirrorDepthForFarSide ; $7d96
	call PredictBallXAtDepth ; $7d99
	ld de, $0200 ; $7d9c
	call SetCharTargetMirrored ; $7d9f
	ret ; $7da2
Label_08_7da3:
	ld a, [$df7b] ; $7da3
	ld [$df59], a ; $7da6
	ld hl, $df1a ; $7da9
	inc [hl] ; $7dac
AiWaitThenPickShot:
	ld hl, $df50 ; $7dad
	bit 0, [hl] ; $7db0
	jr nz, Label_08_7dbd ; $7db2
	ld hl, $df59 ; $7db4
	ld a, [hl] ; $7db7
	and a, a ; $7db8
	jr z, Label_08_7dbd ; $7db9
	dec [hl] ; $7dbb
	ret ; $7dbc
Label_08_7dbd:
	call AiPickShotButtons ; $7dbd
	call AiPressFirstShotButton ; $7dc0
	ld hl, $df13 ; $7dc3
	ld [hl], $05 ; $7dc6
	jp AiAdvancePhase ; $7dc8
AiSwingControlSingles:
	ld a, [$df13] ; $7dcb
	and a, a ; $7dce
	jr nz, Label_08_7dda ; $7dcf
	ld a, [$df17] ; $7dd1
	and a, a ; $7dd4
	jr nz, Label_08_7dda ; $7dd5
	call AiPressSecondShotButton ; $7dd7
Label_08_7dda:
	ld hl, $df50 ; $7dda
	bit 1, [hl] ; $7ddd
	jr nz, Label_08_7de5 ; $7ddf
	call AiSteerTowardBall ; $7de1
	ret ; $7de4
Label_08_7de5:
	ld a, [wCharIndex] ; $7de5
	add a, $01 ; $7de8
	and a, $01 ; $7dea
	call AiMaybeAimAwayFromChar ; $7dec
	jp AiAdvancePhase ; $7def
AiRecoverStateNetPlayer:
	ld a, [$df1a] ; $7df2
	rst Rst00 ; $7df5
	dw Label_08_7e08 ; $7df6 jumptable
	dw AiReturnToPositionPhase ; $7df8 jumptable
	dw Label_08_796c ; $7dfa jumptable
AiRecoverStateBaseliner:
	ld a, [$df1a] ; $7dfc
	rst Rst00 ; $7dff
	dw AiAdvancePhase ; $7e00 jumptable
	dw AiBaselinerShadowPartner ; $7e02 jumptable
	dw AiReturnToPositionPhase ; $7e04 jumptable
	dw Label_08_796c ; $7e06 jumptable
Label_08_7e08:
	ld hl, wBallTargetX ; $7e08
	ld a, [hl+] ; $7e0b
	ld h, [hl] ; $7e0c
	ld l, a ; $7e0d
	sra h ; $7e0e
	rr l ; $7e10
	ld e, l ; $7e12
	ld d, h ; $7e13
	sra h ; $7e14
	rr l ; $7e16
	add hl, de ; $7e18
	ld de, $0180 ; $7e19
	call SetCharTargetMirrored ; $7e1c
	jp AiAdvancePhase ; $7e1f
AiBaselinerShadowPartner:
	ldh a, [hWramBank] ; $7e22
	push af ; $7e24
	ld a, [wCharIndex] ; $7e25
	add a, $02 ; $7e28
	and a, $03 ; $7e2a
	call CharIndexToWramBank ; $7e2c
	ld a, a ; $7e2f
	wram_bank ; $7e30
	ld hl, rLCDC ; $7e34
	ld a, [wCharWalkTargetX + 1] ; $7e37
	bit 7, a ; $7e3a
	jr z, Label_08_7e44 ; $7e3c
	xor a, a ; $7e3e
	sub a, l ; $7e3f
	ld l, a ; $7e40
	sbc a, a ; $7e41
	sub a, h ; $7e42
	ld h, a ; $7e43
Label_08_7e44:
	pop af ; $7e44
	wram_bank ; $7e45
	ld de, $0460 ; $7e49
	call SetCharTargetMirrored ; $7e4c
	jp AiAdvancePhase ; $7e4f
AiRallyStateNetPlayer:
	ld a, [$df1a] ; $7e52
	rst Rst00 ; $7e55
	dw Label_08_7e7e ; $7e56 jumptable
	dw Label_08_7e99 ; $7e58 jumptable
	dw AiDoublesTrackBallPhase ; $7e5a jumptable
	dw AiWaitThenPickShot ; $7e5c jumptable
	dw AiSwingControlDoubles ; $7e5e jumptable
	dw Label_08_796c ; $7e60 jumptable
	dw Label_08_796c ; $7e62 jumptable
	dw Label_08_796c ; $7e64 jumptable
	dw AiNetPlayerPoachCheck ; $7e66 jumptable
AiRallyStateBaseliner:
	ld a, [$df1a] ; $7e68
	rst Rst00 ; $7e6b
	dw Label_08_7eb1 ; $7e6c jumptable
	dw Label_08_7ec0 ; $7e6e jumptable
	dw AiDoublesTrackBallPhase ; $7e70 jumptable
	dw AiWaitThenPickShot ; $7e72 jumptable
	dw AiSwingControlDoubles ; $7e74 jumptable
	dw Label_08_796c ; $7e76 jumptable
	dw Label_08_796c ; $7e78 jumptable
	dw Label_08_796c ; $7e7a jumptable
	dw AiNetPlayerPoachCheck ; $7e7c jumptable
Label_08_7e7e:
	ld a, [wRallyLength] ; $7e7e
	cp a, $02 ; $7e81
	ret c ; $7e83
	call AdvanceMatchRng ; $7e84
	and a, $03 ; $7e87
	ld hl, $df79 ; $7e89
	add a, [hl] ; $7e8c
	ld [$df12], a ; $7e8d
	ld a, [$df7b] ; $7e90
	ld [$df59], a ; $7e93
	jp AiAdvancePhase ; $7e96
Label_08_7e99:
	ld de, $0180 ; $7e99
	call MirrorDepthForFarSide ; $7e9c
	call PredictBallXAtDepth ; $7e9f
	ld de, $0180 ; $7ea2
	call SetCharTargetMirrored ; $7ea5
	ld a, [$df7b] ; $7ea8
	ld [$df59], a ; $7eab
	jp AiAdvancePhase ; $7eae
Label_08_7eb1:
	call AdvanceMatchRng ; $7eb1
	and a, $03 ; $7eb4
	ld hl, $df7a ; $7eb6
	add a, [hl] ; $7eb9
	ld [$df12], a ; $7eba
	jp AiAdvancePhase ; $7ebd
Label_08_7ec0:
	ld de, $0460 ; $7ec0
	call MirrorDepthForFarSide ; $7ec3
	call PredictBallXAtDepth ; $7ec6
	ld de, $0460 ; $7ec9
	call SetCharTargetMirrored ; $7ecc
	jp AiAdvancePhase ; $7ecf
AiDoublesTrackBallPhase:
	ld a, [$df5a] ; $7ed2
	and a, a ; $7ed5
	ret z ; $7ed6
	call AiSteerTowardTarget ; $7ed7
	call CheckCharNearTarget ; $7eda
	and a, a ; $7edd
	jr nz, Label_08_7f07 ; $7ede
	ld hl, $df50 ; $7ee0
	bit 0, [hl] ; $7ee3
	jr nz, Label_08_7f07 ; $7ee5
	ldh a, [hWramBank] ; $7ee7
	push af ; $7ee9
	ld a, [wCharIndex] ; $7eea
	add a, $02 ; $7eed
	and a, $03 ; $7eef
	call CharIndexToWramBank ; $7ef1
	ld a, a ; $7ef4
	wram_bank ; $7ef5
	ld a, [$df16] ; $7ef9
	ld b, a ; $7efc
	pop af ; $7efd
	wram_bank ; $7efe
	ld a, b ; $7f02
	and a, a ; $7f03
	jr nz, Label_08_7f0a ; $7f04
	ret ; $7f06
Label_08_7f07:
	jp AiAdvancePhase ; $7f07
Label_08_7f0a:
	ld a, $08 ; $7f0a
	ld [$df1a], a ; $7f0c
	jr AiNetPlayerPoachCheck ; $7f0f
AiNetPlayerPoachCheck:
	ld a, [wCharServeRole] ; $7f11
	and a, $02 ; $7f14
	jr z, Label_08_7f22 ; $7f16
	ld a, [wCharIndex] ; $7f18
	and a, $01 ; $7f1b
	jr z, Label_08_7f22 ; $7f1d
	ld a, [wCharIndex] ; $7f1f
Label_08_7f22:
	ld hl, $df50 ; $7f22
	bit 0, [hl] ; $7f25
	jr z, Label_08_7f31 ; $7f27
	ld a, $03 ; $7f29
	ld [$df1a], a ; $7f2b
	jp AiWaitThenPickShot ; $7f2e
Label_08_7f31:
	ldh a, [hWramBank] ; $7f31
	push af ; $7f33
	ld a, [wCharIndex] ; $7f34
	add a, $02 ; $7f37
	and a, $03 ; $7f39
	call CharIndexToWramBank ; $7f3b
	ld a, a ; $7f3e
	wram_bank ; $7f3f
	ld hl, wBallDepth ; $7f43
	ld a, [hl+] ; $7f46
	ld d, [hl] ; $7f47
	ld e, a ; $7f48
	bit 7, d ; $7f49
	jr z, Label_08_7f53 ; $7f4b
	xor a, a ; $7f4d
	sub a, e ; $7f4e
	ld e, a ; $7f4f
	sbc a, a ; $7f50
	sub a, d ; $7f51
	ld d, a ; $7f52
Label_08_7f53:
	ld hl, wCharPosDepth + 1 ; $7f53
	ld a, [hl+] ; $7f56
	ld h, [hl] ; $7f57
	ld l, a ; $7f58
	bit 7, h ; $7f59
	jr z, Label_08_7f63 ; $7f5b
	xor a, a ; $7f5d
	sub a, l ; $7f5e
	ld l, a ; $7f5f
	sbc a, a ; $7f60
	sub a, h ; $7f61
	ld h, a ; $7f62
Label_08_7f63:
	ld bc, $0020 ; $7f63
	add hl, bc ; $7f66
	ld a, l ; $7f67
	sub a, e ; $7f68
	ld l, a ; $7f69
	ld a, h ; $7f6a
	sbc a, d ; $7f6b
	ld h, a ; $7f6c
	pop af ; $7f6d
	wram_bank ; $7f6e
	bit 7, h ; $7f72
	jr z, Label_08_7f89 ; $7f74
	ld hl, wCharPosDepth + 1 ; $7f76
	ld a, [hl+] ; $7f79
	ld d, [hl] ; $7f7a
	ld e, a ; $7f7b
	push de ; $7f7c
	call PredictBallXAtDepth ; $7f7d
	pop de ; $7f80
	call SetCharTarget ; $7f81
	ld a, $02 ; $7f84
	ld [$df1a], a ; $7f86
Label_08_7f89:
	ret ; $7f89
AiSwingControlDoubles:
	ld a, [$df13] ; $7f8a
	and a, a ; $7f8d
	jr nz, Label_08_7f99 ; $7f8e
	ld a, [$df17] ; $7f90
	and a, a ; $7f93
	jr nz, Label_08_7f99 ; $7f94
	call AiPressSecondShotButton ; $7f96
Label_08_7f99:
	ld hl, $df50 ; $7f99
	bit 1, [hl] ; $7f9c
	jr nz, Label_08_7fa4 ; $7f9e
	call AiSteerTowardBall ; $7fa0
	ret ; $7fa3
Label_08_7fa4:
	ld a, [wCharIndex] ; $7fa4
	add a, $01 ; $7fa7
	and a, $03 ; $7fa9
	ld d, a ; $7fab
	call GetCharRoleByIndex ; $7fac
	ld a, b ; $7faf
	and a, $02 ; $7fb0
	jr nz, Label_08_7fbc ; $7fb2
	ld a, [wCharIndex] ; $7fb4
	add a, $03 ; $7fb7
	and a, $03 ; $7fb9
	ld d, a ; $7fbb
Label_08_7fbc:
	ld c, d ; $7fbc
	call AiAimAwayFromChar ; $7fbd
	jp AiAdvancePhase ; $7fc0
	ds 61, $ff ; $7fc3, fill
