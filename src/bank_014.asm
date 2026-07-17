SECTION "ROM Bank $14", ROMX[$4000], BANK[$14]

	; $4000, 8 bytes (records:2)
	dw $4008 ; record 0
	dw $4a39 ; record 1
	dw $4fac ; record 2
	dw $5221 ; record 3
	; $4008, 14 bytes (records:2)
	dw $404a ; record 0
	dw $4086 ; record 1
	dw $4016 ; record 2
	dw $40fa ; record 3
	dw $41e6 ; record 4
	dw $41e7 ; record 5
	dw $4278 ; record 6
	; $4016, 52 bytes (bytes:14)
	db $00, $00, $b1, $78, $00, $2b, $00, $33, $00, $00, $3d, $01, $00, $00 ; 0x00
	db $00, $00, $b1, $78, $00, $2b, $00, $31, $00, $00, $3d, $01, $00, $00 ; 0x0e
	db $00, $00, $b1, $78, $00, $2d, $00, $2b, $80, $00, $3e, $01, $00, $00 ; 0x1c
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $ff ; 0x2a
	; $404a, 25 bytes (bytes:16)
	db $01, $c0, $00, $2b, $00, $39, $63, $40, $05, $c0, $00, $38, $00, $36, $00, $00 ; 0x00
	db $07, $c0, $00, $38, $00, $36, $00, $00, $ff ; 0x10
	ld a, [$c295] ; $4063
	cp a, $ff ; $4066
	jp z, Label_14_4085 ; $4068
	clear_flag $0f, 5 ; $406b
	test_flag $05, 7 ; $406e
	jr z, Label_14_4085 ; $4071
	ld a, $02 ; $4073
	ld bc, $2b00 ; $4075
	ld de, $3b00 ; $4078
	farcall FarPtr_ScriptSetActorPosition ; $407b
	ld a, $02 ; $407e
	ld b, $c0 ; $4080
	farcall FarPtr_SetActorFacing ; $4082
Label_14_4085:
	ret ; $4085
	; $4086, 9 bytes (records:8)
; 1 records x 8 bytes
	dw $ff04, $0000, $78d9, $0311 ; record 0
	db $ff
	ld a, [$c2b0] ; $408f
	add a, a ; $4092
	add a, $a6 ; $4093
	ld l, a ; $4095
	adc a, $40 ; $4096
	sub a, l ; $4098
	ld h, a ; $4099
	ld a, [hl+] ; $409a
	ld h, [hl] ; $409b
	ld l, a ; $409c
	farcall FarPtr_InitDialogueTextCursor ; $409d
	ld a, $03 ; $40a0
	farcall FarPtr_ScriptShowSpeakerDialogue ; $40a2
	ret ; $40a5
	; $40a6, 14 bytes (records:2)
	dw $20a7 ; record 0
	dw $20b0 ; record 1
	dw $20b9 ; record 2
	dw $20c0 ; record 3
	dw $20c7 ; record 4
	dw $20cf ; record 5
	dw $20d6 ; record 6
	ld a, [$c2b0] ; $40b4
	add a, a ; $40b7
	add a, $ec ; $40b8
	ld l, a ; $40ba
	adc a, $40 ; $40bb
	sub a, l ; $40bd
	ld h, a ; $40be
	ld a, [hl+] ; $40bf
	ld h, [hl] ; $40c0
	ld l, a ; $40c1
	farcall FarPtr_InitDialogueTextCursor ; $40c2
	ld a, [$c2b0] ; $40c5
	cp a, $01 ; $40c8
	jr z, Label_14_40ce ; $40ca
	jr Label_14_40e6 ; $40cc
Label_14_40ce:
	ld a, $04 ; $40ce
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $40d0
	farcall FarPtr_RunDialogueYesNoPrompt ; $40d3
	farcall FarPtr_ScriptCloseDialogueWindow ; $40d6
	push af ; $40d9
	ld a, $05 ; $40da
	farcall FarPtr_WaitScriptFrames ; $40dc
	pop af ; $40df
	and a, a ; $40e0
	jr z, Label_14_40e6 ; $40e1
	farcall FarPtr_AdvanceDialogueTextCursor ; $40e3
Label_14_40e6:
	ld a, $04 ; $40e6
	farcall FarPtr_ScriptShowSpeakerDialogue ; $40e8
	ret ; $40eb
	; $40ec, 14 bytes (records:2)
	dw $20a8 ; record 0
	dw $20b1 ; record 1
	dw $20ba ; record 2
	dw $20c1 ; record 3
	dw $20c8 ; record 4
	dw $20d0 ; record 5
	dw $20d7 ; record 6
	; $40fa, 25 bytes (records:8)
; 3 records x 8 bytes
	dw $ff03, $0000, $408f, $0003 ; record 0
	dw $ff04, $0000, $40b4, $0003 ; record 1
	dw $ff05, $0000, $442d, $0000 ; record 2
	db $ff
MachineLevel1FailedPrompt:
	ld hl, $20db ; $4113
	farcall FarPtr_InitDialogueTextCursor ; $4116
	ld hl, $000f ; $4119
	farcall FarPtr_PushTextArgNumber ; $411c
	ld hl, wMinigamesCurrentScore ; $411f
	ld a, [hl+] ; $4122
	ld h, [hl] ; $4123
	ld l, a ; $4124
	farcall FarPtr_PushTextArgNumber ; $4125
	jp MachineCourtHandleRetryChoice ; $4128
MachineLevel1ClearedScene:
	call MachineCourtWalkToAttendantCutscene ; $412b
	ld hl, $20af ; $412e
	farcall FarPtr_InitDialogueTextCursor ; $4131
	ld a, $05 ; $4134
	farcall FarPtr_ScriptShowSpeakerDialogue ; $4136
	ld a, $02 ; $4139
	farcall FarPtr_GetActorStateAddr ; $413b
	ld c, l ; $413e
	ld b, h ; $413f
	ld de, $d000 ; $4140
	farcall FarPtr_04_20 ; $4143
	ret ; $4146
MachineLevel2FailedPrompt:
	ld hl, $20db ; $4147
	farcall FarPtr_InitDialogueTextCursor ; $414a
	ld hl, $001e ; $414d
	farcall FarPtr_PushTextArgNumber ; $4150
	ld hl, wMinigamesCurrentScore ; $4153
	ld a, [hl+] ; $4156
	ld h, [hl] ; $4157
	ld l, a ; $4158
	farcall FarPtr_PushTextArgNumber ; $4159
	jp MachineCourtHandleRetryChoice ; $415c
	ret ; $415f
MachineLevel2ClearedScene:
	call MachineCourtWalkToAttendantCutscene ; $4160
	ld hl, $20b7 ; $4163
	farcall FarPtr_InitDialogueTextCursor ; $4166
	ld a, $05 ; $4169
	farcall FarPtr_ScriptShowSpeakerDialogue ; $416b
	ld a, $02 ; $416e
	farcall FarPtr_GetActorStateAddr ; $4170
	ld c, l ; $4173
	ld b, h ; $4174
	ld de, $d000 ; $4175
	farcall FarPtr_04_20 ; $4178
	ret ; $417b
MachineLevel3FailedPrompt:
	ld hl, $20db ; $417c
	farcall FarPtr_InitDialogueTextCursor ; $417f
	ld hl, $003c ; $4182
	farcall FarPtr_PushTextArgNumber ; $4185
	ld hl, wMinigamesCurrentScore ; $4188
	ld a, [hl+] ; $418b
	ld h, [hl] ; $418c
	ld l, a ; $418d
	farcall FarPtr_PushTextArgNumber ; $418e
	jp MachineCourtHandleRetryChoice ; $4191
	ret ; $4194
MachineLevel3ClearedScene:
	call MachineCourtWalkToAttendantCutscene ; $4195
	ld hl, $20be ; $4198
	farcall FarPtr_InitDialogueTextCursor ; $419b
	ld a, $05 ; $419e
	farcall FarPtr_ScriptShowSpeakerDialogue ; $41a0
	ld a, $02 ; $41a3
	farcall FarPtr_GetActorStateAddr ; $41a5
	ld c, l ; $41a8
	ld b, h ; $41a9
	ld de, $d000 ; $41aa
	farcall FarPtr_04_20 ; $41ad
	ret ; $41b0
MachineLevel4FailedPrompt:
	ld hl, $20db ; $41b1
	farcall FarPtr_InitDialogueTextCursor ; $41b4
	ld hl, $0064 ; $41b7
	farcall FarPtr_PushTextArgNumber ; $41ba
	ld hl, wMinigamesCurrentScore ; $41bd
	ld a, [hl+] ; $41c0
	ld h, [hl] ; $41c1
	ld l, a ; $41c2
	farcall FarPtr_PushTextArgNumber ; $41c3
	jp MachineCourtHandleRetryChoice ; $41c6
	ret ; $41c9
MachineLevel4ClearedScene:
	call MachineCourtWalkToAttendantCutscene ; $41ca
	ld hl, $20c5 ; $41cd
	farcall FarPtr_InitDialogueTextCursor ; $41d0
	ld a, $05 ; $41d3
	farcall FarPtr_ScriptShowSpeakerDialogue ; $41d5
	ld a, $02 ; $41d8
	farcall FarPtr_GetActorStateAddr ; $41da
	ld c, l ; $41dd
	ld b, h ; $41de
	ld de, $d000 ; $41df
	farcall FarPtr_04_20 ; $41e2
	ret ; $41e5
	db $ff ; $41e6
	; $41e7, 41 bytes (records:8)
; 5 records x 8 bytes
	dw $ff01, $9c20, $4227, $0000 ; record 0
	dw $ff03, $0000, $4210, $0001 ; record 1
	dw $ff04, $0000, $4216, $0001 ; record 2
	dw $ff05, $0000, $421c, $0001 ; record 3
	dw $ff06, $0000, $4222, $0001 ; record 4
	db $ff
	ld a, $00 ; $4210
	jp MachinePracticeLevelPrompt ; $4212
	ret ; $4215
	ld a, $01 ; $4216
	jp MachinePracticeLevelPrompt ; $4218
	ret ; $421b
	ld a, $02 ; $421c
	jp MachinePracticeLevelPrompt ; $421e
	ret ; $4221
	ld a, $03 ; $4222
	jp MachinePracticeLevelPrompt ; $4224
	clear_flag $1c, 1 ; $4227
	clear_flag $0f, 5 ; $422a
	ld a, $00 ; $422d
	ld bc, $2ac0 ; $422f
	ld de, $2b00 ; $4232
	farcall FarPtr_ScriptSetActorMoveTarget ; $4235
	ld a, $00 ; $4238
	farcall FarPtr_ScriptWaitActorMoveDone ; $423a
	ld a, $05 ; $423d
	ld bc, $2d00 ; $423f
	ld de, $2b00 ; $4242
	farcall FarPtr_ScriptSetActorMoveTarget ; $4245
	ld a, $05 ; $4248
	farcall FarPtr_ScriptWaitActorMoveDone ; $424a
	push af ; $424d
	ld a, $05 ; $424e
	farcall FarPtr_WaitScriptFrames ; $4250
	pop af ; $4253
	ld a, $05 ; $4254
	ld b, $80 ; $4256
	farcall FarPtr_SetActorFacing ; $4258
	ld a, $00 ; $425b
	ld b, $00 ; $425d
	farcall FarPtr_SetActorFacing ; $425f
	ld a, $02 ; $4262
	farcall FarPtr_GetActorStateAddr ; $4264
	ld c, l ; $4267
	ld b, h ; $4268
	ld de, $d000 ; $4269
	farcall FarPtr_04_20 ; $426c
	ret ; $426f
	; $4270, 8 bytes (bytes:16)
	db $12, $13, $14, $15, $1a, $1a, $1a, $1a ; 0x00
	ld a, $26 ; $4278
	ld [$c329], a ; $427a
	ld a, $23 ; $427d
	ld [$c32a], a ; $427f
	ld a, $40 ; $4282
	ld [$c32b], a ; $4284
	ld a, $3c ; $4287
	ld [$c32c], a ; $4289
	call DisableLCDSafely ; $428c
	ld a, $00 ; $428f
	farcall FarPtr_CopyScrolledSceneTilemapToVram ; $4291
	call EnableLCD ; $4294
	call ComputeMachineCourtProgress ; $4297
	farcall FarPtr_WaitPlayerMoveDone ; $429a
	ld a, [$c295] ; $429d
	cp a, $05 ; $42a0
	jp z, MachineCourtResultScene ; $42a2
	cp a, $07 ; $42a5
	jp z, MachinePracticeResultScene ; $42a7
	cp a, $ff ; $42aa
	jp z, Label_14_4a00 ; $42ac
	ret ; $42af
MachineCourtResultScene:
	test_flag $05, 7 ; $42b0
	jr z, Label_14_42d3 ; $42b3
	ld a, $02 ; $42b5
	farcall FarPtr_0a_1c ; $42b7
	push af ; $42ba
	ld a, $0a ; $42bb
	farcall FarPtr_WaitScriptFrames ; $42bd
	pop af ; $42c0
	ld a, $02 ; $42c1
	ld bc, $2900 ; $42c3
	ld de, $2b00 ; $42c6
	farcall FarPtr_ScriptSetActorPosition ; $42c9
	ld a, $02 ; $42cc
	ld b, $00 ; $42ce
	farcall FarPtr_SetActorFacing ; $42d0
Label_14_42d3:
	ld a, $05 ; $42d3
	ld bc, $2d00 ; $42d5
	ld de, $2900 ; $42d8
	farcall FarPtr_ScriptSetActorPosition ; $42db
	ld a, $05 ; $42de
	ld b, $40 ; $42e0
	farcall FarPtr_SetActorFacing ; $42e2
	ld c, $06 ; $42e5
	call BeginFadeIn ; $42e7
	call WaitFadeEnd ; $42ea
	push af ; $42ed
	ld a, $28 ; $42ee
	farcall FarPtr_WaitScriptFrames ; $42f0
	pop af ; $42f3
	ld a, $00 ; $42f4
	ld bc, $0020 ; $42f6
	farcall FarPtr_0a_18 ; $42f9
	test_flag $05, 7 ; $42fc
	jr z, Label_14_4301 ; $42ff
Label_14_4301:
	xor a, a ; $4301
	ld [$c2d5], a ; $4302
	ld a, [$c4c7] ; $4305
	and a, a ; $4308
	jp nz, MachineCourtGameOverExitScene ; $4309
	ld a, [wPointWinLoseFlag] ; $430c
	cp a, $01 ; $430f
	jr z, Label_14_4326 ; $4311
	ld a, [$c2b0] ; $4313
	ld a, a ; $4316
	rst Rst00 ; $4317
	dw MachineLevel1FailedPrompt ; $4318 jumptable
	dw MachineLevel2FailedPrompt ; $431a jumptable
	dw MachineLevel3FailedPrompt ; $431c jumptable
	dw MachineLevel4FailedPrompt ; $431e jumptable
	dw MachineExpertResultScene ; $4320 jumptable
	dw MachineExpertResultScene ; $4322 jumptable
	dw MachineExpertResultScene ; $4324 jumptable
Label_14_4326:
	ld a, [$c2b0] ; $4326
	dec a ; $4329
	ld a, a ; $432a
	rst Rst00 ; $432b
	dw MachineLevel1ClearedScene ; $432c jumptable
	dw MachineLevel2ClearedScene ; $432e jumptable
	dw MachineLevel3ClearedScene ; $4330 jumptable
	dw MachineLevel4ClearedScene ; $4332 jumptable
	dw MachineExpertResultScene ; $4334 jumptable
	dw MachineExpertResultScene ; $4336 jumptable
	dw MachineExpertResultScene ; $4338 jumptable
MachineCourtGameOverExitScene:
	ld hl, $20dc ; $433a
	farcall FarPtr_InitDialogueTextCursor ; $433d
	ld a, $05 ; $4340
	farcall FarPtr_ScriptShowSpeakerDialogue ; $4342
	ld a, $00 ; $4345
	ld bc, $3300 ; $4347
	ld de, $3600 ; $434a
	farcall FarPtr_ScriptSetActorMoveTarget ; $434d
	ld a, $00 ; $4350
	farcall FarPtr_ScriptWaitActorMoveDone ; $4352
	xor a, a ; $4355
	ld bc, $2f00 ; $4356
	ld de, $2d00 ; $4359
	farcall FarPtr_MovePlayerToPosition ; $435c
	ld a, $00 ; $435f
	ld bc, $3300 ; $4361
	ld de, $2b00 ; $4364
	farcall FarPtr_ScriptSetActorMoveTarget ; $4367
	ld a, $00 ; $436a
	farcall FarPtr_ScriptWaitActorMoveDone ; $436c
	ld a, $00 ; $436f
	ld bc, $2b00 ; $4371
	ld de, $2b00 ; $4374
	farcall FarPtr_ScriptSetActorMoveTarget ; $4377
	ld a, $00 ; $437a
	farcall FarPtr_ScriptWaitActorMoveDone ; $437c
	ld a, $05 ; $437f
	ld bc, $2d00 ; $4381
	ld de, $2b00 ; $4384
	farcall FarPtr_ScriptSetActorMoveTarget ; $4387
	ld a, $05 ; $438a
	farcall FarPtr_ScriptWaitActorMoveDone ; $438c
	ld a, $05 ; $438f
	ld b, $80 ; $4391
	farcall FarPtr_SetActorFacing ; $4393
	ld a, $02 ; $4396
	farcall FarPtr_GetActorStateAddr ; $4398
	ld c, l ; $439b
	ld b, h ; $439c
	ld de, $d000 ; $439d
	farcall FarPtr_04_20 ; $43a0
	ret ; $43a3
ComputeMachineCourtProgress:
	ld a, $00 ; $43a4
	test_flag $1a, 2 ; $43a6
	jp z, Label_14_4429 ; $43a9
	ld b, $1e ; $43ac
	ld c, $2c ; $43ae
	ld d, $30 ; $43b0
	ld e, $2c ; $43b2
	ld h, $02 ; $43b4
	ld l, $02 ; $43b6
	farcall FarPtr_0a_7e ; $43b8
	ld a, $01 ; $43bb
	test_flag $1a, 3 ; $43bd
	jp z, Label_14_4429 ; $43c0
	ld b, $1e ; $43c3
	ld c, $30 ; $43c5
	ld d, $30 ; $43c7
	ld e, $30 ; $43c9
	ld h, $02 ; $43cb
	ld l, $02 ; $43cd
	farcall FarPtr_0a_7e ; $43cf
	ld a, $02 ; $43d2
	test_flag $1a, 4 ; $43d4
	jr z, Label_14_4429 ; $43d7
	ld b, $1e ; $43d9
	ld c, $34 ; $43db
	ld d, $30 ; $43dd
	ld e, $34 ; $43df
	ld h, $02 ; $43e1
	ld l, $02 ; $43e3
	farcall FarPtr_0a_7e ; $43e5
	ld a, $03 ; $43e8
	test_flag $1a, 5 ; $43ea
	jr z, Label_14_4429 ; $43ed
	ld b, $1e ; $43ef
	ld c, $38 ; $43f1
	ld d, $30 ; $43f3
	ld e, $38 ; $43f5
	ld h, $02 ; $43f7
	ld l, $02 ; $43f9
	farcall FarPtr_0a_7e ; $43fb
	ld a, $04 ; $43fe
	ld b, a ; $4400
	ld a, $01 ; $4401
	farcall FarPtr_ReadMinigameRecord ; $4403
	ldh a, [hWramBank] ; $4406
	push af ; $4408
	wram_bank $07 ; $4409
	ld hl, $de00 ; $440f
	ld a, [hl+] ; $4412
	ld h, [hl] ; $4413
	ld l, a ; $4414
	pop af ; $4415
	wram_bank ; $4416
	ld a, b ; $441a
	test_flag $1b, 2 ; $441b
	jr z, Label_14_4429 ; $441e
	ld a, $05 ; $4420
	test_flag $1b, 4 ; $4422
	jr z, Label_14_4429 ; $4425
	ld a, $06 ; $4427
Label_14_4429:
	ld [$c2b0], a ; $4429
	ret ; $442c
	test_flag $1c, 0 ; $442d
	jp nz, MachineCourtStartLevelScene ; $4430
	ld a, [$c2b0] ; $4433
	add a, a ; $4436
	add a, $00 ; $4437
	ld l, a ; $4439
	adc a, $46 ; $443a
	sub a, l ; $443c
	ld h, a ; $443d
	ld a, [hl+] ; $443e
	ld h, [hl] ; $443f
	ld l, a ; $4440
	farcall FarPtr_InitDialogueTextCursor ; $4441
	ld a, [$c2b0] ; $4444
	cp a, $05 ; $4447
	jr c, Label_14_4467 ; $4449
	ldh a, [hWramBank] ; $444b
	push af ; $444d
	wram_bank $07 ; $444e
	ld a, $01 ; $4454
	farcall FarPtr_ReadMinigameRecord ; $4456
	ld hl, $de00 ; $4459
	ld a, [hl+] ; $445c
	ld h, [hl] ; $445d
	ld l, a ; $445e
	pop af ; $445f
	wram_bank ; $4460
	farcall FarPtr_PushTextArgNumber ; $4464
Label_14_4467:
	ld a, $02 ; $4467
	ld b, $00 ; $4469
	farcall FarPtr_SetActorFacing ; $446b
	ld a, $00 ; $446e
	ld b, $00 ; $4470
	farcall FarPtr_SetActorFacing ; $4472
	ld a, $05 ; $4475
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $4477
	farcall FarPtr_RunDialogueYesNoPrompt ; $447a
	farcall FarPtr_ScriptCloseDialogueWindow ; $447d
	push af ; $4480
	ld a, $05 ; $4481
	farcall FarPtr_WaitScriptFrames ; $4483
	pop af ; $4486
	and a, a ; $4487
	jr nz, Label_14_44a9 ; $4488
	set_flag $1c, 0 ; $448a
	farcall FarPtr_AdvanceDialogueTextCursor ; $448d
	ld a, [$c2b0] ; $4490
	and a, a ; $4493
	jr nz, Label_14_449b ; $4494
	ld a, $05 ; $4496
	farcall FarPtr_ScriptShowSpeakerDialogue ; $4498
Label_14_449b:
	ld a, $05 ; $449b
	ld d, $03 ; $449d
	farcall FarPtr_ScriptSetActorAnimation ; $449f
	ld a, $05 ; $44a2
	farcall FarPtr_ScriptWaitActorIdle ; $44a4
	jr nz, MachineCourtStartLevelScene ; $44a7
Label_14_44a9:
	test_flag $1a, 2 ; $44a9
	jr z, Label_14_44ca ; $44ac
	ld hl, $20de ; $44ae
	farcall FarPtr_InitDialogueTextCursor ; $44b1
	ld a, $05 ; $44b4
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $44b6
	farcall FarPtr_RunDialogueYesNoPrompt ; $44b9
	farcall FarPtr_ScriptCloseDialogueWindow ; $44bc
	push af ; $44bf
	ld a, $05 ; $44c0
	farcall FarPtr_WaitScriptFrames ; $44c2
	pop af ; $44c5
	and a, a ; $44c6
	jp z, Label_14_45a6 ; $44c7
Label_14_44ca:
	ld a, [$c2b0] ; $44ca
	add a, a ; $44cd
	add a, $00 ; $44ce
	ld l, a ; $44d0
	adc a, $46 ; $44d1
	sub a, l ; $44d3
	ld h, a ; $44d4
	ld a, [hl+] ; $44d5
	ld h, [hl] ; $44d6
	ld l, a ; $44d7
	farcall FarPtr_InitDialogueTextCursor ; $44d8
	farcall FarPtr_AdvanceDialogueTextCursor ; $44db
	ld a, $05 ; $44de
	farcall FarPtr_ScriptShowSpeakerDialogue ; $44e0
	ret ; $44e3
MachineCourtStartLevelScene:
	ld a, $05 ; $44e4
	farcall FarPtr_ScriptShowSpeakerDialogue ; $44e6
	ld a, $05 ; $44e9
	ld bc, $2d00 ; $44eb
	ld de, $2900 ; $44ee
	farcall FarPtr_ScriptSetActorMoveTarget ; $44f1
	ld a, $05 ; $44f4
	farcall FarPtr_ScriptWaitActorMoveDone ; $44f6
	ld a, $05 ; $44f9
	ld b, $40 ; $44fb
	farcall FarPtr_SetActorFacing ; $44fd
	test_flag $05, 7 ; $4500
	jr z, Label_14_4515 ; $4503
	ld a, $02 ; $4505
	farcall FarPtr_0a_1c ; $4507
	ldh a, [hRomBank] ; $450a
	ld b, a ; $450c
	ld a, $02 ; $450d
	ld de, $4808 ; $450f
	farcall FarPtr_0a_1a ; $4512
Label_14_4515:
	ld a, $00 ; $4515
	ld bc, $0020 ; $4517
	farcall FarPtr_0a_18 ; $451a
	xor a, a ; $451d
	ld bc, $3800 ; $451e
	ld de, $3300 ; $4521
	farcall FarPtr_MovePlayerToPosition ; $4524
	ld a, $00 ; $4527
	ld bc, $3300 ; $4529
	ld de, $2b00 ; $452c
	farcall FarPtr_ScriptSetActorMoveTarget ; $452f
	ld a, $00 ; $4532
	farcall FarPtr_ScriptWaitActorMoveDone ; $4534
	ld a, $00 ; $4537
	ld bc, $3300 ; $4539
	ld de, $3300 ; $453c
	farcall FarPtr_ScriptSetActorMoveTarget ; $453f
	ld a, $00 ; $4542
	farcall FarPtr_ScriptWaitActorMoveDone ; $4544
	ld a, $00 ; $4547
	ld bc, $3800 ; $4549
	ld de, $3500 ; $454c
	farcall FarPtr_ScriptSetActorMoveTarget ; $454f
	ld a, $00 ; $4552
	farcall FarPtr_ScriptWaitActorMoveDone ; $4554
	ld a, $00 ; $4557
	ld b, $c0 ; $4559
	farcall FarPtr_SetActorFacing ; $455b
	push af ; $455e
	ld a, $0a ; $455f
	farcall FarPtr_WaitScriptFrames ; $4561
	pop af ; $4564
	ld a, [$c2b0] ; $4565
	cp a, $04 ; $4568
	jr c, Label_14_4577 ; $456a
	ld hl, $20cc ; $456c
	farcall FarPtr_InitDialogueTextCursor ; $456f
	ld a, $05 ; $4572
	farcall FarPtr_ScriptShowSpeakerDialogue ; $4574
Label_14_4577:
	ld c, $06 ; $4577
	call BeginFadeOut ; $4579
	call WaitFadeEnd ; $457c
	clear_flag $1c, 0 ; $457f
	ld a, $12 ; $4582
	ld [wStoryModeCurrentLocation], a ; $4584
	ld a, $05 ; $4587
	ld [$c295], a ; $4589
	ld a, $ff ; $458c
	ld [$c294], a ; $458e
	ld [$c2a1], a ; $4591
	ld a, [$c2b0] ; $4594
	add a, $f8 ; $4597
	ld l, a ; $4599
	adc a, $45 ; $459a
	sub a, l ; $459c
	ld h, a ; $459d
	ld a, [hl] ; $459e
	farcall FarPtr_RunTrainingDrillByID ; $459f
	farcall FarPtr_0a_02 ; $45a2
	ret ; $45a5
Label_14_45a6:
	ld a, $05 ; $45a6
	farcall FarPtr_ScriptShowSpeakerDialogue ; $45a8
	set_flag $1c, 1 ; $45ab
	ld a, $05 ; $45ae
	ld bc, $2d00 ; $45b0
	ld de, $2900 ; $45b3
	farcall FarPtr_ScriptSetActorMoveTarget ; $45b6
	ld a, $05 ; $45b9
	farcall FarPtr_ScriptWaitActorMoveDone ; $45bb
	ld a, $05 ; $45be
	ld b, $40 ; $45c0
	farcall FarPtr_SetActorFacing ; $45c2
	ld a, $02 ; $45c5
	farcall FarPtr_0a_1c ; $45c7
	ld a, $00 ; $45ca
	ld bc, $0020 ; $45cc
	farcall FarPtr_0a_18 ; $45cf
	ldh a, [hRomBank] ; $45d2
	ld b, a ; $45d4
	ld a, $02 ; $45d5
	ld de, $4808 ; $45d7
	farcall FarPtr_0a_1a ; $45da
	ld a, $00 ; $45dd
	ld bc, $3100 ; $45df
	ld de, $2b00 ; $45e2
	farcall FarPtr_ScriptSetActorMoveTarget ; $45e5
	ld a, $00 ; $45e8
	farcall FarPtr_ScriptWaitActorMoveDone ; $45ea
	ld a, $00 ; $45ed
	ld b, $40 ; $45ef
	farcall FarPtr_SetActorFacing ; $45f1
	set_flag $0f, 5 ; $45f4
	ret ; $45f7
	; $45f8, 8 bytes (bytes:16)
	db $12, $13, $14, $15, $1a, $1a, $1a, $c9 ; 0x00
	; $4600, 18 bytes (records:2)
	dw $20a9 ; record 0
	dw $20b4 ; record 1
	dw $20bb ; record 2
	dw $20c2 ; record 3
	dw $20c9 ; record 4
	dw $20d1 ; record 5
	dw $20d8 ; record 6
	dw $20d1 ; record 7
	dw $20d8 ; record 8
MachinePracticeLevelPrompt:
	ld [$c2b8], a ; $4612
	call TestMachineLevelClearedFlag ; $4615
	jr z, MachineLevelNotClearedMessage ; $4618
	ld hl, $20e0 ; $461a
	farcall FarPtr_InitDialogueTextCursor ; $461d
	ld a, [$c2b8] ; $4620
	inc a ; $4623
	ld h, $00 ; $4624
	ld l, a ; $4626
	farcall FarPtr_PushTextArgNumber ; $4627
	ld a, $05 ; $462a
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $462c
	farcall FarPtr_RunDialogueYesNoPrompt ; $462f
	farcall FarPtr_ScriptCloseDialogueWindow ; $4632
	push af ; $4635
	ld a, $05 ; $4636
	farcall FarPtr_WaitScriptFrames ; $4638
	pop af ; $463b
	and a, a ; $463c
	jr nz, Label_14_4692 ; $463d
	ld a, $05 ; $463f
	ld b, $c0 ; $4641
	farcall FarPtr_SetActorFacing ; $4643
	ld a, $00 ; $4646
	ld bc, $0020 ; $4648
	farcall FarPtr_0a_18 ; $464b
	ld a, $00 ; $464e
	ld b, $00 ; $4650
	ld de, $0200 ; $4652
	farcall FarPtr_MoveActorByAngle ; $4655
	ld a, $00 ; $4658
	farcall FarPtr_ScriptWaitActorMoveDone ; $465a
	ld a, $00 ; $465d
	ld bc, $3500 ; $465f
	ld de, $3500 ; $4662
	farcall FarPtr_ScriptSetActorMoveTarget ; $4665
	ld a, $00 ; $4668
	farcall FarPtr_ScriptWaitActorMoveDone ; $466a
	ld c, $08 ; $466d
	call BeginFadeOut ; $466f
	call WaitFadeEnd ; $4672
	ld a, $12 ; $4675
	ld [wStoryModeCurrentLocation], a ; $4677
	ld a, $07 ; $467a
	ld [$c295], a ; $467c
	ld a, $ff ; $467f
	ld [$c294], a ; $4681
	ld [$c2a1], a ; $4684
	ld a, [$c2b8] ; $4687
	add a, $12 ; $468a
	farcall FarPtr_RunTrainingDrillByID ; $468c
	farcall FarPtr_0a_02 ; $468f
Label_14_4692:
	ret ; $4692
MachineLevelNotClearedMessage:
	ld hl, $20e1 ; $4693
	farcall FarPtr_InitDialogueTextCursor ; $4696
	ld a, $05 ; $4699
	farcall FarPtr_ScriptShowSpeakerDialogue ; $469b
	ret ; $469e
TestMachineLevelClearedFlag:
	add a, a ; $469f
	add a, $bd ; $46a0
	ld l, a ; $46a2
	adc a, $46 ; $46a3
	sub a, l ; $46a5
	ld h, a ; $46a6
	ld a, [hl+] ; $46a7
	ld d, [hl] ; $46a8
	ld e, a ; $46a9
	call TestGameFlagByNumber ; $46aa
	ret ; $46ad
	add a, a ; $46ae
	add a, $bd ; $46af
	ld l, a ; $46b1
	adc a, $46 ; $46b2
	sub a, l ; $46b4
	ld h, a ; $46b5
	ld a, [hl+] ; $46b6
	ld d, [hl] ; $46b7
	ld e, a ; $46b8
	call SetGameFlagByNumber ; $46b9
	ret ; $46bc
	; $46bd, 8 bytes (records:2)
	dw $00d2 ; record 0
	dw $00d3 ; record 1
	dw $00d4 ; record 2
	dw $00d5 ; record 3
MachinePracticeResultScene:
	xor a, a ; $46c5
	ld [$c2d5], a ; $46c6
	set_flag $1c, 1 ; $46c9
	test_flag $05, 7 ; $46cc
	jr z, Label_14_46ef ; $46cf
	ld a, $02 ; $46d1
	farcall FarPtr_0a_1c ; $46d3
	ld a, $02 ; $46d6
	ld bc, $2900 ; $46d8
	ld de, $2b00 ; $46db
	farcall FarPtr_ScriptSetActorPosition ; $46de
	ld a, $02 ; $46e1
	ld b, $00 ; $46e3
	farcall FarPtr_SetActorFacing ; $46e5
	push af ; $46e8
	ld a, $0a ; $46e9
	farcall FarPtr_WaitScriptFrames ; $46eb
	pop af ; $46ee
Label_14_46ef:
	ld a, $05 ; $46ef
	ld bc, $2d00 ; $46f1
	ld de, $2900 ; $46f4
	farcall FarPtr_ScriptSetActorPosition ; $46f7
	ld a, $05 ; $46fa
	ld b, $40 ; $46fc
	farcall FarPtr_SetActorFacing ; $46fe
	ld c, $06 ; $4701
	call BeginFadeIn ; $4703
	call WaitFadeEnd ; $4706
	push af ; $4709
	ld a, $28 ; $470a
	farcall FarPtr_WaitScriptFrames ; $470c
	pop af ; $470f
	ld a, [$c4c7] ; $4710
	and a, a ; $4713
	jp nz, Label_14_474d ; $4714
	ld hl, $20db ; $4717
	farcall FarPtr_InitDialogueTextCursor ; $471a
	ld hl, wMinigamesTargetScore ; $471d
	ld a, [hl+] ; $4720
	ld h, [hl] ; $4721
	ld l, a ; $4722
	farcall FarPtr_PushTextArgNumber ; $4723
	ld hl, wMinigamesCurrentScore ; $4726
	ld a, [hl+] ; $4729
	ld h, [hl] ; $472a
	ld l, a ; $472b
	farcall FarPtr_PushTextArgNumber ; $472c
	ld a, $00 ; $472f
	ld bc, $0020 ; $4731
	farcall FarPtr_0a_18 ; $4734
	ld a, $05 ; $4737
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $4739
	farcall FarPtr_RunDialogueYesNoPrompt ; $473c
	farcall FarPtr_ScriptCloseDialogueWindow ; $473f
	push af ; $4742
	ld a, $05 ; $4743
	farcall FarPtr_WaitScriptFrames ; $4745
	pop af ; $4748
	and a, a ; $4749
	jp z, MachineCourtRestartLevel ; $474a
Label_14_474d:
	ret ; $474d
MachineCourtHandleRetryChoice:
	ld a, $05 ; $474e
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $4750
	farcall FarPtr_RunDialogueYesNoPrompt ; $4753
	farcall FarPtr_ScriptCloseDialogueWindow ; $4756
	push af ; $4759
	ld a, $05 ; $475a
	farcall FarPtr_WaitScriptFrames ; $475c
	pop af ; $475f
	and a, a ; $4760
	jr z, MachineCourtRestartLevel ; $4761
	ld hl, $20dc ; $4763
	farcall FarPtr_InitDialogueTextCursor ; $4766
	ld a, $05 ; $4769
	farcall FarPtr_ScriptShowSpeakerDialogue ; $476b
	ld a, $00 ; $476e
	ld bc, $3300 ; $4770
	ld de, $3600 ; $4773
	farcall FarPtr_ScriptSetActorMoveTarget ; $4776
	ld a, $00 ; $4779
	farcall FarPtr_ScriptWaitActorMoveDone ; $477b
	xor a, a ; $477e
	ld bc, $2f00 ; $477f
	ld de, $2d00 ; $4782
	farcall FarPtr_MovePlayerToPosition ; $4785
	ld a, $00 ; $4788
	ld bc, $3300 ; $478a
	ld de, $2b00 ; $478d
	farcall FarPtr_ScriptSetActorMoveTarget ; $4790
	ld a, $00 ; $4793
	farcall FarPtr_ScriptWaitActorMoveDone ; $4795
	ld a, $00 ; $4798
	ld bc, $2b00 ; $479a
	ld de, $2b00 ; $479d
	farcall FarPtr_ScriptSetActorMoveTarget ; $47a0
	ld a, $00 ; $47a3
	farcall FarPtr_ScriptWaitActorMoveDone ; $47a5
	ld a, $05 ; $47a8
	ld bc, $2d00 ; $47aa
	ld de, $2b00 ; $47ad
	farcall FarPtr_ScriptSetActorMoveTarget ; $47b0
	ld a, $05 ; $47b3
	farcall FarPtr_ScriptWaitActorMoveDone ; $47b5
	ld a, $05 ; $47b8
	ld b, $80 ; $47ba
	farcall FarPtr_SetActorFacing ; $47bc
	ld a, $02 ; $47bf
	farcall FarPtr_GetActorStateAddr ; $47c1
	ld c, l ; $47c4
	ld b, h ; $47c5
	ld de, $d000 ; $47c6
	farcall FarPtr_04_20 ; $47c9
	ret ; $47cc
MachineCourtRestartLevel:
	ld a, [$c8f7] ; $47cd
	cp a, $1a ; $47d0
	jr z, Label_14_47ef ; $47d2
	sub a, $12 ; $47d4
	call TestMachineLevelClearedFlag ; $47d6
	jr z, Label_14_47ef ; $47d9
	ld a, $12 ; $47db
	ld [wStoryModeCurrentLocation], a ; $47dd
	ld a, $07 ; $47e0
	ld [$c295], a ; $47e2
	ld a, $ff ; $47e5
	ld [$c294], a ; $47e7
	ld [$c2a1], a ; $47ea
	jr Label_14_4801 ; $47ed
Label_14_47ef:
	ld a, $12 ; $47ef
	ld [wStoryModeCurrentLocation], a ; $47f1
	ld a, $05 ; $47f4
	ld [$c295], a ; $47f6
	ld a, $ff ; $47f9
	ld [$c294], a ; $47fb
	ld [$c2a1], a ; $47fe
Label_14_4801:
	ld a, [$c8f7] ; $4801
	farcall FarPtr_RunTrainingDrillByID ; $4804
	ret ; $4807
	INCBIN "data/bank_014/d_4808.bin" ; $4808, 11 bytes
	ldh a, [hWramBank] ; $4813
	push af ; $4815
	wram_bank $07 ; $4816
	ld a, $01 ; $481c
	farcall FarPtr_ReadMinigameRecord ; $481e
	ld de, $0050 ; $4821
	ld hl, $de00 ; $4824
	ld a, e ; $4827
	ld [hl+], a ; $4828
	ld [hl], d ; $4829
	pop af ; $482a
	wram_bank ; $482b
	ld a, $12 ; $482f
	ld [wStoryModeCurrentLocation], a ; $4831
	ld a, $01 ; $4834
	ld [$c295], a ; $4836
	ld a, $ff ; $4839
	ld [$c294], a ; $483b
	ld [$c2a1], a ; $483e
	ret ; $4841
MachineExpertResultScene:
	test_flag $1b, 4 ; $4842
	jr z, Label_14_484f ; $4845
	ld a, [wPointWinLoseFlag] ; $4847
	cp a, $01 ; $484a
	jp z, MachineExpertCounterMaxScene ; $484c
Label_14_484f:
	ld bc, $0001 ; $484f
	ldh a, [hWramBank] ; $4852
	push af ; $4854
	wram_bank $07 ; $4855
	ld hl, wMinigamesCurrentScore ; $485b
	ld a, [hl+] ; $485e
	ld d, [hl] ; $485f
	ld e, a ; $4860
	pop af ; $4861
	wram_bank ; $4862
	ld l, c ; $4866
	ld h, b ; $4867
	ld a, l ; $4868
	sub a, e ; $4869
	ld l, a ; $486a
	ld a, h ; $486b
	sbc a, d ; $486c
	ld h, a ; $486d
	jp nc, MachineExpertRetryPrompt ; $486e
	ld bc, $270f ; $4871
	ldh a, [hWramBank] ; $4874
	push af ; $4876
	wram_bank $07 ; $4877
	ld a, $01 ; $487d
	farcall FarPtr_ReadMinigameRecord ; $487f
	ld hl, $de00 ; $4882
	ld a, [hl+] ; $4885
	ld d, [hl] ; $4886
	ld e, a ; $4887
	pop af ; $4888
	wram_bank ; $4889
	ld l, c ; $488d
	ld h, b ; $488e
	ld a, l ; $488f
	sub a, e ; $4890
	ld l, a ; $4891
	ld a, h ; $4892
	sbc a, d ; $4893
	ld h, a ; $4894
	jp z, MachineExpertRetryPrompt ; $4895
	ld hl, wMinigamesCurrentScore ; $4898
	ld a, [hl+] ; $489b
	ld b, [hl] ; $489c
	ld c, a ; $489d
	ldh a, [hWramBank] ; $489e
	push af ; $48a0
	wram_bank $07 ; $48a1
	ld hl, $de00 ; $48a7
	ld a, [hl+] ; $48aa
	ld d, [hl] ; $48ab
	ld e, a ; $48ac
	pop af ; $48ad
	wram_bank ; $48ae
	ld l, c ; $48b2
	ld h, b ; $48b3
	inc de ; $48b4
	ld a, l ; $48b5
	sub a, e ; $48b6
	ld l, a ; $48b7
	ld a, h ; $48b8
	sbc a, d ; $48b9
	ld h, a ; $48ba
	jp nc, MachineExpertNewRecordScene ; $48bb
MachineExpertRetryPrompt:
	ld hl, $20dd ; $48be
	farcall FarPtr_InitDialogueTextCursor ; $48c1
	ld hl, wMinigamesCurrentScore ; $48c4
	ld a, [hl+] ; $48c7
	ld h, [hl] ; $48c8
	ld l, a ; $48c9
	farcall FarPtr_PushTextArgNumber ; $48ca
	jp MachineCourtHandleRetryChoice ; $48cd
	ret ; $48d0
MachineExpertNewRecordScene:
	call SaveMachineExpertRecord ; $48d1
	ld hl, $20ce ; $48d4
	farcall FarPtr_InitDialogueTextCursor ; $48d7
	ld hl, wMinigamesCurrentScore ; $48da
	ld a, [hl+] ; $48dd
	ld h, [hl] ; $48de
	ld l, a ; $48df
	farcall FarPtr_PushTextArgNumber ; $48e0
	call MachineCourtWalkToAttendantCutscene ; $48e3
	ld a, $05 ; $48e6
	farcall FarPtr_ScriptShowSpeakerDialogue ; $48e8
	ld a, $02 ; $48eb
	farcall FarPtr_GetActorStateAddr ; $48ed
	ld c, l ; $48f0
	ld b, h ; $48f1
	ld de, $d000 ; $48f2
	farcall FarPtr_04_20 ; $48f5
	ret ; $48f8
MachineExpertCounterMaxScene:
	ldh a, [hWramBank] ; $48f9
	push af ; $48fb
	wram_bank $07 ; $48fc
	ld a, $01 ; $4902
	farcall FarPtr_ReadMinigameRecord ; $4904
	ld hl, $de00 ; $4907
	ld a, [hl+] ; $490a
	ld h, [hl] ; $490b
	ld l, a ; $490c
	pop af ; $490d
	wram_bank ; $490e
	ld de, $270f ; $4912
	ld a, l ; $4915
	sub a, e ; $4916
	ld l, a ; $4917
	ld a, h ; $4918
	sbc a, d ; $4919
	ld h, a ; $491a
	jp z, MachineExpertRetryPrompt ; $491b
	call SaveMachineExpertRecord ; $491e
	ld hl, $20d4 ; $4921
	farcall FarPtr_InitDialogueTextCursor ; $4924
	ld hl, wMinigamesCurrentScore ; $4927
	ld a, [hl+] ; $492a
	ld h, [hl] ; $492b
	ld l, a ; $492c
	farcall FarPtr_PushTextArgNumber ; $492d
	ld hl, $20d4 ; $4930
	farcall FarPtr_InitDialogueTextCursor ; $4933
	call MachineCourtWalkToAttendantCutscene ; $4936
	ld a, $05 ; $4939
	farcall FarPtr_ScriptShowSpeakerDialogue ; $493b
	ld a, $05 ; $493e
	farcall FarPtr_ScriptShowSpeakerDialogue ; $4940
	ld a, $02 ; $4943
	farcall FarPtr_GetActorStateAddr ; $4945
	ld c, l ; $4948
	ld b, h ; $4949
	ld de, $d000 ; $494a
	farcall FarPtr_04_20 ; $494d
	ret ; $4950
	ld hl, wMinigamesCurrentScore ; $4951
	ld a, [hl+] ; $4954
	ld b, [hl] ; $4955
	ld c, a ; $4956
	ldh a, [hWramBank] ; $4957
	push af ; $4959
	wram_bank $07 ; $495a
	ld hl, $de00 ; $4960
	ld a, [hl+] ; $4963
	ld d, [hl] ; $4964
	ld e, a ; $4965
	pop af ; $4966
	wram_bank ; $4967
	ld l, c ; $496b
	ld h, b ; $496c
	ld a, l ; $496d
	sub a, e ; $496e
	ld l, a ; $496f
	ld a, h ; $4970
	sbc a, d ; $4971
	ld h, a ; $4972
	ret ; $4973
SaveMachineExpertRecord:
	ldh a, [hWramBank] ; $4974
	push af ; $4976
	wram_bank $07 ; $4977
	ld hl, wMinigamesCurrentScore ; $497d
	ld a, [hl+] ; $4980
	ld d, [hl] ; $4981
	ld e, a ; $4982
	ld hl, $de00 ; $4983
	ld a, e ; $4986
	ld [hl+], a ; $4987
	ld [hl], d ; $4988
	ld a, $01 ; $4989
	farcall FarPtr_UpdateMinigameRecord ; $498b
	pop af ; $498e
	wram_bank ; $498f
	call ComputeMachineCourtProgress ; $4993
	ret ; $4996
MachineCourtWalkToAttendantCutscene:
	ld a, $00 ; $4997
	ld bc, $3300 ; $4999
	ld de, $3600 ; $499c
	farcall FarPtr_ScriptSetActorMoveTarget ; $499f
	ld a, $00 ; $49a2
	farcall FarPtr_ScriptWaitActorMoveDone ; $49a4
	xor a, a ; $49a7
	ld bc, $2f00 ; $49a8
	ld de, $2d00 ; $49ab
	farcall FarPtr_MovePlayerToPosition ; $49ae
	ld a, $00 ; $49b1
	ld bc, $3300 ; $49b3
	ld de, $2b00 ; $49b6
	farcall FarPtr_ScriptSetActorMoveTarget ; $49b9
	ld a, $00 ; $49bc
	farcall FarPtr_ScriptWaitActorMoveDone ; $49be
	ld a, $00 ; $49c1
	ld bc, $2a80 ; $49c3
	ld de, $2b00 ; $49c6
	farcall FarPtr_ScriptSetActorMoveTarget ; $49c9
	ld a, $00 ; $49cc
	farcall FarPtr_ScriptWaitActorMoveDone ; $49ce
	ld a, $05 ; $49d1
	ld bc, $2d00 ; $49d3
	ld de, $2b00 ; $49d6
	farcall FarPtr_ScriptSetActorMoveTarget ; $49d9
	ld a, $05 ; $49dc
	farcall FarPtr_ScriptWaitActorMoveDone ; $49de
	ld a, $00 ; $49e1
	ld b, $00 ; $49e3
	farcall FarPtr_SetActorFacing ; $49e5
	ld a, $00 ; $49e8
	ld bc, $2b00 ; $49ea
	ld de, $2b00 ; $49ed
	farcall FarPtr_ScriptSetActorMoveTarget ; $49f0
	ld a, $00 ; $49f3
	farcall FarPtr_ScriptWaitActorMoveDone ; $49f5
	ld a, $05 ; $49f8
	ld b, $80 ; $49fa
	farcall FarPtr_SetActorFacing ; $49fc
	ret ; $49ff
Label_14_4a00:
	test_flag $0f, 5 ; $4a00
	jr z, Label_14_4a38 ; $4a03
	set_flag $1c, 1 ; $4a05
	ld a, $05 ; $4a08
	ld bc, $2d00 ; $4a0a
	ld de, $2900 ; $4a0d
	farcall FarPtr_ScriptSetActorPosition ; $4a10
	ld a, $05 ; $4a13
	ld b, $40 ; $4a15
	farcall FarPtr_SetActorFacing ; $4a17
	ld a, $02 ; $4a1a
	farcall FarPtr_0a_1c ; $4a1c
	push af ; $4a1f
	ld a, $01 ; $4a20
	farcall FarPtr_WaitScriptFrames ; $4a22
	pop af ; $4a25
	ld a, $02 ; $4a26
	ld bc, $2900 ; $4a28
	ld de, $2b00 ; $4a2b
	farcall FarPtr_ScriptSetActorPosition ; $4a2e
	ld a, $02 ; $4a31
	ld b, $00 ; $4a33
	farcall FarPtr_SetActorFacing ; $4a35
Label_14_4a38:
	ret ; $4a38
	; $4a39, 14 bytes (records:2)
	dw $4b3f ; record 0
	dw $4b50 ; record 1
	dw $4a47 ; record 2
	dw $4df9 ; record 3
	dw $4e42 ; record 4
	dw $4e4c ; record 5
	dw $4e56 ; record 6
	; $4a47, 248 bytes (bytes:14)
	db $00, $00, $b1, $78, $00, $1d, $00, $15, $00, $00, $25, $01, $00, $00 ; 0x00
	db $00, $00, $b1, $78, $00, $19, $00, $18, $40, $00, $25, $01, $00, $00 ; 0x0e
	db $00, $00, $b1, $78, $00, $1b, $00, $1c, $80, $00, $30, $01, $05, $00 ; 0x1c
	db $00, $00, $b1, $78, $00, $1b, $00, $1a, $80, $00, $39, $01, $05, $00 ; 0x2a
	db $00, $00, $bb, $78, $00, $07, $00, $31, $00, $00, $39, $01, $04, $00 ; 0x38
	db $00, $00, $b1, $78, $00, $09, $00, $23, $00, $00, $39, $01, $04, $00 ; 0x46
	db $00, $00, $b1, $78, $00, $0b, $00, $23, $80, $00, $3a, $01, $00, $00 ; 0x54
	db $00, $00, $b1, $78, $00, $0b, $00, $2b, $00, $00, $23, $01, $00, $00 ; 0x62
	db $00, $00, $b1, $78, $00, $0f, $00, $2b, $80, $00, $24, $01, $00, $00 ; 0x70
	db $00, $00, $b1, $78, $00, $fd, $00, $01, $40, $00, $4c, $01, $00, $00 ; 0x7e
	db $00, $00, $b1, $78, $00, $fd, $00, $01, $40, $00, $53, $01, $00, $00 ; 0x8c
	db $00, $00, $b1, $78, $00, $fd, $00, $01, $40, $00, $4d, $01, $00, $00 ; 0x9a
	db $00, $00, $b1, $78, $00, $1b, $00, $0c, $80, $00, $39, $01, $00, $00 ; 0xa8
	db $00, $00, $b1, $78, $00, $19, $00, $0e, $80, $00, $39, $01, $06, $00 ; 0xb6
	db $00, $00, $b1, $78, $00, $1b, $00, $10, $80, $00, $3a, $01, $03, $00 ; 0xc4
	db $00, $00, $b1, $78, $00, $05, $00, $1b, $00, $00, $33, $01, $00, $00 ; 0xd2
	db $00, $00, $b1, $78, $00, $05, $00, $1d, $00, $00, $3a, $01, $04, $00 ; 0xe0
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $ff ; 0xee
	; $4b3f, 17 bytes (bytes:16)
	db $01, $80, $00, $25, $00, $15, $00, $00, $02, $80, $00, $25, $00, $25, $00, $00 ; 0x00
	db $ff ; 0x10
	; $4b50, 17 bytes (records:8)
; 2 records x 8 bytes
	dw $ff01, $0000, $78d9, $0319 ; record 0
	dw $ff02, $0000, $78d9, $0215 ; record 1
	db $ff
	ld hl, $2491 ; $4b61
	farcall FarPtr_InitDialogueTextCursor ; $4b64
	ld a, $03 ; $4b67
	farcall FarPtr_ScriptShowSpeakerDialogue ; $4b69
	ret ; $4b6c
	ld a, [$c2b0] ; $4b6d
	add a, a ; $4b70
	add a, $84 ; $4b71
	ld l, a ; $4b73
	adc a, $4b ; $4b74
	sub a, l ; $4b76
	ld h, a ; $4b77
	ld a, [hl+] ; $4b78
	ld h, [hl] ; $4b79
	ld l, a ; $4b7a
	farcall FarPtr_InitDialogueTextCursor ; $4b7b
	ld a, $04 ; $4b7e
	farcall FarPtr_ScriptShowSpeakerDialogue ; $4b80
	ret ; $4b83
	; $4b84, 14 bytes (records:2)
	dw $2492 ; record 0
	dw $2492 ; record 1
	dw $2492 ; record 2
	dw $2497 ; record 3
	dw $2492 ; record 4
	dw $2492 ; record 5
	dw $2497 ; record 6
	ld a, [$c2b0] ; $4b92
	add a, a ; $4b95
	add a, $a9 ; $4b96
	ld l, a ; $4b98
	adc a, $4b ; $4b99
	sub a, l ; $4b9b
	ld h, a ; $4b9c
	ld a, [hl+] ; $4b9d
	ld h, [hl] ; $4b9e
	ld l, a ; $4b9f
	farcall FarPtr_InitDialogueTextCursor ; $4ba0
	ld a, $05 ; $4ba3
	farcall FarPtr_ScriptShowSpeakerDialogue ; $4ba5
	ret ; $4ba8
	; $4ba9, 14 bytes (records:2)
	dw $2493 ; record 0
	dw $2493 ; record 1
	dw $2495 ; record 2
	dw $2498 ; record 3
	dw $2499 ; record 4
	dw $249b ; record 5
	dw $249d ; record 6
	ld a, [$c2b0] ; $4bb7
	add a, a ; $4bba
	add a, $ce ; $4bbb
	ld l, a ; $4bbd
	adc a, $4b ; $4bbe
	sub a, l ; $4bc0
	ld h, a ; $4bc1
	ld a, [hl+] ; $4bc2
	ld h, [hl] ; $4bc3
	ld l, a ; $4bc4
	farcall FarPtr_InitDialogueTextCursor ; $4bc5
	ld a, $06 ; $4bc8
	farcall FarPtr_ScriptShowSpeakerDialogue ; $4bca
	ret ; $4bcd
	; $4bce, 14 bytes (records:2)
	dw $2494 ; record 0
	dw $2494 ; record 1
	dw $2496 ; record 2
	dw $2496 ; record 3
	dw $249a ; record 4
	dw $249c ; record 5
	dw $249e ; record 6
	test_flag $05, 7 ; $4bdc
	jr z, Label_14_4bec ; $4bdf
	test_flag $0f, 1 ; $4be1
	jp nz, Court2SpectatorsRepeatChat ; $4be4
	set_flag $0f, 1 ; $4be7
	jr Label_14_4bf5 ; $4bea
Label_14_4bec:
	test_flag $0f, 0 ; $4bec
	jp nz, Court2SpectatorsRepeatChat ; $4bef
	set_flag $0f, 0 ; $4bf2
Label_14_4bf5:
	ld a, [$c2b0] ; $4bf5
	add a, a ; $4bf8
	add a, $5f ; $4bf9
	ld l, a ; $4bfb
	adc a, $4d ; $4bfc
	sub a, l ; $4bfe
	ld h, a ; $4bff
	ld a, [hl+] ; $4c00
	ld h, [hl] ; $4c01
	ld l, a ; $4c02
	farcall FarPtr_InitDialogueTextCursor ; $4c03
	ld a, $08 ; $4c06
	ld d, $04 ; $4c08
	farcall FarPtr_ScriptSetActorAnimation ; $4c0a
	ld a, $08 ; $4c0d
	farcall FarPtr_ScriptWaitActorIdle ; $4c0f
	ld a, $08 ; $4c12
	farcall FarPtr_ScriptShowSpeakerDialogue ; $4c14
	ld a, $0c ; $4c17
	ld bc, $0c80 ; $4c19
	ld de, $2180 ; $4c1c
	farcall FarPtr_ScriptSetActorPosition ; $4c1f
	sound $97 ; $4c22
	push af ; $4c24
	ld a, $14 ; $4c25
	farcall FarPtr_WaitScriptFrames ; $4c27
	pop af ; $4c2a
	ld a, $09 ; $4c2b
	farcall FarPtr_ScriptShowSpeakerDialogue ; $4c2d
	ld a, $0c ; $4c30
	ld bc, $3f00 ; $4c32
	ld de, $3f00 ; $4c35
	farcall FarPtr_ScriptSetActorPosition ; $4c38
	ld a, $08 ; $4c3b
	ld d, $03 ; $4c3d
	farcall FarPtr_ScriptSetActorAnimation ; $4c3f
	ld a, $08 ; $4c42
	farcall FarPtr_ScriptWaitActorIdle ; $4c44
	ld a, $08 ; $4c47
	farcall FarPtr_ScriptShowSpeakerDialogue ; $4c49
	ld a, $09 ; $4c4c
	ld d, $02 ; $4c4e
	farcall FarPtr_ScriptSetActorAnimation ; $4c50
	ld a, $09 ; $4c53
	farcall FarPtr_ScriptWaitActorIdle ; $4c55
	ld a, $09 ; $4c58
	farcall FarPtr_ScriptShowSpeakerDialogue ; $4c5a
	ld a, $00 ; $4c5d
	ld b, a ; $4c5f
	ld a, $08 ; $4c60
	farcall FarPtr_FaceActorTowardActor ; $4c62
	push af ; $4c65
	ld a, $14 ; $4c66
	farcall FarPtr_WaitScriptFrames ; $4c68
	pop af ; $4c6b
	ld a, $0c ; $4c6c
	ld bc, $0a80 ; $4c6e
	ld de, $2180 ; $4c71
	farcall FarPtr_ScriptSetActorPosition ; $4c74
	sound $97 ; $4c77
	ld a, $08 ; $4c79
	ld d, $02 ; $4c7b
	farcall FarPtr_ScriptSetActorAnimation ; $4c7d
	ld a, $08 ; $4c80
	farcall FarPtr_ScriptWaitActorIdle ; $4c82
	ld a, $0c ; $4c85
	ld bc, $3f00 ; $4c87
	ld de, $3f00 ; $4c8a
	farcall FarPtr_ScriptSetActorPosition ; $4c8d
	push af ; $4c90
	ld a, $0a ; $4c91
	farcall FarPtr_WaitScriptFrames ; $4c93
	pop af ; $4c96
	ld a, $0d ; $4c97
	ld bc, $0a80 ; $4c99
	ld de, $2180 ; $4c9c
	farcall FarPtr_ScriptSetActorPosition ; $4c9f
	sound $96 ; $4ca2
	push af ; $4ca4
	ld a, $14 ; $4ca5
	farcall FarPtr_WaitScriptFrames ; $4ca7
	pop af ; $4caa
	ld a, $08 ; $4cab
	farcall FarPtr_ScriptShowSpeakerDialogue ; $4cad
	ld a, $0d ; $4cb0
	ld bc, $3f00 ; $4cb2
	ld de, $3f00 ; $4cb5
	farcall FarPtr_ScriptSetActorPosition ; $4cb8
	ld a, $0e ; $4cbb
	ld bc, $0c80 ; $4cbd
	ld de, $2180 ; $4cc0
	farcall FarPtr_ScriptSetActorPosition ; $4cc3
	sound $98 ; $4cc6
	push af ; $4cc8
	ld a, $3c ; $4cc9
	farcall FarPtr_WaitScriptFrames ; $4ccb
	pop af ; $4cce
	ld a, $0e ; $4ccf
	ld bc, $3f00 ; $4cd1
	ld de, $3f00 ; $4cd4
	farcall FarPtr_ScriptSetActorPosition ; $4cd7
	ld a, $00 ; $4cda
	ld b, a ; $4cdc
	ld a, $09 ; $4cdd
	farcall FarPtr_FaceActorTowardActor ; $4cdf
	push af ; $4ce2
	ld a, $14 ; $4ce3
	farcall FarPtr_WaitScriptFrames ; $4ce5
	pop af ; $4ce8
	ld a, $0c ; $4ce9
	ld bc, $0c80 ; $4ceb
	ld de, $2180 ; $4cee
	farcall FarPtr_ScriptSetActorPosition ; $4cf1
	sound $97 ; $4cf4
	ld a, $09 ; $4cf6
	ld d, $02 ; $4cf8
	farcall FarPtr_ScriptSetActorAnimation ; $4cfa
	ld a, $09 ; $4cfd
	farcall FarPtr_ScriptWaitActorIdle ; $4cff
	ld a, $0c ; $4d02
	ld bc, $3f00 ; $4d04
	ld de, $3f00 ; $4d07
	farcall FarPtr_ScriptSetActorPosition ; $4d0a
	push af ; $4d0d
	ld a, $0a ; $4d0e
	farcall FarPtr_WaitScriptFrames ; $4d10
	pop af ; $4d13
	ld a, $0d ; $4d14
	ld bc, $0c80 ; $4d16
	ld de, $2180 ; $4d19
	farcall FarPtr_ScriptSetActorPosition ; $4d1c
	sound $96 ; $4d1f
	push af ; $4d21
	ld a, $14 ; $4d22
	farcall FarPtr_WaitScriptFrames ; $4d24
	pop af ; $4d27
	ld a, $09 ; $4d28
	farcall FarPtr_ScriptShowSpeakerDialogue ; $4d2a
	ld a, $0d ; $4d2d
	ld bc, $3f00 ; $4d2f
	ld de, $3f00 ; $4d32
	farcall FarPtr_ScriptSetActorPosition ; $4d35
	ld a, $08 ; $4d38
	ld d, $03 ; $4d3a
	farcall FarPtr_ScriptSetActorAnimation ; $4d3c
	ld a, $09 ; $4d3f
	ld d, $03 ; $4d41
	farcall FarPtr_ScriptSetActorAnimation ; $4d43
	ld a, $09 ; $4d46
	farcall FarPtr_ScriptWaitActorIdle ; $4d48
	ld a, $08 ; $4d4b
	ld d, $03 ; $4d4d
	farcall FarPtr_ScriptSetActorAnimation ; $4d4f
	ld a, $09 ; $4d52
	ld d, $03 ; $4d54
	farcall FarPtr_ScriptSetActorAnimation ; $4d56
	ld a, $09 ; $4d59
	farcall FarPtr_ScriptWaitActorIdle ; $4d5b
	ret ; $4d5e
	; $4d5f, 14 bytes (records:2)
	dw $246b ; record 0
	dw $246b ; record 1
	dw $246b ; record 2
	dw $2472 ; record 3
	dw $2478 ; record 4
	dw $2478 ; record 5
	dw $247e ; record 6
Court2SpectatorsRepeatChat:
	ld a, $08 ; $4d6d
	ld d, $02 ; $4d6f
	farcall FarPtr_ScriptSetActorAnimation ; $4d71
	ld a, $08 ; $4d74
	farcall FarPtr_ScriptWaitActorIdle ; $4d76
	ld a, $00 ; $4d79
	ld b, a ; $4d7b
	ld a, $08 ; $4d7c
	farcall FarPtr_FaceActorTowardActor ; $4d7e
	ld hl, $246f ; $4d81
	farcall FarPtr_InitDialogueTextCursor ; $4d84
	ld a, $08 ; $4d87
	farcall FarPtr_ScriptShowSpeakerDialogue ; $4d89
	ld a, $09 ; $4d8c
	ld d, $02 ; $4d8e
	farcall FarPtr_ScriptSetActorAnimation ; $4d90
	ld a, $09 ; $4d93
	farcall FarPtr_ScriptWaitActorIdle ; $4d95
	ld a, $00 ; $4d98
	ld b, a ; $4d9a
	ld a, $09 ; $4d9b
	farcall FarPtr_FaceActorTowardActor ; $4d9d
	ld a, $09 ; $4da0
	farcall FarPtr_ScriptShowSpeakerDialogue ; $4da2
	ld a, $08 ; $4da5
	ld d, $03 ; $4da7
	farcall FarPtr_ScriptSetActorAnimation ; $4da9
	ld a, $09 ; $4dac
	ld d, $03 ; $4dae
	farcall FarPtr_ScriptSetActorAnimation ; $4db0
	ld a, $09 ; $4db3
	farcall FarPtr_ScriptWaitActorIdle ; $4db5
	ld a, $08 ; $4db8
	ld d, $03 ; $4dba
	farcall FarPtr_ScriptSetActorAnimation ; $4dbc
	ld a, $09 ; $4dbf
	ld d, $03 ; $4dc1
	farcall FarPtr_ScriptSetActorAnimation ; $4dc3
	ld a, $09 ; $4dc6
	farcall FarPtr_ScriptWaitActorIdle ; $4dc8
	ret ; $4dcb
	ld hl, $246a ; $4dcc
	farcall FarPtr_InitDialogueTextCursor ; $4dcf
	test_flag $05, 7 ; $4dd2
	jr nz, Label_14_4de6 ; $4dd5
	ld a, [$c2b0] ; $4dd7
	cp a, $03 ; $4dda
	jr nz, Label_14_4df3 ; $4ddc
	ld hl, $2471 ; $4dde
	farcall FarPtr_InitDialogueTextCursor ; $4de1
	jr Label_14_4df3 ; $4de4
Label_14_4de6:
	ld a, [$c2b0] ; $4de6
	cp a, $06 ; $4de9
	jr nz, Label_14_4df3 ; $4deb
	ld hl, $2471 ; $4ded
	farcall FarPtr_InitDialogueTextCursor ; $4df0
Label_14_4df3:
	ld a, $0a ; $4df3
	farcall FarPtr_ScriptShowSpeakerDialogue ; $4df5
	ret ; $4df8
	; $4df9, 73 bytes (records:8)
; 9 records x 8 bytes
	dw $ff03, $0000, $4b61, $0003 ; record 0
	dw $ff04, $0000, $4b6d, $0003 ; record 1
	dw $ff05, $0000, $4b92, $0003 ; record 2
	dw $ff06, $0000, $4bb7, $0013 ; record 3
	dw $ff07, $0000, $2468, $0013 ; record 4
	dw $ff08, $0000, $4bdc, $0000 ; record 5
	dw $ff09, $0000, $4bdc, $0000 ; record 6
	dw $ff0a, $0000, $4dcc, $0003 ; record 7
	dw $ff0b, $0000, $2469, $0003 ; record 8
	db $ff
	; $4e42, 9 bytes (records:8)
; 1 records x 8 bytes
	dw $ff01, $0000, $4e4b, $0000 ; record 0
	db $ff
	ret ; $4e4b
	; $4e4c, 9 bytes (records:8)
; 1 records x 8 bytes
	dw $ff01, $0000, $4e55, $0000 ; record 0
	db $ff
	ret ; $4e55
	call InitCourt2SceneVariant ; $4e56
	call Func_14_51ea ; $4e59
	call Court2EntryWalkIn ; $4e5c
	ret ; $4e5f
InitCourt2SceneVariant:
	ld a, $00 ; $4e60
	ld [$c2b0], a ; $4e62
	test_flag $05, 7 ; $4e65
	jr nz, Label_14_4e92 ; $4e68
	test_flag $07, 5 ; $4e6a
	jr z, Label_14_4e7e ; $4e6d
	ldh a, [hRomBank] ; $4e6f
	ld hl, $4eb4 ; $4e71
	farcall FarPtr_0a_06 ; $4e74
	farcall FarPtr_0a_00 ; $4e77
	ld a, $03 ; $4e7a
	jr Label_14_4e8e ; $4e7c
Label_14_4e7e:
	test_flag $07, 6 ; $4e7e
	jr z, Label_14_4e87 ; $4e81
	ld a, $02 ; $4e83
	jr Label_14_4e8e ; $4e85
Label_14_4e87:
	test_flag $07, 7 ; $4e87
	jr z, Label_14_4e91 ; $4e8a
	ld a, $01 ; $4e8c
Label_14_4e8e:
	ld [$c2b0], a ; $4e8e
Label_14_4e91:
	ret ; $4e91
Label_14_4e92:
	test_flag $06, 6 ; $4e92
	jr z, Label_14_4ea6 ; $4e95
	ldh a, [hRomBank] ; $4e97
	ld hl, $4eb4 ; $4e99
	farcall FarPtr_0a_06 ; $4e9c
	farcall FarPtr_0a_00 ; $4e9f
	ld a, $06 ; $4ea2
	jr Label_14_4e8e ; $4ea4
Label_14_4ea6:
	test_flag $06, 7 ; $4ea6
	jr z, Label_14_4eaf ; $4ea9
	ld a, $05 ; $4eab
	jr Label_14_4e8e ; $4ead
Label_14_4eaf:
	ld a, $04 ; $4eaf
	jr Label_14_4e8e ; $4eb1
	ret ; $4eb3
	; $4eb4, 70 bytes (bytes:14)
	db $00, $00, $b1, $78, $00, $1d, $00, $15, $00, $00, $25, $01, $00, $00 ; 0x00
	db $00, $00, $b1, $78, $00, $1b, $00, $23, $40, $00, $25, $01, $00, $00 ; 0x0e
	db $00, $00, $b1, $78, $00, $1f, $00, $2d, $80, $00, $30, $01, $05, $00 ; 0x1c
	db $00, $00, $bb, $78, $00, $1d, $00, $30, $c0, $00, $39, $01, $05, $00 ; 0x2a
	db $00, $00, $bb, $78, $00, $07, $00, $31, $00, $00, $39, $01, $04, $00 ; 0x38
	; $4efa, 108 bytes (bytes:14)
	db $00, $00, $b1, $78, $00, $09, $00, $23, $00, $00, $39, $01, $04, $00 ; 0x00
	db $00, $00, $b1, $78, $00, $0b, $00, $23, $80, $00, $3a, $01, $00, $00 ; 0x0e
	db $00, $00, $b1, $78, $00, $0b, $00, $2b, $00, $00, $23, $01, $00, $00 ; 0x1c
	db $00, $00, $b1, $78, $00, $0f, $00, $2b, $80, $00, $24, $01, $00, $00 ; 0x2a
	db $00, $00, $b1, $78, $00, $fd, $00, $01, $40, $00, $4c, $01, $00, $00 ; 0x38
	db $00, $00, $b1, $78, $00, $fd, $00, $01, $40, $00, $53, $01, $00, $00 ; 0x46
	db $00, $00, $b1, $78, $00, $fd, $00, $01, $40, $00, $4d, $01, $00, $00 ; 0x54
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $ff ; 0x62
Court2EntryWalkIn:
	ld a, [$c295] ; $4f66
	cp a, $ff ; $4f69
	jp z, Label_14_4fab ; $4f6b
	test_flag $05, 7 ; $4f6e
	jr z, Label_14_4f99 ; $4f71
	ld a, $02 ; $4f73
	ld bc, $00ff ; $4f75
	farcall FarPtr_0a_18 ; $4f78
	ld a, $02 ; $4f7b
	ld b, $00 ; $4f7d
	ld de, $0200 ; $4f7f
	farcall FarPtr_MoveActorByAngle ; $4f82
	ld a, $02 ; $4f85
	farcall FarPtr_ScriptWaitActorMoveDone ; $4f87
	ld a, $02 ; $4f8a
	ld b, $80 ; $4f8c
	farcall FarPtr_SetActorFacing ; $4f8e
	ld a, $02 ; $4f91
	ld bc, $0010 ; $4f93
	farcall FarPtr_0a_18 ; $4f96
Label_14_4f99:
	ld a, $00 ; $4f99
	ld bc, $0010 ; $4f9b
	farcall FarPtr_0a_18 ; $4f9e
	ld a, $00 ; $4fa1
	ld b, $80 ; $4fa3
	ld de, $0200 ; $4fa5
	farcall FarPtr_MoveActorByAngle ; $4fa8
Label_14_4fab:
	ret ; $4fab
	; $4fac, 14 bytes (records:2)
	dw $5042 ; record 0
	dw $5053 ; record 1
	dw $4fba ; record 2
	dw $50c6 ; record 3
	dw $50e7 ; record 4
	dw $50f1 ; record 5
	dw $50fb ; record 6
	; $4fba, 136 bytes (bytes:14)
	db $00, $00, $b1, $78, $00, $0b, $00, $15, $80, $00, $25, $01, $00, $00 ; 0x00
	db $00, $00, $b1, $78, $00, $11, $00, $23, $40, $00, $25, $01, $00, $00 ; 0x0e
	db $00, $00, $b1, $78, $00, $23, $00, $19, $80, $00, $39, $01, $03, $00 ; 0x1c
	db $00, $00, $b1, $78, $00, $23, $00, $1c, $80, $00, $32, $01, $03, $00 ; 0x2a
	db $00, $00, $b1, $78, $00, $0e, $00, $0d, $00, $00, $39, $01, $00, $00 ; 0x38
	db $00, $00, $b1, $78, $00, $0f, $00, $0f, $00, $00, $39, $01, $06, $00 ; 0x46
	db $00, $00, $b1, $78, $00, $0e, $00, $11, $00, $00, $3a, $01, $03, $00 ; 0x54
	db $00, $00, $b1, $78, $00, $23, $00, $0f, $80, $00, $33, $01, $00, $00 ; 0x62
	db $00, $00, $b1, $78, $00, $21, $00, $11, $80, $00, $3a, $01, $04, $00 ; 0x70
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $ff ; 0x7e
	; $5042, 17 bytes (bytes:16)
	db $01, $00, $00, $03, $00, $15, $00, $00, $02, $00, $00, $03, $00, $25, $00, $00 ; 0x00
	db $ff ; 0x10
	; $5053, 17 bytes (records:8)
; 2 records x 8 bytes
	dw $ff01, $0000, $78d9, $0419 ; record 0
	dw $ff02, $0000, $78d9, $0115 ; record 1
	db $ff
	ld hl, $2484 ; $5064
	farcall FarPtr_InitDialogueTextCursor ; $5067
	ld a, $03 ; $506a
	farcall FarPtr_ScriptShowSpeakerDialogue ; $506c
	ret ; $506f
	ld hl, $2485 ; $5070
	farcall FarPtr_InitDialogueTextCursor ; $5073
	ld a, $04 ; $5076
	farcall FarPtr_ScriptShowSpeakerDialogue ; $5078
	ret ; $507b
	ld a, [$c2b0] ; $507c
	add a, a ; $507f
	add a, $93 ; $5080
	ld l, a ; $5082
	adc a, $50 ; $5083
	sub a, l ; $5085
	ld h, a ; $5086
	ld a, [hl+] ; $5087
	ld h, [hl] ; $5088
	ld l, a ; $5089
	farcall FarPtr_InitDialogueTextCursor ; $508a
	ld a, $05 ; $508d
	farcall FarPtr_ScriptShowSpeakerDialogue ; $508f
	ret ; $5092
	; $5093, 14 bytes (records:2)
	dw $2486 ; record 0
	dw $2486 ; record 1
	dw $2489 ; record 2
	dw $248b ; record 3
	dw $2486 ; record 4
	dw $248d ; record 5
	dw $248f ; record 6
	ld a, [$c2b0] ; $50a1
	add a, a ; $50a4
	add a, $b8 ; $50a5
	ld l, a ; $50a7
	adc a, $50 ; $50a8
	sub a, l ; $50aa
	ld h, a ; $50ab
	ld a, [hl+] ; $50ac
	ld h, [hl] ; $50ad
	ld l, a ; $50ae
	farcall FarPtr_InitDialogueTextCursor ; $50af
	ld a, $06 ; $50b2
	farcall FarPtr_ScriptShowSpeakerDialogue ; $50b4
	ret ; $50b7
	; $50b8, 14 bytes (records:2)
	dw $2487 ; record 0
	dw $2488 ; record 1
	dw $248a ; record 2
	dw $248c ; record 3
	dw $2487 ; record 4
	dw $248e ; record 5
	dw $2490 ; record 6
	; $50c6, 33 bytes (records:8)
; 4 records x 8 bytes
	dw $ff03, $0000, $5064, $0003 ; record 0
	dw $ff04, $0000, $5070, $0003 ; record 1
	dw $ff05, $0000, $507c, $0003 ; record 2
	dw $ff06, $0000, $50a1, $0003 ; record 3
	db $ff
	; $50e7, 9 bytes (records:8)
; 1 records x 8 bytes
	dw $ff01, $0000, $50f0, $0000 ; record 0
	db $ff
	ret ; $50f0
	; $50f1, 9 bytes (records:8)
; 1 records x 8 bytes
	dw $ff01, $0000, $50fa, $0000 ; record 0
	db $ff
	ret ; $50fa
	call InitCourt1SceneVariant ; $50fb
	call Func_14_51ea ; $50fe
	call Court1EntryWalkIn ; $5101
	ret ; $5104
InitCourt1SceneVariant:
	ld a, $00 ; $5105
	ld [$c2b0], a ; $5107
	test_flag $05, 7 ; $510a
	jr nz, Label_14_513b ; $510d
	test_flag $07, 5 ; $510f
	jr z, Label_14_5125 ; $5112
	ld a, $03 ; $5114
	ld [$c2b0], a ; $5116
	ldh a, [hRomBank] ; $5119
	ld hl, $5162 ; $511b
	farcall FarPtr_0a_06 ; $511e
	farcall FarPtr_0a_00 ; $5121
	ret ; $5124
Label_14_5125:
	test_flag $07, 6 ; $5125
	jr z, Label_14_5130 ; $5128
	ld a, $02 ; $512a
	ld [$c2b0], a ; $512c
	ret ; $512f
Label_14_5130:
	test_flag $07, 7 ; $5130
	jr z, Label_14_513a ; $5133
	ld a, $01 ; $5135
	ld [$c2b0], a ; $5137
Label_14_513a:
	ret ; $513a
Label_14_513b:
	test_flag $06, 6 ; $513b
	jr z, Label_14_5151 ; $513e
	ld a, $06 ; $5140
	ld [$c2b0], a ; $5142
	ldh a, [hRomBank] ; $5145
	ld hl, $5162 ; $5147
	farcall FarPtr_0a_06 ; $514a
	farcall FarPtr_0a_00 ; $514d
	ret ; $5150
Label_14_5151:
	test_flag $06, 7 ; $5151
	jr z, Label_14_515c ; $5154
	ld a, $05 ; $5156
	ld [$c2b0], a ; $5158
	ret ; $515b
Label_14_515c:
	ld a, $04 ; $515c
	ld [$c2b0], a ; $515e
	ret ; $5161
	; $5162, 66 bytes (bytes:14)
	db $00, $00, $b1, $78, $00, $0b, $00, $15, $80, $00, $25, $01, $00, $00 ; 0x00
	db $00, $00, $b1, $78, $00, $11, $00, $23, $40, $00, $25, $01, $00, $00 ; 0x0e
	db $00, $00, $b1, $78, $00, $1b, $00, $23, $40, $00, $39, $01, $03, $00 ; 0x1c
	db $00, $00, $b1, $78, $00, $1d, $00, $23, $40, $00, $32, $01, $03, $00 ; 0x2a
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $ff ; 0x38
Court1EntryWalkIn:
	ld a, [$c295] ; $51a4
	cp a, $ff ; $51a7
	jp z, Label_14_51e9 ; $51a9
	test_flag $05, 7 ; $51ac
	jr z, Label_14_51d7 ; $51af
	ld a, $02 ; $51b1
	ld bc, $00ff ; $51b3
	farcall FarPtr_0a_18 ; $51b6
	ld a, $02 ; $51b9
	ld b, $80 ; $51bb
	ld de, $0200 ; $51bd
	farcall FarPtr_MoveActorByAngle ; $51c0
	ld a, $02 ; $51c3
	farcall FarPtr_ScriptWaitActorMoveDone ; $51c5
	ld a, $02 ; $51c8
	ld b, $00 ; $51ca
	farcall FarPtr_SetActorFacing ; $51cc
	ld a, $02 ; $51cf
	ld bc, $0010 ; $51d1
	farcall FarPtr_0a_18 ; $51d4
Label_14_51d7:
	ld a, $00 ; $51d7
	ld bc, $0010 ; $51d9
	farcall FarPtr_0a_18 ; $51dc
	ld a, $00 ; $51df
	ld b, $00 ; $51e1
	ld de, $0200 ; $51e3
	farcall FarPtr_MoveActorByAngle ; $51e6
Label_14_51e9:
	ret ; $51e9
Func_14_51ea:
	test_flag $05, 7 ; $51ea
	jp z, Label_14_5208 ; $51ed
	ld a, [$c94d] ; $51f0
	ld d, $58 ; $51f3
	add a, d ; $51f5
	ld d, a ; $51f6
	ld a, $02 ; $51f7
	farcall FarPtr_GetActorStateAddr ; $51f9
	ld c, l ; $51fc
	ld b, h ; $51fd
	farcall FarPtr_04_2c ; $51fe
	ld a, $02 ; $5201
	ld d, $01 ; $5203
	farcall FarPtr_ScriptSetActorAnimation ; $5205
Label_14_5208:
	ld a, [$c90d] ; $5208
	ld d, $56 ; $520b
	add a, d ; $520d
	ld d, a ; $520e
	ld a, $00 ; $520f
	farcall FarPtr_GetActorStateAddr ; $5211
	ld c, l ; $5214
	ld b, h ; $5215
	farcall FarPtr_04_2c ; $5216
	ld a, $00 ; $5219
	ld d, $01 ; $521b
	farcall FarPtr_ScriptSetActorAnimation ; $521d
	ret ; $5220
	; $5221, 14 bytes (records:2)
	dw $5271 ; record 0
	dw $52a2 ; record 1
	dw $522f ; record 2
	dw $52ac ; record 3
	dw $52b5 ; record 4
	dw $52b6 ; record 5
	dw $52b7 ; record 6
	; $522f, 66 bytes (bytes:14)
	db $00, $00, $b1, $78, $00, $06, $00, $27, $40, $00, $63, $01, $00, $00 ; 0x00
	db $00, $00, $b1, $78, $00, $06, $00, $27, $40, $00, $5c, $01, $00, $00 ; 0x0e
	db $00, $00, $b1, $78, $00, $06, $00, $27, $40, $00, $5b, $01, $00, $00 ; 0x1c
	db $00, $00, $b1, $78, $00, $06, $00, $27, $40, $00, $5a, $01, $00, $00 ; 0x2a
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $ff ; 0x38
	; $5271, 49 bytes (bytes:16)
	db $01, $40, $00, $0c, $00, $12, $00, $00, $02, $c0, $00, $06, $00, $27, $00, $00 ; 0x00
	db $08, $40, $00, $06, $00, $27, $00, $00, $0c, $40, $00, $06, $00, $27, $00, $00 ; 0x10
	db $0e, $40, $00, $0c, $00, $0b, $00, $00, $0f, $40, $00, $0c, $00, $12, $00, $00 ; 0x20
	db $ff ; 0x30
	; $52a2, 9 bytes (records:8)
; 1 records x 8 bytes
	dw $ff01, $0000, $78d9, $0608 ; record 0
	db $ff
	ret ; $52ab
	; $52ac, 11 bytes (records:8)
; 1 records x 8 bytes
	dw $ff03, $0000, $1430, $0000 ; record 0
	db $ff, $ff, $ff
	ld a, $03 ; $52b7
	ld bc, $3f00 ; $52b9
	ld de, $3f00 ; $52bc
	farcall FarPtr_ScriptSetActorPosition ; $52bf
	ld a, $04 ; $52c2
	ld bc, $3f00 ; $52c4
	ld de, $3f00 ; $52c7
	farcall FarPtr_ScriptSetActorPosition ; $52ca
	ld a, $05 ; $52cd
	ld bc, $3f00 ; $52cf
	ld de, $3f00 ; $52d2
	farcall FarPtr_ScriptSetActorPosition ; $52d5
	ld a, $06 ; $52d8
	ld bc, $3f00 ; $52da
	ld de, $3f00 ; $52dd
	farcall FarPtr_ScriptSetActorPosition ; $52e0
	ld a, [$c295] ; $52e3
	cp a, $02 ; $52e6
	jp z, Label_14_628b ; $52e8
	cp a, $08 ; $52eb
	jp z, Label_14_64e1 ; $52ed
	cp a, $0e ; $52f0
	jp z, Label_14_76c6 ; $52f2
	cp a, $0f ; $52f5
	jp z, Label_14_6f7b ; $52f7
	cp a, $0d ; $52fa
	jp z, Label_14_6f7b ; $52fc
	jp Label_14_5303 ; $52ff
	ret ; $5302
Label_14_5303:
	set_flag $09, 7 ; $5303
	call DisableLCDSafely ; $5306
	call LoadWaterSpriteObjGfx ; $5309
	call Func_14_60a1 ; $530c
	call EnableLCD ; $530f
	ld a, $50 ; $5312
	ld [$c2b0], a ; $5314
	ld a, $88 ; $5317
	ld [$c2b1], a ; $5319
	ld a, $01 ; $531c
	ld hl, $5e9c ; $531e
	call RegisterFrameTask ; $5321
	test_flag $05, 7 ; $5324
	jp z, Label_14_5352 ; $5327
	ld a, $02 ; $532a
	farcall FarPtr_0a_1c ; $532c
	ld a, $02 ; $532f
	ld bc, $3f00 ; $5331
	ld de, $3f00 ; $5334
	farcall FarPtr_ScriptSetActorPosition ; $5337
	ld a, [$c94d] ; $533a
	ld d, $58 ; $533d
	add a, d ; $533f
	ld d, a ; $5340
	ld a, $05 ; $5341
	farcall FarPtr_GetActorStateAddr ; $5343
	ld c, l ; $5346
	ld b, h ; $5347
	farcall FarPtr_04_2c ; $5348
	ld a, $05 ; $534b
	ld d, $01 ; $534d
	farcall FarPtr_ScriptSetActorAnimation ; $534f
Label_14_5352:
	ld a, [$c90d] ; $5352
	ld d, $56 ; $5355
	add a, d ; $5357
	ld d, a ; $5358
	ld a, $00 ; $5359
	farcall FarPtr_GetActorStateAddr ; $535b
	ld c, l ; $535e
	ld b, h ; $535f
	farcall FarPtr_04_2c ; $5360
	ld a, $00 ; $5363
	ld d, $01 ; $5365
	farcall FarPtr_ScriptSetActorAnimation ; $5367
	ld a, $00 ; $536a
	ld b, $00 ; $536c
	farcall FarPtr_SetActorActive ; $536e
	ld a, [$c295] ; $5371
	cp a, $0c ; $5374
	jr nz, Label_14_539c ; $5376
	ld a, $00 ; $5378
	ld bc, $0600 ; $537a
	ld de, $2700 ; $537d
	farcall FarPtr_ScriptSetActorPosition ; $5380
	xor a, a ; $5383
	ld [$c2d5], a ; $5384
	ld c, $04 ; $5387
	call BeginFadeIn ; $5389
	call WaitFadeEnd ; $538c
	ld a, $3b ; $538f
	ld [$c2b0], a ; $5391
	ld a, $a8 ; $5394
	ld [$c2b1], a ; $5396
	jp Label_14_5440 ; $5399
Label_14_539c:
	xor a, a ; $539c
	ld [$c2d5], a ; $539d
	ld c, $06 ; $53a0
	call BeginFadeIn ; $53a2
	call WaitFadeEnd ; $53a5
	sound $7a ; $53a8
	push af ; $53aa
	ld a, $3c ; $53ab
	farcall FarPtr_WaitScriptFrames ; $53ad
	pop af ; $53b0
	ld a, $00 ; $53b1
	ld bc, $0600 ; $53b3
	ld de, $2700 ; $53b6
	farcall FarPtr_ScriptSetActorPosition ; $53b9
	ld h, $08 ; $53bc
Label_14_53be:
	push af ; $53be
	ld a, $06 ; $53bf
	farcall FarPtr_WaitScriptFrames ; $53c1
	pop af ; $53c4
	call PlayWaterSpriteMoveSfx ; $53c5
	ld a, [$c2b1] ; $53c8
	inc a ; $53cb
	ld [$c2b1], a ; $53cc
	dec h ; $53cf
	jr nz, Label_14_53be ; $53d0
	ld h, $08 ; $53d2
Label_14_53d4:
	push af ; $53d4
	ld a, $05 ; $53d5
	farcall FarPtr_WaitScriptFrames ; $53d7
	pop af ; $53da
	call PlayWaterSpriteMoveSfx ; $53db
	ld a, h ; $53de
	and a, $01 ; $53df
	jr z, Label_14_53ea ; $53e1
	ld a, [$c2b0] ; $53e3
	dec a ; $53e6
	ld [$c2b0], a ; $53e7
Label_14_53ea:
	ld a, [$c2b1] ; $53ea
	inc a ; $53ed
	ld [$c2b1], a ; $53ee
	dec h ; $53f1
	jr nz, Label_14_53d4 ; $53f2
	ld h, $08 ; $53f4
Label_14_53f6:
	push af ; $53f6
	ld a, $04 ; $53f7
	farcall FarPtr_WaitScriptFrames ; $53f9
	pop af ; $53fc
	call PlayWaterSpriteMoveSfx ; $53fd
	ld a, [$c2b0] ; $5400
	dec a ; $5403
	ld [$c2b0], a ; $5404
	ld a, [$c2b1] ; $5407
	inc a ; $540a
	ld [$c2b1], a ; $540b
	dec h ; $540e
	jr nz, Label_14_53f6 ; $540f
	ld bc, $0012 ; $5411
	farcall FarPtr_0a_38 ; $5414
	ld a, $00 ; $5417
	ld b, $00 ; $5419
	farcall FarPtr_MovePlayerToActor ; $541b
	ld h, $1c ; $541e
Label_14_5420:
	push af ; $5420
	ld a, $03 ; $5421
	farcall FarPtr_WaitScriptFrames ; $5423
	pop af ; $5426
	call PlayWaterSpriteMoveSfx ; $5427
	ld a, h ; $542a
	and a, $01 ; $542b
	jr z, Label_14_5436 ; $542d
	ld a, [$c2b0] ; $542f
	dec a ; $5432
	ld [$c2b0], a ; $5433
Label_14_5436:
	ld a, [$c2b1] ; $5436
	inc a ; $5439
	ld [$c2b1], a ; $543a
	dec h ; $543d
	jr nz, Label_14_5420 ; $543e
Label_14_5440:
	ld h, $00 ; $5440
Label_14_5442:
	push af ; $5442
	ld a, $03 ; $5443
	farcall FarPtr_WaitScriptFrames ; $5445
	pop af ; $5448
	inc h ; $5449
	call PlayWaterSpriteMoveSfx ; $544a
	ld a, [$c2b1] ; $544d
	inc a ; $5450
	ld [$c2b1], a ; $5451
	and a, $03 ; $5454
	cp a, $03 ; $5456
	jr nz, Label_14_5461 ; $5458
	ld a, [$c2b0] ; $545a
	dec a ; $545d
	ld [$c2b0], a ; $545e
Label_14_5461:
	ld a, [$c2b0] ; $5461
	cp a, $20 ; $5464
	jr nz, Label_14_5442 ; $5466
	ld h, $08 ; $5468
Label_14_546a:
	push af ; $546a
	ld a, $04 ; $546b
	farcall FarPtr_WaitScriptFrames ; $546d
	pop af ; $5470
	call PlayWaterSpriteMoveSfx ; $5471
	ld a, [$c2b1] ; $5474
	inc a ; $5477
	ld [$c2b1], a ; $5478
	dec h ; $547b
	jr nz, Label_14_546a ; $547c
	sound $7b ; $547e
	ld h, $08 ; $5480
Label_14_5482:
	push af ; $5482
	ld a, $06 ; $5483
	farcall FarPtr_WaitScriptFrames ; $5485
	pop af ; $5488
	ld a, [$c2b1] ; $5489
	inc a ; $548c
	ld [$c2b1], a ; $548d
	dec h ; $5490
	jr nz, Label_14_5482 ; $5491
	sound $7d ; $5493
	ld h, $04 ; $5495
Label_14_5497:
	push af ; $5497
	ld a, $08 ; $5498
	farcall FarPtr_WaitScriptFrames ; $549a
	pop af ; $549d
	ld a, [$c2b1] ; $549e
	inc a ; $54a1
	ld [$c2b1], a ; $54a2
	dec h ; $54a5
	jr nz, Label_14_5497 ; $54a6
	ld a, [$c295] ; $54a8
	cp a, $0c ; $54ab
	jr z, Label_14_54df ; $54ad
	test_flag $05, 7 ; $54af
	jr z, Label_14_54bc ; $54b2
	test_flag $15, 7 ; $54b4
	jp z, Label_14_54df ; $54b7
	jr Label_14_54c1 ; $54ba
Label_14_54bc:
	test_flag $15, 6 ; $54bc
	jr z, Label_14_54df ; $54bf
Label_14_54c1:
	ld c, $04 ; $54c1
	call BeginFadeOut ; $54c3
	call WaitFadeEnd ; $54c6
	call ClearFrameTasks ; $54c9
	ld a, $15 ; $54cc
	ld [wStoryModeCurrentLocation], a ; $54ce
	ld a, $04 ; $54d1
	ld [$c295], a ; $54d3
	ld a, $ff ; $54d6
	ld [$c294], a ; $54d8
	ld [$c2a1], a ; $54db
	ret ; $54de
Label_14_54df:
	ld a, $40 ; $54df
	ld [$c2b2], a ; $54e1
	ld a, $00 ; $54e4
	ld [wWaterSpriteMinigameTimer], a ; $54e6
	xor a, a ; $54e9
	ld [wWaterSpriteMinigameSwingCount], a ; $54ea
	ld a, $10 ; $54ed
	ld [$c2bc], a ; $54ef
	ld a, $00 ; $54f2
	ld [$c2be], a ; $54f4
	ld a, $01 ; $54f7
	ld hl, $60c4 ; $54f9
	call RegisterFrameTask ; $54fc
	push af ; $54ff
	ld a, $0a ; $5500
	farcall FarPtr_WaitScriptFrames ; $5502
	pop af ; $5505
	ld a, $50 ; $5506
	ld [$c2b3], a ; $5508
	ld a, $02 ; $550b
	ld [$c2b5], a ; $550d
	xor a, a ; $5510
	ld [$c2b7], a ; $5511
	ld a, $10 ; $5514
	ld [$c2bd], a ; $5516
	ld a, $00 ; $5519
	ld [$c2bf], a ; $551b
	ld a, $01 ; $551e
	ld hl, $617e ; $5520
	call RegisterFrameTask ; $5523
	push af ; $5526
	ld a, $50 ; $5527
	farcall FarPtr_WaitScriptFrames ; $5529
	pop af ; $552c
	ld a, $03 ; $552d
	ld bc, $0600 ; $552f
	ld de, $2900 ; $5532
	farcall FarPtr_ScriptSetActorPosition ; $5535
	ld a, $04 ; $5538
	ld bc, $0600 ; $553a
	ld de, $2900 ; $553d
	farcall FarPtr_ScriptSetActorPosition ; $5540
	ld a, $05 ; $5543
	ld bc, $0600 ; $5545
	ld de, $2900 ; $5548
	farcall FarPtr_ScriptSetActorPosition ; $554b
	ld a, $06 ; $554e
	ld bc, $0600 ; $5550
	ld de, $2900 ; $5553
	farcall FarPtr_ScriptSetActorPosition ; $5556
	ldh a, [hRomBank] ; $5559
	ld b, a ; $555b
	ld a, $03 ; $555c
	ld de, $563b ; $555e
	farcall FarPtr_0a_1a ; $5561
	push af ; $5564
	ld a, $1e ; $5565
	farcall FarPtr_WaitScriptFrames ; $5567
	pop af ; $556a
	ldh a, [hRomBank] ; $556b
	ld b, a ; $556d
	ld a, $04 ; $556e
	ld de, $563b ; $5570
	farcall FarPtr_0a_1a ; $5573
	push af ; $5576
	ld a, $1e ; $5577
	farcall FarPtr_WaitScriptFrames ; $5579
	pop af ; $557c
	ldh a, [hRomBank] ; $557d
	ld b, a ; $557f
	ld a, $05 ; $5580
	ld de, $563b ; $5582
	farcall FarPtr_0a_1a ; $5585
	push af ; $5588
	ld a, $1e ; $5589
	farcall FarPtr_WaitScriptFrames ; $558b
	pop af ; $558e
	ldh a, [hRomBank] ; $558f
	ld b, a ; $5591
	ld a, $06 ; $5592
	ld de, $563b ; $5594
	farcall FarPtr_0a_1a ; $5597
	push af ; $559a
	ld a, $50 ; $559b
	farcall FarPtr_WaitScriptFrames ; $559d
	pop af ; $55a0
	ld a, $00 ; $55a1
	ld bc, $0600 ; $55a3
	ld de, $2900 ; $55a6
	farcall FarPtr_ScriptSetActorPosition ; $55a9
	ld a, $00 ; $55ac
	ld b, $02 ; $55ae
	farcall FarPtr_SetActorActive ; $55b0
	ld a, $00 ; $55b3
	ld b, $40 ; $55b5
	farcall FarPtr_SetActorFacing ; $55b7
	push af ; $55ba
	ld a, $1e ; $55bb
	farcall FarPtr_WaitScriptFrames ; $55bd
	pop af ; $55c0
	ld a, $00 ; $55c1
	ld bc, $0b00 ; $55c3
	ld de, $2900 ; $55c6
	farcall FarPtr_ScriptSetActorMoveTarget ; $55c9
	ld a, $00 ; $55cc
	farcall FarPtr_ScriptWaitActorMoveDone ; $55ce
	ld a, $00 ; $55d1
	ld b, $c0 ; $55d3
	farcall FarPtr_SetActorFacing ; $55d5
	push af ; $55d8
	ld a, $1e ; $55d9
	farcall FarPtr_WaitScriptFrames ; $55db
	pop af ; $55de
	ld a, $00 ; $55df
	ld d, $02 ; $55e1
	farcall FarPtr_ScriptSetActorAnimation ; $55e3
	ld a, $00 ; $55e6
	farcall FarPtr_ScriptWaitActorIdle ; $55e8
	ld a, [$c295] ; $55eb
	cp a, $0c ; $55ee
	jr nz, Label_14_5603 ; $55f0
	ld a, $01 ; $55f2
	ld [$c2be], a ; $55f4
	ld [$c2bf], a ; $55f7
	ld a, $01 ; $55fa
	ld [$c294], a ; $55fc
	ld [$c2a1], a ; $55ff
	ret ; $5602
Label_14_5603:
	ld a, $00 ; $5603
	ld bc, $0b00 ; $5605
	ld de, $2700 ; $5608
	farcall FarPtr_ScriptSetActorMoveTarget ; $560b
	ld a, $00 ; $560e
	farcall FarPtr_ScriptWaitActorMoveDone ; $5610
	ld a, $00 ; $5613
	ld b, $00 ; $5615
	farcall FarPtr_SetActorActive ; $5617
	ld c, $04 ; $561a
	call BeginFadeOut ; $561c
	call WaitFadeEnd ; $561f
	call WaitFadeEnd ; $5622
	call ClearFrameTasks ; $5625
	ld a, $0a ; $5628
	ld [wStoryModeCurrentLocation], a ; $562a
	ld a, $09 ; $562d
	ld [$c295], a ; $562f
	ld a, $ff ; $5632
	ld [$c294], a ; $5634
	ld [$c2a1], a ; $5637
	ret ; $563a
	INCBIN "data/bank_014/d_563b.bin" ; $563b, 2110 bytes
LoadWaterSpriteObjGfx:
	ldh a, [hWramBank] ; $5e79
	push af ; $5e7b
	wram_bank $01 ; $5e7c
	ld hl, $5650 ; $5e82
	ld de, $a000 ; $5e85
	ld c, $60 ; $5e88
	call QueueVRAMCopy ; $5e8a
	ld hl, $5e71 ; $5e8d
	ld de, $0801 ; $5e90
	call LoadPaletteShadow ; $5e93
	pop af ; $5e96
	wram_bank ; $5e97
	ret ; $5e9b
	call GetWaterSpriteScreenPos ; $5e9c
	ld b, $00 ; $5e9f
	ld a, [$c2b1] ; $5ea1
	sub a, $88 ; $5ea4
	cp a, $0a ; $5ea6
	jr c, Label_14_5ec4 ; $5ea8
	ld b, $10 ; $5eaa
	cp a, $14 ; $5eac
	jr c, Label_14_5ec4 ; $5eae
	ld b, $20 ; $5eb0
	cp a, $1e ; $5eb2
	jr c, Label_14_5ec4 ; $5eb4
	ld b, $30 ; $5eb6
	cp a, $50 ; $5eb8
	jr c, Label_14_5ec4 ; $5eba
	ld b, $20 ; $5ebc
	cp a, $78 ; $5ebe
	jr c, Label_14_5ec4 ; $5ec0
	ld b, $10 ; $5ec2
Label_14_5ec4:
	ld c, b ; $5ec4
	ld hl, $5e50 ; $5ec5
	ld b, $08 ; $5ec8
	call QueueSpriteTemplate ; $5eca
	ret ; $5ecd
	INCBIN "data/bank_014/d_5ece.bin" ; $5ece, 467 bytes
Func_14_60a1:
	ldh a, [hWramBank] ; $60a1
	push af ; $60a3
	wram_bank $01 ; $60a4
	ld hl, $5ed0 ; $60aa
	ld de, $8200 ; $60ad
	ld c, $1c ; $60b0
	call QueueVRAMCopy ; $60b2
	ld hl, $6099 ; $60b5
	ld de, $0901 ; $60b8
	call LoadPaletteShadow ; $60bb
	pop af ; $60be
	wram_bank ; $60bf
	ret ; $60c3
	ldh a, [hScrollX] ; $60c4
	ld b, a ; $60c6
	ld a, [$c2b2] ; $60c7
	sub a, b ; $60ca
	ld d, a ; $60cb
	ld a, [$c2be] ; $60cc
	and a, a ; $60cf
	jr nz, Label_14_60d5 ; $60d0
	call Func_14_616b ; $60d2
Label_14_60d5:
	ldh a, [hScrollY] ; $60d5
	ld b, a ; $60d7
	ld a, [wWaterSpriteMinigameTimer] ; $60d8
	add a, $20 ; $60db
	sub a, b ; $60dd
	ld e, a ; $60de
	ld a, [$c2be] ; $60df
	and a, a ; $60e2
	jp z, Label_14_60f4 ; $60e3
	ld a, [wWaterSpriteMinigameFlag] ; $60e6
	ld b, a ; $60e9
	ld a, [wWaterSpriteMinigameSwingCount] ; $60ea
	cp a, $14 ; $60ed
	jr c, Label_14_615c ; $60ef
	cp a, b ; $60f1
	jr c, Label_14_616a ; $60f2
Label_14_60f4:
	ld a, [$c2bc] ; $60f4
	and a, a ; $60f7
	jr z, Label_14_6107 ; $60f8
	ld a, $08 ; $60fa
	ld [$c2b8], a ; $60fc
	ld a, $00 ; $60ff
	ld [wWaterSpriteMinigameSwingCount], a ; $6101
	jp Label_14_615c ; $6104
Label_14_6107:
	ld a, [$c2b8] ; $6107
	inc a ; $610a
	ld [$c2b8], a ; $610b
	cp a, $08 ; $610e
	jr c, Label_14_612b ; $6110
	cp a, $08 ; $6112
	jr z, Label_14_6118 ; $6114
	sound $7e ; $6116
Label_14_6118:
	ld a, [$c2b2] ; $6118
	inc a ; $611b
	ld [$c2b2], a ; $611c
	xor a, a ; $611f
	ld [$c2b8], a ; $6120
	ld a, [wWaterSpriteMinigameSwingCount] ; $6123
	add a, $04 ; $6126
	ld [wWaterSpriteMinigameSwingCount], a ; $6128
Label_14_612b:
	ld a, [wWaterSpriteMinigameFlag] ; $612b
	ld b, a ; $612e
	ld a, [wWaterSpriteMinigameSwingCount] ; $612f
	cp a, $14 ; $6132
	jr c, Label_14_615c ; $6134
	cp a, b ; $6136
	jr c, Label_14_616a ; $6137
	xor a, a ; $6139
	ld [wWaterSpriteMinigameSwingCount], a ; $613a
	call AdvanceRandomSeed ; $613d
	ld a, l ; $6140
	and a, $0f ; $6141
	add a, a ; $6143
	add a, $40 ; $6144
	ld [$c2b2], a ; $6146
	ld a, h ; $6149
	and a, $3c ; $614a
	ld [wWaterSpriteMinigameFlag], a ; $614c
	ld a, h ; $614f
	and a, $0f ; $6150
	ld [wWaterSpriteMinigameTimer], a ; $6152
	ld a, $10 ; $6155
	ld [$c2bc], a ; $6157
	jr Label_14_616a ; $615a
Label_14_615c:
	ld a, [wWaterSpriteMinigameSwingCount] ; $615c
	add a, $20 ; $615f
	ld c, a ; $6161
	ld hl, $6090 ; $6162
	ld b, $01 ; $6165
	call QueueSpriteTemplate ; $6167
Label_14_616a:
	ret ; $616a
Func_14_616b:
	ld a, [$c2bc] ; $616b
	and a, a ; $616e
	jr z, Label_14_617d ; $616f
	dec a ; $6171
	ld [$c2bc], a ; $6172
	ld a, [wWaterSpriteMinigameTimer] ; $6175
	sub a, $02 ; $6178
	ld [wWaterSpriteMinigameTimer], a ; $617a
Label_14_617d:
	ret ; $617d
	ldh a, [hScrollX] ; $617e
	ld b, a ; $6180
	ld a, [$c2b3] ; $6181
	sub a, b ; $6184
	ld d, a ; $6185
	ld a, [$c2bf] ; $6186
	and a, a ; $6189
	jr nz, Label_14_618f ; $618a
	call Func_14_6225 ; $618c
Label_14_618f:
	ldh a, [hScrollY] ; $618f
	ld b, a ; $6191
	ld a, [$c2b5] ; $6192
	add a, $20 ; $6195
	sub a, b ; $6197
	ld e, a ; $6198
	ld a, [$c2bf] ; $6199
	and a, a ; $619c
	jp z, Label_14_61ae ; $619d
	ld a, [$c2bb] ; $61a0
	ld b, a ; $61a3
	ld a, [$c2b7] ; $61a4
	cp a, $14 ; $61a7
	jr c, Label_14_6216 ; $61a9
	cp a, b ; $61ab
	jr c, Label_14_6224 ; $61ac
Label_14_61ae:
	ld a, [$c2bd] ; $61ae
	and a, a ; $61b1
	jr z, Label_14_61c1 ; $61b2
	ld a, $08 ; $61b4
	ld [$c2b9], a ; $61b6
	ld a, $00 ; $61b9
	ld [$c2b7], a ; $61bb
	jp Label_14_6216 ; $61be
Label_14_61c1:
	ld a, [$c2b9] ; $61c1
	inc a ; $61c4
	ld [$c2b9], a ; $61c5
	cp a, $08 ; $61c8
	jr c, Label_14_61e5 ; $61ca
	cp a, $08 ; $61cc
	jr z, Label_14_61d2 ; $61ce
	sound $7e ; $61d0
Label_14_61d2:
	ld a, [$c2b3] ; $61d2
	inc a ; $61d5
	ld [$c2b3], a ; $61d6
	xor a, a ; $61d9
	ld [$c2b9], a ; $61da
	ld a, [$c2b7] ; $61dd
	add a, $04 ; $61e0
	ld [$c2b7], a ; $61e2
Label_14_61e5:
	ld a, [$c2bb] ; $61e5
	ld b, a ; $61e8
	ld a, [$c2b7] ; $61e9
	cp a, $14 ; $61ec
	jr c, Label_14_6216 ; $61ee
	cp a, b ; $61f0
	jr c, Label_14_6224 ; $61f1
	xor a, a ; $61f3
	ld [$c2b7], a ; $61f4
	call AdvanceRandomSeed ; $61f7
	ld a, l ; $61fa
	and a, $0f ; $61fb
	add a, a ; $61fd
	add a, $40 ; $61fe
	ld [$c2b3], a ; $6200
	ld a, l ; $6203
	and a, $3f ; $6204
	ld [$c2bb], a ; $6206
	ld a, h ; $6209
	and a, $0f ; $620a
	ld [$c2b5], a ; $620c
	ld a, $10 ; $620f
	ld [$c2bd], a ; $6211
	jr Label_14_6224 ; $6214
Label_14_6216:
	ld a, [$c2b7] ; $6216
	add a, $20 ; $6219
	ld c, a ; $621b
	ld hl, $6090 ; $621c
	ld b, $01 ; $621f
	call QueueSpriteTemplate ; $6221
Label_14_6224:
	ret ; $6224
Func_14_6225:
	ld a, [$c2bd] ; $6225
	and a, a ; $6228
	jr z, Label_14_6237 ; $6229
	dec a ; $622b
	ld [$c2bd], a ; $622c
	ld a, [$c2b5] ; $622f
	sub a, $02 ; $6232
	ld [$c2b5], a ; $6234
Label_14_6237:
	ret ; $6237
LoadWaterSpriteObjGfx2:
	ldh a, [hWramBank] ; $6238
	push af ; $623a
	wram_bank $01 ; $623b
	ld hl, $5a50 ; $6241
	ld de, $a000 ; $6244
	ld c, $60 ; $6247
	call QueueVRAMCopy ; $6249
	ld hl, $5e71 ; $624c
	ld de, $0801 ; $624f
	call LoadPaletteShadow ; $6252
	pop af ; $6255
	wram_bank ; $6256
	ret ; $625a
	call GetWaterSpriteScreenPos ; $625b
	ld b, $10 ; $625e
	ld a, [$c2b2] ; $6260
	cp a, $14 ; $6263
	jr c, Label_14_6281 ; $6265
	ld b, $20 ; $6267
	cp a, $1e ; $6269
	jr c, Label_14_6281 ; $626b
	ld b, $30 ; $626d
	cp a, $5a ; $626f
	jr c, Label_14_6281 ; $6271
	ld b, $20 ; $6273
	cp a, $78 ; $6275
	jr c, Label_14_6281 ; $6277
	ld b, $10 ; $6279
	cp a, $8c ; $627b
	jr c, Label_14_6281 ; $627d
	ld b, $00 ; $627f
Label_14_6281:
	ld c, b ; $6281
	ld hl, $5e50 ; $6282
	ld b, $08 ; $6285
	call QueueSpriteTemplate ; $6287
	ret ; $628a
Label_14_628b:
	clear_flag $09, 7 ; $628b
	call DisableLCDSafely ; $628e
	call LoadWaterSpriteObjGfx2 ; $6291
	call EnableLCD ; $6294
	ld a, $20 ; $6297
	ld [$c2b0], a ; $6299
	ld a, $28 ; $629c
	ld [$c2b1], a ; $629e
	ld a, $00 ; $62a1
	ld [$c2b2], a ; $62a3
	ld a, $01 ; $62a6
	ld hl, $625b ; $62a8
	call RegisterFrameTask ; $62ab
	ld a, $00 ; $62ae
	ld b, $00 ; $62b0
	farcall FarPtr_SetActorActive ; $62b2
	ld a, $03 ; $62b5
	ld b, $00 ; $62b7
	farcall FarPtr_SetActorActive ; $62b9
	test_flag $05, 7 ; $62bc
	jp z, Label_14_62d2 ; $62bf
	ld a, $02 ; $62c2
	farcall FarPtr_0a_1c ; $62c4
	ld a, $02 ; $62c7
	ld bc, $3f00 ; $62c9
	ld de, $3f00 ; $62cc
	farcall FarPtr_ScriptSetActorPosition ; $62cf
Label_14_62d2:
	xor a, a ; $62d2
	ld [$c2d5], a ; $62d3
	ld c, $06 ; $62d6
	call BeginFadeIn ; $62d8
	call WaitFadeEnd ; $62db
	sound $7a ; $62de
	push af ; $62e0
	ld a, $3c ; $62e1
	farcall FarPtr_WaitScriptFrames ; $62e3
	pop af ; $62e6
	ld a, $00 ; $62e7
	ld bc, $0c00 ; $62e9
	ld de, $1300 ; $62ec
	farcall FarPtr_ScriptSetActorPosition ; $62ef
	ld h, $08 ; $62f2
Label_14_62f4:
	push af ; $62f4
	ld a, $06 ; $62f5
	farcall FarPtr_WaitScriptFrames ; $62f7
	pop af ; $62fa
	call PlayWaterSpriteMoveSfx ; $62fb
	ld a, [$c2b1] ; $62fe
	dec a ; $6301
	ld [$c2b1], a ; $6302
	call Func_14_641f ; $6305
	dec h ; $6308
	jr nz, Label_14_62f4 ; $6309
	ld h, $08 ; $630b
Label_14_630d:
	push af ; $630d
	ld a, $05 ; $630e
	farcall FarPtr_WaitScriptFrames ; $6310
	pop af ; $6313
	call PlayWaterSpriteMoveSfx ; $6314
	ld a, h ; $6317
	and a, $01 ; $6318
	jr z, Label_14_6323 ; $631a
	ld a, [$c2b0] ; $631c
	inc a ; $631f
	ld [$c2b0], a ; $6320
Label_14_6323:
	ld a, [$c2b1] ; $6323
	dec a ; $6326
	ld [$c2b1], a ; $6327
	call Func_14_641f ; $632a
	dec h ; $632d
	jr nz, Label_14_630d ; $632e
	ld h, $08 ; $6330
Label_14_6332:
	push af ; $6332
	ld a, $04 ; $6333
	farcall FarPtr_WaitScriptFrames ; $6335
	pop af ; $6338
	call PlayWaterSpriteMoveSfx ; $6339
	ld a, [$c2b0] ; $633c
	inc a ; $633f
	ld [$c2b0], a ; $6340
	ld a, [$c2b1] ; $6343
	dec a ; $6346
	ld [$c2b1], a ; $6347
	call Func_14_641f ; $634a
	dec h ; $634d
	jr nz, Label_14_6332 ; $634e
	ld bc, $0012 ; $6350
	farcall FarPtr_0a_38 ; $6353
	ld a, $00 ; $6356
	ld b, $00 ; $6358
	farcall FarPtr_MovePlayerToActor ; $635a
	ld h, $1c ; $635d
Label_14_635f:
	push af ; $635f
	ld a, $03 ; $6360
	farcall FarPtr_WaitScriptFrames ; $6362
	pop af ; $6365
	call PlayWaterSpriteMoveSfx ; $6366
	ld a, h ; $6369
	and a, $01 ; $636a
	jr z, Label_14_6375 ; $636c
	ld a, [$c2b0] ; $636e
	inc a ; $6371
	ld [$c2b0], a ; $6372
Label_14_6375:
	ld a, [$c2b1] ; $6375
	dec a ; $6378
	ld [$c2b1], a ; $6379
	call Func_14_641f ; $637c
	dec h ; $637f
	jr nz, Label_14_635f ; $6380
	ld h, $00 ; $6382
Label_14_6384:
	push af ; $6384
	ld a, $03 ; $6385
	farcall FarPtr_WaitScriptFrames ; $6387
	pop af ; $638a
	inc h ; $638b
	call PlayWaterSpriteMoveSfx ; $638c
	ld a, [$c2b1] ; $638f
	dec a ; $6392
	ld [$c2b1], a ; $6393
	and a, $03 ; $6396
	cp a, $03 ; $6398
	jr nz, Label_14_63a3 ; $639a
	ld a, [$c2b0] ; $639c
	inc a ; $639f
	ld [$c2b0], a ; $63a0
Label_14_63a3:
	call Func_14_641f ; $63a3
	ld a, [$c2b0] ; $63a6
	cp a, $50 ; $63a9
	jr nz, Label_14_6384 ; $63ab
	ld h, $08 ; $63ad
Label_14_63af:
	push af ; $63af
	ld a, $04 ; $63b0
	farcall FarPtr_WaitScriptFrames ; $63b2
	pop af ; $63b5
	call PlayWaterSpriteMoveSfx ; $63b6
	ld a, [$c2b1] ; $63b9
	dec a ; $63bc
	ld [$c2b1], a ; $63bd
	call Func_14_641f ; $63c0
	dec h ; $63c3
	jr nz, Label_14_63af ; $63c4
	ld h, $08 ; $63c6
Label_14_63c8:
	push af ; $63c8
	ld a, $06 ; $63c9
	farcall FarPtr_WaitScriptFrames ; $63cb
	pop af ; $63ce
	call PlayWaterSpriteMoveSfx ; $63cf
	ld a, [$c2b1] ; $63d2
	dec a ; $63d5
	ld [$c2b1], a ; $63d6
	call Func_14_641f ; $63d9
	dec h ; $63dc
	jr nz, Label_14_63c8 ; $63dd
	ld h, $08 ; $63df
Label_14_63e1:
	push af ; $63e1
	ld a, $08 ; $63e2
	farcall FarPtr_WaitScriptFrames ; $63e4
	pop af ; $63e7
	call PlayWaterSpriteMoveSfx ; $63e8
	ld a, [$c2b1] ; $63eb
	dec a ; $63ee
	ld [$c2b1], a ; $63ef
	call Func_14_641f ; $63f2
	dec h ; $63f5
	jr nz, Label_14_63e1 ; $63f6
	sound $7d ; $63f8
	push af ; $63fa
	ld a, $32 ; $63fb
	farcall FarPtr_WaitScriptFrames ; $63fd
	pop af ; $6400
	ld c, $04 ; $6401
	call BeginFadeOut ; $6403
	call WaitFadeEnd ; $6406
	call ClearFrameTasks ; $6409
	ld a, $14 ; $640c
	ld [wStoryModeCurrentLocation], a ; $640e
	ld a, $02 ; $6411
	ld [$c295], a ; $6413
	ld a, $ff ; $6416
	ld [$c294], a ; $6418
	ld [$c2a1], a ; $641b
	ret ; $641e
Func_14_641f:
	ld a, [$c2b2] ; $641f
	inc a ; $6422
	ld [$c2b2], a ; $6423
	ret ; $6426
Func_14_6427:
	ldh a, [hWramBank] ; $6427
	push af ; $6429
	wram_bank $01 ; $642a
	ld hl, $6680 ; $6430
	ld de, $8100 ; $6433
	ld c, $80 ; $6436
	call QueueVRAMCopy ; $6438
	ld hl, $6ea1 ; $643b
	ld de, $0904 ; $643e
	call LoadPaletteShadow ; $6441
	pop af ; $6444
	wram_bank ; $6445
	ret ; $6449
	ld a, [wWaterSpriteMinigameSwingCount] ; $644a
	cp a, $04 ; $644d
	jp nc, Label_14_64bd ; $644f
	ld a, [wWaterSpriteMinigameSwingCount] ; $6452
	and a, a ; $6455
	jr nz, Label_14_645b ; $6456
	call Func_14_64be ; $6458
Label_14_645b:
	ldh a, [hScrollX] ; $645b
	ld b, a ; $645d
	ld a, [$c2b2] ; $645e
	sub a, b ; $6461
	ld d, a ; $6462
	ldh a, [hScrollY] ; $6463
	ld b, a ; $6465
	ld a, [wWaterSpriteMinigameTimer] ; $6466
	sub a, b ; $6469
	ld e, a ; $646a
	ld a, [$c2b8] ; $646b
	dec a ; $646e
	ld [$c2b8], a ; $646f
	and a, a ; $6472
	jp nz, Label_14_64a0 ; $6473
	ld a, [wWaterSpriteMinigameSwingCount] ; $6476
	inc a ; $6479
	ld [wWaterSpriteMinigameSwingCount], a ; $647a
	cp a, $04 ; $647d
	jp nc, Label_14_64bd ; $647f
	ld a, [wWaterSpriteMinigameSwingCount] ; $6482
	add a, $d5 ; $6485
	ld l, a ; $6487
	adc a, $64 ; $6488
	sub a, l ; $648a
	ld h, a ; $648b
	ld a, [hl] ; $648c
	ld [$c2b8], a ; $648d
	ld a, [wWaterSpriteMinigameSwingCount] ; $6490
	cp a, $01 ; $6493
	jr nz, Label_14_64a0 ; $6495
	ld a, [$c2b8] ; $6497
	cp a, $0c ; $649a
	jr nz, Label_14_64a0 ; $649c
	sound $81 ; $649e
Label_14_64a0:
	ld a, [wWaterSpriteMinigameSwingCount] ; $64a0
	add a, $d9 ; $64a3
	ld l, a ; $64a5
	adc a, $64 ; $64a6
	sub a, l ; $64a8
	ld h, a ; $64a9
	ld a, [hl] ; $64aa
	add a, $10 ; $64ab
	ld c, a ; $64ad
	ld a, [$c2b8] ; $64ae
	srl a ; $64b1
	and a, $03 ; $64b3
	inc a ; $64b5
	ld b, a ; $64b6
	ld hl, $6e80 ; $64b7
	call QueueSpriteTemplate ; $64ba
Label_14_64bd:
	ret ; $64bd
Func_14_64be:
	ld b, $03 ; $64be
	ld a, [$c2b8] ; $64c0
	cp a, $14 ; $64c3
	jr nc, Label_14_64cd ; $64c5
	dec b ; $64c7
	cp a, $0a ; $64c8
	jr nc, Label_14_64cd ; $64ca
	dec b ; $64cc
Label_14_64cd:
	ld a, [wWaterSpriteMinigameTimer] ; $64cd
	sub a, b ; $64d0
	ld [wWaterSpriteMinigameTimer], a ; $64d1
	ret ; $64d4
	INCBIN "data/bank_014/d_64d5.bin" ; $64d5, 12 bytes
Label_14_64e1:
	ldh a, [hRomBank] ; $64e1
	ld hl, $6675 ; $64e3
	farcall FarPtr_0a_06 ; $64e6
	farcall FarPtr_0a_00 ; $64e9
	call DisableLCDSafely ; $64ec
	call Func_14_6427 ; $64ef
	call EnableLCD ; $64f2
	test_flag $05, 7 ; $64f5
	jp z, Label_14_650b ; $64f8
	ld a, $02 ; $64fb
	farcall FarPtr_0a_1c ; $64fd
	ld a, $02 ; $6500
	ld bc, $3f00 ; $6502
	ld de, $3f00 ; $6505
	farcall FarPtr_ScriptSetActorPosition ; $6508
Label_14_650b:
	ld a, $00 ; $650b
	ld bc, $3f00 ; $650d
	ld de, $3f00 ; $6510
	farcall FarPtr_ScriptSetActorPosition ; $6513
	xor a, a ; $6516
	ld [$c2d5], a ; $6517
	ld c, $04 ; $651a
	call BeginFadeIn ; $651c
	call WaitFadeEnd ; $651f
	ld bc, $0006 ; $6522
	farcall FarPtr_0a_38 ; $6525
	xor a, a ; $6528
	ld bc, $0500 ; $6529
	ld de, $2300 ; $652c
	farcall FarPtr_MovePlayerToPosition ; $652f
	farcall FarPtr_WaitPlayerMoveDone ; $6532
	push af ; $6535
	ld a, $32 ; $6536
	farcall FarPtr_WaitScriptFrames ; $6538
	pop af ; $653b
	ld a, $50 ; $653c
	ld [$c2b3], a ; $653e
	ld a, $28 ; $6541
	ld [$c2b5], a ; $6543
	ld a, $00 ; $6546
	ld [$c2b7], a ; $6548
	ld a, $1e ; $654b
	ld [$c2b9], a ; $654d
	ld a, $01 ; $6550
	ld hl, $6ef0 ; $6552
	call RegisterFrameTask ; $6555
	push af ; $6558
	ld a, $50 ; $6559
	farcall FarPtr_WaitScriptFrames ; $655b
	pop af ; $655e
	ld a, $40 ; $655f
	ld [$c2b2], a ; $6561
	ld a, $20 ; $6564
	ld [wWaterSpriteMinigameTimer], a ; $6566
	ld a, $00 ; $6569
	ld [wWaterSpriteMinigameSwingCount], a ; $656b
	ld a, $1e ; $656e
	ld [$c2b8], a ; $6570
	ld a, $01 ; $6573
	ld hl, $644a ; $6575
	call RegisterFrameTask ; $6578
	push af ; $657b
	ld a, $50 ; $657c
	farcall FarPtr_WaitScriptFrames ; $657e
	pop af ; $6581
	ld a, $48 ; $6582
	ld [$c2b3], a ; $6584
	ld a, $28 ; $6587
	ld [$c2b5], a ; $6589
	ld a, $00 ; $658c
	ld [$c2b7], a ; $658e
	ld a, $1e ; $6591
	ld [$c2b9], a ; $6593
	push af ; $6596
	ld a, $28 ; $6597
	farcall FarPtr_WaitScriptFrames ; $6599
	pop af ; $659c
	ld a, $38 ; $659d
	ld [$c2b2], a ; $659f
	ld a, $20 ; $65a2
	ld [wWaterSpriteMinigameTimer], a ; $65a4
	ld a, $00 ; $65a7
	ld [wWaterSpriteMinigameSwingCount], a ; $65a9
	ld a, $1e ; $65ac
	ld [$c2b8], a ; $65ae
	push af ; $65b1
	ld a, $28 ; $65b2
	farcall FarPtr_WaitScriptFrames ; $65b4
	pop af ; $65b7
	ld a, $50 ; $65b8
	ld [$c2b3], a ; $65ba
	ld a, $28 ; $65bd
	ld [$c2b5], a ; $65bf
	ld a, $00 ; $65c2
	ld [$c2b7], a ; $65c4
	ld a, $19 ; $65c7
	ld [$c2b9], a ; $65c9
	push af ; $65cc
	ld a, $28 ; $65cd
	farcall FarPtr_WaitScriptFrames ; $65cf
	pop af ; $65d2
	ld a, $38 ; $65d3
	ld [$c2b2], a ; $65d5
	ld a, $20 ; $65d8
	ld [wWaterSpriteMinigameTimer], a ; $65da
	ld a, $00 ; $65dd
	ld [wWaterSpriteMinigameSwingCount], a ; $65df
	ld a, $1a ; $65e2
	ld [$c2b8], a ; $65e4
	push af ; $65e7
	ld a, $28 ; $65e8
	farcall FarPtr_WaitScriptFrames ; $65ea
	pop af ; $65ed
	ld a, $58 ; $65ee
	ld [$c2b3], a ; $65f0
	ld a, $28 ; $65f3
	ld [$c2b5], a ; $65f5
	ld a, $00 ; $65f8
	ld [$c2b7], a ; $65fa
	ld a, $1c ; $65fd
	ld [$c2b9], a ; $65ff
	push af ; $6602
	ld a, $28 ; $6603
	farcall FarPtr_WaitScriptFrames ; $6605
	pop af ; $6608
	ld a, $40 ; $6609
	ld [$c2b2], a ; $660b
	ld a, $20 ; $660e
	ld [wWaterSpriteMinigameTimer], a ; $6610
	ld a, $00 ; $6613
	ld [wWaterSpriteMinigameSwingCount], a ; $6615
	ld a, $16 ; $6618
	ld [$c2b8], a ; $661a
	push af ; $661d
	ld a, $32 ; $661e
	farcall FarPtr_WaitScriptFrames ; $6620
	pop af ; $6623
	ld a, $48 ; $6624
	ld [$c2b3], a ; $6626
	ld a, $28 ; $6629
	ld [$c2b5], a ; $662b
	ld a, $00 ; $662e
	ld [$c2b7], a ; $6630
	ld a, $1c ; $6633
	ld [$c2b9], a ; $6635
	push af ; $6638
	ld a, $48 ; $6639
	farcall FarPtr_WaitScriptFrames ; $663b
	pop af ; $663e
	ld c, $04 ; $663f
	call BeginFadeOut ; $6641
	call WaitFadeEnd ; $6644
	call ClearFrameTasks ; $6647
	test_flag $05, 7 ; $664a
	jr z, Label_14_6662 ; $664d
	ld a, $1a ; $664f
	ld [wStoryModeCurrentLocation], a ; $6651
	ld a, $0b ; $6654
	ld [$c295], a ; $6656
	ld a, $ff ; $6659
	ld [$c294], a ; $665b
	ld [$c2a1], a ; $665e
	ret ; $6661
Label_14_6662:
	ld a, $1a ; $6662
	ld [wStoryModeCurrentLocation], a ; $6664
	ld a, $0a ; $6667
	ld [$c295], a ; $6669
	ld a, $ff ; $666c
	ld [$c294], a ; $666e
	ld [$c2a1], a ; $6671
	ret ; $6674
	INCBIN "data/bank_014/d_6675.bin" ; $6675, 2310 bytes
Label_14_6f7b:
	call DisableLCDSafely ; $6f7b
	call LoadWaterSpriteObjGfx ; $6f7e
	call Func_14_73aa ; $6f81
	call EnableLCD ; $6f84
	ld a, $50 ; $6f87
	ld [$c2b0], a ; $6f89
	ld a, $88 ; $6f8c
	ld [$c2b1], a ; $6f8e
	ld a, $01 ; $6f91
	ld hl, $5e9c ; $6f93
	call RegisterFrameTask ; $6f96
	ld a, $00 ; $6f99
	ld [wWaterSpriteMinigameFlag], a ; $6f9b
	ld [$c2bb], a ; $6f9e
	ld [$c2be], a ; $6fa1
	ld a, $01 ; $6fa4
	ld hl, $73d8 ; $6fa6
	call RegisterFrameTask ; $6fa9
	ld a, $00 ; $6fac
	ld bc, $3f00 ; $6fae
	ld de, $3f00 ; $6fb1
	farcall FarPtr_ScriptSetActorPosition ; $6fb4
	test_flag $05, 7 ; $6fb7
	jp z, Label_14_6fcd ; $6fba
	ld a, $02 ; $6fbd
	farcall FarPtr_0a_1c ; $6fbf
	ld a, $02 ; $6fc2
	ld bc, $3f00 ; $6fc4
	ld de, $3f00 ; $6fc7
	farcall FarPtr_ScriptSetActorPosition ; $6fca
Label_14_6fcd:
	xor a, a ; $6fcd
	ld [$c2d5], a ; $6fce
	ld c, $06 ; $6fd1
	call BeginFadeIn ; $6fd3
	call WaitFadeEnd ; $6fd6
	sound $7a ; $6fd9
	push af ; $6fdb
	ld a, $3c ; $6fdc
	farcall FarPtr_WaitScriptFrames ; $6fde
	pop af ; $6fe1
	ld h, $08 ; $6fe2
Label_14_6fe4:
	push af ; $6fe4
	ld a, $06 ; $6fe5
	farcall FarPtr_WaitScriptFrames ; $6fe7
	pop af ; $6fea
	call PlayWaterSpriteMoveSfx ; $6feb
	ld a, [$c2b1] ; $6fee
	inc a ; $6ff1
	ld [$c2b1], a ; $6ff2
	dec h ; $6ff5
	jr nz, Label_14_6fe4 ; $6ff6
	ld h, $08 ; $6ff8
Label_14_6ffa:
	push af ; $6ffa
	ld a, $04 ; $6ffb
	farcall FarPtr_WaitScriptFrames ; $6ffd
	pop af ; $7000
	call PlayWaterSpriteMoveSfx ; $7001
	ld a, [$c2b1] ; $7004
	inc a ; $7007
	ld [$c2b1], a ; $7008
	and a, $01 ; $700b
	ld b, a ; $700d
	ld a, [$c2b0] ; $700e
	add a, b ; $7011
	ld [$c2b0], a ; $7012
	dec h ; $7015
	jr nz, Label_14_6ffa ; $7016
	ld h, $18 ; $7018
Label_14_701a:
	push af ; $701a
	ld a, $03 ; $701b
	farcall FarPtr_WaitScriptFrames ; $701d
	pop af ; $7020
	call PlayWaterSpriteMoveSfx ; $7021
	ld a, [$c2b1] ; $7024
	inc a ; $7027
	ld [$c2b1], a ; $7028
	ld a, [$c2b0] ; $702b
	inc a ; $702e
	ld [$c2b0], a ; $702f
	dec h ; $7032
	jr nz, Label_14_701a ; $7033
	ld bc, $0012 ; $7035
	farcall FarPtr_0a_38 ; $7038
	xor a, a ; $703b
	ld bc, $0b00 ; $703c
	ld de, $1800 ; $703f
	farcall FarPtr_MovePlayerToPosition ; $7042
	ld h, $18 ; $7045
Label_14_7047:
	push af ; $7047
	ld a, $02 ; $7048
	farcall FarPtr_WaitScriptFrames ; $704a
	pop af ; $704d
	call PlayWaterSpriteMoveSfx ; $704e
	ld a, [$c2b0] ; $7051
	inc a ; $7054
	ld [$c2b0], a ; $7055
	and a, $01 ; $7058
	ld b, a ; $705a
	ld a, [$c2b1] ; $705b
	add a, b ; $705e
	ld [$c2b1], a ; $705f
	dec h ; $7062
	jr nz, Label_14_7047 ; $7063
	ld h, $20 ; $7065
Label_14_7067:
	push af ; $7067
	ld a, $02 ; $7068
	farcall FarPtr_WaitScriptFrames ; $706a
	pop af ; $706d
	call PlayWaterSpriteMoveSfx ; $706e
	ld a, [$c2b0] ; $7071
	inc a ; $7074
	ld [$c2b0], a ; $7075
	and a, $03 ; $7078
	cp a, $03 ; $707a
	jr nz, Label_14_7085 ; $707c
	ld a, [$c2b1] ; $707e
	inc a ; $7081
	ld [$c2b1], a ; $7082
Label_14_7085:
	dec h ; $7085
	jr nz, Label_14_7067 ; $7086
	ld hl, $5e9c ; $7088
	call UnregisterFrameTask ; $708b
	ld h, $1e ; $708e
Label_14_7090:
	push af ; $7090
	ld a, $02 ; $7091
	farcall FarPtr_WaitScriptFrames ; $7093
	pop af ; $7096
	call PlayWaterSpriteMoveSfx ; $7097
	dec h ; $709a
	jr nz, Label_14_7090 ; $709b
	xor a, a ; $709d
	ld bc, $0b00 ; $709e
	ld de, $0d00 ; $70a1
	farcall FarPtr_MovePlayerToPosition ; $70a4
	call Func_14_7539 ; $70a7
	ld a, $04 ; $70aa
	ld [wWaterSpriteMinigameSwingCount], a ; $70ac
	ld a, $a8 ; $70af
	ld [$c2b1], a ; $70b1
	ld a, $01 ; $70b4
	ld hl, $755c ; $70b6
	call RegisterFrameTask ; $70b9
	ld h, $50 ; $70bc
Label_14_70be:
	push af ; $70be
	ld a, $02 ; $70bf
	farcall FarPtr_WaitScriptFrames ; $70c1
	pop af ; $70c4
	call PlayWaterSpriteMoveSfx ; $70c5
	ld a, [$c2b1] ; $70c8
	dec a ; $70cb
	ld [$c2b1], a ; $70cc
	ld a, [$c2b0] ; $70cf
	dec a ; $70d2
	ld [$c2b0], a ; $70d3
	ld a, h ; $70d6
	cp a, $1e ; $70d7
	jr nz, Label_14_70e0 ; $70d9
	ld a, $00 ; $70db
	ld [wWaterSpriteMinigameSwingCount], a ; $70dd
Label_14_70e0:
	dec h ; $70e0
	jr nz, Label_14_70be ; $70e1
	ld hl, $755c ; $70e3
	call UnregisterFrameTask ; $70e6
	call Func_14_7688 ; $70e9
	call Func_14_787b ; $70ec
	push af ; $70ef
	ld a, $46 ; $70f0
	farcall FarPtr_WaitScriptFrames ; $70f2
	pop af ; $70f5
	ld a, [$c295] ; $70f6
	cp a, $0d ; $70f9
	jp nz, Label_14_710c ; $70fb
	ld a, $01 ; $70fe
	ld [$c2be], a ; $7100
	ld a, $01 ; $7103
	ld [$c294], a ; $7105
	ld [$c2a1], a ; $7108
	ret ; $710b
Label_14_710c:
	test_flag $05, 7 ; $710c
	jp z, Label_14_711c ; $710f
	test_flag $16, 1 ; $7112
	jr nz, Label_14_7149 ; $7115
	set_flag $16, 1 ; $7117
	jr Label_14_7124 ; $711a
Label_14_711c:
	test_flag $16, 0 ; $711c
	jr nz, Label_14_7150 ; $711f
	set_flag $16, 0 ; $7121
Label_14_7124:
	ld b, $1d ; $7124
	ld c, $0f ; $7126
	farcall FarPtr_0a_62 ; $7128
	farcall FarPtr_SaveStorySlotWithTimer ; $712b
	ld c, $01 ; $712e
	call BeginFadeOut ; $7130
	call WaitFadeEnd ; $7133
	ld a, $00 ; $7136
	ld [wStoryModeCurrentLocation], a ; $7138
	ld a, $0a ; $713b
	ld [$c295], a ; $713d
	ld a, $ff ; $7140
	ld [$c294], a ; $7142
	ld [$c2a1], a ; $7145
	ret ; $7148
Label_14_7149:
	test_flag $16, 3 ; $7149
	jr z, Label_14_7170 ; $714c
	jr Label_14_7155 ; $714e
Label_14_7150:
	test_flag $16, 2 ; $7150
	jr z, Label_14_7170 ; $7153
Label_14_7155:
	ld c, $04 ; $7155
	call BeginFadeOut ; $7157
	call WaitFadeEnd ; $715a
	ld a, $1d ; $715d
	ld [wStoryModeCurrentLocation], a ; $715f
	ld a, $01 ; $7162
	ld [$c295], a ; $7164
	ld a, $ff ; $7167
	ld [$c294], a ; $7169
	ld [$c2a1], a ; $716c
	ret ; $716f
Label_14_7170:
	ld c, $04 ; $7170
	call BeginFadeOut ; $7172
	call WaitFadeEnd ; $7175
	ld a, $1d ; $7178
	ld [wStoryModeCurrentLocation], a ; $717a
	ld a, $0f ; $717d
	ld [$c295], a ; $717f
	ld a, $ff ; $7182
	ld [$c294], a ; $7184
	ld [$c2a1], a ; $7187
	ret ; $718a
	INCBIN "data/bank_014/d_718b.bin" ; $718b, 543 bytes
Func_14_73aa:
	ldh a, [hWramBank] ; $73aa
	push af ; $73ac
	wram_bank $01 ; $73ad
	ld hl, $7190 ; $73b3
	ld de, $8100 ; $73b6
	ld c, $40 ; $73b9
	call QueueVRAMCopy ; $73bb
	ld hl, $7290 ; $73be
	ld de, $8200 ; $73c1
	ld c, $30 ; $73c4
	call QueueVRAMCopy ; $73c6
	ld hl, $738a ; $73c9
	ld de, $0903 ; $73cc
	call LoadPaletteShadow ; $73cf
	pop af ; $73d2
	wram_bank ; $73d3
	ret ; $73d7
	ldh a, [hScrollX] ; $73d8
	ld b, a ; $73da
	ld a, $40 ; $73db
	sub a, b ; $73dd
	ld d, a ; $73de
	ldh a, [hScrollY] ; $73df
	ld b, a ; $73e1
	ld a, $40 ; $73e2
	sub a, b ; $73e4
	ld e, a ; $73e5
	ld c, $10 ; $73e6
	ld hl, $7350 ; $73e8
	ld a, [$c2be] ; $73eb
	and a, a ; $73ee
	jr nz, Label_14_73f8 ; $73ef
	ld a, [wWaterSpriteMinigameFlag] ; $73f1
	inc a ; $73f4
	ld [wWaterSpriteMinigameFlag], a ; $73f5
Label_14_73f8:
	ld a, [wWaterSpriteMinigameFlag] ; $73f8
	swap a ; $73fb
	and a, $03 ; $73fd
	cp a, $03 ; $73ff
	jr nz, Label_14_7408 ; $7401
	ld a, $00 ; $7403
	ld [wWaterSpriteMinigameFlag], a ; $7405
Label_14_7408:
	inc a ; $7408
	ld b, a ; $7409
	call QueueSpriteTemplate ; $740a
	ldh a, [hScrollX] ; $740d
	ld b, a ; $740f
	ld a, $68 ; $7410
	sub a, b ; $7412
	ld d, a ; $7413
	ldh a, [hScrollY] ; $7414
	ld b, a ; $7416
	ld a, $50 ; $7417
	sub a, b ; $7419
	ld e, a ; $741a
	ld c, $20 ; $741b
	ld hl, $7371 ; $741d
	ld a, [wWaterSpriteMinigameFlag] ; $7420
	swap a ; $7423
	and a, $03 ; $7425
	inc a ; $7427
	ld b, a ; $7428
	call QueueSpriteTemplate ; $7429
	ret ; $742c
	INCBIN "data/bank_014/d_742d.bin" ; $742d, 268 bytes
Func_14_7539:
	ldh a, [hWramBank] ; $7539
	push af ; $753b
	wram_bank $01 ; $753c
	ld hl, $7430 ; $7542
	ld de, $a000 ; $7545
	ld c, $10 ; $7548
	call QueueVRAMCopy ; $754a
	ld hl, $5e71 ; $754d
	ld de, $0801 ; $7550
	call LoadPaletteShadow ; $7553
	pop af ; $7556
	wram_bank ; $7557
	ret ; $755b
	call GetWaterSpriteScreenPos ; $755c
	ld a, [wWaterSpriteMinigameSwingCount] ; $755f
	ld c, a ; $7562
	ld c, a ; $7563
	ld hl, $7530 ; $7564
	ld b, $08 ; $7567
	call QueueSpriteTemplate ; $7569
	ret ; $756c
GetWaterSpriteScreenPos:
	ldh a, [hScrollX] ; $756d
	ld b, a ; $756f
	ld a, [$c2b0] ; $7570
	sub a, b ; $7573
	ld d, a ; $7574
	ldh a, [hScrollY] ; $7575
	ld b, a ; $7577
	ld a, [$c2b1] ; $7578
	sub a, b ; $757b
	ld e, a ; $757c
	ret ; $757d
	INCBIN "data/bank_014/d_757e.bin" ; $757e, 266 bytes
Func_14_7688:
	ldh a, [hWramBank] ; $7688
	push af ; $768a
	wram_bank $01 ; $768b
	ld hl, $7580 ; $7691
	ld de, $a000 ; $7694
	ld c, $10 ; $7697
	call QueueVRAMCopy ; $7699
	ld hl, $7680 ; $769c
	ld de, $0801 ; $769f
	call LoadPaletteShadow ; $76a2
	pop af ; $76a5
	wram_bank ; $76a6
	ret ; $76aa
	ldh a, [hScrollX] ; $76ab
	ld b, a ; $76ad
	ld a, $54 ; $76ae
	sub a, b ; $76b0
	ld d, a ; $76b1
	ldh a, [hScrollY] ; $76b2
	ld b, a ; $76b4
	ld a, $58 ; $76b5
	sub a, b ; $76b7
	ld e, a ; $76b8
	ld a, [wWaterSpriteMinigameSwingCount] ; $76b9
	ld c, a ; $76bc
	ld hl, $7530 ; $76bd
	ld b, $08 ; $76c0
	call QueueSpriteTemplate ; $76c2
	ret ; $76c5
Label_14_76c6:
	call DisableLCDSafely ; $76c6
	call Func_14_73aa ; $76c9
	call Func_14_7688 ; $76cc
	call EnableLCD ; $76cf
	ld a, $00 ; $76d2
	ld [wWaterSpriteMinigameFlag], a ; $76d4
	ld [$c2bb], a ; $76d7
	ld a, $01 ; $76da
	ld hl, $73d8 ; $76dc
	call RegisterFrameTask ; $76df
	ld a, $00 ; $76e2
	ld bc, $3f00 ; $76e4
	ld de, $3f00 ; $76e7
	farcall FarPtr_ScriptSetActorPosition ; $76ea
	test_flag $05, 7 ; $76ed
	jp z, Label_14_7703 ; $76f0
	ld a, $02 ; $76f3
	farcall FarPtr_0a_1c ; $76f5
	ld a, $02 ; $76f8
	ld bc, $3f00 ; $76fa
	ld de, $3f00 ; $76fd
	farcall FarPtr_ScriptSetActorPosition ; $7700
Label_14_7703:
	xor a, a ; $7703
	ld [$c2d5], a ; $7704
	ld c, $06 ; $7707
	call BeginFadeIn ; $7709
	call WaitFadeEnd ; $770c
	push af ; $770f
	ld a, $3c ; $7710
	farcall FarPtr_WaitScriptFrames ; $7712
	pop af ; $7715
	call Func_14_787b ; $7716
	push af ; $7719
	ld a, $1e ; $771a
	farcall FarPtr_WaitScriptFrames ; $771c
	pop af ; $771f
	call Func_14_7539 ; $7720
	ld a, $08 ; $7723
	ld [wWaterSpriteMinigameSwingCount], a ; $7725
	ld a, $54 ; $7728
	ld [$c2b0], a ; $772a
	ld a, $58 ; $772d
	ld [$c2b1], a ; $772f
	ld a, $01 ; $7732
	ld hl, $755c ; $7734
	call RegisterFrameTask ; $7737
	ld h, $4b ; $773a
Label_14_773c:
	push af ; $773c
	ld a, $02 ; $773d
	farcall FarPtr_WaitScriptFrames ; $773f
	pop af ; $7742
	call PlayWaterSpriteMoveSfx ; $7743
	ld a, [$c2b1] ; $7746
	inc a ; $7749
	ld [$c2b1], a ; $774a
	ld a, [$c2b0] ; $774d
	inc a ; $7750
	ld [$c2b0], a ; $7751
	ld a, h ; $7754
	cp a, $2d ; $7755
	jr nz, Label_14_775e ; $7757
	ld a, $0c ; $7759
	ld [wWaterSpriteMinigameSwingCount], a ; $775b
Label_14_775e:
	dec h ; $775e
	jr nz, Label_14_773c ; $775f
	ld hl, $755c ; $7761
	call UnregisterFrameTask ; $7764
	ld bc, $0012 ; $7767
	farcall FarPtr_0a_38 ; $776a
	xor a, a ; $776d
	ld bc, $0b00 ; $776e
	ld de, $1800 ; $7771
	farcall FarPtr_MovePlayerToPosition ; $7774
	ld h, $3c ; $7777
Label_14_7779:
	push af ; $7779
	ld a, $02 ; $777a
	farcall FarPtr_WaitScriptFrames ; $777c
	pop af ; $777f
	call PlayWaterSpriteMoveSfx ; $7780
	dec h ; $7783
	jr nz, Label_14_7779 ; $7784
	call LoadWaterSpriteObjGfx2 ; $7786
	ld a, $a4 ; $7789
	ld [$c2b0], a ; $778b
	ld a, $c6 ; $778e
	ld [$c2b1], a ; $7790
	ld a, $3c ; $7793
	ld [$c2b2], a ; $7795
	ld a, $01 ; $7798
	ld hl, $625b ; $779a
	call RegisterFrameTask ; $779d
	ld h, $20 ; $77a0
Label_14_77a2:
	push af ; $77a2
	ld a, $02 ; $77a3
	farcall FarPtr_WaitScriptFrames ; $77a5
	pop af ; $77a8
	call PlayWaterSpriteMoveSfx ; $77a9
	ld a, [$c2b0] ; $77ac
	dec a ; $77af
	ld [$c2b0], a ; $77b0
	and a, $03 ; $77b3
	cp a, $03 ; $77b5
	jr nz, Label_14_77c0 ; $77b7
	ld a, [$c2b1] ; $77b9
	dec a ; $77bc
	ld [$c2b1], a ; $77bd
Label_14_77c0:
	call Func_14_7873 ; $77c0
	dec h ; $77c3
	jr nz, Label_14_77a2 ; $77c4
	ld h, $18 ; $77c6
Label_14_77c8:
	push af ; $77c8
	ld a, $02 ; $77c9
	farcall FarPtr_WaitScriptFrames ; $77cb
	pop af ; $77ce
	call PlayWaterSpriteMoveSfx ; $77cf
	ld a, [$c2b0] ; $77d2
	dec a ; $77d5
	ld [$c2b0], a ; $77d6
	and a, $01 ; $77d9
	ld b, a ; $77db
	ld a, [$c2b1] ; $77dc
	sub a, b ; $77df
	ld [$c2b1], a ; $77e0
	call Func_14_7873 ; $77e3
	dec h ; $77e6
	jr nz, Label_14_77c8 ; $77e7
	xor a, a ; $77e9
	ld bc, $0b00 ; $77ea
	ld de, $1200 ; $77ed
	farcall FarPtr_MovePlayerToPosition ; $77f0
	ld h, $18 ; $77f3
Label_14_77f5:
	push af ; $77f5
	ld a, $03 ; $77f6
	farcall FarPtr_WaitScriptFrames ; $77f8
	pop af ; $77fb
	call PlayWaterSpriteMoveSfx ; $77fc
	ld a, [$c2b1] ; $77ff
	dec a ; $7802
	ld [$c2b1], a ; $7803
	ld a, [$c2b0] ; $7806
	dec a ; $7809
	ld [$c2b0], a ; $780a
	call Func_14_7873 ; $780d
	dec h ; $7810
	jr nz, Label_14_77f5 ; $7811
	ld h, $08 ; $7813
Label_14_7815:
	push af ; $7815
	ld a, $04 ; $7816
	farcall FarPtr_WaitScriptFrames ; $7818
	pop af ; $781b
	call PlayWaterSpriteMoveSfx ; $781c
	ld a, [$c2b1] ; $781f
	dec a ; $7822
	ld [$c2b1], a ; $7823
	and a, $01 ; $7826
	ld b, a ; $7828
	ld a, [$c2b0] ; $7829
	sub a, b ; $782c
	ld [$c2b0], a ; $782d
	call Func_14_7873 ; $7830
	dec h ; $7833
	jr nz, Label_14_7815 ; $7834
	ld h, $0c ; $7836
Label_14_7838:
	push af ; $7838
	ld a, $06 ; $7839
	farcall FarPtr_WaitScriptFrames ; $783b
	pop af ; $783e
	call PlayWaterSpriteMoveSfx ; $783f
	ld a, [$c2b1] ; $7842
	dec a ; $7845
	ld [$c2b1], a ; $7846
	call Func_14_7873 ; $7849
	dec h ; $784c
	jr nz, Label_14_7838 ; $784d
	sound $7d ; $784f
	push af ; $7851
	ld a, $46 ; $7852
	farcall FarPtr_WaitScriptFrames ; $7854
	pop af ; $7857
	ld c, $04 ; $7858
	call BeginFadeOut ; $785a
	call WaitFadeEnd ; $785d
	ld a, $14 ; $7860
	ld [wStoryModeCurrentLocation], a ; $7862
	ld a, $02 ; $7865
	ld [$c295], a ; $7867
	ld a, $ff ; $786a
	ld [$c294], a ; $786c
	ld [$c2a1], a ; $786f
	ret ; $7872
Func_14_7873:
	ld a, [$c2b2] ; $7873
	inc a ; $7876
	ld [$c2b2], a ; $7877
	ret ; $787a
Func_14_787b:
	xor a, a ; $787b
	ld [wWaterSpriteMinigameSwingCount], a ; $787c
	call AdvanceFrame ; $787f
	ld a, $01 ; $7882
	ld hl, $76ab ; $7884
	call RegisterFrameTask ; $7887
	sound $84 ; $788a
	ld h, $04 ; $788c
Label_14_788e:
	push af ; $788e
	ld a, $04 ; $788f
	farcall FarPtr_WaitScriptFrames ; $7891
	pop af ; $7894
	ld a, [wWaterSpriteMinigameSwingCount] ; $7895
	add a, $04 ; $7898
	ld [wWaterSpriteMinigameSwingCount], a ; $789a
	dec h ; $789d
	jr nz, Label_14_788e ; $789e
	ld hl, $76ab ; $78a0
	call UnregisterFrameTask ; $78a3
	ret ; $78a6
PlayWaterSpriteMoveSfx:
	ld a, h ; $78a7
	srl a ; $78a8
	and a, $01 ; $78aa
	jr z, Label_14_78b0 ; $78ac
	sound $7b ; $78ae
Label_14_78b0:
	ret ; $78b0
	INCBIN "data/bank_014/d_78b1.bin" ; $78b1, 40 bytes
	ret ; $78d9
	xor a, a ; $78da
	ld [$c2da], a ; $78db
	ret ; $78de
	INCBIN "data/bank_014/d_78df.bin" ; $78df, 3 bytes
	xor a, a ; $78e2
	ld [$c2d5], a ; $78e3
	ret ; $78e6
	INCBIN "data/bank_014/d_78e7.bin" ; $78e7, 558 bytes
	ds 1259, $ff ; $7b15, fill
