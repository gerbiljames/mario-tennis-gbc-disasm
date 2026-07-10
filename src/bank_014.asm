INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $14", ROMX[$4000], BANK[$14]

	INCBIN "data/bank_014/d_4000.bin" ; $4000, 99 bytes
	ld a, [$c295] ; $4063
	cp a, $ff ; $4066
	jp z, Label_14_4085 ; $4068
	clear_flag $0f, 5 ; $406b
	test_flag $05, 7 ; $406e
	jr z, Label_14_4085 ; $4071
	ld a, $02 ; $4073
	ld bc, $2b00 ; $4075
	ld de, $3b00 ; $4078
	farcall FarPtr_0a_22 ; $407b
	ld a, $02 ; $407e
	ld b, $c0 ; $4080
	farcall FarPtr_0a_2e ; $4082
Label_14_4085:
	ret ; $4085
	INCBIN "data/bank_014/d_4086.bin" ; $4086, 141 bytes
Label_14_4113:
	ld hl, $20db ; $4113
	farcall FarPtr_0a_0e ; $4116
	ld hl, $000f ; $4119
	farcall FarPtr_05_48 ; $411c
	ld hl, $c47c ; $411f
	ld a, [hl+] ; $4122
	ld h, [hl] ; $4123
	ld l, a ; $4124
	farcall FarPtr_05_48 ; $4125
	jp Label_14_474e ; $4128
Label_14_412b:
	call Func_14_4997 ; $412b
	ld hl, $20af ; $412e
	farcall FarPtr_0a_0e ; $4131
	ld a, $05 ; $4134
	farcall FarPtr_0a_08 ; $4136
	ld a, $02 ; $4139
	farcall FarPtr_0a_16 ; $413b
	ld c, l ; $413e
	ld b, h ; $413f
	ld de, $d000 ; $4140
	farcall FarPtr_04_20 ; $4143
	ret ; $4146
Label_14_4147:
	ld hl, $20db ; $4147
	farcall FarPtr_0a_0e ; $414a
	ld hl, $001e ; $414d
	farcall FarPtr_05_48 ; $4150
	ld hl, $c47c ; $4153
	ld a, [hl+] ; $4156
	ld h, [hl] ; $4157
	ld l, a ; $4158
	farcall FarPtr_05_48 ; $4159
	jp Label_14_474e ; $415c
	INCBIN "data/bank_014/d_415f.bin" ; $415f, 1 bytes
Label_14_4160:
	call Func_14_4997 ; $4160
	ld hl, $20b7 ; $4163
	farcall FarPtr_0a_0e ; $4166
	ld a, $05 ; $4169
	farcall FarPtr_0a_08 ; $416b
	ld a, $02 ; $416e
	farcall FarPtr_0a_16 ; $4170
	ld c, l ; $4173
	ld b, h ; $4174
	ld de, $d000 ; $4175
	farcall FarPtr_04_20 ; $4178
	ret ; $417b
Label_14_417c:
	ld hl, $20db ; $417c
	farcall FarPtr_0a_0e ; $417f
	ld hl, $003c ; $4182
	farcall FarPtr_05_48 ; $4185
	ld hl, $c47c ; $4188
	ld a, [hl+] ; $418b
	ld h, [hl] ; $418c
	ld l, a ; $418d
	farcall FarPtr_05_48 ; $418e
	jp Label_14_474e ; $4191
	INCBIN "data/bank_014/d_4194.bin" ; $4194, 1 bytes
Label_14_4195:
	call Func_14_4997 ; $4195
	ld hl, $20be ; $4198
	farcall FarPtr_0a_0e ; $419b
	ld a, $05 ; $419e
	farcall FarPtr_0a_08 ; $41a0
	ld a, $02 ; $41a3
	farcall FarPtr_0a_16 ; $41a5
	ld c, l ; $41a8
	ld b, h ; $41a9
	ld de, $d000 ; $41aa
	farcall FarPtr_04_20 ; $41ad
	ret ; $41b0
Label_14_41b1:
	ld hl, $20db ; $41b1
	farcall FarPtr_0a_0e ; $41b4
	ld hl, $0064 ; $41b7
	farcall FarPtr_05_48 ; $41ba
	ld hl, $c47c ; $41bd
	ld a, [hl+] ; $41c0
	ld h, [hl] ; $41c1
	ld l, a ; $41c2
	farcall FarPtr_05_48 ; $41c3
	jp Label_14_474e ; $41c6
	INCBIN "data/bank_014/d_41c9.bin" ; $41c9, 1 bytes
Label_14_41ca:
	call Func_14_4997 ; $41ca
	ld hl, $20c5 ; $41cd
	farcall FarPtr_0a_0e ; $41d0
	ld a, $05 ; $41d3
	farcall FarPtr_0a_08 ; $41d5
	ld a, $02 ; $41d8
	farcall FarPtr_0a_16 ; $41da
	ld c, l ; $41dd
	ld b, h ; $41de
	ld de, $d000 ; $41df
	farcall FarPtr_04_20 ; $41e2
	ret ; $41e5
	INCBIN "data/bank_014/d_41e6.bin" ; $41e6, 146 bytes
	ld a, $26 ; $4278
	ld [$c329], a ; $427a
	ld a, $23 ; $427d
	ld [$c32a], a ; $427f
	ld a, $40 ; $4282
	ld [$c32b], a ; $4284
	ld a, $3c ; $4287
	ld [$c32c], a ; $4289
	call DisableLCDSafely ; $428c
	ld a, $00 ; $428f
	farcall FarPtr_0a_76 ; $4291
	call EnableLCD ; $4294
	call Func_14_43a4 ; $4297
	farcall FarPtr_0a_3e ; $429a
	ld a, [$c295] ; $429d
	cp a, $05 ; $42a0
	jp z, Label_14_42b0 ; $42a2
	cp a, $07 ; $42a5
	jp z, Label_14_46c5 ; $42a7
	cp a, $ff ; $42aa
	jp z, Label_14_4a00 ; $42ac
	ret ; $42af
Label_14_42b0:
	test_flag $05, 7 ; $42b0
	jr z, Label_14_42d3 ; $42b3
	ld a, $02 ; $42b5
	farcall FarPtr_0a_1c ; $42b7
	push af ; $42ba
	ld a, $0a ; $42bb
	farcall FarPtr_0a_04 ; $42bd
	pop af ; $42c0
	ld a, $02 ; $42c1
	ld bc, $2900 ; $42c3
	ld de, $2b00 ; $42c6
	farcall FarPtr_0a_22 ; $42c9
	ld a, $02 ; $42cc
	ld b, $00 ; $42ce
	farcall FarPtr_0a_2e ; $42d0
Label_14_42d3:
	ld a, $05 ; $42d3
	ld bc, $2d00 ; $42d5
	ld de, $2900 ; $42d8
	farcall FarPtr_0a_22 ; $42db
	ld a, $05 ; $42de
	ld b, $40 ; $42e0
	farcall FarPtr_0a_2e ; $42e2
	ld c, $06 ; $42e5
	call Func_00_1d2e ; $42e7
	call Func_00_1da4 ; $42ea
	push af ; $42ed
	ld a, $28 ; $42ee
	farcall FarPtr_0a_04 ; $42f0
	pop af ; $42f3
	ld a, $00 ; $42f4
	ld bc, $0020 ; $42f6
	farcall FarPtr_0a_18 ; $42f9
	test_flag $05, 7 ; $42fc
	jr z, Label_14_4301 ; $42ff
Label_14_4301:
	xor a, a ; $4301
	ld [$c2d5], a ; $4302
	ld a, [$c4c7] ; $4305
	and a, a ; $4308
	jp nz, Label_14_433a ; $4309
	ld a, [wPointWinLoseFlag] ; $430c
	cp a, $01 ; $430f
	jr z, Label_14_4326 ; $4311
	ld a, [$c2b0] ; $4313
	ld a, a ; $4316
	rst Rst00 ; $4317
	dw Label_14_4113 ; $4318 jumptable
	dw Label_14_4147 ; $431a jumptable
	dw Label_14_417c ; $431c jumptable
	dw Label_14_41b1 ; $431e jumptable
	dw Label_14_4842 ; $4320 jumptable
	dw Label_14_4842 ; $4322 jumptable
	dw Label_14_4842 ; $4324 jumptable
Label_14_4326:
	ld a, [$c2b0] ; $4326
	dec a ; $4329
	ld a, a ; $432a
	rst Rst00 ; $432b
	dw Label_14_412b ; $432c jumptable
	dw Label_14_4160 ; $432e jumptable
	dw Label_14_4195 ; $4330 jumptable
	dw Label_14_41ca ; $4332 jumptable
	dw Label_14_4842 ; $4334 jumptable
	dw Label_14_4842 ; $4336 jumptable
	dw Label_14_4842 ; $4338 jumptable
Label_14_433a:
	ld hl, $20dc ; $433a
	farcall FarPtr_0a_0e ; $433d
	ld a, $05 ; $4340
	farcall FarPtr_0a_08 ; $4342
	ld a, $00 ; $4345
	ld bc, $3300 ; $4347
	ld de, $3600 ; $434a
	farcall FarPtr_0a_24 ; $434d
	ld a, $00 ; $4350
	farcall FarPtr_0a_20 ; $4352
	xor a, a ; $4355
	ld bc, $2f00 ; $4356
	ld de, $2d00 ; $4359
	farcall FarPtr_0a_3a ; $435c
	ld a, $00 ; $435f
	ld bc, $3300 ; $4361
	ld de, $2b00 ; $4364
	farcall FarPtr_0a_24 ; $4367
	ld a, $00 ; $436a
	farcall FarPtr_0a_20 ; $436c
	ld a, $00 ; $436f
	ld bc, $2b00 ; $4371
	ld de, $2b00 ; $4374
	farcall FarPtr_0a_24 ; $4377
	ld a, $00 ; $437a
	farcall FarPtr_0a_20 ; $437c
	ld a, $05 ; $437f
	ld bc, $2d00 ; $4381
	ld de, $2b00 ; $4384
	farcall FarPtr_0a_24 ; $4387
	ld a, $05 ; $438a
	farcall FarPtr_0a_20 ; $438c
	ld a, $05 ; $438f
	ld b, $80 ; $4391
	farcall FarPtr_0a_2e ; $4393
	ld a, $02 ; $4396
	farcall FarPtr_0a_16 ; $4398
	ld c, l ; $439b
	ld b, h ; $439c
	ld de, $d000 ; $439d
	farcall FarPtr_04_20 ; $43a0
	ret ; $43a3
Func_14_43a4:
	ld a, $00 ; $43a4
	test_flag $1a, 2 ; $43a6
	jp z, Label_14_4429 ; $43a9
	ld b, $1e ; $43ac
	ld c, $2c ; $43ae
	ld d, $30 ; $43b0
	ld e, $2c ; $43b2
	ld h, $02 ; $43b4
	ld l, $02 ; $43b6
	farcall FarPtr_0a_7e ; $43b8
	ld a, $01 ; $43bb
	test_flag $1a, 3 ; $43bd
	jp z, Label_14_4429 ; $43c0
	ld b, $1e ; $43c3
	ld c, $30 ; $43c5
	ld d, $30 ; $43c7
	ld e, $30 ; $43c9
	ld h, $02 ; $43cb
	ld l, $02 ; $43cd
	farcall FarPtr_0a_7e ; $43cf
	ld a, $02 ; $43d2
	test_flag $1a, 4 ; $43d4
	jr z, Label_14_4429 ; $43d7
	ld b, $1e ; $43d9
	ld c, $34 ; $43db
	ld d, $30 ; $43dd
	ld e, $34 ; $43df
	ld h, $02 ; $43e1
	ld l, $02 ; $43e3
	farcall FarPtr_0a_7e ; $43e5
	ld a, $03 ; $43e8
	test_flag $1a, 5 ; $43ea
	jr z, Label_14_4429 ; $43ed
	ld b, $1e ; $43ef
	ld c, $38 ; $43f1
	ld d, $30 ; $43f3
	ld e, $38 ; $43f5
	ld h, $02 ; $43f7
	ld l, $02 ; $43f9
	farcall FarPtr_0a_7e ; $43fb
	ld a, $04 ; $43fe
	ld b, a ; $4400
	ld a, $01 ; $4401
	farcall FarPtr_03_2c ; $4403
	ldh a, [$ff96] ; $4406
	push af ; $4408
	ld a, $07 ; $4409
	ldh [$ff96], a ; $440b
	ldh [rWBK], a ; $440d
	ld hl, $de00 ; $440f
	ld a, [hl+] ; $4412
	ld h, [hl] ; $4413
	ld l, a ; $4414
	pop af ; $4415
	ldh [$ff96], a ; $4416
	ldh [rWBK], a ; $4418
	ld a, b ; $441a
	test_flag $1b, 2 ; $441b
	jr z, Label_14_4429 ; $441e
	ld a, $05 ; $4420
	test_flag $1b, 4 ; $4422
	jr z, Label_14_4429 ; $4425
	ld a, $06 ; $4427
Label_14_4429:
	ld [$c2b0], a ; $4429
	ret ; $442c
	INCBIN "data/bank_014/d_442d.bin" ; $442d, 626 bytes
Func_14_469f:
	add a, a ; $469f
	add a, $bd ; $46a0
	ld l, a ; $46a2
	adc a, $46 ; $46a3
	sub a, l ; $46a5
	ld h, a ; $46a6
	ld a, [hl+] ; $46a7
	ld d, [hl] ; $46a8
	ld e, a ; $46a9
	call Func_00_24ef ; $46aa
	ret ; $46ad
	INCBIN "data/bank_014/d_46ae.bin" ; $46ae, 23 bytes
Label_14_46c5:
	xor a, a ; $46c5
	ld [$c2d5], a ; $46c6
	set_flag $1c, 1 ; $46c9
	test_flag $05, 7 ; $46cc
	jr z, Label_14_46ef ; $46cf
	ld a, $02 ; $46d1
	farcall FarPtr_0a_1c ; $46d3
	ld a, $02 ; $46d6
	ld bc, $2900 ; $46d8
	ld de, $2b00 ; $46db
	farcall FarPtr_0a_22 ; $46de
	ld a, $02 ; $46e1
	ld b, $00 ; $46e3
	farcall FarPtr_0a_2e ; $46e5
	push af ; $46e8
	ld a, $0a ; $46e9
	farcall FarPtr_0a_04 ; $46eb
	pop af ; $46ee
Label_14_46ef:
	ld a, $05 ; $46ef
	ld bc, $2d00 ; $46f1
	ld de, $2900 ; $46f4
	farcall FarPtr_0a_22 ; $46f7
	ld a, $05 ; $46fa
	ld b, $40 ; $46fc
	farcall FarPtr_0a_2e ; $46fe
	ld c, $06 ; $4701
	call Func_00_1d2e ; $4703
	call Func_00_1da4 ; $4706
	push af ; $4709
	ld a, $28 ; $470a
	farcall FarPtr_0a_04 ; $470c
	pop af ; $470f
	ld a, [$c4c7] ; $4710
	and a, a ; $4713
	jp nz, Label_14_474d ; $4714
	ld hl, $20db ; $4717
	farcall FarPtr_0a_0e ; $471a
	ld hl, $c47e ; $471d
	ld a, [hl+] ; $4720
	ld h, [hl] ; $4721
	ld l, a ; $4722
	farcall FarPtr_05_48 ; $4723
	ld hl, $c47c ; $4726
	ld a, [hl+] ; $4729
	ld h, [hl] ; $472a
	ld l, a ; $472b
	farcall FarPtr_05_48 ; $472c
	ld a, $00 ; $472f
	ld bc, $0020 ; $4731
	farcall FarPtr_0a_18 ; $4734
	ld a, $05 ; $4737
	farcall FarPtr_0a_0a ; $4739
	farcall FarPtr_0a_12 ; $473c
	farcall FarPtr_0a_0c ; $473f
	push af ; $4742
	ld a, $05 ; $4743
	farcall FarPtr_0a_04 ; $4745
	pop af ; $4748
	and a, a ; $4749
	jp z, Label_14_47cd ; $474a
Label_14_474d:
	ret ; $474d
Label_14_474e:
	ld a, $05 ; $474e
	farcall FarPtr_0a_0a ; $4750
	farcall FarPtr_0a_12 ; $4753
	farcall FarPtr_0a_0c ; $4756
	push af ; $4759
	ld a, $05 ; $475a
	farcall FarPtr_0a_04 ; $475c
	pop af ; $475f
	and a, a ; $4760
	jr z, Label_14_47cd ; $4761
	ld hl, $20dc ; $4763
	farcall FarPtr_0a_0e ; $4766
	ld a, $05 ; $4769
	farcall FarPtr_0a_08 ; $476b
	ld a, $00 ; $476e
	ld bc, $3300 ; $4770
	ld de, $3600 ; $4773
	farcall FarPtr_0a_24 ; $4776
	ld a, $00 ; $4779
	farcall FarPtr_0a_20 ; $477b
	xor a, a ; $477e
	ld bc, $2f00 ; $477f
	ld de, $2d00 ; $4782
	farcall FarPtr_0a_3a ; $4785
	ld a, $00 ; $4788
	ld bc, $3300 ; $478a
	ld de, $2b00 ; $478d
	farcall FarPtr_0a_24 ; $4790
	ld a, $00 ; $4793
	farcall FarPtr_0a_20 ; $4795
	ld a, $00 ; $4798
	ld bc, $2b00 ; $479a
	ld de, $2b00 ; $479d
	farcall FarPtr_0a_24 ; $47a0
	ld a, $00 ; $47a3
	farcall FarPtr_0a_20 ; $47a5
	ld a, $05 ; $47a8
	ld bc, $2d00 ; $47aa
	ld de, $2b00 ; $47ad
	farcall FarPtr_0a_24 ; $47b0
	ld a, $05 ; $47b3
	farcall FarPtr_0a_20 ; $47b5
	ld a, $05 ; $47b8
	ld b, $80 ; $47ba
	farcall FarPtr_0a_2e ; $47bc
	ld a, $02 ; $47bf
	farcall FarPtr_0a_16 ; $47c1
	ld c, l ; $47c4
	ld b, h ; $47c5
	ld de, $d000 ; $47c6
	farcall FarPtr_04_20 ; $47c9
	ret ; $47cc
Label_14_47cd:
	ld a, [$c8f7] ; $47cd
	cp a, $1a ; $47d0
	jr z, Label_14_47ef ; $47d2
	sub a, $12 ; $47d4
	call Func_14_469f ; $47d6
	jr z, Label_14_47ef ; $47d9
	ld a, $12 ; $47db
	ld [wStoryModeCurrentLocation], a ; $47dd
	ld a, $07 ; $47e0
	ld [$c295], a ; $47e2
	ld a, $ff ; $47e5
	ld [$c294], a ; $47e7
	ld [$c2a1], a ; $47ea
	jr Label_14_4801 ; $47ed
Label_14_47ef:
	ld a, $12 ; $47ef
	ld [wStoryModeCurrentLocation], a ; $47f1
	ld a, $05 ; $47f4
	ld [$c295], a ; $47f6
	ld a, $ff ; $47f9
	ld [$c294], a ; $47fb
	ld [$c2a1], a ; $47fe
Label_14_4801:
	ld a, [$c8f7] ; $4801
	farcall FarPtr_0b_00 ; $4804
	ret ; $4807
	INCBIN "data/bank_014/d_4808.bin" ; $4808, 58 bytes
Label_14_4842:
	test_flag $1b, 4 ; $4842
	jr z, Label_14_484f ; $4845
	ld a, [wPointWinLoseFlag] ; $4847
	cp a, $01 ; $484a
	jp z, Label_14_48f9 ; $484c
Label_14_484f:
	ld bc, $0001 ; $484f
	ldh a, [$ff96] ; $4852
	push af ; $4854
	ld a, $07 ; $4855
	ldh [$ff96], a ; $4857
	ldh [rWBK], a ; $4859
	ld hl, $c47c ; $485b
	ld a, [hl+] ; $485e
	ld d, [hl] ; $485f
	ld e, a ; $4860
	pop af ; $4861
	ldh [$ff96], a ; $4862
	ldh [rWBK], a ; $4864
	ld l, c ; $4866
	ld h, b ; $4867
	ld a, l ; $4868
	sub a, e ; $4869
	ld l, a ; $486a
	ld a, h ; $486b
	sbc a, d ; $486c
	ld h, a ; $486d
	jp nc, Label_14_48be ; $486e
	ld bc, $270f ; $4871
	ldh a, [$ff96] ; $4874
	push af ; $4876
	ld a, $07 ; $4877
	ldh [$ff96], a ; $4879
	ldh [rWBK], a ; $487b
	ld a, $01 ; $487d
	farcall FarPtr_03_2c ; $487f
	ld hl, $de00 ; $4882
	ld a, [hl+] ; $4885
	ld d, [hl] ; $4886
	ld e, a ; $4887
	pop af ; $4888
	ldh [$ff96], a ; $4889
	ldh [rWBK], a ; $488b
	ld l, c ; $488d
	ld h, b ; $488e
	ld a, l ; $488f
	sub a, e ; $4890
	ld l, a ; $4891
	ld a, h ; $4892
	sbc a, d ; $4893
	ld h, a ; $4894
	jp z, Label_14_48be ; $4895
	ld hl, $c47c ; $4898
	ld a, [hl+] ; $489b
	ld b, [hl] ; $489c
	ld c, a ; $489d
	ldh a, [$ff96] ; $489e
	push af ; $48a0
	ld a, $07 ; $48a1
	ldh [$ff96], a ; $48a3
	ldh [rWBK], a ; $48a5
	ld hl, $de00 ; $48a7
	ld a, [hl+] ; $48aa
	ld d, [hl] ; $48ab
	ld e, a ; $48ac
	pop af ; $48ad
	ldh [$ff96], a ; $48ae
	ldh [rWBK], a ; $48b0
	ld l, c ; $48b2
	ld h, b ; $48b3
	inc de ; $48b4
	ld a, l ; $48b5
	sub a, e ; $48b6
	ld l, a ; $48b7
	ld a, h ; $48b8
	sbc a, d ; $48b9
	ld h, a ; $48ba
	jp nc, Label_14_48d1 ; $48bb
Label_14_48be:
	ld hl, $20dd ; $48be
	farcall FarPtr_0a_0e ; $48c1
	ld hl, $c47c ; $48c4
	ld a, [hl+] ; $48c7
	ld h, [hl] ; $48c8
	ld l, a ; $48c9
	farcall FarPtr_05_48 ; $48ca
	jp Label_14_474e ; $48cd
	INCBIN "data/bank_014/d_48d0.bin" ; $48d0, 1 bytes
Label_14_48d1:
	call Func_14_4974 ; $48d1
	ld hl, $20ce ; $48d4
	farcall FarPtr_0a_0e ; $48d7
	ld hl, $c47c ; $48da
	ld a, [hl+] ; $48dd
	ld h, [hl] ; $48de
	ld l, a ; $48df
	farcall FarPtr_05_48 ; $48e0
	call Func_14_4997 ; $48e3
	ld a, $05 ; $48e6
	farcall FarPtr_0a_08 ; $48e8
	ld a, $02 ; $48eb
	farcall FarPtr_0a_16 ; $48ed
	ld c, l ; $48f0
	ld b, h ; $48f1
	ld de, $d000 ; $48f2
	farcall FarPtr_04_20 ; $48f5
	ret ; $48f8
Label_14_48f9:
	ldh a, [$ff96] ; $48f9
	push af ; $48fb
	ld a, $07 ; $48fc
	ldh [$ff96], a ; $48fe
	ldh [rWBK], a ; $4900
	ld a, $01 ; $4902
	farcall FarPtr_03_2c ; $4904
	ld hl, $de00 ; $4907
	ld a, [hl+] ; $490a
	ld h, [hl] ; $490b
	ld l, a ; $490c
	pop af ; $490d
	ldh [$ff96], a ; $490e
	ldh [rWBK], a ; $4910
	ld de, $270f ; $4912
	ld a, l ; $4915
	sub a, e ; $4916
	ld l, a ; $4917
	ld a, h ; $4918
	sbc a, d ; $4919
	ld h, a ; $491a
	jp z, Label_14_48be ; $491b
	call Func_14_4974 ; $491e
	ld hl, $20d4 ; $4921
	farcall FarPtr_0a_0e ; $4924
	ld hl, $c47c ; $4927
	ld a, [hl+] ; $492a
	ld h, [hl] ; $492b
	ld l, a ; $492c
	farcall FarPtr_05_48 ; $492d
	ld hl, $20d4 ; $4930
	farcall FarPtr_0a_0e ; $4933
	call Func_14_4997 ; $4936
	ld a, $05 ; $4939
	farcall FarPtr_0a_08 ; $493b
	ld a, $05 ; $493e
	farcall FarPtr_0a_08 ; $4940
	ld a, $02 ; $4943
	farcall FarPtr_0a_16 ; $4945
	ld c, l ; $4948
	ld b, h ; $4949
	ld de, $d000 ; $494a
	farcall FarPtr_04_20 ; $494d
	ret ; $4950
	INCBIN "data/bank_014/d_4951.bin" ; $4951, 35 bytes
Func_14_4974:
	ldh a, [$ff96] ; $4974
	push af ; $4976
	ld a, $07 ; $4977
	ldh [$ff96], a ; $4979
	ldh [rWBK], a ; $497b
	ld hl, $c47c ; $497d
	ld a, [hl+] ; $4980
	ld d, [hl] ; $4981
	ld e, a ; $4982
	ld hl, $de00 ; $4983
	ld a, e ; $4986
	ld [hl+], a ; $4987
	ld [hl], d ; $4988
	ld a, $01 ; $4989
	farcall FarPtr_03_2a ; $498b
	pop af ; $498e
	ldh [$ff96], a ; $498f
	ldh [rWBK], a ; $4991
	call Func_14_43a4 ; $4993
	ret ; $4996
Func_14_4997:
	ld a, $00 ; $4997
	ld bc, $3300 ; $4999
	ld de, $3600 ; $499c
	farcall FarPtr_0a_24 ; $499f
	ld a, $00 ; $49a2
	farcall FarPtr_0a_20 ; $49a4
	xor a, a ; $49a7
	ld bc, $2f00 ; $49a8
	ld de, $2d00 ; $49ab
	farcall FarPtr_0a_3a ; $49ae
	ld a, $00 ; $49b1
	ld bc, $3300 ; $49b3
	ld de, $2b00 ; $49b6
	farcall FarPtr_0a_24 ; $49b9
	ld a, $00 ; $49bc
	farcall FarPtr_0a_20 ; $49be
	ld a, $00 ; $49c1
	ld bc, $2a80 ; $49c3
	ld de, $2b00 ; $49c6
	farcall FarPtr_0a_24 ; $49c9
	ld a, $00 ; $49cc
	farcall FarPtr_0a_20 ; $49ce
	ld a, $05 ; $49d1
	ld bc, $2d00 ; $49d3
	ld de, $2b00 ; $49d6
	farcall FarPtr_0a_24 ; $49d9
	ld a, $05 ; $49dc
	farcall FarPtr_0a_20 ; $49de
	ld a, $00 ; $49e1
	ld b, $00 ; $49e3
	farcall FarPtr_0a_2e ; $49e5
	ld a, $00 ; $49e8
	ld bc, $2b00 ; $49ea
	ld de, $2b00 ; $49ed
	farcall FarPtr_0a_24 ; $49f0
	ld a, $00 ; $49f3
	farcall FarPtr_0a_20 ; $49f5
	ld a, $05 ; $49f8
	ld b, $80 ; $49fa
	farcall FarPtr_0a_2e ; $49fc
	ret ; $49ff
Label_14_4a00:
	test_flag $0f, 5 ; $4a00
	jr z, Label_14_4a38 ; $4a03
	set_flag $1c, 1 ; $4a05
	ld a, $05 ; $4a08
	ld bc, $2d00 ; $4a0a
	ld de, $2900 ; $4a0d
	farcall FarPtr_0a_22 ; $4a10
	ld a, $05 ; $4a13
	ld b, $40 ; $4a15
	farcall FarPtr_0a_2e ; $4a17
	ld a, $02 ; $4a1a
	farcall FarPtr_0a_1c ; $4a1c
	push af ; $4a1f
	ld a, $01 ; $4a20
	farcall FarPtr_0a_04 ; $4a22
	pop af ; $4a25
	ld a, $02 ; $4a26
	ld bc, $2900 ; $4a28
	ld de, $2b00 ; $4a2b
	farcall FarPtr_0a_22 ; $4a2e
	ld a, $02 ; $4a31
	ld b, $00 ; $4a33
	farcall FarPtr_0a_2e ; $4a35
Label_14_4a38:
	ret ; $4a38
	INCBIN "data/bank_014/d_4a39.bin" ; $4a39, 1052 bytes
	ret ; $4e55
	INCBIN "data/bank_014/d_4e56.bin" ; $4e56, 5090 bytes
Func_14_6238:
	ldh a, [$ff96] ; $6238
	push af ; $623a
	ld a, $01 ; $623b
	ldh [$ff96], a ; $623d
	ldh [rWBK], a ; $623f
	ld hl, $5a50 ; $6241
	ld de, $a000 ; $6244
	ld c, $60 ; $6247
	call Func_00_0480 ; $6249
	ld hl, $5e71 ; $624c
	ld de, $0801 ; $624f
	call Func_00_05b0 ; $6252
	pop af ; $6255
	ldh [$ff96], a ; $6256
	ldh [rWBK], a ; $6258
	ret ; $625a
	INCBIN "data/bank_014/d_625b.bin" ; $625b, 5406 bytes
Label_14_7779:
	push af ; $7779
	ld a, $02 ; $777a
	farcall FarPtr_0a_04 ; $777c
	pop af ; $777f
	call Func_14_78a7 ; $7780
	dec h ; $7783
	jr nz, Label_14_7779 ; $7784
	call Func_14_6238 ; $7786
	ld a, $a4 ; $7789
	ld [$c2b0], a ; $778b
	ld a, $c6 ; $778e
	ld [$c2b1], a ; $7790
	ld a, $3c ; $7793
	ld [$c2b2], a ; $7795
	ld a, $01 ; $7798
	ld hl, $625b ; $779a
	call Func_00_1b6a ; $779d
	ld h, $20 ; $77a0
Label_14_77a2:
	push af ; $77a2
	ld a, $02 ; $77a3
	farcall FarPtr_0a_04 ; $77a5
	pop af ; $77a8
	call Func_14_78a7 ; $77a9
	ld a, [$c2b0] ; $77ac
	dec a ; $77af
	ld [$c2b0], a ; $77b0
	and a, $03 ; $77b3
	cp a, $03 ; $77b5
	jr nz, Label_14_77c0 ; $77b7
	ld a, [$c2b1] ; $77b9
	dec a ; $77bc
	ld [$c2b1], a ; $77bd
Label_14_77c0:
	call Func_14_7873 ; $77c0
	dec h ; $77c3
	jr nz, Label_14_77a2 ; $77c4
	ld h, $18 ; $77c6
Label_14_77c8:
	push af ; $77c8
	ld a, $02 ; $77c9
	farcall FarPtr_0a_04 ; $77cb
	pop af ; $77ce
	call Func_14_78a7 ; $77cf
	ld a, [$c2b0] ; $77d2
	dec a ; $77d5
	ld [$c2b0], a ; $77d6
	and a, $01 ; $77d9
	ld b, a ; $77db
	ld a, [$c2b1] ; $77dc
	sub a, b ; $77df
	ld [$c2b1], a ; $77e0
	call Func_14_7873 ; $77e3
	dec h ; $77e6
	jr nz, Label_14_77c8 ; $77e7
	xor a, a ; $77e9
	ld bc, $0b00 ; $77ea
	ld de, $1200 ; $77ed
	farcall FarPtr_0a_3a ; $77f0
	ld h, $18 ; $77f3
Label_14_77f5:
	push af ; $77f5
	ld a, $03 ; $77f6
	farcall FarPtr_0a_04 ; $77f8
	pop af ; $77fb
	call Func_14_78a7 ; $77fc
	ld a, [$c2b1] ; $77ff
	dec a ; $7802
	ld [$c2b1], a ; $7803
	ld a, [$c2b0] ; $7806
	dec a ; $7809
	ld [$c2b0], a ; $780a
	call Func_14_7873 ; $780d
	dec h ; $7810
	jr nz, Label_14_77f5 ; $7811
	ld h, $08 ; $7813
Label_14_7815:
	push af ; $7815
	ld a, $04 ; $7816
	farcall FarPtr_0a_04 ; $7818
	pop af ; $781b
	call Func_14_78a7 ; $781c
	ld a, [$c2b1] ; $781f
	dec a ; $7822
	ld [$c2b1], a ; $7823
	and a, $01 ; $7826
	ld b, a ; $7828
	ld a, [$c2b0] ; $7829
	sub a, b ; $782c
	ld [$c2b0], a ; $782d
	call Func_14_7873 ; $7830
	dec h ; $7833
	jr nz, Label_14_7815 ; $7834
	ld h, $0c ; $7836
Label_14_7838:
	push af ; $7838
	ld a, $06 ; $7839
	farcall FarPtr_0a_04 ; $783b
	pop af ; $783e
	call Func_14_78a7 ; $783f
	ld a, [$c2b1] ; $7842
	dec a ; $7845
	ld [$c2b1], a ; $7846
	call Func_14_7873 ; $7849
	dec h ; $784c
	jr nz, Label_14_7838 ; $784d
	sound $7d ; $784f
	push af ; $7851
	ld a, $46 ; $7852
	farcall FarPtr_0a_04 ; $7854
	pop af ; $7857
	ld c, $04 ; $7858
	call Func_00_1d20 ; $785a
	call Func_00_1da4 ; $785d
	ld a, $14 ; $7860
	ld [wStoryModeCurrentLocation], a ; $7862
	ld a, $02 ; $7865
	ld [$c295], a ; $7867
	ld a, $ff ; $786a
	ld [$c294], a ; $786c
	ld [$c2a1], a ; $786f
	ret ; $7872
Func_14_7873:
	ld a, [$c2b2] ; $7873
	inc a ; $7876
	ld [$c2b2], a ; $7877
	ret ; $787a
	INCBIN "data/bank_014/d_787b.bin" ; $787b, 44 bytes
Func_14_78a7:
	ld a, h ; $78a7
	srl a ; $78a8
	and a, $01 ; $78aa
	jr z, Label_14_78b0 ; $78ac
	sound $7b ; $78ae
Label_14_78b0:
	ret ; $78b0
	INCBIN "data/bank_014/d_78b1.bin" ; $78b1, 612 bytes
	ds 1259, $ff ; $7b15, fill
