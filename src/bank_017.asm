INCLUDE "hardware.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $17", ROMX[$4000], BANK[$17]

	INCBIN "data/bank_017/d_4000.bin" ; $4000, 163 bytes
Func_17_40a3:
	ldh a, [$ff8c] ; $40a3
	and a, $0f ; $40a5
	ld hl, $40bd ; $40a7
	add a, l ; $40aa
	ld l, a ; $40ab
	jr nc, Label_17_40af ; $40ac
	inc h ; $40ae
Label_17_40af:
	ld a, [hl] ; $40af
	ld b, a ; $40b0
	ld a, c ; $40b1
	or a, a ; $40b2
	jr z, Label_17_40b9 ; $40b3
	ld a, b ; $40b5
	add a, e ; $40b6
	ld e, a ; $40b7
	ret ; $40b8
Label_17_40b9:
	ld a, e ; $40b9
	sub a, b ; $40ba
	ld e, a ; $40bb
	ret ; $40bc
	INCBIN "data/bank_017/d_40bd.bin" ; $40bd, 841 bytes
	rst Rst18 ; $4406
	inc b ; $4407
	add hl, sp ; $4408
	ret ; $4409
	INCBIN "data/bank_017/d_440a.bin" ; $440a, 125 bytes
	xor a, a ; $4487
	ldh [$ffb9], a ; $4488
	ldh [$ffb8], a ; $448a
	ldh [$ff8a], a ; $448c
	ldh [$ff8b], a ; $448e
	ld [$c321], a ; $4490
	ld [$c323], a ; $4493
	call Func_00_1b38 ; $4496
	call DisableLCDSafely ; $4499
	call Func_17_4960 ; $449c
	rst Rst18 ; $449f
	adc a, h ; $44a0
	dec b ; $44a1
	call EnableLCD ; $44a2
	xor a, a ; $44a5
	ld [$cb0b], a ; $44a6
	ld a, $01 ; $44a9
	ld hl, $4406 ; $44ab
	call Func_00_1b6a ; $44ae
	ld a, $03 ; $44b1
	ld [$cb0c], a ; $44b3
	ld c, $10 ; $44b6
	call Func_00_1d2e ; $44b8
	call Func_00_1da4 ; $44bb
	ld a, [$c8f7] ; $44be
	cp a, $12 ; $44c1
	jr nc, $44e7 ; $44c3
	sub a, $03 ; $44c5
	cp a, $04 ; $44c7
	jr c, Label_17_44d3 ; $44c9
	sub a, $03 ; $44cb
	cp a, $06 ; $44cd
	jr c, Label_17_44d3 ; $44cf
	sub a, $03 ; $44d1
Label_17_44d3:
	ld a, a ; $44d3
	rst Rst00 ; $44d4
	ld a, a ; $44d5
	ld d, l ; $44d6
	rla ; $44d7
	ld e, b ; $44d8
	ld h, a ; $44d9
	ld e, h ; $44da
	sub a, d ; $44db
	ld e, a ; $44dc
	jr nc, Label_17_4541 ; $44dd
	add hl, sp ; $44df
	ld h, l ; $44e0
	ld b, d ; $44e1
	ld l, b ; $44e2
	ld [hl], e ; $44e3
	ld l, d ; $44e4
	ld [$cd6c], a ; $44e5
	jr c, Label_17_4505 ; $44e8
	ret ; $44ea
	INCBIN "data/bank_017/d_44eb.bin" ; $44eb, 26 bytes
Label_17_4505:
	ld c, $10 ; $4505
	call Func_00_1d2e ; $4507
	call Func_00_1da4 ; $450a
	ld a, $50 ; $450d
	ld [$d810], a ; $450f
	ld a, $40 ; $4512
	ld [$d811], a ; $4514
	ld a, $01 ; $4517
	ld hl, $46e2 ; $4519
	call Func_00_1b6a ; $451c
	ld a, $30 ; $451f
	ld [$d812], a ; $4521
	ld a, $20 ; $4524
	ld [$d813], a ; $4526
	ld a, $01 ; $4529
	ld hl, $470c ; $452b
	call Func_00_1b6a ; $452e
	ld a, $60 ; $4531
	ld [$d81e], a ; $4533
	ld a, $30 ; $4536
	ld [$d81f], a ; $4538
	ld a, $01 ; $453b
	ld hl, $4736 ; $453d
	INCBIN "data/bank_017/d_4540.bin" ; $4540, 1 bytes
Label_17_4541:
	ld l, d ; $4541
	dec de ; $4542
	ld a, $01 ; $4543
	ld [$d82d], a ; $4545
	ld a, $60 ; $4548
	ld [$d81c], a ; $454a
	ld a, $40 ; $454d
	ld [$d81d], a ; $454f
	ld a, $01 ; $4552
	ld hl, $4754 ; $4554
	call Func_00_1b6a ; $4557
	ld hl, $00e4 ; $455a
	call Func_17_4654 ; $455d
	call Func_17_497e ; $4560
	call Func_00_1b38 ; $4563
	ld a, $01 ; $4566
	ld hl, $4406 ; $4568
	call Func_00_1b6a ; $456b
	ld a, $09 ; $456e
	ld [$d822], a ; $4570
	ld a, $40 ; $4573
	ld [$d814], a ; $4575
	ld a, $32 ; $4578
	ld [$d815], a ; $457a
	ld a, $01 ; $457d
	ld hl, $478e ; $457f
	call Func_00_1b6a ; $4582
	ld a, $40 ; $4585
	ld [$d81a], a ; $4587
	ld a, $20 ; $458a
	ld [$d81b], a ; $458c
	ld a, $50 ; $458f
	ld [$d820], a ; $4591
	ld a, $20 ; $4594
	ld [$d821], a ; $4596
	ld a, $01 ; $4599
	ld hl, $47ef ; $459b
	call Func_00_1b6a ; $459e
	ld a, $01 ; $45a1
	ld [$d825], a ; $45a3
	ld a, $30 ; $45a6
	ld [$d823], a ; $45a8
	ld a, $20 ; $45ab
	ld [$d824], a ; $45ad
	ld a, $01 ; $45b0
	ld hl, $481c ; $45b2
	call Func_00_1b6a ; $45b5
	ld a, $01 ; $45b8
	ld [$d826], a ; $45ba
	ld a, $20 ; $45bd
	ld [$d816], a ; $45bf
	ld a, $40 ; $45c2
	ld [$d817], a ; $45c4
	ld a, $01 ; $45c7
	ld hl, $4843 ; $45c9
	call Func_00_1b6a ; $45cc
	ld a, $03 ; $45cf
	ld [$d827], a ; $45d1
	ld a, $10 ; $45d4
	ld [$d818], a ; $45d6
	ld a, $10 ; $45d9
	ld [$d819], a ; $45db
	ld a, $01 ; $45de
	ld hl, $4876 ; $45e0
	call Func_00_1b6a ; $45e3
	ld a, $18 ; $45e6
	ld [$d82a], a ; $45e8
	ld a, $08 ; $45eb
	ld [$d82b], a ; $45ed
	ld a, $20 ; $45f0
	ld [$d828], a ; $45f2
	ld a, $40 ; $45f5
	ld [$d829], a ; $45f7
	ld a, $01 ; $45fa
	ld hl, $48c1 ; $45fc
	call Func_00_1b6a ; $45ff
	ld hl, $0135 ; $4602
	call Func_17_4654 ; $4605
	ld b, $02 ; $4608
	call Func_17_466c ; $460a
	ld a, $01 ; $460d
	ld hl, $4676 ; $460f
	call Func_00_1b6a ; $4612
	call Func_17_497e ; $4615
	call Func_00_1b38 ; $4618
	ld a, $01 ; $461b
	ld hl, $4406 ; $461d
	call Func_00_1b6a ; $4620
	ld b, $00 ; $4623
	call Func_17_466c ; $4625
	ld hl, $00e4 ; $4628
	call Func_17_4654 ; $462b
	ld a, $70 ; $462e
	ld [$d81c], a ; $4630
	ld a, $20 ; $4633
	ld [$d81d], a ; $4635
	ld a, $01 ; $4638
	ld hl, $4754 ; $463a
	call Func_00_1b6a ; $463d
	ld b, $05 ; $4640
	call Func_17_466c ; $4642
	ld a, $01 ; $4645
	ld hl, $4676 ; $4647
	call Func_00_1b6a ; $464a
	call Func_17_497e ; $464d
	call Func_00_1b38 ; $4650
	ret ; $4653
Func_17_4654:
	call Func_17_49ce ; $4654
	rst Rst18 ; $4657
	adc a, h ; $4658
	dec b ; $4659
	ld de, $d181 ; $465a
	ld c, $12 ; $465d
	rst Rst18 ; $465f
	inc e ; $4660
	dec b ; $4661
	rst Rst18 ; $4662
	sub a, b ; $4663
	dec b ; $4664
	call Func_17_49f9 ; $4665
	call Func_00_2631 ; $4668
	ret ; $466b
Func_17_466c:
	call Func_17_4a32 ; $466c
	call Func_17_4a54 ; $466f
	call Func_17_4a48 ; $4672
	ret ; $4675
	ldh a, [$ff96] ; $4676
	push af ; $4678
	ld a, $03 ; $4679
	ldh [$ff96], a ; $467b
	ldh [rWBK], a ; $467d
	ld hl, $4ed2 ; $467f
	ld de, $d830 ; $4682
	ld bc, $0008 ; $4685
	call CopyMemoryBC ; $4688
	ldh a, [$ff8c] ; $468b
	and a, $3c ; $468d
	srl a ; $468f
	srl a ; $4691
	add a, a ; $4693
	jr nc, Label_17_469b ; $4694
	ld a, $0c ; $4696
	dec a ; $4698
	jr Label_17_46a1 ; $4699
Label_17_469b:
	rra ; $469b
	cp a, $0c ; $469c
	jr c, Label_17_46a1 ; $469e
	xor a, a ; $46a0
Label_17_46a1:
	add a, a ; $46a1
	ld hl, $46ca ; $46a2
	add a, l ; $46a5
	ld l, a ; $46a6
	jr nc, Label_17_46aa ; $46a7
	inc h ; $46a9
Label_17_46aa:
	ld a, [hl+] ; $46aa
	ld d, [hl] ; $46ab
	ld e, a ; $46ac
	ld hl, $d834 ; $46ad
	ld [hl], e ; $46b0
	inc hl ; $46b1
	ld [hl], d ; $46b2
	ld hl, $d830 ; $46b3
	ld de, $0201 ; $46b6
	call Func_00_05b0 ; $46b9
	pop af ; $46bc
	ldh [$ff96], a ; $46bd
	ldh [rWBK], a ; $46bf
	ret ; $46c1
	INCBIN "data/bank_017/d_46c2.bin" ; $46c2, 32 bytes
	ldh a, [$ff96] ; $46e2
	push af ; $46e4
	ld a, $03 ; $46e5
	ldh [$ff96], a ; $46e7
	ldh [rWBK], a ; $46e9
	ld a, [$d810] ; $46eb
	ld d, a ; $46ee
	ld a, [$d811] ; $46ef
	ld e, a ; $46f2
	ld hl, $4703 ; $46f3
	ld b, $08 ; $46f6
	ld c, $00 ; $46f8
	call Func_00_1e9d ; $46fa
	pop af ; $46fd
	ldh [$ff96], a ; $46fe
	ldh [rWBK], a ; $4700
	ret ; $4702
	INCBIN "data/bank_017/d_4703.bin" ; $4703, 9 bytes
	ldh a, [$ff96] ; $470c
	push af ; $470e
	ld a, $03 ; $470f
	ldh [$ff96], a ; $4711
	ldh [rWBK], a ; $4713
	ld a, [$d812] ; $4715
	ld d, a ; $4718
	ld a, [$d813] ; $4719
	ld e, a ; $471c
	ld hl, $472d ; $471d
	ld b, $08 ; $4720
	ld c, $04 ; $4722
	call Func_00_1e9d ; $4724
	pop af ; $4727
	ldh [$ff96], a ; $4728
	ldh [rWBK], a ; $472a
	ret ; $472c
	INCBIN "data/bank_017/d_472d.bin" ; $472d, 9 bytes
	ldh a, [$ff96] ; $4736
	push af ; $4738
	ld a, $03 ; $4739
	ldh [$ff96], a ; $473b
	ldh [rWBK], a ; $473d
	ld a, [$d81e] ; $473f
	ld d, a ; $4742
	ld a, [$d81f] ; $4743
	ld e, a ; $4746
	ld c, $6e ; $4747
	ld b, $09 ; $4749
	call Func_00_1f51 ; $474b
	pop af ; $474e
	ldh [$ff96], a ; $474f
	ldh [rWBK], a ; $4751
	ret ; $4753
	ldh a, [$ff96] ; $4754
	push af ; $4756
	ld a, $03 ; $4757
	ldh [$ff96], a ; $4759
	ldh [rWBK], a ; $475b
	ld b, $09 ; $475d
	ld a, [$d82d] ; $475f
	cp a, $01 ; $4762
	jr z, Label_17_4768 ; $4764
	ld b, $29 ; $4766
Label_17_4768:
	ld a, [$d81c] ; $4768
	ld d, a ; $476b
	ldh a, [$ff8c] ; $476c
	and a, $10 ; $476e
	jr z, Label_17_4773 ; $4770
	inc d ; $4772
Label_17_4773:
	ld a, [$d81d] ; $4773
	ld e, a ; $4776
	ld c, $60 ; $4777
	ld hl, $4785 ; $4779
	call Func_00_1e9d ; $477c
	pop af ; $477f
	ldh [$ff96], a ; $4780
	ldh [rWBK], a ; $4782
	ret ; $4784
	INCBIN "data/bank_017/d_4785.bin" ; $4785, 151 bytes
	ldh a, [$ff96] ; $481c
	push af ; $481e
	ld a, $03 ; $481f
	ldh [$ff96], a ; $4821
	ldh [rWBK], a ; $4823
	ld c, $70 ; $4825
	ld b, $09 ; $4827
	ld a, [$d825] ; $4829
	cp a, $01 ; $482c
	jr z, Label_17_4832 ; $482e
	ld b, $49 ; $4830
Label_17_4832:
	ld a, [$d823] ; $4832
	ld d, a ; $4835
	ld a, [$d824] ; $4836
	ld e, a ; $4839
	call Func_00_1f51 ; $483a
	pop af ; $483d
	ldh [$ff96], a ; $483e
	ldh [rWBK], a ; $4840
	ret ; $4842
	INCBIN "data/bank_017/d_4843.bin" ; $4843, 51 bytes
	ldh a, [$ff96] ; $4876
	push af ; $4878
	ld a, $03 ; $4879
	ldh [$ff96], a ; $487b
	ldh [rWBK], a ; $487d
	ld hl, $489e ; $487f
	ld a, [$d827] ; $4882
	add a, l ; $4885
	ld l, a ; $4886
	jr nc, Label_17_488a ; $4887
	inc h ; $4889
Label_17_488a:
	ld b, [hl] ; $488a
	ld c, $68 ; $488b
	ld a, [$d818] ; $488d
	ld d, a ; $4890
	ld a, [$d819] ; $4891
	ld e, a ; $4894
	call Func_00_1f51 ; $4895
	pop af ; $4898
	ldh [$ff96], a ; $4899
	ldh [rWBK], a ; $489b
	ret ; $489d
	INCBIN "data/bank_017/d_489e.bin" ; $489e, 4 bytes
Func_17_48a2:
	ldh a, [$ff96] ; $48a2
	push af ; $48a4
	ld a, $03 ; $48a5
	ldh [$ff96], a ; $48a7
	ldh [rWBK], a ; $48a9
	ldh a, [$ff8c] ; $48ab
	and a, $10 ; $48ad
	jr z, Label_17_48bb ; $48af
	ld c, $72 ; $48b1
	ld b, $09 ; $48b3
	ld de, $508c ; $48b5
	call Func_00_1f51 ; $48b8
Label_17_48bb:
	pop af ; $48bb
	ldh [$ff96], a ; $48bc
	ldh [rWBK], a ; $48be
	ret ; $48c0
	ldh a, [$ff96] ; $48c1
	push af ; $48c3
	ld a, $03 ; $48c4
	ldh [$ff96], a ; $48c6
	ldh [rWBK], a ; $48c8
	ld a, [$d828] ; $48ca
	ld d, a ; $48cd
	ldh a, [$ff8c] ; $48ce
	and a, $10 ; $48d0
	jr z, Label_17_48d5 ; $48d2
	inc d ; $48d4
Label_17_48d5:
	ld a, [$d829] ; $48d5
	ld e, a ; $48d8
	ldh a, [$ff8c] ; $48d9
	and a, $10 ; $48db
	jr z, Label_17_48e0 ; $48dd
	inc e ; $48df
Label_17_48e0:
	ld c, $6c ; $48e0
	ld b, $0a ; $48e2
	call Func_00_1f51 ; $48e4
	ld a, [$d82a] ; $48e7
	add a, $03 ; $48ea
	ld b, a ; $48ec
	ld a, [$d828] ; $48ed
	add a, b ; $48f0
	ld d, a ; $48f1
	ldh a, [$ff8c] ; $48f2
	and a, $10 ; $48f4
	jr z, Label_17_48f9 ; $48f6
	dec d ; $48f8
Label_17_48f9:
	ld a, [$d829] ; $48f9
	ld e, a ; $48fc
	ldh a, [$ff8c] ; $48fd
	and a, $10 ; $48ff
	jr z, Label_17_4904 ; $4901
	inc e ; $4903
Label_17_4904:
	ld c, $6c ; $4904
	ld b, $2a ; $4906
	call Func_00_1f51 ; $4908
	ld a, [$d82a] ; $490b
	add a, $03 ; $490e
	ld b, a ; $4910
	ld a, [$d828] ; $4911
	add a, b ; $4914
	ld d, a ; $4915
	ldh a, [$ff8c] ; $4916
	and a, $10 ; $4918
	jr z, Label_17_491d ; $491a
	dec d ; $491c
Label_17_491d:
	ld a, [$d82b] ; $491d
	sub a, $05 ; $4920
	ld b, a ; $4922
	ld a, [$d829] ; $4923
	add a, b ; $4926
	ld e, a ; $4927
	ldh a, [$ff8c] ; $4928
	and a, $10 ; $492a
	jr z, Label_17_492f ; $492c
	dec e ; $492e
Label_17_492f:
	ld c, $6c ; $492f
	ld b, $6a ; $4931
	call Func_00_1f51 ; $4933
	ld a, [$d828] ; $4936
	ld d, a ; $4939
	ldh a, [$ff8c] ; $493a
	and a, $10 ; $493c
	jr z, Label_17_4941 ; $493e
	inc d ; $4940
Label_17_4941:
	ld a, [$d82b] ; $4941
	sub a, $05 ; $4944
	ld b, a ; $4946
	ld a, [$d829] ; $4947
	add a, b ; $494a
	ld e, a ; $494b
	ldh a, [$ff8c] ; $494c
	and a, $10 ; $494e
	jr z, Label_17_4953 ; $4950
	dec e ; $4952
Label_17_4953:
	ld c, $6c ; $4953
	ld b, $4a ; $4955
	call Func_00_1f51 ; $4957
	pop af ; $495a
	ldh [$ff96], a ; $495b
	ldh [rWBK], a ; $495d
	ret ; $495f
Func_17_4960:
	ld c, $24 ; $4960
	rst Rst18 ; $4962
	nop ; $4963
	add hl, sp ; $4964
	call Func_17_499f ; $4965
	ld a, $03 ; $4968
	ldh [$ff96], a ; $496a
	ldh [rWBK], a ; $496c
	call Func_17_4a99 ; $496e
	call Func_17_4b0d ; $4971
	rst Rst18 ; $4974
	ld [bc], a ; $4975
	add hl, sp ; $4976
	ld a, $03 ; $4977
	ldh [$ff96], a ; $4979
	ldh [rWBK], a ; $497b
	ret ; $497d
Func_17_497e:
	call Func_00_2631 ; $497e
	ldh a, [$ff94] ; $4981
	and a, $03 ; $4983
	jr nz, Label_17_498c ; $4985
	call Func_17_48a2 ; $4987
	jr Func_17_497e ; $498a
Label_17_498c:
	ret ; $498c
Func_17_498d:
	call Func_00_2631 ; $498d
	ldh a, [$ff94] ; $4990
	and a, $03 ; $4992
	jr nz, Label_17_499e ; $4994
	dec c ; $4996
	jr z, Label_17_499c ; $4997
	call Func_17_48a2 ; $4999
Label_17_499c:
	ld a, $00 ; $499c
Label_17_499e:
	ret ; $499e
Func_17_499f:
	rst Rst18 ; $499f
	halt ; $49a0
	dec b ; $49a1
	ld b, $11 ; $49a2
	ld c, $10 ; $49a4
	ld de, $9000 ; $49a6
	rst Rst18 ; $49a9
	INCBIN "data/bank_017/d_49aa.bin" ; $49aa, 2 bytes
	ld a, $05 ; $49ac
	ldh [$ff96], a ; $49ae
	ldh [rWBK], a ; $49b0
	ld a, $03 ; $49b2
	ld [$c3b3], a ; $49b4
	ld a, $00 ; $49b7
	ld [$c3b6], a ; $49b9
	ld d, $00 ; $49bc
	ld e, $0b ; $49be
	ld b, $14 ; $49c0
	ld c, $07 ; $49c2
	rst Rst18 ; $49c4
	ld a, b ; $49c5
	dec b ; $49c6
	rst Rst18 ; $49c7
	ld a, h ; $49c8
	dec b ; $49c9
	rst Rst18 ; $49ca
	ld a, [hl] ; $49cb
	dec b ; $49cc
	ret ; $49cd
Func_17_49ce:
	push af ; $49ce
	push bc ; $49cf
	push de ; $49d0
	push hl ; $49d1
	ld de, $d160 ; $49d2
	ld b, $14 ; $49d5
	ld c, $01 ; $49d7
	ld h, $03 ; $49d9
	rst Rst18 ; $49db
	inc c ; $49dc
	add hl, sp ; $49dd
	ld a, $02 ; $49de
	ld [$d160], a ; $49e0
	ld a, $04 ; $49e3
	ld [$d173], a ; $49e5
	ld de, $d181 ; $49e8
	ld b, $12 ; $49eb
	ld c, $05 ; $49ed
	ld h, $20 ; $49ef
	rst Rst18 ; $49f1
	inc c ; $49f2
	add hl, sp ; $49f3
	pop hl ; $49f4
	pop de ; $49f5
	pop bc ; $49f6
	pop af ; $49f7
	ret ; $49f8
Func_17_49f9:
	ld hl, $d160 ; $49f9
	ld de, $9960 ; $49fc
	ld c, $0c ; $49ff
	call Func_00_0480 ; $4a01
	ret ; $4a04
	INCBIN "data/bank_017/d_4a05.bin" ; $4a05, 45 bytes
Func_17_4a32:
	push af ; $4a32
	push bc ; $4a33
	push de ; $4a34
	push hl ; $4a35
	ld hl, $d246 ; $4a36
	ld de, $d067 ; $4a39
	ld c, $06 ; $4a3c
	ld b, $06 ; $4a3e
	rst Rst18 ; $4a40
	ld a, [bc] ; $4a41
	add hl, sp ; $4a42
	pop hl ; $4a43
	pop de ; $4a44
	pop bc ; $4a45
	pop af ; $4a46
	ret ; $4a47
Func_17_4a48:
	ld hl, $d060 ; $4a48
	ld de, $9860 ; $4a4b
	ld c, $0c ; $4a4e
	call Func_00_0480 ; $4a50
	ret ; $4a53
Func_17_4a54:
	ld a, b ; $4a54
	or a, a ; $4a55
	ret z ; $4a56
	dec a ; $4a57
	add a, a ; $4a58
	ld c, a ; $4a59
	add a, a ; $4a5a
	add a, c ; $4a5b
	ld hl, $4a75 ; $4a5c
	add a, l ; $4a5f
	ld l, a ; $4a60
	jr nc, Label_17_4a64 ; $4a61
	inc h ; $4a63
Label_17_4a64:
	ld a, [hl+] ; $4a64
	ld b, [hl] ; $4a65
	ld c, a ; $4a66
	inc hl ; $4a67
	ld a, [hl+] ; $4a68
	ld d, [hl] ; $4a69
	ld e, a ; $4a6a
	inc hl ; $4a6b
	push bc ; $4a6c
	ld b, [hl] ; $4a6d
	inc hl ; $4a6e
	ld c, [hl] ; $4a6f
	pop hl ; $4a70
	rst Rst18 ; $4a71
	ld a, [bc] ; $4a72
	add hl, sp ; $4a73
	ret ; $4a74
	INCBIN "data/bank_017/d_4a75.bin" ; $4a75, 36 bytes
Func_17_4a99:
	ld hl, $4abb ; $4a99
Label_17_4a9c:
	ld a, [hl+] ; $4a9c
	ld b, [hl] ; $4a9d
	dec hl ; $4a9e
	or a, b ; $4a9f
	jr z, Label_17_4aba ; $4aa0
	push hl ; $4aa2
	push hl ; $4aa3
	inc hl ; $4aa4
	inc hl ; $4aa5
	ld a, [hl+] ; $4aa6
	ld d, [hl] ; $4aa7
	ld e, a ; $4aa8
	pop hl ; $4aa9
	ld a, [hl+] ; $4aaa
	ld h, [hl] ; $4aab
	ld l, a ; $4aac
	call DecompressData ; $4aad
	pop hl ; $4ab0
	ld a, $04 ; $4ab1
	add a, l ; $4ab3
	ld l, a ; $4ab4
	jr nc, Label_17_4ab8 ; $4ab5
	inc h ; $4ab7
Label_17_4ab8:
	jr Label_17_4a9c ; $4ab8
Label_17_4aba:
	ret ; $4aba
	INCBIN "data/bank_017/d_4abb.bin" ; $4abb, 82 bytes
Func_17_4b0d:
	ld hl, $5567 ; $4b0d
	ld de, $0803 ; $4b10
	call Func_00_05b0 ; $4b13
	ret ; $4b16
	INCBIN "data/bank_017/d_4b17.bin" ; $4b17, 5243 bytes
	ld a, $52 ; $5f92
	ld [$d810], a ; $5f94
	ld a, $44 ; $5f97
	ld [$d811], a ; $5f99
	ld a, $01 ; $5f9c
	ld hl, $46e2 ; $5f9e
	call Func_00_1b6a ; $5fa1
	ld a, $34 ; $5fa4
	ld [$d812], a ; $5fa6
	ld a, $06 ; $5fa9
	ld [$d813], a ; $5fab
	ld a, $01 ; $5fae
	ld hl, $470c ; $5fb0
	call Func_00_1b6a ; $5fb3
	ld a, $4e ; $5fb6
	ld [$d81e], a ; $5fb8
	ld a, $38 ; $5fbb
	ld [$d81f], a ; $5fbd
	ld a, $01 ; $5fc0
	ld hl, $4736 ; $5fc2
	call Func_00_1b6a ; $5fc5
	ld a, $00 ; $5fc8
	ld [$d82d], a ; $5fca
	ld a, $3a ; $5fcd
	ld [$d81c], a ; $5fcf
	ld a, $3c ; $5fd2
	ld [$d81d], a ; $5fd4
	ld a, $01 ; $5fd7
	ld hl, $4754 ; $5fd9
	call Func_00_1b6a ; $5fdc
	ld a, $03 ; $5fdf
	ld [$d827], a ; $5fe1
	ld a, $52 ; $5fe4
	ld [$d818], a ; $5fe6
	ld a, $40 ; $5fe9
	ld [$d819], a ; $5feb
	ld a, $01 ; $5fee
	ld hl, $4876 ; $5ff0
	call Func_00_1b6a ; $5ff3
	ld b, $06 ; $5ff6
	call Func_17_466c ; $5ff8
	ld a, $01 ; $5ffb
	ld hl, $4676 ; $5ffd
	call Func_00_1b6a ; $6000
	ld hl, $1abf ; $6003
	call Func_17_4654 ; $6006
	call Func_17_497e ; $6009
	call Func_00_1b38 ; $600c
	ld a, $01 ; $600f
	ld hl, $4406 ; $6011
	call Func_00_1b6a ; $6014
	call Func_17_466c ; $6017
	ld a, $03 ; $601a
	ld [$d82e], a ; $601c
	call Func_17_60ec ; $601f
	ld a, $01 ; $6022
	ld hl, $46e2 ; $6024
	call Func_00_1b6a ; $6027
	ld a, $01 ; $602a
	ld hl, $470c ; $602c
	call Func_00_1b6a ; $602f
	ld a, $01 ; $6032
	ld hl, $4736 ; $6034
	call Func_00_1b6a ; $6037
	ld a, $01 ; $603a
	ld hl, $4754 ; $603c
	call Func_00_1b6a ; $603f
	ld a, $01 ; $6042
	ld hl, $4876 ; $6044
	call Func_00_1b6a ; $6047
	ld a, $01 ; $604a
	ld hl, $481c ; $604c
	call Func_00_1b6a ; $604f
	ld a, $0d ; $6052
	ld [$d82a], a ; $6054
	ld a, $0f ; $6057
	ld [$d82b], a ; $6059
	ld a, $01 ; $605c
	ld hl, $48c1 ; $605e
	call Func_00_1b6a ; $6061
	ld hl, $1ac0 ; $6064
	call Func_17_4654 ; $6067
	call Func_17_497e ; $606a
	call Func_00_1b38 ; $606d
	ld a, $01 ; $6070
	ld hl, $4406 ; $6072
	call Func_00_1b6a ; $6075
	ld a, $03 ; $6078
	ld [$d82e], a ; $607a
	call Func_17_60ec ; $607d
	ld a, $01 ; $6080
	ld hl, $46e2 ; $6082
	call Func_00_1b6a ; $6085
	ld a, $01 ; $6088
	ld hl, $470c ; $608a
	call Func_00_1b6a ; $608d
	ld a, $01 ; $6090
	ld hl, $4736 ; $6092
	call Func_00_1b6a ; $6095
	ld a, $01 ; $6098
	ld hl, $4754 ; $609a
	call Func_00_1b6a ; $609d
	ld a, $01 ; $60a0
	ld hl, $4876 ; $60a2
	call Func_00_1b6a ; $60a5
	ld a, $01 ; $60a8
	ld hl, $481c ; $60aa
	call Func_00_1b6a ; $60ad
	ld a, $0d ; $60b0
	ld [$d82a], a ; $60b2
	ld a, $0f ; $60b5
	ld [$d82b], a ; $60b7
	ld a, $01 ; $60ba
	ld hl, $48c1 ; $60bc
	call Func_00_1b6a ; $60bf
	ld hl, $1ac1 ; $60c2
	call Func_17_4654 ; $60c5
	xor a, a ; $60c8
	ld [$d82c], a ; $60c9
	ld [$d82e], a ; $60cc
Label_17_60cf:
	call Func_17_60df ; $60cf
	ld c, $01 ; $60d2
	call Func_17_498d ; $60d4
	and a, a ; $60d7
	jp z, Label_17_60cf ; $60d8
	call Func_00_1b38 ; $60db
	ret ; $60de
Func_17_60df:
	ld a, [$d82c] ; $60df
	inc a ; $60e2
	ld [$d82c], a ; $60e3
	cp a, $78 ; $60e6
	jp nc, Func_17_60ec ; $60e8
	ret ; $60eb
Func_17_60ec:
	xor a, a ; $60ec
	ld [$d82c], a ; $60ed
	ld a, [$d82e] ; $60f0
	inc a ; $60f3
	and a, $03 ; $60f4
	ld [$d82e], a ; $60f6
	sla a ; $60f9
	sla a ; $60fb
	ld c, a ; $60fd
	add a, $b4 ; $60fe
	ld l, a ; $6100
	adc a, $61 ; $6101
	sub a, l ; $6103
	ld h, a ; $6104
	ld a, [hl] ; $6105
	inc hl ; $6106
	inc hl ; $6107
	ld b, [hl] ; $6108
	ld a, a ; $6109
	ld [$d810], a ; $610a
	ld a, b ; $610d
	ld [$d811], a ; $610e
	ld a, c ; $6111
	add a, $c4 ; $6112
	ld l, a ; $6114
	adc a, $61 ; $6115
	sub a, l ; $6117
	ld h, a ; $6118
	ld a, [hl] ; $6119
	inc hl ; $611a
	inc hl ; $611b
	ld b, [hl] ; $611c
	ld a, a ; $611d
	ld [$d812], a ; $611e
	ld a, b ; $6121
	ld [$d813], a ; $6122
	ld a, c ; $6125
	add a, $20 ; $6126
	ld l, a ; $6128
	adc a, $62 ; $6129
	sub a, l ; $612b
	ld h, a ; $612c
	ld a, [hl] ; $612d
	inc hl ; $612e
	inc hl ; $612f
	ld b, [hl] ; $6130
	ld a, a ; $6131
	ld [$d828], a ; $6132
	ld a, b ; $6135
	ld [$d829], a ; $6136
	ld a, c ; $6139
	add a, $d4 ; $613a
	ld l, a ; $613c
	adc a, $61 ; $613d
	sub a, l ; $613f
	ld h, a ; $6140
	ld a, [hl] ; $6141
	inc hl ; $6142
	inc hl ; $6143
	ld b, [hl] ; $6144
	ld a, a ; $6145
	ld [$d81e], a ; $6146
	ld a, b ; $6149
	ld [$d81f], a ; $614a
	ld a, [$d82e] ; $614d
	add a, $e4 ; $6150
	ld l, a ; $6152
	adc a, $61 ; $6153
	sub a, l ; $6155
	ld h, a ; $6156
	ld a, [hl] ; $6157
	ld [$d82d], a ; $6158
	ld a, c ; $615b
	add a, $e8 ; $615c
	ld l, a ; $615e
	adc a, $61 ; $615f
	sub a, l ; $6161
	ld h, a ; $6162
	ld a, [hl] ; $6163
	inc hl ; $6164
	inc hl ; $6165
	ld b, [hl] ; $6166
	ld a, a ; $6167
	ld [$d81c], a ; $6168
	ld a, b ; $616b
	ld [$d81d], a ; $616c
	ld a, [$d82e] ; $616f
	add a, $f8 ; $6172
	ld l, a ; $6174
	adc a, $61 ; $6175
	sub a, l ; $6177
	ld h, a ; $6178
	ld a, [hl] ; $6179
	ld [$d827], a ; $617a
	ld a, c ; $617d
	add a, $fc ; $617e
	ld l, a ; $6180
	adc a, $61 ; $6181
	sub a, l ; $6183
	ld h, a ; $6184
	ld a, [hl] ; $6185
	inc hl ; $6186
	inc hl ; $6187
	ld b, [hl] ; $6188
	ld a, a ; $6189
	ld [$d818], a ; $618a
	ld a, b ; $618d
	ld [$d819], a ; $618e
	ld a, [$d82e] ; $6191
	add a, $0c ; $6194
	ld l, a ; $6196
	adc a, $62 ; $6197
	sub a, l ; $6199
	ld h, a ; $619a
	ld a, [hl] ; $619b
	ld [$d825], a ; $619c
	ld a, c ; $619f
	add a, $10 ; $61a0
	ld l, a ; $61a2
	adc a, $62 ; $61a3
	sub a, l ; $61a5
	ld h, a ; $61a6
	ld a, [hl] ; $61a7
	inc hl ; $61a8
	inc hl ; $61a9
	ld b, [hl] ; $61aa
	ld a, a ; $61ab
	ld [$d823], a ; $61ac
	ld a, b ; $61af
	ld [$d824], a ; $61b0
	ret ; $61b3
	INCBIN "data/bank_017/d_61b4.bin" ; $61b4, 1678 bytes
	ld a, $55 ; $6842
	ld [$d810], a ; $6844
	ld a, $44 ; $6847
	ld [$d811], a ; $6849
	ld a, $01 ; $684c
	ld hl, $46e2 ; $684e
	call Func_00_1b6a ; $6851
	ld a, $3a ; $6854
	ld [$d812], a ; $6856
	ld a, $03 ; $6859
	ld [$d813], a ; $685b
	ld a, $01 ; $685e
	ld hl, $470c ; $6860
	call Func_00_1b6a ; $6863
	ld a, $54 ; $6866
	ld [$d81e], a ; $6868
	ld a, $28 ; $686b
	ld [$d81f], a ; $686d
	ld a, $01 ; $6870
	ld hl, $4736 ; $6872
	call Func_00_1b6a ; $6875
	ld a, $01 ; $6878
	ld [$d827], a ; $687a
	ld a, $4c ; $687d
	ld [$d818], a ; $687f
	ld a, $16 ; $6882
	ld [$d819], a ; $6884
	ld a, $01 ; $6887
	ld hl, $4876 ; $6889
	call Func_00_1b6a ; $688c
	ld hl, $1c03 ; $688f
	call Func_17_4654 ; $6892
	call Func_17_497e ; $6895
	call Func_00_1b38 ; $6898
	ld a, $01 ; $689b
	ld hl, $4406 ; $689d
	call Func_00_1b6a ; $68a0
	ld a, $03 ; $68a3
	ld [$d82e], a ; $68a5
	call Func_17_6965 ; $68a8
	ld a, $01 ; $68ab
	ld hl, $46e2 ; $68ad
	call Func_00_1b6a ; $68b0
	ld a, $01 ; $68b3
	ld hl, $470c ; $68b5
	call Func_00_1b6a ; $68b8
	ld a, $01 ; $68bb
	ld hl, $4736 ; $68bd
	call Func_00_1b6a ; $68c0
	ld a, $01 ; $68c3
	ld hl, $4754 ; $68c5
	call Func_00_1b6a ; $68c8
	ld a, $01 ; $68cb
	ld hl, $4876 ; $68cd
	call Func_00_1b6a ; $68d0
	ld a, $0d ; $68d3
	ld [$d82a], a ; $68d5
	ld a, $09 ; $68d8
	ld [$d82b], a ; $68da
	ld a, $01 ; $68dd
	ld hl, $48c1 ; $68df
	call Func_00_1b6a ; $68e2
	ld hl, $1c04 ; $68e5
	call Func_17_4654 ; $68e8
	call Func_17_497e ; $68eb
	call Func_00_1b38 ; $68ee
	ld a, $01 ; $68f1
	ld hl, $4406 ; $68f3
	call Func_00_1b6a ; $68f6
	ld a, $03 ; $68f9
	ld [$d82e], a ; $68fb
	call Func_17_6965 ; $68fe
	ld a, $01 ; $6901
	ld hl, $46e2 ; $6903
	call Func_00_1b6a ; $6906
	ld a, $01 ; $6909
	ld hl, $470c ; $690b
	call Func_00_1b6a ; $690e
	ld a, $01 ; $6911
	ld hl, $4736 ; $6913
	call Func_00_1b6a ; $6916
	ld a, $01 ; $6919
	ld hl, $4754 ; $691b
	call Func_00_1b6a ; $691e
	ld a, $01 ; $6921
	ld hl, $4876 ; $6923
	call Func_00_1b6a ; $6926
	ld a, $0d ; $6929
	ld [$d82a], a ; $692b
	ld a, $09 ; $692e
	ld [$d82b], a ; $6930
	ld a, $01 ; $6933
	ld hl, $48c1 ; $6935
	call Func_00_1b6a ; $6938
	ld hl, $1c05 ; $693b
	call Func_17_4654 ; $693e
	xor a, a ; $6941
	ld [$d82c], a ; $6942
	ld [$d82e], a ; $6945
Label_17_6948:
	call Func_17_6958 ; $6948
	ld c, $01 ; $694b
	call Func_17_498d ; $694d
	and a, a ; $6950
	jp z, Label_17_6948 ; $6951
	call Func_00_1b38 ; $6954
	ret ; $6957
Func_17_6958:
	ld a, [$d82c] ; $6958
	inc a ; $695b
	ld [$d82c], a ; $695c
	cp a, $78 ; $695f
	jp nc, Func_17_6965 ; $6961
	ret ; $6964
Func_17_6965:
	xor a, a ; $6965
	ld [$d82c], a ; $6966
	ld a, [$d82e] ; $6969
	inc a ; $696c
	and a, $03 ; $696d
	ld [$d82e], a ; $696f
	sla a ; $6972
	sla a ; $6974
	ld c, a ; $6976
	add a, $0b ; $6977
	ld l, a ; $6979
	adc a, $6a ; $697a
	sub a, l ; $697c
	ld h, a ; $697d
	ld a, [hl] ; $697e
	inc hl ; $697f
	inc hl ; $6980
	ld b, [hl] ; $6981
	ld a, a ; $6982
	ld [$d810], a ; $6983
	ld a, b ; $6986
	ld [$d811], a ; $6987
	ld a, c ; $698a
	add a, $1b ; $698b
	ld l, a ; $698d
	adc a, $6a ; $698e
	sub a, l ; $6990
	ld h, a ; $6991
	ld a, [hl] ; $6992
	inc hl ; $6993
	inc hl ; $6994
	ld b, [hl] ; $6995
	ld a, a ; $6996
	ld [$d812], a ; $6997
	ld a, b ; $699a
	ld [$d813], a ; $699b
	ld a, c ; $699e
	add a, $63 ; $699f
	ld l, a ; $69a1
	adc a, $6a ; $69a2
	sub a, l ; $69a4
	ld h, a ; $69a5
	ld a, [hl] ; $69a6
	inc hl ; $69a7
	inc hl ; $69a8
	ld b, [hl] ; $69a9
	ld a, a ; $69aa
	ld [$d828], a ; $69ab
	ld a, b ; $69ae
	ld [$d829], a ; $69af
	ld a, c ; $69b2
	add a, $2b ; $69b3
	ld l, a ; $69b5
	adc a, $6a ; $69b6
	sub a, l ; $69b8
	ld h, a ; $69b9
	ld a, [hl] ; $69ba
	inc hl ; $69bb
	inc hl ; $69bc
	ld b, [hl] ; $69bd
	ld a, a ; $69be
	ld [$d81e], a ; $69bf
	ld a, b ; $69c2
	ld [$d81f], a ; $69c3
	ld a, [$d82e] ; $69c6
	add a, $3b ; $69c9
	ld l, a ; $69cb
	adc a, $6a ; $69cc
	sub a, l ; $69ce
	ld h, a ; $69cf
	ld a, [hl] ; $69d0
	ld [$d82d], a ; $69d1
	ld a, c ; $69d4
	add a, $3f ; $69d5
	ld l, a ; $69d7
	adc a, $6a ; $69d8
	sub a, l ; $69da
	ld h, a ; $69db
	ld a, [hl] ; $69dc
	inc hl ; $69dd
	inc hl ; $69de
	ld b, [hl] ; $69df
	ld a, a ; $69e0
	ld [$d81c], a ; $69e1
	ld a, b ; $69e4
	ld [$d81d], a ; $69e5
	ld a, [$d82e] ; $69e8
	add a, $4f ; $69eb
	ld l, a ; $69ed
	adc a, $6a ; $69ee
	sub a, l ; $69f0
	ld h, a ; $69f1
	ld a, [hl] ; $69f2
	ld [$d827], a ; $69f3
	ld a, c ; $69f6
	add a, $53 ; $69f7
	ld l, a ; $69f9
	adc a, $6a ; $69fa
	sub a, l ; $69fc
	ld h, a ; $69fd
	ld a, [hl] ; $69fe
	inc hl ; $69ff
	inc hl ; $6a00
	ld b, [hl] ; $6a01
	ld a, a ; $6a02
	ld [$d818], a ; $6a03
	ld a, b ; $6a06
	ld [$d819], a ; $6a07
	ret ; $6a0a
	INCBIN "data/bank_017/d_6a0b.bin" ; $6a0b, 1296 bytes
	push af ; $6f1b
	ld a, $03 ; $6f1c
	ldh [$ff96], a ; $6f1e
	ldh [rWBK], a ; $6f20
	pop af ; $6f22
	ld [$dc01], a ; $6f23
	ld a, [wMinigameLevel] ; $6f26
	ld [$dc06], a ; $6f29
	xor a, a ; $6f2c
	ld [$dc02], a ; $6f2d
	ld [$dc03], a ; $6f30
	ld [$dc04], a ; $6f33
	ld [$dc05], a ; $6f36
	ld [$dc00], a ; $6f39
	ld c, $20 ; $6f3c
	call Func_00_1d20 ; $6f3e
	call Func_00_1da4 ; $6f41
	call DisableLCDSafely ; $6f44
	call Func_17_7157 ; $6f47
	ld a, $01 ; $6f4a
	ld [$cb0b], a ; $6f4c
	ld a, $03 ; $6f4f
	ld [$cb0c], a ; $6f51
	ld a, $01 ; $6f54
	ld hl, $4406 ; $6f56
	call Func_00_1b6a ; $6f59
	call EnableLCD ; $6f5c
	ld c, $20 ; $6f5f
	call Func_00_1d2e ; $6f61
	call Func_00_1da4 ; $6f64
	ld a, $03 ; $6f67
	ldh [$ff96], a ; $6f69
	ldh [rWBK], a ; $6f6b
	ld a, $01 ; $6f6d
	ld hl, $7420 ; $6f6f
	call Func_00_1b6a ; $6f72
	ld a, $01 ; $6f75
	ld [$dc03], a ; $6f77
	xor a, a ; $6f7a
	ld [$dc04], a ; $6f7b
	call Func_17_6f91 ; $6f7e
	ld c, $20 ; $6f81
	call Func_00_1d20 ; $6f83
	call Func_00_1da4 ; $6f86
	call Func_00_1b38 ; $6f89
	ld a, [$dc02] ; $6f8c
	ret ; $6f8f
	INCBIN "data/bank_017/d_6f90.bin" ; $6f90, 1 bytes
Func_17_6f91:
	ldh a, [$ff96] ; $6f91
	push af ; $6f93
	ld a, $03 ; $6f94
	ldh [$ff96], a ; $6f96
	ldh [rWBK], a ; $6f98
	ld a, [$cb20] ; $6f9a
	inc a ; $6f9d
	inc a ; $6f9e
	rst Rst18 ; $6f9f
	inc l ; $6fa0
	inc bc ; $6fa1
	ld a, $07 ; $6fa2
	ldh [$ff96], a ; $6fa4
	ldh [rWBK], a ; $6fa6
	ld hl, $de00 ; $6fa8
	ld a, [hl+] ; $6fab
	ld h, [hl] ; $6fac
	ld l, a ; $6fad
	ld a, $03 ; $6fae
	ldh [$ff96], a ; $6fb0
	ldh [rWBK], a ; $6fb2
	rst Rst18 ; $6fb4
	ld c, b ; $6fb5
	dec b ; $6fb6
	ld a, [$cb20] ; $6fb7
	ld hl, $6fdb ; $6fba
	add a, a ; $6fbd
	add a, l ; $6fbe
	ld l, a ; $6fbf
	jr nc, Label_17_6fc3 ; $6fc0
	inc h ; $6fc2
Label_17_6fc3:
	ld a, [hl+] ; $6fc3
	ld d, [hl] ; $6fc4
	ld e, a ; $6fc5
	ld hl, $cb6e ; $6fc6
	ld a, e ; $6fc9
	ld [hl+], a ; $6fca
	ld [hl], d ; $6fcb
	ld hl, $6fed ; $6fcc
	ld a, [$dc01] ; $6fcf
	call Func_17_709b ; $6fd2
	pop af ; $6fd5
	ldh [$ff96], a ; $6fd6
	ldh [rWBK], a ; $6fd8
	ret ; $6fda
	INCBIN "data/bank_017/d_6fdb.bin" ; $6fdb, 192 bytes
Func_17_709b:
	add a, a ; $709b
	ld b, a ; $709c
	add a, a ; $709d
	add a, b ; $709e
	add a, l ; $709f
	ld l, a ; $70a0
	jr nc, Label_17_70a4 ; $70a1
	inc h ; $70a3
Label_17_70a4:
	ld a, [hl+] ; $70a4
	cp a, $ff ; $70a5
	jp z, Label_17_7150 ; $70a7
	push hl ; $70aa
	bit 7, a ; $70ab
	jr z, Label_17_70d3 ; $70ad
	push af ; $70af
	ld d, a ; $70b0
	ld a, $07 ; $70b1
	ldh [$ff96], a ; $70b3
	ldh [rWBK], a ; $70b5
	ld hl, $de00 ; $70b7
	ld a, [hl+] ; $70ba
	ld h, [hl] ; $70bb
	ld l, a ; $70bc
	ld a, $03 ; $70bd
	ldh [$ff96], a ; $70bf
	ldh [rWBK], a ; $70c1
	ld a, h ; $70c3
	cp a, $27 ; $70c4
	jr nz, Label_17_70d2 ; $70c6
	ld a, l ; $70c8
	cp a, $0f ; $70c9
	jr nz, Label_17_70d2 ; $70cb
	pop bc ; $70cd
	ld a, d ; $70ce
	inc a ; $70cf
	jr Label_17_70d3 ; $70d0
Label_17_70d2:
	pop af ; $70d2
Label_17_70d3:
	and a, $7f ; $70d3
	pop hl ; $70d5
	push hl ; $70d6
	push af ; $70d7
	ld a, [hl] ; $70d8
	cp a, $ff ; $70d9
	jr z, Label_17_70e5 ; $70db
	ld a, $01 ; $70dd
	ld hl, $755e ; $70df
	call Func_00_1b6a ; $70e2
Label_17_70e5:
	call Func_17_7202 ; $70e5
	ld hl, $cb6e ; $70e8
	ld a, [hl+] ; $70eb
	ld h, [hl] ; $70ec
	ld l, a ; $70ed
	pop af ; $70ee
	add a, l ; $70ef
	ld l, a ; $70f0
	jr nc, Label_17_70f4 ; $70f1
	inc h ; $70f3
Label_17_70f4:
	ld de, $d082 ; $70f4
	ld c, $20 ; $70f7
	rst Rst18 ; $70f9
	adc a, h ; $70fa
	dec b ; $70fb
	ld c, $10 ; $70fc
	rst Rst18 ; $70fe
	inc e ; $70ff
	dec b ; $7100
	rst Rst18 ; $7101
	sub a, b ; $7102
	dec b ; $7103
	call Func_17_724d ; $7104
Label_17_7107:
	call Func_00_2631 ; $7107
	ldh a, [$ff94] ; $710a
	bit 0, a ; $710c
	jr nz, Label_17_711e ; $710e
	bit 7, a ; $7110
	jr nz, Label_17_711e ; $7112
	bit 1, a ; $7114
	jr nz, Label_17_713c ; $7116
	bit 3, a ; $7118
	jr nz, Label_17_7153 ; $711a
	jr Label_17_7107 ; $711c
Label_17_711e:
	rst Rst08 ; $711e
	ld e, a ; $711f
	ld hl, $755e ; $7120
	call Func_00_1bcb ; $7123
	ld hl, $7570 ; $7126
	call Func_00_1bcb ; $7129
	ld a, $01 ; $712c
	ld [$dc03], a ; $712e
	ld [$dc05], a ; $7131
	xor a, a ; $7134
	ld [$dc04], a ; $7135
	pop hl ; $7138
	jp Label_17_70a4 ; $7139
Label_17_713c:
	rst Rst08 ; $713c
	ld h, d ; $713d
	ld hl, $755e ; $713e
	call Func_00_1bcb ; $7141
	ld hl, $7570 ; $7144
	call Func_00_1bcb ; $7147
	ld a, $ff ; $714a
	ld [$dc02], a ; $714c
	pop hl ; $714f
Label_17_7150:
	rst Rst08 ; $7150
	ld h, b ; $7151
	ret ; $7152
Label_17_7153:
	pop hl ; $7153
	rst Rst08 ; $7154
	ld h, b ; $7155
	ret ; $7156
Func_17_7157:
	call Func_17_7293 ; $7157
	rst Rst18 ; $715a
	ld a, [bc] ; $715b
	INCBIN "data/bank_017/d_715c.bin" ; $715c, 1 bytes
	ld c, $44 ; $715d
	rst Rst18 ; $715f
	nop ; $7160
	add hl, sp ; $7161
	ldh a, [$ff96] ; $7162
	push af ; $7164
	rst Rst18 ; $7165
	nop ; $7166
	dec b ; $7167
	ld a, $05 ; $7168
	ldh [$ff96], a ; $716a
	ldh [rWBK], a ; $716c
	ld a, $03 ; $716e
	ld [$c3b3], a ; $7170
	ld a, $00 ; $7173
	ld [$c3b6], a ; $7175
	pop af ; $7178
	ldh [$ff96], a ; $7179
	ldh [rWBK], a ; $717b
	rst Rst18 ; $717d
	adc a, h ; $717e
	dec b ; $717f
	call Func_17_71bd ; $7180
	ld hl, $7b39 ; $7183
	ld de, $0902 ; $7186
	call Func_00_05b5 ; $7189
	ld de, $a000 ; $718c
	rst Rst18 ; $718f
	jr Label_17_71cb ; $7190
	ld b, $08 ; $7192
	ld c, $0f ; $7194
	rst Rst18 ; $7196
	ld c, $39 ; $7197
	ld b, $11 ; $7199
	ld c, $10 ; $719b
	ld de, $9000 ; $719d
	rst Rst18 ; $71a0
	INCBIN "data/bank_017/d_71a1.bin" ; $71a1, 2 bytes
	ld a, $03 ; $71a3
	ld [$c3b3], a ; $71a5
	ld hl, $c3b4 ; $71a8
	ld de, $d000 ; $71ab
	ld a, e ; $71ae
	ld [hl+], a ; $71af
	ld [hl], d ; $71b0
	ld a, $01 ; $71b1
	ld hl, $74db ; $71b3
	call Func_00_1b6a ; $71b6
	rst Rst18 ; $71b9
	ld [bc], a ; $71ba
	add hl, sp ; $71bb
	ret ; $71bc
Func_17_71bd:
	ldh a, [$ff96] ; $71bd
	push af ; $71bf
	ld a, $03 ; $71c0
	ldh [$ff96], a ; $71c2
	ldh [rWBK], a ; $71c4
	ld de, $d462 ; $71c6
	ld b, $10 ; $71c9
Label_17_71cb:
	ld c, $0e ; $71cb
	ld h, $00 ; $71cd
	rst Rst18 ; $71cf
	inc c ; $71d0
	add hl, sp ; $71d1
	call Func_17_71db ; $71d2
	pop af ; $71d5
	ldh [$ff96], a ; $71d6
	ldh [rWBK], a ; $71d8
	ret ; $71da
Func_17_71db:
	ldh a, [$ff96] ; $71db
	push af ; $71dd
	ld a, $03 ; $71de
	ldh [$ff96], a ; $71e0
	ldh [rWBK], a ; $71e2
	ld de, $d062 ; $71e4
	ld b, $10 ; $71e7
	ld c, $01 ; $71e9
	ld h, $03 ; $71eb
	rst Rst18 ; $71ed
	inc c ; $71ee
	add hl, sp ; $71ef
	ld de, $d082 ; $71f0
	ld b, $10 ; $71f3
	ld c, $0d ; $71f5
	ld h, $20 ; $71f7
	rst Rst18 ; $71f9
	inc c ; $71fa
	add hl, sp ; $71fb
	pop af ; $71fc
	ldh [$ff96], a ; $71fd
	ldh [rWBK], a ; $71ff
	ret ; $7201
Func_17_7202:
	ldh a, [$ff96] ; $7202
	push af ; $7204
	ld a, $03 ; $7205
	ldh [$ff96], a ; $7207
	ldh [rWBK], a ; $7209
	ld de, $d062 ; $720b
	ld b, $10 ; $720e
	ld c, $01 ; $7210
	ld h, $03 ; $7212
	rst Rst18 ; $7214
	inc c ; $7215
	add hl, sp ; $7216
	ld de, $d082 ; $7217
	ld b, $10 ; $721a
	ld c, $0d ; $721c
	ld h, $20 ; $721e
	rst Rst18 ; $7220
	inc c ; $7221
	add hl, sp ; $7222
	ld a, [$dc05] ; $7223
	or a, a ; $7226
	jr nz, Label_17_723b ; $7227
	ld a, [$dc06] ; $7229
	add a, $03 ; $722c
	ld h, a ; $722e
	ld de, $d482 ; $722f
	ld b, $10 ; $7232
	ld c, $01 ; $7234
	rst Rst18 ; $7236
	inc c ; $7237
	add hl, sp ; $7238
	jr Label_17_7247 ; $7239
Label_17_723b:
	ld de, $d482 ; $723b
	ld b, $10 ; $723e
	ld c, $01 ; $7240
	ld h, $00 ; $7242
	rst Rst18 ; $7244
	inc c ; $7245
	add hl, sp ; $7246
Label_17_7247:
	pop af ; $7247
	ldh [$ff96], a ; $7248
	ldh [rWBK], a ; $724a
	ret ; $724c
Func_17_724d:
	ld a, [$dc05] ; $724d
	or a, a ; $7250
	jr nz, Label_17_7260 ; $7251
	ld hl, $d080 ; $7253
	ld de, $9880 ; $7256
	ld c, $0a ; $7259
	call Func_00_0480 ; $725b
	jr Label_17_726b ; $725e
Label_17_7260:
	ld hl, $d060 ; $7260
	ld de, $9860 ; $7263
	ld c, $0a ; $7266
	call Func_00_0480 ; $7268
Label_17_726b:
	ld hl, $d480 ; $726b
	ld de, $b880 ; $726e
	ld c, $02 ; $7271
	call Func_00_0480 ; $7273
	call Func_00_2631 ; $7276
	ld hl, $d100 ; $7279
	ld de, $9900 ; $727c
	ld c, $0a ; $727f
	call Func_00_0480 ; $7281
	call Func_00_2631 ; $7284
	ld hl, $d1a0 ; $7287
	ld de, $99a0 ; $728a
	ld c, $08 ; $728d
	call Func_00_0480 ; $728f
	ret ; $7292
Func_17_7293:
	ld a, $01 ; $7293
	ldh [$ff96], a ; $7295
	ldh [rWBK], a ; $7297
	ld hl, $793c ; $7299
	ld de, $d000 ; $729c
	call DecompressData ; $729f
	ld hl, $d000 ; $72a2
	ld de, $8000 ; $72a5
	ld bc, $0012 ; $72a8
	call Func_00_0480 ; $72ab
	ld hl, $d000 ; $72ae
	ld de, $8240 ; $72b1
	ld bc, $0012 ; $72b4
	call Func_00_0480 ; $72b7
	ld hl, $d000 ; $72ba
	ld de, $8480 ; $72bd
	ld bc, $0012 ; $72c0
	call Func_00_0480 ; $72c3
	ld hl, $d000 ; $72c6
	ld de, $a100 ; $72c9
	ld bc, $0012 ; $72cc
	call Func_00_0480 ; $72cf
	ld hl, $d000 ; $72d2
	ld de, $a340 ; $72d5
	ld bc, $0012 ; $72d8
	call Func_00_0480 ; $72db
	ld hl, $d000 ; $72de
	ld de, $a580 ; $72e1
	ld bc, $0012 ; $72e4
	call Func_00_0480 ; $72e7
	ld hl, $7a08 ; $72ea
	ld de, $d000 ; $72ed
	call DecompressData ; $72f0
	ld hl, $d000 ; $72f3
	ld de, $84a0 ; $72f6
	ld bc, $0002 ; $72f9
	call Func_00_0480 ; $72fc
	ld hl, $d000 ; $72ff
	ld de, $a120 ; $7302
	ld bc, $0002 ; $7305
	call Func_00_0480 ; $7308
	ld hl, $d000 ; $730b
	ld de, $a360 ; $730e
	ld bc, $0002 ; $7311
	call Func_00_0480 ; $7314
	ld hl, $d000 ; $7317
	ld de, $a5a0 ; $731a
	ld bc, $0002 ; $731d
	call Func_00_0480 ; $7320
	ld hl, $7a2f ; $7323
	ld de, $d000 ; $7326
	call DecompressData ; $7329
	ld hl, $d020 ; $732c
	ld de, $82c0 ; $732f
	ld bc, $0001 ; $7332
	call Func_00_0480 ; $7335
	ld hl, $d020 ; $7338
	ld de, $a180 ; $733b
	ld bc, $0001 ; $733e
	call Func_00_0480 ; $7341
	ld hl, $d000 ; $7344
	ld de, $a3c0 ; $7347
	ld bc, $0001 ; $734a
	call Func_00_0480 ; $734d
	ld hl, $d040 ; $7350
	ld de, $a600 ; $7353
	ld bc, $0001 ; $7356
	call Func_00_0480 ; $7359
	ld hl, $7a56 ; $735c
	ld de, $d000 ; $735f
	call DecompressData ; $7362
	ld hl, $d000 ; $7365
	ld de, $8120 ; $7368
	ld bc, $0012 ; $736b
	call Func_00_0480 ; $736e
	ld hl, $d000 ; $7371
	ld de, $8360 ; $7374
	ld bc, $0012 ; $7377
	call Func_00_0480 ; $737a
	ld hl, $d000 ; $737d
	ld de, $85a0 ; $7380
	ld bc, $0012 ; $7383
	call Func_00_0480 ; $7386
	ld hl, $d000 ; $7389
	ld de, $a220 ; $738c
	ld bc, $0012 ; $738f
	call Func_00_0480 ; $7392
	ld hl, $d000 ; $7395
	ld de, $a460 ; $7398
	ld bc, $0012 ; $739b
	call Func_00_0480 ; $739e
	ld hl, $d000 ; $73a1
	ld de, $a6a0 ; $73a4
	ld bc, $0012 ; $73a7
	call Func_00_0480 ; $73aa
	ld hl, $7af8 ; $73ad
	ld de, $d000 ; $73b0
	call DecompressData ; $73b3
	ld hl, $d000 ; $73b6
	ld de, $85c0 ; $73b9
	ld bc, $0002 ; $73bc
	call Func_00_0480 ; $73bf
	ld hl, $d000 ; $73c2
	ld de, $a240 ; $73c5
	ld bc, $0002 ; $73c8
	call Func_00_0480 ; $73cb
	ld hl, $d000 ; $73ce
	ld de, $a480 ; $73d1
	ld bc, $0002 ; $73d4
	call Func_00_0480 ; $73d7
	ld hl, $d000 ; $73da
	ld de, $a6c0 ; $73dd
	ld bc, $0002 ; $73e0
	call Func_00_0480 ; $73e3
	ld hl, $7b18 ; $73e6
	ld de, $d000 ; $73e9
	call DecompressData ; $73ec
	ld hl, $d020 ; $73ef
	ld de, $83e0 ; $73f2
	ld bc, $0001 ; $73f5
	call Func_00_0480 ; $73f8
	ld hl, $d020 ; $73fb
	ld de, $a2a0 ; $73fe
	ld bc, $0001 ; $7401
	call Func_00_0480 ; $7404
	ld hl, $d000 ; $7407
	ld de, $a4e0 ; $740a
	ld bc, $0001 ; $740d
	call Func_00_0480 ; $7410
	ld hl, $d040 ; $7413
	ld de, $a720 ; $7416
	ld bc, $0001 ; $7419
	call Func_00_0480 ; $741c
	ret ; $741f
	ldh a, [$ff96] ; $7420
	push af ; $7422
	ld a, $03 ; $7423
	ldh [$ff96], a ; $7425
	ldh [rWBK], a ; $7427
	ld a, [$dc04] ; $7429
	inc a ; $742c
	ld [$dc04], a ; $742d
	ld a, [$dc03] ; $7430
	or a, a ; $7433
	jr z, Label_17_744e ; $7434
	ldh a, [$ff8c] ; $7436
	srl a ; $7438
	srl a ; $743a
	srl a ; $743c
	and a, $3f ; $743e
	ld hl, $749f ; $7440
	add a, l ; $7443
	ld l, a ; $7444
	jr nc, Label_17_7448 ; $7445
	inc h ; $7447
Label_17_7448:
	ld a, [hl] ; $7448
	ld [$dc00], a ; $7449
	jr Label_17_7468 ; $744c
Label_17_744e:
	ldh a, [$ff8c] ; $744e
	srl a ; $7450
	srl a ; $7452
	srl a ; $7454
	srl a ; $7456
	and a, $1f ; $7458
	ld hl, $747f ; $745a
	add a, l ; $745d
	ld l, a ; $745e
	jr nc, Label_17_7462 ; $745f
	inc h ; $7461
Label_17_7462:
	ld a, [hl] ; $7462
	ld [$dc00], a ; $7463
	jr Label_17_7468 ; $7466
Label_17_7468:
	ld a, [$dc03] ; $7468
	or a, a ; $746b
	jr z, Label_17_7479 ; $746c
	ld a, [$dc04] ; $746e
	cp a, $ff ; $7471
	jr nz, Label_17_7479 ; $7473
	xor a, a ; $7475
	ld [$dc03], a ; $7476
Label_17_7479:
	pop af ; $7479
	ldh [$ff96], a ; $747a
	ldh [rWBK], a ; $747c
	ret ; $747e
	INCBIN "data/bank_017/d_747f.bin" ; $747f, 92 bytes
	ldh a, [$ff96] ; $74db
	push af ; $74dd
	ld a, $03 ; $74de
	ldh [$ff96], a ; $74e0
	ldh [rWBK], a ; $74e2
	ld a, [$dc00] ; $74e4
	ld hl, $754c ; $74e7
	add a, l ; $74ea
	ld l, a ; $74eb
	jr nc, Label_17_74ef ; $74ec
	inc h ; $74ee
Label_17_74ef:
	ld a, [hl] ; $74ef
	ld c, a ; $74f0
	push bc ; $74f1
	ld a, [$dc00] ; $74f2
	ld hl, $7552 ; $74f5
	add a, l ; $74f8
	ld l, a ; $74f9
	jr nc, Label_17_74fd ; $74fa
	inc h ; $74fc
Label_17_74fd:
	ld b, [hl] ; $74fd
	ld de, $7e68 ; $74fe
	ld hl, $7527 ; $7501
	call Func_00_1e9d ; $7504
	pop bc ; $7507
	ld a, $12 ; $7508
	add a, c ; $750a
	ld c, a ; $750b
	ld a, [$dc00] ; $750c
	ld hl, $7558 ; $750f
	add a, l ; $7512
	ld l, a ; $7513
	jr nc, Label_17_7517 ; $7514
	inc h ; $7516
Label_17_7517:
	ld b, [hl] ; $7517
	ld de, $7e68 ; $7518
	ld hl, $7527 ; $751b
	call Func_00_1e9d ; $751e
	pop af ; $7521
	ldh [$ff96], a ; $7522
	ldh [rWBK], a ; $7524
	ret ; $7526
	INCBIN "data/bank_017/d_7527.bin" ; $7527, 55 bytes
	ld de, $7888 ; $755e
	ld c, $00 ; $7561
	call Func_17_40a3 ; $7563
	ld b, $08 ; $7566
	ld c, $00 ; $7568
	ld h, $03 ; $756a
	rst Rst18 ; $756c
	ld a, [de] ; $756d
	add hl, sp ; $756e
	ret ; $756f
	INCBIN "data/bank_017/d_7570.bin" ; $7570, 2704 bytes
