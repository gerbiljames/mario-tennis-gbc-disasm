INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $0b", ROMX[$4000], BANK[$0b]

FarPtr_0b_00:
	dw Func_0b_4705 ; $4000
Func_0b_4002:
	ld hl, $0000 ; $4002
	add hl, bc ; $4005
	ld a, [hl] ; $4006
	ld [$c3b1], a ; $4007
	ld hl, $0001 ; $400a
	add hl, bc ; $400d
	ld a, [hl] ; $400e
	ld [wCurrentlyUsedCourt], a ; $400f
	ld hl, $0002 ; $4012
	add hl, bc ; $4015
	ld a, [hl] ; $4016
	ld [$c8f3], a ; $4017
	ld hl, $0003 ; $401a
	add hl, bc ; $401d
	ld a, [hl] ; $401e
	ld [wGameMode], a ; $401f
	ld a, $02 ; $4022
	ld [wCurrentMinigameStoryMatch], a ; $4024
	ld hl, $0004 ; $4027
	add hl, bc ; $402a
	ld a, [hl] ; $402b
	ld [$c8f7], a ; $402c
	ld hl, $0005 ; $402f
	add hl, bc ; $4032
	ld a, [hl] ; $4033
	ld [$c8f8], a ; $4034
	push bc ; $4037
	ld hl, $0007 ; $4038
	add hl, bc ; $403b
	ld b, [hl] ; $403c
	ld c, $00 ; $403d
	farcall FarPtr_02_18 ; $403f
	ld a, [wStoryModeMainCharacterOverworldSprite] ; $4042
	ld [$c3b0], a ; $4045
	ld a, [$c3b1] ; $4048
	cp a, $ff ; $404b
	jr z, Label_0b_4055 ; $404d
	ld b, a ; $404f
	ld c, $02 ; $4050
	farcall FarPtr_02_18 ; $4052
Label_0b_4055:
	pop bc ; $4055
	ld hl, $0008 ; $4056
	add hl, bc ; $4059
	ld a, [hl+] ; $405a
	ld d, [hl] ; $405b
	ld e, a ; $405c
	ldh a, [$ff95] ; $405d
	farcall FarPtr_08_48 ; $405f
	ld hl, $000a ; $4062
	add hl, bc ; $4065
	ld a, [hl+] ; $4066
	ld d, [hl] ; $4067
	ld e, a ; $4068
	farcall FarPtr_08_4a ; $4069
	ld hl, $000c ; $406c
	add hl, bc ; $406f
	ld a, [hl+] ; $4070
	ld h, [hl] ; $4071
	ld l, a ; $4072
	ld a, h ; $4073
	or a, l ; $4074
	jr z, Label_0b_407a ; $4075
	call JumpToHL ; $4077
Label_0b_407a:
	ret ; $407a
Func_0b_407b:
	ld a, [wPointWinLoseFlag] ; $407b
	or a, a ; $407e
	ret z ; $407f
	and a, $03 ; $4080
	ld b, a ; $4082
	rrc a ; $4083
	rrc a ; $4085
	ld c, a ; $4087
	ld a, [wTotalPointsScoredInCurrentGame] ; $4088
	ld b, a ; $408b
	ld hl, $40bc ; $408c
	ld a, [$c7bb] ; $408f
	or a, a ; $4092
	jr nz, Label_0b_40ad ; $4093
	ld a, b ; $4095
	and a, $01 ; $4096
	add a, a ; $4098
	add a, l ; $4099
	ld l, a ; $409a
	jr nc, Label_0b_409e ; $409b
	inc h ; $409d
Label_0b_409e:
	srl b ; $409e
	ld a, [wTotalPointsScoredInCurrentGame] ; $40a0
	and a, $01 ; $40a3
	jr z, Label_0b_40ad ; $40a5
	ld a, c ; $40a7
	xor a, $80 ; $40a8
	ld c, a ; $40aa
	jr Label_0b_40ad ; $40ab
Label_0b_40ad:
	ld a, [hl+] ; $40ad
	ld h, [hl] ; $40ae
	ld l, a ; $40af
	inc b ; $40b0
	sla b ; $40b1
	ld a, c ; $40b3
Label_0b_40b4:
	rlc a ; $40b4
	dec b ; $40b6
	jr nz, Label_0b_40b4 ; $40b7
	or a, [hl] ; $40b9
	ld [hl], a ; $40ba
	ret ; $40bb
	INCBIN "data/bank_00b/d_40bc.bin" ; $40bc, 143 bytes
Func_0b_414b:
	ldh a, [$ff96] ; $414b
	push af ; $414d
	ld a, $05 ; $414e
	ldh [$ff96], a ; $4150
	ldh [rWBK], a ; $4152
	ld a, $00 ; $4154
	farcall FarPtr_08_1c ; $4156
	pop af ; $4159
	ldh [$ff96], a ; $415a
	ldh [rWBK], a ; $415c
	ret ; $415e
	INCBIN "data/bank_00b/d_415f.bin" ; $415f, 50 bytes
Func_0b_4191:
	ld a, [wTotalPointsScoredInCurrentGame] ; $4191
	add a, a ; $4194
	add a, a ; $4195
	add a, a ; $4196
	add a, l ; $4197
	ld l, a ; $4198
	jr nc, Label_0b_419c ; $4199
	inc h ; $419b
Label_0b_419c:
	ld b, h ; $419c
	ld c, l ; $419d
	ld hl, $0002 ; $419e
	add hl, bc ; $41a1
	ld a, [hl+] ; $41a2
	ld d, [hl] ; $41a3
	ld e, a ; $41a4
	ld hl, $0000 ; $41a5
	add hl, bc ; $41a8
	ld a, [hl+] ; $41a9
	ld h, [hl] ; $41aa
	ld l, a ; $41ab
	push bc ; $41ac
	farcall FarPtr_08_52 ; $41ad
	pop bc ; $41b0
	ld hl, $0006 ; $41b1
	add hl, bc ; $41b4
	ld a, [hl+] ; $41b5
	ld d, [hl] ; $41b6
	ld e, a ; $41b7
	ld hl, $0004 ; $41b8
	add hl, bc ; $41bb
	ld a, [hl+] ; $41bc
	ld h, [hl] ; $41bd
	ld l, a ; $41be
	farcall FarPtr_08_54 ; $41bf
	ret ; $41c2
Func_0b_41c3:
	ld a, [$c2e1] ; $41c3
	or a, a ; $41c6
	ret z ; $41c7
	ld a, [$c4d8] ; $41c8
	or a, a ; $41cb
	ret nz ; $41cc
	ld hl, $c2e0 ; $41cd
	dec [hl] ; $41d0
	ld a, [hl] ; $41d1
	or a, a ; $41d2
	ret nz ; $41d3
	ld a, $01 ; $41d4
	ld [$c4c3], a ; $41d6
	ret ; $41d9
	INCBIN "data/bank_00b/d_41da.bin" ; $41da, 12 bytes
Func_0b_41e6:
	ld a, [$c4b2] ; $41e6
	cp a, $02 ; $41e9
	ret nc ; $41eb
	farcall FarPtr_08_56 ; $41ec
	jr z, Label_0b_41f6 ; $41ef
	xor a, a ; $41f1
	ld [$c78c], a ; $41f2
	ret ; $41f5
Label_0b_41f6:
	ld a, [wTotalPointsScoredInCurrentGame] ; $41f6
	ld b, a ; $41f9
	inc b ; $41fa
	xor a, a ; $41fb
	scf ; $41fc
Label_0b_41fd:
	rla ; $41fd
	dec b ; $41fe
	jr nz, Label_0b_41fd ; $41ff
	ld hl, $c2e4 ; $4201
	or a, [hl] ; $4204
	ld [hl], a ; $4205
	ret ; $4206
	INCBIN "data/bank_00b/d_4207.bin" ; $4207, 21 bytes
Func_0b_421c:
	push bc ; $421c
	ld a, [wTotalPointsScoredInCurrentGame] ; $421d
	ld c, a ; $4220
	inc c ; $4221
	ld a, [$c2e4] ; $4222
	ld b, a ; $4225
Label_0b_4226:
	ld a, $00 ; $4226
	rr b ; $4228
	adc a, $00 ; $422a
	dec c ; $422c
	jr nz, Label_0b_4226 ; $422d
	xor a, $01 ; $422f
	pop bc ; $4231
	ret ; $4232
	INCBIN "data/bank_00b/d_4233.bin" ; $4233, 371 bytes
Func_0b_43a6:
	ld hl, $c442 ; $43a6
	ld a, [hl+] ; $43a9
	ld d, [hl] ; $43aa
	ld e, a ; $43ab
	ld hl, $c440 ; $43ac
	ld a, [hl+] ; $43af
	ld h, [hl] ; $43b0
	ld l, a ; $43b1
	farcall FarPtr_08_2e ; $43b2
	ld a, [$c4d8] ; $43b5
	cp a, $06 ; $43b8
	jr z, Label_0b_43dc ; $43ba
	cp a, $07 ; $43bc
	jr z, Label_0b_43dc ; $43be
	cp a, $01 ; $43c0
	jr z, Label_0b_43ca ; $43c2
	cp a, $03 ; $43c4
	jr z, Label_0b_43ca ; $43c6
	jr Label_0b_43cf ; $43c8
Label_0b_43ca:
	add a, $00 ; $43ca
	farcall FarPtr_09_12 ; $43cc
Label_0b_43cf:
	ld a, $1e ; $43cf
	farcall FarPtr_08_40 ; $43d1
	farcall FarPtr_09_16 ; $43d4
	ld a, $0f ; $43d7
	farcall FarPtr_08_40 ; $43d9
Label_0b_43dc:
	farcall FarPtr_09_0a ; $43dc
	ld a, $0a ; $43df
	farcall FarPtr_08_40 ; $43e1
	ld a, $0a ; $43e4
	farcall FarPtr_08_42 ; $43e6
	farcall FarPtr_09_26 ; $43e9
	ld a, $0a ; $43ec
	farcall FarPtr_08_40 ; $43ee
	ld a, $1e ; $43f1
	farcall FarPtr_08_42 ; $43f3
	farcall FarPtr_09_0c ; $43f6
	ld a, $46 ; $43f9
	farcall FarPtr_08_42 ; $43fb
	ld a, $08 ; $43fe
	farcall FarPtr_08_40 ; $4400
	ret ; $4403
Func_0b_4404:
	ld b, a ; $4404
	ld c, $02 ; $4405
	farcall FarPtr_02_18 ; $4407
	ldh a, [$ff96] ; $440a
	push af ; $440c
	ld a, $05 ; $440d
	ldh [$ff96], a ; $440f
	ldh [rWBK], a ; $4411
	farcall FarPtr_07_44 ; $4413
	pop af ; $4416
	ldh [$ff96], a ; $4417
	ldh [rWBK], a ; $4419
	ret ; $441b
	INCBIN "data/bank_00b/d_441c.bin" ; $441c, 43 bytes
Func_0b_4447:
	ld b, a ; $4447
	ldh a, [$ff96] ; $4448
	push af ; $444a
	ld a, $04 ; $444b
	add a, b ; $444d
	ld a, a ; $444e
	ldh [$ff96], a ; $444f
	ldh [rWBK], a ; $4451
	ld de, $df00 ; $4453
	ld hl, $0050 ; $4456
	add hl, de ; $4459
	ld a, [hl] ; $445a
	bit 4, a ; $445b
	jr z, Label_0b_4467 ; $445d
	pop af ; $445f
	ldh [$ff96], a ; $4460
	ldh [rWBK], a ; $4462
	ld a, $01 ; $4464
	ret ; $4466
Label_0b_4467:
	pop af ; $4467
	ldh [$ff96], a ; $4468
	ldh [rWBK], a ; $446a
	xor a, a ; $446c
	ret ; $446d
	ldh a, [$ff96] ; $446e
	push af ; $4470
	ld a, $05 ; $4471
	ldh [$ff96], a ; $4473
	ldh [rWBK], a ; $4475
	ld hl, $df57 ; $4477
	ld a, [wPointWinLoseFlag] ; $447a
	ld [hl], a ; $447d
	pop af ; $447e
	ldh [$ff96], a ; $447f
	ldh [rWBK], a ; $4481
	ret ; $4483
	INCBIN "data/bank_00b/d_4484.bin" ; $4484, 176 bytes
Func_0b_4534:
	cp a, $ff ; $4534
	jr z, Label_0b_4541 ; $4536
	ld c, a ; $4538
	ld a, [wCurrentServingPlayer] ; $4539
	or a, a ; $453c
	jr z, Label_0b_4540 ; $453d
	ld a, b ; $453f
Label_0b_4540:
	add a, c ; $4540
Label_0b_4541:
	ld [$c2e6], a ; $4541
	ret ; $4544
	INCBIN "data/bank_00b/d_4545.bin" ; $4545, 47 bytes
Func_0b_4574:
	ld a, [$c2e6] ; $4574
	or a, a ; $4577
	jr nz, Label_0b_457f ; $4578
	ld a, $6c ; $457a
	ld [$c2e6], a ; $457c
Label_0b_457f:
	call Func_0b_4583 ; $457f
	ret ; $4582
Func_0b_4583:
	cp a, $ff ; $4583
	ret z ; $4585
	ld h, $00 ; $4586
	ld l, a ; $4588
	add hl, hl ; $4589
	ld de, $45c4 ; $458a
	add hl, de ; $458d
	ld a, [hl+] ; $458e
	ld b, [hl] ; $458f
	ld c, a ; $4590
	ld h, b ; $4591
	ld l, c ; $4592
	xor a, a ; $4593
	farcall FarPtr_05_44 ; $4594
	ld b, h ; $4597
	ld c, l ; $4598
	farcall FarPtr_05_26 ; $4599
	ld h, b ; $459c
	ld l, c ; $459d
	add a, $02 ; $459e
	ld b, a ; $45a0
	ldh a, [$ff96] ; $45a1
	push af ; $45a3
	ld a, $05 ; $45a4
	ldh [$ff96], a ; $45a6
	ldh [rWBK], a ; $45a8
	ld a, [$d86f] ; $45aa
	ld e, a ; $45ad
	pop af ; $45ae
	ldh [$ff96], a ; $45af
	ldh [rWBK], a ; $45b1
	ld a, e ; $45b3
	add a, a ; $45b4
	inc a ; $45b5
	ld c, a ; $45b6
	ld d, b ; $45b7
	ld a, $14 ; $45b8
	sub a, d ; $45ba
	srl a ; $45bb
	ld d, a ; $45bd
	ld e, $06 ; $45be
	farcall FarPtr_06_04 ; $45c0
	ret ; $45c3
	INCBIN "data/bank_00b/d_45c4.bin" ; $45c4, 321 bytes
Func_0b_4705:
	push af ; $4705
	farcall FarPtr_08_06 ; $4706
	pop af ; $4709
	cp a, $24 ; $470a
	jp z, Label_0b_47ae ; $470c
	cp a, $12 ; $470f
	jr nc, Label_0b_4723 ; $4711
	ld l, a ; $4713
	ld h, $00 ; $4714
	add hl, hl ; $4716
	ld de, $47b4 ; $4717
	add hl, de ; $471a
	ld a, [hl+] ; $471b
	ld b, [hl] ; $471c
	ld c, a ; $471d
	call Func_0b_4002 ; $471e
	jr Label_0b_4726 ; $4721
Label_0b_4723:
	farcall FarPtr_0d_00 ; $4723
Label_0b_4726:
	ld hl, $c2e0 ; $4726
	ld c, $02 ; $4729
	call ClearMemory16 ; $472b
	ld a, $ff ; $472e
	ld [$c7b5], a ; $4730
	xor a, a ; $4733
	ld hl, $c7b6 ; $4734
	ld [hl+], a ; $4737
	ld [hl], a ; $4738
	ld [$c7a8], a ; $4739
	farcall FarPtr_08_08 ; $473c
Label_0b_473f:
	xor a, a ; $473f
	ldh [$ff8b], a ; $4740
	ldh [$ff8a], a ; $4742
	ld a, $ff ; $4744
	ld [$c7b5], a ; $4746
	xor a, a ; $4749
	ld hl, $c7b6 ; $474a
	ld [hl+], a ; $474d
	ld [hl], a ; $474e
	ld [$c7a8], a ; $474f
	ld a, [$c4de] ; $4752
	or a, a ; $4755
	ld a, [$c8f7] ; $4756
	jp nz, Func_0b_4705 ; $4759
	ld a, [$c4c7] ; $475c
	or a, a ; $475f
	jr z, Label_0b_4767 ; $4760
	ld a, $ff ; $4762
	ld [wPointWinLoseFlag], a ; $4764
Label_0b_4767:
	rst30 $03c0 ; $4767
	jr z, Label_0b_47a7 ; $476a
	call DisableLCDSafely ; $476c
	farcall FarPtr_05_76 ; $476f
	call Func_0b_47d8 ; $4772
	farcall FarPtr_01_0a ; $4775
	call EnableLCD ; $4778
	ld c, $08 ; $477b
	call Func_00_1d2e ; $477d
	call Func_00_1da4 ; $4780
	ld a, [$c2e3] ; $4783
	ld l, a ; $4786
	ld h, $00 ; $4787
	farcall FarPtr_05_48 ; $4789
	ld a, [wPointWinLoseFlag] ; $478c
	inc a ; $478f
	srl a ; $4790
	ld hl, $015f ; $4792
	add a, l ; $4795
	ld l, a ; $4796
	jr nc, Label_0b_479a ; $4797
	inc h ; $4799
Label_0b_479a:
	ld a, $80 ; $479a
	farcall FarPtr_05_34 ; $479c
	ld c, $10 ; $479f
	call Func_00_1d20 ; $47a1
	call Func_00_1da4 ; $47a4
Label_0b_47a7:
	rst28 $03c0 ; $47a7
	farcall FarPtr_1e_04 ; $47aa
	ret ; $47ad
Label_0b_47ae:
	call Func_0b_7258 ; $47ae
	jp Label_0b_473f ; $47b1
	INCBIN "data/bank_00b/d_47b4.bin" ; $47b4, 36 bytes
Func_0b_47d8:
	call DisableLCDSafely ; $47d8
	ld a, $02 ; $47db
	ldh [$ff96], a ; $47dd
	ldh [rWBK], a ; $47df
	ld a, $00 ; $47e1
	ld hl, $d000 ; $47e3
	ld bc, $0500 ; $47e6
	call Func_0b_4823 ; $47e9
	ld a, $03 ; $47ec
	ldh [$ff96], a ; $47ee
	ldh [rWBK], a ; $47f0
	ld a, $20 ; $47f2
	ld hl, $d000 ; $47f4
	ld bc, $0500 ; $47f7
	call Func_0b_4823 ; $47fa
	ld a, $03 ; $47fd
	ldh [$ff96], a ; $47ff
	ldh [rWBK], a ; $4801
	ld hl, $d000 ; $4803
	ld de, $9800 ; $4806
	ld c, $24 ; $4809
	call Func_00_0480 ; $480b
	ld a, $02 ; $480e
	ldh [$ff96], a ; $4810
	ldh [rWBK], a ; $4812
	ld hl, $d000 ; $4814
	ld de, $b800 ; $4817
	ld c, $24 ; $481a
	call Func_00_0480 ; $481c
	call EnableLCD ; $481f
	ret ; $4822
Func_0b_4823:
	ld e, a ; $4823
Label_0b_4824:
	ld [hl], e ; $4824
	inc hl ; $4825
	dec bc ; $4826
	ld a, c ; $4827
	or a, b ; $4828
	jr nz, Label_0b_4824 ; $4829
	ret ; $482b
	INCBIN "data/bank_00b/d_482c.bin" ; $482c, 226 bytes
	ret ; $490e
	INCBIN "data/bank_00b/d_490f.bin" ; $490f, 4827 bytes
	ld a, $01 ; $5bea
	ld [$c7bb], a ; $5bec
	ret ; $5bef
	INCBIN "data/bank_00b/d_5bf0.bin" ; $5bf0, 16 bytes
	xor a, a ; $5c00
	ld [$c2e9], a ; $5c01
	ld [$c2ea], a ; $5c04
	ld [$c2eb], a ; $5c07
	ld a, $04 ; $5c0a
	ld [$c2ec], a ; $5c0c
	ld a, $01 ; $5c0f
	ld [$c7bb], a ; $5c11
	ret ; $5c14
	call Func_0b_41c3 ; $5c15
	ret ; $5c18
	xor a, a ; $5c19
	ld [$c2e1], a ; $5c1a
	ld a, $0a ; $5c1d
	ld [$c2e0], a ; $5c1f
	xor a, a ; $5c22
	ld [$c2ed], a ; $5c23
	ld a, $01 ; $5c26
	ld [$c78c], a ; $5c28
	ld hl, $5cd7 ; $5c2b
	call Func_0b_4191 ; $5c2e
	ld a, $40 ; $5c31
	call Func_0b_4404 ; $5c33
	xor a, a ; $5c36
	ld [$c2e6], a ; $5c37
	xor a, a ; $5c3a
	ld [$c2ff], a ; $5c3b
	ld a, [wTotalPointsScoredInCurrentGame] ; $5c3e
	ld hl, $5c4e ; $5c41
	add a, l ; $5c44
	ld l, a ; $5c45
	jr nc, Label_0b_5c49 ; $5c46
	inc h ; $5c48
Label_0b_5c49:
	ld a, [hl] ; $5c49
	ld [$c7b5], a ; $5c4a
	ret ; $5c4d
	INCBIN "data/bank_00b/d_5c4e.bin" ; $5c4e, 4 bytes
	call Func_0b_5d48 ; $5c52
	ld a, [$c4d8] ; $5c55
	cp a, $04 ; $5c58
	jr z, Label_0b_5c62 ; $5c5a
	cp a, $05 ; $5c5c
	jr z, Label_0b_5c62 ; $5c5e
	jr Label_0b_5c66 ; $5c60
Label_0b_5c62:
	ld hl, $c2e9 ; $5c62
	inc [hl] ; $5c65
Label_0b_5c66:
	call Func_0b_5cf9 ; $5c66
	ld a, [wTotalPointsScoredInCurrentGame] ; $5c69
	cp a, $04 ; $5c6c
	ret c ; $5c6e
	call Func_0b_5c76 ; $5c6f
	ld [wPointWinLoseFlag], a ; $5c72
	ret ; $5c75
Func_0b_5c76:
	ld a, [$c2eb] ; $5c76
	cp a, $04 ; $5c79
	jr nz, Label_0b_5c84 ; $5c7b
	xor a, a ; $5c7d
	ld [$c2e3], a ; $5c7e
	ld a, $01 ; $5c81
	ret ; $5c83
Label_0b_5c84:
	ld a, [wCharacter1DoubleFaults] ; $5c84
	cp a, $04 ; $5c87
	jr nz, Label_0b_5c92 ; $5c89
	ld a, $01 ; $5c8b
	ld [$c2e3], a ; $5c8d
	jr Label_0b_5cbe ; $5c90
Label_0b_5c92:
	or a, a ; $5c92
	jr z, Label_0b_5c9c ; $5c93
	ld a, $02 ; $5c95
	ld [$c2e3], a ; $5c97
	jr Label_0b_5cbe ; $5c9a
Label_0b_5c9c:
	ld a, [$c2eb] ; $5c9c
	cp a, $03 ; $5c9f
	jr nz, Label_0b_5caa ; $5ca1
	ld a, $05 ; $5ca3
	ld [$c2e3], a ; $5ca5
	jr Label_0b_5cbe ; $5ca8
Label_0b_5caa:
	ld a, [$c2ec] ; $5caa
	or a, a ; $5cad
	jr nz, Label_0b_5cb7 ; $5cae
	ld a, $04 ; $5cb0
	ld [$c2e3], a ; $5cb2
	jr Label_0b_5cbe ; $5cb5
Label_0b_5cb7:
	ld a, $03 ; $5cb7
	ld [$c2e3], a ; $5cb9
	jr Label_0b_5cbe ; $5cbc
Label_0b_5cbe:
	ld a, $ff ; $5cbe
	ret ; $5cc0
	call Func_0b_5d63 ; $5cc1
	ret ; $5cc4
	call Func_0b_5d5a ; $5cc5
	ret ; $5cc8
	call Func_0b_5d51 ; $5cc9
	ld a, [$c4b8] ; $5ccc
	cp a, $01 ; $5ccf
	jr nz, Label_0b_5cd6 ; $5cd1
	call Func_0b_414b ; $5cd3
Label_0b_5cd6:
	ret ; $5cd6
	INCBIN "data/bank_00b/d_5cd7.bin" ; $5cd7, 34 bytes
Func_0b_5cf9:
	farcall FarPtr_09_26 ; $5cf9
	ld a, [$c2ff] ; $5cfc
	ld [wPointWinLoseFlag], a ; $5cff
	cp a, $01 ; $5d02
	jr nz, Label_0b_5d0a ; $5d04
	ld hl, $c2eb ; $5d06
	inc [hl] ; $5d09
Label_0b_5d0a:
	call Func_0b_407b ; $5d0a
	call Func_0b_4574 ; $5d0d
	farcall FarPtr_08_5a ; $5d10
	farcall FarPtr_08_5c ; $5d13
	ld a, [$c2eb] ; $5d16
	ld [wPlayer1PointsWon], a ; $5d19
	xor a, a ; $5d1c
	ld [wPlayer2PointsWon], a ; $5d1d
	ld a, [wPlayer1PointsWon] ; $5d20
	ld b, $01 ; $5d23
	farcall FarPtr_09_2a ; $5d25
	ld a, [wPlayer2PointsWon] ; $5d28
	ld b, $01 ; $5d2b
	farcall FarPtr_09_2c ; $5d2d
	farcall FarPtr_08_3e ; $5d30
	ld a, $01 ; $5d33
	ld hl, $446e ; $5d35
	call Func_00_1b6a ; $5d38
	farcall FarPtr_08_5e ; $5d3b
	ld hl, $446e ; $5d3e
	call Func_00_1bcb ; $5d41
	call Func_0b_43a6 ; $5d44
	ret ; $5d47
Func_0b_5d48:
	ld a, $00 ; $5d48
	call Func_0b_5d6d ; $5d4a
	ld [$c2ff], a ; $5d4d
	ret ; $5d50
Func_0b_5d51:
	ld a, $01 ; $5d51
	call Func_0b_5d6d ; $5d53
	ld [$c2ff], a ; $5d56
	ret ; $5d59
Func_0b_5d5a:
	ld a, $02 ; $5d5a
	call Func_0b_5d6d ; $5d5c
	ld [$c2ff], a ; $5d5f
	ret ; $5d62
Func_0b_5d63:
	ret ; $5d63
	INCBIN "data/bank_00b/d_5d64.bin" ; $5d64, 9 bytes
Func_0b_5d6d:
	ld b, a ; $5d6d
	ld a, [$c2ff] ; $5d6e
	or a, a ; $5d71
	ret nz ; $5d72
	ld a, [wRallyLength] ; $5d73
	dec a ; $5d76
	ld a, a ; $5d77
	rst Rst00 ; $5d78
	dw Label_0b_5d7f ; $5d79 jumptable
	dw Label_0b_5db9 ; $5d7b jumptable
	dw Label_0b_5df3 ; $5d7d jumptable
Label_0b_5d7f:
	ld a, b ; $5d7f
	ld a, a ; $5d80
	rst Rst00 ; $5d81
	dw Label_0b_5d8a ; $5d82 jumptable
	dw Label_0b_5db3 ; $5d84 jumptable
	dw Label_0b_5db5 ; $5d86 jumptable
	dw Label_0b_5db7 ; $5d88 jumptable
Label_0b_5d8a:
	ld a, [$c4d8] ; $5d8a
	ld hl, $5da9 ; $5d8d
	add a, l ; $5d90
	ld l, a ; $5d91
	jr nc, Label_0b_5d95 ; $5d92
	inc h ; $5d94
Label_0b_5d95:
	ld a, [hl] ; $5d95
	ld a, a ; $5d96
	ld b, $00 ; $5d97
	call Func_0b_4534 ; $5d99
	ld a, [$c4d8] ; $5d9c
	ld hl, $46f1 ; $5d9f
	add a, l ; $5da2
	ld l, a ; $5da3
	jr nc, Label_0b_5da7 ; $5da4
	inc h ; $5da6
Label_0b_5da7:
	ld a, [hl] ; $5da7
	ret ; $5da8
	INCBIN "data/bank_00b/d_5da9.bin" ; $5da9, 10 bytes
Label_0b_5db3:
	xor a, a ; $5db3
	ret ; $5db4
Label_0b_5db5:
	xor a, a ; $5db5
	ret ; $5db6
Label_0b_5db7:
	xor a, a ; $5db7
	ret ; $5db8
Label_0b_5db9:
	ld a, b ; $5db9
	ld a, a ; $5dba
	rst Rst00 ; $5dbb
	dw Label_0b_5dc4 ; $5dbc jumptable
	dw Label_0b_5ded ; $5dbe jumptable
	dw Label_0b_5def ; $5dc0 jumptable
	dw Label_0b_5df1 ; $5dc2 jumptable
Label_0b_5dc4:
	ld a, [$c4d8] ; $5dc4
	ld hl, $5de3 ; $5dc7
	add a, l ; $5dca
	ld l, a ; $5dcb
	jr nc, Label_0b_5dcf ; $5dcc
	inc h ; $5dce
Label_0b_5dcf:
	ld a, [hl] ; $5dcf
	ld a, a ; $5dd0
	ld b, $00 ; $5dd1
	call Func_0b_4534 ; $5dd3
	ld a, [$c4d8] ; $5dd6
	ld hl, $46fb ; $5dd9
	add a, l ; $5ddc
	ld l, a ; $5ddd
	jr nc, Label_0b_5de1 ; $5dde
	inc h ; $5de0
Label_0b_5de1:
	ld a, [hl] ; $5de1
	ret ; $5de2
	INCBIN "data/bank_00b/d_5de3.bin" ; $5de3, 10 bytes
Label_0b_5ded:
	xor a, a ; $5ded
	ret ; $5dee
Label_0b_5def:
	xor a, a ; $5def
	ret ; $5df0
Label_0b_5df1:
	xor a, a ; $5df1
	ret ; $5df2
Label_0b_5df3:
	ld a, b ; $5df3
	ld a, a ; $5df4
	rst Rst00 ; $5df5
	dw Label_0b_5dfe ; $5df6 jumptable
	dw Label_0b_5e31 ; $5df8 jumptable
	dw Label_0b_5e55 ; $5dfa jumptable
	dw Label_0b_5e83 ; $5dfc jumptable
Label_0b_5dfe:
	ld a, [$c4d8] ; $5dfe
	ld hl, $5e27 ; $5e01
	add a, l ; $5e04
	ld l, a ; $5e05
	jr nc, Label_0b_5e09 ; $5e06
	inc h ; $5e08
Label_0b_5e09:
	ld a, [hl] ; $5e09
	ld a, a ; $5e0a
	ld b, $00 ; $5e0b
	call Func_0b_4534 ; $5e0d
	ld a, [$c4d8] ; $5e10
	ld hl, $5e1d ; $5e13
	add a, l ; $5e16
	ld l, a ; $5e17
	jr nc, Label_0b_5e1b ; $5e18
	inc h ; $5e1a
Label_0b_5e1b:
	ld a, [hl] ; $5e1b
	ret ; $5e1c
	INCBIN "data/bank_00b/d_5e1d.bin" ; $5e1d, 20 bytes
Label_0b_5e31:
	ld a, $35 ; $5e31
	ld b, $00 ; $5e33
	call Func_0b_4534 ; $5e35
	xor a, a ; $5e38
	call Func_0b_4447 ; $5e39
	or a, a ; $5e3c
	jp z, Label_0b_5e8d ; $5e3d
	ld a, $3a ; $5e40
	ld b, $00 ; $5e42
	call Func_0b_4534 ; $5e44
	ld a, [$c4a1] ; $5e47
	cp a, $01 ; $5e4a
	jp nz, Label_0b_5e8d ; $5e4c
	ld hl, $c2ec ; $5e4f
	dec [hl] ; $5e52
	xor a, a ; $5e53
	ret ; $5e54
Label_0b_5e55:
	ld a, [$c4b2] ; $5e55
	cp a, $01 ; $5e58
	ld a, $00 ; $5e5a
	ret nz ; $5e5c
	ld a, [$c4d8] ; $5e5d
	cp a, $04 ; $5e60
	jr z, Label_0b_5e75 ; $5e62
	ld a, $2e ; $5e64
	ld b, $00 ; $5e66
	call Func_0b_4534 ; $5e68
	call Func_0b_41e6 ; $5e6b
	call Func_0b_421c ; $5e6e
	or a, a ; $5e71
	jp nz, Label_0b_5e85 ; $5e72
Label_0b_5e75:
	ld a, $38 ; $5e75
	ld b, $00 ; $5e77
	call Func_0b_4534 ; $5e79
	ld hl, $c2ea ; $5e7c
	inc [hl] ; $5e7f
	jp Label_0b_5e8d ; $5e80
Label_0b_5e83:
	xor a, a ; $5e83
	ret ; $5e84
Label_0b_5e85:
	ld a, $01 ; $5e85
	ld [$c4c3], a ; $5e87
	ld a, $01 ; $5e8a
	ret ; $5e8c
Label_0b_5e8d:
	ld a, $01 ; $5e8d
	ld [$c4c3], a ; $5e8f
	ld a, $ff ; $5e92
	ret ; $5e94
	INCBIN "data/bank_00b/d_5e95.bin" ; $5e95, 3288 bytes
	ld a, $01 ; $6b6d
	ld [$c7bb], a ; $6b6f
	ret ; $6b72
	INCBIN "data/bank_00b/d_6b73.bin" ; $6b73, 16 bytes
	ld a, $01 ; $6b83
	ld [$c7bb], a ; $6b85
	xor a, a ; $6b88
	ld [$c2e9], a ; $6b89
	ld [$c2e8], a ; $6b8c
	ret ; $6b8f
	call Func_0b_41c3 ; $6b90
	ret ; $6b93
	xor a, a ; $6b94
	ld [$c2e1], a ; $6b95
	ld a, $0a ; $6b98
	ld [$c2e0], a ; $6b9a
	xor a, a ; $6b9d
	ld [$c78c], a ; $6b9e
	ld hl, $6c5f ; $6ba1
	call Func_0b_4191 ; $6ba4
	xor a, a ; $6ba7
	ld [$c2e6], a ; $6ba8
	xor a, a ; $6bab
	ld [$c2ff], a ; $6bac
	ld a, $5a ; $6baf
	ld [$c2ef], a ; $6bb1
	ld a, $01 ; $6bb4
	ld hl, $6bd0 ; $6bb6
	call Func_00_1b6a ; $6bb9
	ld a, [wTotalPointsScoredInCurrentGame] ; $6bbc
	ld hl, $6bcc ; $6bbf
	add a, l ; $6bc2
	ld l, a ; $6bc3
	jr nc, Label_0b_6bc7 ; $6bc4
	inc h ; $6bc6
Label_0b_6bc7:
	ld a, [hl] ; $6bc7
	ld [$c7b5], a ; $6bc8
	ret ; $6bcb
	INCBIN "data/bank_00b/d_6bcc.bin" ; $6bcc, 4 bytes
	ld hl, $c2ef ; $6bd0
	dec [hl] ; $6bd3
	ret nz ; $6bd4
	ld a, $01 ; $6bd5
	ld [$c78c], a ; $6bd7
	ld hl, $6bd0 ; $6bda
	call Func_00_1bcb ; $6bdd
	ret ; $6be0
	call Func_0b_6cd0 ; $6be1
	ld a, [$c4d8] ; $6be4
	cp a, $05 ; $6be7
	jr z, Label_0b_6bed ; $6be9
	jr Label_0b_6bf1 ; $6beb
Label_0b_6bed:
	ld hl, $c2e8 ; $6bed
	inc [hl] ; $6bf0
Label_0b_6bf1:
	call Func_0b_6c81 ; $6bf1
	ld a, [wTotalPointsScoredInCurrentGame] ; $6bf4
	cp a, $04 ; $6bf7
	ret c ; $6bf9
	call Func_0b_6c01 ; $6bfa
	ld [wPointWinLoseFlag], a ; $6bfd
	ret ; $6c00
Func_0b_6c01:
	ld a, [$c2e9] ; $6c01
	cp a, $04 ; $6c04
	jr nz, Label_0b_6c0f ; $6c06
	xor a, a ; $6c08
	ld [$c2e3], a ; $6c09
	ld a, $01 ; $6c0c
	ret ; $6c0e
Label_0b_6c0f:
	ld a, [$c2e8] ; $6c0f
	cp a, $04 ; $6c12
	jr c, Label_0b_6c1d ; $6c14
	ld a, $01 ; $6c16
	ld [$c2e3], a ; $6c18
	jr Label_0b_6c47 ; $6c1b
Label_0b_6c1d:
	cp a, $02 ; $6c1d
	jr c, Label_0b_6c28 ; $6c1f
	ld a, $02 ; $6c21
	ld [$c2e3], a ; $6c23
	jr Label_0b_6c47 ; $6c26
Label_0b_6c28:
	ld a, [$c2e9] ; $6c28
	or a, a ; $6c2b
	jr nz, Label_0b_6c35 ; $6c2c
	ld a, $03 ; $6c2e
	ld [$c2e3], a ; $6c30
	jr Label_0b_6c47 ; $6c33
Label_0b_6c35:
	cp a, $03 ; $6c35
	jr nz, Label_0b_6c40 ; $6c37
	ld a, $05 ; $6c39
	ld [$c2e3], a ; $6c3b
	jr Label_0b_6c47 ; $6c3e
Label_0b_6c40:
	ld a, $04 ; $6c40
	ld [$c2e3], a ; $6c42
	jr Label_0b_6c47 ; $6c45
Label_0b_6c47:
	ld a, $ff ; $6c47
	ret ; $6c49
	call Func_0b_6ceb ; $6c4a
	ret ; $6c4d
	call Func_0b_6ce2 ; $6c4e
	ret ; $6c51
	call Func_0b_6cd9 ; $6c52
	ld a, [wRallyLength] ; $6c55
	cp a, $01 ; $6c58
	ret nz ; $6c5a
	call Func_0b_414b ; $6c5b
	ret ; $6c5e
	INCBIN "data/bank_00b/d_6c5f.bin" ; $6c5f, 34 bytes
Func_0b_6c81:
	farcall FarPtr_09_26 ; $6c81
	ld a, [$c2ff] ; $6c84
	ld [wPointWinLoseFlag], a ; $6c87
	cp a, $01 ; $6c8a
	jr nz, Label_0b_6c92 ; $6c8c
	ld hl, $c2e9 ; $6c8e
	inc [hl] ; $6c91
Label_0b_6c92:
	call Func_0b_407b ; $6c92
	call Func_0b_4574 ; $6c95
	farcall FarPtr_08_5a ; $6c98
	farcall FarPtr_08_5c ; $6c9b
	ld a, [$c2e9] ; $6c9e
	ld [wPlayer1PointsWon], a ; $6ca1
	xor a, a ; $6ca4
	ld [wPlayer2PointsWon], a ; $6ca5
	ld a, [wPlayer1PointsWon] ; $6ca8
	ld b, $01 ; $6cab
	farcall FarPtr_09_2a ; $6cad
	ld a, [wPlayer2PointsWon] ; $6cb0
	ld b, $01 ; $6cb3
	farcall FarPtr_09_2c ; $6cb5
	farcall FarPtr_08_3e ; $6cb8
	ld a, $01 ; $6cbb
	ld hl, $446e ; $6cbd
	call Func_00_1b6a ; $6cc0
	farcall FarPtr_08_5e ; $6cc3
	ld hl, $446e ; $6cc6
	call Func_00_1bcb ; $6cc9
	call Func_0b_43a6 ; $6ccc
	ret ; $6ccf
Func_0b_6cd0:
	ld a, $00 ; $6cd0
	call Func_0b_6cf5 ; $6cd2
	ld [$c2ff], a ; $6cd5
	ret ; $6cd8
Func_0b_6cd9:
	ld a, $01 ; $6cd9
	call Func_0b_6cf5 ; $6cdb
	ld [$c2ff], a ; $6cde
	ret ; $6ce1
Func_0b_6ce2:
	ld a, $02 ; $6ce2
	call Func_0b_6cf5 ; $6ce4
	ld [$c2ff], a ; $6ce7
	ret ; $6cea
Func_0b_6ceb:
	ret ; $6ceb
	INCBIN "data/bank_00b/d_6cec.bin" ; $6cec, 9 bytes
Func_0b_6cf5:
	ld b, a ; $6cf5
	ld a, [$c2ff] ; $6cf6
	or a, a ; $6cf9
	ret nz ; $6cfa
	ld a, [wRallyLength] ; $6cfb
	dec a ; $6cfe
	ld a, a ; $6cff
	rst Rst00 ; $6d00
	dw Label_0b_6d05 ; $6d01 jumptable
	dw Label_0b_6d3f ; $6d03 jumptable
Label_0b_6d05:
	ld a, b ; $6d05
	ld a, a ; $6d06
	rst Rst00 ; $6d07
	dw Label_0b_6d10 ; $6d08 jumptable
	dw Label_0b_6d39 ; $6d0a jumptable
	dw Label_0b_6d3b ; $6d0c jumptable
	dw Label_0b_6d3d ; $6d0e jumptable
Label_0b_6d10:
	ld a, [$c4d8] ; $6d10
	ld hl, $6d2f ; $6d13
	add a, l ; $6d16
	ld l, a ; $6d17
	jr nc, Label_0b_6d1b ; $6d18
	inc h ; $6d1a
Label_0b_6d1b:
	ld a, [hl] ; $6d1b
	ld a, a ; $6d1c
	ld b, $00 ; $6d1d
	call Func_0b_4534 ; $6d1f
	ld a, [$c4d8] ; $6d22
	ld hl, $46fb ; $6d25
	add a, l ; $6d28
	ld l, a ; $6d29
	jr nc, Label_0b_6d2d ; $6d2a
	inc h ; $6d2c
Label_0b_6d2d:
	ld a, [hl] ; $6d2d
	ret ; $6d2e
	INCBIN "data/bank_00b/d_6d2f.bin" ; $6d2f, 10 bytes
Label_0b_6d39:
	xor a, a ; $6d39
	ret ; $6d3a
Label_0b_6d3b:
	xor a, a ; $6d3b
	ret ; $6d3c
Label_0b_6d3d:
	xor a, a ; $6d3d
	ret ; $6d3e
Label_0b_6d3f:
	ld a, b ; $6d3f
	ld a, a ; $6d40
	rst Rst00 ; $6d41
	dw Label_0b_6d4a ; $6d42 jumptable
	dw Label_0b_6d73 ; $6d44 jumptable
	dw Label_0b_6d75 ; $6d46 jumptable
	dw Label_0b_6d9c ; $6d48 jumptable
Label_0b_6d4a:
	ld a, [$c4d8] ; $6d4a
	ld hl, $6d69 ; $6d4d
	add a, l ; $6d50
	ld l, a ; $6d51
	jr nc, Label_0b_6d55 ; $6d52
	inc h ; $6d54
Label_0b_6d55:
	ld a, [hl] ; $6d55
	ld a, a ; $6d56
	ld b, $00 ; $6d57
	call Func_0b_4534 ; $6d59
	ld a, [$c4d8] ; $6d5c
	ld hl, $46f1 ; $6d5f
	add a, l ; $6d62
	ld l, a ; $6d63
	jr nc, Label_0b_6d67 ; $6d64
	inc h ; $6d66
Label_0b_6d67:
	ld a, [hl] ; $6d67
	ret ; $6d68
	INCBIN "data/bank_00b/d_6d69.bin" ; $6d69, 10 bytes
Label_0b_6d73:
	xor a, a ; $6d73
	ret ; $6d74
Label_0b_6d75:
	ld a, [$c4b2] ; $6d75
	cp a, $01 ; $6d78
	ld a, $00 ; $6d7a
	ret nz ; $6d7c
	ld a, $57 ; $6d7d
	ld b, $00 ; $6d7f
	call Func_0b_4534 ; $6d81
	call Func_0b_41e6 ; $6d84
	call Func_0b_421c ; $6d87
	or a, a ; $6d8a
	jp nz, Label_0b_6d9e ; $6d8b
	ld a, $5a ; $6d8e
	ld b, $00 ; $6d90
	call Func_0b_4534 ; $6d92
	ld hl, $c2ea ; $6d95
	inc [hl] ; $6d98
	jp Label_0b_6da6 ; $6d99
Label_0b_6d9c:
	xor a, a ; $6d9c
	ret ; $6d9d
Label_0b_6d9e:
	ld a, $01 ; $6d9e
	ld [$c4c3], a ; $6da0
	ld a, $01 ; $6da3
	ret ; $6da5
Label_0b_6da6:
	ld a, $01 ; $6da6
	ld [$c4c3], a ; $6da8
	ld a, $ff ; $6dab
	ret ; $6dad
	INCBIN "data/bank_00b/d_6dae.bin" ; $6dae, 916 bytes
	farcall FarPtr_08_5a ; $7142
	farcall FarPtr_08_5c ; $7145
	ld a, [$c2e9] ; $7148
	ld [wPlayer1PointsWon], a ; $714b
	xor a, a ; $714e
	ld [wPlayer2PointsWon], a ; $714f
	ld a, [wPlayer1PointsWon] ; $7152
	ld b, $01 ; $7155
	farcall FarPtr_09_2a ; $7157
	ld a, [wPlayer2PointsWon] ; $715a
	ld b, $01 ; $715d
	farcall FarPtr_09_2c ; $715f
	farcall FarPtr_08_3e ; $7162
	ld a, $01 ; $7165
	ld hl, $446e ; $7167
	call Func_00_1b6a ; $716a
	farcall FarPtr_08_5e ; $716d
	ld hl, $446e ; $7170
	call Func_00_1bcb ; $7173
	call Func_0b_43a6 ; $7176
	ret ; $7179
	INCBIN "data/bank_00b/d_717a.bin" ; $717a, 222 bytes
Func_0b_7258:
	xor a, a ; $7258
	ld [$c8f5], a ; $7259
	ld a, $08 ; $725c
	ld [wGameMode], a ; $725e
	ld a, $02 ; $7261
	ld [wCurrentMinigameStoryMatch], a ; $7263
	ld a, $24 ; $7266
	ld [$c8f7], a ; $7268
	ld a, $15 ; $726b
	ld [$c8f8], a ; $726d
	ld a, $01 ; $7270
	ld [$c8f2], a ; $7272
	ld a, $03 ; $7275
	ld [$c8f3], a ; $7277
	ld a, $17 ; $727a
	ld [wCurrentlyUsedCourt], a ; $727c
	ld b, $1d ; $727f
	ld a, b ; $7281
	ld [$c3b0], a ; $7282
	ld c, $00 ; $7285
	farcall FarPtr_02_18 ; $7287
	ld b, $1b ; $728a
	ld a, b ; $728c
	ld [$c3b1], a ; $728d
	ld c, $02 ; $7290
	farcall FarPtr_02_18 ; $7292
	ld b, $1e ; $7295
	ld c, $03 ; $7297
	farcall FarPtr_02_18 ; $7299
	ld a, [wMinigameLevel] ; $729c
	add a, a ; $729f
	add a, $e0 ; $72a0
	ld l, a ; $72a2
	adc a, $72 ; $72a3
	sub a, l ; $72a5
	ld h, a ; $72a6
	ld a, [hl+] ; $72a7
	ld h, [hl] ; $72a8
	ld l, a ; $72a9
	ld a, [hl+] ; $72aa
	ld [wMatchTypeNumberOfGames], a ; $72ab
	ld a, [hl+] ; $72ae
	ld [wMatchTypeNumberOfSets], a ; $72af
	push hl ; $72b2
	ld a, [hl+] ; $72b3
	ld [$ca9b], a ; $72b4
	ld a, [hl+] ; $72b7
	ld [$ca9c], a ; $72b8
	ld a, [hl+] ; $72bb
	ld [$ca9d], a ; $72bc
	ld a, [hl+] ; $72bf
	ld [$ca9e], a ; $72c0
	ld a, [hl+] ; $72c3
	ld [wExhibitionModeCPUMainCharacterDifficulty], a ; $72c4
	pop hl ; $72c7
	ld a, [hl+] ; $72c8
	ld [$cadb], a ; $72c9
	ld a, [hl+] ; $72cc
	ld [$cadc], a ; $72cd
	ld a, [hl+] ; $72d0
	ld [$cadd], a ; $72d1
	ld a, [hl+] ; $72d4
	ld [$cade], a ; $72d5
	ld a, [hl+] ; $72d8
	ld [wExhibitionModeCPUPartnerCharacterDifficulty], a ; $72d9
	farcall FarPtr_08_04 ; $72dc
	ret ; $72df
	INCBIN "data/bank_00b/d_72e0.bin" ; $72e0, 3360 bytes
