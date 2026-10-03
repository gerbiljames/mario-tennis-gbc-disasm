	farptr StartMinigameByID ; $4000
	farptr GetDefaultMinigameRecordValue ; $4002
	farptr ShowMinigamePointResult ; $4004
; Instruction-identical to StartDrillFromDefinition (one copy per bank); a change here belongs in every copy.
	twin_named start_drill_from_definition, InitMinigameFromConfig ; $4006
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
	ld_hl_indexed MinigameRecordSlotIds ; $40f0
	ld a, [hl] ; $40f7
	farcall ReadMinigameRecord ; $40f8
	push_wram_bank WRAM_SOUND ; $40fb
	ld hl, wMinigameRecordValue ; $4104
	ld de, wMinigameHighScore ; $4107
	ld a, [hl+] ; $410a
	ld [de], a ; $410b
	inc de ; $410c
	ld a, [hl+] ; $410d
	ld [de], a ; $410e
	inc de ; $410f
	pop_wram_bank ; $4110
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
	ld_hl_indexed MinigamePracticeTargetScores ; $412e
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
	ld_hl_indexed MinigameTargetScores ; $413f
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
	ld_hl_indexed MinigameDefaultRecordValuePointers ; $41a7
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
	push_wram_bank WRAM_ACTORS ; $4211
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
	pop_wram_bank ; $422c
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
	push_wram_bank WRAM_ACTORS ; $42bf
	ld hl, wBallHistory + 30 ; $42c8
	ld a, [hl+] ; $42cb
	ld d, [hl] ; $42cc
	ld e, a ; $42cd
	ld hl, wBallHistory + 32 ; $42ce
	ld a, [hl+] ; $42d1
	ld b, [hl] ; $42d2
	ld c, a ; $42d3
	pop_wram_bank ; $42d4
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
	ld_hl_indexed MinigameGridCellTilemapOffsets ; $431c
	ld a, [hl+] ; $4323
	ld d, [hl] ; $4324
	ld e, a ; $4325
	ld a, b ; $4326
	add a ; $4327
	add a ; $4328
	ld_hl_indexed MinigameGridCellAttrs ; $4329
	push hl ; $4330
	push hl ; $4331
	ld a, b ; $4332
	add a ; $4333
	add a ; $4334
	ld_hl_indexed MinigameGridCellTiles ; $4335
	push hl ; $433c
	push hl ; $433d
	pop hl ; $433e
	push de ; $433f
	ld a, d ; $4340
	add $d8 ; $4341
	ld d, a ; $4343
	ld_size bc, $02, $02 ; $4344
	call CopyTextRect ; $4347
	pop de ; $434a
	pop hl ; $434b
	push de ; $434c
	ld a, d ; $434d
	add $d0 ; $434e
	ld d, a ; $4350
	ld_size bc, $02, $02 ; $4351
	call CopyTextRect ; $4354
	pop de ; $4357
	pop hl ; $4358
	push de ; $4359
	ld a, d ; $435a
	add $dc ; $435b
	ld d, a ; $435d
	ld_size bc, $02, $02 ; $435e
	call CopyTextRect ; $4361
	pop de ; $4364
	pop hl ; $4365
	push de ; $4366
	ld a, d ; $4367
	add $d4 ; $4368
	ld d, a ; $436a
	ld_size bc, $02, $02 ; $436b
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
	ld hl, wCourtTilemap + 9 * TILEMAP_WIDTH ; $43a3
	ld de, vBGMap0 + 9 * TILEMAP_WIDTH ; $43a6
	ld c, 5 * TILEMAP_WIDTH / 16 ; $43a9
	call QueueVRAMCopy ; $43ab
	ld hl, wCourtAttrmap + 9 * TILEMAP_WIDTH ; $43ae
	ld de, vBGMap0 + 9 * TILEMAP_WIDTH + VRAM_BANK1 ; $43b1
	ld c, 5 * TILEMAP_WIDTH / 16 ; $43b4
	call QueueVRAMCopy ; $43b6
	ret ; $43b9
