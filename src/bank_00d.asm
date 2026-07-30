SECTION "ROM Bank $0d", ROMX[$4000], BANK[$0d]

	farptr StartMinigameByID ; $4000
	farptr GetDefaultMinigameRecordValue ; $4002
	farptr ShowMinigamePointResult ; $4004
InitMinigameFromConfig:
	ld hl, $0000 ; $4006
	add hl, bc ; $4009
	ld a, [hl] ; $400a
	ld [wMatchOpponentChar], a ; $400b
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
	ld a, MATCHLIST_TRAINING ; $4026
	ld [wCurrentMinigameStoryMatch], a ; $4028
	ld hl, $0004 ; $402b
	add hl, bc ; $402e
	ld a, [hl] ; $402f
	ld [wCurrentMinigameStoryMatch + 1], a ; $4030
	ld hl, $0005 ; $4033
	add hl, bc ; $4036
	ld a, [hl] ; $4037
	ld [wMatchBGM], a ; $4038
	push bc ; $403b
	ld hl, $0007 ; $403c
	add hl, bc ; $403f
	ld b, [hl] ; $4040
	ld c, $00 ; $4041
	farcall InitCa00RecordFromCharId ; $4043
	ld a, [wStoryModeMainCharacterOverworldSprite] ; $4046
	ld [wMatchPlayerChar], a ; $4049
	ld a, [wMatchOpponentChar] ; $404c
	cp CHAR_NONE ; $404f
	jr z, .restore ; $4051
	ld b, a ; $4053
	ld c, $02 ; $4054
	farcall InitCa00RecordFromCharId ; $4056
.restore:
	pop bc ; $4059
	ld hl, $0008 ; $405a
	add hl, bc ; $405d
	ld a, [hl+] ; $405e
	ld d, [hl] ; $405f
	ld e, a ; $4060
	ldh a, [hRomBank] ; $4061
	farcall SetModeHookTable ; $4063
	ld hl, $000a ; $4066
	add hl, bc ; $4069
	ld a, [hl+] ; $406a
	ld d, [hl] ; $406b
	ld e, a ; $406c
	farcall SetMinigamePointTable ; $406d
	ld hl, $000c ; $4070
	add hl, bc ; $4073
	ld a, [hl+] ; $4074
	ld h, [hl] ; $4075
	ld l, a ; $4076
	ld a, h ; $4077
	or l ; $4078
	jr z, .done ; $4079
	call JumpToHL ; $407b
.done:
	ret ; $407e
StartMinigameByID:
	sub MINIGAME_TENNIS_MACHINE_1 ; $407f
	ld l, a ; $4081
	ld h, $00 ; $4082
	add hl, hl ; $4084
	ld de, MinigameConfigTable ; $4085
	add hl, de ; $4088
	ld a, [hl+] ; $4089
	ld b, [hl] ; $408a
	ld c, a ; $408b
	call InitMinigameFromConfig ; $408c
	ret ; $408f
MinigameConfigTable:
	; $4090, 36 bytes (minigame_configs)
	dw MinigameConfig_TennisMachine1 ; record 0
	dw MinigameConfig_TennisMachine2 ; record 1
	dw MinigameConfig_TennisMachine3 ; record 2
	dw MinigameConfig_TennisMachine4 ; record 3
	dw MinigameConfig_WallPractice1 ; record 4
	dw MinigameConfig_WallPractice2 ; record 5
	dw MinigameConfig_WallPractice3 ; record 6
	dw MinigameConfig_WallPractice4 ; record 7
	dw MinigameConfig_TennisMachineHighScore ; record 8
	dw MinigameConfig_WallPracticeHighScore ; record 9
	dw MinigameConfig_BooBlast ; record 10
	dw MinigameConfig_ShootingStar ; record 11
	dw MinigameConfig_PerfectShot ; record 12
	dw MinigameConfig_TargetShot ; record 13
	dw MinigameConfig_FruitFantasy ; record 14
	dw MinigameConfig_BananaBunch ; record 15
	dw MinigameConfig_TreasureBox ; record 16
	dw MinigameConfig_MedallionMatch ; record 17
MinigamePointLayoutSolo:
	; $40b4, 9 bytes (bytes:9)
	db $00, $09, $09, $09, $00, $09, $09, $09, $ff ; 0x00
MinigamePointLayoutDuo:
	; $40bd, 9 bytes (bytes:9)
	db $00, $03, $09, $09, $01, $00, $09, $09, $ff ; 0x00
MinigamePointLayoutBooBlast:
	; $40c6, 9 bytes (bytes:9)
	db $00, $03, $09, $09, $00, $01, $09, $09, $ff ; 0x00
InitMinigameScore:
	xor a ; $40cf
	ld hl, wMinigamesCurrentScore ; $40d0
	ld [hl+], a ; $40d3
	ld [hl+], a ; $40d4
	ld hl, wMinigameServeCount ; $40d5
	ld [hl+], a ; $40d8
	ld [hl+], a ; $40d9
	ld a, [wMinigameLevel] ; $40da
	ld b, a ; $40dd
	ld a, [wCurrentMinigameStoryMatch + 1] ; $40de
	call GetMinigameTargetScore ; $40e1
	ld hl, wMinigamesTargetScore ; $40e4
	ld a, e ; $40e7
	ld [hl+], a ; $40e8
	ld [hl], d ; $40e9
	ld a, [wCurrentMinigameStoryMatch + 1] ; $40ea
	sub MINIGAME_TENNIS_MACHINE_HIGH_SCORE ; $40ed
	ret c ; $40ef
	add LOW(MinigameRecordSlotIds) ; $40f0
	ld l, a ; $40f2
	adc HIGH(MinigameRecordSlotIds) ; $40f3
	sub l ; $40f5
	ld h, a ; $40f6
	ld a, [hl] ; $40f7
	farcall ReadMinigameRecord ; $40f8
	ldh a, [hWramBank] ; $40fb
	push af ; $40fd
	wram_bank $07 ; $40fe
	ld hl, wMinigameRecordValue ; $4104
	ld de, wMinigameHighScore ; $4107
	ld a, [hl+] ; $410a
	ld [de], a ; $410b
	inc de ; $410c
	ld a, [hl+] ; $410d
	ld [de], a ; $410e
	inc de ; $410f
	pop af ; $4110
	wram_bank ; $4111
	ret ; $4115
MinigameRecordSlotIds:
	; $4116, 11 bytes (bytes:11)
	db $01, $00, $02, $03, $04, $05, $06, $07, $08, $09, $0a ; 0x00
GetMinigameTargetScore:
	ld de, $0000 ; $4121
	cp MINIGAME_TENNIS_MACHINE_1 ; $4124
	ret c ; $4126
	cp MINIGAME_BOO_BLAST ; $4127
	jr nc, .ge1c ; $4129
	sub MINIGAME_TENNIS_MACHINE_1 ; $412b
	add a ; $412d
	add LOW(MinigamePracticeTargetScores) ; $412e
	ld l, a ; $4130
	adc HIGH(MinigamePracticeTargetScores) ; $4131
	sub l ; $4133
	ld h, a ; $4134
	ld a, [hl+] ; $4135
	ld d, [hl] ; $4136
	ld e, a ; $4137
	ret ; $4138
.ge1c:
	sub MINIGAME_BOO_BLAST ; $4139
	add a ; $413b
	add a ; $413c
	add b ; $413d
	add a ; $413e
	add LOW(MinigameTargetScores) ; $413f
	ld l, a ; $4141
	adc HIGH(MinigameTargetScores) ; $4142
	sub l ; $4144
	ld h, a ; $4145
	ld a, [hl+] ; $4146
	ld d, [hl] ; $4147
	ld e, a ; $4148
	ret ; $4149
MinigamePracticeTargetScores:
	; $414a, 6 bytes (records:2)
	dw $000f ; record 0
	dw $001e ; record 1
	dw $003c ; record 2
MinigameDefaultRecordValue00:
	; $4150, 8 bytes (records:2)
	dw $0064 ; record 0
	dw $0032 ; record 1
	dw $0032 ; record 2
	dw $0032 ; record 3
MinigameDefaultRecordValue01:
	; $4158, 6 bytes (records:2)
	dw $0032 ; record 0
	dw $270f ; record 1
	dw $270f ; record 2
MinigameTargetScores:
	; $415e, 2 bytes (records:2)
	dw $001e ; record 0
MinigameDefaultRecordValue02:
	; $4160, 8 bytes (records:2)
	dw $003c ; record 0
	dw $270f ; record 1
	dw $0000 ; record 2
	dw $001e ; record 3
MinigameDefaultRecordValue03:
	; $4168, 8 bytes (records:2)
	dw $003c ; record 0
	dw $270f ; record 1
	dw $0000 ; record 2
	dw $0015 ; record 3
MinigameDefaultRecordValue04:
	; $4170, 8 bytes (records:2)
	dw $0015 ; record 0
	dw $270f ; record 1
	dw $0000 ; record 2
	dw $001e ; record 3
MinigameDefaultRecordValue05:
	; $4178, 8 bytes (records:2)
	dw $003c ; record 0
	dw $270f ; record 1
	dw $0000 ; record 2
	dw $0032 ; record 3
MinigameDefaultRecordValue06:
	; $4180, 8 bytes (records:2)
	dw $0064 ; record 0
	dw $270f ; record 1
	dw $0000 ; record 2
	dw $001e ; record 3
MinigameDefaultRecordValue07:
	; $4188, 8 bytes (records:2)
	dw $003c ; record 0
	dw $270f ; record 1
	dw $0000 ; record 2
	dw $00c8 ; record 3
MinigameDefaultRecordValue08:
	; $4190, 8 bytes (records:2)
	dw $012c ; record 0
	dw $270f ; record 1
	dw $0000 ; record 2
	dw $0064 ; record 3
MinigameDefaultRecordValue09:
	; $4198, 8 bytes (records:2)
	dw $012c ; record 0
	dw $270f ; record 1
	dw $0000 ; record 2
	dw $0001 ; record 3
MinigameDefaultRecordValue10:
	; $41a0, 6 bytes (records:2)
	dw $0001 ; record 0
	dw $270f ; record 1
	dw $0000 ; record 2
GetDefaultMinigameRecordValue:
	add a ; $41a6
	add LOW(MinigameDefaultRecordValuePointers) ; $41a7
	ld l, a ; $41a9
	adc HIGH(MinigameDefaultRecordValuePointers) ; $41aa
	sub l ; $41ac
	ld h, a ; $41ad
	ld a, [hl+] ; $41ae
	ld h, [hl] ; $41af
	ld l, a ; $41b0
	ld a, [hl+] ; $41b1
	ld d, [hl] ; $41b2
	ld e, a ; $41b3
	ret ; $41b4
MinigameDefaultRecordValuePointers:
	; $41b5, 22 bytes (records:2)
	dw MinigameDefaultRecordValue01 ; record 0
	dw MinigameDefaultRecordValue00 ; record 1
	dw MinigameDefaultRecordValue02 ; record 2
	dw MinigameDefaultRecordValue03 ; record 3
	dw MinigameDefaultRecordValue04 ; record 4
	dw MinigameDefaultRecordValue05 ; record 5
	dw MinigameDefaultRecordValue06 ; record 6
	dw MinigameDefaultRecordValue07 ; record 7
	dw MinigameDefaultRecordValue08 ; record 8
	dw MinigameDefaultRecordValue09 ; record 9
	dw MinigameDefaultRecordValue10 ; record 10
IncrementCappedCounter:
	ld hl, wMinigameHitStreak ; $41cb
	ld a, [hl] ; $41ce
	cp b ; $41cf
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
	sub e ; $41e0
	ld l, a ; $41e1
	ld a, h ; $41e2
	sbc d ; $41e3
	ld h, a ; $41e4
	bit 7, h ; $41e5
	jr nz, .notReached ; $41e7
	ld a, $01 ; $41e9
	ret ; $41eb
.notReached:
	xor a ; $41ec
	ret ; $41ed
IsMinigameScoreLimitReached:
	ld hl, wMinigamesCurrentScore ; $41ee
	ld a, [hl+] ; $41f1
	ld d, [hl] ; $41f2
	ld e, a ; $41f3
	ld hl, $d8f1 ; $41f4
	add hl, de ; $41f7
	ld a, h ; $41f8
	or l ; $41f9
	jr z, .returnOne ; $41fa
	ld hl, wMinigameHighScore ; $41fc
	ld a, [hl+] ; $41ff
	ld h, [hl] ; $4200
	ld l, a ; $4201
	ld a, l ; $4202
	sub e ; $4203
	ld l, a ; $4204
	ld a, h ; $4205
	sbc d ; $4206
	ld h, a ; $4207
	bit 7, h ; $4208
	jr nz, .returnOne ; $420a
	xor a ; $420c
	ret ; $420d
.returnOne:
	ld a, $01 ; $420e
	ret ; $4210
StartScorePopup:
	ldh a, [hWramBank] ; $4211
	push af ; $4213
	wram_bank $04 ; $4214
	ld hl, wBallHistory + 30 ; $421a
	ld de, wScorePopupSource ; $421d
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
	ld [wScorePopupTimer], a ; $4233
	ret ; $4236
UpdateScorePopup:
	ld a, [wScorePopupTimer] ; $4237
	and a ; $423a
	ret z ; $423b
	ld hl, wScorePopupTimer ; $423c
	call TickTimer ; $423f
	ld hl, wScorePopupSource + 2 ; $4242
	ld a, [hl+] ; $4245
	ld b, [hl] ; $4246
	ld c, a ; $4247
	ld hl, wScorePopupSource ; $4248
	ld a, [hl+] ; $424b
	ld h, [hl] ; $424c
	ld l, a ; $424d
	farcall ApplyCameraProjection ; $424e
	ld a, [wScorePopupTimer] ; $4251
	add e ; $4254
	add $e8 ; $4255
	ld e, a ; $4257
	ld hl, wScorePopupValue ; $4258
	ld a, [hl+] ; $425b
	ld h, [hl] ; $425c
	ld l, a ; $425d
	ld b, $01 ; $425e
	ld a, $01 ; $4260
	farcall DrawNumberWithSprites ; $4262
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
	jr nc, .store ; $4273
	ld de, $270f ; $4275
.store:
	ld hl, wMinigamesCurrentScore ; $4278
	ld a, e ; $427b
	ld [hl+], a ; $427c
	ld [hl], d ; $427d
	ret ; $427e
MinigameGridCellTiles:
	; $427f, 32 bytes (bytes:4)
	db $08, $08, $08, $08 ; 0x00
	db $0a, $0b, $1a, $1b ; 0x04
	db $0d, $0e, $1d, $1e ; 0x08
	db $0d, $0e, $1d, $1e ; 0x0c
	db $9a, $9b, $a8, $a9 ; 0x10
	db $9c, $9d, $aa, $a9 ; 0x14
	db $b3, $b4, $aa, $b6 ; 0x18
	db $b3, $9b, $b7, $b8 ; 0x1c
MinigameGridCellAttrs:
	; $429f, 32 bytes (bytes:4)
	db $08, $08, $08, $08 ; 0x00
	db $0c, $0c, $0c, $0c ; 0x04
	db $0e, $0e, $0e, $0e ; 0x08
	db $0d, $0d, $0d, $0d ; 0x0c
	db $0c, $0c, $0c, $0c ; 0x10
	db $0c, $0c, $0c, $0c ; 0x14
	db $0c, $0c, $0c, $0c ; 0x18
	db $0c, $0c, $0c, $0c ; 0x1c
GetMinigameGridCellIndex:
	ldh a, [hWramBank] ; $42bf
	push af ; $42c1
	wram_bank $04 ; $42c2
	ld hl, wBallHistory + 30 ; $42c8
	ld a, [hl+] ; $42cb
	ld d, [hl] ; $42cc
	ld e, a ; $42cd
	ld hl, wBallHistory + 32 ; $42ce
	ld a, [hl+] ; $42d1
	ld b, [hl] ; $42d2
	ld c, a ; $42d3
	pop af ; $42d4
	wram_bank ; $42d5
	ld a, d ; $42d9
	add $0f ; $42da
	set 0, a ; $42dc
	ld d, a ; $42de
	ld a, b ; $42df
	add $10 ; $42e0
	res 0, a ; $42e2
	ld e, a ; $42e4
	ld a, d ; $42e5
	sub $09 ; $42e6
	srl a ; $42e8
	ld b, a ; $42ea
	cp $07 ; $42eb
	jr nc, .notFound ; $42ed
	ld a, e ; $42ef
	sub $08 ; $42f0
	srl a ; $42f2
	ld c, a ; $42f4
	cp $03 ; $42f5
	jr nc, .notFound ; $42f7
	ld a, c ; $42f9
	add a ; $42fa
	add a ; $42fb
	add a ; $42fc
	add b ; $42fd
	ret ; $42fe
.notFound:
	ld a, $ff ; $42ff
	ret ; $4301
DrawMinigameGrid:
	ld hl, wMinigameTargetGrid ; $4302
	ld c, $00 ; $4305
	ld b, $18 ; $4307
.loop:
	ld a, [hl+] ; $4309
	and a ; $430a
	jr z, .zero ; $430b
	push bc ; $430d
	push hl ; $430e
	ld b, a ; $430f
	ld a, c ; $4310
	call DrawMinigameGridCell ; $4311
	pop hl ; $4314
	pop bc ; $4315
.zero:
	inc c ; $4316
	dec b ; $4317
	jr nz, .loop ; $4318
	ret ; $431a
DrawMinigameGridCell:
	add a ; $431b
	add LOW(MinigameGridCellTilemapOffsets) ; $431c
	ld l, a ; $431e
	adc HIGH(MinigameGridCellTilemapOffsets) ; $431f
	sub l ; $4321
	ld h, a ; $4322
	ld a, [hl+] ; $4323
	ld d, [hl] ; $4324
	ld e, a ; $4325
	ld a, b ; $4326
	add a ; $4327
	add a ; $4328
	add $9f ; $4329
	ld l, a ; $432b
	adc $42 ; $432c
	sub l ; $432e
	ld h, a ; $432f
	push hl ; $4330
	push hl ; $4331
	ld a, b ; $4332
	add a ; $4333
	add a ; $4334
	add $7f ; $4335
	ld l, a ; $4337
	adc $42 ; $4338
	sub l ; $433a
	ld h, a ; $433b
	push hl ; $433c
	push hl ; $433d
	pop hl ; $433e
	push de ; $433f
	ld a, d ; $4340
	add $d8 ; $4341
	ld d, a ; $4343
	ld bc, $0202 ; $4344
	call CopyTextRect ; $4347
	pop de ; $434a
	pop hl ; $434b
	push de ; $434c
	ld a, d ; $434d
	add $d0 ; $434e
	ld d, a ; $4350
	ld bc, $0202 ; $4351
	call CopyTextRect ; $4354
	pop de ; $4357
	pop hl ; $4358
	push de ; $4359
	ld a, d ; $435a
	add $dc ; $435b
	ld d, a ; $435d
	ld bc, $0202 ; $435e
	call CopyTextRect ; $4361
	pop de ; $4364
	pop hl ; $4365
	push de ; $4366
	ld a, d ; $4367
	add $d4 ; $4368
	ld d, a ; $436a
	ld bc, $0202 ; $436b
	call CopyTextRect ; $436e
	pop de ; $4371
	ret ; $4372
MinigameGridCellTilemapOffsets:
	; $4373, 48 bytes (records:2)
	dw $0109 ; record 0
	dw $010b ; record 1
	dw $010d ; record 2
	dw $010f ; record 3
	dw $0111 ; record 4
	dw $0113 ; record 5
	dw $0115 ; record 6
	dw $0117 ; record 7
	dw $0149 ; record 8
	dw $014b ; record 9
	dw $014d ; record 10
	dw $014f ; record 11
	dw $0151 ; record 12
	dw $0153 ; record 13
	dw $0155 ; record 14
	dw $0157 ; record 15
	dw $0189 ; record 16
	dw $018b ; record 17
	dw $018d ; record 18
	dw $018f ; record 19
	dw $0191 ; record 20
	dw $0193 ; record 21
	dw $0195 ; record 22
	dw $0197 ; record 23
QueueMinigameHudVRAMCopy:
	ld hl, wScreenAttrmap + 9 * TILEMAP_WIDTH ; $43a3
	ld de, $9920 ; $43a6
	ld c, $0a ; $43a9
	call QueueVRAMCopy ; $43ab
	ld hl, $d520 ; $43ae
	ld de, $9920 + VRAM_BANK1 ; $43b1
	ld c, $0a ; $43b4
	call QueueVRAMCopy ; $43b6
	ret ; $43b9
ShowPointOutcomeBanner:
	ld a, [wPointOutcome] ; $43ba
	cp $06 ; $43bd
	jr z, .done ; $43bf
	cp $09 ; $43c1
	jr z, .done ; $43c3
	cp $0b ; $43c5
	jr z, .done ; $43c7
	ld a, [wPointOutcome] ; $43c9
	add $00 ; $43cc
	farcall ShowCourtBanner ; $43ce
	ld a, $1e ; $43d1
	farcall StepMatchFrames ; $43d3
	farcall HideCourtBanner ; $43d6
	ld a, $0a ; $43d9
	farcall StepMatchFrames ; $43db
.done:
	ret ; $43de
DetermineMinigamePointResult:
	ld a, [wMinigameHighScoreMode] ; $43df
	and a ; $43e2
	jr nz, .isMinigameScoreLimitReached ; $43e3
	ld a, [wPointOutcome] ; $43e5
	cp $0b ; $43e8
	jr z, .eq0b ; $43ea
	jr .storePointWinLoseFlag ; $43ec
.isMinigameScoreLimitReached:
	call IsMinigameScoreLimitReached ; $43ee
	and a ; $43f1
	jr nz, .nonZero ; $43f2
	jr .storePointWinLoseFlag ; $43f4
.eq0b:
	ld a, $01 ; $43f6
	ld [wPointWinLoseFlag], a ; $43f8
	ld a, [wMinigameLevel] ; $43fb
	add $12 ; $43fe
	ld d, a ; $4400
	ret ; $4401
.nonZero:
	ld a, $01 ; $4402
	ld [wPointWinLoseFlag], a ; $4404
	ld d, $16 ; $4407
	ret ; $4409
.storePointWinLoseFlag:
	ld a, $ff ; $440a
	ld [wPointWinLoseFlag], a ; $440c
	ld d, $17 ; $440f
	ret ; $4411
ShowMinigamePointResult:
	ld a, [wPointWinLoseFlag] ; $4412
	add a ; $4415
	jr c, .lostPoint ; $4416
	sound BGM_WIN ; $4418
	jr .showBanner ; $441a
.lostPoint:
	sound BGM_LOSE ; $441c
.showBanner:
	farcall StepMatchFrame ; $441e
	ld a, d ; $4421
	farcall ShowCourtBanner ; $4422
	ld a, $0a ; $4425
	farcall StepMatchFrames ; $4427
	ld a, $2d ; $442a
	farcall StepMatchFramesSkippable ; $442c
	farcall RunMatchFramesUntilInput ; $442f
	farcall HideCourtBanner ; $4432
	ld a, $0f ; $4435
	farcall StepMatchFrames ; $4437
	ld a, $80 ; $443a
	ld [wMatchAbortFlag], a ; $443c
	ret ; $443f
ClearMinigameActors:
	wram_bank $04 ; $4440
	ld hl, wMinigameActors ; $4446
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
SetMinigameActorPosition:
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
	farcall ProjectWorldToScreen_08 ; $4483
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
SetMinigameActorWorldPos:
	ld c, l ; $449a
	ld b, h ; $449b
	ld hl, wMinigameSceneActor + 6 ; $449c
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
	farcall ProjectWorldToScreen_08 ; $44ac
	ld e, l ; $44af
	ld d, h ; $44b0
	ld hl, wMinigameSceneActor + 10 ; $44b1
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
	ld hl, wMinigameActors ; $44c3
	ld c, $07 ; $44c6
.actorLoop:
	call UpdateMinigameActor ; $44c8
	ld de, $0010 ; $44cb
	add hl, de ; $44ce
	dec c ; $44cf
	jr nz, .actorLoop ; $44d0
	ret ; $44d2
UpdateMinigameActor:
	bit 0, [hl] ; $44d3
	ret z ; $44d5
	push af ; $44d6
	push bc ; $44d7
	push de ; $44d8
	push hl ; $44d9
	push hl ; $44da
	ld de, wMinigameSceneActor ; $44db
	ld c, $01 ; $44de
	call CopyMemoryFast ; $44e0
	ld hl, wMinigameSceneActor + 14 ; $44e3
	ld a, [hl+] ; $44e6
	ld h, [hl] ; $44e7
	ld l, a ; $44e8
	call JumpToHL ; $44e9
	pop de ; $44ec
	ld hl, wMinigameSceneActor ; $44ed
	ld c, $01 ; $44f0
	call CopyMemoryFast ; $44f2
	pop hl ; $44f5
	pop de ; $44f6
	pop bc ; $44f7
	pop af ; $44f8
	ret ; $44f9
MinigameConfig_TennisMachine1:
	; $44fa, 16 bytes (bytes:16)
	db $15, $0a, $02, $06, $12, $1e, $00, $80, $15, $45, $bd, $40, $0a, $45, $00, $00 ; 0x00
InitMinigame_TennisMachine1:
	ld a, $01 ; $450a
	ld [wMinigameUsesTennisMachine], a ; $450c
	ld a, $00 ; $450f
	ld [wMinigameLevel], a ; $4511
	ret ; $4514
MinigameHooks_TennisMachine1:
	; $4515, 16 bytes (mode_hooks)
	dw TennisMachine1Hook_PerFrame ; record 0
	dw TennisMachine1Hook_PointStart ; record 1
	dw TennisMachine1Hook_PointEnd ; record 2
	dw TennisMachine1Hook_MinigameStart ; record 3
	dw TennisMachine1Hook_BallHit ; record 4
	dw TennisMachine1Hook_Bounce ; record 5
	dw TennisMachine1Hook_RallyTick ; record 6
	dw RetStub ; record 7
TennisMachine1Hook_MinigameStart:
	ld a, $01 ; $4525
	ld [wMinigameServeSlot], a ; $4527
	call StartMinigameMatch ; $452a
	ret ; $452d
TennisMachine1Hook_PerFrame:
	call DrawMinigameScoreHud ; $452e
	ret ; $4531
TennisMachine1Hook_PointStart:
	call LaunchMinigameServe ; $4532
	ret ; $4535
TennisMachine1Hook_PointEnd:
	call AwardMinigamePointAndEnd ; $4536
	ret ; $4539
TennisMachine1Hook_RallyTick:
	call KeepMinigameCameraFixed ; $453a
	ret ; $453d
TennisMachine1Hook_Bounce:
	call CheckMinigameStartBannerTrigger ; $453e
	ret ; $4541
TennisMachine1Hook_BallHit:
	call FreezeMinigameOpponentOnReturn ; $4542
	ret ; $4545
MinigameShotDifficultyRamp:
	; $4546, 1 bytes (bytes:4)
	db $01 ; 0x00
EndMinigamePoint_PointOutcomeTable:
	db $01 ; $4547
LaunchBallTable:
	INCBIN "data/bank_00d/d_4548.bin" ; $4548, 102 bytes
MinigameShotIntervalByTempo:
	; $45ae, 5 bytes (bytes:5)
	db $28, $28, $1e, $14, $0a ; 0x00
MinigameShotAimPools:
	; $45b3, 144 bytes (bytes:16)
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; 0x00
	db $10, $10, $10, $10, $10, $10, $10, $10, $20, $20, $20, $20, $20, $20, $20, $20 ; 0x10
	db $11, $11, $11, $11, $11, $11, $11, $11, $22, $22, $22, $22, $22, $22, $22, $22 ; 0x20
	db $10, $10, $10, $10, $10, $10, $12, $12, $20, $20, $20, $20, $20, $20, $21, $21 ; 0x30
	db $10, $10, $10, $10, $30, $30, $12, $12, $20, $20, $20, $20, $30, $30, $21, $21 ; 0x40
	db $11, $11, $11, $11, $30, $30, $12, $12, $22, $22, $22, $22, $30, $30, $21, $21 ; 0x50
	db $12, $12, $12, $12, $12, $12, $12, $12, $12, $12, $12, $12, $12, $12, $12, $12 ; 0x60
	db $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21, $21 ; 0x70
	db $30, $30, $30, $30, $30, $30, $30, $30, $30, $30, $30, $30, $30, $30, $30, $30 ; 0x80
MinigameShotSpinPool:
	; $4643, 8 bytes (bytes:8)
	db $00, $00, $ff, $ff, $ff, $01, $01, $01 ; 0x00
MinigameCharCoordsTable:
	; $464b, 36 bytes (bytes:4)
	db $a0, $fe, $00, $fc ; 0x00
	db $00, $00, $00, $fc ; 0x04
	db $60, $01, $00, $fc ; 0x08
	db $a0, $fe, $40, $fd ; 0x0c
	db $00, $00, $40, $fd ; 0x10
	db $60, $01, $40, $fd ; 0x14
	db $a0, $fe, $c0, $fe ; 0x18
	db $00, $00, $c0, $fe ; 0x1c
	db $60, $01, $c0, $fe ; 0x20
MinigameBallLaunchHeights:
	; $466f, 6 bytes (records:2)
	dw $ffa0 ; record 0
	dw $ff80 ; record 1
	dw $ff60 ; record 2
MinigameBallLaunchSpeeds:
	; $4675, 3 bytes (bytes:3)
	db $ef, $c1, $93 ; 0x00
StartMinigameMatch:
	call InitMinigameScore ; $4678
	ld hl, $0000 ; $467b
	ld de, $fe00 ; $467e
	call SnapCameraTo_0d ; $4681
	ld de, $fb20 ; $4684
	ld hl, wCourtLimitDepth ; $4687
	ld a, e ; $468a
	ld [hl+], a ; $468b
	ld [hl], d ; $468c
	ld de, $fe50 ; $468d
	ld hl, wCourtLimitX ; $4690
	ld a, e ; $4693
	ld [hl+], a ; $4694
	ld [hl], d ; $4695
	wram_bank $04 ; $4696
	ld hl, $0000 ; $469c
	ld de, $0480 ; $469f
	farcall SetCharPosAndTarget ; $46a2
	ld a, $05 ; $46a5
	farcall SetCharState ; $46a7
	wram_bank $05 ; $46aa
	ld a, [wMinigameServeSlot] ; $46b0
	call GetMinigameCharCoordsEntry ; $46b3
	farcall SetCharPosAndTarget ; $46b6
	ld a, $06 ; $46b9
	farcall SetCharState ; $46bb
	ld a, $04 ; $46be
	ld [wCharAimJitterScale], a ; $46c0
	xor a ; $46c3
	ld [wMinigameServeState], a ; $46c4
	ld a, [wCharId] ; $46c7
	cp $15 ; $46ca
	jr nz, .countdown ; $46cc
	ld a, $01 ; $46ce
	ld [wMinigameServeState], a ; $46d0
.countdown:
	call PlayMinigameCountdown ; $46d3
	ret ; $46d6
DrawMinigameScoreHud:
	ld de, $8403 ; $46d7
	call DrawMinigameScore ; $46da
	ld a, [wMinigameServeState] ; $46dd
	and a ; $46e0
	jr z, .done ; $46e1
	ldh a, [hWramBank] ; $46e3
	push af ; $46e5
	wram_bank $05 ; $46e6
	ld hl, wCharSpriteSlot + 1 ; $46ec
	res 5, [hl] ; $46ef
	pop af ; $46f1
	wram_bank ; $46f2
.done:
	ret ; $46f6
LaunchMinigameServe:
	ld b, $19 ; $46f7
	ld hl, wMinigameServeCount ; $46f9
	ld a, [hl+] ; $46fc
	ld h, [hl] ; $46fd
	ld l, a ; $46fe
	ld a, h ; $46ff
	and a ; $4700
	jr nz, .gotSpeed ; $4701
	xor a ; $4703
	ld h, a ; $4704
	ld e, $0a ; $4705
	call DivAHLByE ; $4707
	ld b, l ; $470a
.gotSpeed:
	ld a, b ; $470b
	ld [wMinigameServeSpeed], a ; $470c
	ldh a, [hWramBank] ; $470f
	push af ; $4711
	wram_bank $05 ; $4712
	ld d, $05 ; $4718
	farcall SetCharAnimation ; $471a
	pop af ; $471d
	wram_bank ; $471e
	ld a, [wMinigameServeState] ; $4722
	and a ; $4725
	jr z, .launch ; $4726
	ld a, $0f ; $4728
	farcall StepMatchFrames ; $472a
.launch:
	ld hl, wMinigameServeCount ; $472d
	ld a, [hl+] ; $4730
	ld d, [hl] ; $4731
	ld e, a ; $4732
	inc de ; $4733
	ld hl, wMinigameServeCount ; $4734
	ld a, e ; $4737
	ld [hl+], a ; $4738
	ld [hl], d ; $4739
	call LaunchBall ; $473a
	ld a, [wMinigameServeSlot] ; $473d
	ld l, a ; $4740
	ld h, $00 ; $4741
	ld de, $0003 ; $4743
	call DivHLByDE ; $4746
	ld a, l ; $4749
	ld [wMinigameServeGroup], a ; $474a
	call ApplyMinigameCharTargetFromTable ; $474d
	ret ; $4750
AwardMinigamePointAndEnd:
	farcall ResolvePointWinner ; $4751
	add a ; $4754
	jr c, EndMinigamePoint ; $4755
	ld de, $0001 ; $4757
	call AddToMinigameScore ; $475a
EndMinigamePoint:
	ldh a, [hWramBank] ; $475d
	push af ; $475f
	wram_bank $04 ; $4760
	ld a, $05 ; $4766
	farcall SetCharState ; $4768
	pop af ; $476b
	wram_bank ; $476c
	call ShowPointOutcomeBanner ; $4770
	farcall ResolvePointWinner ; $4773
	add a ; $4776
	jr c, .resolve ; $4777
	ld a, [wMinigameServeSpeed] ; $4779
	add a ; $477c
	add a ; $477d
	add LOW(EndMinigamePoint_PointOutcomeTable) ; $477e
	ld l, a ; $4780
	adc HIGH(EndMinigamePoint_PointOutcomeTable) ; $4781
	sub l ; $4783
	ld h, a ; $4784
	ld a, [hl] ; $4785
	add LOW(MinigameShotIntervalByTempo) ; $4786
	ld l, a ; $4788
	adc HIGH(MinigameShotIntervalByTempo) ; $4789
	sub l ; $478b
	ld h, a ; $478c
	ld a, [hl] ; $478d
	farcall StepMatchFrames ; $478e
	call IsMinigameTargetReached ; $4791
	and a ; $4794
	ret z ; $4795
	ld a, $0b ; $4796
	ld [wPointOutcome], a ; $4798
.resolve:
	call DetermineMinigamePointResult ; $479b
	push de ; $479e
	ldh a, [hWramBank] ; $479f
	push af ; $47a1
	wram_bank $04 ; $47a2
	farcall CharPointEndReaction ; $47a8
	wram_bank $05 ; $47ab
	farcall CharPointEndReaction ; $47b1
	pop af ; $47b4
	wram_bank ; $47b5
	pop de ; $47b9
	call ShowMinigamePointResult ; $47ba
	ret ; $47bd
KeepMinigameCameraFixed:
	xor a ; $47be
	ld [wCameraFollowBall], a ; $47bf
	ret ; $47c2
CheckMinigameStartBannerTrigger:
	ld a, [wPointOutcome] ; $47c3
	and a ; $47c6
	jr nz, .done ; $47c7
	ld a, [wRallyLength] ; $47c9
	cp $04 ; $47cc
	jr nz, .done ; $47ce
	ld a, [wBallBounceCount] ; $47d0
	cp $01 ; $47d3
	jr nz, .done ; $47d5
	ld a, $06 ; $47d7
	ld [wPointOutcome], a ; $47d9
	ld a, $01 ; $47dc
	ld [wPointOutcomeSide], a ; $47de
.done:
	ret ; $47e1
FreezeMinigameOpponentOnReturn:
	ld a, [wRallyLength] ; $47e2
	cp $03 ; $47e5
	jr nz, .done ; $47e7
	ldh a, [hWramBank] ; $47e9
	push af ; $47eb
	wram_bank $05 ; $47ec
	ld a, $28 ; $47f2
	ld [wCharFreezeTimer], a ; $47f4
	pop af ; $47f7
	wram_bank ; $47f8
.done:
	ret ; $47fc
LaunchBall:
	ld a, $01 ; $47fd
	ld [wBallSpriteEnabled], a ; $47ff
	ld [wBallShadowEnabled], a ; $4802
	ld [wBallTrailEnabled], a ; $4805
	ld a, $02 ; $4808
	ld [wRallyLength], a ; $480a
	ld a, $02 ; $480d
	ld [wBallCourtQuadrant], a ; $480f
	ldh a, [hWramBank] ; $4812
	push af ; $4814
	wram_bank $05 ; $4815
	ld a, $20 ; $481b
	ld [wCharSwingFrames], a ; $481d
	ld a, [wMinigameServeSpeed] ; $4820
	add a ; $4823
	add a ; $4824
	add LOW(LaunchBallTable) ; $4825
	ld l, a ; $4827
	adc HIGH(LaunchBallTable) ; $4828
	sub l ; $482a
	ld h, a ; $482b
	ld a, [hl] ; $482c
	dec a ; $482d
	ld [wGroundStrokeSpeedIndex], a ; $482e
	ld [wReachSpeedIndex], a ; $4831
	ld [wSlicePlacementIndex], a ; $4834
	ld [wTopspinPlacementIndex], a ; $4837
	ld a, [wMinigameServeSpeed] ; $483a
	add a ; $483d
	add a ; $483e
	add LOW(MinigameShotDifficultyRamp) ; $483f
	ld l, a ; $4841
	adc HIGH(MinigameShotDifficultyRamp) ; $4842
	sub l ; $4844
	ld h, a ; $4845
	ld a, [hl] ; $4846
	add a ; $4847
	add a ; $4848
	add a ; $4849
	add a ; $484a
	add $b3 ; $484b
	ld l, a ; $484d
	adc $45 ; $484e
	sub l ; $4850
	ld h, a ; $4851
	farcall AdvanceMatchRng ; $4852
	and $0f ; $4855
	add l ; $4857
	ld l, a ; $4858
	jr nc, .read ; $4859
	inc h ; $485b
.read:
	ld a, [hl] ; $485c
	swap a ; $485d
	and $0f ; $485f
	ld [wCharShotButton1], a ; $4861
	ld a, [hl] ; $4864
	and $0f ; $4865
	ld [wCharShotButton2], a ; $4867
	farcall SelectRallyShotType ; $486a
	ld a, [wMinigameServeGroup] ; $486d
	add LOW(MinigameBallLaunchSpeeds) ; $4870
	ld l, a ; $4872
	adc HIGH(MinigameBallLaunchSpeeds) ; $4873
	sub l ; $4875
	ld h, a ; $4876
	ld a, [hl] ; $4877
	ld [wCharAimOffsetScale], a ; $4878
	ld a, [wMinigameServeGroup] ; $487b
	add a ; $487e
	add LOW(MinigameBallLaunchHeights) ; $487f
	ld l, a ; $4881
	adc HIGH(MinigameBallLaunchHeights) ; $4882
	sub l ; $4884
	ld h, a ; $4885
	ld a, [hl+] ; $4886
	ld b, [hl] ; $4887
	ld c, a ; $4888
	ld hl, wCharPosDepth + 1 ; $4889
	ld a, [hl+] ; $488c
	ld d, [hl] ; $488d
	ld e, a ; $488e
	ld hl, wCharPosX + 1 ; $488f
	ld a, [hl+] ; $4892
	ld h, [hl] ; $4893
	ld l, a ; $4894
	farcall SetBallPosition ; $4895
	farcall AdvanceMatchRng ; $4898
	and $07 ; $489b
	add LOW(MinigameShotSpinPool) ; $489d
	ld l, a ; $489f
	adc HIGH(MinigameShotSpinPool) ; $48a0
	sub l ; $48a2
	ld h, a ; $48a3
	ld a, [hl] ; $48a4
	ld [wCharAimOffset], a ; $48a5
	ld hl, $073c ; $48a8
	call FarCallVector ; $48ab
	sound $76 ; $48ae
	pop af ; $48b0
	wram_bank ; $48b1
	ret ; $48b5
ApplyMinigameCharTargetFromTable:
	ldh a, [hWramBank] ; $48b6
	push af ; $48b8
	wram_bank $05 ; $48b9
	ld a, [wMinigameServeSlot] ; $48bf
	call GetMinigameCharCoordsEntry ; $48c2
	farcall SetCharTarget ; $48c5
	pop af ; $48c8
	wram_bank ; $48c9
	ret ; $48cd
PlayMinigameCountdown:
	wram_bank $04 ; $48ce
	xor a ; $48d4
	ld [wPauseDisabled], a ; $48d5
	ld a, [wCurrentBGM] ; $48d8
	push af ; $48db
	sound BGM_NONE ; $48dc
	ld a, $14 ; $48de
	farcall StepMatchFrames ; $48e0
	ld a, $03 ; $48e3
.loop:
	push af ; $48e5
	ld b, $01 ; $48e6
	ld de, $8200 ; $48e8
	farcall LoadScoreDigitGfx ; $48eb
	ld a, [wMatchFramesAbort] ; $48ee
	and a ; $48f1
	jr nz, .nonZero ; $48f2
	sound SFX_COUNTDOWN ; $48f4
.nonZero:
	ld a, $11 ; $48f6
	farcall SpawnCourtBannerObj ; $48f8
	ld a, $28 ; $48fb
	farcall StepMatchFrames ; $48fd
	pop af ; $4900
	dec a ; $4901
	jr nz, .loop ; $4902
	ld a, [wMatchFramesAbort] ; $4904
	and a ; $4907
	jr nz, .nonZero2 ; $4908
	sound SFX_COUNTDOWN_GO ; $490a
.nonZero2:
	ld a, $10 ; $490c
	farcall ShowCourtBanner ; $490e
	ld a, $28 ; $4911
	farcall StepMatchFrames ; $4913
	farcall HideCourtBanner ; $4916
	pop af ; $4919
	ld b, a ; $491a
	ld a, [wMatchFramesAbort] ; $491b
	and a ; $491e
	jr nz, .done ; $491f
	ld a, b ; $4921
	call PlaySoundManaged ; $4922
.done:
	ret ; $4925
GetMinigameCharCoordsEntry:
	add a ; $4926
	add a ; $4927
	add LOW(MinigameCharCoordsTable) ; $4928
	ld l, a ; $492a
	adc HIGH(MinigameCharCoordsTable) ; $492b
	sub l ; $492d
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
SnapCameraTo_0d:
	ld c, l ; $493a
	ld b, h ; $493b
	ld hl, wMatchCameraX ; $493c
	ld a, c ; $493f
	ld [hl+], a ; $4940
	ld [hl], b ; $4941
	ld hl, wMatchCameraTargetX ; $4942
	ld a, c ; $4945
	ld [hl+], a ; $4946
	ld [hl], b ; $4947
	ld hl, wMatchCameraY ; $4948
	ld a, e ; $494b
	ld [hl+], a ; $494c
	ld [hl], d ; $494d
	ld hl, wMatchCameraTargetY ; $494e
	ld a, e ; $4951
	ld [hl+], a ; $4952
	ld [hl], d ; $4953
	xor a ; $4954
	ld [wCameraFollowBall], a ; $4955
	ret ; $4958
MinigameConfig_TennisMachine2:
	; $4959, 16 bytes (bytes:16)
	db $15, $0a, $02, $06, $13, $1e, $00, $80, $74, $49, $bd, $40, $69, $49, $00, $00 ; 0x00
InitMinigame_TennisMachine2:
	ld a, $01 ; $4969
	ld [wMinigameUsesTennisMachine], a ; $496b
	ld a, $01 ; $496e
	ld [wMinigameLevel], a ; $4970
	ret ; $4973
MinigameHooks_TennisMachine2:
	; $4974, 16 bytes (mode_hooks)
	dw TennisMachine2Hook_PerFrame ; record 0
	dw TennisMachine2Hook_PointStart ; record 1
	dw TennisMachine2Hook_PointEnd ; record 2
	dw TennisMachine2Hook_MinigameStart ; record 3
	dw TennisMachine2Hook_BallHit ; record 4
	dw TennisMachine2Hook_Bounce ; record 5
	dw TennisMachine2Hook_RallyTick ; record 6
	dw RetStub ; record 7
TennisMachine2Hook_MinigameStart:
	ld a, $01 ; $4984
	ld [wMinigameServeSlot], a ; $4986
	call StartMinigameMatch ; $4989
	ret ; $498c
TennisMachine2Hook_PerFrame:
	call DrawMinigameScoreHud ; $498d
	ret ; $4990
TennisMachine2Hook_PointStart:
	farcall AdvanceMatchRng ; $4991
	and $01 ; $4994
	inc a ; $4996
	ld hl, wMinigameServeSlot ; $4997
	add [hl] ; $499a
	cp $03 ; $499b
	jr c, .store ; $499d
	sub $03 ; $499f
.store:
	ld [hl], a ; $49a1
	call LaunchMinigameServe ; $49a2
	ret ; $49a5
TennisMachine2Hook_PointEnd:
	call AwardMinigamePointAndEnd ; $49a6
	ret ; $49a9
TennisMachine2Hook_RallyTick:
	call KeepMinigameCameraFixed ; $49aa
	ret ; $49ad
TennisMachine2Hook_Bounce:
	call CheckMinigameStartBannerTrigger ; $49ae
	ret ; $49b1
TennisMachine2Hook_BallHit:
	call FreezeMinigameOpponentOnReturn ; $49b2
	ret ; $49b5
MinigameConfig_TennisMachine3:
	dec d ; $49b6
	ld a, [bc] ; $49b7
	ld [bc], a ; $49b8
	ld b, $14 ; $49b9
	ld e, $00 ; $49bb
	add b ; $49bd
	pop de ; $49be
	ld c, c ; $49bf
	cp l ; $49c0
	ld b, b ; $49c1
	add $49 ; $49c2
	nop ; $49c4
	nop ; $49c5
InitMinigame_TennisMachine3:
	ld a, $01 ; $49c6
	ld [wMinigameUsesTennisMachine], a ; $49c8
	ld a, $02 ; $49cb
	ld [wMinigameLevel], a ; $49cd
	ret ; $49d0
MinigameHooks_TennisMachine3:
	; $49d1, 16 bytes (mode_hooks)
	dw TennisMachine3Hook_PerFrame ; record 0
	dw TennisMachine3Hook_PointStart ; record 1
	dw TennisMachine3Hook_PointEnd ; record 2
	dw TennisMachine3Hook_MinigameStart ; record 3
	dw TennisMachine3Hook_BallHit ; record 4
	dw TennisMachine3Hook_Bounce ; record 5
	dw TennisMachine3Hook_RallyTick ; record 6
	dw RetStub ; record 7
TennisMachine3Hook_MinigameStart:
	ld a, $04 ; $49e1
	ld [wMinigameServeSlot], a ; $49e3
	call StartMinigameMatch ; $49e6
	ret ; $49e9
TennisMachine3Hook_PerFrame:
	call DrawMinigameScoreHud ; $49ea
	ret ; $49ed
TennisMachine3Hook_PointStart:
	farcall AdvanceMatchRng ; $49ee
	and $03 ; $49f1
	inc a ; $49f3
	ld hl, wMinigameServeSlot ; $49f4
	add [hl] ; $49f7
	cp $06 ; $49f8
	jr c, .store ; $49fa
	sub $06 ; $49fc
.store:
	ld [hl], a ; $49fe
	call LaunchMinigameServe ; $49ff
	ret ; $4a02
TennisMachine3Hook_PointEnd:
	call AwardMinigamePointAndEnd ; $4a03
	ret ; $4a06
TennisMachine3Hook_RallyTick:
	call KeepMinigameCameraFixed ; $4a07
	ret ; $4a0a
TennisMachine3Hook_Bounce:
	call CheckMinigameStartBannerTrigger ; $4a0b
	ret ; $4a0e
TennisMachine3Hook_BallHit:
	call FreezeMinigameOpponentOnReturn ; $4a0f
	ret ; $4a12
MinigameConfig_TennisMachine4:
	dec d ; $4a13
	ld a, [bc] ; $4a14
	ld [bc], a ; $4a15
	ld b, $15 ; $4a16
	ld e, $00 ; $4a18
	add b ; $4a1a
	ld l, $4a ; $4a1b
	cp l ; $4a1d
	ld b, b ; $4a1e
	inc hl ; $4a1f
	ld c, d ; $4a20
	nop ; $4a21
	nop ; $4a22
InitMinigame_TennisMachine4:
	ld a, $01 ; $4a23
	ld [wMinigameUsesTennisMachine], a ; $4a25
	ld a, $03 ; $4a28
	ld [wMinigameLevel], a ; $4a2a
	ret ; $4a2d
MinigameHooks_TennisMachine4:
	; $4a2e, 16 bytes (mode_hooks)
	dw TennisMachine4Hook_PerFrame ; record 0
	dw TennisMachine4Hook_PointStart ; record 1
	dw TennisMachine4Hook_PointEnd ; record 2
	dw TennisMachine4Hook_MinigameStart ; record 3
	dw TennisMachine4Hook_BallHit ; record 4
	dw TennisMachine4Hook_Bounce ; record 5
	dw TennisMachine4Hook_RallyTick ; record 6
	dw RetStub ; record 7
TennisMachine4Hook_MinigameStart:
	ld a, $04 ; $4a3e
	ld [wMinigameServeSlot], a ; $4a40
	call StartMinigameMatch ; $4a43
	ret ; $4a46
TennisMachine4Hook_PerFrame:
	call DrawMinigameScoreHud ; $4a47
	ret ; $4a4a
TennisMachine4Hook_PointStart:
	farcall AdvanceMatchRng ; $4a4b
	and $07 ; $4a4e
	inc a ; $4a50
	ld hl, wMinigameServeSlot ; $4a51
	add [hl] ; $4a54
	cp $09 ; $4a55
	jr c, .store ; $4a57
	sub $09 ; $4a59
.store:
	ld [hl], a ; $4a5b
	call LaunchMinigameServe ; $4a5c
	ret ; $4a5f
TennisMachine4Hook_PointEnd:
	call AwardMinigamePointAndEnd ; $4a60
	ret ; $4a63
TennisMachine4Hook_RallyTick:
	call KeepMinigameCameraFixed ; $4a64
	ret ; $4a67
TennisMachine4Hook_Bounce:
	call CheckMinigameStartBannerTrigger ; $4a68
	ret ; $4a6b
TennisMachine4Hook_BallHit:
	call FreezeMinigameOpponentOnReturn ; $4a6c
	ret ; $4a6f
MinigameConfig_WallPractice1:
	nop ; $4a70
	dec bc ; $4a71
	ld bc, $1607 ; $4a72
	rra ; $4a75
	nop ; $4a76
	add b ; $4a77
	sub e ; $4a78
	ld c, d ; $4a79
	or h ; $4a7a
	ld b, b ; $4a7b
	add b ; $4a7c
	ld c, d ; $4a7d
	nop ; $4a7e
	nop ; $4a7f
InitMinigame_WallPractice1:
	ld a, $01 ; $4a80
	ld [wMinigameUsesWall], a ; $4a82
	ld a, $00 ; $4a85
	ld [wMinigameLevel], a ; $4a87
	farcall InitMinigameTargets ; $4a8a
	ld a, $00 ; $4a8d
	farcall SpawnMinigameTargetFormation ; $4a8f
	ret ; $4a92
MinigameHooks_WallPractice1:
	; $4a93, 16 bytes (mode_hooks)
	dw WallPractice1Hook_PerFrame ; record 0
	dw WallPractice1Hook_PointStart ; record 1
	dw WallPractice1Hook_PointEnd ; record 2
	dw RetStub ; record 3
	dw WallPractice1Hook_BallHit ; record 4
	dw WallPractice1Hook_Bounce ; record 5
	dw WallPractice1Hook_RallyTick ; record 6
	dw RetStub ; record 7
WallPractice1Hook_PerFrame:
	call UpdateMinigameHudAndBallTrail ; $4aa3
	ret ; $4aa6
WallPractice1Hook_PointStart:
	call StartMinigameSoloPoint ; $4aa7
	ret ; $4aaa
WallPractice1Hook_PointEnd:
	call HandleMinigamePointEnd ; $4aab
	ret ; $4aae
WallPractice1Hook_RallyTick:
	call AwardMinigamePointAndReflectBall ; $4aaf
	ret ; $4ab2
WallPractice1Hook_Bounce:
	call StubNop_0d_0 ; $4ab3
	ret ; $4ab6
WallPractice1Hook_BallHit:
	call HideLandingMarkerAndExtendSoloCourt ; $4ab7
	ret ; $4aba
UpdateMinigameHudAndBallTrail:
	ld a, [wPointWinLoseFlag] ; $4abb
	and a ; $4abe
	jr nz, .trail ; $4abf
	ld de, $8484 ; $4ac1
	call DrawMinigameScore ; $4ac4
.trail:
	ldh a, [hWramBank] ; $4ac7
	push af ; $4ac9
	wram_bank $04 ; $4aca
	ld hl, wBallHistory + 12 ; $4ad0
	ld de, wBallTrailSlots + 8 ; $4ad3
	call MarkMinigameObjectOffscreen ; $4ad6
	ld hl, wBallHistory + 6 ; $4ad9
	ld de, wBallTrailSlots + 12 ; $4adc
	call MarkMinigameObjectOffscreen ; $4adf
	ld hl, wBallHistory ; $4ae2
	ld de, wBallTrailSlots + 16 ; $4ae5
	call MarkMinigameObjectOffscreen ; $4ae8
	pop af ; $4aeb
	wram_bank ; $4aec
	ret ; $4af0
MarkMinigameObjectOffscreen:
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
StartMinigameSoloPoint:
	call InitMinigameScore ; $4b01
	xor a ; $4b04
	ld [wStandingShadowsEnabled], a ; $4b05
	ld de, $0000 ; $4b08
	ld hl, wNetHeight ; $4b0b
	ld a, e ; $4b0e
	ld [hl+], a ; $4b0f
	ld [hl], d ; $4b10
	ldh a, [hWramBank] ; $4b11
	push af ; $4b13
	wram_bank $04 ; $4b14
	ld hl, $0000 ; $4b1a
	ld de, $04e0 ; $4b1d
	farcall SetCharPosAndTarget ; $4b20
	pop af ; $4b23
	wram_bank ; $4b24
	ret ; $4b28
HandleMinigamePointEnd:
	ldh a, [hWramBank] ; $4b29
	push af ; $4b2b
	wram_bank $04 ; $4b2c
	ld a, $05 ; $4b32
	farcall SetCharState ; $4b34
	pop af ; $4b37
	wram_bank ; $4b38
	call ShowPointOutcomeBanner ; $4b3c
	call DetermineMinigamePointResult ; $4b3f
	push de ; $4b42
	ldh a, [hWramBank] ; $4b43
	push af ; $4b45
	wram_bank $04 ; $4b46
	farcall CharPointEndReaction ; $4b4c
	pop af ; $4b4f
	wram_bank ; $4b50
	pop de ; $4b54
	call ShowMinigamePointResult ; $4b55
	ret ; $4b58
AwardMinigamePointAndReflectBall:
	ld a, [wPointOutcome] ; $4b59
	and a ; $4b5c
	jr nz, ReflectBallVelocity ; $4b5d
	ld de, $0001 ; $4b5f
	call AddToMinigameScore ; $4b62
	call IsMinigameTargetReached ; $4b65
	and a ; $4b68
	jr z, ReflectBallVelocity ; $4b69
	ld a, $0b ; $4b6b
	ld [wPointOutcome], a ; $4b6d
ReflectBallVelocity:
	ld a, $01 ; $4b70
	ld [wCameraFollowBall], a ; $4b72
	farcall StartBounceEffect ; $4b75
	xor a ; $4b78
	ld [wBallBounceCount], a ; $4b79
	ld hl, wBallQuadrantAtHit ; $4b7c
	ld a, [hl] ; $4b7f
	xor $02 ; $4b80
	ld [hl], a ; $4b82
	ld hl, wBallDepthFrac ; $4b83
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
	ld hl, wBallVelocityDepthFrac ; $4b92
	ld a, [hl] ; $4b95
	cpl ; $4b96
	ld [hl+], a ; $4b97
	ld a, [hl] ; $4b98
	cpl ; $4b99
	ld [hl+], a ; $4b9a
	ld a, [hl] ; $4b9b
	cpl ; $4b9c
	ld [hl+], a ; $4b9d
	ld hl, wBallVelocityDepthFrac ; $4b9e
	ld b, $e6 ; $4ba1
	farcall MulMem24ByFrac ; $4ba3
	ld hl, wBallVelocityDepthFrac ; $4ba6
	ld [hl+], a ; $4ba9
	ld a, e ; $4baa
	ld [hl+], a ; $4bab
	ld a, d ; $4bac
	ld [hl+], a ; $4bad
	ld a, [wPointOutcome] ; $4bae
	and a ; $4bb1
	ret nz ; $4bb2
	ldh a, [hWramBank] ; $4bb3
	push af ; $4bb5
	wram_bank $04 ; $4bb6
	ld a, $01 ; $4bbc
	farcall SetCharState ; $4bbe
	pop af ; $4bc1
	wram_bank ; $4bc2
	ret ; $4bc6
StubNop_0d_0:
	ret ; $4bc7
HideLandingMarkerAndExtendSoloCourt:
	xor a ; $4bc8
	ld [wLandingMarkerActive], a ; $4bc9
	ld a, [wRallyLength] ; $4bcc
	cp $01 ; $4bcf
	ret nz ; $4bd1
	ld de, $fb20 ; $4bd2
	ld hl, wCourtLimitDepth ; $4bd5
	ld a, e ; $4bd8
	ld [hl+], a ; $4bd9
	ld [hl], d ; $4bda
	ld de, $fe50 ; $4bdb
	ld hl, wCourtLimitX ; $4bde
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
	farcall DrawNumberWithSprites ; $4bf4
	ret ; $4bf7
MinigameConfig_WallPractice2:
	; $4bf8, 16 bytes (bytes:16)
	db $00, $0b, $01, $07, $17, $1f, $00, $80, $1b, $4c, $b4, $40, $08, $4c, $00, $00 ; 0x00
InitMinigame_WallPractice2:
	ld a, $01 ; $4c08
	ld [wMinigameUsesWall], a ; $4c0a
	ld a, $01 ; $4c0d
	ld [wMinigameLevel], a ; $4c0f
	farcall InitMinigameTargets ; $4c12
	ld a, $01 ; $4c15
	farcall SpawnMinigameTargetFormation ; $4c17
	ret ; $4c1a
MinigameHooks_WallPractice2:
	; $4c1b, 16 bytes (mode_hooks)
	dw WallPractice2Hook_PerFrame ; record 0
	dw WallPractice2Hook_PointStart ; record 1
	dw WallPractice2Hook_PointEnd ; record 2
	dw RetStub ; record 3
	dw WallPractice2Hook_BallHit ; record 4
	dw WallPractice2Hook_Bounce ; record 5
	dw WallPractice2Hook_RallyTick ; record 6
	dw RetStub ; record 7
WallPractice2Hook_PerFrame:
	call UpdateMinigameHudAndBallTrail ; $4c2b
	ret ; $4c2e
WallPractice2Hook_PointStart:
	call StartMinigameSoloPoint ; $4c2f
	ret ; $4c32
WallPractice2Hook_PointEnd:
	call HandleMinigamePointEnd ; $4c33
	ret ; $4c36
WallPractice2Hook_RallyTick:
	call AwardMinigamePointAndReflectBall ; $4c37
	ret ; $4c3a
WallPractice2Hook_Bounce:
	call StubNop_0d_0 ; $4c3b
	ret ; $4c3e
WallPractice2Hook_BallHit:
	call HideLandingMarkerAndExtendSoloCourt ; $4c3f
	ret ; $4c42
MinigameConfig_WallPractice3:
	nop ; $4c43
	dec bc ; $4c44
	ld bc, $1807 ; $4c45
	rra ; $4c48
	nop ; $4c49
	add b ; $4c4a
	ld h, [hl] ; $4c4b
	ld c, h ; $4c4c
	or h ; $4c4d
	ld b, b ; $4c4e
	ld d, e ; $4c4f
	ld c, h ; $4c50
	nop ; $4c51
	nop ; $4c52
InitMinigame_WallPractice3:
	ld a, $01 ; $4c53
	ld [wMinigameUsesWall], a ; $4c55
	ld a, $02 ; $4c58
	ld [wMinigameLevel], a ; $4c5a
	farcall InitMinigameTargets ; $4c5d
	ld a, $02 ; $4c60
	farcall SpawnMinigameTargetFormation ; $4c62
	ret ; $4c65
MinigameHooks_WallPractice3:
	; $4c66, 16 bytes (mode_hooks)
	dw WallPractice3Hook_PerFrame ; record 0
	dw WallPractice3Hook_PointStart ; record 1
	dw WallPractice3Hook_PointEnd ; record 2
	dw RetStub ; record 3
	dw WallPractice3Hook_BallHit ; record 4
	dw WallPractice3Hook_Bounce ; record 5
	dw WallPractice3Hook_RallyTick ; record 6
	dw RetStub ; record 7
WallPractice3Hook_PerFrame:
	call UpdateMinigameHudAndBallTrail ; $4c76
	ret ; $4c79
WallPractice3Hook_PointStart:
	call StartMinigameSoloPoint ; $4c7a
	ret ; $4c7d
WallPractice3Hook_PointEnd:
	call HandleMinigamePointEnd ; $4c7e
	ret ; $4c81
WallPractice3Hook_RallyTick:
	call AwardMinigamePointAndReflectBall ; $4c82
	ret ; $4c85
WallPractice3Hook_Bounce:
	call StubNop_0d_0 ; $4c86
	ret ; $4c89
WallPractice3Hook_BallHit:
	call HideLandingMarkerAndExtendSoloCourt ; $4c8a
	ret ; $4c8d
MinigameConfig_WallPractice4:
	nop ; $4c8e
	dec bc ; $4c8f
	ld bc, $1907 ; $4c90
	rra ; $4c93
	nop ; $4c94
	add b ; $4c95
	or c ; $4c96
	ld c, h ; $4c97
	or h ; $4c98
	ld b, b ; $4c99
	sbc [hl] ; $4c9a
	ld c, h ; $4c9b
	nop ; $4c9c
	nop ; $4c9d
InitMinigame_WallPractice4:
	ld a, $01 ; $4c9e
	ld [wMinigameUsesWall], a ; $4ca0
	ld a, $03 ; $4ca3
	ld [wMinigameLevel], a ; $4ca5
	farcall InitMinigameTargets ; $4ca8
	ld a, $03 ; $4cab
	farcall SpawnMinigameTargetFormation ; $4cad
	ret ; $4cb0
MinigameHooks_WallPractice4:
	; $4cb1, 16 bytes (mode_hooks)
	dw WallPractice4Hook_PerFrame ; record 0
	dw WallPractice4Hook_PointStart ; record 1
	dw WallPractice4Hook_PointEnd ; record 2
	dw RetStub ; record 3
	dw WallPractice4Hook_BallHit ; record 4
	dw WallPractice4Hook_Bounce ; record 5
	dw WallPractice4Hook_RallyTick ; record 6
	dw RetStub ; record 7
WallPractice4Hook_PerFrame:
	call UpdateMinigameHudAndBallTrail ; $4cc1
	ret ; $4cc4
WallPractice4Hook_PointStart:
	call StartMinigameSoloPoint ; $4cc5
	ret ; $4cc8
WallPractice4Hook_PointEnd:
	call HandleMinigamePointEnd ; $4cc9
	ret ; $4ccc
WallPractice4Hook_RallyTick:
	call AwardMinigamePointAndReflectBall ; $4ccd
	ret ; $4cd0
WallPractice4Hook_Bounce:
	call StubNop_0d_0 ; $4cd1
	ret ; $4cd4
WallPractice4Hook_BallHit:
	call HideLandingMarkerAndExtendSoloCourt ; $4cd5
	ret ; $4cd8
MinigameConfig_TennisMachineHighScore:
	; $4cd9, 16 bytes (bytes:16)
	db $15, $0a, $02, $06, $1a, $1e, $00, $80, $f9, $4c, $bd, $40, $e9, $4c, $00, $00 ; 0x00
InitMinigame_TennisMachineHighScore:
	ld a, $01 ; $4ce9
	ld [wMinigameUsesTennisMachine], a ; $4ceb
	ld a, $01 ; $4cee
	ld [wMinigameHighScoreMode], a ; $4cf0
	ld a, $04 ; $4cf3
	ld [wMinigameLevel], a ; $4cf5
	ret ; $4cf8
MinigameHooks_TennisMachineHighScore:
	; $4cf9, 16 bytes (mode_hooks)
	dw TennisMachineHighScoreHook_PerFrame ; record 0
	dw TennisMachineHighScoreHook_PointStart ; record 1
	dw TennisMachineHighScoreHook_PointEnd ; record 2
	dw TennisMachineHighScoreHook_MinigameStart ; record 3
	dw TennisMachineHighScoreHook_BallHit ; record 4
	dw TennisMachineHighScoreHook_Bounce ; record 5
	dw TennisMachineHighScoreHook_RallyTick ; record 6
	dw RetStub ; record 7
TennisMachineHighScoreHook_MinigameStart:
	ld a, $04 ; $4d09
	ld [wMinigameServeSlot], a ; $4d0b
	call StartMinigameMatch ; $4d0e
	ret ; $4d11
TennisMachineHighScoreHook_PerFrame:
	call DrawMinigameScoreHud ; $4d12
	ret ; $4d15
TennisMachineHighScoreHook_PointStart:
	farcall AdvanceMatchRng ; $4d16
	and $07 ; $4d19
	inc a ; $4d1b
	ld hl, wMinigameServeSlot ; $4d1c
	add [hl] ; $4d1f
	cp $09 ; $4d20
	jr c, .store ; $4d22
	sub $09 ; $4d24
.store:
	ld [hl], a ; $4d26
	call LaunchMinigameServe ; $4d27
	ret ; $4d2a
TennisMachineHighScoreHook_PointEnd:
	call AwardMinigamePointAndEnd ; $4d2b
	ret ; $4d2e
TennisMachineHighScoreHook_RallyTick:
	call KeepMinigameCameraFixed ; $4d2f
	ret ; $4d32
TennisMachineHighScoreHook_Bounce:
	call CheckMinigameStartBannerTrigger ; $4d33
	ret ; $4d36
TennisMachineHighScoreHook_BallHit:
	call FreezeMinigameOpponentOnReturn ; $4d37
	ret ; $4d3a
MinigameConfig_WallPracticeHighScore:
	nop ; $4d3b
	dec bc ; $4d3c
	ld bc, $1b07 ; $4d3d
	rra ; $4d40
	nop ; $4d41
	add b ; $4d42
	ld h, e ; $4d43
	ld c, l ; $4d44
	or h ; $4d45
	ld b, b ; $4d46
	ld c, e ; $4d47
	ld c, l ; $4d48
	nop ; $4d49
	nop ; $4d4a
InitMinigame_WallPracticeHighScore:
	ld a, $01 ; $4d4b
	ld [wMinigameHighScoreMode], a ; $4d4d
	ld a, $01 ; $4d50
	ld [wMinigameUsesWall], a ; $4d52
	ld a, $04 ; $4d55
	ld [wMinigameLevel], a ; $4d57
	farcall InitMinigameTargets ; $4d5a
	ld a, $04 ; $4d5d
	farcall SpawnMinigameTargetFormation ; $4d5f
	ret ; $4d62
MinigameHooks_WallPracticeHighScore:
	; $4d63, 16 bytes (mode_hooks)
	dw WallPracticeHighScoreHook_PerFrame ; record 0
	dw WallPracticeHighScoreHook_PointStart ; record 1
	dw WallPracticeHighScoreHook_PointEnd ; record 2
	dw RetStub ; record 3
	dw WallPracticeHighScoreHook_BallHit ; record 4
	dw WallPracticeHighScoreHook_Bounce ; record 5
	dw WallPracticeHighScoreHook_RallyTick ; record 6
	dw RetStub ; record 7
WallPracticeHighScoreHook_PerFrame:
	call UpdateMinigameHudAndBallTrail ; $4d73
	ret ; $4d76
WallPracticeHighScoreHook_PointStart:
	call StartMinigameSoloPoint ; $4d77
	ret ; $4d7a
WallPracticeHighScoreHook_PointEnd:
	call HandleMinigamePointEnd ; $4d7b
	ret ; $4d7e
WallPracticeHighScoreHook_RallyTick:
	call AwardMinigamePointAndReflectBall ; $4d7f
	ret ; $4d82
WallPracticeHighScoreHook_Bounce:
	call StubNop_0d_0 ; $4d83
	ret ; $4d86
WallPracticeHighScoreHook_BallHit:
	call HideLandingMarkerAndExtendSoloCourt ; $4d87
	ret ; $4d8a
MinigameConfig_TargetShot:
	dec d ; $4d8b
	rrca ; $4d8c
	ld [bc], a ; $4d8d
	ld [$191f], sp ; $4d8e
	nop ; $4d91
	add hl, de ; $4d92
	xor l ; $4d93
	ld c, l ; $4d94
	cp l ; $4d95
	ld b, b ; $4d96
	sbc e ; $4d97
	ld c, l ; $4d98
	nop ; $4d99
	nop ; $4d9a
InitMinigame_TargetShot:
	ld a, $01 ; $4d9b
	ld [wMinigameUsesTennisMachine], a ; $4d9d
	ld a, [wMinigameLevel] ; $4da0
	cp $02 ; $4da3
	jr nz, .done ; $4da5
	ld a, $01 ; $4da7
	ld [wMinigameHighScoreMode], a ; $4da9
.done:
	ret ; $4dac
MinigameHooks_TargetShot:
	; $4dad, 16 bytes (mode_hooks)
	dw TargetShotHook_PerFrame ; record 0
	dw TargetShotHook_PointStart ; record 1
	dw TargetShotHook_PointEnd ; record 2
	dw TargetShotHook_MinigameStart ; record 3
	dw TargetShotHook_BallHit ; record 4
	dw TargetShotHook_Bounce ; record 5
	dw TargetShotHook_RallyTick ; record 6
	dw RetStub ; record 7
TargetShotHook_MinigameStart:
	ld a, $01 ; $4dbd
	ld [wMinigameServeSlot], a ; $4dbf
	call StartMinigameMatch ; $4dc2
	ld a, $01 ; $4dc5
	ld [wTargetZoneEnabled], a ; $4dc7
	ret ; $4dca
TargetShotHook_PerFrame:
	call DrawMinigameScoreHud ; $4dcb
	call UpdateTargetShotScorePopup ; $4dce
	ret ; $4dd1
TargetShotHook_PointStart:
	call SelectRandomMinigameShot ; $4dd2
	farcall AdvanceMatchRng ; $4dd5
	and $01 ; $4dd8
	inc a ; $4dda
	ld hl, wMinigameServeSlot ; $4ddb
	add [hl] ; $4dde
	cp $03 ; $4ddf
	jr c, .store ; $4de1
	sub $03 ; $4de3
.store:
	ld [hl], a ; $4de5
	call LaunchMinigameServe ; $4de6
	ret ; $4de9
TargetShotHook_PointEnd:
	call EndMinigamePoint ; $4dea
	ret ; $4ded
TargetShotHook_RallyTick:
	call KeepMinigameCameraFixed ; $4dee
	ret ; $4df1
TargetShotHook_Bounce:
	ld a, [wPointOutcome] ; $4df2
	and a ; $4df5
	ret nz ; $4df6
	call CheckMinigameStartBannerTrigger ; $4df7
	call CheckBallLandedOut ; $4dfa
	ld a, [wPointOutcome] ; $4dfd
	cp $06 ; $4e00
	ret nz ; $4e02
	call LookupMinigameShotResult ; $4e03
	ld d, $00 ; $4e06
	ld e, a ; $4e08
	ld hl, wScorePopupValue ; $4e09
	ld a, e ; $4e0c
	ld [hl+], a ; $4e0d
	ld [hl], d ; $4e0e
	call AddToMinigameScore ; $4e0f
	call StartScorePopup ; $4e12
	sound $97 ; $4e15
	ret ; $4e17
TargetShotHook_BallHit:
	call FreezeMinigameOpponentOnReturn ; $4e18
	ret ; $4e1b
UpdateTargetShotScorePopup:
	call UpdateScorePopup ; $4e1c
	ret ; $4e1f
SelectRandomMinigameShot:
	ldh a, [hWramBank] ; $4e20
	push af ; $4e22
	wram_bank $02 ; $4e23
	ld a, [wMinigameLevel] ; $4e29
	add a ; $4e2c
	add LOW(TargetShotZonePoolsByLevel) ; $4e2d
	ld l, a ; $4e2f
	adc HIGH(TargetShotZonePoolsByLevel) ; $4e30
	sub l ; $4e32
	ld h, a ; $4e33
	ld a, [hl+] ; $4e34
	ld h, [hl] ; $4e35
	ld l, a ; $4e36
	farcall AdvanceMatchRng ; $4e37
	and $0f ; $4e3a
	add l ; $4e3c
	ld l, a ; $4e3d
	jr nc, .read ; $4e3e
	inc h ; $4e40
.read:
	ld a, [hl] ; $4e41
	ld [wMinigameShotRoll], a ; $4e42
	ld a, [wMinigameShotRoll] ; $4e45
	call LoadTargetZoneConfig ; $4e48
	ld a, [wMinigameShotRoll] ; $4e4b
	call LoadMatchUiCourtTilemap ; $4e4e
	call QueueMinigameHudVRAMCopy ; $4e51
	pop af ; $4e54
	wram_bank ; $4e55
	ret ; $4e59
TargetShotZonePoolsByLevel:
	; $4e5a, 6 bytes (records:2)
	dw TargetShotZonePool0 ; record 0
	dw TargetShotZonePool1 ; record 1
	dw TargetShotZonePool1 ; record 2
TargetShotZonePool0:
	; $4e60, 16 bytes (bytes:16)
	db $00, $00, $00, $00, $01, $01, $01, $01, $05, $05, $05, $06, $06, $06, $04, $04 ; 0x00
TargetShotZonePool1:
	; $4e70, 16 bytes (bytes:16)
	db $00, $00, $00, $00, $01, $01, $01, $01, $02, $02, $02, $03, $03, $03, $04, $04 ; 0x00
CheckBallLandedOut:
	ld a, [wLastShotCharIndex] ; $4e80
	and $01 ; $4e83
	ret nz ; $4e85
	farcall IsBallInTargetZone ; $4e86
	and a ; $4e89
	ret nz ; $4e8a
	ld a, $05 ; $4e8b
	ld [wPointOutcome], a ; $4e8d
	ld a, $ff ; $4e90
	ld [wPointOutcomeSide], a ; $4e92
	ret ; $4e95
LookupMinigameShotResult:
	ld hl, TargetShotScoreRules ; $4e96
.loop:
	ld a, [hl+] ; $4e99
	cp $ff ; $4e9a
	jr z, .eqff2 ; $4e9c
	ld e, a ; $4e9e
	ld a, [hl+] ; $4e9f
	ld d, a ; $4ea0
	ld a, [hl+] ; $4ea1
	ld c, a ; $4ea2
	ld a, [hl+] ; $4ea3
	ld b, a ; $4ea4
	ld a, [wMinigameShotRoll] ; $4ea5
	cp e ; $4ea8
	jr nz, .loop ; $4ea9
	ld a, [wLastShotButtons] ; $4eab
	cp d ; $4eae
	jr nz, .loop ; $4eaf
	ld a, c ; $4eb1
	cp $ff ; $4eb2
	jr z, .eqff ; $4eb4
	ld a, [wCurrentShotType] ; $4eb6
	cp c ; $4eb9
	jr nz, .loop ; $4eba
.eqff:
	ld a, b ; $4ebc
	ret ; $4ebd
.eqff2:
	ld a, $01 ; $4ebe
	ret ; $4ec0
TargetShotScoreRules:
	; $4ec1, 69 bytes (bytes:4)
	db $00, $11, $01, $03 ; 0x00
	db $00, $11, $06, $03 ; 0x04
	db $00, $11, $ff, $03 ; 0x08
	db $01, $22, $03, $03 ; 0x0c
	db $01, $22, $07, $03 ; 0x10
	db $01, $22, $ff, $03 ; 0x14
	db $02, $21, $0b, $05 ; 0x18
	db $02, $21, $ff, $05 ; 0x1c
	db $03, $12, $0a, $05 ; 0x20
	db $03, $12, $ff, $05 ; 0x24
	db $04, $30, $09, $05 ; 0x28
	db $04, $30, $04, $03 ; 0x2c
	db $04, $30, $ff, $03 ; 0x30
	db $05, $21, $0b, $05 ; 0x34
	db $05, $21, $ff, $05 ; 0x38
	db $06, $12, $0a, $05 ; 0x3c
	db $06, $12, $ff, $05 ; 0x40
	db $ff ; 0x44
TargetShotZoneOverlayTiles:
	; $4f06, 250 bytes (bytes:10)
	db $14, $14, $14, $14, $14, $15, $14, $14, $14, $14 ; 0x00
	db $28, $29, $29, $28, $14, $14, $14, $14, $14, $14 ; 0x0a
	db $36, $37, $38, $36, $14, $14, $14, $14, $14, $14 ; 0x14
	db $45, $46, $47, $45, $42, $41, $42, $42, $42, $42 ; 0x1e
	db $51, $52, $52, $51, $00, $4d, $00, $00, $00, $00 ; 0x28
	db $14, $14, $14, $14, $14, $15, $14, $14, $14, $14 ; 0x32
	db $14, $14, $14, $14, $14, $14, $28, $29, $29, $28 ; 0x3c
	db $14, $14, $14, $14, $14, $14, $2a, $2b, $48, $49 ; 0x46
	db $42, $42, $42, $42, $42, $41, $39, $3a, $53, $54 ; 0x50
	db $00, $00, $00, $00, $00, $4d, $51, $52, $52, $51 ; 0x5a
	db $14, $14, $14, $14, $14, $15, $14, $14, $14, $14 ; 0x64
	db $14, $14, $14, $14, $14, $14, $14, $14, $14, $14 ; 0x6e
	db $14, $14, $14, $14, $14, $14, $14, $14, $14, $14 ; 0x78
	db $7e, $7f, $95, $96, $97, $98, $99, $9a, $7f, $7e ; 0x82
	db $8a, $8b, $a3, $a4, $a5, $a6, $a7, $a8, $8b, $8a ; 0x8c
	db $80, $81, $60, $61, $62, $63, $64, $65, $81, $80 ; 0x96
	db $28, $8c, $6f, $70, $71, $72, $73, $74, $8c, $28 ; 0xa0
	db $14, $14, $14, $14, $14, $14, $14, $14, $14, $14 ; 0xaa
	db $42, $42, $42, $42, $42, $41, $42, $42, $42, $42 ; 0xb4
	db $00, $00, $00, $00, $00, $4d, $00, $00, $00, $00 ; 0xbe
	db $14, $14, $14, $14, $14, $15, $14, $14, $14, $14 ; 0xc8
	db $14, $14, $af, $b0, $b1, $b1, $b0, $af, $14, $14 ; 0xd2
	db $80, $b7, $b8, $b9, $ba, $bb, $bc, $bd, $b7, $80 ; 0xdc
	db $8a, $c5, $c6, $c7, $c8, $c9, $ca, $cb, $c5, $8a ; 0xe6
	db $00, $00, $d4, $d5, $52, $52, $d5, $d4, $00, $00 ; 0xf0
TargetShotZoneOverlayAttrs:
	; $5000, 250 bytes (bytes:10)
	db $2f, $2f, $2f, $2f, $2f, $0f, $2f, $2f, $2f, $2f ; 0x00
	db $0e, $0e, $2e, $2e, $2f, $2f, $2f, $2f, $2f, $2f ; 0x0a
	db $0e, $0e, $0e, $2e, $2f, $2f, $2f, $2f, $2f, $2f ; 0x14
	db $0e, $0e, $0e, $2e, $0f, $0f, $0f, $0f, $0f, $0f ; 0x1e
	db $0e, $0e, $2e, $2e, $2f, $0f, $2f, $2f, $2f, $2f ; 0x28
	db $2f, $2f, $2f, $2f, $2f, $0f, $2f, $2f, $2f, $2f ; 0x32
	db $2f, $2f, $2f, $2f, $2f, $2f, $0e, $0e, $2e, $2e ; 0x3c
	db $2f, $2f, $2f, $2f, $2f, $2f, $0e, $0e, $0e, $0e ; 0x46
	db $0f, $0f, $0f, $0f, $0f, $0f, $0e, $0e, $0e, $0e ; 0x50
	db $2f, $2f, $2f, $2f, $2f, $0f, $0e, $0e, $2e, $2e ; 0x5a
	db $2f, $2f, $2f, $2f, $2f, $0f, $2f, $2f, $2f, $2f ; 0x64
	db $2f, $2f, $2f, $2f, $2f, $2f, $2f, $2f, $2f, $2f ; 0x6e
	db $2f, $2f, $2f, $2f, $2f, $2f, $2f, $2f, $2f, $2f ; 0x78
	db $0e, $0e, $0e, $0e, $0e, $0e, $0e, $0e, $2e, $2e ; 0x82
	db $0e, $0e, $0e, $0e, $0e, $0e, $0e, $0e, $2e, $2e ; 0x8c
	db $0e, $0e, $0e, $0e, $0e, $0e, $0e, $0e, $2e, $2e ; 0x96
	db $4e, $0e, $0e, $0e, $0e, $0e, $0e, $0e, $2e, $6e ; 0xa0
	db $2f, $2f, $2f, $2f, $2f, $2f, $2f, $2f, $2f, $2f ; 0xaa
	db $0f, $0f, $0f, $0f, $0f, $0f, $0f, $0f, $0f, $0f ; 0xb4
	db $2f, $2f, $2f, $2f, $2f, $0f, $2f, $2f, $2f, $2f ; 0xbe
	db $2f, $2f, $2f, $2f, $2f, $0f, $2f, $2f, $2f, $2f ; 0xc8
	db $2f, $2f, $0e, $0e, $0e, $2e, $2e, $2e, $2f, $2f ; 0xd2
	db $0e, $0e, $0e, $0e, $0e, $0e, $0e, $0e, $2e, $2e ; 0xdc
	db $0e, $0e, $0e, $0e, $0e, $0e, $0e, $0e, $2e, $2e ; 0xe6
	db $2f, $2f, $0e, $0e, $0e, $2e, $2e, $2e, $2f, $0f ; 0xf0
LoadMatchUiCourtTilemap:
	add a ; $50fa
	add LOW(TargetShotZoneOverlayOffsets) ; $50fb
	ld l, a ; $50fd
	adc HIGH(TargetShotZoneOverlayOffsets) ; $50fe
	sub l ; $5100
	ld h, a ; $5101
	ld a, [hl+] ; $5102
	ld b, [hl] ; $5103
	ld c, a ; $5104
	ld hl, TargetShotZoneOverlayAttrs ; $5105
	add hl, bc ; $5108
	push hl ; $5109
	push hl ; $510a
	ld hl, TargetShotZoneOverlayTiles ; $510b
	add hl, bc ; $510e
	push hl ; $510f
	push hl ; $5110
	pop hl ; $5111
	ld de, $d92b ; $5112
	ld bc, $0a05 ; $5115
	call CopyTextRect ; $5118
	pop hl ; $511b
	ld de, wScreenAttrmap + 9 * TILEMAP_WIDTH + 11 ; $511c
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
TargetShotZoneOverlayOffsets:
	; $513a, 14 bytes (records:2)
	dw $0000 ; record 0
	dw $0032 ; record 1
	dw $0064 ; record 2
	dw $0096 ; record 3
	dw $00c8 ; record 4
	dw $0064 ; record 5
	dw $0096 ; record 6
LoadTargetZoneConfig:
	add a ; $5148
	add a ; $5149
	add a ; $514a
	add $5c ; $514b
	ld l, a ; $514d
	adc $51 ; $514e
	sub l ; $5150
	ld h, a ; $5151
	ld de, wTargetZoneX1 ; $5152
	ld bc, $0008 ; $5155
	call CopyMemoryBC ; $5158
	ret ; $515b
MinigameTargetZoneBounds:
	; $515c, 56 bytes (bytes:8)
	db $50, $fe, $20, $fb, $00, $00, $00, $00 ; 0x00
	db $00, $00, $20, $fb, $b0, $01, $00, $00 ; 0x08
	db $50, $fe, $60, $fd, $b0, $01, $00, $00 ; 0x10
	db $50, $fe, $20, $fb, $b0, $01, $60, $fd ; 0x18
	db $50, $fe, $20, $fb, $b0, $01, $00, $00 ; 0x20
	db $50, $fe, $20, $fb, $b0, $01, $00, $00 ; 0x28
	db $50, $fe, $20, $fb, $b0, $01, $00, $00 ; 0x30
MinigameConfig_ShootingStar:
	; $5194, 16 bytes (bytes:16)
	db $15, $10, $02, $08, $1d, $19, $00, $17, $b6, $51, $bd, $40, $a4, $51, $00, $00 ; 0x00
InitMinigame_ShootingStar:
	ld a, $01 ; $51a4
	ld [wMinigameUsesTennisMachine], a ; $51a6
	ld a, [wMinigameLevel] ; $51a9
	cp $02 ; $51ac
	jr nz, .done ; $51ae
	ld a, $01 ; $51b0
	ld [wMinigameHighScoreMode], a ; $51b2
.done:
	ret ; $51b5
MinigameHooks_ShootingStar:
	; $51b6, 16 bytes (mode_hooks)
	dw ShootingStarHook_PerFrame ; record 0
	dw ShootingStarHook_PointStart ; record 1
	dw ShootingStarHook_PointEnd ; record 2
	dw ShootingStarHook_MinigameStart ; record 3
	dw ShootingStarHook_BallHit ; record 4
	dw ShootingStarHook_Bounce ; record 5
	dw ShootingStarHook_RallyTick ; record 6
	dw ShootingStarHook_Draw ; record 7
ShootingStarHook_MinigameStart:
	call InitBallTargetActor ; $51c6
	ld a, $01 ; $51c9
	ld [wMinigameServeSlot], a ; $51cb
	call StartMinigameMatch ; $51ce
	ret ; $51d1
ShootingStarHook_PerFrame:
	call DrawMinigameScoreHud ; $51d2
	call UpdateScorePopup ; $51d5
	ret ; $51d8
ShootingStarHook_Draw:
	call UpdateMinigameActors ; $51d9
	ret ; $51dc
ShootingStarHook_PointStart:
	call ResetTargetHitState ; $51dd
	farcall AdvanceMatchRng ; $51e0
	and $01 ; $51e3
	inc a ; $51e5
	ld hl, wMinigameServeSlot ; $51e6
	add [hl] ; $51e9
	cp $03 ; $51ea
	jr c, .store ; $51ec
	sub $03 ; $51ee
.store:
	ld [hl], a ; $51f0
	call LaunchMinigameServe ; $51f1
	ret ; $51f4
ShootingStarHook_PointEnd:
	call EndMinigamePoint ; $51f5
	ret ; $51f8
ShootingStarHook_RallyTick:
	call KeepMinigameCameraFixed ; $51f9
	ret ; $51fc
ShootingStarHook_Bounce:
	call CheckMinigameStartBannerTrigger ; $51fd
	ret ; $5200
ShootingStarHook_BallHit:
	call FreezeMinigameOpponentOnReturn ; $5201
	ret ; $5204
InitBallTargetActor:
	call ClearMinigameActors ; $5205
	ld de, ShootingStarTargetActorHandler ; $5208
	ld bc, wMinigameActors ; $520b
	call SetMinigameActorHandler ; $520e
	ld hl, $0000 ; $5211
	ld de, $fdc0 ; $5214
	ld bc, wMinigameActors ; $5217
	call SetMinigameActorPosition ; $521a
	ret ; $521d
ResetTargetHitState:
	ld a, [wMinigameHitScored] ; $521e
	and a ; $5221
	jr nz, .nonZero ; $5222
	xor a ; $5224
	ld [wMinigameHitStreak], a ; $5225
.nonZero:
	xor a ; $5228
	ld [wMinigameHitScored], a ; $5229
	xor a ; $522c
	ld [wMinigameActors + 2], a ; $522d
	ret ; $5230
ShootingStarTargetActorHandler:
	ld a, [wMinigameSceneActor + 2] ; $5231
	rst Rst00 ; $5234
	dw AdvanceTargetActorState.advanceMatchRng ; $5235 jumptable
	dw AdvanceTargetActorState.drawTargetReticleSprite ; $5237 jumptable
	dw AdvanceTargetActorState.drawTargetHitCountdown ; $5239 jumptable
	dw AdvanceTargetActorState.drawTargetReticleSprite2 ; $523b jumptable
	dw RetStub ; $523d jumptable
AdvanceTargetActorState:
	ld hl, wMinigameSceneActor + 2 ; $523f
	inc [hl] ; $5242
	ret ; $5243
.advanceMatchRng:
	ld a, [wMinigameSceneActor + 3] ; $5244
	and a ; $5247
	jr z, .zero ; $5248
	farcall AdvanceMatchRng ; $524a
	ld h, $00 ; $524d
	ld l, a ; $524f
	add hl, hl ; $5250
	ld de, $ff00 ; $5251
	add hl, de ; $5254
	ld de, $fdc0 ; $5255
	call SetMinigameActorWorldPos ; $5258
.zero:
	xor a ; $525b
	ld [wMinigameSceneActor + 3], a ; $525c
	call AdvanceTargetActorState ; $525f
.drawTargetReticleSprite:
	call DrawTargetReticleSprite ; $5262
	call IsBallInHitZone ; $5265
	and a ; $5268
	ret z ; $5269
	call AwardHitScore ; $526a
	jp AdvanceTargetActorState ; $526d
.drawTargetHitCountdown:
	call DrawTargetHitCountdown ; $5270
	ld hl, wMinigameSceneActor + 3 ; $5273
	dec [hl] ; $5276
	ld a, [hl] ; $5277
	and a ; $5278
	ret nz ; $5279
	farcall AdvanceMatchRng ; $527a
	ld h, $00 ; $527d
	ld l, a ; $527f
	add hl, hl ; $5280
	ld de, $ff00 ; $5281
	add hl, de ; $5284
	ld de, $fdc0 ; $5285
	call SetMinigameActorWorldPos ; $5288
	jp AdvanceTargetActorState ; $528b
.drawTargetReticleSprite2:
	call DrawTargetReticleSprite ; $528e
	ret ; $5291
IsBallInHitZone:
	ld a, [wLastShotCharIndex] ; $5292
	and $01 ; $5295
	jp nz, .returnZero ; $5297
	ld hl, wMinigameSceneActor + 6 ; $529a
	ld a, [hl+] ; $529d
	ld d, [hl] ; $529e
	ld e, a ; $529f
	ld hl, wBallX ; $52a0
	ld a, [hl+] ; $52a3
	ld h, [hl] ; $52a4
	ld l, a ; $52a5
	ld a, l ; $52a6
	sub e ; $52a7
	ld l, a ; $52a8
	ld a, h ; $52a9
	sbc d ; $52aa
	ld h, a ; $52ab
	bit 7, h ; $52ac
	jr z, .positive ; $52ae
	xor a ; $52b0
	sub l ; $52b1
	ld l, a ; $52b2
	sbc a ; $52b3
	sub h ; $52b4
	ld h, a ; $52b5
.positive:
	ld de, $ff80 ; $52b6
	add hl, de ; $52b9
	jr c, .returnZero ; $52ba
	ld hl, wMinigameSceneActor + 8 ; $52bc
	ld a, [hl+] ; $52bf
	ld d, [hl] ; $52c0
	ld e, a ; $52c1
	ld hl, wBallDepth ; $52c2
	ld a, [hl+] ; $52c5
	ld h, [hl] ; $52c6
	ld l, a ; $52c7
	ld a, l ; $52c8
	sub e ; $52c9
	ld l, a ; $52ca
	ld a, h ; $52cb
	sbc d ; $52cc
	ld h, a ; $52cd
	bit 7, h ; $52ce
	jr z, .positive2 ; $52d0
	xor a ; $52d2
	sub l ; $52d3
	ld l, a ; $52d4
	sbc a ; $52d5
	sub h ; $52d6
	ld h, a ; $52d7
.positive2:
	ld de, $ff00 ; $52d8
	add hl, de ; $52db
	jr c, .returnZero ; $52dc
	ld hl, wBallHeight ; $52de
	ld a, [hl+] ; $52e1
	ld h, [hl] ; $52e2
	ld l, a ; $52e3
	bit 7, h ; $52e4
	jr z, .positive3 ; $52e6
	xor a ; $52e8
	sub l ; $52e9
	ld l, a ; $52ea
	sbc a ; $52eb
	sub h ; $52ec
	ld h, a ; $52ed
.positive3:
	ld de, $ff40 ; $52ee
	add hl, de ; $52f1
	jr c, .returnZero ; $52f2
	ld a, $01 ; $52f4
	ret ; $52f6
.returnZero:
	xor a ; $52f7
	ret ; $52f8
AwardHitScore:
	ld a, $10 ; $52f9
	ld [wMinigameSceneActor + 3], a ; $52fb
	ld hl, $0001 ; $52fe
	ld a, [wCurrentShotType] ; $5301
	cp SHOTTYPE_SMASH ; $5304
	jr nz, .step ; $5306
	ld a, $20 ; $5308
	ld [wMinigameSceneActor + 3], a ; $530a
	ld hl, $0007 ; $530d
.step:
	ld a, $01 ; $5310
	ld [wMinigameHitScored], a ; $5312
	ld a, [wMinigameHitStreak] ; $5315
	add $4f ; $5318
	ld e, a ; $531a
	adc $53 ; $531b
	sub e ; $531d
	ld d, a ; $531e
	ld a, [de] ; $531f
	call PlaySoundManaged ; $5320
	ld a, [wMinigameHitStreak] ; $5323
	add $57 ; $5326
	ld e, a ; $5328
	adc $53 ; $5329
	sub e ; $532b
	ld d, a ; $532c
	ld a, [de] ; $532d
	call MulHLByA ; $532e
	ld e, l ; $5331
	ld d, h ; $5332
	ld hl, wScorePopupValue ; $5333
	ld a, e ; $5336
	ld [hl+], a ; $5337
	ld [hl], d ; $5338
	call AddToMinigameScore ; $5339
	call StartScorePopup ; $533c
	ld b, $07 ; $533f
	call IncrementCappedCounter ; $5341
	ld a, $06 ; $5344
	ld [wPointOutcome], a ; $5346
	ld a, $01 ; $5349
	ld [wPointOutcomeSide], a ; $534b
	ret ; $534e
MinigameHitStreakSounds:
	; $534f, 8 bytes (bytes:8)
	db $c0, $bf, $be, $bd, $bc, $bb, $ba, $ba ; 0x00
MinigameHitStreakMultipliers:
	; $5357, 8 bytes (bytes:8)
	db $01, $02, $04, $08, $10, $20, $40, $80 ; 0x00
DrawTargetReticleSprite:
	call ProjectMinigameWorldPosition ; $535f
	ld c, $30 ; $5362
	ld h, $fc ; $5364
	ld l, $f1 ; $5366
	call QueueSprite24x32 ; $5368
	ldh a, [hVBlankCounter] ; $536b
	and $1f ; $536d
	add LOW(TargetReticleAnimFrames) ; $536f
	ld l, a ; $5371
	adc HIGH(TargetReticleAnimFrames) ; $5372
	sub l ; $5374
	ld h, a ; $5375
	ld a, [hl] ; $5376
	cp $ff ; $5377
	ret z ; $5379
	farcall QueueMatchSpriteFrameA ; $537a
	ret ; $537d
TargetReticleAnimFrames:
	; $537e, 32 bytes (bytes:8)
	db $00, $ff, $ff, $ff, $ff, $ff, $ff, $ff ; 0x00
	db $01, $ff, $ff, $ff, $ff, $ff, $ff, $ff ; 0x08
	db $02, $ff, $ff, $ff, $ff, $ff, $ff, $ff ; 0x10
	db $01, $ff, $ff, $ff, $ff, $ff, $ff, $ff ; 0x18
DrawTargetHitCountdown:
	call ProjectMinigameWorldPosition ; $539e
	ld c, $3c ; $53a1
	ld a, [wMinigameSceneActor + 3] ; $53a3
	call QueueMinigameHitBurst ; $53a6
	ret ; $53a9
ProjectMinigameWorldPosition:
	ld hl, wMinigameSceneActor + 10 ; $53aa
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
	farcall ApplyCameraProjection ; $53b7
	ld a, [wMinigameHitStreak] ; $53ba
	add LOW(MinigameTargetSpriteOamAttrByHitStreak) ; $53bd
	ld l, a ; $53bf
	adc HIGH(MinigameTargetSpriteOamAttrByHitStreak) ; $53c0
	sub l ; $53c2
	ld h, a ; $53c3
	ld b, [hl] ; $53c4
	ret ; $53c5
MinigameTargetSpriteOamAttrByHitStreak:
	; $53c6, 8 bytes (bytes:8)
	db $0f, $0e, $0e, $0e, $0e, $0e, $0e, $0d ; 0x00
QueueMinigameHitBurst:
	call QueueMinigameHitBurstFirstFour ; $53ce
	call QueueMinigameHitBurstParticle ; $53d1
	call QueueMinigameHitBurstParticle ; $53d4
	ret ; $53d7
QueueMinigameHitBurstFirstFour:
	and $0f ; $53d8
	cpl ; $53da
	inc a ; $53db
	add $0f ; $53dc
	add $2c ; $53de
	ld l, a ; $53e0
	adc $54 ; $53e1
	sub l ; $53e3
	ld h, a ; $53e4
	ld a, e ; $53e5
	add $f8 ; $53e6
	ld e, a ; $53e8
	call QueueMinigameHitBurstParticle ; $53e9
	call QueueMinigameHitBurstParticle ; $53ec
	call QueueMinigameHitBurstParticle ; $53ef
	call QueueMinigameHitBurstParticle ; $53f2
	ret ; $53f5
QueueMinigameHitBurstFirstTwo:
	and $0f ; $53f6
	cpl ; $53f8
	inc a ; $53f9
	add $0f ; $53fa
	add $2c ; $53fc
	ld l, a ; $53fe
	adc $54 ; $53ff
	sub l ; $5401
	ld h, a ; $5402
	call QueueMinigameHitBurstParticle ; $5403
	call QueueMinigameHitBurstParticle ; $5406
	ret ; $5409
QueueMinigameHitBurstParticle:
	push de ; $540a
	ld a, [hl] ; $540b
	add a ; $540c
	add d ; $540d
	ld d, a ; $540e
	ld a, $10 ; $540f
	add l ; $5411
	ld l, a ; $5412
	jr nc, .readY ; $5413
	inc h ; $5415
.readY:
	ld a, [hl] ; $5416
	add a ; $5417
	add e ; $5418
	ld e, a ; $5419
	ld a, $10 ; $541a
	add l ; $541c
	ld l, a ; $541d
	jr nc, .queue ; $541e
	inc h ; $5420
.queue:
	push hl ; $5421
	call QueueSprite ; $5422
	pop hl ; $5425
	pop de ; $5426
	dec e ; $5427
	dec e ; $5428
	dec e ; $5429
	dec e ; $542a
	ret ; $542b
MinigameHitBurstParticleOffsets:
	; $542c, 192 bytes (bytes:16)
	db $00, $01, $02, $03, $04, $05, $06, $07, $08, $09, $0a, $0b, $0c, $0d, $0e, $0f ; 0x00
	db $ff, $fe, $fd, $fc, $fb, $fb, $fa, $fa, $f9, $f9, $f9, $fa, $fa, $fb, $fb, $fc ; 0x10
	db $00, $ff, $fe, $fd, $fc, $fb, $fa, $f9, $f8, $f7, $f6, $f5, $f4, $f3, $f2, $f1 ; 0x20
	db $ff, $fe, $fd, $fc, $fb, $fb, $fa, $fa, $f9, $f9, $f9, $fa, $fa, $fb, $fb, $fc ; 0x30
	db $00, $01, $02, $03, $04, $05, $06, $07, $08, $09, $0a, $0b, $0c, $0d, $0e, $0f ; 0x40
	db $ff, $fe, $fd, $fc, $fb, $fb, $fa, $fa, $f9, $f9, $f9, $fa, $fa, $fb, $fb, $fc ; 0x50
	db $00, $ff, $fe, $fd, $fc, $fb, $fa, $f9, $f8, $f7, $f6, $f5, $f4, $f3, $f2, $f1 ; 0x60
	db $ff, $fe, $fd, $fc, $fb, $fb, $fa, $fa, $f9, $f9, $f9, $fa, $fa, $fb, $fb, $fc ; 0x70
	db $00, $01, $02, $03, $04, $05, $06, $07, $08, $09, $0a, $0b, $0c, $0d, $0e, $0f ; 0x80
	db $ff, $fe, $fd, $fc, $fb, $fb, $fa, $fa, $f9, $f9, $f9, $fa, $fa, $fb, $fb, $fc ; 0x90
	db $00, $ff, $fe, $fd, $fc, $fb, $fa, $f9, $f8, $f7, $f6, $f5, $f4, $f3, $f2, $f1 ; 0xa0
	db $ff, $fe, $fd, $fc, $fb, $fb, $fa, $fa, $f9, $f9, $f9, $fa, $fa, $fb, $fb, $fc ; 0xb0
MinigameConfig_BananaBunch:
	; $54ec, 16 bytes (bytes:16)
	db $00, $11, $01, $08, $21, $16, $00, $18, $1b, $55, $b4, $40, $fc, $54, $00, $00 ; 0x00
InitMinigame_BananaBunch:
	farcall InitMinigameTargets ; $54fc
	ld a, $05 ; $54ff
	farcall SpawnMinigameTargetFormation ; $5501
	ld a, $01 ; $5504
	ld [wMinigameTargetsAltMode], a ; $5506
	ld a, $01 ; $5509
	ld [wMinigameUsesWall], a ; $550b
	ld a, [wMinigameLevel] ; $550e
	cp $02 ; $5511
	jr nz, .done ; $5513
	ld a, $01 ; $5515
	ld [wMinigameHighScoreMode], a ; $5517
.done:
	ret ; $551a
MinigameHooks_BananaBunch:
	; $551b, 16 bytes (mode_hooks)
	dw BananaBunchHook_PerFrame ; record 0
	dw BananaBunchHook_PointStart ; record 1
	dw BananaBunchHook_PointEnd ; record 2
	dw BananaBunchHook_MinigameStart ; record 3
	dw BananaBunchHook_BallHit ; record 4
	dw BananaBunchHook_Bounce ; record 5
	dw BananaBunchHook_RallyTick ; record 6
	dw RetStub ; record 7
BananaBunchHook_MinigameStart:
	ret ; $552b
BananaBunchHook_PerFrame:
	call UpdateMinigameHudAndBallTrail ; $552c
	call UpdateBananaBunchTargetHits ; $552f
	ret ; $5532
BananaBunchHook_PointStart:
	call StartMinigameSoloPoint ; $5533
	ld a, [wMinigameLevel] ; $5536
	add a ; $5539
	add LOW(BananaBunchGridLayoutsByLevel) ; $553a
	ld l, a ; $553c
	adc HIGH(BananaBunchGridLayoutsByLevel) ; $553d
	sub l ; $553f
	ld h, a ; $5540
	ld a, [hl+] ; $5541
	ld h, [hl] ; $5542
	ld l, a ; $5543
	call CopyMinigameTilemapBlock ; $5544
	ret ; $5547
BananaBunchGridLayoutsByLevel:
	; $5548, 6 bytes (records:2)
	dw BananaBunchGridLayout0 ; record 0
	dw BananaBunchGridLayout1 ; record 1
	dw BananaBunchGridLayout2 ; record 2
BananaBunchGridLayout0:
	; $554e, 24 bytes (bytes:8)
	db $00, $00, $00, $00, $00, $00, $00, $00 ; 0x00
	db $00, $00, $00, $00, $00, $00, $00, $00 ; 0x08
	db $00, $00, $00, $00, $00, $00, $00, $00 ; 0x10
BananaBunchGridLayout1:
	; $5566, 24 bytes (bytes:8)
	db $00, $00, $07, $00, $07, $00, $00, $00 ; 0x00
	db $00, $00, $00, $07, $00, $00, $00, $00 ; 0x08
	db $00, $00, $07, $00, $07, $00, $00, $00 ; 0x10
BananaBunchGridLayout2:
	; $557e, 24 bytes (bytes:8)
	db $07, $07, $00, $00, $05, $00, $05, $00 ; 0x00
	db $07, $00, $07, $00, $05, $05, $00, $00 ; 0x08
	db $07, $07, $00, $00, $05, $00, $05, $00 ; 0x10
BananaBunchHook_PointEnd:
	call HandleMinigamePointEnd ; $5596
	ret ; $5599
BananaBunchHook_RallyTick:
	call BananaBunchReflectBallAndRecordCell ; $559a
	ret ; $559d
BananaBunchHook_Bounce:
	call StubNop_0d_0 ; $559e
	ret ; $55a1
BananaBunchHook_BallHit:
	call HideLandingMarkerAndExtendSoloCourt ; $55a2
	ret ; $55a5
UpdateBananaBunchTargetHits:
	call ScoreMinigameTargetHitOrDeflectBall ; $55a6
	ret ; $55a9
BananaBunchReflectBallAndRecordCell:
	call ReflectBallVelocity ; $55aa
	call GetMinigameGridCellIndex ; $55ad
	ld [wMinigameLastHitCell], a ; $55b0
	ret ; $55b3
CopyMinigameTilemapBlock:
	wram_bank $02 ; $55b4
	ld de, wMinigameTargetGrid ; $55ba
	ld bc, $0018 ; $55bd
	call CopyMemoryBC ; $55c0
	call DrawMinigameGrid ; $55c3
	farcall FlushTilemapToVram ; $55c6
	ret ; $55c9
ScoreMinigameTargetHitOrDeflectBall:
	ld hl, wMinigameHitPending ; $55ca
	ld a, [hl] ; $55cd
	and a ; $55ce
	ret z ; $55cf
	ld [hl], $00 ; $55d0
	ld a, [wMinigameHitTargetType] ; $55d2
	cp $ff ; $55d5
	jr z, MinigameTargetTypeScores.eqff ; $55d7
	ld a, [wMinigameHitTargetType] ; $55d9
	add LOW(MinigameTargetTypeScores) ; $55dc
	ld l, a ; $55de
	adc HIGH(MinigameTargetTypeScores) ; $55df
	sub l ; $55e1
	ld h, a ; $55e2
	ld e, [hl] ; $55e3
	ld d, $00 ; $55e4
	call AddToMinigameScore ; $55e6
	ld a, $ff ; $55e9
	ld [wMinigameHitTargetType], a ; $55eb
	call IsMinigameTargetReached ; $55ee
	and a ; $55f1
	ret z ; $55f2
	ld a, $0b ; $55f3
	ld [wPointOutcome], a ; $55f5
	ret ; $55f8
MinigameTargetTypeScores:
	; $55f9, 4 bytes (bytes:4)
	db $01, $03, $05, $03 ; 0x00
.eqff:
	ld a, [wMinigameLastHitCell] ; $55fd
	cp $ff ; $5600
	ret z ; $5602
	add $c0 ; $5603
	ld l, a ; $5605
	adc $c7 ; $5606
	sub l ; $5608
	ld h, a ; $5609
	ld a, [hl] ; $560a
	and a ; $560b
	ret z ; $560c
	sub $04 ; $560d
	farcall DeflectBallOffMinigameTarget ; $560f
	sound $77 ; $5612
	ret ; $5614
MinigameConfig_BooBlast:
	; $5615, 16 bytes (bytes:16)
	db $17, $12, $02, $08, $1c, $11, $00, $1a, $58, $56, $c6, $40, $25, $56, $00, $00 ; 0x00
InitMinigame_BooBlast:
	ld a, $01 ; $5625
	ld [wMinigameIsBooBlast], a ; $5627
	ld a, [wMinigameLevel] ; $562a
	cp $02 ; $562d
	jr nz, .ne02 ; $562f
	ld a, $01 ; $5631
	ld [wMinigameHighScoreMode], a ; $5633
.ne02:
	ld hl, BooBlastInitParams ; $5636
	ld a, [hl+] ; $5639
	ld [wPlayer2MainAiParams], a ; $563a
	ld a, [hl+] ; $563d
	ld [wPlayer2MainAiParams + 1], a ; $563e
	ld a, [hl+] ; $5641
	ld [wPlayer2MainAiParams + 2], a ; $5642
	ld a, [hl+] ; $5645
	ld [wPlayer2MainAiParams + 3], a ; $5646
	ld a, [hl+] ; $5649
	ld [wExhibitionModeCPUMainCharacterDifficulty], a ; $564a
	ld a, [hl+] ; $564d
	ld [wPlayer2MainInitByte], a ; $564e
	ret ; $5651
BooBlastInitParams:
	; $5652, 6 bytes (bytes:6)
	db $00, $00, $00, $dc, $03, $01 ; 0x00
MinigameHooks_BooBlast:
	; $5658, 16 bytes (mode_hooks)
	dw BooBlastHook_PerFrame ; record 0
	dw BooBlastHook_PointStart ; record 1
	dw BooBlastHook_PointEnd ; record 2
	dw BooBlastHook_MinigameStart ; record 3
	dw BooBlastHook_BallHit ; record 4
	dw BooBlastHook_Bounce ; record 5
	dw BooBlastHook_RallyTick ; record 6
	dw BooBlastHook_Draw ; record 7
BooBlastHook_MinigameStart:
	call InitMinigameControllerActor ; $5668
	call InitBooBlastScore ; $566b
	ret ; $566e
BooBlastHook_PerFrame:
	call DrawMinigameScoreAtDefaultPos ; $566f
	call UpdateScorePopup ; $5672
	ret ; $5675
BooBlastHook_Draw:
	call UpdateMinigameActors ; $5676
	ret ; $5679
BooBlastHook_PointStart:
	call DisableOffscreenArrows ; $567a
	ret ; $567d
BooBlastHook_PointEnd:
	call DisableMinigameControllerActor ; $567e
	call ResolveAndShowMinigamePoint ; $5681
	ret ; $5684
BooBlastHook_RallyTick:
	call StubNop_0d_1 ; $5685
	ret ; $5688
BooBlastHook_Bounce:
	call StubNop_0d_2 ; $5689
	ret ; $568c
BooBlastHook_BallHit:
	call UpdateBooBlastHitStreak ; $568d
	ret ; $5690
InitMinigameControllerActor:
	call ClearMinigameActors ; $5691
	ld de, BooBlastControllerActorHandler ; $5694
	ld bc, wMinigameActors ; $5697
	call SetMinigameActorHandler ; $569a
	ld hl, $0000 ; $569d
	ld de, $0000 ; $56a0
	ld bc, wMinigameActors ; $56a3
	call SetMinigameActorPosition ; $56a6
	ret ; $56a9
DisableMinigameControllerActor:
	ld hl, wMinigameActors ; $56aa
	res 0, [hl] ; $56ad
	ret ; $56af
InitBooBlastScore:
	call InitMinigameScore ; $56b0
	ret ; $56b3
DrawMinigameScoreAtDefaultPos:
	ld de, $8403 ; $56b4
	call DrawMinigameScore ; $56b7
	ret ; $56ba
DisableOffscreenArrows:
	xor a ; $56bb
	ld [wOffscreenArrowsEnabled], a ; $56bc
	ret ; $56bf
ResolveAndShowMinigamePoint:
	call ShowPointOutcomeBanner ; $56c0
	call DetermineMinigamePointResult ; $56c3
	push de ; $56c6
	ldh a, [hWramBank] ; $56c7
	push af ; $56c9
	wram_bank $04 ; $56ca
	farcall CharPointEndReaction ; $56d0
	ld a, [wCharPointResult] ; $56d3
	push af ; $56d6
	wram_bank $05 ; $56d7
	farcall CharPointEndReaction ; $56dd
	pop af ; $56e0
	ld [wCharPointResult], a ; $56e1
	pop af ; $56e4
	wram_bank ; $56e5
	pop de ; $56e9
	call ShowMinigamePointResult ; $56ea
	ret ; $56ed
StubNop_0d_1:
	ret ; $56ee
StubNop_0d_2:
	ret ; $56ef
UpdateBooBlastHitStreak:
	ld a, [wLastShotCharIndex] ; $56f0
	and $01 ; $56f3
	jr nz, .maskSet ; $56f5
	ld a, [wMinigameHitScored] ; $56f7
	and a ; $56fa
	jr z, .step3 ; $56fb
	jr .incrementCappedCounter ; $56fd
.maskSet:
	ld a, [wMinigameHitScored] ; $56ff
	and a ; $5702
	jr nz, .incrementCappedCounter ; $5703
	xor a ; $5705
	ld [wMinigameHitStreak], a ; $5706
	jr .step3 ; $5709
.incrementCappedCounter:
	ld b, $07 ; $570b
	call IncrementCappedCounter ; $570d
.step3:
	xor a ; $5710
	ld [wMinigameHitScored], a ; $5711
	xor a ; $5714
	ld [wMinigameActors + 2], a ; $5715
	ret ; $5718
BooBlastControllerActorHandler:
	ld a, [wMinigameSceneActor + 2] ; $5719
	rst Rst00 ; $571c
	dw AdvanceMinigameScriptState.advanceMinigameScriptState ; $571d jumptable
	dw AdvanceMinigameScriptState.drawBooBlastTargetSprite ; $571f jumptable
	dw AdvanceMinigameScriptState.drawBooBlastHitBurst ; $5721 jumptable
	dw AdvanceMinigameScriptState.drawBooBlastTargetSprite2 ; $5723 jumptable
	dw RetStub ; $5725 jumptable
AdvanceMinigameScriptState:
	ld hl, wMinigameSceneActor + 2 ; $5727
	inc [hl] ; $572a
	ret ; $572b
.advanceMinigameScriptState:
	call AdvanceMinigameScriptState ; $572c
.drawBooBlastTargetSprite:
	call DrawBooBlastTargetSprite ; $572f
	call IsBallWithinTargetZone ; $5732
	and a ; $5735
	ret z ; $5736
	call ScoreBallHit ; $5737
	jp AdvanceMinigameScriptState ; $573a
.drawBooBlastHitBurst:
	call DrawBooBlastHitBurst ; $573d
	ld hl, wMinigameSceneActor + 3 ; $5740
	dec [hl] ; $5743
	ld a, [hl] ; $5744
	and a ; $5745
	ret nz ; $5746
	farcall AdvanceMatchRng ; $5747
	ld h, $00 ; $574a
	ld l, a ; $574c
	add hl, hl ; $574d
	ld de, $ff00 ; $574e
	add hl, de ; $5751
	ld de, $0000 ; $5752
	call SetMinigameActorWorldPos ; $5755
	jp AdvanceMinigameScriptState ; $5758
.drawBooBlastTargetSprite2:
	call DrawBooBlastTargetSprite ; $575b
	ret ; $575e
IsBallWithinTargetZone:
	ld hl, wMinigameSceneActor + 6 ; $575f
	ld a, [hl+] ; $5762
	ld d, [hl] ; $5763
	ld e, a ; $5764
	ld hl, wBallX ; $5765
	ld a, [hl+] ; $5768
	ld h, [hl] ; $5769
	ld l, a ; $576a
	ld a, l ; $576b
	sub e ; $576c
	ld l, a ; $576d
	ld a, h ; $576e
	sbc d ; $576f
	ld h, a ; $5770
	bit 7, h ; $5771
	jr z, .positive ; $5773
	xor a ; $5775
	sub l ; $5776
	ld l, a ; $5777
	sbc a ; $5778
	sub h ; $5779
	ld h, a ; $577a
.positive:
	ld de, $ff80 ; $577b
	add hl, de ; $577e
	jr c, .returnZero ; $577f
	ld hl, wMinigameSceneActor + 8 ; $5781
	ld a, [hl+] ; $5784
	ld d, [hl] ; $5785
	ld e, a ; $5786
	ld hl, wBallDepth ; $5787
	ld a, [hl+] ; $578a
	ld h, [hl] ; $578b
	ld l, a ; $578c
	ld a, l ; $578d
	sub e ; $578e
	ld l, a ; $578f
	ld a, h ; $5790
	sbc d ; $5791
	ld h, a ; $5792
	bit 7, h ; $5793
	jr z, .positive2 ; $5795
	xor a ; $5797
	sub l ; $5798
	ld l, a ; $5799
	sbc a ; $579a
	sub h ; $579b
	ld h, a ; $579c
.positive2:
	ld de, $fec0 ; $579d
	add hl, de ; $57a0
	jr c, .returnZero ; $57a1
	ld hl, wBallHeight ; $57a3
	ld a, [hl+] ; $57a6
	ld h, [hl] ; $57a7
	ld l, a ; $57a8
	bit 7, h ; $57a9
	jr z, .positive3 ; $57ab
	xor a ; $57ad
	sub l ; $57ae
	ld l, a ; $57af
	sbc a ; $57b0
	sub h ; $57b1
	ld h, a ; $57b2
.positive3:
	ld de, $ff00 ; $57b3
	add hl, de ; $57b6
	jr c, .returnZero ; $57b7
	ld a, $01 ; $57b9
	ret ; $57bb
.returnZero:
	xor a ; $57bc
	ret ; $57bd
ScoreBallHit:
	ld a, $10 ; $57be
	ld [wMinigameSceneActor + 3], a ; $57c0
	ld a, $01 ; $57c3
	ld [wMinigameHitScored], a ; $57c5
	sound $86 ; $57c8
	ld a, [wMinigameHitStreak] ; $57ca
	add $f5 ; $57cd
	ld e, a ; $57cf
	adc $57 ; $57d0
	sub e ; $57d2
	ld d, a ; $57d3
	ld a, [de] ; $57d4
	ld hl, $0001 ; $57d5
	call MulHLByA ; $57d8
	ld e, l ; $57db
	ld d, h ; $57dc
	ld hl, wScorePopupValue ; $57dd
	ld a, e ; $57e0
	ld [hl+], a ; $57e1
	ld [hl], d ; $57e2
	call AddToMinigameScore ; $57e3
	call StartScorePopup ; $57e6
	call IsMinigameTargetReached ; $57e9
	and a ; $57ec
	jr z, .done ; $57ed
	ld a, $0b ; $57ef
	ld [wPointOutcome], a ; $57f1
.done:
	ret ; $57f4
	ld bc, $0402 ; $57f5
	ld [$2010], sp ; $57f8
	ld b, b ; $57fb
	add b ; $57fc
DrawBooBlastTargetSprite:
	call ProjectBallSprite ; $57fd
	ld c, $30 ; $5800
	ld h, $fc ; $5802
	ld l, $f1 ; $5804
	call QueueSprite24x32 ; $5806
	ldh a, [hVBlankCounter] ; $5809
	and $1f ; $580b
	add LOW(BooBlastTargetAnimFrames) ; $580d
	ld l, a ; $580f
	adc HIGH(BooBlastTargetAnimFrames) ; $5810
	sub l ; $5812
	ld h, a ; $5813
	ld a, [hl] ; $5814
	cp $ff ; $5815
	ret z ; $5817
	farcall QueueMatchSpriteFrameB ; $5818
	ret ; $581b
BooBlastTargetAnimFrames:
	; $581c, 32 bytes (bytes:8)
	db $00, $ff, $ff, $ff, $ff, $ff, $ff, $ff ; 0x00
	db $01, $ff, $ff, $ff, $ff, $ff, $ff, $ff ; 0x08
	db $02, $ff, $ff, $ff, $ff, $ff, $ff, $ff ; 0x10
	db $01, $ff, $ff, $ff, $ff, $ff, $ff, $ff ; 0x18
DrawBooBlastHitBurst:
	call ProjectBallSprite ; $583c
	ld c, $3c ; $583f
	ld a, [wMinigameSceneActor + 3] ; $5841
	call QueueMinigameHitBurst ; $5844
	ret ; $5847
ProjectBallSprite:
	ld hl, wMinigameSceneActor + 10 ; $5848
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
	farcall ApplyCameraProjection ; $5855
	ld a, [wMinigameHitStreak] ; $5858
	add $66 ; $585b
	ld l, a ; $585d
	adc $58 ; $585e
	sub l ; $5860
	ld h, a ; $5861
	ld b, [hl] ; $5862
	ld b, $0e ; $5863
	ret ; $5865
	rrca ; $5866
	ld c, $0e ; $5867
	ld c, $0e ; $5869
	ld c, $0e ; $586b
	dec c ; $586d
MinigameConfig_PerfectShot:
	nop ; $586e
	inc de ; $586f
	ld bc, $1e08 ; $5870
	ld [de], a ; $5873
	nop ; $5874
	rra ; $5875
	and [hl] ; $5876
	ld e, b ; $5877
	or h ; $5878
	ld b, b ; $5879
	ld a, [hl] ; $587a
	ld e, b ; $587b
	nop ; $587c
	nop ; $587d
InitMinigame_PerfectShot:
	ld a, $01 ; $587e
	ld [wMinigameUsesWall], a ; $5880
	ld a, [wMinigameLevel] ; $5883
	cp $02 ; $5886
	jr nz, .initMinigameTargets ; $5888
	ld a, $01 ; $588a
	ld [wMinigameHighScoreMode], a ; $588c
.initMinigameTargets:
	farcall InitMinigameTargets ; $588f
	ld a, [wMinigameLevel] ; $5892
	add LOW(PerfectShotLevelHasTargets) ; $5895
	ld l, a ; $5897
	adc HIGH(PerfectShotLevelHasTargets) ; $5898
	sub l ; $589a
	ld h, a ; $589b
	ld a, [hl] ; $589c
	and a ; $589d
	ret z ; $589e
	farcall SpawnMinigameTargetFormation ; $589f
	ret ; $58a2
PerfectShotLevelHasTargets:
	; $58a3, 3 bytes (bytes:3)
	db $00, $07, $08 ; 0x00
MinigameHooks_PerfectShot:
	; $58a6, 16 bytes (mode_hooks)
	dw PerfectShotHook_PerFrame ; record 0
	dw PerfectShotHook_PointStart ; record 1
	dw PerfectShotHook_PointEnd ; record 2
	dw RetStub ; record 3
	dw PerfectShotHook_BallHit ; record 4
	dw PerfectShotHook_Bounce ; record 5
	dw PerfectShotHook_RallyTick ; record 6
	dw RetStub ; record 7
PerfectShotHook_PerFrame:
	call UpdateMinigameHudAndBallTrail ; $58b6
	ret ; $58b9
PerfectShotHook_PointStart:
	call StartMinigameSoloPoint ; $58ba
	call ResetTargetGrid ; $58bd
	ret ; $58c0
PerfectShotHook_PointEnd:
	call HandleMinigamePointEnd ; $58c1
	ret ; $58c4
PerfectShotHook_RallyTick:
	call ProcessTargetTileHit ; $58c5
	ret ; $58c8
PerfectShotHook_Bounce:
	call StubNop_0d_0 ; $58c9
	ret ; $58cc
PerfectShotHook_BallHit:
	call HideLandingMarkerAndExtendSoloCourt ; $58cd
	ret ; $58d0
ProcessTargetTileHit:
	call ReflectBallVelocity ; $58d1
	call GetMinigameGridCellIndex ; $58d4
	cp $ff ; $58d7
	ret z ; $58d9
	ld b, a ; $58da
	add $c0 ; $58db
	ld l, a ; $58dd
	adc $c7 ; $58de
	sub l ; $58e0
	ld h, a ; $58e1
	ld a, [hl] ; $58e2
	cp $01 ; $58e3
	ret z ; $58e5
	ldh a, [hWramBank] ; $58e6
	push af ; $58e8
	wram_bank $02 ; $58e9
	ld a, $01 ; $58ef
	ld [hl], a ; $58f1
	ld a, b ; $58f2
	ld b, $01 ; $58f3
	call DrawMinigameGridCell ; $58f5
	farcall FlushTilemapToVram ; $58f8
	pop af ; $58fb
	wram_bank ; $58fc
	sound $97 ; $5900
	ld a, [wTargetTileHit] ; $5902
	inc a ; $5905
	ld e, a ; $5906
	ld d, $00 ; $5907
	call AddToMinigameScore ; $5909
	call IsMinigameTargetReached ; $590c
	and a ; $590f
	jr z, .areAllTargetsHit ; $5910
	ld a, $0b ; $5912
	ld [wPointOutcome], a ; $5914
	ret ; $5917
.areAllTargetsHit:
	call AreAllTargetsHit ; $5918
	and a ; $591b
	ret z ; $591c
	ld hl, wTargetTileHit ; $591d
	ld a, [hl] ; $5920
	cp $09 ; $5921
	jr nc, .ge09 ; $5923
	inc [hl] ; $5925
.ge09:
	ldh a, [hWramBank] ; $5926
	push af ; $5928
	wram_bank $02 ; $5929
	ld a, $01 ; $592f
	ld [wMatchSimFrozen], a ; $5931
	call AnimateTargetGridClear ; $5934
	xor a ; $5937
	ld [wMatchSimFrozen], a ; $5938
	pop af ; $593b
	wram_bank ; $593c
	ret ; $5940
PerfectShotTargetGridLayout:
	; $5941, 24 bytes (bytes:8)
	db $02, $02, $02, $02, $02, $02, $02, $00 ; 0x00
	db $02, $02, $02, $02, $02, $02, $02, $00 ; 0x08
	db $03, $03, $03, $03, $03, $03, $03, $00 ; 0x10
	; $5959, 32 bytes (bytes:8)
	db $01, $01, $01, $01, $01, $01, $01, $00 ; 0x00
	db $01, $01, $01, $01, $01, $01, $01, $00 ; 0x08
	db $01, $01, $01, $03, $01, $01, $01, $00 ; 0x10
	db $03, $03, $03, $03, $03, $03, $03, $00 ; 0x18
ResetTargetGrid:
	ld hl, PerfectShotTargetGridLayout ; $5979
	call CopyMinigameTilemapBlock ; $597c
	ld a, $01 ; $597f
	ld [wMinigameTargetGrid + 7], a ; $5981
	ld [wMinigameTargetGrid + 15], a ; $5984
	ld [wMinigameTargetGrid + 23], a ; $5987
	ret ; $598a
AnimateTargetGridClear:
	ld a, $02 ; $598b
	farcall StepMatchFrames ; $598d
	ld hl, PerfectShotTargetGridLayout ; $5990
	ld b, $18 ; $5993
	ld c, $00 ; $5995
.loop:
	ld a, [hl+] ; $5997
	cp $00 ; $5998
	jr z, .eq00 ; $599a
	push bc ; $599c
	push hl ; $599d
	ld b, a ; $599e
	ld a, c ; $599f
	call DrawMinigameGridCell ; $59a0
	farcall FlushTilemapToVram ; $59a3
	sound $94 ; $59a6
	ld a, $08 ; $59a8
	farcall StepMatchFrames ; $59aa
	pop hl ; $59ad
	pop bc ; $59ae
.eq00:
	inc c ; $59af
	dec b ; $59b0
	jr nz, .loop ; $59b1
	call ResetTargetGrid ; $59b3
	ret ; $59b6
AreAllTargetsHit:
	ld hl, wMinigameTargetGrid ; $59b7
	ld c, $18 ; $59ba
	xor a ; $59bc
.loop:
	ld a, [hl+] ; $59bd
	cp $01 ; $59be
	jr nz, .ne01 ; $59c0
	dec c ; $59c2
	jr nz, .loop ; $59c3
	ld a, $01 ; $59c5
	ret ; $59c7
.ne01:
	ld a, $00 ; $59c8
	ret ; $59ca
MinigameConfig_TreasureBox:
	; $59cb, 16 bytes (bytes:16)
	db $1b, $14, $02, $08, $22, $14, $00, $1e, $ed, $59, $bd, $40, $db, $59, $00, $00 ; 0x00
InitMinigame_TreasureBox:
	ld a, $01 ; $59db
	ld [wMinigameUsesTennisMachine], a ; $59dd
	ld a, [wMinigameLevel] ; $59e0
	cp $02 ; $59e3
	jr nz, .done ; $59e5
	ld a, $01 ; $59e7
	ld [wMinigameHighScoreMode], a ; $59e9
.done:
	ret ; $59ec
MinigameHooks_TreasureBox:
	; $59ed, 16 bytes (mode_hooks)
	dw TreasureBoxHook_PerFrame ; record 0
	dw TreasureBoxHook_PointStart ; record 1
	dw TreasureBoxHook_PointEnd ; record 2
	dw TreasureBoxHook_MinigameStart ; record 3
	dw TreasureBoxHook_BallHit ; record 4
	dw TreasureBoxHook_Bounce ; record 5
	dw TreasureBoxHook_RallyTick ; record 6
	dw TreasureBoxHook_Draw ; record 7
TreasureBoxHook_MinigameStart:
	call ClearMinigameActors ; $59fd
	ld a, $01 ; $5a00
	ld [wMinigameServeSlot], a ; $5a02
	call StartMinigameMatch ; $5a05
	ld a, $01 ; $5a08
	ld [wTargetZoneEnabled], a ; $5a0a
	ld de, TreasureBoxTargetActorHandler ; $5a0d
	ld bc, wMinigameActors ; $5a10
	call SetMinigameActorHandler ; $5a13
	ret ; $5a16
TreasureBoxHook_PerFrame:
	call DrawMinigameScoreHud ; $5a17
	call UpdateTreasureBoxScorePopup ; $5a1a
	ret ; $5a1d
TreasureBoxHook_Draw:
	call UpdateMinigameActors ; $5a1e
	ret ; $5a21
TreasureBoxHook_PointStart:
	call SelectRandomTreasureBoxTargetZone ; $5a22
	farcall AdvanceMatchRng ; $5a25
	and $01 ; $5a28
	inc a ; $5a2a
	ld hl, wMinigameServeSlot ; $5a2b
	add [hl] ; $5a2e
	cp $03 ; $5a2f
	jr c, .store ; $5a31
	sub $03 ; $5a33
.store:
	ld [hl], a ; $5a35
	call LaunchMinigameServe ; $5a36
	ret ; $5a39
TreasureBoxHook_PointEnd:
	call StubNop_0d_3 ; $5a3a
	call EndMinigamePoint ; $5a3d
	ret ; $5a40
TreasureBoxHook_RallyTick:
	call KeepMinigameCameraFixed ; $5a41
	ret ; $5a44
TreasureBoxHook_Bounce:
	ld a, [wPointOutcome] ; $5a45
	and a ; $5a48
	ret nz ; $5a49
	call CheckMinigameStartBannerTrigger ; $5a4a
	call CheckBallLandedOut ; $5a4d
	ld a, [wPointOutcome] ; $5a50
	cp $06 ; $5a53
	ret nz ; $5a55
	ld de, $0001 ; $5a56
	ld hl, wScorePopupValue ; $5a59
	ld a, e ; $5a5c
	ld [hl+], a ; $5a5d
	ld [hl], d ; $5a5e
	call AddToMinigameScore ; $5a5f
	call StartScorePopup ; $5a62
	sound $97 ; $5a65
	ret ; $5a67
TreasureBoxHook_BallHit:
	call FreezeMinigameOpponentOnReturn ; $5a68
	ret ; $5a6b
UpdateTreasureBoxScorePopup:
	call UpdateScorePopup ; $5a6c
	ret ; $5a6f
SelectRandomTreasureBoxTargetZone:
	ld a, [wMinigameLevel] ; $5a70
	add a ; $5a73
	add LOW(TreasureBoxZonePoolsByLevel) ; $5a74
	ld l, a ; $5a76
	adc HIGH(TreasureBoxZonePoolsByLevel) ; $5a77
	sub l ; $5a79
	ld h, a ; $5a7a
	ld a, [hl+] ; $5a7b
	ld h, [hl] ; $5a7c
	ld l, a ; $5a7d
	farcall AdvanceMatchRng ; $5a7e
	and $0f ; $5a81
	add l ; $5a83
	ld l, a ; $5a84
	jr nc, .read ; $5a85
	inc h ; $5a87
.read:
	ld a, [hl] ; $5a88
	ld [wMinigameShotRoll], a ; $5a89
	ld a, [wMinigameShotRoll] ; $5a8c
	call LoadTargetZoneConfig ; $5a8f
	ld a, [wMinigameHitScored] ; $5a92
	and a ; $5a95
	jr nz, .nonZero ; $5a96
	xor a ; $5a98
	ld [wMinigameHitStreak], a ; $5a99
.nonZero:
	xor a ; $5a9c
	ld [wMinigameHitScored], a ; $5a9d
	xor a ; $5aa0
	ld [wMinigameActors + 2], a ; $5aa1
	ret ; $5aa4
TreasureBoxZonePoolsByLevel:
	; $5aa5, 6 bytes (records:2)
	dw TreasureBoxZonePool0 ; record 0
	dw TreasureBoxZonePool1 ; record 1
	dw TreasureBoxZonePool1 ; record 2
TreasureBoxZonePool0:
	; $5aab, 16 bytes (bytes:16)
	db $00, $00, $00, $00, $01, $01, $01, $01, $04, $04, $04, $04, $00, $00, $01, $01 ; 0x00
TreasureBoxZonePool1:
	; $5abb, 16 bytes (bytes:16)
	db $00, $00, $00, $00, $01, $01, $01, $01, $04, $04, $04, $04, $02, $02, $03, $03 ; 0x00
StubNop_0d_3:
	ret ; $5acb
TreasureBoxTargetActorHandler:
	ld a, [wMinigameSceneActor + 2] ; $5acc
	rst Rst00 ; $5acf
	dw AdvanceTreasureBoxActorState.step ; $5ad0 jumptable
	dw AdvanceTreasureBoxActorState.drawTreasureBoxSprite ; $5ad2 jumptable
	dw AdvanceTreasureBoxActorState.drawTreasureBoxHitCountdown ; $5ad4 jumptable
	dw AdvanceTreasureBoxActorState.done ; $5ad6 jumptable
	dw RetStub ; $5ad8 jumptable
AdvanceTreasureBoxActorState:
	ld hl, wMinigameSceneActor + 2 ; $5ada
	inc [hl] ; $5add
	ret ; $5ade
.step:
	xor a ; $5adf
	ld [wTreasureBoxState], a ; $5ae0
	ld hl, wMinigameServeCount ; $5ae3
	ld a, [hl+] ; $5ae6
	ld h, [hl] ; $5ae7
	ld l, a ; $5ae8
	ld de, $fff5 ; $5ae9
	add hl, de ; $5aec
	bit 7, h ; $5aed
	ld hl, TreasureBoxTypePoolLate ; $5aef
	jr z, .advanceMatchRng ; $5af2
	ld hl, TreasureBoxTypePoolEarly ; $5af4
.advanceMatchRng:
	farcall AdvanceMatchRng ; $5af7
	and $0f ; $5afa
	add l ; $5afc
	ld l, a ; $5afd
	jr nc, .read ; $5afe
	inc h ; $5b00
.read:
	ld a, [hl] ; $5b01
	ld [wMinigameSceneActor + 1], a ; $5b02
	ld a, [wMinigameShotRoll] ; $5b05
	add a ; $5b08
	add LOW(TreasureBoxSpawnPointsByZone) ; $5b09
	ld l, a ; $5b0b
	adc HIGH(TreasureBoxSpawnPointsByZone) ; $5b0c
	sub l ; $5b0e
	ld h, a ; $5b0f
	ld a, [hl+] ; $5b10
	ld h, [hl] ; $5b11
	ld l, a ; $5b12
	farcall AdvanceMatchRng ; $5b13
	and $03 ; $5b16
	add a ; $5b18
	add a ; $5b19
	add l ; $5b1a
	ld l, a ; $5b1b
	jr nc, .readB ; $5b1c
	inc h ; $5b1e
.readB:
	ld a, [hl+] ; $5b1f
	ld c, a ; $5b20
	ld a, [hl+] ; $5b21
	ld b, a ; $5b22
	ld a, [hl+] ; $5b23
	ld e, a ; $5b24
	ld a, [hl+] ; $5b25
	ld d, a ; $5b26
	ld l, c ; $5b27
	ld h, b ; $5b28
	call SetMinigameActorWorldPos ; $5b29
	call AdvanceTreasureBoxActorState ; $5b2c
.drawTreasureBoxSprite:
	call DrawTreasureBoxSprite ; $5b2f
	call IsBallInTreasureBoxHitZone ; $5b32
	and a ; $5b35
	ret z ; $5b36
	call AwardTreasureBoxHitScore ; $5b37
	jp AdvanceTreasureBoxActorState ; $5b3a
.drawTreasureBoxHitCountdown:
	call DrawTreasureBoxHitCountdown ; $5b3d
	ld hl, wMinigameSceneActor + 3 ; $5b40
	dec [hl] ; $5b43
	ld a, [hl] ; $5b44
	and a ; $5b45
	ret nz ; $5b46
	jp AdvanceTreasureBoxActorState ; $5b47
.done:
	ret ; $5b4a
TreasureBoxTypePoolLate:
	; $5b4b, 16 bytes (bytes:16)
	db $00, $00, $00, $00, $00, $00, $03, $03, $01, $01, $01, $01, $01, $02, $02, $02 ; 0x00
TreasureBoxTypePoolEarly:
	; $5b5b, 16 bytes (bytes:16)
	db $00, $00, $00, $00, $00, $00, $01, $00, $01, $01, $01, $01, $01, $02, $02, $02 ; 0x00
TreasureBoxSpawnPointsByZone:
	; $5b6b, 10 bytes (records:2)
	dw TreasureBoxSpawnPoints0 ; record 0
	dw TreasureBoxSpawnPoints1 ; record 1
	dw TreasureBoxSpawnPoints2 ; record 2
	dw TreasureBoxSpawnPoints3 ; record 3
	dw TreasureBoxSpawnPoints4 ; record 4
TreasureBoxSpawnPoints0:
	; $5b75, 16 bytes (bytes:4)
	db $80, $ff, $80, $fe ; 0x00
	db $00, $ff, $00, $fe ; 0x04
	db $60, $ff, $80, $fd ; 0x08
	db $e0, $fe, $00, $fd ; 0x0c
TreasureBoxSpawnPoints1:
	; $5b85, 16 bytes (bytes:4)
	db $80, $00, $80, $fe ; 0x00
	db $00, $01, $00, $fe ; 0x04
	db $a0, $00, $80, $fd ; 0x08
	db $20, $01, $00, $fd ; 0x0c
TreasureBoxSpawnPoints2:
	; $5b95, 16 bytes (bytes:4)
	db $a0, $00, $00, $fe ; 0x00
	db $20, $00, $00, $fe ; 0x04
	db $e0, $ff, $00, $fe ; 0x08
	db $60, $ff, $00, $fe ; 0x0c
TreasureBoxSpawnPoints3:
	; $5ba5, 16 bytes (bytes:4)
	db $c0, $00, $00, $fd ; 0x00
	db $40, $00, $00, $fd ; 0x04
	db $c0, $ff, $00, $fd ; 0x08
	db $40, $ff, $00, $fd ; 0x0c
TreasureBoxSpawnPoints4:
	; $5bb5, 16 bytes (bytes:4)
	db $00, $00, $00, $fd ; 0x00
	db $00, $00, $80, $fe ; 0x04
	db $00, $01, $c0, $fd ; 0x08
	db $00, $ff, $c0, $fd ; 0x0c
IsBallInTreasureBoxHitZone:
	ld a, [wLastShotCharIndex] ; $5bc5
	and $01 ; $5bc8
	jp nz, .returnZero ; $5bca
	ld hl, wMinigameSceneActor + 6 ; $5bcd
	ld a, [hl+] ; $5bd0
	ld d, [hl] ; $5bd1
	ld e, a ; $5bd2
	ld hl, wBallX ; $5bd3
	ld a, [hl+] ; $5bd6
	ld h, [hl] ; $5bd7
	ld l, a ; $5bd8
	ld a, l ; $5bd9
	sub e ; $5bda
	ld l, a ; $5bdb
	ld a, h ; $5bdc
	sbc d ; $5bdd
	ld h, a ; $5bde
	bit 7, h ; $5bdf
	jr z, .positive ; $5be1
	xor a ; $5be3
	sub l ; $5be4
	ld l, a ; $5be5
	sbc a ; $5be6
	sub h ; $5be7
	ld h, a ; $5be8
.positive:
	ld de, $ffa0 ; $5be9
	add hl, de ; $5bec
	jr c, .returnZero ; $5bed
	ld hl, wMinigameSceneActor + 8 ; $5bef
	ld a, [hl+] ; $5bf2
	ld d, [hl] ; $5bf3
	ld e, a ; $5bf4
	ld hl, wBallDepth ; $5bf5
	ld a, [hl+] ; $5bf8
	ld h, [hl] ; $5bf9
	ld l, a ; $5bfa
	ld a, l ; $5bfb
	sub e ; $5bfc
	ld l, a ; $5bfd
	ld a, h ; $5bfe
	sbc d ; $5bff
	ld h, a ; $5c00
	bit 7, h ; $5c01
	jr z, .positive2 ; $5c03
	xor a ; $5c05
	sub l ; $5c06
	ld l, a ; $5c07
	sbc a ; $5c08
	sub h ; $5c09
	ld h, a ; $5c0a
.positive2:
	ld de, $ff80 ; $5c0b
	add hl, de ; $5c0e
	jr c, .returnZero ; $5c0f
	ld hl, wBallHeight ; $5c11
	ld a, [hl+] ; $5c14
	ld h, [hl] ; $5c15
	ld l, a ; $5c16
	bit 7, h ; $5c17
	jr z, .positive3 ; $5c19
	xor a ; $5c1b
	sub l ; $5c1c
	ld l, a ; $5c1d
	sbc a ; $5c1e
	sub h ; $5c1f
	ld h, a ; $5c20
.positive3:
	ld de, $ff40 ; $5c21
	add hl, de ; $5c24
	jr c, .returnZero ; $5c25
	ld a, $01 ; $5c27
	ret ; $5c29
.returnZero:
	xor a ; $5c2a
	ret ; $5c2b
AwardTreasureBoxHitScore:
	ld a, $10 ; $5c2c
	ld [wMinigameSceneActor + 3], a ; $5c2e
	ld a, $01 ; $5c31
	ld [wMinigameHitScored], a ; $5c33
	ld a, [wMinigameHitStreak] ; $5c36
	add $81 ; $5c39
	ld e, a ; $5c3b
	adc $5c ; $5c3c
	sub e ; $5c3e
	ld d, a ; $5c3f
	ld a, [de] ; $5c40
	call PlaySoundManaged ; $5c41
	ld a, [wMinigameSceneActor + 1] ; $5c44
	add LOW(TreasureBoxValuesByType) ; $5c47
	ld l, a ; $5c49
	adc HIGH(TreasureBoxValuesByType) ; $5c4a
	sub l ; $5c4c
	ld h, a ; $5c4d
	ld l, [hl] ; $5c4e
	ld h, $00 ; $5c4f
	ld a, [wMinigameHitStreak] ; $5c51
	add $85 ; $5c54
	ld e, a ; $5c56
	adc $5c ; $5c57
	sub e ; $5c59
	ld d, a ; $5c5a
	ld a, [de] ; $5c5b
	call MulHLByA ; $5c5c
	ld e, l ; $5c5f
	ld d, h ; $5c60
	ld hl, wScorePopupValue ; $5c61
	ld a, e ; $5c64
	ld [hl+], a ; $5c65
	ld [hl], d ; $5c66
	call AddToMinigameScore ; $5c67
	call StartScorePopup ; $5c6a
	ld b, $03 ; $5c6d
	call IncrementCappedCounter ; $5c6f
	ld a, $06 ; $5c72
	ld [wPointOutcome], a ; $5c74
	ld a, $01 ; $5c77
	ld [wPointOutcomeSide], a ; $5c79
	ret ; $5c7c
TreasureBoxValuesByType:
	; $5c7d, 4 bytes (bytes:4)
	db $05, $0a, $32, $64 ; 0x00
TreasureBoxHitStreakSounds:
	; $5c81, 4 bytes (bytes:4)
	db $c0, $be, $bc, $ba ; 0x00
TreasureBoxHitStreakMultipliers:
	; $5c85, 4 bytes (bytes:4)
	db $01, $02, $04, $08 ; 0x00
DrawTreasureBoxSprite:
	call ProjectTreasureBoxWorldPosition ; $5c89
	ld c, $30 ; $5c8c
	call QueueSprite16 ; $5c8e
	ld a, [wMinigameSceneActor + 1] ; $5c91
	ld b, a ; $5c94
	ld hl, wTreasureBoxState ; $5c95
	ld a, [hl] ; $5c98
	inc [hl] ; $5c99
	and $1f ; $5c9a
	add LOW(TreasureBoxSpriteAnimFrames) ; $5c9c
	ld l, a ; $5c9e
	adc HIGH(TreasureBoxSpriteAnimFrames) ; $5c9f
	sub l ; $5ca1
	ld h, a ; $5ca2
	ld a, [hl] ; $5ca3
	cp $ff ; $5ca4
	ret z ; $5ca6
	farcall LoadEffectFrameTiles_28 ; $5ca7
	ret ; $5caa
TreasureBoxSpriteAnimFrames:
	; $5cab, 32 bytes (bytes:8)
	db $00, $ff, $ff, $ff, $ff, $ff, $ff, $01 ; 0x00
	db $ff, $ff, $ff, $ff, $ff, $02, $ff, $ff ; 0x08
	db $ff, $ff, $ff, $ff, $03, $ff, $ff, $ff ; 0x10
	db $ff, $ff, $04, $ff, $ff, $ff, $ff, $ff ; 0x18
DrawTreasureBoxHitCountdown:
	call ProjectTreasureBoxWorldPosition ; $5ccb
	ld c, $3c ; $5cce
	ld a, [wMinigameSceneActor + 3] ; $5cd0
	call QueueMinigameHitBurstFirstFour ; $5cd3
	ret ; $5cd6
ProjectTreasureBoxWorldPosition:
	ld hl, wMinigameSceneActor + 10 ; $5cd7
	ld a, [hl+] ; $5cda
	ld e, a ; $5cdb
	ld a, [hl+] ; $5cdc
	ld d, a ; $5cdd
	ld a, [hl+] ; $5cde
	ld c, a ; $5cdf
	ld a, [hl+] ; $5ce0
	ld b, a ; $5ce1
	ld l, e ; $5ce2
	ld h, d ; $5ce3
	farcall ApplyCameraProjection ; $5ce4
	ld b, $0f ; $5ce7
	ret ; $5ce9
MinigameConfig_MedallionMatch:
	; $5cea, 16 bytes (bytes:16)
	db $17, $15, $02, $08, $23, $19, $00, $1b, $0c, $5d, $bd, $40, $fa, $5c, $00, $00 ; 0x00
InitMinigame_MedallionMatch:
	ld a, $01 ; $5cfa
	ld [wMinigameUsesTennisMachine], a ; $5cfc
	ld a, [wMinigameLevel] ; $5cff
	cp $02 ; $5d02
	jr nz, .done ; $5d04
	ld a, $01 ; $5d06
	ld [wMinigameHighScoreMode], a ; $5d08
.done:
	ret ; $5d0b
MinigameHooks_MedallionMatch:
	; $5d0c, 16 bytes (mode_hooks)
	dw MedallionMatchHook_PerFrame ; record 0
	dw MedallionMatchHook_PointStart ; record 1
	dw MedallionMatchHook_PointEnd ; record 2
	dw MedallionMatchHook_MinigameStart ; record 3
	dw MedallionMatchHook_BallHit ; record 4
	dw MedallionMatchHook_Bounce ; record 5
	dw MedallionMatchHook_RallyTick ; record 6
	dw MedallionMatchHook_Draw ; record 7
MedallionMatchHook_MinigameStart:
	call SpawnMedallionMatchTargets ; $5d1c
	ld a, $01 ; $5d1f
	ld [wMinigameServeSlot], a ; $5d21
	call StartMinigameMatch ; $5d24
	xor a ; $5d27
	ld [wStandingShadowsEnabled], a ; $5d28
	ret ; $5d2b
Unused_0d:
	; $5d2c, 6 bytes (records:2)
	dw $0064 ; record 0
	dw $012c ; record 1
	dw $270f ; record 2
MedallionMatchHook_PerFrame:
	call DrawMinigameScoreHud ; $5d32
	call UpdateScorePopup ; $5d35
	ret ; $5d38
MedallionMatchHook_Draw:
	call UpdateMinigameActors ; $5d39
	ret ; $5d3c
MedallionMatchHook_PointStart:
	farcall AdvanceMatchRng ; $5d3d
	and $01 ; $5d40
	inc a ; $5d42
	ld hl, wMinigameServeSlot ; $5d43
	add [hl] ; $5d46
	cp $03 ; $5d47
	jr c, .store ; $5d49
	sub $03 ; $5d4b
.store:
	ld [hl], a ; $5d4d
	call LaunchMinigameServe ; $5d4e
	call ResetMedallionMatchHitState ; $5d51
	ret ; $5d54
MedallionMatchHook_PointEnd:
	call EndMinigamePoint ; $5d55
	ret ; $5d58
MedallionMatchHook_RallyTick:
	call KeepMinigameCameraFixed ; $5d59
	ret ; $5d5c
MedallionMatchHook_Bounce:
	call CheckMinigameStartBannerTrigger ; $5d5d
	ret ; $5d60
MedallionMatchHook_BallHit:
	call FreezeMinigameOpponentOnReturn ; $5d61
	ret ; $5d64
SpawnMedallionMatchTargets:
	call ClearMinigameActors ; $5d65
	ld hl, $0040 ; $5d68
	ld de, rJOYP ; $5d6b
	ld bc, wMinigameActors ; $5d6e
	ld a, $00 ; $5d71
	call InitMedallionMatchTargetActor ; $5d73
	ld hl, $0080 ; $5d76
	ld de, $fe40 ; $5d79
	ld bc, wMinigameActors + 16 ; $5d7c
	ld a, $01 ; $5d7f
	call InitMedallionMatchTargetActor ; $5d81
	ld hl, $00c0 ; $5d84
	ld de, $fd80 ; $5d87
	ld bc, wMinigameActors + 32 ; $5d8a
	ld a, $02 ; $5d8d
	call InitMedallionMatchTargetActor ; $5d8f
	ld hl, $ffc0 ; $5d92
	ld de, rJOYP ; $5d95
	ld bc, wMinigameActors + 48 ; $5d98
	ld a, $03 ; $5d9b
	call InitMedallionMatchTargetActor ; $5d9d
	ld hl, $ff80 ; $5da0
	ld de, $fe40 ; $5da3
	ld bc, wMinigameActors + 64 ; $5da6
	ld a, $04 ; $5da9
	call InitMedallionMatchTargetActor ; $5dab
	ld hl, rLCDC ; $5dae
	ld de, $fd80 ; $5db1
	ld bc, wMinigameActors + 80 ; $5db4
	ld a, $05 ; $5db7
	call InitMedallionMatchTargetActor ; $5db9
	ret ; $5dbc
InitMedallionMatchTargetActor:
	push af ; $5dbd
	push bc ; $5dbe
	push de ; $5dbf
	push hl ; $5dc0
	ld de, MedallionMatchTargetActorHandler ; $5dc1
	call SetMinigameActorHandler ; $5dc4
	pop hl ; $5dc7
	pop de ; $5dc8
	pop bc ; $5dc9
	pop af ; $5dca
	push hl ; $5dcb
	ld hl, $0001 ; $5dcc
	add hl, bc ; $5dcf
	ld [hl], a ; $5dd0
	pop hl ; $5dd1
	call SetMinigameActorPosition ; $5dd2
	ret ; $5dd5
ResetMedallionMatchHitState:
	xor a ; $5dd6
	ld [wMinigameHitStreak], a ; $5dd7
	xor a ; $5dda
	ld [wMinigameActors + 2], a ; $5ddb
	ld [wMinigameActors + 18], a ; $5dde
	ld [wMinigameActors + 34], a ; $5de1
	ld [wMinigameActors + 50], a ; $5de4
	ld [wMinigameActors + 66], a ; $5de7
	ld [wMinigameActors + 82], a ; $5dea
	ret ; $5ded
MedallionMatchTargetActorHandler:
	ld a, [wMinigameSceneActor + 2] ; $5dee
	rst Rst00 ; $5df1
	dw AdvanceMedallionMatchActorState.advanceMedallionMatchActorState ; $5df2 jumptable
	dw AdvanceMedallionMatchActorState.drawMedallionMatchSprite ; $5df4 jumptable
	dw AdvanceMedallionMatchActorState.drawMedallionMatchHitCountdown ; $5df6 jumptable
	dw AdvanceMedallionMatchActorState.drawMedallionMatchSprite2 ; $5df8 jumptable
	dw RetStub ; $5dfa jumptable
AdvanceMedallionMatchActorState:
	ld hl, wMinigameSceneActor + 2 ; $5dfc
	inc [hl] ; $5dff
	ret ; $5e00
.advanceMedallionMatchActorState:
	call AdvanceMedallionMatchActorState ; $5e01
.drawMedallionMatchSprite:
	call DrawMedallionMatchSprite ; $5e04
	call IsBallInMedallionMatchHitZone ; $5e07
	and a ; $5e0a
	ret z ; $5e0b
	call AwardMedallionMatchHitScore ; $5e0c
	jp AdvanceMedallionMatchActorState ; $5e0f
.drawMedallionMatchHitCountdown:
	call DrawMedallionMatchHitCountdown ; $5e12
	ld hl, wMinigameSceneActor + 3 ; $5e15
	dec [hl] ; $5e18
	ld a, [hl] ; $5e19
	and a ; $5e1a
	ret nz ; $5e1b
	ld hl, wMinigameSceneActor + 8 ; $5e1c
	ld a, [hl+] ; $5e1f
	ld d, [hl] ; $5e20
	ld e, a ; $5e21
	farcall AdvanceMatchRng ; $5e22
	ld h, $00 ; $5e25
	ld l, a ; $5e27
	add hl, hl ; $5e28
	ld bc, $ff00 ; $5e29
	add hl, bc ; $5e2c
	call SetMinigameActorWorldPos ; $5e2d
	jp AdvanceMedallionMatchActorState ; $5e30
.drawMedallionMatchSprite2:
	call DrawMedallionMatchSprite ; $5e33
	ret ; $5e36
IsBallInMedallionMatchHitZone:
	ld a, [wLastShotCharIndex] ; $5e37
	and $01 ; $5e3a
	jp nz, .returnZero ; $5e3c
	ld hl, wMinigameSceneActor + 6 ; $5e3f
	ld a, [hl+] ; $5e42
	ld d, [hl] ; $5e43
	ld e, a ; $5e44
	ld hl, wBallX ; $5e45
	ld a, [hl+] ; $5e48
	ld h, [hl] ; $5e49
	ld l, a ; $5e4a
	ld a, l ; $5e4b
	sub e ; $5e4c
	ld l, a ; $5e4d
	ld a, h ; $5e4e
	sbc d ; $5e4f
	ld h, a ; $5e50
	bit 7, h ; $5e51
	jr z, .positive ; $5e53
	xor a ; $5e55
	sub l ; $5e56
	ld l, a ; $5e57
	sbc a ; $5e58
	sub h ; $5e59
	ld h, a ; $5e5a
.positive:
	ld de, $ffa0 ; $5e5b
	add hl, de ; $5e5e
	jr c, .returnZero ; $5e5f
	ld hl, wMinigameSceneActor + 8 ; $5e61
	ld a, [hl+] ; $5e64
	ld d, [hl] ; $5e65
	ld e, a ; $5e66
	ld hl, wBallDepth ; $5e67
	ld a, [hl+] ; $5e6a
	ld h, [hl] ; $5e6b
	ld l, a ; $5e6c
	ld a, l ; $5e6d
	sub e ; $5e6e
	ld l, a ; $5e6f
	ld a, h ; $5e70
	sbc d ; $5e71
	ld h, a ; $5e72
	bit 7, h ; $5e73
	jr z, .positive2 ; $5e75
	xor a ; $5e77
	sub l ; $5e78
	ld l, a ; $5e79
	sbc a ; $5e7a
	sub h ; $5e7b
	ld h, a ; $5e7c
.positive2:
	ld de, $ff80 ; $5e7d
	add hl, de ; $5e80
	jr c, .returnZero ; $5e81
	ld hl, wBallHeight ; $5e83
	ld a, [hl+] ; $5e86
	ld h, [hl] ; $5e87
	ld l, a ; $5e88
	bit 7, h ; $5e89
	jr z, .positive3 ; $5e8b
	xor a ; $5e8d
	sub l ; $5e8e
	ld l, a ; $5e8f
	sbc a ; $5e90
	sub h ; $5e91
	ld h, a ; $5e92
.positive3:
	ld de, $ff40 ; $5e93
	add hl, de ; $5e96
	jr c, .returnZero ; $5e97
	ld a, $01 ; $5e99
	ret ; $5e9b
.returnZero:
	xor a ; $5e9c
	ret ; $5e9d
AwardMedallionMatchHitScore:
	ld a, $10 ; $5e9e
	ld [wMinigameSceneActor + 3], a ; $5ea0
	ld hl, $0001 ; $5ea3
	ld a, [wCurrentShotType] ; $5ea6
	cp SHOTTYPE_SMASH ; $5ea9
	jr nz, .step ; $5eab
	ld a, $20 ; $5ead
	ld [wMinigameSceneActor + 3], a ; $5eaf
	ld hl, $0002 ; $5eb2
.step:
	ld a, [wMinigameHitStreak] ; $5eb5
	add $e4 ; $5eb8
	ld e, a ; $5eba
	adc $5e ; $5ebb
	sub e ; $5ebd
	ld d, a ; $5ebe
	ld a, [de] ; $5ebf
	call PlaySoundManaged ; $5ec0
	ld a, [wMinigameHitStreak] ; $5ec3
	add $ec ; $5ec6
	ld e, a ; $5ec8
	adc $5e ; $5ec9
	sub e ; $5ecb
	ld d, a ; $5ecc
	ld a, [de] ; $5ecd
	call MulHLByA ; $5ece
	ld e, l ; $5ed1
	ld d, h ; $5ed2
	ld hl, wScorePopupValue ; $5ed3
	ld a, e ; $5ed6
	ld [hl+], a ; $5ed7
	ld [hl], d ; $5ed8
	call AddToMinigameScore ; $5ed9
	call StartScorePopup ; $5edc
	ld hl, wMinigameHitStreak ; $5edf
	inc [hl] ; $5ee2
	ret ; $5ee3
MedallionMatchHitStreakSounds:
	; $5ee4, 8 bytes (bytes:8)
	db $c0, $bf, $be, $bd, $bc, $bb, $ba, $ba ; 0x00
MedallionMatchHitStreakMultipliers:
	; $5eec, 6 bytes (bytes:6)
	db $01, $05, $1e, $46, $96, $fa ; 0x00
DrawMedallionMatchSprite:
	call ProjectMedallionMatchWorldPosition ; $5ef2
	ldh a, [hVBlankCounter] ; $5ef5
	ld hl, wMinigameSceneActor + 10 ; $5ef7
	add [hl] ; $5efa
	srl a ; $5efb
	srl a ; $5efd
	srl a ; $5eff
	and $03 ; $5f01
	add LOW(MedallionMatchSpriteAnimFrames) ; $5f03
	ld l, a ; $5f05
	adc HIGH(MedallionMatchSpriteAnimFrames) ; $5f06
	sub l ; $5f08
	ld h, a ; $5f09
	ld c, [hl] ; $5f0a
	call QueueSprite16 ; $5f0b
	ret ; $5f0e
MedallionMatchSpriteAnimFrames:
	; $5f0f, 4 bytes (bytes:4)
	db $20, $24, $28, $2c ; 0x00
DrawMedallionMatchHitCountdown:
	call ProjectMedallionMatchWorldPosition ; $5f13
	ld c, $3c ; $5f16
	ld a, [wMinigameSceneActor + 3] ; $5f18
	call QueueMinigameHitBurstFirstTwo ; $5f1b
	ret ; $5f1e
ProjectMedallionMatchWorldPosition:
	ld hl, wMinigameSceneActor + 10 ; $5f1f
	ld a, [hl+] ; $5f22
	ld e, a ; $5f23
	ld a, [hl+] ; $5f24
	ld d, a ; $5f25
	ld a, [hl+] ; $5f26
	ld c, a ; $5f27
	ld a, [hl+] ; $5f28
	ld b, a ; $5f29
	ld l, e ; $5f2a
	ld h, d ; $5f2b
	farcall ApplyCameraProjection ; $5f2c
	ld b, $0f ; $5f2f
	ret ; $5f31
MinigameConfig_FruitFantasy:
	; $5f32, 16 bytes (bytes:16)
	db $00, $16, $01, $08, $20, $13, $00, $1c, $61, $5f, $b4, $40, $42, $5f, $00, $00 ; 0x00
InitMinigame_FruitFantasy:
	farcall InitMinigameTargets ; $5f42
	ld a, $06 ; $5f45
	farcall SpawnMinigameTargetFormation ; $5f47
	ld a, $01 ; $5f4a
	ld [wMinigameTargetsAltMode], a ; $5f4c
	ld a, $01 ; $5f4f
	ld [wMinigameUsesWall], a ; $5f51
	ld a, [wMinigameLevel] ; $5f54
	cp $02 ; $5f57
	jr nz, .done ; $5f59
	ld a, $01 ; $5f5b
	ld [wMinigameHighScoreMode], a ; $5f5d
.done:
	ret ; $5f60
MinigameHooks_FruitFantasy:
	; $5f61, 16 bytes (mode_hooks)
	dw FruitFantasyHook_PerFrame ; record 0
	dw FruitFantasyHook_PointStart ; record 1
	dw FruitFantasyHook_PointEnd ; record 2
	dw FruitFantasyHook_MinigameStart ; record 3
	dw FruitFantasyHook_BallHit ; record 4
	dw FruitFantasyHook_Bounce ; record 5
	dw FruitFantasyHook_RallyTick ; record 6
	dw RetStub ; record 7
FruitFantasyHook_MinigameStart:
	ret ; $5f71
FruitFantasyHook_PerFrame:
	call UpdateMinigameHudAndBallTrail ; $5f72
	call UpdateFruitFantasyTargetHits ; $5f75
	ret ; $5f78
FruitFantasyHook_PointStart:
	call StartMinigameSoloPoint ; $5f79
	ld a, [wMinigameLevel] ; $5f7c
	add a ; $5f7f
	add LOW(FruitFantasyGridLayoutsByLevel) ; $5f80
	ld l, a ; $5f82
	adc HIGH(FruitFantasyGridLayoutsByLevel) ; $5f83
	sub l ; $5f85
	ld h, a ; $5f86
	ld a, [hl+] ; $5f87
	ld h, [hl] ; $5f88
	ld l, a ; $5f89
	call CopyMinigameTilemapBlock ; $5f8a
	ret ; $5f8d
FruitFantasyGridLayoutsByLevel:
	; $5f8e, 6 bytes (records:2)
	dw FruitFantasyGridLayout0 ; record 0
	dw FruitFantasyGridLayout1 ; record 1
	dw FruitFantasyGridLayout2 ; record 2
FruitFantasyGridLayout0:
	; $5f94, 24 bytes (bytes:8)
	db $00, $00, $00, $00, $00, $00, $00, $00 ; 0x00
	db $00, $00, $00, $00, $00, $00, $00, $00 ; 0x08
	db $00, $00, $00, $00, $00, $00, $00, $00 ; 0x10
FruitFantasyGridLayout1:
	; $5fac, 24 bytes (bytes:8)
	db $00, $00, $05, $05, $00, $06, $00, $00 ; 0x00
	db $00, $00, $00, $00, $00, $00, $00, $00 ; 0x08
	db $00, $04, $00, $07, $07, $00, $00, $00 ; 0x10
FruitFantasyGridLayout2:
	; $5fc4, 24 bytes (bytes:8)
	db $00, $04, $04, $00, $06, $06, $00, $00 ; 0x00
	db $07, $00, $00, $05, $00, $00, $07, $00 ; 0x08
	db $00, $07, $07, $00, $07, $07, $00, $00 ; 0x10
FruitFantasyHook_PointEnd:
	call HandleMinigamePointEnd ; $5fdc
	ret ; $5fdf
FruitFantasyHook_RallyTick:
	call FruitFantasyReflectBallAndRecordCell ; $5fe0
	ret ; $5fe3
FruitFantasyHook_Bounce:
	call StubNop_0d_0 ; $5fe4
	ret ; $5fe7
FruitFantasyHook_BallHit:
	call HideLandingMarkerAndExtendSoloCourt ; $5fe8
	ret ; $5feb
UpdateFruitFantasyTargetHits:
	call ScoreMinigameTargetHitOrDeflectBall ; $5fec
	ret ; $5fef
FruitFantasyReflectBallAndRecordCell:
	call ReflectBallVelocity ; $5ff0
	call GetMinigameGridCellIndex ; $5ff3
	ld [wMinigameLastHitCell], a ; $5ff6
	ret ; $5ff9
	; $5ffa, 8198 bytes fill to bank end (linker-padded)
