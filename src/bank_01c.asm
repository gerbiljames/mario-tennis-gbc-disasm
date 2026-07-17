SECTION "ROM Bank $1c", ROMX[$4000], BANK[$1c]

FarPtr_1c_00:
	dw Func_1c_401a ; $4000
FarPtr_CharDataScreen_LoadScreen:
	dw CharDataScreen_LoadScreen ; $4002
FarPtr_1c_04:
	dw Func_1c_44cc ; $4004
FarPtr_CharDataScreen_DrawStats:
	dw CharDataScreen_DrawStats ; $4006
FarPtr_1c_08:
	dw Func_1c_48c9 ; $4008
FarPtr_1c_0a:
	dw Func_1c_48ec ; $400a
FarPtr_BackupCharData:
	dw BackupCharData ; $400c
FarPtr_1c_0e:
	dw Func_1c_731f ; $400e
FarPtr_1c_10:
	dw Func_1c_728b ; $4010
FarPtr_1c_12:
	dw Func_1c_72ec ; $4012
FarPtr_1c_14:
	dw Func_1c_72f5 ; $4014
FarPtr_1c_16:
	dw Func_1c_72fc ; $4016
FarPtr_1c_18:
	dw Func_1c_73f4 ; $4018
Func_1c_401a:
	ldh a, [hWramBank] ; $401a
	push af ; $401c
	wram_bank $06 ; $401d
	push bc ; $4023
	ld a, [$d0b6] ; $4024
	or a, a ; $4027
	jr nz, Label_1c_4038 ; $4028
	test_flag $03, 4 ; $402a
	jr nz, Label_1c_4038 ; $402d
	push bc ; $402f
	ld a, c ; $4030
	farcall FarPtr_HasReachedNextLevelExp ; $4031
	jp nz, Label_1c_40f1 ; $4034
	pop bc ; $4037
Label_1c_4038:
	call ClearFrameTasks ; $4038
	call DisableLCDSafely ; $403b
	xor a, a ; $403e
	ldh [hScrollX], a ; $403f
	ldh [hScrollY], a ; $4041
	ld [wCameraX], a ; $4043
	ld [$c321], a ; $4046
	ld [wCameraY], a ; $4049
	ld [$c323], a ; $404c
	ld a, $90 ; $404f
	ldh [rWY], a ; $4051
	call ClearSpriteQueue ; $4053
	pop bc ; $4056
	call Func_1c_40fb ; $4057
	call Func_1c_4c43 ; $405a
	call Func_1c_41dc ; $405d
	wram_bank $06 ; $4060
	ld a, [$d0b6] ; $4066
	or a, a ; $4069
	jr nz, Label_1c_40af ; $406a
	call EnableLCD ; $406c
	call AdvanceFrame ; $406f
	ld a, $01 ; $4072
	ld hl, $4e54 ; $4074
	call RegisterFrameTask ; $4077
	ld a, $01 ; $407a
	ld hl, $5049 ; $407c
	call RegisterFrameTask ; $407f
	ld c, $10 ; $4082
	call BeginFadeIn ; $4084
	call WaitFadeEnd ; $4087
	ld a, $01 ; $408a
	ld hl, $45fa ; $408c
	call RegisterFrameTask ; $408f
	call Func_1c_4682 ; $4092
	wram_bank $06 ; $4095
	xor a, a ; $409b
	ld [$d028], a ; $409c
	call Func_1c_4dd6 ; $409f
	call Func_1c_495d ; $40a2
	ld a, $01 ; $40a5
	ld hl, $54f2 ; $40a7
	call RegisterFrameTask ; $40aa
	jr Label_1c_40b2 ; $40ad
Label_1c_40af:
	call Func_1c_5572 ; $40af
Label_1c_40b2:
	call Func_1c_509d ; $40b2
	push af ; $40b5
	ld c, $10 ; $40b6
	call BeginFadeOut ; $40b8
	call WaitFadeEnd ; $40bb
	ld hl, wStoryModeNameOfMainCharacter ; $40be
	ld de, $c800 ; $40c1
	ld c, $08 ; $40c4
	call CopyMemoryFast ; $40c6
	ld hl, $4e54 ; $40c9
	call UnregisterFrameTask ; $40cc
	ld hl, $5049 ; $40cf
	call UnregisterFrameTask ; $40d2
	ld hl, $45fa ; $40d5
	call UnregisterFrameTask ; $40d8
	sound $00 ; $40db
	call DisableLCDSafely ; $40dd
	farcall FarPtr_01_0a ; $40e0
	call EnableLCD ; $40e3
	call AdvanceFrame ; $40e6
	pop bc ; $40e9
	pop af ; $40ea
	wram_bank ; $40eb
	ld a, b ; $40ef
	ret ; $40f0
Label_1c_40f1:
	pop bc ; $40f1
	pop bc ; $40f2
	pop af ; $40f3
	wram_bank ; $40f4
	ld a, $ff ; $40f8
	ret ; $40fa
Func_1c_40fb:
	wram_bank $06 ; $40fb
	ld a, c ; $4101
	ld [$cb00], a ; $4102
	xor a, a ; $4105
	ld [$d000], a ; $4106
	ld [$d001], a ; $4109
	ld [$d002], a ; $410c
	ld [$d09f], a ; $410f
	ld a, c ; $4112
	ld [$d145], a ; $4113
	ld [$d146], a ; $4116
	inc a ; $4119
	inc a ; $411a
	ld [$d142], a ; $411b
	ld a, $04 ; $411e
	ld [$d024], a ; $4120
	ld a, $0a ; $4123
	ld [$d026], a ; $4125
	ld a, $03 ; $4128
	ld [$d027], a ; $412a
	ld [$d028], a ; $412d
	ld a, [$d0b6] ; $4130
	or a, a ; $4133
	ret nz ; $4134
	xor a, a ; $4135
	ld [$d003], a ; $4136
	push af ; $4139
	ld hl, wStoryModeNameOfMainCharacter ; $413a
	ld a, [$cb00] ; $413d
	or a, a ; $4140
	jr z, Label_1c_4145 ; $4141
	ld l, $40 ; $4143
Label_1c_4145:
	ld a, l ; $4145
	add a, $18 ; $4146
	ld l, a ; $4148
	ld a, h ; $4149
	adc a, $00 ; $414a
	ld h, a ; $414c
	pop af ; $414d
	ld a, [hl] ; $414e
	ld [$d004], a ; $414f
	push af ; $4152
	ld hl, wStoryModeNameOfMainCharacter ; $4153
	ld a, [$cb00] ; $4156
	or a, a ; $4159
	jr z, Label_1c_415e ; $415a
	ld l, $40 ; $415c
Label_1c_415e:
	ld a, l ; $415e
	add a, $38 ; $415f
	ld l, a ; $4161
	ld a, h ; $4162
	adc a, $00 ; $4163
	ld h, a ; $4165
	pop af ; $4166
	ld a, [hl] ; $4167
	ld [$d005], a ; $4168
	ld [$d00a], a ; $416b
	push af ; $416e
	ld hl, wStoryModeNameOfMainCharacter ; $416f
	ld a, [$cb00] ; $4172
	or a, a ; $4175
	jr z, Label_1c_417a ; $4176
	ld l, $40 ; $4178
Label_1c_417a:
	ld a, l ; $417a
	add a, $39 ; $417b
	ld l, a ; $417d
	ld a, h ; $417e
	adc a, $00 ; $417f
	ld h, a ; $4181
	pop af ; $4182
	ld a, [hl] ; $4183
	ld [$d006], a ; $4184
	ld [$d00b], a ; $4187
	push af ; $418a
	ld hl, wStoryModeNameOfMainCharacter ; $418b
	ld a, [$cb00] ; $418e
	or a, a ; $4191
	jr z, Label_1c_4196 ; $4192
	ld l, $40 ; $4194
Label_1c_4196:
	ld a, l ; $4196
	add a, $3a ; $4197
	ld l, a ; $4199
	ld a, h ; $419a
	adc a, $00 ; $419b
	ld h, a ; $419d
	pop af ; $419e
	ld a, [hl] ; $419f
	ld [$d007], a ; $41a0
	ld [$d00c], a ; $41a3
	push af ; $41a6
	ld hl, wStoryModeNameOfMainCharacter ; $41a7
	ld a, [$cb00] ; $41aa
	or a, a ; $41ad
	jr z, Label_1c_41b2 ; $41ae
	ld l, $40 ; $41b0
Label_1c_41b2:
	ld a, l ; $41b2
	add a, $3b ; $41b3
	ld l, a ; $41b5
	ld a, h ; $41b6
	adc a, $00 ; $41b7
	ld h, a ; $41b9
	pop af ; $41ba
	ld a, [hl] ; $41bb
	ld [$d008], a ; $41bc
	ld [$d00d], a ; $41bf
Label_1c_41c2:
	ld a, [$cb00] ; $41c2
	farcall FarPtr_HasReachedNextLevelExp ; $41c5
	jr nz, Label_1c_41d8 ; $41c8
	ld a, [$cb00] ; $41ca
	ld d, $00 ; $41cd
	farcall FarPtr_LevelUpPlayer ; $41cf
	ld hl, $d003 ; $41d2
	inc [hl] ; $41d5
	jr Label_1c_41c2 ; $41d6
Label_1c_41d8:
	call Func_1c_49eb ; $41d8
	ret ; $41db
Func_1c_41dc:
	call Func_1c_4208 ; $41dc
	call CharDataScreen_DrawStats ; $41df
	call Func_1c_459a ; $41e2
	wram_bank $03 ; $41e5
	ld hl, $d000 ; $41eb
	ld de, $9800 ; $41ee
	ld c, $24 ; $41f1
	call QueueVRAMCopy ; $41f3
	wram_bank $02 ; $41f6
	ld hl, $d000 ; $41fc
	ld de, $b800 ; $41ff
	ld c, $24 ; $4202
	call QueueVRAMCopy ; $4204
	ret ; $4207
Func_1c_4208:
	call CharDataScreen_LoadScreen ; $4208
	wram_bank $01 ; $420b
	ld hl, $682e ; $4211
	ld de, $d3e0 ; $4214
	call DecompressData ; $4217
	ld hl, $d3e0 ; $421a
	ld bc, $0021 ; $421d
	call CopyWram1ToWram3 ; $4220
	wram_bank $01 ; $4223
	ld hl, $6848 ; $4229
	ld de, $d3e0 ; $422c
	call DecompressData ; $422f
	ld hl, $d3e0 ; $4232
	ld bc, $0021 ; $4235
	call CopyWram1ToWram2 ; $4238
	wram_bank $01 ; $423b
	ld hl, $684f ; $4241
	ld de, $d410 ; $4244
	call DecompressData ; $4247
	ld hl, $d410 ; $424a
	ld bc, $0018 ; $424d
	call CopyWram1ToWram3 ; $4250
	wram_bank $01 ; $4253
	ld hl, $686b ; $4259
	ld de, $d410 ; $425c
	call DecompressData ; $425f
	ld hl, $d410 ; $4262
	ld bc, $0018 ; $4265
	call CopyWram1ToWram2 ; $4268
	wram_bank $01 ; $426b
	ld hl, $67fe ; $4271
	ld de, $d3a0 ; $4274
	call DecompressData ; $4277
	ld hl, $d3a0 ; $427a
	ld bc, $0033 ; $427d
	call CopyWram1ToWram3 ; $4280
	wram_bank $01 ; $4283
	ld hl, $6825 ; $4289
	ld de, $d3a0 ; $428c
	call DecompressData ; $428f
	ld hl, $d3a0 ; $4292
	ld bc, $0033 ; $4295
	call CopyWram1ToWram2 ; $4298
	wram_bank $01 ; $429b
	ld hl, $67da ; $42a1
	ld de, $d380 ; $42a4
	call DecompressData ; $42a7
	ld hl, $d380 ; $42aa
	ld bc, $001e ; $42ad
	call CopyWram1ToWram3 ; $42b0
	wram_bank $01 ; $42b3
	ld hl, $67f2 ; $42b9
	ld de, $d380 ; $42bc
	call DecompressData ; $42bf
	ld hl, $d380 ; $42c2
	ld bc, $001e ; $42c5
	call CopyWram1ToWram2 ; $42c8
	ret ; $42cb
CopyWram1ToWram3:
	wram_bank $01 ; $42cc
	ld d, [hl] ; $42d2
	wram_bank $03 ; $42d3
	ld [hl], d ; $42d9
	inc hl ; $42da
	dec bc ; $42db
	ld a, b ; $42dc
	or a, c ; $42dd
	jr nz, CopyWram1ToWram3 ; $42de
	ret ; $42e0
CopyWram1ToWram2:
	wram_bank $01 ; $42e1
	ld d, [hl] ; $42e7
	wram_bank $02 ; $42e8
	ld [hl], d ; $42ee
	inc hl ; $42ef
	dec bc ; $42f0
	ld a, b ; $42f1
	or a, c ; $42f2
	jr nz, CopyWram1ToWram2 ; $42f3
	ret ; $42f5
CharDataScreen_DrawStats:
	wram_bank $06 ; $42f6
	ld a, [$d0b6] ; $42fc
	or a, a ; $42ff
	jr z, Label_1c_4305 ; $4300
	call Func_1c_4c43 ; $4302
Label_1c_4305:
	farcall FarPtr_CharDataScreen_BuildStats ; $4305
	wram_bank $06 ; $4308
	ld a, [$d00e] ; $430e
	ld c, a ; $4311
	ld a, [$d019] ; $4312
	add a, c ; $4315
	push af ; $4316
	ld h, $00 ; $4317
	ld l, a ; $4319
	ld a, $02 ; $431a
	ld de, $d08e ; $431c
	call FormatDecimalNumberUnsigned ; $431f
	ld de, $d251 ; $4322
	call Func_1c_44cc ; $4325
	pop af ; $4328
	ld c, $00 ; $4329
	ld de, $d256 ; $432b
	call Func_1c_4502 ; $432e
	wram_bank $06 ; $4331
	ld a, [$d00f] ; $4337
	ld c, a ; $433a
	ld a, [$d01a] ; $433b
	add a, c ; $433e
	push af ; $433f
	ld h, $00 ; $4340
	ld l, a ; $4342
	ld a, $02 ; $4343
	ld de, $d08e ; $4345
	call FormatDecimalNumberUnsigned ; $4348
	ld de, $d265 ; $434b
	call Func_1c_44cc ; $434e
	pop af ; $4351
	ld c, $01 ; $4352
	ld de, $d26a ; $4354
	call Func_1c_4502 ; $4357
	wram_bank $06 ; $435a
	ld a, [$d010] ; $4360
	ld c, a ; $4363
	ld a, [$d01b] ; $4364
	add a, c ; $4367
	push af ; $4368
	ld h, $00 ; $4369
	ld l, a ; $436b
	ld a, $02 ; $436c
	ld de, $d08e ; $436e
	call FormatDecimalNumberUnsigned ; $4371
	ld de, $d291 ; $4374
	call Func_1c_44cc ; $4377
	pop af ; $437a
	ld c, $00 ; $437b
	ld de, $d296 ; $437d
	call Func_1c_4502 ; $4380
	wram_bank $06 ; $4383
	ld a, [$d011] ; $4389
	ld c, a ; $438c
	ld a, [$d01c] ; $438d
	add a, c ; $4390
	push af ; $4391
	ld h, $00 ; $4392
	ld l, a ; $4394
	ld a, $02 ; $4395
	ld de, $d08e ; $4397
	call FormatDecimalNumberUnsigned ; $439a
	ld de, $d2a5 ; $439d
	call Func_1c_44cc ; $43a0
	pop af ; $43a3
	ld c, $00 ; $43a4
	ld de, $d2aa ; $43a6
	call Func_1c_4502 ; $43a9
	wram_bank $06 ; $43ac
	ld a, [$d012] ; $43b2
	ld c, a ; $43b5
	ld a, [$d01d] ; $43b6
	add a, c ; $43b9
	push af ; $43ba
	ld h, $00 ; $43bb
	ld l, a ; $43bd
	ld a, $02 ; $43be
	ld de, $d08e ; $43c0
	call FormatDecimalNumberUnsigned ; $43c3
	ld de, $d2b9 ; $43c6
	call Func_1c_44cc ; $43c9
	pop af ; $43cc
	ld c, $01 ; $43cd
	ld de, $d2be ; $43cf
	call Func_1c_4502 ; $43d2
	wram_bank $06 ; $43d5
	ld a, [$d013] ; $43db
	ld c, a ; $43de
	ld a, [$d01e] ; $43df
	add a, c ; $43e2
	push af ; $43e3
	ld h, $00 ; $43e4
	ld l, a ; $43e6
	ld a, $02 ; $43e7
	ld de, $d08e ; $43e9
	call FormatDecimalNumberUnsigned ; $43ec
	ld de, $d2e1 ; $43ef
	call Func_1c_44cc ; $43f2
	pop af ; $43f5
	ld c, $00 ; $43f6
	ld de, $d2e6 ; $43f8
	call Func_1c_4502 ; $43fb
	wram_bank $06 ; $43fe
	ld a, [$d014] ; $4404
	ld c, a ; $4407
	ld a, [$d01f] ; $4408
	add a, c ; $440b
	push af ; $440c
	ld h, $00 ; $440d
	ld l, a ; $440f
	ld a, $02 ; $4410
	ld de, $d08e ; $4412
	call FormatDecimalNumberUnsigned ; $4415
	ld de, $d2f5 ; $4418
	call Func_1c_44cc ; $441b
	pop af ; $441e
	ld c, $01 ; $441f
	ld de, $d2fa ; $4421
	call Func_1c_4502 ; $4424
	wram_bank $06 ; $4427
	ld a, [$d015] ; $442d
	ld c, a ; $4430
	ld a, [$d020] ; $4431
	add a, c ; $4434
	push af ; $4435
	ld h, $00 ; $4436
	ld l, a ; $4438
	ld a, $02 ; $4439
	ld de, $d08e ; $443b
	call FormatDecimalNumberUnsigned ; $443e
	ld de, $d321 ; $4441
	call Func_1c_44cc ; $4444
	pop af ; $4447
	ld c, $00 ; $4448
	ld de, $d326 ; $444a
	call Func_1c_4502 ; $444d
	wram_bank $06 ; $4450
	ld a, [$d016] ; $4456
	ld c, a ; $4459
	ld a, [$d021] ; $445a
	add a, c ; $445d
	push af ; $445e
	ld h, $00 ; $445f
	ld l, a ; $4461
	ld a, $02 ; $4462
	ld de, $d08e ; $4464
	call FormatDecimalNumberUnsigned ; $4467
	ld de, $d335 ; $446a
	call Func_1c_44cc ; $446d
	pop af ; $4470
	ld c, $00 ; $4471
	ld de, $d33a ; $4473
	call Func_1c_4502 ; $4476
	wram_bank $06 ; $4479
	ld a, [$d017] ; $447f
	ld c, a ; $4482
	ld a, [$d022] ; $4483
	add a, c ; $4486
	push af ; $4487
	ld h, $00 ; $4488
	ld l, a ; $448a
	ld a, $02 ; $448b
	ld de, $d08e ; $448d
	call FormatDecimalNumberUnsigned ; $4490
	ld de, $d349 ; $4493
	call Func_1c_44cc ; $4496
	pop af ; $4499
	ld c, $00 ; $449a
	ld de, $d34e ; $449c
	call Func_1c_4502 ; $449f
	wram_bank $06 ; $44a2
	ld a, [$d018] ; $44a8
	ld c, a ; $44ab
	ld a, [$d023] ; $44ac
	add a, c ; $44af
	push af ; $44b0
	ld h, $00 ; $44b1
	ld l, a ; $44b3
	ld a, $02 ; $44b4
	ld de, $d08e ; $44b6
	call FormatDecimalNumberUnsigned ; $44b9
	ld de, $d35d ; $44bc
	call Func_1c_44cc ; $44bf
	pop af ; $44c2
	ld c, $01 ; $44c3
	ld de, $d362 ; $44c5
	call Func_1c_4502 ; $44c8
	ret ; $44cb
Func_1c_44cc:
	wram_bank $06 ; $44cc
	ld a, [$d08e] ; $44d2
	ld c, a ; $44d5
	wram_bank $03 ; $44d6
	ld a, c ; $44dc
	ld [de], a ; $44dd
	wram_bank $02 ; $44de
	xor a, a ; $44e4
	ld [de], a ; $44e5
	inc de ; $44e6
	wram_bank $06 ; $44e7
	ld a, [$d08f] ; $44ed
	ld c, a ; $44f0
	wram_bank $03 ; $44f1
	ld a, c ; $44f7
	ld [de], a ; $44f8
	wram_bank $02 ; $44f9
	xor a, a ; $44ff
	ld [de], a ; $4500
	ret ; $4501
Func_1c_4502:
	ld b, a ; $4502
	ld a, c ; $4503
	or a, a ; $4504
	jr nz, Label_1c_4515 ; $4505
	ld a, b ; $4507
	rlca ; $4508
	add a, $58 ; $4509
	ld l, a ; $450b
	adc a, $45 ; $450c
	sub a, l ; $450e
	ld h, a ; $450f
	ld a, [hl+] ; $4510
	ld h, [hl] ; $4511
	ld l, a ; $4512
	jr Label_1c_4521 ; $4513
Label_1c_4515:
	ld a, b ; $4515
	rlca ; $4516
	add a, $6e ; $4517
	ld l, a ; $4519
	adc a, $45 ; $451a
	sub a, l ; $451c
	ld h, a ; $451d
	ld a, [hl+] ; $451e
	ld h, [hl] ; $451f
	ld l, a ; $4520
Label_1c_4521:
	push de ; $4521
	wram_bank $03 ; $4522
	ld a, [hl+] ; $4528
	ld [de], a ; $4529
	inc de ; $452a
	ld a, [hl+] ; $452b
	ld [de], a ; $452c
	inc de ; $452d
	ld a, [hl+] ; $452e
	ld [de], a ; $452f
	inc de ; $4530
	ld a, [hl+] ; $4531
	ld [de], a ; $4532
	inc de ; $4533
	ld a, [hl] ; $4534
	ld [de], a ; $4535
	wram_bank $02 ; $4536
	ld a, b ; $453c
	rlca ; $453d
	add a, $84 ; $453e
	ld l, a ; $4540
	adc a, $45 ; $4541
	sub a, l ; $4543
	ld h, a ; $4544
	ld a, [hl+] ; $4545
	ld h, [hl] ; $4546
	ld l, a ; $4547
	pop de ; $4548
	ld a, [hl+] ; $4549
	ld [de], a ; $454a
	inc de ; $454b
	ld a, [hl+] ; $454c
	ld [de], a ; $454d
	inc de ; $454e
	ld a, [hl+] ; $454f
	ld [de], a ; $4550
	inc de ; $4551
	ld a, [hl+] ; $4552
	ld [de], a ; $4553
	inc de ; $4554
	ld a, [hl] ; $4555
	ld [de], a ; $4556
	ret ; $4557
	; $4558, 66 bytes (records:2)
	dw $64a4 ; record 0
	dw $64a9 ; record 1
	dw $64ae ; record 2
	dw $64b3 ; record 3
	dw $64b8 ; record 4
	dw $64bd ; record 5
	dw $64c2 ; record 6
	dw $64c7 ; record 7
	dw $64cc ; record 8
	dw $64d1 ; record 9
	dw $64d6 ; record 10
	dw $64db ; record 11
	dw $64e0 ; record 12
	dw $64e5 ; record 13
	dw $64ea ; record 14
	dw $64ef ; record 15
	dw $64f4 ; record 16
	dw $64f9 ; record 17
	dw $64fe ; record 18
	dw $6503 ; record 19
	dw $6508 ; record 20
	dw $650d ; record 21
	dw $6512 ; record 22
	dw $6517 ; record 23
	dw $651c ; record 24
	dw $6521 ; record 25
	dw $6526 ; record 26
	dw $652b ; record 27
	dw $6530 ; record 28
	dw $6535 ; record 29
	dw $653a ; record 30
	dw $653f ; record 31
	dw $6544 ; record 32
Func_1c_459a:
	push af ; $459a
	ld hl, wStoryModeNameOfMainCharacter ; $459b
	ld a, [$cb00] ; $459e
	or a, a ; $45a1
	jr z, Label_1c_45a6 ; $45a2
	ld l, $40 ; $45a4
Label_1c_45a6:
	ld a, l ; $45a6
	add a, $0c ; $45a7
	ld l, a ; $45a9
	ld a, h ; $45aa
	adc a, $00 ; $45ab
	ld h, a ; $45ad
	pop af ; $45ae
	ld a, [hl] ; $45af
	ld de, $0401 ; $45b0
	farcall FarPtr_LoadIndexedPaletteThunk ; $45b3
	wram_bank $01 ; $45b6
	push af ; $45bc
	ld hl, wStoryModeNameOfMainCharacter ; $45bd
	ld a, [$cb00] ; $45c0
	or a, a ; $45c3
	jr z, Label_1c_45c8 ; $45c4
	ld l, $40 ; $45c6
Label_1c_45c8:
	ld a, l ; $45c8
	add a, $0b ; $45c9
	ld l, a ; $45cb
	ld a, h ; $45cc
	adc a, $00 ; $45cd
	ld h, a ; $45cf
	pop af ; $45d0
	ld a, [hl] ; $45d1
	ld de, $d000 ; $45d2
	farcall FarPtr_DecompressCharMugshot ; $45d5
	ld hl, $d000 ; $45d8
	ld de, $b200 ; $45db
	ld c, $03 ; $45de
	call QueueVRAMCopy ; $45e0
	ld hl, $d030 ; $45e3
	ld de, $b300 ; $45e6
	ld c, $03 ; $45e9
	call QueueVRAMCopy ; $45eb
	ld hl, $d060 ; $45ee
	ld de, $b400 ; $45f1
	ld c, $03 ; $45f4
	call QueueVRAMCopy ; $45f6
	ret ; $45f9
	push af ; $45fa
	push bc ; $45fb
	push de ; $45fc
	push hl ; $45fd
	ldh a, [hWramBank] ; $45fe
	push af ; $4600
	wram_bank $06 ; $4601
	ld a, [$d002] ; $4607
	or a, a ; $460a
	jp nz, Label_1c_4666 ; $460b
	wram_bank $06 ; $460e
	ld a, [$d000] ; $4614
	inc a ; $4617
	ld [$d000], a ; $4618
	and a, $0f ; $461b
	rlca ; $461d
	push af ; $461e
	add a, $79 ; $461f
	ld l, a ; $4621
	adc a, $56 ; $4622
	sub a, l ; $4624
	ld h, a ; $4625
	ld a, [hl+] ; $4626
	ld h, [hl] ; $4627
	ld l, a ; $4628
	push hl ; $4629
	ld de, $b2e0 ; $462a
	ld c, $02 ; $462d
	call QueueVRAMCopy ; $462f
	pop hl ; $4632
	ld a, $20 ; $4633
	add a, l ; $4635
	ld l, a ; $4636
	jr nc, Label_1c_463a ; $4637
	inc h ; $4639
Label_1c_463a:
	ld de, $b3e0 ; $463a
	ld c, $02 ; $463d
	call QueueVRAMCopy ; $463f
	pop af ; $4642
	add a, $99 ; $4643
	ld l, a ; $4645
	adc a, $56 ; $4646
	sub a, l ; $4648
	ld h, a ; $4649
	ld a, [hl+] ; $464a
	ld h, [hl] ; $464b
	ld l, a ; $464c
	push hl ; $464d
	ld de, $b4e0 ; $464e
	ld c, $02 ; $4651
	call QueueVRAMCopy ; $4653
	pop hl ; $4656
	ld a, $20 ; $4657
	add a, l ; $4659
	ld l, a ; $465a
	jr nc, Label_1c_465e ; $465b
	inc h ; $465d
Label_1c_465e:
	ld de, $b5e0 ; $465e
	ld c, $02 ; $4661
	call QueueVRAMCopy ; $4663
Label_1c_4666:
	wram_bank $06 ; $4666
	ld a, [$d002] ; $466c
	inc a ; $466f
	cp a, $03 ; $4670
	jr nz, Label_1c_4675 ; $4672
	xor a, a ; $4674
Label_1c_4675:
	ld [$d002], a ; $4675
	pop af ; $4678
	wram_bank ; $4679
	pop hl ; $467d
	pop de ; $467e
	pop bc ; $467f
	pop af ; $4680
	ret ; $4681
Func_1c_4682:
	sound $0d ; $4682
	call Func_1c_48c9 ; $4684
	wram_bank $06 ; $4687
Label_1c_468d:
	call AdvanceFrame ; $468d
	ld a, [$d002] ; $4690
	or a, a ; $4693
	jr nz, Label_1c_468d ; $4694
	call Func_1c_48ec ; $4696
	ld hl, $57b6 ; $4699
	ld bc, $d240 ; $469c
	call Func_1c_490f ; $469f
	ld hl, $58cb ; $46a2
	ld bc, $d310 ; $46a5
	call Func_1c_490f ; $46a8
	wram_bank $06 ; $46ab
	ld a, $09 ; $46b1
	ld [$d026], a ; $46b3
	call Func_1c_495d ; $46b6
	call Func_1c_48ec ; $46b9
	ld hl, $571b ; $46bc
	ld bc, $d240 ; $46bf
	call Func_1c_490f ; $46c2
	ld hl, $57a9 ; $46c5
	ld bc, $d280 ; $46c8
	call Func_1c_490f ; $46cb
	ld hl, $581c ; $46ce
	ld bc, $d2d0 ; $46d1
	call Func_1c_490f ; $46d4
	ld hl, $58be ; $46d7
	ld bc, $d310 ; $46da
	call Func_1c_490f ; $46dd
	wram_bank $06 ; $46e0
	ld a, $07 ; $46e6
	ld [$d026], a ; $46e8
	call Func_1c_495d ; $46eb
	call Func_1c_48ec ; $46ee
	ld hl, $570e ; $46f1
	ld bc, $d240 ; $46f4
	call Func_1c_490f ; $46f7
	ld hl, $5794 ; $46fa
	ld bc, $d280 ; $46fd
	call Func_1c_490f ; $4700
	ld hl, $580f ; $4703
	ld bc, $d2d0 ; $4706
	call Func_1c_490f ; $4709
	ld hl, $58a9 ; $470c
	ld bc, $d310 ; $470f
	call Func_1c_490f ; $4712
	wram_bank $06 ; $4715
	ld a, $05 ; $471b
	ld [$d026], a ; $471d
	call Func_1c_495d ; $4720
	call Func_1c_48ec ; $4723
	ld hl, $56f9 ; $4726
	ld bc, $d240 ; $4729
	call Func_1c_490f ; $472c
	ld hl, $5777 ; $472f
	ld bc, $d280 ; $4732
	call Func_1c_490f ; $4735
	ld hl, $57fa ; $4738
	ld bc, $d2d0 ; $473b
	call Func_1c_490f ; $473e
	ld hl, $588c ; $4741
	ld bc, $d310 ; $4744
	call Func_1c_490f ; $4747
	wram_bank $06 ; $474a
	ld a, $03 ; $4750
	ld [$d026], a ; $4752
	call Func_1c_495d ; $4755
	call Func_1c_48ec ; $4758
	ld hl, $56e4 ; $475b
	ld bc, $d240 ; $475e
	call Func_1c_490f ; $4761
	ld hl, $575a ; $4764
	ld bc, $d280 ; $4767
	call Func_1c_490f ; $476a
	ld hl, $57e5 ; $476d
	ld bc, $d2d0 ; $4770
	call Func_1c_490f ; $4773
	ld hl, $586b ; $4776
	ld bc, $d310 ; $4779
	call Func_1c_490f ; $477c
	wram_bank $06 ; $477f
	ld a, $02 ; $4785
	ld [$d026], a ; $4787
	call Func_1c_495d ; $478a
	call Func_1c_48ec ; $478d
	ld hl, $56cf ; $4790
	ld bc, $d240 ; $4793
	call Func_1c_490f ; $4796
	ld hl, $573d ; $4799
	ld bc, $d280 ; $479c
	call Func_1c_490f ; $479f
	ld hl, $57d0 ; $47a2
	ld bc, $d2d0 ; $47a5
	call Func_1c_490f ; $47a8
	ld hl, $5846 ; $47ab
	ld bc, $d310 ; $47ae
	call Func_1c_490f ; $47b1
	wram_bank $06 ; $47b4
	ld a, $01 ; $47ba
	ld [$d026], a ; $47bc
	call Func_1c_495d ; $47bf
	call Func_1c_48ec ; $47c2
	ld hl, $56b9 ; $47c5
	ld bc, $d240 ; $47c8
	call Func_1c_490f ; $47cb
	ld hl, $5720 ; $47ce
	ld bc, $d280 ; $47d1
	call Func_1c_490f ; $47d4
	ld hl, $57bb ; $47d7
	ld bc, $d2d0 ; $47da
	call Func_1c_490f ; $47dd
	ld hl, $5821 ; $47e0
	ld bc, $d310 ; $47e3
	call Func_1c_490f ; $47e6
	wram_bank $06 ; $47e9
	ld hl, $d142 ; $47ef
	dec [hl] ; $47f2
	xor a, a ; $47f3
	ld [$d026], a ; $47f4
	call Func_1c_495d ; $47f7
	call WaitFramesCmd ; $47fa
	db $06 ; $47fd inline arg
	ld hl, $58ea ; $47fe
	ld bc, $d370 ; $4801
	call Func_1c_490f ; $4804
	call Func_1c_495d ; $4807
	ld hl, $58dd ; $480a
	ld bc, $d370 ; $480d
	call Func_1c_490f ; $4810
	call Func_1c_495d ; $4813
	ld hl, $58d0 ; $4816
	ld bc, $d370 ; $4819
	call Func_1c_490f ; $481c
	call Func_1c_495d ; $481f
	ld hl, $590d ; $4822
	ld bc, $d3a0 ; $4825
	call Func_1c_490f ; $4828
	ld hl, $5928 ; $482b
	ld bc, $d380 ; $482e
	call Func_1c_490f ; $4831
	wram_bank $06 ; $4834
	ld a, $02 ; $483a
	ld [$d027], a ; $483c
	call Func_1c_495d ; $483f
	ld hl, $5904 ; $4842
	ld bc, $d3a0 ; $4845
	call Func_1c_490f ; $4848
	ld hl, $591f ; $484b
	ld bc, $d380 ; $484e
	call Func_1c_490f ; $4851
	wram_bank $06 ; $4854
	ld a, $01 ; $485a
	ld [$d027], a ; $485c
	call Func_1c_495d ; $485f
	ld hl, $58f7 ; $4862
	ld bc, $d3a0 ; $4865
	call Func_1c_490f ; $4868
	ld hl, $5912 ; $486b
	ld bc, $d380 ; $486e
	call Func_1c_490f ; $4871
	wram_bank $06 ; $4874
	xor a, a ; $487a
	ld [$d027], a ; $487b
	call Func_1c_495d ; $487e
	ret ; $4881
Func_1c_4882:
	call Func_1c_489b ; $4882
	ld hl, $58f7 ; $4885
	ld bc, $d3a0 ; $4888
	call Func_1c_490f ; $488b
	ld hl, $5912 ; $488e
	ld bc, $d380 ; $4891
	call Func_1c_490f ; $4894
	call Func_1c_495d ; $4897
	ret ; $489a
Func_1c_489b:
	ld hl, $56b9 ; $489b
	ld bc, $d240 ; $489e
	call Func_1c_490f ; $48a1
	ld hl, $5720 ; $48a4
	ld bc, $d280 ; $48a7
	call Func_1c_490f ; $48aa
	ld hl, $57bb ; $48ad
	ld bc, $d2d0 ; $48b0
	call Func_1c_490f ; $48b3
	ld hl, $5821 ; $48b6
	ld bc, $d310 ; $48b9
	call Func_1c_490f ; $48bc
	ld hl, $58d0 ; $48bf
	ld bc, $d370 ; $48c2
	call Func_1c_490f ; $48c5
	ret ; $48c8
Func_1c_48c9:
	wram_bank $03 ; $48c9
	ld hl, $d000 ; $48cf
	ld de, $d430 ; $48d2
	ld c, $24 ; $48d5
	call CopyMemoryFast ; $48d7
	wram_bank $02 ; $48da
	ld hl, $d000 ; $48e0
	ld de, $d430 ; $48e3
	ld c, $24 ; $48e6
	call CopyMemoryFast ; $48e8
	ret ; $48eb
Func_1c_48ec:
	wram_bank $03 ; $48ec
	ld hl, $d430 ; $48f2
	ld de, $d000 ; $48f5
	ld c, $24 ; $48f8
	call CopyMemoryFast ; $48fa
	wram_bank $02 ; $48fd
	ld hl, $d430 ; $4903
	ld de, $d000 ; $4906
	ld c, $24 ; $4909
	call CopyMemoryFast ; $490b
	ret ; $490e
Func_1c_490f:
	ld a, [hl] ; $490f
	cp a, $ff ; $4910
	ret z ; $4912
	push hl ; $4913
	ld d, [hl] ; $4914
	inc hl ; $4915
	ld e, [hl] ; $4916
	push hl ; $4917
	ld hl, $d000 ; $4918
	add hl, de ; $491b
	ld d, h ; $491c
	ld e, l ; $491d
	pop hl ; $491e
	inc hl ; $491f
	push hl ; $4920
	ld a, [hl] ; $4921
	ld h, b ; $4922
	ld l, c ; $4923
	add a, l ; $4924
	ld l, a ; $4925
	jr nc, Label_1c_4929 ; $4926
	inc h ; $4928
Label_1c_4929:
	wram_bank $06 ; $4929
	ld a, l ; $492f
	ld [$d08e], a ; $4930
	ld a, h ; $4933
	ld [$d08f], a ; $4934
	pop hl ; $4937
	push bc ; $4938
	inc hl ; $4939
	ld c, [hl] ; $493a
	ld hl, $d08e ; $493b
	ld a, [hl+] ; $493e
	ld h, [hl] ; $493f
	ld l, a ; $4940
Label_1c_4941:
	wram_bank $03 ; $4941
	ld a, [hl] ; $4947
	ld [de], a ; $4948
	wram_bank $02 ; $4949
	ld a, [hl+] ; $494f
	ld [de], a ; $4950
	inc de ; $4951
	dec c ; $4952
	jr nz, Label_1c_4941 ; $4953
	pop bc ; $4955
	pop hl ; $4956
	inc hl ; $4957
	inc hl ; $4958
	inc hl ; $4959
	inc hl ; $495a
	jr Func_1c_490f ; $495b
Func_1c_495d:
	call Func_1c_4967 ; $495d
	call Func_1c_4967 ; $4960
	call Func_1c_4967 ; $4963
	ret ; $4966
Func_1c_4967:
	wram_bank $06 ; $4967
	ld a, [$d002] ; $496d
	inc a ; $4970
	dec a ; $4971
	jr z, Label_1c_4979 ; $4972
	dec a ; $4974
	jr z, Label_1c_499f ; $4975
	jr Label_1c_49c5 ; $4977
Label_1c_4979:
	wram_bank $03 ; $4979
	ld hl, $d1e0 ; $497f
	ld de, $99e0 ; $4982
	ld c, $06 ; $4985
	call QueueVRAMCopy ; $4987
	wram_bank $02 ; $498a
	ld hl, $d1e0 ; $4990
	ld de, $b9e0 ; $4993
	ld c, $06 ; $4996
	call QueueVRAMCopy ; $4998
	call AdvanceFrame ; $499b
	ret ; $499e
Label_1c_499f:
	wram_bank $03 ; $499f
	ld hl, $d0e0 ; $49a5
	ld de, $98e0 ; $49a8
	ld c, $10 ; $49ab
	call QueueVRAMCopy ; $49ad
	wram_bank $02 ; $49b0
	ld hl, $d0e0 ; $49b6
	ld de, $b8e0 ; $49b9
	ld c, $10 ; $49bc
	call QueueVRAMCopy ; $49be
	call AdvanceFrame ; $49c1
	ret ; $49c4
Label_1c_49c5:
	wram_bank $03 ; $49c5
	ld hl, $d000 ; $49cb
	ld de, $9800 ; $49ce
	ld c, $0e ; $49d1
	call QueueVRAMCopy ; $49d3
	wram_bank $02 ; $49d6
	ld hl, $d000 ; $49dc
	ld de, $b800 ; $49df
	ld c, $0e ; $49e2
	call QueueVRAMCopy ; $49e4
	call AdvanceFrame ; $49e7
	ret ; $49ea
Func_1c_49eb:
	wram_bank $06 ; $49eb
	ld a, [$d003] ; $49f1
	ld [$d009], a ; $49f4
	push af ; $49f7
	ld hl, wStoryModeNameOfMainCharacter ; $49f8
	ld a, [$cb00] ; $49fb
	or a, a ; $49fe
	jr z, Label_1c_4a03 ; $49ff
	ld l, $40 ; $4a01
Label_1c_4a03:
	ld a, l ; $4a03
	add a, $18 ; $4a04
	ld l, a ; $4a06
	ld a, h ; $4a07
	adc a, $00 ; $4a08
	ld h, a ; $4a0a
	pop af ; $4a0b
	ld a, [$d004] ; $4a0c
	ld [hl], a ; $4a0f
	push af ; $4a10
	ld hl, wStoryModeNameOfMainCharacter ; $4a11
	ld a, [$cb00] ; $4a14
	or a, a ; $4a17
	jr z, Label_1c_4a1c ; $4a18
	ld l, $40 ; $4a1a
Label_1c_4a1c:
	ld a, l ; $4a1c
	add a, $38 ; $4a1d
	ld l, a ; $4a1f
	ld a, h ; $4a20
	adc a, $00 ; $4a21
	ld h, a ; $4a23
	pop af ; $4a24
	ld a, [$d005] ; $4a25
	ld [hl], a ; $4a28
	ld [$d00a], a ; $4a29
	push af ; $4a2c
	ld hl, wStoryModeNameOfMainCharacter ; $4a2d
	ld a, [$cb00] ; $4a30
	or a, a ; $4a33
	jr z, Label_1c_4a38 ; $4a34
	ld l, $40 ; $4a36
Label_1c_4a38:
	ld a, l ; $4a38
	add a, $39 ; $4a39
	ld l, a ; $4a3b
	ld a, h ; $4a3c
	adc a, $00 ; $4a3d
	ld h, a ; $4a3f
	pop af ; $4a40
	ld a, [$d006] ; $4a41
	ld [hl], a ; $4a44
	ld [$d00b], a ; $4a45
	push af ; $4a48
	ld hl, wStoryModeNameOfMainCharacter ; $4a49
	ld a, [$cb00] ; $4a4c
	or a, a ; $4a4f
	jr z, Label_1c_4a54 ; $4a50
	ld l, $40 ; $4a52
Label_1c_4a54:
	ld a, l ; $4a54
	add a, $3a ; $4a55
	ld l, a ; $4a57
	ld a, h ; $4a58
	adc a, $00 ; $4a59
	ld h, a ; $4a5b
	pop af ; $4a5c
	ld a, [$d007] ; $4a5d
	ld [hl], a ; $4a60
	ld [$d00c], a ; $4a61
	push af ; $4a64
	ld hl, wStoryModeNameOfMainCharacter ; $4a65
	ld a, [$cb00] ; $4a68
	or a, a ; $4a6b
	jr z, Label_1c_4a70 ; $4a6c
	ld l, $40 ; $4a6e
Label_1c_4a70:
	ld a, l ; $4a70
	add a, $3b ; $4a71
	ld l, a ; $4a73
	ld a, h ; $4a74
	adc a, $00 ; $4a75
	ld h, a ; $4a77
	pop af ; $4a78
	ld a, [$d008] ; $4a79
	ld [hl], a ; $4a7c
	ld [$d00d], a ; $4a7d
	xor a, a ; $4a80
	ld b, $64 ; $4a81
	ld hl, $d02a ; $4a83
Label_1c_4a86:
	ld [hl+], a ; $4a86
	dec b ; $4a87
	jr nz, Label_1c_4a86 ; $4a88
	ld [$d029], a ; $4a8a
	ld a, [$cb00] ; $4a8d
	farcall FarPtr_RefreshPlayerStatsAndGetPtr ; $4a90
	ret ; $4a93
Func_1c_4a94:
	wram_bank $06 ; $4a94
	ld a, [$d0b6] ; $4a9a
	or a, a ; $4a9d
	ret nz ; $4a9e
	push af ; $4a9f
	ld hl, wStoryModeNameOfMainCharacter ; $4aa0
	ld a, [$cb00] ; $4aa3
	or a, a ; $4aa6
	jr z, Label_1c_4aab ; $4aa7
	ld l, $40 ; $4aa9
Label_1c_4aab:
	ld a, l ; $4aab
	add a, $38 ; $4aac
	ld l, a ; $4aae
	ld a, h ; $4aaf
	adc a, $00 ; $4ab0
	ld h, a ; $4ab2
	pop af ; $4ab3
	ld a, [hl] ; $4ab4
	ld [$d00a], a ; $4ab5
	push af ; $4ab8
	ld hl, wStoryModeNameOfMainCharacter ; $4ab9
	ld a, [$cb00] ; $4abc
	or a, a ; $4abf
	jr z, Label_1c_4ac4 ; $4ac0
	ld l, $40 ; $4ac2
Label_1c_4ac4:
	ld a, l ; $4ac4
	add a, $20 ; $4ac5
	ld l, a ; $4ac7
	ld a, h ; $4ac8
	adc a, $00 ; $4ac9
	ld h, a ; $4acb
	pop af ; $4acc
	ld a, [hl] ; $4acd
	inc a ; $4ace
	ld [$d00e], a ; $4acf
	push af ; $4ad2
	ld hl, wStoryModeNameOfMainCharacter ; $4ad3
	ld a, [$cb00] ; $4ad6
	or a, a ; $4ad9
	jr z, Label_1c_4ade ; $4ada
	ld l, $40 ; $4adc
Label_1c_4ade:
	ld a, l ; $4ade
	add a, $21 ; $4adf
	ld l, a ; $4ae1
	ld a, h ; $4ae2
	adc a, $00 ; $4ae3
	ld h, a ; $4ae5
	pop af ; $4ae6
	ld a, [hl] ; $4ae7
	inc a ; $4ae8
	ld [$d00f], a ; $4ae9
	push af ; $4aec
	ld hl, wStoryModeNameOfMainCharacter ; $4aed
	ld a, [$cb00] ; $4af0
	or a, a ; $4af3
	jr z, Label_1c_4af8 ; $4af4
	ld l, $40 ; $4af6
Label_1c_4af8:
	ld a, l ; $4af8
	add a, $39 ; $4af9
	ld l, a ; $4afb
	ld a, h ; $4afc
	adc a, $00 ; $4afd
	ld h, a ; $4aff
	pop af ; $4b00
	ld a, [hl] ; $4b01
	ld [$d00b], a ; $4b02
	push af ; $4b05
	ld hl, wStoryModeNameOfMainCharacter ; $4b06
	ld a, [$cb00] ; $4b09
	or a, a ; $4b0c
	jr z, Label_1c_4b11 ; $4b0d
	ld l, $40 ; $4b0f
Label_1c_4b11:
	ld a, l ; $4b11
	add a, $22 ; $4b12
	ld l, a ; $4b14
	ld a, h ; $4b15
	adc a, $00 ; $4b16
	ld h, a ; $4b18
	pop af ; $4b19
	ld a, [hl] ; $4b1a
	inc a ; $4b1b
	ld [$d010], a ; $4b1c
	push af ; $4b1f
	ld hl, wStoryModeNameOfMainCharacter ; $4b20
	ld a, [$cb00] ; $4b23
	or a, a ; $4b26
	jr z, Label_1c_4b2b ; $4b27
	ld l, $40 ; $4b29
Label_1c_4b2b:
	ld a, l ; $4b2b
	add a, $23 ; $4b2c
	ld l, a ; $4b2e
	ld a, h ; $4b2f
	adc a, $00 ; $4b30
	ld h, a ; $4b32
	pop af ; $4b33
	ld a, [hl] ; $4b34
	inc a ; $4b35
	ld [$d011], a ; $4b36
	push af ; $4b39
	ld hl, wStoryModeNameOfMainCharacter ; $4b3a
	ld a, [$cb00] ; $4b3d
	or a, a ; $4b40
	jr z, Label_1c_4b45 ; $4b41
	ld l, $40 ; $4b43
Label_1c_4b45:
	ld a, l ; $4b45
	add a, $24 ; $4b46
	ld l, a ; $4b48
	ld a, h ; $4b49
	adc a, $00 ; $4b4a
	ld h, a ; $4b4c
	pop af ; $4b4d
	ld a, [hl] ; $4b4e
	inc a ; $4b4f
	ld [$d012], a ; $4b50
	push af ; $4b53
	ld hl, wStoryModeNameOfMainCharacter ; $4b54
	ld a, [$cb00] ; $4b57
	or a, a ; $4b5a
	jr z, Label_1c_4b5f ; $4b5b
	ld l, $40 ; $4b5d
Label_1c_4b5f:
	ld a, l ; $4b5f
	add a, $3a ; $4b60
	ld l, a ; $4b62
	ld a, h ; $4b63
	adc a, $00 ; $4b64
	ld h, a ; $4b66
	pop af ; $4b67
	ld a, [hl] ; $4b68
	ld [$d00c], a ; $4b69
	push af ; $4b6c
	ld hl, wStoryModeNameOfMainCharacter ; $4b6d
	ld a, [$cb00] ; $4b70
	or a, a ; $4b73
	jr z, Label_1c_4b78 ; $4b74
	ld l, $40 ; $4b76
Label_1c_4b78:
	ld a, l ; $4b78
	add a, $25 ; $4b79
	ld l, a ; $4b7b
	ld a, h ; $4b7c
	adc a, $00 ; $4b7d
	ld h, a ; $4b7f
	pop af ; $4b80
	ld a, [hl] ; $4b81
	inc a ; $4b82
	ld [$d013], a ; $4b83
	push af ; $4b86
	ld hl, wStoryModeNameOfMainCharacter ; $4b87
	ld a, [$cb00] ; $4b8a
	or a, a ; $4b8d
	jr z, Label_1c_4b92 ; $4b8e
	ld l, $40 ; $4b90
Label_1c_4b92:
	ld a, l ; $4b92
	add a, $26 ; $4b93
	ld l, a ; $4b95
	ld a, h ; $4b96
	adc a, $00 ; $4b97
	ld h, a ; $4b99
	pop af ; $4b9a
	ld a, [hl] ; $4b9b
	inc a ; $4b9c
	ld [$d014], a ; $4b9d
	push af ; $4ba0
	ld hl, wStoryModeNameOfMainCharacter ; $4ba1
	ld a, [$cb00] ; $4ba4
	or a, a ; $4ba7
	jr z, Label_1c_4bac ; $4ba8
	ld l, $40 ; $4baa
Label_1c_4bac:
	ld a, l ; $4bac
	add a, $3b ; $4bad
	ld l, a ; $4baf
	ld a, h ; $4bb0
	adc a, $00 ; $4bb1
	ld h, a ; $4bb3
	pop af ; $4bb4
	ld a, [hl] ; $4bb5
	ld [$d00d], a ; $4bb6
	push af ; $4bb9
	ld hl, wStoryModeNameOfMainCharacter ; $4bba
	ld a, [$cb00] ; $4bbd
	or a, a ; $4bc0
	jr z, Label_1c_4bc5 ; $4bc1
	ld l, $40 ; $4bc3
Label_1c_4bc5:
	ld a, l ; $4bc5
	add a, $27 ; $4bc6
	ld l, a ; $4bc8
	ld a, h ; $4bc9
	adc a, $00 ; $4bca
	ld h, a ; $4bcc
	pop af ; $4bcd
	ld a, [hl] ; $4bce
	inc a ; $4bcf
	ld [$d015], a ; $4bd0
	push af ; $4bd3
	ld hl, wStoryModeNameOfMainCharacter ; $4bd4
	ld a, [$cb00] ; $4bd7
	or a, a ; $4bda
	jr z, Label_1c_4bdf ; $4bdb
	ld l, $40 ; $4bdd
Label_1c_4bdf:
	ld a, l ; $4bdf
	add a, $28 ; $4be0
	ld l, a ; $4be2
	ld a, h ; $4be3
	adc a, $00 ; $4be4
	ld h, a ; $4be6
	pop af ; $4be7
	ld a, [hl] ; $4be8
	inc a ; $4be9
	ld [$d016], a ; $4bea
	push af ; $4bed
	ld hl, wStoryModeNameOfMainCharacter ; $4bee
	ld a, [$cb00] ; $4bf1
	or a, a ; $4bf4
	jr z, Label_1c_4bf9 ; $4bf5
	ld l, $40 ; $4bf7
Label_1c_4bf9:
	ld a, l ; $4bf9
	add a, $29 ; $4bfa
	ld l, a ; $4bfc
	ld a, h ; $4bfd
	adc a, $00 ; $4bfe
	ld h, a ; $4c00
	pop af ; $4c01
	ld a, [hl] ; $4c02
	inc a ; $4c03
	ld [$d017], a ; $4c04
	push af ; $4c07
	ld hl, wStoryModeNameOfMainCharacter ; $4c08
	ld a, [$cb00] ; $4c0b
	or a, a ; $4c0e
	jr z, Label_1c_4c13 ; $4c0f
	ld l, $40 ; $4c11
Label_1c_4c13:
	ld a, l ; $4c13
	add a, $2a ; $4c14
	ld l, a ; $4c16
	ld a, h ; $4c17
	adc a, $00 ; $4c18
	ld h, a ; $4c1a
	pop af ; $4c1b
	ld a, [hl] ; $4c1c
	inc a ; $4c1d
	ld [$d018], a ; $4c1e
	ld a, [$d024] ; $4c21
	cp a, $04 ; $4c24
	jr z, Label_1c_4c33 ; $4c26
	ld d, a ; $4c28
	ld hl, $d019 ; $4c29
	ld a, [$cb00] ; $4c2c
	farcall FarPtr_02_0c ; $4c2f
	ret ; $4c32
Label_1c_4c33:
	xor a, a ; $4c33
	ld hl, $d019 ; $4c34
	ld [hl+], a ; $4c37
	ld [hl+], a ; $4c38
	ld [hl+], a ; $4c39
	ld [hl+], a ; $4c3a
	ld [hl+], a ; $4c3b
	ld [hl+], a ; $4c3c
	ld [hl+], a ; $4c3d
	ld [hl+], a ; $4c3e
	ld [hl+], a ; $4c3f
	ld [hl+], a ; $4c40
	ld [hl+], a ; $4c41
	ret ; $4c42
Func_1c_4c43:
	wram_bank $06 ; $4c43
	push af ; $4c49
	ld hl, wStoryModeNameOfMainCharacter ; $4c4a
	ld a, [$cb00] ; $4c4d
	or a, a ; $4c50
	jr z, Label_1c_4c55 ; $4c51
	ld l, $40 ; $4c53
Label_1c_4c55:
	ld a, l ; $4c55
	add a, $38 ; $4c56
	ld l, a ; $4c58
	ld a, h ; $4c59
	adc a, $00 ; $4c5a
	ld h, a ; $4c5c
	pop af ; $4c5d
	ld a, [hl] ; $4c5e
	ld [$d00a], a ; $4c5f
	push af ; $4c62
	ld hl, wStoryModeNameOfMainCharacter ; $4c63
	ld a, [$cb00] ; $4c66
	or a, a ; $4c69
	jr z, Label_1c_4c6e ; $4c6a
	ld l, $40 ; $4c6c
Label_1c_4c6e:
	ld a, l ; $4c6e
	add a, $20 ; $4c6f
	ld l, a ; $4c71
	ld a, h ; $4c72
	adc a, $00 ; $4c73
	ld h, a ; $4c75
	pop af ; $4c76
	ld a, [hl] ; $4c77
	inc a ; $4c78
	ld [$d00e], a ; $4c79
	push af ; $4c7c
	ld hl, wStoryModeNameOfMainCharacter ; $4c7d
	ld a, [$cb00] ; $4c80
	or a, a ; $4c83
	jr z, Label_1c_4c88 ; $4c84
	ld l, $40 ; $4c86
Label_1c_4c88:
	ld a, l ; $4c88
	add a, $21 ; $4c89
	ld l, a ; $4c8b
	ld a, h ; $4c8c
	adc a, $00 ; $4c8d
	ld h, a ; $4c8f
	pop af ; $4c90
	ld a, [hl] ; $4c91
	inc a ; $4c92
	ld [$d00f], a ; $4c93
	push af ; $4c96
	ld hl, wStoryModeNameOfMainCharacter ; $4c97
	ld a, [$cb00] ; $4c9a
	or a, a ; $4c9d
	jr z, Label_1c_4ca2 ; $4c9e
	ld l, $40 ; $4ca0
Label_1c_4ca2:
	ld a, l ; $4ca2
	add a, $39 ; $4ca3
	ld l, a ; $4ca5
	ld a, h ; $4ca6
	adc a, $00 ; $4ca7
	ld h, a ; $4ca9
	pop af ; $4caa
	ld a, [hl] ; $4cab
	ld [$d00b], a ; $4cac
	push af ; $4caf
	ld hl, wStoryModeNameOfMainCharacter ; $4cb0
	ld a, [$cb00] ; $4cb3
	or a, a ; $4cb6
	jr z, Label_1c_4cbb ; $4cb7
	ld l, $40 ; $4cb9
Label_1c_4cbb:
	ld a, l ; $4cbb
	add a, $22 ; $4cbc
	ld l, a ; $4cbe
	ld a, h ; $4cbf
	adc a, $00 ; $4cc0
	ld h, a ; $4cc2
	pop af ; $4cc3
	ld a, [hl] ; $4cc4
	inc a ; $4cc5
	ld [$d010], a ; $4cc6
	push af ; $4cc9
	ld hl, wStoryModeNameOfMainCharacter ; $4cca
	ld a, [$cb00] ; $4ccd
	or a, a ; $4cd0
	jr z, Label_1c_4cd5 ; $4cd1
	ld l, $40 ; $4cd3
Label_1c_4cd5:
	ld a, l ; $4cd5
	add a, $23 ; $4cd6
	ld l, a ; $4cd8
	ld a, h ; $4cd9
	adc a, $00 ; $4cda
	ld h, a ; $4cdc
	pop af ; $4cdd
	ld a, [hl] ; $4cde
	inc a ; $4cdf
	ld [$d011], a ; $4ce0
	push af ; $4ce3
	ld hl, wStoryModeNameOfMainCharacter ; $4ce4
	ld a, [$cb00] ; $4ce7
	or a, a ; $4cea
	jr z, Label_1c_4cef ; $4ceb
	ld l, $40 ; $4ced
Label_1c_4cef:
	ld a, l ; $4cef
	add a, $24 ; $4cf0
	ld l, a ; $4cf2
	ld a, h ; $4cf3
	adc a, $00 ; $4cf4
	ld h, a ; $4cf6
	pop af ; $4cf7
	ld a, [hl] ; $4cf8
	inc a ; $4cf9
	ld [$d012], a ; $4cfa
	push af ; $4cfd
	ld hl, wStoryModeNameOfMainCharacter ; $4cfe
	ld a, [$cb00] ; $4d01
	or a, a ; $4d04
	jr z, Label_1c_4d09 ; $4d05
	ld l, $40 ; $4d07
Label_1c_4d09:
	ld a, l ; $4d09
	add a, $3a ; $4d0a
	ld l, a ; $4d0c
	ld a, h ; $4d0d
	adc a, $00 ; $4d0e
	ld h, a ; $4d10
	pop af ; $4d11
	ld a, [hl] ; $4d12
	ld [$d00c], a ; $4d13
	push af ; $4d16
	ld hl, wStoryModeNameOfMainCharacter ; $4d17
	ld a, [$cb00] ; $4d1a
	or a, a ; $4d1d
	jr z, Label_1c_4d22 ; $4d1e
	ld l, $40 ; $4d20
Label_1c_4d22:
	ld a, l ; $4d22
	add a, $25 ; $4d23
	ld l, a ; $4d25
	ld a, h ; $4d26
	adc a, $00 ; $4d27
	ld h, a ; $4d29
	pop af ; $4d2a
	ld a, [hl] ; $4d2b
	inc a ; $4d2c
	ld [$d013], a ; $4d2d
	push af ; $4d30
	ld hl, wStoryModeNameOfMainCharacter ; $4d31
	ld a, [$cb00] ; $4d34
	or a, a ; $4d37
	jr z, Label_1c_4d3c ; $4d38
	ld l, $40 ; $4d3a
Label_1c_4d3c:
	ld a, l ; $4d3c
	add a, $26 ; $4d3d
	ld l, a ; $4d3f
	ld a, h ; $4d40
	adc a, $00 ; $4d41
	ld h, a ; $4d43
	pop af ; $4d44
	ld a, [hl] ; $4d45
	inc a ; $4d46
	ld [$d014], a ; $4d47
	push af ; $4d4a
	ld hl, wStoryModeNameOfMainCharacter ; $4d4b
	ld a, [$cb00] ; $4d4e
	or a, a ; $4d51
	jr z, Label_1c_4d56 ; $4d52
	ld l, $40 ; $4d54
Label_1c_4d56:
	ld a, l ; $4d56
	add a, $3b ; $4d57
	ld l, a ; $4d59
	ld a, h ; $4d5a
	adc a, $00 ; $4d5b
	ld h, a ; $4d5d
	pop af ; $4d5e
	ld a, [hl] ; $4d5f
	ld [$d00d], a ; $4d60
	push af ; $4d63
	ld hl, wStoryModeNameOfMainCharacter ; $4d64
	ld a, [$cb00] ; $4d67
	or a, a ; $4d6a
	jr z, Label_1c_4d6f ; $4d6b
	ld l, $40 ; $4d6d
Label_1c_4d6f:
	ld a, l ; $4d6f
	add a, $27 ; $4d70
	ld l, a ; $4d72
	ld a, h ; $4d73
	adc a, $00 ; $4d74
	ld h, a ; $4d76
	pop af ; $4d77
	ld a, [hl] ; $4d78
	inc a ; $4d79
	ld [$d015], a ; $4d7a
	push af ; $4d7d
	ld hl, wStoryModeNameOfMainCharacter ; $4d7e
	ld a, [$cb00] ; $4d81
	or a, a ; $4d84
	jr z, Label_1c_4d89 ; $4d85
	ld l, $40 ; $4d87
Label_1c_4d89:
	ld a, l ; $4d89
	add a, $28 ; $4d8a
	ld l, a ; $4d8c
	ld a, h ; $4d8d
	adc a, $00 ; $4d8e
	ld h, a ; $4d90
	pop af ; $4d91
	ld a, [hl] ; $4d92
	inc a ; $4d93
	ld [$d016], a ; $4d94
	push af ; $4d97
	ld hl, wStoryModeNameOfMainCharacter ; $4d98
	ld a, [$cb00] ; $4d9b
	or a, a ; $4d9e
	jr z, Label_1c_4da3 ; $4d9f
	ld l, $40 ; $4da1
Label_1c_4da3:
	ld a, l ; $4da3
	add a, $29 ; $4da4
	ld l, a ; $4da6
	ld a, h ; $4da7
	adc a, $00 ; $4da8
	ld h, a ; $4daa
	pop af ; $4dab
	ld a, [hl] ; $4dac
	inc a ; $4dad
	ld [$d017], a ; $4dae
	push af ; $4db1
	ld hl, wStoryModeNameOfMainCharacter ; $4db2
	ld a, [$cb00] ; $4db5
	or a, a ; $4db8
	jr z, Label_1c_4dbd ; $4db9
	ld l, $40 ; $4dbb
Label_1c_4dbd:
	ld a, l ; $4dbd
	add a, $2a ; $4dbe
	ld l, a ; $4dc0
	ld a, h ; $4dc1
	adc a, $00 ; $4dc2
	ld h, a ; $4dc4
	pop af ; $4dc5
	ld a, [hl] ; $4dc6
	inc a ; $4dc7
	ld [$d018], a ; $4dc8
	ld hl, $d019 ; $4dcb
	ld b, $0b ; $4dce
	xor a, a ; $4dd0
Label_1c_4dd1:
	ld [hl+], a ; $4dd1
	dec b ; $4dd2
	jr nz, Label_1c_4dd1 ; $4dd3
	ret ; $4dd5
Func_1c_4dd6:
	wram_bank $06 ; $4dd6
	ld a, [$d024] ; $4ddc
	rlca ; $4ddf
	push af ; $4de0
	rlca ; $4de1
	add a, $36 ; $4de2
	ld l, a ; $4de4
	adc a, $4e ; $4de5
	sub a, l ; $4de7
	ld h, a ; $4de8
	ld a, [hl+] ; $4de9
	ld d, [hl] ; $4dea
	ld e, a ; $4deb
	inc hl ; $4dec
	ld a, [hl+] ; $4ded
	ld b, [hl] ; $4dee
	ld c, a ; $4def
	pop af ; $4df0
	add a, $4a ; $4df1
	ld l, a ; $4df3
	adc a, $4e ; $4df4
	sub a, l ; $4df6
	ld h, a ; $4df7
	ld a, [hl+] ; $4df8
	ld h, [hl] ; $4df9
	ld l, a ; $4dfa
Label_1c_4dfb:
	push bc ; $4dfb
Label_1c_4dfc:
	wram_bank $02 ; $4dfc
	ld a, [hl+] ; $4e02
	ld [de], a ; $4e03
	inc de ; $4e04
	dec b ; $4e05
	jr nz, Label_1c_4dfc ; $4e06
	pop bc ; $4e08
	ld a, c ; $4e09
	and a, $01 ; $4e0a
	jr nz, Label_1c_4e2b ; $4e0c
	wram_bank $06 ; $4e0e
	ld a, [$d024] ; $4e14
	cp a, $04 ; $4e17
	jr z, Label_1c_4e2b ; $4e19
	dec de ; $4e1b
	dec de ; $4e1c
	dec de ; $4e1d
	wram_bank $02 ; $4e1e
	ld a, $01 ; $4e24
	ld [de], a ; $4e26
	inc de ; $4e27
	ld [de], a ; $4e28
	inc de ; $4e29
	inc de ; $4e2a
Label_1c_4e2b:
	ld a, $16 ; $4e2b
	add a, e ; $4e2d
	ld e, a ; $4e2e
	jr nc, Label_1c_4e32 ; $4e2f
	inc d ; $4e31
Label_1c_4e32:
	dec c ; $4e32
	jr nz, Label_1c_4dfb ; $4e33
	ret ; $4e35
	; $4e36, 30 bytes (bytes:4)
	db $60, $d0, $05, $0a ; 0x00
	db $00, $d1, $07, $0a ; 0x04
	db $6a, $d0, $05, $0a ; 0x08
	db $0a, $d1, $09, $0a ; 0x0c
	db $e0, $d1, $03, $0a ; 0x10
	db $96, $65, $22, $66 ; 0x14
	db $ba, $66, $4d, $67 ; 0x18
	db $a7, $67 ; 0x1c
	wram_bank $06 ; $4e54
	ld b, $0e ; $4e5a
	ld a, [$d00a] ; $4e5c
	ld l, a ; $4e5f
	ld a, [$d028] ; $4e60
	or a, a ; $4e63
	jr nz, Label_1c_4e6f ; $4e64
	ld a, [$d024] ; $4e66
	or a, a ; $4e69
	jr nz, Label_1c_4e6f ; $4e6a
	inc l ; $4e6c
	ld b, $0f ; $4e6d
Label_1c_4e6f:
	ld a, l ; $4e6f
	cp a, $0a ; $4e70
	jr c, Label_1c_4ea6 ; $4e72
	push bc ; $4e74
	ld h, $00 ; $4e75
	ld a, $02 ; $4e77
	ld de, $d08e ; $4e79
	call FormatDecimalNumberUnsigned ; $4e7c
	pop bc ; $4e7f
	push bc ; $4e80
	ld a, [$d08e] ; $4e81
	sub a, $30 ; $4e84
	rlca ; $4e86
	ld c, a ; $4e87
	ld de, $051c ; $4e88
	xor a, a ; $4e8b
	call Func_1c_4fce ; $4e8c
	call QueueSprite ; $4e8f
	pop bc ; $4e92
	ld a, [$d08f] ; $4e93
	sub a, $30 ; $4e96
	rlca ; $4e98
	ld c, a ; $4e99
	ld de, $0c1c ; $4e9a
	xor a, a ; $4e9d
	call Func_1c_4fce ; $4e9e
	call QueueSprite ; $4ea1
	jr Label_1c_4eb3 ; $4ea4
Label_1c_4ea6:
	ld a, l ; $4ea6
	rlca ; $4ea7
	ld c, a ; $4ea8
	ld de, $091c ; $4ea9
	xor a, a ; $4eac
	call Func_1c_4fce ; $4ead
	call QueueSprite ; $4eb0
Label_1c_4eb3:
	ld b, $0e ; $4eb3
	ld a, [$d00b] ; $4eb5
	ld l, a ; $4eb8
	ld a, [$d028] ; $4eb9
	or a, a ; $4ebc
	jr nz, Label_1c_4ec9 ; $4ebd
	ld a, [$d024] ; $4ebf
	cp a, $01 ; $4ec2
	jr nz, Label_1c_4ec9 ; $4ec4
	inc l ; $4ec6
	ld b, $0f ; $4ec7
Label_1c_4ec9:
	ld a, l ; $4ec9
	cp a, $0a ; $4eca
	jr c, Label_1c_4f02 ; $4ecc
	push bc ; $4ece
	ld h, $00 ; $4ecf
	ld a, $02 ; $4ed1
	ld de, $d08e ; $4ed3
	call FormatDecimalNumberUnsigned ; $4ed6
	pop bc ; $4ed9
	push bc ; $4eda
	ld a, [$d08e] ; $4edb
	sub a, $30 ; $4ede
	rlca ; $4ee0
	ld c, a ; $4ee1
	ld de, $0544 ; $4ee2
	ld a, $01 ; $4ee5
	call Func_1c_4fce ; $4ee7
	call QueueSprite ; $4eea
	pop bc ; $4eed
	ld a, [$d08f] ; $4eee
	sub a, $30 ; $4ef1
	rlca ; $4ef3
	ld c, a ; $4ef4
	ld de, $0c44 ; $4ef5
	ld a, $01 ; $4ef8
	call Func_1c_4fce ; $4efa
	call QueueSprite ; $4efd
	jr Label_1c_4f10 ; $4f00
Label_1c_4f02:
	ld a, l ; $4f02
	rlca ; $4f03
	ld c, a ; $4f04
	ld de, $0944 ; $4f05
	ld a, $01 ; $4f08
	call Func_1c_4fce ; $4f0a
	call QueueSprite ; $4f0d
Label_1c_4f10:
	ld b, $0e ; $4f10
	ld a, [$d00c] ; $4f12
	ld l, a ; $4f15
	ld a, [$d028] ; $4f16
	or a, a ; $4f19
	jr nz, Label_1c_4f26 ; $4f1a
	ld a, [$d024] ; $4f1c
	cp a, $02 ; $4f1f
	jr nz, Label_1c_4f26 ; $4f21
	inc l ; $4f23
	ld b, $0f ; $4f24
Label_1c_4f26:
	ld a, l ; $4f26
	cp a, $0a ; $4f27
	jr c, Label_1c_4f5f ; $4f29
	push bc ; $4f2b
	ld h, $00 ; $4f2c
	ld a, $02 ; $4f2e
	ld de, $d08e ; $4f30
	call FormatDecimalNumberUnsigned ; $4f33
	pop bc ; $4f36
	push bc ; $4f37
	ld a, [$d08e] ; $4f38
	sub a, $30 ; $4f3b
	rlca ; $4f3d
	ld c, a ; $4f3e
	ld de, $551c ; $4f3f
	ld a, $02 ; $4f42
	call Func_1c_4fce ; $4f44
	call QueueSprite ; $4f47
	pop bc ; $4f4a
	ld a, [$d08f] ; $4f4b
	sub a, $30 ; $4f4e
	rlca ; $4f50
	ld c, a ; $4f51
	ld de, $5c1c ; $4f52
	ld a, $02 ; $4f55
	call Func_1c_4fce ; $4f57
	call QueueSprite ; $4f5a
	jr Label_1c_4f6d ; $4f5d
Label_1c_4f5f:
	ld a, l ; $4f5f
	rlca ; $4f60
	ld c, a ; $4f61
	ld de, $591c ; $4f62
	ld a, $02 ; $4f65
	call Func_1c_4fce ; $4f67
	call QueueSprite ; $4f6a
Label_1c_4f6d:
	ld b, $0e ; $4f6d
	ld a, [$d00d] ; $4f6f
	ld l, a ; $4f72
	ld a, [$d028] ; $4f73
	or a, a ; $4f76
	jr nz, Label_1c_4f83 ; $4f77
	ld a, [$d024] ; $4f79
	cp a, $03 ; $4f7c
	jr nz, Label_1c_4f83 ; $4f7e
	inc l ; $4f80
	ld b, $0f ; $4f81
Label_1c_4f83:
	ld a, l ; $4f83
	cp a, $0a ; $4f84
	jr c, Label_1c_4fbc ; $4f86
	push bc ; $4f88
	ld h, $00 ; $4f89
	ld a, $02 ; $4f8b
	ld de, $d08e ; $4f8d
	call FormatDecimalNumberUnsigned ; $4f90
	pop bc ; $4f93
	push bc ; $4f94
	ld a, [$d08e] ; $4f95
	sub a, $30 ; $4f98
	rlca ; $4f9a
	ld c, a ; $4f9b
	ld de, $5544 ; $4f9c
	ld a, $03 ; $4f9f
	call Func_1c_4fce ; $4fa1
	call QueueSprite ; $4fa4
	pop bc ; $4fa7
	ld a, [$d08f] ; $4fa8
	sub a, $30 ; $4fab
	rlca ; $4fad
	ld c, a ; $4fae
	ld de, $5c44 ; $4faf
	ld a, $03 ; $4fb2
	call Func_1c_4fce ; $4fb4
	call QueueSprite ; $4fb7
	jr Label_1c_4fca ; $4fba
Label_1c_4fbc:
	ld a, l ; $4fbc
	rlca ; $4fbd
	ld c, a ; $4fbe
	ld de, $5944 ; $4fbf
	ld a, $03 ; $4fc2
	call Func_1c_4fce ; $4fc4
	call QueueSprite ; $4fc7
Label_1c_4fca:
	farcall FarPtr_1a_12 ; $4fca
	ret ; $4fcd
Func_1c_4fce:
	rlca ; $4fce
	add a, $e9 ; $4fcf
	ld l, a ; $4fd1
	adc a, $4f ; $4fd2
	sub a, l ; $4fd4
	ld h, a ; $4fd5
	ld a, [hl+] ; $4fd6
	ld h, [hl] ; $4fd7
	ld l, a ; $4fd8
	ld a, [$d026] ; $4fd9
	rlca ; $4fdc
	add a, l ; $4fdd
	ld l, a ; $4fde
	jr nc, Label_1c_4fe2 ; $4fdf
	inc h ; $4fe1
Label_1c_4fe2:
	ld a, [hl+] ; $4fe2
	add a, d ; $4fe3
	ld d, a ; $4fe4
	ld a, [hl] ; $4fe5
	add a, e ; $4fe6
	ld e, a ; $4fe7
	ret ; $4fe8
	INCBIN "data/bank_01c/d_4fe9.bin" ; $4fe9, 96 bytes
	wram_bank $06 ; $5049
	ld a, [$d009] ; $504f
	cp a, $0a ; $5052
	jr c, Label_1c_5086 ; $5054
	ld h, $00 ; $5056
	ld l, a ; $5058
	ld a, $02 ; $5059
	ld de, $d08e ; $505b
	call FormatDecimalNumberUnsigned ; $505e
	ld a, [$d08e] ; $5061
	sub a, $30 ; $5064
	rlca ; $5066
	ld c, a ; $5067
	ld de, $147f ; $5068
	call Func_1c_5094 ; $506b
	ld b, $0f ; $506e
	call QueueSprite ; $5070
	ld a, [$d08f] ; $5073
	sub a, $30 ; $5076
	rlca ; $5078
	ld c, a ; $5079
	ld de, $1b7f ; $507a
	call Func_1c_5094 ; $507d
	ld b, $0f ; $5080
	call QueueSprite ; $5082
	ret ; $5085
Label_1c_5086:
	rlca ; $5086
	ld c, a ; $5087
	ld de, $187f ; $5088
	call Func_1c_5094 ; $508b
	ld b, $0f ; $508e
	call QueueSprite ; $5090
	ret ; $5093
Func_1c_5094:
	ld a, [$d027] ; $5094
	rlca ; $5097
	rlca ; $5098
	rlca ; $5099
	add a, e ; $509a
	ld e, a ; $509b
	ret ; $509c
Func_1c_509d:
	wram_bank $06 ; $509d
	ld a, [$d0b6] ; $50a3
	or a, a ; $50a6
	jp nz, Label_1c_51a3 ; $50a7
	call AdvanceFrame ; $50aa
	ldh a, [hInputRisingEdge] ; $50ad
	push af ; $50af
	test_flag $03, 4 ; $50b0
	jr z, Label_1c_50bd ; $50b3
	bit 3, a ; $50b5
	jr z, Label_1c_50bd ; $50b7
	pop af ; $50b9
	jp Label_1c_51a3 ; $50ba
Label_1c_50bd:
	pop af ; $50bd
	bit 0, a ; $50be
	jr nz, Label_1c_512a ; $50c0
	bit 1, a ; $50c2
	jr nz, Label_1c_50f9 ; $50c4
	bit 4, a ; $50c6
	jr nz, Label_1c_50f0 ; $50c8
	bit 5, a ; $50ca
	jr nz, Label_1c_50e8 ; $50cc
	bit 7, a ; $50ce
	jr nz, Label_1c_50e0 ; $50d0
	bit 6, a ; $50d2
	jr nz, Label_1c_50d8 ; $50d4
	jr Func_1c_509d ; $50d6
Label_1c_50d8:
	ld hl, $5665 ; $50d8
	call Func_1c_53c3 ; $50db
	jr Func_1c_509d ; $50de
Label_1c_50e0:
	ld hl, $566a ; $50e0
	call Func_1c_53c3 ; $50e3
	jr Func_1c_509d ; $50e6
Label_1c_50e8:
	ld hl, $566f ; $50e8
	call Func_1c_53c3 ; $50eb
	jr Func_1c_509d ; $50ee
Label_1c_50f0:
	ld hl, $5674 ; $50f0
	call Func_1c_53c3 ; $50f3
	jp Func_1c_509d ; $50f6
Label_1c_50f9:
	wram_bank $06 ; $50f9
	ld a, [$d024] ; $50ff
	cp a, $04 ; $5102
	jr nz, Label_1c_5110 ; $5104
	call Func_1c_5404 ; $5106
	or a, a ; $5109
	jp nz, Func_1c_509d ; $510a
	ld a, $01 ; $510d
	ret ; $510f
Label_1c_5110:
	ld a, $04 ; $5110
	ld [$d024], a ; $5112
	call Func_1c_48ec ; $5115
	call Func_1c_4c43 ; $5118
	call CharDataScreen_DrawStats ; $511b
	call Func_1c_4882 ; $511e
	call Func_1c_4dd6 ; $5121
	call Func_1c_495d ; $5124
	jp nz, Func_1c_509d ; $5127
Label_1c_512a:
	wram_bank $06 ; $512a
	ld a, [$d024] ; $5130
	cp a, $04 ; $5133
	jp z, Func_1c_509d ; $5135
	sound $5f ; $5138
	ld d, a ; $513a
	ld a, [$cb00] ; $513b
	farcall FarPtr_LevelUpPlayer ; $513e
	wram_bank $06 ; $5141
	ld hl, $d009 ; $5147
	dec [hl] ; $514a
	ld a, [$d029] ; $514b
	add a, $2a ; $514e
	ld l, a ; $5150
	adc a, $d0 ; $5151
	sub a, l ; $5153
	ld h, a ; $5154
	ld a, [$d024] ; $5155
	ld [hl], a ; $5158
	ld hl, $d029 ; $5159
	inc [hl] ; $515c
	ld a, $04 ; $515d
	ld [$d024], a ; $515f
	test_flag $03, 4 ; $5162
	jr nz, Label_1c_5171 ; $5165
	ld a, [$cb00] ; $5167
	farcall FarPtr_HasReachedNextLevelExp ; $516a
	jr nz, Label_1c_51a3 ; $516d
	jr Label_1c_518e ; $516f
Label_1c_5171:
	ld a, [$cb00] ; $5171
	push af ; $5174
	ld hl, wStoryModeNameOfMainCharacter ; $5175
	ld a, [$cb00] ; $5178
	or a, a ; $517b
	jr z, Label_1c_5180 ; $517c
	ld l, $40 ; $517e
Label_1c_5180:
	ld a, l ; $5180
	add a, $18 ; $5181
	ld l, a ; $5183
	ld a, h ; $5184
	adc a, $00 ; $5185
	ld h, a ; $5187
	pop af ; $5188
	ld a, [hl] ; $5189
	cp a, $63 ; $518a
	jr z, Label_1c_51a3 ; $518c
Label_1c_518e:
	call Func_1c_48ec ; $518e
	call Func_1c_4c43 ; $5191
	call CharDataScreen_DrawStats ; $5194
	call Func_1c_4882 ; $5197
	call Func_1c_4dd6 ; $519a
	call Func_1c_495d ; $519d
	jp Func_1c_509d ; $51a0
Label_1c_51a3:
	wram_bank $06 ; $51a3
	ld a, [$d0b6] ; $51a9
	or a, a ; $51ac
	jp nz, Label_1c_528d ; $51ad
	ld hl, $54f2 ; $51b0
	call UnregisterFrameTask ; $51b3
	call Func_1c_4c43 ; $51b6
	call CharDataScreen_DrawStats ; $51b9
	call Func_1c_48ec ; $51bc
	call Func_1c_489b ; $51bf
	ld hl, $5904 ; $51c2
	ld bc, $d3a0 ; $51c5
	call Func_1c_490f ; $51c8
	ld hl, $591f ; $51cb
	ld bc, $d380 ; $51ce
	call Func_1c_490f ; $51d1
	wram_bank $06 ; $51d4
	ld a, $01 ; $51da
	ld [$d027], a ; $51dc
	ld [$d025], a ; $51df
	ld [$d028], a ; $51e2
	call Func_1c_495d ; $51e5
	call Func_1c_48ec ; $51e8
	call Func_1c_489b ; $51eb
	ld hl, $590d ; $51ee
	ld bc, $d3a0 ; $51f1
	call Func_1c_490f ; $51f4
	ld hl, $5928 ; $51f7
	ld bc, $d380 ; $51fa
	call Func_1c_490f ; $51fd
	wram_bank $06 ; $5200
	ld a, $02 ; $5206
	ld [$d027], a ; $5208
	call Func_1c_495d ; $520b
	wram_bank $06 ; $520e
	ld a, $03 ; $5214
	ld [$d027], a ; $5216
	ld hl, $5049 ; $5219
	call UnregisterFrameTask ; $521c
	call Func_1c_48ec ; $521f
	call Func_1c_489b ; $5222
	call Func_1c_495d ; $5225
	call Func_1c_48ec ; $5228
	call Func_1c_489b ; $522b
	ld hl, $597b ; $522e
	ld bc, $d410 ; $5231
	call Func_1c_490f ; $5234
	call Func_1c_495d ; $5237
	call Func_1c_48ec ; $523a
	call Func_1c_489b ; $523d
	ld hl, $5943 ; $5240
	ld bc, $d3e0 ; $5243
	call Func_1c_490f ; $5246
	ld hl, $596a ; $5249
	ld bc, $d410 ; $524c
	call Func_1c_490f ; $524f
	call Func_1c_495d ; $5252
	call Func_1c_48ec ; $5255
	call Func_1c_489b ; $5258
	ld hl, $593a ; $525b
	ld bc, $d3e0 ; $525e
	call Func_1c_490f ; $5261
	ld hl, $5959 ; $5264
	ld bc, $d410 ; $5267
	call Func_1c_490f ; $526a
	call Func_1c_495d ; $526d
	call Func_1c_48ec ; $5270
	call Func_1c_489b ; $5273
	ld hl, $592d ; $5276
	ld bc, $d3e0 ; $5279
	call Func_1c_490f ; $527c
	ld hl, $5948 ; $527f
	ld bc, $d410 ; $5282
	call Func_1c_490f ; $5285
	call Func_1c_495d ; $5288
	jr Label_1c_5291 ; $528b
Label_1c_528d:
	xor a, a ; $528d
	ld [$d0b6], a ; $528e
Label_1c_5291:
	call Func_1c_53a3 ; $5291
	call AdvanceFrame ; $5294
	ldh a, [hInputRisingEdge] ; $5297
	bit 0, a ; $5299
	jr nz, Label_1c_52b1 ; $529b
	bit 1, a ; $529d
	jr nz, Label_1c_52c1 ; $529f
	and a, $c0 ; $52a1
	jr z, Label_1c_5291 ; $52a3
	sound $5e ; $52a5
	ld a, [$d025] ; $52a7
	xor a, $01 ; $52aa
	ld [$d025], a ; $52ac
	jr Label_1c_5291 ; $52af
Label_1c_52b1:
	wram_bank $06 ; $52b1
	ld a, [$d025] ; $52b7
	or a, a ; $52ba
	jr nz, Label_1c_52c1 ; $52bb
	sound $5f ; $52bd
	xor a, a ; $52bf
	ret ; $52c0
Label_1c_52c1:
	sound $62 ; $52c1
	call Func_1c_54e3 ; $52c3
	call Func_1c_48ec ; $52c6
	call Func_1c_4c43 ; $52c9
	call CharDataScreen_DrawStats ; $52cc
	call Func_1c_489b ; $52cf
	ld hl, $593a ; $52d2
	ld bc, $d3e0 ; $52d5
	call Func_1c_490f ; $52d8
	ld hl, $5959 ; $52db
	ld bc, $d410 ; $52de
	call Func_1c_490f ; $52e1
	call Func_1c_495d ; $52e4
	call Func_1c_48ec ; $52e7
	call Func_1c_489b ; $52ea
	ld hl, $5943 ; $52ed
	ld bc, $d3e0 ; $52f0
	call Func_1c_490f ; $52f3
	ld hl, $596a ; $52f6
	ld bc, $d410 ; $52f9
	call Func_1c_490f ; $52fc
	call Func_1c_495d ; $52ff
	call Func_1c_48ec ; $5302
	call Func_1c_489b ; $5305
	ld hl, $597b ; $5308
	ld bc, $d410 ; $530b
	call Func_1c_490f ; $530e
	call Func_1c_495d ; $5311
	call Func_1c_48ec ; $5314
	call Func_1c_489b ; $5317
	call Func_1c_495d ; $531a
	wram_bank $06 ; $531d
	ld a, $03 ; $5323
	ld [$d027], a ; $5325
	call Func_1c_495d ; $5328
	ld a, $01 ; $532b
	ld hl, $5049 ; $532d
	call RegisterFrameTask ; $5330
	call Func_1c_48ec ; $5333
	call Func_1c_489b ; $5336
	ld hl, $590d ; $5339
	ld bc, $d3a0 ; $533c
	call Func_1c_490f ; $533f
	ld hl, $5928 ; $5342
	ld bc, $d380 ; $5345
	call Func_1c_490f ; $5348
	wram_bank $06 ; $534b
	ld a, $02 ; $5351
	ld [$d027], a ; $5353
	call Func_1c_495d ; $5356
	call Func_1c_48ec ; $5359
	call Func_1c_489b ; $535c
	ld hl, $5904 ; $535f
	ld bc, $d3a0 ; $5362
	call Func_1c_490f ; $5365
	ld hl, $591f ; $5368
	ld bc, $d380 ; $536b
	call Func_1c_490f ; $536e
	wram_bank $06 ; $5371
	ld a, $01 ; $5377
	ld [$d027], a ; $5379
	call Func_1c_495d ; $537c
	wram_bank $06 ; $537f
	xor a, a ; $5385
	ld [$d028], a ; $5386
	ld [$d027], a ; $5389
	call Func_1c_48ec ; $538c
	call Func_1c_4882 ; $538f
	call Func_1c_4dd6 ; $5392
	call Func_1c_495d ; $5395
	ld a, $01 ; $5398
	ld hl, $54f2 ; $539a
	call RegisterFrameTask ; $539d
	jp Func_1c_509d ; $53a0
Func_1c_53a3:
	wram_bank $06 ; $53a3
	ld a, [$d025] ; $53a9
	or a, a ; $53ac
	jr nz, Label_1c_53b9 ; $53ad
	ld bc, $0fd4 ; $53af
	ld de, $7a0c ; $53b2
	call QueueSprite ; $53b5
	ret ; $53b8
Label_1c_53b9:
	ld bc, $0fd4 ; $53b9
	ld de, $7a14 ; $53bc
	call QueueSprite ; $53bf
	ret ; $53c2
Func_1c_53c3:
	wram_bank $06 ; $53c3
	ld a, [$d024] ; $53c9
	add a, l ; $53cc
	ld l, a ; $53cd
	jr nc, Label_1c_53d1 ; $53ce
	inc h ; $53d0
Label_1c_53d1:
	ld a, [hl] ; $53d1
	cp a, $ff ; $53d2
	ret z ; $53d4
	ld [$d024], a ; $53d5
	sound $5e ; $53d8
	cp a, $04 ; $53da
	jr z, Label_1c_53f1 ; $53dc
	call Func_1c_48ec ; $53de
	call Func_1c_4a94 ; $53e1
	call CharDataScreen_DrawStats ; $53e4
	call Func_1c_4882 ; $53e7
	call Func_1c_4dd6 ; $53ea
	call Func_1c_495d ; $53ed
	ret ; $53f0
Label_1c_53f1:
	call Func_1c_48ec ; $53f1
	call Func_1c_4c43 ; $53f4
	call CharDataScreen_DrawStats ; $53f7
	call Func_1c_4882 ; $53fa
	call Func_1c_4dd6 ; $53fd
	call Func_1c_495d ; $5400
	ret ; $5403
Func_1c_5404:
	wram_bank $06 ; $5404
	ld a, [$d029] ; $540a
	or a, a ; $540d
	ret z ; $540e
	sound $62 ; $540f
	ld hl, $d009 ; $5411
	inc [hl] ; $5414
	push af ; $5415
	ld hl, wStoryModeNameOfMainCharacter ; $5416
	ld a, [$cb00] ; $5419
	or a, a ; $541c
	jr z, Label_1c_5421 ; $541d
	ld l, $40 ; $541f
Label_1c_5421:
	ld a, l ; $5421
	add a, $18 ; $5422
	ld l, a ; $5424
	ld a, h ; $5425
	adc a, $00 ; $5426
	ld h, a ; $5428
	pop af ; $5429
	ld a, [$d004] ; $542a
	ld [hl], a ; $542d
	push af ; $542e
	ld hl, wStoryModeNameOfMainCharacter ; $542f
	ld a, [$cb00] ; $5432
	or a, a ; $5435
	jr z, Label_1c_543a ; $5436
	ld l, $40 ; $5438
Label_1c_543a:
	ld a, l ; $543a
	add a, $38 ; $543b
	ld l, a ; $543d
	ld a, h ; $543e
	adc a, $00 ; $543f
	ld h, a ; $5441
	pop af ; $5442
	ld a, [$d005] ; $5443
	ld [hl], a ; $5446
	ld [$d00a], a ; $5447
	push af ; $544a
	ld hl, wStoryModeNameOfMainCharacter ; $544b
	ld a, [$cb00] ; $544e
	or a, a ; $5451
	jr z, Label_1c_5456 ; $5452
	ld l, $40 ; $5454
Label_1c_5456:
	ld a, l ; $5456
	add a, $39 ; $5457
	ld l, a ; $5459
	ld a, h ; $545a
	adc a, $00 ; $545b
	ld h, a ; $545d
	pop af ; $545e
	ld a, [$d006] ; $545f
	ld [hl], a ; $5462
	ld [$d00b], a ; $5463
	push af ; $5466
	ld hl, wStoryModeNameOfMainCharacter ; $5467
	ld a, [$cb00] ; $546a
	or a, a ; $546d
	jr z, Label_1c_5472 ; $546e
	ld l, $40 ; $5470
Label_1c_5472:
	ld a, l ; $5472
	add a, $3a ; $5473
	ld l, a ; $5475
	ld a, h ; $5476
	adc a, $00 ; $5477
	ld h, a ; $5479
	pop af ; $547a
	ld a, [$d007] ; $547b
	ld [hl], a ; $547e
	ld [$d00c], a ; $547f
	push af ; $5482
	ld hl, wStoryModeNameOfMainCharacter ; $5483
	ld a, [$cb00] ; $5486
	or a, a ; $5489
	jr z, Label_1c_548e ; $548a
	ld l, $40 ; $548c
Label_1c_548e:
	ld a, l ; $548e
	add a, $3b ; $548f
	ld l, a ; $5491
	ld a, h ; $5492
	adc a, $00 ; $5493
	ld h, a ; $5495
	pop af ; $5496
	ld a, [$d008] ; $5497
	ld [hl], a ; $549a
	ld [$d00d], a ; $549b
	ld a, [$cb00] ; $549e
	farcall FarPtr_RefreshPlayerStatsAndGetPtr ; $54a1
	ld a, [$d029] ; $54a4
	ld c, a ; $54a7
	ld b, $00 ; $54a8
Label_1c_54aa:
	dec c ; $54aa
	jr z, Label_1c_54c2 ; $54ab
	push bc ; $54ad
	ld a, b ; $54ae
	add a, $2a ; $54af
	ld l, a ; $54b1
	adc a, $d0 ; $54b2
	sub a, l ; $54b4
	ld h, a ; $54b5
	ld a, [hl] ; $54b6
	ld d, a ; $54b7
	ld a, [$cb00] ; $54b8
	farcall FarPtr_LevelUpPlayer ; $54bb
	pop bc ; $54be
	inc b ; $54bf
	jr Label_1c_54aa ; $54c0
Label_1c_54c2:
	ld a, [$d029] ; $54c2
	dec a ; $54c5
	ld [$d029], a ; $54c6
	ld a, $04 ; $54c9
	ld [$d024], a ; $54cb
	call Func_1c_48ec ; $54ce
	call Func_1c_4c43 ; $54d1
	call CharDataScreen_DrawStats ; $54d4
	call Func_1c_4882 ; $54d7
	call Func_1c_4dd6 ; $54da
	call Func_1c_495d ; $54dd
	ld a, $01 ; $54e0
	ret ; $54e2
Func_1c_54e3:
	wram_bank $06 ; $54e3
	ld a, $04 ; $54e9
	ld [$d024], a ; $54eb
	call Func_1c_49eb ; $54ee
	ret ; $54f1
	wram_bank $06 ; $54f2
	ld a, [$d019] ; $54f8
	ld de, $4c24 ; $54fb
	call Func_1c_555c ; $54fe
	ld a, [$d01a] ; $5501
	ld de, $4c34 ; $5504
	call Func_1c_555c ; $5507
	ld a, [$d01b] ; $550a
	ld de, $4c4c ; $550d
	call Func_1c_555c ; $5510
	ld a, [$d01c] ; $5513
	ld de, $4c5c ; $5516
	call Func_1c_555c ; $5519
	ld a, [$d01d] ; $551c
	ld de, $4c6c ; $551f
	call Func_1c_555c ; $5522
	ld a, [$d01e] ; $5525
	ld de, $9c24 ; $5528
	call Func_1c_555c ; $552b
	ld a, [$d01f] ; $552e
	ld de, $9c34 ; $5531
	call Func_1c_555c ; $5534
	ld a, [$d020] ; $5537
	ld de, $9c4c ; $553a
	call Func_1c_555c ; $553d
	ld a, [$d021] ; $5540
	ld de, $9c5c ; $5543
	call Func_1c_555c ; $5546
	ld a, [$d022] ; $5549
	ld de, $9c6c ; $554c
	call Func_1c_555c ; $554f
	ld a, [$d023] ; $5552
	ld de, $9c7c ; $5555
	call Func_1c_555c ; $5558
	ret ; $555b
Func_1c_555c:
	or a, a ; $555c
	ret z ; $555d
	bit 7, a ; $555e
	jr nz, Label_1c_556a ; $5560
	ld b, $0e ; $5562
	ld c, $d0 ; $5564
	call QueueSprite ; $5566
	ret ; $5569
Label_1c_556a:
	ld b, $0f ; $556a
	ld c, $d2 ; $556c
	call QueueSprite ; $556e
	ret ; $5571
Func_1c_5572:
	sound $0d ; $5572
	call Func_1c_48c9 ; $5574
	ld hl, $56b9 ; $5577
	ld bc, $d240 ; $557a
	call Func_1c_490f ; $557d
	ld hl, $5720 ; $5580
	ld bc, $d280 ; $5583
	call Func_1c_490f ; $5586
	ld hl, $57bb ; $5589
	ld bc, $d2d0 ; $558c
	call Func_1c_490f ; $558f
	ld hl, $5821 ; $5592
	ld bc, $d310 ; $5595
	call Func_1c_490f ; $5598
	ld hl, $58d0 ; $559b
	ld bc, $d370 ; $559e
	call Func_1c_490f ; $55a1
	wram_bank $06 ; $55a4
	xor a, a ; $55aa
	ld [$d026], a ; $55ab
	wram_bank $03 ; $55ae
	ld hl, $d000 ; $55b4
	ld de, $9800 ; $55b7
	ld c, $24 ; $55ba
	call QueueVRAMCopy ; $55bc
	wram_bank $02 ; $55bf
	ld hl, $d000 ; $55c5
	ld de, $b800 ; $55c8
	ld c, $24 ; $55cb
	call QueueVRAMCopy ; $55cd
	wram_bank $06 ; $55d0
	ld a, $03 ; $55d6
	ld [$d027], a ; $55d8
	ld a, $01 ; $55db
	ld [$d025], a ; $55dd
	ld [$d028], a ; $55e0
	call EnableLCD ; $55e3
	call AdvanceFrame ; $55e6
	ld a, $01 ; $55e9
	ld hl, $4e54 ; $55eb
	call RegisterFrameTask ; $55ee
	ld c, $10 ; $55f1
	call BeginFadeIn ; $55f3
	call WaitFadeEnd ; $55f6
	ld a, $01 ; $55f9
	ld hl, $45fa ; $55fb
	call RegisterFrameTask ; $55fe
	call Func_1c_48ec ; $5601
	call Func_1c_489b ; $5604
	ld hl, $597b ; $5607
	ld bc, $d410 ; $560a
	call Func_1c_490f ; $560d
	call Func_1c_495d ; $5610
	call Func_1c_48ec ; $5613
	call Func_1c_489b ; $5616
	ld hl, $5943 ; $5619
	ld bc, $d3e0 ; $561c
	call Func_1c_490f ; $561f
	ld hl, $596a ; $5622
	ld bc, $d410 ; $5625
	call Func_1c_490f ; $5628
	call Func_1c_495d ; $562b
	call Func_1c_48ec ; $562e
	call Func_1c_489b ; $5631
	ld hl, $593a ; $5634
	ld bc, $d3e0 ; $5637
	call Func_1c_490f ; $563a
	ld hl, $5959 ; $563d
	ld bc, $d410 ; $5640
	call Func_1c_490f ; $5643
	call Func_1c_495d ; $5646
	call Func_1c_48ec ; $5649
	call Func_1c_489b ; $564c
	ld hl, $592d ; $564f
	ld bc, $d3e0 ; $5652
	call Func_1c_490f ; $5655
	ld hl, $5948 ; $5658
	ld bc, $d410 ; $565b
	call Func_1c_490f ; $565e
	call Func_1c_495d ; $5661
	ret ; $5664
	INCBIN "data/bank_01c/d_5665.bin" ; $5665, 2845 bytes
	rst Rst18 ; $6182
	and a, a ; $6183
	rst Rst38 ; $6184
	ld sp, hl ; $6185
	rst Rst10 ; $6186
	ld sp, hl ; $6187
	adc a, e ; $6188
	INCBIN "data/bank_01c/d_6189.bin" ; $6189, 3425 bytes
Label_1c_6eea:
	ld b, b ; $6eea
	sbc a, b ; $6eeb
	inc h ; $6eec
	ret z ; $6eed
	nop ; $6eee
	INCBIN "data/bank_01c/d_6eef.bin" ; $6eef, 34 bytes
	sound $10 ; $6f11
	sound $40 ; $6f13
	sbc a, a ; $6f15
	and a, b ; $6f16
	rra ; $6f17
	ld b, d ; $6f18
	inc a ; $6f19
	add hl, bc ; $6f1a
	ldh a, [hInputRisingEdge] ; $6f1b
	ld h, e ; $6f1d
	ld c, b ; $6f1e
	daa ; $6f1f
	add a, b ; $6f20
	nop ; $6f21
	nop ; $6f22
	nop ; $6f23
	nop ; $6f24
	nop ; $6f25
	add a, b ; $6f26
	nop ; $6f27
	jr nz, Label_1c_6eea ; $6f28
	INCBIN "data/bank_01c/d_6f2a.bin" ; $6f2a, 492 bytes
CharDataScreen_LoadScreen:
	ld hl, $598c ; $7116
	ld de, $0008 ; $7119
	call LoadPaletteShadow ; $711c
	ld hl, $598c ; $711f
	ld de, $0808 ; $7122
	call LoadPaletteShadow ; $7125
	wram_bank $01 ; $7128
	ld hl, $7080 ; $712e
	ld de, $d000 ; $7131
	call DecompressData ; $7134
	ld hl, $d000 ; $7137
	ld de, $a000 ; $713a
	ld c, $14 ; $713d
	call QueueVRAMCopy ; $713f
	farcall FarPtr_CharDataScreen_LoadGfx ; $7142
	wram_bank $01 ; $7145
	ld hl, $59cc ; $714b
	ld de, $d000 ; $714e
	call DecompressData ; $7151
	ld hl, $d000 ; $7154
	ld de, $b000 ; $7157
	ld c, $80 ; $715a
	call QueueVRAMCopy ; $715c
	ld hl, $d800 ; $715f
	ld de, $a800 ; $7162
	ld c, $80 ; $7165
	call QueueVRAMCopy ; $7167
	wram_bank $01 ; $716a
	ld hl, $6406 ; $7170
	ld de, $d000 ; $7173
	call DecompressData ; $7176
	ld hl, $d000 ; $7179
	ld bc, $0240 ; $717c
	call CopyWram1ToWram3 ; $717f
	wram_bank $01 ; $7182
	ld hl, $6469 ; $7188
	ld de, $d000 ; $718b
	call DecompressData ; $718e
	ld hl, $d000 ; $7191
	ld bc, $0240 ; $7194
	call CopyWram1ToWram2 ; $7197
	wram_bank $01 ; $719a
	ld hl, $6549 ; $71a0
	ld de, $d240 ; $71a3
	call DecompressData ; $71a6
	ld hl, $d240 ; $71a9
	ld bc, $0032 ; $71ac
	call CopyWram1ToWram3 ; $71af
	wram_bank $01 ; $71b2
	ld hl, $657f ; $71b8
	ld de, $d240 ; $71bb
	call DecompressData ; $71be
	ld hl, $d240 ; $71c1
	ld bc, $0032 ; $71c4
	call CopyWram1ToWram2 ; $71c7
	wram_bank $01 ; $71ca
	ld hl, $65c8 ; $71d0
	ld de, $d280 ; $71d3
	call DecompressData ; $71d6
	ld hl, $d280 ; $71d9
	ld bc, $0046 ; $71dc
	call CopyWram1ToWram3 ; $71df
	wram_bank $01 ; $71e2
	ld hl, $660b ; $71e8
	ld de, $d280 ; $71eb
	call DecompressData ; $71ee
	ld hl, $d280 ; $71f1
	ld bc, $0046 ; $71f4
	call CopyWram1ToWram2 ; $71f7
	wram_bank $01 ; $71fa
	ld hl, $6668 ; $7200
	ld de, $d2d0 ; $7203
	call DecompressData ; $7206
	ld hl, $d2d0 ; $7209
	ld bc, $0032 ; $720c
	call CopyWram1ToWram3 ; $720f
	wram_bank $01 ; $7212
	ld hl, $66a2 ; $7218
	ld de, $d2d0 ; $721b
	call DecompressData ; $721e
	ld hl, $d2d0 ; $7221
	ld bc, $0032 ; $7224
	call CopyWram1ToWram2 ; $7227
	wram_bank $01 ; $722a
	ld hl, $66ec ; $7230
	ld de, $d310 ; $7233
	call DecompressData ; $7236
	ld hl, $d310 ; $7239
	ld bc, $005a ; $723c
	call CopyWram1ToWram3 ; $723f
	wram_bank $01 ; $7242
	ld hl, $6734 ; $7248
	ld de, $d310 ; $724b
	call DecompressData ; $724e
	ld hl, $d310 ; $7251
	ld bc, $005a ; $7254
	call CopyWram1ToWram2 ; $7257
	wram_bank $01 ; $725a
	ld hl, $67c5 ; $7260
	ld de, $d370 ; $7263
	call DecompressData ; $7266
	ld hl, $d370 ; $7269
	ld bc, $0009 ; $726c
	call CopyWram1ToWram3 ; $726f
	wram_bank $01 ; $7272
	ld hl, $67d3 ; $7278
	ld de, $d370 ; $727b
	call DecompressData ; $727e
	ld hl, $d370 ; $7281
	ld bc, $0009 ; $7284
	call CopyWram1ToWram2 ; $7287
	ret ; $728a
Func_1c_728b:
	wram_bank $01 ; $728b
	ld hl, $682e ; $7291
	ld de, $d550 ; $7294
	call DecompressData ; $7297
	ld hl, $d550 ; $729a
	ld bc, $0021 ; $729d
	call CopyWram1ToWram3 ; $72a0
	wram_bank $01 ; $72a3
	ld hl, $6848 ; $72a9
	ld de, $d550 ; $72ac
	call DecompressData ; $72af
	ld hl, $d550 ; $72b2
	ld bc, $0021 ; $72b5
	call CopyWram1ToWram2 ; $72b8
	wram_bank $01 ; $72bb
	ld hl, $684f ; $72c1
	ld de, $d580 ; $72c4
	call DecompressData ; $72c7
	ld hl, $d580 ; $72ca
	ld bc, $0018 ; $72cd
	call CopyWram1ToWram3 ; $72d0
	wram_bank $01 ; $72d3
	ld hl, $686b ; $72d9
	ld de, $d580 ; $72dc
	call DecompressData ; $72df
	ld hl, $d580 ; $72e2
	ld bc, $0018 ; $72e5
	call CopyWram1ToWram2 ; $72e8
	ret ; $72eb
Func_1c_72ec:
	ld a, $01 ; $72ec
	ld hl, $45fa ; $72ee
	call RegisterFrameTask ; $72f1
	ret ; $72f4
Func_1c_72f5:
	ld hl, $45fa ; $72f5
	call UnregisterFrameTask ; $72f8
	ret ; $72fb
Func_1c_72fc:
	call Func_1c_495d ; $72fc
	ret ; $72ff
BackupCharData:
	wram_bank $06 ; $7300
	ld hl, $d003 ; $7306
	ld de, $d0b7 ; $7309
	ld bc, $0006 ; $730c
	call CopyMemoryBC ; $730f
	ld hl, $d029 ; $7312
	ld de, $d0bd ; $7315
	ld bc, $0065 ; $7318
	call CopyMemoryBC ; $731b
	ret ; $731e
Func_1c_731f:
	wram_bank $06 ; $731f
	ld hl, $d0b7 ; $7325
	ld de, $d003 ; $7328
	ld bc, $0006 ; $732b
	call CopyMemoryBC ; $732e
	ld hl, $d0bd ; $7331
	ld de, $d029 ; $7334
	ld bc, $0065 ; $7337
	call CopyMemoryBC ; $733a
	ld a, $01 ; $733d
	ld [$d0b6], a ; $733f
	xor a, a ; $7342
	ld [$cb00], a ; $7343
	ld a, [$d003] ; $7346
	ld [$d009], a ; $7349
	push af ; $734c
	ld hl, wStoryModeNameOfMainCharacter ; $734d
	ld a, [$cb00] ; $7350
	or a, a ; $7353
	jr z, Label_1c_7358 ; $7354
	ld l, $40 ; $7356
Label_1c_7358:
	ld a, l ; $7358
	add a, $18 ; $7359
	ld l, a ; $735b
	ld a, h ; $735c
	adc a, $00 ; $735d
	ld h, a ; $735f
	pop af ; $7360
	ld a, [$d004] ; $7361
	ld [hl], a ; $7364
	push af ; $7365
	ld hl, wStoryModeNameOfMainCharacter ; $7366
	ld a, [$cb00] ; $7369
	or a, a ; $736c
	jr z, Label_1c_7371 ; $736d
	ld l, $40 ; $736f
Label_1c_7371:
	ld a, l ; $7371
	add a, $38 ; $7372
	ld l, a ; $7374
	ld a, h ; $7375
	adc a, $00 ; $7376
	ld h, a ; $7378
	pop af ; $7379
	ld a, [$d005] ; $737a
	ld [hl], a ; $737d
	ld [$d00a], a ; $737e
	push af ; $7381
	ld hl, wStoryModeNameOfMainCharacter ; $7382
	ld a, [$cb00] ; $7385
	or a, a ; $7388
	jr z, Label_1c_738d ; $7389
	ld l, $40 ; $738b
Label_1c_738d:
	ld a, l ; $738d
	add a, $39 ; $738e
	ld l, a ; $7390
	ld a, h ; $7391
	adc a, $00 ; $7392
	ld h, a ; $7394
	pop af ; $7395
	ld a, [$d006] ; $7396
	ld [hl], a ; $7399
	ld [$d00b], a ; $739a
	push af ; $739d
	ld hl, wStoryModeNameOfMainCharacter ; $739e
	ld a, [$cb00] ; $73a1
	or a, a ; $73a4
	jr z, Label_1c_73a9 ; $73a5
	ld l, $40 ; $73a7
Label_1c_73a9:
	ld a, l ; $73a9
	add a, $3a ; $73aa
	ld l, a ; $73ac
	ld a, h ; $73ad
	adc a, $00 ; $73ae
	ld h, a ; $73b0
	pop af ; $73b1
	ld a, [$d007] ; $73b2
	ld [hl], a ; $73b5
	ld [$d00c], a ; $73b6
	push af ; $73b9
	ld hl, wStoryModeNameOfMainCharacter ; $73ba
	ld a, [$cb00] ; $73bd
	or a, a ; $73c0
	jr z, Label_1c_73c5 ; $73c1
	ld l, $40 ; $73c3
Label_1c_73c5:
	ld a, l ; $73c5
	add a, $3b ; $73c6
	ld l, a ; $73c8
	ld a, h ; $73c9
	adc a, $00 ; $73ca
	ld h, a ; $73cc
	pop af ; $73cd
	ld a, [$d008] ; $73ce
	ld [hl], a ; $73d1
	ld [$d00d], a ; $73d2
	xor a, a ; $73d5
	farcall FarPtr_RefreshPlayerStatsAndGetPtr ; $73d6
	wram_bank $06 ; $73d9
	ld hl, $d02a ; $73df
	ld a, [$d029] ; $73e2
	ld b, a ; $73e5
Label_1c_73e6:
	ld a, [hl+] ; $73e6
	push bc ; $73e7
	push hl ; $73e8
	ld d, a ; $73e9
	xor a, a ; $73ea
	farcall FarPtr_LevelUpPlayer ; $73eb
	pop hl ; $73ee
	pop bc ; $73ef
	dec b ; $73f0
	jr nz, Label_1c_73e6 ; $73f1
	ret ; $73f3
Func_1c_73f4:
	call Func_1c_73fb ; $73f4
	call Func_1c_748d ; $73f7
	ret ; $73fa
Func_1c_73fb:
	ld hl, $7541 ; $73fb
	ld de, $0008 ; $73fe
	call LoadPaletteShadow ; $7401
	ld hl, $7541 ; $7404
	ld de, $0808 ; $7407
	call LoadPaletteShadow ; $740a
	wram_bank $06 ; $740d
	ld a, [$c23a] ; $7413
	ld [$d16b], a ; $7416
	ld a, [$c23b] ; $7419
	ld [$d16c], a ; $741c
	ld a, [$c222] ; $741f
	ld [$d17a], a ; $7422
	ld a, [$c223] ; $7425
	ld [$d17b], a ; $7428
	ld hl, $c222 ; $742b
	farcall FarPtr_1d_14 ; $742e
	ld hl, $c222 ; $7431
	farcall FarPtr_1d_14 ; $7434
	wram_bank $01 ; $7437
	ld hl, $7581 ; $743d
	ld de, $d000 ; $7440
	call DecompressData ; $7443
	ld hl, $d000 ; $7446
	ld de, $b000 ; $7449
	ld c, $80 ; $744c
	call QueueVRAMCopy ; $744e
	ld hl, $d800 ; $7451
	ld de, $a800 ; $7454
	ld c, $80 ; $7457
	call QueueVRAMCopy ; $7459
	wram_bank $01 ; $745c
	ld hl, $7cdf ; $7462
	ld de, $d000 ; $7465
	call DecompressData ; $7468
	ld hl, $d000 ; $746b
	ld bc, $0240 ; $746e
	call CopyWram1ToWram3 ; $7471
	wram_bank $01 ; $7474
	ld hl, $7e1f ; $747a
	ld de, $d000 ; $747d
	call DecompressData ; $7480
	ld hl, $d000 ; $7483
	ld bc, $0240 ; $7486
	call CopyWram1ToWram2 ; $7489
	ret ; $748c
Func_1c_748d:
	xor a, a ; $748d
	ld [$cb00], a ; $748e
	push af ; $7491
	ld hl, wStoryModeNameOfMainCharacter ; $7492
	ld a, [$cb00] ; $7495
	or a, a ; $7498
	jr z, Label_1c_749d ; $7499
	ld l, $40 ; $749b
Label_1c_749d:
	ld a, l ; $749d
	add a, $0c ; $749e
	ld l, a ; $74a0
	ld a, h ; $74a1
	adc a, $00 ; $74a2
	ld h, a ; $74a4
	pop af ; $74a5
	ld a, [hl] ; $74a6
	ld de, $0101 ; $74a7
	farcall FarPtr_LoadIndexedPaletteThunk ; $74aa
	wram_bank $01 ; $74ad
	push af ; $74b3
	ld hl, wStoryModeNameOfMainCharacter ; $74b4
	ld a, [$cb00] ; $74b7
	or a, a ; $74ba
	jr z, Label_1c_74bf ; $74bb
	ld l, $40 ; $74bd
Label_1c_74bf:
	ld a, l ; $74bf
	add a, $0b ; $74c0
	ld l, a ; $74c2
	ld a, h ; $74c3
	adc a, $00 ; $74c4
	ld h, a ; $74c6
	pop af ; $74c7
	ld a, [hl] ; $74c8
	ld de, $d000 ; $74c9
	farcall FarPtr_DecompressCharMugshot ; $74cc
	ld hl, $d000 ; $74cf
	ld de, $ab00 ; $74d2
	ld c, $09 ; $74d5
	call QueueVRAMCopy ; $74d7
	ld a, $01 ; $74da
	ld [$cb00], a ; $74dc
	push af ; $74df
	ld hl, wStoryModeNameOfMainCharacter ; $74e0
	ld a, [$cb00] ; $74e3
	or a, a ; $74e6
	jr z, Label_1c_74eb ; $74e7
	ld l, $40 ; $74e9
Label_1c_74eb:
	ld a, l ; $74eb
	add a, $0c ; $74ec
	ld l, a ; $74ee
	ld a, h ; $74ef
	adc a, $00 ; $74f0
	ld h, a ; $74f2
	pop af ; $74f3
	ld a, [hl] ; $74f4
	ld de, $0201 ; $74f5
	farcall FarPtr_LoadIndexedPaletteThunk ; $74f8
	wram_bank $01 ; $74fb
	push af ; $7501
	ld hl, wStoryModeNameOfMainCharacter ; $7502
	ld a, [$cb00] ; $7505
	or a, a ; $7508
	jr z, Label_1c_750d ; $7509
	ld l, $40 ; $750b
Label_1c_750d:
	ld a, l ; $750d
	add a, $0b ; $750e
	ld l, a ; $7510
	ld a, h ; $7511
	adc a, $00 ; $7512
	ld h, a ; $7514
	pop af ; $7515
	ld a, [hl] ; $7516
	ld de, $d000 ; $7517
	farcall FarPtr_DecompressCharMugshot ; $751a
	ld hl, $d000 ; $751d
	ld de, $ac00 ; $7520
	ld c, $09 ; $7523
	call QueueVRAMCopy ; $7525
	ld hl, $c210 ; $7528
	farcall FarPtr_1d_14 ; $752b
	ld hl, $c212 ; $752e
	farcall FarPtr_1d_14 ; $7531
	ld hl, $c214 ; $7534
	farcall FarPtr_1d_14 ; $7537
	ld hl, $c216 ; $753a
	farcall FarPtr_1d_14 ; $753d
	ret ; $7540
	INCBIN "data/bank_01c/d_7541.bin" ; $7541, 2486 bytes
	ds 265, $ff ; $7ef7, fill
