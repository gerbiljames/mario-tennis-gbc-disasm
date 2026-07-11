INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $0d", ROMX[$4000], BANK[$0d]

FarPtr_0d_00:
	dw Func_0d_407f ; $4000
FarPtr_0d_02:
	dw Func_0d_41a6 ; $4002
FarPtr_0d_04:
	dw Func_0d_4412 ; $4004
Func_0d_4006:
	ld hl, $0000 ; $4006
	add hl, bc ; $4009
	ld a, [hl] ; $400a
	ld [$c3b1], a ; $400b
	ld hl, $0001 ; $400e
	add hl, bc ; $4011
	ld a, [hl] ; $4012
	ld [wCurrentlyUsedCourt], a ; $4013
	ld hl, $0002 ; $4016
	add hl, bc ; $4019
	ld a, [hl] ; $401a
	ld [wOnCourtCharCount], a ; $401b
	ld hl, $0003 ; $401e
	add hl, bc ; $4021
	ld a, [hl] ; $4022
	ld [wGameMode], a ; $4023
	ld a, $02 ; $4026
	ld [wCurrentMinigameStoryMatch], a ; $4028
	ld hl, $0004 ; $402b
	add hl, bc ; $402e
	ld a, [hl] ; $402f
	ld [$c8f7], a ; $4030
	ld hl, $0005 ; $4033
	add hl, bc ; $4036
	ld a, [hl] ; $4037
	ld [$c8f8], a ; $4038
	push bc ; $403b
	ld hl, $0007 ; $403c
	add hl, bc ; $403f
	ld b, [hl] ; $4040
	ld c, $00 ; $4041
	farcall FarPtr_02_18 ; $4043
	ld a, [wStoryModeMainCharacterOverworldSprite] ; $4046
	ld [$c3b0], a ; $4049
	ld a, [$c3b1] ; $404c
	cp a, $ff ; $404f
	jr z, Label_0d_4059 ; $4051
	ld b, a ; $4053
	ld c, $02 ; $4054
	farcall FarPtr_02_18 ; $4056
Label_0d_4059:
	pop bc ; $4059
	ld hl, $0008 ; $405a
	add hl, bc ; $405d
	ld a, [hl+] ; $405e
	ld d, [hl] ; $405f
	ld e, a ; $4060
	ldh a, [$ff95] ; $4061
	farcall FarPtr_08_48 ; $4063
	ld hl, $000a ; $4066
	add hl, bc ; $4069
	ld a, [hl+] ; $406a
	ld d, [hl] ; $406b
	ld e, a ; $406c
	farcall FarPtr_08_4a ; $406d
	ld hl, $000c ; $4070
	add hl, bc ; $4073
	ld a, [hl+] ; $4074
	ld h, [hl] ; $4075
	ld l, a ; $4076
	ld a, h ; $4077
	or a, l ; $4078
	jr z, Label_0d_407e ; $4079
	call JumpToHL ; $407b
Label_0d_407e:
	ret ; $407e
Func_0d_407f:
	sub a, $12 ; $407f
	ld l, a ; $4081
	ld h, $00 ; $4082
	add hl, hl ; $4084
	ld de, $4090 ; $4085
	add hl, de ; $4088
	ld a, [hl+] ; $4089
	ld b, [hl] ; $408a
	ld c, a ; $408b
	call Func_0d_4006 ; $408c
	ret ; $408f
	INCBIN "data/bank_00d/d_4090.bin" ; $4090, 63 bytes
Func_0d_40cf:
	xor a, a ; $40cf
	ld hl, wMinigamesCurrentScore ; $40d0
	ld [hl+], a ; $40d3
	ld [hl+], a ; $40d4
	ld hl, $c780 ; $40d5
	ld [hl+], a ; $40d8
	ld [hl+], a ; $40d9
	ld a, [wMinigameLevel] ; $40da
	ld b, a ; $40dd
	ld a, [$c8f7] ; $40de
	call Func_0d_4121 ; $40e1
	ld hl, wMinigamesTargetScore ; $40e4
	ld a, e ; $40e7
	ld [hl+], a ; $40e8
	ld [hl], d ; $40e9
	ld a, [$c8f7] ; $40ea
	sub a, $1a ; $40ed
	ret c ; $40ef
	add a, $16 ; $40f0
	ld l, a ; $40f2
	adc a, $41 ; $40f3
	sub a, l ; $40f5
	ld h, a ; $40f6
	ld a, [hl] ; $40f7
	farcall FarPtr_03_2c ; $40f8
	ldh a, [hWramBank] ; $40fb
	push af ; $40fd
	wram_bank $07 ; $40fe
	ld hl, $de00 ; $4104
	ld de, $c4ec ; $4107
	ld a, [hl+] ; $410a
	ld [de], a ; $410b
	inc de ; $410c
	ld a, [hl+] ; $410d
	ld [de], a ; $410e
	inc de ; $410f
	pop af ; $4110
	wram_bank ; $4111
	ret ; $4115
	INCBIN "data/bank_00d/d_4116.bin" ; $4116, 11 bytes
Func_0d_4121:
	ld de, $0000 ; $4121
	cp a, $12 ; $4124
	ret c ; $4126
	cp a, $1c ; $4127
	jr nc, Label_0d_4139 ; $4129
	sub a, $12 ; $412b
	add a, a ; $412d
	add a, $4a ; $412e
	ld l, a ; $4130
	adc a, $41 ; $4131
	sub a, l ; $4133
	ld h, a ; $4134
	ld a, [hl+] ; $4135
	ld d, [hl] ; $4136
	ld e, a ; $4137
	ret ; $4138
Label_0d_4139:
	sub a, $1c ; $4139
	add a, a ; $413b
	add a, a ; $413c
	add a, b ; $413d
	add a, a ; $413e
	add a, $5e ; $413f
	ld l, a ; $4141
	adc a, $41 ; $4142
	sub a, l ; $4144
	ld h, a ; $4145
	ld a, [hl+] ; $4146
	ld d, [hl] ; $4147
	ld e, a ; $4148
	ret ; $4149
	INCBIN "data/bank_00d/d_414a.bin" ; $414a, 92 bytes
Func_0d_41a6:
	add a, a ; $41a6
	add a, $b5 ; $41a7
	ld l, a ; $41a9
	adc a, $41 ; $41aa
	sub a, l ; $41ac
	ld h, a ; $41ad
	ld a, [hl+] ; $41ae
	ld h, [hl] ; $41af
	ld l, a ; $41b0
	ld a, [hl+] ; $41b1
	ld d, [hl] ; $41b2
	ld e, a ; $41b3
	ret ; $41b4
	INCBIN "data/bank_00d/d_41b5.bin" ; $41b5, 22 bytes
Func_0d_41cb:
	ld hl, $c789 ; $41cb
	ld a, [hl] ; $41ce
	cp a, b ; $41cf
	ret nc ; $41d0
	inc [hl] ; $41d1
	ret ; $41d2
Func_0d_41d3:
	ld hl, wMinigamesTargetScore ; $41d3
	ld a, [hl+] ; $41d6
	ld d, [hl] ; $41d7
	ld e, a ; $41d8
	ld hl, wMinigamesCurrentScore ; $41d9
	ld a, [hl+] ; $41dc
	ld h, [hl] ; $41dd
	ld l, a ; $41de
	ld a, l ; $41df
	sub a, e ; $41e0
	ld l, a ; $41e1
	ld a, h ; $41e2
	sbc a, d ; $41e3
	ld h, a ; $41e4
	bit 7, h ; $41e5
	jr nz, Label_0d_41ec ; $41e7
	ld a, $01 ; $41e9
	ret ; $41eb
Label_0d_41ec:
	xor a, a ; $41ec
	ret ; $41ed
Func_0d_41ee:
	ld hl, wMinigamesCurrentScore ; $41ee
	ld a, [hl+] ; $41f1
	ld d, [hl] ; $41f2
	ld e, a ; $41f3
	ld hl, $d8f1 ; $41f4
	add hl, de ; $41f7
	ld a, h ; $41f8
	or a, l ; $41f9
	jr z, Label_0d_420e ; $41fa
	ld hl, $c4ec ; $41fc
	ld a, [hl+] ; $41ff
	ld h, [hl] ; $4200
	ld l, a ; $4201
	ld a, l ; $4202
	sub a, e ; $4203
	ld l, a ; $4204
	ld a, h ; $4205
	sbc a, d ; $4206
	ld h, a ; $4207
	bit 7, h ; $4208
	jr nz, Label_0d_420e ; $420a
	xor a, a ; $420c
	ret ; $420d
Label_0d_420e:
	ld a, $01 ; $420e
	ret ; $4210
Func_0d_4211:
	ldh a, [hWramBank] ; $4211
	push af ; $4213
	wram_bank $04 ; $4214
	ld hl, $dd1e ; $421a
	ld de, $c7a0 ; $421d
	ld a, [hl+] ; $4220
	ld [de], a ; $4221
	inc de ; $4222
	ld a, [hl+] ; $4223
	ld [de], a ; $4224
	inc de ; $4225
	ld a, [hl+] ; $4226
	ld [de], a ; $4227
	inc de ; $4228
	ld a, [hl+] ; $4229
	ld [de], a ; $422a
	inc de ; $422b
	pop af ; $422c
	wram_bank ; $422d
	ld a, $10 ; $4231
	ld [$c787], a ; $4233
	ret ; $4236
Func_0d_4237:
	ld a, [$c787] ; $4237
	and a, a ; $423a
	ret z ; $423b
	ld hl, $c787 ; $423c
	call TickTimer ; $423f
	ld hl, $c7a2 ; $4242
	ld a, [hl+] ; $4245
	ld b, [hl] ; $4246
	ld c, a ; $4247
	ld hl, $c7a0 ; $4248
	ld a, [hl+] ; $424b
	ld h, [hl] ; $424c
	ld l, a ; $424d
	farcall FarPtr_08_46 ; $424e
	ld a, [$c787] ; $4251
	add a, e ; $4254
	add a, $e8 ; $4255
	ld e, a ; $4257
	ld hl, $c782 ; $4258
	ld a, [hl+] ; $425b
	ld h, [hl] ; $425c
	ld l, a ; $425d
	ld b, $01 ; $425e
	ld a, $01 ; $4260
	farcall FarPtr_0a_9c ; $4262
	ret ; $4265
Func_0d_4266:
	ld hl, wMinigamesCurrentScore ; $4266
	ld a, [hl+] ; $4269
	ld h, [hl] ; $426a
	ld l, a ; $426b
	add hl, de ; $426c
	ld e, l ; $426d
	ld d, h ; $426e
	ld hl, $d8f1 ; $426f
	add hl, de ; $4272
	jr nc, Label_0d_4278 ; $4273
	ld de, $270f ; $4275
Label_0d_4278:
	ld hl, wMinigamesCurrentScore ; $4278
	ld a, e ; $427b
	ld [hl+], a ; $427c
	ld [hl], d ; $427d
	ret ; $427e
	INCBIN "data/bank_00d/d_427f.bin" ; $427f, 315 bytes
Func_0d_43ba:
	ld a, [wPointOutcome] ; $43ba
	cp a, $06 ; $43bd
	jr z, Label_0d_43de ; $43bf
	cp a, $09 ; $43c1
	jr z, Label_0d_43de ; $43c3
	cp a, $0b ; $43c5
	jr z, Label_0d_43de ; $43c7
	ld a, [wPointOutcome] ; $43c9
	add a, $00 ; $43cc
	farcall FarPtr_09_12 ; $43ce
	ld a, $1e ; $43d1
	farcall FarPtr_08_40 ; $43d3
	farcall FarPtr_09_16 ; $43d6
	ld a, $0a ; $43d9
	farcall FarPtr_08_40 ; $43db
Label_0d_43de:
	ret ; $43de
Func_0d_43df:
	ld a, [$c7bc] ; $43df
	and a, a ; $43e2
	jr nz, Label_0d_43ee ; $43e3
	ld a, [wPointOutcome] ; $43e5
	cp a, $0b ; $43e8
	jr z, Label_0d_43f6 ; $43ea
	jr Label_0d_440a ; $43ec
Label_0d_43ee:
	call Func_0d_41ee ; $43ee
	and a, a ; $43f1
	jr nz, Label_0d_4402 ; $43f2
	jr Label_0d_440a ; $43f4
Label_0d_43f6:
	ld a, $01 ; $43f6
	ld [wPointWinLoseFlag], a ; $43f8
	ld a, [wMinigameLevel] ; $43fb
	add a, $12 ; $43fe
	ld d, a ; $4400
	ret ; $4401
Label_0d_4402:
	ld a, $01 ; $4402
	ld [wPointWinLoseFlag], a ; $4404
	ld d, $16 ; $4407
	ret ; $4409
Label_0d_440a:
	ld a, $ff ; $440a
	ld [wPointWinLoseFlag], a ; $440c
	ld d, $17 ; $440f
	ret ; $4411
Func_0d_4412:
	ld a, [wPointWinLoseFlag] ; $4412
	add a, a ; $4415
	jr c, Label_0d_441c ; $4416
	sound $09 ; $4418
	jr Label_0d_441e ; $441a
Label_0d_441c:
	sound $0a ; $441c
Label_0d_441e:
	farcall FarPtr_08_3e ; $441e
	ld a, d ; $4421
	farcall FarPtr_09_12 ; $4422
	ld a, $0a ; $4425
	farcall FarPtr_08_40 ; $4427
	ld a, $2d ; $442a
	farcall FarPtr_08_42 ; $442c
	farcall FarPtr_08_6a ; $442f
	farcall FarPtr_09_16 ; $4432
	ld a, $0f ; $4435
	farcall FarPtr_08_40 ; $4437
	ld a, $80 ; $443a
	ld [$c4c3], a ; $443c
	ret ; $443f
Func_0d_4440:
	wram_bank $04 ; $4440
	ld hl, $dc00 ; $4446
	ld c, $07 ; $4449
	call ClearMemory16 ; $444b
	ret ; $444e
Func_0d_444f:
	wram_bank $04 ; $444f
	ld hl, $000e ; $4455
	add hl, bc ; $4458
	ld a, e ; $4459
	ld [hl+], a ; $445a
	ld [hl], d ; $445b
	ld hl, $0000 ; $445c
	add hl, bc ; $445f
	set 0, [hl] ; $4460
	set 1, [hl] ; $4462
	ret ; $4464
Func_0d_4465:
	wram_bank $04 ; $4465
	push de ; $446b
	push hl ; $446c
	push hl ; $446d
	ld hl, $0008 ; $446e
	add hl, bc ; $4471
	ld a, e ; $4472
	ld [hl+], a ; $4473
	ld [hl], d ; $4474
	pop de ; $4475
	ld hl, $0006 ; $4476
	add hl, bc ; $4479
	ld a, e ; $447a
	ld [hl+], a ; $447b
	ld [hl], d ; $447c
	pop hl ; $447d
	pop de ; $447e
	push bc ; $447f
	ld bc, $0000 ; $4480
	farcall FarPtr_08_44 ; $4483
	ld e, c ; $4486
	ld d, b ; $4487
	pop bc ; $4488
	push hl ; $4489
	ld hl, $000c ; $448a
	add hl, bc ; $448d
	ld a, e ; $448e
	ld [hl+], a ; $448f
	ld [hl], d ; $4490
	pop de ; $4491
	ld hl, $000a ; $4492
	add hl, bc ; $4495
	ld a, e ; $4496
	ld [hl+], a ; $4497
	ld [hl], d ; $4498
	ret ; $4499
Func_0d_449a:
	ld c, l ; $449a
	ld b, h ; $449b
	ld hl, $dc76 ; $449c
	ld a, c ; $449f
	ld [hl+], a ; $44a0
	ld a, b ; $44a1
	ld [hl+], a ; $44a2
	ld a, e ; $44a3
	ld [hl+], a ; $44a4
	ld a, d ; $44a5
	ld [hl+], a ; $44a6
	ld l, c ; $44a7
	ld h, b ; $44a8
	ld bc, $0000 ; $44a9
	farcall FarPtr_08_44 ; $44ac
	ld e, l ; $44af
	ld d, h ; $44b0
	ld hl, $dc7a ; $44b1
	ld a, e ; $44b4
	ld [hl+], a ; $44b5
	ld a, d ; $44b6
	ld [hl+], a ; $44b7
	ld a, c ; $44b8
	ld [hl+], a ; $44b9
	ld a, b ; $44ba
	ld [hl+], a ; $44bb
	ret ; $44bc
Func_0d_44bd:
	wram_bank $04 ; $44bd
	ld hl, $dc00 ; $44c3
	ld c, $07 ; $44c6
Label_0d_44c8:
	call Func_0d_44d3 ; $44c8
	ld de, $0010 ; $44cb
	add hl, de ; $44ce
	dec c ; $44cf
	jr nz, Label_0d_44c8 ; $44d0
	ret ; $44d2
Func_0d_44d3:
	bit 0, [hl] ; $44d3
	ret z ; $44d5
	push af ; $44d6
	push bc ; $44d7
	push de ; $44d8
	push hl ; $44d9
	push hl ; $44da
	ld de, $dc70 ; $44db
	ld c, $01 ; $44de
	call CopyMemoryFast ; $44e0
	ld hl, $dc7e ; $44e3
	ld a, [hl+] ; $44e6
	ld h, [hl] ; $44e7
	ld l, a ; $44e8
	call JumpToHL ; $44e9
	pop de ; $44ec
	ld hl, $dc70 ; $44ed
	ld c, $01 ; $44f0
	call CopyMemoryFast ; $44f2
	pop hl ; $44f5
	pop de ; $44f6
	pop bc ; $44f7
	pop af ; $44f8
	ret ; $44f9
	INCBIN "data/bank_00d/d_44fa.bin" ; $44fa, 382 bytes
Func_0d_4678:
	call Func_0d_40cf ; $4678
	ld hl, $0000 ; $467b
	ld de, $fe00 ; $467e
	call Func_0d_493a ; $4681
	ld de, $fb20 ; $4684
	ld hl, $c486 ; $4687
	ld a, e ; $468a
	ld [hl+], a ; $468b
	ld [hl], d ; $468c
	ld de, $fe50 ; $468d
	ld hl, $c484 ; $4690
	ld a, e ; $4693
	ld [hl+], a ; $4694
	ld [hl], d ; $4695
	wram_bank $04 ; $4696
	ld hl, $0000 ; $469c
	ld de, $0480 ; $469f
	farcall FarPtr_08_22 ; $46a2
	ld a, $05 ; $46a5
	farcall FarPtr_08_1c ; $46a7
	wram_bank $05 ; $46aa
	ld a, [$c785] ; $46b0
	call Func_0d_4926 ; $46b3
	farcall FarPtr_08_22 ; $46b6
	ld a, $06 ; $46b9
	farcall FarPtr_08_1c ; $46bb
	ld a, $04 ; $46be
	ld [$df6a], a ; $46c0
	xor a, a ; $46c3
	ld [$c7a7], a ; $46c4
	ld a, [$df78] ; $46c7
	cp a, $15 ; $46ca
	jr nz, Label_0d_46d3 ; $46cc
	ld a, $01 ; $46ce
	ld [$c7a7], a ; $46d0
Label_0d_46d3:
	call Func_0d_48ce ; $46d3
	ret ; $46d6
Func_0d_46d7:
	ld de, $8403 ; $46d7
	call Func_0d_4bea ; $46da
	ld a, [$c7a7] ; $46dd
	and a, a ; $46e0
	jr z, Label_0d_46f6 ; $46e1
	ldh a, [hWramBank] ; $46e3
	push af ; $46e5
	wram_bank $05 ; $46e6
	ld hl, $df81 ; $46ec
	res 5, [hl] ; $46ef
	pop af ; $46f1
	wram_bank ; $46f2
Label_0d_46f6:
	ret ; $46f6
Func_0d_46f7:
	ld b, $19 ; $46f7
	ld hl, $c780 ; $46f9
	ld a, [hl+] ; $46fc
	ld h, [hl] ; $46fd
	ld l, a ; $46fe
	ld a, h ; $46ff
	and a, a ; $4700
	jr nz, Label_0d_470b ; $4701
	xor a, a ; $4703
	ld h, a ; $4704
	ld e, $0a ; $4705
	call Func_00_0fbc ; $4707
	ld b, l ; $470a
Label_0d_470b:
	ld a, b ; $470b
	ld [$c784], a ; $470c
	ldh a, [hWramBank] ; $470f
	push af ; $4711
	wram_bank $05 ; $4712
	ld d, $05 ; $4718
	farcall FarPtr_08_20 ; $471a
	pop af ; $471d
	wram_bank ; $471e
	ld a, [$c7a7] ; $4722
	and a, a ; $4725
	jr z, Label_0d_472d ; $4726
	ld a, $0f ; $4728
	farcall FarPtr_08_40 ; $472a
Label_0d_472d:
	ld hl, $c780 ; $472d
	ld a, [hl+] ; $4730
	ld d, [hl] ; $4731
	ld e, a ; $4732
	inc de ; $4733
	ld hl, $c780 ; $4734
	ld a, e ; $4737
	ld [hl+], a ; $4738
	ld [hl], d ; $4739
	call Func_0d_47fd ; $473a
	ld a, [$c785] ; $473d
	ld l, a ; $4740
	ld h, $00 ; $4741
	ld de, $0003 ; $4743
	call Func_00_0987 ; $4746
	ld a, l ; $4749
	ld [$c786], a ; $474a
	call Func_0d_48b6 ; $474d
	ret ; $4750
	INCBIN "data/bank_00d/d_4751.bin" ; $4751, 12 bytes
Func_0d_475d:
	ldh a, [hWramBank] ; $475d
	push af ; $475f
	wram_bank $04 ; $4760
	ld a, $05 ; $4766
	farcall FarPtr_08_1c ; $4768
	pop af ; $476b
	wram_bank ; $476c
	call Func_0d_43ba ; $4770
	farcall FarPtr_08_58 ; $4773
	add a, a ; $4776
	jr c, Label_0d_479b ; $4777
	ld a, [$c784] ; $4779
	add a, a ; $477c
	add a, a ; $477d
	add a, $47 ; $477e
	ld l, a ; $4780
	adc a, $45 ; $4781
	sub a, l ; $4783
	ld h, a ; $4784
	ld a, [hl] ; $4785
	add a, $ae ; $4786
	ld l, a ; $4788
	adc a, $45 ; $4789
	sub a, l ; $478b
	ld h, a ; $478c
	ld a, [hl] ; $478d
	farcall FarPtr_08_40 ; $478e
	call Func_0d_41d3 ; $4791
	and a, a ; $4794
	ret z ; $4795
	ld a, $0b ; $4796
	ld [wPointOutcome], a ; $4798
Label_0d_479b:
	call Func_0d_43df ; $479b
	push de ; $479e
	ldh a, [hWramBank] ; $479f
	push af ; $47a1
	wram_bank $04 ; $47a2
	farcall FarPtr_08_6c ; $47a8
	wram_bank $05 ; $47ab
	farcall FarPtr_08_6c ; $47b1
	pop af ; $47b4
	wram_bank ; $47b5
	pop de ; $47b9
	call Func_0d_4412 ; $47ba
	ret ; $47bd
Func_0d_47be:
	xor a, a ; $47be
	ld [$c4c9], a ; $47bf
	ret ; $47c2
Func_0d_47c3:
	ld a, [wPointOutcome] ; $47c3
	and a, a ; $47c6
	jr nz, Label_0d_47e1 ; $47c7
	ld a, [wRallyLength] ; $47c9
	cp a, $04 ; $47cc
	jr nz, Label_0d_47e1 ; $47ce
	ld a, [$c4b2] ; $47d0
	cp a, $01 ; $47d3
	jr nz, Label_0d_47e1 ; $47d5
	ld a, $06 ; $47d7
	ld [wPointOutcome], a ; $47d9
	ld a, $01 ; $47dc
	ld [$c4d9], a ; $47de
Label_0d_47e1:
	ret ; $47e1
Func_0d_47e2:
	ld a, [wRallyLength] ; $47e2
	cp a, $03 ; $47e5
	jr nz, Label_0d_47fc ; $47e7
	ldh a, [hWramBank] ; $47e9
	push af ; $47eb
	wram_bank $05 ; $47ec
	ld a, $28 ; $47f2
	ld [$df10], a ; $47f4
	pop af ; $47f7
	wram_bank ; $47f8
Label_0d_47fc:
	ret ; $47fc
Func_0d_47fd:
	ld a, $01 ; $47fd
	ld [wBallSpriteEnabled], a ; $47ff
	ld [wBallShadowEnabled], a ; $4802
	ld [wBallTrailEnabled], a ; $4805
	ld a, $02 ; $4808
	ld [wRallyLength], a ; $480a
	ld a, $02 ; $480d
	ld [$c4b0], a ; $480f
	ldh a, [hWramBank] ; $4812
	push af ; $4814
	wram_bank $05 ; $4815
	ld a, $20 ; $481b
	ld [$df4b], a ; $481d
	ld a, [$c784] ; $4820
	add a, a ; $4823
	add a, a ; $4824
	add a, $48 ; $4825
	ld l, a ; $4827
	adc a, $45 ; $4828
	sub a, l ; $482a
	ld h, a ; $482b
	ld a, [hl] ; $482c
	dec a ; $482d
	ld [$df6b], a ; $482e
	ld [$df6d], a ; $4831
	ld [$df6f], a ; $4834
	ld [$df6e], a ; $4837
	ld a, [$c784] ; $483a
	add a, a ; $483d
	add a, a ; $483e
	add a, $46 ; $483f
	ld l, a ; $4841
	adc a, $45 ; $4842
	sub a, l ; $4844
	ld h, a ; $4845
	ld a, [hl] ; $4846
	add a, a ; $4847
	add a, a ; $4848
	add a, a ; $4849
	add a, a ; $484a
	add a, $b3 ; $484b
	ld l, a ; $484d
	adc a, $45 ; $484e
	sub a, l ; $4850
	ld h, a ; $4851
	farcall FarPtr_08_36 ; $4852
	and a, $0f ; $4855
	add a, l ; $4857
	ld l, a ; $4858
	jr nc, Label_0d_485c ; $4859
	inc h ; $485b
Label_0d_485c:
	ld a, [hl] ; $485c
	swap a ; $485d
	and a, $0f ; $485f
	ld [$df16], a ; $4861
	ld a, [hl] ; $4864
	and a, $0f ; $4865
	ld [$df17], a ; $4867
	farcall FarPtr_08_68 ; $486a
	ld a, [$c786] ; $486d
	add a, $75 ; $4870
	ld l, a ; $4872
	adc a, $46 ; $4873
	sub a, l ; $4875
	ld h, a ; $4876
	ld a, [hl] ; $4877
	ld [$df69], a ; $4878
	ld a, [$c786] ; $487b
	add a, a ; $487e
	add a, $6f ; $487f
	ld l, a ; $4881
	adc a, $46 ; $4882
	sub a, l ; $4884
	ld h, a ; $4885
	ld a, [hl+] ; $4886
	ld b, [hl] ; $4887
	ld c, a ; $4888
	ld hl, $df04 ; $4889
	ld a, [hl+] ; $488c
	ld d, [hl] ; $488d
	ld e, a ; $488e
	ld hl, $df01 ; $488f
	ld a, [hl+] ; $4892
	ld h, [hl] ; $4893
	ld l, a ; $4894
	farcall FarPtr_08_62 ; $4895
	farcall FarPtr_08_36 ; $4898
	and a, $07 ; $489b
	add a, $43 ; $489d
	ld l, a ; $489f
	adc a, $46 ; $48a0
	sub a, l ; $48a2
	ld h, a ; $48a3
	ld a, [hl] ; $48a4
	ld [$df4a], a ; $48a5
	ld hl, $073c ; $48a8
	call Func_00_07c5 ; $48ab
	sound $76 ; $48ae
	pop af ; $48b0
	wram_bank ; $48b1
	ret ; $48b5
Func_0d_48b6:
	ldh a, [hWramBank] ; $48b6
	push af ; $48b8
	wram_bank $05 ; $48b9
	ld a, [$c785] ; $48bf
	call Func_0d_4926 ; $48c2
	farcall FarPtr_08_66 ; $48c5
	pop af ; $48c8
	wram_bank ; $48c9
	ret ; $48cd
Func_0d_48ce:
	wram_bank $04 ; $48ce
	xor a, a ; $48d4
	ld [$c4c2], a ; $48d5
	ld a, [wCurrentBGM] ; $48d8
	push af ; $48db
	sound $00 ; $48dc
	ld a, $14 ; $48de
	farcall FarPtr_08_40 ; $48e0
	ld a, $03 ; $48e3
Label_0d_48e5:
	push af ; $48e5
	ld b, $01 ; $48e6
	ld de, $8200 ; $48e8
	farcall FarPtr_09_28 ; $48eb
	ld a, [$c492] ; $48ee
	and a, a ; $48f1
	jr nz, Label_0d_48f6 ; $48f2
	sound $74 ; $48f4
Label_0d_48f6:
	ld a, $11 ; $48f6
	farcall FarPtr_09_14 ; $48f8
	ld a, $28 ; $48fb
	farcall FarPtr_08_40 ; $48fd
	pop af ; $4900
	dec a ; $4901
	jr nz, Label_0d_48e5 ; $4902
	ld a, [$c492] ; $4904
	and a, a ; $4907
	jr nz, Label_0d_490c ; $4908
	sound $75 ; $490a
Label_0d_490c:
	ld a, $10 ; $490c
	farcall FarPtr_09_12 ; $490e
	ld a, $28 ; $4911
	farcall FarPtr_08_40 ; $4913
	farcall FarPtr_09_16 ; $4916
	pop af ; $4919
	ld b, a ; $491a
	ld a, [$c492] ; $491b
	and a, a ; $491e
	jr nz, Label_0d_4925 ; $491f
	ld a, b ; $4921
	call Func_00_3024 ; $4922
Label_0d_4925:
	ret ; $4925
Func_0d_4926:
	add a, a ; $4926
	add a, a ; $4927
	add a, $4b ; $4928
	ld l, a ; $492a
	adc a, $46 ; $492b
	sub a, l ; $492d
	ld h, a ; $492e
	ld a, [hl+] ; $492f
	ld c, a ; $4930
	ld a, [hl+] ; $4931
	ld b, a ; $4932
	ld a, [hl+] ; $4933
	ld e, a ; $4934
	ld a, [hl+] ; $4935
	ld d, a ; $4936
	ld l, c ; $4937
	ld h, b ; $4938
	ret ; $4939
Func_0d_493a:
	ld c, l ; $493a
	ld b, h ; $493b
	ld hl, $c440 ; $493c
	ld a, c ; $493f
	ld [hl+], a ; $4940
	ld [hl], b ; $4941
	ld hl, $c444 ; $4942
	ld a, c ; $4945
	ld [hl+], a ; $4946
	ld [hl], b ; $4947
	ld hl, $c442 ; $4948
	ld a, e ; $494b
	ld [hl+], a ; $494c
	ld [hl], d ; $494d
	ld hl, $c446 ; $494e
	ld a, e ; $4951
	ld [hl+], a ; $4952
	ld [hl], d ; $4953
	xor a, a ; $4954
	ld [$c4c9], a ; $4955
	ret ; $4958
	INCBIN "data/bank_00d/d_4959.bin" ; $4959, 295 bytes
	ld a, $01 ; $4a80
	ld [$c7b9], a ; $4a82
	ld a, $00 ; $4a85
	ld [wMinigameLevel], a ; $4a87
	farcall FarPtr_0a_96 ; $4a8a
	ld a, $00 ; $4a8d
	farcall FarPtr_0a_9a ; $4a8f
	ret ; $4a92
	INCBIN "data/bank_00d/d_4a93.bin" ; $4a93, 16 bytes
	call Func_0d_4abb ; $4aa3
	ret ; $4aa6
	call Func_0d_4b01 ; $4aa7
	ret ; $4aaa
	call Func_0d_4b29 ; $4aab
	ret ; $4aae
	call Func_0d_4b59 ; $4aaf
	ret ; $4ab2
	call Func_0d_4bc7 ; $4ab3
	ret ; $4ab6
	call Func_0d_4bc8 ; $4ab7
	ret ; $4aba
Func_0d_4abb:
	ld a, [wPointWinLoseFlag] ; $4abb
	and a, a ; $4abe
	jr nz, Label_0d_4ac7 ; $4abf
	ld de, $8484 ; $4ac1
	call Func_0d_4bea ; $4ac4
Label_0d_4ac7:
	ldh a, [hWramBank] ; $4ac7
	push af ; $4ac9
	wram_bank $04 ; $4aca
	ld hl, $dd0c ; $4ad0
	ld de, $de14 ; $4ad3
	call Func_0d_4af1 ; $4ad6
	ld hl, $dd06 ; $4ad9
	ld de, $de18 ; $4adc
	call Func_0d_4af1 ; $4adf
	ld hl, $dd00 ; $4ae2
	ld de, $de1c ; $4ae5
	call Func_0d_4af1 ; $4ae8
	pop af ; $4aeb
	wram_bank ; $4aec
	ret ; $4af0
Func_0d_4af1:
	inc hl ; $4af1
	inc hl ; $4af2
	ld a, [hl+] ; $4af3
	ld b, [hl] ; $4af4
	ld c, a ; $4af5
	ld hl, $fe60 ; $4af6
	add hl, bc ; $4af9
	bit 7, h ; $4afa
	ret z ; $4afc
	ld a, $ff ; $4afd
	ld [de], a ; $4aff
	ret ; $4b00
Func_0d_4b01:
	call Func_0d_40cf ; $4b01
	xor a, a ; $4b04
	ld [wStandingShadowsEnabled], a ; $4b05
	ld de, $0000 ; $4b08
	ld hl, $c488 ; $4b0b
	ld a, e ; $4b0e
	ld [hl+], a ; $4b0f
	ld [hl], d ; $4b10
	ldh a, [hWramBank] ; $4b11
	push af ; $4b13
	wram_bank $04 ; $4b14
	ld hl, $0000 ; $4b1a
	ld de, $04e0 ; $4b1d
	farcall FarPtr_08_22 ; $4b20
	pop af ; $4b23
	wram_bank ; $4b24
	ret ; $4b28
Func_0d_4b29:
	ldh a, [hWramBank] ; $4b29
	push af ; $4b2b
	wram_bank $04 ; $4b2c
	ld a, $05 ; $4b32
	farcall FarPtr_08_1c ; $4b34
	pop af ; $4b37
	wram_bank ; $4b38
	call Func_0d_43ba ; $4b3c
	call Func_0d_43df ; $4b3f
	push de ; $4b42
	ldh a, [hWramBank] ; $4b43
	push af ; $4b45
	wram_bank $04 ; $4b46
	farcall FarPtr_08_6c ; $4b4c
	pop af ; $4b4f
	wram_bank ; $4b50
	pop de ; $4b54
	call Func_0d_4412 ; $4b55
	ret ; $4b58
Func_0d_4b59:
	ld a, [wPointOutcome] ; $4b59
	and a, a ; $4b5c
	jr nz, Label_0d_4b70 ; $4b5d
	ld de, $0001 ; $4b5f
	call Func_0d_4266 ; $4b62
	call Func_0d_41d3 ; $4b65
	and a, a ; $4b68
	jr z, Label_0d_4b70 ; $4b69
	ld a, $0b ; $4b6b
	ld [wPointOutcome], a ; $4b6d
Label_0d_4b70:
	ld a, $01 ; $4b70
	ld [$c4c9], a ; $4b72
	farcall FarPtr_08_34 ; $4b75
	xor a, a ; $4b78
	ld [$c4b2], a ; $4b79
	ld hl, $c4be ; $4b7c
	ld a, [hl] ; $4b7f
	xor a, $02 ; $4b80
	ld [hl], a ; $4b82
	ld hl, $c404 ; $4b83
	ld a, [hl] ; $4b86
	cpl ; $4b87
	ld [hl+], a ; $4b88
	ld a, [hl] ; $4b89
	cpl ; $4b8a
	ld [hl+], a ; $4b8b
	ld a, [hl] ; $4b8c
	cpl ; $4b8d
	ld [hl+], a ; $4b8e
	ld a, [hl] ; $4b8f
	cpl ; $4b90
	ld [hl+], a ; $4b91
	ld hl, $c423 ; $4b92
	ld a, [hl] ; $4b95
	cpl ; $4b96
	ld [hl+], a ; $4b97
	ld a, [hl] ; $4b98
	cpl ; $4b99
	ld [hl+], a ; $4b9a
	ld a, [hl] ; $4b9b
	cpl ; $4b9c
	ld [hl+], a ; $4b9d
	ld hl, $c423 ; $4b9e
	ld b, $e6 ; $4ba1
	farcall FarPtr_08_6e ; $4ba3
	ld hl, $c423 ; $4ba6
	ld [hl+], a ; $4ba9
	ld a, e ; $4baa
	ld [hl+], a ; $4bab
	ld a, d ; $4bac
	ld [hl+], a ; $4bad
	ld a, [wPointOutcome] ; $4bae
	and a, a ; $4bb1
	ret nz ; $4bb2
	ldh a, [hWramBank] ; $4bb3
	push af ; $4bb5
	wram_bank $04 ; $4bb6
	ld a, $01 ; $4bbc
	farcall FarPtr_08_1c ; $4bbe
	pop af ; $4bc1
	wram_bank ; $4bc2
	ret ; $4bc6
Func_0d_4bc7:
	ret ; $4bc7
Func_0d_4bc8:
	xor a, a ; $4bc8
	ld [$c4da], a ; $4bc9
	ld a, [wRallyLength] ; $4bcc
	cp a, $01 ; $4bcf
	ret nz ; $4bd1
	ld de, $fb20 ; $4bd2
	ld hl, $c486 ; $4bd5
	ld a, e ; $4bd8
	ld [hl+], a ; $4bd9
	ld [hl], d ; $4bda
	ld de, $fe50 ; $4bdb
	ld hl, $c484 ; $4bde
	ld a, e ; $4be1
	ld [hl+], a ; $4be2
	ld [hl], d ; $4be3
	ld a, $02 ; $4be4
	ld [wRallyLength], a ; $4be6
	ret ; $4be9
Func_0d_4bea:
	ld hl, wMinigamesCurrentScore ; $4bea
	ld a, [hl+] ; $4bed
	ld h, [hl] ; $4bee
	ld l, a ; $4bef
	ld b, $01 ; $4bf0
	ld a, $04 ; $4bf2
	farcall FarPtr_0a_9c ; $4bf4
	ret ; $4bf7
	INCBIN "data/bank_00d/d_4bf8.bin" ; $4bf8, 216 bytes
	ret ; $4cd0
	INCBIN "data/bank_00d/d_4cd1.bin" ; $4cd1, 219 bytes
	ret ; $4dac
	INCBIN "data/bank_00d/d_4dad.bin" ; $4dad, 1015 bytes
	ld a, $01 ; $51a4
	ld [$c7b8], a ; $51a6
	ld a, [wMinigameLevel] ; $51a9
	cp a, $02 ; $51ac
	jr nz, Label_0d_51b5 ; $51ae
	ld a, $01 ; $51b0
	ld [$c7bc], a ; $51b2
Label_0d_51b5:
	ret ; $51b5
	INCBIN "data/bank_00d/d_51b6.bin" ; $51b6, 16 bytes
	call Func_0d_5205 ; $51c6
	ld a, $01 ; $51c9
	ld [$c785], a ; $51cb
	call Func_0d_4678 ; $51ce
	ret ; $51d1
	call Func_0d_46d7 ; $51d2
	call Func_0d_4237 ; $51d5
	ret ; $51d8
	call Func_0d_44bd ; $51d9
	ret ; $51dc
	call Func_0d_521e ; $51dd
	farcall FarPtr_08_36 ; $51e0
	and a, $01 ; $51e3
	inc a ; $51e5
	ld hl, $c785 ; $51e6
	add a, [hl] ; $51e9
	cp a, $03 ; $51ea
	jr c, Label_0d_51f0 ; $51ec
	sub a, $03 ; $51ee
Label_0d_51f0:
	ld [hl], a ; $51f0
	call Func_0d_46f7 ; $51f1
	ret ; $51f4
	call Func_0d_475d ; $51f5
	ret ; $51f8
	call Func_0d_47be ; $51f9
	ret ; $51fc
	call Func_0d_47c3 ; $51fd
	ret ; $5200
	call Func_0d_47e2 ; $5201
	ret ; $5204
Func_0d_5205:
	call Func_0d_4440 ; $5205
	ld de, $5231 ; $5208
	ld bc, $dc00 ; $520b
	call Func_0d_444f ; $520e
	ld hl, $0000 ; $5211
	ld de, $fdc0 ; $5214
	ld bc, $dc00 ; $5217
	call Func_0d_4465 ; $521a
	ret ; $521d
Func_0d_521e:
	ld a, [$c788] ; $521e
	and a, a ; $5221
	jr nz, Label_0d_5228 ; $5222
	xor a, a ; $5224
	ld [$c789], a ; $5225
Label_0d_5228:
	xor a, a ; $5228
	ld [$c788], a ; $5229
	xor a, a ; $522c
	ld [$dc02], a ; $522d
	ret ; $5230
	ld a, [$dc72] ; $5231
	rst Rst00 ; $5234
	dw Label_0d_5244 ; $5235 jumptable
	dw Label_0d_5262 ; $5237 jumptable
	dw Label_0d_5270 ; $5239 jumptable
	dw Label_0d_528e ; $523b jumptable
	dw Label_00_03ae ; $523d jumptable
Func_0d_523f:
	ld hl, $dc72 ; $523f
	inc [hl] ; $5242
	ret ; $5243
Label_0d_5244:
	ld a, [$dc73] ; $5244
	and a, a ; $5247
	jr z, Label_0d_525b ; $5248
	farcall FarPtr_08_36 ; $524a
	ld h, $00 ; $524d
	ld l, a ; $524f
	add hl, hl ; $5250
	ld de, rJOYP ; $5251
	add hl, de ; $5254
	ld de, $fdc0 ; $5255
	call Func_0d_449a ; $5258
Label_0d_525b:
	xor a, a ; $525b
	ld [$dc73], a ; $525c
	call Func_0d_523f ; $525f
Label_0d_5262:
	call Func_0d_535f ; $5262
	call Func_0d_5292 ; $5265
	and a, a ; $5268
	ret z ; $5269
	call Func_0d_52f9 ; $526a
	jp Func_0d_523f ; $526d
Label_0d_5270:
	call Func_0d_539e ; $5270
	ld hl, $dc73 ; $5273
	dec [hl] ; $5276
	ld a, [hl] ; $5277
	and a, a ; $5278
	ret nz ; $5279
	farcall FarPtr_08_36 ; $527a
	ld h, $00 ; $527d
	ld l, a ; $527f
	add hl, hl ; $5280
	ld de, rJOYP ; $5281
	add hl, de ; $5284
	ld de, $fdc0 ; $5285
	call Func_0d_449a ; $5288
	jp Func_0d_523f ; $528b
Label_0d_528e:
	call Func_0d_535f ; $528e
	ret ; $5291
Func_0d_5292:
	ld a, [$c4b8] ; $5292
	and a, $01 ; $5295
	jp nz, Label_0d_52f7 ; $5297
	ld hl, $dc76 ; $529a
	ld a, [hl+] ; $529d
	ld d, [hl] ; $529e
	ld e, a ; $529f
	ld hl, wBallX ; $52a0
	ld a, [hl+] ; $52a3
	ld h, [hl] ; $52a4
	ld l, a ; $52a5
	ld a, l ; $52a6
	sub a, e ; $52a7
	ld l, a ; $52a8
	ld a, h ; $52a9
	sbc a, d ; $52aa
	ld h, a ; $52ab
	bit 7, h ; $52ac
	jr z, Label_0d_52b6 ; $52ae
	xor a, a ; $52b0
	sub a, l ; $52b1
	ld l, a ; $52b2
	sbc a, a ; $52b3
	sub a, h ; $52b4
	ld h, a ; $52b5
Label_0d_52b6:
	ld de, $ff80 ; $52b6
	add hl, de ; $52b9
	jr c, Label_0d_52f7 ; $52ba
	ld hl, $dc78 ; $52bc
	ld a, [hl+] ; $52bf
	ld d, [hl] ; $52c0
	ld e, a ; $52c1
	ld hl, wBallDepth ; $52c2
	ld a, [hl+] ; $52c5
	ld h, [hl] ; $52c6
	ld l, a ; $52c7
	ld a, l ; $52c8
	sub a, e ; $52c9
	ld l, a ; $52ca
	ld a, h ; $52cb
	sbc a, d ; $52cc
	ld h, a ; $52cd
	bit 7, h ; $52ce
	jr z, Label_0d_52d8 ; $52d0
	xor a, a ; $52d2
	sub a, l ; $52d3
	ld l, a ; $52d4
	sbc a, a ; $52d5
	sub a, h ; $52d6
	ld h, a ; $52d7
Label_0d_52d8:
	ld de, rJOYP ; $52d8
	add hl, de ; $52db
	jr c, Label_0d_52f7 ; $52dc
	ld hl, wBallHeight ; $52de
	ld a, [hl+] ; $52e1
	ld h, [hl] ; $52e2
	ld l, a ; $52e3
	bit 7, h ; $52e4
	jr z, Label_0d_52ee ; $52e6
	xor a, a ; $52e8
	sub a, l ; $52e9
	ld l, a ; $52ea
	sbc a, a ; $52eb
	sub a, h ; $52ec
	ld h, a ; $52ed
Label_0d_52ee:
	ld de, rLCDC ; $52ee
	add hl, de ; $52f1
	jr c, Label_0d_52f7 ; $52f2
	ld a, $01 ; $52f4
	ret ; $52f6
Label_0d_52f7:
	xor a, a ; $52f7
	ret ; $52f8
Func_0d_52f9:
	ld a, $10 ; $52f9
	ld [$dc73], a ; $52fb
	ld hl, $0001 ; $52fe
	ld a, [$c4a0] ; $5301
	cp a, $09 ; $5304
	jr nz, Label_0d_5310 ; $5306
	ld a, $20 ; $5308
	ld [$dc73], a ; $530a
	ld hl, $0007 ; $530d
Label_0d_5310:
	ld a, $01 ; $5310
	ld [$c788], a ; $5312
	ld a, [$c789] ; $5315
	add a, $4f ; $5318
	ld e, a ; $531a
	adc a, $53 ; $531b
	sub a, e ; $531d
	ld d, a ; $531e
	ld a, [de] ; $531f
	call Func_00_3024 ; $5320
	ld a, [$c789] ; $5323
	add a, $57 ; $5326
	ld e, a ; $5328
	adc a, $53 ; $5329
	sub a, e ; $532b
	ld d, a ; $532c
	ld a, [de] ; $532d
	call Func_00_0926 ; $532e
	ld e, l ; $5331
	ld d, h ; $5332
	ld hl, $c782 ; $5333
	ld a, e ; $5336
	ld [hl+], a ; $5337
	ld [hl], d ; $5338
	call Func_0d_4266 ; $5339
	call Func_0d_4211 ; $533c
	ld b, $07 ; $533f
	call Func_0d_41cb ; $5341
	ld a, $06 ; $5344
	ld [wPointOutcome], a ; $5346
	ld a, $01 ; $5349
	ld [$c4d9], a ; $534b
	ret ; $534e
	INCBIN "data/bank_00d/d_534f.bin" ; $534f, 16 bytes
Func_0d_535f:
	call Func_0d_53aa ; $535f
	ld c, $30 ; $5362
	ld h, $fc ; $5364
	ld l, $f1 ; $5366
	call Func_00_2c2b ; $5368
	ldh a, [$ff8c] ; $536b
	and a, $1f ; $536d
	add a, $7e ; $536f
	ld l, a ; $5371
	adc a, $53 ; $5372
	sub a, l ; $5374
	ld h, a ; $5375
	ld a, [hl] ; $5376
	cp a, $ff ; $5377
	ret z ; $5379
	farcall FarPtr_28_0c ; $537a
	ret ; $537d
	INCBIN "data/bank_00d/d_537e.bin" ; $537e, 32 bytes
Func_0d_539e:
	call Func_0d_53aa ; $539e
	ld c, $3c ; $53a1
	ld a, [$dc73] ; $53a3
	call Func_0d_53ce ; $53a6
	ret ; $53a9
Func_0d_53aa:
	ld hl, $dc7a ; $53aa
	ld a, [hl+] ; $53ad
	ld e, a ; $53ae
	ld a, [hl+] ; $53af
	ld d, a ; $53b0
	ld a, [hl+] ; $53b1
	ld c, a ; $53b2
	ld a, [hl+] ; $53b3
	ld b, a ; $53b4
	ld l, e ; $53b5
	ld h, d ; $53b6
	farcall FarPtr_08_46 ; $53b7
	ld a, [$c789] ; $53ba
	add a, $c6 ; $53bd
	ld l, a ; $53bf
	adc a, $53 ; $53c0
	sub a, l ; $53c2
	ld h, a ; $53c3
	ld b, [hl] ; $53c4
	ret ; $53c5
	INCBIN "data/bank_00d/d_53c6.bin" ; $53c6, 8 bytes
Func_0d_53ce:
	call Func_0d_53d8 ; $53ce
	call Func_0d_540a ; $53d1
	call Func_0d_540a ; $53d4
	ret ; $53d7
Func_0d_53d8:
	and a, $0f ; $53d8
	cpl ; $53da
	inc a ; $53db
	add a, $0f ; $53dc
	add a, $2c ; $53de
	ld l, a ; $53e0
	adc a, $54 ; $53e1
	sub a, l ; $53e3
	ld h, a ; $53e4
	ld a, e ; $53e5
	add a, $f8 ; $53e6
	ld e, a ; $53e8
	call Func_0d_540a ; $53e9
	call Func_0d_540a ; $53ec
	call Func_0d_540a ; $53ef
	call Func_0d_540a ; $53f2
	ret ; $53f5
	INCBIN "data/bank_00d/d_53f6.bin" ; $53f6, 20 bytes
Func_0d_540a:
	push de ; $540a
	ld a, [hl] ; $540b
	add a, a ; $540c
	add a, d ; $540d
	ld d, a ; $540e
	ld a, $10 ; $540f
	add a, l ; $5411
	ld l, a ; $5412
	jr nc, Label_0d_5416 ; $5413
	inc h ; $5415
Label_0d_5416:
	ld a, [hl] ; $5416
	add a, a ; $5417
	add a, e ; $5418
	ld e, a ; $5419
	ld a, $10 ; $541a
	add a, l ; $541c
	ld l, a ; $541d
	jr nc, Label_0d_5421 ; $541e
	inc h ; $5420
Label_0d_5421:
	push hl ; $5421
	call QueueSprite ; $5422
	pop hl ; $5425
	pop de ; $5426
	dec e ; $5427
	dec e ; $5428
	dec e ; $5429
	dec e ; $542a
	ret ; $542b
	INCBIN "data/bank_00d/d_542c.bin" ; $542c, 1165 bytes
	ret ; $58b9
	INCBIN "data/bank_00d/d_58ba.bin" ; $58ba, 1856 bytes
	ds 8198, $ff ; $5ffa, fill
