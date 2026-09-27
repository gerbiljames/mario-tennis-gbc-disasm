SetActorPositionRaw:
	push bc ; $43d8
	push af ; $43d9
	ld hl, hActorPtr ; $43da
	ld a, [hl+] ; $43dd
	ld h, [hl] ; $43de
	add $0c ; $43df
	ld l, a ; $43e1
	ld e, l ; $43e2
	ld d, h ; $43e3
	pop af ; $43e4
	ld l, c ; $43e5
	ld h, b ; $43e6
	ld bc, $0004 ; $43e7
	call CopyMemoryBC ; $43ea
	pop bc ; $43ed
	ld hl, hActorPtr ; $43ee
	ld a, [hl+] ; $43f1
	ld h, [hl] ; $43f2
	add $05 ; $43f3
	ld l, a ; $43f5
	res 7, [hl] ; $43f6
	ret ; $43f8
ScriptSetActorMoveTarget:
	add sp, -4 ; $43f9
	ld hl, sp + 0 ; $43fb
	ld [hl], c ; $43fd
	inc hl ; $43fe
	ld [hl], b ; $43ff
	inc hl ; $4400
	ld [hl], e ; $4401
	inc hl ; $4402
	ld [hl], d ; $4403
	ld hl, sp + 0 ; $4404
	ld c, l ; $4406
	ld b, h ; $4407
	call GetActorStateAddr ; $4408
	jr z, .done ; $440b
	ld a, l ; $440d
	ldh [hActorPtr], a ; $440e
	ld a, h ; $4410
	ldh [hActorPtr + 1], a ; $4411
	wram_bank WRAM_ACTORS ; $4413
	call SetActorMoveTargetRaw ; $4419
.done:
	add sp, 4 ; $441c
	ret ; $441e
SetActorMoveTargetRaw:
	push bc ; $441f
	push af ; $4420
	ld hl, hActorPtr ; $4421
	ld a, [hl+] ; $4424
	ld h, [hl] ; $4425
	add $08 ; $4426
	ld l, a ; $4428
	ld e, l ; $4429
	ld d, h ; $442a
	pop af ; $442b
	ld l, c ; $442c
	ld h, b ; $442d
	ld bc, $0004 ; $442e
	call CopyMemoryBC ; $4431
	pop bc ; $4434
	ld hl, hActorPtr ; $4435
	ld a, [hl+] ; $4438
	ld h, [hl] ; $4439
	add $05 ; $443a
	ld l, a ; $443c
	set 7, [hl] ; $443d
	ret ; $443f
MoveActorTowardPoint:
	add sp, -5 ; $4440
	push af ; $4442
	ld a, l ; $4443
	ld hl, sp + 2 ; $4444
	ld [hl], c ; $4446
	inc hl ; $4447
	ld [hl], b ; $4448
	inc hl ; $4449
	ld [hl], e ; $444a
	inc hl ; $444b
	ld [hl], d ; $444c
	inc hl ; $444d
	ld [hl], a ; $444e
	pop af ; $444f
	ld hl, sp + 0 ; $4450
	ld c, l ; $4452
	ld b, h ; $4453
	call GetActorStateAddr ; $4454
	jr z, .done ; $4457
	ld a, l ; $4459
	ldh [hActorPtr], a ; $445a
	ld a, h ; $445c
	ldh [hActorPtr + 1], a ; $445d
	call MoveActorTowardPointRaw ; $445f
.done:
	add sp, 5 ; $4462
	ret ; $4464
MoveActorTowardPointRaw:
	push bc ; $4465
	ld l, c ; $4466
	ld h, b ; $4467
	ld c, [hl] ; $4468
	inc hl ; $4469
	ld b, [hl] ; $446a
	inc hl ; $446b
	push bc ; $446c
	ld c, [hl] ; $446d
	inc hl ; $446e
	ld b, [hl] ; $446f
	inc hl ; $4470
	push bc ; $4471
	ld a, [hl] ; $4472
	push af ; $4473
	push hl ; $4474
	ld hl, hActorPtr ; $4475
	ld a, [hl+] ; $4478
	ld b, [hl] ; $4479
	ld c, a ; $447a
	ld hl, ACTORF_X ; $447b
	add hl, bc ; $447e
	ld a, [hl+] ; $447f
	ld h, [hl] ; $4480
	ld l, a ; $4481
	ld a, l ; $4482
	sub e ; $4483
	ld l, a ; $4484
	ld a, h ; $4485
	sbc d ; $4486
	ld h, a ; $4487
	pop de ; $4488
	push hl ; $4489
	ld hl, ACTORF_Y ; $448a
	add hl, bc ; $448d
	ld a, [hl+] ; $448e
	ld h, [hl] ; $448f
	ld l, a ; $4490
	ld a, l ; $4491
	sub e ; $4492
	ld l, a ; $4493
	ld a, h ; $4494
	sbc d ; $4495
	ld h, a ; $4496
	pop de ; $4497
	call AngleFromVectorCoarse ; $4498
	pop hl ; $449b
	ld l, h ; $449c
	ld h, $00 ; $449d
	call VectorFromLengthAndAngleRaw ; $449f
	pop bc ; $44a2
	add hl, bc ; $44a3
	ld c, l ; $44a4
	ld b, h ; $44a5
	pop hl ; $44a6
	add hl, de ; $44a7
	ld e, l ; $44a8
	ld d, h ; $44a9
	ld hl, hActorPtr ; $44aa
	ld a, [hl+] ; $44ad
	ld h, [hl] ; $44ae
	add $08 ; $44af
	ld l, a ; $44b1
	ld [hl], c ; $44b2
	inc hl ; $44b3
	ld [hl], b ; $44b4
	inc hl ; $44b5
	ld [hl], e ; $44b6
	inc hl ; $44b7
	ld [hl], d ; $44b8
	pop bc ; $44b9
	ld hl, ACTORF_FLAGS ; $44ba
	add hl, bc ; $44bd
	ld c, l ; $44be
	ld b, h ; $44bf
	ld hl, hActorPtr ; $44c0
	ld a, [hl+] ; $44c3
	ld h, [hl] ; $44c4
	add $05 ; $44c5
	ld l, a ; $44c7
	set 7, [hl] ; $44c8
	ret ; $44ca
MoveActorByDelta:
	add sp, -4 ; $44cb
	ld hl, sp + 0 ; $44cd
	ld [hl], c ; $44cf
	inc hl ; $44d0
	ld [hl], b ; $44d1
	inc hl ; $44d2
	ld [hl], e ; $44d3
	inc hl ; $44d4
	ld [hl], d ; $44d5
	ld hl, sp + 0 ; $44d6
	ld c, l ; $44d8
	ld b, h ; $44d9
	call GetActorStateAddr ; $44da
	jr z, .done ; $44dd
	ld a, l ; $44df
	ldh [hActorPtr], a ; $44e0
	ld a, h ; $44e2
	ldh [hActorPtr + 1], a ; $44e3
	wram_bank WRAM_ACTORS ; $44e5
	call MoveActorByDeltaRaw ; $44eb
.done:
	add sp, 4 ; $44ee
	ret ; $44f0
MoveActorByDeltaRaw:
	push de ; $44f1
	ld l, c ; $44f2
	ld h, b ; $44f3
	ld c, [hl] ; $44f4
	inc hl ; $44f5
	ld b, [hl] ; $44f6
	inc hl ; $44f7
	ld e, c ; $44f8
	ld d, b ; $44f9
	ld c, l ; $44fa
	ld b, h ; $44fb
	ld hl, hActorPtr ; $44fc
	ld a, [hl+] ; $44ff
	ld h, [hl] ; $4500
	add $0c ; $4501
	ld l, a ; $4503
	ld a, [hl+] ; $4504
	ld h, [hl] ; $4505
	ld l, a ; $4506
	add hl, de ; $4507
	ld e, l ; $4508
	ld d, h ; $4509
	ld hl, hActorPtr ; $450a
	ld a, [hl+] ; $450d
	ld h, [hl] ; $450e
	add $08 ; $450f
	ld l, a ; $4511
	ld a, e ; $4512
	ld [hl+], a ; $4513
	ld [hl], d ; $4514
	pop de ; $4515
	ld a, d ; $4516
	ld l, c ; $4517
	ld h, b ; $4518
	ld c, [hl] ; $4519
	inc hl ; $451a
	ld b, [hl] ; $451b
	inc hl ; $451c
	ld e, c ; $451d
	ld d, b ; $451e
	ld c, l ; $451f
	ld b, h ; $4520
	ld hl, hActorPtr ; $4521
	ld a, [hl+] ; $4524
	ld h, [hl] ; $4525
	add $0e ; $4526
	ld l, a ; $4528
	ld a, [hl+] ; $4529
	ld h, [hl] ; $452a
	ld l, a ; $452b
	add hl, de ; $452c
	ld e, l ; $452d
	ld d, h ; $452e
	ld hl, hActorPtr ; $452f
	ld a, [hl+] ; $4532
	ld h, [hl] ; $4533
	add $0a ; $4534
	ld l, a ; $4536
	ld a, e ; $4537
	ld [hl+], a ; $4538
	ld [hl], d ; $4539
	ld hl, hActorPtr ; $453a
	ld a, [hl+] ; $453d
	ld h, [hl] ; $453e
	add $05 ; $453f
	ld l, a ; $4541
	set 7, [hl] ; $4542
	ret ; $4544
MoveActorByAngle:
	add sp, -3 ; $4545
	ld hl, sp + 0 ; $4547
	ld [hl], b ; $4549
	inc hl ; $454a
	ld [hl], e ; $454b
	inc hl ; $454c
	ld [hl], d ; $454d
	ld hl, sp + 0 ; $454e
	ld c, l ; $4550
	ld b, h ; $4551
	call GetActorStateAddr ; $4552
	jr z, .done ; $4555
	ld a, l ; $4557
	ldh [hActorPtr], a ; $4558
	ld a, h ; $455a
	ldh [hActorPtr + 1], a ; $455b
	wram_bank WRAM_ACTORS ; $455d
	call MoveActorByAngleRaw ; $4563
.done:
	add sp, 3 ; $4566
	ret ; $4568
MoveActorByAngleRaw:
	ld a, d ; $4569
	ld l, c ; $456a
	ld h, b ; $456b
	ld a, [hl] ; $456c
	inc bc ; $456d
	push af ; $456e
	push bc ; $456f
	ld a, d ; $4570
	ld l, c ; $4571
	ld h, b ; $4572
	ld c, [hl] ; $4573
	inc hl ; $4574
	ld b, [hl] ; $4575
	ld l, c ; $4576
	ld h, b ; $4577
	pop bc ; $4578
	inc bc ; $4579
	inc bc ; $457a
	pop af ; $457b
	call VectorFromLengthAndAngle ; $457c
	push de ; $457f
	ld e, l ; $4580
	ld d, h ; $4581
	ld hl, hActorPtr ; $4582
	ld a, [hl+] ; $4585
	ld h, [hl] ; $4586
	add $0c ; $4587
	ld l, a ; $4589
	ld a, [hl+] ; $458a
	ld h, [hl] ; $458b
	ld l, a ; $458c
	add hl, de ; $458d
	ld e, l ; $458e
	ld d, h ; $458f
	ld hl, hActorPtr ; $4590
	ld a, [hl+] ; $4593
	ld h, [hl] ; $4594
	add $08 ; $4595
	ld l, a ; $4597
	ld a, e ; $4598
	ld [hl+], a ; $4599
	ld [hl], d ; $459a
	pop de ; $459b
	ld hl, hActorPtr ; $459c
	ld a, [hl+] ; $459f
	ld h, [hl] ; $45a0
	add $0e ; $45a1
	ld l, a ; $45a3
	ld a, [hl+] ; $45a4
	ld h, [hl] ; $45a5
	ld l, a ; $45a6
	add hl, de ; $45a7
	ld e, l ; $45a8
	ld d, h ; $45a9
	ld hl, hActorPtr ; $45aa
	ld a, [hl+] ; $45ad
	ld h, [hl] ; $45ae
	add $0a ; $45af
	ld l, a ; $45b1
	ld a, e ; $45b2
	ld [hl+], a ; $45b3
	ld [hl], d ; $45b4
	ld hl, hActorPtr ; $45b5
	ld a, [hl+] ; $45b8
	ld h, [hl] ; $45b9
	add $05 ; $45ba
	ld l, a ; $45bc
	set 7, [hl] ; $45bd
	ret ; $45bf
ScriptSetActorFacingLock:
	call GetActorStateAddr ; $45c0
	ret z ; $45c3
	ld a, b ; $45c4
	and a ; $45c5
	ld c, l ; $45c6
	ld b, h ; $45c7
	jr nz, .setBit ; $45c8
	ld hl, ACTORF_HEADING ; $45ca
	add hl, bc ; $45cd
	ld a, [hl] ; $45ce
	ld hl, ACTORF_FACING ; $45cf
	add hl, bc ; $45d2
	ld [hl], a ; $45d3
	ld hl, ACTORF_STATUS ; $45d4
	add hl, bc ; $45d7
	res 0, [hl] ; $45d8
	ret ; $45da
.setBit:
	ld hl, ACTORF_STATUS ; $45db
	add hl, bc ; $45de
	set 0, [hl] ; $45df
	ret ; $45e1
SetActorFacing:
	call GetActorStateAddr ; $45e2
	ret z ; $45e5
	wram_bank WRAM_ACTORS ; $45e6
	ld a, $14 ; $45ec
	add l ; $45ee
	ld l, a ; $45ef
	jr nc, .store ; $45f0
	inc h ; $45f2
.store:
	ld [hl], b ; $45f3
	ret ; $45f4
FaceActorTowardActor:
	push af ; $45f5
	push bc ; $45f6
	push de ; $45f7
	push hl ; $45f8
	ld d, a ; $45f9
	call GetActorStateAddr ; $45fa
	jr z, .done ; $45fd
	ld a, b ; $45ff
	call GetActorStateAddr ; $4600
	inc h ; $4603
	dec h ; $4604
	jr z, .done ; $4605
	ld a, l ; $4607
	ldh [hActorPtr], a ; $4608
	ld a, h ; $460a
	ldh [hActorPtr + 1], a ; $460b
	wram_bank WRAM_ACTORS ; $460d
	ld hl, hActorPtr ; $4613
	ld a, [hl+] ; $4616
	ld h, [hl] ; $4617
	add $0c ; $4618
	ld l, a ; $461a
	ld c, [hl] ; $461b
	inc hl ; $461c
	ld b, [hl] ; $461d
	inc hl ; $461e
	push bc ; $461f
	ld c, [hl] ; $4620
	inc hl ; $4621
	ld b, [hl] ; $4622
	push bc ; $4623
	ld a, d ; $4624
	call GetActorStateAddr ; $4625
	ld a, l ; $4628
	ldh [hActorPtr], a ; $4629
	ld a, h ; $462b
	ldh [hActorPtr + 1], a ; $462c
	ld hl, hActorPtr ; $462e
	ld a, [hl+] ; $4631
	ld h, [hl] ; $4632
	add $0e ; $4633
	ld l, a ; $4635
	ld a, [hl+] ; $4636
	ld h, [hl] ; $4637
	ld l, a ; $4638
	ld d, h ; $4639
	ld e, l ; $463a
	pop hl ; $463b
	ld a, l ; $463c
	sub e ; $463d
	ld l, a ; $463e
	ld a, h ; $463f
	sbc d ; $4640
	ld h, a ; $4641
	ld b, h ; $4642
	ld c, l ; $4643
	ld hl, hActorPtr ; $4644
	ld a, [hl+] ; $4647
	ld h, [hl] ; $4648
	add $0c ; $4649
	ld l, a ; $464b
	ld a, [hl+] ; $464c
	ld h, [hl] ; $464d
	ld l, a ; $464e
	ld d, h ; $464f
	ld e, l ; $4650
	pop hl ; $4651
	ld a, l ; $4652
	sub e ; $4653
	ld l, a ; $4654
	ld a, h ; $4655
	sbc d ; $4656
	ld h, a ; $4657
	ld d, h ; $4658
	ld e, l ; $4659
	ld h, b ; $465a
	ld l, c ; $465b
	call AngleFromVectorCoarse ; $465c
	push af ; $465f
	ld hl, hActorPtr ; $4660
	ld a, [hl+] ; $4663
	ld h, [hl] ; $4664
	add $14 ; $4665
	ld l, a ; $4667
	pop af ; $4668
	ld [hl], a ; $4669
.done:
	pop hl ; $466a
	pop de ; $466b
	pop bc ; $466c
	pop af ; $466d
	ret ; $466e
