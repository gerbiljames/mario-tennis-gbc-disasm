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
	call Func_00_1d20 ; $40b5
	call Func_00_1da4 ; $40b8
	ld b, $00 ; $40bb
	farcall FarPtr_38_00 ; $40bd
	ld c, $10 ; $40c0
	call Func_00_1d20 ; $40c2
	call Func_00_1da4 ; $40c5
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
	call Func_00_2725 ; $40f5
	db $3c ; $40f8 inline arg
	call EnableLCD ; $40f9
	farcall FarPtr_03_38 ; $40fc
	ld c, $04 ; $40ff
	call Func_00_1d2e ; $4101
	call Func_00_1da4 ; $4104
	sound $14 ; $4107
	ld a, $01 ; $4109
	ld hl, $4141 ; $410b
	call RegisterFrameTask ; $410e
	call Func_00_2725 ; $4111
	db $78 ; $4114 inline arg
	call Func_00_2725 ; $4115
	db $ff ; $4118 inline arg
	call Func_00_2725 ; $4119
	db $ff ; $411c inline arg
	call Func_00_2725 ; $411d
	db $ff ; $4120 inline arg
	call Func_00_2725 ; $4121
	db $ff ; $4124 inline arg
	call Func_00_2725 ; $4125
	db $ff ; $4128 inline arg
	call Func_00_2725 ; $4129
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
	INCBIN "data/bank_010/d_4141.bin" ; $4141, 4 bytes
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
Func_10_4195:
	ld hl, $0484 ; $4195
	ld de, $0101 ; $4198
	ld a, $05 ; $419b
	farcall FarPtr_05_3e ; $419d
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
Func_10_41da:
	ld hl, $0489 ; $41da
	ld de, $0101 ; $41dd
	ld a, $04 ; $41e0
	farcall FarPtr_05_3e ; $41e2
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
	ld hl, $048d ; $4450
	ld a, $09 ; $4453
	farcall FarPtr_05_3e ; $4455
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
	farcall FarPtr_0a_0e ; $4490
	ld a, $80 ; $4493
	farcall FarPtr_0a_08 ; $4495
	ret ; $4498
	INCBIN "data/bank_010/d_4499.bin" ; $4499, 423 bytes
Label_10_4640:
	ld hl, $0496 ; $4640
	ld a, $03 ; $4643
	farcall FarPtr_05_3e ; $4645
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
	farcall FarPtr_05_3e ; $465a
	cp a, $ff ; $465d
	jp z, Label_10_4640 ; $465f
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
	INCBIN "data/bank_010/d_4684.bin" ; $4684, 9 bytes
Data_10_468d:
	INCBIN "data/bank_010/d_468d.bin" ; $468d, 1598 bytes
Data_10_4ccb:
	INCBIN "data/bank_010/d_4ccb.bin" ; $4ccb, 90 bytes
	farcall FarPtr_0a_20 ; $4d25
	ld a, $07 ; $4d28
	ld bc, $0100 ; $4d2a
	ld de, $0100 ; $4d2d
	farcall FarPtr_0a_24 ; $4d30
	ld a, $07 ; $4d33
	farcall FarPtr_0a_20 ; $4d35
	ld a, $0b ; $4d38
	ld bc, $0100 ; $4d3a
	ld de, $0100 ; $4d3d
	farcall FarPtr_0a_24 ; $4d40
	ld a, $0b ; $4d43
	farcall FarPtr_0a_20 ; $4d45
	ld a, $10 ; $4d48
	ld bc, $0100 ; $4d4a
	ld de, $0100 ; $4d4d
	farcall FarPtr_0a_24 ; $4d50
	ld a, $10 ; $4d53
	farcall FarPtr_0a_20 ; $4d55
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
	call Func_00_1d20 ; $4d72
	call Func_00_1da4 ; $4d75
	ldh a, [hRomBank] ; $4d78
	ld hl, $4cd9 ; $4d7a
	farcall FarPtr_0a_06 ; $4d7d
	ld c, $10 ; $4d80
	call Func_00_1d2e ; $4d82
	call Func_00_1da4 ; $4d85
	ret ; $4d88
	INCBIN "data/bank_010/d_4d89.bin" ; $4d89, 227 bytes
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
	farcall FarPtr_0a_22 ; $4ec1
	call Func_10_4f0d ; $4ec4
	farcall FarPtr_TestStorySlotFlagA ; $4ec7
	call Func_00_2f86 ; $4eca
	ret ; $4ecd
Func_10_4ece:
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
	INCBIN "data/bank_010/d_4f08.bin" ; $4f08, 5 bytes
Func_10_4f0d:
	call ClearFrameTasks ; $4f0d
	sound $00 ; $4f10
	call Func_00_2f32 ; $4f12
	ld a, [$c295] ; $4f15
	cp a, $0a ; $4f18
	jr nz, Label_10_4f3c ; $4f1a
	call ClearFrameTasks ; $4f1c
	sound $00 ; $4f1f
	call Func_00_2f32 ; $4f21
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
	farcall FarPtr_08_00 ; $4f3c
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
	call Func_00_1d20 ; $4f5a
	call Func_00_1da4 ; $4f5d
	call DisableLCDSafely ; $4f60
	ld a, $01 ; $4f63
	ld [$cb11], a ; $4f65
Label_10_4f68:
	call DisableLCDSafely ; $4f68
	farcall FarPtr_01_0a ; $4f6b
	farcall FarPtr_39_22 ; $4f6e
	call EnableLCD ; $4f71
	ld c, $10 ; $4f74
	call Func_00_1d2e ; $4f76
	call Func_00_1da4 ; $4f79
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
	ldh [$ff8b], a ; $4f95
	ldh [$ff8a], a ; $4f97
	ld [$c320], a ; $4f99
	ld [$c321], a ; $4f9c
	ld [$c322], a ; $4f9f
	ld [$c323], a ; $4fa2
	ld a, $03 ; $4fa5
	ld [$cb0c], a ; $4fa7
	call Func_00_2f32 ; $4faa
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
	call Func_00_1d2e ; $5000
	call Func_00_1da4 ; $5003
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
	call Func_00_1d20 ; $5048
	call Func_00_1da4 ; $504b
	ld a, e ; $504e
	ld [$c36c], a ; $504f
	farcall FarPtr_1b_22 ; $5052
	cp a, $ff ; $5055
	jp nz, Label_10_5073 ; $5057
	ld a, $00 ; $505a
	ld [$cb11], a ; $505c
	call DisableLCDSafely ; $505f
	farcall FarPtr_01_0a ; $5062
	farcall FarPtr_39_22 ; $5065
	call EnableLCD ; $5068
	ld c, $10 ; $506b
	call Func_00_1d2e ; $506d
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
	call Func_00_1d2e ; $509e
	call Func_00_1da4 ; $50a1
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
	call Func_00_1d2e ; $5130
	call Func_00_1da4 ; $5133
	pop af ; $5136
Label_10_5137:
	xor a, a ; $5137
	ld [$c8a8], a ; $5138
	ld a, $03 ; $513b
	ld [$c36c], a ; $513d
	farcall FarPtr_InitStoryModeState ; $5140
	farcall FarPtr_08_00 ; $5143
	farcall FarPtr_03_26 ; $5146
Label_10_5149:
	farcall FarPtr_3b_0e ; $5149
	cp a, $ff ; $514c
	jp z, Label_10_4f7c ; $514e
	ld c, $10 ; $5151
	call Func_00_1d20 ; $5153
	call Func_00_1da4 ; $5156
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
	call Func_00_1d2e ; $5187
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
	call Func_00_1d2e ; $51a4
	farcall FarPtr_3e_1c ; $51a7
	cp a, $ff ; $51aa
	jr nz, Label_10_51cd ; $51ac
	ld a, $00 ; $51ae
	ld [$cb11], a ; $51b0
	jp z, Label_10_5159 ; $51b3
Label_10_51b6:
	call EnableLCD ; $51b6
	ld c, $10 ; $51b9
	call Func_00_1d2e ; $51bb
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
	call Func_10_4ece ; $51d8
Label_10_51db:
	ld a, $03 ; $51db
	ld [$c36c], a ; $51dd
	xor a, a ; $51e0
	ld [$c8a5], a ; $51e1
	farcall FarPtr_03_26 ; $51e4
	ld a, $04 ; $51e7
	ld [wGameMode], a ; $51e9
	farcall FarPtr_08_04 ; $51ec
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
	call Func_00_1d2e ; $5210
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
	farcall FarPtr_17_0c ; $524f
	cp a, $ff ; $5252
	jr nz, Label_10_526e ; $5254
	call DisableLCDSafely ; $5256
	farcall FarPtr_01_0a ; $5259
	farcall FarPtr_39_22 ; $525c
	call EnableLCD ; $525f
	ld c, $10 ; $5262
	call Func_00_1d2e ; $5264
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
	call Func_00_1d2e ; $528a
	call Func_00_1da4 ; $528d
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
	farcall FarPtr_08_00 ; $52a8
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
	call Func_00_1d2e ; $52cb
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
	call Func_00_1d20 ; $52f1
	call Func_00_1da4 ; $52f4
	ld a, $00 ; $52f7
	farcall FarPtr_1d_00 ; $52f9
	call DisableLCDSafely ; $52fc
	farcall FarPtr_01_0a ; $52ff
	farcall FarPtr_39_22 ; $5302
	call EnableLCD ; $5305
	ld c, $10 ; $5308
	call Func_00_1d2e ; $530a
	ld a, $00 ; $530d
	ld [$cb11], a ; $530f
	jp Label_10_52e4 ; $5312
Label_10_5315:
	cp a, $01 ; $5315
	jr nz, Label_10_5345 ; $5317
	ld c, $10 ; $5319
	call Func_00_1d20 ; $531b
	call Func_00_1da4 ; $531e
	farcall FarPtr_1e_08 ; $5321
	ld c, $10 ; $5324
	call Func_00_1d20 ; $5326
	call Func_00_1da4 ; $5329
	call DisableLCDSafely ; $532c
	farcall FarPtr_01_0a ; $532f
	farcall FarPtr_39_22 ; $5332
	call EnableLCD ; $5335
	ld c, $10 ; $5338
	call Func_00_1d2e ; $533a
	ld a, $00 ; $533d
	ld [$cb11], a ; $533f
	jp Label_10_52e4 ; $5342
Label_10_5345:
	cp a, $02 ; $5345
	jr nz, Label_10_536d ; $5347
	ld c, $10 ; $5349
	call Func_00_1d20 ; $534b
	call Func_00_1da4 ; $534e
	farcall FarPtr_3b_06 ; $5351
	call DisableLCDSafely ; $5354
	farcall FarPtr_01_0a ; $5357
	farcall FarPtr_39_22 ; $535a
	call EnableLCD ; $535d
	ld c, $10 ; $5360
	call Func_00_1d2e ; $5362
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
	call Func_00_1d20 ; $5382
	call Func_00_1da4 ; $5385
	farcall FarPtr_3e_0c ; $5388
	farcall FarPtr_3e_10 ; $538b
	farcall FarPtr_SaveStorySlot ; $538e
	call DisableLCDSafely ; $5391
	farcall FarPtr_01_0a ; $5394
	farcall FarPtr_39_22 ; $5397
	call EnableLCD ; $539a
	ld c, $10 ; $539d
	call Func_00_1d2e ; $539f
	ld a, $00 ; $53a2
	ld [$cb11], a ; $53a4
	jp Label_10_536d ; $53a7
Label_10_53aa:
	ld c, $10 ; $53aa
	call Func_00_1d20 ; $53ac
	call Func_00_1da4 ; $53af
	farcall FarPtr_3e_0e ; $53b2
	farcall FarPtr_3e_10 ; $53b5
	farcall FarPtr_SaveStorySlot ; $53b8
	call DisableLCDSafely ; $53bb
	farcall FarPtr_01_0a ; $53be
	farcall FarPtr_39_22 ; $53c1
	call EnableLCD ; $53c4
	ld c, $10 ; $53c7
	call Func_00_1d2e ; $53c9
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
	call Func_00_1d20 ; $53e7
	call Func_00_1da4 ; $53ea
	farcall FarPtr_3b_30 ; $53ed
	ld c, $10 ; $53f0
	call Func_00_1d20 ; $53f2
	call Func_00_1da4 ; $53f5
	call DisableLCDSafely ; $53f8
	farcall FarPtr_01_0a ; $53fb
	farcall FarPtr_39_22 ; $53fe
	call EnableLCD ; $5401
	ld c, $10 ; $5404
	call Func_00_1d2e ; $5406
	ld a, $00 ; $5409
	ld [$cb11], a ; $540b
	jp Label_10_53d8 ; $540e
Label_10_5411:
	ld c, $10 ; $5411
	call Func_00_1d20 ; $5413
	call Func_00_1da4 ; $5416
	farcall FarPtr_1b_2c ; $5419
	ld c, $10 ; $541c
	call Func_00_1d20 ; $541e
	call Func_00_1da4 ; $5421
	call DisableLCDSafely ; $5424
	farcall FarPtr_01_0a ; $5427
	farcall FarPtr_39_22 ; $542a
	call EnableLCD ; $542d
	ld c, $10 ; $5430
	call Func_00_1d2e ; $5432
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
	call Func_00_1d20 ; $544a
	call Func_00_1da4 ; $544d
	farcall FarPtr_3b_08 ; $5450
	call DisableLCDSafely ; $5453
	farcall FarPtr_01_0a ; $5456
	farcall FarPtr_39_22 ; $5459
	call EnableLCD ; $545c
	ld c, $10 ; $545f
	call Func_00_1d2e ; $5461
	ld a, $00 ; $5464
	ld [$cb11], a ; $5466
	jp Label_10_53d4 ; $5469
Label_10_546c:
	cp a, $01 ; $546c
	jr nz, Label_10_5494 ; $546e
	ld c, $10 ; $5470
	call Func_00_1d20 ; $5472
	call Func_00_1da4 ; $5475
	farcall FarPtr_Func_3b_44aaAlias1 ; $5478
	call DisableLCDSafely ; $547b
	farcall FarPtr_01_0a ; $547e
	farcall FarPtr_39_22 ; $5481
	call EnableLCD ; $5484
	ld c, $10 ; $5487
	call Func_00_1d2e ; $5489
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
	call Func_00_1d2e ; $54a5
	ld a, $00 ; $54a8
	ld [$cb11], a ; $54aa
	jp Label_10_53d4 ; $54ad
	ld c, $10 ; $54b0
	call Func_00_1d20 ; $54b2
	call Func_00_1da4 ; $54b5
	ld a, $06 ; $54b8
	farcall FarPtr_3f_00 ; $54ba
	call DisableLCDSafely ; $54bd
	farcall FarPtr_01_0a ; $54c0
	farcall FarPtr_39_22 ; $54c3
	call EnableLCD ; $54c6
	ld c, $10 ; $54c9
	call Func_00_1d2e ; $54cb
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
	call Func_00_1d20 ; $5500
	call Func_00_1da4 ; $5503
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
	call Func_00_1d2e ; $552e
	ld a, $00 ; $5531
	ld [$cb11], a ; $5533
	jp Label_10_54d6 ; $5536
	ld c, $10 ; $5539
	call Func_00_1d20 ; $553b
	call Func_00_1da4 ; $553e
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
	call Func_00_1d2e ; $555a
	ld a, $00 ; $555d
	ld [$cb11], a ; $555f
	jp Label_10_54d6 ; $5562
	ld c, $10 ; $5565
	call Func_00_1d20 ; $5567
	call Func_00_1da4 ; $556a
	ld b, $00 ; $556d
	farcall FarPtr_3e_06 ; $556f
	or a, a ; $5572
	jr nz, Label_10_5592 ; $5573
	call DisableLCDSafely ; $5575
	farcall FarPtr_01_0a ; $5578
	farcall FarPtr_39_22 ; $557b
	call EnableLCD ; $557e
	ld c, $10 ; $5581
	call Func_00_1d2e ; $5583
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
	call Func_00_1d2e ; $55a3
	ld a, $00 ; $55a6
	ld [$cb11], a ; $55a8
	xor a, a ; $55ab
	ld [$cb1b], a ; $55ac
	ld [$cb20], a ; $55af
	jp Label_10_54d6 ; $55b2
	ret ; $55b5
Label_10_55b6:
	farcall FarPtr_08_04 ; $55b6
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
	INCBIN "data/bank_010/d_56f3.bin" ; $56f3, 9 bytes
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
	INCBIN "data/bank_010/d_57f6.bin" ; $57f6, 140 bytes
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
	farcall FarPtr_0a_0e ; $5890
	ld a, $03 ; $5893
	farcall FarPtr_0a_08 ; $5895
	ret ; $5898
	INCBIN "data/bank_010/d_5899.bin" ; $5899, 210 bytes
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
	farcall FarPtr_0a_0e ; $5979
	ld a, $06 ; $597c
	farcall FarPtr_0a_08 ; $597e
	ret ; $5981
	INCBIN "data/bank_010/d_5982.bin" ; $5982, 208 bytes
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
	INCBIN "data/bank_010/d_5a80.bin" ; $5a80, 279 bytes
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
	farcall FarPtr_0a_2a ; $5bb3
	ld a, $02 ; $5bb6
	farcall FarPtr_0a_20 ; $5bb8
	ld a, $02 ; $5bbb
	ld b, $c0 ; $5bbd
	farcall FarPtr_0a_2e ; $5bbf
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
	farcall FarPtr_0a_2a ; $5bd9
Label_10_5bdc:
	ret ; $5bdc
	INCBIN "data/bank_010/d_5bdd.bin" ; $5bdd, 17 bytes
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
	farcall FarPtr_0a_0e ; $5c00
	ld a, [$c2b0] ; $5c03
	cp a, $03 ; $5c06
	jr nz, Label_10_5c0d ; $5c08
	farcall FarPtr_0a_10 ; $5c0a
Label_10_5c0d:
	ld a, $03 ; $5c0d
	farcall FarPtr_0a_08 ; $5c0f
	ret ; $5c12
	INCBIN "data/bank_010/d_5c13.bin" ; $5c13, 10 bytes
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
	farcall FarPtr_0a_0e ; $5c2b
	ld a, $04 ; $5c2e
	farcall FarPtr_0a_08 ; $5c30
	ret ; $5c33
	INCBIN "data/bank_010/d_5c34.bin" ; $5c34, 209 bytes
	call Func_10_612c ; $5d05
	jp nz, Label_10_5db6 ; $5d08
	ld a, $12 ; $5d0b
	ld d, $03 ; $5d0d
	farcall FarPtr_0a_34 ; $5d0f
	ld a, $12 ; $5d12
	farcall FarPtr_0a_36 ; $5d14
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
	farcall FarPtr_0a_0e ; $5d25
	ld a, $12 ; $5d28
	farcall FarPtr_0a_08 ; $5d2a
	ld a, $00 ; $5d2d
	ld b, a ; $5d2f
	ld a, $12 ; $5d30
	farcall FarPtr_0a_30 ; $5d32
	ld a, $07 ; $5d35
	ld bc, $1c00 ; $5d37
	ld de, $1100 ; $5d3a
	farcall FarPtr_0a_22 ; $5d3d
	sound $97 ; $5d40
	ld a, $12 ; $5d42
	ld d, $02 ; $5d44
	farcall FarPtr_0a_34 ; $5d46
	push af ; $5d49
	ld a, $28 ; $5d4a
	farcall FarPtr_0a_04 ; $5d4c
	pop af ; $5d4f
	ld a, $07 ; $5d50
	ld bc, $3f00 ; $5d52
	ld de, $3f00 ; $5d55
	farcall FarPtr_0a_22 ; $5d58
	ld a, $12 ; $5d5b
	farcall FarPtr_0a_08 ; $5d5d
	ld a, $12 ; $5d60
	ld b, $40 ; $5d62
	farcall FarPtr_0a_2e ; $5d64
	push af ; $5d67
	ld a, $14 ; $5d68
	farcall FarPtr_0a_04 ; $5d6a
	pop af ; $5d6d
	ld a, $12 ; $5d6e
	ld b, $01 ; $5d70
	farcall FarPtr_0a_2c ; $5d72
	ld a, $12 ; $5d75
	ld b, $c0 ; $5d77
	ld de, $0100 ; $5d79
	farcall FarPtr_0a_2a ; $5d7c
	call Func_10_613e ; $5d7f
	ld a, $00 ; $5d82
	ld b, a ; $5d84
	ld a, $12 ; $5d85
	farcall FarPtr_0a_30 ; $5d87
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
	farcall FarPtr_0a_0e ; $5d9f
	ld a, $12 ; $5da2
	farcall FarPtr_0a_08 ; $5da4
	ld a, $12 ; $5da7
	ld b, $00 ; $5da9
	farcall FarPtr_0a_2c ; $5dab
	ld a, $12 ; $5dae
	ld b, $40 ; $5db0
	farcall FarPtr_0a_2e ; $5db2
	ret ; $5db5
Label_10_5db6:
	ld a, $00 ; $5db6
	ld b, a ; $5db8
	ld a, $12 ; $5db9
	farcall FarPtr_0a_30 ; $5dbb
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
	farcall FarPtr_0a_0e ; $5dd3
	ld a, $12 ; $5dd6
	farcall FarPtr_0a_08 ; $5dd8
	ret ; $5ddb
	INCBIN "data/bank_010/d_5ddc.bin" ; $5ddc, 278 bytes
	ld a, $00 ; $5ef2
	ld b, a ; $5ef4
	ld a, $0a ; $5ef5
	farcall FarPtr_0a_30 ; $5ef7
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
	farcall FarPtr_0a_0e ; $5f08
	ld a, [$c2b0] ; $5f0b
	cp a, $06 ; $5f0e
	jr nc, Label_10_5f2a ; $5f10
	ld a, $0a ; $5f12
	farcall FarPtr_0a_0a ; $5f14
	farcall FarPtr_0a_12 ; $5f17
	farcall FarPtr_0a_0c ; $5f1a
	push af ; $5f1d
	ld a, $05 ; $5f1e
	farcall FarPtr_0a_04 ; $5f20
	pop af ; $5f23
	and a, a ; $5f24
	jr z, Label_10_5f2a ; $5f25
	farcall FarPtr_0a_10 ; $5f27
Label_10_5f2a:
	ld a, $0a ; $5f2a
	farcall FarPtr_0a_08 ; $5f2c
	ret ; $5f2f
	INCBIN "data/bank_010/d_5f30.bin" ; $5f30, 227 bytes
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
	farcall FarPtr_0a_0e ; $6021
	ld a, $0e ; $6024
	farcall FarPtr_0a_08 ; $6026
	ret ; $6029
	INCBIN "data/bank_010/d_602a.bin" ; $602a, 65 bytes
	ret ; $606b
	INCBIN "data/bank_010/d_606c.bin" ; $606c, 133 bytes
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
	farcall FarPtr_0a_22 ; $6110
	ld a, $08 ; $6113
	ld b, $00 ; $6115
	farcall FarPtr_0a_2e ; $6117
Label_10_611a:
	ret ; $611a
Func_10_611b:
	call Func_10_612c ; $611b
	jr z, Label_10_612b ; $611e
	ld a, $12 ; $6120
	ld bc, $1b00 ; $6122
	ld de, $1100 ; $6125
	farcall FarPtr_0a_22 ; $6128
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
	call Func_00_24ef ; $613a
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
	call Func_00_2509 ; $614c
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
	farcall FarPtr_0a_16 ; $6162
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
	farcall FarPtr_0a_22 ; $619b
	push af ; $619e
	ld a, $46 ; $619f
	farcall FarPtr_0a_04 ; $61a1
	pop af ; $61a4
	ld a, $11 ; $61a5
	ld bc, $3f00 ; $61a7
	ld de, $3f00 ; $61aa
	farcall FarPtr_0a_22 ; $61ad
	ret ; $61b0
Data_10_61b1:
	INCBIN "data/bank_010/d_61b1.bin" ; $61b1, 3649 bytes
	farcall FarPtr_0a_22 ; $6ff2
	ld a, $02 ; $6ff5
	ld bc, $2100 ; $6ff7
	ld de, $3400 ; $6ffa
	farcall FarPtr_0a_22 ; $6ffd
	ld a, $02 ; $7000
	ld b, $c0 ; $7002
	farcall FarPtr_0a_2e ; $7004
	test_flag $07, 4 ; $7007
	jr nz, Label_10_7029 ; $700a
	ld a, $04 ; $700c
	ld bc, $3f00 ; $700e
	ld de, $3f00 ; $7011
	farcall FarPtr_0a_22 ; $7014
	jr Label_10_7029 ; $7017
	INCBIN "data/bank_010/d_7019.bin" ; $7019, 16 bytes
Label_10_7029:
	ld a, $00 ; $7029
	ld b, $c0 ; $702b
	farcall FarPtr_0a_2e ; $702d
	xor a, a ; $7030
	ld [$c2d5], a ; $7031
	ld c, $04 ; $7034
	call Func_00_1d2e ; $7036
	call Func_00_1da4 ; $7039
	push af ; $703c
	ld a, $3c ; $703d
	farcall FarPtr_0a_04 ; $703f
	pop af ; $7042
	ld hl, $01f2 ; $7043
	farcall FarPtr_0a_0e ; $7046
	call Func_10_73ee ; $7049
	test_flag $05, 7 ; $704c
	jp z, Label_10_7059 ; $704f
	ld a, $02 ; $7052
	ld d, $02 ; $7054
	farcall FarPtr_0a_34 ; $7056
Label_10_7059:
	ld a, $00 ; $7059
	ld d, $02 ; $705b
	farcall FarPtr_0a_34 ; $705d
	ld a, $00 ; $7060
	farcall FarPtr_0a_36 ; $7062
	call Func_10_7405 ; $7065
	farcall FarPtr_0a_12 ; $7068
	farcall FarPtr_0a_0c ; $706b
	push af ; $706e
	ld a, $05 ; $706f
	farcall FarPtr_0a_04 ; $7071
	pop af ; $7074
	and a, a ; $7075
	jr nz, Label_10_7089 ; $7076
	ld a, $00 ; $7078
	ld d, $03 ; $707a
	farcall FarPtr_0a_34 ; $707c
	ld a, $00 ; $707f
	farcall FarPtr_0a_36 ; $7081
	farcall FarPtr_0a_10 ; $7084
	jr Label_10_7095 ; $7087
Label_10_7089:
	ld a, $00 ; $7089
	ld d, $04 ; $708b
	farcall FarPtr_0a_34 ; $708d
	ld a, $00 ; $7090
	farcall FarPtr_0a_36 ; $7092
Label_10_7095:
	push af ; $7095
	ld a, $0a ; $7096
	farcall FarPtr_0a_04 ; $7098
	pop af ; $709b
	ld a, $03 ; $709c
	ld d, $03 ; $709e
	farcall FarPtr_0a_34 ; $70a0
	ld a, $03 ; $70a3
	farcall FarPtr_0a_36 ; $70a5
	ld a, $03 ; $70a8
	farcall FarPtr_0a_08 ; $70aa
	ld a, $03 ; $70ad
	ld b, $c0 ; $70af
	farcall FarPtr_0a_2e ; $70b1
	push af ; $70b4
	ld a, $50 ; $70b5
	farcall FarPtr_0a_04 ; $70b7
	pop af ; $70ba
	ld hl, $01f8 ; $70bb
	farcall FarPtr_0a_0e ; $70be
	call Func_10_73ee ; $70c1
	test_flag $05, 7 ; $70c4
	jp z, Label_10_7101 ; $70c7
	ld a, $06 ; $70ca
	ld bc, $2080 ; $70cc
	ld de, $3200 ; $70cf
	farcall FarPtr_0a_22 ; $70d2
	ld a, $07 ; $70d5
	ld bc, $2280 ; $70d7
	ld de, $3200 ; $70da
	farcall FarPtr_0a_22 ; $70dd
	sound $97 ; $70e0
	push af ; $70e2
	ld a, $50 ; $70e3
	farcall FarPtr_0a_04 ; $70e5
	pop af ; $70e8
	ld a, $06 ; $70e9
	ld bc, $3f00 ; $70eb
	ld de, $3f00 ; $70ee
	farcall FarPtr_0a_22 ; $70f1
	ld a, $07 ; $70f4
	ld bc, $3f00 ; $70f6
	ld de, $3f00 ; $70f9
	farcall FarPtr_0a_22 ; $70fc
	jr Label_10_7120 ; $70ff
Label_10_7101:
	ld a, $06 ; $7101
	ld bc, $2180 ; $7103
	ld de, $3200 ; $7106
	farcall FarPtr_0a_22 ; $7109
	sound $97 ; $710c
	push af ; $710e
	ld a, $50 ; $710f
	farcall FarPtr_0a_04 ; $7111
	pop af ; $7114
	ld a, $06 ; $7115
	ld bc, $3f00 ; $7117
	ld de, $3f00 ; $711a
	farcall FarPtr_0a_22 ; $711d
Label_10_7120:
	ld a, $03 ; $7120
	ld b, $40 ; $7122
	farcall FarPtr_0a_2e ; $7124
	push af ; $7127
	ld a, $01 ; $7128
	farcall FarPtr_0a_04 ; $712a
	pop af ; $712d
	call Func_10_73ee ; $712e
	push af ; $7131
	ld a, $1e ; $7132
	farcall FarPtr_0a_04 ; $7134
	pop af ; $7137
	ld a, $03 ; $7138
	ld d, $03 ; $713a
	farcall FarPtr_0a_34 ; $713c
	ld a, $03 ; $713f
	farcall FarPtr_0a_36 ; $7141
	ld a, $03 ; $7144
	farcall FarPtr_0a_08 ; $7146
	ld a, $03 ; $7149
	ld bc, $0010 ; $714b
	farcall FarPtr_0a_18 ; $714e
	ld a, $03 ; $7151
	ld bc, $2200 ; $7153
	ld de, $3000 ; $7156
	farcall FarPtr_0a_24 ; $7159
	ld a, $03 ; $715c
	farcall FarPtr_0a_20 ; $715e
	push af ; $7161
	ld a, $28 ; $7162
	farcall FarPtr_0a_04 ; $7164
	pop af ; $7167
	ld a, $03 ; $7168
	ld d, $03 ; $716a
	farcall FarPtr_0a_34 ; $716c
	ld a, $03 ; $716f
	farcall FarPtr_0a_36 ; $7171
	ld a, $03 ; $7174
	ld d, $03 ; $7176
	farcall FarPtr_0a_34 ; $7178
	ld a, $03 ; $717b
	farcall FarPtr_0a_36 ; $717d
	ld a, $03 ; $7180
	ld bc, $2000 ; $7182
	ld de, $3000 ; $7185
	farcall FarPtr_0a_24 ; $7188
	ld a, $03 ; $718b
	farcall FarPtr_0a_20 ; $718d
	ld a, $03 ; $7190
	ld b, $40 ; $7192
	farcall FarPtr_0a_2e ; $7194
	push af ; $7197
	ld a, $0a ; $7198
	farcall FarPtr_0a_04 ; $719a
	pop af ; $719d
	ld a, $03 ; $719e
	farcall FarPtr_0a_08 ; $71a0
	ld a, $00 ; $71a3
	ld d, $02 ; $71a5
	farcall FarPtr_0a_34 ; $71a7
	ld a, $00 ; $71aa
	farcall FarPtr_0a_36 ; $71ac
	ld a, $03 ; $71af
	ld d, $03 ; $71b1
	farcall FarPtr_0a_34 ; $71b3
	ld a, $03 ; $71b6
	farcall FarPtr_0a_36 ; $71b8
Label_10_71bb:
	ld a, $03 ; $71bb
	farcall FarPtr_0a_0a ; $71bd
	farcall FarPtr_0a_12 ; $71c0
	farcall FarPtr_0a_0c ; $71c3
	push af ; $71c6
	ld a, $05 ; $71c7
	farcall FarPtr_0a_04 ; $71c9
	pop af ; $71cc
	and a, a ; $71cd
	jr z, Label_10_71f0 ; $71ce
	ld a, $00 ; $71d0
	ld d, $04 ; $71d2
	farcall FarPtr_0a_34 ; $71d4
	ld a, $00 ; $71d7
	farcall FarPtr_0a_36 ; $71d9
	ld a, $03 ; $71dc
	ld d, $02 ; $71de
	farcall FarPtr_0a_34 ; $71e0
	ld a, $03 ; $71e3
	farcall FarPtr_0a_36 ; $71e5
	ld hl, $01ff ; $71e8
	farcall FarPtr_0a_0e ; $71eb
	jr Label_10_71bb ; $71ee
Label_10_71f0:
	test_flag $05, 7 ; $71f0
	jp z, Label_10_72a9 ; $71f3
	ld a, $00 ; $71f6
	ld d, $03 ; $71f8
	farcall FarPtr_0a_34 ; $71fa
	ld a, $00 ; $71fd
	farcall FarPtr_0a_36 ; $71ff
	ld a, $03 ; $7202
	ld d, $03 ; $7204
	farcall FarPtr_0a_34 ; $7206
	ld a, $03 ; $7209
	farcall FarPtr_0a_36 ; $720b
	ld hl, $0200 ; $720e
	farcall FarPtr_0a_0e ; $7211
	ld a, $03 ; $7214
	farcall FarPtr_0a_08 ; $7216
	ld a, $00 ; $7219
	ld d, $03 ; $721b
	farcall FarPtr_0a_34 ; $721d
	ld a, $02 ; $7220
	ld d, $03 ; $7222
	farcall FarPtr_0a_34 ; $7224
	ld a, $02 ; $7227
	farcall FarPtr_0a_36 ; $7229
	push af ; $722c
	ld a, $0a ; $722d
	farcall FarPtr_0a_04 ; $722f
	pop af ; $7232
	ld a, $02 ; $7233
	ld b, a ; $7235
	ld a, $00 ; $7236
	farcall FarPtr_0a_32 ; $7238
	push af ; $723b
	ld a, $1e ; $723c
	farcall FarPtr_0a_04 ; $723e
	pop af ; $7241
	ld a, $00 ; $7242
	ld d, $03 ; $7244
	farcall FarPtr_0a_34 ; $7246
	ld a, $02 ; $7249
	ld d, $03 ; $724b
	farcall FarPtr_0a_34 ; $724d
	ld a, $02 ; $7250
	farcall FarPtr_0a_36 ; $7252
	ld a, $02 ; $7255
	ld b, $40 ; $7257
	farcall FarPtr_0a_2e ; $7259
	ld a, $00 ; $725c
	ld bc, $2100 ; $725e
	ld de, $3600 ; $7261
	farcall FarPtr_0a_24 ; $7264
	ld a, $00 ; $7267
	farcall FarPtr_0a_20 ; $7269
	ld a, $00 ; $726c
	ld bc, $2100 ; $726e
	ld de, $3700 ; $7271
	farcall FarPtr_0a_24 ; $7274
	ld a, $02 ; $7277
	ld bc, $2100 ; $7279
	ld de, $3500 ; $727c
	farcall FarPtr_0a_24 ; $727f
	ld a, $02 ; $7282
	farcall FarPtr_0a_20 ; $7284
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
	farcall FarPtr_0a_04 ; $72a3
	pop af ; $72a6
	jr Label_10_7314 ; $72a7
Label_10_72a9:
	ld a, $00 ; $72a9
	ld d, $03 ; $72ab
	farcall FarPtr_0a_34 ; $72ad
	ld a, $00 ; $72b0
	farcall FarPtr_0a_36 ; $72b2
	ld a, $03 ; $72b5
	ld d, $03 ; $72b7
	farcall FarPtr_0a_34 ; $72b9
	ld a, $03 ; $72bc
	farcall FarPtr_0a_36 ; $72be
	ld hl, $0200 ; $72c1
	farcall FarPtr_0a_0e ; $72c4
	ld a, $03 ; $72c7
	farcall FarPtr_0a_08 ; $72c9
	ld a, $00 ; $72cc
	ld d, $03 ; $72ce
	farcall FarPtr_0a_34 ; $72d0
	ld a, $00 ; $72d3
	farcall FarPtr_0a_36 ; $72d5
	push af ; $72d8
	ld a, $1e ; $72d9
	farcall FarPtr_0a_04 ; $72db
	pop af ; $72de
	ld a, $00 ; $72df
	ld bc, $2100 ; $72e1
	ld de, $3400 ; $72e4
	farcall FarPtr_0a_24 ; $72e7
	ld a, $00 ; $72ea
	farcall FarPtr_0a_20 ; $72ec
	ld a, $00 ; $72ef
	ld bc, $2100 ; $72f1
	ld de, $3700 ; $72f4
	farcall FarPtr_0a_24 ; $72f7
	ld a, $00 ; $72fa
	farcall FarPtr_0a_20 ; $72fc
	call Func_10_7339 ; $72ff
	ldh a, [hRomBank] ; $7302
	ld b, a ; $7304
	ld a, $00 ; $7305
	ld de, $741c ; $7307
	farcall FarPtr_0a_1a ; $730a
	push af ; $730d
	ld a, $14 ; $730e
	farcall FarPtr_0a_04 ; $7310
	pop af ; $7313
Label_10_7314:
	call Func_10_736f ; $7314
	push af ; $7317
	ld a, $3c ; $7318
	farcall FarPtr_0a_04 ; $731a
	pop af ; $731d
	ld c, $02 ; $731e
	call Func_00_1d20 ; $7320
	call Func_00_1da4 ; $7323
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
	farcall FarPtr_0a_04 ; $733c
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
	farcall FarPtr_0a_04 ; $7354
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
	farcall FarPtr_0a_04 ; $736a
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
	farcall FarPtr_0a_04 ; $7383
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
	farcall FarPtr_0a_04 ; $7399
	pop af ; $739c
	ret ; $739d
	INCBIN "data/bank_010/d_739e.bin" ; $739e, 80 bytes
Func_10_73ee:
	test_flag $05, 7 ; $73ee
	jr z, Label_10_73fc ; $73f1
	farcall FarPtr_0a_10 ; $73f3
	ld a, $03 ; $73f6
	farcall FarPtr_0a_08 ; $73f8
	ret ; $73fb
Label_10_73fc:
	ld a, $03 ; $73fc
	farcall FarPtr_0a_08 ; $73fe
	farcall FarPtr_0a_10 ; $7401
	ret ; $7404
Func_10_7405:
	test_flag $05, 7 ; $7405
	jr z, Label_10_7413 ; $7408
	farcall FarPtr_0a_10 ; $740a
	ld a, $03 ; $740d
	farcall FarPtr_0a_0a ; $740f
	ret ; $7412
Label_10_7413:
	ld a, $03 ; $7413
	farcall FarPtr_0a_0a ; $7415
	farcall FarPtr_0a_10 ; $7418
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
	ld a, $04 ; $7443
	ld d, $06 ; $7445
	farcall FarPtr_0a_34 ; $7447
	test_flag $05, 7 ; $744a
	jr z, Label_10_7461 ; $744d
	test_flag $07, 4 ; $744f
	jr nz, Label_10_7471 ; $7452
	ld a, $04 ; $7454
	ld bc, $0100 ; $7456
	ld de, $0100 ; $7459
	farcall FarPtr_0a_22 ; $745c
	jr Label_10_7471 ; $745f
Label_10_7461:
	test_flag $06, 5 ; $7461
	jr nz, Label_10_7471 ; $7464
	ld a, $05 ; $7466
	ld bc, $0100 ; $7468
	ld de, $0100 ; $746b
	farcall FarPtr_0a_22 ; $746e
Label_10_7471:
	ret ; $7471
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
	INCBIN "data/bank_010/d_74a9.bin" ; $74a9, 622 bytes
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
	farcall FarPtr_0a_22 ; $7754
	ld a, $03 ; $7757
	ld bc, $2200 ; $7759
	ld de, $2400 ; $775c
	farcall FarPtr_0a_22 ; $775f
	ld c, $04 ; $7762
	call Func_00_1d2e ; $7764
	push af ; $7767
	ld a, $1e ; $7768
	farcall FarPtr_0a_04 ; $776a
	pop af ; $776d
	ld a, $03 ; $776e
	ld b, $c0 ; $7770
	farcall FarPtr_0a_2e ; $7772
	push af ; $7775
	ld a, $0a ; $7776
	farcall FarPtr_0a_04 ; $7778
	pop af ; $777b
	ld a, $04 ; $777c
	ld d, $02 ; $777e
	farcall FarPtr_0a_34 ; $7780
	push af ; $7783
	ld a, $1e ; $7784
	farcall FarPtr_0a_04 ; $7786
	pop af ; $7789
	ld a, $03 ; $778a
	ld bc, $2200 ; $778c
	ld de, $1700 ; $778f
	farcall FarPtr_0a_24 ; $7792
	xor a, a ; $7795
	ld bc, $2200 ; $7796
	ld de, $1700 ; $7799
	farcall FarPtr_0a_3a ; $779c
	push af ; $779f
	ld a, $0a ; $77a0
	farcall FarPtr_0a_04 ; $77a2
	pop af ; $77a5
	ld a, $00 ; $77a6
	ld bc, $2200 ; $77a8
	ld de, $1900 ; $77ab
	farcall FarPtr_0a_24 ; $77ae
	ld a, $04 ; $77b1
	ld b, $00 ; $77b3
	farcall FarPtr_0a_2e ; $77b5
	farcall FarPtr_0a_3e ; $77b8
	ld hl, $01ae ; $77bb
	farcall FarPtr_0a_0e ; $77be
	ld a, $04 ; $77c1
	farcall FarPtr_0a_08 ; $77c3
	ld a, $03 ; $77c6
	farcall FarPtr_0a_20 ; $77c8
	push af ; $77cb
	ld a, $0a ; $77cc
	farcall FarPtr_0a_04 ; $77ce
	pop af ; $77d1
	xor a, a ; $77d2
	ld bc, $1d00 ; $77d3
	ld de, $1900 ; $77d6
	farcall FarPtr_0a_3a ; $77d9
	ld a, $04 ; $77dc
	ld b, a ; $77de
	ld a, $03 ; $77df
	farcall FarPtr_0a_30 ; $77e1
	push af ; $77e4
	ld a, $1e ; $77e5
	farcall FarPtr_0a_04 ; $77e7
	pop af ; $77ea
	ld a, $04 ; $77eb
	ld b, a ; $77ed
	ld a, $00 ; $77ee
	farcall FarPtr_0a_30 ; $77f0
	push af ; $77f3
	ld a, $1e ; $77f4
	farcall FarPtr_0a_04 ; $77f6
	pop af ; $77f9
	farcall FarPtr_0a_3e ; $77fa
	ld a, $04 ; $77fd
	ld d, $03 ; $77ff
	farcall FarPtr_0a_34 ; $7801
	ld a, $04 ; $7804
	farcall FarPtr_0a_36 ; $7806
	ld a, $04 ; $7809
	farcall FarPtr_0a_08 ; $780b
	push af ; $780e
	ld a, $0a ; $780f
	farcall FarPtr_0a_04 ; $7811
	pop af ; $7814
	ld a, $03 ; $7815
	ld d, $03 ; $7817
	farcall FarPtr_0a_34 ; $7819
	ld a, $03 ; $781c
	farcall FarPtr_0a_36 ; $781e
	ld a, $03 ; $7821
	farcall FarPtr_0a_08 ; $7823
	ld a, $00 ; $7826
	ld b, a ; $7828
	ld a, $03 ; $7829
	farcall FarPtr_0a_30 ; $782b
	push af ; $782e
	ld a, $32 ; $782f
	farcall FarPtr_0a_04 ; $7831
	pop af ; $7834
	ld a, $04 ; $7835
	ld b, a ; $7837
	ld a, $03 ; $7838
	farcall FarPtr_0a_30 ; $783a
	push af ; $783d
	ld a, $1e ; $783e
	farcall FarPtr_0a_04 ; $7840
	pop af ; $7843
	ld a, [$c90d] ; $7844
	or a, a ; $7847
	jr z, Label_10_784d ; $7848
	farcall FarPtr_0a_10 ; $784a
Label_10_784d:
	ld a, $03 ; $784d
	farcall FarPtr_0a_08 ; $784f
	ld a, [$c90d] ; $7852
	or a, a ; $7855
	jr nz, Label_10_785b ; $7856
	farcall FarPtr_0a_10 ; $7858
Label_10_785b:
	push af ; $785b
	ld a, $0f ; $785c
	farcall FarPtr_0a_04 ; $785e
	pop af ; $7861
	ld a, $04 ; $7862
	ld d, $03 ; $7864
	farcall FarPtr_0a_34 ; $7866
	ld a, $04 ; $7869
	farcall FarPtr_0a_36 ; $786b
	ld a, $04 ; $786e
	farcall FarPtr_0a_08 ; $7870
	push af ; $7873
	ld a, $0f ; $7874
	farcall FarPtr_0a_04 ; $7876
	pop af ; $7879
	ld a, $00 ; $787a
	ld d, $03 ; $787c
	farcall FarPtr_0a_34 ; $787e
	ld a, $00 ; $7881
	farcall FarPtr_0a_36 ; $7883
	push af ; $7886
	ld a, $0f ; $7887
	farcall FarPtr_0a_04 ; $7889
	pop af ; $788c
	ld a, $04 ; $788d
	ld d, $03 ; $788f
	farcall FarPtr_0a_34 ; $7891
	ld a, $04 ; $7894
	farcall FarPtr_0a_36 ; $7896
	ld a, $04 ; $7899
	farcall FarPtr_0a_08 ; $789b
	push af ; $789e
	ld a, $0f ; $789f
	farcall FarPtr_0a_04 ; $78a1
	pop af ; $78a4
	ld a, $03 ; $78a5
	ld d, $02 ; $78a7
	farcall FarPtr_0a_34 ; $78a9
	ld a, $03 ; $78ac
	farcall FarPtr_0a_36 ; $78ae
	ld a, $03 ; $78b1
	farcall FarPtr_0a_08 ; $78b3
	ld a, $03 ; $78b6
	ld b, a ; $78b8
	ld a, $00 ; $78b9
	farcall FarPtr_0a_30 ; $78bb
	ld a, $06 ; $78be
	ld bc, $2300 ; $78c0
	ld de, $1700 ; $78c3
	farcall FarPtr_0a_22 ; $78c6
	sound $98 ; $78c9
	push af ; $78cb
	ld a, $3c ; $78cc
	farcall FarPtr_0a_04 ; $78ce
	pop af ; $78d1
	ld a, $06 ; $78d2
	ld bc, $3f00 ; $78d4
	ld de, $3f00 ; $78d7
	farcall FarPtr_0a_22 ; $78da
	ld a, $04 ; $78dd
	ld d, $03 ; $78df
	farcall FarPtr_0a_34 ; $78e1
	ld a, $04 ; $78e4
	farcall FarPtr_0a_36 ; $78e6
	ld a, $04 ; $78e9
	farcall FarPtr_0a_08 ; $78eb
	ld a, $00 ; $78ee
	ld d, $02 ; $78f0
	farcall FarPtr_0a_34 ; $78f2
	ld a, $00 ; $78f5
	farcall FarPtr_0a_36 ; $78f7
	push af ; $78fa
	ld a, $0a ; $78fb
	farcall FarPtr_0a_04 ; $78fd
	pop af ; $7900
	ld a, $04 ; $7901
	ld b, a ; $7903
	ld a, $00 ; $7904
	farcall FarPtr_0a_30 ; $7906
	ld a, $00 ; $7909
	ld d, $03 ; $790b
	farcall FarPtr_0a_34 ; $790d
	ld a, $00 ; $7910
	farcall FarPtr_0a_36 ; $7912
	push af ; $7915
	ld a, $0f ; $7916
	farcall FarPtr_0a_04 ; $7918
	pop af ; $791b
	ld a, $04 ; $791c
	ld b, a ; $791e
	ld a, $03 ; $791f
	farcall FarPtr_0a_32 ; $7921
	ld a, $03 ; $7924
	ld d, $03 ; $7926
	farcall FarPtr_0a_34 ; $7928
	ld a, $04 ; $792b
	ld d, $03 ; $792d
	farcall FarPtr_0a_34 ; $792f
	ld a, $04 ; $7932
	farcall FarPtr_0a_36 ; $7934
	xor a, a ; $7937
	ld bc, $2200 ; $7938
	ld de, $1700 ; $793b
	farcall FarPtr_0a_3a ; $793e
	push af ; $7941
	ld a, $28 ; $7942
	farcall FarPtr_0a_04 ; $7944
	pop af ; $7947
	ld a, $03 ; $7948
	ld bc, $2200 ; $794a
	ld de, $0300 ; $794d
	farcall FarPtr_0a_24 ; $7950
	push af ; $7953
	ld a, $0a ; $7954
	farcall FarPtr_0a_04 ; $7956
	pop af ; $7959
	xor a, a ; $795a
	ld bc, $2200 ; $795b
	ld de, $0300 ; $795e
	farcall FarPtr_0a_3a ; $7961
	ld a, $00 ; $7964
	ld bc, $2200 ; $7966
	ld de, $0300 ; $7969
	farcall FarPtr_0a_24 ; $796c
	ld a, $00 ; $796f
	farcall FarPtr_0a_20 ; $7971
	ld a, $0f ; $7974
	ld [$c294], a ; $7976
	ld [$c2a1], a ; $7979
	farcall FarPtr_0a_02 ; $797c
	ret ; $797f
	INCBIN "data/bank_010/d_7980.bin" ; $7980, 80 bytes
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
	farcall FarPtr_0a_2a ; $7afd
	ld a, $00 ; $7b00
	farcall FarPtr_0a_20 ; $7b02
	ld a, $00 ; $7b05
	ld b, $e0 ; $7b07
	ld de, $0080 ; $7b09
	farcall FarPtr_0a_2a ; $7b0c
	ld a, $00 ; $7b0f
	farcall FarPtr_0a_20 ; $7b11
	ld a, $00 ; $7b14
	ld b, $00 ; $7b16
	ld de, $00c0 ; $7b18
	farcall FarPtr_0a_2a ; $7b1b
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
	farcall FarPtr_0a_2a ; $7b3d
	ld a, $00 ; $7b40
	farcall FarPtr_0a_20 ; $7b42
	ld a, $00 ; $7b45
	ld b, $a0 ; $7b47
	ld de, $0080 ; $7b49
	farcall FarPtr_0a_2a ; $7b4c
	ld a, $00 ; $7b4f
	farcall FarPtr_0a_20 ; $7b51
	ld a, $00 ; $7b54
	ld b, $80 ; $7b56
	ld de, $0080 ; $7b58
	farcall FarPtr_0a_2a ; $7b5b
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
	farcall FarPtr_0a_2a ; $7b7d
	ld a, $02 ; $7b80
	ld b, $40 ; $7b82
	ld de, $0200 ; $7b84
	farcall FarPtr_0a_2a ; $7b87
Label_10_7b8a:
	ret ; $7b8a
	INCBIN "data/bank_010/d_7b8b.bin" ; $7b8b, 110 bytes
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
