UpdateCameraIfActorIsCameraTarget:
	ld hl, ACTORF_MODE ; $4402
	add hl, bc ; $4405
	ld a, [hl] ; $4406
	cp $01 ; $4407
	ret nz ; $4409
UpdateCameraToActor:
	push af ; $440a
	push de ; $440b
	push hl ; $440c
	wram_bank WRAM_ACTORS ; $440d
	ld hl, ACTORF_X ; $4413
	add hl, bc ; $4416
	ld a, [hl+] ; $4417
	ld h, [hl] ; $4418
	ld l, a ; $4419
	ld de, $f610 ; $441a
	add hl, de ; $441d
	ld a, [wMapScrollMinX] ; $441e
	ld d, a ; $4421
	ld a, h ; $4422
	sub d ; $4423
	bit 7, a ; $4424
	jr z, .clampX ; $4426
	ld h, d ; $4428
	ld l, $00 ; $4429
	jr .storeX ; $442b
.clampX:
	ld a, [wMapWidthTiles] ; $442d
	sub $14 ; $4430
	ld d, a ; $4432
	ld a, h ; $4433
	sub d ; $4434
	bit 7, a ; $4435
	jr nz, .storeX ; $4437
	ld h, d ; $4439
	ld l, $00 ; $443a
.storeX:
	ld a, l ; $443c
	and $e0 ; $443d
	ld [wCameraX], a ; $443f
	ld a, h ; $4442
	ld [wCameraX + 1], a ; $4443
	ld hl, ACTORF_Y ; $4446
	add hl, bc ; $4449
	ld a, [hl+] ; $444a
	ld h, [hl] ; $444b
	ld l, a ; $444c
	ld de, $f710 ; $444d
	add hl, de ; $4450
	ld a, [wMapScrollMinY] ; $4451
	ld d, a ; $4454
	ld a, h ; $4455
	sub d ; $4456
	bit 7, a ; $4457
	jr z, .clampDepth ; $4459
	ld h, d ; $445b
	ld l, $00 ; $445c
	jr .done ; $445e
.clampDepth:
	ld a, [wMapHeightTiles] ; $4460
	sub $12 ; $4463
	ld d, a ; $4465
	ld a, h ; $4466
	sub d ; $4467
	bit 7, a ; $4468
	jr nz, .done ; $446a
	ld h, d ; $446c
	ld l, $00 ; $446d
.done:
	ld a, l ; $446f
	and $e0 ; $4470
	ld [wCameraY], a ; $4472
	ld a, h ; $4475
	ld [wCameraY + 1], a ; $4476
	pop hl ; $4479
	pop de ; $447a
	pop af ; $447b
	ret ; $447c
ActorScriptOpHandlers_04:
	; $447d, 44 bytes (records:2)
	dw ActorScriptOp_Halt ; record 0
	dw ActorScriptOp_Wait ; record 1
	dw ActorScriptOp_WaitMove ; record 2
	dw ActorScriptOp_SetPos ; record 3
	dw ActorScriptOp_SetTarget ; record 4
	dw ActorScriptOp_Halt ; record 5
	dw ActorScriptOp_TargetRel ; record 6
	dw ActorScriptOp_Move ; record 7
	dw ActorScriptOp_MoveRel ; record 8
	dw ActorScriptOp_RandBox ; record 9
	dw ActorScriptOp_Step ; record 10
	dw ActorScriptOp_FollowWaypoint ; record 11
	dw ActorScriptOp_Jump ; record 12
	dw ActorScriptOp_SetField ; record 13
	dw ActorScriptOp_AddField ; record 14
	dw ActorScriptOp_Halt ; record 15
	dw ActorScriptOp_Anim ; record 16
	dw ActorScriptOp_Sound ; record 17
	dw ActorScriptOp_Call ; record 18
	dw ActorScriptOp_BeginPath ; record 19
	dw ActorScriptOp_WaitMove2 ; record 20
	dw ActorScriptOp_Flag ; record 21
ActorScriptOp_Call:
	inc de ; $44a9
	push de ; $44aa
	ld l, e ; $44ab
	ld h, d ; $44ac
	ld a, [wActorScriptBank] ; $44ad
	call FarReadWord ; $44b0
	push bc ; $44b3
	ld hl, hActorPtr ; $44b4
	ld a, [hl+] ; $44b7
	ld b, [hl] ; $44b8
	ld c, a ; $44b9
	pop hl ; $44ba
	ld a, [wActorScriptBank] ; $44bb
	call CallHLInBankA ; $44be
	pop de ; $44c1
	and a ; $44c2
	jr z, .skipOperand ; $44c3
	inc b ; $44c5
	dec b ; $44c6
	jr z, .skipOperand ; $44c7
	dec de ; $44c9
	ld a, $00 ; $44ca
	ret ; $44cc
.skipOperand:
	inc de ; $44cd
	inc de ; $44ce
	ret ; $44cf
ActorScriptOp_Jump:
	inc de ; $44d0
	ld a, [wActorScriptBank] ; $44d1
	ld l, e ; $44d4
	ld h, d ; $44d5
	call FarReadWord ; $44d6
	add hl, bc ; $44d9
	ld e, l ; $44da
	ld d, h ; $44db
	ld a, $01 ; $44dc
	ret ; $44de
ActorScriptOp_Move:
	inc de ; $44df
	ld a, [wActorScriptBank] ; $44e0
	ld l, e ; $44e3
	ld h, d ; $44e4
	call FarReadByte ; $44e5
	inc de ; $44e8
	jr ApplyActorHeadingStep ; $44e9
ActorScriptOp_MoveRel:
	inc de ; $44eb
	ld a, [wActorScriptBank] ; $44ec
	ld l, e ; $44ef
	ld h, d ; $44f0
	call FarReadByte ; $44f1
	inc de ; $44f4
	push af ; $44f5
	ld hl, hActorPtr ; $44f6
	ld a, [hl+] ; $44f9
	ld h, [hl] ; $44fa
	add $14 ; $44fb
	ld l, a ; $44fd
	pop af ; $44fe
	add [hl] ; $44ff
ApplyActorHeadingStep:
	push af ; $4500
	ld a, [wActorScriptBank] ; $4501
	ld l, e ; $4504
	ld h, d ; $4505
	call FarReadWord ; $4506
	pop af ; $4509
	ld e, l ; $450a
	ld d, h ; $450b
	inc de ; $450c
	inc de ; $450d
	push de ; $450e
	ld l, c ; $450f
	ld h, b ; $4510
	call VectorFromLengthAndAngle ; $4511
	push hl ; $4514
	ld hl, hActorPtr ; $4515
	ld a, [hl+] ; $4518
	ld h, [hl] ; $4519
	add $0e ; $451a
	ld l, a ; $451c
	ld a, [hl+] ; $451d
	ld h, [hl] ; $451e
	ld l, a ; $451f
	add hl, de ; $4520
	ld e, l ; $4521
	ld d, h ; $4522
	ld hl, hActorPtr ; $4523
	ld a, [hl+] ; $4526
	ld h, [hl] ; $4527
	add $0a ; $4528
	ld l, a ; $452a
	ld a, e ; $452b
	ld [hl+], a ; $452c
	ld [hl], d ; $452d
	pop de ; $452e
	ld hl, hActorPtr ; $452f
	ld a, [hl+] ; $4532
	ld h, [hl] ; $4533
	add $0c ; $4534
	ld l, a ; $4536
	ld a, [hl+] ; $4537
	ld h, [hl] ; $4538
	ld l, a ; $4539
	add hl, de ; $453a
	ld e, l ; $453b
	ld d, h ; $453c
	ld hl, hActorPtr ; $453d
	ld a, [hl+] ; $4540
	ld h, [hl] ; $4541
	add $08 ; $4542
	ld l, a ; $4544
	ld a, e ; $4545
	ld [hl+], a ; $4546
	ld [hl], d ; $4547
	pop de ; $4548
	ld hl, hActorPtr ; $4549
	ld a, [hl+] ; $454c
	ld h, [hl] ; $454d
	add $05 ; $454e
	ld l, a ; $4550
	set 7, [hl] ; $4551
	ld a, $01 ; $4553
	ret ; $4555
ActorScriptOp_SetPos:
	inc de ; $4556
	push de ; $4557
	ld hl, hActorPtr ; $4558
	ld a, [hl+] ; $455b
	ld h, [hl] ; $455c
	add $0c ; $455d
	ld l, a ; $455f
	ld e, l ; $4560
	ld d, h ; $4561
	pop hl ; $4562
	ld a, [wActorScriptBank] ; $4563
	ld bc, $0004 ; $4566
	call FarCopyBytes ; $4569
	ld e, l ; $456c
	ld d, h ; $456d
	ld hl, hActorPtr ; $456e
	ld a, [hl+] ; $4571
	ld h, [hl] ; $4572
	add $05 ; $4573
	ld l, a ; $4575
	res 7, [hl] ; $4576
	ld a, $01 ; $4578
	ret ; $457a
ActorScriptOp_SetTarget:
	inc de ; $457b
	push de ; $457c
	ld hl, hActorPtr ; $457d
	ld a, [hl+] ; $4580
	ld h, [hl] ; $4581
	add $08 ; $4582
	ld l, a ; $4584
	ld e, l ; $4585
	ld d, h ; $4586
	pop hl ; $4587
	ld a, [wActorScriptBank] ; $4588
	ld bc, $0004 ; $458b
	call FarCopyBytes ; $458e
	ld e, l ; $4591
	ld d, h ; $4592
	ld hl, hActorPtr ; $4593
	ld a, [hl+] ; $4596
	ld h, [hl] ; $4597
	add $05 ; $4598
	ld l, a ; $459a
	set 7, [hl] ; $459b
	ld a, $01 ; $459d
	ret ; $459f
ActorScriptOp_TargetRel:
	inc de ; $45a0
	ld a, [wActorScriptBank] ; $45a1
	ld l, e ; $45a4
	ld h, d ; $45a5
	call FarReadWord ; $45a6
	ld e, l ; $45a9
	ld d, h ; $45aa
	inc de ; $45ab
	inc de ; $45ac
	ld hl, hActorPtr ; $45ad
	ld a, [hl+] ; $45b0
	ld h, [hl] ; $45b1
	add $0c ; $45b2
	ld l, a ; $45b4
	ld a, [hl+] ; $45b5
	ld h, [hl] ; $45b6
	ld l, a ; $45b7
	add hl, bc ; $45b8
	ld c, l ; $45b9
	ld b, h ; $45ba
	ld hl, hActorPtr ; $45bb
	ld a, [hl+] ; $45be
	ld h, [hl] ; $45bf
	add $08 ; $45c0
	ld l, a ; $45c2
	ld a, c ; $45c3
	ld [hl+], a ; $45c4
	ld [hl], b ; $45c5
	ld a, [wActorScriptBank] ; $45c6
	ld l, e ; $45c9
	ld h, d ; $45ca
	call FarReadWord ; $45cb
	ld e, l ; $45ce
	ld d, h ; $45cf
	inc de ; $45d0
	inc de ; $45d1
	ld hl, hActorPtr ; $45d2
	ld a, [hl+] ; $45d5
	ld h, [hl] ; $45d6
	add $0e ; $45d7
	ld l, a ; $45d9
	ld a, [hl+] ; $45da
	ld h, [hl] ; $45db
	ld l, a ; $45dc
	add hl, bc ; $45dd
	ld c, l ; $45de
	ld b, h ; $45df
	ld hl, hActorPtr ; $45e0
	ld a, [hl+] ; $45e3
	ld h, [hl] ; $45e4
	add $0a ; $45e5
	ld l, a ; $45e7
	ld a, c ; $45e8
	ld [hl+], a ; $45e9
	ld [hl], b ; $45ea
	ld hl, hActorPtr ; $45eb
	ld a, [hl+] ; $45ee
	ld h, [hl] ; $45ef
	add $05 ; $45f0
	ld l, a ; $45f2
	set 7, [hl] ; $45f3
	ld a, $01 ; $45f5
	ret ; $45f7
ActorScriptOp_WaitMove:
	ld hl, hActorPtr ; $45f8
	ld a, [hl+] ; $45fb
	ld h, [hl] ; $45fc
	add $05 ; $45fd
	ld l, a ; $45ff
	bit 7, [hl] ; $4600
	jr nz, .noAdvance ; $4602
	inc de ; $4604
	ld a, $01 ; $4605
	ret ; $4607
.noAdvance:
	xor a ; $4608
	ret ; $4609
ActorScriptOp_Halt:
	xor a ; $460a
	ret ; $460b
ActorScriptOp_Wait:
	inc de ; $460c
	ld a, [wActorScriptBank] ; $460d
	ld l, e ; $4610
	ld h, d ; $4611
	call FarReadByte ; $4612
	dec a ; $4615
	ld b, a ; $4616
	ld hl, hActorPtr ; $4617
	ld a, [hl+] ; $461a
	ld h, [hl] ; $461b
	add $03 ; $461c
	ld l, a ; $461e
	ld [hl], b ; $461f
	inc de ; $4620
	xor a ; $4621
	ret ; $4622
ActorScriptOp_FollowWaypoint:
	inc de ; $4623
	push de ; $4624
	ld hl, hActorPtr ; $4625
	ld a, [hl+] ; $4628
	ld b, [hl] ; $4629
	ld c, a ; $462a
	ld hl, $0016 ; $462b
	add hl, bc ; $462e
	ld a, [hl+] ; $462f
	ld d, [hl] ; $4630
	ld e, a ; $4631
	ld hl, $000c ; $4632
	add hl, de ; $4635
	ld a, ACTORF_TARGET_X ; $4636
	add c ; $4638
	ld e, a ; $4639
	ld d, b ; $463a
	ld a, [hl+] ; $463b
	ld [de], a ; $463c
	inc de ; $463d
	ld a, [hl+] ; $463e
	ld [de], a ; $463f
	inc de ; $4640
	ld a, [hl+] ; $4641
	ld [de], a ; $4642
	inc de ; $4643
	ld a, [hl+] ; $4644
	ld [de], a ; $4645
	call IsActorAtTarget ; $4646
	jr z, .done ; $4649
	ld hl, ACTORF_TARGET_X + 1 ; $464b
	add hl, bc ; $464e
	ld a, [hl] ; $464f
	ld hl, ACTORF_X + 1 ; $4650
	add hl, bc ; $4653
	sub [hl] ; $4654
	bit 7, a ; $4655
	jr z, .squareDeltaX ; $4657
	cpl ; $4659
	inc a ; $465a
.squareDeltaX:
	call GetSquareOfByte ; $465b
	push hl ; $465e
	ld hl, ACTORF_TARGET_Y + 1 ; $465f
	add hl, bc ; $4662
	ld a, [hl] ; $4663
	ld hl, ACTORF_Y + 1 ; $4664
	add hl, bc ; $4667
	sub [hl] ; $4668
	bit 7, a ; $4669
	jr z, .squareDeltaDepth ; $466b
	cpl ; $466d
	inc a ; $466e
.squareDeltaDepth:
	call GetSquareOfByte ; $466f
	pop de ; $4672
	add hl, de ; $4673
	ld a, h ; $4674
	or a ; $4675
	jr nz, .speed5 ; $4676
	ld a, l ; $4678
	cp $01 ; $4679
	jr nc, .speed2 ; $467b
	ld de, $0010 ; $467d
	jr .setSpeed ; $4680
.speed2:
	cp $04 ; $4682
	jr nc, .speed3 ; $4684
	ld de, $0018 ; $4686
	jr .setSpeed ; $4689
.speed3:
	cp $09 ; $468b
	jr nc, .speed4 ; $468d
	ld de, $0020 ; $468f
	jr .setSpeed ; $4692
.speed4:
	cp $10 ; $4694
	jr nc, .speed5 ; $4696
	ld de, $0040 ; $4698
	jr .setSpeed ; $469b
.speed5:
	ld de, $0080 ; $469d
.setSpeed:
	ld hl, $0006 ; $46a0
	add hl, bc ; $46a3
	ld a, e ; $46a4
	ld [hl+], a ; $46a5
	ld [hl], d ; $46a6
	ld hl, ACTORF_FLAGS ; $46a7
	add hl, bc ; $46aa
	set 7, [hl] ; $46ab
.done:
	pop de ; $46ad
	xor a ; $46ae
	ret ; $46af
ActorScriptOp_Step:
	inc de ; $46b0
	push de ; $46b1
	ld hl, hActorPtr ; $46b2
	ld a, [hl+] ; $46b5
	ld b, [hl] ; $46b6
	ld c, a ; $46b7
	ld hl, $0016 ; $46b8
	add hl, bc ; $46bb
	ld a, [hl+] ; $46bc
	ld h, [hl] ; $46bd
	add $0e ; $46be
	ld l, a ; $46c0
	ld a, [hl+] ; $46c1
	ld d, [hl] ; $46c2
	ld e, a ; $46c3
	ld c, d ; $46c4
	push de ; $46c5
	ld de, $fffd ; $46c6
	add hl, de ; $46c9
	ld a, [hl+] ; $46ca
	ld d, [hl] ; $46cb
	ld e, a ; $46cc
	ld b, d ; $46cd
	push de ; $46ce
	ld de, $0007 ; $46cf
	add hl, de ; $46d2
	ld a, [hl] ; $46d3
	push af ; $46d4
	ld de, $fff2 ; $46d5
	add hl, de ; $46d8
	ld a, [hl+] ; $46d9
	ld d, [hl] ; $46da
	ld e, a ; $46db
	push de ; $46dc
	ld e, c ; $46dd
	ld d, b ; $46de
	ld hl, hActorPtr ; $46df
	ld a, [hl+] ; $46e2
	ld b, [hl] ; $46e3
	ld c, a ; $46e4
	ld hl, ACTORF_X + 1 ; $46e5
	add hl, bc ; $46e8
	ld a, d ; $46e9
	sub [hl] ; $46ea
	bit 7, a ; $46eb
	jr z, .negative ; $46ed
	cpl ; $46ef
	inc a ; $46f0
.negative:
	call GetSquareOfByte ; $46f1
	push hl ; $46f4
	ld hl, ACTORF_Y + 1 ; $46f5
	add hl, bc ; $46f8
	ld a, e ; $46f9
	sub [hl] ; $46fa
	bit 7, a ; $46fb
	jr z, .apply ; $46fd
	cpl ; $46ff
	inc a ; $4700
.apply:
	call GetSquareOfByte ; $4701
	pop de ; $4704
	add hl, de ; $4705
	ld a, l ; $4706
	cp $08 ; $4707
	jr nc, .depthAxis ; $4709
	add sp, 8 ; $470b
	pop de ; $470d
	xor a ; $470e
	ret ; $470f
.depthAxis:
	pop de ; $4710
	ld hl, $0006 ; $4711
	add hl, bc ; $4714
	ld a, e ; $4715
	ld [hl+], a ; $4716
	ld [hl], d ; $4717
	pop af ; $4718
	add $80 ; $4719
	ld hl, $0200 ; $471b
	call VectorFromLengthAndAngle ; $471e
	pop bc ; $4721
	add hl, bc ; $4722
	ld c, l ; $4723
	ld b, h ; $4724
	pop hl ; $4725
	add hl, de ; $4726
	ld e, l ; $4727
	ld d, h ; $4728
	ld l, c ; $4729
	ld h, b ; $472a
	call IsTerrainBlockedAtPoint ; $472b
	and a ; $472e
	jr nz, .done ; $472f
	ld hl, hActorPtr ; $4731
	ld a, [hl+] ; $4734
	ld h, [hl] ; $4735
	add $08 ; $4736
	ld l, a ; $4738
	ld a, c ; $4739
	ld [hl+], a ; $473a
	ld a, b ; $473b
	ld [hl+], a ; $473c
	ld a, e ; $473d
	ld [hl+], a ; $473e
	ld [hl], d ; $473f
	ld hl, hActorPtr ; $4740
	ld a, [hl+] ; $4743
	ld b, [hl] ; $4744
	ld c, a ; $4745
	call IsActorAtTarget ; $4746
	jr z, .done ; $4749
	ld hl, hActorPtr ; $474b
	ld a, [hl+] ; $474e
	ld b, [hl] ; $474f
	ld c, a ; $4750
	ld hl, ACTORF_FLAGS ; $4751
	add hl, bc ; $4754
	set 7, [hl] ; $4755
.done:
	pop de ; $4757
	xor a ; $4758
	ret ; $4759
IsActorAtTarget:
	ld hl, ACTORF_X ; $475a
	add hl, bc ; $475d
	ld a, ACTORF_TARGET_X ; $475e
	add c ; $4760
	ld e, a ; $4761
	ld d, b ; $4762
	ld a, [de] ; $4763
	cp [hl] ; $4764
	jr nz, .notThere ; $4765
	inc hl ; $4767
	inc de ; $4768
	ld a, [de] ; $4769
	cp [hl] ; $476a
	jr nz, .notThere ; $476b
	inc hl ; $476d
	inc de ; $476e
	ld a, [de] ; $476f
	cp [hl] ; $4770
	jr nz, .notThere ; $4771
	inc hl ; $4773
	inc de ; $4774
	ld a, [de] ; $4775
	cp [hl] ; $4776
	jr nz, .notThere ; $4777
	xor a ; $4779
	ret ; $477a
.notThere:
	ld a, $01 ; $477b
	or a ; $477d
	ret ; $477e
ActorScriptOp_SetField:
	inc de ; $477f
	ld l, e ; $4780
	ld h, d ; $4781
	ld a, [wActorScriptBank] ; $4782
	call FarReadByte ; $4785
	inc de ; $4788
	push af ; $4789
	ld a, [wActorScriptBank] ; $478a
	ld l, e ; $478d
	ld h, d ; $478e
	call FarReadWord ; $478f
	inc de ; $4792
	inc de ; $4793
	pop af ; $4794
	push af ; $4795
	ld hl, hActorPtr ; $4796
	add [hl] ; $4799
	inc hl ; $479a
	ld h, [hl] ; $479b
	ld l, a ; $479c
	pop af ; $479d
	push hl ; $479e
	add LOW(ActorFieldTypeTable_04) ; $479f
	ld l, a ; $47a1
	ld a, HIGH(ActorFieldTypeTable_04) ; $47a2
	adc $00 ; $47a4
	ld h, a ; $47a6
	ld a, [hl] ; $47a7
	pop hl ; $47a8
	cp $02 ; $47a9
	jr nz, .wordField ; $47ab
	ld a, c ; $47ad
	ld [hl+], a ; $47ae
	ld [hl], b ; $47af
	jr .done ; $47b0
.wordField:
	cp $01 ; $47b2
	jr nz, .done ; $47b4
	ld [hl], c ; $47b6
.done:
	ld a, $01 ; $47b7
	ret ; $47b9
ActorScriptOp_AddField:
	inc de ; $47ba
	ld l, e ; $47bb
	ld h, d ; $47bc
	ld a, [wActorScriptBank] ; $47bd
	call FarReadByte ; $47c0
	inc de ; $47c3
	push af ; $47c4
	ld a, [wActorScriptBank] ; $47c5
	call FarReadWord ; $47c8
	inc de ; $47cb
	inc de ; $47cc
	pop af ; $47cd
	push af ; $47ce
	ld hl, hActorPtr ; $47cf
	add [hl] ; $47d2
	inc hl ; $47d3
	ld h, [hl] ; $47d4
	ld l, a ; $47d5
	pop af ; $47d6
	push hl ; $47d7
	add LOW(ActorFieldTypeTable_04) ; $47d8
	ld l, a ; $47da
	ld a, HIGH(ActorFieldTypeTable_04) ; $47db
	adc $00 ; $47dd
	ld h, a ; $47df
	ld a, [hl] ; $47e0
	pop hl ; $47e1
	cp $02 ; $47e2
	jr nz, .wordField ; $47e4
	push hl ; $47e6
	ld a, [hl+] ; $47e7
	ld h, [hl] ; $47e8
	ld l, a ; $47e9
	add hl, bc ; $47ea
	ld c, l ; $47eb
	ld b, h ; $47ec
	pop hl ; $47ed
	ld a, c ; $47ee
	ld [hl+], a ; $47ef
	ld [hl], b ; $47f0
	jr .done ; $47f1
.wordField:
	cp $01 ; $47f3
	jr nz, .done ; $47f5
	ld a, [hl] ; $47f7
	add c ; $47f8
	ld [hl], a ; $47f9
.done:
	ld a, $01 ; $47fa
	ret ; $47fc
ActorFieldTypeTable_04:
	; $47fd, 39 bytes (bytes:35)
	db $02, $00, $01, $01, $01, $01, $02, $00, $02, $00, $02, $00, $02, $00, $02, $00, $02, $00, $02, $00, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01 ; 0x00
	db $13, $3e, $01, $c9 ; 0x23
ActorScriptOp_Anim:
	inc de ; $4824
	ld a, [wActorScriptBank] ; $4825
	ld l, e ; $4828
	ld h, d ; $4829
	call FarReadByte ; $482a
	inc de ; $482d
	push de ; $482e
	ld d, a ; $482f
	ld hl, hActorPtr ; $4830
	ld a, [hl+] ; $4833
	ld b, [hl] ; $4834
	ld c, a ; $4835
	call SetActorAnimationChecked ; $4836
	pop de ; $4839
	ld a, $01 ; $483a
	ret ; $483c
ActorScriptOp_Sound:
	inc de ; $483d
	ld a, [wActorScriptBank] ; $483e
	ld l, e ; $4841
	ld h, d ; $4842
	call FarReadByte ; $4843
	inc de ; $4846
	ld b, a ; $4847
	call PlaySoundManaged ; $4848
	ld a, $01 ; $484b
	ret ; $484d
ActorScriptOp_BeginPath:
	ld hl, hActorPtr ; $484e
	ld a, [hl+] ; $4851
	ld h, [hl] ; $4852
	add $0d ; $4853
	ld l, a ; $4855
	ld b, [hl] ; $4856
	ld hl, hActorPtr ; $4857
	ld a, [hl+] ; $485a
	ld h, [hl] ; $485b
	add $0f ; $485c
	ld l, a ; $485e
	ld c, [hl] ; $485f
	ld hl, hActorPtr ; $4860
	ld a, [hl+] ; $4863
	ld h, [hl] ; $4864
	add $16 ; $4865
	ld l, a ; $4867
	ld a, c ; $4868
	ld [hl+], a ; $4869
	ld [hl], b ; $486a
	ld hl, hActorPtr ; $486b
	ld a, [hl+] ; $486e
	ld h, [hl] ; $486f
	add $06 ; $4870
	ld l, a ; $4872
	ld [hl], $08 ; $4873
	inc hl ; $4875
	ld [hl], $00 ; $4876
	ld hl, hActorPtr ; $4878
	ld a, [hl+] ; $487b
	ld h, [hl] ; $487c
	add $05 ; $487d
	ld l, a ; $487f
	set 2, [hl] ; $4880
	inc de ; $4882
	ld a, $00 ; $4883
	ret ; $4885
ActorScriptOp_RandBox:
	ld hl, hActorPtr ; $4886
	ld a, [hl+] ; $4889
	ld h, [hl] ; $488a
	add $30 ; $488b
	ld l, a ; $488d
	bit 7, [hl] ; $488e
	jr z, .advance ; $4890
	push de ; $4892
	inc de ; $4893
	ld a, [wActorScriptBank] ; $4894
	ld l, e ; $4897
	ld h, d ; $4898
	call FarReadWord ; $4899
	ld a, c ; $489c
	ld [wActorRandBoxHalfWidth], a ; $489d
	ld a, b ; $48a0
	ld [wActorRandBoxHalfDepth], a ; $48a1
	call TryPickRandomReachableTarget ; $48a4
	and a ; $48a7
	jr nz, .skipOperands ; $48a8
	call TryPickRandomReachableTarget ; $48aa
	and a ; $48ad
	jr nz, .skipOperands ; $48ae
	call TryPickRandomReachableTarget ; $48b0
	and a ; $48b3
	jr nz, .skipOperands ; $48b4
	call TryPickRandomReachableTarget ; $48b6
	and a ; $48b9
	jr nz, .skipOperands ; $48ba
	jr .skipOperands ; $48bc
.skipOperands:
	pop de ; $48be
.advance:
	inc de ; $48bf
	inc de ; $48c0
	inc de ; $48c1
	ret ; $48c2
