SECTION "ROM Bank $10", ROMX[$4000], BANK[$10]

DataPtr_10_00:
	dw Data_10_4010 ; $4000
DataPtr_10_02:
	dw Data_10_468d ; $4002
DataPtr_10_04:
	dw Data_10_4ccb ; $4004
DataPtr_MatchSelectHandlersA_10:
	dw MatchSelectHandlersA_10 ; $4006
DataPtr_10_08:
	dw Data_10_57f6 ; $4008
DataPtr_10_0a:
	dw Data_10_5a80 ; $400a
DataPtr_10_0c:
	dw Data_10_61b1 ; $400c
DataPtr_10_0e:
	dw Data_10_74a9 ; $400e
Data_10_4010:
	; $4010, 16 bytes (records:2)
; 8 records x 2 bytes
	dw $40a6 ; record 0
	dw $40af ; record 1
	dw $401e ; record 2
	dw $4145 ; record 3
	dw $418e ; record 4
	dw $418f ; record 5
	dw $4190 ; record 6
	dw $0000 ; record 7
MatchSelectEntries_10:
	; $4020, 126 bytes (bytes:14)
	db $d1, $7b, $00, $07, $00, $11, $40, $00, $49, $01, $00, $00, $00, $00 ; 0x00
	db $d1, $7b, $00, $07, $00, $07, $80, $00, $46, $01, $03, $00, $00, $00 ; 0x0e
	db $d1, $7b, $00, $0d, $00, $07, $80, $00, $47, $01, $03, $00, $00, $00 ; 0x1c
	db $d1, $7b, $00, $07, $00, $0b, $40, $00, $54, $01, $03, $00, $00, $00 ; 0x2a
	db $d1, $7b, $00, $0d, $00, $0b, $40, $00, $55, $01, $03, $00, $00, $00 ; 0x38
	db $d1, $7b, $00, $0d, $00, $11, $40, $00, $6c, $01, $05, $00, $00, $00 ; 0x46
	db $d1, $7b, $00, $05, $00, $0e, $40, $00, $43, $01, $03, $00, $00, $00 ; 0x54
	db $d1, $7b, $00, $11, $00, $0e, $40, $00, $43, $01, $03, $00, $00, $00 ; 0x62
	db $d1, $7b, $00, $11, $00, $0c, $40, $00, $43, $01, $03, $00, $00, $00 ; 0x70
MatchSelectRecordsTail_10:
	; $409e, 18 bytes (bytes:16)
	db $00, $00, $00, $00, $00, $00, $00, $ff, $01, $c0, $00, $0a, $00, $09, $00, $00 ; 0x00
	db $ff, $ff ; 0x10
Func_10_40b0:
	farcall FarPtr_0a_00 ; $40b0
	ld c, $10 ; $40b3
	call BeginFadeOut ; $40b5
	call WaitFadeEnd ; $40b8
	ld b, $00 ; $40bb
	farcall FarPtr_38_00 ; $40bd
	ld c, $10 ; $40c0
	call BeginFadeOut ; $40c2
	call WaitFadeEnd ; $40c5
	farcall FarPtr_0a_68 ; $40c8
	call DisableLCDSafely ; $40cb
	farcall FarPtr_01_0a ; $40ce
	call EnableLCD ; $40d1
	ld hl, wStoryModePlayersXPosition ; $40d4
	ld de, $c296 ; $40d7
	ld bc, $0005 ; $40da
	call CopyMemoryBC ; $40dd
	ld a, $ff ; $40e0
	ld [$c295], a ; $40e2
	ld [$c294], a ; $40e5
	ld [$c2a1], a ; $40e8
	farcall FarPtr_0a_02 ; $40eb
	ret ; $40ee
Func_10_40ef:
	farcall FarPtr_0a_00 ; $40ef
	farcall FarPtr_03_36 ; $40f2
	call WaitFramesCmd ; $40f5
	db $3c ; $40f8 inline arg
	call EnableLCD ; $40f9
	farcall FarPtr_03_38 ; $40fc
	ld c, $04 ; $40ff
	call BeginFadeIn ; $4101
	call WaitFadeEnd ; $4104
	sound $14 ; $4107
	ld a, $01 ; $4109
	ld hl, $4141 ; $410b
	call RegisterFrameTask ; $410e
	call WaitFramesCmd ; $4111
	db $78 ; $4114 inline arg
	call WaitFramesCmd ; $4115
	db $ff ; $4118 inline arg
	call WaitFramesCmd ; $4119
	db $ff ; $411c inline arg
	call WaitFramesCmd ; $411d
	db $ff ; $4120 inline arg
	call WaitFramesCmd ; $4121
	db $ff ; $4124 inline arg
	call WaitFramesCmd ; $4125
	db $ff ; $4128 inline arg
	call WaitFramesCmd ; $4129
	db $ff ; $412c inline arg
	ld hl, $4141 ; $412d
	call UnregisterFrameTask ; $4130
	farcall FarPtr_0a_02 ; $4133
	ret ; $4136
Func_10_4137:
	farcall FarPtr_0a_00 ; $4137
	farcall FarPtr_0a_a2 ; $413a
	farcall FarPtr_0a_02 ; $413d
	ret ; $4140
	farcall FarPtr_03_3a ; $4141
	ret ; $4144
MatchSelectHandlerTable_10:
	; $4145, 75 bytes (records:8)
; 9 records x 8 bytes
	dw $ff03, $0000, $40b0, $0000 ; record 0
	dw $ff04, $0000, $4195, $0000 ; record 1
	dw $ff05, $0000, $41da, $0000 ; record 2
	dw $ff06, $0000, $4450, $0000 ; record 3
	dw $ff07, $0000, $448d, $0000 ; record 4
	dw $ff08, $0000, $44cc, $0000 ; record 5
	dw $ff09, $0000, $4640, $0000 ; record 6
	dw $ff0a, $0000, $40ef, $0000 ; record 7
	dw $ff0b, $0000, $4137, $0000 ; record 8
	db $ff, $ff, $ff
Func_10_4190:
	xor a, a ; $4190
	ld [$c2d5], a ; $4191
	ret ; $4194
RunSinglesMatchListMenu:
	ld hl, $0484 ; $4195
	ld de, $0101 ; $4198
	ld a, $05 ; $419b
	farcall FarPtr_RunPagedTextMenu ; $419d
	cp a, $ff ; $41a0
	jp z, Label_10_421f ; $41a2
	ld [$c2b0], a ; $41a5
	ld hl, wStoryModePlayersXPosition ; $41a8
	ld de, $c296 ; $41ab
	ld bc, $0005 ; $41ae
	call CopyMemoryBC ; $41b1
	ld a, $ff ; $41b4
	ld [$c295], a ; $41b6
	ld [$c294], a ; $41b9
	ld [$c2a1], a ; $41bc
	farcall FarPtr_InitStoryMatchSettings ; $41bf
	ld a, [$c2b0] ; $41c2
	add a, a ; $41c5
	add a, $20 ; $41c6
	ld l, a ; $41c8
	adc a, $42 ; $41c9
	sub a, l ; $41cb
	ld h, a ; $41cc
	ld a, [hl+] ; $41cd
	ld h, [hl] ; $41ce
	ld l, a ; $41cf
	call JumpToHL ; $41d0
	farcall FarPtr_0a_4c ; $41d3
	farcall FarPtr_0a_4e ; $41d6
	ret ; $41d9
RunDoublesMatchListMenu:
	ld hl, $0489 ; $41da
	ld de, $0101 ; $41dd
	ld a, $04 ; $41e0
	farcall FarPtr_RunPagedTextMenu ; $41e2
	cp a, $ff ; $41e5
	jp z, Label_10_421f ; $41e7
	ld [$c2b0], a ; $41ea
	ld hl, wStoryModePlayersXPosition ; $41ed
	ld de, $c296 ; $41f0
	ld bc, $0005 ; $41f3
	call CopyMemoryBC ; $41f6
	ld a, $ff ; $41f9
	ld [$c295], a ; $41fb
	ld [$c294], a ; $41fe
	ld [$c2a1], a ; $4201
	farcall FarPtr_InitStoryMatchSettings ; $4204
	ld a, [$c2b0] ; $4207
	add a, a ; $420a
	add a, $46 ; $420b
	ld l, a ; $420d
	adc a, $42 ; $420e
	sub a, l ; $4210
	ld h, a ; $4211
	ld a, [hl+] ; $4212
	ld h, [hl] ; $4213
	ld l, a ; $4214
	call JumpToHL ; $4215
	farcall FarPtr_0a_4c ; $4218
	farcall FarPtr_0a_4e ; $421b
	ret ; $421e
Label_10_421f:
	ret ; $421f
	dw Func_10_4354 ; $4220
	dw Func_10_4346 ; $4222
	dw Func_10_4338 ; $4224
	dw Func_10_432a ; $4226
	dw Func_10_438c ; $4228
	dw Func_10_437e ; $422a
	dw Func_10_4370 ; $422c
	dw Func_10_4362 ; $422e
	dw Func_10_43a8 ; $4230
	dw Func_10_431c ; $4232
	dw Func_10_439a ; $4234
	dw Func_10_43b6 ; $4236
	dw Func_10_42ba ; $4238
	dw Func_10_42c8 ; $423a
	dw Func_10_42d6 ; $423c
	dw Func_10_42e4 ; $423e
	dw Func_10_4266 ; $4240
	dw Func_10_4274 ; $4242
	dw Func_10_4282 ; $4244
	dw Func_10_43d2 ; $4246
	dw Func_10_43e0 ; $4248
	dw Func_10_43ee ; $424a
	dw Func_10_43c4 ; $424c
	dw Func_10_440a ; $424e
	dw Func_10_4418 ; $4250
	dw Func_10_4426 ; $4252
	dw Func_10_43fc ; $4254
	dw Func_10_4434 ; $4256
	dw Func_10_4442 ; $4258
	dw Func_10_42f2 ; $425a
	dw Func_10_4300 ; $425c
	dw Func_10_430e ; $425e
	dw Func_10_4290 ; $4260
	dw Func_10_429e ; $4262
	dw Func_10_42ac ; $4264
Func_10_4266:
	ld a, $00 ; $4266
	ld [wCurrentMinigameStoryMatch], a ; $4268
	ld a, $18 ; $426b
	ld [$c8f7], a ; $426d
	farcall FarPtr_LoadMatchSettingsFromTable ; $4270
	ret ; $4273
Func_10_4274:
	ld a, $00 ; $4274
	ld [wCurrentMinigameStoryMatch], a ; $4276
	ld a, $17 ; $4279
	ld [$c8f7], a ; $427b
	farcall FarPtr_LoadMatchSettingsFromTable ; $427e
	ret ; $4281
Func_10_4282:
	ld a, $00 ; $4282
	ld [wCurrentMinigameStoryMatch], a ; $4284
	ld a, $16 ; $4287
	ld [$c8f7], a ; $4289
	farcall FarPtr_LoadMatchSettingsFromTable ; $428c
	ret ; $428f
Func_10_4290:
	ld a, $01 ; $4290
	ld [wCurrentMinigameStoryMatch], a ; $4292
	ld a, $18 ; $4295
	ld [$c8f7], a ; $4297
	farcall FarPtr_LoadMatchSettingsFromTable ; $429a
	ret ; $429d
Func_10_429e:
	ld a, $01 ; $429e
	ld [wCurrentMinigameStoryMatch], a ; $42a0
	ld a, $17 ; $42a3
	ld [$c8f7], a ; $42a5
	farcall FarPtr_LoadMatchSettingsFromTable ; $42a8
	ret ; $42ab
Func_10_42ac:
	ld a, $01 ; $42ac
	ld [wCurrentMinigameStoryMatch], a ; $42ae
	ld a, $16 ; $42b1
	ld [$c8f7], a ; $42b3
	farcall FarPtr_LoadMatchSettingsFromTable ; $42b6
	ret ; $42b9
Func_10_42ba:
	ld a, $00 ; $42ba
	ld [wCurrentMinigameStoryMatch], a ; $42bc
	ld a, $10 ; $42bf
	ld [$c8f7], a ; $42c1
	farcall FarPtr_LoadMatchSettingsFromTable ; $42c4
	ret ; $42c7
Func_10_42c8:
	ld a, $00 ; $42c8
	ld [wCurrentMinigameStoryMatch], a ; $42ca
	ld a, $11 ; $42cd
	ld [$c8f7], a ; $42cf
	farcall FarPtr_LoadMatchSettingsFromTable ; $42d2
	ret ; $42d5
Func_10_42d6:
	ld a, $00 ; $42d6
	ld [wCurrentMinigameStoryMatch], a ; $42d8
	ld a, $12 ; $42db
	ld [$c8f7], a ; $42dd
	farcall FarPtr_LoadMatchSettingsFromTable ; $42e0
	ret ; $42e3
Func_10_42e4:
	ld a, $00 ; $42e4
	ld [wCurrentMinigameStoryMatch], a ; $42e6
	ld a, $13 ; $42e9
	ld [$c8f7], a ; $42eb
	farcall FarPtr_LoadMatchSettingsFromTable ; $42ee
	ret ; $42f1
Func_10_42f2:
	ld a, $01 ; $42f2
	ld [wCurrentMinigameStoryMatch], a ; $42f4
	ld a, $11 ; $42f7
	ld [$c8f7], a ; $42f9
	farcall FarPtr_LoadMatchSettingsFromTable ; $42fc
	ret ; $42ff
Func_10_4300:
	ld a, $01 ; $4300
	ld [wCurrentMinigameStoryMatch], a ; $4302
	ld a, $12 ; $4305
	ld [$c8f7], a ; $4307
	farcall FarPtr_LoadMatchSettingsFromTable ; $430a
	ret ; $430d
Func_10_430e:
	ld a, $01 ; $430e
	ld [wCurrentMinigameStoryMatch], a ; $4310
	ld a, $13 ; $4313
	ld [$c8f7], a ; $4315
	farcall FarPtr_LoadMatchSettingsFromTable ; $4318
	ret ; $431b
Func_10_431c:
	ld a, $00 ; $431c
	ld [wCurrentMinigameStoryMatch], a ; $431e
	ld a, $00 ; $4321
	ld [$c8f7], a ; $4323
	farcall FarPtr_LoadMatchSettingsFromTable ; $4326
	ret ; $4329
Func_10_432a:
	ld a, $00 ; $432a
	ld [wCurrentMinigameStoryMatch], a ; $432c
	ld a, $04 ; $432f
	ld [$c8f7], a ; $4331
	farcall FarPtr_LoadMatchSettingsFromTable ; $4334
	ret ; $4337
Func_10_4338:
	ld a, $00 ; $4338
	ld [wCurrentMinigameStoryMatch], a ; $433a
	ld a, $03 ; $433d
	ld [$c8f7], a ; $433f
	farcall FarPtr_LoadMatchSettingsFromTable ; $4342
	ret ; $4345
Func_10_4346:
	ld a, $00 ; $4346
	ld [wCurrentMinigameStoryMatch], a ; $4348
	ld a, $02 ; $434b
	ld [$c8f7], a ; $434d
	farcall FarPtr_LoadMatchSettingsFromTable ; $4350
	ret ; $4353
Func_10_4354:
	ld a, $00 ; $4354
	ld [wCurrentMinigameStoryMatch], a ; $4356
	ld a, $01 ; $4359
	ld [$c8f7], a ; $435b
	farcall FarPtr_LoadMatchSettingsFromTable ; $435e
	ret ; $4361
Func_10_4362:
	ld a, $00 ; $4362
	ld [wCurrentMinigameStoryMatch], a ; $4364
	ld a, $09 ; $4367
	ld [$c8f7], a ; $4369
	farcall FarPtr_LoadMatchSettingsFromTable ; $436c
	ret ; $436f
Func_10_4370:
	ld a, $00 ; $4370
	ld [wCurrentMinigameStoryMatch], a ; $4372
	ld a, $08 ; $4375
	ld [$c8f7], a ; $4377
	farcall FarPtr_LoadMatchSettingsFromTable ; $437a
	ret ; $437d
Func_10_437e:
	ld a, $00 ; $437e
	ld [wCurrentMinigameStoryMatch], a ; $4380
	ld a, $07 ; $4383
	ld [$c8f7], a ; $4385
	farcall FarPtr_LoadMatchSettingsFromTable ; $4388
	ret ; $438b
Func_10_438c:
	ld a, $00 ; $438c
	ld [wCurrentMinigameStoryMatch], a ; $438e
	ld a, $06 ; $4391
	ld [$c8f7], a ; $4393
	farcall FarPtr_LoadMatchSettingsFromTable ; $4396
	ret ; $4399
Func_10_439a:
	ld a, $00 ; $439a
	ld [wCurrentMinigameStoryMatch], a ; $439c
	ld a, $05 ; $439f
	ld [$c8f7], a ; $43a1
	farcall FarPtr_LoadMatchSettingsFromTable ; $43a4
	ret ; $43a7
Func_10_43a8:
	ld a, $00 ; $43a8
	ld [wCurrentMinigameStoryMatch], a ; $43aa
	ld a, $02 ; $43ad
	ld [$c8f7], a ; $43af
	farcall FarPtr_LoadMatchSettingsFromTable ; $43b2
	ret ; $43b5
Func_10_43b6:
	ld a, $00 ; $43b6
	ld [wCurrentMinigameStoryMatch], a ; $43b8
	ld a, $0a ; $43bb
	ld [$c8f7], a ; $43bd
	farcall FarPtr_LoadMatchSettingsFromTable ; $43c0
	ret ; $43c3
Func_10_43c4:
	ld a, $01 ; $43c4
	ld [wCurrentMinigameStoryMatch], a ; $43c6
	ld a, $00 ; $43c9
	ld [$c8f7], a ; $43cb
	farcall FarPtr_LoadMatchSettingsFromTable ; $43ce
	ret ; $43d1
Func_10_43d2:
	ld a, $01 ; $43d2
	ld [wCurrentMinigameStoryMatch], a ; $43d4
	ld a, $02 ; $43d7
	ld [$c8f7], a ; $43d9
	farcall FarPtr_LoadMatchSettingsFromTable ; $43dc
	ret ; $43df
Func_10_43e0:
	ld a, $01 ; $43e0
	ld [wCurrentMinigameStoryMatch], a ; $43e2
	ld a, $03 ; $43e5
	ld [$c8f7], a ; $43e7
	farcall FarPtr_LoadMatchSettingsFromTable ; $43ea
	ret ; $43ed
Func_10_43ee:
	ld a, $01 ; $43ee
	ld [wCurrentMinigameStoryMatch], a ; $43f0
	ld a, $04 ; $43f3
	ld [$c8f7], a ; $43f5
	farcall FarPtr_LoadMatchSettingsFromTable ; $43f8
	ret ; $43fb
Func_10_43fc:
	ld a, $01 ; $43fc
	ld [wCurrentMinigameStoryMatch], a ; $43fe
	ld a, $05 ; $4401
	ld [$c8f7], a ; $4403
	farcall FarPtr_LoadMatchSettingsFromTable ; $4406
	ret ; $4409
Func_10_440a:
	ld a, $01 ; $440a
	ld [wCurrentMinigameStoryMatch], a ; $440c
	ld a, $07 ; $440f
	ld [$c8f7], a ; $4411
	farcall FarPtr_LoadMatchSettingsFromTable ; $4414
	ret ; $4417
Func_10_4418:
	ld a, $01 ; $4418
	ld [wCurrentMinigameStoryMatch], a ; $441a
	ld a, $08 ; $441d
	ld [$c8f7], a ; $441f
	farcall FarPtr_LoadMatchSettingsFromTable ; $4422
	ret ; $4425
Func_10_4426:
	ld a, $01 ; $4426
	ld [wCurrentMinigameStoryMatch], a ; $4428
	ld a, $09 ; $442b
	ld [$c8f7], a ; $442d
	farcall FarPtr_LoadMatchSettingsFromTable ; $4430
	ret ; $4433
Func_10_4434:
	ld a, $01 ; $4434
	ld [wCurrentMinigameStoryMatch], a ; $4436
	ld a, $0d ; $4439
	ld [$c8f7], a ; $443b
	farcall FarPtr_LoadMatchSettingsFromTable ; $443e
	ret ; $4441
Func_10_4442:
	ld a, $01 ; $4442
	ld [wCurrentMinigameStoryMatch], a ; $4444
	ld a, $0a ; $4447
	ld [$c8f7], a ; $4449
	farcall FarPtr_LoadMatchSettingsFromTable ; $444c
	ret ; $444f
RunDrillMatchListMenu:
	ld hl, $048d ; $4450
	ld a, $09 ; $4453
	farcall FarPtr_RunPagedTextMenu ; $4455
	cp a, $ff ; $4458
	jp z, Label_10_421f ; $445a
	push af ; $445d
	ld hl, wStoryModePlayersXPosition ; $445e
	ld de, $c296 ; $4461
	ld bc, $0005 ; $4464
	call CopyMemoryBC ; $4467
	ld a, $ff ; $446a
	ld [$c295], a ; $446c
	ld [$c294], a ; $446f
	ld [$c2a1], a ; $4472
	ld a, $00 ; $4475
	ld [$c36c], a ; $4477
	farcall FarPtr_CheckStorySlot ; $447a
	pop af ; $447d
	set_flag $03, 6 ; $447e
	farcall FarPtr_0b_00 ; $4481
	ld a, $00 ; $4484
	ld [$c36c], a ; $4486
	farcall FarPtr_03_18 ; $4489
	ret ; $448c
	ld hl, $28a4 ; $448d
	farcall FarPtr_InitDialogueTextCursor ; $4490
	ld a, $80 ; $4493
	farcall FarPtr_ScriptShowSpeakerDialogue ; $4495
	ret ; $4498
	ld hl, wStoryModePlayersXPosition ; $4499
	ld de, $c296 ; $449c
	ld bc, $0005 ; $449f
	call CopyMemoryBC ; $44a2
	ld a, $ff ; $44a5
	ld [$c295], a ; $44a7
	ld [$c294], a ; $44aa
	ld [$c2a1], a ; $44ad
	ld a, $00 ; $44b0
	ld [$c36c], a ; $44b2
	farcall FarPtr_CheckStorySlot ; $44b5
	set_flag $03, 4 ; $44b8
	ld c, $00 ; $44bb
	farcall FarPtr_1c_00 ; $44bd
	clear_flag $03, 4 ; $44c0
	ld a, $00 ; $44c3
	ld [$c36c], a ; $44c5
	farcall FarPtr_03_18 ; $44c8
	ret ; $44cb
RunLessonSelectMenu:
	call ClearFrameTasks ; $44cc
	ld b, $00 ; $44cf
	ld c, $02 ; $44d1
	ld d, $03 ; $44d3
	farcall FarPtr_1b_1a ; $44d5
	ld b, $01 ; $44d8
	ld c, $02 ; $44da
	ld d, $03 ; $44dc
	farcall FarPtr_1b_1a ; $44de
	ldh a, [hWramBank] ; $44e1
	push af ; $44e3
	wram_bank $07 ; $44e4
	ld de, $0000 ; $44ea
	ld hl, $de00 ; $44ed
	ld a, [hl+] ; $44f0
	ld d, [hl] ; $44f1
	ld e, a ; $44f2
	ld a, $01 ; $44f3
	farcall FarPtr_03_2a ; $44f5
	ld a, $00 ; $44f8
	farcall FarPtr_03_2a ; $44fa
	pop af ; $44fd
	wram_bank ; $44fe
	ld l, c ; $4502
	ld h, b ; $4503
	ld a, l ; $4504
	sub a, e ; $4505
	ld l, a ; $4506
	ld a, h ; $4507
	sbc a, d ; $4508
	ld h, a ; $4509
	ld hl, $1c0c ; $450a
	ld de, $0101 ; $450d
	ld a, $01 ; $4510
	farcall FarPtr_RunPagedTextMenu ; $4512
	cp a, $ff ; $4515
	jp z, Label_10_421f ; $4517
	ld a, a ; $451a
	rst Rst00 ; $451b
	dw RunServiceLessonMenu ; $451c jumptable
	dw RunNetLessonMenu ; $451e jumptable
	dw RunStrokeLessonMenu ; $4520 jumptable
	dw Label_10_45cc ; $4522 jumptable
RunServiceLessonMenu:
	ld hl, $1c0d ; $4524
	ld de, $0101 ; $4527
	ld a, $01 ; $452a
	farcall FarPtr_RunPagedTextMenu ; $452c
	cp a, $ff ; $452f
	jp z, Label_10_421f ; $4531
	add a, $03 ; $4534
	ld [$c8f7], a ; $4536
	ld hl, wStoryModePlayersXPosition ; $4539
	ld de, $c296 ; $453c
	ld bc, $0005 ; $453f
	call CopyMemoryBC ; $4542
	ld a, $ff ; $4545
	ld [$c295], a ; $4547
	ld [$c294], a ; $454a
	ld [$c2a1], a ; $454d
	ld c, $10 ; $4550
	call BeginFadeOut ; $4552
	call WaitFadeEnd ; $4555
	farcall FarPtr_17_0a ; $4558
	ret ; $455b
RunNetLessonMenu:
	ld hl, $1c0e ; $455c
	ld de, $0101 ; $455f
	ld a, $01 ; $4562
	farcall FarPtr_RunPagedTextMenu ; $4564
	cp a, $ff ; $4567
	jp z, Label_10_421f ; $4569
	add a, $09 ; $456c
	ld [$c8f7], a ; $456e
	ld hl, wStoryModePlayersXPosition ; $4571
	ld de, $c296 ; $4574
	ld bc, $0005 ; $4577
	call CopyMemoryBC ; $457a
	ld a, $ff ; $457d
	ld [$c295], a ; $457f
	ld [$c294], a ; $4582
	ld [$c2a1], a ; $4585
	ld c, $10 ; $4588
	call BeginFadeOut ; $458a
	call WaitFadeEnd ; $458d
	farcall FarPtr_17_0a ; $4590
	ret ; $4593
RunStrokeLessonMenu:
	ld hl, $1c0f ; $4594
	ld de, $0101 ; $4597
	ld a, $01 ; $459a
	farcall FarPtr_RunPagedTextMenu ; $459c
	cp a, $ff ; $459f
	jp z, Label_10_421f ; $45a1
	add a, $0f ; $45a4
	ld [$c8f7], a ; $45a6
	ld hl, wStoryModePlayersXPosition ; $45a9
	ld de, $c296 ; $45ac
	ld bc, $0005 ; $45af
	call CopyMemoryBC ; $45b2
	ld a, $ff ; $45b5
	ld [$c295], a ; $45b7
	ld [$c294], a ; $45ba
	ld [$c2a1], a ; $45bd
	ld c, $10 ; $45c0
	call BeginFadeOut ; $45c2
	call WaitFadeEnd ; $45c5
	farcall FarPtr_17_0a ; $45c8
	ret ; $45cb
Label_10_45cc:
	ld hl, wStoryModePlayersXPosition ; $45cc
	ld de, $c296 ; $45cf
	ld bc, $0005 ; $45d2
	call CopyMemoryBC ; $45d5
	ld a, $ff ; $45d8
	ld [$c295], a ; $45da
	ld [$c294], a ; $45dd
	ld [$c2a1], a ; $45e0
	ld c, $10 ; $45e3
	call BeginFadeOut ; $45e5
	call WaitFadeEnd ; $45e8
	call ClearFrameTasks ; $45eb
	xor a, a ; $45ee
	ldh [hBGColumnBlitPending], a ; $45ef
	ldh [hBGRowBlitPending], a ; $45f1
	ldh [hScrollY], a ; $45f3
	ldh [hScrollX], a ; $45f5
	ld [$c321], a ; $45f7
	ld [$c323], a ; $45fa
	call ClearFrameTasks ; $45fd
	ld b, $00 ; $4600
	ld c, $01 ; $4602
	ld d, $00 ; $4604
	farcall FarPtr_1b_1a ; $4606
	xor a, a ; $4609
	ldh [hBGColumnBlitPending], a ; $460a
	ldh [hBGRowBlitPending], a ; $460c
	ldh [hScrollY], a ; $460e
	ldh [hScrollX], a ; $4610
	ld [$c321], a ; $4612
	ld [$c323], a ; $4615
	call ClearFrameTasks ; $4618
	ld b, $00 ; $461b
	ld c, $02 ; $461d
	ld d, $00 ; $461f
	farcall FarPtr_1b_1a ; $4621
	xor a, a ; $4624
	ldh [hBGColumnBlitPending], a ; $4625
	ldh [hBGRowBlitPending], a ; $4627
	ldh [hScrollY], a ; $4629
	ldh [hScrollX], a ; $462b
	ld [$c321], a ; $462d
	ld [$c323], a ; $4630
	call ClearFrameTasks ; $4633
	ld b, $00 ; $4636
	ld c, $03 ; $4638
	ld d, $00 ; $463a
	farcall FarPtr_1b_1a ; $463c
	ret ; $463f
RunMinigameSelectMenu:
	ld hl, $0496 ; $4640
	ld a, $03 ; $4643
	farcall FarPtr_RunPagedTextMenu ; $4645
	cp a, $ff ; $4648
	jp z, Label_10_421f ; $464a
	ld de, $4684 ; $464d
	add a, e ; $4650
	ld e, a ; $4651
	jr nc, Label_10_4655 ; $4652
	inc d ; $4654
Label_10_4655:
	ld hl, $0499 ; $4655
	ld a, $01 ; $4658
	farcall FarPtr_RunPagedTextMenu ; $465a
	cp a, $ff ; $465d
	jp z, RunMinigameSelectMenu ; $465f
	ld [wMinigameLevel], a ; $4662
	ld a, [de] ; $4665
	set_flag $03, 6 ; $4666
	farcall FarPtr_0b_00 ; $4669
	ld hl, wStoryModePlayersXPosition ; $466c
	ld de, $c296 ; $466f
	ld bc, $0005 ; $4672
	call CopyMemoryBC ; $4675
	ld a, $ff ; $4678
	ld [$c295], a ; $467a
	ld [$c294], a ; $467d
	ld [$c2a1], a ; $4680
	ret ; $4683
	; $4684, 9 bytes (bytes:16)
	db $1c, $1d, $1e, $1f, $20, $21, $22, $23, $24 ; 0x00
Data_10_468d:
	; $468d, 14 bytes (records:2)
; 7 records x 2 bytes
	dw $4785 ; record 0
	dw $478e ; record 1
	dw $469b ; record 2
	dw $4adf ; record 3
	dw $4b60 ; record 4
	dw $4b80 ; record 5
	dw $4b9b ; record 6
	; $469b, 234 bytes (bytes:14)
	db $00, $00, $d1, $7b, $00, $05, $00, $0f, $40, $00, $55, $01, $00, $00 ; 0x00
	db $00, $00, $d1, $7b, $00, $05, $00, $05, $40, $00, $27, $01, $07, $00 ; 0x0e
	db $00, $00, $d1, $7b, $00, $05, $00, $03, $40, $00, $26, $01, $00, $00 ; 0x1c
	db $00, $00, $d1, $7b, $00, $05, $00, $09, $40, $00, $29, $01, $05, $00 ; 0x2a
	db $00, $00, $d1, $7b, $00, $05, $00, $07, $40, $00, $28, $01, $00, $00 ; 0x38
	db $00, $00, $d1, $7b, $00, $05, $00, $0d, $40, $00, $2a, $01, $07, $00 ; 0x46
	db $00, $00, $d1, $7b, $00, $05, $00, $0b, $40, $00, $2d, $01, $00, $00 ; 0x54
	db $00, $00, $d1, $7b, $00, $05, $00, $11, $40, $00, $2b, $01, $00, $00 ; 0x62
	db $00, $00, $d1, $7b, $00, $0d, $00, $03, $40, $00, $2f, $01, $00, $00 ; 0x70
	db $00, $00, $d1, $7b, $00, $0d, $00, $05, $40, $00, $2f, $01, $07, $00 ; 0x7e
	db $00, $00, $d1, $7b, $00, $0d, $00, $07, $40, $00, $30, $01, $00, $00 ; 0x8c
	db $00, $00, $d1, $7b, $00, $0d, $00, $09, $40, $00, $30, $01, $05, $00 ; 0x9a
	db $00, $00, $d1, $7b, $00, $0d, $00, $0b, $40, $00, $2f, $01, $00, $00 ; 0xa8
	db $00, $00, $d1, $7b, $00, $0d, $00, $0d, $40, $00, $2f, $01, $07, $00 ; 0xb6
	db $00, $00, $d1, $7b, $00, $0d, $00, $0f, $40, $00, $30, $01, $00, $00 ; 0xc4
	db $00, $00, $d1, $7b, $00, $0d, $00, $11, $40, $00, $30, $01, $00, $00 ; 0xd2
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $ff ; 0xe0
	; $4785, 9 bytes (bytes:16)
	db $01, $40, $00, $09, $00, $0d, $00, $00, $ff ; 0x00
	; $478e, 457 bytes (records:8)
; 57 records x 8 bytes
	dw $ff01, $0000, $7bf9, $0b0f ; record 0
	dw $ff02, $0000, $7bf9, $0c0f ; record 1
	dw $ff03, $0000, $7bf9, $0d0f ; record 2
	dw $ff04, $0000, $7bf9, $0f0b ; record 3
	dw $ff05, $0000, $7bf9, $0f0c ; record 4
	dw $ff06, $0000, $7bf9, $0110 ; record 5
	dw $ff07, $0000, $7bf9, $0107 ; record 6
	dw $ff08, $0000, $7bf9, $0100 ; record 7
	dw $21ff, $c2d0, $9611, $01c2 ; record 8
	dw $0005, $dbcd, $3e03, $eaff ; record 9
	dw $c295, $94ea, $eac2, $c2a1 ; record 10
	dw $c0e7, $2103, $0001, $48df ; record 11
	dw $2105, $0161, $0edf, $3e0a ; record 12
	dw $df80, $0a08, $013e, $00df ; record 13
	dw $c90b, $d021, $11c2, $c296 ; record 14
	dw $0501, $cd00, $03db, $ff3e ; record 15
	dw $95ea, $eac2, $c294, $a1ea ; record 16
	dw $e7c2, $03c0, $0221, $df00 ; record 17
	dw $0548, $6121, $df01, $0a0e ; record 18
	dw $803e, $08df, $3e0a, $df02 ; record 19
	dw $0b00, $21c9, $c2d0, $9611 ; record 20
	dw $01c2, $0005, $dbcd, $3e03 ; record 21
	dw $eaff, $c295, $94ea, $eac2 ; record 22
	dw $c2a1, $c0e7, $2103, $0003 ; record 23
	dw $48df, $2105, $0161, $0edf ; record 24
	dw $3e0a, $df80, $0a08, $033e ; record 25
	dw $00df, $c90b, $d021, $11c2 ; record 26
	dw $c296, $0501, $cd00, $03db ; record 27
	dw $ff3e, $95ea, $eac2, $c294 ; record 28
	dw $a1ea, $e7c2, $03c0, $0421 ; record 29
	dw $df00, $0548, $6121, $df01 ; record 30
	dw $0a0e, $803e, $08df, $3e0a ; record 31
	dw $df04, $0b00, $21c9, $c2d0 ; record 32
	dw $9611, $01c2, $0005, $dbcd ; record 33
	dw $3e03, $eaff, $c295, $94ea ; record 34
	dw $eac2, $c2a1, $c0e7, $2103 ; record 35
	dw $0005, $48df, $2105, $0161 ; record 36
	dw $0edf, $3e0a, $df80, $0a08 ; record 37
	dw $053e, $00df, $c90b, $d021 ; record 38
	dw $11c2, $c296, $0501, $cd00 ; record 39
	dw $03db, $ff3e, $95ea, $eac2 ; record 40
	dw $c294, $a1ea, $e7c2, $03c0 ; record 41
	dw $0621, $df00, $0548, $6121 ; record 42
	dw $df01, $0a0e, $803e, $08df ; record 43
	dw $3e0a, $df06, $0b00, $21c9 ; record 44
	dw $c2d0, $9611, $01c2, $0005 ; record 45
	dw $dbcd, $3e03, $eaff, $c295 ; record 46
	dw $94ea, $eac2, $c2a1, $c0e7 ; record 47
	dw $2103, $0007, $48df, $2105 ; record 48
	dw $0161, $0edf, $3e0a, $df80 ; record 49
	dw $0a08, $073e, $00df, $c90b ; record 50
	dw $d021, $11c2, $c296, $0501 ; record 51
	dw $cd00, $03db, $ff3e, $95ea ; record 52
	dw $eac2, $c294, $a1ea, $e7c2 ; record 53
	dw $03c0, $0821, $df00, $0548 ; record 54
	dw $6121, $df01, $0a0e, $803e ; record 55
	dw $08df, $3e0a, $df08, $0b00 ; record 56
	db $c9
	ld hl, wStoryModePlayersXPosition ; $4957
	ld de, $c296 ; $495a
	ld bc, $0005 ; $495d
	call CopyMemoryBC ; $4960
	ld a, $ff ; $4963
	ld [$c295], a ; $4965
	ld [$c294], a ; $4968
	ld [$c2a1], a ; $496b
	set_flag $03, 6 ; $496e
	ld hl, $0009 ; $4971
	farcall FarPtr_PushTextArgNumber ; $4974
	ld hl, $0161 ; $4977
	farcall FarPtr_InitDialogueTextCursor ; $497a
	ld a, $80 ; $497d
	farcall FarPtr_ScriptShowSpeakerDialogue ; $497f
	ld a, $09 ; $4982
	farcall FarPtr_0b_00 ; $4984
	ret ; $4987
	ld hl, wStoryModePlayersXPosition ; $4988
	ld de, $c296 ; $498b
	ld bc, $0005 ; $498e
	call CopyMemoryBC ; $4991
	ld a, $ff ; $4994
	ld [$c295], a ; $4996
	ld [$c294], a ; $4999
	ld [$c2a1], a ; $499c
	set_flag $03, 6 ; $499f
	ld hl, $000a ; $49a2
	farcall FarPtr_PushTextArgNumber ; $49a5
	ld hl, $0161 ; $49a8
	farcall FarPtr_InitDialogueTextCursor ; $49ab
	ld a, $80 ; $49ae
	farcall FarPtr_ScriptShowSpeakerDialogue ; $49b0
	ld a, $0a ; $49b3
	farcall FarPtr_0b_00 ; $49b5
	ret ; $49b8
	ld hl, wStoryModePlayersXPosition ; $49b9
	ld de, $c296 ; $49bc
	ld bc, $0005 ; $49bf
	call CopyMemoryBC ; $49c2
	ld a, $ff ; $49c5
	ld [$c295], a ; $49c7
	ld [$c294], a ; $49ca
	ld [$c2a1], a ; $49cd
	set_flag $03, 6 ; $49d0
	ld hl, $000b ; $49d3
	farcall FarPtr_PushTextArgNumber ; $49d6
	ld hl, $0161 ; $49d9
	farcall FarPtr_InitDialogueTextCursor ; $49dc
	ld a, $80 ; $49df
	farcall FarPtr_ScriptShowSpeakerDialogue ; $49e1
	ld a, $0b ; $49e4
	farcall FarPtr_0b_00 ; $49e6
	ret ; $49e9
	ld hl, wStoryModePlayersXPosition ; $49ea
	ld de, $c296 ; $49ed
	ld bc, $0005 ; $49f0
	call CopyMemoryBC ; $49f3
	ld a, $ff ; $49f6
	ld [$c295], a ; $49f8
	ld [$c294], a ; $49fb
	ld [$c2a1], a ; $49fe
	set_flag $03, 6 ; $4a01
	ld hl, $000c ; $4a04
	farcall FarPtr_PushTextArgNumber ; $4a07
	ld hl, $0161 ; $4a0a
	farcall FarPtr_InitDialogueTextCursor ; $4a0d
	ld a, $80 ; $4a10
	farcall FarPtr_ScriptShowSpeakerDialogue ; $4a12
	ld a, $0c ; $4a15
	farcall FarPtr_0b_00 ; $4a17
	ret ; $4a1a
	ld hl, wStoryModePlayersXPosition ; $4a1b
	ld de, $c296 ; $4a1e
	ld bc, $0005 ; $4a21
	call CopyMemoryBC ; $4a24
	ld a, $ff ; $4a27
	ld [$c295], a ; $4a29
	ld [$c294], a ; $4a2c
	ld [$c2a1], a ; $4a2f
	set_flag $03, 6 ; $4a32
	ld hl, $000d ; $4a35
	farcall FarPtr_PushTextArgNumber ; $4a38
	ld hl, $0161 ; $4a3b
	farcall FarPtr_InitDialogueTextCursor ; $4a3e
	ld a, $80 ; $4a41
	farcall FarPtr_ScriptShowSpeakerDialogue ; $4a43
	ld a, $0d ; $4a46
	farcall FarPtr_0b_00 ; $4a48
	ret ; $4a4b
	ld hl, wStoryModePlayersXPosition ; $4a4c
	ld de, $c296 ; $4a4f
	ld bc, $0005 ; $4a52
	call CopyMemoryBC ; $4a55
	ld a, $ff ; $4a58
	ld [$c295], a ; $4a5a
	ld [$c294], a ; $4a5d
	ld [$c2a1], a ; $4a60
	set_flag $03, 6 ; $4a63
	ld hl, $000e ; $4a66
	farcall FarPtr_PushTextArgNumber ; $4a69
	ld hl, $0161 ; $4a6c
	farcall FarPtr_InitDialogueTextCursor ; $4a6f
	ld a, $80 ; $4a72
	farcall FarPtr_ScriptShowSpeakerDialogue ; $4a74
	ld a, $0e ; $4a77
	farcall FarPtr_0b_00 ; $4a79
	ret ; $4a7c
	ld hl, wStoryModePlayersXPosition ; $4a7d
	ld de, $c296 ; $4a80
	ld bc, $0005 ; $4a83
	call CopyMemoryBC ; $4a86
	ld a, $ff ; $4a89
	ld [$c295], a ; $4a8b
	ld [$c294], a ; $4a8e
	ld [$c2a1], a ; $4a91
	set_flag $03, 6 ; $4a94
	ld hl, $000f ; $4a97
	farcall FarPtr_PushTextArgNumber ; $4a9a
	ld hl, $0161 ; $4a9d
	farcall FarPtr_InitDialogueTextCursor ; $4aa0
	ld a, $80 ; $4aa3
	farcall FarPtr_ScriptShowSpeakerDialogue ; $4aa5
	ld a, $0f ; $4aa8
	farcall FarPtr_0b_00 ; $4aaa
	ret ; $4aad
	ld hl, wStoryModePlayersXPosition ; $4aae
	ld de, $c296 ; $4ab1
	ld bc, $0005 ; $4ab4
	call CopyMemoryBC ; $4ab7
	ld a, $ff ; $4aba
	ld [$c295], a ; $4abc
	ld [$c294], a ; $4abf
	ld [$c2a1], a ; $4ac2
	set_flag $03, 6 ; $4ac5
	ld hl, $0010 ; $4ac8
	farcall FarPtr_PushTextArgNumber ; $4acb
	ld hl, $0161 ; $4ace
	farcall FarPtr_InitDialogueTextCursor ; $4ad1
	ld a, $80 ; $4ad4
	farcall FarPtr_ScriptShowSpeakerDialogue ; $4ad6
	ld a, $10 ; $4ad9
	farcall FarPtr_0b_00 ; $4adb
	ret ; $4ade
	; $4adf, 129 bytes (records:8)
; 16 records x 8 bytes
	dw $ff03, $0000, $0c21, $0000 ; record 0
	dw $ff04, $0000, $0c22, $0000 ; record 1
	dw $ff05, $0000, $0c23, $0000 ; record 2
	dw $ff06, $0000, $0c24, $0000 ; record 3
	dw $ff07, $0000, $0c25, $0000 ; record 4
	dw $ff08, $0000, $0c26, $0000 ; record 5
	dw $ff09, $0000, $0c27, $0000 ; record 6
	dw $ff0a, $0000, $0c28, $0000 ; record 7
	dw $ff0b, $0000, $4957, $0000 ; record 8
	dw $ff0c, $0000, $4988, $0000 ; record 9
	dw $ff0d, $0000, $49b9, $0000 ; record 10
	dw $ff0e, $0000, $49ea, $0000 ; record 11
	dw $ff0f, $0000, $4a1b, $0000 ; record 12
	dw $ff10, $0000, $4a4c, $0000 ; record 13
	dw $ff11, $0000, $4a7d, $0000 ; record 14
	dw $ff12, $0000, $4aae, $0000 ; record 15
	db $ff
	; $4b60, 32 bytes (records:8)
; 4 records x 8 bytes
	dw $ff01, $0000, $4b69, $0000 ; record 0
	dw $dfff, $0a00, $100e, $2ecd ; record 1
	dw $211d, $0483, $0edf, $3e0a ; record 2
	dw $df00, $0a08, $02df, $c90a ; record 3
	; $4b80, 27 bytes (records:8)
; 3 records x 8 bytes
	dw $ff01, $0000, $4b89, $0000 ; record 0
	dw $dfff, $0a00, $8021, $df04 ; record 1
	dw $0a0e, $003e, $08df, $df0a ; record 2
	db $02, $0a, $c9
	ld a, [$c295] ; $4b9b
	cp a, $0f ; $4b9e
	ret z ; $4ba0
	farcall FarPtr_0a_94 ; $4ba1
	ld a, a ; $4ba4
	ld [$c294], a ; $4ba5
	ld [$c2a1], a ; $4ba8
	ret ; $4bab
	farcall FarPtr_08_06 ; $4bac
	ld a, $02 ; $4baf
	ld [wCurrentlyUsedCourt], a ; $4bb1
	ld a, $02 ; $4bb4
	ld [wOnCourtCharCount], a ; $4bb6
	ldh a, [hRomBank] ; $4bb9
	ld de, $4bd8 ; $4bbb
	farcall FarPtr_SetModeHookTable ; $4bbe
	ld de, $4c13 ; $4bc1
	farcall FarPtr_08_4a ; $4bc4
	ld a, $1a ; $4bc7
	ld [$c3b0], a ; $4bc9
	ld a, $04 ; $4bcc
	ld [$c3b1], a ; $4bce
	farcall FarPtr_Func_3b_44aa ; $4bd1
	farcall FarPtr_08_08 ; $4bd4
	ret ; $4bd7
	INCBIN "data/bank_010/d_4bd8.bin" ; $4bd8, 243 bytes
Data_10_4ccb:
	; $4ccb, 14 bytes (records:2)
; 7 records x 2 bytes
	dw $4ced ; record 0
	dw $4cf6 ; record 1
	dw $4cd9 ; record 2
	dw $4daf ; record 3
	dw $4e30 ; record 4
	dw $4e50 ; record 5
	dw $4e6b ; record 6
	; $4cd9, 20 bytes (bytes:14)
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $ff, $00, $00, $00, $00 ; 0x00
	db $00, $00, $00, $00, $00, $ff ; 0x0e
	; $4ced, 9 bytes (bytes:16)
	db $01, $40, $00, $09, $00, $09, $00, $00, $ff ; 0x00
	; $4cf6, 9 bytes (records:8)
; 1 records x 8 bytes
	dw $ff01, $0000, $7bf9, $0101 ; record 0
	db $ff
	ld c, $10 ; $4cff
	call BeginFadeOut ; $4d01
	call WaitFadeEnd ; $4d04
	ldh a, [hRomBank] ; $4d07
	ld hl, $4ce3 ; $4d09
	farcall FarPtr_0a_06 ; $4d0c
	ld c, $10 ; $4d0f
	call BeginFadeIn ; $4d11
	call WaitFadeEnd ; $4d14
	ret ; $4d17
	ld a, $03 ; $4d18
	ld bc, $0100 ; $4d1a
	ld de, $0100 ; $4d1d
	farcall FarPtr_ScriptSetActorMoveTarget ; $4d20
	ld a, $03 ; $4d23
	farcall FarPtr_ScriptWaitActorMoveDone ; $4d25
	ld a, $07 ; $4d28
	ld bc, $0100 ; $4d2a
	ld de, $0100 ; $4d2d
	farcall FarPtr_ScriptSetActorMoveTarget ; $4d30
	ld a, $07 ; $4d33
	farcall FarPtr_ScriptWaitActorMoveDone ; $4d35
	ld a, $0b ; $4d38
	ld bc, $0100 ; $4d3a
	ld de, $0100 ; $4d3d
	farcall FarPtr_ScriptSetActorMoveTarget ; $4d40
	ld a, $0b ; $4d43
	farcall FarPtr_ScriptWaitActorMoveDone ; $4d45
	ld a, $10 ; $4d48
	ld bc, $0100 ; $4d4a
	ld de, $0100 ; $4d4d
	farcall FarPtr_ScriptSetActorMoveTarget ; $4d50
	ld a, $10 ; $4d53
	farcall FarPtr_ScriptWaitActorMoveDone ; $4d55
	ld hl, wStoryModePlayersXPosition ; $4d58
	ld de, $c296 ; $4d5b
	ld bc, $0005 ; $4d5e
	call CopyMemoryBC ; $4d61
	ld a, $ff ; $4d64
	ld [$c295], a ; $4d66
	ld [$c294], a ; $4d69
	ld [$c2a1], a ; $4d6c
	ret ; $4d6f
	ld c, $10 ; $4d70
	call BeginFadeOut ; $4d72
	call WaitFadeEnd ; $4d75
	ldh a, [hRomBank] ; $4d78
	ld hl, $4cd9 ; $4d7a
	farcall FarPtr_0a_06 ; $4d7d
	ld c, $10 ; $4d80
	call BeginFadeIn ; $4d82
	call WaitFadeEnd ; $4d85
	ret ; $4d88
	farcall FarPtr_0a_00 ; $4d89
	ld hl, $0001 ; $4d8c
	farcall FarPtr_InitDialogueTextCursor ; $4d8f
	ld a, $00 ; $4d92
	farcall FarPtr_ScriptShowSpeakerDialogue ; $4d94
	farcall FarPtr_0a_02 ; $4d97
	ret ; $4d9a
	ret ; $4d9b
	INCBIN "data/bank_010/d_4d9c.bin" ; $4d9c, 10 bytes
	ld a, $0e ; $4da6
	ld [$c294], a ; $4da8
	ld [$c2a1], a ; $4dab
	ret ; $4dae
	; $4daf, 129 bytes (records:8)
; 16 records x 8 bytes
	dw $ff03, $0000, $4cff, $0000 ; record 0
	dw $ff04, $0000, $4cff, $0000 ; record 1
	dw $ff05, $0000, $4cff, $0000 ; record 2
	dw $ff06, $0000, $4cff, $0000 ; record 3
	dw $ff07, $0000, $4cff, $0000 ; record 4
	dw $ff08, $0000, $4cff, $0000 ; record 5
	dw $ff09, $0000, $4cff, $0000 ; record 6
	dw $ff0a, $0000, $4cff, $0000 ; record 7
	dw $ff0b, $0000, $4d70, $0000 ; record 8
	dw $ff0c, $0000, $4d70, $0000 ; record 9
	dw $ff0d, $0000, $4d70, $0003 ; record 10
	dw $ff0e, $0000, $4d70, $0000 ; record 11
	dw $ff0f, $0000, $4d70, $0000 ; record 12
	dw $ff10, $0000, $4d70, $0000 ; record 13
	dw $ff11, $0000, $4d70, $0000 ; record 14
	dw $ff12, $0000, $4d70, $0000 ; record 15
	db $ff
	; $4e30, 32 bytes (records:8)
; 4 records x 8 bytes
	dw $ff01, $0000, $4e39, $0000 ; record 0
	dw $dfff, $0a00, $100e, $2ecd ; record 1
	dw $211d, $0483, $0edf, $3e0a ; record 2
	dw $df00, $0a08, $02df, $c90a ; record 3
	; $4e50, 27 bytes (records:8)
; 3 records x 8 bytes
	dw $ff01, $0000, $4e59, $0000 ; record 0
	dw $dfff, $0a00, $8021, $df04 ; record 1
	dw $0a0e, $003e, $08df, $df0a ; record 2
	db $02, $0a, $c9
	ret ; $4e6b
MatchSelectHandlersA_10:
	; $4e6c, 14 bytes (records:2)
; 7 records x 2 bytes
	dw $4e84 ; record 0
	dw $4e8d ; record 1
	dw $4e7a ; record 2
	dw $4eb6 ; record 3
	dw $4eb7 ; record 4
	dw $4eb8 ; record 5
	dw $4eb9 ; record 6
	nop ; $4e7a
	nop ; $4e7b
	nop ; $4e7c
	nop ; $4e7d
	nop ; $4e7e
	nop ; $4e7f
	nop ; $4e80
	nop ; $4e81
	nop ; $4e82
	rst Rst38 ; $4e83
	ld bc, $0040 ; $4e84
	rst Rst38 ; $4e87
	nop ; $4e88
	rst Rst38 ; $4e89
	nop ; $4e8a
	nop ; $4e8b
	rst Rst38 ; $4e8c
	ld bc, $00ff ; $4e8d
	nop ; $4e90
	ld sp, hl ; $4e91
	ld a, e ; $4e92
	inc d ; $4e93
	rrca ; $4e94
	ld [bc], a ; $4e95
	rst Rst38 ; $4e96
	nop ; $4e97
	nop ; $4e98
	ld sp, hl ; $4e99
	ld a, e ; $4e9a
	ld a, [bc] ; $4e9b
	ld bc, $ff03 ; $4e9c
	nop ; $4e9f
	nop ; $4ea0
	ld sp, hl ; $4ea1
	ld a, e ; $4ea2
	inc b ; $4ea3
	ld bc, rDIV ; $4ea4
	nop ; $4ea7
	nop ; $4ea8
	ld sp, hl ; $4ea9
	ld a, e ; $4eaa
	ld b, $0f ; $4eab
	dec b ; $4ead
	rst Rst38 ; $4eae
	nop ; $4eaf
	nop ; $4eb0
	ld sp, hl ; $4eb1
	ld a, e ; $4eb2
	dec e ; $4eb3
	rrca ; $4eb4
	rst Rst38 ; $4eb5
	rst Rst38 ; $4eb6
	rst Rst38 ; $4eb7
	rst Rst38 ; $4eb8
	ld a, $00 ; $4eb9
	ld bc, $3f00 ; $4ebb
	ld de, $3f00 ; $4ebe
	farcall FarPtr_ScriptSetActorPosition ; $4ec1
	call Func_10_4f0d ; $4ec4
	farcall FarPtr_TestStorySlotFlagA ; $4ec7
	call SetMusicMuted ; $4eca
	ret ; $4ecd
ApplyMatchTypeSettings:
	ld hl, $4f08 ; $4ece
	ld a, [$cb10] ; $4ed1
	add a, l ; $4ed4
	ld l, a ; $4ed5
	jr nc, Label_10_4ed9 ; $4ed6
	inc h ; $4ed8
Label_10_4ed9:
	ld a, [hl] ; $4ed9
	ld [wMatchTypeNumberOfSets], a ; $4eda
	ld hl, $4f0b ; $4edd
	ld a, [$cb0f] ; $4ee0
	add a, l ; $4ee3
	ld l, a ; $4ee4
	jr nc, Label_10_4ee8 ; $4ee5
	inc h ; $4ee7
Label_10_4ee8:
	ld a, [hl] ; $4ee8
	ld [wMatchTypeNumberOfGames], a ; $4ee9
	ld a, [$cb0e] ; $4eec
	ld [wMatchIsDoubles], a ; $4eef
	or a, a ; $4ef2
	jr z, Label_10_4eff ; $4ef3
	ld a, $04 ; $4ef5
	ld [wOnCourtCharCount], a ; $4ef7
	set_flag $05, 7 ; $4efa
	jr Label_10_4f07 ; $4efd
Label_10_4eff:
	ld a, $02 ; $4eff
	ld [wOnCourtCharCount], a ; $4f01
	clear_flag $05, 7 ; $4f04
Label_10_4f07:
	ret ; $4f07
	; $4f08, 5 bytes (bytes:16)
	db $01, $03, $05, $02, $06 ; 0x00
Func_10_4f0d:
	call ClearFrameTasks ; $4f0d
	sound $00 ; $4f10
	call ResumeBGM ; $4f12
	ld a, [$c295] ; $4f15
	cp a, $0a ; $4f18
	jr nz, Label_10_4f3c ; $4f1a
	call ClearFrameTasks ; $4f1c
	sound $00 ; $4f1f
	call ResumeBGM ; $4f21
	xor a, a ; $4f24
	ld [$cb71], a ; $4f25
Label_10_4f28:
	farcall FarPtr_6b_12 ; $4f28
	farcall FarPtr_6b_14 ; $4f2b
	farcall FarPtr_6b_00 ; $4f2e
Label_10_4f31:
	farcall FarPtr_6b_02 ; $4f31
	cp a, $ff ; $4f34
	jr z, Label_10_4f28 ; $4f36
	cp a, $01 ; $4f38
	jr z, Label_10_4f28 ; $4f3a
Label_10_4f3c:
	farcall FarPtr_InitDefaultMatchSettings ; $4f3c
	xor a, a ; $4f3f
	ld [$cb1b], a ; $4f40
	ld [$cb1c], a ; $4f43
	ld [$cb1d], a ; $4f46
	ld [$cb1e], a ; $4f49
	ld [$cb0e], a ; $4f4c
	ld [$cb0f], a ; $4f4f
	ld [$cb10], a ; $4f52
	call EnableLCD ; $4f55
	ld c, $7f ; $4f58
	call BeginFadeOut ; $4f5a
	call WaitFadeEnd ; $4f5d
	call DisableLCDSafely ; $4f60
	ld a, $01 ; $4f63
	ld [$cb11], a ; $4f65
Label_10_4f68:
	call DisableLCDSafely ; $4f68
	farcall FarPtr_01_0a ; $4f6b
	farcall FarPtr_39_22 ; $4f6e
	call EnableLCD ; $4f71
	ld c, $10 ; $4f74
	call BeginFadeIn ; $4f76
	call WaitFadeEnd ; $4f79
Label_10_4f7c:
	xor a, a ; $4f7c
	ld [$cb22], a ; $4f7d
	ld [$cb1c], a ; $4f80
	ld [$cb1d], a ; $4f83
	ld [$cb1e], a ; $4f86
	ld [$cb0e], a ; $4f89
	ld [$cb0f], a ; $4f8c
	ld [$cb10], a ; $4f8f
	ld [$cb0b], a ; $4f92
	ldh [hScrollX], a ; $4f95
	ldh [hScrollY], a ; $4f97
	ld [wCameraX], a ; $4f99
	ld [$c321], a ; $4f9c
	ld [wCameraY], a ; $4f9f
	ld [$c323], a ; $4fa2
	ld a, $03 ; $4fa5
	ld [$cb0c], a ; $4fa7
	call ResumeBGM ; $4faa
	call InitSerialLink ; $4fad
	farcall FarPtr_3b_0c ; $4fb0
	cp a, $ff ; $4fb3
	jp z, Label_10_4f31 ; $4fb5
	ld e, a ; $4fb8
	ld hl, MatchSelectHandlersB_10 ; $4fb9
	add a, a ; $4fbc
	add a, l ; $4fbd
	ld l, a ; $4fbe
	jr nc, Label_10_4fc2 ; $4fbf
	inc h ; $4fc1
Label_10_4fc2:
	ld a, [hl+] ; $4fc2
	ld h, [hl] ; $4fc3
	ld l, a ; $4fc4
	jp hl ; $4fc5
MatchSelectHandlersB_10:
	; $4fc6, 18 bytes (records:2)
; 9 records x 2 bytes
	dw $4fd8 ; record 0
	dw $4fd8 ; record 1
	dw $4fd8 ; record 2
	dw $50fe ; record 3
	dw $5216 ; record 4
	dw $52a0 ; record 5
	dw $52d1 ; record 6
	dw $54b0 ; record 7
	dw $54d6 ; record 8
	ld a, e ; $4fd8
	cp a, $ff ; $4fd9
	jr z, Label_10_5041 ; $4fdb
	and a, $7f ; $4fdd
	ld [$c36c], a ; $4fdf
	farcall FarPtr_CheckStorySlot ; $4fe2
	cp a, $fe ; $4fe5
	jr z, Label_10_5041 ; $4fe7
	farcall FarPtr_1e_06 ; $4fe9
	or a, a ; $4fec
	jr z, Label_10_5006 ; $4fed
	call DisableLCDSafely ; $4fef
	farcall FarPtr_39_22 ; $4ff2
	call EnableLCD ; $4ff5
	ld a, [$c8a5] ; $4ff8
	or a, a ; $4ffb
	jr nz, Label_10_5006 ; $4ffc
	ld c, $10 ; $4ffe
	call BeginFadeIn ; $5000
	call WaitFadeEnd ; $5003
Label_10_5006:
	ld a, [$c8a5] ; $5006
	or a, a ; $5009
	jp z, Label_10_50a4 ; $500a
	ld c, $00 ; $500d
	farcall FarPtr_1e_00 ; $500f
	push af ; $5012
	call RestoreGameTimer ; $5013
	pop af ; $5016
	or a, a ; $5017
	jp z, Label_10_5093 ; $5018
	cp a, $ff ; $501b
	jp z, Label_10_4f68 ; $501d
	xor a, a ; $5020
	ld [$c8a5], a ; $5021
	farcall FarPtr_03_18 ; $5024
	ld a, [$c8a7] ; $5027
	or a, a ; $502a
	jr z, Label_10_5030 ; $502b
	jp Label_10_55b6 ; $502d
Label_10_5030:
	farcall FarPtr_0a_64 ; $5030
	ld b, $0a ; $5033
	ld c, $01 ; $5035
	farcall FarPtr_0a_62 ; $5037
	farcall FarPtr_03_18 ; $503a
	farcall FarPtr_0a_02 ; $503d
	ret ; $5040
Label_10_5041:
	ld a, $03 ; $5041
	ld [$cb0c], a ; $5043
	ld c, $10 ; $5046
	call BeginFadeOut ; $5048
	call WaitFadeEnd ; $504b
	ld a, e ; $504e
	ld [$c36c], a ; $504f
	farcall FarPtr_RunNewGameSetup ; $5052
	cp a, $ff ; $5055
	jp nz, Label_10_5073 ; $5057
	ld a, $00 ; $505a
	ld [$cb11], a ; $505c
	call DisableLCDSafely ; $505f
	farcall FarPtr_01_0a ; $5062
	farcall FarPtr_39_22 ; $5065
	call EnableLCD ; $5068
	ld c, $10 ; $506b
	call BeginFadeIn ; $506d
	jp Label_10_4f7c ; $5070
Label_10_5073:
	call ResetGameTimer ; $5073
	farcall FarPtr_02_16 ; $5076
	farcall FarPtr_03_18 ; $5079
	test_flag $02, 5 ; $507c
	jr nz, Label_10_508a ; $507f
	ld a, $01 ; $5081
	ld [$c294], a ; $5083
	ld [$c2a1], a ; $5086
	ret ; $5089
Label_10_508a:
	ld a, $03 ; $508a
	ld [$c294], a ; $508c
	ld [$c2a1], a ; $508f
	ret ; $5092
Label_10_5093:
	call DisableLCDSafely ; $5093
	farcall FarPtr_39_22 ; $5096
	call EnableLCD ; $5099
	ld c, $10 ; $509c
	call BeginFadeIn ; $509e
	call WaitFadeEnd ; $50a1
Label_10_50a4:
	xor a, a ; $50a4
	ld [$c8a5], a ; $50a5
	ld [$c8a7], a ; $50a8
	call RestoreGameTimer ; $50ab
	farcall FarPtr_03_18 ; $50ae
	call Func_10_5752 ; $50b1
	ld [$cb74], a ; $50b4
	cp a, $04 ; $50b7
	jr z, Label_10_50ca ; $50b9
	farcall FarPtr_3e_0a ; $50bb
	cp a, $ff ; $50be
	jr nz, Label_10_50ca ; $50c0
	ld a, $00 ; $50c2
	ld [$cb11], a ; $50c4
	jp Label_10_4f7c ; $50c7
Label_10_50ca:
	call Func_10_5752 ; $50ca
	ld [$cb74], a ; $50cd
	call RestoreGameTimer ; $50d0
	ld a, $00 ; $50d3
	ld [wGameMode], a ; $50d5
	clear_flag $09, 7 ; $50d8
	ld b, $0a ; $50db
	ld c, $01 ; $50dd
	farcall FarPtr_0a_62 ; $50df
	farcall FarPtr_03_18 ; $50e2
	test_flag $02, 5 ; $50e5
	jr nz, Label_10_50f5 ; $50e8
	ld a, [$cb74] ; $50ea
	ld a, a ; $50ed
	ld [$c294], a ; $50ee
	ld [$c2a1], a ; $50f1
	ret ; $50f4
Label_10_50f5:
	ld a, $03 ; $50f5
	ld [$c294], a ; $50f7
	ld [$c2a1], a ; $50fa
	ret ; $50fd
	ld a, $03 ; $50fe
	ld [$c36c], a ; $5100
	farcall FarPtr_03_24 ; $5103
	bit 7, a ; $5106
	jr nz, Label_10_5137 ; $5108
	ld a, [$c8a5] ; $510a
	or a, a ; $510d
	jr z, Label_10_5137 ; $510e
	ld c, $00 ; $5110
	farcall FarPtr_1e_00 ; $5112
	or a, a ; $5115
	jr z, Label_10_5124 ; $5116
	cp a, $ff ; $5118
	jp z, Label_10_4f68 ; $511a
	ld a, [$c8a7] ; $511d
	or a, a ; $5120
	jp nz, Label_10_51db ; $5121
Label_10_5124:
	call DisableLCDSafely ; $5124
	farcall FarPtr_39_22 ; $5127
	call EnableLCD ; $512a
	push af ; $512d
	ld c, $10 ; $512e
	call BeginFadeIn ; $5130
	call WaitFadeEnd ; $5133
	pop af ; $5136
Label_10_5137:
	xor a, a ; $5137
	ld [$c8a8], a ; $5138
	ld a, $03 ; $513b
	ld [$c36c], a ; $513d
	farcall FarPtr_InitStoryModeState ; $5140
	farcall FarPtr_InitDefaultMatchSettings ; $5143
	farcall FarPtr_03_26 ; $5146
Label_10_5149:
	farcall FarPtr_3b_0e ; $5149
	cp a, $ff ; $514c
	jp z, Label_10_4f7c ; $514e
	ld c, $10 ; $5151
	call BeginFadeOut ; $5153
	call WaitFadeEnd ; $5156
Label_10_5159:
	ld a, [$cb0e] ; $5159
	ld b, a ; $515c
	farcall FarPtr_38_08 ; $515d
	call Func_10_56fc ; $5160
	push af ; $5163
	call ClearFrameTasks ; $5164
	call DisableLCDSafely ; $5167
	farcall FarPtr_01_0a ; $516a
	farcall FarPtr_39_22 ; $516d
	xor a, a ; $5170
	ld [$cb53], a ; $5171
	ld [$cb54], a ; $5174
	farcall FarPtr_3e_22 ; $5177
	farcall FarPtr_3e_20 ; $517a
	pop af ; $517d
	cp a, $ff ; $517e
	jr nz, Label_10_5191 ; $5180
	call EnableLCD ; $5182
	ld c, $10 ; $5185
	call BeginFadeIn ; $5187
	ld a, $00 ; $518a
	ld [$cb11], a ; $518c
	jr Label_10_5149 ; $518f
Label_10_5191:
	ld a, $01 ; $5191
	ld [$cb11], a ; $5193
	farcall FarPtr_3e_24 ; $5196
	ld a, [$cb54] ; $5199
	or a, a ; $519c
	jr z, Label_10_51b6 ; $519d
	call EnableLCD ; $519f
	ld c, $10 ; $51a2
	call BeginFadeIn ; $51a4
	farcall FarPtr_3e_1c ; $51a7
	cp a, $ff ; $51aa
	jr nz, Label_10_51cd ; $51ac
	ld a, $00 ; $51ae
	ld [$cb11], a ; $51b0
	jp z, Label_10_5159 ; $51b3
Label_10_51b6:
	call EnableLCD ; $51b6
	ld c, $10 ; $51b9
	call BeginFadeIn ; $51bb
	farcall FarPtr_3e_18 ; $51be
	cp a, $ff ; $51c1
	jr nz, Label_10_51cd ; $51c3
	ld a, $00 ; $51c5
	ld [$cb11], a ; $51c7
	jp z, Label_10_5159 ; $51ca
Label_10_51cd:
	ld d, a ; $51cd
	wram_bank $04 ; $51ce
	ld a, d ; $51d4
	ld [wCurrentlyUsedCourt], a ; $51d5
	call ApplyMatchTypeSettings ; $51d8
Label_10_51db:
	ld a, $03 ; $51db
	ld [$c36c], a ; $51dd
	xor a, a ; $51e0
	ld [$c8a5], a ; $51e1
	farcall FarPtr_03_26 ; $51e4
	ld a, $04 ; $51e7
	ld [wGameMode], a ; $51e9
	farcall FarPtr_RunMatch ; $51ec
	ld a, [$c8a5] ; $51ef
	or a, a ; $51f2
	jr z, Label_10_51fd ; $51f3
	ld a, $01 ; $51f5
	ld [$c8a8], a ; $51f7
	farcall FarPtr_03_26 ; $51fa
Label_10_51fd:
	ld a, $01 ; $51fd
	ld [$cb11], a ; $51ff
	call DisableLCDSafely ; $5202
	farcall FarPtr_01_0a ; $5205
	farcall FarPtr_39_22 ; $5208
	call EnableLCD ; $520b
	ld c, $10 ; $520e
	call BeginFadeIn ; $5210
	jp Label_10_4f7c ; $5213
Label_10_5216:
	xor a, a ; $5216
	ld [$c8a7], a ; $5217
	farcall FarPtr_3b_10 ; $521a
	cp a, $ff ; $521d
	jr nz, Label_10_5229 ; $521f
	ld a, $00 ; $5221
	ld [$cb11], a ; $5223
	jp Label_10_4f7c ; $5226
Label_10_5229:
	ld a, $03 ; $5229
	ld [$c36c], a ; $522b
	ld a, [$cb20] ; $522e
	ld c, a ; $5231
	farcall FarPtr_1b_28 ; $5232
	cp a, $ff ; $5235
	jr nz, Label_10_5241 ; $5237
	ld a, $00 ; $5239
	ld [$cb11], a ; $523b
	jp Label_10_5216 ; $523e
Label_10_5241:
	ld [wMinigameLevel], a ; $5241
	ld a, [$cb20] ; $5244
	ld b, a ; $5247
	add a, a ; $5248
	add a, b ; $5249
	ld c, a ; $524a
	ld a, [wMinigameLevel] ; $524b
	add a, c ; $524e
	farcall FarPtr_ShowRulesScreen ; $524f
	cp a, $ff ; $5252
	jr nz, Label_10_526e ; $5254
	call DisableLCDSafely ; $5256
	farcall FarPtr_01_0a ; $5259
	farcall FarPtr_39_22 ; $525c
	call EnableLCD ; $525f
	ld c, $10 ; $5262
	call BeginFadeIn ; $5264
	ld a, $00 ; $5267
	ld [$cb11], a ; $5269
	jr Label_10_5229 ; $526c
Label_10_526e:
	ld a, [$cb20] ; $526e
	call Func_10_56e9 ; $5271
	farcall FarPtr_0b_00 ; $5274
	ld a, $01 ; $5277
	ld [$cb11], a ; $5279
	call DisableLCDSafely ; $527c
	farcall FarPtr_01_0a ; $527f
	farcall FarPtr_39_22 ; $5282
	call EnableLCD ; $5285
	ld c, $10 ; $5288
	call BeginFadeIn ; $528a
	call WaitFadeEnd ; $528d
	ld a, [$c4df] ; $5290
	or a, a ; $5293
	jr nz, Label_10_5229 ; $5294
	ld a, [wPointWinLoseFlag] ; $5296
	cp a, $01 ; $5299
	jr z, Label_10_5229 ; $529b
	jp Label_10_4f7c ; $529d
	ld a, $03 ; $52a0
	ld [$c36c], a ; $52a2
	farcall FarPtr_InitStoryModeState ; $52a5
	farcall FarPtr_InitDefaultMatchSettings ; $52a8
	farcall FarPtr_Func_38_7408Alias1 ; $52ab
	push af ; $52ae
	call InitSerialLink ; $52af
	pop af ; $52b2
	cp a, $ff ; $52b3
	jp z, Label_10_4f7c ; $52b5
	ld a, $01 ; $52b8
	ld [$cb11], a ; $52ba
	call DisableLCDSafely ; $52bd
	farcall FarPtr_01_0a ; $52c0
	farcall FarPtr_39_22 ; $52c3
	call EnableLCD ; $52c6
	ld c, $10 ; $52c9
	call BeginFadeIn ; $52cb
	jp Label_10_4f7c ; $52ce
Label_10_52d1:
	farcall FarPtr_3b_12 ; $52d1
	cp a, $ff ; $52d4
	jp z, Label_10_4f7c ; $52d6
	cp a, $03 ; $52d9
	jp nc, Label_10_53d4 ; $52db
	ld [$c36c], a ; $52de
	farcall FarPtr_CheckStorySlot ; $52e1
Label_10_52e4:
	farcall FarPtr_3b_18 ; $52e4
	cp a, $ff ; $52e7
	jp z, Label_10_52d1 ; $52e9
	or a, a ; $52ec
	jr nz, Label_10_5315 ; $52ed
	ld c, $10 ; $52ef
	call BeginFadeOut ; $52f1
	call WaitFadeEnd ; $52f4
	ld a, $00 ; $52f7
	farcall FarPtr_1d_00 ; $52f9
	call DisableLCDSafely ; $52fc
	farcall FarPtr_01_0a ; $52ff
	farcall FarPtr_39_22 ; $5302
	call EnableLCD ; $5305
	ld c, $10 ; $5308
	call BeginFadeIn ; $530a
	ld a, $00 ; $530d
	ld [$cb11], a ; $530f
	jp Label_10_52e4 ; $5312
Label_10_5315:
	cp a, $01 ; $5315
	jr nz, Label_10_5345 ; $5317
	ld c, $10 ; $5319
	call BeginFadeOut ; $531b
	call WaitFadeEnd ; $531e
	farcall FarPtr_1e_08 ; $5321
	ld c, $10 ; $5324
	call BeginFadeOut ; $5326
	call WaitFadeEnd ; $5329
	call DisableLCDSafely ; $532c
	farcall FarPtr_01_0a ; $532f
	farcall FarPtr_39_22 ; $5332
	call EnableLCD ; $5335
	ld c, $10 ; $5338
	call BeginFadeIn ; $533a
	ld a, $00 ; $533d
	ld [$cb11], a ; $533f
	jp Label_10_52e4 ; $5342
Label_10_5345:
	cp a, $02 ; $5345
	jr nz, Label_10_536d ; $5347
	ld c, $10 ; $5349
	call BeginFadeOut ; $534b
	call WaitFadeEnd ; $534e
	farcall FarPtr_3b_06 ; $5351
	call DisableLCDSafely ; $5354
	farcall FarPtr_01_0a ; $5357
	farcall FarPtr_39_22 ; $535a
	call EnableLCD ; $535d
	ld c, $10 ; $5360
	call BeginFadeIn ; $5362
	ld a, $00 ; $5365
	ld [$cb11], a ; $5367
	jp Label_10_52e4 ; $536a
Label_10_536d:
	farcall FarPtr_3e_08 ; $536d
	cp a, $00 ; $5370
	jr z, Label_10_5380 ; $5372
	cp a, $01 ; $5374
	jr z, Label_10_53aa ; $5376
	ld a, $00 ; $5378
	ld [$cb11], a ; $537a
	jp Label_10_52e4 ; $537d
Label_10_5380:
	ld c, $10 ; $5380
	call BeginFadeOut ; $5382
	call WaitFadeEnd ; $5385
	farcall FarPtr_3e_0c ; $5388
	farcall FarPtr_3e_10 ; $538b
	farcall FarPtr_SaveStorySlot ; $538e
	call DisableLCDSafely ; $5391
	farcall FarPtr_01_0a ; $5394
	farcall FarPtr_39_22 ; $5397
	call EnableLCD ; $539a
	ld c, $10 ; $539d
	call BeginFadeIn ; $539f
	ld a, $00 ; $53a2
	ld [$cb11], a ; $53a4
	jp Label_10_536d ; $53a7
Label_10_53aa:
	ld c, $10 ; $53aa
	call BeginFadeOut ; $53ac
	call WaitFadeEnd ; $53af
	farcall FarPtr_3e_0e ; $53b2
	farcall FarPtr_3e_10 ; $53b5
	farcall FarPtr_SaveStorySlot ; $53b8
	call DisableLCDSafely ; $53bb
	farcall FarPtr_01_0a ; $53be
	farcall FarPtr_39_22 ; $53c1
	call EnableLCD ; $53c4
	ld c, $10 ; $53c7
	call BeginFadeIn ; $53c9
	ld a, $00 ; $53cc
	ld [$cb11], a ; $53ce
	jp Label_10_536d ; $53d1
Label_10_53d4:
	cp a, $03 ; $53d4
	jr nz, Label_10_543d ; $53d6
Label_10_53d8:
	farcall FarPtr_1b_2a ; $53d8
	cp a, $ff ; $53db
	jr nz, Label_10_53e2 ; $53dd
	jp Label_10_52d1 ; $53df
Label_10_53e2:
	or a, a ; $53e2
	jr nz, Label_10_5411 ; $53e3
	ld c, $10 ; $53e5
	call BeginFadeOut ; $53e7
	call WaitFadeEnd ; $53ea
	farcall FarPtr_3b_30 ; $53ed
	ld c, $10 ; $53f0
	call BeginFadeOut ; $53f2
	call WaitFadeEnd ; $53f5
	call DisableLCDSafely ; $53f8
	farcall FarPtr_01_0a ; $53fb
	farcall FarPtr_39_22 ; $53fe
	call EnableLCD ; $5401
	ld c, $10 ; $5404
	call BeginFadeIn ; $5406
	ld a, $00 ; $5409
	ld [$cb11], a ; $540b
	jp Label_10_53d8 ; $540e
Label_10_5411:
	ld c, $10 ; $5411
	call BeginFadeOut ; $5413
	call WaitFadeEnd ; $5416
	farcall FarPtr_1b_2c ; $5419
	ld c, $10 ; $541c
	call BeginFadeOut ; $541e
	call WaitFadeEnd ; $5421
	call DisableLCDSafely ; $5424
	farcall FarPtr_01_0a ; $5427
	farcall FarPtr_39_22 ; $542a
	call EnableLCD ; $542d
	ld c, $10 ; $5430
	call BeginFadeIn ; $5432
	ld a, $00 ; $5435
	ld [$cb11], a ; $5437
	jp Label_10_53d8 ; $543a
Label_10_543d:
	farcall FarPtr_3b_16 ; $543d
	cp a, $ff ; $5440
	jp z, Label_10_52d1 ; $5442
	or a, a ; $5445
	jr nz, Label_10_546c ; $5446
	ld c, $10 ; $5448
	call BeginFadeOut ; $544a
	call WaitFadeEnd ; $544d
	farcall FarPtr_3b_08 ; $5450
	call DisableLCDSafely ; $5453
	farcall FarPtr_01_0a ; $5456
	farcall FarPtr_39_22 ; $5459
	call EnableLCD ; $545c
	ld c, $10 ; $545f
	call BeginFadeIn ; $5461
	ld a, $00 ; $5464
	ld [$cb11], a ; $5466
	jp Label_10_53d4 ; $5469
Label_10_546c:
	cp a, $01 ; $546c
	jr nz, Label_10_5494 ; $546e
	ld c, $10 ; $5470
	call BeginFadeOut ; $5472
	call WaitFadeEnd ; $5475
	farcall FarPtr_Func_3b_44aaAlias1 ; $5478
	call DisableLCDSafely ; $547b
	farcall FarPtr_01_0a ; $547e
	farcall FarPtr_39_22 ; $5481
	call EnableLCD ; $5484
	ld c, $10 ; $5487
	call BeginFadeIn ; $5489
	ld a, $00 ; $548c
	ld [$cb11], a ; $548e
	jp Label_10_53d4 ; $5491
Label_10_5494:
	farcall FarPtr_3b_0a ; $5494
	call DisableLCDSafely ; $5497
	farcall FarPtr_01_0a ; $549a
	farcall FarPtr_39_22 ; $549d
	call EnableLCD ; $54a0
	ld c, $10 ; $54a3
	call BeginFadeIn ; $54a5
	ld a, $00 ; $54a8
	ld [$cb11], a ; $54aa
	jp Label_10_53d4 ; $54ad
	ld c, $10 ; $54b0
	call BeginFadeOut ; $54b2
	call WaitFadeEnd ; $54b5
	ld a, $06 ; $54b8
	farcall FarPtr_3f_00 ; $54ba
	call DisableLCDSafely ; $54bd
	farcall FarPtr_01_0a ; $54c0
	farcall FarPtr_39_22 ; $54c3
	call EnableLCD ; $54c6
	ld c, $10 ; $54c9
	call BeginFadeIn ; $54cb
	ld a, $00 ; $54ce
	ld [$cb11], a ; $54d0
	jp Label_10_4f7c ; $54d3
Label_10_54d6:
	farcall FarPtr_3b_14 ; $54d6
	cp a, $ff ; $54d9
	jp z, Label_10_4f7c ; $54db
	ld b, a ; $54de
	add a, a ; $54df
	ld hl, $54ec ; $54e0
	add a, l ; $54e3
	ld l, a ; $54e4
	jr nc, Label_10_54e8 ; $54e5
	inc h ; $54e7
Label_10_54e8:
	ld a, [hl+] ; $54e8
	ld h, [hl] ; $54e9
	ld l, a ; $54ea
	jp hl ; $54eb
	or a, $54 ; $54ec
	or a, $54 ; $54ee
	or a, $54 ; $54f0
	add hl, sp ; $54f2
	ld d, l ; $54f3
	ld h, l ; $54f4
	ld d, l ; $54f5
	ld a, b ; $54f6
	ld [$c36c], a ; $54f7
	farcall FarPtr_CheckStorySlot ; $54fa
	push bc ; $54fd
	ld c, $10 ; $54fe
	call BeginFadeOut ; $5500
	call WaitFadeEnd ; $5503
	farcall FarPtr_1a_0c ; $5506
	pop bc ; $5509
	or a, a ; $550a
	jr nz, Label_10_5520 ; $550b
	call Func_10_578a ; $550d
	or a, a ; $5510
	jr nz, Label_10_5520 ; $5511
	ld a, b ; $5513
	ld [$c36c], a ; $5514
	ld a, $00 ; $5517
	farcall FarPtr_EraseStorySlotSaveData ; $5519
	xor a, a ; $551c
	ld [$cb1b], a ; $551d
Label_10_5520:
	call DisableLCDSafely ; $5520
	farcall FarPtr_01_0a ; $5523
	farcall FarPtr_39_22 ; $5526
	call EnableLCD ; $5529
	ld c, $10 ; $552c
	call BeginFadeIn ; $552e
	ld a, $00 ; $5531
	ld [$cb11], a ; $5533
	jp Label_10_54d6 ; $5536
	ld c, $10 ; $5539
	call BeginFadeOut ; $553b
	call WaitFadeEnd ; $553e
	ld b, $01 ; $5541
	farcall FarPtr_3e_06 ; $5543
	or a, a ; $5546
	jr z, Label_10_554c ; $5547
	farcall FarPtr_ClearSaveBlock11 ; $5549
Label_10_554c:
	call DisableLCDSafely ; $554c
	farcall FarPtr_01_0a ; $554f
	farcall FarPtr_39_22 ; $5552
	call EnableLCD ; $5555
	ld c, $10 ; $5558
	call BeginFadeIn ; $555a
	ld a, $00 ; $555d
	ld [$cb11], a ; $555f
	jp Label_10_54d6 ; $5562
	ld c, $10 ; $5565
	call BeginFadeOut ; $5567
	call WaitFadeEnd ; $556a
	ld b, $00 ; $556d
	farcall FarPtr_3e_06 ; $556f
	or a, a ; $5572
	jr nz, Label_10_5592 ; $5573
	call DisableLCDSafely ; $5575
	farcall FarPtr_01_0a ; $5578
	farcall FarPtr_39_22 ; $557b
	call EnableLCD ; $557e
	ld c, $10 ; $5581
	call BeginFadeIn ; $5583
	ld a, $00 ; $5586
	ld [$cb11], a ; $5588
	xor a, a ; $558b
	ld [$cb1b], a ; $558c
	jp Label_10_54d6 ; $558f
Label_10_5592:
	farcall FarPtr_ReinitSaveRamPreservingBlock6 ; $5592
	call DisableLCDSafely ; $5595
	farcall FarPtr_01_0a ; $5598
	farcall FarPtr_39_22 ; $559b
	call EnableLCD ; $559e
	ld c, $10 ; $55a1
	call BeginFadeIn ; $55a3
	ld a, $00 ; $55a6
	ld [$cb11], a ; $55a8
	xor a, a ; $55ab
	ld [$cb1b], a ; $55ac
	ld [$cb20], a ; $55af
	jp Label_10_54d6 ; $55b2
	ret ; $55b5
Label_10_55b6:
	farcall FarPtr_RunMatch ; $55b6
	ld a, [$c8a5] ; $55b9
	or a, a ; $55bc
	jr z, Label_10_55d5 ; $55bd
	farcall FarPtr_03_18 ; $55bf
	ld a, $00 ; $55c2
	ld [wStoryModeCurrentLocation], a ; $55c4
	ld a, $01 ; $55c7
	ld [$c295], a ; $55c9
	ld a, $ff ; $55cc
	ld [$c294], a ; $55ce
	ld [$c2a1], a ; $55d1
	ret ; $55d4
Label_10_55d5:
	ld a, [wGameMode] ; $55d5
	cp a, $04 ; $55d8
	jr nz, Label_10_5604 ; $55da
	clear_flag $09, 7 ; $55dc
	xor a, a ; $55df
	ld [$c8a7], a ; $55e0
	ld b, $00 ; $55e3
	ld c, $01 ; $55e5
	farcall FarPtr_0a_62 ; $55e7
	farcall FarPtr_03_18 ; $55ea
	test_flag $02, 5 ; $55ed
	jr nz, Label_10_55fb ; $55f0
	ld a, $02 ; $55f2
	ld [$c294], a ; $55f4
	ld [$c2a1], a ; $55f7
	ret ; $55fa
Label_10_55fb:
	ld a, $03 ; $55fb
	ld [$c294], a ; $55fd
	ld [$c2a1], a ; $5600
	ret ; $5603
Label_10_5604:
	ld a, [$c8f7] ; $5604
	cp a, $14 ; $5607
	jr c, Label_10_561e ; $5609
	ld a, $1c ; $560b
	ld [wStoryModeCurrentLocation], a ; $560d
	ld a, $0a ; $5610
	ld [$c295], a ; $5612
	ld a, $ff ; $5615
	ld [$c294], a ; $5617
	ld [$c2a1], a ; $561a
	ret ; $561d
Label_10_561e:
	cp a, $0f ; $561e
	jr c, Label_10_564d ; $5620
	test_flag $05, 7 ; $5622
	jr nz, Label_10_563a ; $5625
	ld a, $19 ; $5627
	ld [wStoryModeCurrentLocation], a ; $5629
	ld a, $0a ; $562c
	ld [$c295], a ; $562e
	ld a, $ff ; $5631
	ld [$c294], a ; $5633
	ld [$c2a1], a ; $5636
	ret ; $5639
Label_10_563a:
	ld a, $19 ; $563a
	ld [wStoryModeCurrentLocation], a ; $563c
	ld a, $0b ; $563f
	ld [$c295], a ; $5641
	ld a, $ff ; $5644
	ld [$c294], a ; $5646
	ld [$c2a1], a ; $5649
	ret ; $564c
Label_10_564d:
	cp a, $0a ; $564d
	jr c, Label_10_5664 ; $564f
	ld a, $07 ; $5651
	ld [wStoryModeCurrentLocation], a ; $5653
	ld a, $0d ; $5656
	ld [$c295], a ; $5658
	ld a, $ff ; $565b
	ld [$c294], a ; $565d
	ld [$c2a1], a ; $5660
	ret ; $5663
Label_10_5664:
	cp a, $05 ; $5664
	jr c, Label_10_5690 ; $5666
	jr z, Label_10_567d ; $5668
	ld a, $10 ; $566a
	ld [wStoryModeCurrentLocation], a ; $566c
	ld a, $0f ; $566f
	ld [$c295], a ; $5671
	ld a, $ff ; $5674
	ld [$c294], a ; $5676
	ld [$c2a1], a ; $5679
	ret ; $567c
Label_10_567d:
	ld a, $10 ; $567d
	ld [wStoryModeCurrentLocation], a ; $567f
	ld a, $09 ; $5682
	ld [$c295], a ; $5684
	ld a, $ff ; $5687
	ld [$c294], a ; $5689
	ld [$c2a1], a ; $568c
	ret ; $568f
Label_10_5690:
	test_flag $05, 7 ; $5690
	jr nz, Label_10_56bf ; $5693
	cp a, $00 ; $5695
	jr z, Label_10_56ac ; $5697
	ld a, $0b ; $5699
	ld [wStoryModeCurrentLocation], a ; $569b
	ld a, $0f ; $569e
	ld [$c295], a ; $56a0
	ld a, $ff ; $56a3
	ld [$c294], a ; $56a5
	ld [$c2a1], a ; $56a8
	ret ; $56ab
Label_10_56ac:
	ld a, $0b ; $56ac
	ld [wStoryModeCurrentLocation], a ; $56ae
	ld a, $09 ; $56b1
	ld [$c295], a ; $56b3
	ld a, $ff ; $56b6
	ld [$c294], a ; $56b8
	ld [$c2a1], a ; $56bb
	ret ; $56be
Label_10_56bf:
	cp a, $00 ; $56bf
	jr z, Label_10_56d6 ; $56c1
	ld a, $0c ; $56c3
	ld [wStoryModeCurrentLocation], a ; $56c5
	ld a, $0f ; $56c8
	ld [$c295], a ; $56ca
	ld a, $ff ; $56cd
	ld [$c294], a ; $56cf
	ld [$c2a1], a ; $56d2
	ret ; $56d5
Label_10_56d6:
	ld a, $0c ; $56d6
	ld [wStoryModeCurrentLocation], a ; $56d8
	ld a, $09 ; $56db
	ld [$c295], a ; $56dd
	ld a, $ff ; $56e0
	ld [$c294], a ; $56e2
	ld [$c2a1], a ; $56e5
	ret ; $56e8
Func_10_56e9:
	ld hl, $56f3 ; $56e9
	add a, l ; $56ec
	ld l, a ; $56ed
	jr nc, Label_10_56f1 ; $56ee
	inc h ; $56f0
Label_10_56f1:
	ld a, [hl] ; $56f1
	ret ; $56f2
	; $56f3, 9 bytes (bytes:16)
	db $1c, $1d, $1e, $1f, $20, $21, $22, $23, $24 ; 0x00
Func_10_56fc:
	push af ; $56fc
	ldh a, [hWramBank] ; $56fd
	push af ; $56ff
	wram_bank $03 ; $5700
	ld hl, $d816 ; $5706
	ld de, $c8b5 ; $5709
	ld a, [hl+] ; $570c
	ld [de], a ; $570d
	inc de ; $570e
	ld a, [hl+] ; $570f
	ld [de], a ; $5710
	inc de ; $5711
	ld a, [hl+] ; $5712
	ld [de], a ; $5713
	inc de ; $5714
	ld a, [hl+] ; $5715
	ld [de], a ; $5716
	pop af ; $5717
	wram_bank ; $5718
	pop af ; $571c
	ret ; $571d
	ld a, [$c36c] ; $571e
	push af ; $5721
	xor a, a ; $5722
	ld [$c36c], a ; $5723
	farcall FarPtr_CheckStorySlot ; $5726
	cp a, $fe ; $5729
	jr nz, Label_10_574b ; $572b
	ld a, $01 ; $572d
	ld [$c36c], a ; $572f
	farcall FarPtr_CheckStorySlot ; $5732
	cp a, $fe ; $5735
	jr nz, Label_10_574b ; $5737
	ld a, $02 ; $5739
	ld [$c36c], a ; $573b
	farcall FarPtr_CheckStorySlot ; $573e
	cp a, $fe ; $5741
	jr nz, Label_10_574b ; $5743
	pop af ; $5745
	xor a, a ; $5746
	ld [$c36c], a ; $5747
	ret ; $574a
Label_10_574b:
	pop af ; $574b
	ld [$c36c], a ; $574c
	ld a, $01 ; $574f
	ret ; $5751
Func_10_5752:
	test_flag $05, 7 ; $5752
	jr nz, Label_10_5770 ; $5755
	test_flag $07, 4 ; $5757
	ld a, $02 ; $575a
	jr z, Label_10_5789 ; $575c
	test_flag $16, 0 ; $575e
	ld a, $04 ; $5761
	jr z, Label_10_5789 ; $5763
	test_flag $16, 2 ; $5765
	ld a, $05 ; $5768
	jr z, Label_10_5789 ; $576a
	ld a, $02 ; $576c
	jr Label_10_5789 ; $576e
Label_10_5770:
	test_flag $06, 5 ; $5770
	ld a, $02 ; $5773
	jr z, Label_10_5789 ; $5775
	test_flag $16, 1 ; $5777
	ld a, $04 ; $577a
	jr z, Label_10_5789 ; $577c
	test_flag $16, 3 ; $577e
	ld a, $05 ; $5781
	jr z, Label_10_5789 ; $5783
	ld a, $02 ; $5785
	jr Label_10_5789 ; $5787
Label_10_5789:
	ret ; $5789
Func_10_578a:
	push af ; $578a
	push bc ; $578b
	farcall FarPtr_03_24 ; $578c
	bit 7, a ; $578f
	jr nz, Label_10_57f3 ; $5791
	ld a, [$c8a5] ; $5793
	or a, a ; $5796
	jr z, Label_10_57f3 ; $5797
	ld a, [$c36c] ; $5799
	ld b, a ; $579c
	ld a, [$c8b5] ; $579d
	bit 7, a ; $57a0
	jr z, Label_10_57ab ; $57a2
	and a, $7f ; $57a4
	srl a ; $57a6
	cp a, b ; $57a8
	jr z, Label_10_57d7 ; $57a9
Label_10_57ab:
	ld a, [$c8b6] ; $57ab
	bit 7, a ; $57ae
	jr z, Label_10_57b9 ; $57b0
	and a, $7f ; $57b2
	srl a ; $57b4
	cp a, b ; $57b6
	jr z, Label_10_57d7 ; $57b7
Label_10_57b9:
	ld a, [$c8b7] ; $57b9
	bit 7, a ; $57bc
	jr z, Label_10_57c7 ; $57be
	and a, $7f ; $57c0
	srl a ; $57c2
	cp a, b ; $57c4
	jr z, Label_10_57d7 ; $57c5
Label_10_57c7:
	ld a, [$c8b8] ; $57c7
	bit 7, a ; $57ca
	jr z, Label_10_57d5 ; $57cc
	and a, $7f ; $57ce
	srl a ; $57d0
	cp a, b ; $57d2
	jr z, Label_10_57d7 ; $57d3
Label_10_57d5:
	jr Label_10_57f3 ; $57d5
Label_10_57d7:
	ld b, $02 ; $57d7
	farcall FarPtr_3e_06 ; $57d9
	or a, a ; $57dc
	jr z, Label_10_57ee ; $57dd
	xor a, a ; $57df
	ld [$c8a5], a ; $57e0
	ld [$c8a7], a ; $57e3
	farcall FarPtr_03_26 ; $57e6
	pop bc ; $57e9
	pop af ; $57ea
	ld a, $00 ; $57eb
	ret ; $57ed
Label_10_57ee:
	pop bc ; $57ee
	pop af ; $57ef
	ld a, $01 ; $57f0
	ret ; $57f2
Label_10_57f3:
	pop bc ; $57f3
	pop af ; $57f4
	ret ; $57f5
Data_10_57f6:
	; $57f6, 14 bytes (records:2)
; 7 records x 2 bytes
	dw $5870 ; record 0
	dw $5879 ; record 1
	dw $5804 ; record 2
	dw $5a17 ; record 3
	dw $5a50 ; record 4
	dw $5a51 ; record 5
	dw $5a52 ; record 6
	; $5804, 108 bytes (bytes:14)
	db $00, $00, $d1, $7b, $00, $3b, $00, $37, $40, $00, $30, $01, $00, $00 ; 0x00
	db $00, $00, $d1, $7b, $00, $3d, $00, $39, $80, $00, $30, $01, $05, $00 ; 0x0e
	db $00, $00, $d1, $7b, $00, $3d, $00, $3b, $80, $00, $3a, $01, $00, $00 ; 0x1c
	db $00, $00, $d1, $7b, $00, $2f, $00, $31, $00, $00, $3a, $01, $07, $00 ; 0x2a
	db $00, $00, $d1, $7b, $00, $33, $00, $31, $80, $00, $3b, $01, $00, $00 ; 0x38
	db $00, $00, $d1, $7b, $00, $37, $00, $2f, $00, $00, $3c, $01, $00, $00 ; 0x46
	db $00, $00, $d1, $7b, $00, $3b, $00, $2f, $80, $00, $3b, $01, $04, $00 ; 0x54
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $ff ; 0x62
	; $5870, 9 bytes (bytes:16)
	db $01, $40, $00, $27, $00, $37, $00, $00, $ff ; 0x00
	; $5879, 9 bytes (records:8)
; 1 records x 8 bytes
	dw $ff03, $0000, $7b1f, $020d ; record 0
	db $ff
	ld a, [$c2b0] ; $5882
	add a, a ; $5885
	add a, $99 ; $5886
	ld l, a ; $5888
	adc a, $58 ; $5889
	sub a, l ; $588b
	ld h, a ; $588c
	ld a, [hl+] ; $588d
	ld h, [hl] ; $588e
	ld l, a ; $588f
	farcall FarPtr_InitDialogueTextCursor ; $5890
	ld a, $03 ; $5893
	farcall FarPtr_ScriptShowSpeakerDialogue ; $5895
	ret ; $5898
	; $5899, 20 bytes (records:2)
; 10 records x 2 bytes
	dw $0c3b ; record 0
	dw $0c3c ; record 1
	dw $0c62 ; record 2
	dw $0c63 ; record 3
	dw $0c8f ; record 4
	dw $0c8f ; record 5
	dw $0cb7 ; record 6
	dw $0cb7 ; record 7
	dw $0cda ; record 8
	dw $0cda ; record 9
	ld a, [$c2b1] ; $58ad
	add a, a ; $58b0
	add a, $21 ; $58b1
	ld l, a ; $58b3
	adc a, $59 ; $58b4
	sub a, l ; $58b6
	ld h, a ; $58b7
	ld a, [hl+] ; $58b8
	ld h, [hl] ; $58b9
	ld l, a ; $58ba
	farcall FarPtr_InitDialogueTextCursor ; $58bb
	ld a, [$c2b1] ; $58be
	cp a, $03 ; $58c1
	jr c, Label_10_58e4 ; $58c3
	ld a, [$c2b1] ; $58c5
	cp a, $04 ; $58c8
	jr z, Label_10_58ea ; $58ca
	ld a, $04 ; $58cc
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $58ce
	farcall FarPtr_RunDialogueYesNoPrompt ; $58d1
	farcall FarPtr_ScriptCloseDialogueWindow ; $58d4
	push af ; $58d7
	ld a, $05 ; $58d8
	farcall FarPtr_WaitScriptFrames ; $58da
	pop af ; $58dd
	and a, a ; $58de
	jr z, Label_10_58e4 ; $58df
	farcall FarPtr_AdvanceDialogueTextCursor ; $58e1
Label_10_58e4:
	ld a, $04 ; $58e4
	farcall FarPtr_ScriptShowSpeakerDialogue ; $58e6
	ret ; $58e9
Label_10_58ea:
	ld a, [$c2b0] ; $58ea
	cp a, $09 ; $58ed
	jr nz, Label_10_58f4 ; $58ef
	farcall FarPtr_AdvanceDialogueTextCursor ; $58f1
Label_10_58f4:
	ld a, $04 ; $58f4
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $58f6
	farcall FarPtr_RunDialogueYesNoPrompt ; $58f9
	farcall FarPtr_ScriptCloseDialogueWindow ; $58fc
	push af ; $58ff
	ld a, $05 ; $5900
	farcall FarPtr_WaitScriptFrames ; $5902
	pop af ; $5905
	and a, a ; $5906
	jr z, Label_10_5915 ; $5907
	ld hl, $0cde ; $5909
	farcall FarPtr_InitDialogueTextCursor ; $590c
	ld a, $04 ; $590f
	farcall FarPtr_ScriptShowSpeakerDialogue ; $5911
	ret ; $5914
Label_10_5915:
	ld hl, $0cdd ; $5915
	farcall FarPtr_InitDialogueTextCursor ; $5918
	ld a, $04 ; $591b
	farcall FarPtr_ScriptShowSpeakerDialogue ; $591d
	ret ; $5920
	; $5921, 10 bytes (records:2)
; 5 records x 2 bytes
	dw $0c3d ; record 0
	dw $0c64 ; record 1
	dw $0c90 ; record 2
	dw $0cb8 ; record 3
	dw $0cdb ; record 4
	ld a, [$c2b1] ; $592b
	add a, a ; $592e
	add a, $61 ; $592f
	ld l, a ; $5931
	adc a, $59 ; $5932
	sub a, l ; $5934
	ld h, a ; $5935
	ld a, [hl+] ; $5936
	ld h, [hl] ; $5937
	ld l, a ; $5938
	farcall FarPtr_InitDialogueTextCursor ; $5939
	ld a, [$c2b1] ; $593c
	cp a, $01 ; $593f
	jr nz, Label_10_595b ; $5941
	ld a, $05 ; $5943
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $5945
	farcall FarPtr_RunDialogueYesNoPrompt ; $5948
	farcall FarPtr_ScriptCloseDialogueWindow ; $594b
	push af ; $594e
	ld a, $05 ; $594f
	farcall FarPtr_WaitScriptFrames ; $5951
	pop af ; $5954
	and a, a ; $5955
	jr z, Label_10_595b ; $5956
	farcall FarPtr_AdvanceDialogueTextCursor ; $5958
Label_10_595b:
	ld a, $05 ; $595b
	farcall FarPtr_ScriptShowSpeakerDialogue ; $595d
	ret ; $5960
	; $5961, 10 bytes (records:2)
; 5 records x 2 bytes
	dw $0c3e ; record 0
	dw $0c65 ; record 1
	dw $0c91 ; record 2
	dw $0cbb ; record 3
	dw $0cdf ; record 4
	ld a, [$c2b0] ; $596b
	add a, a ; $596e
	add a, $82 ; $596f
	ld l, a ; $5971
	adc a, $59 ; $5972
	sub a, l ; $5974
	ld h, a ; $5975
	ld a, [hl+] ; $5976
	ld h, [hl] ; $5977
	ld l, a ; $5978
	farcall FarPtr_InitDialogueTextCursor ; $5979
	ld a, $06 ; $597c
	farcall FarPtr_ScriptShowSpeakerDialogue ; $597e
	ret ; $5981
	; $5982, 20 bytes (records:2)
; 10 records x 2 bytes
	dw $0c3f ; record 0
	dw $0c3f ; record 1
	dw $0c68 ; record 2
	dw $0c69 ; record 3
	dw $0c92 ; record 4
	dw $0c93 ; record 5
	dw $0cbc ; record 6
	dw $0cbd ; record 7
	dw $0cbc ; record 8
	dw $0cbd ; record 9
	ld a, [$c2b0] ; $5996
	add a, a ; $5999
	add a, $ad ; $599a
	ld l, a ; $599c
	adc a, $59 ; $599d
	sub a, l ; $599f
	ld h, a ; $59a0
	ld a, [hl+] ; $59a1
	ld h, [hl] ; $59a2
	ld l, a ; $59a3
	farcall FarPtr_InitDialogueTextCursor ; $59a4
	ld a, $07 ; $59a7
	farcall FarPtr_ScriptShowSpeakerDialogue ; $59a9
	ret ; $59ac
	; $59ad, 20 bytes (records:2)
; 10 records x 2 bytes
	dw $0c40 ; record 0
	dw $0c40 ; record 1
	dw $0c6a ; record 2
	dw $0c6b ; record 3
	dw $0c94 ; record 4
	dw $0c95 ; record 5
	dw $0cbe ; record 6
	dw $0cbf ; record 7
	dw $0cbe ; record 8
	dw $0cbf ; record 9
	ld a, [$c2b0] ; $59c1
	add a, a ; $59c4
	add a, $d8 ; $59c5
	ld l, a ; $59c7
	adc a, $59 ; $59c8
	sub a, l ; $59ca
	ld h, a ; $59cb
	ld a, [hl+] ; $59cc
	ld h, [hl] ; $59cd
	ld l, a ; $59ce
	farcall FarPtr_InitDialogueTextCursor ; $59cf
	ld a, $08 ; $59d2
	farcall FarPtr_ScriptShowSpeakerDialogue ; $59d4
	ret ; $59d7
	; $59d8, 20 bytes (records:2)
; 10 records x 2 bytes
	dw $0c41 ; record 0
	dw $0c41 ; record 1
	dw $0c6c ; record 2
	dw $0c6c ; record 3
	dw $0c96 ; record 4
	dw $0c97 ; record 5
	dw $0cc0 ; record 6
	dw $0cc1 ; record 7
	dw $0ce0 ; record 8
	dw $0cc1 ; record 9
	ld a, [$c2b0] ; $59ec
	add a, a ; $59ef
	add a, $03 ; $59f0
	ld l, a ; $59f2
	adc a, $5a ; $59f3
	sub a, l ; $59f5
	ld h, a ; $59f6
	ld a, [hl+] ; $59f7
	ld h, [hl] ; $59f8
	ld l, a ; $59f9
	farcall FarPtr_InitDialogueTextCursor ; $59fa
	ld a, $09 ; $59fd
	farcall FarPtr_ScriptShowSpeakerDialogue ; $59ff
	ret ; $5a02
	; $5a03, 20 bytes (records:2)
; 10 records x 2 bytes
	dw $0c42 ; record 0
	dw $0c42 ; record 1
	dw $0c6d ; record 2
	dw $0c6d ; record 3
	dw $0c98 ; record 4
	dw $0c98 ; record 5
	dw $0cc2 ; record 6
	dw $0cc3 ; record 7
	dw $0cc2 ; record 8
	dw $0cc3 ; record 9
	; $5a17, 59 bytes (records:8)
; 7 records x 8 bytes
	dw $ff03, $0000, $5882, $0003 ; record 0
	dw $ff04, $0000, $58ad, $0003 ; record 1
	dw $ff05, $0000, $592b, $0003 ; record 2
	dw $ff06, $0000, $596b, $0003 ; record 3
	dw $ff07, $0000, $5996, $0003 ; record 4
	dw $ff08, $0000, $59c1, $0003 ; record 5
	dw $ff09, $0000, $59ec, $0003 ; record 6
	db $ff, $ff, $ff
	call Func_10_7dbd ; $5a52
	ld a, [$c2b0] ; $5a55
	sra a ; $5a58
	ld [$c2b1], a ; $5a5a
	ld a, $22 ; $5a5d
	ld [$c329], a ; $5a5f
	ld a, $26 ; $5a62
	ld [$c32a], a ; $5a64
	ld a, $40 ; $5a67
	ld [$c32b], a ; $5a69
	ld a, $3e ; $5a6c
	ld [$c32c], a ; $5a6e
	call DisableLCDSafely ; $5a71
	ld a, $00 ; $5a74
	farcall FarPtr_CopyScrolledSceneTilemapToVram ; $5a76
	call EnableLCD ; $5a79
	call Func_10_7b5f ; $5a7c
	ret ; $5a7f
Data_10_5a80:
	; $5a80, 14 bytes (records:2)
; 7 records x 2 bytes
	dw $5b86 ; record 0
	dw $5bdd ; record 1
	dw $5a8e ; record 2
	dw $6076 ; record 3
	dw $60ef ; record 4
	dw $60f0 ; record 5
	dw $60f1 ; record 6
	; $5a8e, 248 bytes (bytes:14)
	db $00, $00, $d1, $7b, $00, $11, $00, $19, $80, $00, $2f, $01, $00, $00 ; 0x00
	db $00, $00, $d1, $7b, $00, $21, $00, $15, $c0, $00, $2f, $01, $07, $00 ; 0x0e
	db $00, $00, $d1, $7b, $00, $16, $00, $13, $40, $00, $30, $01, $00, $00 ; 0x1c
	db $00, $00, $d1, $7b, $00, $1d, $00, $17, $c0, $00, $31, $01, $00, $00 ; 0x2a
	db $00, $00, $d1, $7b, $00, $29, $00, $29, $00, $00, $4c, $01, $00, $00 ; 0x38
	db $00, $00, $d1, $7b, $00, $21, $00, $11, $00, $00, $33, $01, $00, $00 ; 0x46
	db $00, $00, $d1, $7b, $00, $09, $00, $0f, $00, $00, $34, $01, $00, $00 ; 0x54
	db $00, $00, $db, $7b, $00, $0b, $00, $19, $80, $00, $30, $01, $06, $00 ; 0x62
	db $00, $00, $d1, $7b, $00, $0d, $00, $0f, $80, $00, $3a, $01, $00, $00 ; 0x70
	db $00, $00, $d1, $7b, $00, $15, $00, $0b, $80, $00, $33, $01, $00, $00 ; 0x7e
	db $00, $00, $d1, $7b, $00, $1d, $00, $0b, $80, $00, $3c, $01, $04, $00 ; 0x8c
	db $00, $00, $d1, $7b, $00, $1b, $00, $09, $40, $00, $3b, $01, $00, $00 ; 0x9a
	db $00, $00, $d1, $7b, $00, $1d, $00, $0f, $80, $00, $3c, $01, $00, $00 ; 0xa8
	db $00, $00, $d1, $7b, $00, $19, $00, $0f, $00, $00, $3b, $01, $06, $00 ; 0xb6
	db $00, $00, $d1, $7b, $00, $29, $00, $29, $00, $00, $4f, $01, $00, $00 ; 0xc4
	db $00, $00, $d1, $7b, $00, $1b, $00, $12, $40, $00, $3a, $01, $00, $00 ; 0xd2
	db $00, $00, $d1, $7b, $00, $19, $00, $09, $40, $00, $35, $01, $00, $00 ; 0xe0
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $ff ; 0xee
	; $5b86, 17 bytes (bytes:16)
	db $01, $c0, $00, $0c, $00, $21, $97, $5b, $02, $40, $00, $05, $00, $17, $5f, $7b ; 0x00
	db $ff ; 0x10
	ld a, [$c295] ; $5b97
	cp a, $ff ; $5b9a
	jp z, Label_10_5bdc ; $5b9c
	test_flag $05, 7 ; $5b9f
	jr z, Label_10_5bca ; $5ba2
	ld a, $02 ; $5ba4
	ld bc, $00ff ; $5ba6
	farcall FarPtr_0a_18 ; $5ba9
	ld a, $02 ; $5bac
	ld b, $40 ; $5bae
	ld de, $0200 ; $5bb0
	farcall FarPtr_MoveActorByAngle ; $5bb3
	ld a, $02 ; $5bb6
	farcall FarPtr_ScriptWaitActorMoveDone ; $5bb8
	ld a, $02 ; $5bbb
	ld b, $c0 ; $5bbd
	farcall FarPtr_SetActorFacing ; $5bbf
	ld a, $02 ; $5bc2
	ld bc, $0010 ; $5bc4
	farcall FarPtr_0a_18 ; $5bc7
Label_10_5bca:
	ld a, $00 ; $5bca
	ld bc, $0010 ; $5bcc
	farcall FarPtr_0a_18 ; $5bcf
	ld a, $00 ; $5bd2
	ld b, $c0 ; $5bd4
	ld de, $0200 ; $5bd6
	farcall FarPtr_MoveActorByAngle ; $5bd9
Label_10_5bdc:
	ret ; $5bdc
	; $5bdd, 17 bytes (records:8)
; 2 records x 8 bytes
	dw $ff01, $0000, $5bee, $0208 ; record 0
	dw $ff02, $0000, $7ae6, $010e ; record 1
	db $ff
	clear_flag $0f, 3 ; $5bee
	ret ; $5bf1
	ld a, [$c2b1] ; $5bf2
	add a, a ; $5bf5
	add a, $13 ; $5bf6
	ld l, a ; $5bf8
	adc a, $5c ; $5bf9
	sub a, l ; $5bfb
	ld h, a ; $5bfc
	ld a, [hl+] ; $5bfd
	ld h, [hl] ; $5bfe
	ld l, a ; $5bff
	farcall FarPtr_InitDialogueTextCursor ; $5c00
	ld a, [$c2b0] ; $5c03
	cp a, $03 ; $5c06
	jr nz, Label_10_5c0d ; $5c08
	farcall FarPtr_AdvanceDialogueTextCursor ; $5c0a
Label_10_5c0d:
	ld a, $03 ; $5c0d
	farcall FarPtr_ScriptShowSpeakerDialogue ; $5c0f
	ret ; $5c12
	; $5c13, 10 bytes (records:2)
; 5 records x 2 bytes
	dw $0c21 ; record 0
	dw $0c44 ; record 1
	dw $0c6f ; record 2
	dw $0c99 ; record 3
	dw $0cc4 ; record 4
	ld a, [$c2b1] ; $5c1d
	add a, a ; $5c20
	add a, $34 ; $5c21
	ld l, a ; $5c23
	adc a, $5c ; $5c24
	sub a, l ; $5c26
	ld h, a ; $5c27
	ld a, [hl+] ; $5c28
	ld h, [hl] ; $5c29
	ld l, a ; $5c2a
	farcall FarPtr_InitDialogueTextCursor ; $5c2b
	ld a, $04 ; $5c2e
	farcall FarPtr_ScriptShowSpeakerDialogue ; $5c30
	ret ; $5c33
	; $5c34, 10 bytes (records:2)
; 5 records x 2 bytes
	dw $0c22 ; record 0
	dw $0c46 ; record 1
	dw $0c70 ; record 2
	dw $0c9a ; record 3
	dw $0cc5 ; record 4
	ld a, $00 ; $5c3e
	ld b, a ; $5c40
	ld a, $05 ; $5c41
	farcall FarPtr_FaceActorTowardActor ; $5c43
	ld a, [$c2b0] ; $5c46
	add a, a ; $5c49
	add a, $9c ; $5c4a
	ld l, a ; $5c4c
	adc a, $5c ; $5c4d
	sub a, l ; $5c4f
	ld h, a ; $5c50
	ld a, [hl+] ; $5c51
	ld h, [hl] ; $5c52
	ld l, a ; $5c53
	farcall FarPtr_InitDialogueTextCursor ; $5c54
	ld a, $05 ; $5c57
	farcall FarPtr_ScriptShowSpeakerDialogue ; $5c59
	ld a, $05 ; $5c5c
	ld b, $40 ; $5c5e
	farcall FarPtr_SetActorFacing ; $5c60
	ld a, $05 ; $5c63
	ld d, $02 ; $5c65
	farcall FarPtr_ScriptSetActorAnimation ; $5c67
	ld a, $05 ; $5c6a
	farcall FarPtr_ScriptWaitActorIdle ; $5c6c
	ld a, $05 ; $5c6f
	farcall FarPtr_ScriptShowSpeakerDialogue ; $5c71
	ld a, $00 ; $5c74
	ld b, a ; $5c76
	ld a, $05 ; $5c77
	farcall FarPtr_FaceActorTowardActor ; $5c79
	ld a, $05 ; $5c7c
	ld d, $04 ; $5c7e
	farcall FarPtr_ScriptSetActorAnimation ; $5c80
	ld a, $05 ; $5c83
	farcall FarPtr_ScriptWaitActorIdle ; $5c85
	ld a, $05 ; $5c88
	farcall FarPtr_ScriptShowSpeakerDialogue ; $5c8a
	push af ; $5c8d
	ld a, $14 ; $5c8e
	farcall FarPtr_WaitScriptFrames ; $5c90
	pop af ; $5c93
	ld a, $05 ; $5c94
	ld b, $40 ; $5c96
	farcall FarPtr_SetActorFacing ; $5c98
	ret ; $5c9b
	; $5c9c, 105 bytes (records:2)
; 52 records x 2 bytes
	dw $0c23 ; record 0
	dw $0c23 ; record 1
	dw $0c47 ; record 2
	dw $0c47 ; record 3
	dw $0c71 ; record 4
	dw $0c74 ; record 5
	dw $0c9b ; record 6
	dw $0c9e ; record 7
	dw $0cc6 ; record 8
	dw $0cc6 ; record 9
	dw $063e ; record 10
	dw $0416 ; record 11
	dw $34df ; record 12
	dw $3e0a ; record 13
	dw $df06 ; record 14
	dw $0a36 ; record 15
	dw $b1fa ; record 16
	dw $87c2 ; record 17
	dw $fbc6 ; record 18
	dw $ce6f ; record 19
	dw $955c ; record 20
	dw $2a67 ; record 21
	dw $6f66 ; record 22
	dw $0edf ; record 23
	dw $fa0a ; record 24
	dw $c2b0 ; record 25
	dw $05fe ; record 26
	dw $0620 ; record 27
	dw $10df ; record 28
	dw $df0a ; record 29
	dw $0a10 ; record 30
	dw $063e ; record 31
	dw $08df ; record 32
	dw $fa0a ; record 33
	dw $c2b1 ; record 34
	dw $00fe ; record 35
	dw $0320 ; record 36
	dw $5acd ; record 37
	dw $3e61 ; record 38
	dw $1606 ; record 39
	dw $df03 ; record 40
	dw $0a34 ; record 41
	dw $063e ; record 42
	dw $36df ; record 43
	dw $3e0a ; record 44
	dw $df06 ; record 45
	dw $0a08 ; record 46
	dw $26c9 ; record 47
	dw $4a0c ; record 48
	dw $770c ; record 49
	dw $a10c ; record 50
	dw $c90c ; record 51
	db $0c
	call Func_10_612c ; $5d05
	jp nz, Label_10_5db6 ; $5d08
	ld a, $12 ; $5d0b
	ld d, $03 ; $5d0d
	farcall FarPtr_ScriptSetActorAnimation ; $5d0f
	ld a, $12 ; $5d12
	farcall FarPtr_ScriptWaitActorIdle ; $5d14
	ld a, [$c2b1] ; $5d17
	add a, a ; $5d1a
	add a, $dc ; $5d1b
	ld l, a ; $5d1d
	adc a, $5d ; $5d1e
	sub a, l ; $5d20
	ld h, a ; $5d21
	ld a, [hl+] ; $5d22
	ld h, [hl] ; $5d23
	ld l, a ; $5d24
	farcall FarPtr_InitDialogueTextCursor ; $5d25
	ld a, $12 ; $5d28
	farcall FarPtr_ScriptShowSpeakerDialogue ; $5d2a
	ld a, $00 ; $5d2d
	ld b, a ; $5d2f
	ld a, $12 ; $5d30
	farcall FarPtr_FaceActorTowardActor ; $5d32
	ld a, $07 ; $5d35
	ld bc, $1c00 ; $5d37
	ld de, $1100 ; $5d3a
	farcall FarPtr_ScriptSetActorPosition ; $5d3d
	sound $97 ; $5d40
	ld a, $12 ; $5d42
	ld d, $02 ; $5d44
	farcall FarPtr_ScriptSetActorAnimation ; $5d46
	push af ; $5d49
	ld a, $28 ; $5d4a
	farcall FarPtr_WaitScriptFrames ; $5d4c
	pop af ; $5d4f
	ld a, $07 ; $5d50
	ld bc, $3f00 ; $5d52
	ld de, $3f00 ; $5d55
	farcall FarPtr_ScriptSetActorPosition ; $5d58
	ld a, $12 ; $5d5b
	farcall FarPtr_ScriptShowSpeakerDialogue ; $5d5d
	ld a, $12 ; $5d60
	ld b, $40 ; $5d62
	farcall FarPtr_SetActorFacing ; $5d64
	push af ; $5d67
	ld a, $14 ; $5d68
	farcall FarPtr_WaitScriptFrames ; $5d6a
	pop af ; $5d6d
	ld a, $12 ; $5d6e
	ld b, $01 ; $5d70
	farcall FarPtr_0a_2c ; $5d72
	ld a, $12 ; $5d75
	ld b, $c0 ; $5d77
	ld de, $0100 ; $5d79
	farcall FarPtr_MoveActorByAngle ; $5d7c
	call Func_10_613e ; $5d7f
	ld a, $00 ; $5d82
	ld b, a ; $5d84
	ld a, $12 ; $5d85
	farcall FarPtr_FaceActorTowardActor ; $5d87
	ld a, [$c2b1] ; $5d8a
	add a, a ; $5d8d
	add a, $dc ; $5d8e
	ld l, a ; $5d90
	adc a, $5d ; $5d91
	sub a, l ; $5d93
	ld h, a ; $5d94
	ld a, [hl+] ; $5d95
	ld h, [hl] ; $5d96
	ld l, a ; $5d97
	ld a, $02 ; $5d98
	add a, l ; $5d9a
	ld l, a ; $5d9b
	jr nc, Label_10_5d9f ; $5d9c
	inc h ; $5d9e
Label_10_5d9f:
	farcall FarPtr_InitDialogueTextCursor ; $5d9f
	ld a, $12 ; $5da2
	farcall FarPtr_ScriptShowSpeakerDialogue ; $5da4
	ld a, $12 ; $5da7
	ld b, $00 ; $5da9
	farcall FarPtr_0a_2c ; $5dab
	ld a, $12 ; $5dae
	ld b, $40 ; $5db0
	farcall FarPtr_SetActorFacing ; $5db2
	ret ; $5db5
Label_10_5db6:
	ld a, $00 ; $5db6
	ld b, a ; $5db8
	ld a, $12 ; $5db9
	farcall FarPtr_FaceActorTowardActor ; $5dbb
	ld a, [$c2b1] ; $5dbe
	add a, a ; $5dc1
	add a, $dc ; $5dc2
	ld l, a ; $5dc4
	adc a, $5d ; $5dc5
	sub a, l ; $5dc7
	ld h, a ; $5dc8
	ld a, [hl+] ; $5dc9
	ld h, [hl] ; $5dca
	ld l, a ; $5dcb
	ld a, $02 ; $5dcc
	add a, l ; $5dce
	ld l, a ; $5dcf
	jr nc, Label_10_5dd3 ; $5dd0
	inc h ; $5dd2
Label_10_5dd3:
	farcall FarPtr_InitDialogueTextCursor ; $5dd3
	ld a, $12 ; $5dd6
	farcall FarPtr_ScriptShowSpeakerDialogue ; $5dd8
	ret ; $5ddb
	; $5ddc, 10 bytes (records:2)
; 5 records x 2 bytes
	dw $0c28 ; record 0
	dw $0c4c ; record 1
	dw $0c7b ; record 2
	dw $0ca3 ; record 3
	dw $0ccb ; record 4
	set_flag $1c, 1 ; $5de6
	test_flag $0f, 3 ; $5de9
	jr nz, Label_10_5e5c ; $5dec
	ld a, [$c2b1] ; $5dee
	add a, a ; $5df1
	add a, $81 ; $5df2
	ld l, a ; $5df4
	adc a, $5e ; $5df5
	sub a, l ; $5df7
	ld h, a ; $5df8
	ld a, [hl+] ; $5df9
	ld h, [hl] ; $5dfa
	ld l, a ; $5dfb
	farcall FarPtr_InitDialogueTextCursor ; $5dfc
	ld a, $08 ; $5dff
	farcall FarPtr_ScriptShowSpeakerDialogue ; $5e01
	ld a, $08 ; $5e04
	ld bc, $0010 ; $5e06
	farcall FarPtr_0a_18 ; $5e09
	test_flag $1c, 1 ; $5e0c
	jr z, Label_10_5e30 ; $5e0f
	ld a, $00 ; $5e11
	ld de, $ff80 ; $5e13
	farcall FarPtr_0a_42 ; $5e16
	ld a, $00 ; $5e19
	ld bc, $1f00 ; $5e1b
	ld de, $0f00 ; $5e1e
	farcall FarPtr_ScriptSetActorMoveTarget ; $5e21
	ld a, $00 ; $5e24
	farcall FarPtr_ScriptWaitActorMoveDone ; $5e26
	ld a, $00 ; $5e29
	ld b, $00 ; $5e2b
	farcall FarPtr_SetActorFacing ; $5e2d
Label_10_5e30:
	ld a, $08 ; $5e30
	ld bc, $2140 ; $5e32
	ld de, $0f00 ; $5e35
	farcall FarPtr_ScriptSetActorMoveTarget ; $5e38
	ld a, $08 ; $5e3b
	farcall FarPtr_ScriptWaitActorMoveDone ; $5e3d
	push af ; $5e40
	ld a, $0a ; $5e41
	farcall FarPtr_WaitScriptFrames ; $5e43
	pop af ; $5e46
	ld a, $08 ; $5e47
	ld d, $02 ; $5e49
	farcall FarPtr_ScriptSetActorAnimation ; $5e4b
	ld a, $08 ; $5e4e
	ld b, $00 ; $5e50
	farcall FarPtr_SetActorFacing ; $5e52
	set_flag $0f, 3 ; $5e55
	clear_flag $1c, 1 ; $5e58
	ret ; $5e5b
Label_10_5e5c:
	ld a, [$c2b1] ; $5e5c
	add a, a ; $5e5f
	add a, $81 ; $5e60
	ld l, a ; $5e62
	adc a, $5e ; $5e63
	sub a, l ; $5e65
	ld h, a ; $5e66
	ld a, [hl+] ; $5e67
	ld h, [hl] ; $5e68
	ld l, a ; $5e69
	ld a, $01 ; $5e6a
	add a, l ; $5e6c
	ld l, a ; $5e6d
	jr nc, Label_10_5e71 ; $5e6e
	inc h ; $5e70
Label_10_5e71:
	farcall FarPtr_InitDialogueTextCursor ; $5e71
	ld a, $08 ; $5e74
	farcall FarPtr_ScriptShowSpeakerDialogue ; $5e76
	ld a, $08 ; $5e79
	ld b, $00 ; $5e7b
	farcall FarPtr_SetActorFacing ; $5e7d
	ret ; $5e80
	; $5e81, 10 bytes (records:2)
; 5 records x 2 bytes
	dw $0c2b ; record 0
	dw $0c4f ; record 1
	dw $0c7e ; record 2
	dw $0ca6 ; record 3
	dw $0cce ; record 4
	ld a, [$c2b0] ; $5e8b
	add a, a ; $5e8e
	add a, $de ; $5e8f
	ld l, a ; $5e91
	adc a, $5e ; $5e92
	sub a, l ; $5e94
	ld h, a ; $5e95
	ld a, [hl+] ; $5e96
	ld h, [hl] ; $5e97
	ld l, a ; $5e98
	farcall FarPtr_InitDialogueTextCursor ; $5e99
	ld a, [$c2b0] ; $5e9c
	cp a, $06 ; $5e9f
	jr nc, Label_10_5ea9 ; $5ea1
	ld a, $09 ; $5ea3
	farcall FarPtr_ScriptShowSpeakerDialogue ; $5ea5
	ret ; $5ea8
Label_10_5ea9:
	ld a, $09 ; $5ea9
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $5eab
	farcall FarPtr_RunDialogueYesNoPrompt ; $5eae
	farcall FarPtr_ScriptCloseDialogueWindow ; $5eb1
	push af ; $5eb4
	ld a, $05 ; $5eb5
	farcall FarPtr_WaitScriptFrames ; $5eb7
	pop af ; $5eba
	and a, a ; $5ebb
	jr nz, Label_10_5ed2 ; $5ebc
	ld hl, $0ca9 ; $5ebe
	farcall FarPtr_InitDialogueTextCursor ; $5ec1
	test_flag $05, 7 ; $5ec4
	jr z, Label_10_5ecc ; $5ec7
	farcall FarPtr_AdvanceDialogueTextCursor ; $5ec9
Label_10_5ecc:
	ld a, $09 ; $5ecc
	farcall FarPtr_ScriptShowSpeakerDialogue ; $5ece
	ret ; $5ed1
Label_10_5ed2:
	ld hl, $0cab ; $5ed2
	farcall FarPtr_InitDialogueTextCursor ; $5ed5
	ld a, $09 ; $5ed8
	farcall FarPtr_ScriptShowSpeakerDialogue ; $5eda
	ret ; $5edd
	; $5ede, 20 bytes (records:2)
; 10 records x 2 bytes
	dw $0c2d ; record 0
	dw $0c2d ; record 1
	dw $0c51 ; record 2
	dw $0c52 ; record 3
	dw $0c80 ; record 4
	dw $0c81 ; record 5
	dw $0ca8 ; record 6
	dw $0ca8 ; record 7
	dw $0cd0 ; record 8
	dw $0cd0 ; record 9
	ld a, $00 ; $5ef2
	ld b, a ; $5ef4
	ld a, $0a ; $5ef5
	farcall FarPtr_FaceActorTowardActor ; $5ef7
	ld a, [$c2b0] ; $5efa
	add a, a ; $5efd
	add a, $30 ; $5efe
	ld l, a ; $5f00
	adc a, $5f ; $5f01
	sub a, l ; $5f03
	ld h, a ; $5f04
	ld a, [hl+] ; $5f05
	ld h, [hl] ; $5f06
	ld l, a ; $5f07
	farcall FarPtr_InitDialogueTextCursor ; $5f08
	ld a, [$c2b0] ; $5f0b
	cp a, $06 ; $5f0e
	jr nc, Label_10_5f2a ; $5f10
	ld a, $0a ; $5f12
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $5f14
	farcall FarPtr_RunDialogueYesNoPrompt ; $5f17
	farcall FarPtr_ScriptCloseDialogueWindow ; $5f1a
	push af ; $5f1d
	ld a, $05 ; $5f1e
	farcall FarPtr_WaitScriptFrames ; $5f20
	pop af ; $5f23
	and a, a ; $5f24
	jr z, Label_10_5f2a ; $5f25
	farcall FarPtr_AdvanceDialogueTextCursor ; $5f27
Label_10_5f2a:
	ld a, $0a ; $5f2a
	farcall FarPtr_ScriptShowSpeakerDialogue ; $5f2c
	ret ; $5f2f
	; $5f30, 20 bytes (records:2)
; 10 records x 2 bytes
	dw $0c2e ; record 0
	dw $0c31 ; record 1
	dw $0c53 ; record 2
	dw $0c56 ; record 3
	dw $0c82 ; record 4
	dw $0c82 ; record 5
	dw $0cac ; record 6
	dw $0cac ; record 7
	dw $0cd1 ; record 8
	dw $0cd1 ; record 9
	ld a, [$c2b1] ; $5f44
	add a, a ; $5f47
	add a, $65 ; $5f48
	ld l, a ; $5f4a
	adc a, $5f ; $5f4b
	sub a, l ; $5f4d
	ld h, a ; $5f4e
	ld a, [hl+] ; $5f4f
	ld h, [hl] ; $5f50
	ld l, a ; $5f51
	farcall FarPtr_InitDialogueTextCursor ; $5f52
	ld a, [$c2b0] ; $5f55
	cp a, $01 ; $5f58
	jr nz, Label_10_5f5f ; $5f5a
	farcall FarPtr_AdvanceDialogueTextCursor ; $5f5c
Label_10_5f5f:
	ld a, $0b ; $5f5f
	farcall FarPtr_ScriptShowSpeakerDialogue ; $5f61
	ret ; $5f64
	; $5f65, 10 bytes (records:2)
; 5 records x 2 bytes
	dw $0c34 ; record 0
	dw $0c59 ; record 1
	dw $0c85 ; record 2
	dw $0cad ; record 3
	dw $0cd2 ; record 4
	ld a, [$c2b1] ; $5f6f
	add a, a ; $5f72
	add a, $bf ; $5f73
	ld l, a ; $5f75
	adc a, $5f ; $5f76
	sub a, l ; $5f78
	ld h, a ; $5f79
	ld a, [hl+] ; $5f7a
	ld h, [hl] ; $5f7b
	ld l, a ; $5f7c
	farcall FarPtr_InitDialogueTextCursor ; $5f7d
	ld a, [$c2b1] ; $5f80
	cp a, $00 ; $5f83
	jr z, Label_10_5fb9 ; $5f85
	cp a, $03 ; $5f87
	jr nc, Label_10_5faf ; $5f89
	ld a, $0c ; $5f8b
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $5f8d
	farcall FarPtr_RunDialogueYesNoPrompt ; $5f90
	farcall FarPtr_ScriptCloseDialogueWindow ; $5f93
	push af ; $5f96
	ld a, $05 ; $5f97
	farcall FarPtr_WaitScriptFrames ; $5f99
	pop af ; $5f9c
	and a, a ; $5f9d
	jr z, Label_10_5fb9 ; $5f9e
	farcall FarPtr_AdvanceDialogueTextCursor ; $5fa0
	ld a, [$c2b0] ; $5fa3
	cp a, $05 ; $5fa6
	jr nz, Label_10_5fb9 ; $5fa8
	farcall FarPtr_AdvanceDialogueTextCursor ; $5faa
	jr Label_10_5fb9 ; $5fad
Label_10_5faf:
	ld a, [$c2b0] ; $5faf
	and a, $01 ; $5fb2
	jr z, Label_10_5fb9 ; $5fb4
	farcall FarPtr_AdvanceDialogueTextCursor ; $5fb6
Label_10_5fb9:
	ld a, $0c ; $5fb9
	farcall FarPtr_ScriptShowSpeakerDialogue ; $5fbb
	ret ; $5fbe
	; $5fbf, 10 bytes (records:2)
; 5 records x 2 bytes
	dw $0c36 ; record 0
	dw $0c5a ; record 1
	dw $0c86 ; record 2
	dw $0cae ; record 3
	dw $0cd3 ; record 4
	ld a, [$c2b1] ; $5fc9
	add a, a ; $5fcc
	add a, $09 ; $5fcd
	ld l, a ; $5fcf
	adc a, $60 ; $5fd0
	sub a, l ; $5fd2
	ld h, a ; $5fd3
	ld a, [hl+] ; $5fd4
	ld h, [hl] ; $5fd5
	ld l, a ; $5fd6
	farcall FarPtr_InitDialogueTextCursor ; $5fd7
	ld a, [$c2b1] ; $5fda
	cp a, $03 ; $5fdd
	jr nz, Label_10_5ff9 ; $5fdf
	ld a, $0d ; $5fe1
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $5fe3
	farcall FarPtr_RunDialogueYesNoPrompt ; $5fe6
	farcall FarPtr_ScriptCloseDialogueWindow ; $5fe9
	push af ; $5fec
	ld a, $05 ; $5fed
	farcall FarPtr_WaitScriptFrames ; $5fef
	pop af ; $5ff2
	and a, a ; $5ff3
	jr z, Label_10_5ff9 ; $5ff4
	farcall FarPtr_AdvanceDialogueTextCursor ; $5ff6
Label_10_5ff9:
	ld a, [$c2b0] ; $5ff9
	cp a, $03 ; $5ffc
	jr nz, Label_10_6003 ; $5ffe
	farcall FarPtr_AdvanceDialogueTextCursor ; $6000
Label_10_6003:
	ld a, $0d ; $6003
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6005
	ret ; $6008
	; $6009, 10 bytes (records:2)
; 5 records x 2 bytes
	dw $0c37 ; record 0
	dw $0c5d ; record 1
	dw $0c8a ; record 2
	dw $0cb0 ; record 3
	dw $0cd5 ; record 4
	ld a, [$c2b1] ; $6013
	add a, a ; $6016
	add a, $2a ; $6017
	ld l, a ; $6019
	adc a, $60 ; $601a
	sub a, l ; $601c
	ld h, a ; $601d
	ld a, [hl+] ; $601e
	ld h, [hl] ; $601f
	ld l, a ; $6020
	farcall FarPtr_InitDialogueTextCursor ; $6021
	ld a, $0e ; $6024
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6026
	ret ; $6029
	; $602a, 10 bytes (records:2)
; 5 records x 2 bytes
	dw $0c38 ; record 0
	dw $0c5f ; record 1
	dw $0c8b ; record 2
	dw $0cb3 ; record 3
	dw $0cd6 ; record 4
	ld a, [$c2b1] ; $6034
	add a, a ; $6037
	add a, $4b ; $6038
	ld l, a ; $603a
	adc a, $60 ; $603b
	sub a, l ; $603d
	ld h, a ; $603e
	ld a, [hl+] ; $603f
	ld h, [hl] ; $6040
	ld l, a ; $6041
	farcall FarPtr_InitDialogueTextCursor ; $6042
	ld a, $0f ; $6045
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6047
	ret ; $604a
	; $604b, 10 bytes (records:2)
; 5 records x 2 bytes
	dw $0c39 ; record 0
	dw $0c60 ; record 1
	dw $0c8c ; record 2
	dw $0cb4 ; record 3
	dw $0cd7 ; record 4
	ld a, [$c2b1] ; $6055
	add a, a ; $6058
	add a, $6c ; $6059
	ld l, a ; $605b
	adc a, $60 ; $605c
	sub a, l ; $605e
	ld h, a ; $605f
	ld a, [hl+] ; $6060
	ld h, [hl] ; $6061
	ld l, a ; $6062
	farcall FarPtr_InitDialogueTextCursor ; $6063
	ld a, $10 ; $6066
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6068
	ret ; $606b
	; $606c, 10 bytes (records:2)
; 5 records x 2 bytes
	dw $0c3a ; record 0
	dw $0c61 ; record 1
	dw $0c8e ; record 2
	dw $0cb6 ; record 3
	dw $0cd9 ; record 4
	; $6076, 123 bytes (records:8)
; 15 records x 8 bytes
	dw $ff03, $0000, $5bf2, $0003 ; record 0
	dw $ff04, $0000, $5c1d, $0003 ; record 1
	dw $ff05, $0000, $5c3e, $0003 ; record 2
	dw $ff06, $0000, $5cb0, $0003 ; record 3
	dw $ff12, $0000, $5d05, $0000 ; record 4
	dw $8008, $0000, $5de6, $0003 ; record 5
	dw $ff08, $0000, $5de9, $0003 ; record 6
	dw $ff09, $0000, $5e8b, $0003 ; record 7
	dw $ff0a, $0000, $5ef2, $0013 ; record 8
	dw $ff0b, $0000, $5f44, $0003 ; record 9
	dw $ff0c, $0000, $5f6f, $0003 ; record 10
	dw $ff0d, $0000, $5fc9, $0003 ; record 11
	dw $ff0e, $0000, $6013, $0013 ; record 12
	dw $ff0f, $0000, $6034, $0003 ; record 13
	dw $ff10, $0000, $6055, $0003 ; record 14
	db $ff, $ff, $ff
	call Func_10_7dbd ; $60f1
	ld a, [$c2b0] ; $60f4
	sra a ; $60f7
	ld [$c2b1], a ; $60f9
	call Func_10_611b ; $60fc
	call Func_10_6103 ; $60ff
	ret ; $6102
Func_10_6103:
	test_flag $0f, 3 ; $6103
	jr z, Label_10_611a ; $6106
	ld a, $08 ; $6108
	ld bc, $2140 ; $610a
	ld de, $0f00 ; $610d
	farcall FarPtr_ScriptSetActorPosition ; $6110
	ld a, $08 ; $6113
	ld b, $00 ; $6115
	farcall FarPtr_SetActorFacing ; $6117
Label_10_611a:
	ret ; $611a
Func_10_611b:
	call Func_10_612c ; $611b
	jr z, Label_10_612b ; $611e
	ld a, $12 ; $6120
	ld bc, $1b00 ; $6122
	ld de, $1100 ; $6125
	farcall FarPtr_ScriptSetActorPosition ; $6128
Label_10_612b:
	ret ; $612b
Func_10_612c:
	ld a, [$c2b1] ; $612c
	add a, a ; $612f
	add a, $50 ; $6130
	ld l, a ; $6132
	adc a, $61 ; $6133
	sub a, l ; $6135
	ld h, a ; $6136
	ld a, [hl+] ; $6137
	ld d, [hl] ; $6138
	ld e, a ; $6139
	call TestGameFlagByNumber ; $613a
	ret ; $613d
Func_10_613e:
	ld a, [$c2b1] ; $613e
	add a, a ; $6141
	add a, $50 ; $6142
	ld l, a ; $6144
	adc a, $61 ; $6145
	sub a, l ; $6147
	ld h, a ; $6148
	ld a, [hl+] ; $6149
	ld d, [hl] ; $614a
	ld e, a ; $614b
	call SetGameFlagByNumber ; $614c
	ret ; $614f
	ld [hl], b ; $6150
	nop ; $6151
	ld [hl], c ; $6152
	nop ; $6153
	ld [hl], d ; $6154
	nop ; $6155
	ld [hl], e ; $6156
	nop ; $6157
	ld a, d ; $6158
	nop ; $6159
	wram_bank $04 ; $615a
	ld a, $00 ; $6160
	farcall FarPtr_GetActorStateAddr ; $6162
	ld c, l ; $6165
	ld b, h ; $6166
	ld hl, $000c ; $6167
	add hl, bc ; $616a
	ld a, [hl+] ; $616b
	ld h, [hl] ; $616c
	ld l, a ; $616d
	ld de, $0180 ; $616e
	add hl, de ; $6171
	ld e, l ; $6172
	ld d, h ; $6173
	ld hl, $c2b8 ; $6174
	ld a, e ; $6177
	ld [hl+], a ; $6178
	ld [hl], d ; $6179
	ld hl, $000e ; $617a
	add hl, bc ; $617d
	ld a, [hl+] ; $617e
	ld h, [hl] ; $617f
	ld l, a ; $6180
	ld de, $fe80 ; $6181
	add hl, de ; $6184
	ld e, l ; $6185
	ld d, h ; $6186
	ld hl, wWaterSpriteMinigameFlag ; $6187
	ld a, e ; $618a
	ld [hl+], a ; $618b
	ld [hl], d ; $618c
	ld hl, $c2b8 ; $618d
	ld a, [hl+] ; $6190
	ld b, [hl] ; $6191
	ld c, a ; $6192
	ld hl, wWaterSpriteMinigameFlag ; $6193
	ld a, [hl+] ; $6196
	ld d, [hl] ; $6197
	ld e, a ; $6198
	ld a, $11 ; $6199
	farcall FarPtr_ScriptSetActorPosition ; $619b
	push af ; $619e
	ld a, $46 ; $619f
	farcall FarPtr_WaitScriptFrames ; $61a1
	pop af ; $61a4
	ld a, $11 ; $61a5
	ld bc, $3f00 ; $61a7
	ld de, $3f00 ; $61aa
	farcall FarPtr_ScriptSetActorPosition ; $61ad
	ret ; $61b0
Data_10_61b1:
	; $61b1, 14 bytes (records:2)
; 7 records x 2 bytes
	dw $6201 ; record 0
	dw $6212 ; record 1
	dw $61bf ; record 2
	dw $62b6 ; record 3
	dw $62bf ; record 4
	dw $6361 ; record 5
	dw $643b ; record 6
	; $61bf, 66 bytes (bytes:14)
	db $00, $00, $d1, $7b, $00, $3f, $00, $19, $00, $00, $63, $01, $00, $00 ; 0x00
	db $00, $00, $d1, $7b, $00, $19, $00, $3f, $00, $00, $36, $01, $00, $00 ; 0x0e
	db $00, $00, $d1, $7b, $00, $27, $40, $32, $40, $00, $74, $01, $00, $00 ; 0x1c
	db $00, $00, $d1, $7b, $00, $27, $c0, $30, $40, $00, $74, $01, $00, $00 ; 0x2a
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $ff ; 0x38
	; $6201, 17 bytes (bytes:16)
	db $01, $40, $00, $3b, $00, $39, $5f, $7b, $0f, $c0, $00, $20, $00, $34, $f9, $7b ; 0x00
	db $ff ; 0x10
	; $6212, 164 bytes (records:8)
; 20 records x 8 bytes
	dw $ff01, $0000, $7bf9, $0114 ; record 0
	dw $ff02, $0000, $7bf9, $0307 ; record 1
	dw $ff03, $0000, $7ae6, $0405 ; record 2
	dw $ff04, $0000, $7b1f, $0305 ; record 3
	dw $ff0f, $0000, $7bf9, $0f07 ; record 4
	dw $3eff, $4700, $033e, $30df ; record 5
	dw $f70a, $1c00, $0828, $0521 ; record 6
	dw $df02, $0a0e, $6018, $063e ; record 7
	dw $16df, $4d0a, $2144, $0037 ; record 8
	dw $7e09, $20f6, $3e77, $0106 ; record 9
	dw $1b80, $0011, $df2e, $0a22 ; record 10
	dw $97cf, $3ef5, $df3c, $0a04 ; record 11
	dw $3ef1, $0106, $0100, $0011 ; record 12
	dw $df01, $0a22, $0121, $df02 ; record 13
	dw $0a0e, $e0f7, $2805, $df03 ; record 14
	dw $0a10, $033e, $0adf, $210a ; record 15
	dw $0203, $0edf, $df0a, $0a12 ; record 16
	dw $0cdf, $f50a, $053e, $04df ; record 17
	dw $f10a, $20a7, $2109, $0204 ; record 18
	dw $0edf, $e70a, $1c00, $033e ; record 19
	db $df, $08, $0a, $c9
	; $62b6, 9 bytes (records:8)
; 1 records x 8 bytes
	dw $ff03, $0000, $623b, $0001 ; record 0
	db $ff
	; $62bf, 17 bytes (records:8)
; 2 records x 8 bytes
	dw $ff01, $0000, $6355, $0000 ; record 0
	dw $ff02, $0000, $62d0, $0000 ; record 1
	db $ff
	ld a, [$c2b0] ; $62d0
	cp a, $01 ; $62d3
	jr nz, Label_10_6355 ; $62d5
	farcall FarPtr_0a_00 ; $62d7
	ld bc, $0020 ; $62da
	farcall FarPtr_0a_38 ; $62dd
	xor a, a ; $62e0
	ld bc, $2100 ; $62e1
	ld de, $3300 ; $62e4
	farcall FarPtr_MovePlayerToPosition ; $62e7
	ld hl, $01c1 ; $62ea
	farcall FarPtr_InitDialogueTextCursor ; $62ed
	ld a, $03 ; $62f0
	ld b, $40 ; $62f2
	farcall FarPtr_SetActorFacing ; $62f4
	push af ; $62f7
	ld a, $0a ; $62f8
	farcall FarPtr_WaitScriptFrames ; $62fa
	pop af ; $62fd
	ld a, $04 ; $62fe
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6300
	push af ; $6303
	ld a, $0a ; $6304
	farcall FarPtr_WaitScriptFrames ; $6306
	pop af ; $6309
	ld a, $02 ; $630a
	ld d, $02 ; $630c
	farcall FarPtr_ScriptSetActorAnimation ; $630e
	ld a, $00 ; $6311
	ld d, $02 ; $6313
	farcall FarPtr_ScriptSetActorAnimation ; $6315
	ld a, $00 ; $6318
	farcall FarPtr_ScriptWaitActorIdle ; $631a
	ld a, $03 ; $631d
	ld d, $04 ; $631f
	farcall FarPtr_ScriptSetActorAnimation ; $6321
	ld a, $03 ; $6324
	farcall FarPtr_ScriptWaitActorIdle ; $6326
	ld bc, $0018 ; $6329
	farcall FarPtr_0a_38 ; $632c
	ld a, $04 ; $632f
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6331
	ld a, $03 ; $6334
	ld b, $00 ; $6336
	farcall FarPtr_SetActorFacing ; $6338
	xor a, a ; $633b
	ld bc, $2100 ; $633c
	ld de, $3b00 ; $633f
	farcall FarPtr_MovePlayerToPosition ; $6342
	ld a, $00 ; $6345
	ld d, $02 ; $6347
	farcall FarPtr_ScriptSetActorAnimation ; $6349
	ld a, $00 ; $634c
	farcall FarPtr_ScriptWaitActorIdle ; $634e
	farcall FarPtr_0a_02 ; $6351
	ret ; $6354
Label_10_6355:
	ld hl, $01c3 ; $6355
	farcall FarPtr_InitDialogueTextCursor ; $6358
	ld a, $00 ; $635b
	farcall FarPtr_ScriptShowSpeakerDialogue ; $635d
	ret ; $6360
	; $6361, 218 bytes (bytes:16)
	db $01, $40, $00, $00, $72, $63, $00, $00, $02, $80, $00, $00, $e0, $63, $00, $00 ; 0x00
	db $ff, $3e, $00, $01, $14, $00, $df, $18, $0a, $3e, $00, $06, $c0, $df, $2e, $0a ; 0x10
	db $cd, $39, $73, $f7, $e0, $05, $28, $10, $3e, $02, $01, $00, $21, $11, $00, $3d ; 0x20
	db $df, $24, $0a, $3e, $02, $df, $20, $0a, $3e, $00, $01, $00, $21, $11, $00, $39 ; 0x30
	db $df, $24, $0a, $3e, $00, $df, $20, $0a, $f5, $3e, $02, $df, $04, $0a, $f1, $3e ; 0x40
	db $00, $06, $c0, $11, $00, $02, $df, $2a, $0a, $3e, $00, $df, $20, $0a, $3e, $00 ; 0x50
	db $06, $80, $11, $00, $02, $df, $2a, $0a, $3e, $00, $df, $20, $0a, $f5, $3e, $0a ; 0x60
	db $df, $04, $0a, $f1, $3e, $00, $06, $c0, $df, $2e, $0a, $cd, $6f, $73, $c9, $3e ; 0x70
	db $00, $06, $40, $df, $2e, $0a, $3e, $00, $01, $10, $00, $df, $18, $0a, $cd, $39 ; 0x80
	db $73, $3e, $02, $01, $00, $21, $11, $00, $35, $df, $24, $0a, $f7, $e0, $05, $28 ; 0x90
	db $00, $3e, $00, $01, $00, $21, $11, $00, $39, $df, $24, $0a, $3e, $00, $df, $20 ; 0xa0
	db $0a, $3e, $00, $06, $40, $11, $00, $02, $df, $2a, $0a, $3e, $00, $df, $20, $0a ; 0xb0
	db $3e, $00, $06, $00, $11, $00, $02, $df, $2a, $0a, $3e, $00, $df, $20, $0a, $f5 ; 0xc0
	db $3e, $05, $df, $04, $0a, $f1, $cd, $6f, $73, $c9 ; 0xd0
	ld a, $05 ; $643b
	ld d, $06 ; $643d
	farcall FarPtr_ScriptSetActorAnimation ; $643f
	test_flag $07, 4 ; $6442
	jr nz, Label_10_6452 ; $6445
	ld a, $05 ; $6447
	ld bc, $0100 ; $6449
	ld de, $0100 ; $644c
	farcall FarPtr_ScriptSetActorPosition ; $644f
Label_10_6452:
	test_flag $06, 5 ; $6452
	jr nz, Label_10_6462 ; $6455
	ld a, $06 ; $6457
	ld bc, $0100 ; $6459
	ld de, $0100 ; $645c
	farcall FarPtr_ScriptSetActorPosition ; $645f
Label_10_6462:
	call Func_10_7472 ; $6462
	ld a, [$c2b0] ; $6465
	cp a, $03 ; $6468
	jr nz, Label_10_649e ; $646a
	ldh a, [hRomBank] ; $646c
	ld hl, $739e ; $646e
	farcall FarPtr_0a_06 ; $6471
	farcall FarPtr_0a_00 ; $6474
	ld b, $1e ; $6477
	ld c, $38 ; $6479
	ld d, $20 ; $647b
	ld e, $38 ; $647d
	ld h, $02 ; $647f
	ld l, $02 ; $6481
	farcall FarPtr_0a_82 ; $6483
	call Func_10_7b5f ; $6486
	call Func_10_7443 ; $6489
	ld a, $03 ; $648c
	ld bc, $1d00 ; $648e
	ld de, $3000 ; $6491
	farcall FarPtr_ScriptSetActorPosition ; $6494
	ld a, $03 ; $6497
	ld b, $c0 ; $6499
	farcall FarPtr_SetActorFacing ; $649b
Label_10_649e:
	ld a, [$c2b0] ; $649e
	cp a, $01 ; $64a1
	jr nz, Label_10_64b0 ; $64a3
	ld a, $03 ; $64a5
	ld bc, $19a0 ; $64a7
	ld de, $32c0 ; $64aa
	farcall FarPtr_ScriptSetActorPosition ; $64ad
Label_10_64b0:
	ld a, $16 ; $64b0
	ld [$c329], a ; $64b2
	ld a, $28 ; $64b5
	ld [$c32a], a ; $64b7
	ld a, $40 ; $64ba
	ld [$c32b], a ; $64bc
	ld a, $3e ; $64bf
	ld [$c32c], a ; $64c1
	call DisableLCDSafely ; $64c4
	ld a, $00 ; $64c7
	farcall FarPtr_CopyScrolledSceneTilemapToVram ; $64c9
	call EnableLCD ; $64cc
	ld a, [$c295] ; $64cf
	cp a, $0d ; $64d2
	jp z, Label_10_64e0 ; $64d4
	cp a, $0f ; $64d7
	jp z, Label_10_6fcd ; $64d9
	call Func_10_7429 ; $64dc
	ret ; $64df
Label_10_64e0:
	ldh a, [hRomBank] ; $64e0
	ld hl, $6f45 ; $64e2
	farcall FarPtr_0a_06 ; $64e5
	farcall FarPtr_0a_00 ; $64e8
	ld a, $0a ; $64eb
	ld d, $06 ; $64ed
	farcall FarPtr_ScriptSetActorAnimation ; $64ef
	test_flag $07, 4 ; $64f2
	jr nz, Label_10_6502 ; $64f5
	ld a, $0a ; $64f7
	ld bc, $0100 ; $64f9
	ld de, $0100 ; $64fc
	farcall FarPtr_ScriptSetActorPosition ; $64ff
Label_10_6502:
	test_flag $06, 5 ; $6502
	jr nz, Label_10_6512 ; $6505
	ld a, $0b ; $6507
	ld bc, $0100 ; $6509
	ld de, $0100 ; $650c
	farcall FarPtr_ScriptSetActorPosition ; $650f
Label_10_6512:
	ld bc, $00f0 ; $6512
	farcall FarPtr_0a_38 ; $6515
	xor a, a ; $6518
	ld bc, $1f00 ; $6519
	ld de, $3b00 ; $651c
	farcall FarPtr_MovePlayerToPosition ; $651f
	farcall FarPtr_WaitPlayerMoveDone ; $6522
	ld a, $00 ; $6525
	ld bc, $3500 ; $6527
	ld de, $3b00 ; $652a
	farcall FarPtr_ScriptSetActorPosition ; $652d
	xor a, a ; $6530
	ld [$c2d5], a ; $6531
	ld a, $00 ; $6534
	ld bc, $2b00 ; $6536
	ld de, $3b00 ; $6539
	farcall FarPtr_ScriptSetActorPosition ; $653c
	ld c, $08 ; $653f
	call BeginFadeIn ; $6541
	call WaitFadeEnd ; $6544
	push af ; $6547
	ld a, $3c ; $6548
	farcall FarPtr_WaitScriptFrames ; $654a
	pop af ; $654d
	ld a, $06 ; $654e
	ld d, $02 ; $6550
	farcall FarPtr_ScriptSetActorAnimation ; $6552
	ld a, $06 ; $6555
	farcall FarPtr_ScriptWaitActorIdle ; $6557
	ld hl, $01db ; $655a
	farcall FarPtr_InitDialogueTextCursor ; $655d
	ld a, $06 ; $6560
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6562
	ld a, $07 ; $6565
	ld d, $02 ; $6567
	farcall FarPtr_ScriptSetActorAnimation ; $6569
	ld a, $08 ; $656c
	ld d, $02 ; $656e
	farcall FarPtr_ScriptSetActorAnimation ; $6570
	ld a, $09 ; $6573
	ld d, $02 ; $6575
	farcall FarPtr_ScriptSetActorAnimation ; $6577
	ld a, $09 ; $657a
	farcall FarPtr_ScriptWaitActorIdle ; $657c
	ld a, $07 ; $657f
	ld b, a ; $6581
	ld a, $08 ; $6582
	farcall FarPtr_FaceActorsTowardEachOther ; $6584
	push af ; $6587
	ld a, $28 ; $6588
	farcall FarPtr_WaitScriptFrames ; $658a
	pop af ; $658d
	ld a, $07 ; $658e
	ld b, $c0 ; $6590
	farcall FarPtr_SetActorFacing ; $6592
	ld a, $08 ; $6595
	ld b, $c0 ; $6597
	farcall FarPtr_SetActorFacing ; $6599
	push af ; $659c
	ld a, $28 ; $659d
	farcall FarPtr_WaitScriptFrames ; $659f
	pop af ; $65a2
	ld a, $05 ; $65a3
	ld bc, $2380 ; $65a5
	ld de, $3100 ; $65a8
	farcall FarPtr_ScriptSetActorPosition ; $65ab
	sound $97 ; $65ae
	ld a, $07 ; $65b0
	farcall FarPtr_ScriptShowSpeakerDialogue ; $65b2
	ld a, $05 ; $65b5
	ld bc, $3f00 ; $65b7
	ld de, $3f00 ; $65ba
	farcall FarPtr_ScriptSetActorPosition ; $65bd
	ld a, $06 ; $65c0
	ld d, $03 ; $65c2
	farcall FarPtr_ScriptSetActorAnimation ; $65c4
	ld a, $06 ; $65c7
	farcall FarPtr_ScriptWaitActorIdle ; $65c9
	ld a, $06 ; $65cc
	farcall FarPtr_ScriptShowSpeakerDialogue ; $65ce
	test_flag $05, 7 ; $65d1
	jp z, Label_10_66a2 ; $65d4
	ld a, $03 ; $65d7
	ld bc, $2180 ; $65d9
	ld de, $3100 ; $65dc
	farcall FarPtr_ScriptSetActorPosition ; $65df
	sound $99 ; $65e2
	push af ; $65e4
	ld a, $0a ; $65e5
	farcall FarPtr_WaitScriptFrames ; $65e7
	pop af ; $65ea
	farcall FarPtr_AdvanceDialogueTextCursor ; $65eb
	ld a, $08 ; $65ee
	farcall FarPtr_ScriptShowSpeakerDialogue ; $65f0
	ld a, $03 ; $65f3
	ld bc, $3f00 ; $65f5
	ld de, $3f00 ; $65f8
	farcall FarPtr_ScriptSetActorPosition ; $65fb
	ld a, $08 ; $65fe
	ld b, a ; $6600
	ld a, $07 ; $6601
	farcall FarPtr_FaceActorTowardActor ; $6603
	push af ; $6606
	ld a, $01 ; $6607
	farcall FarPtr_WaitScriptFrames ; $6609
	pop af ; $660c
	ld a, $07 ; $660d
	ld b, $01 ; $660f
	farcall FarPtr_0a_2c ; $6611
	ld a, $07 ; $6614
	ld bc, $2100 ; $6616
	ld de, $3300 ; $6619
	farcall FarPtr_ScriptSetActorMoveTarget ; $661c
	ld a, $07 ; $661f
	farcall FarPtr_ScriptWaitActorMoveDone ; $6621
	ld a, $08 ; $6624
	ld d, $02 ; $6626
	farcall FarPtr_ScriptSetActorAnimation ; $6628
	ld a, $07 ; $662b
	ld bc, $2200 ; $662d
	ld de, $3300 ; $6630
	farcall FarPtr_ScriptSetActorMoveTarget ; $6633
	ld a, $07 ; $6636
	farcall FarPtr_ScriptWaitActorMoveDone ; $6638
	ld a, $07 ; $663b
	ld b, $00 ; $663d
	farcall FarPtr_0a_2c ; $663f
	ld a, $08 ; $6642
	ld b, a ; $6644
	ld a, $07 ; $6645
	farcall FarPtr_FaceActorsTowardEachOther ; $6647
	ld a, $07 ; $664a
	farcall FarPtr_ScriptShowSpeakerDialogue ; $664c
	ld a, $08 ; $664f
	ld b, a ; $6651
	ld a, $09 ; $6652
	farcall FarPtr_FaceActorTowardActor ; $6654
	push af ; $6657
	ld a, $01 ; $6658
	farcall FarPtr_WaitScriptFrames ; $665a
	pop af ; $665d
	ld a, $09 ; $665e
	ld b, $01 ; $6660
	farcall FarPtr_0a_2c ; $6662
	ld a, $09 ; $6665
	ld bc, $1f00 ; $6667
	ld de, $3300 ; $666a
	farcall FarPtr_ScriptSetActorMoveTarget ; $666d
	ld a, $09 ; $6670
	farcall FarPtr_ScriptWaitActorMoveDone ; $6672
	ld a, $08 ; $6675
	ld d, $02 ; $6677
	farcall FarPtr_ScriptSetActorAnimation ; $6679
	ld a, $09 ; $667c
	ld bc, $1e00 ; $667e
	ld de, $3300 ; $6681
	farcall FarPtr_ScriptSetActorMoveTarget ; $6684
	ld a, $09 ; $6687
	farcall FarPtr_ScriptWaitActorMoveDone ; $6689
	ld a, $09 ; $668c
	ld b, $00 ; $668e
	farcall FarPtr_0a_2c ; $6690
	ld a, $08 ; $6693
	ld b, a ; $6695
	ld a, $09 ; $6696
	farcall FarPtr_FaceActorsTowardEachOther ; $6698
	ld a, $09 ; $669b
	farcall FarPtr_ScriptShowSpeakerDialogue ; $669d
	jr Label_10_66c6 ; $66a0
Label_10_66a2:
	ld a, $05 ; $66a2
	ld bc, $2180 ; $66a4
	ld de, $3100 ; $66a7
	farcall FarPtr_ScriptSetActorPosition ; $66aa
	sound $97 ; $66ad
	push af ; $66af
	ld a, $1e ; $66b0
	farcall FarPtr_WaitScriptFrames ; $66b2
	pop af ; $66b5
	ld a, $08 ; $66b6
	farcall FarPtr_ScriptShowSpeakerDialogue ; $66b8
	ld a, $05 ; $66bb
	ld bc, $3f00 ; $66bd
	ld de, $3f00 ; $66c0
	farcall FarPtr_ScriptSetActorPosition ; $66c3
Label_10_66c6:
	ld a, $08 ; $66c6
	ld b, a ; $66c8
	ld a, $07 ; $66c9
	farcall FarPtr_FaceActorTowardActor ; $66cb
	push af ; $66ce
	ld a, $01 ; $66cf
	farcall FarPtr_WaitScriptFrames ; $66d1
	pop af ; $66d4
	ld a, $07 ; $66d5
	ld b, $01 ; $66d7
	farcall FarPtr_0a_2c ; $66d9
	ld a, $07 ; $66dc
	ld bc, $2100 ; $66de
	ld de, $3300 ; $66e1
	farcall FarPtr_ScriptSetActorMoveTarget ; $66e4
	ld a, $07 ; $66e7
	farcall FarPtr_ScriptWaitActorMoveDone ; $66e9
	ld a, $07 ; $66ec
	ld bc, $2200 ; $66ee
	ld de, $3300 ; $66f1
	farcall FarPtr_ScriptSetActorMoveTarget ; $66f4
	ld a, $07 ; $66f7
	farcall FarPtr_ScriptWaitActorMoveDone ; $66f9
	ld a, $07 ; $66fc
	ld b, $00 ; $66fe
	farcall FarPtr_0a_2c ; $6700
	ld a, $08 ; $6703
	ld b, a ; $6705
	ld a, $07 ; $6706
	farcall FarPtr_FaceActorsTowardEachOther ; $6708
	ld a, $08 ; $670b
	ld d, $02 ; $670d
	farcall FarPtr_ScriptSetActorAnimation ; $670f
	ld a, $08 ; $6712
	farcall FarPtr_ScriptWaitActorIdle ; $6714
	ld a, $08 ; $6717
	ld b, a ; $6719
	ld a, $09 ; $671a
	farcall FarPtr_FaceActorTowardActor ; $671c
	push af ; $671f
	ld a, $01 ; $6720
	farcall FarPtr_WaitScriptFrames ; $6722
	pop af ; $6725
	ld a, $09 ; $6726
	ld b, $01 ; $6728
	farcall FarPtr_0a_2c ; $672a
	ld a, $09 ; $672d
	ld bc, $1f00 ; $672f
	ld de, $3300 ; $6732
	farcall FarPtr_ScriptSetActorMoveTarget ; $6735
	ld a, $09 ; $6738
	farcall FarPtr_ScriptWaitActorMoveDone ; $673a
	ld a, $09 ; $673d
	ld bc, $1e00 ; $673f
	ld de, $3300 ; $6742
	farcall FarPtr_ScriptSetActorMoveTarget ; $6745
	ld a, $09 ; $6748
	farcall FarPtr_ScriptWaitActorMoveDone ; $674a
	ld a, $09 ; $674d
	ld b, $00 ; $674f
	farcall FarPtr_0a_2c ; $6751
	ld a, $08 ; $6754
	ld b, a ; $6756
	ld a, $09 ; $6757
	farcall FarPtr_FaceActorsTowardEachOther ; $6759
	ld a, $08 ; $675c
	ld d, $02 ; $675e
	farcall FarPtr_ScriptSetActorAnimation ; $6760
	ld a, $08 ; $6763
	farcall FarPtr_ScriptWaitActorIdle ; $6765
	ld a, $09 ; $6768
	ld d, $03 ; $676a
	farcall FarPtr_ScriptSetActorAnimation ; $676c
	ld a, $07 ; $676f
	ld d, $03 ; $6771
	farcall FarPtr_ScriptSetActorAnimation ; $6773
	ld a, $07 ; $6776
	farcall FarPtr_ScriptWaitActorIdle ; $6778
	ld a, $06 ; $677b
	ld bc, $1e00 ; $677d
	ld de, $2f00 ; $6780
	farcall FarPtr_ScriptSetActorMoveTarget ; $6783
	ld a, $06 ; $6786
	farcall FarPtr_ScriptWaitActorMoveDone ; $6788
	ld a, $06 ; $678b
	ld b, $40 ; $678d
	farcall FarPtr_SetActorFacing ; $678f
	push af ; $6792
	ld a, $1e ; $6793
	farcall FarPtr_WaitScriptFrames ; $6795
	pop af ; $6798
	ld a, $06 ; $6799
	ld bc, $2200 ; $679b
	ld de, $2f00 ; $679e
	farcall FarPtr_ScriptSetActorMoveTarget ; $67a1
	ld a, $06 ; $67a4
	farcall FarPtr_ScriptWaitActorMoveDone ; $67a6
	ld a, $06 ; $67a9
	ld b, $40 ; $67ab
	farcall FarPtr_SetActorFacing ; $67ad
	push af ; $67b0
	ld a, $1e ; $67b1
	farcall FarPtr_WaitScriptFrames ; $67b3
	pop af ; $67b6
	ld a, $06 ; $67b7
	ld bc, $2000 ; $67b9
	ld de, $2f00 ; $67bc
	farcall FarPtr_ScriptSetActorMoveTarget ; $67bf
	ld a, $06 ; $67c2
	farcall FarPtr_ScriptWaitActorMoveDone ; $67c4
	ld a, $06 ; $67c7
	ld b, $40 ; $67c9
	farcall FarPtr_SetActorFacing ; $67cb
	push af ; $67ce
	ld a, $0a ; $67cf
	farcall FarPtr_WaitScriptFrames ; $67d1
	pop af ; $67d4
	ld a, $06 ; $67d5
	ld d, $02 ; $67d7
	farcall FarPtr_ScriptSetActorAnimation ; $67d9
	ld a, $06 ; $67dc
	farcall FarPtr_ScriptWaitActorIdle ; $67de
	ld a, $07 ; $67e1
	ld b, $c0 ; $67e3
	farcall FarPtr_SetActorFacing ; $67e5
	ld a, $08 ; $67e8
	ld b, $c0 ; $67ea
	farcall FarPtr_SetActorFacing ; $67ec
	ld a, $09 ; $67ef
	ld b, $c0 ; $67f1
	farcall FarPtr_SetActorFacing ; $67f3
	ld hl, $01e2 ; $67f6
	farcall FarPtr_InitDialogueTextCursor ; $67f9
	ld a, $06 ; $67fc
	farcall FarPtr_ScriptShowSpeakerDialogue ; $67fe
	ld d, $53 ; $6801
	ld a, $03 ; $6803
	farcall FarPtr_GetActorStateAddr ; $6805
	ld c, l ; $6808
	ld b, h ; $6809
	farcall FarPtr_04_2c ; $680a
	ld a, $03 ; $680d
	ld d, $01 ; $680f
	farcall FarPtr_ScriptSetActorAnimation ; $6811
	ld d, $53 ; $6814
	ld a, $05 ; $6816
	farcall FarPtr_GetActorStateAddr ; $6818
	ld c, l ; $681b
	ld b, h ; $681c
	farcall FarPtr_04_2c ; $681d
	ld a, $05 ; $6820
	ld d, $01 ; $6822
	farcall FarPtr_ScriptSetActorAnimation ; $6824
	ld a, $03 ; $6827
	ld bc, $1f80 ; $6829
	ld de, $3100 ; $682c
	farcall FarPtr_ScriptSetActorPosition ; $682f
	sound $96 ; $6832
	push af ; $6834
	ld a, $28 ; $6835
	farcall FarPtr_WaitScriptFrames ; $6837
	pop af ; $683a
	ld a, $04 ; $683b
	ld bc, $2180 ; $683d
	ld de, $3100 ; $6840
	farcall FarPtr_ScriptSetActorPosition ; $6843
	sound $96 ; $6846
	push af ; $6848
	ld a, $28 ; $6849
	farcall FarPtr_WaitScriptFrames ; $684b
	pop af ; $684e
	ld a, $03 ; $684f
	ld bc, $3f00 ; $6851
	ld de, $3f00 ; $6854
	farcall FarPtr_ScriptSetActorPosition ; $6857
	ld a, $05 ; $685a
	ld bc, $2380 ; $685c
	ld de, $3100 ; $685f
	farcall FarPtr_ScriptSetActorPosition ; $6862
	sound $96 ; $6865
	push af ; $6867
	ld a, $28 ; $6868
	farcall FarPtr_WaitScriptFrames ; $686a
	pop af ; $686d
	ld a, $04 ; $686e
	ld bc, $3f00 ; $6870
	ld de, $3f00 ; $6873
	farcall FarPtr_ScriptSetActorPosition ; $6876
	push af ; $6879
	ld a, $28 ; $687a
	farcall FarPtr_WaitScriptFrames ; $687c
	pop af ; $687f
	ld a, $05 ; $6880
	ld bc, $3f00 ; $6882
	ld de, $3f00 ; $6885
	farcall FarPtr_ScriptSetActorPosition ; $6888
	ld a, $07 ; $688b
	ld b, $40 ; $688d
	farcall FarPtr_SetActorFacing ; $688f
	ld a, $08 ; $6892
	ld b, $40 ; $6894
	farcall FarPtr_SetActorFacing ; $6896
	ld a, $09 ; $6899
	ld b, $40 ; $689b
	farcall FarPtr_SetActorFacing ; $689d
	push af ; $68a0
	ld a, $78 ; $68a1
	farcall FarPtr_WaitScriptFrames ; $68a3
	pop af ; $68a6
	ld a, $07 ; $68a7
	ld b, $c0 ; $68a9
	farcall FarPtr_SetActorFacing ; $68ab
	ld a, $08 ; $68ae
	ld b, $c0 ; $68b0
	farcall FarPtr_SetActorFacing ; $68b2
	ld a, $09 ; $68b5
	ld b, $c0 ; $68b7
	farcall FarPtr_SetActorFacing ; $68b9
	push af ; $68bc
	ld a, $28 ; $68bd
	farcall FarPtr_WaitScriptFrames ; $68bf
	pop af ; $68c2
	ld a, $07 ; $68c3
	ld b, a ; $68c5
	ld a, $08 ; $68c6
	farcall FarPtr_FaceActorTowardActor ; $68c8
	push af ; $68cb
	ld a, $01 ; $68cc
	farcall FarPtr_WaitScriptFrames ; $68ce
	pop af ; $68d1
	ld a, $08 ; $68d2
	ld d, $02 ; $68d4
	farcall FarPtr_ScriptSetActorAnimation ; $68d6
	ld a, $08 ; $68d9
	farcall FarPtr_ScriptWaitActorIdle ; $68db
	ld a, $05 ; $68de
	ld bc, $2380 ; $68e0
	ld de, $3100 ; $68e3
	farcall FarPtr_ScriptSetActorPosition ; $68e6
	sound $96 ; $68e9
	push af ; $68eb
	ld a, $3c ; $68ec
	farcall FarPtr_WaitScriptFrames ; $68ee
	pop af ; $68f1
	ld a, $09 ; $68f2
	ld b, a ; $68f4
	ld a, $08 ; $68f5
	farcall FarPtr_FaceActorTowardActor ; $68f7
	push af ; $68fa
	ld a, $01 ; $68fb
	farcall FarPtr_WaitScriptFrames ; $68fd
	pop af ; $6900
	ld a, $08 ; $6901
	ld d, $02 ; $6903
	farcall FarPtr_ScriptSetActorAnimation ; $6905
	ld a, $08 ; $6908
	farcall FarPtr_ScriptWaitActorIdle ; $690a
	ld a, $03 ; $690d
	ld bc, $1f80 ; $690f
	ld de, $3100 ; $6912
	farcall FarPtr_ScriptSetActorPosition ; $6915
	sound $96 ; $6918
	push af ; $691a
	ld a, $3c ; $691b
	farcall FarPtr_WaitScriptFrames ; $691d
	pop af ; $6920
	test_flag $05, 7 ; $6921
	jp z, Label_10_69c0 ; $6924
	ld a, $02 ; $6927
	farcall FarPtr_0a_1c ; $6929
	ld a, $02 ; $692c
	ld bc, $2d00 ; $692e
	ld de, $3b00 ; $6931
	farcall FarPtr_ScriptSetActorPosition ; $6934
	ld a, $00 ; $6937
	ld bc, $2100 ; $6939
	ld de, $3b00 ; $693c
	farcall FarPtr_ScriptSetActorMoveTarget ; $693f
	ld a, $02 ; $6942
	ld bc, $2300 ; $6944
	ld de, $3b00 ; $6947
	farcall FarPtr_ScriptSetActorMoveTarget ; $694a
	ld a, $02 ; $694d
	farcall FarPtr_ScriptWaitActorMoveDone ; $694f
	push af ; $6952
	ld a, $05 ; $6953
	farcall FarPtr_WaitScriptFrames ; $6955
	pop af ; $6958
	ld a, $00 ; $6959
	ld b, $c0 ; $695b
	farcall FarPtr_SetActorFacing ; $695d
	call Func_10_7339 ; $6960
	ld a, $00 ; $6963
	ld bc, $2100 ; $6965
	ld de, $3500 ; $6968
	farcall FarPtr_ScriptSetActorMoveTarget ; $696b
	ld a, $02 ; $696e
	ld bc, $2100 ; $6970
	ld de, $3b00 ; $6973
	farcall FarPtr_ScriptSetActorMoveTarget ; $6976
	ld a, $02 ; $6979
	farcall FarPtr_ScriptWaitActorMoveDone ; $697b
	ld a, $00 ; $697e
	ld bc, $1f00 ; $6980
	ld de, $3500 ; $6983
	farcall FarPtr_ScriptSetActorMoveTarget ; $6986
	ld a, $02 ; $6989
	ld bc, $2100 ; $698b
	ld de, $3500 ; $698e
	farcall FarPtr_ScriptSetActorMoveTarget ; $6991
	ld a, $02 ; $6994
	farcall FarPtr_ScriptWaitActorMoveDone ; $6996
	ld a, $02 ; $6999
	ld bc, $2100 ; $699b
	ld de, $3500 ; $699e
	farcall FarPtr_ScriptSetActorMoveTarget ; $69a1
	ld a, $02 ; $69a4
	farcall FarPtr_ScriptWaitActorMoveDone ; $69a6
	ld a, $00 ; $69a9
	ld b, $c0 ; $69ab
	farcall FarPtr_SetActorFacing ; $69ad
	ld a, $02 ; $69b0
	ld b, $c0 ; $69b2
	farcall FarPtr_SetActorFacing ; $69b4
	push af ; $69b7
	ld a, $01 ; $69b8
	farcall FarPtr_WaitScriptFrames ; $69ba
	pop af ; $69bd
	jr Label_10_6a08 ; $69be
Label_10_69c0:
	ld a, $00 ; $69c0
	ld bc, $2100 ; $69c2
	ld de, $3b00 ; $69c5
	farcall FarPtr_ScriptSetActorMoveTarget ; $69c8
	ld a, $00 ; $69cb
	farcall FarPtr_ScriptWaitActorMoveDone ; $69cd
	ld a, $00 ; $69d0
	ld b, $c0 ; $69d2
	farcall FarPtr_SetActorFacing ; $69d4
	call Func_10_7339 ; $69d7
	ld a, $00 ; $69da
	ld bc, $2100 ; $69dc
	ld de, $3500 ; $69df
	farcall FarPtr_ScriptSetActorMoveTarget ; $69e2
	ld a, $00 ; $69e5
	farcall FarPtr_ScriptWaitActorMoveDone ; $69e7
	ld a, $00 ; $69ea
	ld bc, $2000 ; $69ec
	ld de, $3500 ; $69ef
	farcall FarPtr_ScriptSetActorMoveTarget ; $69f2
	ld a, $00 ; $69f5
	farcall FarPtr_ScriptWaitActorMoveDone ; $69f7
	ld a, $00 ; $69fa
	ld b, $c0 ; $69fc
	farcall FarPtr_SetActorFacing ; $69fe
	push af ; $6a01
	ld a, $01 ; $6a02
	farcall FarPtr_WaitScriptFrames ; $6a04
	pop af ; $6a07
Label_10_6a08:
	call Func_10_736f ; $6a08
	ld a, $03 ; $6a0b
	ld bc, $3f00 ; $6a0d
	ld de, $3f00 ; $6a10
	farcall FarPtr_ScriptSetActorPosition ; $6a13
	ld a, $05 ; $6a16
	ld bc, $3f00 ; $6a18
	ld de, $3f00 ; $6a1b
	farcall FarPtr_ScriptSetActorPosition ; $6a1e
	push af ; $6a21
	ld a, $0a ; $6a22
	farcall FarPtr_WaitScriptFrames ; $6a24
	pop af ; $6a27
	ld a, $07 ; $6a28
	ld b, $40 ; $6a2a
	farcall FarPtr_SetActorFacing ; $6a2c
	ld a, $08 ; $6a2f
	ld b, $40 ; $6a31
	farcall FarPtr_SetActorFacing ; $6a33
	ld a, $09 ; $6a36
	ld b, $40 ; $6a38
	farcall FarPtr_SetActorFacing ; $6a3a
	push af ; $6a3d
	ld a, $01 ; $6a3e
	farcall FarPtr_WaitScriptFrames ; $6a40
	pop af ; $6a43
	ld a, $06 ; $6a44
	ld d, $02 ; $6a46
	farcall FarPtr_ScriptSetActorAnimation ; $6a48
	ld a, $07 ; $6a4b
	ld d, $02 ; $6a4d
	farcall FarPtr_ScriptSetActorAnimation ; $6a4f
	ld a, $08 ; $6a52
	ld d, $02 ; $6a54
	farcall FarPtr_ScriptSetActorAnimation ; $6a56
	ld a, $09 ; $6a59
	ld d, $02 ; $6a5b
	farcall FarPtr_ScriptSetActorAnimation ; $6a5d
	ld a, $09 ; $6a60
	farcall FarPtr_ScriptWaitActorIdle ; $6a62
	push af ; $6a65
	ld a, $1e ; $6a66
	farcall FarPtr_WaitScriptFrames ; $6a68
	pop af ; $6a6b
	ld a, $08 ; $6a6c
	ld bc, $2300 ; $6a6e
	ld de, $3300 ; $6a71
	farcall FarPtr_ScriptSetActorMoveTarget ; $6a74
	ld a, $07 ; $6a77
	ld bc, $2500 ; $6a79
	ld de, $3300 ; $6a7c
	farcall FarPtr_ScriptSetActorMoveTarget ; $6a7f
	ld a, $09 ; $6a82
	ld bc, $1d00 ; $6a84
	ld de, $3500 ; $6a87
	farcall FarPtr_ScriptSetActorMoveTarget ; $6a8a
	ld a, $09 ; $6a8d
	farcall FarPtr_ScriptWaitActorMoveDone ; $6a8f
	ld a, $09 ; $6a92
	ld b, $00 ; $6a94
	farcall FarPtr_SetActorFacing ; $6a96
	ld a, $08 ; $6a99
	ld bc, $2300 ; $6a9b
	ld de, $3500 ; $6a9e
	farcall FarPtr_ScriptSetActorMoveTarget ; $6aa1
	ld a, $07 ; $6aa4
	ld bc, $2500 ; $6aa6
	ld de, $3500 ; $6aa9
	farcall FarPtr_ScriptSetActorMoveTarget ; $6aac
	ld a, $07 ; $6aaf
	farcall FarPtr_ScriptWaitActorMoveDone ; $6ab1
	ld a, $08 ; $6ab4
	ld b, $80 ; $6ab6
	farcall FarPtr_SetActorFacing ; $6ab8
	ld a, $07 ; $6abb
	ld b, $80 ; $6abd
	farcall FarPtr_SetActorFacing ; $6abf
	push af ; $6ac2
	ld a, $0a ; $6ac3
	farcall FarPtr_WaitScriptFrames ; $6ac5
	pop af ; $6ac8
	test_flag $05, 7 ; $6ac9
	jp z, Label_10_6b73 ; $6acc
	push af ; $6acf
	ld a, $3c ; $6ad0
	farcall FarPtr_WaitScriptFrames ; $6ad2
	pop af ; $6ad5
	ld a, $02 ; $6ad6
	ld b, a ; $6ad8
	ld a, $00 ; $6ad9
	farcall FarPtr_FaceActorTowardActor ; $6adb
	ld a, $00 ; $6ade
	ld d, $02 ; $6ae0
	farcall FarPtr_ScriptSetActorAnimation ; $6ae2
	ld a, $00 ; $6ae5
	farcall FarPtr_ScriptWaitActorIdle ; $6ae7
	push af ; $6aea
	ld a, $14 ; $6aeb
	farcall FarPtr_WaitScriptFrames ; $6aed
	pop af ; $6af0
	ld a, $00 ; $6af1
	ld b, a ; $6af3
	ld a, $02 ; $6af4
	farcall FarPtr_FaceActorTowardActor ; $6af6
	push af ; $6af9
	ld a, $01 ; $6afa
	farcall FarPtr_WaitScriptFrames ; $6afc
	pop af ; $6aff
	ld a, $02 ; $6b00
	ld d, $03 ; $6b02
	farcall FarPtr_ScriptSetActorAnimation ; $6b04
	ld a, $02 ; $6b07
	farcall FarPtr_ScriptWaitActorIdle ; $6b09
	push af ; $6b0c
	ld a, $14 ; $6b0d
	farcall FarPtr_WaitScriptFrames ; $6b0f
	pop af ; $6b12
	ld a, $00 ; $6b13
	ld b, $c0 ; $6b15
	farcall FarPtr_SetActorFacing ; $6b17
	ld a, $02 ; $6b1a
	ld b, $c0 ; $6b1c
	farcall FarPtr_SetActorFacing ; $6b1e
	ld a, $07 ; $6b21
	ld d, $03 ; $6b23
	farcall FarPtr_ScriptSetActorAnimation ; $6b25
	ld a, $08 ; $6b28
	ld d, $03 ; $6b2a
	farcall FarPtr_ScriptSetActorAnimation ; $6b2c
	ld a, $09 ; $6b2f
	ld d, $03 ; $6b31
	farcall FarPtr_ScriptSetActorAnimation ; $6b33
	ld a, $09 ; $6b36
	farcall FarPtr_ScriptWaitActorIdle ; $6b38
	push af ; $6b3b
	ld a, $28 ; $6b3c
	farcall FarPtr_WaitScriptFrames ; $6b3e
	pop af ; $6b41
	ld a, $00 ; $6b42
	ld d, $03 ; $6b44
	farcall FarPtr_ScriptSetActorAnimation ; $6b46
	ld a, $02 ; $6b49
	ld d, $03 ; $6b4b
	farcall FarPtr_ScriptSetActorAnimation ; $6b4d
	ld a, $02 ; $6b50
	farcall FarPtr_ScriptWaitActorIdle ; $6b52
	ld a, $00 ; $6b55
	ld bc, $1f00 ; $6b57
	ld de, $3200 ; $6b5a
	farcall FarPtr_ScriptSetActorMoveTarget ; $6b5d
	ld a, $02 ; $6b60
	ld bc, $2100 ; $6b62
	ld de, $3200 ; $6b65
	farcall FarPtr_ScriptSetActorMoveTarget ; $6b68
	ld a, $02 ; $6b6b
	farcall FarPtr_ScriptWaitActorMoveDone ; $6b6d
	jp Label_10_6c02 ; $6b70
Label_10_6b73:
	ld a, $04 ; $6b73
	ld bc, $2180 ; $6b75
	ld de, $3300 ; $6b78
	farcall FarPtr_ScriptSetActorPosition ; $6b7b
	sound $96 ; $6b7e
	push af ; $6b80
	ld a, $50 ; $6b81
	farcall FarPtr_WaitScriptFrames ; $6b83
	pop af ; $6b86
	ld a, $04 ; $6b87
	ld bc, $3f00 ; $6b89
	ld de, $3f00 ; $6b8c
	farcall FarPtr_ScriptSetActorPosition ; $6b8f
	ld a, $09 ; $6b92
	ld b, a ; $6b94
	ld a, $00 ; $6b95
	farcall FarPtr_FaceActorTowardActor ; $6b97
	push af ; $6b9a
	ld a, $28 ; $6b9b
	farcall FarPtr_WaitScriptFrames ; $6b9d
	pop af ; $6ba0
	ld a, $00 ; $6ba1
	ld b, a ; $6ba3
	ld a, $09 ; $6ba4
	farcall FarPtr_FaceActorTowardActor ; $6ba6
	push af ; $6ba9
	ld a, $01 ; $6baa
	farcall FarPtr_WaitScriptFrames ; $6bac
	pop af ; $6baf
	ld a, $09 ; $6bb0
	ld d, $03 ; $6bb2
	farcall FarPtr_ScriptSetActorAnimation ; $6bb4
	ld a, $09 ; $6bb7
	farcall FarPtr_ScriptWaitActorIdle ; $6bb9
	push af ; $6bbc
	ld a, $14 ; $6bbd
	farcall FarPtr_WaitScriptFrames ; $6bbf
	pop af ; $6bc2
	ld a, $00 ; $6bc3
	ld b, $c0 ; $6bc5
	farcall FarPtr_SetActorFacing ; $6bc7
	ld a, $07 ; $6bca
	ld d, $03 ; $6bcc
	farcall FarPtr_ScriptSetActorAnimation ; $6bce
	ld a, $08 ; $6bd1
	ld d, $03 ; $6bd3
	farcall FarPtr_ScriptSetActorAnimation ; $6bd5
	ld a, $09 ; $6bd8
	ld d, $03 ; $6bda
	farcall FarPtr_ScriptSetActorAnimation ; $6bdc
	ld a, $09 ; $6bdf
	farcall FarPtr_ScriptWaitActorIdle ; $6be1
	push af ; $6be4
	ld a, $28 ; $6be5
	farcall FarPtr_WaitScriptFrames ; $6be7
	pop af ; $6bea
	ld a, $00 ; $6beb
	ld d, $03 ; $6bed
	farcall FarPtr_ScriptSetActorAnimation ; $6bef
	ld a, $00 ; $6bf2
	ld bc, $2000 ; $6bf4
	ld de, $3200 ; $6bf7
	farcall FarPtr_ScriptSetActorMoveTarget ; $6bfa
	ld a, $00 ; $6bfd
	farcall FarPtr_ScriptWaitActorMoveDone ; $6bff
Label_10_6c02:
	push af ; $6c02
	ld a, $01 ; $6c03
	farcall FarPtr_WaitScriptFrames ; $6c05
	pop af ; $6c08
	ld a, $09 ; $6c09
	ld bc, $1e00 ; $6c0b
	ld de, $3500 ; $6c0e
	farcall FarPtr_ScriptSetActorMoveTarget ; $6c11
	ld a, $08 ; $6c14
	ld bc, $2000 ; $6c16
	ld de, $3500 ; $6c19
	farcall FarPtr_ScriptSetActorMoveTarget ; $6c1c
	ld a, $07 ; $6c1f
	ld bc, $2200 ; $6c21
	ld de, $3500 ; $6c24
	farcall FarPtr_ScriptSetActorMoveTarget ; $6c27
	ld a, $07 ; $6c2a
	farcall FarPtr_ScriptWaitActorMoveDone ; $6c2c
	ld a, $09 ; $6c2f
	ld b, $c0 ; $6c31
	farcall FarPtr_SetActorFacing ; $6c33
	ld a, $08 ; $6c36
	ld b, $c0 ; $6c38
	farcall FarPtr_SetActorFacing ; $6c3a
	ld a, $07 ; $6c3d
	ld b, $c0 ; $6c3f
	farcall FarPtr_SetActorFacing ; $6c41
	ld a, $06 ; $6c44
	ld d, $03 ; $6c46
	farcall FarPtr_ScriptSetActorAnimation ; $6c48
	ld a, $06 ; $6c4b
	farcall FarPtr_ScriptWaitActorIdle ; $6c4d
	ld h, $00 ; $6c50
	ld l, $02 ; $6c52
	test_flag $15, 6 ; $6c54
	jr z, Label_10_6c5a ; $6c57
	inc l ; $6c59
Label_10_6c5a:
	test_flag $15, 7 ; $6c5a
	jr z, Label_10_6c60 ; $6c5d
	inc l ; $6c5f
Label_10_6c60:
	farcall FarPtr_PushTextArgNumber ; $6c60
	ld a, $06 ; $6c63
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6c65
	ld a, $00 ; $6c68
	ld d, $02 ; $6c6a
	farcall FarPtr_ScriptSetActorAnimation ; $6c6c
	ld a, $00 ; $6c6f
	farcall FarPtr_ScriptWaitActorIdle ; $6c71
	ld a, $06 ; $6c74
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6c76
	ld a, $00 ; $6c79
	ld d, $03 ; $6c7b
	farcall FarPtr_ScriptSetActorAnimation ; $6c7d
	ld a, $00 ; $6c80
	farcall FarPtr_ScriptWaitActorIdle ; $6c82
	ld d, $51 ; $6c85
	ld a, $05 ; $6c87
	farcall FarPtr_GetActorStateAddr ; $6c89
	ld c, l ; $6c8c
	ld b, h ; $6c8d
	farcall FarPtr_04_2c ; $6c8e
	ld a, $05 ; $6c91
	ld d, $01 ; $6c93
	farcall FarPtr_ScriptSetActorAnimation ; $6c95
	ld a, $05 ; $6c98
	ld bc, $2380 ; $6c9a
	ld de, $3300 ; $6c9d
	farcall FarPtr_ScriptSetActorPosition ; $6ca0
	sound $97 ; $6ca3
	push af ; $6ca5
	ld a, $14 ; $6ca6
	farcall FarPtr_WaitScriptFrames ; $6ca8
	pop af ; $6cab
	ld a, $07 ; $6cac
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6cae
	ld a, $05 ; $6cb1
	ld bc, $3f00 ; $6cb3
	ld de, $3f00 ; $6cb6
	farcall FarPtr_ScriptSetActorPosition ; $6cb9
	ld a, $06 ; $6cbc
	ld d, $03 ; $6cbe
	farcall FarPtr_ScriptSetActorAnimation ; $6cc0
	ld a, $06 ; $6cc3
	farcall FarPtr_ScriptWaitActorIdle ; $6cc5
	ld a, $06 ; $6cc8
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6cca
	ld a, $08 ; $6ccd
	ld b, a ; $6ccf
	ld a, $07 ; $6cd0
	farcall FarPtr_FaceActorsTowardEachOther ; $6cd2
	ld a, $07 ; $6cd5
	ld d, $03 ; $6cd7
	farcall FarPtr_ScriptSetActorAnimation ; $6cd9
	ld a, $08 ; $6cdc
	ld d, $03 ; $6cde
	farcall FarPtr_ScriptSetActorAnimation ; $6ce0
	ld a, $08 ; $6ce3
	farcall FarPtr_ScriptWaitActorIdle ; $6ce5
	push af ; $6ce8
	ld a, $28 ; $6ce9
	farcall FarPtr_WaitScriptFrames ; $6ceb
	pop af ; $6cee
	ld a, $08 ; $6cef
	ld b, a ; $6cf1
	ld a, $09 ; $6cf2
	farcall FarPtr_FaceActorsTowardEachOther ; $6cf4
	ld a, $09 ; $6cf7
	ld d, $03 ; $6cf9
	farcall FarPtr_ScriptSetActorAnimation ; $6cfb
	ld a, $08 ; $6cfe
	ld d, $03 ; $6d00
	farcall FarPtr_ScriptSetActorAnimation ; $6d02
	ld a, $08 ; $6d05
	farcall FarPtr_ScriptWaitActorIdle ; $6d07
	push af ; $6d0a
	ld a, $28 ; $6d0b
	farcall FarPtr_WaitScriptFrames ; $6d0d
	pop af ; $6d10
	ld a, $07 ; $6d11
	ld b, $c0 ; $6d13
	farcall FarPtr_SetActorFacing ; $6d15
	ld a, $08 ; $6d18
	ld b, $c0 ; $6d1a
	farcall FarPtr_SetActorFacing ; $6d1c
	ld a, $09 ; $6d1f
	ld b, $c0 ; $6d21
	farcall FarPtr_SetActorFacing ; $6d23
	push af ; $6d26
	ld a, $28 ; $6d27
	farcall FarPtr_WaitScriptFrames ; $6d29
	pop af ; $6d2c
	ld a, $09 ; $6d2d
	ld d, $03 ; $6d2f
	farcall FarPtr_ScriptSetActorAnimation ; $6d31
	ld a, $07 ; $6d34
	ld d, $03 ; $6d36
	farcall FarPtr_ScriptSetActorAnimation ; $6d38
	ld a, $08 ; $6d3b
	ld d, $03 ; $6d3d
	farcall FarPtr_ScriptSetActorAnimation ; $6d3f
	ld a, $08 ; $6d42
	farcall FarPtr_ScriptWaitActorIdle ; $6d44
	push af ; $6d47
	ld a, $3c ; $6d48
	farcall FarPtr_WaitScriptFrames ; $6d4a
	pop af ; $6d4d
	ld d, $4d ; $6d4e
	ld a, $05 ; $6d50
	farcall FarPtr_GetActorStateAddr ; $6d52
	ld c, l ; $6d55
	ld b, h ; $6d56
	farcall FarPtr_04_2c ; $6d57
	ld a, $05 ; $6d5a
	ld d, $01 ; $6d5c
	farcall FarPtr_ScriptSetActorAnimation ; $6d5e
	ld a, $05 ; $6d61
	ld bc, $2180 ; $6d63
	ld de, $2d80 ; $6d66
	farcall FarPtr_ScriptSetActorPosition ; $6d69
	sound $98 ; $6d6c
	push af ; $6d6e
	ld a, $50 ; $6d6f
	farcall FarPtr_WaitScriptFrames ; $6d71
	pop af ; $6d74
	ld a, $05 ; $6d75
	ld bc, $3f00 ; $6d77
	ld de, $3f00 ; $6d7a
	farcall FarPtr_ScriptSetActorPosition ; $6d7d
	ld a, $06 ; $6d80
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $6d82
	farcall FarPtr_RunDialogueYesNoPrompt ; $6d85
	farcall FarPtr_ScriptCloseDialogueWindow ; $6d88
	push af ; $6d8b
	ld a, $05 ; $6d8c
	farcall FarPtr_WaitScriptFrames ; $6d8e
	pop af ; $6d91
	and a, a ; $6d92
	jp z, Label_10_6eae ; $6d93
	ld a, $06 ; $6d96
	ld d, $02 ; $6d98
	farcall FarPtr_ScriptSetActorAnimation ; $6d9a
	ld a, $06 ; $6d9d
	farcall FarPtr_ScriptWaitActorIdle ; $6d9f
	ld a, $06 ; $6da2
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6da4
	test_flag $05, 7 ; $6da7
	jp z, Label_10_6e27 ; $6daa
	ld a, $08 ; $6dad
	ld bc, $2000 ; $6daf
	ld de, $3400 ; $6db2
	farcall FarPtr_ScriptSetActorMoveTarget ; $6db5
	ld a, $08 ; $6db8
	farcall FarPtr_ScriptWaitActorMoveDone ; $6dba
	ld a, $08 ; $6dbd
	ld b, a ; $6dbf
	ld a, $00 ; $6dc0
	farcall FarPtr_FaceActorTowardActor ; $6dc2
	ld a, $08 ; $6dc5
	ld b, a ; $6dc7
	ld a, $02 ; $6dc8
	farcall FarPtr_FaceActorTowardActor ; $6dca
	ld a, $08 ; $6dcd
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6dcf
	push af ; $6dd2
	ld a, $1e ; $6dd3
	farcall FarPtr_WaitScriptFrames ; $6dd5
	pop af ; $6dd8
	ld a, $07 ; $6dd9
	ld bc, $2200 ; $6ddb
	ld de, $3400 ; $6dde
	farcall FarPtr_ScriptSetActorMoveTarget ; $6de1
	ld a, $07 ; $6de4
	farcall FarPtr_ScriptWaitActorMoveDone ; $6de6
	ld a, $07 ; $6de9
	ld b, a ; $6deb
	ld a, $00 ; $6dec
	farcall FarPtr_FaceActorTowardActor ; $6dee
	ld a, $07 ; $6df1
	ld b, a ; $6df3
	ld a, $02 ; $6df4
	farcall FarPtr_FaceActorTowardActor ; $6df6
	ld a, $07 ; $6df9
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6dfb
	push af ; $6dfe
	ld a, $1e ; $6dff
	farcall FarPtr_WaitScriptFrames ; $6e01
	pop af ; $6e04
	ld a, $09 ; $6e05
	ld bc, $1d00 ; $6e07
	ld de, $3200 ; $6e0a
	farcall FarPtr_ScriptSetActorMoveTarget ; $6e0d
	ld a, $09 ; $6e10
	farcall FarPtr_ScriptWaitActorMoveDone ; $6e12
	ld a, $09 ; $6e15
	ld b, a ; $6e17
	ld a, $00 ; $6e18
	farcall FarPtr_FaceActorsTowardEachOther ; $6e1a
	ld a, $09 ; $6e1d
	ld b, a ; $6e1f
	ld a, $02 ; $6e20
	farcall FarPtr_FaceActorTowardActor ; $6e22
	jr Label_10_6e87 ; $6e25
Label_10_6e27:
	ld a, $08 ; $6e27
	ld bc, $2000 ; $6e29
	ld de, $3400 ; $6e2c
	farcall FarPtr_ScriptSetActorMoveTarget ; $6e2f
	ld a, $08 ; $6e32
	farcall FarPtr_ScriptWaitActorMoveDone ; $6e34
	ld a, $08 ; $6e37
	ld b, a ; $6e39
	ld a, $00 ; $6e3a
	farcall FarPtr_FaceActorTowardActor ; $6e3c
	ld a, $08 ; $6e3f
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6e41
	push af ; $6e44
	ld a, $1e ; $6e45
	farcall FarPtr_WaitScriptFrames ; $6e47
	pop af ; $6e4a
	ld a, $07 ; $6e4b
	ld bc, $2200 ; $6e4d
	ld de, $3400 ; $6e50
	farcall FarPtr_ScriptSetActorMoveTarget ; $6e53
	ld a, $07 ; $6e56
	farcall FarPtr_ScriptWaitActorMoveDone ; $6e58
	ld a, $07 ; $6e5b
	ld b, a ; $6e5d
	ld a, $00 ; $6e5e
	farcall FarPtr_FaceActorTowardActor ; $6e60
	ld a, $07 ; $6e63
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6e65
	push af ; $6e68
	ld a, $1e ; $6e69
	farcall FarPtr_WaitScriptFrames ; $6e6b
	pop af ; $6e6e
	ld a, $09 ; $6e6f
	ld bc, $1e00 ; $6e71
	ld de, $3200 ; $6e74
	farcall FarPtr_ScriptSetActorMoveTarget ; $6e77
	ld a, $09 ; $6e7a
	farcall FarPtr_ScriptWaitActorMoveDone ; $6e7c
	ld a, $09 ; $6e7f
	ld b, a ; $6e81
	ld a, $00 ; $6e82
	farcall FarPtr_FaceActorsTowardEachOther ; $6e84
Label_10_6e87:
	ld a, $09 ; $6e87
	ld d, $04 ; $6e89
	farcall FarPtr_ScriptSetActorAnimation ; $6e8b
	ld a, $09 ; $6e8e
	farcall FarPtr_ScriptWaitActorIdle ; $6e90
	ld hl, $01eb ; $6e93
	farcall FarPtr_InitDialogueTextCursor ; $6e96
	ld a, $09 ; $6e99
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $6e9b
	farcall FarPtr_RunDialogueYesNoPrompt ; $6e9e
	farcall FarPtr_ScriptCloseDialogueWindow ; $6ea1
	push af ; $6ea4
	ld a, $05 ; $6ea5
	farcall FarPtr_WaitScriptFrames ; $6ea7
	pop af ; $6eaa
	and a, a ; $6eab
	jr nz, Label_10_6e87 ; $6eac
Label_10_6eae:
	ld a, $06 ; $6eae
	ld d, $03 ; $6eb0
	farcall FarPtr_ScriptSetActorAnimation ; $6eb2
	ld a, $06 ; $6eb5
	farcall FarPtr_ScriptWaitActorIdle ; $6eb7
	ld a, $07 ; $6eba
	ld b, $c0 ; $6ebc
	farcall FarPtr_SetActorFacing ; $6ebe
	ld a, $08 ; $6ec1
	ld b, $c0 ; $6ec3
	farcall FarPtr_SetActorFacing ; $6ec5
	ld a, $09 ; $6ec8
	ld b, $c0 ; $6eca
	farcall FarPtr_SetActorFacing ; $6ecc
	ld a, $00 ; $6ecf
	ld b, $c0 ; $6ed1
	farcall FarPtr_SetActorFacing ; $6ed3
	test_flag $05, 7 ; $6ed6
	jp z, Label_10_6ee3 ; $6ed9
	ld a, $02 ; $6edc
	ld b, $c0 ; $6ede
	farcall FarPtr_SetActorFacing ; $6ee0
Label_10_6ee3:
	push af ; $6ee3
	ld a, $14 ; $6ee4
	farcall FarPtr_WaitScriptFrames ; $6ee6
	pop af ; $6ee9
	ld a, $07 ; $6eea
	ld d, $03 ; $6eec
	farcall FarPtr_ScriptSetActorAnimation ; $6eee
	ld a, $08 ; $6ef1
	ld d, $03 ; $6ef3
	farcall FarPtr_ScriptSetActorAnimation ; $6ef5
	ld a, $09 ; $6ef8
	ld d, $03 ; $6efa
	farcall FarPtr_ScriptSetActorAnimation ; $6efc
	test_flag $05, 7 ; $6eff
	jp z, Label_10_6f0c ; $6f02
	ld a, $02 ; $6f05
	ld d, $03 ; $6f07
	farcall FarPtr_ScriptSetActorAnimation ; $6f09
Label_10_6f0c:
	ld a, $00 ; $6f0c
	ld d, $03 ; $6f0e
	farcall FarPtr_ScriptSetActorAnimation ; $6f10
	ld a, $00 ; $6f13
	farcall FarPtr_ScriptWaitActorIdle ; $6f15
	ld hl, $01ec ; $6f18
	farcall FarPtr_InitDialogueTextCursor ; $6f1b
	ld a, $06 ; $6f1e
	farcall FarPtr_ScriptShowSpeakerDialogue ; $6f20
	ld c, $04 ; $6f23
	call BeginFadeOut ; $6f25
	call WaitFadeEnd ; $6f28
	push af ; $6f2b
	ld a, $32 ; $6f2c
	farcall FarPtr_WaitScriptFrames ; $6f2e
	pop af ; $6f31
	ld a, $0a ; $6f32
	ld [wStoryModeCurrentLocation], a ; $6f34
	ld a, $0a ; $6f37
	ld [$c295], a ; $6f39
	ld a, $ff ; $6f3c
	ld [$c294], a ; $6f3e
	ld [$c2a1], a ; $6f41
	ret ; $6f44
	; $6f45, 136 bytes (bytes:14)
	db $00, $00, $d1, $7b, $00, $fd, $00, $01, $40, $00, $4e, $01, $00, $00 ; 0x00
	db $00, $00, $d1, $7b, $00, $fd, $00, $01, $40, $00, $53, $01, $00, $00 ; 0x0e
	db $00, $00, $d1, $7b, $00, $fd, $00, $01, $40, $00, $51, $01, $00, $00 ; 0x1c
	db $00, $00, $d1, $7b, $00, $20, $00, $2f, $40, $00, $63, $01, $00, $00 ; 0x2a
	db $00, $00, $d1, $7b, $00, $22, $00, $33, $c0, $00, $4b, $01, $00, $00 ; 0x38
	db $00, $00, $d1, $7b, $00, $20, $00, $33, $c0, $00, $4a, $01, $00, $00 ; 0x46
	db $00, $00, $d1, $7b, $00, $1e, $00, $33, $c0, $00, $49, $01, $00, $00 ; 0x54
	db $00, $00, $d1, $7b, $00, $27, $40, $32, $40, $00, $74, $01, $00, $00 ; 0x62
	db $00, $00, $d1, $7b, $00, $27, $c0, $30, $40, $00, $74, $01, $00, $00 ; 0x70
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $ff ; 0x7e
Label_10_6fcd:
	ldh a, [hRomBank] ; $6fcd
	ld hl, $739e ; $6fcf
	farcall FarPtr_0a_06 ; $6fd2
	farcall FarPtr_0a_00 ; $6fd5
	ld a, $04 ; $6fd8
	ld d, $06 ; $6fda
	farcall FarPtr_ScriptSetActorAnimation ; $6fdc
	test_flag $05, 7 ; $6fdf
	jp z, Label_10_7019 ; $6fe2
	ld a, $02 ; $6fe5
	farcall FarPtr_0a_1c ; $6fe7
	ld a, $00 ; $6fea
	ld bc, $1f00 ; $6fec
	ld de, $3400 ; $6fef
	farcall FarPtr_ScriptSetActorPosition ; $6ff2
	ld a, $02 ; $6ff5
	ld bc, $2100 ; $6ff7
	ld de, $3400 ; $6ffa
	farcall FarPtr_ScriptSetActorPosition ; $6ffd
	ld a, $02 ; $7000
	ld b, $c0 ; $7002
	farcall FarPtr_SetActorFacing ; $7004
	test_flag $07, 4 ; $7007
	jr nz, Label_10_7029 ; $700a
	ld a, $04 ; $700c
	ld bc, $3f00 ; $700e
	ld de, $3f00 ; $7011
	farcall FarPtr_ScriptSetActorPosition ; $7014
	jr Label_10_7029 ; $7017
Label_10_7019:
	test_flag $06, 5 ; $7019
	jr nz, Label_10_7029 ; $701c
	ld a, $05 ; $701e
	ld bc, $3f00 ; $7020
	ld de, $3f00 ; $7023
	farcall FarPtr_ScriptSetActorPosition ; $7026
Label_10_7029:
	ld a, $00 ; $7029
	ld b, $c0 ; $702b
	farcall FarPtr_SetActorFacing ; $702d
	xor a, a ; $7030
	ld [$c2d5], a ; $7031
	ld c, $04 ; $7034
	call BeginFadeIn ; $7036
	call WaitFadeEnd ; $7039
	push af ; $703c
	ld a, $3c ; $703d
	farcall FarPtr_WaitScriptFrames ; $703f
	pop af ; $7042
	ld hl, $01f2 ; $7043
	farcall FarPtr_InitDialogueTextCursor ; $7046
	call Func_10_73ee ; $7049
	test_flag $05, 7 ; $704c
	jp z, Label_10_7059 ; $704f
	ld a, $02 ; $7052
	ld d, $02 ; $7054
	farcall FarPtr_ScriptSetActorAnimation ; $7056
Label_10_7059:
	ld a, $00 ; $7059
	ld d, $02 ; $705b
	farcall FarPtr_ScriptSetActorAnimation ; $705d
	ld a, $00 ; $7060
	farcall FarPtr_ScriptWaitActorIdle ; $7062
	call Func_10_7405 ; $7065
	farcall FarPtr_RunDialogueYesNoPrompt ; $7068
	farcall FarPtr_ScriptCloseDialogueWindow ; $706b
	push af ; $706e
	ld a, $05 ; $706f
	farcall FarPtr_WaitScriptFrames ; $7071
	pop af ; $7074
	and a, a ; $7075
	jr nz, Label_10_7089 ; $7076
	ld a, $00 ; $7078
	ld d, $03 ; $707a
	farcall FarPtr_ScriptSetActorAnimation ; $707c
	ld a, $00 ; $707f
	farcall FarPtr_ScriptWaitActorIdle ; $7081
	farcall FarPtr_AdvanceDialogueTextCursor ; $7084
	jr Label_10_7095 ; $7087
Label_10_7089:
	ld a, $00 ; $7089
	ld d, $04 ; $708b
	farcall FarPtr_ScriptSetActorAnimation ; $708d
	ld a, $00 ; $7090
	farcall FarPtr_ScriptWaitActorIdle ; $7092
Label_10_7095:
	push af ; $7095
	ld a, $0a ; $7096
	farcall FarPtr_WaitScriptFrames ; $7098
	pop af ; $709b
	ld a, $03 ; $709c
	ld d, $03 ; $709e
	farcall FarPtr_ScriptSetActorAnimation ; $70a0
	ld a, $03 ; $70a3
	farcall FarPtr_ScriptWaitActorIdle ; $70a5
	ld a, $03 ; $70a8
	farcall FarPtr_ScriptShowSpeakerDialogue ; $70aa
	ld a, $03 ; $70ad
	ld b, $c0 ; $70af
	farcall FarPtr_SetActorFacing ; $70b1
	push af ; $70b4
	ld a, $50 ; $70b5
	farcall FarPtr_WaitScriptFrames ; $70b7
	pop af ; $70ba
	ld hl, $01f8 ; $70bb
	farcall FarPtr_InitDialogueTextCursor ; $70be
	call Func_10_73ee ; $70c1
	test_flag $05, 7 ; $70c4
	jp z, Label_10_7101 ; $70c7
	ld a, $06 ; $70ca
	ld bc, $2080 ; $70cc
	ld de, $3200 ; $70cf
	farcall FarPtr_ScriptSetActorPosition ; $70d2
	ld a, $07 ; $70d5
	ld bc, $2280 ; $70d7
	ld de, $3200 ; $70da
	farcall FarPtr_ScriptSetActorPosition ; $70dd
	sound $97 ; $70e0
	push af ; $70e2
	ld a, $50 ; $70e3
	farcall FarPtr_WaitScriptFrames ; $70e5
	pop af ; $70e8
	ld a, $06 ; $70e9
	ld bc, $3f00 ; $70eb
	ld de, $3f00 ; $70ee
	farcall FarPtr_ScriptSetActorPosition ; $70f1
	ld a, $07 ; $70f4
	ld bc, $3f00 ; $70f6
	ld de, $3f00 ; $70f9
	farcall FarPtr_ScriptSetActorPosition ; $70fc
	jr Label_10_7120 ; $70ff
Label_10_7101:
	ld a, $06 ; $7101
	ld bc, $2180 ; $7103
	ld de, $3200 ; $7106
	farcall FarPtr_ScriptSetActorPosition ; $7109
	sound $97 ; $710c
	push af ; $710e
	ld a, $50 ; $710f
	farcall FarPtr_WaitScriptFrames ; $7111
	pop af ; $7114
	ld a, $06 ; $7115
	ld bc, $3f00 ; $7117
	ld de, $3f00 ; $711a
	farcall FarPtr_ScriptSetActorPosition ; $711d
Label_10_7120:
	ld a, $03 ; $7120
	ld b, $40 ; $7122
	farcall FarPtr_SetActorFacing ; $7124
	push af ; $7127
	ld a, $01 ; $7128
	farcall FarPtr_WaitScriptFrames ; $712a
	pop af ; $712d
	call Func_10_73ee ; $712e
	push af ; $7131
	ld a, $1e ; $7132
	farcall FarPtr_WaitScriptFrames ; $7134
	pop af ; $7137
	ld a, $03 ; $7138
	ld d, $03 ; $713a
	farcall FarPtr_ScriptSetActorAnimation ; $713c
	ld a, $03 ; $713f
	farcall FarPtr_ScriptWaitActorIdle ; $7141
	ld a, $03 ; $7144
	farcall FarPtr_ScriptShowSpeakerDialogue ; $7146
	ld a, $03 ; $7149
	ld bc, $0010 ; $714b
	farcall FarPtr_0a_18 ; $714e
	ld a, $03 ; $7151
	ld bc, $2200 ; $7153
	ld de, $3000 ; $7156
	farcall FarPtr_ScriptSetActorMoveTarget ; $7159
	ld a, $03 ; $715c
	farcall FarPtr_ScriptWaitActorMoveDone ; $715e
	push af ; $7161
	ld a, $28 ; $7162
	farcall FarPtr_WaitScriptFrames ; $7164
	pop af ; $7167
	ld a, $03 ; $7168
	ld d, $03 ; $716a
	farcall FarPtr_ScriptSetActorAnimation ; $716c
	ld a, $03 ; $716f
	farcall FarPtr_ScriptWaitActorIdle ; $7171
	ld a, $03 ; $7174
	ld d, $03 ; $7176
	farcall FarPtr_ScriptSetActorAnimation ; $7178
	ld a, $03 ; $717b
	farcall FarPtr_ScriptWaitActorIdle ; $717d
	ld a, $03 ; $7180
	ld bc, $2000 ; $7182
	ld de, $3000 ; $7185
	farcall FarPtr_ScriptSetActorMoveTarget ; $7188
	ld a, $03 ; $718b
	farcall FarPtr_ScriptWaitActorMoveDone ; $718d
	ld a, $03 ; $7190
	ld b, $40 ; $7192
	farcall FarPtr_SetActorFacing ; $7194
	push af ; $7197
	ld a, $0a ; $7198
	farcall FarPtr_WaitScriptFrames ; $719a
	pop af ; $719d
	ld a, $03 ; $719e
	farcall FarPtr_ScriptShowSpeakerDialogue ; $71a0
	ld a, $00 ; $71a3
	ld d, $02 ; $71a5
	farcall FarPtr_ScriptSetActorAnimation ; $71a7
	ld a, $00 ; $71aa
	farcall FarPtr_ScriptWaitActorIdle ; $71ac
	ld a, $03 ; $71af
	ld d, $03 ; $71b1
	farcall FarPtr_ScriptSetActorAnimation ; $71b3
	ld a, $03 ; $71b6
	farcall FarPtr_ScriptWaitActorIdle ; $71b8
Label_10_71bb:
	ld a, $03 ; $71bb
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $71bd
	farcall FarPtr_RunDialogueYesNoPrompt ; $71c0
	farcall FarPtr_ScriptCloseDialogueWindow ; $71c3
	push af ; $71c6
	ld a, $05 ; $71c7
	farcall FarPtr_WaitScriptFrames ; $71c9
	pop af ; $71cc
	and a, a ; $71cd
	jr z, Label_10_71f0 ; $71ce
	ld a, $00 ; $71d0
	ld d, $04 ; $71d2
	farcall FarPtr_ScriptSetActorAnimation ; $71d4
	ld a, $00 ; $71d7
	farcall FarPtr_ScriptWaitActorIdle ; $71d9
	ld a, $03 ; $71dc
	ld d, $02 ; $71de
	farcall FarPtr_ScriptSetActorAnimation ; $71e0
	ld a, $03 ; $71e3
	farcall FarPtr_ScriptWaitActorIdle ; $71e5
	ld hl, $01ff ; $71e8
	farcall FarPtr_InitDialogueTextCursor ; $71eb
	jr Label_10_71bb ; $71ee
Label_10_71f0:
	test_flag $05, 7 ; $71f0
	jp z, Label_10_72a9 ; $71f3
	ld a, $00 ; $71f6
	ld d, $03 ; $71f8
	farcall FarPtr_ScriptSetActorAnimation ; $71fa
	ld a, $00 ; $71fd
	farcall FarPtr_ScriptWaitActorIdle ; $71ff
	ld a, $03 ; $7202
	ld d, $03 ; $7204
	farcall FarPtr_ScriptSetActorAnimation ; $7206
	ld a, $03 ; $7209
	farcall FarPtr_ScriptWaitActorIdle ; $720b
	ld hl, $0200 ; $720e
	farcall FarPtr_InitDialogueTextCursor ; $7211
	ld a, $03 ; $7214
	farcall FarPtr_ScriptShowSpeakerDialogue ; $7216
	ld a, $00 ; $7219
	ld d, $03 ; $721b
	farcall FarPtr_ScriptSetActorAnimation ; $721d
	ld a, $02 ; $7220
	ld d, $03 ; $7222
	farcall FarPtr_ScriptSetActorAnimation ; $7224
	ld a, $02 ; $7227
	farcall FarPtr_ScriptWaitActorIdle ; $7229
	push af ; $722c
	ld a, $0a ; $722d
	farcall FarPtr_WaitScriptFrames ; $722f
	pop af ; $7232
	ld a, $02 ; $7233
	ld b, a ; $7235
	ld a, $00 ; $7236
	farcall FarPtr_FaceActorsTowardEachOther ; $7238
	push af ; $723b
	ld a, $1e ; $723c
	farcall FarPtr_WaitScriptFrames ; $723e
	pop af ; $7241
	ld a, $00 ; $7242
	ld d, $03 ; $7244
	farcall FarPtr_ScriptSetActorAnimation ; $7246
	ld a, $02 ; $7249
	ld d, $03 ; $724b
	farcall FarPtr_ScriptSetActorAnimation ; $724d
	ld a, $02 ; $7250
	farcall FarPtr_ScriptWaitActorIdle ; $7252
	ld a, $02 ; $7255
	ld b, $40 ; $7257
	farcall FarPtr_SetActorFacing ; $7259
	ld a, $00 ; $725c
	ld bc, $2100 ; $725e
	ld de, $3600 ; $7261
	farcall FarPtr_ScriptSetActorMoveTarget ; $7264
	ld a, $00 ; $7267
	farcall FarPtr_ScriptWaitActorMoveDone ; $7269
	ld a, $00 ; $726c
	ld bc, $2100 ; $726e
	ld de, $3700 ; $7271
	farcall FarPtr_ScriptSetActorMoveTarget ; $7274
	ld a, $02 ; $7277
	ld bc, $2100 ; $7279
	ld de, $3500 ; $727c
	farcall FarPtr_ScriptSetActorMoveTarget ; $727f
	ld a, $02 ; $7282
	farcall FarPtr_ScriptWaitActorMoveDone ; $7284
	call Func_10_7339 ; $7287
	ldh a, [hRomBank] ; $728a
	ld b, a ; $728c
	ld a, $00 ; $728d
	ld de, $741c ; $728f
	farcall FarPtr_0a_1a ; $7292
	ldh a, [hRomBank] ; $7295
	ld b, a ; $7297
	ld a, $02 ; $7298
	ld de, $741c ; $729a
	farcall FarPtr_0a_1a ; $729d
	push af ; $72a0
	ld a, $28 ; $72a1
	farcall FarPtr_WaitScriptFrames ; $72a3
	pop af ; $72a6
	jr Label_10_7314 ; $72a7
Label_10_72a9:
	ld a, $00 ; $72a9
	ld d, $03 ; $72ab
	farcall FarPtr_ScriptSetActorAnimation ; $72ad
	ld a, $00 ; $72b0
	farcall FarPtr_ScriptWaitActorIdle ; $72b2
	ld a, $03 ; $72b5
	ld d, $03 ; $72b7
	farcall FarPtr_ScriptSetActorAnimation ; $72b9
	ld a, $03 ; $72bc
	farcall FarPtr_ScriptWaitActorIdle ; $72be
	ld hl, $0200 ; $72c1
	farcall FarPtr_InitDialogueTextCursor ; $72c4
	ld a, $03 ; $72c7
	farcall FarPtr_ScriptShowSpeakerDialogue ; $72c9
	ld a, $00 ; $72cc
	ld d, $03 ; $72ce
	farcall FarPtr_ScriptSetActorAnimation ; $72d0
	ld a, $00 ; $72d3
	farcall FarPtr_ScriptWaitActorIdle ; $72d5
	push af ; $72d8
	ld a, $1e ; $72d9
	farcall FarPtr_WaitScriptFrames ; $72db
	pop af ; $72de
	ld a, $00 ; $72df
	ld bc, $2100 ; $72e1
	ld de, $3400 ; $72e4
	farcall FarPtr_ScriptSetActorMoveTarget ; $72e7
	ld a, $00 ; $72ea
	farcall FarPtr_ScriptWaitActorMoveDone ; $72ec
	ld a, $00 ; $72ef
	ld bc, $2100 ; $72f1
	ld de, $3700 ; $72f4
	farcall FarPtr_ScriptSetActorMoveTarget ; $72f7
	ld a, $00 ; $72fa
	farcall FarPtr_ScriptWaitActorMoveDone ; $72fc
	call Func_10_7339 ; $72ff
	ldh a, [hRomBank] ; $7302
	ld b, a ; $7304
	ld a, $00 ; $7305
	ld de, $741c ; $7307
	farcall FarPtr_0a_1a ; $730a
	push af ; $730d
	ld a, $14 ; $730e
	farcall FarPtr_WaitScriptFrames ; $7310
	pop af ; $7313
Label_10_7314:
	call Func_10_736f ; $7314
	push af ; $7317
	ld a, $3c ; $7318
	farcall FarPtr_WaitScriptFrames ; $731a
	pop af ; $731d
	ld c, $02 ; $731e
	call BeginFadeOut ; $7320
	call WaitFadeEnd ; $7323
	ld a, $14 ; $7326
	ld [wStoryModeCurrentLocation], a ; $7328
	ld a, $0c ; $732b
	ld [$c295], a ; $732d
	ld a, $ff ; $7330
	ld [$c294], a ; $7332
	ld [$c2a1], a ; $7335
	ret ; $7338
Func_10_7339:
	push af ; $7339
	ld a, $0a ; $733a
	farcall FarPtr_WaitScriptFrames ; $733c
	pop af ; $733f
	sound $79 ; $7340
	ld b, $07 ; $7342
	ld c, $38 ; $7344
	ld d, $20 ; $7346
	ld e, $38 ; $7348
	ld h, $02 ; $734a
	ld l, $02 ; $734c
	farcall FarPtr_0a_7e ; $734e
	push af ; $7351
	ld a, $02 ; $7352
	farcall FarPtr_WaitScriptFrames ; $7354
	pop af ; $7357
	ld b, $0b ; $7358
	ld c, $38 ; $735a
	ld d, $20 ; $735c
	ld e, $38 ; $735e
	ld h, $02 ; $7360
	ld l, $02 ; $7362
	farcall FarPtr_0a_7e ; $7364
	push af ; $7367
	ld a, $04 ; $7368
	farcall FarPtr_WaitScriptFrames ; $736a
	pop af ; $736d
	ret ; $736e
Func_10_736f:
	sound $79 ; $736f
	ld b, $07 ; $7371
	ld c, $38 ; $7373
	ld d, $20 ; $7375
	ld e, $38 ; $7377
	ld h, $02 ; $7379
	ld l, $02 ; $737b
	farcall FarPtr_0a_7e ; $737d
	push af ; $7380
	ld a, $02 ; $7381
	farcall FarPtr_WaitScriptFrames ; $7383
	pop af ; $7386
	ld b, $03 ; $7387
	ld c, $38 ; $7389
	ld d, $20 ; $738b
	ld e, $38 ; $738d
	ld h, $02 ; $738f
	ld l, $02 ; $7391
	farcall FarPtr_0a_7e ; $7393
	push af ; $7396
	ld a, $04 ; $7397
	farcall FarPtr_WaitScriptFrames ; $7399
	pop af ; $739c
	ret ; $739d
	; $739e, 80 bytes (bytes:14)
	db $00, $00, $d1, $7b, $00, $20, $00, $30, $40, $00, $63, $01, $00, $00 ; 0x00
	db $00, $00, $d1, $7b, $00, $27, $40, $32, $40, $00, $74, $01, $00, $00 ; 0x0e
	db $00, $00, $d1, $7b, $00, $27, $c0, $30, $40, $00, $74, $01, $00, $00 ; 0x1c
	db $00, $00, $d1, $7b, $00, $fd, $00, $01, $40, $00, $4c, $01, $00, $00 ; 0x2a
	db $00, $00, $d1, $7b, $00, $fd, $00, $01, $40, $00, $4c, $01, $00, $00 ; 0x38
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $ff ; 0x46
Func_10_73ee:
	test_flag $05, 7 ; $73ee
	jr z, Label_10_73fc ; $73f1
	farcall FarPtr_AdvanceDialogueTextCursor ; $73f3
	ld a, $03 ; $73f6
	farcall FarPtr_ScriptShowSpeakerDialogue ; $73f8
	ret ; $73fb
Label_10_73fc:
	ld a, $03 ; $73fc
	farcall FarPtr_ScriptShowSpeakerDialogue ; $73fe
	farcall FarPtr_AdvanceDialogueTextCursor ; $7401
	ret ; $7404
Func_10_7405:
	test_flag $05, 7 ; $7405
	jr z, Label_10_7413 ; $7408
	farcall FarPtr_AdvanceDialogueTextCursor ; $740a
	ld a, $03 ; $740d
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $740f
	ret ; $7412
Label_10_7413:
	ld a, $03 ; $7413
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $7415
	farcall FarPtr_AdvanceDialogueTextCursor ; $7418
	ret ; $741b
	inc b ; $741c
	nop ; $741d
	ld hl, $3b00 ; $741e
	ld [bc], a ; $7421
	inc b ; $7422
	nop ; $7423
	dec [hl] ; $7424
	nop ; $7425
	dec sp ; $7426
	ld [bc], a ; $7427
	nop ; $7428
Func_10_7429:
	ld a, [$c2b0] ; $7429
	cp a, $03 ; $742c
	jr nz, Label_10_7442 ; $742e
	ld a, $11 ; $7430
	ld d, $20 ; $7432
	ld e, $3a ; $7434
	farcall FarPtr_0a_8a ; $7436
	ld a, $21 ; $7439
	ld d, $20 ; $743b
	ld e, $36 ; $743d
	farcall FarPtr_0a_8a ; $743f
Label_10_7442:
	ret ; $7442
Func_10_7443:
	ld a, $04 ; $7443
	ld d, $06 ; $7445
	farcall FarPtr_ScriptSetActorAnimation ; $7447
	test_flag $05, 7 ; $744a
	jr z, Label_10_7461 ; $744d
	test_flag $07, 4 ; $744f
	jr nz, Label_10_7471 ; $7452
	ld a, $04 ; $7454
	ld bc, $0100 ; $7456
	ld de, $0100 ; $7459
	farcall FarPtr_ScriptSetActorPosition ; $745c
	jr Label_10_7471 ; $745f
Label_10_7461:
	test_flag $06, 5 ; $7461
	jr nz, Label_10_7471 ; $7464
	ld a, $05 ; $7466
	ld bc, $0100 ; $7468
	ld de, $0100 ; $746b
	farcall FarPtr_ScriptSetActorPosition ; $746e
Label_10_7471:
	ret ; $7471
Func_10_7472:
	ld a, $00 ; $7472
	test_flag $05, 7 ; $7474
	jr z, Label_10_7490 ; $7477
	test_flag $08, 6 ; $7479
	jr z, Label_10_74a5 ; $747c
	ld a, $01 ; $747e
	test_flag $15, 7 ; $7480
	jr z, Label_10_74a5 ; $7483
	ld a, $02 ; $7485
	test_flag $16, 1 ; $7487
	jr z, Label_10_74a5 ; $748a
	ld a, $03 ; $748c
	jr Label_10_74a5 ; $748e
Label_10_7490:
	test_flag $0a, 7 ; $7490
	jr z, Label_10_74a5 ; $7493
	ld a, $01 ; $7495
	test_flag $15, 6 ; $7497
	jr z, Label_10_74a5 ; $749a
	ld a, $02 ; $749c
	test_flag $16, 0 ; $749e
	jr z, Label_10_74a5 ; $74a1
	ld a, $03 ; $74a3
Label_10_74a5:
	ld [$c2b0], a ; $74a5
	ret ; $74a8
Data_10_74a9:
	; $74a9, 14 bytes (records:2)
; 7 records x 2 bytes
	dw $74f9 ; record 0
	dw $75be ; record 1
	dw $74b7 ; record 2
	dw $76f4 ; record 3
	dw $7715 ; record 4
	dw $7716 ; record 5
	dw $7717 ; record 6
	; $74b7, 66 bytes (bytes:14)
	db $00, $00, $d1, $7b, $00, $1d, $80, $17, $40, $00, $3f, $01, $04, $00 ; 0x00
	db $00, $00, $d1, $7b, $80, $0e, $00, $0f, $80, $00, $40, $01, $00, $00 ; 0x0e
	db $00, $00, $d1, $7b, $00, $05, $80, $0f, $40, $00, $3f, $01, $07, $00 ; 0x1c
	db $00, $00, $db, $7b, $00, $28, $00, $1e, $40, $00, $41, $01, $03, $00 ; 0x2a
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $ff ; 0x38
	; $74f9, 197 bytes (bytes:16)
	db $01, $c0, $00, $22, $00, $21, $78, $75, $02, $40, $00, $22, $00, $07, $32, $75 ; 0x00
	db $03, $40, $00, $35, $00, $19, $5f, $7b, $04, $40, $00, $3b, $00, $39, $5f, $7b ; 0x10
	db $0d, $c0, $00, $21, $00, $3b, $00, $00, $0e, $c0, $00, $22, $00, $13, $00, $00 ; 0x20
	db $0f, $c0, $00, $22, $00, $1d, $00, $00, $ff, $fa, $95, $c2, $fe, $ff, $ca, $77 ; 0x30
	db $75, $f7, $e0, $05, $28, $26, $3e, $02, $01, $ff, $00, $df, $18, $0a, $3e, $02 ; 0x40
	db $06, $c0, $11, $00, $02, $df, $2a, $0a, $3e, $02, $df, $20, $0a, $3e, $02, $06 ; 0x50
	db $40, $df, $2e, $0a, $3e, $02, $01, $10, $00, $df, $18, $0a, $3e, $00, $01, $10 ; 0x60
	db $00, $df, $18, $0a, $3e, $00, $06, $40, $11, $00, $02, $df, $2a, $0a, $c9, $fa ; 0x70
	db $95, $c2, $fe, $ff, $ca, $bd, $75, $f7, $e0, $05, $28, $26, $3e, $02, $01, $ff ; 0x80
	db $00, $df, $18, $0a, $3e, $02, $06, $40, $11, $00, $02, $df, $2a, $0a, $3e, $02 ; 0x90
	db $df, $20, $0a, $3e, $02, $06, $c0, $df, $2e, $0a, $3e, $02, $01, $10, $00, $df ; 0xa0
	db $18, $0a, $3e, $00, $01, $10, $00, $df, $18, $0a, $3e, $00, $06, $c0, $11, $00 ; 0xb0
	db $02, $df, $2a, $0a, $c9 ; 0xc0
	; $75be, 41 bytes (records:8)
; 5 records x 8 bytes
	dw $ff01, $0000, $7bf9, $0114 ; record 0
	dw $ff02, $0000, $7bf9, $0307 ; record 1
	dw $ff03, $0000, $7ae6, $0106 ; record 2
	dw $ff04, $0000, $7b1f, $0305 ; record 3
	dw $ff0f, $0000, $7bf9, $0f07 ; record 4
	db $ff
	ld a, [$c2b0] ; $75e7
	sra a ; $75ea
	add a, a ; $75ec
	add a, $27 ; $75ed
	ld l, a ; $75ef
	adc a, $76 ; $75f0
	sub a, l ; $75f2
	ld h, a ; $75f3
	ld a, [hl+] ; $75f4
	ld h, [hl] ; $75f5
	ld l, a ; $75f6
	farcall FarPtr_InitDialogueTextCursor ; $75f7
	ld a, [$c2b0] ; $75fa
	sra a ; $75fd
	cp a, $03 ; $75ff
	jr z, Label_10_7609 ; $7601
	ld a, $03 ; $7603
	farcall FarPtr_ScriptShowSpeakerDialogue ; $7605
	ret ; $7608
Label_10_7609:
	ld a, $03 ; $7609
	farcall FarPtr_ScriptShowSpeakerDialogueRestoreBG ; $760b
	farcall FarPtr_RunDialogueYesNoPrompt ; $760e
	farcall FarPtr_ScriptCloseDialogueWindow ; $7611
	push af ; $7614
	ld a, $05 ; $7615
	farcall FarPtr_WaitScriptFrames ; $7617
	pop af ; $761a
	and a, a ; $761b
	jr z, Label_10_7621 ; $761c
	farcall FarPtr_AdvanceDialogueTextCursor ; $761e
Label_10_7621:
	ld a, $03 ; $7621
	farcall FarPtr_ScriptShowSpeakerDialogue ; $7623
	ret ; $7626
	; $7627, 10 bytes (records:2)
; 5 records x 2 bytes
	dw $01b8 ; record 0
	dw $01bb ; record 1
	dw $01be ; record 2
	dw $01c4 ; record 3
	dw $01c9 ; record 4
	ld a, [$c2b0] ; $7631
	sra a ; $7634
	add a, a ; $7636
	add a, $4a ; $7637
	ld l, a ; $7639
	adc a, $76 ; $763a
	sub a, l ; $763c
	ld h, a ; $763d
	ld a, [hl+] ; $763e
	ld h, [hl] ; $763f
	ld l, a ; $7640
	farcall FarPtr_InitDialogueTextCursor ; $7641
	ld a, $04 ; $7644
	farcall FarPtr_ScriptShowSpeakerDialogue ; $7646
	ret ; $7649
	; $764a, 10 bytes (records:2)
; 5 records x 2 bytes
	dw $01b9 ; record 0
	dw $01bc ; record 1
	dw $01bf ; record 2
	dw $01c7 ; record 3
	dw $01ca ; record 4
	ld hl, $01ce ; $7654
	farcall FarPtr_InitDialogueTextCursor ; $7657
	ld a, $05 ; $765a
	farcall FarPtr_ScriptShowSpeakerDialogue ; $765c
	ld a, $05 ; $765f
	ld b, $40 ; $7661
	farcall FarPtr_SetActorFacing ; $7663
	test_flag $05, 7 ; $7666
	jr nz, Label_10_76a2 ; $7669
	ld a, $05 ; $766b
	farcall FarPtr_ScriptShowSpeakerDialogue ; $766d
	ld a, [$c2b0] ; $7670
	sra a ; $7673
	add a, a ; $7675
	add a, $98 ; $7676
	ld l, a ; $7678
	adc a, $76 ; $7679
	sub a, l ; $767b
	ld h, a ; $767c
	ld a, [hl+] ; $767d
	ld h, [hl] ; $767e
	ld l, a ; $767f
	farcall FarPtr_InitDialogueTextCursor ; $7680
Label_10_7683:
	push af ; $7683
	ld a, $14 ; $7684
	farcall FarPtr_WaitScriptFrames ; $7686
	pop af ; $7689
	ld a, $00 ; $768a
	ld b, a ; $768c
	ld a, $05 ; $768d
	farcall FarPtr_FaceActorTowardActor ; $768f
	ld a, $05 ; $7692
	farcall FarPtr_ScriptShowSpeakerDialogue ; $7694
	ret ; $7697
	; $7698, 10 bytes (records:2)
; 5 records x 2 bytes
	dw $01d0 ; record 0
	dw $01d1 ; record 1
	dw $01d2 ; record 2
	dw $01d3 ; record 3
	dw $01d4 ; record 4
Label_10_76a2:
	ld hl, $01d5 ; $76a2
	farcall FarPtr_InitDialogueTextCursor ; $76a5
	push af ; $76a8
	ld a, $14 ; $76a9
	farcall FarPtr_WaitScriptFrames ; $76ab
	pop af ; $76ae
	ld a, $05 ; $76af
	farcall FarPtr_ScriptShowSpeakerDialogue ; $76b1
	call Func_10_7bb6 ; $76b4
	add a, a ; $76b7
	add a, $c7 ; $76b8
	ld l, a ; $76ba
	adc a, $76 ; $76bb
	sub a, l ; $76bd
	ld h, a ; $76be
	ld a, [hl+] ; $76bf
	ld h, [hl] ; $76c0
	ld l, a ; $76c1
	farcall FarPtr_InitDialogueTextCursor ; $76c2
	jr Label_10_7683 ; $76c5
	; $76c7, 10 bytes (records:2)
; 5 records x 2 bytes
	dw $01d6 ; record 0
	dw $01d7 ; record 1
	dw $01d8 ; record 2
	dw $01d9 ; record 3
	dw $01da ; record 4
	ld a, [$c2b0] ; $76d1
	sra a ; $76d4
	add a, a ; $76d6
	add a, $ea ; $76d7
	ld l, a ; $76d9
	adc a, $76 ; $76da
	sub a, l ; $76dc
	ld h, a ; $76dd
	ld a, [hl+] ; $76de
	ld h, [hl] ; $76df
	ld l, a ; $76e0
	farcall FarPtr_InitDialogueTextCursor ; $76e1
	ld a, $06 ; $76e4
	farcall FarPtr_ScriptShowSpeakerDialogue ; $76e6
	ret ; $76e9
	; $76ea, 10 bytes (records:2)
; 5 records x 2 bytes
	dw $01ba ; record 0
	dw $01bd ; record 1
	dw $01c0 ; record 2
	dw $01c8 ; record 3
	dw $01cb ; record 4
	; $76f4, 35 bytes (records:8)
; 4 records x 8 bytes
	dw $ff03, $0000, $75e7, $0013 ; record 0
	dw $ff04, $0000, $7631, $0003 ; record 1
	dw $ff05, $0000, $7654, $0003 ; record 2
	dw $ff06, $0000, $76d1, $0013 ; record 3
	db $ff, $ff, $ff
	call Func_10_7dbd ; $7717
	ld a, [$c2b0] ; $771a
	sra a ; $771d
	cp a, $02 ; $771f
	jr nz, Label_10_772e ; $7721
	ldh a, [hRomBank] ; $7723
	ld b, a ; $7725
	ld a, $03 ; $7726
	ld de, $7b8b ; $7728
	farcall FarPtr_0a_1a ; $772b
Label_10_772e:
	ld a, $01 ; $772e
	ld hl, $79d0 ; $7730
	call RegisterFrameTask ; $7733
	ld a, [$c295] ; $7736
	cp a, $0f ; $7739
	jr nz, Label_10_7740 ; $773b
	call Func_10_7741 ; $773d
Label_10_7740:
	ret ; $7740
Func_10_7741:
	ldh a, [hRomBank] ; $7741
	ld hl, $7980 ; $7743
	farcall FarPtr_0a_06 ; $7746
	farcall FarPtr_0a_00 ; $7749
	ld a, $00 ; $774c
	ld bc, $2200 ; $774e
	ld de, $2580 ; $7751
	farcall FarPtr_ScriptSetActorPosition ; $7754
	ld a, $03 ; $7757
	ld bc, $2200 ; $7759
	ld de, $2400 ; $775c
	farcall FarPtr_ScriptSetActorPosition ; $775f
	ld c, $04 ; $7762
	call BeginFadeIn ; $7764
	push af ; $7767
	ld a, $1e ; $7768
	farcall FarPtr_WaitScriptFrames ; $776a
	pop af ; $776d
	ld a, $03 ; $776e
	ld b, $c0 ; $7770
	farcall FarPtr_SetActorFacing ; $7772
	push af ; $7775
	ld a, $0a ; $7776
	farcall FarPtr_WaitScriptFrames ; $7778
	pop af ; $777b
	ld a, $04 ; $777c
	ld d, $02 ; $777e
	farcall FarPtr_ScriptSetActorAnimation ; $7780
	push af ; $7783
	ld a, $1e ; $7784
	farcall FarPtr_WaitScriptFrames ; $7786
	pop af ; $7789
	ld a, $03 ; $778a
	ld bc, $2200 ; $778c
	ld de, $1700 ; $778f
	farcall FarPtr_ScriptSetActorMoveTarget ; $7792
	xor a, a ; $7795
	ld bc, $2200 ; $7796
	ld de, $1700 ; $7799
	farcall FarPtr_MovePlayerToPosition ; $779c
	push af ; $779f
	ld a, $0a ; $77a0
	farcall FarPtr_WaitScriptFrames ; $77a2
	pop af ; $77a5
	ld a, $00 ; $77a6
	ld bc, $2200 ; $77a8
	ld de, $1900 ; $77ab
	farcall FarPtr_ScriptSetActorMoveTarget ; $77ae
	ld a, $04 ; $77b1
	ld b, $00 ; $77b3
	farcall FarPtr_SetActorFacing ; $77b5
	farcall FarPtr_WaitPlayerMoveDone ; $77b8
	ld hl, $01ae ; $77bb
	farcall FarPtr_InitDialogueTextCursor ; $77be
	ld a, $04 ; $77c1
	farcall FarPtr_ScriptShowSpeakerDialogue ; $77c3
	ld a, $03 ; $77c6
	farcall FarPtr_ScriptWaitActorMoveDone ; $77c8
	push af ; $77cb
	ld a, $0a ; $77cc
	farcall FarPtr_WaitScriptFrames ; $77ce
	pop af ; $77d1
	xor a, a ; $77d2
	ld bc, $1d00 ; $77d3
	ld de, $1900 ; $77d6
	farcall FarPtr_MovePlayerToPosition ; $77d9
	ld a, $04 ; $77dc
	ld b, a ; $77de
	ld a, $03 ; $77df
	farcall FarPtr_FaceActorTowardActor ; $77e1
	push af ; $77e4
	ld a, $1e ; $77e5
	farcall FarPtr_WaitScriptFrames ; $77e7
	pop af ; $77ea
	ld a, $04 ; $77eb
	ld b, a ; $77ed
	ld a, $00 ; $77ee
	farcall FarPtr_FaceActorTowardActor ; $77f0
	push af ; $77f3
	ld a, $1e ; $77f4
	farcall FarPtr_WaitScriptFrames ; $77f6
	pop af ; $77f9
	farcall FarPtr_WaitPlayerMoveDone ; $77fa
	ld a, $04 ; $77fd
	ld d, $03 ; $77ff
	farcall FarPtr_ScriptSetActorAnimation ; $7801
	ld a, $04 ; $7804
	farcall FarPtr_ScriptWaitActorIdle ; $7806
	ld a, $04 ; $7809
	farcall FarPtr_ScriptShowSpeakerDialogue ; $780b
	push af ; $780e
	ld a, $0a ; $780f
	farcall FarPtr_WaitScriptFrames ; $7811
	pop af ; $7814
	ld a, $03 ; $7815
	ld d, $03 ; $7817
	farcall FarPtr_ScriptSetActorAnimation ; $7819
	ld a, $03 ; $781c
	farcall FarPtr_ScriptWaitActorIdle ; $781e
	ld a, $03 ; $7821
	farcall FarPtr_ScriptShowSpeakerDialogue ; $7823
	ld a, $00 ; $7826
	ld b, a ; $7828
	ld a, $03 ; $7829
	farcall FarPtr_FaceActorTowardActor ; $782b
	push af ; $782e
	ld a, $32 ; $782f
	farcall FarPtr_WaitScriptFrames ; $7831
	pop af ; $7834
	ld a, $04 ; $7835
	ld b, a ; $7837
	ld a, $03 ; $7838
	farcall FarPtr_FaceActorTowardActor ; $783a
	push af ; $783d
	ld a, $1e ; $783e
	farcall FarPtr_WaitScriptFrames ; $7840
	pop af ; $7843
	ld a, [$c90d] ; $7844
	or a, a ; $7847
	jr z, Label_10_784d ; $7848
	farcall FarPtr_AdvanceDialogueTextCursor ; $784a
Label_10_784d:
	ld a, $03 ; $784d
	farcall FarPtr_ScriptShowSpeakerDialogue ; $784f
	ld a, [$c90d] ; $7852
	or a, a ; $7855
	jr nz, Label_10_785b ; $7856
	farcall FarPtr_AdvanceDialogueTextCursor ; $7858
Label_10_785b:
	push af ; $785b
	ld a, $0f ; $785c
	farcall FarPtr_WaitScriptFrames ; $785e
	pop af ; $7861
	ld a, $04 ; $7862
	ld d, $03 ; $7864
	farcall FarPtr_ScriptSetActorAnimation ; $7866
	ld a, $04 ; $7869
	farcall FarPtr_ScriptWaitActorIdle ; $786b
	ld a, $04 ; $786e
	farcall FarPtr_ScriptShowSpeakerDialogue ; $7870
	push af ; $7873
	ld a, $0f ; $7874
	farcall FarPtr_WaitScriptFrames ; $7876
	pop af ; $7879
	ld a, $00 ; $787a
	ld d, $03 ; $787c
	farcall FarPtr_ScriptSetActorAnimation ; $787e
	ld a, $00 ; $7881
	farcall FarPtr_ScriptWaitActorIdle ; $7883
	push af ; $7886
	ld a, $0f ; $7887
	farcall FarPtr_WaitScriptFrames ; $7889
	pop af ; $788c
	ld a, $04 ; $788d
	ld d, $03 ; $788f
	farcall FarPtr_ScriptSetActorAnimation ; $7891
	ld a, $04 ; $7894
	farcall FarPtr_ScriptWaitActorIdle ; $7896
	ld a, $04 ; $7899
	farcall FarPtr_ScriptShowSpeakerDialogue ; $789b
	push af ; $789e
	ld a, $0f ; $789f
	farcall FarPtr_WaitScriptFrames ; $78a1
	pop af ; $78a4
	ld a, $03 ; $78a5
	ld d, $02 ; $78a7
	farcall FarPtr_ScriptSetActorAnimation ; $78a9
	ld a, $03 ; $78ac
	farcall FarPtr_ScriptWaitActorIdle ; $78ae
	ld a, $03 ; $78b1
	farcall FarPtr_ScriptShowSpeakerDialogue ; $78b3
	ld a, $03 ; $78b6
	ld b, a ; $78b8
	ld a, $00 ; $78b9
	farcall FarPtr_FaceActorTowardActor ; $78bb
	ld a, $06 ; $78be
	ld bc, $2300 ; $78c0
	ld de, $1700 ; $78c3
	farcall FarPtr_ScriptSetActorPosition ; $78c6
	sound $98 ; $78c9
	push af ; $78cb
	ld a, $3c ; $78cc
	farcall FarPtr_WaitScriptFrames ; $78ce
	pop af ; $78d1
	ld a, $06 ; $78d2
	ld bc, $3f00 ; $78d4
	ld de, $3f00 ; $78d7
	farcall FarPtr_ScriptSetActorPosition ; $78da
	ld a, $04 ; $78dd
	ld d, $03 ; $78df
	farcall FarPtr_ScriptSetActorAnimation ; $78e1
	ld a, $04 ; $78e4
	farcall FarPtr_ScriptWaitActorIdle ; $78e6
	ld a, $04 ; $78e9
	farcall FarPtr_ScriptShowSpeakerDialogue ; $78eb
	ld a, $00 ; $78ee
	ld d, $02 ; $78f0
	farcall FarPtr_ScriptSetActorAnimation ; $78f2
	ld a, $00 ; $78f5
	farcall FarPtr_ScriptWaitActorIdle ; $78f7
	push af ; $78fa
	ld a, $0a ; $78fb
	farcall FarPtr_WaitScriptFrames ; $78fd
	pop af ; $7900
	ld a, $04 ; $7901
	ld b, a ; $7903
	ld a, $00 ; $7904
	farcall FarPtr_FaceActorTowardActor ; $7906
	ld a, $00 ; $7909
	ld d, $03 ; $790b
	farcall FarPtr_ScriptSetActorAnimation ; $790d
	ld a, $00 ; $7910
	farcall FarPtr_ScriptWaitActorIdle ; $7912
	push af ; $7915
	ld a, $0f ; $7916
	farcall FarPtr_WaitScriptFrames ; $7918
	pop af ; $791b
	ld a, $04 ; $791c
	ld b, a ; $791e
	ld a, $03 ; $791f
	farcall FarPtr_FaceActorsTowardEachOther ; $7921
	ld a, $03 ; $7924
	ld d, $03 ; $7926
	farcall FarPtr_ScriptSetActorAnimation ; $7928
	ld a, $04 ; $792b
	ld d, $03 ; $792d
	farcall FarPtr_ScriptSetActorAnimation ; $792f
	ld a, $04 ; $7932
	farcall FarPtr_ScriptWaitActorIdle ; $7934
	xor a, a ; $7937
	ld bc, $2200 ; $7938
	ld de, $1700 ; $793b
	farcall FarPtr_MovePlayerToPosition ; $793e
	push af ; $7941
	ld a, $28 ; $7942
	farcall FarPtr_WaitScriptFrames ; $7944
	pop af ; $7947
	ld a, $03 ; $7948
	ld bc, $2200 ; $794a
	ld de, $0300 ; $794d
	farcall FarPtr_ScriptSetActorMoveTarget ; $7950
	push af ; $7953
	ld a, $0a ; $7954
	farcall FarPtr_WaitScriptFrames ; $7956
	pop af ; $7959
	xor a, a ; $795a
	ld bc, $2200 ; $795b
	ld de, $0300 ; $795e
	farcall FarPtr_MovePlayerToPosition ; $7961
	ld a, $00 ; $7964
	ld bc, $2200 ; $7966
	ld de, $0300 ; $7969
	farcall FarPtr_ScriptSetActorMoveTarget ; $796c
	ld a, $00 ; $796f
	farcall FarPtr_ScriptWaitActorMoveDone ; $7971
	ld a, $0f ; $7974
	ld [$c294], a ; $7976
	ld [$c2a1], a ; $7979
	farcall FarPtr_0a_02 ; $797c
	ret ; $797f
	; $7980, 80 bytes (bytes:14)
	db $00, $00, $d1, $7b, $00, $2b, $00, $0b, $40, $00, $49, $01, $00, $00 ; 0x00
	db $00, $00, $d1, $7b, $00, $1d, $00, $17, $40, $00, $3f, $01, $04, $00 ; 0x0e
	db $00, $00, $d1, $7b, $00, $fd, $00, $01, $40, $00, $4c, $01, $00, $00 ; 0x1c
	db $00, $00, $d1, $7b, $00, $fd, $00, $01, $40, $00, $4d, $01, $00, $00 ; 0x2a
	db $00, $00, $d1, $7b, $00, $fd, $00, $01, $40, $00, $4f, $01, $00, $00 ; 0x38
	db $00, $00, $00, $00, $00, $00, $00, $00, $00, $ff ; 0x46
	ld a, $00 ; $79d0
	call Func_10_79df ; $79d2
	test_flag $05, 7 ; $79d5
	ret z ; $79d8
	ld a, $02 ; $79d9
	call Func_10_79df ; $79db
	ret ; $79de
Func_10_79df:
	ld h, a ; $79df
	ld l, $00 ; $79e0
	push af ; $79e2
	wram_bank $04 ; $79e3
	srl h ; $79e9
	rr l ; $79eb
	srl h ; $79ed
	rr l ; $79ef
	ld bc, $d000 ; $79f1
	add hl, bc ; $79f4
	ld b, h ; $79f5
	ld c, l ; $79f6
	ld hl, $000c ; $79f7
	add hl, bc ; $79fa
	ld a, [hl+] ; $79fb
	ld h, [hl] ; $79fc
	ld l, a ; $79fd
	ld de, $ffb0 ; $79fe
	add hl, de ; $7a01
	ld d, h ; $7a02
	ld hl, $000e ; $7a03
	add hl, bc ; $7a06
	ld a, [hl+] ; $7a07
	add a, $40 ; $7a08
	ld a, [hl] ; $7a0a
	adc a, $00 ; $7a0b
	ld e, a ; $7a0d
	dec e ; $7a0e
	pop af ; $7a0f
	or a, a ; $7a10
	jr z, Label_10_7a15 ; $7a11
	dec e ; $7a13
	dec e ; $7a14
Label_10_7a15:
	push de ; $7a15
	call Func_10_7ac8 ; $7a16
	pop de ; $7a19
	and a, $87 ; $7a1a
	cp a, $06 ; $7a1c
	jr nz, Label_10_7a2f ; $7a1e
	wram_bank $04 ; $7a20
	ld hl, $0020 ; $7a26
	add hl, bc ; $7a29
	ld a, [hl] ; $7a2a
	xor a, $01 ; $7a2b
	ld [hl], a ; $7a2d
	ret ; $7a2e
Label_10_7a2f:
	inc d ; $7a2f
	call Func_10_7ac8 ; $7a30
	and a, $07 ; $7a33
	cp a, $06 ; $7a35
	jr nz, Label_10_7a48 ; $7a37
	wram_bank $04 ; $7a39
	ld hl, $0020 ; $7a3f
	add hl, bc ; $7a42
	ld a, [hl] ; $7a43
	xor a, $01 ; $7a44
	ld [hl], a ; $7a46
	ret ; $7a47
Label_10_7a48:
	wram_bank $04 ; $7a48
	ld hl, $0020 ; $7a4e
	add hl, bc ; $7a51
	ld a, $02 ; $7a52
	ld [hl], a ; $7a54
	ret ; $7a55
	ld h, a ; $7a56
	ld l, $00 ; $7a57
	wram_bank $04 ; $7a59
	srl h ; $7a5f
	rr l ; $7a61
	srl h ; $7a63
	rr l ; $7a65
	ld bc, $d000 ; $7a67
	add hl, bc ; $7a6a
	ld b, h ; $7a6b
	ld c, l ; $7a6c
	ld hl, $000c ; $7a6d
	add hl, bc ; $7a70
	ld a, [hl+] ; $7a71
	ld h, [hl] ; $7a72
	ld l, a ; $7a73
	ld de, $ffb0 ; $7a74
	add hl, de ; $7a77
	ld d, h ; $7a78
	ld hl, $000e ; $7a79
	add hl, bc ; $7a7c
	ld a, [hl+] ; $7a7d
	add a, $40 ; $7a7e
	ld a, [hl] ; $7a80
	adc a, $00 ; $7a81
	ld e, a ; $7a83
	dec e ; $7a84
	dec e ; $7a85
	dec e ; $7a86
	push de ; $7a87
	call Func_10_7ac8 ; $7a88
	pop de ; $7a8b
	and a, $87 ; $7a8c
	cp a, $06 ; $7a8e
	jr nz, Label_10_7aa1 ; $7a90
	wram_bank $04 ; $7a92
	ld hl, $0020 ; $7a98
	add hl, bc ; $7a9b
	ld a, [hl] ; $7a9c
	xor a, $01 ; $7a9d
	ld [hl], a ; $7a9f
	ret ; $7aa0
Label_10_7aa1:
	inc d ; $7aa1
	call Func_10_7ac8 ; $7aa2
	and a, $07 ; $7aa5
	cp a, $06 ; $7aa7
	jr nz, Label_10_7aba ; $7aa9
	wram_bank $04 ; $7aab
	ld hl, $0020 ; $7ab1
	add hl, bc ; $7ab4
	ld a, [hl] ; $7ab5
	xor a, $01 ; $7ab6
	ld [hl], a ; $7ab8
	ret ; $7ab9
Label_10_7aba:
	wram_bank $04 ; $7aba
	ld hl, $0020 ; $7ac0
	add hl, bc ; $7ac3
	ld a, $02 ; $7ac4
	ld [hl], a ; $7ac6
	ret ; $7ac7
Func_10_7ac8:
	wram_bank $02 ; $7ac8
	ld h, e ; $7ace
	ld l, $00 ; $7acf
	srl h ; $7ad1
	rr l ; $7ad3
	srl h ; $7ad5
	rr l ; $7ad7
	ld a, d ; $7ad9
	add a, l ; $7ada
	ld l, a ; $7adb
	jr nc, Label_10_7adf ; $7adc
	inc h ; $7ade
Label_10_7adf:
	ld d, h ; $7adf
	ld e, l ; $7ae0
	ld l, c ; $7ae1
	ld h, b ; $7ae2
	add hl, de ; $7ae3
	ld a, [hl] ; $7ae4
	ret ; $7ae5
	ld a, $00 ; $7ae6
	ld bc, $0010 ; $7ae8
	farcall FarPtr_0a_18 ; $7aeb
	ld a, $02 ; $7aee
	ld bc, $0010 ; $7af0
	farcall FarPtr_0a_18 ; $7af3
	ld a, $00 ; $7af6
	ld b, $c0 ; $7af8
	ld de, $0100 ; $7afa
	farcall FarPtr_MoveActorByAngle ; $7afd
	ld a, $00 ; $7b00
	farcall FarPtr_ScriptWaitActorMoveDone ; $7b02
	ld a, $00 ; $7b05
	ld b, $e0 ; $7b07
	ld de, $0080 ; $7b09
	farcall FarPtr_MoveActorByAngle ; $7b0c
	ld a, $00 ; $7b0f
	farcall FarPtr_ScriptWaitActorMoveDone ; $7b11
	ld a, $00 ; $7b14
	ld b, $00 ; $7b16
	ld de, $00c0 ; $7b18
	farcall FarPtr_MoveActorByAngle ; $7b1b
	ret ; $7b1e
	ld a, [$c295] ; $7b1f
	cp a, $ff ; $7b22
	jr z, Label_10_7b5e ; $7b24
	ld a, $02 ; $7b26
	ld bc, $0010 ; $7b28
	farcall FarPtr_0a_18 ; $7b2b
	ld a, $00 ; $7b2e
	ld bc, $0010 ; $7b30
	farcall FarPtr_0a_18 ; $7b33
	ld a, $00 ; $7b36
	ld b, $c0 ; $7b38
	ld de, $00c0 ; $7b3a
	farcall FarPtr_MoveActorByAngle ; $7b3d
	ld a, $00 ; $7b40
	farcall FarPtr_ScriptWaitActorMoveDone ; $7b42
	ld a, $00 ; $7b45
	ld b, $a0 ; $7b47
	ld de, $0080 ; $7b49
	farcall FarPtr_MoveActorByAngle ; $7b4c
	ld a, $00 ; $7b4f
	farcall FarPtr_ScriptWaitActorMoveDone ; $7b51
	ld a, $00 ; $7b54
	ld b, $80 ; $7b56
	ld de, $0080 ; $7b58
	farcall FarPtr_MoveActorByAngle ; $7b5b
Label_10_7b5e:
	ret ; $7b5e
Func_10_7b5f:
	ld a, [$c295] ; $7b5f
	cp a, $ff ; $7b62
	jr z, Label_10_7b8a ; $7b64
	ld a, $00 ; $7b66
	ld bc, $0010 ; $7b68
	farcall FarPtr_0a_18 ; $7b6b
	ld a, $02 ; $7b6e
	ld bc, $0010 ; $7b70
	farcall FarPtr_0a_18 ; $7b73
	ld a, $00 ; $7b76
	ld b, $40 ; $7b78
	ld de, $0280 ; $7b7a
	farcall FarPtr_MoveActorByAngle ; $7b7d
	ld a, $02 ; $7b80
	ld b, $40 ; $7b82
	ld de, $0200 ; $7b84
	farcall FarPtr_MoveActorByAngle ; $7b87
Label_10_7b8a:
	ret ; $7b8a
	INCBIN "data/bank_010/d_7b8b.bin" ; $7b8b, 43 bytes
Func_10_7bb6:
	ld a, $00 ; $7bb6
	test_flag $08, 2 ; $7bb8
	jr z, Label_10_7bd0 ; $7bbb
	inc a ; $7bbd
	test_flag $08, 6 ; $7bbe
	jr z, Label_10_7bd0 ; $7bc1
	inc a ; $7bc3
	test_flag $09, 0 ; $7bc4
	jr z, Label_10_7bd0 ; $7bc7
	inc a ; $7bc9
	test_flag $16, 1 ; $7bca
	jr z, Label_10_7bd0 ; $7bcd
	inc a ; $7bcf
Label_10_7bd0:
	ret ; $7bd0
	INCBIN "data/bank_010/d_7bd1.bin" ; $7bd1, 40 bytes
	ret ; $7bf9
	xor a, a ; $7bfa
	ld [$c2da], a ; $7bfb
	ret ; $7bfe
	INCBIN "data/bank_010/d_7bff.bin" ; $7bff, 446 bytes
Func_10_7dbd:
	test_flag $05, 7 ; $7dbd
	jr nz, Label_10_7de4 ; $7dc0
	ld a, $00 ; $7dc2
	test_flag $0a, 3 ; $7dc4
	jr z, Label_10_7de0 ; $7dc7
	ld a, $02 ; $7dc9
	test_flag $0a, 7 ; $7dcb
	jr z, Label_10_7de0 ; $7dce
	ld a, $04 ; $7dd0
	test_flag $15, 6 ; $7dd2
	jr z, Label_10_7de0 ; $7dd5
	ld a, $06 ; $7dd7
	test_flag $16, 0 ; $7dd9
	jr z, Label_10_7de0 ; $7ddc
	ld a, $08 ; $7dde
Label_10_7de0:
	ld [$c2b0], a ; $7de0
	ret ; $7de3
Label_10_7de4:
	ld a, $01 ; $7de4
	test_flag $08, 2 ; $7de6
	jr z, Label_10_7de0 ; $7de9
	ld a, $03 ; $7deb
	test_flag $08, 6 ; $7ded
	jr z, Label_10_7de0 ; $7df0
	ld a, $05 ; $7df2
	test_flag $15, 7 ; $7df4
	jr z, Label_10_7de0 ; $7df7
	ld a, $07 ; $7df9
	test_flag $16, 1 ; $7dfb
	jr z, Label_10_7de0 ; $7dfe
	ld a, $09 ; $7e00
	jr Label_10_7de0 ; $7e02
	ld a, $00 ; $7e04
	test_flag $0a, 3 ; $7e06
	jr z, Label_10_7e23 ; $7e09
	inc a ; $7e0b
	test_flag $0a, 7 ; $7e0c
	jr z, Label_10_7e23 ; $7e0f
	inc a ; $7e11
	test_flag $05, 7 ; $7e12
	jr nz, Label_10_7e27 ; $7e15
	test_flag $15, 6 ; $7e17
	jr z, Label_10_7e23 ; $7e1a
	inc a ; $7e1c
	test_flag $16, 0 ; $7e1d
	jr z, Label_10_7e23 ; $7e20
	inc a ; $7e22
Label_10_7e23:
	ld [$c2b0], a ; $7e23
	ret ; $7e26
Label_10_7e27:
	test_flag $15, 7 ; $7e27
	jr z, Label_10_7e23 ; $7e2a
	inc a ; $7e2c
	test_flag $16, 1 ; $7e2d
	jr z, Label_10_7e23 ; $7e30
	inc a ; $7e32
	jr Label_10_7e23 ; $7e33
	ds 459, $ff ; $7e35, fill
