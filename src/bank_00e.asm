SECTION "ROM Bank $0e", ROMX[$4000], BANK[$0e]

DataPtr_TrainingGymMapScripts_0e:
	dw TrainingGymMapScripts_0e ; $4000
DataPtr_MarioWorldMapScripts_0e:
	dw MarioWorldMapScripts_0e ; $4002
DataPtr_SpecialCourtMapScripts_0e:
	dw SpecialCourtMapScripts_0e ; $4004
TrainingGymMapScripts_0e:
	; $4006, 14 bytes (records:2)
; 7 records x 2 bytes
	dw $40c6 ; record 0
	dw $4277 ; record 1
	dw $4014 ; record 2
	dw $4554 ; record 3
	dw $45ad ; record 4
	dw $45f6 ; record 5
	dw $4619 ; record 6
	; $4014, 178 bytes (bytes:14)
	db $00, $00, $6e, $7c, $00, $25, $00, $0d, $40, $00, $42, $01, $00, $00 ; 0x00
	db $00, $00, $6e, $7c, $00, $29, $00, $0f, $40, $00, $45, $01, $05, $00 ; 0x0e
	db $00, $00, $6e, $7c, $00, $25, $00, $15, $40, $00, $43, $01, $07, $00 ; 0x1c
	db $00, $00, $6e, $7c, $00, $29, $00, $13, $40, $00, $44, $01, $05, $00 ; 0x2a
	db $00, $00, $6e, $7c, $00, $25, $00, $05, $40, $00, $47, $01, $07, $00 ; 0x38
	db $00, $00, $6e, $7c, $00, $27, $00, $07, $40, $00, $46, $01, $00, $00 ; 0x46
	db $00, $00, $6e, $7c, $00, $29, $00, $05, $40, $00, $47, $01, $00, $00 ; 0x54
	db $00, $00, $12, $47, $00, $21, $00, $0c, $40, $00, $3b, $01, $00, $00 ; 0x62
	db $00, $00, $c9, $48, $00, $2c, $00, $0b, $80, $00, $3c, $01, $00, $00 ; 0x70
	db $00, $00, $80, $4a, $60, $2d, $00, $17, $00, $00, $3b, $01, $06, $00 ; 0x7e
	db $00, $00, $25, $52, $00, $19, $00, $11, $c0, $00, $39, $01, $06, $00 ; 0x8c
	db $00, $00, $6e, $7c, $00, $0d, $00, $13, $00, $00, $39, $01, $07, $00 ; 0x9a
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $ff ; 0xa8
	; $40c6, 57 bytes (bytes:16)
	db $01, $c0, $00, $16, $00, $18, $ff, $40, $02, $40, $00, $0b, $00, $0c, $45, $41 ; 0x00
	db $03, $40, $00, $15, $00, $0c, $e2, $41, $0b, $40, $00, $0d, $00, $0f, $00, $00 ; 0x10
	db $0c, $80, $00, $11, $00, $13, $00, $00, $0d, $40, $00, $0d, $00, $0f, $00, $00 ; 0x20
	db $0e, $80, $00, $11, $00, $13, $00, $00, $ff ; 0x30
	ld a, [$c295] ; $40ff
	cp a, $ff ; $4102
	jp z, Label_0e_4144 ; $4104
	test_flag $05, 7 ; $4107
	jr z, Label_0e_4132 ; $410a
	ld a, $02 ; $410c
	ld bc, $00ff ; $410e
	farcall FarPtr_0a_18 ; $4111
	ld a, $02 ; $4114
	ld b, $40 ; $4116
	ld de, $0200 ; $4118
	farcall FarPtr_MoveActorByAngle ; $411b
	ld a, $02 ; $411e
	farcall FarPtr_ScriptWaitActorMoveDone ; $4120
	ld a, $02 ; $4123
	ld b, $c0 ; $4125
	farcall FarPtr_SetActorFacing ; $4127
	ld a, $02 ; $412a
	ld bc, $0010 ; $412c
	farcall FarPtr_0a_18 ; $412f
Label_0e_4132:
	ld a, $00 ; $4132
	ld bc, $0010 ; $4134
	farcall FarPtr_0a_18 ; $4137
	ld a, $00 ; $413a
	ld b, $c0 ; $413c
	ld de, $0200 ; $413e
	farcall FarPtr_MoveActorByAngle ; $4141
Label_0e_4144:
	ret ; $4144
	ld a, [$c295] ; $4145
	cp a, $ff ; $4148
	jp z, Label_0e_41e1 ; $414a
	ld a, $00 ; $414d
	ld bc, $0010 ; $414f
	farcall FarPtr_0a_18 ; $4152
	ld a, $02 ; $4155
	ld bc, $0010 ; $4157
	farcall FarPtr_0a_18 ; $415a
	farcall FarPtr_WaitPlayerMoveDone ; $415d
	ld b, $0a ; $4160
	ld c, $0a ; $4162
	ld d, $3d ; $4164
	ld e, $0c ; $4166
	ld h, $02 ; $4168
	ld l, $02 ; $416a
	farcall FarPtr_0a_7e ; $416c
	ld b, $3d ; $416f
	ld c, $0a ; $4171
	ld d, $0a ; $4173
	ld e, $0a ; $4175
	ld h, $02 ; $4177
	ld l, $02 ; $4179
	farcall FarPtr_0a_7e ; $417b
	push af ; $417e
	ld a, $02 ; $417f
	farcall FarPtr_WaitScriptFrames ; $4181
	pop af ; $4184
	ld c, $08 ; $4185
	call BeginFadeIn ; $4187
	call WaitFadeEnd ; $418a
	ld a, $00 ; $418d
	ld bc, $0b00 ; $418f
	ld de, $0e00 ; $4192
	farcall FarPtr_ScriptSetActorMoveTarget ; $4195
	ld a, $00 ; $4198
	farcall FarPtr_ScriptWaitActorMoveDone ; $419a
	sound $71 ; $419d
	push af ; $419f
	ld a, $02 ; $41a0
	farcall FarPtr_WaitScriptFrames ; $41a2
	pop af ; $41a5
	ld b, $3a ; $41a6
	ld c, $0a ; $41a8
	ld d, $0a ; $41aa
	ld e, $0a ; $41ac
	ld h, $02 ; $41ae
	ld l, $02 ; $41b0
	farcall FarPtr_0a_7e ; $41b2
	push af ; $41b5
	ld a, $02 ; $41b6
	farcall FarPtr_WaitScriptFrames ; $41b8
	pop af ; $41bb
	ld b, $37 ; $41bc
	ld c, $0a ; $41be
	ld d, $0a ; $41c0
	ld e, $0a ; $41c2
	ld h, $02 ; $41c4
	ld l, $02 ; $41c6
	farcall FarPtr_0a_7e ; $41c8
	push af ; $41cb
	ld a, $02 ; $41cc
	farcall FarPtr_WaitScriptFrames ; $41ce
	pop af ; $41d1
	ld b, $3d ; $41d2
	ld c, $0c ; $41d4
	ld d, $0a ; $41d6
	ld e, $0a ; $41d8
	ld h, $02 ; $41da
	ld l, $02 ; $41dc
	farcall FarPtr_0a_7e ; $41de
Label_0e_41e1:
	ret ; $41e1
	ld a, [$c295] ; $41e2
	cp a, $ff ; $41e5
	jr z, Label_0e_41e1 ; $41e7
	ld a, $00 ; $41e9
	ld bc, $0010 ; $41eb
	farcall FarPtr_0a_18 ; $41ee
	ld a, $02 ; $41f1
	ld bc, $0010 ; $41f3
	farcall FarPtr_0a_18 ; $41f6
	farcall FarPtr_WaitPlayerMoveDone ; $41f9
	ld b, $0a ; $41fc
	ld c, $0a ; $41fe
	ld d, $3d ; $4200
	ld e, $0c ; $4202
	ld h, $02 ; $4204
	ld l, $02 ; $4206
	farcall FarPtr_0a_7e ; $4208
	ld b, $3d ; $420b
	ld c, $0a ; $420d
	ld d, $14 ; $420f
	ld e, $0a ; $4211
	ld h, $02 ; $4213
	ld l, $02 ; $4215
	farcall FarPtr_0a_7e ; $4217
	ld c, $08 ; $421a
	call BeginFadeIn ; $421c
	call WaitFadeEnd ; $421f
	ld a, $00 ; $4222
	ld bc, $1500 ; $4224
	ld de, $0e00 ; $4227
	farcall FarPtr_ScriptSetActorMoveTarget ; $422a
	ld a, $00 ; $422d
	farcall FarPtr_ScriptWaitActorMoveDone ; $422f
	sound $71 ; $4232
	push af ; $4234
	ld a, $02 ; $4235
	farcall FarPtr_WaitScriptFrames ; $4237
	pop af ; $423a
	ld b, $3a ; $423b
	ld c, $0a ; $423d
	ld d, $14 ; $423f
	ld e, $0a ; $4241
	ld h, $02 ; $4243
	ld l, $02 ; $4245
	farcall FarPtr_0a_7e ; $4247
	push af ; $424a
	ld a, $02 ; $424b
	farcall FarPtr_WaitScriptFrames ; $424d
	pop af ; $4250
	ld b, $37 ; $4251
	ld c, $0a ; $4253
	ld d, $14 ; $4255
	ld e, $0a ; $4257
	ld h, $02 ; $4259
	ld l, $02 ; $425b
	farcall FarPtr_0a_7e ; $425d
	push af ; $4260
	ld a, $02 ; $4261
	farcall FarPtr_WaitScriptFrames ; $4263
	pop af ; $4266
	ld b, $3d ; $4267
	ld c, $0c ; $4269
	ld d, $14 ; $426b
	ld e, $0a ; $426d
	ld h, $02 ; $426f
	ld l, $02 ; $4271
	farcall FarPtr_0a_7e ; $4273
	ret ; $4276
	; $4277, 25 bytes (records:8)
; 3 records x 8 bytes
	dw $ff01, $0000, $7c96, $0107 ; record 0
	dw $ff03, $0000, $431b, $0112 ; record 1
	dw $ff02, $0000, $4290, $0113 ; record 2
	db $ff
	ld a, $00 ; $4290
	ld b, $c0 ; $4292
	farcall FarPtr_SetActorFacing ; $4294
	ld a, $00 ; $4297
	ld b, $01 ; $4299
	farcall FarPtr_0a_2c ; $429b
	ld a, $00 ; $429e
	ld bc, $0018 ; $42a0
	farcall FarPtr_0a_18 ; $42a3
	ld a, $00 ; $42a6
	ld bc, $0b00 ; $42a8
	ld de, $0d00 ; $42ab
	farcall FarPtr_ScriptSetActorMoveTarget ; $42ae
	ld a, $00 ; $42b1
	farcall FarPtr_ScriptWaitActorMoveDone ; $42b3
	farcall FarPtr_WaitPlayerMoveDone ; $42b6
	sound $71 ; $42b9
	ld b, $37 ; $42bb
	ld c, $0a ; $42bd
	ld d, $0a ; $42bf
	ld e, $0a ; $42c1
	ld h, $02 ; $42c3
	ld l, $02 ; $42c5
	farcall FarPtr_0a_7e ; $42c7
	push af ; $42ca
	ld a, $02 ; $42cb
	farcall FarPtr_WaitScriptFrames ; $42cd
	pop af ; $42d0
	ld b, $3a ; $42d1
	ld c, $0a ; $42d3
	ld d, $0a ; $42d5
	ld e, $0a ; $42d7
	ld h, $02 ; $42d9
	ld l, $02 ; $42db
	farcall FarPtr_0a_7e ; $42dd
	push af ; $42e0
	ld a, $02 ; $42e1
	farcall FarPtr_WaitScriptFrames ; $42e3
	pop af ; $42e6
	ld b, $3d ; $42e7
	ld c, $0a ; $42e9
	ld d, $0a ; $42eb
	ld e, $0a ; $42ed
	ld h, $02 ; $42ef
	ld l, $02 ; $42f1
	farcall FarPtr_0a_7e ; $42f3
	push af ; $42f6
	ld a, $02 ; $42f7
	farcall FarPtr_WaitScriptFrames ; $42f9
	pop af ; $42fc
	ld a, $00 ; $42fd
	ld b, $c0 ; $42ff
	ld de, $0100 ; $4301
	farcall FarPtr_MoveActorByAngle ; $4304
	ld c, $08 ; $4307
	call BeginFadeOut ; $4309
	ld a, $00 ; $430c
	ld b, $00 ; $430e
	farcall FarPtr_0a_2c ; $4310
	push af ; $4313
	ld a, $0a ; $4314
	farcall FarPtr_WaitScriptFrames ; $4316
	pop af ; $4319
	ret ; $431a
	ld a, $00 ; $431b
	ld b, $c0 ; $431d
	farcall FarPtr_SetActorFacing ; $431f
	ld a, $00 ; $4322
	ld b, $01 ; $4324
	farcall FarPtr_0a_2c ; $4326
	ld a, $00 ; $4329
	ld bc, $0018 ; $432b
	farcall FarPtr_0a_18 ; $432e
	ld a, $00 ; $4331
	ld bc, $1500 ; $4333
	ld de, $0d00 ; $4336
	farcall FarPtr_ScriptSetActorMoveTarget ; $4339
	ld a, $00 ; $433c
	farcall FarPtr_ScriptWaitActorMoveDone ; $433e
	farcall FarPtr_WaitPlayerMoveDone ; $4341
	sound $71 ; $4344
	ld b, $37 ; $4346
	ld c, $0a ; $4348
	ld d, $14 ; $434a
	ld e, $0a ; $434c
	ld h, $02 ; $434e
	ld l, $02 ; $4350
	farcall FarPtr_0a_7e ; $4352
	push af ; $4355
	ld a, $02 ; $4356
	farcall FarPtr_WaitScriptFrames ; $4358
	pop af ; $435b
	ld b, $3a ; $435c
	ld c, $0a ; $435e
	ld d, $14 ; $4360
	ld e, $0a ; $4362
	ld h, $02 ; $4364
	ld l, $02 ; $4366
	farcall FarPtr_0a_7e ; $4368
	push af ; $436b
	ld a, $02 ; $436c
	farcall FarPtr_WaitScriptFrames ; $436e
	pop af ; $4371
	ld b, $3d ; $4372
	ld c, $0a ; $4374
	ld d, $14 ; $4376
	ld e, $0a ; $4378
	ld h, $02 ; $437a
	ld l, $02 ; $437c
	farcall FarPtr_0a_7e ; $437e
	push af ; $4381
	ld a, $02 ; $4382
	farcall FarPtr_WaitScriptFrames ; $4384
	pop af ; $4387
	ld a, $00 ; $4388
	ld b, $c0 ; $438a
	ld de, $0100 ; $438c
	farcall FarPtr_MoveActorByAngle ; $438f
	ld c, $08 ; $4392
	call BeginFadeOut ; $4394
	ld a, $00 ; $4397
	ld b, $00 ; $4399
	farcall FarPtr_0a_2c ; $439b
	push af ; $439e
	ld a, $0a ; $439f
	farcall FarPtr_WaitScriptFrames ; $43a1
	pop af ; $43a4
	ret ; $43a5
	ld a, [$c2b0] ; $43a6
	add a, a ; $43a9
	add a, $bd ; $43aa
	ld l, a ; $43ac
	adc a, $43 ; $43ad
	sub a, l ; $43af
	ld h, a ; $43b0
	ld a, [hl+] ; $43b1
	ld h, [hl] ; $43b2
	ld l, a ; $43b3
	farcall FarPtr_InitDialogueTextCursor ; $43b4
	ld a, $03 ; $43b7
	farcall FarPtr_ScriptShowSpeakerDialogue ; $43b9
	ret ; $43bc
	; $43bd, 20 bytes (records:2)
	dw $14a9 ; record 0
	dw $14a9 ; record 1
	dw $14b3 ; record 2
	dw $14b3 ; record 3
	dw $14bd ; record 4
	dw $14be ; record 5
	dw $14cb ; record 6
	dw $14cc ; record 7
	dw $14db ; record 8
	dw $14db ; record 9
	ld a, [$c2b0] ; $43d1
	sra a ; $43d4
	add a, a ; $43d6
	add a, $ea ; $43d7
	ld l, a ; $43d9
	adc a, $43 ; $43da
	sub a, l ; $43dc
	ld h, a ; $43dd
	ld a, [hl+] ; $43de
	ld h, [hl] ; $43df
	ld l, a ; $43e0
	farcall FarPtr_InitDialogueTextCursor ; $43e1
	ld a, $04 ; $43e4
	farcall FarPtr_ScriptShowSpeakerDialogue ; $43e6
	ret ; $43e9
	; $43ea, 10 bytes (records:2)
	dw $14aa ; record 0
	dw $14b4 ; record 1
	dw $14bf ; record 2
	dw $14cd ; record 3
	dw $14dc ; record 4
	ld a, [$c2b0] ; $43f4
	add a, a ; $43f7
	add a, $0b ; $43f8
	ld l, a ; $43fa
	adc a, $44 ; $43fb
	sub a, l ; $43fd
	ld h, a ; $43fe
	ld a, [hl+] ; $43ff
	ld h, [hl] ; $4400
	ld l, a ; $4401
	farcall FarPtr_InitDialogueTextCursor ; $4402
	ld a, $05 ; $4405
	farcall FarPtr_ScriptShowSpeakerDialogue ; $4407
	ret ; $440a
	; $440b, 20 bytes (records:2)
	dw $14ab ; record 0
	dw $14ab ; record 1
	dw $14b5 ; record 2
	dw $14b5 ; record 3
	dw $14c0 ; record 4
	dw $14c1 ; record 5
	dw $14ce ; record 6
	dw $14cf ; record 7
	dw $14dd ; record 8
	dw $14dd ; record 9
	ld a, [$c2b0] ; $441f
	add a, a ; $4422
	add a, $36 ; $4423
	ld l, a ; $4425
	adc a, $44 ; $4426
	sub a, l ; $4428
	ld h, a ; $4429
	ld a, [hl+] ; $442a
	ld h, [hl] ; $442b
	ld l, a ; $442c
	farcall FarPtr_InitDialogueTextCursor ; $442d
	ld a, $06 ; $4430
	farcall FarPtr_ScriptShowSpeakerDialogue ; $4432
	ret ; $4435
	; $4436, 20 bytes (records:2)
	dw $14ac ; record 0
	dw $14ac ; record 1
	dw $14b6 ; record 2
	dw $14b6 ; record 3
	dw $14c2 ; record 4
	dw $14c2 ; record 5
	dw $14d0 ; record 6
	dw $14d1 ; record 7
	dw $14de ; record 8
	dw $14de ; record 9
	ld a, [$c2b0] ; $444a
	sra a ; $444d
	cp a, $03 ; $444f
	jr z, Label_0e_4471 ; $4451
	add a, a ; $4453
	add a, $67 ; $4454
	ld l, a ; $4456
	adc a, $44 ; $4457
	sub a, l ; $4459
	ld h, a ; $445a
	ld a, [hl+] ; $445b
	ld h, [hl] ; $445c
	ld l, a ; $445d
	farcall FarPtr_InitDialogueTextCursor ; $445e
	ld a, $07 ; $4461
	farcall FarPtr_ScriptShowSpeakerDialogue ; $4463
	ret ; $4466
	; $4467, 10 bytes (records:2)
	dw $14ad ; record 0
	dw $14b7 ; record 1
	dw $14c3 ; record 2
	dw $14d2 ; record 3
	dw $14df ; record 4
Label_0e_4471:
	ld hl, $14d2 ; $4471
	farcall FarPtr_InitDialogueTextCursor ; $4474
	ld a, $07 ; $4477
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $4479
	farcall FarPtr_RunDialogueYesNoPrompt ; $447c
	farcall FarPtr_ScriptCloseDialogueWindow ; $447f
	push af ; $4482
	ld a, $05 ; $4483
	farcall FarPtr_WaitScriptFrames ; $4485
	pop af ; $4488
	and a, a ; $4489
	jr z, Label_0e_448f ; $448a
	farcall FarPtr_AdvanceDialogueTextCursor ; $448c
Label_0e_448f:
	ld a, $07 ; $448f
	farcall FarPtr_ScriptShowSpeakerDialogue ; $4491
	ret ; $4494
	ld a, [$c2b0] ; $4495
	sra a ; $4498
	add a, a ; $449a
	add a, $ae ; $449b
	ld l, a ; $449d
	adc a, $44 ; $449e
	sub a, l ; $44a0
	ld h, a ; $44a1
	ld a, [hl+] ; $44a2
	ld h, [hl] ; $44a3
	ld l, a ; $44a4
	farcall FarPtr_InitDialogueTextCursor ; $44a5
	ld a, $08 ; $44a8
	farcall FarPtr_ScriptShowSpeakerDialogue ; $44aa
	ret ; $44ad
	; $44ae, 10 bytes (records:2)
	dw $14ae ; record 0
	dw $14b8 ; record 1
	dw $14c4 ; record 2
	dw $14d5 ; record 3
	dw $14e0 ; record 4
	ld a, [$c2b0] ; $44b8
	sra a ; $44bb
	add a, a ; $44bd
	add a, $d1 ; $44be
	ld l, a ; $44c0
	adc a, $44 ; $44c1
	sub a, l ; $44c3
	ld h, a ; $44c4
	ld a, [hl+] ; $44c5
	ld h, [hl] ; $44c6
	ld l, a ; $44c7
	farcall FarPtr_InitDialogueTextCursor ; $44c8
	ld a, $09 ; $44cb
	farcall FarPtr_ScriptShowSpeakerDialogue ; $44cd
	ret ; $44d0
	; $44d1, 10 bytes (records:2)
	dw $14af ; record 0
	dw $14b9 ; record 1
	dw $14c5 ; record 2
	dw $14d6 ; record 3
	dw $14e1 ; record 4
	ld a, [$c2b0] ; $44db
	add a, a ; $44de
	add a, $f2 ; $44df
	ld l, a ; $44e1
	adc a, $44 ; $44e2
	sub a, l ; $44e4
	ld h, a ; $44e5
	ld a, [hl+] ; $44e6
	ld h, [hl] ; $44e7
	ld l, a ; $44e8
	farcall FarPtr_InitDialogueTextCursor ; $44e9
	ld a, $0a ; $44ec
	farcall FarPtr_ScriptShowSpeakerDialogue ; $44ee
	ret ; $44f1
	; $44f2, 20 bytes (records:2)
	dw $14b0 ; record 0
	dw $14b0 ; record 1
	dw $14ba ; record 2
	dw $14ba ; record 3
	dw $14c6 ; record 4
	dw $14c7 ; record 5
	dw $14d7 ; record 6
	dw $14d7 ; record 7
	dw $14e2 ; record 8
	dw $14e3 ; record 9
	ld a, [$c2b0] ; $4506
	add a, a ; $4509
	add a, $1d ; $450a
	ld l, a ; $450c
	adc a, $45 ; $450d
	sub a, l ; $450f
	ld h, a ; $4510
	ld a, [hl+] ; $4511
	ld h, [hl] ; $4512
	ld l, a ; $4513
	farcall FarPtr_InitDialogueTextCursor ; $4514
	ld a, $0b ; $4517
	farcall FarPtr_ScriptShowSpeakerDialogue ; $4519
	ret ; $451c
	; $451d, 20 bytes (records:2)
	dw $14b1 ; record 0
	dw $14b1 ; record 1
	dw $14bb ; record 2
	dw $14bb ; record 3
	dw $14c8 ; record 4
	dw $14c8 ; record 5
	dw $14d8 ; record 6
	dw $14d9 ; record 7
	dw $14e4 ; record 8
	dw $14e5 ; record 9
	ld a, [$c2b0] ; $4531
	sra a ; $4534
	add a, a ; $4536
	add a, $4a ; $4537
	ld l, a ; $4539
	adc a, $45 ; $453a
	sub a, l ; $453c
	ld h, a ; $453d
	ld a, [hl+] ; $453e
	ld h, [hl] ; $453f
	ld l, a ; $4540
	farcall FarPtr_InitDialogueTextCursor ; $4541
	ld a, $0c ; $4544
	farcall FarPtr_ScriptShowSpeakerDialogue ; $4546
	ret ; $4549
	; $454a, 10 bytes (records:2)
	dw $14b2 ; record 0
	dw $14bc ; record 1
	dw $14c9 ; record 2
	dw $14da ; record 3
	dw $14e6 ; record 4
	; $4554, 89 bytes (records:8)
; 11 records x 8 bytes
	dw $ff03, $0000, $43a6, $0003 ; record 0
	dw $ff04, $0000, $43d1, $0003 ; record 1
	dw $ff05, $0000, $43f4, $0003 ; record 2
	dw $ff06, $0000, $441f, $0003 ; record 3
	dw $ff07, $0000, $444a, $0000 ; record 4
	dw $ff08, $0000, $4495, $0000 ; record 5
	dw $ff09, $0000, $44b8, $0000 ; record 6
	dw $ff0a, $0000, $44db, $0013 ; record 7
	dw $ff0b, $0000, $4506, $0010 ; record 8
	dw $ff0c, $0000, $4531, $0013 ; record 9
	dw $ff0d, $0000, $20e2, $0013 ; record 10
	db $ff
	; $45ad, 17 bytes (records:8)
; 2 records x 8 bytes
	dw $ff01, $0000, $45be, $0000 ; record 0
	dw $ff02, $0000, $45da, $0000 ; record 1
	db $ff
	ld a, $0b ; $45be
	ld [$c2b1], a ; $45c0
	ld bc, $0040 ; $45c3
	farcall FarPtr_0a_38 ; $45c6
	xor a, a ; $45c9
	ld bc, $0d00 ; $45ca
	ld de, $1300 ; $45cd
	farcall FarPtr_MovePlayerToPosition ; $45d0
	farcall FarPtr_WaitPlayerMoveDone ; $45d3
	call RunRepairCounterDialogue ; $45d6
	ret ; $45d9
	ld a, $0c ; $45da
	ld [$c2b1], a ; $45dc
	ld bc, $0040 ; $45df
	farcall FarPtr_0a_38 ; $45e2
	xor a, a ; $45e5
	ld bc, $0d00 ; $45e6
	ld de, $1300 ; $45e9
	farcall FarPtr_MovePlayerToPosition ; $45ec
	farcall FarPtr_WaitPlayerMoveDone ; $45ef
	call RunRepairCounterDialogue ; $45f2
	ret ; $45f5
	; $45f6, 17 bytes (records:8)
; 2 records x 8 bytes
	dw $4002, $0000, $4607, $0000 ; record 0
	dw $4003, $0000, $4610, $0000 ; record 1
	db $ff
	ld a, $02 ; $4607
	ld [$c294], a ; $4609
	ld [$c2a1], a ; $460c
	ret ; $460f
	ld a, $03 ; $4610
	ld [$c294], a ; $4612
	ld [$c2a1], a ; $4615
	ret ; $4618
	call ComputeTrainingGymProgressIndex ; $4619
	ld a, $07 ; $461c
	farcall FarPtr_GetActorStateAddr ; $461e
	ld a, $03 ; $4621
	ld e, l ; $4623
	ld d, h ; $4624
	ld hl, $0018 ; $4625
	add hl, de ; $4628
	ld [hl], a ; $4629
	ld a, $08 ; $462a
	farcall FarPtr_GetActorStateAddr ; $462c
	ld a, $03 ; $462f
	ld e, l ; $4631
	ld d, h ; $4632
	ld hl, $0018 ; $4633
	add hl, de ; $4636
	ld [hl], a ; $4637
	ld a, $09 ; $4638
	farcall FarPtr_GetActorStateAddr ; $463a
	ld a, $03 ; $463d
	ld e, l ; $463f
	ld d, h ; $4640
	ld hl, $0018 ; $4641
	add hl, de ; $4644
	ld [hl], a ; $4645
	ld a, $07 ; $4646
	ld d, $05 ; $4648
	farcall FarPtr_ScriptSetActorAnimation ; $464a
	ld a, $08 ; $464d
	ld d, $05 ; $464f
	farcall FarPtr_ScriptSetActorAnimation ; $4651
	ld a, $09 ; $4654
	ld d, $05 ; $4656
	farcall FarPtr_ScriptSetActorAnimation ; $4658
	call SetupGymActorsForProgress ; $465b
	ld a, [$c295] ; $465e
	cp a, $0b ; $4661
	jr nz, Label_0e_4669 ; $4663
	call RepairCounterReturnA ; $4665
	ret ; $4668
Label_0e_4669:
	cp a, $0c ; $4669
	jr nz, Label_0e_4671 ; $466b
	call RepairCounterReturnB ; $466d
	ret ; $4670
Label_0e_4671:
	cp a, $0d ; $4671
	jr nz, Label_0e_4679 ; $4673
	call RepairCounterChangedReturnA ; $4675
	ret ; $4678
Label_0e_4679:
	cp a, $0e ; $4679
	jr nz, Label_0e_4680 ; $467b
	call RepairCounterChangedReturnB ; $467d
Label_0e_4680:
	ret ; $4680
SetupGymActorsForProgress:
	ld a, [$c2b0] ; $4681
	sra a ; $4684
	cp a, $01 ; $4686
	jr z, Label_0e_4693 ; $4688
	cp a, $03 ; $468a
	jr z, Label_0e_46b9 ; $468c
	cp a, $04 ; $468e
	jr z, Label_0e_46e9 ; $4690
	ret ; $4692
Label_0e_4693:
	ld d, $34 ; $4693
	ld a, $04 ; $4695
	farcall FarPtr_GetActorStateAddr ; $4697
	ld c, l ; $469a
	ld b, h ; $469b
	farcall FarPtr_04_2c ; $469c
	ld a, $03 ; $469f
	ld d, $01 ; $46a1
	farcall FarPtr_ScriptSetActorAnimation ; $46a3
	ld a, $04 ; $46a6
	ld bc, $2700 ; $46a8
	ld de, $0f00 ; $46ab
	farcall FarPtr_ScriptSetActorPosition ; $46ae
	ld a, $04 ; $46b1
	ld b, $00 ; $46b3
	farcall FarPtr_SetActorFacing ; $46b5
	ret ; $46b8
Label_0e_46b9:
	ld a, $07 ; $46b9
	ld bc, $2900 ; $46bb
	ld de, $0700 ; $46be
	farcall FarPtr_ScriptSetActorPosition ; $46c1
	ld a, $08 ; $46c4
	ld bc, $2700 ; $46c6
	ld de, $0500 ; $46c9
	farcall FarPtr_ScriptSetActorPosition ; $46cc
	ld a, $09 ; $46cf
	ld bc, $2500 ; $46d1
	ld de, $0700 ; $46d4
	farcall FarPtr_ScriptSetActorPosition ; $46d7
	ld a, $07 ; $46da
	farcall FarPtr_GetActorStateAddr ; $46dc
	ld a, $01 ; $46df
	ld e, l ; $46e1
	ld d, h ; $46e2
	ld hl, $0018 ; $46e3
	add hl, de ; $46e6
	ld [hl], a ; $46e7
	ret ; $46e8
Label_0e_46e9:
	ld a, $07 ; $46e9
	ld bc, $2900 ; $46eb
	ld de, $0700 ; $46ee
	farcall FarPtr_ScriptSetActorPosition ; $46f1
	ld a, $08 ; $46f4
	ld bc, $2700 ; $46f6
	ld de, $0500 ; $46f9
	farcall FarPtr_ScriptSetActorPosition ; $46fc
	ld a, $09 ; $46ff
	ld bc, $2500 ; $4701
	ld de, $0700 ; $4704
	farcall FarPtr_ScriptSetActorPosition ; $4707
	ld a, $07 ; $470a
	ld d, $02 ; $470c
	farcall FarPtr_ScriptSetActorAnimation ; $470e
	ret ; $4711
	INCBIN "data/bank_00e/d_4712.bin" ; $4712, 1317 bytes
	ld a, $0c ; $4c37
	farcall FarPtr_GetActorStateAddr ; $4c39
	ld c, l ; $4c3c
	ld b, h ; $4c3d
	ld hl, $000e ; $4c3e
	add hl, bc ; $4c41
	ld a, [hl+] ; $4c42
	ld d, [hl] ; $4c43
	ld e, a ; $4c44
	ld hl, wWaterSpriteMinigameTimer ; $4c45
	ld a, e ; $4c48
	ld [hl+], a ; $4c49
	ld [hl], d ; $4c4a
	ld hl, $000c ; $4c4b
	add hl, bc ; $4c4e
	ld a, [hl+] ; $4c4f
	ld d, [hl] ; $4c50
	ld e, a ; $4c51
	ld hl, $c2b2 ; $4c52
	ld a, e ; $4c55
	ld [hl+], a ; $4c56
	ld [hl], d ; $4c57
	ld a, $0a ; $4c58
	farcall FarPtr_GetActorStateAddr ; $4c5a
	ld c, l ; $4c5d
	ld b, h ; $4c5e
	ld hl, $000a ; $4c5f
	add hl, bc ; $4c62
	ld a, [hl+] ; $4c63
	ld d, [hl] ; $4c64
	ld e, a ; $4c65
	ld hl, $c2b8 ; $4c66
	ld a, e ; $4c69
	ld [hl+], a ; $4c6a
	ld [hl], d ; $4c6b
	ld hl, $0008 ; $4c6c
	add hl, bc ; $4c6f
	ld a, [hl+] ; $4c70
	ld d, [hl] ; $4c71
	ld e, a ; $4c72
	ld hl, wWaterSpriteMinigameSwingCount ; $4c73
	ld a, e ; $4c76
	ld [hl+], a ; $4c77
	ld [hl], d ; $4c78
	jp Label_0e_4d3c ; $4c79
	ld a, $0a ; $4c7c
	farcall FarPtr_GetActorStateAddr ; $4c7e
	ld c, l ; $4c81
	ld b, h ; $4c82
	ld hl, $0005 ; $4c83
	add hl, bc ; $4c86
	res 0, [hl] ; $4c87
	ld b, $00 ; $4c89
	ld a, $00 ; $4c8b
	ret ; $4c8d
	ld a, $0a ; $4c8e
	farcall FarPtr_GetActorStateAddr ; $4c90
	ld c, l ; $4c93
	ld b, h ; $4c94
	ld hl, $000e ; $4c95
	add hl, bc ; $4c98
	ld a, [hl+] ; $4c99
	ld d, [hl] ; $4c9a
	ld e, a ; $4c9b
	ld hl, wWaterSpriteMinigameTimer ; $4c9c
	ld a, e ; $4c9f
	ld [hl+], a ; $4ca0
	ld [hl], d ; $4ca1
	ld hl, $000c ; $4ca2
	add hl, bc ; $4ca5
	ld a, [hl+] ; $4ca6
	ld d, [hl] ; $4ca7
	ld e, a ; $4ca8
	ld hl, $c2b2 ; $4ca9
	ld a, e ; $4cac
	ld [hl+], a ; $4cad
	ld [hl], d ; $4cae
	ld a, $0b ; $4caf
	farcall FarPtr_GetActorStateAddr ; $4cb1
	ld c, l ; $4cb4
	ld b, h ; $4cb5
	ld hl, $000a ; $4cb6
	add hl, bc ; $4cb9
	ld a, [hl+] ; $4cba
	ld d, [hl] ; $4cbb
	ld e, a ; $4cbc
	ld hl, $c2b8 ; $4cbd
	ld a, e ; $4cc0
	ld [hl+], a ; $4cc1
	ld [hl], d ; $4cc2
	ld hl, $0008 ; $4cc3
	add hl, bc ; $4cc6
	ld a, [hl+] ; $4cc7
	ld d, [hl] ; $4cc8
	ld e, a ; $4cc9
	ld hl, wWaterSpriteMinigameSwingCount ; $4cca
	ld a, e ; $4ccd
	ld [hl+], a ; $4cce
	ld [hl], d ; $4ccf
	jp Label_0e_4d3c ; $4cd0
	ld a, $0b ; $4cd3
	farcall FarPtr_GetActorStateAddr ; $4cd5
	ld c, l ; $4cd8
	ld b, h ; $4cd9
	ld hl, $0005 ; $4cda
	add hl, bc ; $4cdd
	res 0, [hl] ; $4cde
	ld b, $00 ; $4ce0
	ld a, $00 ; $4ce2
	ret ; $4ce4
	ld a, $0b ; $4ce5
	farcall FarPtr_GetActorStateAddr ; $4ce7
	ld c, l ; $4cea
	ld b, h ; $4ceb
	ld hl, $000e ; $4cec
	add hl, bc ; $4cef
	ld a, [hl+] ; $4cf0
	ld d, [hl] ; $4cf1
	ld e, a ; $4cf2
	ld hl, wWaterSpriteMinigameTimer ; $4cf3
	ld a, e ; $4cf6
	ld [hl+], a ; $4cf7
	ld [hl], d ; $4cf8
	ld hl, $000c ; $4cf9
	add hl, bc ; $4cfc
	ld a, [hl+] ; $4cfd
	ld d, [hl] ; $4cfe
	ld e, a ; $4cff
	ld hl, $c2b2 ; $4d00
	ld a, e ; $4d03
	ld [hl+], a ; $4d04
	ld [hl], d ; $4d05
	ld a, $0c ; $4d06
	farcall FarPtr_GetActorStateAddr ; $4d08
	ld c, l ; $4d0b
	ld b, h ; $4d0c
	ld hl, $000a ; $4d0d
	add hl, bc ; $4d10
	ld a, [hl+] ; $4d11
	ld d, [hl] ; $4d12
	ld e, a ; $4d13
	ld hl, $c2b8 ; $4d14
	ld a, e ; $4d17
	ld [hl+], a ; $4d18
	ld [hl], d ; $4d19
	ld hl, $0008 ; $4d1a
	add hl, bc ; $4d1d
	ld a, [hl+] ; $4d1e
	ld d, [hl] ; $4d1f
	ld e, a ; $4d20
	ld hl, wWaterSpriteMinigameSwingCount ; $4d21
	ld a, e ; $4d24
	ld [hl+], a ; $4d25
	ld [hl], d ; $4d26
	jp Label_0e_4d3c ; $4d27
	ld a, $0c ; $4d2a
	farcall FarPtr_GetActorStateAddr ; $4d2c
	ld c, l ; $4d2f
	ld b, h ; $4d30
	ld hl, $0005 ; $4d31
	add hl, bc ; $4d34
	res 0, [hl] ; $4d35
	ld b, $00 ; $4d37
	ld a, $00 ; $4d39
	ret ; $4d3b
Label_0e_4d3c:
	ld hl, wWaterSpriteMinigameTimer ; $4d3c
	ld a, [hl+] ; $4d3f
	ld d, [hl] ; $4d40
	ld e, a ; $4d41
	ld hl, $c2b8 ; $4d42
	ld a, [hl+] ; $4d45
	ld h, [hl] ; $4d46
	ld l, a ; $4d47
	ld a, l ; $4d48
	sub a, e ; $4d49
	ld l, a ; $4d4a
	ld a, h ; $4d4b
	sbc a, d ; $4d4c
	ld h, a ; $4d4d
	bit 7, h ; $4d4e
	jr z, Label_0e_4d58 ; $4d50
	xor a, a ; $4d52
	sub a, l ; $4d53
	ld l, a ; $4d54
	sbc a, a ; $4d55
	sub a, h ; $4d56
	ld h, a ; $4d57
Label_0e_4d58:
	ld a, h ; $4d58
	cp a, $05 ; $4d59
	jr nc, Label_0e_4d83 ; $4d5b
	ld hl, $c2b2 ; $4d5d
	ld a, [hl+] ; $4d60
	ld d, [hl] ; $4d61
	ld e, a ; $4d62
	ld hl, wWaterSpriteMinigameSwingCount ; $4d63
	ld a, [hl+] ; $4d66
	ld h, [hl] ; $4d67
	ld l, a ; $4d68
	ld a, l ; $4d69
	sub a, e ; $4d6a
	ld l, a ; $4d6b
	ld a, h ; $4d6c
	sbc a, d ; $4d6d
	ld h, a ; $4d6e
	bit 7, h ; $4d6f
	jr z, Label_0e_4d79 ; $4d71
	xor a, a ; $4d73
	sub a, l ; $4d74
	ld l, a ; $4d75
	sbc a, a ; $4d76
	sub a, h ; $4d77
	ld h, a ; $4d78
Label_0e_4d79:
	ld a, h ; $4d79
	cp a, $05 ; $4d7a
	jr nc, Label_0e_4d83 ; $4d7c
	ld b, $01 ; $4d7e
	ld a, $01 ; $4d80
	ret ; $4d82
Label_0e_4d83:
	ld b, $00 ; $4d83
	ld a, $00 ; $4d85
	ret ; $4d87
RunRepairCounterDialogue:
	ld a, $00 ; $4d88
	ld b, a ; $4d8a
	ld a, $0e ; $4d8b
	farcall FarPtr_FaceActorTowardActor ; $4d8d
	test_flag $0a, 3 ; $4d90
	jp z, Label_0e_4da5 ; $4d93
	test_flag $0a, 7 ; $4d96
	jp z, Label_0e_4e0d ; $4d99
	test_flag $0b, 0 ; $4d9c
	jp z, Label_0e_4de5 ; $4d9f
	jp Label_0e_4de5 ; $4da2
Label_0e_4da5:
	test_flag $05, 7 ; $4da5
	jr nz, Label_0e_4dcd ; $4da8
	test_flag $0f, 6 ; $4daa
	jr z, Label_0e_4db7 ; $4dad
	ld hl, $20e4 ; $4daf
	farcall FarPtr_InitDialogueTextCursor ; $4db2
	jr Label_0e_4dc0 ; $4db5
Label_0e_4db7:
	ld hl, $20e3 ; $4db7
	farcall FarPtr_InitDialogueTextCursor ; $4dba
	set_flag $0f, 6 ; $4dbd
Label_0e_4dc0:
	ld a, $0e ; $4dc0
	farcall FarPtr_ScriptShowSpeakerDialogue ; $4dc2
	ld a, $0e ; $4dc5
	ld b, $00 ; $4dc7
	farcall FarPtr_SetActorFacing ; $4dc9
	ret ; $4dcc
Label_0e_4dcd:
	test_flag $0f, 6 ; $4dcd
	jr z, Label_0e_4dda ; $4dd0
	ld hl, $20e6 ; $4dd2
	farcall FarPtr_InitDialogueTextCursor ; $4dd5
	jr Label_0e_4dc0 ; $4dd8
Label_0e_4dda:
	ld hl, $20e5 ; $4dda
	farcall FarPtr_InitDialogueTextCursor ; $4ddd
	set_flag $0f, 6 ; $4de0
	jr Label_0e_4dc0 ; $4de3
Label_0e_4de5:
	set_flag $0c, 1 ; $4de5
	set_flag $0c, 2 ; $4de8
	set_flag $0d, 0 ; $4deb
	ld hl, $20e9 ; $4dee
	farcall FarPtr_InitDialogueTextCursor ; $4df1
	jr Label_0e_4e26 ; $4df4
	set_flag $0c, 1 ; $4df6
	set_flag $0c, 2 ; $4df9
	set_flag $0d, 0 ; $4dfc
	set_flag $0c, 3 ; $4dff
	set_flag $0c, 7 ; $4e02
	ld hl, $20e9 ; $4e05
	farcall FarPtr_InitDialogueTextCursor ; $4e08
	jr Label_0e_4e26 ; $4e0b
Label_0e_4e0d:
	set_flag $0c, 1 ; $4e0d
	test_flag $0f, 7 ; $4e10
	jr z, Label_0e_4e1d ; $4e13
	ld hl, $20e9 ; $4e15
	farcall FarPtr_InitDialogueTextCursor ; $4e18
	jr Label_0e_4e26 ; $4e1b
Label_0e_4e1d:
	ld hl, $20e7 ; $4e1d
	farcall FarPtr_InitDialogueTextCursor ; $4e20
	set_flag $0f, 7 ; $4e23
Label_0e_4e26:
	ld a, $00 ; $4e26
	ld b, a ; $4e28
	ld a, $0e ; $4e29
	farcall FarPtr_FaceActorTowardActor ; $4e2b
	ld a, $0e ; $4e2e
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $4e30
	farcall FarPtr_RunDialogueYesNoPrompt ; $4e33
	farcall FarPtr_ScriptCloseDialogueWindow ; $4e36
	push af ; $4e39
	ld a, $05 ; $4e3a
	farcall FarPtr_WaitScriptFrames ; $4e3c
	pop af ; $4e3f
	and a, a ; $4e40
	jr z, Label_0e_4e4f ; $4e41
RepairCounterFarewell:
	ld hl, $20ea ; $4e43
	farcall FarPtr_InitDialogueTextCursor ; $4e46
	ld a, $0e ; $4e49
	farcall FarPtr_ScriptShowSpeakerDialogue ; $4e4b
	ret ; $4e4e
Label_0e_4e4f:
	ld hl, $20eb ; $4e4f
	farcall FarPtr_InitDialogueTextCursor ; $4e52
	ld a, $0e ; $4e55
	farcall FarPtr_ScriptShowSpeakerDialogue ; $4e57
	push af ; $4e5a
	ld a, $05 ; $4e5b
	farcall FarPtr_WaitScriptFrames ; $4e5d
	pop af ; $4e60
RepairCounterServiceMenu:
	ld hl, $20ec ; $4e61
	ld de, $0101 ; $4e64
	farcall FarPtr_RunMenuFromText ; $4e67
Label_0e_4e6a:
	ld [$c2bc], a ; $4e6a
	cp a, $ff ; $4e6d
	jp z, RepairCounterFarewell ; $4e6f
	cp a, $02 ; $4e72
	jp z, RepairCounterFarewell ; $4e74
	cp a, $00 ; $4e77
	jp z, RepairCounterChangeRackets ; $4e79
	test_flag $0a, 7 ; $4e7c
	jp nz, RepairCounterChangeShoes ; $4e7f
	ld hl, $20e8 ; $4e82
	farcall FarPtr_InitDialogueTextCursor ; $4e85
	ld a, $0e ; $4e88
	farcall FarPtr_ScriptShowSpeakerDialogue ; $4e8a
	ld hl, $20f2 ; $4e8d
	farcall FarPtr_InitDialogueTextCursor ; $4e90
	ld a, $0e ; $4e93
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $4e95
	farcall FarPtr_RunDialogueYesNoPrompt ; $4e98
	farcall FarPtr_ScriptCloseDialogueWindow ; $4e9b
	push af ; $4e9e
	ld a, $05 ; $4e9f
	farcall FarPtr_WaitScriptFrames ; $4ea1
	pop af ; $4ea4
	and a, a ; $4ea5
	jr z, RepairCounterServiceMenu ; $4ea6
	jr RepairCounterFarewell ; $4ea8
	ld a, $0e ; $4eaa
	ld b, $00 ; $4eac
	farcall FarPtr_SetActorFacing ; $4eae
	ret ; $4eb1
PrepareEquipmentSelectScreen:
	ld a, [wEquippedRacket] ; $4eb2
	ld [wWaterSpriteMinigameFlag], a ; $4eb5
	ld a, $11 ; $4eb8
	ld [wStoryModeCurrentLocation], a ; $4eba
	ld a, [$c2b1] ; $4ebd
	ld [$c295], a ; $4ec0
	ld a, $ff ; $4ec3
	ld [$c294], a ; $4ec5
	ld [$c2a1], a ; $4ec8
	ld c, $10 ; $4ecb
	call BeginFadeOut ; $4ecd
	call WaitFadeEnd ; $4ed0
	call ClearFrameTasks ; $4ed3
	call DisableLCDSafely ; $4ed6
	farcall FarPtr_01_0a ; $4ed9
	xor a, a ; $4edc
	ldh [hBGColumnBlitPending], a ; $4edd
	ldh [hBGRowBlitPending], a ; $4edf
	ldh [hScrollY], a ; $4ee1
	ldh [hScrollX], a ; $4ee3
	ld [$c321], a ; $4ee5
	ret ; $4ee8
RepairCounterChangeRackets:
	ld hl, $20ed ; $4ee9
	farcall FarPtr_InitDialogueTextCursor ; $4eec
	ld a, $0e ; $4eef
	farcall FarPtr_ScriptShowSpeakerDialogue ; $4ef1
	call PrepareEquipmentSelectScreen ; $4ef4
	farcall FarPtr_3e_0c ; $4ef7
	and a, a ; $4efa
	jr nz, Label_0e_4f1d ; $4efb
	jr RestoreScreenAfterEquipSelect ; $4efd
RepairCounterChangeShoes:
	ld hl, $20ee ; $4eff
	farcall FarPtr_InitDialogueTextCursor ; $4f02
	ld a, $0e ; $4f05
	farcall FarPtr_ScriptShowSpeakerDialogue ; $4f07
	call PrepareEquipmentSelectScreen ; $4f0a
	farcall FarPtr_3e_0e ; $4f0d
	and a, a ; $4f10
	jr nz, Label_0e_4f1d ; $4f11
RestoreScreenAfterEquipSelect:
	call DisableLCDSafely ; $4f13
	farcall FarPtr_01_0a ; $4f16
	call EnableLCD ; $4f19
	ret ; $4f1c
Label_0e_4f1d:
	ld a, [$c2b1] ; $4f1d
	add a, $02 ; $4f20
	ld [$c2b1], a ; $4f22
	ld a, $11 ; $4f25
	ld [wStoryModeCurrentLocation], a ; $4f27
	ld a, [$c2b1] ; $4f2a
	ld [$c295], a ; $4f2d
	ld a, $ff ; $4f30
	ld [$c294], a ; $4f32
	ld [$c2a1], a ; $4f35
	call RestoreScreenAfterEquipSelect ; $4f38
	ret ; $4f3b
FetchAndPushShortTextArg:
	ldh a, [hWramBank] ; $4f3c
	push af ; $4f3e
	wram_bank $07 ; $4f3f
	ld de, $df00 ; $4f45
	wram_bank $05 ; $4f48
	farcall FarPtr_FetchShortTextToBuffer ; $4f4e
	ld hl, $df00 ; $4f51
	farcall FarPtr_PushTextArgString ; $4f54
	pop af ; $4f57
	wram_bank ; $4f58
	ret ; $4f5c
GetEquippedRacketNibble:
	ld a, [$c2bc] ; $4f5d
	and a, a ; $4f60
	jr z, Label_0e_4f65 ; $4f61
	jr Label_0e_4f6b ; $4f63
Label_0e_4f65:
	ld a, [wEquippedRacket] ; $4f65
	and a, $0f ; $4f68
	ret ; $4f6a
Label_0e_4f6b:
	ld a, [wEquippedRacket] ; $4f6b
	and a, $f0 ; $4f6e
	swap a ; $4f70
	ret ; $4f72
PushEquipmentNameTextArg:
	ld a, [$c2bc] ; $4f73
	and a, a ; $4f76
	jr z, Label_0e_4f7b ; $4f77
	jr Label_0e_4f8a ; $4f79
Label_0e_4f7b:
	call GetEquippedRacketNibble ; $4f7b
	ld hl, $00e5 ; $4f7e
	add a, l ; $4f81
	ld l, a ; $4f82
	jr nc, Label_0e_4f86 ; $4f83
	inc h ; $4f85
Label_0e_4f86:
	call FetchAndPushShortTextArg ; $4f86
	ret ; $4f89
Label_0e_4f8a:
	call GetEquippedRacketNibble ; $4f8a
	ld hl, $00f4 ; $4f8d
	add a, l ; $4f90
	ld l, a ; $4f91
	jr nc, Label_0e_4f95 ; $4f92
	inc h ; $4f94
Label_0e_4f95:
	call FetchAndPushShortTextArg ; $4f95
	ret ; $4f98
InitEquipmentHandoutDialogue:
	ld a, [$c2bc] ; $4f99
	and a, a ; $4f9c
	jr z, Label_0e_4fa1 ; $4f9d
	jr Label_0e_4fb0 ; $4f9f
Label_0e_4fa1:
	call GetEquippedRacketNibble ; $4fa1
	ld hl, $2403 ; $4fa4
	add a, l ; $4fa7
	ld l, a ; $4fa8
	jr nc, Label_0e_4fac ; $4fa9
	inc h ; $4fab
Label_0e_4fac:
	farcall FarPtr_InitDialogueTextCursor ; $4fac
	ret ; $4faf
Label_0e_4fb0:
	call GetEquippedRacketNibble ; $4fb0
	ld hl, $240a ; $4fb3
	add a, l ; $4fb6
	ld l, a ; $4fb7
	jr nc, Label_0e_4fbb ; $4fb8
	inc h ; $4fba
Label_0e_4fbb:
	farcall FarPtr_InitDialogueTextCursor ; $4fbb
	ret ; $4fbe
RepairCounterReturnA:
	ld a, $0b ; $4fbf
	ld [$c2b1], a ; $4fc1
	ld a, $00 ; $4fc4
	ld b, a ; $4fc6
	ld a, $0e ; $4fc7
	farcall FarPtr_FaceActorTowardActor ; $4fc9
	ld a, $02 ; $4fcc
	ld bc, $0f00 ; $4fce
	ld de, $0f00 ; $4fd1
	farcall FarPtr_ScriptSetActorPosition ; $4fd4
	jp RepairCounterCheckEquipChanged ; $4fd7
	ret ; $4fda
RepairCounterReturnB:
	ld a, $0c ; $4fdb
	ld [$c2b1], a ; $4fdd
	farcall FarPtr_WaitPlayerMoveDone ; $4fe0
	ld bc, $00f0 ; $4fe3
	farcall FarPtr_0a_38 ; $4fe6
	xor a, a ; $4fe9
	ld bc, $0d00 ; $4fea
	ld de, $1100 ; $4fed
	farcall FarPtr_MovePlayerToPosition ; $4ff0
	farcall FarPtr_WaitPlayerMoveDone ; $4ff3
	ld a, $02 ; $4ff6
	ld bc, $1300 ; $4ff8
	ld de, $1300 ; $4ffb
	farcall FarPtr_ScriptSetActorPosition ; $4ffe
	jp RepairCounterCheckEquipChanged ; $5001
	ret ; $5004
CompareEquippedRacketToMinigameFlag:
	ld a, [wWaterSpriteMinigameFlag] ; $5005
	ld b, a ; $5008
	ld a, [wEquippedRacket] ; $5009
	cp a, b ; $500c
	jr z, Label_0e_5012 ; $500d
	ld a, $00 ; $500f
	ret ; $5011
Label_0e_5012:
	ld a, $ff ; $5012
	ret ; $5014
RepairCounterCheckEquipChanged:
	xor a, a ; $5015
	ld [$c2d5], a ; $5016
	ld c, $08 ; $5019
	call BeginFadeIn ; $501b
	call WaitFadeEnd ; $501e
	call CompareEquippedRacketToMinigameFlag ; $5021
	cp a, $ff ; $5024
	jp nz, Label_0e_5056 ; $5026
	ld a, [$c2bc] ; $5029
	ld hl, $2401 ; $502c
	add a, l ; $502f
	ld l, a ; $5030
	jr nc, Label_0e_5034 ; $5031
	inc h ; $5033
Label_0e_5034:
	farcall FarPtr_InitDialogueTextCursor ; $5034
	call PushEquipmentNameTextArg ; $5037
	ld a, $0e ; $503a
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $503c
	farcall FarPtr_RunDialogueYesNoPrompt ; $503f
	farcall FarPtr_ScriptCloseDialogueWindow ; $5042
	push af ; $5045
	ld a, $05 ; $5046
	farcall FarPtr_WaitScriptFrames ; $5048
	pop af ; $504b
	and a, a ; $504c
	jp nz, Label_0e_5080 ; $504d
	ld a, [$c2bc] ; $5050
	jp Label_0e_4e6a ; $5053
Label_0e_5056:
	ld a, [wEquippedRacket] ; $5056
	ld [wWaterSpriteMinigameFlag], a ; $5059
	call InitEquipmentHandoutDialogue ; $505c
	ld a, $0e ; $505f
	farcall FarPtr_ScriptShowSpeakerDialogue ; $5061
	call ShowEquipChangeConfirmation ; $5064
	set_flag $0f, 7 ; $5067
	ld a, $00 ; $506a
	ld b, a ; $506c
	ld a, $0e ; $506d
	farcall FarPtr_FaceActorTowardActor ; $506f
	ld hl, $20f1 ; $5072
	farcall FarPtr_InitDialogueTextCursor ; $5075
	call PushEquipmentNameTextArg ; $5078
	ld a, $0e ; $507b
	farcall FarPtr_ScriptShowSpeakerDialogue ; $507d
Label_0e_5080:
	ld hl, $20f2 ; $5080
	farcall FarPtr_InitDialogueTextCursor ; $5083
	ld a, $0e ; $5086
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $5088
	farcall FarPtr_RunDialogueYesNoPrompt ; $508b
	farcall FarPtr_ScriptCloseDialogueWindow ; $508e
	push af ; $5091
	ld a, $05 ; $5092
	farcall FarPtr_WaitScriptFrames ; $5094
	pop af ; $5097
	and a, a ; $5098
	jp z, RepairCounterServiceMenu ; $5099
	jp RepairCounterFarewell ; $509c
RepairCounterChangedReturnA:
	ld a, $0b ; $509f
	ld [$c2b1], a ; $50a1
	ld a, $02 ; $50a4
	ld bc, $0f00 ; $50a6
	ld de, $0f00 ; $50a9
	farcall FarPtr_ScriptSetActorPosition ; $50ac
	jp RepairCounterReopenServiceMenu ; $50af
	ret ; $50b2
RepairCounterChangedReturnB:
	ld a, $0c ; $50b3
	ld [$c2b1], a ; $50b5
	farcall FarPtr_WaitPlayerMoveDone ; $50b8
	ld bc, $00f0 ; $50bb
	farcall FarPtr_0a_38 ; $50be
	xor a, a ; $50c1
	ld bc, $0d00 ; $50c2
	ld de, $1300 ; $50c5
	farcall FarPtr_MovePlayerToPosition ; $50c8
	farcall FarPtr_WaitPlayerMoveDone ; $50cb
	ld a, $02 ; $50ce
	ld bc, $1300 ; $50d0
	ld de, $1300 ; $50d3
	farcall FarPtr_ScriptSetActorPosition ; $50d6
	jp RepairCounterReopenServiceMenu ; $50d9
	ret ; $50dc
RepairCounterReopenServiceMenu:
	xor a, a ; $50dd
	ld [$c2d5], a ; $50de
	ld hl, $20ef ; $50e1
	farcall FarPtr_InitDialogueTextCursor ; $50e4
	ld hl, $00e6 ; $50e7
	call FetchAndPushShortTextArg ; $50ea
	set_flag $0f, 7 ; $50ed
	ld a, $00 ; $50f0
	ld b, a ; $50f2
	ld a, $0e ; $50f3
	farcall FarPtr_FaceActorTowardActor ; $50f5
	ld c, $08 ; $50f8
	call BeginFadeIn ; $50fa
	call WaitFadeEnd ; $50fd
	ld hl, $20ec ; $5100
	ld de, $0101 ; $5103
	farcall FarPtr_RunMenuFromText ; $5106
	ld [$c2bc], a ; $5109
	cp a, $ff ; $510c
	jp z, RepairCounterFarewell ; $510e
	cp a, $02 ; $5111
	jp z, RepairCounterFarewell ; $5113
	cp a, $00 ; $5116
	jp z, RepairCounterChangeRackets ; $5118
	test_flag $0a, 7 ; $511b
	jp nz, RepairCounterChangeShoes ; $511e
	ld hl, $20e8 ; $5121
	farcall FarPtr_InitDialogueTextCursor ; $5124
	ld a, $0e ; $5127
	farcall FarPtr_ScriptShowSpeakerDialogue ; $5129
	ld hl, $20f2 ; $512c
	farcall FarPtr_InitDialogueTextCursor ; $512f
	ld a, $0e ; $5132
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $5134
	farcall FarPtr_RunDialogueYesNoPrompt ; $5137
	farcall FarPtr_ScriptCloseDialogueWindow ; $513a
	push af ; $513d
	ld a, $05 ; $513e
	farcall FarPtr_WaitScriptFrames ; $5140
	pop af ; $5143
	and a, a ; $5144
	jp z, RepairCounterServiceMenu ; $5145
	jp RepairCounterFarewell ; $5148
	ld a, $0e ; $514b
	ld b, $00 ; $514d
	farcall FarPtr_SetActorFacing ; $514f
	ret ; $5152
ShowEquipChangeConfirmation:
	ld a, [$c2bc] ; $5153
	ld hl, $20ef ; $5156
	add a, l ; $5159
	ld l, a ; $515a
	jr nc, Label_0e_515e ; $515b
	inc h ; $515d
Label_0e_515e:
	farcall FarPtr_InitDialogueTextCursor ; $515e
	call PushEquipmentNameTextArg ; $5161
	ld a, [$c2bc] ; $5164
	and a, a ; $5167
	jr nz, Label_0e_51a3 ; $5168
	call Func_0e_520f ; $516a
	ld a, $00 ; $516d
	ld d, $09 ; $516f
	farcall FarPtr_ScriptSetActorAnimation ; $5171
	ld a, $00 ; $5174
	ld b, $40 ; $5176
	farcall FarPtr_SetActorFacing ; $5178
	ldh a, [hRomBank] ; $517b
	ld b, a ; $517d
	ld a, $00 ; $517e
	ld de, $51d7 ; $5180
	farcall FarPtr_0a_1a ; $5183
	ld a, $8c ; $5186
	farcall FarPtr_ScriptShowSpeakerDialogue ; $5188
	ld a, $00 ; $518b
	farcall FarPtr_0a_1c ; $518d
	ld a, $00 ; $5190
	ld d, $01 ; $5192
	farcall FarPtr_ScriptSetActorAnimation ; $5194
	ld a, $0e ; $5197
	ld b, a ; $5199
	ld a, $00 ; $519a
	farcall FarPtr_FaceActorTowardActor ; $519c
	call Func_0e_520f ; $519f
	ret ; $51a2
Label_0e_51a3:
	ld a, $00 ; $51a3
	ld b, $40 ; $51a5
	farcall FarPtr_SetActorFacing ; $51a7
	ldh a, [hRomBank] ; $51aa
	ld b, a ; $51ac
	ld a, $00 ; $51ad
	ld de, $51e4 ; $51af
	farcall FarPtr_0a_1a ; $51b2
	ld a, $8c ; $51b5
	farcall FarPtr_ScriptShowSpeakerDialogue ; $51b7
	ld a, $00 ; $51ba
	farcall FarPtr_0a_1c ; $51bc
	ld a, $00 ; $51bf
	ld d, $01 ; $51c1
	farcall FarPtr_ScriptSetActorAnimation ; $51c3
	ld a, $00 ; $51c6
	ld bc, $0020 ; $51c8
	farcall FarPtr_0a_18 ; $51cb
	ld a, $0e ; $51ce
	ld b, a ; $51d0
	ld a, $00 ; $51d1
	farcall FarPtr_FaceActorTowardActor ; $51d3
	ret ; $51d6
	INCBIN "data/bank_00e/d_51d7.bin" ; $51d7, 56 bytes
Func_0e_520f:
	ld a, [$c90e] ; $520f
	and a, a ; $5212
	jr z, Label_0e_5224 ; $5213
	ld a, $00 ; $5215
	farcall FarPtr_GetActorStateAddr ; $5217
	ld c, l ; $521a
	ld b, h ; $521b
	ld hl, $0037 ; $521c
	add hl, bc ; $521f
	ld a, [hl] ; $5220
	xor a, $20 ; $5221
	ld [hl], a ; $5223
Label_0e_5224:
	ret ; $5224
	INCBIN "data/bank_00e/d_5225.bin" ; $5225, 35 bytes
MarioWorldMapScripts_0e:
	; $5248, 14 bytes (records:2)
	dw $535c ; record 0
	dw $5385 ; record 1
	dw $5256 ; record 2
	dw $544e ; record 3
	dw $54cf ; record 4
	dw $54d0 ; record 5
	dw $54d2 ; record 6
	; $5256, 262 bytes (bytes:14)
	db $00, $00, $6e, $7c, $00, $15, $00, $3d, $00, $00, $4c, $01, $00, $00 ; 0x00
	db $00, $00, $6e, $7c, $00, $15, $00, $3d, $00, $00, $53, $01, $00, $00 ; 0x0e
	db $00, $00, $6e, $7c, $00, $15, $00, $3d, $00, $00, $53, $01, $00, $00 ; 0x1c
	db $00, $00, $6e, $7c, $00, $15, $00, $3d, $00, $00, $53, $01, $00, $00 ; 0x2a
	db $00, $00, $6e, $7c, $00, $15, $00, $3d, $00, $00, $4e, $01, $00, $00 ; 0x38
	db $00, $00, $6e, $7c, $00, $12, $00, $13, $40, $00, $2e, $01, $00, $00 ; 0x46
	db $00, $00, $6e, $7c, $00, $18, $00, $12, $40, $00, $2c, $01, $00, $00 ; 0x54
	db $00, $00, $6e, $7c, $00, $18, $40, $0f, $40, $00, $6f, $01, $00, $00 ; 0x62
	db $00, $00, $6e, $7c, $00, $18, $00, $0d, $40, $00, $6d, $01, $00, $00 ; 0x70
	db $00, $00, $6e, $7c, $00, $17, $00, $14, $40, $00, $6e, $01, $00, $00 ; 0x7e
	db $00, $00, $6e, $7c, $00, $0a, $00, $0f, $40, $00, $73, $01, $00, $00 ; 0x8c
	db $00, $00, $6e, $7c, $00, $0c, $00, $11, $40, $00, $2b, $01, $00, $00 ; 0x9a
	db $00, $00, $6e, $7c, $00, $0c, $00, $0f, $40, $00, $2d, $01, $00, $00 ; 0xa8
	db $00, $00, $6e, $7c, $00, $0c, $00, $0d, $40, $00, $48, $01, $00, $00 ; 0xb6
	db $00, $00, $6e, $7c, $00, $0e, $00, $0b, $40, $00, $72, $01, $00, $00 ; 0xc4
	db $00, $00, $6e, $7c, $00, $16, $00, $0b, $40, $00, $2a, $01, $00, $00 ; 0xd2
	db $00, $00, $6e, $7c, $00, $0f, $00, $1f, $40, $00, $70, $01, $00, $00 ; 0xe0
	db $00, $00, $6e, $7c, $00, $15, $00, $1f, $40, $00, $71, $01, $00, $00 ; 0xee
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $ff ; 0xfc
	; $535c, 41 bytes (bytes:16)
	db $01, $c0, $00, $12, $00, $21, $00, $00, $02, $40, $00, $1b, $00, $0b, $00, $00 ; 0x00
	db $0a, $c0, $00, $12, $00, $08, $00, $00, $0e, $c0, $00, $12, $00, $0f, $00, $00 ; 0x10
	db $0f, $c0, $00, $12, $00, $08, $00, $00, $ff ; 0x20
	; $5385, 9 bytes (records:8)
; 1 records x 8 bytes
	dw $ff01, $0000, $7c96, $0e1b ; record 0
	db $ff
	ld hl, $308e ; $538e
	farcall FarPtr_InitDialogueTextCursor ; $5391
	ld a, $12 ; $5394
	farcall FarPtr_ScriptShowSpeakerDialogue ; $5396
	ret ; $5399
	ld hl, $308f ; $539a
	ld a, [$c2b0] ; $539d
	add a, l ; $53a0
	ld l, a ; $53a1
	jr nc, Label_0e_53a5 ; $53a2
	inc h ; $53a4
Label_0e_53a5:
	farcall FarPtr_InitDialogueTextCursor ; $53a5
	ld a, $11 ; $53a8
	farcall FarPtr_ScriptShowSpeakerDialogue ; $53aa
	ret ; $53ad
	ld hl, $3093 ; $53ae
	ld a, [$c2b0] ; $53b1
	add a, l ; $53b4
	ld l, a ; $53b5
	jr nc, Label_0e_53b9 ; $53b6
	inc h ; $53b8
Label_0e_53b9:
	farcall FarPtr_InitDialogueTextCursor ; $53b9
	ld a, $0b ; $53bc
	farcall FarPtr_ScriptShowSpeakerDialogue ; $53be
	ret ; $53c1
	ld hl, $3097 ; $53c2
	farcall FarPtr_InitDialogueTextCursor ; $53c5
	sound $87 ; $53c8
	ld a, $09 ; $53ca
	farcall FarPtr_ScriptShowSpeakerDialogue ; $53cc
	ret ; $53cf
	ld hl, $3098 ; $53d0
	farcall FarPtr_InitDialogueTextCursor ; $53d3
	sound $89 ; $53d6
	ld a, $0a ; $53d8
	farcall FarPtr_ScriptShowSpeakerDialogue ; $53da
	ret ; $53dd
	ld hl, $3099 ; $53de
	farcall FarPtr_InitDialogueTextCursor ; $53e1
	sound $88 ; $53e4
	ld a, $0c ; $53e6
	farcall FarPtr_ScriptShowSpeakerDialogue ; $53e8
	ret ; $53eb
	ld hl, $309a ; $53ec
	farcall FarPtr_InitDialogueTextCursor ; $53ef
	sound $86 ; $53f2
	ld a, $0d ; $53f4
	farcall FarPtr_ScriptShowSpeakerDialogue ; $53f6
	ret ; $53f9
	ld hl, $309b ; $53fa
	ld a, [$c2b0] ; $53fd
	add a, l ; $5400
	ld l, a ; $5401
	jr nc, Label_0e_5405 ; $5402
	inc h ; $5404
Label_0e_5405:
	farcall FarPtr_InitDialogueTextCursor ; $5405
	ld a, $0f ; $5408
	farcall FarPtr_ScriptShowSpeakerDialogue ; $540a
	ret ; $540d
	ld hl, $309f ; $540e
	ld a, [$c2b0] ; $5411
	add a, l ; $5414
	ld l, a ; $5415
	jr nc, Label_0e_5419 ; $5416
	inc h ; $5418
Label_0e_5419:
	farcall FarPtr_InitDialogueTextCursor ; $5419
	ld a, $10 ; $541c
	farcall FarPtr_ScriptShowSpeakerDialogue ; $541e
	ret ; $5421
	ld hl, $30a3 ; $5422
	ld a, [$c2b0] ; $5425
	add a, l ; $5428
	ld l, a ; $5429
	jr nc, Label_0e_542d ; $542a
	inc h ; $542c
Label_0e_542d:
	farcall FarPtr_InitDialogueTextCursor ; $542d
	ld a, $0e ; $5430
	farcall FarPtr_ScriptShowSpeakerDialogue ; $5432
	ret ; $5435
	ld hl, $30a7 ; $5436
	farcall FarPtr_InitDialogueTextCursor ; $5439
	ld a, $13 ; $543c
	farcall FarPtr_ScriptShowSpeakerDialogue ; $543e
	ret ; $5441
	ld hl, $30a8 ; $5442
	farcall FarPtr_InitDialogueTextCursor ; $5445
	ld a, $14 ; $5448
	farcall FarPtr_ScriptShowSpeakerDialogue ; $544a
	ret ; $544d
	; $544e, 132 bytes (records:8)
; 16 records x 8 bytes
	dw $1008, $0000, $64a4, $0000 ; record 0
	dw $2008, $0000, $654f, $0000 ; record 1
	dw $4008, $0000, $63f4, $0000 ; record 2
	dw $8008, $0000, $633d, $0003 ; record 3
	dw $ff11, $0000, $539a, $0003 ; record 4
	dw $ff0b, $0000, $53ae, $0003 ; record 5
	dw $ff09, $0000, $53c2, $0003 ; record 6
	dw $ff0a, $0000, $53d0, $0003 ; record 7
	dw $ff0c, $0000, $53de, $0003 ; record 8
	dw $ff0d, $0000, $53ec, $0003 ; record 9
	dw $ff0f, $0000, $53fa, $0003 ; record 10
	dw $ff10, $0000, $540e, $0003 ; record 11
	dw $ff0e, $0000, $5422, $0003 ; record 12
	dw $ff13, $0000, $5436, $0003 ; record 13
	dw $ff14, $0000, $5442, $0003 ; record 14
	dw $ff12, $0000, $538e, $0003 ; record 15
	db $ff, $ff, $ff, $c9
	call ComputeMarioWorldProgressIndex ; $54d2
	ld a, [$c295] ; $54d5
	cp a, $0a ; $54d8
	jp z, MarioWorldArrivalSingles ; $54da
	cp a, $0e ; $54dd
	jp z, Label_0e_69ad ; $54df
	cp a, $0f ; $54e2
	jp z, MarioWorldArrivalSingles ; $54e4
	test_flag $05, 7 ; $54e7
	jr nz, Label_0e_550c ; $54ea
	test_flag $16, 2 ; $54ec
	ret z ; $54ef
	ld a, [$c295] ; $54f0
	inc a ; $54f3
	jr z, Label_0e_5509 ; $54f4
	ld a, $00 ; $54f6
	ld bc, $0014 ; $54f8
	farcall FarPtr_0a_18 ; $54fb
	ld a, $00 ; $54fe
	ld bc, $1200 ; $5500
	ld de, $1d00 ; $5503
	farcall FarPtr_ScriptSetActorMoveTarget ; $5506
Label_0e_5509:
	jp Label_0e_69fb ; $5509
Label_0e_550c:
	test_flag $16, 3 ; $550c
	ret z ; $550f
	ld a, [$c295] ; $5510
	inc a ; $5513
	jr z, Label_0e_5529 ; $5514
	ld a, $00 ; $5516
	ld bc, $0014 ; $5518
	farcall FarPtr_0a_18 ; $551b
	ld a, $00 ; $551e
	ld bc, $1200 ; $5520
	ld de, $1d00 ; $5523
	farcall FarPtr_ScriptSetActorMoveTarget ; $5526
Label_0e_5529:
	jp Label_0e_69fb ; $5529
	INCBIN "data/bank_00e/d_552c.bin" ; $552c, 49 bytes
ComputeMarioWorldProgressIndex:
	test_flag $05, 7 ; $555d
	jr nz, Label_0e_556e ; $5560
	ld a, $00 ; $5562
	test_flag $07, 3 ; $5564
	jr z, Label_0e_556a ; $5567
	inc a ; $5569
Label_0e_556a:
	ld [$c2b0], a ; $556a
	ret ; $556d
Label_0e_556e:
	ld a, $02 ; $556e
	test_flag $06, 4 ; $5570
	jr z, Label_0e_556a ; $5573
	inc a ; $5575
	jr Label_0e_556a ; $5576
	ret ; $5578
MarioWorldArrivalSingles:
	test_flag $05, 7 ; $5579
	jp nz, MarioWorldArrivalDoubles ; $557c
	test_flag $0d, 6 ; $557f
	jr nz, Label_0e_558a ; $5582
	test_flag $16, 2 ; $5584
	jp nz, Label_0e_69b3 ; $5587
Label_0e_558a:
	ld a, $00 ; $558a
	ld bc, $3f00 ; $558c
	ld de, $3f00 ; $558f
	farcall FarPtr_ScriptSetActorPosition ; $5592
	ld c, $04 ; $5595
	call BeginFadeIn ; $5597
	call WaitFadeEnd ; $559a
	push af ; $559d
	ld a, $28 ; $559e
	farcall FarPtr_WaitScriptFrames ; $55a0
	pop af ; $55a3
	call Func_0e_6a51 ; $55a4
	ld a, $00 ; $55a7
	ld bc, $1200 ; $55a9
	ld de, $2500 ; $55ac
	farcall FarPtr_ScriptSetActorPosition ; $55af
	ld a, $00 ; $55b2
	ld bc, $0010 ; $55b4
	farcall FarPtr_0a_18 ; $55b7
	ld a, $00 ; $55ba
	ld bc, $1200 ; $55bc
	ld de, $2080 ; $55bf
	farcall FarPtr_ScriptSetActorMoveTarget ; $55c2
	ld bc, $0010 ; $55c5
	farcall FarPtr_0a_38 ; $55c8
	xor a, a ; $55cb
	ld bc, $1200 ; $55cc
	ld de, $1b00 ; $55cf
	farcall FarPtr_MovePlayerToPosition ; $55d2
	push af ; $55d5
	ld a, $50 ; $55d6
	farcall FarPtr_WaitScriptFrames ; $55d8
	pop af ; $55db
	ld a, $13 ; $55dc
	ld b, $c0 ; $55de
	farcall FarPtr_SetActorFacing ; $55e0
	push af ; $55e3
	ld a, $0a ; $55e4
	farcall FarPtr_WaitScriptFrames ; $55e6
	pop af ; $55e9
	test_flag $0d, 6 ; $55ea
	jr nz, Label_0e_55ff ; $55ed
	ld hl, $304b ; $55ef
	farcall FarPtr_InitDialogueTextCursor ; $55f2
	ld a, $13 ; $55f5
	farcall FarPtr_ScriptShowSpeakerDialogue ; $55f7
	ld a, $13 ; $55fa
	farcall FarPtr_ScriptShowSpeakerDialogue ; $55fc
Label_0e_55ff:
	ld bc, $0020 ; $55ff
	farcall FarPtr_0a_38 ; $5602
	xor a, a ; $5605
	ld bc, $1200 ; $5606
	ld de, $1800 ; $5609
	farcall FarPtr_MovePlayerToPosition ; $560c
	farcall FarPtr_WaitPlayerMoveDone ; $560f
	push af ; $5612
	ld a, $0a ; $5613
	farcall FarPtr_WaitScriptFrames ; $5615
	pop af ; $5618
	ld a, $08 ; $5619
	ld d, $03 ; $561b
	farcall FarPtr_ScriptSetActorAnimation ; $561d
	ld a, $08 ; $5620
	farcall FarPtr_ScriptWaitActorIdle ; $5622
	test_flag $0d, 6 ; $5625
	jr nz, Label_0e_562f ; $5628
	ld a, $08 ; $562a
	farcall FarPtr_ScriptShowSpeakerDialogue ; $562c
Label_0e_562f:
	ld bc, $0014 ; $562f
	farcall FarPtr_0a_38 ; $5632
	ld a, $00 ; $5635
	ld bc, $0014 ; $5637
	farcall FarPtr_0a_18 ; $563a
	ld a, $13 ; $563d
	ld bc, $0014 ; $563f
	farcall FarPtr_0a_18 ; $5642
	ld a, $08 ; $5645
	ld bc, $0014 ; $5647
	farcall FarPtr_0a_18 ; $564a
	ld a, $00 ; $564d
	ld bc, $1200 ; $564f
	ld de, $1100 ; $5652
	farcall FarPtr_ScriptSetActorMoveTarget ; $5655
	ld a, $13 ; $5658
	ld bc, $1200 ; $565a
	ld de, $1700 ; $565d
	farcall FarPtr_ScriptSetActorMoveTarget ; $5660
	push af ; $5663
	ld a, $28 ; $5664
	farcall FarPtr_WaitScriptFrames ; $5666
	pop af ; $5669
	xor a, a ; $566a
	ld bc, $1200 ; $566b
	ld de, $0d00 ; $566e
	farcall FarPtr_MovePlayerToPosition ; $5671
	ld a, $13 ; $5674
	farcall FarPtr_ScriptWaitActorMoveDone ; $5676
	ld a, $08 ; $5679
	ld bc, $1200 ; $567b
	ld de, $0900 ; $567e
	farcall FarPtr_ScriptSetActorMoveTarget ; $5681
	ld a, $13 ; $5684
	ld bc, $1200 ; $5686
	ld de, $1300 ; $5689
	farcall FarPtr_ScriptSetActorMoveTarget ; $568c
	ld a, $13 ; $568f
	farcall FarPtr_ScriptWaitActorMoveDone ; $5691
	ld a, $13 ; $5694
	ld bc, $0d00 ; $5696
	ld de, $1300 ; $5699
	farcall FarPtr_ScriptSetActorMoveTarget ; $569c
	ld a, $08 ; $569f
	farcall FarPtr_ScriptWaitActorMoveDone ; $56a1
	test_flag $0d, 6 ; $56a4
	jr z, Label_0e_56c0 ; $56a7
	ld a, $08 ; $56a9
	ld b, $40 ; $56ab
	farcall FarPtr_SetActorFacing ; $56ad
	push af ; $56b0
	ld a, $14 ; $56b1
	farcall FarPtr_WaitScriptFrames ; $56b3
	pop af ; $56b6
	ld a, $01 ; $56b7
	ld [$c294], a ; $56b9
	ld [$c2a1], a ; $56bc
	ret ; $56bf
Label_0e_56c0:
	call Func_0e_6ad4 ; $56c0
	ld a, $0f ; $56c3
	ld bc, $0020 ; $56c5
	farcall FarPtr_0a_18 ; $56c8
	ld a, $07 ; $56cb
	ld bc, $0020 ; $56cd
	farcall FarPtr_0a_18 ; $56d0
	push af ; $56d3
	ld a, $28 ; $56d4
	farcall FarPtr_WaitScriptFrames ; $56d6
	pop af ; $56d9
	ld a, $0f ; $56da
	ld d, $02 ; $56dc
	farcall FarPtr_ScriptSetActorAnimation ; $56de
	ld a, $0f ; $56e1
	farcall FarPtr_ScriptWaitActorIdle ; $56e3
	ld a, $0f ; $56e6
	ld bc, $0f00 ; $56e8
	ld de, $0e00 ; $56eb
	farcall FarPtr_ScriptSetActorMoveTarget ; $56ee
	ld a, $07 ; $56f1
	ld bc, $1000 ; $56f3
	ld de, $0c00 ; $56f6
	farcall FarPtr_ScriptSetActorMoveTarget ; $56f9
	ld a, $07 ; $56fc
	farcall FarPtr_ScriptWaitActorMoveDone ; $56fe
	ld a, $07 ; $5701
	ld bc, $3f00 ; $5703
	ld de, $3f00 ; $5706
	farcall FarPtr_ScriptSetActorPosition ; $5709
	ld a, $0f ; $570c
	ld b, $c0 ; $570e
	farcall FarPtr_SetActorFacing ; $5710
	push af ; $5713
	ld a, $14 ; $5714
	farcall FarPtr_WaitScriptFrames ; $5716
	pop af ; $5719
	ld a, $0f ; $571a
	farcall FarPtr_ScriptShowSpeakerDialogue ; $571c
	push af ; $571f
	ld a, $14 ; $5720
	farcall FarPtr_WaitScriptFrames ; $5722
	pop af ; $5725
	ld a, $10 ; $5726
	ld bc, $0020 ; $5728
	farcall FarPtr_0a_18 ; $572b
	ld a, $0e ; $572e
	ld bc, $0020 ; $5730
	farcall FarPtr_0a_18 ; $5733
	ld a, $0f ; $5736
	ld bc, $1000 ; $5738
	ld de, $0d00 ; $573b
	farcall FarPtr_ScriptSetActorMoveTarget ; $573e
	ld a, $0f ; $5741
	farcall FarPtr_ScriptWaitActorMoveDone ; $5743
	push af ; $5746
	ld a, $0a ; $5747
	farcall FarPtr_WaitScriptFrames ; $5749
	pop af ; $574c
	ld a, $10 ; $574d
	ld b, $00 ; $574f
	farcall FarPtr_SetActorFacing ; $5751
	ld a, $10 ; $5754
	ld bc, $0d00 ; $5756
	ld de, $0d00 ; $5759
	farcall FarPtr_ScriptSetActorMoveTarget ; $575c
	ld a, $10 ; $575f
	farcall FarPtr_ScriptWaitActorMoveDone ; $5761
	ld a, $10 ; $5764
	ld b, $c0 ; $5766
	farcall FarPtr_SetActorFacing ; $5768
	push af ; $576b
	ld a, $0a ; $576c
	farcall FarPtr_WaitScriptFrames ; $576e
	pop af ; $5771
	ld a, $0e ; $5772
	ld b, $00 ; $5774
	farcall FarPtr_SetActorFacing ; $5776
	ld a, $0e ; $5779
	ld bc, $0e00 ; $577b
	ld de, $1000 ; $577e
	farcall FarPtr_ScriptSetActorMoveTarget ; $5781
	ld a, $0e ; $5784
	farcall FarPtr_ScriptWaitActorMoveDone ; $5786
	ld a, $0e ; $5789
	ld b, $c0 ; $578b
	farcall FarPtr_SetActorFacing ; $578d
	push af ; $5790
	ld a, $28 ; $5791
	farcall FarPtr_WaitScriptFrames ; $5793
	pop af ; $5796
	sound $96 ; $5797
	ld a, $04 ; $5799
	ld bc, $0f00 ; $579b
	ld de, $0900 ; $579e
	farcall FarPtr_ScriptSetActorPosition ; $57a1
	push af ; $57a4
	ld a, $04 ; $57a5
	farcall FarPtr_WaitScriptFrames ; $57a7
	pop af ; $57aa
	sound $96 ; $57ab
	ld a, $05 ; $57ad
	ld bc, $1300 ; $57af
	ld de, $0700 ; $57b2
	farcall FarPtr_ScriptSetActorPosition ; $57b5
	push af ; $57b8
	ld a, $04 ; $57b9
	farcall FarPtr_WaitScriptFrames ; $57bb
	pop af ; $57be
	sound $96 ; $57bf
	ld a, $06 ; $57c1
	ld bc, $1700 ; $57c3
	ld de, $0900 ; $57c6
	farcall FarPtr_ScriptSetActorPosition ; $57c9
	push af ; $57cc
	ld a, $04 ; $57cd
	farcall FarPtr_WaitScriptFrames ; $57cf
	pop af ; $57d2
	ld a, $0f ; $57d3
	ld b, $00 ; $57d5
	farcall FarPtr_SetActorFacing ; $57d7
	ld a, $0f ; $57da
	ld bc, $1100 ; $57dc
	ld de, $0d00 ; $57df
	farcall FarPtr_ScriptSetActorMoveTarget ; $57e2
	ld a, $0f ; $57e5
	farcall FarPtr_ScriptWaitActorMoveDone ; $57e7
	ld a, $0f ; $57ea
	ld b, $c0 ; $57ec
	farcall FarPtr_SetActorFacing ; $57ee
	push af ; $57f1
	ld a, $0a ; $57f2
	farcall FarPtr_WaitScriptFrames ; $57f4
	pop af ; $57f7
	ld a, $10 ; $57f8
	ld b, $00 ; $57fa
	farcall FarPtr_SetActorFacing ; $57fc
	ld a, $10 ; $57ff
	ld bc, $0f00 ; $5801
	ld de, $0d00 ; $5804
	farcall FarPtr_ScriptSetActorMoveTarget ; $5807
	ld a, $10 ; $580a
	farcall FarPtr_ScriptWaitActorMoveDone ; $580c
	ld a, $10 ; $580f
	ld b, $c0 ; $5811
	farcall FarPtr_SetActorFacing ; $5813
	push af ; $5816
	ld a, $0a ; $5817
	farcall FarPtr_WaitScriptFrames ; $5819
	pop af ; $581c
	ld a, $0e ; $581d
	ld b, $00 ; $581f
	farcall FarPtr_SetActorFacing ; $5821
	ld a, $0e ; $5824
	ld bc, $1100 ; $5826
	ld de, $0f00 ; $5829
	farcall FarPtr_ScriptSetActorMoveTarget ; $582c
	ld a, $0e ; $582f
	farcall FarPtr_ScriptWaitActorMoveDone ; $5831
	ld a, $0e ; $5834
	ld b, $c0 ; $5836
	farcall FarPtr_SetActorFacing ; $5838
	push af ; $583b
	ld a, $0a ; $583c
	farcall FarPtr_WaitScriptFrames ; $583e
	pop af ; $5841
	call Func_0e_6db7 ; $5842
	sound $96 ; $5845
	ld a, $04 ; $5847
	ld bc, $1380 ; $5849
	ld de, $0f80 ; $584c
	farcall FarPtr_ScriptSetActorPosition ; $584f
	push af ; $5852
	ld a, $14 ; $5853
	farcall FarPtr_WaitScriptFrames ; $5855
	pop af ; $5858
	ld a, $12 ; $5859
	ld b, $80 ; $585b
	farcall FarPtr_SetActorFacing ; $585d
	push af ; $5860
	ld a, $28 ; $5861
	farcall FarPtr_WaitScriptFrames ; $5863
	pop af ; $5866
	ld a, $08 ; $5867
	ld d, $03 ; $5869
	farcall FarPtr_ScriptSetActorAnimation ; $586b
	ld a, $12 ; $586e
	ld d, $03 ; $5870
	farcall FarPtr_ScriptSetActorAnimation ; $5872
	ld a, $12 ; $5875
	farcall FarPtr_ScriptWaitActorIdle ; $5877
	push af ; $587a
	ld a, $0a ; $587b
	farcall FarPtr_WaitScriptFrames ; $587d
	pop af ; $5880
	ld a, $08 ; $5881
	ld b, $40 ; $5883
	farcall FarPtr_SetActorFacing ; $5885
	push af ; $5888
	ld a, $0a ; $5889
	farcall FarPtr_WaitScriptFrames ; $588b
	pop af ; $588e
	ld a, $08 ; $588f
	ld bc, $0020 ; $5891
	farcall FarPtr_0a_18 ; $5894
	ld a, $08 ; $5897
	ld bc, $1200 ; $5899
	ld de, $0b00 ; $589c
	farcall FarPtr_ScriptSetActorMoveTarget ; $589f
	ld a, $08 ; $58a2
	farcall FarPtr_ScriptWaitActorMoveDone ; $58a4
	ld a, $11 ; $58a7
	ld b, $40 ; $58a9
	farcall FarPtr_SetActorFacing ; $58ab
	ld a, $12 ; $58ae
	ld b, $40 ; $58b0
	farcall FarPtr_SetActorFacing ; $58b2
	ld a, $04 ; $58b5
	ld bc, $3f00 ; $58b7
	ld de, $3f00 ; $58ba
	farcall FarPtr_ScriptSetActorPosition ; $58bd
	ld a, $08 ; $58c0
	farcall FarPtr_ScriptShowSpeakerDialogue ; $58c2
	push af ; $58c5
	ld a, $0a ; $58c6
	farcall FarPtr_WaitScriptFrames ; $58c8
	pop af ; $58cb
	call Func_0e_6f2b ; $58cc
	ld a, $0f ; $58cf
	ld bc, $1300 ; $58d1
	ld de, $0f00 ; $58d4
	farcall FarPtr_ScriptSetActorMoveTarget ; $58d7
	ld a, $10 ; $58da
	ld bc, $1100 ; $58dc
	ld de, $0f00 ; $58df
	farcall FarPtr_ScriptSetActorMoveTarget ; $58e2
	ld a, $0e ; $58e5
	ld bc, $1400 ; $58e7
	ld de, $1100 ; $58ea
	farcall FarPtr_ScriptSetActorMoveTarget ; $58ed
	ld a, $0e ; $58f0
	farcall FarPtr_ScriptWaitActorMoveDone ; $58f2
	ld a, $0e ; $58f5
	ld bc, $1300 ; $58f7
	ld de, $1300 ; $58fa
	farcall FarPtr_ScriptSetActorMoveTarget ; $58fd
	ld a, $0e ; $5900
	farcall FarPtr_ScriptWaitActorMoveDone ; $5902
	ld a, $0e ; $5905
	ld b, $c0 ; $5907
	farcall FarPtr_SetActorFacing ; $5909
	push af ; $590c
	ld a, $28 ; $590d
	farcall FarPtr_WaitScriptFrames ; $590f
	pop af ; $5912
	set_flag $16, 2 ; $5913
	farcall FarPtr_03_18 ; $5916
	ld a, $08 ; $5919
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $591b
	farcall FarPtr_RunDialogueYesNoPrompt ; $591e
	farcall FarPtr_ScriptCloseDialogueWindow ; $5921
	push af ; $5924
	ld a, $05 ; $5925
	farcall FarPtr_WaitScriptFrames ; $5927
	pop af ; $592a
	and a, a ; $592b
	jr z, ExhibitionAcceptedSingles ; $592c
	ld hl, $3060 ; $592e
	farcall FarPtr_InitDialogueTextCursor ; $5931
	call ExhibitionDeclinedCutscene ; $5934
	ret ; $5937
ExhibitionAcceptedSingles:
	push af ; $5938
	ld a, $0a ; $5939
	farcall FarPtr_WaitScriptFrames ; $593b
	pop af ; $593e
	ld a, $0f ; $593f
	ld d, $03 ; $5941
	farcall FarPtr_ScriptSetActorAnimation ; $5943
	ld a, $0f ; $5946
	farcall FarPtr_ScriptWaitActorIdle ; $5948
	push af ; $594b
	ld a, $0a ; $594c
	farcall FarPtr_WaitScriptFrames ; $594e
	pop af ; $5951
	ld hl, $3063 ; $5952
	farcall FarPtr_InitDialogueTextCursor ; $5955
	ld a, $0f ; $5958
	farcall FarPtr_ScriptShowSpeakerDialogue ; $595a
	ld a, $08 ; $595d
	farcall FarPtr_ScriptShowSpeakerDialogue ; $595f
	ld a, $0b ; $5962
	ld b, $c0 ; $5964
	farcall FarPtr_SetActorFacing ; $5966
	push af ; $5969
	ld a, $04 ; $596a
	farcall FarPtr_WaitScriptFrames ; $596c
	pop af ; $596f
	ld a, $0f ; $5970
	ld b, $c0 ; $5972
	farcall FarPtr_SetActorFacing ; $5974
	push af ; $5977
	ld a, $04 ; $5978
	farcall FarPtr_WaitScriptFrames ; $597a
	pop af ; $597d
	ld a, $10 ; $597e
	ld b, $c0 ; $5980
	farcall FarPtr_SetActorFacing ; $5982
	push af ; $5985
	ld a, $04 ; $5986
	farcall FarPtr_WaitScriptFrames ; $5988
	pop af ; $598b
	ld a, $0a ; $598c
	ld b, $c0 ; $598e
	farcall FarPtr_SetActorFacing ; $5990
	push af ; $5993
	ld a, $04 ; $5994
	farcall FarPtr_WaitScriptFrames ; $5996
	pop af ; $5999
	ld a, $09 ; $599a
	ld b, $c0 ; $599c
	farcall FarPtr_SetActorFacing ; $599e
	push af ; $59a1
	ld a, $04 ; $59a2
	farcall FarPtr_WaitScriptFrames ; $59a4
	pop af ; $59a7
	ld a, $0e ; $59a8
	ld b, $c0 ; $59aa
	farcall FarPtr_SetActorFacing ; $59ac
	push af ; $59af
	ld a, $0a ; $59b0
	farcall FarPtr_WaitScriptFrames ; $59b2
	pop af ; $59b5
	ld a, $0f ; $59b6
	ld d, $03 ; $59b8
	farcall FarPtr_ScriptSetActorAnimation ; $59ba
	ld a, $10 ; $59bd
	ld d, $03 ; $59bf
	farcall FarPtr_ScriptSetActorAnimation ; $59c1
	ld a, $0e ; $59c4
	ld d, $03 ; $59c6
	farcall FarPtr_ScriptSetActorAnimation ; $59c8
	ld a, $11 ; $59cb
	ld d, $03 ; $59cd
	farcall FarPtr_ScriptSetActorAnimation ; $59cf
	ld a, $12 ; $59d2
	ld d, $03 ; $59d4
	farcall FarPtr_ScriptSetActorAnimation ; $59d6
	ld a, $0b ; $59d9
	ld d, $03 ; $59db
	farcall FarPtr_ScriptSetActorAnimation ; $59dd
	ld a, $0a ; $59e0
	ld d, $03 ; $59e2
	farcall FarPtr_ScriptSetActorAnimation ; $59e4
	ld a, $09 ; $59e7
	ld d, $03 ; $59e9
	farcall FarPtr_ScriptSetActorAnimation ; $59eb
	ld a, $0c ; $59ee
	ld d, $03 ; $59f0
	farcall FarPtr_ScriptSetActorAnimation ; $59f2
	ld a, $13 ; $59f5
	ld d, $03 ; $59f7
	farcall FarPtr_ScriptSetActorAnimation ; $59f9
	ld a, $13 ; $59fc
	farcall FarPtr_ScriptWaitActorIdle ; $59fe
	ld bc, $0010 ; $5a01
	farcall FarPtr_0a_38 ; $5a04
	xor a, a ; $5a07
	ld bc, $1500 ; $5a08
	ld de, $0d00 ; $5a0b
	farcall FarPtr_MovePlayerToPosition ; $5a0e
	ld a, $08 ; $5a11
	ld bc, $0014 ; $5a13
	farcall FarPtr_0a_18 ; $5a16
	ld a, $0f ; $5a19
	ld bc, $0014 ; $5a1b
	farcall FarPtr_0a_18 ; $5a1e
	ld a, $10 ; $5a21
	ld bc, $0014 ; $5a23
	farcall FarPtr_0a_18 ; $5a26
	ld a, $0e ; $5a29
	ld bc, $0014 ; $5a2b
	farcall FarPtr_0a_18 ; $5a2e
	ld a, $11 ; $5a31
	ld bc, $0014 ; $5a33
	farcall FarPtr_0a_18 ; $5a36
	ld a, $12 ; $5a39
	ld bc, $0014 ; $5a3b
	farcall FarPtr_0a_18 ; $5a3e
	ld a, $0b ; $5a41
	ld bc, $0014 ; $5a43
	farcall FarPtr_0a_18 ; $5a46
	ld a, $0a ; $5a49
	ld bc, $0014 ; $5a4b
	farcall FarPtr_0a_18 ; $5a4e
	ld a, $09 ; $5a51
	ld bc, $0014 ; $5a53
	farcall FarPtr_0a_18 ; $5a56
	ld a, $0d ; $5a59
	ld bc, $0014 ; $5a5b
	farcall FarPtr_0a_18 ; $5a5e
	ld a, $0c ; $5a61
	ld bc, $0014 ; $5a63
	farcall FarPtr_0a_18 ; $5a66
	ld a, $13 ; $5a69
	ld bc, $0014 ; $5a6b
	farcall FarPtr_0a_18 ; $5a6e
	ld a, $00 ; $5a71
	ld bc, $0014 ; $5a73
	farcall FarPtr_0a_18 ; $5a76
	ldh a, [hRomBank] ; $5a79
	ld b, a ; $5a7b
	ld a, $11 ; $5a7c
	ld de, $552d ; $5a7e
	farcall FarPtr_0a_1a ; $5a81
	push af ; $5a84
	ld a, $14 ; $5a85
	farcall FarPtr_WaitScriptFrames ; $5a87
	pop af ; $5a8a
	ldh a, [hRomBank] ; $5a8b
	ld b, a ; $5a8d
	ld a, $08 ; $5a8e
	ld de, $552d ; $5a90
	farcall FarPtr_0a_1a ; $5a93
	push af ; $5a96
	ld a, $14 ; $5a97
	farcall FarPtr_WaitScriptFrames ; $5a99
	pop af ; $5a9c
	ldh a, [hRomBank] ; $5a9d
	ld b, a ; $5a9f
	ld a, $12 ; $5aa0
	ld de, $552d ; $5aa2
	farcall FarPtr_0a_1a ; $5aa5
	push af ; $5aa8
	ld a, $64 ; $5aa9
	farcall FarPtr_WaitScriptFrames ; $5aab
	pop af ; $5aae
	ldh a, [hRomBank] ; $5aaf
	ld b, a ; $5ab1
	ld a, $0b ; $5ab2
	ld de, $552d ; $5ab4
	farcall FarPtr_0a_1a ; $5ab7
	ldh a, [hRomBank] ; $5aba
	ld b, a ; $5abc
	ld a, $0a ; $5abd
	ld de, $552d ; $5abf
	farcall FarPtr_0a_1a ; $5ac2
	ldh a, [hRomBank] ; $5ac5
	ld b, a ; $5ac7
	ld a, $09 ; $5ac8
	ld de, $552d ; $5aca
	farcall FarPtr_0a_1a ; $5acd
	ldh a, [hRomBank] ; $5ad0
	ld b, a ; $5ad2
	ld a, $0c ; $5ad3
	ld de, $552d ; $5ad5
	farcall FarPtr_0a_1a ; $5ad8
	ldh a, [hRomBank] ; $5adb
	ld b, a ; $5add
	ld a, $0d ; $5ade
	ld de, $552d ; $5ae0
	farcall FarPtr_0a_1a ; $5ae3
	push af ; $5ae6
	ld a, $3c ; $5ae7
	farcall FarPtr_WaitScriptFrames ; $5ae9
	pop af ; $5aec
	ldh a, [hRomBank] ; $5aed
	ld b, a ; $5aef
	ld a, $0f ; $5af0
	ld de, $552d ; $5af2
	farcall FarPtr_0a_1a ; $5af5
	ldh a, [hRomBank] ; $5af8
	ld b, a ; $5afa
	ld a, $10 ; $5afb
	ld de, $552d ; $5afd
	farcall FarPtr_0a_1a ; $5b00
	push af ; $5b03
	ld a, $28 ; $5b04
	farcall FarPtr_WaitScriptFrames ; $5b06
	pop af ; $5b09
	ldh a, [hRomBank] ; $5b0a
	ld b, a ; $5b0c
	ld a, $0e ; $5b0d
	ld de, $552d ; $5b0f
	farcall FarPtr_0a_1a ; $5b12
	ld a, $0e ; $5b15
	farcall FarPtr_WaitActorScriptDone ; $5b17
	xor a, a ; $5b1a
	ld bc, $1200 ; $5b1b
	ld de, $0d00 ; $5b1e
	farcall FarPtr_MovePlayerToPosition ; $5b21
	ld a, $13 ; $5b24
	ld bc, $1000 ; $5b26
	ld de, $0f00 ; $5b29
	farcall FarPtr_ScriptSetActorMoveTarget ; $5b2c
	ld a, $13 ; $5b2f
	farcall FarPtr_ScriptWaitActorMoveDone ; $5b31
	ld a, $13 ; $5b34
	ld bc, $1200 ; $5b36
	ld de, $0f00 ; $5b39
	farcall FarPtr_ScriptSetActorMoveTarget ; $5b3c
	ld a, $13 ; $5b3f
	farcall FarPtr_ScriptWaitActorMoveDone ; $5b41
	ld a, $13 ; $5b44
	ld b, $40 ; $5b46
	farcall FarPtr_SetActorFacing ; $5b48
	push af ; $5b4b
	ld a, $14 ; $5b4c
	farcall FarPtr_WaitScriptFrames ; $5b4e
	pop af ; $5b51
	ld a, $13 ; $5b52
	farcall FarPtr_ScriptShowSpeakerDialogue ; $5b54
	push af ; $5b57
	ld a, $0a ; $5b58
	farcall FarPtr_WaitScriptFrames ; $5b5a
	pop af ; $5b5d
	ld a, $00 ; $5b5e
	ld d, $03 ; $5b60
	farcall FarPtr_ScriptSetActorAnimation ; $5b62
	ld a, $00 ; $5b65
	farcall FarPtr_ScriptWaitActorIdle ; $5b67
	push af ; $5b6a
	ld a, $14 ; $5b6b
	farcall FarPtr_WaitScriptFrames ; $5b6d
	pop af ; $5b70
	ldh a, [hRomBank] ; $5b71
	ld b, a ; $5b73
	ld a, $13 ; $5b74
	ld de, $5545 ; $5b76
	farcall FarPtr_0a_1a ; $5b79
	push af ; $5b7c
	ld a, $14 ; $5b7d
	farcall FarPtr_WaitScriptFrames ; $5b7f
	pop af ; $5b82
	ldh a, [hRomBank] ; $5b83
	ld b, a ; $5b85
	ld a, $00 ; $5b86
	ld de, $5545 ; $5b88
	farcall FarPtr_0a_1a ; $5b8b
	push af ; $5b8e
	ld a, $3c ; $5b8f
	farcall FarPtr_WaitScriptFrames ; $5b91
	pop af ; $5b94
	xor a, a ; $5b95
	ld bc, $1500 ; $5b96
	ld de, $0d00 ; $5b99
	farcall FarPtr_MovePlayerToPosition ; $5b9c
	ld a, $00 ; $5b9f
	farcall FarPtr_WaitActorScriptDone ; $5ba1
	call Func_0e_7150 ; $5ba4
	ld a, $1c ; $5ba7
	ld [wStoryModeCurrentLocation], a ; $5ba9
	ld a, $01 ; $5bac
	ld [$c295], a ; $5bae
	ld a, $ff ; $5bb1
	ld [$c294], a ; $5bb3
	ld [$c2a1], a ; $5bb6
	ret ; $5bb9
MarioWorldArrivalDoubles:
	test_flag $0d, 6 ; $5bba
	jr nz, Label_0e_5bc5 ; $5bbd
	test_flag $16, 3 ; $5bbf
	jp nz, Label_0e_69c5 ; $5bc2
Label_0e_5bc5:
	ldh a, [hRomBank] ; $5bc5
	ld b, a ; $5bc7
	ld a, $02 ; $5bc8
	ld de, $7c6e ; $5bca
	farcall FarPtr_0a_1a ; $5bcd
	ld a, $00 ; $5bd0
	ld bc, $3f00 ; $5bd2
	ld de, $3f00 ; $5bd5
	farcall FarPtr_ScriptSetActorPosition ; $5bd8
	ld a, $02 ; $5bdb
	ld bc, $3f00 ; $5bdd
	ld de, $3f00 ; $5be0
	farcall FarPtr_ScriptSetActorPosition ; $5be3
	ld c, $04 ; $5be6
	call BeginFadeIn ; $5be8
	call WaitFadeEnd ; $5beb
	push af ; $5bee
	ld a, $28 ; $5bef
	farcall FarPtr_WaitScriptFrames ; $5bf1
	pop af ; $5bf4
	call Func_0e_6a51 ; $5bf5
	ld a, $00 ; $5bf8
	ld bc, $1100 ; $5bfa
	ld de, $2500 ; $5bfd
	farcall FarPtr_ScriptSetActorPosition ; $5c00
	ld a, $02 ; $5c03
	ld bc, $1300 ; $5c05
	ld de, $2500 ; $5c08
	farcall FarPtr_ScriptSetActorPosition ; $5c0b
	ld a, $00 ; $5c0e
	ld bc, $0010 ; $5c10
	farcall FarPtr_0a_18 ; $5c13
	ld a, $02 ; $5c16
	ld bc, $0010 ; $5c18
	farcall FarPtr_0a_18 ; $5c1b
	ld a, $00 ; $5c1e
	ld bc, $1100 ; $5c20
	ld de, $2080 ; $5c23
	farcall FarPtr_ScriptSetActorMoveTarget ; $5c26
	ld a, $02 ; $5c29
	ld bc, $1300 ; $5c2b
	ld de, $2080 ; $5c2e
	farcall FarPtr_ScriptSetActorMoveTarget ; $5c31
	ld bc, $0010 ; $5c34
	farcall FarPtr_0a_38 ; $5c37
	xor a, a ; $5c3a
	ld bc, $1200 ; $5c3b
	ld de, $1b00 ; $5c3e
	farcall FarPtr_MovePlayerToPosition ; $5c41
	push af ; $5c44
	ld a, $50 ; $5c45
	farcall FarPtr_WaitScriptFrames ; $5c47
	pop af ; $5c4a
	ld a, $13 ; $5c4b
	ld b, $c0 ; $5c4d
	farcall FarPtr_SetActorFacing ; $5c4f
	push af ; $5c52
	ld a, $0a ; $5c53
	farcall FarPtr_WaitScriptFrames ; $5c55
	pop af ; $5c58
	test_flag $0d, 6 ; $5c59
	jr nz, Label_0e_5c6e ; $5c5c
	ld hl, $3066 ; $5c5e
	farcall FarPtr_InitDialogueTextCursor ; $5c61
	ld a, $13 ; $5c64
	farcall FarPtr_ScriptShowSpeakerDialogue ; $5c66
	ld a, $13 ; $5c69
	farcall FarPtr_ScriptShowSpeakerDialogue ; $5c6b
Label_0e_5c6e:
	ld bc, $0020 ; $5c6e
	farcall FarPtr_0a_38 ; $5c71
	xor a, a ; $5c74
	ld bc, $1200 ; $5c75
	ld de, $1800 ; $5c78
	farcall FarPtr_MovePlayerToPosition ; $5c7b
	farcall FarPtr_WaitPlayerMoveDone ; $5c7e
	push af ; $5c81
	ld a, $0a ; $5c82
	farcall FarPtr_WaitScriptFrames ; $5c84
	pop af ; $5c87
	ld a, $08 ; $5c88
	ld d, $03 ; $5c8a
	farcall FarPtr_ScriptSetActorAnimation ; $5c8c
	ld a, $08 ; $5c8f
	farcall FarPtr_ScriptWaitActorIdle ; $5c91
	test_flag $0d, 6 ; $5c94
	jr nz, Label_0e_5c9e ; $5c97
	ld a, $08 ; $5c99
	farcall FarPtr_ScriptShowSpeakerDialogue ; $5c9b
Label_0e_5c9e:
	ld bc, $0014 ; $5c9e
	farcall FarPtr_0a_38 ; $5ca1
	ld a, $00 ; $5ca4
	ld bc, $0014 ; $5ca6
	farcall FarPtr_0a_18 ; $5ca9
	ld a, $02 ; $5cac
	ld bc, $0014 ; $5cae
	farcall FarPtr_0a_18 ; $5cb1
	ld a, $13 ; $5cb4
	ld bc, $0014 ; $5cb6
	farcall FarPtr_0a_18 ; $5cb9
	ld a, $08 ; $5cbc
	ld bc, $0014 ; $5cbe
	farcall FarPtr_0a_18 ; $5cc1
	ld a, $13 ; $5cc4
	ld bc, $1200 ; $5cc6
	ld de, $1700 ; $5cc9
	farcall FarPtr_ScriptSetActorMoveTarget ; $5ccc
	push af ; $5ccf
	ld a, $14 ; $5cd0
	farcall FarPtr_WaitScriptFrames ; $5cd2
	pop af ; $5cd5
	ld a, $00 ; $5cd6
	ld bc, $1100 ; $5cd8
	ld de, $1100 ; $5cdb
	farcall FarPtr_ScriptSetActorMoveTarget ; $5cde
	ld a, $02 ; $5ce1
	ld bc, $1300 ; $5ce3
	ld de, $1100 ; $5ce6
	farcall FarPtr_ScriptSetActorMoveTarget ; $5ce9
	push af ; $5cec
	ld a, $28 ; $5ced
	farcall FarPtr_WaitScriptFrames ; $5cef
	pop af ; $5cf2
	xor a, a ; $5cf3
	ld bc, $1200 ; $5cf4
	ld de, $0d00 ; $5cf7
	farcall FarPtr_MovePlayerToPosition ; $5cfa
	ld a, $13 ; $5cfd
	farcall FarPtr_ScriptWaitActorMoveDone ; $5cff
	ld a, $08 ; $5d02
	ld bc, $1200 ; $5d04
	ld de, $0900 ; $5d07
	farcall FarPtr_ScriptSetActorMoveTarget ; $5d0a
	ld a, $13 ; $5d0d
	ld bc, $1200 ; $5d0f
	ld de, $1300 ; $5d12
	farcall FarPtr_ScriptSetActorMoveTarget ; $5d15
	ld a, $13 ; $5d18
	farcall FarPtr_ScriptWaitActorMoveDone ; $5d1a
	ld a, $13 ; $5d1d
	ld bc, $0d00 ; $5d1f
	ld de, $1300 ; $5d22
	farcall FarPtr_ScriptSetActorMoveTarget ; $5d25
	ld a, $08 ; $5d28
	farcall FarPtr_ScriptWaitActorMoveDone ; $5d2a
	test_flag $0d, 6 ; $5d2d
	jr z, Label_0e_5d49 ; $5d30
	ld a, $08 ; $5d32
	ld b, $40 ; $5d34
	farcall FarPtr_SetActorFacing ; $5d36
	push af ; $5d39
	ld a, $14 ; $5d3a
	farcall FarPtr_WaitScriptFrames ; $5d3c
	pop af ; $5d3f
	ld a, $01 ; $5d40
	ld [$c294], a ; $5d42
	ld [$c2a1], a ; $5d45
	ret ; $5d48
Label_0e_5d49:
	call Func_0e_6ad4 ; $5d49
	ld a, $07 ; $5d4c
	ld bc, $3f00 ; $5d4e
	ld de, $3f00 ; $5d51
	farcall FarPtr_ScriptSetActorPosition ; $5d54
	ld a, $0f ; $5d57
	ld b, $80 ; $5d59
	farcall FarPtr_SetActorFacing ; $5d5b
	push af ; $5d5e
	ld a, $28 ; $5d5f
	farcall FarPtr_WaitScriptFrames ; $5d61
	pop af ; $5d64
	ld a, $0f ; $5d65
	farcall FarPtr_ScriptShowSpeakerDialogue ; $5d67
	push af ; $5d6a
	ld a, $14 ; $5d6b
	farcall FarPtr_WaitScriptFrames ; $5d6d
	pop af ; $5d70
	ld a, $0d ; $5d71
	ld de, $ff80 ; $5d73
	farcall FarPtr_0a_42 ; $5d76
	push af ; $5d79
	ld a, $14 ; $5d7a
	farcall FarPtr_WaitScriptFrames ; $5d7c
	pop af ; $5d7f
	ld a, $0d ; $5d80
	ld de, $ff80 ; $5d82
	farcall FarPtr_0a_42 ; $5d85
	push af ; $5d88
	ld a, $28 ; $5d89
	farcall FarPtr_WaitScriptFrames ; $5d8b
	pop af ; $5d8e
	sound $86 ; $5d8f
	ld a, $0d ; $5d91
	farcall FarPtr_ScriptShowSpeakerDialogue ; $5d93
	sound $99 ; $5d96
	ld a, $07 ; $5d98
	ld bc, $0f00 ; $5d9a
	ld de, $0d00 ; $5d9d
	farcall FarPtr_ScriptSetActorPosition ; $5da0
	ld a, $0f ; $5da3
	ld bc, $0020 ; $5da5
	farcall FarPtr_0a_18 ; $5da8
	ld a, $07 ; $5dab
	ld bc, $0020 ; $5dad
	farcall FarPtr_0a_18 ; $5db0
	push af ; $5db3
	ld a, $28 ; $5db4
	farcall FarPtr_WaitScriptFrames ; $5db6
	pop af ; $5db9
	ld a, $0f ; $5dba
	ld d, $02 ; $5dbc
	farcall FarPtr_ScriptSetActorAnimation ; $5dbe
	ld a, $0f ; $5dc1
	farcall FarPtr_ScriptWaitActorIdle ; $5dc3
	ld a, $0f ; $5dc6
	ld bc, $0f00 ; $5dc8
	ld de, $0e00 ; $5dcb
	farcall FarPtr_ScriptSetActorMoveTarget ; $5dce
	ld a, $07 ; $5dd1
	ld bc, $1000 ; $5dd3
	ld de, $0c00 ; $5dd6
	farcall FarPtr_ScriptSetActorMoveTarget ; $5dd9
	ld a, $07 ; $5ddc
	farcall FarPtr_ScriptWaitActorMoveDone ; $5dde
	ld a, $07 ; $5de1
	ld bc, $3f00 ; $5de3
	ld de, $3f00 ; $5de6
	farcall FarPtr_ScriptSetActorPosition ; $5de9
	ld a, $0f ; $5dec
	ld b, $c0 ; $5dee
	farcall FarPtr_SetActorFacing ; $5df0
	push af ; $5df3
	ld a, $14 ; $5df4
	farcall FarPtr_WaitScriptFrames ; $5df6
	pop af ; $5df9
	ld a, $0f ; $5dfa
	farcall FarPtr_ScriptShowSpeakerDialogue ; $5dfc
	ld a, $10 ; $5dff
	ld bc, $0020 ; $5e01
	farcall FarPtr_0a_18 ; $5e04
	ld a, $0e ; $5e07
	ld bc, $0020 ; $5e09
	farcall FarPtr_0a_18 ; $5e0c
	ld a, $0f ; $5e0f
	ld bc, $0f00 ; $5e11
	ld de, $0d00 ; $5e14
	farcall FarPtr_ScriptSetActorMoveTarget ; $5e17
	ld a, $0f ; $5e1a
	farcall FarPtr_ScriptWaitActorMoveDone ; $5e1c
	push af ; $5e1f
	ld a, $0a ; $5e20
	farcall FarPtr_WaitScriptFrames ; $5e22
	pop af ; $5e25
	ld a, $10 ; $5e26
	ld b, $00 ; $5e28
	farcall FarPtr_SetActorFacing ; $5e2a
	ld a, $10 ; $5e2d
	ld bc, $0d80 ; $5e2f
	ld de, $0d00 ; $5e32
	farcall FarPtr_ScriptSetActorMoveTarget ; $5e35
	ld a, $10 ; $5e38
	farcall FarPtr_ScriptWaitActorMoveDone ; $5e3a
	ld a, $10 ; $5e3d
	ld b, $c0 ; $5e3f
	farcall FarPtr_SetActorFacing ; $5e41
	push af ; $5e44
	ld a, $0a ; $5e45
	farcall FarPtr_WaitScriptFrames ; $5e47
	pop af ; $5e4a
	ld a, $0e ; $5e4b
	ld b, $00 ; $5e4d
	farcall FarPtr_SetActorFacing ; $5e4f
	ld a, $0e ; $5e52
	ld bc, $0f80 ; $5e54
	ld de, $0f80 ; $5e57
	farcall FarPtr_ScriptSetActorMoveTarget ; $5e5a
	ld a, $0e ; $5e5d
	farcall FarPtr_ScriptWaitActorMoveDone ; $5e5f
	ld a, $0e ; $5e62
	ld b, $c0 ; $5e64
	farcall FarPtr_SetActorFacing ; $5e66
	push af ; $5e69
	ld a, $28 ; $5e6a
	farcall FarPtr_WaitScriptFrames ; $5e6c
	pop af ; $5e6f
	sound $99 ; $5e70
	ld a, $04 ; $5e72
	ld bc, $0f00 ; $5e74
	ld de, $0900 ; $5e77
	farcall FarPtr_ScriptSetActorPosition ; $5e7a
	push af ; $5e7d
	ld a, $04 ; $5e7e
	farcall FarPtr_WaitScriptFrames ; $5e80
	pop af ; $5e83
	sound $99 ; $5e84
	ld a, $05 ; $5e86
	ld bc, $1300 ; $5e88
	ld de, $0700 ; $5e8b
	farcall FarPtr_ScriptSetActorPosition ; $5e8e
	push af ; $5e91
	ld a, $04 ; $5e92
	farcall FarPtr_WaitScriptFrames ; $5e94
	pop af ; $5e97
	sound $99 ; $5e98
	ld a, $06 ; $5e9a
	ld bc, $1700 ; $5e9c
	ld de, $0900 ; $5e9f
	farcall FarPtr_ScriptSetActorPosition ; $5ea2
	push af ; $5ea5
	ld a, $04 ; $5ea6
	farcall FarPtr_WaitScriptFrames ; $5ea8
	pop af ; $5eab
	ld a, $0f ; $5eac
	ld b, $00 ; $5eae
	farcall FarPtr_SetActorFacing ; $5eb0
	ld a, $0f ; $5eb3
	ld bc, $1100 ; $5eb5
	ld de, $0d00 ; $5eb8
	farcall FarPtr_ScriptSetActorMoveTarget ; $5ebb
	ld a, $0f ; $5ebe
	farcall FarPtr_ScriptWaitActorMoveDone ; $5ec0
	ld a, $0f ; $5ec3
	ld b, $c0 ; $5ec5
	farcall FarPtr_SetActorFacing ; $5ec7
	push af ; $5eca
	ld a, $0a ; $5ecb
	farcall FarPtr_WaitScriptFrames ; $5ecd
	pop af ; $5ed0
	ld a, $10 ; $5ed1
	ld b, $00 ; $5ed3
	farcall FarPtr_SetActorFacing ; $5ed5
	ld a, $10 ; $5ed8
	ld bc, $0f00 ; $5eda
	ld de, $0d00 ; $5edd
	farcall FarPtr_ScriptSetActorMoveTarget ; $5ee0
	ld a, $10 ; $5ee3
	farcall FarPtr_ScriptWaitActorMoveDone ; $5ee5
	ld a, $10 ; $5ee8
	ld b, $c0 ; $5eea
	farcall FarPtr_SetActorFacing ; $5eec
	push af ; $5eef
	ld a, $0a ; $5ef0
	farcall FarPtr_WaitScriptFrames ; $5ef2
	pop af ; $5ef5
	ld a, $0e ; $5ef6
	ld b, $00 ; $5ef8
	farcall FarPtr_SetActorFacing ; $5efa
	ld a, $0e ; $5efd
	ld bc, $1100 ; $5eff
	ld de, $0f00 ; $5f02
	farcall FarPtr_ScriptSetActorMoveTarget ; $5f05
	ld a, $0e ; $5f08
	farcall FarPtr_ScriptWaitActorMoveDone ; $5f0a
	ld a, $0e ; $5f0d
	ld b, $c0 ; $5f0f
	farcall FarPtr_SetActorFacing ; $5f11
	push af ; $5f14
	ld a, $0a ; $5f15
	farcall FarPtr_WaitScriptFrames ; $5f17
	pop af ; $5f1a
	call Func_0e_6db7 ; $5f1b
	sound $96 ; $5f1e
	ld a, $04 ; $5f20
	ld bc, $1180 ; $5f22
	ld de, $0f80 ; $5f25
	farcall FarPtr_ScriptSetActorPosition ; $5f28
	ld a, $05 ; $5f2b
	ld bc, $1380 ; $5f2d
	ld de, $0f80 ; $5f30
	farcall FarPtr_ScriptSetActorPosition ; $5f33
	ld a, $00 ; $5f36
	ld b, $00 ; $5f38
	farcall FarPtr_SetActorFacing ; $5f3a
	ld a, $02 ; $5f3d
	ld b, $80 ; $5f3f
	farcall FarPtr_SetActorFacing ; $5f41
	push af ; $5f44
	ld a, $28 ; $5f45
	farcall FarPtr_WaitScriptFrames ; $5f47
	pop af ; $5f4a
	ld a, $00 ; $5f4b
	ld b, $c0 ; $5f4d
	farcall FarPtr_SetActorFacing ; $5f4f
	ld a, $02 ; $5f52
	ld b, $c0 ; $5f54
	farcall FarPtr_SetActorFacing ; $5f56
	push af ; $5f59
	ld a, $14 ; $5f5a
	farcall FarPtr_WaitScriptFrames ; $5f5c
	pop af ; $5f5f
	ld a, $04 ; $5f60
	ld bc, $3f00 ; $5f62
	ld de, $3f00 ; $5f65
	farcall FarPtr_ScriptSetActorPosition ; $5f68
	ld a, $05 ; $5f6b
	ld bc, $3f00 ; $5f6d
	ld de, $3f00 ; $5f70
	farcall FarPtr_ScriptSetActorPosition ; $5f73
	ld a, $12 ; $5f76
	ld b, $80 ; $5f78
	farcall FarPtr_SetActorFacing ; $5f7a
	push af ; $5f7d
	ld a, $28 ; $5f7e
	farcall FarPtr_WaitScriptFrames ; $5f80
	pop af ; $5f83
	ld a, $08 ; $5f84
	ld d, $03 ; $5f86
	farcall FarPtr_ScriptSetActorAnimation ; $5f88
	ld a, $12 ; $5f8b
	ld d, $03 ; $5f8d
	farcall FarPtr_ScriptSetActorAnimation ; $5f8f
	ld a, $12 ; $5f92
	farcall FarPtr_ScriptWaitActorIdle ; $5f94
	push af ; $5f97
	ld a, $0a ; $5f98
	farcall FarPtr_WaitScriptFrames ; $5f9a
	pop af ; $5f9d
	ld a, $08 ; $5f9e
	ld b, $40 ; $5fa0
	farcall FarPtr_SetActorFacing ; $5fa2
	push af ; $5fa5
	ld a, $0a ; $5fa6
	farcall FarPtr_WaitScriptFrames ; $5fa8
	pop af ; $5fab
	ld a, $08 ; $5fac
	ld bc, $0020 ; $5fae
	farcall FarPtr_0a_18 ; $5fb1
	ld a, $08 ; $5fb4
	ld bc, $1200 ; $5fb6
	ld de, $0b00 ; $5fb9
	farcall FarPtr_ScriptSetActorMoveTarget ; $5fbc
	ld a, $08 ; $5fbf
	farcall FarPtr_ScriptWaitActorMoveDone ; $5fc1
	ld a, $11 ; $5fc4
	ld b, $40 ; $5fc6
	farcall FarPtr_SetActorFacing ; $5fc8
	ld a, $12 ; $5fcb
	ld b, $40 ; $5fcd
	farcall FarPtr_SetActorFacing ; $5fcf
	ld a, $08 ; $5fd2
	farcall FarPtr_ScriptShowSpeakerDialogue ; $5fd4
	call Func_0e_6f2b ; $5fd7
	ld a, $0f ; $5fda
	ld bc, $1300 ; $5fdc
	ld de, $0f00 ; $5fdf
	farcall FarPtr_ScriptSetActorMoveTarget ; $5fe2
	ld a, $10 ; $5fe5
	ld bc, $1100 ; $5fe7
	ld de, $0f00 ; $5fea
	farcall FarPtr_ScriptSetActorMoveTarget ; $5fed
	ld a, $0e ; $5ff0
	ld bc, $1500 ; $5ff2
	ld de, $0f00 ; $5ff5
	farcall FarPtr_ScriptSetActorMoveTarget ; $5ff8
	ld a, $0e ; $5ffb
	farcall FarPtr_ScriptWaitActorMoveDone ; $5ffd
	ld a, $0e ; $6000
	ld bc, $1500 ; $6002
	ld de, $1300 ; $6005
	farcall FarPtr_ScriptSetActorMoveTarget ; $6008
	ld a, $0e ; $600b
	farcall FarPtr_ScriptWaitActorMoveDone ; $600d
	ld a, $0e ; $6010
	ld bc, $1300 ; $6012
	ld de, $1300 ; $6015
	farcall FarPtr_ScriptSetActorMoveTarget ; $6018
	ld a, $0e ; $601b
	farcall FarPtr_ScriptWaitActorMoveDone ; $601d
	ld a, $0e ; $6020
	ld b, $c0 ; $6022
	farcall FarPtr_SetActorFacing ; $6024
	push af ; $6027
	ld a, $28 ; $6028
	farcall FarPtr_WaitScriptFrames ; $602a
	pop af ; $602d
	set_flag $16, 3 ; $602e
	farcall FarPtr_03_18 ; $6031
	ld a, $08 ; $6034
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $6036
	farcall FarPtr_RunDialogueYesNoPrompt ; $6039
	farcall FarPtr_ScriptCloseDialogueWindow ; $603c
	push af ; $603f
	ld a, $05 ; $6040
	farcall FarPtr_WaitScriptFrames ; $6042
	pop af ; $6045
	and a, a ; $6046
	jr z, ExhibitionAcceptedDoubles ; $6047
	ld hl, $307d ; $6049
	farcall FarPtr_InitDialogueTextCursor ; $604c
	call ExhibitionDeclinedCutscene ; $604f
	ld a, $02 ; $6052
	farcall FarPtr_GetActorStateAddr ; $6054
	ld c, l ; $6057
	ld b, h ; $6058
	ld de, $d000 ; $6059
	farcall FarPtr_04_20 ; $605c
	ret ; $605f
ExhibitionAcceptedDoubles:
	push af ; $6060
	ld a, $0a ; $6061
	farcall FarPtr_WaitScriptFrames ; $6063
	pop af ; $6066
	ld a, $0f ; $6067
	ld d, $03 ; $6069
	farcall FarPtr_ScriptSetActorAnimation ; $606b
	ld a, $0f ; $606e
	farcall FarPtr_ScriptWaitActorIdle ; $6070
	push af ; $6073
	ld a, $0a ; $6074
	farcall FarPtr_WaitScriptFrames ; $6076
	pop af ; $6079
	ld hl, $3080 ; $607a
	farcall FarPtr_InitDialogueTextCursor ; $607d
	ld a, $0f ; $6080
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6082
	ld a, $08 ; $6085
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6087
	ld a, $0b ; $608a
	ld b, $c0 ; $608c
	farcall FarPtr_SetActorFacing ; $608e
	push af ; $6091
	ld a, $04 ; $6092
	farcall FarPtr_WaitScriptFrames ; $6094
	pop af ; $6097
	ld a, $0f ; $6098
	ld b, $c0 ; $609a
	farcall FarPtr_SetActorFacing ; $609c
	push af ; $609f
	ld a, $04 ; $60a0
	farcall FarPtr_WaitScriptFrames ; $60a2
	pop af ; $60a5
	ld a, $10 ; $60a6
	ld b, $c0 ; $60a8
	farcall FarPtr_SetActorFacing ; $60aa
	push af ; $60ad
	ld a, $04 ; $60ae
	farcall FarPtr_WaitScriptFrames ; $60b0
	pop af ; $60b3
	ld a, $0a ; $60b4
	ld b, $c0 ; $60b6
	farcall FarPtr_SetActorFacing ; $60b8
	push af ; $60bb
	ld a, $04 ; $60bc
	farcall FarPtr_WaitScriptFrames ; $60be
	pop af ; $60c1
	ld a, $09 ; $60c2
	ld b, $c0 ; $60c4
	farcall FarPtr_SetActorFacing ; $60c6
	push af ; $60c9
	ld a, $04 ; $60ca
	farcall FarPtr_WaitScriptFrames ; $60cc
	pop af ; $60cf
	ld a, $0e ; $60d0
	ld b, $c0 ; $60d2
	farcall FarPtr_SetActorFacing ; $60d4
	push af ; $60d7
	ld a, $0a ; $60d8
	farcall FarPtr_WaitScriptFrames ; $60da
	pop af ; $60dd
	ld a, $0f ; $60de
	ld d, $03 ; $60e0
	farcall FarPtr_ScriptSetActorAnimation ; $60e2
	ld a, $10 ; $60e5
	ld d, $03 ; $60e7
	farcall FarPtr_ScriptSetActorAnimation ; $60e9
	ld a, $0e ; $60ec
	ld d, $03 ; $60ee
	farcall FarPtr_ScriptSetActorAnimation ; $60f0
	ld a, $11 ; $60f3
	ld d, $03 ; $60f5
	farcall FarPtr_ScriptSetActorAnimation ; $60f7
	ld a, $12 ; $60fa
	ld d, $03 ; $60fc
	farcall FarPtr_ScriptSetActorAnimation ; $60fe
	ld a, $0b ; $6101
	ld d, $03 ; $6103
	farcall FarPtr_ScriptSetActorAnimation ; $6105
	ld a, $0a ; $6108
	ld d, $03 ; $610a
	farcall FarPtr_ScriptSetActorAnimation ; $610c
	ld a, $09 ; $610f
	ld d, $03 ; $6111
	farcall FarPtr_ScriptSetActorAnimation ; $6113
	ld a, $0c ; $6116
	ld d, $03 ; $6118
	farcall FarPtr_ScriptSetActorAnimation ; $611a
	ld a, $13 ; $611d
	ld d, $03 ; $611f
	farcall FarPtr_ScriptSetActorAnimation ; $6121
	ld a, $13 ; $6124
	farcall FarPtr_ScriptWaitActorIdle ; $6126
	ld bc, $0010 ; $6129
	farcall FarPtr_0a_38 ; $612c
	xor a, a ; $612f
	ld bc, $1500 ; $6130
	ld de, $0d00 ; $6133
	farcall FarPtr_MovePlayerToPosition ; $6136
	ld a, $08 ; $6139
	ld bc, $0014 ; $613b
	farcall FarPtr_0a_18 ; $613e
	ld a, $0f ; $6141
	ld bc, $0014 ; $6143
	farcall FarPtr_0a_18 ; $6146
	ld a, $10 ; $6149
	ld bc, $0014 ; $614b
	farcall FarPtr_0a_18 ; $614e
	ld a, $0e ; $6151
	ld bc, $0014 ; $6153
	farcall FarPtr_0a_18 ; $6156
	ld a, $11 ; $6159
	ld bc, $0014 ; $615b
	farcall FarPtr_0a_18 ; $615e
	ld a, $12 ; $6161
	ld bc, $0014 ; $6163
	farcall FarPtr_0a_18 ; $6166
	ld a, $0b ; $6169
	ld bc, $0014 ; $616b
	farcall FarPtr_0a_18 ; $616e
	ld a, $0a ; $6171
	ld bc, $0014 ; $6173
	farcall FarPtr_0a_18 ; $6176
	ld a, $09 ; $6179
	ld bc, $0014 ; $617b
	farcall FarPtr_0a_18 ; $617e
	ld a, $0d ; $6181
	ld bc, $0014 ; $6183
	farcall FarPtr_0a_18 ; $6186
	ld a, $0c ; $6189
	ld bc, $0014 ; $618b
	farcall FarPtr_0a_18 ; $618e
	ld a, $13 ; $6191
	ld bc, $0014 ; $6193
	farcall FarPtr_0a_18 ; $6196
	ld a, $00 ; $6199
	ld bc, $0014 ; $619b
	farcall FarPtr_0a_18 ; $619e
	ldh a, [hRomBank] ; $61a1
	ld b, a ; $61a3
	ld a, $11 ; $61a4
	ld de, $552d ; $61a6
	farcall FarPtr_0a_1a ; $61a9
	push af ; $61ac
	ld a, $14 ; $61ad
	farcall FarPtr_WaitScriptFrames ; $61af
	pop af ; $61b2
	ldh a, [hRomBank] ; $61b3
	ld b, a ; $61b5
	ld a, $08 ; $61b6
	ld de, $552d ; $61b8
	farcall FarPtr_0a_1a ; $61bb
	push af ; $61be
	ld a, $14 ; $61bf
	farcall FarPtr_WaitScriptFrames ; $61c1
	pop af ; $61c4
	ldh a, [hRomBank] ; $61c5
	ld b, a ; $61c7
	ld a, $12 ; $61c8
	ld de, $552d ; $61ca
	farcall FarPtr_0a_1a ; $61cd
	push af ; $61d0
	ld a, $64 ; $61d1
	farcall FarPtr_WaitScriptFrames ; $61d3
	pop af ; $61d6
	ldh a, [hRomBank] ; $61d7
	ld b, a ; $61d9
	ld a, $0b ; $61da
	ld de, $552d ; $61dc
	farcall FarPtr_0a_1a ; $61df
	ldh a, [hRomBank] ; $61e2
	ld b, a ; $61e4
	ld a, $0a ; $61e5
	ld de, $552d ; $61e7
	farcall FarPtr_0a_1a ; $61ea
	ldh a, [hRomBank] ; $61ed
	ld b, a ; $61ef
	ld a, $09 ; $61f0
	ld de, $552d ; $61f2
	farcall FarPtr_0a_1a ; $61f5
	ldh a, [hRomBank] ; $61f8
	ld b, a ; $61fa
	ld a, $0c ; $61fb
	ld de, $552d ; $61fd
	farcall FarPtr_0a_1a ; $6200
	ldh a, [hRomBank] ; $6203
	ld b, a ; $6205
	ld a, $0d ; $6206
	ld de, $552d ; $6208
	farcall FarPtr_0a_1a ; $620b
	push af ; $620e
	ld a, $3c ; $620f
	farcall FarPtr_WaitScriptFrames ; $6211
	pop af ; $6214
	ldh a, [hRomBank] ; $6215
	ld b, a ; $6217
	ld a, $0f ; $6218
	ld de, $552d ; $621a
	farcall FarPtr_0a_1a ; $621d
	ldh a, [hRomBank] ; $6220
	ld b, a ; $6222
	ld a, $10 ; $6223
	ld de, $552d ; $6225
	farcall FarPtr_0a_1a ; $6228
	push af ; $622b
	ld a, $1e ; $622c
	farcall FarPtr_WaitScriptFrames ; $622e
	pop af ; $6231
	ld a, $0e ; $6232
	ld bc, $1500 ; $6234
	ld de, $1300 ; $6237
	farcall FarPtr_ScriptSetActorMoveTarget ; $623a
	ld a, $0e ; $623d
	farcall FarPtr_ScriptWaitActorMoveDone ; $623f
	ldh a, [hRomBank] ; $6242
	ld b, a ; $6244
	ld a, $0e ; $6245
	ld de, $552d ; $6247
	farcall FarPtr_0a_1a ; $624a
	ld a, $0e ; $624d
	farcall FarPtr_WaitActorScriptDone ; $624f
	xor a, a ; $6252
	ld bc, $1200 ; $6253
	ld de, $0d00 ; $6256
	farcall FarPtr_MovePlayerToPosition ; $6259
	ld a, $13 ; $625c
	ld bc, $1000 ; $625e
	ld de, $0f00 ; $6261
	farcall FarPtr_ScriptSetActorMoveTarget ; $6264
	ld a, $13 ; $6267
	farcall FarPtr_ScriptWaitActorMoveDone ; $6269
	ld a, $13 ; $626c
	ld bc, $1200 ; $626e
	ld de, $0f00 ; $6271
	farcall FarPtr_ScriptSetActorMoveTarget ; $6274
	ld a, $13 ; $6277
	farcall FarPtr_ScriptWaitActorMoveDone ; $6279
	ld a, $13 ; $627c
	ld b, $40 ; $627e
	farcall FarPtr_SetActorFacing ; $6280
	push af ; $6283
	ld a, $14 ; $6284
	farcall FarPtr_WaitScriptFrames ; $6286
	pop af ; $6289
	ld a, $13 ; $628a
	farcall FarPtr_ScriptShowSpeakerDialogue ; $628c
	push af ; $628f
	ld a, $0a ; $6290
	farcall FarPtr_WaitScriptFrames ; $6292
	pop af ; $6295
	ld a, $02 ; $6296
	ld d, $03 ; $6298
	farcall FarPtr_ScriptSetActorAnimation ; $629a
	ld a, $00 ; $629d
	ld d, $03 ; $629f
	farcall FarPtr_ScriptSetActorAnimation ; $62a1
	ld a, $00 ; $62a4
	farcall FarPtr_ScriptWaitActorIdle ; $62a6
	push af ; $62a9
	ld a, $14 ; $62aa
	farcall FarPtr_WaitScriptFrames ; $62ac
	pop af ; $62af
	ldh a, [hRomBank] ; $62b0
	ld b, a ; $62b2
	ld a, $13 ; $62b3
	ld de, $5545 ; $62b5
	farcall FarPtr_0a_1a ; $62b8
	push af ; $62bb
	ld a, $14 ; $62bc
	farcall FarPtr_WaitScriptFrames ; $62be
	pop af ; $62c1
	ldh a, [hRomBank] ; $62c2
	ld b, a ; $62c4
	ld a, $00 ; $62c5
	ld de, $5545 ; $62c7
	farcall FarPtr_0a_1a ; $62ca
	push af ; $62cd
	ld a, $32 ; $62ce
	farcall FarPtr_WaitScriptFrames ; $62d0
	pop af ; $62d3
	ldh a, [hRomBank] ; $62d4
	ld b, a ; $62d6
	ld a, $02 ; $62d7
	ld de, $5545 ; $62d9
	farcall FarPtr_0a_1a ; $62dc
	push af ; $62df
	ld a, $3c ; $62e0
	farcall FarPtr_WaitScriptFrames ; $62e2
	pop af ; $62e5
	xor a, a ; $62e6
	ld bc, $1500 ; $62e7
	ld de, $0d00 ; $62ea
	farcall FarPtr_MovePlayerToPosition ; $62ed
	ld a, $02 ; $62f0
	farcall FarPtr_WaitActorScriptDone ; $62f2
	call Func_0e_7150 ; $62f5
	ld a, $1c ; $62f8
	ld [wStoryModeCurrentLocation], a ; $62fa
	ld a, $04 ; $62fd
	ld [$c295], a ; $62ff
	ld a, $ff ; $6302
	ld [$c294], a ; $6304
	ld [$c2a1], a ; $6307
	ret ; $630a
	INCBIN "data/bank_00e/d_630b.bin" ; $630b, 316 bytes
	farcall FarPtr_0a_1a ; $6447
	call MoveDoublesPartnerToPlayer ; $644a
	ld a, $08 ; $644d
	ld b, $40 ; $644f
	farcall FarPtr_SetActorFacing ; $6451
	ldh a, [hRomBank] ; $6454
	ld b, a ; $6456
	ld a, $00 ; $6457
	ld de, $63da ; $6459
	farcall FarPtr_0a_1a ; $645c
	push af ; $645f
	ld a, $14 ; $6460
	farcall FarPtr_WaitScriptFrames ; $6462
	pop af ; $6465
	ldh a, [hRomBank] ; $6466
	ld b, a ; $6468
	ld a, $02 ; $6469
	ld de, $63e7 ; $646b
	farcall FarPtr_0a_1a ; $646e
	ld a, $00 ; $6471
	farcall FarPtr_WaitActorScriptDone ; $6473
	ld a, $02 ; $6476
	farcall FarPtr_WaitActorScriptDone ; $6478
	jp PromptExhibitionMatch ; $647b
	INCBIN "data/bank_00e/d_647e.bin" ; $647e, 238 bytes
	farcall FarPtr_ScriptSetActorMoveTarget ; $656c
	ld a, $00 ; $656f
	farcall FarPtr_ScriptWaitActorMoveDone ; $6571
	ld a, $00 ; $6574
	ld bc, $1200 ; $6576
	ld de, $0d00 ; $6579
	farcall FarPtr_ScriptSetActorMoveTarget ; $657c
	ld a, $00 ; $657f
	farcall FarPtr_ScriptWaitActorMoveDone ; $6581
	ld a, $00 ; $6584
	ld b, $c0 ; $6586
	farcall FarPtr_SetActorFacing ; $6588
	ld a, $08 ; $658b
	ld b, $40 ; $658d
	farcall FarPtr_SetActorFacing ; $658f
	jp PromptExhibitionMatch ; $6592
	ldh a, [hRomBank] ; $6595
	ld b, a ; $6597
	ld a, $02 ; $6598
	ld de, $7c6e ; $659a
	farcall FarPtr_0a_1a ; $659d
	call MoveDoublesPartnerToPlayer ; $65a0
	ld a, $08 ; $65a3
	ld b, $40 ; $65a5
	farcall FarPtr_SetActorFacing ; $65a7
	ldh a, [hRomBank] ; $65aa
	ld b, a ; $65ac
	ld a, $00 ; $65ad
	ld de, $6529 ; $65af
	farcall FarPtr_0a_1a ; $65b2
	push af ; $65b5
	ld a, $14 ; $65b6
	farcall FarPtr_WaitScriptFrames ; $65b8
	pop af ; $65bb
	ldh a, [hRomBank] ; $65bc
	ld b, a ; $65be
	ld a, $02 ; $65bf
	ld de, $653c ; $65c1
	farcall FarPtr_0a_1a ; $65c4
	ld a, $00 ; $65c7
	farcall FarPtr_WaitActorScriptDone ; $65c9
	ld a, $02 ; $65cc
	farcall FarPtr_WaitActorScriptDone ; $65ce
	jp PromptExhibitionMatch ; $65d1
PromptExhibitionMatch:
	farcall FarPtr_0a_00 ; $65d4
	ld bc, $0018 ; $65d7
	farcall FarPtr_0a_38 ; $65da
	xor a, a ; $65dd
	ld bc, $1200 ; $65de
	ld de, $0d00 ; $65e1
	farcall FarPtr_MovePlayerToPosition ; $65e4
	farcall FarPtr_WaitPlayerMoveDone ; $65e7
	ld a, $02 ; $65ea
	ld [wWaterSpriteMinigameTimer], a ; $65ec
	ld hl, $c2b2 ; $65ef
	ld de, $3083 ; $65f2
	ld a, e ; $65f5
	ld [hl+], a ; $65f6
	ld [hl], d ; $65f7
	test_flag $05, 7 ; $65f8
	jr z, Label_0e_660b ; $65fb
	ld a, $05 ; $65fd
	ld [wWaterSpriteMinigameTimer], a ; $65ff
	ld hl, $c2b2 ; $6602
	ld de, $3089 ; $6605
	ld a, e ; $6608
	ld [hl+], a ; $6609
	ld [hl], d ; $660a
Label_0e_660b:
	ld hl, $c2b2 ; $660b
	ld a, [hl+] ; $660e
	ld h, [hl] ; $660f
	ld l, a ; $6610
	farcall FarPtr_InitDialogueTextCursor ; $6611
	ld a, $08 ; $6614
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $6616
	farcall FarPtr_RunDialogueYesNoPrompt ; $6619
	farcall FarPtr_ScriptCloseDialogueWindow ; $661c
	push af ; $661f
	ld a, $05 ; $6620
	farcall FarPtr_WaitScriptFrames ; $6622
	pop af ; $6625
	and a, a ; $6626
	jr z, Label_0e_6644 ; $6627
	ld a, $08 ; $6629
	farcall FarPtr_ScriptShowSpeakerDialogue ; $662b
	test_flag $05, 7 ; $662e
	jr z, Label_0e_6640 ; $6631
	ld a, $02 ; $6633
	farcall FarPtr_GetActorStateAddr ; $6635
	ld c, l ; $6638
	ld b, h ; $6639
	ld de, $d000 ; $663a
	farcall FarPtr_04_20 ; $663d
Label_0e_6640:
	farcall FarPtr_0a_02 ; $6640
	ret ; $6643
Label_0e_6644:
	ld a, [$c2b0] ; $6644
	and a, $01 ; $6647
	jr z, Label_0e_666e ; $6649
	farcall FarPtr_AdvanceDialogueTextCursor ; $664b
	ld a, $08 ; $664e
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6650
	ld hl, $3088 ; $6653
	ld de, $0101 ; $6656
	ld a, $01 ; $6659
	farcall FarPtr_RunPagedTextMenu ; $665b
	cp a, $ff ; $665e
	jp z, Label_0e_660b ; $6660
	inc a ; $6663
	test_flag $05, 7 ; $6664
	jr z, Label_0e_666b ; $6667
	add a, $03 ; $6669
Label_0e_666b:
	ld [wWaterSpriteMinigameTimer], a ; $666b
Label_0e_666e:
	ld hl, $c2b2 ; $666e
	ld a, [hl+] ; $6671
	ld h, [hl] ; $6672
	ld l, a ; $6673
	ld a, $03 ; $6674
	add a, l ; $6676
	ld l, a ; $6677
	jr nc, Label_0e_667b ; $6678
	inc h ; $667a
Label_0e_667b:
	farcall FarPtr_InitDialogueTextCursor ; $667b
	ld a, $08 ; $667e
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6680
	ld a, $0b ; $6683
	ld b, $c0 ; $6685
	farcall FarPtr_SetActorFacing ; $6687
	push af ; $668a
	ld a, $04 ; $668b
	farcall FarPtr_WaitScriptFrames ; $668d
	pop af ; $6690
	ld a, $0f ; $6691
	ld b, $c0 ; $6693
	farcall FarPtr_SetActorFacing ; $6695
	push af ; $6698
	ld a, $04 ; $6699
	farcall FarPtr_WaitScriptFrames ; $669b
	pop af ; $669e
	ld a, $10 ; $669f
	ld b, $c0 ; $66a1
	farcall FarPtr_SetActorFacing ; $66a3
	push af ; $66a6
	ld a, $04 ; $66a7
	farcall FarPtr_WaitScriptFrames ; $66a9
	pop af ; $66ac
	ld a, $0a ; $66ad
	ld b, $c0 ; $66af
	farcall FarPtr_SetActorFacing ; $66b1
	push af ; $66b4
	ld a, $04 ; $66b5
	farcall FarPtr_WaitScriptFrames ; $66b7
	pop af ; $66ba
	ld a, $09 ; $66bb
	ld b, $c0 ; $66bd
	farcall FarPtr_SetActorFacing ; $66bf
	push af ; $66c2
	ld a, $04 ; $66c3
	farcall FarPtr_WaitScriptFrames ; $66c5
	pop af ; $66c8
	ld a, $0e ; $66c9
	ld b, $c0 ; $66cb
	farcall FarPtr_SetActorFacing ; $66cd
	push af ; $66d0
	ld a, $0a ; $66d1
	farcall FarPtr_WaitScriptFrames ; $66d3
	pop af ; $66d6
	ld a, $0f ; $66d7
	ld d, $03 ; $66d9
	farcall FarPtr_ScriptSetActorAnimation ; $66db
	ld a, $10 ; $66de
	ld d, $03 ; $66e0
	farcall FarPtr_ScriptSetActorAnimation ; $66e2
	ld a, $0e ; $66e5
	ld d, $03 ; $66e7
	farcall FarPtr_ScriptSetActorAnimation ; $66e9
	ld a, $11 ; $66ec
	ld d, $03 ; $66ee
	farcall FarPtr_ScriptSetActorAnimation ; $66f0
	ld a, $12 ; $66f3
	ld d, $03 ; $66f5
	farcall FarPtr_ScriptSetActorAnimation ; $66f7
	ld a, $0b ; $66fa
	ld d, $03 ; $66fc
	farcall FarPtr_ScriptSetActorAnimation ; $66fe
	ld a, $0a ; $6701
	ld d, $03 ; $6703
	farcall FarPtr_ScriptSetActorAnimation ; $6705
	ld a, $09 ; $6708
	ld d, $03 ; $670a
	farcall FarPtr_ScriptSetActorAnimation ; $670c
	ld a, $0c ; $670f
	ld d, $03 ; $6711
	farcall FarPtr_ScriptSetActorAnimation ; $6713
	ld a, $13 ; $6716
	ld d, $03 ; $6718
	farcall FarPtr_ScriptSetActorAnimation ; $671a
	ld a, $13 ; $671d
	farcall FarPtr_ScriptWaitActorIdle ; $671f
	ld bc, $0018 ; $6722
	farcall FarPtr_0a_38 ; $6725
	xor a, a ; $6728
	ld bc, $1500 ; $6729
	ld de, $0d00 ; $672c
	farcall FarPtr_MovePlayerToPosition ; $672f
	ld a, $08 ; $6732
	ld bc, $0020 ; $6734
	farcall FarPtr_0a_18 ; $6737
	ld a, $0f ; $673a
	ld bc, $0020 ; $673c
	farcall FarPtr_0a_18 ; $673f
	ld a, $10 ; $6742
	ld bc, $0020 ; $6744
	farcall FarPtr_0a_18 ; $6747
	ld a, $0e ; $674a
	ld bc, $0020 ; $674c
	farcall FarPtr_0a_18 ; $674f
	ld a, $11 ; $6752
	ld bc, $0020 ; $6754
	farcall FarPtr_0a_18 ; $6757
	ld a, $12 ; $675a
	ld bc, $0020 ; $675c
	farcall FarPtr_0a_18 ; $675f
	ld a, $0b ; $6762
	ld bc, $0020 ; $6764
	farcall FarPtr_0a_18 ; $6767
	ld a, $0a ; $676a
	ld bc, $0020 ; $676c
	farcall FarPtr_0a_18 ; $676f
	ld a, $09 ; $6772
	ld bc, $0020 ; $6774
	farcall FarPtr_0a_18 ; $6777
	ld a, $0d ; $677a
	ld bc, $0020 ; $677c
	farcall FarPtr_0a_18 ; $677f
	ld a, $0c ; $6782
	ld bc, $0020 ; $6784
	farcall FarPtr_0a_18 ; $6787
	ld a, $13 ; $678a
	ld bc, $0020 ; $678c
	farcall FarPtr_0a_18 ; $678f
	ld a, $00 ; $6792
	ld bc, $0020 ; $6794
	farcall FarPtr_0a_18 ; $6797
	ld a, $12 ; $679a
	ld b, $00 ; $679c
	farcall FarPtr_SetActorFacing ; $679e
	push af ; $67a1
	ld a, $0a ; $67a2
	farcall FarPtr_WaitScriptFrames ; $67a4
	pop af ; $67a7
	ld a, $08 ; $67a8
	ld b, $00 ; $67aa
	farcall FarPtr_SetActorFacing ; $67ac
	push af ; $67af
	ld a, $0a ; $67b0
	farcall FarPtr_WaitScriptFrames ; $67b2
	pop af ; $67b5
	ld a, $11 ; $67b6
	ld b, $00 ; $67b8
	farcall FarPtr_SetActorFacing ; $67ba
	push af ; $67bd
	ld a, $14 ; $67be
	farcall FarPtr_WaitScriptFrames ; $67c0
	pop af ; $67c3
	ldh a, [hRomBank] ; $67c4
	ld b, a ; $67c6
	ld a, $12 ; $67c7
	ld de, $552d ; $67c9
	farcall FarPtr_0a_1a ; $67cc
	push af ; $67cf
	ld a, $14 ; $67d0
	farcall FarPtr_WaitScriptFrames ; $67d2
	pop af ; $67d5
	ldh a, [hRomBank] ; $67d6
	ld b, a ; $67d8
	ld a, $08 ; $67d9
	ld de, $552d ; $67db
	farcall FarPtr_0a_1a ; $67de
	push af ; $67e1
	ld a, $14 ; $67e2
	farcall FarPtr_WaitScriptFrames ; $67e4
	pop af ; $67e7
	ldh a, [hRomBank] ; $67e8
	ld b, a ; $67ea
	ld a, $11 ; $67eb
	ld de, $552d ; $67ed
	farcall FarPtr_0a_1a ; $67f0
	push af ; $67f3
	ld a, $64 ; $67f4
	farcall FarPtr_WaitScriptFrames ; $67f6
	pop af ; $67f9
	test_flag $05, 7 ; $67fa
	jr nz, Label_0e_680c ; $67fd
	ld a, $00 ; $67ff
	ld bc, $1200 ; $6801
	ld de, $0900 ; $6804
	farcall FarPtr_ScriptSetActorMoveTarget ; $6807
	jr Label_0e_682a ; $680a
Label_0e_680c:
	ld a, $02 ; $680c
	ld bc, $0020 ; $680e
	farcall FarPtr_0a_18 ; $6811
	ld a, $00 ; $6814
	ld bc, $1100 ; $6816
	ld de, $0900 ; $6819
	farcall FarPtr_ScriptSetActorMoveTarget ; $681c
	ld a, $02 ; $681f
	ld bc, $1300 ; $6821
	ld de, $0900 ; $6824
	farcall FarPtr_ScriptSetActorMoveTarget ; $6827
Label_0e_682a:
	ldh a, [hRomBank] ; $682a
	ld b, a ; $682c
	ld a, $0b ; $682d
	ld de, $552d ; $682f
	farcall FarPtr_0a_1a ; $6832
	ldh a, [hRomBank] ; $6835
	ld b, a ; $6837
	ld a, $0a ; $6838
	ld de, $552d ; $683a
	farcall FarPtr_0a_1a ; $683d
	ldh a, [hRomBank] ; $6840
	ld b, a ; $6842
	ld a, $09 ; $6843
	ld de, $552d ; $6845
	farcall FarPtr_0a_1a ; $6848
	ldh a, [hRomBank] ; $684b
	ld b, a ; $684d
	ld a, $0c ; $684e
	ld de, $552d ; $6850
	farcall FarPtr_0a_1a ; $6853
	ldh a, [hRomBank] ; $6856
	ld b, a ; $6858
	ld a, $0d ; $6859
	ld de, $552d ; $685b
	farcall FarPtr_0a_1a ; $685e
	push af ; $6861
	ld a, $1e ; $6862
	farcall FarPtr_WaitScriptFrames ; $6864
	pop af ; $6867
	ld a, $00 ; $6868
	ld b, $40 ; $686a
	farcall FarPtr_SetActorFacing ; $686c
	test_flag $05, 7 ; $686f
	jr z, Label_0e_687b ; $6872
	ld a, $02 ; $6874
	ld b, $40 ; $6876
	farcall FarPtr_SetActorFacing ; $6878
Label_0e_687b:
	ldh a, [hRomBank] ; $687b
	ld b, a ; $687d
	ld a, $0f ; $687e
	ld de, $552d ; $6880
	farcall FarPtr_0a_1a ; $6883
	push af ; $6886
	ld a, $28 ; $6887
	farcall FarPtr_WaitScriptFrames ; $6889
	pop af ; $688c
	ldh a, [hRomBank] ; $688d
	ld b, a ; $688f
	ld a, $10 ; $6890
	ld de, $552d ; $6892
	farcall FarPtr_0a_1a ; $6895
	push af ; $6898
	ld a, $14 ; $6899
	farcall FarPtr_WaitScriptFrames ; $689b
	pop af ; $689e
	ldh a, [hRomBank] ; $689f
	ld b, a ; $68a1
	ld a, $0e ; $68a2
	ld de, $552d ; $68a4
	farcall FarPtr_0a_1a ; $68a7
	ld a, $0e ; $68aa
	farcall FarPtr_WaitActorScriptDone ; $68ac
	xor a, a ; $68af
	ld bc, $1200 ; $68b0
	ld de, $0d00 ; $68b3
	farcall FarPtr_MovePlayerToPosition ; $68b6
	test_flag $05, 7 ; $68b9
	jr nz, Label_0e_68cb ; $68bc
	ld a, $00 ; $68be
	ld bc, $1200 ; $68c0
	ld de, $0b00 ; $68c3
	farcall FarPtr_ScriptSetActorMoveTarget ; $68c6
	jr Label_0e_68e1 ; $68c9
Label_0e_68cb:
	ld a, $00 ; $68cb
	ld bc, $1100 ; $68cd
	ld de, $0b00 ; $68d0
	farcall FarPtr_ScriptSetActorMoveTarget ; $68d3
	ld a, $02 ; $68d6
	ld bc, $1300 ; $68d8
	ld de, $0b00 ; $68db
	farcall FarPtr_ScriptSetActorMoveTarget ; $68de
Label_0e_68e1:
	ld a, $13 ; $68e1
	ld bc, $1200 ; $68e3
	ld de, $0d00 ; $68e6
	farcall FarPtr_ScriptSetActorMoveTarget ; $68e9
	ld a, $13 ; $68ec
	farcall FarPtr_ScriptWaitActorMoveDone ; $68ee
	ld a, $13 ; $68f1
	ld b, $c0 ; $68f3
	farcall FarPtr_SetActorFacing ; $68f5
	push af ; $68f8
	ld a, $14 ; $68f9
	farcall FarPtr_WaitScriptFrames ; $68fb
	pop af ; $68fe
	ld a, $13 ; $68ff
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6901
	push af ; $6904
	ld a, $0a ; $6905
	farcall FarPtr_WaitScriptFrames ; $6907
	pop af ; $690a
	ld a, $00 ; $690b
	ld d, $03 ; $690d
	farcall FarPtr_ScriptSetActorAnimation ; $690f
	test_flag $05, 7 ; $6912
	jr z, Label_0e_691e ; $6915
	ld a, $02 ; $6917
	ld d, $03 ; $6919
	farcall FarPtr_ScriptSetActorAnimation ; $691b
Label_0e_691e:
	ld a, $00 ; $691e
	farcall FarPtr_ScriptWaitActorIdle ; $6920
	push af ; $6923
	ld a, $14 ; $6924
	farcall FarPtr_WaitScriptFrames ; $6926
	pop af ; $6929
	ldh a, [hRomBank] ; $692a
	ld b, a ; $692c
	ld a, $13 ; $692d
	ld de, $5545 ; $692f
	farcall FarPtr_0a_1a ; $6932
	push af ; $6935
	ld a, $14 ; $6936
	farcall FarPtr_WaitScriptFrames ; $6938
	pop af ; $693b
	ldh a, [hRomBank] ; $693c
	ld b, a ; $693e
	ld a, $00 ; $693f
	ld de, $5545 ; $6941
	farcall FarPtr_0a_1a ; $6944
	test_flag $05, 7 ; $6947
	jr z, Label_0e_695e ; $694a
	push af ; $694c
	ld a, $28 ; $694d
	farcall FarPtr_WaitScriptFrames ; $694f
	pop af ; $6952
	ldh a, [hRomBank] ; $6953
	ld b, a ; $6955
	ld a, $02 ; $6956
	ld de, $5545 ; $6958
	farcall FarPtr_0a_1a ; $695b
Label_0e_695e:
	xor a, a ; $695e
	ld bc, $1500 ; $695f
	ld de, $0d00 ; $6962
	farcall FarPtr_MovePlayerToPosition ; $6965
	ld a, $00 ; $6968
	farcall FarPtr_WaitActorScriptDone ; $696a
	call Func_0e_7150 ; $696d
	ld a, $1c ; $6970
	ld [wStoryModeCurrentLocation], a ; $6972
	ld a, [wWaterSpriteMinigameTimer] ; $6975
	ld [$c295], a ; $6978
	ld a, $ff ; $697b
	ld [$c294], a ; $697d
	ld [$c2a1], a ; $6980
	farcall FarPtr_0a_02 ; $6983
	ret ; $6986
MoveDoublesPartnerToPlayer:
	wram_bank $04 ; $6987
	ld a, $00 ; $698d
	farcall FarPtr_GetActorStateAddr ; $698f
	ld c, l ; $6992
	ld b, h ; $6993
	ld hl, $000e ; $6994
	add hl, bc ; $6997
	ld a, [hl+] ; $6998
	ld d, [hl] ; $6999
	ld e, a ; $699a
	ld hl, $000c ; $699b
	add hl, bc ; $699e
	ld a, [hl+] ; $699f
	ld b, [hl] ; $69a0
	ld c, a ; $69a1
	ld a, $02 ; $69a2
	farcall FarPtr_ScriptSetActorMoveTarget ; $69a4
	ld a, $02 ; $69a7
	farcall FarPtr_ScriptWaitActorMoveDone ; $69a9
	ret ; $69ac
Label_0e_69ad:
	test_flag $05, 7 ; $69ad
	jp nz, Label_0e_69c5 ; $69b0
Label_0e_69b3:
	test_flag $16, 2 ; $69b3
	ret z ; $69b6
	ld a, $00 ; $69b7
	ld bc, $1200 ; $69b9
	ld de, $0f00 ; $69bc
	farcall FarPtr_ScriptSetActorPosition ; $69bf
	jp Label_0e_69fb ; $69c2
Label_0e_69c5:
	test_flag $16, 3 ; $69c5
	ret z ; $69c8
	farcall FarPtr_0a_00 ; $69c9
	ld bc, $0010 ; $69cc
	farcall FarPtr_0a_38 ; $69cf
	xor a, a ; $69d2
	ld bc, $1100 ; $69d3
	ld de, $0f00 ; $69d6
	farcall FarPtr_MovePlayerToPosition ; $69d9
	farcall FarPtr_WaitPlayerMoveDone ; $69dc
	ld a, $00 ; $69df
	ld bc, $1100 ; $69e1
	ld de, $0f00 ; $69e4
	farcall FarPtr_ScriptSetActorPosition ; $69e7
	ld a, $02 ; $69ea
	ld bc, $1300 ; $69ec
	ld de, $0f00 ; $69ef
	farcall FarPtr_ScriptSetActorPosition ; $69f2
	farcall FarPtr_0a_02 ; $69f5
	jp Label_0e_69fb ; $69f8
Label_0e_69fb:
	ld a, $08 ; $69fb
	ld bc, $1200 ; $69fd
	ld de, $0b00 ; $6a00
	farcall FarPtr_ScriptSetActorPosition ; $6a03
	ld a, $10 ; $6a06
	ld b, $00 ; $6a08
	farcall FarPtr_SetActorFacing ; $6a0a
	ld a, $0f ; $6a0d
	ld b, $00 ; $6a0f
	farcall FarPtr_SetActorFacing ; $6a11
	ld a, $0d ; $6a14
	ld b, $00 ; $6a16
	farcall FarPtr_SetActorFacing ; $6a18
	ld a, $0e ; $6a1b
	ld b, $00 ; $6a1d
	farcall FarPtr_SetActorFacing ; $6a1f
	ld a, $0b ; $6a22
	ld b, $80 ; $6a24
	farcall FarPtr_SetActorFacing ; $6a26
	ld a, $0a ; $6a29
	ld b, $80 ; $6a2b
	farcall FarPtr_SetActorFacing ; $6a2d
	ld a, $09 ; $6a30
	ld b, $80 ; $6a32
	farcall FarPtr_SetActorFacing ; $6a34
	ld a, $0c ; $6a37
	ld b, $80 ; $6a39
	farcall FarPtr_SetActorFacing ; $6a3b
	ld a, $13 ; $6a3e
	ld bc, $0d00 ; $6a40
	ld de, $1300 ; $6a43
	farcall FarPtr_ScriptSetActorPosition ; $6a46
	ld a, $13 ; $6a49
	ld b, $00 ; $6a4b
	farcall FarPtr_SetActorFacing ; $6a4d
	ret ; $6a50
Func_0e_6a51:
	ld bc, $0020 ; $6a51
	farcall FarPtr_0a_38 ; $6a54
	xor a, a ; $6a57
	ld bc, $1200 ; $6a58
	ld de, $0f00 ; $6a5b
	farcall FarPtr_MovePlayerToPosition ; $6a5e
	farcall FarPtr_WaitPlayerMoveDone ; $6a61
	push af ; $6a64
	ld a, $28 ; $6a65
	farcall FarPtr_WaitScriptFrames ; $6a67
	pop af ; $6a6a
	ld bc, $0040 ; $6a6b
	farcall FarPtr_0a_38 ; $6a6e
	xor a, a ; $6a71
	ld bc, $1200 ; $6a72
	ld de, $1900 ; $6a75
	farcall FarPtr_MovePlayerToPosition ; $6a78
	farcall FarPtr_WaitPlayerMoveDone ; $6a7b
	sound $97 ; $6a7e
	ld a, $03 ; $6a80
	ld bc, $1000 ; $6a82
	ld de, $1d00 ; $6a85
	farcall FarPtr_ScriptSetActorPosition ; $6a88
	push af ; $6a8b
	ld a, $0a ; $6a8c
	farcall FarPtr_WaitScriptFrames ; $6a8e
	pop af ; $6a91
	ld a, $13 ; $6a92
	ld de, $ff80 ; $6a94
	farcall FarPtr_0a_42 ; $6a97
	ld a, $03 ; $6a9a
	ld de, $ff80 ; $6a9c
	farcall FarPtr_0a_42 ; $6a9f
	push af ; $6aa2
	ld a, $1e ; $6aa3
	farcall FarPtr_WaitScriptFrames ; $6aa5
	pop af ; $6aa8
	ld a, $03 ; $6aa9
	ld bc, $3f00 ; $6aab
	ld de, $3f00 ; $6aae
	farcall FarPtr_ScriptSetActorPosition ; $6ab1
	ld a, $13 ; $6ab4
	ld bc, $0040 ; $6ab6
	farcall FarPtr_0a_18 ; $6ab9
	ld a, $13 ; $6abc
	ld bc, $0300 ; $6abe
	ld de, rJOYP ; $6ac1
	farcall FarPtr_MoveActorByDelta ; $6ac4
	ld a, $13 ; $6ac7
	farcall FarPtr_ScriptWaitActorMoveDone ; $6ac9
	ld a, $13 ; $6acc
	ld b, $40 ; $6ace
	farcall FarPtr_SetActorFacing ; $6ad0
	ret ; $6ad3
Func_0e_6ad4:
	push af ; $6ad4
	ld a, $0a ; $6ad5
	farcall FarPtr_WaitScriptFrames ; $6ad7
	pop af ; $6ada
	ld a, $08 ; $6adb
	ld b, $40 ; $6add
	farcall FarPtr_SetActorFacing ; $6adf
	push af ; $6ae2
	ld a, $04 ; $6ae3
	farcall FarPtr_WaitScriptFrames ; $6ae5
	pop af ; $6ae8
	ld a, $10 ; $6ae9
	ld b, $00 ; $6aeb
	farcall FarPtr_SetActorFacing ; $6aed
	push af ; $6af0
	ld a, $04 ; $6af1
	farcall FarPtr_WaitScriptFrames ; $6af3
	pop af ; $6af6
	ld a, $0f ; $6af7
	ld b, $00 ; $6af9
	farcall FarPtr_SetActorFacing ; $6afb
	push af ; $6afe
	ld a, $04 ; $6aff
	farcall FarPtr_WaitScriptFrames ; $6b01
	pop af ; $6b04
	ld a, $0d ; $6b05
	ld b, $00 ; $6b07
	farcall FarPtr_SetActorFacing ; $6b09
	push af ; $6b0c
	ld a, $04 ; $6b0d
	farcall FarPtr_WaitScriptFrames ; $6b0f
	pop af ; $6b12
	ld a, $0e ; $6b13
	ld b, $00 ; $6b15
	farcall FarPtr_SetActorFacing ; $6b17
	push af ; $6b1a
	ld a, $04 ; $6b1b
	farcall FarPtr_WaitScriptFrames ; $6b1d
	pop af ; $6b20
	ld a, $0b ; $6b21
	ld b, $80 ; $6b23
	farcall FarPtr_SetActorFacing ; $6b25
	push af ; $6b28
	ld a, $04 ; $6b29
	farcall FarPtr_WaitScriptFrames ; $6b2b
	pop af ; $6b2e
	ld a, $0a ; $6b2f
	ld b, $80 ; $6b31
	farcall FarPtr_SetActorFacing ; $6b33
	push af ; $6b36
	ld a, $04 ; $6b37
	farcall FarPtr_WaitScriptFrames ; $6b39
	pop af ; $6b3c
	ld a, $09 ; $6b3d
	ld b, $80 ; $6b3f
	farcall FarPtr_SetActorFacing ; $6b41
	push af ; $6b44
	ld a, $04 ; $6b45
	farcall FarPtr_WaitScriptFrames ; $6b47
	pop af ; $6b4a
	ld a, $13 ; $6b4b
	ld b, $c0 ; $6b4d
	farcall FarPtr_SetActorFacing ; $6b4f
	push af ; $6b52
	ld a, $04 ; $6b53
	farcall FarPtr_WaitScriptFrames ; $6b55
	pop af ; $6b58
	ld a, $0c ; $6b59
	ld b, $c0 ; $6b5b
	farcall FarPtr_SetActorFacing ; $6b5d
	push af ; $6b60
	ld a, $14 ; $6b61
	farcall FarPtr_WaitScriptFrames ; $6b63
	pop af ; $6b66
	ld a, $08 ; $6b67
	ld d, $03 ; $6b69
	farcall FarPtr_ScriptSetActorAnimation ; $6b6b
	ld a, $08 ; $6b6e
	farcall FarPtr_ScriptWaitActorIdle ; $6b70
	ld a, $08 ; $6b73
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6b75
	push af ; $6b78
	ld a, $14 ; $6b79
	farcall FarPtr_WaitScriptFrames ; $6b7b
	pop af ; $6b7e
	ld a, $11 ; $6b7f
	ld d, $03 ; $6b81
	farcall FarPtr_ScriptSetActorAnimation ; $6b83
	ld a, $11 ; $6b86
	farcall FarPtr_ScriptWaitActorIdle ; $6b88
	ld a, $11 ; $6b8b
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6b8d
	ld a, $08 ; $6b90
	ld b, $80 ; $6b92
	farcall FarPtr_SetActorFacing ; $6b94
	push af ; $6b97
	ld a, $0a ; $6b98
	farcall FarPtr_WaitScriptFrames ; $6b9a
	pop af ; $6b9d
	ld a, $11 ; $6b9e
	ld b, $00 ; $6ba0
	farcall FarPtr_SetActorFacing ; $6ba2
	push af ; $6ba5
	ld a, $14 ; $6ba6
	farcall FarPtr_WaitScriptFrames ; $6ba8
	pop af ; $6bab
	ld a, $11 ; $6bac
	ld d, $03 ; $6bae
	farcall FarPtr_ScriptSetActorAnimation ; $6bb0
	ld a, $08 ; $6bb3
	ld d, $03 ; $6bb5
	farcall FarPtr_ScriptSetActorAnimation ; $6bb7
	ld a, $08 ; $6bba
	farcall FarPtr_ScriptWaitActorIdle ; $6bbc
	push af ; $6bbf
	ld a, $0a ; $6bc0
	farcall FarPtr_WaitScriptFrames ; $6bc2
	pop af ; $6bc5
	ld a, $08 ; $6bc6
	ld b, $40 ; $6bc8
	farcall FarPtr_SetActorFacing ; $6bca
	push af ; $6bcd
	ld a, $0a ; $6bce
	farcall FarPtr_WaitScriptFrames ; $6bd0
	pop af ; $6bd3
	ld a, $11 ; $6bd4
	ld b, $40 ; $6bd6
	farcall FarPtr_SetActorFacing ; $6bd8
	push af ; $6bdb
	ld a, $1e ; $6bdc
	farcall FarPtr_WaitScriptFrames ; $6bde
	pop af ; $6be1
	ld a, $08 ; $6be2
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6be4
	ld a, $08 ; $6be7
	ld b, $00 ; $6be9
	farcall FarPtr_SetActorFacing ; $6beb
	push af ; $6bee
	ld a, $0a ; $6bef
	farcall FarPtr_WaitScriptFrames ; $6bf1
	pop af ; $6bf4
	ld a, $12 ; $6bf5
	ld b, $80 ; $6bf7
	farcall FarPtr_SetActorFacing ; $6bf9
	push af ; $6bfc
	ld a, $14 ; $6bfd
	farcall FarPtr_WaitScriptFrames ; $6bff
	pop af ; $6c02
	ld a, $12 ; $6c03
	ld d, $03 ; $6c05
	farcall FarPtr_ScriptSetActorAnimation ; $6c07
	ld a, $08 ; $6c0a
	ld d, $03 ; $6c0c
	farcall FarPtr_ScriptSetActorAnimation ; $6c0e
	ld a, $08 ; $6c11
	farcall FarPtr_ScriptWaitActorIdle ; $6c13
	push af ; $6c16
	ld a, $0a ; $6c17
	farcall FarPtr_WaitScriptFrames ; $6c19
	pop af ; $6c1c
	ld a, $08 ; $6c1d
	ld b, $40 ; $6c1f
	farcall FarPtr_SetActorFacing ; $6c21
	push af ; $6c24
	ld a, $0a ; $6c25
	farcall FarPtr_WaitScriptFrames ; $6c27
	pop af ; $6c2a
	ld a, $12 ; $6c2b
	ld b, $40 ; $6c2d
	farcall FarPtr_SetActorFacing ; $6c2f
	push af ; $6c32
	ld a, $1e ; $6c33
	farcall FarPtr_WaitScriptFrames ; $6c35
	pop af ; $6c38
	ld a, $08 ; $6c39
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6c3b
	push af ; $6c3e
	ld a, $14 ; $6c3f
	farcall FarPtr_WaitScriptFrames ; $6c41
	pop af ; $6c44
	ld a, $10 ; $6c45
	ld de, $ff80 ; $6c47
	farcall FarPtr_0a_42 ; $6c4a
	push af ; $6c4d
	ld a, $14 ; $6c4e
	farcall FarPtr_WaitScriptFrames ; $6c50
	pop af ; $6c53
	ld a, $10 ; $6c54
	ld b, $c0 ; $6c56
	farcall FarPtr_SetActorFacing ; $6c58
	ld a, $10 ; $6c5b
	ld d, $02 ; $6c5d
	farcall FarPtr_ScriptSetActorAnimation ; $6c5f
	ld a, $10 ; $6c62
	farcall FarPtr_ScriptWaitActorIdle ; $6c64
	ld a, $10 ; $6c67
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6c69
	push af ; $6c6c
	ld a, $0a ; $6c6d
	farcall FarPtr_WaitScriptFrames ; $6c6f
	pop af ; $6c72
	ld a, $0e ; $6c73
	ld de, rLCDC ; $6c75
	farcall FarPtr_0a_42 ; $6c78
	push af ; $6c7b
	ld a, $28 ; $6c7c
	farcall FarPtr_WaitScriptFrames ; $6c7e
	pop af ; $6c81
	ld a, $0e ; $6c82
	ld b, $c0 ; $6c84
	farcall FarPtr_SetActorFacing ; $6c86
	ld a, $0e ; $6c89
	ld d, $02 ; $6c8b
	farcall FarPtr_ScriptSetActorAnimation ; $6c8d
	ld a, $0e ; $6c90
	farcall FarPtr_ScriptWaitActorIdle ; $6c92
	ld a, $0e ; $6c95
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6c97
	push af ; $6c9a
	ld a, $14 ; $6c9b
	farcall FarPtr_WaitScriptFrames ; $6c9d
	pop af ; $6ca0
	sound $96 ; $6ca1
	ld a, $04 ; $6ca3
	ld bc, $0f00 ; $6ca5
	ld de, $0900 ; $6ca8
	farcall FarPtr_ScriptSetActorPosition ; $6cab
	push af ; $6cae
	ld a, $04 ; $6caf
	farcall FarPtr_WaitScriptFrames ; $6cb1
	pop af ; $6cb4
	sound $96 ; $6cb5
	ld a, $05 ; $6cb7
	ld bc, $1300 ; $6cb9
	ld de, $0700 ; $6cbc
	farcall FarPtr_ScriptSetActorPosition ; $6cbf
	push af ; $6cc2
	ld a, $04 ; $6cc3
	farcall FarPtr_WaitScriptFrames ; $6cc5
	pop af ; $6cc8
	sound $96 ; $6cc9
	ld a, $06 ; $6ccb
	ld bc, $1700 ; $6ccd
	ld de, $0900 ; $6cd0
	farcall FarPtr_ScriptSetActorPosition ; $6cd3
	push af ; $6cd6
	ld a, $28 ; $6cd7
	farcall FarPtr_WaitScriptFrames ; $6cd9
	pop af ; $6cdc
	ld a, $08 ; $6cdd
	ld b, $80 ; $6cdf
	farcall FarPtr_SetActorFacing ; $6ce1
	push af ; $6ce4
	ld a, $0a ; $6ce5
	farcall FarPtr_WaitScriptFrames ; $6ce7
	pop af ; $6cea
	ld a, $11 ; $6ceb
	ld b, $00 ; $6ced
	farcall FarPtr_SetActorFacing ; $6cef
	push af ; $6cf2
	ld a, $28 ; $6cf3
	farcall FarPtr_WaitScriptFrames ; $6cf5
	pop af ; $6cf8
	ld a, $08 ; $6cf9
	ld b, $00 ; $6cfb
	farcall FarPtr_SetActorFacing ; $6cfd
	push af ; $6d00
	ld a, $0a ; $6d01
	farcall FarPtr_WaitScriptFrames ; $6d03
	pop af ; $6d06
	ld a, $12 ; $6d07
	ld b, $80 ; $6d09
	farcall FarPtr_SetActorFacing ; $6d0b
	push af ; $6d0e
	ld a, $3c ; $6d0f
	farcall FarPtr_WaitScriptFrames ; $6d11
	pop af ; $6d14
	ld a, $0f ; $6d15
	ld bc, $0e00 ; $6d17
	ld de, $0f00 ; $6d1a
	farcall FarPtr_ScriptSetActorMoveTarget ; $6d1d
	ld a, $0f ; $6d20
	farcall FarPtr_ScriptWaitActorMoveDone ; $6d22
	ld a, $0f ; $6d25
	ld b, $c0 ; $6d27
	farcall FarPtr_SetActorFacing ; $6d29
	push af ; $6d2c
	ld a, $04 ; $6d2d
	farcall FarPtr_WaitScriptFrames ; $6d2f
	pop af ; $6d32
	ld a, $11 ; $6d33
	ld b, $40 ; $6d35
	farcall FarPtr_SetActorFacing ; $6d37
	push af ; $6d3a
	ld a, $04 ; $6d3b
	farcall FarPtr_WaitScriptFrames ; $6d3d
	pop af ; $6d40
	ld a, $08 ; $6d41
	ld b, $40 ; $6d43
	farcall FarPtr_SetActorFacing ; $6d45
	push af ; $6d48
	ld a, $04 ; $6d49
	farcall FarPtr_WaitScriptFrames ; $6d4b
	pop af ; $6d4e
	ld a, $12 ; $6d4f
	ld b, $40 ; $6d51
	farcall FarPtr_SetActorFacing ; $6d53
	push af ; $6d56
	ld a, $14 ; $6d57
	farcall FarPtr_WaitScriptFrames ; $6d59
	pop af ; $6d5c
	ld a, $04 ; $6d5d
	ld bc, $3f00 ; $6d5f
	ld de, $3f00 ; $6d62
	farcall FarPtr_ScriptSetActorPosition ; $6d65
	ld a, $05 ; $6d68
	ld bc, $3f00 ; $6d6a
	ld de, $3f00 ; $6d6d
	farcall FarPtr_ScriptSetActorPosition ; $6d70
	ld a, $06 ; $6d73
	ld bc, $3f00 ; $6d75
	ld de, $3f00 ; $6d78
	farcall FarPtr_ScriptSetActorPosition ; $6d7b
	ld a, $0f ; $6d7e
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6d80
	push af ; $6d83
	ld a, $0a ; $6d84
	farcall FarPtr_WaitScriptFrames ; $6d86
	pop af ; $6d89
	ld a, $0f ; $6d8a
	ld d, $04 ; $6d8c
	farcall FarPtr_ScriptSetActorAnimation ; $6d8e
	ld a, $0f ; $6d91
	farcall FarPtr_ScriptWaitActorIdle ; $6d93
	ld a, $0f ; $6d96
	ld b, $00 ; $6d98
	farcall FarPtr_SetActorFacing ; $6d9a
	sound $99 ; $6d9d
	ld a, $07 ; $6d9f
	ld bc, $0f00 ; $6da1
	ld de, $0d00 ; $6da4
	farcall FarPtr_ScriptSetActorPosition ; $6da7
	push af ; $6daa
	ld a, $14 ; $6dab
	farcall FarPtr_WaitScriptFrames ; $6dad
	pop af ; $6db0
	ld a, $0f ; $6db1
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6db3
	ret ; $6db6
Func_0e_6db7:
	ld a, $0b ; $6db7
	ld de, $ff80 ; $6db9
	farcall FarPtr_0a_42 ; $6dbc
	push af ; $6dbf
	ld a, $14 ; $6dc0
	farcall FarPtr_WaitScriptFrames ; $6dc2
	pop af ; $6dc5
	ld a, $0b ; $6dc6
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6dc8
	ld a, $04 ; $6dcb
	ld bc, $3f00 ; $6dcd
	ld de, $3f00 ; $6dd0
	farcall FarPtr_ScriptSetActorPosition ; $6dd3
	ld a, $05 ; $6dd6
	ld bc, $3f00 ; $6dd8
	ld de, $3f00 ; $6ddb
	farcall FarPtr_ScriptSetActorPosition ; $6dde
	ld a, $06 ; $6de1
	ld bc, $3f00 ; $6de3
	ld de, $3f00 ; $6de6
	farcall FarPtr_ScriptSetActorPosition ; $6de9
	push af ; $6dec
	ld a, $0a ; $6ded
	farcall FarPtr_WaitScriptFrames ; $6def
	pop af ; $6df2
	ld a, $0f ; $6df3
	ld b, $00 ; $6df5
	farcall FarPtr_SetActorFacing ; $6df7
	push af ; $6dfa
	ld a, $04 ; $6dfb
	farcall FarPtr_WaitScriptFrames ; $6dfd
	pop af ; $6e00
	ld a, $10 ; $6e01
	ld b, $00 ; $6e03
	farcall FarPtr_SetActorFacing ; $6e05
	push af ; $6e08
	ld a, $04 ; $6e09
	farcall FarPtr_WaitScriptFrames ; $6e0b
	pop af ; $6e0e
	ld a, $0e ; $6e0f
	ld b, $00 ; $6e11
	farcall FarPtr_SetActorFacing ; $6e13
	push af ; $6e16
	ld a, $04 ; $6e17
	farcall FarPtr_WaitScriptFrames ; $6e19
	pop af ; $6e1c
	ld a, $08 ; $6e1d
	ld b, $00 ; $6e1f
	farcall FarPtr_SetActorFacing ; $6e21
	ld a, $0a ; $6e24
	ld b, $c0 ; $6e26
	farcall FarPtr_SetActorFacing ; $6e28
	push af ; $6e2b
	ld a, $04 ; $6e2c
	farcall FarPtr_WaitScriptFrames ; $6e2e
	pop af ; $6e31
	ld a, $11 ; $6e32
	ld b, $00 ; $6e34
	farcall FarPtr_SetActorFacing ; $6e36
	ld a, $09 ; $6e39
	ld b, $c0 ; $6e3b
	farcall FarPtr_SetActorFacing ; $6e3d
	ld a, $0b ; $6e40
	ld bc, $0020 ; $6e42
	farcall FarPtr_0a_18 ; $6e45
	ld a, $0b ; $6e48
	ld bc, $1600 ; $6e4a
	ld de, $0d00 ; $6e4d
	farcall FarPtr_ScriptSetActorMoveTarget ; $6e50
	ld a, $0b ; $6e53
	farcall FarPtr_ScriptWaitActorMoveDone ; $6e55
	push af ; $6e58
	ld a, $0a ; $6e59
	farcall FarPtr_WaitScriptFrames ; $6e5b
	pop af ; $6e5e
	ld a, $0b ; $6e5f
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6e61
	push af ; $6e64
	ld a, $0a ; $6e65
	farcall FarPtr_WaitScriptFrames ; $6e67
	pop af ; $6e6a
	ld a, $0f ; $6e6b
	ld b, $00 ; $6e6d
	farcall FarPtr_SetActorFacing ; $6e6f
	sound $99 ; $6e72
	ld a, $07 ; $6e74
	ld bc, $1200 ; $6e76
	ld de, $0b00 ; $6e79
	farcall FarPtr_ScriptSetActorPosition ; $6e7c
	push af ; $6e7f
	ld a, $0a ; $6e80
	farcall FarPtr_WaitScriptFrames ; $6e82
	pop af ; $6e85
	ld a, $0f ; $6e86
	ld d, $02 ; $6e88
	farcall FarPtr_ScriptSetActorAnimation ; $6e8a
	ld a, $0f ; $6e8d
	farcall FarPtr_ScriptWaitActorIdle ; $6e8f
	push af ; $6e92
	ld a, $0a ; $6e93
	farcall FarPtr_WaitScriptFrames ; $6e95
	pop af ; $6e98
	ld a, $0f ; $6e99
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6e9b
	ld a, $10 ; $6e9e
	ld b, $00 ; $6ea0
	farcall FarPtr_SetActorFacing ; $6ea2
	ld a, $0e ; $6ea5
	ld b, $00 ; $6ea7
	farcall FarPtr_SetActorFacing ; $6ea9
	ld a, $07 ; $6eac
	ld bc, $3f00 ; $6eae
	ld de, $3f00 ; $6eb1
	farcall FarPtr_ScriptSetActorPosition ; $6eb4
	ld a, $0f ; $6eb7
	ld bc, $1300 ; $6eb9
	ld de, $0d00 ; $6ebc
	farcall FarPtr_ScriptSetActorMoveTarget ; $6ebf
	ld a, $0f ; $6ec2
	farcall FarPtr_ScriptWaitActorMoveDone ; $6ec4
	push af ; $6ec7
	ld a, $0a ; $6ec8
	farcall FarPtr_WaitScriptFrames ; $6eca
	pop af ; $6ecd
	ld a, $0a ; $6ece
	ld b, $80 ; $6ed0
	farcall FarPtr_SetActorFacing ; $6ed2
	ld a, $10 ; $6ed5
	ld bc, $1100 ; $6ed7
	ld de, $0d00 ; $6eda
	farcall FarPtr_ScriptSetActorMoveTarget ; $6edd
	push af ; $6ee0
	ld a, $0a ; $6ee1
	farcall FarPtr_WaitScriptFrames ; $6ee3
	pop af ; $6ee6
	ld a, $09 ; $6ee7
	ld b, $80 ; $6ee9
	farcall FarPtr_SetActorFacing ; $6eeb
	ld a, $0e ; $6eee
	ld bc, $1300 ; $6ef0
	ld de, $0f00 ; $6ef3
	farcall FarPtr_ScriptSetActorMoveTarget ; $6ef6
	ld a, $0e ; $6ef9
	farcall FarPtr_ScriptWaitActorMoveDone ; $6efb
	push af ; $6efe
	ld a, $0a ; $6eff
	farcall FarPtr_WaitScriptFrames ; $6f01
	pop af ; $6f04
	ld a, $0b ; $6f05
	ld b, $01 ; $6f07
	farcall FarPtr_0a_2c ; $6f09
	ld a, $0b ; $6f0c
	ld bc, $1800 ; $6f0e
	ld de, $0d00 ; $6f11
	farcall FarPtr_ScriptSetActorMoveTarget ; $6f14
	ld a, $0b ; $6f17
	farcall FarPtr_ScriptWaitActorMoveDone ; $6f19
	ld a, $0b ; $6f1c
	ld b, $80 ; $6f1e
	farcall FarPtr_SetActorFacing ; $6f20
	ld a, $0b ; $6f23
	ld b, $00 ; $6f25
	farcall FarPtr_0a_2c ; $6f27
	ret ; $6f2a
Func_0e_6f2b:
	ld a, $10 ; $6f2b
	ld b, $c0 ; $6f2d
	farcall FarPtr_SetActorFacing ; $6f2f
	push af ; $6f32
	ld a, $0a ; $6f33
	farcall FarPtr_WaitScriptFrames ; $6f35
	pop af ; $6f38
	ld a, $10 ; $6f39
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6f3b
	push af ; $6f3e
	ld a, $0a ; $6f3f
	farcall FarPtr_WaitScriptFrames ; $6f41
	pop af ; $6f44
	ld a, $0f ; $6f45
	ld b, $40 ; $6f47
	farcall FarPtr_SetActorFacing ; $6f49
	push af ; $6f4c
	ld a, $0a ; $6f4d
	farcall FarPtr_WaitScriptFrames ; $6f4f
	pop af ; $6f52
	ld a, $0e ; $6f53
	ld b, $c0 ; $6f55
	farcall FarPtr_SetActorFacing ; $6f57
	push af ; $6f5a
	ld a, $28 ; $6f5b
	farcall FarPtr_WaitScriptFrames ; $6f5d
	pop af ; $6f60
	ld a, $0f ; $6f61
	ld d, $03 ; $6f63
	farcall FarPtr_ScriptSetActorAnimation ; $6f65
	ld a, $0e ; $6f68
	ld d, $03 ; $6f6a
	farcall FarPtr_ScriptSetActorAnimation ; $6f6c
	ld a, $0e ; $6f6f
	farcall FarPtr_ScriptWaitActorIdle ; $6f71
	push af ; $6f74
	ld a, $0a ; $6f75
	farcall FarPtr_WaitScriptFrames ; $6f77
	pop af ; $6f7a
	ld a, $0f ; $6f7b
	ld b, $c0 ; $6f7d
	farcall FarPtr_SetActorFacing ; $6f7f
	push af ; $6f82
	ld a, $04 ; $6f83
	farcall FarPtr_WaitScriptFrames ; $6f85
	pop af ; $6f88
	ld a, $0e ; $6f89
	ld b, $c0 ; $6f8b
	farcall FarPtr_SetActorFacing ; $6f8d
	push af ; $6f90
	ld a, $0a ; $6f91
	farcall FarPtr_WaitScriptFrames ; $6f93
	pop af ; $6f96
	ld a, $0e ; $6f97
	ld de, rLCDC ; $6f99
	farcall FarPtr_0a_42 ; $6f9c
	push af ; $6f9f
	ld a, $28 ; $6fa0
	farcall FarPtr_WaitScriptFrames ; $6fa2
	pop af ; $6fa5
	ld a, $0e ; $6fa6
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6fa8
	push af ; $6fab
	ld a, $0a ; $6fac
	farcall FarPtr_WaitScriptFrames ; $6fae
	pop af ; $6fb1
	sound $96 ; $6fb2
	ld a, $04 ; $6fb4
	ld bc, $1300 ; $6fb6
	ld de, $0900 ; $6fb9
	farcall FarPtr_ScriptSetActorPosition ; $6fbc
	ld a, $05 ; $6fbf
	ld bc, $1700 ; $6fc1
	ld de, $0900 ; $6fc4
	farcall FarPtr_ScriptSetActorPosition ; $6fc7
	push af ; $6fca
	ld a, $14 ; $6fcb
	farcall FarPtr_WaitScriptFrames ; $6fcd
	pop af ; $6fd0
	ld a, $08 ; $6fd1
	ld b, $00 ; $6fd3
	farcall FarPtr_SetActorFacing ; $6fd5
	push af ; $6fd8
	ld a, $0a ; $6fd9
	farcall FarPtr_WaitScriptFrames ; $6fdb
	pop af ; $6fde
	ld a, $12 ; $6fdf
	ld b, $80 ; $6fe1
	farcall FarPtr_SetActorFacing ; $6fe3
	push af ; $6fe6
	ld a, $14 ; $6fe7
	farcall FarPtr_WaitScriptFrames ; $6fe9
	pop af ; $6fec
	ld a, $04 ; $6fed
	ld bc, $3f00 ; $6fef
	ld de, $3f00 ; $6ff2
	farcall FarPtr_ScriptSetActorPosition ; $6ff5
	ld a, $05 ; $6ff8
	ld bc, $3f00 ; $6ffa
	ld de, $3f00 ; $6ffd
	farcall FarPtr_ScriptSetActorPosition ; $7000
	push af ; $7003
	ld a, $14 ; $7004
	farcall FarPtr_WaitScriptFrames ; $7006
	pop af ; $7009
	ld a, $08 ; $700a
	ld d, $03 ; $700c
	farcall FarPtr_ScriptSetActorAnimation ; $700e
	ld a, $12 ; $7011
	ld d, $03 ; $7013
	farcall FarPtr_ScriptSetActorAnimation ; $7015
	ld a, $12 ; $7018
	farcall FarPtr_ScriptWaitActorIdle ; $701a
	push af ; $701d
	ld a, $0a ; $701e
	farcall FarPtr_WaitScriptFrames ; $7020
	pop af ; $7023
	ld a, $08 ; $7024
	ld b, $40 ; $7026
	farcall FarPtr_SetActorFacing ; $7028
	push af ; $702b
	ld a, $0a ; $702c
	farcall FarPtr_WaitScriptFrames ; $702e
	pop af ; $7031
	ld a, $12 ; $7032
	ld b, $40 ; $7034
	farcall FarPtr_SetActorFacing ; $7036
	ld a, $08 ; $7039
	farcall FarPtr_ScriptShowSpeakerDialogue ; $703b
	push af ; $703e
	ld a, $14 ; $703f
	farcall FarPtr_WaitScriptFrames ; $7041
	pop af ; $7044
	ld a, $0f ; $7045
	ld d, $03 ; $7047
	farcall FarPtr_ScriptSetActorAnimation ; $7049
	ld a, $10 ; $704c
	ld d, $03 ; $704e
	farcall FarPtr_ScriptSetActorAnimation ; $7050
	ld a, $0e ; $7053
	ld d, $03 ; $7055
	farcall FarPtr_ScriptSetActorAnimation ; $7057
	ld a, $0e ; $705a
	farcall FarPtr_ScriptWaitActorIdle ; $705c
	push af ; $705f
	ld a, $14 ; $7060
	farcall FarPtr_WaitScriptFrames ; $7062
	pop af ; $7065
	ld a, $10 ; $7066
	ld de, $ff80 ; $7068
	farcall FarPtr_0a_42 ; $706b
	push af ; $706e
	ld a, $28 ; $706f
	farcall FarPtr_WaitScriptFrames ; $7071
	pop af ; $7074
	ld a, $10 ; $7075
	farcall FarPtr_ScriptShowSpeakerDialogue ; $7077
	push af ; $707a
	ld a, $0a ; $707b
	farcall FarPtr_WaitScriptFrames ; $707d
	pop af ; $7080
	ret ; $7081
ExhibitionDeclinedCutscene:
	push af ; $7082
	ld a, $0a ; $7083
	farcall FarPtr_WaitScriptFrames ; $7085
	pop af ; $7088
	sound $99 ; $7089
	ld a, $07 ; $708b
	ld bc, $1400 ; $708d
	ld de, $0d00 ; $7090
	farcall FarPtr_ScriptSetActorPosition ; $7093
	push af ; $7096
	ld a, $28 ; $7097
	farcall FarPtr_WaitScriptFrames ; $7099
	pop af ; $709c
	ld a, $0f ; $709d
	farcall FarPtr_ScriptShowSpeakerDialogue ; $709f
	push af ; $70a2
	ld a, $14 ; $70a3
	farcall FarPtr_WaitScriptFrames ; $70a5
	pop af ; $70a8
	ld a, $07 ; $70a9
	ld bc, $3f00 ; $70ab
	ld de, $3f00 ; $70ae
	farcall FarPtr_ScriptSetActorPosition ; $70b1
	ld a, $08 ; $70b4
	ld d, $02 ; $70b6
	farcall FarPtr_ScriptSetActorAnimation ; $70b8
	ld a, $08 ; $70bb
	farcall FarPtr_ScriptWaitActorIdle ; $70bd
	ld a, $08 ; $70c0
	farcall FarPtr_ScriptShowSpeakerDialogue ; $70c2
	push af ; $70c5
	ld a, $0a ; $70c6
	farcall FarPtr_WaitScriptFrames ; $70c8
	pop af ; $70cb
	ld a, $08 ; $70cc
	ld d, $03 ; $70ce
	farcall FarPtr_ScriptSetActorAnimation ; $70d0
	ld a, $08 ; $70d3
	farcall FarPtr_ScriptWaitActorIdle ; $70d5
	push af ; $70d8
	ld a, $0a ; $70d9
	farcall FarPtr_WaitScriptFrames ; $70db
	pop af ; $70de
	ld a, $08 ; $70df
	farcall FarPtr_ScriptShowSpeakerDialogue ; $70e1
	ld a, $0f ; $70e4
	ld de, $ff80 ; $70e6
	farcall FarPtr_0a_42 ; $70e9
	push af ; $70ec
	ld a, $14 ; $70ed
	farcall FarPtr_WaitScriptFrames ; $70ef
	pop af ; $70f2
	sound $70 ; $70f3
	ld a, $04 ; $70f5
	farcall FarPtr_SetScreenShake ; $70f7
	push af ; $70fa
	ld a, $0a ; $70fb
	farcall FarPtr_WaitScriptFrames ; $70fd
	pop af ; $7100
	ld a, $00 ; $7101
	farcall FarPtr_SetScreenShake ; $7103
	push af ; $7106
	ld a, $1e ; $7107
	farcall FarPtr_WaitScriptFrames ; $7109
	pop af ; $710c
	ld a, $10 ; $710d
	ld bc, $0c00 ; $710f
	ld de, $0d00 ; $7112
	farcall FarPtr_ScriptSetActorMoveTarget ; $7115
	ld a, $0e ; $7118
	ld bc, $0c00 ; $711a
	ld de, $1100 ; $711d
	farcall FarPtr_ScriptSetActorMoveTarget ; $7120
	push af ; $7123
	ld a, $14 ; $7124
	farcall FarPtr_WaitScriptFrames ; $7126
	pop af ; $7129
	ld a, $0f ; $712a
	ld bc, $0c00 ; $712c
	ld de, $0f00 ; $712f
	farcall FarPtr_ScriptSetActorMoveTarget ; $7132
	ld a, $0f ; $7135
	farcall FarPtr_ScriptWaitActorMoveDone ; $7137
	ld a, $10 ; $713a
	ld b, $00 ; $713c
	farcall FarPtr_SetActorFacing ; $713e
	ld a, $0e ; $7141
	ld b, $00 ; $7143
	farcall FarPtr_SetActorFacing ; $7145
	ld a, $0f ; $7148
	ld b, $00 ; $714a
	farcall FarPtr_SetActorFacing ; $714c
	ret ; $714f
Func_0e_7150:
	ldh a, [hWramBank] ; $7150
	push af ; $7152
	ld hl, $72ce ; $7153
	ld de, $0901 ; $7156
	call LoadPaletteShadow ; $7159
	ld hl, $72e0 ; $715c
	ld de, $a000 ; $715f
	ld c, $18 ; $7162
	call QueueVRAMCopy ; $7164
	ld hl, $7460 ; $7167
	ld de, $a180 ; $716a
	ld c, $02 ; $716d
	call QueueVRAMCopy ; $716f
	wram_bank $06 ; $7172
	xor a, a ; $7178
	ld hl, $d000 ; $7179
	ld [hl+], a ; $717c
	ld [hl+], a ; $717d
	ld a, $5a ; $717e
	ld [hl+], a ; $7180
	xor a, a ; $7181
	ld [hl+], a ; $7182
	ld [hl+], a ; $7183
	ld [hl+], a ; $7184
	ld [hl+], a ; $7185
	ld [hl+], a ; $7186
	ld [hl+], a ; $7187
	ld [hl+], a ; $7188
	ld [hl+], a ; $7189
	ld [hl+], a ; $718a
	ld [hl+], a ; $718b
	ld [hl+], a ; $718c
	ld [hl+], a ; $718d
	ld [hl+], a ; $718e
	ld [hl+], a ; $718f
	ld [hl+], a ; $7190
	ld [hl+], a ; $7191
	ld b, $00 ; $7192
	ld c, $2b ; $7194
	ld d, $1a ; $7196
	ld e, $0c ; $7198
	ld h, $04 ; $719a
	ld l, $02 ; $719c
	farcall FarPtr_0a_7e ; $719e
	ld b, $04 ; $71a1
	ld c, $2d ; $71a3
	ld d, $14 ; $71a5
	ld e, $14 ; $71a7
	ld h, $06 ; $71a9
	ld l, $02 ; $71ab
	farcall FarPtr_0a_7e ; $71ad
	ld b, $0a ; $71b0
	ld c, $2b ; $71b2
	ld d, $1a ; $71b4
	ld e, $12 ; $71b6
	ld h, $06 ; $71b8
	ld l, $02 ; $71ba
	farcall FarPtr_0a_7e ; $71bc
	sound $09 ; $71bf
	ld a, $01 ; $71c1
	ld hl, $71e9 ; $71c3
	call RegisterFrameTask ; $71c6
	wram_bank $06 ; $71c9
Label_0e_71cf:
	call AdvanceFrame ; $71cf
	ld a, [$d002] ; $71d2
	cp a, $1e ; $71d5
	jr z, Label_0e_71e2 ; $71d7
	or a, a ; $71d9
	jr nz, Label_0e_71cf ; $71da
	pop af ; $71dc
	wram_bank ; $71dd
	ret ; $71e1
Label_0e_71e2:
	ld c, $03 ; $71e2
	call BeginFadeOut ; $71e4
	jr Label_0e_71cf ; $71e7
	INCBIN "data/bank_00e/d_71e9.bin" ; $71e9, 1037 bytes
SpecialCourtMapScripts_0e:
	; $75f6, 14 bytes (records:2)
	dw $76d2 ; record 0
	dw $76db ; record 1
	dw $7604 ; record 2
	dw $76e4 ; record 3
	dw $76e5 ; record 4
	dw $76e6 ; record 5
	dw $76e7 ; record 6
	; $7604, 206 bytes (bytes:14)
	db $00, $00, $6e, $7c, $00, $0f, $00, $05, $40, $00, $2e, $01, $00, $00 ; 0x00
	db $00, $00, $6e, $7c, $00, $17, $00, $0d, $80, $00, $6d, $01, $00, $00 ; 0x0e
	db $00, $00, $6e, $7c, $00, $17, $00, $0f, $80, $00, $6f, $01, $00, $00 ; 0x1c
	db $00, $00, $6e, $7c, $00, $17, $00, $11, $80, $00, $2c, $01, $00, $00 ; 0x2a
	db $00, $00, $6e, $7c, $00, $17, $00, $19, $80, $00, $6e, $01, $00, $00 ; 0x38
	db $00, $00, $6e, $7c, $80, $04, $00, $0f, $00, $00, $73, $01, $00, $00 ; 0x46
	db $00, $00, $6e, $7c, $00, $05, $00, $11, $00, $00, $2d, $01, $00, $00 ; 0x54
	db $00, $00, $6e, $7c, $00, $05, $00, $19, $00, $00, $48, $01, $00, $00 ; 0x62
	db $00, $00, $6e, $7c, $00, $05, $00, $1b, $00, $00, $2b, $01, $00, $00 ; 0x70
	db $00, $00, $6e, $7c, $00, $0d, $00, $05, $40, $00, $72, $01, $00, $00 ; 0x7e
	db $00, $00, $6e, $7c, $00, $0d, $00, $17, $40, $00, $2a, $01, $00, $00 ; 0x8c
	db $00, $00, $6e, $7c, $00, $05, $00, $1f, $c0, $00, $70, $01, $00, $00 ; 0x9a
	db $00, $00, $6e, $7c, $00, $05, $00, $0d, $00, $00, $71, $01, $00, $00 ; 0xa8
	db $00, $00, $6e, $7c, $00, $17, $00, $1b, $80, $00, $71, $01, $00, $00 ; 0xb6
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $ff ; 0xc4
	; $76d2, 9 bytes (bytes:16)
	db $01, $c0, $00, $05, $00, $21, $00, $00, $ff ; 0x00
	; $76db, 12 bytes (records:8)
; 1 records x 8 bytes
	dw $ff01, $0000, $7c96, $0608 ; record 0
	db $ff, $ff, $ff, $ff
	ld a, [$c295] ; $76e7
	cp a, $07 ; $76ea
	jr c, Label_0e_76f7 ; $76ec
	cp a, $0a ; $76ee
	jr z, Label_0e_76f3 ; $76f0
	ret ; $76f2
Label_0e_76f3:
	call HandleExhibitionMatchResult ; $76f3
	ret ; $76f6
Label_0e_76f7:
	call ExhibitionMatchIntroCutscene ; $76f7
	ret ; $76fa
ExhibitionMatchIntroCutscene:
	xor a, a ; $76fb
	ld [$c2d5], a ; $76fc
	ld a, [$c295] ; $76ff
	dec a ; $7702
	ld [wWaterSpriteMinigameTimer], a ; $7703
	test_flag $05, 7 ; $7706
	jp nz, Label_0e_7927 ; $7709
	ld a, $0e ; $770c
	ld bc, $0014 ; $770e
	farcall FarPtr_0a_18 ; $7711
	ld a, $00 ; $7714
	ld bc, $0014 ; $7716
	farcall FarPtr_0a_18 ; $7719
	ld a, $0e ; $771c
	ld bc, $0500 ; $771e
	ld de, $2300 ; $7721
	farcall FarPtr_ScriptSetActorPosition ; $7724
	ld a, $00 ; $7727
	ld bc, $0500 ; $7729
	ld de, $2500 ; $772c
	farcall FarPtr_ScriptSetActorPosition ; $772f
	ld a, $02 ; $7732
	ld bc, $0500 ; $7734
	ld de, $2500 ; $7737
	farcall FarPtr_ScriptSetActorPosition ; $773a
	ld a, $0e ; $773d
	ld bc, $0500 ; $773f
	ld de, $1f00 ; $7742
	farcall FarPtr_ScriptSetActorMoveTarget ; $7745
	ld a, $00 ; $7748
	ld bc, $0500 ; $774a
	ld de, $2100 ; $774d
	farcall FarPtr_ScriptSetActorMoveTarget ; $7750
	ld a, $02 ; $7753
	ld bc, $0500 ; $7755
	ld de, $2300 ; $7758
	farcall FarPtr_ScriptSetActorMoveTarget ; $775b
	ld bc, $0014 ; $775e
	farcall FarPtr_0a_38 ; $7761
	xor a, a ; $7764
	ld bc, $0e00 ; $7765
	ld de, $1b00 ; $7768
	farcall FarPtr_MovePlayerToPosition ; $776b
	ld c, $04 ; $776e
	call BeginFadeIn ; $7770
	call WaitFadeEnd ; $7773
	ld a, $0e ; $7776
	farcall FarPtr_ScriptWaitActorMoveDone ; $7778
	ldh a, [hRomBank] ; $777b
	ld b, a ; $777d
	ld a, $0e ; $777e
	ld de, $7b11 ; $7780
	farcall FarPtr_0a_1a ; $7783
	ld a, $00 ; $7786
	ld bc, $0500 ; $7788
	ld de, $1f00 ; $778b
	farcall FarPtr_ScriptSetActorMoveTarget ; $778e
	ld a, $00 ; $7791
	farcall FarPtr_ScriptWaitActorMoveDone ; $7793
	ldh a, [hRomBank] ; $7796
	ld b, a ; $7798
	ld a, $00 ; $7799
	ld de, $7b11 ; $779b
	farcall FarPtr_0a_1a ; $779e
	push af ; $77a1
	ld a, $5a ; $77a2
	farcall FarPtr_WaitScriptFrames ; $77a4
	pop af ; $77a7
	xor a, a ; $77a8
	ld bc, $0e00 ; $77a9
	ld de, $1700 ; $77ac
	farcall FarPtr_MovePlayerToPosition ; $77af
	ld a, $0e ; $77b2
	farcall FarPtr_WaitActorScriptDone ; $77b4
	ld a, $0e ; $77b7
	ld bc, $0020 ; $77b9
	farcall FarPtr_0a_18 ; $77bc
	ldh a, [hRomBank] ; $77bf
	ld b, a ; $77c1
	ld a, $0e ; $77c2
	ld de, $7b24 ; $77c4
	farcall FarPtr_0a_1a ; $77c7
	ld a, $0e ; $77ca
	farcall FarPtr_WaitActorScriptDone ; $77cc
	push af ; $77cf
	ld a, $3c ; $77d0
	farcall FarPtr_WaitScriptFrames ; $77d2
	pop af ; $77d5
	ld a, $0d ; $77d6
	ld d, $03 ; $77d8
	farcall FarPtr_ScriptSetActorAnimation ; $77da
	ld a, $00 ; $77dd
	ld d, $03 ; $77df
	farcall FarPtr_ScriptSetActorAnimation ; $77e1
	ld a, $00 ; $77e4
	farcall FarPtr_ScriptWaitActorIdle ; $77e6
	push af ; $77e9
	ld a, $14 ; $77ea
	farcall FarPtr_WaitScriptFrames ; $77ec
	pop af ; $77ef
	test_flag $0d, 6 ; $77f0
	jr z, Label_0e_77fe ; $77f3
	ld a, $01 ; $77f5
	ld [$c294], a ; $77f7
	ld [$c2a1], a ; $77fa
	ret ; $77fd
Label_0e_77fe:
	ld a, $00 ; $77fe
	ld bc, $0f00 ; $7800
	ld de, $1a00 ; $7803
	farcall FarPtr_ScriptSetActorMoveTarget ; $7806
	ld a, $00 ; $7809
	farcall FarPtr_ScriptWaitActorMoveDone ; $780b
	ld a, $00 ; $780e
	ld bc, $0f00 ; $7810
	ld de, $1700 ; $7813
	farcall FarPtr_ScriptSetActorMoveTarget ; $7816
	ld a, $00 ; $7819
	farcall FarPtr_ScriptWaitActorMoveDone ; $781b
	ld a, $0d ; $781e
	ld b, $c0 ; $7820
	farcall FarPtr_SetActorFacing ; $7822
	push af ; $7825
	ld a, $14 ; $7826
	farcall FarPtr_WaitScriptFrames ; $7828
	pop af ; $782b
	ld bc, $0020 ; $782c
	farcall FarPtr_0a_38 ; $782f
	xor a, a ; $7832
	ld bc, $0e00 ; $7833
	ld de, $0900 ; $7836
	farcall FarPtr_MovePlayerToPosition ; $7839
	farcall FarPtr_WaitPlayerMoveDone ; $783c
	push af ; $783f
	ld a, $14 ; $7840
	farcall FarPtr_WaitScriptFrames ; $7842
	pop af ; $7845
	ld a, $03 ; $7846
	ld bc, $0014 ; $7848
	farcall FarPtr_0a_18 ; $784b
	ld a, $03 ; $784e
	ld bc, $0f00 ; $7850
	ld de, $0700 ; $7853
	farcall FarPtr_ScriptSetActorMoveTarget ; $7856
	ld a, $03 ; $7859
	farcall FarPtr_ScriptWaitActorMoveDone ; $785b
	ld a, $03 ; $785e
	ld d, $03 ; $7860
	farcall FarPtr_ScriptSetActorAnimation ; $7862
	ld a, $03 ; $7865
	farcall FarPtr_ScriptWaitActorIdle ; $7867
	ld hl, $30a9 ; $786a
	farcall FarPtr_InitDialogueTextCursor ; $786d
	ld a, $03 ; $7870
	farcall FarPtr_ScriptShowSpeakerDialogue ; $7872
	ld bc, $0040 ; $7875
	farcall FarPtr_0a_38 ; $7878
	xor a, a ; $787b
	ld bc, $0e00 ; $787c
	ld de, $1400 ; $787f
	farcall FarPtr_MovePlayerToPosition ; $7882
	farcall FarPtr_WaitPlayerMoveDone ; $7885
	push af ; $7888
	ld a, $14 ; $7889
	farcall FarPtr_WaitScriptFrames ; $788b
	pop af ; $788e
	ld a, $0d ; $788f
	ld b, $00 ; $7891
	farcall FarPtr_SetActorFacing ; $7893
	ld a, $00 ; $7896
	ld b, $80 ; $7898
	farcall FarPtr_SetActorFacing ; $789a
	push af ; $789d
	ld a, $28 ; $789e
	farcall FarPtr_WaitScriptFrames ; $78a0
	pop af ; $78a3
	ld a, $0d ; $78a4
	ld d, $03 ; $78a6
	farcall FarPtr_ScriptSetActorAnimation ; $78a8
	ld a, $00 ; $78ab
	ld d, $03 ; $78ad
	farcall FarPtr_ScriptSetActorAnimation ; $78af
	ld a, $00 ; $78b2
	farcall FarPtr_ScriptWaitActorIdle ; $78b4
	push af ; $78b7
	ld a, $14 ; $78b8
	farcall FarPtr_WaitScriptFrames ; $78ba
	pop af ; $78bd
	ld a, $00 ; $78be
	ld bc, $0020 ; $78c0
	farcall FarPtr_0a_18 ; $78c3
	ld a, $0d ; $78c6
	ld bc, $0020 ; $78c8
	farcall FarPtr_0a_18 ; $78cb
	ld a, $00 ; $78ce
	ld bc, $0f00 ; $78d0
	ld de, $1d00 ; $78d3
	farcall FarPtr_ScriptSetActorMoveTarget ; $78d6
	ld a, $0d ; $78d9
	ld bc, $0900 ; $78db
	ld de, $1700 ; $78de
	farcall FarPtr_ScriptSetActorMoveTarget ; $78e1
	ld a, $0d ; $78e4
	farcall FarPtr_ScriptWaitActorMoveDone ; $78e6
	ld a, $0d ; $78e9
	ld bc, $0900 ; $78eb
	ld de, $0d00 ; $78ee
	farcall FarPtr_ScriptSetActorMoveTarget ; $78f1
	ld a, $00 ; $78f4
	farcall FarPtr_ScriptWaitActorMoveDone ; $78f6
	ld a, $00 ; $78f9
	ld b, $c0 ; $78fb
	farcall FarPtr_SetActorFacing ; $78fd
	ld a, $0d ; $7900
	farcall FarPtr_ScriptWaitActorMoveDone ; $7902
	ld a, $0d ; $7905
	ld bc, $0d00 ; $7907
	ld de, $0d00 ; $790a
	farcall FarPtr_ScriptSetActorMoveTarget ; $790d
	ld a, $0d ; $7910
	farcall FarPtr_ScriptWaitActorMoveDone ; $7912
	ld a, $0d ; $7915
	ld b, $40 ; $7917
	farcall FarPtr_SetActorFacing ; $7919
	push af ; $791c
	ld a, $28 ; $791d
	farcall FarPtr_WaitScriptFrames ; $791f
	pop af ; $7922
	call PrepareStoryMatch ; $7923
	ret ; $7926
Label_0e_7927:
	ld a, $0e ; $7927
	ld bc, $0014 ; $7929
	farcall FarPtr_0a_18 ; $792c
	ld a, $00 ; $792f
	ld bc, $0014 ; $7931
	farcall FarPtr_0a_18 ; $7934
	ld a, $02 ; $7937
	ld bc, $0014 ; $7939
	farcall FarPtr_0a_18 ; $793c
	ld a, $03 ; $793f
	ld bc, $0f00 ; $7941
	ld de, $1700 ; $7944
	farcall FarPtr_ScriptSetActorPosition ; $7947
	ld a, $02 ; $794a
	farcall FarPtr_0a_1c ; $794c
	ld a, $0e ; $794f
	ld bc, $0500 ; $7951
	ld de, $2300 ; $7954
	farcall FarPtr_ScriptSetActorPosition ; $7957
	ld a, $00 ; $795a
	ld bc, $0500 ; $795c
	ld de, $2500 ; $795f
	farcall FarPtr_ScriptSetActorPosition ; $7962
	ld a, $02 ; $7965
	ld bc, $0500 ; $7967
	ld de, $2500 ; $796a
	farcall FarPtr_ScriptSetActorPosition ; $796d
	ld a, $0e ; $7970
	ld bc, $0500 ; $7972
	ld de, $1f00 ; $7975
	farcall FarPtr_ScriptSetActorMoveTarget ; $7978
	ld a, $00 ; $797b
	ld bc, $0500 ; $797d
	ld de, $2100 ; $7980
	farcall FarPtr_ScriptSetActorMoveTarget ; $7983
	ld a, $02 ; $7986
	ld bc, $0500 ; $7988
	ld de, $2300 ; $798b
	farcall FarPtr_ScriptSetActorMoveTarget ; $798e
	ld bc, $0014 ; $7991
	farcall FarPtr_0a_38 ; $7994
	xor a, a ; $7997
	ld bc, $0e00 ; $7998
	ld de, $1b00 ; $799b
	farcall FarPtr_MovePlayerToPosition ; $799e
	ld c, $04 ; $79a1
	call BeginFadeIn ; $79a3
	call WaitFadeEnd ; $79a6
	ld a, $0e ; $79a9
	farcall FarPtr_ScriptWaitActorMoveDone ; $79ab
	ldh a, [hRomBank] ; $79ae
	ld b, a ; $79b0
	ld a, $0e ; $79b1
	ld de, $7b11 ; $79b3
	farcall FarPtr_0a_1a ; $79b6
	ld a, $00 ; $79b9
	ld bc, $0500 ; $79bb
	ld de, $1f00 ; $79be
	farcall FarPtr_ScriptSetActorMoveTarget ; $79c1
	ld a, $02 ; $79c4
	ld bc, $0500 ; $79c6
	ld de, $2100 ; $79c9
	farcall FarPtr_ScriptSetActorMoveTarget ; $79cc
	ld a, $00 ; $79cf
	farcall FarPtr_ScriptWaitActorMoveDone ; $79d1
	ldh a, [hRomBank] ; $79d4
	ld b, a ; $79d6
	ld a, $00 ; $79d7
	ld de, $7b11 ; $79d9
	farcall FarPtr_0a_1a ; $79dc
	ld a, $02 ; $79df
	ld bc, $0500 ; $79e1
	ld de, $1f00 ; $79e4
	farcall FarPtr_ScriptSetActorMoveTarget ; $79e7
	ld a, $02 ; $79ea
	farcall FarPtr_ScriptWaitActorMoveDone ; $79ec
	ldh a, [hRomBank] ; $79ef
	ld b, a ; $79f1
	ld a, $02 ; $79f2
	ld de, $7b11 ; $79f4
	farcall FarPtr_0a_1a ; $79f7
	push af ; $79fa
	ld a, $5a ; $79fb
	farcall FarPtr_WaitScriptFrames ; $79fd
	pop af ; $7a00
	xor a, a ; $7a01
	ld bc, $0e00 ; $7a02
	ld de, $1700 ; $7a05
	farcall FarPtr_MovePlayerToPosition ; $7a08
	ld a, $0e ; $7a0b
	farcall FarPtr_WaitActorScriptDone ; $7a0d
	ld a, $0e ; $7a10
	ld bc, $0020 ; $7a12
	farcall FarPtr_0a_18 ; $7a15
	ldh a, [hRomBank] ; $7a18
	ld b, a ; $7a1a
	ld a, $0e ; $7a1b
	ld de, $7b24 ; $7a1d
	farcall FarPtr_0a_1a ; $7a20
	ldh a, [hRomBank] ; $7a23
	ld b, a ; $7a25
	ld a, $02 ; $7a26
	ld de, $7c6e ; $7a28
	farcall FarPtr_0a_1a ; $7a2b
	ld a, $02 ; $7a2e
	ld bc, $0f00 ; $7a30
	ld de, $1b00 ; $7a33
	farcall FarPtr_ScriptSetActorMoveTarget ; $7a36
	ld a, $0e ; $7a39
	farcall FarPtr_WaitActorScriptDone ; $7a3b
	push af ; $7a3e
	ld a, $3c ; $7a3f
	farcall FarPtr_WaitScriptFrames ; $7a41
	pop af ; $7a44
	ld a, $03 ; $7a45
	ld d, $03 ; $7a47
	farcall FarPtr_ScriptSetActorAnimation ; $7a49
	ld a, $03 ; $7a4c
	farcall FarPtr_ScriptWaitActorIdle ; $7a4e
	push af ; $7a51
	ld a, $14 ; $7a52
	farcall FarPtr_WaitScriptFrames ; $7a54
	pop af ; $7a57
	test_flag $0d, 6 ; $7a58
	jr z, Label_0e_7a66 ; $7a5b
	ld a, $01 ; $7a5d
	ld [$c294], a ; $7a5f
	ld [$c2a1], a ; $7a62
	ret ; $7a65
Label_0e_7a66:
	ld hl, $30aa ; $7a66
	farcall FarPtr_InitDialogueTextCursor ; $7a69
	ld a, $03 ; $7a6c
	farcall FarPtr_ScriptShowSpeakerDialogue ; $7a6e
	push af ; $7a71
	ld a, $14 ; $7a72
	farcall FarPtr_WaitScriptFrames ; $7a74
	pop af ; $7a77
	ld a, $0d ; $7a78
	ld d, $03 ; $7a7a
	farcall FarPtr_ScriptSetActorAnimation ; $7a7c
	ld a, $03 ; $7a7f
	ld d, $03 ; $7a81
	farcall FarPtr_ScriptSetActorAnimation ; $7a83
	ld a, $02 ; $7a86
	ld d, $03 ; $7a88
	farcall FarPtr_ScriptSetActorAnimation ; $7a8a
	ld a, $00 ; $7a8d
	ld d, $03 ; $7a8f
	farcall FarPtr_ScriptSetActorAnimation ; $7a91
	ld a, $00 ; $7a94
	farcall FarPtr_ScriptWaitActorIdle ; $7a96
	push af ; $7a99
	ld a, $14 ; $7a9a
	farcall FarPtr_WaitScriptFrames ; $7a9c
	pop af ; $7a9f
	ld bc, $0020 ; $7aa0
	farcall FarPtr_0a_38 ; $7aa3
	xor a, a ; $7aa6
	ld bc, $0e00 ; $7aa7
	ld de, $1400 ; $7aaa
	farcall FarPtr_MovePlayerToPosition ; $7aad
	ld a, $00 ; $7ab0
	ld bc, $0020 ; $7ab2
	farcall FarPtr_0a_18 ; $7ab5
	ld a, $02 ; $7ab8
	ld bc, $0020 ; $7aba
	farcall FarPtr_0a_18 ; $7abd
	ld a, $0d ; $7ac0
	ld bc, $0020 ; $7ac2
	farcall FarPtr_0a_18 ; $7ac5
	ld a, $03 ; $7ac8
	ld bc, $0020 ; $7aca
	farcall FarPtr_0a_18 ; $7acd
	ldh a, [hRomBank] ; $7ad0
	ld b, a ; $7ad2
	ld a, $0d ; $7ad3
	ld de, $7b2f ; $7ad5
	farcall FarPtr_0a_1a ; $7ad8
	ldh a, [hRomBank] ; $7adb
	ld b, a ; $7add
	ld a, $03 ; $7ade
	ld de, $7b46 ; $7ae0
	farcall FarPtr_0a_1a ; $7ae3
	ldh a, [hRomBank] ; $7ae6
	ld b, a ; $7ae8
	ld a, $00 ; $7ae9
	ld de, $7b5d ; $7aeb
	farcall FarPtr_0a_1a ; $7aee
	ldh a, [hRomBank] ; $7af1
	ld b, a ; $7af3
	ld a, $02 ; $7af4
	ld de, $7b6e ; $7af6
	farcall FarPtr_0a_1a ; $7af9
	ld a, $0d ; $7afc
	farcall FarPtr_WaitActorScriptDone ; $7afe
	ld a, $03 ; $7b01
	farcall FarPtr_WaitActorScriptDone ; $7b03
	push af ; $7b06
	ld a, $3c ; $7b07
	farcall FarPtr_WaitScriptFrames ; $7b09
	pop af ; $7b0c
	call PrepareStoryMatch ; $7b0d
	ret ; $7b10
	INCBIN "data/bank_00e/d_7b11.bin" ; $7b11, 110 bytes
PrepareStoryMatch:
	ld a, $1c ; $7b7f
	ld [wStoryModeCurrentLocation], a ; $7b81
	ld a, $0a ; $7b84
	ld [$c295], a ; $7b86
	ld a, $ff ; $7b89
	ld [$c294], a ; $7b8b
	ld [$c2a1], a ; $7b8e
	farcall FarPtr_InitStoryMatchSettings ; $7b91
	ld a, [wWaterSpriteMinigameTimer] ; $7b94
	add a, a ; $7b97
	add a, $ac ; $7b98
	ld l, a ; $7b9a
	adc a, $7b ; $7b9b
	sub a, l ; $7b9d
	ld h, a ; $7b9e
	ld a, [hl+] ; $7b9f
	ld h, [hl] ; $7ba0
	ld l, a ; $7ba1
	call JumpToHL ; $7ba2
	farcall FarPtr_0a_4c ; $7ba5
	farcall FarPtr_0a_4e ; $7ba8
	ret ; $7bab
	dw LoadExhibitionMatchSettings0 ; $7bac
	dw LoadExhibitionMatchSettings1 ; $7bae
	dw LoadExhibitionMatchSettings2 ; $7bb0
	dw LoadExhibitionMatchSettings3 ; $7bb2
	dw LoadExhibitionMatchSettings4 ; $7bb4
	dw LoadExhibitionMatchSettings5 ; $7bb6
LoadExhibitionMatchSettings0:
	ld a, $00 ; $7bb8
	ld [wCurrentMinigameStoryMatch], a ; $7bba
	ld a, $18 ; $7bbd
	ld [$c8f7], a ; $7bbf
	farcall FarPtr_LoadMatchSettingsFromTable ; $7bc2
	ret ; $7bc5
LoadExhibitionMatchSettings1:
	ld a, $00 ; $7bc6
	ld [wCurrentMinigameStoryMatch], a ; $7bc8
	ld a, $17 ; $7bcb
	ld [$c8f7], a ; $7bcd
	farcall FarPtr_LoadMatchSettingsFromTable ; $7bd0
	ret ; $7bd3
LoadExhibitionMatchSettings2:
	ld a, $00 ; $7bd4
	ld [wCurrentMinigameStoryMatch], a ; $7bd6
	ld a, $16 ; $7bd9
	ld [$c8f7], a ; $7bdb
	farcall FarPtr_LoadMatchSettingsFromTable ; $7bde
	ret ; $7be1
LoadExhibitionMatchSettings3:
	ld a, $01 ; $7be2
	ld [wCurrentMinigameStoryMatch], a ; $7be4
	ld a, $18 ; $7be7
	ld [$c8f7], a ; $7be9
	farcall FarPtr_LoadMatchSettingsFromTable ; $7bec
	ret ; $7bef
LoadExhibitionMatchSettings4:
	ld a, $01 ; $7bf0
	ld [wCurrentMinigameStoryMatch], a ; $7bf2
	ld a, $17 ; $7bf5
	ld [$c8f7], a ; $7bf7
	farcall FarPtr_LoadMatchSettingsFromTable ; $7bfa
	ret ; $7bfd
LoadExhibitionMatchSettings5:
	ld a, $01 ; $7bfe
	ld [wCurrentMinigameStoryMatch], a ; $7c00
	ld a, $16 ; $7c03
	ld [$c8f7], a ; $7c05
	farcall FarPtr_LoadMatchSettingsFromTable ; $7c08
	ret ; $7c0b
HandleExhibitionMatchResult:
	ld a, [wMatchWinLoseFlag] ; $7c0c
	cp a, $01 ; $7c0f
	jr nz, Label_0e_7c24 ; $7c11
	test_flag $05, 7 ; $7c13
	jr nz, Label_0e_7c1f ; $7c16
	test_flag $07, 3 ; $7c18
	jr nz, Label_0e_7c37 ; $7c1b
	jr Label_0e_7c24 ; $7c1d
Label_0e_7c1f:
	test_flag $06, 4 ; $7c1f
	jr nz, Label_0e_7c37 ; $7c22
Label_0e_7c24:
	ld a, $1d ; $7c24
	ld [wStoryModeCurrentLocation], a ; $7c26
	ld a, $0e ; $7c29
	ld [$c295], a ; $7c2b
	ld a, $ff ; $7c2e
	ld [$c294], a ; $7c30
	ld [$c2a1], a ; $7c33
	ret ; $7c36
Label_0e_7c37:
	test_flag $05, 7 ; $7c37
	jr nz, Label_0e_7c49 ; $7c3a
	ld b, $02 ; $7c3c
	ld a, [$c90d] ; $7c3e
	add a, $04 ; $7c41
	ld c, a ; $7c43
	farcall FarPtr_18_8e ; $7c44
	jr Label_0e_7c5b ; $7c47
Label_0e_7c49:
	ld b, $02 ; $7c49
	ld a, [$c90d] ; $7c4b
	ld d, a ; $7c4e
	sla a ; $7c4f
	ld c, a ; $7c51
	ld a, [$c94d] ; $7c52
	xor a, d ; $7c55
	or a, c ; $7c56
	ld c, a ; $7c57
	farcall FarPtr_18_8e ; $7c58
Label_0e_7c5b:
	ld a, $00 ; $7c5b
	ld [wStoryModeCurrentLocation], a ; $7c5d
	ld a, $0a ; $7c60
	ld [$c295], a ; $7c62
	ld a, $ff ; $7c65
	ld [$c294], a ; $7c67
	ld [$c2a1], a ; $7c6a
	ret ; $7c6d
	INCBIN "data/bank_00e/d_7c6e.bin" ; $7c6e, 40 bytes
	ret ; $7c96
	xor a, a ; $7c97
	ld [$c2da], a ; $7c98
	ret ; $7c9b
	sound $a2 ; $7c9c
	ret ; $7c9e
	xor a, a ; $7c9f
	ld [$c2d5], a ; $7ca0
	ret ; $7ca3
	INCBIN "data/bank_00e/d_7ca4.bin" ; $7ca4, 438 bytes
ComputeTrainingGymProgressIndex:
	test_flag $05, 7 ; $7e5a
	jr nz, Label_0e_7e81 ; $7e5d
	ld a, $00 ; $7e5f
	test_flag $0a, 3 ; $7e61
	jr z, Label_0e_7e7d ; $7e64
	ld a, $02 ; $7e66
	test_flag $0a, 7 ; $7e68
	jr z, Label_0e_7e7d ; $7e6b
	ld a, $04 ; $7e6d
	test_flag $15, 6 ; $7e6f
	jr z, Label_0e_7e7d ; $7e72
	ld a, $06 ; $7e74
	test_flag $16, 0 ; $7e76
	jr z, Label_0e_7e7d ; $7e79
	ld a, $08 ; $7e7b
Label_0e_7e7d:
	ld [$c2b0], a ; $7e7d
	ret ; $7e80
Label_0e_7e81:
	ld a, $01 ; $7e81
	test_flag $08, 2 ; $7e83
	jr z, Label_0e_7e7d ; $7e86
	ld a, $03 ; $7e88
	test_flag $08, 6 ; $7e8a
	jr z, Label_0e_7e7d ; $7e8d
	ld a, $05 ; $7e8f
	test_flag $15, 7 ; $7e91
	jr z, Label_0e_7e7d ; $7e94
	ld a, $07 ; $7e96
	test_flag $16, 1 ; $7e98
	jr z, Label_0e_7e7d ; $7e9b
	ld a, $09 ; $7e9d
	jr Label_0e_7e7d ; $7e9f
	ld a, $00 ; $7ea1
	test_flag $0a, 3 ; $7ea3
	jr z, Label_0e_7ec0 ; $7ea6
	inc a ; $7ea8
	test_flag $0a, 7 ; $7ea9
	jr z, Label_0e_7ec0 ; $7eac
	inc a ; $7eae
	test_flag $05, 7 ; $7eaf
	jr nz, Label_0e_7ec4 ; $7eb2
	test_flag $15, 6 ; $7eb4
	jr z, Label_0e_7ec0 ; $7eb7
	inc a ; $7eb9
	test_flag $16, 0 ; $7eba
	jr z, Label_0e_7ec0 ; $7ebd
	inc a ; $7ebf
Label_0e_7ec0:
	ld [$c2b0], a ; $7ec0
	ret ; $7ec3
Label_0e_7ec4:
	test_flag $15, 7 ; $7ec4
	jr z, Label_0e_7ec0 ; $7ec7
	inc a ; $7ec9
	test_flag $16, 1 ; $7eca
	jr z, Label_0e_7ec0 ; $7ecd
	inc a ; $7ecf
	jr Label_0e_7ec0 ; $7ed0
	ds 302, $ff ; $7ed2, fill
