SECTION "ROM Bank $0a", ROMX[$4000], BANK[$0a]

	farptr BeginCutsceneScriptMode ; $4000
	farptr EndCutsceneScriptMode ; $4002
	farptr WaitScriptFrames ; $4004
	farptr ScriptRespawnLocationActors ; $4006
	farptr ScriptShowSpeakerDialogue ; $4008
	farptr ScriptShowSpeakerDialogueRestoreBG ; $400a
	farptr ScriptCloseDialogueWindow ; $400c
	farptr InitDialogueTextCursor ; $400e
	farptr AdvanceDialogueTextCursor ; $4010
	farptr RunDialogueYesNoPrompt ; $4012
	farptr ScriptSkipSpeakerDialogue ; $4014
	farptr GetActorStateAddr ; $4016
	farptr ScriptSetActorMoveSpeed ; $4018
	farptr ScriptSetActorScript ; $401a
	farptr SetActorNullScript ; $401c
	farptr WaitActorScriptDone ; $401e
	farptr ScriptWaitActorMoveDone ; $4020
	farptr ScriptSetActorPosition ; $4022
	farptr ScriptSetActorMoveTarget ; $4024
	farptr MoveActorTowardPoint ; $4026
	farptr MoveActorByDelta ; $4028
	farptr MoveActorByAngle ; $402a
	farptr ScriptSetActorFacingLock ; $402c
	farptr SetActorFacing ; $402e
	farptr FaceActorTowardActor ; $4030
	farptr FaceActorsTowardEachOther ; $4032
	farptr ScriptSetActorAnimation ; $4034
	farptr ScriptWaitActorIdle ; $4036
	farptr SetPlayerMoveSpeed ; $4038
	farptr MovePlayerToPosition ; $403a
	farptr MovePlayerToActor ; $403c
	farptr WaitPlayerMoveDone ; $403e
	farptr SetScreenShake ; $4040
	farptr ScriptSetActorJumpVelocity ; $4042
	farptr ScriptWaitActorJumpDone ; $4044
	farptr RunMenuFromText ; $4046
	farptr SetActorActive ; $4048
	farptr InitStoryMatchSettings ; $404a
	farptr RunStoryMatch ; $404c
	farptr RestoreOverworldAfterMatch ; $404e
	farptr SetMatchDoublesMode ; $4050
	farptr SetStoryMatchOpponent ; $4052
	farptr SetCurrentlyUsedCourt ; $4054
	farptr SetMatchNumberOfSets ; $4056
	farptr SetMatchNumberOfGames ; $4058
	farptr LoadMatchSettingsFromTable ; $405a
	farptr RunStoryModeOverworld ; $405c
	farptr InitLocationActors ; $405e
	farptr WriteStoryStateWord ; $4060
	farptr SaveStoryReturnPoint ; $4062
	farptr RestoreStoryReturnPoint ; $4064
	farptr GetStoryLocationCount ; $4066
	farptr LoadStoryObjPalettes ; $4068
	farptr InitSceneScroll ; $406a
	farptr LoadStorySceneGraphics ; $406c
	farptr CopySceneTilemapToVram ; $406e
	farptr UpdateSceneScroll ; $4070
	farptr InitSceneViewer ; $4072
	farptr RunSceneSelectDebugMenu ; $4074
	farptr CopyScrolledSceneTilemapToVram ; $4076
	farptr LoadAndDisplayScene ; $4078
	farptr InitSceneTileAnimations ; $407a
	farptr StopSceneTileAnimations ; $407c
	farptr CopySceneTilemapRect ; $407e
	farptr CopyCollisionMapRect ; $4080
	farptr CopyBehaviorMapRect ; $4082
	farptr ReadCollisionMapCell ; $4084
	farptr ReadBehaviorMapCell ; $4086
	farptr WriteCollisionMapCell ; $4088
	farptr WriteBehaviorMapCell ; $408a
	farptr LoadCourtSceneGraphics ; $408c
	farptr UpdateSceneViewerScroll ; $408e
	farptr ShowLocationNamePopup ; $4090
	farptr CopySceneTilemapChunk ; $4092
	farptr ClearStatusSetupMenuEntry ; $4094
	farptr InitMinigameTargets ; $4096
	farptr UpdateMinigameTargets ; $4098
	farptr SpawnMinigameTargetFormation ; $409a
	farptr DrawNumberWithSprites ; $409c
	farptr DeflectBallOffMinigameTarget ; $409e
	farptr StopSceneScrollTask ; $40a0
	farptr RunEndingCreditsSequence ; $40a2
ToggleCutsceneFastForward:
	push af ; $40a4
	push bc ; $40a5
	push de ; $40a6
	push hl ; $40a7
	ldh a, [hInputRisingEdge] ; $40a8
	and PADF_START ; $40aa
	jr z, .done ; $40ac
	test_flag FLAG_CUTSCENE_FAST_FORWARD ; $40ae
	jr z, .enableFastForward ; $40b1
	clear_flag FLAG_CUTSCENE_FAST_FORWARD ; $40b3
	ld a, [wMessageSpeed] ; $40b6
	or $80 ; $40b9
	ld [wMessageSpeed], a ; $40bb
	jr .done ; $40be
.enableFastForward:
	set_flag FLAG_CUTSCENE_FAST_FORWARD ; $40c0
	ld a, [wMessageSpeed] ; $40c3
	and $7f ; $40c6
	ld [wMessageSpeed], a ; $40c8
.done:
	pop hl ; $40cb
	pop de ; $40cc
	pop bc ; $40cd
	pop af ; $40ce
	ret ; $40cf
BeginCutsceneScriptMode:
	push af ; $40d0
	push bc ; $40d1
	push de ; $40d2
	push hl ; $40d3
	ldh a, [hWramBank] ; $40d4
	push af ; $40d6
	wram_bank $05 ; $40d7
	pop af ; $40dd
	wram_bank ; $40de
	ld a, $ff ; $40e2
	ld [wScreenShakeMagnitude], a ; $40e4
	xor a ; $40e7
	ld [wScreenShakeOffsetX], a ; $40e8
	ld [wScreenShakeOffsetY], a ; $40eb
	ld a, $01 ; $40ee
	call SetActorNullScript ; $40f0
	ldh a, [hDebugStepMode] ; $40f3
	or a ; $40f5
	jr z, .done ; $40f6
	ld a, $01 ; $40f8
	ld hl, ToggleCutsceneFastForward ; $40fa
	call RegisterFrameTask ; $40fd
.done:
	pop hl ; $4100
	pop de ; $4101
	pop bc ; $4102
	pop af ; $4103
	ret ; $4104
EndCutsceneScriptMode:
	push af ; $4105
	push bc ; $4106
	push de ; $4107
	push hl ; $4108
	xor a ; $4109
	ld [wScreenShakeOffsetX], a ; $410a
	ld [wScreenShakeOffsetY], a ; $410d
	ld bc, wActors + 1 * ACTOR_SIZE ; $4110
	ld de, wActors ; $4113
	farcall AttachActorWaypointFollower ; $4116
	ld hl, ToggleCutsceneFastForward ; $4119
	call UnregisterFrameTask ; $411c
	clear_flag FLAG_CUTSCENE_FAST_FORWARD ; $411f
	ldh a, [hWramBank] ; $4122
	push af ; $4124
	wram_bank $04 ; $4125
	ld a, [wActors + 20] ; $412b
	ld [wPlayerMoveAngle], a ; $412e
	pop af ; $4131
	wram_bank ; $4132
	pop hl ; $4136
	pop de ; $4137
	pop bc ; $4138
	pop af ; $4139
	ret ; $413a
Unused_0a_0:
	; $413b, 4 bytes (bytes:4)
	db $0b, $0c, $fe, $ff ; 0x00
WaitScriptFrames:
	push af ; $413f
	push bc ; $4140
	test_flag FLAG_CUTSCENE_FAST_FORWARD ; $4141
	jr z, .wait ; $4144
	ld a, $02 ; $4146
.wait:
	or a ; $4148
	jr z, .done ; $4149
	ld c, a ; $414b
	call WaitFrames ; $414c
	pop bc ; $414f
	pop af ; $4150
.done:
	ret ; $4151
ScriptRespawnLocationActors:
	farcall InitLocationActors ; $4152
	ret ; $4155
InitDialogueTextCursor:
	push af ; $4156
	ldh a, [hWramBank] ; $4157
	push af ; $4159
	wram_bank $05 ; $415a
	farcall SetActiveWindowTextId ; $4160
	ld a, l ; $4163
	ld [wScriptDialogueTextId], a ; $4164
	ld a, h ; $4167
	ld [wScriptDialogueTextId + 1], a ; $4168
	pop af ; $416b
	wram_bank ; $416c
	pop af ; $4170
	ret ; $4171
AdvanceDialogueTextCursor:
	push af ; $4172
	push hl ; $4173
	push de ; $4174
	ldh a, [hWramBank] ; $4175
	push af ; $4177
	wram_bank $05 ; $4178
	ld hl, wScriptDialogueTextId ; $417e
	ld a, [hl+] ; $4181
	ld d, [hl] ; $4182
	ld e, a ; $4183
	inc de ; $4184
	dec hl ; $4185
	ld a, e ; $4186
	ld [hl+], a ; $4187
	ld [hl], d ; $4188
	pop af ; $4189
	wram_bank ; $418a
	pop de ; $418e
	pop hl ; $418f
	pop af ; $4190
	ret ; $4191
ScriptShowSpeakerDialogue:
	push af ; $4192
	push hl ; $4193
	ld b, a ; $4194
	ldh a, [hWramBank] ; $4195
	push af ; $4197
	call WaitPlayerMoveDone ; $4198
	wram_bank $05 ; $419b
	ld hl, wScriptDialogueTextId ; $41a1
	ld a, [hl+] ; $41a4
	ld h, [hl] ; $41a5
	ld l, a ; $41a6
	test_flag FLAG_CUTSCENE_FAST_FORWARD ; $41a7
	jr nz, .advanceTextId ; $41aa
	ld a, b ; $41ac
	farcall ShowSpeakerDialogue ; $41ad
.advanceTextId:
	inc hl ; $41b0
	ld a, l ; $41b1
	ld [wScriptDialogueTextId], a ; $41b2
	ld a, h ; $41b5
	ld [wScriptDialogueTextId + 1], a ; $41b6
	pop af ; $41b9
	wram_bank ; $41ba
	pop hl ; $41be
	pop af ; $41bf
	ret ; $41c0
ScriptShowSpeakerDialogueRestoreBG:
	push af ; $41c1
	push hl ; $41c2
	ld b, a ; $41c3
	ldh a, [hWramBank] ; $41c4
	push af ; $41c6
	call WaitPlayerMoveDone ; $41c7
	wram_bank $05 ; $41ca
	ld a, [wScriptDialogueTextId] ; $41d0
	ld l, a ; $41d3
	ld a, [wScriptDialogueTextId + 1] ; $41d4
	ld h, a ; $41d7
	test_flag FLAG_CUTSCENE_FAST_FORWARD ; $41d8
	jr nz, .advanceTextId ; $41db
	ld a, b ; $41dd
	farcall ShowSpeakerDialogueRestoreBG ; $41de
.advanceTextId:
	inc hl ; $41e1
	ld a, l ; $41e2
	ld [wScriptDialogueTextId], a ; $41e3
	ld a, h ; $41e6
	ld [wScriptDialogueTextId + 1], a ; $41e7
	pop af ; $41ea
	wram_bank ; $41eb
	pop hl ; $41ef
	pop af ; $41f0
	ret ; $41f1
ScriptCloseDialogueWindow:
	farcall CloseActiveDialogueWindow ; $41f2
	ret ; $41f5
RunDialogueYesNoPrompt:
	push bc ; $41f6
	push de ; $41f7
	push hl ; $41f8
	ldh a, [hWramBank] ; $41f9
	push af ; $41fb
	wram_bank $05 ; $41fc
	call FindDialogueChoiceMarker ; $4202
	ld a, [wTextRedrawGuard] ; $4205
	push af ; $4208
	xor a ; $4209
	ld [wTextRedrawGuard], a ; $420a
	call ShowYesNoPromptWindow ; $420d
	farcall RenderMenuWindowText ; $4210
	farcall RunMenuSelection ; $4213
	ld b, a ; $4216
	call FindDialogueChoiceMarker ; $4217
	ld a, [wMenuWindowId] ; $421a
	farcall CloseWindow ; $421d
	xor a ; $4220
	ld [wTextResumePtr + 1], a ; $4221
	ld a, $ff ; $4224
	ld [wMenuWindowId], a ; $4226
	pop af ; $4229
	ld [wTextRedrawGuard], a ; $422a
	pop af ; $422d
	wram_bank ; $422e
	ld a, b ; $4232
	pop hl ; $4233
	pop de ; $4234
	pop bc ; $4235
	ret ; $4236
ShowYesNoPromptWindow:
	push af ; $4237
	push bc ; $4238
	push de ; $4239
	push hl ; $423a
	ldh a, [hWramBank] ; $423b
	push af ; $423d
	ld a, [wDialogueSpeaker] ; $423e
	ld b, a ; $4241
	and $7f ; $4242
	ld e, a ; $4244
	rl b ; $4245
	jr nc, .fromActor ; $4247
	cp $09 ; $4249
	jr c, .lowerRow ; $424b
	ld e, $01 ; $424d
	jr .open ; $424f
.lowerRow:
	ld e, $0a ; $4251
	jr .open ; $4253
.fromActor:
	call GetActorStateAddr ; $4255
	ld a, [wCameraY + 1] ; $4258
	ld b, a ; $425b
	ld a, l ; $425c
	ldh [hActorPtr], a ; $425d
	ld a, h ; $425f
	ldh [hActorPtr + 1], a ; $4260
	wram_bank $04 ; $4262
	ld hl, hActorPtr ; $4268
	ld a, [hl+] ; $426b
	ld h, [hl] ; $426c
	add $0c ; $426d
	ld l, a ; $426f
	inc hl ; $4270
	inc hl ; $4271
	inc hl ; $4272
	ld a, [hl] ; $4273
	sub b ; $4274
	cp $0a ; $4275
	jr c, .upperRow ; $4277
	ld e, $0a ; $4279
	jr .open ; $427b
.upperRow:
	ld e, $01 ; $427d
.open:
	pop af ; $427f
	wram_bank ; $4280
	ld d, $02 ; $4284
	ld hl, Text_30_26 ; $4286
	farcall CreateMenuWindowFromText ; $4289
	pop hl ; $428c
	pop de ; $428d
	pop bc ; $428e
	pop af ; $428f
	ret ; $4290
FindDialogueChoiceMarker:
	push af ; $4291
	push bc ; $4292
	push de ; $4293
	push hl ; $4294
	ld hl, wScriptDialogueTextId ; $4295
	ld a, [hl+] ; $4298
	ld h, [hl] ; $4299
	ld l, a ; $429a
	dec hl ; $429b
	xor a ; $429c
	farcall AddTextIdOffset ; $429d
	farcall FetchDialogueText ; $42a0
	ld hl, wTextBuffer ; $42a3
	ld bc, $0180 ; $42a6
	ld de, $0000 ; $42a9
.scanLoop:
	ld a, $00 ; $42ac
	cp [hl] ; $42ae
	jr z, .storeMarker ; $42af
	ld a, $02 ; $42b1
	cp [hl] ; $42b3
	inc hl ; $42b4
	jr nz, .next ; $42b5
	ld d, h ; $42b7
	ld e, l ; $42b8
.next:
	dec bc ; $42b9
	ld a, b ; $42ba
	or c ; $42bb
	jr nz, .scanLoop ; $42bc
.storeMarker:
	ld a, d ; $42be
	or e ; $42bf
	jr z, .done ; $42c0
	ld a, e ; $42c2
	ld [wTextResumePtr], a ; $42c3
	ld a, d ; $42c6
	ld [wTextResumePtr + 1], a ; $42c7
.done:
	pop hl ; $42ca
	pop de ; $42cb
	pop bc ; $42cc
	pop af ; $42cd
	ret ; $42ce
RunMenuFromText:
	push bc ; $42cf
	push de ; $42d0
	push hl ; $42d1
	farcall CreateMenuWindowFromText ; $42d2
	ld b, a ; $42d5
	farcall RestoreShadowTilemap ; $42d6
	farcall RenderMenuWindowText ; $42d9
	farcall RunMenuSelection ; $42dc
	ld c, a ; $42df
	ld a, b ; $42e0
	farcall CloseWindow ; $42e1
	ld a, c ; $42e4
	pop hl ; $42e5
	pop de ; $42e6
	pop bc ; $42e7
	ret ; $42e8
ScriptSkipSpeakerDialogue:
	push af ; $42e9
	push hl ; $42ea
	ldh a, [hWramBank] ; $42eb
	push af ; $42ed
	wram_bank $05 ; $42ee
	ld a, [wScriptDialogueTextId] ; $42f4
	ld l, a ; $42f7
	ld a, [wScriptDialogueTextId + 1] ; $42f8
	ld h, a ; $42fb
	test_flag FLAG_CUTSCENE_FAST_FORWARD ; $42fc
	jr nz, .advanceTextId ; $42ff
.advanceTextId:
	inc hl ; $4301
	ld a, l ; $4302
	ld [wScriptDialogueTextId], a ; $4303
	ld a, h ; $4306
	ld [wScriptDialogueTextId + 1], a ; $4307
	pop af ; $430a
	wram_bank ; $430b
	pop hl ; $430f
	pop af ; $4310
	ret ; $4311
GetActorStateAddr:
	ld hl, wActors ; $4312
	cp $18 ; $4315
	jr nc, .haveAddr ; $4317
	ld h, a ; $4319
	xor a ; $431a
	srl h ; $431b
	rra ; $431d
	srl h ; $431e
	rra ; $4320
	ld l, a ; $4321
	ld a, $d0 ; $4322
	add h ; $4324
	ld h, a ; $4325
.haveAddr:
	wram_bank $04 ; $4326
	push hl ; $432c
	ld a, $20 ; $432d
	add l ; $432f
	ld l, a ; $4330
	jr nc, .readActive ; $4331
	inc h ; $4333
.readActive:
	ld a, [hl] ; $4334
	cp $00 ; $4335
	pop hl ; $4337
	inc h ; $4338
	dec h ; $4339
	ret ; $433a
ScriptSetActorMoveSpeed:
	call GetActorStateAddr ; $433b
	ret z ; $433e
	wram_bank $04 ; $433f
	ld a, $06 ; $4345
	add l ; $4347
	ld l, a ; $4348
	jr nc, .store ; $4349
	inc h ; $434b
.store:
	ld a, c ; $434c
	ld [hl+], a ; $434d
	ld [hl], b ; $434e
	ret ; $434f
ScriptSetActorScript:
	call GetActorStateAddr ; $4350
	ld a, b ; $4353
	push af ; $4354
	wram_bank $04 ; $4355
	pop af ; $435b
	ld c, l ; $435c
	ld b, h ; $435d
	ld l, e ; $435e
	ld h, d ; $435f
	farcall SetActorScript ; $4360
	ret ; $4363
SetActorNullScript:
	call GetActorStateAddr ; $4364
	ld c, l ; $4367
	ld b, h ; $4368
	ld hl, ActorScript_0a ; $4369
	ldh a, [hRomBank] ; $436c
	farcall SetActorScript ; $436e
	ret ; $4371
WaitActorScriptDone:
	call GetActorStateAddr ; $4372
	push af ; $4375
	push bc ; $4376
	ld bc, $0258 ; $4377
.waitLoop:
	call CheckActorScriptEnd ; $437a
	jr z, .done ; $437d
	call AdvanceFrame ; $437f
	dec bc ; $4382
	ld a, c ; $4383
	or b ; $4384
	jr nz, .waitLoop ; $4385
.done:
	pop bc ; $4387
	pop af ; $4388
	ret ; $4389
CheckActorScriptEnd:
	inc h ; $438a
	dec h ; $438b
	ret z ; $438c
	push de ; $438d
	wram_bank $04 ; $438e
	push hl ; $4394
	ld a, [hl+] ; $4395
	ld e, a ; $4396
	ld a, [hl+] ; $4397
	ld d, a ; $4398
	ld a, [hl] ; $4399
	ld l, e ; $439a
	ld h, d ; $439b
	call FarReadByte ; $439c
	pop hl ; $439f
	cp $00 ; $43a0
	pop de ; $43a2
	ret ; $43a3
ScriptWaitActorMoveDone:
	call GetActorStateAddr ; $43a4
	farcall WaitActorMoveDone ; $43a7
	ret ; $43aa
ScriptWaitActorJumpDone:
	call GetActorStateAddr ; $43ab
	farcall WaitActorJumpDone ; $43ae
	ret ; $43b1
ScriptSetActorPosition:
	add sp, -4 ; $43b2
	ld hl, sp + 0 ; $43b4
	ld [hl], c ; $43b6
	inc hl ; $43b7
	ld [hl], b ; $43b8
	inc hl ; $43b9
	ld [hl], e ; $43ba
	inc hl ; $43bb
	ld [hl], d ; $43bc
	ld hl, sp + 0 ; $43bd
	ld c, l ; $43bf
	ld b, h ; $43c0
	call GetActorStateAddr ; $43c1
	jr z, .done ; $43c4
	ld a, l ; $43c6
	ldh [hActorPtr], a ; $43c7
	ld a, h ; $43c9
	ldh [hActorPtr + 1], a ; $43ca
	wram_bank $04 ; $43cc
	call SetActorPositionRaw ; $43d2
.done:
	add sp, 4 ; $43d5
	ret ; $43d7
SetActorPositionRaw:
	push bc ; $43d8
	push af ; $43d9
	ld hl, hActorPtr ; $43da
	ld a, [hl+] ; $43dd
	ld h, [hl] ; $43de
	add $0c ; $43df
	ld l, a ; $43e1
	ld e, l ; $43e2
	ld d, h ; $43e3
	pop af ; $43e4
	ld l, c ; $43e5
	ld h, b ; $43e6
	ld bc, $0004 ; $43e7
	call CopyMemoryBC ; $43ea
	pop bc ; $43ed
	ld hl, hActorPtr ; $43ee
	ld a, [hl+] ; $43f1
	ld h, [hl] ; $43f2
	add $05 ; $43f3
	ld l, a ; $43f5
	res 7, [hl] ; $43f6
	ret ; $43f8
ScriptSetActorMoveTarget:
	add sp, -4 ; $43f9
	ld hl, sp + 0 ; $43fb
	ld [hl], c ; $43fd
	inc hl ; $43fe
	ld [hl], b ; $43ff
	inc hl ; $4400
	ld [hl], e ; $4401
	inc hl ; $4402
	ld [hl], d ; $4403
	ld hl, sp + 0 ; $4404
	ld c, l ; $4406
	ld b, h ; $4407
	call GetActorStateAddr ; $4408
	jr z, .done ; $440b
	ld a, l ; $440d
	ldh [hActorPtr], a ; $440e
	ld a, h ; $4410
	ldh [hActorPtr + 1], a ; $4411
	wram_bank $04 ; $4413
	call SetActorMoveTargetRaw ; $4419
.done:
	add sp, 4 ; $441c
	ret ; $441e
SetActorMoveTargetRaw:
	push bc ; $441f
	push af ; $4420
	ld hl, hActorPtr ; $4421
	ld a, [hl+] ; $4424
	ld h, [hl] ; $4425
	add $08 ; $4426
	ld l, a ; $4428
	ld e, l ; $4429
	ld d, h ; $442a
	pop af ; $442b
	ld l, c ; $442c
	ld h, b ; $442d
	ld bc, $0004 ; $442e
	call CopyMemoryBC ; $4431
	pop bc ; $4434
	ld hl, hActorPtr ; $4435
	ld a, [hl+] ; $4438
	ld h, [hl] ; $4439
	add $05 ; $443a
	ld l, a ; $443c
	set 7, [hl] ; $443d
	ret ; $443f
MoveActorTowardPoint:
	add sp, -5 ; $4440
	push af ; $4442
	ld a, l ; $4443
	ld hl, sp + 2 ; $4444
	ld [hl], c ; $4446
	inc hl ; $4447
	ld [hl], b ; $4448
	inc hl ; $4449
	ld [hl], e ; $444a
	inc hl ; $444b
	ld [hl], d ; $444c
	inc hl ; $444d
	ld [hl], a ; $444e
	pop af ; $444f
	ld hl, sp + 0 ; $4450
	ld c, l ; $4452
	ld b, h ; $4453
	call GetActorStateAddr ; $4454
	jr z, .done ; $4457
	ld a, l ; $4459
	ldh [hActorPtr], a ; $445a
	ld a, h ; $445c
	ldh [hActorPtr + 1], a ; $445d
	call MoveActorTowardPointRaw ; $445f
.done:
	add sp, 5 ; $4462
	ret ; $4464
MoveActorTowardPointRaw:
	push bc ; $4465
	ld l, c ; $4466
	ld h, b ; $4467
	ld c, [hl] ; $4468
	inc hl ; $4469
	ld b, [hl] ; $446a
	inc hl ; $446b
	push bc ; $446c
	ld c, [hl] ; $446d
	inc hl ; $446e
	ld b, [hl] ; $446f
	inc hl ; $4470
	push bc ; $4471
	ld a, [hl] ; $4472
	push af ; $4473
	push hl ; $4474
	ld hl, hActorPtr ; $4475
	ld a, [hl+] ; $4478
	ld b, [hl] ; $4479
	ld c, a ; $447a
	ld hl, $000c ; $447b
	add hl, bc ; $447e
	ld a, [hl+] ; $447f
	ld h, [hl] ; $4480
	ld l, a ; $4481
	ld a, l ; $4482
	sub e ; $4483
	ld l, a ; $4484
	ld a, h ; $4485
	sbc d ; $4486
	ld h, a ; $4487
	pop de ; $4488
	push hl ; $4489
	ld hl, $000e ; $448a
	add hl, bc ; $448d
	ld a, [hl+] ; $448e
	ld h, [hl] ; $448f
	ld l, a ; $4490
	ld a, l ; $4491
	sub e ; $4492
	ld l, a ; $4493
	ld a, h ; $4494
	sbc d ; $4495
	ld h, a ; $4496
	pop de ; $4497
	call AngleFromVectorCoarse ; $4498
	pop hl ; $449b
	ld l, h ; $449c
	ld h, $00 ; $449d
	call VectorFromLengthAndAngleRaw ; $449f
	pop bc ; $44a2
	add hl, bc ; $44a3
	ld c, l ; $44a4
	ld b, h ; $44a5
	pop hl ; $44a6
	add hl, de ; $44a7
	ld e, l ; $44a8
	ld d, h ; $44a9
	ld hl, hActorPtr ; $44aa
	ld a, [hl+] ; $44ad
	ld h, [hl] ; $44ae
	add $08 ; $44af
	ld l, a ; $44b1
	ld [hl], c ; $44b2
	inc hl ; $44b3
	ld [hl], b ; $44b4
	inc hl ; $44b5
	ld [hl], e ; $44b6
	inc hl ; $44b7
	ld [hl], d ; $44b8
	pop bc ; $44b9
	ld hl, $0005 ; $44ba
	add hl, bc ; $44bd
	ld c, l ; $44be
	ld b, h ; $44bf
	ld hl, hActorPtr ; $44c0
	ld a, [hl+] ; $44c3
	ld h, [hl] ; $44c4
	add $05 ; $44c5
	ld l, a ; $44c7
	set 7, [hl] ; $44c8
	ret ; $44ca
MoveActorByDelta:
	add sp, -4 ; $44cb
	ld hl, sp + 0 ; $44cd
	ld [hl], c ; $44cf
	inc hl ; $44d0
	ld [hl], b ; $44d1
	inc hl ; $44d2
	ld [hl], e ; $44d3
	inc hl ; $44d4
	ld [hl], d ; $44d5
	ld hl, sp + 0 ; $44d6
	ld c, l ; $44d8
	ld b, h ; $44d9
	call GetActorStateAddr ; $44da
	jr z, .done ; $44dd
	ld a, l ; $44df
	ldh [hActorPtr], a ; $44e0
	ld a, h ; $44e2
	ldh [hActorPtr + 1], a ; $44e3
	wram_bank $04 ; $44e5
	call MoveActorByDeltaRaw ; $44eb
.done:
	add sp, 4 ; $44ee
	ret ; $44f0
MoveActorByDeltaRaw:
	push de ; $44f1
	ld l, c ; $44f2
	ld h, b ; $44f3
	ld c, [hl] ; $44f4
	inc hl ; $44f5
	ld b, [hl] ; $44f6
	inc hl ; $44f7
	ld e, c ; $44f8
	ld d, b ; $44f9
	ld c, l ; $44fa
	ld b, h ; $44fb
	ld hl, hActorPtr ; $44fc
	ld a, [hl+] ; $44ff
	ld h, [hl] ; $4500
	add $0c ; $4501
	ld l, a ; $4503
	ld a, [hl+] ; $4504
	ld h, [hl] ; $4505
	ld l, a ; $4506
	add hl, de ; $4507
	ld e, l ; $4508
	ld d, h ; $4509
	ld hl, hActorPtr ; $450a
	ld a, [hl+] ; $450d
	ld h, [hl] ; $450e
	add $08 ; $450f
	ld l, a ; $4511
	ld a, e ; $4512
	ld [hl+], a ; $4513
	ld [hl], d ; $4514
	pop de ; $4515
	ld a, d ; $4516
	ld l, c ; $4517
	ld h, b ; $4518
	ld c, [hl] ; $4519
	inc hl ; $451a
	ld b, [hl] ; $451b
	inc hl ; $451c
	ld e, c ; $451d
	ld d, b ; $451e
	ld c, l ; $451f
	ld b, h ; $4520
	ld hl, hActorPtr ; $4521
	ld a, [hl+] ; $4524
	ld h, [hl] ; $4525
	add $0e ; $4526
	ld l, a ; $4528
	ld a, [hl+] ; $4529
	ld h, [hl] ; $452a
	ld l, a ; $452b
	add hl, de ; $452c
	ld e, l ; $452d
	ld d, h ; $452e
	ld hl, hActorPtr ; $452f
	ld a, [hl+] ; $4532
	ld h, [hl] ; $4533
	add $0a ; $4534
	ld l, a ; $4536
	ld a, e ; $4537
	ld [hl+], a ; $4538
	ld [hl], d ; $4539
	ld hl, hActorPtr ; $453a
	ld a, [hl+] ; $453d
	ld h, [hl] ; $453e
	add $05 ; $453f
	ld l, a ; $4541
	set 7, [hl] ; $4542
	ret ; $4544
MoveActorByAngle:
	add sp, -3 ; $4545
	ld hl, sp + 0 ; $4547
	ld [hl], b ; $4549
	inc hl ; $454a
	ld [hl], e ; $454b
	inc hl ; $454c
	ld [hl], d ; $454d
	ld hl, sp + 0 ; $454e
	ld c, l ; $4550
	ld b, h ; $4551
	call GetActorStateAddr ; $4552
	jr z, .done ; $4555
	ld a, l ; $4557
	ldh [hActorPtr], a ; $4558
	ld a, h ; $455a
	ldh [hActorPtr + 1], a ; $455b
	wram_bank $04 ; $455d
	call MoveActorByAngleRaw ; $4563
.done:
	add sp, 3 ; $4566
	ret ; $4568
MoveActorByAngleRaw:
	ld a, d ; $4569
	ld l, c ; $456a
	ld h, b ; $456b
	ld a, [hl] ; $456c
	inc bc ; $456d
	push af ; $456e
	push bc ; $456f
	ld a, d ; $4570
	ld l, c ; $4571
	ld h, b ; $4572
	ld c, [hl] ; $4573
	inc hl ; $4574
	ld b, [hl] ; $4575
	ld l, c ; $4576
	ld h, b ; $4577
	pop bc ; $4578
	inc bc ; $4579
	inc bc ; $457a
	pop af ; $457b
	call VectorFromLengthAndAngle ; $457c
	push de ; $457f
	ld e, l ; $4580
	ld d, h ; $4581
	ld hl, hActorPtr ; $4582
	ld a, [hl+] ; $4585
	ld h, [hl] ; $4586
	add $0c ; $4587
	ld l, a ; $4589
	ld a, [hl+] ; $458a
	ld h, [hl] ; $458b
	ld l, a ; $458c
	add hl, de ; $458d
	ld e, l ; $458e
	ld d, h ; $458f
	ld hl, hActorPtr ; $4590
	ld a, [hl+] ; $4593
	ld h, [hl] ; $4594
	add $08 ; $4595
	ld l, a ; $4597
	ld a, e ; $4598
	ld [hl+], a ; $4599
	ld [hl], d ; $459a
	pop de ; $459b
	ld hl, hActorPtr ; $459c
	ld a, [hl+] ; $459f
	ld h, [hl] ; $45a0
	add $0e ; $45a1
	ld l, a ; $45a3
	ld a, [hl+] ; $45a4
	ld h, [hl] ; $45a5
	ld l, a ; $45a6
	add hl, de ; $45a7
	ld e, l ; $45a8
	ld d, h ; $45a9
	ld hl, hActorPtr ; $45aa
	ld a, [hl+] ; $45ad
	ld h, [hl] ; $45ae
	add $0a ; $45af
	ld l, a ; $45b1
	ld a, e ; $45b2
	ld [hl+], a ; $45b3
	ld [hl], d ; $45b4
	ld hl, hActorPtr ; $45b5
	ld a, [hl+] ; $45b8
	ld h, [hl] ; $45b9
	add $05 ; $45ba
	ld l, a ; $45bc
	set 7, [hl] ; $45bd
	ret ; $45bf
ScriptSetActorFacingLock:
	call GetActorStateAddr ; $45c0
	ret z ; $45c3
	ld a, b ; $45c4
	and a ; $45c5
	ld c, l ; $45c6
	ld b, h ; $45c7
	jr nz, .setBit ; $45c8
	ld hl, $0014 ; $45ca
	add hl, bc ; $45cd
	ld a, [hl] ; $45ce
	ld hl, $0034 ; $45cf
	add hl, bc ; $45d2
	ld [hl], a ; $45d3
	ld hl, $0030 ; $45d4
	add hl, bc ; $45d7
	res 0, [hl] ; $45d8
	ret ; $45da
.setBit:
	ld hl, $0030 ; $45db
	add hl, bc ; $45de
	set 0, [hl] ; $45df
	ret ; $45e1
SetActorFacing:
	call GetActorStateAddr ; $45e2
	ret z ; $45e5
	wram_bank $04 ; $45e6
	ld a, $14 ; $45ec
	add l ; $45ee
	ld l, a ; $45ef
	jr nc, .store ; $45f0
	inc h ; $45f2
.store:
	ld [hl], b ; $45f3
	ret ; $45f4
FaceActorTowardActor:
	push af ; $45f5
	push bc ; $45f6
	push de ; $45f7
	push hl ; $45f8
	ld d, a ; $45f9
	call GetActorStateAddr ; $45fa
	jr z, .done ; $45fd
	ld a, b ; $45ff
	call GetActorStateAddr ; $4600
	inc h ; $4603
	dec h ; $4604
	jr z, .done ; $4605
	ld a, l ; $4607
	ldh [hActorPtr], a ; $4608
	ld a, h ; $460a
	ldh [hActorPtr + 1], a ; $460b
	wram_bank $04 ; $460d
	ld hl, hActorPtr ; $4613
	ld a, [hl+] ; $4616
	ld h, [hl] ; $4617
	add $0c ; $4618
	ld l, a ; $461a
	ld c, [hl] ; $461b
	inc hl ; $461c
	ld b, [hl] ; $461d
	inc hl ; $461e
	push bc ; $461f
	ld c, [hl] ; $4620
	inc hl ; $4621
	ld b, [hl] ; $4622
	push bc ; $4623
	ld a, d ; $4624
	call GetActorStateAddr ; $4625
	ld a, l ; $4628
	ldh [hActorPtr], a ; $4629
	ld a, h ; $462b
	ldh [hActorPtr + 1], a ; $462c
	ld hl, hActorPtr ; $462e
	ld a, [hl+] ; $4631
	ld h, [hl] ; $4632
	add $0e ; $4633
	ld l, a ; $4635
	ld a, [hl+] ; $4636
	ld h, [hl] ; $4637
	ld l, a ; $4638
	ld d, h ; $4639
	ld e, l ; $463a
	pop hl ; $463b
	ld a, l ; $463c
	sub e ; $463d
	ld l, a ; $463e
	ld a, h ; $463f
	sbc d ; $4640
	ld h, a ; $4641
	ld b, h ; $4642
	ld c, l ; $4643
	ld hl, hActorPtr ; $4644
	ld a, [hl+] ; $4647
	ld h, [hl] ; $4648
	add $0c ; $4649
	ld l, a ; $464b
	ld a, [hl+] ; $464c
	ld h, [hl] ; $464d
	ld l, a ; $464e
	ld d, h ; $464f
	ld e, l ; $4650
	pop hl ; $4651
	ld a, l ; $4652
	sub e ; $4653
	ld l, a ; $4654
	ld a, h ; $4655
	sbc d ; $4656
	ld h, a ; $4657
	ld d, h ; $4658
	ld e, l ; $4659
	ld h, b ; $465a
	ld l, c ; $465b
	call AngleFromVectorCoarse ; $465c
	push af ; $465f
	ld hl, hActorPtr ; $4660
	ld a, [hl+] ; $4663
	ld h, [hl] ; $4664
	add $14 ; $4665
	ld l, a ; $4667
	pop af ; $4668
	ld [hl], a ; $4669
.done:
	pop hl ; $466a
	pop de ; $466b
	pop bc ; $466c
	pop af ; $466d
	ret ; $466e
FaceActorsTowardEachOther:
	push af ; $466f
	push bc ; $4670
	push de ; $4671
	push hl ; $4672
	ld d, a ; $4673
	call GetActorStateAddr ; $4674
	inc h ; $4677
	dec h ; $4678
	jp z, .done ; $4679
	ld a, b ; $467c
	call GetActorStateAddr ; $467d
	inc h ; $4680
	dec h ; $4681
	jp z, .done ; $4682
	push hl ; $4685
	ld a, l ; $4686
	ldh [hActorPtr], a ; $4687
	ld a, h ; $4689
	ldh [hActorPtr + 1], a ; $468a
	wram_bank $04 ; $468c
	ld hl, hActorPtr ; $4692
	ld a, [hl+] ; $4695
	ld h, [hl] ; $4696
	add $0c ; $4697
	ld l, a ; $4699
	ld c, [hl] ; $469a
	inc hl ; $469b
	ld b, [hl] ; $469c
	inc hl ; $469d
	push bc ; $469e
	ld c, [hl] ; $469f
	inc hl ; $46a0
	ld b, [hl] ; $46a1
	push bc ; $46a2
	ld a, d ; $46a3
	call GetActorStateAddr ; $46a4
	ld a, l ; $46a7
	ldh [hActorPtr], a ; $46a8
	ld a, h ; $46aa
	ldh [hActorPtr + 1], a ; $46ab
	ld hl, hActorPtr ; $46ad
	ld a, [hl+] ; $46b0
	ld h, [hl] ; $46b1
	add $0e ; $46b2
	ld l, a ; $46b4
	ld a, [hl+] ; $46b5
	ld h, [hl] ; $46b6
	ld l, a ; $46b7
	ld d, h ; $46b8
	ld e, l ; $46b9
	pop hl ; $46ba
	ld a, l ; $46bb
	sub e ; $46bc
	ld l, a ; $46bd
	ld a, h ; $46be
	sbc d ; $46bf
	ld h, a ; $46c0
	ld b, h ; $46c1
	ld c, l ; $46c2
	ld hl, hActorPtr ; $46c3
	ld a, [hl+] ; $46c6
	ld h, [hl] ; $46c7
	add $0c ; $46c8
	ld l, a ; $46ca
	ld a, [hl+] ; $46cb
	ld h, [hl] ; $46cc
	ld l, a ; $46cd
	ld d, h ; $46ce
	ld e, l ; $46cf
	pop hl ; $46d0
	ld a, l ; $46d1
	sub e ; $46d2
	ld l, a ; $46d3
	ld a, h ; $46d4
	sbc d ; $46d5
	ld h, a ; $46d6
	ld d, h ; $46d7
	ld e, l ; $46d8
	ld h, b ; $46d9
	ld l, c ; $46da
	call AngleFromVectorCoarse ; $46db
	push af ; $46de
	ld hl, hActorPtr ; $46df
	ld a, [hl+] ; $46e2
	ld h, [hl] ; $46e3
	add $14 ; $46e4
	ld l, a ; $46e6
	pop af ; $46e7
	ld [hl], a ; $46e8
	add $80 ; $46e9
	pop hl ; $46eb
	ld d, a ; $46ec
	ld a, l ; $46ed
	ldh [hActorPtr], a ; $46ee
	ld a, h ; $46f0
	ldh [hActorPtr + 1], a ; $46f1
	ld hl, hActorPtr ; $46f3
	ld a, [hl+] ; $46f6
	ld h, [hl] ; $46f7
	add $14 ; $46f8
	ld l, a ; $46fa
	ld a, d ; $46fb
	ld [hl], a ; $46fc
.done:
	pop hl ; $46fd
	pop de ; $46fe
	pop bc ; $46ff
	pop af ; $4700
	ret ; $4701
ScriptSetActorAnimation:
	call GetActorStateAddr ; $4702
	ld c, l ; $4705
	ld b, h ; $4706
	farcall SetActorAnimationChecked ; $4707
	ret ; $470a
ScriptWaitActorIdle:
	test_flag FLAG_CUTSCENE_FAST_FORWARD ; $470b
	jr nz, .done ; $470e
	call GetActorStateAddr ; $4710
	ld c, l ; $4713
	ld b, h ; $4714
	call WaitActorIdle ; $4715
.done:
	ret ; $4718
ScriptSetActorJumpVelocity:
	call GetActorStateAddr ; $4719
	ret z ; $471c
	wram_bank $04 ; $471d
	ld a, $12 ; $4723
	add l ; $4725
	ld l, a ; $4726
	jr nc, .read ; $4727
	inc h ; $4729
.read:
	ld a, e ; $472a
	ld [hl+], a ; $472b
	ld [hl], d ; $472c
	ret ; $472d
SetActorActive:
	call GetActorStateAddr ; $472e
	ret z ; $4731
	wram_bank $04 ; $4732
	ld a, $20 ; $4738
	add l ; $473a
	ld l, a ; $473b
	jr nc, .read ; $473c
	inc h ; $473e
.read:
	ld [hl], b ; $473f
	ret ; $4740
	ld a, d ; $4741
	or e ; $4742
	ret z ; $4743
	ld a, e ; $4744
	cpl ; $4745
	add $01 ; $4746
	ld e, a ; $4748
	ld a, d ; $4749
	sbc $00 ; $474a
	cpl ; $474c
	ld d, a ; $474d
	add hl, de ; $474e
	ret ; $474f
	inc h ; $4750
	dec h ; $4751
	ret z ; $4752
	push af ; $4753
	push hl ; $4754
	ld a, $16 ; $4755
	add l ; $4757
	ld l, a ; $4758
	ld [hl], e ; $4759
	inc hl ; $475a
	ld [hl], d ; $475b
	pop hl ; $475c
	pop af ; $475d
	ret ; $475e
Unused_0a_1:
	; $475f, 7 bytes (bytes:7)
	db $0c, $ff, $ff, $0b, $0c, $fe, $ff ; 0x00
ActorScript_0a:
	; $4766, 6 bytes (actor_script)
	as_halt
	as_set_field $20, $0000
	as_halt
IsActorBusy:
	xor a ; $476c
	inc h ; $476d
	dec h ; $476e
	ret z ; $476f
	push de ; $4770
	push hl ; $4771
	wram_bank $04 ; $4772
	ld de, $002e ; $4778
	add hl, de ; $477b
	ld a, [hl] ; $477c
	cp $00 ; $477d
	jr z, .busy ; $477f
	cp $01 ; $4781
	jr z, .busy ; $4783
	ld a, $01 ; $4785
	jr .done ; $4787
.busy:
	xor a ; $4789
.done:
	pop hl ; $478a
	pop de ; $478b
	ret ; $478c
WaitActorIdle:
	push af ; $478d
	push bc ; $478e
	ld bc, $00f0 ; $478f
.waitLoop:
	call IsActorBusy ; $4792
	and a ; $4795
	jr z, .done ; $4796
	call AdvanceFrame ; $4798
	dec bc ; $479b
	ld a, b ; $479c
	or c ; $479d
	jr nz, .waitLoop ; $479e
.done:
	pop bc ; $47a0
	pop af ; $47a1
	ret ; $47a2
SetPlayerMoveSpeed:
	push af ; $47a3
	push hl ; $47a4
	wram_bank $04 ; $47a5
	ld hl, wActors + 1 * ACTOR_SIZE + 6 ; $47ab
	ld a, c ; $47ae
	ld [hl+], a ; $47af
	ld [hl], b ; $47b0
	pop hl ; $47b1
	pop af ; $47b2
	ret ; $47b3
MovePlayerToPosition:
	push af ; $47b4
	push bc ; $47b5
	push de ; $47b6
	push hl ; $47b7
	add sp, -4 ; $47b8
	ld hl, sp + 0 ; $47ba
	ld [hl], c ; $47bc
	inc hl ; $47bd
	ld [hl], b ; $47be
	inc hl ; $47bf
	ld [hl], e ; $47c0
	inc hl ; $47c1
	ld [hl], d ; $47c2
	ld hl, sp + 0 ; $47c3
	ld b, h ; $47c5
	ld c, l ; $47c6
	ld d, a ; $47c7
	ld hl, wActors + 1 * ACTOR_SIZE ; $47c8
	ld a, l ; $47cb
	ldh [hActorPtr], a ; $47cc
	ld a, h ; $47ce
	ldh [hActorPtr + 1], a ; $47cf
	wram_bank $04 ; $47d1
	ld a, d ; $47d7
	or a ; $47d8
	jr nz, .waitLoop ; $47d9
	call SetActorMoveTargetRaw ; $47db
	jr .done ; $47de
.waitLoop:
	push af ; $47e0
	push bc ; $47e1
	push de ; $47e2
	push hl ; $47e3
	ld c, $7f ; $47e4
	call BeginFadeOut ; $47e6
	call WaitFadeEnd ; $47e9
	pop hl ; $47ec
	pop de ; $47ed
	pop bc ; $47ee
	pop af ; $47ef
	ld a, l ; $47f0
	ldh [hActorPtr], a ; $47f1
	ld a, h ; $47f3
	ldh [hActorPtr + 1], a ; $47f4
	call SetActorPositionRaw ; $47f6
	call AdvanceFrame ; $47f9
	farcall RestoreShadowTilemap ; $47fc
	ld b, $05 ; $47ff
	call AdvanceFrame ; $4801
	script_fade_in $7f ; $4804
	call WaitFadeEnd ; $4809
.done:
	add sp, 4 ; $480c
	pop hl ; $480e
	pop de ; $480f
	pop bc ; $4810
	pop af ; $4811
	ret ; $4812
MovePlayerToActor:
	cp $ff ; $4813
	ret z ; $4815
	push af ; $4816
	push bc ; $4817
	push de ; $4818
	push hl ; $4819
	push af ; $481a
	wram_bank $04 ; $481b
	pop af ; $4821
	add sp, -4 ; $4822
	ld hl, sp + 0 ; $4824
	call GetActorStateAddr ; $4826
	ld a, l ; $4829
	ldh [hActorPtr], a ; $482a
	ld a, h ; $482c
	ldh [hActorPtr + 1], a ; $482d
	ld hl, hActorPtr ; $482f
	ld a, [hl+] ; $4832
	ld h, [hl] ; $4833
	add $0c ; $4834
	ld l, a ; $4836
	ld a, b ; $4837
	ld c, [hl] ; $4838
	inc hl ; $4839
	ld b, [hl] ; $483a
	inc hl ; $483b
	ld e, [hl] ; $483c
	inc hl ; $483d
	ld d, [hl] ; $483e
	ld hl, sp + 0 ; $483f
	ld [hl], c ; $4841
	inc hl ; $4842
	ld [hl], b ; $4843
	inc hl ; $4844
	ld [hl], e ; $4845
	inc hl ; $4846
	ld [hl], d ; $4847
	ld hl, sp + 0 ; $4848
	ld b, h ; $484a
	ld c, l ; $484b
	ld d, a ; $484c
	ld hl, wActors + 1 * ACTOR_SIZE ; $484d
	ld a, l ; $4850
	ldh [hActorPtr], a ; $4851
	ld a, h ; $4853
	ldh [hActorPtr + 1], a ; $4854
	ld a, d ; $4856
	or a ; $4857
	jr nz, .waitLoop ; $4858
	call SetActorMoveTargetRaw ; $485a
	jr .done ; $485d
.waitLoop:
	push af ; $485f
	push bc ; $4860
	push de ; $4861
	push hl ; $4862
	ld c, $7f ; $4863
	call BeginFadeOut ; $4865
	call WaitFadeEnd ; $4868
	pop hl ; $486b
	pop de ; $486c
	pop bc ; $486d
	pop af ; $486e
	ld a, l ; $486f
	ldh [hActorPtr], a ; $4870
	ld a, h ; $4872
	ldh [hActorPtr + 1], a ; $4873
	call SetActorPositionRaw ; $4875
	call AdvanceFrame ; $4878
	farcall RestoreShadowTilemap ; $487b
	ld b, $05 ; $487e
	call AdvanceFrame ; $4880
	script_fade_in $7f ; $4883
	call WaitFadeEnd ; $4888
.done:
	add sp, 4 ; $488b
	pop hl ; $488d
	pop de ; $488e
	pop bc ; $488f
	pop af ; $4890
	ret ; $4891
WaitPlayerMoveDone:
	push af ; $4892
	push bc ; $4893
	push hl ; $4894
	ld bc, $0258 ; $4895
	ld hl, wActors + 1 * ACTOR_SIZE ; $4898
	ld a, l ; $489b
	ldh [hActorPtr], a ; $489c
	ld a, h ; $489e
	ldh [hActorPtr + 1], a ; $489f
	wram_bank $04 ; $48a1
	ld a, $05 ; $48a7
	add l ; $48a9
	ld l, a ; $48aa
	jr nc, .waitLoop ; $48ab
	inc h ; $48ad
.waitLoop:
	ld a, $01 ; $48ae
	call WaitScriptFrames ; $48b0
	bit 7, [hl] ; $48b3
	jr z, .done ; $48b5
	dec bc ; $48b7
	ld a, c ; $48b8
	or b ; $48b9
	jr nz, .waitLoop ; $48ba
.done:
	pop hl ; $48bc
	pop bc ; $48bd
	pop af ; $48be
	ret ; $48bf
SetScreenShake:
	push af ; $48c0
	push bc ; $48c1
	push de ; $48c2
	push hl ; $48c3
	ld b, a ; $48c4
	ldh a, [hWramBank] ; $48c5
	push af ; $48c7
	ld a, b ; $48c8
	or a ; $48c9
	jr z, .stop ; $48ca
	push af ; $48cc
	ld a, [wScreenShakeMagnitude] ; $48cd
	inc a ; $48d0
	jr nz, .clampMagnitude ; $48d1
	ld a, $01 ; $48d3
	ld hl, UpdateScreenShake ; $48d5
	call RegisterFrameTask ; $48d8
.clampMagnitude:
	pop af ; $48db
	cp $04 ; $48dc
	jr c, .store ; $48de
	ld a, $03 ; $48e0
	jr .store ; $48e2
.stop:
	ld a, [wScreenShakeMagnitude] ; $48e4
	inc a ; $48e7
	ld a, $00 ; $48e8
	jr z, .store ; $48ea
	xor a ; $48ec
	ld [wScreenShakeOffsetX], a ; $48ed
	ld [wScreenShakeOffsetY], a ; $48f0
	ld hl, UpdateScreenShake ; $48f3
	call UnregisterFrameTask ; $48f6
	ld a, $ff ; $48f9
.store:
	ld [wScreenShakeMagnitude], a ; $48fb
	pop af ; $48fe
	wram_bank ; $48ff
	pop hl ; $4903
	pop de ; $4904
	pop bc ; $4905
	pop af ; $4906
	ret ; $4907
UpdateScreenShake:
	push af ; $4908
	push bc ; $4909
	push de ; $490a
	push hl ; $490b
	ld a, [wScreenShakeMagnitude] ; $490c
	ld c, $00 ; $490f
.buildPattern:
	scf ; $4911
	rl c ; $4912
	dec a ; $4914
	jr nz, .buildPattern ; $4915
	call AdvanceRandomSeed ; $4917
	ld a, h ; $491a
	and c ; $491b
	jr nc, .negate ; $491c
	cpl ; $491e
	inc a ; $491f
.negate:
	ld [wScreenShakeOffsetX], a ; $4920
	ld a, l ; $4923
	and c ; $4924
	jr nc, .store ; $4925
	cpl ; $4927
	inc a ; $4928
.store:
	ld [wScreenShakeOffsetY], a ; $4929
	pop hl ; $492c
	pop de ; $492d
	pop bc ; $492e
	pop af ; $492f
	ret ; $4930
InitStoryMatchSettings:
	farcall InitDefaultMatchSettings ; $4931
	ld a, [wStoryModeMainCharacterOverworldSprite] ; $4934
	ld [wMatchPlayerChar], a ; $4937
	xor a ; $493a
	ld [wMatchIsDoubles], a ; $493b
	add $02 ; $493e
	ld [wOnCourtCharCount], a ; $4940
	ld a, MATCHLIST_SINGLES ; $4943
	ld [wCurrentMinigameStoryMatch], a ; $4945
	ld a, CHAR_MARK ; $4948
	ld [wMatchOpponentChar], a ; $494a
	ld a, COURT_GRASS ; $494d
	ld [wCurrentlyUsedCourt], a ; $494f
	ld a, $01 ; $4952
	ld [wMatchTypeNumberOfSets], a ; $4954
	ld a, $02 ; $4957
	ld [wMatchTypeNumberOfGames], a ; $4959
	ld a, $01 ; $495c
	ld [wMatchContext], a ; $495e
	ret ; $4961
RunStoryMatch:
	ld c, $10 ; $4962
	call BeginFadeOut ; $4964
	call WaitFadeEnd ; $4967
	call AssignStoryMatchCharacters ; $496a
	farcall RunMatch ; $496d
	ld a, [wSaveAndQuitRequest] ; $4970
	or a ; $4973
	jr z, .matchAborted ; $4974
	farcall SaveStorySlotWithTimer ; $4976
	ld a, STORYLOC_MAIN_MENU ; $4979
	ld [wStoryModeCurrentLocation], a ; $497b
	ld a, $01 ; $497e
	ld [wStoryModeEntryPoint], a ; $4980
	ld a, $ff ; $4983
	ld [wUnusedExitLocationMirror], a ; $4985
	ld [wStoryModeExitLocationRequest], a ; $4988
	ret ; $498b
.matchAborted:
	xor a ; $498c
	ld [wKeepMatchStatsFlag], a ; $498d
	ret ; $4990
RestoreOverworldAfterMatch:
	ld c, $10 ; $4991
	call BeginFadeOut ; $4993
	call WaitFadeEnd ; $4996
	farcall LoadStoryObjPalettes ; $4999
	call DisableLCDSafely ; $499c
	farcall LoadMenuFontGfx ; $499f
	call EnableLCD ; $49a2
	xor a ; $49a5
	ld [wMatchContext], a ; $49a6
	ret ; $49a9
AssignStoryMatchCharacters:
	ld b, CHAR_STORY_MAIN ; $49aa
	ld c, $00 ; $49ac
	farcall InitCa00RecordFromCharId ; $49ae
	ld a, [wMatchOpponentChar] ; $49b1
	ld b, a ; $49b4
	ld c, $02 ; $49b5
	farcall InitCa00RecordFromCharId ; $49b7
	ld a, [wMatchIsDoubles] ; $49ba
	or a ; $49bd
	jr z, .done ; $49be
	ld b, CHAR_STORY_PARTNER ; $49c0
	ld c, $01 ; $49c2
	farcall InitCa00RecordFromCharId ; $49c4
	ld a, [wMatchOpponentChar] ; $49c7
	ld hl, PairSwapIndexTable_0a ; $49ca
	add l ; $49cd
	ld l, a ; $49ce
	jr nc, .read ; $49cf
	inc h ; $49d1
.read:
	ld b, [hl] ; $49d2
	ld c, $03 ; $49d3
	farcall InitCa00RecordFromCharId ; $49d5
.done:
	ret ; $49d8
PairSwapIndexTable_0a:
	; $49d9, 104 bytes (bytes:16)
	db $02, $03, $00, $01, $05, $04, $07, $06, $09, $08, $0b, $0a, $0c, $0e, $0d, $10 ; 0x00
	db $0f, $14, $13, $12, $11, $14, $17, $16, $19, $18, $1b, $1a, $1d, $1c, $1f, $1e ; 0x10
	db $22, $23, $20, $21, $25, $24, $27, $26, $29, $28, $2b, $2a, $2d, $2c, $2f, $2e ; 0x20
	db $31, $30, $33, $32, $35, $34, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; 0x30
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; 0x40
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $61, $62 ; 0x50
	db $63, $5e, $5f, $60, $00, $00, $00, $00 ; 0x60
SetMatchDoublesMode:
	ld [wMatchIsDoubles], a ; $4a41
	sla a ; $4a44
	add $02 ; $4a46
	ld [wOnCourtCharCount], a ; $4a48
	ret ; $4a4b
SetStoryMatchOpponent:
	ld [wMatchOpponentChar], a ; $4a4c
	ret ; $4a4f
SetCurrentlyUsedCourt:
	ld [wCurrentlyUsedCourt], a ; $4a50
	ret ; $4a53
SetMatchNumberOfSets:
	ld [wMatchTypeNumberOfSets], a ; $4a54
	ret ; $4a57
SetMatchNumberOfGames:
	ld [wMatchTypeNumberOfGames], a ; $4a58
	ret ; $4a5b
LoadMatchSettingsFromTable:
	ld de, SinglesMatchSettingsTable_0a ; $4a5c
	ld a, [wCurrentMinigameStoryMatch] ; $4a5f
	cp MATCHLIST_DOUBLES ; $4a62
	ld a, $00 ; $4a64
	jr nz, .haveTable ; $4a66
	inc a ; $4a68
	ld de, DoublesMatchSettingsTable_0a ; $4a69
.haveTable:
	call SetMatchDoublesMode ; $4a6c
	ld a, [wCurrentMinigameStoryMatch + 1] ; $4a6f
	ld l, a ; $4a72
	ld h, $00 ; $4a73
	add hl, hl ; $4a75
	add hl, hl ; $4a76
	add l ; $4a77
	ld l, a ; $4a78
	jr nc, .readEntry ; $4a79
	inc h ; $4a7b
.readEntry:
	add hl, de ; $4a7c
	ld a, [hl+] ; $4a7d
	ld [wGameMode], a ; $4a7e
	ld a, [hl+] ; $4a81
	ld [wMatchOpponentChar], a ; $4a82
	ld a, [hl+] ; $4a85
	ld [wCurrentlyUsedCourt], a ; $4a86
	test_flag FLAG_DEBUG_KEEP_MATCH_SETTINGS ; $4a89
	jr nz, .minigameDefaults ; $4a8c
	ld a, [hl+] ; $4a8e
	ld e, a ; $4a8f
	and $0f ; $4a90
	ld [wMatchTypeNumberOfGames], a ; $4a92
	ld a, e ; $4a95
	swap a ; $4a96
	and $0f ; $4a98
	ld [wMatchTypeNumberOfSets], a ; $4a9a
	ld a, [hl] ; $4a9d
	ld [wMatchBGM], a ; $4a9e
	ret ; $4aa1
.minigameDefaults:
	ld a, $02 ; $4aa2
	ld [wMatchTypeNumberOfGames], a ; $4aa4
	ld a, $01 ; $4aa7
	ld [wMatchTypeNumberOfSets], a ; $4aa9
	inc hl ; $4aac
	ld a, [hl] ; $4aad
	ld [wMatchBGM], a ; $4aae
	ret ; $4ab1
SinglesMatchSettingsTable_0a:
	; $4ab2, 125 bytes (records:5)
; 25 records x 5 bytes
	db $03, $24, $00, $36, $20 ; record 0
	db $01, $23, $00, $36, $21 ; record 1
	db $01, $22, $00, $36, $21 ; record 2
	db $01, $21, $00, $36, $21 ; record 3
	db $01, $20, $00, $36, $21 ; record 4
	db $03, $2c, $01, $36, $20 ; record 5
	db $01, $2b, $01, $36, $22 ; record 6
	db $01, $2a, $01, $36, $22 ; record 7
	db $01, $29, $01, $36, $22 ; record 8
	db $01, $28, $01, $36, $22 ; record 9
	db $03, $34, $03, $36, $20 ; record 10
	db $01, $33, $03, $36, $23 ; record 11
	db $00, $00, $00, $12, $23 ; record 12
	db $00, $00, $00, $12, $23 ; record 13
	db $00, $00, $00, $12, $23 ; record 14
	db $03, $34, $02, $56, $20 ; record 15
	db $02, $0e, $0d, $56, $26 ; record 16
	db $02, $10, $0d, $56, $26 ; record 17
	db $02, $11, $0d, $56, $27 ; record 18
	db $02, $13, $0c, $56, $28 ; record 19
	db $03, $34, $02, $56, $20 ; record 20
	db $00, $00, $00, $12, $29 ; record 21
	db $0a, $5d, $05, $56, $29 ; record 22
	db $0a, $5c, $05, $56, $29 ; record 23
	db $0a, $5b, $05, $56, $29 ; record 24
DoublesMatchSettingsTable_0a:
	; $4b2f, 125 bytes (records:5)
; 25 records x 5 bytes
	db $03, $27, $00, $36, $20 ; record 0
	db $00, $00, $00, $36, $21 ; record 1
	db $01, $24, $00, $36, $21 ; record 2
	db $01, $21, $00, $36, $21 ; record 3
	db $01, $20, $00, $36, $21 ; record 4
	db $03, $2e, $01, $36, $20 ; record 5
	db $00, $00, $00, $36, $22 ; record 6
	db $01, $2c, $01, $36, $22 ; record 7
	db $01, $2a, $01, $36, $22 ; record 8
	db $01, $28, $01, $36, $22 ; record 9
	db $03, $34, $03, $36, $20 ; record 10
	db $00, $00, $00, $12, $23 ; record 11
	db $00, $00, $00, $12, $23 ; record 12
	db $01, $32, $03, $36, $23 ; record 13
	db $01, $30, $03, $36, $23 ; record 14
	db $03, $34, $02, $56, $20 ; record 15
	db $00, $00, $00, $12, $26 ; record 16
	db $02, $0e, $0d, $56, $26 ; record 17
	db $02, $10, $0d, $56, $27 ; record 18
	db $02, $13, $0c, $56, $28 ; record 19
	db $03, $34, $02, $56, $20 ; record 20
	db $00, $00, $00, $12, $29 ; record 21
	db $0a, $60, $05, $56, $29 ; record 22
	db $0a, $5f, $05, $56, $29 ; record 23
	db $0a, $5e, $05, $56, $29 ; record 24
RunClearStatusSetupMenu:
	push bc ; $4bac
	push de ; $4bad
	push hl ; $4bae
	ldh a, [hWramBank] ; $4baf
	push af ; $4bb1
	call ClearFrameTasks ; $4bb2
	call DisableLCDSafely ; $4bb5
	farcall LoadMenuFontGfx ; $4bb8
	call EnableLCD ; $4bbb
	wram_bank $05 ; $4bbe
	ld hl, wCharPosX ; $4bc4
	ld c, $02 ; $4bc7
	call ClearMemory16 ; $4bc9
	farcall ResetTextWindowState ; $4bcc
	call ClearBgTilemaps ; $4bcf
	ld d, $00 ; $4bd2
	ld e, $0b ; $4bd4
	ld b, $14 ; $4bd6
	ld c, $07 ; $4bd8
	farcall CreateWindowFromScreenRect ; $4bda
	ld [wCharPosDepth + 2], a ; $4bdd
	farcall DrawTextWindowFrame ; $4be0
	script_fade_in $10 ; $4be3
	call WaitFadeEnd ; $4be8
	wram_bank $05 ; $4beb
.modeMenu:
	ld a, [wCharPosDepth + 2] ; $4bf1
	farcall DrawTextWindowFrame ; $4bf4
	ld hl, $10e8 ; $4bf7
	ld de, wWindowShadowTilemap + 12 * TILEMAP_WIDTH + 1 ; $4bfa
	farcall RenderProportionalTextAt ; $4bfd
	ld a, [wCharPosDepth + 2] ; $4c00
	farcall RedrawWindowRows ; $4c03
	ld hl, Text_34_215 ; $4c06
	ld d, $01 ; $4c09
	ld e, $00 ; $4c0b
	farcall CreateMenuWindowFromText ; $4c0d
	farcall RestoreShadowTilemap ; $4c10
	farcall RenderMenuWindowText ; $4c13
	farcall RunMenuSelection ; $4c16
	ld [wCharPosX], a ; $4c19
	ld a, [wMenuWindowId] ; $4c1c
	farcall CloseWindow ; $4c1f
	ld a, [wCharPosX] ; $4c22
	cp $ff ; $4c25
	jr nz, .checkMode ; $4c27
	ld a, $08 ; $4c29
	ld [wCharPosHeight], a ; $4c2b
	jp .done ; $4c2e
.checkMode:
	or a ; $4c31
	jp z, .defaultDoubles ; $4c32
	ld a, $01 ; $4c35
	ld [wCharPosHeight], a ; $4c37
	jp .done ; $4c3a
.defaultDoubles:
	test_flag FLAG_DOUBLES ; $4c3d
	jr nz, .doubles ; $4c40
	xor a ; $4c42
	jr .storeDoubles ; $4c43
.doubles:
	ld a, $01 ; $4c45
.storeDoubles:
	ld [wCharPosX + 1], a ; $4c47
.formatMenu:
	ld a, [wCharPosDepth + 2] ; $4c4a
	farcall DrawTextWindowFrame ; $4c4d
	ld hl, $10e4 ; $4c50
	ld de, wWindowShadowTilemap + 12 * TILEMAP_WIDTH + 1 ; $4c53
	farcall RenderProportionalTextAt ; $4c56
	ld a, [wCharPosDepth + 2] ; $4c59
	farcall RedrawWindowRows ; $4c5c
	ld hl, Text_34_217 ; $4c5f
	ld d, $03 ; $4c62
	ld e, $00 ; $4c64
	farcall CreateMenuWindowFromText ; $4c66
	farcall RestoreShadowTilemap ; $4c69
	farcall RenderMenuWindowText ; $4c6c
	farcall RunMenuSelection ; $4c6f
	ld [wCharPosX + 2], a ; $4c72
	ld a, [wMenuWindowId] ; $4c75
	farcall CloseWindow ; $4c78
	ld a, [wCharPosX + 2] ; $4c7b
	cp $ff ; $4c7e
	jp z, .modeMenu ; $4c80
.setsMenu:
	ld a, [wCharPosDepth + 2] ; $4c83
	farcall DrawTextWindowFrame ; $4c86
	ld hl, $10e5 ; $4c89
	ld de, wWindowShadowTilemap + 12 * TILEMAP_WIDTH + 1 ; $4c8c
	farcall RenderProportionalTextAt ; $4c8f
	ld a, [wCharPosDepth + 2] ; $4c92
	farcall RedrawWindowRows ; $4c95
	ld hl, Text_34_218 ; $4c98
	ld d, $05 ; $4c9b
	ld e, $00 ; $4c9d
	farcall CreateMenuWindowFromText ; $4c9f
	farcall RestoreShadowTilemap ; $4ca2
	farcall RenderMenuWindowText ; $4ca5
	farcall RunMenuSelection ; $4ca8
	ld [wCharPosDepth], a ; $4cab
	ld a, [wMenuWindowId] ; $4cae
	farcall CloseWindow ; $4cb1
	ld a, [wCharPosDepth] ; $4cb4
	cp $ff ; $4cb7
	jp z, .formatMenu ; $4cb9
	ld a, [wCharPosDepth + 2] ; $4cbc
	farcall DrawTextWindowFrame ; $4cbf
	ld hl, $10e6 ; $4cc2
	ld a, [wCharPosX + 2] ; $4cc5
	add l ; $4cc8
	ld l, a ; $4cc9
	jr nc, .drawSetsOption ; $4cca
	inc h ; $4ccc
.drawSetsOption:
	ld de, wWindowShadowTilemap + 12 * TILEMAP_WIDTH + 1 ; $4ccd
	farcall RenderProportionalTextAt ; $4cd0
	ld a, [wCharPosDepth + 2] ; $4cd3
	farcall RedrawWindowRows ; $4cd6
	ld a, [wCharPosX + 1] ; $4cd9
	or a ; $4cdc
	jp nz, .setsCancel ; $4cdd
	ld hl, $10db ; $4ce0
	jr .checkSets ; $4ce3
.setsCancel:
	ld hl, $10df ; $4ce5
.checkSets:
	ld a, [wCharPosX + 2] ; $4ce8
	or a ; $4ceb
	jr z, .storeSets ; $4cec
	ld a, [wCharPosDepth] ; $4cee
	inc a ; $4cf1
	add l ; $4cf2
	ld l, a ; $4cf3
	jr nc, .storeSets ; $4cf4
	inc h ; $4cf6
.storeSets:
	ld d, $07 ; $4cf7
	ld e, $00 ; $4cf9
	farcall CreateMenuWindowFromText ; $4cfb
	farcall RestoreShadowTilemap ; $4cfe
	farcall RenderMenuWindowText ; $4d01
	farcall RunMenuSelection ; $4d04
	ld [wCharPosDepth + 1], a ; $4d07
	ld a, [wMenuWindowId] ; $4d0a
	farcall CloseWindow ; $4d0d
	ld a, [wCharPosDepth + 1] ; $4d10
	cp $ff ; $4d13
	jp z, .setsMenu ; $4d15
	call ApplyClearStatusFlags ; $4d18
	call GetClearStatusResultCode ; $4d1b
.done:
	ld hl, wCharPosHeight ; $4d1e
	ld b, [hl] ; $4d21
	pop af ; $4d22
	wram_bank ; $4d23
	ld a, b ; $4d27
	pop hl ; $4d28
	pop de ; $4d29
	pop bc ; $4d2a
	ret ; $4d2b
ClearBgTilemaps:
	call DisableLCDSafely ; $4d2c
	wram_bank $02 ; $4d2f
	ld a, $00 ; $4d35
	ld hl, wScreenAttrmap ; $4d37
	ld bc, $0500 ; $4d3a
	call FillMemoryFast ; $4d3d
	wram_bank $03 ; $4d40
	ld a, $20 ; $4d46
	ld hl, wShadowTilemap ; $4d48
	ld bc, $0500 ; $4d4b
	call FillMemoryFast ; $4d4e
	wram_bank $03 ; $4d51
	ld hl, wShadowTilemap ; $4d57
	ld de, $9800 ; $4d5a
	ld c, $24 ; $4d5d
	call QueueVRAMCopy ; $4d5f
	wram_bank $02 ; $4d62
	ld hl, wScreenAttrmap ; $4d68
	ld de, $9800 + VRAM_BANK1 ; $4d6b
	ld c, $24 ; $4d6e
	call QueueVRAMCopy ; $4d70
	call EnableLCD ; $4d73
	ret ; $4d76
FillMemoryFast:
	ld e, a ; $4d77
.fillLoop:
	ld [hl], e ; $4d78
	inc hl ; $4d79
	dec bc ; $4d7a
	ld a, c ; $4d7b
	or b ; $4d7c
	jr nz, .fillLoop ; $4d7d
	ret ; $4d7f
ApplyClearStatusFlags:
	ld a, [wCharPosX] ; $4d80
	or a ; $4d83
	ret nz ; $4d84
	clear_flag FLAG_DOUBLES ; $4d85
	ld a, [wCharPosX + 1] ; $4d88
	or a ; $4d8b
	jr z, .checkDoubles ; $4d8c
	set_flag FLAG_DOUBLES ; $4d8e
.checkDoubles:
	call SetRankingMatchClearFlags ; $4d91
	ld a, [wCharPosX + 1] ; $4d94
	or a ; $4d97
	jr nz, .setFlags ; $4d98
.doubles:
	call SetMinigameClearFlags ; $4d9a
	jr .done ; $4d9d
.setFlags:
	ld a, [wCharPosX + 2] ; $4d9f
	or a ; $4da2
	jr z, .doubles ; $4da3
	call SetMinigameClearFlagsAlt ; $4da5
.done:
	ret ; $4da8
SetRankingMatchClearFlags:
	ld c, $1c ; $4da9
	ld de, $1800 ; $4dab
.clearLoop:
	push de ; $4dae
	call ClearGameFlag ; $4daf
	pop de ; $4db2
	ld hl, $0020 ; $4db3
	add hl, de ; $4db6
	ld d, h ; $4db7
	ld e, l ; $4db8
	dec c ; $4db9
	jr nz, .clearLoop ; $4dba
	ld a, [wCharPosDepth] ; $4dbc
	or a ; $4dbf
	ret z ; $4dc0
	ld hl, RankingFlagList_0a_0 ; $4dc1
.setListA:
	ld a, [hl+] ; $4dc4
	ld d, [hl] ; $4dc5
	ld e, a ; $4dc6
	inc hl ; $4dc7
	ld a, d ; $4dc8
	and d ; $4dc9
	cp $ff ; $4dca
	jr z, .checkSecondList ; $4dcc
	call SetGameFlag ; $4dce
	jr .setListA ; $4dd1
.checkSecondList:
	ld a, [wCharPosDepth] ; $4dd3
	cp $01 ; $4dd6
	ret z ; $4dd8
	ld hl, RankingFlagList_0a_1 ; $4dd9
.setListB:
	ld a, [hl+] ; $4ddc
	ld d, [hl] ; $4ddd
	ld e, a ; $4dde
	inc hl ; $4ddf
	ld a, d ; $4de0
	and d ; $4de1
	cp $ff ; $4de2
	jr z, .done ; $4de4
	call SetGameFlag ; $4de6
	jr .setListB ; $4de9
.done:
	ret ; $4deb
RankingFlagListPtrs_0a:
	; $4dec, 6 bytes (records:2)
	dw $0000 ; record 0
	dw RankingFlagList_0a_0 ; record 1
	dw RankingFlagList_0a_1 ; record 2
RankingFlagList_0a_0:
	; $4df2, 14 bytes (records:2)
	dw $1800 ; record 0
	dw $1860 ; record 1
	dw $18c0 ; record 2
	dw $1920 ; record 3
	dw $1980 ; record 4
	dw $19e0 ; record 5
	dw $ffff ; record 6
RankingFlagList_0a_1:
	; $4e00, 14 bytes (records:2)
	dw $1820 ; record 0
	dw $1880 ; record 1
	dw $18e0 ; record 2
	dw $1940 ; record 3
	dw $19a0 ; record 4
	dw $1a00 ; record 5
	dw $ffff ; record 6
SetMinigameClearFlags:
	ld c, $09 ; $4e0e
	ld de, $0a00 ; $4e10
.clearLoop:
	push de ; $4e13
	call ClearGameFlag ; $4e14
	pop de ; $4e17
	ld hl, $0020 ; $4e18
	add hl, de ; $4e1b
	ld d, h ; $4e1c
	ld e, l ; $4e1d
	dec c ; $4e1e
	jr nz, .clearLoop ; $4e1f
	ld a, [wCharPosX + 2] ; $4e21
	or a ; $4e24
	jr z, .haveLevel ; $4e25
	ld a, [wCharPosDepth + 1] ; $4e27
.haveLevel:
	ld b, a ; $4e2a
	ld a, [wCharPosDepth] ; $4e2b
	ld c, a ; $4e2e
	add a ; $4e2f
	add a ; $4e30
	add c ; $4e31
	ld c, a ; $4e32
	ld a, b ; $4e33
	add c ; $4e34
	ld c, a ; $4e35
	inc c ; $4e36
	ld hl, MinigameClearFlagsRankingFlagList ; $4e37
.setLoop:
	ld a, [hl+] ; $4e3a
	ld d, [hl] ; $4e3b
	ld e, a ; $4e3c
	inc hl ; $4e3d
	dec c ; $4e3e
	jr z, .done ; $4e3f
	ld a, d ; $4e41
	or e ; $4e42
	jr z, .setLoop ; $4e43
	call SetGameFlag ; $4e45
	jr .setLoop ; $4e48
.done:
	ret ; $4e4a
MinigameClearFlagsRankingFlagList:
	; $4e4b, 42 bytes (records:2)
	dw $0000 ; record 0
	dw $0a00 ; record 1
	dw $0a20 ; record 2
	dw $0a40 ; record 3
	dw $0a60 ; record 4
	dw $0000 ; record 5
	dw $0a80 ; record 6
	dw $0aa0 ; record 7
	dw $0ac0 ; record 8
	dw $0ae0 ; record 9
	dw $0000 ; record 10
	dw $0b00 ; record 11
	dw $0000 ; record 12
	dw $0000 ; record 13
	dw $0000 ; record 14
	dw $0000 ; record 15
	dw $07e0 ; record 16
	dw $07c0 ; record 17
	dw $07a0 ; record 18
	dw $0780 ; record 19
	dw $ffff ; record 20
SetMinigameClearFlagsAlt:
	ld c, $09 ; $4e75
	ld de, $0a00 ; $4e77
.clearLoop:
	push de ; $4e7a
	call ClearGameFlag ; $4e7b
	pop de ; $4e7e
	ld hl, $0020 ; $4e7f
	add hl, de ; $4e82
	ld d, h ; $4e83
	ld e, l ; $4e84
	dec c ; $4e85
	jr nz, .clearLoop ; $4e86
	ld a, [wCharPosDepth] ; $4e88
	add a ; $4e8b
	add a ; $4e8c
	ld c, a ; $4e8d
	ld a, [wCharPosDepth + 1] ; $4e8e
	add c ; $4e91
	ld c, a ; $4e92
	inc c ; $4e93
	ld hl, MinigameClearFlagsAltRankingFlagList ; $4e94
.setLoop:
	ld a, [hl+] ; $4e97
	ld d, [hl] ; $4e98
	ld e, a ; $4e99
	inc hl ; $4e9a
	dec c ; $4e9b
	jr z, .done ; $4e9c
	ld a, d ; $4e9e
	or e ; $4e9f
	jr z, .setLoop ; $4ea0
	call SetGameFlag ; $4ea2
	jr .setLoop ; $4ea5
.done:
	ret ; $4ea7
MinigameClearFlagsAltRankingFlagList:
	; $4ea8, 34 bytes (records:2)
	dw $0000 ; record 0
	dw $0800 ; record 1
	dw $0820 ; record 2
	dw $0840 ; record 3
	dw $0000 ; record 4
	dw $0880 ; record 5
	dw $08a0 ; record 6
	dw $08c0 ; record 7
	dw $0000 ; record 8
	dw $0900 ; record 9
	dw $0000 ; record 10
	dw $0000 ; record 11
	dw $0000 ; record 12
	dw $07e0 ; record 13
	dw $07c0 ; record 14
	dw $07a0 ; record 15
	dw $ffff ; record 16
GetClearStatusResultCode:
	ld hl, ClearStatusResultCodeIndexTable ; $4eca
	ld a, [wCharPosX + 2] ; $4ecd
	ld b, a ; $4ed0
	or a ; $4ed1
	jr z, .doublesRow ; $4ed2
	ld a, [wCharPosDepth] ; $4ed4
	inc a ; $4ed7
	inc a ; $4ed8
	add a ; $4ed9
	ld b, a ; $4eda
	ld a, [wCharPosX + 1] ; $4edb
	jr .index ; $4ede
.doublesRow:
	ld a, [wCharPosDepth + 1] ; $4ee0
.index:
	add b ; $4ee3
	add l ; $4ee4
	ld l, a ; $4ee5
	jr nc, .read ; $4ee6
	inc h ; $4ee8
.read:
	ld a, [hl] ; $4ee9
	ld [wCharPosHeight], a ; $4eea
	ret ; $4eed
ClearStatusResultCodeIndexTable:
	; $4eee, 10 bytes (bytes:10)
	db $01, $02, $03, $00, $04, $05, $06, $06, $07, $07 ; 0x00
ClearStatusSetupMenuEntry:
	call RunClearStatusSetupMenu ; $4ef8
	ret ; $4efb
DrawPlayerPositionDebugOverlay:
	test_flag FLAG_DEBUG_SHOW_PLAYER_POS ; $4efc
	jr z, .done ; $4eff
	wram_bank $04 ; $4f01
	ld hl, wStoryModePlayersXPosition ; $4f07
	ld a, [hl+] ; $4f0a
	ld h, [hl] ; $4f0b
	ld l, a ; $4f0c
	push hl ; $4f0d
	push de ; $4f0e
	ld h, h ; $4f0f
	ld l, l ; $4f10
	ld de, $1000 ; $4f11
	call PrintHexWord ; $4f14
	pop de ; $4f17
	pop hl ; $4f18
	ld hl, wStoryModePlayersYPosition ; $4f19
	ld a, [hl+] ; $4f1c
	ld h, [hl] ; $4f1d
	ld l, a ; $4f1e
	push hl ; $4f1f
	push de ; $4f20
	ld h, h ; $4f21
	ld l, l ; $4f22
	ld de, $1001 ; $4f23
	call PrintHexWord ; $4f26
	pop de ; $4f29
	pop hl ; $4f2a
.done:
	ret ; $4f2b
RunStoryModeOverworld:
	xor a ; $4f2c
	ld [wOverworldEnterFlag], a ; $4f2d
.restart:
	call ClearFrameTasks ; $4f30
	ld a, $01 ; $4f33
	ld hl, DrawPlayerPositionDebugOverlay ; $4f35
	call RegisterFrameTask ; $4f38
	call RunStoryLocation ; $4f3b
	jr .restart ; $4f3e
RunStoryLocation:
	push af ; $4f40
	push bc ; $4f41
	push de ; $4f42
	push hl ; $4f43
	ld c, $0c ; $4f44
	call BeginFadeOut ; $4f46
	call ClearTemporaryStoryFlags ; $4f49
	call ClearStoryEventRequests ; $4f4c
	call LoadStoryLocationHeader ; $4f4f
	call LoadStoryEntryPointRecord ; $4f52
	ld a, GAMEMODE_NONE ; $4f55
	ld [wGameMode], a ; $4f57
	call AdvanceFrame ; $4f5a
	test_flag FLAG_ENDING_CREDITS_RUNNING ; $4f5d
	jr nz, .loadLocation ; $4f60
	ld a, [wStoryLocationBGM] ; $4f62
	cp $ff ; $4f65
	jr z, .loadLocation ; $4f67
	ld a, [wStoryLocationBGM] ; $4f69
	call PlaySoundManaged ; $4f6c
.loadLocation:
	farcall ResetTextWindowState ; $4f6f
	ld hl, wMapActorsPtr ; $4f72
	ld a, [hl+] ; $4f75
	ld h, [hl] ; $4f76
	ld l, a ; $4f77
	ld a, [wStoryLocationBank] ; $4f78
	call InitLocationActors ; $4f7b
	ld hl, wActors ; $4f7e
	ld de, $0018 ; $4f81
	add hl, de ; $4f84
	ld [hl], $01 ; $4f85
	set_flag FLAG_HIDE_OVERWORLD_ACTORS ; $4f87
	call WaitFadeEnd ; $4f8a
	clear_flag FLAG_HIDE_OVERWORLD_ACTORS ; $4f8d
	farcall LoadStoryObjPalettes ; $4f90
	call DisableLCDSafely ; $4f93
	farcall ResetTextWindowState ; $4f96
	farcall InitSceneScroll ; $4f99
	ld a, [wStoryLocationScene] ; $4f9c
	farcall LoadStorySceneGraphics ; $4f9f
	ld a, $00 ; $4fa2
	farcall CopyScrolledSceneTilemapToVram ; $4fa4
	test_flag FLAG_ENDING_CREDITS_RUNNING ; $4fa7
	jr nz, .enableLcd ; $4faa
	farcall LoadMenuFontGfx ; $4fac
.enableLcd:
	call EnableLCD ; $4faf
	ld a, [wStoryArrivalScript] ; $4fb2
	ld l, a ; $4fb5
	ld a, [wStoryArrivalScript + 1] ; $4fb6
	ld h, a ; $4fb9
	ld a, h ; $4fba
	or l ; $4fbb
	jr z, .runInitScript ; $4fbc
	ld a, [wStoryLocationBank] ; $4fbe
	call CallHLInBankA ; $4fc1
.runInitScript:
	call RunLocationInitScript ; $4fc4
	ld hl, wStoryModeExitLocationRequest ; $4fc7
	ld a, [hl] ; $4fca
	and a ; $4fcb
	jr z, .fadeIn ; $4fcc
	ld [hl], $00 ; $4fce
	call RunLocationExit ; $4fd0
	jp .done ; $4fd3
.fadeIn:
	script_fade_in $08 ; $4fd6
	call WaitFadeEnd ; $4fdb
	ld a, [wStoryModeShowLocationName] ; $4fde
	and a ; $4fe1
	jr z, .noNamePopup ; $4fe2
	ld a, [wStoryModeLocationNameTextId] ; $4fe4
	ld l, a ; $4fe7
	ld a, [wStoryModeLocationNameTextId + 1] ; $4fe8
	ld h, a ; $4feb
	call ShowLocationNamePopup ; $4fec
	jr .frameLoop ; $4fef
.noNamePopup:
	call WaitFramesCmd ; $4ff1
	db $04 ; $4ff4 inline arg
.frameLoop:
	wram_bank $04 ; $4ff5
	call CheckStoryEventRequests ; $4ffb
	and a ; $4ffe
	jp z, .waitForEvent ; $4fff
	ld bc, wActors ; $5002
	ld hl, ActorScript_0a ; $5005
	ldh a, [hRomBank] ; $5008
	farcall SetActorScript ; $500a
	ld hl, wActors ; $500d
	ld de, $0018 ; $5010
	add hl, de ; $5013
	ld [hl], $01 ; $5014
	ld hl, wStoryModeTriggerScript ; $5016
	ld a, [hl] ; $5019
	and a ; $501a
	jr z, .checkExit ; $501b
	ld [hl], $00 ; $501d
	call RunQueuedTriggerScript ; $501f
.checkExit:
	ld hl, wStoryModeExitLocationRequest ; $5022
	ld a, [hl] ; $5025
	and a ; $5026
	jr z, .checkMenu ; $5027
	ld [hl], $00 ; $5029
	call RunLocationExit ; $502b
	jp .done ; $502e
.checkMenu:
	ld hl, wStoryModeMenuRequest ; $5031
	ld a, [hl] ; $5034
	and a ; $5035
	jr z, .checkInteract ; $5036
	ld [hl], $00 ; $5038
	call WaitPlayerMoveDone ; $503a
	test_flag FLAG_STORY_MENU_LOCKED ; $503d
	jr nz, .checkInteract ; $5040
	farcall RunStoryModeMenu ; $5042
	jp .frameLoop ; $5045
.checkInteract:
	xor a ; $5048
	ld [wStoryAutoInteractFired], a ; $5049
	ld hl, wStoryAutoInteractArmed ; $504c
	ld a, [hl] ; $504f
	and a ; $5050
	jr z, .runInteract ; $5051
	ld [hl], $00 ; $5053
	wram_bank $04 ; $5055
	ld a, [wPlayerMoveAngleApplied] ; $505b
	and a ; $505e
	jr z, .runInteract ; $505f
	ld hl, wPlayerMoveAnglePrev ; $5061
	ld a, [wPlayerMoveAngleApplied] ; $5064
	cp [hl] ; $5067
	jr nz, .runInteract ; $5068
	ld hl, wPlayerMoving ; $506a
	ld a, [hl] ; $506d
	cp $1e ; $506e
	jr c, .runInteract ; $5070
	ld [hl], $00 ; $5072
	ld hl, wStoryAutoInteractFired ; $5074
	ld [hl], $ff ; $5077
	ld hl, wStoryModeInteractRequest ; $5079
	ld [hl], $01 ; $507c
.runInteract:
	xor a ; $507e
	ld [wStoryScriptRan], a ; $507f
	ld hl, wStoryModeInteractRequest ; $5082
	ld a, [hl] ; $5085
	and a ; $5086
	jr z, .nextFrame ; $5087
	ld [hl], $00 ; $5089
	call FindActorFacingPlayer ; $508b
	and a ; $508e
	jr z, .checkFacingTile ; $508f
	call RunNpcInteraction ; $5091
	ld a, [wStoryScriptRan] ; $5094
	and a ; $5097
	jr nz, .nextFrame ; $5098
.checkFacingTile:
	call GetFacingTileInteractionId ; $509a
	and a ; $509d
	jr z, .checkTileTrigger ; $509e
	call RunFacingTileScript ; $50a0
	ld a, [wStoryScriptRan] ; $50a3
	and a ; $50a6
	jr nz, .nextFrame ; $50a7
.checkTileTrigger:
	call GetTileTriggerAtPlayer ; $50a9
	and a ; $50ac
	jr z, .checkDebugMenu ; $50ad
	call RunTileTriggerScript ; $50af
	jr .nextFrame ; $50b2
.checkDebugMenu:
	ld a, [wStoryAutoInteractFired] ; $50b4
	and a ; $50b7
	jr nz, .nextFrame ; $50b8
	ldh a, [hDebugStepMode] ; $50ba
	and a ; $50bc
	jr z, .nextFrame ; $50bd
	call WaitPlayerMoveDone ; $50bf
	farcall RunDebugMenu ; $50c2
	jr .nextFrame ; $50c5
.nextFrame:
	jp .frameLoop ; $50c7
.waitForEvent:
	call WaitFadeEnd ; $50ca
	ld bc, wActors ; $50cd
	farcall AttachActorControllerScript ; $50d0
.eventWaitLoop:
	call AdvanceFrame ; $50d3
	call CheckStoryEventRequests ; $50d6
	and a ; $50d9
	jr z, .eventWaitLoop ; $50da
	jp .frameLoop ; $50dc
.done:
	pop hl ; $50df
	pop de ; $50e0
	pop bc ; $50e1
	pop af ; $50e2
	ret ; $50e3
ClearTemporaryStoryFlags:
	push af ; $50e4
	push hl ; $50e5
	ld hl, wGameFlagsTemp ; $50e6
	xor a ; $50e9
	ld [hl+], a ; $50ea
	ld [hl+], a ; $50eb
	ld [hl+], a ; $50ec
	ld [hl+], a ; $50ed
	pop hl ; $50ee
	pop af ; $50ef
	ret ; $50f0
ClearStoryEventRequests:
	push af ; $50f1
	push bc ; $50f2
	push de ; $50f3
	push hl ; $50f4
	ld hl, wStoryModeTriggerScript ; $50f5
	ld b, $06 ; $50f8
	xor a ; $50fa
.clearLoop:
	ld [hl+], a ; $50fb
	dec b ; $50fc
	jr nz, .clearLoop ; $50fd
	pop hl ; $50ff
	pop de ; $5100
	pop bc ; $5101
	pop af ; $5102
	ret ; $5103
CheckStoryEventRequests:
	push bc ; $5104
	push hl ; $5105
	ld hl, wStoryModeTriggerScript ; $5106
	ld b, $06 ; $5109
	xor a ; $510b
.orLoop:
	or [hl] ; $510c
	inc hl ; $510d
	dec b ; $510e
	jr nz, .orLoop ; $510f
	pop hl ; $5111
	pop bc ; $5112
	ret ; $5113
LoadStoryLocationHeader:
	push af ; $5114
	push bc ; $5115
	push de ; $5116
	push hl ; $5117
	ld a, [wStoryModeCurrentLocation] ; $5118
	call GetStoryLocationRecordPtr ; $511b
	jr .readHeader ; $511e
.readHeader:
	ld de, wStoryModeCurrentLocation ; $5120
	ld bc, $0006 ; $5123
	call CopyMemoryBC ; $5126
	ld hl, wStoryLocationMapScriptsSlot ; $5129
	ld a, [hl+] ; $512c
	ld h, [hl] ; $512d
	ld l, a ; $512e
	ld a, h ; $512f
	ld [wStoryLocationBank], a ; $5130
	ld hl, wStoryLocationMapScriptsSlot ; $5133
	ld a, [hl+] ; $5136
	ld h, [hl] ; $5137
	ld l, a ; $5138
	ld de, wMapEntryPointsPtr ; $5139
	ld bc, $000e ; $513c
	call CopyDataFromBank ; $513f
	ld a, [wStoryModeCurrentLocation] ; $5142
	add $79 ; $5145
	ld l, a ; $5147
	adc $01 ; $5148
	sub l ; $514a
	ld h, a ; $514b
	ld a, l ; $514c
	ld [wStoryModeLocationNameTextId], a ; $514d
	ld a, h ; $5150
	ld [wStoryModeLocationNameTextId + 1], a ; $5151
	ld a, [wStoryModeEntryPoint] ; $5154
	sub $ff ; $5157
	ld [wStoryModeShowLocationName], a ; $5159
	pop hl ; $515c
	pop de ; $515d
	pop bc ; $515e
	pop af ; $515f
	ret ; $5160
WriteStoryStateWord:
	push de ; $5161
	push hl ; $5162
	push hl ; $5163
	ld hl, wStoryModeCurrentLocation ; $5164
	add hl, de ; $5167
	pop de ; $5168
	ld [hl], e ; $5169
	inc hl ; $516a
	ld [hl], d ; $516b
	pop hl ; $516c
	pop de ; $516d
	ret ; $516e
LoadStoryEntryPointRecord:
	push af ; $516f
	push bc ; $5170
	push de ; $5171
	push hl ; $5172
	ld a, [wStoryModeEntryPoint] ; $5173
	cp $ff ; $5176
	jr z, .done ; $5178
	ld hl, wStoryModeEntryPoint ; $517a
	ld d, [hl] ; $517d
	ld hl, wMapEntryPointsPtr ; $517e
	ld a, [hl+] ; $5181
	ld h, [hl] ; $5182
	ld l, a ; $5183
.searchLoop:
	ld a, [wStoryLocationBank] ; $5184
	call FarReadByte ; $5187
	cp $ff ; $518a
	jr z, .notFound ; $518c
	cp d ; $518e
	jr z, .copyRecord ; $518f
	ld a, $08 ; $5191
	add l ; $5193
	ld l, a ; $5194
	jr nc, .next ; $5195
	inc h ; $5197
.next:
	jr .searchLoop ; $5198
.notFound:
	ld hl, wMapEntryPointsPtr ; $519a
	ld a, [hl+] ; $519d
	ld h, [hl] ; $519e
	ld l, a ; $519f
.copyRecord:
	ld a, [wStoryLocationBank] ; $51a0
	ld de, wStoryMapRecord ; $51a3
	ld bc, $0008 ; $51a6
	call FarCopyBytes ; $51a9
	ld a, [wStoryMapRecord + 1] ; $51ac
	ld [wStoryModeSpawnPosition + 4], a ; $51af
	ld hl, wStoryMapRecord + 2 ; $51b2
	ld de, wStoryModeSpawnPosition ; $51b5
	ld bc, $0004 ; $51b8
	call CopyMemoryBC ; $51bb
	ld a, [wStoryMapRecord + 6] ; $51be
	ld [wStoryArrivalScript], a ; $51c1
	ld a, [wStoryMapRecord + 7] ; $51c4
	ld [wStoryArrivalScript + 1], a ; $51c7
.done:
	pop hl ; $51ca
	pop de ; $51cb
	pop bc ; $51cc
	pop af ; $51cd
	ret ; $51ce
GetPointAheadOfActor:
	push af ; $51cf
	push bc ; $51d0
	ld b, a ; $51d1
	wram_bank $04 ; $51d2
	ld a, b ; $51d8
	ld c, l ; $51d9
	ld b, h ; $51da
	ld hl, $0032 ; $51db
	add hl, bc ; $51de
	add [hl] ; $51df
	ld l, e ; $51e0
	ld h, d ; $51e1
	call VectorFromLengthAndAngle ; $51e2
	push hl ; $51e5
	ld hl, $000e ; $51e6
	add hl, bc ; $51e9
	ld a, [hl+] ; $51ea
	ld h, [hl] ; $51eb
	ld l, a ; $51ec
	add hl, de ; $51ed
	ld e, l ; $51ee
	ld d, h ; $51ef
	pop hl ; $51f0
	push de ; $51f1
	ld e, l ; $51f2
	ld d, h ; $51f3
	ld hl, $000c ; $51f4
	add hl, bc ; $51f7
	ld a, [hl+] ; $51f8
	ld h, [hl] ; $51f9
	ld l, a ; $51fa
	add hl, de ; $51fb
	pop de ; $51fc
	pop bc ; $51fd
	pop af ; $51fe
	ret ; $51ff
GetFacingTileInteractionId:
	push bc ; $5200
	push de ; $5201
	push hl ; $5202
	ld hl, wActors ; $5203
	ld de, $01c0 ; $5206
	ld a, $00 ; $5209
	call GetPointAheadOfActor ; $520b
	ld e, d ; $520e
	ld d, h ; $520f
	farcall ReadBehaviorMapCell ; $5210
	ld d, a ; $5213
	ld e, $00 ; $5214
	and $0f ; $5216
	cp $08 ; $5218
	jr nz, .done ; $521a
	ld a, d ; $521c
	swap a ; $521d
	and $0f ; $521f
	ld e, a ; $5221
.done:
	ld a, e ; $5222
	pop hl ; $5223
	pop de ; $5224
	pop bc ; $5225
	ret ; $5226
FindActorFacingPlayer:
	push bc ; $5227
	push de ; $5228
	push hl ; $5229
	wram_bank $04 ; $522a
	farcall BuildActorQueryList ; $5230
	ld hl, wActors ; $5233
	ld de, $01c0 ; $5236
	ld a, $00 ; $5239
	call GetPointAheadOfActor ; $523b
	push de ; $523e
	ld e, d ; $523f
	ld d, h ; $5240
	farcall ReadBehaviorMapCell ; $5241
	and $0f ; $5244
	pop de ; $5246
	cp $0c ; $5247
	jr nz, .query ; $5249
	ld hl, wActors ; $524b
	ld de, $03c0 ; $524e
	ld a, $00 ; $5251
	call GetPointAheadOfActor ; $5253
.query:
	farcall FindActorAtPoint ; $5256
	and a ; $5259
	jr nz, .done ; $525a
	ld hl, wActors ; $525c
	ld de, $0180 ; $525f
	ld a, $f0 ; $5262
	call GetPointAheadOfActor ; $5264
	farcall FindActorAtPoint ; $5267
	and a ; $526a
	jr nz, .done ; $526b
	ld hl, wActors ; $526d
	ld de, $0180 ; $5270
	ld a, $10 ; $5273
	call GetPointAheadOfActor ; $5275
	farcall FindActorAtPoint ; $5278
.done:
	pop hl ; $527b
	pop de ; $527c
	pop bc ; $527d
	ret ; $527e
SaveStoryReturnPoint:
	push af ; $527f
	push bc ; $5280
	push de ; $5281
	push hl ; $5282
	ld a, b ; $5283
	cp $ff ; $5284
	jr z, .fromCurrent ; $5286
	ld hl, wStoryReturnLocation ; $5288
	ld [hl], b ; $528b
	ld hl, wStoryReturnEntryPoint ; $528c
	ld [hl], c ; $528f
	jr .done ; $5290
.fromCurrent:
	ld a, [wStoryModeCurrentLocation] ; $5292
	ld [wStoryReturnLocation], a ; $5295
	ld hl, wStoryReturnEntryPoint ; $5298
	ld [hl], $ff ; $529b
	ld hl, wStoryModePlayersXPosition ; $529d
	ld de, wStoryReturnPosition ; $52a0
	ld bc, $0005 ; $52a3
	call CopyMemoryBC ; $52a6
.done:
	pop hl ; $52a9
	pop de ; $52aa
	pop bc ; $52ab
	pop af ; $52ac
	ret ; $52ad
RestoreStoryReturnPoint:
	push af ; $52ae
	push bc ; $52af
	push de ; $52b0
	push hl ; $52b1
	ld a, [wStoryReturnEntryPoint] ; $52b2
	cp $ff ; $52b5
	jr z, .restorePosition ; $52b7
	ld a, [wStoryReturnLocation] ; $52b9
	ld [wStoryModeCurrentLocation], a ; $52bc
	ld a, [wStoryReturnEntryPoint] ; $52bf
	ld [wStoryModeEntryPoint], a ; $52c2
	ld a, $ff ; $52c5
	ld [wUnusedExitLocationMirror], a ; $52c7
	ld [wStoryModeExitLocationRequest], a ; $52ca
	jr .done ; $52cd
.restorePosition:
	ld hl, wStoryReturnPosition ; $52cf
	ld de, wStoryModeSpawnPosition ; $52d2
	ld bc, $0005 ; $52d5
	call CopyMemoryBC ; $52d8
	ld a, [wStoryReturnLocation] ; $52db
	ld [wStoryModeCurrentLocation], a ; $52de
	ld a, $ff ; $52e1
	ld [wStoryModeEntryPoint], a ; $52e3
	ld a, $ff ; $52e6
	ld [wUnusedExitLocationMirror], a ; $52e8
	ld a, $ff ; $52eb
	ld [wStoryModeExitLocationRequest], a ; $52ed
.done:
	pop hl ; $52f0
	pop de ; $52f1
	pop bc ; $52f2
	pop af ; $52f3
	ret ; $52f4
ShowLocationNamePopup:
	push af ; $52f5
	push bc ; $52f6
	push de ; $52f7
	push hl ; $52f8
	ldh a, [hWramBank] ; $52f9
	push af ; $52fb
	call WaitPlayerMoveDone ; $52fc
	wram_bank $05 ; $52ff
	ld a, [wMessageSpeed] ; $5305
	set 7, a ; $5308
	ld [wMessageSpeed], a ; $530a
	ld a, $83 ; $530d
	farcall ShowSpeakerDialogueRestoreBG ; $530f
	ld b, $50 ; $5312
.waitLoop:
	call AdvanceFrame ; $5314
	ldh a, [hPlayerInputFlags] ; $5317
	and a ; $5319
	jr nz, .close ; $531a
	dec b ; $531c
	jr nz, .waitLoop ; $531d
.close:
	farcall CloseActiveDialogueWindow ; $531f
	wram_bank $05 ; $5322
	ld hl, wMessageSpeed ; $5328
	res 7, [hl] ; $532b
	pop af ; $532d
	wram_bank ; $532e
	pop hl ; $5332
	pop de ; $5333
	pop bc ; $5334
	pop af ; $5335
	ret ; $5336
LoadStoryObjPalettes:
	ld hl, StoryObjPalettes ; $5337
	ld de, $0b05 ; $533a
	call LoadPaletteShadow ; $533d
	ret ; $5340
StoryObjPalettes:
	INCLUDE "data/bank_00a/palettes_5341.asm" ; $5341, 40 bytes (palettes)
GetTileTriggerAtPlayer:
	push bc ; $5369
	push de ; $536a
	push hl ; $536b
	ld bc, wActors ; $536c
	ld hl, $000d ; $536f
	add hl, bc ; $5372
	ld d, [hl] ; $5373
	ld hl, $000f ; $5374
	add hl, bc ; $5377
	ld e, [hl] ; $5378
	farcall ReadBehaviorMapCell ; $5379
	ld e, a ; $537c
	ld d, $00 ; $537d
	and $0f ; $537f
	cp $01 ; $5381
	jr nz, .done ; $5383
	ld a, e ; $5385
	swap a ; $5386
	and $0f ; $5388
	ld d, a ; $538a
	ld hl, wMapTileTriggersPtr ; $538b
	ld a, [hl+] ; $538e
	ld h, [hl] ; $538f
	ld l, a ; $5390
	ld a, [wStoryLocationBank] ; $5391
	call FindStoryScriptEntry ; $5394
	ld a, h ; $5397
	or l ; $5398
	jr nz, .done ; $5399
	ld d, $00 ; $539b
.done:
	ld a, d ; $539d
	pop hl ; $539e
	pop de ; $539f
	pop bc ; $53a0
	ret ; $53a1
	ld a, e ; $53a2
	or d ; $53a3
	ret z ; $53a4
	bit 7, d ; $53a5
	jr nz, .negated ; $53a7
	call TestGameFlag ; $53a9
	ret ; $53ac
.negated:
	res 7, d ; $53ad
	call TestGameFlag ; $53af
	jr z, .true ; $53b2
	xor a ; $53b4
	ret ; $53b5
.true:
	xor a ; $53b6
	inc a ; $53b7
	ret ; $53b8
FacingMaskTable_0a:
	; $53b9, 4 bytes (enum:FACEMASK:4)
	db FACEMASK_RIGHT, FACEMASK_DOWN, FACEMASK_LEFT, FACEMASK_UP ; 0x00
CheckTriggerFacingMask:
	push bc ; $53bd
	push hl ; $53be
	wram_bank $04 ; $53bf
	ld c, $01 ; $53c5
	ld a, b ; $53c7
	cp $ff ; $53c8
	jr z, .done ; $53ca
	ld a, [wPlayerMoveAngle] ; $53cc
	rlca ; $53cf
	rlca ; $53d0
	and $03 ; $53d1
	add LOW(FacingMaskTable_0a) ; $53d3
	ld l, a ; $53d5
	adc HIGH(FacingMaskTable_0a) ; $53d6
	sub l ; $53d8
	ld h, a ; $53d9
	ld a, [hl] ; $53da
	and b ; $53db
	jr nz, .done ; $53dc
	ld c, $00 ; $53de
.done:
	ld a, c ; $53e0
	pop hl ; $53e1
	pop bc ; $53e2
	ret ; $53e3
FindStoryScriptEntry:
	push af ; $53e4
	push bc ; $53e5
	push de ; $53e6
.searchLoop:
	ld a, [wStoryLocationBank] ; $53e7
	call FarReadWord ; $53ea
	ld a, c ; $53ed
	cp $ff ; $53ee
	jr z, .notFound ; $53f0
	cp d ; $53f2
	jr nz, .nextEntry ; $53f3
	call CheckTriggerFacingMask ; $53f5
	and a ; $53f8
	jr z, .nextEntry ; $53f9
	inc hl ; $53fb
	inc hl ; $53fc
	ld a, [wStoryLocationBank] ; $53fd
	call FarReadWord ; $5400
	dec hl ; $5403
	dec hl ; $5404
	push de ; $5405
	ld e, c ; $5406
	ld d, b ; $5407
	farcall EvalFlagCondition ; $5408
	pop de ; $540b
	jr nz, .nextEntry ; $540c
	jr .done ; $540e
.nextEntry:
	ld bc, $0008 ; $5410
	add hl, bc ; $5413
	jr .searchLoop ; $5414
.notFound:
	ld hl, $0000 ; $5416
.done:
	pop de ; $5419
	pop bc ; $541a
	pop af ; $541b
	ret ; $541c
RunStoryScriptOrDialogue:
	push af ; $541d
	push bc ; $541e
	ld b, a ; $541f
	push de ; $5420
	push hl ; $5421
	ldh a, [hWramBank] ; $5422
	push af ; $5424
	ld a, $01 ; $5425
	ld [wStoryScriptRan], a ; $5427
	ld a, h ; $542a
	or l ; $542b
	jr z, .done ; $542c
	ld a, h ; $542e
	and $c0 ; $542f
	jr nz, .runScript ; $5431
	call WaitPlayerMoveDone ; $5433
	ld a, b ; $5436
	farcall ShowSpeakerDialogue ; $5437
	jr .done ; $543a
.runScript:
	farcall BeginCutsceneScriptMode ; $543c
	push hl ; $543f
	wram_bank $04 ; $5440
	ld hl, wActors + 48 ; $5446
	res 0, [hl] ; $5449
	ld hl, wActors + 20 ; $544b
	ld a, [wPlayerMoveAngle] ; $544e
	ld [hl], a ; $5451
	pop hl ; $5452
	ld a, [wStoryLocationBank] ; $5453
	call CallHLInBankA ; $5456
	farcall EndCutsceneScriptMode ; $5459
.done:
	pop af ; $545c
	wram_bank ; $545d
	pop hl ; $5461
	pop de ; $5462
	pop bc ; $5463
	pop af ; $5464
	ret ; $5465
InitLocationActors:
	push af ; $5466
	push bc ; $5467
	push de ; $5468
	push hl ; $5469
	push af ; $546a
	push hl ; $546b
	wram_bank $04 ; $546c
	farcall InitActorEngine ; $5472
	ld hl, wStoryModeSpawnPosition + 4 ; $5475
	ld c, [hl] ; $5478
	ld hl, wStoryModeSpawnPosition + 2 ; $5479
	ld a, [hl+] ; $547c
	ld d, [hl] ; $547d
	ld e, a ; $547e
	ld hl, wStoryModeSpawnPosition ; $547f
	ld a, [hl+] ; $5482
	ld h, [hl] ; $5483
	ld l, a ; $5484
	farcall SpawnMainCharacterActor ; $5485
	pop hl ; $5488
	pop af ; $5489
	farcall SpawnCompanionActor ; $548a
	farcall SpawnActorsFromList ; $548d
	pop hl ; $5490
	pop de ; $5491
	pop bc ; $5492
	pop af ; $5493
	ret ; $5494
RunLocationInitScript:
	push af ; $5495
	push bc ; $5496
	push de ; $5497
	push hl ; $5498
	ldh a, [hWramBank] ; $5499
	push af ; $549b
	ld a, $90 ; $549c
	ldh [rWY], a ; $549e
	ld hl, wMapInitScriptPtr ; $54a0
	ld a, [hl+] ; $54a3
	ld h, [hl] ; $54a4
	ld l, a ; $54a5
	ld a, $00 ; $54a6
	call RunStoryScriptOrDialogue ; $54a8
	pop af ; $54ab
	wram_bank ; $54ac
	pop hl ; $54b0
	pop de ; $54b1
	pop bc ; $54b2
	pop af ; $54b3
	ret ; $54b4
RunNpcInteraction:
	ld [wUnusedStoryScriptId], a ; $54b5
	cp $02 ; $54b8
	jp z, .done ; $54ba
	push af ; $54bd
	push bc ; $54be
	push de ; $54bf
	push hl ; $54c0
	ld d, a ; $54c1
	ld hl, wMapNpcScriptsPtr ; $54c2
	ld a, [hl+] ; $54c5
	ld h, [hl] ; $54c6
	ld l, a ; $54c7
	call FindStoryScriptEntry ; $54c8
	ld a, h ; $54cb
	or l ; $54cc
	jp z, .checkRespawn ; $54cd
	ld a, [wStoryLocationBank] ; $54d0
	ld de, wStoryMapRecord ; $54d3
	ld bc, $0008 ; $54d6
	call FarCopyBytes ; $54d9
	ld hl, wStoryMapRecord + 6 ; $54dc
	ld b, [hl] ; $54df
	wram_bank $04 ; $54e0
	ld hl, wStoryMapRecord ; $54e6
	ld a, [hl] ; $54e9
	call GetActorStateAddr ; $54ea
	ld e, l ; $54ed
	ld d, h ; $54ee
	ld hl, $0019 ; $54ef
	add hl, de ; $54f2
	ld a, [hl] ; $54f3
	ld [wStoryScriptSavedActorBusy], a ; $54f4
	ld a, $01 ; $54f7
	ld [hl], a ; $54f9
	ld a, b ; $54fa
	and $08 ; $54fb
	jr z, .applyFlags ; $54fd
	ld hl, $002e ; $54ff
	add hl, de ; $5502
	ld a, [hl] ; $5503
	ld [wStoryScriptSavedActorAnim], a ; $5504
	ld a, $01 ; $5507
	push bc ; $5509
	push de ; $550a
	ld c, e ; $550b
	ld b, d ; $550c
	ld d, $01 ; $550d
	farcall SetActorAnimationChecked ; $550f
	pop de ; $5512
	pop bc ; $5513
.applyFlags:
	ld a, b ; $5514
	and $10 ; $5515
	jr z, .faceThePlayer ; $5517
	ld hl, $0005 ; $5519
	add hl, de ; $551c
	set 0, [hl] ; $551d
	set 1, [hl] ; $551f
.faceThePlayer:
	bit 0, b ; $5521
	jr z, .runScript ; $5523
	ld hl, $0014 ; $5525
	add hl, de ; $5528
	ld c, [hl] ; $5529
	ld a, [wPlayerMoveAngle] ; $552a
	add $80 ; $552d
	ld [hl], a ; $552f
.runScript:
	push de ; $5530
	ld hl, wStoryMapRecord + 4 ; $5531
	ld a, [hl+] ; $5534
	ld h, [hl] ; $5535
	ld l, a ; $5536
	ld a, [wStoryMapRecord] ; $5537
	call RunStoryScriptOrDialogue ; $553a
	pop de ; $553d
	bit 1, b ; $553e
	jr z, .restoreFlags ; $5540
	ld hl, $0014 ; $5542
	add hl, de ; $5545
	ld [hl], c ; $5546
.restoreFlags:
	ld a, b ; $5547
	and $10 ; $5548
	jr z, .restoreAnim ; $554a
	ld hl, $0005 ; $554c
	add hl, de ; $554f
	res 0, [hl] ; $5550
	res 1, [hl] ; $5552
.restoreAnim:
	ld a, b ; $5554
	and $08 ; $5555
	jr z, .clearBusy ; $5557
	push bc ; $5559
	push de ; $555a
	ld c, e ; $555b
	ld b, d ; $555c
	ld a, [wStoryScriptSavedActorAnim] ; $555d
	ld d, a ; $5560
	farcall SetActorAnimationChecked ; $5561
	pop de ; $5564
	pop bc ; $5565
.clearBusy:
	ld hl, $0019 ; $5566
	add hl, de ; $5569
	ld a, [wStoryScriptSavedActorBusy] ; $556a
	ld [hl], a ; $556d
.checkRespawn:
	pop hl ; $556e
	pop de ; $556f
	pop bc ; $5570
	pop af ; $5571
	ret ; $5572
.done:
	ret ; $5573
RunFacingTileScript:
	push af ; $5574
	push bc ; $5575
	push de ; $5576
	push hl ; $5577
	ld [wUnusedStoryScriptId], a ; $5578
	ld d, a ; $557b
	ld hl, wMapFacingScriptsPtr ; $557c
	ld a, [hl+] ; $557f
	ld h, [hl] ; $5580
	ld l, a ; $5581
	call FindStoryScriptEntry ; $5582
	ld a, h ; $5585
	or l ; $5586
	jr z, .done ; $5587
	ld a, [wStoryLocationBank] ; $5589
	ld de, wStoryMapRecord ; $558c
	ld bc, $0008 ; $558f
	call FarCopyBytes ; $5592
	ld hl, wStoryMapRecord + 4 ; $5595
	ld a, [hl+] ; $5598
	ld h, [hl] ; $5599
	ld l, a ; $559a
	ld a, $00 ; $559b
	call RunStoryScriptOrDialogue ; $559d
.done:
	pop hl ; $55a0
	pop de ; $55a1
	pop bc ; $55a2
	pop af ; $55a3
	ret ; $55a4
RunQueuedTriggerScript:
	push af ; $55a5
	push bc ; $55a6
	push de ; $55a7
	push hl ; $55a8
	ld [wUnusedStoryScriptId], a ; $55a9
	ld d, a ; $55ac
	ld hl, wMapTileTriggersPtr ; $55ad
	ld a, [hl+] ; $55b0
	ld h, [hl] ; $55b1
	ld l, a ; $55b2
	call FindStoryScriptEntry ; $55b3
	ld a, h ; $55b6
	or l ; $55b7
	jr z, .done ; $55b8
	ld a, [wStoryLocationBank] ; $55ba
	ld de, wStoryMapRecord ; $55bd
	ld bc, $0008 ; $55c0
	call FarCopyBytes ; $55c3
	ld a, [wStoryMapRecord + 6] ; $55c6
	cp $01 ; $55c9
	jr z, .done ; $55cb
	ld hl, wStoryMapRecord + 4 ; $55cd
	ld a, [hl+] ; $55d0
	ld h, [hl] ; $55d1
	ld l, a ; $55d2
	ld a, $00 ; $55d3
	call RunStoryScriptOrDialogue ; $55d5
.done:
	pop hl ; $55d8
	pop de ; $55d9
	pop bc ; $55da
	pop af ; $55db
	ret ; $55dc
RunTileTriggerScript:
	push af ; $55dd
	push bc ; $55de
	push de ; $55df
	push hl ; $55e0
	ld d, a ; $55e1
	ld hl, wMapTileTriggersPtr ; $55e2
	ld a, [hl+] ; $55e5
	ld h, [hl] ; $55e6
	ld l, a ; $55e7
	call FindStoryScriptEntry ; $55e8
	ld a, h ; $55eb
	or l ; $55ec
	jr z, .done ; $55ed
	ld a, [wStoryLocationBank] ; $55ef
	ld de, wStoryMapRecord ; $55f2
	ld bc, $0008 ; $55f5
	call FarCopyBytes ; $55f8
	ld hl, wStoryMapRecord + 4 ; $55fb
	ld a, [hl+] ; $55fe
	ld h, [hl] ; $55ff
	ld l, a ; $5600
	ld a, $00 ; $5601
	call RunStoryScriptOrDialogue ; $5603
.done:
	pop hl ; $5606
	pop de ; $5607
	pop bc ; $5608
	pop af ; $5609
	ret ; $560a
RunLocationExit:
	push af ; $560b
	push bc ; $560c
	push de ; $560d
	push hl ; $560e
	ld [wUnusedStoryScriptId], a ; $560f
	ld d, a ; $5612
	ld hl, wMapExitTriggersPtr ; $5613
	ld a, [hl+] ; $5616
	ld h, [hl] ; $5617
	ld l, a ; $5618
	call FindStoryScriptEntry ; $5619
	ld a, h ; $561c
	or l ; $561d
	jr z, .saveSlot ; $561e
	ld a, [wStoryLocationBank] ; $5620
	ld de, wStoryMapRecord ; $5623
	ld bc, $0008 ; $5626
	call FarCopyBytes ; $5629
	ld hl, wStoryMapRecord + 4 ; $562c
	ld a, [hl+] ; $562f
	ld h, [hl] ; $5630
	ld l, a ; $5631
	ld a, $00 ; $5632
	call RunStoryScriptOrDialogue ; $5634
	ld a, [wStoryMapRecord + 6] ; $5637
	ld [wStoryModeCurrentLocation], a ; $563a
	ld a, [wStoryMapRecord + 7] ; $563d
	ld [wStoryModeEntryPoint], a ; $5640
.saveSlot:
	xor a ; $5643
	ld a, a ; $5644
	ldh [hSramBank], a ; $5645
	ld [rRAMB], a ; $5647
	pop hl ; $564a
	pop de ; $564b
	pop bc ; $564c
	pop af ; $564d
	ret ; $564e
StoryLocationTable_0a:
	; $564f, 252 bytes (story_locations)
	story_location $00, $10, DataPtr_MainMenuMapScripts_10, $ff ; loc 0 Main Menu
	story_location $01, $10, DataPtr_DevelopmentMapScripts_10, $ff ; loc 1 Development
	story_location $02, $10, DataPtr_SmallCharTestMapScripts_0f, $ff ; loc 2 Small Char. Test
	story_location $03, $10, DataPtr_MatchSelectMapScripts_10, $ff ; loc 3 Test
	story_location $04, $10, DataPtr_Test2MapScripts_10, $0b ; loc 4 Test 2
	story_location $05, $11, DataPtr_AcademyMainBldgMapScripts_10, $1a ; loc 5 Academy Main Bldg.
	story_location $06, $11, DataPtr_AcademyWingMapScripts_10, $1a ; loc 6 Academy Wing
	story_location $07, $14, DataPtr_CourtyardMapScripts_13, $1b ; loc 7 Courtyard
	story_location $08, $13, DataPtr_RestaurantPlazaMapScripts_13, $1b ; loc 8 Restaurant Plaza
	story_location $09, $1b, DataPtr_DormEntranceMapScripts_12, $1b ; loc 9 Dorm Entrance
	story_location $0a, $12, DataPtr_DormRoomMapScripts_13, $00 ; loc 10 Dorm Room
	story_location $0b, $18, DataPtr_JuniorClassCourtSinglesMapScripts_11, $1b ; loc 11 Junior Class Court
	story_location $0c, $18, DataPtr_JuniorClassCourtDoublesMapScripts_11, $1b ; loc 12 Junior Class Court
	story_location $0d, $19, DataPtr_RestaurantMapScripts_10, $1d ; loc 13 Restaurant
	story_location $0e, $19, DataPtr_CafeteriaMapScripts_10, $1d ; loc 14 Cafeteria
	story_location $0f, $1e, DataPtr_TrainingCourtMapScripts_15, $1b ; loc 15 Training Court
	story_location $10, $17, DataPtr_SeniorCourtMapScripts_12, $1b ; loc 16 Senior Class Court
	story_location $11, $22, DataPtr_TrainingGymMapScripts_0e, $1d ; loc 17 Training Center
	story_location $12, $22, DataPtr_TennisMachineRoomMapScripts_14, $1d ; loc 18 Tennis Machine Room
	story_location $13, $22, DataPtr_WallPracticeRoomMapScripts_12, $1d ; loc 19 Wall Practice Room
	story_location $14, $1a, DataPtr_AcademyArrivalMapScripts_11, $1b ; loc 20 Academy Entrance
	story_location $15, $1c, DataPtr_TournamentCourtyardMapScripts_15, $1b ; loc 21 Tournament Courtyard
	story_location $16, $1d, DataPtr_Court1MapScripts_14, $1b ; loc 22 Court #1
	story_location $17, $1f, DataPtr_Court2MapScripts_14, $1b ; loc 23 Court #2
	story_location $18, $20, DataPtr_CenterCourtMapScripts_11, $1d ; loc 24 Center Court
	story_location $19, $23, DataPtr_TournamentMapScripts_0f, $1d ; loc 25 Tournament
	story_location $1a, $24, DataPtr_AwardsCeremonyMapScripts_0f, $1b ; loc 26 Awards Ceremony
	story_location $1b, $15, DataPtr_IslandSkyMapScripts_14, $1b ; loc 27 Island Sky
	story_location $1c, $16, DataPtr_SpecialCourtMapScripts_0e, $08 ; loc 28 Special Court
	story_location $1d, $21, DataPtr_MarioWorldMapScripts_0e, $12 ; loc 29 Peach's Castle
	story_location $1e, $1a, DataPtr_End1MainBldgMapScripts_27, $2c ; loc 30 End1 Main Bldg
	story_location $1f, $13, DataPtr_EndRestaurantEntMapScripts_27, $ff ; loc 31 End Restaurant Ent.
	story_location $20, $1b, DataPtr_End3DormEntMapScripts_27, $ff ; loc 32 End3 Dorm Ent.
	story_location $21, $18, DataPtr_End4JrCourtMapScripts_27, $ff ; loc 33 End4 Jr. Court
	story_location $22, $19, DataPtr_End5ServiceAceMapScripts_27, $ff ; loc 34 End5 Service Ace
	story_location $23, $22, DataPtr_End7TrainingCtrMapScripts_27, $ff ; loc 35 End7 Training Ctr.
	story_location $24, $17, DataPtr_End8SrCourtMapScripts_27, $ff ; loc 36 End8 Sr. Court
	story_location $25, $14, DataPtr_End10VarsityCourtMapScripts_27, $ff ; loc 37 End10 Varsity Court
	story_location $26, $1e, DataPtr_End11TrainingCourtMapScripts_27, $ff ; loc 38 End11 Training Court
	story_location $27, $11, DataPtr_End12PrincipalsOfficeMapScripts_27, $ff ; loc 39 End12 Principal's Office
	story_location $28, $23, DataPtr_End16BeforeFinalsMapScripts_27, $ff ; loc 40 End16 Before Finals
	story_location $29, $24, DataPtr_End17AwardCeremonyMapScripts_27, $ff ; loc 41 End17 Award Ceremony
GetStoryLocationCount:
	ld a, $2a ; $574b
	ret ; $574d
GetStoryLocationRecordPtr:
	ld h, a ; $574e
	add a ; $574f
	add h ; $5750
	add a ; $5751
	add $4f ; $5752
	ld l, a ; $5754
	adc $56 ; $5755
	sub l ; $5757
	ld h, a ; $5758
	ret ; $5759
	db $ff ; $575a
	ret ; $575b
CopySceneTilemapToVram:
	push af ; $575c
	push bc ; $575d
	push de ; $575e
	push hl ; $575f
	ld a, [wCameraY + 1] ; $5760
	and $1f ; $5763
	ld l, a ; $5765
	ld h, $00 ; $5766
	add hl, hl ; $5768
	add hl, hl ; $5769
	add hl, hl ; $576a
	add hl, hl ; $576b
	add hl, hl ; $576c
	ld a, [wCameraX + 1] ; $576d
	and $1f ; $5770
	add l ; $5772
	ld l, a ; $5773
	ld de, $9800 ; $5774
	add hl, de ; $5777
	push hl ; $5778
	ld a, [wCameraY + 1] ; $5779
	ld l, a ; $577c
	ld h, $00 ; $577d
	add hl, hl ; $577f
	add hl, hl ; $5780
	add hl, hl ; $5781
	add hl, hl ; $5782
	add hl, hl ; $5783
	add hl, hl ; $5784
	ld a, [wCameraX + 1] ; $5785
	add l ; $5788
	ld l, a ; $5789
	ld de, $d000 ; $578a
	add hl, de ; $578d
	pop de ; $578e
	wram_bank $02 ; $578f
	ld a, $01 ; $5795
	ldh [rVBK], a ; $5797
	push de ; $5799
	push hl ; $579a
	call CopySceneTilemapChunk ; $579b
	call CopySceneTilemapChunk ; $579e
	call CopySceneTilemapChunk ; $57a1
	call CopySceneTilemapChunk ; $57a4
	call CopySceneTilemapChunk ; $57a7
	call CopySceneTilemapChunk ; $57aa
	call CopySceneTilemapChunk ; $57ad
	call CopySceneTilemapChunk ; $57b0
	call CopySceneTilemapChunk ; $57b3
	call CopySceneTilemapChunk ; $57b6
	call CopySceneTilemapChunk ; $57b9
	call CopySceneTilemapChunk ; $57bc
	call CopySceneTilemapChunk ; $57bf
	call CopySceneTilemapChunk ; $57c2
	call CopySceneTilemapChunk ; $57c5
	call CopySceneTilemapChunk ; $57c8
	call CopySceneTilemapChunk ; $57cb
	call CopySceneTilemapChunk ; $57ce
	call CopySceneTilemapChunk ; $57d1
	call CopySceneTilemapChunk ; $57d4
	pop hl ; $57d7
	pop de ; $57d8
	wram_bank $03 ; $57d9
	xor a ; $57df
	ldh [rVBK], a ; $57e0
	call CopySceneTilemapChunk ; $57e2
	call CopySceneTilemapChunk ; $57e5
	call CopySceneTilemapChunk ; $57e8
	call CopySceneTilemapChunk ; $57eb
	call CopySceneTilemapChunk ; $57ee
	call CopySceneTilemapChunk ; $57f1
	call CopySceneTilemapChunk ; $57f4
	call CopySceneTilemapChunk ; $57f7
	call CopySceneTilemapChunk ; $57fa
	call CopySceneTilemapChunk ; $57fd
	call CopySceneTilemapChunk ; $5800
	call CopySceneTilemapChunk ; $5803
	call CopySceneTilemapChunk ; $5806
	call CopySceneTilemapChunk ; $5809
	call CopySceneTilemapChunk ; $580c
	call CopySceneTilemapChunk ; $580f
	call CopySceneTilemapChunk ; $5812
	call CopySceneTilemapChunk ; $5815
	call CopySceneTilemapChunk ; $5818
	call CopySceneTilemapChunk ; $581b
	pop hl ; $581e
	pop de ; $581f
	pop bc ; $5820
	pop af ; $5821
	ret ; $5822
CopySceneTilemapChunk:
	push de ; $5823
	push hl ; $5824
	ld c, $16 ; $5825
.copyLoop:
	ld a, [hl+] ; $5827
	ld [de], a ; $5828
	inc de ; $5829
	ld a, l ; $582a
	and $3f ; $582b
	jr nz, .checkDestWrap ; $582d
	ld a, l ; $582f
	sub $40 ; $5830
	ld l, a ; $5832
	jr nc, .srcWrapped ; $5833
	dec h ; $5835
.srcWrapped:
	jr .wrapDest ; $5836
.checkDestWrap:
	ld a, e ; $5838
	and $1f ; $5839
	jr nz, .next ; $583b
.wrapDest:
	ld a, e ; $583d
	sub $20 ; $583e
	ld e, a ; $5840
	jr nc, .next ; $5841
	dec d ; $5843
.next:
	dec c ; $5844
	jr nz, .copyLoop ; $5845
	pop hl ; $5847
	ld de, $0040 ; $5848
	add hl, de ; $584b
	ld a, h ; $584c
	and $0f ; $584d
	or $d0 ; $584f
	ld h, a ; $5851
	pop de ; $5852
	ld a, $20 ; $5853
	add e ; $5855
	ld e, a ; $5856
	jr nc, .done ; $5857
	inc d ; $5859
.done:
	res 2, d ; $585a
	ret ; $585c
LoadStorySceneGraphics:
	push af ; $585d
	push bc ; $585e
	push de ; $585f
	push hl ; $5860
	ld [wCurrentScene], a ; $5861
	ld h, $00 ; $5864
	ld l, a ; $5866
	add hl, hl ; $5867
	add hl, hl ; $5868
	add hl, hl ; $5869
	add hl, hl ; $586a
	ld de, SceneGfxSlotTable ; $586b
	add hl, de ; $586e
	ld a, [hl+] ; $586f
	ld c, a ; $5870
	ld a, [hl+] ; $5871
	ld b, a ; $5872
	push bc ; $5873
	ld a, [hl+] ; $5874
	ld c, a ; $5875
	ld a, [hl+] ; $5876
	ld b, a ; $5877
	push bc ; $5878
	ld a, [hl+] ; $5879
	ld c, a ; $587a
	ld a, [hl+] ; $587b
	ld b, a ; $587c
	push bc ; $587d
	ld a, [hl+] ; $587e
	ld c, a ; $587f
	ld a, [hl+] ; $5880
	ld b, a ; $5881
	push bc ; $5882
	ld a, [hl+] ; $5883
	ld c, a ; $5884
	ld a, [hl+] ; $5885
	ld b, a ; $5886
	push bc ; $5887
	ld a, [hl+] ; $5888
	ld c, a ; $5889
	ld a, [hl+] ; $588a
	ld b, a ; $588b
	push bc ; $588c
	ld a, [hl+] ; $588d
	ld c, a ; $588e
	ld a, [hl+] ; $588f
	ld b, a ; $5890
	push bc ; $5891
	wram_bank $01 ; $5892
	ld a, [hl+] ; $5898
	ld h, [hl] ; $5899
	ld l, a ; $589a
	ld de, wDecompBuffer ; $589b
	call DecompressDataFromBank ; $589e
	ld hl, wDecompBuffer ; $58a1
	ld de, $9000 + VRAM_BANK1 ; $58a4
	ld c, $80 ; $58a7
	call QueueVRAMCopy ; $58a9
	ld hl, wTextTileBuffer ; $58ac
	ld de, $8800 + VRAM_BANK1 ; $58af
	ld c, $80 ; $58b2
	call QueueVRAMCopy ; $58b4
	wram_bank $06 ; $58b7
	pop hl ; $58bd
	ld de, wStorySceneUnusedBuffer ; $58be
	pop hl ; $58c1
	ld de, wBehaviorMap ; $58c2
	call DecompressDataFromBank ; $58c5
	pop hl ; $58c8
	ld de, wCollisionMap ; $58c9
	call DecompressDataFromBank ; $58cc
	wram_bank $02 ; $58cf
	pop hl ; $58d5
	ld de, wScreenAttrmap ; $58d6
	call DecompressDataFromBank ; $58d9
	wram_bank $03 ; $58dc
	pop hl ; $58e2
	ld de, wShadowTilemap ; $58e3
	call DecompressDataFromBank ; $58e6
	wram_bank $01 ; $58e9
	pop hl ; $58ef
	ld de, wDecompBuffer ; $58f0
	ld bc, $0040 ; $58f3
	call CopyDataFromBank ; $58f6
	ld hl, wDecompBuffer + 1 * TILE_SIZE ; $58f9
	ld de, $0206 ; $58fc
	call LoadPaletteShadow ; $58ff
	wram_bank $06 ; $5902
	pop hl ; $5908
	ld de, wStorySceneRecord ; $5909
	ld bc, $0088 ; $590c
	call CopyDataFromBank ; $590f
	ld hl, wStorySceneRecord + 2 ; $5912
	ld a, [hl+] ; $5915
	ld [wMapScrollMinX], a ; $5916
	ld a, [hl+] ; $5919
	ld [wMapScrollMinY], a ; $591a
	ld a, [hl+] ; $591d
	ld [wMapWidthTiles], a ; $591e
	ld a, [hl+] ; $5921
	ld [wMapHeightTiles], a ; $5922
	ld a, [wCurrentScene] ; $5925
	call InitSceneTileAnimations ; $5928
	pop hl ; $592b
	pop de ; $592c
	pop bc ; $592d
	pop af ; $592e
	ret ; $592f
InitSceneScroll:
	push af ; $5930
	push bc ; $5931
	push de ; $5932
	push hl ; $5933
	ld a, $25 ; $5934
	ld [wScrollListLength], a ; $5936
	xor a ; $5939
	ldh [hScrollY], a ; $593a
	ldh [hScrollX], a ; $593c
	ldh [hBGColumnBlitPending], a ; $593e
	ldh [hBGRowBlitPending], a ; $5940
	ld [wCameraX], a ; $5942
	ld [wCameraX + 1], a ; $5945
	ld [wCameraY], a ; $5948
	ld [wCameraY + 1], a ; $594b
	ld [wCameraTileXPrev], a ; $594e
	ld [wCameraTileYPrev], a ; $5951
	ld [wMapScrollMinX], a ; $5954
	ld [wMapScrollMinY], a ; $5957
	ld a, $40 ; $595a
	ld [wMapWidthTiles], a ; $595c
	ld [wMapHeightTiles], a ; $595f
	ld a, $0f ; $5962
	ld hl, UpdateSceneScroll ; $5964
	call RegisterFrameTask ; $5967
	pop hl ; $596a
	pop de ; $596b
	pop bc ; $596c
	pop af ; $596d
	ret ; $596e
StopSceneScrollTask:
	ld hl, UpdateSceneScroll ; $596f
	call UnregisterFrameTask ; $5972
	ret ; $5975
UpdateSceneScroll:
	ld a, [wCameraTileYPrev] ; $5976
	ld h, a ; $5979
	ld a, [wCameraY + 1] ; $597a
	sub h ; $597d
	jr z, .checkX ; $597e
	bit 7, a ; $5980
	jr nz, .scrollUp ; $5982
	ld bc, $fb13 ; $5984
	call BlitBGRowFrom64 ; $5987
	jr .checkX ; $598a
.scrollUp:
	ld bc, $fb00 ; $598c
	call BlitBGRowFrom64 ; $598f
.checkX:
	ld a, [wCameraTileXPrev] ; $5992
	ld h, a ; $5995
	ld a, [wCameraX + 1] ; $5996
	sub h ; $5999
	jr z, .storeCamera ; $599a
	bit 7, a ; $599c
	jr nz, .scrollLeft ; $599e
	ld bc, $15fa ; $59a0
	call BlitBGColumnFrom64 ; $59a3
	jr .storeCamera ; $59a6
.scrollLeft:
	ld bc, $00fa ; $59a8
	call BlitBGColumnFrom64 ; $59ab
.storeCamera:
	ld a, [wCameraY] ; $59ae
	ld l, a ; $59b1
	ld a, [wCameraY + 1] ; $59b2
	ld h, a ; $59b5
	ld [wCameraTileYPrev], a ; $59b6
	add hl, hl ; $59b9
	add hl, hl ; $59ba
	add hl, hl ; $59bb
	ld a, h ; $59bc
	ld hl, wScreenShakeOffsetY ; $59bd
	add [hl] ; $59c0
	ldh [hScrollY], a ; $59c1
	ld a, [wCameraX] ; $59c3
	ld l, a ; $59c6
	ld a, [wCameraX + 1] ; $59c7
	ld h, a ; $59ca
	ld [wCameraTileXPrev], a ; $59cb
	add hl, hl ; $59ce
	add hl, hl ; $59cf
	add hl, hl ; $59d0
	ld a, h ; $59d1
	ld hl, wScreenShakeOffsetX ; $59d2
	add [hl] ; $59d5
	ldh [hScrollX], a ; $59d6
	ret ; $59d8
SceneGfxSlotTable:
	; $59d9, 592 bytes (37 records x 8 slot words)
	dslot DataPtr_ClubhouseSceneAuxTilemap, DataPtr_ClubhouseScenePalettes, DataPtr_ClubhouseSceneTilemap, DataPtr_ClubhouseSceneAttrmap, DataPtr_ClubhouseSceneAuxTilemapAlias1, DataPtr_ClubhouseSceneAuxAttrmap, DataPtr_CourtyardScenePalettes, DataPtr_ClubhouseSceneTiles ; record 0
	dslot DataPtr_CourtyardSceneAuxTilemap, DataPtr_CourtyardScenePalettesAlias1, DataPtr_CourtyardSceneTilemap, DataPtr_CourtyardSceneAttrmap, DataPtr_CourtyardSceneAuxTilemapAlias1, DataPtr_CourtyardSceneAuxAttrmap, DataPtr_CourtyardSceneUnusedSlot, DataPtr_CourtyardSceneTiles ; record 1
	dslot DataPtr_GrassCourtSceneConfig, DataPtr_GrassCourtPalettes, DataPtr_GrassCourtTilemap, DataPtr_GrassCourtAttrmap, DataPtr_GrassCourtSceneConfigAlias1, DataPtr_GrassCourtSceneConfigB, DataPtr_HardCourtPalettes, DataPtr_GrassCourtTiles ; record 2
	dslot DataPtr_HardCourtSceneConfig, DataPtr_HardCourtPalettesAlias1, DataPtr_HardCourtTilemap, DataPtr_HardCourtAttrmap, DataPtr_HardCourtSceneConfigAlias1, DataPtr_HardCourtSceneConfigB, DataPtr_ClayCourtPalettes, DataPtr_HardCourtTiles ; record 3
	dslot DataPtr_ClayCourtSceneConfig, DataPtr_ClayCourtPalettesAlias1, DataPtr_ClayCourtTilemap, DataPtr_ClayCourtAttrmap, DataPtr_ClayCourtSceneConfigAlias1, DataPtr_ClayCourtSceneConfigB, DataPtr_CompositionCourtPalettes, DataPtr_ClayCourtTiles ; record 4
	dslot DataPtr_CompositionCourtSceneConfig, DataPtr_CompositionCourtPalettesAlias1, DataPtr_CompositionCourtTilemap, DataPtr_CompositionCourtAttrmap, DataPtr_CompositionCourtSceneConfigAlias1, DataPtr_CompositionCourtSceneConfigB, DataPtr_CompositionCourtSceneUnusedSlot, DataPtr_CompositionCourtTiles ; record 5
	dslot DataPtr_MachineCourtSceneConfig, DataPtr_MachineCourtPalettes, DataPtr_MachineCourtTilemap, DataPtr_MachineCourtAttrmap, DataPtr_MachineCourtSceneConfigAlias1, DataPtr_MachineCourtSceneConfigB, DataPtr_CenterCourtPalettes, DataPtr_MachineCourtTiles ; record 6
	dslot DataPtr_CenterCourtSceneConfig, DataPtr_CenterCourtPalettesAlias1, DataPtr_CenterCourtTilemap, DataPtr_CenterCourtAttrmap, DataPtr_CenterCourtSceneConfigAlias1, DataPtr_CenterCourtSceneConfigB, DataPtr_PracticeCourtPalettes, DataPtr_CenterCourtTiles ; record 7
	dslot DataPtr_PracticeCourtSceneConfig, DataPtr_PracticeCourtPalettesAlias1, DataPtr_PracticeCourtTilemap, DataPtr_PracticeCourtAttrmap, DataPtr_PracticeCourtSceneConfigAlias1, DataPtr_PracticeCourtSceneConfigB, DataPtr_YoshiCourtPalettes, DataPtr_PracticeCourtTiles ; record 8
	dslot DataPtr_YoshiCourtSceneConfig, DataPtr_YoshiCourtPalettesAlias1, DataPtr_YoshiCourtTilemap, DataPtr_YoshiCourtAttrmap, DataPtr_YoshiCourtSceneConfigAlias1, DataPtr_YoshiCourtSceneConfigB, DataPtr_YoshiCourtSceneUnusedSlot, DataPtr_YoshiCourtTiles ; record 9
	dslot DataPtr_StarCourtSceneConfig, DataPtr_StarCourtPalettes, DataPtr_StarCourtTilemap, DataPtr_StarCourtAttrmap, DataPtr_StarCourtSceneConfigAlias1, DataPtr_StarCourtSceneConfigB, DataPtr_BowserCourtPalettes, DataPtr_StarCourtTiles ; record 10
	dslot DataPtr_BowserCourtSceneConfig, DataPtr_BowserCourtPalettesAlias1, DataPtr_BowserCourtTilemap, DataPtr_BowserCourtAttrmap, DataPtr_BowserCourtSceneConfigAlias1, DataPtr_BowserCourtSceneConfigB, DataPtr_WarioCourtPalettes, DataPtr_BowserCourtTiles ; record 11
	dslot DataPtr_WarioCourtSceneConfig, DataPtr_WarioCourtPalettesAlias1, DataPtr_WarioCourtTilemap, DataPtr_WarioCourtAttrmap, DataPtr_WarioCourtSceneConfigAlias1, DataPtr_WarioCourtSceneConfigB, DataPtr_PeachCourtPalettes, DataPtr_WarioCourtTiles ; record 12
	dslot DataPtr_PeachCourtSceneConfig, DataPtr_PeachCourtPalettesAlias1, DataPtr_PeachCourtTilemap, DataPtr_PeachCourtAttrmap, DataPtr_PeachCourtSceneConfigAlias1, DataPtr_PeachCourtSceneConfigB, DataPtr_PeachCourtSceneUnusedSlot, DataPtr_PeachCourtTiles ; record 13
	dslot DataPtr_IslandOpenCourtSceneConfig, DataPtr_IslandOpenCourtPalettes, DataPtr_IslandOpenCourtTilemap, DataPtr_IslandOpenCourtAttrmap, DataPtr_IslandOpenCourtSceneConfigAlias1, DataPtr_IslandOpenCourtSceneConfigB, DataPtr_DKCourtPalettes, DataPtr_IslandOpenCourtTiles ; record 14
	dslot DataPtr_DKCourtSceneConfig, DataPtr_DKCourtPalettesAlias1, DataPtr_DKCourtTilemap, DataPtr_DKCourtAttrmap, DataPtr_DKCourtSceneConfigAlias1, DataPtr_DKCourtSceneConfigB, DataPtr_StarPatternBgSceneConfig, DataPtr_DKCourtTiles ; record 15
	dslot DataPtr_StarPatternBgSceneConfigAlias1, DataPtr_StarPatternBgPalettes, DataPtr_StarPatternBgTilemap, DataPtr_StarPatternBgAttrmap, DataPtr_StarPatternBgAuxTilemap, DataPtr_StarPatternBgAuxAttrmap, DataPtr_DormInteriorSceneConfig, DataPtr_StarPatternBgTiles ; record 16
	dslot DataPtr_DormInteriorSceneConfigAlias1, DataPtr_DormInteriorPalettes, DataPtr_DormInteriorTilemap, DataPtr_DormInteriorAttrmap, DataPtr_DormInteriorAuxTilemap, DataPtr_DormInteriorAuxAttrmap, DataPtr_DormInteriorSceneUnusedSlot, DataPtr_DormInteriorTiles ; record 17
	dslot DataPtr_DormBedroomSceneConfig, DataPtr_DormBedroomPalettes, DataPtr_DormBedroomTilemap, DataPtr_DormBedroomAttrmap, DataPtr_DormBedroomAuxTilemap, DataPtr_DormBedroomAuxAttrmap, DataPtr_CountrysideSceneConfig, DataPtr_DormBedroomTiles ; record 18
	dslot DataPtr_CountrysideSceneConfigAlias1, DataPtr_CountrysidePalettes, DataPtr_CountrysideTilemap, DataPtr_CountrysideAttrmap, DataPtr_CountrysideAuxTilemap, DataPtr_CountrysideAuxAttrmap, DataPtr_AcademyGroundsSceneConfig, DataPtr_CountrysideTiles ; record 19
	dslot DataPtr_AcademyGroundsSceneConfigAlias1, DataPtr_AcademyGroundsPalettes, DataPtr_AcademyGroundsTilemap, DataPtr_AcademyGroundsAttrmap, DataPtr_AcademyGroundsAuxTilemap, DataPtr_AcademyGroundsAuxAttrmap, DataPtr_AcademyGroundsSceneUnusedSlot, DataPtr_AcademyGroundsTiles ; record 20
	dslot DataPtr_SeasideSceneConfig, DataPtr_SeasidePalettes, DataPtr_SeasideTilemap, DataPtr_SeasideAttrmap, DataPtr_SeasideAuxTilemap, DataPtr_SeasideAuxAttrmap, DataPtr_SeasideSceneUnusedSlot, DataPtr_SeasideTiles ; record 21
	dslot DataPtr_HedgeCourtSceneConfig, DataPtr_HedgeCourtPalettes, DataPtr_HedgeCourtTilemap, DataPtr_HedgeCourtAttrmap, DataPtr_HedgeCourtAuxTilemap, DataPtr_HedgeCourtAuxAttrmap, DataPtr_HedgeCourtSceneUnusedSlot, DataPtr_HedgeCourtTiles ; record 22
	dslot DataPtr_ClayCourtGroundsSceneConfig, DataPtr_ClayCourtGroundsPalettes, DataPtr_ClayCourtGroundsTilemap, DataPtr_ClayCourtGroundsAttrmap, DataPtr_ClayCourtGroundsAuxTilemap, DataPtr_ClayCourtGroundsAuxAttrmap, DataPtr_ClayCourtGroundsSceneUnusedSlot, DataPtr_ClayCourtGroundsTiles ; record 23
	dslot DataPtr_HardCourtGroundsSceneConfig, DataPtr_HardCourtGroundsPalettes, DataPtr_HardCourtGroundsTilemap, DataPtr_HardCourtGroundsAttrmap, DataPtr_HardCourtGroundsAuxTilemap, DataPtr_HardCourtGroundsAuxAttrmap, DataPtr_SpaResortSceneConfig, DataPtr_HardCourtGroundsTiles ; record 24
	dslot DataPtr_SpaResortSceneConfigAlias1, DataPtr_SpaResortPalettes, DataPtr_SpaResortTilemap, DataPtr_SpaResortAttrmap, DataPtr_SpaResortAuxTilemap, DataPtr_SpaResortAuxAttrmap, DataPtr_MainBuildingSceneConfig, DataPtr_SpaResortTiles ; record 25
	dslot DataPtr_MainBuildingSceneConfigAlias1, DataPtr_MainBuildingPalettes, DataPtr_MainBuildingTilemap, DataPtr_MainBuildingAttrmap, DataPtr_MainBuildingAuxTilemap, DataPtr_MainBuildingAuxAttrmap, DataPtr_GardenPavilionSceneConfig, DataPtr_MainBuildingTiles ; record 26
	dslot DataPtr_GardenPavilionSceneConfigAlias1, DataPtr_GardenPavilionPalettes, DataPtr_GardenPavilionTilemap, DataPtr_GardenPavilionAttrmap, DataPtr_GardenPavilionAuxTilemap, DataPtr_GardenPavilionAuxAttrmap, DataPtr_GardenPavilionSceneUnusedSlot, DataPtr_GardenPavilionTiles ; record 27
	dslot DataPtr_FountainCourtSceneConfig, DataPtr_FountainCourtPalettes, DataPtr_FountainCourtTilemap, DataPtr_FountainCourtAttrmap, DataPtr_FountainCourtAuxTilemap, DataPtr_FountainCourtAuxAttrmap, DataPtr_FountainCourtSceneUnusedSlot, DataPtr_FountainCourtTiles ; record 28
	dslot DataPtr_CafeCourtSceneConfig, DataPtr_CafeCourtPalettes, DataPtr_CafeCourtTilemap, DataPtr_CafeCourtAttrmap, DataPtr_CafeCourtAuxTilemap, DataPtr_CafeCourtAuxAttrmap, DataPtr_CourtComplexSceneConfig, DataPtr_CafeCourtTiles ; record 29
	dslot DataPtr_CourtComplexSceneConfigAlias1, DataPtr_CourtComplexPalettes, DataPtr_CourtComplexTilemap, DataPtr_CourtComplexAttrmap, DataPtr_CourtComplexAuxTilemap, DataPtr_CourtComplexAuxAttrmap, DataPtr_CourtComplexSceneUnusedSlot, DataPtr_CourtComplexTiles ; record 30
	dslot DataPtr_ClubCourtSceneConfig, DataPtr_ClubCourtPalettes, DataPtr_ClubCourtTilemap, DataPtr_ClubCourtAttrmap, DataPtr_ClubCourtAuxTilemap, DataPtr_ClubCourtAuxAttrmap, DataPtr_StadiumGroundsSceneConfig, DataPtr_ClubCourtTiles ; record 31
	dslot DataPtr_StadiumGroundsSceneConfigAlias1, DataPtr_StadiumGroundsPalettes, DataPtr_StadiumGroundsTilemap, DataPtr_StadiumGroundsAttrmap, DataPtr_StadiumGroundsAuxTilemap, DataPtr_StadiumGroundsAuxAttrmap, DataPtr_CeremonyHallSceneConfig, DataPtr_StadiumGroundsTiles ; record 32
	dslot DataPtr_CeremonyHallSceneConfigAlias1, DataPtr_CeremonyHallPalettes, DataPtr_CeremonyHallTilemap, DataPtr_CeremonyHallAttrmap, DataPtr_CeremonyHallAuxTilemap, DataPtr_CeremonyHallAuxAttrmap, DataPtr_CeremonyHallSceneUnusedSlot, DataPtr_CeremonyHallTiles ; record 33
	dslot DataPtr_TrainingHallSceneConfig, DataPtr_TrainingHallPalettes, DataPtr_TrainingHallTilemap, DataPtr_TrainingHallAttrmap, DataPtr_TrainingHallAuxTilemap, DataPtr_TrainingHallAuxAttrmap, DataPtr_CenterCourtHallSceneConfig, DataPtr_TrainingHallTiles ; record 34
	dslot DataPtr_CenterCourtHallSceneConfigAlias1, DataPtr_CenterCourtHallPalettes, DataPtr_CenterCourtHallTilemap, DataPtr_CenterCourtHallAttrmap, DataPtr_CenterCourtHallAuxTilemap, DataPtr_CenterCourtHallAuxAttrmap, DataPtr_ClubroomInteriorSceneConfig, DataPtr_CenterCourtHallTiles ; record 35
	dslot DataPtr_ClubroomInteriorSceneConfigAlias1, DataPtr_ClubroomInteriorPalettes, DataPtr_ClubroomInteriorTilemap, DataPtr_ClubroomInteriorAttrmap, DataPtr_ClubroomInteriorAuxTilemap, DataPtr_ClubroomInteriorAuxAttrmap, DataPtr_ClubroomInteriorSceneUnusedSlot, DataPtr_ClubroomInteriorTiles ; record 36
CopyScrolledSceneTilemapToVram:
	push af ; $5c29
	push bc ; $5c2a
	push de ; $5c2b
	push hl ; $5c2c
	or a ; $5c2d
	jr z, .fromPlayer ; $5c2e
	ld a, [wCameraX + 1] ; $5c30
	ld h, a ; $5c33
	ld a, [wCameraY + 1] ; $5c34
	ld l, a ; $5c37
	jp .gotCamera ; $5c38
.fromPlayer:
	call UpdateCameraFromPlayer ; $5c3b
	ld h, b ; $5c3e
	ld l, d ; $5c3f
.gotCamera:
	push hl ; $5c40
	ld a, l ; $5c41
	and $1f ; $5c42
	ld l, a ; $5c44
	ld a, h ; $5c45
	and $1f ; $5c46
	ld h, $00 ; $5c48
	add hl, hl ; $5c4a
	add hl, hl ; $5c4b
	add hl, hl ; $5c4c
	add hl, hl ; $5c4d
	add hl, hl ; $5c4e
	add l ; $5c4f
	ld l, a ; $5c50
	ld de, $9800 ; $5c51
	add hl, de ; $5c54
	ld e, l ; $5c55
	ld d, h ; $5c56
	pop hl ; $5c57
	push de ; $5c58
	ld a, h ; $5c59
	ld h, $00 ; $5c5a
	add hl, hl ; $5c5c
	add hl, hl ; $5c5d
	add hl, hl ; $5c5e
	add hl, hl ; $5c5f
	add hl, hl ; $5c60
	add hl, hl ; $5c61
	add l ; $5c62
	ld l, a ; $5c63
	ld de, wMapBuffer64 ; $5c64
	add hl, de ; $5c67
	pop de ; $5c68
	push hl ; $5c69
	push de ; $5c6a
	wram_bank $02 ; $5c6b
	ld a, $01 ; $5c71
	ldh [rVBK], a ; $5c73
	ld b, $15 ; $5c75
.attrRowLoop:
	ld c, $17 ; $5c77
	push de ; $5c79
	push hl ; $5c7a
.attrCellLoop:
	ld a, [hl+] ; $5c7b
	ld [de], a ; $5c7c
	inc de ; $5c7d
	ld a, l ; $5c7e
	and $3f ; $5c7f
	jr nz, .attrCheckDestWrap ; $5c81
	push de ; $5c83
	ld de, $ffc0 ; $5c84
	add hl, de ; $5c87
	pop de ; $5c88
	jr .attrWrapDest ; $5c89
.attrCheckDestWrap:
	ld a, e ; $5c8b
	and $1f ; $5c8c
	jr nz, .attrNextCell ; $5c8e
.attrWrapDest:
	push hl ; $5c90
	ld hl, $ffe0 ; $5c91
	add hl, de ; $5c94
	ld e, l ; $5c95
	ld d, h ; $5c96
	pop hl ; $5c97
.attrNextCell:
	dec c ; $5c98
	jr nz, .attrCellLoop ; $5c99
	pop hl ; $5c9b
	ld a, $40 ; $5c9c
	add l ; $5c9e
	ld l, a ; $5c9f
	jr nc, .attrRowSrcOk ; $5ca0
	ld a, h ; $5ca2
	inc a ; $5ca3
	and $0f ; $5ca4
	or $d0 ; $5ca6
	ld h, a ; $5ca8
.attrRowSrcOk:
	pop de ; $5ca9
	ld a, $20 ; $5caa
	add e ; $5cac
	ld e, a ; $5cad
	jr nc, .attrNextRow ; $5cae
	ld a, d ; $5cb0
	inc a ; $5cb1
	res 2, a ; $5cb2
	ld d, a ; $5cb4
.attrNextRow:
	dec b ; $5cb5
	jr nz, .attrRowLoop ; $5cb6
	pop de ; $5cb8
	pop hl ; $5cb9
	wram_bank $03 ; $5cba
	xor a ; $5cc0
	ldh [rVBK], a ; $5cc1
	ld b, $15 ; $5cc3
.tileRowLoop:
	ld c, $17 ; $5cc5
	push de ; $5cc7
	push hl ; $5cc8
.tileCellLoop:
	ld a, [hl+] ; $5cc9
	ld [de], a ; $5cca
	inc de ; $5ccb
	ld a, l ; $5ccc
	and $3f ; $5ccd
	jr nz, .tileCheckDestWrap ; $5ccf
	push de ; $5cd1
	ld de, $ffc0 ; $5cd2
	add hl, de ; $5cd5
	pop de ; $5cd6
	jr .tileWrapDest ; $5cd7
.tileCheckDestWrap:
	ld a, e ; $5cd9
	and $1f ; $5cda
	jr nz, .tileNextCell ; $5cdc
.tileWrapDest:
	push hl ; $5cde
	ld hl, $ffe0 ; $5cdf
	add hl, de ; $5ce2
	ld e, l ; $5ce3
	ld d, h ; $5ce4
	pop hl ; $5ce5
.tileNextCell:
	dec c ; $5ce6
	jr nz, .tileCellLoop ; $5ce7
	pop hl ; $5ce9
	ld a, $40 ; $5cea
	add l ; $5cec
	ld l, a ; $5ced
	jr nc, .tileRowSrcOk ; $5cee
	ld a, h ; $5cf0
	inc a ; $5cf1
	and $0f ; $5cf2
	or $d0 ; $5cf4
	ld h, a ; $5cf6
.tileRowSrcOk:
	pop de ; $5cf7
	ld a, $20 ; $5cf8
	add e ; $5cfa
	ld e, a ; $5cfb
	jr nc, .tileNextRow ; $5cfc
	ld a, d ; $5cfe
	inc a ; $5cff
	res 2, a ; $5d00
	ld d, a ; $5d02
.tileNextRow:
	dec b ; $5d03
	jr nz, .tileRowLoop ; $5d04
	pop hl ; $5d06
	pop de ; $5d07
	pop bc ; $5d08
	pop af ; $5d09
	ret ; $5d0a
GetSceneSlotPtr:
	push af ; $5d0b
	push bc ; $5d0c
	push de ; $5d0d
	ld b, a ; $5d0e
	ld a, [wCurrentScene] ; $5d0f
	ld h, $00 ; $5d12
	ld l, a ; $5d14
	add hl, hl ; $5d15
	add hl, hl ; $5d16
	add hl, hl ; $5d17
	add hl, hl ; $5d18
	ld de, SceneGfxSlotTable ; $5d19
	add hl, de ; $5d1c
	ld e, b ; $5d1d
	sla e ; $5d1e
	ld d, $00 ; $5d20
	add hl, de ; $5d22
	ld a, [hl+] ; $5d23
	ld h, [hl] ; $5d24
	ld l, a ; $5d25
	pop de ; $5d26
	pop bc ; $5d27
	pop af ; $5d28
	ret ; $5d29
LoadSceneGraphicsDirect:
	push af ; $5d2a
	push bc ; $5d2b
	push de ; $5d2c
	push hl ; $5d2d
	ld h, $00 ; $5d2e
	ld l, a ; $5d30
	add hl, hl ; $5d31
	ld d, h ; $5d32
	ld e, l ; $5d33
	add hl, hl ; $5d34
	add hl, hl ; $5d35
	add hl, hl ; $5d36
	add hl, de ; $5d37
	ld d, h ; $5d38
	ld e, l ; $5d39
	ld hl, SceneGfxSlotTable ; $5d3a
	add hl, de ; $5d3d
	inc hl ; $5d3e
	inc hl ; $5d3f
	ld a, [hl+] ; $5d40
	ld c, a ; $5d41
	ld a, [hl+] ; $5d42
	ld b, a ; $5d43
	push bc ; $5d44
	ld a, [hl+] ; $5d45
	ld c, a ; $5d46
	ld a, [hl+] ; $5d47
	ld b, a ; $5d48
	push bc ; $5d49
	ld a, [hl+] ; $5d4a
	ld c, a ; $5d4b
	ld a, [hl+] ; $5d4c
	ld b, a ; $5d4d
	push bc ; $5d4e
	ld a, [hl+] ; $5d4f
	ld c, a ; $5d50
	ld a, [hl+] ; $5d51
	ld b, a ; $5d52
	push bc ; $5d53
	ld a, [hl+] ; $5d54
	ld c, a ; $5d55
	ld a, [hl+] ; $5d56
	ld b, a ; $5d57
	push bc ; $5d58
	ld a, [hl+] ; $5d59
	ld c, a ; $5d5a
	ld a, [hl+] ; $5d5b
	ld b, a ; $5d5c
	push bc ; $5d5d
	ld a, [hl+] ; $5d5e
	ld c, a ; $5d5f
	ld a, [hl+] ; $5d60
	ld b, a ; $5d61
	push bc ; $5d62
	wram_bank $01 ; $5d63
	ld a, $01 ; $5d69
	ldh [rVBK], a ; $5d6b
	ld a, [hl+] ; $5d6d
	ld h, [hl] ; $5d6e
	ld l, a ; $5d6f
	ld de, wDecompBuffer ; $5d70
	call DecompressDataFromBank ; $5d73
	ld hl, wDecompBuffer ; $5d76
	ld de, $9000 ; $5d79
	ld bc, $0080 ; $5d7c
	call StartVRAMDMAFromHL ; $5d7f
	ld hl, wTextTileBuffer ; $5d82
	ld de, $8800 ; $5d85
	ld bc, $0080 ; $5d88
	call StartVRAMDMAFromHL ; $5d8b
	wram_bank $06 ; $5d8e
	pop hl ; $5d94
	ld de, wStorySceneUnusedBuffer ; $5d95
	call DecompressDataFromBank ; $5d98
	pop hl ; $5d9b
	pop hl ; $5d9c
	ld de, wBehaviorMap ; $5d9d
	call DecompressDataFromBank ; $5da0
	pop hl ; $5da3
	ld de, wCollisionMap ; $5da4
	call DecompressDataFromBank ; $5da7
	wram_bank $02 ; $5daa
	pop hl ; $5db0
	ld de, wScreenAttrmap ; $5db1
	call DecompressDataFromBank ; $5db4
	wram_bank $03 ; $5db7
	pop hl ; $5dbd
	ld de, wShadowTilemap ; $5dbe
	call DecompressDataFromBank ; $5dc1
	pop hl ; $5dc4
	wram_bank $01 ; $5dc5
	ld de, wDecompBuffer ; $5dcb
	ld bc, $0040 ; $5dce
	call CopyDataFromBank ; $5dd1
	ld hl, wDecompBuffer + 8 ; $5dd4
	ld de, $0107 ; $5dd7
	call LoadPalettesMasterOnly ; $5dda
	pop hl ; $5ddd
	pop de ; $5dde
	pop bc ; $5ddf
	pop af ; $5de0
	ret ; $5de1
LoadAndDisplayScene:
	push bc ; $5de2
	push af ; $5de3
	call DisableLCDSafely ; $5de4
	pop af ; $5de7
	call LoadSceneGraphicsDirect ; $5de8
	ld a, $00 ; $5deb
	call GetSceneSlotPtr ; $5ded
	ld de, wTextBuffer ; $5df0
	ld bc, $0010 ; $5df3
	call CopyDataFromBank ; $5df6
	ld hl, wTextBuffer ; $5df9
	ld bc, $0002 ; $5dfc
	add hl, bc ; $5dff
	ld a, [hl+] ; $5e00
	ld [wMapScrollMinX], a ; $5e01
	ld a, [hl+] ; $5e04
	ld [wMapScrollMinY], a ; $5e05
	ld a, [hl+] ; $5e08
	ld [wMapWidthTiles], a ; $5e09
	ld a, [hl+] ; $5e0c
	ld [wMapHeightTiles], a ; $5e0d
	pop bc ; $5e10
	ld a, b ; $5e11
	call CopyScrolledSceneTilemapToVram ; $5e12
	call EnableLCD ; $5e15
	call AdvanceFrame ; $5e18
	call AdvanceFrame ; $5e1b
	ret ; $5e1e
SceneViewerSelectScene:
	ldh a, [hInputRisingEdge] ; $5e1f
	bit PADB_B, a ; $5e21
	ret z ; $5e23
	ld a, [wScrollListLength] ; $5e24
	dec a ; $5e27
	srl a ; $5e28
	srl a ; $5e2a
	inc a ; $5e2c
	push af ; $5e2d
	ld a, [wCurrentScene] ; $5e2e
	ld [wUnusedPrevSceneIndex], a ; $5e31
	call StopSceneTileAnimations ; $5e34
	pop af ; $5e37
	ld hl, $0176 ; $5e38
	farcall RunPagedTextMenu ; $5e3b
	ld [wCurrentScene], a ; $5e3e
	cp $ff ; $5e41
	jp z, .done ; $5e43
	ld b, $01 ; $5e46
	call LoadAndDisplayScene ; $5e48
	ld a, [wCurrentScene] ; $5e4b
	call InitSceneTileAnimations ; $5e4e
.done:
	ret ; $5e51
	ld hl, Text_30_374 ; $5e52
	ld d, $01 ; $5e55
	ld e, $01 ; $5e57
	farcall CreateMenuWindowFromText ; $5e59
	ld a, [$d820] ; $5e5c
	ld [$d82f], a ; $5e5f
	farcall RestoreShadowTilemap ; $5e62
	farcall StubNop_05_0 ; $5e65
.inputLoop:
	call AdvanceFrame ; $5e68
	ldh a, [hPlayerInputFlags] ; $5e6b
	and PADF_B ; $5e6d
	jr nz, .inputLoop ; $5e6f
	farcall RunMenuSelection ; $5e71
	ld [wCurrentScene], a ; $5e74
	ld a, [$d82f] ; $5e77
	farcall CloseWindow ; $5e7a
	ld a, [wCurrentScene] ; $5e7d
	cp $ff ; $5e80
	jp z, .redraw ; $5e82
	ld a, [wCurrentScene] ; $5e85
	ld b, $01 ; $5e88
	call LoadAndDisplayScene ; $5e8a
	farcall RestoreShadowTilemap ; $5e8d
.redraw:
	ret ; $5e90
RunSceneSelectDebugMenu:
	push af ; $5e91
	push bc ; $5e92
	push de ; $5e93
	push hl ; $5e94
	ld a, $08 ; $5e95
	ld [wScrollListLength], a ; $5e97
	dec a ; $5e9a
	srl a ; $5e9b
	srl a ; $5e9d
	inc a ; $5e9f
	push af ; $5ea0
	ld a, [wCurrentScene] ; $5ea1
	ld [wUnusedPrevSceneIndex], a ; $5ea4
	call StopSceneTileAnimations ; $5ea7
	pop af ; $5eaa
	ld hl, $0176 ; $5eab
	farcall RunPagedTextMenu ; $5eae
	ld [wCurrentScene], a ; $5eb1
	cp $ff ; $5eb4
	jp z, .done ; $5eb6
	ld b, $01 ; $5eb9
	farcall ResetTextWindowState ; $5ebb
	call DisableLCDSafely ; $5ebe
	call InitSceneScroll ; $5ec1
	ld a, [wCurrentScene] ; $5ec4
	call LoadStorySceneGraphics ; $5ec7
	ld a, $00 ; $5eca
	farcall CopyScrolledSceneTilemapToVram ; $5ecc
	call EnableLCD ; $5ecf
	ld a, [wCurrentScene] ; $5ed2
	call InitSceneTileAnimations ; $5ed5
.done:
	pop hl ; $5ed8
	pop de ; $5ed9
	pop bc ; $5eda
	pop af ; $5edb
	ret ; $5edc
GetCollisionMapCellAddr:
	push bc ; $5edd
	push de ; $5ede
	sra d ; $5edf
	sla d ; $5ee1
	sra e ; $5ee3
	sla e ; $5ee5
	ld h, $00 ; $5ee7
	ld l, e ; $5ee9
	add hl, hl ; $5eea
	add hl, hl ; $5eeb
	add hl, hl ; $5eec
	add hl, hl ; $5eed
	ld b, $00 ; $5eee
	ld c, d ; $5ef0
	sra c ; $5ef1
	add hl, bc ; $5ef3
	ld bc, wCollisionMap ; $5ef4
	add hl, bc ; $5ef7
	pop de ; $5ef8
	pop bc ; $5ef9
	ret ; $5efa
ReadCollisionMapCell:
	push bc ; $5efb
	push de ; $5efc
	push hl ; $5efd
	call GetCollisionMapCellAddr ; $5efe
	ldh a, [hWramBank] ; $5f01
	push af ; $5f03
	wram_bank $06 ; $5f04
	ld b, [hl] ; $5f0a
	pop af ; $5f0b
	wram_bank ; $5f0c
	ld a, b ; $5f10
	pop hl ; $5f11
	pop de ; $5f12
	pop bc ; $5f13
	ret ; $5f14
WriteCollisionMapCell:
	push af ; $5f15
	push bc ; $5f16
	push de ; $5f17
	push hl ; $5f18
	call GetCollisionMapCellAddr ; $5f19
	ld b, a ; $5f1c
	ldh a, [hWramBank] ; $5f1d
	push af ; $5f1f
	wram_bank $06 ; $5f20
	ld [hl], b ; $5f26
	pop af ; $5f27
	wram_bank ; $5f28
	pop hl ; $5f2c
	pop de ; $5f2d
	pop bc ; $5f2e
	pop af ; $5f2f
	ret ; $5f30
GetBehaviorMapCellAddr:
	push bc ; $5f31
	push de ; $5f32
	sra d ; $5f33
	sla d ; $5f35
	sra e ; $5f37
	sla e ; $5f39
	ld h, $00 ; $5f3b
	ld l, e ; $5f3d
	add hl, hl ; $5f3e
	add hl, hl ; $5f3f
	add hl, hl ; $5f40
	add hl, hl ; $5f41
	ld b, $00 ; $5f42
	ld c, d ; $5f44
	sra c ; $5f45
	add hl, bc ; $5f47
	ld bc, wBehaviorMap ; $5f48
	add hl, bc ; $5f4b
	pop de ; $5f4c
	pop bc ; $5f4d
	ret ; $5f4e
ReadBehaviorMapCell:
	push bc ; $5f4f
	push de ; $5f50
	push hl ; $5f51
	call GetBehaviorMapCellAddr ; $5f52
	ldh a, [hWramBank] ; $5f55
	push af ; $5f57
	wram_bank $06 ; $5f58
	ld b, [hl] ; $5f5e
	pop af ; $5f5f
	wram_bank ; $5f60
	ld a, b ; $5f64
	push de ; $5f65
	push af ; $5f66
	ld a, a ; $5f67
	ld de, $0e0e ; $5f68
	call PrintHexByte ; $5f6b
	pop af ; $5f6e
	pop de ; $5f6f
	pop hl ; $5f70
	pop de ; $5f71
	pop bc ; $5f72
	ret ; $5f73
WriteBehaviorMapCell:
	push af ; $5f74
	push bc ; $5f75
	push de ; $5f76
	push hl ; $5f77
	call GetBehaviorMapCellAddr ; $5f78
	ld b, a ; $5f7b
	ldh a, [hWramBank] ; $5f7c
	push af ; $5f7e
	wram_bank $06 ; $5f7f
	ld [hl], b ; $5f85
	pop af ; $5f86
	wram_bank ; $5f87
	pop hl ; $5f8b
	pop de ; $5f8c
	pop bc ; $5f8d
	pop af ; $5f8e
	ret ; $5f8f
CopyCollisionMapRect:
	push af ; $5f90
	push bc ; $5f91
	push de ; $5f92
	push hl ; $5f93
	ldh a, [hWramBank] ; $5f94
	push af ; $5f96
	sra h ; $5f97
	sra l ; $5f99
	push hl ; $5f9b
	call GetCollisionMapCellAddr ; $5f9c
	push hl ; $5f9f
	ld d, b ; $5fa0
	ld e, c ; $5fa1
	call GetCollisionMapCellAddr ; $5fa2
	pop de ; $5fa5
	pop bc ; $5fa6
	wram_bank $06 ; $5fa7
	ld a, c ; $5fad
	ld c, b ; $5fae
	ld b, $00 ; $5faf
.rowLoop:
	push af ; $5fb1
	push bc ; $5fb2
	push de ; $5fb3
	push hl ; $5fb4
	call CopyMemoryBC ; $5fb5
	pop hl ; $5fb8
	pop de ; $5fb9
	pop bc ; $5fba
	pop af ; $5fbb
	push bc ; $5fbc
	ld bc, $0020 ; $5fbd
	push hl ; $5fc0
	ld h, d ; $5fc1
	ld l, e ; $5fc2
	add hl, bc ; $5fc3
	ld d, h ; $5fc4
	ld e, l ; $5fc5
	pop hl ; $5fc6
	add hl, bc ; $5fc7
	pop bc ; $5fc8
	dec a ; $5fc9
	jr nz, .rowLoop ; $5fca
	pop af ; $5fcc
	wram_bank ; $5fcd
	pop hl ; $5fd1
	pop de ; $5fd2
	pop bc ; $5fd3
	pop af ; $5fd4
	ret ; $5fd5
CopyBehaviorMapRect:
	push af ; $5fd6
	push bc ; $5fd7
	push de ; $5fd8
	push hl ; $5fd9
	ldh a, [hWramBank] ; $5fda
	push af ; $5fdc
	sra h ; $5fdd
	sra l ; $5fdf
	push hl ; $5fe1
	call GetBehaviorMapCellAddr ; $5fe2
	push hl ; $5fe5
	ld d, b ; $5fe6
	ld e, c ; $5fe7
	call GetBehaviorMapCellAddr ; $5fe8
	pop de ; $5feb
	pop bc ; $5fec
	wram_bank $06 ; $5fed
	ld a, c ; $5ff3
	ld c, b ; $5ff4
	ld b, $00 ; $5ff5
.rowLoop:
	push af ; $5ff7
	push bc ; $5ff8
	push de ; $5ff9
	push hl ; $5ffa
	call CopyMemoryBC ; $5ffb
	pop hl ; $5ffe
	pop de ; $5fff
	pop bc ; $6000
	pop af ; $6001
	push bc ; $6002
	ld bc, $0020 ; $6003
	push hl ; $6006
	ld h, d ; $6007
	ld l, e ; $6008
	add hl, bc ; $6009
	ld d, h ; $600a
	ld e, l ; $600b
	pop hl ; $600c
	add hl, bc ; $600d
	pop bc ; $600e
	dec a ; $600f
	jr nz, .rowLoop ; $6010
	pop af ; $6012
	wram_bank ; $6013
	pop hl ; $6017
	pop de ; $6018
	pop bc ; $6019
	pop af ; $601a
	ret ; $601b
InitSceneViewer:
	push af ; $601c
	push bc ; $601d
	push de ; $601e
	push hl ; $601f
	push af ; $6020
	and $7f ; $6021
	ld [wCurrentScene], a ; $6023
	xor a ; $6026
	ldh [hScrollY], a ; $6027
	ldh [hScrollX], a ; $6029
	dec a ; $602b
	ld [wUnusedPrevSceneIndex], a ; $602c
	ld hl, SceneGfxSlotTable ; $602f
	ld bc, $ffff ; $6032
.slotLoop:
	inc bc ; $6035
	ld a, [hl+] ; $6036
	ld d, a ; $6037
	ld a, [hl+] ; $6038
	or d ; $6039
	jr nz, .slotLoop ; $603a
	ld h, b ; $603c
	ld l, c ; $603d
	ld de, $0009 ; $603e
	call DivHLByDE ; $6041
	ld a, l ; $6044
	ld [wScrollListLength], a ; $6045
	pop af ; $6048
	bit 7, a ; $6049
	jr nz, .clearScroll ; $604b
	and $7f ; $604d
	ld b, $00 ; $604f
	call LoadAndDisplayScene ; $6051
.clearScroll:
	xor a ; $6054
	ldh [hBGColumnBlitPending], a ; $6055
	ldh [hBGRowBlitPending], a ; $6057
	farcall InitTextWindows ; $6059
	ld a, $01 ; $605c
	ld hl, StubNop_0a ; $605e
	call RegisterFrameTask ; $6061
	ld a, [wCurrentScene] ; $6064
	call InitSceneTileAnimations ; $6067
	pop hl ; $606a
	pop de ; $606b
	pop bc ; $606c
	pop af ; $606d
	ret ; $606e
	ld hl, StubNop_0a ; $606f
	call UnregisterFrameTask ; $6072
	ret ; $6075
InitSceneViewerDefault:
	push af ; $6076
	push bc ; $6077
	push de ; $6078
	push hl ; $6079
	xor a ; $607a
	ldh [hScrollY], a ; $607b
	ldh [hScrollX], a ; $607d
	ld hl, SceneGfxSlotTable ; $607f
	ld bc, $ffff ; $6082
.slotLoop:
	inc c ; $6085
	ld a, [hl+] ; $6086
	ld d, a ; $6087
	ld a, [hl+] ; $6088
	or d ; $6089
	jr nz, .slotLoop ; $608a
	ld h, b ; $608c
	ld l, c ; $608d
	ld de, $0009 ; $608e
	call DivHLByDE ; $6091
	ld a, l ; $6094
	ld [wScrollListLength], a ; $6095
	ld a, $00 ; $6098
	ld [wCurrentScene], a ; $609a
	ld b, $00 ; $609d
	call LoadAndDisplayScene ; $609f
	farcall InitTextWindows ; $60a2
	farcall RestoreShadowTilemap ; $60a5
	ld a, [wCurrentScene] ; $60a8
	call InitSceneTileAnimations ; $60ab
	pop hl ; $60ae
	pop de ; $60af
	pop bc ; $60b0
	pop af ; $60b1
	ret ; $60b2
	call InitSceneViewerDefault ; $60b3
.clearScroll:
	call UpdateSceneViewerScroll ; $60b6
	call SceneViewerSelectScene ; $60b9
	call AdvanceFrame ; $60bc
	jr .clearScroll ; $60bf
StubNop_0a:
	ret ; $60c1
UpdateSceneViewerScroll:
	ld a, [wCameraX + 1] ; $60c2
	push af ; $60c5
	ld a, [wCameraY + 1] ; $60c6
	push af ; $60c9
	call MoveSceneViewerCamera ; $60ca
	pop hl ; $60cd
	ld a, [wCameraY + 1] ; $60ce
	cp h ; $60d1
	jr z, .checkVertical ; $60d2
	jr c, .scrollLeft ; $60d4
	ld bc, $fb13 ; $60d6
	call BlitBGRowFrom64 ; $60d9
	jr .checkVertical ; $60dc
.scrollLeft:
	ld bc, $fb00 ; $60de
	call BlitBGRowFrom64 ; $60e1
.checkVertical:
	pop hl ; $60e4
	ld a, [wCameraX + 1] ; $60e5
	cp h ; $60e8
	jr z, .store ; $60e9
	jr c, .scrollUp ; $60eb
	ld bc, $15fa ; $60ed
	call BlitBGColumnFrom64 ; $60f0
	jr .store ; $60f3
.scrollUp:
	ld bc, $00fa ; $60f5
	call BlitBGColumnFrom64 ; $60f8
.store:
	ld a, [wCameraY] ; $60fb
	ld c, a ; $60fe
	ld a, [wCameraY + 1] ; $60ff
	sla c ; $6102
	rla ; $6104
	sla c ; $6105
	rla ; $6107
	sla c ; $6108
	rla ; $610a
	ldh [hScrollY], a ; $610b
	ld a, [wCameraX] ; $610d
	ld c, a ; $6110
	ld a, [wCameraX + 1] ; $6111
	sla c ; $6114
	rla ; $6116
	sla c ; $6117
	rla ; $6119
	sla c ; $611a
	rla ; $611c
	ldh [hScrollX], a ; $611d
	ret ; $611f
DPadMoveVectors_0a:
	; $6120, 64 bytes (records:4)
; 16 records x 4 bytes
	dw $0000, $0000 ; record 0
	dw $0040, $0000 ; record 1
	dw $ffc0, $0000 ; record 2
	dw $0000, $0000 ; record 3
	dw $0000, $ffc0 ; record 4
	dw $002d, $ffd3 ; record 5
	dw $ffd3, $ffd3 ; record 6
	dw $0000, $ffc0 ; record 7
	dw $0000, $0040 ; record 8
	dw $002d, $002d ; record 9
	dw $ffd3, $002d ; record 10
	dw $0000, $0040 ; record 11
	dw $0000, $0000 ; record 12
	dw $0040, $0000 ; record 13
	dw $ffc0, $0000 ; record 14
	dw $0000, $0000 ; record 15
MoveSceneViewerCamera:
	ldh a, [hPlayerInputFlags] ; $6160
	rra ; $6162
	rra ; $6163
	and $3c ; $6164
	ld hl, DPadMoveVectors_0a ; $6166
	ld d, $00 ; $6169
	ld e, a ; $616b
	add hl, de ; $616c
	ld d, h ; $616d
	ld e, l ; $616e
	ld a, [wCameraX] ; $616f
	ld l, a ; $6172
	ld a, [wCameraX + 1] ; $6173
	ld h, a ; $6176
	ld a, [de] ; $6177
	ld c, a ; $6178
	inc de ; $6179
	ld a, [de] ; $617a
	ld b, a ; $617b
	inc de ; $617c
	add hl, bc ; $617d
	ld a, l ; $617e
	ld [wCameraX], a ; $617f
	ld a, h ; $6182
	ld [wCameraX + 1], a ; $6183
	ld a, [wCameraY] ; $6186
	ld l, a ; $6189
	ld a, [wCameraY + 1] ; $618a
	ld h, a ; $618d
	ld a, [de] ; $618e
	ld c, a ; $618f
	inc de ; $6190
	ld a, [de] ; $6191
	ld b, a ; $6192
	inc de ; $6193
	add hl, bc ; $6194
	ld a, l ; $6195
	ld [wCameraY], a ; $6196
	ld a, h ; $6199
	ld [wCameraY + 1], a ; $619a
	ret ; $619d
CopySceneTilemapRect:
	push af ; $619e
	push bc ; $619f
	push de ; $61a0
	push hl ; $61a1
	ldh a, [hWramBank] ; $61a2
	push af ; $61a4
	push de ; $61a5
	push hl ; $61a6
	push hl ; $61a7
	ld h, d ; $61a8
	ld l, e ; $61a9
	call GetSceneTilemapAddr ; $61aa
	ld d, h ; $61ad
	ld e, l ; $61ae
	ld h, b ; $61af
	ld l, c ; $61b0
	call GetSceneTilemapAddr ; $61b1
	pop bc ; $61b4
	push hl ; $61b5
	push de ; $61b6
	push bc ; $61b7
	wram_bank $02 ; $61b8
	ld a, c ; $61be
	ld c, b ; $61bf
	ld b, $00 ; $61c0
.rowLoop:
	push af ; $61c2
	push bc ; $61c3
	push de ; $61c4
	push hl ; $61c5
	call CopyMemoryBC ; $61c6
	pop hl ; $61c9
	pop de ; $61ca
	pop bc ; $61cb
	pop af ; $61cc
	push bc ; $61cd
	ld bc, $0040 ; $61ce
	push hl ; $61d1
	ld h, d ; $61d2
	ld l, e ; $61d3
	add hl, bc ; $61d4
	ld d, h ; $61d5
	ld e, l ; $61d6
	pop hl ; $61d7
	add hl, bc ; $61d8
	pop bc ; $61d9
	dec a ; $61da
	jr nz, .rowLoop ; $61db
	pop bc ; $61dd
	pop de ; $61de
	pop hl ; $61df
	wram_bank $03 ; $61e0
	ld a, c ; $61e6
	ld c, b ; $61e7
	ld b, $00 ; $61e8
.rowLoop2:
	push af ; $61ea
	push bc ; $61eb
	push de ; $61ec
	push hl ; $61ed
	call CopyMemoryBC ; $61ee
	pop hl ; $61f1
	pop de ; $61f2
	pop bc ; $61f3
	pop af ; $61f4
	push bc ; $61f5
	ld bc, $0040 ; $61f6
	push hl ; $61f9
	ld h, d ; $61fa
	ld l, e ; $61fb
	add hl, bc ; $61fc
	ld d, h ; $61fd
	ld e, l ; $61fe
	pop hl ; $61ff
	add hl, bc ; $6200
	pop bc ; $6201
	dec a ; $6202
	jr nz, .rowLoop2 ; $6203
	pop hl ; $6205
	pop de ; $6206
	wram_bank $05 ; $6207
	farcall RestoreShadowTilemap ; $620d
	ld d, e ; $6210
	ld e, l ; $6211
	farcall RedrawTilemapRowRange ; $6212
	pop af ; $6215
	wram_bank ; $6216
	pop hl ; $621a
	pop de ; $621b
	pop bc ; $621c
	pop af ; $621d
	ret ; $621e
GetSceneTilemapAddr:
	push bc ; $621f
	ld c, $00 ; $6220
	ld b, l ; $6222
	sra b ; $6223
	rr c ; $6225
	sra b ; $6227
	rr c ; $6229
	ld l, h ; $622b
	ld h, $00 ; $622c
	add hl, bc ; $622e
	ld bc, wActors ; $622f
	add hl, bc ; $6232
	pop bc ; $6233
	ret ; $6234
UpdateCameraFromPlayer:
	wram_bank $04 ; $6235
	ld hl, wActors + 12 ; $623b
	ld a, [hl+] ; $623e
	ld b, [hl] ; $623f
	ld c, a ; $6240
	inc hl ; $6241
	ld a, [hl+] ; $6242
	ld d, [hl] ; $6243
	ld e, a ; $6244
	push de ; $6245
	ld hl, $f610 ; $6246
	add hl, bc ; $6249
	ld a, [wMapScrollMinX] ; $624a
	ld d, a ; $624d
	ld a, h ; $624e
	sub d ; $624f
	bit 7, a ; $6250
	jr z, .clampXHigh ; $6252
	ld h, d ; $6254
	ld l, $00 ; $6255
	jr .storeX ; $6257
.clampXHigh:
	ld a, [wMapWidthTiles] ; $6259
	sub $14 ; $625c
	ld d, a ; $625e
	ld a, h ; $625f
	sub d ; $6260
	bit 7, a ; $6261
	jr nz, .storeX ; $6263
	ld h, d ; $6265
	ld l, $00 ; $6266
.storeX:
	ld b, h ; $6268
	ld c, l ; $6269
	pop de ; $626a
	ld hl, $f510 ; $626b
	add hl, de ; $626e
	ld a, [wMapScrollMinY] ; $626f
	ld d, a ; $6272
	ld a, h ; $6273
	sub d ; $6274
	bit 7, a ; $6275
	jr z, .clampYHigh ; $6277
	ld h, d ; $6279
	ld l, $00 ; $627a
	jr .storeY ; $627c
.clampYHigh:
	ld a, [wMapHeightTiles] ; $627e
	sub $12 ; $6281
	ld d, a ; $6283
	ld a, h ; $6284
	sub d ; $6285
	bit 7, a ; $6286
	jr nz, .storeY ; $6288
	ld h, d ; $628a
	ld l, $00 ; $628b
.storeY:
	ld d, h ; $628d
	ld e, l ; $628e
	ld hl, wCameraX ; $628f
	ld a, c ; $6292
	ld [hl+], a ; $6293
	ld a, b ; $6294
	ld [hl+], a ; $6295
	ld a, e ; $6296
	ld [hl+], a ; $6297
	ld a, d ; $6298
	ld [hl], a ; $6299
	ret ; $629a
	ld a, [wCourtSceneGfxStepsLeft] ; $629b
	or a ; $629e
	jr nz, .done ; $629f
.checkScrollX:
	ld hl, CameraFromPlayerSpriteList ; $62a1
	ld a, [wCourtSceneGfxCursor] ; $62a4
	add l ; $62a7
	ld l, a ; $62a8
	ld a, h ; $62a9
	adc $00 ; $62aa
	ld h, a ; $62ac
	ld a, [hl] ; $62ad
	cp $ff ; $62ae
	jr nz, .checkScrollY ; $62b0
	xor a ; $62b2
	ld [wCourtSceneGfxCursor], a ; $62b3
	jr .checkScrollX ; $62b6
.checkScrollY:
	ld b, a ; $62b8
	inc hl ; $62b9
	ld c, [hl] ; $62ba
	inc hl ; $62bb
	ld e, [hl] ; $62bc
	inc hl ; $62bd
	ld a, [hl] ; $62be
	push af ; $62bf
	push bc ; $62c0
	ld l, e ; $62c1
	ld h, $00 ; $62c2
	add hl, hl ; $62c4
	add hl, hl ; $62c5
	add hl, hl ; $62c6
	add hl, hl ; $62c7
	ld de, $9000 + VRAM_BANK1 ; $62c8
	add hl, de ; $62cb
	push hl ; $62cc
	ld l, b ; $62cd
	ld h, $00 ; $62ce
	add hl, hl ; $62d0
	add hl, hl ; $62d1
	add hl, hl ; $62d2
	add hl, hl ; $62d3
	ld bc, LoadCourtSceneGraphics ; $62d4
	add hl, bc ; $62d7
	pop de ; $62d8
	pop bc ; $62d9
	call QueueVRAMCopy ; $62da
	ld a, [wCourtSceneGfxCursor] ; $62dd
	add $04 ; $62e0
	ld [wCourtSceneGfxCursor], a ; $62e2
	pop af ; $62e5
.done:
	dec a ; $62e6
	ld [wCourtSceneGfxStepsLeft], a ; $62e7
	ret ; $62ea
CameraFromPlayerSpriteList:
	; $62eb, 13 bytes (records:4)
; 3 records x 4 bytes
	dw $1000, $0a50 ; record 0
	dw $1010, $0a50 ; record 1
	dw $1020, $0a50 ; record 2
	db $ff
LoadCourtSceneGraphics:
	push af ; $62f8
	push bc ; $62f9
	push de ; $62fa
	push hl ; $62fb
	ld [wCurrentScene], a ; $62fc
	ld h, $00 ; $62ff
	ld l, a ; $6301
	add hl, hl ; $6302
	add hl, hl ; $6303
	add hl, hl ; $6304
	add hl, hl ; $6305
	ld de, SceneGfxSlotTable ; $6306
	add hl, de ; $6309
	inc hl ; $630a
	inc hl ; $630b
	ld a, [hl+] ; $630c
	ld c, a ; $630d
	ld a, [hl+] ; $630e
	ld b, a ; $630f
	push bc ; $6310
	ld a, [hl+] ; $6311
	ld c, a ; $6312
	ld a, [hl+] ; $6313
	ld b, a ; $6314
	push bc ; $6315
	ld a, [hl+] ; $6316
	ld c, a ; $6317
	ld a, [hl+] ; $6318
	ld b, a ; $6319
	push bc ; $631a
	ld a, [hl+] ; $631b
	ld c, a ; $631c
	ld a, [hl+] ; $631d
	ld b, a ; $631e
	push bc ; $631f
	ld a, [hl+] ; $6320
	ld c, a ; $6321
	ld a, [hl+] ; $6322
	ld b, a ; $6323
	push bc ; $6324
	inc hl ; $6325
	inc hl ; $6326
	wram_bank $01 ; $6327
	ld a, [hl+] ; $632d
	ld h, [hl] ; $632e
	ld l, a ; $632f
	ld de, wDecompBuffer ; $6330
	call DecompressDataFromBank ; $6333
	ld hl, wDecompBuffer ; $6336
	ld de, $9000 + VRAM_BANK1 ; $6339
	ld c, $80 ; $633c
	call QueueVRAMCopy ; $633e
	ld hl, wTextTileBuffer ; $6341
	ld de, $8800 + VRAM_BANK1 ; $6344
	ld c, $80 ; $6347
	call QueueVRAMCopy ; $6349
	wram_bank $04 ; $634c
	pop hl ; $6352
	ld de, wScoreboardColumnAttrs ; $6353
	ld bc, $0028 ; $6356
	call CopyDataFromBank ; $6359
	pop hl ; $635c
	ld de, wScoreboardColumnTiles ; $635d
	ld bc, $0028 ; $6360
	call CopyDataFromBank ; $6363
	wram_bank $02 ; $6366
	pop hl ; $636c
	ld de, wCourtAttrmapSaved ; $636d
	call DecompressDataFromBank ; $6370
	pop hl ; $6373
	ld de, wCourtTilemapSaved ; $6374
	call DecompressDataFromBank ; $6377
	pop hl ; $637a
	ld de, wScreenAttrmap ; $637b
	ld bc, $0040 ; $637e
	call CopyDataFromBank ; $6381
	ld hl, wScreenAttrmap + 16 ; $6384
	ld de, $0206 ; $6387
	call LoadPaletteShadow ; $638a
	ld hl, wScreenAttrmap + 1 * TILEMAP_WIDTH + 8 ; $638d
	ld de, $0b01 ; $6390
	call LoadPaletteShadow ; $6393
	pop hl ; $6396
	pop de ; $6397
	pop bc ; $6398
	pop af ; $6399
	ret ; $639a
InitSceneTileAnimations:
	push af ; $639b
	push bc ; $639c
	push de ; $639d
	push hl ; $639e
	ldh a, [hWramBank] ; $639f
	push af ; $63a1
	wram_bank $05 ; $63a2
	ld a, $ff ; $63a8
	ld b, $01 ; $63aa
	ld hl, wSceneTileAnimState ; $63ac
	ld [hl+], a ; $63af
	ld [hl], b ; $63b0
	inc hl ; $63b1
	ld [hl+], a ; $63b2
	ld [hl], b ; $63b3
	inc hl ; $63b4
	ld [hl+], a ; $63b5
	ld [hl], b ; $63b6
	inc hl ; $63b7
	ld [hl+], a ; $63b8
	ld [hl], b ; $63b9
	inc hl ; $63ba
	ld [hl+], a ; $63bb
	ld [hl+], a ; $63bc
	ld [hl+], a ; $63bd
	ld [hl+], a ; $63be
	ld a, $00 ; $63bf
	call GetSceneSlotPtr ; $63c1
	ld de, wSceneTileAnimHeader ; $63c4
	ld bc, $0088 ; $63c7
	call CopyDataFromBank ; $63ca
	ld hl, wSceneTileAnimEntries ; $63cd
	ld a, [hl] ; $63d0
	cp $fe ; $63d1
	jr nz, .buildSlots ; $63d3
	jp .done ; $63d5
.buildSlots:
	add sp, -2 ; $63d8
	ld de, wSceneTileAnimState + 2 ; $63da
	push hl ; $63dd
	ld hl, sp + 2 ; $63de
	ld [hl], e ; $63e0
	inc hl ; $63e1
	ld [hl], d ; $63e2
	pop hl ; $63e3
	ld d, h ; $63e4
	ld e, l ; $63e5
	ld b, $ff ; $63e6
	ld c, $03 ; $63e8
	xor a ; $63ea
	ld hl, wSceneTileAnimState ; $63eb
	ld [hl], a ; $63ee
	ld hl, wSceneTileAnimStart ; $63ef
	ld [hl], a ; $63f2
	inc hl ; $63f3
.scanLoop:
	inc b ; $63f4
	ld a, [de] ; $63f5
	inc de ; $63f6
	cp $fe ; $63f7
	jr z, .listEnd ; $63f9
	cp $ff ; $63fb
	jr nz, .scanLoop ; $63fd
	inc b ; $63ff
	ld a, b ; $6400
	inc a ; $6401
	ld [hl], a ; $6402
	push de ; $6403
	push hl ; $6404
	ld hl, sp + 4 ; $6405
	ld e, [hl] ; $6407
	inc hl ; $6408
	ld d, [hl] ; $6409
	pop hl ; $640a
	ld [de], a ; $640b
	inc de ; $640c
	inc de ; $640d
	push hl ; $640e
	ld hl, sp + 4 ; $640f
	ld [hl], e ; $6411
	inc hl ; $6412
	ld [hl], d ; $6413
	pop hl ; $6414
	pop de ; $6415
	ld a, [de] ; $6416
	inc a ; $6417
	inc de ; $6418
	push hl ; $6419
	push de ; $641a
	ld d, a ; $641b
	ld a, $04 ; $641c
	sub c ; $641e
	ld hl, wSceneTileAnimState ; $641f
	ld e, a ; $6422
	ld a, d ; $6423
	ld d, $00 ; $6424
	add hl, de ; $6426
	add hl, de ; $6427
	inc hl ; $6428
	ld [hl], a ; $6429
	pop de ; $642a
	pop hl ; $642b
	inc hl ; $642c
	dec c ; $642d
	jr nz, .scanLoop ; $642e
.listEnd:
	ld a, c ; $6430
	or a ; $6431
	jr z, .install ; $6432
	ld a, $ff ; $6434
	dec hl ; $6436
	ld [hl], a ; $6437
	push hl ; $6438
	ld hl, sp + 2 ; $6439
	ld e, [hl] ; $643b
	inc hl ; $643c
	ld d, [hl] ; $643d
	pop hl ; $643e
	dec de ; $643f
	dec de ; $6440
	ld [de], a ; $6441
.install:
	ld a, $01 ; $6442
	ld hl, UpdateSceneTileAnimations ; $6444
	call RegisterFrameTask ; $6447
	add sp, 2 ; $644a
.done:
	pop af ; $644c
	wram_bank ; $644d
	pop hl ; $6451
	pop de ; $6452
	pop bc ; $6453
	pop af ; $6454
	ret ; $6455
StopSceneTileAnimations:
	push af ; $6456
	push bc ; $6457
	push de ; $6458
	push hl ; $6459
	ld hl, UpdateSceneTileAnimations ; $645a
	call UnregisterFrameTask ; $645d
	pop hl ; $6460
	pop de ; $6461
	pop bc ; $6462
	pop af ; $6463
	ret ; $6464
UpdateSceneTileAnimations:
	test_flag FLAG_VRAM_UPDATE_BUSY ; $6465
	ret nz ; $6468
	test_flag FLAG_DEBUG_FREEZE_TILE_ANIM ; $6469
	ret nz ; $646c
	push af ; $646d
	push bc ; $646e
	push de ; $646f
	push hl ; $6470
	ldh a, [hWramBank] ; $6471
	push af ; $6473
	wram_bank $05 ; $6474
	ld de, $d900 ; $647a
	ld hl, $db10 ; $647d
	ld a, e ; $6480
	ld [hl+], a ; $6481
	ld [hl], d ; $6482
	ld c, $00 ; $6483
	ld hl, wSceneTileAnimStart ; $6485
.read:
	ld a, [hl] ; $6488
	cp $ff ; $6489
	jr z, .done ; $648b
	push hl ; $648d
	ld l, c ; $648e
	ld h, $00 ; $648f
	add hl, hl ; $6491
	ld de, wSceneTileAnimState ; $6492
	add hl, de ; $6495
	inc hl ; $6496
	ld a, [hl] ; $6497
	dec a ; $6498
	ld [hl], a ; $6499
	pop hl ; $649a
	inc hl ; $649b
	ld b, c ; $649c
	inc c ; $649d
	ld d, a ; $649e
	ld a, c ; $649f
	cp $04 ; $64a0
	jr z, .done ; $64a2
	ld a, d ; $64a4
	or a ; $64a5
	jr nz, .read ; $64a6
	ld a, b ; $64a8
	call AdvanceSceneTileAnimation ; $64a9
	ld a, c ; $64ac
	cp $04 ; $64ad
	jr nz, .read ; $64af
.done:
	pop af ; $64b1
	wram_bank ; $64b2
	pop hl ; $64b6
	pop de ; $64b7
	pop bc ; $64b8
	pop af ; $64b9
	ret ; $64ba
AdvanceSceneTileAnimation:
	push af ; $64bb
	push bc ; $64bc
	push de ; $64bd
	push hl ; $64be
	push af ; $64bf
	add sp, -1 ; $64c0
	ld hl, sp + 0 ; $64c2
	ld [hl], a ; $64c4
	ld h, $00 ; $64c5
	ld l, a ; $64c7
	add hl, hl ; $64c8
	ld bc, wSceneTileAnimState ; $64c9
	add hl, bc ; $64cc
	ld a, [hl] ; $64cd
	ld [wSceneTileAnimCursor], a ; $64ce
.applyFrame:
	ld hl, wSceneTileAnimEntries ; $64d1
	ld a, [wSceneTileAnimCursor] ; $64d4
	ld c, a ; $64d7
	ld b, $00 ; $64d8
	add hl, bc ; $64da
	ld a, [hl] ; $64db
	cp $ff ; $64dc
	jr nz, .nextEntry ; $64de
	ld hl, sp + 0 ; $64e0
	ld c, [hl] ; $64e2
	ld b, $00 ; $64e3
	ld hl, wSceneTileAnimStart ; $64e5
	add hl, bc ; $64e8
	ld a, [hl] ; $64e9
	ld [wSceneTileAnimCursor], a ; $64ea
	jr .applyFrame ; $64ed
.nextEntry:
	ld b, a ; $64ef
	inc hl ; $64f0
	ld c, [hl] ; $64f1
	inc hl ; $64f2
	ld e, [hl] ; $64f3
	inc hl ; $64f4
	ld a, [hl] ; $64f5
	push af ; $64f6
	ld d, b ; $64f7
	ld b, $00 ; $64f8
	sla c ; $64fa
	rl b ; $64fc
	sla c ; $64fe
	rl b ; $6500
	sla c ; $6502
	rl b ; $6504
	sla c ; $6506
	rl b ; $6508
	push bc ; $650a
	ld a, d ; $650b
	ld l, e ; $650c
	ld h, $00 ; $650d
	add hl, hl ; $650f
	add hl, hl ; $6510
	add hl, hl ; $6511
	add hl, hl ; $6512
	ld de, $9000 + VRAM_BANK1 ; $6513
	add hl, de ; $6516
	push hl ; $6517
	ld l, a ; $6518
	ld h, $00 ; $6519
	add hl, hl ; $651b
	add hl, hl ; $651c
	add hl, hl ; $651d
	add hl, hl ; $651e
	push bc ; $651f
	ld b, h ; $6520
	ld c, l ; $6521
	ld a, $06 ; $6522
	call GetSceneSlotPtr ; $6524
	push hl ; $6527
	push bc ; $6528
	ld a, h ; $6529
	ld h, $40 ; $652a
	ld de, $db12 ; $652c
	ld bc, $0002 ; $652f
	call FarCopyBytes ; $6532
	pop bc ; $6535
	ld hl, $db10 ; $6536
	ld a, [hl+] ; $6539
	ld d, [hl] ; $653a
	ld e, a ; $653b
	ld hl, $db12 ; $653c
	ld a, [hl+] ; $653f
	ld h, [hl] ; $6540
	ld l, a ; $6541
	add hl, bc ; $6542
	pop bc ; $6543
	ld a, b ; $6544
	pop bc ; $6545
	call FarCopyBytes ; $6546
	ld hl, $db10 ; $6549
	ld a, [hl+] ; $654c
	ld h, [hl] ; $654d
	ld l, a ; $654e
	pop de ; $654f
	pop bc ; $6550
	push bc ; $6551
	srl b ; $6552
	rr c ; $6554
	srl b ; $6556
	rr c ; $6558
	srl b ; $655a
	rr c ; $655c
	srl b ; $655e
	rr c ; $6560
	ld hl, $db10 ; $6562
	ld a, [hl+] ; $6565
	ld h, [hl] ; $6566
	ld l, a ; $6567
	push hl ; $6568
	call QueueVRAMCopy ; $6569
	pop hl ; $656c
	pop bc ; $656d
	add hl, bc ; $656e
	ld b, h ; $656f
	ld c, l ; $6570
	ld hl, $db10 ; $6571
	ld a, c ; $6574
	ld [hl+], a ; $6575
	ld [hl], b ; $6576
	ld a, [wSceneTileAnimCursor] ; $6577
	add $04 ; $657a
	ld [wSceneTileAnimCursor], a ; $657c
	pop af ; $657f
	ld d, a ; $6580
	add sp, 1 ; $6581
	pop af ; $6583
	ld h, $00 ; $6584
	ld l, a ; $6586
	add hl, hl ; $6587
	ld bc, wSceneTileAnimState ; $6588
	add hl, bc ; $658b
	ld a, [wSceneTileAnimCursor] ; $658c
	ld [hl+], a ; $658f
	ld [hl], d ; $6590
	pop hl ; $6591
	pop de ; $6592
	pop bc ; $6593
	pop af ; $6594
	ret ; $6595
InitMinigameTargets:
	wram_bank $04 ; $6596
	ld hl, wMinigameTargets ; $659c
	ld c, $10 ; $659f
	call ClearMemory16 ; $65a1
	ld a, $01 ; $65a4
	ld [wMinigameTargetsActive], a ; $65a6
	ld a, $ff ; $65a9
	ld [wMinigameHitTargetType], a ; $65ab
	ret ; $65ae
ActivateMinigameTarget:
	ld hl, $0004 ; $65af
	add hl, bc ; $65b2
	ld a, e ; $65b3
	ld [hl+], a ; $65b4
	ld [hl], d ; $65b5
	ld hl, $0001 ; $65b6
	add hl, bc ; $65b9
	ld [hl], $00 ; $65ba
	ld hl, $0000 ; $65bc
	add hl, bc ; $65bf
	set 0, [hl] ; $65c0
	ret ; $65c2
UpdateMinigameTargets:
	ld a, [wMinigameTargetsActive] ; $65c3
	and a ; $65c6
	ret z ; $65c7
	ld hl, wMinigameTargets ; $65c8
	ld c, $0f ; $65cb
.targetLoop:
	call UpdateMinigameTarget ; $65cd
	ld de, $000e ; $65d0
	add hl, de ; $65d3
	dec c ; $65d4
	jr nz, .targetLoop ; $65d5
	ret ; $65d7
UpdateMinigameTarget:
	bit 0, [hl] ; $65d8
	ret z ; $65da
	push af ; $65db
	push bc ; $65dc
	push de ; $65dd
	push hl ; $65de
	push hl ; $65df
	ld de, wMinigameTargetWork ; $65e0
	ld c, $01 ; $65e3
	call CopyMemoryFast ; $65e5
	ld hl, wMinigameTargetWork + 2 ; $65e8
	ld a, [hl] ; $65eb
	and a ; $65ec
	jr z, .hit ; $65ed
	dec [hl] ; $65ef
.hit:
	call RunMinigameTargetScript ; $65f0
	call MoveMinigameTargetTowardGoal ; $65f3
	ld a, [wMinigameTargetsAltMode] ; $65f6
	and a ; $65f9
	jr nz, .expire ; $65fa
	call DrawMinigameTarget ; $65fc
	call CheckBallHitsMinigameTarget ; $65ff
	call HandleMinigameTargetHit ; $6602
	jr .done ; $6605
.expire:
	call DrawMinigameTargetAlt ; $6607
	call CheckBallHitsMinigameTargetAlt ; $660a
	call HandleMinigameTargetHitAlt ; $660d
.done:
	pop de ; $6610
	ld hl, wMinigameTargetWork ; $6611
	ld c, $01 ; $6614
	call CopyMemoryFast ; $6616
	pop hl ; $6619
	pop de ; $661a
	pop bc ; $661b
	pop af ; $661c
	ret ; $661d
MoveMinigameTargetTowardGoal:
	ld hl, wMinigameTargetWork ; $661e
	bit 1, [hl] ; $6621
	ret z ; $6623
	ld hl, wMinigameTargetWork + 6 ; $6624
	ld a, [hl+] ; $6627
	ld d, [hl] ; $6628
	ld e, a ; $6629
	ld hl, wMinigameTargetWork + 10 ; $662a
	ld a, [hl+] ; $662d
	ld h, [hl] ; $662e
	ld l, a ; $662f
	ld a, l ; $6630
	sub e ; $6631
	ld l, a ; $6632
	ld a, h ; $6633
	sbc d ; $6634
	ld h, a ; $6635
	ld a, h ; $6636
	or l ; $6637
	jr z, .depthAxis ; $6638
	ld de, $0010 ; $663a
	bit 7, h ; $663d
	jr z, .stepX ; $663f
	xor a ; $6641
	sub e ; $6642
	ld e, a ; $6643
	sbc a ; $6644
	sub d ; $6645
	ld d, a ; $6646
.stepX:
	ld hl, wMinigameTargetWork + 6 ; $6647
	ld a, [hl] ; $664a
	add e ; $664b
	ld [hl+], a ; $664c
	ld a, [hl] ; $664d
	adc d ; $664e
	ld [hl+], a ; $664f
.depthAxis:
	ld hl, wMinigameTargetWork + 8 ; $6650
	ld a, [hl+] ; $6653
	ld d, [hl] ; $6654
	ld e, a ; $6655
	ld hl, wMinigameTargetWork + 12 ; $6656
	ld a, [hl+] ; $6659
	ld h, [hl] ; $665a
	ld l, a ; $665b
	ld a, l ; $665c
	sub e ; $665d
	ld l, a ; $665e
	ld a, h ; $665f
	sbc d ; $6660
	ld h, a ; $6661
	ld a, h ; $6662
	or l ; $6663
	jr z, .checkArrived ; $6664
	ld de, $0010 ; $6666
	bit 7, h ; $6669
	jr z, .stepDepth ; $666b
	xor a ; $666d
	sub e ; $666e
	ld e, a ; $666f
	sbc a ; $6670
	sub d ; $6671
	ld d, a ; $6672
.stepDepth:
	ld hl, wMinigameTargetWork + 8 ; $6673
	ld a, [hl] ; $6676
	add e ; $6677
	ld [hl+], a ; $6678
	ld a, [hl] ; $6679
	adc d ; $667a
	ld [hl+], a ; $667b
.checkArrived:
	ld hl, wMinigameTargetWork + 6 ; $667c
	ld a, [hl+] ; $667f
	ld d, [hl] ; $6680
	ld e, a ; $6681
	ld hl, wMinigameTargetWork + 10 ; $6682
	ld a, [hl+] ; $6685
	ld h, [hl] ; $6686
	ld l, a ; $6687
	ld a, l ; $6688
	sub e ; $6689
	ld l, a ; $668a
	ld a, h ; $668b
	sbc d ; $668c
	ld h, a ; $668d
	ld a, h ; $668e
	or l ; $668f
	jr nz, .done ; $6690
	ld hl, wMinigameTargetWork + 8 ; $6692
	ld a, [hl+] ; $6695
	ld d, [hl] ; $6696
	ld e, a ; $6697
	ld hl, wMinigameTargetWork + 12 ; $6698
	ld a, [hl+] ; $669b
	ld h, [hl] ; $669c
	ld l, a ; $669d
	ld a, l ; $669e
	sub e ; $669f
	ld l, a ; $66a0
	ld a, h ; $66a1
	sbc d ; $66a2
	ld h, a ; $66a3
	ld a, h ; $66a4
	or l ; $66a5
	jr nz, .done ; $66a6
	ld hl, wMinigameTargetWork ; $66a8
	res 1, [hl] ; $66ab
.done:
	ret ; $66ad
DrawMinigameTarget:
	ld hl, wMinigameTargetWork + 8 ; $66ae
	ld a, [hl+] ; $66b1
	ld b, [hl] ; $66b2
	ld c, a ; $66b3
	ld hl, wMinigameTargetWork + 6 ; $66b4
	ld a, [hl+] ; $66b7
	ld h, [hl] ; $66b8
	ld l, a ; $66b9
	farcall ApplyCameraProjection ; $66ba
	ld c, e ; $66bd
	ld b, d ; $66be
	ld a, [wMinigameTargetWork + 2] ; $66bf
	and $0f ; $66c2
	jr z, .readSprite ; $66c4
	add LOW(DrawMinigameTargetTable) ; $66c6
	ld l, a ; $66c8
	adc HIGH(DrawMinigameTargetTable) ; $66c9
	sub l ; $66cb
	ld h, a ; $66cc
	ld a, [hl] ; $66cd
	ld h, $00 ; $66ce
	ld l, a ; $66d0
	ld a, [wMinigameTargetWork + 1] ; $66d1
	rrca ; $66d4
	rrca ; $66d5
	and $c0 ; $66d6
	call VectorFromLengthAndAngleRaw ; $66d8
	ld a, c ; $66db
	add e ; $66dc
	ld e, a ; $66dd
	ld a, b ; $66de
	add l ; $66df
	ld d, a ; $66e0
.readSprite:
	ld a, [wMinigameTargetWork + 1] ; $66e1
	add a ; $66e4
	add LOW(MinigameTargetTable) ; $66e5
	ld l, a ; $66e7
	adc HIGH(MinigameTargetTable) ; $66e8
	sub l ; $66ea
	ld h, a ; $66eb
	ld a, [hl+] ; $66ec
	ld b, [hl] ; $66ed
	ld c, a ; $66ee
	ld hl, DrawMinigameTarget_SpriteTemplate ; $66ef
	call QueueSpriteTemplate ; $66f2
	ret ; $66f5
MinigameTargetTable:
	; $66f6, 8 bytes (bytes:8)
	db $10, $0d, $14, $0f, $18, $0b, $1c, $0e ; 0x00
DrawMinigameTargetTable:
	INCBIN "data/bank_00a/d_66fe.bin" ; $66fe, 16 bytes
DrawMinigameTarget_SpriteTemplate:
	; $670e, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
HandleMinigameTargetHit:
	ld hl, wMinigameTargetWork ; $6717
	bit 2, [hl] ; $671a
	ret z ; $671c
	res 2, [hl] ; $671d
	sound SFX_BALL_CONTACT ; $671f
	ld a, $20 ; $6721
	ld [wMinigameTargetWork + 2], a ; $6723
	ld a, [wMinigameTargetWork + 1] ; $6726
	call DeflectBallOffMinigameTarget ; $6729
	ret ; $672c
CheckBallHitsMinigameTarget:
	ld a, [wBallCrossedNetFlag] ; $672d
	and a ; $6730
	ret z ; $6731
	ld hl, wBallHistory + 30 ; $6732
	ld a, [hl+] ; $6735
	ld d, [hl] ; $6736
	ld e, a ; $6737
	ld hl, wMinigameTargetWork + 6 ; $6738
	ld a, [hl+] ; $673b
	ld h, [hl] ; $673c
	ld l, a ; $673d
	ld a, l ; $673e
	sub e ; $673f
	ld l, a ; $6740
	ld a, h ; $6741
	sbc d ; $6742
	ld h, a ; $6743
	bit 7, h ; $6744
	jr z, .done ; $6746
	ld de, $0200 ; $6748
	add hl, de ; $674b
	bit 7, h ; $674c
	jr nz, .done ; $674e
	ld hl, wBallHistory + 32 ; $6750
	ld a, [hl+] ; $6753
	ld d, [hl] ; $6754
	ld e, a ; $6755
	ld hl, wMinigameTargetWork + 8 ; $6756
	ld a, [hl+] ; $6759
	ld h, [hl] ; $675a
	ld l, a ; $675b
	ld a, l ; $675c
	sub e ; $675d
	ld l, a ; $675e
	ld a, h ; $675f
	sbc d ; $6760
	ld h, a ; $6761
	bit 7, h ; $6762
	jr z, .done ; $6764
	ld de, $0200 ; $6766
	add hl, de ; $6769
	bit 7, h ; $676a
	jr nz, .done ; $676c
	ld hl, wMinigameTargetWork ; $676e
	set 2, [hl] ; $6771
.done:
	ret ; $6773
DeflectBallOffMinigameTarget:
	and $03 ; $6774
	ld a, a ; $6776
	rst Rst00 ; $6777
	dw DeflectBallOffMinigameTarget.pushX ; $6778 jumptable
	dw DeflectBallOffMinigameTarget.pushUp ; $677a jumptable
	dw DeflectBallOffMinigameTarget.pushDepth ; $677c jumptable
	dw DeflectBallOffMinigameTarget.reverse ; $677e jumptable
.pushX:
	ld de, $0600 ; $6780
	ld hl, wBallVelocityX ; $6783
	ld a, [hl] ; $6786
	add e ; $6787
	ld [hl+], a ; $6788
	ld a, [hl] ; $6789
	adc d ; $678a
	ld [hl+], a ; $678b
	ret ; $678c
.pushUp:
	ld bc, $0800 ; $678d
	ld hl, wBallVelocityHeight ; $6790
	ld a, c ; $6793
	ld [hl+], a ; $6794
	ld [hl], b ; $6795
	ld hl, wBallVelocityDepth ; $6796
	ld a, [hl+] ; $6799
	ld d, [hl] ; $679a
	ld e, a ; $679b
	sra d ; $679c
	rr e ; $679e
	dec hl ; $67a0
	ld a, e ; $67a1
	ld [hl+], a ; $67a2
	ld [hl], d ; $67a3
	ret ; $67a4
.pushDepth:
	ld de, $fa00 ; $67a5
	ld hl, wBallVelocityX ; $67a8
	ld a, [hl] ; $67ab
	add e ; $67ac
	ld [hl+], a ; $67ad
	ld a, [hl] ; $67ae
	adc d ; $67af
	ld [hl+], a ; $67b0
	ret ; $67b1
.reverse:
	ld bc, $f400 ; $67b2
	ld hl, wBallVelocityHeight ; $67b5
	ld a, c ; $67b8
	ld [hl+], a ; $67b9
	ld [hl], b ; $67ba
	ld hl, wBallVelocityDepth ; $67bb
	ld a, [hl+] ; $67be
	ld d, [hl] ; $67bf
	ld e, a ; $67c0
	sra d ; $67c1
	rr e ; $67c3
	dec hl ; $67c5
	ld a, e ; $67c6
	ld [hl+], a ; $67c7
	ld [hl], d ; $67c8
	ret ; $67c9
DrawNumberWithSprites:
	push af ; $67ca
	push bc ; $67cb
	push hl ; $67cc
	add sp, -10 ; $67cd
	push bc ; $67cf
	push de ; $67d0
	ld c, l ; $67d1
	ld b, h ; $67d2
	ld hl, sp + 4 ; $67d3
	ld e, l ; $67d5
	ld d, h ; $67d6
	ld l, c ; $67d7
	ld h, b ; $67d8
	ld c, e ; $67d9
	ld b, d ; $67da
	call FormatDecimalNumber ; $67db
	ld l, c ; $67de
	ld h, b ; $67df
	pop de ; $67e0
	pop bc ; $67e1
	call DrawDigitSpritesString ; $67e2
	add sp, 10 ; $67e5
	pop hl ; $67e7
	pop bc ; $67e8
	pop af ; $67e9
	ret ; $67ea
DrawDigitSpritesString:
	ld a, [hl+] ; $67eb
	and a ; $67ec
	jr z, .done ; $67ed
	call DrawDigitSprite_0a ; $67ef
	jr DrawDigitSpritesString ; $67f2
.done:
	ret ; $67f4
DrawDigitSprite_0a:
	sub $30 ; $67f5
	jr c, .advance ; $67f7
	push de ; $67f9
	push hl ; $67fa
	add a ; $67fb
	add $08 ; $67fc
	ld c, a ; $67fe
	call QueueSprite ; $67ff
	pop hl ; $6802
	pop de ; $6803
.advance:
	ld a, d ; $6804
	add $08 ; $6805
	ld d, a ; $6807
	ret ; $6808
MinigameTargetOpHandlers_0a:
	; $6809, 18 bytes (records:2)
	dw MinigameTargetOp_00 ; record 0
	dw MinigameTargetOp_01 ; record 1
	dw MinigameTargetOp_02 ; record 2
	dw MinigameTargetOp_03 ; record 3
	dw MinigameTargetOp_04 ; record 4
	dw MinigameTargetOp_05 ; record 5
	dw MinigameTargetOp_06 ; record 6
	dw MinigameTargetOp_07 ; record 7
	dw MinigameTargetOp_08 ; record 8
MinigameTargetOp_00:
	xor a ; $681b
	ret ; $681c
MinigameTargetOp_01:
	inc de ; $681d
	ld a, [de] ; $681e
	inc de ; $681f
	dec a ; $6820
	ld [wMinigameTargetWork + 3], a ; $6821
	xor a ; $6824
	ret ; $6825
MinigameTargetOp_02:
	inc de ; $6826
	ld l, e ; $6827
	ld h, d ; $6828
	ld a, [hl+] ; $6829
	ld e, a ; $682a
	ld a, [hl-] ; $682b
	ld d, a ; $682c
	add hl, de ; $682d
	ld e, l ; $682e
	ld d, h ; $682f
	ld a, $01 ; $6830
	ret ; $6832
MinigameTargetOp_03:
	inc de ; $6833
	ld a, [de] ; $6834
	ld l, a ; $6835
	inc de ; $6836
	ld a, [de] ; $6837
	ld h, a ; $6838
	inc de ; $6839
	push de ; $683a
	call JumpToHL ; $683b
	pop de ; $683e
	ret ; $683f
MinigameTargetOp_04:
	ld hl, wMinigameTargetWork ; $6840
	bit 1, [hl] ; $6843
	jr nz, .apply ; $6845
	inc de ; $6847
	ld a, $01 ; $6848
	ret ; $684a
.apply:
	xor a ; $684b
	ret ; $684c
MinigameTargetOp_05:
	inc de ; $684d
	ld l, e ; $684e
	ld h, d ; $684f
	ld de, wMinigameTargetWork + 6 ; $6850
	ld a, [hl+] ; $6853
	ld [de], a ; $6854
	inc de ; $6855
	ld a, [hl+] ; $6856
	ld [de], a ; $6857
	inc de ; $6858
	ld a, [hl+] ; $6859
	ld [de], a ; $685a
	inc de ; $685b
	ld a, [hl+] ; $685c
	ld [de], a ; $685d
	inc de ; $685e
	ld e, l ; $685f
	ld d, h ; $6860
	ld hl, wMinigameTargetWork ; $6861
	res 1, [hl] ; $6864
	ld a, $01 ; $6866
	ret ; $6868
MinigameTargetOp_06:
	inc de ; $6869
	ld a, [de] ; $686a
	ld b, a ; $686b
	inc de ; $686c
	ld a, [de] ; $686d
	ld l, a ; $686e
	inc de ; $686f
	ld a, [de] ; $6870
	ld h, a ; $6871
	inc de ; $6872
	push de ; $6873
	ld a, b ; $6874
	call VectorFromLengthAndAngle ; $6875
	ld c, l ; $6878
	ld b, h ; $6879
	ld hl, wMinigameTargetWork + 6 ; $687a
	ld a, [hl+] ; $687d
	ld h, [hl] ; $687e
	ld l, a ; $687f
	add hl, bc ; $6880
	ld c, l ; $6881
	ld b, h ; $6882
	ld hl, wMinigameTargetWork + 10 ; $6883
	ld a, c ; $6886
	ld [hl+], a ; $6887
	ld [hl], b ; $6888
	ld hl, wMinigameTargetWork + 8 ; $6889
	ld a, [hl+] ; $688c
	ld h, [hl] ; $688d
	ld l, a ; $688e
	add hl, de ; $688f
	ld e, l ; $6890
	ld d, h ; $6891
	ld hl, wMinigameTargetWork + 12 ; $6892
	ld a, e ; $6895
	ld [hl+], a ; $6896
	ld [hl], d ; $6897
	pop de ; $6898
	ld hl, wMinigameTargetWork ; $6899
	set 1, [hl] ; $689c
	ld a, $01 ; $689e
	ret ; $68a0
MinigameTargetOp_07:
	inc de ; $68a1
	ld a, [de] ; $68a2
	inc de ; $68a3
	ld [wMinigameTargetWork + 1], a ; $68a4
	ld a, $01 ; $68a7
	ret ; $68a9
MinigameTargetOp_08:
	inc de ; $68aa
	ld a, [de] ; $68ab
	inc de ; $68ac
	ld hl, wMinigameTargetWork + 1 ; $68ad
	add [hl] ; $68b0
	and $03 ; $68b1
	ld [hl], a ; $68b3
	ld a, $01 ; $68b4
	ret ; $68b6
RunMinigameTargetScript:
	ld hl, wMinigameTargetWork + 3 ; $68b7
	ld a, [hl] ; $68ba
	and a ; $68bb
	jr z, .runScript ; $68bc
	dec [hl] ; $68be
	ret ; $68bf
.runScript:
	ld hl, wMinigameTargetWork + 4 ; $68c0
	ld a, [hl+] ; $68c3
	ld d, [hl] ; $68c4
	ld e, a ; $68c5
.dispatchOp:
	ld hl, MinigameTargetScriptOpReturn ; $68c6
	push hl ; $68c9
	ld a, [de] ; $68ca
	add a ; $68cb
	add LOW(MinigameTargetOpHandlers_0a) ; $68cc
	ld l, a ; $68ce
	adc HIGH(MinigameTargetOpHandlers_0a) ; $68cf
	sub l ; $68d1
	ld h, a ; $68d2
	ld a, [hl+] ; $68d3
	ld h, [hl] ; $68d4
	ld l, a ; $68d5
	jp hl ; $68d6
MinigameTargetScriptOpReturn:
	ld hl, wMinigameTargetWork + 4 ; $68d7
	ld [hl], e ; $68da
	inc hl ; $68db
	ld [hl], d ; $68dc
	and a ; $68dd
	jr nz, RunMinigameTargetScript.dispatchOp ; $68de
	ret ; $68e0
MinigameTargetFormation0Script0:
	INCBIN "data/bank_00a/d_68e1.bin" ; $68e1, 10 bytes
MinigameTargetFormation0Script1:
	INCBIN "data/bank_00a/d_68eb.bin" ; $68eb, 10 bytes
MinigameTargetFormation0Script2:
	INCBIN "data/bank_00a/d_68f5.bin" ; $68f5, 10 bytes
MinigameTargetFormation0Script3:
	INCBIN "data/bank_00a/d_68ff.bin" ; $68ff, 33 bytes
MinigameTargetFormation1Script0:
	INCBIN "data/bank_00a/d_6920.bin" ; $6920, 10 bytes
MinigameTargetFormation1Script1:
	INCBIN "data/bank_00a/d_692a.bin" ; $692a, 10 bytes
MinigameTargetFormation1Script2:
	INCBIN "data/bank_00a/d_6934.bin" ; $6934, 10 bytes
MinigameTargetFormation1Script3:
	INCBIN "data/bank_00a/d_693e.bin" ; $693e, 10 bytes
MinigameTargetFormation1Script4:
	INCBIN "data/bank_00a/d_6948.bin" ; $6948, 10 bytes
MinigameTargetFormation1Script5:
	INCBIN "data/bank_00a/d_6952.bin" ; $6952, 10 bytes
MinigameTargetFormation1Script6:
	INCBIN "data/bank_00a/d_695c.bin" ; $695c, 10 bytes
MinigameTargetFormation1Script7:
	INCBIN "data/bank_00a/d_6966.bin" ; $6966, 33 bytes
MinigameTargetFormation2Script0:
	INCBIN "data/bank_00a/d_6987.bin" ; $6987, 10 bytes
MinigameTargetFormation2Script1:
	INCBIN "data/bank_00a/d_6991.bin" ; $6991, 10 bytes
MinigameTargetFormation2Script2:
	INCBIN "data/bank_00a/d_699b.bin" ; $699b, 10 bytes
MinigameTargetFormation2Script3:
	INCBIN "data/bank_00a/d_69a5.bin" ; $69a5, 10 bytes
MinigameTargetFormation2Script4:
	INCBIN "data/bank_00a/d_69af.bin" ; $69af, 10 bytes
MinigameTargetFormation2Script5:
	INCBIN "data/bank_00a/d_69b9.bin" ; $69b9, 10 bytes
MinigameTargetFormation2Script6:
	INCBIN "data/bank_00a/d_69c3.bin" ; $69c3, 10 bytes
MinigameTargetFormation2Script7:
	INCBIN "data/bank_00a/d_69cd.bin" ; $69cd, 144 bytes
MinigameTargetFormation3Script00:
	INCBIN "data/bank_00a/d_6a5d.bin" ; $6a5d, 10 bytes
MinigameTargetFormation3Script01:
	INCBIN "data/bank_00a/d_6a67.bin" ; $6a67, 10 bytes
MinigameTargetFormation3Script02:
	INCBIN "data/bank_00a/d_6a71.bin" ; $6a71, 10 bytes
MinigameTargetFormation3Script03:
	INCBIN "data/bank_00a/d_6a7b.bin" ; $6a7b, 10 bytes
MinigameTargetFormation3Script04:
	INCBIN "data/bank_00a/d_6a85.bin" ; $6a85, 10 bytes
MinigameTargetFormation3Script05:
	INCBIN "data/bank_00a/d_6a8f.bin" ; $6a8f, 10 bytes
MinigameTargetFormation3Script06:
	INCBIN "data/bank_00a/d_6a99.bin" ; $6a99, 10 bytes
MinigameTargetFormation3Script07:
	INCBIN "data/bank_00a/d_6aa3.bin" ; $6aa3, 10 bytes
MinigameTargetFormation3Script08:
	INCBIN "data/bank_00a/d_6aad.bin" ; $6aad, 10 bytes
MinigameTargetFormation3Script09:
	INCBIN "data/bank_00a/d_6ab7.bin" ; $6ab7, 10 bytes
MinigameTargetFormation3Script10:
	INCBIN "data/bank_00a/d_6ac1.bin" ; $6ac1, 10 bytes
MinigameTargetFormation3Script11:
	INCBIN "data/bank_00a/d_6acb.bin" ; $6acb, 70 bytes
MinigameTargetFormation4Script00:
	INCBIN "data/bank_00a/d_6b11.bin" ; $6b11, 10 bytes
MinigameTargetFormation4Script01:
	INCBIN "data/bank_00a/d_6b1b.bin" ; $6b1b, 10 bytes
MinigameTargetFormation4Script02:
	INCBIN "data/bank_00a/d_6b25.bin" ; $6b25, 10 bytes
MinigameTargetFormation4Script03:
	INCBIN "data/bank_00a/d_6b2f.bin" ; $6b2f, 10 bytes
MinigameTargetFormation4Script04:
	INCBIN "data/bank_00a/d_6b39.bin" ; $6b39, 10 bytes
MinigameTargetFormation4Script05:
	INCBIN "data/bank_00a/d_6b43.bin" ; $6b43, 10 bytes
MinigameTargetFormation4Script06:
	INCBIN "data/bank_00a/d_6b4d.bin" ; $6b4d, 10 bytes
MinigameTargetFormation4Script07:
	INCBIN "data/bank_00a/d_6b57.bin" ; $6b57, 10 bytes
MinigameTargetFormation4Script08:
	INCBIN "data/bank_00a/d_6b61.bin" ; $6b61, 10 bytes
MinigameTargetFormation4Script09:
	INCBIN "data/bank_00a/d_6b6b.bin" ; $6b6b, 10 bytes
MinigameTargetFormation4Script10:
	INCBIN "data/bank_00a/d_6b75.bin" ; $6b75, 10 bytes
MinigameTargetFormation4Script11:
	INCBIN "data/bank_00a/d_6b7f.bin" ; $6b7f, 42 bytes
MinigameTargetFormation5Script0:
	INCBIN "data/bank_00a/d_6ba9.bin" ; $6ba9, 10 bytes
MinigameTargetFormation5Script1:
	INCBIN "data/bank_00a/d_6bb3.bin" ; $6bb3, 35 bytes
MinigameTargetFormation6Script0:
	INCBIN "data/bank_00a/d_6bd6.bin" ; $6bd6, 10 bytes
MinigameTargetFormation6Script1:
	INCBIN "data/bank_00a/d_6be0.bin" ; $6be0, 10 bytes
MinigameTargetFormation6Script2:
	INCBIN "data/bank_00a/d_6bea.bin" ; $6bea, 38 bytes
MinigameTargetFormation7Script0:
	INCBIN "data/bank_00a/d_6c10.bin" ; $6c10, 10 bytes
MinigameTargetFormation7Script1:
	INCBIN "data/bank_00a/d_6c1a.bin" ; $6c1a, 10 bytes
MinigameTargetFormation7Script2:
	INCBIN "data/bank_00a/d_6c24.bin" ; $6c24, 10 bytes
MinigameTargetFormation7Script3:
	INCBIN "data/bank_00a/d_6c2e.bin" ; $6c2e, 37 bytes
MinigameTargetFormation8Script0:
	INCBIN "data/bank_00a/d_6c53.bin" ; $6c53, 10 bytes
MinigameTargetFormation8Script1:
	INCBIN "data/bank_00a/d_6c5d.bin" ; $6c5d, 10 bytes
MinigameTargetFormation8Script2:
	INCBIN "data/bank_00a/d_6c67.bin" ; $6c67, 10 bytes
MinigameTargetFormation8Script3:
	INCBIN "data/bank_00a/d_6c71.bin" ; $6c71, 10 bytes
SpawnMinigameTargetFormation:
	ld a, a ; $6c7b
	rst Rst00 ; $6c7c
	dw SpawnMinigameTargetFormation0 ; $6c7d jumptable
	dw SpawnMinigameTargetFormation1 ; $6c7f jumptable
	dw SpawnMinigameTargetFormation2 ; $6c81 jumptable
	dw SpawnMinigameTargetFormation3 ; $6c83 jumptable
	dw SpawnMinigameTargetFormation4 ; $6c85 jumptable
	dw SpawnMinigameTargetFormation5 ; $6c87 jumptable
	dw SpawnMinigameTargetFormation6 ; $6c89 jumptable
	dw SpawnMinigameTargetFormation7 ; $6c8b jumptable
	dw SpawnMinigameTargetFormation8 ; $6c8d jumptable
SpawnMinigameTargetFormation0:
	ld hl, MinigameTargetFormation0ScriptPtrs ; $6c8f
	call SpawnMinigameTargetsFromList ; $6c92
	ret ; $6c95
MinigameTargetFormation0ScriptPtrs:
	; $6c96, 10 bytes (records:2)
	dw MinigameTargetFormation0Script0 ; record 0
	dw MinigameTargetFormation0Script1 ; record 1
	dw MinigameTargetFormation0Script2 ; record 2
	dw MinigameTargetFormation0Script3 ; record 3
	dw $0000 ; record 4
SpawnMinigameTargetFormation1:
	ld hl, MinigameTargetFormation1ScriptPtrs ; $6ca0
	call SpawnMinigameTargetsFromList ; $6ca3
	ret ; $6ca6
MinigameTargetFormation1ScriptPtrs:
	; $6ca7, 18 bytes (records:2)
	dw MinigameTargetFormation1Script0 ; record 0
	dw MinigameTargetFormation1Script1 ; record 1
	dw MinigameTargetFormation1Script2 ; record 2
	dw MinigameTargetFormation1Script3 ; record 3
	dw MinigameTargetFormation1Script4 ; record 4
	dw MinigameTargetFormation1Script5 ; record 5
	dw MinigameTargetFormation1Script6 ; record 6
	dw MinigameTargetFormation1Script7 ; record 7
	dw $0000 ; record 8
SpawnMinigameTargetFormation2:
	ld hl, MinigameTargetFormation2ScriptPtrs ; $6cb9
	call SpawnMinigameTargetsFromList ; $6cbc
	ret ; $6cbf
MinigameTargetFormation2ScriptPtrs:
	; $6cc0, 18 bytes (records:2)
	dw MinigameTargetFormation2Script0 ; record 0
	dw MinigameTargetFormation2Script1 ; record 1
	dw MinigameTargetFormation2Script2 ; record 2
	dw MinigameTargetFormation2Script3 ; record 3
	dw MinigameTargetFormation2Script4 ; record 4
	dw MinigameTargetFormation2Script5 ; record 5
	dw MinigameTargetFormation2Script6 ; record 6
	dw MinigameTargetFormation2Script7 ; record 7
	dw $0000 ; record 8
SpawnMinigameTargetFormation3:
	ld hl, MinigameTargetFormation3ScriptPtrs ; $6cd2
	call SpawnMinigameTargetsFromList ; $6cd5
	ret ; $6cd8
MinigameTargetFormation3ScriptPtrs:
	; $6cd9, 26 bytes (records:2)
	dw MinigameTargetFormation3Script00 ; record 0
	dw MinigameTargetFormation3Script01 ; record 1
	dw MinigameTargetFormation3Script02 ; record 2
	dw MinigameTargetFormation3Script03 ; record 3
	dw MinigameTargetFormation3Script04 ; record 4
	dw MinigameTargetFormation3Script05 ; record 5
	dw MinigameTargetFormation3Script06 ; record 6
	dw MinigameTargetFormation3Script07 ; record 7
	dw MinigameTargetFormation3Script08 ; record 8
	dw MinigameTargetFormation3Script09 ; record 9
	dw MinigameTargetFormation3Script10 ; record 10
	dw MinigameTargetFormation3Script11 ; record 11
	dw $0000 ; record 12
SpawnMinigameTargetFormation4:
	ld hl, MinigameTargetFormation4ScriptPtrs ; $6cf3
	call SpawnMinigameTargetsFromList ; $6cf6
	ret ; $6cf9
MinigameTargetFormation4ScriptPtrs:
	; $6cfa, 26 bytes (records:2)
	dw MinigameTargetFormation4Script00 ; record 0
	dw MinigameTargetFormation4Script01 ; record 1
	dw MinigameTargetFormation4Script02 ; record 2
	dw MinigameTargetFormation4Script03 ; record 3
	dw MinigameTargetFormation4Script04 ; record 4
	dw MinigameTargetFormation4Script05 ; record 5
	dw MinigameTargetFormation4Script06 ; record 6
	dw MinigameTargetFormation4Script07 ; record 7
	dw MinigameTargetFormation4Script08 ; record 8
	dw MinigameTargetFormation4Script09 ; record 9
	dw MinigameTargetFormation4Script10 ; record 10
	dw MinigameTargetFormation4Script11 ; record 11
	dw $0000 ; record 12
SpawnMinigameTargetFormation5:
	ld hl, MinigameTargetFormation5ScriptPtrs ; $6d14
	call SpawnMinigameTargetsFromList ; $6d17
	ret ; $6d1a
MinigameTargetFormation5ScriptPtrs:
	; $6d1b, 6 bytes (records:2)
	dw MinigameTargetFormation5Script0 ; record 0
	dw MinigameTargetFormation5Script1 ; record 1
	dw $0000 ; record 2
SpawnMinigameTargetFormation6:
	ld hl, MinigameTargetFormation6ScriptPtrs ; $6d21
	call SpawnMinigameTargetsFromList ; $6d24
	ret ; $6d27
MinigameTargetFormation6ScriptPtrs:
	; $6d28, 8 bytes (records:2)
	dw MinigameTargetFormation6Script0 ; record 0
	dw MinigameTargetFormation6Script1 ; record 1
	dw MinigameTargetFormation6Script2 ; record 2
	dw $0000 ; record 3
SpawnMinigameTargetFormation7:
	ld hl, MinigameTargetFormation7ScriptPtrs ; $6d30
	call SpawnMinigameTargetsFromList ; $6d33
	ret ; $6d36
MinigameTargetFormation7ScriptPtrs:
	; $6d37, 10 bytes (records:2)
	dw MinigameTargetFormation7Script0 ; record 0
	dw MinigameTargetFormation7Script1 ; record 1
	dw MinigameTargetFormation7Script2 ; record 2
	dw MinigameTargetFormation7Script3 ; record 3
	dw $0000 ; record 4
SpawnMinigameTargetFormation8:
	ld hl, MinigameTargetFormation8ScriptPtrs ; $6d41
	call SpawnMinigameTargetsFromList ; $6d44
	ret ; $6d47
MinigameTargetFormation8ScriptPtrs:
	; $6d48, 10 bytes (records:2)
	dw MinigameTargetFormation8Script0 ; record 0
	dw MinigameTargetFormation8Script1 ; record 1
	dw MinigameTargetFormation8Script2 ; record 2
	dw MinigameTargetFormation8Script3 ; record 3
	dw $0000 ; record 4
SpawnMinigameTargetsFromList:
	ld bc, wMinigameTargets ; $6d52
.spawnLoop:
	ld a, [hl+] ; $6d55
	ld e, a ; $6d56
	ld a, [hl+] ; $6d57
	ld d, a ; $6d58
	ld a, d ; $6d59
	or e ; $6d5a
	jr z, .done ; $6d5b
	push bc ; $6d5d
	push hl ; $6d5e
	call ActivateMinigameTarget ; $6d5f
	pop hl ; $6d62
	pop bc ; $6d63
	ld a, $0e ; $6d64
	add c ; $6d66
	ld c, a ; $6d67
	jr nc, .next ; $6d68
	inc b ; $6d6a
.next:
	jr .spawnLoop ; $6d6b
.done:
	ret ; $6d6d
DrawMinigameTargetAlt:
	ld hl, wMinigameTargetWork + 8 ; $6d6e
	ld a, [hl+] ; $6d71
	ld b, [hl] ; $6d72
	ld c, a ; $6d73
	ld hl, wMinigameTargetWork + 6 ; $6d74
	ld a, [hl+] ; $6d77
	ld h, [hl] ; $6d78
	ld l, a ; $6d79
	farcall ApplyCameraProjection ; $6d7a
	ld c, e ; $6d7d
	ld b, d ; $6d7e
	ld a, [wMinigameTargetWork + 2] ; $6d7f
	and $0f ; $6d82
	jr z, .readSprite ; $6d84
	add LOW(DrawMinigameTargetAltTable) ; $6d86
	ld l, a ; $6d88
	adc HIGH(DrawMinigameTargetAltTable) ; $6d89
	sub l ; $6d8b
	ld h, a ; $6d8c
	ld a, [hl] ; $6d8d
	add d ; $6d8e
	ld d, a ; $6d8f
.readSprite:
	ld a, [wMinigameTargetWork + 1] ; $6d90
	add a ; $6d93
	add LOW(MinigameTargetAltTable) ; $6d94
	ld l, a ; $6d96
	adc HIGH(MinigameTargetAltTable) ; $6d97
	sub l ; $6d99
	ld h, a ; $6d9a
	ld a, [hl+] ; $6d9b
	ld b, [hl] ; $6d9c
	ld c, a ; $6d9d
	ld hl, DrawMinigameTargetAlt_SpriteTemplate ; $6d9e
	call QueueSpriteTemplate ; $6da1
	ret ; $6da4
MinigameTargetAltTable:
	; $6da5, 8 bytes (bytes:8)
	db $10, $0f, $20, $0e, $30, $0d, $20, $0f ; 0x00
DrawMinigameTargetAltTable:
	INCBIN "data/bank_00a/d_6dad.bin" ; $6dad, 16 bytes
DrawMinigameTargetAlt_SpriteTemplate:
	; $6dbd, 33 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $20, $08, $02, $00
	oam_sprite $10, $10, $04, $00
	oam_sprite $20, $10, $06, $00
	oam_sprite $10, $18, $08, $00
	oam_sprite $20, $18, $0a, $00
	oam_sprite $10, $20, $0c, $00
	oam_sprite $20, $20, $0e, $00
	oam_sprite_end
HandleMinigameTargetHitAlt:
	ld hl, wMinigameTargetWork ; $6dde
	bit 2, [hl] ; $6de1
	ret z ; $6de3
	res 2, [hl] ; $6de4
	sound $97 ; $6de6
	ld a, $20 ; $6de8
	ld [wMinigameTargetWork + 2], a ; $6dea
	ld a, [wMinigameTargetWork + 1] ; $6ded
	ld [wMinigameHitTargetType], a ; $6df0
	ret ; $6df3
CheckBallHitsMinigameTargetAlt:
	ld a, [wBallCrossedNetFlag] ; $6df4
	and a ; $6df7
	ret z ; $6df8
	ld a, $01 ; $6df9
	ld [wMinigameHitPending], a ; $6dfb
	ld hl, wBallHistory + 30 ; $6dfe
	ld a, [hl+] ; $6e01
	ld d, [hl] ; $6e02
	ld e, a ; $6e03
	ld hl, wMinigameTargetWork + 6 ; $6e04
	ld a, [hl+] ; $6e07
	ld h, [hl] ; $6e08
	ld l, a ; $6e09
	ld a, l ; $6e0a
	sub e ; $6e0b
	ld l, a ; $6e0c
	ld a, h ; $6e0d
	sbc d ; $6e0e
	ld h, a ; $6e0f
	bit 7, h ; $6e10
	jr z, .done ; $6e12
	ld de, $0400 ; $6e14
	add hl, de ; $6e17
	bit 7, h ; $6e18
	jr nz, .done ; $6e1a
	ld hl, wBallHistory + 32 ; $6e1c
	ld a, [hl+] ; $6e1f
	ld d, [hl] ; $6e20
	ld e, a ; $6e21
	ld hl, wMinigameTargetWork + 8 ; $6e22
	ld a, [hl+] ; $6e25
	ld h, [hl] ; $6e26
	ld l, a ; $6e27
	ld a, l ; $6e28
	sub e ; $6e29
	ld l, a ; $6e2a
	ld a, h ; $6e2b
	sbc d ; $6e2c
	ld h, a ; $6e2d
	bit 7, h ; $6e2e
	jr z, .done ; $6e30
	ld de, $0400 ; $6e32
	add hl, de ; $6e35
	bit 7, h ; $6e36
	jr nz, .done ; $6e38
	ld hl, wMinigameTargetWork ; $6e3a
	set 2, [hl] ; $6e3d
.done:
	ret ; $6e3f
EndingCutsceneLocationList:
	; $6e40, 44 bytes (location_entries)
	db STORYLOC_END1_MAIN_BLDG, $01 ; 0
	db STORYLOC_END_RESTAURANT_ENT, $01 ; 1
	db STORYLOC_END3_DORM_ENT, $01 ; 2
	db STORYLOC_END4_JR_COURT, $01 ; 3
	db STORYLOC_END5_SERVICE_ACE, $01 ; 4
	db STORYLOC_END11_TRAINING_COURT, $02 ; 5
	db STORYLOC_END7_TRAINING_CTR, $01 ; 6
	db STORYLOC_END8_SR_COURT, $01 ; 7
	db STORYLOC_END7_TRAINING_CTR, $02 ; 8
	db STORYLOC_END10_VARSITY_COURT, $01 ; 9
	db STORYLOC_END11_TRAINING_COURT, $01 ; 10
	db STORYLOC_END12_PRINCIPALS_OFFICE, $01 ; 11
	db STORYLOC_END1_MAIN_BLDG, $02 ; 12
	db STORYLOC_ISLAND_SKY, $0c ; 13
	db STORYLOC_CENTER_COURT, $0f ; 14
	db STORYLOC_END16_BEFORE_FINALS, $01 ; 15
	db STORYLOC_END17_AWARD_CEREMONY, $01 ; 16
	db STORYLOC_END12_PRINCIPALS_OFFICE, $02 ; 17
	db STORYLOC_ISLAND_SKY, $0d ; 18
	db STORYLOC_PEACHS_CASTLE, $0a ; 19
	db STORYLOC_SPECIAL_COURT, $01 ; 20
	db $ff, $ff ; list end
EndingCreditsSequencePalette:
	INCLUDE "data/bank_00a/palettes_6e6c.asm" ; $6e6c, 8 bytes (palettes)
RunEndingCreditsSequence:
	ld c, $04 ; $6e74
	call BeginFadeOut ; $6e76
	call WaitFadeEnd ; $6e79
	set_flag FLAG_ENDING_CREDITS_RUNNING ; $6e7c
	sound BGM_CREDITS ; $6e7f
	farcall LoadMenuFontGfx ; $6e81
	ld hl, EndingCreditsSequencePalette ; $6e84
	ld de, $0001 ; $6e87
	call LoadPalettesMasterOnly ; $6e8a
	xor a ; $6e8d
	ld [wStoryCharacterSlot], a ; $6e8e
.sceneLoop:
	call ClearFrameTasks ; $6e91
	ld a, [wStoryCharacterSlot] ; $6e94
	add a ; $6e97
	add LOW(EndingCutsceneLocationList) ; $6e98
	ld l, a ; $6e9a
	adc HIGH(EndingCutsceneLocationList) ; $6e9b
	sub l ; $6e9d
	ld h, a ; $6e9e
	ld a, [hl+] ; $6e9f
	cp $ff ; $6ea0
	jr z, .done ; $6ea2
	and a ; $6ea4
	jr nz, .setLocation ; $6ea5
	ld a, [wStoryModeMainCharacterOverworldSprite] ; $6ea7
	add a ; $6eaa
	ld a, [hl+] ; $6eab
.setLocation:
	ld [wStoryModeCurrentLocation], a ; $6eac
	ld a, [hl+] ; $6eaf
	ld [wStoryModeEntryPoint], a ; $6eb0
	clear_flag FLAG_VRAM_UPDATE_BUSY ; $6eb3
	clear_flag FLAG_ACTORS_FROZEN ; $6eb6
	xor a ; $6eb9
	ld [wRasterScrollStartLY], a ; $6eba
	ld [wRasterScrollEndLY], a ; $6ebd
	call RunStoryLocation ; $6ec0
	test_flag FLAG_ENDING_CREDITS_PENDING ; $6ec3
	jr nz, .fadeOut ; $6ec6
	set_flag FLAG_VRAM_UPDATE_BUSY ; $6ec8
	call FreezeAllActors ; $6ecb
	farcall InitGrayscalePaletteFade ; $6ece
	ld b, $3f ; $6ed1
	ld c, $ff ; $6ed3
	ld d, $1e ; $6ed5
	farcall SetupPaletteFadeMask ; $6ed7
	farcall AnimatePaletteFadeToTarget ; $6eda
	ld a, [wStoryCharacterSlot] ; $6edd
	farcall PlayScrollingStoryCutscene ; $6ee0
.fadeOut:
	clear_flag FLAG_ENDING_CREDITS_PENDING ; $6ee3
	ld c, $04 ; $6ee6
	call BeginFadeOut ; $6ee8
	call WaitFadeEnd ; $6eeb
	ld a, $90 ; $6eee
	ldh [rWY], a ; $6ef0
	ld hl, wStoryCharacterSlot ; $6ef2
	inc [hl] ; $6ef5
	ldh a, [hDebugStepMode] ; $6ef6
	or a ; $6ef8
	jr z, .nextScene ; $6ef9
	ldh a, [hPlayerInputFlags] ; $6efb
	bit PADB_SELECT, a ; $6efd
	jr nz, .done ; $6eff
.nextScene:
	jr .sceneLoop ; $6f01
.done:
	farcall ShowStoryResultScreen ; $6f03
	ld c, $08 ; $6f06
	call BeginFadeOut ; $6f08
	call WaitFadeEnd ; $6f0b
	xor a ; $6f0e
	ldh [hScrollX], a ; $6f0f
	ldh [hScrollY], a ; $6f11
	farcall LoadMenuFontGfx ; $6f13
	clear_flag FLAG_ENDING_CREDITS_RUNNING ; $6f16
	clear_flag FLAG_ACTORS_FROZEN ; $6f19
	ret ; $6f1c
FreezeAllActors:
	wram_bank $04 ; $6f1d
	ld de, wActors ; $6f23
	ld c, $18 ; $6f26
.actorLoop:
	inc e ; $6f28
	ld a, [de] ; $6f29
	dec e ; $6f2a
	or a ; $6f2b
	jp z, .next ; $6f2c
	ld hl, $0005 ; $6f2f
	add hl, de ; $6f32
	set 0, [hl] ; $6f33
	set 1, [hl] ; $6f35
.next:
	ld hl, $0040 ; $6f37
	add hl, de ; $6f3a
	ld e, l ; $6f3b
	ld d, h ; $6f3c
	dec c ; $6f3d
	jp nz, .actorLoop ; $6f3e
	set_flag FLAG_ACTORS_FROZEN ; $6f41
	ret ; $6f44
Unused_0a_2:
	; $6f45, 4 bytes (bytes:4)
	db $df, $3a, $03, $c9 ; 0x00
	; $6f49, 4279 bytes fill to bank end (linker-padded)
