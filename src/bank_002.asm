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
	ld a, [wN64TransferMarker] ; $4044
	cp $64 ; $4047
	jr nz, .returnZero ; $4049
	ld hl, wPendingExpStory ; $404b
	ld a, [hl+] ; $404e
	add [hl] ; $404f
	inc l ; $4050
	add [hl] ; $4051
	inc l ; $4052
	add [hl] ; $4053
	inc l ; $4054
	add [hl] ; $4055
	inc l ; $4056
	add [hl] ; $4057
	inc l ; $4058
	add [hl] ; $4059
	inc l ; $405a
	rlca ; $405b
	xor $fe ; $405c
	cp [hl] ; $405e
	jr nz, .returnZero ; $405f
	ld a, $ff ; $4061
	ret ; $4063
.returnZero:
	xor a ; $4064
	ret ; $4065
InitCa00RecordFromCharId:
	ld a, b ; $4066
	push af ; $4067
	ld a, c ; $4068
	call GetCa00RecordPtr ; $4069
	ld l, c ; $406c
	ld h, b ; $406d
	pop af ; $406e
	cp $ff ; $406f
	jr z, .emptySlot ; $4071
	cp $90 ; $4073
	jr z, .mainCharacter ; $4075
	bit 7, a ; $4077
	jr z, .fromRoster ; $4079
	ld b, a ; $407b
	ld a, [wCurrentStorySlot] ; $407c
	cp $0f ; $407f
	jr z, .skip ; $4081
	push hl ; $4083
	ld c, $04 ; $4084
	call ClearMemory16 ; $4086
	pop de ; $4089
	ld a, b ; $408a
	and $01 ; $408b
	swap a ; $408d
	add a ; $408f
	add a ; $4090
	add $00 ; $4091
	ld l, a ; $4093
	adc $c9 ; $4094
	sub l ; $4096
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
	add e ; $40d6
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
	add l ; $40fe
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
	push_wram_bank $06 ; $4119
	pop_wram_bank ; $4122
	ret ; $4127
; GetCharPaletteIndex with a different table base (`add $33` for `add $7e`): the same character-id lookup over the remap table above. Nothing calls it.
Unused_02_CharIdRemapLookup:
	push hl ; $4128
	ld_hl_indexed Unused_02_CharIdRemapTable ; $4129
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
	ld_hl_indexed CharPaletteIndexTable ; $4174
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
	or a ; $4209
	ret z ; $420a
	ld c, $40 ; $420b
	ret ; $420d
GetCa00RecordPtr:
	and $03 ; $420e
	swap a ; $4210
	add a ; $4212
	add a ; $4213
	add $00 ; $4214
	ld c, a ; $4216
	adc $ca ; $4217
	sub c ; $4219
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
	ld [hl], STORYLOC_MAIN_MENU ; $4238
	ld hl, wStoryModeEntryPoint ; $423a
	ld [hl], $02 ; $423d
	ld a, $01 ; $423f
	ld [wMessageSpeed], a ; $4241
	farcall InitDefaultMatchSettings ; $4244
	clear_flag FLAG_NEW_GAME_CLEARED_BIT ; $4247
	set_flag FLAG_NEW_GAME_SET_BIT ; $424a
	ld hl, wStorySlotBlockTag ; $424d
	xor a ; $4250
	ld [hl], $56 ; $4251
	inc hl ; $4253
	ld [hl+], a ; $4254
	ld [hl], a ; $4255
	ret ; $4256
Unused_02_SignExtendL:
	bit 7, l ; $4257
	jr nz, .negative ; $4259
	ld h, $00 ; $425b
	ret ; $425d
.negative:
	ld h, $ff ; $425e
	ret ; $4260
CacheStorySlotSummaries:
	push af ; $4261
	push bc ; $4262
	push de ; $4263
	push hl ; $4264
	push_wram_bank $06 ; $4265
	xor a ; $426e
	ld c, $0c ; $426f
	ld hl, wStorySlotSignatures ; $4271
.loop:
	ld [hl+], a ; $4274
	dec c ; $4275
	jr nz, .loop ; $4276
	ld a, [wCurrentStorySlot] ; $4278
	push af ; $427b
	ld a, $00 ; $427c
	ld [wCurrentStorySlot], a ; $427e
	farcall CheckStorySlot ; $4281
	cp $fe ; $4284
	jr z, .eqfe ; $4286
	ld hl, wStorySaveSignature ; $4288
	ld de, wStorySlotSignatures ; $428b
	call Copy4Bytes ; $428e
.eqfe:
	ld a, $01 ; $4291
	ld [wCurrentStorySlot], a ; $4293
	farcall CheckStorySlot ; $4296
	cp $fe ; $4299
	jr z, .eqfe2 ; $429b
	ld hl, wStorySaveSignature ; $429d
	ld de, wStorySlotSignatures + 4 ; $42a0
	call Copy4Bytes ; $42a3
.eqfe2:
	ld a, $02 ; $42a6
	ld [wCurrentStorySlot], a ; $42a8
	farcall CheckStorySlot ; $42ab
	cp $fe ; $42ae
	jr z, .restore ; $42b0
	ld hl, wStorySaveSignature ; $42b2
	ld de, wStorySlotSignatures + 8 ; $42b5
	call Copy4Bytes ; $42b8
.restore:
	pop af ; $42bb
	ld [wCurrentStorySlot], a ; $42bc
	pop_wram_bank ; $42bf
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
	push_wram_bank $06 ; $42d8
	ld hl, wStorySaveSignature ; $42e1
	ld a, [hl+] ; $42e4
	or [hl] ; $42e5
	inc hl ; $42e6
	or [hl] ; $42e7
	inc hl ; $42e8
	or [hl] ; $42e9
	ld a, $ff ; $42ea
	jr z, .step ; $42ec
	ld de, wStorySaveSignature ; $42ee
	ld hl, wStorySlotSignatures ; $42f1
	call CompareNextByte ; $42f4
	jr z, .step ; $42f7
	call CompareNextByte ; $42f9
	jr z, .step ; $42fc
	call CompareNextByte ; $42fe
	jr z, .step ; $4301
	call CompareNextByte ; $4303
	jr z, .step ; $4306
	ld de, wStorySaveSignature ; $4308
	ld hl, wStorySlotSignatures + 4 ; $430b
	call CompareNextByte ; $430e
	jr z, .step ; $4311
	call CompareNextByte ; $4313
	jr z, .step ; $4316
	call CompareNextByte ; $4318
	jr z, .step ; $431b
	call CompareNextByte ; $431d
	jr z, .step ; $4320
	ld de, wStorySaveSignature ; $4322
	ld hl, wStorySlotSignatures + 8 ; $4325
	call CompareNextByte ; $4328
	jr z, .step ; $432b
	call CompareNextByte ; $432d
	jr z, .step ; $4330
	call CompareNextByte ; $4332
	jr z, .step ; $4335
	call CompareNextByte ; $4337
	jr z, .step ; $433a
	xor a ; $433c
.step:
	ld h, a ; $433d
	pop_wram_bank ; $433e
	ld a, h ; $4343
	pop hl ; $4344
	pop de ; $4345
	ret ; $4346
CompareNextByte:
	ld a, [de] ; $4347
	cp [hl] ; $4348
	inc de ; $4349
	inc hl ; $434a
	ld a, $ff ; $434b
	ret ; $434d
RollStoryRandomByte:
	push af ; $434e
	push bc ; $434f
	push de ; $4350
	push hl ; $4351
	ld de, wStoryRandomBytes ; $4352
	add e ; $4355
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
	ld hl, wStoryRandomBytes ; $4368
	ld de, wStorySaveSignature ; $436b
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
	or a ; $437d
	jr z, .restore ; $437e
	call AdvanceRandomSeed ; $4380
	ld a, h ; $4383
	ld [wStorySaveSignature], a ; $4384
	call AdvanceRandomSeed ; $4387
	ld a, h ; $438a
	ld [wStorySaveSignature + 1], a ; $438b
	call AdvanceRandomSeed ; $438e
	ld a, h ; $4391
	ld [wStorySaveSignature + 2], a ; $4392
	call AdvanceRandomSeed ; $4395
	ld a, h ; $4398
	ld [wStorySaveSignature + 3], a ; $4399
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
	and $03 ; $43a5
	ld d, a ; $43a7
	pop af ; $43a8
	and $01 ; $43a9
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
	add $1b ; $43cb
	ld l, a ; $43cd
	adc $00 ; $43ce
	sub l ; $43d0
	ld h, a ; $43d1
	ld a, $00 ; $43d2
	add c ; $43d4
	ld e, a ; $43d5
	ld d, b ; $43d6
	farcall FetchShortTextToBuffer ; $43d7
	pop de ; $43da
	ld a, d ; $43db
	ld_hl_indexed StoryCharGenderTable ; $43dc
	ld a, [hl] ; $43e3
	ld hl, $000d ; $43e4
	add hl, bc ; $43e7
	ld [hl], a ; $43e8
	push bc ; $43e9
	ld a, d ; $43ea
	add a ; $43eb
	ld_hl_indexed StatArchetypePtrs_02 ; $43ec
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
	add c ; $4400
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
Unused_02:
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
	and $3f ; $4447
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
	add l ; $446c
	ld l, a ; $446d
	jr nc, .gotPtr ; $446e
	inc h ; $4470
.gotPtr:
	ldh a, [hWramBank] ; $4471
	push af ; $4473
	pop_wram_bank ; $4474
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
	sub c ; $44a3
	ld l, a ; $44a4
	ld a, h ; $44a5
	sbc b ; $44a6
	ld h, a ; $44a7
	ld a, h ; $44a8
	or l ; $44a9
	bit 7, h ; $44aa
	pop bc ; $44ac
	pop hl ; $44ad
	ret nz ; $44ae
	or a ; $44af
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
	sub e ; $44c8
	ld l, a ; $44c9
	ld a, h ; $44ca
	sbc d ; $44cb
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
	and $03 ; $44ef
	add a ; $44f1
	ld_hl_indexed StatArchetypePtrs_02 ; $44f2
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
	cp $ff ; $4630
	jr z, .copyStats ; $4632
	cp d ; $4634
	jr nz, .nextModifier ; $4635
	ld a, [hl] ; $4637
	push hl ; $4638
	and $0f ; $4639
	add a ; $463b
	add $6e ; $463c
	ld l, a ; $463e
	adc $46 ; $463f
	sub l ; $4641
	ld h, a ; $4642
	ld a, $19 ; $4643
	add c ; $4645
	ld e, a ; $4646
	ld d, b ; $4647
	ld a, [de] ; $4648
	or [hl] ; $4649
	ld [de], a ; $464a
	inc hl ; $464b
	inc de ; $464c
	ld a, [de] ; $464d
	or [hl] ; $464e
	ld [de], a ; $464f
	pop hl ; $4650
.nextModifier:
	inc hl ; $4651
	jr .modifierLoop ; $4652
.copyStats:
	ld hl, $0030 ; $4654
	add hl, bc ; $4657
	ld a, $10 ; $4658
	add c ; $465a
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
	or a ; $4668
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
	and $0f ; $4698
	ld d, $00 ; $469a
	call ApplyStatModifierRow ; $469c
	pop bc ; $469f
	ld hl, $003c ; $46a0
	add hl, bc ; $46a3
	ld a, [hl] ; $46a4
	swap a ; $46a5
	and $0f ; $46a7
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
	add a ; $46b6
	ld hl, EquipStatDeltaPtrs_02 ; $46b7
	add l ; $46ba
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
	add c ; $46cf
	ld e, a ; $46d0
	ld d, b ; $46d1
	ld c, $0b ; $46d2
.loop:
	ld b, [hl] ; $46d4
	ld a, [de] ; $46d5
	add b ; $46d6
	bit 7, a ; $46d7
	jr z, .compare ; $46d9
	xor a ; $46db
	jr .store ; $46dc
.compare:
	cp $09 ; $46de
	jr c, .store ; $46e0
	ld a, $09 ; $46e2
.store:
	ld [de], a ; $46e4
	inc hl ; $46e5
	inc de ; $46e6
	dec c ; $46e7
	jr nz, .loop ; $46e8
	ret ; $46ea
EquipStatDeltaPtrs_02:
	; $46eb, 4 bytes (records:2)
	dw RacketStatDeltas_02 ; record 0
	dw ShoeStatDeltas_02 ; record 1
RacketStatDeltas_02:
	; $46ef, 112 bytes (equip_stat_deltas)
; equip_stat_deltas Top, Slice, Serve, Stroke, Volley, Angle, Placement, Speed, Dash, Reaction, Stop
	equip_stat_deltas 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ; 0 Normal
	equip_stat_deltas -2, -2, -1, -1, 0, 2, 1, 0, 0, 0, 0 ; 1 Large
	equip_stat_deltas 1, 1, 2, 1, 0, -2, -2, 0, 0, 0, 0 ; 2 Small
	equip_stat_deltas 0, 0, -2, -2, -2, 0, 0, 0, 0, 0, 0 ; 3 Iron
	equip_stat_deltas 0, 0, 2, 2, -1, -1, 0, 0, 0, 0, 0 ; 4 Gold
	equip_stat_deltas 0, 0, -1, -1, 3, 1, 1, 0, 0, 0, 0 ; 5 Silver
	equip_stat_deltas 3, 0, -2, -2, 0, 0, 0, 0, 0, 0, 0 ; 6 Drive
ShoeStatDeltas_02:
	; $475f, 48 bytes (equip_stat_deltas)
; equip_stat_deltas Top, Slice, Serve, Stroke, Volley, Angle, Placement, Speed, Dash, Reaction, Stop
	equip_stat_deltas 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ; 0 Normal
	equip_stat_deltas 0, 0, 0, 0, 0, 0, 0, -2, -2, -2, -2 ; 1 Iron
	equip_stat_deltas 0, 0, 0, 0, 0, 0, 0, 2, 2, -2, -2 ; 2 Light
RefreshMainCharacterStats:
	ld bc, wStoryModeNameOfMainCharacter ; $478f
	call RecomputeCharacterStats ; $4792
	ld hl, wStoryModeNameOfMainCharacter ; $4795
	ld de, wStorySlotData ; $4798
	ld c, $08 ; $479b
	call CopyMemoryFast ; $479d
	ld a, [wMainCharEquipmentBits] ; $47a0
	ld b, a ; $47a3
	and $0f ; $47a4
	cp $03 ; $47a6
	jr nz, .checkHighNibble ; $47a8
	ld a, b ; $47aa
	and $f0 ; $47ab
	ld b, a ; $47ad
.checkHighNibble:
	ld a, b ; $47ae
	swap a ; $47af
	and $0f ; $47b1
	cp $01 ; $47b3
	jr nz, .store ; $47b5
	ld a, b ; $47b7
	and $0f ; $47b8
	ld b, a ; $47ba
.store:
	ld a, b ; $47bb
	ld [wMainCharEquipmentBits], a ; $47bc
	ld bc, wStorySlotData ; $47bf
	call RecomputeCharacterStats ; $47c2
	ret ; $47c5
RecomputeStatsWithoutRacket:
	ld hl, wEquippedRacket ; $47c6
	ld a, [hl] ; $47c9
	push af ; $47ca
	xor a ; $47cb
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
StatArchetypePtrs_02:
	; $47f2, 8 bytes (records:2)
	dw StatArchetype0_02 ; record 0
	dw StatArchetype1_02 ; record 1
	dw StatArchetype2_02 ; record 2
	dw StatArchetype3_02 ; record 3
StatArchetype0_02:
	; $47fa, 113 bytes (stat archetype)
	db 1 ; level / class tier -> record +$18
	db $79, $00, $a0, $00, $99, $09, $0d, $00 ; physics template -> record +$30-+$37
	db 0, 0, 0, 0 ; Spin, Power, Control, Speed levels -> record +$38-+$3b
	stat_thresholds 2, 5, 8, 11, 13, 16, 19, 23, 28 ; Top
	stat_thresholds 4, 7, 10, 13, 15, 18, 21, 25, 30 ; Slice
	stat_thresholds 3, 8, 11, 15, 18, 22, 26, 31, 38 ; Serve
	stat_thresholds -3, 2, 6, 9, 13, 17, 21, 27, 34 ; Stroke
	stat_thresholds 2, 7, 11, 14, 18, 21, 26, 31, 38 ; Volley
	stat_thresholds 3, 8, 11, 14, 18, 21, 25, 31, 37 ; Angle
	stat_thresholds 4, 9, 13, 16, 20, 23, 28, 33, 40 ; Placement
	stat_thresholds 2, 5, 8, 10, 12, 15, 18, 21, 26 ; Speed
	stat_thresholds -6, -2, 1, 4, 7, 10, 14, 18, 24 ; Dash
	stat_thresholds 4, 7, 10, 13, 15, 18, 21, 25, 30 ; Reaction
	stat_thresholds 3, 8, 11, 15, 18, 22, 26, 31, 38 ; Stop
	db $ff
StatArchetype1_02:
	; $486b, 113 bytes (stat archetype)
	db 1 ; level / class tier -> record +$18
	db $80, $00, $a0, $00, $33, $09, $0e, $00 ; physics template -> record +$30-+$37
	db 0, 0, 0, 0 ; Spin, Power, Control, Speed levels -> record +$38-+$3b
	stat_thresholds 4, 8, 11, 14, 17, 20, 24, 28, 34 ; Top
	stat_thresholds 3, 7, 9, 12, 15, 17, 21, 25, 30 ; Slice
	stat_thresholds 5, 10, 14, 17, 21, 25, 29, 35, 42 ; Serve
	stat_thresholds 3, 7, 10, 13, 16, 20, 23, 28, 34 ; Stroke
	stat_thresholds 2, 6, 9, 12, 15, 18, 22, 26, 32 ; Volley
	stat_thresholds 2, 6, 9, 12, 15, 17, 21, 25, 31 ; Angle
	stat_thresholds -3, 1, 4, 7, 10, 13, 17, 21, 27 ; Placement
	stat_thresholds 3, 6, 9, 12, 14, 17, 20, 24, 29 ; Speed
	stat_thresholds 4, 7, 9, 11, 13, 16, 18, 22, 26 ; Dash
	stat_thresholds -4, 1, 5, 9, 13, 16, 21, 27, 34 ; Reaction
	stat_thresholds 2, 6, 10, 13, 16, 20, 24, 29, 35 ; Stop
	db $ff
StatArchetype2_02:
	; $48dc, 113 bytes (stat archetype)
	db 1 ; level / class tier -> record +$18
	db $90, $00, $a3, $00, $99, $07, $0b, $00 ; physics template -> record +$30-+$37
	db 0, 0, 0, 0 ; Spin, Power, Control, Speed levels -> record +$38-+$3b
	stat_thresholds -3, 2, 6, 10, 14, 18, 23, 29, 36 ; Top
	stat_thresholds 2, 8, 12, 16, 20, 24, 29, 35, 42 ; Slice
	stat_thresholds -8, -2, 3, 8, 12, 17, 23, 29, 38 ; Serve
	stat_thresholds 1, 7, 11, 15, 19, 24, 29, 35, 43 ; Stroke
	stat_thresholds 3, 9, 14, 18, 22, 27, 32, 39, 47 ; Volley
	stat_thresholds -2, 4, 8, 13, 17, 21, 27, 33, 41 ; Angle
	stat_thresholds 3, 9, 13, 17, 21, 25, 30, 36, 44 ; Placement
	stat_thresholds -4, 3, 9, 14, 19, 24, 31, 38, 48 ; Speed
	stat_thresholds 2, 9, 14, 19, 24, 29, 35, 43, 52 ; Dash
	stat_thresholds 3, 9, 13, 17, 21, 26, 31, 37, 45 ; Reaction
	stat_thresholds 6, 14, 20, 26, 32, 38, 45, 54, 65 ; Stop
	db $ff
StatArchetype3_02:
	; $494d, 113 bytes (stat archetype)
	db 1 ; level / class tier -> record +$18
	db $86, $00, $a9, $00, $c2, $07, $0b, $00 ; physics template -> record +$30-+$37
	db 0, 0, 0, 0 ; Spin, Power, Control, Speed levels -> record +$38-+$3b
	stat_thresholds 2, 8, 12, 16, 20, 24, 29, 35, 42 ; Top
	stat_thresholds -4, 2, 6, 10, 14, 19, 24, 30, 38 ; Slice
	stat_thresholds -2, 4, 9, 14, 18, 23, 29, 35, 44 ; Serve
	stat_thresholds 4, 10, 14, 18, 22, 27, 32, 38, 46 ; Stroke
	stat_thresholds 2, 7, 11, 15, 19, 22, 27, 33, 40 ; Volley
	stat_thresholds -10, -2, 4, 10, 16, 21, 29, 37, 48 ; Angle
	stat_thresholds 2, 8, 12, 16, 20, 24, 29, 35, 42 ; Placement
	stat_thresholds 3, 9, 14, 18, 22, 27, 32, 39, 47 ; Speed
	stat_thresholds -3, 4, 9, 13, 18, 23, 29, 36, 45 ; Dash
	stat_thresholds 4, 10, 15, 19, 23, 28, 33, 40, 48 ; Reaction
	stat_thresholds 6, 11, 15, 18, 22, 25, 30, 35, 42 ; Stop
	db $ff
LevelUpPlayer:
	call GetPlayerRecordPtr ; $49be
LevelUpPlayerRecord:
	ld hl, $0018 ; $49c1
	add hl, bc ; $49c4
	ld a, [hl] ; $49c5
	cp $63 ; $49c6
	jp nc, .done ; $49c8
	ld a, d ; $49cb
	or a ; $49cc
	jr nz, .compare ; $49cd
	ld hl, $0038 ; $49cf
	add hl, bc ; $49d2
	inc [hl] ; $49d3
	jr .recomputeCharacterStats ; $49d4
.compare:
	cp $01 ; $49d6
	jr nz, .compare2 ; $49d8
	ld hl, $0039 ; $49da
	add hl, bc ; $49dd
	inc [hl] ; $49de
	jr .recomputeCharacterStats ; $49df
.compare2:
	cp $02 ; $49e1
	jr nz, .compare3 ; $49e3
	ld hl, $003a ; $49e5
	add hl, bc ; $49e8
	inc [hl] ; $49e9
	jr .recomputeCharacterStats ; $49ea
.compare3:
	cp $03 ; $49ec
	jr nz, .recomputeCharacterStats ; $49ee
	ld hl, $003b ; $49f0
	add hl, bc ; $49f3
	inc [hl] ; $49f4
	jr .recomputeCharacterStats ; $49f5
.recomputeCharacterStats:
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
	sub d ; $4a37
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
	sub d ; $4a57
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
	sub d ; $4a77
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
	sub d ; $4a97
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
	sub d ; $4ab7
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
	sub d ; $4ad7
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
	sub d ; $4af7
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
	sub d ; $4b17
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
	sub d ; $4b37
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
	sub d ; $4b57
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
	sub d ; $4b77
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
	add a ; $4b99
	add a ; $4b9a
	ld hl, Unused_02_4b99_Table ; $4b9b
	add l ; $4b9e
	ld l, a ; $4b9f
	jr nc, .levelUpPlayer ; $4ba0
	inc h ; $4ba2
.levelUpPlayer:
	push hl ; $4ba3
	ld d, $ff ; $4ba4
	call LevelUpPlayer ; $4ba6
	pop hl ; $4ba9
	ld a, [hl+] ; $4baa
.loop:
	or a ; $4bab
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
	or a ; $4bbb
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
.loop2:
	or a ; $4bcb
	jr z, .read2 ; $4bcc
	push af ; $4bce
	push hl ; $4bcf
	ld d, $02 ; $4bd0
	call LevelUpPlayer ; $4bd2
	pop hl ; $4bd5
	pop af ; $4bd6
	dec a ; $4bd7
	jr .loop2 ; $4bd8
.read2:
	ld a, [hl+] ; $4bda
.loop3:
	or a ; $4bdb
	jr z, .zero ; $4bdc
	push af ; $4bde
	push hl ; $4bdf
	ld d, $03 ; $4be0
	call LevelUpPlayer ; $4be2
	pop hl ; $4be5
	pop af ; $4be6
	dec a ; $4be7
	jr .loop3 ; $4be8
.zero:
	xor a ; $4bea
	ld hl, CharDataPtr_02 ; $4beb
	add l ; $4bee
	ld l, a ; $4bef
	jr nc, .read3 ; $4bf0
	inc h ; $4bf2
.read3:
	ld a, [hl+] ; $4bf3
	ld d, [hl] ; $4bf4
	ld e, a ; $4bf5
	ld hl, $0018 ; $4bf6
	add hl, bc ; $4bf9
	ld a, [hl] ; $4bfa
	cp $01 ; $4bfb
	jr z, .done ; $4bfd
	ld h, d ; $4bff
	ld l, e ; $4c00
	ld d, a ; $4c01
	add a ; $4c02
	add d ; $4c03
	add l ; $4c04
	ld l, a ; $4c05
	jr nc, .gotPtr ; $4c06
	inc h ; $4c08
.gotPtr:
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
	cp $20 ; $4c58
	ret c ; $4c5a
	push hl ; $4c5b
	sub $20 ; $4c5c
	and $7f ; $4c5e
	ld_hl_indexed NameTextRemap_02 ; $4c60
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
	add a ; $4cb5
	ld_hl_indexed StorySlotFlagBIds_02 ; $4cb6
	ld a, [hl+] ; $4cbd
	ld d, [hl] ; $4cbe
	ld e, a ; $4cbf
	pop af ; $4cc0
	and a ; $4cc1
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
	add a ; $4cd7
	ld_hl_indexed StorySlotFlagBIds_02 ; $4cd8
	ld a, [hl+] ; $4cdf
	ld d, [hl] ; $4ce0
	ld e, a ; $4ce1
	farcall TestSaveFlag ; $4ce2
	jr z, .zero ; $4ce5
	ld a, $01 ; $4ce7
	ret ; $4ce9
.zero:
	ld a, $00 ; $4cea
	ret ; $4cec
SetStorySlotFlagA:
	push af ; $4ced
	ld a, [wCurrentStorySlot] ; $4cee
	add a ; $4cf1
	ld_hl_indexed StorySlotFlagAIds_02 ; $4cf2
	ld a, [hl+] ; $4cf9
	ld d, [hl] ; $4cfa
	ld e, a ; $4cfb
	pop af ; $4cfc
	and a ; $4cfd
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
	add a ; $4d13
	ld_hl_indexed StorySlotFlagAIds_02 ; $4d14
	ld a, [hl+] ; $4d1b
	ld d, [hl] ; $4d1c
	ld e, a ; $4d1d
	farcall TestSaveFlag ; $4d1e
	jr z, .zero ; $4d21
	ld a, $01 ; $4d23
	ret ; $4d25
.zero:
	ld a, $00 ; $4d26
	ret ; $4d28
; The gate on awarding EXP: AddExpToCa00RecordChecked calls it and returns on
; z. It cannot return z -- `xor a` / `dec a` sets the flags from $ff and the
; following `ld a, c` restores the caller's a without touching them -- so the
; gate always passes and the award always happens. Whatever condition it was
; meant to test is not in the ROM.
CheckExpAwardAllowed:
	push bc ; $4d29
	ld c, a ; $4d2a
	xor a ; $4d2b
	dec a ; $4d2c
	ld a, c ; $4d2d
	pop bc ; $4d2e
	ret ; $4d2f
AddExpCapped:
	ld a, [hl] ; $4d30
	add e ; $4d31
	ld [hl+], a ; $4d32
	ld a, [hl] ; $4d33
	adc d ; $4d34
	ld [hl+], a ; $4d35
	ld a, [hl] ; $4d36
	adc $00 ; $4d37
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
	sub [hl] ; $4d56
	inc hl ; $4d57
	ld a, [de] ; $4d58
	inc de ; $4d59
	sbc [hl] ; $4d5a
	inc hl ; $4d5b
	ld a, [de] ; $4d5c
	sbc [hl] ; $4d5d
	bit 7, a ; $4d5e
	ret ; $4d60
ClearCa00RecordExp:
	call GetCa00RecordPtr ; $4d61
	ld hl, $002c ; $4d64
	add hl, bc ; $4d67
	xor a ; $4d68
	ld [hl+], a ; $4d69
	ld [hl+], a ; $4d6a
	ld [hl+], a ; $4d6b
	ret ; $4d6c
AddExpToCa00RecordChecked:
	call CheckExpAwardAllowed ; $4d6d
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
Table_02:
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
	cp $63 ; $4da1
	jp nc, .ge63 ; $4da3
	ld h, $00 ; $4da6
	ld l, a ; $4da8
	ld d, h ; $4da9
	ld e, l ; $4daa
	add hl, hl ; $4dab
	add hl, de ; $4dac
	push hl ; $4dad
	xor a ; $4dae
	ld hl, CharDataPtr_02 ; $4daf
	add l ; $4db2
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
	add c ; $4dbe
	ld e, a ; $4dbf
	ld d, b ; $4dc0
	jp Compare24Bit ; $4dc1
.ge63:
	ld a, $80 ; $4dc4
	or a ; $4dc6
	ret ; $4dc7
GetExpRemainingToNextLevel:
	call GetPlayerRecordPtr ; $4dc8
	ld hl, $0018 ; $4dcb
	add hl, bc ; $4dce
	ld a, [hl] ; $4dcf
	cp $63 ; $4dd0
	jp nc, .maxLevel ; $4dd2
	ld h, $00 ; $4dd5
	ld l, a ; $4dd7
	ld d, h ; $4dd8
	ld e, l ; $4dd9
	add hl, hl ; $4dda
	add hl, de ; $4ddb
	push hl ; $4ddc
	xor a ; $4ddd
	ld hl, CharDataPtr_02 ; $4dde
	add l ; $4de1
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
	sub e ; $4df8
	ld l, a ; $4df9
	ld a, h ; $4dfa
	sbc d ; $4dfb
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
	cp $63 ; $4e0a
	jr nc, .ge63 ; $4e0c
	dec a ; $4e0e
	ld h, $00 ; $4e0f
	ld l, a ; $4e11
	ld d, h ; $4e12
	ld e, l ; $4e13
	add hl, hl ; $4e14
	add hl, de ; $4e15
	push hl ; $4e16
	xor a ; $4e17
	ld hl, CharDataPtr_02 ; $4e18
	add l ; $4e1b
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
	sub e ; $4e30
	ld l, a ; $4e31
	ld a, h ; $4e32
	sbc d ; $4e33
	ld h, a ; $4e34
	ret ; $4e35
.ge63:
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
	xor a ; $4e44
	ld hl, CharDataPtr_02 ; $4e45
	add l ; $4e48
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
	xor a ; $4e5f
	ld hl, CharDataPtr_02 ; $4e60
	add l ; $4e63
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
	sub e ; $4e72
	ld l, a ; $4e73
	ld a, h ; $4e74
	sbc d ; $4e75
	ld h, a ; $4e76
	ret ; $4e77
CharDataPtr_02:
	; $4e78, 2 bytes (records:2)
	dw ExpLevelThresholds_02 ; record 0
ExpLevelThresholds_02:
	; $4e7a, 300 bytes (exp_threshold)
	exp_threshold 0 ; level 1
	exp_threshold 15 ; level 2
	exp_threshold 45 ; level 3
	exp_threshold 90 ; level 4
	exp_threshold 144 ; level 5
	exp_threshold 204 ; level 6
	exp_threshold 270 ; level 7
	exp_threshold 341 ; level 8
	exp_threshold 417 ; level 9
	exp_threshold 498 ; level 10
	exp_threshold 585 ; level 11
	exp_threshold 678 ; level 12
	exp_threshold 777 ; level 13
	exp_threshold 882 ; level 14
	exp_threshold 993 ; level 15
	exp_threshold 1111 ; level 16
	exp_threshold 1236 ; level 17
	exp_threshold 1369 ; level 18
	exp_threshold 1510 ; level 19
	exp_threshold 1659 ; level 20
	exp_threshold 1817 ; level 21
	exp_threshold 1984 ; level 22
	exp_threshold 2161 ; level 23
	exp_threshold 2349 ; level 24
	exp_threshold 2548 ; level 25
	exp_threshold 2759 ; level 26
	exp_threshold 2983 ; level 27
	exp_threshold 3220 ; level 28
	exp_threshold 3471 ; level 29
	exp_threshold 3737 ; level 30
	exp_threshold 4019 ; level 31
	exp_threshold 4315 ; level 32
	exp_threshold 4623 ; level 33
	exp_threshold 4943 ; level 34
	exp_threshold 5276 ; level 35
	exp_threshold 5619 ; level 36
	exp_threshold 5969 ; level 37
	exp_threshold 6319 ; level 38
	exp_threshold 6669 ; level 39
	exp_threshold 7019 ; level 40
	exp_threshold 7369 ; level 41
	exp_threshold 7719 ; level 42
	exp_threshold 8069 ; level 43
	exp_threshold 8419 ; level 44
	exp_threshold 8769 ; level 45
	exp_threshold 9119 ; level 46
	exp_threshold 9469 ; level 47
	exp_threshold 9819 ; level 48
	exp_threshold 10169 ; level 49
	exp_threshold 10519 ; level 50
	exp_threshold 10869 ; level 51
	exp_threshold 11219 ; level 52
	exp_threshold 11569 ; level 53
	exp_threshold 11919 ; level 54
	exp_threshold 12269 ; level 55
	exp_threshold 12619 ; level 56
	exp_threshold 12969 ; level 57
	exp_threshold 13319 ; level 58
	exp_threshold 13669 ; level 59
	exp_threshold 14019 ; level 60
	exp_threshold 14369 ; level 61
	exp_threshold 14719 ; level 62
	exp_threshold 15069 ; level 63
	exp_threshold 15419 ; level 64
	exp_threshold 15769 ; level 65
	exp_threshold 16119 ; level 66
	exp_threshold 16469 ; level 67
	exp_threshold 16819 ; level 68
	exp_threshold 17169 ; level 69
	exp_threshold 17519 ; level 70
	exp_threshold 17869 ; level 71
	exp_threshold 18219 ; level 72
	exp_threshold 18569 ; level 73
	exp_threshold 18919 ; level 74
	exp_threshold 19269 ; level 75
	exp_threshold 19619 ; level 76
	exp_threshold 19969 ; level 77
	exp_threshold 20319 ; level 78
	exp_threshold 20669 ; level 79
	exp_threshold 21019 ; level 80
	exp_threshold 21369 ; level 81
	exp_threshold 21719 ; level 82
	exp_threshold 22069 ; level 83
	exp_threshold 22419 ; level 84
	exp_threshold 22769 ; level 85
	exp_threshold 23119 ; level 86
	exp_threshold 23469 ; level 87
	exp_threshold 23819 ; level 88
	exp_threshold 24169 ; level 89
	exp_threshold 24519 ; level 90
	exp_threshold 24869 ; level 91
	exp_threshold 25219 ; level 92
	exp_threshold 25569 ; level 93
	exp_threshold 25919 ; level 94
	exp_threshold 26269 ; level 95
	exp_threshold 26619 ; level 96
	exp_threshold 26969 ; level 97
	exp_threshold 27319 ; level 98
	exp_threshold 27669 ; level 99
	db $ff, $ff, $ff ; end
DebugStoryStatsScreen:
	sound BGM_DICTIONARY ; $4fa6
	wram_bank $01 ; $4fa8
	ld a, $03 ; $4fae
	ldh [hDebugStepMode], a ; $4fb0
	xor a ; $4fb2
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
	or a ; $4fce
	jr z, .zero ; $4fcf
	push de ; $4fd1
	ld hl, MenuTilemaps_02 ; $4fd2
	lb de, $08, $02 ; $4fd5 column, row
	call PrintString ; $4fd8
	pop de ; $4fdb
	jp .printString ; $4fdc
.zero:
	ld hl, DebugStoryStatsScreenString0 ; $4fdf
	lb de, $08, $02 ; $4fe2 column, row
	call PrintString ; $4fe5
	call ValidateN64TransferRecord ; $4fe8
	or a ; $4feb
	jr z, .printString ; $4fec
	push de ; $4fee
	ld hl, wPendingExpStory ; $4fef
	ld a, [hl+] ; $4ff2
	ld h, [hl] ; $4ff3
	ld l, a ; $4ff4
	ld de, $0210 ; $4ff5
	call PrintDecimalWord ; $4ff8
	ld hl, wPendingExpTrophy ; $4ffb
	ld a, [hl+] ; $4ffe
	ld h, [hl] ; $4fff
	ld l, a ; $5000
	ld de, $0a10 ; $5001
	call PrintDecimalWord ; $5004
	pop de ; $5007
	ld hl, wPendingExpStory ; $5008
	xor a ; $500b
	ld [hl+], a ; $500c
	ld [hl+], a ; $500d
	ld [hl+], a ; $500e
	ld [hl+], a ; $500f
	ld [hl+], a ; $5010
	ld [hl+], a ; $5011
	ld [hl+], a ; $5012
	ld [hl+], a ; $5013
	jr .loopB ; $5014
.printString:
	push de ; $5016
	ld hl, DebugStoryStatsScreenString2 ; $5017
	lb de, $02, $10 ; $501a column, row
	call PrintString ; $501d
	ld hl, DebugStoryStatsScreenString2 ; $5020
	lb de, $08, $10 ; $5023 column, row
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
.loop2:
	call AdvanceFrame ; $513f
	call AdvanceRandomSeed ; $5142
	ldh a, [hInputPressed] ; $5145
	bit PADB_UP, a ; $5147
	jr z, .levelUpPlayer ; $5149
	push de ; $514b
	ld a, $00 ; $514c
	ld d, $00 ; $514e
	call LevelUpPlayer ; $5150
	pop de ; $5153
	sound SFX_MENU_MOVE ; $5154
	jp .loopB ; $5156
.levelUpPlayer:
	bit 5, a ; $5159
	jr z, .bit5Clear ; $515b
	push de ; $515d
	ld a, $00 ; $515e
	ld d, $01 ; $5160
	call LevelUpPlayer ; $5162
	pop de ; $5165
	sound SFX_MENU_MOVE ; $5166
	jp .loopB ; $5168
.bit5Clear:
	bit 4, a ; $516b
	jr z, .bit4Clear ; $516d
	push de ; $516f
	ld a, $00 ; $5170
	ld d, $02 ; $5172
	call LevelUpPlayer ; $5174
	pop de ; $5177
	sound SFX_MENU_MOVE ; $5178
	jp .loopB ; $517a
.bit4Clear:
	bit 7, a ; $517d
	jr z, .positive ; $517f
	push de ; $5181
	ld a, $00 ; $5182
	ld d, $03 ; $5184
	call LevelUpPlayer ; $5186
	pop de ; $5189
	sound SFX_MENU_MOVE ; $518a
	jp .loopB ; $518c
.positive:
	bit 1, a ; $518f
	jr z, .bit1Clear ; $5191
	push de ; $5193
	ld a, $01 ; $5194
	ldh [hDebugStepMode], a ; $5196
	sound BGM_DICTIONARY ; $5198
	ld a, $03 ; $519a
	ldh [hDebugStepMode], a ; $519c
	pop de ; $519e
	jp .loopB ; $519f
.bit1Clear:
	bit 0, a ; $51a2
	jr z, .bit0Clear ; $51a4
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
	and $07 ; $51b3
	ld d, a ; $51b5
	xor a ; $51b6
	push de ; $51b7
	res 2, d ; $51b8
	call InitPlayerRecordFromTemplate ; $51ba
	pop de ; $51bd
	bit 2, d ; $51be
	jp z, .loopB ; $51c0
	ld a, $01 ; $51c3
	ld [wStoryModeMainCharacterLeftHanded], a ; $51c5
	jp .loopB ; $51c8
.bit0Clear:
	bit 2, a ; $51cb
	jr z, .bit2Clear ; $51cd
	sound SFX_MENU_SELECT ; $51cf
	ld a, [wCurrentStorySlot] ; $51d1
	inc a ; $51d4
	cp NUM_STORY_SLOTS ; $51d5
	jr c, .store ; $51d7
	xor a ; $51d9
.store:
	ld [wCurrentStorySlot], a ; $51da
	jp .loop ; $51dd
.bit2Clear:
	bit 3, a ; $51e0
	jr z, .skipSave ; $51e2
	sound SFX_MENU_SELECT ; $51e4
	push de ; $51e6
	ld hl, DebugStoryStatsScreenString1 ; $51e7
	lb de, $08, $02 ; $51ea column, row
	call PrintString ; $51ed
	farcall SaveStorySlotWithTimer ; $51f0
	pop de ; $51f3
	jp .loopB ; $51f4
.skipSave:
	jp .loop2 ; $51f7
MenuTilemaps_02:
	; $51fa, 8 bytes (bytes:16)
	db $46, $41, $49, $4c, $45, $44, $20, $00 ; 0x00
DebugStoryStatsScreenString0:
	INCLUDE "data/bank_002/DebugStoryStatsScreenString0.asm" ; $5202, 8 bytes
DebugStoryStatsScreenString1:
	INCLUDE "data/bank_002/DebugStoryStatsScreenString1.asm" ; $520a, 16 bytes
DebugStoryStatsScreenString2:
	; $521a, 45 bytes (bytes:16)
	db $20, $20, $20, $20, $20, $20, $00, $00, $01, $02, $03, $04, $05, $06, $07, $08 ; 0x00
	db $09, $0a, $0b, $0c, $0d, $00, $00, $00, $00, $00, $00, $00, $00, $4d, $41, $52 ; 0x10
	db $49, $4f, $20, $47, $4f, $4c, $46, $20, $47, $42, $20, $43, $48 ; 0x20
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
	or a ; $5256
	jr z, .zero ; $5257
	ld a, [wLinkSessionActive] ; $5259
	or a ; $525c
	ld a, h ; $525d
	jr nz, .storePlayer1CurrentMainCharacter ; $525e
	ld a, $3f ; $5260
	ld [wPlayer1CurrentMainCharacter], a ; $5262
	ld a, $03 ; $5265
	ld [wPlayer1MainPalette], a ; $5267
	ld a, b ; $526a
	ld [wCurrentStorySlot], a ; $526b
	ret ; $526e
.storePlayer1CurrentMainCharacter:
	ld a, $ff ; $526f
	ld [wPlayer1CurrentMainCharacter], a ; $5271
	ret ; $5274
.zero:
	push bc ; $5275
	push de ; $5276
	xor a ; $5277
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
	or a ; $5293
	jr z, .zero ; $5294
	ld a, $ff ; $5296
	ld [wPlayer1CurrentMainCharacter], a ; $5298
	ld a, $ff ; $529b
	ret ; $529d
.zero:
	push bc ; $529e
	push de ; $529f
	ld bc, $8000 ; $52a0
	call InitCa00RecordFromCharId ; $52a3
	pop de ; $52a6
	pop bc ; $52a7
	xor a ; $52a8
	ret ; $52a9
LoadCharacterRecordToCa80:
	push af ; $52aa
	push bc ; $52ab
	push de ; $52ac
	push hl ; $52ad
	bit 7, a ; $52ae
	jr z, .positive ; $52b0
	res 7, a ; $52b2
	call LoadStorySlot ; $52b4
	ld hl, wPlayer1MainName ; $52b7
	ld de, wPlayer2MainName ; $52ba
	ld c, $08 ; $52bd
	call CopyMemoryFast ; $52bf
	jr .restore ; $52c2
.positive:
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
	; $52cf, 2900 bytes (char_record)
; 100 records x 29 bytes
; char_record strategy, reach_h, reach_x, smash_jump, dive, tier, swing,
;             delay_near, delay_far, tracking, aim_away, serve_style,
;             Top, Slice, Serve, Stroke, Volley, Angle, Placement, Speed, Dash, Reaction, Stop,
;             speed_bonus
	char_record 1, $0080, $00a0, $0800, $000c, 1, $0080, 18, 12, 10, 200, 0,  5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5,  0 ; $00 Alex
	char_record 1, $0080, $00a0, $0800, $000c, 1, $0080, 18, 12, 10, 200, 0,  5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5,  0 ; $01 Nina
	char_record 1, $0080, $00a0, $0800, $000c, 1, $0080, 18, 12, 10, 200, 0,  5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5,  0 ; $02 Harry
	char_record 1, $0080, $00a0, $0800, $000c, 1, $0080, 18, 12, 10, 200, 0,  5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5,  0 ; $03 Kate
	char_record 1, $0080, $00a0, $0800, $000c, 2, $0080, 27, 18, 14, 70, 0,  0, 0, 0, 0, 1, 0, 1, 3, 4, 0, 0,  0 ; $04 Allie
	char_record 1, $0080, $00a0, $0800, $000c, 2, $0080, 25, 19, 10, 80, 0,  0, 2, 0, 0, 1, 5, 7, 0, 0, 1, 1,  0 ; $05 Joy
	char_record 1, $0080, $00a0, $0800, $000c, 2, $0080, 30, 28, 13, 30, 0,  3, 2, 2, 2, 1, 2, 2, 2, 2, 3, 2,  0 ; $06 Brian
	char_record 1, $0080, $00a0, $0800, $000c, 3, $0080, 22, 18, 10, 160, 0,  2, 2, 0, 1, 2, 5, 4, 1, 2, 1, 0,  0 ; $07 Pam
	char_record 1, $0080, $00a0, $0800, $000c, 3, $0080, 22, 18, 10, 160, 0,  3, 1, 6, 5, 3, 0, 0, 0, 1, 1, 2,  0 ; $08 Bob
	char_record 1, $0080, $00a0, $0800, $000c, 3, $0080, 22, 17, 10, 160, 0,  2, 0, 1, 2, 1, 2, 1, 6, 7, 3, 2,  0 ; $09 Beth
	char_record 1, $0080, $00a0, $0800, $000c, 4, $0080, 18, 12, 10, 170, 0,  2, 1, 5, 6, 4, 2, 2, 2, 3, 2, 3,  0 ; $0a Fay
	char_record 1, $0080, $00a0, $0800, $000c, 4, $0080, 18, 12, 10, 170, 0,  7, 8, 3, 2, 1, 3, 2, 1, 2, 1, 2,  0 ; $0b Curt
	char_record 1, $0080, $00a0, $0800, $000c, 4, $0080, 15, 10, 8, 170, 0,  3, 2, 3, 4, 3, 4, 3, 4, 3, 3, 3,  0 ; $0c Mark
	char_record 1, $0080, $00a0, $0800, $000c, 5, $0080, 10, 9, 5, 200, 0,  3, 3, 4, 3, 2, 4, 5, 4, 4, 3, 3,  0 ; $0d Sean
	char_record 1, $0080, $00a0, $0800, $000c, 5, $0080, 10, 9, 5, 200, 0,  1, 4, 2, 3, 4, 8, 7, 4, 3, 2, 3,  0 ; $0e Sammi
	char_record 1, $0080, $00a0, $0800, $000c, 5, $0080, 10, 9, 5, 200, 0,  4, 1, 3, 5, 4, 4, 2, 7, 6, 4, 3,  0 ; $0f Elden
	char_record 1, $0080, $00a0, $0800, $000c, 5, $0280, 10, 9, 5, 230, 8,  4, 4, 5, 4, 3, 5, 4, 4, 4, 3, 3,  0 ; $10 Spike
	char_record 1, $0080, $00a0, $0800, $0012, 5, $0080, 8, 7, 3, 220, 3,  4, 2, 3, 4, 5, 4, 3, 7, 8, 5, 4,  0 ; $11 Emily
	char_record 1, $0080, $00a0, $0800, $000c, 5, $0080, 10, 9, 5, 180, 0,  7, 1, 7, 8, 5, 2, 3, 3, 2, 2, 4,  0 ; $12 B. Coz
	char_record 1, $0080, $00a0, $0800, $000c, 5, $0180, 8, 7, 3, 255, 7,  9, 9, 3, 4, 5, 4, 3, 4, 2, 3, 3,  0 ; $13 A. Coz
	char_record 1, $0080, $00a0, $0800, $000c, 5, $0080, 9, 8, 4, 220, 0,  4, 3, 3, 4, 4, 7, 6, 5, 4, 4, 5,  0 ; $14 Kevin
	char_record 1, $0080, $00a0, $0800, $000c, 1, $0080, 18, 12, 10, 200, 0,  0, 0, 0, 0, 0, 9, 9, 1, 9, 9, 9,  0 ; $15 Not used
	char_record 1, $0080, $00a0, $0800, $000c, 1, $0080, 18, 12, 10, 200, 0,  5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5,  0 ; $16 Not used
	char_record 1, $0090, $00a0, $0800, $000c, 5, $0080, 32, 28, 14, 60, 0,  0, 3, 4, 5, 8, 4, 5, 4, 6, 3, 3,  0 ; $17 Luigi
	char_record 1, $0090, $00b0, $0800, $000c, 5, $0080, 32, 28, 14, 60, 0,  0, 2, 6, 7, 4, 2, 3, 4, 5, 0, 3,  0 ; $18 DK
	char_record 1, $0070, $00a0, $0800, $000c, 5, $0080, 32, 28, 14, 60, 0,  3, 2, 5, 5, 6, 8, 7, 5, 6, 5, 9,  0 ; $19 Baby M.
	char_record 1, $0080, $00a0, $0900, $000c, 5, $0080, 32, 28, 14, 60, 0,  3, 2, 5, 6, 5, 4, 6, 6, 5, 3, 3,  0 ; $1a Mario
	char_record 2, $00a0, $00a6, $0800, $000c, 5, $0080, 32, 28, 14, 60, 0,  0, 3, 4, 4, 8, 1, 8, 3, 6, 6, 3,  0 ; $1b Waluigi
	char_record 0, $0080, $00a0, $0800, $000c, 5, $0080, 32, 28, 14, 60, 0,  2, 3, 4, 5, 4, 5, 7, 6, 8, 3, 5,  0 ; $1c Yoshi
	char_record 0, $0090, $00b0, $0780, $000b, 5, $0080, 32, 28, 14, 60, 0,  2, 0, 6, 7, 4, 3, 5, 4, 2, 3, 3,  0 ; $1d Bowser
	char_record 1, $0080, $00a0, $0800, $000c, 5, $0080, 32, 28, 14, 60, 0,  3, 0, 6, 7, 5, 5, 6, 5, 4, 4, 5,  0 ; $1e Wario
	char_record 1, $0080, $00a0, $0800, $000c, 5, $0080, 32, 28, 14, 60, 0,  1, 3, 4, 4, 6, 5, 9, 4, 7, 7, 8,  0 ; $1f Peach
	char_record 1, $0080, $00a0, $0800, $000c, 2, $0080, 22, 18, 10, 160, 0,  2, 1, 5, 4, 2, 0, 0, 0, 0, 0, 1,  0 ; $20 Ranker 32
	char_record 1, $0080, $00a0, $0800, $000c, 2, $0080, 24, 20, 11, 150, 0,  2, 0, 1, 2, 1, 1, 0, 4, 5, 2, 1,  0 ; $21 Ranker 33
	char_record 1, $0080, $00a0, $0800, $000c, 2, $0080, 26, 24, 12, 120, 0,  5, 6, 2, 1, 0, 2, 1, 0, 1, 0, 1,  0 ; $22 Ranker 34
	char_record 1, $0080, $00a0, $0800, $000c, 2, $0080, 31, 31, 14, 40, 0,  2, 1, 1, 0, 1, 0, 1, 0, 1, 1, 1,  0 ; $23 Ranker 35
	char_record 1, $0080, $00a0, $0800, $000c, 2, $0080, 30, 28, 13, 30, 0,  3, 2, 2, 2, 1, 2, 2, 2, 2, 3, 2,  0 ; $24 Ranker 36
	char_record 1, $0080, $00a0, $0800, $000c, 2, $0080, 31, 24, 10, 50, 0,  1, 0, 3, 4, 2, 0, 0, 0, 1, 0, 1,  0 ; $25 Ranker 37
	char_record 1, $0080, $00a0, $0800, $000c, 2, $0080, 27, 18, 14, 70, 0,  0, 0, 0, 0, 1, 0, 1, 3, 4, 0, 0,  0 ; $26 Ranker 38
	char_record 1, $0080, $00a0, $0800, $000c, 2, $0080, 25, 19, 10, 80, 0,  0, 2, 0, 0, 1, 5, 7, 0, 0, 1, 1,  0 ; $27 Ranker 39
	char_record 1, $0080, $00a0, $0800, $000c, 3, $0080, 18, 12, 10, 170, 0,  1, 0, 4, 5, 3, 2, 2, 1, 2, 1, 2,  0 ; $28 Ranker 40
	char_record 1, $0080, $00a0, $0800, $000c, 3, $0080, 19, 14, 10, 160, 0,  1, 2, 0, 1, 2, 1, 2, 6, 7, 4, 2,  0 ; $29 Ranker 41
	char_record 1, $0080, $00a0, $0800, $000c, 3, $0080, 20, 16, 10, 160, 0,  1, 3, 1, 0, 2, 6, 7, 1, 1, 2, 2,  0 ; $2a Ranker 42
	char_record 1, $0080, $00a0, $0800, $000c, 3, $0080, 21, 17, 10, 160, 0,  3, 2, 2, 2, 1, 2, 2, 2, 2, 3, 2,  0 ; $2b Ranker 43
	char_record 1, $0080, $00a0, $0800, $000c, 3, $0080, 22, 17, 10, 160, 0,  2, 0, 1, 2, 1, 2, 1, 6, 7, 3, 2,  0 ; $2c Ranker 44
	char_record 1, $0080, $00a0, $0800, $000c, 3, $0080, 22, 17, 10, 160, 0,  6, 7, 2, 1, 0, 2, 1, 0, 1, 0, 1,  0 ; $2d Ranker 45
	char_record 1, $0080, $00a0, $0800, $000c, 3, $0080, 22, 18, 10, 160, 0,  3, 1, 6, 5, 3, 0, 0, 0, 1, 1, 2,  0 ; $2e Ranker 46
	char_record 1, $0080, $00a0, $0800, $000c, 3, $0080, 22, 18, 10, 160, 0,  2, 2, 1, 2, 2, 3, 2, 3, 2, 1, 1,  0 ; $2f Ranker 47
	char_record 1, $0080, $00a0, $0800, $000c, 4, $0080, 15, 10, 10, 180, 0,  4, 3, 3, 4, 4, 7, 6, 5, 4, 4, 5,  0 ; $30 Kevin
	char_record 1, $0080, $00a0, $0800, $000c, 4, $0080, 16, 11, 10, 170, 0,  4, 2, 3, 4, 5, 3, 2, 7, 8, 5, 4,  0 ; $31 Emily
	char_record 1, $0080, $00a0, $0800, $000c, 4, $0080, 15, 10, 8, 170, 0,  3, 2, 3, 4, 3, 4, 3, 4, 3, 3, 3,  0 ; $32 Mark
	char_record 1, $0080, $00a0, $0800, $000c, 4, $0080, 18, 12, 10, 170, 0,  5, 1, 7, 6, 4, 1, 1, 1, 2, 2, 3,  0 ; $33 Ellis
	char_record 1, $0080, $00a0, $0800, $000c, 4, $0080, 18, 12, 10, 170, 0,  2, 1, 5, 6, 4, 2, 2, 2, 3, 2, 3,  0 ; $34 Frank
	char_record 1, $0080, $00a0, $0800, $000c, 4, $0080, 18, 12, 10, 170, 0,  7, 8, 3, 2, 1, 3, 2, 1, 2, 1, 2,  0 ; $35 Edgar
	char_record 1, $0080, $00a0, $0800, $000c, 1, $0080, 18, 12, 10, 200, 0,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  0 ; $36
	char_record 1, $0080, $00a0, $0800, $000c, 1, $0080, 18, 32, 10, 200, 0,  4, 5, 5, 4, 4, 2, 2, 1, 0, 0, 1,  0 ; $37
	char_record 1, $0080, $00a0, $0800, $000c, 1, $0080, 18, 44, 10, 200, 0,  9, 9, 9, 8, 8, 6, 6, 1, 0, 0, 1,  0 ; $38
	char_record 1, $0080, $00a0, $0800, $000c, 1, $0080, 18, 25, 10, 200, 0,  9, 9, 9, 8, 8, 7, 7, 3, 2, 2, 3,  0 ; $39
	char_record 1, $0080, $00a0, $0800, $000c, 1, $0080, 18, 250, 10, 200, 0,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  0 ; $3a
	char_record 1, $0080, $00a0, $0800, $000c, 1, $0080, 18, 250, 10, 200, 0,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  0 ; $3b
	char_record 1, $0080, $00a0, $0800, $000c, 1, $0080, 18, 250, 10, 200, 0,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  0 ; $3c
	char_record 3, $0080, $00a0, $0800, $000c, 1, $0080, 36, 6, 18, 40, 0,  0, 1, 0, 0, 1, 0, 1, 6, 7, 4, 4,  0 ; $3d
	char_record 4, $0080, $00a0, $0800, $000c, 1, $0080, 36, 8, 0, 40, 5,  1, 2, 2, 2, 3, 2, 3, 6, 7, 4, 4,  0 ; $3e
	char_record 3, $0080, $00a0, $0800, $000c, 1, $0080, 30, 0, 10, 40, 0,  2, 3, 0, 0, 1, 3, 4, 6, 7, 4, 4,  0 ; $3f
	char_record 0, $0080, $00a0, $0800, $000c, 1, $0080, 18, 0, 10, 40, 0,  0, 0, 0, 0, 0, 0, 1, 6, 7, 4, 4,  0 ; $40
	char_record 4, $0080, $00a0, $0800, $000c, 1, $0080, 36, 0, 10, 40, 5,  1, 1, 0, 1, 0, 2, 3, 7, 8, 5, 5,  0 ; $41
	char_record 5, $0080, $00a0, $0800, $000c, 1, $0080, 18, 0, 10, 120, 5,  2, 2, 1, 2, 1, 3, 4, 8, 9, 6, 6,  0 ; $42
	char_record 5, $0080, $00a0, $0800, $000c, 1, $0080, 18, 20, 10, 50, 3,  0, 0, 0, 9, 0, 0, 0, 0, 0, 0, 0,  0 ; $43
	char_record 6, $0080, $00a0, $0500, $000c, 1, $0080, 18, 24, 12, 40, 0,  1, 2, 4, 2, 3, 2, 3, 3, 4, 4, 4,  4 ; $44
	char_record 6, $0080, $00a0, $0800, $000c, 1, $0080, 18, 12, 10, 200, 0,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  0 ; $45
	char_record 1, $0080, $00a0, $0800, $000c, 1, $0080, 18, 12, 10, 200, 0,  0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0,  0 ; $46
	char_record 6, $0080, $00a0, $0200, $000c, 1, $0080, 40, 0, 12, 40, 1,  1, 2, 4, 2, 3, 2, 3, 9, 9, 4, 4,  0 ; $47
	char_record 6, $0060, $00a0, $0200, $000c, 1, $0080, 40, 0, 12, 40, 3,  1, 2, 2, 2, 3, 2, 3, 9, 9, 9, 4,  0 ; $48
	char_record 1, $0080, $00a0, $0800, $000c, 1, $0080, 18, 12, 10, 200, 0,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  0 ; $49
	char_record 1, $0080, $00a0, $0800, $000c, 1, $0080, 18, 12, 10, 200, 0,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  0 ; $4a
	char_record 1, $0080, $00a0, $0800, $000c, 1, $0080, 18, 12, 10, 200, 0,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  0 ; $4b
	char_record 1, $0080, $00a0, $0800, $000c, 1, $0080, 18, 20, 10, 200, 0,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  0 ; $4c
	char_record 1, $0080, $00a0, $0800, $000c, 1, $0080, 18, 12, 10, 200, 0,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  0 ; $4d
	char_record 1, $0080, $00a0, $0800, $000c, 1, $0080, 18, 12, 10, 200, 0,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  0 ; $4e
	char_record 1, $0080, $00a0, $0800, $000c, 1, $0080, 18, 12, 10, 200, 0,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  0 ; $4f
	char_record 1, $0080, $00a0, $0800, $000c, 1, $0080, 18, 20, 10, 200, 0,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  0 ; $50
	char_record 1, $0080, $00a0, $0800, $000c, 1, $0080, 18, 12, 10, 200, 0,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  0 ; $51
	char_record 1, $0080, $00a0, $0800, $000c, 1, $0080, 18, 12, 10, 200, 0,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  0 ; $52
	char_record 1, $0080, $00a0, $0800, $000c, 1, $0080, 18, 12, 10, 200, 0,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  0 ; $53
	char_record 3, $0080, $00a0, $0800, $000c, 1, $0080, 32, 0, 18, 40, 0,  0, 1, 0, 0, 1, 0, 1, 9, 9, 6, 6,  0 ; $54
	char_record 2, $0080, $00a0, $0800, $000c, 1, $0080, 24, 0, 12, 40, 4,  1, 2, 2, 2, 3, 2, 3, 9, 9, 6, 6,  0 ; $55
	char_record 3, $0080, $00a0, $0800, $000c, 1, $0080, 18, 0, 10, 120, 0,  2, 3, 4, 4, 5, 4, 5, 9, 9, 6, 6,  0 ; $56
	char_record 1, $0080, $00a0, $0800, $000c, 1, $0080, 18, 0, 10, 200, 0,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  0 ; $57
	char_record 5, $0080, $00a0, $0800, $000c, 1, $0080, 18, 0, 0, 200, 5,  0, 4, 0, 5, 0, 0, 0, 6, 6, 7, 6,  0 ; $58
	char_record 1, $0080, $00a0, $0800, $000c, 1, $0080, 18, 12, 10, 200, 0,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  0 ; $59
	char_record 1, $0080, $00a0, $0800, $000c, 1, $0080, 18, 12, 10, 200, 0,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  0 ; $5a
	char_record 1, $0080, $00a0, $0900, $000c, 5, $0080, 8, 7, 3, 190, 0,  3, 2, 5, 6, 5, 4, 6, 6, 5, 3, 3,  0 ; $5b
	char_record 1, $0080, $00a0, $0900, $000c, 6, $0080, 2, 2, 0, 230, 0,  3, 2, 5, 6, 5, 4, 6, 6, 5, 3, 3,  0 ; $5c
	char_record 1, $0080, $00a0, $0900, $000c, 7, $0080, 0, 0, 0, 255, 0,  4, 3, 6, 7, 6, 5, 7, 7, 6, 4, 4,  0 ; $5d
	char_record 1, $0080, $00a0, $0900, $000c, 5, $0080, 8, 7, 3, 190, 0,  3, 2, 5, 6, 5, 4, 6, 6, 5, 3, 3,  0 ; $5e
	char_record 1, $0080, $00a0, $0900, $000c, 6, $0080, 2, 2, 0, 230, 0,  3, 2, 5, 6, 5, 4, 6, 6, 5, 3, 3,  0 ; $5f
	char_record 1, $0080, $00a0, $0900, $000c, 7, $0080, 0, 0, 0, 255, 0,  4, 3, 6, 7, 6, 5, 7, 7, 6, 4, 4,  0 ; $60
	char_record 1, $0080, $00a0, $0800, $000c, 5, $0080, 8, 7, 3, 190, 0,  1, 3, 4, 4, 6, 5, 9, 4, 7, 7, 8,  0 ; $61
	char_record 1, $0080, $00a0, $0800, $000c, 6, $0080, 2, 2, 0, 230, 0,  1, 3, 4, 4, 6, 5, 9, 4, 7, 7, 8,  0 ; $62
	char_record 1, $0080, $00a0, $0800, $000c, 7, $0080, 0, 0, 0, 255, 0,  2, 4, 5, 5, 7, 6, 9, 5, 8, 8, 9,  0 ; $63
CharGroupTable_02:
	; $5e23, 144 bytes (AISHOT_* x 16 per serve style)
	db AISHOT_TOPSPIN, AISHOT_TOPSPIN, AISHOT_TOPSPIN, AISHOT_TOPSPIN, AISHOT_TOPSPIN, AISHOT_TOPSPIN, AISHOT_TOPSPIN, AISHOT_NEUTRAL, AISHOT_SLICE, AISHOT_SLICE, AISHOT_SLICE, AISHOT_SLICE, AISHOT_SLICE, AISHOT_SLICE, AISHOT_SLICE, AISHOT_NEUTRAL ; serve style 0
	db AISHOT_TOPSPIN, AISHOT_TOPSPIN, AISHOT_TOPSPIN, AISHOT_TOPSPIN, AISHOT_SLICE, AISHOT_SLICE, AISHOT_SLICE, AISHOT_SLICE, AISHOT_TOPSPIN, AISHOT_POWER_TOPSPIN, AISHOT_POWER_TOPSPIN, AISHOT_NEUTRAL, AISHOT_SLICE, AISHOT_POWER_SLICE, AISHOT_POWER_SLICE, AISHOT_NEUTRAL ; serve style 1
	db AISHOT_TOPSPIN, AISHOT_TOPSPIN, AISHOT_TOPSPIN, AISHOT_NEUTRAL, AISHOT_SLICE, AISHOT_SLICE, AISHOT_SLICE, AISHOT_NEUTRAL, AISHOT_POWER_TOPSPIN, AISHOT_POWER_TOPSPIN, AISHOT_POWER_TOPSPIN, AISHOT_LOB, AISHOT_POWER_SLICE, AISHOT_POWER_SLICE, AISHOT_POWER_SLICE, AISHOT_DROP ; serve style 2
	db AISHOT_NEUTRAL, AISHOT_NEUTRAL, AISHOT_NEUTRAL, AISHOT_POWER_TOPSPIN, AISHOT_POWER_TOPSPIN, AISHOT_POWER_TOPSPIN, AISHOT_POWER_TOPSPIN, AISHOT_POWER_TOPSPIN, AISHOT_POWER_SLICE, AISHOT_POWER_SLICE, AISHOT_POWER_SLICE, AISHOT_POWER_SLICE, AISHOT_SLICE, AISHOT_TOPSPIN, AISHOT_LOB, AISHOT_DROP ; serve style 3
	db AISHOT_NEUTRAL, AISHOT_NEUTRAL, AISHOT_NEUTRAL, AISHOT_NEUTRAL, AISHOT_NEUTRAL, AISHOT_NEUTRAL, AISHOT_NEUTRAL, AISHOT_NEUTRAL, AISHOT_NEUTRAL, AISHOT_NEUTRAL, AISHOT_NEUTRAL, AISHOT_NEUTRAL, AISHOT_NEUTRAL, AISHOT_NEUTRAL, AISHOT_NEUTRAL, AISHOT_NEUTRAL ; serve style 4
	db AISHOT_LOB, AISHOT_LOB, AISHOT_LOB, AISHOT_LOB, AISHOT_LOB, AISHOT_LOB, AISHOT_LOB, AISHOT_LOB, AISHOT_LOB, AISHOT_LOB, AISHOT_LOB, AISHOT_LOB, AISHOT_LOB, AISHOT_LOB, AISHOT_LOB, AISHOT_LOB ; serve style 5
	db AISHOT_DROP, AISHOT_DROP, AISHOT_DROP, AISHOT_DROP, AISHOT_DROP, AISHOT_DROP, AISHOT_DROP, AISHOT_DROP, AISHOT_DROP, AISHOT_DROP, AISHOT_DROP, AISHOT_DROP, AISHOT_DROP, AISHOT_DROP, AISHOT_DROP, AISHOT_DROP ; serve style 6
	db AISHOT_POWER_TOPSPIN, AISHOT_POWER_TOPSPIN, AISHOT_SLICE, AISHOT_POWER_SLICE, AISHOT_NEUTRAL, AISHOT_DROP, AISHOT_DROP, AISHOT_DROP, AISHOT_LOB, AISHOT_LOB, AISHOT_LOB, AISHOT_LOB, AISHOT_LOB, AISHOT_LOB, AISHOT_LOB, AISHOT_LOB ; serve style 7
	db AISHOT_POWER_TOPSPIN, AISHOT_POWER_TOPSPIN, AISHOT_POWER_TOPSPIN, AISHOT_POWER_TOPSPIN, AISHOT_NEUTRAL, AISHOT_POWER_SLICE, AISHOT_LOB, AISHOT_LOB, AISHOT_DROP, AISHOT_DROP, AISHOT_DROP, AISHOT_DROP, AISHOT_DROP, AISHOT_DROP, AISHOT_DROP, AISHOT_DROP ; serve style 8
GetCharGroupEntry:
	add a ; $5eb3
	add a ; $5eb4
	add a ; $5eb5
	add a ; $5eb6
	add $23 ; $5eb7
	ld l, a ; $5eb9
	adc $5e ; $5eba
	sub l ; $5ebc
	ld h, a ; $5ebd
	ld a, b ; $5ebe
	and $0f ; $5ebf
	add l ; $5ec1
	ld l, a ; $5ec2
	jr nc, .read ; $5ec3
	inc h ; $5ec5
.read:
	ld a, [hl] ; $5ec6
	ret ; $5ec7
Unused_02_CharGroupFind:
	add a ; $5ec8
	add a ; $5ec9
	add a ; $5eca
	add a ; $5ecb
	ld_hl_indexed CharGroupTable_02 ; $5ecc
	ld b, $10 ; $5ed3
.loop:
	ld a, [hl+] ; $5ed5
	cp $30 ; $5ed6
	jr z, .eq30 ; $5ed8
	dec b ; $5eda
	jr nz, .loop ; $5edb
	xor a ; $5edd
	ret ; $5ede
.eq30:
	ld a, $01 ; $5edf
	ret ; $5ee1
DoesCharGroupRowContain:
	add a ; $5ee2
	add a ; $5ee3
	add a ; $5ee4
	add a ; $5ee5
	ld_hl_indexed CharGroupTable_02 ; $5ee6
	ld c, $10 ; $5eed
.loop:
	ld a, [hl+] ; $5eef
	cp b ; $5ef0
	jr z, .zero ; $5ef1
	dec c ; $5ef3
	jr nz, .loop ; $5ef4
	xor a ; $5ef6
	ret ; $5ef7
.zero:
	ld a, $01 ; $5ef8
	ret ; $5efa
	; $5efb, 8453 bytes fill to bank end (linker-padded)
