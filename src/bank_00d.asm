SECTION "ROM Bank $0d", ROMX[$4000], BANK[$0d]

FarPtr_StartMinigameByID:
	dw StartMinigameByID ; $4000
FarPtr_GetDefaultMinigameRecordValue:
	dw GetDefaultMinigameRecordValue ; $4002
FarPtr_ShowMinigamePointResult:
	dw ShowMinigamePointResult ; $4004
InitMinigameFromConfig:
	ld hl, $0000 ; $4006
	add hl, bc ; $4009
	ld a, [hl] ; $400a
	ld [$c3b1], a ; $400b
	ld hl, $0001 ; $400e
	add hl, bc ; $4011
	ld a, [hl] ; $4012
	ld [wCurrentlyUsedCourt], a ; $4013
	ld hl, $0002 ; $4016
	add hl, bc ; $4019
	ld a, [hl] ; $401a
	ld [wOnCourtCharCount], a ; $401b
	ld hl, $0003 ; $401e
	add hl, bc ; $4021
	ld a, [hl] ; $4022
	ld [wGameMode], a ; $4023
	ld a, $02 ; $4026
	ld [wCurrentMinigameStoryMatch], a ; $4028
	ld hl, $0004 ; $402b
	add hl, bc ; $402e
	ld a, [hl] ; $402f
	ld [$c8f7], a ; $4030
	ld hl, $0005 ; $4033
	add hl, bc ; $4036
	ld a, [hl] ; $4037
	ld [$c8f8], a ; $4038
	push bc ; $403b
	ld hl, $0007 ; $403c
	add hl, bc ; $403f
	ld b, [hl] ; $4040
	ld c, $00 ; $4041
	farcall FarPtr_02_18 ; $4043
	ld a, [wStoryModeMainCharacterOverworldSprite] ; $4046
	ld [$c3b0], a ; $4049
	ld a, [$c3b1] ; $404c
	cp a, $ff ; $404f
	jr z, Label_0d_4059 ; $4051
	ld b, a ; $4053
	ld c, $02 ; $4054
	farcall FarPtr_02_18 ; $4056
Label_0d_4059:
	pop bc ; $4059
	ld hl, $0008 ; $405a
	add hl, bc ; $405d
	ld a, [hl+] ; $405e
	ld d, [hl] ; $405f
	ld e, a ; $4060
	ldh a, [hRomBank] ; $4061
	farcall FarPtr_SetModeHookTable ; $4063
	ld hl, $000a ; $4066
	add hl, bc ; $4069
	ld a, [hl+] ; $406a
	ld d, [hl] ; $406b
	ld e, a ; $406c
	farcall FarPtr_08_4a ; $406d
	ld hl, $000c ; $4070
	add hl, bc ; $4073
	ld a, [hl+] ; $4074
	ld h, [hl] ; $4075
	ld l, a ; $4076
	ld a, h ; $4077
	or a, l ; $4078
	jr z, Label_0d_407e ; $4079
	call JumpToHL ; $407b
Label_0d_407e:
	ret ; $407e
StartMinigameByID:
	sub a, $12 ; $407f
	ld l, a ; $4081
	ld h, $00 ; $4082
	add hl, hl ; $4084
	ld de, $4090 ; $4085
	add hl, de ; $4088
	ld a, [hl+] ; $4089
	ld b, [hl] ; $408a
	ld c, a ; $408b
	call InitMinigameFromConfig ; $408c
	ret ; $408f
	; $4090, 63 bytes (records:2)
	dw $44fa ; record 0
	dw $4959 ; record 1
	dw $49b6 ; record 2
	dw $4a13 ; record 3
	dw $4a70 ; record 4
	dw $4bf8 ; record 5
	dw $4c43 ; record 6
	dw $4c8e ; record 7
	dw $4cd9 ; record 8
	dw $4d3b ; record 9
	dw $5615 ; record 10
	dw $5194 ; record 11
	dw $586e ; record 12
	dw $4d8b ; record 13
	dw $5f32 ; record 14
	dw $54ec ; record 15
	dw $59cb ; record 16
	dw $5cea ; record 17
	dw $0900 ; record 18
	dw $0909 ; record 19
	dw $0900 ; record 20
	dw $0909 ; record 21
	dw $00ff ; record 22
	dw $0903 ; record 23
	dw $0109 ; record 24
	dw $0900 ; record 25
	dw $ff09 ; record 26
	dw $0300 ; record 27
	dw $0909 ; record 28
	dw $0100 ; record 29
	dw $0909 ; record 30
	db $ff
InitMinigameScore:
	xor a, a ; $40cf
	ld hl, wMinigamesCurrentScore ; $40d0
	ld [hl+], a ; $40d3
	ld [hl+], a ; $40d4
	ld hl, $c780 ; $40d5
	ld [hl+], a ; $40d8
	ld [hl+], a ; $40d9
	ld a, [wMinigameLevel] ; $40da
	ld b, a ; $40dd
	ld a, [$c8f7] ; $40de
	call GetMinigameTargetScore ; $40e1
	ld hl, wMinigamesTargetScore ; $40e4
	ld a, e ; $40e7
	ld [hl+], a ; $40e8
	ld [hl], d ; $40e9
	ld a, [$c8f7] ; $40ea
	sub a, $1a ; $40ed
	ret c ; $40ef
	add a, $16 ; $40f0
	ld l, a ; $40f2
	adc a, $41 ; $40f3
	sub a, l ; $40f5
	ld h, a ; $40f6
	ld a, [hl] ; $40f7
	farcall FarPtr_ReadMinigameRecord ; $40f8
	ldh a, [hWramBank] ; $40fb
	push af ; $40fd
	wram_bank $07 ; $40fe
	ld hl, $de00 ; $4104
	ld de, $c4ec ; $4107
	ld a, [hl+] ; $410a
	ld [de], a ; $410b
	inc de ; $410c
	ld a, [hl+] ; $410d
	ld [de], a ; $410e
	inc de ; $410f
	pop af ; $4110
	wram_bank ; $4111
	ret ; $4115
	INCBIN "data/bank_00d/d_4116.bin" ; $4116, 11 bytes
GetMinigameTargetScore:
	ld de, $0000 ; $4121
	cp a, $12 ; $4124
	ret c ; $4126
	cp a, $1c ; $4127
	jr nc, Label_0d_4139 ; $4129
	sub a, $12 ; $412b
	add a, a ; $412d
	add a, $4a ; $412e
	ld l, a ; $4130
	adc a, $41 ; $4131
	sub a, l ; $4133
	ld h, a ; $4134
	ld a, [hl+] ; $4135
	ld d, [hl] ; $4136
	ld e, a ; $4137
	ret ; $4138
Label_0d_4139:
	sub a, $1c ; $4139
	add a, a ; $413b
	add a, a ; $413c
	add a, b ; $413d
	add a, a ; $413e
	add a, $5e ; $413f
	ld l, a ; $4141
	adc a, $41 ; $4142
	sub a, l ; $4144
	ld h, a ; $4145
	ld a, [hl+] ; $4146
	ld d, [hl] ; $4147
	ld e, a ; $4148
	ret ; $4149
	; $414a, 92 bytes (records:2)
	dw $000f ; record 0
	dw $001e ; record 1
	dw $003c ; record 2
	dw $0064 ; record 3
	dw $0032 ; record 4
	dw $0032 ; record 5
	dw $0032 ; record 6
	dw $0032 ; record 7
	dw $270f ; record 8
	dw $270f ; record 9
	dw $001e ; record 10
	dw $003c ; record 11
	dw $270f ; record 12
	dw $0000 ; record 13
	dw $001e ; record 14
	dw $003c ; record 15
	dw $270f ; record 16
	dw $0000 ; record 17
	dw $0015 ; record 18
	dw $0015 ; record 19
	dw $270f ; record 20
	dw $0000 ; record 21
	dw $001e ; record 22
	dw $003c ; record 23
	dw $270f ; record 24
	dw $0000 ; record 25
	dw $0032 ; record 26
	dw $0064 ; record 27
	dw $270f ; record 28
	dw $0000 ; record 29
	dw $001e ; record 30
	dw $003c ; record 31
	dw $270f ; record 32
	dw $0000 ; record 33
	dw $00c8 ; record 34
	dw $012c ; record 35
	dw $270f ; record 36
	dw $0000 ; record 37
	dw $0064 ; record 38
	dw $012c ; record 39
	dw $270f ; record 40
	dw $0000 ; record 41
	dw $0001 ; record 42
	dw $0001 ; record 43
	dw $270f ; record 44
	dw $0000 ; record 45
GetDefaultMinigameRecordValue:
	add a, a ; $41a6
	add a, $b5 ; $41a7
	ld l, a ; $41a9
	adc a, $41 ; $41aa
	sub a, l ; $41ac
	ld h, a ; $41ad
	ld a, [hl+] ; $41ae
	ld h, [hl] ; $41af
	ld l, a ; $41b0
	ld a, [hl+] ; $41b1
	ld d, [hl] ; $41b2
	ld e, a ; $41b3
	ret ; $41b4
	INCBIN "data/bank_00d/d_41b5.bin" ; $41b5, 22 bytes
Func_0d_41cb:
	ld hl, $c789 ; $41cb
	ld a, [hl] ; $41ce
	cp a, b ; $41cf
	ret nc ; $41d0
	inc [hl] ; $41d1
	ret ; $41d2
IsMinigameTargetReached:
	ld hl, wMinigamesTargetScore ; $41d3
	ld a, [hl+] ; $41d6
	ld d, [hl] ; $41d7
	ld e, a ; $41d8
	ld hl, wMinigamesCurrentScore ; $41d9
	ld a, [hl+] ; $41dc
	ld h, [hl] ; $41dd
	ld l, a ; $41de
	ld a, l ; $41df
	sub a, e ; $41e0
	ld l, a ; $41e1
	ld a, h ; $41e2
	sbc a, d ; $41e3
	ld h, a ; $41e4
	bit 7, h ; $41e5
	jr nz, Label_0d_41ec ; $41e7
	ld a, $01 ; $41e9
	ret ; $41eb
Label_0d_41ec:
	xor a, a ; $41ec
	ret ; $41ed
Func_0d_41ee:
	ld hl, wMinigamesCurrentScore ; $41ee
	ld a, [hl+] ; $41f1
	ld d, [hl] ; $41f2
	ld e, a ; $41f3
	ld hl, $d8f1 ; $41f4
	add hl, de ; $41f7
	ld a, h ; $41f8
	or a, l ; $41f9
	jr z, Label_0d_420e ; $41fa
	ld hl, $c4ec ; $41fc
	ld a, [hl+] ; $41ff
	ld h, [hl] ; $4200
	ld l, a ; $4201
	ld a, l ; $4202
	sub a, e ; $4203
	ld l, a ; $4204
	ld a, h ; $4205
	sbc a, d ; $4206
	ld h, a ; $4207
	bit 7, h ; $4208
	jr nz, Label_0d_420e ; $420a
	xor a, a ; $420c
	ret ; $420d
Label_0d_420e:
	ld a, $01 ; $420e
	ret ; $4210
StartScorePopup:
	ldh a, [hWramBank] ; $4211
	push af ; $4213
	wram_bank $04 ; $4214
	ld hl, $dd1e ; $421a
	ld de, $c7a0 ; $421d
	ld a, [hl+] ; $4220
	ld [de], a ; $4221
	inc de ; $4222
	ld a, [hl+] ; $4223
	ld [de], a ; $4224
	inc de ; $4225
	ld a, [hl+] ; $4226
	ld [de], a ; $4227
	inc de ; $4228
	ld a, [hl+] ; $4229
	ld [de], a ; $422a
	inc de ; $422b
	pop af ; $422c
	wram_bank ; $422d
	ld a, $10 ; $4231
	ld [$c787], a ; $4233
	ret ; $4236
UpdateScorePopup:
	ld a, [$c787] ; $4237
	and a, a ; $423a
	ret z ; $423b
	ld hl, $c787 ; $423c
	call TickTimer ; $423f
	ld hl, $c7a2 ; $4242
	ld a, [hl+] ; $4245
	ld b, [hl] ; $4246
	ld c, a ; $4247
	ld hl, $c7a0 ; $4248
	ld a, [hl+] ; $424b
	ld h, [hl] ; $424c
	ld l, a ; $424d
	farcall FarPtr_08_46 ; $424e
	ld a, [$c787] ; $4251
	add a, e ; $4254
	add a, $e8 ; $4255
	ld e, a ; $4257
	ld hl, $c782 ; $4258
	ld a, [hl+] ; $425b
	ld h, [hl] ; $425c
	ld l, a ; $425d
	ld b, $01 ; $425e
	ld a, $01 ; $4260
	farcall FarPtr_DrawNumberWithSprites ; $4262
	ret ; $4265
AddToMinigameScore:
	ld hl, wMinigamesCurrentScore ; $4266
	ld a, [hl+] ; $4269
	ld h, [hl] ; $426a
	ld l, a ; $426b
	add hl, de ; $426c
	ld e, l ; $426d
	ld d, h ; $426e
	ld hl, $d8f1 ; $426f
	add hl, de ; $4272
	jr nc, Label_0d_4278 ; $4273
	ld de, $270f ; $4275
Label_0d_4278:
	ld hl, wMinigamesCurrentScore ; $4278
	ld a, e ; $427b
	ld [hl+], a ; $427c
	ld [hl], d ; $427d
	ret ; $427e
	; $427f, 64 bytes (bytes:4)
	db $08, $08, $08, $08 ; 0x00
	db $0a, $0b, $1a, $1b ; 0x04
	db $0d, $0e, $1d, $1e ; 0x08
	db $0d, $0e, $1d, $1e ; 0x0c
	db $9a, $9b, $a8, $a9 ; 0x10
	db $9c, $9d, $aa, $a9 ; 0x14
	db $b3, $b4, $aa, $b6 ; 0x18
	db $b3, $9b, $b7, $b8 ; 0x1c
	db $08, $08, $08, $08 ; 0x20
	db $0c, $0c, $0c, $0c ; 0x24
	db $0e, $0e, $0e, $0e ; 0x28
	db $0d, $0d, $0d, $0d ; 0x2c
	db $0c, $0c, $0c, $0c ; 0x30
	db $0c, $0c, $0c, $0c ; 0x34
	db $0c, $0c, $0c, $0c ; 0x38
	db $0c, $0c, $0c, $0c ; 0x3c
Func_0d_42bf:
	ldh a, [hWramBank] ; $42bf
	push af ; $42c1
	wram_bank $04 ; $42c2
	ld hl, $dd1e ; $42c8
	ld a, [hl+] ; $42cb
	ld d, [hl] ; $42cc
	ld e, a ; $42cd
	ld hl, $dd20 ; $42ce
	ld a, [hl+] ; $42d1
	ld b, [hl] ; $42d2
	ld c, a ; $42d3
	pop af ; $42d4
	wram_bank ; $42d5
	ld a, d ; $42d9
	add a, $0f ; $42da
	set 0, a ; $42dc
	ld d, a ; $42de
	ld a, b ; $42df
	add a, $10 ; $42e0
	res 0, a ; $42e2
	ld e, a ; $42e4
	ld a, d ; $42e5
	sub a, $09 ; $42e6
	srl a ; $42e8
	ld b, a ; $42ea
	cp a, $07 ; $42eb
	jr nc, Label_0d_42ff ; $42ed
	ld a, e ; $42ef
	sub a, $08 ; $42f0
	srl a ; $42f2
	ld c, a ; $42f4
	cp a, $03 ; $42f5
	jr nc, Label_0d_42ff ; $42f7
	ld a, c ; $42f9
	add a, a ; $42fa
	add a, a ; $42fb
	add a, a ; $42fc
	add a, b ; $42fd
	ret ; $42fe
Label_0d_42ff:
	ld a, $ff ; $42ff
	ret ; $4301
Func_0d_4302:
	ld hl, $c7c0 ; $4302
	ld c, $00 ; $4305
	ld b, $18 ; $4307
Label_0d_4309:
	ld a, [hl+] ; $4309
	and a, a ; $430a
	jr z, Label_0d_4316 ; $430b
	push bc ; $430d
	push hl ; $430e
	ld b, a ; $430f
	ld a, c ; $4310
	call Func_0d_431b ; $4311
	pop hl ; $4314
	pop bc ; $4315
Label_0d_4316:
	inc c ; $4316
	dec b ; $4317
	jr nz, Label_0d_4309 ; $4318
	ret ; $431a
Func_0d_431b:
	add a, a ; $431b
	add a, $73 ; $431c
	ld l, a ; $431e
	adc a, $43 ; $431f
	sub a, l ; $4321
	ld h, a ; $4322
	ld a, [hl+] ; $4323
	ld d, [hl] ; $4324
	ld e, a ; $4325
	ld a, b ; $4326
	add a, a ; $4327
	add a, a ; $4328
	add a, $9f ; $4329
	ld l, a ; $432b
	adc a, $42 ; $432c
	sub a, l ; $432e
	ld h, a ; $432f
	push hl ; $4330
	push hl ; $4331
	ld a, b ; $4332
	add a, a ; $4333
	add a, a ; $4334
	add a, $7f ; $4335
	ld l, a ; $4337
	adc a, $42 ; $4338
	sub a, l ; $433a
	ld h, a ; $433b
	push hl ; $433c
	push hl ; $433d
	pop hl ; $433e
	push de ; $433f
	ld a, d ; $4340
	add a, $d8 ; $4341
	ld d, a ; $4343
	ld bc, $0202 ; $4344
	call CopyTextRect ; $4347
	pop de ; $434a
	pop hl ; $434b
	push de ; $434c
	ld a, d ; $434d
	add a, $d0 ; $434e
	ld d, a ; $4350
	ld bc, $0202 ; $4351
	call CopyTextRect ; $4354
	pop de ; $4357
	pop hl ; $4358
	push de ; $4359
	ld a, d ; $435a
	add a, $dc ; $435b
	ld d, a ; $435d
	ld bc, $0202 ; $435e
	call CopyTextRect ; $4361
	pop de ; $4364
	pop hl ; $4365
	push de ; $4366
	ld a, d ; $4367
	add a, $d4 ; $4368
	ld d, a ; $436a
	ld bc, $0202 ; $436b
	call CopyTextRect ; $436e
	pop de ; $4371
	ret ; $4372
	INCBIN "data/bank_00d/d_4373.bin" ; $4373, 48 bytes
Func_0d_43a3:
	ld hl, $d120 ; $43a3
	ld de, $9920 ; $43a6
	ld c, $0a ; $43a9
	call QueueVRAMCopy ; $43ab
	ld hl, $d520 ; $43ae
	ld de, $b920 ; $43b1
	ld c, $0a ; $43b4
	call QueueVRAMCopy ; $43b6
	ret ; $43b9
Func_0d_43ba:
	ld a, [wPointOutcome] ; $43ba
	cp a, $06 ; $43bd
	jr z, Label_0d_43de ; $43bf
	cp a, $09 ; $43c1
	jr z, Label_0d_43de ; $43c3
	cp a, $0b ; $43c5
	jr z, Label_0d_43de ; $43c7
	ld a, [wPointOutcome] ; $43c9
	add a, $00 ; $43cc
	farcall FarPtr_09_12 ; $43ce
	ld a, $1e ; $43d1
	farcall FarPtr_StepMatchFrames ; $43d3
	farcall FarPtr_09_16 ; $43d6
	ld a, $0a ; $43d9
	farcall FarPtr_StepMatchFrames ; $43db
Label_0d_43de:
	ret ; $43de
DetermineMinigamePointResult:
	ld a, [$c7bc] ; $43df
	and a, a ; $43e2
	jr nz, Label_0d_43ee ; $43e3
	ld a, [wPointOutcome] ; $43e5
	cp a, $0b ; $43e8
	jr z, Label_0d_43f6 ; $43ea
	jr Label_0d_440a ; $43ec
Label_0d_43ee:
	call Func_0d_41ee ; $43ee
	and a, a ; $43f1
	jr nz, Label_0d_4402 ; $43f2
	jr Label_0d_440a ; $43f4
Label_0d_43f6:
	ld a, $01 ; $43f6
	ld [wPointWinLoseFlag], a ; $43f8
	ld a, [wMinigameLevel] ; $43fb
	add a, $12 ; $43fe
	ld d, a ; $4400
	ret ; $4401
Label_0d_4402:
	ld a, $01 ; $4402
	ld [wPointWinLoseFlag], a ; $4404
	ld d, $16 ; $4407
	ret ; $4409
Label_0d_440a:
	ld a, $ff ; $440a
	ld [wPointWinLoseFlag], a ; $440c
	ld d, $17 ; $440f
	ret ; $4411
ShowMinigamePointResult:
	ld a, [wPointWinLoseFlag] ; $4412
	add a, a ; $4415
	jr c, Label_0d_441c ; $4416
	sound $09 ; $4418
	jr Label_0d_441e ; $441a
Label_0d_441c:
	sound $0a ; $441c
Label_0d_441e:
	farcall FarPtr_StepMatchFrame ; $441e
	ld a, d ; $4421
	farcall FarPtr_09_12 ; $4422
	ld a, $0a ; $4425
	farcall FarPtr_StepMatchFrames ; $4427
	ld a, $2d ; $442a
	farcall FarPtr_08_42 ; $442c
	farcall FarPtr_08_6a ; $442f
	farcall FarPtr_09_16 ; $4432
	ld a, $0f ; $4435
	farcall FarPtr_StepMatchFrames ; $4437
	ld a, $80 ; $443a
	ld [$c4c3], a ; $443c
	ret ; $443f
ClearMinigameActors:
	wram_bank $04 ; $4440
	ld hl, $dc00 ; $4446
	ld c, $07 ; $4449
	call ClearMemory16 ; $444b
	ret ; $444e
SetMinigameActorHandler:
	wram_bank $04 ; $444f
	ld hl, $000e ; $4455
	add hl, bc ; $4458
	ld a, e ; $4459
	ld [hl+], a ; $445a
	ld [hl], d ; $445b
	ld hl, $0000 ; $445c
	add hl, bc ; $445f
	set 0, [hl] ; $4460
	set 1, [hl] ; $4462
	ret ; $4464
Func_0d_4465:
	wram_bank $04 ; $4465
	push de ; $446b
	push hl ; $446c
	push hl ; $446d
	ld hl, $0008 ; $446e
	add hl, bc ; $4471
	ld a, e ; $4472
	ld [hl+], a ; $4473
	ld [hl], d ; $4474
	pop de ; $4475
	ld hl, $0006 ; $4476
	add hl, bc ; $4479
	ld a, e ; $447a
	ld [hl+], a ; $447b
	ld [hl], d ; $447c
	pop hl ; $447d
	pop de ; $447e
	push bc ; $447f
	ld bc, $0000 ; $4480
	farcall FarPtr_08_44 ; $4483
	ld e, c ; $4486
	ld d, b ; $4487
	pop bc ; $4488
	push hl ; $4489
	ld hl, $000c ; $448a
	add hl, bc ; $448d
	ld a, e ; $448e
	ld [hl+], a ; $448f
	ld [hl], d ; $4490
	pop de ; $4491
	ld hl, $000a ; $4492
	add hl, bc ; $4495
	ld a, e ; $4496
	ld [hl+], a ; $4497
	ld [hl], d ; $4498
	ret ; $4499
Func_0d_449a:
	ld c, l ; $449a
	ld b, h ; $449b
	ld hl, $dc76 ; $449c
	ld a, c ; $449f
	ld [hl+], a ; $44a0
	ld a, b ; $44a1
	ld [hl+], a ; $44a2
	ld a, e ; $44a3
	ld [hl+], a ; $44a4
	ld a, d ; $44a5
	ld [hl+], a ; $44a6
	ld l, c ; $44a7
	ld h, b ; $44a8
	ld bc, $0000 ; $44a9
	farcall FarPtr_08_44 ; $44ac
	ld e, l ; $44af
	ld d, h ; $44b0
	ld hl, $dc7a ; $44b1
	ld a, e ; $44b4
	ld [hl+], a ; $44b5
	ld a, d ; $44b6
	ld [hl+], a ; $44b7
	ld a, c ; $44b8
	ld [hl+], a ; $44b9
	ld a, b ; $44ba
	ld [hl+], a ; $44bb
	ret ; $44bc
UpdateMinigameActors:
	wram_bank $04 ; $44bd
	ld hl, $dc00 ; $44c3
	ld c, $07 ; $44c6
Label_0d_44c8:
	call UpdateMinigameActor ; $44c8
	ld de, $0010 ; $44cb
	add hl, de ; $44ce
	dec c ; $44cf
	jr nz, Label_0d_44c8 ; $44d0
	ret ; $44d2
UpdateMinigameActor:
	bit 0, [hl] ; $44d3
	ret z ; $44d5
	push af ; $44d6
	push bc ; $44d7
	push de ; $44d8
	push hl ; $44d9
	push hl ; $44da
	ld de, $dc70 ; $44db
	ld c, $01 ; $44de
	call CopyMemoryFast ; $44e0
	ld hl, $dc7e ; $44e3
	ld a, [hl+] ; $44e6
	ld h, [hl] ; $44e7
	ld l, a ; $44e8
	call JumpToHL ; $44e9
	pop de ; $44ec
	ld hl, $dc70 ; $44ed
	ld c, $01 ; $44f0
	call CopyMemoryFast ; $44f2
	pop hl ; $44f5
	pop de ; $44f6
	pop bc ; $44f7
	pop af ; $44f8
	ret ; $44f9
	INCBIN "data/bank_00d/d_44fa.bin" ; $44fa, 16 bytes
	ld a, $01 ; $450a
	ld [$c7b8], a ; $450c
	ld a, $00 ; $450f
	ld [wMinigameLevel], a ; $4511
	ret ; $4514
	ld l, $45 ; $4515
	ld [hl-], a ; $4517
	ld b, l ; $4518
	ld [hl], $45 ; $4519
	dec h ; $451b
	ld b, l ; $451c
	ld b, d ; $451d
	ld b, l ; $451e
	ld a, $45 ; $451f
	ld a, [hl-] ; $4521
	ld b, l ; $4522
	xor a, [hl] ; $4523
	inc bc ; $4524
	ld a, $01 ; $4525
	ld [$c785], a ; $4527
	call Func_0d_4678 ; $452a
	ret ; $452d
	INCBIN "data/bank_00d/d_452e.bin" ; $452e, 330 bytes
Func_0d_4678:
	call InitMinigameScore ; $4678
	ld hl, $0000 ; $467b
	ld de, $fe00 ; $467e
	call Func_0d_493a ; $4681
	ld de, $fb20 ; $4684
	ld hl, $c486 ; $4687
	ld a, e ; $468a
	ld [hl+], a ; $468b
	ld [hl], d ; $468c
	ld de, $fe50 ; $468d
	ld hl, $c484 ; $4690
	ld a, e ; $4693
	ld [hl+], a ; $4694
	ld [hl], d ; $4695
	wram_bank $04 ; $4696
	ld hl, $0000 ; $469c
	ld de, $0480 ; $469f
	farcall FarPtr_SetCharPosAndTarget ; $46a2
	ld a, $05 ; $46a5
	farcall FarPtr_SetCharState ; $46a7
	wram_bank $05 ; $46aa
	ld a, [$c785] ; $46b0
	call Func_0d_4926 ; $46b3
	farcall FarPtr_SetCharPosAndTarget ; $46b6
	ld a, $06 ; $46b9
	farcall FarPtr_SetCharState ; $46bb
	ld a, $04 ; $46be
	ld [$df6a], a ; $46c0
	xor a, a ; $46c3
	ld [$c7a7], a ; $46c4
	ld a, [$df78] ; $46c7
	cp a, $15 ; $46ca
	jr nz, Label_0d_46d3 ; $46cc
	ld a, $01 ; $46ce
	ld [$c7a7], a ; $46d0
Label_0d_46d3:
	call PlayMinigameCountdown ; $46d3
	ret ; $46d6
Func_0d_46d7:
	ld de, $8403 ; $46d7
	call DrawMinigameScore ; $46da
	ld a, [$c7a7] ; $46dd
	and a, a ; $46e0
	jr z, Label_0d_46f6 ; $46e1
	ldh a, [hWramBank] ; $46e3
	push af ; $46e5
	wram_bank $05 ; $46e6
	ld hl, $df81 ; $46ec
	res 5, [hl] ; $46ef
	pop af ; $46f1
	wram_bank ; $46f2
Label_0d_46f6:
	ret ; $46f6
Func_0d_46f7:
	ld b, $19 ; $46f7
	ld hl, $c780 ; $46f9
	ld a, [hl+] ; $46fc
	ld h, [hl] ; $46fd
	ld l, a ; $46fe
	ld a, h ; $46ff
	and a, a ; $4700
	jr nz, Label_0d_470b ; $4701
	xor a, a ; $4703
	ld h, a ; $4704
	ld e, $0a ; $4705
	call DivAHLByE ; $4707
	ld b, l ; $470a
Label_0d_470b:
	ld a, b ; $470b
	ld [$c784], a ; $470c
	ldh a, [hWramBank] ; $470f
	push af ; $4711
	wram_bank $05 ; $4712
	ld d, $05 ; $4718
	farcall FarPtr_SetCharAnimation ; $471a
	pop af ; $471d
	wram_bank ; $471e
	ld a, [$c7a7] ; $4722
	and a, a ; $4725
	jr z, Label_0d_472d ; $4726
	ld a, $0f ; $4728
	farcall FarPtr_StepMatchFrames ; $472a
Label_0d_472d:
	ld hl, $c780 ; $472d
	ld a, [hl+] ; $4730
	ld d, [hl] ; $4731
	ld e, a ; $4732
	inc de ; $4733
	ld hl, $c780 ; $4734
	ld a, e ; $4737
	ld [hl+], a ; $4738
	ld [hl], d ; $4739
	call LaunchBall ; $473a
	ld a, [$c785] ; $473d
	ld l, a ; $4740
	ld h, $00 ; $4741
	ld de, $0003 ; $4743
	call DivHLByDE ; $4746
	ld a, l ; $4749
	ld [$c786], a ; $474a
	call Func_0d_48b6 ; $474d
	ret ; $4750
Func_0d_4751:
	farcall FarPtr_ResolvePointWinner ; $4751
	add a, a ; $4754
	jr c, Func_0d_475d ; $4755
	ld de, $0001 ; $4757
	call AddToMinigameScore ; $475a
Func_0d_475d:
	ldh a, [hWramBank] ; $475d
	push af ; $475f
	wram_bank $04 ; $4760
	ld a, $05 ; $4766
	farcall FarPtr_SetCharState ; $4768
	pop af ; $476b
	wram_bank ; $476c
	call Func_0d_43ba ; $4770
	farcall FarPtr_ResolvePointWinner ; $4773
	add a, a ; $4776
	jr c, Label_0d_479b ; $4777
	ld a, [$c784] ; $4779
	add a, a ; $477c
	add a, a ; $477d
	add a, $47 ; $477e
	ld l, a ; $4780
	adc a, $45 ; $4781
	sub a, l ; $4783
	ld h, a ; $4784
	ld a, [hl] ; $4785
	add a, $ae ; $4786
	ld l, a ; $4788
	adc a, $45 ; $4789
	sub a, l ; $478b
	ld h, a ; $478c
	ld a, [hl] ; $478d
	farcall FarPtr_StepMatchFrames ; $478e
	call IsMinigameTargetReached ; $4791
	and a, a ; $4794
	ret z ; $4795
	ld a, $0b ; $4796
	ld [wPointOutcome], a ; $4798
Label_0d_479b:
	call DetermineMinigamePointResult ; $479b
	push de ; $479e
	ldh a, [hWramBank] ; $479f
	push af ; $47a1
	wram_bank $04 ; $47a2
	farcall FarPtr_CharPointEndReaction ; $47a8
	wram_bank $05 ; $47ab
	farcall FarPtr_CharPointEndReaction ; $47b1
	pop af ; $47b4
	wram_bank ; $47b5
	pop de ; $47b9
	call ShowMinigamePointResult ; $47ba
	ret ; $47bd
Func_0d_47be:
	xor a, a ; $47be
	ld [$c4c9], a ; $47bf
	ret ; $47c2
Func_0d_47c3:
	ld a, [wPointOutcome] ; $47c3
	and a, a ; $47c6
	jr nz, Label_0d_47e1 ; $47c7
	ld a, [wRallyLength] ; $47c9
	cp a, $04 ; $47cc
	jr nz, Label_0d_47e1 ; $47ce
	ld a, [$c4b2] ; $47d0
	cp a, $01 ; $47d3
	jr nz, Label_0d_47e1 ; $47d5
	ld a, $06 ; $47d7
	ld [wPointOutcome], a ; $47d9
	ld a, $01 ; $47dc
	ld [$c4d9], a ; $47de
Label_0d_47e1:
	ret ; $47e1
Func_0d_47e2:
	ld a, [wRallyLength] ; $47e2
	cp a, $03 ; $47e5
	jr nz, Label_0d_47fc ; $47e7
	ldh a, [hWramBank] ; $47e9
	push af ; $47eb
	wram_bank $05 ; $47ec
	ld a, $28 ; $47f2
	ld [$df10], a ; $47f4
	pop af ; $47f7
	wram_bank ; $47f8
Label_0d_47fc:
	ret ; $47fc
LaunchBall:
	ld a, $01 ; $47fd
	ld [wBallSpriteEnabled], a ; $47ff
	ld [wBallShadowEnabled], a ; $4802
	ld [wBallTrailEnabled], a ; $4805
	ld a, $02 ; $4808
	ld [wRallyLength], a ; $480a
	ld a, $02 ; $480d
	ld [$c4b0], a ; $480f
	ldh a, [hWramBank] ; $4812
	push af ; $4814
	wram_bank $05 ; $4815
	ld a, $20 ; $481b
	ld [$df4b], a ; $481d
	ld a, [$c784] ; $4820
	add a, a ; $4823
	add a, a ; $4824
	add a, $48 ; $4825
	ld l, a ; $4827
	adc a, $45 ; $4828
	sub a, l ; $482a
	ld h, a ; $482b
	ld a, [hl] ; $482c
	dec a ; $482d
	ld [$df6b], a ; $482e
	ld [$df6d], a ; $4831
	ld [$df6f], a ; $4834
	ld [$df6e], a ; $4837
	ld a, [$c784] ; $483a
	add a, a ; $483d
	add a, a ; $483e
	add a, $46 ; $483f
	ld l, a ; $4841
	adc a, $45 ; $4842
	sub a, l ; $4844
	ld h, a ; $4845
	ld a, [hl] ; $4846
	add a, a ; $4847
	add a, a ; $4848
	add a, a ; $4849
	add a, a ; $484a
	add a, $b3 ; $484b
	ld l, a ; $484d
	adc a, $45 ; $484e
	sub a, l ; $4850
	ld h, a ; $4851
	farcall FarPtr_AdvanceMatchRng ; $4852
	and a, $0f ; $4855
	add a, l ; $4857
	ld l, a ; $4858
	jr nc, Label_0d_485c ; $4859
	inc h ; $485b
Label_0d_485c:
	ld a, [hl] ; $485c
	swap a ; $485d
	and a, $0f ; $485f
	ld [$df16], a ; $4861
	ld a, [hl] ; $4864
	and a, $0f ; $4865
	ld [$df17], a ; $4867
	farcall FarPtr_08_68 ; $486a
	ld a, [$c786] ; $486d
	add a, $75 ; $4870
	ld l, a ; $4872
	adc a, $46 ; $4873
	sub a, l ; $4875
	ld h, a ; $4876
	ld a, [hl] ; $4877
	ld [$df69], a ; $4878
	ld a, [$c786] ; $487b
	add a, a ; $487e
	add a, $6f ; $487f
	ld l, a ; $4881
	adc a, $46 ; $4882
	sub a, l ; $4884
	ld h, a ; $4885
	ld a, [hl+] ; $4886
	ld b, [hl] ; $4887
	ld c, a ; $4888
	ld hl, $df04 ; $4889
	ld a, [hl+] ; $488c
	ld d, [hl] ; $488d
	ld e, a ; $488e
	ld hl, $df01 ; $488f
	ld a, [hl+] ; $4892
	ld h, [hl] ; $4893
	ld l, a ; $4894
	farcall FarPtr_08_62 ; $4895
	farcall FarPtr_AdvanceMatchRng ; $4898
	and a, $07 ; $489b
	add a, $43 ; $489d
	ld l, a ; $489f
	adc a, $46 ; $48a0
	sub a, l ; $48a2
	ld h, a ; $48a3
	ld a, [hl] ; $48a4
	ld [$df4a], a ; $48a5
	ld hl, $073c ; $48a8
	call FarCallVector ; $48ab
	sound $76 ; $48ae
	pop af ; $48b0
	wram_bank ; $48b1
	ret ; $48b5
Func_0d_48b6:
	ldh a, [hWramBank] ; $48b6
	push af ; $48b8
	wram_bank $05 ; $48b9
	ld a, [$c785] ; $48bf
	call Func_0d_4926 ; $48c2
	farcall FarPtr_SetCharTarget ; $48c5
	pop af ; $48c8
	wram_bank ; $48c9
	ret ; $48cd
PlayMinigameCountdown:
	wram_bank $04 ; $48ce
	xor a, a ; $48d4
	ld [$c4c2], a ; $48d5
	ld a, [wCurrentBGM] ; $48d8
	push af ; $48db
	sound $00 ; $48dc
	ld a, $14 ; $48de
	farcall FarPtr_StepMatchFrames ; $48e0
	ld a, $03 ; $48e3
Label_0d_48e5:
	push af ; $48e5
	ld b, $01 ; $48e6
	ld de, $8200 ; $48e8
	farcall FarPtr_09_28 ; $48eb
	ld a, [$c492] ; $48ee
	and a, a ; $48f1
	jr nz, Label_0d_48f6 ; $48f2
	sound $74 ; $48f4
Label_0d_48f6:
	ld a, $11 ; $48f6
	farcall FarPtr_09_14 ; $48f8
	ld a, $28 ; $48fb
	farcall FarPtr_StepMatchFrames ; $48fd
	pop af ; $4900
	dec a ; $4901
	jr nz, Label_0d_48e5 ; $4902
	ld a, [$c492] ; $4904
	and a, a ; $4907
	jr nz, Label_0d_490c ; $4908
	sound $75 ; $490a
Label_0d_490c:
	ld a, $10 ; $490c
	farcall FarPtr_09_12 ; $490e
	ld a, $28 ; $4911
	farcall FarPtr_StepMatchFrames ; $4913
	farcall FarPtr_09_16 ; $4916
	pop af ; $4919
	ld b, a ; $491a
	ld a, [$c492] ; $491b
	and a, a ; $491e
	jr nz, Label_0d_4925 ; $491f
	ld a, b ; $4921
	call PlaySoundManaged ; $4922
Label_0d_4925:
	ret ; $4925
Func_0d_4926:
	add a, a ; $4926
	add a, a ; $4927
	add a, $4b ; $4928
	ld l, a ; $492a
	adc a, $46 ; $492b
	sub a, l ; $492d
	ld h, a ; $492e
	ld a, [hl+] ; $492f
	ld c, a ; $4930
	ld a, [hl+] ; $4931
	ld b, a ; $4932
	ld a, [hl+] ; $4933
	ld e, a ; $4934
	ld a, [hl+] ; $4935
	ld d, a ; $4936
	ld l, c ; $4937
	ld h, b ; $4938
	ret ; $4939
Func_0d_493a:
	ld c, l ; $493a
	ld b, h ; $493b
	ld hl, $c440 ; $493c
	ld a, c ; $493f
	ld [hl+], a ; $4940
	ld [hl], b ; $4941
	ld hl, $c444 ; $4942
	ld a, c ; $4945
	ld [hl+], a ; $4946
	ld [hl], b ; $4947
	ld hl, $c442 ; $4948
	ld a, e ; $494b
	ld [hl+], a ; $494c
	ld [hl], d ; $494d
	ld hl, $c446 ; $494e
	ld a, e ; $4951
	ld [hl+], a ; $4952
	ld [hl], d ; $4953
	xor a, a ; $4954
	ld [$c4c9], a ; $4955
	ret ; $4958
	INCBIN "data/bank_00d/d_4959.bin" ; $4959, 16 bytes
	ld a, $01 ; $4969
	ld [$c7b8], a ; $496b
	ld a, $01 ; $496e
	ld [wMinigameLevel], a ; $4970
	ret ; $4973
	adc a, l ; $4974
	ld c, c ; $4975
	sub a, c ; $4976
	ld c, c ; $4977
	and a, [hl] ; $4978
	ld c, c ; $4979
	add a, h ; $497a
	ld c, c ; $497b
	or a, d ; $497c
	ld c, c ; $497d
	xor a, [hl] ; $497e
	ld c, c ; $497f
	xor a, d ; $4980
	ld c, c ; $4981
	xor a, [hl] ; $4982
	inc bc ; $4983
	ld a, $01 ; $4984
	ld [$c785], a ; $4986
	call Func_0d_4678 ; $4989
	ret ; $498c
	call Func_0d_46d7 ; $498d
	ret ; $4990
	farcall FarPtr_AdvanceMatchRng ; $4991
	and a, $01 ; $4994
	inc a ; $4996
	ld hl, $c785 ; $4997
	add a, [hl] ; $499a
	cp a, $03 ; $499b
	jr c, Label_0d_49a1 ; $499d
	sub a, $03 ; $499f
Label_0d_49a1:
	ld [hl], a ; $49a1
	call Func_0d_46f7 ; $49a2
	ret ; $49a5
	call Func_0d_4751 ; $49a6
	ret ; $49a9
	call Func_0d_47be ; $49aa
	ret ; $49ad
	call Func_0d_47c3 ; $49ae
	ret ; $49b1
	call Func_0d_47e2 ; $49b2
	ret ; $49b5
	dec d ; $49b6
	ld a, [bc] ; $49b7
	ld [bc], a ; $49b8
	ld b, $14 ; $49b9
	ld e, $00 ; $49bb
	add a, b ; $49bd
	pop de ; $49be
	ld c, c ; $49bf
	cp a, l ; $49c0
	ld b, b ; $49c1
	add a, $49 ; $49c2
	nop ; $49c4
	nop ; $49c5
	ld a, $01 ; $49c6
	ld [$c7b8], a ; $49c8
	ld a, $02 ; $49cb
	ld [wMinigameLevel], a ; $49cd
	ret ; $49d0
	ld [$ee49], a ; $49d1
	ld c, c ; $49d4
	inc bc ; $49d5
	ld c, d ; $49d6
	pop hl ; $49d7
	ld c, c ; $49d8
	rrca ; $49d9
	ld c, d ; $49da
	dec bc ; $49db
	ld c, d ; $49dc
	rlca ; $49dd
	ld c, d ; $49de
	xor a, [hl] ; $49df
	inc bc ; $49e0
	ld a, $04 ; $49e1
	ld [$c785], a ; $49e3
	call Func_0d_4678 ; $49e6
	ret ; $49e9
	call Func_0d_46d7 ; $49ea
	ret ; $49ed
	farcall FarPtr_AdvanceMatchRng ; $49ee
	and a, $03 ; $49f1
	inc a ; $49f3
	ld hl, $c785 ; $49f4
	add a, [hl] ; $49f7
	cp a, $06 ; $49f8
	jr c, Label_0d_49fe ; $49fa
	sub a, $06 ; $49fc
Label_0d_49fe:
	ld [hl], a ; $49fe
	call Func_0d_46f7 ; $49ff
	ret ; $4a02
	call Func_0d_4751 ; $4a03
	ret ; $4a06
	call Func_0d_47be ; $4a07
	ret ; $4a0a
	call Func_0d_47c3 ; $4a0b
	ret ; $4a0e
	call Func_0d_47e2 ; $4a0f
	ret ; $4a12
	dec d ; $4a13
	ld a, [bc] ; $4a14
	ld [bc], a ; $4a15
	ld b, $15 ; $4a16
	ld e, $00 ; $4a18
	add a, b ; $4a1a
	ld l, $4a ; $4a1b
	cp a, l ; $4a1d
	ld b, b ; $4a1e
	inc hl ; $4a1f
	ld c, d ; $4a20
	nop ; $4a21
	nop ; $4a22
	ld a, $01 ; $4a23
	ld [$c7b8], a ; $4a25
	ld a, $03 ; $4a28
	ld [wMinigameLevel], a ; $4a2a
	ret ; $4a2d
	ld b, a ; $4a2e
	ld c, d ; $4a2f
	ld c, e ; $4a30
	ld c, d ; $4a31
	ld h, b ; $4a32
	ld c, d ; $4a33
	ld a, $4a ; $4a34
	ld l, h ; $4a36
	ld c, d ; $4a37
	ld l, b ; $4a38
	ld c, d ; $4a39
	ld h, h ; $4a3a
	ld c, d ; $4a3b
	xor a, [hl] ; $4a3c
	inc bc ; $4a3d
	ld a, $04 ; $4a3e
	ld [$c785], a ; $4a40
	call Func_0d_4678 ; $4a43
	ret ; $4a46
	call Func_0d_46d7 ; $4a47
	ret ; $4a4a
	farcall FarPtr_AdvanceMatchRng ; $4a4b
	and a, $07 ; $4a4e
	inc a ; $4a50
	ld hl, $c785 ; $4a51
	add a, [hl] ; $4a54
	cp a, $09 ; $4a55
	jr c, Label_0d_4a5b ; $4a57
	sub a, $09 ; $4a59
Label_0d_4a5b:
	ld [hl], a ; $4a5b
	call Func_0d_46f7 ; $4a5c
	ret ; $4a5f
	call Func_0d_4751 ; $4a60
	ret ; $4a63
	call Func_0d_47be ; $4a64
	ret ; $4a67
	call Func_0d_47c3 ; $4a68
	ret ; $4a6b
	call Func_0d_47e2 ; $4a6c
	ret ; $4a6f
	nop ; $4a70
	dec bc ; $4a71
	ld bc, $1607 ; $4a72
	rra ; $4a75
	nop ; $4a76
	add a, b ; $4a77
	sub a, e ; $4a78
	ld c, d ; $4a79
	or a, h ; $4a7a
	ld b, b ; $4a7b
	add a, b ; $4a7c
	ld c, d ; $4a7d
	nop ; $4a7e
	nop ; $4a7f
	ld a, $01 ; $4a80
	ld [$c7b9], a ; $4a82
	ld a, $00 ; $4a85
	ld [wMinigameLevel], a ; $4a87
	farcall FarPtr_InitMinigameTargets ; $4a8a
	ld a, $00 ; $4a8d
	farcall FarPtr_SpawnMinigameTargetFormation ; $4a8f
	ret ; $4a92
	INCBIN "data/bank_00d/d_4a93.bin" ; $4a93, 16 bytes
	call Func_0d_4abb ; $4aa3
	ret ; $4aa6
	call Func_0d_4b01 ; $4aa7
	ret ; $4aaa
	call Func_0d_4b29 ; $4aab
	ret ; $4aae
	call Func_0d_4b59 ; $4aaf
	ret ; $4ab2
	call Func_0d_4bc7 ; $4ab3
	ret ; $4ab6
	call Func_0d_4bc8 ; $4ab7
	ret ; $4aba
Func_0d_4abb:
	ld a, [wPointWinLoseFlag] ; $4abb
	and a, a ; $4abe
	jr nz, Label_0d_4ac7 ; $4abf
	ld de, $8484 ; $4ac1
	call DrawMinigameScore ; $4ac4
Label_0d_4ac7:
	ldh a, [hWramBank] ; $4ac7
	push af ; $4ac9
	wram_bank $04 ; $4aca
	ld hl, $dd0c ; $4ad0
	ld de, $de14 ; $4ad3
	call Func_0d_4af1 ; $4ad6
	ld hl, $dd06 ; $4ad9
	ld de, $de18 ; $4adc
	call Func_0d_4af1 ; $4adf
	ld hl, $dd00 ; $4ae2
	ld de, $de1c ; $4ae5
	call Func_0d_4af1 ; $4ae8
	pop af ; $4aeb
	wram_bank ; $4aec
	ret ; $4af0
Func_0d_4af1:
	inc hl ; $4af1
	inc hl ; $4af2
	ld a, [hl+] ; $4af3
	ld b, [hl] ; $4af4
	ld c, a ; $4af5
	ld hl, $fe60 ; $4af6
	add hl, bc ; $4af9
	bit 7, h ; $4afa
	ret z ; $4afc
	ld a, $ff ; $4afd
	ld [de], a ; $4aff
	ret ; $4b00
Func_0d_4b01:
	call InitMinigameScore ; $4b01
	xor a, a ; $4b04
	ld [wStandingShadowsEnabled], a ; $4b05
	ld de, $0000 ; $4b08
	ld hl, $c488 ; $4b0b
	ld a, e ; $4b0e
	ld [hl+], a ; $4b0f
	ld [hl], d ; $4b10
	ldh a, [hWramBank] ; $4b11
	push af ; $4b13
	wram_bank $04 ; $4b14
	ld hl, $0000 ; $4b1a
	ld de, $04e0 ; $4b1d
	farcall FarPtr_SetCharPosAndTarget ; $4b20
	pop af ; $4b23
	wram_bank ; $4b24
	ret ; $4b28
Func_0d_4b29:
	ldh a, [hWramBank] ; $4b29
	push af ; $4b2b
	wram_bank $04 ; $4b2c
	ld a, $05 ; $4b32
	farcall FarPtr_SetCharState ; $4b34
	pop af ; $4b37
	wram_bank ; $4b38
	call Func_0d_43ba ; $4b3c
	call DetermineMinigamePointResult ; $4b3f
	push de ; $4b42
	ldh a, [hWramBank] ; $4b43
	push af ; $4b45
	wram_bank $04 ; $4b46
	farcall FarPtr_CharPointEndReaction ; $4b4c
	pop af ; $4b4f
	wram_bank ; $4b50
	pop de ; $4b54
	call ShowMinigamePointResult ; $4b55
	ret ; $4b58
Func_0d_4b59:
	ld a, [wPointOutcome] ; $4b59
	and a, a ; $4b5c
	jr nz, Func_0d_4b70 ; $4b5d
	ld de, $0001 ; $4b5f
	call AddToMinigameScore ; $4b62
	call IsMinigameTargetReached ; $4b65
	and a, a ; $4b68
	jr z, Func_0d_4b70 ; $4b69
	ld a, $0b ; $4b6b
	ld [wPointOutcome], a ; $4b6d
Func_0d_4b70:
	ld a, $01 ; $4b70
	ld [$c4c9], a ; $4b72
	farcall FarPtr_StartBounceEffect ; $4b75
	xor a, a ; $4b78
	ld [$c4b2], a ; $4b79
	ld hl, $c4be ; $4b7c
	ld a, [hl] ; $4b7f
	xor a, $02 ; $4b80
	ld [hl], a ; $4b82
	ld hl, $c404 ; $4b83
	ld a, [hl] ; $4b86
	cpl ; $4b87
	ld [hl+], a ; $4b88
	ld a, [hl] ; $4b89
	cpl ; $4b8a
	ld [hl+], a ; $4b8b
	ld a, [hl] ; $4b8c
	cpl ; $4b8d
	ld [hl+], a ; $4b8e
	ld a, [hl] ; $4b8f
	cpl ; $4b90
	ld [hl+], a ; $4b91
	ld hl, $c423 ; $4b92
	ld a, [hl] ; $4b95
	cpl ; $4b96
	ld [hl+], a ; $4b97
	ld a, [hl] ; $4b98
	cpl ; $4b99
	ld [hl+], a ; $4b9a
	ld a, [hl] ; $4b9b
	cpl ; $4b9c
	ld [hl+], a ; $4b9d
	ld hl, $c423 ; $4b9e
	ld b, $e6 ; $4ba1
	farcall FarPtr_08_6e ; $4ba3
	ld hl, $c423 ; $4ba6
	ld [hl+], a ; $4ba9
	ld a, e ; $4baa
	ld [hl+], a ; $4bab
	ld a, d ; $4bac
	ld [hl+], a ; $4bad
	ld a, [wPointOutcome] ; $4bae
	and a, a ; $4bb1
	ret nz ; $4bb2
	ldh a, [hWramBank] ; $4bb3
	push af ; $4bb5
	wram_bank $04 ; $4bb6
	ld a, $01 ; $4bbc
	farcall FarPtr_SetCharState ; $4bbe
	pop af ; $4bc1
	wram_bank ; $4bc2
	ret ; $4bc6
Func_0d_4bc7:
	ret ; $4bc7
Func_0d_4bc8:
	xor a, a ; $4bc8
	ld [$c4da], a ; $4bc9
	ld a, [wRallyLength] ; $4bcc
	cp a, $01 ; $4bcf
	ret nz ; $4bd1
	ld de, $fb20 ; $4bd2
	ld hl, $c486 ; $4bd5
	ld a, e ; $4bd8
	ld [hl+], a ; $4bd9
	ld [hl], d ; $4bda
	ld de, $fe50 ; $4bdb
	ld hl, $c484 ; $4bde
	ld a, e ; $4be1
	ld [hl+], a ; $4be2
	ld [hl], d ; $4be3
	ld a, $02 ; $4be4
	ld [wRallyLength], a ; $4be6
	ret ; $4be9
DrawMinigameScore:
	ld hl, wMinigamesCurrentScore ; $4bea
	ld a, [hl+] ; $4bed
	ld h, [hl] ; $4bee
	ld l, a ; $4bef
	ld b, $01 ; $4bf0
	ld a, $04 ; $4bf2
	farcall FarPtr_DrawNumberWithSprites ; $4bf4
	ret ; $4bf7
	INCBIN "data/bank_00d/d_4bf8.bin" ; $4bf8, 16 bytes
	ld a, $01 ; $4c08
	ld [$c7b9], a ; $4c0a
	ld a, $01 ; $4c0d
	ld [wMinigameLevel], a ; $4c0f
	farcall FarPtr_InitMinigameTargets ; $4c12
	ld a, $01 ; $4c15
	farcall FarPtr_SpawnMinigameTargetFormation ; $4c17
	ret ; $4c1a
	dec hl ; $4c1b
	ld c, h ; $4c1c
	cpl ; $4c1d
	ld c, h ; $4c1e
	inc sp ; $4c1f
	ld c, h ; $4c20
	xor a, [hl] ; $4c21
	inc bc ; $4c22
	ccf ; $4c23
	ld c, h ; $4c24
	dec sp ; $4c25
	ld c, h ; $4c26
	scf ; $4c27
	ld c, h ; $4c28
	xor a, [hl] ; $4c29
	inc bc ; $4c2a
	call Func_0d_4abb ; $4c2b
	ret ; $4c2e
	call Func_0d_4b01 ; $4c2f
	ret ; $4c32
	call Func_0d_4b29 ; $4c33
	ret ; $4c36
	call Func_0d_4b59 ; $4c37
	ret ; $4c3a
	call Func_0d_4bc7 ; $4c3b
	ret ; $4c3e
	call Func_0d_4bc8 ; $4c3f
	ret ; $4c42
	nop ; $4c43
	dec bc ; $4c44
	ld bc, $1807 ; $4c45
	rra ; $4c48
	nop ; $4c49
	add a, b ; $4c4a
	ld h, [hl] ; $4c4b
	ld c, h ; $4c4c
	or a, h ; $4c4d
	ld b, b ; $4c4e
	ld d, e ; $4c4f
	ld c, h ; $4c50
	nop ; $4c51
	nop ; $4c52
	ld a, $01 ; $4c53
	ld [$c7b9], a ; $4c55
	ld a, $02 ; $4c58
	ld [wMinigameLevel], a ; $4c5a
	farcall FarPtr_InitMinigameTargets ; $4c5d
	ld a, $02 ; $4c60
	farcall FarPtr_SpawnMinigameTargetFormation ; $4c62
	ret ; $4c65
	halt ; $4c66
	ld c, h ; $4c67
	ld a, d ; $4c68
	ld c, h ; $4c69
	ld a, [hl] ; $4c6a
	ld c, h ; $4c6b
	xor a, [hl] ; $4c6c
	inc bc ; $4c6d
	adc a, d ; $4c6e
	ld c, h ; $4c6f
	add a, [hl] ; $4c70
	ld c, h ; $4c71
	add a, d ; $4c72
	ld c, h ; $4c73
	xor a, [hl] ; $4c74
	inc bc ; $4c75
	call Func_0d_4abb ; $4c76
	ret ; $4c79
	call Func_0d_4b01 ; $4c7a
	ret ; $4c7d
	call Func_0d_4b29 ; $4c7e
	ret ; $4c81
	call Func_0d_4b59 ; $4c82
	ret ; $4c85
	call Func_0d_4bc7 ; $4c86
	ret ; $4c89
	call Func_0d_4bc8 ; $4c8a
	ret ; $4c8d
	nop ; $4c8e
	dec bc ; $4c8f
	ld bc, $1907 ; $4c90
	rra ; $4c93
	nop ; $4c94
	add a, b ; $4c95
	or a, c ; $4c96
	ld c, h ; $4c97
	or a, h ; $4c98
	ld b, b ; $4c99
	sbc a, [hl] ; $4c9a
	ld c, h ; $4c9b
	nop ; $4c9c
	nop ; $4c9d
	ld a, $01 ; $4c9e
	ld [$c7b9], a ; $4ca0
	ld a, $03 ; $4ca3
	ld [wMinigameLevel], a ; $4ca5
	farcall FarPtr_InitMinigameTargets ; $4ca8
	ld a, $03 ; $4cab
	farcall FarPtr_SpawnMinigameTargetFormation ; $4cad
	ret ; $4cb0
	pop bc ; $4cb1
	ld c, h ; $4cb2
	push bc ; $4cb3
	ld c, h ; $4cb4
	ret ; $4cb5
	ld c, h ; $4cb6
	xor a, [hl] ; $4cb7
	inc bc ; $4cb8
	push de ; $4cb9
	ld c, h ; $4cba
	pop de ; $4cbb
	ld c, h ; $4cbc
	call $ae4c ; $4cbd
	inc bc ; $4cc0
	call Func_0d_4abb ; $4cc1
	ret ; $4cc4
	call Func_0d_4b01 ; $4cc5
	ret ; $4cc8
	call Func_0d_4b29 ; $4cc9
	ret ; $4ccc
	call Func_0d_4b59 ; $4ccd
	ret ; $4cd0
	call Func_0d_4bc7 ; $4cd1
	ret ; $4cd4
	call Func_0d_4bc8 ; $4cd5
	ret ; $4cd8
	INCBIN "data/bank_00d/d_4cd9.bin" ; $4cd9, 32 bytes
	ld [de], a ; $4cf9
	ld c, l ; $4cfa
	ld d, $4d ; $4cfb
	dec hl ; $4cfd
	ld c, l ; $4cfe
	add hl, bc ; $4cff
	ld c, l ; $4d00
	scf ; $4d01
	ld c, l ; $4d02
	inc sp ; $4d03
	ld c, l ; $4d04
	cpl ; $4d05
	ld c, l ; $4d06
	xor a, [hl] ; $4d07
	inc bc ; $4d08
	ld a, $04 ; $4d09
	ld [$c785], a ; $4d0b
	call Func_0d_4678 ; $4d0e
	ret ; $4d11
	call Func_0d_46d7 ; $4d12
	ret ; $4d15
	farcall FarPtr_AdvanceMatchRng ; $4d16
	and a, $07 ; $4d19
	inc a ; $4d1b
	ld hl, $c785 ; $4d1c
	add a, [hl] ; $4d1f
	cp a, $09 ; $4d20
	jr c, Label_0d_4d26 ; $4d22
	sub a, $09 ; $4d24
Label_0d_4d26:
	ld [hl], a ; $4d26
	call Func_0d_46f7 ; $4d27
	ret ; $4d2a
	call Func_0d_4751 ; $4d2b
	ret ; $4d2e
	call Func_0d_47be ; $4d2f
	ret ; $4d32
	call Func_0d_47c3 ; $4d33
	ret ; $4d36
	call Func_0d_47e2 ; $4d37
	ret ; $4d3a
	nop ; $4d3b
	dec bc ; $4d3c
	ld bc, $1b07 ; $4d3d
	rra ; $4d40
	nop ; $4d41
	add a, b ; $4d42
	ld h, e ; $4d43
	ld c, l ; $4d44
	or a, h ; $4d45
	ld b, b ; $4d46
	ld c, e ; $4d47
	ld c, l ; $4d48
	nop ; $4d49
	nop ; $4d4a
	ld a, $01 ; $4d4b
	ld [$c7bc], a ; $4d4d
	ld a, $01 ; $4d50
	ld [$c7b9], a ; $4d52
	ld a, $04 ; $4d55
	ld [wMinigameLevel], a ; $4d57
	farcall FarPtr_InitMinigameTargets ; $4d5a
	ld a, $04 ; $4d5d
	farcall FarPtr_SpawnMinigameTargetFormation ; $4d5f
	ret ; $4d62
	ld [hl], e ; $4d63
	ld c, l ; $4d64
	ld [hl], a ; $4d65
	ld c, l ; $4d66
	ld a, e ; $4d67
	ld c, l ; $4d68
	xor a, [hl] ; $4d69
	inc bc ; $4d6a
	add a, a ; $4d6b
	ld c, l ; $4d6c
	add a, e ; $4d6d
	ld c, l ; $4d6e
	ld a, a ; $4d6f
	ld c, l ; $4d70
	xor a, [hl] ; $4d71
	inc bc ; $4d72
	call Func_0d_4abb ; $4d73
	ret ; $4d76
	call Func_0d_4b01 ; $4d77
	ret ; $4d7a
	call Func_0d_4b29 ; $4d7b
	ret ; $4d7e
	call Func_0d_4b59 ; $4d7f
	ret ; $4d82
	call Func_0d_4bc7 ; $4d83
	ret ; $4d86
	call Func_0d_4bc8 ; $4d87
	ret ; $4d8a
	dec d ; $4d8b
	rrca ; $4d8c
	ld [bc], a ; $4d8d
	ld [$191f], sp ; $4d8e
	nop ; $4d91
	add hl, de ; $4d92
	xor a, l ; $4d93
	ld c, l ; $4d94
	cp a, l ; $4d95
	ld b, b ; $4d96
	sbc a, e ; $4d97
	ld c, l ; $4d98
	nop ; $4d99
	nop ; $4d9a
	ld a, $01 ; $4d9b
	ld [$c7b8], a ; $4d9d
	ld a, [wMinigameLevel] ; $4da0
	cp a, $02 ; $4da3
	jr nz, Label_0d_4dac ; $4da5
	ld a, $01 ; $4da7
	ld [$c7bc], a ; $4da9
Label_0d_4dac:
	ret ; $4dac
	; $4dad, 16 bytes (records:2)
	dw $4dcb ; record 0
	dw $4dd2 ; record 1
	dw $4dea ; record 2
	dw $4dbd ; record 3
	dw $4e18 ; record 4
	dw $4df2 ; record 5
	dw $4dee ; record 6
	dw $03ae ; record 7
	ld a, $01 ; $4dbd
	ld [$c785], a ; $4dbf
	call Func_0d_4678 ; $4dc2
	ld a, $01 ; $4dc5
	ld [wTargetZoneEnabled], a ; $4dc7
	ret ; $4dca
	call Func_0d_46d7 ; $4dcb
	call Func_0d_4e1c ; $4dce
	ret ; $4dd1
	call Func_0d_4e20 ; $4dd2
	farcall FarPtr_AdvanceMatchRng ; $4dd5
	and a, $01 ; $4dd8
	inc a ; $4dda
	ld hl, $c785 ; $4ddb
	add a, [hl] ; $4dde
	cp a, $03 ; $4ddf
	jr c, Label_0d_4de5 ; $4de1
	sub a, $03 ; $4de3
Label_0d_4de5:
	ld [hl], a ; $4de5
	call Func_0d_46f7 ; $4de6
	ret ; $4de9
	call Func_0d_475d ; $4dea
	ret ; $4ded
	call Func_0d_47be ; $4dee
	ret ; $4df1
	ld a, [wPointOutcome] ; $4df2
	and a, a ; $4df5
	ret nz ; $4df6
	call Func_0d_47c3 ; $4df7
	call Func_0d_4e80 ; $4dfa
	ld a, [wPointOutcome] ; $4dfd
	cp a, $06 ; $4e00
	ret nz ; $4e02
	call Func_0d_4e96 ; $4e03
	ld d, $00 ; $4e06
	ld e, a ; $4e08
	ld hl, $c782 ; $4e09
	ld a, e ; $4e0c
	ld [hl+], a ; $4e0d
	ld [hl], d ; $4e0e
	call AddToMinigameScore ; $4e0f
	call StartScorePopup ; $4e12
	sound $97 ; $4e15
	ret ; $4e17
	call Func_0d_47e2 ; $4e18
	ret ; $4e1b
Func_0d_4e1c:
	call UpdateScorePopup ; $4e1c
	ret ; $4e1f
Func_0d_4e20:
	ldh a, [hWramBank] ; $4e20
	push af ; $4e22
	wram_bank $02 ; $4e23
	ld a, [wMinigameLevel] ; $4e29
	add a, a ; $4e2c
	add a, $5a ; $4e2d
	ld l, a ; $4e2f
	adc a, $4e ; $4e30
	sub a, l ; $4e32
	ld h, a ; $4e33
	ld a, [hl+] ; $4e34
	ld h, [hl] ; $4e35
	ld l, a ; $4e36
	farcall FarPtr_AdvanceMatchRng ; $4e37
	and a, $0f ; $4e3a
	add a, l ; $4e3c
	ld l, a ; $4e3d
	jr nc, Label_0d_4e41 ; $4e3e
	inc h ; $4e40
Label_0d_4e41:
	ld a, [hl] ; $4e41
	ld [$c7a5], a ; $4e42
	ld a, [$c7a5] ; $4e45
	call Func_0d_5148 ; $4e48
	ld a, [$c7a5] ; $4e4b
	call Func_0d_50fa ; $4e4e
	call Func_0d_43a3 ; $4e51
	pop af ; $4e54
	wram_bank ; $4e55
	ret ; $4e59
	INCBIN "data/bank_00d/d_4e5a.bin" ; $4e5a, 38 bytes
Func_0d_4e80:
	ld a, [$c4b8] ; $4e80
	and a, $01 ; $4e83
	ret nz ; $4e85
	farcall FarPtr_IsBallInTargetZone ; $4e86
	and a, a ; $4e89
	ret nz ; $4e8a
	ld a, $05 ; $4e8b
	ld [wPointOutcome], a ; $4e8d
	ld a, $ff ; $4e90
	ld [$c4d9], a ; $4e92
	ret ; $4e95
Func_0d_4e96:
	ld hl, $4ec1 ; $4e96
Label_0d_4e99:
	ld a, [hl+] ; $4e99
	cp a, $ff ; $4e9a
	jr z, Label_0d_4ebe ; $4e9c
	ld e, a ; $4e9e
	ld a, [hl+] ; $4e9f
	ld d, a ; $4ea0
	ld a, [hl+] ; $4ea1
	ld c, a ; $4ea2
	ld a, [hl+] ; $4ea3
	ld b, a ; $4ea4
	ld a, [$c7a5] ; $4ea5
	cp a, e ; $4ea8
	jr nz, Label_0d_4e99 ; $4ea9
	ld a, [$c490] ; $4eab
	cp a, d ; $4eae
	jr nz, Label_0d_4e99 ; $4eaf
	ld a, c ; $4eb1
	cp a, $ff ; $4eb2
	jr z, Label_0d_4ebc ; $4eb4
	ld a, [$c4a0] ; $4eb6
	cp a, c ; $4eb9
	jr nz, Label_0d_4e99 ; $4eba
Label_0d_4ebc:
	ld a, b ; $4ebc
	ret ; $4ebd
Label_0d_4ebe:
	ld a, $01 ; $4ebe
	ret ; $4ec0
	INCBIN "data/bank_00d/d_4ec1.bin" ; $4ec1, 569 bytes
Func_0d_50fa:
	add a, a ; $50fa
	add a, $3a ; $50fb
	ld l, a ; $50fd
	adc a, $51 ; $50fe
	sub a, l ; $5100
	ld h, a ; $5101
	ld a, [hl+] ; $5102
	ld b, [hl] ; $5103
	ld c, a ; $5104
	ld hl, $5000 ; $5105
	add hl, bc ; $5108
	push hl ; $5109
	push hl ; $510a
	ld hl, $4f06 ; $510b
	add hl, bc ; $510e
	push hl ; $510f
	push hl ; $5110
	pop hl ; $5111
	ld de, $d92b ; $5112
	ld bc, $0a05 ; $5115
	call CopyTextRect ; $5118
	pop hl ; $511b
	ld de, $d12b ; $511c
	ld bc, $0a05 ; $511f
	call CopyTextRect ; $5122
	pop hl ; $5125
	ld de, $dd2b ; $5126
	ld bc, $0a05 ; $5129
	call CopyTextRect ; $512c
	pop hl ; $512f
	ld de, $d52b ; $5130
	ld bc, $0a05 ; $5133
	call CopyTextRect ; $5136
	ret ; $5139
	INCBIN "data/bank_00d/d_513a.bin" ; $513a, 14 bytes
Func_0d_5148:
	add a, a ; $5148
	add a, a ; $5149
	add a, a ; $514a
	add a, $5c ; $514b
	ld l, a ; $514d
	adc a, $51 ; $514e
	sub a, l ; $5150
	ld h, a ; $5151
	ld de, wTargetZoneX1 ; $5152
	ld bc, $0008 ; $5155
	call CopyMemoryBC ; $5158
	ret ; $515b
	INCBIN "data/bank_00d/d_515c.bin" ; $515c, 72 bytes
	ld a, $01 ; $51a4
	ld [$c7b8], a ; $51a6
	ld a, [wMinigameLevel] ; $51a9
	cp a, $02 ; $51ac
	jr nz, Label_0d_51b5 ; $51ae
	ld a, $01 ; $51b0
	ld [$c7bc], a ; $51b2
Label_0d_51b5:
	ret ; $51b5
	; $51b6, 16 bytes (records:2)
	dw $51d2 ; record 0
	dw $51dd ; record 1
	dw $51f5 ; record 2
	dw $51c6 ; record 3
	dw $5201 ; record 4
	dw $51fd ; record 5
	dw $51f9 ; record 6
	dw $51d9 ; record 7
	call Func_0d_5205 ; $51c6
	ld a, $01 ; $51c9
	ld [$c785], a ; $51cb
	call Func_0d_4678 ; $51ce
	ret ; $51d1
	call Func_0d_46d7 ; $51d2
	call UpdateScorePopup ; $51d5
	ret ; $51d8
	call UpdateMinigameActors ; $51d9
	ret ; $51dc
	call Func_0d_521e ; $51dd
	farcall FarPtr_AdvanceMatchRng ; $51e0
	and a, $01 ; $51e3
	inc a ; $51e5
	ld hl, $c785 ; $51e6
	add a, [hl] ; $51e9
	cp a, $03 ; $51ea
	jr c, Label_0d_51f0 ; $51ec
	sub a, $03 ; $51ee
Label_0d_51f0:
	ld [hl], a ; $51f0
	call Func_0d_46f7 ; $51f1
	ret ; $51f4
	call Func_0d_475d ; $51f5
	ret ; $51f8
	call Func_0d_47be ; $51f9
	ret ; $51fc
	call Func_0d_47c3 ; $51fd
	ret ; $5200
	call Func_0d_47e2 ; $5201
	ret ; $5204
Func_0d_5205:
	call ClearMinigameActors ; $5205
	ld de, $5231 ; $5208
	ld bc, $dc00 ; $520b
	call SetMinigameActorHandler ; $520e
	ld hl, $0000 ; $5211
	ld de, $fdc0 ; $5214
	ld bc, $dc00 ; $5217
	call Func_0d_4465 ; $521a
	ret ; $521d
Func_0d_521e:
	ld a, [$c788] ; $521e
	and a, a ; $5221
	jr nz, Label_0d_5228 ; $5222
	xor a, a ; $5224
	ld [$c789], a ; $5225
Label_0d_5228:
	xor a, a ; $5228
	ld [$c788], a ; $5229
	xor a, a ; $522c
	ld [$dc02], a ; $522d
	ret ; $5230
	ld a, [$dc72] ; $5231
	rst Rst00 ; $5234
	dw Label_0d_5244 ; $5235 jumptable
	dw Label_0d_5262 ; $5237 jumptable
	dw Label_0d_5270 ; $5239 jumptable
	dw Label_0d_528e ; $523b jumptable
	dw Label_00_03ae ; $523d jumptable
Func_0d_523f:
	ld hl, $dc72 ; $523f
	inc [hl] ; $5242
	ret ; $5243
Label_0d_5244:
	ld a, [$dc73] ; $5244
	and a, a ; $5247
	jr z, Label_0d_525b ; $5248
	farcall FarPtr_AdvanceMatchRng ; $524a
	ld h, $00 ; $524d
	ld l, a ; $524f
	add hl, hl ; $5250
	ld de, rJOYP ; $5251
	add hl, de ; $5254
	ld de, $fdc0 ; $5255
	call Func_0d_449a ; $5258
Label_0d_525b:
	xor a, a ; $525b
	ld [$dc73], a ; $525c
	call Func_0d_523f ; $525f
Label_0d_5262:
	call Func_0d_535f ; $5262
	call IsBallInHitZone ; $5265
	and a, a ; $5268
	ret z ; $5269
	call AwardHitScore ; $526a
	jp Func_0d_523f ; $526d
Label_0d_5270:
	call Func_0d_539e ; $5270
	ld hl, $dc73 ; $5273
	dec [hl] ; $5276
	ld a, [hl] ; $5277
	and a, a ; $5278
	ret nz ; $5279
	farcall FarPtr_AdvanceMatchRng ; $527a
	ld h, $00 ; $527d
	ld l, a ; $527f
	add hl, hl ; $5280
	ld de, rJOYP ; $5281
	add hl, de ; $5284
	ld de, $fdc0 ; $5285
	call Func_0d_449a ; $5288
	jp Func_0d_523f ; $528b
Label_0d_528e:
	call Func_0d_535f ; $528e
	ret ; $5291
IsBallInHitZone:
	ld a, [$c4b8] ; $5292
	and a, $01 ; $5295
	jp nz, Label_0d_52f7 ; $5297
	ld hl, $dc76 ; $529a
	ld a, [hl+] ; $529d
	ld d, [hl] ; $529e
	ld e, a ; $529f
	ld hl, wBallX ; $52a0
	ld a, [hl+] ; $52a3
	ld h, [hl] ; $52a4
	ld l, a ; $52a5
	ld a, l ; $52a6
	sub a, e ; $52a7
	ld l, a ; $52a8
	ld a, h ; $52a9
	sbc a, d ; $52aa
	ld h, a ; $52ab
	bit 7, h ; $52ac
	jr z, Label_0d_52b6 ; $52ae
	xor a, a ; $52b0
	sub a, l ; $52b1
	ld l, a ; $52b2
	sbc a, a ; $52b3
	sub a, h ; $52b4
	ld h, a ; $52b5
Label_0d_52b6:
	ld de, $ff80 ; $52b6
	add hl, de ; $52b9
	jr c, Label_0d_52f7 ; $52ba
	ld hl, $dc78 ; $52bc
	ld a, [hl+] ; $52bf
	ld d, [hl] ; $52c0
	ld e, a ; $52c1
	ld hl, wBallDepth ; $52c2
	ld a, [hl+] ; $52c5
	ld h, [hl] ; $52c6
	ld l, a ; $52c7
	ld a, l ; $52c8
	sub a, e ; $52c9
	ld l, a ; $52ca
	ld a, h ; $52cb
	sbc a, d ; $52cc
	ld h, a ; $52cd
	bit 7, h ; $52ce
	jr z, Label_0d_52d8 ; $52d0
	xor a, a ; $52d2
	sub a, l ; $52d3
	ld l, a ; $52d4
	sbc a, a ; $52d5
	sub a, h ; $52d6
	ld h, a ; $52d7
Label_0d_52d8:
	ld de, rJOYP ; $52d8
	add hl, de ; $52db
	jr c, Label_0d_52f7 ; $52dc
	ld hl, wBallHeight ; $52de
	ld a, [hl+] ; $52e1
	ld h, [hl] ; $52e2
	ld l, a ; $52e3
	bit 7, h ; $52e4
	jr z, Label_0d_52ee ; $52e6
	xor a, a ; $52e8
	sub a, l ; $52e9
	ld l, a ; $52ea
	sbc a, a ; $52eb
	sub a, h ; $52ec
	ld h, a ; $52ed
Label_0d_52ee:
	ld de, rLCDC ; $52ee
	add hl, de ; $52f1
	jr c, Label_0d_52f7 ; $52f2
	ld a, $01 ; $52f4
	ret ; $52f6
Label_0d_52f7:
	xor a, a ; $52f7
	ret ; $52f8
AwardHitScore:
	ld a, $10 ; $52f9
	ld [$dc73], a ; $52fb
	ld hl, $0001 ; $52fe
	ld a, [$c4a0] ; $5301
	cp a, $09 ; $5304
	jr nz, Label_0d_5310 ; $5306
	ld a, $20 ; $5308
	ld [$dc73], a ; $530a
	ld hl, $0007 ; $530d
Label_0d_5310:
	ld a, $01 ; $5310
	ld [$c788], a ; $5312
	ld a, [$c789] ; $5315
	add a, $4f ; $5318
	ld e, a ; $531a
	adc a, $53 ; $531b
	sub a, e ; $531d
	ld d, a ; $531e
	ld a, [de] ; $531f
	call PlaySoundManaged ; $5320
	ld a, [$c789] ; $5323
	add a, $57 ; $5326
	ld e, a ; $5328
	adc a, $53 ; $5329
	sub a, e ; $532b
	ld d, a ; $532c
	ld a, [de] ; $532d
	call MulHLByA ; $532e
	ld e, l ; $5331
	ld d, h ; $5332
	ld hl, $c782 ; $5333
	ld a, e ; $5336
	ld [hl+], a ; $5337
	ld [hl], d ; $5338
	call AddToMinigameScore ; $5339
	call StartScorePopup ; $533c
	ld b, $07 ; $533f
	call Func_0d_41cb ; $5341
	ld a, $06 ; $5344
	ld [wPointOutcome], a ; $5346
	ld a, $01 ; $5349
	ld [$c4d9], a ; $534b
	ret ; $534e
	INCBIN "data/bank_00d/d_534f.bin" ; $534f, 16 bytes
Func_0d_535f:
	call Func_0d_53aa ; $535f
	ld c, $30 ; $5362
	ld h, $fc ; $5364
	ld l, $f1 ; $5366
	call QueueSprite24x32 ; $5368
	ldh a, [hVBlankCounter] ; $536b
	and a, $1f ; $536d
	add a, $7e ; $536f
	ld l, a ; $5371
	adc a, $53 ; $5372
	sub a, l ; $5374
	ld h, a ; $5375
	ld a, [hl] ; $5376
	cp a, $ff ; $5377
	ret z ; $5379
	farcall FarPtr_28_0c ; $537a
	ret ; $537d
	; $537e, 32 bytes (bytes:8)
	db $00, $ff, $ff, $ff, $ff, $ff, $ff, $ff ; 0x00
	db $01, $ff, $ff, $ff, $ff, $ff, $ff, $ff ; 0x08
	db $02, $ff, $ff, $ff, $ff, $ff, $ff, $ff ; 0x10
	db $01, $ff, $ff, $ff, $ff, $ff, $ff, $ff ; 0x18
Func_0d_539e:
	call Func_0d_53aa ; $539e
	ld c, $3c ; $53a1
	ld a, [$dc73] ; $53a3
	call Func_0d_53ce ; $53a6
	ret ; $53a9
Func_0d_53aa:
	ld hl, $dc7a ; $53aa
	ld a, [hl+] ; $53ad
	ld e, a ; $53ae
	ld a, [hl+] ; $53af
	ld d, a ; $53b0
	ld a, [hl+] ; $53b1
	ld c, a ; $53b2
	ld a, [hl+] ; $53b3
	ld b, a ; $53b4
	ld l, e ; $53b5
	ld h, d ; $53b6
	farcall FarPtr_08_46 ; $53b7
	ld a, [$c789] ; $53ba
	add a, $c6 ; $53bd
	ld l, a ; $53bf
	adc a, $53 ; $53c0
	sub a, l ; $53c2
	ld h, a ; $53c3
	ld b, [hl] ; $53c4
	ret ; $53c5
	INCBIN "data/bank_00d/d_53c6.bin" ; $53c6, 8 bytes
Func_0d_53ce:
	call Func_0d_53d8 ; $53ce
	call Func_0d_540a ; $53d1
	call Func_0d_540a ; $53d4
	ret ; $53d7
Func_0d_53d8:
	and a, $0f ; $53d8
	cpl ; $53da
	inc a ; $53db
	add a, $0f ; $53dc
	add a, $2c ; $53de
	ld l, a ; $53e0
	adc a, $54 ; $53e1
	sub a, l ; $53e3
	ld h, a ; $53e4
	ld a, e ; $53e5
	add a, $f8 ; $53e6
	ld e, a ; $53e8
	call Func_0d_540a ; $53e9
	call Func_0d_540a ; $53ec
	call Func_0d_540a ; $53ef
	call Func_0d_540a ; $53f2
	ret ; $53f5
	and a, $0f ; $53f6
	cpl ; $53f8
	inc a ; $53f9
	add a, $0f ; $53fa
	add a, $2c ; $53fc
	ld l, a ; $53fe
	adc a, $54 ; $53ff
	sub a, l ; $5401
	ld h, a ; $5402
	call Func_0d_540a ; $5403
	call Func_0d_540a ; $5406
	ret ; $5409
Func_0d_540a:
	push de ; $540a
	ld a, [hl] ; $540b
	add a, a ; $540c
	add a, d ; $540d
	ld d, a ; $540e
	ld a, $10 ; $540f
	add a, l ; $5411
	ld l, a ; $5412
	jr nc, Label_0d_5416 ; $5413
	inc h ; $5415
Label_0d_5416:
	ld a, [hl] ; $5416
	add a, a ; $5417
	add a, e ; $5418
	ld e, a ; $5419
	ld a, $10 ; $541a
	add a, l ; $541c
	ld l, a ; $541d
	jr nc, Label_0d_5421 ; $541e
	inc h ; $5420
Label_0d_5421:
	push hl ; $5421
	call QueueSprite ; $5422
	pop hl ; $5425
	pop de ; $5426
	dec e ; $5427
	dec e ; $5428
	dec e ; $5429
	dec e ; $542a
	ret ; $542b
	INCBIN "data/bank_00d/d_542c.bin" ; $542c, 392 bytes
Func_0d_55b4:
	wram_bank $02 ; $55b4
	ld de, $c7c0 ; $55ba
	ld bc, $0018 ; $55bd
	call CopyMemoryBC ; $55c0
	call Func_0d_4302 ; $55c3
	farcall FarPtr_FlushTilemapToVram ; $55c6
	ret ; $55c9
	ld hl, $c78e ; $55ca
	ld a, [hl] ; $55cd
	and a, a ; $55ce
	ret z ; $55cf
	ld [hl], $00 ; $55d0
	ld a, [$c78d] ; $55d2
	cp a, $ff ; $55d5
	jr z, Label_0d_55fd ; $55d7
	ld a, [$c78d] ; $55d9
	add a, $f9 ; $55dc
	ld l, a ; $55de
	adc a, $55 ; $55df
	sub a, l ; $55e1
	ld h, a ; $55e2
	ld e, [hl] ; $55e3
	ld d, $00 ; $55e4
	call AddToMinigameScore ; $55e6
	ld a, $ff ; $55e9
	ld [$c78d], a ; $55eb
	call IsMinigameTargetReached ; $55ee
	and a, a ; $55f1
	ret z ; $55f2
	ld a, $0b ; $55f3
	ld [wPointOutcome], a ; $55f5
	ret ; $55f8
	INCBIN "data/bank_00d/d_55f9.bin" ; $55f9, 4 bytes
Label_0d_55fd:
	ld a, [$c7bf] ; $55fd
	cp a, $ff ; $5600
	ret z ; $5602
	add a, $c0 ; $5603
	ld l, a ; $5605
	adc a, $c7 ; $5606
	sub a, l ; $5608
	ld h, a ; $5609
	ld a, [hl] ; $560a
	and a, a ; $560b
	ret z ; $560c
	sub a, $04 ; $560d
	farcall FarPtr_DeflectBallOffMinigameTarget ; $560f
	sound $77 ; $5612
	ret ; $5614
	INCBIN "data/bank_00d/d_5615.bin" ; $5615, 67 bytes
	ld l, a ; $5658
	ld d, [hl] ; $5659
	ld a, d ; $565a
	ld d, [hl] ; $565b
	ld a, [hl] ; $565c
	ld d, [hl] ; $565d
	ld l, b ; $565e
	ld d, [hl] ; $565f
	adc a, l ; $5660
	ld d, [hl] ; $5661
	adc a, c ; $5662
	ld d, [hl] ; $5663
	add a, l ; $5664
	ld d, [hl] ; $5665
	halt ; $5666
	ld d, [hl] ; $5667
	call Func_0d_5691 ; $5668
	call Func_0d_56b0 ; $566b
	ret ; $566e
	call Func_0d_56b4 ; $566f
	call UpdateScorePopup ; $5672
	ret ; $5675
	call UpdateMinigameActors ; $5676
	ret ; $5679
	call Func_0d_56bb ; $567a
	ret ; $567d
	call Func_0d_56aa ; $567e
	call Func_0d_56c0 ; $5681
	ret ; $5684
	call Func_0d_56ee ; $5685
	ret ; $5688
	call Func_0d_56ef ; $5689
	ret ; $568c
	call Func_0d_56f0 ; $568d
	ret ; $5690
Func_0d_5691:
	call ClearMinigameActors ; $5691
	ld de, $5719 ; $5694
	ld bc, $dc00 ; $5697
	call SetMinigameActorHandler ; $569a
	ld hl, $0000 ; $569d
	ld de, $0000 ; $56a0
	ld bc, $dc00 ; $56a3
	call Func_0d_4465 ; $56a6
	ret ; $56a9
Func_0d_56aa:
	ld hl, $dc00 ; $56aa
	res 0, [hl] ; $56ad
	ret ; $56af
Func_0d_56b0:
	call InitMinigameScore ; $56b0
	ret ; $56b3
Func_0d_56b4:
	ld de, $8403 ; $56b4
	call DrawMinigameScore ; $56b7
	ret ; $56ba
Func_0d_56bb:
	xor a, a ; $56bb
	ld [wOffscreenArrowsEnabled], a ; $56bc
	ret ; $56bf
Func_0d_56c0:
	call Func_0d_43ba ; $56c0
	call DetermineMinigamePointResult ; $56c3
	push de ; $56c6
	ldh a, [hWramBank] ; $56c7
	push af ; $56c9
	wram_bank $04 ; $56ca
	farcall FarPtr_CharPointEndReaction ; $56d0
	ld a, [$df57] ; $56d3
	push af ; $56d6
	wram_bank $05 ; $56d7
	farcall FarPtr_CharPointEndReaction ; $56dd
	pop af ; $56e0
	ld [$df57], a ; $56e1
	pop af ; $56e4
	wram_bank ; $56e5
	pop de ; $56e9
	call ShowMinigamePointResult ; $56ea
	ret ; $56ed
Func_0d_56ee:
	ret ; $56ee
Func_0d_56ef:
	ret ; $56ef
Func_0d_56f0:
	ld a, [$c4b8] ; $56f0
	and a, $01 ; $56f3
	jr nz, Label_0d_56ff ; $56f5
	ld a, [$c788] ; $56f7
	and a, a ; $56fa
	jr z, Label_0d_5710 ; $56fb
	jr Label_0d_570b ; $56fd
Label_0d_56ff:
	ld a, [$c788] ; $56ff
	and a, a ; $5702
	jr nz, Label_0d_570b ; $5703
	xor a, a ; $5705
	ld [$c789], a ; $5706
	jr Label_0d_5710 ; $5709
Label_0d_570b:
	ld b, $07 ; $570b
	call Func_0d_41cb ; $570d
Label_0d_5710:
	xor a, a ; $5710
	ld [$c788], a ; $5711
	xor a, a ; $5714
	ld [$dc02], a ; $5715
	ret ; $5718
	ld a, [$dc72] ; $5719
	rst Rst00 ; $571c
	dw Label_0d_572c ; $571d jumptable
	dw Label_0d_572f ; $571f jumptable
	dw Label_0d_573d ; $5721 jumptable
	dw Label_0d_575b ; $5723 jumptable
	dw Label_00_03ae ; $5725 jumptable
Func_0d_5727:
	ld hl, $dc72 ; $5727
	inc [hl] ; $572a
	ret ; $572b
Label_0d_572c:
	call Func_0d_5727 ; $572c
Label_0d_572f:
	call Func_0d_57fd ; $572f
	call Func_0d_575f ; $5732
	and a, a ; $5735
	ret z ; $5736
	call Func_0d_57be ; $5737
	jp Func_0d_5727 ; $573a
Label_0d_573d:
	call Func_0d_583c ; $573d
	ld hl, $dc73 ; $5740
	dec [hl] ; $5743
	ld a, [hl] ; $5744
	and a, a ; $5745
	ret nz ; $5746
	farcall FarPtr_AdvanceMatchRng ; $5747
	ld h, $00 ; $574a
	ld l, a ; $574c
	add hl, hl ; $574d
	ld de, rJOYP ; $574e
	add hl, de ; $5751
	ld de, $0000 ; $5752
	call Func_0d_449a ; $5755
	jp Func_0d_5727 ; $5758
Label_0d_575b:
	call Func_0d_57fd ; $575b
	ret ; $575e
Func_0d_575f:
	ld hl, $dc76 ; $575f
	ld a, [hl+] ; $5762
	ld d, [hl] ; $5763
	ld e, a ; $5764
	ld hl, wBallX ; $5765
	ld a, [hl+] ; $5768
	ld h, [hl] ; $5769
	ld l, a ; $576a
	ld a, l ; $576b
	sub a, e ; $576c
	ld l, a ; $576d
	ld a, h ; $576e
	sbc a, d ; $576f
	ld h, a ; $5770
	bit 7, h ; $5771
	jr z, Label_0d_577b ; $5773
	xor a, a ; $5775
	sub a, l ; $5776
	ld l, a ; $5777
	sbc a, a ; $5778
	sub a, h ; $5779
	ld h, a ; $577a
Label_0d_577b:
	ld de, $ff80 ; $577b
	add hl, de ; $577e
	jr c, Label_0d_57bc ; $577f
	ld hl, $dc78 ; $5781
	ld a, [hl+] ; $5784
	ld d, [hl] ; $5785
	ld e, a ; $5786
	ld hl, wBallDepth ; $5787
	ld a, [hl+] ; $578a
	ld h, [hl] ; $578b
	ld l, a ; $578c
	ld a, l ; $578d
	sub a, e ; $578e
	ld l, a ; $578f
	ld a, h ; $5790
	sbc a, d ; $5791
	ld h, a ; $5792
	bit 7, h ; $5793
	jr z, Label_0d_579d ; $5795
	xor a, a ; $5797
	sub a, l ; $5798
	ld l, a ; $5799
	sbc a, a ; $579a
	sub a, h ; $579b
	ld h, a ; $579c
Label_0d_579d:
	ld de, $fec0 ; $579d
	add hl, de ; $57a0
	jr c, Label_0d_57bc ; $57a1
	ld hl, wBallHeight ; $57a3
	ld a, [hl+] ; $57a6
	ld h, [hl] ; $57a7
	ld l, a ; $57a8
	bit 7, h ; $57a9
	jr z, Label_0d_57b3 ; $57ab
	xor a, a ; $57ad
	sub a, l ; $57ae
	ld l, a ; $57af
	sbc a, a ; $57b0
	sub a, h ; $57b1
	ld h, a ; $57b2
Label_0d_57b3:
	ld de, rJOYP ; $57b3
	add hl, de ; $57b6
	jr c, Label_0d_57bc ; $57b7
	ld a, $01 ; $57b9
	ret ; $57bb
Label_0d_57bc:
	xor a, a ; $57bc
	ret ; $57bd
Func_0d_57be:
	ld a, $10 ; $57be
	ld [$dc73], a ; $57c0
	ld a, $01 ; $57c3
	ld [$c788], a ; $57c5
	sound $86 ; $57c8
	ld a, [$c789] ; $57ca
	add a, $f5 ; $57cd
	ld e, a ; $57cf
	adc a, $57 ; $57d0
	sub a, e ; $57d2
	ld d, a ; $57d3
	ld a, [de] ; $57d4
	ld hl, $0001 ; $57d5
	call MulHLByA ; $57d8
	ld e, l ; $57db
	ld d, h ; $57dc
	ld hl, $c782 ; $57dd
	ld a, e ; $57e0
	ld [hl+], a ; $57e1
	ld [hl], d ; $57e2
	call AddToMinigameScore ; $57e3
	call StartScorePopup ; $57e6
	call IsMinigameTargetReached ; $57e9
	and a, a ; $57ec
	jr z, Label_0d_57f4 ; $57ed
	ld a, $0b ; $57ef
	ld [wPointOutcome], a ; $57f1
Label_0d_57f4:
	ret ; $57f4
	ld bc, $0402 ; $57f5
	ld [$2010], sp ; $57f8
	ld b, b ; $57fb
	add a, b ; $57fc
Func_0d_57fd:
	call Func_0d_5848 ; $57fd
	ld c, $30 ; $5800
	ld h, $fc ; $5802
	ld l, $f1 ; $5804
	call QueueSprite24x32 ; $5806
	ldh a, [hVBlankCounter] ; $5809
	and a, $1f ; $580b
	add a, $1c ; $580d
	ld l, a ; $580f
	adc a, $58 ; $5810
	sub a, l ; $5812
	ld h, a ; $5813
	ld a, [hl] ; $5814
	cp a, $ff ; $5815
	ret z ; $5817
	farcall FarPtr_28_10 ; $5818
	ret ; $581b
	nop ; $581c
	rst Rst38 ; $581d
	rst Rst38 ; $581e
	rst Rst38 ; $581f
	rst Rst38 ; $5820
	rst Rst38 ; $5821
	rst Rst38 ; $5822
	rst Rst38 ; $5823
	ld bc, rIE ; $5824
	rst Rst38 ; $5827
	rst Rst38 ; $5828
	rst Rst38 ; $5829
	rst Rst38 ; $582a
	rst Rst38 ; $582b
	ld [bc], a ; $582c
	rst Rst38 ; $582d
	rst Rst38 ; $582e
	rst Rst38 ; $582f
	rst Rst38 ; $5830
	rst Rst38 ; $5831
	rst Rst38 ; $5832
	rst Rst38 ; $5833
	ld bc, rIE ; $5834
	rst Rst38 ; $5837
	rst Rst38 ; $5838
	rst Rst38 ; $5839
	rst Rst38 ; $583a
	rst Rst38 ; $583b
Func_0d_583c:
	call Func_0d_5848 ; $583c
	ld c, $3c ; $583f
	ld a, [$dc73] ; $5841
	call Func_0d_53ce ; $5844
	ret ; $5847
Func_0d_5848:
	ld hl, $dc7a ; $5848
	ld a, [hl+] ; $584b
	ld e, a ; $584c
	ld a, [hl+] ; $584d
	ld d, a ; $584e
	ld a, [hl+] ; $584f
	ld c, a ; $5850
	ld a, [hl+] ; $5851
	ld b, a ; $5852
	ld l, e ; $5853
	ld h, d ; $5854
	farcall FarPtr_08_46 ; $5855
	ld a, [$c789] ; $5858
	add a, $66 ; $585b
	ld l, a ; $585d
	adc a, $58 ; $585e
	sub a, l ; $5860
	ld h, a ; $5861
	ld b, [hl] ; $5862
	ld b, $0e ; $5863
	ret ; $5865
	rrca ; $5866
	ld c, $0e ; $5867
	ld c, $0e ; $5869
	ld c, $0e ; $586b
	dec c ; $586d
	nop ; $586e
	inc de ; $586f
	ld bc, $1e08 ; $5870
	ld [de], a ; $5873
	nop ; $5874
	rra ; $5875
	and a, [hl] ; $5876
	ld e, b ; $5877
	or a, h ; $5878
	ld b, b ; $5879
	ld a, [hl] ; $587a
	ld e, b ; $587b
	nop ; $587c
	nop ; $587d
	ld a, $01 ; $587e
	ld [$c7b9], a ; $5880
	ld a, [wMinigameLevel] ; $5883
	cp a, $02 ; $5886
	jr nz, Label_0d_588f ; $5888
	ld a, $01 ; $588a
	ld [$c7bc], a ; $588c
Label_0d_588f:
	farcall FarPtr_InitMinigameTargets ; $588f
	ld a, [wMinigameLevel] ; $5892
	add a, $a3 ; $5895
	ld l, a ; $5897
	adc a, $58 ; $5898
	sub a, l ; $589a
	ld h, a ; $589b
	ld a, [hl] ; $589c
	and a, a ; $589d
	ret z ; $589e
	farcall FarPtr_SpawnMinigameTargetFormation ; $589f
	ret ; $58a2
	nop ; $58a3
	rlca ; $58a4
	ld [$58b6], sp ; $58a5
	cp a, d ; $58a8
	ld e, b ; $58a9
	pop bc ; $58aa
	ld e, b ; $58ab
	xor a, [hl] ; $58ac
	inc bc ; $58ad
	call $c958 ; $58ae
	ld e, b ; $58b1
	push bc ; $58b2
	ld e, b ; $58b3
	xor a, [hl] ; $58b4
	inc bc ; $58b5
	call Func_0d_4abb ; $58b6
	ret ; $58b9
	call Func_0d_4b01 ; $58ba
	call Func_0d_5979 ; $58bd
	ret ; $58c0
	call Func_0d_4b29 ; $58c1
	ret ; $58c4
	call Func_0d_58d1 ; $58c5
	ret ; $58c8
	call Func_0d_4bc7 ; $58c9
	ret ; $58cc
	call Func_0d_4bc8 ; $58cd
	ret ; $58d0
Func_0d_58d1:
	call Func_0d_4b70 ; $58d1
	call Func_0d_42bf ; $58d4
	cp a, $ff ; $58d7
	ret z ; $58d9
	ld b, a ; $58da
	add a, $c0 ; $58db
	ld l, a ; $58dd
	adc a, $c7 ; $58de
	sub a, l ; $58e0
	ld h, a ; $58e1
	ld a, [hl] ; $58e2
	cp a, $01 ; $58e3
	ret z ; $58e5
	ldh a, [hWramBank] ; $58e6
	push af ; $58e8
	wram_bank $02 ; $58e9
	ld a, $01 ; $58ef
	ld [hl], a ; $58f1
	ld a, b ; $58f2
	ld b, $01 ; $58f3
	call Func_0d_431b ; $58f5
	farcall FarPtr_FlushTilemapToVram ; $58f8
	pop af ; $58fb
	wram_bank ; $58fc
	sound $97 ; $5900
	ld a, [$c7a6] ; $5902
	inc a ; $5905
	ld e, a ; $5906
	ld d, $00 ; $5907
	call AddToMinigameScore ; $5909
	call IsMinigameTargetReached ; $590c
	and a, a ; $590f
	jr z, Label_0d_5918 ; $5910
	ld a, $0b ; $5912
	ld [wPointOutcome], a ; $5914
	ret ; $5917
Label_0d_5918:
	call Func_0d_59b7 ; $5918
	and a, a ; $591b
	ret z ; $591c
	ld hl, $c7a6 ; $591d
	ld a, [hl] ; $5920
	cp a, $09 ; $5921
	jr nc, Label_0d_5926 ; $5923
	inc [hl] ; $5925
Label_0d_5926:
	ldh a, [hWramBank] ; $5926
	push af ; $5928
	wram_bank $02 ; $5929
	ld a, $01 ; $592f
	ld [$c4c0], a ; $5931
	call Func_0d_598b ; $5934
	xor a, a ; $5937
	ld [$c4c0], a ; $5938
	pop af ; $593b
	wram_bank ; $593c
	ret ; $5940
	INCBIN "data/bank_00d/d_5941.bin" ; $5941, 56 bytes
Func_0d_5979:
	ld hl, $5941 ; $5979
	call Func_0d_55b4 ; $597c
	ld a, $01 ; $597f
	ld [$c7c7], a ; $5981
	ld [$c7cf], a ; $5984
	ld [$c7d7], a ; $5987
	ret ; $598a
Func_0d_598b:
	ld a, $02 ; $598b
	farcall FarPtr_StepMatchFrames ; $598d
	ld hl, $5941 ; $5990
	ld b, $18 ; $5993
	ld c, $00 ; $5995
Label_0d_5997:
	ld a, [hl+] ; $5997
	cp a, $00 ; $5998
	jr z, Label_0d_59af ; $599a
	push bc ; $599c
	push hl ; $599d
	ld b, a ; $599e
	ld a, c ; $599f
	call Func_0d_431b ; $59a0
	farcall FarPtr_FlushTilemapToVram ; $59a3
	sound $94 ; $59a6
	ld a, $08 ; $59a8
	farcall FarPtr_StepMatchFrames ; $59aa
	pop hl ; $59ad
	pop bc ; $59ae
Label_0d_59af:
	inc c ; $59af
	dec b ; $59b0
	jr nz, Label_0d_5997 ; $59b1
	call Func_0d_5979 ; $59b3
	ret ; $59b6
Func_0d_59b7:
	ld hl, $c7c0 ; $59b7
	ld c, $18 ; $59ba
	xor a, a ; $59bc
Label_0d_59bd:
	ld a, [hl+] ; $59bd
	cp a, $01 ; $59be
	jr nz, Label_0d_59c8 ; $59c0
	dec c ; $59c2
	jr nz, Label_0d_59bd ; $59c3
	ld a, $01 ; $59c5
	ret ; $59c7
Label_0d_59c8:
	ld a, $00 ; $59c8
	ret ; $59ca
	INCBIN "data/bank_00d/d_59cb.bin" ; $59cb, 935 bytes
	; $5d72, 648 bytes (bytes:14)
	db $00, $cd, $bd, $5d, $21, $80, $00, $11, $40, $fe, $01, $10, $dc, $3e ; 0x00
	db $01, $cd, $bd, $5d, $21, $c0, $00, $11, $80, $fd, $01, $20, $dc, $3e ; 0x0e
	db $02, $cd, $bd, $5d, $21, $c0, $ff, $11, $00, $ff, $01, $30, $dc, $3e ; 0x1c
	db $03, $cd, $bd, $5d, $21, $80, $ff, $11, $40, $fe, $01, $40, $dc, $3e ; 0x2a
	db $04, $cd, $bd, $5d, $21, $40, $ff, $11, $80, $fd, $01, $50, $dc, $3e ; 0x38
	db $05, $cd, $bd, $5d, $c9, $f5, $c5, $d5, $e5, $11, $ee, $5d, $cd, $4f ; 0x46
	db $44, $e1, $d1, $c1, $f1, $e5, $21, $01, $00, $09, $77, $e1, $cd, $65 ; 0x54
	db $44, $c9, $af, $ea, $89, $c7, $af, $ea, $02, $dc, $ea, $12, $dc, $ea ; 0x62
	db $22, $dc, $ea, $32, $dc, $ea, $42, $dc, $ea, $52, $dc, $c9, $fa, $72 ; 0x70
	db $dc, $c7, $01, $5e, $04, $5e, $12, $5e, $33, $5e, $ae, $03, $21, $72 ; 0x7e
	db $dc, $34, $c9, $cd, $fc, $5d, $cd, $f2, $5e, $cd, $37, $5e, $a7, $c8 ; 0x8c
	db $cd, $9e, $5e, $c3, $fc, $5d, $cd, $13, $5f, $21, $73, $dc, $35, $7e ; 0x9a
	db $a7, $c0, $21, $78, $dc, $2a, $56, $5f, $df, $36, $08, $26, $00, $6f ; 0xa8
	db $29, $01, $00, $ff, $09, $cd, $9a, $44, $c3, $fc, $5d, $cd, $f2, $5e ; 0xb6
	db $c9, $fa, $b8, $c4, $e6, $01, $c2, $9c, $5e, $21, $76, $dc, $2a, $56 ; 0xc4
	db $5f, $21, $02, $c4, $2a, $66, $6f, $7d, $93, $6f, $7c, $9a, $67, $cb ; 0xd2
	db $7c, $28, $06, $af, $95, $6f, $9f, $94, $67, $11, $a0, $ff, $19, $38 ; 0xe0
	db $3b, $21, $78, $dc, $2a, $56, $5f, $21, $06, $c4, $2a, $66, $6f, $7d ; 0xee
	db $93, $6f, $7c, $9a, $67, $cb, $7c, $28, $06, $af, $95, $6f, $9f, $94 ; 0xfc
	db $67, $11, $80, $ff, $19, $38, $19, $21, $0a, $c4, $2a, $66, $6f, $cb ; 0x10a
	db $7c, $28, $06, $af, $95, $6f, $9f, $94, $67, $11, $40, $ff, $19, $38 ; 0x118
	db $03, $3e, $01, $c9, $af, $c9, $3e, $10, $ea, $73, $dc, $21, $01, $00 ; 0x126
	db $fa, $a0, $c4, $fe, $09, $20, $08, $3e, $20, $ea, $73, $dc, $21, $02 ; 0x134
	db $00, $fa, $89, $c7, $c6, $e4, $5f, $ce, $5e, $93, $57, $1a, $cd, $24 ; 0x142
	db $30, $fa, $89, $c7, $c6, $ec, $5f, $ce, $5e, $93, $57, $1a, $cd, $26 ; 0x150
	db $09, $5d, $54, $21, $82, $c7, $7b, $22, $72, $cd, $66, $42, $cd, $11 ; 0x15e
	db $42, $21, $89, $c7, $34, $c9, $c0, $bf, $be, $bd, $bc, $bb, $ba, $ba ; 0x16c
	db $01, $05, $1e, $46, $96, $fa, $cd, $1f, $5f, $f0, $8c, $21, $7a, $dc ; 0x17a
	db $86, $cb, $3f, $cb, $3f, $cb, $3f, $e6, $03, $c6, $0f, $6f, $ce, $5f ; 0x188
	db $95, $67, $4e, $cd, $55, $1e, $c9, $20, $24, $28, $2c, $cd, $1f, $5f ; 0x196
	db $0e, $3c, $fa, $73, $dc, $cd, $f6, $53, $c9, $21, $7a, $dc, $2a, $5f ; 0x1a4
	db $2a, $57, $2a, $4f, $2a, $47, $6b, $62, $df, $46, $08, $06, $0f, $c9 ; 0x1b2
	db $00, $16, $01, $08, $20, $13, $00, $1c, $61, $5f, $b4, $40, $42, $5f ; 0x1c0
	db $00, $00, $df, $96, $0a, $3e, $06, $df, $9a, $0a, $3e, $01, $ea, $a4 ; 0x1ce
	db $c7, $3e, $01, $ea, $b9, $c7, $fa, $76, $c3, $fe, $02, $20, $05, $3e ; 0x1dc
	db $01, $ea, $bc, $c7, $c9, $72, $5f, $79, $5f, $dc, $5f, $71, $5f, $e8 ; 0x1ea
	db $5f, $e4, $5f, $e0, $5f, $ae, $03, $c9, $cd, $bb, $4a, $cd, $ec, $5f ; 0x1f8
	db $c9, $cd, $01, $4b, $fa, $76, $c3, $87, $c6, $8e, $6f, $ce, $5f, $95 ; 0x206
	db $67, $2a, $66, $6f, $cd, $b4, $55, $c9, $94, $5f, $ac, $5f, $c4, $5f ; 0x214
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; 0x222
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $05, $05 ; 0x230
	db $00, $06, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $04 ; 0x23e
	db $00, $07, $07, $00, $00, $00, $00, $04, $04, $00, $06, $06, $00, $00 ; 0x24c
	db $07, $00, $00, $05, $00, $00, $07, $00, $00, $07, $07, $00, $07, $07 ; 0x25a
	db $00, $00, $cd, $29, $4b, $c9, $cd, $f0, $5f, $c9, $cd, $c7, $4b, $c9 ; 0x268
	db $cd, $c8, $4b, $c9, $cd, $ca, $55, $c9, $cd, $70, $4b, $cd, $bf, $42 ; 0x276
	db $ea, $bf, $c7, $c9 ; 0x284
	ds 8198, $ff ; $5ffa, fill
