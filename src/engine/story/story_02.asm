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
	push_wram_bank WRAM_SCENE ; $4119
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
	push_wram_bank WRAM_SCENE ; $4265
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
	push_wram_bank WRAM_SCENE ; $42d8
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
	ld hl, CHARREC_CHAR ; $43bb
	add hl, bc ; $43be
	ld [hl], a ; $43bf
	ld a, d ; $43c0
	call GetCharPaletteIndex ; $43c1
	ld hl, CHARREC_PALETTE ; $43c4
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
	ld hl, CHARREC_GENDER ; $43e4
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
	ld hl, CHARREC_EXP_TIER ; $43f8
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
