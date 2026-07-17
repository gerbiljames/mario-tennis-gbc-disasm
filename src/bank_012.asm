SECTION "ROM Bank $12", ROMX[$4000], BANK[$12]

DataPtr_StoryCmdHandlersA_12:
	dw StoryCmdHandlersA_12 ; $4000
DataPtr_WallPracticeRoomStoryCmds_12:
	dw WallPracticeRoomStoryCmds_12 ; $4002
DataPtr_SeniorCourtStoryCmds_12:
	dw SeniorCourtStoryCmds_12 ; $4004
StoryCmdHandlersA_12:
	; $4006, 14 bytes (records:2)
; 7 records x 2 bytes
	dw $4056 ; record 0
	dw $40fb ; record 1
	dw $4014 ; record 2
	dw $4114 ; record 3
	dw $4115 ; record 4
	dw $4116 ; record 5
	dw $4170 ; record 6
	; $4014, 66 bytes (bytes:14)
	db $00, $00, $89, $7a, $00, $01, $00, $01, $40, $00, $49, $01, $00, $00 ; 0x00
	db $00, $00, $89, $7a, $00, $01, $00, $01, $40, $00, $29, $01, $00, $00 ; 0x0e
	db $00, $00, $89, $7a, $00, $01, $00, $01, $40, $00, $4c, $01, $00, $00 ; 0x1c
	db $00, $00, $89, $7a, $00, $01, $00, $01, $40, $00, $4d, $01, $00, $00 ; 0x2a
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $ff ; 0x38
	; $4056, 25 bytes (bytes:16)
	db $01, $c0, $00, $16, $00, $1b, $b5, $40, $02, $40, $00, $16, $00, $0d, $6f, $40 ; 0x00
	db $0f, $c0, $00, $16, $00, $1b, $00, $00, $ff ; 0x10
	ld a, [$c295] ; $406f
	cp a, $ff ; $4072
	jp z, Label_12_40b4 ; $4074
	test_flag $05, 7 ; $4077
	jr z, Label_12_40a2 ; $407a
	ld a, $02 ; $407c
	ld bc, $00ff ; $407e
	farcall FarPtr_ScriptSetActorMoveSpeed ; $4081
	ld a, $02 ; $4084
	ld b, $c0 ; $4086
	ld de, $0200 ; $4088
	farcall FarPtr_MoveActorByAngle ; $408b
	ld a, $02 ; $408e
	farcall FarPtr_ScriptWaitActorMoveDone ; $4090
	ld a, $02 ; $4093
	ld b, $40 ; $4095
	farcall FarPtr_SetActorFacing ; $4097
	ld a, $02 ; $409a
	ld bc, $0010 ; $409c
	farcall FarPtr_ScriptSetActorMoveSpeed ; $409f
Label_12_40a2:
	ld a, $00 ; $40a2
	ld bc, $0010 ; $40a4
	farcall FarPtr_ScriptSetActorMoveSpeed ; $40a7
	ld a, $00 ; $40aa
	ld b, $40 ; $40ac
	ld de, $0200 ; $40ae
	farcall FarPtr_MoveActorByAngle ; $40b1
Label_12_40b4:
	ret ; $40b4
	ld a, [$c295] ; $40b5
	cp a, $ff ; $40b8
	jp z, Label_12_40fa ; $40ba
	test_flag $05, 7 ; $40bd
	jr z, Label_12_40e8 ; $40c0
	ld a, $02 ; $40c2
	ld bc, $00ff ; $40c4
	farcall FarPtr_ScriptSetActorMoveSpeed ; $40c7
	ld a, $02 ; $40ca
	ld b, $40 ; $40cc
	ld de, $0200 ; $40ce
	farcall FarPtr_MoveActorByAngle ; $40d1
	ld a, $02 ; $40d4
	farcall FarPtr_ScriptWaitActorMoveDone ; $40d6
	ld a, $02 ; $40d9
	ld b, $c0 ; $40db
	farcall FarPtr_SetActorFacing ; $40dd
	ld a, $02 ; $40e0
	ld bc, $0010 ; $40e2
	farcall FarPtr_ScriptSetActorMoveSpeed ; $40e5
Label_12_40e8:
	ld a, $00 ; $40e8
	ld bc, $0010 ; $40ea
	farcall FarPtr_ScriptSetActorMoveSpeed ; $40ed
	ld a, $00 ; $40f0
	ld b, $c0 ; $40f2
	ld de, $0200 ; $40f4
	farcall FarPtr_MoveActorByAngle ; $40f7
Label_12_40fa:
	ret ; $40fa
	; $40fb, 27 bytes (records:8)
; 3 records x 8 bytes
	dw $ff01, $0000, $7ab1, $020a ; record 0
	dw $ff03, $0000, $7ab1, $0108 ; record 1
	dw $ff0f, $0000, $7ab1, $0f0a ; record 2
	db $ff, $ff, $ff
	; $4116, 9 bytes (records:8)
; 1 records x 8 bytes
	dw $ff01, $0000, $411f, $0000 ; record 0
	db $ff
	ld a, $00 ; $411f
	ld b, $00 ; $4121
	farcall FarPtr_SetActorActive ; $4123
	ld a, $00 ; $4126
	ld bc, $1600 ; $4128
	ld de, $0900 ; $412b
	farcall FarPtr_ScriptSetActorMoveTarget ; $412e
	ld a, $00 ; $4131
	farcall FarPtr_ScriptWaitActorMoveDone ; $4133
	ld bc, $0010 ; $4136
	farcall FarPtr_SetPlayerMoveSpeed ; $4139
	xor a, a ; $413c
	ld bc, $1600 ; $413d
	ld de, $0800 ; $4140
	farcall FarPtr_MovePlayerToPosition ; $4143
	push af ; $4146
	ld a, $0f ; $4147
	farcall FarPtr_WaitScriptFrames ; $4149
	pop af ; $414c
	ld c, $04 ; $414d
	call BeginFadeOut ; $414f
	farcall FarPtr_WaitPlayerMoveDone ; $4152
	call WaitFadeEnd ; $4155
	ld a, [$c90d] ; $4158
	or a, a ; $415b
	jr nz, Label_12_4167 ; $415c
	ld a, $01 ; $415e
	ld [$c294], a ; $4160
	ld [$c2a1], a ; $4163
	ret ; $4166
Label_12_4167:
	ld a, $01 ; $4167
	ld [$c294], a ; $4169
	ld [$c2a1], a ; $416c
	ret ; $416f
	ld a, [$c295] ; $4170
	cp a, $0f ; $4173
	call z, Func_12_4179 ; $4175
	ret ; $4178
Func_12_4179:
	ld a, $03 ; $4179
	ld bc, $0010 ; $417b
	farcall FarPtr_ScriptSetActorMoveSpeed ; $417e
	ld a, $04 ; $4181
	ld bc, $0010 ; $4183
	farcall FarPtr_ScriptSetActorMoveSpeed ; $4186
	ld a, $00 ; $4189
	ld bc, $0010 ; $418b
	farcall FarPtr_ScriptSetActorMoveSpeed ; $418e
	ld bc, $0010 ; $4191
	farcall FarPtr_SetPlayerMoveSpeed ; $4194
	ld a, $00 ; $4197
	ld bc, $1600 ; $4199
	ld de, $1f00 ; $419c
	farcall FarPtr_ScriptSetActorPosition ; $419f
	ld a, $03 ; $41a2
	ld bc, $1600 ; $41a4
	ld de, $1d00 ; $41a7
	farcall FarPtr_ScriptSetActorPosition ; $41aa
	ld a, $03 ; $41ad
	ld b, $c0 ; $41af
	farcall FarPtr_SetActorFacing ; $41b1
	ld c, $20 ; $41b4
	call BeginFadeIn ; $41b6
	push af ; $41b9
	ld a, $14 ; $41ba
	farcall FarPtr_WaitScriptFrames ; $41bc
	pop af ; $41bf
	ld a, $03 ; $41c0
	ld bc, $1600 ; $41c2
	ld de, $1100 ; $41c5
	farcall FarPtr_ScriptSetActorMoveTarget ; $41c8
	xor a, a ; $41cb
	ld bc, $1600 ; $41cc
	ld de, $0f00 ; $41cf
	farcall FarPtr_MovePlayerToPosition ; $41d2
	ld a, $00 ; $41d5
	ld bc, $1600 ; $41d7
	ld de, $1400 ; $41da
	farcall FarPtr_ScriptSetActorMoveTarget ; $41dd
	ld a, $00 ; $41e0
	farcall FarPtr_ScriptWaitActorMoveDone ; $41e2
	ld a, $03 ; $41e5
	ld bc, $1600 ; $41e7
	ld de, $1100 ; $41ea
	farcall FarPtr_ScriptSetActorMoveTarget ; $41ed
	ld a, $00 ; $41f0
	ld bc, $1600 ; $41f2
	ld de, $1300 ; $41f5
	farcall FarPtr_ScriptSetActorMoveTarget ; $41f8
	ld a, $00 ; $41fb
	farcall FarPtr_ScriptWaitActorMoveDone ; $41fd
	push af ; $4200
	ld a, $14 ; $4201
	farcall FarPtr_WaitScriptFrames ; $4203
	pop af ; $4206
	ld a, $03 ; $4207
	farcall FarPtr_ScriptWaitActorMoveDone ; $4209
	ld a, $00 ; $420c
	ld b, a ; $420e
	ld a, $03 ; $420f
	farcall FarPtr_FaceActorTowardActor ; $4211
	ld hl, $044a ; $4214
	farcall FarPtr_InitDialogueTextCursor ; $4217
	ld a, $03 ; $421a
	farcall FarPtr_ScriptShowSpeakerDialogue ; $421c
	ld a, $03 ; $421f
	ld d, $03 ; $4221
	farcall FarPtr_ScriptSetActorAnimation ; $4223
	ld a, $03 ; $4226
	farcall FarPtr_ScriptWaitActorIdle ; $4228
	ld a, $03 ; $422b
	farcall FarPtr_ScriptShowSpeakerDialogue ; $422d
	ld a, $00 ; $4230
	ld d, $02 ; $4232
	farcall FarPtr_ScriptSetActorAnimation ; $4234
	ld bc, $0018 ; $4237
	farcall FarPtr_SetPlayerMoveSpeed ; $423a
	xor a, a ; $423d
	ld bc, $1600 ; $423e
	ld de, $0b00 ; $4241
	farcall FarPtr_MovePlayerToPosition ; $4244
	farcall FarPtr_WaitPlayerMoveDone ; $4247
	push af ; $424a
	ld a, $14 ; $424b
	farcall FarPtr_WaitScriptFrames ; $424d
	pop af ; $4250
	xor a, a ; $4251
	ld bc, $1100 ; $4252
	ld de, $0b00 ; $4255
	farcall FarPtr_MovePlayerToPosition ; $4258
	farcall FarPtr_WaitPlayerMoveDone ; $425b
	push af ; $425e
	ld a, $0a ; $425f
	farcall FarPtr_WaitScriptFrames ; $4261
	pop af ; $4264
	xor a, a ; $4265
	ld bc, $1a00 ; $4266
	ld de, $0b00 ; $4269
	farcall FarPtr_MovePlayerToPosition ; $426c
	farcall FarPtr_WaitPlayerMoveDone ; $426f
	push af ; $4272
	ld a, $0a ; $4273
	farcall FarPtr_WaitScriptFrames ; $4275
	pop af ; $4278
	xor a, a ; $4279
	ld bc, $1600 ; $427a
	ld de, $0b00 ; $427d
	farcall FarPtr_MovePlayerToPosition ; $4280
	farcall FarPtr_WaitPlayerMoveDone ; $4283
	push af ; $4286
	ld a, $1e ; $4287
	farcall FarPtr_WaitScriptFrames ; $4289
	pop af ; $428c
	xor a, a ; $428d
	ld bc, $1600 ; $428e
	ld de, $1000 ; $4291
	farcall FarPtr_MovePlayerToPosition ; $4294
	ld a, $00 ; $4297
	ld d, $02 ; $4299
	farcall FarPtr_ScriptSetActorAnimation ; $429b
	ld a, $00 ; $429e
	farcall FarPtr_ScriptWaitActorIdle ; $42a0
	push af ; $42a3
	ld a, $14 ; $42a4
	farcall FarPtr_WaitScriptFrames ; $42a6
	pop af ; $42a9
	ld bc, $0010 ; $42aa
	farcall FarPtr_SetPlayerMoveSpeed ; $42ad
	ld a, $05 ; $42b0
	ld bc, $1780 ; $42b2
	ld de, $0f00 ; $42b5
	farcall FarPtr_ScriptSetActorPosition ; $42b8
	sound $97 ; $42bb
	ld a, $03 ; $42bd
	ld d, $02 ; $42bf
	farcall FarPtr_ScriptSetActorAnimation ; $42c1
	ld a, $03 ; $42c4
	farcall FarPtr_ScriptWaitActorIdle ; $42c6
	ld a, $05 ; $42c9
	ld bc, $0100 ; $42cb
	ld de, $0100 ; $42ce
	farcall FarPtr_ScriptSetActorPosition ; $42d1
	ld a, $03 ; $42d4
	farcall FarPtr_ScriptShowSpeakerDialogue ; $42d6
	ld a, $03 ; $42d9
	ld bc, $1600 ; $42db
	ld de, $0b00 ; $42de
	farcall FarPtr_ScriptSetActorMoveTarget ; $42e1
	ld a, $03 ; $42e4
	farcall FarPtr_ScriptWaitActorMoveDone ; $42e6
	ld a, $04 ; $42e9
	ld bc, $1700 ; $42eb
	ld de, $0b00 ; $42ee
	farcall FarPtr_ScriptSetActorPosition ; $42f1
	push af ; $42f4
	ld a, $a0 ; $42f5
	farcall FarPtr_WaitScriptFrames ; $42f7
	pop af ; $42fa
	ld a, $00 ; $42fb
	ld bc, $1600 ; $42fd
	ld de, $1500 ; $4300
	farcall FarPtr_ScriptSetActorMoveTarget ; $4303
	ld a, $00 ; $4306
	farcall FarPtr_ScriptWaitActorMoveDone ; $4308
	ld a, $00 ; $430b
	ld b, $40 ; $430d
	farcall FarPtr_SetActorFacing ; $430f
	push af ; $4312
	ld a, $14 ; $4313
	farcall FarPtr_WaitScriptFrames ; $4315
	pop af ; $4318
	ld a, $00 ; $4319
	ld d, $04 ; $431b
	farcall FarPtr_ScriptSetActorAnimation ; $431d
	ld a, $00 ; $4320
	farcall FarPtr_ScriptWaitActorIdle ; $4322
	ld a, $00 ; $4325
	ld b, $c0 ; $4327
	farcall FarPtr_SetActorFacing ; $4329
	push af ; $432c
	ld a, $a0 ; $432d
	farcall FarPtr_WaitScriptFrames ; $432f
	pop af ; $4332
	ld a, $00 ; $4333
	ld b, $40 ; $4335
	farcall FarPtr_SetActorFacing ; $4337
	push af ; $433a
	ld a, $14 ; $433b
	farcall FarPtr_WaitScriptFrames ; $433d
	pop af ; $4340
	ld a, $00 ; $4341
	ld d, $04 ; $4343
	farcall FarPtr_ScriptSetActorAnimation ; $4345
	ld a, $00 ; $4348
	farcall FarPtr_ScriptWaitActorIdle ; $434a
	push af ; $434d
	ld a, $14 ; $434e
	farcall FarPtr_WaitScriptFrames ; $4350
	pop af ; $4353
	ld a, $03 ; $4354
	ld b, $00 ; $4356
	farcall FarPtr_SetActorActive ; $4358
	ld a, $03 ; $435b
	ld bc, $1700 ; $435d
	ld de, $1900 ; $4360
	farcall FarPtr_ScriptSetActorPosition ; $4363
	ld a, $03 ; $4366
	farcall FarPtr_ScriptShowSpeakerDialogue ; $4368
	ld a, $00 ; $436b
	ld bc, $1680 ; $436d
	ld de, $1200 ; $4370
	farcall FarPtr_ScriptSetActorMoveTarget ; $4373
	ld a, $00 ; $4376
	ld de, $ff80 ; $4378
	farcall FarPtr_ScriptSetActorJumpVelocity ; $437b
	ld a, $00 ; $437e
	farcall FarPtr_ScriptWaitActorJumpDone ; $4380
	ld a, $00 ; $4383
	ld b, $c0 ; $4385
	farcall FarPtr_SetActorFacing ; $4387
	ld a, $03 ; $438a
	ld b, $02 ; $438c
	farcall FarPtr_SetActorActive ; $438e
	ld a, $03 ; $4391
	ld bc, $1500 ; $4393
	ld de, $0b00 ; $4396
	farcall FarPtr_ScriptSetActorPosition ; $4399
	ld a, [$c94d] ; $439c
	or a, a ; $439f
	jr nz, Label_12_43bb ; $43a0
	ld hl, $045c ; $43a2
	farcall FarPtr_InitDialogueTextCursor ; $43a5
	ld d, $28 ; $43a8
	ld a, $04 ; $43aa
	farcall FarPtr_GetActorStateAddr ; $43ac
	ld c, l ; $43af
	ld b, h ; $43b0
	farcall FarPtr_04_2c ; $43b1
	ld a, $04 ; $43b4
	ld d, $01 ; $43b6
	farcall FarPtr_ScriptSetActorAnimation ; $43b8
Label_12_43bb:
	ld a, $03 ; $43bb
	ld bc, $1500 ; $43bd
	ld de, $0f00 ; $43c0
	farcall FarPtr_ScriptSetActorMoveTarget ; $43c3
	ld a, $03 ; $43c6
	farcall FarPtr_ScriptWaitActorMoveDone ; $43c8
	ld a, $04 ; $43cb
	ld bc, $1700 ; $43cd
	ld de, $0f00 ; $43d0
	farcall FarPtr_ScriptSetActorMoveTarget ; $43d3
	ld a, $04 ; $43d6
	farcall FarPtr_ScriptWaitActorMoveDone ; $43d8
	ld a, $06 ; $43db
	ld bc, $1800 ; $43dd
	ld de, $1100 ; $43e0
	farcall FarPtr_ScriptSetActorPosition ; $43e3
	sound $98 ; $43e6
	push af ; $43e8
	ld a, $3c ; $43e9
	farcall FarPtr_WaitScriptFrames ; $43eb
	pop af ; $43ee
	ld a, $03 ; $43ef
	ld d, $04 ; $43f1
	farcall FarPtr_ScriptSetActorAnimation ; $43f3
	ld a, $03 ; $43f6
	farcall FarPtr_ScriptWaitActorIdle ; $43f8
	ld a, $06 ; $43fb
	ld bc, $0100 ; $43fd
	ld de, $0100 ; $4400
	farcall FarPtr_ScriptSetActorPosition ; $4403
	ld a, $03 ; $4406
	farcall FarPtr_ScriptShowSpeakerDialogue ; $4408
	ld a, $04 ; $440b
	ld b, a ; $440d
	ld a, $03 ; $440e
	farcall FarPtr_FaceActorTowardActor ; $4410
	push af ; $4413
	ld a, $3c ; $4414
	farcall FarPtr_WaitScriptFrames ; $4416
	pop af ; $4419
	ld a, $00 ; $441a
	ld b, a ; $441c
	ld a, $03 ; $441d
	farcall FarPtr_FaceActorTowardActor ; $441f
	ld a, $03 ; $4422
	farcall FarPtr_ScriptShowSpeakerDialogue ; $4424
	ld a, $04 ; $4427
	ld d, $03 ; $4429
	farcall FarPtr_ScriptSetActorAnimation ; $442b
	ld a, $04 ; $442e
	farcall FarPtr_ScriptWaitActorIdle ; $4430
	ld a, $04 ; $4433
	farcall FarPtr_ScriptShowSpeakerDialogue ; $4435
	ld a, $00 ; $4438
	ld d, $03 ; $443a
	farcall FarPtr_ScriptSetActorAnimation ; $443c
	ld a, $00 ; $443f
	farcall FarPtr_ScriptWaitActorIdle ; $4441
	push af ; $4444
	ld a, $14 ; $4445
	farcall FarPtr_WaitScriptFrames ; $4447
	pop af ; $444a
	ld a, $03 ; $444b
	ld d, $03 ; $444d
	farcall FarPtr_ScriptSetActorAnimation ; $444f
	ld a, $03 ; $4452
	farcall FarPtr_ScriptWaitActorIdle ; $4454
	ld a, $03 ; $4457
	farcall FarPtr_ScriptShowSpeakerDialogue ; $4459
	ld a, $03 ; $445c
	ld b, a ; $445e
	ld a, $04 ; $445f
	farcall FarPtr_FaceActorTowardActor ; $4461
	ld a, $04 ; $4464
	ld d, $04 ; $4466
	farcall FarPtr_ScriptSetActorAnimation ; $4468
	ld a, $04 ; $446b
	farcall FarPtr_ScriptWaitActorIdle ; $446d
	ld a, $04 ; $4470
	farcall FarPtr_ScriptShowSpeakerDialogue ; $4472
	ld a, $04 ; $4475
	ld b, a ; $4477
	ld a, $03 ; $4478
	farcall FarPtr_FaceActorTowardActor ; $447a
	ld a, $03 ; $447d
	farcall FarPtr_ScriptShowSpeakerDialogue ; $447f
	ld a, $04 ; $4482
	ld d, $03 ; $4484
	farcall FarPtr_ScriptSetActorAnimation ; $4486
	ld a, $04 ; $4489
	farcall FarPtr_ScriptWaitActorIdle ; $448b
	ld a, $00 ; $448e
	ld b, a ; $4490
	ld a, $04 ; $4491
	farcall FarPtr_FaceActorTowardActor ; $4493
	ld a, $04 ; $4496
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $4498
	ld a, $00 ; $449b
	ld b, a ; $449d
	ld a, $03 ; $449e
	farcall FarPtr_FaceActorTowardActor ; $44a0
	farcall FarPtr_RunDialogueYesNoPrompt ; $44a3
	farcall FarPtr_ScriptCloseDialogueWindow ; $44a6
	push af ; $44a9
	ld a, $05 ; $44aa
	farcall FarPtr_WaitScriptFrames ; $44ac
	pop af ; $44af
	and a, a ; $44b0
	jr nz, Label_12_44bd ; $44b1
	ld a, $04 ; $44b3
	farcall FarPtr_ScriptShowSpeakerDialogue ; $44b5
	farcall FarPtr_AdvanceDialogueTextCursor ; $44b8
	jr Label_12_44c5 ; $44bb
Label_12_44bd:
	farcall FarPtr_AdvanceDialogueTextCursor ; $44bd
	ld a, $04 ; $44c0
	farcall FarPtr_ScriptShowSpeakerDialogue ; $44c2
Label_12_44c5:
	ld a, $03 ; $44c5
	ld d, $03 ; $44c7
	farcall FarPtr_ScriptSetActorAnimation ; $44c9
	ld a, $03 ; $44cc
	farcall FarPtr_ScriptWaitActorIdle ; $44ce
	ld a, $03 ; $44d1
	farcall FarPtr_ScriptShowSpeakerDialogue ; $44d3
	ld a, $04 ; $44d6
	ld d, $03 ; $44d8
	farcall FarPtr_ScriptSetActorAnimation ; $44da
	ld a, $04 ; $44dd
	farcall FarPtr_ScriptWaitActorIdle ; $44df
	ld a, $03 ; $44e2
	ld d, $02 ; $44e4
	farcall FarPtr_ScriptSetActorAnimation ; $44e6
	ld a, $03 ; $44e9
	farcall FarPtr_ScriptWaitActorIdle ; $44eb
	ld a, $03 ; $44ee
	farcall FarPtr_ScriptShowSpeakerDialogue ; $44f0
	ld a, $06 ; $44f3
	ld bc, $1800 ; $44f5
	ld de, $1100 ; $44f8
	farcall FarPtr_ScriptSetActorPosition ; $44fb
	sound $98 ; $44fe
	push af ; $4500
	ld a, $3c ; $4501
	farcall FarPtr_WaitScriptFrames ; $4503
	pop af ; $4506
	ld a, $06 ; $4507
	ld bc, $0100 ; $4509
	ld de, $0100 ; $450c
	farcall FarPtr_ScriptSetActorPosition ; $450f
	ld a, $04 ; $4512
	ld d, $03 ; $4514
	farcall FarPtr_ScriptSetActorAnimation ; $4516
	ld a, $04 ; $4519
	farcall FarPtr_ScriptWaitActorIdle ; $451b
	ld a, $04 ; $451e
	farcall FarPtr_ScriptShowSpeakerDialogue ; $4520
	ld a, $04 ; $4523
	ld b, a ; $4525
	ld a, $03 ; $4526
	farcall FarPtr_FaceActorTowardActor ; $4528
	push af ; $452b
	ld a, $1e ; $452c
	farcall FarPtr_WaitScriptFrames ; $452e
	pop af ; $4531
	ld a, $00 ; $4532
	ld b, a ; $4534
	ld a, $03 ; $4535
	farcall FarPtr_FaceActorTowardActor ; $4537
	push af ; $453a
	ld a, $1e ; $453b
	farcall FarPtr_WaitScriptFrames ; $453d
	pop af ; $4540
	ld a, $03 ; $4541
	ld d, $03 ; $4543
	farcall FarPtr_ScriptSetActorAnimation ; $4545
	ld a, $03 ; $4548
	farcall FarPtr_ScriptWaitActorIdle ; $454a
	ld hl, $045a ; $454d
	farcall FarPtr_InitDialogueTextCursor ; $4550
	ld a, $04 ; $4553
	farcall FarPtr_ScriptShowSpeakerDialogue ; $4555
	ld a, $03 ; $4558
	ld b, a ; $455a
	ld a, $04 ; $455b
	farcall FarPtr_FaceActorTowardActor ; $455d
	ld a, $00 ; $4560
	ld d, $03 ; $4562
	farcall FarPtr_ScriptSetActorAnimation ; $4564
	ld a, $04 ; $4567
	ld d, $03 ; $4569
	farcall FarPtr_ScriptSetActorAnimation ; $456b
	ld a, $04 ; $456e
	farcall FarPtr_ScriptWaitActorIdle ; $4570
	xor a, a ; $4573
	ld bc, $1600 ; $4574
	ld de, $1300 ; $4577
	farcall FarPtr_MovePlayerToPosition ; $457a
	ld a, $03 ; $457d
	ld bc, $1500 ; $457f
	ld de, $1300 ; $4582
	farcall FarPtr_ScriptSetActorMoveTarget ; $4585
	ld a, $03 ; $4588
	farcall FarPtr_ScriptWaitActorMoveDone ; $458a
	ld a, $04 ; $458d
	ld b, $40 ; $458f
	farcall FarPtr_SetActorFacing ; $4591
	ld a, $00 ; $4594
	ld b, $40 ; $4596
	farcall FarPtr_SetActorFacing ; $4598
	ld a, $03 ; $459b
	ld bc, $1500 ; $459d
	ld de, $1500 ; $45a0
	farcall FarPtr_ScriptSetActorMoveTarget ; $45a3
	ld a, $03 ; $45a6
	farcall FarPtr_ScriptWaitActorMoveDone ; $45a8
	ld a, $03 ; $45ab
	ld b, $c0 ; $45ad
	farcall FarPtr_SetActorFacing ; $45af
	ld a, $00 ; $45b2
	ld b, $40 ; $45b4
	farcall FarPtr_SetActorFacing ; $45b6
	ld a, $04 ; $45b9
	farcall FarPtr_ScriptShowSpeakerDialogue ; $45bb
	ld a, $00 ; $45be
	ld d, $03 ; $45c0
	farcall FarPtr_ScriptSetActorAnimation ; $45c2
	ld a, $04 ; $45c5
	ld d, $03 ; $45c7
	farcall FarPtr_ScriptSetActorAnimation ; $45c9
	ld a, $04 ; $45cc
	farcall FarPtr_ScriptWaitActorIdle ; $45ce
	ld a, $03 ; $45d1
	ld d, $03 ; $45d3
	farcall FarPtr_ScriptSetActorAnimation ; $45d5
	ld a, $03 ; $45d8
	farcall FarPtr_ScriptWaitActorIdle ; $45da
	ld a, $03 ; $45dd
	ld b, $40 ; $45df
	farcall FarPtr_SetActorFacing ; $45e1
	push af ; $45e4
	ld a, $1e ; $45e5
	farcall FarPtr_WaitScriptFrames ; $45e7
	pop af ; $45ea
	ld a, $03 ; $45eb
	ld bc, $1500 ; $45ed
	ld de, $1f00 ; $45f0
	farcall FarPtr_ScriptSetActorMoveTarget ; $45f3
	push af ; $45f6
	ld a, $78 ; $45f7
	farcall FarPtr_WaitScriptFrames ; $45f9
	pop af ; $45fc
	ld a, $00 ; $45fd
	ld b, a ; $45ff
	ld a, $04 ; $4600
	farcall FarPtr_FaceActorsTowardEachOther ; $4602
	ld a, $00 ; $4605
	ld d, $03 ; $4607
	farcall FarPtr_ScriptSetActorAnimation ; $4609
	ld a, $04 ; $460c
	ld d, $03 ; $460e
	farcall FarPtr_ScriptSetActorAnimation ; $4610
	ld a, $04 ; $4613
	farcall FarPtr_ScriptWaitActorIdle ; $4615
	xor a, a ; $4618
	ld bc, $1500 ; $4619
	ld de, $0f00 ; $461c
	farcall FarPtr_MovePlayerToPosition ; $461f
	ld a, $00 ; $4622
	ld bc, $1500 ; $4624
	ld de, $0f00 ; $4627
	farcall FarPtr_ScriptSetActorMoveTarget ; $462a
	ld a, $00 ; $462d
	farcall FarPtr_ScriptWaitActorMoveDone ; $462f
	ld a, $04 ; $4632
	ld bc, $1700 ; $4634
	ld de, $0b00 ; $4637
	farcall FarPtr_ScriptSetActorMoveTarget ; $463a
	ld a, $00 ; $463d
	ld bc, $1500 ; $463f
	ld de, $0b00 ; $4642
	farcall FarPtr_ScriptSetActorMoveTarget ; $4645
	ld a, $00 ; $4648
	farcall FarPtr_ScriptWaitActorMoveDone ; $464a
	xor a, a ; $464d
	ld bc, $1600 ; $464e
	ld de, $0b00 ; $4651
	farcall FarPtr_MovePlayerToPosition ; $4654
	ld b, $0a ; $4657
	ld c, $0f ; $4659
	farcall FarPtr_SaveStoryReturnPoint ; $465b
	farcall FarPtr_SaveStorySlotWithTimer ; $465e
	ld a, $01 ; $4661
	farcall FarPtr_EraseStorySlotSaveData ; $4663
	farcall FarPtr_SaveStorySlotWithTimer ; $4666
	sound $00 ; $4669
	ld c, $04 ; $466b
	call BeginFadeOut ; $466d
	call WaitFadeEnd ; $4670
	ld a, $0f ; $4673
	ld [$c294], a ; $4675
	ld [$c2a1], a ; $4678
	ret ; $467b
WallPracticeRoomStoryCmds_12:
	; $467c, 14 bytes (records:2)
	dw $46da ; record 0
	dw $4716 ; record 1
	dw $468a ; record 2
	dw $4818 ; record 3
	dw $4ca0 ; record 4
	dw $4cc0 ; record 5
	dw $4f03 ; record 6
	; $468a, 80 bytes (bytes:14)
	db $00, $00, $89, $7a, $00, $03, $00, $39, $00, $00, $39, $01, $00, $00 ; 0x00
	db $00, $00, $89, $7a, $00, $08, $00, $37, $c0, $00, $32, $01, $00, $00 ; 0x0e
	db $00, $00, $89, $7a, $00, $0d, $00, $37, $c0, $00, $30, $01, $00, $00 ; 0x1c
	db $00, $00, $89, $7a, $00, $13, $00, $39, $00, $00, $3e, $01, $00, $00 ; 0x2a
	db $00, $00, $89, $7a, $00, $05, $00, $37, $40, $00, $3d, $01, $00, $00 ; 0x38
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $ff ; 0x46
	; $46da, 25 bytes (bytes:16)
	db $01, $c0, $00, $0f, $00, $39, $f3, $46, $0a, $c0, $00, $0c, $00, $31, $00, $00 ; 0x00
	db $0b, $c0, $00, $0c, $00, $31, $00, $00, $ff ; 0x10
	ld a, [$c295] ; $46f3
	cp a, $ff ; $46f6
	jp z, Label_12_4715 ; $46f8
	clear_flag $0f, 5 ; $46fb
	test_flag $05, 7 ; $46fe
	jr z, Label_12_4715 ; $4701
	ld a, $02 ; $4703
	ld bc, $0f00 ; $4705
	ld de, $3b00 ; $4708
	farcall FarPtr_ScriptSetActorPosition ; $470b
	ld a, $02 ; $470e
	ld b, $c0 ; $4710
	farcall FarPtr_SetActorFacing ; $4712
Label_12_4715:
	ret ; $4715
	; $4716, 9 bytes (records:8)
; 1 records x 8 bytes
	dw $ff05, $0000, $7ab1, $0211 ; record 0
	db $ff
	ld a, [$c2b0] ; $471f
	add a, a ; $4722
	add a, $73 ; $4723
	ld l, a ; $4725
	adc a, $47 ; $4726
	sub a, l ; $4728
	ld h, a ; $4729
	ld a, [hl+] ; $472a
	ld h, [hl] ; $472b
	ld l, a ; $472c
	farcall FarPtr_InitDialogueTextCursor ; $472d
	ld a, [$c2b0] ; $4730
	ld a, a ; $4733
	rst Rst00 ; $4734
	dw Label_12_4743 ; $4735 jumptable
	dw Label_12_475b ; $4737 jumptable
	dw Label_12_4743 ; $4739 jumptable
	dw Label_12_4743 ; $473b jumptable
	dw Label_12_4761 ; $473d jumptable
	dw Label_12_4761 ; $473f jumptable
	dw Label_12_475b ; $4741 jumptable
Label_12_4743:
	ld a, $03 ; $4743
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $4745
	farcall FarPtr_RunDialogueYesNoPrompt ; $4748
	farcall FarPtr_ScriptCloseDialogueWindow ; $474b
	push af ; $474e
	ld a, $05 ; $474f
	farcall FarPtr_WaitScriptFrames ; $4751
	pop af ; $4754
	and a, a ; $4755
	jr z, Label_12_475b ; $4756
	farcall FarPtr_AdvanceDialogueTextCursor ; $4758
Label_12_475b:
	ld a, $03 ; $475b
	farcall FarPtr_ScriptShowSpeakerDialogue ; $475d
	ret ; $4760
Label_12_4761:
	ld a, $03 ; $4761
	ld d, $02 ; $4763
	farcall FarPtr_ScriptSetActorAnimation ; $4765
	ld a, $03 ; $4768
	farcall FarPtr_ScriptWaitActorIdle ; $476a
	ld a, $03 ; $476d
	farcall FarPtr_ScriptShowSpeakerDialogue ; $476f
	ret ; $4772
	; $4773, 14 bytes (records:2)
	dw $14e7 ; record 0
	dw $1500 ; record 1
	dw $150a ; record 2
	dw $1808 ; record 3
	dw $1815 ; record 4
	dw $1815 ; record 5
	dw $182c ; record 6
	ld a, [$c2b0] ; $4781
	add a, a ; $4784
	add a, $98 ; $4785
	ld l, a ; $4787
	adc a, $47 ; $4788
	sub a, l ; $478a
	ld h, a ; $478b
	ld a, [hl+] ; $478c
	ld h, [hl] ; $478d
	ld l, a ; $478e
	farcall FarPtr_InitDialogueTextCursor ; $478f
	ld a, $04 ; $4792
	farcall FarPtr_ScriptShowSpeakerDialogue ; $4794
	ret ; $4797
	; $4798, 14 bytes (records:2)
	dw $14ea ; record 0
	dw $1501 ; record 1
	dw $150d ; record 2
	dw $180b ; record 3
	dw $1816 ; record 4
	dw $1816 ; record 5
	dw $182d ; record 6
	ld a, [$c2b0] ; $47a6
	add a, a ; $47a9
	add a, $e5 ; $47aa
	ld l, a ; $47ac
	adc a, $47 ; $47ad
	sub a, l ; $47af
	ld h, a ; $47b0
	ld a, [hl+] ; $47b1
	ld h, [hl] ; $47b2
	ld l, a ; $47b3
	farcall FarPtr_InitDialogueTextCursor ; $47b4
	ld a, [$c2b0] ; $47b7
	cp a, $04 ; $47ba
	jr c, Label_12_47c4 ; $47bc
	ld a, $05 ; $47be
	farcall FarPtr_ScriptShowSpeakerDialogue ; $47c0
	ret ; $47c3
Label_12_47c4:
	ld a, $05 ; $47c4
	ld b, $c0 ; $47c6
	farcall FarPtr_SetActorFacing ; $47c8
	ld a, $05 ; $47cb
	farcall FarPtr_ScriptShowSpeakerDialogue ; $47cd
	ld a, $00 ; $47d0
	ld b, a ; $47d2
	ld a, $05 ; $47d3
	farcall FarPtr_FaceActorTowardActor ; $47d5
	ld a, $05 ; $47d8
	farcall FarPtr_ScriptShowSpeakerDialogue ; $47da
	ld a, $05 ; $47dd
	ld b, $c0 ; $47df
	farcall FarPtr_SetActorFacing ; $47e1
	ret ; $47e4
	; $47e5, 14 bytes (records:2)
	dw $14eb ; record 0
	dw $1502 ; record 1
	dw $150e ; record 2
	dw $180c ; record 3
	dw $1817 ; record 4
	dw $1817 ; record 5
	dw $182e ; record 6
	ld a, [$c2b0] ; $47f3
	add a, a ; $47f6
	add a, $0a ; $47f7
	ld l, a ; $47f9
	adc a, $48 ; $47fa
	sub a, l ; $47fc
	ld h, a ; $47fd
	ld a, [hl+] ; $47fe
	ld h, [hl] ; $47ff
	ld l, a ; $4800
	farcall FarPtr_InitDialogueTextCursor ; $4801
	ld a, $06 ; $4804
	farcall FarPtr_ScriptShowSpeakerDialogue ; $4806
	ret ; $4809
	; $480a, 14 bytes (records:2)
	dw $14ed ; record 0
	dw $1504 ; record 1
	dw $1510 ; record 2
	dw $180e ; record 3
	dw $1818 ; record 4
	dw $1818 ; record 5
	dw $182f ; record 6
	; $4818, 41 bytes (records:8)
; 5 records x 8 bytes
	dw $ff03, $0000, $471f, $0001 ; record 0
	dw $ff04, $0000, $4781, $0001 ; record 1
	dw $ff05, $0000, $47a6, $0001 ; record 2
	dw $ff06, $0000, $47f3, $0003 ; record 3
	dw $ff07, $0000, $50cc, $0001 ; record 4
	db $ff
WallPracticeMasterResultScript:
	ld c, $06 ; $4841
	call BeginFadeIn ; $4843
	call WaitFadeEnd ; $4846
	xor a, a ; $4849
	ld [$c2d5], a ; $484a
	test_flag $1b, 5 ; $484d
	jr z, WallPracticeScoreRetryPrompt ; $4850
	ld a, [wPointWinLoseFlag] ; $4852
	cp a, $01 ; $4855
	jr nz, WallPracticeScoreRetryPrompt ; $4857
	jp WallPracticeMaxScoreScript ; $4859
WallPracticeScoreRetryPrompt:
	ld c, $06 ; $485c
	call BeginFadeIn ; $485e
	call WaitFadeEnd ; $4861
	xor a, a ; $4864
	ld [$c2d5], a ; $4865
	ld hl, wMinigamesCurrentScore ; $4868
	ld a, [hl+] ; $486b
	ld b, [hl] ; $486c
	ld c, a ; $486d
	ldh a, [hWramBank] ; $486e
	push af ; $4870
	wram_bank $07 ; $4871
	ld a, $00 ; $4877
	farcall FarPtr_ReadMinigameRecord ; $4879
	ld hl, $de00 ; $487c
	ld a, [hl+] ; $487f
	ld d, [hl] ; $4880
	ld e, a ; $4881
	pop af ; $4882
	wram_bank ; $4883
	ld l, c ; $4887
	ld h, b ; $4888
	inc de ; $4889
	ld a, l ; $488a
	sub a, e ; $488b
	ld l, a ; $488c
	ld a, h ; $488d
	sbc a, d ; $488e
	ld h, a ; $488f
	jp nc, WallPracticeNewRecordScript ; $4890
	ld a, [wPointOutcome] ; $4893
	cp a, $09 ; $4896
	jr nz, Label_12_48a2 ; $4898
	ld hl, $14fa ; $489a
	farcall FarPtr_InitDialogueTextCursor ; $489d
	jr Label_12_48b5 ; $48a0
Label_12_48a2:
	ld a, [wPointOutcome] ; $48a2
	and a, $03 ; $48a5
	add a, a ; $48a7
	add a, $af ; $48a8
	ld l, a ; $48aa
	adc a, $4a ; $48ab
	sub a, l ; $48ad
	ld h, a ; $48ae
	ld a, [hl+] ; $48af
	ld h, [hl] ; $48b0
	ld l, a ; $48b1
	farcall FarPtr_InitDialogueTextCursor ; $48b2
Label_12_48b5:
	ld hl, wMinigamesCurrentScore ; $48b5
	ld a, [hl+] ; $48b8
	ld h, [hl] ; $48b9
	ld l, a ; $48ba
	farcall FarPtr_PushTextArgNumber ; $48bb
	ld a, $07 ; $48be
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $48c0
	farcall FarPtr_RunDialogueYesNoPrompt ; $48c3
	farcall FarPtr_ScriptCloseDialogueWindow ; $48c6
	push af ; $48c9
	ld a, $05 ; $48ca
	farcall FarPtr_WaitScriptFrames ; $48cc
	pop af ; $48cf
	and a, a ; $48d0
	jp nz, WallPracticeExitCourtScript ; $48d1
	ld a, $07 ; $48d4
	ld b, $c0 ; $48d6
	farcall FarPtr_SetActorFacing ; $48d8
	ld a, $07 ; $48db
	ld d, $02 ; $48dd
	farcall FarPtr_ScriptSetActorAnimation ; $48df
	ld a, $07 ; $48e2
	farcall FarPtr_ScriptWaitActorIdle ; $48e4
	jp LaunchWallPracticeMinigame ; $48e7
	ret ; $48ea
WallPracticeNewRecordScript:
	ldh a, [hWramBank] ; $48eb
	push af ; $48ed
	wram_bank $07 ; $48ee
	ld hl, wMinigamesCurrentScore ; $48f4
	ld a, [hl+] ; $48f7
	ld d, [hl] ; $48f8
	ld e, a ; $48f9
	ld hl, $de00 ; $48fa
	ld a, e ; $48fd
	ld [hl+], a ; $48fe
	ld [hl], d ; $48ff
	ld a, $00 ; $4900
	farcall FarPtr_UpdateMinigameRecord ; $4902
	pop af ; $4905
	wram_bank ; $4906
	call SetupWallPracticeLevelSigns ; $490a
	ld hl, $1828 ; $490d
	farcall FarPtr_InitDialogueTextCursor ; $4910
	ld hl, wMinigamesCurrentScore ; $4913
	ld a, [hl+] ; $4916
	ld h, [hl] ; $4917
	ld l, a ; $4918
	farcall FarPtr_PushTextArgNumber ; $4919
	ld a, $07 ; $491c
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $491e
	farcall FarPtr_RunDialogueYesNoPrompt ; $4921
	farcall FarPtr_ScriptCloseDialogueWindow ; $4924
	push af ; $4927
	ld a, $05 ; $4928
	farcall FarPtr_WaitScriptFrames ; $492a
	pop af ; $492d
	and a, a ; $492e
	jp nz, WallPracticeExitCourtScript ; $492f
	jp LaunchWallPracticeMinigame ; $4932
	ret ; $4935
WallPracticeMaxScoreScript:
	ld hl, $1829 ; $4936
	farcall FarPtr_InitDialogueTextCursor ; $4939
	ld a, $07 ; $493c
	farcall FarPtr_ScriptShowSpeakerDialogue ; $493e
	ldh a, [hWramBank] ; $4941
	push af ; $4943
	wram_bank $07 ; $4944
	ld a, $00 ; $494a
	farcall FarPtr_ReadMinigameRecord ; $494c
	ld hl, $de00 ; $494f
	ld a, [hl+] ; $4952
	ld h, [hl] ; $4953
	ld l, a ; $4954
	pop af ; $4955
	wram_bank ; $4956
	ld de, $270f ; $495a
	ld a, l ; $495d
	sub a, e ; $495e
	ld l, a ; $495f
	ld a, h ; $4960
	sbc a, d ; $4961
	ld h, a ; $4962
	jp c, Label_12_49e5 ; $4963
	ld hl, $182b ; $4966
	farcall FarPtr_InitDialogueTextCursor ; $4969
	ld a, $07 ; $496c
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $496e
	farcall FarPtr_RunDialogueYesNoPrompt ; $4971
	farcall FarPtr_ScriptCloseDialogueWindow ; $4974
	push af ; $4977
	ld a, $05 ; $4978
	farcall FarPtr_WaitScriptFrames ; $497a
	pop af ; $497d
	and a, a ; $497e
	jr z, RelaunchWallPracticeMasterLevel ; $497f
	ld a, $00 ; $4981
	ld bc, $0020 ; $4983
	farcall FarPtr_ScriptSetActorMoveSpeed ; $4986
	ld a, $00 ; $4989
	ld bc, $0500 ; $498b
	ld de, $3100 ; $498e
	farcall FarPtr_ScriptSetActorMoveTarget ; $4991
	ld a, $00 ; $4994
	farcall FarPtr_ScriptWaitActorMoveDone ; $4996
	xor a, a ; $4999
	ld bc, $0500 ; $499a
	ld de, $3700 ; $499d
	farcall FarPtr_MovePlayerToPosition ; $49a0
	ld a, $00 ; $49a3
	ld bc, $0500 ; $49a5
	ld de, $3900 ; $49a8
	farcall FarPtr_ScriptSetActorMoveTarget ; $49ab
	ld a, $00 ; $49ae
	farcall FarPtr_ScriptWaitActorMoveDone ; $49b0
	ld a, $07 ; $49b3
	ld bc, $0500 ; $49b5
	ld de, $3700 ; $49b8
	farcall FarPtr_ScriptSetActorMoveTarget ; $49bb
	ld a, $07 ; $49be
	farcall FarPtr_ScriptWaitActorMoveDone ; $49c0
	ld a, $07 ; $49c3
	ld b, $40 ; $49c5
	farcall FarPtr_SetActorFacing ; $49c7
	jp Label_12_4a6c ; $49ca
RelaunchWallPracticeMasterLevel:
	ld a, $13 ; $49cd
	ld [wStoryModeCurrentLocation], a ; $49cf
	ld a, $0a ; $49d2
	ld [$c295], a ; $49d4
	ld a, $ff ; $49d7
	ld [$c294], a ; $49d9
	ld [$c2a1], a ; $49dc
	ld a, $1b ; $49df
	farcall FarPtr_RunTrainingDrillByID ; $49e1
	ret ; $49e4
Label_12_49e5:
	ldh a, [hWramBank] ; $49e5
	push af ; $49e7
	wram_bank $07 ; $49e8
	ld hl, wMinigamesCurrentScore ; $49ee
	ld a, [hl+] ; $49f1
	ld d, [hl] ; $49f2
	ld e, a ; $49f3
	ld hl, $de00 ; $49f4
	ld a, e ; $49f7
	ld [hl+], a ; $49f8
	ld [hl], d ; $49f9
	ld a, $00 ; $49fa
	farcall FarPtr_UpdateMinigameRecord ; $49fc
	pop af ; $49ff
	wram_bank ; $4a00
	ld a, $00 ; $4a04
	ld bc, $0020 ; $4a06
	farcall FarPtr_ScriptSetActorMoveSpeed ; $4a09
	ld a, $00 ; $4a0c
	ld bc, $0500 ; $4a0e
	ld de, $3100 ; $4a11
	farcall FarPtr_ScriptSetActorMoveTarget ; $4a14
	ld a, $00 ; $4a17
	farcall FarPtr_ScriptWaitActorMoveDone ; $4a19
	xor a, a ; $4a1c
	ld bc, $0500 ; $4a1d
	ld de, $3700 ; $4a20
	farcall FarPtr_MovePlayerToPosition ; $4a23
	ld a, $00 ; $4a26
	ld bc, $0500 ; $4a28
	ld de, $3900 ; $4a2b
	farcall FarPtr_ScriptSetActorMoveTarget ; $4a2e
	ld a, $00 ; $4a31
	farcall FarPtr_ScriptWaitActorMoveDone ; $4a33
	ld a, $07 ; $4a36
	ld bc, $0500 ; $4a38
	ld de, $3700 ; $4a3b
	farcall FarPtr_ScriptSetActorMoveTarget ; $4a3e
	ld a, $07 ; $4a41
	farcall FarPtr_ScriptWaitActorMoveDone ; $4a43
	ld a, $07 ; $4a46
	ld b, $40 ; $4a48
	farcall FarPtr_SetActorFacing ; $4a4a
	ld a, $00 ; $4a4d
	ld b, $c0 ; $4a4f
	farcall FarPtr_SetActorFacing ; $4a51
	push af ; $4a54
	ld a, $32 ; $4a55
	farcall FarPtr_WaitScriptFrames ; $4a57
	pop af ; $4a5a
	ld a, $07 ; $4a5b
	ld d, $02 ; $4a5d
	farcall FarPtr_ScriptSetActorAnimation ; $4a5f
	ld a, $07 ; $4a62
	farcall FarPtr_ScriptWaitActorIdle ; $4a64
	ld a, $07 ; $4a67
	farcall FarPtr_ScriptShowSpeakerDialogue ; $4a69
Label_12_4a6c:
	test_flag $05, 7 ; $4a6c
	jr z, Label_12_4aae ; $4a6f
	push af ; $4a71
	ld a, $28 ; $4a72
	farcall FarPtr_WaitScriptFrames ; $4a74
	pop af ; $4a77
	ld a, $02 ; $4a78
	ld b, a ; $4a7a
	ld a, $00 ; $4a7b
	farcall FarPtr_FaceActorsTowardEachOther ; $4a7d
	push af ; $4a80
	ld a, $1e ; $4a81
	farcall FarPtr_WaitScriptFrames ; $4a83
	pop af ; $4a86
	ld a, $00 ; $4a87
	ld d, $03 ; $4a89
	farcall FarPtr_ScriptSetActorAnimation ; $4a8b
	ld a, $02 ; $4a8e
	ld d, $03 ; $4a90
	farcall FarPtr_ScriptSetActorAnimation ; $4a92
	ld a, $02 ; $4a95
	farcall FarPtr_ScriptWaitActorIdle ; $4a97
	ld a, $02 ; $4a9a
	farcall FarPtr_GetActorStateAddr ; $4a9c
	ld c, l ; $4a9f
	ld b, h ; $4aa0
	ld de, $d000 ; $4aa1
	farcall FarPtr_04_20 ; $4aa4
	push af ; $4aa7
	ld a, $28 ; $4aa8
	farcall FarPtr_WaitScriptFrames ; $4aaa
	pop af ; $4aad
Label_12_4aae:
	ret ; $4aae
	; $4aaf, 6 bytes (records:2)
	dw $14f7 ; record 0
	dw $14f8 ; record 1
	dw $14f9 ; record 2
WallPracticeLevelResultScript:
	xor a, a ; $4ab5
	ld [$c2d5], a ; $4ab6
	ld a, [wPointWinLoseFlag] ; $4ab9
	cp a, $01 ; $4abc
	jp nz, Label_12_4ad0 ; $4abe
	ld a, [$c2b0] ; $4ac1
	sub a, $01 ; $4ac4
	ld a, a ; $4ac6
	rst Rst00 ; $4ac7
	dw Label_12_4bee ; $4ac8 jumptable
	dw Label_12_4bde ; $4aca jumptable
	dw Label_12_4bb2 ; $4acc jumptable
	dw Label_12_4ba2 ; $4ace jumptable
Label_12_4ad0:
	ld a, [$c2b0] ; $4ad0
	cp a, $04 ; $4ad3
	jp z, WallPracticeScoreRetryPrompt ; $4ad5
	ld c, $06 ; $4ad8
	call BeginFadeIn ; $4ada
	call WaitFadeEnd ; $4add
	ld a, [wPointOutcome] ; $4ae0
	cp a, $09 ; $4ae3
	jr nz, Label_12_4aef ; $4ae5
	ld hl, $14f6 ; $4ae7
	farcall FarPtr_InitDialogueTextCursor ; $4aea
	jr Label_12_4b02 ; $4aed
Label_12_4aef:
	ld a, [wPointOutcome] ; $4aef
	and a, $03 ; $4af2
	add a, a ; $4af4
	add a, $9c ; $4af5
	ld l, a ; $4af7
	adc a, $4b ; $4af8
	sub a, l ; $4afa
	ld h, a ; $4afb
	ld a, [hl+] ; $4afc
	ld h, [hl] ; $4afd
	ld l, a ; $4afe
	farcall FarPtr_InitDialogueTextCursor ; $4aff
Label_12_4b02:
	ld a, $07 ; $4b02
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $4b04
	farcall FarPtr_RunDialogueYesNoPrompt ; $4b07
	farcall FarPtr_ScriptCloseDialogueWindow ; $4b0a
	push af ; $4b0d
	ld a, $05 ; $4b0e
	farcall FarPtr_WaitScriptFrames ; $4b10
	pop af ; $4b13
	and a, a ; $4b14
	jp nz, WallPracticeExitCourtScript ; $4b15
	ld a, $07 ; $4b18
	ld b, $c0 ; $4b1a
	farcall FarPtr_SetActorFacing ; $4b1c
	ld a, $07 ; $4b1f
	ld d, $02 ; $4b21
	farcall FarPtr_ScriptSetActorAnimation ; $4b23
	ld a, $07 ; $4b26
	farcall FarPtr_ScriptWaitActorIdle ; $4b28
	jp LaunchWallPracticeMinigame ; $4b2b
WallPracticeExitCourtScript:
	ld hl, $14fb ; $4b2e
	farcall FarPtr_InitDialogueTextCursor ; $4b31
	ld a, $07 ; $4b34
	farcall FarPtr_ScriptShowSpeakerDialogue ; $4b36
	ld a, $00 ; $4b39
	ld bc, $0020 ; $4b3b
	farcall FarPtr_ScriptSetActorMoveSpeed ; $4b3e
	ld a, $00 ; $4b41
	ld bc, $0500 ; $4b43
	ld de, $3100 ; $4b46
	farcall FarPtr_ScriptSetActorMoveTarget ; $4b49
	ld a, $00 ; $4b4c
	farcall FarPtr_ScriptWaitActorMoveDone ; $4b4e
	xor a, a ; $4b51
	ld bc, $0500 ; $4b52
	ld de, $3700 ; $4b55
	farcall FarPtr_MovePlayerToPosition ; $4b58
	ld a, $00 ; $4b5b
	ld bc, $0500 ; $4b5d
	ld de, $3900 ; $4b60
	farcall FarPtr_ScriptSetActorMoveTarget ; $4b63
	ld a, $00 ; $4b66
	farcall FarPtr_ScriptWaitActorMoveDone ; $4b68
	ld a, $07 ; $4b6b
	ld bc, $0500 ; $4b6d
	ld de, $3700 ; $4b70
	farcall FarPtr_ScriptSetActorMoveTarget ; $4b73
	ld a, $07 ; $4b76
	farcall FarPtr_ScriptWaitActorMoveDone ; $4b78
	ld a, $07 ; $4b7b
	ld b, $40 ; $4b7d
	farcall FarPtr_SetActorFacing ; $4b7f
	test_flag $05, 7 ; $4b82
	jr z, Label_12_4b94 ; $4b85
	ld a, $02 ; $4b87
	farcall FarPtr_GetActorStateAddr ; $4b89
	ld c, l ; $4b8c
	ld b, h ; $4b8d
	ld de, $d000 ; $4b8e
	farcall FarPtr_04_20 ; $4b91
Label_12_4b94:
	push af ; $4b94
	ld a, $0a ; $4b95
	farcall FarPtr_WaitScriptFrames ; $4b97
	pop af ; $4b9a
	ret ; $4b9b
	; $4b9c, 6 bytes (records:2)
	dw $14f3 ; record 0
	dw $14f4 ; record 1
	dw $14f5 ; record 2
Label_12_4ba2:
	ld hl, $14ff ; $4ba2
	farcall FarPtr_InitDialogueTextCursor ; $4ba5
	ld c, $06 ; $4ba8
	call BeginFadeIn ; $4baa
	call WaitFadeEnd ; $4bad
	jr Label_12_4bfc ; $4bb0
Label_12_4bb2:
	ldh a, [hWramBank] ; $4bb2
	push af ; $4bb4
	wram_bank $07 ; $4bb5
	ld de, $0032 ; $4bbb
	ld hl, $de00 ; $4bbe
	ld a, e ; $4bc1
	ld [hl+], a ; $4bc2
	ld [hl], d ; $4bc3
	ld a, $00 ; $4bc4
	farcall FarPtr_UpdateMinigameRecord ; $4bc6
	pop af ; $4bc9
	wram_bank ; $4bca
	ld hl, $14fe ; $4bce
	farcall FarPtr_InitDialogueTextCursor ; $4bd1
	ld c, $06 ; $4bd4
	call BeginFadeIn ; $4bd6
	call WaitFadeEnd ; $4bd9
	jr Label_12_4bfc ; $4bdc
Label_12_4bde:
	ld hl, $14fd ; $4bde
	farcall FarPtr_InitDialogueTextCursor ; $4be1
	ld c, $06 ; $4be4
	call BeginFadeIn ; $4be6
	call WaitFadeEnd ; $4be9
	jr Label_12_4bfc ; $4bec
Label_12_4bee:
	ld hl, $14fc ; $4bee
	farcall FarPtr_InitDialogueTextCursor ; $4bf1
	ld c, $06 ; $4bf4
	call BeginFadeIn ; $4bf6
	call WaitFadeEnd ; $4bf9
Label_12_4bfc:
	ld a, $07 ; $4bfc
	ld d, $02 ; $4bfe
	farcall FarPtr_ScriptSetActorAnimation ; $4c00
	ld a, $07 ; $4c03
	farcall FarPtr_ScriptWaitActorIdle ; $4c05
	ld a, $07 ; $4c08
	farcall FarPtr_ScriptShowSpeakerDialogue ; $4c0a
	ld a, $00 ; $4c0d
	ld bc, $0020 ; $4c0f
	farcall FarPtr_ScriptSetActorMoveSpeed ; $4c12
	ld a, $00 ; $4c15
	ld bc, $0500 ; $4c17
	ld de, $3100 ; $4c1a
	farcall FarPtr_ScriptSetActorMoveTarget ; $4c1d
	ld a, $00 ; $4c20
	farcall FarPtr_ScriptWaitActorMoveDone ; $4c22
	xor a, a ; $4c25
	ld bc, $0500 ; $4c26
	ld de, $3700 ; $4c29
	farcall FarPtr_MovePlayerToPosition ; $4c2c
	ld a, $00 ; $4c2f
	ld bc, $0500 ; $4c31
	ld de, $3900 ; $4c34
	farcall FarPtr_ScriptSetActorMoveTarget ; $4c37
	ld a, $00 ; $4c3a
	farcall FarPtr_ScriptWaitActorMoveDone ; $4c3c
	ld a, $07 ; $4c3f
	ld bc, $0500 ; $4c41
	ld de, $3700 ; $4c44
	farcall FarPtr_ScriptSetActorMoveTarget ; $4c47
	ld a, $07 ; $4c4a
	farcall FarPtr_ScriptWaitActorMoveDone ; $4c4c
	ld a, $07 ; $4c4f
	ld b, $40 ; $4c51
	farcall FarPtr_SetActorFacing ; $4c53
	test_flag $05, 7 ; $4c56
	jr z, Label_12_4c98 ; $4c59
	push af ; $4c5b
	ld a, $1e ; $4c5c
	farcall FarPtr_WaitScriptFrames ; $4c5e
	pop af ; $4c61
	ld a, $02 ; $4c62
	ld b, a ; $4c64
	ld a, $00 ; $4c65
	farcall FarPtr_FaceActorsTowardEachOther ; $4c67
	push af ; $4c6a
	ld a, $1e ; $4c6b
	farcall FarPtr_WaitScriptFrames ; $4c6d
	pop af ; $4c70
	ld a, $00 ; $4c71
	ld d, $03 ; $4c73
	farcall FarPtr_ScriptSetActorAnimation ; $4c75
	ld a, $02 ; $4c78
	ld d, $03 ; $4c7a
	farcall FarPtr_ScriptSetActorAnimation ; $4c7c
	ld a, $02 ; $4c7f
	farcall FarPtr_ScriptWaitActorIdle ; $4c81
	ld a, $02 ; $4c84
	farcall FarPtr_GetActorStateAddr ; $4c86
	ld c, l ; $4c89
	ld b, h ; $4c8a
	ld de, $d000 ; $4c8b
	farcall FarPtr_04_20 ; $4c8e
	push af ; $4c91
	ld a, $14 ; $4c92
	farcall FarPtr_WaitScriptFrames ; $4c94
	pop af ; $4c97
Label_12_4c98:
	push af ; $4c98
	ld a, $0a ; $4c99
	farcall FarPtr_WaitScriptFrames ; $4c9b
	pop af ; $4c9e
	ret ; $4c9f
	; $4ca0, 9 bytes (records:8)
; 1 records x 8 bytes
	dw $ff01, $0000, $4ca9, $0000 ; record 0
	db $ff
	farcall FarPtr_BeginCutsceneScriptMode ; $4ca9
	ld c, $10 ; $4cac
	call BeginFadeIn ; $4cae
	ld hl, $0483 ; $4cb1
	farcall FarPtr_InitDialogueTextCursor ; $4cb4
	ld a, $00 ; $4cb7
	farcall FarPtr_ScriptShowSpeakerDialogue ; $4cb9
	farcall FarPtr_EndCutsceneScriptMode ; $4cbc
	ret ; $4cbf
	; $4cc0, 8 bytes (records:8)
; 1 records x 8 bytes
	dw $ff02, $9c00, $4ce9, $0000 ; record 0
	; $4cc8, 34 bytes (records:8)
; 4 records x 8 bytes
	dw $ff03, $0000, $4d29, $0001 ; record 0
	dw $ff04, $0000, $4d98, $0001 ; record 1
	dw $ff05, $0000, $4e0d, $0001 ; record 2
	dw $ff06, $0000, $4e82, $0001 ; record 3
	db $ff, $3e
	nop ; $4cea
	ld bc, $0500 ; $4ceb
	ld de, $3900 ; $4cee
	farcall FarPtr_ScriptSetActorMoveTarget ; $4cf1
	ld a, $00 ; $4cf4
	farcall FarPtr_ScriptWaitActorMoveDone ; $4cf6
	ld a, $07 ; $4cf9
	ld bc, $0500 ; $4cfb
	ld de, $3700 ; $4cfe
	farcall FarPtr_ScriptSetActorMoveTarget ; $4d01
	ld a, $07 ; $4d04
	farcall FarPtr_ScriptWaitActorMoveDone ; $4d06
	ld a, $07 ; $4d09
	ld b, $40 ; $4d0b
	farcall FarPtr_SetActorFacing ; $4d0d
	clear_flag $1c, 0 ; $4d10
	clear_flag $0f, 5 ; $4d13
	test_flag $05, 7 ; $4d16
	jr z, Label_12_4d28 ; $4d19
	ld a, $02 ; $4d1b
	farcall FarPtr_GetActorStateAddr ; $4d1d
	ld c, l ; $4d20
	ld b, h ; $4d21
	ld de, $d000 ; $4d22
	farcall FarPtr_04_20 ; $4d25
Label_12_4d28:
	ret ; $4d28
	ld hl, $1830 ; $4d29
	farcall FarPtr_InitDialogueTextCursor ; $4d2c
	ld a, $07 ; $4d2f
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $4d31
	farcall FarPtr_RunDialogueYesNoPrompt ; $4d34
	farcall FarPtr_ScriptCloseDialogueWindow ; $4d37
	push af ; $4d3a
	ld a, $05 ; $4d3b
	farcall FarPtr_WaitScriptFrames ; $4d3d
	pop af ; $4d40
	and a, a ; $4d41
	jr nz, Label_12_4d97 ; $4d42
	ld a, $07 ; $4d44
	ld b, $c0 ; $4d46
	farcall FarPtr_SetActorFacing ; $4d48
	ld a, $07 ; $4d4b
	ld d, $02 ; $4d4d
	farcall FarPtr_ScriptSetActorAnimation ; $4d4f
	ld a, $00 ; $4d52
	ld bc, $0020 ; $4d54
	farcall FarPtr_ScriptSetActorMoveSpeed ; $4d57
	ld a, $00 ; $4d5a
	ld bc, $0300 ; $4d5c
	ld de, $3100 ; $4d5f
	farcall FarPtr_ScriptSetActorMoveTarget ; $4d62
	ld a, $00 ; $4d65
	farcall FarPtr_ScriptWaitActorMoveDone ; $4d67
	ld a, $00 ; $4d6a
	ld bc, $0c00 ; $4d6c
	ld de, $3100 ; $4d6f
	farcall FarPtr_ScriptSetActorMoveTarget ; $4d72
	ld c, $04 ; $4d75
	call BeginFadeOut ; $4d77
	call WaitFadeEnd ; $4d7a
	ld a, $13 ; $4d7d
	ld [wStoryModeCurrentLocation], a ; $4d7f
	ld a, $0b ; $4d82
	ld [$c295], a ; $4d84
	ld a, $ff ; $4d87
	ld [$c294], a ; $4d89
	ld [$c2a1], a ; $4d8c
	ld a, $16 ; $4d8f
	farcall FarPtr_RunTrainingDrillByID ; $4d91
	farcall FarPtr_EndCutsceneScriptMode ; $4d94
Label_12_4d97:
	ret ; $4d97
	test_flag $1a, 7 ; $4d98
	jp z, WallPracticeLevelLockedScript ; $4d9b
	ld hl, $1831 ; $4d9e
	farcall FarPtr_InitDialogueTextCursor ; $4da1
	ld a, $07 ; $4da4
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $4da6
	farcall FarPtr_RunDialogueYesNoPrompt ; $4da9
	farcall FarPtr_ScriptCloseDialogueWindow ; $4dac
	push af ; $4daf
	ld a, $05 ; $4db0
	farcall FarPtr_WaitScriptFrames ; $4db2
	pop af ; $4db5
	and a, a ; $4db6
	jr nz, Label_12_4e0c ; $4db7
	ld a, $07 ; $4db9
	ld b, $c0 ; $4dbb
	farcall FarPtr_SetActorFacing ; $4dbd
	ld a, $07 ; $4dc0
	ld d, $02 ; $4dc2
	farcall FarPtr_ScriptSetActorAnimation ; $4dc4
	ld a, $00 ; $4dc7
	ld bc, $0020 ; $4dc9
	farcall FarPtr_ScriptSetActorMoveSpeed ; $4dcc
	ld a, $00 ; $4dcf
	ld bc, $0700 ; $4dd1
	ld de, $3100 ; $4dd4
	farcall FarPtr_ScriptSetActorMoveTarget ; $4dd7
	ld a, $00 ; $4dda
	farcall FarPtr_ScriptWaitActorMoveDone ; $4ddc
	ld a, $00 ; $4ddf
	ld bc, $0c00 ; $4de1
	ld de, $3100 ; $4de4
	farcall FarPtr_ScriptSetActorMoveTarget ; $4de7
	ld c, $04 ; $4dea
	call BeginFadeOut ; $4dec
	call WaitFadeEnd ; $4def
	ld a, $13 ; $4df2
	ld [wStoryModeCurrentLocation], a ; $4df4
	ld a, $0b ; $4df7
	ld [$c295], a ; $4df9
	ld a, $ff ; $4dfc
	ld [$c294], a ; $4dfe
	ld [$c2a1], a ; $4e01
	ld a, $17 ; $4e04
	farcall FarPtr_RunTrainingDrillByID ; $4e06
	farcall FarPtr_EndCutsceneScriptMode ; $4e09
Label_12_4e0c:
	ret ; $4e0c
	test_flag $1b, 0 ; $4e0d
	jp z, WallPracticeLevelLockedScript ; $4e10
	ld hl, $1832 ; $4e13
	farcall FarPtr_InitDialogueTextCursor ; $4e16
	ld a, $07 ; $4e19
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $4e1b
	farcall FarPtr_RunDialogueYesNoPrompt ; $4e1e
	farcall FarPtr_ScriptCloseDialogueWindow ; $4e21
	push af ; $4e24
	ld a, $05 ; $4e25
	farcall FarPtr_WaitScriptFrames ; $4e27
	pop af ; $4e2a
	and a, a ; $4e2b
	jr nz, Label_12_4e81 ; $4e2c
	ld a, $07 ; $4e2e
	ld b, $c0 ; $4e30
	farcall FarPtr_SetActorFacing ; $4e32
	ld a, $07 ; $4e35
	ld d, $02 ; $4e37
	farcall FarPtr_ScriptSetActorAnimation ; $4e39
	ld a, $00 ; $4e3c
	ld bc, $0020 ; $4e3e
	farcall FarPtr_ScriptSetActorMoveSpeed ; $4e41
	ld a, $00 ; $4e44
	ld bc, $1100 ; $4e46
	ld de, $3100 ; $4e49
	farcall FarPtr_ScriptSetActorMoveTarget ; $4e4c
	ld a, $00 ; $4e4f
	farcall FarPtr_ScriptWaitActorMoveDone ; $4e51
	ld a, $00 ; $4e54
	ld bc, $0c00 ; $4e56
	ld de, $3100 ; $4e59
	farcall FarPtr_ScriptSetActorMoveTarget ; $4e5c
	ld c, $04 ; $4e5f
	call BeginFadeOut ; $4e61
	call WaitFadeEnd ; $4e64
	ld a, $13 ; $4e67
	ld [wStoryModeCurrentLocation], a ; $4e69
	ld a, $0b ; $4e6c
	ld [$c295], a ; $4e6e
	ld a, $ff ; $4e71
	ld [$c294], a ; $4e73
	ld [$c2a1], a ; $4e76
	ld a, $18 ; $4e79
	farcall FarPtr_RunTrainingDrillByID ; $4e7b
	farcall FarPtr_EndCutsceneScriptMode ; $4e7e
Label_12_4e81:
	ret ; $4e81
	test_flag $1b, 1 ; $4e82
	jp z, WallPracticeLevelLockedScript ; $4e85
	ld hl, $1833 ; $4e88
	farcall FarPtr_InitDialogueTextCursor ; $4e8b
	ld a, $07 ; $4e8e
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $4e90
	farcall FarPtr_RunDialogueYesNoPrompt ; $4e93
	farcall FarPtr_ScriptCloseDialogueWindow ; $4e96
	push af ; $4e99
	ld a, $05 ; $4e9a
	farcall FarPtr_WaitScriptFrames ; $4e9c
	pop af ; $4e9f
	and a, a ; $4ea0
	jr nz, Label_12_4ef6 ; $4ea1
	ld a, $07 ; $4ea3
	ld b, $c0 ; $4ea5
	farcall FarPtr_SetActorFacing ; $4ea7
	ld a, $07 ; $4eaa
	ld d, $02 ; $4eac
	farcall FarPtr_ScriptSetActorAnimation ; $4eae
	ld a, $00 ; $4eb1
	ld bc, $0020 ; $4eb3
	farcall FarPtr_ScriptSetActorMoveSpeed ; $4eb6
	ld a, $00 ; $4eb9
	ld bc, $1500 ; $4ebb
	ld de, $3100 ; $4ebe
	farcall FarPtr_ScriptSetActorMoveTarget ; $4ec1
	ld a, $00 ; $4ec4
	farcall FarPtr_ScriptWaitActorMoveDone ; $4ec6
	ld a, $00 ; $4ec9
	ld bc, $0c00 ; $4ecb
	ld de, $3100 ; $4ece
	farcall FarPtr_ScriptSetActorMoveTarget ; $4ed1
	ld c, $04 ; $4ed4
	call BeginFadeOut ; $4ed6
	call WaitFadeEnd ; $4ed9
	ld a, $13 ; $4edc
	ld [wStoryModeCurrentLocation], a ; $4ede
	ld a, $0b ; $4ee1
	ld [$c295], a ; $4ee3
	ld a, $ff ; $4ee6
	ld [$c294], a ; $4ee8
	ld [$c2a1], a ; $4eeb
	ld a, $19 ; $4eee
	farcall FarPtr_RunTrainingDrillByID ; $4ef0
	farcall FarPtr_EndCutsceneScriptMode ; $4ef3
Label_12_4ef6:
	ret ; $4ef6
WallPracticeLevelLockedScript:
	ld hl, $1834 ; $4ef7
	farcall FarPtr_InitDialogueTextCursor ; $4efa
	ld a, $07 ; $4efd
	farcall FarPtr_ScriptShowSpeakerDialogue ; $4eff
	ret ; $4f02
	farcall FarPtr_WaitPlayerMoveDone ; $4f03
	ld a, $00 ; $4f06
	ld [$c329], a ; $4f08
	ld a, $27 ; $4f0b
	ld [$c32a], a ; $4f0d
	ld a, $18 ; $4f10
	ld [$c32b], a ; $4f12
	ld a, $3c ; $4f15
	ld [$c32c], a ; $4f17
	call DisableLCDSafely ; $4f1a
	ld a, $00 ; $4f1d
	farcall FarPtr_CopyScrolledSceneTilemapToVram ; $4f1f
	call EnableLCD ; $4f22
	call SetupWallPracticeLevelSigns ; $4f25
	ld a, [$c295] ; $4f28
	cp a, $0a ; $4f2b
	jp z, Label_12_4f39 ; $4f2d
	cp a, $0b ; $4f30
	jp z, Label_12_4f8a ; $4f32
	call RestoreWallPracticeRoomActors ; $4f35
	ret ; $4f38
Label_12_4f39:
	test_flag $05, 7 ; $4f39
	jr z, Label_12_4f55 ; $4f3c
	ld a, $02 ; $4f3e
	farcall FarPtr_SetActorNullScript ; $4f40
	ld a, $02 ; $4f43
	ld bc, $0700 ; $4f45
	ld de, $3900 ; $4f48
	farcall FarPtr_ScriptSetActorPosition ; $4f4b
	ld a, $02 ; $4f4e
	ld b, $c0 ; $4f50
	farcall FarPtr_SetActorFacing ; $4f52
Label_12_4f55:
	ld a, $07 ; $4f55
	ld bc, $0300 ; $4f57
	ld de, $3700 ; $4f5a
	farcall FarPtr_ScriptSetActorPosition ; $4f5d
	ld a, $07 ; $4f60
	ld b, $00 ; $4f62
	farcall FarPtr_SetActorFacing ; $4f64
	ld a, [$c4c7] ; $4f67
	cp a, $01 ; $4f6a
	jp nz, Label_12_4f7e ; $4f6c
	ld c, $06 ; $4f6f
	call BeginFadeIn ; $4f71
	call WaitFadeEnd ; $4f74
	xor a, a ; $4f77
	ld [$c2d5], a ; $4f78
	jp WallPracticeExitCourtScript ; $4f7b
Label_12_4f7e:
	ld a, [$c2b0] ; $4f7e
	cp a, $05 ; $4f81
	jp nc, WallPracticeMasterResultScript ; $4f83
	jp WallPracticeLevelResultScript ; $4f86
	ret ; $4f89
Label_12_4f8a:
	test_flag $05, 7 ; $4f8a
	jr z, Label_12_4fa6 ; $4f8d
	ld a, $02 ; $4f8f
	farcall FarPtr_SetActorNullScript ; $4f91
	ld a, $02 ; $4f94
	ld bc, $0700 ; $4f96
	ld de, $3900 ; $4f99
	farcall FarPtr_ScriptSetActorPosition ; $4f9c
	ld a, $02 ; $4f9f
	ld b, $c0 ; $4fa1
	farcall FarPtr_SetActorFacing ; $4fa3
Label_12_4fa6:
	set_flag $1c, 0 ; $4fa6
	ld a, $07 ; $4fa9
	ld bc, $0300 ; $4fab
	ld de, $3700 ; $4fae
	farcall FarPtr_ScriptSetActorPosition ; $4fb1
	ld a, $07 ; $4fb4
	ld b, $00 ; $4fb6
	farcall FarPtr_SetActorFacing ; $4fb8
	ld c, $06 ; $4fbb
	call BeginFadeIn ; $4fbd
	call WaitFadeEnd ; $4fc0
	xor a, a ; $4fc3
	ld [$c2d5], a ; $4fc4
	ld a, [$c4c7] ; $4fc7
	cp a, $01 ; $4fca
	jp z, Label_12_505e ; $4fcc
	ld a, [wPointWinLoseFlag] ; $4fcf
	cp a, $01 ; $4fd2
	jr nz, Label_12_4ff3 ; $4fd4
	ld hl, $1835 ; $4fd6
	farcall FarPtr_InitDialogueTextCursor ; $4fd9
	ld a, $07 ; $4fdc
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $4fde
	farcall FarPtr_RunDialogueYesNoPrompt ; $4fe1
	farcall FarPtr_ScriptCloseDialogueWindow ; $4fe4
	push af ; $4fe7
	ld a, $05 ; $4fe8
	farcall FarPtr_WaitScriptFrames ; $4fea
	pop af ; $4fed
	and a, a ; $4fee
	jr nz, Label_12_505e ; $4fef
	jr Label_12_502b ; $4ff1
Label_12_4ff3:
	ld a, [wPointOutcome] ; $4ff3
	cp a, $09 ; $4ff6
	jr nz, Label_12_5002 ; $4ff8
	ld hl, $14f6 ; $4ffa
	farcall FarPtr_InitDialogueTextCursor ; $4ffd
	jr Label_12_5015 ; $5000
Label_12_5002:
	ld a, [wPointOutcome] ; $5002
	and a, $03 ; $5005
	add a, a ; $5007
	add a, $9c ; $5008
	ld l, a ; $500a
	adc a, $4b ; $500b
	sub a, l ; $500d
	ld h, a ; $500e
	ld a, [hl+] ; $500f
	ld h, [hl] ; $5010
	ld l, a ; $5011
	farcall FarPtr_InitDialogueTextCursor ; $5012
Label_12_5015:
	ld a, $07 ; $5015
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $5017
	farcall FarPtr_RunDialogueYesNoPrompt ; $501a
	farcall FarPtr_ScriptCloseDialogueWindow ; $501d
	push af ; $5020
	ld a, $05 ; $5021
	farcall FarPtr_WaitScriptFrames ; $5023
	pop af ; $5026
	and a, a ; $5027
	jp nz, Label_12_505e ; $5028
Label_12_502b:
	ld a, $07 ; $502b
	ld b, $c0 ; $502d
	farcall FarPtr_SetActorFacing ; $502f
	ld a, $07 ; $5032
	ld d, $02 ; $5034
	farcall FarPtr_ScriptSetActorAnimation ; $5036
	ld a, $07 ; $5039
	farcall FarPtr_ScriptWaitActorIdle ; $503b
	ld c, $04 ; $503e
	call BeginFadeOut ; $5040
	call WaitFadeEnd ; $5043
	ld a, $13 ; $5046
	ld [wStoryModeCurrentLocation], a ; $5048
	ld a, $0b ; $504b
	ld [$c295], a ; $504d
	ld a, $ff ; $5050
	ld [$c294], a ; $5052
	ld [$c2a1], a ; $5055
	ld a, [$c8f7] ; $5058
	farcall FarPtr_RunTrainingDrillByID ; $505b
Label_12_505e:
	ret ; $505e
SetupWallPracticeLevelSigns:
	ld a, $00 ; $505f
	test_flag $1a, 6 ; $5061
	jp z, Label_12_50c8 ; $5064
	ld b, $1e ; $5067
	ld c, $2c ; $5069
	ld d, $02 ; $506b
	ld e, $2c ; $506d
	ld h, $02 ; $506f
	ld l, $02 ; $5071
	farcall FarPtr_CopySceneTilemapRect ; $5073
	ld a, $01 ; $5076
	test_flag $1a, 7 ; $5078
	jr z, Label_12_50c8 ; $507b
	ld b, $1e ; $507d
	ld c, $30 ; $507f
	ld d, $06 ; $5081
	ld e, $2c ; $5083
	ld h, $02 ; $5085
	ld l, $02 ; $5087
	farcall FarPtr_CopySceneTilemapRect ; $5089
	ld a, $02 ; $508c
	test_flag $1b, 0 ; $508e
	jr z, Label_12_50c8 ; $5091
	ld b, $1e ; $5093
	ld c, $34 ; $5095
	ld d, $10 ; $5097
	ld e, $2c ; $5099
	ld h, $02 ; $509b
	ld l, $02 ; $509d
	farcall FarPtr_CopySceneTilemapRect ; $509f
	ld a, $03 ; $50a2
	test_flag $1b, 1 ; $50a4
	jr z, Label_12_50c8 ; $50a7
	ld b, $1e ; $50a9
	ld c, $38 ; $50ab
	ld d, $14 ; $50ad
	ld e, $2c ; $50af
	ld h, $02 ; $50b1
	ld l, $02 ; $50b3
	farcall FarPtr_CopySceneTilemapRect ; $50b5
	ld a, $04 ; $50b8
	test_flag $1b, 3 ; $50ba
	jr z, Label_12_50c8 ; $50bd
	ld a, $05 ; $50bf
	test_flag $1b, 5 ; $50c1
	jr z, Label_12_50c8 ; $50c4
	ld a, $06 ; $50c6
Label_12_50c8:
	ld [$c2b0], a ; $50c8
	ret ; $50cb
	test_flag $1c, 0 ; $50cc
	jr z, Label_12_50dd ; $50cf
	ld hl, $1508 ; $50d1
	farcall FarPtr_InitDialogueTextCursor ; $50d4
	ld a, $07 ; $50d7
	farcall FarPtr_ScriptShowSpeakerDialogue ; $50d9
	ret ; $50dc
Label_12_50dd:
	ld a, [$c2b0] ; $50dd
	add a, a ; $50e0
	add a, $71 ; $50e1
	ld l, a ; $50e3
	adc a, $52 ; $50e4
	sub a, l ; $50e6
	ld h, a ; $50e7
	ld a, [hl+] ; $50e8
	ld h, [hl] ; $50e9
	ld l, a ; $50ea
	farcall FarPtr_InitDialogueTextCursor ; $50eb
	ld a, [$c2b0] ; $50ee
	cp a, $05 ; $50f1
	jr nz, Label_12_5111 ; $50f3
	ldh a, [hWramBank] ; $50f5
	push af ; $50f7
	wram_bank $07 ; $50f8
	ld a, $00 ; $50fe
	farcall FarPtr_ReadMinigameRecord ; $5100
	ld hl, $de00 ; $5103
	ld a, [hl+] ; $5106
	ld h, [hl] ; $5107
	ld l, a ; $5108
	pop af ; $5109
	wram_bank ; $510a
	farcall FarPtr_PushTextArgNumber ; $510e
Label_12_5111:
	ld a, $07 ; $5111
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $5113
	farcall FarPtr_RunDialogueYesNoPrompt ; $5116
	farcall FarPtr_ScriptCloseDialogueWindow ; $5119
	push af ; $511c
	ld a, $05 ; $511d
	farcall FarPtr_WaitScriptFrames ; $511f
	pop af ; $5122
	and a, a ; $5123
	jp z, Label_12_51ba ; $5124
	ld a, [$c2b0] ; $5127
	add a, a ; $512a
	add a, $7f ; $512b
	ld l, a ; $512d
	adc a, $52 ; $512e
	sub a, l ; $5130
	ld h, a ; $5131
	ld a, [hl+] ; $5132
	ld h, [hl] ; $5133
	ld l, a ; $5134
	farcall FarPtr_InitDialogueTextCursor ; $5135
	ld a, $07 ; $5138
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $513a
	farcall FarPtr_RunDialogueYesNoPrompt ; $513d
	farcall FarPtr_ScriptCloseDialogueWindow ; $5140
	push af ; $5143
	ld a, $05 ; $5144
	farcall FarPtr_WaitScriptFrames ; $5146
	pop af ; $5149
	and a, a ; $514a
	jp nz, Label_12_51b1 ; $514b
	ld a, [$c2b0] ; $514e
	and a, a ; $5151
	jp z, Label_12_51b4 ; $5152
	ld a, $07 ; $5155
	ld bc, $0300 ; $5157
	ld de, $3700 ; $515a
	farcall FarPtr_ScriptSetActorMoveTarget ; $515d
	ld a, $07 ; $5160
	farcall FarPtr_ScriptWaitActorMoveDone ; $5162
	ld a, $07 ; $5165
	ld b, $00 ; $5167
	farcall FarPtr_SetActorFacing ; $5169
	ld a, $07 ; $516c
	farcall FarPtr_ScriptShowSpeakerDialogue ; $516e
	test_flag $05, 7 ; $5171
	jr z, Label_12_5192 ; $5174
	ld a, $02 ; $5176
	farcall FarPtr_SetActorNullScript ; $5178
	ld a, $02 ; $517b
	ld bc, $0700 ; $517d
	ld de, $3900 ; $5180
	farcall FarPtr_ScriptSetActorMoveTarget ; $5183
	ld a, $02 ; $5186
	farcall FarPtr_ScriptWaitActorMoveDone ; $5188
	ld a, $02 ; $518b
	ld b, $c0 ; $518d
	farcall FarPtr_SetActorFacing ; $518f
Label_12_5192:
	ld a, $00 ; $5192
	ld bc, $0020 ; $5194
	farcall FarPtr_ScriptSetActorMoveSpeed ; $5197
	ld a, $00 ; $519a
	ld bc, $0500 ; $519c
	ld de, $3500 ; $519f
	farcall FarPtr_ScriptSetActorMoveTarget ; $51a2
	ld a, $00 ; $51a5
	farcall FarPtr_ScriptWaitActorMoveDone ; $51a7
	set_flag $1c, 0 ; $51aa
	set_flag $0f, 5 ; $51ad
	ret ; $51b0
Label_12_51b1:
	farcall FarPtr_AdvanceDialogueTextCursor ; $51b1
Label_12_51b4:
	ld a, $07 ; $51b4
	farcall FarPtr_ScriptShowSpeakerDialogue ; $51b6
	ret ; $51b9
Label_12_51ba:
	ld a, $07 ; $51ba
	ld d, $03 ; $51bc
	farcall FarPtr_ScriptSetActorAnimation ; $51be
	ld a, $07 ; $51c1
	farcall FarPtr_ScriptWaitActorIdle ; $51c3
	ld a, $07 ; $51c6
	farcall FarPtr_ScriptShowSpeakerDialogue ; $51c8
	ld a, $07 ; $51cb
	ld bc, $0300 ; $51cd
	ld de, $3700 ; $51d0
	farcall FarPtr_ScriptSetActorMoveTarget ; $51d3
	ld a, $07 ; $51d6
	farcall FarPtr_ScriptWaitActorMoveDone ; $51d8
	ld a, $07 ; $51db
	ld b, $00 ; $51dd
	farcall FarPtr_SetActorFacing ; $51df
	test_flag $05, 7 ; $51e2
	jr z, Label_12_522c ; $51e5
	push af ; $51e7
	ld a, $14 ; $51e8
	farcall FarPtr_WaitScriptFrames ; $51ea
	pop af ; $51ed
	ld a, $02 ; $51ee
	farcall FarPtr_SetActorNullScript ; $51f0
	ld a, $02 ; $51f3
	ld bc, $0700 ; $51f5
	ld de, $3900 ; $51f8
	farcall FarPtr_ScriptSetActorMoveTarget ; $51fb
	ld a, $02 ; $51fe
	farcall FarPtr_ScriptWaitActorMoveDone ; $5200
	ld a, $02 ; $5203
	ld b, a ; $5205
	ld a, $00 ; $5206
	farcall FarPtr_FaceActorsTowardEachOther ; $5208
	push af ; $520b
	ld a, $1e ; $520c
	farcall FarPtr_WaitScriptFrames ; $520e
	pop af ; $5211
	ld a, $00 ; $5212
	ld d, $03 ; $5214
	farcall FarPtr_ScriptSetActorAnimation ; $5216
	ld a, $02 ; $5219
	ld d, $03 ; $521b
	farcall FarPtr_ScriptSetActorAnimation ; $521d
	ld a, $02 ; $5220
	farcall FarPtr_ScriptWaitActorIdle ; $5222
	push af ; $5225
	ld a, $14 ; $5226
	farcall FarPtr_WaitScriptFrames ; $5228
	pop af ; $522b
Label_12_522c:
	ld a, $00 ; $522c
	ld bc, $0020 ; $522e
	farcall FarPtr_ScriptSetActorMoveSpeed ; $5231
	ld a, $00 ; $5234
	ld bc, $0500 ; $5236
	ld de, $3700 ; $5239
	farcall FarPtr_ScriptSetActorMoveTarget ; $523c
	ld a, $00 ; $523f
	farcall FarPtr_ScriptWaitActorMoveDone ; $5241
	ld a, $00 ; $5244
	ld bc, $0500 ; $5246
	ld de, $3100 ; $5249
	farcall FarPtr_ScriptSetActorMoveTarget ; $524c
	ld a, $00 ; $524f
	farcall FarPtr_ScriptWaitActorMoveDone ; $5251
	ld a, $07 ; $5254
	ld b, $c0 ; $5256
	farcall FarPtr_SetActorFacing ; $5258
	ld a, $07 ; $525b
	ld d, $02 ; $525d
	farcall FarPtr_ScriptSetActorAnimation ; $525f
	ld a, $00 ; $5262
	ld bc, $0c00 ; $5264
	ld de, $3100 ; $5267
	farcall FarPtr_ScriptSetActorMoveTarget ; $526a
	jp LaunchWallPracticeMinigame ; $526d
	ret ; $5270
	; $5271, 14 bytes (records:2)
	dw $14ee ; record 0
	dw $1505 ; record 1
	dw $1803 ; record 2
	dw $180f ; record 3
	dw $1819 ; record 4
	dw $181e ; record 5
	dw $1823 ; record 6
	; $527f, 14 bytes (records:2)
	dw $14f0 ; record 0
	dw $1507 ; record 1
	dw $1805 ; record 2
	dw $1811 ; record 3
	dw $181b ; record 4
	dw $1820 ; record 5
	dw $1825 ; record 6
LaunchWallPracticeMinigame:
	ld c, $04 ; $528d
	call BeginFadeOut ; $528f
	call WaitFadeEnd ; $5292
	ld a, $13 ; $5295
	ld [wStoryModeCurrentLocation], a ; $5297
	ld a, $0a ; $529a
	ld [$c295], a ; $529c
	ld a, $ff ; $529f
	ld [$c294], a ; $52a1
	ld [$c2a1], a ; $52a4
	ld a, [$c2b0] ; $52a7
	add a, $b9 ; $52aa
	ld l, a ; $52ac
	adc a, $52 ; $52ad
	sub a, l ; $52af
	ld h, a ; $52b0
	ld a, [hl] ; $52b1
	farcall FarPtr_RunTrainingDrillByID ; $52b2
	farcall FarPtr_EndCutsceneScriptMode ; $52b5
	ret ; $52b8
	; $52b9, 7 bytes (bytes:16)
	db $16, $17, $18, $19, $1b, $1b, $1b ; 0x00
RestoreWallPracticeRoomActors:
	test_flag $0f, 5 ; $52c0
	jr z, Label_12_52f6 ; $52c3
	set_flag $1c, 0 ; $52c5
	ld a, $07 ; $52c8
	ld bc, $0300 ; $52ca
	ld de, $3700 ; $52cd
	farcall FarPtr_ScriptSetActorPosition ; $52d0
	ld a, $07 ; $52d3
	ld b, $00 ; $52d5
	farcall FarPtr_SetActorFacing ; $52d7
	test_flag $05, 7 ; $52da
	jr z, Label_12_52f6 ; $52dd
	ld a, $02 ; $52df
	farcall FarPtr_SetActorNullScript ; $52e1
	ld a, $02 ; $52e4
	ld bc, $0700 ; $52e6
	ld de, $3900 ; $52e9
	farcall FarPtr_ScriptSetActorPosition ; $52ec
	ld a, $02 ; $52ef
	ld b, $c0 ; $52f1
	farcall FarPtr_SetActorFacing ; $52f3
Label_12_52f6:
	ret ; $52f6
SeniorCourtStoryCmds_12:
	; $52f7, 14 bytes (records:2)
	dw $556f ; record 0
	dw $5580 ; record 1
	dw $5305 ; record 2
	dw $5c4d ; record 3
	dw $5cc6 ; record 4
	dw $5cc7 ; record 5
	dw $5d1c ; record 6
	; $5305, 618 bytes (bytes:14)
	db $00, $00, $89, $7a, $00, $29, $00, $19, $80, $00, $49, $01, $00, $00 ; 0x00
	db $00, $00, $e3, $79, $00, $35, $00, $1e, $c0, $00, $65, $06, $07, $00 ; 0x0e
	db $00, $00, $59, $7c, $00, $32, $00, $1e, $00, $00, $64, $01, $05, $00 ; 0x1c
	db $00, $00, $93, $7a, $00, $33, $00, $11, $80, $00, $69, $01, $04, $00 ; 0x2a
	db $00, $00, $89, $7a, $00, $29, $00, $13, $80, $00, $66, $01, $06, $00 ; 0x38
	db $00, $00, $e3, $79, $00, $0b, $00, $15, $c0, $00, $6b, $01, $05, $00 ; 0x46
	db $00, $00, $66, $7c, $00, $0b, $00, $13, $40, $00, $67, $01, $03, $00 ; 0x54
	db $00, $00, $f0, $7b, $00, $15, $00, $17, $c0, $00, $68, $01, $06, $00 ; 0x62
	db $00, $00, $89, $7b, $00, $13, $00, $0b, $40, $00, $6a, $01, $03, $00 ; 0x70
	db $e0, $05, $93, $7a, $00, $09, $00, $0b, $40, $00, $29, $01, $00, $00 ; 0x7e
	db $00, $00, $bf, $7a, $00, $22, $00, $13, $40, $00, $54, $01, $00, $00 ; 0x8c
	db $00, $00, $22, $7b, $00, $25, $00, $1d, $c0, $00, $54, $01, $04, $00 ; 0x9a
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $ff, $00, $00, $89, $7a ; 0xa8
	db $00, $2d, $00, $19, $40, $00, $49, $01, $00, $00, $00, $00, $89, $7a ; 0xb6
	db $00, $29, $00, $1b, $80, $00, $65, $01, $07, $00, $00, $00, $59, $7c ; 0xc4
	db $00, $39, $00, $1d, $80, $00, $64, $01, $05, $00, $00, $00, $89, $7a ; 0xd2
	db $00, $2d, $00, $13, $00, $00, $69, $01, $04, $00, $00, $00, $89, $7a ; 0xe0
	db $00, $2b, $00, $11, $80, $00, $66, $01, $06, $00, $00, $00, $e3, $79 ; 0xee
	db $00, $0a, $00, $15, $c0, $00, $6b, $01, $05, $00, $00, $00, $89, $7a ; 0xfc
	db $00, $03, $00, $17, $00, $00, $67, $01, $03, $00, $00, $00, $59, $7c ; 0x10a
	db $00, $12, $00, $0d, $00, $00, $68, $01, $06, $00, $00, $00, $ea, $79 ; 0x118
	db $00, $15, $00, $0d, $40, $00, $6a, $06, $03, $00, $e0, $05, $93, $7a ; 0x126
	db $00, $03, $00, $0b, $40, $00, $29, $01, $00, $00, $00, $00, $bf, $7a ; 0x134
	db $00, $22, $00, $11, $40, $00, $54, $01, $05, $00, $00, $00, $22, $7b ; 0x142
	db $00, $26, $00, $1d, $c0, $00, $54, $01, $00, $00, $00, $00, $89, $7b ; 0x150
	db $00, $32, $00, $11, $40, $00, $54, $01, $00, $00, $00, $00, $f0, $7b ; 0x15e
	db $00, $36, $00, $1d, $c0, $00, $54, $01, $06, $00, $00, $00, $89, $7a ; 0x16c
	db $00, $40, $00, $40, $c0, $00, $53, $01, $00, $00, $00, $00, $00, $00 ; 0x17a
	db $00, $00, $00, $00, $00, $ff, $00, $00, $89, $7a, $00, $2d, $00, $19 ; 0x188
	db $40, $00, $49, $01, $00, $00, $00, $00, $e3, $79, $00, $2d, $00, $11 ; 0x196
	db $c0, $00, $65, $06, $07, $00, $00, $00, $59, $7c, $00, $2d, $00, $0f ; 0x1a4
	db $40, $00, $64, $01, $05, $00, $00, $00, $89, $7a, $00, $39, $00, $1d ; 0x1b2
	db $80, $00, $69, $01, $04, $00, $00, $00, $89, $7a, $00, $39, $00, $1b ; 0x1c0
	db $80, $00, $66, $01, $06, $00, $00, $00, $e3, $79, $00, $23, $00, $1e ; 0x1ce
	db $c0, $00, $6b, $01, $05, $00, $00, $00, $89, $7a, $00, $23, $00, $1c ; 0x1dc
	db $40, $00, $67, $01, $03, $00, $00, $00, $89, $7a, $00, $09, $00, $07 ; 0x1ea
	db $00, $00, $68, $01, $06, $00, $00, $00, $89, $7a, $00, $0b, $00, $07 ; 0x1f8
	db $80, $00, $6a, $01, $03, $00, $e0, $05, $93, $7a, $00, $03, $00, $0b ; 0x206
	db $40, $00, $29, $01, $00, $00, $00, $00, $bf, $7a, $00, $12, $00, $0b ; 0x214
	db $40, $00, $54, $01, $05, $00, $00, $00, $22, $7b, $00, $16, $00, $16 ; 0x222
	db $c0, $00, $54, $01, $00, $00, $00, $00, $89, $7b, $00, $32, $00, $11 ; 0x230
	db $40, $00, $54, $01, $00, $00, $00, $00, $f0, $7b, $00, $36, $00, $1d ; 0x23e
	db $c0, $00, $54, $01, $06, $00, $00, $00, $89, $7a, $00, $40, $00, $40 ; 0x24c
	db $c0, $00, $53, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; 0x25a
	db $00, $ff ; 0x268
	; $556f, 17 bytes (bytes:16)
	db $01, $c0, $00, $2b, $00, $23, $00, $00, $09, $c0, $00, $0b, $00, $19, $00, $00 ; 0x00
	db $ff ; 0x10
	; $5580, 17 bytes (records:8)
; 2 records x 8 bytes
	dw $ff01, $0000, $5591, $0308 ; record 0
	dw $ff0f, $0000, $7ab1, $0f10 ; record 1
	db $ff
	clear_flag $0f, 4 ; $5591
	ld a, $00 ; $5594
	ld b, $40 ; $5596
	ld de, $0200 ; $5598
	farcall FarPtr_MoveActorByAngle ; $559b
	ld a, $02 ; $559e
	ld b, $40 ; $55a0
	ld de, $0200 ; $55a2
	farcall FarPtr_MoveActorByAngle ; $55a5
	ld c, $10 ; $55a8
	call BeginFadeOut ; $55aa
	push af ; $55ad
	ld a, $1e ; $55ae
	farcall FarPtr_WaitScriptFrames ; $55b0
	pop af ; $55b3
	ret ; $55b4
Label_12_55b5:
	ld a, [$c2b1] ; $55b5
	sub a, $09 ; $55b8
	add a, a ; $55ba
	add a, $dc ; $55bb
	ld l, a ; $55bd
	adc a, $55 ; $55be
	sub a, l ; $55c0
	ld h, a ; $55c1
	ld a, [hl+] ; $55c2
	ld h, [hl] ; $55c3
	ld l, a ; $55c4
	farcall FarPtr_InitDialogueTextCursor ; $55c5
	ld a, [$c90d] ; $55c8
	ld hl, $001d ; $55cb
	add a, l ; $55ce
	ld l, a ; $55cf
	jr nc, Label_12_55d3 ; $55d0
	inc h ; $55d2
Label_12_55d3:
	call PushTextArgFetchedString ; $55d3
	ld a, $03 ; $55d6
	farcall FarPtr_ScriptShowSpeakerDialogue ; $55d8
	ret ; $55db
	; $55dc, 12 bytes (records:2)
	dw $108d ; record 0
	dw $1097 ; record 1
	dw $109e ; record 2
	dw $10a8 ; record 3
	dw $10b0 ; record 4
	dw $10ba ; record 5
Label_12_55e8:
	ld a, [$c2b1] ; $55e8
	cp a, $02 ; $55eb
	jr c, Label_12_5606 ; $55ed
	cp a, $09 ; $55ef
	jr nc, Label_12_55b5 ; $55f1
	call Func_12_5ef1 ; $55f3
	ret ; $55f6
Label_12_55f7:
	ld a, [$c2b1] ; $55f7
	cp a, $02 ; $55fa
	jr c, Label_12_5606 ; $55fc
	cp a, $09 ; $55fe
	jr nc, Label_12_55b5 ; $5600
	call Func_12_5f03 ; $5602
	ret ; $5605
Label_12_5606:
	test_flag $05, 7 ; $5606
	jp nz, Label_12_5704 ; $5609
	ld hl, $1004 ; $560c
	farcall FarPtr_InitDialogueTextCursor ; $560f
	ld a, $03 ; $5612
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $5614
	farcall FarPtr_RunDialogueYesNoPrompt ; $5617
	farcall FarPtr_ScriptCloseDialogueWindow ; $561a
	push af ; $561d
	ld a, $05 ; $561e
	farcall FarPtr_WaitScriptFrames ; $5620
	pop af ; $5623
	and a, a ; $5624
	jr z, Label_12_562a ; $5625
	farcall FarPtr_AdvanceDialogueTextCursor ; $5627
Label_12_562a:
	ld a, $03 ; $562a
	farcall FarPtr_ScriptShowSpeakerDialogue ; $562c
	ret ; $562f
	test_flag $05, 7 ; $5630
	jr z, Label_12_55e8 ; $5633
	test_flag $0e, 4 ; $5635
	jp nz, Label_12_57f4 ; $5638
	ld a, $00 ; $563b
	ld bc, $0010 ; $563d
	farcall FarPtr_ScriptSetActorMoveSpeed ; $5640
	ld a, $02 ; $5643
	ld bc, $0010 ; $5645
	farcall FarPtr_ScriptSetActorMoveSpeed ; $5648
	ld a, $02 ; $564b
	farcall FarPtr_SetActorNullScript ; $564d
	ld a, $00 ; $5650
	ld bc, $2900 ; $5652
	ld de, $1b00 ; $5655
	farcall FarPtr_ScriptSetActorMoveTarget ; $5658
	ld a, $02 ; $565b
	ld bc, $2700 ; $565d
	ld de, $1d00 ; $5660
	farcall FarPtr_ScriptSetActorMoveTarget ; $5663
	ld a, $02 ; $5666
	farcall FarPtr_ScriptWaitActorMoveDone ; $5668
	ld a, $02 ; $566b
	ld bc, $2b00 ; $566d
	ld de, $1d00 ; $5670
	farcall FarPtr_ScriptSetActorMoveTarget ; $5673
	ld a, $02 ; $5676
	farcall FarPtr_ScriptWaitActorMoveDone ; $5678
	ld a, $02 ; $567b
	ld bc, $2b00 ; $567d
	ld de, $1900 ; $5680
	farcall FarPtr_ScriptSetActorMoveTarget ; $5683
	ld a, $02 ; $5686
	farcall FarPtr_ScriptWaitActorMoveDone ; $5688
	ld a, $03 ; $568b
	ld b, a ; $568d
	ld a, $02 ; $568e
	farcall FarPtr_FaceActorTowardActor ; $5690
	ld a, $00 ; $5693
	farcall FarPtr_ScriptWaitActorMoveDone ; $5695
	jp Label_12_5747 ; $5698
	test_flag $05, 7 ; $569b
	jp z, Label_12_55f7 ; $569e
	test_flag $0e, 4 ; $56a1
	jp nz, Label_12_57f4 ; $56a4
	ld a, $02 ; $56a7
	ld bc, $0010 ; $56a9
	farcall FarPtr_ScriptSetActorMoveSpeed ; $56ac
	ld a, $00 ; $56af
	ld bc, $0008 ; $56b1
	farcall FarPtr_ScriptSetActorMoveSpeed ; $56b4
	ld a, $00 ; $56b7
	ld b, $c0 ; $56b9
	farcall FarPtr_SetActorFacing ; $56bb
	ld a, $00 ; $56be
	ld b, $01 ; $56c0
	farcall FarPtr_ScriptSetActorFacingLock ; $56c2
	ld a, $02 ; $56c5
	farcall FarPtr_SetActorNullScript ; $56c7
	ld a, $00 ; $56ca
	ld bc, $2900 ; $56cc
	ld de, $1b00 ; $56cf
	farcall FarPtr_ScriptSetActorMoveTarget ; $56d2
	ld a, $02 ; $56d5
	ld bc, $2b00 ; $56d7
	ld de, $1b00 ; $56da
	farcall FarPtr_ScriptSetActorMoveTarget ; $56dd
	ld a, $02 ; $56e0
	farcall FarPtr_ScriptWaitActorMoveDone ; $56e2
	ld a, $02 ; $56e5
	ld bc, $2b00 ; $56e7
	ld de, $1900 ; $56ea
	farcall FarPtr_ScriptSetActorMoveTarget ; $56ed
	ld a, $02 ; $56f0
	farcall FarPtr_ScriptWaitActorMoveDone ; $56f2
	ld a, $03 ; $56f5
	ld b, a ; $56f7
	ld a, $02 ; $56f8
	farcall FarPtr_FaceActorTowardActor ; $56fa
	ld a, $00 ; $56fd
	farcall FarPtr_ScriptWaitActorMoveDone ; $56ff
	jr Label_12_5747 ; $5702
Label_12_5704:
	test_flag $0e, 4 ; $5704
	jp nz, Label_12_57f4 ; $5707
	ld a, $00 ; $570a
	ld bc, $0010 ; $570c
	farcall FarPtr_ScriptSetActorMoveSpeed ; $570f
	ld a, $02 ; $5712
	ld bc, $0010 ; $5714
	farcall FarPtr_ScriptSetActorMoveSpeed ; $5717
	ld a, $02 ; $571a
	farcall FarPtr_SetActorNullScript ; $571c
	ld a, $00 ; $571f
	ld bc, $2900 ; $5721
	ld de, $1b00 ; $5724
	farcall FarPtr_ScriptSetActorMoveTarget ; $5727
	ld a, $02 ; $572a
	ld bc, $2b00 ; $572c
	ld de, $1900 ; $572f
	farcall FarPtr_ScriptSetActorMoveTarget ; $5732
	ld a, $02 ; $5735
	farcall FarPtr_ScriptWaitActorMoveDone ; $5737
	ld a, $03 ; $573a
	ld b, a ; $573c
	ld a, $02 ; $573d
	farcall FarPtr_FaceActorTowardActor ; $573f
	ld a, $00 ; $5742
	farcall FarPtr_ScriptWaitActorMoveDone ; $5744
Label_12_5747:
	ld a, $03 ; $5747
	ld b, a ; $5749
	ld a, $00 ; $574a
	farcall FarPtr_FaceActorTowardActor ; $574c
	ld a, $02 ; $574f
	ld b, a ; $5751
	ld a, $03 ; $5752
	farcall FarPtr_FaceActorTowardActor ; $5754
	ld a, $03 ; $5757
	ld d, $03 ; $5759
	farcall FarPtr_ScriptSetActorAnimation ; $575b
	ld a, $03 ; $575e
	farcall FarPtr_ScriptWaitActorIdle ; $5760
	push af ; $5763
	ld a, $1e ; $5764
	farcall FarPtr_WaitScriptFrames ; $5766
	pop af ; $5769
	ld a, $00 ; $576a
	ld b, a ; $576c
	ld a, $03 ; $576d
	farcall FarPtr_FaceActorTowardActor ; $576f
	ld a, $03 ; $5772
	ld d, $03 ; $5774
	farcall FarPtr_ScriptSetActorAnimation ; $5776
	ld a, $03 ; $5779
	farcall FarPtr_ScriptWaitActorIdle ; $577b
	ld a, $00 ; $577e
	ld b, $00 ; $5780
	farcall FarPtr_ScriptSetActorFacingLock ; $5782
	ld a, $00 ; $5785
	ld b, $c0 ; $5787
	farcall FarPtr_SetActorFacing ; $5789
	ld hl, $1007 ; $578c
	farcall FarPtr_InitDialogueTextCursor ; $578f
	set_flag $0e, 4 ; $5792
	ld a, [$c94d] ; $5795
	or a, a ; $5798
	jr nz, Label_12_57a1 ; $5799
	ld hl, $100b ; $579b
	farcall FarPtr_InitDialogueTextCursor ; $579e
Label_12_57a1:
	ld a, $03 ; $57a1
	farcall FarPtr_ScriptShowSpeakerDialogue ; $57a3
	ld a, $02 ; $57a6
	ld b, a ; $57a8
	ld a, $03 ; $57a9
	farcall FarPtr_FaceActorTowardActor ; $57ab
	ld a, $03 ; $57ae
	farcall FarPtr_ScriptShowSpeakerDialogue ; $57b0
	ld a, $02 ; $57b3
	ld d, $03 ; $57b5
	farcall FarPtr_ScriptSetActorAnimation ; $57b7
	ld a, $02 ; $57ba
	farcall FarPtr_ScriptWaitActorIdle ; $57bc
	ld a, $02 ; $57bf
	farcall FarPtr_ScriptShowSpeakerDialogue ; $57c1
	ld a, $00 ; $57c4
	ld bc, $0018 ; $57c6
	farcall FarPtr_ScriptSetActorMoveSpeed ; $57c9
	ld a, $02 ; $57cc
	ld bc, $0018 ; $57ce
	farcall FarPtr_ScriptSetActorMoveSpeed ; $57d1
	ld a, $02 ; $57d4
	ld bc, $2b00 ; $57d6
	ld de, $1b00 ; $57d9
	farcall FarPtr_ScriptSetActorMoveTarget ; $57dc
	ld a, $02 ; $57df
	farcall FarPtr_ScriptWaitActorMoveDone ; $57e1
	ld a, $03 ; $57e4
	ld b, a ; $57e6
	ld a, $02 ; $57e7
	farcall FarPtr_FaceActorTowardActor ; $57e9
	ld a, $02 ; $57ec
	ld b, a ; $57ee
	ld a, $03 ; $57ef
	farcall FarPtr_FaceActorTowardActor ; $57f1
Label_12_57f4:
	ld hl, $100a ; $57f4
	farcall FarPtr_InitDialogueTextCursor ; $57f7
	ld a, $03 ; $57fa
	farcall FarPtr_ScriptShowSpeakerDialogue ; $57fc
	ld a, $00 ; $57ff
	ld d, $03 ; $5801
	farcall FarPtr_ScriptSetActorAnimation ; $5803
	ld a, $02 ; $5806
	ld d, $03 ; $5808
	farcall FarPtr_ScriptSetActorAnimation ; $580a
	ld a, $02 ; $580d
	farcall FarPtr_ScriptWaitActorIdle ; $580f
	ld a, $02 ; $5812
	farcall FarPtr_GetActorStateAddr ; $5814
	ld c, l ; $5817
	ld b, h ; $5818
	ld de, $d000 ; $5819
	farcall FarPtr_04_20 ; $581c
	ret ; $581f
	ld a, [$c2b1] ; $5820
	add a, a ; $5823
	add a, $47 ; $5824
	ld l, a ; $5826
	adc a, $58 ; $5827
	sub a, l ; $5829
	ld h, a ; $582a
	ld a, [hl+] ; $582b
	ld h, [hl] ; $582c
	ld l, a ; $582d
	farcall FarPtr_InitDialogueTextCursor ; $582e
	ld a, $04 ; $5831
	farcall FarPtr_ScriptShowSpeakerDialogue ; $5833
	ld a, [$c2b1] ; $5836
	cp a, $02 ; $5839
	jr nc, Label_12_583f ; $583b
	jr Label_12_5846 ; $583d
Label_12_583f:
	ld a, [$c2b1] ; $583f
	cp a, $06 ; $5842
	jr c, Label_12_5846 ; $5844
Label_12_5846:
	ret ; $5846
	; $5847, 207 bytes (records:2)
	dw $100e ; record 0
	dw $100e ; record 1
	dw $101a ; record 2
	dw $101a ; record 3
	dw $101a ; record 4
	dw $101b ; record 5
	dw $1055 ; record 6
	dw $1055 ; record 7
	dw $1056 ; record 8
	dw $b1fa ; record 9
	dw $87c2 ; record 10
	dw $95c6 ; record 11
	dw $ce6f ; record 12
	dw $9558 ; record 13
	dw $2a67 ; record 14
	dw $6f66 ; record 15
	dw $0edf ; record 16
	dw $fa0a ; record 17
	dw $c2b1 ; record 18
	dw $04fe ; record 19
	dw $0628 ; record 20
	dw $053e ; record 21
	dw $08df ; record 22
	dw $c90a ; record 23
	dw $053e ; record 24
	dw $0adf ; record 25
	dw $df0a ; record 26
	dw $0a12 ; record 27
	dw $0cdf ; record 28
	dw $f50a ; record 29
	dw $053e ; record 30
	dw $04df ; record 31
	dw $f10a ; record 32
	dw $28a7 ; record 33
	dw $df03 ; record 34
	dw $0a10 ; record 35
	dw $053e ; record 36
	dw $08df ; record 37
	dw $c90a ; record 38
	dw $100f ; record 39
	dw $1018 ; record 40
	dw $101c ; record 41
	dw $101c ; record 42
	dw $101d ; record 43
	dw $1020 ; record 44
	dw $1057 ; record 45
	dw $1057 ; record 46
	dw $1058 ; record 47
	dw $108e ; record 48
	dw $1097 ; record 49
	dw $109f ; record 50
	dw $10a8 ; record 51
	dw $10b1 ; record 52
	dw $10ba ; record 53
	dw $b1fa ; record 54
	dw $87c2 ; record 55
	dw $f8c6 ; record 56
	dw $ce6f ; record 57
	dw $9558 ; record 58
	dw $2a67 ; record 59
	dw $6f66 ; record 60
	dw $0edf ; record 61
	dw $fa0a ; record 62
	dw $c2b1 ; record 63
	dw $06fe ; record 64
	dw $0628 ; record 65
	dw $063e ; record 66
	dw $08df ; record 67
	dw $c90a ; record 68
	dw $063e ; record 69
	dw $0adf ; record 70
	dw $df0a ; record 71
	dw $0a12 ; record 72
	dw $0cdf ; record 73
	dw $f50a ; record 74
	dw $053e ; record 75
	dw $04df ; record 76
	dw $f10a ; record 77
	dw $28a7 ; record 78
	dw $df0c ; record 79
	dw $0a10 ; record 80
	dw $4dfa ; record 81
	dw $b7c9 ; record 82
	dw $0320 ; record 83
	dw $10df ; record 84
	dw $3e0a ; record 85
	dw $df06 ; record 86
	dw $0a08 ; record 87
	dw $10c9 ; record 88
	dw $1010 ; record 89
	dw $2110 ; record 90
	dw $2210 ; record 91
	dw $2310 ; record 92
	dw $2410 ; record 93
	dw $5910 ; record 94
	dw $5e10 ; record 95
	dw $6010 ; record 96
	dw $8f10 ; record 97
	dw $9810 ; record 98
	dw $a010 ; record 99
	dw $a910 ; record 100
	dw $b210 ; record 101
	dw $bb10 ; record 102
	db $10
	ld a, [$c2b1] ; $5916
	add a, a ; $5919
	add a, $2d ; $591a
	ld l, a ; $591c
	adc a, $59 ; $591d
	sub a, l ; $591f
	ld h, a ; $5920
	ld a, [hl+] ; $5921
	ld h, [hl] ; $5922
	ld l, a ; $5923
	farcall FarPtr_InitDialogueTextCursor ; $5924
	ld a, $07 ; $5927
	farcall FarPtr_ScriptShowSpeakerDialogue ; $5929
	ret ; $592c
	; $592d, 30 bytes (records:2)
	dw $1011 ; record 0
	dw $1019 ; record 1
	dw $1025 ; record 2
	dw $1026 ; record 3
	dw $1026 ; record 4
	dw $1026 ; record 5
	dw $105d ; record 6
	dw $105f ; record 7
	dw $1061 ; record 8
	dw $1090 ; record 9
	dw $1099 ; record 10
	dw $10a1 ; record 11
	dw $10aa ; record 12
	dw $10b3 ; record 13
	dw $10bc ; record 14
	ld a, [$c2b1] ; $594b
	add a, a ; $594e
	add a, $2b ; $594f
	ld l, a ; $5951
	adc a, $5a ; $5952
	sub a, l ; $5954
	ld h, a ; $5955
	ld a, [hl+] ; $5956
	ld h, [hl] ; $5957
	ld l, a ; $5958
	farcall FarPtr_InitDialogueTextCursor ; $5959
	ld a, [$c2b1] ; $595c
	cp a, $02 ; $595f
	jr z, Label_12_5979 ; $5961
	jr nc, Label_12_5973 ; $5963
	ld a, $08 ; $5965
	ld b, $c0 ; $5967
	farcall FarPtr_SetActorFacing ; $5969
	ld a, $08 ; $596c
	ld d, $06 ; $596e
	farcall FarPtr_ScriptSetActorAnimation ; $5970
Label_12_5973:
	ld a, $08 ; $5973
	farcall FarPtr_ScriptShowSpeakerDialogue ; $5975
	ret ; $5978
Label_12_5979:
	ld a, $08 ; $5979
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $597b
	farcall FarPtr_RunDialogueYesNoPrompt ; $597e
	farcall FarPtr_ScriptCloseDialogueWindow ; $5981
	push af ; $5984
	ld a, $05 ; $5985
	farcall FarPtr_WaitScriptFrames ; $5987
	pop af ; $598a
	and a, a ; $598b
	jr z, Label_12_5994 ; $598c
	ld a, $08 ; $598e
	farcall FarPtr_ScriptShowSpeakerDialogue ; $5990
	ret ; $5993
Label_12_5994:
	farcall FarPtr_AdvanceDialogueTextCursor ; $5994
	ld a, $08 ; $5997
	ld d, $02 ; $5999
	farcall FarPtr_ScriptSetActorAnimation ; $599b
	ld a, $08 ; $599e
	farcall FarPtr_ScriptWaitActorIdle ; $59a0
	ld a, $08 ; $59a3
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $59a5
	farcall FarPtr_RunDialogueYesNoPrompt ; $59a8
	farcall FarPtr_ScriptCloseDialogueWindow ; $59ab
	push af ; $59ae
	ld a, $05 ; $59af
	farcall FarPtr_WaitScriptFrames ; $59b1
	pop af ; $59b4
	and a, a ; $59b5
	jr z, Label_12_59be ; $59b6
	ld a, $08 ; $59b8
	farcall FarPtr_ScriptShowSpeakerDialogue ; $59ba
	ret ; $59bd
Label_12_59be:
	push af ; $59be
	ld a, $0a ; $59bf
	farcall FarPtr_WaitScriptFrames ; $59c1
	pop af ; $59c4
	ldh a, [hRomBank] ; $59c5
	ld b, a ; $59c7
	ld a, $00 ; $59c8
	ld de, $7a5a ; $59ca
	farcall FarPtr_ScriptSetActorScript ; $59cd
	ld a, $08 ; $59d0
	ld bc, $0c00 ; $59d2
	ld de, $1500 ; $59d5
	farcall FarPtr_ScriptSetActorMoveTarget ; $59d8
	ld a, $08 ; $59db
	farcall FarPtr_ScriptWaitActorMoveDone ; $59dd
	ldh a, [hRomBank] ; $59e0
	ld b, a ; $59e2
	ld a, $08 ; $59e3
	ld de, $7a41 ; $59e5
	farcall FarPtr_ScriptSetActorScript ; $59e8
	xor a, a ; $59eb
	ld bc, $0a00 ; $59ec
	ld de, $1100 ; $59ef
	farcall FarPtr_MovePlayerToPosition ; $59f2
	farcall FarPtr_WaitPlayerMoveDone ; $59f5
	ld a, $08 ; $59f8
	farcall FarPtr_WaitActorScriptDone ; $59fa
	ld hl, wStoryModePlayersXPosition ; $59fd
	ld de, $c296 ; $5a00
	ld bc, $0005 ; $5a03
	call CopyMemoryBC ; $5a06
	ld a, $ff ; $5a09
	ld [$c295], a ; $5a0b
	ld [$c294], a ; $5a0e
	ld [$c2a1], a ; $5a11
	farcall FarPtr_InitStoryMatchSettings ; $5a14
	ld a, $00 ; $5a17
	ld [wCurrentMinigameStoryMatch], a ; $5a19
	ld a, $05 ; $5a1c
	ld [$c8f7], a ; $5a1e
	farcall FarPtr_LoadMatchSettingsFromTable ; $5a21
	farcall FarPtr_RunStoryMatch ; $5a24
	farcall FarPtr_RestoreOverworldAfterMatch ; $5a27
	ret ; $5a2a
	; $5a2b, 30 bytes (records:2)
	dw $1012 ; record 0
	dw $1012 ; record 1
	dw $1027 ; record 2
	dw $1030 ; record 3
	dw $1030 ; record 4
	dw $1030 ; record 5
	dw $1062 ; record 6
	dw $1063 ; record 7
	dw $1063 ; record 8
	dw $1091 ; record 9
	dw $109a ; record 10
	dw $10a2 ; record 11
	dw $10ab ; record 12
	dw $10b4 ; record 13
	dw $10bd ; record 14
	ld a, [$c2b1] ; $5a49
	add a, a ; $5a4c
	add a, $6e ; $5a4d
	ld l, a ; $5a4f
	adc a, $5a ; $5a50
	sub a, l ; $5a52
	ld h, a ; $5a53
	ld a, [hl+] ; $5a54
	ld h, [hl] ; $5a55
	ld l, a ; $5a56
	farcall FarPtr_InitDialogueTextCursor ; $5a57
	ld a, [$c2b1] ; $5a5a
	cp a, $02 ; $5a5d
	jr nc, Label_12_5a68 ; $5a5f
	ld a, $09 ; $5a61
	ld b, $40 ; $5a63
	farcall FarPtr_SetActorFacing ; $5a65
Label_12_5a68:
	ld a, $09 ; $5a68
	farcall FarPtr_ScriptShowSpeakerDialogue ; $5a6a
	ret ; $5a6d
	; $5a6e, 30 bytes (records:2)
	dw $1013 ; record 0
	dw $1013 ; record 1
	dw $102b ; record 2
	dw $1031 ; record 3
	dw $1031 ; record 4
	dw $1031 ; record 5
	dw $1064 ; record 6
	dw $1065 ; record 7
	dw $1065 ; record 8
	dw $1092 ; record 9
	dw $109b ; record 10
	dw $10a3 ; record 11
	dw $10ac ; record 12
	dw $10b5 ; record 13
	dw $10be ; record 14
	ld a, [$c2b1] ; $5a8c
	add a, a ; $5a8f
	add a, $75 ; $5a90
	ld l, a ; $5a92
	adc a, $5b ; $5a93
	sub a, l ; $5a95
	ld h, a ; $5a96
	ld a, [hl+] ; $5a97
	ld h, [hl] ; $5a98
	ld l, a ; $5a99
	farcall FarPtr_InitDialogueTextCursor ; $5a9a
	ld a, [$c2b1] ; $5a9d
	cp a, $06 ; $5aa0
	jr z, Label_12_5aaa ; $5aa2
	ld a, $0a ; $5aa4
	farcall FarPtr_ScriptShowSpeakerDialogue ; $5aa6
	ret ; $5aa9
Label_12_5aaa:
	ld a, $0a ; $5aaa
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $5aac
	farcall FarPtr_RunDialogueYesNoPrompt ; $5aaf
	farcall FarPtr_ScriptCloseDialogueWindow ; $5ab2
	push af ; $5ab5
	ld a, $05 ; $5ab6
	farcall FarPtr_WaitScriptFrames ; $5ab8
	pop af ; $5abb
	and a, a ; $5abc
	jr z, Label_12_5ac5 ; $5abd
	ld a, $0a ; $5abf
	farcall FarPtr_ScriptShowSpeakerDialogue ; $5ac1
	ret ; $5ac4
Label_12_5ac5:
	farcall FarPtr_AdvanceDialogueTextCursor ; $5ac5
	ld a, $0a ; $5ac8
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $5aca
	farcall FarPtr_RunDialogueYesNoPrompt ; $5acd
	farcall FarPtr_ScriptCloseDialogueWindow ; $5ad0
	push af ; $5ad3
	ld a, $05 ; $5ad4
	farcall FarPtr_WaitScriptFrames ; $5ad6
	pop af ; $5ad9
	and a, a ; $5ada
	jr z, Label_12_5ae3 ; $5adb
	ld a, $0a ; $5add
	farcall FarPtr_ScriptShowSpeakerDialogue ; $5adf
	ret ; $5ae2
Label_12_5ae3:
	ld a, $0a ; $5ae3
	farcall FarPtr_GetActorStateAddr ; $5ae5
	ld e, l ; $5ae8
	ld d, h ; $5ae9
	ld hl, $0005 ; $5aea
	add hl, de ; $5aed
	res 0, [hl] ; $5aee
	res 1, [hl] ; $5af0
	ld a, $00 ; $5af2
	ld bc, $0020 ; $5af4
	farcall FarPtr_ScriptSetActorMoveSpeed ; $5af7
	ld a, $02 ; $5afa
	ld bc, $0020 ; $5afc
	farcall FarPtr_ScriptSetActorMoveSpeed ; $5aff
	ldh a, [hRomBank] ; $5b02
	ld b, a ; $5b04
	ld a, $00 ; $5b05
	ld de, $7a07 ; $5b07
	farcall FarPtr_ScriptSetActorScript ; $5b0a
	push af ; $5b0d
	ld a, $20 ; $5b0e
	farcall FarPtr_WaitScriptFrames ; $5b10
	pop af ; $5b13
	ldh a, [hRomBank] ; $5b14
	ld b, a ; $5b16
	ld a, $02 ; $5b17
	ld de, $7a24 ; $5b19
	farcall FarPtr_ScriptSetActorScript ; $5b1c
	ldh a, [hRomBank] ; $5b1f
	ld b, a ; $5b21
	ld a, $0a ; $5b22
	ld de, $79f1 ; $5b24
	farcall FarPtr_ScriptSetActorScript ; $5b27
	ldh a, [hRomBank] ; $5b2a
	ld b, a ; $5b2c
	ld a, $0b ; $5b2d
	ld de, $79fc ; $5b2f
	farcall FarPtr_ScriptSetActorScript ; $5b32
	xor a, a ; $5b35
	ld bc, $0a00 ; $5b36
	ld de, $1100 ; $5b39
	farcall FarPtr_MovePlayerToPosition ; $5b3c
	farcall FarPtr_WaitPlayerMoveDone ; $5b3f
	ld a, $00 ; $5b42
	farcall FarPtr_WaitActorScriptDone ; $5b44
	ld hl, wStoryModePlayersXPosition ; $5b47
	ld de, $c296 ; $5b4a
	ld bc, $0005 ; $5b4d
	call CopyMemoryBC ; $5b50
	ld a, $ff ; $5b53
	ld [$c295], a ; $5b55
	ld [$c294], a ; $5b58
	ld [$c2a1], a ; $5b5b
	farcall FarPtr_InitStoryMatchSettings ; $5b5e
	ld a, $01 ; $5b61
	ld [wCurrentMinigameStoryMatch], a ; $5b63
	ld a, $05 ; $5b66
	ld [$c8f7], a ; $5b68
	farcall FarPtr_LoadMatchSettingsFromTable ; $5b6b
	farcall FarPtr_RunStoryMatch ; $5b6e
	farcall FarPtr_RestoreOverworldAfterMatch ; $5b71
	ret ; $5b74
	; $5b75, 30 bytes (records:2)
	dw $1014 ; record 0
	dw $1014 ; record 1
	dw $102c ; record 2
	dw $1032 ; record 3
	dw $1032 ; record 4
	dw $1032 ; record 5
	dw $1066 ; record 6
	dw $106c ; record 7
	dw $106c ; record 8
	dw $1093 ; record 9
	dw $109c ; record 10
	dw $10a4 ; record 11
	dw $10ad ; record 12
	dw $10b6 ; record 13
	dw $10bf ; record 14
	ld a, [$c2b1] ; $5b93
	add a, a ; $5b96
	add a, $bf ; $5b97
	ld l, a ; $5b99
	adc a, $5b ; $5b9a
	sub a, l ; $5b9c
	ld h, a ; $5b9d
	ld a, [hl+] ; $5b9e
	ld h, [hl] ; $5b9f
	ld l, a ; $5ba0
	farcall FarPtr_InitDialogueTextCursor ; $5ba1
	ld a, [$c2b1] ; $5ba4
	cp a, $0c ; $5ba7
	jr c, Label_12_5bb9 ; $5ba9
	test_flag $05, 7 ; $5bab
	jr z, Label_12_5bb9 ; $5bae
	ld a, [$c94d] ; $5bb0
	and a, a ; $5bb3
	jr nz, Label_12_5bb9 ; $5bb4
	farcall FarPtr_AdvanceDialogueTextCursor ; $5bb6
Label_12_5bb9:
	ld a, $0b ; $5bb9
	farcall FarPtr_ScriptShowSpeakerDialogue ; $5bbb
	ret ; $5bbe
	; $5bbf, 30 bytes (records:2)
	dw $1015 ; record 0
	dw $1015 ; record 1
	dw $102d ; record 2
	dw $1033 ; record 3
	dw $1033 ; record 4
	dw $1033 ; record 5
	dw $106b ; record 6
	dw $106d ; record 7
	dw $106d ; record 8
	dw $1094 ; record 9
	dw $109d ; record 10
	dw $10a5 ; record 11
	dw $10ae ; record 12
	dw $10b7 ; record 13
	dw $10ae ; record 14
	ld a, [$c94d] ; $5bdd
	or a, a ; $5be0
	jr nz, Label_12_5bfa ; $5be1
	ld a, [$c2b1] ; $5be3
	add a, a ; $5be6
	add a, $2f ; $5be7
	ld l, a ; $5be9
	adc a, $5c ; $5bea
	sub a, l ; $5bec
	ld h, a ; $5bed
	ld a, [hl+] ; $5bee
	ld h, [hl] ; $5bef
	ld l, a ; $5bf0
	farcall FarPtr_InitDialogueTextCursor ; $5bf1
	ld a, $0c ; $5bf4
	farcall FarPtr_ScriptShowSpeakerDialogue ; $5bf6
	ret ; $5bf9
Label_12_5bfa:
	ld a, [$c2b1] ; $5bfa
	add a, a ; $5bfd
	add a, $11 ; $5bfe
	ld l, a ; $5c00
	adc a, $5c ; $5c01
	sub a, l ; $5c03
	ld h, a ; $5c04
	ld a, [hl+] ; $5c05
	ld h, [hl] ; $5c06
	ld l, a ; $5c07
	farcall FarPtr_InitDialogueTextCursor ; $5c08
	ld a, $0c ; $5c0b
	farcall FarPtr_ScriptShowSpeakerDialogue ; $5c0d
	ret ; $5c10
	; $5c11, 60 bytes (records:2)
	dw $1016 ; record 0
	dw $1016 ; record 1
	dw $102e ; record 2
	dw $1034 ; record 3
	dw $1034 ; record 4
	dw $1034 ; record 5
	dw $106c ; record 6
	dw $106e ; record 7
	dw $106e ; record 8
	dw $1095 ; record 9
	dw $109e ; record 10
	dw $10a6 ; record 11
	dw $10af ; record 12
	dw $10b8 ; record 13
	dw $10ba ; record 14
	dw $1017 ; record 15
	dw $1017 ; record 16
	dw $102f ; record 17
	dw $1035 ; record 18
	dw $1035 ; record 19
	dw $1035 ; record 20
	dw $106c ; record 21
	dw $106e ; record 22
	dw $106e ; record 23
	dw $1096 ; record 24
	dw $109e ; record 25
	dw $10a7 ; record 26
	dw $10af ; record 27
	dw $10b9 ; record 28
	dw $10ba ; record 29
	; $5c4d, 122 bytes (records:8)
; 15 records x 8 bytes
	dw $1003, $0840, $5630, $0001 ; record 0
	dw $4003, $0840, $569b, $0001 ; record 1
	dw $4003, $0000, $55f7, $0001 ; record 2
	dw $ff03, $0000, $55e8, $0001 ; record 3
	dw $ff04, $0000, $5820, $001b ; record 4
	dw $ff05, $0000, $5859, $0013 ; record 5
	dw $ff06, $08a0, $58b3, $0013 ; record 6
	dw $ff06, $0000, $58b3, $0011 ; record 7
	dw $ff07, $08a0, $5916, $0003 ; record 8
	dw $ff07, $0000, $5916, $0001 ; record 9
	dw $ff08, $0000, $594b, $000b ; record 10
	dw $ff09, $0000, $5a49, $0013 ; record 11
	dw $ff0a, $0000, $5a8c, $0013 ; record 12
	dw $ff0b, $0000, $5b93, $001b ; record 13
	dw $ff0c, $0000, $5bdd, $0013 ; record 14
	db $ff, $ff
	; $5cc7, 9 bytes (records:8)
; 1 records x 8 bytes
	dw $ff01, $0f80, $5cd0, $0000 ; record 0
	db $ff
	set_flag $0f, 4 ; $5cd0
	ld a, $0a ; $5cd3
	farcall FarPtr_SetActorNullScript ; $5cd5
	ld a, $0b ; $5cd8
	farcall FarPtr_SetActorNullScript ; $5cda
	ld a, $0a ; $5cdd
	ld d, $01 ; $5cdf
	farcall FarPtr_ScriptSetActorAnimation ; $5ce1
	ld a, $0b ; $5ce4
	ld d, $01 ; $5ce6
	farcall FarPtr_ScriptSetActorAnimation ; $5ce8
	ld a, $0a ; $5ceb
	ld bc, $1400 ; $5ced
	ld de, $1300 ; $5cf0
	farcall FarPtr_ScriptSetActorMoveTarget ; $5cf3
	ld a, $0b ; $5cf6
	ld bc, $1400 ; $5cf8
	ld de, $0f00 ; $5cfb
	farcall FarPtr_ScriptSetActorMoveTarget ; $5cfe
	ld a, $0a ; $5d01
	farcall FarPtr_ScriptWaitActorMoveDone ; $5d03
	ld a, $0b ; $5d06
	farcall FarPtr_ScriptWaitActorMoveDone ; $5d08
	ld a, $00 ; $5d0b
	ld b, a ; $5d0d
	ld a, $0a ; $5d0e
	farcall FarPtr_FaceActorTowardActor ; $5d10
	ld a, $00 ; $5d13
	ld b, a ; $5d15
	ld a, $0b ; $5d16
	farcall FarPtr_FaceActorTowardActor ; $5d18
	ret ; $5d1b
	call ComputeSeniorCourtStageB ; $5d1c
	call ComputeSeniorCourtStage ; $5d1f
	ld a, [$c2b1] ; $5d22
	cp a, $02 ; $5d25
	jr nc, Label_12_5d7b ; $5d27
	ld b, $00 ; $5d29
	ld c, $2a ; $5d2b
	ld d, $10 ; $5d2d
	ld e, $0a ; $5d2f
	ld h, $08 ; $5d31
	ld l, $0e ; $5d33
	farcall FarPtr_CopyBehaviorMapRect ; $5d35
	test_flag $0f, 4 ; $5d38
	jr z, Label_12_5d7b ; $5d3b
	ld a, $0a ; $5d3d
	farcall FarPtr_SetActorNullScript ; $5d3f
	ld a, $0b ; $5d42
	farcall FarPtr_SetActorNullScript ; $5d44
	ld a, $0a ; $5d47
	ld d, $01 ; $5d49
	farcall FarPtr_ScriptSetActorAnimation ; $5d4b
	ld a, $0b ; $5d4e
	ld d, $01 ; $5d50
	farcall FarPtr_ScriptSetActorAnimation ; $5d52
	ld a, $0a ; $5d55
	ld bc, $1400 ; $5d57
	ld de, $1300 ; $5d5a
	farcall FarPtr_ScriptSetActorPosition ; $5d5d
	ld a, $0b ; $5d60
	ld bc, $1400 ; $5d62
	ld de, $0f00 ; $5d65
	farcall FarPtr_ScriptSetActorPosition ; $5d68
	ld a, $00 ; $5d6b
	ld b, a ; $5d6d
	ld a, $0a ; $5d6e
	farcall FarPtr_FaceActorTowardActor ; $5d70
	ld a, $00 ; $5d73
	ld b, a ; $5d75
	ld a, $0b ; $5d76
	farcall FarPtr_FaceActorTowardActor ; $5d78
Label_12_5d7b:
	test_flag $05, 7 ; $5d7b
	jr nz, Label_12_5daf ; $5d7e
	test_flag $0a, 3 ; $5d80
	jr z, Label_12_5d8d ; $5d83
	ldh a, [hRomBank] ; $5d85
	ld hl, $53b7 ; $5d87
	farcall FarPtr_ScriptRespawnLocationActors ; $5d8a
Label_12_5d8d:
	call Func_12_5e12 ; $5d8d
	call Func_12_5e91 ; $5d90
	ld a, [$c295] ; $5d93
	cp a, $0f ; $5d96
	jp z, SeniorCourtPostMatchReturn ; $5d98
	cp a, $0e ; $5d9b
	jp z, Label_12_6d8a ; $5d9d
	cp a, $0d ; $5da0
	jp z, SeniorMatchVictorySceneDispatch ; $5da2
	call Func_12_5dbe ; $5da5
	farcall FarPtr_EndCutsceneScriptMode ; $5da8
	call Func_12_5eab ; $5dab
	ret ; $5dae
Label_12_5daf:
	test_flag $08, 2 ; $5daf
	jr z, Label_12_5d8d ; $5db2
	ldh a, [hRomBank] ; $5db4
	ld hl, $5493 ; $5db6
	farcall FarPtr_ScriptRespawnLocationActors ; $5db9
	jr Label_12_5d8d ; $5dbc
Func_12_5dbe:
	ld a, [$c2b1] ; $5dbe
	cp a, $0b ; $5dc1
	jr c, Label_12_5ddc ; $5dc3
	cp a, $0d ; $5dc5
	jr nc, Label_12_5ddc ; $5dc7
	ld a, $03 ; $5dc9
	farcall FarPtr_GetActorStateAddr ; $5dcb
	ld c, l ; $5dce
	ld b, h ; $5dcf
	ld d, $3b ; $5dd0
	farcall FarPtr_04_2c ; $5dd2
	ld a, $03 ; $5dd5
	ld d, $01 ; $5dd7
	farcall FarPtr_ScriptSetActorAnimation ; $5dd9
Label_12_5ddc:
	test_flag $05, 7 ; $5ddc
	jr nz, Label_12_5df4 ; $5ddf
	ld a, [$c2b1] ; $5de1
	cp a, $09 ; $5de4
	jr c, Label_12_5df3 ; $5de6
	ld a, $04 ; $5de8
	ld bc, $3f00 ; $5dea
	ld de, $3f00 ; $5ded
	farcall FarPtr_ScriptSetActorPosition ; $5df0
Label_12_5df3:
	ret ; $5df3
Label_12_5df4:
	ld a, [$c2b1] ; $5df4
	cp a, $0a ; $5df7
	jr c, Label_12_5df3 ; $5df9
	ld a, $04 ; $5dfb
	ld bc, $3f00 ; $5dfd
	ld de, $3f00 ; $5e00
	farcall FarPtr_ScriptSetActorPosition ; $5e03
	ld a, $05 ; $5e06
	ld bc, $3f00 ; $5e08
	ld de, $3f00 ; $5e0b
	farcall FarPtr_ScriptSetActorPosition ; $5e0e
	ret ; $5e11
Func_12_5e12:
	test_flag $05, 7 ; $5e12
	jr nz, Label_12_5e38 ; $5e15
	ld a, [$c2b1] ; $5e17
	cp a, $03 ; $5e1a
	jr c, Label_12_5e30 ; $5e1c
	ld a, $07 ; $5e1e
	ld bc, $1b00 ; $5e20
	ld de, $0d00 ; $5e23
	farcall FarPtr_ScriptSetActorPosition ; $5e26
	ld a, $07 ; $5e29
	ld b, $80 ; $5e2b
	farcall FarPtr_SetActorFacing ; $5e2d
Label_12_5e30:
	ld a, [$c2b1] ; $5e30
	cp a, $09 ; $5e33
	jr c, Label_12_5e37 ; $5e35
Label_12_5e37:
	ret ; $5e37
Label_12_5e38:
	ld a, [$c2b1] ; $5e38
	cp a, $07 ; $5e3b
	jr c, Label_12_5e73 ; $5e3d
	cp a, $09 ; $5e3f
	jr nc, Label_12_5e73 ; $5e41
	ld a, $09 ; $5e43
	ld bc, $1b00 ; $5e45
	ld de, $0b00 ; $5e48
	farcall FarPtr_ScriptSetActorPosition ; $5e4b
	ld a, $08 ; $5e4e
	ld bc, $1b00 ; $5e50
	ld de, $0d00 ; $5e53
	farcall FarPtr_ScriptSetActorPosition ; $5e56
	ld a, $09 ; $5e59
	ld b, $80 ; $5e5b
	farcall FarPtr_SetActorFacing ; $5e5d
	ld a, $08 ; $5e60
	ld b, $80 ; $5e62
	farcall FarPtr_SetActorFacing ; $5e64
	ld a, $08 ; $5e67
	farcall FarPtr_SetActorNullScript ; $5e69
	ld a, $08 ; $5e6c
	ld d, $01 ; $5e6e
	farcall FarPtr_ScriptSetActorAnimation ; $5e70
Label_12_5e73:
	ld a, [$c2b1] ; $5e73
	cp a, $0a ; $5e76
	jr c, Label_12_5e30 ; $5e78
	ld a, $04 ; $5e7a
	ld bc, $3f00 ; $5e7c
	ld de, $3f00 ; $5e7f
	farcall FarPtr_ScriptSetActorPosition ; $5e82
	ld a, $05 ; $5e85
	ld bc, $3f00 ; $5e87
	ld de, $3f00 ; $5e8a
	farcall FarPtr_ScriptSetActorPosition ; $5e8d
	ret ; $5e90
Func_12_5e91:
	ld a, [$c94d] ; $5e91
	or a, a ; $5e94
	jr nz, Label_12_5eaa ; $5e95
	ld a, $0c ; $5e97
	farcall FarPtr_GetActorStateAddr ; $5e99
	ld c, l ; $5e9c
	ld b, h ; $5e9d
	ld d, $28 ; $5e9e
	farcall FarPtr_04_2c ; $5ea0
	ld a, $0c ; $5ea3
	ld d, $01 ; $5ea5
	farcall FarPtr_ScriptSetActorAnimation ; $5ea7
Label_12_5eaa:
	ret ; $5eaa
Func_12_5eab:
	ld a, [$c295] ; $5eab
	cp a, $01 ; $5eae
	jp nz, Label_12_5ef0 ; $5eb0
	test_flag $05, 7 ; $5eb3
	jr z, Label_12_5ede ; $5eb6
	ld a, $02 ; $5eb8
	ld bc, $00ff ; $5eba
	farcall FarPtr_ScriptSetActorMoveSpeed ; $5ebd
	ld a, $02 ; $5ec0
	ld b, $40 ; $5ec2
	ld de, $0200 ; $5ec4
	farcall FarPtr_MoveActorByAngle ; $5ec7
	ld a, $02 ; $5eca
	farcall FarPtr_ScriptWaitActorMoveDone ; $5ecc
	ld a, $02 ; $5ecf
	ld b, $c0 ; $5ed1
	farcall FarPtr_SetActorFacing ; $5ed3
	ld a, $02 ; $5ed6
	ld bc, $0010 ; $5ed8
	farcall FarPtr_ScriptSetActorMoveSpeed ; $5edb
Label_12_5ede:
	ld a, $00 ; $5ede
	ld bc, $0010 ; $5ee0
	farcall FarPtr_ScriptSetActorMoveSpeed ; $5ee3
	ld a, $00 ; $5ee6
	ld b, $c0 ; $5ee8
	ld de, $0200 ; $5eea
	farcall FarPtr_MoveActorByAngle ; $5eed
Label_12_5ef0:
	ret ; $5ef0
Func_12_5ef1:
	ld a, $00 ; $5ef1
	ld bc, $0010 ; $5ef3
	farcall FarPtr_ScriptSetActorMoveSpeed ; $5ef6
	test_flag $05, 7 ; $5ef9
	jp z, SeniorSinglesRankOfferScene ; $5efc
	call SeniorDoublesRankOfferScene ; $5eff
	ret ; $5f02
Func_12_5f03:
	ld a, $00 ; $5f03
	ld bc, $0008 ; $5f05
	farcall FarPtr_ScriptSetActorMoveSpeed ; $5f08
	ld a, $00 ; $5f0b
	ld b, $c0 ; $5f0d
	farcall FarPtr_SetActorFacing ; $5f0f
	ld a, $00 ; $5f12
	ld b, $01 ; $5f14
	farcall FarPtr_ScriptSetActorFacingLock ; $5f16
	test_flag $05, 7 ; $5f19
	jr z, SeniorSinglesRankOfferScene ; $5f1c
	call SeniorDoublesRankOfferScene ; $5f1e
	ret ; $5f21
SeniorSinglesRankOfferScene:
	ld a, $00 ; $5f22
	ld bc, $2d00 ; $5f24
	ld de, $1b00 ; $5f27
	farcall FarPtr_ScriptSetActorMoveTarget ; $5f2a
	ld a, $00 ; $5f2d
	farcall FarPtr_ScriptWaitActorMoveDone ; $5f2f
	push af ; $5f32
	ld a, $0a ; $5f33
	farcall FarPtr_WaitScriptFrames ; $5f35
	pop af ; $5f38
	ld a, $00 ; $5f39
	ld b, $00 ; $5f3b
	farcall FarPtr_ScriptSetActorFacingLock ; $5f3d
	ld a, $03 ; $5f40
	ld b, a ; $5f42
	ld a, $00 ; $5f43
	farcall FarPtr_FaceActorTowardActor ; $5f45
	ld a, $00 ; $5f48
	ld b, a ; $5f4a
	ld a, $03 ; $5f4b
	farcall FarPtr_FaceActorTowardActor ; $5f4d
	ld hl, $103c ; $5f50
	farcall FarPtr_InitDialogueTextCursor ; $5f53
	test_flag $0a, 4 ; $5f56
	jr z, Label_12_5f5e ; $5f59
	farcall FarPtr_AdvanceDialogueTextCursor ; $5f5b
Label_12_5f5e:
	ld a, $03 ; $5f5e
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $5f60
	farcall FarPtr_RunDialogueYesNoPrompt ; $5f63
	farcall FarPtr_ScriptCloseDialogueWindow ; $5f66
	push af ; $5f69
	ld a, $05 ; $5f6a
	farcall FarPtr_WaitScriptFrames ; $5f6c
	pop af ; $5f6f
	and a, a ; $5f70
	jp nz, Label_12_5fb8 ; $5f71
	ld hl, $1040 ; $5f74
	farcall FarPtr_InitDialogueTextCursor ; $5f77
	test_flag $0a, 4 ; $5f7a
	jr z, Label_12_5f92 ; $5f7d
	farcall FarPtr_AdvanceDialogueTextCursor ; $5f7f
	test_flag $0a, 5 ; $5f82
	jr z, Label_12_5f92 ; $5f85
	farcall FarPtr_AdvanceDialogueTextCursor ; $5f87
	test_flag $0a, 6 ; $5f8a
	jr z, Label_12_5f92 ; $5f8d
	farcall FarPtr_AdvanceDialogueTextCursor ; $5f8f
Label_12_5f92:
	ld a, $03 ; $5f92
	farcall FarPtr_ScriptShowSpeakerDialogue ; $5f94
	call RunSeniorRankingMatchIntro ; $5f97
	ld a, $00 ; $5f9a
	ld b, $c0 ; $5f9c
	farcall FarPtr_SetActorFacing ; $5f9e
	push af ; $5fa1
	ld a, $0f ; $5fa2
	farcall FarPtr_WaitScriptFrames ; $5fa4
	pop af ; $5fa7
	ld a, $03 ; $5fa8
	ld d, $02 ; $5faa
	farcall FarPtr_ScriptSetActorAnimation ; $5fac
	ld a, $03 ; $5faf
	farcall FarPtr_ScriptWaitActorIdle ; $5fb1
	call SeniorSinglesMatchConfirm ; $5fb4
	ret ; $5fb7
Label_12_5fb8:
	ld hl, $103e ; $5fb8
	farcall FarPtr_InitDialogueTextCursor ; $5fbb
	ld a, $03 ; $5fbe
	farcall FarPtr_ScriptShowSpeakerDialogue ; $5fc0
	farcall FarPtr_EndCutsceneScriptMode ; $5fc3
	ret ; $5fc6
SeniorDoublesRankOfferScene:
	ld a, $02 ; $5fc7
	farcall FarPtr_SetActorNullScript ; $5fc9
	push af ; $5fcc
	ld a, $0a ; $5fcd
	farcall FarPtr_WaitScriptFrames ; $5fcf
	pop af ; $5fd2
	ld a, $02 ; $5fd3
	ld bc, $2d00 ; $5fd5
	ld de, $1d00 ; $5fd8
	farcall FarPtr_ScriptSetActorMoveTarget ; $5fdb
	ld a, $00 ; $5fde
	ld bc, $2d00 ; $5fe0
	ld de, $1b00 ; $5fe3
	farcall FarPtr_ScriptSetActorMoveTarget ; $5fe6
	push af ; $5fe9
	ld a, $0a ; $5fea
	farcall FarPtr_WaitScriptFrames ; $5fec
	pop af ; $5fef
	ld a, $00 ; $5ff0
	farcall FarPtr_ScriptWaitActorMoveDone ; $5ff2
	ld a, $00 ; $5ff5
	ld b, $00 ; $5ff7
	farcall FarPtr_ScriptSetActorFacingLock ; $5ff9
	ld a, $03 ; $5ffc
	ld b, a ; $5ffe
	ld a, $00 ; $5fff
	farcall FarPtr_FaceActorTowardActor ; $6001
	ld a, $02 ; $6004
	farcall FarPtr_ScriptWaitActorMoveDone ; $6006
	ld a, $03 ; $6009
	ld b, a ; $600b
	ld a, $02 ; $600c
	farcall FarPtr_FaceActorTowardActor ; $600e
	push af ; $6011
	ld a, $1e ; $6012
	farcall FarPtr_WaitScriptFrames ; $6014
	pop af ; $6017
	ld a, $00 ; $6018
	ld b, a ; $601a
	ld a, $03 ; $601b
	farcall FarPtr_FaceActorTowardActor ; $601d
	ld hl, $106e ; $6020
	farcall FarPtr_InitDialogueTextCursor ; $6023
	test_flag $08, 4 ; $6026
	jr z, Label_12_602e ; $6029
	farcall FarPtr_AdvanceDialogueTextCursor ; $602b
Label_12_602e:
	ld a, $03 ; $602e
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $6030
	farcall FarPtr_RunDialogueYesNoPrompt ; $6033
	farcall FarPtr_ScriptCloseDialogueWindow ; $6036
	push af ; $6039
	ld a, $05 ; $603a
	farcall FarPtr_WaitScriptFrames ; $603c
	pop af ; $603f
	and a, a ; $6040
	jp nz, Label_12_6087 ; $6041
	ld hl, $1071 ; $6044
	farcall FarPtr_InitDialogueTextCursor ; $6047
	test_flag $08, 4 ; $604a
	jr z, Label_12_605a ; $604d
	farcall FarPtr_AdvanceDialogueTextCursor ; $604f
	test_flag $08, 5 ; $6052
	jr z, Label_12_605a ; $6055
	farcall FarPtr_AdvanceDialogueTextCursor ; $6057
Label_12_605a:
	ld a, $03 ; $605a
	farcall FarPtr_ScriptShowSpeakerDialogue ; $605c
	call RunSeniorRankingMatchIntro ; $605f
	ld a, $00 ; $6062
	ld b, $c0 ; $6064
	farcall FarPtr_SetActorFacing ; $6066
	ld a, $02 ; $6069
	ld b, $c0 ; $606b
	farcall FarPtr_SetActorFacing ; $606d
	push af ; $6070
	ld a, $0f ; $6071
	farcall FarPtr_WaitScriptFrames ; $6073
	pop af ; $6076
	ld a, $03 ; $6077
	ld d, $02 ; $6079
	farcall FarPtr_ScriptSetActorAnimation ; $607b
	ld a, $03 ; $607e
	farcall FarPtr_ScriptWaitActorIdle ; $6080
	call SeniorDoublesMatchConfirm ; $6083
	ret ; $6086
Label_12_6087:
	ld hl, $1070 ; $6087
	farcall FarPtr_InitDialogueTextCursor ; $608a
	ld a, $03 ; $608d
	farcall FarPtr_ScriptShowSpeakerDialogue ; $608f
	ld a, $02 ; $6092
	farcall FarPtr_GetActorStateAddr ; $6094
	ld c, l ; $6097
	ld b, h ; $6098
	ld de, $d000 ; $6099
	farcall FarPtr_04_20 ; $609c
	ret ; $609f
StartSeniorRankingMatch:
	ld a, $00 ; $60a0
	ld bc, $0020 ; $60a2
	farcall FarPtr_ScriptSetActorMoveSpeed ; $60a5
	ld a, $02 ; $60a8
	ld bc, $0020 ; $60aa
	farcall FarPtr_ScriptSetActorMoveSpeed ; $60ad
	ld a, [$c2b1] ; $60b0
	sub a, $02 ; $60b3
	rst Rst00 ; $60b5
	dw Label_12_6232 ; $60b6 jumptable
	dw Label_12_628a ; $60b8 jumptable
	dw Label_12_62e9 ; $60ba jumptable
	dw Label_12_6348 ; $60bc jumptable
	dw Label_12_60c4 ; $60be jumptable
	dw Label_12_6136 ; $60c0 jumptable
	dw Label_12_61b2 ; $60c2 jumptable
Label_12_60c4:
	ld a, $03 ; $60c4
	ld b, $80 ; $60c6
	farcall FarPtr_SetActorFacing ; $60c8
	push af ; $60cb
	ld a, $0f ; $60cc
	farcall FarPtr_WaitScriptFrames ; $60ce
	pop af ; $60d1
	ldh a, [hRomBank] ; $60d2
	ld b, a ; $60d4
	ld a, $09 ; $60d5
	ld de, $7876 ; $60d7
	farcall FarPtr_ScriptSetActorScript ; $60da
	ldh a, [hRomBank] ; $60dd
	ld b, a ; $60df
	ld a, $08 ; $60e0
	ld de, $7838 ; $60e2
	farcall FarPtr_ScriptSetActorScript ; $60e5
	ldh a, [hRomBank] ; $60e8
	ld b, a ; $60ea
	ld a, $02 ; $60eb
	ld de, $6d0e ; $60ed
	farcall FarPtr_ScriptSetActorScript ; $60f0
	ldh a, [hRomBank] ; $60f3
	ld b, a ; $60f5
	ld a, $00 ; $60f6
	ld de, $6cec ; $60f8
	farcall FarPtr_ScriptSetActorScript ; $60fb
	xor a, a ; $60fe
	ld bc, $2400 ; $60ff
	ld de, $1700 ; $6102
	farcall FarPtr_MovePlayerToPosition ; $6105
	farcall FarPtr_WaitPlayerMoveDone ; $6108
	ld a, $08 ; $610b
	farcall FarPtr_WaitActorScriptDone ; $610d
	push af ; $6110
	ld a, $1e ; $6111
	farcall FarPtr_WaitScriptFrames ; $6113
	pop af ; $6116
	ld a, $0f ; $6117
	ld [$c294], a ; $6119
	ld [$c2a1], a ; $611c
	farcall FarPtr_InitStoryMatchSettings ; $611f
	ld a, $01 ; $6122
	ld [wCurrentMinigameStoryMatch], a ; $6124
	ld a, $07 ; $6127
	ld [$c8f7], a ; $6129
	farcall FarPtr_LoadMatchSettingsFromTable ; $612c
	farcall FarPtr_RunStoryMatch ; $612f
	farcall FarPtr_RestoreOverworldAfterMatch ; $6132
	ret ; $6135
Label_12_6136:
	ld a, $03 ; $6136
	ld b, $00 ; $6138
	farcall FarPtr_SetActorFacing ; $613a
	push af ; $613d
	ld a, $0f ; $613e
	farcall FarPtr_WaitScriptFrames ; $6140
	pop af ; $6143
	ld a, $00 ; $6144
	ld b, $00 ; $6146
	farcall FarPtr_SetActorFacing ; $6148
	ld a, $02 ; $614b
	ld b, $00 ; $614d
	farcall FarPtr_SetActorFacing ; $614f
	ld a, $07 ; $6152
	ld b, $00 ; $6154
	farcall FarPtr_SetActorFacing ; $6156
	ld a, $06 ; $6159
	ld b, $00 ; $615b
	farcall FarPtr_SetActorFacing ; $615d
	call Func_12_63d3 ; $6160
	ldh a, [hRomBank] ; $6163
	ld b, a ; $6165
	ld a, $06 ; $6166
	ld de, $78d9 ; $6168
	farcall FarPtr_ScriptSetActorScript ; $616b
	ldh a, [hRomBank] ; $616e
	ld b, a ; $6170
	ld a, $07 ; $6171
	ld de, $78ea ; $6173
	farcall FarPtr_ScriptSetActorScript ; $6176
	ldh a, [hRomBank] ; $6179
	ld b, a ; $617b
	ld a, $02 ; $617c
	ld de, $6d1f ; $617e
	farcall FarPtr_ScriptSetActorScript ; $6181
	farcall FarPtr_WaitPlayerMoveDone ; $6184
	ld a, $07 ; $6187
	farcall FarPtr_WaitActorScriptDone ; $6189
	push af ; $618c
	ld a, $1e ; $618d
	farcall FarPtr_WaitScriptFrames ; $618f
	pop af ; $6192
	ld a, $0f ; $6193
	ld [$c294], a ; $6195
	ld [$c2a1], a ; $6198
	farcall FarPtr_InitStoryMatchSettings ; $619b
	ld a, $01 ; $619e
	ld [wCurrentMinigameStoryMatch], a ; $61a0
	ld a, $08 ; $61a3
	ld [$c8f7], a ; $61a5
	farcall FarPtr_LoadMatchSettingsFromTable ; $61a8
	farcall FarPtr_RunStoryMatch ; $61ab
	farcall FarPtr_RestoreOverworldAfterMatch ; $61ae
	ret ; $61b1
Label_12_61b2:
	ld a, $03 ; $61b2
	ld b, $80 ; $61b4
	farcall FarPtr_SetActorFacing ; $61b6
	push af ; $61b9
	ld a, $0f ; $61ba
	farcall FarPtr_WaitScriptFrames ; $61bc
	pop af ; $61bf
	ld a, $00 ; $61c0
	ld b, $80 ; $61c2
	farcall FarPtr_SetActorFacing ; $61c4
	ld a, $07 ; $61c7
	ld b, $80 ; $61c9
	farcall FarPtr_SetActorFacing ; $61cb
	ldh a, [hRomBank] ; $61ce
	ld b, a ; $61d0
	ld a, $05 ; $61d1
	ld de, $796f ; $61d3
	farcall FarPtr_ScriptSetActorScript ; $61d6
	ldh a, [hRomBank] ; $61d9
	ld b, a ; $61db
	ld a, $04 ; $61dc
	ld de, $7980 ; $61de
	farcall FarPtr_ScriptSetActorScript ; $61e1
	ldh a, [hRomBank] ; $61e4
	ld b, a ; $61e6
	ld a, $02 ; $61e7
	ld de, $6d0e ; $61e9
	farcall FarPtr_ScriptSetActorScript ; $61ec
	ldh a, [hRomBank] ; $61ef
	ld b, a ; $61f1
	ld a, $00 ; $61f2
	ld de, $6cec ; $61f4
	farcall FarPtr_ScriptSetActorScript ; $61f7
	xor a, a ; $61fa
	ld bc, $2400 ; $61fb
	ld de, $1700 ; $61fe
	farcall FarPtr_MovePlayerToPosition ; $6201
	farcall FarPtr_WaitPlayerMoveDone ; $6204
	ld a, $04 ; $6207
	farcall FarPtr_WaitActorScriptDone ; $6209
	push af ; $620c
	ld a, $1e ; $620d
	farcall FarPtr_WaitScriptFrames ; $620f
	pop af ; $6212
	ld a, $0f ; $6213
	ld [$c294], a ; $6215
	ld [$c2a1], a ; $6218
	farcall FarPtr_InitStoryMatchSettings ; $621b
	ld a, $01 ; $621e
	ld [wCurrentMinigameStoryMatch], a ; $6220
	ld a, $09 ; $6223
	ld [$c8f7], a ; $6225
	farcall FarPtr_LoadMatchSettingsFromTable ; $6228
	farcall FarPtr_RunStoryMatch ; $622b
	farcall FarPtr_RestoreOverworldAfterMatch ; $622e
	ret ; $6231
Label_12_6232:
	ld a, $03 ; $6232
	ld b, $80 ; $6234
	farcall FarPtr_SetActorFacing ; $6236
	push af ; $6239
	ld a, $0f ; $623a
	farcall FarPtr_WaitScriptFrames ; $623c
	pop af ; $623f
	ld a, $00 ; $6240
	ld b, $80 ; $6242
	farcall FarPtr_SetActorFacing ; $6244
	ld a, $07 ; $6247
	ld b, $80 ; $6249
	farcall FarPtr_SetActorFacing ; $624b
	call Func_12_63a2 ; $624e
	ldh a, [hRomBank] ; $6251
	ld b, a ; $6253
	ld a, $07 ; $6254
	ld de, $6c18 ; $6256
	farcall FarPtr_ScriptSetActorScript ; $6259
	farcall FarPtr_WaitPlayerMoveDone ; $625c
	ld a, $07 ; $625f
	farcall FarPtr_WaitActorScriptDone ; $6261
	push af ; $6264
	ld a, $1e ; $6265
	farcall FarPtr_WaitScriptFrames ; $6267
	pop af ; $626a
	ld a, $0f ; $626b
	ld [$c294], a ; $626d
	ld [$c2a1], a ; $6270
	farcall FarPtr_InitStoryMatchSettings ; $6273
	ld a, $00 ; $6276
	ld [wCurrentMinigameStoryMatch], a ; $6278
	ld a, $06 ; $627b
	ld [$c8f7], a ; $627d
	farcall FarPtr_LoadMatchSettingsFromTable ; $6280
	farcall FarPtr_RunStoryMatch ; $6283
	farcall FarPtr_RestoreOverworldAfterMatch ; $6286
	ret ; $6289
Label_12_628a:
	ld a, $03 ; $628a
	ld b, $00 ; $628c
	farcall FarPtr_SetActorFacing ; $628e
	push af ; $6291
	ld a, $0f ; $6292
	farcall FarPtr_WaitScriptFrames ; $6294
	pop af ; $6297
	ld a, $00 ; $6298
	ld b, $00 ; $629a
	farcall FarPtr_SetActorFacing ; $629c
	ld a, $06 ; $629f
	ld b, $00 ; $62a1
	farcall FarPtr_SetActorFacing ; $62a3
	push af ; $62a6
	ld a, $1e ; $62a7
	farcall FarPtr_WaitScriptFrames ; $62a9
	pop af ; $62ac
	call Func_12_63d3 ; $62ad
	ldh a, [hRomBank] ; $62b0
	ld b, a ; $62b2
	ld a, $06 ; $62b3
	ld de, $6c62 ; $62b5
	farcall FarPtr_ScriptSetActorScript ; $62b8
	farcall FarPtr_WaitPlayerMoveDone ; $62bb
	ld a, $06 ; $62be
	farcall FarPtr_WaitActorScriptDone ; $62c0
	push af ; $62c3
	ld a, $1e ; $62c4
	farcall FarPtr_WaitScriptFrames ; $62c6
	pop af ; $62c9
	ld a, $0f ; $62ca
	ld [$c294], a ; $62cc
	ld [$c2a1], a ; $62cf
	farcall FarPtr_InitStoryMatchSettings ; $62d2
	ld a, $00 ; $62d5
	ld [wCurrentMinigameStoryMatch], a ; $62d7
	ld a, $07 ; $62da
	ld [$c8f7], a ; $62dc
	farcall FarPtr_LoadMatchSettingsFromTable ; $62df
	farcall FarPtr_RunStoryMatch ; $62e2
	farcall FarPtr_RestoreOverworldAfterMatch ; $62e5
	ret ; $62e8
Label_12_62e9:
	ld a, $03 ; $62e9
	ld b, $00 ; $62eb
	farcall FarPtr_SetActorFacing ; $62ed
	push af ; $62f0
	ld a, $0f ; $62f1
	farcall FarPtr_WaitScriptFrames ; $62f3
	pop af ; $62f6
	ld a, $00 ; $62f7
	ld b, $00 ; $62f9
	farcall FarPtr_SetActorFacing ; $62fb
	ld a, $05 ; $62fe
	ld b, $00 ; $6300
	farcall FarPtr_SetActorFacing ; $6302
	push af ; $6305
	ld a, $1e ; $6306
	farcall FarPtr_WaitScriptFrames ; $6308
	pop af ; $630b
	call Func_12_63d3 ; $630c
	ldh a, [hRomBank] ; $630f
	ld b, a ; $6311
	ld a, $05 ; $6312
	ld de, $6c62 ; $6314
	farcall FarPtr_ScriptSetActorScript ; $6317
	farcall FarPtr_WaitPlayerMoveDone ; $631a
	push af ; $631d
	ld a, $78 ; $631e
	farcall FarPtr_WaitScriptFrames ; $6320
	pop af ; $6323
	ld a, $00 ; $6324
	farcall FarPtr_ScriptWaitActorMoveDone ; $6326
	ld a, $0f ; $6329
	ld [$c294], a ; $632b
	ld [$c2a1], a ; $632e
	farcall FarPtr_InitStoryMatchSettings ; $6331
	ld a, $00 ; $6334
	ld [wCurrentMinigameStoryMatch], a ; $6336
	ld a, $08 ; $6339
	ld [$c8f7], a ; $633b
	farcall FarPtr_LoadMatchSettingsFromTable ; $633e
	farcall FarPtr_RunStoryMatch ; $6341
	farcall FarPtr_RestoreOverworldAfterMatch ; $6344
	ret ; $6347
Label_12_6348:
	ld a, $03 ; $6348
	ld b, $80 ; $634a
	farcall FarPtr_SetActorFacing ; $634c
	push af ; $634f
	ld a, $0f ; $6350
	farcall FarPtr_WaitScriptFrames ; $6352
	pop af ; $6355
	ld a, $00 ; $6356
	ld b, $80 ; $6358
	farcall FarPtr_SetActorFacing ; $635a
	ld a, $04 ; $635d
	ld b, $80 ; $635f
	farcall FarPtr_SetActorFacing ; $6361
	push af ; $6364
	ld a, $1e ; $6365
	farcall FarPtr_WaitScriptFrames ; $6367
	pop af ; $636a
	call Func_12_63a2 ; $636b
	ldh a, [hRomBank] ; $636e
	ld b, a ; $6370
	ld a, $04 ; $6371
	ld de, $6c18 ; $6373
	farcall FarPtr_ScriptSetActorScript ; $6376
	farcall FarPtr_WaitPlayerMoveDone ; $6379
	push af ; $637c
	ld a, $b4 ; $637d
	farcall FarPtr_WaitScriptFrames ; $637f
	pop af ; $6382
	ld a, $0f ; $6383
	ld [$c294], a ; $6385
	ld [$c2a1], a ; $6388
	farcall FarPtr_InitStoryMatchSettings ; $638b
	ld a, $00 ; $638e
	ld [wCurrentMinigameStoryMatch], a ; $6390
	ld a, $09 ; $6393
	ld [$c8f7], a ; $6395
	farcall FarPtr_LoadMatchSettingsFromTable ; $6398
	farcall FarPtr_RunStoryMatch ; $639b
	farcall FarPtr_RestoreOverworldAfterMatch ; $639e
	ret ; $63a1
Func_12_63a2:
	ldh a, [hRomBank] ; $63a2
	ld b, a ; $63a4
	ld a, $0d ; $63a5
	ld de, $6d30 ; $63a7
	farcall FarPtr_ScriptSetActorScript ; $63aa
	ldh a, [hRomBank] ; $63ad
	ld b, a ; $63af
	ld a, $0e ; $63b0
	ld de, $6d3f ; $63b2
	farcall FarPtr_ScriptSetActorScript ; $63b5
	ld a, $0e ; $63b8
	farcall FarPtr_WaitActorScriptDone ; $63ba
	xor a, a ; $63bd
	ld bc, $2400 ; $63be
	ld de, $1700 ; $63c1
	farcall FarPtr_MovePlayerToPosition ; $63c4
	ldh a, [hRomBank] ; $63c7
	ld b, a ; $63c9
	ld a, $00 ; $63ca
	ld de, $6cec ; $63cc
	farcall FarPtr_ScriptSetActorScript ; $63cf
	ret ; $63d2
Func_12_63d3:
	ldh a, [hRomBank] ; $63d3
	ld b, a ; $63d5
	ld a, $0f ; $63d6
	ld de, $6d4e ; $63d8
	farcall FarPtr_ScriptSetActorScript ; $63db
	ldh a, [hRomBank] ; $63de
	ld b, a ; $63e0
	ld a, $10 ; $63e1
	ld de, $6d5d ; $63e3
	farcall FarPtr_ScriptSetActorScript ; $63e6
	ld a, $0f ; $63e9
	farcall FarPtr_WaitActorScriptDone ; $63eb
	xor a, a ; $63ee
	ld bc, $3500 ; $63ef
	ld de, $1700 ; $63f2
	farcall FarPtr_MovePlayerToPosition ; $63f5
	ldh a, [hRomBank] ; $63f8
	ld b, a ; $63fa
	ld a, $00 ; $63fb
	ld de, $6cfd ; $63fd
	farcall FarPtr_ScriptSetActorScript ; $6400
	ret ; $6403
PlaceSeniorCourtPairA:
	ld a, $0d ; $6404
	farcall FarPtr_SetActorNullScript ; $6406
	ld a, $0e ; $6409
	farcall FarPtr_SetActorNullScript ; $640b
	ld a, $0d ; $640e
	ld bc, $2900 ; $6410
	ld de, $1300 ; $6413
	farcall FarPtr_ScriptSetActorPosition ; $6416
	ld a, $0e ; $6419
	ld bc, $2900 ; $641b
	ld de, $1900 ; $641e
	farcall FarPtr_ScriptSetActorPosition ; $6421
	ld a, $0d ; $6424
	ld b, $80 ; $6426
	farcall FarPtr_SetActorFacing ; $6428
	ld a, $0e ; $642b
	ld b, $80 ; $642d
	farcall FarPtr_SetActorFacing ; $642f
	ret ; $6432
PlaceSeniorCourtPairB:
	ld a, $0f ; $6433
	farcall FarPtr_SetActorNullScript ; $6435
	ld a, $10 ; $6438
	farcall FarPtr_SetActorNullScript ; $643a
	ld a, $0f ; $643d
	ld bc, $3900 ; $643f
	ld de, $1300 ; $6442
	farcall FarPtr_ScriptSetActorPosition ; $6445
	ld a, $10 ; $6448
	ld bc, $3900 ; $644a
	ld de, $1900 ; $644d
	farcall FarPtr_ScriptSetActorPosition ; $6450
	ld a, $0f ; $6453
	ld b, $80 ; $6455
	farcall FarPtr_SetActorFacing ; $6457
	ld a, $10 ; $645a
	ld b, $80 ; $645c
	farcall FarPtr_SetActorFacing ; $645e
	push af ; $6461
	ld a, $14 ; $6462
	farcall FarPtr_WaitScriptFrames ; $6464
	pop af ; $6467
	ret ; $6468
StartSeniorCourtPairARally:
	ld a, $0d ; $6469
	ld bc, $2200 ; $646b
	ld de, $1100 ; $646e
	farcall FarPtr_ScriptSetActorMoveTarget ; $6471
	ld a, $0e ; $6474
	ld bc, $2500 ; $6476
	ld de, $1d00 ; $6479
	farcall FarPtr_ScriptSetActorMoveTarget ; $647c
	ld a, $0d ; $647f
	farcall FarPtr_ScriptWaitActorMoveDone ; $6481
	ld a, $0e ; $6484
	farcall FarPtr_ScriptWaitActorMoveDone ; $6486
	ldh a, [hRomBank] ; $6489
	ld b, a ; $648b
	ld a, $0d ; $648c
	ld de, $7abf ; $648e
	farcall FarPtr_ScriptSetActorScript ; $6491
	ldh a, [hRomBank] ; $6494
	ld b, a ; $6496
	ld a, $0e ; $6497
	ld de, $7b22 ; $6499
	farcall FarPtr_ScriptSetActorScript ; $649c
	ret ; $649f
StartSeniorCourtPairBRally:
	ld a, $0f ; $64a0
	ld bc, $3200 ; $64a2
	ld de, $1100 ; $64a5
	farcall FarPtr_ScriptSetActorMoveTarget ; $64a8
	ld a, $10 ; $64ab
	ld bc, $3600 ; $64ad
	ld de, $1d00 ; $64b0
	farcall FarPtr_ScriptSetActorMoveTarget ; $64b3
	ld a, $0f ; $64b6
	farcall FarPtr_ScriptWaitActorMoveDone ; $64b8
	ld a, $10 ; $64bb
	farcall FarPtr_ScriptWaitActorMoveDone ; $64bd
	ld a, $10 ; $64c0
	ld b, $c0 ; $64c2
	farcall FarPtr_SetActorFacing ; $64c4
	ldh a, [hRomBank] ; $64c7
	ld b, a ; $64c9
	ld a, $0f ; $64ca
	ld de, $7b89 ; $64cc
	farcall FarPtr_ScriptSetActorScript ; $64cf
	ldh a, [hRomBank] ; $64d2
	ld b, a ; $64d4
	ld a, $10 ; $64d5
	ld de, $7bf0 ; $64d7
	farcall FarPtr_ScriptSetActorScript ; $64da
	ret ; $64dd
RunSeniorRankingMatchIntro:
	ld a, [$c2b1] ; $64de
	sub a, $02 ; $64e1
	add a, a ; $64e3
	add a, $f2 ; $64e4
	ld l, a ; $64e6
	adc a, $64 ; $64e7
	sub a, l ; $64e9
	ld h, a ; $64ea
	ld a, [hl+] ; $64eb
	ld h, [hl] ; $64ec
	ld l, a ; $64ed
	call JumpToHL ; $64ee
	ret ; $64f1
	; $64f2, 14 bytes (records:2)
	dw $67a1 ; record 0
	dw $683b ; record 1
	dw $68f3 ; record 2
	dw $69a9 ; record 3
	dw $6500 ; record 4
	dw $65e9 ; record 5
	dw $66af ; record 6
	push af ; $6500
	ld a, $0f ; $6501
	farcall FarPtr_WaitScriptFrames ; $6503
	pop af ; $6506
	ld a, $09 ; $6507
	ld b, a ; $6509
	ld a, $03 ; $650a
	farcall FarPtr_FaceActorTowardActor ; $650c
	push af ; $650f
	ld a, $1e ; $6510
	farcall FarPtr_WaitScriptFrames ; $6512
	pop af ; $6515
	ld a, $09 ; $6516
	ld b, a ; $6518
	ld a, $00 ; $6519
	farcall FarPtr_FaceActorTowardActor ; $651b
	ld a, $09 ; $651e
	ld b, a ; $6520
	ld a, $02 ; $6521
	farcall FarPtr_FaceActorTowardActor ; $6523
	push af ; $6526
	ld a, $1e ; $6527
	farcall FarPtr_WaitScriptFrames ; $6529
	pop af ; $652c
	ld bc, $0020 ; $652d
	farcall FarPtr_SetPlayerMoveSpeed ; $6530
	ld a, $09 ; $6533
	ld b, $00 ; $6535
	farcall FarPtr_MovePlayerToActor ; $6537
	farcall FarPtr_WaitPlayerMoveDone ; $653a
	ld bc, $d040 ; $653d
	ld a, $09 ; $6540
	farcall FarPtr_GetActorStateAddr ; $6542
	ld e, l ; $6545
	ld d, h ; $6546
	farcall FarPtr_04_1e ; $6547
	ld a, $03 ; $654a
	ld b, a ; $654c
	ld a, $09 ; $654d
	farcall FarPtr_FaceActorTowardActor ; $654f
	ld a, $08 ; $6552
	farcall FarPtr_SetActorNullScript ; $6554
	ld a, $08 ; $6557
	ld d, $01 ; $6559
	farcall FarPtr_ScriptSetActorAnimation ; $655b
	ld a, $03 ; $655e
	ld b, a ; $6560
	ld a, $08 ; $6561
	farcall FarPtr_FaceActorTowardActor ; $6563
	ld a, $09 ; $6566
	ld d, $03 ; $6568
	farcall FarPtr_ScriptSetActorAnimation ; $656a
	ld a, $09 ; $656d
	farcall FarPtr_ScriptWaitActorIdle ; $656f
	ldh a, [hRomBank] ; $6572
	ld b, a ; $6574
	ld a, $09 ; $6575
	ld de, $782d ; $6577
	farcall FarPtr_ScriptSetActorScript ; $657a
	ldh a, [hRomBank] ; $657d
	ld b, a ; $657f
	ld a, $08 ; $6580
	ld de, $786b ; $6582
	farcall FarPtr_ScriptSetActorScript ; $6585
	ld a, $03 ; $6588
	ld b, $40 ; $658a
	farcall FarPtr_SetActorFacing ; $658c
	ld a, $09 ; $658f
	farcall FarPtr_WaitActorScriptDone ; $6591
	ld a, $01 ; $6594
	farcall FarPtr_SetActorNullScript ; $6596
	ld a, $00 ; $6599
	ld b, $00 ; $659b
	farcall FarPtr_MovePlayerToActor ; $659d
	farcall FarPtr_WaitPlayerMoveDone ; $65a0
	ld a, $09 ; $65a3
	ld b, a ; $65a5
	ld a, $00 ; $65a6
	farcall FarPtr_FaceActorTowardActor ; $65a8
	ld hl, $107e ; $65ab
	farcall FarPtr_InitDialogueTextCursor ; $65ae
	ld a, $08 ; $65b1
	ld d, $03 ; $65b3
	farcall FarPtr_ScriptSetActorAnimation ; $65b5
	ld a, $08 ; $65b8
	farcall FarPtr_ScriptWaitActorIdle ; $65ba
	ld a, $08 ; $65bd
	farcall FarPtr_ScriptShowSpeakerDialogue ; $65bf
	ld a, $09 ; $65c2
	ld d, $03 ; $65c4
	farcall FarPtr_ScriptSetActorAnimation ; $65c6
	ld a, $09 ; $65c9
	farcall FarPtr_ScriptWaitActorIdle ; $65cb
	ld a, $09 ; $65ce
	farcall FarPtr_ScriptShowSpeakerDialogue ; $65d0
	ld a, $09 ; $65d3
	ld b, $c0 ; $65d5
	farcall FarPtr_SetActorFacing ; $65d7
	ld a, $08 ; $65da
	ld b, $c0 ; $65dc
	farcall FarPtr_SetActorFacing ; $65de
	ld a, $02 ; $65e1
	ld b, $c0 ; $65e3
	farcall FarPtr_SetActorFacing ; $65e5
	ret ; $65e8
	push af ; $65e9
	ld a, $0f ; $65ea
	farcall FarPtr_WaitScriptFrames ; $65ec
	pop af ; $65ef
	ld a, $06 ; $65f0
	ld b, a ; $65f2
	ld a, $03 ; $65f3
	farcall FarPtr_FaceActorTowardActor ; $65f5
	push af ; $65f8
	ld a, $1e ; $65f9
	farcall FarPtr_WaitScriptFrames ; $65fb
	pop af ; $65fe
	ld a, $07 ; $65ff
	ld b, a ; $6601
	ld a, $00 ; $6602
	farcall FarPtr_FaceActorTowardActor ; $6604
	ld a, $06 ; $6607
	ld b, a ; $6609
	ld a, $02 ; $660a
	farcall FarPtr_FaceActorTowardActor ; $660c
	push af ; $660f
	ld a, $1e ; $6610
	farcall FarPtr_WaitScriptFrames ; $6612
	pop af ; $6615
	ld bc, $0020 ; $6616
	farcall FarPtr_SetPlayerMoveSpeed ; $6619
	ld a, $07 ; $661c
	ld b, $00 ; $661e
	farcall FarPtr_MovePlayerToActor ; $6620
	farcall FarPtr_WaitPlayerMoveDone ; $6623
	ld bc, $d040 ; $6626
	ld a, $07 ; $6629
	farcall FarPtr_GetActorStateAddr ; $662b
	ld e, l ; $662e
	ld d, h ; $662f
	farcall FarPtr_04_1e ; $6630
	ld a, $03 ; $6633
	ld b, a ; $6635
	ld a, $07 ; $6636
	farcall FarPtr_FaceActorTowardActor ; $6638
	ld a, $07 ; $663b
	ld d, $03 ; $663d
	farcall FarPtr_ScriptSetActorAnimation ; $663f
	ld a, $07 ; $6642
	farcall FarPtr_ScriptWaitActorIdle ; $6644
	ldh a, [hRomBank] ; $6647
	ld b, a ; $6649
	ld a, $07 ; $664a
	ld de, $78ab ; $664c
	farcall FarPtr_ScriptSetActorScript ; $664f
	ldh a, [hRomBank] ; $6652
	ld b, a ; $6654
	ld a, $06 ; $6655
	ld de, $78c2 ; $6657
	farcall FarPtr_ScriptSetActorScript ; $665a
	ld a, $03 ; $665d
	ld b, $40 ; $665f
	farcall FarPtr_SetActorFacing ; $6661
	ld a, $07 ; $6664
	farcall FarPtr_WaitActorScriptDone ; $6666
	ld a, $01 ; $6669
	farcall FarPtr_SetActorNullScript ; $666b
	ld a, $00 ; $666e
	ld b, $00 ; $6670
	farcall FarPtr_MovePlayerToActor ; $6672
	farcall FarPtr_WaitPlayerMoveDone ; $6675
	ld hl, $107c ; $6678
	farcall FarPtr_InitDialogueTextCursor ; $667b
	ld a, $06 ; $667e
	ld d, $03 ; $6680
	farcall FarPtr_ScriptSetActorAnimation ; $6682
	ld a, $06 ; $6685
	farcall FarPtr_ScriptWaitActorIdle ; $6687
	ld a, $06 ; $668a
	farcall FarPtr_ScriptShowSpeakerDialogue ; $668c
	ld a, $07 ; $668f
	ld d, $03 ; $6691
	farcall FarPtr_ScriptSetActorAnimation ; $6693
	ld a, $07 ; $6696
	farcall FarPtr_ScriptWaitActorIdle ; $6698
	ld a, $07 ; $669b
	farcall FarPtr_ScriptShowSpeakerDialogue ; $669d
	ld a, $07 ; $66a0
	ld b, $c0 ; $66a2
	farcall FarPtr_SetActorFacing ; $66a4
	ld a, $06 ; $66a7
	ld b, $c0 ; $66a9
	farcall FarPtr_SetActorFacing ; $66ab
	ret ; $66ae
	push af ; $66af
	ld a, $0f ; $66b0
	farcall FarPtr_WaitScriptFrames ; $66b2
	pop af ; $66b5
	ld a, $05 ; $66b6
	ld b, a ; $66b8
	ld a, $03 ; $66b9
	farcall FarPtr_FaceActorTowardActor ; $66bb
	push af ; $66be
	ld a, $1e ; $66bf
	farcall FarPtr_WaitScriptFrames ; $66c1
	pop af ; $66c4
	ld a, $04 ; $66c5
	ld b, a ; $66c7
	ld a, $00 ; $66c8
	farcall FarPtr_FaceActorTowardActor ; $66ca
	ld a, $05 ; $66cd
	ld b, a ; $66cf
	ld a, $02 ; $66d0
	farcall FarPtr_FaceActorTowardActor ; $66d2
	ld a, $04 ; $66d5
	farcall FarPtr_SetActorNullScript ; $66d7
	ld a, $04 ; $66da
	ld d, $01 ; $66dc
	farcall FarPtr_ScriptSetActorAnimation ; $66de
	push af ; $66e1
	ld a, $1e ; $66e2
	farcall FarPtr_WaitScriptFrames ; $66e4
	pop af ; $66e7
	ld bc, $0020 ; $66e8
	farcall FarPtr_SetPlayerMoveSpeed ; $66eb
	ld a, $04 ; $66ee
	farcall FarPtr_SetActorNullScript ; $66f0
	ld a, $04 ; $66f3
	ld b, $40 ; $66f5
	farcall FarPtr_SetActorFacing ; $66f7
	ld a, $05 ; $66fa
	ld bc, $2b00 ; $66fc
	ld de, $1100 ; $66ff
	farcall FarPtr_ScriptSetActorMoveTarget ; $6702
	ld a, $05 ; $6705
	ld b, $00 ; $6707
	farcall FarPtr_MovePlayerToActor ; $6709
	farcall FarPtr_WaitPlayerMoveDone ; $670c
	ld a, $05 ; $670f
	ld b, $40 ; $6711
	farcall FarPtr_SetActorFacing ; $6713
	ld a, $03 ; $6716
	ld b, a ; $6718
	ld a, $05 ; $6719
	farcall FarPtr_FaceActorTowardActor ; $671b
	ld a, $05 ; $671e
	ld d, $03 ; $6720
	farcall FarPtr_ScriptSetActorAnimation ; $6722
	ld a, $05 ; $6725
	farcall FarPtr_ScriptWaitActorIdle ; $6727
	ldh a, [hRomBank] ; $672a
	ld b, a ; $672c
	ld a, $05 ; $672d
	ld de, $7953 ; $672f
	farcall FarPtr_ScriptSetActorScript ; $6732
	push af ; $6735
	ld a, $0f ; $6736
	farcall FarPtr_WaitScriptFrames ; $6738
	pop af ; $673b
	ld a, $00 ; $673c
	ld b, $00 ; $673e
	farcall FarPtr_MovePlayerToActor ; $6740
	ldh a, [hRomBank] ; $6743
	ld b, a ; $6745
	ld a, $04 ; $6746
	ld de, $795e ; $6748
	farcall FarPtr_ScriptSetActorScript ; $674b
	ld a, $03 ; $674e
	ld b, $40 ; $6750
	farcall FarPtr_SetActorFacing ; $6752
	ld a, $04 ; $6755
	farcall FarPtr_WaitActorScriptDone ; $6757
	ld a, $04 ; $675a
	ld b, a ; $675c
	ld a, $00 ; $675d
	farcall FarPtr_FaceActorTowardActor ; $675f
	ld a, $05 ; $6762
	ld b, a ; $6764
	ld a, $02 ; $6765
	farcall FarPtr_FaceActorTowardActor ; $6767
	ld hl, $107a ; $676a
	farcall FarPtr_InitDialogueTextCursor ; $676d
	ld a, $04 ; $6770
	ld d, $03 ; $6772
	farcall FarPtr_ScriptSetActorAnimation ; $6774
	ld a, $04 ; $6777
	farcall FarPtr_ScriptWaitActorIdle ; $6779
	ld a, $04 ; $677c
	farcall FarPtr_ScriptShowSpeakerDialogue ; $677e
	ld a, $05 ; $6781
	ld d, $03 ; $6783
	farcall FarPtr_ScriptSetActorAnimation ; $6785
	ld a, $05 ; $6788
	farcall FarPtr_ScriptWaitActorIdle ; $678a
	ld a, $05 ; $678d
	farcall FarPtr_ScriptShowSpeakerDialogue ; $678f
	ld a, $05 ; $6792
	ld b, $c0 ; $6794
	farcall FarPtr_SetActorFacing ; $6796
	ld a, $04 ; $6799
	ld b, $c0 ; $679b
	farcall FarPtr_SetActorFacing ; $679d
	ret ; $67a0
	push af ; $67a1
	ld a, $0f ; $67a2
	farcall FarPtr_WaitScriptFrames ; $67a4
	pop af ; $67a7
	ld a, $07 ; $67a8
	ld b, a ; $67aa
	ld a, $03 ; $67ab
	farcall FarPtr_FaceActorTowardActor ; $67ad
	push af ; $67b0
	ld a, $1e ; $67b1
	farcall FarPtr_WaitScriptFrames ; $67b3
	pop af ; $67b6
	ld a, $07 ; $67b7
	ld b, a ; $67b9
	ld a, $00 ; $67ba
	farcall FarPtr_FaceActorTowardActor ; $67bc
	push af ; $67bf
	ld a, $1e ; $67c0
	farcall FarPtr_WaitScriptFrames ; $67c2
	pop af ; $67c5
	ld bc, $0020 ; $67c6
	farcall FarPtr_SetPlayerMoveSpeed ; $67c9
	ld a, $07 ; $67cc
	ld b, $00 ; $67ce
	farcall FarPtr_MovePlayerToActor ; $67d0
	farcall FarPtr_WaitPlayerMoveDone ; $67d3
	ld bc, $d040 ; $67d6
	ld a, $07 ; $67d9
	farcall FarPtr_GetActorStateAddr ; $67db
	ld e, l ; $67de
	ld d, h ; $67df
	farcall FarPtr_04_1e ; $67e0
	ld a, $03 ; $67e3
	ld b, a ; $67e5
	ld a, $07 ; $67e6
	farcall FarPtr_FaceActorTowardActor ; $67e8
	ld a, $07 ; $67eb
	ld d, $03 ; $67ed
	farcall FarPtr_ScriptSetActorAnimation ; $67ef
	ld a, $07 ; $67f2
	farcall FarPtr_ScriptWaitActorIdle ; $67f4
	ldh a, [hRomBank] ; $67f7
	ld b, a ; $67f9
	ld a, $07 ; $67fa
	ld de, $6c0d ; $67fc
	farcall FarPtr_ScriptSetActorScript ; $67ff
	ld a, $03 ; $6802
	ld b, $40 ; $6804
	farcall FarPtr_SetActorFacing ; $6806
	ld a, $07 ; $6809
	farcall FarPtr_WaitActorScriptDone ; $680b
	ld a, $01 ; $680e
	farcall FarPtr_SetActorNullScript ; $6810
	ld a, $07 ; $6813
	ld b, a ; $6815
	ld a, $00 ; $6816
	farcall FarPtr_FaceActorTowardActor ; $6818
	ld a, $07 ; $681b
	ld d, $02 ; $681d
	farcall FarPtr_ScriptSetActorAnimation ; $681f
	ld a, $07 ; $6822
	farcall FarPtr_ScriptWaitActorIdle ; $6824
	ld a, $07 ; $6827
	ld d, $03 ; $6829
	farcall FarPtr_ScriptSetActorAnimation ; $682b
	ld a, $07 ; $682e
	farcall FarPtr_ScriptWaitActorIdle ; $6830
	ld a, $07 ; $6833
	ld b, $c0 ; $6835
	farcall FarPtr_SetActorFacing ; $6837
	ret ; $683a
	push af ; $683b
	ld a, $0f ; $683c
	farcall FarPtr_WaitScriptFrames ; $683e
	pop af ; $6841
	ld a, $06 ; $6842
	ld b, a ; $6844
	ld a, $03 ; $6845
	farcall FarPtr_FaceActorTowardActor ; $6847
	push af ; $684a
	ld a, $1e ; $684b
	farcall FarPtr_WaitScriptFrames ; $684d
	pop af ; $6850
	ld a, $06 ; $6851
	ld b, a ; $6853
	ld a, $00 ; $6854
	farcall FarPtr_FaceActorTowardActor ; $6856
	push af ; $6859
	ld a, $1e ; $685a
	farcall FarPtr_WaitScriptFrames ; $685c
	pop af ; $685f
	ld bc, $0020 ; $6860
	farcall FarPtr_SetPlayerMoveSpeed ; $6863
	ld a, $06 ; $6866
	ld b, $00 ; $6868
	farcall FarPtr_MovePlayerToActor ; $686a
	farcall FarPtr_WaitPlayerMoveDone ; $686d
	ld bc, $d040 ; $6870
	ld a, $06 ; $6873
	farcall FarPtr_GetActorStateAddr ; $6875
	ld e, l ; $6878
	ld d, h ; $6879
	farcall FarPtr_04_1e ; $687a
	ld a, $03 ; $687d
	ld b, a ; $687f
	ld a, $06 ; $6880
	farcall FarPtr_FaceActorTowardActor ; $6882
	ld a, $06 ; $6885
	ld d, $03 ; $6887
	farcall FarPtr_ScriptSetActorAnimation ; $6889
	ld a, $06 ; $688c
	farcall FarPtr_ScriptWaitActorIdle ; $688e
	ldh a, [hRomBank] ; $6891
	ld b, a ; $6893
	ld a, $06 ; $6894
	ld de, $6c51 ; $6896
	farcall FarPtr_ScriptSetActorScript ; $6899
	ld a, $03 ; $689c
	ld b, $40 ; $689e
	farcall FarPtr_SetActorFacing ; $68a0
	ld a, $00 ; $68a3
	ld b, $00 ; $68a5
	farcall FarPtr_MovePlayerToActor ; $68a7
	ld a, $06 ; $68aa
	farcall FarPtr_WaitActorScriptDone ; $68ac
	ld a, $01 ; $68af
	farcall FarPtr_SetActorNullScript ; $68b1
	ld a, $00 ; $68b4
	ld b, a ; $68b6
	ld a, $06 ; $68b7
	farcall FarPtr_FaceActorsTowardEachOther ; $68b9
	ld a, $06 ; $68bc
	ld d, $02 ; $68be
	farcall FarPtr_ScriptSetActorAnimation ; $68c0
	ld a, $06 ; $68c3
	farcall FarPtr_ScriptWaitActorIdle ; $68c5
	ld hl, $103a ; $68c8
	farcall FarPtr_InitDialogueTextCursor ; $68cb
	ld a, $06 ; $68ce
	farcall FarPtr_ScriptShowSpeakerDialogue ; $68d0
	ld a, $06 ; $68d3
	ld d, $03 ; $68d5
	farcall FarPtr_ScriptSetActorAnimation ; $68d7
	ld a, $06 ; $68da
	farcall FarPtr_ScriptWaitActorIdle ; $68dc
	ld a, $06 ; $68df
	farcall FarPtr_ScriptShowSpeakerDialogue ; $68e1
	push af ; $68e4
	ld a, $0f ; $68e5
	farcall FarPtr_WaitScriptFrames ; $68e7
	pop af ; $68ea
	ld a, $06 ; $68eb
	ld b, $c0 ; $68ed
	farcall FarPtr_SetActorFacing ; $68ef
	ret ; $68f2
	push af ; $68f3
	ld a, $0f ; $68f4
	farcall FarPtr_WaitScriptFrames ; $68f6
	pop af ; $68f9
	ld a, $05 ; $68fa
	ld b, a ; $68fc
	ld a, $03 ; $68fd
	farcall FarPtr_FaceActorTowardActor ; $68ff
	push af ; $6902
	ld a, $1e ; $6903
	farcall FarPtr_WaitScriptFrames ; $6905
	pop af ; $6908
	ld a, $05 ; $6909
	ld b, a ; $690b
	ld a, $00 ; $690c
	farcall FarPtr_FaceActorTowardActor ; $690e
	push af ; $6911
	ld a, $1e ; $6912
	farcall FarPtr_WaitScriptFrames ; $6914
	pop af ; $6917
	ld bc, $0020 ; $6918
	farcall FarPtr_SetPlayerMoveSpeed ; $691b
	ld a, $05 ; $691e
	ld b, $00 ; $6920
	farcall FarPtr_MovePlayerToActor ; $6922
	farcall FarPtr_WaitPlayerMoveDone ; $6925
	ld bc, $d040 ; $6928
	ld a, $05 ; $692b
	farcall FarPtr_GetActorStateAddr ; $692d
	ld e, l ; $6930
	ld d, h ; $6931
	farcall FarPtr_04_1e ; $6932
	ld a, $03 ; $6935
	ld b, a ; $6937
	ld a, $05 ; $6938
	farcall FarPtr_FaceActorTowardActor ; $693a
	ld a, $05 ; $693d
	ld d, $03 ; $693f
	farcall FarPtr_ScriptSetActorAnimation ; $6941
	ld a, $05 ; $6944
	farcall FarPtr_ScriptWaitActorIdle ; $6946
	ldh a, [hRomBank] ; $6949
	ld b, a ; $694b
	ld a, $05 ; $694c
	ld de, $6c95 ; $694e
	farcall FarPtr_ScriptSetActorScript ; $6951
	ld a, $03 ; $6954
	ld b, $40 ; $6956
	farcall FarPtr_SetActorFacing ; $6958
	ld a, $01 ; $695b
	farcall FarPtr_SetActorNullScript ; $695d
	ld a, $00 ; $6960
	ld b, $00 ; $6962
	farcall FarPtr_MovePlayerToActor ; $6964
	farcall FarPtr_WaitPlayerMoveDone ; $6967
	ld a, $00 ; $696a
	ld b, a ; $696c
	ld a, $05 ; $696d
	farcall FarPtr_FaceActorTowardActor ; $696f
	ld a, $05 ; $6972
	ld d, $02 ; $6974
	farcall FarPtr_ScriptSetActorAnimation ; $6976
	ld a, $05 ; $6979
	farcall FarPtr_ScriptWaitActorIdle ; $697b
	ld hl, $1038 ; $697e
	farcall FarPtr_InitDialogueTextCursor ; $6981
	ld a, $05 ; $6984
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6986
	ld a, $05 ; $6989
	ld d, $03 ; $698b
	farcall FarPtr_ScriptSetActorAnimation ; $698d
	ld a, $05 ; $6990
	farcall FarPtr_ScriptWaitActorIdle ; $6992
	ld a, $05 ; $6995
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6997
	push af ; $699a
	ld a, $0f ; $699b
	farcall FarPtr_WaitScriptFrames ; $699d
	pop af ; $69a0
	ld a, $05 ; $69a1
	ld b, $c0 ; $69a3
	farcall FarPtr_SetActorFacing ; $69a5
	ret ; $69a8
	push af ; $69a9
	ld a, $0f ; $69aa
	farcall FarPtr_WaitScriptFrames ; $69ac
	pop af ; $69af
	ld a, $04 ; $69b0
	ld b, a ; $69b2
	ld a, $03 ; $69b3
	farcall FarPtr_FaceActorTowardActor ; $69b5
	push af ; $69b8
	ld a, $1e ; $69b9
	farcall FarPtr_WaitScriptFrames ; $69bb
	pop af ; $69be
	ld a, $04 ; $69bf
	ld b, a ; $69c1
	ld a, $00 ; $69c2
	farcall FarPtr_FaceActorTowardActor ; $69c4
	push af ; $69c7
	ld a, $1e ; $69c8
	farcall FarPtr_WaitScriptFrames ; $69ca
	pop af ; $69cd
	ld bc, $0020 ; $69ce
	farcall FarPtr_SetPlayerMoveSpeed ; $69d1
	ld a, $04 ; $69d4
	ld b, $00 ; $69d6
	farcall FarPtr_MovePlayerToActor ; $69d8
	farcall FarPtr_WaitPlayerMoveDone ; $69db
	ld a, $03 ; $69de
	ld b, a ; $69e0
	ld a, $04 ; $69e1
	farcall FarPtr_FaceActorTowardActor ; $69e3
	ld a, $04 ; $69e6
	ld d, $03 ; $69e8
	farcall FarPtr_ScriptSetActorAnimation ; $69ea
	ld a, $04 ; $69ed
	farcall FarPtr_ScriptWaitActorIdle ; $69ef
	ldh a, [hRomBank] ; $69f2
	ld b, a ; $69f4
	ld a, $04 ; $69f5
	ld de, $6cda ; $69f7
	farcall FarPtr_ScriptSetActorScript ; $69fa
	ld a, $03 ; $69fd
	ld b, $40 ; $69ff
	farcall FarPtr_SetActorFacing ; $6a01
	ld a, $00 ; $6a04
	ld b, $00 ; $6a06
	farcall FarPtr_MovePlayerToActor ; $6a08
	farcall FarPtr_WaitPlayerMoveDone ; $6a0b
	ld a, $00 ; $6a0e
	ld b, a ; $6a10
	ld a, $04 ; $6a11
	farcall FarPtr_FaceActorTowardActor ; $6a13
	ld hl, $1036 ; $6a16
	farcall FarPtr_InitDialogueTextCursor ; $6a19
	ld a, $04 ; $6a1c
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6a1e
	ld a, $04 ; $6a21
	ld d, $03 ; $6a23
	farcall FarPtr_ScriptSetActorAnimation ; $6a25
	ld a, $04 ; $6a28
	farcall FarPtr_ScriptWaitActorIdle ; $6a2a
	ld a, $04 ; $6a2d
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6a2f
	push af ; $6a32
	ld a, $0f ; $6a33
	farcall FarPtr_WaitScriptFrames ; $6a35
	pop af ; $6a38
	ld a, $04 ; $6a39
	ld b, $c0 ; $6a3b
	farcall FarPtr_SetActorFacing ; $6a3d
	ret ; $6a40
ResumeSeniorOpponentScripts:
	ld a, [$c2b1] ; $6a41
	sub a, $02 ; $6a44
	add a, a ; $6a46
	add a, $55 ; $6a47
	ld l, a ; $6a49
	adc a, $6a ; $6a4a
	sub a, l ; $6a4c
	ld h, a ; $6a4d
	ld a, [hl+] ; $6a4e
	ld h, [hl] ; $6a4f
	ld l, a ; $6a50
	call JumpToHL ; $6a51
	ret ; $6a54
	; $6a55, 14 bytes (records:2)
	dw $6ab8 ; record 0
	dw $6ac4 ; record 1
	dw $6ad0 ; record 2
	dw $6adc ; record 3
	dw $6a63 ; record 4
	dw $6a7a ; record 5
	dw $6a91 ; record 6
	ldh a, [hRomBank] ; $6a63
	ld b, a ; $6a65
	ld a, $09 ; $6a66
	ld de, $7849 ; $6a68
	farcall FarPtr_ScriptSetActorScript ; $6a6b
	ldh a, [hRomBank] ; $6a6e
	ld b, a ; $6a70
	ld a, $08 ; $6a71
	ld de, $7887 ; $6a73
	farcall FarPtr_ScriptSetActorScript ; $6a76
	ret ; $6a79
	ldh a, [hRomBank] ; $6a7a
	ld b, a ; $6a7c
	ld a, $07 ; $6a7d
	ld de, $78fb ; $6a7f
	farcall FarPtr_ScriptSetActorScript ; $6a82
	ldh a, [hRomBank] ; $6a85
	ld b, a ; $6a87
	ld a, $06 ; $6a88
	ld de, $7912 ; $6a8a
	farcall FarPtr_ScriptSetActorScript ; $6a8d
	ret ; $6a90
	ldh a, [hRomBank] ; $6a91
	ld b, a ; $6a93
	ld a, $05 ; $6a94
	ld de, $7991 ; $6a96
	farcall FarPtr_ScriptSetActorScript ; $6a99
	ldh a, [hRomBank] ; $6a9c
	ld b, a ; $6a9e
	ld a, $04 ; $6a9f
	ld de, $79a2 ; $6aa1
	farcall FarPtr_ScriptSetActorScript ; $6aa4
	ld a, $05 ; $6aa7
	farcall FarPtr_WaitActorScriptDone ; $6aa9
	ldh a, [hRomBank] ; $6aac
	ld b, a ; $6aae
	ld a, $05 ; $6aaf
	ld de, $7c59 ; $6ab1
	farcall FarPtr_ScriptSetActorScript ; $6ab4
	ret ; $6ab7
	ldh a, [hRomBank] ; $6ab8
	ld b, a ; $6aba
	ld a, $07 ; $6abb
	ld de, $6c29 ; $6abd
	farcall FarPtr_ScriptSetActorScript ; $6ac0
	ret ; $6ac3
	ldh a, [hRomBank] ; $6ac4
	ld b, a ; $6ac6
	ld a, $06 ; $6ac7
	ld de, $6c73 ; $6ac9
	farcall FarPtr_ScriptSetActorScript ; $6acc
	ret ; $6acf
	ldh a, [hRomBank] ; $6ad0
	ld b, a ; $6ad2
	ld a, $05 ; $6ad3
	ld de, $6cac ; $6ad5
	farcall FarPtr_ScriptSetActorScript ; $6ad8
	ret ; $6adb
	ldh a, [hRomBank] ; $6adc
	ld b, a ; $6ade
	ld a, $04 ; $6adf
	ld de, $6ce5 ; $6ae1
	farcall FarPtr_ScriptSetActorScript ; $6ae4
	ret ; $6ae7
SeniorSinglesMatchConfirm:
	ld hl, $1044 ; $6ae8
	farcall FarPtr_InitDialogueTextCursor ; $6aeb
	test_flag $0a, 4 ; $6aee
	jr z, Label_12_6af6 ; $6af1
	farcall FarPtr_AdvanceDialogueTextCursor ; $6af3
Label_12_6af6:
	ld a, $03 ; $6af6
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $6af8
	farcall FarPtr_RunDialogueYesNoPrompt ; $6afb
	farcall FarPtr_ScriptCloseDialogueWindow ; $6afe
	push af ; $6b01
	ld a, $05 ; $6b02
	farcall FarPtr_WaitScriptFrames ; $6b04
	pop af ; $6b07
	and a, a ; $6b08
	jp nz, Label_12_6b57 ; $6b09
	ld a, $03 ; $6b0c
	ld d, $03 ; $6b0e
	farcall FarPtr_ScriptSetActorAnimation ; $6b10
	ld a, $03 ; $6b13
	farcall FarPtr_ScriptWaitActorIdle ; $6b15
Label_12_6b18:
	ld a, $03 ; $6b18
	ld d, $03 ; $6b1a
	farcall FarPtr_ScriptSetActorAnimation ; $6b1c
	ld a, $03 ; $6b1f
	farcall FarPtr_ScriptWaitActorIdle ; $6b21
	ld hl, $1046 ; $6b24
	farcall FarPtr_InitDialogueTextCursor ; $6b27
	ld a, $03 ; $6b2a
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6b2c
	call StartSeniorRankingMatch ; $6b2f
	farcall FarPtr_EndCutsceneScriptMode ; $6b32
	ret ; $6b35
Label_12_6b36:
	ld hl, $1048 ; $6b36
	farcall FarPtr_InitDialogueTextCursor ; $6b39
	test_flag $0a, 4 ; $6b3c
	jr z, Label_12_6b44 ; $6b3f
	farcall FarPtr_AdvanceDialogueTextCursor ; $6b41
Label_12_6b44:
	ld a, $03 ; $6b44
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6b46
	call ResumeSeniorOpponentScripts ; $6b49
	push af ; $6b4c
	ld a, $1e ; $6b4d
	farcall FarPtr_WaitScriptFrames ; $6b4f
	pop af ; $6b52
	farcall FarPtr_EndCutsceneScriptMode ; $6b53
	ret ; $6b56
Label_12_6b57:
	ld hl, $1047 ; $6b57
	farcall FarPtr_InitDialogueTextCursor ; $6b5a
	ld a, $03 ; $6b5d
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $6b5f
	farcall FarPtr_RunDialogueYesNoPrompt ; $6b62
	farcall FarPtr_ScriptCloseDialogueWindow ; $6b65
	push af ; $6b68
	ld a, $05 ; $6b69
	farcall FarPtr_WaitScriptFrames ; $6b6b
	pop af ; $6b6e
	and a, a ; $6b6f
	jr z, Label_12_6b36 ; $6b70
	jp Label_12_6b18 ; $6b72
	ret ; $6b75
SeniorDoublesMatchConfirm:
	ld hl, $1074 ; $6b76
	farcall FarPtr_InitDialogueTextCursor ; $6b79
	test_flag $08, 5 ; $6b7c
	jr z, Label_12_6b84 ; $6b7f
	farcall FarPtr_AdvanceDialogueTextCursor ; $6b81
Label_12_6b84:
	ld a, $03 ; $6b84
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $6b86
	farcall FarPtr_RunDialogueYesNoPrompt ; $6b89
	farcall FarPtr_ScriptCloseDialogueWindow ; $6b8c
	push af ; $6b8f
	ld a, $05 ; $6b90
	farcall FarPtr_WaitScriptFrames ; $6b92
	pop af ; $6b95
	and a, a ; $6b96
	jp nz, Label_12_6be4 ; $6b97
	ld a, $03 ; $6b9a
	ld d, $03 ; $6b9c
	farcall FarPtr_ScriptSetActorAnimation ; $6b9e
	ld a, $03 ; $6ba1
	farcall FarPtr_ScriptWaitActorIdle ; $6ba3
	ld a, $03 ; $6ba6
	ld d, $03 ; $6ba8
	farcall FarPtr_ScriptSetActorAnimation ; $6baa
	ld a, $03 ; $6bad
	farcall FarPtr_ScriptWaitActorIdle ; $6baf
	ld hl, $1076 ; $6bb2
	farcall FarPtr_InitDialogueTextCursor ; $6bb5
	ld a, $03 ; $6bb8
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6bba
Label_12_6bbd:
	call StartSeniorRankingMatch ; $6bbd
	farcall FarPtr_EndCutsceneScriptMode ; $6bc0
	ret ; $6bc3
Label_12_6bc4:
	ld a, $03 ; $6bc4
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6bc6
	call ResumeSeniorOpponentScripts ; $6bc9
	push af ; $6bcc
	ld a, $1e ; $6bcd
	farcall FarPtr_WaitScriptFrames ; $6bcf
	pop af ; $6bd2
	ld a, $02 ; $6bd3
	farcall FarPtr_GetActorStateAddr ; $6bd5
	ld c, l ; $6bd8
	ld b, h ; $6bd9
	ld de, $d000 ; $6bda
	farcall FarPtr_04_20 ; $6bdd
	farcall FarPtr_EndCutsceneScriptMode ; $6be0
	ret ; $6be3
Label_12_6be4:
	ld hl, $1077 ; $6be4
	farcall FarPtr_InitDialogueTextCursor ; $6be7
	ld a, $03 ; $6bea
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $6bec
	farcall FarPtr_RunDialogueYesNoPrompt ; $6bef
	farcall FarPtr_ScriptCloseDialogueWindow ; $6bf2
	push af ; $6bf5
	ld a, $05 ; $6bf6
	farcall FarPtr_WaitScriptFrames ; $6bf8
	pop af ; $6bfb
	and a, a ; $6bfc
	jr z, Label_12_6bc4 ; $6bfd
	ld hl, $1079 ; $6bff
	farcall FarPtr_InitDialogueTextCursor ; $6c02
	ld a, $03 ; $6c05
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6c07
	jp Label_12_6bbd ; $6c0a
	INCBIN "data/bank_012/d_6c0d.bin" ; $6c0d, 381 bytes
Label_12_6d8a:
	ld a, $10 ; $6d8a
	ld [wStoryModeCurrentLocation], a ; $6d8c
	ld a, $0d ; $6d8f
	ld [$c295], a ; $6d91
	ld a, $ff ; $6d94
	ld [$c294], a ; $6d96
	ld [$c2a1], a ; $6d99
	farcall FarPtr_StubNop_1e ; $6d9c
	ret ; $6d9f
SeniorCourtPostMatchReturn:
	wram_bank $04 ; $6da0
	ld a, [$c4c7] ; $6da6
	cp a, $01 ; $6da9
	jr z, Label_12_6db5 ; $6dab
	ld a, [wMatchWinLoseFlag] ; $6dad
	cp a, $01 ; $6db0
	jp z, SeniorMatchVictorySceneDispatch ; $6db2
Label_12_6db5:
	ld bc, $0040 ; $6db5
	farcall FarPtr_SetPlayerMoveSpeed ; $6db8
	xor a, a ; $6dbb
	ld bc, $2d00 ; $6dbc
	ld de, $1b00 ; $6dbf
	farcall FarPtr_MovePlayerToPosition ; $6dc2
	ld a, $00 ; $6dc5
	ld bc, $2d00 ; $6dc7
	ld de, $1b00 ; $6dca
	farcall FarPtr_ScriptSetActorPosition ; $6dcd
	ld a, $00 ; $6dd0
	ld b, $c0 ; $6dd2
	farcall FarPtr_SetActorFacing ; $6dd4
	ld a, $02 ; $6dd7
	ld bc, $2d00 ; $6dd9
	ld de, $1d00 ; $6ddc
	farcall FarPtr_ScriptSetActorPosition ; $6ddf
	ld a, $02 ; $6de2
	ld b, $c0 ; $6de4
	farcall FarPtr_SetActorFacing ; $6de6
	farcall FarPtr_WaitPlayerMoveDone ; $6de9
	ret ; $6dec
SeniorMatchVictorySceneDispatch:
	xor a, a ; $6ded
	ld [$c2d5], a ; $6dee
	ld a, $01 ; $6df1
	farcall FarPtr_SetActorNullScript ; $6df3
	ld a, [$c2b1] ; $6df6
	sub a, $02 ; $6df9
	add a, a ; $6dfb
	add a, $0d ; $6dfc
	ld l, a ; $6dfe
	adc a, $6e ; $6dff
	sub a, l ; $6e01
	ld h, a ; $6e02
	ld a, [hl+] ; $6e03
	ld h, [hl] ; $6e04
	ld l, a ; $6e05
	call JumpToHL ; $6e06
	call ComputeSeniorCourtStage ; $6e09
	ret ; $6e0c
	; $6e0d, 18 bytes (records:2)
	dw $73b2 ; record 0
	dw $73b2 ; record 1
	dw $7449 ; record 2
	dw $74b8 ; record 3
	dw $752a ; record 4
	dw $6e1f ; record 5
	dw $6f6a ; record 6
	dw $752a ; record 7
	dw $7071 ; record 8
	ld a, $02 ; $6e1f
	farcall FarPtr_SetActorNullScript ; $6e21
	ld a, $08 ; $6e24
	farcall FarPtr_SetActorNullScript ; $6e26
	ld a, $03 ; $6e29
	ld b, $80 ; $6e2b
	farcall FarPtr_SetActorFacing ; $6e2d
	ld a, $08 ; $6e30
	ld bc, $2500 ; $6e32
	ld de, $1300 ; $6e35
	farcall FarPtr_ScriptSetActorPosition ; $6e38
	ld a, $08 ; $6e3b
	ld b, $40 ; $6e3d
	farcall FarPtr_SetActorFacing ; $6e3f
	ld a, $09 ; $6e42
	ld bc, $2300 ; $6e44
	ld de, $0f00 ; $6e47
	farcall FarPtr_ScriptSetActorPosition ; $6e4a
	ld a, $09 ; $6e4d
	ld b, $40 ; $6e4f
	farcall FarPtr_SetActorFacing ; $6e51
	ld hl, $1080 ; $6e54
	farcall FarPtr_InitDialogueTextCursor ; $6e57
	ld a, $00 ; $6e5a
	ld bc, $2500 ; $6e5c
	ld de, $1b00 ; $6e5f
	farcall FarPtr_ScriptSetActorPosition ; $6e62
	ld a, $02 ; $6e65
	ld bc, $2300 ; $6e67
	ld de, $1b00 ; $6e6a
	farcall FarPtr_ScriptSetActorPosition ; $6e6d
	ld a, $00 ; $6e70
	ld b, $c0 ; $6e72
	farcall FarPtr_SetActorFacing ; $6e74
	ld a, $02 ; $6e77
	ld b, $c0 ; $6e79
	farcall FarPtr_SetActorFacing ; $6e7b
	ld bc, $0040 ; $6e7e
	farcall FarPtr_SetPlayerMoveSpeed ; $6e81
	xor a, a ; $6e84
	ld bc, $2600 ; $6e85
	ld de, $1700 ; $6e88
	farcall FarPtr_MovePlayerToPosition ; $6e8b
	farcall FarPtr_WaitPlayerMoveDone ; $6e8e
	ld c, $08 ; $6e91
	call BeginFadeIn ; $6e93
	call WaitFadeEnd ; $6e96
	push af ; $6e99
	ld a, $3c ; $6e9a
	farcall FarPtr_WaitScriptFrames ; $6e9c
	pop af ; $6e9f
	ld a, $09 ; $6ea0
	ld bc, $2300 ; $6ea2
	ld de, $1300 ; $6ea5
	farcall FarPtr_ScriptSetActorMoveTarget ; $6ea8
	ld a, $09 ; $6eab
	farcall FarPtr_ScriptWaitActorMoveDone ; $6ead
	ld a, $09 ; $6eb0
	ld b, a ; $6eb2
	ld a, $08 ; $6eb3
	farcall FarPtr_FaceActorsTowardEachOther ; $6eb5
	push af ; $6eb8
	ld a, $14 ; $6eb9
	farcall FarPtr_WaitScriptFrames ; $6ebb
	pop af ; $6ebe
	ld a, $11 ; $6ebf
	ld bc, $2400 ; $6ec1
	ld de, $1180 ; $6ec4
	farcall FarPtr_ScriptSetActorPosition ; $6ec7
	sound $96 ; $6eca
	push af ; $6ecc
	ld a, $1e ; $6ecd
	farcall FarPtr_WaitScriptFrames ; $6ecf
	pop af ; $6ed2
	ld a, $08 ; $6ed3
	ld d, $04 ; $6ed5
	farcall FarPtr_ScriptSetActorAnimation ; $6ed7
	ld a, $08 ; $6eda
	farcall FarPtr_ScriptWaitActorIdle ; $6edc
	ld a, $11 ; $6edf
	ld bc, $3f00 ; $6ee1
	ld de, $3f00 ; $6ee4
	farcall FarPtr_ScriptSetActorPosition ; $6ee7
	ld a, $03 ; $6eea
	ld de, $ff80 ; $6eec
	farcall FarPtr_ScriptSetActorJumpVelocity ; $6eef
	ld a, $03 ; $6ef2
	farcall FarPtr_ScriptWaitActorJumpDone ; $6ef4
	ld a, $03 ; $6ef7
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6ef9
	ldh a, [hRomBank] ; $6efc
	ld b, a ; $6efe
	ld a, $08 ; $6eff
	ld de, $7894 ; $6f01
	farcall FarPtr_ScriptSetActorScript ; $6f04
	ldh a, [hRomBank] ; $6f07
	ld b, a ; $6f09
	ld a, $09 ; $6f0a
	ld de, $7854 ; $6f0c
	farcall FarPtr_ScriptSetActorScript ; $6f0f
	push af ; $6f12
	ld a, $3c ; $6f13
	farcall FarPtr_WaitScriptFrames ; $6f15
	pop af ; $6f18
	ld a, $03 ; $6f19
	ld bc, $2d00 ; $6f1b
	ld de, $1900 ; $6f1e
	farcall FarPtr_ScriptSetActorMoveTarget ; $6f21
	xor a, a ; $6f24
	ld bc, $2d00 ; $6f25
	ld de, $1b00 ; $6f28
	farcall FarPtr_MovePlayerToPosition ; $6f2b
	ld a, $00 ; $6f2e
	ld bc, $2d00 ; $6f30
	ld de, $1b00 ; $6f33
	farcall FarPtr_ScriptSetActorMoveTarget ; $6f36
	ld a, $02 ; $6f39
	ld bc, $2d00 ; $6f3b
	ld de, $1d00 ; $6f3e
	farcall FarPtr_ScriptSetActorMoveTarget ; $6f41
	push af ; $6f44
	ld a, $3c ; $6f45
	farcall FarPtr_WaitScriptFrames ; $6f47
	pop af ; $6f4a
	ld a, $03 ; $6f4b
	ld b, $40 ; $6f4d
	farcall FarPtr_SetActorFacing ; $6f4f
	ld a, $00 ; $6f52
	ld b, $40 ; $6f54
	farcall FarPtr_SetActorFacing ; $6f56
	ld a, $02 ; $6f59
	farcall FarPtr_GetActorStateAddr ; $6f5b
	ld c, l ; $6f5e
	ld b, h ; $6f5f
	ld de, $d000 ; $6f60
	farcall FarPtr_04_20 ; $6f63
	farcall FarPtr_EndCutsceneScriptMode ; $6f66
	ret ; $6f69
	ld a, $02 ; $6f6a
	farcall FarPtr_SetActorNullScript ; $6f6c
	ld a, $03 ; $6f6f
	ld b, $00 ; $6f71
	farcall FarPtr_SetActorFacing ; $6f73
	ld a, $07 ; $6f76
	ld bc, $3300 ; $6f78
	ld de, $1100 ; $6f7b
	farcall FarPtr_ScriptSetActorPosition ; $6f7e
	ld a, $07 ; $6f81
	ld b, $40 ; $6f83
	farcall FarPtr_SetActorFacing ; $6f85
	ld a, $06 ; $6f88
	ld bc, $3500 ; $6f8a
	ld de, $1300 ; $6f8d
	farcall FarPtr_ScriptSetActorPosition ; $6f90
	ld a, $06 ; $6f93
	ld b, $40 ; $6f95
	farcall FarPtr_SetActorFacing ; $6f97
	ld a, $00 ; $6f9a
	ld bc, $3300 ; $6f9c
	ld de, $1b00 ; $6f9f
	farcall FarPtr_ScriptSetActorPosition ; $6fa2
	ld a, $02 ; $6fa5
	ld bc, $3500 ; $6fa7
	ld de, $1b00 ; $6faa
	farcall FarPtr_ScriptSetActorPosition ; $6fad
	ld a, $00 ; $6fb0
	ld b, $c0 ; $6fb2
	farcall FarPtr_SetActorFacing ; $6fb4
	ld a, $02 ; $6fb7
	ld b, $c0 ; $6fb9
	farcall FarPtr_SetActorFacing ; $6fbb
	call FadeInSeniorCourtNearPairB ; $6fbe
	ld hl, $1081 ; $6fc1
	farcall FarPtr_InitDialogueTextCursor ; $6fc4
	push af ; $6fc7
	ld a, $28 ; $6fc8
	farcall FarPtr_WaitScriptFrames ; $6fca
	pop af ; $6fcd
	ld a, $07 ; $6fce
	ld d, $02 ; $6fd0
	farcall FarPtr_ScriptSetActorAnimation ; $6fd2
	ld a, $07 ; $6fd5
	farcall FarPtr_ScriptWaitActorIdle ; $6fd7
	push af ; $6fda
	ld a, $14 ; $6fdb
	farcall FarPtr_WaitScriptFrames ; $6fdd
	pop af ; $6fe0
	ld a, $03 ; $6fe1
	ld de, $ff80 ; $6fe3
	farcall FarPtr_ScriptSetActorJumpVelocity ; $6fe6
	ld a, $03 ; $6fe9
	farcall FarPtr_ScriptWaitActorJumpDone ; $6feb
	ld a, $03 ; $6fee
	ld de, $ff80 ; $6ff0
	farcall FarPtr_ScriptSetActorJumpVelocity ; $6ff3
	ld a, $03 ; $6ff6
	farcall FarPtr_ScriptWaitActorJumpDone ; $6ff8
	ld a, $03 ; $6ffb
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6ffd
	push af ; $7000
	ld a, $3c ; $7001
	farcall FarPtr_WaitScriptFrames ; $7003
	pop af ; $7006
	ld a, $03 ; $7007
	ld bc, $2d00 ; $7009
	ld de, $1900 ; $700c
	farcall FarPtr_ScriptSetActorMoveTarget ; $700f
	xor a, a ; $7012
	ld bc, $2d00 ; $7013
	ld de, $1b00 ; $7016
	farcall FarPtr_MovePlayerToPosition ; $7019
	ld a, $00 ; $701c
	ld bc, $2d00 ; $701e
	ld de, $1b00 ; $7021
	farcall FarPtr_ScriptSetActorMoveTarget ; $7024
	ld a, $02 ; $7027
	ld bc, $2d00 ; $7029
	ld de, $1d00 ; $702c
	farcall FarPtr_ScriptSetActorMoveTarget ; $702f
	ldh a, [hRomBank] ; $7032
	ld b, a ; $7034
	ld a, $07 ; $7035
	ld de, $7940 ; $7037
	farcall FarPtr_ScriptSetActorScript ; $703a
	ldh a, [hRomBank] ; $703d
	ld b, a ; $703f
	ld a, $06 ; $7040
	ld de, $7929 ; $7042
	farcall FarPtr_ScriptSetActorScript ; $7045
	call StartSeniorCourtPairBRally ; $7048
	ld a, $03 ; $704b
	ld b, $40 ; $704d
	farcall FarPtr_SetActorFacing ; $704f
	ld a, $00 ; $7052
	ld b, $40 ; $7054
	farcall FarPtr_SetActorFacing ; $7056
	ld a, $02 ; $7059
	ld b, $40 ; $705b
	farcall FarPtr_SetActorFacing ; $705d
	ld a, $02 ; $7060
	farcall FarPtr_GetActorStateAddr ; $7062
	ld c, l ; $7065
	ld b, h ; $7066
	ld de, $d000 ; $7067
	farcall FarPtr_04_20 ; $706a
	farcall FarPtr_EndCutsceneScriptMode ; $706d
	ret ; $7070
	ld a, $09 ; $7071
	ld bc, $1b00 ; $7073
	ld de, $0b00 ; $7076
	farcall FarPtr_ScriptSetActorPosition ; $7079
	ld a, $08 ; $707c
	ld bc, $1b00 ; $707e
	ld de, $0d00 ; $7081
	farcall FarPtr_ScriptSetActorPosition ; $7084
	ld a, $09 ; $7087
	ld b, $80 ; $7089
	farcall FarPtr_SetActorFacing ; $708b
	ld a, $08 ; $708e
	ld b, $80 ; $7090
	farcall FarPtr_SetActorFacing ; $7092
	ld a, $08 ; $7095
	farcall FarPtr_SetActorNullScript ; $7097
	ld a, $08 ; $709a
	ld d, $01 ; $709c
	farcall FarPtr_ScriptSetActorAnimation ; $709e
	ld a, $02 ; $70a1
	farcall FarPtr_SetActorNullScript ; $70a3
	ld a, $03 ; $70a6
	ld bc, $2b00 ; $70a8
	ld de, $2700 ; $70ab
	farcall FarPtr_ScriptSetActorPosition ; $70ae
	ld a, $04 ; $70b1
	ld bc, $2500 ; $70b3
	ld de, $0f00 ; $70b6
	farcall FarPtr_ScriptSetActorPosition ; $70b9
	ld a, $04 ; $70bc
	ld b, $40 ; $70be
	farcall FarPtr_SetActorFacing ; $70c0
	ld a, $04 ; $70c3
	farcall FarPtr_SetActorNullScript ; $70c5
	ld a, $04 ; $70c8
	ld d, $01 ; $70ca
	farcall FarPtr_ScriptSetActorAnimation ; $70cc
	ld a, $05 ; $70cf
	ld bc, $2300 ; $70d1
	ld de, $1300 ; $70d4
	farcall FarPtr_ScriptSetActorPosition ; $70d7
	ld a, $05 ; $70da
	ld b, $40 ; $70dc
	farcall FarPtr_SetActorFacing ; $70de
	ld a, $05 ; $70e1
	farcall FarPtr_SetActorNullScript ; $70e3
	ld a, $05 ; $70e6
	ld d, $01 ; $70e8
	farcall FarPtr_ScriptSetActorAnimation ; $70ea
	ld a, $00 ; $70ed
	ld bc, $2500 ; $70ef
	ld de, $1b00 ; $70f2
	farcall FarPtr_ScriptSetActorPosition ; $70f5
	ld a, $00 ; $70f8
	ld b, $c0 ; $70fa
	farcall FarPtr_SetActorFacing ; $70fc
	ld a, $02 ; $70ff
	ld bc, $2300 ; $7101
	ld de, $1b00 ; $7104
	farcall FarPtr_ScriptSetActorPosition ; $7107
	ld a, $02 ; $710a
	ld b, $c0 ; $710c
	farcall FarPtr_SetActorFacing ; $710e
	ld bc, $0040 ; $7111
	farcall FarPtr_SetPlayerMoveSpeed ; $7114
	xor a, a ; $7117
	ld bc, $2400 ; $7118
	ld de, $1500 ; $711b
	farcall FarPtr_MovePlayerToPosition ; $711e
	farcall FarPtr_WaitPlayerMoveDone ; $7121
	ld a, $03 ; $7124
	ld b, $80 ; $7126
	farcall FarPtr_SetActorFacing ; $7128
	farcall FarPtr_WaitPlayerMoveDone ; $712b
	ld c, $20 ; $712e
	call BeginFadeIn ; $7130
	call WaitFadeEnd ; $7133
	ld hl, $1082 ; $7136
	farcall FarPtr_InitDialogueTextCursor ; $7139
	ld a, $04 ; $713c
	ld bc, $2500 ; $713e
	ld de, $1300 ; $7141
	farcall FarPtr_ScriptSetActorMoveTarget ; $7144
	ld a, $04 ; $7147
	farcall FarPtr_ScriptWaitActorMoveDone ; $7149
	ld a, $05 ; $714c
	ld b, a ; $714e
	ld a, $04 ; $714f
	farcall FarPtr_FaceActorsTowardEachOther ; $7151
	ld a, $04 ; $7154
	ld d, $02 ; $7156
	farcall FarPtr_ScriptSetActorAnimation ; $7158
	ld a, $04 ; $715b
	farcall FarPtr_ScriptShowSpeakerDialogue ; $715d
	ld a, $05 ; $7160
	ld b, $40 ; $7162
	farcall FarPtr_SetActorFacing ; $7164
	ld a, $05 ; $7167
	ld d, $04 ; $7169
	farcall FarPtr_ScriptSetActorAnimation ; $716b
	ld a, $05 ; $716e
	farcall FarPtr_ScriptWaitActorIdle ; $7170
	ld a, $05 ; $7173
	farcall FarPtr_ScriptShowSpeakerDialogue ; $7175
	ld a, $03 ; $7178
	ld d, $03 ; $717a
	farcall FarPtr_ScriptSetActorAnimation ; $717c
	ld a, $03 ; $717f
	farcall FarPtr_ScriptShowSpeakerDialogue ; $7181
	ld a, $04 ; $7184
	ld d, $02 ; $7186
	farcall FarPtr_ScriptSetActorAnimation ; $7188
	ld a, $05 ; $718b
	ld d, $02 ; $718d
	farcall FarPtr_ScriptSetActorAnimation ; $718f
	ld a, $02 ; $7192
	ld d, $02 ; $7194
	farcall FarPtr_ScriptSetActorAnimation ; $7196
	ld a, $00 ; $7199
	ld d, $02 ; $719b
	farcall FarPtr_ScriptSetActorAnimation ; $719d
	ld a, $00 ; $71a0
	ld b, $40 ; $71a2
	farcall FarPtr_SetActorFacing ; $71a4
	ld a, $02 ; $71a7
	ld b, $40 ; $71a9
	farcall FarPtr_SetActorFacing ; $71ab
	ld a, $04 ; $71ae
	ld b, $40 ; $71b0
	farcall FarPtr_SetActorFacing ; $71b2
	ld bc, $0010 ; $71b5
	farcall FarPtr_SetPlayerMoveSpeed ; $71b8
	ld a, $03 ; $71bb
	ld bc, $0010 ; $71bd
	farcall FarPtr_ScriptSetActorMoveSpeed ; $71c0
	xor a, a ; $71c3
	ld bc, $2b00 ; $71c4
	ld de, $2000 ; $71c7
	farcall FarPtr_MovePlayerToPosition ; $71ca
	ld a, $03 ; $71cd
	ld bc, $2b00 ; $71cf
	ld de, $2000 ; $71d2
	farcall FarPtr_ScriptSetActorMoveTarget ; $71d5
	ld a, $03 ; $71d8
	farcall FarPtr_ScriptWaitActorMoveDone ; $71da
	farcall FarPtr_WaitPlayerMoveDone ; $71dd
	xor a, a ; $71e0
	ld bc, $2400 ; $71e1
	ld de, $1b00 ; $71e4
	farcall FarPtr_MovePlayerToPosition ; $71e7
	ld a, $03 ; $71ea
	ld bc, $2500 ; $71ec
	ld de, $1f00 ; $71ef
	farcall FarPtr_ScriptSetActorMoveTarget ; $71f2
	ld a, $03 ; $71f5
	farcall FarPtr_ScriptWaitActorMoveDone ; $71f7
	ld a, $03 ; $71fa
	ld b, $c0 ; $71fc
	farcall FarPtr_SetActorFacing ; $71fe
	ld a, $03 ; $7201
	ld d, $02 ; $7203
	farcall FarPtr_ScriptSetActorAnimation ; $7205
	ld a, $03 ; $7208
	farcall FarPtr_ScriptWaitActorIdle ; $720a
	ld a, $03 ; $720d
	farcall FarPtr_ScriptShowSpeakerDialogue ; $720f
	ld a, $02 ; $7212
	ld b, a ; $7214
	ld a, $00 ; $7215
	farcall FarPtr_FaceActorsTowardEachOther ; $7217
	push af ; $721a
	ld a, $1e ; $721b
	farcall FarPtr_WaitScriptFrames ; $721d
	pop af ; $7220
	ld a, $00 ; $7221
	ld b, $40 ; $7223
	farcall FarPtr_SetActorFacing ; $7225
	ld a, $02 ; $7228
	ld b, $40 ; $722a
	farcall FarPtr_SetActorFacing ; $722c
	ld a, $02 ; $722f
	ld d, $03 ; $7231
	farcall FarPtr_ScriptSetActorAnimation ; $7233
	ld a, $00 ; $7236
	ld d, $03 ; $7238
	farcall FarPtr_ScriptSetActorAnimation ; $723a
	ld a, $00 ; $723d
	farcall FarPtr_ScriptWaitActorIdle ; $723f
	ld a, $03 ; $7242
	ld d, $03 ; $7244
	farcall FarPtr_ScriptSetActorAnimation ; $7246
	ld a, $03 ; $7249
	farcall FarPtr_ScriptWaitActorIdle ; $724b
	ld hl, $1087 ; $724e
	farcall FarPtr_InitDialogueTextCursor ; $7251
	ld a, $03 ; $7254
	farcall FarPtr_ScriptShowSpeakerDialogue ; $7256
	ld a, $03 ; $7259
	ld bc, $2500 ; $725b
	ld de, $1d00 ; $725e
	farcall FarPtr_ScriptSetActorMoveTarget ; $7261
	ld a, $03 ; $7264
	farcall FarPtr_ScriptWaitActorMoveDone ; $7266
	ld a, $03 ; $7269
	ld d, $02 ; $726b
	farcall FarPtr_ScriptSetActorAnimation ; $726d
	ld a, $03 ; $7270
	farcall FarPtr_ScriptWaitActorIdle ; $7272
	push af ; $7275
	ld a, $1e ; $7276
	farcall FarPtr_WaitScriptFrames ; $7278
	pop af ; $727b
	ld a, $03 ; $727c
	ld d, $03 ; $727e
	farcall FarPtr_ScriptSetActorAnimation ; $7280
	ld a, $00 ; $7283
	ld d, $03 ; $7285
	farcall FarPtr_ScriptSetActorAnimation ; $7287
	ld a, $00 ; $728a
	farcall FarPtr_ScriptWaitActorIdle ; $728c
	ld a, $00 ; $728f
	farcall FarPtr_ScriptShowSpeakerDialogue ; $7291
	ld a, $03 ; $7294
	ld d, $02 ; $7296
	farcall FarPtr_ScriptSetActorAnimation ; $7298
	ld a, $03 ; $729b
	farcall FarPtr_ScriptWaitActorIdle ; $729d
	ld a, $03 ; $72a0
	farcall FarPtr_ScriptShowSpeakerDialogue ; $72a2
	ld a, $03 ; $72a5
	ld d, $03 ; $72a7
	farcall FarPtr_ScriptSetActorAnimation ; $72a9
	ld a, $03 ; $72ac
	farcall FarPtr_ScriptWaitActorIdle ; $72ae
	ld a, $03 ; $72b1
	farcall FarPtr_ScriptShowSpeakerDialogue ; $72b3
	ld a, $00 ; $72b6
	ld d, $03 ; $72b8
	farcall FarPtr_ScriptSetActorAnimation ; $72ba
	ld a, $00 ; $72bd
	farcall FarPtr_ScriptWaitActorIdle ; $72bf
	ld a, $03 ; $72c2
	ld d, $03 ; $72c4
	farcall FarPtr_ScriptSetActorAnimation ; $72c6
	ld a, $03 ; $72c9
	farcall FarPtr_ScriptWaitActorIdle ; $72cb
	ld a, $00 ; $72ce
	ld d, $02 ; $72d0
	farcall FarPtr_ScriptSetActorAnimation ; $72d2
	ld a, $00 ; $72d5
	farcall FarPtr_ScriptWaitActorIdle ; $72d7
	ld a, $00 ; $72da
	ld b, $c0 ; $72dc
	farcall FarPtr_SetActorFacing ; $72de
	ld a, $02 ; $72e1
	ld b, $c0 ; $72e3
	farcall FarPtr_SetActorFacing ; $72e5
	push af ; $72e8
	ld a, $28 ; $72e9
	farcall FarPtr_WaitScriptFrames ; $72eb
	pop af ; $72ee
	xor a, a ; $72ef
	ld bc, $2400 ; $72f0
	ld de, $1700 ; $72f3
	farcall FarPtr_MovePlayerToPosition ; $72f6
	farcall FarPtr_WaitPlayerMoveDone ; $72f9
	ld a, $05 ; $72fc
	ld d, $02 ; $72fe
	farcall FarPtr_ScriptSetActorAnimation ; $7300
	push af ; $7303
	ld a, $28 ; $7304
	farcall FarPtr_WaitScriptFrames ; $7306
	pop af ; $7309
	ld a, $05 ; $730a
	farcall FarPtr_ScriptShowSpeakerDialogue ; $730c
	ld a, $04 ; $730f
	ld bc, $2500 ; $7311
	ld de, $1500 ; $7314
	farcall FarPtr_ScriptSetActorMoveTarget ; $7317
	ld a, $04 ; $731a
	farcall FarPtr_ScriptWaitActorMoveDone ; $731c
	ld a, $04 ; $731f
	farcall FarPtr_ScriptShowSpeakerDialogue ; $7321
	ld a, $02 ; $7324
	ld b, a ; $7326
	ld a, $00 ; $7327
	farcall FarPtr_FaceActorsTowardEachOther ; $7329
	push af ; $732c
	ld a, $0a ; $732d
	farcall FarPtr_WaitScriptFrames ; $732f
	pop af ; $7332
	ld a, $00 ; $7333
	ld d, $02 ; $7335
	farcall FarPtr_ScriptSetActorAnimation ; $7337
	ld a, $02 ; $733a
	ld d, $02 ; $733c
	farcall FarPtr_ScriptSetActorAnimation ; $733e
	ld a, $02 ; $7341
	farcall FarPtr_ScriptWaitActorIdle ; $7343
	ld a, $00 ; $7346
	ld b, $c0 ; $7348
	farcall FarPtr_SetActorFacing ; $734a
	ld a, $02 ; $734d
	ld b, $c0 ; $734f
	farcall FarPtr_SetActorFacing ; $7351
	ld a, $02 ; $7354
	ld d, $03 ; $7356
	farcall FarPtr_ScriptSetActorAnimation ; $7358
	ld a, $00 ; $735b
	ld d, $03 ; $735d
	farcall FarPtr_ScriptSetActorAnimation ; $735f
	ld a, $00 ; $7362
	farcall FarPtr_ScriptWaitActorIdle ; $7364
	push af ; $7367
	ld a, $0a ; $7368
	farcall FarPtr_WaitScriptFrames ; $736a
	pop af ; $736d
	ld a, $04 ; $736e
	ld d, $03 ; $7370
	farcall FarPtr_ScriptSetActorAnimation ; $7372
	ld a, $05 ; $7375
	ld d, $03 ; $7377
	farcall FarPtr_ScriptSetActorAnimation ; $7379
	ld a, $05 ; $737c
	farcall FarPtr_ScriptWaitActorIdle ; $737e
	ld a, $10 ; $7381
	ld [wStoryModeCurrentLocation], a ; $7383
	ld a, $01 ; $7386
	ld [$c295], a ; $7388
	ld a, $ff ; $738b
	ld [$c294], a ; $738d
	ld [$c2a1], a ; $7390
	ld a, $03 ; $7393
	ld d, $03 ; $7395
	farcall FarPtr_ScriptSetActorAnimation ; $7397
	ld a, $03 ; $739a
	farcall FarPtr_ScriptWaitActorIdle ; $739c
	push af ; $739f
	ld a, $1e ; $73a0
	farcall FarPtr_WaitScriptFrames ; $73a2
	pop af ; $73a5
	ld c, $08 ; $73a6
	call BeginFadeOut ; $73a8
	call WaitFadeEnd ; $73ab
	farcall FarPtr_EndCutsceneScriptMode ; $73ae
	ret ; $73b1
	ld a, $07 ; $73b2
	ld bc, $2300 ; $73b4
	ld de, $0f00 ; $73b7
	farcall FarPtr_ScriptSetActorPosition ; $73ba
	ld a, $07 ; $73bd
	ld b, $40 ; $73bf
	farcall FarPtr_SetActorFacing ; $73c1
	call FadeInSeniorCourtNearPairA ; $73c4
	ld hl, $104a ; $73c7
	farcall FarPtr_InitDialogueTextCursor ; $73ca
	ld a, $07 ; $73cd
	farcall FarPtr_ScriptShowSpeakerDialogue ; $73cf
	ld a, $03 ; $73d2
	ld de, $ff80 ; $73d4
	farcall FarPtr_ScriptSetActorJumpVelocity ; $73d7
	ld a, $03 ; $73da
	farcall FarPtr_ScriptWaitActorJumpDone ; $73dc
	ld a, $03 ; $73df
	farcall FarPtr_ScriptShowSpeakerDialogue ; $73e1
	ldh a, [hRomBank] ; $73e4
	ld b, a ; $73e6
	ld a, $07 ; $73e7
	ld de, $6c3a ; $73e9
	farcall FarPtr_ScriptSetActorScript ; $73ec
	push af ; $73ef
	ld a, $3c ; $73f0
	farcall FarPtr_WaitScriptFrames ; $73f2
	pop af ; $73f5
	ld a, $03 ; $73f6
	ld bc, $2d00 ; $73f8
	ld de, $1900 ; $73fb
	farcall FarPtr_ScriptSetActorMoveTarget ; $73fe
	xor a, a ; $7401
	ld bc, $2d00 ; $7402
	ld de, $1b00 ; $7405
	farcall FarPtr_MovePlayerToPosition ; $7408
	ld a, $00 ; $740b
	ld bc, $2400 ; $740d
	ld de, $1d00 ; $7410
	farcall FarPtr_ScriptSetActorMoveTarget ; $7413
	ld a, $00 ; $7416
	farcall FarPtr_ScriptWaitActorMoveDone ; $7418
	ld a, $00 ; $741b
	ld bc, $2d00 ; $741d
	ld de, $1d00 ; $7420
	farcall FarPtr_ScriptSetActorMoveTarget ; $7423
	push af ; $7426
	ld a, $3c ; $7427
	farcall FarPtr_WaitScriptFrames ; $7429
	pop af ; $742c
	call StartSeniorCourtPairARally ; $742d
	ld a, $03 ; $7430
	ld b, $40 ; $7432
	farcall FarPtr_SetActorFacing ; $7434
	ld a, $00 ; $7437
	ld b, $40 ; $7439
	farcall FarPtr_SetActorFacing ; $743b
	push af ; $743e
	ld a, $01 ; $743f
	farcall FarPtr_WaitScriptFrames ; $7441
	pop af ; $7444
	farcall FarPtr_EndCutsceneScriptMode ; $7445
	ret ; $7448
	set_flag $0a, 5 ; $7449
	ld a, $06 ; $744c
	ld bc, $3300 ; $744e
	ld de, $0f00 ; $7451
	farcall FarPtr_ScriptSetActorPosition ; $7454
	ld a, $06 ; $7457
	ld b, $40 ; $7459
	farcall FarPtr_SetActorFacing ; $745b
	call FadeInSeniorCourtNearPairB ; $745e
	ld a, $00 ; $7461
	ld bc, $3400 ; $7463
	ld de, $1b00 ; $7466
	farcall FarPtr_ScriptSetActorPosition ; $7469
	ld hl, $1023 ; $746c
	farcall FarPtr_InitDialogueTextCursor ; $746f
	ld a, $06 ; $7472
	farcall FarPtr_ScriptShowSpeakerDialogue ; $7474
	ld a, $03 ; $7477
	ld de, $ff80 ; $7479
	farcall FarPtr_ScriptSetActorJumpVelocity ; $747c
	ld a, $03 ; $747f
	farcall FarPtr_ScriptWaitActorJumpDone ; $7481
	ld hl, $104c ; $7484
	farcall FarPtr_InitDialogueTextCursor ; $7487
	ld a, $03 ; $748a
	farcall FarPtr_ScriptShowSpeakerDialogue ; $748c
	ldh a, [hRomBank] ; $748f
	ld b, a ; $7491
	ld a, $06 ; $7492
	ld de, $6c84 ; $7494
	farcall FarPtr_ScriptSetActorScript ; $7497
	ld a, $00 ; $749a
	ld bc, $2d00 ; $749c
	ld de, $1b00 ; $749f
	farcall FarPtr_ScriptSetActorMoveTarget ; $74a2
	ld a, $00 ; $74a5
	farcall FarPtr_ScriptWaitActorMoveDone ; $74a7
	ld a, $00 ; $74aa
	ld b, $40 ; $74ac
	farcall FarPtr_SetActorFacing ; $74ae
	call StartSeniorCourtPairBRally ; $74b1
	farcall FarPtr_EndCutsceneScriptMode ; $74b4
	ret ; $74b7
	set_flag $0a, 6 ; $74b8
	call PlaceSeniorCourtPairB ; $74bb
	ld a, $05 ; $74be
	ld bc, $3300 ; $74c0
	ld de, $0f00 ; $74c3
	farcall FarPtr_ScriptSetActorPosition ; $74c6
	ld a, $05 ; $74c9
	ld b, $40 ; $74cb
	farcall FarPtr_SetActorFacing ; $74cd
	call FadeInSeniorCourtNearPairB ; $74d0
	ld a, $00 ; $74d3
	ld bc, $3400 ; $74d5
	ld de, $1b00 ; $74d8
	farcall FarPtr_ScriptSetActorPosition ; $74db
	ld hl, $1020 ; $74de
	farcall FarPtr_InitDialogueTextCursor ; $74e1
	ld a, $05 ; $74e4
	farcall FarPtr_ScriptShowSpeakerDialogue ; $74e6
	ld a, $03 ; $74e9
	ld de, $ff80 ; $74eb
	farcall FarPtr_ScriptSetActorJumpVelocity ; $74ee
	ld a, $03 ; $74f1
	farcall FarPtr_ScriptWaitActorJumpDone ; $74f3
	ld hl, $104d ; $74f6
	farcall FarPtr_InitDialogueTextCursor ; $74f9
	ld a, $03 ; $74fc
	farcall FarPtr_ScriptShowSpeakerDialogue ; $74fe
	ldh a, [hRomBank] ; $7501
	ld b, a ; $7503
	ld a, $05 ; $7504
	ld de, $6cc3 ; $7506
	farcall FarPtr_ScriptSetActorScript ; $7509
	ld a, $00 ; $750c
	ld bc, $2d00 ; $750e
	ld de, $1b00 ; $7511
	farcall FarPtr_ScriptSetActorMoveTarget ; $7514
	ld a, $00 ; $7517
	farcall FarPtr_ScriptWaitActorMoveDone ; $7519
	ld a, $00 ; $751c
	ld b, $40 ; $751e
	farcall FarPtr_SetActorFacing ; $7520
	call StartSeniorCourtPairBRally ; $7523
	farcall FarPtr_EndCutsceneScriptMode ; $7526
	ret ; $7529
	ld bc, $0040 ; $752a
	farcall FarPtr_SetPlayerMoveSpeed ; $752d
	ld a, $04 ; $7530
	ld bc, $0018 ; $7532
	farcall FarPtr_ScriptSetActorMoveSpeed ; $7535
	ld a, $03 ; $7538
	ld bc, $2b00 ; $753a
	ld de, $2700 ; $753d
	farcall FarPtr_ScriptSetActorPosition ; $7540
	ld a, $04 ; $7543
	ld bc, $2200 ; $7545
	ld de, $0f00 ; $7548
	farcall FarPtr_ScriptSetActorPosition ; $754b
	ld a, $00 ; $754e
	ld bc, $2400 ; $7550
	ld de, $1b00 ; $7553
	farcall FarPtr_ScriptSetActorPosition ; $7556
	xor a, a ; $7559
	ld bc, $2400 ; $755a
	ld de, $1500 ; $755d
	farcall FarPtr_MovePlayerToPosition ; $7560
	farcall FarPtr_WaitPlayerMoveDone ; $7563
	ld a, $00 ; $7566
	ld b, $c0 ; $7568
	farcall FarPtr_SetActorFacing ; $756a
	ld a, $04 ; $756d
	ld b, $40 ; $756f
	farcall FarPtr_SetActorFacing ; $7571
	ld a, $03 ; $7574
	ld b, $c0 ; $7576
	farcall FarPtr_SetActorFacing ; $7578
	call PlaceSeniorCourtPairA ; $757b
	ld c, $08 ; $757e
	call BeginFadeIn ; $7580
	call WaitFadeEnd ; $7583
	push af ; $7586
	ld a, $1e ; $7587
	farcall FarPtr_WaitScriptFrames ; $7589
	pop af ; $758c
	ld hl, $104e ; $758d
	farcall FarPtr_InitDialogueTextCursor ; $7590
	ld a, $04 ; $7593
	ld bc, $2400 ; $7595
	ld de, $1300 ; $7598
	farcall FarPtr_ScriptSetActorMoveTarget ; $759b
	ld a, $04 ; $759e
	farcall FarPtr_ScriptWaitActorMoveDone ; $75a0
	ld a, $04 ; $75a3
	ld d, $02 ; $75a5
	farcall FarPtr_ScriptSetActorAnimation ; $75a7
	ld a, $04 ; $75aa
	farcall FarPtr_ScriptShowSpeakerDialogue ; $75ac
	ld a, $03 ; $75af
	ld d, $03 ; $75b1
	farcall FarPtr_ScriptSetActorAnimation ; $75b3
	ld a, $03 ; $75b6
	farcall FarPtr_ScriptShowSpeakerDialogue ; $75b8
	ld a, $04 ; $75bb
	ld d, $02 ; $75bd
	farcall FarPtr_ScriptSetActorAnimation ; $75bf
	ld a, $00 ; $75c2
	ld d, $02 ; $75c4
	farcall FarPtr_ScriptSetActorAnimation ; $75c6
	ld a, $00 ; $75c9
	ld b, $40 ; $75cb
	farcall FarPtr_SetActorFacing ; $75cd
	ld bc, $0010 ; $75d0
	farcall FarPtr_SetPlayerMoveSpeed ; $75d3
	ld a, $03 ; $75d6
	ld bc, $0010 ; $75d8
	farcall FarPtr_ScriptSetActorMoveSpeed ; $75db
	xor a, a ; $75de
	ld bc, $2b00 ; $75df
	ld de, $2000 ; $75e2
	farcall FarPtr_MovePlayerToPosition ; $75e5
	ld a, $03 ; $75e8
	ld bc, $2b00 ; $75ea
	ld de, $1f00 ; $75ed
	farcall FarPtr_ScriptSetActorMoveTarget ; $75f0
	ld a, $03 ; $75f3
	farcall FarPtr_ScriptWaitActorMoveDone ; $75f5
	farcall FarPtr_WaitPlayerMoveDone ; $75f8
	xor a, a ; $75fb
	ld bc, $2400 ; $75fc
	ld de, $1e00 ; $75ff
	farcall FarPtr_MovePlayerToPosition ; $7602
	ld a, $03 ; $7605
	ld bc, $2400 ; $7607
	ld de, $1f00 ; $760a
	farcall FarPtr_ScriptSetActorMoveTarget ; $760d
	ld a, $03 ; $7610
	farcall FarPtr_ScriptWaitActorMoveDone ; $7612
	ld a, $03 ; $7615
	ld bc, $2400 ; $7617
	ld de, $1e00 ; $761a
	farcall FarPtr_ScriptSetActorMoveTarget ; $761d
	ld a, $03 ; $7620
	farcall FarPtr_ScriptWaitActorMoveDone ; $7622
	ld a, $03 ; $7625
	ld d, $02 ; $7627
	farcall FarPtr_ScriptSetActorAnimation ; $7629
	ld a, $03 ; $762c
	farcall FarPtr_ScriptWaitActorIdle ; $762e
	ld a, $03 ; $7631
	farcall FarPtr_ScriptShowSpeakerDialogue ; $7633
	ld a, $00 ; $7636
	ld d, $03 ; $7638
	farcall FarPtr_ScriptSetActorAnimation ; $763a
	ld a, $00 ; $763d
	farcall FarPtr_ScriptWaitActorIdle ; $763f
	ld a, $03 ; $7642
	ld d, $03 ; $7644
	farcall FarPtr_ScriptSetActorAnimation ; $7646
	ld a, $03 ; $7649
	farcall FarPtr_ScriptWaitActorIdle ; $764b
	ld a, $03 ; $764e
	farcall FarPtr_ScriptShowSpeakerDialogue ; $7650
	ld a, $03 ; $7653
	ld bc, $2400 ; $7655
	ld de, $1d00 ; $7658
	farcall FarPtr_ScriptSetActorMoveTarget ; $765b
	ld a, $03 ; $765e
	farcall FarPtr_ScriptWaitActorMoveDone ; $7660
	ld a, $03 ; $7663
	ld d, $02 ; $7665
	farcall FarPtr_ScriptSetActorAnimation ; $7667
	ld a, $03 ; $766a
	farcall FarPtr_ScriptWaitActorIdle ; $766c
	push af ; $766f
	ld a, $1e ; $7670
	farcall FarPtr_WaitScriptFrames ; $7672
	pop af ; $7675
	ld a, $03 ; $7676
	ld d, $03 ; $7678
	farcall FarPtr_ScriptSetActorAnimation ; $767a
	ld a, $00 ; $767d
	ld d, $03 ; $767f
	farcall FarPtr_ScriptSetActorAnimation ; $7681
	ld a, $00 ; $7684
	farcall FarPtr_ScriptWaitActorIdle ; $7686
	ld a, $00 ; $7689
	farcall FarPtr_ScriptShowSpeakerDialogue ; $768b
	ld a, $03 ; $768e
	ld d, $02 ; $7690
	farcall FarPtr_ScriptSetActorAnimation ; $7692
	ld a, $03 ; $7695
	farcall FarPtr_ScriptWaitActorIdle ; $7697
	ld a, $03 ; $769a
	farcall FarPtr_ScriptShowSpeakerDialogue ; $769c
	ld a, $00 ; $769f
	ld d, $03 ; $76a1
	farcall FarPtr_ScriptSetActorAnimation ; $76a3
	ld a, $00 ; $76a6
	farcall FarPtr_ScriptWaitActorIdle ; $76a8
	ld a, $03 ; $76ab
	ld d, $03 ; $76ad
	farcall FarPtr_ScriptSetActorAnimation ; $76af
	ld a, $03 ; $76b2
	farcall FarPtr_ScriptWaitActorIdle ; $76b4
	ld a, $00 ; $76b7
	ld d, $02 ; $76b9
	farcall FarPtr_ScriptSetActorAnimation ; $76bb
	ld a, $00 ; $76be
	farcall FarPtr_ScriptWaitActorIdle ; $76c0
	ld a, $00 ; $76c3
	ld b, $c0 ; $76c5
	farcall FarPtr_SetActorFacing ; $76c7
	ld a, $11 ; $76ca
	ld bc, $2580 ; $76cc
	ld de, $1980 ; $76cf
	farcall FarPtr_ScriptSetActorPosition ; $76d2
	sound $96 ; $76d5
	push af ; $76d7
	ld a, $28 ; $76d8
	farcall FarPtr_WaitScriptFrames ; $76da
	pop af ; $76dd
	xor a, a ; $76de
	ld bc, $2400 ; $76df
	ld de, $1700 ; $76e2
	farcall FarPtr_MovePlayerToPosition ; $76e5
	farcall FarPtr_WaitPlayerMoveDone ; $76e8
	ld a, $04 ; $76eb
	ld d, $02 ; $76ed
	farcall FarPtr_ScriptSetActorAnimation ; $76ef
	push af ; $76f2
	ld a, $28 ; $76f3
	farcall FarPtr_WaitScriptFrames ; $76f5
	pop af ; $76f8
	ld a, $04 ; $76f9
	ld bc, $2400 ; $76fb
	ld de, $1500 ; $76fe
	farcall FarPtr_ScriptSetActorMoveTarget ; $7701
	ld a, $04 ; $7704
	farcall FarPtr_ScriptWaitActorMoveDone ; $7706
	ld a, $11 ; $7709
	ld bc, $3f00 ; $770b
	ld de, $3f00 ; $770e
	farcall FarPtr_ScriptSetActorPosition ; $7711
	ld a, $04 ; $7714
	farcall FarPtr_ScriptShowSpeakerDialogue ; $7716
	ld a, $10 ; $7719
	ld [wStoryModeCurrentLocation], a ; $771b
	ld a, $01 ; $771e
	ld [$c295], a ; $7720
	ld a, $ff ; $7723
	ld [$c294], a ; $7725
	ld [$c2a1], a ; $7728
	ld a, $03 ; $772b
	ld d, $03 ; $772d
	farcall FarPtr_ScriptSetActorAnimation ; $772f
	ld a, $03 ; $7732
	farcall FarPtr_ScriptWaitActorIdle ; $7734
	ld a, $00 ; $7737
	ld d, $02 ; $7739
	farcall FarPtr_ScriptSetActorAnimation ; $773b
	ld a, $00 ; $773e
	farcall FarPtr_ScriptWaitActorIdle ; $7740
	push af ; $7743
	ld a, $1e ; $7744
	farcall FarPtr_WaitScriptFrames ; $7746
	pop af ; $7749
	ld c, $08 ; $774a
	call BeginFadeOut ; $774c
	call WaitFadeEnd ; $774f
	farcall FarPtr_EndCutsceneScriptMode ; $7752
	ret ; $7755
ComputeSeniorCourtStage:
	test_flag $05, 7 ; $7756
	jp nz, Label_12_7793 ; $7759
	ld a, $00 ; $775c
	test_flag $0a, 3 ; $775e
	jr z, Label_12_778f ; $7761
	ld a, $02 ; $7763
	test_flag $0a, 4 ; $7765
	jr z, Label_12_778f ; $7768
	ld a, $03 ; $776a
	test_flag $0a, 5 ; $776c
	jr z, Label_12_778f ; $776f
	ld a, $04 ; $7771
	test_flag $0a, 6 ; $7773
	jr z, Label_12_778f ; $7776
	ld a, $05 ; $7778
	test_flag $0a, 7 ; $777a
	jr z, Label_12_778f ; $777d
	ld a, $09 ; $777f
	test_flag $15, 6 ; $7781
	jr z, Label_12_778f ; $7784
	ld a, $0b ; $7786
	test_flag $16, 0 ; $7788
	jr z, Label_12_778f ; $778b
	ld a, $0d ; $778d
Label_12_778f:
	ld [$c2b1], a ; $778f
	ret ; $7792
Label_12_7793:
	ld a, $01 ; $7793
	test_flag $08, 2 ; $7795
	jr z, Label_12_778f ; $7798
	ld a, $06 ; $779a
	test_flag $08, 4 ; $779c
	jr z, Label_12_778f ; $779f
	ld a, $07 ; $77a1
	test_flag $08, 5 ; $77a3
	jr z, Label_12_778f ; $77a6
	ld a, $08 ; $77a8
	test_flag $08, 6 ; $77aa
	jr z, Label_12_778f ; $77ad
	ld a, $0a ; $77af
	test_flag $15, 7 ; $77b1
	jr z, Label_12_778f ; $77b4
	ld a, $0c ; $77b6
	test_flag $16, 1 ; $77b8
	jr z, Label_12_778f ; $77bb
	ld a, $0e ; $77bd
	jr Label_12_778f ; $77bf
	ret ; $77c1
FadeInSeniorCourtNearPairA:
	call PlaceSeniorCourtPairA ; $77c2
	ld bc, $0040 ; $77c5
	farcall FarPtr_SetPlayerMoveSpeed ; $77c8
	ld a, $00 ; $77cb
	ld bc, $2400 ; $77cd
	ld de, $1b00 ; $77d0
	farcall FarPtr_ScriptSetActorPosition ; $77d3
	xor a, a ; $77d6
	ld bc, $2400 ; $77d7
	ld de, $1500 ; $77da
	farcall FarPtr_MovePlayerToPosition ; $77dd
	farcall FarPtr_WaitPlayerMoveDone ; $77e0
	ld a, $00 ; $77e3
	ld b, $c0 ; $77e5
	farcall FarPtr_SetActorFacing ; $77e7
	ld a, $03 ; $77ea
	ld b, $80 ; $77ec
	farcall FarPtr_SetActorFacing ; $77ee
	farcall FarPtr_WaitPlayerMoveDone ; $77f1
	ld c, $20 ; $77f4
	call BeginFadeIn ; $77f6
	call WaitFadeEnd ; $77f9
	ret ; $77fc
FadeInSeniorCourtNearPairB:
	call PlaceSeniorCourtPairB ; $77fd
	ld bc, $0040 ; $7800
	farcall FarPtr_SetPlayerMoveSpeed ; $7803
	xor a, a ; $7806
	ld bc, $3500 ; $7807
	ld de, $1500 ; $780a
	farcall FarPtr_MovePlayerToPosition ; $780d
	farcall FarPtr_WaitPlayerMoveDone ; $7810
	ld a, $00 ; $7813
	ld b, $c0 ; $7815
	farcall FarPtr_SetActorFacing ; $7817
	ld a, $03 ; $781a
	ld b, $00 ; $781c
	farcall FarPtr_SetActorFacing ; $781e
	farcall FarPtr_WaitPlayerMoveDone ; $7821
	ld c, $20 ; $7824
	call BeginFadeIn ; $7826
	call WaitFadeEnd ; $7829
	ret ; $782c
	INCBIN "data/bank_012/d_782d.bin" ; $782d, 571 bytes
PushTextArgFetchedString:
	ldh a, [hWramBank] ; $7a68
	push af ; $7a6a
	wram_bank $07 ; $7a6b
	ld de, $df00 ; $7a71
	wram_bank $05 ; $7a74
	farcall FarPtr_FetchShortTextToBuffer ; $7a7a
	ld hl, $df00 ; $7a7d
	farcall FarPtr_PushTextArgString ; $7a80
	pop af ; $7a83
	wram_bank ; $7a84
	ret ; $7a88
	INCBIN "data/bank_012/d_7a89.bin" ; $7a89, 40 bytes
	ret ; $7ab1
	INCBIN "data/bank_012/d_7ab2.bin" ; $7ab2, 451 bytes
ComputeSeniorCourtStageB:
	test_flag $05, 7 ; $7c75
	jr nz, Label_12_7c9c ; $7c78
	ld a, $00 ; $7c7a
	test_flag $0a, 3 ; $7c7c
	jr z, Label_12_7c98 ; $7c7f
	ld a, $02 ; $7c81
	test_flag $0a, 7 ; $7c83
	jr z, Label_12_7c98 ; $7c86
	ld a, $04 ; $7c88
	test_flag $15, 6 ; $7c8a
	jr z, Label_12_7c98 ; $7c8d
	ld a, $06 ; $7c8f
	test_flag $16, 0 ; $7c91
	jr z, Label_12_7c98 ; $7c94
	ld a, $08 ; $7c96
Label_12_7c98:
	ld [$c2b0], a ; $7c98
	ret ; $7c9b
Label_12_7c9c:
	ld a, $01 ; $7c9c
	test_flag $08, 2 ; $7c9e
	jr z, Label_12_7c98 ; $7ca1
	ld a, $03 ; $7ca3
	test_flag $08, 6 ; $7ca5
	jr z, Label_12_7c98 ; $7ca8
	ld a, $05 ; $7caa
	test_flag $15, 7 ; $7cac
	jr z, Label_12_7c98 ; $7caf
	ld a, $07 ; $7cb1
	test_flag $16, 1 ; $7cb3
	jr z, Label_12_7c98 ; $7cb6
	ld a, $09 ; $7cb8
	jr Label_12_7c98 ; $7cba
	ld a, $00 ; $7cbc
	test_flag $0a, 3 ; $7cbe
	jr z, Label_12_7cdb ; $7cc1
	inc a ; $7cc3
	test_flag $0a, 7 ; $7cc4
	jr z, Label_12_7cdb ; $7cc7
	inc a ; $7cc9
	test_flag $05, 7 ; $7cca
	jr nz, Label_12_7cdf ; $7ccd
	test_flag $15, 6 ; $7ccf
	jr z, Label_12_7cdb ; $7cd2
	inc a ; $7cd4
	test_flag $16, 0 ; $7cd5
	jr z, Label_12_7cdb ; $7cd8
	inc a ; $7cda
Label_12_7cdb:
	ld [$c2b0], a ; $7cdb
	ret ; $7cde
Label_12_7cdf:
	test_flag $15, 7 ; $7cdf
	jr z, Label_12_7cdb ; $7ce2
	inc a ; $7ce4
	test_flag $16, 1 ; $7ce5
	jr z, Label_12_7cdb ; $7ce8
	inc a ; $7cea
	jr Label_12_7cdb ; $7ceb
	ds 787, $ff ; $7ced, fill
