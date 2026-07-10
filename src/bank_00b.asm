INCLUDE "hardware.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $0b", ROMX[$4000], BANK[$0b]

	INCBIN "data/bank_00b/d_4000.bin" ; $4000, 2 bytes
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
	rst Rst18 ; $403f
	jr Label_0b_4044 ; $4040
	INCBIN "data/bank_00b/d_4042.bin" ; $4042, 2 bytes
Label_0b_4044:
	ret ; $4044
	INCBIN "data/bank_00b/d_4045.bin" ; $4045, 865 bytes
Func_0b_43a6:
	ld hl, $c442 ; $43a6
	ld a, [hl+] ; $43a9
	ld d, [hl] ; $43aa
	ld e, a ; $43ab
	ld hl, $c440 ; $43ac
	ld a, [hl+] ; $43af
	ld h, [hl] ; $43b0
	ld l, a ; $43b1
	rst Rst18 ; $43b2
	ld l, $08 ; $43b3
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
	rst Rst18 ; $43cc
	ld [de], a ; $43cd
	add hl, bc ; $43ce
Label_0b_43cf:
	ld a, $1e ; $43cf
	rst Rst18 ; $43d1
	ld b, b ; $43d2
	ld [$16df], sp ; $43d3
	add hl, bc ; $43d6
	ld a, $0f ; $43d7
	rst Rst18 ; $43d9
	ld b, b ; $43da
	INCBIN "data/bank_00b/d_43db.bin" ; $43db, 1 bytes
Label_0b_43dc:
	rst Rst18 ; $43dc
	ld a, [bc] ; $43dd
	add hl, bc ; $43de
	ld a, $0a ; $43df
	rst Rst18 ; $43e1
	ld b, b ; $43e2
	ld [$0a3e], sp ; $43e3
	rst Rst18 ; $43e6
	ld b, d ; $43e7
	ld [$26df], sp ; $43e8
	add hl, bc ; $43eb
	ld a, $0a ; $43ec
	rst Rst18 ; $43ee
	ld b, b ; $43ef
	ld [$1e3e], sp ; $43f0
	rst Rst18 ; $43f3
	ld b, d ; $43f4
	INCBIN "data/bank_00b/d_43f5.bin" ; $43f5, 1 bytes
	rst Rst18 ; $43f6
	inc c ; $43f7
	add hl, bc ; $43f8
	ld a, $46 ; $43f9
	rst Rst18 ; $43fb
	ld b, d ; $43fc
	ld [$083e], sp ; $43fd
	rst Rst18 ; $4400
	ld b, b ; $4401
	ld [$47c9], sp ; $4402
	ld c, $02 ; $4405
	rst Rst18 ; $4407
	jr Label_0b_440c ; $4408
	INCBIN "data/bank_00b/d_440a.bin" ; $440a, 2 bytes
Label_0b_440c:
	push af ; $440c
	ld a, $05 ; $440d
	ldh [$ff96], a ; $440f
	ldh [rWBK], a ; $4411
	rst Rst18 ; $4413
	ld b, h ; $4414
	rlca ; $4415
	pop af ; $4416
	ldh [$ff96], a ; $4417
	ldh [rWBK], a ; $4419
	ret ; $441b
	INCBIN "data/bank_00b/d_441c.bin" ; $441c, 745 bytes
Label_0b_4705:
	push af ; $4705
	rst Rst18 ; $4706
	ld b, $08 ; $4707
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
	rst Rst18 ; $4723
	nop ; $4724
	dec c ; $4725
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
	rst Rst18 ; $473c
	INCBIN "data/bank_00b/d_473d.bin" ; $473d, 2 bytes
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
	jp nz, Label_0b_4705 ; $4759
	ld a, [$c4c7] ; $475c
	or a, a ; $475f
	jr z, Label_0b_4767 ; $4760
	ld a, $ff ; $4762
	ld [wPointWinLoseFlag], a ; $4764
Label_0b_4767:
	rst Rst30 ; $4767
	ret nz ; $4768
	inc bc ; $4769
	jr z, Label_0b_47a7 ; $476a
	call DisableLCDSafely ; $476c
	rst Rst18 ; $476f
	halt ; $4770
	dec b ; $4771
	call Func_0b_47d8 ; $4772
	rst Rst18 ; $4775
	ld a, [bc] ; $4776
	ld bc, $76cd ; $4777
	inc bc ; $477a
	ld c, $08 ; $477b
	call Func_00_1d2e ; $477d
	call Func_00_1da4 ; $4780
	ld a, [$c2e3] ; $4783
	ld l, a ; $4786
	ld h, $00 ; $4787
	rst Rst18 ; $4789
	ld c, b ; $478a
	dec b ; $478b
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
	rst Rst18 ; $479c
	inc [hl] ; $479d
	dec b ; $479e
	ld c, $10 ; $479f
	call Func_00_1d20 ; $47a1
	call Func_00_1da4 ; $47a4
Label_0b_47a7:
	rst Rst28 ; $47a7
	ret nz ; $47a8
	inc bc ; $47a9
	rst Rst18 ; $47aa
	inc b ; $47ab
	ld e, $c9 ; $47ac
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
	INCBIN "data/bank_00b/d_482c.bin" ; $482c, 10518 bytes
	rst Rst18 ; $7142
	ld e, d ; $7143
	ld [$5cdf], sp ; $7144
	ld [$e9fa], sp ; $7147
	jp nz, $e4ea ; $714a
	ret z ; $714d
	xor a, a ; $714e
	ld [wPlayer2PointsWon], a ; $714f
	ld a, [wPlayer1PointsWon] ; $7152
	ld b, $01 ; $7155
	rst Rst18 ; $7157
	ld a, [hl+] ; $7158
	add hl, bc ; $7159
	ld a, [wPlayer2PointsWon] ; $715a
	ld b, $01 ; $715d
	rst Rst18 ; $715f
	inc l ; $7160
	add hl, bc ; $7161
	rst Rst18 ; $7162
	ld a, $08 ; $7163
	ld a, $01 ; $7165
	ld hl, $446e ; $7167
	call Func_00_1b6a ; $716a
	rst Rst18 ; $716d
	ld e, [hl] ; $716e
	ld [$6e21], sp ; $716f
	ld b, h ; $7172
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
	rst Rst18 ; $7287
	jr Label_0b_728c ; $7288
	INCBIN "data/bank_00b/d_728a.bin" ; $728a, 2 bytes
Label_0b_728c:
	ld a, b ; $728c
	ld [$c3b1], a ; $728d
	ld c, $02 ; $7290
	rst Rst18 ; $7292
	jr Label_0b_7297 ; $7293
	INCBIN "data/bank_00b/d_7295.bin" ; $7295, 2 bytes
Label_0b_7297:
	ld c, $03 ; $7297
	rst Rst18 ; $7299
	jr Label_0b_729e ; $729a
	INCBIN "data/bank_00b/d_729c.bin" ; $729c, 2 bytes
Label_0b_729e:
	jp $c687 ; $729e
	INCBIN "data/bank_00b/d_72a1.bin" ; $72a1, 3423 bytes
