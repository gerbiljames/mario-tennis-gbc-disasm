INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $15", ROMX[$4000], BANK[$15]

	INCBIN "data/bank_015/d_4000.bin" ; $4000, 2317 bytes
	ld a, [$c295] ; $490d
	cp a, $ff ; $4910
	jp z, Label_15_4955 ; $4912
	call Func_15_4967 ; $4915
	rst Rst30 ; $4918
	ldh [rTIMA], a ; $4919
	jr z, Label_15_4943 ; $491b
	ld a, $02 ; $491d
	ld bc, $00ff ; $491f
	farcall FarPtr_0a_18 ; $4922
	ld a, $02 ; $4925
	ld b, $80 ; $4927
	ld de, $0200 ; $4929
	farcall FarPtr_0a_2a ; $492c
	ld a, $02 ; $492f
	farcall FarPtr_0a_20 ; $4931
	ld a, $02 ; $4934
	ld b, $00 ; $4936
	farcall FarPtr_0a_2e ; $4938
	ld a, $02 ; $493b
	ld bc, $0010 ; $493d
	farcall FarPtr_0a_18 ; $4940
Label_15_4943:
	ld a, $00 ; $4943
	ld bc, $0010 ; $4945
	farcall FarPtr_0a_18 ; $4948
	ld a, $00 ; $494b
	ld b, $00 ; $494d
	ld de, $0200 ; $494f
	farcall FarPtr_0a_2a ; $4952
Label_15_4955:
	ret ; $4955
	INCBIN "data/bank_015/d_4956.bin" ; $4956, 17 bytes
Func_15_4967:
	rst Rst28 ; $4967
	ld b, b ; $4968
	rla ; $4969
	rst Rst28 ; $496a
	and a, b ; $496b
	rla ; $496c
	rst Rst28 ; $496d
	ld h, b ; $496e
	rla ; $496f
	rst Rst28 ; $4970
	ret nz ; $4971
	rla ; $4972
	rst Rst28 ; $4973
	add a, b ; $4974
	rla ; $4975
	rst Rst28 ; $4976
	ldh [rAUD2ENV], a ; $4977
	ret ; $4979
	ld a, [$c2b0] ; $497a
	add a, a ; $497d
	add a, $91 ; $497e
	ld l, a ; $4980
	adc a, $49 ; $4981
	sub a, l ; $4983
	ld h, a ; $4984
	ld a, [hl+] ; $4985
	ld h, [hl] ; $4986
	ld l, a ; $4987
	farcall FarPtr_0a_0e ; $4988
	ld a, $03 ; $498b
	farcall FarPtr_0a_08 ; $498d
	ret ; $4990
	INCBIN "data/bank_015/d_4991.bin" ; $4991, 57 bytes
	farcall FarPtr_0a_0e ; $49ca
	ld a, $05 ; $49cd
	farcall FarPtr_0a_08 ; $49cf
	ret ; $49d2
	INCBIN "data/bank_015/d_49d3.bin" ; $49d3, 159 bytes
	farcall FarPtr_0a_08 ; $4a72
	ret ; $4a75
	INCBIN "data/bank_015/d_4a76.bin" ; $4a76, 1864 bytes
	ld a, $00 ; $51be
	ld bc, $0008 ; $51c0
	farcall FarPtr_0a_18 ; $51c3
	ld a, $00 ; $51c6
	ld b, $01 ; $51c8
	farcall FarPtr_0a_2c ; $51ca
	ld a, $00 ; $51cd
	ld bc, $2d00 ; $51cf
	ld de, $2b00 ; $51d2
	farcall FarPtr_0a_24 ; $51d5
	ld a, $00 ; $51d8
	farcall FarPtr_0a_20 ; $51da
	ld a, $00 ; $51dd
	ld b, $00 ; $51df
	farcall FarPtr_0a_2c ; $51e1
	ld a, $00 ; $51e4
	ld b, $c0 ; $51e6
	farcall FarPtr_0a_2e ; $51e8
	rst Rst30 ; $51eb
	jr nz, Label_15_5207 ; $51ec
	jr nz, Label_15_51f4 ; $51ee
	call Func_15_6fcf ; $51f0
	ret ; $51f3
Label_15_51f4:
	rst Rst30 ; $51f4
	ld b, b ; $51f5
	add hl, de ; $51f6
	jr nz, Label_15_521e ; $51f7
	rst Rst30 ; $51f9
	ret nz ; $51fa
	rla ; $51fb
	jr nz, Label_15_5207 ; $51fc
	rst Rst30 ; $51fe
	ld h, b ; $51ff
	ld a, [bc] ; $5200
	jr z, Label_15_5207 ; $5201
	call Func_15_706e ; $5203
	ret ; $5206
Label_15_5207:
	ld hl, $1c80 ; $5207
	farcall FarPtr_0a_0e ; $520a
	rst Rst30 ; $520d
	ldh [$ff0a], a ; $520e
	jr z, Label_15_5218 ; $5210
	ld hl, $1c83 ; $5212
	farcall FarPtr_0a_0e ; $5215
Label_15_5218:
	ld a, $12 ; $5218
	farcall FarPtr_0a_08 ; $521a
	ret ; $521d
Label_15_521e:
	rst Rst30 ; $521e
	ld h, b ; $521f
	add hl, de ; $5220
	jr nz, Label_15_5248 ; $5221
	rst Rst30 ; $5223
	ret nz ; $5224
	rla ; $5225
	jr nz, Label_15_5231 ; $5226
	rst Rst30 ; $5228
	ldh [$ff0a], a ; $5229
	jr z, Label_15_5231 ; $522b
	call Func_15_711d ; $522d
	ret ; $5230
Label_15_5231:
	ld hl, $1c9e ; $5231
	farcall FarPtr_0a_0e ; $5234
	rst Rst30 ; $5237
	ldh [$ff0a], a ; $5238
	jr z, Label_15_5242 ; $523a
	ld hl, $1c9c ; $523c
	farcall FarPtr_0a_0e ; $523f
Label_15_5242:
	ld a, $12 ; $5242
	farcall FarPtr_0a_08 ; $5244
	ret ; $5247
Label_15_5248:
	ld hl, $1cbb ; $5248
	farcall FarPtr_0a_0e ; $524b
	ld a, $12 ; $524e
	farcall FarPtr_0a_08 ; $5250
	ret ; $5253
	INCBIN "data/bank_015/d_5254.bin" ; $5254, 67 bytes
	rst Rst30 ; $5297
	ldh [rAUD2HIGH], a ; $5298
	jr nz, Label_15_52a0 ; $529a
	call Func_15_6db4 ; $529c
	ret ; $529f
Label_15_52a0:
	rst Rst30 ; $52a0
	nop ; $52a1
	ld a, [de] ; $52a2
	jr nz, Label_15_52d5 ; $52a3
	rst Rst30 ; $52a5
	ldh [rAUD2ENV], a ; $52a6
	jr nz, Label_15_52b3 ; $52a8
	rst Rst30 ; $52aa
	ld h, b ; $52ab
	ld a, [bc] ; $52ac
	jr z, Label_15_52b3 ; $52ad
	call Func_15_6e4b ; $52af
	ret ; $52b2
Label_15_52b3:
	ld hl, $1ce1 ; $52b3
	farcall FarPtr_0a_0e ; $52b6
	rst Rst30 ; $52b9
	ld h, b ; $52ba
	ld a, [bc] ; $52bb
	jr z, Label_15_52cf ; $52bc
	ld hl, $1ce2 ; $52be
	farcall FarPtr_0a_0e ; $52c1
	rst Rst30 ; $52c4
	ldh [$ff0a], a ; $52c5
	jr z, Label_15_52cf ; $52c7
	ld hl, $1ce2 ; $52c9
	farcall FarPtr_0a_0e ; $52cc
Label_15_52cf:
	ld a, $0d ; $52cf
	farcall FarPtr_0a_08 ; $52d1
	ret ; $52d4
Label_15_52d5:
	rst Rst30 ; $52d5
	jr nz, Label_15_52f2 ; $52d6
	jr nz, Label_15_52f4 ; $52d8
	rst Rst30 ; $52da
	ldh [rAUD2ENV], a ; $52db
	jr nz, Label_15_52e8 ; $52dd
	rst Rst30 ; $52df
	ldh [$ff0a], a ; $52e0
	jr z, Label_15_52e8 ; $52e2
	call Func_15_6ece ; $52e4
	ret ; $52e7
Label_15_52e8:
	ld hl, $1cf8 ; $52e8
	farcall FarPtr_0a_0e ; $52eb
	ld a, $0d ; $52ee
	INCBIN "data/bank_015/d_52f0.bin" ; $52f0, 2 bytes
Label_15_52f2:
	ld a, [bc] ; $52f2
	ret ; $52f3
Label_15_52f4:
	ld hl, $2012 ; $52f4
	farcall FarPtr_0a_0e ; $52f7
	ld a, $0d ; $52fa
	farcall FarPtr_0a_08 ; $52fc
	ret ; $52ff
	INCBIN "data/bank_015/d_5300.bin" ; $5300, 46 bytes
	call Func_15_7fa0 ; $532e
	ld a, [$c2b0] ; $5331
	cp a, $05 ; $5334
	jr c, Label_15_5340 ; $5336
	ld a, [$c2b0] ; $5338
	sub a, $06 ; $533b
	ld [$c2b0], a ; $533d
Label_15_5340:
	ld a, [$c295] ; $5340
	cp a, $0f ; $5343
	jr nz, Label_15_534b ; $5345
	call Func_15_59c0 ; $5347
	ret ; $534a
Label_15_534b:
	call Func_15_71be ; $534b
	call Func_15_724a ; $534e
	call Func_15_7204 ; $5351
	call Func_15_7a45 ; $5354
	ld a, [$c295] ; $5357
	cp a, $0a ; $535a
	jr nz, Label_15_5362 ; $535c
	call Func_15_536d ; $535e
	ret ; $5361
Label_15_5362:
	ld a, [$c295] ; $5362
	cp a, $09 ; $5365
	jr nz, Label_15_536c ; $5367
	call Func_15_7a67 ; $5369
Label_15_536c:
	ret ; $536c
Func_15_536d:
	ld a, [$c4c7] ; $536d
	cp a, $01 ; $5370
	jr nz, Label_15_5378 ; $5372
	call Func_15_53a9 ; $5374
	ret ; $5377
Label_15_5378:
	ld a, [$c8f7] ; $5378
	cp a, $12 ; $537b
	jr c, Label_15_5380 ; $537d
	ret ; $537f
Label_15_5380:
	ld a, [$c8f7] ; $5380
	ld a, a ; $5383
	rst Rst00 ; $5384
	add a, l ; $5385
	ld e, [hl] ; $5386
	or a, a ; $5387
	ld e, [hl] ; $5388
	rst Rst18 ; $5389
	ld e, [hl] ; $538a
	sub a, b ; $538b
	ld [hl], d ; $538c
	sbc a, a ; $538d
	ld [hl], d ; $538e
	or a, h ; $538f
	ld [hl], d ; $5390
	cp a, a ; $5391
	ld h, d ; $5392
	nop ; $5393
	ld h, e ; $5394
	jr z, $53fa ; $5395
	add hl, sp ; $5397
	ld [hl], l ; $5398
	ld c, [hl] ; $5399
	ld [hl], l ; $539a
	ld h, e ; $539b
	ld [hl], l ; $539c
	ld d, b ; $539d
	ld h, e ; $539e
	sub a, c ; $539f
	ld h, e ; $53a0
	cp a, c ; $53a1
	ld h, e ; $53a2
	xor a, d ; $53a3
	ld [hl], a ; $53a4
	cp a, l ; $53a5
	ld [hl], a ; $53a6
	ret nc ; $53a7
	ld [hl], a ; $53a8
Func_15_53a9:
	ld a, [$c8f7] ; $53a9
	ld a, a ; $53ac
	rst Rst00 ; $53ad
	jp nc, $d253 ; $53ae
	ld d, e ; $53b1
	jp nc, Label_00_3753 ; $53b2
	ld d, h ; $53b5
	scf ; $53b6
	ld d, h ; $53b7
	scf ; $53b8
	ld d, h ; $53b9
	add a, d ; $53ba
	ld d, h ; $53bb
	add a, d ; $53bc
	ld d, h ; $53bd
	add a, d ; $53be
	ld d, h ; $53bf
	rst Rst20 ; $53c0
	ld d, h ; $53c1
	rst Rst20 ; $53c2
	ld d, h ; $53c3
	rst Rst20 ; $53c4
	ld d, h ; $53c5
	ld [hl-], a ; $53c6
	ld d, l ; $53c7
	ld [hl-], a ; $53c8
	ld d, l ; $53c9
	ld [hl-], a ; $53ca
	ld d, l ; $53cb
	sub a, a ; $53cc
	ld d, l ; $53cd
	sub a, a ; $53ce
	ld d, l ; $53cf
	sub a, a ; $53d0
	ld d, l ; $53d1
	xor a, a ; $53d2
	ld [$c2d5], a ; $53d3
	ld a, $06 ; $53d6
	ld [$c2b1], a ; $53d8
	ld a, $00 ; $53db
	ld bc, $1800 ; $53dd
	ld de, $1100 ; $53e0
	farcall FarPtr_0a_22 ; $53e3
	ld a, $00 ; $53e6
	ld b, $c0 ; $53e8
	farcall FarPtr_0a_2e ; $53ea
	ld a, [$c2b1] ; $53ed
	ld bc, $1800 ; $53f0
	ld de, $0d00 ; $53f3
	farcall FarPtr_0a_22 ; $53f6
	ld a, [$c2b1] ; $53f9
	ld b, $40 ; $53fc
	farcall FarPtr_0a_2e ; $53fe
	ld a, $02 ; $5401
	farcall FarPtr_0a_1c ; $5403
	ld a, $02 ; $5406
	ld bc, $1300 ; $5408
	ld de, $1100 ; $540b
	farcall FarPtr_0a_22 ; $540e
	ld a, $02 ; $5411
	ld b, $00 ; $5413
	farcall FarPtr_0a_2e ; $5415
	ld bc, $00f0 ; $5418
	farcall FarPtr_0a_38 ; $541b
	xor a, a ; $541e
	ld bc, $1800 ; $541f
	ld de, $0f00 ; $5422
	farcall FarPtr_0a_3a ; $5425
	farcall FarPtr_0a_3e ; $5428
	ld c, $08 ; $542b
	call Func_00_1d2e ; $542d
	call Func_00_1da4 ; $5430
	call Func_15_6179 ; $5433
	ret ; $5436
	INCBIN "data/bank_015/d_5437.bin" ; $5437, 176 bytes
	xor a, a ; $54e7
	ld [$c2d5], a ; $54e8
	ld bc, $00f0 ; $54eb
	farcall FarPtr_0a_38 ; $54ee
	ld a, $00 ; $54f1
	ld bc, $2d00 ; $54f3
	ld de, $2b00 ; $54f6
	farcall FarPtr_0a_22 ; $54f9
	ld a, $02 ; $54fc
	ld bc, $2f00 ; $54fe
	ld de, $2b00 ; $5501
	farcall FarPtr_0a_22 ; $5504
	xor a, a ; $5507
	ld bc, $2d00 ; $5508
	ld de, $2b00 ; $550b
	farcall FarPtr_0a_3a ; $550e
	farcall FarPtr_0a_3e ; $5511
	ld a, $00 ; $5514
	ld b, $c0 ; $5516
	farcall FarPtr_0a_2e ; $5518
	ld a, $02 ; $551b
	ld b, $c0 ; $551d
	farcall FarPtr_0a_2e ; $551f
	ld a, $12 ; $5522
	ld b, $00 ; $5524
	farcall FarPtr_0a_2e ; $5526
	ld c, $04 ; $5529
	call Func_00_1d2e ; $552b
	call Func_00_1da4 ; $552e
	ret ; $5531
	INCBIN "data/bank_015/d_5532.bin" ; $5532, 1166 bytes
Func_15_59c0:
	xor a, a ; $59c0
	ld [$c2d5], a ; $59c1
	ldh a, [$ff95] ; $59c4
	ld hl, $5c4f ; $59c6
	farcall FarPtr_0a_06 ; $59c9
	farcall FarPtr_0a_00 ; $59cc
	ld a, $00 ; $59cf
	ld bc, $3f00 ; $59d1
	ld de, $3f00 ; $59d4
	farcall FarPtr_0a_22 ; $59d7
	ld a, $0d ; $59da
	ld bc, $3f00 ; $59dc
	ld de, $3f00 ; $59df
	farcall FarPtr_0a_22 ; $59e2
	ld a, $0d ; $59e5
	ld bc, $0700 ; $59e7
	ld de, $36c0 ; $59ea
	farcall FarPtr_0a_22 ; $59ed
	ld a, $0d ; $59f0
	ld bc, $1f00 ; $59f2
	ld de, $36c0 ; $59f5
	farcall FarPtr_0a_24 ; $59f8
	push af ; $59fb
	ld a, $0a ; $59fc
	farcall FarPtr_0a_04 ; $59fe
	pop af ; $5a01
	ld a, $00 ; $5a02
	ld bc, $0500 ; $5a04
	ld de, $3700 ; $5a07
	farcall FarPtr_0a_22 ; $5a0a
	ld a, $00 ; $5a0d
	ld bc, $1f00 ; $5a0f
	ld de, $3700 ; $5a12
	farcall FarPtr_0a_24 ; $5a15
	xor a, a ; $5a18
	ld bc, $1f00 ; $5a19
	ld de, $3700 ; $5a1c
	farcall FarPtr_0a_3a ; $5a1f
	ld c, $04 ; $5a22
	call Func_00_1d2e ; $5a24
	call Func_00_1da4 ; $5a27
	ld a, $0d ; $5a2a
	farcall FarPtr_0a_20 ; $5a2c
	ld a, $0d ; $5a2f
	ld bc, $1f00 ; $5a31
	ld de, $2b00 ; $5a34
	farcall FarPtr_0a_24 ; $5a37
	ld a, $00 ; $5a3a
	farcall FarPtr_0a_20 ; $5a3c
	ld a, $00 ; $5a3f
	ld bc, $1f00 ; $5a41
	ld de, $2d00 ; $5a44
	farcall FarPtr_0a_24 ; $5a47
	farcall FarPtr_0a_3e ; $5a4a
	xor a, a ; $5a4d
	ld bc, $1f00 ; $5a4e
	ld de, $2d00 ; $5a51
	farcall FarPtr_0a_3a ; $5a54
	farcall FarPtr_0a_3e ; $5a57
	push af ; $5a5a
	ld a, $3c ; $5a5b
	farcall FarPtr_0a_04 ; $5a5d
	pop af ; $5a60
	ld a, $0d ; $5a61
	ld b, $00 ; $5a63
	farcall FarPtr_0a_2e ; $5a65
	push af ; $5a68
	ld a, $3c ; $5a69
	farcall FarPtr_0a_04 ; $5a6b
	pop af ; $5a6e
	ld a, $0d ; $5a6f
	ld b, $80 ; $5a71
	farcall FarPtr_0a_2e ; $5a73
	push af ; $5a76
	ld a, $3c ; $5a77
	farcall FarPtr_0a_04 ; $5a79
	pop af ; $5a7c
	ld a, $0d ; $5a7d
	ld b, $40 ; $5a7f
	farcall FarPtr_0a_2e ; $5a81
	push af ; $5a84
	ld a, $3c ; $5a85
	farcall FarPtr_0a_04 ; $5a87
	pop af ; $5a8a
	ld a, $0d ; $5a8b
	ld b, $00 ; $5a8d
	farcall FarPtr_0a_2e ; $5a8f
	ld bc, $0040 ; $5a92
	farcall FarPtr_0a_38 ; $5a95
	ld hl, $1a73 ; $5a98
	farcall FarPtr_0a_0e ; $5a9b
	ld a, $0d ; $5a9e
	farcall FarPtr_0a_08 ; $5aa0
	ld a, $00 ; $5aa3
	ld d, $03 ; $5aa5
	farcall FarPtr_0a_34 ; $5aa7
	ld a, $00 ; $5aaa
	farcall FarPtr_0a_36 ; $5aac
	ld a, $00 ; $5aaf
	ld b, $00 ; $5ab1
	farcall FarPtr_0a_2e ; $5ab3
	xor a, a ; $5ab6
	ld bc, $2d00 ; $5ab7
	ld de, $2900 ; $5aba
	farcall FarPtr_0a_3a ; $5abd
	farcall FarPtr_0a_3e ; $5ac0
	ld a, $0d ; $5ac3
	farcall FarPtr_0a_08 ; $5ac5
	push af ; $5ac8
	ld a, $3c ; $5ac9
	farcall FarPtr_0a_04 ; $5acb
	pop af ; $5ace
	ld a, $00 ; $5acf
	ld b, a ; $5ad1
	ld a, $0d ; $5ad2
	farcall FarPtr_0a_30 ; $5ad4
	xor a, a ; $5ad7
	ld bc, $1f00 ; $5ad8
	ld de, $2d00 ; $5adb
	farcall FarPtr_0a_3a ; $5ade
	farcall FarPtr_0a_3e ; $5ae1
	ld a, $00 ; $5ae4
	ld d, $03 ; $5ae6
	farcall FarPtr_0a_34 ; $5ae8
	ld a, $00 ; $5aeb
	farcall FarPtr_0a_36 ; $5aed
	ld a, $0d ; $5af0
	ld b, $80 ; $5af2
	farcall FarPtr_0a_2e ; $5af4
	push af ; $5af7
	ld a, $28 ; $5af8
	farcall FarPtr_0a_04 ; $5afa
	pop af ; $5afd
	ld a, $00 ; $5afe
	ld b, $80 ; $5b00
	farcall FarPtr_0a_2e ; $5b02
	ld a, $0d ; $5b05
	farcall FarPtr_0a_08 ; $5b07
	ld a, $0b ; $5b0a
	ld b, $00 ; $5b0c
	farcall FarPtr_0a_3c ; $5b0e
	farcall FarPtr_0a_3e ; $5b11
	push af ; $5b14
	ld a, $3c ; $5b15
	farcall FarPtr_0a_04 ; $5b17
	pop af ; $5b1a
	ld a, $00 ; $5b1b
	ld b, a ; $5b1d
	ld a, $0d ; $5b1e
	farcall FarPtr_0a_30 ; $5b20
	ld a, $0d ; $5b23
	ld b, $00 ; $5b25
	farcall FarPtr_0a_3c ; $5b27
	farcall FarPtr_0a_3e ; $5b2a
	ld a, $00 ; $5b2d
	ld d, $03 ; $5b2f
	farcall FarPtr_0a_34 ; $5b31
	ld a, $00 ; $5b34
	farcall FarPtr_0a_36 ; $5b36
	ld a, $0d ; $5b39
	farcall FarPtr_0a_08 ; $5b3b
	ld a, $0d ; $5b3e
	ld b, a ; $5b40
	ld a, $00 ; $5b41
	farcall FarPtr_0a_30 ; $5b43
	ld a, $00 ; $5b46
	ld d, $02 ; $5b48
	farcall FarPtr_0a_34 ; $5b4a
	ld a, $00 ; $5b4d
	farcall FarPtr_0a_36 ; $5b4f
	ld a, $0d ; $5b52
	farcall FarPtr_0a_08 ; $5b54
	ld a, $00 ; $5b57
	ld d, $03 ; $5b59
	farcall FarPtr_0a_34 ; $5b5b
	ld a, $00 ; $5b5e
	farcall FarPtr_0a_36 ; $5b60
	ld a, $0d ; $5b63
	ld d, $03 ; $5b65
	farcall FarPtr_0a_34 ; $5b67
	ld a, $0d ; $5b6a
	farcall FarPtr_0a_36 ; $5b6c
	ld a, $0d ; $5b6f
	farcall FarPtr_0a_08 ; $5b71
	ld a, $00 ; $5b74
	ld d, $03 ; $5b76
	farcall FarPtr_0a_34 ; $5b78
	ld a, $00 ; $5b7b
	farcall FarPtr_0a_36 ; $5b7d
	ld bc, $0020 ; $5b80
	farcall FarPtr_0a_38 ; $5b83
	ld a, $00 ; $5b86
	ld b, $80 ; $5b88
	farcall FarPtr_0a_2e ; $5b8a
	ld a, $0d ; $5b8d
	ld bc, $1e00 ; $5b8f
	ld de, $2b00 ; $5b92
	farcall FarPtr_0a_24 ; $5b95
	ld a, $0d ; $5b98
	farcall FarPtr_0a_20 ; $5b9a
	ld a, $00 ; $5b9d
	ld b, $01 ; $5b9f
	farcall FarPtr_0a_2c ; $5ba1
	ld a, $00 ; $5ba4
	ld bc, $2000 ; $5ba6
	ld de, $2d00 ; $5ba9
	farcall FarPtr_0a_24 ; $5bac
	ld a, $0d ; $5baf
	ld bc, $1e00 ; $5bb1
	ld de, $2f00 ; $5bb4
	farcall FarPtr_0a_24 ; $5bb7
	ld a, $0d ; $5bba
	farcall FarPtr_0a_20 ; $5bbc
	ld a, $00 ; $5bbf
	ld bc, $1f00 ; $5bc1
	ld de, $2d00 ; $5bc4
	farcall FarPtr_0a_24 ; $5bc7
	ld a, $00 ; $5bca
	farcall FarPtr_0a_20 ; $5bcc
	ld a, $00 ; $5bcf
	ld b, $00 ; $5bd1
	farcall FarPtr_0a_2c ; $5bd3
	ld a, $0d ; $5bd6
	ld bc, $1f00 ; $5bd8
	ld de, $2f00 ; $5bdb
	farcall FarPtr_0a_24 ; $5bde
	ld a, $0d ; $5be1
	farcall FarPtr_0a_20 ; $5be3
	ld a, $00 ; $5be6
	ld bc, $1f00 ; $5be8
	ld de, $3700 ; $5beb
	farcall FarPtr_0a_24 ; $5bee
	xor a, a ; $5bf1
	ld bc, $1f00 ; $5bf2
	ld de, $3700 ; $5bf5
	farcall FarPtr_0a_3a ; $5bf8
	ld a, $0d ; $5bfb
	ld bc, $1f00 ; $5bfd
	ld de, $3700 ; $5c00
	farcall FarPtr_0a_24 ; $5c03
	ld a, $0d ; $5c06
	farcall FarPtr_0a_20 ; $5c08
	ld a, $0d ; $5c0b
	ld bc, $0300 ; $5c0d
	ld de, $3700 ; $5c10
	farcall FarPtr_0a_24 ; $5c13
	xor a, a ; $5c16
	ld bc, $0900 ; $5c17
	ld de, $3700 ; $5c1a
	farcall FarPtr_0a_3a ; $5c1d
	ld a, $00 ; $5c20
	farcall FarPtr_0a_20 ; $5c22
	ld a, $00 ; $5c25
	ld bc, $0300 ; $5c27
	ld de, $3700 ; $5c2a
	farcall FarPtr_0a_24 ; $5c2d
	push af ; $5c30
	ld a, $5a ; $5c31
	farcall FarPtr_0a_04 ; $5c33
	pop af ; $5c36
	ld c, $08 ; $5c37
	call Func_00_1d20 ; $5c39
	push af ; $5c3c
	ld a, $14 ; $5c3d
	farcall FarPtr_0a_04 ; $5c3f
	pop af ; $5c42
	ld a, $0f ; $5c43
	ld [$c294], a ; $5c45
	ld [$c2a1], a ; $5c48
	farcall FarPtr_0a_02 ; $5c4b
	ret ; $5c4e
	INCBIN "data/bank_015/d_5c4f.bin" ; $5c4f, 1322 bytes
Func_15_6179:
	ld a, [$c8f7] ; $6179
	sub a, $0a ; $617c
	jr nc, Label_15_618b ; $617e
	ld a, [$c8f7] ; $6180
	sub a, $04 ; $6183
	jr c, Label_15_61d5 ; $6185
	jp Label_15_6214 ; $6187
	INCBIN "data/bank_015/d_618a.bin" ; $618a, 1 bytes
Label_15_618b:
	ld a, [$c2b1] ; $618b
	ld bc, $1300 ; $618e
	ld de, $2500 ; $6191
	farcall FarPtr_0a_24 ; $6194
	ld a, [$c2b1] ; $6197
	farcall FarPtr_0a_20 ; $619a
	ld a, [$c2b1] ; $619d
	ld bc, $1300 ; $61a0
	ld de, $2700 ; $61a3
	farcall FarPtr_0a_24 ; $61a6
	ld a, $00 ; $61a9
	ld bc, $1300 ; $61ab
	ld de, $2b00 ; $61ae
	farcall FarPtr_0a_24 ; $61b1
	ld a, $00 ; $61b4
	farcall FarPtr_0a_20 ; $61b6
	ld a, $02 ; $61b9
	farcall FarPtr_0a_16 ; $61bb
	ld c, l ; $61be
	ld b, h ; $61bf
	ld de, $d000 ; $61c0
	farcall FarPtr_04_20 ; $61c3
	ld a, [$c2b1] ; $61c6
	farcall FarPtr_0a_20 ; $61c9
	ld a, [$c2b1] ; $61cc
	ld b, $40 ; $61cf
	farcall FarPtr_0a_2e ; $61d1
	ret ; $61d4
Label_15_61d5:
	ld a, [$c2b1] ; $61d5
	ld bc, $1300 ; $61d8
	ld de, $0b00 ; $61db
	farcall FarPtr_0a_24 ; $61de
	push af ; $61e1
	ld a, $1e ; $61e2
	farcall FarPtr_0a_04 ; $61e4
	pop af ; $61e7
	ld a, $00 ; $61e8
	ld bc, $1300 ; $61ea
	ld de, $1300 ; $61ed
	farcall FarPtr_0a_24 ; $61f0
	ld a, $00 ; $61f3
	farcall FarPtr_0a_20 ; $61f5
	ld a, $02 ; $61f8
	farcall FarPtr_0a_16 ; $61fa
	ld c, l ; $61fd
	ld b, h ; $61fe
	ld de, $d000 ; $61ff
	farcall FarPtr_04_20 ; $6202
	ld a, [$c2b1] ; $6205
	farcall FarPtr_0a_20 ; $6208
	ld a, [$c2b1] ; $620b
	ld b, $00 ; $620e
	farcall FarPtr_0a_2e ; $6210
	ret ; $6213
Label_15_6214:
	ld a, [$c2b1] ; $6214
	ld bc, $2d00 ; $6217
	ld de, $2100 ; $621a
	farcall FarPtr_0a_24 ; $621d
	push af ; $6220
	ld a, $1e ; $6221
	farcall FarPtr_0a_04 ; $6223
	pop af ; $6226
	ld a, $00 ; $6227
	ld bc, $2d00 ; $6229
	ld de, $2b00 ; $622c
	farcall FarPtr_0a_24 ; $622f
	ld a, $00 ; $6232
	farcall FarPtr_0a_20 ; $6234
	ld a, $02 ; $6237
	farcall FarPtr_0a_16 ; $6239
	ld c, l ; $623c
	ld b, h ; $623d
	ld de, $d000 ; $623e
	farcall FarPtr_04_20 ; $6241
	ld a, [$c2b1] ; $6244
	farcall FarPtr_0a_20 ; $6247
	ld a, [$c2b1] ; $624a
	ld b, $00 ; $624d
	farcall FarPtr_0a_2e ; $624f
	ret ; $6252
	INCBIN "data/bank_015/d_6253.bin" ; $6253, 1012 bytes
Func_15_6647:
	rst Rst30 ; $6647
	ldh [rTIMA], a ; $6648
	jr z, Label_15_667b ; $664a
	ld a, $02 ; $664c
	ld b, a ; $664e
	ld a, $00 ; $664f
	farcall FarPtr_0a_30 ; $6651
	ld a, $00 ; $6654
	ld d, $03 ; $6656
	farcall FarPtr_0a_34 ; $6658
	ld a, $00 ; $665b
	farcall FarPtr_0a_36 ; $665d
	ld a, $02 ; $6660
	ld d, $03 ; $6662
	farcall FarPtr_0a_34 ; $6664
	ld a, $02 ; $6667
	farcall FarPtr_0a_36 ; $6669
	ld a, $00 ; $666c
	ld b, $c0 ; $666e
	farcall FarPtr_0a_2e ; $6670
	push af ; $6673
	ld a, $0a ; $6674
	farcall FarPtr_0a_04 ; $6676
	pop af ; $6679
	ret ; $667a
Label_15_667b:
	ld a, $00 ; $667b
	ld d, $03 ; $667d
	farcall FarPtr_0a_34 ; $667f
	ld a, $00 ; $6682
	farcall FarPtr_0a_36 ; $6684
	push af ; $6687
	ld a, $0a ; $6688
	farcall FarPtr_0a_04 ; $668a
	pop af ; $668d
	ret ; $668e
	INCBIN "data/bank_015/d_668f.bin" ; $668f, 1823 bytes
Label_15_6dae:
	ld a, $0d ; $6dae
	farcall FarPtr_0a_08 ; $6db0
	ret ; $6db3
Func_15_6db4:
	ld hl, $1cc4 ; $6db4
	farcall FarPtr_0a_0e ; $6db7
	rst Rst30 ; $6dba
	ld h, b ; $6dbb
	ld a, [bc] ; $6dbc
	jr z, Label_15_6dc2 ; $6dbd
	farcall FarPtr_0a_10 ; $6dbf
Label_15_6dc2:
	ld a, $0d ; $6dc2
	ld b, a ; $6dc4
	ld a, $02 ; $6dc5
	farcall FarPtr_0a_30 ; $6dc7
	ld a, $0d ; $6dca
	farcall FarPtr_0a_0a ; $6dcc
	ld hl, $1cc6 ; $6dcf
	farcall FarPtr_0a_0e ; $6dd2
	farcall FarPtr_0a_12 ; $6dd5
	farcall FarPtr_0a_0c ; $6dd8
	push af ; $6ddb
	ld a, $05 ; $6ddc
	farcall FarPtr_0a_04 ; $6dde
	pop af ; $6de1
	and a, a ; $6de2
	jp nz, Label_15_6dae ; $6de3
	farcall FarPtr_0a_10 ; $6de6
	ld a, $0d ; $6de9
	farcall FarPtr_0a_0a ; $6deb
	farcall FarPtr_0a_12 ; $6dee
	farcall FarPtr_0a_0c ; $6df1
	push af ; $6df4
	ld a, $05 ; $6df5
	farcall FarPtr_0a_04 ; $6df7
	pop af ; $6dfa
	and a, a ; $6dfb
	jp nz, Label_15_6dae ; $6dfc
	farcall FarPtr_0a_10 ; $6dff
	ld a, $0d ; $6e02
	farcall FarPtr_0a_08 ; $6e04
	call Func_15_7d14 ; $6e07
	ld a, $0d ; $6e0a
	ld b, $00 ; $6e0c
	farcall FarPtr_0a_2e ; $6e0e
	ld hl, $1cca ; $6e11
	farcall FarPtr_0a_0e ; $6e14
	ld a, $0d ; $6e17
	farcall FarPtr_0a_08 ; $6e19
	ld a, $0d ; $6e1c
	ld d, $02 ; $6e1e
	farcall FarPtr_0a_34 ; $6e20
	ld a, $0d ; $6e23
	farcall FarPtr_0a_36 ; $6e25
	ld a, $0f ; $6e28
	ld [$c8f7], a ; $6e2a
	ld a, $0f ; $6e2d
	ld [wStoryModeCurrentLocation], a ; $6e2f
	ld a, $09 ; $6e32
	ld [$c295], a ; $6e34
	ld a, $ff ; $6e37
	ld [$c294], a ; $6e39
	ld [$c2a1], a ; $6e3c
	ld c, $10 ; $6e3f
	call Func_00_1d20 ; $6e41
	call Func_00_1da4 ; $6e44
	farcall FarPtr_17_0a ; $6e47
	ret ; $6e4a
Func_15_6e4b:
	ld a, $0d ; $6e4b
	ld b, a ; $6e4d
	ld a, $02 ; $6e4e
	farcall FarPtr_0a_30 ; $6e50
	ld hl, $1ce3 ; $6e53
	farcall FarPtr_0a_0e ; $6e56
	ld a, $0d ; $6e59
	farcall FarPtr_0a_0a ; $6e5b
	farcall FarPtr_0a_12 ; $6e5e
	farcall FarPtr_0a_0c ; $6e61
	push af ; $6e64
	ld a, $05 ; $6e65
	farcall FarPtr_0a_04 ; $6e67
	pop af ; $6e6a
	and a, a ; $6e6b
	jp nz, Label_15_6dae ; $6e6c
	farcall FarPtr_0a_10 ; $6e6f
	ld a, $0d ; $6e72
	farcall FarPtr_0a_0a ; $6e74
	farcall FarPtr_0a_12 ; $6e77
	farcall FarPtr_0a_0c ; $6e7a
	push af ; $6e7d
	ld a, $05 ; $6e7e
	farcall FarPtr_0a_04 ; $6e80
	pop af ; $6e83
	and a, a ; $6e84
	jp nz, Label_15_6dae ; $6e85
	farcall FarPtr_0a_10 ; $6e88
	ld a, $0d ; $6e8b
	farcall FarPtr_0a_08 ; $6e8d
	call Func_15_7d14 ; $6e90
	ld a, $0d ; $6e93
	ld b, $00 ; $6e95
	farcall FarPtr_0a_2e ; $6e97
	ld a, $0d ; $6e9a
	farcall FarPtr_0a_08 ; $6e9c
	ld a, $0d ; $6e9f
	ld d, $02 ; $6ea1
	farcall FarPtr_0a_34 ; $6ea3
	ld a, $0d ; $6ea6
	farcall FarPtr_0a_36 ; $6ea8
	ld a, $10 ; $6eab
	ld [$c8f7], a ; $6ead
	ld a, $0f ; $6eb0
	ld [wStoryModeCurrentLocation], a ; $6eb2
	ld a, $09 ; $6eb5
	ld [$c295], a ; $6eb7
	ld a, $ff ; $6eba
	ld [$c294], a ; $6ebc
	ld [$c2a1], a ; $6ebf
	ld c, $10 ; $6ec2
	call Func_00_1d20 ; $6ec4
	call Func_00_1da4 ; $6ec7
	farcall FarPtr_17_0a ; $6eca
	ret ; $6ecd
Func_15_6ece:
	ld a, $0d ; $6ece
	ld b, a ; $6ed0
	ld a, $02 ; $6ed1
	farcall FarPtr_0a_30 ; $6ed3
	ld hl, $1cf9 ; $6ed6
	farcall FarPtr_0a_0e ; $6ed9
	ld a, $0d ; $6edc
	farcall FarPtr_0a_0a ; $6ede
	farcall FarPtr_0a_12 ; $6ee1
	farcall FarPtr_0a_0c ; $6ee4
	push af ; $6ee7
	ld a, $05 ; $6ee8
	farcall FarPtr_0a_04 ; $6eea
	pop af ; $6eed
	and a, a ; $6eee
	jp nz, Label_15_6dae ; $6eef
	farcall FarPtr_0a_10 ; $6ef2
	ld a, $0d ; $6ef5
	farcall FarPtr_0a_0a ; $6ef7
	farcall FarPtr_0a_12 ; $6efa
	farcall FarPtr_0a_0c ; $6efd
	push af ; $6f00
	ld a, $05 ; $6f01
	farcall FarPtr_0a_04 ; $6f03
	pop af ; $6f06
	and a, a ; $6f07
	jp nz, Label_15_6dae ; $6f08
	farcall FarPtr_0a_10 ; $6f0b
	ld a, $0d ; $6f0e
	farcall FarPtr_0a_08 ; $6f10
	call Func_15_7d14 ; $6f13
	ld a, $0d ; $6f16
	ld b, $00 ; $6f18
	farcall FarPtr_0a_2e ; $6f1a
	ld a, $0d ; $6f1d
	farcall FarPtr_0a_08 ; $6f1f
	ld a, $0d ; $6f22
	ld d, $02 ; $6f24
	farcall FarPtr_0a_34 ; $6f26
	ld a, $0d ; $6f29
	farcall FarPtr_0a_36 ; $6f2b
	ld a, $11 ; $6f2e
	ld [$c8f7], a ; $6f30
	ld a, $0f ; $6f33
	ld [wStoryModeCurrentLocation], a ; $6f35
	ld a, $09 ; $6f38
	ld [$c295], a ; $6f3a
	ld a, $ff ; $6f3d
	ld [$c294], a ; $6f3f
	ld [$c2a1], a ; $6f42
	ld c, $10 ; $6f45
	call Func_00_1d20 ; $6f47
	call Func_00_1da4 ; $6f4a
	farcall FarPtr_17_0a ; $6f4d
	ret ; $6f50
	INCBIN "data/bank_015/d_6f51.bin" ; $6f51, 126 bytes
Func_15_6fcf:
	ld a, $12 ; $6fcf
	ld b, a ; $6fd1
	ld a, $02 ; $6fd2
	farcall FarPtr_0a_30 ; $6fd4
	rst Rst30 ; $6fd7
	ld h, b ; $6fd8
	ld a, [bc] ; $6fd9
	jr nz, Label_15_6fe4 ; $6fda
	ld hl, $1c5d ; $6fdc
	farcall FarPtr_0a_0e ; $6fdf
	jr Label_15_6fea ; $6fe2
Label_15_6fe4:
	ld hl, $1c64 ; $6fe4
	farcall FarPtr_0a_0e ; $6fe7
Label_15_6fea:
	ld a, $12 ; $6fea
	farcall FarPtr_0a_0a ; $6fec
	farcall FarPtr_0a_12 ; $6fef
	farcall FarPtr_0a_0c ; $6ff2
	push af ; $6ff5
	ld a, $05 ; $6ff6
	farcall FarPtr_0a_04 ; $6ff8
	pop af ; $6ffb
	and a, a ; $6ffc
	jr nz, Label_15_7068 ; $6ffd
	farcall FarPtr_0a_10 ; $6fff
	ld a, $12 ; $7002
	farcall FarPtr_0a_0a ; $7004
	farcall FarPtr_0a_12 ; $7007
	farcall FarPtr_0a_0c ; $700a
	push af ; $700d
	ld a, $05 ; $700e
	farcall FarPtr_0a_04 ; $7010
	pop af ; $7013
	and a, a ; $7014
	jr nz, Label_15_7068 ; $7015
	farcall FarPtr_0a_10 ; $7017
	ld a, $12 ; $701a
	farcall FarPtr_0a_08 ; $701c
	call Func_15_7cbb ; $701f
	ld a, $12 ; $7022
	ld b, $80 ; $7024
	farcall FarPtr_0a_2e ; $7026
	ld a, $12 ; $7029
	farcall FarPtr_0a_08 ; $702b
	ld a, $12 ; $702e
	ld d, $02 ; $7030
	farcall FarPtr_0a_34 ; $7032
	ld a, $12 ; $7035
	farcall FarPtr_0a_36 ; $7037
	ld hl, $1c63 ; $703a
	farcall FarPtr_0a_0e ; $703d
	ld a, $12 ; $7040
	farcall FarPtr_0a_08 ; $7042
	ld a, $09 ; $7045
	ld [$c8f7], a ; $7047
	ld a, $0f ; $704a
	ld [wStoryModeCurrentLocation], a ; $704c
	ld a, $09 ; $704f
	ld [$c295], a ; $7051
	ld a, $ff ; $7054
	ld [$c294], a ; $7056
	ld [$c2a1], a ; $7059
	ld c, $10 ; $705c
	call Func_00_1d20 ; $705e
	call Func_00_1da4 ; $7061
	farcall FarPtr_17_0a ; $7064
	ret ; $7067
Label_15_7068:
	ld a, $12 ; $7068
	farcall FarPtr_0a_08 ; $706a
	ret ; $706d
Func_15_706e:
	ld a, $12 ; $706e
	ld b, a ; $7070
	ld a, $02 ; $7071
	farcall FarPtr_0a_30 ; $7073
	ld hl, $1c86 ; $7076
	farcall FarPtr_0a_0e ; $7079
	ld a, $12 ; $707c
	farcall FarPtr_0a_0a ; $707e
	farcall FarPtr_0a_12 ; $7081
	farcall FarPtr_0a_0c ; $7084
	push af ; $7087
	ld a, $05 ; $7088
	farcall FarPtr_0a_04 ; $708a
	pop af ; $708d
	and a, a ; $708e
	jr nz, Label_15_7068 ; $708f
	farcall FarPtr_0a_10 ; $7091
	ld a, $12 ; $7094
	farcall FarPtr_0a_0a ; $7096
	farcall FarPtr_0a_12 ; $7099
	farcall FarPtr_0a_0c ; $709c
	push af ; $709f
	ld a, $05 ; $70a0
	farcall FarPtr_0a_04 ; $70a2
	pop af ; $70a5
	and a, a ; $70a6
	jr nz, Label_15_7068 ; $70a7
	farcall FarPtr_0a_10 ; $70a9
	ld a, $12 ; $70ac
	farcall FarPtr_0a_0a ; $70ae
	farcall FarPtr_0a_12 ; $70b1
	farcall FarPtr_0a_0c ; $70b4
	push af ; $70b7
	ld a, $05 ; $70b8
	farcall FarPtr_0a_04 ; $70ba
	pop af ; $70bd
	and a, a ; $70be
	jr nz, Label_15_7068 ; $70bf
	farcall FarPtr_0a_10 ; $70c1
	ld a, $12 ; $70c4
	farcall FarPtr_0a_08 ; $70c6
	call Func_15_7cbb ; $70c9
	ld a, $12 ; $70cc
	ld b, $80 ; $70ce
	farcall FarPtr_0a_2e ; $70d0
	ld a, $12 ; $70d3
	farcall FarPtr_0a_08 ; $70d5
	ld a, $12 ; $70d8
	ld d, $02 ; $70da
	farcall FarPtr_0a_34 ; $70dc
	ld a, $12 ; $70df
	farcall FarPtr_0a_36 ; $70e1
	ld a, $12 ; $70e4
	farcall FarPtr_0a_08 ; $70e6
	ld a, $12 ; $70e9
	ld d, $03 ; $70eb
	farcall FarPtr_0a_34 ; $70ed
	ld a, $12 ; $70f0
	farcall FarPtr_0a_36 ; $70f2
	ld a, $12 ; $70f5
	farcall FarPtr_0a_08 ; $70f7
	ld a, $0a ; $70fa
	ld [$c8f7], a ; $70fc
	ld a, $0f ; $70ff
	ld [wStoryModeCurrentLocation], a ; $7101
	ld a, $09 ; $7104
	ld [$c295], a ; $7106
	ld a, $ff ; $7109
	ld [$c294], a ; $710b
	ld [$c2a1], a ; $710e
	ld c, $10 ; $7111
	call Func_00_1d20 ; $7113
	call Func_00_1da4 ; $7116
	farcall FarPtr_17_0a ; $7119
	ret ; $711c
Func_15_711d:
	ld a, $12 ; $711d
	ld b, a ; $711f
	ld a, $02 ; $7120
	farcall FarPtr_0a_30 ; $7122
	ld hl, $1c9f ; $7125
	farcall FarPtr_0a_0e ; $7128
	ld a, $12 ; $712b
	farcall FarPtr_0a_0a ; $712d
	farcall FarPtr_0a_12 ; $7130
	farcall FarPtr_0a_0c ; $7133
	push af ; $7136
	ld a, $05 ; $7137
	farcall FarPtr_0a_04 ; $7139
	pop af ; $713c
	and a, a ; $713d
	jp nz, Label_15_7068 ; $713e
	farcall FarPtr_0a_10 ; $7141
	ld a, $12 ; $7144
	farcall FarPtr_0a_0a ; $7146
	farcall FarPtr_0a_12 ; $7149
	farcall FarPtr_0a_0c ; $714c
	push af ; $714f
	ld a, $05 ; $7150
	farcall FarPtr_0a_04 ; $7152
	pop af ; $7155
	and a, a ; $7156
	jp nz, Label_15_7068 ; $7157
	farcall FarPtr_0a_10 ; $715a
	ld a, $12 ; $715d
	farcall FarPtr_0a_0a ; $715f
	farcall FarPtr_0a_12 ; $7162
	farcall FarPtr_0a_0c ; $7165
	push af ; $7168
	ld a, $05 ; $7169
	farcall FarPtr_0a_04 ; $716b
	pop af ; $716e
	and a, a ; $716f
	jp nz, Label_15_7068 ; $7170
	farcall FarPtr_0a_10 ; $7173
	ld a, $12 ; $7176
	farcall FarPtr_0a_08 ; $7178
	call Func_15_7cbb ; $717b
	ld a, $12 ; $717e
	ld b, $80 ; $7180
	farcall FarPtr_0a_2e ; $7182
	ld a, $12 ; $7185
	farcall FarPtr_0a_08 ; $7187
	ld a, $12 ; $718a
	ld d, $02 ; $718c
	farcall FarPtr_0a_34 ; $718e
	ld a, $12 ; $7191
	farcall FarPtr_0a_36 ; $7193
	ld a, $12 ; $7196
	farcall FarPtr_0a_08 ; $7198
	ld a, $0b ; $719b
	ld [$c8f7], a ; $719d
	ld a, $0f ; $71a0
	ld [wStoryModeCurrentLocation], a ; $71a2
	ld a, $09 ; $71a5
	ld [$c295], a ; $71a7
	ld a, $ff ; $71aa
	ld [$c294], a ; $71ac
	ld [$c2a1], a ; $71af
	ld c, $10 ; $71b2
	call Func_00_1d20 ; $71b4
	call Func_00_1da4 ; $71b7
	farcall FarPtr_17_0a ; $71ba
	ret ; $71bd
Func_15_71be:
	rst Rst30 ; $71be
	ld b, b ; $71bf
	rla ; $71c0
	jr nz, Label_15_71c8 ; $71c1
	call Func_15_71d4 ; $71c3
	jr z, Label_15_71d3 ; $71c6
Label_15_71c8:
	ld a, $06 ; $71c8
	ld bc, $3f00 ; $71ca
	ld de, $3f00 ; $71cd
	farcall FarPtr_0a_22 ; $71d0
Label_15_71d3:
	ret ; $71d3
Func_15_71d4:
	ld a, [$c2b0] ; $71d4
	add a, a ; $71d7
	add a, $f8 ; $71d8
	ld l, a ; $71da
	adc a, $71 ; $71db
	sub a, l ; $71dd
	ld h, a ; $71de
	ld a, [hl+] ; $71df
	ld d, [hl] ; $71e0
	ld e, a ; $71e1
	call Func_00_24ef ; $71e2
	ret ; $71e5
	INCBIN "data/bank_015/d_71e6.bin" ; $71e6, 30 bytes
Func_15_7204:
	rst Rst30 ; $7204
	ld h, b ; $7205
	rla ; $7206
	jr nz, Label_15_720e ; $7207
	call Func_15_721a ; $7209
	jr z, Label_15_7219 ; $720c
Label_15_720e:
	ld a, $11 ; $720e
	ld bc, $3f00 ; $7210
	ld de, $3f00 ; $7213
	farcall FarPtr_0a_22 ; $7216
Label_15_7219:
	ret ; $7219
Func_15_721a:
	ld a, [$c2b0] ; $721a
	add a, a ; $721d
	add a, $3e ; $721e
	ld l, a ; $7220
	adc a, $72 ; $7221
	sub a, l ; $7223
	ld h, a ; $7224
	ld a, [hl+] ; $7225
	ld d, [hl] ; $7226
	ld e, a ; $7227
	call Func_00_24ef ; $7228
	ret ; $722b
	INCBIN "data/bank_015/d_722c.bin" ; $722c, 30 bytes
Func_15_724a:
	rst Rst30 ; $724a
	add a, b ; $724b
	rla ; $724c
	jr nz, Label_15_7254 ; $724d
	call Func_15_7260 ; $724f
	jr z, Label_15_725f ; $7252
Label_15_7254:
	ld a, $0c ; $7254
	ld bc, $3f00 ; $7256
	ld de, $3f00 ; $7259
	farcall FarPtr_0a_22 ; $725c
Label_15_725f:
	ret ; $725f
Func_15_7260:
	ld a, [$c2b0] ; $7260
	add a, a ; $7263
	add a, $84 ; $7264
	ld l, a ; $7266
	adc a, $72 ; $7267
	sub a, l ; $7269
	ld h, a ; $726a
	ld a, [hl+] ; $726b
	ld d, [hl] ; $726c
	ld e, a ; $726d
	call Func_00_24ef ; $726e
	ret ; $7271
	INCBIN "data/bank_015/d_7272.bin" ; $7272, 623 bytes
Func_15_74e1:
	xor a, a ; $74e1
	ld [$c2d5], a ; $74e2
	ld bc, $00f0 ; $74e5
	farcall FarPtr_0a_38 ; $74e8
	ld a, $00 ; $74eb
	ld bc, $1300 ; $74ed
	ld de, $1300 ; $74f0
	farcall FarPtr_0a_22 ; $74f3
	ld a, $02 ; $74f6
	ld bc, $1300 ; $74f8
	ld de, $1100 ; $74fb
	farcall FarPtr_0a_22 ; $74fe
	xor a, a ; $7501
	ld bc, $1300 ; $7502
	ld de, $1300 ; $7505
	farcall FarPtr_0a_3a ; $7508
	farcall FarPtr_0a_3e ; $750b
	ld a, $00 ; $750e
	ld b, $40 ; $7510
	farcall FarPtr_0a_2e ; $7512
	ld a, $02 ; $7515
	ld b, $40 ; $7517
	farcall FarPtr_0a_2e ; $7519
	ld a, $07 ; $751c
	ld b, $c0 ; $751e
	farcall FarPtr_0a_2e ; $7520
	ld c, $04 ; $7523
	call Func_00_1d2e ; $7525
	call Func_00_1da4 ; $7528
	ret ; $752b
	INCBIN "data/bank_015/d_752c.bin" ; $752c, 13 bytes
	ld a, [$c2e3] ; $7539
	ld a, a ; $753c
	rst Rst00 ; $753d
	ld a, d ; $753e
	ld [hl], l ; $753f
	adc a, h ; $7540
	halt ; $7541
	sbc a, c ; $7542
	halt ; $7543
	and a, [hl] ; $7544
	halt ; $7545
	or a, e ; $7546
	halt ; $7547
	ret nz ; $7548
	halt ; $7549
	adc a, h ; $754a
	halt ; $754b
	adc a, h ; $754c
	halt ; $754d
	ld a, [$c2e3] ; $754e
	ld a, a ; $7551
	rst Rst00 ; $7552
	reti ; $7553
	INCBIN "data/bank_015/d_7554.bin" ; $7554, 85 bytes
	farcall FarPtr_0a_08 ; $75a9
	ld a, $12 ; $75ac
	ld d, $02 ; $75ae
	farcall FarPtr_0a_34 ; $75b0
	ld a, $12 ; $75b3
	farcall FarPtr_0a_36 ; $75b5
	ld a, $12 ; $75b8
	farcall FarPtr_0a_08 ; $75ba
	ld a, $12 ; $75bd
	ld d, $04 ; $75bf
	farcall FarPtr_0a_34 ; $75c1
	ld a, $12 ; $75c4
	farcall FarPtr_0a_36 ; $75c6
	ld a, $12 ; $75c9
	farcall FarPtr_0a_08 ; $75cb
	ld a, $12 ; $75ce
	ld b, $00 ; $75d0
	farcall FarPtr_0a_2e ; $75d2
	rst Rst20 ; $75d5
	ret nz ; $75d6
	rla ; $75d7
	ret ; $75d8
	INCBIN "data/bank_015/d_75d9.bin" ; $75d9, 205 bytes
	call Func_15_7752 ; $76a6
	ld hl, $1c73 ; $76a9
	farcall FarPtr_0a_0e ; $76ac
	call Func_15_7728 ; $76af
	ret ; $76b2
	INCBIN "data/bank_015/d_76b3.bin" ; $76b3, 117 bytes
Func_15_7728:
	ld a, $12 ; $7728
	farcall FarPtr_0a_08 ; $772a
	ld a, $12 ; $772d
	farcall FarPtr_0a_0a ; $772f
	farcall FarPtr_0a_12 ; $7732
	farcall FarPtr_0a_0c ; $7735
	push af ; $7738
	ld a, $05 ; $7739
	farcall FarPtr_0a_04 ; $773b
	pop af ; $773e
	and a, a ; $773f
	jp z, Label_15_7749 ; $7740
	farcall FarPtr_0a_10 ; $7743
	jp Label_15_779d ; $7746
Label_15_7749:
	ld a, $12 ; $7749
	farcall FarPtr_0a_08 ; $774b
	call Func_15_7b30 ; $774e
	ret ; $7751
Func_15_7752:
	xor a, a ; $7752
	ld [$c2d5], a ; $7753
	ld bc, $00f0 ; $7756
	farcall FarPtr_0a_38 ; $7759
	ld a, $00 ; $775c
	ld bc, $2d00 ; $775e
	ld de, $2b00 ; $7761
	farcall FarPtr_0a_22 ; $7764
	ld a, $02 ; $7767
	ld bc, $2f00 ; $7769
	ld de, $2b00 ; $776c
	farcall FarPtr_0a_22 ; $776f
	xor a, a ; $7772
	ld bc, $2d00 ; $7773
	ld de, $2b00 ; $7776
	farcall FarPtr_0a_3a ; $7779
	farcall FarPtr_0a_3e ; $777c
	ld a, $00 ; $777f
	ld b, $c0 ; $7781
	farcall FarPtr_0a_2e ; $7783
	ld a, $02 ; $7786
	ld b, $c0 ; $7788
	farcall FarPtr_0a_2e ; $778a
	ld a, $12 ; $778d
	ld b, $40 ; $778f
	farcall FarPtr_0a_2e ; $7791
	ld c, $04 ; $7794
	call Func_00_1d2e ; $7796
	call Func_00_1da4 ; $7799
	ret ; $779c
Label_15_779d:
	ld a, $12 ; $779d
	farcall FarPtr_0a_08 ; $779f
	ld a, $12 ; $77a2
	ld b, $00 ; $77a4
	farcall FarPtr_0a_2e ; $77a6
	ret ; $77a9
	ld a, [$c2e3] ; $77aa
	ld a, a ; $77ad
	rst Rst00 ; $77ae
	INCBIN "data/bank_015/d_77af.bin" ; $77af, 52 bytes
	call Func_15_79cb ; $77e3
	ld hl, $1cdd ; $77e6
	farcall FarPtr_0a_0e ; $77e9
	ld a, $0d ; $77ec
	farcall FarPtr_0a_08 ; $77ee
	ld a, $00 ; $77f1
	ld b, a ; $77f3
	ld a, $0d ; $77f4
	farcall FarPtr_0a_30 ; $77f6
	ld a, $0d ; $77f9
	ld d, $03 ; $77fb
	farcall FarPtr_0a_34 ; $77fd
	ld a, $0d ; $7800
	farcall FarPtr_0a_36 ; $7802
	ld a, $0d ; $7805
	farcall FarPtr_0a_08 ; $7807
	ld a, $0d ; $780a
	ld d, $02 ; $780c
	farcall FarPtr_0a_34 ; $780e
	ld a, $0d ; $7811
	farcall FarPtr_0a_36 ; $7813
	rst Rst30 ; $7816
	ld h, b ; $7817
	ld a, [bc] ; $7818
	jr z, Label_15_781e ; $7819
	farcall FarPtr_0a_10 ; $781b
Label_15_781e:
	ld a, $0d ; $781e
	farcall FarPtr_0a_08 ; $7820
	ld hl, $1ce1 ; $7823
	farcall FarPtr_0a_0e ; $7826
	ld a, $0d ; $7829
	ld d, $04 ; $782b
	farcall FarPtr_0a_34 ; $782d
	ld a, $0d ; $7830
	farcall FarPtr_0a_36 ; $7832
	rst Rst30 ; $7835
	ld h, b ; $7836
	ld a, [bc] ; $7837
	jr z, Label_15_783d ; $7838
	farcall FarPtr_0a_10 ; $783a
Label_15_783d:
	ld a, $0d ; $783d
	farcall FarPtr_0a_08 ; $783f
	ld a, $0d ; $7842
	ld b, $c0 ; $7844
	farcall FarPtr_0a_2e ; $7846
	rst Rst20 ; $7849
	ldh [rAUD2ENV], a ; $784a
	ret ; $784c
	INCBIN "data/bank_015/d_784d.bin" ; $784d, 194 bytes
	call Func_15_79cb ; $790f
	ld hl, $1cd3 ; $7912
	farcall FarPtr_0a_0e ; $7915
	call Func_15_799e ; $7918
	ret ; $791b
	INCBIN "data/bank_015/d_791c.bin" ; $791c, 130 bytes
Func_15_799e:
	ld a, $0d ; $799e
	farcall FarPtr_0a_08 ; $79a0
	ld a, $0d ; $79a3
	farcall FarPtr_0a_0a ; $79a5
	farcall FarPtr_0a_12 ; $79a8
	farcall FarPtr_0a_0c ; $79ab
	push af ; $79ae
	ld a, $05 ; $79af
	farcall FarPtr_0a_04 ; $79b1
	pop af ; $79b4
	and a, a ; $79b5
	jp z, Label_15_79bc ; $79b6
	jp Label_15_7a16 ; $79b9
Label_15_79bc:
	farcall FarPtr_0a_10 ; $79bc
	ld a, $0d ; $79bf
	farcall FarPtr_0a_08 ; $79c1
	call Func_15_7bc9 ; $79c4
	farcall FarPtr_0a_02 ; $79c7
	ret ; $79ca
Func_15_79cb:
	xor a, a ; $79cb
	ld [$c2d5], a ; $79cc
	ld bc, $00f0 ; $79cf
	farcall FarPtr_0a_38 ; $79d2
	ld a, $00 ; $79d5
	ld bc, $1300 ; $79d7
	ld de, $2b00 ; $79da
	farcall FarPtr_0a_22 ; $79dd
	ld a, $02 ; $79e0
	ld bc, $1100 ; $79e2
	ld de, $2b00 ; $79e5
	farcall FarPtr_0a_22 ; $79e8
	xor a, a ; $79eb
	ld bc, $1300 ; $79ec
	ld de, $2b00 ; $79ef
	farcall FarPtr_0a_3a ; $79f2
	farcall FarPtr_0a_3e ; $79f5
	ld a, $00 ; $79f8
	ld b, $c0 ; $79fa
	farcall FarPtr_0a_2e ; $79fc
	ld a, $02 ; $79ff
	ld b, $c0 ; $7a01
	farcall FarPtr_0a_2e ; $7a03
	ld a, $0d ; $7a06
	ld b, $40 ; $7a08
	farcall FarPtr_0a_2e ; $7a0a
	ld c, $04 ; $7a0d
	call Func_00_1d2e ; $7a0f
	call Func_00_1da4 ; $7a12
	ret ; $7a15
Label_15_7a16:
	ld a, $0d ; $7a16
	farcall FarPtr_0a_08 ; $7a18
	ld a, $0d ; $7a1b
	ld b, $c0 ; $7a1d
	farcall FarPtr_0a_2e ; $7a1f
	ret ; $7a22
	INCBIN "data/bank_015/d_7a23.bin" ; $7a23, 34 bytes
Func_15_7a45:
	rst Rst30 ; $7a45
	ldh [rTIMA], a ; $7a46
	jp nz, Label_15_7a66 ; $7a48
	ld a, [wEquippedRacket] ; $7a4b
	and a, $0f ; $7a4e
	cp a, $03 ; $7a50
	jp nz, Label_15_7a66 ; $7a52
	rst Rst30 ; $7a55
	nop ; $7a56
	INCBIN "data/bank_015/d_7a57.bin" ; $7a57, 15 bytes
Label_15_7a66:
	ret ; $7a66
Func_15_7a67:
	ld a, [$c8f7] ; $7a67
	cp a, $06 ; $7a6a
	jr nc, Label_15_7a75 ; $7a6c
	call Func_15_74e1 ; $7a6e
	call Func_15_7a96 ; $7a71
	ret ; $7a74
Label_15_7a75:
	cp a, $0c ; $7a75
	jr nc, Label_15_7a8b ; $7a77
	call Func_15_7752 ; $7a79
	ld hl, $1c6a ; $7a7c
	farcall FarPtr_0a_0e ; $7a7f
	ld a, $12 ; $7a82
	farcall FarPtr_0a_08 ; $7a84
	call Func_15_7b30 ; $7a87
	ret ; $7a8a
Label_15_7a8b:
	cp a, $12 ; $7a8b
	jr nc, Label_15_7a95 ; $7a8d
	call Func_15_79cb ; $7a8f
	call Func_15_7bc9 ; $7a92
Label_15_7a95:
	ret ; $7a95
Func_15_7a96:
	ld a, $02 ; $7a96
	farcall FarPtr_0a_1c ; $7a98
	ld bc, $0020 ; $7a9b
	farcall FarPtr_0a_38 ; $7a9e
	push af ; $7aa1
	ld a, $14 ; $7aa2
	farcall FarPtr_0a_04 ; $7aa4
	pop af ; $7aa7
	ldh a, [$ff95] ; $7aa8
	ld b, a ; $7aaa
	ld a, $07 ; $7aab
	ld de, $7b03 ; $7aad
	farcall FarPtr_0a_1a ; $7ab0
	ldh a, [$ff95] ; $7ab3
	ld b, a ; $7ab5
	ld a, $00 ; $7ab6
	ld de, $7b1a ; $7ab8
	farcall FarPtr_0a_1a ; $7abb
	ldh a, [$ff95] ; $7abe
	ld b, a ; $7ac0
	ld a, $02 ; $7ac1
	ld de, $7b25 ; $7ac3
	farcall FarPtr_0a_1a ; $7ac6
	xor a, a ; $7ac9
	ld bc, $1800 ; $7aca
	ld de, $0f00 ; $7acd
	farcall FarPtr_0a_3a ; $7ad0
	ld a, $00 ; $7ad3
	farcall FarPtr_0a_1e ; $7ad5
	farcall FarPtr_0a_3e ; $7ad8
	ld a, $07 ; $7adb
	farcall FarPtr_0a_1e ; $7add
	push af ; $7ae0
	ld a, $05 ; $7ae1
	farcall FarPtr_0a_04 ; $7ae3
	pop af ; $7ae6
	call Func_15_6647 ; $7ae7
	ld a, $0f ; $7aea
	ld [wStoryModeCurrentLocation], a ; $7aec
	ld a, $0a ; $7aef
	ld [$c295], a ; $7af1
	ld a, $ff ; $7af4
	ld [$c294], a ; $7af6
	ld [$c2a1], a ; $7af9
	ld a, [$c8f7] ; $7afc
	farcall FarPtr_0b_00 ; $7aff
	ret ; $7b02
	INCBIN "data/bank_015/d_7b03.bin" ; $7b03, 45 bytes
Func_15_7b30:
	ld bc, $0020 ; $7b30
	farcall FarPtr_0a_38 ; $7b33
	ld a, $02 ; $7b36
	farcall FarPtr_0a_1c ; $7b38
	ldh a, [$ff95] ; $7b3b
	ld b, a ; $7b3d
	ld a, $12 ; $7b3e
	ld de, $7b96 ; $7b40
	farcall FarPtr_0a_1a ; $7b43
	ldh a, [$ff95] ; $7b46
	ld b, a ; $7b48
	ld a, $00 ; $7b49
	ld de, $7bb3 ; $7b4b
	farcall FarPtr_0a_1a ; $7b4e
	ldh a, [$ff95] ; $7b51
	ld b, a ; $7b53
	ld a, $02 ; $7b54
	ld de, $7bbe ; $7b56
	farcall FarPtr_0a_1a ; $7b59
	xor a, a ; $7b5c
	ld bc, $2800 ; $7b5d
	ld de, $2600 ; $7b60
	farcall FarPtr_0a_3a ; $7b63
	ld a, $00 ; $7b66
	farcall FarPtr_0a_1e ; $7b68
	farcall FarPtr_0a_3e ; $7b6b
	ld a, $12 ; $7b6e
	farcall FarPtr_0a_1e ; $7b70
	push af ; $7b73
	ld a, $05 ; $7b74
	farcall FarPtr_0a_04 ; $7b76
	pop af ; $7b79
	call Func_15_6647 ; $7b7a
	ld a, $0f ; $7b7d
	ld [wStoryModeCurrentLocation], a ; $7b7f
	ld a, $0a ; $7b82
	ld [$c295], a ; $7b84
	ld a, $ff ; $7b87
	ld [$c294], a ; $7b89
	ld [$c2a1], a ; $7b8c
	ld a, [$c8f7] ; $7b8f
	farcall FarPtr_0b_00 ; $7b92
	ret ; $7b95
	INCBIN "data/bank_015/d_7b96.bin" ; $7b96, 51 bytes
Func_15_7bc9:
	ld a, $02 ; $7bc9
	farcall FarPtr_0a_1c ; $7bcb
	ld bc, $0020 ; $7bce
	farcall FarPtr_0a_38 ; $7bd1
	ldh a, [$ff95] ; $7bd4
	ld b, a ; $7bd6
	ld a, $0d ; $7bd7
	ld de, $7c2f ; $7bd9
	farcall FarPtr_0a_1a ; $7bdc
	ldh a, [$ff95] ; $7bdf
	ld b, a ; $7be1
	ld a, $00 ; $7be2
	ld de, $7c4c ; $7be4
	farcall FarPtr_0a_1a ; $7be7
	ldh a, [$ff95] ; $7bea
	ld b, a ; $7bec
	ld a, $02 ; $7bed
	ld de, $7c57 ; $7bef
	farcall FarPtr_0a_1a ; $7bf2
	xor a, a ; $7bf5
	ld bc, $1800 ; $7bf6
	ld de, $2700 ; $7bf9
	farcall FarPtr_0a_3a ; $7bfc
	ld a, $00 ; $7bff
	farcall FarPtr_0a_1e ; $7c01
	farcall FarPtr_0a_3e ; $7c04
	ld a, $0d ; $7c07
	farcall FarPtr_0a_1e ; $7c09
	push af ; $7c0c
	ld a, $05 ; $7c0d
	farcall FarPtr_0a_04 ; $7c0f
	pop af ; $7c12
	call Func_15_6647 ; $7c13
	ld a, $0f ; $7c16
	ld [wStoryModeCurrentLocation], a ; $7c18
	ld a, $0a ; $7c1b
	ld [$c295], a ; $7c1d
	ld a, $ff ; $7c20
	ld [$c294], a ; $7c22
	ld [$c2a1], a ; $7c25
	ld a, [$c8f7] ; $7c28
	farcall FarPtr_0b_00 ; $7c2b
	ret ; $7c2e
	INCBIN "data/bank_015/d_7c2f.bin" ; $7c2f, 140 bytes
Func_15_7cbb:
	ld a, $00 ; $7cbb
	ld bc, $0010 ; $7cbd
	farcall FarPtr_0a_18 ; $7cc0
	ld a, $02 ; $7cc3
	ld bc, $0010 ; $7cc5
	farcall FarPtr_0a_18 ; $7cc8
	ld a, $00 ; $7ccb
	ld bc, $2d00 ; $7ccd
	ld de, $2b00 ; $7cd0
	farcall FarPtr_0a_24 ; $7cd3
	rst Rst30 ; $7cd6
	ldh [rTIMA], a ; $7cd7
	jr z, Label_15_7cf0 ; $7cd9
	ld a, $02 ; $7cdb
	farcall FarPtr_0a_1c ; $7cdd
	ld a, $02 ; $7ce0
	ld bc, $2f00 ; $7ce2
	ld de, $2b00 ; $7ce5
	farcall FarPtr_0a_24 ; $7ce8
	ld a, $02 ; $7ceb
	farcall FarPtr_0a_20 ; $7ced
Label_15_7cf0:
	ld a, $00 ; $7cf0
	farcall FarPtr_0a_20 ; $7cf2
	ld a, $00 ; $7cf5
	ld b, $80 ; $7cf7
	farcall FarPtr_0a_2e ; $7cf9
	ld a, $02 ; $7cfc
	ld b, $80 ; $7cfe
	farcall FarPtr_0a_2e ; $7d00
	ld a, $00 ; $7d03
	ld bc, $0020 ; $7d05
	farcall FarPtr_0a_18 ; $7d08
	ld a, $02 ; $7d0b
	ld bc, $0020 ; $7d0d
	farcall FarPtr_0a_18 ; $7d10
	ret ; $7d13
Func_15_7d14:
	ld a, $00 ; $7d14
	ld bc, $0010 ; $7d16
	farcall FarPtr_0a_18 ; $7d19
	ld a, $02 ; $7d1c
	ld bc, $0010 ; $7d1e
	farcall FarPtr_0a_18 ; $7d21
	ld a, $00 ; $7d24
	ld bc, $1300 ; $7d26
	ld de, $2b00 ; $7d29
	farcall FarPtr_0a_24 ; $7d2c
	rst Rst30 ; $7d2f
	ldh [rTIMA], a ; $7d30
	jr z, Label_15_7d49 ; $7d32
	ld a, $02 ; $7d34
	farcall FarPtr_0a_1c ; $7d36
	ld a, $02 ; $7d39
	ld bc, $1100 ; $7d3b
	ld de, $2b00 ; $7d3e
	farcall FarPtr_0a_24 ; $7d41
	ld a, $02 ; $7d44
	farcall FarPtr_0a_20 ; $7d46
Label_15_7d49:
	ld a, $00 ; $7d49
	farcall FarPtr_0a_20 ; $7d4b
	ld a, $00 ; $7d4e
	ld b, $00 ; $7d50
	farcall FarPtr_0a_2e ; $7d52
	ld a, $02 ; $7d55
	ld b, $00 ; $7d57
	farcall FarPtr_0a_2e ; $7d59
	ld a, $00 ; $7d5c
	ld bc, $0020 ; $7d5e
	farcall FarPtr_0a_18 ; $7d61
	ld a, $02 ; $7d64
	ld bc, $0020 ; $7d66
	farcall FarPtr_0a_18 ; $7d69
	ret ; $7d6c
	INCBIN "data/bank_015/d_7d6d.bin" ; $7d6d, 40 bytes
	ret ; $7d95
	INCBIN "data/bank_015/d_7d96.bin" ; $7d96, 522 bytes
Func_15_7fa0:
	ld a, $00 ; $7fa0
	rst Rst30 ; $7fa2
	ld h, b ; $7fa3
	ld a, [bc] ; $7fa4
	jr z, Label_15_7fbf ; $7fa5
	inc a ; $7fa7
	rst Rst30 ; $7fa8
	ldh [$ff0a], a ; $7fa9
	jr z, Label_15_7fbf ; $7fab
	inc a ; $7fad
	rst Rst30 ; $7fae
	ldh [rTIMA], a ; $7faf
	jr nz, Label_15_7fc3 ; $7fb1
	rst Rst30 ; $7fb3
	ret nz ; $7fb4
	dec d ; $7fb5
	jr z, Label_15_7fbf ; $7fb6
	inc a ; $7fb8
	rst Rst30 ; $7fb9
	nop ; $7fba
	ld d, $28 ; $7fbb
	INCBIN "data/bank_015/d_7fbd.bin" ; $7fbd, 2 bytes
Label_15_7fbf:
	ld [$c2b0], a ; $7fbf
	ret ; $7fc2
Label_15_7fc3:
	rst Rst30 ; $7fc3
	ldh [$ff15], a ; $7fc4
	jr z, Label_15_7fbf ; $7fc6
	inc a ; $7fc8
	rst Rst30 ; $7fc9
	jr nz, Label_15_7fe2 ; $7fca
	jr z, Label_15_7fbf ; $7fcc
	inc a ; $7fce
	jr Label_15_7fbf ; $7fcf
	INCBIN "data/bank_015/d_7fd1.bin" ; $7fd1, 17 bytes
Label_15_7fe2:
	rst Rst38 ; $7fe2
	rst Rst38 ; $7fe3
	rst Rst38 ; $7fe4
	rst Rst38 ; $7fe5
	rst Rst38 ; $7fe6
	rst Rst38 ; $7fe7
	rst Rst38 ; $7fe8
	rst Rst38 ; $7fe9
	rst Rst38 ; $7fea
	rst Rst38 ; $7feb
	rst Rst38 ; $7fec
	rst Rst38 ; $7fed
	rst Rst38 ; $7fee
	rst Rst38 ; $7fef
	rst Rst38 ; $7ff0
	rst Rst38 ; $7ff1
	rst Rst38 ; $7ff2
	rst Rst38 ; $7ff3
	rst Rst38 ; $7ff4
	rst Rst38 ; $7ff5
	rst Rst38 ; $7ff6
	rst Rst38 ; $7ff7
	rst Rst38 ; $7ff8
	rst Rst38 ; $7ff9
	rst Rst38 ; $7ffa
	rst Rst38 ; $7ffb
	rst Rst38 ; $7ffc
	rst Rst38 ; $7ffd
	rst Rst38 ; $7ffe
	rst Rst38 ; $7fff
