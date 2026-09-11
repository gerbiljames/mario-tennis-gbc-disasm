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
