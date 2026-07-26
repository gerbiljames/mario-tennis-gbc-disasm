SECTION "ROM Bank $02", ROMX[$4000], BANK[$02]

	farptr DebugStoryStatsScreen ; $4000
	farptr InitStoryModeState ; $4002
	farptr ValidateN64TransferRecord ; $4004
	farptr InitPlayerRecordFromTemplate ; $4006
	farptr LoadMainCharacterFromRoster ; $4008
	farptr LevelUpPlayer ; $400a
	farptr ComputeLevelUpStatDeltas ; $400c
	farptr RefreshPlayerStatsAndGetPtr ; $400e
	farptr RefreshMainCharacterStats ; $4010
	farptr RecomputeStatsWithoutRacket ; $4012
	farptr RollStoryRandomByte ; $4014
	farptr GenerateUniqueStorySaveSignature ; $4016
	farptr InitCa00RecordFromCharId ; $4018
	farptr LoadCharacterRecordToCa80 ; $401a
	farptr AddExpCapped ; $401c
	farptr Compare24Bit ; $401e
	farptr ClearCa00RecordExp ; $4020
	farptr AddExpToCa00RecordChecked ; $4022
	farptr AddExpToCa00RecordHooked ; $4024
	farptr AddExpToCa00Record ; $4026
	farptr AddPlayerExp ; $4028
	farptr HasReachedNextLevelExp ; $402a
	farptr GetExpRemainingToNextLevel ; $402c
	farptr GetExpProgressInCurrentLevel ; $402e
	farptr GetExpRequiredForLevel ; $4030
	farptr Unused_02_CharIdRemapLookup ; $4032
	farptr GetCharPaletteIndex ; $4034
	farptr RemapExtendedCharId ; $4036
	farptr GetCharGroupEntry ; $4038
	farptr DoesCharGroupRowContain ; $403a
	farptr SetStorySlotFlagB ; $403c
	farptr TestStorySlotFlagB ; $403e
	farptr SetStorySlotFlagA ; $4040
	farptr TestStorySlotFlagA ; $4042
ValidateN64TransferRecord:
	ld a, [$c9b4] ; $4044
	cp a, $64 ; $4047
	jr nz, .step ; $4049
	ld hl, $c9b0 ; $404b
	ld a, [hl+] ; $404e
	add a, [hl] ; $404f
	inc l ; $4050
	add a, [hl] ; $4051
	inc l ; $4052
	add a, [hl] ; $4053
	inc l ; $4054
	add a, [hl] ; $4055
	inc l ; $4056
	add a, [hl] ; $4057
	inc l ; $4058
	add a, [hl] ; $4059
	inc l ; $405a
	rlca ; $405b
	xor a, $fe ; $405c
	cp a, [hl] ; $405e
	jr nz, .step ; $405f
	ld a, $ff ; $4061
	ret ; $4063
.step:
	xor a, a ; $4064
	ret ; $4065
InitCa00RecordFromCharId:
	ld a, b ; $4066
	push af ; $4067
	ld a, c ; $4068
	call GetCa00RecordPtr ; $4069
	ld l, c ; $406c
	ld h, b ; $406d
	pop af ; $406e
	cp a, $ff ; $406f
	jr z, .emptySlot ; $4071
	cp a, $90 ; $4073
	jr z, .mainCharacter ; $4075
	bit 7, a ; $4077
	jr z, .fromRoster ; $4079
	ld b, a ; $407b
	ld a, [wCurrentStorySlot] ; $407c
	cp a, $0f ; $407f
	jr z, .skip ; $4081
	push hl ; $4083
	ld c, $04 ; $4084
	call ClearMemory16 ; $4086
	pop de ; $4089
	ld a, b ; $408a
	and a, $01 ; $408b
	swap a ; $408d
	add a, a ; $408f
	add a, a ; $4090
	add a, $00 ; $4091
	ld l, a ; $4093
	adc a, $c9 ; $4094
	sub a, l ; $4096
	ld h, a ; $4097
	ld c, $04 ; $4098
	call CopyMemoryFast ; $409a
	ret ; $409d
.skip:
	ret ; $409e
.mainCharacter:
	push hl ; $409f
	ld c, $04 ; $40a0
	call ClearMemory16 ; $40a2
	pop de ; $40a5
	ld a, [wStoryModeNameOfMainCharacter] ; $40a6
	ld [hl], a ; $40a9
	push de ; $40aa
	ld h, d ; $40ab
	ld l, e ; $40ac
	pop de ; $40ad
	ld hl, $002f ; $40ae
	add hl, de ; $40b1
	ld [hl], $03 ; $40b2
	ret ; $40b4
	ret ; $40b5
.emptySlot:
	push hl ; $40b6
	ld c, $04 ; $40b7
	call ClearMemory16 ; $40b9
	pop de ; $40bc
	ld hl, $000b ; $40bd
	add hl, de ; $40c0
	ld [hl], $ff ; $40c1
	ret ; $40c3
.fromRoster:
	push af ; $40c4
	push hl ; $40c5
	ld c, $04 ; $40c6
	call ClearMemory16 ; $40c8
	pop de ; $40cb
	pop af ; $40cc
	push af ; $40cd
	push de ; $40ce
	call GetStoryCharacterRecordPtr ; $40cf
	ld b, a ; $40d2
	push de ; $40d3
	ld a, $0f ; $40d4
	add a, e ; $40d6
	ld e, a ; $40d7
	jr nc, .gotDest ; $40d8
	inc d ; $40da
.gotDest:
	ld c, $1d ; $40db
.copyLoop:
	ld a, [hl+] ; $40dd
	ld [de], a ; $40de
	inc e ; $40df
	dec c ; $40e0
	jr nz, .copyLoop ; $40e1
	pop de ; $40e3
	ld a, b ; $40e4
	call RemapExtendedCharId ; $40e5
	ld hl, $000b ; $40e8
	add hl, de ; $40eb
	ld [hl], a ; $40ec
	ld a, b ; $40ed
	call GetCharPaletteIndex ; $40ee
	ld hl, $000c ; $40f1
	add hl, de ; $40f4
	ld [hl], a ; $40f5
	ld hl, $000b ; $40f6
	add hl, de ; $40f9
	ld a, [hl] ; $40fa
	ld hl, $001b ; $40fb
	add a, l ; $40fe
	ld l, a ; $40ff
	jr nc, .gotTextId ; $4100
	inc h ; $4102
.gotTextId:
	push hl ; $4103
	ld hl, $0000 ; $4104
	add hl, de ; $4107
	ld d, h ; $4108
	ld e, l ; $4109
	pop hl ; $410a
	farcall FetchShortTextToBuffer ; $410b
	pop de ; $410e
	pop af ; $410f
	bit 6, a ; $4110
	ret z ; $4112
	ld hl, $002f ; $4113
	add hl, de ; $4116
	ld [hl], $02 ; $4117
	ldh a, [hWramBank] ; $4119
	push af ; $411b
	wram_bank $06 ; $411c
	pop af ; $4122
	wram_bank ; $4123
	ret ; $4127
Unused_02_CharIdRemapLookup:
	push hl ; $4128
	add a, $33 ; $4129
	ld l, a ; $412b
	adc a, $41 ; $412c
	sub a, l ; $412e
	ld h, a ; $412f
	ld a, [hl] ; $4130
	pop hl ; $4131
	ret ; $4132
Unused_02_CharIdRemapTable:
	; $4133, 64 bytes (bytes:16)
	db $00, $01, $02, $03, $04, $05, $06, $07, $08, $09, $0a, $0b, $0c, $0d, $0e, $0f ; 0x00
	db $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $1a, $1b, $1c, $1d, $1e, $1f ; 0x10
	db $14, $15, $16, $17, $14, $15, $16, $17, $14, $15, $16, $17, $14, $15, $16, $17 ; 0x20
	db $14, $15, $16, $17, $14, $15, $16, $17, $14, $15, $16, $17, $14, $15, $16, $17 ; 0x30
GetCharPaletteIndex:
	push hl ; $4173
	add a, $7e ; $4174
	ld l, a ; $4176
	adc a, $41 ; $4177
	sub a, l ; $4179
	ld h, a ; $417a
	ld a, [hl] ; $417b
	pop hl ; $417c
	ret ; $417d
CharPaletteIndexTable:
	; $417e, 112 bytes (bytes:16)
	db $03, $02, $02, $01, $00, $00, $00, $04, $02, $01, $02, $04, $01, $00, $00, $02 ; 0x00
	db $02, $02, $04, $04, $00, $05, $02, $00, $01, $03, $03, $04, $00, $02, $02, $02 ; 0x10
	db $02, $01, $04, $04, $00, $03, $01, $00, $04, $02, $01, $03, $02, $00, $03, $00 ; 0x20
	db $04, $03, $01, $04, $00, $01, $02, $04, $04, $04, $03, $03, $03, $04, $04, $04 ; 0x30
	db $04, $04, $04, $03, $03, $03, $01, $01, $01, $00, $04, $03, $02, $00, $04, $03 ; 0x40
	db $02, $03, $03, $02, $02, $00, $04, $03, $02, $00, $04, $03, $03, $03, $03, $03 ; 0x50
	db $03, $02, $02, $02, $02, $02, $04, $03, $02, $00, $04, $03, $02, $00, $04, $03 ; 0x60
GetStoryCharacterRecordPtr:
	push af ; $41ee
	push de ; $41ef
	push bc ; $41f0
	ld h, $00 ; $41f1
	ld l, a ; $41f3
	ld d, h ; $41f4
	ld e, l ; $41f5
	add hl, hl ; $41f6
	add hl, hl ; $41f7
	add hl, de ; $41f8
	add hl, de ; $41f9
	add hl, de ; $41fa
	add hl, hl ; $41fb
	add hl, hl ; $41fc
	add hl, de ; $41fd
	ld de, StoryCharacterRecords_02 ; $41fe
	add hl, de ; $4201
	pop bc ; $4202
	pop de ; $4203
	pop af ; $4204
	ret ; $4205
GetPlayerRecordPtr:
	ld bc, wStoryModeNameOfMainCharacter ; $4206
	or a, a ; $4209
	ret z ; $420a
	ld c, $40 ; $420b
	ret ; $420d
GetCa00RecordPtr:
	and a, $03 ; $420e
	swap a ; $4210
	add a, a ; $4212
	add a, a ; $4213
	add a, $00 ; $4214
	ld c, a ; $4216
	adc a, $ca ; $4217
	sub a, c ; $4219
	ld b, a ; $421a
	ret ; $421b
InitStoryModeState:
	call CacheStorySlotSummaries ; $421c
	ld hl, wStorySlotData ; $421f
	ld c, $30 ; $4222
	call ClearMemory16 ; $4224
	ld a, $00 ; $4227
	ld d, $00 ; $4229
	call InitPlayerRecordFromTemplate ; $422b
	ld a, $01 ; $422e
	ld d, $02 ; $4230
	call InitPlayerRecordFromTemplate ; $4232
	ld hl, wStoryModeCurrentLocation ; $4235
	ld [hl], $00 ; $4238
	ld hl, wStoryModeEntryPoint ; $423a
	ld [hl], $02 ; $423d
	ld a, $01 ; $423f
	ld [wMessageSpeed], a ; $4241
	farcall InitDefaultMatchSettings ; $4244
	clear_flag $01, 6 ; $4247
	set_flag $01, 7 ; $424a
	ld hl, $c884 ; $424d
	xor a, a ; $4250
	ld [hl], $56 ; $4251
	inc hl ; $4253
	ld [hl+], a ; $4254
	ld [hl], a ; $4255
	ret ; $4256
Unused_02_SignExtendL:
	bit 7, l ; $4257
	jr nz, .step ; $4259
	ld h, $00 ; $425b
	ret ; $425d
.step:
	ld h, $ff ; $425e
	ret ; $4260
CacheStorySlotSummaries:
	push af ; $4261
	push bc ; $4262
	push de ; $4263
	push hl ; $4264
	ldh a, [hWramBank] ; $4265
	push af ; $4267
	wram_bank $06 ; $4268
	xor a, a ; $426e
	ld c, $0c ; $426f
	ld hl, $d400 ; $4271
.loop:
	ld [hl+], a ; $4274
	dec c ; $4275
	jr nz, .loop ; $4276
	ld a, [wCurrentStorySlot] ; $4278
	push af ; $427b
	ld a, $00 ; $427c
	ld [wCurrentStorySlot], a ; $427e
	farcall CheckStorySlot ; $4281
	cp a, $fe ; $4284
	jr z, .step ; $4286
	ld hl, $c880 ; $4288
	ld de, $d400 ; $428b
	call Copy4Bytes ; $428e
.step:
	ld a, $01 ; $4291
	ld [wCurrentStorySlot], a ; $4293
	farcall CheckStorySlot ; $4296
	cp a, $fe ; $4299
	jr z, .step2 ; $429b
	ld hl, $c880 ; $429d
	ld de, $d404 ; $42a0
	call Copy4Bytes ; $42a3
.step2:
	ld a, $02 ; $42a6
	ld [wCurrentStorySlot], a ; $42a8
	farcall CheckStorySlot ; $42ab
	cp a, $fe ; $42ae
	jr z, .restore ; $42b0
	ld hl, $c880 ; $42b2
	ld de, $d408 ; $42b5
	call Copy4Bytes ; $42b8
.restore:
	pop af ; $42bb
	ld [wCurrentStorySlot], a ; $42bc
	pop af ; $42bf
	wram_bank ; $42c0
	pop hl ; $42c4
	pop de ; $42c5
	pop bc ; $42c6
	pop af ; $42c7
	ret ; $42c8
Copy4Bytes:
	ld a, [hl+] ; $42c9
	ld [de], a ; $42ca
	inc de ; $42cb
	ld a, [hl+] ; $42cc
	ld [de], a ; $42cd
	inc de ; $42ce
	ld a, [hl+] ; $42cf
	ld [de], a ; $42d0
	inc de ; $42d1
	ld a, [hl+] ; $42d2
	ld [de], a ; $42d3
	inc de ; $42d4
	ret ; $42d5
CheckStorySignatureCollision:
	push de ; $42d6
	push hl ; $42d7
	ldh a, [hWramBank] ; $42d8
	push af ; $42da
	wram_bank $06 ; $42db
	ld hl, $c880 ; $42e1
	ld a, [hl+] ; $42e4
	or a, [hl] ; $42e5
	inc hl ; $42e6
	or a, [hl] ; $42e7
	inc hl ; $42e8
	or a, [hl] ; $42e9
	ld a, $ff ; $42ea
	jr z, .step ; $42ec
	ld de, $c880 ; $42ee
	ld hl, $d400 ; $42f1
	call CompareNextByte ; $42f4
	jr z, .step ; $42f7
	call CompareNextByte ; $42f9
	jr z, .step ; $42fc
	call CompareNextByte ; $42fe
	jr z, .step ; $4301
	call CompareNextByte ; $4303
	jr z, .step ; $4306
	ld de, $c880 ; $4308
	ld hl, $d404 ; $430b
	call CompareNextByte ; $430e
	jr z, .step ; $4311
	call CompareNextByte ; $4313
	jr z, .step ; $4316
	call CompareNextByte ; $4318
	jr z, .step ; $431b
	call CompareNextByte ; $431d
	jr z, .step ; $4320
	ld de, $c880 ; $4322
	ld hl, $d408 ; $4325
	call CompareNextByte ; $4328
	jr z, .step ; $432b
	call CompareNextByte ; $432d
	jr z, .step ; $4330
	call CompareNextByte ; $4332
	jr z, .step ; $4335
	call CompareNextByte ; $4337
	jr z, .step ; $433a
	xor a, a ; $433c
.step:
	ld h, a ; $433d
	pop af ; $433e
	wram_bank ; $433f
	ld a, h ; $4343
	pop hl ; $4344
	pop de ; $4345
	ret ; $4346
CompareNextByte:
	ld a, [de] ; $4347
	cp a, [hl] ; $4348
	inc de ; $4349
	inc hl ; $434a
	ld a, $ff ; $434b
	ret ; $434d
RollStoryRandomByte:
	push af ; $434e
	push bc ; $434f
	push de ; $4350
	push hl ; $4351
	ld de, $c8bb ; $4352
	add a, e ; $4355
	ld e, a ; $4356
	jr nc, .advanceRandomSeed ; $4357
	inc d ; $4359
.advanceRandomSeed:
	call AdvanceRandomSeed ; $435a
	ld a, h ; $435d
	ld [de], a ; $435e
	pop hl ; $435f
	pop de ; $4360
	pop bc ; $4361
	pop af ; $4362
	ret ; $4363
GenerateUniqueStorySaveSignature:
	push af ; $4364
	push bc ; $4365
	push de ; $4366
	push hl ; $4367
	ld hl, $c8bb ; $4368
	ld de, $c880 ; $436b
	ld a, [hl+] ; $436e
	ld [de], a ; $436f
	inc de ; $4370
	ld a, [hl+] ; $4371
	ld [de], a ; $4372
	inc de ; $4373
	ld a, [hl+] ; $4374
	ld [de], a ; $4375
	inc de ; $4376
	ld a, [hl+] ; $4377
	ld [de], a ; $4378
	inc de ; $4379
.loop:
	call CheckStorySignatureCollision ; $437a
	or a, a ; $437d
	jr z, .restore ; $437e
	call AdvanceRandomSeed ; $4380
	ld a, h ; $4383
	ld [$c880], a ; $4384
	call AdvanceRandomSeed ; $4387
	ld a, h ; $438a
	ld [$c881], a ; $438b
	call AdvanceRandomSeed ; $438e
	ld a, h ; $4391
	ld [$c882], a ; $4392
	call AdvanceRandomSeed ; $4395
	ld a, h ; $4398
	ld [$c883], a ; $4399
	jr .loop ; $439c
.restore:
	pop hl ; $439e
	pop de ; $439f
	pop bc ; $43a0
	pop af ; $43a1
	ret ; $43a2
InitPlayerRecordFromTemplate:
	push af ; $43a3
	ld a, d ; $43a4
	and a, $03 ; $43a5
	ld d, a ; $43a7
	pop af ; $43a8
	and a, $01 ; $43a9
	call GetPlayerRecordPtr ; $43ab
	push bc ; $43ae
	ld l, c ; $43af
	ld h, b ; $43b0
	ld c, $04 ; $43b1
	call ClearMemory16 ; $43b3
	pop bc ; $43b6
	ld a, d ; $43b7
	call RemapExtendedCharId ; $43b8
	ld hl, $000b ; $43bb
	add hl, bc ; $43be
	ld [hl], a ; $43bf
	ld a, d ; $43c0
	call GetCharPaletteIndex ; $43c1
	ld hl, $000c ; $43c4
	add hl, bc ; $43c7
	ld [hl], a ; $43c8
	ld a, d ; $43c9
	push de ; $43ca
	add a, $1b ; $43cb
	ld l, a ; $43cd
	adc a, $00 ; $43ce
	sub a, l ; $43d0
	ld h, a ; $43d1
	ld a, $00 ; $43d2
	add a, c ; $43d4
	ld e, a ; $43d5
	ld d, b ; $43d6
	farcall FetchShortTextToBuffer ; $43d7
	pop de ; $43da
	ld a, d ; $43db
	add a, $1b ; $43dc
	ld l, a ; $43de
	adc a, $44 ; $43df
	sub a, l ; $43e1
	ld h, a ; $43e2
	ld a, [hl] ; $43e3
	ld hl, $000d ; $43e4
	add hl, bc ; $43e7
	ld [hl], a ; $43e8
	push bc ; $43e9
	ld a, d ; $43ea
	add a, a ; $43eb
	add a, $f2 ; $43ec
	ld l, a ; $43ee
	adc a, $47 ; $43ef
	sub a, l ; $43f1
	ld h, a ; $43f2
	ld a, [hl+] ; $43f3
	ld h, [hl] ; $43f4
	ld l, a ; $43f5
	ld a, [hl+] ; $43f6
	push hl ; $43f7
	ld hl, $0018 ; $43f8
	add hl, bc ; $43fb
	ld [hl], a ; $43fc
	pop hl ; $43fd
	ld a, $30 ; $43fe
	add a, c ; $4400
	ld e, a ; $4401
	ld d, b ; $4402
	ld c, $0c ; $4403
.copyLoop:
	ld a, [hl+] ; $4405
	ld [de], a ; $4406
	inc de ; $4407
	dec c ; $4408
	jr nz, .copyLoop ; $4409
	pop bc ; $440b
	call RecomputeCharacterStats ; $440c
	ld hl, wStoryModeNameOfMainCharacter ; $440f
	ld de, wStorySlotData ; $4412
	ld c, $08 ; $4415
	call CopyMemoryFast ; $4417
	ret ; $441a
StoryCharGenderTable:
	; $441b, 4 bytes (bytes:4)
	db $00, $01, $00, $01 ; 0x00
Unused_02_441f:
	; $441f, 28 bytes (bytes:16)
	db $00, $01, $00, $00, $00, $01, $00, $01, $00, $01, $00, $00, $00, $00, $00, $01 ; 0x00
	db $00, $01, $00, $01, $00, $00, $01, $00, $00, $01, $00, $00 ; 0x10
LoadMainCharacterFromRoster:
	push de ; $443b
	ld hl, wStoryModeNameOfMainCharacter ; $443c
	ld c, $04 ; $443f
	call ClearMemory16 ; $4441
	pop de ; $4444
	ld c, d ; $4445
	ld a, d ; $4446
	and a, $3f ; $4447
	ld b, a ; $4449
	call GetStoryCharacterRecordPtr ; $444a
	ld de, wStoryModeNameOfMainCharacter ; $444d
	call Copy64Bytes ; $4450
	ld hl, $000b ; $4453
	add hl, de ; $4456
	ld [hl], b ; $4457
	ld a, b ; $4458
	call GetCharPaletteIndex ; $4459
	ld hl, $000c ; $445c
	add hl, de ; $445f
	ld [hl], a ; $4460
	ld hl, $002f ; $4461
	add hl, de ; $4464
	ld [hl], $00 ; $4465
	ld hl, $000b ; $4467
	add hl, de ; $446a
	ld a, [hl] ; $446b
	add a, l ; $446c
	ld l, a ; $446d
	jr nc, .step ; $446e
	inc h ; $4470
.step:
	ldh a, [hWramBank] ; $4471
	push af ; $4473
	pop af ; $4474
	wram_bank ; $4475
	ret ; $4479
Copy64Bytes:
	push de ; $447a
	ld c, $40 ; $447b
.loop:
	ld a, [hl+] ; $447d
	ld [de], a ; $447e
	inc de ; $447f
	dec c ; $4480
	jr nz, .loop ; $4481
	pop de ; $4483
	ret ; $4484
RefreshPlayerStatsAndGetPtr:
	call GetPlayerRecordPtr ; $4485
	ld hl, $0018 ; $4488
	add hl, bc ; $448b
	call RecomputeCharacterStats ; $448c
	ld hl, $0018 ; $448f
	add hl, bc ; $4492
	ret ; $4493
LookupStatBarLevel:
	ld e, $00 ; $4494
	ld d, $09 ; $4496
.thresholdLoop:
	push hl ; $4498
	push bc ; $4499
	ld c, [hl] ; $449a
	ld l, b ; $449b
	call SignExtendCToBC ; $449c
	call SignExtendLToHL ; $449f
	ld a, l ; $44a2
	sub a, c ; $44a3
	ld l, a ; $44a4
	ld a, h ; $44a5
	sbc a, b ; $44a6
	ld h, a ; $44a7
	ld a, h ; $44a8
	or a, l ; $44a9
	bit 7, h ; $44aa
	pop bc ; $44ac
	pop hl ; $44ad
	ret nz ; $44ae
	or a, a ; $44af
	ret z ; $44b0
	inc e ; $44b1
	inc hl ; $44b2
	dec d ; $44b3
	jr nz, .thresholdLoop ; $44b4
	ret ; $44b6
ScaleStatForBarLevel:
	ld l, [hl] ; $44b7
	ld h, $00 ; $44b8
	call MulHLByA ; $44ba
	push hl ; $44bd
	ld hl, $0018 ; $44be
	add hl, bc ; $44c1
	ld e, [hl] ; $44c2
	ld d, $00 ; $44c3
	dec e ; $44c5
	pop hl ; $44c6
	ld a, l ; $44c7
	sub a, e ; $44c8
	ld l, a ; $44c9
	ld a, h ; $44ca
	sbc a, d ; $44cb
	ld h, a ; $44cc
	push hl ; $44cd
	ld de, $ff81 ; $44ce
	add hl, de ; $44d1
	bit 7, h ; $44d2
	pop hl ; $44d4
	jr z, .clampMax ; $44d5
	push hl ; $44d7
	ld de, $007f ; $44d8
	add hl, de ; $44db
	bit 7, h ; $44dc
	pop hl ; $44de
	jr nz, .clampMin ; $44df
	ld b, l ; $44e1
	ret ; $44e2
.clampMax:
	ld b, $7f ; $44e3
	ret ; $44e5
.clampMin:
	ld b, $81 ; $44e6
	ret ; $44e8
RecomputeCharacterStats:
	push bc ; $44e9
	ld hl, $000b ; $44ea
	add hl, bc ; $44ed
	ld a, [hl] ; $44ee
	and a, $03 ; $44ef
	add a, a ; $44f1
	add a, $f2 ; $44f2
	ld l, a ; $44f4
	adc a, $47 ; $44f5
	sub a, l ; $44f7
	ld h, a ; $44f8
	ld a, [hl+] ; $44f9
	ld d, [hl] ; $44fa
	ld e, a ; $44fb
	push de ; $44fc
	push bc ; $44fd
	push de ; $44fe
	ld hl, $0038 ; $44ff
	add hl, bc ; $4502
	ld a, $05 ; $4503
	call ScaleStatForBarLevel ; $4505
	pop de ; $4508
	ld hl, $000d ; $4509
	add hl, de ; $450c
	call LookupStatBarLevel ; $450d
	pop bc ; $4510
	ld hl, $0020 ; $4511
	add hl, bc ; $4514
	ld [hl], e ; $4515
	pop de ; $4516
	push de ; $4517
	push bc ; $4518
	push de ; $4519
	ld hl, $0038 ; $451a
	add hl, bc ; $451d
	ld a, $05 ; $451e
	call ScaleStatForBarLevel ; $4520
	pop de ; $4523
	ld hl, $0016 ; $4524
	add hl, de ; $4527
	call LookupStatBarLevel ; $4528
	pop bc ; $452b
	ld hl, $0021 ; $452c
	add hl, bc ; $452f
	ld [hl], e ; $4530
	pop de ; $4531
	push de ; $4532
	push bc ; $4533
	push de ; $4534
	ld hl, $0039 ; $4535
	add hl, bc ; $4538
	ld a, $05 ; $4539
	call ScaleStatForBarLevel ; $453b
	pop de ; $453e
	ld hl, $001f ; $453f
	add hl, de ; $4542
	call LookupStatBarLevel ; $4543
	pop bc ; $4546
	ld hl, $0022 ; $4547
	add hl, bc ; $454a
	ld [hl], e ; $454b
	pop de ; $454c
	push de ; $454d
	push bc ; $454e
	push de ; $454f
	ld hl, $0039 ; $4550
	add hl, bc ; $4553
	ld a, $05 ; $4554
	call ScaleStatForBarLevel ; $4556
	pop de ; $4559
	ld hl, $0028 ; $455a
	add hl, de ; $455d
	call LookupStatBarLevel ; $455e
	pop bc ; $4561
	ld hl, $0023 ; $4562
	add hl, bc ; $4565
	ld [hl], e ; $4566
	pop de ; $4567
	push de ; $4568
	push bc ; $4569
	push de ; $456a
	ld hl, $0039 ; $456b
	add hl, bc ; $456e
	ld a, $05 ; $456f
	call ScaleStatForBarLevel ; $4571
	pop de ; $4574
	ld hl, $0031 ; $4575
	add hl, de ; $4578
	call LookupStatBarLevel ; $4579
	pop bc ; $457c
	ld hl, $0024 ; $457d
	add hl, bc ; $4580
	ld [hl], e ; $4581
	pop de ; $4582
	push de ; $4583
	push bc ; $4584
	push de ; $4585
	ld hl, $003a ; $4586
	add hl, bc ; $4589
	ld a, $05 ; $458a
	call ScaleStatForBarLevel ; $458c
	pop de ; $458f
	ld hl, $003a ; $4590
	add hl, de ; $4593
	call LookupStatBarLevel ; $4594
	pop bc ; $4597
	ld hl, $0025 ; $4598
	add hl, bc ; $459b
	ld [hl], e ; $459c
	pop de ; $459d
	push de ; $459e
	push bc ; $459f
	push de ; $45a0
	ld hl, $003a ; $45a1
	add hl, bc ; $45a4
	ld a, $05 ; $45a5
	call ScaleStatForBarLevel ; $45a7
	pop de ; $45aa
	ld hl, $0043 ; $45ab
	add hl, de ; $45ae
	call LookupStatBarLevel ; $45af
	pop bc ; $45b2
	ld hl, $0026 ; $45b3
	add hl, bc ; $45b6
	ld [hl], e ; $45b7
	pop de ; $45b8
	push de ; $45b9
	push bc ; $45ba
	push de ; $45bb
	ld hl, $003b ; $45bc
	add hl, bc ; $45bf
	ld a, $05 ; $45c0
	call ScaleStatForBarLevel ; $45c2
	pop de ; $45c5
	ld hl, $004c ; $45c6
	add hl, de ; $45c9
	call LookupStatBarLevel ; $45ca
	pop bc ; $45cd
	ld hl, $0027 ; $45ce
	add hl, bc ; $45d1
	ld [hl], e ; $45d2
	pop de ; $45d3
	push de ; $45d4
	push bc ; $45d5
	push de ; $45d6
	ld hl, $003b ; $45d7
	add hl, bc ; $45da
	ld a, $05 ; $45db
	call ScaleStatForBarLevel ; $45dd
	pop de ; $45e0
	ld hl, $0055 ; $45e1
	add hl, de ; $45e4
	call LookupStatBarLevel ; $45e5
	pop bc ; $45e8
	ld hl, $0028 ; $45e9
	add hl, bc ; $45ec
	ld [hl], e ; $45ed
	pop de ; $45ee
	push de ; $45ef
	push bc ; $45f0
	push de ; $45f1
	ld hl, $003b ; $45f2
	add hl, bc ; $45f5
	ld a, $05 ; $45f6
	call ScaleStatForBarLevel ; $45f8
	pop de ; $45fb
	ld hl, $005e ; $45fc
	add hl, de ; $45ff
	call LookupStatBarLevel ; $4600
	pop bc ; $4603
	ld hl, $0029 ; $4604
	add hl, bc ; $4607
	ld [hl], e ; $4608
	pop de ; $4609
	push de ; $460a
	push bc ; $460b
	push de ; $460c
	ld hl, $003b ; $460d
	add hl, bc ; $4610
	ld a, $05 ; $4611
	call ScaleStatForBarLevel ; $4613
	pop de ; $4616
	ld hl, $0067 ; $4617
	add hl, de ; $461a
	call LookupStatBarLevel ; $461b
	pop bc ; $461e
	ld hl, $002a ; $461f
	add hl, bc ; $4622
	ld [hl], e ; $4623
	pop de ; $4624
	ld hl, $0018 ; $4625
	add hl, bc ; $4628
	ld a, [hl] ; $4629
	ld hl, $0070 ; $462a
	add hl, de ; $462d
	ld d, a ; $462e
.modifierLoop:
	ld a, [hl+] ; $462f
	cp a, $ff ; $4630
	jr z, .copyStats ; $4632
	cp a, d ; $4634
	jr nz, .nextModifier ; $4635
	ld a, [hl] ; $4637
	push hl ; $4638
	and a, $0f ; $4639
	add a, a ; $463b
	add a, $6e ; $463c
	ld l, a ; $463e
	adc a, $46 ; $463f
	sub a, l ; $4641
	ld h, a ; $4642
	ld a, $19 ; $4643
	add a, c ; $4645
	ld e, a ; $4646
	ld d, b ; $4647
	ld a, [de] ; $4648
	or a, [hl] ; $4649
	ld [de], a ; $464a
	inc hl ; $464b
	inc de ; $464c
	ld a, [de] ; $464d
	or a, [hl] ; $464e
	ld [de], a ; $464f
	pop hl ; $4650
.nextModifier:
	inc hl ; $4651
	jr .modifierLoop ; $4652
.copyStats:
	ld hl, $0030 ; $4654
	add hl, bc ; $4657
	ld a, $10 ; $4658
	add a, c ; $465a
	ld e, a ; $465b
	ld d, b ; $465c
	ld c, $08 ; $465d
.copyLoop:
	ld a, [hl+] ; $465f
	ld [de], a ; $4660
	inc e ; $4661
	dec c ; $4662
	jr nz, .copyLoop ; $4663
	pop bc ; $4665
	push bc ; $4666
	ld a, c ; $4667
	or a, a ; $4668
	call z, ApplyStatModifiers ; $4669
	pop bc ; $466c
	ret ; $466d
CharIconMasks_02:
	; $466e, 32 bytes (bytes:2)
	db $01, $00 ; 0x00
	db $02, $00 ; 0x02
	db $04, $00 ; 0x04
	db $08, $00 ; 0x06
	db $10, $00 ; 0x08
	db $20, $00 ; 0x0a
	db $40, $00 ; 0x0c
	db $80, $00 ; 0x0e
	db $00, $01 ; 0x10
	db $00, $02 ; 0x12
	db $00, $04 ; 0x14
	db $00, $08 ; 0x16
	db $00, $10 ; 0x18
	db $00, $20 ; 0x1a
	db $00, $40 ; 0x1c
	db $00, $80 ; 0x1e
ApplyStatModifiers:
	push af ; $468e
	push bc ; $468f
	push de ; $4690
	push hl ; $4691
	push bc ; $4692
	ld hl, $003c ; $4693
	add hl, bc ; $4696
	ld a, [hl] ; $4697
	and a, $0f ; $4698
	ld d, $00 ; $469a
	call ApplyStatModifierRow ; $469c
	pop bc ; $469f
	ld hl, $003c ; $46a0
	add hl, bc ; $46a3
	ld a, [hl] ; $46a4
	swap a ; $46a5
	and a, $0f ; $46a7
	ld d, $01 ; $46a9
	call ApplyStatModifierRow ; $46ab
	pop hl ; $46ae
	pop de ; $46af
	pop bc ; $46b0
	pop af ; $46b1
	ret ; $46b2
ApplyStatModifierRow:
	push bc ; $46b3
	ld c, a ; $46b4
	ld a, d ; $46b5
	add a, a ; $46b6
	ld hl, CharStatClampPtrs_02 ; $46b7
	add a, l ; $46ba
	ld l, a ; $46bb
	jr nc, .read ; $46bc
	inc h ; $46be
.read:
	ld a, [hl+] ; $46bf
	ld h, [hl] ; $46c0
	ld l, a ; $46c1
	ld d, h ; $46c2
	ld e, l ; $46c3
	ld h, $00 ; $46c4
	ld l, c ; $46c6
	add hl, hl ; $46c7
	add hl, hl ; $46c8
	add hl, hl ; $46c9
	add hl, hl ; $46ca
	add hl, de ; $46cb
	pop bc ; $46cc
	ld a, $20 ; $46cd
	add a, c ; $46cf
	ld e, a ; $46d0
	ld d, b ; $46d1
	ld c, $0b ; $46d2
.loop:
	ld b, [hl] ; $46d4
	ld a, [de] ; $46d5
	add a, b ; $46d6
	bit 7, a ; $46d7
	jr z, .compare ; $46d9
	xor a, a ; $46db
	jr .store ; $46dc
.compare:
	cp a, $09 ; $46de
	jr c, .store ; $46e0
	ld a, $09 ; $46e2
.store:
	ld [de], a ; $46e4
	inc hl ; $46e5
	inc de ; $46e6
	dec c ; $46e7
	jr nz, .loop ; $46e8
	ret ; $46ea
CharStatClampPtrs_02:
	; $46eb, 4 bytes (records:2)
	dw CharStatClampData_02 ; record 0
	dw $475f ; record 1
CharStatClampData_02:
	; $46ef, 160 bytes (bytes:16)
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; 0x00
	db $fe, $fe, $ff, $ff, $00, $02, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; 0x10
	db $01, $01, $02, $01, $00, $fe, $fe, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; 0x20
	db $00, $00, $fe, $fe, $fe, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; 0x30
	db $00, $00, $02, $02, $ff, $ff, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; 0x40
	db $00, $00, $ff, $ff, $03, $01, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; 0x50
	db $03, $00, $fe, $fe, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; 0x60
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; 0x70
	db $00, $00, $00, $00, $00, $00, $00, $fe, $fe, $fe, $fe, $00, $00, $00, $00, $00 ; 0x80
	db $00, $00, $00, $00, $00, $00, $00, $02, $02, $fe, $fe, $00, $00, $00, $00, $00 ; 0x90
RefreshMainCharacterStats:
	ld bc, wStoryModeNameOfMainCharacter ; $478f
	call RecomputeCharacterStats ; $4792
	ld hl, wStoryModeNameOfMainCharacter ; $4795
	ld de, wStorySlotData ; $4798
	ld c, $08 ; $479b
	call CopyMemoryFast ; $479d
	ld a, [$c83c] ; $47a0
	ld b, a ; $47a3
	and a, $0f ; $47a4
	cp a, $03 ; $47a6
	jr nz, .checkHighNibble ; $47a8
	ld a, b ; $47aa
	and a, $f0 ; $47ab
	ld b, a ; $47ad
.checkHighNibble:
	ld a, b ; $47ae
	swap a ; $47af
	and a, $0f ; $47b1
	cp a, $01 ; $47b3
	jr nz, .store ; $47b5
	ld a, b ; $47b7
	and a, $0f ; $47b8
	ld b, a ; $47ba
.store:
	ld a, b ; $47bb
	ld [$c83c], a ; $47bc
	ld bc, wStorySlotData ; $47bf
	call RecomputeCharacterStats ; $47c2
	ret ; $47c5
RecomputeStatsWithoutRacket:
	ld hl, wEquippedRacket ; $47c6
	ld a, [hl] ; $47c9
	push af ; $47ca
	xor a, a ; $47cb
	ld [hl], a ; $47cc
	ld bc, wStoryModeNameOfMainCharacter ; $47cd
	call RecomputeCharacterStats ; $47d0
	pop af ; $47d3
	ld [wEquippedRacket], a ; $47d4
	ret ; $47d7
EquipData_02:
	; $47d8, 26 bytes (bytes:16)
	db $f5, $21, $0b, $00, $09, $7e, $e6, $03, $87, $c6, $f2, $6f, $ce, $47, $95, $67 ; 0x00
	db $2a, $66, $6f, $f1, $85, $6f, $30, $01, $24, $c9 ; 0x10
EquipRecordPtrs_02:
	; $47f2, 8 bytes (records:2)
	dw EquipRecords_02 ; record 0
	dw $486b ; record 1
	dw $48dc ; record 2
	dw $494d ; record 3
EquipRecords_02:
	; $47fa, 452 bytes (bytes:16)
	db $01, $79, $00, $a0, $00, $99, $09, $0d, $00, $00, $00, $00, $00, $02, $05, $08 ; 0x00
	db $0b, $0d, $10, $13, $17, $1c, $04, $07, $0a, $0d, $0f, $12, $15, $19, $1e, $03 ; 0x10
	db $08, $0b, $0f, $12, $16, $1a, $1f, $26, $fd, $02, $06, $09, $0d, $11, $15, $1b ; 0x20
	db $22, $02, $07, $0b, $0e, $12, $15, $1a, $1f, $26, $03, $08, $0b, $0e, $12, $15 ; 0x30
	db $19, $1f, $25, $04, $09, $0d, $10, $14, $17, $1c, $21, $28, $02, $05, $08, $0a ; 0x40
	db $0c, $0f, $12, $15, $1a, $fa, $fe, $01, $04, $07, $0a, $0e, $12, $18, $04, $07 ; 0x50
	db $0a, $0d, $0f, $12, $15, $19, $1e, $03, $08, $0b, $0f, $12, $16, $1a, $1f, $26 ; 0x60
	db $ff, $01, $80, $00, $a0, $00, $33, $09, $0e, $00, $00, $00, $00, $00, $04, $08 ; 0x70
	db $0b, $0e, $11, $14, $18, $1c, $22, $03, $07, $09, $0c, $0f, $11, $15, $19, $1e ; 0x80
	db $05, $0a, $0e, $11, $15, $19, $1d, $23, $2a, $03, $07, $0a, $0d, $10, $14, $17 ; 0x90
	db $1c, $22, $02, $06, $09, $0c, $0f, $12, $16, $1a, $20, $02, $06, $09, $0c, $0f ; 0xa0
	db $11, $15, $19, $1f, $fd, $01, $04, $07, $0a, $0d, $11, $15, $1b, $03, $06, $09 ; 0xb0
	db $0c, $0e, $11, $14, $18, $1d, $04, $07, $09, $0b, $0d, $10, $12, $16, $1a, $fc ; 0xc0
	db $01, $05, $09, $0d, $10, $15, $1b, $22, $02, $06, $0a, $0d, $10, $14, $18, $1d ; 0xd0
	db $23, $ff, $01, $90, $00, $a3, $00, $99, $07, $0b, $00, $00, $00, $00, $00, $fd ; 0xe0
	db $02, $06, $0a, $0e, $12, $17, $1d, $24, $02, $08, $0c, $10, $14, $18, $1d, $23 ; 0xf0
	db $2a, $f8, $fe, $03, $08, $0c, $11, $17, $1d, $26, $01, $07, $0b, $0f, $13, $18 ; 0x100
	db $1d, $23, $2b, $03, $09, $0e, $12, $16, $1b, $20, $27, $2f, $fe, $04, $08, $0d ; 0x110
	db $11, $15, $1b, $21, $29, $03, $09, $0d, $11, $15, $19, $1e, $24, $2c, $fc, $03 ; 0x120
	db $09, $0e, $13, $18, $1f, $26, $30, $02, $09, $0e, $13, $18, $1d, $23, $2b, $34 ; 0x130
	db $03, $09, $0d, $11, $15, $1a, $1f, $25, $2d, $06, $0e, $14, $1a, $20, $26, $2d ; 0x140
	db $36, $41, $ff, $01, $86, $00, $a9, $00, $c2, $07, $0b, $00, $00, $00, $00, $00 ; 0x150
	db $02, $08, $0c, $10, $14, $18, $1d, $23, $2a, $fc, $02, $06, $0a, $0e, $13, $18 ; 0x160
	db $1e, $26, $fe, $04, $09, $0e, $12, $17, $1d, $23, $2c, $04, $0a, $0e, $12, $16 ; 0x170
	db $1b, $20, $26, $2e, $02, $07, $0b, $0f, $13, $16, $1b, $21, $28, $f6, $fe, $04 ; 0x180
	db $0a, $10, $15, $1d, $25, $30, $02, $08, $0c, $10, $14, $18, $1d, $23, $2a, $03 ; 0x190
	db $09, $0e, $12, $16, $1b, $20, $27, $2f, $fd, $04, $09, $0d, $12, $17, $1d, $24 ; 0x1a0
	db $2d, $04, $0a, $0f, $13, $17, $1c, $21, $28, $30, $06, $0b, $0f, $12, $16, $19 ; 0x1b0
	db $1e, $23, $2a, $ff ; 0x1c0
LevelUpPlayer:
	call GetPlayerRecordPtr ; $49be
LevelUpPlayerRecord:
	ld hl, $0018 ; $49c1
	add hl, bc ; $49c4
	ld a, [hl] ; $49c5
	cp a, $63 ; $49c6
	jp nc, .done ; $49c8
	ld a, d ; $49cb
	or a, a ; $49cc
	jr nz, .compare ; $49cd
	ld hl, $0038 ; $49cf
	add hl, bc ; $49d2
	inc [hl] ; $49d3
	jr .step ; $49d4
.compare:
	cp a, $01 ; $49d6
	jr nz, .compare2 ; $49d8
	ld hl, $0039 ; $49da
	add hl, bc ; $49dd
	inc [hl] ; $49de
	jr .step ; $49df
.compare2:
	cp a, $02 ; $49e1
	jr nz, .compare3 ; $49e3
	ld hl, $003a ; $49e5
	add hl, bc ; $49e8
	inc [hl] ; $49e9
	jr .step ; $49ea
.compare3:
	cp a, $03 ; $49ec
	jr nz, .step ; $49ee
	ld hl, $003b ; $49f0
	add hl, bc ; $49f3
	inc [hl] ; $49f4
	jr .step ; $49f5
.step:
	ld hl, $0018 ; $49f7
	add hl, bc ; $49fa
	inc [hl] ; $49fb
	call RecomputeCharacterStats ; $49fc
.done:
	ret ; $49ff
ComputeLevelUpStatDeltas:
	ld e, a ; $4a00
	ld a, l ; $4a01
	ldh [hStatDeltaOutPtr], a ; $4a02
	ld a, h ; $4a04
	ldh [hStatDeltaOutPtr + 1], a ; $4a05
	add sp, -64 ; $4a07
	ld hl, sp + 0 ; $4a09
	ld a, l ; $4a0b
	ldh [hStatDeltaRecordCopy], a ; $4a0c
	ld a, h ; $4a0e
	ldh [hStatDeltaRecordCopy + 1], a ; $4a0f
	ld a, e ; $4a11
	call GetPlayerRecordPtr ; $4a12
	push bc ; $4a15
	push bc ; $4a16
	push de ; $4a17
	ld e, l ; $4a18
	ld d, h ; $4a19
	ld l, c ; $4a1a
	ld h, b ; $4a1b
	ld bc, $0004 ; $4a1c
	call CopyMemoryFast ; $4a1f
	pop de ; $4a22
	pop bc ; $4a23
	call LevelUpPlayerRecord ; $4a24
	ld hl, hStatDeltaRecordCopy ; $4a27
	ld a, [hl+] ; $4a2a
	ld h, [hl] ; $4a2b
	ld l, a ; $4a2c
	ld de, $0020 ; $4a2d
	add hl, de ; $4a30
	ld d, [hl] ; $4a31
	ld hl, $0020 ; $4a32
	add hl, bc ; $4a35
	ld a, [hl] ; $4a36
	sub a, d ; $4a37
	ld d, a ; $4a38
	ld hl, hStatDeltaOutPtr ; $4a39
	ld a, [hl+] ; $4a3c
	ld h, [hl] ; $4a3d
	ld l, a ; $4a3e
	ld [hl], d ; $4a3f
	inc hl ; $4a40
	ld a, l ; $4a41
	ldh [hStatDeltaOutPtr], a ; $4a42
	ld a, h ; $4a44
	ldh [hStatDeltaOutPtr + 1], a ; $4a45
	ld hl, hStatDeltaRecordCopy ; $4a47
	ld a, [hl+] ; $4a4a
	ld h, [hl] ; $4a4b
	ld l, a ; $4a4c
	ld de, $0021 ; $4a4d
	add hl, de ; $4a50
	ld d, [hl] ; $4a51
	ld hl, $0021 ; $4a52
	add hl, bc ; $4a55
	ld a, [hl] ; $4a56
	sub a, d ; $4a57
	ld d, a ; $4a58
	ld hl, hStatDeltaOutPtr ; $4a59
	ld a, [hl+] ; $4a5c
	ld h, [hl] ; $4a5d
	ld l, a ; $4a5e
	ld [hl], d ; $4a5f
	inc hl ; $4a60
	ld a, l ; $4a61
	ldh [hStatDeltaOutPtr], a ; $4a62
	ld a, h ; $4a64
	ldh [hStatDeltaOutPtr + 1], a ; $4a65
	ld hl, hStatDeltaRecordCopy ; $4a67
	ld a, [hl+] ; $4a6a
	ld h, [hl] ; $4a6b
	ld l, a ; $4a6c
	ld de, $0022 ; $4a6d
	add hl, de ; $4a70
	ld d, [hl] ; $4a71
	ld hl, $0022 ; $4a72
	add hl, bc ; $4a75
	ld a, [hl] ; $4a76
	sub a, d ; $4a77
	ld d, a ; $4a78
	ld hl, hStatDeltaOutPtr ; $4a79
	ld a, [hl+] ; $4a7c
	ld h, [hl] ; $4a7d
	ld l, a ; $4a7e
	ld [hl], d ; $4a7f
	inc hl ; $4a80
	ld a, l ; $4a81
	ldh [hStatDeltaOutPtr], a ; $4a82
	ld a, h ; $4a84
	ldh [hStatDeltaOutPtr + 1], a ; $4a85
	ld hl, hStatDeltaRecordCopy ; $4a87
	ld a, [hl+] ; $4a8a
	ld h, [hl] ; $4a8b
	ld l, a ; $4a8c
	ld de, $0023 ; $4a8d
	add hl, de ; $4a90
	ld d, [hl] ; $4a91
	ld hl, $0023 ; $4a92
	add hl, bc ; $4a95
	ld a, [hl] ; $4a96
	sub a, d ; $4a97
	ld d, a ; $4a98
	ld hl, hStatDeltaOutPtr ; $4a99
	ld a, [hl+] ; $4a9c
	ld h, [hl] ; $4a9d
	ld l, a ; $4a9e
	ld [hl], d ; $4a9f
	inc hl ; $4aa0
	ld a, l ; $4aa1
	ldh [hStatDeltaOutPtr], a ; $4aa2
	ld a, h ; $4aa4
	ldh [hStatDeltaOutPtr + 1], a ; $4aa5
	ld hl, hStatDeltaRecordCopy ; $4aa7
	ld a, [hl+] ; $4aaa
	ld h, [hl] ; $4aab
	ld l, a ; $4aac
	ld de, $0024 ; $4aad
	add hl, de ; $4ab0
	ld d, [hl] ; $4ab1
	ld hl, $0024 ; $4ab2
	add hl, bc ; $4ab5
	ld a, [hl] ; $4ab6
	sub a, d ; $4ab7
	ld d, a ; $4ab8
	ld hl, hStatDeltaOutPtr ; $4ab9
	ld a, [hl+] ; $4abc
	ld h, [hl] ; $4abd
	ld l, a ; $4abe
	ld [hl], d ; $4abf
	inc hl ; $4ac0
	ld a, l ; $4ac1
	ldh [hStatDeltaOutPtr], a ; $4ac2
	ld a, h ; $4ac4
	ldh [hStatDeltaOutPtr + 1], a ; $4ac5
	ld hl, hStatDeltaRecordCopy ; $4ac7
	ld a, [hl+] ; $4aca
	ld h, [hl] ; $4acb
	ld l, a ; $4acc
	ld de, $0025 ; $4acd
	add hl, de ; $4ad0
	ld d, [hl] ; $4ad1
	ld hl, $0025 ; $4ad2
	add hl, bc ; $4ad5
	ld a, [hl] ; $4ad6
	sub a, d ; $4ad7
	ld d, a ; $4ad8
	ld hl, hStatDeltaOutPtr ; $4ad9
	ld a, [hl+] ; $4adc
	ld h, [hl] ; $4add
	ld l, a ; $4ade
	ld [hl], d ; $4adf
	inc hl ; $4ae0
	ld a, l ; $4ae1
	ldh [hStatDeltaOutPtr], a ; $4ae2
	ld a, h ; $4ae4
	ldh [hStatDeltaOutPtr + 1], a ; $4ae5
	ld hl, hStatDeltaRecordCopy ; $4ae7
	ld a, [hl+] ; $4aea
	ld h, [hl] ; $4aeb
	ld l, a ; $4aec
	ld de, $0026 ; $4aed
	add hl, de ; $4af0
	ld d, [hl] ; $4af1
	ld hl, $0026 ; $4af2
	add hl, bc ; $4af5
	ld a, [hl] ; $4af6
	sub a, d ; $4af7
	ld d, a ; $4af8
	ld hl, hStatDeltaOutPtr ; $4af9
	ld a, [hl+] ; $4afc
	ld h, [hl] ; $4afd
	ld l, a ; $4afe
	ld [hl], d ; $4aff
	inc hl ; $4b00
	ld a, l ; $4b01
	ldh [hStatDeltaOutPtr], a ; $4b02
	ld a, h ; $4b04
	ldh [hStatDeltaOutPtr + 1], a ; $4b05
	ld hl, hStatDeltaRecordCopy ; $4b07
	ld a, [hl+] ; $4b0a
	ld h, [hl] ; $4b0b
	ld l, a ; $4b0c
	ld de, $0027 ; $4b0d
	add hl, de ; $4b10
	ld d, [hl] ; $4b11
	ld hl, $0027 ; $4b12
	add hl, bc ; $4b15
	ld a, [hl] ; $4b16
	sub a, d ; $4b17
	ld d, a ; $4b18
	ld hl, hStatDeltaOutPtr ; $4b19
	ld a, [hl+] ; $4b1c
	ld h, [hl] ; $4b1d
	ld l, a ; $4b1e
	ld [hl], d ; $4b1f
	inc hl ; $4b20
	ld a, l ; $4b21
	ldh [hStatDeltaOutPtr], a ; $4b22
	ld a, h ; $4b24
	ldh [hStatDeltaOutPtr + 1], a ; $4b25
	ld hl, hStatDeltaRecordCopy ; $4b27
	ld a, [hl+] ; $4b2a
	ld h, [hl] ; $4b2b
	ld l, a ; $4b2c
	ld de, $0028 ; $4b2d
	add hl, de ; $4b30
	ld d, [hl] ; $4b31
	ld hl, $0028 ; $4b32
	add hl, bc ; $4b35
	ld a, [hl] ; $4b36
	sub a, d ; $4b37
	ld d, a ; $4b38
	ld hl, hStatDeltaOutPtr ; $4b39
	ld a, [hl+] ; $4b3c
	ld h, [hl] ; $4b3d
	ld l, a ; $4b3e
	ld [hl], d ; $4b3f
	inc hl ; $4b40
	ld a, l ; $4b41
	ldh [hStatDeltaOutPtr], a ; $4b42
	ld a, h ; $4b44
	ldh [hStatDeltaOutPtr + 1], a ; $4b45
	ld hl, hStatDeltaRecordCopy ; $4b47
	ld a, [hl+] ; $4b4a
	ld h, [hl] ; $4b4b
	ld l, a ; $4b4c
	ld de, $0029 ; $4b4d
	add hl, de ; $4b50
	ld d, [hl] ; $4b51
	ld hl, $0029 ; $4b52
	add hl, bc ; $4b55
	ld a, [hl] ; $4b56
	sub a, d ; $4b57
	ld d, a ; $4b58
	ld hl, hStatDeltaOutPtr ; $4b59
	ld a, [hl+] ; $4b5c
	ld h, [hl] ; $4b5d
	ld l, a ; $4b5e
	ld [hl], d ; $4b5f
	inc hl ; $4b60
	ld a, l ; $4b61
	ldh [hStatDeltaOutPtr], a ; $4b62
	ld a, h ; $4b64
	ldh [hStatDeltaOutPtr + 1], a ; $4b65
	ld hl, hStatDeltaRecordCopy ; $4b67
	ld a, [hl+] ; $4b6a
	ld h, [hl] ; $4b6b
	ld l, a ; $4b6c
	ld de, $002a ; $4b6d
	add hl, de ; $4b70
	ld d, [hl] ; $4b71
	ld hl, $002a ; $4b72
	add hl, bc ; $4b75
	ld a, [hl] ; $4b76
	sub a, d ; $4b77
	ld d, a ; $4b78
	ld hl, hStatDeltaOutPtr ; $4b79
	ld a, [hl+] ; $4b7c
	ld h, [hl] ; $4b7d
	ld l, a ; $4b7e
	ld [hl], d ; $4b7f
	inc hl ; $4b80
	ld a, l ; $4b81
	ldh [hStatDeltaOutPtr], a ; $4b82
	ld a, h ; $4b84
	ldh [hStatDeltaOutPtr + 1], a ; $4b85
	pop bc ; $4b87
	ld hl, hStatDeltaRecordCopy ; $4b88
	ld a, [hl+] ; $4b8b
	ld h, [hl] ; $4b8c
	ld l, a ; $4b8d
	ld e, c ; $4b8e
	ld d, b ; $4b8f
	ld bc, $0004 ; $4b90
	call CopyMemoryFast ; $4b93
	add sp, 64 ; $4b96
	ret ; $4b98
Unused_02_ListForEach:
	add a, a ; $4b99
	add a, a ; $4b9a
	ld hl, Unused_02_4b99_Table ; $4b9b
	add a, l ; $4b9e
	ld l, a ; $4b9f
	jr nc, .step ; $4ba0
	inc h ; $4ba2
.step:
	push hl ; $4ba3
	ld d, $ff ; $4ba4
	call LevelUpPlayer ; $4ba6
	pop hl ; $4ba9
	ld a, [hl+] ; $4baa
.loop:
	or a, a ; $4bab
	jr z, .read ; $4bac
	push af ; $4bae
	push hl ; $4baf
	ld d, $00 ; $4bb0
	call LevelUpPlayer ; $4bb2
	pop hl ; $4bb5
	pop af ; $4bb6
	dec a ; $4bb7
	jr .loop ; $4bb8
.read:
	ld a, [hl+] ; $4bba
.loopB:
	or a, a ; $4bbb
	jr z, .readB ; $4bbc
	push af ; $4bbe
	push hl ; $4bbf
	ld d, $01 ; $4bc0
	call LevelUpPlayer ; $4bc2
	pop hl ; $4bc5
	pop af ; $4bc6
	dec a ; $4bc7
	jr .loopB ; $4bc8
.readB:
	ld a, [hl+] ; $4bca
.loopBB:
	or a, a ; $4bcb
	jr z, .readBB ; $4bcc
	push af ; $4bce
	push hl ; $4bcf
	ld d, $02 ; $4bd0
	call LevelUpPlayer ; $4bd2
	pop hl ; $4bd5
	pop af ; $4bd6
	dec a ; $4bd7
	jr .loopBB ; $4bd8
.readBB:
	ld a, [hl+] ; $4bda
.loopBBB:
	or a, a ; $4bdb
	jr z, .step2 ; $4bdc
	push af ; $4bde
	push hl ; $4bdf
	ld d, $03 ; $4be0
	call LevelUpPlayer ; $4be2
	pop hl ; $4be5
	pop af ; $4be6
	dec a ; $4be7
	jr .loopBBB ; $4be8
.step2:
	xor a, a ; $4bea
	ld hl, CharDataPtr_02 ; $4beb
	add a, l ; $4bee
	ld l, a ; $4bef
	jr nc, .readBBB ; $4bf0
	inc h ; $4bf2
.readBBB:
	ld a, [hl+] ; $4bf3
	ld d, [hl] ; $4bf4
	ld e, a ; $4bf5
	ld hl, $0018 ; $4bf6
	add hl, bc ; $4bf9
	ld a, [hl] ; $4bfa
	cp a, $01 ; $4bfb
	jr z, .done ; $4bfd
	ld h, d ; $4bff
	ld l, e ; $4c00
	ld d, a ; $4c01
	add a, a ; $4c02
	add a, d ; $4c03
	add a, l ; $4c04
	ld l, a ; $4c05
	jr nc, .step3 ; $4c06
	inc h ; $4c08
.step3:
	ld d, h ; $4c09
	ld e, l ; $4c0a
	ld hl, $002c ; $4c0b
	add hl, bc ; $4c0e
	ld a, [de] ; $4c0f
	ld [hl+], a ; $4c10
	inc de ; $4c11
	ld a, [de] ; $4c12
	ld [hl+], a ; $4c13
	inc de ; $4c14
	ld a, [de] ; $4c15
	ld [hl], a ; $4c16
.done:
	ret ; $4c17
Unused_02_4b99_Table:
	; $4c18, 64 bytes (bytes:16)
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; 0x00
	db $07, $03, $05, $03, $0a, $08, $06, $05, $12, $09, $0d, $06, $10, $06, $08, $04 ; 0x10
	db $00, $00, $00, $00, $08, $02, $04, $01, $0f, $03, $06, $02, $10, $0b, $0a, $08 ; 0x20
	db $06, $00, $01, $01, $07, $02, $03, $02, $13, $15, $11, $0a, $18, $0c, $0f, $07 ; 0x30
RemapExtendedCharId:
	cp a, $20 ; $4c58
	ret c ; $4c5a
	push hl ; $4c5b
	sub a, $20 ; $4c5c
	and a, $7f ; $4c5e
	add a, $6a ; $4c60
	ld l, a ; $4c62
	adc a, $4c ; $4c63
	sub a, l ; $4c65
	ld h, a ; $4c66
	ld a, [hl] ; $4c67
	pop hl ; $4c68
	ret ; $4c69
NameTextRemap_02:
	; $4c6a, 71 bytes (bytes:16)
	db $08, $09, $0b, $07, $06, $0a, $04, $05, $0a, $04, $05, $06, $09, $0b, $08, $07 ; 0x00
	db $14, $11, $0c, $08, $0a, $0b, $09, $08, $08, $08, $0b, $0b, $0b, $06, $06, $06 ; 0x10
	db $09, $09, $09, $04, $04, $04, $08, $08, $08, $0c, $0c, $0c, $0c, $0c, $0c, $0c ; 0x20
	db $0c, $1a, $1a, $1f, $0c, $0c, $0c, $0c, $0c, $0c, $0c, $1a, $1a, $1a, $1a, $1a ; 0x30
	db $1a, $1f, $1f, $1f, $1a, $1a, $1a ; 0x40
SetStorySlotFlagB:
	push af ; $4cb1
	ld a, [wCurrentStorySlot] ; $4cb2
	add a, a ; $4cb5
	add a, $cc ; $4cb6
	ld l, a ; $4cb8
	adc a, $4c ; $4cb9
	sub a, l ; $4cbb
	ld h, a ; $4cbc
	ld a, [hl+] ; $4cbd
	ld d, [hl] ; $4cbe
	ld e, a ; $4cbf
	pop af ; $4cc0
	and a, a ; $4cc1
	jr nz, .setSaveFlag ; $4cc2
	farcall ClearSaveFlag ; $4cc4
	ret ; $4cc7
.setSaveFlag:
	farcall SetSaveFlag ; $4cc8
	ret ; $4ccb
StorySlotFlagBIds_02:
	; $4ccc, 8 bytes (save_flag_ids)
	dw SAVEFLAG_STORY_SLOT0_B ; 0
	dw SAVEFLAG_STORY_SLOT1_B ; 1
	dw SAVEFLAG_STORY_SLOT2_B ; 2
	dw $04e0 ; 3: flag $04, 7
TestStorySlotFlagB:
	ld a, [wCurrentStorySlot] ; $4cd4
	add a, a ; $4cd7
	add a, $cc ; $4cd8
	ld l, a ; $4cda
	adc a, $4c ; $4cdb
	sub a, l ; $4cdd
	ld h, a ; $4cde
	ld a, [hl+] ; $4cdf
	ld d, [hl] ; $4ce0
	ld e, a ; $4ce1
	farcall TestSaveFlag ; $4ce2
	jr z, .step ; $4ce5
	ld a, $01 ; $4ce7
	ret ; $4ce9
.step:
	ld a, $00 ; $4cea
	ret ; $4cec
SetStorySlotFlagA:
	push af ; $4ced
	ld a, [wCurrentStorySlot] ; $4cee
	add a, a ; $4cf1
	add a, $08 ; $4cf2
	ld l, a ; $4cf4
	adc a, $4d ; $4cf5
	sub a, l ; $4cf7
	ld h, a ; $4cf8
	ld a, [hl+] ; $4cf9
	ld d, [hl] ; $4cfa
	ld e, a ; $4cfb
	pop af ; $4cfc
	and a, a ; $4cfd
	jr nz, .setSaveFlag ; $4cfe
	farcall ClearSaveFlag ; $4d00
	ret ; $4d03
.setSaveFlag:
	farcall SetSaveFlag ; $4d04
	ret ; $4d07
StorySlotFlagAIds_02:
	; $4d08, 8 bytes (save_flag_ids)
	dw SAVEFLAG_STORY_SLOT0_A ; 0
	dw SAVEFLAG_STORY_SLOT1_A ; 1
	dw SAVEFLAG_STORY_SLOT2_A ; 2
	dw $0460 ; 3: flag $04, 3
TestStorySlotFlagA:
	ld a, [wCurrentStorySlot] ; $4d10
	add a, a ; $4d13
	add a, $08 ; $4d14
	ld l, a ; $4d16
	adc a, $4d ; $4d17
	sub a, l ; $4d19
	ld h, a ; $4d1a
	ld a, [hl+] ; $4d1b
	ld d, [hl] ; $4d1c
	ld e, a ; $4d1d
	farcall TestSaveFlag ; $4d1e
	jr z, .step ; $4d21
	ld a, $01 ; $4d23
	ret ; $4d25
.step:
	ld a, $00 ; $4d26
	ret ; $4d28
StubAlwaysNotZero:
	push bc ; $4d29
	ld c, a ; $4d2a
	xor a, a ; $4d2b
	dec a ; $4d2c
	ld a, c ; $4d2d
	pop bc ; $4d2e
	ret ; $4d2f
AddExpCapped:
	ld a, [hl] ; $4d30
	add a, e ; $4d31
	ld [hl+], a ; $4d32
	ld a, [hl] ; $4d33
	adc a, d ; $4d34
	ld [hl+], a ; $4d35
	ld a, [hl] ; $4d36
	adc a, $00 ; $4d37
	ld [hl], a ; $4d39
	dec hl ; $4d3a
	dec hl ; $4d3b
	ld de, Value100000_02 ; $4d3c
	call Compare24Bit ; $4d3f
	ret z ; $4d42
	dec hl ; $4d43
	dec hl ; $4d44
	dec de ; $4d45
	dec de ; $4d46
	ld a, [de] ; $4d47
	ld [hl+], a ; $4d48
	inc de ; $4d49
	ld a, [de] ; $4d4a
	ld [hl+], a ; $4d4b
	inc de ; $4d4c
	ld a, [de] ; $4d4d
	ld [hl], a ; $4d4e
	ret ; $4d4f
Value100000_02:
	; $4d50, 4 bytes (bytes:4)
	db $9f, $86, $01, $c9 ; 0x00
Compare24Bit:
	ld a, [de] ; $4d54
	inc de ; $4d55
	sub a, [hl] ; $4d56
	inc hl ; $4d57
	ld a, [de] ; $4d58
	inc de ; $4d59
	sbc a, [hl] ; $4d5a
	inc hl ; $4d5b
	ld a, [de] ; $4d5c
	sbc a, [hl] ; $4d5d
	bit 7, a ; $4d5e
	ret ; $4d60
ClearCa00RecordExp:
	call GetCa00RecordPtr ; $4d61
	ld hl, $002c ; $4d64
	add hl, bc ; $4d67
	xor a, a ; $4d68
	ld [hl+], a ; $4d69
	ld [hl+], a ; $4d6a
	ld [hl+], a ; $4d6b
	ret ; $4d6c
AddExpToCa00RecordChecked:
	call StubAlwaysNotZero ; $4d6d
	ret z ; $4d70
AddExpToCa00RecordHooked:
	call StubNop ; $4d71
AddExpToCa00Record:
	call GetCa00RecordPtr ; $4d74
	ld hl, $002c ; $4d77
	add hl, bc ; $4d7a
	jp AddExpCapped ; $4d7b
StubNop:
	ret ; $4d7e
Table_02_4d7f:
	; $4d7f, 16 bytes (bytes:16)
	db $02, $02, $03, $04, $05, $07, $07, $07, $02, $02, $02, $03, $02, $02, $02, $02 ; 0x00
AddPlayerExp:
	call GetPlayerRecordPtr ; $4d8f
	ld hl, $002c ; $4d92
	add hl, bc ; $4d95
	jp AddExpCapped ; $4d96
HasReachedNextLevelExp:
	call GetPlayerRecordPtr ; $4d99
	ld hl, $0018 ; $4d9c
	add hl, bc ; $4d9f
	ld a, [hl] ; $4da0
	cp a, $63 ; $4da1
	jp nc, .step ; $4da3
	ld h, $00 ; $4da6
	ld l, a ; $4da8
	ld d, h ; $4da9
	ld e, l ; $4daa
	add hl, hl ; $4dab
	add hl, de ; $4dac
	push hl ; $4dad
	xor a, a ; $4dae
	ld hl, CharDataPtr_02 ; $4daf
	add a, l ; $4db2
	ld l, a ; $4db3
	jr nc, .read ; $4db4
	inc h ; $4db6
.read:
	ld a, [hl+] ; $4db7
	ld h, [hl] ; $4db8
	ld l, a ; $4db9
	pop de ; $4dba
	add hl, de ; $4dbb
	ld a, $2c ; $4dbc
	add a, c ; $4dbe
	ld e, a ; $4dbf
	ld d, b ; $4dc0
	jp Compare24Bit ; $4dc1
.step:
	ld a, $80 ; $4dc4
	or a, a ; $4dc6
	ret ; $4dc7
GetExpRemainingToNextLevel:
	call GetPlayerRecordPtr ; $4dc8
	ld hl, $0018 ; $4dcb
	add hl, bc ; $4dce
	ld a, [hl] ; $4dcf
	cp a, $63 ; $4dd0
	jp nc, .maxLevel ; $4dd2
	ld h, $00 ; $4dd5
	ld l, a ; $4dd7
	ld d, h ; $4dd8
	ld e, l ; $4dd9
	add hl, hl ; $4dda
	add hl, de ; $4ddb
	push hl ; $4ddc
	xor a, a ; $4ddd
	ld hl, CharDataPtr_02 ; $4dde
	add a, l ; $4de1
	ld l, a ; $4de2
	jr nc, .readTable ; $4de3
	inc h ; $4de5
.readTable:
	ld a, [hl+] ; $4de6
	ld h, [hl] ; $4de7
	ld l, a ; $4de8
	pop de ; $4de9
	add hl, de ; $4dea
	ld a, [hl+] ; $4deb
	ld h, [hl] ; $4dec
	ld l, a ; $4ded
	push hl ; $4dee
	ld hl, $002c ; $4def
	add hl, bc ; $4df2
	ld a, [hl+] ; $4df3
	ld d, [hl] ; $4df4
	ld e, a ; $4df5
	pop hl ; $4df6
	ld a, l ; $4df7
	sub a, e ; $4df8
	ld l, a ; $4df9
	ld a, h ; $4dfa
	sbc a, d ; $4dfb
	ld h, a ; $4dfc
	ret ; $4dfd
.maxLevel:
	ld hl, $0000 ; $4dfe
	ret ; $4e01
GetExpProgressInCurrentLevel:
	call GetPlayerRecordPtr ; $4e02
	ld hl, $0018 ; $4e05
	add hl, bc ; $4e08
	ld a, [hl] ; $4e09
	cp a, $63 ; $4e0a
	jr nc, .step ; $4e0c
	dec a ; $4e0e
	ld h, $00 ; $4e0f
	ld l, a ; $4e11
	ld d, h ; $4e12
	ld e, l ; $4e13
	add hl, hl ; $4e14
	add hl, de ; $4e15
	push hl ; $4e16
	xor a, a ; $4e17
	ld hl, CharDataPtr_02 ; $4e18
	add a, l ; $4e1b
	ld l, a ; $4e1c
	jr nc, .read ; $4e1d
	inc h ; $4e1f
.read:
	ld a, [hl+] ; $4e20
	ld h, [hl] ; $4e21
	ld l, a ; $4e22
	pop de ; $4e23
	add hl, de ; $4e24
	ld a, [hl+] ; $4e25
	ld d, [hl] ; $4e26
	ld e, a ; $4e27
	ld hl, $002c ; $4e28
	add hl, bc ; $4e2b
	ld a, [hl+] ; $4e2c
	ld h, [hl] ; $4e2d
	ld l, a ; $4e2e
	ld a, l ; $4e2f
	sub a, e ; $4e30
	ld l, a ; $4e31
	ld a, h ; $4e32
	sbc a, d ; $4e33
	ld h, a ; $4e34
	ret ; $4e35
.step:
	ld hl, $0000 ; $4e36
	ret ; $4e39
GetExpRequiredForLevel:
	push af ; $4e3a
	dec a ; $4e3b
	ld h, $00 ; $4e3c
	ld l, a ; $4e3e
	ld d, h ; $4e3f
	ld e, l ; $4e40
	add hl, hl ; $4e41
	add hl, de ; $4e42
	push hl ; $4e43
	xor a, a ; $4e44
	ld hl, CharDataPtr_02 ; $4e45
	add a, l ; $4e48
	ld l, a ; $4e49
	jr nc, .readPrevTable ; $4e4a
	inc h ; $4e4c
.readPrevTable:
	ld a, [hl+] ; $4e4d
	ld h, [hl] ; $4e4e
	ld l, a ; $4e4f
	pop de ; $4e50
	add hl, de ; $4e51
	ld a, [hl+] ; $4e52
	ld d, [hl] ; $4e53
	ld e, a ; $4e54
	pop af ; $4e55
	push de ; $4e56
	ld h, $00 ; $4e57
	ld l, a ; $4e59
	ld d, h ; $4e5a
	ld e, l ; $4e5b
	add hl, hl ; $4e5c
	add hl, de ; $4e5d
	push hl ; $4e5e
	xor a, a ; $4e5f
	ld hl, CharDataPtr_02 ; $4e60
	add a, l ; $4e63
	ld l, a ; $4e64
	jr nc, .readTable ; $4e65
	inc h ; $4e67
.readTable:
	ld a, [hl+] ; $4e68
	ld h, [hl] ; $4e69
	ld l, a ; $4e6a
	pop de ; $4e6b
	add hl, de ; $4e6c
	ld a, [hl+] ; $4e6d
	ld h, [hl] ; $4e6e
	ld l, a ; $4e6f
	pop de ; $4e70
	ld a, l ; $4e71
	sub a, e ; $4e72
	ld l, a ; $4e73
	ld a, h ; $4e74
	sbc a, d ; $4e75
	ld h, a ; $4e76
	ret ; $4e77
CharDataPtr_02:
	; $4e78, 2 bytes (records:2)
	dw CharData_02 ; record 0
CharData_02:
	; $4e7a, 300 bytes (bytes:16)
	db $00, $00, $00, $0f, $00, $00, $2d, $00, $00, $5a, $00, $00, $90, $00, $00, $cc ; 0x00
	db $00, $00, $0e, $01, $00, $55, $01, $00, $a1, $01, $00, $f2, $01, $00, $49, $02 ; 0x10
	db $00, $a6, $02, $00, $09, $03, $00, $72, $03, $00, $e1, $03, $00, $57, $04, $00 ; 0x20
	db $d4, $04, $00, $59, $05, $00, $e6, $05, $00, $7b, $06, $00, $19, $07, $00, $c0 ; 0x30
	db $07, $00, $71, $08, $00, $2d, $09, $00, $f4, $09, $00, $c7, $0a, $00, $a7, $0b ; 0x40
	db $00, $94, $0c, $00, $8f, $0d, $00, $99, $0e, $00, $b3, $0f, $00, $db, $10, $00 ; 0x50
	db $0f, $12, $00, $4f, $13, $00, $9c, $14, $00, $f3, $15, $00, $51, $17, $00, $af ; 0x60
	db $18, $00, $0d, $1a, $00, $6b, $1b, $00, $c9, $1c, $00, $27, $1e, $00, $85, $1f ; 0x70
	db $00, $e3, $20, $00, $41, $22, $00, $9f, $23, $00, $fd, $24, $00, $5b, $26, $00 ; 0x80
	db $b9, $27, $00, $17, $29, $00, $75, $2a, $00, $d3, $2b, $00, $31, $2d, $00, $8f ; 0x90
	db $2e, $00, $ed, $2f, $00, $4b, $31, $00, $a9, $32, $00, $07, $34, $00, $65, $35 ; 0xa0
	db $00, $c3, $36, $00, $21, $38, $00, $7f, $39, $00, $dd, $3a, $00, $3b, $3c, $00 ; 0xb0
	db $99, $3d, $00, $f7, $3e, $00, $55, $40, $00, $b3, $41, $00, $11, $43, $00, $6f ; 0xc0
	db $44, $00, $cd, $45, $00, $2b, $47, $00, $89, $48, $00, $e7, $49, $00, $45, $4b ; 0xd0
	db $00, $a3, $4c, $00, $01, $4e, $00, $5f, $4f, $00, $bd, $50, $00, $1b, $52, $00 ; 0xe0
	db $79, $53, $00, $d7, $54, $00, $35, $56, $00, $93, $57, $00, $f1, $58, $00, $4f ; 0xf0
	db $5a, $00, $ad, $5b, $00, $0b, $5d, $00, $69, $5e, $00, $c7, $5f, $00, $25, $61 ; 0x100
	db $00, $83, $62, $00, $e1, $63, $00, $3f, $65, $00, $9d, $66, $00, $fb, $67, $00 ; 0x110
	db $59, $69, $00, $b7, $6a, $00, $15, $6c, $00, $ff, $ff, $ff ; 0x120
DebugStoryStatsScreen:
	sound $05 ; $4fa6
	wram_bank $01 ; $4fa8
	ld a, $03 ; $4fae
	ldh [hDebugStepMode], a ; $4fb0
	xor a, a ; $4fb2
	ld [wCurrentStorySlot], a ; $4fb3
	farcall InitTextWindows ; $4fb6
	call EnableLCD ; $4fb9
	ld c, $7f ; $4fbc
	call BeginFadeOut ; $4fbe
	script_fade_in $7f ; $4fc1
	farcall InitStoryModeState ; $4fc6
	ld d, $00 ; $4fc9
.loop:
	farcall CheckStorySlot ; $4fcb
	or a, a ; $4fce
	jr z, .step ; $4fcf
	push de ; $4fd1
	ld hl, MenuTilemaps_02 ; $4fd2
	ld de, $0802 ; $4fd5
	call PrintString ; $4fd8
	pop de ; $4fdb
	jp .step2 ; $4fdc
.step:
	ld hl, $5202 ; $4fdf
	ld de, $0802 ; $4fe2
	call PrintString ; $4fe5
	call ValidateN64TransferRecord ; $4fe8
	or a, a ; $4feb
	jr z, .step2 ; $4fec
	push de ; $4fee
	ld hl, $c9b0 ; $4fef
	ld a, [hl+] ; $4ff2
	ld h, [hl] ; $4ff3
	ld l, a ; $4ff4
	ld de, $0210 ; $4ff5
	call PrintDecimalWord ; $4ff8
	ld hl, $c9b2 ; $4ffb
	ld a, [hl+] ; $4ffe
	ld h, [hl] ; $4fff
	ld l, a ; $5000
	ld de, $0a10 ; $5001
	call PrintDecimalWord ; $5004
	pop de ; $5007
	ld hl, $c9b0 ; $5008
	xor a, a ; $500b
	ld [hl+], a ; $500c
	ld [hl+], a ; $500d
	ld [hl+], a ; $500e
	ld [hl+], a ; $500f
	ld [hl+], a ; $5010
	ld [hl+], a ; $5011
	ld [hl+], a ; $5012
	ld [hl+], a ; $5013
	jr .loopB ; $5014
.step2:
	push de ; $5016
	ld hl, $521a ; $5017
	ld de, $0210 ; $501a
	call PrintString ; $501d
	ld hl, $521a ; $5020
	ld de, $0810 ; $5023
	call PrintString ; $5026
	pop de ; $5029
.loopB:
	push de ; $502a
	ld bc, wStoryModeNameOfMainCharacter ; $502b
	ld a, [wCurrentStorySlot] ; $502e
	ld de, $0202 ; $5031
	call PrintDecimalByte ; $5034
	ld hl, $000b ; $5037
	add hl, bc ; $503a
	ld a, [hl] ; $503b
	ld de, $0204 ; $503c
	call PrintDecimalByte ; $503f
	ld hl, $0018 ; $5042
	add hl, bc ; $5045
	ld a, [hl] ; $5046
	ld de, $0206 ; $5047
	call PrintDecimalByte ; $504a
	ld hl, $0019 ; $504d
	add hl, bc ; $5050
	ld a, [hl+] ; $5051
	ld h, [hl] ; $5052
	ld l, a ; $5053
	ld de, $0207 ; $5054
	call PrintHexWord ; $5057
	ld hl, $0030 ; $505a
	add hl, bc ; $505d
	ld a, [hl+] ; $505e
	ld h, [hl] ; $505f
	ld l, a ; $5060
	ld de, $0209 ; $5061
	call PrintHexWord ; $5064
	ld hl, $0032 ; $5067
	add hl, bc ; $506a
	ld a, [hl+] ; $506b
	ld h, [hl] ; $506c
	ld l, a ; $506d
	ld de, $020a ; $506e
	call PrintHexWord ; $5071
	ld hl, $0034 ; $5074
	add hl, bc ; $5077
	ld a, [hl+] ; $5078
	ld h, [hl] ; $5079
	ld l, a ; $507a
	ld de, $020b ; $507b
	call PrintHexWord ; $507e
	ld hl, $0036 ; $5081
	add hl, bc ; $5084
	ld a, [hl+] ; $5085
	ld h, [hl] ; $5086
	ld l, a ; $5087
	ld de, $020c ; $5088
	call PrintHexWord ; $508b
	ld hl, $000e ; $508e
	add hl, bc ; $5091
	ld a, [hl] ; $5092
	ld de, $020e ; $5093
	call PrintDecimalByte ; $5096
	ld hl, $0038 ; $5099
	add hl, bc ; $509c
	ld a, [hl] ; $509d
	ld de, $0704 ; $509e
	call PrintDecimalByte ; $50a1
	ld hl, $0039 ; $50a4
	add hl, bc ; $50a7
	ld a, [hl] ; $50a8
	ld de, $0706 ; $50a9
	call PrintDecimalByte ; $50ac
	ld hl, $003a ; $50af
	add hl, bc ; $50b2
	ld a, [hl] ; $50b3
	ld de, $0709 ; $50b4
	call PrintDecimalByte ; $50b7
	ld hl, $003b ; $50ba
	add hl, bc ; $50bd
	ld a, [hl] ; $50be
	ld de, $070b ; $50bf
	call PrintDecimalByte ; $50c2
	ld hl, $0020 ; $50c5
	add hl, bc ; $50c8
	ld a, [hl] ; $50c9
	ld de, $0c04 ; $50ca
	call PrintDecimalByte ; $50cd
	ld hl, $0021 ; $50d0
	add hl, bc ; $50d3
	ld a, [hl] ; $50d4
	ld de, $0c05 ; $50d5
	call PrintDecimalByte ; $50d8
	ld hl, $0022 ; $50db
	add hl, bc ; $50de
	ld a, [hl] ; $50df
	ld de, $0c06 ; $50e0
	call PrintDecimalByte ; $50e3
	ld hl, $0023 ; $50e6
	add hl, bc ; $50e9
	ld a, [hl] ; $50ea
	ld de, $0c07 ; $50eb
	call PrintDecimalByte ; $50ee
	ld hl, $0024 ; $50f1
	add hl, bc ; $50f4
	ld a, [hl] ; $50f5
	ld de, $0c08 ; $50f6
	call PrintDecimalByte ; $50f9
	ld hl, $0025 ; $50fc
	add hl, bc ; $50ff
	ld a, [hl] ; $5100
	ld de, $0c09 ; $5101
	call PrintDecimalByte ; $5104
	ld hl, $0026 ; $5107
	add hl, bc ; $510a
	ld a, [hl] ; $510b
	ld de, $0c0a ; $510c
	call PrintDecimalByte ; $510f
	ld hl, $0027 ; $5112
	add hl, bc ; $5115
	ld a, [hl] ; $5116
	ld de, $0c0b ; $5117
	call PrintDecimalByte ; $511a
	ld hl, $0028 ; $511d
	add hl, bc ; $5120
	ld a, [hl] ; $5121
	ld de, $0c0c ; $5122
	call PrintDecimalByte ; $5125
	ld hl, $0029 ; $5128
	add hl, bc ; $512b
	ld a, [hl] ; $512c
	ld de, $0c0d ; $512d
	call PrintDecimalByte ; $5130
	ld hl, $002a ; $5133
	add hl, bc ; $5136
	ld a, [hl] ; $5137
	ld de, $0c0e ; $5138
	call PrintDecimalByte ; $513b
	pop de ; $513e
.loopBB:
	call AdvanceFrame ; $513f
	call AdvanceRandomSeed ; $5142
	ldh a, [hInputPressed] ; $5145
	bit PADB_UP, a ; $5147
	jr z, .step3 ; $5149
	push de ; $514b
	ld a, $00 ; $514c
	ld d, $00 ; $514e
	call LevelUpPlayer ; $5150
	pop de ; $5153
	sound $5e ; $5154
	jp .loopB ; $5156
.step3:
	bit 5, a ; $5159
	jr z, .step4 ; $515b
	push de ; $515d
	ld a, $00 ; $515e
	ld d, $01 ; $5160
	call LevelUpPlayer ; $5162
	pop de ; $5165
	sound $5e ; $5166
	jp .loopB ; $5168
.step4:
	bit 4, a ; $516b
	jr z, .step5 ; $516d
	push de ; $516f
	ld a, $00 ; $5170
	ld d, $02 ; $5172
	call LevelUpPlayer ; $5174
	pop de ; $5177
	sound $5e ; $5178
	jp .loopB ; $517a
.step5:
	bit 7, a ; $517d
	jr z, .step6 ; $517f
	push de ; $5181
	ld a, $00 ; $5182
	ld d, $03 ; $5184
	call LevelUpPlayer ; $5186
	pop de ; $5189
	sound $5e ; $518a
	jp .loopB ; $518c
.step6:
	bit 1, a ; $518f
	jr z, .step7 ; $5191
	push de ; $5193
	ld a, $01 ; $5194
	ldh [hDebugStepMode], a ; $5196
	sound $05 ; $5198
	ld a, $03 ; $519a
	ldh [hDebugStepMode], a ; $519c
	pop de ; $519e
	jp .loopB ; $519f
.step7:
	bit 0, a ; $51a2
	jr z, .step8 ; $51a4
	push af ; $51a6
	push bc ; $51a7
	push de ; $51a8
	push hl ; $51a9
	farcall InitStoryModeState ; $51aa
	pop hl ; $51ad
	pop de ; $51ae
	pop bc ; $51af
	pop af ; $51b0
	ld a, d ; $51b1
	inc a ; $51b2
	and a, $07 ; $51b3
	ld d, a ; $51b5
	xor a, a ; $51b6
	push de ; $51b7
	res 2, d ; $51b8
	call InitPlayerRecordFromTemplate ; $51ba
	pop de ; $51bd
	bit 2, d ; $51be
	jp z, .loopB ; $51c0
	ld a, $01 ; $51c3
	ld [wStoryModeMainCharacterLeftHanded], a ; $51c5
	jp .loopB ; $51c8
.step8:
	bit 2, a ; $51cb
	jr z, .step9 ; $51cd
	sound $5f ; $51cf
	ld a, [wCurrentStorySlot] ; $51d1
	inc a ; $51d4
	cp a, $03 ; $51d5
	jr c, .store ; $51d7
	xor a, a ; $51d9
.store:
	ld [wCurrentStorySlot], a ; $51da
	jp .loop ; $51dd
.step9:
	bit 3, a ; $51e0
	jr z, .label_02_513f ; $51e2
	sound $5f ; $51e4
	push de ; $51e6
	ld hl, $520a ; $51e7
	ld de, $0802 ; $51ea
	call PrintString ; $51ed
	farcall SaveStorySlotWithTimer ; $51f0
	pop de ; $51f3
	jp .loopB ; $51f4
.label_02_513f:
	jp .loopBB ; $51f7
MenuTilemaps_02:
	; $51fa, 77 bytes (bytes:16)
	db $46, $41, $49, $4c, $45, $44, $20, $00, $4c, $4f, $41, $44, $45, $44, $20, $00 ; 0x00
	db $53, $41, $56, $45, $44, $20, $20, $00, $44, $45, $4c, $45, $54, $45, $44, $00 ; 0x10
	db $20, $20, $20, $20, $20, $20, $00, $00, $01, $02, $03, $04, $05, $06, $07, $08 ; 0x20
	db $09, $0a, $0b, $0c, $0d, $00, $00, $00, $00, $00, $00, $00, $00, $4d, $41, $52 ; 0x30
	db $49, $4f, $20, $47, $4f, $4c, $46, $20, $47, $42, $20, $43, $48 ; 0x40
LoadStorySlot:
	push de ; $5247
	ld hl, wStorySlotData ; $5248
	ld b, a ; $524b
	ld c, a ; $524c
	push bc ; $524d
	ld [wCurrentStorySlot], a ; $524e
	farcall CheckStorySlot ; $5251
	pop bc ; $5254
	pop de ; $5255
	or a, a ; $5256
	jr z, .step2 ; $5257
	ld a, [$c33f] ; $5259
	or a, a ; $525c
	ld a, h ; $525d
	jr nz, .step ; $525e
	ld a, $3f ; $5260
	ld [wPlayer1CurrentMainCharacter], a ; $5262
	ld a, $03 ; $5265
	ld [$ca0c], a ; $5267
	ld a, b ; $526a
	ld [wCurrentStorySlot], a ; $526b
	ret ; $526e
.step:
	ld a, $ff ; $526f
	ld [wPlayer1CurrentMainCharacter], a ; $5271
	ret ; $5274
.step2:
	push bc ; $5275
	push de ; $5276
	xor a, a ; $5277
	ld [wCurrentStorySlot], a ; $5278
	ld bc, $8000 ; $527b
	call InitCa00RecordFromCharId ; $527e
	pop de ; $5281
	pop bc ; $5282
	ret ; $5283
Unused_02_StorySlotVariant:
	push de ; $5284
	ld hl, wStorySlotData ; $5285
	ld b, a ; $5288
	ld c, a ; $5289
	push bc ; $528a
	ld [wCurrentStorySlot], a ; $528b
	farcall CheckStorySlot ; $528e
	pop bc ; $5291
	pop de ; $5292
	or a, a ; $5293
	jr z, .step ; $5294
	ld a, $ff ; $5296
	ld [wPlayer1CurrentMainCharacter], a ; $5298
	ld a, $ff ; $529b
	ret ; $529d
.step:
	push bc ; $529e
	push de ; $529f
	ld bc, $8000 ; $52a0
	call InitCa00RecordFromCharId ; $52a3
	pop de ; $52a6
	pop bc ; $52a7
	xor a, a ; $52a8
	ret ; $52a9
LoadCharacterRecordToCa80:
	push af ; $52aa
	push bc ; $52ab
	push de ; $52ac
	push hl ; $52ad
	bit 7, a ; $52ae
	jr z, .step ; $52b0
	res 7, a ; $52b2
	call LoadStorySlot ; $52b4
	ld hl, $ca00 ; $52b7
	ld de, $ca80 ; $52ba
	ld c, $08 ; $52bd
	call CopyMemoryFast ; $52bf
	jr .restore ; $52c2
.step:
	ld b, a ; $52c4
	ld c, $02 ; $52c5
	call InitCa00RecordFromCharId ; $52c7
.restore:
	pop hl ; $52ca
	pop de ; $52cb
	pop bc ; $52cc
	pop af ; $52cd
	ret ; $52ce
StoryCharacterRecords_02:
	; $52cf, 2900 bytes (records:29)
; 100 records x 29 bytes
	db $01, $80, $00, $a0, $00, $00, $08, $0c, $00, $01, $80, $00, $12, $0c, $0a, $c8, $00, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $00 ; record 0
	db $01, $80, $00, $a0, $00, $00, $08, $0c, $00, $01, $80, $00, $12, $0c, $0a, $c8, $00, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $00 ; record 1
	db $01, $80, $00, $a0, $00, $00, $08, $0c, $00, $01, $80, $00, $12, $0c, $0a, $c8, $00, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $00 ; record 2
	db $01, $80, $00, $a0, $00, $00, $08, $0c, $00, $01, $80, $00, $12, $0c, $0a, $c8, $00, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $00 ; record 3
	db $01, $80, $00, $a0, $00, $00, $08, $0c, $00, $02, $80, $00, $1b, $12, $0e, $46, $00, $00, $00, $00, $00, $01, $00, $01, $03, $04, $00, $00, $00 ; record 4
	db $01, $80, $00, $a0, $00, $00, $08, $0c, $00, $02, $80, $00, $19, $13, $0a, $50, $00, $00, $02, $00, $00, $01, $05, $07, $00, $00, $01, $01, $00 ; record 5
	db $01, $80, $00, $a0, $00, $00, $08, $0c, $00, $02, $80, $00, $1e, $1c, $0d, $1e, $00, $03, $02, $02, $02, $01, $02, $02, $02, $02, $03, $02, $00 ; record 6
	db $01, $80, $00, $a0, $00, $00, $08, $0c, $00, $03, $80, $00, $16, $12, $0a, $a0, $00, $02, $02, $00, $01, $02, $05, $04, $01, $02, $01, $00, $00 ; record 7
	db $01, $80, $00, $a0, $00, $00, $08, $0c, $00, $03, $80, $00, $16, $12, $0a, $a0, $00, $03, $01, $06, $05, $03, $00, $00, $00, $01, $01, $02, $00 ; record 8
	db $01, $80, $00, $a0, $00, $00, $08, $0c, $00, $03, $80, $00, $16, $11, $0a, $a0, $00, $02, $00, $01, $02, $01, $02, $01, $06, $07, $03, $02, $00 ; record 9
	db $01, $80, $00, $a0, $00, $00, $08, $0c, $00, $04, $80, $00, $12, $0c, $0a, $aa, $00, $02, $01, $05, $06, $04, $02, $02, $02, $03, $02, $03, $00 ; record 10
	db $01, $80, $00, $a0, $00, $00, $08, $0c, $00, $04, $80, $00, $12, $0c, $0a, $aa, $00, $07, $08, $03, $02, $01, $03, $02, $01, $02, $01, $02, $00 ; record 11
	db $01, $80, $00, $a0, $00, $00, $08, $0c, $00, $04, $80, $00, $0f, $0a, $08, $aa, $00, $03, $02, $03, $04, $03, $04, $03, $04, $03, $03, $03, $00 ; record 12
	db $01, $80, $00, $a0, $00, $00, $08, $0c, $00, $05, $80, $00, $0a, $09, $05, $c8, $00, $03, $03, $04, $03, $02, $04, $05, $04, $04, $03, $03, $00 ; record 13
	db $01, $80, $00, $a0, $00, $00, $08, $0c, $00, $05, $80, $00, $0a, $09, $05, $c8, $00, $01, $04, $02, $03, $04, $08, $07, $04, $03, $02, $03, $00 ; record 14
	db $01, $80, $00, $a0, $00, $00, $08, $0c, $00, $05, $80, $00, $0a, $09, $05, $c8, $00, $04, $01, $03, $05, $04, $04, $02, $07, $06, $04, $03, $00 ; record 15
	db $01, $80, $00, $a0, $00, $00, $08, $0c, $00, $05, $80, $02, $0a, $09, $05, $e6, $08, $04, $04, $05, $04, $03, $05, $04, $04, $04, $03, $03, $00 ; record 16
	db $01, $80, $00, $a0, $00, $00, $08, $12, $00, $05, $80, $00, $08, $07, $03, $dc, $03, $04, $02, $03, $04, $05, $04, $03, $07, $08, $05, $04, $00 ; record 17
	db $01, $80, $00, $a0, $00, $00, $08, $0c, $00, $05, $80, $00, $0a, $09, $05, $b4, $00, $07, $01, $07, $08, $05, $02, $03, $03, $02, $02, $04, $00 ; record 18
	db $01, $80, $00, $a0, $00, $00, $08, $0c, $00, $05, $80, $01, $08, $07, $03, $ff, $07, $09, $09, $03, $04, $05, $04, $03, $04, $02, $03, $03, $00 ; record 19
	db $01, $80, $00, $a0, $00, $00, $08, $0c, $00, $05, $80, $00, $09, $08, $04, $dc, $00, $04, $03, $03, $04, $04, $07, $06, $05, $04, $04, $05, $00 ; record 20
	db $01, $80, $00, $a0, $00, $00, $08, $0c, $00, $01, $80, $00, $12, $0c, $0a, $c8, $00, $00, $00, $00, $00, $00, $09, $09, $01, $09, $09, $09, $00 ; record 21
	db $01, $80, $00, $a0, $00, $00, $08, $0c, $00, $01, $80, $00, $12, $0c, $0a, $c8, $00, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $00 ; record 22
	db $01, $90, $00, $a0, $00, $00, $08, $0c, $00, $05, $80, $00, $20, $1c, $0e, $3c, $00, $00, $03, $04, $05, $08, $04, $05, $04, $06, $03, $03, $00 ; record 23
	db $01, $90, $00, $b0, $00, $00, $08, $0c, $00, $05, $80, $00, $20, $1c, $0e, $3c, $00, $00, $02, $06, $07, $04, $02, $03, $04, $05, $00, $03, $00 ; record 24
	db $01, $70, $00, $a0, $00, $00, $08, $0c, $00, $05, $80, $00, $20, $1c, $0e, $3c, $00, $03, $02, $05, $05, $06, $08, $07, $05, $06, $05, $09, $00 ; record 25
	db $01, $80, $00, $a0, $00, $00, $09, $0c, $00, $05, $80, $00, $20, $1c, $0e, $3c, $00, $03, $02, $05, $06, $05, $04, $06, $06, $05, $03, $03, $00 ; record 26
	db $02, $a0, $00, $a6, $00, $00, $08, $0c, $00, $05, $80, $00, $20, $1c, $0e, $3c, $00, $00, $03, $04, $04, $08, $01, $08, $03, $06, $06, $03, $00 ; record 27
	db $00, $80, $00, $a0, $00, $00, $08, $0c, $00, $05, $80, $00, $20, $1c, $0e, $3c, $00, $02, $03, $04, $05, $04, $05, $07, $06, $08, $03, $05, $00 ; record 28
	db $00, $90, $00, $b0, $00, $80, $07, $0b, $00, $05, $80, $00, $20, $1c, $0e, $3c, $00, $02, $00, $06, $07, $04, $03, $05, $04, $02, $03, $03, $00 ; record 29
	db $01, $80, $00, $a0, $00, $00, $08, $0c, $00, $05, $80, $00, $20, $1c, $0e, $3c, $00, $03, $00, $06, $07, $05, $05, $06, $05, $04, $04, $05, $00 ; record 30
	db $01, $80, $00, $a0, $00, $00, $08, $0c, $00, $05, $80, $00, $20, $1c, $0e, $3c, $00, $01, $03, $04, $04, $06, $05, $09, $04, $07, $07, $08, $00 ; record 31
	db $01, $80, $00, $a0, $00, $00, $08, $0c, $00, $02, $80, $00, $16, $12, $0a, $a0, $00, $02, $01, $05, $04, $02, $00, $00, $00, $00, $00, $01, $00 ; record 32
	db $01, $80, $00, $a0, $00, $00, $08, $0c, $00, $02, $80, $00, $18, $14, $0b, $96, $00, $02, $00, $01, $02, $01, $01, $00, $04, $05, $02, $01, $00 ; record 33
	db $01, $80, $00, $a0, $00, $00, $08, $0c, $00, $02, $80, $00, $1a, $18, $0c, $78, $00, $05, $06, $02, $01, $00, $02, $01, $00, $01, $00, $01, $00 ; record 34
	db $01, $80, $00, $a0, $00, $00, $08, $0c, $00, $02, $80, $00, $1f, $1f, $0e, $28, $00, $02, $01, $01, $00, $01, $00, $01, $00, $01, $01, $01, $00 ; record 35
	db $01, $80, $00, $a0, $00, $00, $08, $0c, $00, $02, $80, $00, $1e, $1c, $0d, $1e, $00, $03, $02, $02, $02, $01, $02, $02, $02, $02, $03, $02, $00 ; record 36
	db $01, $80, $00, $a0, $00, $00, $08, $0c, $00, $02, $80, $00, $1f, $18, $0a, $32, $00, $01, $00, $03, $04, $02, $00, $00, $00, $01, $00, $01, $00 ; record 37
	db $01, $80, $00, $a0, $00, $00, $08, $0c, $00, $02, $80, $00, $1b, $12, $0e, $46, $00, $00, $00, $00, $00, $01, $00, $01, $03, $04, $00, $00, $00 ; record 38
	db $01, $80, $00, $a0, $00, $00, $08, $0c, $00, $02, $80, $00, $19, $13, $0a, $50, $00, $00, $02, $00, $00, $01, $05, $07, $00, $00, $01, $01, $00 ; record 39
	db $01, $80, $00, $a0, $00, $00, $08, $0c, $00, $03, $80, $00, $12, $0c, $0a, $aa, $00, $01, $00, $04, $05, $03, $02, $02, $01, $02, $01, $02, $00 ; record 40
	db $01, $80, $00, $a0, $00, $00, $08, $0c, $00, $03, $80, $00, $13, $0e, $0a, $a0, $00, $01, $02, $00, $01, $02, $01, $02, $06, $07, $04, $02, $00 ; record 41
	db $01, $80, $00, $a0, $00, $00, $08, $0c, $00, $03, $80, $00, $14, $10, $0a, $a0, $00, $01, $03, $01, $00, $02, $06, $07, $01, $01, $02, $02, $00 ; record 42
	db $01, $80, $00, $a0, $00, $00, $08, $0c, $00, $03, $80, $00, $15, $11, $0a, $a0, $00, $03, $02, $02, $02, $01, $02, $02, $02, $02, $03, $02, $00 ; record 43
	db $01, $80, $00, $a0, $00, $00, $08, $0c, $00, $03, $80, $00, $16, $11, $0a, $a0, $00, $02, $00, $01, $02, $01, $02, $01, $06, $07, $03, $02, $00 ; record 44
	db $01, $80, $00, $a0, $00, $00, $08, $0c, $00, $03, $80, $00, $16, $11, $0a, $a0, $00, $06, $07, $02, $01, $00, $02, $01, $00, $01, $00, $01, $00 ; record 45
	db $01, $80, $00, $a0, $00, $00, $08, $0c, $00, $03, $80, $00, $16, $12, $0a, $a0, $00, $03, $01, $06, $05, $03, $00, $00, $00, $01, $01, $02, $00 ; record 46
	db $01, $80, $00, $a0, $00, $00, $08, $0c, $00, $03, $80, $00, $16, $12, $0a, $a0, $00, $02, $02, $01, $02, $02, $03, $02, $03, $02, $01, $01, $00 ; record 47
	db $01, $80, $00, $a0, $00, $00, $08, $0c, $00, $04, $80, $00, $0f, $0a, $0a, $b4, $00, $04, $03, $03, $04, $04, $07, $06, $05, $04, $04, $05, $00 ; record 48
	db $01, $80, $00, $a0, $00, $00, $08, $0c, $00, $04, $80, $00, $10, $0b, $0a, $aa, $00, $04, $02, $03, $04, $05, $03, $02, $07, $08, $05, $04, $00 ; record 49
	db $01, $80, $00, $a0, $00, $00, $08, $0c, $00, $04, $80, $00, $0f, $0a, $08, $aa, $00, $03, $02, $03, $04, $03, $04, $03, $04, $03, $03, $03, $00 ; record 50
	db $01, $80, $00, $a0, $00, $00, $08, $0c, $00, $04, $80, $00, $12, $0c, $0a, $aa, $00, $05, $01, $07, $06, $04, $01, $01, $01, $02, $02, $03, $00 ; record 51
	db $01, $80, $00, $a0, $00, $00, $08, $0c, $00, $04, $80, $00, $12, $0c, $0a, $aa, $00, $02, $01, $05, $06, $04, $02, $02, $02, $03, $02, $03, $00 ; record 52
	db $01, $80, $00, $a0, $00, $00, $08, $0c, $00, $04, $80, $00, $12, $0c, $0a, $aa, $00, $07, $08, $03, $02, $01, $03, $02, $01, $02, $01, $02, $00 ; record 53
	db $01, $80, $00, $a0, $00, $00, $08, $0c, $00, $01, $80, $00, $12, $0c, $0a, $c8, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; record 54
	db $01, $80, $00, $a0, $00, $00, $08, $0c, $00, $01, $80, $00, $12, $20, $0a, $c8, $00, $04, $05, $05, $04, $04, $02, $02, $01, $00, $00, $01, $00 ; record 55
	db $01, $80, $00, $a0, $00, $00, $08, $0c, $00, $01, $80, $00, $12, $2c, $0a, $c8, $00, $09, $09, $09, $08, $08, $06, $06, $01, $00, $00, $01, $00 ; record 56
	db $01, $80, $00, $a0, $00, $00, $08, $0c, $00, $01, $80, $00, $12, $19, $0a, $c8, $00, $09, $09, $09, $08, $08, $07, $07, $03, $02, $02, $03, $00 ; record 57
	db $01, $80, $00, $a0, $00, $00, $08, $0c, $00, $01, $80, $00, $12, $fa, $0a, $c8, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; record 58
	db $01, $80, $00, $a0, $00, $00, $08, $0c, $00, $01, $80, $00, $12, $fa, $0a, $c8, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; record 59
	db $01, $80, $00, $a0, $00, $00, $08, $0c, $00, $01, $80, $00, $12, $fa, $0a, $c8, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; record 60
	db $03, $80, $00, $a0, $00, $00, $08, $0c, $00, $01, $80, $00, $24, $06, $12, $28, $00, $00, $01, $00, $00, $01, $00, $01, $06, $07, $04, $04, $00 ; record 61
	db $04, $80, $00, $a0, $00, $00, $08, $0c, $00, $01, $80, $00, $24, $08, $00, $28, $05, $01, $02, $02, $02, $03, $02, $03, $06, $07, $04, $04, $00 ; record 62
	db $03, $80, $00, $a0, $00, $00, $08, $0c, $00, $01, $80, $00, $1e, $00, $0a, $28, $00, $02, $03, $00, $00, $01, $03, $04, $06, $07, $04, $04, $00 ; record 63
	db $00, $80, $00, $a0, $00, $00, $08, $0c, $00, $01, $80, $00, $12, $00, $0a, $28, $00, $00, $00, $00, $00, $00, $00, $01, $06, $07, $04, $04, $00 ; record 64
	db $04, $80, $00, $a0, $00, $00, $08, $0c, $00, $01, $80, $00, $24, $00, $0a, $28, $05, $01, $01, $00, $01, $00, $02, $03, $07, $08, $05, $05, $00 ; record 65
	db $05, $80, $00, $a0, $00, $00, $08, $0c, $00, $01, $80, $00, $12, $00, $0a, $78, $05, $02, $02, $01, $02, $01, $03, $04, $08, $09, $06, $06, $00 ; record 66
	db $05, $80, $00, $a0, $00, $00, $08, $0c, $00, $01, $80, $00, $12, $14, $0a, $32, $03, $00, $00, $00, $09, $00, $00, $00, $00, $00, $00, $00, $00 ; record 67
	db $06, $80, $00, $a0, $00, $00, $05, $0c, $00, $01, $80, $00, $12, $18, $0c, $28, $00, $01, $02, $04, $02, $03, $02, $03, $03, $04, $04, $04, $04 ; record 68
	db $06, $80, $00, $a0, $00, $00, $08, $0c, $00, $01, $80, $00, $12, $0c, $0a, $c8, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; record 69
	db $01, $80, $00, $a0, $00, $00, $08, $0c, $00, $01, $80, $00, $12, $0c, $0a, $c8, $00, $00, $00, $04, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; record 70
	db $06, $80, $00, $a0, $00, $00, $02, $0c, $00, $01, $80, $00, $28, $00, $0c, $28, $01, $01, $02, $04, $02, $03, $02, $03, $09, $09, $04, $04, $00 ; record 71
	db $06, $60, $00, $a0, $00, $00, $02, $0c, $00, $01, $80, $00, $28, $00, $0c, $28, $03, $01, $02, $02, $02, $03, $02, $03, $09, $09, $09, $04, $00 ; record 72
	db $01, $80, $00, $a0, $00, $00, $08, $0c, $00, $01, $80, $00, $12, $0c, $0a, $c8, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; record 73
	db $01, $80, $00, $a0, $00, $00, $08, $0c, $00, $01, $80, $00, $12, $0c, $0a, $c8, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; record 74
	db $01, $80, $00, $a0, $00, $00, $08, $0c, $00, $01, $80, $00, $12, $0c, $0a, $c8, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; record 75
	db $01, $80, $00, $a0, $00, $00, $08, $0c, $00, $01, $80, $00, $12, $14, $0a, $c8, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; record 76
	db $01, $80, $00, $a0, $00, $00, $08, $0c, $00, $01, $80, $00, $12, $0c, $0a, $c8, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; record 77
	db $01, $80, $00, $a0, $00, $00, $08, $0c, $00, $01, $80, $00, $12, $0c, $0a, $c8, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; record 78
	db $01, $80, $00, $a0, $00, $00, $08, $0c, $00, $01, $80, $00, $12, $0c, $0a, $c8, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; record 79
	db $01, $80, $00, $a0, $00, $00, $08, $0c, $00, $01, $80, $00, $12, $14, $0a, $c8, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; record 80
	db $01, $80, $00, $a0, $00, $00, $08, $0c, $00, $01, $80, $00, $12, $0c, $0a, $c8, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; record 81
	db $01, $80, $00, $a0, $00, $00, $08, $0c, $00, $01, $80, $00, $12, $0c, $0a, $c8, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; record 82
	db $01, $80, $00, $a0, $00, $00, $08, $0c, $00, $01, $80, $00, $12, $0c, $0a, $c8, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; record 83
	db $03, $80, $00, $a0, $00, $00, $08, $0c, $00, $01, $80, $00, $20, $00, $12, $28, $00, $00, $01, $00, $00, $01, $00, $01, $09, $09, $06, $06, $00 ; record 84
	db $02, $80, $00, $a0, $00, $00, $08, $0c, $00, $01, $80, $00, $18, $00, $0c, $28, $04, $01, $02, $02, $02, $03, $02, $03, $09, $09, $06, $06, $00 ; record 85
	db $03, $80, $00, $a0, $00, $00, $08, $0c, $00, $01, $80, $00, $12, $00, $0a, $78, $00, $02, $03, $04, $04, $05, $04, $05, $09, $09, $06, $06, $00 ; record 86
	db $01, $80, $00, $a0, $00, $00, $08, $0c, $00, $01, $80, $00, $12, $00, $0a, $c8, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; record 87
	db $05, $80, $00, $a0, $00, $00, $08, $0c, $00, $01, $80, $00, $12, $00, $00, $c8, $05, $00, $04, $00, $05, $00, $00, $00, $06, $06, $07, $06, $00 ; record 88
	db $01, $80, $00, $a0, $00, $00, $08, $0c, $00, $01, $80, $00, $12, $0c, $0a, $c8, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; record 89
	db $01, $80, $00, $a0, $00, $00, $08, $0c, $00, $01, $80, $00, $12, $0c, $0a, $c8, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; record 90
	db $01, $80, $00, $a0, $00, $00, $09, $0c, $00, $05, $80, $00, $08, $07, $03, $be, $00, $03, $02, $05, $06, $05, $04, $06, $06, $05, $03, $03, $00 ; record 91
	db $01, $80, $00, $a0, $00, $00, $09, $0c, $00, $06, $80, $00, $02, $02, $00, $e6, $00, $03, $02, $05, $06, $05, $04, $06, $06, $05, $03, $03, $00 ; record 92
	db $01, $80, $00, $a0, $00, $00, $09, $0c, $00, $07, $80, $00, $00, $00, $00, $ff, $00, $04, $03, $06, $07, $06, $05, $07, $07, $06, $04, $04, $00 ; record 93
	db $01, $80, $00, $a0, $00, $00, $09, $0c, $00, $05, $80, $00, $08, $07, $03, $be, $00, $03, $02, $05, $06, $05, $04, $06, $06, $05, $03, $03, $00 ; record 94
	db $01, $80, $00, $a0, $00, $00, $09, $0c, $00, $06, $80, $00, $02, $02, $00, $e6, $00, $03, $02, $05, $06, $05, $04, $06, $06, $05, $03, $03, $00 ; record 95
	db $01, $80, $00, $a0, $00, $00, $09, $0c, $00, $07, $80, $00, $00, $00, $00, $ff, $00, $04, $03, $06, $07, $06, $05, $07, $07, $06, $04, $04, $00 ; record 96
	db $01, $80, $00, $a0, $00, $00, $08, $0c, $00, $05, $80, $00, $08, $07, $03, $be, $00, $01, $03, $04, $04, $06, $05, $09, $04, $07, $07, $08, $00 ; record 97
	db $01, $80, $00, $a0, $00, $00, $08, $0c, $00, $06, $80, $00, $02, $02, $00, $e6, $00, $01, $03, $04, $04, $06, $05, $09, $04, $07, $07, $08, $00 ; record 98
	db $01, $80, $00, $a0, $00, $00, $08, $0c, $00, $07, $80, $00, $00, $00, $00, $ff, $00, $02, $04, $05, $05, $07, $06, $09, $05, $08, $08, $09, $00 ; record 99
CharGroupTable_02:
	; $5e23, 144 bytes (bytes:16)
	db $10, $10, $10, $10, $10, $10, $10, $30, $20, $20, $20, $20, $20, $20, $20, $30 ; 0x00
	db $10, $10, $10, $10, $20, $20, $20, $20, $10, $11, $11, $30, $20, $22, $22, $30 ; 0x10
	db $10, $10, $10, $30, $20, $20, $20, $30, $11, $11, $11, $12, $22, $22, $22, $21 ; 0x20
	db $30, $30, $30, $11, $11, $11, $11, $11, $22, $22, $22, $22, $20, $10, $12, $21 ; 0x30
	db $30, $30, $30, $30, $30, $30, $30, $30, $30, $30, $30, $30, $30, $30, $30, $30 ; 0x40
	db $12, $12, $12, $12, $12, $12, $12, $12, $12, $12, $12, $12, $12, $12, $12, $12 ; 0x50
	db $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21 ; 0x60
	db $11, $11, $20, $22, $30, $21, $21, $21, $12, $12, $12, $12, $12, $12, $12, $12 ; 0x70
	db $11, $11, $11, $11, $30, $22, $12, $12, $21, $21, $21, $21, $21, $21, $21, $21 ; 0x80
GetCharGroupEntry:
	add a, a ; $5eb3
	add a, a ; $5eb4
	add a, a ; $5eb5
	add a, a ; $5eb6
	add a, $23 ; $5eb7
	ld l, a ; $5eb9
	adc a, $5e ; $5eba
	sub a, l ; $5ebc
	ld h, a ; $5ebd
	ld a, b ; $5ebe
	and a, $0f ; $5ebf
	add a, l ; $5ec1
	ld l, a ; $5ec2
	jr nc, .read ; $5ec3
	inc h ; $5ec5
.read:
	ld a, [hl] ; $5ec6
	ret ; $5ec7
Unused_02_CharGroupFind:
	add a, a ; $5ec8
	add a, a ; $5ec9
	add a, a ; $5eca
	add a, a ; $5ecb
	add a, $23 ; $5ecc
	ld l, a ; $5ece
	adc a, $5e ; $5ecf
	sub a, l ; $5ed1
	ld h, a ; $5ed2
	ld b, $10 ; $5ed3
.loop:
	ld a, [hl+] ; $5ed5
	cp a, $30 ; $5ed6
	jr z, .step ; $5ed8
	dec b ; $5eda
	jr nz, .loop ; $5edb
	xor a, a ; $5edd
	ret ; $5ede
.step:
	ld a, $01 ; $5edf
	ret ; $5ee1
DoesCharGroupRowContain:
	add a, a ; $5ee2
	add a, a ; $5ee3
	add a, a ; $5ee4
	add a, a ; $5ee5
	add a, $23 ; $5ee6
	ld l, a ; $5ee8
	adc a, $5e ; $5ee9
	sub a, l ; $5eeb
	ld h, a ; $5eec
	ld c, $10 ; $5eed
.loop:
	ld a, [hl+] ; $5eef
	cp a, b ; $5ef0
	jr z, .step ; $5ef1
	dec c ; $5ef3
	jr nz, .loop ; $5ef4
	xor a, a ; $5ef6
	ret ; $5ef7
.step:
	ld a, $01 ; $5ef8
	ret ; $5efa
	; $5efb, 8453 bytes fill to bank end (linker-padded)
