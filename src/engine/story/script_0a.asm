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
	push_wram_bank WRAM_TEXT ; $40d4
	pop_wram_bank ; $40dd
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
	push_wram_bank WRAM_ACTORS ; $4122
	ld a, [wActors + 20] ; $412b
	ld [wPlayerMoveAngle], a ; $412e
	pop_wram_bank ; $4131
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
	push_wram_bank WRAM_TEXT ; $4157
	farcall SetActiveWindowTextId ; $4160
	ld a, l ; $4163
	ld [wScriptDialogueTextId], a ; $4164
	ld a, h ; $4167
	ld [wScriptDialogueTextId + 1], a ; $4168
	pop_wram_bank ; $416b
	pop af ; $4170
	ret ; $4171
AdvanceDialogueTextCursor:
	push af ; $4172
	push hl ; $4173
	push de ; $4174
	push_wram_bank WRAM_TEXT ; $4175
	ld hl, wScriptDialogueTextId ; $417e
	ld a, [hl+] ; $4181
	ld d, [hl] ; $4182
	ld e, a ; $4183
	inc de ; $4184
	dec hl ; $4185
	ld a, e ; $4186
	ld [hl+], a ; $4187
	ld [hl], d ; $4188
	pop_wram_bank ; $4189
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
	wram_bank WRAM_TEXT ; $419b
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
	pop_wram_bank ; $41b9
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
	wram_bank WRAM_TEXT ; $41ca
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
	pop_wram_bank ; $41ea
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
	push_wram_bank WRAM_TEXT ; $41f9
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
	pop_wram_bank ; $422d
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
	wram_bank WRAM_ACTORS ; $4262
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
	pop_wram_bank ; $427f
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
	push_wram_bank WRAM_TEXT ; $42eb
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
	pop_wram_bank ; $430a
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
	wram_bank WRAM_ACTORS ; $4326
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
	wram_bank WRAM_ACTORS ; $433f
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
	wram_bank WRAM_ACTORS ; $4355
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
	wram_bank WRAM_ACTORS ; $438e
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
	wram_bank WRAM_ACTORS ; $43cc
	call SetActorPositionRaw ; $43d2
.done:
	add sp, 4 ; $43d5
	ret ; $43d7
