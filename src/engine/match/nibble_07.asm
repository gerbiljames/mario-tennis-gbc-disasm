ExchangeChecksumMaster:
	push bc ; $4328
	ld hl, $0000 ; $4329
	ld a, d ; $432c
	swap a ; $432d
	and $0f ; $432f
	or $40 ; $4331
	call SendByteGetReplyMaster ; $4333
	ld b, a ; $4336
	and $c0 ; $4337
	cp $80 ; $4339
	jr z, .nibble1 ; $433b
	call LinkErrorReset ; $433d
.nibble1:
	call ShiftNibbleIntoChecksum ; $4340
	ld a, d ; $4343
	and $0f ; $4344
	or $40 ; $4346
	call SendByteGetReplyMaster ; $4348
	ld b, a ; $434b
	and $c0 ; $434c
	cp $80 ; $434e
	jr z, .nibble2 ; $4350
	call LinkErrorReset ; $4352
.nibble2:
	call ShiftNibbleIntoChecksum ; $4355
	ld a, e ; $4358
	swap a ; $4359
	and $0f ; $435b
	or $40 ; $435d
	call SendByteGetReplyMaster ; $435f
	ld b, a ; $4362
	and $c0 ; $4363
	cp $80 ; $4365
	jr z, .nibble3 ; $4367
	call LinkErrorReset ; $4369
.nibble3:
	call ShiftNibbleIntoChecksum ; $436c
	ld a, e ; $436f
	and $0f ; $4370
	or $40 ; $4372
	call SendByteGetReplyMaster ; $4374
	ld b, a ; $4377
	and $c0 ; $4378
	cp $80 ; $437a
	jr z, .done ; $437c
	call LinkErrorReset ; $437e
.done:
	call ShiftNibbleIntoChecksum ; $4381
	call ShortDelay ; $4384
	call ShortDelay ; $4387
	pop bc ; $438a
	ret ; $438b
ExchangeChecksumSlave:
	push bc ; $438c
	ld hl, $0000 ; $438d
	ld a, d ; $4390
	swap a ; $4391
	and $0f ; $4393
	or $80 ; $4395
	call SendByteGetReplySlave ; $4397
	cp $cc ; $439a
	jr z, .nibble1 ; $439c
	call LinkErrorReset ; $439e
.nibble1:
	ld a, d ; $43a1
	and $0f ; $43a2
	or $80 ; $43a4
	call SendByteGetReplySlave ; $43a6
	ld b, a ; $43a9
	and $c0 ; $43aa
	cp $40 ; $43ac
	jr z, .nibble2 ; $43ae
	call LinkErrorReset ; $43b0
.nibble2:
	call ShiftNibbleIntoChecksum ; $43b3
	ld a, e ; $43b6
	swap a ; $43b7
	and $0f ; $43b9
	or $80 ; $43bb
	call SendByteGetReplySlave ; $43bd
	ld b, a ; $43c0
	and $c0 ; $43c1
	cp $40 ; $43c3
	jr z, .nibble3 ; $43c5
	call LinkErrorReset ; $43c7
.nibble3:
	call ShiftNibbleIntoChecksum ; $43ca
	ld a, e ; $43cd
	and $0f ; $43ce
	or $80 ; $43d0
	call SendByteGetReplySlave ; $43d2
	ld b, a ; $43d5
	and $c0 ; $43d6
	cp $40 ; $43d8
	jr z, .nibble4 ; $43da
	call LinkErrorReset ; $43dc
.nibble4:
	call ShiftNibbleIntoChecksum ; $43df
	ld a, LINKMSG_BLOCK_OK ; $43e2
	call SendByteGetReplySlave ; $43e4
	ld b, a ; $43e7
	and $c0 ; $43e8
	cp $40 ; $43ea
	jr z, .done ; $43ec
	call LinkErrorReset ; $43ee
.done:
	call ShiftNibbleIntoChecksum ; $43f1
	pop bc ; $43f4
	ret ; $43f5
ShiftNibbleIntoChecksum:
	sla l ; $43f6
	rl h ; $43f8
	sla l ; $43fa
	rl h ; $43fc
	sla l ; $43fe
	rl h ; $4400
	sla l ; $4402
	rl h ; $4404
	ld a, b ; $4406
	and $0f ; $4407
	or l ; $4409
	ld l, a ; $440a
	ret ; $440b
ComputeNibbleBufferChecksum:
	push af ; $440c
	push bc ; $440d
	push de ; $440e
	push hl ; $440f
	ld hl, wLinkNibbleBuffer ; $4410
	ld de, $0000 ; $4413
.sumLoop:
	ld a, [hl+] ; $4416
	add e ; $4417
	ld e, a ; $4418
	jr nc, .next ; $4419
	inc d ; $441b
.next:
	dec c ; $441c
	jr nz, .sumLoop ; $441d
	ld a, e ; $441f
	ldh [hLinkBlockChecksum], a ; $4420
	ld a, d ; $4422
	ldh [hLinkBlockChecksum + 1], a ; $4423
	pop hl ; $4425
	pop de ; $4426
	pop bc ; $4427
	pop af ; $4428
	ret ; $4429
Unused_07_SendNibbleBlockSlave:
	push af ; $442a
	push bc ; $442b
	push de ; $442c
	push hl ; $442d
	call UnpackBytesToNibbles ; $442e
	jr nc, .haveLength ; $4431
	scf ; $4433
	jp .done ; $4434
.haveLength:
	ld c, a ; $4437
.startBlock:
	ld a, LINKMSG_SYNC_MASTER ; $4438
	ld b, LINKMSG_SYNC_SLAVE ; $443a
	call Unused_07_SendByteAwaitEchoSlave ; $443c
	jr c, .startBlock ; $443f
	ld hl, wLinkNibbleBuffer ; $4441
	ld de, $0000 ; $4444
	ld b, c ; $4447
.sendLoop:
	ld a, [hl+] ; $4448
	ldh [hLinkTxByte], a ; $4449
	add e ; $444b
	ld e, a ; $444c
	jr nc, .sendByte ; $444d
	inc d ; $444f
.sendByte:
	di ; $4450
	ldh a, [hLinkTxByte] ; $4451
	or $80 ; $4453
	ldh [rSB], a ; $4455
	push af ; $4457
	ld a, SC_FAST | SC_EXTERNAL ; $4458
	ldh [rSC], a ; $445a
	ld a, SC_START | SC_FAST | SC_EXTERNAL ; $445c
	ldh [rSC], a ; $445e
	pop af ; $4460
	ei ; $4461
	call WaitSerialTransfer ; $4462
	call PollSerialResponse ; $4465
	jr c, .sendByte ; $4468
	xor a ; $446a
	ldh [hLinkCounter], a ; $446b
	dec b ; $446d
	jr nz, .sendLoop ; $446e
.sendBlockEnd:
	ld a, LINKMSG_BLOCK_END ; $4470
	ld b, LINKMSG_BLOCK_END_ACK ; $4472
	call Unused_07_SendByteAwaitEchoSlave ; $4474
	jr c, .sendBlockEnd ; $4477
	ld hl, $0000 ; $4479
.compareChecksum:
	ld a, LINKMSG_CHECKSUM ; $447c
	call SendByteGetReplySlave ; $447e
	cp $cd ; $4481
	jr z, .checksumOk ; $4483
	ld b, a ; $4485
	and $c0 ; $4486
	cp $40 ; $4488
	jr nz, .compareChecksum ; $448a
	sla l ; $448c
	rl h ; $448e
	sla l ; $4490
	rl h ; $4492
	sla l ; $4494
	rl h ; $4496
	sla l ; $4498
	rl h ; $449a
	ld a, b ; $449c
	and $0f ; $449d
	or l ; $449f
	ld l, a ; $44a0
	jr .compareChecksum ; $44a1
.checksumOk:
	push hl ; $44a3
	push de ; $44a4
	ld a, l ; $44a5
	sub e ; $44a6
	ld l, a ; $44a7
	ld a, h ; $44a8
	sbc d ; $44a9
	ld h, a ; $44aa
	ld a, h ; $44ab
	or l ; $44ac
	pop de ; $44ad
	pop hl ; $44ae
	jr nz, .startBlock ; $44af
.retry:
	ld a, $80 ; $44b1
	call SendByteGetReplySlave ; $44b3
	cp $40 ; $44b6
	jr nz, .retry ; $44b8
	scf ; $44ba
	ccf ; $44bb
.done:
	pop hl ; $44bc
	pop de ; $44bd
	pop bc ; $44be
	pop af ; $44bf
	ret ; $44c0
Unused_07_ReceiveNibbleBlockMaster:
	push af ; $44c1
	push bc ; $44c2
	push de ; $44c3
	push hl ; $44c4
	call EnableSerialAndVBlankInterrupts ; $44c5
.startBlock:
	ld a, LINKMSG_SYNC_SLAVE ; $44c8
	ld b, LINKMSG_SYNC_MASTER ; $44ca
	call SendByteAwaitEchoMaster ; $44cc
	jr c, .startBlock ; $44cf
	ld hl, wLinkByteBuffer ; $44d1
	ld de, $0000 ; $44d4
	ld b, $00 ; $44d7
.nibbleLoop:
	ld a, $40 ; $44d9
	ldh [rSB], a ; $44db
	push af ; $44dd
	ld a, SC_FAST | SC_INTERNAL ; $44de
	ldh [rSC], a ; $44e0
	ld a, SC_START | SC_FAST | SC_INTERNAL ; $44e2
	ldh [rSC], a ; $44e4
	pop af ; $44e6
	call ShortDelay ; $44e7
	call PollSerialResponse ; $44ea
	jr c, .nibbleLoop ; $44ed
	cp $c5 ; $44ef
	jr z, .compareChecksum ; $44f1
	and $3f ; $44f3
	ld [hl+], a ; $44f5
	add e ; $44f6
	ld e, a ; $44f7
	jr nc, .nextNibble ; $44f8
	inc d ; $44fa
.nextNibble:
	xor a ; $44fb
	ldh [hLinkCounter], a ; $44fc
	inc b ; $44fe
	ld a, b ; $44ff
	cp $40 ; $4500
	jr c, .nibbleLoop ; $4502
	call LinkErrorReset ; $4504
.compareChecksum:
	ld a, LINKMSG_BLOCK_END_ACK ; $4507
	call SendByteGetReplyMaster ; $4509
	ld a, d ; $450c
	or $40 ; $450d
	call SendByteGetReplyMaster ; $450f
	ld a, e ; $4512
	or $40 ; $4513
	call SendByteGetReplyMaster ; $4515
	ld a, LINKMSG_BLOCK_OK ; $4518
	call SendByteGetReplyMaster ; $451a
.retry:
	ld a, $40 ; $451d
	call SendByteGetReplyMaster ; $451f
	cp $c3 ; $4522
	jr z, .startBlock ; $4524
	cp $80 ; $4526
	jr nz, .retry ; $4528
	pop hl ; $452a
	pop de ; $452b
	pop bc ; $452c
	pop af ; $452d
	ret ; $452e
PollSerialResponse:
	push bc ; $452f
	di ; $4530
	ldh a, [hLinkRxByte] ; $4531
	ld b, a ; $4533
	cp $00 ; $4534
	jr z, .noReply ; $4536
	cp $ff ; $4538
	jr z, .noReply ; $453a
	xor a ; $453c
	ldh [hLinkCounter], a ; $453d
	scf ; $453f
	ccf ; $4540
	jr .done ; $4541
.noReply:
	call IncrementLinkFrameCounter ; $4543
	scf ; $4546
.done:
	ei ; $4547
	ld a, b ; $4548
	pop bc ; $4549
	ret ; $454a
SendByteAwaitEchoMaster:
	push bc ; $454b
	ldh [hLinkTxByte], a ; $454c
	ld c, $14 ; $454e
.sendLoop:
	di ; $4550
	ldh a, [hLinkTxByte] ; $4551
	ldh [rSB], a ; $4553
	push af ; $4555
	ld a, SC_FAST | SC_INTERNAL ; $4556
	ldh [rSC], a ; $4558
	ld a, SC_START | SC_FAST | SC_INTERNAL ; $455a
	ldh [rSC], a ; $455c
	pop af ; $455e
	ei ; $455f
	call WaitSerialTransfer ; $4560
	call ShortDelay ; $4563
	call ShortDelay ; $4566
	di ; $4569
	ldh a, [hLinkRxByte] ; $456a
	ei ; $456c
	cp $00 ; $456d
	jr z, .retry ; $456f
	cp $ff ; $4571
	jr z, .retry ; $4573
	cp b ; $4575
	jr z, .success ; $4576
	xor a ; $4578
	ldh [hLinkCounter], a ; $4579
	dec c ; $457b
	jr nz, .sendLoop ; $457c
	scf ; $457e
	jr .done ; $457f
.retry:
	call IncrementLinkFrameCounter ; $4581
	jr .sendLoop ; $4584
.success:
	scf ; $4586
	ccf ; $4587
.done:
	pop bc ; $4588
	ret ; $4589
Unused_07_SendByteAwaitEchoSlave:
	push bc ; $458a
	ldh [hLinkTxByte], a ; $458b
	ld c, $1e ; $458d
.sendLoop:
	di ; $458f
	ldh a, [hLinkTxByte] ; $4590
	ldh [rSB], a ; $4592
	push af ; $4594
	ld a, SC_FAST | SC_EXTERNAL ; $4595
	ldh [rSC], a ; $4597
	ld a, SC_START | SC_FAST | SC_EXTERNAL ; $4599
	ldh [rSC], a ; $459b
	pop af ; $459d
	ei ; $459e
	call WaitSerialTransfer ; $459f
	ldh a, [hLinkRxByte] ; $45a2
	cp $00 ; $45a4
	jr z, .retry ; $45a6
	cp $ff ; $45a8
	jr z, .retry ; $45aa
	cp b ; $45ac
	jr z, .success ; $45ad
	xor a ; $45af
	ldh [hLinkCounter], a ; $45b0
	dec c ; $45b2
	jr nz, .sendLoop ; $45b3
	scf ; $45b5
	jr .done ; $45b6
.retry:
	call IncrementLinkFrameCounter ; $45b8
	jr .sendLoop ; $45bb
.success:
	scf ; $45bd
	ccf ; $45be
.done:
	pop bc ; $45bf
	ret ; $45c0
SendByteGetReplyMaster:
	push bc ; $45c1
	ldh [hLinkTxByte], a ; $45c2
	ld c, $64 ; $45c4
.sendLoop:
	ei ; $45c6
	nop ; $45c7
	di ; $45c8
	ldh a, [hLinkTxByte] ; $45c9
	ldh [rSB], a ; $45cb
	push af ; $45cd
	ld a, SC_FAST | SC_INTERNAL ; $45ce
	ldh [rSC], a ; $45d0
	ld a, SC_START | SC_FAST | SC_INTERNAL ; $45d2
	ldh [rSC], a ; $45d4
	pop af ; $45d6
	ei ; $45d7
	call WaitSerialTransfer ; $45d8
	call ShortDelay ; $45db
	call ShortDelay ; $45de
	di ; $45e1
	ldh a, [hLinkRxByte] ; $45e2
	cp $00 ; $45e4
	jr z, .retry ; $45e6
	cp $ff ; $45e8
	jr z, .retry ; $45ea
	jr .done ; $45ec
.retry:
	dec c ; $45ee
	jr nz, .sendLoop ; $45ef
	ei ; $45f1
	call LinkErrorReset ; $45f2
.done:
	ei ; $45f5
	pop bc ; $45f6
	ret ; $45f7
Unused_07_SendByteAwaitReplyMaster:
	push bc ; $45f8
	ldh [hLinkTxByte], a ; $45f9
.sendLoop:
	ldh a, [hLinkTxByte] ; $45fb
	ldh [rSB], a ; $45fd
	push af ; $45ff
	ld a, SC_FAST | SC_INTERNAL ; $4600
	ldh [rSC], a ; $4602
	ld a, SC_START | SC_FAST | SC_INTERNAL ; $4604
	ldh [rSC], a ; $4606
	pop af ; $4608
	call AdvanceFrame ; $4609
	ldh a, [hLinkRxByte] ; $460c
	cp $00 ; $460e
	jr z, .retry ; $4610
	cp $ff ; $4612
	jr z, .retry ; $4614
	ld b, a ; $4616
	xor a ; $4617
	ldh [hLinkCounter], a ; $4618
	ld a, b ; $461a
	jr .done ; $461b
.retry:
	call IncrementLinkFrameCounter ; $461d
	jr .sendLoop ; $4620
.done:
	pop bc ; $4622
	ret ; $4623
SendByteGetReplySlave:
	push bc ; $4624
	di ; $4625
	ldh [hLinkTxPending], a ; $4626
	ldh [hLinkTxByte], a ; $4628
	ldh a, [rIF] ; $462a
	and $f7 ; $462c
	ldh [rIF], a ; $462e
	xor a ; $4630
	ldh [hLinkTransferDone], a ; $4631
	ei ; $4633
	ld c, $64 ; $4634
.waitLoop:
	call WaitSerialTransfer ; $4636
	jr c, .retry ; $4639
	di ; $463b
	ldh a, [hLinkRxByte] ; $463c
	ei ; $463e
	cp $00 ; $463f
	jr z, .retry ; $4641
	cp $ff ; $4643
	jr z, .retry ; $4645
	ld b, a ; $4647
	xor a ; $4648
	ldh [hLinkCounter], a ; $4649
	ld a, b ; $464b
	jr .done ; $464c
.retry:
	dec c ; $464e
	jr nz, .waitLoop ; $464f
	call LinkErrorReset ; $4651
.done:
	pop bc ; $4654
	ret ; $4655
