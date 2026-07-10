INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $0e", ROMX[$4000], BANK[$0e]

	INCBIN "data/bank_00e/d_4000.bin" ; $4000, 255 bytes
	ld a, [$c295] ; $40ff
	cp a, $ff ; $4102
	jp z, Label_0e_4144 ; $4104
	rst30 $05e0 ; $4107
	jr z, Label_0e_4132 ; $410a
	ld a, $02 ; $410c
	ld bc, $00ff ; $410e
	farcall FarPtr_0a_18 ; $4111
	ld a, $02 ; $4114
	ld b, $40 ; $4116
	ld de, $0200 ; $4118
	farcall FarPtr_0a_2a ; $411b
	ld a, $02 ; $411e
	farcall FarPtr_0a_20 ; $4120
	ld a, $02 ; $4123
	ld b, $c0 ; $4125
	farcall FarPtr_0a_2e ; $4127
	ld a, $02 ; $412a
	ld bc, $0010 ; $412c
	farcall FarPtr_0a_18 ; $412f
Label_0e_4132:
	ld a, $00 ; $4132
	ld bc, $0010 ; $4134
	farcall FarPtr_0a_18 ; $4137
	ld a, $00 ; $413a
	ld b, $c0 ; $413c
	ld de, $0200 ; $413e
	farcall FarPtr_0a_2a ; $4141
Label_0e_4144:
	ret ; $4144
	ld a, [$c295] ; $4145
	cp a, $ff ; $4148
	jp z, Label_0e_41e1 ; $414a
	ld a, $00 ; $414d
	ld bc, $0010 ; $414f
	farcall FarPtr_0a_18 ; $4152
	ld a, $02 ; $4155
	ld bc, $0010 ; $4157
	farcall FarPtr_0a_18 ; $415a
	farcall FarPtr_0a_3e ; $415d
	ld b, $0a ; $4160
	ld c, $0a ; $4162
	ld d, $3d ; $4164
	ld e, $0c ; $4166
	ld h, $02 ; $4168
	ld l, $02 ; $416a
	farcall FarPtr_0a_7e ; $416c
	ld b, $3d ; $416f
	ld c, $0a ; $4171
	ld d, $0a ; $4173
	ld e, $0a ; $4175
	ld h, $02 ; $4177
	ld l, $02 ; $4179
	farcall FarPtr_0a_7e ; $417b
	push af ; $417e
	ld a, $02 ; $417f
	farcall FarPtr_0a_04 ; $4181
	pop af ; $4184
	ld c, $08 ; $4185
	call Func_00_1d2e ; $4187
	call Func_00_1da4 ; $418a
	ld a, $00 ; $418d
	ld bc, $0b00 ; $418f
	ld de, $0e00 ; $4192
	farcall FarPtr_0a_24 ; $4195
	ld a, $00 ; $4198
	farcall FarPtr_0a_20 ; $419a
	sound $71 ; $419d
	push af ; $419f
	ld a, $02 ; $41a0
	farcall FarPtr_0a_04 ; $41a2
	pop af ; $41a5
	ld b, $3a ; $41a6
	ld c, $0a ; $41a8
	ld d, $0a ; $41aa
	ld e, $0a ; $41ac
	ld h, $02 ; $41ae
	ld l, $02 ; $41b0
	farcall FarPtr_0a_7e ; $41b2
	push af ; $41b5
	ld a, $02 ; $41b6
	farcall FarPtr_0a_04 ; $41b8
	pop af ; $41bb
	ld b, $37 ; $41bc
	ld c, $0a ; $41be
	ld d, $0a ; $41c0
	ld e, $0a ; $41c2
	ld h, $02 ; $41c4
	ld l, $02 ; $41c6
	farcall FarPtr_0a_7e ; $41c8
	push af ; $41cb
	ld a, $02 ; $41cc
	farcall FarPtr_0a_04 ; $41ce
	pop af ; $41d1
	ld b, $3d ; $41d2
	ld c, $0c ; $41d4
	ld d, $0a ; $41d6
	ld e, $0a ; $41d8
	ld h, $02 ; $41da
	ld l, $02 ; $41dc
	farcall FarPtr_0a_7e ; $41de
Label_0e_41e1:
	ret ; $41e1
	INCBIN "data/bank_00e/d_41e2.bin" ; $41e2, 101 bytes
	farcall FarPtr_0a_7e ; $4247
	push af ; $424a
	ld a, $02 ; $424b
	farcall FarPtr_0a_04 ; $424d
	pop af ; $4250
	ld b, $37 ; $4251
	ld c, $0a ; $4253
	ld d, $14 ; $4255
	ld e, $0a ; $4257
	ld h, $02 ; $4259
	ld l, $02 ; $425b
	farcall FarPtr_0a_7e ; $425d
	push af ; $4260
	ld a, $02 ; $4261
	farcall FarPtr_0a_04 ; $4263
	pop af ; $4266
	ld b, $3d ; $4267
	ld c, $0c ; $4269
	ld d, $14 ; $426b
	ld e, $0a ; $426d
	ld h, $02 ; $426f
	ld l, $02 ; $4271
	farcall FarPtr_0a_7e ; $4273
	ret ; $4276
	INCBIN "data/bank_00e/d_4277.bin" ; $4277, 25 bytes
	ld a, $00 ; $4290
	ld b, $c0 ; $4292
	farcall FarPtr_0a_2e ; $4294
	ld a, $00 ; $4297
	ld b, $01 ; $4299
	farcall FarPtr_0a_2c ; $429b
	ld a, $00 ; $429e
	ld bc, $0018 ; $42a0
	farcall FarPtr_0a_18 ; $42a3
	ld a, $00 ; $42a6
	ld bc, $0b00 ; $42a8
	ld de, $0d00 ; $42ab
	farcall FarPtr_0a_24 ; $42ae
	ld a, $00 ; $42b1
	farcall FarPtr_0a_20 ; $42b3
	farcall FarPtr_0a_3e ; $42b6
	sound $71 ; $42b9
	ld b, $37 ; $42bb
	ld c, $0a ; $42bd
	ld d, $0a ; $42bf
	ld e, $0a ; $42c1
	ld h, $02 ; $42c3
	ld l, $02 ; $42c5
	farcall FarPtr_0a_7e ; $42c7
	push af ; $42ca
	ld a, $02 ; $42cb
	farcall FarPtr_0a_04 ; $42cd
	pop af ; $42d0
	ld b, $3a ; $42d1
	ld c, $0a ; $42d3
	ld d, $0a ; $42d5
	ld e, $0a ; $42d7
	ld h, $02 ; $42d9
	ld l, $02 ; $42db
	farcall FarPtr_0a_7e ; $42dd
	push af ; $42e0
	ld a, $02 ; $42e1
	farcall FarPtr_0a_04 ; $42e3
	pop af ; $42e6
	ld b, $3d ; $42e7
	ld c, $0a ; $42e9
	ld d, $0a ; $42eb
	ld e, $0a ; $42ed
	ld h, $02 ; $42ef
	ld l, $02 ; $42f1
	farcall FarPtr_0a_7e ; $42f3
	push af ; $42f6
	ld a, $02 ; $42f7
	farcall FarPtr_0a_04 ; $42f9
	pop af ; $42fc
	ld a, $00 ; $42fd
	ld b, $c0 ; $42ff
	ld de, $0100 ; $4301
	farcall FarPtr_0a_2a ; $4304
	ld c, $08 ; $4307
	call Func_00_1d20 ; $4309
	ld a, $00 ; $430c
	ld b, $00 ; $430e
	farcall FarPtr_0a_2c ; $4310
	push af ; $4313
	ld a, $0a ; $4314
	farcall FarPtr_0a_04 ; $4316
	pop af ; $4319
	ret ; $431a
	ld a, $00 ; $431b
	ld b, $c0 ; $431d
	farcall FarPtr_0a_2e ; $431f
	ld a, $00 ; $4322
	ld b, $01 ; $4324
	farcall FarPtr_0a_2c ; $4326
	ld a, $00 ; $4329
	ld bc, $0018 ; $432b
	farcall FarPtr_0a_18 ; $432e
	ld a, $00 ; $4331
	ld bc, $1500 ; $4333
	ld de, $0d00 ; $4336
	farcall FarPtr_0a_24 ; $4339
	ld a, $00 ; $433c
	farcall FarPtr_0a_20 ; $433e
	farcall FarPtr_0a_3e ; $4341
	sound $71 ; $4344
	ld b, $37 ; $4346
	ld c, $0a ; $4348
	ld d, $14 ; $434a
	ld e, $0a ; $434c
	ld h, $02 ; $434e
	ld l, $02 ; $4350
	farcall FarPtr_0a_7e ; $4352
	push af ; $4355
	ld a, $02 ; $4356
	farcall FarPtr_0a_04 ; $4358
	pop af ; $435b
	ld b, $3a ; $435c
	ld c, $0a ; $435e
	ld d, $14 ; $4360
	ld e, $0a ; $4362
	ld h, $02 ; $4364
	ld l, $02 ; $4366
	farcall FarPtr_0a_7e ; $4368
	push af ; $436b
	ld a, $02 ; $436c
	farcall FarPtr_0a_04 ; $436e
	pop af ; $4371
	ld b, $3d ; $4372
	ld c, $0a ; $4374
	ld d, $14 ; $4376
	ld e, $0a ; $4378
	ld h, $02 ; $437a
	ld l, $02 ; $437c
	farcall FarPtr_0a_7e ; $437e
	push af ; $4381
	ld a, $02 ; $4382
	farcall FarPtr_0a_04 ; $4384
	pop af ; $4387
	ld a, $00 ; $4388
	ld b, $c0 ; $438a
	ld de, $0100 ; $438c
	farcall FarPtr_0a_2a ; $438f
	ld c, $08 ; $4392
	call Func_00_1d20 ; $4394
	ld a, $00 ; $4397
	ld b, $00 ; $4399
	farcall FarPtr_0a_2c ; $439b
	push af ; $439e
	ld a, $0a ; $439f
	farcall FarPtr_0a_04 ; $43a1
	pop af ; $43a4
	ret ; $43a5
	INCBIN "data/bank_00e/d_43a6.bin" ; $43a6, 564 bytes
	ld a, $0c ; $45da
	ld [$c2b1], a ; $45dc
	ld bc, $0040 ; $45df
	farcall FarPtr_0a_38 ; $45e2
	xor a, a ; $45e5
	ld bc, $0d00 ; $45e6
	ld de, $1300 ; $45e9
	farcall FarPtr_0a_3a ; $45ec
	farcall FarPtr_0a_3e ; $45ef
	call Func_0e_4d88 ; $45f2
	ret ; $45f5
	INCBIN "data/bank_00e/d_45f6.bin" ; $45f6, 17 bytes
	ld a, $02 ; $4607
	ld [$c294], a ; $4609
	ld [$c2a1], a ; $460c
	ret ; $460f
	ld a, $03 ; $4610
	ld [$c294], a ; $4612
	ld [$c2a1], a ; $4615
	ret ; $4618
	call Func_0e_7e5a ; $4619
	ld a, $07 ; $461c
	farcall FarPtr_0a_16 ; $461e
	ld a, $03 ; $4621
	ld e, l ; $4623
	ld d, h ; $4624
	ld hl, $0018 ; $4625
	add hl, de ; $4628
	ld [hl], a ; $4629
	ld a, $08 ; $462a
	farcall FarPtr_0a_16 ; $462c
	ld a, $03 ; $462f
	ld e, l ; $4631
	ld d, h ; $4632
	ld hl, $0018 ; $4633
	add hl, de ; $4636
	ld [hl], a ; $4637
	ld a, $09 ; $4638
	farcall FarPtr_0a_16 ; $463a
	ld a, $03 ; $463d
	ld e, l ; $463f
	ld d, h ; $4640
	ld hl, $0018 ; $4641
	add hl, de ; $4644
	ld [hl], a ; $4645
	ld a, $07 ; $4646
	ld d, $05 ; $4648
	farcall FarPtr_0a_34 ; $464a
	ld a, $08 ; $464d
	ld d, $05 ; $464f
	farcall FarPtr_0a_34 ; $4651
	ld a, $09 ; $4654
	ld d, $05 ; $4656
	farcall FarPtr_0a_34 ; $4658
	call Func_0e_4681 ; $465b
	ld a, [$c295] ; $465e
	cp a, $0b ; $4661
	jr nz, Label_0e_4669 ; $4663
	call Func_0e_4fbf ; $4665
	ret ; $4668
Label_0e_4669:
	cp a, $0c ; $4669
	jr nz, Label_0e_4671 ; $466b
	call Func_0e_4fdb ; $466d
	ret ; $4670
Label_0e_4671:
	cp a, $0d ; $4671
	jr nz, Label_0e_4679 ; $4673
	call Func_0e_509f ; $4675
	ret ; $4678
Label_0e_4679:
	cp a, $0e ; $4679
	jr nz, Label_0e_4680 ; $467b
	call Func_0e_50b3 ; $467d
Label_0e_4680:
	ret ; $4680
Func_0e_4681:
	ld a, [$c2b0] ; $4681
	sra a ; $4684
	cp a, $01 ; $4686
	jr z, Label_0e_4693 ; $4688
	cp a, $03 ; $468a
	jr z, Label_0e_46b9 ; $468c
	cp a, $04 ; $468e
	jr z, Label_0e_46e9 ; $4690
	ret ; $4692
Label_0e_4693:
	ld d, $34 ; $4693
	ld a, $04 ; $4695
	farcall FarPtr_0a_16 ; $4697
	ld c, l ; $469a
	ld b, h ; $469b
	farcall FarPtr_04_2c ; $469c
	ld a, $03 ; $469f
	ld d, $01 ; $46a1
	farcall FarPtr_0a_34 ; $46a3
	ld a, $04 ; $46a6
	ld bc, $2700 ; $46a8
	ld de, $0f00 ; $46ab
	farcall FarPtr_0a_22 ; $46ae
	ld a, $04 ; $46b1
	ld b, $00 ; $46b3
	farcall FarPtr_0a_2e ; $46b5
	ret ; $46b8
Label_0e_46b9:
	ld a, $07 ; $46b9
	ld bc, $2900 ; $46bb
	ld de, $0700 ; $46be
	farcall FarPtr_0a_22 ; $46c1
	ld a, $08 ; $46c4
	ld bc, $2700 ; $46c6
	ld de, $0500 ; $46c9
	farcall FarPtr_0a_22 ; $46cc
	ld a, $09 ; $46cf
	ld bc, $2500 ; $46d1
	ld de, $0700 ; $46d4
	farcall FarPtr_0a_22 ; $46d7
	ld a, $07 ; $46da
	farcall FarPtr_0a_16 ; $46dc
	ld a, $01 ; $46df
	ld e, l ; $46e1
	ld d, h ; $46e2
	ld hl, $0018 ; $46e3
	add hl, de ; $46e6
	ld [hl], a ; $46e7
	ret ; $46e8
Label_0e_46e9:
	ld a, $07 ; $46e9
	ld bc, $2900 ; $46eb
	ld de, $0700 ; $46ee
	farcall FarPtr_0a_22 ; $46f1
	ld a, $08 ; $46f4
	ld bc, $2700 ; $46f6
	ld de, $0500 ; $46f9
	farcall FarPtr_0a_22 ; $46fc
	ld a, $09 ; $46ff
	ld bc, $2500 ; $4701
	ld de, $0700 ; $4704
	farcall FarPtr_0a_22 ; $4707
	ld a, $07 ; $470a
	ld d, $02 ; $470c
	farcall FarPtr_0a_34 ; $470e
	ret ; $4711
	INCBIN "data/bank_00e/d_4712.bin" ; $4712, 1317 bytes
	ld a, $0c ; $4c37
	farcall FarPtr_0a_16 ; $4c39
	ld c, l ; $4c3c
	ld b, h ; $4c3d
	ld hl, $000e ; $4c3e
	add hl, bc ; $4c41
	ld a, [hl+] ; $4c42
	ld d, [hl] ; $4c43
	ld e, a ; $4c44
	ld hl, $c2b4 ; $4c45
	ld a, e ; $4c48
	ld [hl+], a ; $4c49
	ld [hl], d ; $4c4a
	ld hl, $000c ; $4c4b
	add hl, bc ; $4c4e
	ld a, [hl+] ; $4c4f
	ld d, [hl] ; $4c50
	ld e, a ; $4c51
	ld hl, $c2b2 ; $4c52
	ld a, e ; $4c55
	ld [hl+], a ; $4c56
	ld [hl], d ; $4c57
	ld a, $0a ; $4c58
	farcall FarPtr_0a_16 ; $4c5a
	ld c, l ; $4c5d
	ld b, h ; $4c5e
	ld hl, $000a ; $4c5f
	add hl, bc ; $4c62
	ld a, [hl+] ; $4c63
	ld d, [hl] ; $4c64
	ld e, a ; $4c65
	ld hl, $c2b8 ; $4c66
	ld a, e ; $4c69
	ld [hl+], a ; $4c6a
	ld [hl], d ; $4c6b
	ld hl, $0008 ; $4c6c
	add hl, bc ; $4c6f
	ld a, [hl+] ; $4c70
	ld d, [hl] ; $4c71
	ld e, a ; $4c72
	ld hl, $c2b6 ; $4c73
	ld a, e ; $4c76
	ld [hl+], a ; $4c77
	ld [hl], d ; $4c78
	jp Label_0e_4d3c ; $4c79
	INCBIN "data/bank_00e/d_4c7c.bin" ; $4c7c, 18 bytes
	ld a, $0a ; $4c8e
	farcall FarPtr_0a_16 ; $4c90
	ld c, l ; $4c93
	ld b, h ; $4c94
	ld hl, $000e ; $4c95
	add hl, bc ; $4c98
	ld a, [hl+] ; $4c99
	ld d, [hl] ; $4c9a
	ld e, a ; $4c9b
	ld hl, $c2b4 ; $4c9c
	ld a, e ; $4c9f
	ld [hl+], a ; $4ca0
	ld [hl], d ; $4ca1
	ld hl, $000c ; $4ca2
	add hl, bc ; $4ca5
	ld a, [hl+] ; $4ca6
	ld d, [hl] ; $4ca7
	ld e, a ; $4ca8
	ld hl, $c2b2 ; $4ca9
	ld a, e ; $4cac
	ld [hl+], a ; $4cad
	ld [hl], d ; $4cae
	ld a, $0b ; $4caf
	farcall FarPtr_0a_16 ; $4cb1
	ld c, l ; $4cb4
	ld b, h ; $4cb5
	ld hl, $000a ; $4cb6
	add hl, bc ; $4cb9
	ld a, [hl+] ; $4cba
	ld d, [hl] ; $4cbb
	ld e, a ; $4cbc
	ld hl, $c2b8 ; $4cbd
	ld a, e ; $4cc0
	ld [hl+], a ; $4cc1
	ld [hl], d ; $4cc2
	ld hl, $0008 ; $4cc3
	add hl, bc ; $4cc6
	ld a, [hl+] ; $4cc7
	ld d, [hl] ; $4cc8
	ld e, a ; $4cc9
	ld hl, $c2b6 ; $4cca
	ld a, e ; $4ccd
	ld [hl+], a ; $4cce
	ld [hl], d ; $4ccf
	jp Label_0e_4d3c ; $4cd0
	INCBIN "data/bank_00e/d_4cd3.bin" ; $4cd3, 18 bytes
	ld a, $0b ; $4ce5
	farcall FarPtr_0a_16 ; $4ce7
	ld c, l ; $4cea
	ld b, h ; $4ceb
	ld hl, $000e ; $4cec
	add hl, bc ; $4cef
	ld a, [hl+] ; $4cf0
	ld d, [hl] ; $4cf1
	ld e, a ; $4cf2
	ld hl, $c2b4 ; $4cf3
	ld a, e ; $4cf6
	ld [hl+], a ; $4cf7
	ld [hl], d ; $4cf8
	ld hl, $000c ; $4cf9
	add hl, bc ; $4cfc
	ld a, [hl+] ; $4cfd
	ld d, [hl] ; $4cfe
	ld e, a ; $4cff
	ld hl, $c2b2 ; $4d00
	ld a, e ; $4d03
	ld [hl+], a ; $4d04
	ld [hl], d ; $4d05
	ld a, $0c ; $4d06
	farcall FarPtr_0a_16 ; $4d08
	ld c, l ; $4d0b
	ld b, h ; $4d0c
	ld hl, $000a ; $4d0d
	add hl, bc ; $4d10
	ld a, [hl+] ; $4d11
	ld d, [hl] ; $4d12
	ld e, a ; $4d13
	ld hl, $c2b8 ; $4d14
	ld a, e ; $4d17
	ld [hl+], a ; $4d18
	ld [hl], d ; $4d19
	ld hl, $0008 ; $4d1a
	add hl, bc ; $4d1d
	ld a, [hl+] ; $4d1e
	ld d, [hl] ; $4d1f
	ld e, a ; $4d20
	ld hl, $c2b6 ; $4d21
	ld a, e ; $4d24
	ld [hl+], a ; $4d25
	ld [hl], d ; $4d26
	jp Label_0e_4d3c ; $4d27
	INCBIN "data/bank_00e/d_4d2a.bin" ; $4d2a, 18 bytes
Label_0e_4d3c:
	ld hl, $c2b4 ; $4d3c
	ld a, [hl+] ; $4d3f
	ld d, [hl] ; $4d40
	ld e, a ; $4d41
	ld hl, $c2b8 ; $4d42
	ld a, [hl+] ; $4d45
	ld h, [hl] ; $4d46
	ld l, a ; $4d47
	ld a, l ; $4d48
	sub a, e ; $4d49
	ld l, a ; $4d4a
	ld a, h ; $4d4b
	sbc a, d ; $4d4c
	ld h, a ; $4d4d
	bit 7, h ; $4d4e
	jr z, Label_0e_4d58 ; $4d50
	xor a, a ; $4d52
	sub a, l ; $4d53
	ld l, a ; $4d54
	sbc a, a ; $4d55
	sub a, h ; $4d56
	ld h, a ; $4d57
Label_0e_4d58:
	ld a, h ; $4d58
	cp a, $05 ; $4d59
	jr nc, Label_0e_4d83 ; $4d5b
	ld hl, $c2b2 ; $4d5d
	ld a, [hl+] ; $4d60
	ld d, [hl] ; $4d61
	ld e, a ; $4d62
	ld hl, $c2b6 ; $4d63
	ld a, [hl+] ; $4d66
	ld h, [hl] ; $4d67
	ld l, a ; $4d68
	ld a, l ; $4d69
	sub a, e ; $4d6a
	ld l, a ; $4d6b
	ld a, h ; $4d6c
	sbc a, d ; $4d6d
	ld h, a ; $4d6e
	bit 7, h ; $4d6f
	jr z, Label_0e_4d79 ; $4d71
	xor a, a ; $4d73
	sub a, l ; $4d74
	ld l, a ; $4d75
	sbc a, a ; $4d76
	sub a, h ; $4d77
	ld h, a ; $4d78
Label_0e_4d79:
	ld a, h ; $4d79
	cp a, $05 ; $4d7a
	jr nc, Label_0e_4d83 ; $4d7c
	ld b, $01 ; $4d7e
	ld a, $01 ; $4d80
	ret ; $4d82
Label_0e_4d83:
	ld b, $00 ; $4d83
	ld a, $00 ; $4d85
	ret ; $4d87
Func_0e_4d88:
	ld a, $00 ; $4d88
	ld b, a ; $4d8a
	ld a, $0e ; $4d8b
	farcall FarPtr_0a_30 ; $4d8d
	rst30 $0a60 ; $4d90
	jp z, Label_0e_4da5 ; $4d93
	rst30 $0ae0 ; $4d96
	jp z, Label_0e_4e0d ; $4d99
	rst30 $0b00 ; $4d9c
	jp z, Label_0e_4de5 ; $4d9f
	jp Label_0e_4de5 ; $4da2
Label_0e_4da5:
	rst30 $05e0 ; $4da5
	jr nz, Label_0e_4dcd ; $4da8
	rst30 $0fc0 ; $4daa
	jr z, Label_0e_4db7 ; $4dad
	ld hl, $20e4 ; $4daf
	farcall FarPtr_0a_0e ; $4db2
	jr Label_0e_4dc0 ; $4db5
Label_0e_4db7:
	ld hl, $20e3 ; $4db7
	farcall FarPtr_0a_0e ; $4dba
	rst20 $0fc0 ; $4dbd
Label_0e_4dc0:
	ld a, $0e ; $4dc0
	farcall FarPtr_0a_08 ; $4dc2
	ld a, $0e ; $4dc5
	ld b, $00 ; $4dc7
	farcall FarPtr_0a_2e ; $4dc9
	ret ; $4dcc
Label_0e_4dcd:
	rst30 $0fc0 ; $4dcd
	jr z, Label_0e_4dda ; $4dd0
	ld hl, $20e6 ; $4dd2
	farcall FarPtr_0a_0e ; $4dd5
	jr Label_0e_4dc0 ; $4dd8
Label_0e_4dda:
	ld hl, $20e5 ; $4dda
	farcall FarPtr_0a_0e ; $4ddd
	rst20 $0fc0 ; $4de0
	jr Label_0e_4dc0 ; $4de3
Label_0e_4de5:
	rst20 $0c20 ; $4de5
	rst20 $0c40 ; $4de8
	rst20 $0d00 ; $4deb
	ld hl, $20e9 ; $4dee
	farcall FarPtr_0a_0e ; $4df1
	jr Label_0e_4e26 ; $4df4
	INCBIN "data/bank_00e/d_4df6.bin" ; $4df6, 18 bytes
	farcall FarPtr_0a_0e ; $4e08
	jr Label_0e_4e26 ; $4e0b
Label_0e_4e0d:
	rst20 $0c20 ; $4e0d
	rst30 $0fe0 ; $4e10
	jr z, Label_0e_4e1d ; $4e13
	ld hl, $20e9 ; $4e15
	farcall FarPtr_0a_0e ; $4e18
	jr Label_0e_4e26 ; $4e1b
Label_0e_4e1d:
	ld hl, $20e7 ; $4e1d
	farcall FarPtr_0a_0e ; $4e20
	rst20 $0fe0 ; $4e23
Label_0e_4e26:
	ld a, $00 ; $4e26
	ld b, a ; $4e28
	ld a, $0e ; $4e29
	farcall FarPtr_0a_30 ; $4e2b
	ld a, $0e ; $4e2e
	farcall FarPtr_0a_0a ; $4e30
	farcall FarPtr_0a_12 ; $4e33
	farcall FarPtr_0a_0c ; $4e36
	push af ; $4e39
	ld a, $05 ; $4e3a
	farcall FarPtr_0a_04 ; $4e3c
	pop af ; $4e3f
	and a, a ; $4e40
	jr z, Label_0e_4e4f ; $4e41
Label_0e_4e43:
	ld hl, $20ea ; $4e43
	farcall FarPtr_0a_0e ; $4e46
	ld a, $0e ; $4e49
	farcall FarPtr_0a_08 ; $4e4b
	ret ; $4e4e
Label_0e_4e4f:
	ld hl, $20eb ; $4e4f
	farcall FarPtr_0a_0e ; $4e52
	ld a, $0e ; $4e55
	farcall FarPtr_0a_08 ; $4e57
	push af ; $4e5a
	ld a, $05 ; $4e5b
	farcall FarPtr_0a_04 ; $4e5d
	pop af ; $4e60
Label_0e_4e61:
	ld hl, $20ec ; $4e61
	ld de, $0101 ; $4e64
	farcall FarPtr_0a_46 ; $4e67
Label_0e_4e6a:
	ld [$c2bc], a ; $4e6a
	cp a, $ff ; $4e6d
	jp z, Label_0e_4e43 ; $4e6f
	cp a, $02 ; $4e72
	jp z, Label_0e_4e43 ; $4e74
	cp a, $00 ; $4e77
	jp z, Label_0e_4ee9 ; $4e79
	rst30 $0ae0 ; $4e7c
	jp nz, Label_0e_4eff ; $4e7f
	ld hl, $20e8 ; $4e82
	farcall FarPtr_0a_0e ; $4e85
	ld a, $0e ; $4e88
	farcall FarPtr_0a_08 ; $4e8a
	ld hl, $20f2 ; $4e8d
	farcall FarPtr_0a_0e ; $4e90
	ld a, $0e ; $4e93
	farcall FarPtr_0a_0a ; $4e95
	farcall FarPtr_0a_12 ; $4e98
	farcall FarPtr_0a_0c ; $4e9b
	push af ; $4e9e
	ld a, $05 ; $4e9f
	farcall FarPtr_0a_04 ; $4ea1
	pop af ; $4ea4
	and a, a ; $4ea5
	jr z, Label_0e_4e61 ; $4ea6
	jr Label_0e_4e43 ; $4ea8
	INCBIN "data/bank_00e/d_4eaa.bin" ; $4eaa, 8 bytes
Func_0e_4eb2:
	ld a, [wEquippedRacket] ; $4eb2
	ld [wWaterSpriteMinigameFlag], a ; $4eb5
	ld a, $11 ; $4eb8
	ld [wStoryModeCurrentLocation], a ; $4eba
	ld a, [$c2b1] ; $4ebd
	ld [$c295], a ; $4ec0
	ld a, $ff ; $4ec3
	ld [$c294], a ; $4ec5
	ld [$c2a1], a ; $4ec8
	ld c, $10 ; $4ecb
	call Func_00_1d20 ; $4ecd
	call Func_00_1da4 ; $4ed0
	call Func_00_1b38 ; $4ed3
	call DisableLCDSafely ; $4ed6
	farcall FarPtr_01_0a ; $4ed9
	xor a, a ; $4edc
	ldh [$ffb9], a ; $4edd
	ldh [$ffb8], a ; $4edf
	ldh [$ff8a], a ; $4ee1
	ldh [$ff8b], a ; $4ee3
	ld [$c321], a ; $4ee5
	ret ; $4ee8
Label_0e_4ee9:
	ld hl, $20ed ; $4ee9
	farcall FarPtr_0a_0e ; $4eec
	ld a, $0e ; $4eef
	farcall FarPtr_0a_08 ; $4ef1
	call Func_0e_4eb2 ; $4ef4
	farcall FarPtr_3e_0c ; $4ef7
	and a, a ; $4efa
	jr nz, Label_0e_4f1d ; $4efb
	jr Func_0e_4f13 ; $4efd
Label_0e_4eff:
	ld hl, $20ee ; $4eff
	farcall FarPtr_0a_0e ; $4f02
	ld a, $0e ; $4f05
	farcall FarPtr_0a_08 ; $4f07
	call Func_0e_4eb2 ; $4f0a
	farcall FarPtr_3e_0e ; $4f0d
	and a, a ; $4f10
	jr nz, Label_0e_4f1d ; $4f11
Func_0e_4f13:
	call DisableLCDSafely ; $4f13
	farcall FarPtr_01_0a ; $4f16
	call EnableLCD ; $4f19
	ret ; $4f1c
Label_0e_4f1d:
	ld a, [$c2b1] ; $4f1d
	add a, $02 ; $4f20
	ld [$c2b1], a ; $4f22
	ld a, $11 ; $4f25
	ld [wStoryModeCurrentLocation], a ; $4f27
	ld a, [$c2b1] ; $4f2a
	ld [$c295], a ; $4f2d
	ld a, $ff ; $4f30
	ld [$c294], a ; $4f32
	ld [$c2a1], a ; $4f35
	call Func_0e_4f13 ; $4f38
	ret ; $4f3b
Func_0e_4f3c:
	ldh a, [$ff96] ; $4f3c
	push af ; $4f3e
	ld a, $07 ; $4f3f
	ldh [$ff96], a ; $4f41
	ldh [rWBK], a ; $4f43
	ld de, $df00 ; $4f45
	ld a, $05 ; $4f48
	ldh [$ff96], a ; $4f4a
	ldh [rWBK], a ; $4f4c
	farcall FarPtr_05_4e ; $4f4e
	ld hl, $df00 ; $4f51
	farcall FarPtr_05_46 ; $4f54
	pop af ; $4f57
	ldh [$ff96], a ; $4f58
	ldh [rWBK], a ; $4f5a
	ret ; $4f5c
Func_0e_4f5d:
	ld a, [$c2bc] ; $4f5d
	and a, a ; $4f60
	jr z, Label_0e_4f65 ; $4f61
	jr Label_0e_4f6b ; $4f63
Label_0e_4f65:
	ld a, [wEquippedRacket] ; $4f65
	and a, $0f ; $4f68
	ret ; $4f6a
Label_0e_4f6b:
	ld a, [wEquippedRacket] ; $4f6b
	and a, $f0 ; $4f6e
	swap a ; $4f70
	ret ; $4f72
Func_0e_4f73:
	ld a, [$c2bc] ; $4f73
	and a, a ; $4f76
	jr z, Label_0e_4f7b ; $4f77
	jr Label_0e_4f8a ; $4f79
Label_0e_4f7b:
	call Func_0e_4f5d ; $4f7b
	ld hl, $00e5 ; $4f7e
	add a, l ; $4f81
	ld l, a ; $4f82
	jr nc, Label_0e_4f86 ; $4f83
	inc h ; $4f85
Label_0e_4f86:
	call Func_0e_4f3c ; $4f86
	ret ; $4f89
Label_0e_4f8a:
	call Func_0e_4f5d ; $4f8a
	ld hl, $00f4 ; $4f8d
	add a, l ; $4f90
	ld l, a ; $4f91
	jr nc, Label_0e_4f95 ; $4f92
	inc h ; $4f94
Label_0e_4f95:
	call Func_0e_4f3c ; $4f95
	ret ; $4f98
Func_0e_4f99:
	ld a, [$c2bc] ; $4f99
	and a, a ; $4f9c
	jr z, Label_0e_4fa1 ; $4f9d
	jr Label_0e_4fb0 ; $4f9f
Label_0e_4fa1:
	call Func_0e_4f5d ; $4fa1
	ld hl, $2403 ; $4fa4
	add a, l ; $4fa7
	ld l, a ; $4fa8
	jr nc, Label_0e_4fac ; $4fa9
	inc h ; $4fab
Label_0e_4fac:
	farcall FarPtr_0a_0e ; $4fac
	ret ; $4faf
Label_0e_4fb0:
	call Func_0e_4f5d ; $4fb0
	ld hl, $240a ; $4fb3
	add a, l ; $4fb6
	ld l, a ; $4fb7
	jr nc, Label_0e_4fbb ; $4fb8
	inc h ; $4fba
Label_0e_4fbb:
	farcall FarPtr_0a_0e ; $4fbb
	ret ; $4fbe
Func_0e_4fbf:
	ld a, $0b ; $4fbf
	ld [$c2b1], a ; $4fc1
	ld a, $00 ; $4fc4
	ld b, a ; $4fc6
	ld a, $0e ; $4fc7
	farcall FarPtr_0a_30 ; $4fc9
	ld a, $02 ; $4fcc
	ld bc, $0f00 ; $4fce
	ld de, $0f00 ; $4fd1
	farcall FarPtr_0a_22 ; $4fd4
	jp Label_0e_5015 ; $4fd7
	INCBIN "data/bank_00e/d_4fda.bin" ; $4fda, 1 bytes
Func_0e_4fdb:
	ld a, $0c ; $4fdb
	ld [$c2b1], a ; $4fdd
	farcall FarPtr_0a_3e ; $4fe0
	ld bc, $00f0 ; $4fe3
	farcall FarPtr_0a_38 ; $4fe6
	xor a, a ; $4fe9
	ld bc, $0d00 ; $4fea
	ld de, $1100 ; $4fed
	farcall FarPtr_0a_3a ; $4ff0
	farcall FarPtr_0a_3e ; $4ff3
	ld a, $02 ; $4ff6
	ld bc, $1300 ; $4ff8
	ld de, $1300 ; $4ffb
	farcall FarPtr_0a_22 ; $4ffe
	jp Label_0e_5015 ; $5001
	INCBIN "data/bank_00e/d_5004.bin" ; $5004, 1 bytes
Func_0e_5005:
	ld a, [wWaterSpriteMinigameFlag] ; $5005
	ld b, a ; $5008
	ld a, [wEquippedRacket] ; $5009
	cp a, b ; $500c
	jr z, Label_0e_5012 ; $500d
	ld a, $00 ; $500f
	ret ; $5011
Label_0e_5012:
	ld a, $ff ; $5012
	ret ; $5014
Label_0e_5015:
	xor a, a ; $5015
	ld [$c2d5], a ; $5016
	ld c, $08 ; $5019
	call Func_00_1d2e ; $501b
	call Func_00_1da4 ; $501e
	call Func_0e_5005 ; $5021
	cp a, $ff ; $5024
	jp nz, Label_0e_5056 ; $5026
	ld a, [$c2bc] ; $5029
	ld hl, $2401 ; $502c
	add a, l ; $502f
	ld l, a ; $5030
	jr nc, Label_0e_5034 ; $5031
	inc h ; $5033
Label_0e_5034:
	farcall FarPtr_0a_0e ; $5034
	call Func_0e_4f73 ; $5037
	ld a, $0e ; $503a
	farcall FarPtr_0a_0a ; $503c
	farcall FarPtr_0a_12 ; $503f
	farcall FarPtr_0a_0c ; $5042
	push af ; $5045
	ld a, $05 ; $5046
	farcall FarPtr_0a_04 ; $5048
	pop af ; $504b
	and a, a ; $504c
	jp nz, Label_0e_5080 ; $504d
	ld a, [$c2bc] ; $5050
	jp Label_0e_4e6a ; $5053
Label_0e_5056:
	ld a, [wEquippedRacket] ; $5056
	ld [wWaterSpriteMinigameFlag], a ; $5059
	call Func_0e_4f99 ; $505c
	ld a, $0e ; $505f
	farcall FarPtr_0a_08 ; $5061
	call Func_0e_5153 ; $5064
	rst20 $0fe0 ; $5067
	ld a, $00 ; $506a
	ld b, a ; $506c
	ld a, $0e ; $506d
	farcall FarPtr_0a_30 ; $506f
	ld hl, $20f1 ; $5072
	farcall FarPtr_0a_0e ; $5075
	call Func_0e_4f73 ; $5078
	ld a, $0e ; $507b
	farcall FarPtr_0a_08 ; $507d
Label_0e_5080:
	ld hl, $20f2 ; $5080
	farcall FarPtr_0a_0e ; $5083
	ld a, $0e ; $5086
	farcall FarPtr_0a_0a ; $5088
	farcall FarPtr_0a_12 ; $508b
	farcall FarPtr_0a_0c ; $508e
	push af ; $5091
	ld a, $05 ; $5092
	farcall FarPtr_0a_04 ; $5094
	pop af ; $5097
	and a, a ; $5098
	jp z, Label_0e_4e61 ; $5099
	jp Label_0e_4e43 ; $509c
Func_0e_509f:
	ld a, $0b ; $509f
	ld [$c2b1], a ; $50a1
	ld a, $02 ; $50a4
	ld bc, $0f00 ; $50a6
	ld de, $0f00 ; $50a9
	farcall FarPtr_0a_22 ; $50ac
	jp Label_0e_50dd ; $50af
	INCBIN "data/bank_00e/d_50b2.bin" ; $50b2, 1 bytes
Func_0e_50b3:
	ld a, $0c ; $50b3
	ld [$c2b1], a ; $50b5
	farcall FarPtr_0a_3e ; $50b8
	ld bc, $00f0 ; $50bb
	farcall FarPtr_0a_38 ; $50be
	xor a, a ; $50c1
	ld bc, $0d00 ; $50c2
	ld de, $1300 ; $50c5
	farcall FarPtr_0a_3a ; $50c8
	farcall FarPtr_0a_3e ; $50cb
	ld a, $02 ; $50ce
	ld bc, $1300 ; $50d0
	ld de, $1300 ; $50d3
	farcall FarPtr_0a_22 ; $50d6
	jp Label_0e_50dd ; $50d9
	INCBIN "data/bank_00e/d_50dc.bin" ; $50dc, 1 bytes
Label_0e_50dd:
	xor a, a ; $50dd
	ld [$c2d5], a ; $50de
	ld hl, $20ef ; $50e1
	farcall FarPtr_0a_0e ; $50e4
	ld hl, $00e6 ; $50e7
	call Func_0e_4f3c ; $50ea
	rst20 $0fe0 ; $50ed
	ld a, $00 ; $50f0
	ld b, a ; $50f2
	ld a, $0e ; $50f3
	farcall FarPtr_0a_30 ; $50f5
	ld c, $08 ; $50f8
	call Func_00_1d2e ; $50fa
	call Func_00_1da4 ; $50fd
	ld hl, $20ec ; $5100
	ld de, $0101 ; $5103
	farcall FarPtr_0a_46 ; $5106
	ld [$c2bc], a ; $5109
	cp a, $ff ; $510c
	jp z, Label_0e_4e43 ; $510e
	cp a, $02 ; $5111
	jp z, Label_0e_4e43 ; $5113
	cp a, $00 ; $5116
	jp z, Label_0e_4ee9 ; $5118
	rst30 $0ae0 ; $511b
	jp nz, Label_0e_4eff ; $511e
	ld hl, $20e8 ; $5121
	farcall FarPtr_0a_0e ; $5124
	ld a, $0e ; $5127
	farcall FarPtr_0a_08 ; $5129
	ld hl, $20f2 ; $512c
	farcall FarPtr_0a_0e ; $512f
	ld a, $0e ; $5132
	farcall FarPtr_0a_0a ; $5134
	farcall FarPtr_0a_12 ; $5137
	farcall FarPtr_0a_0c ; $513a
	push af ; $513d
	ld a, $05 ; $513e
	farcall FarPtr_0a_04 ; $5140
	pop af ; $5143
	and a, a ; $5144
	jp z, Label_0e_4e61 ; $5145
	jp Label_0e_4e43 ; $5148
	INCBIN "data/bank_00e/d_514b.bin" ; $514b, 8 bytes
Func_0e_5153:
	ld a, [$c2bc] ; $5153
	ld hl, $20ef ; $5156
	add a, l ; $5159
	ld l, a ; $515a
	jr nc, Label_0e_515e ; $515b
	inc h ; $515d
Label_0e_515e:
	farcall FarPtr_0a_0e ; $515e
	call Func_0e_4f73 ; $5161
	ld a, [$c2bc] ; $5164
	and a, a ; $5167
	jr nz, Label_0e_51a3 ; $5168
	call Func_0e_520f ; $516a
	ld a, $00 ; $516d
	ld d, $09 ; $516f
	farcall FarPtr_0a_34 ; $5171
	ld a, $00 ; $5174
	ld b, $40 ; $5176
	farcall FarPtr_0a_2e ; $5178
	ldh a, [$ff95] ; $517b
	ld b, a ; $517d
	ld a, $00 ; $517e
	ld de, $51d7 ; $5180
	farcall FarPtr_0a_1a ; $5183
	ld a, $8c ; $5186
	farcall FarPtr_0a_08 ; $5188
	ld a, $00 ; $518b
	farcall FarPtr_0a_1c ; $518d
	ld a, $00 ; $5190
	ld d, $01 ; $5192
	farcall FarPtr_0a_34 ; $5194
	ld a, $0e ; $5197
	ld b, a ; $5199
	ld a, $00 ; $519a
	farcall FarPtr_0a_30 ; $519c
	call Func_0e_520f ; $519f
	ret ; $51a2
Label_0e_51a3:
	ld a, $00 ; $51a3
	ld b, $40 ; $51a5
	farcall FarPtr_0a_2e ; $51a7
	ldh a, [$ff95] ; $51aa
	ld b, a ; $51ac
	ld a, $00 ; $51ad
	ld de, $51e4 ; $51af
	farcall FarPtr_0a_1a ; $51b2
	ld a, $8c ; $51b5
	farcall FarPtr_0a_08 ; $51b7
	ld a, $00 ; $51ba
	farcall FarPtr_0a_1c ; $51bc
	ld a, $00 ; $51bf
	ld d, $01 ; $51c1
	farcall FarPtr_0a_34 ; $51c3
	ld a, $00 ; $51c6
	ld bc, $0020 ; $51c8
	farcall FarPtr_0a_18 ; $51cb
	ld a, $0e ; $51ce
	ld b, a ; $51d0
	ld a, $00 ; $51d1
	farcall FarPtr_0a_30 ; $51d3
	ret ; $51d6
	INCBIN "data/bank_00e/d_51d7.bin" ; $51d7, 56 bytes
Func_0e_520f:
	ld a, [$c90e] ; $520f
	and a, a ; $5212
	jr z, Label_0e_5224 ; $5213
	ld a, $00 ; $5215
	farcall FarPtr_0a_16 ; $5217
	ld c, l ; $521a
	ld b, h ; $521b
	ld hl, $0037 ; $521c
	add hl, bc ; $521f
	ld a, [hl] ; $5220
	xor a, $20 ; $5221
	ld [hl], a ; $5223
Label_0e_5224:
	ret ; $5224
	INCBIN "data/bank_00e/d_5225.bin" ; $5225, 500 bytes
	farcall FarPtr_0a_0e ; $5419
	ld a, $10 ; $541c
	farcall FarPtr_0a_08 ; $541e
	ret ; $5421
	INCBIN "data/bank_00e/d_5422.bin" ; $5422, 507 bytes
	farcall FarPtr_0a_34 ; $561d
	ld a, $08 ; $5620
	farcall FarPtr_0a_36 ; $5622
	rst30 $0dc0 ; $5625
	jr nz, Label_0e_562f ; $5628
	ld a, $08 ; $562a
	farcall FarPtr_0a_08 ; $562c
Label_0e_562f:
	ld bc, $0014 ; $562f
	farcall FarPtr_0a_38 ; $5632
	ld a, $00 ; $5635
	ld bc, $0014 ; $5637
	farcall FarPtr_0a_18 ; $563a
	ld a, $13 ; $563d
	ld bc, $0014 ; $563f
	farcall FarPtr_0a_18 ; $5642
	ld a, $08 ; $5645
	ld bc, $0014 ; $5647
	farcall FarPtr_0a_18 ; $564a
	ld a, $00 ; $564d
	ld bc, $1200 ; $564f
	ld de, $1100 ; $5652
	farcall FarPtr_0a_24 ; $5655
	ld a, $13 ; $5658
	ld bc, $1200 ; $565a
	ld de, $1700 ; $565d
	farcall FarPtr_0a_24 ; $5660
	push af ; $5663
	ld a, $28 ; $5664
	farcall FarPtr_0a_04 ; $5666
	pop af ; $5669
	xor a, a ; $566a
	ld bc, $1200 ; $566b
	ld de, $0d00 ; $566e
	farcall FarPtr_0a_3a ; $5671
	ld a, $13 ; $5674
	farcall FarPtr_0a_20 ; $5676
	ld a, $08 ; $5679
	ld bc, $1200 ; $567b
	ld de, $0900 ; $567e
	farcall FarPtr_0a_24 ; $5681
	ld a, $13 ; $5684
	ld bc, $1200 ; $5686
	ld de, $1300 ; $5689
	farcall FarPtr_0a_24 ; $568c
	ld a, $13 ; $568f
	farcall FarPtr_0a_20 ; $5691
	ld a, $13 ; $5694
	ld bc, $0d00 ; $5696
	ld de, $1300 ; $5699
	farcall FarPtr_0a_24 ; $569c
	ld a, $08 ; $569f
	farcall FarPtr_0a_20 ; $56a1
	rst30 $0dc0 ; $56a4
	jr z, Label_0e_56c0 ; $56a7
	ld a, $08 ; $56a9
	ld b, $40 ; $56ab
	farcall FarPtr_0a_2e ; $56ad
	push af ; $56b0
	ld a, $14 ; $56b1
	farcall FarPtr_0a_04 ; $56b3
	pop af ; $56b6
	ld a, $01 ; $56b7
	ld [$c294], a ; $56b9
	ld [$c2a1], a ; $56bc
	ret ; $56bf
Label_0e_56c0:
	call Func_0e_6ad4 ; $56c0
	ld a, $0f ; $56c3
	ld bc, $0020 ; $56c5
	farcall FarPtr_0a_18 ; $56c8
	ld a, $07 ; $56cb
	ld bc, $0020 ; $56cd
	farcall FarPtr_0a_18 ; $56d0
	push af ; $56d3
	ld a, $28 ; $56d4
	farcall FarPtr_0a_04 ; $56d6
	pop af ; $56d9
	ld a, $0f ; $56da
	ld d, $02 ; $56dc
	farcall FarPtr_0a_34 ; $56de
	ld a, $0f ; $56e1
	farcall FarPtr_0a_36 ; $56e3
	ld a, $0f ; $56e6
	ld bc, $0f00 ; $56e8
	ld de, $0e00 ; $56eb
	farcall FarPtr_0a_24 ; $56ee
	ld a, $07 ; $56f1
	ld bc, $1000 ; $56f3
	ld de, $0c00 ; $56f6
	farcall FarPtr_0a_24 ; $56f9
	ld a, $07 ; $56fc
	farcall FarPtr_0a_20 ; $56fe
	ld a, $07 ; $5701
	ld bc, $3f00 ; $5703
	ld de, $3f00 ; $5706
	farcall FarPtr_0a_22 ; $5709
	ld a, $0f ; $570c
	ld b, $c0 ; $570e
	farcall FarPtr_0a_2e ; $5710
	push af ; $5713
	ld a, $14 ; $5714
	farcall FarPtr_0a_04 ; $5716
	pop af ; $5719
	ld a, $0f ; $571a
	farcall FarPtr_0a_08 ; $571c
	push af ; $571f
	ld a, $14 ; $5720
	farcall FarPtr_0a_04 ; $5722
	pop af ; $5725
	ld a, $10 ; $5726
	ld bc, $0020 ; $5728
	farcall FarPtr_0a_18 ; $572b
	ld a, $0e ; $572e
	ld bc, $0020 ; $5730
	farcall FarPtr_0a_18 ; $5733
	ld a, $0f ; $5736
	ld bc, $1000 ; $5738
	ld de, $0d00 ; $573b
	farcall FarPtr_0a_24 ; $573e
	ld a, $0f ; $5741
	farcall FarPtr_0a_20 ; $5743
	push af ; $5746
	ld a, $0a ; $5747
	farcall FarPtr_0a_04 ; $5749
	pop af ; $574c
	ld a, $10 ; $574d
	ld b, $00 ; $574f
	farcall FarPtr_0a_2e ; $5751
	ld a, $10 ; $5754
	ld bc, $0d00 ; $5756
	ld de, $0d00 ; $5759
	farcall FarPtr_0a_24 ; $575c
	ld a, $10 ; $575f
	farcall FarPtr_0a_20 ; $5761
	ld a, $10 ; $5764
	ld b, $c0 ; $5766
	farcall FarPtr_0a_2e ; $5768
	push af ; $576b
	ld a, $0a ; $576c
	farcall FarPtr_0a_04 ; $576e
	pop af ; $5771
	ld a, $0e ; $5772
	ld b, $00 ; $5774
	farcall FarPtr_0a_2e ; $5776
	ld a, $0e ; $5779
	ld bc, $0e00 ; $577b
	ld de, $1000 ; $577e
	farcall FarPtr_0a_24 ; $5781
	ld a, $0e ; $5784
	farcall FarPtr_0a_20 ; $5786
	ld a, $0e ; $5789
	ld b, $c0 ; $578b
	farcall FarPtr_0a_2e ; $578d
	push af ; $5790
	ld a, $28 ; $5791
	farcall FarPtr_0a_04 ; $5793
	pop af ; $5796
	sound $96 ; $5797
	ld a, $04 ; $5799
	ld bc, $0f00 ; $579b
	ld de, $0900 ; $579e
	farcall FarPtr_0a_22 ; $57a1
	push af ; $57a4
	ld a, $04 ; $57a5
	farcall FarPtr_0a_04 ; $57a7
	pop af ; $57aa
	sound $96 ; $57ab
	ld a, $05 ; $57ad
	ld bc, $1300 ; $57af
	ld de, $0700 ; $57b2
	farcall FarPtr_0a_22 ; $57b5
	push af ; $57b8
	ld a, $04 ; $57b9
	farcall FarPtr_0a_04 ; $57bb
	pop af ; $57be
	sound $96 ; $57bf
	ld a, $06 ; $57c1
	ld bc, $1700 ; $57c3
	ld de, $0900 ; $57c6
	farcall FarPtr_0a_22 ; $57c9
	push af ; $57cc
	ld a, $04 ; $57cd
	farcall FarPtr_0a_04 ; $57cf
	pop af ; $57d2
	ld a, $0f ; $57d3
	ld b, $00 ; $57d5
	farcall FarPtr_0a_2e ; $57d7
	ld a, $0f ; $57da
	ld bc, $1100 ; $57dc
	ld de, $0d00 ; $57df
	farcall FarPtr_0a_24 ; $57e2
	ld a, $0f ; $57e5
	farcall FarPtr_0a_20 ; $57e7
	ld a, $0f ; $57ea
	ld b, $c0 ; $57ec
	farcall FarPtr_0a_2e ; $57ee
	push af ; $57f1
	ld a, $0a ; $57f2
	farcall FarPtr_0a_04 ; $57f4
	pop af ; $57f7
	ld a, $10 ; $57f8
	ld b, $00 ; $57fa
	farcall FarPtr_0a_2e ; $57fc
	ld a, $10 ; $57ff
	ld bc, $0f00 ; $5801
	ld de, $0d00 ; $5804
	farcall FarPtr_0a_24 ; $5807
	ld a, $10 ; $580a
	farcall FarPtr_0a_20 ; $580c
	ld a, $10 ; $580f
	ld b, $c0 ; $5811
	farcall FarPtr_0a_2e ; $5813
	push af ; $5816
	ld a, $0a ; $5817
	farcall FarPtr_0a_04 ; $5819
	pop af ; $581c
	ld a, $0e ; $581d
	ld b, $00 ; $581f
	farcall FarPtr_0a_2e ; $5821
	ld a, $0e ; $5824
	ld bc, $1100 ; $5826
	ld de, $0f00 ; $5829
	farcall FarPtr_0a_24 ; $582c
	ld a, $0e ; $582f
	farcall FarPtr_0a_20 ; $5831
	ld a, $0e ; $5834
	ld b, $c0 ; $5836
	farcall FarPtr_0a_2e ; $5838
	push af ; $583b
	ld a, $0a ; $583c
	farcall FarPtr_0a_04 ; $583e
	pop af ; $5841
	call Func_0e_6db7 ; $5842
	sound $96 ; $5845
	ld a, $04 ; $5847
	ld bc, $1380 ; $5849
	ld de, $0f80 ; $584c
	farcall FarPtr_0a_22 ; $584f
	push af ; $5852
	ld a, $14 ; $5853
	farcall FarPtr_0a_04 ; $5855
	pop af ; $5858
	ld a, $12 ; $5859
	ld b, $80 ; $585b
	farcall FarPtr_0a_2e ; $585d
	push af ; $5860
	ld a, $28 ; $5861
	farcall FarPtr_0a_04 ; $5863
	pop af ; $5866
	ld a, $08 ; $5867
	ld d, $03 ; $5869
	farcall FarPtr_0a_34 ; $586b
	ld a, $12 ; $586e
	ld d, $03 ; $5870
	farcall FarPtr_0a_34 ; $5872
	ld a, $12 ; $5875
	farcall FarPtr_0a_36 ; $5877
	push af ; $587a
	ld a, $0a ; $587b
	farcall FarPtr_0a_04 ; $587d
	pop af ; $5880
	ld a, $08 ; $5881
	ld b, $40 ; $5883
	farcall FarPtr_0a_2e ; $5885
	push af ; $5888
	ld a, $0a ; $5889
	farcall FarPtr_0a_04 ; $588b
	pop af ; $588e
	ld a, $08 ; $588f
	ld bc, $0020 ; $5891
	farcall FarPtr_0a_18 ; $5894
	ld a, $08 ; $5897
	ld bc, $1200 ; $5899
	ld de, $0b00 ; $589c
	farcall FarPtr_0a_24 ; $589f
	ld a, $08 ; $58a2
	farcall FarPtr_0a_20 ; $58a4
	ld a, $11 ; $58a7
	ld b, $40 ; $58a9
	farcall FarPtr_0a_2e ; $58ab
	ld a, $12 ; $58ae
	ld b, $40 ; $58b0
	farcall FarPtr_0a_2e ; $58b2
	ld a, $04 ; $58b5
	ld bc, $3f00 ; $58b7
	ld de, $3f00 ; $58ba
	farcall FarPtr_0a_22 ; $58bd
	ld a, $08 ; $58c0
	farcall FarPtr_0a_08 ; $58c2
	push af ; $58c5
	ld a, $0a ; $58c6
	farcall FarPtr_0a_04 ; $58c8
	pop af ; $58cb
	call Func_0e_6f2b ; $58cc
	ld a, $0f ; $58cf
	ld bc, $1300 ; $58d1
	ld de, $0f00 ; $58d4
	farcall FarPtr_0a_24 ; $58d7
	ld a, $10 ; $58da
	ld bc, $1100 ; $58dc
	ld de, $0f00 ; $58df
	farcall FarPtr_0a_24 ; $58e2
	ld a, $0e ; $58e5
	ld bc, $1400 ; $58e7
	ld de, $1100 ; $58ea
	farcall FarPtr_0a_24 ; $58ed
	ld a, $0e ; $58f0
	farcall FarPtr_0a_20 ; $58f2
	ld a, $0e ; $58f5
	ld bc, $1300 ; $58f7
	ld de, $1300 ; $58fa
	farcall FarPtr_0a_24 ; $58fd
	ld a, $0e ; $5900
	farcall FarPtr_0a_20 ; $5902
	ld a, $0e ; $5905
	ld b, $c0 ; $5907
	farcall FarPtr_0a_2e ; $5909
	push af ; $590c
	ld a, $28 ; $590d
	farcall FarPtr_0a_04 ; $590f
	pop af ; $5912
	rst20 $1640 ; $5913
	farcall FarPtr_03_18 ; $5916
	ld a, $08 ; $5919
	farcall FarPtr_0a_0a ; $591b
	farcall FarPtr_0a_12 ; $591e
	farcall FarPtr_0a_0c ; $5921
	push af ; $5924
	ld a, $05 ; $5925
	farcall FarPtr_0a_04 ; $5927
	pop af ; $592a
	and a, a ; $592b
	jr z, Label_0e_5938 ; $592c
	ld hl, $3060 ; $592e
	farcall FarPtr_0a_0e ; $5931
	call Func_0e_7082 ; $5934
	ret ; $5937
Label_0e_5938:
	push af ; $5938
	ld a, $0a ; $5939
	farcall FarPtr_0a_04 ; $593b
	pop af ; $593e
	ld a, $0f ; $593f
	ld d, $03 ; $5941
	farcall FarPtr_0a_34 ; $5943
	ld a, $0f ; $5946
	farcall FarPtr_0a_36 ; $5948
	push af ; $594b
	ld a, $0a ; $594c
	farcall FarPtr_0a_04 ; $594e
	pop af ; $5951
	ld hl, $3063 ; $5952
	farcall FarPtr_0a_0e ; $5955
	ld a, $0f ; $5958
	farcall FarPtr_0a_08 ; $595a
	ld a, $08 ; $595d
	farcall FarPtr_0a_08 ; $595f
	ld a, $0b ; $5962
	ld b, $c0 ; $5964
	farcall FarPtr_0a_2e ; $5966
	push af ; $5969
	ld a, $04 ; $596a
	farcall FarPtr_0a_04 ; $596c
	pop af ; $596f
	ld a, $0f ; $5970
	ld b, $c0 ; $5972
	farcall FarPtr_0a_2e ; $5974
	push af ; $5977
	ld a, $04 ; $5978
	farcall FarPtr_0a_04 ; $597a
	pop af ; $597d
	ld a, $10 ; $597e
	ld b, $c0 ; $5980
	farcall FarPtr_0a_2e ; $5982
	push af ; $5985
	ld a, $04 ; $5986
	farcall FarPtr_0a_04 ; $5988
	pop af ; $598b
	ld a, $0a ; $598c
	ld b, $c0 ; $598e
	farcall FarPtr_0a_2e ; $5990
	push af ; $5993
	ld a, $04 ; $5994
	farcall FarPtr_0a_04 ; $5996
	pop af ; $5999
	ld a, $09 ; $599a
	ld b, $c0 ; $599c
	farcall FarPtr_0a_2e ; $599e
	push af ; $59a1
	ld a, $04 ; $59a2
	farcall FarPtr_0a_04 ; $59a4
	pop af ; $59a7
	ld a, $0e ; $59a8
	ld b, $c0 ; $59aa
	farcall FarPtr_0a_2e ; $59ac
	push af ; $59af
	ld a, $0a ; $59b0
	farcall FarPtr_0a_04 ; $59b2
	pop af ; $59b5
	ld a, $0f ; $59b6
	ld d, $03 ; $59b8
	farcall FarPtr_0a_34 ; $59ba
	ld a, $10 ; $59bd
	ld d, $03 ; $59bf
	farcall FarPtr_0a_34 ; $59c1
	ld a, $0e ; $59c4
	ld d, $03 ; $59c6
	farcall FarPtr_0a_34 ; $59c8
	ld a, $11 ; $59cb
	ld d, $03 ; $59cd
	farcall FarPtr_0a_34 ; $59cf
	ld a, $12 ; $59d2
	ld d, $03 ; $59d4
	farcall FarPtr_0a_34 ; $59d6
	ld a, $0b ; $59d9
	ld d, $03 ; $59db
	farcall FarPtr_0a_34 ; $59dd
	ld a, $0a ; $59e0
	ld d, $03 ; $59e2
	farcall FarPtr_0a_34 ; $59e4
	ld a, $09 ; $59e7
	ld d, $03 ; $59e9
	farcall FarPtr_0a_34 ; $59eb
	ld a, $0c ; $59ee
	ld d, $03 ; $59f0
	farcall FarPtr_0a_34 ; $59f2
	ld a, $13 ; $59f5
	ld d, $03 ; $59f7
	farcall FarPtr_0a_34 ; $59f9
	ld a, $13 ; $59fc
	farcall FarPtr_0a_36 ; $59fe
	ld bc, $0010 ; $5a01
	farcall FarPtr_0a_38 ; $5a04
	xor a, a ; $5a07
	ld bc, $1500 ; $5a08
	ld de, $0d00 ; $5a0b
	farcall FarPtr_0a_3a ; $5a0e
	ld a, $08 ; $5a11
	ld bc, $0014 ; $5a13
	farcall FarPtr_0a_18 ; $5a16
	ld a, $0f ; $5a19
	ld bc, $0014 ; $5a1b
	farcall FarPtr_0a_18 ; $5a1e
	ld a, $10 ; $5a21
	ld bc, $0014 ; $5a23
	farcall FarPtr_0a_18 ; $5a26
	ld a, $0e ; $5a29
	ld bc, $0014 ; $5a2b
	farcall FarPtr_0a_18 ; $5a2e
	ld a, $11 ; $5a31
	ld bc, $0014 ; $5a33
	farcall FarPtr_0a_18 ; $5a36
	ld a, $12 ; $5a39
	ld bc, $0014 ; $5a3b
	farcall FarPtr_0a_18 ; $5a3e
	ld a, $0b ; $5a41
	ld bc, $0014 ; $5a43
	farcall FarPtr_0a_18 ; $5a46
	ld a, $0a ; $5a49
	ld bc, $0014 ; $5a4b
	farcall FarPtr_0a_18 ; $5a4e
	ld a, $09 ; $5a51
	ld bc, $0014 ; $5a53
	farcall FarPtr_0a_18 ; $5a56
	ld a, $0d ; $5a59
	ld bc, $0014 ; $5a5b
	farcall FarPtr_0a_18 ; $5a5e
	ld a, $0c ; $5a61
	ld bc, $0014 ; $5a63
	farcall FarPtr_0a_18 ; $5a66
	ld a, $13 ; $5a69
	ld bc, $0014 ; $5a6b
	farcall FarPtr_0a_18 ; $5a6e
	ld a, $00 ; $5a71
	ld bc, $0014 ; $5a73
	farcall FarPtr_0a_18 ; $5a76
	ldh a, [$ff95] ; $5a79
	ld b, a ; $5a7b
	ld a, $11 ; $5a7c
	ld de, $552d ; $5a7e
	farcall FarPtr_0a_1a ; $5a81
	push af ; $5a84
	ld a, $14 ; $5a85
	farcall FarPtr_0a_04 ; $5a87
	pop af ; $5a8a
	ldh a, [$ff95] ; $5a8b
	ld b, a ; $5a8d
	ld a, $08 ; $5a8e
	ld de, $552d ; $5a90
	farcall FarPtr_0a_1a ; $5a93
	push af ; $5a96
	ld a, $14 ; $5a97
	farcall FarPtr_0a_04 ; $5a99
	pop af ; $5a9c
	ldh a, [$ff95] ; $5a9d
	ld b, a ; $5a9f
	ld a, $12 ; $5aa0
	ld de, $552d ; $5aa2
	farcall FarPtr_0a_1a ; $5aa5
	push af ; $5aa8
	ld a, $64 ; $5aa9
	farcall FarPtr_0a_04 ; $5aab
	pop af ; $5aae
	ldh a, [$ff95] ; $5aaf
	ld b, a ; $5ab1
	ld a, $0b ; $5ab2
	ld de, $552d ; $5ab4
	farcall FarPtr_0a_1a ; $5ab7
	ldh a, [$ff95] ; $5aba
	ld b, a ; $5abc
	ld a, $0a ; $5abd
	ld de, $552d ; $5abf
	farcall FarPtr_0a_1a ; $5ac2
	ldh a, [$ff95] ; $5ac5
	ld b, a ; $5ac7
	ld a, $09 ; $5ac8
	ld de, $552d ; $5aca
	farcall FarPtr_0a_1a ; $5acd
	ldh a, [$ff95] ; $5ad0
	ld b, a ; $5ad2
	ld a, $0c ; $5ad3
	ld de, $552d ; $5ad5
	farcall FarPtr_0a_1a ; $5ad8
	ldh a, [$ff95] ; $5adb
	ld b, a ; $5add
	ld a, $0d ; $5ade
	ld de, $552d ; $5ae0
	farcall FarPtr_0a_1a ; $5ae3
	push af ; $5ae6
	ld a, $3c ; $5ae7
	farcall FarPtr_0a_04 ; $5ae9
	pop af ; $5aec
	ldh a, [$ff95] ; $5aed
	ld b, a ; $5aef
	ld a, $0f ; $5af0
	ld de, $552d ; $5af2
	farcall FarPtr_0a_1a ; $5af5
	ldh a, [$ff95] ; $5af8
	ld b, a ; $5afa
	ld a, $10 ; $5afb
	ld de, $552d ; $5afd
	farcall FarPtr_0a_1a ; $5b00
	push af ; $5b03
	ld a, $28 ; $5b04
	farcall FarPtr_0a_04 ; $5b06
	pop af ; $5b09
	ldh a, [$ff95] ; $5b0a
	ld b, a ; $5b0c
	ld a, $0e ; $5b0d
	ld de, $552d ; $5b0f
	farcall FarPtr_0a_1a ; $5b12
	ld a, $0e ; $5b15
	farcall FarPtr_0a_1e ; $5b17
	xor a, a ; $5b1a
	ld bc, $1200 ; $5b1b
	ld de, $0d00 ; $5b1e
	farcall FarPtr_0a_3a ; $5b21
	ld a, $13 ; $5b24
	ld bc, $1000 ; $5b26
	ld de, $0f00 ; $5b29
	farcall FarPtr_0a_24 ; $5b2c
	ld a, $13 ; $5b2f
	farcall FarPtr_0a_20 ; $5b31
	ld a, $13 ; $5b34
	ld bc, $1200 ; $5b36
	ld de, $0f00 ; $5b39
	farcall FarPtr_0a_24 ; $5b3c
	ld a, $13 ; $5b3f
	farcall FarPtr_0a_20 ; $5b41
	ld a, $13 ; $5b44
	ld b, $40 ; $5b46
	farcall FarPtr_0a_2e ; $5b48
	push af ; $5b4b
	ld a, $14 ; $5b4c
	farcall FarPtr_0a_04 ; $5b4e
	pop af ; $5b51
	ld a, $13 ; $5b52
	farcall FarPtr_0a_08 ; $5b54
	push af ; $5b57
	ld a, $0a ; $5b58
	farcall FarPtr_0a_04 ; $5b5a
	pop af ; $5b5d
	ld a, $00 ; $5b5e
	ld d, $03 ; $5b60
	farcall FarPtr_0a_34 ; $5b62
	ld a, $00 ; $5b65
	farcall FarPtr_0a_36 ; $5b67
	push af ; $5b6a
	ld a, $14 ; $5b6b
	farcall FarPtr_0a_04 ; $5b6d
	pop af ; $5b70
	ldh a, [$ff95] ; $5b71
	ld b, a ; $5b73
	ld a, $13 ; $5b74
	ld de, $5545 ; $5b76
	farcall FarPtr_0a_1a ; $5b79
	push af ; $5b7c
	ld a, $14 ; $5b7d
	farcall FarPtr_0a_04 ; $5b7f
	pop af ; $5b82
	ldh a, [$ff95] ; $5b83
	ld b, a ; $5b85
	ld a, $00 ; $5b86
	ld de, $5545 ; $5b88
	farcall FarPtr_0a_1a ; $5b8b
	push af ; $5b8e
	ld a, $3c ; $5b8f
	farcall FarPtr_0a_04 ; $5b91
	pop af ; $5b94
	xor a, a ; $5b95
	ld bc, $1500 ; $5b96
	ld de, $0d00 ; $5b99
	farcall FarPtr_0a_3a ; $5b9c
	ld a, $00 ; $5b9f
	farcall FarPtr_0a_1e ; $5ba1
	call Func_0e_7150 ; $5ba4
	ld a, $1c ; $5ba7
	ld [wStoryModeCurrentLocation], a ; $5ba9
	ld a, $01 ; $5bac
	ld [$c295], a ; $5bae
	ld a, $ff ; $5bb1
	ld [$c294], a ; $5bb3
	ld [$c2a1], a ; $5bb6
	ret ; $5bb9
	INCBIN "data/bank_00e/d_5bba.bin" ; $5bba, 774 bytes
	farcall FarPtr_0a_20 ; $5ec0
	ld a, $0f ; $5ec3
	ld b, $c0 ; $5ec5
	farcall FarPtr_0a_2e ; $5ec7
	push af ; $5eca
	ld a, $0a ; $5ecb
	farcall FarPtr_0a_04 ; $5ecd
	pop af ; $5ed0
	ld a, $10 ; $5ed1
	ld b, $00 ; $5ed3
	farcall FarPtr_0a_2e ; $5ed5
	ld a, $10 ; $5ed8
	ld bc, $0f00 ; $5eda
	ld de, $0d00 ; $5edd
	farcall FarPtr_0a_24 ; $5ee0
	ld a, $10 ; $5ee3
	farcall FarPtr_0a_20 ; $5ee5
	ld a, $10 ; $5ee8
	ld b, $c0 ; $5eea
	farcall FarPtr_0a_2e ; $5eec
	push af ; $5eef
	ld a, $0a ; $5ef0
	farcall FarPtr_0a_04 ; $5ef2
	pop af ; $5ef5
	ld a, $0e ; $5ef6
	ld b, $00 ; $5ef8
	farcall FarPtr_0a_2e ; $5efa
	ld a, $0e ; $5efd
	ld bc, $1100 ; $5eff
	ld de, $0f00 ; $5f02
	farcall FarPtr_0a_24 ; $5f05
	ld a, $0e ; $5f08
	farcall FarPtr_0a_20 ; $5f0a
	ld a, $0e ; $5f0d
	ld b, $c0 ; $5f0f
	farcall FarPtr_0a_2e ; $5f11
	push af ; $5f14
	ld a, $0a ; $5f15
	farcall FarPtr_0a_04 ; $5f17
	pop af ; $5f1a
	call Func_0e_6db7 ; $5f1b
	sound $96 ; $5f1e
	ld a, $04 ; $5f20
	ld bc, $1180 ; $5f22
	ld de, $0f80 ; $5f25
	farcall FarPtr_0a_22 ; $5f28
	ld a, $05 ; $5f2b
	ld bc, $1380 ; $5f2d
	ld de, $0f80 ; $5f30
	farcall FarPtr_0a_22 ; $5f33
	ld a, $00 ; $5f36
	ld b, $00 ; $5f38
	farcall FarPtr_0a_2e ; $5f3a
	ld a, $02 ; $5f3d
	ld b, $80 ; $5f3f
	farcall FarPtr_0a_2e ; $5f41
	push af ; $5f44
	ld a, $28 ; $5f45
	farcall FarPtr_0a_04 ; $5f47
	pop af ; $5f4a
	ld a, $00 ; $5f4b
	ld b, $c0 ; $5f4d
	farcall FarPtr_0a_2e ; $5f4f
	ld a, $02 ; $5f52
	ld b, $c0 ; $5f54
	farcall FarPtr_0a_2e ; $5f56
	push af ; $5f59
	ld a, $14 ; $5f5a
	farcall FarPtr_0a_04 ; $5f5c
	pop af ; $5f5f
	ld a, $04 ; $5f60
	ld bc, $3f00 ; $5f62
	ld de, $3f00 ; $5f65
	farcall FarPtr_0a_22 ; $5f68
	ld a, $05 ; $5f6b
	ld bc, $3f00 ; $5f6d
	ld de, $3f00 ; $5f70
	farcall FarPtr_0a_22 ; $5f73
	ld a, $12 ; $5f76
	ld b, $80 ; $5f78
	farcall FarPtr_0a_2e ; $5f7a
	push af ; $5f7d
	ld a, $28 ; $5f7e
	farcall FarPtr_0a_04 ; $5f80
	pop af ; $5f83
	ld a, $08 ; $5f84
	ld d, $03 ; $5f86
	farcall FarPtr_0a_34 ; $5f88
	ld a, $12 ; $5f8b
	ld d, $03 ; $5f8d
	farcall FarPtr_0a_34 ; $5f8f
	ld a, $12 ; $5f92
	farcall FarPtr_0a_36 ; $5f94
	push af ; $5f97
	ld a, $0a ; $5f98
	farcall FarPtr_0a_04 ; $5f9a
	pop af ; $5f9d
	ld a, $08 ; $5f9e
	ld b, $40 ; $5fa0
	farcall FarPtr_0a_2e ; $5fa2
	push af ; $5fa5
	ld a, $0a ; $5fa6
	farcall FarPtr_0a_04 ; $5fa8
	pop af ; $5fab
	ld a, $08 ; $5fac
	ld bc, $0020 ; $5fae
	farcall FarPtr_0a_18 ; $5fb1
	ld a, $08 ; $5fb4
	ld bc, $1200 ; $5fb6
	ld de, $0b00 ; $5fb9
	farcall FarPtr_0a_24 ; $5fbc
	ld a, $08 ; $5fbf
	farcall FarPtr_0a_20 ; $5fc1
	ld a, $11 ; $5fc4
	ld b, $40 ; $5fc6
	farcall FarPtr_0a_2e ; $5fc8
	ld a, $12 ; $5fcb
	ld b, $40 ; $5fcd
	farcall FarPtr_0a_2e ; $5fcf
	ld a, $08 ; $5fd2
	farcall FarPtr_0a_08 ; $5fd4
	call Func_0e_6f2b ; $5fd7
	ld a, $0f ; $5fda
	ld bc, $1300 ; $5fdc
	ld de, $0f00 ; $5fdf
	farcall FarPtr_0a_24 ; $5fe2
	ld a, $10 ; $5fe5
	ld bc, $1100 ; $5fe7
	ld de, $0f00 ; $5fea
	farcall FarPtr_0a_24 ; $5fed
	ld a, $0e ; $5ff0
	ld bc, $1500 ; $5ff2
	ld de, $0f00 ; $5ff5
	farcall FarPtr_0a_24 ; $5ff8
	ld a, $0e ; $5ffb
	farcall FarPtr_0a_20 ; $5ffd
	ld a, $0e ; $6000
	ld bc, $1500 ; $6002
	ld de, $1300 ; $6005
	farcall FarPtr_0a_24 ; $6008
	ld a, $0e ; $600b
	farcall FarPtr_0a_20 ; $600d
	ld a, $0e ; $6010
	ld bc, $1300 ; $6012
	ld de, $1300 ; $6015
	farcall FarPtr_0a_24 ; $6018
	ld a, $0e ; $601b
	farcall FarPtr_0a_20 ; $601d
	ld a, $0e ; $6020
	ld b, $c0 ; $6022
	farcall FarPtr_0a_2e ; $6024
	push af ; $6027
	ld a, $28 ; $6028
	farcall FarPtr_0a_04 ; $602a
	pop af ; $602d
	rst20 $1660 ; $602e
	farcall FarPtr_03_18 ; $6031
	ld a, $08 ; $6034
	farcall FarPtr_0a_0a ; $6036
	farcall FarPtr_0a_12 ; $6039
	farcall FarPtr_0a_0c ; $603c
	push af ; $603f
	ld a, $05 ; $6040
	farcall FarPtr_0a_04 ; $6042
	pop af ; $6045
	and a, a ; $6046
	jr z, Label_0e_6060 ; $6047
	ld hl, $307d ; $6049
	farcall FarPtr_0a_0e ; $604c
	call Func_0e_7082 ; $604f
	ld a, $02 ; $6052
	farcall FarPtr_0a_16 ; $6054
	ld c, l ; $6057
	ld b, h ; $6058
	ld de, $d000 ; $6059
	farcall FarPtr_04_20 ; $605c
	ret ; $605f
Label_0e_6060:
	push af ; $6060
	ld a, $0a ; $6061
	farcall FarPtr_0a_04 ; $6063
	pop af ; $6066
	ld a, $0f ; $6067
	ld d, $03 ; $6069
	farcall FarPtr_0a_34 ; $606b
	ld a, $0f ; $606e
	farcall FarPtr_0a_36 ; $6070
	push af ; $6073
	ld a, $0a ; $6074
	farcall FarPtr_0a_04 ; $6076
	pop af ; $6079
	ld hl, $3080 ; $607a
	farcall FarPtr_0a_0e ; $607d
	ld a, $0f ; $6080
	farcall FarPtr_0a_08 ; $6082
	ld a, $08 ; $6085
	farcall FarPtr_0a_08 ; $6087
	ld a, $0b ; $608a
	ld b, $c0 ; $608c
	farcall FarPtr_0a_2e ; $608e
	push af ; $6091
	ld a, $04 ; $6092
	farcall FarPtr_0a_04 ; $6094
	pop af ; $6097
	ld a, $0f ; $6098
	ld b, $c0 ; $609a
	farcall FarPtr_0a_2e ; $609c
	push af ; $609f
	ld a, $04 ; $60a0
	farcall FarPtr_0a_04 ; $60a2
	pop af ; $60a5
	ld a, $10 ; $60a6
	ld b, $c0 ; $60a8
	farcall FarPtr_0a_2e ; $60aa
	push af ; $60ad
	ld a, $04 ; $60ae
	farcall FarPtr_0a_04 ; $60b0
	pop af ; $60b3
	ld a, $0a ; $60b4
	ld b, $c0 ; $60b6
	farcall FarPtr_0a_2e ; $60b8
	push af ; $60bb
	ld a, $04 ; $60bc
	farcall FarPtr_0a_04 ; $60be
	pop af ; $60c1
	ld a, $09 ; $60c2
	ld b, $c0 ; $60c4
	farcall FarPtr_0a_2e ; $60c6
	push af ; $60c9
	ld a, $04 ; $60ca
	farcall FarPtr_0a_04 ; $60cc
	pop af ; $60cf
	ld a, $0e ; $60d0
	ld b, $c0 ; $60d2
	farcall FarPtr_0a_2e ; $60d4
	push af ; $60d7
	ld a, $0a ; $60d8
	farcall FarPtr_0a_04 ; $60da
	pop af ; $60dd
	ld a, $0f ; $60de
	ld d, $03 ; $60e0
	farcall FarPtr_0a_34 ; $60e2
	ld a, $10 ; $60e5
	ld d, $03 ; $60e7
	farcall FarPtr_0a_34 ; $60e9
	ld a, $0e ; $60ec
	ld d, $03 ; $60ee
	farcall FarPtr_0a_34 ; $60f0
	ld a, $11 ; $60f3
	ld d, $03 ; $60f5
	farcall FarPtr_0a_34 ; $60f7
	ld a, $12 ; $60fa
	ld d, $03 ; $60fc
	farcall FarPtr_0a_34 ; $60fe
	ld a, $0b ; $6101
	ld d, $03 ; $6103
	farcall FarPtr_0a_34 ; $6105
	ld a, $0a ; $6108
	ld d, $03 ; $610a
	farcall FarPtr_0a_34 ; $610c
	ld a, $09 ; $610f
	ld d, $03 ; $6111
	farcall FarPtr_0a_34 ; $6113
	ld a, $0c ; $6116
	ld d, $03 ; $6118
	farcall FarPtr_0a_34 ; $611a
	ld a, $13 ; $611d
	ld d, $03 ; $611f
	farcall FarPtr_0a_34 ; $6121
	ld a, $13 ; $6124
	farcall FarPtr_0a_36 ; $6126
	ld bc, $0010 ; $6129
	farcall FarPtr_0a_38 ; $612c
	xor a, a ; $612f
	ld bc, $1500 ; $6130
	ld de, $0d00 ; $6133
	farcall FarPtr_0a_3a ; $6136
	ld a, $08 ; $6139
	ld bc, $0014 ; $613b
	farcall FarPtr_0a_18 ; $613e
	ld a, $0f ; $6141
	ld bc, $0014 ; $6143
	farcall FarPtr_0a_18 ; $6146
	ld a, $10 ; $6149
	ld bc, $0014 ; $614b
	farcall FarPtr_0a_18 ; $614e
	ld a, $0e ; $6151
	ld bc, $0014 ; $6153
	farcall FarPtr_0a_18 ; $6156
	ld a, $11 ; $6159
	ld bc, $0014 ; $615b
	farcall FarPtr_0a_18 ; $615e
	ld a, $12 ; $6161
	ld bc, $0014 ; $6163
	farcall FarPtr_0a_18 ; $6166
	ld a, $0b ; $6169
	ld bc, $0014 ; $616b
	farcall FarPtr_0a_18 ; $616e
	ld a, $0a ; $6171
	ld bc, $0014 ; $6173
	farcall FarPtr_0a_18 ; $6176
	ld a, $09 ; $6179
	ld bc, $0014 ; $617b
	farcall FarPtr_0a_18 ; $617e
	ld a, $0d ; $6181
	ld bc, $0014 ; $6183
	farcall FarPtr_0a_18 ; $6186
	ld a, $0c ; $6189
	ld bc, $0014 ; $618b
	farcall FarPtr_0a_18 ; $618e
	ld a, $13 ; $6191
	ld bc, $0014 ; $6193
	farcall FarPtr_0a_18 ; $6196
	ld a, $00 ; $6199
	ld bc, $0014 ; $619b
	farcall FarPtr_0a_18 ; $619e
	ldh a, [$ff95] ; $61a1
	ld b, a ; $61a3
	ld a, $11 ; $61a4
	ld de, $552d ; $61a6
	farcall FarPtr_0a_1a ; $61a9
	push af ; $61ac
	ld a, $14 ; $61ad
	farcall FarPtr_0a_04 ; $61af
	pop af ; $61b2
	ldh a, [$ff95] ; $61b3
	ld b, a ; $61b5
	ld a, $08 ; $61b6
	ld de, $552d ; $61b8
	farcall FarPtr_0a_1a ; $61bb
	push af ; $61be
	ld a, $14 ; $61bf
	farcall FarPtr_0a_04 ; $61c1
	pop af ; $61c4
	ldh a, [$ff95] ; $61c5
	ld b, a ; $61c7
	ld a, $12 ; $61c8
	ld de, $552d ; $61ca
	farcall FarPtr_0a_1a ; $61cd
	push af ; $61d0
	ld a, $64 ; $61d1
	farcall FarPtr_0a_04 ; $61d3
	pop af ; $61d6
	ldh a, [$ff95] ; $61d7
	ld b, a ; $61d9
	ld a, $0b ; $61da
	ld de, $552d ; $61dc
	farcall FarPtr_0a_1a ; $61df
	ldh a, [$ff95] ; $61e2
	ld b, a ; $61e4
	ld a, $0a ; $61e5
	ld de, $552d ; $61e7
	farcall FarPtr_0a_1a ; $61ea
	ldh a, [$ff95] ; $61ed
	ld b, a ; $61ef
	ld a, $09 ; $61f0
	ld de, $552d ; $61f2
	farcall FarPtr_0a_1a ; $61f5
	ldh a, [$ff95] ; $61f8
	ld b, a ; $61fa
	ld a, $0c ; $61fb
	ld de, $552d ; $61fd
	farcall FarPtr_0a_1a ; $6200
	ldh a, [$ff95] ; $6203
	ld b, a ; $6205
	ld a, $0d ; $6206
	ld de, $552d ; $6208
	farcall FarPtr_0a_1a ; $620b
	push af ; $620e
	ld a, $3c ; $620f
	farcall FarPtr_0a_04 ; $6211
	pop af ; $6214
	ldh a, [$ff95] ; $6215
	ld b, a ; $6217
	ld a, $0f ; $6218
	ld de, $552d ; $621a
	farcall FarPtr_0a_1a ; $621d
	ldh a, [$ff95] ; $6220
	ld b, a ; $6222
	ld a, $10 ; $6223
	ld de, $552d ; $6225
	farcall FarPtr_0a_1a ; $6228
	push af ; $622b
	ld a, $1e ; $622c
	farcall FarPtr_0a_04 ; $622e
	pop af ; $6231
	ld a, $0e ; $6232
	ld bc, $1500 ; $6234
	ld de, $1300 ; $6237
	farcall FarPtr_0a_24 ; $623a
	ld a, $0e ; $623d
	farcall FarPtr_0a_20 ; $623f
	ldh a, [$ff95] ; $6242
	ld b, a ; $6244
	ld a, $0e ; $6245
	ld de, $552d ; $6247
	farcall FarPtr_0a_1a ; $624a
	ld a, $0e ; $624d
	farcall FarPtr_0a_1e ; $624f
	xor a, a ; $6252
	ld bc, $1200 ; $6253
	ld de, $0d00 ; $6256
	farcall FarPtr_0a_3a ; $6259
	ld a, $13 ; $625c
	ld bc, $1000 ; $625e
	ld de, $0f00 ; $6261
	farcall FarPtr_0a_24 ; $6264
	ld a, $13 ; $6267
	farcall FarPtr_0a_20 ; $6269
	ld a, $13 ; $626c
	ld bc, $1200 ; $626e
	ld de, $0f00 ; $6271
	farcall FarPtr_0a_24 ; $6274
	ld a, $13 ; $6277
	farcall FarPtr_0a_20 ; $6279
	ld a, $13 ; $627c
	ld b, $40 ; $627e
	farcall FarPtr_0a_2e ; $6280
	push af ; $6283
	ld a, $14 ; $6284
	farcall FarPtr_0a_04 ; $6286
	pop af ; $6289
	ld a, $13 ; $628a
	farcall FarPtr_0a_08 ; $628c
	push af ; $628f
	ld a, $0a ; $6290
	farcall FarPtr_0a_04 ; $6292
	pop af ; $6295
	ld a, $02 ; $6296
	ld d, $03 ; $6298
	farcall FarPtr_0a_34 ; $629a
	ld a, $00 ; $629d
	ld d, $03 ; $629f
	farcall FarPtr_0a_34 ; $62a1
	ld a, $00 ; $62a4
	farcall FarPtr_0a_36 ; $62a6
	push af ; $62a9
	ld a, $14 ; $62aa
	farcall FarPtr_0a_04 ; $62ac
	pop af ; $62af
	ldh a, [$ff95] ; $62b0
	ld b, a ; $62b2
	ld a, $13 ; $62b3
	ld de, $5545 ; $62b5
	farcall FarPtr_0a_1a ; $62b8
	push af ; $62bb
	ld a, $14 ; $62bc
	farcall FarPtr_0a_04 ; $62be
	pop af ; $62c1
	ldh a, [$ff95] ; $62c2
	ld b, a ; $62c4
	ld a, $00 ; $62c5
	ld de, $5545 ; $62c7
	farcall FarPtr_0a_1a ; $62ca
	push af ; $62cd
	ld a, $32 ; $62ce
	farcall FarPtr_0a_04 ; $62d0
	pop af ; $62d3
	ldh a, [$ff95] ; $62d4
	ld b, a ; $62d6
	ld a, $02 ; $62d7
	ld de, $5545 ; $62d9
	farcall FarPtr_0a_1a ; $62dc
	push af ; $62df
	ld a, $3c ; $62e0
	farcall FarPtr_0a_04 ; $62e2
	pop af ; $62e5
	xor a, a ; $62e6
	ld bc, $1500 ; $62e7
	ld de, $0d00 ; $62ea
	farcall FarPtr_0a_3a ; $62ed
	ld a, $02 ; $62f0
	farcall FarPtr_0a_1e ; $62f2
	call Func_0e_7150 ; $62f5
	ld a, $1c ; $62f8
	ld [wStoryModeCurrentLocation], a ; $62fa
	ld a, $04 ; $62fd
	ld [$c295], a ; $62ff
	ld a, $ff ; $6302
	ld [$c294], a ; $6304
	ld [$c2a1], a ; $6307
	ret ; $630a
	INCBIN "data/bank_00e/d_630b.bin" ; $630b, 316 bytes
	farcall FarPtr_0a_1a ; $6447
	call Func_0e_6987 ; $644a
	ld a, $08 ; $644d
	ld b, $40 ; $644f
	farcall FarPtr_0a_2e ; $6451
	ldh a, [$ff95] ; $6454
	ld b, a ; $6456
	ld a, $00 ; $6457
	ld de, $63da ; $6459
	farcall FarPtr_0a_1a ; $645c
	push af ; $645f
	ld a, $14 ; $6460
	farcall FarPtr_0a_04 ; $6462
	pop af ; $6465
	ldh a, [$ff95] ; $6466
	ld b, a ; $6468
	ld a, $02 ; $6469
	ld de, $63e7 ; $646b
	farcall FarPtr_0a_1a ; $646e
	ld a, $00 ; $6471
	farcall FarPtr_0a_1e ; $6473
	ld a, $02 ; $6476
	farcall FarPtr_0a_1e ; $6478
	jp Label_0e_65d4 ; $647b
	INCBIN "data/bank_00e/d_647e.bin" ; $647e, 238 bytes
	farcall FarPtr_0a_24 ; $656c
	ld a, $00 ; $656f
	farcall FarPtr_0a_20 ; $6571
	ld a, $00 ; $6574
	ld bc, $1200 ; $6576
	ld de, $0d00 ; $6579
	farcall FarPtr_0a_24 ; $657c
	ld a, $00 ; $657f
	farcall FarPtr_0a_20 ; $6581
	ld a, $00 ; $6584
	ld b, $c0 ; $6586
	farcall FarPtr_0a_2e ; $6588
	ld a, $08 ; $658b
	ld b, $40 ; $658d
	farcall FarPtr_0a_2e ; $658f
	jp Label_0e_65d4 ; $6592
	INCBIN "data/bank_00e/d_6595.bin" ; $6595, 63 bytes
Label_0e_65d4:
	farcall FarPtr_0a_00 ; $65d4
	ld bc, $0018 ; $65d7
	farcall FarPtr_0a_38 ; $65da
	xor a, a ; $65dd
	ld bc, $1200 ; $65de
	ld de, $0d00 ; $65e1
	farcall FarPtr_0a_3a ; $65e4
	farcall FarPtr_0a_3e ; $65e7
	ld a, $02 ; $65ea
	ld [wWaterSpriteMinigameTimer], a ; $65ec
	ld hl, $c2b2 ; $65ef
	ld de, $3083 ; $65f2
	ld a, e ; $65f5
	ld [hl+], a ; $65f6
	ld [hl], d ; $65f7
	rst30 $05e0 ; $65f8
	jr z, Label_0e_660b ; $65fb
	ld a, $05 ; $65fd
	ld [wWaterSpriteMinigameTimer], a ; $65ff
	ld hl, $c2b2 ; $6602
	ld de, $3089 ; $6605
	ld a, e ; $6608
	ld [hl+], a ; $6609
	ld [hl], d ; $660a
Label_0e_660b:
	ld hl, $c2b2 ; $660b
	ld a, [hl+] ; $660e
	ld h, [hl] ; $660f
	ld l, a ; $6610
	farcall FarPtr_0a_0e ; $6611
	ld a, $08 ; $6614
	farcall FarPtr_0a_0a ; $6616
	farcall FarPtr_0a_12 ; $6619
	farcall FarPtr_0a_0c ; $661c
	push af ; $661f
	ld a, $05 ; $6620
	farcall FarPtr_0a_04 ; $6622
	pop af ; $6625
	and a, a ; $6626
	jr z, Label_0e_6644 ; $6627
	ld a, $08 ; $6629
	farcall FarPtr_0a_08 ; $662b
	rst30 $05e0 ; $662e
	jr z, Label_0e_6640 ; $6631
	ld a, $02 ; $6633
	farcall FarPtr_0a_16 ; $6635
	ld c, l ; $6638
	ld b, h ; $6639
	ld de, $d000 ; $663a
	farcall FarPtr_04_20 ; $663d
Label_0e_6640:
	farcall FarPtr_0a_02 ; $6640
	ret ; $6643
Label_0e_6644:
	ld a, [$c2b0] ; $6644
	and a, $01 ; $6647
	jr z, Label_0e_666e ; $6649
	farcall FarPtr_0a_10 ; $664b
	ld a, $08 ; $664e
	farcall FarPtr_0a_08 ; $6650
	ld hl, $3088 ; $6653
	ld de, $0101 ; $6656
	ld a, $01 ; $6659
	farcall FarPtr_05_3e ; $665b
	cp a, $ff ; $665e
	jp z, Label_0e_660b ; $6660
	inc a ; $6663
	rst30 $05e0 ; $6664
	jr z, Label_0e_666b ; $6667
	add a, $03 ; $6669
Label_0e_666b:
	ld [wWaterSpriteMinigameTimer], a ; $666b
Label_0e_666e:
	ld hl, $c2b2 ; $666e
	ld a, [hl+] ; $6671
	ld h, [hl] ; $6672
	ld l, a ; $6673
	ld a, $03 ; $6674
	add a, l ; $6676
	ld l, a ; $6677
	jr nc, Label_0e_667b ; $6678
	inc h ; $667a
Label_0e_667b:
	farcall FarPtr_0a_0e ; $667b
	ld a, $08 ; $667e
	farcall FarPtr_0a_08 ; $6680
	ld a, $0b ; $6683
	ld b, $c0 ; $6685
	farcall FarPtr_0a_2e ; $6687
	push af ; $668a
	ld a, $04 ; $668b
	farcall FarPtr_0a_04 ; $668d
	pop af ; $6690
	ld a, $0f ; $6691
	ld b, $c0 ; $6693
	farcall FarPtr_0a_2e ; $6695
	push af ; $6698
	ld a, $04 ; $6699
	farcall FarPtr_0a_04 ; $669b
	pop af ; $669e
	ld a, $10 ; $669f
	ld b, $c0 ; $66a1
	farcall FarPtr_0a_2e ; $66a3
	push af ; $66a6
	ld a, $04 ; $66a7
	farcall FarPtr_0a_04 ; $66a9
	pop af ; $66ac
	ld a, $0a ; $66ad
	ld b, $c0 ; $66af
	farcall FarPtr_0a_2e ; $66b1
	push af ; $66b4
	ld a, $04 ; $66b5
	farcall FarPtr_0a_04 ; $66b7
	pop af ; $66ba
	ld a, $09 ; $66bb
	ld b, $c0 ; $66bd
	farcall FarPtr_0a_2e ; $66bf
	push af ; $66c2
	ld a, $04 ; $66c3
	farcall FarPtr_0a_04 ; $66c5
	pop af ; $66c8
	ld a, $0e ; $66c9
	ld b, $c0 ; $66cb
	farcall FarPtr_0a_2e ; $66cd
	push af ; $66d0
	ld a, $0a ; $66d1
	farcall FarPtr_0a_04 ; $66d3
	pop af ; $66d6
	ld a, $0f ; $66d7
	ld d, $03 ; $66d9
	farcall FarPtr_0a_34 ; $66db
	ld a, $10 ; $66de
	ld d, $03 ; $66e0
	farcall FarPtr_0a_34 ; $66e2
	ld a, $0e ; $66e5
	ld d, $03 ; $66e7
	farcall FarPtr_0a_34 ; $66e9
	ld a, $11 ; $66ec
	ld d, $03 ; $66ee
	farcall FarPtr_0a_34 ; $66f0
	ld a, $12 ; $66f3
	ld d, $03 ; $66f5
	farcall FarPtr_0a_34 ; $66f7
	ld a, $0b ; $66fa
	ld d, $03 ; $66fc
	farcall FarPtr_0a_34 ; $66fe
	ld a, $0a ; $6701
	ld d, $03 ; $6703
	farcall FarPtr_0a_34 ; $6705
	ld a, $09 ; $6708
	ld d, $03 ; $670a
	farcall FarPtr_0a_34 ; $670c
	ld a, $0c ; $670f
	ld d, $03 ; $6711
	farcall FarPtr_0a_34 ; $6713
	ld a, $13 ; $6716
	ld d, $03 ; $6718
	farcall FarPtr_0a_34 ; $671a
	ld a, $13 ; $671d
	farcall FarPtr_0a_36 ; $671f
	ld bc, $0018 ; $6722
	farcall FarPtr_0a_38 ; $6725
	xor a, a ; $6728
	ld bc, $1500 ; $6729
	ld de, $0d00 ; $672c
	farcall FarPtr_0a_3a ; $672f
	ld a, $08 ; $6732
	ld bc, $0020 ; $6734
	farcall FarPtr_0a_18 ; $6737
	ld a, $0f ; $673a
	ld bc, $0020 ; $673c
	farcall FarPtr_0a_18 ; $673f
	ld a, $10 ; $6742
	ld bc, $0020 ; $6744
	farcall FarPtr_0a_18 ; $6747
	ld a, $0e ; $674a
	ld bc, $0020 ; $674c
	farcall FarPtr_0a_18 ; $674f
	ld a, $11 ; $6752
	ld bc, $0020 ; $6754
	farcall FarPtr_0a_18 ; $6757
	ld a, $12 ; $675a
	ld bc, $0020 ; $675c
	farcall FarPtr_0a_18 ; $675f
	ld a, $0b ; $6762
	ld bc, $0020 ; $6764
	farcall FarPtr_0a_18 ; $6767
	ld a, $0a ; $676a
	ld bc, $0020 ; $676c
	farcall FarPtr_0a_18 ; $676f
	ld a, $09 ; $6772
	ld bc, $0020 ; $6774
	farcall FarPtr_0a_18 ; $6777
	ld a, $0d ; $677a
	ld bc, $0020 ; $677c
	farcall FarPtr_0a_18 ; $677f
	ld a, $0c ; $6782
	ld bc, $0020 ; $6784
	farcall FarPtr_0a_18 ; $6787
	ld a, $13 ; $678a
	ld bc, $0020 ; $678c
	farcall FarPtr_0a_18 ; $678f
	ld a, $00 ; $6792
	ld bc, $0020 ; $6794
	farcall FarPtr_0a_18 ; $6797
	ld a, $12 ; $679a
	ld b, $00 ; $679c
	farcall FarPtr_0a_2e ; $679e
	push af ; $67a1
	ld a, $0a ; $67a2
	farcall FarPtr_0a_04 ; $67a4
	pop af ; $67a7
	ld a, $08 ; $67a8
	ld b, $00 ; $67aa
	farcall FarPtr_0a_2e ; $67ac
	push af ; $67af
	ld a, $0a ; $67b0
	farcall FarPtr_0a_04 ; $67b2
	pop af ; $67b5
	ld a, $11 ; $67b6
	ld b, $00 ; $67b8
	farcall FarPtr_0a_2e ; $67ba
	push af ; $67bd
	ld a, $14 ; $67be
	farcall FarPtr_0a_04 ; $67c0
	pop af ; $67c3
	ldh a, [$ff95] ; $67c4
	ld b, a ; $67c6
	ld a, $12 ; $67c7
	ld de, $552d ; $67c9
	farcall FarPtr_0a_1a ; $67cc
	push af ; $67cf
	ld a, $14 ; $67d0
	farcall FarPtr_0a_04 ; $67d2
	pop af ; $67d5
	ldh a, [$ff95] ; $67d6
	ld b, a ; $67d8
	ld a, $08 ; $67d9
	ld de, $552d ; $67db
	farcall FarPtr_0a_1a ; $67de
	push af ; $67e1
	ld a, $14 ; $67e2
	farcall FarPtr_0a_04 ; $67e4
	pop af ; $67e7
	ldh a, [$ff95] ; $67e8
	ld b, a ; $67ea
	ld a, $11 ; $67eb
	ld de, $552d ; $67ed
	farcall FarPtr_0a_1a ; $67f0
	push af ; $67f3
	ld a, $64 ; $67f4
	farcall FarPtr_0a_04 ; $67f6
	pop af ; $67f9
	rst30 $05e0 ; $67fa
	jr nz, Label_0e_680c ; $67fd
	ld a, $00 ; $67ff
	ld bc, $1200 ; $6801
	ld de, $0900 ; $6804
	farcall FarPtr_0a_24 ; $6807
	jr Label_0e_682a ; $680a
Label_0e_680c:
	ld a, $02 ; $680c
	ld bc, $0020 ; $680e
	farcall FarPtr_0a_18 ; $6811
	ld a, $00 ; $6814
	ld bc, $1100 ; $6816
	ld de, $0900 ; $6819
	farcall FarPtr_0a_24 ; $681c
	ld a, $02 ; $681f
	ld bc, $1300 ; $6821
	ld de, $0900 ; $6824
	farcall FarPtr_0a_24 ; $6827
Label_0e_682a:
	ldh a, [$ff95] ; $682a
	ld b, a ; $682c
	ld a, $0b ; $682d
	ld de, $552d ; $682f
	farcall FarPtr_0a_1a ; $6832
	ldh a, [$ff95] ; $6835
	ld b, a ; $6837
	ld a, $0a ; $6838
	ld de, $552d ; $683a
	farcall FarPtr_0a_1a ; $683d
	ldh a, [$ff95] ; $6840
	ld b, a ; $6842
	ld a, $09 ; $6843
	ld de, $552d ; $6845
	farcall FarPtr_0a_1a ; $6848
	ldh a, [$ff95] ; $684b
	ld b, a ; $684d
	ld a, $0c ; $684e
	ld de, $552d ; $6850
	farcall FarPtr_0a_1a ; $6853
	ldh a, [$ff95] ; $6856
	ld b, a ; $6858
	ld a, $0d ; $6859
	ld de, $552d ; $685b
	farcall FarPtr_0a_1a ; $685e
	push af ; $6861
	ld a, $1e ; $6862
	farcall FarPtr_0a_04 ; $6864
	pop af ; $6867
	ld a, $00 ; $6868
	ld b, $40 ; $686a
	farcall FarPtr_0a_2e ; $686c
	rst30 $05e0 ; $686f
	jr z, Label_0e_687b ; $6872
	ld a, $02 ; $6874
	ld b, $40 ; $6876
	farcall FarPtr_0a_2e ; $6878
Label_0e_687b:
	ldh a, [$ff95] ; $687b
	ld b, a ; $687d
	ld a, $0f ; $687e
	ld de, $552d ; $6880
	farcall FarPtr_0a_1a ; $6883
	push af ; $6886
	ld a, $28 ; $6887
	farcall FarPtr_0a_04 ; $6889
	pop af ; $688c
	ldh a, [$ff95] ; $688d
	ld b, a ; $688f
	ld a, $10 ; $6890
	ld de, $552d ; $6892
	farcall FarPtr_0a_1a ; $6895
	push af ; $6898
	ld a, $14 ; $6899
	farcall FarPtr_0a_04 ; $689b
	pop af ; $689e
	ldh a, [$ff95] ; $689f
	ld b, a ; $68a1
	ld a, $0e ; $68a2
	ld de, $552d ; $68a4
	farcall FarPtr_0a_1a ; $68a7
	ld a, $0e ; $68aa
	farcall FarPtr_0a_1e ; $68ac
	xor a, a ; $68af
	ld bc, $1200 ; $68b0
	ld de, $0d00 ; $68b3
	farcall FarPtr_0a_3a ; $68b6
	rst30 $05e0 ; $68b9
	jr nz, Label_0e_68cb ; $68bc
	ld a, $00 ; $68be
	ld bc, $1200 ; $68c0
	ld de, $0b00 ; $68c3
	farcall FarPtr_0a_24 ; $68c6
	jr Label_0e_68e1 ; $68c9
Label_0e_68cb:
	ld a, $00 ; $68cb
	ld bc, $1100 ; $68cd
	ld de, $0b00 ; $68d0
	farcall FarPtr_0a_24 ; $68d3
	ld a, $02 ; $68d6
	ld bc, $1300 ; $68d8
	ld de, $0b00 ; $68db
	farcall FarPtr_0a_24 ; $68de
Label_0e_68e1:
	ld a, $13 ; $68e1
	ld bc, $1200 ; $68e3
	ld de, $0d00 ; $68e6
	farcall FarPtr_0a_24 ; $68e9
	ld a, $13 ; $68ec
	farcall FarPtr_0a_20 ; $68ee
	ld a, $13 ; $68f1
	ld b, $c0 ; $68f3
	farcall FarPtr_0a_2e ; $68f5
	push af ; $68f8
	ld a, $14 ; $68f9
	farcall FarPtr_0a_04 ; $68fb
	pop af ; $68fe
	ld a, $13 ; $68ff
	farcall FarPtr_0a_08 ; $6901
	push af ; $6904
	ld a, $0a ; $6905
	farcall FarPtr_0a_04 ; $6907
	pop af ; $690a
	ld a, $00 ; $690b
	ld d, $03 ; $690d
	farcall FarPtr_0a_34 ; $690f
	rst30 $05e0 ; $6912
	jr z, Label_0e_691e ; $6915
	ld a, $02 ; $6917
	ld d, $03 ; $6919
	farcall FarPtr_0a_34 ; $691b
Label_0e_691e:
	ld a, $00 ; $691e
	farcall FarPtr_0a_36 ; $6920
	push af ; $6923
	ld a, $14 ; $6924
	farcall FarPtr_0a_04 ; $6926
	pop af ; $6929
	ldh a, [$ff95] ; $692a
	ld b, a ; $692c
	ld a, $13 ; $692d
	ld de, $5545 ; $692f
	farcall FarPtr_0a_1a ; $6932
	push af ; $6935
	ld a, $14 ; $6936
	farcall FarPtr_0a_04 ; $6938
	pop af ; $693b
	ldh a, [$ff95] ; $693c
	ld b, a ; $693e
	ld a, $00 ; $693f
	ld de, $5545 ; $6941
	farcall FarPtr_0a_1a ; $6944
	rst30 $05e0 ; $6947
	jr z, Label_0e_695e ; $694a
	push af ; $694c
	ld a, $28 ; $694d
	farcall FarPtr_0a_04 ; $694f
	pop af ; $6952
	ldh a, [$ff95] ; $6953
	ld b, a ; $6955
	ld a, $02 ; $6956
	ld de, $5545 ; $6958
	farcall FarPtr_0a_1a ; $695b
Label_0e_695e:
	xor a, a ; $695e
	ld bc, $1500 ; $695f
	ld de, $0d00 ; $6962
	farcall FarPtr_0a_3a ; $6965
	ld a, $00 ; $6968
	farcall FarPtr_0a_1e ; $696a
	call Func_0e_7150 ; $696d
	ld a, $1c ; $6970
	ld [wStoryModeCurrentLocation], a ; $6972
	ld a, [wWaterSpriteMinigameTimer] ; $6975
	ld [$c295], a ; $6978
	ld a, $ff ; $697b
	ld [$c294], a ; $697d
	ld [$c2a1], a ; $6980
	farcall FarPtr_0a_02 ; $6983
	ret ; $6986
Func_0e_6987:
	ld a, $04 ; $6987
	ldh [$ff96], a ; $6989
	ldh [rWBK], a ; $698b
	ld a, $00 ; $698d
	farcall FarPtr_0a_16 ; $698f
	ld c, l ; $6992
	ld b, h ; $6993
	ld hl, $000e ; $6994
	add hl, bc ; $6997
	ld a, [hl+] ; $6998
	ld d, [hl] ; $6999
	ld e, a ; $699a
	ld hl, $000c ; $699b
	add hl, bc ; $699e
	ld a, [hl+] ; $699f
	ld b, [hl] ; $69a0
	ld c, a ; $69a1
	ld a, $02 ; $69a2
	farcall FarPtr_0a_24 ; $69a4
	ld a, $02 ; $69a7
	farcall FarPtr_0a_20 ; $69a9
	ret ; $69ac
	INCBIN "data/bank_00e/d_69ad.bin" ; $69ad, 47 bytes
	farcall FarPtr_0a_3e ; $69dc
	ld a, $00 ; $69df
	ld bc, $1100 ; $69e1
	ld de, $0f00 ; $69e4
	farcall FarPtr_0a_22 ; $69e7
	ld a, $02 ; $69ea
	ld bc, $1300 ; $69ec
	ld de, $0f00 ; $69ef
	farcall FarPtr_0a_22 ; $69f2
	farcall FarPtr_0a_02 ; $69f5
	jp Label_0e_69fb ; $69f8
Label_0e_69fb:
	ld a, $08 ; $69fb
	ld bc, $1200 ; $69fd
	ld de, $0b00 ; $6a00
	farcall FarPtr_0a_22 ; $6a03
	ld a, $10 ; $6a06
	ld b, $00 ; $6a08
	farcall FarPtr_0a_2e ; $6a0a
	ld a, $0f ; $6a0d
	ld b, $00 ; $6a0f
	farcall FarPtr_0a_2e ; $6a11
	ld a, $0d ; $6a14
	ld b, $00 ; $6a16
	farcall FarPtr_0a_2e ; $6a18
	ld a, $0e ; $6a1b
	ld b, $00 ; $6a1d
	farcall FarPtr_0a_2e ; $6a1f
	ld a, $0b ; $6a22
	ld b, $80 ; $6a24
	farcall FarPtr_0a_2e ; $6a26
	ld a, $0a ; $6a29
	ld b, $80 ; $6a2b
	farcall FarPtr_0a_2e ; $6a2d
	ld a, $09 ; $6a30
	ld b, $80 ; $6a32
	farcall FarPtr_0a_2e ; $6a34
	ld a, $0c ; $6a37
	ld b, $80 ; $6a39
	farcall FarPtr_0a_2e ; $6a3b
	ld a, $13 ; $6a3e
	ld bc, $0d00 ; $6a40
	ld de, $1300 ; $6a43
	farcall FarPtr_0a_22 ; $6a46
	ld a, $13 ; $6a49
	ld b, $00 ; $6a4b
	farcall FarPtr_0a_2e ; $6a4d
	ret ; $6a50
	INCBIN "data/bank_00e/d_6a51.bin" ; $6a51, 131 bytes
Func_0e_6ad4:
	push af ; $6ad4
	ld a, $0a ; $6ad5
	farcall FarPtr_0a_04 ; $6ad7
	pop af ; $6ada
	ld a, $08 ; $6adb
	ld b, $40 ; $6add
	farcall FarPtr_0a_2e ; $6adf
	push af ; $6ae2
	ld a, $04 ; $6ae3
	farcall FarPtr_0a_04 ; $6ae5
	pop af ; $6ae8
	ld a, $10 ; $6ae9
	ld b, $00 ; $6aeb
	farcall FarPtr_0a_2e ; $6aed
	push af ; $6af0
	ld a, $04 ; $6af1
	farcall FarPtr_0a_04 ; $6af3
	pop af ; $6af6
	ld a, $0f ; $6af7
	ld b, $00 ; $6af9
	farcall FarPtr_0a_2e ; $6afb
	push af ; $6afe
	ld a, $04 ; $6aff
	farcall FarPtr_0a_04 ; $6b01
	pop af ; $6b04
	ld a, $0d ; $6b05
	ld b, $00 ; $6b07
	farcall FarPtr_0a_2e ; $6b09
	push af ; $6b0c
	ld a, $04 ; $6b0d
	farcall FarPtr_0a_04 ; $6b0f
	pop af ; $6b12
	ld a, $0e ; $6b13
	ld b, $00 ; $6b15
	farcall FarPtr_0a_2e ; $6b17
	push af ; $6b1a
	ld a, $04 ; $6b1b
	farcall FarPtr_0a_04 ; $6b1d
	pop af ; $6b20
	ld a, $0b ; $6b21
	ld b, $80 ; $6b23
	farcall FarPtr_0a_2e ; $6b25
	push af ; $6b28
	ld a, $04 ; $6b29
	farcall FarPtr_0a_04 ; $6b2b
	pop af ; $6b2e
	ld a, $0a ; $6b2f
	ld b, $80 ; $6b31
	farcall FarPtr_0a_2e ; $6b33
	push af ; $6b36
	ld a, $04 ; $6b37
	farcall FarPtr_0a_04 ; $6b39
	pop af ; $6b3c
	ld a, $09 ; $6b3d
	ld b, $80 ; $6b3f
	farcall FarPtr_0a_2e ; $6b41
	push af ; $6b44
	ld a, $04 ; $6b45
	farcall FarPtr_0a_04 ; $6b47
	pop af ; $6b4a
	ld a, $13 ; $6b4b
	ld b, $c0 ; $6b4d
	farcall FarPtr_0a_2e ; $6b4f
	push af ; $6b52
	ld a, $04 ; $6b53
	farcall FarPtr_0a_04 ; $6b55
	pop af ; $6b58
	ld a, $0c ; $6b59
	ld b, $c0 ; $6b5b
	farcall FarPtr_0a_2e ; $6b5d
	push af ; $6b60
	ld a, $14 ; $6b61
	farcall FarPtr_0a_04 ; $6b63
	pop af ; $6b66
	ld a, $08 ; $6b67
	ld d, $03 ; $6b69
	farcall FarPtr_0a_34 ; $6b6b
	ld a, $08 ; $6b6e
	farcall FarPtr_0a_36 ; $6b70
	ld a, $08 ; $6b73
	farcall FarPtr_0a_08 ; $6b75
	push af ; $6b78
	ld a, $14 ; $6b79
	farcall FarPtr_0a_04 ; $6b7b
	pop af ; $6b7e
	ld a, $11 ; $6b7f
	ld d, $03 ; $6b81
	farcall FarPtr_0a_34 ; $6b83
	ld a, $11 ; $6b86
	farcall FarPtr_0a_36 ; $6b88
	ld a, $11 ; $6b8b
	farcall FarPtr_0a_08 ; $6b8d
	ld a, $08 ; $6b90
	ld b, $80 ; $6b92
	farcall FarPtr_0a_2e ; $6b94
	push af ; $6b97
	ld a, $0a ; $6b98
	farcall FarPtr_0a_04 ; $6b9a
	pop af ; $6b9d
	ld a, $11 ; $6b9e
	ld b, $00 ; $6ba0
	farcall FarPtr_0a_2e ; $6ba2
	push af ; $6ba5
	ld a, $14 ; $6ba6
	farcall FarPtr_0a_04 ; $6ba8
	pop af ; $6bab
	ld a, $11 ; $6bac
	ld d, $03 ; $6bae
	farcall FarPtr_0a_34 ; $6bb0
	ld a, $08 ; $6bb3
	ld d, $03 ; $6bb5
	farcall FarPtr_0a_34 ; $6bb7
	ld a, $08 ; $6bba
	farcall FarPtr_0a_36 ; $6bbc
	push af ; $6bbf
	ld a, $0a ; $6bc0
	farcall FarPtr_0a_04 ; $6bc2
	pop af ; $6bc5
	ld a, $08 ; $6bc6
	ld b, $40 ; $6bc8
	farcall FarPtr_0a_2e ; $6bca
	push af ; $6bcd
	ld a, $0a ; $6bce
	farcall FarPtr_0a_04 ; $6bd0
	pop af ; $6bd3
	ld a, $11 ; $6bd4
	ld b, $40 ; $6bd6
	farcall FarPtr_0a_2e ; $6bd8
	push af ; $6bdb
	ld a, $1e ; $6bdc
	farcall FarPtr_0a_04 ; $6bde
	pop af ; $6be1
	ld a, $08 ; $6be2
	farcall FarPtr_0a_08 ; $6be4
	ld a, $08 ; $6be7
	ld b, $00 ; $6be9
	farcall FarPtr_0a_2e ; $6beb
	push af ; $6bee
	ld a, $0a ; $6bef
	farcall FarPtr_0a_04 ; $6bf1
	pop af ; $6bf4
	ld a, $12 ; $6bf5
	ld b, $80 ; $6bf7
	farcall FarPtr_0a_2e ; $6bf9
	push af ; $6bfc
	ld a, $14 ; $6bfd
	farcall FarPtr_0a_04 ; $6bff
	pop af ; $6c02
	ld a, $12 ; $6c03
	ld d, $03 ; $6c05
	farcall FarPtr_0a_34 ; $6c07
	ld a, $08 ; $6c0a
	ld d, $03 ; $6c0c
	farcall FarPtr_0a_34 ; $6c0e
	ld a, $08 ; $6c11
	farcall FarPtr_0a_36 ; $6c13
	push af ; $6c16
	ld a, $0a ; $6c17
	farcall FarPtr_0a_04 ; $6c19
	pop af ; $6c1c
	ld a, $08 ; $6c1d
	ld b, $40 ; $6c1f
	farcall FarPtr_0a_2e ; $6c21
	push af ; $6c24
	ld a, $0a ; $6c25
	farcall FarPtr_0a_04 ; $6c27
	pop af ; $6c2a
	ld a, $12 ; $6c2b
	ld b, $40 ; $6c2d
	farcall FarPtr_0a_2e ; $6c2f
	push af ; $6c32
	ld a, $1e ; $6c33
	farcall FarPtr_0a_04 ; $6c35
	pop af ; $6c38
	ld a, $08 ; $6c39
	farcall FarPtr_0a_08 ; $6c3b
	push af ; $6c3e
	ld a, $14 ; $6c3f
	farcall FarPtr_0a_04 ; $6c41
	pop af ; $6c44
	ld a, $10 ; $6c45
	ld de, $ff80 ; $6c47
	farcall FarPtr_0a_42 ; $6c4a
	push af ; $6c4d
	ld a, $14 ; $6c4e
	farcall FarPtr_0a_04 ; $6c50
	pop af ; $6c53
	ld a, $10 ; $6c54
	ld b, $c0 ; $6c56
	farcall FarPtr_0a_2e ; $6c58
	ld a, $10 ; $6c5b
	ld d, $02 ; $6c5d
	farcall FarPtr_0a_34 ; $6c5f
	ld a, $10 ; $6c62
	farcall FarPtr_0a_36 ; $6c64
	ld a, $10 ; $6c67
	farcall FarPtr_0a_08 ; $6c69
	push af ; $6c6c
	ld a, $0a ; $6c6d
	farcall FarPtr_0a_04 ; $6c6f
	pop af ; $6c72
	ld a, $0e ; $6c73
	ld de, rLCDC ; $6c75
	farcall FarPtr_0a_42 ; $6c78
	push af ; $6c7b
	ld a, $28 ; $6c7c
	farcall FarPtr_0a_04 ; $6c7e
	pop af ; $6c81
	ld a, $0e ; $6c82
	ld b, $c0 ; $6c84
	farcall FarPtr_0a_2e ; $6c86
	ld a, $0e ; $6c89
	ld d, $02 ; $6c8b
	farcall FarPtr_0a_34 ; $6c8d
	ld a, $0e ; $6c90
	farcall FarPtr_0a_36 ; $6c92
	ld a, $0e ; $6c95
	farcall FarPtr_0a_08 ; $6c97
	push af ; $6c9a
	ld a, $14 ; $6c9b
	farcall FarPtr_0a_04 ; $6c9d
	pop af ; $6ca0
	sound $96 ; $6ca1
	ld a, $04 ; $6ca3
	ld bc, $0f00 ; $6ca5
	ld de, $0900 ; $6ca8
	farcall FarPtr_0a_22 ; $6cab
	push af ; $6cae
	ld a, $04 ; $6caf
	farcall FarPtr_0a_04 ; $6cb1
	pop af ; $6cb4
	sound $96 ; $6cb5
	ld a, $05 ; $6cb7
	ld bc, $1300 ; $6cb9
	ld de, $0700 ; $6cbc
	farcall FarPtr_0a_22 ; $6cbf
	push af ; $6cc2
	ld a, $04 ; $6cc3
	farcall FarPtr_0a_04 ; $6cc5
	pop af ; $6cc8
	sound $96 ; $6cc9
	ld a, $06 ; $6ccb
	ld bc, $1700 ; $6ccd
	ld de, $0900 ; $6cd0
	farcall FarPtr_0a_22 ; $6cd3
	push af ; $6cd6
	ld a, $28 ; $6cd7
	farcall FarPtr_0a_04 ; $6cd9
	pop af ; $6cdc
	ld a, $08 ; $6cdd
	ld b, $80 ; $6cdf
	farcall FarPtr_0a_2e ; $6ce1
	push af ; $6ce4
	ld a, $0a ; $6ce5
	farcall FarPtr_0a_04 ; $6ce7
	pop af ; $6cea
	ld a, $11 ; $6ceb
	ld b, $00 ; $6ced
	farcall FarPtr_0a_2e ; $6cef
	push af ; $6cf2
	ld a, $28 ; $6cf3
	farcall FarPtr_0a_04 ; $6cf5
	pop af ; $6cf8
	ld a, $08 ; $6cf9
	ld b, $00 ; $6cfb
	farcall FarPtr_0a_2e ; $6cfd
	push af ; $6d00
	ld a, $0a ; $6d01
	farcall FarPtr_0a_04 ; $6d03
	pop af ; $6d06
	ld a, $12 ; $6d07
	ld b, $80 ; $6d09
	farcall FarPtr_0a_2e ; $6d0b
	push af ; $6d0e
	ld a, $3c ; $6d0f
	farcall FarPtr_0a_04 ; $6d11
	pop af ; $6d14
	ld a, $0f ; $6d15
	ld bc, $0e00 ; $6d17
	ld de, $0f00 ; $6d1a
	farcall FarPtr_0a_24 ; $6d1d
	ld a, $0f ; $6d20
	farcall FarPtr_0a_20 ; $6d22
	ld a, $0f ; $6d25
	ld b, $c0 ; $6d27
	farcall FarPtr_0a_2e ; $6d29
	push af ; $6d2c
	ld a, $04 ; $6d2d
	farcall FarPtr_0a_04 ; $6d2f
	pop af ; $6d32
	ld a, $11 ; $6d33
	ld b, $40 ; $6d35
	farcall FarPtr_0a_2e ; $6d37
	push af ; $6d3a
	ld a, $04 ; $6d3b
	farcall FarPtr_0a_04 ; $6d3d
	pop af ; $6d40
	ld a, $08 ; $6d41
	ld b, $40 ; $6d43
	farcall FarPtr_0a_2e ; $6d45
	push af ; $6d48
	ld a, $04 ; $6d49
	farcall FarPtr_0a_04 ; $6d4b
	pop af ; $6d4e
	ld a, $12 ; $6d4f
	ld b, $40 ; $6d51
	farcall FarPtr_0a_2e ; $6d53
	push af ; $6d56
	ld a, $14 ; $6d57
	farcall FarPtr_0a_04 ; $6d59
	pop af ; $6d5c
	ld a, $04 ; $6d5d
	ld bc, $3f00 ; $6d5f
	ld de, $3f00 ; $6d62
	farcall FarPtr_0a_22 ; $6d65
	ld a, $05 ; $6d68
	ld bc, $3f00 ; $6d6a
	ld de, $3f00 ; $6d6d
	farcall FarPtr_0a_22 ; $6d70
	ld a, $06 ; $6d73
	ld bc, $3f00 ; $6d75
	ld de, $3f00 ; $6d78
	farcall FarPtr_0a_22 ; $6d7b
	ld a, $0f ; $6d7e
	farcall FarPtr_0a_08 ; $6d80
	push af ; $6d83
	ld a, $0a ; $6d84
	farcall FarPtr_0a_04 ; $6d86
	pop af ; $6d89
	ld a, $0f ; $6d8a
	ld d, $04 ; $6d8c
	farcall FarPtr_0a_34 ; $6d8e
	ld a, $0f ; $6d91
	farcall FarPtr_0a_36 ; $6d93
	ld a, $0f ; $6d96
	ld b, $00 ; $6d98
	farcall FarPtr_0a_2e ; $6d9a
	sound $99 ; $6d9d
	ld a, $07 ; $6d9f
	ld bc, $0f00 ; $6da1
	ld de, $0d00 ; $6da4
	farcall FarPtr_0a_22 ; $6da7
	push af ; $6daa
	ld a, $14 ; $6dab
	farcall FarPtr_0a_04 ; $6dad
	pop af ; $6db0
	ld a, $0f ; $6db1
	farcall FarPtr_0a_08 ; $6db3
	ret ; $6db6
Func_0e_6db7:
	ld a, $0b ; $6db7
	ld de, $ff80 ; $6db9
	farcall FarPtr_0a_42 ; $6dbc
	push af ; $6dbf
	ld a, $14 ; $6dc0
	farcall FarPtr_0a_04 ; $6dc2
	pop af ; $6dc5
	ld a, $0b ; $6dc6
	farcall FarPtr_0a_08 ; $6dc8
	ld a, $04 ; $6dcb
	ld bc, $3f00 ; $6dcd
	ld de, $3f00 ; $6dd0
	farcall FarPtr_0a_22 ; $6dd3
	ld a, $05 ; $6dd6
	ld bc, $3f00 ; $6dd8
	ld de, $3f00 ; $6ddb
	farcall FarPtr_0a_22 ; $6dde
	ld a, $06 ; $6de1
	ld bc, $3f00 ; $6de3
	ld de, $3f00 ; $6de6
	farcall FarPtr_0a_22 ; $6de9
	push af ; $6dec
	ld a, $0a ; $6ded
	farcall FarPtr_0a_04 ; $6def
	pop af ; $6df2
	ld a, $0f ; $6df3
	ld b, $00 ; $6df5
	farcall FarPtr_0a_2e ; $6df7
	push af ; $6dfa
	ld a, $04 ; $6dfb
	farcall FarPtr_0a_04 ; $6dfd
	pop af ; $6e00
	ld a, $10 ; $6e01
	ld b, $00 ; $6e03
	farcall FarPtr_0a_2e ; $6e05
	push af ; $6e08
	ld a, $04 ; $6e09
	farcall FarPtr_0a_04 ; $6e0b
	pop af ; $6e0e
	ld a, $0e ; $6e0f
	ld b, $00 ; $6e11
	farcall FarPtr_0a_2e ; $6e13
	push af ; $6e16
	ld a, $04 ; $6e17
	farcall FarPtr_0a_04 ; $6e19
	pop af ; $6e1c
	ld a, $08 ; $6e1d
	ld b, $00 ; $6e1f
	farcall FarPtr_0a_2e ; $6e21
	ld a, $0a ; $6e24
	ld b, $c0 ; $6e26
	farcall FarPtr_0a_2e ; $6e28
	push af ; $6e2b
	ld a, $04 ; $6e2c
	farcall FarPtr_0a_04 ; $6e2e
	pop af ; $6e31
	ld a, $11 ; $6e32
	ld b, $00 ; $6e34
	farcall FarPtr_0a_2e ; $6e36
	ld a, $09 ; $6e39
	ld b, $c0 ; $6e3b
	farcall FarPtr_0a_2e ; $6e3d
	ld a, $0b ; $6e40
	ld bc, $0020 ; $6e42
	farcall FarPtr_0a_18 ; $6e45
	ld a, $0b ; $6e48
	ld bc, $1600 ; $6e4a
	ld de, $0d00 ; $6e4d
	farcall FarPtr_0a_24 ; $6e50
	ld a, $0b ; $6e53
	farcall FarPtr_0a_20 ; $6e55
	push af ; $6e58
	ld a, $0a ; $6e59
	farcall FarPtr_0a_04 ; $6e5b
	pop af ; $6e5e
	ld a, $0b ; $6e5f
	farcall FarPtr_0a_08 ; $6e61
	push af ; $6e64
	ld a, $0a ; $6e65
	farcall FarPtr_0a_04 ; $6e67
	pop af ; $6e6a
	ld a, $0f ; $6e6b
	ld b, $00 ; $6e6d
	farcall FarPtr_0a_2e ; $6e6f
	sound $99 ; $6e72
	ld a, $07 ; $6e74
	ld bc, $1200 ; $6e76
	ld de, $0b00 ; $6e79
	farcall FarPtr_0a_22 ; $6e7c
	push af ; $6e7f
	ld a, $0a ; $6e80
	farcall FarPtr_0a_04 ; $6e82
	pop af ; $6e85
	ld a, $0f ; $6e86
	ld d, $02 ; $6e88
	farcall FarPtr_0a_34 ; $6e8a
	ld a, $0f ; $6e8d
	farcall FarPtr_0a_36 ; $6e8f
	push af ; $6e92
	ld a, $0a ; $6e93
	farcall FarPtr_0a_04 ; $6e95
	pop af ; $6e98
	ld a, $0f ; $6e99
	farcall FarPtr_0a_08 ; $6e9b
	ld a, $10 ; $6e9e
	ld b, $00 ; $6ea0
	farcall FarPtr_0a_2e ; $6ea2
	ld a, $0e ; $6ea5
	ld b, $00 ; $6ea7
	farcall FarPtr_0a_2e ; $6ea9
	ld a, $07 ; $6eac
	ld bc, $3f00 ; $6eae
	ld de, $3f00 ; $6eb1
	farcall FarPtr_0a_22 ; $6eb4
	ld a, $0f ; $6eb7
	ld bc, $1300 ; $6eb9
	ld de, $0d00 ; $6ebc
	farcall FarPtr_0a_24 ; $6ebf
	ld a, $0f ; $6ec2
	farcall FarPtr_0a_20 ; $6ec4
	push af ; $6ec7
	ld a, $0a ; $6ec8
	farcall FarPtr_0a_04 ; $6eca
	pop af ; $6ecd
	ld a, $0a ; $6ece
	ld b, $80 ; $6ed0
	farcall FarPtr_0a_2e ; $6ed2
	ld a, $10 ; $6ed5
	ld bc, $1100 ; $6ed7
	ld de, $0d00 ; $6eda
	farcall FarPtr_0a_24 ; $6edd
	push af ; $6ee0
	ld a, $0a ; $6ee1
	farcall FarPtr_0a_04 ; $6ee3
	pop af ; $6ee6
	ld a, $09 ; $6ee7
	ld b, $80 ; $6ee9
	farcall FarPtr_0a_2e ; $6eeb
	ld a, $0e ; $6eee
	ld bc, $1300 ; $6ef0
	ld de, $0f00 ; $6ef3
	farcall FarPtr_0a_24 ; $6ef6
	ld a, $0e ; $6ef9
	farcall FarPtr_0a_20 ; $6efb
	push af ; $6efe
	ld a, $0a ; $6eff
	farcall FarPtr_0a_04 ; $6f01
	pop af ; $6f04
	ld a, $0b ; $6f05
	ld b, $01 ; $6f07
	farcall FarPtr_0a_2c ; $6f09
	ld a, $0b ; $6f0c
	ld bc, $1800 ; $6f0e
	ld de, $0d00 ; $6f11
	farcall FarPtr_0a_24 ; $6f14
	ld a, $0b ; $6f17
	farcall FarPtr_0a_20 ; $6f19
	ld a, $0b ; $6f1c
	ld b, $80 ; $6f1e
	farcall FarPtr_0a_2e ; $6f20
	ld a, $0b ; $6f23
	ld b, $00 ; $6f25
	farcall FarPtr_0a_2c ; $6f27
	ret ; $6f2a
Func_0e_6f2b:
	ld a, $10 ; $6f2b
	ld b, $c0 ; $6f2d
	farcall FarPtr_0a_2e ; $6f2f
	push af ; $6f32
	ld a, $0a ; $6f33
	farcall FarPtr_0a_04 ; $6f35
	pop af ; $6f38
	ld a, $10 ; $6f39
	farcall FarPtr_0a_08 ; $6f3b
	push af ; $6f3e
	ld a, $0a ; $6f3f
	farcall FarPtr_0a_04 ; $6f41
	pop af ; $6f44
	ld a, $0f ; $6f45
	ld b, $40 ; $6f47
	farcall FarPtr_0a_2e ; $6f49
	push af ; $6f4c
	ld a, $0a ; $6f4d
	farcall FarPtr_0a_04 ; $6f4f
	pop af ; $6f52
	ld a, $0e ; $6f53
	ld b, $c0 ; $6f55
	farcall FarPtr_0a_2e ; $6f57
	push af ; $6f5a
	ld a, $28 ; $6f5b
	farcall FarPtr_0a_04 ; $6f5d
	pop af ; $6f60
	ld a, $0f ; $6f61
	ld d, $03 ; $6f63
	farcall FarPtr_0a_34 ; $6f65
	ld a, $0e ; $6f68
	ld d, $03 ; $6f6a
	farcall FarPtr_0a_34 ; $6f6c
	ld a, $0e ; $6f6f
	farcall FarPtr_0a_36 ; $6f71
	push af ; $6f74
	ld a, $0a ; $6f75
	farcall FarPtr_0a_04 ; $6f77
	pop af ; $6f7a
	ld a, $0f ; $6f7b
	ld b, $c0 ; $6f7d
	farcall FarPtr_0a_2e ; $6f7f
	push af ; $6f82
	ld a, $04 ; $6f83
	farcall FarPtr_0a_04 ; $6f85
	pop af ; $6f88
	ld a, $0e ; $6f89
	ld b, $c0 ; $6f8b
	farcall FarPtr_0a_2e ; $6f8d
	push af ; $6f90
	ld a, $0a ; $6f91
	farcall FarPtr_0a_04 ; $6f93
	pop af ; $6f96
	ld a, $0e ; $6f97
	ld de, rLCDC ; $6f99
	farcall FarPtr_0a_42 ; $6f9c
	push af ; $6f9f
	ld a, $28 ; $6fa0
	farcall FarPtr_0a_04 ; $6fa2
	pop af ; $6fa5
	ld a, $0e ; $6fa6
	farcall FarPtr_0a_08 ; $6fa8
	push af ; $6fab
	ld a, $0a ; $6fac
	farcall FarPtr_0a_04 ; $6fae
	pop af ; $6fb1
	sound $96 ; $6fb2
	ld a, $04 ; $6fb4
	ld bc, $1300 ; $6fb6
	ld de, $0900 ; $6fb9
	farcall FarPtr_0a_22 ; $6fbc
	ld a, $05 ; $6fbf
	ld bc, $1700 ; $6fc1
	ld de, $0900 ; $6fc4
	farcall FarPtr_0a_22 ; $6fc7
	push af ; $6fca
	ld a, $14 ; $6fcb
	farcall FarPtr_0a_04 ; $6fcd
	pop af ; $6fd0
	ld a, $08 ; $6fd1
	ld b, $00 ; $6fd3
	farcall FarPtr_0a_2e ; $6fd5
	push af ; $6fd8
	ld a, $0a ; $6fd9
	farcall FarPtr_0a_04 ; $6fdb
	pop af ; $6fde
	ld a, $12 ; $6fdf
	ld b, $80 ; $6fe1
	farcall FarPtr_0a_2e ; $6fe3
	push af ; $6fe6
	ld a, $14 ; $6fe7
	farcall FarPtr_0a_04 ; $6fe9
	pop af ; $6fec
	ld a, $04 ; $6fed
	ld bc, $3f00 ; $6fef
	ld de, $3f00 ; $6ff2
	farcall FarPtr_0a_22 ; $6ff5
	ld a, $05 ; $6ff8
	ld bc, $3f00 ; $6ffa
	ld de, $3f00 ; $6ffd
	farcall FarPtr_0a_22 ; $7000
	push af ; $7003
	ld a, $14 ; $7004
	farcall FarPtr_0a_04 ; $7006
	pop af ; $7009
	ld a, $08 ; $700a
	ld d, $03 ; $700c
	farcall FarPtr_0a_34 ; $700e
	ld a, $12 ; $7011
	ld d, $03 ; $7013
	farcall FarPtr_0a_34 ; $7015
	ld a, $12 ; $7018
	farcall FarPtr_0a_36 ; $701a
	push af ; $701d
	ld a, $0a ; $701e
	farcall FarPtr_0a_04 ; $7020
	pop af ; $7023
	ld a, $08 ; $7024
	ld b, $40 ; $7026
	farcall FarPtr_0a_2e ; $7028
	push af ; $702b
	ld a, $0a ; $702c
	farcall FarPtr_0a_04 ; $702e
	pop af ; $7031
	ld a, $12 ; $7032
	ld b, $40 ; $7034
	farcall FarPtr_0a_2e ; $7036
	ld a, $08 ; $7039
	farcall FarPtr_0a_08 ; $703b
	push af ; $703e
	ld a, $14 ; $703f
	farcall FarPtr_0a_04 ; $7041
	pop af ; $7044
	ld a, $0f ; $7045
	ld d, $03 ; $7047
	farcall FarPtr_0a_34 ; $7049
	ld a, $10 ; $704c
	ld d, $03 ; $704e
	farcall FarPtr_0a_34 ; $7050
	ld a, $0e ; $7053
	ld d, $03 ; $7055
	farcall FarPtr_0a_34 ; $7057
	ld a, $0e ; $705a
	farcall FarPtr_0a_36 ; $705c
	push af ; $705f
	ld a, $14 ; $7060
	farcall FarPtr_0a_04 ; $7062
	pop af ; $7065
	ld a, $10 ; $7066
	ld de, $ff80 ; $7068
	farcall FarPtr_0a_42 ; $706b
	push af ; $706e
	ld a, $28 ; $706f
	farcall FarPtr_0a_04 ; $7071
	pop af ; $7074
	ld a, $10 ; $7075
	farcall FarPtr_0a_08 ; $7077
	push af ; $707a
	ld a, $0a ; $707b
	farcall FarPtr_0a_04 ; $707d
	pop af ; $7080
	ret ; $7081
Func_0e_7082:
	push af ; $7082
	ld a, $0a ; $7083
	farcall FarPtr_0a_04 ; $7085
	pop af ; $7088
	sound $99 ; $7089
	ld a, $07 ; $708b
	ld bc, $1400 ; $708d
	ld de, $0d00 ; $7090
	farcall FarPtr_0a_22 ; $7093
	push af ; $7096
	ld a, $28 ; $7097
	farcall FarPtr_0a_04 ; $7099
	pop af ; $709c
	ld a, $0f ; $709d
	farcall FarPtr_0a_08 ; $709f
	push af ; $70a2
	ld a, $14 ; $70a3
	farcall FarPtr_0a_04 ; $70a5
	pop af ; $70a8
	ld a, $07 ; $70a9
	ld bc, $3f00 ; $70ab
	ld de, $3f00 ; $70ae
	farcall FarPtr_0a_22 ; $70b1
	ld a, $08 ; $70b4
	ld d, $02 ; $70b6
	farcall FarPtr_0a_34 ; $70b8
	ld a, $08 ; $70bb
	farcall FarPtr_0a_36 ; $70bd
	ld a, $08 ; $70c0
	farcall FarPtr_0a_08 ; $70c2
	push af ; $70c5
	ld a, $0a ; $70c6
	farcall FarPtr_0a_04 ; $70c8
	pop af ; $70cb
	ld a, $08 ; $70cc
	ld d, $03 ; $70ce
	farcall FarPtr_0a_34 ; $70d0
	ld a, $08 ; $70d3
	farcall FarPtr_0a_36 ; $70d5
	push af ; $70d8
	ld a, $0a ; $70d9
	farcall FarPtr_0a_04 ; $70db
	pop af ; $70de
	ld a, $08 ; $70df
	farcall FarPtr_0a_08 ; $70e1
	ld a, $0f ; $70e4
	ld de, $ff80 ; $70e6
	farcall FarPtr_0a_42 ; $70e9
	push af ; $70ec
	ld a, $14 ; $70ed
	farcall FarPtr_0a_04 ; $70ef
	pop af ; $70f2
	sound $70 ; $70f3
	ld a, $04 ; $70f5
	farcall FarPtr_0a_40 ; $70f7
	push af ; $70fa
	ld a, $0a ; $70fb
	farcall FarPtr_0a_04 ; $70fd
	pop af ; $7100
	ld a, $00 ; $7101
	farcall FarPtr_0a_40 ; $7103
	push af ; $7106
	ld a, $1e ; $7107
	farcall FarPtr_0a_04 ; $7109
	pop af ; $710c
	ld a, $10 ; $710d
	ld bc, $0c00 ; $710f
	ld de, $0d00 ; $7112
	farcall FarPtr_0a_24 ; $7115
	ld a, $0e ; $7118
	ld bc, $0c00 ; $711a
	ld de, $1100 ; $711d
	farcall FarPtr_0a_24 ; $7120
	push af ; $7123
	ld a, $14 ; $7124
	farcall FarPtr_0a_04 ; $7126
	pop af ; $7129
	ld a, $0f ; $712a
	ld bc, $0c00 ; $712c
	ld de, $0f00 ; $712f
	farcall FarPtr_0a_24 ; $7132
	ld a, $0f ; $7135
	farcall FarPtr_0a_20 ; $7137
	ld a, $10 ; $713a
	ld b, $00 ; $713c
	farcall FarPtr_0a_2e ; $713e
	ld a, $0e ; $7141
	ld b, $00 ; $7143
	farcall FarPtr_0a_2e ; $7145
	ld a, $0f ; $7148
	ld b, $00 ; $714a
	farcall FarPtr_0a_2e ; $714c
	ret ; $714f
Func_0e_7150:
	ldh a, [$ff96] ; $7150
	push af ; $7152
	ld hl, $72ce ; $7153
	ld de, $0901 ; $7156
	call Func_00_05b0 ; $7159
	ld hl, $72e0 ; $715c
	ld de, $a000 ; $715f
	ld c, $18 ; $7162
	call Func_00_0480 ; $7164
	ld hl, $7460 ; $7167
	ld de, $a180 ; $716a
	ld c, $02 ; $716d
	call Func_00_0480 ; $716f
	ld a, $06 ; $7172
	ldh [$ff96], a ; $7174
	ldh [rWBK], a ; $7176
	xor a, a ; $7178
	ld hl, $d000 ; $7179
	ld [hl+], a ; $717c
	ld [hl+], a ; $717d
	ld a, $5a ; $717e
	ld [hl+], a ; $7180
	xor a, a ; $7181
	ld [hl+], a ; $7182
	ld [hl+], a ; $7183
	ld [hl+], a ; $7184
	ld [hl+], a ; $7185
	ld [hl+], a ; $7186
	ld [hl+], a ; $7187
	ld [hl+], a ; $7188
	ld [hl+], a ; $7189
	ld [hl+], a ; $718a
	ld [hl+], a ; $718b
	ld [hl+], a ; $718c
	ld [hl+], a ; $718d
	ld [hl+], a ; $718e
	ld [hl+], a ; $718f
	ld [hl+], a ; $7190
	ld [hl+], a ; $7191
	ld b, $00 ; $7192
	ld c, $2b ; $7194
	ld d, $1a ; $7196
	ld e, $0c ; $7198
	ld h, $04 ; $719a
	ld l, $02 ; $719c
	farcall FarPtr_0a_7e ; $719e
	ld b, $04 ; $71a1
	ld c, $2d ; $71a3
	ld d, $14 ; $71a5
	ld e, $14 ; $71a7
	ld h, $06 ; $71a9
	ld l, $02 ; $71ab
	farcall FarPtr_0a_7e ; $71ad
	ld b, $0a ; $71b0
	ld c, $2b ; $71b2
	ld d, $1a ; $71b4
	ld e, $12 ; $71b6
	ld h, $06 ; $71b8
	ld l, $02 ; $71ba
	farcall FarPtr_0a_7e ; $71bc
	sound $09 ; $71bf
	ld a, $01 ; $71c1
	ld hl, $71e9 ; $71c3
	call Func_00_1b6a ; $71c6
	ld a, $06 ; $71c9
	ldh [$ff96], a ; $71cb
	ldh [rWBK], a ; $71cd
Label_0e_71cf:
	call Func_00_2631 ; $71cf
	ld a, [$d002] ; $71d2
	cp a, $1e ; $71d5
	jr z, Label_0e_71e2 ; $71d7
	or a, a ; $71d9
	jr nz, Label_0e_71cf ; $71da
	pop af ; $71dc
	ldh [$ff96], a ; $71dd
	ldh [rWBK], a ; $71df
	ret ; $71e1
Label_0e_71e2:
	ld c, $03 ; $71e2
	call Func_00_1d20 ; $71e4
	jr Label_0e_71cf ; $71e7
	INCBIN "data/bank_00e/d_71e9.bin" ; $71e9, 1762 bytes
	farcall FarPtr_0a_18 ; $78cb
	ld a, $00 ; $78ce
	ld bc, $0f00 ; $78d0
	ld de, $1d00 ; $78d3
	farcall FarPtr_0a_24 ; $78d6
	ld a, $0d ; $78d9
	ld bc, $0900 ; $78db
	ld de, $1700 ; $78de
	farcall FarPtr_0a_24 ; $78e1
	ld a, $0d ; $78e4
	farcall FarPtr_0a_20 ; $78e6
	ld a, $0d ; $78e9
	ld bc, $0900 ; $78eb
	ld de, $0d00 ; $78ee
	farcall FarPtr_0a_24 ; $78f1
	ld a, $00 ; $78f4
	farcall FarPtr_0a_20 ; $78f6
	ld a, $00 ; $78f9
	ld b, $c0 ; $78fb
	farcall FarPtr_0a_2e ; $78fd
	ld a, $0d ; $7900
	farcall FarPtr_0a_20 ; $7902
	ld a, $0d ; $7905
	ld bc, $0d00 ; $7907
	ld de, $0d00 ; $790a
	farcall FarPtr_0a_24 ; $790d
	ld a, $0d ; $7910
	farcall FarPtr_0a_20 ; $7912
	ld a, $0d ; $7915
	ld b, $40 ; $7917
	farcall FarPtr_0a_2e ; $7919
	push af ; $791c
	ld a, $28 ; $791d
	farcall FarPtr_0a_04 ; $791f
	pop af ; $7922
	call Func_0e_7b7f ; $7923
	ret ; $7926
	INCBIN "data/bank_00e/d_7927.bin" ; $7927, 132 bytes
	farcall FarPtr_0a_20 ; $79ab
	ldh a, [$ff95] ; $79ae
	ld b, a ; $79b0
	ld a, $0e ; $79b1
	ld de, $7b11 ; $79b3
	farcall FarPtr_0a_1a ; $79b6
	ld a, $00 ; $79b9
	ld bc, $0500 ; $79bb
	ld de, $1f00 ; $79be
	farcall FarPtr_0a_24 ; $79c1
	ld a, $02 ; $79c4
	ld bc, $0500 ; $79c6
	ld de, $2100 ; $79c9
	farcall FarPtr_0a_24 ; $79cc
	ld a, $00 ; $79cf
	farcall FarPtr_0a_20 ; $79d1
	ldh a, [$ff95] ; $79d4
	ld b, a ; $79d6
	ld a, $00 ; $79d7
	ld de, $7b11 ; $79d9
	farcall FarPtr_0a_1a ; $79dc
	ld a, $02 ; $79df
	ld bc, $0500 ; $79e1
	ld de, $1f00 ; $79e4
	farcall FarPtr_0a_24 ; $79e7
	ld a, $02 ; $79ea
	farcall FarPtr_0a_20 ; $79ec
	ldh a, [$ff95] ; $79ef
	ld b, a ; $79f1
	ld a, $02 ; $79f2
	ld de, $7b11 ; $79f4
	farcall FarPtr_0a_1a ; $79f7
	push af ; $79fa
	ld a, $5a ; $79fb
	farcall FarPtr_0a_04 ; $79fd
	pop af ; $7a00
	xor a, a ; $7a01
	ld bc, $0e00 ; $7a02
	ld de, $1700 ; $7a05
	farcall FarPtr_0a_3a ; $7a08
	ld a, $0e ; $7a0b
	farcall FarPtr_0a_1e ; $7a0d
	ld a, $0e ; $7a10
	ld bc, $0020 ; $7a12
	farcall FarPtr_0a_18 ; $7a15
	ldh a, [$ff95] ; $7a18
	ld b, a ; $7a1a
	ld a, $0e ; $7a1b
	ld de, $7b24 ; $7a1d
	farcall FarPtr_0a_1a ; $7a20
	ldh a, [$ff95] ; $7a23
	ld b, a ; $7a25
	ld a, $02 ; $7a26
	ld de, $7c6e ; $7a28
	farcall FarPtr_0a_1a ; $7a2b
	ld a, $02 ; $7a2e
	ld bc, $0f00 ; $7a30
	ld de, $1b00 ; $7a33
	farcall FarPtr_0a_24 ; $7a36
	ld a, $0e ; $7a39
	farcall FarPtr_0a_1e ; $7a3b
	push af ; $7a3e
	ld a, $3c ; $7a3f
	farcall FarPtr_0a_04 ; $7a41
	pop af ; $7a44
	ld a, $03 ; $7a45
	ld d, $03 ; $7a47
	farcall FarPtr_0a_34 ; $7a49
	ld a, $03 ; $7a4c
	farcall FarPtr_0a_36 ; $7a4e
	push af ; $7a51
	ld a, $14 ; $7a52
	farcall FarPtr_0a_04 ; $7a54
	pop af ; $7a57
	rst30 $0dc0 ; $7a58
	jr z, Label_0e_7a66 ; $7a5b
	ld a, $01 ; $7a5d
	ld [$c294], a ; $7a5f
	ld [$c2a1], a ; $7a62
	ret ; $7a65
Label_0e_7a66:
	ld hl, $30aa ; $7a66
	farcall FarPtr_0a_0e ; $7a69
	ld a, $03 ; $7a6c
	farcall FarPtr_0a_08 ; $7a6e
	push af ; $7a71
	ld a, $14 ; $7a72
	farcall FarPtr_0a_04 ; $7a74
	pop af ; $7a77
	ld a, $0d ; $7a78
	ld d, $03 ; $7a7a
	farcall FarPtr_0a_34 ; $7a7c
	ld a, $03 ; $7a7f
	ld d, $03 ; $7a81
	farcall FarPtr_0a_34 ; $7a83
	ld a, $02 ; $7a86
	ld d, $03 ; $7a88
	farcall FarPtr_0a_34 ; $7a8a
	ld a, $00 ; $7a8d
	ld d, $03 ; $7a8f
	farcall FarPtr_0a_34 ; $7a91
	ld a, $00 ; $7a94
	farcall FarPtr_0a_36 ; $7a96
	push af ; $7a99
	ld a, $14 ; $7a9a
	farcall FarPtr_0a_04 ; $7a9c
	pop af ; $7a9f
	ld bc, $0020 ; $7aa0
	farcall FarPtr_0a_38 ; $7aa3
	xor a, a ; $7aa6
	ld bc, $0e00 ; $7aa7
	ld de, $1400 ; $7aaa
	farcall FarPtr_0a_3a ; $7aad
	ld a, $00 ; $7ab0
	ld bc, $0020 ; $7ab2
	farcall FarPtr_0a_18 ; $7ab5
	ld a, $02 ; $7ab8
	ld bc, $0020 ; $7aba
	farcall FarPtr_0a_18 ; $7abd
	ld a, $0d ; $7ac0
	ld bc, $0020 ; $7ac2
	farcall FarPtr_0a_18 ; $7ac5
	ld a, $03 ; $7ac8
	ld bc, $0020 ; $7aca
	farcall FarPtr_0a_18 ; $7acd
	ldh a, [$ff95] ; $7ad0
	ld b, a ; $7ad2
	ld a, $0d ; $7ad3
	ld de, $7b2f ; $7ad5
	farcall FarPtr_0a_1a ; $7ad8
	ldh a, [$ff95] ; $7adb
	ld b, a ; $7add
	ld a, $03 ; $7ade
	ld de, $7b46 ; $7ae0
	farcall FarPtr_0a_1a ; $7ae3
	ldh a, [$ff95] ; $7ae6
	ld b, a ; $7ae8
	ld a, $00 ; $7ae9
	ld de, $7b5d ; $7aeb
	farcall FarPtr_0a_1a ; $7aee
	ldh a, [$ff95] ; $7af1
	ld b, a ; $7af3
	ld a, $02 ; $7af4
	ld de, $7b6e ; $7af6
	farcall FarPtr_0a_1a ; $7af9
	ld a, $0d ; $7afc
	farcall FarPtr_0a_1e ; $7afe
	ld a, $03 ; $7b01
	farcall FarPtr_0a_1e ; $7b03
	push af ; $7b06
	ld a, $3c ; $7b07
	farcall FarPtr_0a_04 ; $7b09
	pop af ; $7b0c
	call Func_0e_7b7f ; $7b0d
	ret ; $7b10
	INCBIN "data/bank_00e/d_7b11.bin" ; $7b11, 110 bytes
Func_0e_7b7f:
	ld a, $1c ; $7b7f
	ld [wStoryModeCurrentLocation], a ; $7b81
	ld a, $0a ; $7b84
	ld [$c295], a ; $7b86
	ld a, $ff ; $7b89
	ld [$c294], a ; $7b8b
	ld [$c2a1], a ; $7b8e
	farcall FarPtr_0a_4a ; $7b91
	ld a, [wWaterSpriteMinigameTimer] ; $7b94
	add a, a ; $7b97
	add a, $ac ; $7b98
	ld l, a ; $7b9a
	adc a, $7b ; $7b9b
	sub a, l ; $7b9d
	ld h, a ; $7b9e
	ld a, [hl+] ; $7b9f
	ld h, [hl] ; $7ba0
	ld l, a ; $7ba1
	call JumpToHL ; $7ba2
	farcall FarPtr_0a_4c ; $7ba5
	farcall FarPtr_0a_4e ; $7ba8
	ret ; $7bab
	INCBIN "data/bank_00e/d_7bac.bin" ; $7bac, 686 bytes
Func_0e_7e5a:
	rst30 $05e0 ; $7e5a
	jr nz, Label_0e_7e81 ; $7e5d
	ld a, $00 ; $7e5f
	rst30 $0a60 ; $7e61
	jr z, Label_0e_7e7d ; $7e64
	ld a, $02 ; $7e66
	rst30 $0ae0 ; $7e68
	jr z, Label_0e_7e7d ; $7e6b
	ld a, $04 ; $7e6d
	rst30 $15c0 ; $7e6f
	jr z, Label_0e_7e7d ; $7e72
	ld a, $06 ; $7e74
	rst30 $1600 ; $7e76
	jr z, Label_0e_7e7d ; $7e79
	ld a, $08 ; $7e7b
Label_0e_7e7d:
	ld [$c2b0], a ; $7e7d
	ret ; $7e80
Label_0e_7e81:
	ld a, $01 ; $7e81
	rst30 $0840 ; $7e83
	jr z, Label_0e_7e7d ; $7e86
	ld a, $03 ; $7e88
	rst30 $08c0 ; $7e8a
	jr z, Label_0e_7e7d ; $7e8d
	ld a, $05 ; $7e8f
	rst30 $15e0 ; $7e91
	jr z, Label_0e_7e7d ; $7e94
	ld a, $07 ; $7e96
	rst30 $1620 ; $7e98
	jr z, Label_0e_7e7d ; $7e9b
	ld a, $09 ; $7e9d
	jr Label_0e_7e7d ; $7e9f
	INCBIN "data/bank_00e/d_7ea1.bin" ; $7ea1, 351 bytes
