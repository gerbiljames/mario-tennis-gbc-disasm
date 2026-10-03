InitDefaultMatchSettings:
	xor a ; $4070
	ld [wKeepMatchStatsFlag], a ; $4071
	ld hl, wMatchMenuSelection ; $4074
	ld c, $02 ; $4077
	call ClearMemory16 ; $4079
	ld hl, wMatchTypeNumberOfSets ; $407c
	ld c, $01 ; $407f
	call ClearMemory16 ; $4081
	ld hl, wModeScratch ; $4084
	ld c, $08 ; $4087
	call ClearMemory16 ; $4089
	ld a, COURT_HARD ; $408c
	ld [wCurrentlyUsedCourt], a ; $408e
	ld a, $01 ; $4091
	ld [wMatchTypeNumberOfSets], a ; $4093
	ld a, $02 ; $4096
	ld [wMatchTypeNumberOfGames], a ; $4098
	ld a, $00 ; $409b
	ld [wMatchIsDoubles], a ; $409d
	ld a, $02 ; $40a0
	ld [wOnCourtCharCount], a ; $40a2
	ld a, BGM_COURT_STAR ; $40a5
	ld [wMatchBGM], a ; $40a7
	ret ; $40aa
ResetMatchState:
	wram_bank WRAM_ACTORS ; $40ab
	ld hl, wBallXFrac ; $40b1
	ld c, $0e ; $40b4
	call ClearMemory16 ; $40b6
	ld a, [wKeepMatchStatsFlag] ; $40b9
	and a ; $40bc
	jr nz, .keepStats ; $40bd
	ld hl, wCharacter1ServiceAces ; $40bf
	ld c, $03 ; $40c2
	call ClearMemory16 ; $40c4
.keepStats:
	xor a ; $40c7
	ld [wKeepMatchStatsFlag], a ; $40c8
	ld a, $ff ; $40cb
	ld [wMatchSimFrozen], a ; $40cd
	ld a, $01 ; $40d0
	ld [wPauseDisabled], a ; $40d2
	xor a ; $40d5
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
	and a ; $4103
	ld bc, $0220 ; $4104
	jr z, .storeAimSpread ; $4107
	ld bc, $0320 ; $4109
.storeAimSpread:
	ld hl, wAimSpreadBase ; $410c
	ld a, c ; $410f
	ld [hl+], a ; $4110
	ld [hl], b ; $4111
	ld a, [wOnCourtCharCount] ; $4112
	dec a ; $4115
	and $03 ; $4116
	ld [wOnCourtCharCountMinus1], a ; $4118
	ld a, [wMatchTypeNumberOfSets] ; $411b
	srl a ; $411e
	ld [wRulesSetsIndex], a ; $4120
	ld a, [wMatchTypeNumberOfGames] ; $4123
	rrca ; $4126
	rrca ; $4127
	and $01 ; $4128
	ld [wRulesGamesIndex], a ; $412a
	call SelectScoreboardLayout ; $412d
	ld a, [wGameMode] ; $4130
	cp GAMEMODE_LINK_MATCH ; $4133
	ldh a, [hVBlankCounter] ; $4135
	jr nz, .seedRng ; $4137
	ld a, $00 ; $4139
.seedRng:
	ld [wMatchRngState], a ; $413b
	xor a ; $413e
	ldh [hMatchFrameCounter], a ; $413f
	xor a ; $4141
	ldh [hLinkPayloadKind], a ; $4142
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
	wram_bank WRAM_ACTORS ; $4161
	call ResetBallState ; $4167
	call InitAllChars ; $416a
	farcall InitAllObjSlots ; $416d
	call ClearSpriteSlots ; $4170
	call AssignCourtPositions ; $4173
	xor a ; $4176
	ld [wChangeEndsPending], a ; $4177
	farcall UpdatePointDigitsDisplay ; $417a
	call RefreshCourtScoreboard ; $417d
	call UploadCourtTilemap ; $4180
	call UploadCourtAttrmap ; $4183
	farcall LoadMatchGraphics ; $4186
	wram_bank WRAM_CHAR0 ; $4189
	ret ; $418f
RunMatch:
	ld c, 32 ; $4190
	call BeginFadeOut ; $4192
	call WaitFadeEnd ; $4195
	call AdvanceFrame ; $4198
	call DisableLCDSafely ; $419b
	call InitMatchScene ; $419e
	call EnableLCD ; $41a1
	farcall UpdateLinkSession ; $41a4
	ld a, [wMatchBGM] ; $41a7
	call PlaySoundManaged ; $41aa
	ld hl, wModeScratch ; $41ad
	ld c, $08 ; $41b0
	call ClearMemory16 ; $41b2
	ld a, $ff ; $41b5
	ld [wAiServeAimOverride], a ; $41b7
	script_fade_in 32 ; $41ba
	wram_bank WRAM_ACTORS ; $41bf
	call PlayCourtIntro ; $41c5
	xor a ; $41c8
	ld [wMatchSimFrozen], a ; $41c9
	call RunMatchPlayLoop ; $41cc
	ldh a, [hLinkState] ; $41cf
	ld [wMatchEndLinkState], a ; $41d1
	farcall EndLinkSession ; $41d4
	ld a, [wGameMode] ; $41d7
	cp GAMEMODE_MARIO_MINIGAME ; $41da
	call z, ShowMatchResultScreens ; $41dc
	ld c, 32 ; $41df
	call BeginFadeOut ; $41e1
	call WaitFadeEnd ; $41e4
	call AdvanceFrame ; $41e7
	farcall RunMatchWinLoseScreen ; $41ea
	farcall LoadMenuFontGfx ; $41ed
	call AdvanceFrame ; $41f0
	farcall ProcessMatchRewards ; $41f3
	ret ; $41f6
UpdateMatchFrame:
	wram_bank WRAM_ACTORS ; $41f7
	ld a, [wMatchSimFrozen] ; $41fd
	and a ; $4200
	jr nz, .draw ; $4201
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
	ld_slot hl, FarPtr_UpdateAllObjSprites ; $4220
	call FarCallVector ; $4223
.draw:
	ld a, [wMatchDrawFrozen] ; $4226
	and a ; $4229
	jr nz, .stepTargets ; $422a
	call DrawActorsByDepth ; $422c
.stepTargets:
	ld a, [wMatchSimFrozen] ; $422f
	and a ; $4232
	jr nz, .drawMarkers ; $4233
	farcall UpdateMinigameTargets ; $4235
.drawMarkers:
	ld a, [wMatchDrawFrozen] ; $4238
	and a ; $423b
	jr nz, .done ; $423c
	call DrawMarkersAndShadows ; $423e
.done:
	ret ; $4241
TickRallyTimers:
	ld a, [wBallCrossedNetFlag] ; $4242
	and a ; $4245
	ret z ; $4246
	ld hl, wRallyNetFrames ; $4247
	ld a, [hl] ; $424a
	cp $64 ; $424b
	jr nc, .checkFirstShot ; $424d
	inc [hl] ; $424f
.checkFirstShot:
	ld a, [wRallyLength] ; $4250
	cp $01 ; $4253
	jr nz, .modeHook ; $4255
	ld a, [wPointOutcome] ; $4257
	and a ; $425a
	jr nz, .checkBounce ; $425b
	ld a, $01 ; $425d
	ld [wCameraFollowBall], a ; $425f
.checkBounce:
	ld a, [wBallHasBouncedFlag] ; $4262
	and a ; $4265
	jr z, .modeHook ; $4266
	ld hl, SetCharStateForRallyTick ; $4268
	call ForEachCharBank ; $426b
.modeHook:
	ld d, $06 ; $426e
	call CallModeHook ; $4270
	ret ; $4273
SetCharStateForRallyTick:
	ld a, CHARSTATE_STANDBY ; $4274
	call SetCharState ; $4276
	ret ; $4279
HandleBallHitEvent:
	ld a, [wBallHitEvent] ; $427a
	and a ; $427d
	ret z ; $427e
	ld hl, wRallyLength ; $427f
	ld a, [hl] ; $4282
	cp $64 ; $4283
	jr nc, .clearEvent ; $4285
	inc [hl] ; $4287
.clearEvent:
	xor a ; $4288
	ld [wBallHitEvent], a ; $4289
	ld [wBallHasBouncedFlag], a ; $428c
	ld [wLandingMarkerActive], a ; $428f
	call StartLandingMarker ; $4292
	call StartHitEffect ; $4295
	wram_bank WRAM_CHAR3 ; $4298
	call SetCharStateOnBallHit ; $429e
	wram_bank WRAM_CHAR2 ; $42a1
	call SetCharStateOnBallHit ; $42a7
	wram_bank WRAM_TEXT ; $42aa
	call SetCharStateOnBallHit ; $42b0
	wram_bank WRAM_ACTORS ; $42b3
	call SetCharStateOnBallHit ; $42b9
	call DetectServeAceOutcome ; $42bc
	ld d, $04 ; $42bf
	call CallModeHook ; $42c1
	xor a ; $42c4
	ld [wBallBounceCount], a ; $42c5
	ld a, [wRallyLength] ; $42c8
	cp $01 ; $42cb
	jr z, .specialShot ; $42cd
	cp $02 ; $42cf
	jr z, .resetCourtLimits ; $42d1
	ret ; $42d3
.specialShot:
	ld a, [wSpecialShotFlag] ; $42d4
	and a ; $42d7
	jr z, .done ; $42d8
	ld a, $0e ; $42da
	farcall ShowCourtBanner ; $42dc
	ld a, [wServingCharCourtPos] ; $42df
	and $02 ; $42e2
	ld de, $f0d8 ; $42e4
	jr z, .placeEffect ; $42e7
	ld de, $f000 ; $42e9
.placeEffect:
	ld bc, wObjSlot3 ; $42ec
	farcall SetObjPosition ; $42ef
.done:
	ret ; $42f2
.resetCourtLimits:
	ld de, $fb20 ; $42f3
	ld hl, wCourtLimitDepth ; $42f6
	ld a, e ; $42f9
	ld [hl+], a ; $42fa
	ld [hl], d ; $42fb
	ld a, [wMatchIsDoubles] ; $42fc
	and a ; $42ff
	ld de, $fe50 ; $4300
	jr z, .doneLimits ; $4303
	ld de, $fdc0 ; $4305
.doneLimits:
	ld hl, wCourtLimitX ; $4308
	ld a, e ; $430b
	ld [hl+], a ; $430c
	ld [hl], d ; $430d
	ret ; $430e
SetCharStateOnBallHit:
	ld a, [wCharState] ; $430f
	ld_hl_indexed SetCharStateOnBallHitTable ; $4312
	ld a, [hl] ; $4319
	call SetCharState ; $431a
	ret ; $431d
SetCharStateOnBallHitTable:
	; $431e, 8 bytes (bytes:8)
	db $00, $02, $01, $02, $02, $01, $06, $07 ; 0x00
DetectServeAceOutcome:
	ld a, [wRallyLength] ; $4326
	cp $02 ; $4329
	jr nz, .done ; $432b
	ld a, [wPointOutcome] ; $432d
	and a ; $4330
	jr nz, .done ; $4331
	ld b, POINTOUTCOME_WRONG_RECEIVER ; $4333
	ld c, $ff ; $4335
	ld a, [wLastShotServeRole] ; $4337
	cp $01 ; $433a
	jr nz, .setOutcome ; $433c
	ld b, POINTOUTCOME_SERVE_VOLLEYED ; $433e
	ld c, $ff ; $4340
	ld a, [wBallBounceCount] ; $4342
	and a ; $4345
	jr z, .setOutcome ; $4346
.done:
	ret ; $4348
.setOutcome:
	ld a, b ; $4349
	ld [wPointOutcome], a ; $434a
	ld a, c ; $434d
	ld [wPointOutcomeSide], a ; $434e
	ret ; $4351
HandleBallBounceEvent:
	ld a, [wBallBounceEvent] ; $4352
	and a ; $4355
	ret z ; $4356
	ld a, [wBallBounceCount] ; $4357
	cp $02 ; $435a
	jr nc, .clearEvent ; $435c
	sound SFX_BALL_BOUNCE ; $435e
.clearEvent:
	ld hl, wBallBounceCount ; $4360
	ld a, [hl] ; $4363
	cp $0a ; $4364
	jr nc, .done ; $4366
	inc [hl] ; $4368
.done:
	xor a ; $4369
	ld [wLandingMarkerActive], a ; $436a
	call StartBounceEffect ; $436d
	call EvaluateBounceOutcome ; $4370
	ld d, $05 ; $4373
	call CallModeHook ; $4375
	ret ; $4378
EvaluateBounceOutcome:
	ld a, [wRallyLength] ; $4379
	and a ; $437c
	jr z, .done ; $437d
	ld a, [wPointOutcome] ; $437f
	and a ; $4382
	jr nz, .done ; $4383
	ld b, POINTOUTCOME_WINNER ; $4385
	ld c, $01 ; $4387
	ld a, [wBallBounceCount] ; $4389
	cp $01 ; $438c
	jr nz, .setOutcome ; $438e
	ld b, POINTOUTCOME_NET ; $4390
	ld c, $ff ; $4392
	ld hl, wBallQuadrantAtHit ; $4394
	ld a, [wBallCourtQuadrant] ; $4397
	xor [hl] ; $439a
	and $02 ; $439b
	jr z, .setOutcome ; $439d
	call CheckBallOutOfBounds ; $439f
	ld b, POINTOUTCOME_OUT ; $43a2
	ld c, $ff ; $43a4
	and a ; $43a6
	jr nz, .setOutcome ; $43a7
	ld a, [wRallyLength] ; $43a9
	cp $01 ; $43ac
	jr nz, .done ; $43ae
	ld b, POINTOUTCOME_OUT ; $43b0
	ld c, $ff ; $43b2
	ld hl, wBallQuadrantAtHit ; $43b4
	ld a, [wBallCourtQuadrant] ; $43b7
	xor [hl] ; $43ba
	and $01 ; $43bb
	jr z, .setOutcome ; $43bd
	ld b, POINTOUTCOME_LET ; $43bf
	ld c, $00 ; $43c1
	ld a, [wBallHasBouncedFlag] ; $43c3
	and a ; $43c6
	jr nz, .setOutcome ; $43c7
.done:
	ret ; $43c9
.setOutcome:
	ld a, b ; $43ca
	ld [wPointOutcome], a ; $43cb
	ld a, c ; $43ce
	ld [wPointOutcomeSide], a ; $43cf
	ret ; $43d2
HandleBallTouchCharEvent:
	ld a, [wBallTouchCharFlag] ; $43d3
	and a ; $43d6
	ret z ; $43d7
	xor a ; $43d8
	ld [wBallTouchCharFlag], a ; $43d9
	sound SFX_BALL_CONTACT ; $43dc
	call StartBallTouchCharEffect ; $43de
	call ApplyBallTouchOutcome ; $43e1
	ret ; $43e4
ApplyBallTouchOutcome:
	ld a, [wPointOutcome] ; $43e5
	and a ; $43e8
	jr nz, .done ; $43e9
	ld a, POINTOUTCOME_BALL_HIT_PLAYER ; $43eb
	ld [wPointOutcome], a ; $43ed
	ld a, $01 ; $43f0
	ld [wPointOutcomeSide], a ; $43f2
.done:
	ret ; $43f5
AdvanceMatchRng:
	push hl ; $43f6
	ld a, [wMatchRngState] ; $43f7
	add $73 ; $43fa
	ld hl, wBallHeightFrac + 1 ; $43fc
	add [hl] ; $43ff
	ld hl, wBallXFrac + 1 ; $4400
	add [hl] ; $4403
	ld hl, wBallDepthFrac + 1 ; $4404
	add [hl] ; $4407
	ld [wMatchRngState], a ; $4408
	pop hl ; $440b
	ret ; $440c
ReadMatchInputHeld:
	ldh a, [hLinkExchangeActive] ; $440d
	and a ; $440f
	jr nz, ReadScriptedMatchInput ; $4410
	ldh a, [hPlayerInputFlags] ; $4412
	ret ; $4414
ReadMatchInputPressed:
	ldh a, [hLinkExchangeActive] ; $4415
	and a ; $4417
	jr nz, ReadScriptedMatchInput ; $4418
	ldh a, [hInputRisingEdge] ; $441a
	ret ; $441c
ReadMatchInputRepeat:
	ldh a, [hLinkExchangeActive] ; $441d
	and a ; $441f
	jr nz, ReadScriptedMatchInput ; $4420
	ldh a, [hInputPressed] ; $4422
	ret ; $4424
