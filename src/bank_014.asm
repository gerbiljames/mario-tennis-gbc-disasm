INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $14", ROMX[$4000], BANK[$14]

	ld [$3940], sp ; $4000
	ld c, d ; $4003
	xor a, h ; $4004
	ld c, a ; $4005
	ld hl, $4a52 ; $4006
	ld b, b ; $4009
	add a, [hl] ; $400a
	ld b, b ; $400b
	ld d, $40 ; $400c
	ld a, [$e640] ; $400e
	ld b, c ; $4011
	rst Rst20 ; $4012
	ld b, c ; $4013
	ld a, b ; $4014
	ld b, d ; $4015
	nop ; $4016
	nop ; $4017
	or a, c ; $4018
	ld a, b ; $4019
	nop ; $401a
	dec hl ; $401b
	nop ; $401c
	inc sp ; $401d
	nop ; $401e
	nop ; $401f
	dec a ; $4020
	ld bc, $0000 ; $4021
	nop ; $4024
	nop ; $4025
	or a, c ; $4026
	ld a, b ; $4027
	nop ; $4028
	dec hl ; $4029
	nop ; $402a
	ld sp, $0000 ; $402b
	dec a ; $402e
	ld bc, $0000 ; $402f
	nop ; $4032
	nop ; $4033
	or a, c ; $4034
	ld a, b ; $4035
	nop ; $4036
	dec l ; $4037
	nop ; $4038
	dec hl ; $4039
	add a, b ; $403a
	nop ; $403b
	ld a, $01 ; $403c
	nop ; $403e
	nop ; $403f
	nop ; $4040
	nop ; $4041
	nop ; $4042
	nop ; $4043
	nop ; $4044
	nop ; $4045
	nop ; $4046
	nop ; $4047
	nop ; $4048
	rst Rst38 ; $4049
	ld bc, $00c0 ; $404a
	dec hl ; $404d
	nop ; $404e
	add hl, sp ; $404f
	ld h, e ; $4050
	ld b, b ; $4051
	dec b ; $4052
	ret nz ; $4053
	nop ; $4054
	jr c, Label_14_4057 ; $4055
Label_14_4057:
	ld [hl], $00 ; $4057
	nop ; $4059
	rlca ; $405a
	ret nz ; $405b
	nop ; $405c
	jr c, Label_14_405f ; $405d
Label_14_405f:
	ld [hl], $00 ; $405f
	nop ; $4061
	rst Rst38 ; $4062
	ld a, [$c295] ; $4063
	cp a, $ff ; $4066
	jp z, Label_14_4085 ; $4068
	rst Rst28 ; $406b
	and a, b ; $406c
	rrca ; $406d
	rst Rst30 ; $406e
	ldh [rTIMA], a ; $406f
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
	INCBIN "data/bank_014/d_4086.bin" ; $4086, 443 bytes
Label_14_4241:
	dec l ; $4241
	ld de, $2b00 ; $4242
	farcall FarPtr_0a_24 ; $4245
	ld a, $05 ; $4248
	farcall FarPtr_0a_20 ; $424a
	push af ; $424d
	ld a, $05 ; $424e
	farcall FarPtr_0a_04 ; $4250
	pop af ; $4253
	ld a, $05 ; $4254
	ld b, $80 ; $4256
	farcall FarPtr_0a_2e ; $4258
	ld a, $00 ; $425b
	ld b, $00 ; $425d
	farcall FarPtr_0a_2e ; $425f
	ld a, $02 ; $4262
	farcall FarPtr_0a_16 ; $4264
	ld c, l ; $4267
	ld b, h ; $4268
	ld de, $d000 ; $4269
	farcall FarPtr_04_20 ; $426c
	ret ; $426f
	INCBIN "data/bank_014/d_4270.bin" ; $4270, 8 bytes
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
	rst Rst30 ; $42b0
	ldh [rTIMA], a ; $42b1
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
	rst Rst30 ; $42fc
	ldh [rTIMA], a ; $42fd
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
	inc de ; $4318
	ld b, c ; $4319
	ld b, a ; $431a
	ld b, c ; $431b
	ld a, h ; $431c
	ld b, c ; $431d
	or a, c ; $431e
	ld b, c ; $431f
	ld b, d ; $4320
	ld c, b ; $4321
	ld b, d ; $4322
	ld c, b ; $4323
	ld b, d ; $4324
	ld c, b ; $4325
Label_14_4326:
	ld a, [$c2b0] ; $4326
	dec a ; $4329
	ld a, a ; $432a
	rst Rst00 ; $432b
	dec hl ; $432c
	ld b, c ; $432d
	ld h, b ; $432e
	ld b, c ; $432f
	sub a, l ; $4330
	ld b, c ; $4331
	jp z, Label_14_4241 ; $4332
	ld c, b ; $4335
	ld b, d ; $4336
	ld c, b ; $4337
	ld b, d ; $4338
	ld c, b ; $4339
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
	rst Rst30 ; $43a6
	ld b, b ; $43a7
	ld a, [de] ; $43a8
	jp z, Label_14_4429 ; $43a9
	ld b, $1e ; $43ac
	ld c, $2c ; $43ae
	ld d, $30 ; $43b0
	ld e, $2c ; $43b2
	ld h, $02 ; $43b4
	ld l, $02 ; $43b6
	farcall FarPtr_0a_7e ; $43b8
	ld a, $01 ; $43bb
	rst Rst30 ; $43bd
	ld h, b ; $43be
	ld a, [de] ; $43bf
	jp z, Label_14_4429 ; $43c0
	ld b, $1e ; $43c3
	ld c, $30 ; $43c5
	ld d, $30 ; $43c7
	ld e, $30 ; $43c9
	ld h, $02 ; $43cb
	ld l, $02 ; $43cd
	farcall FarPtr_0a_7e ; $43cf
	ld a, $02 ; $43d2
	rst Rst30 ; $43d4
	add a, b ; $43d5
	ld a, [de] ; $43d6
	jr z, Label_14_4429 ; $43d7
	ld b, $1e ; $43d9
	ld c, $34 ; $43db
	ld d, $30 ; $43dd
	ld e, $34 ; $43df
	ld h, $02 ; $43e1
	ld l, $02 ; $43e3
	farcall FarPtr_0a_7e ; $43e5
	ld a, $03 ; $43e8
	rst Rst30 ; $43ea
	and a, b ; $43eb
	ld a, [de] ; $43ec
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
	rst Rst30 ; $441b
	ld b, b ; $441c
	dec de ; $441d
	jr z, Label_14_4429 ; $441e
	ld a, $05 ; $4420
	rst Rst30 ; $4422
	add a, b ; $4423
	dec de ; $4424
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
	rst Rst20 ; $46c9
	jr nz, Label_14_46e8 ; $46ca
	rst Rst30 ; $46cc
	ldh [rTIMA], a ; $46cd
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
Label_14_46e8:
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
	INCBIN "data/bank_014/d_474e.bin" ; $474e, 127 bytes
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
	INCBIN "data/bank_014/d_4808.bin" ; $4808, 504 bytes
Label_14_4a00:
	rst Rst30 ; $4a00
	and a, b ; $4a01
	rrca ; $4a02
	jr z, Label_14_4a38 ; $4a03
	rst Rst20 ; $4a05
	jr nz, Label_14_4a24 ; $4a06
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
	INCBIN "data/bank_014/d_4a22.bin" ; $4a22, 2 bytes
Label_14_4a24:
	ld a, [bc] ; $4a24
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
	rst Rst08 ; $784f
	ld a, l ; $7850
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
	rst Rst08 ; $78ae
	ld a, e ; $78af
Label_14_78b0:
	ret ; $78b0
	INCBIN "data/bank_014/d_78b1.bin" ; $78b1, 1871 bytes
