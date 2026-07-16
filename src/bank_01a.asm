SECTION "ROM Bank $1a", ROMX[$4000], BANK[$1a]

FarPtr_1a_00:
	dw Func_1a_4014 ; $4000
FarPtr_1a_02:
	dw Func_1a_413c ; $4002
FarPtr_1a_04:
	dw Func_1a_5082 ; $4004
FarPtr_1a_06:
	dw Func_1a_4399 ; $4006
FarPtr_1a_08:
	dw Func_1a_67d4 ; $4008
FarPtr_1a_0a:
	dw Func_1a_44d8 ; $400a
FarPtr_1a_0c:
	dw Func_1a_7945 ; $400c
FarPtr_CharDataScreen_BuildStats:
	dw CharDataScreen_BuildStats ; $400e
FarPtr_CharDataScreen_LoadGfx:
	dw CharDataScreen_LoadGfx ; $4010
FarPtr_1a_12:
	dw Func_1a_7be5 ; $4012
Func_1a_4014:
	ldh a, [hWramBank] ; $4014
	push af ; $4016
	call Func_1a_42bc ; $4017
	call Func_1a_437c ; $401a
	call Func_1a_402c ; $401d
	call Func_1a_42c5 ; $4020
	pop af ; $4023
	wram_bank ; $4024
	ld a, [$cb2b] ; $4028
	ret ; $402b
Func_1a_402c:
	xor a, a ; $402c
	ld [$cb2b], a ; $402d
	wram_bank $05 ; $4030
	farcall FarPtr_05_08 ; $4036
	set_flag $03, 0 ; $4039
	ld [$cb26], a ; $403c
	farcall FarPtr_05_18 ; $403f
	farcall FarPtr_05_80 ; $4042
	clear_flag $03, 0 ; $4045
	call Func_1a_40a0 ; $4048
	ld a, [$cb26] ; $404b
	farcall FarPtr_05_42 ; $404e
	push af ; $4051
	push bc ; $4052
	cp a, $ff ; $4053
	jr z, Label_1a_4070 ; $4055
	ld a, [$cb29] ; $4057
	bit 7, a ; $405a
	jr z, Label_1a_4070 ; $405c
	and a, $7f ; $405e
	ld b, a ; $4060
	ld a, [$d830] ; $4061
	inc a ; $4064
Label_1a_4065:
	rrc b ; $4065
	dec a ; $4067
	jr nz, Label_1a_4065 ; $4068
	rlc b ; $406a
	bit 0, b ; $406c
	jr nz, Label_1a_407c ; $406e
Label_1a_4070:
	ld a, [$cb26] ; $4070
	set_flag $03, 0 ; $4073
	farcall FarPtr_05_7a ; $4076
	clear_flag $03, 0 ; $4079
Label_1a_407c:
	pop bc ; $407c
	pop af ; $407d
	cp a, $ff ; $407e
	jr z, Label_1a_408e ; $4080
	add a, a ; $4082
	add a, c ; $4083
	ld c, a ; $4084
	jr nc, Label_1a_4088 ; $4085
	inc b ; $4087
Label_1a_4088:
	ld h, b ; $4088
	ld l, c ; $4089
	ld a, [hl+] ; $408a
	ld h, [hl] ; $408b
	ld l, a ; $408c
	jp hl ; $408d
Label_1a_408e:
	call Func_1a_4092 ; $408e
	ret ; $4091
Func_1a_4092:
	xor a, a ; $4092
	ld [$cb27], a ; $4093
	ld [$cb28], a ; $4096
	ld [$cb2a], a ; $4099
	ld [$cb29], a ; $409c
	ret ; $409f
Func_1a_40a0:
	push af ; $40a0
	push bc ; $40a1
	push de ; $40a2
	push hl ; $40a3
	ld a, [$cb2a] ; $40a4
	bit 5, a ; $40a7
	jr nz, Label_1a_40b0 ; $40a9
	pop hl ; $40ab
	pop de ; $40ac
	pop bc ; $40ad
	pop af ; $40ae
	ret ; $40af
Label_1a_40b0:
	ld a, [wMessageSpeed] ; $40b0
	and a, $7f ; $40b3
	jr z, Label_1a_40ee ; $40b5
	dec a ; $40b7
	jr z, Label_1a_40d4 ; $40b8
	ld l, $75 ; $40ba
	ld de, $0a05 ; $40bc
	call Func_1a_413c ; $40bf
	ld l, $7f ; $40c2
	ld de, $0b05 ; $40c4
	call Func_1a_413c ; $40c7
	ld l, $72 ; $40ca
	ld de, $0c05 ; $40cc
	call Func_1a_413c ; $40cf
	jr Label_1a_4108 ; $40d2
Label_1a_40d4:
	ld l, $8c ; $40d4
	ld de, $0a05 ; $40d6
	call Func_1a_413c ; $40d9
	ld l, $82 ; $40dc
	ld de, $0b05 ; $40de
	call Func_1a_413c ; $40e1
	ld l, $73 ; $40e4
	ld de, $0c05 ; $40e6
	call Func_1a_413c ; $40e9
	jr Label_1a_4108 ; $40ec
Label_1a_40ee:
	ld l, $8a ; $40ee
	ld de, $0a05 ; $40f0
	call Func_1a_413c ; $40f3
	ld l, $94 ; $40f6
	ld de, $0b05 ; $40f8
	call Func_1a_413c ; $40fb
	ld l, $72 ; $40fe
	ld de, $0c05 ; $4100
	call Func_1a_413c ; $4103
	jr Label_1a_4108 ; $4106
Label_1a_4108:
	ldh a, [hMusic] ; $4108
	push af ; $410a
	push bc ; $410b
	push de ; $410c
	push hl ; $410d
	ld de, $0404 ; $410e
	call PrintHexByte ; $4111
	ld a, [$c8a3] ; $4114
	ld de, $0405 ; $4117
	call PrintHexByte ; $411a
	pop hl ; $411d
	pop de ; $411e
	pop bc ; $411f
	pop af ; $4120
	and a, $01 ; $4121
	jr nz, Label_1a_412f ; $4123
	ld l, $dd ; $4125
	ld de, $0b07 ; $4127
	call Func_1a_413c ; $412a
	jr Label_1a_4137 ; $412d
Label_1a_412f:
	ld l, $cc ; $412f
	ld de, $0b07 ; $4131
	call Func_1a_413c ; $4134
Label_1a_4137:
	pop hl ; $4137
	pop de ; $4138
	pop bc ; $4139
	pop af ; $413a
	ret ; $413b
Func_1a_413c:
	ld h, $80 ; $413c
	call Func_1a_4145 ; $413e
	call Func_00_0507 ; $4141
	ret ; $4144
Func_1a_4145:
	push af ; $4145
	push bc ; $4146
	push hl ; $4147
	push de ; $4148
	ld a, [$cb26] ; $4149
	farcall FarPtr_05_86 ; $414c
	ld d, [hl] ; $414f
	inc hl ; $4150
	ld e, [hl] ; $4151
	pop hl ; $4152
	ld a, h ; $4153
	add a, d ; $4154
	ld d, a ; $4155
	ld a, l ; $4156
	add a, e ; $4157
	ld e, a ; $4158
	farcall FarPtr_GetTilemapCellAddress ; $4159
	ld h, d ; $415c
	ld l, e ; $415d
	ld de, $3000 ; $415e
	add hl, de ; $4161
	ld de, $9800 ; $4162
	add hl, de ; $4165
	ld d, h ; $4166
	ld e, l ; $4167
	pop hl ; $4168
	pop bc ; $4169
	pop af ; $416a
	ret ; $416b
	INCBIN "data/bank_01a/d_416c.bin" ; $416c, 336 bytes
Func_1a_42bc:
	ld a, [wMessageSpeed] ; $42bc
	set 7, a ; $42bf
	ld [wMessageSpeed], a ; $42c1
	ret ; $42c4
Func_1a_42c5:
	ld a, [wMessageSpeed] ; $42c5
	res 7, a ; $42c8
	ld [wMessageSpeed], a ; $42ca
	ret ; $42cd
	INCBIN "data/bank_01a/d_42ce.bin" ; $42ce, 174 bytes
Func_1a_437c:
	call Func_1a_4092 ; $437c
	ld a, $a0 ; $437f
	ld [$cb2a], a ; $4381
	ld a, $8c ; $4384
	ld [$cb28], a ; $4386
	ld [$cb29], a ; $4389
	ld hl, $049a ; $438c
	ld bc, $416c ; $438f
	ld de, $0304 ; $4392
	set_flag $06, 1 ; $4395
	ret ; $4398
Func_1a_4399:
	push af ; $4399
	ldh a, [$ff9e] ; $439a
	or a, a ; $439c
	jr z, Label_1a_43a8 ; $439d
	ldh a, [hPlayerInputFlags] ; $439f
	bit 2, a ; $43a1
	jr z, Label_1a_43a8 ; $43a3
	call Func_1a_43aa ; $43a5
Label_1a_43a8:
	pop af ; $43a8
	ret ; $43a9
Func_1a_43aa:
	push af ; $43aa
	push bc ; $43ab
	push de ; $43ac
	push hl ; $43ad
	ldh a, [hWramBank] ; $43ae
	push af ; $43b0
	wram_bank $05 ; $43b1
	ld de, $0000 ; $43b7
	ld bc, $1404 ; $43ba
	farcall FarPtr_05_04 ; $43bd
	ld [$cb26], a ; $43c0
	farcall FarPtr_05_18 ; $43c3
	farcall FarPtr_05_10 ; $43c6
	ld c, $00 ; $43c9
Label_1a_43cb:
	ld hl, $c92c ; $43cb
	ld a, [hl+] ; $43ce
	ld h, [hl] ; $43cf
	ld l, a ; $43d0
	ld a, $04 ; $43d1
	ld de, $d000 ; $43d3
	call FormatDecimalNumber ; $43d6
	ld hl, $d000 ; $43d9
	ld de, $0801 ; $43dc
	ld a, [$cb26] ; $43df
	farcall FarPtr_05_56 ; $43e2
	ld hl, $c96c ; $43e5
	ld a, [hl+] ; $43e8
	ld h, [hl] ; $43e9
	ld l, a ; $43ea
	ld a, $04 ; $43eb
	ld de, $d000 ; $43ed
	call FormatDecimalNumber ; $43f0
	ld hl, $d000 ; $43f3
	ld de, $0802 ; $43f6
	ld a, [$cb26] ; $43f9
	farcall FarPtr_05_56 ; $43fc
	farcall FarPtr_05_18 ; $43ff
	farcall FarPtr_05_10 ; $4402
	call AdvanceFrame ; $4405
	ldh a, [hPlayerInputFlags] ; $4408
	and a, $01 ; $440a
	jr z, Label_1a_4418 ; $440c
	sound $5f ; $440e
	ld de, $0064 ; $4410
	call Func_1a_4473 ; $4413
	jr Label_1a_43cb ; $4416
Label_1a_4418:
	ldh a, [hPlayerInputFlags] ; $4418
	and a, $10 ; $441a
	jr z, Label_1a_4428 ; $441c
	sound $5e ; $441e
	ld de, $000a ; $4420
	call Func_1a_4473 ; $4423
	jr Label_1a_43cb ; $4426
Label_1a_4428:
	ldh a, [hPlayerInputFlags] ; $4428
	and a, $20 ; $442a
	jr z, Label_1a_4438 ; $442c
	sound $5e ; $442e
	ld de, $0001 ; $4430
	call Func_1a_4473 ; $4433
	jr Label_1a_43cb ; $4436
Label_1a_4438:
	ldh a, [hPlayerInputFlags] ; $4438
	and a, $c0 ; $443a
	jr z, Label_1a_4446 ; $443c
	sound $62 ; $443e
	ld a, c ; $4440
	xor a, $01 ; $4441
	ld c, a ; $4443
	jr Label_1a_43cb ; $4444
Label_1a_4446:
	ldh a, [hPlayerInputFlags] ; $4446
	and a, $02 ; $4448
	jp z, Label_1a_43cb ; $444a
	ld a, [$cb26] ; $444d
	farcall FarPtr_05_7a ; $4450
	ld hl, $c92c ; $4453
	ld a, [hl+] ; $4456
	ld d, [hl] ; $4457
	ld e, a ; $4458
	ld l, $00 ; $4459
	call Func_1a_5082 ; $445b
	ld hl, $c96c ; $445e
	ld a, [hl+] ; $4461
	ld d, [hl] ; $4462
	ld e, a ; $4463
	ld l, $01 ; $4464
	call Func_1a_5082 ; $4466
	pop af ; $4469
	wram_bank ; $446a
	pop hl ; $446e
	pop de ; $446f
	pop bc ; $4470
	pop af ; $4471
	ret ; $4472
Func_1a_4473:
	ld a, c ; $4473
	or a, a ; $4474
	jr nz, Label_1a_447d ; $4475
	push bc ; $4477
	farcall FarPtr_AddPlayerExp ; $4478
	pop bc ; $447b
	ret ; $447c
Label_1a_447d:
	push bc ; $447d
	farcall FarPtr_AddPlayerExp ; $447e
	pop bc ; $4481
	ret ; $4482
	INCBIN "data/bank_01a/d_4483.bin" ; $4483, 85 bytes
Func_1a_44d8:
	push bc ; $44d8
	push de ; $44d9
	push hl ; $44da
	push af ; $44db
	ld a, l ; $44dc
	ld [$cb00], a ; $44dd
	pop af ; $44e0
	ld h, a ; $44e1
	ldh a, [hWramBank] ; $44e2
	push af ; $44e4
	push hl ; $44e5
	ld c, $10 ; $44e6
	call Func_00_1d20 ; $44e8
	call Func_00_1da4 ; $44eb
	call ClearFrameTasks ; $44ee
	farcall FarPtr_05_00 ; $44f1
	farcall FarPtr_01_0a ; $44f4
	call DisableLCDSafely ; $44f7
	call Func_00_1e1d ; $44fa
	xor a, a ; $44fd
	ldh [$ff8a], a ; $44fe
	ldh [$ff8b], a ; $4500
	pop hl ; $4502
	push hl ; $4503
	call Func_1a_4852 ; $4504
	call Func_1a_4b1f ; $4507
	pop hl ; $450a
	ld a, h ; $450b
	cp a, $00 ; $450c
	jr nz, Label_1a_4527 ; $450e
	call Func_1a_4a7d ; $4510
	ld a, $0e ; $4513
	ld hl, $4779 ; $4515
	call RegisterFrameTask ; $4518
	call Func_1a_4bb9 ; $451b
	jp Label_1a_473e ; $451e
	INCBIN "data/bank_01a/d_4521.bin" ; $4521, 6 bytes
Label_1a_4527:
	pop af ; $4527
	wram_bank ; $4528
	pop hl ; $452c
	pop de ; $452d
	ld b, h ; $452e
	ldh a, [hWramBank] ; $452f
	push af ; $4531
	push hl ; $4532
	push de ; $4533
	ld a, b ; $4534
	call Func_1a_4fab ; $4535
	wram_bank $06 ; $4538
	push af ; $453e
	ld hl, wStoryModeNameOfMainCharacter ; $453f
	ld a, [$cb00] ; $4542
	or a, a ; $4545
	jr z, Label_1a_454a ; $4546
	ld l, $40 ; $4548
Label_1a_454a:
	ld a, l ; $454a
	add a, $18 ; $454b
	ld l, a ; $454d
	ld a, h ; $454e
	adc a, $00 ; $454f
	ld h, a ; $4551
	pop af ; $4552
	ld a, [hl] ; $4553
	cp a, $63 ; $4554
	jr z, Label_1a_455f ; $4556
	ld a, $02 ; $4558
	call Func_1a_4fab ; $455a
	jr Label_1a_4564 ; $455d
Label_1a_455f:
	ld a, $05 ; $455f
	call Func_1a_4fab ; $4561
Label_1a_4564:
	pop de ; $4564
	push de ; $4565
	wram_bank $06 ; $4566
	ld hl, $d230 ; $456c
	ld a, e ; $456f
	ld [hl+], a ; $4570
	ld [hl], d ; $4571
	inc hl ; $4572
	xor a, a ; $4573
	ld [hl+], a ; $4574
	ld [hl+], a ; $4575
	ld a, $1c ; $4576
	ld [hl+], a ; $4578
	ld a, $6c ; $4579
	ld [hl+], a ; $457b
	ld a, $ca ; $457c
	ld [hl+], a ; $457e
	ld a, $0f ; $457f
	ld [hl+], a ; $4581
	xor a, a ; $4582
	ld [hl+], a ; $4583
	ld [hl+], a ; $4584
	ld [hl], a ; $4585
	pop de ; $4586
	pop hl ; $4587
	push hl ; $4588
	push de ; $4589
	ld a, l ; $458a
	ld [$d254], a ; $458b
	ld de, $0000 ; $458e
	farcall FarPtr_GetExpRemainingToNextLevel ; $4591
	ld d, h ; $4594
	ld e, l ; $4595
	ld hl, $d23c ; $4596
	ld a, e ; $4599
	ld [hl+], a ; $459a
	ld [hl], d ; $459b
	ld hl, $d242 ; $459c
	ld a, e ; $459f
	ld [hl+], a ; $45a0
	ld [hl], d ; $45a1
	ld hl, $d23e ; $45a2
	ld a, $68 ; $45a5
	ld [hl+], a ; $45a7
	ld a, $84 ; $45a8
	ld [hl+], a ; $45aa
	ld a, $ca ; $45ab
	ld [hl+], a ; $45ad
	ld a, $08 ; $45ae
	ld [hl+], a ; $45b0
	xor a, a ; $45b1
	ld [$d23b], a ; $45b2
	ld [$d151], a ; $45b5
	wram_bank $01 ; $45b8
	ld hl, $d000 ; $45be
	ld de, $b800 ; $45c1
	ld c, $24 ; $45c4
	call Func_00_0480 ; $45c6
	ld hl, $d400 ; $45c9
	ld de, $9800 ; $45cc
	ld c, $24 ; $45cf
	call Func_00_0480 ; $45d1
	call Func_00_086c ; $45d4
	ld a, $0f ; $45d7
	ld hl, $477a ; $45d9
	call RegisterFrameTask ; $45dc
	call EnableLCD ; $45df
	ld c, $10 ; $45e2
	call Func_00_1d2e ; $45e4
	call Func_00_1da4 ; $45e7
	ld a, $0f ; $45ea
	ld hl, $4e65 ; $45ec
	call RegisterFrameTask ; $45ef
	wram_bank $06 ; $45f2
	pop de ; $45f8
	pop hl ; $45f9
	push hl ; $45fa
	push de ; $45fb
	ld a, h ; $45fc
	sub a, $04 ; $45fd
	jp z, Label_1a_46de ; $45ff
	ld hl, $d230 ; $4602
	ld a, [hl+] ; $4605
	ld h, [hl] ; $4606
	ld l, a ; $4607
	ld a, h ; $4608
	or a, l ; $4609
	jp z, Label_1a_46de ; $460a
Label_1a_460d:
	call Func_1a_4f30 ; $460d
	ld a, [$d238] ; $4610
	and a, a ; $4613
	jr nz, Label_1a_467b ; $4614
	ld a, [$d239] ; $4616
	and a, a ; $4619
	jr nz, Label_1a_462a ; $461a
	ldh a, [hPlayerInputFlags] ; $461c
	and a, $03 ; $461e
	jr nz, Label_1a_462a ; $4620
	sound $5e ; $4622
	call Func_00_2725 ; $4624
	db $04 ; $4627 inline arg
	jr Label_1a_460d ; $4628
Label_1a_462a:
	ld a, $01 ; $462a
	ld [$d239], a ; $462c
	sound $5f ; $462f
	call Func_1a_4f30 ; $4631
	ld hl, $d230 ; $4634
	ld a, [hl+] ; $4637
	ld h, [hl] ; $4638
	ld l, a ; $4639
	ld de, $fc18 ; $463a
	add hl, de ; $463d
	jr nc, Label_1a_4676 ; $463e
	ld hl, $d230 ; $4640
	ld a, [hl+] ; $4643
	ld h, [hl] ; $4644
	ld l, a ; $4645
	ld de, $d8f0 ; $4646
	add hl, de ; $4649
	jr nc, Label_1a_4664 ; $464a
	call Func_1a_4f30 ; $464c
	call Func_1a_4f30 ; $464f
	call Func_1a_4f30 ; $4652
	call Func_1a_4f30 ; $4655
	call Func_1a_4f30 ; $4658
	call Func_1a_4f30 ; $465b
	call Func_1a_4f30 ; $465e
	call Func_1a_4f30 ; $4661
Label_1a_4664:
	call Func_1a_4f30 ; $4664
	call Func_1a_4f30 ; $4667
	call Func_1a_4f30 ; $466a
	call Func_1a_4f30 ; $466d
	call Func_1a_4f30 ; $4670
	call Func_1a_4f30 ; $4673
Label_1a_4676:
	call AdvanceFrame ; $4676
	jr Label_1a_460d ; $4679
Label_1a_467b:
	sound $5f ; $467b
	ld a, [$c36f] ; $467d
	and a, a ; $4680
	jr z, Label_1a_46de ; $4681
	push af ; $4683
	wram_bank $06 ; $4684
	ld c, $00 ; $468a
	ld a, [$d000] ; $468c
	and a, a ; $468f
	jr nz, Label_1a_4694 ; $4690
	ld c, $fc ; $4692
Label_1a_4694:
	ld a, c ; $4694
	ld hl, $d23a ; $4695
	ld [hl], a ; $4698
	ld b, $28 ; $4699
Label_1a_469b:
	ld hl, $d23a ; $469b
	ld a, [hl] ; $469e
	and a, a ; $469f
	jr z, Label_1a_46a4 ; $46a0
	inc a ; $46a2
	ld [hl], a ; $46a3
Label_1a_46a4:
	call AdvanceFrame ; $46a4
	dec b ; $46a7
	jr z, Label_1a_46af ; $46a8
	ldh a, [$ff94] ; $46aa
	or a, a ; $46ac
	jr z, Label_1a_469b ; $46ad
Label_1a_46af:
	pop af ; $46af
	call Func_1a_50d3 ; $46b0
	sound $5f ; $46b3
	call Func_00_2725 ; $46b5
	db $14 ; $46b8 inline arg
	wram_bank $06 ; $46b9
	ld hl, $c370 ; $46bf
	ld a, [hl+] ; $46c2
	ld d, [hl] ; $46c3
	ld e, a ; $46c4
	ld hl, $d230 ; $46c5
	ld a, [hl+] ; $46c8
	ld h, [hl] ; $46c9
	ld l, a ; $46ca
	add hl, de ; $46cb
	ld d, h ; $46cc
	ld e, l ; $46cd
	ld hl, $d230 ; $46ce
	ld a, e ; $46d1
	ld [hl+], a ; $46d2
	ld [hl], d ; $46d3
	xor a, a ; $46d4
	ld [$c36f], a ; $46d5
	ld [$d238], a ; $46d8
	jp Label_1a_460d ; $46db
Label_1a_46de:
	wram_bank $06 ; $46de
	ld c, $00 ; $46e4
	ld a, [$d000] ; $46e6
	and a, a ; $46e9
	jr nz, Label_1a_46ee ; $46ea
	ld c, $fc ; $46ec
Label_1a_46ee:
	ld a, c ; $46ee
	ld hl, $d23a ; $46ef
	ld [hl], a ; $46f2
	ld b, $f0 ; $46f3
Label_1a_46f5:
	ld hl, $d23a ; $46f5
	ld a, [hl] ; $46f8
	and a, a ; $46f9
	jr z, Label_1a_46fe ; $46fa
	inc a ; $46fc
	ld [hl], a ; $46fd
Label_1a_46fe:
	call AdvanceFrame ; $46fe
	dec b ; $4701
	jr z, Label_1a_4709 ; $4702
	ldh a, [$ff94] ; $4704
	or a, a ; $4706
	jr z, Label_1a_46f5 ; $4707
Label_1a_4709:
	ld c, $10 ; $4709
	call Func_00_1d20 ; $470b
	call Func_00_1da4 ; $470e
	ld hl, $477a ; $4711
	call UnregisterFrameTask ; $4714
	ld hl, $4e65 ; $4717
	call UnregisterFrameTask ; $471a
	call AdvanceFrame ; $471d
	pop de ; $4720
	pop hl ; $4721
	pop af ; $4722
	wram_bank ; $4723
	pop bc ; $4727
	wram_bank $06 ; $4728
	ld hl, $d230 ; $472e
	ld a, [hl+] ; $4731
	ld d, [hl] ; $4732
	ld e, a ; $4733
	ld a, d ; $4734
	or a, e ; $4735
	ret z ; $4736
	ld a, [$d254] ; $4737
	farcall FarPtr_AddPlayerExp ; $473a
	ret ; $473d
Label_1a_473e:
	wram_bank $01 ; $473e
	ld hl, $d000 ; $4744
	ld de, $b800 ; $4747
	ld c, $24 ; $474a
	call Func_00_0480 ; $474c
	ld hl, $d400 ; $474f
	ld de, $9800 ; $4752
	ld c, $24 ; $4755
	call Func_00_0480 ; $4757
	call Func_00_086c ; $475a
	ld a, $0f ; $475d
	ld hl, $477a ; $475f
	call RegisterFrameTask ; $4762
	call EnableLCD ; $4765
	ld c, $10 ; $4768
	call Func_00_1d2e ; $476a
	call Func_00_1da4 ; $476d
	pop af ; $4770
	wram_bank ; $4771
	pop hl ; $4775
	pop de ; $4776
	pop bc ; $4777
	ret ; $4778
	INCBIN "data/bank_01a/d_4779.bin" ; $4779, 217 bytes
Func_1a_4852:
	wram_bank $01 ; $4852
	push hl ; $4858
	ld hl, $5530 ; $4859
	ld de, $d000 ; $485c
	call DecompressData ; $485f
	ld hl, $d000 ; $4862
	ld de, $b000 ; $4865
	ld c, $80 ; $4868
	call Func_00_0480 ; $486a
	ld hl, $d800 ; $486d
	ld de, $a800 ; $4870
	ld c, $50 ; $4873
	call Func_00_0480 ; $4875
	ld hl, $64e0 ; $4878
	ld de, $0008 ; $487b
	call Func_00_05e1 ; $487e
	wram_bank $01 ; $4881
	ld a, [wStoryModeMainCharacterOverworldSpriteColor] ; $4887
	ld d, $0e ; $488a
	farcall FarPtr_18_02 ; $488c
	ld a, [wStoryModeMainCharacterOverworldSprite] ; $488f
	ld b, $00 ; $4892
	wram_bank $01 ; $4894
	ld hl, $6680 ; $489a
	ld de, $d000 ; $489d
	call DecompressData ; $48a0
	ld hl, $d000 ; $48a3
	ld de, $ac00 ; $48a6
	ld c, $04 ; $48a9
	call Func_00_0480 ; $48ab
	ld hl, $66c8 ; $48ae
	ld de, $d000 ; $48b1
	call DecompressData ; $48b4
	ld hl, $d000 ; $48b7
	ld de, $ac40 ; $48ba
	ld c, $04 ; $48bd
	call Func_00_0480 ; $48bf
	ld hl, $6711 ; $48c2
	ld de, $0901 ; $48c5
	call Func_00_05e1 ; $48c8
	pop hl ; $48cb
	ld a, h ; $48cc
	cp a, $01 ; $48cd
	jr z, Label_1a_48f0 ; $48cf
	ld hl, $6650 ; $48d1
	ld de, $d000 ; $48d4
	call DecompressData ; $48d7
	ld hl, $d000 ; $48da
	ld de, $ac80 ; $48dd
	ld c, $02 ; $48e0
	call Func_00_0480 ; $48e2
	ld hl, $6668 ; $48e5
	ld de, $0a01 ; $48e8
	call Func_00_05e1 ; $48eb
	jr Label_1a_4933 ; $48ee
Label_1a_48f0:
	call Func_00_052e ; $48f0
	ld hl, $6721 ; $48f3
	ld de, $0f01 ; $48f6
	call Func_00_05e1 ; $48f9
	wram_bank $01 ; $48fc
	ld hl, $6729 ; $4902
	ld de, $de00 ; $4905
	call DecompressData ; $4908
	ld hl, $de00 ; $490b
	ld de, $aca0 ; $490e
	ld c, $14 ; $4911
	call Func_00_0480 ; $4913
	wram_bank $01 ; $4916
	ld hl, $5e20 ; $491c
	ld de, $d000 ; $491f
	ld c, $24 ; $4922
	call CopyMemoryFast ; $4924
	ld hl, $5be0 ; $4927
	ld de, $d400 ; $492a
	ld c, $24 ; $492d
	call CopyMemoryFast ; $492f
	ret ; $4932
Label_1a_4933:
	wram_bank $01 ; $4933
	ld hl, $62a0 ; $4939
	ld de, $d000 ; $493c
	ld c, $24 ; $493f
	call CopyMemoryFast ; $4941
	ld hl, $6060 ; $4944
	ld de, $d400 ; $4947
	ld c, $24 ; $494a
	call CopyMemoryFast ; $494c
	ret ; $494f
	INCBIN "data/bank_01a/d_4950.bin" ; $4950, 200 bytes
Func_1a_4a18:
	push af ; $4a18
	push bc ; $4a19
	push de ; $4a1a
	push hl ; $4a1b
	ld c, $00 ; $4a1c
	ld hl, $4950 ; $4a1e
Label_1a_4a21:
	ld a, c ; $4a21
	cp a, $05 ; $4a22
	jr z, Label_1a_4a3c ; $4a24
	ld b, $00 ; $4a26
Label_1a_4a28:
	ld a, b ; $4a28
	cp a, $14 ; $4a29
	jr z, Label_1a_4a39 ; $4a2b
	ld a, [hl] ; $4a2d
	ld d, a ; $4a2e
	inc hl ; $4a2f
	ld a, [hl] ; $4a30
	ld e, a ; $4a31
	call Func_1a_4c38 ; $4a32
	inc hl ; $4a35
	inc b ; $4a36
	jr Label_1a_4a28 ; $4a37
Label_1a_4a39:
	inc c ; $4a39
	jr Label_1a_4a21 ; $4a3a
Label_1a_4a3c:
	pop hl ; $4a3c
	pop de ; $4a3d
	pop bc ; $4a3e
	pop af ; $4a3f
	ret ; $4a40
	INCBIN "data/bank_01a/d_4a41.bin" ; $4a41, 60 bytes
Func_1a_4a7d:
	push af ; $4a7d
	push bc ; $4a7e
	push de ; $4a7f
	push hl ; $4a80
	ld bc, $0005 ; $4a81
	ld a, $00 ; $4a84
	ld hl, $4a41 ; $4a86
Label_1a_4a89:
	ld a, c ; $4a89
	cp a, $0a ; $4a8a
	jr z, Label_1a_4aa4 ; $4a8c
	ld b, $00 ; $4a8e
Label_1a_4a90:
	ld a, b ; $4a90
	cp a, $06 ; $4a91
	jr z, Label_1a_4aa1 ; $4a93
	ld a, [hl] ; $4a95
	ld d, a ; $4a96
	inc hl ; $4a97
	ld a, [hl] ; $4a98
	ld e, a ; $4a99
	call Func_1a_4c38 ; $4a9a
	inc hl ; $4a9d
	inc b ; $4a9e
	jr Label_1a_4a90 ; $4a9f
Label_1a_4aa1:
	inc c ; $4aa1
	jr Label_1a_4a89 ; $4aa2
Label_1a_4aa4:
	ld de, $d4c2 ; $4aa4
	ld hl, $04eb ; $4aa7
	ld c, $20 ; $4aaa
	farcall FarPtr_05_1c ; $4aac
	pop hl ; $4aaf
	pop de ; $4ab0
	pop bc ; $4ab1
	pop af ; $4ab2
	ret ; $4ab3
	INCBIN "data/bank_01a/d_4ab4.bin" ; $4ab4, 107 bytes
Func_1a_4b1f:
	push af ; $4b1f
	push bc ; $4b20
	push de ; $4b21
	push hl ; $4b22
	call Func_1a_4b96 ; $4b23
	wram_bank $01 ; $4b26
	push af ; $4b2c
	ld hl, wStoryModeNameOfMainCharacter ; $4b2d
	ld a, [$cb00] ; $4b30
	or a, a ; $4b33
	jr z, Label_1a_4b38 ; $4b34
	ld l, $40 ; $4b36
Label_1a_4b38:
	ld a, l ; $4b38
	add a, $00 ; $4b39
	ld l, a ; $4b3b
	ld a, h ; $4b3c
	adc a, $00 ; $4b3d
	ld h, a ; $4b3f
	pop af ; $4b40
	ld de, $d4c7 ; $4b41
	call Func_1a_4b73 ; $4b44
	push af ; $4b47
	ld hl, wStoryModeNameOfMainCharacter ; $4b48
	ld a, [$cb00] ; $4b4b
	or a, a ; $4b4e
	jr z, Label_1a_4b53 ; $4b4f
	ld l, $40 ; $4b51
Label_1a_4b53:
	ld a, l ; $4b53
	add a, $18 ; $4b54
	ld l, a ; $4b56
	ld a, h ; $4b57
	adc a, $00 ; $4b58
	ld h, a ; $4b5a
	pop af ; $4b5b
	ld a, [hl] ; $4b5c
	ld l, a ; $4b5d
	ld h, $00 ; $4b5e
	farcall FarPtr_05_48 ; $4b60
	ld de, $d507 ; $4b63
	ld hl, $04ed ; $4b66
	ld c, $20 ; $4b69
	farcall FarPtr_05_1c ; $4b6b
	pop hl ; $4b6e
	pop de ; $4b6f
	pop bc ; $4b70
	pop af ; $4b71
	ret ; $4b72
Func_1a_4b73:
	ld a, [hl+] ; $4b73
	or a, a ; $4b74
	ret z ; $4b75
	cp a, $de ; $4b76
	jr z, Label_1a_4b82 ; $4b78
	cp a, $df ; $4b7a
	jr z, Label_1a_4b82 ; $4b7c
	ld [de], a ; $4b7e
	inc de ; $4b7f
	jr Func_1a_4b73 ; $4b80
Label_1a_4b82:
	call Func_1a_4b8f ; $4b82
	ld [de], a ; $4b85
	ld a, $21 ; $4b86
	add a, e ; $4b88
	ld e, a ; $4b89
	jr nc, Label_1a_4b8d ; $4b8a
	inc d ; $4b8c
Label_1a_4b8d:
	jr Func_1a_4b73 ; $4b8d
Func_1a_4b8f:
	ld b, $21 ; $4b8f
Label_1a_4b91:
	dec de ; $4b91
	dec b ; $4b92
	jr nz, Label_1a_4b91 ; $4b93
	ret ; $4b95
Func_1a_4b96:
	push af ; $4b96
	push bc ; $4b97
	push de ; $4b98
	push hl ; $4b99
	ld c, $05 ; $4b9a
Label_1a_4b9c:
	ld a, c ; $4b9c
	cp a, $09 ; $4b9d
	jr z, Label_1a_4bb4 ; $4b9f
	ld b, $07 ; $4ba1
Label_1a_4ba3:
	ld a, b ; $4ba3
	cp a, $0d ; $4ba4
	jr z, Label_1a_4bb1 ; $4ba6
	ld de, $2000 ; $4ba8
	call Func_1a_4c38 ; $4bab
	inc b ; $4bae
	jr Label_1a_4ba3 ; $4baf
Label_1a_4bb1:
	inc c ; $4bb1
	jr Label_1a_4b9c ; $4bb2
Label_1a_4bb4:
	pop hl ; $4bb4
	pop de ; $4bb5
	pop bc ; $4bb6
	pop af ; $4bb7
	ret ; $4bb8
Func_1a_4bb9:
	ret ; $4bb9
	INCBIN "data/bank_01a/d_4bba.bin" ; $4bba, 22 bytes
Func_1a_4bd0:
	push af ; $4bd0
	push bc ; $4bd1
	push de ; $4bd2
	push hl ; $4bd3
Label_1a_4bd4:
	ld a, [hl] ; $4bd4
	cp a, $00 ; $4bd5
	jr z, Label_1a_4c1d ; $4bd7
	cp a, $9e ; $4bd9
	jr z, Label_1a_4bf1 ; $4bdb
	cp a, $9f ; $4bdd
	jr z, Label_1a_4bf1 ; $4bdf
	cp a, $de ; $4be1
	jr z, Label_1a_4bf1 ; $4be3
	cp a, $df ; $4be5
	jr z, Label_1a_4bf1 ; $4be7
	ld d, a ; $4be9
	call Func_1a_4c38 ; $4bea
	inc b ; $4bed
	inc hl ; $4bee
	jr Label_1a_4bd4 ; $4bef
Label_1a_4bf1:
	push bc ; $4bf1
	dec b ; $4bf2
	dec c ; $4bf3
	push af ; $4bf4
	ld a, c ; $4bf5
	cp a, $00 ; $4bf6
	jr z, Label_1a_4c03 ; $4bf8
	pop af ; $4bfa
	ld d, a ; $4bfb
	call Func_1a_4c38 ; $4bfc
	pop bc ; $4bff
	inc hl ; $4c00
	jr Label_1a_4bd4 ; $4c01
Label_1a_4c03:
	pop af ; $4c03
	push de ; $4c04
	cp a, $9e ; $4c05
	jr z, Label_1a_4c12 ; $4c07
	cp a, $de ; $4c09
	jr z, Label_1a_4c12 ; $4c0b
	ld de, $040b ; $4c0d
	jr Label_1a_4c15 ; $4c10
Label_1a_4c12:
	ld de, $030b ; $4c12
Label_1a_4c15:
	call Func_1a_4c38 ; $4c15
	pop de ; $4c18
	pop bc ; $4c19
	inc hl ; $4c1a
	jr Label_1a_4bd4 ; $4c1b
Label_1a_4c1d:
	pop hl ; $4c1d
	pop de ; $4c1e
	pop bc ; $4c1f
	pop af ; $4c20
	ret ; $4c21
Func_1a_4c22:
	push af ; $4c22
	push de ; $4c23
	ld hl, $0020 ; $4c24
	ld a, c ; $4c27
	call MulHLByA ; $4c28
	ld d, $00 ; $4c2b
	ld e, b ; $4c2d
	add hl, de ; $4c2e
	push hl ; $4c2f
	pop de ; $4c30
	ld hl, $d000 ; $4c31
	add hl, de ; $4c34
	pop de ; $4c35
	pop af ; $4c36
	ret ; $4c37
Func_1a_4c38:
	push af ; $4c38
	push bc ; $4c39
	push de ; $4c3a
	push hl ; $4c3b
	ldh a, [hWramBank] ; $4c3c
	push af ; $4c3e
	wram_bank $01 ; $4c3f
	call Func_1a_4c22 ; $4c45
	ld a, e ; $4c48
	ld [hl], a ; $4c49
	push de ; $4c4a
	ld de, $0400 ; $4c4b
	add hl, de ; $4c4e
	pop de ; $4c4f
	ld a, d ; $4c50
	ld [hl], a ; $4c51
	pop af ; $4c52
	wram_bank ; $4c53
	pop hl ; $4c57
	pop de ; $4c58
	pop bc ; $4c59
	pop af ; $4c5a
	ret ; $4c5b
	INCBIN "data/bank_01a/d_4c5c.bin" ; $4c5c, 724 bytes
Func_1a_4f30:
	wram_bank $06 ; $4f30
	ld a, [$d238] ; $4f36
	and a, a ; $4f39
	jr nz, Label_1a_4f5c ; $4f3a
	ld hl, $d232 ; $4f3c
	ld a, [hl+] ; $4f3f
	ld d, [hl] ; $4f40
	ld e, a ; $4f41
	inc de ; $4f42
	dec hl ; $4f43
	ld a, e ; $4f44
	ld [hl+], a ; $4f45
	ld [hl], d ; $4f46
	ld hl, $d230 ; $4f47
	ld a, [hl+] ; $4f4a
	ld h, [hl] ; $4f4b
	ld l, a ; $4f4c
	ld a, l ; $4f4d
	sub a, e ; $4f4e
	ld l, a ; $4f4f
	ld a, h ; $4f50
	sbc a, d ; $4f51
	ld h, a ; $4f52
	ld a, h ; $4f53
	or a, l ; $4f54
	jr nz, Label_1a_4f5c ; $4f55
	ld a, $01 ; $4f57
	ld [$d238], a ; $4f59
Label_1a_4f5c:
	ld hl, $d232 ; $4f5c
	ld a, [hl+] ; $4f5f
	ld b, [hl] ; $4f60
	ld c, a ; $4f61
	ld hl, $d23c ; $4f62
	ld a, [hl+] ; $4f65
	ld h, [hl] ; $4f66
	ld l, a ; $4f67
	ld a, l ; $4f68
	sub a, c ; $4f69
	ld l, a ; $4f6a
	ld a, h ; $4f6b
	sbc a, b ; $4f6c
	ld h, a ; $4f6d
	bit 7, h ; $4f6e
	jr nz, Label_1a_4f7b ; $4f70
	ld d, h ; $4f72
	ld e, l ; $4f73
	ld hl, $d242 ; $4f74
	ld a, e ; $4f77
	ld [hl+], a ; $4f78
	ld [hl], d ; $4f79
	ret ; $4f7a
Label_1a_4f7b:
	xor a, a ; $4f7b
	ld hl, $d242 ; $4f7c
	ld [hl+], a ; $4f7f
	ld [hl+], a ; $4f80
	ret ; $4f81
	INCBIN "data/bank_01a/d_4f82.bin" ; $4f82, 41 bytes
Func_1a_4fab:
	and a, a ; $4fab
	jr z, Label_1a_4fbf ; $4fac
	dec a ; $4fae
	jr z, Label_1a_4fd7 ; $4faf
	dec a ; $4fb1
	jr z, Label_1a_5000 ; $4fb2
	dec a ; $4fb4
	jr z, Label_1a_5018 ; $4fb5
	dec a ; $4fb7
	jr z, Label_1a_502c ; $4fb8
	dec a ; $4fba
	jp z, Label_1a_5044 ; $4fbb
	ret ; $4fbe
Label_1a_4fbf:
	ld hl, $04ee ; $4fbf
	call Func_1a_505e ; $4fc2
	wram_bank $01 ; $4fc5
	ld hl, $d800 ; $4fcb
	ld bc, $0302 ; $4fce
	ld e, $01 ; $4fd1
	call Func_1a_4bd0 ; $4fd3
	ret ; $4fd6
Label_1a_4fd7:
	ld hl, $04ef ; $4fd7
	call Func_1a_505e ; $4fda
	wram_bank $01 ; $4fdd
	ld hl, $d800 ; $4fe3
	ld bc, $0101 ; $4fe6
	ld e, $01 ; $4fe9
	call Func_1a_4bd0 ; $4feb
	ld hl, $04f0 ; $4fee
	call Func_1a_505e ; $4ff1
	ld hl, $d800 ; $4ff4
	ld bc, $0103 ; $4ff7
	ld e, $01 ; $4ffa
	call Func_1a_4bd0 ; $4ffc
	ret ; $4fff
Label_1a_5000:
	ld hl, $04f1 ; $5000
	call Func_1a_505e ; $5003
	wram_bank $01 ; $5006
	ld hl, $d800 ; $500c
	ld bc, $0110 ; $500f
	ld e, $01 ; $5012
	call Func_1a_4bd0 ; $5014
	ret ; $5017
Label_1a_5018:
	wram_bank $03 ; $5018
	ld hl, $04f2 ; $501e
	ld de, $d82b ; $5021
	ld c, $20 ; $5024
	farcall FarPtr_05_1c ; $5026
	sound $73 ; $5029
	ret ; $502b
Label_1a_502c:
	ld hl, $04f3 ; $502c
	call Func_1a_505e ; $502f
	wram_bank $01 ; $5032
	ld hl, $d800 ; $5038
	ld bc, $0302 ; $503b
	ld e, $01 ; $503e
	call Func_1a_4bd0 ; $5040
	ret ; $5043
Label_1a_5044:
	sound $00 ; $5044
	ld hl, $04f4 ; $5046
	call Func_1a_505e ; $5049
	wram_bank $01 ; $504c
	ld hl, $d800 ; $5052
	ld bc, $0a10 ; $5055
	ld e, $01 ; $5058
	call Func_1a_4bd0 ; $505a
	ret ; $505d
Func_1a_505e:
	wram_bank $05 ; $505e
	farcall FarPtr_FetchDialogueText ; $5064
	ld hl, wTextBuffer ; $5067
	ld de, $d800 ; $506a
Label_1a_506d:
	wram_bank $05 ; $506d
	ld b, [hl] ; $5073
	wram_bank $01 ; $5074
	ld a, b ; $507a
	ld [de], a ; $507b
	inc hl ; $507c
	inc de ; $507d
	and a, a ; $507e
	jr nz, Label_1a_506d ; $507f
	ret ; $5081
Func_1a_5082:
	push af ; $5082
	push bc ; $5083
	push de ; $5084
	push hl ; $5085
	ldh a, [hWramBank] ; $5086
	push af ; $5088
	wram_bank $06 ; $5089
	xor a, a ; $508f
	ld [$d000], a ; $5090
	pop af ; $5093
	wram_bank ; $5094
	pop hl ; $5098
	pop de ; $5099
	pop bc ; $509a
	pop af ; $509b
	push af ; $509c
	push bc ; $509d
	push de ; $509e
	push hl ; $509f
	ldh a, [hWramBank] ; $50a0
	push af ; $50a2
	ld a, $01 ; $50a3
	call Func_1a_44d8 ; $50a5
	wram_bank $06 ; $50a8
	ld a, [$d23b] ; $50ae
	and a, a ; $50b1
	jr z, Label_1a_50c9 ; $50b2
	wram_bank $06 ; $50b4
	ld a, $01 ; $50ba
	ld [$d000], a ; $50bc
	ld a, $01 ; $50bf
	ld de, $0000 ; $50c1
	ld h, $04 ; $50c4
	call Func_1a_44d8 ; $50c6
Label_1a_50c9:
	pop af ; $50c9
	wram_bank ; $50ca
	pop hl ; $50ce
	pop de ; $50cf
	pop bc ; $50d0
	pop af ; $50d1
	ret ; $50d2
Func_1a_50d3:
	push af ; $50d3
	call Func_1a_4a18 ; $50d4
	pop af ; $50d7
	cp a, $01 ; $50d8
	jp z, Label_1a_5121 ; $50da
	cp a, $02 ; $50dd
	jp z, Label_1a_513b ; $50df
	cp a, $03 ; $50e2
	jp z, Label_1a_5155 ; $50e4
	cp a, $14 ; $50e7
	jp z, Label_1a_516f ; $50e9
	cp a, $15 ; $50ec
	jp z, Label_1a_51b7 ; $50ee
	cp a, $16 ; $50f1
	jp z, Label_1a_51ff ; $50f3
	cp a, $17 ; $50f6
	jp z, Label_1a_5247 ; $50f8
	cp a, $18 ; $50fb
	jp z, Label_1a_528f ; $50fd
	cp a, $19 ; $5100
	jp z, Label_1a_52d7 ; $5102
	cp a, $1a ; $5105
	jp z, Label_1a_531f ; $5107
	cp a, $1b ; $510a
	jp z, Label_1a_5367 ; $510c
	cp a, $1c ; $510f
	jp z, Label_1a_53af ; $5111
	cp a, $1d ; $5114
	jp z, Label_1a_53f7 ; $5116
	cp a, $1e ; $5119
	jp z, Label_1a_543f ; $511b
	jp Label_1a_5486 ; $511e
Label_1a_5121:
	ld hl, $04f5 ; $5121
	call Func_1a_505e ; $5124
	wram_bank $01 ; $5127
	ld hl, $d800 ; $512d
	ld bc, $0201 ; $5130
	ld e, $01 ; $5133
	call Func_1a_4bd0 ; $5135
	jp Label_1a_54cd ; $5138
Label_1a_513b:
	ld hl, $04f6 ; $513b
	call Func_1a_505e ; $513e
	wram_bank $01 ; $5141
	ld hl, $d800 ; $5147
	ld bc, $0201 ; $514a
	ld e, $01 ; $514d
	call Func_1a_4bd0 ; $514f
	jp Label_1a_54cd ; $5152
Label_1a_5155:
	ld hl, $04f7 ; $5155
	call Func_1a_505e ; $5158
	wram_bank $01 ; $515b
	ld hl, $d800 ; $5161
	ld bc, $0201 ; $5164
	ld e, $01 ; $5167
	call Func_1a_4bd0 ; $5169
	jp Label_1a_54cd ; $516c
Label_1a_516f:
	ld hl, $04f8 ; $516f
	call Func_1a_505e ; $5172
	wram_bank $01 ; $5175
	ld hl, $d800 ; $517b
	ld bc, $0201 ; $517e
	ld e, $01 ; $5181
	call Func_1a_4bd0 ; $5183
	ld hl, $001f ; $5186
	call Func_1a_505e ; $5189
	wram_bank $01 ; $518c
	ld hl, $d800 ; $5192
	ld bc, $0601 ; $5195
	ld e, $01 ; $5198
	call Func_1a_4bd0 ; $519a
	ld hl, $04f9 ; $519d
	call Func_1a_505e ; $51a0
	wram_bank $01 ; $51a3
	ld hl, $d800 ; $51a9
	ld bc, $0901 ; $51ac
	ld e, $01 ; $51af
	call Func_1a_4bd0 ; $51b1
	jp Label_1a_54cd ; $51b4
Label_1a_51b7:
	ld hl, $04f8 ; $51b7
	call Func_1a_505e ; $51ba
	wram_bank $01 ; $51bd
	ld hl, $d800 ; $51c3
	ld bc, $0201 ; $51c6
	ld e, $01 ; $51c9
	call Func_1a_4bd0 ; $51cb
	ld hl, $0020 ; $51ce
	call Func_1a_505e ; $51d1
	wram_bank $01 ; $51d4
	ld hl, $d800 ; $51da
	ld bc, $0601 ; $51dd
	ld e, $01 ; $51e0
	call Func_1a_4bd0 ; $51e2
	ld hl, $04f9 ; $51e5
	call Func_1a_505e ; $51e8
	wram_bank $01 ; $51eb
	ld hl, $d800 ; $51f1
	ld bc, $0a01 ; $51f4
	ld e, $01 ; $51f7
	call Func_1a_4bd0 ; $51f9
	jp Label_1a_54cd ; $51fc
Label_1a_51ff:
	ld hl, $04f8 ; $51ff
	call Func_1a_505e ; $5202
	wram_bank $01 ; $5205
	ld hl, $d800 ; $520b
	ld bc, $0201 ; $520e
	ld e, $01 ; $5211
	call Func_1a_4bd0 ; $5213
	ld hl, $0021 ; $5216
	call Func_1a_505e ; $5219
	wram_bank $01 ; $521c
	ld hl, $d800 ; $5222
	ld bc, $0601 ; $5225
	ld e, $01 ; $5228
	call Func_1a_4bd0 ; $522a
	ld hl, $04f9 ; $522d
	call Func_1a_505e ; $5230
	wram_bank $01 ; $5233
	ld hl, $d800 ; $5239
	ld bc, $0a01 ; $523c
	ld e, $01 ; $523f
	call Func_1a_4bd0 ; $5241
	jp Label_1a_54cd ; $5244
Label_1a_5247:
	ld hl, $04f8 ; $5247
	call Func_1a_505e ; $524a
	wram_bank $01 ; $524d
	ld hl, $d800 ; $5253
	ld bc, $0201 ; $5256
	ld e, $01 ; $5259
	call Func_1a_4bd0 ; $525b
	ld hl, $0022 ; $525e
	call Func_1a_505e ; $5261
	wram_bank $01 ; $5264
	ld hl, $d800 ; $526a
	ld bc, $0601 ; $526d
	ld e, $01 ; $5270
	call Func_1a_4bd0 ; $5272
	ld hl, $04f9 ; $5275
	call Func_1a_505e ; $5278
	wram_bank $01 ; $527b
	ld hl, $d800 ; $5281
	ld bc, $0901 ; $5284
	ld e, $01 ; $5287
	call Func_1a_4bd0 ; $5289
	jp Label_1a_54cd ; $528c
Label_1a_528f:
	ld hl, $04f8 ; $528f
	call Func_1a_505e ; $5292
	wram_bank $01 ; $5295
	ld hl, $d800 ; $529b
	ld bc, $0201 ; $529e
	ld e, $01 ; $52a1
	call Func_1a_4bd0 ; $52a3
	ld hl, $0023 ; $52a6
	call Func_1a_505e ; $52a9
	wram_bank $01 ; $52ac
	ld hl, $d800 ; $52b2
	ld bc, $0601 ; $52b5
	ld e, $01 ; $52b8
	call Func_1a_4bd0 ; $52ba
	ld hl, $04f9 ; $52bd
	call Func_1a_505e ; $52c0
	wram_bank $01 ; $52c3
	ld hl, $d800 ; $52c9
	ld bc, $0901 ; $52cc
	ld e, $01 ; $52cf
	call Func_1a_4bd0 ; $52d1
	jp Label_1a_54cd ; $52d4
Label_1a_52d7:
	ld hl, $04f8 ; $52d7
	call Func_1a_505e ; $52da
	wram_bank $01 ; $52dd
	ld hl, $d800 ; $52e3
	ld bc, $0201 ; $52e6
	ld e, $01 ; $52e9
	call Func_1a_4bd0 ; $52eb
	ld hl, $0024 ; $52ee
	call Func_1a_505e ; $52f1
	wram_bank $01 ; $52f4
	ld hl, $d800 ; $52fa
	ld bc, $0601 ; $52fd
	ld e, $01 ; $5300
	call Func_1a_4bd0 ; $5302
	ld hl, $04f9 ; $5305
	call Func_1a_505e ; $5308
	wram_bank $01 ; $530b
	ld hl, $d800 ; $5311
	ld bc, $0a01 ; $5314
	ld e, $01 ; $5317
	call Func_1a_4bd0 ; $5319
	jp Label_1a_54cd ; $531c
Label_1a_531f:
	ld hl, $04f8 ; $531f
	call Func_1a_505e ; $5322
	wram_bank $01 ; $5325
	ld hl, $d800 ; $532b
	ld bc, $0201 ; $532e
	ld e, $01 ; $5331
	call Func_1a_4bd0 ; $5333
	ld hl, $0025 ; $5336
	call Func_1a_505e ; $5339
	wram_bank $01 ; $533c
	ld hl, $d800 ; $5342
	ld bc, $0601 ; $5345
	ld e, $01 ; $5348
	call Func_1a_4bd0 ; $534a
	ld hl, $04f9 ; $534d
	call Func_1a_505e ; $5350
	wram_bank $01 ; $5353
	ld hl, $d800 ; $5359
	ld bc, $0a01 ; $535c
	ld e, $01 ; $535f
	call Func_1a_4bd0 ; $5361
	jp Label_1a_54cd ; $5364
Label_1a_5367:
	ld hl, $04f8 ; $5367
	call Func_1a_505e ; $536a
	wram_bank $01 ; $536d
	ld hl, $d800 ; $5373
	ld bc, $0201 ; $5376
	ld e, $01 ; $5379
	call Func_1a_4bd0 ; $537b
	ld hl, $0026 ; $537e
	call Func_1a_505e ; $5381
	wram_bank $01 ; $5384
	ld hl, $d800 ; $538a
	ld bc, $0601 ; $538d
	ld e, $01 ; $5390
	call Func_1a_4bd0 ; $5392
	ld hl, $04f9 ; $5395
	call Func_1a_505e ; $5398
	wram_bank $01 ; $539b
	ld hl, $d800 ; $53a1
	ld bc, $0901 ; $53a4
	ld e, $01 ; $53a7
	call Func_1a_4bd0 ; $53a9
	jp Label_1a_54cd ; $53ac
Label_1a_53af:
	ld hl, $04f8 ; $53af
	call Func_1a_505e ; $53b2
	wram_bank $01 ; $53b5
	ld hl, $d800 ; $53bb
	ld bc, $0201 ; $53be
	ld e, $01 ; $53c1
	call Func_1a_4bd0 ; $53c3
	ld hl, $0027 ; $53c6
	call Func_1a_505e ; $53c9
	wram_bank $01 ; $53cc
	ld hl, $d800 ; $53d2
	ld bc, $0601 ; $53d5
	ld e, $01 ; $53d8
	call Func_1a_4bd0 ; $53da
	ld hl, $04f9 ; $53dd
	call Func_1a_505e ; $53e0
	wram_bank $01 ; $53e3
	ld hl, $d800 ; $53e9
	ld bc, $0901 ; $53ec
	ld e, $01 ; $53ef
	call Func_1a_4bd0 ; $53f1
	jp Label_1a_54cd ; $53f4
Label_1a_53f7:
	ld hl, $04f8 ; $53f7
	call Func_1a_505e ; $53fa
	wram_bank $01 ; $53fd
	ld hl, $d800 ; $5403
	ld bc, $0201 ; $5406
	ld e, $01 ; $5409
	call Func_1a_4bd0 ; $540b
	ld hl, $0028 ; $540e
	call Func_1a_505e ; $5411
	wram_bank $01 ; $5414
	ld hl, $d800 ; $541a
	ld bc, $0601 ; $541d
	ld e, $01 ; $5420
	call Func_1a_4bd0 ; $5422
	ld hl, $04f9 ; $5425
	call Func_1a_505e ; $5428
	wram_bank $01 ; $542b
	ld hl, $d800 ; $5431
	ld bc, $0a01 ; $5434
	ld e, $01 ; $5437
	call Func_1a_4bd0 ; $5439
	jp Label_1a_54cd ; $543c
Label_1a_543f:
	ld hl, $04f8 ; $543f
	call Func_1a_505e ; $5442
	wram_bank $01 ; $5445
	ld hl, $d800 ; $544b
	ld bc, $0201 ; $544e
	ld e, $01 ; $5451
	call Func_1a_4bd0 ; $5453
	ld hl, $0029 ; $5456
	call Func_1a_505e ; $5459
	wram_bank $01 ; $545c
	ld hl, $d800 ; $5462
	ld bc, $0601 ; $5465
	ld e, $01 ; $5468
	call Func_1a_4bd0 ; $546a
	ld hl, $04f9 ; $546d
	call Func_1a_505e ; $5470
	wram_bank $01 ; $5473
	ld hl, $d800 ; $5479
	ld bc, $0b01 ; $547c
	ld e, $01 ; $547f
	call Func_1a_4bd0 ; $5481
	jr Label_1a_54cd ; $5484
Label_1a_5486:
	ld hl, $04f8 ; $5486
	call Func_1a_505e ; $5489
	wram_bank $01 ; $548c
	ld hl, $d800 ; $5492
	ld bc, $0201 ; $5495
	ld e, $01 ; $5498
	call Func_1a_4bd0 ; $549a
	ld hl, $002a ; $549d
	call Func_1a_505e ; $54a0
	wram_bank $01 ; $54a3
	ld hl, $d800 ; $54a9
	ld bc, $0601 ; $54ac
	ld e, $01 ; $54af
	call Func_1a_4bd0 ; $54b1
	ld hl, $04f9 ; $54b4
	call Func_1a_505e ; $54b7
	wram_bank $01 ; $54ba
	ld hl, $d800 ; $54c0
	ld bc, $0901 ; $54c3
	ld e, $01 ; $54c6
	call Func_1a_4bd0 ; $54c8
	jr Label_1a_54cd ; $54cb
Label_1a_54cd:
	ld hl, $04f4 ; $54cd
	call Func_1a_505e ; $54d0
	wram_bank $01 ; $54d3
	ld hl, $d800 ; $54d9
	ld bc, $0203 ; $54dc
	ld e, $01 ; $54df
	call Func_1a_4bd0 ; $54e1
	wram_bank $06 ; $54e4
	ld a, [$d151] ; $54ea
	or a, $01 ; $54ed
	ld [$d151], a ; $54ef
	call AdvanceFrame ; $54f2
	wram_bank $01 ; $54f5
	ld hl, $d000 ; $54fb
	ld de, $b800 ; $54fe
	ld c, $08 ; $5501
	call Func_00_0480 ; $5503
	ld hl, $d400 ; $5506
	ld de, $9800 ; $5509
	ld c, $08 ; $550c
	call Func_00_0480 ; $550e
	call AdvanceFrame ; $5511
	wram_bank $06 ; $5514
	ld a, [$d151] ; $551a
	and a, $fe ; $551d
	ld [$d151], a ; $551f
	ret ; $5522
	INCBIN "data/bank_01a/d_5523.bin" ; $5523, 4785 bytes
Func_1a_67d4:
	xor a, a ; $67d4
	ld [$cb62], a ; $67d5
	ld [$cb63], a ; $67d8
Label_1a_67db:
	call ClearFrameTasks ; $67db
	call DisableLCDSafely ; $67de
	farcall FarPtr_01_0a ; $67e1
	xor a, a ; $67e4
	ldh [$ff8b], a ; $67e5
	ldh [$ff8a], a ; $67e7
	ld [$c320], a ; $67e9
	ld [$c321], a ; $67ec
	ld [$c322], a ; $67ef
	ld [$c323], a ; $67f2
	ld a, $90 ; $67f5
	ldh [rWY], a ; $67f7
	call Func_00_1e1d ; $67f9
	farcall FarPtr_InitActorEngine ; $67fc
	farcall FarPtr_05_76 ; $67ff
	call Func_1a_686c ; $6802
	cp a, $ff ; $6805
	jr z, Label_1a_6854 ; $6807
	ld c, $40 ; $6809
	call Func_00_1d20 ; $680b
	call Func_00_1da4 ; $680e
	call DisableLCDSafely ; $6811
	call Func_1a_6c0b ; $6814
	call Func_1a_6b2f ; $6817
	call Func_1a_6f3d ; $681a
	call EnableLCD ; $681d
	ld a, $01 ; $6820
	ld hl, $6c28 ; $6822
	call RegisterFrameTask ; $6825
	call Func_1a_70c0 ; $6828
	call Func_1a_6e41 ; $682b
	call AdvanceFrame ; $682e
	wram_bank $06 ; $6831
	ld a, [$d002] ; $6837
	ld de, $8700 ; $683a
	farcall FarPtr_18_44 ; $683d
	call AdvanceFrame ; $6840
	ld c, $10 ; $6843
	call Func_00_1d2e ; $6845
	call Func_00_1da4 ; $6848
	call Func_1a_6c9f ; $684b
	ld hl, $6c28 ; $684e
	call UnregisterFrameTask ; $6851
Label_1a_6854:
	ld c, $10 ; $6854
	call Func_00_1d20 ; $6856
	call Func_00_1da4 ; $6859
	call DisableLCDSafely ; $685c
	farcall FarPtr_01_0a ; $685f
	call EnableLCD ; $6862
	call AdvanceFrame ; $6865
	jp Label_1a_67db ; $6868
	ret ; $686b
Func_1a_686c:
	wram_bank $06 ; $686c
	xor a, a ; $6872
	ld hl, $70d9 ; $6873
	ld de, $0008 ; $6876
	call LoadPaletteShadow ; $6879
	ld hl, $70d9 ; $687c
	ld de, $0808 ; $687f
	call LoadPaletteShadow ; $6882
	wram_bank $01 ; $6885
	ld hl, $7119 ; $688b
	ld de, $d000 ; $688e
	call DecompressData ; $6891
	ld hl, $d000 ; $6894
	ld de, $b000 ; $6897
	ld c, $80 ; $689a
	call Func_00_0480 ; $689c
	ld hl, $d800 ; $689f
	ld de, $a800 ; $68a2
	ld c, $80 ; $68a5
	call Func_00_0480 ; $68a7
	call Func_1a_69eb ; $68aa
	ld a, [$cb62] ; $68ad
	call Func_1a_6a3a ; $68b0
	wram_bank $03 ; $68b3
	ld hl, $d000 ; $68b9
	ld de, $9800 ; $68bc
	ld c, $24 ; $68bf
	call Func_00_0480 ; $68c1
	wram_bank $02 ; $68c4
	ld hl, $d000 ; $68ca
	ld de, $b800 ; $68cd
	ld c, $24 ; $68d0
	call Func_00_0480 ; $68d2
	call EnableLCD ; $68d5
	ld a, $01 ; $68d8
	ld hl, $6ab3 ; $68da
	call RegisterFrameTask ; $68dd
	ld c, $10 ; $68e0
	call Func_00_1d2e ; $68e2
	call Func_00_1da4 ; $68e5
Label_1a_68e8:
	wram_bank $06 ; $68e8
	call AdvanceFrame ; $68ee
	ldh a, [hInputPressed] ; $68f1
	bit 6, a ; $68f3
	jr nz, Label_1a_691b ; $68f5
	bit 7, a ; $68f7
	jr nz, Label_1a_6934 ; $68f9
	bit 5, a ; $68fb
	jr nz, Label_1a_694c ; $68fd
	bit 4, a ; $68ff
	jr nz, Label_1a_6979 ; $6901
	bit 0, a ; $6903
	jp nz, Label_1a_69c8 ; $6905
	bit 1, a ; $6908
	jp nz, Label_1a_69e0 ; $690a
	jr Label_1a_68e8 ; $690d
	INCBIN "data/bank_01a/d_690f.bin" ; $690f, 12 bytes
Label_1a_691b:
	ld a, [$cb63] ; $691b
	dec a ; $691e
	cp a, $ff ; $691f
	jr z, Label_1a_692b ; $6921
	cp a, $07 ; $6923
	jr nz, Label_1a_692d ; $6925
	ld a, $0f ; $6927
	jr Label_1a_692d ; $6929
Label_1a_692b:
	ld a, $07 ; $692b
Label_1a_692d:
	ld [$cb63], a ; $692d
	sound $5e ; $6930
	jr Label_1a_68e8 ; $6932
Label_1a_6934:
	ld a, [$cb63] ; $6934
	inc a ; $6937
	cp a, $08 ; $6938
	jr z, Label_1a_6944 ; $693a
	cp a, $10 ; $693c
	jr nz, Label_1a_6945 ; $693e
	ld a, $08 ; $6940
	jr Label_1a_6945 ; $6942
Label_1a_6944:
	xor a, a ; $6944
Label_1a_6945:
	ld [$cb63], a ; $6945
	sound $5e ; $6948
	jr Label_1a_68e8 ; $694a
Label_1a_694c:
	ld a, [$cb63] ; $694c
	sub a, $08 ; $694f
	jr nc, Label_1a_6966 ; $6951
	add a, $10 ; $6953
	ld [$cb63], a ; $6955
	ld a, [$cb62] ; $6958
	or a, a ; $695b
	jr z, Label_1a_696e ; $695c
	dec a ; $695e
	ld [$cb62], a ; $695f
	sound $5e ; $6962
	jr Label_1a_69a9 ; $6964
Label_1a_6966:
	ld [$cb63], a ; $6966
	sound $5e ; $6969
	jp Label_1a_68e8 ; $696b
Label_1a_696e:
	ld a, [$cb63] ; $696e
	sub a, $08 ; $6971
	ld [$cb63], a ; $6973
	jp Label_1a_68e8 ; $6976
Label_1a_6979:
	ld a, [$cb63] ; $6979
	add a, $08 ; $697c
	cp a, $10 ; $697e
	jr c, Label_1a_6996 ; $6980
	sub a, $10 ; $6982
	ld [$cb63], a ; $6984
	ld a, [$cb62] ; $6987
	cp a, $01 ; $698a
	jr z, Label_1a_699e ; $698c
	inc a ; $698e
	ld [$cb62], a ; $698f
	sound $5e ; $6992
	jr Label_1a_69a9 ; $6994
Label_1a_6996:
	ld [$cb63], a ; $6996
	sound $5e ; $6999
	jp Label_1a_68e8 ; $699b
Label_1a_699e:
	ld a, [$cb63] ; $699e
	add a, $08 ; $69a1
	ld [$cb63], a ; $69a3
	jp Label_1a_68e8 ; $69a6
Label_1a_69a9:
	push af ; $69a9
	call Func_1a_69eb ; $69aa
	pop af ; $69ad
	call Func_1a_6a3a ; $69ae
	wram_bank $03 ; $69b1
	ld hl, $d020 ; $69b7
	ld de, $9820 ; $69ba
	ld c, $20 ; $69bd
	call Func_00_0480 ; $69bf
	call AdvanceFrame ; $69c2
	jp Label_1a_68e8 ; $69c5
Label_1a_69c8:
	ld hl, $6ab3 ; $69c8
	call UnregisterFrameTask ; $69cb
	sound $5f ; $69ce
	ld a, [$cb62] ; $69d0
	rlca ; $69d3
	rlca ; $69d4
	rlca ; $69d5
	rlca ; $69d6
	ld b, a ; $69d7
	ld a, [$cb63] ; $69d8
	add a, b ; $69db
	ld [$d002], a ; $69dc
	ret ; $69df
Label_1a_69e0:
	ld hl, $6ab3 ; $69e0
	call UnregisterFrameTask ; $69e3
	sound $62 ; $69e6
	ld a, $ff ; $69e8
	ret ; $69ea
Func_1a_69eb:
	wram_bank $01 ; $69eb
	ld hl, $78b2 ; $69f1
	ld de, $d000 ; $69f4
	call DecompressData ; $69f7
	ld hl, $d000 ; $69fa
	ld bc, $0240 ; $69fd
	call Func_1a_6be1 ; $6a00
	wram_bank $01 ; $6a03
	ld hl, $78ec ; $6a09
	ld de, $d000 ; $6a0c
	call DecompressData ; $6a0f
	ld hl, $d000 ; $6a12
	ld bc, $0240 ; $6a15
	call Func_1a_6bf6 ; $6a18
	wram_bank $02 ; $6a1b
	ld hl, $d021 ; $6a21
	ld c, $10 ; $6a24
Label_1a_6a26:
	push hl ; $6a26
	ld b, $12 ; $6a27
Label_1a_6a29:
	xor a, a ; $6a29
	ld [hl+], a ; $6a2a
	dec b ; $6a2b
	jr nz, Label_1a_6a29 ; $6a2c
	pop hl ; $6a2e
	ld a, $20 ; $6a2f
	add a, l ; $6a31
	ld l, a ; $6a32
	jr nc, Label_1a_6a36 ; $6a33
	inc h ; $6a35
Label_1a_6a36:
	dec c ; $6a36
	jr nz, Label_1a_6a26 ; $6a37
	ret ; $6a39
Func_1a_6a3a:
	or a, a ; $6a3a
	jr z, Label_1a_6a44 ; $6a3b
	dec a ; $6a3d
	jr z, Label_1a_6a61 ; $6a3e
	dec a ; $6a40
	jr z, Label_1a_6a7e ; $6a41
	ret ; $6a43
Label_1a_6a44:
	wram_bank $03 ; $6a44
	ld hl, $001b ; $6a4a
	ld de, $d043 ; $6a4d
	ld c, $08 ; $6a50
	call Func_1a_6a9b ; $6a52
	ld hl, $0023 ; $6a55
	ld de, $d04b ; $6a58
	ld c, $08 ; $6a5b
	call Func_1a_6a9b ; $6a5d
	ret ; $6a60
Label_1a_6a61:
	wram_bank $03 ; $6a61
	ld hl, $002b ; $6a67
	ld de, $d043 ; $6a6a
	ld c, $08 ; $6a6d
	call Func_1a_6a9b ; $6a6f
	ld hl, $0033 ; $6a72
	ld de, $d04b ; $6a75
	ld c, $08 ; $6a78
	call Func_1a_6a9b ; $6a7a
	ret ; $6a7d
Label_1a_6a7e:
	wram_bank $03 ; $6a7e
	ld hl, $003b ; $6a84
	ld de, $d043 ; $6a87
	ld c, $08 ; $6a8a
	call Func_1a_6a9b ; $6a8c
	ld hl, $0043 ; $6a8f
	ld de, $d04b ; $6a92
	ld c, $08 ; $6a95
	call Func_1a_6a9b ; $6a97
	ret ; $6a9a
Func_1a_6a9b:
	push bc ; $6a9b
	push de ; $6a9c
	push hl ; $6a9d
	ld c, $20 ; $6a9e
	farcall FarPtr_05_72 ; $6aa0
	pop hl ; $6aa3
	pop de ; $6aa4
	pop bc ; $6aa5
	dec c ; $6aa6
	ret z ; $6aa7
	inc hl ; $6aa8
	push hl ; $6aa9
	ld hl, $0040 ; $6aaa
	add hl, de ; $6aad
	ld d, h ; $6aae
	ld e, l ; $6aaf
	pop hl ; $6ab0
	jr Func_1a_6a9b ; $6ab1
	INCBIN "data/bank_01a/d_6ab3.bin" ; $6ab3, 124 bytes
Func_1a_6b2f:
	call Func_1a_6b55 ; $6b2f
	wram_bank $03 ; $6b32
	ld hl, $d000 ; $6b38
	ld de, $9800 ; $6b3b
	ld c, $24 ; $6b3e
	call Func_00_0480 ; $6b40
	wram_bank $02 ; $6b43
	ld hl, $d000 ; $6b49
	ld de, $b800 ; $6b4c
	ld c, $24 ; $6b4f
	call Func_00_0480 ; $6b51
	ret ; $6b54
Func_1a_6b55:
	ld hl, $70d9 ; $6b55
	ld de, $0008 ; $6b58
	call LoadPaletteShadow ; $6b5b
	wram_bank $01 ; $6b5e
	ld hl, $7119 ; $6b64
	ld de, $d000 ; $6b67
	call DecompressData ; $6b6a
	ld hl, $d000 ; $6b6d
	ld de, $b000 ; $6b70
	ld c, $80 ; $6b73
	call Func_00_0480 ; $6b75
	ld hl, $d800 ; $6b78
	ld de, $a800 ; $6b7b
	ld c, $80 ; $6b7e
	call Func_00_0480 ; $6b80
	wram_bank $01 ; $6b83
	ld hl, $777d ; $6b89
	ld de, $d000 ; $6b8c
	call DecompressData ; $6b8f
	ld hl, $d000 ; $6b92
	ld bc, $0240 ; $6b95
	call Func_1a_6be1 ; $6b98
	wram_bank $01 ; $6b9b
	ld hl, $7831 ; $6ba1
	ld de, $d000 ; $6ba4
	call DecompressData ; $6ba7
	ld hl, $d000 ; $6baa
	ld bc, $0240 ; $6bad
	call Func_1a_6bf6 ; $6bb0
	wram_bank $02 ; $6bb3
	ld hl, $d1e1 ; $6bb9
	xor a, a ; $6bbc
	ld [hl+], a ; $6bbd
	ld [hl+], a ; $6bbe
	ld [hl+], a ; $6bbf
	ld [hl+], a ; $6bc0
	ld [hl+], a ; $6bc1
	ld [hl+], a ; $6bc2
	ld [hl+], a ; $6bc3
	ld [hl+], a ; $6bc4
	ld [hl+], a ; $6bc5
	ld [hl+], a ; $6bc6
	ld [hl+], a ; $6bc7
	ld [hl+], a ; $6bc8
	ld [hl+], a ; $6bc9
	ld [hl+], a ; $6bca
	ld [hl+], a ; $6bcb
	ld [hl+], a ; $6bcc
	ld hl, $d201 ; $6bcd
	ld [hl+], a ; $6bd0
	ld [hl+], a ; $6bd1
	ld [hl+], a ; $6bd2
	ld [hl+], a ; $6bd3
	ld [hl+], a ; $6bd4
	ld [hl+], a ; $6bd5
	ld [hl+], a ; $6bd6
	ld [hl+], a ; $6bd7
	ld [hl+], a ; $6bd8
	ld [hl+], a ; $6bd9
	ld [hl+], a ; $6bda
	ld [hl+], a ; $6bdb
	ld [hl+], a ; $6bdc
	ld [hl+], a ; $6bdd
	ld [hl+], a ; $6bde
	ld [hl+], a ; $6bdf
	ret ; $6be0
Func_1a_6be1:
	wram_bank $01 ; $6be1
	ld d, [hl] ; $6be7
	wram_bank $03 ; $6be8
	ld [hl], d ; $6bee
	inc hl ; $6bef
	dec bc ; $6bf0
	ld a, b ; $6bf1
	or a, c ; $6bf2
	jr nz, Func_1a_6be1 ; $6bf3
	ret ; $6bf5
Func_1a_6bf6:
	wram_bank $01 ; $6bf6
	ld d, [hl] ; $6bfc
	wram_bank $02 ; $6bfd
	ld [hl], d ; $6c03
	inc hl ; $6c04
	dec bc ; $6c05
	ld a, b ; $6c06
	or a, c ; $6c07
	jr nz, Func_1a_6bf6 ; $6c08
	ret ; $6c0a
Func_1a_6c0b:
	wram_bank $06 ; $6c0b
	xor a, a ; $6c11
	ld [$d001], a ; $6c12
	ld [$d000], a ; $6c15
	ld [$d003], a ; $6c18
	ld [$d005], a ; $6c1b
	ld a, [$d002] ; $6c1e
	farcall FarPtr_02_34 ; $6c21
	ld [$d004], a ; $6c24
	ret ; $6c27
	INCBIN "data/bank_01a/d_6c28.bin" ; $6c28, 119 bytes
Func_1a_6c9f:
	call Func_1a_7012 ; $6c9f
	wram_bank $06 ; $6ca2
	call AdvanceFrame ; $6ca8
	ldh a, [hInputPressed] ; $6cab
	bit 6, a ; $6cad
	jr nz, Label_1a_6cd5 ; $6caf
	bit 7, a ; $6cb1
	jr nz, Label_1a_6d23 ; $6cb3
	bit 5, a ; $6cb5
	jp nz, Label_1a_6d71 ; $6cb7
	bit 4, a ; $6cba
	jp nz, Label_1a_6dae ; $6cbc
	bit 0, a ; $6cbf
	jp nz, Label_1a_6de4 ; $6cc1
	bit 1, a ; $6cc4
	jp nz, Label_1a_6e1d ; $6cc6
	bit 3, a ; $6cc9
	jp nz, Label_1a_6e29 ; $6ccb
	bit 2, a ; $6cce
	jp nz, Label_1a_6e35 ; $6cd0
	jr Func_1a_6c9f ; $6cd3
Label_1a_6cd5:
	sound $5e ; $6cd5
	wram_bank $06 ; $6cd7
	ld a, [$d000] ; $6cdd
	or a, a ; $6ce0
	jr nz, Label_1a_6d0c ; $6ce1
	ld a, [$d001] ; $6ce3
	cp a, $0b ; $6ce6
	jr c, Label_1a_6cf5 ; $6ce8
	ld a, [$d001] ; $6cea
	sub a, $0b ; $6ced
	ld [$d001], a ; $6cef
	jp Label_1a_6e20 ; $6cf2
Label_1a_6cf5:
	wram_bank $06 ; $6cf5
	ld a, [$d000] ; $6cfb
	xor a, $01 ; $6cfe
	ld [$d000], a ; $6d00
	ld a, [$d004] ; $6d03
	ld [$d001], a ; $6d06
	jp Label_1a_6e20 ; $6d09
Label_1a_6d0c:
	wram_bank $06 ; $6d0c
	ld a, [$d000] ; $6d12
	xor a, $01 ; $6d15
	ld [$d000], a ; $6d17
	ld a, [$d003] ; $6d1a
	ld [$d001], a ; $6d1d
	jp Label_1a_6e20 ; $6d20
Label_1a_6d23:
	sound $5e ; $6d23
	wram_bank $06 ; $6d25
	ld a, [$d000] ; $6d2b
	or a, a ; $6d2e
	jr nz, Label_1a_6d5a ; $6d2f
	ld a, [$d001] ; $6d31
	cp a, $0b ; $6d34
	jr nc, Label_1a_6d43 ; $6d36
	ld a, [$d001] ; $6d38
	add a, $0b ; $6d3b
	ld [$d001], a ; $6d3d
	jp Label_1a_6e20 ; $6d40
Label_1a_6d43:
	wram_bank $06 ; $6d43
	ld a, [$d000] ; $6d49
	xor a, $01 ; $6d4c
	ld [$d000], a ; $6d4e
	ld a, [$d004] ; $6d51
	ld [$d001], a ; $6d54
	jp Label_1a_6e20 ; $6d57
Label_1a_6d5a:
	wram_bank $06 ; $6d5a
	ld a, [$d000] ; $6d60
	xor a, $01 ; $6d63
	ld [$d000], a ; $6d65
	ld a, [$d003] ; $6d68
	ld [$d001], a ; $6d6b
	jp Label_1a_6e20 ; $6d6e
Label_1a_6d71:
	sound $5e ; $6d71
	wram_bank $06 ; $6d73
	ld a, [$d000] ; $6d79
	or a, a ; $6d7c
	jr nz, Label_1a_6d9f ; $6d7d
	ld a, [$d001] ; $6d7f
	dec a ; $6d82
	ld [$d001], a ; $6d83
	cp a, $ff ; $6d86
	jr nz, Label_1a_6d92 ; $6d88
	ld a, $0a ; $6d8a
	ld [$d001], a ; $6d8c
	jp Label_1a_6e20 ; $6d8f
Label_1a_6d92:
	cp a, $0a ; $6d92
	jp nz, Label_1a_6e20 ; $6d94
	ld a, $15 ; $6d97
	ld [$d001], a ; $6d99
	jp Label_1a_6e20 ; $6d9c
Label_1a_6d9f:
	ld a, [$d001] ; $6d9f
	dec a ; $6da2
	cp a, $ff ; $6da3
	jr nz, Label_1a_6da9 ; $6da5
	ld a, $04 ; $6da7
Label_1a_6da9:
	ld [$d001], a ; $6da9
	jr Label_1a_6e20 ; $6dac
Label_1a_6dae:
	sound $5e ; $6dae
	wram_bank $06 ; $6db0
	ld a, [$d000] ; $6db6
	or a, a ; $6db9
	jr nz, Label_1a_6dd6 ; $6dba
	ld a, [$d001] ; $6dbc
	inc a ; $6dbf
	ld [$d001], a ; $6dc0
	cp a, $0b ; $6dc3
	jr nz, Label_1a_6dcb ; $6dc5
	xor a, a ; $6dc7
	ld [$d001], a ; $6dc8
Label_1a_6dcb:
	cp a, $16 ; $6dcb
	jr nz, Label_1a_6e20 ; $6dcd
	ld a, $0b ; $6dcf
	ld [$d001], a ; $6dd1
	jr Label_1a_6e20 ; $6dd4
Label_1a_6dd6:
	ld a, [$d001] ; $6dd6
	inc a ; $6dd9
	cp a, $05 ; $6dda
	jr nz, Label_1a_6ddf ; $6ddc
	xor a, a ; $6dde
Label_1a_6ddf:
	ld [$d001], a ; $6ddf
	jr Label_1a_6e20 ; $6de2
Label_1a_6de4:
	sound $5e ; $6de4
	wram_bank $06 ; $6de6
	ld a, [$d000] ; $6dec
	or a, a ; $6def
	jr nz, Label_1a_6e12 ; $6df0
	ld a, [$d001] ; $6df2
	ld [$d003], a ; $6df5
	ld hl, $792f ; $6df8
	add a, l ; $6dfb
	ld l, a ; $6dfc
	jr nc, Label_1a_6e00 ; $6dfd
	inc h ; $6dff
Label_1a_6e00:
	ld d, [hl] ; $6e00
	wram_bank $04 ; $6e01
	farcall FarPtr_08_20 ; $6e07
	wram_bank $06 ; $6e0a
	jr Label_1a_6e20 ; $6e10
Label_1a_6e12:
	ld a, [$d001] ; $6e12
	ld [$d004], a ; $6e15
	call Func_1a_70c0 ; $6e18
	jr Label_1a_6e20 ; $6e1b
Label_1a_6e1d:
	sound $62 ; $6e1d
	ret ; $6e1f
Label_1a_6e20:
	call Func_1a_6e41 ; $6e20
	call AdvanceFrame ; $6e23
	jp Func_1a_6c9f ; $6e26
Label_1a_6e29:
	ld a, [$d005] ; $6e29
	dec a ; $6e2c
	and a, $07 ; $6e2d
	ld [$d005], a ; $6e2f
	jp Func_1a_6c9f ; $6e32
Label_1a_6e35:
	ld a, [$d005] ; $6e35
	inc a ; $6e38
	and a, $07 ; $6e39
	ld [$d005], a ; $6e3b
	jp Func_1a_6c9f ; $6e3e
Func_1a_6e41:
	wram_bank $02 ; $6e41
	ld a, $09 ; $6e47
	ld hl, $d128 ; $6e49
	ld [hl+], a ; $6e4c
	ld [hl+], a ; $6e4d
	ld [hl+], a ; $6e4e
	ld [hl+], a ; $6e4f
	ld [hl+], a ; $6e50
	ld [hl+], a ; $6e51
	ld [hl+], a ; $6e52
	ld [hl+], a ; $6e53
	ld [hl+], a ; $6e54
	ld [hl+], a ; $6e55
	ld [hl+], a ; $6e56
	ld hl, $d148 ; $6e57
	ld [hl+], a ; $6e5a
	ld [hl+], a ; $6e5b
	ld [hl+], a ; $6e5c
	ld [hl+], a ; $6e5d
	ld [hl+], a ; $6e5e
	ld [hl+], a ; $6e5f
	ld [hl+], a ; $6e60
	ld [hl+], a ; $6e61
	ld [hl+], a ; $6e62
	ld [hl+], a ; $6e63
	ld [hl+], a ; $6e64
	ld hl, $d1c8 ; $6e65
	ld [hl+], a ; $6e68
	ld [hl+], a ; $6e69
	ld [hl+], a ; $6e6a
	ld [hl+], a ; $6e6b
	ld [hl+], a ; $6e6c
	wram_bank $06 ; $6e6d
	ld a, [$d003] ; $6e73
	cp a, $0b ; $6e76
	jr nc, Label_1a_6e83 ; $6e78
	add a, $28 ; $6e7a
	ld l, a ; $6e7c
	adc a, $d1 ; $6e7d
	sub a, l ; $6e7f
	ld h, a ; $6e80
	jr Label_1a_6e8c ; $6e81
Label_1a_6e83:
	sub a, $0b ; $6e83
	add a, $48 ; $6e85
	ld l, a ; $6e87
	adc a, $d1 ; $6e88
	sub a, l ; $6e8a
	ld h, a ; $6e8b
Label_1a_6e8c:
	wram_bank $02 ; $6e8c
	ld a, $08 ; $6e92
	ld [hl], a ; $6e94
	ld hl, $d120 ; $6e95
	ld de, $b920 ; $6e98
	ld c, $04 ; $6e9b
	call Func_00_0480 ; $6e9d
	wram_bank $06 ; $6ea0
	ld a, [$d004] ; $6ea6
	add a, $c8 ; $6ea9
	ld l, a ; $6eab
	adc a, $d1 ; $6eac
	sub a, l ; $6eae
	ld h, a ; $6eaf
	wram_bank $02 ; $6eb0
	ld a, $08 ; $6eb6
	ld [hl], a ; $6eb8
	ld hl, $d1c0 ; $6eb9
	ld de, $b9c0 ; $6ebc
	ld c, $02 ; $6ebf
	call Func_00_0480 ; $6ec1
	wram_bank $03 ; $6ec4
	ld hl, $d1e1 ; $6eca
	ld a, $20 ; $6ecd
	ld [hl+], a ; $6ecf
	ld [hl+], a ; $6ed0
	ld [hl+], a ; $6ed1
	ld [hl+], a ; $6ed2
	ld [hl+], a ; $6ed3
	ld [hl+], a ; $6ed4
	ld [hl+], a ; $6ed5
	ld [hl+], a ; $6ed6
	ld [hl+], a ; $6ed7
	ld [hl+], a ; $6ed8
	ld [hl+], a ; $6ed9
	ld [hl+], a ; $6eda
	ld [hl+], a ; $6edb
	ld [hl+], a ; $6edc
	ld [hl+], a ; $6edd
	ld [hl+], a ; $6ede
	ld hl, $d201 ; $6edf
	ld [hl+], a ; $6ee2
	ld [hl+], a ; $6ee3
	ld [hl+], a ; $6ee4
	ld [hl+], a ; $6ee5
	ld [hl+], a ; $6ee6
	ld [hl+], a ; $6ee7
	ld [hl+], a ; $6ee8
	ld [hl+], a ; $6ee9
	ld [hl+], a ; $6eea
	ld [hl+], a ; $6eeb
	ld [hl+], a ; $6eec
	ld [hl+], a ; $6eed
	ld [hl+], a ; $6eee
	ld [hl+], a ; $6eef
	ld [hl+], a ; $6ef0
	ld [hl+], a ; $6ef1
	wram_bank $06 ; $6ef2
	ld a, [$d000] ; $6ef8
	or a, a ; $6efb
	jr nz, Label_1a_6f1a ; $6efc
	ld a, [$d001] ; $6efe
	add a, $01 ; $6f01
	add a, $c0 ; $6f03
	ld l, a ; $6f05
	adc a, $10 ; $6f06
	sub a, l ; $6f08
	ld h, a ; $6f09
	ld de, $d201 ; $6f0a
	ld c, $20 ; $6f0d
	wram_bank $03 ; $6f0f
	farcall FarPtr_05_72 ; $6f15
	jr Label_1a_6f2b ; $6f18
Label_1a_6f1a:
	wram_bank $03 ; $6f1a
	ld hl, $10c0 ; $6f20
	ld de, $d201 ; $6f23
	ld c, $20 ; $6f26
	farcall FarPtr_05_72 ; $6f28
Label_1a_6f2b:
	wram_bank $03 ; $6f2b
	ld hl, $d1e0 ; $6f31
	ld de, $99e0 ; $6f34
	ld c, $04 ; $6f37
	call Func_00_0480 ; $6f39
	ret ; $6f3c
Func_1a_6f3d:
	call Func_1a_7096 ; $6f3d
	wram_bank $06 ; $6f40
	ld a, [$d002] ; $6f46
	farcall FarPtr_LookupTileId_04 ; $6f49
	ld d, a ; $6f4c
	wram_bank $04 ; $6f4d
	ldh a, [hRomBank] ; $6f53
	ld hl, $6fcf ; $6f55
	farcall FarPtr_SpawnActorsFromList ; $6f58
	ld bc, $d000 ; $6f5b
	farcall FarPtr_04_2c ; $6f5e
	ld bc, $d040 ; $6f61
	farcall FarPtr_04_2c ; $6f64
	ld bc, $d080 ; $6f67
	farcall FarPtr_04_2c ; $6f6a
	ld bc, $d0c0 ; $6f6d
	farcall FarPtr_04_2c ; $6f70
	ld d, $01 ; $6f73
	ld bc, $d000 ; $6f75
	farcall FarPtr_04_16 ; $6f78
	ld bc, $d040 ; $6f7b
	farcall FarPtr_04_16 ; $6f7e
	ld bc, $d080 ; $6f81
	farcall FarPtr_04_16 ; $6f84
	ld bc, $d0c0 ; $6f87
	farcall FarPtr_04_16 ; $6f8a
	ld a, $07 ; $6f8d
	ld [$d037], a ; $6f8f
	ld [$d077], a ; $6f92
	ld [$d0b7], a ; $6f95
	ld [$d0f7], a ; $6f98
	wram_bank $06 ; $6f9b
	ld a, [$d002] ; $6fa1
	ld [$c3b0], a ; $6fa4
	ld d, a ; $6fa7
	wram_bank $04 ; $6fa8
	ld hl, $df00 ; $6fae
	ld c, $10 ; $6fb1
	call ClearMemory16 ; $6fb3
	ld a, $00 ; $6fb6
	farcall FarPtr_InitChar ; $6fb8
	ld a, $07 ; $6fbb
	ld [$df37], a ; $6fbd
	ld de, $8600 ; $6fc0
	ld hl, $df26 ; $6fc3
	ld a, e ; $6fc6
	ld [hl+], a ; $6fc7
	ld [hl], d ; $6fc8
	ld hl, $df36 ; $6fc9
	ld [hl], $60 ; $6fcc
	ret ; $6fce
	INCBIN "data/bank_01a/d_6fcf.bin" ; $6fcf, 67 bytes
Func_1a_7012:
	ld bc, $0770 ; $7012
	ld de, $4615 ; $7015
	call QueueSprite ; $7018
	ld bc, $0772 ; $701b
	ld de, $4e15 ; $701e
	call QueueSprite ; $7021
	wram_bank $04 ; $7024
	ld hl, $df00 ; $702a
	ld b, h ; $702d
	ld c, l ; $702e
	farcall FarPtr_08_12 ; $702f
	wram_bank $06 ; $7032
	ld a, [$d005] ; $7038
	ld d, a ; $703b
	wram_bank $04 ; $703c
	push de ; $7042
	farcall FarPtr_08_14 ; $7043
	pop de ; $7046
	ld a, d ; $7047
	add a, $8e ; $7048
	ld l, a ; $704a
	adc a, $70 ; $704b
	sub a, l ; $704d
	ld h, a ; $704e
	ld b, [hl] ; $704f
	ld hl, $df36 ; $7050
	ld a, [hl+] ; $7053
	ld c, a ; $7054
	ld a, [hl] ; $7055
	or a, b ; $7056
	ld b, a ; $7057
	push bc ; $7058
	push de ; $7059
	ld d, $20 ; $705a
	ld e, $68 ; $705c
	ld a, d ; $705e
	ld [$df53], a ; $705f
	ld a, e ; $7062
	ld [$df54], a ; $7063
	pop hl ; $7066
	add hl, hl ; $7067
	add hl, hl ; $7068
	add hl, hl ; $7069
	pop bc ; $706a
	push hl ; $706b
	ld hl, $df80 ; $706c
	ld a, c ; $706f
	ld [hl+], a ; $7070
	ld a, b ; $7071
	ld [hl+], a ; $7072
	ld a, e ; $7073
	ld [hl+], a ; $7074
	ld a, d ; $7075
	ld [hl+], a ; $7076
	ld a, [$df1d] ; $7077
	ld [hl+], a ; $707a
	ld a, [$df1c] ; $707b
	ld [hl+], a ; $707e
	ld a, [$df1b] ; $707f
	ld [hl+], a ; $7082
	pop af ; $7083
	add a, $80 ; $7084
	ld [hl+], a ; $7086
	ld hl, $df80 ; $7087
	farcall FarPtr_DrawCharSprite ; $708a
	ret ; $708d
	INCBIN "data/bank_01a/d_708e.bin" ; $708e, 8 bytes
Func_1a_7096:
	xor a, a ; $7096
	ld de, $0701 ; $7097
	farcall FarPtr_1b_02 ; $709a
	wram_bank $06 ; $709d
	ld a, [$d002] ; $70a3
	ld b, a ; $70a6
	wram_bank $01 ; $70a7
	ld a, b ; $70ad
	ld de, $d000 ; $70ae
	farcall FarPtr_1b_00 ; $70b1
	ld hl, $d000 ; $70b4
	ld de, $b100 ; $70b7
	ld c, $09 ; $70ba
	call Func_00_0480 ; $70bc
	ret ; $70bf
Func_1a_70c0:
	wram_bank $06 ; $70c0
	ld a, [$d004] ; $70c6
	ld de, $0701 ; $70c9
	farcall FarPtr_1b_02 ; $70cc
	ld a, [$d004] ; $70cf
	ld de, $0f01 ; $70d2
	farcall FarPtr_1b_02 ; $70d5
	ret ; $70d8
	INCBIN "data/bank_01a/d_70d9.bin" ; $70d9, 2156 bytes
Func_1a_7945:
	farcall FarPtr_1d_0c ; $7945
	farcall FarPtr_1c_10 ; $7948
	wram_bank $01 ; $794b
	ld hl, $7e53 ; $7951
	ld de, $dea0 ; $7954
	call DecompressData ; $7957
	ld hl, $dea0 ; $795a
	ld bc, $002a ; $795d
	call Func_1a_7a3d ; $7960
	wram_bank $01 ; $7963
	ld hl, $7e75 ; $7969
	ld de, $dea0 ; $796c
	call DecompressData ; $796f
	ld hl, $dea0 ; $7972
	ld bc, $002a ; $7975
	call Func_1a_7a52 ; $7978
	ld hl, $7e46 ; $797b
	ld bc, $dea0 ; $797e
	call Func_1a_7a67 ; $7981
	farcall FarPtr_1d_0e ; $7984
	wram_bank $03 ; $7987
	ld hl, $d000 ; $798d
	ld de, $9800 ; $7990
	ld c, $24 ; $7993
	call Func_00_0480 ; $7995
	wram_bank $02 ; $7998
	ld hl, $d000 ; $799e
	ld de, $b800 ; $79a1
	ld c, $24 ; $79a4
	call Func_00_0480 ; $79a6
	call EnableLCD ; $79a9
	call AdvanceFrame ; $79ac
	farcall FarPtr_1c_12 ; $79af
	farcall FarPtr_1d_10 ; $79b2
	ld c, $10 ; $79b5
	call Func_00_1d2e ; $79b7
	call Func_00_1da4 ; $79ba
	wram_bank $06 ; $79bd
	ld a, $01 ; $79c3
	ld [$d025], a ; $79c5
Label_1a_79c8:
	call Func_1a_7a1d ; $79c8
	call AdvanceFrame ; $79cb
	ldh a, [$ff94] ; $79ce
	bit 0, a ; $79d0
	jr nz, Label_1a_79e8 ; $79d2
	bit 1, a ; $79d4
	jr nz, Label_1a_79f8 ; $79d6
	and a, $c0 ; $79d8
	jr z, Label_1a_79c8 ; $79da
	sound $5e ; $79dc
	ld a, [$d025] ; $79de
	xor a, $01 ; $79e1
	ld [$d025], a ; $79e3
	jr Label_1a_79c8 ; $79e6
Label_1a_79e8:
	wram_bank $06 ; $79e8
	ld a, [$d025] ; $79ee
	or a, a ; $79f1
	jr nz, Label_1a_79f8 ; $79f2
	sound $5f ; $79f4
	jr Label_1a_7a05 ; $79f6
Label_1a_79f8:
	wram_bank $06 ; $79f8
	ld a, $01 ; $79fe
	ld [$d025], a ; $7a00
	sound $62 ; $7a03
Label_1a_7a05:
	ld c, $10 ; $7a05
	call Func_00_1d20 ; $7a07
	call Func_00_1da4 ; $7a0a
	farcall FarPtr_1d_12 ; $7a0d
	farcall FarPtr_1c_14 ; $7a10
	wram_bank $06 ; $7a13
	ld a, [$d025] ; $7a19
	ret ; $7a1c
Func_1a_7a1d:
	wram_bank $06 ; $7a1d
	ld a, [$d025] ; $7a23
	or a, a ; $7a26
	jr nz, Label_1a_7a33 ; $7a27
	ld bc, $0fd4 ; $7a29
	ld de, $7a0c ; $7a2c
	call QueueSprite ; $7a2f
	ret ; $7a32
Label_1a_7a33:
	ld bc, $0fd4 ; $7a33
	ld de, $7a14 ; $7a36
	call QueueSprite ; $7a39
	ret ; $7a3c
Func_1a_7a3d:
	wram_bank $01 ; $7a3d
	ld d, [hl] ; $7a43
	wram_bank $03 ; $7a44
	ld [hl], d ; $7a4a
	inc hl ; $7a4b
	dec bc ; $7a4c
	ld a, b ; $7a4d
	or a, c ; $7a4e
	jr nz, Func_1a_7a3d ; $7a4f
	ret ; $7a51
Func_1a_7a52:
	wram_bank $01 ; $7a52
	ld d, [hl] ; $7a58
	wram_bank $02 ; $7a59
	ld [hl], d ; $7a5f
	inc hl ; $7a60
	dec bc ; $7a61
	ld a, b ; $7a62
	or a, c ; $7a63
	jr nz, Func_1a_7a52 ; $7a64
	ret ; $7a66
Func_1a_7a67:
	ld a, [hl] ; $7a67
	cp a, $ff ; $7a68
	ret z ; $7a6a
	push hl ; $7a6b
	ld d, [hl] ; $7a6c
	inc hl ; $7a6d
	ld e, [hl] ; $7a6e
	push hl ; $7a6f
	ld hl, $d000 ; $7a70
	add hl, de ; $7a73
	ld d, h ; $7a74
	ld e, l ; $7a75
	pop hl ; $7a76
	inc hl ; $7a77
	push hl ; $7a78
	ld a, [hl] ; $7a79
	ld h, b ; $7a7a
	ld l, c ; $7a7b
	add a, l ; $7a7c
	ld l, a ; $7a7d
	jr nc, Label_1a_7a81 ; $7a7e
	inc h ; $7a80
Label_1a_7a81:
	wram_bank $06 ; $7a81
	ld a, l ; $7a87
	ld [$d08e], a ; $7a88
	ld a, h ; $7a8b
	ld [$d08f], a ; $7a8c
	pop hl ; $7a8f
	push bc ; $7a90
	inc hl ; $7a91
	ld c, [hl] ; $7a92
	ld hl, $d08e ; $7a93
	ld a, [hl+] ; $7a96
	ld h, [hl] ; $7a97
	ld l, a ; $7a98
Label_1a_7a99:
	wram_bank $03 ; $7a99
	ld a, [hl] ; $7a9f
	ld [de], a ; $7aa0
	wram_bank $02 ; $7aa1
	ld a, [hl+] ; $7aa7
	ld [de], a ; $7aa8
	inc de ; $7aa9
	dec c ; $7aaa
	jr nz, Label_1a_7a99 ; $7aab
	pop bc ; $7aad
	pop hl ; $7aae
	inc hl ; $7aaf
	inc hl ; $7ab0
	inc hl ; $7ab1
	inc hl ; $7ab2
	jr Func_1a_7a67 ; $7ab3
CharDataScreen_BuildStats:
	ld a, [$cb00] ; $7ab5
	or a, a ; $7ab8
	ret nz ; $7ab9
	wram_bank $06 ; $7aba
	xor a, a ; $7ac0
	ld hl, $d0ab ; $7ac1
	ld [hl+], a ; $7ac4
	ld [hl+], a ; $7ac5
	ld [hl+], a ; $7ac6
	ld [hl+], a ; $7ac7
	ld [hl+], a ; $7ac8
	ld [hl+], a ; $7ac9
	ld [hl+], a ; $7aca
	ld [hl+], a ; $7acb
	ld [hl+], a ; $7acc
	ld [hl+], a ; $7acd
	ld [hl+], a ; $7ace
	ld a, [wEquippedRacket] ; $7acf
	or a, a ; $7ad2
	ret z ; $7ad3
	farcall FarPtr_RecomputeStatsWithoutRacket ; $7ad4
	ld hl, $c920 ; $7ad7
	ld de, $d0a0 ; $7ada
	ld a, [hl+] ; $7add
	ld [de], a ; $7ade
	inc de ; $7adf
	ld a, [hl+] ; $7ae0
	ld [de], a ; $7ae1
	inc de ; $7ae2
	ld a, [hl+] ; $7ae3
	ld [de], a ; $7ae4
	inc de ; $7ae5
	ld a, [hl+] ; $7ae6
	ld [de], a ; $7ae7
	inc de ; $7ae8
	ld a, [hl+] ; $7ae9
	ld [de], a ; $7aea
	inc de ; $7aeb
	ld a, [hl+] ; $7aec
	ld [de], a ; $7aed
	inc de ; $7aee
	ld a, [hl+] ; $7aef
	ld [de], a ; $7af0
	inc de ; $7af1
	ld a, [hl+] ; $7af2
	ld [de], a ; $7af3
	inc de ; $7af4
	ld a, [hl+] ; $7af5
	ld [de], a ; $7af6
	inc de ; $7af7
	ld a, [hl+] ; $7af8
	ld [de], a ; $7af9
	inc de ; $7afa
	ld a, [hl] ; $7afb
	ld [de], a ; $7afc
	ld hl, $d0a0 ; $7afd
	ld c, [hl] ; $7b00
	ld a, [$d00e] ; $7b01
	dec a ; $7b04
	sub a, c ; $7b05
	ld [$d0ab], a ; $7b06
	ld hl, $d0a1 ; $7b09
	ld c, [hl] ; $7b0c
	ld a, [$d00f] ; $7b0d
	dec a ; $7b10
	sub a, c ; $7b11
	ld [$d0ac], a ; $7b12
	ld hl, $d0a2 ; $7b15
	ld c, [hl] ; $7b18
	ld a, [$d010] ; $7b19
	dec a ; $7b1c
	sub a, c ; $7b1d
	ld [$d0ad], a ; $7b1e
	ld hl, $d0a3 ; $7b21
	ld c, [hl] ; $7b24
	ld a, [$d011] ; $7b25
	dec a ; $7b28
	sub a, c ; $7b29
	ld [$d0ae], a ; $7b2a
	ld hl, $d0a4 ; $7b2d
	ld c, [hl] ; $7b30
	ld a, [$d012] ; $7b31
	dec a ; $7b34
	sub a, c ; $7b35
	ld [$d0af], a ; $7b36
	ld hl, $d0a5 ; $7b39
	ld c, [hl] ; $7b3c
	ld a, [$d013] ; $7b3d
	dec a ; $7b40
	sub a, c ; $7b41
	ld [$d0b0], a ; $7b42
	ld hl, $d0a6 ; $7b45
	ld c, [hl] ; $7b48
	ld a, [$d014] ; $7b49
	dec a ; $7b4c
	sub a, c ; $7b4d
	ld [$d0b1], a ; $7b4e
	ld hl, $d0a7 ; $7b51
	ld c, [hl] ; $7b54
	ld a, [$d015] ; $7b55
	dec a ; $7b58
	sub a, c ; $7b59
	ld [$d0b2], a ; $7b5a
	ld hl, $d0a8 ; $7b5d
	ld c, [hl] ; $7b60
	ld a, [$d016] ; $7b61
	dec a ; $7b64
	sub a, c ; $7b65
	ld [$d0b3], a ; $7b66
	ld hl, $d0a9 ; $7b69
	ld c, [hl] ; $7b6c
	ld a, [$d017] ; $7b6d
	dec a ; $7b70
	sub a, c ; $7b71
	ld [$d0b4], a ; $7b72
	ld hl, $d0aa ; $7b75
	ld c, [hl] ; $7b78
	ld a, [$d018] ; $7b79
	dec a ; $7b7c
	sub a, c ; $7b7d
	ld [$d0b5], a ; $7b7e
	farcall FarPtr_RefreshMainCharacterStats ; $7b81
	ret ; $7b84
CharDataScreen_LoadGfx:
	ld hl, $7e7e ; $7b85
	ld de, $0c02 ; $7b88
	call LoadPaletteShadow ; $7b8b
	wram_bank $01 ; $7b8e
	ld hl, $7e8e ; $7b94
	ld de, $d000 ; $7b97
	call DecompressData ; $7b9a
	ld hl, $d000 ; $7b9d
	ld de, $a780 ; $7ba0
	ld c, $02 ; $7ba3
	call Func_00_0480 ; $7ba5
	ld hl, $7e99 ; $7ba8
	ld de, $d000 ; $7bab
	call DecompressData ; $7bae
	ld hl, $d000 ; $7bb1
	ld de, $a7a0 ; $7bb4
	ld c, $02 ; $7bb7
	call Func_00_0480 ; $7bb9
	ld hl, $7ea4 ; $7bbc
	ld de, $d000 ; $7bbf
	call DecompressData ; $7bc2
	ld hl, $d000 ; $7bc5
	ld de, $a7c0 ; $7bc8
	ld c, $02 ; $7bcb
	call Func_00_0480 ; $7bcd
	ld hl, $7eaf ; $7bd0
	ld de, $d000 ; $7bd3
	call DecompressData ; $7bd6
	ld hl, $d000 ; $7bd9
	ld de, $a7e0 ; $7bdc
	ld c, $02 ; $7bdf
	call Func_00_0480 ; $7be1
	ret ; $7be4
Func_1a_7be5:
	wram_bank $06 ; $7be5
	ld a, [$d142] ; $7beb
	dec a ; $7bee
	ret nz ; $7bef
	ld hl, $d145 ; $7bf0
	ld a, [hl+] ; $7bf3
	ld h, [hl] ; $7bf4
	ld l, a ; $7bf5
	ld a, h ; $7bf6
	or a, l ; $7bf7
	ret nz ; $7bf8
	ldh a, [$ff8c] ; $7bf9
	and a, $18 ; $7bfb
	ret z ; $7bfd
	ld a, [$d0ab] ; $7bfe
	or a, a ; $7c01
	jr z, Label_1a_7c2b ; $7c02
	call Func_1a_7dee ; $7c04
	call Func_1a_7df5 ; $7c07
	push af ; $7c0a
	ld a, [$d0a0] ; $7c0b
	ld l, a ; $7c0e
	ld a, [$d019] ; $7c0f
	add a, l ; $7c12
	ld de, $142c ; $7c13
	call Func_1a_7e23 ; $7c16
	push de ; $7c19
	call QueueSprite ; $7c1a
	pop de ; $7c1d
	pop af ; $7c1e
	or a, a ; $7c1f
	jr z, Label_1a_7c2b ; $7c20
	call Func_1a_7e15 ; $7c22
	call Func_1a_7e38 ; $7c25
	call QueueSprite ; $7c28
Label_1a_7c2b:
	ld a, [$d0ac] ; $7c2b
	or a, a ; $7c2e
	jr z, Label_1a_7c58 ; $7c2f
	call Func_1a_7dee ; $7c31
	call Func_1a_7df5 ; $7c34
	push af ; $7c37
	ld a, [$d0a1] ; $7c38
	ld l, a ; $7c3b
	ld a, [$d01a] ; $7c3c
	add a, l ; $7c3f
	ld de, $143c ; $7c40
	call Func_1a_7e23 ; $7c43
	push de ; $7c46
	call QueueSprite ; $7c47
	pop de ; $7c4a
	pop af ; $7c4b
	or a, a ; $7c4c
	jr z, Label_1a_7c58 ; $7c4d
	call Func_1a_7e15 ; $7c4f
	call Func_1a_7e38 ; $7c52
	call QueueSprite ; $7c55
Label_1a_7c58:
	ld a, [$d0ad] ; $7c58
	or a, a ; $7c5b
	jr z, Label_1a_7c85 ; $7c5c
	call Func_1a_7dee ; $7c5e
	call Func_1a_7df5 ; $7c61
	push af ; $7c64
	ld a, [$d0a2] ; $7c65
	ld l, a ; $7c68
	ld a, [$d01b] ; $7c69
	add a, l ; $7c6c
	ld de, $1454 ; $7c6d
	call Func_1a_7e23 ; $7c70
	push de ; $7c73
	call QueueSprite ; $7c74
	pop de ; $7c77
	pop af ; $7c78
	or a, a ; $7c79
	jr z, Label_1a_7c85 ; $7c7a
	call Func_1a_7e15 ; $7c7c
	call Func_1a_7e38 ; $7c7f
	call QueueSprite ; $7c82
Label_1a_7c85:
	ld a, [$d0ae] ; $7c85
	or a, a ; $7c88
	jr z, Label_1a_7cb2 ; $7c89
	call Func_1a_7dee ; $7c8b
	call Func_1a_7df5 ; $7c8e
	push af ; $7c91
	ld a, [$d0a3] ; $7c92
	ld l, a ; $7c95
	ld a, [$d01c] ; $7c96
	add a, l ; $7c99
	ld de, $1464 ; $7c9a
	call Func_1a_7e23 ; $7c9d
	push de ; $7ca0
	call QueueSprite ; $7ca1
	pop de ; $7ca4
	pop af ; $7ca5
	or a, a ; $7ca6
	jr z, Label_1a_7cb2 ; $7ca7
	call Func_1a_7e15 ; $7ca9
	call Func_1a_7e38 ; $7cac
	call QueueSprite ; $7caf
Label_1a_7cb2:
	ld a, [$d0af] ; $7cb2
	or a, a ; $7cb5
	jr z, Label_1a_7cdf ; $7cb6
	call Func_1a_7dee ; $7cb8
	call Func_1a_7df5 ; $7cbb
	push af ; $7cbe
	ld a, [$d0a4] ; $7cbf
	ld l, a ; $7cc2
	ld a, [$d01d] ; $7cc3
	add a, l ; $7cc6
	ld de, $1474 ; $7cc7
	call Func_1a_7e23 ; $7cca
	push de ; $7ccd
	call QueueSprite ; $7cce
	pop de ; $7cd1
	pop af ; $7cd2
	or a, a ; $7cd3
	jr z, Label_1a_7cdf ; $7cd4
	call Func_1a_7e15 ; $7cd6
	call Func_1a_7e38 ; $7cd9
	call QueueSprite ; $7cdc
Label_1a_7cdf:
	ld a, [$d0b0] ; $7cdf
	or a, a ; $7ce2
	jr z, Label_1a_7d0c ; $7ce3
	call Func_1a_7dee ; $7ce5
	call Func_1a_7df5 ; $7ce8
	push af ; $7ceb
	ld a, [$d0a5] ; $7cec
	ld l, a ; $7cef
	ld a, [$d01e] ; $7cf0
	add a, l ; $7cf3
	ld de, $642c ; $7cf4
	call Func_1a_7e23 ; $7cf7
	push de ; $7cfa
	call QueueSprite ; $7cfb
	pop de ; $7cfe
	pop af ; $7cff
	or a, a ; $7d00
	jr z, Label_1a_7d0c ; $7d01
	call Func_1a_7e15 ; $7d03
	call Func_1a_7e38 ; $7d06
	call QueueSprite ; $7d09
Label_1a_7d0c:
	ld a, [$d0b1] ; $7d0c
	or a, a ; $7d0f
	jr z, Label_1a_7d39 ; $7d10
	call Func_1a_7dee ; $7d12
	call Func_1a_7df5 ; $7d15
	push af ; $7d18
	ld a, [$d0a6] ; $7d19
	ld l, a ; $7d1c
	ld a, [$d01f] ; $7d1d
	add a, l ; $7d20
	ld de, $643c ; $7d21
	call Func_1a_7e23 ; $7d24
	push de ; $7d27
	call QueueSprite ; $7d28
	pop de ; $7d2b
	pop af ; $7d2c
	or a, a ; $7d2d
	jr z, Label_1a_7d39 ; $7d2e
	call Func_1a_7e15 ; $7d30
	call Func_1a_7e38 ; $7d33
	call QueueSprite ; $7d36
Label_1a_7d39:
	ld a, [$d0b2] ; $7d39
	or a, a ; $7d3c
	jr z, Label_1a_7d66 ; $7d3d
	call Func_1a_7dee ; $7d3f
	call Func_1a_7df5 ; $7d42
	push af ; $7d45
	ld a, [$d0a7] ; $7d46
	ld l, a ; $7d49
	ld a, [$d020] ; $7d4a
	add a, l ; $7d4d
	ld de, $6454 ; $7d4e
	call Func_1a_7e23 ; $7d51
	push de ; $7d54
	call QueueSprite ; $7d55
	pop de ; $7d58
	pop af ; $7d59
	or a, a ; $7d5a
	jr z, Label_1a_7d66 ; $7d5b
	call Func_1a_7e15 ; $7d5d
	call Func_1a_7e38 ; $7d60
	call QueueSprite ; $7d63
Label_1a_7d66:
	ld a, [$d0b3] ; $7d66
	or a, a ; $7d69
	jr z, Label_1a_7d93 ; $7d6a
	call Func_1a_7dee ; $7d6c
	call Func_1a_7df5 ; $7d6f
	push af ; $7d72
	ld a, [$d0a8] ; $7d73
	ld l, a ; $7d76
	ld a, [$d021] ; $7d77
	add a, l ; $7d7a
	ld de, $6464 ; $7d7b
	call Func_1a_7e23 ; $7d7e
	push de ; $7d81
	call QueueSprite ; $7d82
	pop de ; $7d85
	pop af ; $7d86
	or a, a ; $7d87
	jr z, Label_1a_7d93 ; $7d88
	call Func_1a_7e15 ; $7d8a
	call Func_1a_7e38 ; $7d8d
	call QueueSprite ; $7d90
Label_1a_7d93:
	ld a, [$d0b4] ; $7d93
	or a, a ; $7d96
	jr z, Label_1a_7dc0 ; $7d97
	call Func_1a_7dee ; $7d99
	call Func_1a_7df5 ; $7d9c
	push af ; $7d9f
	ld a, [$d0a9] ; $7da0
	ld l, a ; $7da3
	ld a, [$d022] ; $7da4
	add a, l ; $7da7
	ld de, $6474 ; $7da8
	call Func_1a_7e23 ; $7dab
	push de ; $7dae
	call QueueSprite ; $7daf
	pop de ; $7db2
	pop af ; $7db3
	or a, a ; $7db4
	jr z, Label_1a_7dc0 ; $7db5
	call Func_1a_7e15 ; $7db7
	call Func_1a_7e38 ; $7dba
	call QueueSprite ; $7dbd
Label_1a_7dc0:
	ld a, [$d0b5] ; $7dc0
	or a, a ; $7dc3
	jr z, Label_1a_7ded ; $7dc4
	call Func_1a_7dee ; $7dc6
	call Func_1a_7df5 ; $7dc9
	push af ; $7dcc
	ld a, [$d0aa] ; $7dcd
	ld l, a ; $7dd0
	ld a, [$d023] ; $7dd1
	add a, l ; $7dd4
	ld de, $6484 ; $7dd5
	call Func_1a_7e23 ; $7dd8
	push de ; $7ddb
	call QueueSprite ; $7ddc
	pop de ; $7ddf
	pop af ; $7de0
	or a, a ; $7de1
	jr z, Label_1a_7ded ; $7de2
	call Func_1a_7e15 ; $7de4
	call Func_1a_7e38 ; $7de7
	call QueueSprite ; $7dea
Label_1a_7ded:
	ret ; $7ded
Func_1a_7dee:
	ld b, $0c ; $7dee
	bit 7, a ; $7df0
	ret z ; $7df2
	inc b ; $7df3
	ret ; $7df4
Func_1a_7df5:
	bit 7, a ; $7df5
	jr nz, Label_1a_7e07 ; $7df7
	dec a ; $7df9
	jr z, Label_1a_7e02 ; $7dfa
	dec a ; $7dfc
	ld c, $7e ; $7dfd
	ld h, $02 ; $7dff
	ret ; $7e01
Label_1a_7e02:
	ld c, $7c ; $7e02
	ld h, $02 ; $7e04
	ret ; $7e06
Label_1a_7e07:
	inc a ; $7e07
	jr z, Label_1a_7e10 ; $7e08
	inc a ; $7e0a
	ld c, $7a ; $7e0b
	ld h, $01 ; $7e0d
	ret ; $7e0f
Label_1a_7e10:
	ld c, $78 ; $7e10
	ld h, $01 ; $7e12
	ret ; $7e14
Func_1a_7e15:
	bit 7, a ; $7e15
	jr nz, Label_1a_7e1e ; $7e17
	ld c, $7c ; $7e19
	ld h, $03 ; $7e1b
	ret ; $7e1d
Label_1a_7e1e:
	ld c, $78 ; $7e1e
	ld h, $00 ; $7e20
	ret ; $7e22
Func_1a_7e23:
	inc a ; $7e23
	rlca ; $7e24
	rlca ; $7e25
	add a, d ; $7e26
	ld d, a ; $7e27
	ld a, h ; $7e28
	add a, $34 ; $7e29
	ld l, a ; $7e2b
	adc a, $7e ; $7e2c
	sub a, l ; $7e2e
	ld h, a ; $7e2f
	ld a, [hl] ; $7e30
	add a, d ; $7e31
	ld d, a ; $7e32
	ret ; $7e33
	INCBIN "data/bank_01a/d_7e34.bin" ; $7e34, 4 bytes
Func_1a_7e38:
	bit 7, a ; $7e38
	jr nz, Label_1a_7e41 ; $7e3a
	ld a, $08 ; $7e3c
	add a, d ; $7e3e
	ld d, a ; $7e3f
	ret ; $7e40
Label_1a_7e41:
	ld a, $f8 ; $7e41
	add a, d ; $7e43
	ld d, a ; $7e44
	ret ; $7e45
	INCBIN "data/bank_01a/d_7e46.bin" ; $7e46, 116 bytes
	ds 326, $ff ; $7eba, fill
