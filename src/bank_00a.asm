SECTION "ROM Bank $0a", ROMX[$4000], BANK[$0a]

FarPtr_BeginCutsceneScriptMode:
	dw BeginCutsceneScriptMode ; $4000
FarPtr_EndCutsceneScriptMode:
	dw EndCutsceneScriptMode ; $4002
FarPtr_WaitScriptFrames:
	dw WaitScriptFrames ; $4004
FarPtr_ScriptRespawnLocationActors:
	dw ScriptRespawnLocationActors ; $4006
FarPtr_ScriptShowSpeakerDialogue:
	dw ScriptShowSpeakerDialogue ; $4008
FarPtr_ScriptShowSpeakerDialogueRestoreBG:
	dw ScriptShowSpeakerDialogueRestoreBG ; $400a
FarPtr_ScriptCloseDialogueWindow:
	dw ScriptCloseDialogueWindow ; $400c
FarPtr_InitDialogueTextCursor:
	dw InitDialogueTextCursor ; $400e
FarPtr_AdvanceDialogueTextCursor:
	dw AdvanceDialogueTextCursor ; $4010
FarPtr_RunDialogueYesNoPrompt:
	dw RunDialogueYesNoPrompt ; $4012
FarPtr_ScriptSkipSpeakerDialogue:
	dw ScriptSkipSpeakerDialogue ; $4014
FarPtr_GetActorStateAddr:
	dw GetActorStateAddr ; $4016
FarPtr_ScriptSetActorMoveSpeed:
	dw ScriptSetActorMoveSpeed ; $4018
FarPtr_ScriptSetActorScript:
	dw ScriptSetActorScript ; $401a
FarPtr_SetActorNullScript:
	dw SetActorNullScript ; $401c
FarPtr_WaitActorScriptDone:
	dw WaitActorScriptDone ; $401e
FarPtr_ScriptWaitActorMoveDone:
	dw ScriptWaitActorMoveDone ; $4020
FarPtr_ScriptSetActorPosition:
	dw ScriptSetActorPosition ; $4022
FarPtr_ScriptSetActorMoveTarget:
	dw ScriptSetActorMoveTarget ; $4024
FarPtr_MoveActorTowardPoint:
	dw MoveActorTowardPoint ; $4026
FarPtr_MoveActorByDelta:
	dw MoveActorByDelta ; $4028
FarPtr_MoveActorByAngle:
	dw MoveActorByAngle ; $402a
FarPtr_ScriptSetActorFacingLock:
	dw ScriptSetActorFacingLock ; $402c
FarPtr_SetActorFacing:
	dw SetActorFacing ; $402e
FarPtr_FaceActorTowardActor:
	dw FaceActorTowardActor ; $4030
FarPtr_FaceActorsTowardEachOther:
	dw FaceActorsTowardEachOther ; $4032
FarPtr_ScriptSetActorAnimation:
	dw ScriptSetActorAnimation ; $4034
FarPtr_ScriptWaitActorIdle:
	dw ScriptWaitActorIdle ; $4036
FarPtr_SetPlayerMoveSpeed:
	dw SetPlayerMoveSpeed ; $4038
FarPtr_MovePlayerToPosition:
	dw MovePlayerToPosition ; $403a
FarPtr_MovePlayerToActor:
	dw MovePlayerToActor ; $403c
FarPtr_WaitPlayerMoveDone:
	dw WaitPlayerMoveDone ; $403e
FarPtr_SetScreenShake:
	dw SetScreenShake ; $4040
FarPtr_ScriptSetActorJumpVelocity:
	dw ScriptSetActorJumpVelocity ; $4042
FarPtr_ScriptWaitActorJumpDone:
	dw ScriptWaitActorJumpDone ; $4044
FarPtr_RunMenuFromText:
	dw RunMenuFromText ; $4046
FarPtr_SetActorActive:
	dw SetActorActive ; $4048
FarPtr_InitStoryMatchSettings:
	dw InitStoryMatchSettings ; $404a
FarPtr_RunStoryMatch:
	dw RunStoryMatch ; $404c
FarPtr_RestoreOverworldAfterMatch:
	dw RestoreOverworldAfterMatch ; $404e
FarPtr_SetMatchDoublesMode:
	dw SetMatchDoublesMode ; $4050
FarPtr_SetStoryMatchOpponent:
	dw SetStoryMatchOpponent ; $4052
FarPtr_SetCurrentlyUsedCourt:
	dw SetCurrentlyUsedCourt ; $4054
FarPtr_SetMatchNumberOfSets:
	dw SetMatchNumberOfSets ; $4056
FarPtr_SetMatchNumberOfGames:
	dw SetMatchNumberOfGames ; $4058
FarPtr_LoadMatchSettingsFromTable:
	dw LoadMatchSettingsFromTable ; $405a
FarPtr_RunStoryModeOverworld:
	dw RunStoryModeOverworld ; $405c
FarPtr_InitLocationActors:
	dw InitLocationActors ; $405e
FarPtr_WriteStoryStateWord:
	dw WriteStoryStateWord ; $4060
FarPtr_SaveStoryReturnPoint:
	dw SaveStoryReturnPoint ; $4062
FarPtr_RestoreStoryReturnPoint:
	dw RestoreStoryReturnPoint ; $4064
FarPtr_GetStoryLocationCount:
	dw GetStoryLocationCount ; $4066
FarPtr_LoadStoryObjPalettes:
	dw LoadStoryObjPalettes ; $4068
FarPtr_InitSceneScroll:
	dw InitSceneScroll ; $406a
FarPtr_LoadStorySceneGraphics:
	dw LoadStorySceneGraphics ; $406c
FarPtr_CopySceneTilemapToVram:
	dw CopySceneTilemapToVram ; $406e
FarPtr_UpdateSceneScroll:
	dw UpdateSceneScroll ; $4070
FarPtr_InitSceneViewer:
	dw InitSceneViewer ; $4072
FarPtr_RunSceneSelectDebugMenu:
	dw RunSceneSelectDebugMenu ; $4074
FarPtr_CopyScrolledSceneTilemapToVram:
	dw CopyScrolledSceneTilemapToVram ; $4076
FarPtr_LoadAndDisplayScene:
	dw LoadAndDisplayScene ; $4078
FarPtr_InitSceneTileAnimations:
	dw InitSceneTileAnimations ; $407a
FarPtr_StopSceneTileAnimations:
	dw StopSceneTileAnimations ; $407c
FarPtr_CopySceneTilemapRect:
	dw CopySceneTilemapRect ; $407e
FarPtr_CopyCollisionMapRect:
	dw CopyCollisionMapRect ; $4080
FarPtr_CopyBehaviorMapRect:
	dw CopyBehaviorMapRect ; $4082
FarPtr_ReadCollisionMapCell:
	dw ReadCollisionMapCell ; $4084
FarPtr_ReadBehaviorMapCell:
	dw ReadBehaviorMapCell ; $4086
FarPtr_WriteCollisionMapCell:
	dw WriteCollisionMapCell ; $4088
FarPtr_WriteBehaviorMapCell:
	dw WriteBehaviorMapCell ; $408a
FarPtr_LoadCourtSceneGraphics:
	dw LoadCourtSceneGraphics ; $408c
FarPtr_UpdateSceneViewerScroll:
	dw UpdateSceneViewerScroll ; $408e
FarPtr_ShowLocationNamePopup:
	dw ShowLocationNamePopup ; $4090
FarPtr_CopySceneTilemapChunk:
	dw CopySceneTilemapChunk ; $4092
FarPtr_ClearStatusSetupMenuEntry:
	dw ClearStatusSetupMenuEntry ; $4094
FarPtr_InitMinigameTargets:
	dw InitMinigameTargets ; $4096
FarPtr_UpdateMinigameTargets:
	dw UpdateMinigameTargets ; $4098
FarPtr_SpawnMinigameTargetFormation:
	dw SpawnMinigameTargetFormation ; $409a
FarPtr_DrawNumberWithSprites:
	dw DrawNumberWithSprites ; $409c
FarPtr_DeflectBallOffMinigameTarget:
	dw DeflectBallOffMinigameTarget ; $409e
FarPtr_StopSceneScrollTask:
	dw StopSceneScrollTask ; $40a0
FarPtr_RunEndingCreditsSequence:
	dw RunEndingCreditsSequence ; $40a2
	push af ; $40a4
	push bc ; $40a5
	push de ; $40a6
	push hl ; $40a7
	ldh a, [hInputRisingEdge] ; $40a8
	and a, $08 ; $40aa
	jr z, Label_0a_40cb ; $40ac
	test_flag $02, 6 ; $40ae
	jr z, Label_0a_40c0 ; $40b1
	clear_flag $02, 6 ; $40b3
	ld a, [wMessageSpeed] ; $40b6
	or a, $80 ; $40b9
	ld [wMessageSpeed], a ; $40bb
	jr Label_0a_40cb ; $40be
Label_0a_40c0:
	set_flag $02, 6 ; $40c0
	ld a, [wMessageSpeed] ; $40c3
	and a, $7f ; $40c6
	ld [wMessageSpeed], a ; $40c8
Label_0a_40cb:
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
	ld [$c363], a ; $40e4
	xor a, a ; $40e7
	ld [$c368], a ; $40e8
	ld [$c369], a ; $40eb
	ld a, $01 ; $40ee
	call SetActorNullScript ; $40f0
	ldh a, [hDebugStepMode] ; $40f3
	or a, a ; $40f5
	jr z, Label_0a_4100 ; $40f6
	ld a, $01 ; $40f8
	ld hl, $40a4 ; $40fa
	call RegisterFrameTask ; $40fd
Label_0a_4100:
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
	xor a, a ; $4109
	ld [$c368], a ; $410a
	ld [$c369], a ; $410d
	ld bc, $d040 ; $4110
	ld de, $d000 ; $4113
	farcall FarPtr_04_1e ; $4116
	ld hl, $40a4 ; $4119
	call UnregisterFrameTask ; $411c
	clear_flag $02, 6 ; $411f
	ldh a, [hWramBank] ; $4122
	push af ; $4124
	wram_bank $04 ; $4125
	ld a, [$d014] ; $412b
	ld [$daea], a ; $412e
	pop af ; $4131
	wram_bank ; $4132
	pop hl ; $4136
	pop de ; $4137
	pop bc ; $4138
	pop af ; $4139
	ret ; $413a
	INCBIN "data/bank_00a/d_413b.bin" ; $413b, 4 bytes
WaitScriptFrames:
	push af ; $413f
	push bc ; $4140
	test_flag $02, 6 ; $4141
	jr z, Label_0a_4148 ; $4144
	ld a, $02 ; $4146
Label_0a_4148:
	or a, a ; $4148
	jr z, Label_0a_4151 ; $4149
	ld c, a ; $414b
	call WaitFrames ; $414c
	pop bc ; $414f
	pop af ; $4150
Label_0a_4151:
	ret ; $4151
ScriptRespawnLocationActors:
	farcall FarPtr_InitLocationActors ; $4152
	ret ; $4155
InitDialogueTextCursor:
	push af ; $4156
	ldh a, [hWramBank] ; $4157
	push af ; $4159
	wram_bank $05 ; $415a
	farcall FarPtr_SetActiveWindowTextId ; $4160
	ld a, l ; $4163
	ld [$d852], a ; $4164
	ld a, h ; $4167
	ld [$d853], a ; $4168
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
	ld hl, $d852 ; $417e
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
	ld hl, $d852 ; $41a1
	ld a, [hl+] ; $41a4
	ld h, [hl] ; $41a5
	ld l, a ; $41a6
	test_flag $02, 6 ; $41a7
	jr nz, Label_0a_41b0 ; $41aa
	ld a, b ; $41ac
	farcall FarPtr_ShowSpeakerDialogue ; $41ad
Label_0a_41b0:
	inc hl ; $41b0
	ld a, l ; $41b1
	ld [$d852], a ; $41b2
	ld a, h ; $41b5
	ld [$d853], a ; $41b6
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
	ld a, [$d852] ; $41d0
	ld l, a ; $41d3
	ld a, [$d853] ; $41d4
	ld h, a ; $41d7
	test_flag $02, 6 ; $41d8
	jr nz, Label_0a_41e1 ; $41db
	ld a, b ; $41dd
	farcall FarPtr_ShowSpeakerDialogueRestoreBG ; $41de
Label_0a_41e1:
	inc hl ; $41e1
	ld a, l ; $41e2
	ld [$d852], a ; $41e3
	ld a, h ; $41e6
	ld [$d853], a ; $41e7
	pop af ; $41ea
	wram_bank ; $41eb
	pop hl ; $41ef
	pop af ; $41f0
	ret ; $41f1
ScriptCloseDialogueWindow:
	farcall FarPtr_CloseActiveDialogueWindow ; $41f2
	ret ; $41f5
RunDialogueYesNoPrompt:
	push bc ; $41f6
	push de ; $41f7
	push hl ; $41f8
	ldh a, [hWramBank] ; $41f9
	push af ; $41fb
	wram_bank $05 ; $41fc
	call FindDialogueChoiceMarker ; $4202
	ld a, [$d829] ; $4205
	push af ; $4208
	xor a, a ; $4209
	ld [$d829], a ; $420a
	call ShowYesNoPromptWindow ; $420d
	farcall FarPtr_RenderMenuWindowText ; $4210
	farcall FarPtr_RunMenuSelection ; $4213
	ld b, a ; $4216
	call FindDialogueChoiceMarker ; $4217
	ld a, [$d82f] ; $421a
	farcall FarPtr_CloseWindow ; $421d
	xor a, a ; $4220
	ld [$d84f], a ; $4221
	ld a, $ff ; $4224
	ld [$d82f], a ; $4226
	pop af ; $4229
	ld [$d829], a ; $422a
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
	ld a, [$d851] ; $423e
	ld b, a ; $4241
	and a, $7f ; $4242
	ld e, a ; $4244
	rl b ; $4245
	jr nc, Label_0a_4255 ; $4247
	cp a, $09 ; $4249
	jr c, Label_0a_4251 ; $424b
	ld e, $01 ; $424d
	jr Label_0a_427f ; $424f
Label_0a_4251:
	ld e, $0a ; $4251
	jr Label_0a_427f ; $4253
Label_0a_4255:
	call GetActorStateAddr ; $4255
	ld a, [$c323] ; $4258
	ld b, a ; $425b
	ld a, l ; $425c
	ldh [$ffea], a ; $425d
	ld a, h ; $425f
	ldh [$ffeb], a ; $4260
	wram_bank $04 ; $4262
	ld hl, $ffea ; $4268
	ld a, [hl+] ; $426b
	ld h, [hl] ; $426c
	add a, $0c ; $426d
	ld l, a ; $426f
	inc hl ; $4270
	inc hl ; $4271
	inc hl ; $4272
	ld a, [hl] ; $4273
	sub a, b ; $4274
	cp a, $0a ; $4275
	jr c, Label_0a_427d ; $4277
	ld e, $0a ; $4279
	jr Label_0a_427f ; $427b
Label_0a_427d:
	ld e, $01 ; $427d
Label_0a_427f:
	pop af ; $427f
	wram_bank ; $4280
	ld d, $02 ; $4284
	ld hl, $001a ; $4286
	farcall FarPtr_CreateMenuWindowFromText ; $4289
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
	ld hl, $d852 ; $4295
	ld a, [hl+] ; $4298
	ld h, [hl] ; $4299
	ld l, a ; $429a
	dec hl ; $429b
	xor a, a ; $429c
	farcall FarPtr_AddTextIdOffset ; $429d
	farcall FarPtr_FetchDialogueText ; $42a0
	ld hl, wTextBuffer ; $42a3
	ld bc, $0180 ; $42a6
	ld de, $0000 ; $42a9
Label_0a_42ac:
	ld a, $00 ; $42ac
	cp a, [hl] ; $42ae
	jr z, Label_0a_42be ; $42af
	ld a, $02 ; $42b1
	cp a, [hl] ; $42b3
	inc hl ; $42b4
	jr nz, Label_0a_42b9 ; $42b5
	ld d, h ; $42b7
	ld e, l ; $42b8
Label_0a_42b9:
	dec bc ; $42b9
	ld a, b ; $42ba
	or a, c ; $42bb
	jr nz, Label_0a_42ac ; $42bc
Label_0a_42be:
	ld a, d ; $42be
	or a, e ; $42bf
	jr z, Label_0a_42ca ; $42c0
	ld a, e ; $42c2
	ld [$d84e], a ; $42c3
	ld a, d ; $42c6
	ld [$d84f], a ; $42c7
Label_0a_42ca:
	pop hl ; $42ca
	pop de ; $42cb
	pop bc ; $42cc
	pop af ; $42cd
	ret ; $42ce
RunMenuFromText:
	push bc ; $42cf
	push de ; $42d0
	push hl ; $42d1
	farcall FarPtr_CreateMenuWindowFromText ; $42d2
	ld b, a ; $42d5
	farcall FarPtr_RestoreShadowTilemap ; $42d6
	farcall FarPtr_RenderMenuWindowText ; $42d9
	farcall FarPtr_RunMenuSelection ; $42dc
	ld c, a ; $42df
	ld a, b ; $42e0
	farcall FarPtr_CloseWindow ; $42e1
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
	ld a, [$d852] ; $42f4
	ld l, a ; $42f7
	ld a, [$d853] ; $42f8
	ld h, a ; $42fb
	test_flag $02, 6 ; $42fc
	jr nz, Label_0a_4301 ; $42ff
Label_0a_4301:
	inc hl ; $4301
	ld a, l ; $4302
	ld [$d852], a ; $4303
	ld a, h ; $4306
	ld [$d853], a ; $4307
	pop af ; $430a
	wram_bank ; $430b
	pop hl ; $430f
	pop af ; $4310
	ret ; $4311
GetActorStateAddr:
	ld hl, $d000 ; $4312
	cp a, $18 ; $4315
	jr nc, Label_0a_4326 ; $4317
	ld h, a ; $4319
	xor a, a ; $431a
	srl h ; $431b
	rra ; $431d
	srl h ; $431e
	rra ; $4320
	ld l, a ; $4321
	ld a, $d0 ; $4322
	add a, h ; $4324
	ld h, a ; $4325
Label_0a_4326:
	wram_bank $04 ; $4326
	push hl ; $432c
	ld a, $20 ; $432d
	add a, l ; $432f
	ld l, a ; $4330
	jr nc, Label_0a_4334 ; $4331
	inc h ; $4333
Label_0a_4334:
	ld a, [hl] ; $4334
	cp a, $00 ; $4335
	pop hl ; $4337
	inc h ; $4338
	dec h ; $4339
	ret ; $433a
ScriptSetActorMoveSpeed:
	call GetActorStateAddr ; $433b
	ret z ; $433e
	wram_bank $04 ; $433f
	ld a, $06 ; $4345
	add a, l ; $4347
	ld l, a ; $4348
	jr nc, Label_0a_434c ; $4349
	inc h ; $434b
Label_0a_434c:
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
	farcall FarPtr_SetActorScript ; $4360
	ret ; $4363
SetActorNullScript:
	call GetActorStateAddr ; $4364
	ld c, l ; $4367
	ld b, h ; $4368
	ld hl, $4766 ; $4369
	ldh a, [hRomBank] ; $436c
	farcall FarPtr_SetActorScript ; $436e
	ret ; $4371
WaitActorScriptDone:
	call GetActorStateAddr ; $4372
	push af ; $4375
	push bc ; $4376
	ld bc, $0258 ; $4377
Label_0a_437a:
	call CheckActorScriptEnd ; $437a
	jr z, Label_0a_4387 ; $437d
	call AdvanceFrame ; $437f
	dec bc ; $4382
	ld a, c ; $4383
	or a, b ; $4384
	jr nz, Label_0a_437a ; $4385
Label_0a_4387:
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
	cp a, $00 ; $43a0
	pop de ; $43a2
	ret ; $43a3
ScriptWaitActorMoveDone:
	call GetActorStateAddr ; $43a4
	farcall FarPtr_WaitActorMoveDone ; $43a7
	ret ; $43aa
ScriptWaitActorJumpDone:
	call GetActorStateAddr ; $43ab
	farcall FarPtr_04_2a ; $43ae
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
	jr z, Label_0a_43d5 ; $43c4
	ld a, l ; $43c6
	ldh [$ffea], a ; $43c7
	ld a, h ; $43c9
	ldh [$ffeb], a ; $43ca
	wram_bank $04 ; $43cc
	call Func_0a_43d8 ; $43d2
Label_0a_43d5:
	add sp, 4 ; $43d5
	ret ; $43d7
Func_0a_43d8:
	push bc ; $43d8
	push af ; $43d9
	ld hl, $ffea ; $43da
	ld a, [hl+] ; $43dd
	ld h, [hl] ; $43de
	add a, $0c ; $43df
	ld l, a ; $43e1
	ld e, l ; $43e2
	ld d, h ; $43e3
	pop af ; $43e4
	ld l, c ; $43e5
	ld h, b ; $43e6
	ld bc, $0004 ; $43e7
	call CopyMemoryBC ; $43ea
	pop bc ; $43ed
	ld hl, $ffea ; $43ee
	ld a, [hl+] ; $43f1
	ld h, [hl] ; $43f2
	add a, $05 ; $43f3
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
	jr z, Label_0a_441c ; $440b
	ld a, l ; $440d
	ldh [$ffea], a ; $440e
	ld a, h ; $4410
	ldh [$ffeb], a ; $4411
	wram_bank $04 ; $4413
	call Func_0a_441f ; $4419
Label_0a_441c:
	add sp, 4 ; $441c
	ret ; $441e
Func_0a_441f:
	push bc ; $441f
	push af ; $4420
	ld hl, $ffea ; $4421
	ld a, [hl+] ; $4424
	ld h, [hl] ; $4425
	add a, $08 ; $4426
	ld l, a ; $4428
	ld e, l ; $4429
	ld d, h ; $442a
	pop af ; $442b
	ld l, c ; $442c
	ld h, b ; $442d
	ld bc, $0004 ; $442e
	call CopyMemoryBC ; $4431
	pop bc ; $4434
	ld hl, $ffea ; $4435
	ld a, [hl+] ; $4438
	ld h, [hl] ; $4439
	add a, $05 ; $443a
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
	jr z, Label_0a_4462 ; $4457
	ld a, l ; $4459
	ldh [$ffea], a ; $445a
	ld a, h ; $445c
	ldh [$ffeb], a ; $445d
	call MoveActorTowardPointRaw ; $445f
Label_0a_4462:
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
	ld hl, $ffea ; $4475
	ld a, [hl+] ; $4478
	ld b, [hl] ; $4479
	ld c, a ; $447a
	ld hl, $000c ; $447b
	add hl, bc ; $447e
	ld a, [hl+] ; $447f
	ld h, [hl] ; $4480
	ld l, a ; $4481
	ld a, l ; $4482
	sub a, e ; $4483
	ld l, a ; $4484
	ld a, h ; $4485
	sbc a, d ; $4486
	ld h, a ; $4487
	pop de ; $4488
	push hl ; $4489
	ld hl, $000e ; $448a
	add hl, bc ; $448d
	ld a, [hl+] ; $448e
	ld h, [hl] ; $448f
	ld l, a ; $4490
	ld a, l ; $4491
	sub a, e ; $4492
	ld l, a ; $4493
	ld a, h ; $4494
	sbc a, d ; $4495
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
	ld hl, $ffea ; $44aa
	ld a, [hl+] ; $44ad
	ld h, [hl] ; $44ae
	add a, $08 ; $44af
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
	ld hl, $ffea ; $44c0
	ld a, [hl+] ; $44c3
	ld h, [hl] ; $44c4
	add a, $05 ; $44c5
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
	jr z, Label_0a_44ee ; $44dd
	ld a, l ; $44df
	ldh [$ffea], a ; $44e0
	ld a, h ; $44e2
	ldh [$ffeb], a ; $44e3
	wram_bank $04 ; $44e5
	call MoveActorByDeltaRaw ; $44eb
Label_0a_44ee:
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
	ld hl, $ffea ; $44fc
	ld a, [hl+] ; $44ff
	ld h, [hl] ; $4500
	add a, $0c ; $4501
	ld l, a ; $4503
	ld a, [hl+] ; $4504
	ld h, [hl] ; $4505
	ld l, a ; $4506
	add hl, de ; $4507
	ld e, l ; $4508
	ld d, h ; $4509
	ld hl, $ffea ; $450a
	ld a, [hl+] ; $450d
	ld h, [hl] ; $450e
	add a, $08 ; $450f
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
	ld hl, $ffea ; $4521
	ld a, [hl+] ; $4524
	ld h, [hl] ; $4525
	add a, $0e ; $4526
	ld l, a ; $4528
	ld a, [hl+] ; $4529
	ld h, [hl] ; $452a
	ld l, a ; $452b
	add hl, de ; $452c
	ld e, l ; $452d
	ld d, h ; $452e
	ld hl, $ffea ; $452f
	ld a, [hl+] ; $4532
	ld h, [hl] ; $4533
	add a, $0a ; $4534
	ld l, a ; $4536
	ld a, e ; $4537
	ld [hl+], a ; $4538
	ld [hl], d ; $4539
	ld hl, $ffea ; $453a
	ld a, [hl+] ; $453d
	ld h, [hl] ; $453e
	add a, $05 ; $453f
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
	jr z, Label_0a_4566 ; $4555
	ld a, l ; $4557
	ldh [$ffea], a ; $4558
	ld a, h ; $455a
	ldh [$ffeb], a ; $455b
	wram_bank $04 ; $455d
	call MoveActorByAngleRaw ; $4563
Label_0a_4566:
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
	ld hl, $ffea ; $4582
	ld a, [hl+] ; $4585
	ld h, [hl] ; $4586
	add a, $0c ; $4587
	ld l, a ; $4589
	ld a, [hl+] ; $458a
	ld h, [hl] ; $458b
	ld l, a ; $458c
	add hl, de ; $458d
	ld e, l ; $458e
	ld d, h ; $458f
	ld hl, $ffea ; $4590
	ld a, [hl+] ; $4593
	ld h, [hl] ; $4594
	add a, $08 ; $4595
	ld l, a ; $4597
	ld a, e ; $4598
	ld [hl+], a ; $4599
	ld [hl], d ; $459a
	pop de ; $459b
	ld hl, $ffea ; $459c
	ld a, [hl+] ; $459f
	ld h, [hl] ; $45a0
	add a, $0e ; $45a1
	ld l, a ; $45a3
	ld a, [hl+] ; $45a4
	ld h, [hl] ; $45a5
	ld l, a ; $45a6
	add hl, de ; $45a7
	ld e, l ; $45a8
	ld d, h ; $45a9
	ld hl, $ffea ; $45aa
	ld a, [hl+] ; $45ad
	ld h, [hl] ; $45ae
	add a, $0a ; $45af
	ld l, a ; $45b1
	ld a, e ; $45b2
	ld [hl+], a ; $45b3
	ld [hl], d ; $45b4
	ld hl, $ffea ; $45b5
	ld a, [hl+] ; $45b8
	ld h, [hl] ; $45b9
	add a, $05 ; $45ba
	ld l, a ; $45bc
	set 7, [hl] ; $45bd
	ret ; $45bf
ScriptSetActorFacingLock:
	call GetActorStateAddr ; $45c0
	ret z ; $45c3
	ld a, b ; $45c4
	and a, a ; $45c5
	ld c, l ; $45c6
	ld b, h ; $45c7
	jr nz, Label_0a_45db ; $45c8
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
Label_0a_45db:
	ld hl, $0030 ; $45db
	add hl, bc ; $45de
	set 0, [hl] ; $45df
	ret ; $45e1
SetActorFacing:
	call GetActorStateAddr ; $45e2
	ret z ; $45e5
	wram_bank $04 ; $45e6
	ld a, $14 ; $45ec
	add a, l ; $45ee
	ld l, a ; $45ef
	jr nc, Label_0a_45f3 ; $45f0
	inc h ; $45f2
Label_0a_45f3:
	ld [hl], b ; $45f3
	ret ; $45f4
FaceActorTowardActor:
	push af ; $45f5
	push bc ; $45f6
	push de ; $45f7
	push hl ; $45f8
	ld d, a ; $45f9
	call GetActorStateAddr ; $45fa
	jr z, Label_0a_466a ; $45fd
	ld a, b ; $45ff
	call GetActorStateAddr ; $4600
	inc h ; $4603
	dec h ; $4604
	jr z, Label_0a_466a ; $4605
	ld a, l ; $4607
	ldh [$ffea], a ; $4608
	ld a, h ; $460a
	ldh [$ffeb], a ; $460b
	wram_bank $04 ; $460d
	ld hl, $ffea ; $4613
	ld a, [hl+] ; $4616
	ld h, [hl] ; $4617
	add a, $0c ; $4618
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
	ldh [$ffea], a ; $4629
	ld a, h ; $462b
	ldh [$ffeb], a ; $462c
	ld hl, $ffea ; $462e
	ld a, [hl+] ; $4631
	ld h, [hl] ; $4632
	add a, $0e ; $4633
	ld l, a ; $4635
	ld a, [hl+] ; $4636
	ld h, [hl] ; $4637
	ld l, a ; $4638
	ld d, h ; $4639
	ld e, l ; $463a
	pop hl ; $463b
	ld a, l ; $463c
	sub a, e ; $463d
	ld l, a ; $463e
	ld a, h ; $463f
	sbc a, d ; $4640
	ld h, a ; $4641
	ld b, h ; $4642
	ld c, l ; $4643
	ld hl, $ffea ; $4644
	ld a, [hl+] ; $4647
	ld h, [hl] ; $4648
	add a, $0c ; $4649
	ld l, a ; $464b
	ld a, [hl+] ; $464c
	ld h, [hl] ; $464d
	ld l, a ; $464e
	ld d, h ; $464f
	ld e, l ; $4650
	pop hl ; $4651
	ld a, l ; $4652
	sub a, e ; $4653
	ld l, a ; $4654
	ld a, h ; $4655
	sbc a, d ; $4656
	ld h, a ; $4657
	ld d, h ; $4658
	ld e, l ; $4659
	ld h, b ; $465a
	ld l, c ; $465b
	call AngleFromVectorCoarse ; $465c
	push af ; $465f
	ld hl, $ffea ; $4660
	ld a, [hl+] ; $4663
	ld h, [hl] ; $4664
	add a, $14 ; $4665
	ld l, a ; $4667
	pop af ; $4668
	ld [hl], a ; $4669
Label_0a_466a:
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
	jp z, Label_0a_46fd ; $4679
	ld a, b ; $467c
	call GetActorStateAddr ; $467d
	inc h ; $4680
	dec h ; $4681
	jp z, Label_0a_46fd ; $4682
	push hl ; $4685
	ld a, l ; $4686
	ldh [$ffea], a ; $4687
	ld a, h ; $4689
	ldh [$ffeb], a ; $468a
	wram_bank $04 ; $468c
	ld hl, $ffea ; $4692
	ld a, [hl+] ; $4695
	ld h, [hl] ; $4696
	add a, $0c ; $4697
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
	ldh [$ffea], a ; $46a8
	ld a, h ; $46aa
	ldh [$ffeb], a ; $46ab
	ld hl, $ffea ; $46ad
	ld a, [hl+] ; $46b0
	ld h, [hl] ; $46b1
	add a, $0e ; $46b2
	ld l, a ; $46b4
	ld a, [hl+] ; $46b5
	ld h, [hl] ; $46b6
	ld l, a ; $46b7
	ld d, h ; $46b8
	ld e, l ; $46b9
	pop hl ; $46ba
	ld a, l ; $46bb
	sub a, e ; $46bc
	ld l, a ; $46bd
	ld a, h ; $46be
	sbc a, d ; $46bf
	ld h, a ; $46c0
	ld b, h ; $46c1
	ld c, l ; $46c2
	ld hl, $ffea ; $46c3
	ld a, [hl+] ; $46c6
	ld h, [hl] ; $46c7
	add a, $0c ; $46c8
	ld l, a ; $46ca
	ld a, [hl+] ; $46cb
	ld h, [hl] ; $46cc
	ld l, a ; $46cd
	ld d, h ; $46ce
	ld e, l ; $46cf
	pop hl ; $46d0
	ld a, l ; $46d1
	sub a, e ; $46d2
	ld l, a ; $46d3
	ld a, h ; $46d4
	sbc a, d ; $46d5
	ld h, a ; $46d6
	ld d, h ; $46d7
	ld e, l ; $46d8
	ld h, b ; $46d9
	ld l, c ; $46da
	call AngleFromVectorCoarse ; $46db
	push af ; $46de
	ld hl, $ffea ; $46df
	ld a, [hl+] ; $46e2
	ld h, [hl] ; $46e3
	add a, $14 ; $46e4
	ld l, a ; $46e6
	pop af ; $46e7
	ld [hl], a ; $46e8
	add a, $80 ; $46e9
	pop hl ; $46eb
	ld d, a ; $46ec
	ld a, l ; $46ed
	ldh [$ffea], a ; $46ee
	ld a, h ; $46f0
	ldh [$ffeb], a ; $46f1
	ld hl, $ffea ; $46f3
	ld a, [hl+] ; $46f6
	ld h, [hl] ; $46f7
	add a, $14 ; $46f8
	ld l, a ; $46fa
	ld a, d ; $46fb
	ld [hl], a ; $46fc
Label_0a_46fd:
	pop hl ; $46fd
	pop de ; $46fe
	pop bc ; $46ff
	pop af ; $4700
	ret ; $4701
ScriptSetActorAnimation:
	call GetActorStateAddr ; $4702
	ld c, l ; $4705
	ld b, h ; $4706
	farcall FarPtr_SetActorAnimationChecked ; $4707
	ret ; $470a
ScriptWaitActorIdle:
	test_flag $02, 6 ; $470b
	jr nz, Label_0a_4718 ; $470e
	call GetActorStateAddr ; $4710
	ld c, l ; $4713
	ld b, h ; $4714
	call WaitActorIdle ; $4715
Label_0a_4718:
	ret ; $4718
ScriptSetActorJumpVelocity:
	call GetActorStateAddr ; $4719
	ret z ; $471c
	wram_bank $04 ; $471d
	ld a, $12 ; $4723
	add a, l ; $4725
	ld l, a ; $4726
	jr nc, Label_0a_472a ; $4727
	inc h ; $4729
Label_0a_472a:
	ld a, e ; $472a
	ld [hl+], a ; $472b
	ld [hl], d ; $472c
	ret ; $472d
SetActorActive:
	call GetActorStateAddr ; $472e
	ret z ; $4731
	wram_bank $04 ; $4732
	ld a, $20 ; $4738
	add a, l ; $473a
	ld l, a ; $473b
	jr nc, Label_0a_473f ; $473c
	inc h ; $473e
Label_0a_473f:
	ld [hl], b ; $473f
	ret ; $4740
	INCBIN "data/bank_00a/d_4741.bin" ; $4741, 43 bytes
IsActorBusy:
	xor a, a ; $476c
	inc h ; $476d
	dec h ; $476e
	ret z ; $476f
	push de ; $4770
	push hl ; $4771
	wram_bank $04 ; $4772
	ld de, $002e ; $4778
	add hl, de ; $477b
	ld a, [hl] ; $477c
	cp a, $00 ; $477d
	jr z, Label_0a_4789 ; $477f
	cp a, $01 ; $4781
	jr z, Label_0a_4789 ; $4783
	ld a, $01 ; $4785
	jr Label_0a_478a ; $4787
Label_0a_4789:
	xor a, a ; $4789
Label_0a_478a:
	pop hl ; $478a
	pop de ; $478b
	ret ; $478c
WaitActorIdle:
	push af ; $478d
	push bc ; $478e
	ld bc, $00f0 ; $478f
Label_0a_4792:
	call IsActorBusy ; $4792
	and a, a ; $4795
	jr z, Label_0a_47a0 ; $4796
	call AdvanceFrame ; $4798
	dec bc ; $479b
	ld a, b ; $479c
	or a, c ; $479d
	jr nz, Label_0a_4792 ; $479e
Label_0a_47a0:
	pop bc ; $47a0
	pop af ; $47a1
	ret ; $47a2
SetPlayerMoveSpeed:
	push af ; $47a3
	push hl ; $47a4
	wram_bank $04 ; $47a5
	ld hl, $d046 ; $47ab
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
	ld hl, $d040 ; $47c8
	ld a, l ; $47cb
	ldh [$ffea], a ; $47cc
	ld a, h ; $47ce
	ldh [$ffeb], a ; $47cf
	wram_bank $04 ; $47d1
	ld a, d ; $47d7
	or a, a ; $47d8
	jr nz, Label_0a_47e0 ; $47d9
	call Func_0a_441f ; $47db
	jr Label_0a_480c ; $47de
Label_0a_47e0:
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
	ldh [$ffea], a ; $47f1
	ld a, h ; $47f3
	ldh [$ffeb], a ; $47f4
	call Func_0a_43d8 ; $47f6
	call AdvanceFrame ; $47f9
	farcall FarPtr_RestoreShadowTilemap ; $47fc
	ld b, $05 ; $47ff
	call AdvanceFrame ; $4801
	ld c, $7f ; $4804
	call BeginFadeIn ; $4806
	call WaitFadeEnd ; $4809
Label_0a_480c:
	add sp, 4 ; $480c
	pop hl ; $480e
	pop de ; $480f
	pop bc ; $4810
	pop af ; $4811
	ret ; $4812
MovePlayerToActor:
	cp a, $ff ; $4813
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
	ldh [$ffea], a ; $482a
	ld a, h ; $482c
	ldh [$ffeb], a ; $482d
	ld hl, $ffea ; $482f
	ld a, [hl+] ; $4832
	ld h, [hl] ; $4833
	add a, $0c ; $4834
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
	ld hl, $d040 ; $484d
	ld a, l ; $4850
	ldh [$ffea], a ; $4851
	ld a, h ; $4853
	ldh [$ffeb], a ; $4854
	ld a, d ; $4856
	or a, a ; $4857
	jr nz, Label_0a_485f ; $4858
	call Func_0a_441f ; $485a
	jr Label_0a_488b ; $485d
Label_0a_485f:
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
	ldh [$ffea], a ; $4870
	ld a, h ; $4872
	ldh [$ffeb], a ; $4873
	call Func_0a_43d8 ; $4875
	call AdvanceFrame ; $4878
	farcall FarPtr_RestoreShadowTilemap ; $487b
	ld b, $05 ; $487e
	call AdvanceFrame ; $4880
	ld c, $7f ; $4883
	call BeginFadeIn ; $4885
	call WaitFadeEnd ; $4888
Label_0a_488b:
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
	ld hl, $d040 ; $4898
	ld a, l ; $489b
	ldh [$ffea], a ; $489c
	ld a, h ; $489e
	ldh [$ffeb], a ; $489f
	wram_bank $04 ; $48a1
	ld a, $05 ; $48a7
	add a, l ; $48a9
	ld l, a ; $48aa
	jr nc, Label_0a_48ae ; $48ab
	inc h ; $48ad
Label_0a_48ae:
	ld a, $01 ; $48ae
	call WaitScriptFrames ; $48b0
	bit 7, [hl] ; $48b3
	jr z, Label_0a_48bc ; $48b5
	dec bc ; $48b7
	ld a, c ; $48b8
	or a, b ; $48b9
	jr nz, Label_0a_48ae ; $48ba
Label_0a_48bc:
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
	or a, a ; $48c9
	jr z, Label_0a_48e4 ; $48ca
	push af ; $48cc
	ld a, [$c363] ; $48cd
	inc a ; $48d0
	jr nz, Label_0a_48db ; $48d1
	ld a, $01 ; $48d3
	ld hl, $4908 ; $48d5
	call RegisterFrameTask ; $48d8
Label_0a_48db:
	pop af ; $48db
	cp a, $04 ; $48dc
	jr c, Label_0a_48fb ; $48de
	ld a, $03 ; $48e0
	jr Label_0a_48fb ; $48e2
Label_0a_48e4:
	ld a, [$c363] ; $48e4
	inc a ; $48e7
	ld a, $00 ; $48e8
	jr z, Label_0a_48fb ; $48ea
	xor a, a ; $48ec
	ld [$c368], a ; $48ed
	ld [$c369], a ; $48f0
	ld hl, $4908 ; $48f3
	call UnregisterFrameTask ; $48f6
	ld a, $ff ; $48f9
Label_0a_48fb:
	ld [$c363], a ; $48fb
	pop af ; $48fe
	wram_bank ; $48ff
	pop hl ; $4903
	pop de ; $4904
	pop bc ; $4905
	pop af ; $4906
	ret ; $4907
	push af ; $4908
	push bc ; $4909
	push de ; $490a
	push hl ; $490b
	ld a, [$c363] ; $490c
	ld c, $00 ; $490f
Label_0a_4911:
	scf ; $4911
	rl c ; $4912
	dec a ; $4914
	jr nz, Label_0a_4911 ; $4915
	call AdvanceRandomSeed ; $4917
	ld a, h ; $491a
	and a, c ; $491b
	jr nc, Label_0a_4920 ; $491c
	cpl ; $491e
	inc a ; $491f
Label_0a_4920:
	ld [$c368], a ; $4920
	ld a, l ; $4923
	and a, c ; $4924
	jr nc, Label_0a_4929 ; $4925
	cpl ; $4927
	inc a ; $4928
Label_0a_4929:
	ld [$c369], a ; $4929
	pop hl ; $492c
	pop de ; $492d
	pop bc ; $492e
	pop af ; $492f
	ret ; $4930
InitStoryMatchSettings:
	farcall FarPtr_InitDefaultMatchSettings ; $4931
	ld a, [wStoryModeMainCharacterOverworldSprite] ; $4934
	ld [wMatchPlayerChar], a ; $4937
	xor a, a ; $493a
	ld [wMatchIsDoubles], a ; $493b
	add a, $02 ; $493e
	ld [wOnCourtCharCount], a ; $4940
	ld a, $00 ; $4943
	ld [wCurrentMinigameStoryMatch], a ; $4945
	ld a, $0c ; $4948
	ld [wMatchOpponentChar], a ; $494a
	ld a, $02 ; $494d
	ld [wCurrentlyUsedCourt], a ; $494f
	ld a, $01 ; $4952
	ld [wMatchTypeNumberOfSets], a ; $4954
	ld a, $02 ; $4957
	ld [wMatchTypeNumberOfGames], a ; $4959
	ld a, $01 ; $495c
	ld [$c8f5], a ; $495e
	ret ; $4961
RunStoryMatch:
	ld c, $10 ; $4962
	call BeginFadeOut ; $4964
	call WaitFadeEnd ; $4967
	call AssignStoryMatchCharacters ; $496a
	farcall FarPtr_RunMatch ; $496d
	ld a, [$c8a5] ; $4970
	or a, a ; $4973
	jr z, Label_0a_498c ; $4974
	farcall FarPtr_SaveStorySlotWithTimer ; $4976
	ld a, $00 ; $4979
	ld [wStoryModeCurrentLocation], a ; $497b
	ld a, $01 ; $497e
	ld [wStoryModeEntryPoint], a ; $4980
	ld a, $ff ; $4983
	ld [$c294], a ; $4985
	ld [wStoryModeExitLocationRequest], a ; $4988
	ret ; $498b
Label_0a_498c:
	xor a, a ; $498c
	ld [wKeepMatchStatsFlag], a ; $498d
	ret ; $4990
RestoreOverworldAfterMatch:
	ld c, $10 ; $4991
	call BeginFadeOut ; $4993
	call WaitFadeEnd ; $4996
	farcall FarPtr_LoadStoryObjPalettes ; $4999
	call DisableLCDSafely ; $499c
	farcall FarPtr_01_0a ; $499f
	call EnableLCD ; $49a2
	xor a, a ; $49a5
	ld [$c8f5], a ; $49a6
	ret ; $49a9
AssignStoryMatchCharacters:
	ld b, $80 ; $49aa
	ld c, $00 ; $49ac
	farcall FarPtr_02_18 ; $49ae
	ld a, [wMatchOpponentChar] ; $49b1
	ld b, a ; $49b4
	ld c, $02 ; $49b5
	farcall FarPtr_02_18 ; $49b7
	ld a, [wMatchIsDoubles] ; $49ba
	or a, a ; $49bd
	jr z, Label_0a_49d8 ; $49be
	ld b, $81 ; $49c0
	ld c, $01 ; $49c2
	farcall FarPtr_02_18 ; $49c4
	ld a, [wMatchOpponentChar] ; $49c7
	ld hl, $49d9 ; $49ca
	add a, l ; $49cd
	ld l, a ; $49ce
	jr nc, Label_0a_49d2 ; $49cf
	inc h ; $49d1
Label_0a_49d2:
	ld b, [hl] ; $49d2
	ld c, $03 ; $49d3
	farcall FarPtr_02_18 ; $49d5
Label_0a_49d8:
	ret ; $49d8
	INCBIN "data/bank_00a/d_49d9.bin" ; $49d9, 104 bytes
SetMatchDoublesMode:
	ld [wMatchIsDoubles], a ; $4a41
	sla a ; $4a44
	add a, $02 ; $4a46
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
	ld de, $4ab2 ; $4a5c
	ld a, [wCurrentMinigameStoryMatch] ; $4a5f
	cp a, $01 ; $4a62
	ld a, $00 ; $4a64
	jr nz, Label_0a_4a6c ; $4a66
	inc a ; $4a68
	ld de, $4b2f ; $4a69
Label_0a_4a6c:
	call SetMatchDoublesMode ; $4a6c
	ld a, [$c8f7] ; $4a6f
	ld l, a ; $4a72
	ld h, $00 ; $4a73
	add hl, hl ; $4a75
	add hl, hl ; $4a76
	add a, l ; $4a77
	ld l, a ; $4a78
	jr nc, Label_0a_4a7c ; $4a79
	inc h ; $4a7b
Label_0a_4a7c:
	add hl, de ; $4a7c
	ld a, [hl+] ; $4a7d
	ld [wGameMode], a ; $4a7e
	ld a, [hl+] ; $4a81
	ld [wMatchOpponentChar], a ; $4a82
	ld a, [hl+] ; $4a85
	ld [wCurrentlyUsedCourt], a ; $4a86
	test_flag $04, 1 ; $4a89
	jr nz, Label_0a_4aa2 ; $4a8c
	ld a, [hl+] ; $4a8e
	ld e, a ; $4a8f
	and a, $0f ; $4a90
	ld [wMatchTypeNumberOfGames], a ; $4a92
	ld a, e ; $4a95
	swap a ; $4a96
	and a, $0f ; $4a98
	ld [wMatchTypeNumberOfSets], a ; $4a9a
	ld a, [hl] ; $4a9d
	ld [wMatchBGM], a ; $4a9e
	ret ; $4aa1
Label_0a_4aa2:
	ld a, $02 ; $4aa2
	ld [wMatchTypeNumberOfGames], a ; $4aa4
	ld a, $01 ; $4aa7
	ld [wMatchTypeNumberOfSets], a ; $4aa9
	inc hl ; $4aac
	ld a, [hl] ; $4aad
	ld [wMatchBGM], a ; $4aae
	ret ; $4ab1
	INCBIN "data/bank_00a/d_4ab2.bin" ; $4ab2, 250 bytes
RunClearStatusSetupMenu:
	push bc ; $4bac
	push de ; $4bad
	push hl ; $4bae
	ldh a, [hWramBank] ; $4baf
	push af ; $4bb1
	call ClearFrameTasks ; $4bb2
	call DisableLCDSafely ; $4bb5
	farcall FarPtr_01_0a ; $4bb8
	call EnableLCD ; $4bbb
	wram_bank $05 ; $4bbe
	ld hl, $df00 ; $4bc4
	ld c, $02 ; $4bc7
	call ClearMemory16 ; $4bc9
	farcall FarPtr_ResetTextWindowState ; $4bcc
	call ClearBgTilemaps ; $4bcf
	ld d, $00 ; $4bd2
	ld e, $0b ; $4bd4
	ld b, $14 ; $4bd6
	ld c, $07 ; $4bd8
	farcall FarPtr_CreateWindowFromScreenRect ; $4bda
	ld [$df05], a ; $4bdd
	farcall FarPtr_DrawTextWindowFrame ; $4be0
	ld c, $10 ; $4be3
	call BeginFadeIn ; $4be5
	call WaitFadeEnd ; $4be8
	wram_bank $05 ; $4beb
Label_0a_4bf1:
	ld a, [$df05] ; $4bf1
	farcall FarPtr_DrawTextWindowFrame ; $4bf4
	ld hl, $10e8 ; $4bf7
	ld de, $d181 ; $4bfa
	farcall FarPtr_RenderProportionalTextAt ; $4bfd
	ld a, [$df05] ; $4c00
	farcall FarPtr_RedrawWindowRows ; $4c03
	ld hl, $10d7 ; $4c06
	ld d, $01 ; $4c09
	ld e, $00 ; $4c0b
	farcall FarPtr_CreateMenuWindowFromText ; $4c0d
	farcall FarPtr_RestoreShadowTilemap ; $4c10
	farcall FarPtr_RenderMenuWindowText ; $4c13
	farcall FarPtr_RunMenuSelection ; $4c16
	ld [$df00], a ; $4c19
	ld a, [$d82f] ; $4c1c
	farcall FarPtr_CloseWindow ; $4c1f
	ld a, [$df00] ; $4c22
	cp a, $ff ; $4c25
	jr nz, Label_0a_4c31 ; $4c27
	ld a, $08 ; $4c29
	ld [$df06], a ; $4c2b
	jp Label_0a_4d1e ; $4c2e
Label_0a_4c31:
	or a, a ; $4c31
	jp z, Label_0a_4c3d ; $4c32
	ld a, $01 ; $4c35
	ld [$df06], a ; $4c37
	jp Label_0a_4d1e ; $4c3a
Label_0a_4c3d:
	test_flag $05, 7 ; $4c3d
	jr nz, Label_0a_4c45 ; $4c40
	xor a, a ; $4c42
	jr Label_0a_4c47 ; $4c43
Label_0a_4c45:
	ld a, $01 ; $4c45
Label_0a_4c47:
	ld [$df01], a ; $4c47
Label_0a_4c4a:
	ld a, [$df05] ; $4c4a
	farcall FarPtr_DrawTextWindowFrame ; $4c4d
	ld hl, $10e4 ; $4c50
	ld de, $d181 ; $4c53
	farcall FarPtr_RenderProportionalTextAt ; $4c56
	ld a, [$df05] ; $4c59
	farcall FarPtr_RedrawWindowRows ; $4c5c
	ld hl, $10d9 ; $4c5f
	ld d, $03 ; $4c62
	ld e, $00 ; $4c64
	farcall FarPtr_CreateMenuWindowFromText ; $4c66
	farcall FarPtr_RestoreShadowTilemap ; $4c69
	farcall FarPtr_RenderMenuWindowText ; $4c6c
	farcall FarPtr_RunMenuSelection ; $4c6f
	ld [$df02], a ; $4c72
	ld a, [$d82f] ; $4c75
	farcall FarPtr_CloseWindow ; $4c78
	ld a, [$df02] ; $4c7b
	cp a, $ff ; $4c7e
	jp z, Label_0a_4bf1 ; $4c80
Label_0a_4c83:
	ld a, [$df05] ; $4c83
	farcall FarPtr_DrawTextWindowFrame ; $4c86
	ld hl, $10e5 ; $4c89
	ld de, $d181 ; $4c8c
	farcall FarPtr_RenderProportionalTextAt ; $4c8f
	ld a, [$df05] ; $4c92
	farcall FarPtr_RedrawWindowRows ; $4c95
	ld hl, $10da ; $4c98
	ld d, $05 ; $4c9b
	ld e, $00 ; $4c9d
	farcall FarPtr_CreateMenuWindowFromText ; $4c9f
	farcall FarPtr_RestoreShadowTilemap ; $4ca2
	farcall FarPtr_RenderMenuWindowText ; $4ca5
	farcall FarPtr_RunMenuSelection ; $4ca8
	ld [$df03], a ; $4cab
	ld a, [$d82f] ; $4cae
	farcall FarPtr_CloseWindow ; $4cb1
	ld a, [$df03] ; $4cb4
	cp a, $ff ; $4cb7
	jp z, Label_0a_4c4a ; $4cb9
	ld a, [$df05] ; $4cbc
	farcall FarPtr_DrawTextWindowFrame ; $4cbf
	ld hl, $10e6 ; $4cc2
	ld a, [$df02] ; $4cc5
	add a, l ; $4cc8
	ld l, a ; $4cc9
	jr nc, Label_0a_4ccd ; $4cca
	inc h ; $4ccc
Label_0a_4ccd:
	ld de, $d181 ; $4ccd
	farcall FarPtr_RenderProportionalTextAt ; $4cd0
	ld a, [$df05] ; $4cd3
	farcall FarPtr_RedrawWindowRows ; $4cd6
	ld a, [$df01] ; $4cd9
	or a, a ; $4cdc
	jp nz, Label_0a_4ce5 ; $4cdd
	ld hl, $10db ; $4ce0
	jr Label_0a_4ce8 ; $4ce3
Label_0a_4ce5:
	ld hl, $10df ; $4ce5
Label_0a_4ce8:
	ld a, [$df02] ; $4ce8
	or a, a ; $4ceb
	jr z, Label_0a_4cf7 ; $4cec
	ld a, [$df03] ; $4cee
	inc a ; $4cf1
	add a, l ; $4cf2
	ld l, a ; $4cf3
	jr nc, Label_0a_4cf7 ; $4cf4
	inc h ; $4cf6
Label_0a_4cf7:
	ld d, $07 ; $4cf7
	ld e, $00 ; $4cf9
	farcall FarPtr_CreateMenuWindowFromText ; $4cfb
	farcall FarPtr_RestoreShadowTilemap ; $4cfe
	farcall FarPtr_RenderMenuWindowText ; $4d01
	farcall FarPtr_RunMenuSelection ; $4d04
	ld [$df04], a ; $4d07
	ld a, [$d82f] ; $4d0a
	farcall FarPtr_CloseWindow ; $4d0d
	ld a, [$df04] ; $4d10
	cp a, $ff ; $4d13
	jp z, Label_0a_4c83 ; $4d15
	call ApplyClearStatusFlags ; $4d18
	call GetClearStatusResultCode ; $4d1b
Label_0a_4d1e:
	ld hl, $df06 ; $4d1e
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
	ld hl, $d000 ; $4d37
	ld bc, $0500 ; $4d3a
	call FillMemoryFast ; $4d3d
	wram_bank $03 ; $4d40
	ld a, $20 ; $4d46
	ld hl, $d000 ; $4d48
	ld bc, $0500 ; $4d4b
	call FillMemoryFast ; $4d4e
	wram_bank $03 ; $4d51
	ld hl, $d000 ; $4d57
	ld de, $9800 ; $4d5a
	ld c, $24 ; $4d5d
	call QueueVRAMCopy ; $4d5f
	wram_bank $02 ; $4d62
	ld hl, $d000 ; $4d68
	ld de, $b800 ; $4d6b
	ld c, $24 ; $4d6e
	call QueueVRAMCopy ; $4d70
	call EnableLCD ; $4d73
	ret ; $4d76
FillMemoryFast:
	ld e, a ; $4d77
Label_0a_4d78:
	ld [hl], e ; $4d78
	inc hl ; $4d79
	dec bc ; $4d7a
	ld a, c ; $4d7b
	or a, b ; $4d7c
	jr nz, Label_0a_4d78 ; $4d7d
	ret ; $4d7f
ApplyClearStatusFlags:
	ld a, [$df00] ; $4d80
	or a, a ; $4d83
	ret nz ; $4d84
	clear_flag $05, 7 ; $4d85
	ld a, [$df01] ; $4d88
	or a, a ; $4d8b
	jr z, Label_0a_4d91 ; $4d8c
	set_flag $05, 7 ; $4d8e
Label_0a_4d91:
	call SetRankingMatchClearFlags ; $4d91
	ld a, [$df01] ; $4d94
	or a, a ; $4d97
	jr nz, Label_0a_4d9f ; $4d98
Label_0a_4d9a:
	call SetMinigameClearFlags ; $4d9a
	jr Label_0a_4da8 ; $4d9d
Label_0a_4d9f:
	ld a, [$df02] ; $4d9f
	or a, a ; $4da2
	jr z, Label_0a_4d9a ; $4da3
	call SetMinigameClearFlagsAlt ; $4da5
Label_0a_4da8:
	ret ; $4da8
SetRankingMatchClearFlags:
	ld c, $1c ; $4da9
	ld de, $1800 ; $4dab
Label_0a_4dae:
	push de ; $4dae
	call ClearGameFlag ; $4daf
	pop de ; $4db2
	ld hl, $0020 ; $4db3
	add hl, de ; $4db6
	ld d, h ; $4db7
	ld e, l ; $4db8
	dec c ; $4db9
	jr nz, Label_0a_4dae ; $4dba
	ld a, [$df03] ; $4dbc
	or a, a ; $4dbf
	ret z ; $4dc0
	ld hl, $4df2 ; $4dc1
Label_0a_4dc4:
	ld a, [hl+] ; $4dc4
	ld d, [hl] ; $4dc5
	ld e, a ; $4dc6
	inc hl ; $4dc7
	ld a, d ; $4dc8
	and a, d ; $4dc9
	cp a, $ff ; $4dca
	jr z, Label_0a_4dd3 ; $4dcc
	call SetGameFlag ; $4dce
	jr Label_0a_4dc4 ; $4dd1
Label_0a_4dd3:
	ld a, [$df03] ; $4dd3
	cp a, $01 ; $4dd6
	ret z ; $4dd8
	ld hl, $4e00 ; $4dd9
Label_0a_4ddc:
	ld a, [hl+] ; $4ddc
	ld d, [hl] ; $4ddd
	ld e, a ; $4dde
	inc hl ; $4ddf
	ld a, d ; $4de0
	and a, d ; $4de1
	cp a, $ff ; $4de2
	jr z, Label_0a_4deb ; $4de4
	call SetGameFlag ; $4de6
	jr Label_0a_4ddc ; $4de9
Label_0a_4deb:
	ret ; $4deb
	INCBIN "data/bank_00a/d_4dec.bin" ; $4dec, 34 bytes
SetMinigameClearFlags:
	ld c, $09 ; $4e0e
	ld de, $0a00 ; $4e10
Label_0a_4e13:
	push de ; $4e13
	call ClearGameFlag ; $4e14
	pop de ; $4e17
	ld hl, $0020 ; $4e18
	add hl, de ; $4e1b
	ld d, h ; $4e1c
	ld e, l ; $4e1d
	dec c ; $4e1e
	jr nz, Label_0a_4e13 ; $4e1f
	ld a, [$df02] ; $4e21
	or a, a ; $4e24
	jr z, Label_0a_4e2a ; $4e25
	ld a, [$df04] ; $4e27
Label_0a_4e2a:
	ld b, a ; $4e2a
	ld a, [$df03] ; $4e2b
	ld c, a ; $4e2e
	add a, a ; $4e2f
	add a, a ; $4e30
	add a, c ; $4e31
	ld c, a ; $4e32
	ld a, b ; $4e33
	add a, c ; $4e34
	ld c, a ; $4e35
	inc c ; $4e36
	ld hl, $4e4b ; $4e37
Label_0a_4e3a:
	ld a, [hl+] ; $4e3a
	ld d, [hl] ; $4e3b
	ld e, a ; $4e3c
	inc hl ; $4e3d
	dec c ; $4e3e
	jr z, Label_0a_4e4a ; $4e3f
	ld a, d ; $4e41
	or a, e ; $4e42
	jr z, Label_0a_4e3a ; $4e43
	call SetGameFlag ; $4e45
	jr Label_0a_4e3a ; $4e48
Label_0a_4e4a:
	ret ; $4e4a
	INCBIN "data/bank_00a/d_4e4b.bin" ; $4e4b, 42 bytes
SetMinigameClearFlagsAlt:
	ld c, $09 ; $4e75
	ld de, $0a00 ; $4e77
Label_0a_4e7a:
	push de ; $4e7a
	call ClearGameFlag ; $4e7b
	pop de ; $4e7e
	ld hl, $0020 ; $4e7f
	add hl, de ; $4e82
	ld d, h ; $4e83
	ld e, l ; $4e84
	dec c ; $4e85
	jr nz, Label_0a_4e7a ; $4e86
	ld a, [$df03] ; $4e88
	add a, a ; $4e8b
	add a, a ; $4e8c
	ld c, a ; $4e8d
	ld a, [$df04] ; $4e8e
	add a, c ; $4e91
	ld c, a ; $4e92
	inc c ; $4e93
	ld hl, $4ea8 ; $4e94
Label_0a_4e97:
	ld a, [hl+] ; $4e97
	ld d, [hl] ; $4e98
	ld e, a ; $4e99
	inc hl ; $4e9a
	dec c ; $4e9b
	jr z, Label_0a_4ea7 ; $4e9c
	ld a, d ; $4e9e
	or a, e ; $4e9f
	jr z, Label_0a_4e97 ; $4ea0
	call SetGameFlag ; $4ea2
	jr Label_0a_4e97 ; $4ea5
Label_0a_4ea7:
	ret ; $4ea7
	INCBIN "data/bank_00a/d_4ea8.bin" ; $4ea8, 34 bytes
GetClearStatusResultCode:
	ld hl, $4eee ; $4eca
	ld a, [$df02] ; $4ecd
	ld b, a ; $4ed0
	or a, a ; $4ed1
	jr z, Label_0a_4ee0 ; $4ed2
	ld a, [$df03] ; $4ed4
	inc a ; $4ed7
	inc a ; $4ed8
	add a, a ; $4ed9
	ld b, a ; $4eda
	ld a, [$df01] ; $4edb
	jr Label_0a_4ee3 ; $4ede
Label_0a_4ee0:
	ld a, [$df04] ; $4ee0
Label_0a_4ee3:
	add a, b ; $4ee3
	add a, l ; $4ee4
	ld l, a ; $4ee5
	jr nc, Label_0a_4ee9 ; $4ee6
	inc h ; $4ee8
Label_0a_4ee9:
	ld a, [hl] ; $4ee9
	ld [$df06], a ; $4eea
	ret ; $4eed
	INCBIN "data/bank_00a/d_4eee.bin" ; $4eee, 10 bytes
ClearStatusSetupMenuEntry:
	call RunClearStatusSetupMenu ; $4ef8
	ret ; $4efb
	test_flag $04, 0 ; $4efc
	jr z, Label_0a_4f2b ; $4eff
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
Label_0a_4f2b:
	ret ; $4f2b
RunStoryModeOverworld:
	xor a, a ; $4f2c
	ld [$cb5f], a ; $4f2d
Label_0a_4f30:
	call ClearFrameTasks ; $4f30
	ld a, $01 ; $4f33
	ld hl, $4efc ; $4f35
	call RegisterFrameTask ; $4f38
	call RunStoryLocation ; $4f3b
	jr Label_0a_4f30 ; $4f3e
RunStoryLocation:
	push af ; $4f40
	push bc ; $4f41
	push de ; $4f42
	push hl ; $4f43
	ld c, $0c ; $4f44
	call BeginFadeOut ; $4f46
	call Func_0a_50e4 ; $4f49
	call ClearStoryEventRequests ; $4f4c
	call LoadStoryLocationHeader ; $4f4f
	call LoadStoryEntryPointRecord ; $4f52
	ld a, $00 ; $4f55
	ld [wGameMode], a ; $4f57
	call AdvanceFrame ; $4f5a
	test_flag $0d, 6 ; $4f5d
	jr nz, Label_0a_4f6f ; $4f60
	ld a, [$c284] ; $4f62
	cp a, $ff ; $4f65
	jr z, Label_0a_4f6f ; $4f67
	ld a, [$c284] ; $4f69
	call PlaySoundManaged ; $4f6c
Label_0a_4f6f:
	farcall FarPtr_ResetTextWindowState ; $4f6f
	ld hl, $c28a ; $4f72
	ld a, [hl+] ; $4f75
	ld h, [hl] ; $4f76
	ld l, a ; $4f77
	ld a, [$c29b] ; $4f78
	call InitLocationActors ; $4f7b
	ld hl, $d000 ; $4f7e
	ld de, $0018 ; $4f81
	add hl, de ; $4f84
	ld [hl], $01 ; $4f85
	set_flag $02, 4 ; $4f87
	call WaitFadeEnd ; $4f8a
	clear_flag $02, 4 ; $4f8d
	farcall FarPtr_LoadStoryObjPalettes ; $4f90
	call DisableLCDSafely ; $4f93
	farcall FarPtr_ResetTextWindowState ; $4f96
	farcall FarPtr_InitSceneScroll ; $4f99
	ld a, [$c281] ; $4f9c
	farcall FarPtr_LoadStorySceneGraphics ; $4f9f
	ld a, $00 ; $4fa2
	farcall FarPtr_CopyScrolledSceneTilemapToVram ; $4fa4
	test_flag $0d, 6 ; $4fa7
	jr nz, Label_0a_4faf ; $4faa
	farcall FarPtr_01_0a ; $4fac
Label_0a_4faf:
	call EnableLCD ; $4faf
	ld a, [$c29c] ; $4fb2
	ld l, a ; $4fb5
	ld a, [$c29d] ; $4fb6
	ld h, a ; $4fb9
	ld a, h ; $4fba
	or a, l ; $4fbb
	jr z, Label_0a_4fc4 ; $4fbc
	ld a, [$c29b] ; $4fbe
	call CallHLInBankA ; $4fc1
Label_0a_4fc4:
	call RunLocationInitScript ; $4fc4
	ld hl, wStoryModeExitLocationRequest ; $4fc7
	ld a, [hl] ; $4fca
	and a, a ; $4fcb
	jr z, Label_0a_4fd6 ; $4fcc
	ld [hl], $00 ; $4fce
	call RunLocationExit ; $4fd0
	jp Label_0a_50df ; $4fd3
Label_0a_4fd6:
	ld c, $08 ; $4fd6
	call BeginFadeIn ; $4fd8
	call WaitFadeEnd ; $4fdb
	ld a, [wStoryModeShowLocationName] ; $4fde
	and a, a ; $4fe1
	jr z, Label_0a_4ff1 ; $4fe2
	ld a, [wStoryModeLocationNameTextId] ; $4fe4
	ld l, a ; $4fe7
	ld a, [$c2d7] ; $4fe8
	ld h, a ; $4feb
	call ShowLocationNamePopup ; $4fec
	jr Label_0a_4ff5 ; $4fef
Label_0a_4ff1:
	call WaitFramesCmd ; $4ff1
	db $04 ; $4ff4 inline arg
Label_0a_4ff5:
	wram_bank $04 ; $4ff5
	call CheckStoryEventRequests ; $4ffb
	and a, a ; $4ffe
	jp z, Label_0a_50ca ; $4fff
	ld bc, $d000 ; $5002
	ld hl, $4766 ; $5005
	ldh a, [hRomBank] ; $5008
	farcall FarPtr_SetActorScript ; $500a
	ld hl, $d000 ; $500d
	ld de, $0018 ; $5010
	add hl, de ; $5013
	ld [hl], $01 ; $5014
	ld hl, wStoryModeTriggerScript ; $5016
	ld a, [hl] ; $5019
	and a, a ; $501a
	jr z, Label_0a_5022 ; $501b
	ld [hl], $00 ; $501d
	call RunQueuedTriggerScript ; $501f
Label_0a_5022:
	ld hl, wStoryModeExitLocationRequest ; $5022
	ld a, [hl] ; $5025
	and a, a ; $5026
	jr z, Label_0a_5031 ; $5027
	ld [hl], $00 ; $5029
	call RunLocationExit ; $502b
	jp Label_0a_50df ; $502e
Label_0a_5031:
	ld hl, wStoryModeMenuRequest ; $5031
	ld a, [hl] ; $5034
	and a, a ; $5035
	jr z, Label_0a_5048 ; $5036
	ld [hl], $00 ; $5038
	call WaitPlayerMoveDone ; $503a
	test_flag $05, 6 ; $503d
	jr nz, Label_0a_5048 ; $5040
	farcall FarPtr_RunStoryModeMenu ; $5042
	jp Label_0a_4ff5 ; $5045
Label_0a_5048:
	xor a, a ; $5048
	ld [$c2a3], a ; $5049
	ld hl, $c2a2 ; $504c
	ld a, [hl] ; $504f
	and a, a ; $5050
	jr z, Label_0a_507e ; $5051
	ld [hl], $00 ; $5053
	wram_bank $04 ; $5055
	ld a, [$daec] ; $505b
	and a, a ; $505e
	jr z, Label_0a_507e ; $505f
	ld hl, $daed ; $5061
	ld a, [$daec] ; $5064
	cp a, [hl] ; $5067
	jr nz, Label_0a_507e ; $5068
	ld hl, $daee ; $506a
	ld a, [hl] ; $506d
	cp a, $1e ; $506e
	jr c, Label_0a_507e ; $5070
	ld [hl], $00 ; $5072
	ld hl, $c2a3 ; $5074
	ld [hl], $ff ; $5077
	ld hl, wStoryModeInteractRequest ; $5079
	ld [hl], $01 ; $507c
Label_0a_507e:
	xor a, a ; $507e
	ld [$c2da], a ; $507f
	ld hl, wStoryModeInteractRequest ; $5082
	ld a, [hl] ; $5085
	and a, a ; $5086
	jr z, Label_0a_50c7 ; $5087
	ld [hl], $00 ; $5089
	call FindActorFacingPlayer ; $508b
	and a, a ; $508e
	jr z, Label_0a_509a ; $508f
	call RunNpcInteraction ; $5091
	ld a, [$c2da] ; $5094
	and a, a ; $5097
	jr nz, Label_0a_50c7 ; $5098
Label_0a_509a:
	call GetFacingTileInteractionId ; $509a
	and a, a ; $509d
	jr z, Label_0a_50a9 ; $509e
	call RunFacingTileScript ; $50a0
	ld a, [$c2da] ; $50a3
	and a, a ; $50a6
	jr nz, Label_0a_50c7 ; $50a7
Label_0a_50a9:
	call GetTileTriggerAtPlayer ; $50a9
	and a, a ; $50ac
	jr z, Label_0a_50b4 ; $50ad
	call RunTileTriggerScript ; $50af
	jr Label_0a_50c7 ; $50b2
Label_0a_50b4:
	ld a, [$c2a3] ; $50b4
	and a, a ; $50b7
	jr nz, Label_0a_50c7 ; $50b8
	ldh a, [hDebugStepMode] ; $50ba
	and a, a ; $50bc
	jr z, Label_0a_50c7 ; $50bd
	call WaitPlayerMoveDone ; $50bf
	farcall FarPtr_RunDebugMenu ; $50c2
	jr Label_0a_50c7 ; $50c5
Label_0a_50c7:
	jp Label_0a_4ff5 ; $50c7
Label_0a_50ca:
	call WaitFadeEnd ; $50ca
	ld bc, $d000 ; $50cd
	farcall FarPtr_04_1c ; $50d0
Label_0a_50d3:
	call AdvanceFrame ; $50d3
	call CheckStoryEventRequests ; $50d6
	and a, a ; $50d9
	jr z, Label_0a_50d3 ; $50da
	jp Label_0a_4ff5 ; $50dc
Label_0a_50df:
	pop hl ; $50df
	pop de ; $50e0
	pop bc ; $50e1
	pop af ; $50e2
	ret ; $50e3
Func_0a_50e4:
	push af ; $50e4
	push hl ; $50e5
	ld hl, $c9dc ; $50e6
	xor a, a ; $50e9
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
	xor a, a ; $50fa
Label_0a_50fb:
	ld [hl+], a ; $50fb
	dec b ; $50fc
	jr nz, Label_0a_50fb ; $50fd
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
	xor a, a ; $510b
Label_0a_510c:
	or a, [hl] ; $510c
	inc hl ; $510d
	dec b ; $510e
	jr nz, Label_0a_510c ; $510f
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
	jr Label_0a_5120 ; $511e
Label_0a_5120:
	ld de, wStoryModeCurrentLocation ; $5120
	ld bc, $0006 ; $5123
	call CopyMemoryBC ; $5126
	ld hl, $c282 ; $5129
	ld a, [hl+] ; $512c
	ld h, [hl] ; $512d
	ld l, a ; $512e
	ld a, h ; $512f
	ld [$c29b], a ; $5130
	ld hl, $c282 ; $5133
	ld a, [hl+] ; $5136
	ld h, [hl] ; $5137
	ld l, a ; $5138
	ld de, $c286 ; $5139
	ld bc, $000e ; $513c
	call CopyDataFromBank ; $513f
	ld a, [wStoryModeCurrentLocation] ; $5142
	add a, $79 ; $5145
	ld l, a ; $5147
	adc a, $01 ; $5148
	sub a, l ; $514a
	ld h, a ; $514b
	ld a, l ; $514c
	ld [wStoryModeLocationNameTextId], a ; $514d
	ld a, h ; $5150
	ld [$c2d7], a ; $5151
	ld a, [wStoryModeEntryPoint] ; $5154
	sub a, $ff ; $5157
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
	cp a, $ff ; $5176
	jr z, Label_0a_51ca ; $5178
	ld hl, wStoryModeEntryPoint ; $517a
	ld d, [hl] ; $517d
	ld hl, $c286 ; $517e
	ld a, [hl+] ; $5181
	ld h, [hl] ; $5182
	ld l, a ; $5183
Label_0a_5184:
	ld a, [$c29b] ; $5184
	call FarReadByte ; $5187
	cp a, $ff ; $518a
	jr z, Label_0a_519a ; $518c
	cp a, d ; $518e
	jr z, Label_0a_51a0 ; $518f
	ld a, $08 ; $5191
	add a, l ; $5193
	ld l, a ; $5194
	jr nc, Label_0a_5198 ; $5195
	inc h ; $5197
Label_0a_5198:
	jr Label_0a_5184 ; $5198
Label_0a_519a:
	ld hl, $c286 ; $519a
	ld a, [hl+] ; $519d
	ld h, [hl] ; $519e
	ld l, a ; $519f
Label_0a_51a0:
	ld a, [$c29b] ; $51a0
	ld de, $c2c0 ; $51a3
	ld bc, $0008 ; $51a6
	call FarCopyBytes ; $51a9
	ld a, [$c2c1] ; $51ac
	ld [$c29a], a ; $51af
	ld hl, $c2c2 ; $51b2
	ld de, wStoryModeSpawnPosition ; $51b5
	ld bc, $0004 ; $51b8
	call CopyMemoryBC ; $51bb
	ld a, [$c2c6] ; $51be
	ld [$c29c], a ; $51c1
	ld a, [$c2c7] ; $51c4
	ld [$c29d], a ; $51c7
Label_0a_51ca:
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
	add a, [hl] ; $51df
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
	ld hl, $d000 ; $5203
	ld de, $01c0 ; $5206
	ld a, $00 ; $5209
	call GetPointAheadOfActor ; $520b
	ld e, d ; $520e
	ld d, h ; $520f
	farcall FarPtr_ReadBehaviorMapCell ; $5210
	ld d, a ; $5213
	ld e, $00 ; $5214
	and a, $0f ; $5216
	cp a, $08 ; $5218
	jr nz, Label_0a_5222 ; $521a
	ld a, d ; $521c
	swap a ; $521d
	and a, $0f ; $521f
	ld e, a ; $5221
Label_0a_5222:
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
	farcall FarPtr_04_26 ; $5230
	ld hl, $d000 ; $5233
	ld de, $01c0 ; $5236
	ld a, $00 ; $5239
	call GetPointAheadOfActor ; $523b
	push de ; $523e
	ld e, d ; $523f
	ld d, h ; $5240
	farcall FarPtr_ReadBehaviorMapCell ; $5241
	and a, $0f ; $5244
	pop de ; $5246
	cp a, $0c ; $5247
	jr nz, Label_0a_5256 ; $5249
	ld hl, $d000 ; $524b
	ld de, $03c0 ; $524e
	ld a, $00 ; $5251
	call GetPointAheadOfActor ; $5253
Label_0a_5256:
	farcall FarPtr_04_24 ; $5256
	and a, a ; $5259
	jr nz, Label_0a_527b ; $525a
	ld hl, $d000 ; $525c
	ld de, $0180 ; $525f
	ld a, $f0 ; $5262
	call GetPointAheadOfActor ; $5264
	farcall FarPtr_04_24 ; $5267
	and a, a ; $526a
	jr nz, Label_0a_527b ; $526b
	ld hl, $d000 ; $526d
	ld de, $0180 ; $5270
	ld a, $10 ; $5273
	call GetPointAheadOfActor ; $5275
	farcall FarPtr_04_24 ; $5278
Label_0a_527b:
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
	cp a, $ff ; $5284
	jr z, Label_0a_5292 ; $5286
	ld hl, $c8a9 ; $5288
	ld [hl], b ; $528b
	ld hl, $c8aa ; $528c
	ld [hl], c ; $528f
	jr Label_0a_52a9 ; $5290
Label_0a_5292:
	ld a, [wStoryModeCurrentLocation] ; $5292
	ld [$c8a9], a ; $5295
	ld hl, $c8aa ; $5298
	ld [hl], $ff ; $529b
	ld hl, wStoryModePlayersXPosition ; $529d
	ld de, $c8ab ; $52a0
	ld bc, $0005 ; $52a3
	call CopyMemoryBC ; $52a6
Label_0a_52a9:
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
	ld a, [$c8aa] ; $52b2
	cp a, $ff ; $52b5
	jr z, Label_0a_52cf ; $52b7
	ld a, [$c8a9] ; $52b9
	ld [wStoryModeCurrentLocation], a ; $52bc
	ld a, [$c8aa] ; $52bf
	ld [wStoryModeEntryPoint], a ; $52c2
	ld a, $ff ; $52c5
	ld [$c294], a ; $52c7
	ld [wStoryModeExitLocationRequest], a ; $52ca
	jr Label_0a_52f0 ; $52cd
Label_0a_52cf:
	ld hl, $c8ab ; $52cf
	ld de, wStoryModeSpawnPosition ; $52d2
	ld bc, $0005 ; $52d5
	call CopyMemoryBC ; $52d8
	ld a, [$c8a9] ; $52db
	ld [wStoryModeCurrentLocation], a ; $52de
	ld a, $ff ; $52e1
	ld [wStoryModeEntryPoint], a ; $52e3
	ld a, $ff ; $52e6
	ld [$c294], a ; $52e8
	ld a, $ff ; $52eb
	ld [wStoryModeExitLocationRequest], a ; $52ed
Label_0a_52f0:
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
	farcall FarPtr_ShowSpeakerDialogueRestoreBG ; $530f
	ld b, $50 ; $5312
Label_0a_5314:
	call AdvanceFrame ; $5314
	ldh a, [hPlayerInputFlags] ; $5317
	and a, a ; $5319
	jr nz, Label_0a_531f ; $531a
	dec b ; $531c
	jr nz, Label_0a_5314 ; $531d
Label_0a_531f:
	farcall FarPtr_CloseActiveDialogueWindow ; $531f
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
	ld hl, $5341 ; $5337
	ld de, $0b05 ; $533a
	call LoadPaletteShadow ; $533d
	ret ; $5340
	INCBIN "data/bank_00a/d_5341.bin" ; $5341, 40 bytes
GetTileTriggerAtPlayer:
	push bc ; $5369
	push de ; $536a
	push hl ; $536b
	ld bc, $d000 ; $536c
	ld hl, $000d ; $536f
	add hl, bc ; $5372
	ld d, [hl] ; $5373
	ld hl, $000f ; $5374
	add hl, bc ; $5377
	ld e, [hl] ; $5378
	farcall FarPtr_ReadBehaviorMapCell ; $5379
	ld e, a ; $537c
	ld d, $00 ; $537d
	and a, $0f ; $537f
	cp a, $01 ; $5381
	jr nz, Label_0a_539d ; $5383
	ld a, e ; $5385
	swap a ; $5386
	and a, $0f ; $5388
	ld d, a ; $538a
	ld hl, $c290 ; $538b
	ld a, [hl+] ; $538e
	ld h, [hl] ; $538f
	ld l, a ; $5390
	ld a, [$c29b] ; $5391
	call FindStoryScriptEntry ; $5394
	ld a, h ; $5397
	or a, l ; $5398
	jr nz, Label_0a_539d ; $5399
	ld d, $00 ; $539b
Label_0a_539d:
	ld a, d ; $539d
	pop hl ; $539e
	pop de ; $539f
	pop bc ; $53a0
	ret ; $53a1
	INCBIN "data/bank_00a/d_53a2.bin" ; $53a2, 27 bytes
CheckTriggerFacingMask:
	push bc ; $53bd
	push hl ; $53be
	wram_bank $04 ; $53bf
	ld c, $01 ; $53c5
	ld a, b ; $53c7
	cp a, $ff ; $53c8
	jr z, Label_0a_53e0 ; $53ca
	ld a, [$daea] ; $53cc
	rlca ; $53cf
	rlca ; $53d0
	and a, $03 ; $53d1
	add a, $b9 ; $53d3
	ld l, a ; $53d5
	adc a, $53 ; $53d6
	sub a, l ; $53d8
	ld h, a ; $53d9
	ld a, [hl] ; $53da
	and a, b ; $53db
	jr nz, Label_0a_53e0 ; $53dc
	ld c, $00 ; $53de
Label_0a_53e0:
	ld a, c ; $53e0
	pop hl ; $53e1
	pop bc ; $53e2
	ret ; $53e3
FindStoryScriptEntry:
	push af ; $53e4
	push bc ; $53e5
	push de ; $53e6
Label_0a_53e7:
	ld a, [$c29b] ; $53e7
	call FarReadWord ; $53ea
	ld a, c ; $53ed
	cp a, $ff ; $53ee
	jr z, Label_0a_5416 ; $53f0
	cp a, d ; $53f2
	jr nz, Label_0a_5410 ; $53f3
	call CheckTriggerFacingMask ; $53f5
	and a, a ; $53f8
	jr z, Label_0a_5410 ; $53f9
	inc hl ; $53fb
	inc hl ; $53fc
	ld a, [$c29b] ; $53fd
	call FarReadWord ; $5400
	dec hl ; $5403
	dec hl ; $5404
	push de ; $5405
	ld e, c ; $5406
	ld d, b ; $5407
	farcall FarPtr_EvalFlagCondition ; $5408
	pop de ; $540b
	jr nz, Label_0a_5410 ; $540c
	jr Label_0a_5419 ; $540e
Label_0a_5410:
	ld bc, $0008 ; $5410
	add hl, bc ; $5413
	jr Label_0a_53e7 ; $5414
Label_0a_5416:
	ld hl, $0000 ; $5416
Label_0a_5419:
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
	ld [$c2da], a ; $5427
	ld a, h ; $542a
	or a, l ; $542b
	jr z, Label_0a_545c ; $542c
	ld a, h ; $542e
	and a, $c0 ; $542f
	jr nz, Label_0a_543c ; $5431
	call WaitPlayerMoveDone ; $5433
	ld a, b ; $5436
	farcall FarPtr_ShowSpeakerDialogue ; $5437
	jr Label_0a_545c ; $543a
Label_0a_543c:
	farcall FarPtr_BeginCutsceneScriptMode ; $543c
	push hl ; $543f
	wram_bank $04 ; $5440
	ld hl, $d030 ; $5446
	res 0, [hl] ; $5449
	ld hl, $d014 ; $544b
	ld a, [$daea] ; $544e
	ld [hl], a ; $5451
	pop hl ; $5452
	ld a, [$c29b] ; $5453
	call CallHLInBankA ; $5456
	farcall FarPtr_EndCutsceneScriptMode ; $5459
Label_0a_545c:
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
	farcall FarPtr_InitActorEngine ; $5472
	ld hl, $c29a ; $5475
	ld c, [hl] ; $5478
	ld hl, $c298 ; $5479
	ld a, [hl+] ; $547c
	ld d, [hl] ; $547d
	ld e, a ; $547e
	ld hl, wStoryModeSpawnPosition ; $547f
	ld a, [hl+] ; $5482
	ld h, [hl] ; $5483
	ld l, a ; $5484
	farcall FarPtr_SpawnMainCharacterActor ; $5485
	pop hl ; $5488
	pop af ; $5489
	farcall FarPtr_04_1a ; $548a
	farcall FarPtr_SpawnActorsFromList ; $548d
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
	ld hl, $c292 ; $54a0
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
	ld [$c2db], a ; $54b5
	cp a, $02 ; $54b8
	jp z, Label_0a_5573 ; $54ba
	push af ; $54bd
	push bc ; $54be
	push de ; $54bf
	push hl ; $54c0
	ld d, a ; $54c1
	ld hl, $c28c ; $54c2
	ld a, [hl+] ; $54c5
	ld h, [hl] ; $54c6
	ld l, a ; $54c7
	call FindStoryScriptEntry ; $54c8
	ld a, h ; $54cb
	or a, l ; $54cc
	jp z, Label_0a_556e ; $54cd
	ld a, [$c29b] ; $54d0
	ld de, $c2c0 ; $54d3
	ld bc, $0008 ; $54d6
	call FarCopyBytes ; $54d9
	ld hl, $c2c6 ; $54dc
	ld b, [hl] ; $54df
	wram_bank $04 ; $54e0
	ld hl, $c2c0 ; $54e6
	ld a, [hl] ; $54e9
	call GetActorStateAddr ; $54ea
	ld e, l ; $54ed
	ld d, h ; $54ee
	ld hl, $0019 ; $54ef
	add hl, de ; $54f2
	ld a, [hl] ; $54f3
	ld [$c2d8], a ; $54f4
	ld a, $01 ; $54f7
	ld [hl], a ; $54f9
	ld a, b ; $54fa
	and a, $08 ; $54fb
	jr z, Label_0a_5514 ; $54fd
	ld hl, $002e ; $54ff
	add hl, de ; $5502
	ld a, [hl] ; $5503
	ld [$c2d9], a ; $5504
	ld a, $01 ; $5507
	push bc ; $5509
	push de ; $550a
	ld c, e ; $550b
	ld b, d ; $550c
	ld d, $01 ; $550d
	farcall FarPtr_SetActorAnimationChecked ; $550f
	pop de ; $5512
	pop bc ; $5513
Label_0a_5514:
	ld a, b ; $5514
	and a, $10 ; $5515
	jr z, Label_0a_5521 ; $5517
	ld hl, $0005 ; $5519
	add hl, de ; $551c
	set 0, [hl] ; $551d
	set 1, [hl] ; $551f
Label_0a_5521:
	bit 0, b ; $5521
	jr z, Label_0a_5530 ; $5523
	ld hl, $0014 ; $5525
	add hl, de ; $5528
	ld c, [hl] ; $5529
	ld a, [$daea] ; $552a
	add a, $80 ; $552d
	ld [hl], a ; $552f
Label_0a_5530:
	push de ; $5530
	ld hl, $c2c4 ; $5531
	ld a, [hl+] ; $5534
	ld h, [hl] ; $5535
	ld l, a ; $5536
	ld a, [$c2c0] ; $5537
	call RunStoryScriptOrDialogue ; $553a
	pop de ; $553d
	bit 1, b ; $553e
	jr z, Label_0a_5547 ; $5540
	ld hl, $0014 ; $5542
	add hl, de ; $5545
	ld [hl], c ; $5546
Label_0a_5547:
	ld a, b ; $5547
	and a, $10 ; $5548
	jr z, Label_0a_5554 ; $554a
	ld hl, $0005 ; $554c
	add hl, de ; $554f
	res 0, [hl] ; $5550
	res 1, [hl] ; $5552
Label_0a_5554:
	ld a, b ; $5554
	and a, $08 ; $5555
	jr z, Label_0a_5566 ; $5557
	push bc ; $5559
	push de ; $555a
	ld c, e ; $555b
	ld b, d ; $555c
	ld a, [$c2d9] ; $555d
	ld d, a ; $5560
	farcall FarPtr_SetActorAnimationChecked ; $5561
	pop de ; $5564
	pop bc ; $5565
Label_0a_5566:
	ld hl, $0019 ; $5566
	add hl, de ; $5569
	ld a, [$c2d8] ; $556a
	ld [hl], a ; $556d
Label_0a_556e:
	pop hl ; $556e
	pop de ; $556f
	pop bc ; $5570
	pop af ; $5571
	ret ; $5572
Label_0a_5573:
	ret ; $5573
RunFacingTileScript:
	push af ; $5574
	push bc ; $5575
	push de ; $5576
	push hl ; $5577
	ld [$c2db], a ; $5578
	ld d, a ; $557b
	ld hl, $c28e ; $557c
	ld a, [hl+] ; $557f
	ld h, [hl] ; $5580
	ld l, a ; $5581
	call FindStoryScriptEntry ; $5582
	ld a, h ; $5585
	or a, l ; $5586
	jr z, Label_0a_55a0 ; $5587
	ld a, [$c29b] ; $5589
	ld de, $c2c0 ; $558c
	ld bc, $0008 ; $558f
	call FarCopyBytes ; $5592
	ld hl, $c2c4 ; $5595
	ld a, [hl+] ; $5598
	ld h, [hl] ; $5599
	ld l, a ; $559a
	ld a, $00 ; $559b
	call RunStoryScriptOrDialogue ; $559d
Label_0a_55a0:
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
	ld [$c2db], a ; $55a9
	ld d, a ; $55ac
	ld hl, $c290 ; $55ad
	ld a, [hl+] ; $55b0
	ld h, [hl] ; $55b1
	ld l, a ; $55b2
	call FindStoryScriptEntry ; $55b3
	ld a, h ; $55b6
	or a, l ; $55b7
	jr z, Label_0a_55d8 ; $55b8
	ld a, [$c29b] ; $55ba
	ld de, $c2c0 ; $55bd
	ld bc, $0008 ; $55c0
	call FarCopyBytes ; $55c3
	ld a, [$c2c6] ; $55c6
	cp a, $01 ; $55c9
	jr z, Label_0a_55d8 ; $55cb
	ld hl, $c2c4 ; $55cd
	ld a, [hl+] ; $55d0
	ld h, [hl] ; $55d1
	ld l, a ; $55d2
	ld a, $00 ; $55d3
	call RunStoryScriptOrDialogue ; $55d5
Label_0a_55d8:
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
	ld hl, $c290 ; $55e2
	ld a, [hl+] ; $55e5
	ld h, [hl] ; $55e6
	ld l, a ; $55e7
	call FindStoryScriptEntry ; $55e8
	ld a, h ; $55eb
	or a, l ; $55ec
	jr z, Label_0a_5606 ; $55ed
	ld a, [$c29b] ; $55ef
	ld de, $c2c0 ; $55f2
	ld bc, $0008 ; $55f5
	call FarCopyBytes ; $55f8
	ld hl, $c2c4 ; $55fb
	ld a, [hl+] ; $55fe
	ld h, [hl] ; $55ff
	ld l, a ; $5600
	ld a, $00 ; $5601
	call RunStoryScriptOrDialogue ; $5603
Label_0a_5606:
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
	ld [$c2db], a ; $560f
	ld d, a ; $5612
	ld hl, $c288 ; $5613
	ld a, [hl+] ; $5616
	ld h, [hl] ; $5617
	ld l, a ; $5618
	call FindStoryScriptEntry ; $5619
	ld a, h ; $561c
	or a, l ; $561d
	jr z, Label_0a_5643 ; $561e
	ld a, [$c29b] ; $5620
	ld de, $c2c0 ; $5623
	ld bc, $0008 ; $5626
	call FarCopyBytes ; $5629
	ld hl, $c2c4 ; $562c
	ld a, [hl+] ; $562f
	ld h, [hl] ; $5630
	ld l, a ; $5631
	ld a, $00 ; $5632
	call RunStoryScriptOrDialogue ; $5634
	ld a, [$c2c6] ; $5637
	ld [wStoryModeCurrentLocation], a ; $563a
	ld a, [$c2c7] ; $563d
	ld [wStoryModeEntryPoint], a ; $5640
Label_0a_5643:
	xor a, a ; $5643
	ld a, a ; $5644
	ldh [hSramBank], a ; $5645
	ld [$4000], a ; $5647
	pop hl ; $564a
	pop de ; $564b
	pop bc ; $564c
	pop af ; $564d
	ret ; $564e
	INCBIN "data/bank_00a/d_564f.bin" ; $564f, 252 bytes
GetStoryLocationCount:
	ld a, $2a ; $574b
	ret ; $574d
GetStoryLocationRecordPtr:
	ld h, a ; $574e
	add a, a ; $574f
	add a, h ; $5750
	add a, a ; $5751
	add a, $4f ; $5752
	ld l, a ; $5754
	adc a, $56 ; $5755
	sub a, l ; $5757
	ld h, a ; $5758
	ret ; $5759
	db $ff ; $575a
	ret ; $575b
CopySceneTilemapToVram:
	push af ; $575c
	push bc ; $575d
	push de ; $575e
	push hl ; $575f
	ld a, [$c323] ; $5760
	and a, $1f ; $5763
	ld l, a ; $5765
	ld h, $00 ; $5766
	add hl, hl ; $5768
	add hl, hl ; $5769
	add hl, hl ; $576a
	add hl, hl ; $576b
	add hl, hl ; $576c
	ld a, [$c321] ; $576d
	and a, $1f ; $5770
	add a, l ; $5772
	ld l, a ; $5773
	ld de, $9800 ; $5774
	add hl, de ; $5777
	push hl ; $5778
	ld a, [$c323] ; $5779
	ld l, a ; $577c
	ld h, $00 ; $577d
	add hl, hl ; $577f
	add hl, hl ; $5780
	add hl, hl ; $5781
	add hl, hl ; $5782
	add hl, hl ; $5783
	add hl, hl ; $5784
	ld a, [$c321] ; $5785
	add a, l ; $5788
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
	xor a, a ; $57df
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
Label_0a_5827:
	ld a, [hl+] ; $5827
	ld [de], a ; $5828
	inc de ; $5829
	ld a, l ; $582a
	and a, $3f ; $582b
	jr nz, Label_0a_5838 ; $582d
	ld a, l ; $582f
	sub a, $40 ; $5830
	ld l, a ; $5832
	jr nc, Label_0a_5836 ; $5833
	dec h ; $5835
Label_0a_5836:
	jr Label_0a_583d ; $5836
Label_0a_5838:
	ld a, e ; $5838
	and a, $1f ; $5839
	jr nz, Label_0a_5844 ; $583b
Label_0a_583d:
	ld a, e ; $583d
	sub a, $20 ; $583e
	ld e, a ; $5840
	jr nc, Label_0a_5844 ; $5841
	dec d ; $5843
Label_0a_5844:
	dec c ; $5844
	jr nz, Label_0a_5827 ; $5845
	pop hl ; $5847
	ld de, $0040 ; $5848
	add hl, de ; $584b
	ld a, h ; $584c
	and a, $0f ; $584d
	or a, $d0 ; $584f
	ld h, a ; $5851
	pop de ; $5852
	ld a, $20 ; $5853
	add a, e ; $5855
	ld e, a ; $5856
	jr nc, Label_0a_585a ; $5857
	inc d ; $5859
Label_0a_585a:
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
	ld de, $d000 ; $589b
	call DecompressDataFromBank ; $589e
	ld hl, $d000 ; $58a1
	ld de, $b000 ; $58a4
	ld c, $80 ; $58a7
	call QueueVRAMCopy ; $58a9
	ld hl, $d800 ; $58ac
	ld de, $a800 ; $58af
	ld c, $80 ; $58b2
	call QueueVRAMCopy ; $58b4
	wram_bank $06 ; $58b7
	pop hl ; $58bd
	ld de, $d800 ; $58be
	pop hl ; $58c1
	ld de, $d400 ; $58c2
	call DecompressDataFromBank ; $58c5
	pop hl ; $58c8
	ld de, $d000 ; $58c9
	call DecompressDataFromBank ; $58cc
	wram_bank $02 ; $58cf
	pop hl ; $58d5
	ld de, $d000 ; $58d6
	call DecompressDataFromBank ; $58d9
	wram_bank $03 ; $58dc
	pop hl ; $58e2
	ld de, $d000 ; $58e3
	call DecompressDataFromBank ; $58e6
	wram_bank $01 ; $58e9
	pop hl ; $58ef
	ld de, $d000 ; $58f0
	ld bc, $0040 ; $58f3
	call CopyDataFromBank ; $58f6
	ld hl, $d010 ; $58f9
	ld de, $0206 ; $58fc
	call LoadPaletteShadow ; $58ff
	wram_bank $06 ; $5902
	pop hl ; $5908
	ld de, $dc08 ; $5909
	ld bc, $0088 ; $590c
	call CopyDataFromBank ; $590f
	ld hl, $dc0a ; $5912
	ld a, [hl+] ; $5915
	ld [$c329], a ; $5916
	ld a, [hl+] ; $5919
	ld [$c32a], a ; $591a
	ld a, [hl+] ; $591d
	ld [$c32b], a ; $591e
	ld a, [hl+] ; $5921
	ld [$c32c], a ; $5922
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
	ld [$c32d], a ; $5936
	xor a, a ; $5939
	ldh [hScrollY], a ; $593a
	ldh [hScrollX], a ; $593c
	ldh [hBGColumnBlitPending], a ; $593e
	ldh [hBGRowBlitPending], a ; $5940
	ld [wCameraX], a ; $5942
	ld [$c321], a ; $5945
	ld [wCameraY], a ; $5948
	ld [$c323], a ; $594b
	ld [$c324], a ; $594e
	ld [$c325], a ; $5951
	ld [$c329], a ; $5954
	ld [$c32a], a ; $5957
	ld a, $40 ; $595a
	ld [$c32b], a ; $595c
	ld [$c32c], a ; $595f
	ld a, $0f ; $5962
	ld hl, $5976 ; $5964
	call RegisterFrameTask ; $5967
	pop hl ; $596a
	pop de ; $596b
	pop bc ; $596c
	pop af ; $596d
	ret ; $596e
StopSceneScrollTask:
	ld hl, $5976 ; $596f
	call UnregisterFrameTask ; $5972
	ret ; $5975
UpdateSceneScroll:
	ld a, [$c325] ; $5976
	ld h, a ; $5979
	ld a, [$c323] ; $597a
	sub a, h ; $597d
	jr z, Label_0a_5992 ; $597e
	bit 7, a ; $5980
	jr nz, Label_0a_598c ; $5982
	ld bc, $fb13 ; $5984
	call BlitBGRowFrom64 ; $5987
	jr Label_0a_5992 ; $598a
Label_0a_598c:
	ld bc, $fb00 ; $598c
	call BlitBGRowFrom64 ; $598f
Label_0a_5992:
	ld a, [$c324] ; $5992
	ld h, a ; $5995
	ld a, [$c321] ; $5996
	sub a, h ; $5999
	jr z, Label_0a_59ae ; $599a
	bit 7, a ; $599c
	jr nz, Label_0a_59a8 ; $599e
	ld bc, $15fa ; $59a0
	call BlitBGColumnFrom64 ; $59a3
	jr Label_0a_59ae ; $59a6
Label_0a_59a8:
	ld bc, $00fa ; $59a8
	call BlitBGColumnFrom64 ; $59ab
Label_0a_59ae:
	ld a, [wCameraY] ; $59ae
	ld l, a ; $59b1
	ld a, [$c323] ; $59b2
	ld h, a ; $59b5
	ld [$c325], a ; $59b6
	add hl, hl ; $59b9
	add hl, hl ; $59ba
	add hl, hl ; $59bb
	ld a, h ; $59bc
	ld hl, $c369 ; $59bd
	add a, [hl] ; $59c0
	ldh [hScrollY], a ; $59c1
	ld a, [wCameraX] ; $59c3
	ld l, a ; $59c6
	ld a, [$c321] ; $59c7
	ld h, a ; $59ca
	ld [$c324], a ; $59cb
	add hl, hl ; $59ce
	add hl, hl ; $59cf
	add hl, hl ; $59d0
	ld a, h ; $59d1
	ld hl, $c368 ; $59d2
	add a, [hl] ; $59d5
	ldh [hScrollX], a ; $59d6
	ret ; $59d8
SceneGfxSlotTable:
	; $59d9, 592 bytes (37 records x 8 slot words)
	dslot DataPtr_Data_5f_4c13, DataPtr_5f_02, DataPtr_ClubhouseSceneTilemap, DataPtr_5f_06, DataPtr_Data_5f_4c13Alias1, DataPtr_5f_0a, DataPtr_Data_5f_4c63, DataPtr_ClubhouseSceneTiles ; record 0
	dslot DataPtr_Data_5f_5904, DataPtr_Data_5f_4c63Alias1, DataPtr_CourtyardSceneTilemap, DataPtr_5f_16, DataPtr_Data_5f_5904Alias1, DataPtr_5f_1a, DataPtr_5f_1c, DataPtr_CourtyardSceneTiles ; record 1
	dslot DataPtr_GrassCourtSceneConfig, DataPtr_GrassCourtPalettes, DataPtr_GrassCourtTilemap, DataPtr_GrassCourtAttrmap, DataPtr_GrassCourtSceneConfigAlias1, DataPtr_GrassCourtSceneConfigB, DataPtr_HardCourtPalettes, DataPtr_GrassCourtTiles ; record 2
	dslot DataPtr_HardCourtSceneConfig, DataPtr_HardCourtPalettesAlias1, DataPtr_HardCourtTilemap, DataPtr_HardCourtAttrmap, DataPtr_HardCourtSceneConfigAlias1, DataPtr_HardCourtSceneConfigB, DataPtr_ClayCourtPalettes, DataPtr_HardCourtTiles ; record 3
	dslot DataPtr_ClayCourtSceneConfig, DataPtr_ClayCourtPalettesAlias1, DataPtr_ClayCourtTilemap, DataPtr_ClayCourtAttrmap, DataPtr_ClayCourtSceneConfigAlias1, DataPtr_ClayCourtSceneConfigB, DataPtr_CompositionCourtPalettes, DataPtr_ClayCourtTiles ; record 4
	dslot DataPtr_CompositionCourtSceneConfig, DataPtr_CompositionCourtPalettesAlias1, DataPtr_CompositionCourtTilemap, DataPtr_CompositionCourtAttrmap, DataPtr_CompositionCourtSceneConfigAlias1, DataPtr_CompositionCourtSceneConfigB, DataPtr_60_3c, DataPtr_CompositionCourtTiles ; record 5
	dslot DataPtr_MachineCourtSceneConfig, DataPtr_MachineCourtPalettes, DataPtr_MachineCourtTilemap, DataPtr_MachineCourtAttrmap, DataPtr_MachineCourtSceneConfigAlias1, DataPtr_MachineCourtSceneConfigB, DataPtr_CenterCourtPalettes, DataPtr_MachineCourtTiles ; record 6
	dslot DataPtr_CenterCourtSceneConfig, DataPtr_CenterCourtPalettesAlias1, DataPtr_CenterCourtTilemap, DataPtr_CenterCourtAttrmap, DataPtr_CenterCourtSceneConfigAlias1, DataPtr_CenterCourtSceneConfigB, DataPtr_PracticeCourtPalettes, DataPtr_CenterCourtTiles ; record 7
	dslot DataPtr_PracticeCourtSceneConfig, DataPtr_PracticeCourtPalettesAlias1, DataPtr_PracticeCourtTilemap, DataPtr_PracticeCourtAttrmap, DataPtr_PracticeCourtSceneConfigAlias1, DataPtr_PracticeCourtSceneConfigB, DataPtr_YoshiCourtPalettes, DataPtr_PracticeCourtTiles ; record 8
	dslot DataPtr_YoshiCourtSceneConfig, DataPtr_YoshiCourtPalettesAlias1, DataPtr_YoshiCourtTilemap, DataPtr_YoshiCourtAttrmap, DataPtr_YoshiCourtSceneConfigAlias1, DataPtr_YoshiCourtSceneConfigB, DataPtr_61_3c, DataPtr_YoshiCourtTiles ; record 9
	dslot DataPtr_StarCourtSceneConfig, DataPtr_StarCourtPalettes, DataPtr_StarCourtTilemap, DataPtr_StarCourtAttrmap, DataPtr_StarCourtSceneConfigAlias1, DataPtr_StarCourtSceneConfigB, DataPtr_BowserCourtPalettes, DataPtr_StarCourtTiles ; record 10
	dslot DataPtr_BowserCourtSceneConfig, DataPtr_BowserCourtPalettesAlias1, DataPtr_BowserCourtTilemap, DataPtr_BowserCourtAttrmap, DataPtr_BowserCourtSceneConfigAlias1, DataPtr_BowserCourtSceneConfigB, DataPtr_WarioCourtPalettes, DataPtr_BowserCourtTiles ; record 11
	dslot DataPtr_WarioCourtSceneConfig, DataPtr_WarioCourtPalettesAlias1, DataPtr_WarioCourtTilemap, DataPtr_WarioCourtAttrmap, DataPtr_WarioCourtSceneConfigAlias1, DataPtr_WarioCourtSceneConfigB, DataPtr_PeachCourtPalettes, DataPtr_WarioCourtTiles ; record 12
	dslot DataPtr_PeachCourtSceneConfig, DataPtr_PeachCourtPalettesAlias1, DataPtr_PeachCourtTilemap, DataPtr_PeachCourtAttrmap, DataPtr_PeachCourtSceneConfigAlias1, DataPtr_PeachCourtSceneConfigB, DataPtr_62_3c, DataPtr_PeachCourtTiles ; record 13
	dslot DataPtr_IslandOpenCourtSceneConfig, DataPtr_IslandOpenCourtPalettes, DataPtr_IslandOpenCourtTilemap, DataPtr_IslandOpenCourtAttrmap, DataPtr_IslandOpenCourtSceneConfigAlias1, DataPtr_IslandOpenCourtSceneConfigB, DataPtr_DKCourtPalettes, DataPtr_IslandOpenCourtTiles ; record 14
	dslot DataPtr_DKCourtSceneConfig, DataPtr_DKCourtPalettesAlias1, DataPtr_DKCourtTilemap, DataPtr_DKCourtAttrmap, DataPtr_DKCourtSceneConfigAlias1, DataPtr_DKCourtSceneConfigB, DataPtr_StarPatternBgSceneConfig, DataPtr_DKCourtTiles ; record 15
	dslot DataPtr_StarPatternBgSceneConfigAlias1, DataPtr_StarPatternBgPalettes, DataPtr_StarPatternBgTilemap, DataPtr_StarPatternBgAttrmap, DataPtr_StarPatternBgAuxTilemap, DataPtr_StarPatternBgAuxAttrmap, DataPtr_DormInteriorSceneConfig, DataPtr_StarPatternBgTiles ; record 16
	dslot DataPtr_DormInteriorSceneConfigAlias1, DataPtr_DormInteriorPalettes, DataPtr_DormInteriorTilemap, DataPtr_DormInteriorAttrmap, DataPtr_DormInteriorAuxTilemap, DataPtr_DormInteriorAuxAttrmap, DataPtr_63_3c, DataPtr_DormInteriorTiles ; record 17
	dslot DataPtr_DormBedroomSceneConfig, DataPtr_DormBedroomPalettes, DataPtr_DormBedroomTilemap, DataPtr_DormBedroomAttrmap, DataPtr_DormBedroomAuxTilemap, DataPtr_DormBedroomAuxAttrmap, DataPtr_CountrysideSceneConfig, DataPtr_DormBedroomTiles ; record 18
	dslot DataPtr_CountrysideSceneConfigAlias1, DataPtr_CountrysidePalettes, DataPtr_CountrysideTilemap, DataPtr_CountrysideAttrmap, DataPtr_CountrysideAuxTilemap, DataPtr_CountrysideAuxAttrmap, DataPtr_AcademyGroundsSceneConfig, DataPtr_CountrysideTiles ; record 19
	dslot DataPtr_AcademyGroundsSceneConfigAlias1, DataPtr_AcademyGroundsPalettes, DataPtr_AcademyGroundsTilemap, DataPtr_AcademyGroundsAttrmap, DataPtr_AcademyGroundsAuxTilemap, DataPtr_AcademyGroundsAuxAttrmap, DataPtr_64_2c, DataPtr_AcademyGroundsTiles ; record 20
	dslot DataPtr_SeasideSceneConfig, DataPtr_SeasidePalettes, DataPtr_SeasideTilemap, DataPtr_SeasideAttrmap, DataPtr_SeasideAuxTilemap, DataPtr_SeasideAuxAttrmap, DataPtr_65_0c, DataPtr_SeasideTiles ; record 21
	dslot DataPtr_HedgeCourtSceneConfig, DataPtr_HedgeCourtPalettes, DataPtr_HedgeCourtTilemap, DataPtr_HedgeCourtAttrmap, DataPtr_HedgeCourtAuxTilemap, DataPtr_HedgeCourtAuxAttrmap, DataPtr_65_1c, DataPtr_HedgeCourtTiles ; record 22
	dslot DataPtr_ClayCourtGroundsSceneConfig, DataPtr_ClayCourtGroundsPalettes, DataPtr_ClayCourtGroundsTilemap, DataPtr_ClayCourtGroundsAttrmap, DataPtr_ClayCourtGroundsAuxTilemap, DataPtr_ClayCourtGroundsAuxAttrmap, DataPtr_65_2c, DataPtr_ClayCourtGroundsTiles ; record 23
	dslot DataPtr_HardCourtGroundsSceneConfig, DataPtr_HardCourtGroundsPalettes, DataPtr_HardCourtGroundsTilemap, DataPtr_HardCourtGroundsAttrmap, DataPtr_HardCourtGroundsAuxTilemap, DataPtr_HardCourtGroundsAuxAttrmap, DataPtr_SpaResortSceneConfig, DataPtr_HardCourtGroundsTiles ; record 24
	dslot DataPtr_SpaResortSceneConfigAlias1, DataPtr_SpaResortPalettes, DataPtr_SpaResortTilemap, DataPtr_SpaResortAttrmap, DataPtr_SpaResortAuxTilemap, DataPtr_SpaResortAuxAttrmap, DataPtr_MainBuildingSceneConfig, DataPtr_SpaResortTiles ; record 25
	dslot DataPtr_MainBuildingSceneConfigAlias1, DataPtr_MainBuildingPalettes, DataPtr_MainBuildingTilemap, DataPtr_MainBuildingAttrmap, DataPtr_MainBuildingAuxTilemap, DataPtr_MainBuildingAuxAttrmap, DataPtr_GardenPavilionSceneConfig, DataPtr_MainBuildingTiles ; record 26
	dslot DataPtr_GardenPavilionSceneConfigAlias1, DataPtr_GardenPavilionPalettes, DataPtr_GardenPavilionTilemap, DataPtr_GardenPavilionAttrmap, DataPtr_GardenPavilionAuxTilemap, DataPtr_GardenPavilionAuxAttrmap, DataPtr_66_3c, DataPtr_GardenPavilionTiles ; record 27
	dslot DataPtr_FountainCourtSceneConfig, DataPtr_FountainCourtPalettes, DataPtr_FountainCourtTilemap, DataPtr_FountainCourtAttrmap, DataPtr_FountainCourtAuxTilemap, DataPtr_FountainCourtAuxAttrmap, DataPtr_67_0c, DataPtr_FountainCourtTiles ; record 28
	dslot DataPtr_CafeCourtSceneConfig, DataPtr_CafeCourtPalettes, DataPtr_CafeCourtTilemap, DataPtr_CafeCourtAttrmap, DataPtr_CafeCourtAuxTilemap, DataPtr_CafeCourtAuxAttrmap, DataPtr_CourtComplexSceneConfig, DataPtr_CafeCourtTiles ; record 29
	dslot DataPtr_CourtComplexSceneConfigAlias1, DataPtr_CourtComplexPalettes, DataPtr_CourtComplexTilemap, DataPtr_CourtComplexAttrmap, DataPtr_CourtComplexAuxTilemap, DataPtr_CourtComplexAuxAttrmap, DataPtr_67_2c, DataPtr_CourtComplexTiles ; record 30
	dslot DataPtr_ClubCourtSceneConfig, DataPtr_ClubCourtPalettes, DataPtr_ClubCourtTilemap, DataPtr_ClubCourtAttrmap, DataPtr_ClubCourtAuxTilemap, DataPtr_ClubCourtAuxAttrmap, DataPtr_StadiumGroundsSceneConfig, DataPtr_ClubCourtTiles ; record 31
	dslot DataPtr_StadiumGroundsSceneConfigAlias1, DataPtr_StadiumGroundsPalettes, DataPtr_StadiumGroundsTilemap, DataPtr_StadiumGroundsAttrmap, DataPtr_StadiumGroundsAuxTilemap, DataPtr_StadiumGroundsAuxAttrmap, DataPtr_CeremonyHallSceneConfig, DataPtr_StadiumGroundsTiles ; record 32
	dslot DataPtr_CeremonyHallSceneConfigAlias1, DataPtr_CeremonyHallPalettes, DataPtr_CeremonyHallTilemap, DataPtr_CeremonyHallAttrmap, DataPtr_CeremonyHallAuxTilemap, DataPtr_CeremonyHallAuxAttrmap, DataPtr_68_2c, DataPtr_CeremonyHallTiles ; record 33
	dslot DataPtr_TrainingHallSceneConfig, DataPtr_TrainingHallPalettes, DataPtr_TrainingHallTilemap, DataPtr_TrainingHallAttrmap, DataPtr_TrainingHallAuxTilemap, DataPtr_TrainingHallAuxAttrmap, DataPtr_CenterCourtHallSceneConfig, DataPtr_TrainingHallTiles ; record 34
	dslot DataPtr_CenterCourtHallSceneConfigAlias1, DataPtr_CenterCourtHallPalettes, DataPtr_CenterCourtHallTilemap, DataPtr_CenterCourtHallAttrmap, DataPtr_CenterCourtHallAuxTilemap, DataPtr_CenterCourtHallAuxAttrmap, DataPtr_ClubroomInteriorSceneConfig, DataPtr_CenterCourtHallTiles ; record 35
	dslot DataPtr_ClubroomInteriorSceneConfigAlias1, DataPtr_ClubroomInteriorPalettes, DataPtr_ClubroomInteriorTilemap, DataPtr_ClubroomInteriorAttrmap, DataPtr_ClubroomInteriorAuxTilemap, DataPtr_ClubroomInteriorAuxAttrmap, DataPtr_69_2c, DataPtr_ClubroomInteriorTiles ; record 36
CopyScrolledSceneTilemapToVram:
	push af ; $5c29
	push bc ; $5c2a
	push de ; $5c2b
	push hl ; $5c2c
	or a, a ; $5c2d
	jr z, Label_0a_5c3b ; $5c2e
	ld a, [$c321] ; $5c30
	ld h, a ; $5c33
	ld a, [$c323] ; $5c34
	ld l, a ; $5c37
	jp Label_0a_5c40 ; $5c38
Label_0a_5c3b:
	call UpdateCameraFromPlayer ; $5c3b
	ld h, b ; $5c3e
	ld l, d ; $5c3f
Label_0a_5c40:
	push hl ; $5c40
	ld a, l ; $5c41
	and a, $1f ; $5c42
	ld l, a ; $5c44
	ld a, h ; $5c45
	and a, $1f ; $5c46
	ld h, $00 ; $5c48
	add hl, hl ; $5c4a
	add hl, hl ; $5c4b
	add hl, hl ; $5c4c
	add hl, hl ; $5c4d
	add hl, hl ; $5c4e
	add a, l ; $5c4f
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
	add a, l ; $5c62
	ld l, a ; $5c63
	ld de, $d000 ; $5c64
	add hl, de ; $5c67
	pop de ; $5c68
	push hl ; $5c69
	push de ; $5c6a
	wram_bank $02 ; $5c6b
	ld a, $01 ; $5c71
	ldh [rVBK], a ; $5c73
	ld b, $15 ; $5c75
Label_0a_5c77:
	ld c, $17 ; $5c77
	push de ; $5c79
	push hl ; $5c7a
Label_0a_5c7b:
	ld a, [hl+] ; $5c7b
	ld [de], a ; $5c7c
	inc de ; $5c7d
	ld a, l ; $5c7e
	and a, $3f ; $5c7f
	jr nz, Label_0a_5c8b ; $5c81
	push de ; $5c83
	ld de, hLinkRxByte ; $5c84
	add hl, de ; $5c87
	pop de ; $5c88
	jr Label_0a_5c90 ; $5c89
Label_0a_5c8b:
	ld a, e ; $5c8b
	and a, $1f ; $5c8c
	jr nz, Label_0a_5c98 ; $5c8e
Label_0a_5c90:
	push hl ; $5c90
	ld hl, $ffe0 ; $5c91
	add hl, de ; $5c94
	ld e, l ; $5c95
	ld d, h ; $5c96
	pop hl ; $5c97
Label_0a_5c98:
	dec c ; $5c98
	jr nz, Label_0a_5c7b ; $5c99
	pop hl ; $5c9b
	ld a, $40 ; $5c9c
	add a, l ; $5c9e
	ld l, a ; $5c9f
	jr nc, Label_0a_5ca9 ; $5ca0
	ld a, h ; $5ca2
	inc a ; $5ca3
	and a, $0f ; $5ca4
	or a, $d0 ; $5ca6
	ld h, a ; $5ca8
Label_0a_5ca9:
	pop de ; $5ca9
	ld a, $20 ; $5caa
	add a, e ; $5cac
	ld e, a ; $5cad
	jr nc, Label_0a_5cb5 ; $5cae
	ld a, d ; $5cb0
	inc a ; $5cb1
	res 2, a ; $5cb2
	ld d, a ; $5cb4
Label_0a_5cb5:
	dec b ; $5cb5
	jr nz, Label_0a_5c77 ; $5cb6
	pop de ; $5cb8
	pop hl ; $5cb9
	wram_bank $03 ; $5cba
	xor a, a ; $5cc0
	ldh [rVBK], a ; $5cc1
	ld b, $15 ; $5cc3
Label_0a_5cc5:
	ld c, $17 ; $5cc5
	push de ; $5cc7
	push hl ; $5cc8
Label_0a_5cc9:
	ld a, [hl+] ; $5cc9
	ld [de], a ; $5cca
	inc de ; $5ccb
	ld a, l ; $5ccc
	and a, $3f ; $5ccd
	jr nz, Label_0a_5cd9 ; $5ccf
	push de ; $5cd1
	ld de, hLinkRxByte ; $5cd2
	add hl, de ; $5cd5
	pop de ; $5cd6
	jr Label_0a_5cde ; $5cd7
Label_0a_5cd9:
	ld a, e ; $5cd9
	and a, $1f ; $5cda
	jr nz, Label_0a_5ce6 ; $5cdc
Label_0a_5cde:
	push hl ; $5cde
	ld hl, $ffe0 ; $5cdf
	add hl, de ; $5ce2
	ld e, l ; $5ce3
	ld d, h ; $5ce4
	pop hl ; $5ce5
Label_0a_5ce6:
	dec c ; $5ce6
	jr nz, Label_0a_5cc9 ; $5ce7
	pop hl ; $5ce9
	ld a, $40 ; $5cea
	add a, l ; $5cec
	ld l, a ; $5ced
	jr nc, Label_0a_5cf7 ; $5cee
	ld a, h ; $5cf0
	inc a ; $5cf1
	and a, $0f ; $5cf2
	or a, $d0 ; $5cf4
	ld h, a ; $5cf6
Label_0a_5cf7:
	pop de ; $5cf7
	ld a, $20 ; $5cf8
	add a, e ; $5cfa
	ld e, a ; $5cfb
	jr nc, Label_0a_5d03 ; $5cfc
	ld a, d ; $5cfe
	inc a ; $5cff
	res 2, a ; $5d00
	ld d, a ; $5d02
Label_0a_5d03:
	dec b ; $5d03
	jr nz, Label_0a_5cc5 ; $5d04
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
	ld de, $d000 ; $5d70
	call DecompressDataFromBank ; $5d73
	ld hl, $d000 ; $5d76
	ld de, $9000 ; $5d79
	ld bc, $0080 ; $5d7c
	call StartVRAMDMAFromHL ; $5d7f
	ld hl, $d800 ; $5d82
	ld de, $8800 ; $5d85
	ld bc, $0080 ; $5d88
	call StartVRAMDMAFromHL ; $5d8b
	wram_bank $06 ; $5d8e
	pop hl ; $5d94
	ld de, $d800 ; $5d95
	call DecompressDataFromBank ; $5d98
	pop hl ; $5d9b
	pop hl ; $5d9c
	ld de, $d400 ; $5d9d
	call DecompressDataFromBank ; $5da0
	pop hl ; $5da3
	ld de, $d000 ; $5da4
	call DecompressDataFromBank ; $5da7
	wram_bank $02 ; $5daa
	pop hl ; $5db0
	ld de, $d000 ; $5db1
	call DecompressDataFromBank ; $5db4
	wram_bank $03 ; $5db7
	pop hl ; $5dbd
	ld de, $d000 ; $5dbe
	call DecompressDataFromBank ; $5dc1
	pop hl ; $5dc4
	wram_bank $01 ; $5dc5
	ld de, $d000 ; $5dcb
	ld bc, $0040 ; $5dce
	call CopyDataFromBank ; $5dd1
	ld hl, $d008 ; $5dd4
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
	ld [$c329], a ; $5e01
	ld a, [hl+] ; $5e04
	ld [$c32a], a ; $5e05
	ld a, [hl+] ; $5e08
	ld [$c32b], a ; $5e09
	ld a, [hl+] ; $5e0c
	ld [$c32c], a ; $5e0d
	pop bc ; $5e10
	ld a, b ; $5e11
	call CopyScrolledSceneTilemapToVram ; $5e12
	call EnableLCD ; $5e15
	call AdvanceFrame ; $5e18
	call AdvanceFrame ; $5e1b
	ret ; $5e1e
SceneViewerSelectScene:
	ldh a, [hInputRisingEdge] ; $5e1f
	bit 1, a ; $5e21
	ret z ; $5e23
	ld a, [$c32d] ; $5e24
	dec a ; $5e27
	srl a ; $5e28
	srl a ; $5e2a
	inc a ; $5e2c
	push af ; $5e2d
	ld a, [wCurrentScene] ; $5e2e
	ld [$c33d], a ; $5e31
	call StopSceneTileAnimations ; $5e34
	pop af ; $5e37
	ld hl, $0176 ; $5e38
	farcall FarPtr_RunPagedTextMenu ; $5e3b
	ld [wCurrentScene], a ; $5e3e
	cp a, $ff ; $5e41
	jp z, Label_0a_5e51 ; $5e43
	ld b, $01 ; $5e46
	call LoadAndDisplayScene ; $5e48
	ld a, [wCurrentScene] ; $5e4b
	call InitSceneTileAnimations ; $5e4e
Label_0a_5e51:
	ret ; $5e51
	ld hl, $0176 ; $5e52
	ld d, $01 ; $5e55
	ld e, $01 ; $5e57
	farcall FarPtr_CreateMenuWindowFromText ; $5e59
	ld a, [$d820] ; $5e5c
	ld [$d82f], a ; $5e5f
	farcall FarPtr_RestoreShadowTilemap ; $5e62
	farcall FarPtr_05_10 ; $5e65
Label_0a_5e68:
	call AdvanceFrame ; $5e68
	ldh a, [hPlayerInputFlags] ; $5e6b
	and a, $02 ; $5e6d
	jr nz, Label_0a_5e68 ; $5e6f
	farcall FarPtr_RunMenuSelection ; $5e71
	ld [wCurrentScene], a ; $5e74
	ld a, [$d82f] ; $5e77
	farcall FarPtr_CloseWindow ; $5e7a
	ld a, [wCurrentScene] ; $5e7d
	cp a, $ff ; $5e80
	jp z, Label_0a_5e90 ; $5e82
	ld a, [wCurrentScene] ; $5e85
	ld b, $01 ; $5e88
	call LoadAndDisplayScene ; $5e8a
	farcall FarPtr_RestoreShadowTilemap ; $5e8d
Label_0a_5e90:
	ret ; $5e90
RunSceneSelectDebugMenu:
	push af ; $5e91
	push bc ; $5e92
	push de ; $5e93
	push hl ; $5e94
	ld a, $08 ; $5e95
	ld [$c32d], a ; $5e97
	dec a ; $5e9a
	srl a ; $5e9b
	srl a ; $5e9d
	inc a ; $5e9f
	push af ; $5ea0
	ld a, [wCurrentScene] ; $5ea1
	ld [$c33d], a ; $5ea4
	call StopSceneTileAnimations ; $5ea7
	pop af ; $5eaa
	ld hl, $0176 ; $5eab
	farcall FarPtr_RunPagedTextMenu ; $5eae
	ld [wCurrentScene], a ; $5eb1
	cp a, $ff ; $5eb4
	jp z, Label_0a_5ed8 ; $5eb6
	ld b, $01 ; $5eb9
	farcall FarPtr_ResetTextWindowState ; $5ebb
	call DisableLCDSafely ; $5ebe
	call InitSceneScroll ; $5ec1
	ld a, [wCurrentScene] ; $5ec4
	call LoadStorySceneGraphics ; $5ec7
	ld a, $00 ; $5eca
	farcall FarPtr_CopyScrolledSceneTilemapToVram ; $5ecc
	call EnableLCD ; $5ecf
	ld a, [wCurrentScene] ; $5ed2
	call InitSceneTileAnimations ; $5ed5
Label_0a_5ed8:
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
	ld bc, $d000 ; $5ef4
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
	ld bc, $d400 ; $5f48
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
Label_0a_5fb1:
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
	jr nz, Label_0a_5fb1 ; $5fca
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
Label_0a_5ff7:
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
	jr nz, Label_0a_5ff7 ; $6010
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
	and a, $7f ; $6021
	ld [wCurrentScene], a ; $6023
	xor a, a ; $6026
	ldh [hScrollY], a ; $6027
	ldh [hScrollX], a ; $6029
	dec a ; $602b
	ld [$c33d], a ; $602c
	ld hl, SceneGfxSlotTable ; $602f
	ld bc, rIE ; $6032
Label_0a_6035:
	inc bc ; $6035
	ld a, [hl+] ; $6036
	ld d, a ; $6037
	ld a, [hl+] ; $6038
	or a, d ; $6039
	jr nz, Label_0a_6035 ; $603a
	ld h, b ; $603c
	ld l, c ; $603d
	ld de, $0009 ; $603e
	call DivHLByDE ; $6041
	ld a, l ; $6044
	ld [$c32d], a ; $6045
	pop af ; $6048
	bit 7, a ; $6049
	jr nz, Label_0a_6054 ; $604b
	and a, $7f ; $604d
	ld b, $00 ; $604f
	call LoadAndDisplayScene ; $6051
Label_0a_6054:
	xor a, a ; $6054
	ldh [hBGColumnBlitPending], a ; $6055
	ldh [hBGRowBlitPending], a ; $6057
	farcall FarPtr_InitTextWindows ; $6059
	ld a, $01 ; $605c
	ld hl, $60c1 ; $605e
	call RegisterFrameTask ; $6061
	ld a, [wCurrentScene] ; $6064
	call InitSceneTileAnimations ; $6067
	pop hl ; $606a
	pop de ; $606b
	pop bc ; $606c
	pop af ; $606d
	ret ; $606e
	ld hl, $60c1 ; $606f
	call UnregisterFrameTask ; $6072
	ret ; $6075
InitSceneViewerDefault:
	push af ; $6076
	push bc ; $6077
	push de ; $6078
	push hl ; $6079
	xor a, a ; $607a
	ldh [hScrollY], a ; $607b
	ldh [hScrollX], a ; $607d
	ld hl, SceneGfxSlotTable ; $607f
	ld bc, rIE ; $6082
Label_0a_6085:
	inc c ; $6085
	ld a, [hl+] ; $6086
	ld d, a ; $6087
	ld a, [hl+] ; $6088
	or a, d ; $6089
	jr nz, Label_0a_6085 ; $608a
	ld h, b ; $608c
	ld l, c ; $608d
	ld de, $0009 ; $608e
	call DivHLByDE ; $6091
	ld a, l ; $6094
	ld [$c32d], a ; $6095
	ld a, $00 ; $6098
	ld [wCurrentScene], a ; $609a
	ld b, $00 ; $609d
	call LoadAndDisplayScene ; $609f
	farcall FarPtr_InitTextWindows ; $60a2
	farcall FarPtr_RestoreShadowTilemap ; $60a5
	ld a, [wCurrentScene] ; $60a8
	call InitSceneTileAnimations ; $60ab
	pop hl ; $60ae
	pop de ; $60af
	pop bc ; $60b0
	pop af ; $60b1
	ret ; $60b2
	call InitSceneViewerDefault ; $60b3
Label_0a_60b6:
	call UpdateSceneViewerScroll ; $60b6
	call SceneViewerSelectScene ; $60b9
	call AdvanceFrame ; $60bc
	jr Label_0a_60b6 ; $60bf
	ret ; $60c1
UpdateSceneViewerScroll:
	ld a, [$c321] ; $60c2
	push af ; $60c5
	ld a, [$c323] ; $60c6
	push af ; $60c9
	call MoveSceneViewerCamera ; $60ca
	pop hl ; $60cd
	ld a, [$c323] ; $60ce
	cp a, h ; $60d1
	jr z, Label_0a_60e4 ; $60d2
	jr c, Label_0a_60de ; $60d4
	ld bc, $fb13 ; $60d6
	call BlitBGRowFrom64 ; $60d9
	jr Label_0a_60e4 ; $60dc
Label_0a_60de:
	ld bc, $fb00 ; $60de
	call BlitBGRowFrom64 ; $60e1
Label_0a_60e4:
	pop hl ; $60e4
	ld a, [$c321] ; $60e5
	cp a, h ; $60e8
	jr z, Label_0a_60fb ; $60e9
	jr c, Label_0a_60f5 ; $60eb
	ld bc, $15fa ; $60ed
	call BlitBGColumnFrom64 ; $60f0
	jr Label_0a_60fb ; $60f3
Label_0a_60f5:
	ld bc, $00fa ; $60f5
	call BlitBGColumnFrom64 ; $60f8
Label_0a_60fb:
	ld a, [wCameraY] ; $60fb
	ld c, a ; $60fe
	ld a, [$c323] ; $60ff
	sla c ; $6102
	rla ; $6104
	sla c ; $6105
	rla ; $6107
	sla c ; $6108
	rla ; $610a
	ldh [hScrollY], a ; $610b
	ld a, [wCameraX] ; $610d
	ld c, a ; $6110
	ld a, [$c321] ; $6111
	sla c ; $6114
	rla ; $6116
	sla c ; $6117
	rla ; $6119
	sla c ; $611a
	rla ; $611c
	ldh [hScrollX], a ; $611d
	ret ; $611f
	INCBIN "data/bank_00a/d_6120.bin" ; $6120, 64 bytes
MoveSceneViewerCamera:
	ldh a, [hPlayerInputFlags] ; $6160
	rra ; $6162
	rra ; $6163
	and a, $3c ; $6164
	ld hl, $6120 ; $6166
	ld d, $00 ; $6169
	ld e, a ; $616b
	add hl, de ; $616c
	ld d, h ; $616d
	ld e, l ; $616e
	ld a, [wCameraX] ; $616f
	ld l, a ; $6172
	ld a, [$c321] ; $6173
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
	ld [$c321], a ; $6183
	ld a, [wCameraY] ; $6186
	ld l, a ; $6189
	ld a, [$c323] ; $618a
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
	ld [$c323], a ; $619a
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
Label_0a_61c2:
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
	jr nz, Label_0a_61c2 ; $61db
	pop bc ; $61dd
	pop de ; $61de
	pop hl ; $61df
	wram_bank $03 ; $61e0
	ld a, c ; $61e6
	ld c, b ; $61e7
	ld b, $00 ; $61e8
Label_0a_61ea:
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
	jr nz, Label_0a_61ea ; $6203
	pop hl ; $6205
	pop de ; $6206
	wram_bank $05 ; $6207
	farcall FarPtr_RestoreShadowTilemap ; $620d
	ld d, e ; $6210
	ld e, l ; $6211
	farcall FarPtr_RedrawTilemapRowRange ; $6212
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
	ld bc, $d000 ; $622f
	add hl, bc ; $6232
	pop bc ; $6233
	ret ; $6234
UpdateCameraFromPlayer:
	wram_bank $04 ; $6235
	ld hl, $d00c ; $623b
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
	ld a, [$c329] ; $624a
	ld d, a ; $624d
	ld a, h ; $624e
	sub a, d ; $624f
	bit 7, a ; $6250
	jr z, Label_0a_6259 ; $6252
	ld h, d ; $6254
	ld l, $00 ; $6255
	jr Label_0a_6268 ; $6257
Label_0a_6259:
	ld a, [$c32b] ; $6259
	sub a, $14 ; $625c
	ld d, a ; $625e
	ld a, h ; $625f
	sub a, d ; $6260
	bit 7, a ; $6261
	jr nz, Label_0a_6268 ; $6263
	ld h, d ; $6265
	ld l, $00 ; $6266
Label_0a_6268:
	ld b, h ; $6268
	ld c, l ; $6269
	pop de ; $626a
	ld hl, $f510 ; $626b
	add hl, de ; $626e
	ld a, [$c32a] ; $626f
	ld d, a ; $6272
	ld a, h ; $6273
	sub a, d ; $6274
	bit 7, a ; $6275
	jr z, Label_0a_627e ; $6277
	ld h, d ; $6279
	ld l, $00 ; $627a
	jr Label_0a_628d ; $627c
Label_0a_627e:
	ld a, [$c32c] ; $627e
	sub a, $12 ; $6281
	ld d, a ; $6283
	ld a, h ; $6284
	sub a, d ; $6285
	bit 7, a ; $6286
	jr nz, Label_0a_628d ; $6288
	ld h, d ; $628a
	ld l, $00 ; $628b
Label_0a_628d:
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
	INCBIN "data/bank_00a/d_629b.bin" ; $629b, 93 bytes
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
	ld de, $d000 ; $6330
	call DecompressDataFromBank ; $6333
	ld hl, $d000 ; $6336
	ld de, $b000 ; $6339
	ld c, $80 ; $633c
	call QueueVRAMCopy ; $633e
	ld hl, $d800 ; $6341
	ld de, $a800 ; $6344
	ld c, $80 ; $6347
	call QueueVRAMCopy ; $6349
	wram_bank $04 ; $634c
	pop hl ; $6352
	ld de, $dea8 ; $6353
	ld bc, $0028 ; $6356
	call CopyDataFromBank ; $6359
	pop hl ; $635c
	ld de, $de80 ; $635d
	ld bc, $0028 ; $6360
	call CopyDataFromBank ; $6363
	wram_bank $02 ; $6366
	pop hl ; $636c
	ld de, $dc00 ; $636d
	call DecompressDataFromBank ; $6370
	pop hl ; $6373
	ld de, $d800 ; $6374
	call DecompressDataFromBank ; $6377
	pop hl ; $637a
	ld de, $d000 ; $637b
	ld bc, $0040 ; $637e
	call CopyDataFromBank ; $6381
	ld hl, $d010 ; $6384
	ld de, $0206 ; $6387
	call LoadPaletteShadow ; $638a
	ld hl, $d028 ; $638d
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
	ld hl, $c330 ; $63ac
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
	ld de, $da80 ; $63c4
	ld bc, $0088 ; $63c7
	call CopyDataFromBank ; $63ca
	ld hl, $da88 ; $63cd
	ld a, [hl] ; $63d0
	cp a, $fe ; $63d1
	jr nz, Label_0a_63d8 ; $63d3
	jp Label_0a_644c ; $63d5
Label_0a_63d8:
	add sp, -2 ; $63d8
	ld de, $c332 ; $63da
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
	xor a, a ; $63ea
	ld hl, $c330 ; $63eb
	ld [hl], a ; $63ee
	ld hl, $c338 ; $63ef
	ld [hl], a ; $63f2
	inc hl ; $63f3
Label_0a_63f4:
	inc b ; $63f4
	ld a, [de] ; $63f5
	inc de ; $63f6
	cp a, $fe ; $63f7
	jr z, Label_0a_6430 ; $63f9
	cp a, $ff ; $63fb
	jr nz, Label_0a_63f4 ; $63fd
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
	sub a, c ; $641e
	ld hl, $c330 ; $641f
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
	jr nz, Label_0a_63f4 ; $642e
Label_0a_6430:
	ld a, c ; $6430
	or a, a ; $6431
	jr z, Label_0a_6442 ; $6432
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
Label_0a_6442:
	ld a, $01 ; $6442
	ld hl, $6465 ; $6444
	call RegisterFrameTask ; $6447
	add sp, 2 ; $644a
Label_0a_644c:
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
	ld hl, $6465 ; $645a
	call UnregisterFrameTask ; $645d
	pop hl ; $6460
	pop de ; $6461
	pop bc ; $6462
	pop af ; $6463
	ret ; $6464
	test_flag $03, 0 ; $6465
	ret nz ; $6468
	test_flag $03, 2 ; $6469
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
	ld hl, $c338 ; $6485
Label_0a_6488:
	ld a, [hl] ; $6488
	cp a, $ff ; $6489
	jr z, Label_0a_64b1 ; $648b
	push hl ; $648d
	ld l, c ; $648e
	ld h, $00 ; $648f
	add hl, hl ; $6491
	ld de, $c330 ; $6492
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
	cp a, $04 ; $64a0
	jr z, Label_0a_64b1 ; $64a2
	ld a, d ; $64a4
	or a, a ; $64a5
	jr nz, Label_0a_6488 ; $64a6
	ld a, b ; $64a8
	call AdvanceSceneTileAnimation ; $64a9
	ld a, c ; $64ac
	cp a, $04 ; $64ad
	jr nz, Label_0a_6488 ; $64af
Label_0a_64b1:
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
	ld bc, $c330 ; $64c9
	add hl, bc ; $64cc
	ld a, [hl] ; $64cd
	ld [$c33c], a ; $64ce
Label_0a_64d1:
	ld hl, $da88 ; $64d1
	ld a, [$c33c] ; $64d4
	ld c, a ; $64d7
	ld b, $00 ; $64d8
	add hl, bc ; $64da
	ld a, [hl] ; $64db
	cp a, $ff ; $64dc
	jr nz, Label_0a_64ef ; $64de
	ld hl, sp + 0 ; $64e0
	ld c, [hl] ; $64e2
	ld b, $00 ; $64e3
	ld hl, $c338 ; $64e5
	add hl, bc ; $64e8
	ld a, [hl] ; $64e9
	ld [$c33c], a ; $64ea
	jr Label_0a_64d1 ; $64ed
Label_0a_64ef:
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
	ld de, $b000 ; $6513
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
	ld a, [$c33c] ; $6577
	add a, $04 ; $657a
	ld [$c33c], a ; $657c
	pop af ; $657f
	ld d, a ; $6580
	add sp, 1 ; $6581
	pop af ; $6583
	ld h, $00 ; $6584
	ld l, a ; $6586
	add hl, hl ; $6587
	ld bc, $c330 ; $6588
	add hl, bc ; $658b
	ld a, [$c33c] ; $658c
	ld [hl+], a ; $658f
	ld [hl], d ; $6590
	pop hl ; $6591
	pop de ; $6592
	pop bc ; $6593
	pop af ; $6594
	ret ; $6595
InitMinigameTargets:
	wram_bank $04 ; $6596
	ld hl, $dc00 ; $659c
	ld c, $10 ; $659f
	call ClearMemory16 ; $65a1
	ld a, $01 ; $65a4
	ld [$c7be], a ; $65a6
	ld a, $ff ; $65a9
	ld [$c78d], a ; $65ab
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
	ld a, [$c7be] ; $65c3
	and a, a ; $65c6
	ret z ; $65c7
	ld hl, $dc00 ; $65c8
	ld c, $0f ; $65cb
Label_0a_65cd:
	call UpdateMinigameTarget ; $65cd
	ld de, $000e ; $65d0
	add hl, de ; $65d3
	dec c ; $65d4
	jr nz, Label_0a_65cd ; $65d5
	ret ; $65d7
UpdateMinigameTarget:
	bit 0, [hl] ; $65d8
	ret z ; $65da
	push af ; $65db
	push bc ; $65dc
	push de ; $65dd
	push hl ; $65de
	push hl ; $65df
	ld de, $dcf0 ; $65e0
	ld c, $01 ; $65e3
	call CopyMemoryFast ; $65e5
	ld hl, $dcf2 ; $65e8
	ld a, [hl] ; $65eb
	and a, a ; $65ec
	jr z, Label_0a_65f0 ; $65ed
	dec [hl] ; $65ef
Label_0a_65f0:
	call RunMinigameTargetScript ; $65f0
	call MoveMinigameTargetTowardGoal ; $65f3
	ld a, [$c7a4] ; $65f6
	and a, a ; $65f9
	jr nz, Label_0a_6607 ; $65fa
	call DrawMinigameTarget ; $65fc
	call CheckBallHitsMinigameTarget ; $65ff
	call HandleMinigameTargetHit ; $6602
	jr Label_0a_6610 ; $6605
Label_0a_6607:
	call DrawMinigameTargetAlt ; $6607
	call CheckBallHitsMinigameTargetAlt ; $660a
	call HandleMinigameTargetHitAlt ; $660d
Label_0a_6610:
	pop de ; $6610
	ld hl, $dcf0 ; $6611
	ld c, $01 ; $6614
	call CopyMemoryFast ; $6616
	pop hl ; $6619
	pop de ; $661a
	pop bc ; $661b
	pop af ; $661c
	ret ; $661d
MoveMinigameTargetTowardGoal:
	ld hl, $dcf0 ; $661e
	bit 1, [hl] ; $6621
	ret z ; $6623
	ld hl, $dcf6 ; $6624
	ld a, [hl+] ; $6627
	ld d, [hl] ; $6628
	ld e, a ; $6629
	ld hl, $dcfa ; $662a
	ld a, [hl+] ; $662d
	ld h, [hl] ; $662e
	ld l, a ; $662f
	ld a, l ; $6630
	sub a, e ; $6631
	ld l, a ; $6632
	ld a, h ; $6633
	sbc a, d ; $6634
	ld h, a ; $6635
	ld a, h ; $6636
	or a, l ; $6637
	jr z, Label_0a_6650 ; $6638
	ld de, $0010 ; $663a
	bit 7, h ; $663d
	jr z, Label_0a_6647 ; $663f
	xor a, a ; $6641
	sub a, e ; $6642
	ld e, a ; $6643
	sbc a, a ; $6644
	sub a, d ; $6645
	ld d, a ; $6646
Label_0a_6647:
	ld hl, $dcf6 ; $6647
	ld a, [hl] ; $664a
	add a, e ; $664b
	ld [hl+], a ; $664c
	ld a, [hl] ; $664d
	adc a, d ; $664e
	ld [hl+], a ; $664f
Label_0a_6650:
	ld hl, $dcf8 ; $6650
	ld a, [hl+] ; $6653
	ld d, [hl] ; $6654
	ld e, a ; $6655
	ld hl, $dcfc ; $6656
	ld a, [hl+] ; $6659
	ld h, [hl] ; $665a
	ld l, a ; $665b
	ld a, l ; $665c
	sub a, e ; $665d
	ld l, a ; $665e
	ld a, h ; $665f
	sbc a, d ; $6660
	ld h, a ; $6661
	ld a, h ; $6662
	or a, l ; $6663
	jr z, Label_0a_667c ; $6664
	ld de, $0010 ; $6666
	bit 7, h ; $6669
	jr z, Label_0a_6673 ; $666b
	xor a, a ; $666d
	sub a, e ; $666e
	ld e, a ; $666f
	sbc a, a ; $6670
	sub a, d ; $6671
	ld d, a ; $6672
Label_0a_6673:
	ld hl, $dcf8 ; $6673
	ld a, [hl] ; $6676
	add a, e ; $6677
	ld [hl+], a ; $6678
	ld a, [hl] ; $6679
	adc a, d ; $667a
	ld [hl+], a ; $667b
Label_0a_667c:
	ld hl, $dcf6 ; $667c
	ld a, [hl+] ; $667f
	ld d, [hl] ; $6680
	ld e, a ; $6681
	ld hl, $dcfa ; $6682
	ld a, [hl+] ; $6685
	ld h, [hl] ; $6686
	ld l, a ; $6687
	ld a, l ; $6688
	sub a, e ; $6689
	ld l, a ; $668a
	ld a, h ; $668b
	sbc a, d ; $668c
	ld h, a ; $668d
	ld a, h ; $668e
	or a, l ; $668f
	jr nz, Label_0a_66ad ; $6690
	ld hl, $dcf8 ; $6692
	ld a, [hl+] ; $6695
	ld d, [hl] ; $6696
	ld e, a ; $6697
	ld hl, $dcfc ; $6698
	ld a, [hl+] ; $669b
	ld h, [hl] ; $669c
	ld l, a ; $669d
	ld a, l ; $669e
	sub a, e ; $669f
	ld l, a ; $66a0
	ld a, h ; $66a1
	sbc a, d ; $66a2
	ld h, a ; $66a3
	ld a, h ; $66a4
	or a, l ; $66a5
	jr nz, Label_0a_66ad ; $66a6
	ld hl, $dcf0 ; $66a8
	res 1, [hl] ; $66ab
Label_0a_66ad:
	ret ; $66ad
DrawMinigameTarget:
	ld hl, $dcf8 ; $66ae
	ld a, [hl+] ; $66b1
	ld b, [hl] ; $66b2
	ld c, a ; $66b3
	ld hl, $dcf6 ; $66b4
	ld a, [hl+] ; $66b7
	ld h, [hl] ; $66b8
	ld l, a ; $66b9
	farcall FarPtr_ApplyCameraProjection ; $66ba
	ld c, e ; $66bd
	ld b, d ; $66be
	ld a, [$dcf2] ; $66bf
	and a, $0f ; $66c2
	jr z, Label_0a_66e1 ; $66c4
	add a, $fe ; $66c6
	ld l, a ; $66c8
	adc a, $66 ; $66c9
	sub a, l ; $66cb
	ld h, a ; $66cc
	ld a, [hl] ; $66cd
	ld h, $00 ; $66ce
	ld l, a ; $66d0
	ld a, [$dcf1] ; $66d1
	rrca ; $66d4
	rrca ; $66d5
	and a, $c0 ; $66d6
	call VectorFromLengthAndAngleRaw ; $66d8
	ld a, c ; $66db
	add a, e ; $66dc
	ld e, a ; $66dd
	ld a, b ; $66de
	add a, l ; $66df
	ld d, a ; $66e0
Label_0a_66e1:
	ld a, [$dcf1] ; $66e1
	add a, a ; $66e4
	add a, $f6 ; $66e5
	ld l, a ; $66e7
	adc a, $66 ; $66e8
	sub a, l ; $66ea
	ld h, a ; $66eb
	ld a, [hl+] ; $66ec
	ld b, [hl] ; $66ed
	ld c, a ; $66ee
	ld hl, $670e ; $66ef
	call QueueSpriteTemplate ; $66f2
	ret ; $66f5
	INCBIN "data/bank_00a/d_66f6.bin" ; $66f6, 33 bytes
HandleMinigameTargetHit:
	ld hl, $dcf0 ; $6717
	bit 2, [hl] ; $671a
	ret z ; $671c
	res 2, [hl] ; $671d
	sound $77 ; $671f
	ld a, $20 ; $6721
	ld [$dcf2], a ; $6723
	ld a, [$dcf1] ; $6726
	call DeflectBallOffMinigameTarget ; $6729
	ret ; $672c
CheckBallHitsMinigameTarget:
	ld a, [$c4b4] ; $672d
	and a, a ; $6730
	ret z ; $6731
	ld hl, $dd1e ; $6732
	ld a, [hl+] ; $6735
	ld d, [hl] ; $6736
	ld e, a ; $6737
	ld hl, $dcf6 ; $6738
	ld a, [hl+] ; $673b
	ld h, [hl] ; $673c
	ld l, a ; $673d
	ld a, l ; $673e
	sub a, e ; $673f
	ld l, a ; $6740
	ld a, h ; $6741
	sbc a, d ; $6742
	ld h, a ; $6743
	bit 7, h ; $6744
	jr z, Label_0a_6773 ; $6746
	ld de, $0200 ; $6748
	add hl, de ; $674b
	bit 7, h ; $674c
	jr nz, Label_0a_6773 ; $674e
	ld hl, $dd20 ; $6750
	ld a, [hl+] ; $6753
	ld d, [hl] ; $6754
	ld e, a ; $6755
	ld hl, $dcf8 ; $6756
	ld a, [hl+] ; $6759
	ld h, [hl] ; $675a
	ld l, a ; $675b
	ld a, l ; $675c
	sub a, e ; $675d
	ld l, a ; $675e
	ld a, h ; $675f
	sbc a, d ; $6760
	ld h, a ; $6761
	bit 7, h ; $6762
	jr z, Label_0a_6773 ; $6764
	ld de, $0200 ; $6766
	add hl, de ; $6769
	bit 7, h ; $676a
	jr nz, Label_0a_6773 ; $676c
	ld hl, $dcf0 ; $676e
	set 2, [hl] ; $6771
Label_0a_6773:
	ret ; $6773
DeflectBallOffMinigameTarget:
	and a, $03 ; $6774
	ld a, a ; $6776
	rst Rst00 ; $6777
	dw Label_0a_6780 ; $6778 jumptable
	dw Label_0a_678d ; $677a jumptable
	dw Label_0a_67a5 ; $677c jumptable
	dw Label_0a_67b2 ; $677e jumptable
Label_0a_6780:
	ld de, $0600 ; $6780
	ld hl, wBallVelocityX ; $6783
	ld a, [hl] ; $6786
	add a, e ; $6787
	ld [hl+], a ; $6788
	ld a, [hl] ; $6789
	adc a, d ; $678a
	ld [hl+], a ; $678b
	ret ; $678c
Label_0a_678d:
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
Label_0a_67a5:
	ld de, $fa00 ; $67a5
	ld hl, wBallVelocityX ; $67a8
	ld a, [hl] ; $67ab
	add a, e ; $67ac
	ld [hl+], a ; $67ad
	ld a, [hl] ; $67ae
	adc a, d ; $67af
	ld [hl+], a ; $67b0
	ret ; $67b1
Label_0a_67b2:
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
	and a, a ; $67ec
	jr z, Label_0a_67f4 ; $67ed
	call DrawDigitSprite_0a ; $67ef
	jr DrawDigitSpritesString ; $67f2
Label_0a_67f4:
	ret ; $67f4
DrawDigitSprite_0a:
	sub a, $30 ; $67f5
	jr c, Label_0a_6804 ; $67f7
	push de ; $67f9
	push hl ; $67fa
	add a, a ; $67fb
	add a, $08 ; $67fc
	ld c, a ; $67fe
	call QueueSprite ; $67ff
	pop hl ; $6802
	pop de ; $6803
Label_0a_6804:
	ld a, d ; $6804
	add a, $08 ; $6805
	ld d, a ; $6807
	ret ; $6808
	INCBIN "data/bank_00a/d_6809.bin" ; $6809, 29 bytes
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
	INCBIN "data/bank_00a/d_6833.bin" ; $6833, 13 bytes
	ld hl, $dcf0 ; $6840
	bit 1, [hl] ; $6843
	jr nz, Label_0a_684b ; $6845
	inc de ; $6847
	ld a, $01 ; $6848
	ret ; $684a
Label_0a_684b:
	xor a, a ; $684b
	ret ; $684c
	inc de ; $684d
	ld l, e ; $684e
	ld h, d ; $684f
	ld de, $dcf6 ; $6850
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
	ld hl, $dcf0 ; $6861
	res 1, [hl] ; $6864
	ld a, $01 ; $6866
	ret ; $6868
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
	ld hl, $dcf6 ; $687a
	ld a, [hl+] ; $687d
	ld h, [hl] ; $687e
	ld l, a ; $687f
	add hl, bc ; $6880
	ld c, l ; $6881
	ld b, h ; $6882
	ld hl, $dcfa ; $6883
	ld a, c ; $6886
	ld [hl+], a ; $6887
	ld [hl], b ; $6888
	ld hl, $dcf8 ; $6889
	ld a, [hl+] ; $688c
	ld h, [hl] ; $688d
	ld l, a ; $688e
	add hl, de ; $688f
	ld e, l ; $6890
	ld d, h ; $6891
	ld hl, $dcfc ; $6892
	ld a, e ; $6895
	ld [hl+], a ; $6896
	ld [hl], d ; $6897
	pop de ; $6898
	ld hl, $dcf0 ; $6899
	set 1, [hl] ; $689c
	ld a, $01 ; $689e
	ret ; $68a0
	inc de ; $68a1
	ld a, [de] ; $68a2
	inc de ; $68a3
	ld [$dcf1], a ; $68a4
	ld a, $01 ; $68a7
	ret ; $68a9
	INCBIN "data/bank_00a/d_68aa.bin" ; $68aa, 13 bytes
RunMinigameTargetScript:
	ld hl, $dcf3 ; $68b7
	ld a, [hl] ; $68ba
	and a, a ; $68bb
	jr z, Label_0a_68c0 ; $68bc
	dec [hl] ; $68be
	ret ; $68bf
Label_0a_68c0:
	ld hl, $dcf4 ; $68c0
	ld a, [hl+] ; $68c3
	ld d, [hl] ; $68c4
	ld e, a ; $68c5
Label_0a_68c6:
	ld hl, $68d7 ; $68c6
	push hl ; $68c9
	ld a, [de] ; $68ca
	add a, a ; $68cb
	add a, $09 ; $68cc
	ld l, a ; $68ce
	adc a, $68 ; $68cf
	sub a, l ; $68d1
	ld h, a ; $68d2
	ld a, [hl+] ; $68d3
	ld h, [hl] ; $68d4
	ld l, a ; $68d5
	jp hl ; $68d6
	ld hl, $dcf4 ; $68d7
	ld [hl], e ; $68da
	inc hl ; $68db
	ld [hl], d ; $68dc
	and a, a ; $68dd
	jr nz, Label_0a_68c6 ; $68de
	ret ; $68e0
	INCBIN "data/bank_00a/d_68e1.bin" ; $68e1, 922 bytes
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
	ld hl, $6c96 ; $6c8f
	call SpawnMinigameTargetsFromList ; $6c92
	ret ; $6c95
	INCBIN "data/bank_00a/d_6c96.bin" ; $6c96, 10 bytes
SpawnMinigameTargetFormation1:
	ld hl, $6ca7 ; $6ca0
	call SpawnMinigameTargetsFromList ; $6ca3
	ret ; $6ca6
	INCBIN "data/bank_00a/d_6ca7.bin" ; $6ca7, 18 bytes
SpawnMinigameTargetFormation2:
	ld hl, $6cc0 ; $6cb9
	call SpawnMinigameTargetsFromList ; $6cbc
	ret ; $6cbf
	INCBIN "data/bank_00a/d_6cc0.bin" ; $6cc0, 18 bytes
SpawnMinigameTargetFormation3:
	ld hl, $6cd9 ; $6cd2
	call SpawnMinigameTargetsFromList ; $6cd5
	ret ; $6cd8
	INCBIN "data/bank_00a/d_6cd9.bin" ; $6cd9, 26 bytes
SpawnMinigameTargetFormation4:
	ld hl, $6cfa ; $6cf3
	call SpawnMinigameTargetsFromList ; $6cf6
	ret ; $6cf9
	INCBIN "data/bank_00a/d_6cfa.bin" ; $6cfa, 26 bytes
SpawnMinigameTargetFormation5:
	ld hl, $6d1b ; $6d14
	call SpawnMinigameTargetsFromList ; $6d17
	ret ; $6d1a
	INCBIN "data/bank_00a/d_6d1b.bin" ; $6d1b, 6 bytes
SpawnMinigameTargetFormation6:
	ld hl, $6d28 ; $6d21
	call SpawnMinigameTargetsFromList ; $6d24
	ret ; $6d27
	INCBIN "data/bank_00a/d_6d28.bin" ; $6d28, 8 bytes
SpawnMinigameTargetFormation7:
	ld hl, $6d37 ; $6d30
	call SpawnMinigameTargetsFromList ; $6d33
	ret ; $6d36
	INCBIN "data/bank_00a/d_6d37.bin" ; $6d37, 10 bytes
SpawnMinigameTargetFormation8:
	ld hl, $6d48 ; $6d41
	call SpawnMinigameTargetsFromList ; $6d44
	ret ; $6d47
	INCBIN "data/bank_00a/d_6d48.bin" ; $6d48, 10 bytes
SpawnMinigameTargetsFromList:
	ld bc, $dc00 ; $6d52
Label_0a_6d55:
	ld a, [hl+] ; $6d55
	ld e, a ; $6d56
	ld a, [hl+] ; $6d57
	ld d, a ; $6d58
	ld a, d ; $6d59
	or a, e ; $6d5a
	jr z, Label_0a_6d6d ; $6d5b
	push bc ; $6d5d
	push hl ; $6d5e
	call ActivateMinigameTarget ; $6d5f
	pop hl ; $6d62
	pop bc ; $6d63
	ld a, $0e ; $6d64
	add a, c ; $6d66
	ld c, a ; $6d67
	jr nc, Label_0a_6d6b ; $6d68
	inc b ; $6d6a
Label_0a_6d6b:
	jr Label_0a_6d55 ; $6d6b
Label_0a_6d6d:
	ret ; $6d6d
DrawMinigameTargetAlt:
	ld hl, $dcf8 ; $6d6e
	ld a, [hl+] ; $6d71
	ld b, [hl] ; $6d72
	ld c, a ; $6d73
	ld hl, $dcf6 ; $6d74
	ld a, [hl+] ; $6d77
	ld h, [hl] ; $6d78
	ld l, a ; $6d79
	farcall FarPtr_ApplyCameraProjection ; $6d7a
	ld c, e ; $6d7d
	ld b, d ; $6d7e
	ld a, [$dcf2] ; $6d7f
	and a, $0f ; $6d82
	jr z, Label_0a_6d90 ; $6d84
	add a, $ad ; $6d86
	ld l, a ; $6d88
	adc a, $6d ; $6d89
	sub a, l ; $6d8b
	ld h, a ; $6d8c
	ld a, [hl] ; $6d8d
	add a, d ; $6d8e
	ld d, a ; $6d8f
Label_0a_6d90:
	ld a, [$dcf1] ; $6d90
	add a, a ; $6d93
	add a, $a5 ; $6d94
	ld l, a ; $6d96
	adc a, $6d ; $6d97
	sub a, l ; $6d99
	ld h, a ; $6d9a
	ld a, [hl+] ; $6d9b
	ld b, [hl] ; $6d9c
	ld c, a ; $6d9d
	ld hl, $6dbd ; $6d9e
	call QueueSpriteTemplate ; $6da1
	ret ; $6da4
	INCBIN "data/bank_00a/d_6da5.bin" ; $6da5, 57 bytes
HandleMinigameTargetHitAlt:
	ld hl, $dcf0 ; $6dde
	bit 2, [hl] ; $6de1
	ret z ; $6de3
	res 2, [hl] ; $6de4
	sound $97 ; $6de6
	ld a, $20 ; $6de8
	ld [$dcf2], a ; $6dea
	ld a, [$dcf1] ; $6ded
	ld [$c78d], a ; $6df0
	ret ; $6df3
CheckBallHitsMinigameTargetAlt:
	ld a, [$c4b4] ; $6df4
	and a, a ; $6df7
	ret z ; $6df8
	ld a, $01 ; $6df9
	ld [$c78e], a ; $6dfb
	ld hl, $dd1e ; $6dfe
	ld a, [hl+] ; $6e01
	ld d, [hl] ; $6e02
	ld e, a ; $6e03
	ld hl, $dcf6 ; $6e04
	ld a, [hl+] ; $6e07
	ld h, [hl] ; $6e08
	ld l, a ; $6e09
	ld a, l ; $6e0a
	sub a, e ; $6e0b
	ld l, a ; $6e0c
	ld a, h ; $6e0d
	sbc a, d ; $6e0e
	ld h, a ; $6e0f
	bit 7, h ; $6e10
	jr z, Label_0a_6e3f ; $6e12
	ld de, $0400 ; $6e14
	add hl, de ; $6e17
	bit 7, h ; $6e18
	jr nz, Label_0a_6e3f ; $6e1a
	ld hl, $dd20 ; $6e1c
	ld a, [hl+] ; $6e1f
	ld d, [hl] ; $6e20
	ld e, a ; $6e21
	ld hl, $dcf8 ; $6e22
	ld a, [hl+] ; $6e25
	ld h, [hl] ; $6e26
	ld l, a ; $6e27
	ld a, l ; $6e28
	sub a, e ; $6e29
	ld l, a ; $6e2a
	ld a, h ; $6e2b
	sbc a, d ; $6e2c
	ld h, a ; $6e2d
	bit 7, h ; $6e2e
	jr z, Label_0a_6e3f ; $6e30
	ld de, $0400 ; $6e32
	add hl, de ; $6e35
	bit 7, h ; $6e36
	jr nz, Label_0a_6e3f ; $6e38
	ld hl, $dcf0 ; $6e3a
	set 2, [hl] ; $6e3d
Label_0a_6e3f:
	ret ; $6e3f
	INCBIN "data/bank_00a/d_6e40.bin" ; $6e40, 52 bytes
RunEndingCreditsSequence:
	ld c, $04 ; $6e74
	call BeginFadeOut ; $6e76
	call WaitFadeEnd ; $6e79
	set_flag $0d, 6 ; $6e7c
	sound $2c ; $6e7f
	farcall FarPtr_01_0a ; $6e81
	ld hl, $6e6c ; $6e84
	ld de, $0001 ; $6e87
	call LoadPalettesMasterOnly ; $6e8a
	xor a, a ; $6e8d
	ld [$cb00], a ; $6e8e
Label_0a_6e91:
	call ClearFrameTasks ; $6e91
	ld a, [$cb00] ; $6e94
	add a, a ; $6e97
	add a, $40 ; $6e98
	ld l, a ; $6e9a
	adc a, $6e ; $6e9b
	sub a, l ; $6e9d
	ld h, a ; $6e9e
	ld a, [hl+] ; $6e9f
	cp a, $ff ; $6ea0
	jr z, Label_0a_6f03 ; $6ea2
	and a, a ; $6ea4
	jr nz, Label_0a_6eac ; $6ea5
	ld a, [wStoryModeMainCharacterOverworldSprite] ; $6ea7
	add a, a ; $6eaa
	ld a, [hl+] ; $6eab
Label_0a_6eac:
	ld [wStoryModeCurrentLocation], a ; $6eac
	ld a, [hl+] ; $6eaf
	ld [wStoryModeEntryPoint], a ; $6eb0
	clear_flag $03, 0 ; $6eb3
	clear_flag $0d, 7 ; $6eb6
	xor a, a ; $6eb9
	ld [$cb02], a ; $6eba
	ld [$cb03], a ; $6ebd
	call RunStoryLocation ; $6ec0
	test_flag $0d, 5 ; $6ec3
	jr nz, Label_0a_6ee3 ; $6ec6
	set_flag $03, 0 ; $6ec8
	call FreezeAllActors ; $6ecb
	farcall FarPtr_03_40 ; $6ece
	ld b, $3f ; $6ed1
	ld c, $ff ; $6ed3
	ld d, $1e ; $6ed5
	farcall FarPtr_03_42 ; $6ed7
	farcall FarPtr_03_44 ; $6eda
	ld a, [$cb00] ; $6edd
	farcall FarPtr_03_3c ; $6ee0
Label_0a_6ee3:
	clear_flag $0d, 5 ; $6ee3
	ld c, $04 ; $6ee6
	call BeginFadeOut ; $6ee8
	call WaitFadeEnd ; $6eeb
	ld a, $90 ; $6eee
	ldh [rWY], a ; $6ef0
	ld hl, $cb00 ; $6ef2
	inc [hl] ; $6ef5
	ldh a, [hDebugStepMode] ; $6ef6
	or a, a ; $6ef8
	jr z, Label_0a_6f01 ; $6ef9
	ldh a, [hPlayerInputFlags] ; $6efb
	bit 2, a ; $6efd
	jr nz, Label_0a_6f03 ; $6eff
Label_0a_6f01:
	jr Label_0a_6e91 ; $6f01
Label_0a_6f03:
	farcall FarPtr_03_3e ; $6f03
	ld c, $08 ; $6f06
	call BeginFadeOut ; $6f08
	call WaitFadeEnd ; $6f0b
	xor a, a ; $6f0e
	ldh [hScrollX], a ; $6f0f
	ldh [hScrollY], a ; $6f11
	farcall FarPtr_01_0a ; $6f13
	clear_flag $0d, 6 ; $6f16
	clear_flag $0d, 7 ; $6f19
	ret ; $6f1c
FreezeAllActors:
	wram_bank $04 ; $6f1d
	ld de, $d000 ; $6f23
	ld c, $18 ; $6f26
Label_0a_6f28:
	inc e ; $6f28
	ld a, [de] ; $6f29
	dec e ; $6f2a
	or a, a ; $6f2b
	jp z, Label_0a_6f37 ; $6f2c
	ld hl, $0005 ; $6f2f
	add hl, de ; $6f32
	set 0, [hl] ; $6f33
	set 1, [hl] ; $6f35
Label_0a_6f37:
	ld hl, $0040 ; $6f37
	add hl, de ; $6f3a
	ld e, l ; $6f3b
	ld d, h ; $6f3c
	dec c ; $6f3d
	jp nz, Label_0a_6f28 ; $6f3e
	set_flag $0d, 7 ; $6f41
	ret ; $6f44
	INCBIN "data/bank_00a/d_6f45.bin" ; $6f45, 4 bytes
	ds 4279, $ff ; $6f49, fill
