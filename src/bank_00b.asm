SECTION "ROM Bank $0b", ROMX[$4000], BANK[$0b]

FarPtr_RunTrainingDrillByID:
	dw RunTrainingDrillByID ; $4000
StartDrillFromDefinition:
	ld hl, $0000 ; $4002
	add hl, bc ; $4005
	ld a, [hl] ; $4006
	ld [wMatchOpponentChar], a ; $4007
	ld hl, $0001 ; $400a
	add hl, bc ; $400d
	ld a, [hl] ; $400e
	ld [wCurrentlyUsedCourt], a ; $400f
	ld hl, $0002 ; $4012
	add hl, bc ; $4015
	ld a, [hl] ; $4016
	ld [wOnCourtCharCount], a ; $4017
	ld hl, $0003 ; $401a
	add hl, bc ; $401d
	ld a, [hl] ; $401e
	ld [wGameMode], a ; $401f
	ld a, $02 ; $4022
	ld [wCurrentMinigameStoryMatch], a ; $4024
	ld hl, $0004 ; $4027
	add hl, bc ; $402a
	ld a, [hl] ; $402b
	ld [$c8f7], a ; $402c
	ld hl, $0005 ; $402f
	add hl, bc ; $4032
	ld a, [hl] ; $4033
	ld [wMatchBGM], a ; $4034
	push bc ; $4037
	ld hl, $0007 ; $4038
	add hl, bc ; $403b
	ld b, [hl] ; $403c
	ld c, $00 ; $403d
	farcall FarPtr_02_18 ; $403f
	ld a, [wStoryModeMainCharacterOverworldSprite] ; $4042
	ld [wMatchPlayerChar], a ; $4045
	ld a, [wMatchOpponentChar] ; $4048
	cp a, $ff ; $404b
	jr z, Label_0b_4055 ; $404d
	ld b, a ; $404f
	ld c, $02 ; $4050
	farcall FarPtr_02_18 ; $4052
Label_0b_4055:
	pop bc ; $4055
	ld hl, $0008 ; $4056
	add hl, bc ; $4059
	ld a, [hl+] ; $405a
	ld d, [hl] ; $405b
	ld e, a ; $405c
	ldh a, [hRomBank] ; $405d
	farcall FarPtr_SetModeHookTable ; $405f
	ld hl, $000a ; $4062
	add hl, bc ; $4065
	ld a, [hl+] ; $4066
	ld d, [hl] ; $4067
	ld e, a ; $4068
	farcall FarPtr_SetMinigamePointTable ; $4069
	ld hl, $000c ; $406c
	add hl, bc ; $406f
	ld a, [hl+] ; $4070
	ld h, [hl] ; $4071
	ld l, a ; $4072
	ld a, h ; $4073
	or a, l ; $4074
	jr z, Label_0b_407a ; $4075
	call JumpToHL ; $4077
Label_0b_407a:
	ret ; $407a
RecordDrillPointResultBits:
	ld a, [wPointWinLoseFlag] ; $407b
	or a, a ; $407e
	ret z ; $407f
	and a, $03 ; $4080
	ld b, a ; $4082
	rrc a ; $4083
	rrc a ; $4085
	ld c, a ; $4087
	ld a, [wTotalPointsScoredInCurrentGame] ; $4088
	ld b, a ; $408b
	ld hl, $40bc ; $408c
	ld a, [$c7bb] ; $408f
	or a, a ; $4092
	jr nz, Label_0b_40ad ; $4093
	ld a, b ; $4095
	and a, $01 ; $4096
	add a, a ; $4098
	add a, l ; $4099
	ld l, a ; $409a
	jr nc, Label_0b_409e ; $409b
	inc h ; $409d
Label_0b_409e:
	srl b ; $409e
	ld a, [wTotalPointsScoredInCurrentGame] ; $40a0
	and a, $01 ; $40a3
	jr z, Label_0b_40ad ; $40a5
	ld a, c ; $40a7
	xor a, $80 ; $40a8
	ld c, a ; $40aa
	jr Label_0b_40ad ; $40ab
Label_0b_40ad:
	ld a, [hl+] ; $40ad
	ld h, [hl] ; $40ae
	ld l, a ; $40af
	inc b ; $40b0
	sla b ; $40b1
	ld a, c ; $40b3
Label_0b_40b4:
	rlc a ; $40b4
	dec b ; $40b6
	jr nz, Label_0b_40b4 ; $40b7
	or a, [hl] ; $40b9
	ld [hl], a ; $40ba
	ret ; $40bb
	; $40bc, 4 bytes (records:2)
	dw $c2fc ; record 0
	dw $c2fd ; record 1
	push bc ; $40c0
	push hl ; $40c1
	ld hl, $c2fc ; $40c2
	add a, l ; $40c5
	ld l, a ; $40c6
	jr nc, Label_0b_40ca ; $40c7
	inc h ; $40c9
Label_0b_40ca:
	ld c, $00 ; $40ca
	ld a, [hl] ; $40cc
	ld b, a ; $40cd
	and a, $03 ; $40ce
	cp a, $01 ; $40d0
	jr nz, Label_0b_40d5 ; $40d2
	inc c ; $40d4
Label_0b_40d5:
	ld a, b ; $40d5
	srl a ; $40d6
	srl a ; $40d8
	and a, $03 ; $40da
	cp a, $01 ; $40dc
	jr nz, Label_0b_40e1 ; $40de
	inc c ; $40e0
Label_0b_40e1:
	ld a, b ; $40e1
	swap a ; $40e2
	and a, $03 ; $40e4
	cp a, $01 ; $40e6
	jr nz, Label_0b_40eb ; $40e8
	inc c ; $40ea
Label_0b_40eb:
	ld a, b ; $40eb
	swap a ; $40ec
	srl a ; $40ee
	srl a ; $40f0
	and a, $03 ; $40f2
	cp a, $01 ; $40f4
	jr nz, Label_0b_40f9 ; $40f6
	inc c ; $40f8
Label_0b_40f9:
	ld a, c ; $40f9
	pop hl ; $40fa
	pop bc ; $40fb
	ret ; $40fc
	ld a, [wPlayer2PointsWon] ; $40fd
	ld b, a ; $4100
	ld a, [wPlayer1PointsWon] ; $4101
	sub a, b ; $4104
	bit 7, a ; $4105
	jr nz, Label_0b_4110 ; $4107
	cp a, $02 ; $4109
	jr c, Label_0b_4119 ; $410b
	ld a, $01 ; $410d
	ret ; $410f
Label_0b_4110:
	cpl ; $4110
	inc a ; $4111
	cp a, $02 ; $4112
	jr c, Label_0b_4119 ; $4114
	ld a, $02 ; $4116
	ret ; $4118
Label_0b_4119:
	xor a, a ; $4119
	ret ; $411a
	INCBIN "data/bank_00b/d_411b.bin" ; $411b, 48 bytes
Func_0b_414b:
	ldh a, [hWramBank] ; $414b
	push af ; $414d
	wram_bank $05 ; $414e
	ld a, $00 ; $4154
	farcall FarPtr_SetCharState ; $4156
	pop af ; $4159
	wram_bank ; $415a
	ret ; $415e
	ld a, [wTotalPointsScoredInCurrentGame] ; $415f
	add a, a ; $4162
	add a, a ; $4163
	add a, a ; $4164
	add a, l ; $4165
	ld l, a ; $4166
	jr nc, Label_0b_416a ; $4167
	inc h ; $4169
Label_0b_416a:
	ld b, h ; $416a
	ld c, l ; $416b
	ld hl, $0002 ; $416c
	add hl, bc ; $416f
	ld a, [hl+] ; $4170
	ld d, [hl] ; $4171
	ld e, a ; $4172
	ld hl, $0000 ; $4173
	add hl, bc ; $4176
	ld a, [hl+] ; $4177
	ld h, [hl] ; $4178
	ld l, a ; $4179
	push bc ; $417a
	farcall FarPtr_SetBallGatePoint1 ; $417b
	pop bc ; $417e
	ld hl, $0006 ; $417f
	add hl, bc ; $4182
	ld a, [hl+] ; $4183
	ld d, [hl] ; $4184
	ld e, a ; $4185
	ld hl, $0004 ; $4186
	add hl, bc ; $4189
	ld a, [hl+] ; $418a
	ld h, [hl] ; $418b
	ld l, a ; $418c
	farcall FarPtr_SetBallGatePoint2 ; $418d
	ret ; $4190
SetDrillTargetZoneForPoint:
	ld a, [wTotalPointsScoredInCurrentGame] ; $4191
	add a, a ; $4194
	add a, a ; $4195
	add a, a ; $4196
	add a, l ; $4197
	ld l, a ; $4198
	jr nc, Label_0b_419c ; $4199
	inc h ; $419b
Label_0b_419c:
	ld b, h ; $419c
	ld c, l ; $419d
	ld hl, $0002 ; $419e
	add hl, bc ; $41a1
	ld a, [hl+] ; $41a2
	ld d, [hl] ; $41a3
	ld e, a ; $41a4
	ld hl, $0000 ; $41a5
	add hl, bc ; $41a8
	ld a, [hl+] ; $41a9
	ld h, [hl] ; $41aa
	ld l, a ; $41ab
	push bc ; $41ac
	farcall FarPtr_SetTargetZoneCorner1 ; $41ad
	pop bc ; $41b0
	ld hl, $0006 ; $41b1
	add hl, bc ; $41b4
	ld a, [hl+] ; $41b5
	ld d, [hl] ; $41b6
	ld e, a ; $41b7
	ld hl, $0004 ; $41b8
	add hl, bc ; $41bb
	ld a, [hl+] ; $41bc
	ld h, [hl] ; $41bd
	ld l, a ; $41be
	farcall FarPtr_SetTargetZoneCorner2 ; $41bf
	ret ; $41c2
Func_0b_41c3:
	ld a, [$c2e1] ; $41c3
	or a, a ; $41c6
	ret z ; $41c7
	ld a, [wPointOutcome] ; $41c8
	or a, a ; $41cb
	ret nz ; $41cc
	ld hl, $c2e0 ; $41cd
	dec [hl] ; $41d0
	ld a, [hl] ; $41d1
	or a, a ; $41d2
	ret nz ; $41d3
	ld a, $01 ; $41d4
	ld [wMatchAbortFlag], a ; $41d6
	ret ; $41d9
	ld a, [wPointOutcome] ; $41da
	cp a, $04 ; $41dd
	ret z ; $41df
	cp a, $01 ; $41e0
	ret z ; $41e2
	cp a, $03 ; $41e3
	ret z ; $41e5
RecordDrillTargetZoneHit:
	ld a, [$c4b2] ; $41e6
	cp a, $02 ; $41e9
	ret nc ; $41eb
	farcall FarPtr_IsBallInTargetZone ; $41ec
	jr z, Label_0b_41f6 ; $41ef
	xor a, a ; $41f1
	ld [wTargetZoneEnabled], a ; $41f2
	ret ; $41f5
Label_0b_41f6:
	ld a, [wTotalPointsScoredInCurrentGame] ; $41f6
	ld b, a ; $41f9
	inc b ; $41fa
	xor a, a ; $41fb
	scf ; $41fc
Label_0b_41fd:
	rla ; $41fd
	dec b ; $41fe
	jr nz, Label_0b_41fd ; $41ff
	ld hl, $c2e4 ; $4201
	or a, [hl] ; $4204
	ld [hl], a ; $4205
	ret ; $4206
	INCBIN "data/bank_00b/d_4207.bin" ; $4207, 4 bytes
	push bc ; $420b
	ld a, [$c2e4] ; $420c
	ld b, a ; $420f
	xor a, a ; $4210
	ld c, $08 ; $4211
Label_0b_4213:
	rr b ; $4213
	adc a, $00 ; $4215
	dec c ; $4217
	jr nz, Label_0b_4213 ; $4218
	pop bc ; $421a
	ret ; $421b
CheckDrillTargetZoneMissed:
	push bc ; $421c
	ld a, [wTotalPointsScoredInCurrentGame] ; $421d
	ld c, a ; $4220
	inc c ; $4221
	ld a, [$c2e4] ; $4222
	ld b, a ; $4225
Label_0b_4226:
	ld a, $00 ; $4226
	rr b ; $4228
	adc a, $00 ; $422a
	dec c ; $422c
	jr nz, Label_0b_4226 ; $422d
	xor a, $01 ; $422f
	pop bc ; $4231
	ret ; $4232
	ld a, [wRallyLength] ; $4233
	cp a, $01 ; $4236
	ret nz ; $4238
	ld a, [$c78b] ; $4239
	or a, a ; $423c
	ret z ; $423d
	farcall FarPtr_DidBallCrossGate ; $423e
	ret z ; $4241
	xor a, a ; $4242
	ld [$c78b], a ; $4243
	ld a, [wTotalPointsScoredInCurrentGame] ; $4246
	ld b, a ; $4249
	inc b ; $424a
	xor a, a ; $424b
	scf ; $424c
Label_0b_424d:
	rla ; $424d
	dec b ; $424e
	jr nz, Label_0b_424d ; $424f
	ld hl, $c2e5 ; $4251
	or a, [hl] ; $4254
	ld [hl], a ; $4255
	ret ; $4256
	push bc ; $4257
	ld a, [$c2e5] ; $4258
	ld b, a ; $425b
	xor a, a ; $425c
	ld c, $08 ; $425d
Label_0b_425f:
	rr b ; $425f
	adc a, $00 ; $4261
	dec c ; $4263
	jr nz, Label_0b_425f ; $4264
	pop bc ; $4266
	ret ; $4267
	INCBIN "data/bank_00b/d_4268.bin" ; $4268, 318 bytes
PlayDrillPointEndSequence:
	ld hl, $c442 ; $43a6
	ld a, [hl+] ; $43a9
	ld d, [hl] ; $43aa
	ld e, a ; $43ab
	ld hl, $c440 ; $43ac
	ld a, [hl+] ; $43af
	ld h, [hl] ; $43b0
	ld l, a ; $43b1
	farcall FarPtr_SetCameraTarget ; $43b2
	ld a, [wPointOutcome] ; $43b5
	cp a, $06 ; $43b8
	jr z, Label_0b_43dc ; $43ba
	cp a, $07 ; $43bc
	jr z, Label_0b_43dc ; $43be
	cp a, $01 ; $43c0
	jr z, Label_0b_43ca ; $43c2
	cp a, $03 ; $43c4
	jr z, Label_0b_43ca ; $43c6
	jr Label_0b_43cf ; $43c8
Label_0b_43ca:
	add a, $00 ; $43ca
	farcall FarPtr_09_12 ; $43cc
Label_0b_43cf:
	ld a, $1e ; $43cf
	farcall FarPtr_StepMatchFrames ; $43d1
	farcall FarPtr_09_16 ; $43d4
	ld a, $0f ; $43d7
	farcall FarPtr_StepMatchFrames ; $43d9
Label_0b_43dc:
	farcall FarPtr_09_0a ; $43dc
	ld a, $0a ; $43df
	farcall FarPtr_StepMatchFrames ; $43e1
	ld a, $0a ; $43e4
	farcall FarPtr_StepMatchFramesSkippable ; $43e6
	farcall FarPtr_09_26 ; $43e9
	ld a, $0a ; $43ec
	farcall FarPtr_StepMatchFrames ; $43ee
	ld a, $1e ; $43f1
	farcall FarPtr_StepMatchFramesSkippable ; $43f3
	farcall FarPtr_09_0c ; $43f6
	ld a, $46 ; $43f9
	farcall FarPtr_StepMatchFramesSkippable ; $43fb
	ld a, $08 ; $43fe
	farcall FarPtr_StepMatchFrames ; $4400
	ret ; $4403
LoadDrillOpponentChar:
	ld b, a ; $4404
	ld c, $02 ; $4405
	farcall FarPtr_02_18 ; $4407
	ldh a, [hWramBank] ; $440a
	push af ; $440c
	wram_bank $05 ; $440d
	farcall FarPtr_LoadCharacterAttributes ; $4413
	pop af ; $4416
	wram_bank ; $4417
	ret ; $441b
	ld a, [wCurrentServingPlayer] ; $441c
	and a, $01 ; $441f
	add a, l ; $4421
	ld l, a ; $4422
	jr nc, Label_0b_4426 ; $4423
	inc h ; $4425
Label_0b_4426:
	ld a, [hl] ; $4426
	call LoadDrillOpponentChar ; $4427
	ret ; $442a
	ld b, a ; $442b
	ldh a, [hWramBank] ; $442c
	push af ; $442e
	wram_bank $05 ; $442f
	ld de, $df00 ; $4435
	add hl, de ; $4438
	ld [hl], b ; $4439
	pop af ; $443a
	wram_bank ; $443b
	ret ; $443f
	INCBIN "data/bank_00b/d_4440.bin" ; $4440, 7 bytes
Func_0b_4447:
	ld b, a ; $4447
	ldh a, [hWramBank] ; $4448
	push af ; $444a
	ld a, $04 ; $444b
	add a, b ; $444d
	ld a, a ; $444e
	wram_bank ; $444f
	ld de, $df00 ; $4453
	ld hl, $0050 ; $4456
	add hl, de ; $4459
	ld a, [hl] ; $445a
	bit 4, a ; $445b
	jr z, Label_0b_4467 ; $445d
	pop af ; $445f
	wram_bank ; $4460
	ld a, $01 ; $4464
	ret ; $4466
Label_0b_4467:
	pop af ; $4467
	wram_bank ; $4468
	xor a, a ; $446c
	ret ; $446d
	ldh a, [hWramBank] ; $446e
	push af ; $4470
	wram_bank $05 ; $4471
	ld hl, $df57 ; $4477
	ld a, [wPointWinLoseFlag] ; $447a
	ld [hl], a ; $447d
	pop af ; $447e
	wram_bank ; $447f
	ret ; $4483
	ld a, [wPointOutcome] ; $4484
	cp a, $01 ; $4487
	jr z, Label_0b_44ec ; $4489
	cp a, $03 ; $448b
	jr z, Label_0b_44ec ; $448d
	cp a, $09 ; $448f
	ld a, $01 ; $4491
	jr z, Label_0b_44de ; $4493
	ld a, [$c8f7] ; $4495
	cp a, $01 ; $4498
	jr nz, Label_0b_44af ; $449a
	ld hl, $c2f8 ; $449c
	ld a, [wCurrentServingPlayer] ; $449f
	add a, l ; $44a2
	ld l, a ; $44a3
	jr nc, Label_0b_44a7 ; $44a4
	inc h ; $44a6
Label_0b_44a7:
	ld a, [hl] ; $44a7
	or a, a ; $44a8
	jr nz, Label_0b_44af ; $44a9
	ld a, $03 ; $44ab
	jr Label_0b_44de ; $44ad
Label_0b_44af:
	ld a, [wRallyLength] ; $44af
	cp a, $01 ; $44b2
	jr nz, Label_0b_44c4 ; $44b4
	ld a, [wServiceAceFlag] ; $44b6
	or a, a ; $44b9
	jr z, Label_0b_44c0 ; $44ba
	ld a, $01 ; $44bc
	jr Label_0b_44de ; $44be
Label_0b_44c0:
	ld a, $02 ; $44c0
	jr Label_0b_44de ; $44c2
Label_0b_44c4:
	ld a, [wPointOutcome] ; $44c4
	or a, a ; $44c7
	jr nz, Label_0b_44ce ; $44c8
	ld a, $04 ; $44ca
	jr Label_0b_44de ; $44cc
Label_0b_44ce:
	cp a, $07 ; $44ce
	ld a, $06 ; $44d0
	jr z, Label_0b_44de ; $44d2
	cp a, $09 ; $44d4
	ld a, $01 ; $44d6
	jr z, Label_0b_44de ; $44d8
	ld a, $05 ; $44da
	jr Label_0b_44de ; $44dc
Label_0b_44de:
	ld b, a ; $44de
	ld a, [wCurrentServingPlayer] ; $44df
	or a, a ; $44e2
	jr z, Label_0b_44e7 ; $44e3
	ld a, $06 ; $44e5
Label_0b_44e7:
	add a, b ; $44e7
	ld [$c2e6], a ; $44e8
	ret ; $44eb
Label_0b_44ec:
	ld a, $ff ; $44ec
	ld [$c2e6], a ; $44ee
	ret ; $44f1
	ld a, [wPointOutcome] ; $44f2
	cp a, $01 ; $44f5
	jr z, Label_0b_452e ; $44f7
	cp a, $03 ; $44f9
	jr z, Label_0b_452e ; $44fb
	call CheckDrillTargetZoneMissed ; $44fd
	or a, a ; $4500
	jr nz, Label_0b_4507 ; $4501
	ld a, $10 ; $4503
	jr Label_0b_452a ; $4505
Label_0b_4507:
	ld a, [wRallyLength] ; $4507
	cp a, $01 ; $450a
	jr nz, Label_0b_451c ; $450c
	ld a, [wServiceAceFlag] ; $450e
	or a, a ; $4511
	jr z, Label_0b_4518 ; $4512
	ld a, $0d ; $4514
	jr Label_0b_452a ; $4516
Label_0b_4518:
	ld a, $0e ; $4518
	jr Label_0b_452a ; $451a
Label_0b_451c:
	ld a, [wPointOutcome] ; $451c
	or a, a ; $451f
	jr nz, Label_0b_4526 ; $4520
	ld a, $10 ; $4522
	jr Label_0b_452a ; $4524
Label_0b_4526:
	ld a, $10 ; $4526
	jr Label_0b_452a ; $4528
Label_0b_452a:
	ld [$c2e6], a ; $452a
	ret ; $452d
Label_0b_452e:
	ld a, $ff ; $452e
	ld [$c2e6], a ; $4530
	ret ; $4533
QueueDrillResultMessage:
	cp a, $ff ; $4534
	jr z, Label_0b_4541 ; $4536
	ld c, a ; $4538
	ld a, [wCurrentServingPlayer] ; $4539
	or a, a ; $453c
	jr z, Label_0b_4540 ; $453d
	ld a, b ; $453f
Label_0b_4540:
	add a, c ; $4540
Label_0b_4541:
	ld [$c2e6], a ; $4541
	ret ; $4544
	cp a, $ff ; $4545
	jr z, Label_0b_4554 ; $4547
	ld c, a ; $4549
	ld a, [wCurrentServingPlayer] ; $454a
	xor a, $01 ; $454d
	or a, a ; $454f
	jr z, Label_0b_4553 ; $4550
	ld a, b ; $4552
Label_0b_4553:
	add a, c ; $4553
Label_0b_4554:
	ld [$c2e6], a ; $4554
	ret ; $4557
	cp a, $ff ; $4558
	jr z, Label_0b_4570 ; $455a
	ld c, a ; $455c
	ld a, [wTotalPointsScoredInCurrentGame] ; $455d
	xor a, $01 ; $4560
	ld d, a ; $4562
	ld a, [wRallyLength] ; $4563
	xor a, $01 ; $4566
	add a, d ; $4568
	and a, $01 ; $4569
	or a, a ; $456b
	jr z, Label_0b_456f ; $456c
	ld a, b ; $456e
Label_0b_456f:
	add a, c ; $456f
Label_0b_4570:
	ld [$c2e6], a ; $4570
	ret ; $4573
ShowQueuedDrillMessage:
	ld a, [$c2e6] ; $4574
	or a, a ; $4577
	jr nz, Label_0b_457f ; $4578
	ld a, $6c ; $457a
	ld [$c2e6], a ; $457c
Label_0b_457f:
	call ShowDrillMessageByIndex ; $457f
	ret ; $4582
ShowDrillMessageByIndex:
	cp a, $ff ; $4583
	ret z ; $4585
	ld h, $00 ; $4586
	ld l, a ; $4588
	add hl, hl ; $4589
	ld de, DrillMessageTextIds_0b ; $458a
	add hl, de ; $458d
	ld a, [hl+] ; $458e
	ld b, [hl] ; $458f
	ld c, a ; $4590
	ld h, b ; $4591
	ld l, c ; $4592
	xor a, a ; $4593
	farcall FarPtr_AddTextIdOffset ; $4594
	ld b, h ; $4597
	ld c, l ; $4598
	farcall FarPtr_MeasureDialogueWidthTiles ; $4599
	ld h, b ; $459c
	ld l, c ; $459d
	add a, $02 ; $459e
	ld b, a ; $45a0
	ldh a, [hWramBank] ; $45a1
	push af ; $45a3
	wram_bank $05 ; $45a4
	ld a, [$d86f] ; $45aa
	ld e, a ; $45ad
	pop af ; $45ae
	wram_bank ; $45af
	ld a, e ; $45b3
	add a, a ; $45b4
	inc a ; $45b5
	ld c, a ; $45b6
	ld d, b ; $45b7
	ld a, $14 ; $45b8
	sub a, d ; $45ba
	srl a ; $45bb
	ld d, a ; $45bd
	ld e, $06 ; $45be
	farcall FarPtr_ShowMessageWindow ; $45c0
	ret ; $45c3
DrillMessageTextIds_0b:
	; $45c4, 274 bytes (records:2)
	dw $28c4 ; record 0
	dw $28c4 ; record 1
	dw $28c5 ; record 2
	dw $28c6 ; record 3
	dw $28c7 ; record 4
	dw $28c8 ; record 5
	dw $28c9 ; record 6
	dw $28ca ; record 7
	dw $28cb ; record 8
	dw $28cc ; record 9
	dw $28cd ; record 10
	dw $28ce ; record 11
	dw $28cf ; record 12
	dw $28d0 ; record 13
	dw $28d1 ; record 14
	dw $28d2 ; record 15
	dw $28d3 ; record 16
	dw $28d4 ; record 17
	dw $28d5 ; record 18
	dw $28d6 ; record 19
	dw $28d7 ; record 20
	dw $28d8 ; record 21
	dw $28d9 ; record 22
	dw $28da ; record 23
	dw $28db ; record 24
	dw $28dc ; record 25
	dw $28dd ; record 26
	dw $28de ; record 27
	dw $28df ; record 28
	dw $28e0 ; record 29
	dw $28e1 ; record 30
	dw $28e2 ; record 31
	dw $28e3 ; record 32
	dw $28e4 ; record 33
	dw $28e5 ; record 34
	dw $28e6 ; record 35
	dw $28e7 ; record 36
	dw $28e8 ; record 37
	dw $28e9 ; record 38
	dw $28ea ; record 39
	dw $28eb ; record 40
	dw $28ec ; record 41
	dw $28ed ; record 42
	dw $28ee ; record 43
	dw $28ef ; record 44
	dw $28f0 ; record 45
	dw $28f1 ; record 46
	dw $28f2 ; record 47
	dw $28f3 ; record 48
	dw $28f4 ; record 49
	dw $28f5 ; record 50
	dw $28f6 ; record 51
	dw $28f7 ; record 52
	dw $28f8 ; record 53
	dw $28f9 ; record 54
	dw $28fa ; record 55
	dw $28fb ; record 56
	dw $28fc ; record 57
	dw $28fd ; record 58
	dw $28fe ; record 59
	dw $28ff ; record 60
	dw $2900 ; record 61
	dw $2901 ; record 62
	dw $2902 ; record 63
	dw $2903 ; record 64
	dw $2904 ; record 65
	dw $2905 ; record 66
	dw $2906 ; record 67
	dw $2907 ; record 68
	dw $2908 ; record 69
	dw $2909 ; record 70
	dw $290a ; record 71
	dw $290b ; record 72
	dw $290c ; record 73
	dw $290d ; record 74
	dw $290e ; record 75
	dw $290f ; record 76
	dw $2910 ; record 77
	dw $2911 ; record 78
	dw $2912 ; record 79
	dw $2913 ; record 80
	dw $2914 ; record 81
	dw $2915 ; record 82
	dw $2916 ; record 83
	dw $2917 ; record 84
	dw $2918 ; record 85
	dw $2919 ; record 86
	dw $2c0f ; record 87
	dw $2c10 ; record 88
	dw $2c11 ; record 89
	dw $2c12 ; record 90
	dw $2c13 ; record 91
	dw $2c14 ; record 92
	dw $2c15 ; record 93
	dw $2c16 ; record 94
	dw $2c17 ; record 95
	dw $2c18 ; record 96
	dw $2c19 ; record 97
	dw $2c1a ; record 98
	dw $2c1b ; record 99
	dw $2c1c ; record 100
	dw $2c1d ; record 101
	dw $2c1e ; record 102
	dw $2c1f ; record 103
	dw $2c20 ; record 104
	dw $2c21 ; record 105
	dw $2c22 ; record 106
	dw $2c23 ; record 107
	dw $2c24 ; record 108
	dw $0200 ; record 109
	dw $8bfa ; record 110
	dw $a7c7 ; record 111
	dw $01c8 ; record 112
	dw $0000 ; record 113
	dw $9a21 ; record 114
	dw $2ac7 ; record 115
	dw $5f56 ; record 116
	dw $9821 ; record 117
	dw $2ac7 ; record 118
	dw $6f66 ; record 119
	dw $44df ; record 120
	dw $df08 ; record 121
	dw $0846 ; record 122
	dw $e821 ; record 123
	dw $0146 ; record 124
	dw $0930 ; record 125
	dw $9dcd ; record 126
	dw $c91e ; record 127
	dw $8bfa ; record 128
	dw $a7c7 ; record 129
	dw $01c8 ; record 130
	dw $0000 ; record 131
	dw $9e21 ; record 132
	dw $2ac7 ; record 133
	dw $5f56 ; record 134
	dw $9c21 ; record 135
	dw $2ac7 ; record 136
QueueDrillSprite_0b:
	ld h, [hl] ; $46d6
	ld l, a ; $46d7
	farcall FarPtr_08_44 ; $46d8
	farcall FarPtr_ApplyCameraProjection ; $46db
	ld hl, DrillSpriteTemplate_0b ; $46de
	ld bc, $0930 ; $46e1
	call QueueSpriteTemplate ; $46e4
	ret ; $46e7
DrillSpriteTemplate_0b:
	INCBIN "data/bank_00b/d_46e8.bin" ; $46e8, 29 bytes
RunTrainingDrillByID:
	push af ; $4705
	farcall FarPtr_08_06 ; $4706
	pop af ; $4709
	cp a, $24 ; $470a
	jp z, Label_0b_47ae ; $470c
	cp a, $12 ; $470f
	jr nc, Label_0b_4723 ; $4711
	ld l, a ; $4713
	ld h, $00 ; $4714
	add hl, hl ; $4716
	ld de, $47b4 ; $4717
	add hl, de ; $471a
	ld a, [hl+] ; $471b
	ld b, [hl] ; $471c
	ld c, a ; $471d
	call StartDrillFromDefinition ; $471e
	jr Label_0b_4726 ; $4721
Label_0b_4723:
	farcall FarPtr_StartMinigameByID ; $4723
Label_0b_4726:
	ld hl, $c2e0 ; $4726
	ld c, $02 ; $4729
	call ClearMemory16 ; $472b
	ld a, $ff ; $472e
	ld [$c7b5], a ; $4730
	xor a, a ; $4733
	ld hl, $c7b6 ; $4734
	ld [hl+], a ; $4737
	ld [hl], a ; $4738
	ld [$c7a8], a ; $4739
	farcall FarPtr_RunMinigameMatch ; $473c
Label_0b_473f:
	xor a, a ; $473f
	ldh [hScrollX], a ; $4740
	ldh [hScrollY], a ; $4742
	ld a, $ff ; $4744
	ld [$c7b5], a ; $4746
	xor a, a ; $4749
	ld hl, $c7b6 ; $474a
	ld [hl+], a ; $474d
	ld [hl], a ; $474e
	ld [$c7a8], a ; $474f
	ld a, [wMatchRetryRequest] ; $4752
	or a, a ; $4755
	ld a, [$c8f7] ; $4756
	jp nz, RunTrainingDrillByID ; $4759
	ld a, [wMatchExitRequest] ; $475c
	or a, a ; $475f
	jr z, Label_0b_4767 ; $4760
	ld a, $ff ; $4762
	ld [wPointWinLoseFlag], a ; $4764
Label_0b_4767:
	test_flag $03, 6 ; $4767
	jr z, Label_0b_47a7 ; $476a
	call DisableLCDSafely ; $476c
	farcall FarPtr_ResetTextWindowState ; $476f
	call ClearBGForDrillResult ; $4772
	farcall FarPtr_01_0a ; $4775
	call EnableLCD ; $4778
	ld c, $08 ; $477b
	call BeginFadeIn ; $477d
	call WaitFadeEnd ; $4780
	ld a, [$c2e3] ; $4783
	ld l, a ; $4786
	ld h, $00 ; $4787
	farcall FarPtr_PushTextArgNumber ; $4789
	ld a, [wPointWinLoseFlag] ; $478c
	inc a ; $478f
	srl a ; $4790
	ld hl, $015f ; $4792
	add a, l ; $4795
	ld l, a ; $4796
	jr nc, Label_0b_479a ; $4797
	inc h ; $4799
Label_0b_479a:
	ld a, $80 ; $479a
	farcall FarPtr_ShowSpeakerDialogue ; $479c
	ld c, $10 ; $479f
	call BeginFadeOut ; $47a1
	call WaitFadeEnd ; $47a4
Label_0b_47a7:
	clear_flag $03, 6 ; $47a7
	farcall FarPtr_ProcessMatchRewards ; $47aa
	ret ; $47ad
Label_0b_47ae:
	call RunDoublesDrillMatch ; $47ae
	jp Label_0b_473f ; $47b1
	; $47b4, 36 bytes (records:2)
	dw $482c ; record 0
	dw $49c7 ; record 1
	dw $4c13 ; record 2
	dw $4de2 ; record 3
	dw $4f69 ; record 4
	dw $51cd ; record 5
	dw $53dd ; record 6
	dw $5644 ; record 7
	dw $58bf ; record 8
	dw $5bda ; record 9
	dw $5e95 ; record 10
	dw $614e ; record 11
	dw $6400 ; record 12
	dw $66db ; record 13
	dw $6926 ; record 14
	dw $6b5d ; record 15
	dw $6dae ; record 16
	dw $700e ; record 17
ClearBGForDrillResult:
	call DisableLCDSafely ; $47d8
	wram_bank $02 ; $47db
	ld a, $00 ; $47e1
	ld hl, $d000 ; $47e3
	ld bc, $0500 ; $47e6
	call FillMemoryBC_0b ; $47e9
	wram_bank $03 ; $47ec
	ld a, $20 ; $47f2
	ld hl, $d000 ; $47f4
	ld bc, $0500 ; $47f7
	call FillMemoryBC_0b ; $47fa
	wram_bank $03 ; $47fd
	ld hl, $d000 ; $4803
	ld de, $9800 ; $4806
	ld c, $24 ; $4809
	call QueueVRAMCopy ; $480b
	wram_bank $02 ; $480e
	ld hl, $d000 ; $4814
	ld de, $b800 ; $4817
	ld c, $24 ; $481a
	call QueueVRAMCopy ; $481c
	call EnableLCD ; $481f
	ret ; $4822
FillMemoryBC_0b:
	ld e, a ; $4823
Label_0b_4824:
	ld [hl], e ; $4824
	inc hl ; $4825
	dec bc ; $4826
	ld a, c ; $4827
	or a, b ; $4828
	jr nz, Label_0b_4824 ; $4829
	ret ; $482b
	INCBIN "data/bank_00b/d_482c.bin" ; $482c, 226 bytes
	ret ; $490e
	ld a, $02 ; $490f
	call Drill00JudgePoint ; $4911
	ld [$c2ff], a ; $4914
	ret ; $4917
	ret ; $4918
	ld a, $03 ; $4919
	call Drill00JudgePoint ; $491b
	ld [$c2ff], a ; $491e
	ret ; $4921
Drill00JudgePoint:
	ld b, a ; $4922
	ld a, [$c2ff] ; $4923
	or a, a ; $4926
	ret nz ; $4927
	ld a, [wRallyLength] ; $4928
	dec a ; $492b
	ld a, a ; $492c
	rst Rst00 ; $492d
	dw Label_0b_4932 ; $492e jumptable
	dw Label_0b_496c ; $4930 jumptable
Label_0b_4932:
	ld a, b ; $4932
	ld a, a ; $4933
	rst Rst00 ; $4934
	dw Label_0b_493d ; $4935 jumptable
	dw Label_0b_4966 ; $4937 jumptable
	dw Label_0b_4968 ; $4939 jumptable
	dw Label_0b_496a ; $493b jumptable
Label_0b_493d:
	ld a, [wPointOutcome] ; $493d
	ld hl, $495c ; $4940
	add a, l ; $4943
	ld l, a ; $4944
	jr nc, Label_0b_4948 ; $4945
	inc h ; $4947
Label_0b_4948:
	ld a, [hl] ; $4948
	ld a, a ; $4949
	ld b, $06 ; $494a
	call QueueDrillResultMessage ; $494c
	ld a, [wPointOutcome] ; $494f
	ld hl, $46f1 ; $4952
	add a, l ; $4955
	ld l, a ; $4956
	jr nc, Label_0b_495a ; $4957
	inc h ; $4959
Label_0b_495a:
	ld a, [hl] ; $495a
	ret ; $495b
	INCBIN "data/bank_00b/d_495c.bin" ; $495c, 10 bytes
Label_0b_4966:
	xor a, a ; $4966
	ret ; $4967
Label_0b_4968:
	xor a, a ; $4968
	ret ; $4969
Label_0b_496a:
	xor a, a ; $496a
	ret ; $496b
Label_0b_496c:
	ld a, b ; $496c
	ld a, a ; $496d
	rst Rst00 ; $496e
	dw Label_0b_4977 ; $496f jumptable
	dw Label_0b_49a0 ; $4971 jumptable
	dw Label_0b_49b3 ; $4973 jumptable
	dw Label_0b_49b5 ; $4975 jumptable
Label_0b_4977:
	ld a, [wPointOutcome] ; $4977
	ld hl, $4996 ; $497a
	add a, l ; $497d
	ld l, a ; $497e
	jr nc, Label_0b_4982 ; $497f
	inc h ; $4981
Label_0b_4982:
	ld a, [hl] ; $4982
	ld a, a ; $4983
	ld b, $06 ; $4984
	call QueueDrillResultMessage ; $4986
	ld a, [wPointOutcome] ; $4989
	ld hl, $46fb ; $498c
	add a, l ; $498f
	ld l, a ; $4990
	jr nc, Label_0b_4994 ; $4991
	inc h ; $4993
Label_0b_4994:
	ld a, [hl] ; $4994
	ret ; $4995
	INCBIN "data/bank_00b/d_4996.bin" ; $4996, 10 bytes
Label_0b_49a0:
	ld a, [wPointOutcome] ; $49a0
	cp a, $07 ; $49a3
	ld a, $00 ; $49a5
	ret z ; $49a7
	ld a, $04 ; $49a8
	ld b, $06 ; $49aa
	call QueueDrillResultMessage ; $49ac
	jr Label_0b_49bf ; $49af
	db $af ; $49b1
	ret ; $49b2
Label_0b_49b3:
	xor a, a ; $49b3
	ret ; $49b4
Label_0b_49b5:
	xor a, a ; $49b5
	ret ; $49b6
	ld a, $01 ; $49b7
	ld [wMatchAbortFlag], a ; $49b9
	ld a, $01 ; $49bc
	ret ; $49be
Label_0b_49bf:
	ld a, $01 ; $49bf
	ld [wMatchAbortFlag], a ; $49c1
	ld a, $ff ; $49c4
	ret ; $49c6
	INCBIN "data/bank_00b/d_49c7.bin" ; $49c7, 4643 bytes
	ld a, $01 ; $5bea
	ld [$c7bb], a ; $5bec
	ret ; $5bef
	; $5bf0, 16 bytes (records:2)
	dw $5c15 ; record 0
	dw $5c19 ; record 1
	dw $5c52 ; record 2
	dw $5c00 ; record 3
	dw $5cc9 ; record 4
	dw $5cc5 ; record 5
	dw $5cc1 ; record 6
	dw $03ae ; record 7
	xor a, a ; $5c00
	ld [$c2e9], a ; $5c01
	ld [$c2ea], a ; $5c04
	ld [$c2eb], a ; $5c07
	ld a, $04 ; $5c0a
	ld [$c2ec], a ; $5c0c
	ld a, $01 ; $5c0f
	ld [$c7bb], a ; $5c11
	ret ; $5c14
	call Func_0b_41c3 ; $5c15
	ret ; $5c18
	xor a, a ; $5c19
	ld [$c2e1], a ; $5c1a
	ld a, $0a ; $5c1d
	ld [$c2e0], a ; $5c1f
	xor a, a ; $5c22
	ld [$c2ed], a ; $5c23
	ld a, $01 ; $5c26
	ld [wTargetZoneEnabled], a ; $5c28
	ld hl, $5cd7 ; $5c2b
	call SetDrillTargetZoneForPoint ; $5c2e
	ld a, $40 ; $5c31
	call LoadDrillOpponentChar ; $5c33
	xor a, a ; $5c36
	ld [$c2e6], a ; $5c37
	xor a, a ; $5c3a
	ld [$c2ff], a ; $5c3b
	ld a, [wTotalPointsScoredInCurrentGame] ; $5c3e
	ld hl, $5c4e ; $5c41
	add a, l ; $5c44
	ld l, a ; $5c45
	jr nc, Label_0b_5c49 ; $5c46
	inc h ; $5c48
Label_0b_5c49:
	ld a, [hl] ; $5c49
	ld [$c7b5], a ; $5c4a
	ret ; $5c4d
	INCBIN "data/bank_00b/d_5c4e.bin" ; $5c4e, 4 bytes
	call Func_0b_5d48 ; $5c52
	ld a, [wPointOutcome] ; $5c55
	cp a, $04 ; $5c58
	jr z, Label_0b_5c62 ; $5c5a
	cp a, $05 ; $5c5c
	jr z, Label_0b_5c62 ; $5c5e
	jr Label_0b_5c66 ; $5c60
Label_0b_5c62:
	ld hl, $c2e9 ; $5c62
	inc [hl] ; $5c65
Label_0b_5c66:
	call Drill09HandlePointEnd ; $5c66
	ld a, [wTotalPointsScoredInCurrentGame] ; $5c69
	cp a, $04 ; $5c6c
	ret c ; $5c6e
	call Drill09EvaluateResult ; $5c6f
	ld [wPointWinLoseFlag], a ; $5c72
	ret ; $5c75
Drill09EvaluateResult:
	ld a, [$c2eb] ; $5c76
	cp a, $04 ; $5c79
	jr nz, Label_0b_5c84 ; $5c7b
	xor a, a ; $5c7d
	ld [$c2e3], a ; $5c7e
	ld a, $01 ; $5c81
	ret ; $5c83
Label_0b_5c84:
	ld a, [wCharacter1DoubleFaults] ; $5c84
	cp a, $04 ; $5c87
	jr nz, Label_0b_5c92 ; $5c89
	ld a, $01 ; $5c8b
	ld [$c2e3], a ; $5c8d
	jr Label_0b_5cbe ; $5c90
Label_0b_5c92:
	or a, a ; $5c92
	jr z, Label_0b_5c9c ; $5c93
	ld a, $02 ; $5c95
	ld [$c2e3], a ; $5c97
	jr Label_0b_5cbe ; $5c9a
Label_0b_5c9c:
	ld a, [$c2eb] ; $5c9c
	cp a, $03 ; $5c9f
	jr nz, Label_0b_5caa ; $5ca1
	ld a, $05 ; $5ca3
	ld [$c2e3], a ; $5ca5
	jr Label_0b_5cbe ; $5ca8
Label_0b_5caa:
	ld a, [$c2ec] ; $5caa
	or a, a ; $5cad
	jr nz, Label_0b_5cb7 ; $5cae
	ld a, $04 ; $5cb0
	ld [$c2e3], a ; $5cb2
	jr Label_0b_5cbe ; $5cb5
Label_0b_5cb7:
	ld a, $03 ; $5cb7
	ld [$c2e3], a ; $5cb9
	jr Label_0b_5cbe ; $5cbc
Label_0b_5cbe:
	ld a, $ff ; $5cbe
	ret ; $5cc0
	call Func_0b_5d63 ; $5cc1
	ret ; $5cc4
	call Func_0b_5d5a ; $5cc5
	ret ; $5cc8
	call Func_0b_5d51 ; $5cc9
	ld a, [$c4b8] ; $5ccc
	cp a, $01 ; $5ccf
	jr nz, Label_0b_5cd6 ; $5cd1
	call Func_0b_414b ; $5cd3
Label_0b_5cd6:
	ret ; $5cd6
	; $5cd7, 34 bytes (records:2)
	dw $0000 ; record 0
	dw $fb20 ; record 1
	dw $01b0 ; record 2
	dw $feb0 ; record 3
	dw $fe50 ; record 4
	dw $fb20 ; record 5
	dw $0000 ; record 6
	dw $feb0 ; record 7
	dw $fe50 ; record 8
	dw $0150 ; record 9
	dw $0000 ; record 10
	dw $04e0 ; record 11
	dw $0000 ; record 12
	dw $0150 ; record 13
	dw $01b0 ; record 14
	dw $04e0 ; record 15
	dw $ffff ; record 16
Drill09HandlePointEnd:
	farcall FarPtr_09_26 ; $5cf9
	ld a, [$c2ff] ; $5cfc
	ld [wPointWinLoseFlag], a ; $5cff
	cp a, $01 ; $5d02
	jr nz, Label_0b_5d0a ; $5d04
	ld hl, $c2eb ; $5d06
	inc [hl] ; $5d09
Label_0b_5d0a:
	call RecordDrillPointResultBits ; $5d0a
	call ShowQueuedDrillMessage ; $5d0d
	farcall FarPtr_UpdatePointStats ; $5d10
	farcall FarPtr_AwardPoint ; $5d13
	ld a, [$c2eb] ; $5d16
	ld [wPlayer1PointsWon], a ; $5d19
	xor a, a ; $5d1c
	ld [wPlayer2PointsWon], a ; $5d1d
	ld a, [wPlayer1PointsWon] ; $5d20
	ld b, $01 ; $5d23
	farcall FarPtr_09_2a ; $5d25
	ld a, [wPlayer2PointsWon] ; $5d28
	ld b, $01 ; $5d2b
	farcall FarPtr_09_2c ; $5d2d
	farcall FarPtr_StepMatchFrame ; $5d30
	ld a, $01 ; $5d33
	ld hl, $446e ; $5d35
	call RegisterFrameTask ; $5d38
	farcall FarPtr_StartPointEndReactions ; $5d3b
	ld hl, $446e ; $5d3e
	call UnregisterFrameTask ; $5d41
	call PlayDrillPointEndSequence ; $5d44
	ret ; $5d47
Func_0b_5d48:
	ld a, $00 ; $5d48
	call Drill09JudgePoint ; $5d4a
	ld [$c2ff], a ; $5d4d
	ret ; $5d50
Func_0b_5d51:
	ld a, $01 ; $5d51
	call Drill09JudgePoint ; $5d53
	ld [$c2ff], a ; $5d56
	ret ; $5d59
Func_0b_5d5a:
	ld a, $02 ; $5d5a
	call Drill09JudgePoint ; $5d5c
	ld [$c2ff], a ; $5d5f
	ret ; $5d62
Func_0b_5d63:
	ret ; $5d63
	INCBIN "data/bank_00b/d_5d64.bin" ; $5d64, 9 bytes
Drill09JudgePoint:
	ld b, a ; $5d6d
	ld a, [$c2ff] ; $5d6e
	or a, a ; $5d71
	ret nz ; $5d72
	ld a, [wRallyLength] ; $5d73
	dec a ; $5d76
	ld a, a ; $5d77
	rst Rst00 ; $5d78
	dw Label_0b_5d7f ; $5d79 jumptable
	dw Label_0b_5db9 ; $5d7b jumptable
	dw Label_0b_5df3 ; $5d7d jumptable
Label_0b_5d7f:
	ld a, b ; $5d7f
	ld a, a ; $5d80
	rst Rst00 ; $5d81
	dw Label_0b_5d8a ; $5d82 jumptable
	dw Label_0b_5db3 ; $5d84 jumptable
	dw Label_0b_5db5 ; $5d86 jumptable
	dw Label_0b_5db7 ; $5d88 jumptable
Label_0b_5d8a:
	ld a, [wPointOutcome] ; $5d8a
	ld hl, $5da9 ; $5d8d
	add a, l ; $5d90
	ld l, a ; $5d91
	jr nc, Label_0b_5d95 ; $5d92
	inc h ; $5d94
Label_0b_5d95:
	ld a, [hl] ; $5d95
	ld a, a ; $5d96
	ld b, $00 ; $5d97
	call QueueDrillResultMessage ; $5d99
	ld a, [wPointOutcome] ; $5d9c
	ld hl, $46f1 ; $5d9f
	add a, l ; $5da2
	ld l, a ; $5da3
	jr nc, Label_0b_5da7 ; $5da4
	inc h ; $5da6
Label_0b_5da7:
	ld a, [hl] ; $5da7
	ret ; $5da8
	INCBIN "data/bank_00b/d_5da9.bin" ; $5da9, 10 bytes
Label_0b_5db3:
	xor a, a ; $5db3
	ret ; $5db4
Label_0b_5db5:
	xor a, a ; $5db5
	ret ; $5db6
Label_0b_5db7:
	xor a, a ; $5db7
	ret ; $5db8
Label_0b_5db9:
	ld a, b ; $5db9
	ld a, a ; $5dba
	rst Rst00 ; $5dbb
	dw Label_0b_5dc4 ; $5dbc jumptable
	dw Label_0b_5ded ; $5dbe jumptable
	dw Label_0b_5def ; $5dc0 jumptable
	dw Label_0b_5df1 ; $5dc2 jumptable
Label_0b_5dc4:
	ld a, [wPointOutcome] ; $5dc4
	ld hl, $5de3 ; $5dc7
	add a, l ; $5dca
	ld l, a ; $5dcb
	jr nc, Label_0b_5dcf ; $5dcc
	inc h ; $5dce
Label_0b_5dcf:
	ld a, [hl] ; $5dcf
	ld a, a ; $5dd0
	ld b, $00 ; $5dd1
	call QueueDrillResultMessage ; $5dd3
	ld a, [wPointOutcome] ; $5dd6
	ld hl, $46fb ; $5dd9
	add a, l ; $5ddc
	ld l, a ; $5ddd
	jr nc, Label_0b_5de1 ; $5dde
	inc h ; $5de0
Label_0b_5de1:
	ld a, [hl] ; $5de1
	ret ; $5de2
	INCBIN "data/bank_00b/d_5de3.bin" ; $5de3, 10 bytes
Label_0b_5ded:
	xor a, a ; $5ded
	ret ; $5dee
Label_0b_5def:
	xor a, a ; $5def
	ret ; $5df0
Label_0b_5df1:
	xor a, a ; $5df1
	ret ; $5df2
Label_0b_5df3:
	ld a, b ; $5df3
	ld a, a ; $5df4
	rst Rst00 ; $5df5
	dw Label_0b_5dfe ; $5df6 jumptable
	dw Label_0b_5e31 ; $5df8 jumptable
	dw Label_0b_5e55 ; $5dfa jumptable
	dw Label_0b_5e83 ; $5dfc jumptable
Label_0b_5dfe:
	ld a, [wPointOutcome] ; $5dfe
	ld hl, $5e27 ; $5e01
	add a, l ; $5e04
	ld l, a ; $5e05
	jr nc, Label_0b_5e09 ; $5e06
	inc h ; $5e08
Label_0b_5e09:
	ld a, [hl] ; $5e09
	ld a, a ; $5e0a
	ld b, $00 ; $5e0b
	call QueueDrillResultMessage ; $5e0d
	ld a, [wPointOutcome] ; $5e10
	ld hl, $5e1d ; $5e13
	add a, l ; $5e16
	ld l, a ; $5e17
	jr nc, Label_0b_5e1b ; $5e18
	inc h ; $5e1a
Label_0b_5e1b:
	ld a, [hl] ; $5e1b
	ret ; $5e1c
	INCBIN "data/bank_00b/d_5e1d.bin" ; $5e1d, 20 bytes
Label_0b_5e31:
	ld a, $35 ; $5e31
	ld b, $00 ; $5e33
	call QueueDrillResultMessage ; $5e35
	xor a, a ; $5e38
	call Func_0b_4447 ; $5e39
	or a, a ; $5e3c
	jp z, Label_0b_5e8d ; $5e3d
	ld a, $3a ; $5e40
	ld b, $00 ; $5e42
	call QueueDrillResultMessage ; $5e44
	ld a, [$c4a1] ; $5e47
	cp a, $01 ; $5e4a
	jp nz, Label_0b_5e8d ; $5e4c
	ld hl, $c2ec ; $5e4f
	dec [hl] ; $5e52
	xor a, a ; $5e53
	ret ; $5e54
Label_0b_5e55:
	ld a, [$c4b2] ; $5e55
	cp a, $01 ; $5e58
	ld a, $00 ; $5e5a
	ret nz ; $5e5c
	ld a, [wPointOutcome] ; $5e5d
	cp a, $04 ; $5e60
	jr z, Label_0b_5e75 ; $5e62
	ld a, $2e ; $5e64
	ld b, $00 ; $5e66
	call QueueDrillResultMessage ; $5e68
	call RecordDrillTargetZoneHit ; $5e6b
	call CheckDrillTargetZoneMissed ; $5e6e
	or a, a ; $5e71
	jp nz, Label_0b_5e85 ; $5e72
Label_0b_5e75:
	ld a, $38 ; $5e75
	ld b, $00 ; $5e77
	call QueueDrillResultMessage ; $5e79
	ld hl, $c2ea ; $5e7c
	inc [hl] ; $5e7f
	jp Label_0b_5e8d ; $5e80
Label_0b_5e83:
	xor a, a ; $5e83
	ret ; $5e84
Label_0b_5e85:
	ld a, $01 ; $5e85
	ld [wMatchAbortFlag], a ; $5e87
	ld a, $01 ; $5e8a
	ret ; $5e8c
Label_0b_5e8d:
	ld a, $01 ; $5e8d
	ld [wMatchAbortFlag], a ; $5e8f
	ld a, $ff ; $5e92
	ret ; $5e94
	INCBIN "data/bank_00b/d_5e95.bin" ; $5e95, 16 bytes
	ld a, $01 ; $5ea5
	ld [$c7bb], a ; $5ea7
	ret ; $5eaa
	call $d15e ; $5eab
	ld e, [hl] ; $5eae
	ld a, [$bb5e] ; $5eaf
	ld e, [hl] ; $5eb2
	add a, e ; $5eb3
	ld e, a ; $5eb4
	ld a, a ; $5eb5
	ld e, a ; $5eb6
	ld a, e ; $5eb7
	ld e, a ; $5eb8
	xor a, [hl] ; $5eb9
	inc bc ; $5eba
	xor a, a ; $5ebb
	ld [$c2ea], a ; $5ebc
	ld [$c2eb], a ; $5ebf
	ld a, $04 ; $5ec2
	ld [$c2ec], a ; $5ec4
	ld a, $01 ; $5ec7
	ld [$c7bb], a ; $5ec9
	ret ; $5ecc
	call Func_0b_41c3 ; $5ecd
	ret ; $5ed0
	INCBIN "data/bank_00b/d_5ed1.bin" ; $5ed1, 3228 bytes
	ld a, $01 ; $6b6d
	ld [$c7bb], a ; $6b6f
	ret ; $6b72
	; $6b73, 16 bytes (records:2)
	dw $6b90 ; record 0
	dw $6b94 ; record 1
	dw $6be1 ; record 2
	dw $6b83 ; record 3
	dw $6c52 ; record 4
	dw $6c4e ; record 5
	dw $6c4a ; record 6
	dw $03ae ; record 7
	ld a, $01 ; $6b83
	ld [$c7bb], a ; $6b85
	xor a, a ; $6b88
	ld [$c2e9], a ; $6b89
	ld [$c2e8], a ; $6b8c
	ret ; $6b8f
	call Func_0b_41c3 ; $6b90
	ret ; $6b93
	xor a, a ; $6b94
	ld [$c2e1], a ; $6b95
	ld a, $0a ; $6b98
	ld [$c2e0], a ; $6b9a
	xor a, a ; $6b9d
	ld [wTargetZoneEnabled], a ; $6b9e
	ld hl, $6c5f ; $6ba1
	call SetDrillTargetZoneForPoint ; $6ba4
	xor a, a ; $6ba7
	ld [$c2e6], a ; $6ba8
	xor a, a ; $6bab
	ld [$c2ff], a ; $6bac
	ld a, $5a ; $6baf
	ld [$c2ef], a ; $6bb1
	ld a, $01 ; $6bb4
	ld hl, $6bd0 ; $6bb6
	call RegisterFrameTask ; $6bb9
	ld a, [wTotalPointsScoredInCurrentGame] ; $6bbc
	ld hl, $6bcc ; $6bbf
	add a, l ; $6bc2
	ld l, a ; $6bc3
	jr nc, Label_0b_6bc7 ; $6bc4
	inc h ; $6bc6
Label_0b_6bc7:
	ld a, [hl] ; $6bc7
	ld [$c7b5], a ; $6bc8
	ret ; $6bcb
	INCBIN "data/bank_00b/d_6bcc.bin" ; $6bcc, 4 bytes
	ld hl, $c2ef ; $6bd0
	dec [hl] ; $6bd3
	ret nz ; $6bd4
	ld a, $01 ; $6bd5
	ld [wTargetZoneEnabled], a ; $6bd7
	ld hl, $6bd0 ; $6bda
	call UnregisterFrameTask ; $6bdd
	ret ; $6be0
	call Func_0b_6cd0 ; $6be1
	ld a, [wPointOutcome] ; $6be4
	cp a, $05 ; $6be7
	jr z, Label_0b_6bed ; $6be9
	jr Label_0b_6bf1 ; $6beb
Label_0b_6bed:
	ld hl, $c2e8 ; $6bed
	inc [hl] ; $6bf0
Label_0b_6bf1:
	call Drill15HandlePointEnd ; $6bf1
	ld a, [wTotalPointsScoredInCurrentGame] ; $6bf4
	cp a, $04 ; $6bf7
	ret c ; $6bf9
	call Drill15EvaluateResult ; $6bfa
	ld [wPointWinLoseFlag], a ; $6bfd
	ret ; $6c00
Drill15EvaluateResult:
	ld a, [$c2e9] ; $6c01
	cp a, $04 ; $6c04
	jr nz, Label_0b_6c0f ; $6c06
	xor a, a ; $6c08
	ld [$c2e3], a ; $6c09
	ld a, $01 ; $6c0c
	ret ; $6c0e
Label_0b_6c0f:
	ld a, [$c2e8] ; $6c0f
	cp a, $04 ; $6c12
	jr c, Label_0b_6c1d ; $6c14
	ld a, $01 ; $6c16
	ld [$c2e3], a ; $6c18
	jr Label_0b_6c47 ; $6c1b
Label_0b_6c1d:
	cp a, $02 ; $6c1d
	jr c, Label_0b_6c28 ; $6c1f
	ld a, $02 ; $6c21
	ld [$c2e3], a ; $6c23
	jr Label_0b_6c47 ; $6c26
Label_0b_6c28:
	ld a, [$c2e9] ; $6c28
	or a, a ; $6c2b
	jr nz, Label_0b_6c35 ; $6c2c
	ld a, $03 ; $6c2e
	ld [$c2e3], a ; $6c30
	jr Label_0b_6c47 ; $6c33
Label_0b_6c35:
	cp a, $03 ; $6c35
	jr nz, Label_0b_6c40 ; $6c37
	ld a, $05 ; $6c39
	ld [$c2e3], a ; $6c3b
	jr Label_0b_6c47 ; $6c3e
Label_0b_6c40:
	ld a, $04 ; $6c40
	ld [$c2e3], a ; $6c42
	jr Label_0b_6c47 ; $6c45
Label_0b_6c47:
	ld a, $ff ; $6c47
	ret ; $6c49
	call Func_0b_6ceb ; $6c4a
	ret ; $6c4d
	call Func_0b_6ce2 ; $6c4e
	ret ; $6c51
	call Func_0b_6cd9 ; $6c52
	ld a, [wRallyLength] ; $6c55
	cp a, $01 ; $6c58
	ret nz ; $6c5a
	call Func_0b_414b ; $6c5b
	ret ; $6c5e
	; $6c5f, 34 bytes (records:2)
	dw $fe50 ; record 0
	dw $fb20 ; record 1
	dw $0000 ; record 2
	dw $fd60 ; record 3
	dw $0000 ; record 4
	dw $fb20 ; record 5
	dw $01b0 ; record 6
	dw $fd60 ; record 7
	dw $0000 ; record 8
	dw $02a0 ; record 9
	dw $01b0 ; record 10
	dw $04e0 ; record 11
	dw $fe50 ; record 12
	dw $02a0 ; record 13
	dw $0000 ; record 14
	dw $04e0 ; record 15
	dw $ffff ; record 16
Drill15HandlePointEnd:
	farcall FarPtr_09_26 ; $6c81
	ld a, [$c2ff] ; $6c84
	ld [wPointWinLoseFlag], a ; $6c87
	cp a, $01 ; $6c8a
	jr nz, Label_0b_6c92 ; $6c8c
	ld hl, $c2e9 ; $6c8e
	inc [hl] ; $6c91
Label_0b_6c92:
	call RecordDrillPointResultBits ; $6c92
	call ShowQueuedDrillMessage ; $6c95
	farcall FarPtr_UpdatePointStats ; $6c98
	farcall FarPtr_AwardPoint ; $6c9b
	ld a, [$c2e9] ; $6c9e
	ld [wPlayer1PointsWon], a ; $6ca1
	xor a, a ; $6ca4
	ld [wPlayer2PointsWon], a ; $6ca5
	ld a, [wPlayer1PointsWon] ; $6ca8
	ld b, $01 ; $6cab
	farcall FarPtr_09_2a ; $6cad
	ld a, [wPlayer2PointsWon] ; $6cb0
	ld b, $01 ; $6cb3
	farcall FarPtr_09_2c ; $6cb5
	farcall FarPtr_StepMatchFrame ; $6cb8
	ld a, $01 ; $6cbb
	ld hl, $446e ; $6cbd
	call RegisterFrameTask ; $6cc0
	farcall FarPtr_StartPointEndReactions ; $6cc3
	ld hl, $446e ; $6cc6
	call UnregisterFrameTask ; $6cc9
	call PlayDrillPointEndSequence ; $6ccc
	ret ; $6ccf
Func_0b_6cd0:
	ld a, $00 ; $6cd0
	call Drill15JudgePoint ; $6cd2
	ld [$c2ff], a ; $6cd5
	ret ; $6cd8
Func_0b_6cd9:
	ld a, $01 ; $6cd9
	call Drill15JudgePoint ; $6cdb
	ld [$c2ff], a ; $6cde
	ret ; $6ce1
Func_0b_6ce2:
	ld a, $02 ; $6ce2
	call Drill15JudgePoint ; $6ce4
	ld [$c2ff], a ; $6ce7
	ret ; $6cea
Func_0b_6ceb:
	ret ; $6ceb
	INCBIN "data/bank_00b/d_6cec.bin" ; $6cec, 9 bytes
Drill15JudgePoint:
	ld b, a ; $6cf5
	ld a, [$c2ff] ; $6cf6
	or a, a ; $6cf9
	ret nz ; $6cfa
	ld a, [wRallyLength] ; $6cfb
	dec a ; $6cfe
	ld a, a ; $6cff
	rst Rst00 ; $6d00
	dw Label_0b_6d05 ; $6d01 jumptable
	dw Label_0b_6d3f ; $6d03 jumptable
Label_0b_6d05:
	ld a, b ; $6d05
	ld a, a ; $6d06
	rst Rst00 ; $6d07
	dw Label_0b_6d10 ; $6d08 jumptable
	dw Label_0b_6d39 ; $6d0a jumptable
	dw Label_0b_6d3b ; $6d0c jumptable
	dw Label_0b_6d3d ; $6d0e jumptable
Label_0b_6d10:
	ld a, [wPointOutcome] ; $6d10
	ld hl, $6d2f ; $6d13
	add a, l ; $6d16
	ld l, a ; $6d17
	jr nc, Label_0b_6d1b ; $6d18
	inc h ; $6d1a
Label_0b_6d1b:
	ld a, [hl] ; $6d1b
	ld a, a ; $6d1c
	ld b, $00 ; $6d1d
	call QueueDrillResultMessage ; $6d1f
	ld a, [wPointOutcome] ; $6d22
	ld hl, $46fb ; $6d25
	add a, l ; $6d28
	ld l, a ; $6d29
	jr nc, Label_0b_6d2d ; $6d2a
	inc h ; $6d2c
Label_0b_6d2d:
	ld a, [hl] ; $6d2d
	ret ; $6d2e
	INCBIN "data/bank_00b/d_6d2f.bin" ; $6d2f, 10 bytes
Label_0b_6d39:
	xor a, a ; $6d39
	ret ; $6d3a
Label_0b_6d3b:
	xor a, a ; $6d3b
	ret ; $6d3c
Label_0b_6d3d:
	xor a, a ; $6d3d
	ret ; $6d3e
Label_0b_6d3f:
	ld a, b ; $6d3f
	ld a, a ; $6d40
	rst Rst00 ; $6d41
	dw Label_0b_6d4a ; $6d42 jumptable
	dw Label_0b_6d73 ; $6d44 jumptable
	dw Label_0b_6d75 ; $6d46 jumptable
	dw Label_0b_6d9c ; $6d48 jumptable
Label_0b_6d4a:
	ld a, [wPointOutcome] ; $6d4a
	ld hl, $6d69 ; $6d4d
	add a, l ; $6d50
	ld l, a ; $6d51
	jr nc, Label_0b_6d55 ; $6d52
	inc h ; $6d54
Label_0b_6d55:
	ld a, [hl] ; $6d55
	ld a, a ; $6d56
	ld b, $00 ; $6d57
	call QueueDrillResultMessage ; $6d59
	ld a, [wPointOutcome] ; $6d5c
	ld hl, $46f1 ; $6d5f
	add a, l ; $6d62
	ld l, a ; $6d63
	jr nc, Label_0b_6d67 ; $6d64
	inc h ; $6d66
Label_0b_6d67:
	ld a, [hl] ; $6d67
	ret ; $6d68
	INCBIN "data/bank_00b/d_6d69.bin" ; $6d69, 10 bytes
Label_0b_6d73:
	xor a, a ; $6d73
	ret ; $6d74
Label_0b_6d75:
	ld a, [$c4b2] ; $6d75
	cp a, $01 ; $6d78
	ld a, $00 ; $6d7a
	ret nz ; $6d7c
	ld a, $57 ; $6d7d
	ld b, $00 ; $6d7f
	call QueueDrillResultMessage ; $6d81
	call RecordDrillTargetZoneHit ; $6d84
	call CheckDrillTargetZoneMissed ; $6d87
	or a, a ; $6d8a
	jp nz, Label_0b_6d9e ; $6d8b
	ld a, $5a ; $6d8e
	ld b, $00 ; $6d90
	call QueueDrillResultMessage ; $6d92
	ld hl, $c2ea ; $6d95
	inc [hl] ; $6d98
	jp Label_0b_6da6 ; $6d99
Label_0b_6d9c:
	xor a, a ; $6d9c
	ret ; $6d9d
Label_0b_6d9e:
	ld a, $01 ; $6d9e
	ld [wMatchAbortFlag], a ; $6da0
	ld a, $01 ; $6da3
	ret ; $6da5
Label_0b_6da6:
	ld a, $01 ; $6da6
	ld [wMatchAbortFlag], a ; $6da8
	ld a, $ff ; $6dab
	ret ; $6dad
	INCBIN "data/bank_00b/d_6dae.bin" ; $6dae, 16 bytes
	ld a, $01 ; $6dbe
	ld [$c7bb], a ; $6dc0
	ret ; $6dc3
	call c, $e06d ; $6dc4
	ld l, l ; $6dc7
	dec l ; $6dc8
	ld l, [hl] ; $6dc9
	call nc, $a36d ; $6dca
	ld l, [hl] ; $6dcd
	sbc a, a ; $6dce
	ld l, [hl] ; $6dcf
	sub a, d ; $6dd0
	ld l, [hl] ; $6dd1
	xor a, [hl] ; $6dd2
	inc bc ; $6dd3
	xor a, a ; $6dd4
	ld [$c2e9], a ; $6dd5
	ld [$c2ee], a ; $6dd8
	ret ; $6ddb
	INCBIN "data/bank_00b/d_6ddc.bin" ; $6ddc, 870 bytes
	farcall FarPtr_UpdatePointStats ; $7142
	farcall FarPtr_AwardPoint ; $7145
	ld a, [$c2e9] ; $7148
	ld [wPlayer1PointsWon], a ; $714b
	xor a, a ; $714e
	ld [wPlayer2PointsWon], a ; $714f
	ld a, [wPlayer1PointsWon] ; $7152
	ld b, $01 ; $7155
	farcall FarPtr_09_2a ; $7157
	ld a, [wPlayer2PointsWon] ; $715a
	ld b, $01 ; $715d
	farcall FarPtr_09_2c ; $715f
	farcall FarPtr_StepMatchFrame ; $7162
	ld a, $01 ; $7165
	ld hl, $446e ; $7167
	call RegisterFrameTask ; $716a
	farcall FarPtr_StartPointEndReactions ; $716d
	ld hl, $446e ; $7170
	call UnregisterFrameTask ; $7173
	call PlayDrillPointEndSequence ; $7176
	ret ; $7179
	ld a, $00 ; $717a
	call Drill17JudgePoint ; $717c
	ld [$c2ff], a ; $717f
	ret ; $7182
	ld a, $01 ; $7183
	call Drill17JudgePoint ; $7185
	ld [$c2ff], a ; $7188
	ret ; $718b
	ld a, $02 ; $718c
	call Drill17JudgePoint ; $718e
	ld [$c2ff], a ; $7191
	ret ; $7194
	INCBIN "data/bank_00b/d_7195.bin" ; $7195, 10 bytes
Drill17JudgePoint:
	ld b, a ; $719f
	ld a, [$c2ff] ; $71a0
	or a, a ; $71a3
	ret nz ; $71a4
	ld a, [wRallyLength] ; $71a5
	dec a ; $71a8
	ld a, a ; $71a9
	rst Rst00 ; $71aa
	dw Label_0b_71af ; $71ab jumptable
	dw Label_0b_71e9 ; $71ad jumptable
Label_0b_71af:
	ld a, b ; $71af
	ld a, a ; $71b0
	rst Rst00 ; $71b1
	dw Label_0b_71ba ; $71b2 jumptable
	dw Label_0b_71e3 ; $71b4 jumptable
	dw Label_0b_71e5 ; $71b6 jumptable
	dw Label_0b_71e7 ; $71b8 jumptable
Label_0b_71ba:
	ld a, [wPointOutcome] ; $71ba
	ld hl, $71d9 ; $71bd
	add a, l ; $71c0
	ld l, a ; $71c1
	jr nc, Label_0b_71c5 ; $71c2
	inc h ; $71c4
Label_0b_71c5:
	ld a, [hl] ; $71c5
	ld a, a ; $71c6
	ld b, $00 ; $71c7
	call QueueDrillResultMessage ; $71c9
	ld a, [wPointOutcome] ; $71cc
	ld hl, $46fb ; $71cf
	add a, l ; $71d2
	ld l, a ; $71d3
	jr nc, Label_0b_71d7 ; $71d4
	inc h ; $71d6
Label_0b_71d7:
	ld a, [hl] ; $71d7
	ret ; $71d8
	INCBIN "data/bank_00b/d_71d9.bin" ; $71d9, 10 bytes
Label_0b_71e3:
	xor a, a ; $71e3
	ret ; $71e4
Label_0b_71e5:
	xor a, a ; $71e5
	ret ; $71e6
Label_0b_71e7:
	xor a, a ; $71e7
	ret ; $71e8
Label_0b_71e9:
	ld a, b ; $71e9
	ld a, a ; $71ea
	rst Rst00 ; $71eb
	dw Label_0b_71f4 ; $71ec jumptable
	dw Label_0b_721d ; $71ee jumptable
	dw Label_0b_721f ; $71f0 jumptable
	dw Label_0b_7246 ; $71f2 jumptable
Label_0b_71f4:
	ld a, [wPointOutcome] ; $71f4
	ld hl, $7213 ; $71f7
	add a, l ; $71fa
	ld l, a ; $71fb
	jr nc, Label_0b_71ff ; $71fc
	inc h ; $71fe
Label_0b_71ff:
	ld a, [hl] ; $71ff
	ld a, a ; $7200
	ld b, $00 ; $7201
	call QueueDrillResultMessage ; $7203
	ld a, [wPointOutcome] ; $7206
	ld hl, $46f1 ; $7209
	add a, l ; $720c
	ld l, a ; $720d
	jr nc, Label_0b_7211 ; $720e
	inc h ; $7210
Label_0b_7211:
	ld a, [hl] ; $7211
	ret ; $7212
	INCBIN "data/bank_00b/d_7213.bin" ; $7213, 10 bytes
Label_0b_721d:
	xor a, a ; $721d
	ret ; $721e
Label_0b_721f:
	ld a, [$c4b2] ; $721f
	cp a, $01 ; $7222
	ld a, $00 ; $7224
	ret nz ; $7226
	ld a, $57 ; $7227
	ld b, $00 ; $7229
	call QueueDrillResultMessage ; $722b
	call RecordDrillTargetZoneHit ; $722e
	call CheckDrillTargetZoneMissed ; $7231
	or a, a ; $7234
	jp nz, Label_0b_7248 ; $7235
	ld a, $5a ; $7238
	ld b, $00 ; $723a
	call QueueDrillResultMessage ; $723c
	ld hl, $c2ea ; $723f
	inc [hl] ; $7242
	jp Label_0b_7250 ; $7243
Label_0b_7246:
	xor a, a ; $7246
	ret ; $7247
Label_0b_7248:
	ld a, $01 ; $7248
	ld [wMatchAbortFlag], a ; $724a
	ld a, $01 ; $724d
	ret ; $724f
Label_0b_7250:
	ld a, $01 ; $7250
	ld [wMatchAbortFlag], a ; $7252
	ld a, $ff ; $7255
	ret ; $7257
RunDoublesDrillMatch:
	xor a, a ; $7258
	ld [$c8f5], a ; $7259
	ld a, $08 ; $725c
	ld [wGameMode], a ; $725e
	ld a, $02 ; $7261
	ld [wCurrentMinigameStoryMatch], a ; $7263
	ld a, $24 ; $7266
	ld [$c8f7], a ; $7268
	ld a, $15 ; $726b
	ld [wMatchBGM], a ; $726d
	ld a, $01 ; $7270
	ld [wMatchIsDoubles], a ; $7272
	ld a, $03 ; $7275
	ld [wOnCourtCharCount], a ; $7277
	ld a, $17 ; $727a
	ld [wCurrentlyUsedCourt], a ; $727c
	ld b, $1d ; $727f
	ld a, b ; $7281
	ld [wMatchPlayerChar], a ; $7282
	ld c, $00 ; $7285
	farcall FarPtr_02_18 ; $7287
	ld b, $1b ; $728a
	ld a, b ; $728c
	ld [wMatchOpponentChar], a ; $728d
	ld c, $02 ; $7290
	farcall FarPtr_02_18 ; $7292
	ld b, $1e ; $7295
	ld c, $03 ; $7297
	farcall FarPtr_02_18 ; $7299
	ld a, [wMinigameLevel] ; $729c
	add a, a ; $729f
	add a, $e0 ; $72a0
	ld l, a ; $72a2
	adc a, $72 ; $72a3
	sub a, l ; $72a5
	ld h, a ; $72a6
	ld a, [hl+] ; $72a7
	ld h, [hl] ; $72a8
	ld l, a ; $72a9
	ld a, [hl+] ; $72aa
	ld [wMatchTypeNumberOfGames], a ; $72ab
	ld a, [hl+] ; $72ae
	ld [wMatchTypeNumberOfSets], a ; $72af
	push hl ; $72b2
	ld a, [hl+] ; $72b3
	ld [$ca9b], a ; $72b4
	ld a, [hl+] ; $72b7
	ld [$ca9c], a ; $72b8
	ld a, [hl+] ; $72bb
	ld [$ca9d], a ; $72bc
	ld a, [hl+] ; $72bf
	ld [$ca9e], a ; $72c0
	ld a, [hl+] ; $72c3
	ld [wExhibitionModeCPUMainCharacterDifficulty], a ; $72c4
	pop hl ; $72c7
	ld a, [hl+] ; $72c8
	ld [$cadb], a ; $72c9
	ld a, [hl+] ; $72cc
	ld [$cadc], a ; $72cd
	ld a, [hl+] ; $72d0
	ld [$cadd], a ; $72d1
	ld a, [hl+] ; $72d4
	ld [$cade], a ; $72d5
	ld a, [hl+] ; $72d8
	ld [wExhibitionModeCPUPartnerCharacterDifficulty], a ; $72d9
	farcall FarPtr_RunMatch ; $72dc
	ret ; $72df
	; $72e0, 27 bytes (records:2)
	dw $72e6 ; record 0
	dw $72ed ; record 1
	dw $72f4 ; record 2
	dw $0106 ; record 3
	dw $1324 ; record 4
	dw $1e12 ; record 5
	dw $0600 ; record 6
	dw $1403 ; record 7
	dw $0a0f ; record 8
	dw $0164 ; record 9
	dw $0506 ; record 10
	dw $0a0e ; record 11
	dw $b402 ; record 12
	db $03
	ds 3333, $ff ; $72fb, fill
