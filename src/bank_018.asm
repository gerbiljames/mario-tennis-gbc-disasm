INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $18", ROMX[$4000], BANK[$18]

FarPtr_18_00:
	dw Func_18_4328 ; $4000
FarPtr_18_02:
	dw Func_18_4339 ; $4002
FarPtr_18_04:
	dw Func_18_439a ; $4004
FarPtr_18_06:
	dw Func_18_437c ; $4006
	INCBIN "data/bank_018/d_4008.bin" ; $4008, 14 bytes
FarPtr_18_16:
	dw Func_18_449b ; $4016
	INCBIN "data/bank_018/d_4018.bin" ; $4018, 4 bytes
FarPtr_18_1c:
	dw Func_18_44ef ; $401c
	INCBIN "data/bank_018/d_401e.bin" ; $401e, 2 bytes
FarPtr_18_20:
	dw Func_18_59c1 ; $4020
	INCBIN "data/bank_018/d_4022.bin" ; $4022, 2 bytes
FarPtr_18_24:
	dw Func_18_4507 ; $4024
FarPtr_18_26:
	dw Func_18_452a ; $4026
FarPtr_18_28:
	dw Func_18_4557 ; $4028
	INCBIN "data/bank_018/d_402a.bin" ; $402a, 4 bytes
FarPtr_18_2e:
	dw Func_18_5418 ; $402e
	INCBIN "data/bank_018/d_4030.bin" ; $4030, 4 bytes
FarPtr_18_34:
	dw Func_18_5469 ; $4034
	INCBIN "data/bank_018/d_4036.bin" ; $4036, 14 bytes
FarPtr_18_44:
	dw Func_18_5ab9 ; $4044
FarPtr_18_46:
	dw Func_18_5ace ; $4046
	INCBIN "data/bank_018/d_4048.bin" ; $4048, 70 bytes
FarPtr_18_8e:
	dw Func_18_7617 ; $408e
	INCBIN "data/bank_018/d_4090.bin" ; $4090, 664 bytes
Func_18_4328:
	push af ; $4328
	push bc ; $4329
	push de ; $432a
	push hl ; $432b
	ld hl, $4300 ; $432c
	ld e, $05 ; $432f
	call Func_00_05b0 ; $4331
	pop hl ; $4334
	pop de ; $4335
	pop bc ; $4336
	pop af ; $4337
	ret ; $4338
Func_18_4339:
	push af ; $4339
	push bc ; $433a
	push de ; $433b
	push hl ; $433c
	and a, $0f ; $433d
	add a, a ; $433f
	add a, a ; $4340
	add a, a ; $4341
	add a, $00 ; $4342
	ld l, a ; $4344
	adc a, $43 ; $4345
	sub a, l ; $4347
	ld h, a ; $4348
	ld e, $01 ; $4349
	call Func_00_05b0 ; $434b
	pop hl ; $434e
	pop de ; $434f
	pop bc ; $4350
	pop af ; $4351
	ret ; $4352
Func_18_4353:
	ld a, [$cb61] ; $4353
	and a, $0f ; $4356
	jr z, Label_18_4365 ; $4358
	ld hl, $d800 ; $435a
	ld de, $9800 ; $435d
	ld c, $24 ; $4360
	call Func_00_0480 ; $4362
Label_18_4365:
	ld a, [$cb61] ; $4365
	and a, $f0 ; $4368
	jr z, Label_18_4377 ; $436a
	ld hl, $dc00 ; $436c
	ld de, $b800 ; $436f
	ld c, $24 ; $4372
	call Func_00_0480 ; $4374
Label_18_4377:
	xor a, a ; $4377
	ld [$cb61], a ; $4378
	ret ; $437b
Func_18_437c:
	push hl ; $437c
	ld hl, $42e0 ; $437d
	call Func_00_05b0 ; $4380
	pop de ; $4383
	ld hl, $42a0 ; $4384
	ld c, $04 ; $4387
	call Func_00_0480 ; $4389
	ret ; $438c
	INCBIN "data/bank_018/d_438d.bin" ; $438d, 13 bytes
Func_18_439a:
	push bc ; $439a
	ld c, $20 ; $439b
	farcall FarPtr_05_1c ; $439d
	pop bc ; $43a0
	ret ; $43a1
	INCBIN "data/bank_018/d_43a2.bin" ; $43a2, 162 bytes
Func_18_4444:
	push af ; $4444
	push hl ; $4445
	ldh a, [$ff8c] ; $4446
	and a, $0f ; $4448
	add a, $68 ; $444a
	ld l, a ; $444c
	adc a, $44 ; $444d
	sub a, l ; $444f
	ld h, a ; $4450
	ld a, [hl] ; $4451
	add a, d ; $4452
	ld d, a ; $4453
	ldh a, [$ff8c] ; $4454
	add a, $04 ; $4456
	and a, $0f ; $4458
	add a, $68 ; $445a
	ld l, a ; $445c
	adc a, $44 ; $445d
	sub a, l ; $445f
	ld h, a ; $4460
	ld a, [hl] ; $4461
	cpl ; $4462
	add a, e ; $4463
	ld e, a ; $4464
	pop af ; $4465
	pop hl ; $4466
	ret ; $4467
	INCBIN "data/bank_018/d_4468.bin" ; $4468, 51 bytes
Func_18_449b:
	push af ; $449b
	push hl ; $449c
	ldh a, [$ff8c] ; $449d
	and a, $3f ; $449f
	add a, $ae ; $44a1
	ld l, a ; $44a3
	adc a, $44 ; $44a4
	sub a, l ; $44a6
	ld h, a ; $44a7
	ld a, [hl] ; $44a8
	add a, e ; $44a9
	ld e, a ; $44aa
	pop af ; $44ab
	pop hl ; $44ac
	ret ; $44ad
	INCBIN "data/bank_018/d_44ae.bin" ; $44ae, 65 bytes
Func_18_44ef:
	push af ; $44ef
	push bc ; $44f0
	ld b, a ; $44f1
Label_18_44f2:
	ld a, [hl] ; $44f2
	cp a, b ; $44f3
	jr z, Label_18_4503 ; $44f4
	cp a, $ff ; $44f6
	jr z, Label_18_4503 ; $44f8
	ld a, $08 ; $44fa
	add a, l ; $44fc
	ld l, a ; $44fd
	jr nc, Label_18_4501 ; $44fe
	inc h ; $4500
Label_18_4501:
	jr Label_18_44f2 ; $4501
Label_18_4503:
	add hl, de ; $4503
	pop bc ; $4504
	pop af ; $4505
	ret ; $4506
Func_18_4507:
	cp a, $84 ; $4507
	jr z, Label_18_4522 ; $4509
	push af ; $450b
	push bc ; $450c
	push de ; $450d
	push hl ; $450e
	farcall FarPtr_02_1a ; $450f
	ld hl, $ca80 ; $4512
	ld de, $d580 ; $4515
	ld c, $08 ; $4518
	call CopyMemoryFast ; $451a
	pop hl ; $451d
	pop de ; $451e
	pop bc ; $451f
	pop af ; $4520
	ret ; $4521
Label_18_4522:
	push af ; $4522
	ld a, $3e ; $4523
	ld [$d58b], a ; $4525
	pop af ; $4528
	ret ; $4529
Func_18_452a:
	bit 7, a ; $452a
	jr z, Label_18_4534 ; $452c
	ld a, [$d58b] ; $452e
	cp a, $ff ; $4531
	ret ; $4533
Label_18_4534:
	cp a, $04 ; $4534
	jr nc, Label_18_453b ; $4536
	cp a, $ff ; $4538
	ret ; $453a
Label_18_453b:
	push hl ; $453b
	push de ; $453c
	ld h, $00 ; $453d
	ld l, a ; $453f
	add hl, hl ; $4540
	add hl, hl ; $4541
	add hl, hl ; $4542
	add hl, hl ; $4543
	add hl, hl ; $4544
	ld d, h ; $4545
	ld e, l ; $4546
	farcall FarPtr_03_1c ; $4547
	pop de ; $454a
	pop hl ; $454b
	ret ; $454c
	INCBIN "data/bank_018/d_454d.bin" ; $454d, 10 bytes
Func_18_4557:
	bit 7, a ; $4557
	jr z, Label_18_4564 ; $4559
	cp a, $84 ; $455b
	jr nz, Label_18_4562 ; $455d
	cp a, $ff ; $455f
	ret ; $4561
Label_18_4562:
	xor a, a ; $4562
	ret ; $4563
Label_18_4564:
	push hl ; $4564
	push de ; $4565
	ld hl, $458a ; $4566
	add a, a ; $4569
	add a, l ; $456a
	ld l, a ; $456b
	jr nc, Label_18_456f ; $456c
	inc h ; $456e
Label_18_456f:
	ld a, [hl+] ; $456f
	ld d, [hl] ; $4570
	ld e, a ; $4571
	or a, d ; $4572
	jr nz, Label_18_4579 ; $4573
	cp a, $ff ; $4575
	jr Label_18_4587 ; $4577
Label_18_4579:
	bit 0, e ; $4579
	jr nz, Label_18_4582 ; $457b
	call Func_00_249f ; $457d
	jr Label_18_4587 ; $4580
Label_18_4582:
	res 0, e ; $4582
	farcall FarPtr_03_1c ; $4584
Label_18_4587:
	pop de ; $4587
	pop hl ; $4588
	ret ; $4589
	INCBIN "data/bank_018/d_458a.bin" ; $458a, 3726 bytes
Func_18_5418:
	ld a, $ff ; $5418
	ld [$cb61], a ; $541a
	call Func_18_4353 ; $541d
	ret ; $5420
	INCBIN "data/bank_018/d_5421.bin" ; $5421, 72 bytes
Func_18_5469:
	ldh a, [$ff94] ; $5469
	and a, $20 ; $546b
	jr z, Label_18_5473 ; $546d
	ld b, $00 ; $546f
	rst Rst08 ; $5471
	ld e, [hl] ; $5472
Label_18_5473:
	ldh a, [$ff94] ; $5473
	and a, $10 ; $5475
	jr z, Label_18_547d ; $5477
	ld b, $01 ; $5479
	rst Rst08 ; $547b
	ld e, [hl] ; $547c
Label_18_547d:
	ldh a, [$ff94] ; $547d
	and a, $01 ; $547f
	jr nz, Label_18_54a7 ; $5481
	ldh a, [$ff94] ; $5483
	and a, $02 ; $5485
	jr z, Label_18_548d ; $5487
	ld b, $ff ; $5489
	jr Label_18_54a7 ; $548b
Label_18_548d:
	ld de, $2892 ; $548d
	ld a, b ; $5490
	and a, a ; $5491
	jr z, Label_18_5497 ; $5492
	ld de, $5892 ; $5494
Label_18_5497:
	call Func_18_4444 ; $5497
	push bc ; $549a
	ld bc, $0650 ; $549b
	call Func_00_1e55 ; $549e
	pop bc ; $54a1
	call Func_00_2631 ; $54a2
	jr Func_18_5469 ; $54a5
Label_18_54a7:
	ld a, b ; $54a7
	and a, a ; $54a8
	jr z, Label_18_54ae ; $54a9
	rst Rst08 ; $54ab
	ld h, d ; $54ac
	ret ; $54ad
Label_18_54ae:
	rst Rst08 ; $54ae
	ld e, a ; $54af
	ret ; $54b0
	INCBIN "data/bank_018/d_54b1.bin" ; $54b1, 1296 bytes
Func_18_59c1:
	ld hl, $58e0 ; $59c1
	ld de, $8400 ; $59c4
	ld c, $0c ; $59c7
	call Func_00_0480 ; $59c9
	ld hl, $59b9 ; $59cc
	ld de, $0a01 ; $59cf
	call Func_00_05b0 ; $59d2
	ret ; $59d5
	INCBIN "data/bank_018/d_59d6.bin" ; $59d6, 227 bytes
Func_18_5ab9:
	ld h, a ; $5ab9
	ld l, $00 ; $5aba
	srl h ; $5abc
	rr l ; $5abe
	srl h ; $5ac0
	rr l ; $5ac2
	ld bc, $5af0 ; $5ac4
	add hl, bc ; $5ac7
	ld c, $04 ; $5ac8
	call Func_00_0480 ; $5aca
	ret ; $5acd
Func_18_5ace:
	cp a, $ff ; $5ace
	jr z, Label_18_5ae7 ; $5ad0
	ld h, a ; $5ad2
	ld l, $00 ; $5ad3
	srl h ; $5ad5
	rr l ; $5ad7
	srl h ; $5ad9
	rr l ; $5adb
	ld bc, $62f0 ; $5add
	add hl, bc ; $5ae0
	ld c, $04 ; $5ae1
	call Func_00_0480 ; $5ae3
	ret ; $5ae6
Label_18_5ae7:
	ld hl, $6af0 ; $5ae7
	ld c, $04 ; $5aea
	call Func_00_0480 ; $5aec
	ret ; $5aef
	INCBIN "data/bank_018/d_5af0.bin" ; $5af0, 6951 bytes
Func_18_7617:
	ld a, c ; $7617
	ld [$cb6d], a ; $7618
	call Func_18_7632 ; $761b
	ld a, b ; $761e
	or a, a ; $761f
	jr nz, Label_18_7626 ; $7620
	call Func_18_76b4 ; $7622
	ret ; $7625
Label_18_7626:
	cp a, $01 ; $7626
	jr nz, Label_18_762e ; $7628
	call Func_18_77bb ; $762a
	ret ; $762d
Label_18_762e:
	call Func_18_792c ; $762e
	ret ; $7631
Func_18_7632:
	call EnableLCD ; $7632
	ld c, $10 ; $7635
	call Func_00_1d20 ; $7637
	call Func_00_1da4 ; $763a
	call DisableLCDSafely ; $763d
	call Func_00_1b38 ; $7640
	call Func_18_7647 ; $7643
	ret ; $7646
Func_18_7647:
	xor a, a ; $7647
	ldh [$ff8b], a ; $7648
	ldh [$ff8a], a ; $764a
	ld [$c320], a ; $764c
	ld [$c321], a ; $764f
	ld [$c322], a ; $7652
	ld [$c323], a ; $7655
	ret ; $7658
	INCBIN "data/bank_018/d_7659.bin" ; $7659, 91 bytes
Func_18_76b4:
	call Func_18_7720 ; $76b4
	call Func_18_7740 ; $76b7
	call EnableLCD ; $76ba
	ld c, $02 ; $76bd
	call Func_00_1d2e ; $76bf
	call Func_00_1da4 ; $76c2
	ld a, $03 ; $76c5
	ldh [$ff96], a ; $76c7
	ldh [rWBK], a ; $76c9
	xor a, a ; $76cb
	ld [$da01], a ; $76cc
Label_18_76cf:
	call Func_00_2631 ; $76cf
	ld a, [$da01] ; $76d2
	inc a ; $76d5
	ld [$da01], a ; $76d6
	cp a, $fa ; $76d9
	jr nz, Label_18_76cf ; $76db
	farcall FarPtr_03_40 ; $76dd
	ld b, $3f ; $76e0
	ld c, $3f ; $76e2
	ld d, $1e ; $76e4
	farcall FarPtr_03_42 ; $76e6
	farcall FarPtr_03_44 ; $76e9
Label_18_76ec:
	call Func_00_2631 ; $76ec
	ldh a, [$ff91] ; $76ef
	and a, $03 ; $76f1
	jr z, Label_18_76ec ; $76f3
	ld c, $10 ; $76f5
	call Func_00_1d20 ; $76f7
	call Func_00_1da4 ; $76fa
	call DisableLCDSafely ; $76fd
	call Func_18_7855 ; $7700
	call EnableLCD ; $7703
	ld c, $10 ; $7706
	call Func_00_1d2e ; $7708
	call Func_00_1da4 ; $770b
	ld a, $01 ; $770e
	ld hl, $775c ; $7710
	call Func_00_1b6a ; $7713
Label_18_7716:
	call Func_00_2631 ; $7716
	ldh a, [$ff91] ; $7719
	and a, $03 ; $771b
	jr z, Label_18_7716 ; $771d
	ret ; $771f
Func_18_7720:
	call Func_18_7647 ; $7720
	call Func_18_772d ; $7723
	farcall FarPtr_39_00 ; $7726
	farcall FarPtr_39_02 ; $7729
	ret ; $772c
Func_18_772d:
	ld a, [$cb6d] ; $772d
	ld hl, $773a ; $7730
	add a, l ; $7733
	ld l, a ; $7734
	jr nc, Label_18_7738 ; $7735
	inc h ; $7737
Label_18_7738:
	ld c, [hl] ; $7738
	ret ; $7739
	INCBIN "data/bank_018/d_773a.bin" ; $773a, 6 bytes
Func_18_7740:
	ld b, $06 ; $7740
	ld c, $28 ; $7742
	ld de, $8000 ; $7744
	farcall FarPtr_39_10 ; $7747
	ld hl, $7754 ; $774a
	ld de, $0801 ; $774d
	call Func_00_05b0 ; $7750
	ret ; $7753
	INCBIN "data/bank_018/d_7754.bin" ; $7754, 103 bytes
Func_18_77bb:
	call Func_18_7835 ; $77bb
	call Func_18_7bce ; $77be
	ld a, $01 ; $77c1
	ld hl, $7b36 ; $77c3
	call Func_00_1b6a ; $77c6
	ld a, $01 ; $77c9
	ld hl, $7b6e ; $77cb
	call Func_00_1b6a ; $77ce
	rst Rst08 ; $77d1
	inc l ; $77d2
	call EnableLCD ; $77d3
	ld c, $02 ; $77d6
	call Func_00_1d2e ; $77d8
	call Func_00_1da4 ; $77db
	ld a, $03 ; $77de
	ldh [$ff96], a ; $77e0
	ldh [rWBK], a ; $77e2
	xor a, a ; $77e4
	ld [$da01], a ; $77e5
Label_18_77e8:
	call Func_00_2631 ; $77e8
	ldh a, [$ff8c] ; $77eb
	and a, $03 ; $77ed
	jr nz, Label_18_77e8 ; $77ef
	ld a, [$da01] ; $77f1
	inc a ; $77f4
	ld [$da01], a ; $77f5
	cp a, $af ; $77f8
	jr nz, Label_18_77e8 ; $77fa
	ld c, $01 ; $77fc
	call Func_00_1d20 ; $77fe
	call Func_00_1da4 ; $7801
	call Func_00_1b38 ; $7804
	call DisableLCDSafely ; $7807
	farcall FarPtr_03_36 ; $780a
	call DisableLCDSafely ; $780d
	call Func_18_78b1 ; $7810
	call Func_18_7855 ; $7813
	ld a, $01 ; $7816
	ld hl, $78cd ; $7818
	call Func_00_1b6a ; $781b
	call EnableLCD ; $781e
	ld c, $40 ; $7821
	call Func_00_1d2e ; $7823
	call Func_00_1da4 ; $7826
	rst Rst08 ; $7829
	dec l ; $782a
Label_18_782b:
	call Func_00_2631 ; $782b
	ldh a, [$ff91] ; $782e
	and a, $03 ; $7830
	jr z, Label_18_782b ; $7832
	ret ; $7834
Func_18_7835:
	call Func_18_7647 ; $7835
	call Func_18_7842 ; $7838
	farcall FarPtr_39_00 ; $783b
	farcall FarPtr_39_02 ; $783e
	ret ; $7841
Func_18_7842:
	ld a, [$cb6d] ; $7842
	ld hl, $784f ; $7845
	add a, l ; $7848
	ld l, a ; $7849
	jr nc, Label_18_784d ; $784a
	inc h ; $784c
Label_18_784d:
	ld c, [hl] ; $784d
	ret ; $784e
	INCBIN "data/bank_018/d_784f.bin" ; $784f, 6 bytes
Func_18_7855:
	call Func_18_7647 ; $7855
	ld c, $32 ; $7858
	farcall FarPtr_39_00 ; $785a
	ld hl, $78a9 ; $785d
	ld de, $0001 ; $7860
	call Func_00_05b0 ; $7863
	ld hl, $78a9 ; $7866
	ld de, $0101 ; $7869
	call Func_00_05b0 ; $786c
	ld hl, $78a9 ; $786f
	ld de, $0201 ; $7872
	call Func_00_05b0 ; $7875
	ld hl, $78a9 ; $7878
	ld de, $0301 ; $787b
	call Func_00_05b0 ; $787e
	ld hl, $78a9 ; $7881
	ld de, $0401 ; $7884
	call Func_00_05b0 ; $7887
	ld hl, $78a9 ; $788a
	ld de, $0501 ; $788d
	call Func_00_05b0 ; $7890
	ld hl, $78a9 ; $7893
	ld de, $0601 ; $7896
	call Func_00_05b0 ; $7899
	ld hl, $78a9 ; $789c
	ld de, $0701 ; $789f
	call Func_00_05b0 ; $78a2
	farcall FarPtr_39_02 ; $78a5
	ret ; $78a8
	INCBIN "data/bank_018/d_78a9.bin" ; $78a9, 8 bytes
Func_18_78b1:
	ld b, $07 ; $78b1
	ld c, $28 ; $78b3
	ld de, $8000 ; $78b5
	farcall FarPtr_39_10 ; $78b8
	ld hl, $78c5 ; $78bb
	ld de, $0801 ; $78be
	call Func_00_05b0 ; $78c1
	ret ; $78c4
	INCBIN "data/bank_018/d_78c5.bin" ; $78c5, 103 bytes
Func_18_792c:
	call Func_18_7647 ; $792c
	rst Rst08 ; $792f
	add hl, bc ; $7930
	call Func_18_7a07 ; $7931
	farcall FarPtr_39_00 ; $7934
	farcall FarPtr_39_02 ; $7937
	call Func_18_7d03 ; $793a
	ld a, $01 ; $793d
	ld hl, $7b36 ; $793f
	call Func_00_1b6a ; $7942
	ld a, $01 ; $7945
	ld hl, $7b6e ; $7947
	call Func_00_1b6a ; $794a
	call EnableLCD ; $794d
	ld c, $01 ; $7950
	call Func_00_1d2e ; $7952
	call Func_00_1da4 ; $7955
Label_18_7958:
	call Func_00_2631 ; $7958
	ldh a, [$ff91] ; $795b
	and a, $03 ; $795d
	jr z, Label_18_7958 ; $795f
	ld c, $02 ; $7961
	call Func_00_1d20 ; $7963
	call Func_00_1da4 ; $7966
	ld de, $05e0 ; $7969
	call Func_00_249f ; $796c
	jr z, Label_18_797b ; $796f
	ld de, $1700 ; $7971
	call Func_00_249f ; $7974
	jr z, Label_18_7985 ; $7977
	jr Label_18_798a ; $7979
Label_18_797b:
	ld de, $16e0 ; $797b
	call Func_00_249f ; $797e
	jr z, Label_18_7985 ; $7981
	jr Label_18_798a ; $7983
Label_18_7985:
	rst Rst08 ; $7985
	inc l ; $7986
	farcall FarPtr_0a_a2 ; $7987
Label_18_798a:
	ld a, $03 ; $798a
	ldh [$ff96], a ; $798c
	ldh [rWBK], a ; $798e
	xor a, a ; $7990
	ld [$da00], a ; $7991
	call Func_00_1b38 ; $7994
	call Func_18_7647 ; $7997
	call DisableLCDSafely ; $799a
	call Func_18_7a1a ; $799d
	farcall FarPtr_39_00 ; $79a0
	farcall FarPtr_39_02 ; $79a3
	call Func_18_7a2d ; $79a6
	call EnableLCD ; $79a9
	ld c, $02 ; $79ac
	call Func_00_1d2e ; $79ae
	call Func_00_1da4 ; $79b1
	ld a, $03 ; $79b4
	ldh [$ff96], a ; $79b6
	ldh [rWBK], a ; $79b8
	xor a, a ; $79ba
	ld [$da01], a ; $79bb
Label_18_79be:
	call Func_00_2631 ; $79be
	ld a, [$da01] ; $79c1
	inc a ; $79c4
	ld [$da01], a ; $79c5
	cp a, $b4 ; $79c8
	jr nz, Label_18_79be ; $79ca
	ld a, $01 ; $79cc
	ld hl, $7a81 ; $79ce
	call Func_00_1b6a ; $79d1
	ld a, $01 ; $79d4
	ld hl, $7a49 ; $79d6
	call Func_00_1b6a ; $79d9
	rst Rst08 ; $79dc
	dec l ; $79dd
Label_18_79de:
	call Func_00_2631 ; $79de
	ldh a, [$ff91] ; $79e1
	and a, $03 ; $79e3
	jr z, Label_18_79de ; $79e5
	ld de, $0120 ; $79e7
	farcall FarPtr_03_1e ; $79ea
	ld de, $05e0 ; $79ed
	call Func_00_249f ; $79f0
	jr z, Label_18_79fd ; $79f3
	ld de, $1700 ; $79f5
	call Func_00_24ba ; $79f8
	jr Label_18_7a03 ; $79fb
Label_18_79fd:
	ld de, $16e0 ; $79fd
	call Func_00_24ba ; $7a00
Label_18_7a03:
	farcall FarPtr_03_18 ; $7a03
	ret ; $7a06
Func_18_7a07:
	ld a, [$cb6d] ; $7a07
	ld hl, $7a14 ; $7a0a
	add a, l ; $7a0d
	ld l, a ; $7a0e
	jr nc, Label_18_7a12 ; $7a0f
	inc h ; $7a11
Label_18_7a12:
	ld c, [hl] ; $7a12
	ret ; $7a13
	INCBIN "data/bank_018/d_7a14.bin" ; $7a14, 6 bytes
Func_18_7a1a:
	ld a, [$cb6d] ; $7a1a
	ld hl, $7a27 ; $7a1d
	add a, l ; $7a20
	ld l, a ; $7a21
	jr nc, Label_18_7a25 ; $7a22
	inc h ; $7a24
Label_18_7a25:
	ld c, [hl] ; $7a25
	ret ; $7a26
	INCBIN "data/bank_018/d_7a27.bin" ; $7a27, 6 bytes
Func_18_7a2d:
	ld b, $08 ; $7a2d
	ld c, $14 ; $7a2f
	ld de, $8000 ; $7a31
	farcall FarPtr_39_10 ; $7a34
	ld hl, $7a41 ; $7a37
	ld de, $0801 ; $7a3a
	call Func_00_05b0 ; $7a3d
	ret ; $7a40
	INCBIN "data/bank_018/d_7a41.bin" ; $7a41, 397 bytes
Func_18_7bce:
	ldh a, [$ff96] ; $7bce
	push af ; $7bd0
	ld a, $03 ; $7bd1
	ldh [$ff96], a ; $7bd3
	ldh [rWBK], a ; $7bd5
	ld hl, $d800 ; $7bd7
	ld bc, $0100 ; $7bda
	call ClearBytes ; $7bdd
	call Func_18_7c27 ; $7be0
	call Func_18_7be7 ; $7be3
	ret ; $7be6
Func_18_7be7:
	ld b, $00 ; $7be7
	ld c, $10 ; $7be9
	ld de, $8000 ; $7beb
	farcall FarPtr_39_10 ; $7bee
	ld b, $01 ; $7bf1
	ld c, $10 ; $7bf3
	ld de, $8100 ; $7bf5
	farcall FarPtr_39_10 ; $7bf8
	ld b, $02 ; $7bfb
	ld c, $10 ; $7bfd
	ld de, $8200 ; $7bff
	farcall FarPtr_39_10 ; $7c02
	ld hl, $7c0f ; $7c05
	ld de, $0903 ; $7c08
	call Func_00_05b0 ; $7c0b
	ret ; $7c0e
	INCBIN "data/bank_018/d_7c0f.bin" ; $7c0f, 24 bytes
Func_18_7c27:
	ld c, $00 ; $7c27
	ld hl, $7c53 ; $7c29
	ld de, $d800 ; $7c2c
Label_18_7c2f:
	push af ; $7c2f
	push bc ; $7c30
	push de ; $7c31
	push hl ; $7c32
	ld bc, $000b ; $7c33
	call CopyMemoryBC ; $7c36
	pop hl ; $7c39
	pop de ; $7c3a
	pop bc ; $7c3b
	pop af ; $7c3c
	push hl ; $7c3d
	ld hl, $0010 ; $7c3e
	add hl, de ; $7c41
	ld d, h ; $7c42
	ld e, l ; $7c43
	pop hl ; $7c44
	ld a, $0b ; $7c45
	add a, l ; $7c47
	ld l, a ; $7c48
	jr nc, Label_18_7c4c ; $7c49
	inc h ; $7c4b
Label_18_7c4c:
	inc c ; $7c4c
	ld a, c ; $7c4d
	cp a, $10 ; $7c4e
	jr nz, Label_18_7c2f ; $7c50
	ret ; $7c52
	INCBIN "data/bank_018/d_7c53.bin" ; $7c53, 176 bytes
Func_18_7d03:
	ldh a, [$ff96] ; $7d03
	push af ; $7d05
	ld a, $03 ; $7d06
	ldh [$ff96], a ; $7d08
	ldh [rWBK], a ; $7d0a
	ld hl, $d800 ; $7d0c
	ld bc, $0100 ; $7d0f
	call ClearBytes ; $7d12
	call Func_18_7d5c ; $7d15
	call Func_18_7d1c ; $7d18
	ret ; $7d1b
Func_18_7d1c:
	ld b, $03 ; $7d1c
	ld c, $10 ; $7d1e
	ld de, $8000 ; $7d20
	farcall FarPtr_39_10 ; $7d23
	ld b, $04 ; $7d26
	ld c, $10 ; $7d28
	ld de, $8100 ; $7d2a
	farcall FarPtr_39_10 ; $7d2d
	ld b, $05 ; $7d30
	ld c, $10 ; $7d32
	ld de, $8200 ; $7d34
	farcall FarPtr_39_10 ; $7d37
	ld hl, $7d44 ; $7d3a
	ld de, $0903 ; $7d3d
	call Func_00_05b0 ; $7d40
	ret ; $7d43
	INCBIN "data/bank_018/d_7d44.bin" ; $7d44, 24 bytes
Func_18_7d5c:
	ld c, $00 ; $7d5c
	ld hl, $7d88 ; $7d5e
	ld de, $d800 ; $7d61
Label_18_7d64:
	push af ; $7d64
	push bc ; $7d65
	push de ; $7d66
	push hl ; $7d67
	ld bc, $000b ; $7d68
	call CopyMemoryBC ; $7d6b
	pop hl ; $7d6e
	pop de ; $7d6f
	pop bc ; $7d70
	pop af ; $7d71
	push hl ; $7d72
	ld hl, $0010 ; $7d73
	add hl, de ; $7d76
	ld d, h ; $7d77
	ld e, l ; $7d78
	pop hl ; $7d79
	ld a, $0b ; $7d7a
	add a, l ; $7d7c
	ld l, a ; $7d7d
	jr nc, Label_18_7d81 ; $7d7e
	inc h ; $7d80
Label_18_7d81:
	inc c ; $7d81
	ld a, c ; $7d82
	cp a, $10 ; $7d83
	jr nz, Label_18_7d64 ; $7d85
	ret ; $7d87
	INCBIN "data/bank_018/d_7d88.bin" ; $7d88, 632 bytes
