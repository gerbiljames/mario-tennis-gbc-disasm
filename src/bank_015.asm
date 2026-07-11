INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $15", ROMX[$4000], BANK[$15]

DataPtr_15_00:
	dw Data_15_4004 ; $4000
DataPtr_15_02:
	dw Data_15_4796 ; $4002
Data_15_4004:
	INCBIN "data/bank_015/d_4004.bin" ; $4004, 1938 bytes
Data_15_4796:
	INCBIN "data/bank_015/d_4796.bin" ; $4796, 14 bytes
	INCBIN "data/bank_015/d_47a4.bin" ; $47a4, 361 bytes
	ld a, [$c295] ; $490d
	cp a, $ff ; $4910
	jp z, Label_15_4955 ; $4912
	call Func_15_4967 ; $4915
	test_flag $05, 7 ; $4918
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
	clear_flag $17, 2 ; $4967
	clear_flag $17, 5 ; $496a
	clear_flag $17, 3 ; $496d
	clear_flag $17, 6 ; $4970
	clear_flag $17, 4 ; $4973
	clear_flag $17, 7 ; $4976
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
	INCBIN "data/bank_015/d_49d3.bin" ; $49d3, 76 bytes
	ld a, [$c2b0] ; $4a1f
	add a, a ; $4a22
	add a, $36 ; $4a23
	ld l, a ; $4a25
	adc a, $4a ; $4a26
	sub a, l ; $4a28
	ld h, a ; $4a29
	ld a, [hl+] ; $4a2a
	ld h, [hl] ; $4a2b
	ld l, a ; $4a2c
	farcall FarPtr_0a_0e ; $4a2d
	ld a, $0a ; $4a30
	farcall FarPtr_0a_08 ; $4a32
	ret ; $4a35
	INCBIN "data/bank_015/d_4a36.bin" ; $4a36, 60 bytes
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
	test_flag $19, 1 ; $51eb
	jr nz, Label_15_51f4 ; $51ee
	call Func_15_6fcf ; $51f0
	ret ; $51f3
Label_15_51f4:
	test_flag $19, 2 ; $51f4
	jr nz, Label_15_521e ; $51f7
	test_flag $17, 6 ; $51f9
	jr nz, Label_15_5207 ; $51fc
	test_flag $0a, 3 ; $51fe
	jr z, Label_15_5207 ; $5201
	call Func_15_706e ; $5203
	ret ; $5206
Label_15_5207:
	ld hl, $1c80 ; $5207
	farcall FarPtr_0a_0e ; $520a
	test_flag $0a, 7 ; $520d
	jr z, Label_15_5218 ; $5210
	ld hl, $1c83 ; $5212
	farcall FarPtr_0a_0e ; $5215
Label_15_5218:
	ld a, $12 ; $5218
	farcall FarPtr_0a_08 ; $521a
	ret ; $521d
Label_15_521e:
	test_flag $19, 3 ; $521e
	jr nz, Label_15_5248 ; $5221
	test_flag $17, 6 ; $5223
	jr nz, Label_15_5231 ; $5226
	test_flag $0a, 7 ; $5228
	jr z, Label_15_5231 ; $522b
	call Func_15_711d ; $522d
	ret ; $5230
Label_15_5231:
	ld hl, $1c9e ; $5231
	farcall FarPtr_0a_0e ; $5234
	test_flag $0a, 7 ; $5237
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
	test_flag $19, 7 ; $5297
	jr nz, Label_15_52a0 ; $529a
	call Func_15_6db4 ; $529c
	ret ; $529f
Label_15_52a0:
	test_flag $1a, 0 ; $52a0
	jr nz, Label_15_52d5 ; $52a3
	test_flag $17, 7 ; $52a5
	jr nz, Label_15_52b3 ; $52a8
	test_flag $0a, 3 ; $52aa
	jr z, Label_15_52b3 ; $52ad
	call Func_15_6e4b ; $52af
	ret ; $52b2
Label_15_52b3:
	ld hl, $1ce1 ; $52b3
	farcall FarPtr_0a_0e ; $52b6
	test_flag $0a, 3 ; $52b9
	jr z, Label_15_52cf ; $52bc
	ld hl, $1ce2 ; $52be
	farcall FarPtr_0a_0e ; $52c1
	test_flag $0a, 7 ; $52c4
	jr z, Label_15_52cf ; $52c7
	ld hl, $1ce2 ; $52c9
	farcall FarPtr_0a_0e ; $52cc
Label_15_52cf:
	ld a, $0d ; $52cf
	farcall FarPtr_0a_08 ; $52d1
	ret ; $52d4
Label_15_52d5:
	test_flag $1a, 1 ; $52d5
	jr nz, Label_15_52f4 ; $52d8
	test_flag $17, 7 ; $52da
	jr nz, Label_15_52e8 ; $52dd
	test_flag $0a, 7 ; $52df
	jr z, Label_15_52e8 ; $52e2
	call Func_15_6ece ; $52e4
	ret ; $52e7
Label_15_52e8:
	ld hl, $1cf8 ; $52e8
	farcall FarPtr_0a_0e ; $52eb
	ld a, $0d ; $52ee
	farcall FarPtr_0a_08 ; $52f0
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
	dw Label_15_5e85 ; $5385 jumptable
	dw Label_15_5eb7 ; $5387 jumptable
	dw Label_15_5edf ; $5389 jumptable
	dw Label_15_7290 ; $538b jumptable
	dw Label_15_729f ; $538d jumptable
	dw Label_15_72b4 ; $538f jumptable
	dw Label_15_62bf ; $5391 jumptable
	dw Label_15_6300 ; $5393 jumptable
	dw Label_15_6328 ; $5395 jumptable
	dw Label_15_7539 ; $5397 jumptable
	dw Label_15_754e ; $5399 jumptable
	dw Label_15_7563 ; $539b jumptable
	dw Label_15_6350 ; $539d jumptable
	dw Label_15_6391 ; $539f jumptable
	dw Label_15_63b9 ; $53a1 jumptable
	dw Label_15_77aa ; $53a3 jumptable
	dw Label_15_77bd ; $53a5 jumptable
	dw Label_15_77d0 ; $53a7 jumptable
Func_15_53a9:
	ld a, [$c8f7] ; $53a9
	ld a, a ; $53ac
	rst Rst00 ; $53ad
	dw Label_15_53d2 ; $53ae jumptable
	dw Label_15_53d2 ; $53b0 jumptable
	dw Label_15_53d2 ; $53b2 jumptable
	dw Label_15_5437 ; $53b4 jumptable
	dw Label_15_5437 ; $53b6 jumptable
	dw Label_15_5437 ; $53b8 jumptable
	dw Label_15_5482 ; $53ba jumptable
	dw Label_15_5482 ; $53bc jumptable
	dw Label_15_5482 ; $53be jumptable
	dw Label_15_54e7 ; $53c0 jumptable
	dw Label_15_54e7 ; $53c2 jumptable
	dw Label_15_54e7 ; $53c4 jumptable
	dw Label_15_5532 ; $53c6 jumptable
	dw Label_15_5532 ; $53c8 jumptable
	dw Label_15_5532 ; $53ca jumptable
	dw Label_15_5597 ; $53cc jumptable
	dw Label_15_5597 ; $53ce jumptable
	dw Label_15_5597 ; $53d0 jumptable
Label_15_53d2:
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
Label_15_5437:
	xor a, a ; $5437
	ld [$c2d5], a ; $5438
	ld bc, $00f0 ; $543b
	farcall FarPtr_0a_38 ; $543e
	ld a, $00 ; $5441
	ld bc, $1300 ; $5443
	ld de, $1300 ; $5446
	farcall FarPtr_0a_22 ; $5449
	ld a, $02 ; $544c
	ld bc, $1300 ; $544e
	ld de, $1100 ; $5451
	farcall FarPtr_0a_22 ; $5454
	xor a, a ; $5457
	ld bc, $1300 ; $5458
	ld de, $1300 ; $545b
	farcall FarPtr_0a_3a ; $545e
	farcall FarPtr_0a_3e ; $5461
	ld a, $00 ; $5464
	ld b, $40 ; $5466
	farcall FarPtr_0a_2e ; $5468
	ld a, $02 ; $546b
	ld b, $40 ; $546d
	farcall FarPtr_0a_2e ; $546f
	ld a, $07 ; $5472
	ld b, $80 ; $5474
	farcall FarPtr_0a_2e ; $5476
	ld c, $04 ; $5479
	call Func_00_1d2e ; $547b
	call Func_00_1da4 ; $547e
	ret ; $5481
Label_15_5482:
	xor a, a ; $5482
	ld [$c2d5], a ; $5483
	ld a, $11 ; $5486
	ld [$c2b1], a ; $5488
	ld a, $00 ; $548b
	ld bc, $2800 ; $548d
	ld de, $2a00 ; $5490
	farcall FarPtr_0a_22 ; $5493
	ld a, $00 ; $5496
	ld b, $c0 ; $5498
	farcall FarPtr_0a_2e ; $549a
	ld a, [$c2b1] ; $549d
	ld bc, $2800 ; $54a0
	ld de, $2500 ; $54a3
	farcall FarPtr_0a_22 ; $54a6
	ld a, [$c2b1] ; $54a9
	ld b, $40 ; $54ac
	farcall FarPtr_0a_2e ; $54ae
	ld a, $02 ; $54b1
	farcall FarPtr_0a_1c ; $54b3
	ld a, $02 ; $54b6
	ld bc, $2d00 ; $54b8
	ld de, $2d00 ; $54bb
	farcall FarPtr_0a_22 ; $54be
	ld a, $02 ; $54c1
	ld b, $80 ; $54c3
	farcall FarPtr_0a_2e ; $54c5
	ld bc, $00f0 ; $54c8
	farcall FarPtr_0a_38 ; $54cb
	xor a, a ; $54ce
	ld bc, $2800 ; $54cf
	ld de, $2900 ; $54d2
	farcall FarPtr_0a_3a ; $54d5
	farcall FarPtr_0a_3e ; $54d8
	ld c, $08 ; $54db
	call Func_00_1d2e ; $54dd
	call Func_00_1da4 ; $54e0
	call Func_15_6179 ; $54e3
	ret ; $54e6
Label_15_54e7:
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
Label_15_5532:
	xor a, a ; $5532
	ld [$c2d5], a ; $5533
	ld a, $0c ; $5536
	ld [$c2b1], a ; $5538
	ld a, $00 ; $553b
	ld bc, $1800 ; $553d
	ld de, $2a00 ; $5540
	farcall FarPtr_0a_22 ; $5543
	ld a, $00 ; $5546
	ld b, $c0 ; $5548
	farcall FarPtr_0a_2e ; $554a
	ld a, [$c2b1] ; $554d
	ld bc, $1800 ; $5550
	ld de, $2500 ; $5553
	farcall FarPtr_0a_22 ; $5556
	ld a, [$c2b1] ; $5559
	ld b, $40 ; $555c
	farcall FarPtr_0a_2e ; $555e
	ld a, $02 ; $5561
	farcall FarPtr_0a_1c ; $5563
	ld a, $02 ; $5566
	ld bc, $1300 ; $5568
	ld de, $2d00 ; $556b
	farcall FarPtr_0a_22 ; $556e
	ld a, $02 ; $5571
	ld b, $00 ; $5573
	farcall FarPtr_0a_2e ; $5575
	ld bc, $00f0 ; $5578
	farcall FarPtr_0a_38 ; $557b
	xor a, a ; $557e
	ld bc, $1800 ; $557f
	ld de, $2800 ; $5582
	farcall FarPtr_0a_3a ; $5585
	farcall FarPtr_0a_3e ; $5588
	ld c, $08 ; $558b
	call Func_00_1d2e ; $558d
	call Func_00_1da4 ; $5590
	call Func_15_6179 ; $5593
	ret ; $5596
Label_15_5597:
	xor a, a ; $5597
	ld [$c2d5], a ; $5598
	ld bc, $00f0 ; $559b
	farcall FarPtr_0a_38 ; $559e
	ld a, $00 ; $55a1
	ld bc, $1300 ; $55a3
	ld de, $2b00 ; $55a6
	farcall FarPtr_0a_22 ; $55a9
	ld a, $02 ; $55ac
	ld bc, $1100 ; $55ae
	ld de, $2b00 ; $55b1
	farcall FarPtr_0a_22 ; $55b4
	xor a, a ; $55b7
	ld bc, $1300 ; $55b8
	ld de, $2b00 ; $55bb
	farcall FarPtr_0a_3a ; $55be
	farcall FarPtr_0a_3e ; $55c1
	ld a, $00 ; $55c4
	ld b, $c0 ; $55c6
	farcall FarPtr_0a_2e ; $55c8
	ld a, $02 ; $55cb
	ld b, $c0 ; $55cd
	farcall FarPtr_0a_2e ; $55cf
	ld a, $0d ; $55d2
	ld b, $c0 ; $55d4
	farcall FarPtr_0a_2e ; $55d6
	ld c, $04 ; $55d9
	call Func_00_1d2e ; $55db
	call Func_00_1da4 ; $55de
	ret ; $55e1
	INCBIN "data/bank_015/d_55e2.bin" ; $55e2, 990 bytes
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
	INCBIN "data/bank_015/d_5c4f.bin" ; $5c4f, 164 bytes
Func_15_5cf3:
	xor a, a ; $5cf3
	ld [$c2d5], a ; $5cf4
	ld a, $06 ; $5cf7
	ld [$c2b1], a ; $5cf9
	ld a, $00 ; $5cfc
	ld bc, $1800 ; $5cfe
	ld de, $1100 ; $5d01
	farcall FarPtr_0a_22 ; $5d04
	ld a, $00 ; $5d07
	ld b, $c0 ; $5d09
	farcall FarPtr_0a_2e ; $5d0b
	ld a, [$c2b1] ; $5d0e
	ld bc, $1800 ; $5d11
	ld de, $0d00 ; $5d14
	farcall FarPtr_0a_22 ; $5d17
	ld a, [$c2b1] ; $5d1a
	ld b, $40 ; $5d1d
	farcall FarPtr_0a_2e ; $5d1f
	ld a, $02 ; $5d22
	farcall FarPtr_0a_1c ; $5d24
	ld a, $02 ; $5d27
	ld bc, $1300 ; $5d29
	ld de, $1100 ; $5d2c
	farcall FarPtr_0a_22 ; $5d2f
	ld a, $02 ; $5d32
	ld b, $00 ; $5d34
	farcall FarPtr_0a_2e ; $5d36
	ld bc, $00f0 ; $5d39
	farcall FarPtr_0a_38 ; $5d3c
	xor a, a ; $5d3f
	ld bc, $1800 ; $5d40
	ld de, $0f00 ; $5d43
	farcall FarPtr_0a_3a ; $5d46
	farcall FarPtr_0a_3e ; $5d49
	ld c, $08 ; $5d4c
	call Func_00_1d2e ; $5d4e
	call Func_00_1da4 ; $5d51
	ld a, [wPointWinLoseFlag] ; $5d54
	inc a ; $5d57
	cp a, $01 ; $5d58
	jr nz, Label_15_5d69 ; $5d5a
	ld hl, $c2b2 ; $5d5c
	ld de, $201d ; $5d5f
	ld a, e ; $5d62
	ld [hl+], a ; $5d63
	ld [hl], d ; $5d64
	ld a, [wPointWinLoseFlag] ; $5d65
	inc a ; $5d68
Label_15_5d69:
	ld a, a ; $5d69
	rst Rst00 ; $5d6a
	dw Label_15_5f58 ; $5d6b jumptable
	dw Label_15_5f07 ; $5d6d jumptable
	dw Label_15_5fc2 ; $5d6f jumptable
	dw Label_15_5e74 ; $5d71 jumptable
	INCBIN "data/bank_015/d_5d73.bin" ; $5d73, 1 bytes
Func_15_5d74:
	xor a, a ; $5d74
	ld [$c2d5], a ; $5d75
	ld a, $11 ; $5d78
	ld [$c2b1], a ; $5d7a
	ld a, $00 ; $5d7d
	ld bc, $2800 ; $5d7f
	ld de, $2a00 ; $5d82
	farcall FarPtr_0a_22 ; $5d85
	ld a, $00 ; $5d88
	ld b, $c0 ; $5d8a
	farcall FarPtr_0a_2e ; $5d8c
	ld a, [$c2b1] ; $5d8f
	ld bc, $2800 ; $5d92
	ld de, $2500 ; $5d95
	farcall FarPtr_0a_22 ; $5d98
	ld a, [$c2b1] ; $5d9b
	ld b, $40 ; $5d9e
	farcall FarPtr_0a_2e ; $5da0
	ld a, $02 ; $5da3
	farcall FarPtr_0a_1c ; $5da5
	ld a, $02 ; $5da8
	ld bc, $2d00 ; $5daa
	ld de, $2d00 ; $5dad
	farcall FarPtr_0a_22 ; $5db0
	ld a, $02 ; $5db3
	ld b, $80 ; $5db5
	farcall FarPtr_0a_2e ; $5db7
	ld bc, $00f0 ; $5dba
	farcall FarPtr_0a_38 ; $5dbd
	xor a, a ; $5dc0
	ld bc, $2800 ; $5dc1
	ld de, $2900 ; $5dc4
	farcall FarPtr_0a_3a ; $5dc7
	farcall FarPtr_0a_3e ; $5dca
	ld c, $08 ; $5dcd
	call Func_00_1d2e ; $5dcf
	call Func_00_1da4 ; $5dd2
	ld a, [wPointWinLoseFlag] ; $5dd5
	inc a ; $5dd8
	cp a, $01 ; $5dd9
	jr nz, Label_15_5dea ; $5ddb
	ld hl, $c2b2 ; $5ddd
	ld de, $204a ; $5de0
	ld a, e ; $5de3
	ld [hl+], a ; $5de4
	ld [hl], d ; $5de5
	ld a, [wPointWinLoseFlag] ; $5de6
	inc a ; $5de9
Label_15_5dea:
	ld a, a ; $5dea
	rst Rst00 ; $5deb
	dw Label_15_5f58 ; $5dec jumptable
	dw Label_15_5f07 ; $5dee jumptable
	dw Label_15_5fc2 ; $5df0 jumptable
	INCBIN "data/bank_015/d_5df2.bin" ; $5df2, 1 bytes
Func_15_5df3:
	xor a, a ; $5df3
	ld [$c2d5], a ; $5df4
	ld a, $0c ; $5df7
	ld [$c2b1], a ; $5df9
	ld a, $00 ; $5dfc
	ld bc, $1800 ; $5dfe
	ld de, $2a00 ; $5e01
	farcall FarPtr_0a_22 ; $5e04
	ld a, $00 ; $5e07
	ld b, $c0 ; $5e09
	farcall FarPtr_0a_2e ; $5e0b
	ld a, [$c2b1] ; $5e0e
	ld bc, $1800 ; $5e11
	ld de, $2500 ; $5e14
	farcall FarPtr_0a_22 ; $5e17
	ld a, [$c2b1] ; $5e1a
	ld b, $40 ; $5e1d
	farcall FarPtr_0a_2e ; $5e1f
	ld a, $02 ; $5e22
	farcall FarPtr_0a_1c ; $5e24
	ld a, $02 ; $5e27
	ld bc, $1300 ; $5e29
	ld de, $2d00 ; $5e2c
	farcall FarPtr_0a_22 ; $5e2f
	ld a, $02 ; $5e32
	ld b, $00 ; $5e34
	farcall FarPtr_0a_2e ; $5e36
	ld bc, $00f0 ; $5e39
	farcall FarPtr_0a_38 ; $5e3c
	xor a, a ; $5e3f
	ld bc, $1800 ; $5e40
	ld de, $2800 ; $5e43
	farcall FarPtr_0a_3a ; $5e46
	farcall FarPtr_0a_3e ; $5e49
	ld c, $08 ; $5e4c
	call Func_00_1d2e ; $5e4e
	call Func_00_1da4 ; $5e51
	ld a, [wPointWinLoseFlag] ; $5e54
	inc a ; $5e57
	cp a, $01 ; $5e58
	jr nz, Label_15_5e69 ; $5e5a
	ld hl, $c2b2 ; $5e5c
	ld de, $2078 ; $5e5f
	ld a, e ; $5e62
	ld [hl+], a ; $5e63
	ld [hl], d ; $5e64
	ld a, [wPointWinLoseFlag] ; $5e65
	inc a ; $5e68
Label_15_5e69:
	ld a, a ; $5e69
	rst Rst00 ; $5e6a
	dw Label_15_5f58 ; $5e6b jumptable
	dw Label_15_5f07 ; $5e6d jumptable
	dw Label_15_5fc2 ; $5e6f jumptable
	dw Label_15_5e74 ; $5e71 jumptable
	INCBIN "data/bank_015/d_5e73.bin" ; $5e73, 1 bytes
Label_15_5e74:
	ld a, $00 ; $5e74
	ld de, rLCDC ; $5e76
	farcall FarPtr_0a_42 ; $5e79
	ld a, $00 ; $5e7c
	farcall FarPtr_0a_44 ; $5e7e
	jp Label_15_5f58 ; $5e81
	INCBIN "data/bank_015/d_5e84.bin" ; $5e84, 1 bytes
Label_15_5e85:
	ld hl, wWaterSpriteMinigameFlag ; $5e85
	ld de, $2020 ; $5e88
	ld a, e ; $5e8b
	ld [hl+], a ; $5e8c
	ld [hl], d ; $5e8d
	ld hl, wWaterSpriteMinigameTimer ; $5e8e
	ld de, $201d ; $5e91
	ld a, e ; $5e94
	ld [hl+], a ; $5e95
	ld [hl], d ; $5e96
	ld hl, wWaterSpriteMinigameSwingCount ; $5e97
	test_flag $0a, 3 ; $5e9a
	jr z, Label_15_5ea4 ; $5e9d
	ld de, $2023 ; $5e9f
	jr Label_15_5ea7 ; $5ea2
Label_15_5ea4:
	ld de, $2022 ; $5ea4
Label_15_5ea7:
	ld a, e ; $5ea7
	ld [hl+], a ; $5ea8
	ld [hl], d ; $5ea9
	ld hl, $c2b8 ; $5eaa
	ld de, $2024 ; $5ead
	ld a, e ; $5eb0
	ld [hl+], a ; $5eb1
	ld [hl], d ; $5eb2
	call Func_15_5cf3 ; $5eb3
	ret ; $5eb6
Label_15_5eb7:
	ld hl, wWaterSpriteMinigameFlag ; $5eb7
	ld de, $2020 ; $5eba
	ld a, e ; $5ebd
	ld [hl+], a ; $5ebe
	ld [hl], d ; $5ebf
	ld hl, wWaterSpriteMinigameTimer ; $5ec0
	ld de, $201d ; $5ec3
	ld a, e ; $5ec6
	ld [hl+], a ; $5ec7
	ld [hl], d ; $5ec8
	ld hl, wWaterSpriteMinigameSwingCount ; $5ec9
	ld de, $2031 ; $5ecc
	ld a, e ; $5ecf
	ld [hl+], a ; $5ed0
	ld [hl], d ; $5ed1
	ld hl, $c2b8 ; $5ed2
	ld de, $2032 ; $5ed5
	ld a, e ; $5ed8
	ld [hl+], a ; $5ed9
	ld [hl], d ; $5eda
	call Func_15_5cf3 ; $5edb
	ret ; $5ede
Label_15_5edf:
	ld hl, wWaterSpriteMinigameFlag ; $5edf
	ld de, $2020 ; $5ee2
	ld a, e ; $5ee5
	ld [hl+], a ; $5ee6
	ld [hl], d ; $5ee7
	ld hl, wWaterSpriteMinigameTimer ; $5ee8
	ld de, $201d ; $5eeb
	ld a, e ; $5eee
	ld [hl+], a ; $5eef
	ld [hl], d ; $5ef0
	ld hl, wWaterSpriteMinigameSwingCount ; $5ef1
	ld de, $203d ; $5ef4
	ld a, e ; $5ef7
	ld [hl+], a ; $5ef8
	ld [hl], d ; $5ef9
	ld hl, $c2b8 ; $5efa
	ld de, $203e ; $5efd
	ld a, e ; $5f00
	ld [hl+], a ; $5f01
	ld [hl], d ; $5f02
	call Func_15_5cf3 ; $5f03
	ret ; $5f06
Label_15_5f07:
	ld hl, wWaterSpriteMinigameTimer ; $5f07
	ld a, [hl+] ; $5f0a
	ld h, [hl] ; $5f0b
	ld l, a ; $5f0c
	farcall FarPtr_0a_0e ; $5f0d
	ld a, [$c2b1] ; $5f10
	farcall FarPtr_0a_0a ; $5f13
	farcall FarPtr_0a_12 ; $5f16
	farcall FarPtr_0a_0c ; $5f19
	push af ; $5f1c
	ld a, $05 ; $5f1d
	farcall FarPtr_0a_04 ; $5f1f
	pop af ; $5f22
	and a, a ; $5f23
	jr nz, Label_15_5f48 ; $5f24
	ld a, [$c2b1] ; $5f26
	farcall FarPtr_0a_08 ; $5f29
	ld a, $0f ; $5f2c
	ld [wStoryModeCurrentLocation], a ; $5f2e
	ld a, $0a ; $5f31
	ld [$c295], a ; $5f33
	ld a, $ff ; $5f36
	ld [$c294], a ; $5f38
	ld [$c2a1], a ; $5f3b
	ld a, [$c8f7] ; $5f3e
	farcall FarPtr_0b_00 ; $5f41
	farcall FarPtr_0a_02 ; $5f44
	ret ; $5f47
Label_15_5f48:
	farcall FarPtr_0a_10 ; $5f48
	ld a, [$c2b1] ; $5f4b
	farcall FarPtr_0a_08 ; $5f4e
	call Func_15_6179 ; $5f51
	farcall FarPtr_0a_02 ; $5f54
	ret ; $5f57
Label_15_5f58:
	ld hl, wWaterSpriteMinigameSwingCount ; $5f58
	ld a, [hl+] ; $5f5b
	ld h, [hl] ; $5f5c
	ld l, a ; $5f5d
	farcall FarPtr_0a_0e ; $5f5e
	ld a, [$c2b1] ; $5f61
	farcall FarPtr_0a_0a ; $5f64
	farcall FarPtr_0a_12 ; $5f67
	farcall FarPtr_0a_0c ; $5f6a
	push af ; $5f6d
	ld a, $05 ; $5f6e
	farcall FarPtr_0a_04 ; $5f70
	pop af ; $5f73
	and a, a ; $5f74
	jr nz, Label_15_5fa2 ; $5f75
	ld hl, wWaterSpriteMinigameFlag ; $5f77
	ld a, [hl+] ; $5f7a
	ld h, [hl] ; $5f7b
	ld l, a ; $5f7c
	farcall FarPtr_0a_0e ; $5f7d
	ld a, [$c2b1] ; $5f80
	farcall FarPtr_0a_08 ; $5f83
	ld a, $0f ; $5f86
	ld [wStoryModeCurrentLocation], a ; $5f88
	ld a, $0a ; $5f8b
	ld [$c295], a ; $5f8d
	ld a, $ff ; $5f90
	ld [$c294], a ; $5f92
	ld [$c2a1], a ; $5f95
	ld a, [$c8f7] ; $5f98
	farcall FarPtr_0b_00 ; $5f9b
	farcall FarPtr_0a_02 ; $5f9e
	ret ; $5fa1
Label_15_5fa2:
	ld hl, wWaterSpriteMinigameFlag ; $5fa2
	ld a, [hl+] ; $5fa5
	ld h, [hl] ; $5fa6
	ld l, a ; $5fa7
	farcall FarPtr_0a_0e ; $5fa8
	farcall FarPtr_0a_10 ; $5fab
	ld a, [$c2b1] ; $5fae
	farcall FarPtr_0a_08 ; $5fb1
	call Func_15_6179 ; $5fb4
	farcall FarPtr_0a_02 ; $5fb7
	ret ; $5fba
	INCBIN "data/bank_015/d_5fbb.bin" ; $5fbb, 7 bytes
Label_15_5fc2:
	ld a, [$c2b1] ; $5fc2
	ld d, $02 ; $5fc5
	farcall FarPtr_0a_34 ; $5fc7
	ld a, [$c2b1] ; $5fca
	farcall FarPtr_0a_36 ; $5fcd
	ld hl, $c2b8 ; $5fd0
	ld a, [hl+] ; $5fd3
	ld h, [hl] ; $5fd4
	ld l, a ; $5fd5
	farcall FarPtr_0a_0e ; $5fd6
	ld a, [$c2b1] ; $5fd9
	farcall FarPtr_0a_08 ; $5fdc
	ld a, [$c2b1] ; $5fdf
	ld b, $01 ; $5fe2
	farcall FarPtr_0a_2c ; $5fe4
	ld a, [$c2b1] ; $5fe7
	ld b, $c0 ; $5fea
	ld de, $0100 ; $5fec
	farcall FarPtr_0a_2a ; $5fef
	ld a, [$c2b1] ; $5ff2
	farcall FarPtr_0a_20 ; $5ff5
	push af ; $5ff8
	ld a, $28 ; $5ff9
	farcall FarPtr_0a_04 ; $5ffb
	pop af ; $5ffe
	ld a, [$c2b1] ; $5fff
	ld b, $c0 ; $6002
	ld de, $0100 ; $6004
	farcall FarPtr_0a_2a ; $6007
	ld a, [$c2b1] ; $600a
	farcall FarPtr_0a_20 ; $600d
	ld a, [$c2b1] ; $6010
	ld d, $02 ; $6013
	farcall FarPtr_0a_34 ; $6015
	ld a, [$c2b1] ; $6018
	farcall FarPtr_0a_36 ; $601b
	ld a, [$c2b1] ; $601e
	farcall FarPtr_0a_08 ; $6021
	ld a, [$c2b1] ; $6024
	ld b, $00 ; $6027
	farcall FarPtr_0a_2c ; $6029
	call Func_15_6042 ; $602c
	ld a, [$c2b1] ; $602f
	ld bc, $3f00 ; $6032
	ld de, $3f00 ; $6035
	farcall FarPtr_0a_22 ; $6038
	call Func_15_6253 ; $603b
	farcall FarPtr_0a_02 ; $603e
	ret ; $6041
Func_15_6042:
	ld a, [$c8f7] ; $6042
	sub a, $0a ; $6045
	jp nc, Label_15_60f6 ; $6047
	ld a, [$c8f7] ; $604a
	sub a, $04 ; $604d
	jp c, Label_15_6056 ; $604f
	jp Label_15_60af ; $6052
	INCBIN "data/bank_015/d_6055.bin" ; $6055, 1 bytes
Label_15_6056:
	ld a, [$c2b1] ; $6056
	ld bc, $0030 ; $6059
	farcall FarPtr_0a_18 ; $605c
	ld a, [$c2b1] ; $605f
	farcall FarPtr_0a_16 ; $6062
	ld a, $04 ; $6065
	ld e, l ; $6067
	ld d, h ; $6068
	ld hl, $0018 ; $6069
	add hl, de ; $606c
	ld [hl], a ; $606d
	ld a, [$c2b1] ; $606e
	ld bc, $1f00 ; $6071
	ld de, $0b00 ; $6074
	farcall FarPtr_0a_24 ; $6077
	ld a, [$c2b1] ; $607a
	farcall FarPtr_0a_20 ; $607d
	ld a, [$c2b1] ; $6080
	ld bc, $1f00 ; $6083
	ld de, $1100 ; $6086
	farcall FarPtr_0a_24 ; $6089
	ld a, [$c2b1] ; $608c
	farcall FarPtr_0a_20 ; $608f
	ld a, $00 ; $6092
	ld b, $40 ; $6094
	farcall FarPtr_0a_2e ; $6096
	ld a, [$c2b1] ; $6099
	ld bc, $1f00 ; $609c
	ld de, $1f00 ; $609f
	farcall FarPtr_0a_24 ; $60a2
	ld a, [$c2b1] ; $60a5
	farcall FarPtr_0a_20 ; $60a8
	set_flag $17, 2 ; $60ab
	ret ; $60ae
Label_15_60af:
	ld a, [$c2b1] ; $60af
	ld bc, $0030 ; $60b2
	farcall FarPtr_0a_18 ; $60b5
	ld a, [$c2b1] ; $60b8
	farcall FarPtr_0a_16 ; $60bb
	ld a, $04 ; $60be
	ld e, l ; $60c0
	ld d, h ; $60c1
	ld hl, $0018 ; $60c2
	add hl, de ; $60c5
	ld [hl], a ; $60c6
	ld a, [$c2b1] ; $60c7
	ld bc, $2100 ; $60ca
	ld de, $2500 ; $60cd
	farcall FarPtr_0a_24 ; $60d0
	ld a, [$c2b1] ; $60d3
	farcall FarPtr_0a_20 ; $60d6
	ld a, $00 ; $60d9
	ld b, $40 ; $60db
	farcall FarPtr_0a_2e ; $60dd
	ld a, [$c2b1] ; $60e0
	ld bc, $1f00 ; $60e3
	ld de, $3500 ; $60e6
	farcall FarPtr_0a_24 ; $60e9
	ld a, [$c2b1] ; $60ec
	farcall FarPtr_0a_20 ; $60ef
	set_flag $17, 3 ; $60f2
	ret ; $60f5
Label_15_60f6:
	ld a, [$c2b1] ; $60f6
	ld b, $c0 ; $60f9
	farcall FarPtr_0a_2e ; $60fb
	ld a, [$c2b1] ; $60fe
	ld d, $02 ; $6101
	farcall FarPtr_0a_34 ; $6103
	ld a, [$c2b1] ; $6106
	farcall FarPtr_0a_36 ; $6109
	ld a, [$c2b1] ; $610c
	ld d, $02 ; $610f
	farcall FarPtr_0a_34 ; $6111
	ld a, [$c2b1] ; $6114
	farcall FarPtr_0a_36 ; $6117
	ld a, [$c2b1] ; $611a
	farcall FarPtr_0a_08 ; $611d
	ld a, [$c2b1] ; $6120
	ld bc, $0030 ; $6123
	farcall FarPtr_0a_18 ; $6126
	ld a, [$c2b1] ; $6129
	farcall FarPtr_0a_16 ; $612c
	ld a, $04 ; $612f
	ld e, l ; $6131
	ld d, h ; $6132
	ld hl, $0018 ; $6133
	add hl, de ; $6136
	ld [hl], a ; $6137
	ld a, [$c2b1] ; $6138
	ld bc, $1f00 ; $613b
	ld de, $2500 ; $613e
	farcall FarPtr_0a_24 ; $6141
	ld a, [$c2b1] ; $6144
	farcall FarPtr_0a_20 ; $6147
	ld a, [$c2b1] ; $614a
	ld bc, $1f00 ; $614d
	ld de, $2900 ; $6150
	farcall FarPtr_0a_24 ; $6153
	ld a, [$c2b1] ; $6156
	farcall FarPtr_0a_20 ; $6159
	ld a, $00 ; $615c
	ld b, $40 ; $615e
	farcall FarPtr_0a_2e ; $6160
	ld a, [$c2b1] ; $6163
	ld bc, $1f00 ; $6166
	ld de, $3500 ; $6169
	farcall FarPtr_0a_24 ; $616c
	ld a, [$c2b1] ; $616f
	farcall FarPtr_0a_20 ; $6172
	set_flag $17, 4 ; $6175
	ret ; $6178
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
Func_15_6253:
	ld a, [$c8f7] ; $6253
	sub a, $0a ; $6256
	jr nc, Label_15_6265 ; $6258
	ld a, [$c8f7] ; $625a
	sub a, $04 ; $625d
	jr c, Label_15_6283 ; $625f
	jp Label_15_62a1 ; $6261
	INCBIN "data/bank_015/d_6264.bin" ; $6264, 1 bytes
Label_15_6265:
	ld a, $00 ; $6265
	ld bc, $1300 ; $6267
	ld de, $2b00 ; $626a
	farcall FarPtr_0a_24 ; $626d
	ld a, $00 ; $6270
	farcall FarPtr_0a_20 ; $6272
	ld a, $02 ; $6275
	farcall FarPtr_0a_16 ; $6277
	ld c, l ; $627a
	ld b, h ; $627b
	ld de, $d000 ; $627c
	farcall FarPtr_04_20 ; $627f
	ret ; $6282
Label_15_6283:
	ld a, $00 ; $6283
	ld bc, $1300 ; $6285
	ld de, $1300 ; $6288
	farcall FarPtr_0a_24 ; $628b
	ld a, $00 ; $628e
	farcall FarPtr_0a_20 ; $6290
	ld a, $02 ; $6293
	farcall FarPtr_0a_16 ; $6295
	ld c, l ; $6298
	ld b, h ; $6299
	ld de, $d000 ; $629a
	farcall FarPtr_04_20 ; $629d
	ret ; $62a0
Label_15_62a1:
	ld a, $00 ; $62a1
	ld bc, $2d00 ; $62a3
	ld de, $2b00 ; $62a6
	farcall FarPtr_0a_24 ; $62a9
	ld a, $00 ; $62ac
	farcall FarPtr_0a_20 ; $62ae
	ld a, $02 ; $62b1
	farcall FarPtr_0a_16 ; $62b3
	ld c, l ; $62b6
	ld b, h ; $62b7
	ld de, $d000 ; $62b8
	farcall FarPtr_04_20 ; $62bb
	ret ; $62be
Label_15_62bf:
	ld hl, wWaterSpriteMinigameFlag ; $62bf
	ld de, $204d ; $62c2
	ld a, e ; $62c5
	ld [hl+], a ; $62c6
	ld [hl], d ; $62c7
	ld hl, wWaterSpriteMinigameTimer ; $62c8
	ld de, $204a ; $62cb
	ld a, e ; $62ce
	ld [hl+], a ; $62cf
	ld [hl], d ; $62d0
	test_flag $0a, 3 ; $62d1
	jr z, Label_15_62ea ; $62d4
	ld hl, wWaterSpriteMinigameSwingCount ; $62d6
	ld de, $2050 ; $62d9
	ld a, e ; $62dc
	ld [hl+], a ; $62dd
	ld [hl], d ; $62de
	ld hl, $c2b8 ; $62df
	ld de, $2053 ; $62e2
	ld a, e ; $62e5
	ld [hl+], a ; $62e6
	ld [hl], d ; $62e7
	jr Label_15_62fc ; $62e8
Label_15_62ea:
	ld hl, wWaterSpriteMinigameSwingCount ; $62ea
	ld de, $204f ; $62ed
	ld a, e ; $62f0
	ld [hl+], a ; $62f1
	ld [hl], d ; $62f2
	ld hl, $c2b8 ; $62f3
	ld de, $2051 ; $62f6
	ld a, e ; $62f9
	ld [hl+], a ; $62fa
	ld [hl], d ; $62fb
Label_15_62fc:
	call Func_15_5d74 ; $62fc
	ret ; $62ff
Label_15_6300:
	ld hl, wWaterSpriteMinigameFlag ; $6300
	ld de, $204d ; $6303
	ld a, e ; $6306
	ld [hl+], a ; $6307
	ld [hl], d ; $6308
	ld hl, wWaterSpriteMinigameTimer ; $6309
	ld de, $204a ; $630c
	ld a, e ; $630f
	ld [hl+], a ; $6310
	ld [hl], d ; $6311
	ld hl, wWaterSpriteMinigameSwingCount ; $6312
	ld de, $205f ; $6315
	ld a, e ; $6318
	ld [hl+], a ; $6319
	ld [hl], d ; $631a
	ld hl, $c2b8 ; $631b
	ld de, $2060 ; $631e
	ld a, e ; $6321
	ld [hl+], a ; $6322
	ld [hl], d ; $6323
	call Func_15_5d74 ; $6324
	ret ; $6327
Label_15_6328:
	ld hl, wWaterSpriteMinigameFlag ; $6328
	ld de, $204d ; $632b
	ld a, e ; $632e
	ld [hl+], a ; $632f
	ld [hl], d ; $6330
	ld hl, wWaterSpriteMinigameTimer ; $6331
	ld de, $204a ; $6334
	ld a, e ; $6337
	ld [hl+], a ; $6338
	ld [hl], d ; $6339
	ld hl, wWaterSpriteMinigameSwingCount ; $633a
	ld de, $206c ; $633d
	ld a, e ; $6340
	ld [hl+], a ; $6341
	ld [hl], d ; $6342
	ld hl, $c2b8 ; $6343
	ld de, $206d ; $6346
	ld a, e ; $6349
	ld [hl+], a ; $634a
	ld [hl], d ; $634b
	call Func_15_5d74 ; $634c
	ret ; $634f
Label_15_6350:
	ld hl, wWaterSpriteMinigameFlag ; $6350
	ld de, $207b ; $6353
	ld a, e ; $6356
	ld [hl+], a ; $6357
	ld [hl], d ; $6358
	ld hl, wWaterSpriteMinigameTimer ; $6359
	ld de, $2078 ; $635c
	ld a, e ; $635f
	ld [hl+], a ; $6360
	ld [hl], d ; $6361
	test_flag $0a, 3 ; $6362
	jr z, Label_15_637b ; $6365
	ld hl, wWaterSpriteMinigameSwingCount ; $6367
	ld de, $207e ; $636a
	ld a, e ; $636d
	ld [hl+], a ; $636e
	ld [hl], d ; $636f
	ld hl, $c2b8 ; $6370
	ld de, $2082 ; $6373
	ld a, e ; $6376
	ld [hl+], a ; $6377
	ld [hl], d ; $6378
	jr Label_15_638d ; $6379
Label_15_637b:
	ld hl, wWaterSpriteMinigameSwingCount ; $637b
	ld de, $207d ; $637e
	ld a, e ; $6381
	ld [hl+], a ; $6382
	ld [hl], d ; $6383
	ld hl, $c2b8 ; $6384
	ld de, $207f ; $6387
	ld a, e ; $638a
	ld [hl+], a ; $638b
	ld [hl], d ; $638c
Label_15_638d:
	call Func_15_5df3 ; $638d
	ret ; $6390
Label_15_6391:
	ld hl, wWaterSpriteMinigameFlag ; $6391
	ld de, $207b ; $6394
	ld a, e ; $6397
	ld [hl+], a ; $6398
	ld [hl], d ; $6399
	ld hl, wWaterSpriteMinigameTimer ; $639a
	ld de, $2078 ; $639d
	ld a, e ; $63a0
	ld [hl+], a ; $63a1
	ld [hl], d ; $63a2
	ld hl, wWaterSpriteMinigameSwingCount ; $63a3
	ld de, $2091 ; $63a6
	ld a, e ; $63a9
	ld [hl+], a ; $63aa
	ld [hl], d ; $63ab
	ld hl, $c2b8 ; $63ac
	ld de, $2092 ; $63af
	ld a, e ; $63b2
	ld [hl+], a ; $63b3
	ld [hl], d ; $63b4
	call Func_15_5df3 ; $63b5
	ret ; $63b8
Label_15_63b9:
	ld hl, wWaterSpriteMinigameFlag ; $63b9
	ld de, $207b ; $63bc
	ld a, e ; $63bf
	ld [hl+], a ; $63c0
	ld [hl], d ; $63c1
	ld hl, wWaterSpriteMinigameTimer ; $63c2
	ld de, $2078 ; $63c5
	ld a, e ; $63c8
	ld [hl+], a ; $63c9
	ld [hl], d ; $63ca
	ld hl, wWaterSpriteMinigameSwingCount ; $63cb
	ld de, $20a3 ; $63ce
	ld a, e ; $63d1
	ld [hl+], a ; $63d2
	ld [hl], d ; $63d3
	ld hl, $c2b8 ; $63d4
	ld de, $20a4 ; $63d7
	ld a, e ; $63da
	ld [hl+], a ; $63db
	ld [hl], d ; $63dc
	call Func_15_5df3 ; $63dd
	ret ; $63e0
	INCBIN "data/bank_015/d_63e1.bin" ; $63e1, 614 bytes
Func_15_6647:
	test_flag $05, 7 ; $6647
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
	test_flag $0a, 3 ; $6dba
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
	test_flag $0a, 3 ; $6fd7
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
	test_flag $17, 2 ; $71be
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
	test_flag $17, 3 ; $7204
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
	test_flag $17, 4 ; $724a
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
	INCBIN "data/bank_015/d_7272.bin" ; $7272, 30 bytes
Label_15_7290:
	ld a, [$c2e3] ; $7290
	ld a, a ; $7293
	rst Rst00 ; $7294
	dw Label_15_72c7 ; $7295 jumptable
	dw Label_15_73f0 ; $7297 jumptable
	dw Label_15_73fd ; $7299 jumptable
	dw Label_15_740a ; $729b jumptable
	dw Label_15_73f0 ; $729d jumptable
Label_15_729f:
	ld a, [$c2e3] ; $729f
	ld a, a ; $72a2
	rst Rst00 ; $72a3
	dw Label_15_7336 ; $72a4 jumptable
	dw Label_15_73f0 ; $72a6 jumptable
	dw Label_15_73fd ; $72a8 jumptable
	dw Label_15_7417 ; $72aa jumptable
	dw Label_15_7424 ; $72ac jumptable
	dw Label_15_7431 ; $72ae jumptable
	dw Label_15_743e ; $72b0 jumptable
	dw Label_15_73f0 ; $72b2 jumptable
Label_15_72b4:
	ld a, [$c2e3] ; $72b4
	ld a, a ; $72b7
	rst Rst00 ; $72b8
	dw Label_15_739c ; $72b9 jumptable
	dw Label_15_73f0 ; $72bb jumptable
	dw Label_15_73fd ; $72bd jumptable
	dw Label_15_7417 ; $72bf jumptable
	dw Label_15_744b ; $72c1 jumptable
	dw Label_15_7458 ; $72c3 jumptable
	dw Label_15_73f0 ; $72c5 jumptable
Label_15_72c7:
	call Func_15_74e1 ; $72c7
	ld hl, $1c1c ; $72ca
	farcall FarPtr_0a_0e ; $72cd
	ld a, $07 ; $72d0
	farcall FarPtr_0a_08 ; $72d2
	test_flag $0a, 3 ; $72d5
	jr z, Label_15_72dd ; $72d8
	farcall FarPtr_0a_10 ; $72da
Label_15_72dd:
	ld a, $00 ; $72dd
	ld b, a ; $72df
	ld a, $07 ; $72e0
	farcall FarPtr_0a_30 ; $72e2
	ld a, $07 ; $72e5
	ld d, $03 ; $72e7
	farcall FarPtr_0a_34 ; $72e9
	ld a, $07 ; $72ec
	farcall FarPtr_0a_36 ; $72ee
	ld a, $07 ; $72f1
	farcall FarPtr_0a_08 ; $72f3
	ld a, $07 ; $72f6
	ld d, $02 ; $72f8
	farcall FarPtr_0a_34 ; $72fa
	ld a, $07 ; $72fd
	farcall FarPtr_0a_36 ; $72ff
	ld hl, $1c1f ; $7302
	farcall FarPtr_0a_0e ; $7305
	ld a, $07 ; $7308
	farcall FarPtr_0a_08 ; $730a
	ld a, $07 ; $730d
	ld d, $04 ; $730f
	farcall FarPtr_0a_34 ; $7311
	ld a, $07 ; $7314
	farcall FarPtr_0a_36 ; $7316
	ld a, $07 ; $7319
	farcall FarPtr_0a_08 ; $731b
	test_flag $0a, 3 ; $731e
	jr z, Label_15_7326 ; $7321
	farcall FarPtr_0a_10 ; $7323
Label_15_7326:
	ld a, $07 ; $7326
	farcall FarPtr_0a_08 ; $7328
	ld a, $07 ; $732b
	ld b, $80 ; $732d
	farcall FarPtr_0a_2e ; $732f
	set_flag $17, 5 ; $7332
	ret ; $7335
Label_15_7336:
	call Func_15_74e1 ; $7336
	ld hl, $1c2a ; $7339
	farcall FarPtr_0a_0e ; $733c
	test_flag $0a, 7 ; $733f
	jr z, Label_15_734a ; $7342
	ld hl, $1c2e ; $7344
	farcall FarPtr_0a_0e ; $7347
Label_15_734a:
	ld a, $07 ; $734a
	farcall FarPtr_0a_08 ; $734c
	ld a, $00 ; $734f
	ld b, a ; $7351
	ld a, $07 ; $7352
	farcall FarPtr_0a_30 ; $7354
	ld a, $07 ; $7357
	ld d, $03 ; $7359
	farcall FarPtr_0a_34 ; $735b
	ld a, $07 ; $735e
	farcall FarPtr_0a_36 ; $7360
	ld a, $07 ; $7363
	farcall FarPtr_0a_08 ; $7365
	ld a, $07 ; $7368
	ld d, $02 ; $736a
	farcall FarPtr_0a_34 ; $736c
	ld a, $07 ; $736f
	farcall FarPtr_0a_36 ; $7371
	ld a, $07 ; $7374
	farcall FarPtr_0a_08 ; $7376
	ld a, $07 ; $7379
	ld d, $04 ; $737b
	farcall FarPtr_0a_34 ; $737d
	ld a, $07 ; $7380
	farcall FarPtr_0a_36 ; $7382
	ld a, $07 ; $7385
	farcall FarPtr_0a_08 ; $7387
	ld a, $07 ; $738a
	ld b, $80 ; $738c
	farcall FarPtr_0a_2e ; $738e
	push af ; $7391
	ld a, $05 ; $7392
	farcall FarPtr_0a_04 ; $7394
	pop af ; $7397
	set_flag $17, 5 ; $7398
	ret ; $739b
Label_15_739c:
	call Func_15_74e1 ; $739c
	ld hl, $1c39 ; $739f
	farcall FarPtr_0a_0e ; $73a2
	ld a, $07 ; $73a5
	farcall FarPtr_0a_08 ; $73a7
	ld a, $00 ; $73aa
	ld b, a ; $73ac
	ld a, $07 ; $73ad
	farcall FarPtr_0a_30 ; $73af
	ld a, $07 ; $73b2
	ld d, $03 ; $73b4
	farcall FarPtr_0a_34 ; $73b6
	ld a, $07 ; $73b9
	farcall FarPtr_0a_36 ; $73bb
	ld a, $07 ; $73be
	farcall FarPtr_0a_08 ; $73c0
	ld a, $07 ; $73c3
	ld d, $02 ; $73c5
	farcall FarPtr_0a_34 ; $73c7
	ld a, $07 ; $73ca
	farcall FarPtr_0a_36 ; $73cc
	ld a, $07 ; $73cf
	farcall FarPtr_0a_08 ; $73d1
	ld a, $07 ; $73d4
	ld d, $03 ; $73d6
	farcall FarPtr_0a_34 ; $73d8
	ld a, $07 ; $73db
	farcall FarPtr_0a_36 ; $73dd
	ld a, $07 ; $73e0
	farcall FarPtr_0a_08 ; $73e2
	ld a, $07 ; $73e5
	ld b, $80 ; $73e7
	farcall FarPtr_0a_2e ; $73e9
	set_flag $17, 5 ; $73ec
	ret ; $73ef
Label_15_73f0:
	call Func_15_74e1 ; $73f0
	ld hl, $1c3e ; $73f3
	farcall FarPtr_0a_0e ; $73f6
	call Func_15_7465 ; $73f9
	ret ; $73fc
Label_15_73fd:
	call Func_15_74e1 ; $73fd
	ld hl, $1c43 ; $7400
	farcall FarPtr_0a_0e ; $7403
	call Func_15_749a ; $7406
	ret ; $7409
Label_15_740a:
	call Func_15_74e1 ; $740a
	ld hl, $1c48 ; $740d
	farcall FarPtr_0a_0e ; $7410
	call Func_15_747e ; $7413
	ret ; $7416
Label_15_7417:
	call Func_15_74e1 ; $7417
	ld hl, $1c4b ; $741a
	farcall FarPtr_0a_0e ; $741d
	call Func_15_747e ; $7420
	ret ; $7423
Label_15_7424:
	call Func_15_74e1 ; $7424
	ld hl, $1c4e ; $7427
	farcall FarPtr_0a_0e ; $742a
	call Func_15_747e ; $742d
	ret ; $7430
Label_15_7431:
	call Func_15_74e1 ; $7431
	ld hl, $1c51 ; $7434
	farcall FarPtr_0a_0e ; $7437
	call Func_15_747e ; $743a
	ret ; $743d
Label_15_743e:
	call Func_15_74e1 ; $743e
	ld hl, $1c54 ; $7441
	farcall FarPtr_0a_0e ; $7444
	call Func_15_747e ; $7447
	ret ; $744a
Label_15_744b:
	call Func_15_74e1 ; $744b
	ld hl, $1c57 ; $744e
	farcall FarPtr_0a_0e ; $7451
	call Func_15_747e ; $7454
	ret ; $7457
Label_15_7458:
	call Func_15_74e1 ; $7458
	ld hl, $1c5a ; $745b
	farcall FarPtr_0a_0e ; $745e
	call Func_15_747e ; $7461
	ret ; $7464
Func_15_7465:
	ld a, $07 ; $7465
	farcall FarPtr_0a_0a ; $7467
	farcall FarPtr_0a_12 ; $746a
	farcall FarPtr_0a_0c ; $746d
	push af ; $7470
	ld a, $05 ; $7471
	farcall FarPtr_0a_04 ; $7473
	pop af ; $7476
	and a, a ; $7477
	jp nz, Label_15_752c ; $7478
	farcall FarPtr_0a_10 ; $747b
Func_15_747e:
	ld a, $07 ; $747e
	farcall FarPtr_0a_0a ; $7480
	farcall FarPtr_0a_12 ; $7483
	farcall FarPtr_0a_0c ; $7486
	push af ; $7489
	ld a, $05 ; $748a
	farcall FarPtr_0a_04 ; $748c
	pop af ; $748f
	and a, a ; $7490
	jp z, Label_15_74d2 ; $7491
	farcall FarPtr_0a_10 ; $7494
	jp Label_15_752c ; $7497
Func_15_749a:
	ld a, $07 ; $749a
	farcall FarPtr_0a_0a ; $749c
	farcall FarPtr_0a_12 ; $749f
	farcall FarPtr_0a_0c ; $74a2
	push af ; $74a5
	ld a, $05 ; $74a6
	farcall FarPtr_0a_04 ; $74a8
	pop af ; $74ab
	and a, a ; $74ac
	jp nz, Label_15_74b3 ; $74ad
	farcall FarPtr_0a_10 ; $74b0
Label_15_74b3:
	ld a, $07 ; $74b3
	farcall FarPtr_0a_0a ; $74b5
	farcall FarPtr_0a_12 ; $74b8
	farcall FarPtr_0a_0c ; $74bb
	push af ; $74be
	ld a, $05 ; $74bf
	farcall FarPtr_0a_04 ; $74c1
	pop af ; $74c4
	and a, a ; $74c5
	jp z, Label_15_74d2 ; $74c6
	ld hl, $1c47 ; $74c9
	farcall FarPtr_0a_0e ; $74cc
	jp Label_15_752c ; $74cf
Label_15_74d2:
	ld hl, $1c41 ; $74d2
	farcall FarPtr_0a_0e ; $74d5
	ld a, $07 ; $74d8
	farcall FarPtr_0a_08 ; $74da
	call Func_15_7a96 ; $74dd
	ret ; $74e0
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
Label_15_752c:
	ld a, $07 ; $752c
	farcall FarPtr_0a_08 ; $752e
	ld a, $07 ; $7531
	ld b, $80 ; $7533
	farcall FarPtr_0a_2e ; $7535
	ret ; $7538
Label_15_7539:
	ld a, [$c2e3] ; $7539
	ld a, a ; $753c
	rst Rst00 ; $753d
	dw Label_15_757a ; $753e jumptable
	dw Label_15_768c ; $7540 jumptable
	dw Label_15_7699 ; $7542 jumptable
	dw Label_15_76a6 ; $7544 jumptable
	dw Label_15_76b3 ; $7546 jumptable
	dw Label_15_76c0 ; $7548 jumptable
	dw Label_15_768c ; $754a jumptable
	dw Label_15_768c ; $754c jumptable
Label_15_754e:
	ld a, [$c2e3] ; $754e
	ld a, a ; $7551
	rst Rst00 ; $7552
	dw Label_15_75d9 ; $7553 jumptable
	dw Label_15_768c ; $7555 jumptable
	dw Label_15_7699 ; $7557 jumptable
	dw Label_15_76cd ; $7559 jumptable
	dw Label_15_770e ; $755b jumptable
	dw Label_15_76da ; $755d jumptable
	dw Label_15_76c0 ; $755f jumptable
	dw Label_15_768c ; $7561 jumptable
Label_15_7563:
	ld a, [$c2e3] ; $7563
	ld a, a ; $7566
	rst Rst00 ; $7567
	dw Label_15_7638 ; $7568 jumptable
	dw Label_15_768c ; $756a jumptable
	dw Label_15_7699 ; $756c jumptable
	dw Label_15_76e7 ; $756e jumptable
	dw Label_15_76f4 ; $7570 jumptable
	dw Label_15_771b ; $7572 jumptable
	dw Label_15_7701 ; $7574 jumptable
	dw Label_15_76c0 ; $7576 jumptable
	dw Label_15_768c ; $7578 jumptable
Label_15_757a:
	ld hl, $1c7e ; $757a
	farcall FarPtr_0a_0e ; $757d
	call Func_15_7752 ; $7580
	ld a, $12 ; $7583
	farcall FarPtr_0a_08 ; $7585
	ld a, $00 ; $7588
	ld b, a ; $758a
	ld a, $12 ; $758b
	farcall FarPtr_0a_30 ; $758d
	test_flag $0a, 3 ; $7590
	jr z, Label_15_759b ; $7593
	ld hl, $1c82 ; $7595
	farcall FarPtr_0a_0e ; $7598
Label_15_759b:
	ld a, $12 ; $759b
	ld d, $03 ; $759d
	farcall FarPtr_0a_34 ; $759f
	ld a, $12 ; $75a2
	farcall FarPtr_0a_36 ; $75a4
	ld a, $12 ; $75a7
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
	set_flag $17, 6 ; $75d5
	ret ; $75d8
Label_15_75d9:
	call Func_15_7752 ; $75d9
	ld hl, $1c97 ; $75dc
	farcall FarPtr_0a_0e ; $75df
	ld a, $12 ; $75e2
	farcall FarPtr_0a_08 ; $75e4
	ld a, $00 ; $75e7
	ld b, a ; $75e9
	ld a, $12 ; $75ea
	farcall FarPtr_0a_30 ; $75ec
	ld a, $12 ; $75ef
	ld d, $03 ; $75f1
	farcall FarPtr_0a_34 ; $75f3
	ld a, $12 ; $75f6
	farcall FarPtr_0a_36 ; $75f8
	test_flag $0a, 7 ; $75fb
	jr z, Label_15_7606 ; $75fe
	ld hl, $1c9b ; $7600
	farcall FarPtr_0a_0e ; $7603
Label_15_7606:
	ld a, $12 ; $7606
	farcall FarPtr_0a_08 ; $7608
	ld a, $12 ; $760b
	ld d, $02 ; $760d
	farcall FarPtr_0a_34 ; $760f
	ld a, $12 ; $7612
	farcall FarPtr_0a_36 ; $7614
	ld a, $12 ; $7617
	farcall FarPtr_0a_08 ; $7619
	ld a, $12 ; $761c
	ld d, $04 ; $761e
	farcall FarPtr_0a_34 ; $7620
	ld a, $12 ; $7623
	farcall FarPtr_0a_36 ; $7625
	ld a, $12 ; $7628
	farcall FarPtr_0a_08 ; $762a
	ld a, $12 ; $762d
	ld b, $00 ; $762f
	farcall FarPtr_0a_2e ; $7631
	set_flag $17, 6 ; $7634
	ret ; $7637
Label_15_7638:
	call Func_15_7752 ; $7638
	ld hl, $1cb7 ; $763b
	farcall FarPtr_0a_0e ; $763e
	ld a, $12 ; $7641
	farcall FarPtr_0a_08 ; $7643
	ld a, $00 ; $7646
	ld b, a ; $7648
	ld a, $12 ; $7649
	farcall FarPtr_0a_30 ; $764b
	ld a, $12 ; $764e
	ld d, $03 ; $7650
	farcall FarPtr_0a_34 ; $7652
	ld a, $12 ; $7655
	farcall FarPtr_0a_36 ; $7657
	ld a, $12 ; $765a
	farcall FarPtr_0a_08 ; $765c
	ld a, $12 ; $765f
	ld d, $02 ; $7661
	farcall FarPtr_0a_34 ; $7663
	ld a, $12 ; $7666
	farcall FarPtr_0a_36 ; $7668
	ld a, $12 ; $766b
	farcall FarPtr_0a_08 ; $766d
	ld a, $12 ; $7670
	ld d, $03 ; $7672
	farcall FarPtr_0a_34 ; $7674
	ld a, $12 ; $7677
	farcall FarPtr_0a_36 ; $7679
	ld a, $12 ; $767c
	farcall FarPtr_0a_08 ; $767e
	ld a, $12 ; $7681
	ld b, $00 ; $7683
	farcall FarPtr_0a_2e ; $7685
	set_flag $17, 6 ; $7688
	ret ; $768b
Label_15_768c:
	call Func_15_7752 ; $768c
	ld hl, $1c6b ; $768f
	farcall FarPtr_0a_0e ; $7692
	call Func_15_7728 ; $7695
	ret ; $7698
Label_15_7699:
	call Func_15_7752 ; $7699
	ld hl, $1c6f ; $769c
	farcall FarPtr_0a_0e ; $769f
	call Func_15_7728 ; $76a2
	ret ; $76a5
Label_15_76a6:
	call Func_15_7752 ; $76a6
	ld hl, $1c73 ; $76a9
	farcall FarPtr_0a_0e ; $76ac
	call Func_15_7728 ; $76af
	ret ; $76b2
Label_15_76b3:
	call Func_15_7752 ; $76b3
	ld hl, $1c77 ; $76b6
	farcall FarPtr_0a_0e ; $76b9
	call Func_15_7728 ; $76bc
	ret ; $76bf
Label_15_76c0:
	call Func_15_7752 ; $76c0
	ld hl, $1c7b ; $76c3
	farcall FarPtr_0a_0e ; $76c6
	call Func_15_772d ; $76c9
	ret ; $76cc
Label_15_76cd:
	call Func_15_7752 ; $76cd
	ld hl, $1c90 ; $76d0
	farcall FarPtr_0a_0e ; $76d3
	call Func_15_7728 ; $76d6
	ret ; $76d9
Label_15_76da:
	call Func_15_7752 ; $76da
	ld hl, $1c94 ; $76dd
	farcall FarPtr_0a_0e ; $76e0
	call Func_15_772d ; $76e3
	ret ; $76e6
Label_15_76e7:
	call Func_15_7752 ; $76e7
	ld hl, $1cac ; $76ea
	farcall FarPtr_0a_0e ; $76ed
	call Func_15_7728 ; $76f0
	ret ; $76f3
Label_15_76f4:
	call Func_15_7752 ; $76f4
	ld hl, $1cb0 ; $76f7
	farcall FarPtr_0a_0e ; $76fa
	call Func_15_7728 ; $76fd
	ret ; $7700
Label_15_7701:
	call Func_15_7752 ; $7701
	ld hl, $1cb4 ; $7704
	farcall FarPtr_0a_0e ; $7707
	call Func_15_772d ; $770a
	ret ; $770d
Label_15_770e:
	call Func_15_7752 ; $770e
	ld hl, $1cbc ; $7711
	farcall FarPtr_0a_0e ; $7714
	call Func_15_7728 ; $7717
	ret ; $771a
Label_15_771b:
	call Func_15_7752 ; $771b
	ld hl, $1cc0 ; $771e
	farcall FarPtr_0a_0e ; $7721
	call Func_15_7728 ; $7724
	ret ; $7727
Func_15_7728:
	ld a, $12 ; $7728
	farcall FarPtr_0a_08 ; $772a
Func_15_772d:
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
Label_15_77aa:
	ld a, [$c2e3] ; $77aa
	ld a, a ; $77ad
	rst Rst00 ; $77ae
	dw Label_15_77e3 ; $77af jumptable
	dw Label_15_78f5 ; $77b1 jumptable
	dw Label_15_7902 ; $77b3 jumptable
	dw Label_15_790f ; $77b5 jumptable
	dw Label_15_791c ; $77b7 jumptable
	dw Label_15_7929 ; $77b9 jumptable
	dw Label_15_7929 ; $77bb jumptable
Label_15_77bd:
	ld a, [$c2e3] ; $77bd
	ld a, a ; $77c0
	rst Rst00 ; $77c1
	dw Label_15_784d ; $77c2 jumptable
	dw Label_15_7936 ; $77c4 jumptable
	dw Label_15_7943 ; $77c6 jumptable
	dw Label_15_7950 ; $77c8 jumptable
	dw Label_15_795d ; $77ca jumptable
	dw Label_15_7929 ; $77cc jumptable
	dw Label_15_78f5 ; $77ce jumptable
Label_15_77d0:
	ld a, [$c2e3] ; $77d0
	ld a, a ; $77d3
	rst Rst00 ; $77d4
	dw Label_15_78a1 ; $77d5 jumptable
	dw Label_15_796a ; $77d7 jumptable
	dw Label_15_7977 ; $77d9 jumptable
	dw Label_15_7984 ; $77db jumptable
	dw Label_15_7991 ; $77dd jumptable
	dw Label_15_7929 ; $77df jumptable
	dw Label_15_78f5 ; $77e1 jumptable
Label_15_77e3:
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
	test_flag $0a, 3 ; $7816
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
	test_flag $0a, 3 ; $7835
	jr z, Label_15_783d ; $7838
	farcall FarPtr_0a_10 ; $783a
Label_15_783d:
	ld a, $0d ; $783d
	farcall FarPtr_0a_08 ; $783f
	ld a, $0d ; $7842
	ld b, $c0 ; $7844
	farcall FarPtr_0a_2e ; $7846
	set_flag $17, 7 ; $7849
	ret ; $784c
Label_15_784d:
	call Func_15_79cb ; $784d
	ld hl, $1cf5 ; $7850
	farcall FarPtr_0a_0e ; $7853
	ld a, $0d ; $7856
	farcall FarPtr_0a_08 ; $7858
	ld a, $00 ; $785b
	ld b, a ; $785d
	ld a, $0d ; $785e
	farcall FarPtr_0a_30 ; $7860
	ld a, $0d ; $7863
	ld d, $03 ; $7865
	farcall FarPtr_0a_34 ; $7867
	ld a, $0d ; $786a
	farcall FarPtr_0a_36 ; $786c
	ld a, $0d ; $786f
	farcall FarPtr_0a_08 ; $7871
	ld a, $0d ; $7874
	ld d, $02 ; $7876
	farcall FarPtr_0a_34 ; $7878
	ld a, $0d ; $787b
	farcall FarPtr_0a_36 ; $787d
	ld a, $0d ; $7880
	farcall FarPtr_0a_08 ; $7882
	ld a, $0d ; $7885
	ld d, $04 ; $7887
	farcall FarPtr_0a_34 ; $7889
	ld a, $0d ; $788c
	farcall FarPtr_0a_36 ; $788e
	ld a, $0d ; $7891
	farcall FarPtr_0a_08 ; $7893
	ld a, $0d ; $7896
	ld b, $c0 ; $7898
	farcall FarPtr_0a_2e ; $789a
	set_flag $17, 7 ; $789d
	ret ; $78a0
Label_15_78a1:
	call Func_15_79cb ; $78a1
	ld hl, $200f ; $78a4
	farcall FarPtr_0a_0e ; $78a7
	ld a, $0d ; $78aa
	farcall FarPtr_0a_08 ; $78ac
	ld a, $00 ; $78af
	ld b, a ; $78b1
	ld a, $0d ; $78b2
	farcall FarPtr_0a_30 ; $78b4
	ld a, $0d ; $78b7
	ld d, $03 ; $78b9
	farcall FarPtr_0a_34 ; $78bb
	ld a, $0d ; $78be
	farcall FarPtr_0a_36 ; $78c0
	ld a, $0d ; $78c3
	farcall FarPtr_0a_08 ; $78c5
	ld a, $0d ; $78c8
	ld d, $02 ; $78ca
	farcall FarPtr_0a_34 ; $78cc
	ld a, $0d ; $78cf
	farcall FarPtr_0a_36 ; $78d1
	ld a, $0d ; $78d4
	farcall FarPtr_0a_08 ; $78d6
	ld a, $0d ; $78d9
	ld d, $03 ; $78db
	farcall FarPtr_0a_34 ; $78dd
	ld a, $0d ; $78e0
	farcall FarPtr_0a_36 ; $78e2
	ld a, $0d ; $78e5
	farcall FarPtr_0a_08 ; $78e7
	ld a, $0d ; $78ea
	ld b, $c0 ; $78ec
	farcall FarPtr_0a_2e ; $78ee
	set_flag $17, 7 ; $78f1
	ret ; $78f4
Label_15_78f5:
	call Func_15_79cb ; $78f5
	ld hl, $1ccb ; $78f8
	farcall FarPtr_0a_0e ; $78fb
	call Func_15_799e ; $78fe
	ret ; $7901
Label_15_7902:
	call Func_15_79cb ; $7902
	ld hl, $1ccf ; $7905
	farcall FarPtr_0a_0e ; $7908
	call Func_15_799e ; $790b
	ret ; $790e
Label_15_790f:
	call Func_15_79cb ; $790f
	ld hl, $1cd3 ; $7912
	farcall FarPtr_0a_0e ; $7915
	call Func_15_799e ; $7918
	ret ; $791b
Label_15_791c:
	call Func_15_79cb ; $791c
	ld hl, $1cd7 ; $791f
	farcall FarPtr_0a_0e ; $7922
	call Func_15_79a3 ; $7925
	ret ; $7928
Label_15_7929:
	call Func_15_79cb ; $7929
	ld hl, $1cda ; $792c
	farcall FarPtr_0a_0e ; $792f
	call Func_15_79a3 ; $7932
	ret ; $7935
Label_15_7936:
	call Func_15_79cb ; $7936
	ld hl, $1ce9 ; $7939
	farcall FarPtr_0a_0e ; $793c
	call Func_15_79a3 ; $793f
	ret ; $7942
Label_15_7943:
	call Func_15_79cb ; $7943
	ld hl, $1cec ; $7946
	farcall FarPtr_0a_0e ; $7949
	call Func_15_79a3 ; $794c
	ret ; $794f
Label_15_7950:
	call Func_15_79cb ; $7950
	ld hl, $1cef ; $7953
	farcall FarPtr_0a_0e ; $7956
	call Func_15_79a3 ; $7959
	ret ; $795c
Label_15_795d:
	call Func_15_79cb ; $795d
	ld hl, $1cf2 ; $7960
	farcall FarPtr_0a_0e ; $7963
	call Func_15_79a3 ; $7966
	ret ; $7969
Label_15_796a:
	call Func_15_79cb ; $796a
	ld hl, $1cff ; $796d
	farcall FarPtr_0a_0e ; $7970
	call Func_15_799e ; $7973
	ret ; $7976
Label_15_7977:
	call Func_15_79cb ; $7977
	ld hl, $2003 ; $797a
	farcall FarPtr_0a_0e ; $797d
	call Func_15_799e ; $7980
	ret ; $7983
Label_15_7984:
	call Func_15_79cb ; $7984
	ld hl, $2007 ; $7987
	farcall FarPtr_0a_0e ; $798a
	call Func_15_799e ; $798d
	ret ; $7990
Label_15_7991:
	call Func_15_79cb ; $7991
	ld hl, $200b ; $7994
	farcall FarPtr_0a_0e ; $7997
	call Func_15_799e ; $799a
	ret ; $799d
Func_15_799e:
	ld a, $0d ; $799e
	farcall FarPtr_0a_08 ; $79a0
Func_15_79a3:
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
	test_flag $05, 7 ; $7a45
	jp nz, Label_15_7a66 ; $7a48
	ld a, [wEquippedRacket] ; $7a4b
	and a, $0f ; $7a4e
	cp a, $03 ; $7a50
	jp nz, Label_15_7a66 ; $7a52
	test_flag $10, 0 ; $7a55
	jp nz, Label_15_7a66 ; $7a58
	ld a, $13 ; $7a5b
	ld bc, $3500 ; $7a5d
	ld de, $0f00 ; $7a60
	farcall FarPtr_0a_22 ; $7a63
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
	test_flag $05, 7 ; $7cd6
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
	test_flag $05, 7 ; $7d2f
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
	test_flag $0a, 3 ; $7fa2
	jr z, Label_15_7fbf ; $7fa5
	inc a ; $7fa7
	test_flag $0a, 7 ; $7fa8
	jr z, Label_15_7fbf ; $7fab
	inc a ; $7fad
	test_flag $05, 7 ; $7fae
	jr nz, Label_15_7fc3 ; $7fb1
	test_flag $15, 6 ; $7fb3
	jr z, Label_15_7fbf ; $7fb6
	inc a ; $7fb8
	test_flag $16, 0 ; $7fb9
	jr z, Label_15_7fbf ; $7fbc
	inc a ; $7fbe
Label_15_7fbf:
	ld [$c2b0], a ; $7fbf
	ret ; $7fc2
Label_15_7fc3:
	test_flag $15, 7 ; $7fc3
	jr z, Label_15_7fbf ; $7fc6
	inc a ; $7fc8
	test_flag $16, 1 ; $7fc9
	jr z, Label_15_7fbf ; $7fcc
	inc a ; $7fce
	jr Label_15_7fbf ; $7fcf
	ds 47, $ff ; $7fd1, fill
