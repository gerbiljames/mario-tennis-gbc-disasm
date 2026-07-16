SECTION "ROM Bank $16", ROMX[$4000], BANK[$16]

FarPtr_RunMatchWinLoseScreen:
	dw RunMatchWinLoseScreen ; $4000
FarPtr_RunMatchStatsScreen:
	dw RunMatchStatsScreen ; $4002
FarPtr_16_04:
	dw Func_16_6955 ; $4004
	push de ; $4006
	push bc ; $4007
	ld c, $00 ; $4008
	call Func_16_4069 ; $400a
	ld c, $00 ; $400d
	call Func_16_4093 ; $400f
	ld c, $00 ; $4012
	ld b, $08 ; $4014
	call QueueSprite ; $4016
	pop bc ; $4019
	pop de ; $401a
	push de ; $401b
	push bc ; $401c
	ld a, b ; $401d
	add a, d ; $401e
	ld d, a ; $401f
	push de ; $4020
	ld c, $01 ; $4021
	call Func_16_4069 ; $4023
	ld c, $00 ; $4026
	call Func_16_4093 ; $4028
	ld c, $00 ; $402b
	ld b, $28 ; $402d
	call QueueSprite ; $402f
	pop de ; $4032
	pop bc ; $4033
	pop de ; $4034
	push de ; $4035
	push bc ; $4036
	ld a, c ; $4037
	add a, e ; $4038
	ld e, a ; $4039
	ld a, b ; $403a
	add a, d ; $403b
	ld d, a ; $403c
	push de ; $403d
	ld c, $01 ; $403e
	call Func_16_4069 ; $4040
	ld c, $01 ; $4043
	call Func_16_4093 ; $4045
	ld c, $00 ; $4048
	ld b, $68 ; $404a
	call QueueSprite ; $404c
	pop de ; $404f
	pop bc ; $4050
	pop de ; $4051
	ld a, e ; $4052
	add a, c ; $4053
	ld e, a ; $4054
	push de ; $4055
	ld c, $00 ; $4056
	call Func_16_4069 ; $4058
	ld c, $01 ; $405b
	call Func_16_4093 ; $405d
	ld c, $00 ; $4060
	ld b, $48 ; $4062
	call QueueSprite ; $4064
	pop de ; $4067
	ret ; $4068
Func_16_4069:
	ldh a, [$ff8c] ; $4069
	and a, $0f ; $406b
	ld hl, $4083 ; $406d
	add a, l ; $4070
	ld l, a ; $4071
	jr nc, Label_16_4075 ; $4072
	inc h ; $4074
Label_16_4075:
	ld a, [hl] ; $4075
	ld b, a ; $4076
	ld a, c ; $4077
	or a, a ; $4078
	jr z, Label_16_407f ; $4079
	ld a, b ; $407b
	add a, d ; $407c
	ld d, a ; $407d
	ret ; $407e
Label_16_407f:
	ld a, d ; $407f
	sub a, b ; $4080
	ld d, a ; $4081
	ret ; $4082
	INCBIN "data/bank_016/d_4083.bin" ; $4083, 16 bytes
Func_16_4093:
	ldh a, [$ff8c] ; $4093
	and a, $0f ; $4095
	ld hl, $40ad ; $4097
	add a, l ; $409a
	ld l, a ; $409b
	jr nc, Label_16_409f ; $409c
	inc h ; $409e
Label_16_409f:
	ld a, [hl] ; $409f
	ld b, a ; $40a0
	ld a, c ; $40a1
	or a, a ; $40a2
	jr z, Label_16_40a9 ; $40a3
	ld a, b ; $40a5
	add a, e ; $40a6
	ld e, a ; $40a7
	ret ; $40a8
Label_16_40a9:
	ld a, e ; $40a9
	sub a, b ; $40aa
	ld e, a ; $40ab
	ret ; $40ac
	INCBIN "data/bank_016/d_40ad.bin" ; $40ad, 841 bytes
	farcall FarPtr_39_04 ; $43f6
	ret ; $43f9
	push af ; $43fa
	push bc ; $43fb
Label_16_43fc:
	ld a, [hl] ; $43fc
	cp a, $00 ; $43fd
	jr z, Label_16_4430 ; $43ff
	ld [de], a ; $4401
	inc hl ; $4402
	ld a, [hl] ; $4403
	cp a, $de ; $4404
	jr z, Label_16_440c ; $4406
	cp a, $df ; $4408
	jr nz, Label_16_4421 ; $440a
Label_16_440c:
	push hl ; $440c
	push bc ; $440d
	ld h, d ; $440e
	ld l, e ; $440f
	ld bc, $ffe0 ; $4410
	add hl, bc ; $4413
	ld b, a ; $4414
	ld a, [hl] ; $4415
	cp a, $03 ; $4416
	ld a, b ; $4418
	jr nz, Label_16_441d ; $4419
	sub a, $d0 ; $441b
Label_16_441d:
	ld [hl], a ; $441d
	pop bc ; $441e
	pop hl ; $441f
	inc hl ; $4420
Label_16_4421:
	inc de ; $4421
	ld a, e ; $4422
	and a, $1f ; $4423
	jr nz, Label_16_43fc ; $4425
	push hl ; $4427
	ld h, d ; $4428
	ld l, e ; $4429
	add hl, de ; $442a
	ld d, h ; $442b
	ld e, l ; $442c
	pop hl ; $442d
	jr Label_16_43fc ; $442e
Label_16_4430:
	pop bc ; $4430
	pop af ; $4431
	ret ; $4432
	INCBIN "data/bank_016/d_4433.bin" ; $4433, 68 bytes
RunMatchWinLoseScreen:
	ld a, [$c4c3] ; $4477
	bit 7, a ; $447a
	ret nz ; $447c
	call DisableLCDSafely ; $447d
	call ClearFrameTasks ; $4480
	wram_bank $03 ; $4483
	ld a, [wGameMode] ; $4489
	cp a, $04 ; $448c
	jr z, Label_16_4496 ; $448e
	cp a, $09 ; $4490
	jr z, Label_16_4496 ; $4492
	jr Label_16_449a ; $4494
Label_16_4496:
	ld a, $01 ; $4496
	jr Label_16_449b ; $4498
Label_16_449a:
	xor a, a ; $449a
Label_16_449b:
	ld [$d800], a ; $449b
	ld [$d801], a ; $449e
	ld a, [wMatchWinLoseFlag] ; $44a1
	ld [$cb73], a ; $44a4
	call Func_16_5c11 ; $44a7
	ld a, $ff ; $44aa
	ld a, [wMatchWinLoseFlag] ; $44ac
	cp a, $ff ; $44af
	jr z, Label_16_44b7 ; $44b1
	sound $09 ; $44b3
	jr Label_16_44b9 ; $44b5
Label_16_44b7:
	sound $0a ; $44b7
Label_16_44b9:
	call InitMatchWinLoseScreen ; $44b9
	farcall FarPtr_39_04 ; $44bc
	ld a, $01 ; $44bf
	ld hl, $43f6 ; $44c1
	call RegisterFrameTask ; $44c4
	ld a, $01 ; $44c7
	ld hl, $4cb1 ; $44c9
	call RegisterFrameTask ; $44cc
	call EnableLCD ; $44cf
	ld c, $10 ; $44d2
	call Func_00_1d2e ; $44d4
	call Func_00_1da4 ; $44d7
	ld a, $08 ; $44da
	ldh [rSTAT], a ; $44dc
	ld hl, rIE ; $44de
	set 1, [hl] ; $44e1
	ld a, $48 ; $44e3
	ld [$cb02], a ; $44e5
	ld a, $57 ; $44e8
	ld [$cb03], a ; $44ea
	xor a, a ; $44ed
	ld [$cb01], a ; $44ee
	ld a, $01 ; $44f1
	ld hl, $4c9d ; $44f3
	call RegisterFrameTask ; $44f6
Label_16_44f9:
	call AdvanceFrame ; $44f9
	ld a, [$c8f7] ; $44fc
	push de ; $44ff
	push af ; $4500
	ld a, a ; $4501
	ld de, $0303 ; $4502
	call PrintDecimalByte ; $4505
	pop af ; $4508
	pop de ; $4509
	ldh a, [hInputPressed] ; $450a
	ld [wMenuInputPressed], a ; $450c
	bit 0, a ; $450f
	jr nz, Label_16_451d ; $4511
	bit 1, a ; $4513
	jr nz, Label_16_451d ; $4515
	bit 4, a ; $4517
	jr nz, Label_16_453b ; $4519
	jr Label_16_44f9 ; $451b
Label_16_451d:
	sound $5f ; $451d
	call ClearFrameTasks ; $451f
	ld c, $40 ; $4522
	call Func_00_1d20 ; $4524
	call Func_00_1da4 ; $4527
	ld hl, rIE ; $452a
	res 1, [hl] ; $452d
	ld a, $03 ; $452f
	ld [$cb0c], a ; $4531
	ld a, [$cb73] ; $4534
	ld [wMatchWinLoseFlag], a ; $4537
	ret ; $453a
Label_16_453b:
	ld c, $40 ; $453b
	call Func_00_1d20 ; $453d
	call Func_00_1da4 ; $4540
	ld hl, rIE ; $4543
	res 1, [hl] ; $4546
	call ClearFrameTasks ; $4548
	call RunMatchStatsScreen ; $454b
	push af ; $454e
	ld a, [$cb73] ; $454f
	ld [wMatchWinLoseFlag], a ; $4552
	pop af ; $4555
	cp a, $ff ; $4556
	jp nz, RunMatchWinLoseScreen ; $4558
	call ClearFrameTasks ; $455b
	ld c, $08 ; $455e
	call Func_00_1d20 ; $4560
	call Func_00_1da4 ; $4563
	ld hl, rIE ; $4566
	res 1, [hl] ; $4569
	ld a, $03 ; $456b
	ld [$cb0c], a ; $456d
	ret ; $4570
InitMatchWinLoseScreen:
	call ClearFrameTasks ; $4571
	xor a, a ; $4574
	ldh [$ff8b], a ; $4575
	ldh [$ff8a], a ; $4577
	call Func_16_490c ; $4579
	wram_bank $03 ; $457c
	ld de, $d560 ; $4582
	ld b, $14 ; $4585
	ld c, $05 ; $4587
	ld h, $0a ; $4589
	farcall FarPtr_39_0c ; $458b
	ld a, $00 ; $458e
	ld d, $04 ; $4590
	farcall FarPtr_18_02 ; $4592
	ld a, $00 ; $4595
	ld d, $05 ; $4597
	farcall FarPtr_18_02 ; $4599
	ld a, $00 ; $459c
	ld d, $06 ; $459e
	farcall FarPtr_18_02 ; $45a0
	ld a, $00 ; $45a3
	ld d, $07 ; $45a5
	farcall FarPtr_18_02 ; $45a7
	call LoadMatchResultPalettes ; $45aa
	call Func_16_4a56 ; $45ad
	call Func_16_4dfe ; $45b0
	call Func_16_4963 ; $45b3
	ld c, $00 ; $45b6
	call Func_16_5fe7 ; $45b8
	ldh a, [hWramBank] ; $45bb
	push af ; $45bd
	wram_bank $01 ; $45be
	ld hl, $4608 ; $45c4
	ld de, $d000 ; $45c7
	call DecompressData ; $45ca
	ld hl, $d000 ; $45cd
	ld de, $a000 ; $45d0
	ld c, $20 ; $45d3
	call Func_00_0480 ; $45d5
	ld hl, $4784 ; $45d8
	ld de, $d000 ; $45db
	call DecompressData ; $45de
	ld hl, $d000 ; $45e1
	ld de, $a200 ; $45e4
	ld c, $20 ; $45e7
	call Func_00_0480 ; $45e9
	ld hl, $48f4 ; $45ec
	ld de, $0803 ; $45ef
	call LoadPaletteShadow ; $45f2
	ld b, $09 ; $45f5
	ld c, $04 ; $45f7
	ld de, $a400 ; $45f9
	farcall FarPtr_39_10 ; $45fc
	pop af ; $45ff
	wram_bank ; $4600
	farcall FarPtr_Func_39_4325 ; $4604
	ret ; $4607
	INCBIN "data/bank_016/d_4608.bin" ; $4608, 559 bytes
Label_16_4837:
	ldh [rAUD3HIGH], a ; $4837
	INCBIN "data/bank_016/d_4839.bin" ; $4839, 10 bytes
	rst Rst38 ; $4843
	rra ; $4844
	rst Rst20 ; $4845
	jr Label_16_4837 ; $4846
	INCBIN "data/bank_016/d_4848.bin" ; $4848, 196 bytes
Func_16_490c:
	ld a, [$d800] ; $490c
	or a, a ; $490f
	jr z, Label_16_4919 ; $4910
	ld c, $14 ; $4912
	farcall FarPtr_LoadScreenAssetRecord ; $4914
	jr Label_16_4920 ; $4917
Label_16_4919:
	ld c, $13 ; $4919
	farcall FarPtr_LoadScreenAssetRecord ; $491b
	jr Label_16_4920 ; $491e
Label_16_4920:
	ld de, $002f ; $4920
	call Func_00_24ef ; $4923
	jr nz, Label_16_4962 ; $4926
	wram_bank $03 ; $4928
	ld hl, $d280 ; $492e
	ld de, $d08b ; $4931
	ld b, $09 ; $4934
	ld c, $05 ; $4936
	farcall FarPtr_39_0a ; $4938
	ld hl, $d680 ; $493b
	ld de, $d48b ; $493e
	ld b, $09 ; $4941
	ld c, $05 ; $4943
	farcall FarPtr_39_0a ; $4945
	ld hl, $d289 ; $4948
	ld de, $d161 ; $494b
	ld b, $08 ; $494e
	ld c, $05 ; $4950
	farcall FarPtr_39_0a ; $4952
	ld hl, $d689 ; $4955
	ld de, $d561 ; $4958
	ld b, $08 ; $495b
	ld c, $05 ; $495d
	farcall FarPtr_39_0a ; $495f
Label_16_4962:
	ret ; $4962
Func_16_4963:
	ld a, [$d801] ; $4963
	or a, a ; $4966
	jr nz, Label_16_49bc ; $4967
	ld de, $002f ; $4969
	call Func_00_24ef ; $496c
	jr z, Label_16_49a3 ; $496f
	ld de, $d48b ; $4971
	ld b, $04 ; $4974
	ld c, $04 ; $4976
	ld h, $0c ; $4978
	farcall FarPtr_39_0c ; $497a
	ld de, $d48f ; $497d
	ld b, $04 ; $4980
	ld c, $04 ; $4982
	ld h, $0d ; $4984
	farcall FarPtr_39_0c ; $4986
	ld de, $d582 ; $4989
	ld b, $03 ; $498c
	ld c, $03 ; $498e
	ld h, $0e ; $4990
	farcall FarPtr_39_0c ; $4992
	ld de, $d585 ; $4995
	ld b, $03 ; $4998
	ld c, $03 ; $499a
	ld h, $0f ; $499c
	farcall FarPtr_39_0c ; $499e
	jr Label_16_49bb ; $49a1
Label_16_49a3:
	ld de, $d48d ; $49a3
	ld b, $04 ; $49a6
	ld c, $04 ; $49a8
	ld h, $0c ; $49aa
	farcall FarPtr_39_0c ; $49ac
	ld de, $d583 ; $49af
	ld b, $03 ; $49b2
	ld c, $03 ; $49b4
	ld h, $0e ; $49b6
	farcall FarPtr_39_0c ; $49b8
Label_16_49bb:
	ret ; $49bb
Label_16_49bc:
	ld de, $002f ; $49bc
	call Func_00_24ef ; $49bf
	jr z, Label_16_49f6 ; $49c2
	ld de, $d4ac ; $49c4
	ld b, $03 ; $49c7
	ld c, $03 ; $49c9
	ld h, $0c ; $49cb
	farcall FarPtr_39_0c ; $49cd
	ld de, $d4af ; $49d0
	ld b, $03 ; $49d3
	ld c, $03 ; $49d5
	ld h, $0d ; $49d7
	farcall FarPtr_39_0c ; $49d9
	ld de, $d582 ; $49dc
	ld b, $03 ; $49df
	ld c, $03 ; $49e1
	ld h, $0e ; $49e3
	farcall FarPtr_39_0c ; $49e5
	ld de, $d585 ; $49e8
	ld b, $03 ; $49eb
	ld c, $03 ; $49ed
	ld h, $0f ; $49ef
	farcall FarPtr_39_0c ; $49f1
	jr Label_16_4a0e ; $49f4
Label_16_49f6:
	ld de, $d4ad ; $49f6
	ld b, $03 ; $49f9
	ld c, $03 ; $49fb
	ld h, $0c ; $49fd
	farcall FarPtr_39_0c ; $49ff
	ld de, $d583 ; $4a02
	ld b, $03 ; $4a05
	ld c, $03 ; $4a07
	ld h, $0e ; $4a09
	farcall FarPtr_39_0c ; $4a0b
Label_16_4a0e:
	ret ; $4a0e
LoadMatchResultPalettes:
	ld a, [wMatchWinLoseFlag] ; $4a0f
	cp a, $ff ; $4a12
	jr z, Label_16_4a2e ; $4a14
	ld a, $02 ; $4a16
	ld [$cb0b], a ; $4a18
	ld hl, $4a4e ; $4a1b
	ld de, $0101 ; $4a1e
	call LoadPaletteShadow ; $4a21
	ld hl, $4a46 ; $4a24
	ld de, $0201 ; $4a27
	call LoadPaletteShadow ; $4a2a
	ret ; $4a2d
Label_16_4a2e:
	ld a, $03 ; $4a2e
	ld [$cb0b], a ; $4a30
	ld hl, $4a4e ; $4a33
	ld de, $0201 ; $4a36
	call LoadPaletteShadow ; $4a39
	ld hl, $4a46 ; $4a3c
	ld de, $0101 ; $4a3f
	call LoadPaletteShadow ; $4a42
	ret ; $4a45
	; $4a46, 16 bytes (palettes)
; GBC palettes (BGR555), 4 colors each
	dw $7de0, $5160, $2900, $2900 ; pal 0: #007bff #005aa4 #004152 #004152
	dw $5a9f, $39bf, $009f, $001f ; pal 1: #ffa4b4 #ff6a73 #ff2000 #ff0000
Func_16_4a56:
	ld a, [wMatchWinLoseFlag] ; $4a56
	cp a, $ff ; $4a59
	jr nz, Label_16_4a6f ; $4a5b
	ld hl, $d240 ; $4a5d
	ld de, $d120 ; $4a60
	ld b, $20 ; $4a63
	ld c, $02 ; $4a65
	farcall FarPtr_39_0a ; $4a67
	ld a, $06 ; $4a6a
	ld [$cb0c], a ; $4a6c
Label_16_4a6f:
	ret ; $4a6f
	ret ; $4a70
	ld a, [$c8f7] ; $4a71
	add a, a ; $4a74
	ld hl, $4abd ; $4a75
	add a, l ; $4a78
	ld l, a ; $4a79
	jr nc, Label_16_4a7d ; $4a7a
	inc h ; $4a7c
Label_16_4a7d:
	ld a, [hl+] ; $4a7d
	ld h, [hl] ; $4a7e
	ld l, a ; $4a7f
Label_16_4a80:
	ld a, [hl+] ; $4a80
	ld d, [hl] ; $4a81
	ld e, a ; $4a82
	ld a, d ; $4a83
	or a, e ; $4a84
	jr z, Label_16_4a99 ; $4a85
	inc hl ; $4a87
	ld a, [hl+] ; $4a88
	ld b, [hl] ; $4a89
	ld c, a ; $4a8a
	inc hl ; $4a8b
	ld a, [hl+] ; $4a8c
	push hl ; $4a8d
	ld h, b ; $4a8e
	ld l, c ; $4a8f
	ld b, a ; $4a90
	ld c, $02 ; $4a91
	farcall FarPtr_39_0a ; $4a93
	pop hl ; $4a96
	jr Label_16_4a80 ; $4a97
Label_16_4a99:
	ld a, [wCurrentMinigameStoryMatch] ; $4a99
	cp a, $01 ; $4a9c
	jr nz, Label_16_4aaf ; $4a9e
	ld hl, $d3c7 ; $4aa0
	ld de, $d200 ; $4aa3
	ld b, $06 ; $4aa6
	ld c, $02 ; $4aa8
	farcall FarPtr_39_0a ; $4aaa
	jr Label_16_4abc ; $4aad
Label_16_4aaf:
	ld hl, $d3c0 ; $4aaf
	ld de, $d200 ; $4ab2
	ld b, $07 ; $4ab5
	ld c, $02 ; $4ab7
	farcall FarPtr_39_0a ; $4ab9
Label_16_4abc:
	ret ; $4abc
	; $4abd, 480 bytes (records:2)
; 240 records x 2 bytes
	dw $4ae5 ; record 0
	dw $4af9 ; record 1
	dw $4b12 ; record 2
	dw $4b2b ; record 3
	dw $4b44 ; record 4
	dw $4b5d ; record 5
	dw $4b71 ; record 6
	dw $4b8a ; record 7
	dw $4ba3 ; record 8
	dw $4bbc ; record 9
	dw $4bd5 ; record 10
	dw $4be9 ; record 11
	dw $4c02 ; record 12
	dw $4c1b ; record 13
	dw $4c34 ; record 14
	dw $4c4d ; record 15
	dw $4c5c ; record 16
	dw $4c6b ; record 17
	dw $4c7f ; record 18
	dw $4c8e ; record 19
	dw $d000 ; record 20
	dw $d2c0 ; record 21
	dw $0b0a ; record 22
	dw $cad0 ; record 23
	dw $09d2 ; record 24
	dw $d20a ; record 25
	dw $d3cd ; record 26
	dw $0009 ; record 27
	dw $0000 ; record 28
	dw $0000 ; record 29
	dw $d000 ; record 30
	dw $d2c0 ; record 31
	dw $0b0a ; record 32
	dw $cad0 ; record 33
	dw $09d2 ; record 34
	dw $d209 ; record 35
	dw $d380 ; record 36
	dw $1007 ; record 37
	dw $93d2 ; record 38
	dw $04d3 ; record 39
	dw $0000 ; record 40
	dw $0000 ; record 41
	dw $0000 ; record 42
	dw $c0d0 ; record 43
	dw $0ad2 ; record 44
	dw $d00b ; record 45
	dw $d2ca ; record 46
	dw $0909 ; record 47
	dw $80d2 ; record 48
	dw $07d3 ; record 49
	dw $d210 ; record 50
	dw $d38f ; record 51
	dw $0004 ; record 52
	dw $0000 ; record 53
	dw $0000 ; record 54
	dw $d000 ; record 55
	dw $d2c0 ; record 56
	dw $0b0a ; record 57
	dw $cad0 ; record 58
	dw $09d2 ; record 59
	dw $d209 ; record 60
	dw $d380 ; record 61
	dw $1007 ; record 62
	dw $8bd2 ; record 63
	dw $04d3 ; record 64
	dw $0000 ; record 65
	dw $0000 ; record 66
	dw $0000 ; record 67
	dw $c0d0 ; record 68
	dw $0ad2 ; record 69
	dw $d00b ; record 70
	dw $d2ca ; record 71
	dw $0909 ; record 72
	dw $80d2 ; record 73
	dw $07d3 ; record 74
	dw $d210 ; record 75
	dw $d388 ; record 76
	dw $0003 ; record 77
	dw $0000 ; record 78
	dw $0000 ; record 79
	dw $d000 ; record 80
	dw $d2c0 ; record 81
	dw $0b0a ; record 82
	dw $d3d0 ; record 83
	dw $08d2 ; record 84
	dw $d20a ; record 85
	dw $d3cd ; record 86
	dw $0009 ; record 87
	dw $0000 ; record 88
	dw $0000 ; record 89
	dw $d000 ; record 90
	dw $d2c0 ; record 91
	dw $0b0a ; record 92
	dw $d3d0 ; record 93
	dw $08d2 ; record 94
	dw $d209 ; record 95
	dw $d380 ; record 96
	dw $1007 ; record 97
	dw $93d2 ; record 98
	dw $04d3 ; record 99
	dw $0000 ; record 100
	dw $0000 ; record 101
	dw $0000 ; record 102
	dw $c0d0 ; record 103
	dw $0ad2 ; record 104
	dw $d00b ; record 105
	dw $d2d3 ; record 106
	dw $0908 ; record 107
	dw $80d2 ; record 108
	dw $07d3 ; record 109
	dw $d210 ; record 110
	dw $d38f ; record 111
	dw $0004 ; record 112
	dw $0000 ; record 113
	dw $0000 ; record 114
	dw $d000 ; record 115
	dw $d2c0 ; record 116
	dw $0b0a ; record 117
	dw $d3d0 ; record 118
	dw $08d2 ; record 119
	dw $d209 ; record 120
	dw $d380 ; record 121
	dw $1007 ; record 122
	dw $8bd2 ; record 123
	dw $04d3 ; record 124
	dw $0000 ; record 125
	dw $0000 ; record 126
	dw $0000 ; record 127
	dw $c0d0 ; record 128
	dw $0ad2 ; record 129
	dw $d00b ; record 130
	dw $d2d3 ; record 131
	dw $0908 ; record 132
	dw $80d2 ; record 133
	dw $07d3 ; record 134
	dw $d210 ; record 135
	dw $d388 ; record 136
	dw $0003 ; record 137
	dw $0000 ; record 138
	dw $0000 ; record 139
	dw $d000 ; record 140
	dw $d2c0 ; record 141
	dw $0a0a ; record 142
	dw $00d0 ; record 143
	dw $0ad3 ; record 144
	dw $d20a ; record 145
	dw $d3cd ; record 146
	dw $0009 ; record 147
	dw $0000 ; record 148
	dw $0000 ; record 149
	dw $d000 ; record 150
	dw $d2c0 ; record 151
	dw $0a0a ; record 152
	dw $00d0 ; record 153
	dw $0ad3 ; record 154
	dw $d209 ; record 155
	dw $d380 ; record 156
	dw $1007 ; record 157
	dw $93d2 ; record 158
	dw $04d3 ; record 159
	dw $0000 ; record 160
	dw $0000 ; record 161
	dw $0000 ; record 162
	dw $c0d0 ; record 163
	dw $0ad2 ; record 164
	dw $d00a ; record 165
	dw $d300 ; record 166
	dw $090a ; record 167
	dw $80d2 ; record 168
	dw $07d3 ; record 169
	dw $d210 ; record 170
	dw $d38f ; record 171
	dw $0004 ; record 172
	dw $0000 ; record 173
	dw $0000 ; record 174
	dw $d000 ; record 175
	dw $d2c0 ; record 176
	dw $0a0a ; record 177
	dw $00d0 ; record 178
	dw $0ad3 ; record 179
	dw $d209 ; record 180
	dw $d380 ; record 181
	dw $1007 ; record 182
	dw $8bd2 ; record 183
	dw $04d3 ; record 184
	dw $0000 ; record 185
	dw $0000 ; record 186
	dw $0000 ; record 187
	dw $c0d0 ; record 188
	dw $0ad2 ; record 189
	dw $d00a ; record 190
	dw $d300 ; record 191
	dw $090a ; record 192
	dw $80d2 ; record 193
	dw $07d3 ; record 194
	dw $d210 ; record 195
	dw $d388 ; record 196
	dw $0003 ; record 197
	dw $0000 ; record 198
	dw $0000 ; record 199
	dw $d000 ; record 200
	dw $d280 ; record 201
	dw $0a14 ; record 202
	dw $cdd2 ; record 203
	dw $09d3 ; record 204
	dw $0000 ; record 205
	dw $0000 ; record 206
	dw $0000 ; record 207
	dw $80d0 ; record 208
	dw $14d2 ; record 209
	dw $d20a ; record 210
	dw $d340 ; record 211
	dw $0007 ; record 212
	dw $0000 ; record 213
	dw $0000 ; record 214
	dw $d000 ; record 215
	dw $d280 ; record 216
	dw $0914 ; record 217
	dw $80d2 ; record 218
	dw $07d3 ; record 219
	dw $d20a ; record 220
	dw $d347 ; record 221
	dw $0008 ; record 222
	dw $0000 ; record 223
	dw $0000 ; record 224
	dw $d000 ; record 225
	dw $d280 ; record 226
	dw $0914 ; record 227
	dw $4fd2 ; record 228
	dw $0ad3 ; record 229
	dw $0000 ; record 230
	dw $0000 ; record 231
	dw $0000 ; record 232
	dw $80d0 ; record 233
	dw $14d2 ; record 234
	dw $d20c ; record 235
	dw $d359 ; record 236
	dw $0007 ; record 237
	dw $0000 ; record 238
	dw $0000 ; record 239
	ld a, [wMatchWinLoseFlag] ; $4c9d
	cp a, $ff ; $4ca0
	jr nz, Label_16_4ca9 ; $4ca2
	ldh a, [$ff8c] ; $4ca4
	and a, $01 ; $4ca6
	ret z ; $4ca8
Label_16_4ca9:
	ld a, [$cb01] ; $4ca9
	inc a ; $4cac
	ld [$cb01], a ; $4cad
	ret ; $4cb0
	ld a, [wMatchWinLoseFlag] ; $4cb1
	cp a, $ff ; $4cb4
	jr z, Label_16_4cd1 ; $4cb6
	ld de, $0824 ; $4cb8
	call Func_16_4cea ; $4cbb
	ld de, $502c ; $4cbe
	call Func_16_4d96 ; $4cc1
	ld de, $5060 ; $4cc4
	call Func_16_4d45 ; $4cc7
	ld de, $4e68 ; $4cca
	call Func_16_4dad ; $4ccd
	ret ; $4cd0
Label_16_4cd1:
	ld de, $5860 ; $4cd1
	call Func_16_4cea ; $4cd4
	ld de, $5068 ; $4cd7
	call Func_16_4dc7 ; $4cda
	ld de, $0024 ; $4cdd
	call Func_16_4d45 ; $4ce0
	ld de, $482c ; $4ce3
	call Func_16_4dba ; $4ce6
	ret ; $4ce9
Func_16_4cea:
	call Func_16_4dde ; $4cea
	ld b, a ; $4ced
	ld a, d ; $4cee
	sub a, b ; $4cef
	ld d, a ; $4cf0
	ld c, $00 ; $4cf1
	ld b, $08 ; $4cf3
	ldh a, [$ff8c] ; $4cf5
	and a, $10 ; $4cf7
	jr z, Label_16_4cfd ; $4cf9
	ld b, $0a ; $4cfb
Label_16_4cfd:
	ld hl, $4d04 ; $4cfd
	call QueueSpriteTemplate ; $4d00
	ret ; $4d03
	; $4d04, 65 bytes (bytes:4)
	db $10, $08, $00, $00 ; 0x00
	db $20, $08, $02, $00 ; 0x04
	db $10, $10, $04, $00 ; 0x08
	db $20, $10, $06, $00 ; 0x0c
	db $10, $18, $08, $00 ; 0x10
	db $20, $18, $0a, $00 ; 0x14
	db $10, $20, $0c, $00 ; 0x18
	db $20, $20, $0e, $00 ; 0x1c
	db $10, $28, $10, $00 ; 0x20
	db $20, $28, $12, $00 ; 0x24
	db $10, $30, $14, $00 ; 0x28
	db $20, $30, $16, $00 ; 0x2c
	db $10, $38, $18, $00 ; 0x30
	db $20, $38, $1a, $00 ; 0x34
	db $10, $40, $1c, $00 ; 0x38
	db $20, $40, $1e, $00 ; 0x3c
	db $80 ; 0x40
Func_16_4d45:
	call Func_16_4dde ; $4d45
	add a, d ; $4d48
	ld d, a ; $4d49
	ld c, $20 ; $4d4a
	ld b, $09 ; $4d4c
	ld hl, $4d55 ; $4d4e
	call QueueSpriteTemplate ; $4d51
	ret ; $4d54
	; $4d55, 65 bytes (bytes:4)
	db $10, $08, $00, $00 ; 0x00
	db $20, $08, $02, $00 ; 0x04
	db $10, $10, $04, $00 ; 0x08
	db $20, $10, $06, $00 ; 0x0c
	db $10, $18, $08, $00 ; 0x10
	db $20, $18, $0a, $00 ; 0x14
	db $10, $20, $0c, $00 ; 0x18
	db $20, $20, $0e, $00 ; 0x1c
	db $10, $28, $10, $00 ; 0x20
	db $20, $28, $12, $00 ; 0x24
	db $10, $30, $14, $00 ; 0x28
	db $20, $30, $16, $00 ; 0x2c
	db $10, $38, $18, $00 ; 0x30
	db $20, $38, $1a, $00 ; 0x34
	db $10, $40, $1c, $00 ; 0x38
	db $20, $40, $1e, $00 ; 0x3c
	db $80 ; 0x40
Func_16_4d96:
	call Func_16_4dde ; $4d96
	ld b, a ; $4d99
	ld a, d ; $4d9a
	sub a, b ; $4d9b
	ld d, a ; $4d9c
	ld c, $40 ; $4d9d
	ld b, $08 ; $4d9f
	ldh a, [$ff8c] ; $4da1
	and a, $10 ; $4da3
	jr z, Label_16_4da9 ; $4da5
	ld b, $0a ; $4da7
Label_16_4da9:
	call QueueSprite ; $4da9
	ret ; $4dac
Func_16_4dad:
	call Func_16_4dde ; $4dad
	add a, d ; $4db0
	ld d, a ; $4db1
	ld c, $42 ; $4db2
	ld b, $09 ; $4db4
	call QueueSprite ; $4db6
	ret ; $4db9
Func_16_4dba:
	call Func_16_4dde ; $4dba
	add a, d ; $4dbd
	ld d, a ; $4dbe
	ld c, $40 ; $4dbf
	ld b, $09 ; $4dc1
	call QueueSprite ; $4dc3
	ret ; $4dc6
Func_16_4dc7:
	call Func_16_4dde ; $4dc7
	ld b, a ; $4dca
	ld a, d ; $4dcb
	sub a, b ; $4dcc
	ld d, a ; $4dcd
	ld c, $42 ; $4dce
	ld b, $08 ; $4dd0
	ldh a, [$ff8c] ; $4dd2
	and a, $10 ; $4dd4
	jr z, Label_16_4dda ; $4dd6
	ld b, $0a ; $4dd8
Label_16_4dda:
	call QueueSprite ; $4dda
	ret ; $4ddd
Func_16_4dde:
	ldh a, [$ff8c] ; $4dde
	srl a ; $4de0
	and a, $0f ; $4de2
	ld hl, $4dee ; $4de4
	add a, l ; $4de7
	ld l, a ; $4de8
	jr nc, Label_16_4dec ; $4de9
	inc h ; $4deb
Label_16_4dec:
	ld a, [hl] ; $4dec
	ret ; $4ded
	INCBIN "data/bank_016/d_4dee.bin" ; $4dee, 16 bytes
Func_16_4dfe:
	ld de, $d400 ; $4dfe
	ld b, $14 ; $4e01
	ld c, $02 ; $4e03
	ld h, $0b ; $4e05
	farcall FarPtr_39_0c ; $4e07
	ld de, $d600 ; $4e0a
	ld b, $14 ; $4e0d
	ld c, $02 ; $4e0f
	ld h, $0b ; $4e11
	farcall FarPtr_39_0c ; $4e13
	ld de, $002f ; $4e16
	call Func_00_24ef ; $4e19
	jr nz, Label_16_4e29 ; $4e1c
	ld hl, $542e ; $4e1e
	ld de, $9000 ; $4e21
	call DecompressData ; $4e24
	jr Label_16_4e32 ; $4e27
Label_16_4e29:
	ld hl, $54bd ; $4e29
	ld de, $9000 ; $4e2c
	call DecompressData ; $4e2f
Label_16_4e32:
	ld a, [$d800] ; $4e32
	or a, a ; $4e35
	jr z, Label_16_4e54 ; $4e36
	ld hl, $5357 ; $4e38
	ld de, $8900 ; $4e3b
	call DecompressData ; $4e3e
	ld hl, $53c1 ; $4e41
	ld de, $8a40 ; $4e44
	call DecompressData ; $4e47
	ld hl, $5bf5 ; $4e4a
	ld de, $9140 ; $4e4d
	call DecompressData ; $4e50
	ret ; $4e53
Label_16_4e54:
	ld a, [$c8f7] ; $4e54
	call Func_16_4e8a ; $4e57
	add a, a ; $4e5a
	ld hl, $4e9d ; $4e5b
	add a, l ; $4e5e
	ld l, a ; $4e5f
	jr nc, Label_16_4e63 ; $4e60
	inc h ; $4e62
Label_16_4e63:
	ld a, [hl+] ; $4e63
	ld h, [hl] ; $4e64
	ld l, a ; $4e65
	push hl ; $4e66
	ld a, [hl+] ; $4e67
	ld h, [hl] ; $4e68
	ld l, a ; $4e69
	ld de, $8900 ; $4e6a
	call DecompressData ; $4e6d
	pop hl ; $4e70
	inc hl ; $4e71
	inc hl ; $4e72
	push hl ; $4e73
	ld a, [hl+] ; $4e74
	ld h, [hl] ; $4e75
	ld l, a ; $4e76
	ld de, $8a40 ; $4e77
	call DecompressData ; $4e7a
	pop hl ; $4e7d
	inc hl ; $4e7e
	inc hl ; $4e7f
	ld a, [hl+] ; $4e80
	ld h, [hl] ; $4e81
	ld l, a ; $4e82
	ld de, $9140 ; $4e83
	call DecompressData ; $4e86
	ret ; $4e89
Func_16_4e8a:
	push af ; $4e8a
	ld de, $002f ; $4e8b
	call Func_00_24ef ; $4e8e
	jr z, Label_16_4e9b ; $4e91
	cp a, $11 ; $4e93
	jr nz, Label_16_4e9b ; $4e95
	ld a, $10 ; $4e97
	pop hl ; $4e99
	ret ; $4e9a
Label_16_4e9b:
	pop af ; $4e9b
	ret ; $4e9c
	; $4e9d, 2334 bytes (records:2)
; 1167 records x 2 bytes
	dw $4ecf ; record 0
	dw $4ed5 ; record 1
	dw $4edb ; record 2
	dw $4ee1 ; record 3
	dw $4ee7 ; record 4
	dw $4eed ; record 5
	dw $4ef3 ; record 6
	dw $4ef9 ; record 7
	dw $4eff ; record 8
	dw $4f05 ; record 9
	dw $4f0b ; record 10
	dw $4f11 ; record 11
	dw $4f17 ; record 12
	dw $4f1d ; record 13
	dw $4f23 ; record 14
	dw $4f29 ; record 15
	dw $4f2f ; record 16
	dw $4f35 ; record 17
	dw $4f3b ; record 18
	dw $4f41 ; record 19
	dw $4f47 ; record 20
	dw $4f47 ; record 21
	dw $4f47 ; record 22
	dw $4f47 ; record 23
	dw $4f47 ; record 24
	dw $5093 ; record 25
	dw $52bd ; record 26
	dw $5a4f ; record 27
	dw $5093 ; record 28
	dw $52bd ; record 29
	dw $59a6 ; record 30
	dw $5093 ; record 31
	dw $52bd ; record 32
	dw $58fa ; record 33
	dw $5093 ; record 34
	dw $52bd ; record 35
	dw $584d ; record 36
	dw $5093 ; record 37
	dw $52bd ; record 38
	dw $57ac ; record 39
	dw $5093 ; record 40
	dw $5212 ; record 41
	dw $5a4f ; record 42
	dw $5093 ; record 43
	dw $5212 ; record 44
	dw $59a6 ; record 45
	dw $5093 ; record 46
	dw $5212 ; record 47
	dw $58fa ; record 48
	dw $5093 ; record 49
	dw $5212 ; record 50
	dw $584d ; record 51
	dw $5093 ; record 52
	dw $5212 ; record 53
	dw $57ac ; record 54
	dw $5093 ; record 55
	dw $5160 ; record 56
	dw $5a4f ; record 57
	dw $5093 ; record 58
	dw $5160 ; record 59
	dw $59a6 ; record 60
	dw $5093 ; record 61
	dw $5160 ; record 62
	dw $58fa ; record 63
	dw $5093 ; record 64
	dw $5160 ; record 65
	dw $584d ; record 66
	dw $5093 ; record 67
	dw $5160 ; record 68
	dw $57ac ; record 69
	dw $4f4d ; record 70
	dw $5014 ; record 71
	dw $5a4f ; record 72
	dw $4f4d ; record 73
	dw $5014 ; record 74
	dw $5642 ; record 75
	dw $4f4d ; record 76
	dw $5014 ; record 77
	dw $56f2 ; record 78
	dw $4f4d ; record 79
	dw $5014 ; record 80
	dw $559e ; record 81
	dw $4f4d ; record 82
	dw $5014 ; record 83
	dw $5541 ; record 84
	dw $5357 ; record 85
	dw $53c1 ; record 86
	dw $5bf5 ; record 87
	dw $00df ; record 88
	dw $3100 ; record 89
	dw $3300 ; record 90
	dw $e8fe ; record 91
	dw $0000 ; record 92
	dw $fb55 ; record 93
	dw $e2fe ; record 94
	dw $fe03 ; record 95
	dw $f3e0 ; record 96
	dw $e0f4 ; record 97
	dw $f600 ; record 98
	dw $d5e0 ; record 99
	dw $fe07 ; record 100
	dw $06e0 ; record 101
	dw $e2fe ; record 102
	dw $e007 ; record 103
	dw $e6e0 ; record 104
	dw $9500 ; record 105
	dw $fef7 ; record 106
	dw $37e0 ; record 107
	dw $e2fe ; record 108
	dw $d0f7 ; record 109
	dw $f6e0 ; record 110
	dw $b6e3 ; record 111
	dw $fefa ; record 112
	dw $f6e0 ; record 113
	dw $e0fe ; record 114
	dw $0000 ; record 115
	dw $00c0 ; record 116
	dw $bfe0 ; record 117
	dw $f000 ; record 118
	dw $7000 ; record 119
	dw $3000 ; record 120
	dw $e2fe ; record 121
	dw $af00 ; record 122
	dw $7c00 ; record 123
	dw $fe00 ; record 124
	dw $e0fe ; record 125
	dw $fec6 ; record 126
	dw $00e4 ; record 127
	dw $00ab ; record 128
	dw $f0fc ; record 129
	dw $fee8 ; record 130
	dw $e090 ; record 131
	dw $fefd ; record 132
	dw $c1e2 ; record 133
	dw $fe7c ; record 134
	dw $f6e0 ; record 135
	dw $00e1 ; record 136
	dw $8c00 ; record 137
	dw $cc00 ; record 138
	dw $e0fe ; record 139
	dw $ec15 ; record 140
	dw $e0fe ; record 141
	dw $d4fc ; record 142
	dw $31e0 ; record 143
	dw $e2b8 ; record 144
	dw $e564 ; record 145
	dw $e162 ; record 146
	dw $1b09 ; record 147
	dw $e0fe ; record 148
	dw $e15c ; record 149
	dw $f0f1 ; record 150
	dw $64e2 ; record 151
	dw $86e3 ; record 152
	dw $84e1 ; record 153
	dw $1de1 ; record 154
	dw $6400 ; record 155
	dw $f6e0 ; record 156
	dw $3600 ; record 157
	dw $e4fe ; record 158
	dw $e1cf ; record 159
	dw $e3e6 ; record 160
	dw $77a5 ; record 161
	dw $e0fe ; record 162
	dw $c037 ; record 163
	dw $6ae2 ; record 164
	dw $70e1 ; record 165
	dw $e060 ; record 166
	dw $48e0 ; record 167
	dw $e058 ; record 168
	dw $e1af ; record 169
	dw $e578 ; record 170
	dw $58fe ; record 171
	dw $9fe0 ; record 172
	dw $fee1 ; record 173
	dw $e060 ; record 174
	dw $c041 ; record 175
	dw $e4fe ; record 176
	dw $e18f ; record 177
	dw $e766 ; record 178
	dw $e164 ; record 179
	dw $e142 ; record 180
	dw $febc ; record 181
	dw $05e0 ; record 182
	dw $fe9c ; record 183
	dw $8ce0 ; record 184
	dw $e270 ; record 185
	dw $0000 ; record 186
	dw $d700 ; record 187
	dw $0000 ; record 188
	dw $fe3f ; record 189
	dw $0ce2 ; record 190
	dw $e4fe ; record 191
	dw $0000 ; record 192
	dw $3e57 ; record 193
	dw $7f00 ; record 194
	dw $e0fe ; record 195
	dw $fe63 ; record 196
	dw $00e4 ; record 197
	dw $e6f6 ; record 198
	dw $f04a ; record 199
	dw $7ee5 ; record 200
	dw $e6e0 ; record 201
	dw $f47f ; record 202
	dw $e0e0 ; record 203
	dw $73e1 ; record 204
	dw $e0fe ; record 205
	dw $7b21 ; record 206
	dw $e0fe ; record 207
	dw $e1c8 ; record 208
	dw $ebc0 ; record 209
	dw $e1f0 ; record 210
	dw $e061 ; record 211
	dw $aee0 ; record 212
	dw $55e1 ; record 213
	dw $f66d ; record 214
	dw $61e0 ; record 215
	dw $e0a0 ; record 216
	dw $febf ; record 217
	dw $b0e2 ; record 218
	dw $e0fe ; record 219
	dw $f614 ; record 220
	dw $c0e1 ; record 221
	dw $7eef ; record 222
	dw $e2fe ; record 223
	dw $fe18 ; record 224
	dw $68e4 ; record 225
	dw $64e5 ; record 226
	dw $84e3 ; record 227
	dw $e572 ; record 228
	dw $e15e ; record 229
	dw $f03e ; record 230
	dw $46f2 ; record 231
	dw $44e7 ; record 232
	dw $f0e1 ; record 233
	dw $6fe1 ; record 234
	dw $fe02 ; record 235
	dw $67e0 ; record 236
	dw $e0fe ; record 237
	dw $e5f0 ; record 238
	dw $e924 ; record 239
	dw $e162 ; record 240
	dw $e7fe ; record 241
	dw $e19f ; record 242
	dw $6600 ; record 243
	dw $64e7 ; record 244
	dw $c0e1 ; record 245
	dw $68ef ; record 246
	dw $60e5 ; record 247
	dw $ffe1 ; record 248
	dw $00e1 ; record 249
	dw $0000 ; record 250
	dw $00d7 ; record 251
	dw $fb00 ; record 252
	dw $e2fe ; record 253
	dw $fe33 ; record 254
	dw $00e4 ; record 255
	dw $fd00 ; record 256
	dw $fee9 ; record 257
	dw $ede0 ; record 258
	dw $0d00 ; record 259
	dw $0f00 ; record 260
	dw $5d00 ; record 261
	dw $fecf ; record 262
	dw $00e0 ; record 263
	dw $a600 ; record 264
	dw $e0fe ; record 265
	dw $feb6 ; record 266
	dw $55e0 ; record 267
	dw $febe ; record 268
	dw $00e2 ; record 269
	dw $e0ea ; record 270
	dw $fedf ; record 271
	dw $d8e0 ; record 272
	dw $e0fe ; record 273
	dw $de7d ; record 274
	dw $e0f6 ; record 275
	dw $0000 ; record 276
	dw $000e ; record 277
	dw $fe1f ; record 278
	dw $75e0 ; record 279
	dw $fe1b ; record 280
	dw $1fe2 ; record 281
	dw $e0c0 ; record 282
	dw $0039 ; record 283
	dw $fe7b ; record 284
	dw $7de0 ; record 285
	dw $fe63 ; record 286
	dw $00e4 ; record 287
	dw $ce00 ; record 288
	dw $ef00 ; record 289
	dw $e0fe ; record 290
	dw $6dd5 ; record 291
	dw $e2fe ; record 292
	dw $a0ed ; record 293
	dw $3ee0 ; record 294
	dw $e0fe ; record 295
	dw $00be ; record 296
	dw $b0f5 ; record 297
	dw $e0fe ; record 298
	dw $febc ; record 299
	dw $00e0 ; record 300
	dw $8500 ; record 301
	dw $d700 ; record 302
	dw $00cd ; record 303
	dw $fefd ; record 304
	dw $cde2 ; record 305
	dw $e0f6 ; record 306
	dw $0000 ; record 307
	dw $9845 ; record 308
	dw $e8fe ; record 309
	dw $68f8 ; record 310
	dw $64e6 ; record 311
	dw $82e3 ; record 312
	dw $0fe1 ; record 313
	dw $e064 ; record 314
	dw $ed87 ; record 315
	dw $ec00 ; record 316
	dw $e0fe ; record 317
	dw $e1ef ; record 318
	dw $e16a ; record 319
	dw $e162 ; record 320
	dw $24b2 ; record 321
	dw $e0fe ; record 322
	dw $e3e0 ; record 323
	dw $fec3 ; record 324
	dw $5ee0 ; record 325
	dw $dee1 ; record 326
	dw $e2d0 ; record 327
	dw $e764 ; record 328
	dw $1b51 ; record 329
	dw $e2c0 ; record 330
	dw $e368 ; record 331
	dw $e15e ; record 332
	dw $b03b ; record 333
	dw $ede2 ; record 334
	dw $e014 ; record 335
	dw $6d57 ; record 336
	dw $6f00 ; record 337
	dw $e0fe ; record 338
	dw $a06e ; record 339
	dw $bce2 ; record 340
	dw $e266 ; record 341
	dw $be49 ; record 342
	dw $e25a ; record 343
	dw $e18f ; record 344
	dw $fecc ; record 345
	dw $7fe8 ; record 346
	dw $f0e1 ; record 347
	dw $e0fe ; record 348
	dw $6001 ; record 349
	dw $e4fe ; record 350
	dw $e1ff ; record 351
	dw $0000 ; record 352
	dw $f700 ; record 353
	dw $0000 ; record 354
	dw $fe0c ; record 355
	dw $00ea ; record 356
	dw $cf00 ; record 357
	dw $d500 ; record 358
	dw $fedf ; record 359
	dw $d9e0 ; record 360
	dw $e2fe ; record 361
	dw $f0df ; record 362
	dw $3ee0 ; record 363
	dw $7500 ; record 364
	dw $febf ; record 365
	dw $b3e0 ; record 366
	dw $e0fe ; record 367
	dw $00bf ; record 368
	dw $e0be ; record 369
	dw $57e0 ; record 370
	dw $003d ; record 371
	dw $fe7d ; record 372
	dw $61e0 ; record 373
	dw $e0fe ; record 374
	dw $f679 ; record 375
	dw $dde0 ; record 376
	dw $e200 ; record 377
	dw $bfe2 ; record 378
	dw $8c00 ; record 379
	dw $e4fe ; record 380
	dw $0000 ; record 381
	dw $6655 ; record 382
	dw $e8fe ; record 383
	dw $b07e ; record 384
	dw $1fe0 ; record 385
	dw $e2fe ; record 386
	dw $fe06 ; record 387
	dw $a9e4 ; record 388
	dw $bc00 ; record 389
	dw $fee0 ; record 390
	dw $30e1 ; record 391
	dw $e0fe ; record 392
	dw $fe3c ; record 393
	dw $00e0 ; record 394
	dw $baaa ; record 395
	dw $fde0 ; record 396
	dw $e0fe ; record 397
	dw $fecd ; record 398
	dw $fde2 ; record 399
	dw $e080 ; record 400
	dw $af8c ; record 401
	dw $dc00 ; record 402
	dw $fc00 ; record 403
	dw $e0fe ; record 404
	dw $acac ; record 405
	dw $0ce2 ; record 406
	dw $00bb ; record 407
	dw $fe0f ; record 408
	dw $07e2 ; record 409
	dw $0300 ; record 410
	dw $e064 ; record 411
	dw $0e00 ; record 412
	dw $e664 ; record 413
	dw $0099 ; record 414
	dw $f019 ; record 415
	dw $66e2 ; record 416
	dw $fce3 ; record 417
	dw $dfe3 ; record 418
	dw $27e1 ; record 419
	dw $003d ; record 420
	dw $fe0d ; record 421
	dw $5ee0 ; record 422
	dw $79e1 ; record 423
	dw $e2d0 ; record 424
	dw $e568 ; record 425
	dw $640a ; record 426
	dw $00e3 ; record 427
	dw $e28c ; record 428
	dw $fe18 ; record 429
	dw $afe4 ; record 430
	dw $68e1 ; record 431
	dw $64e5 ; record 432
	dw $44e3 ; record 433
	dw $e1e0 ; record 434
	dw $e166 ; record 435
	dw $fe3e ; record 436
	dw $8fe2 ; record 437
	dw $64e1 ; record 438
	dw $cde7 ; record 439
	dw $f2b0 ; record 440
	dw $0000 ; record 441
	dw $5d00 ; record 442
	dw $ff00 ; record 443
	dw $3eee ; record 444
	dw $7e00 ; record 445
	dw $e0fe ; record 446
	dw $fe60 ; record 447
	dw $5de0 ; record 448
	dw $f67c ; record 449
	dw $00e0 ; record 450
	dw $fd00 ; record 451
	dw $e2fe ; record 452
	dw $fec1 ; record 453
	dw $5de0 ; record 454
	dw $fef9 ; record 455
	dw $00e0 ; record 456
	dw $9b00 ; record 457
	dw $e0fe ; record 458
	dw $fedb ; record 459
	dw $5de0 ; record 460
	dw $fefb ; record 461
	dw $00e2 ; record 462
	dw $3c00 ; record 463
	dw $e2d0 ; record 464
	dw $fe66 ; record 465
	dw $5fe4 ; record 466
	dw $0000 ; record 467
	dw $00f8 ; record 468
	dw $fefc ; record 469
	dw $cce0 ; record 470
	dw $e0fe ; record 471
	dw $fc5d ; record 472
	dw $e0f4 ; record 473
	dw $0000 ; record 474
	dw $fe3f ; record 475
	dw $0ce2 ; record 476
	dw $e4fe ; record 477
	dw $00a9 ; record 478
	dw $e2a2 ; record 479
	dw $e5a0 ; record 480
	dw $817c ; record 481
	dw $79e0 ; record 482
	dw $e29e ; record 483
	dw $bacd ; record 484
	dw $e2fe ; record 485
	dw $71fd ; record 486
	dw $8ce0 ; record 487
	dw $dc00 ; record 488
	dw $e2be ; record 489
	dw $8aac ; record 490
	dw $e0f6 ; record 491
	dw $628c ; record 492
	dw $06f0 ; record 493
	dw $e0fe ; record 494
	dw $e15e ; record 495
	dw $e1c4 ; record 496
	dw $2000 ; record 497
	dw $e06c ; record 498
	dw $e166 ; record 499
	dw $e35c ; record 500
	dw $e134 ; record 501
	dw $e16a ; record 502
	dw $febb ; record 503
	dw $5ae0 ; record 504
	dw $08e1 ; record 505
	dw $e124 ; record 506
	dw $e368 ; record 507
	dw $e12e ; record 508
	dw $153c ; record 509
	dw $66e2 ; record 510
	dw $fce3 ; record 511
	dw $04e3 ; record 512
	dw $04e1 ; record 513
	dw $e568 ; record 514
	dw $e364 ; record 515
	dw $0c00 ; record 516
	dw $06e0 ; record 517
	dw $5ce1 ; record 518
	dw $e4e3 ; record 519
	dw $64c1 ; record 520
	dw $01e7 ; record 521
	dw $d5cd ; record 522
	dw $6cc2 ; record 523
	dw $fce1 ; record 524
	dw $ffe5 ; record 525
	dw $00e1 ; record 526
	dw $0000 ; record 527
	dw $0075 ; record 528
	dw $eeff ; record 529
	dw $fe06 ; record 530
	dw $00ea ; record 531
	dw $cd00 ; record 532
	dw $eafe ; record 533
	dw $0057 ; record 534
	dw $9b00 ; record 535
	dw $e0fe ; record 536
	dw $fedb ; record 537
	dw $fbe0 ; record 538
	dw $e2fe ; record 539
	dw $005f ; record 540
	dw $3c00 ; record 541
	dw $7e00 ; record 542
	dw $e0fe ; record 543
	dw $fe66 ; record 544
	dw $5fe4 ; record 545
	dw $0000 ; record 546
	dw $00f8 ; record 547
	dw $fefc ; record 548
	dw $cce0 ; record 549
	dw $e0fe ; record 550
	dw $fc5d ; record 551
	dw $e0f4 ; record 552
	dw $0000 ; record 553
	dw $fe3f ; record 554
	dw $0ce2 ; record 555
	dw $e4fe ; record 556
	dw $005d ; record 557
	dw $e2d2 ; record 558
	dw $007e ; record 559
	dw $fe60 ; record 560
	dw $7ce0 ; record 561
	dw $e0fe ; record 562
	dw $009f ; record 563
	dw $7900 ; record 564
	dw $fd00 ; record 565
	dw $e0fe ; record 566
	dw $e39a ; record 567
	dw $aefd ; record 568
	dw $e071 ; record 569
	dw $008c ; record 570
	dw $bedc ; record 571
	dw $ace2 ; record 572
	dw $e0f6 ; record 573
	dw $488c ; record 574
	dw $ee61 ; record 575
	dw $e398 ; record 576
	dw $e18e ; record 577
	dw $453c ; record 578
	dw $c8e2 ; record 579
	dw $fde5 ; record 580
	dw $e0b8 ; record 581
	dw $3404 ; record 582
	dw $6ae1 ; record 583
	dw $bbe1 ; record 584
	dw $e0fe ; record 585
	dw $e15a ; record 586
	dw $f1d0 ; record 587
	dw $e366 ; record 588
	dw $e3fc ; record 589
	dw $0408 ; record 590
	dw $68e1 ; record 591
	dw $64e5 ; record 592
	dw $00e3 ; record 593
	dw $e06c ; record 594
	dw $e166 ; record 595
	dw $e35c ; record 596
	dw $c1e4 ; record 597
	dw $6400 ; record 598
	dw $04e7 ; record 599
	dw $62e1 ; record 600
	dw $fee1 ; record 601
	dw $ffe7 ; record 602
	dw $00e1 ; record 603
	dw $0000 ; record 604
	dw $0051 ; record 605
	dw $ffff ; record 606
	dw $ffff ; record 607
	dw $eaeb ; record 608
	dw $fe1f ; record 609
	dw $18e2 ; record 610
	dw $e0fe ; record 611
	dw $f6ee ; record 612
	dw $00e1 ; record 613
	dw $ec00 ; record 614
	dw $e2fe ; record 615
	dw $000e ; record 616
	dw $af0f ; record 617
	dw $c700 ; record 618
	dw $c300 ; record 619
	dw $e0c1 ; record 620
	dw $fe36 ; record 621
	dw $76e2 ; record 622
	dw $00ef ; record 623
	dw $00f6 ; record 624
	dw $eee7 ; record 625
	dw $00e0 ; record 626
	dw $1900 ; record 627
	dw $feba ; record 628
	dw $f9e6 ; record 629
	dw $e0fe ; record 630
	dw $0000 ; record 631
	dw $fe9f ; record 632
	dw $98e2 ; record 633
	dw $fe80 ; record 634
	dw $f6e0 ; record 635
	dw $ffe1 ; record 636
	dw $ffff ; record 637
	dw $62ff ; record 638
	dw $66eb ; record 639
	dw $64e5 ; record 640
	dw $00e1 ; record 641
	dw $6ee2 ; record 642
	dw $07e0 ; record 643
	dw $e064 ; record 644
	dw $e35c ; record 645
	dw $e1c2 ; record 646
	dw $00c7 ; record 647
	dw $08e6 ; record 648
	dw $e064 ; record 649
	dw $e35c ; record 650
	dw $e1b2 ; record 651
	dw $60f9 ; record 652
	dw $a2e8 ; record 653
	dw $66e1 ; record 654
	dw $64e7 ; record 655
	dw $00e3 ; record 656
	dw $0000 ; record 657
	dw $005f ; record 658
	dw $c600 ; record 659
	dw $e600 ; record 660
	dw $e0fe ; record 661
	dw $fe66 ; record 662
	dw $5de0 ; record 663
	dw $f4e6 ; record 664
	dw $00e0 ; record 665
	dw $fd00 ; record 666
	dw $e2fe ; record 667
	dw $fe31 ; record 668
	dw $5fe4 ; record 669
	dw $0000 ; record 670
	dw $008f ; record 671
	dw $fe9f ; record 672
	dw $98e0 ; record 673
	dw $e4fe ; record 674
	dw $005f ; record 675
	dw $cc00 ; record 676
	dw $ee00 ; record 677
	dw $e0fe ; record 678
	dw $fe6f ; record 679
	dw $15e2 ; record 680
	dw $d06d ; record 681
	dw $30e0 ; record 682
	dw $e6fe ; record 683
	dw $feb0 ; record 684
	dw $ffe0 ; record 685
	dw $ffff ; record 686
	dw $48ff ; record 687
	dw $e9ea ; record 688
	dw $e566 ; record 689
	dw $e364 ; record 690
	dw $6800 ; record 691
	dw $64e6 ; record 692
	dw $00e3 ; record 693
	dw $e468 ; record 694
	dw $5eba ; record 695
	dw $8fe1 ; record 696
	dw $e2b3 ; record 697
	dw $006d ; record 698
	dw $fe6c ; record 699
	dw $ece0 ; record 700
	dw $feaa ; record 701
	dw $cce0 ; record 702
	dw $e2a3 ; record 703
	dw $fef0 ; record 704
	dw $70e2 ; record 705
	dw $e0fe ; record 706
	dw $0030 ; record 707
	dw $ff93 ; record 708
	dw $ffff ; record 709
	dw $eeff ; record 710
	dw $0000 ; record 711
	dw $e700 ; record 712
	dw $ffff ; record 713
	dw $ff00 ; record 714
	dw $f0ea ; record 715
	dw $1fe1 ; record 716
	dw $3f00 ; record 717
	dw $feaa ; record 718
	dw $30e0 ; record 719
	dw $e0fe ; record 720
	dw $f03f ; record 721
	dw $99e2 ; record 722
	dw $e2fe ; record 723
	dw $5c19 ; record 724
	dw $e2fe ; record 725
	dw $e1d0 ; record 726
	dw $008c ; record 727
	dw $fecd ; record 728
	dw $ede0 ; record 729
	dw $e0fe ; record 730
	dw $fd55 ; record 731
	dw $e2d0 ; record 732
	dw $fefd ; record 733
	dw $81e2 ; record 734
	dw $e0fe ; record 735
	dw $c0bd ; record 736
	dw $28e2 ; record 737
	dw $e1f6 ; record 738
	dw $e5fc ; record 739
	dw $e1a0 ; record 740
	dw $e0fc ; record 741
	dw $f9e6 ; record 742
	dw $e4f0 ; record 743
	dw $e1fe ; record 744
	dw $8045 ; record 745
	dw $e0fe ; record 746
	dw $90f8 ; record 747
	dw $80e2 ; record 748
	dw $feed ; record 749
	dw $3ff9 ; record 750
	dw $e062 ; record 751
	dw $0109 ; record 752
	dw $e0fe ; record 753
	dw $e15e ; record 754
	dw $453f ; record 755
	dw $64e0 ; record 756
	dw $5ee3 ; record 757
	dw $74e5 ; record 758
	dw $95e3 ; record 759
	dw $78bd ; record 760
	dw $9de0 ; record 761
	dw $e0fe ; record 762
	dw $258c ; record 763
	dw $f4e0 ; record 764
	dw $8de1 ; record 765
	dw $fe44 ; record 766
	dw $5ce0 ; record 767
	dw $f8e1 ; record 768
	dw $e015 ; record 769
	dw $e564 ; record 770
	dw $e34c ; record 771
	dw $6e00 ; record 772
	dw $11e0 ; record 773
	dw $76f8 ; record 774
	dw $f0e2 ; record 775
	dw $64e5 ; record 776
	dw $0ce1 ; record 777
	dw $e0fe ; record 778
	dw $e15c ; record 779
	dw $e1d0 ; record 780
	dw $ff00 ; record 781
	dw $00fd ; record 782
	dw $0000 ; record 783
	dw $ffe7 ; record 784
	dw $00ff ; record 785
	dw $eaff ; record 786
	dw $e1f0 ; record 787
	dw $003e ; record 788
	dw $4e3f ; record 789
	dw $e0fe ; record 790
	dw $0033 ; record 791
	dw $fe31 ; record 792
	dw $e0e0 ; record 793
	dw $1fe1 ; record 794
	dw $e0f0 ; record 795
	dw $bf27 ; record 796
	dw $b100 ; record 797
	dw $e2fe ; record 798
	dw $e1d0 ; record 799
	dw $f431 ; record 800
	dw $f0e4 ; record 801
	dw $e9e5 ; record 802
	dw $febf ; record 803
	dw $e0e2 ; record 804
	dw $bfe1 ; record 805
	dw $e2c0 ; record 806
	dw $0030 ; record 807
	dw $28b0 ; record 808
	dw $e6fe ; record 809
	dw $e1a0 ; record 810
	dw $e1b2 ; record 811
	dw $ea3f ; record 812
	dw $30e0 ; record 813
	dw $e0a8 ; record 814
	dw $e190 ; record 815
	dw $9f09 ; record 816
	dw $e2ce ; record 817
	dw $e7f0 ; record 818
	dw $fe80 ; record 819
	dw $80e2 ; record 820
	dw $fee7 ; record 821
	dw $6cf9 ; record 822
	dw $49e1 ; record 823
	dw $6431 ; record 824
	dw $5ee0 ; record 825
	dw $3ee1 ; record 826
	dw $e045 ; record 827
	dw $e576 ; record 828
	dw $4cbf ; record 829
	dw $05e0 ; record 830
	dw $f01f ; record 831
	dw $bfea ; record 832
	dw $e2f0 ; record 833
	dw $e766 ; record 834
	dw $e1de ; record 835
	dw $e764 ; record 836
	dw $e5e0 ; record 837
	dw $6638 ; record 838
	dw $3ce5 ; record 839
	dw $54e3 ; record 840
	dw $1fe1 ; record 841
	dw $0100 ; record 842
	dw $e0fe ; record 843
	dw $e5f0 ; record 844
	dw $6400 ; record 845
	dw $5ee3 ; record 846
	dw $ffe9 ; record 847
	dw $00eb ; record 848
	dw $0000 ; record 849
	dw $ff47 ; record 850
	dw $00ff ; record 851
	dw $eaff ; record 852
	dw $fff0 ; record 853
	dw $fff0 ; record 854
	dw $fe7f ; record 855
	dw $95e2 ; record 856
	dw $fe60 ; record 857
	dw $7ee0 ; record 858
	dw $e2d0 ; record 859
	dw $fe33 ; record 860
	dw $c0e8 ; record 861
	dw $19e1 ; record 862
	dw $00ab ; record 863
	dw $fe9b ; record 864
	dw $dbe0 ; record 865
	dw $e0fe ; record 866
	dw $b0fb ; record 867
	dw $f3e2 ; record 868
	dw $f80e ; record 869
	dw $fbe0 ; record 870
	dw $1b00 ; record 871
	dw $e2fe ; record 872
	dw $eda0 ; record 873
	dw $ffff ; record 874
	dw $ffff ; record 875
	dw $4e42 ; record 876
	dw $7ee9 ; record 877
	dw $e06c ; record 878
	dw $e166 ; record 879
	dw $e3fc ; record 880
	dw $eb64 ; record 881
	dw $2533 ; record 882
	dw $2ae0 ; record 883
	dw $e176 ; record 884
	dw $fe7b ; record 885
	dw $3be0 ; record 886
	dw $e0fe ; record 887
	dw $f01b ; record 888
	dw $64e4 ; record 889
	dw $35e5 ; record 890
	dw $0519 ; record 891
	dw $f8e8 ; record 892
	dw $e2fe ; record 893
	dw $0000 ; record 894
	dw $0000 ; record 895
	dw $e700 ; record 896
	dw $ffff ; record 897
	dw $ff00 ; record 898
	dw $f0ea ; record 899
	dw $07e1 ; record 900
	dw $0f00 ; record 901
	dw $fe2a ; record 902
	dw $0ce0 ; record 903
	dw $e0fe ; record 904
	dw $f00f ; record 905
	dw $efe2 ; record 906
	dw $e2fe ; record 907
	dw $e1f0 ; record 908
	dw $cfdd ; record 909
	dw $e2e0 ; record 910
	dw $00ec ; record 911
	dw $ecee ; record 912
	dw $0fe0 ; record 913
	dw $7700 ; record 914
	dw $000d ; record 915
	dw $d0cc ; record 916
	dw $66e2 ; record 917
	dw $e600 ; record 918
	dw $e2fe ; record 919
	dw $66a9 ; record 920
	dw $e0f6 ; record 921
	dw $e1b0 ; record 922
	dw $fe7f ; record 923
	dw $60e2 ; record 924
	dw $e0fe ; record 925
	dw $727e ; record 926
	dw $e2b0 ; record 927
	dw $fe33 ; record 928
	dw $90e8 ; record 929
	dw $19e1 ; record 930
	dw $9b00 ; record 931
	dw $e0fe ; record 932
	dw $dbd5 ; record 933
	dw $e0fe ; record 934
	dw $90fb ; record 935
	dw $f3e2 ; record 936
	dw $e0f8 ; record 937
	dw $00fb ; record 938
	dw $1b11 ; record 939
	dw $e2fe ; record 940
	dw $ed70 ; record 941
	dw $edf2 ; record 942
	dw $620f ; record 943
	dw $f8e0 ; record 944
	dw $5ce3 ; record 945
	dw $52e1 ; record 946
	dw $e364 ; record 947
	dw $fe6c ; record 948
	dw $5ce0 ; record 949
	dw $cfe1 ; record 950
	dw $e035 ; record 951
	dw $6ccc ; record 952
	dw $a2e0 ; record 953
	dw $e146 ; record 954
	dw $feec ; record 955
	dw $64e2 ; record 956
	dw $fee1 ; record 957
	dw $00e9 ; record 958
	dw $e06e ; record 959
	dw $487e ; record 960
	dw $e266 ; record 961
	dw $e3fc ; record 962
	dw $eb64 ; record 963
	dw $f533 ; record 964
	dw $76c0 ; record 965
	dw $7be1 ; record 966
	dw $e0fe ; record 967
	dw $3ba5 ; record 968
	dw $e0fe ; record 969
	dw $f01b ; record 970
	dw $64e4 ; record 971
	dw $19e5 ; record 972
	dw $c8d5 ; record 973
	dw $06f8 ; record 974
	dw $e2fe ; record 975
	dw $0000 ; record 976
	dw $0000 ; record 977
	dw $e700 ; record 978
	dw $ffff ; record 979
	dw $ff00 ; record 980
	dw $f0ea ; record 981
	dw $0ee1 ; record 982
	dw $3e00 ; record 983
	dw $fe72 ; record 984
	dw $0ee2 ; record 985
	dw $e0f6 ; record 986
	dw $e1e0 ; record 987
	dw $0007 ; record 988
	dw $fe0f ; record 989
	dw $55e0 ; record 990
	dw $fe0c ; record 991
	dw $0fe0 ; record 992
	dw $e2e0 ; record 993
	dw $feef ; record 994
	dw $03e2 ; record 995
	dw $e0fe ; record 996
	dw $c395 ; record 997
	dw $e2d0 ; record 998
	dw $fec1 ; record 999
	dw $01e2 ; record 1000
	dw $e2fe ; record 1001
	dw $e1b0 ; record 1002
	dw $ef8c ; record 1003
	dw $dd00 ; record 1004
	dw $fd00 ; record 1005
	dw $e0fe ; record 1006
	dw $00ad ; record 1007
	dw $4a8d ; record 1008
	dw $e2b0 ; record 1009
	dw $f2f9 ; record 1010
	dw $8ce2 ; record 1011
	dw $e2fe ; record 1012
	dw $e3f0 ; record 1013
	dw $fefb ; record 1014
	dw $51e0 ; record 1015
	dw $fe63 ; record 1016
	dw $80e2 ; record 1017
	dw $f2e1 ; record 1018
	dw $fbe1 ; record 1019
	dw $e2b0 ; record 1020
	dw $8003 ; record 1021
	dw $85e2 ; record 1022
	dw $fe18 ; record 1023
	dw $f8e6 ; record 1024
	dw $eb63 ; record 1025
	dw $e055 ; record 1026
	dw $e16c ; record 1027
	dw $e168 ; record 1028
	dw $aa3f ; record 1029
	dw $e2fe ; record 1030
	dw $6600 ; record 1031
	dw $07e0 ; record 1032
	dw $e23f ; record 1033
	dw $fe8f ; record 1034
	dw $00e2 ; record 1035
	dw $0023 ; record 1036
	dw $fee3 ; record 1037
	dw $a6e0 ; record 1038
	dw $f8e1 ; record 1039
	dw $c3e1 ; record 1040
	dw $e025 ; record 1041
	dw $e36a ; record 1042
	dw $64ca ; record 1043
	dw $19e1 ; record 1044
	dw $e0fe ; record 1045
	dw $6e00 ; record 1046
	dw $fee0 ; record 1047
	dw $00e9 ; record 1048
	dw $8900 ; record 1049
	dw $fefc ; record 1050
	dw $64e2 ; record 1051
	dw $8ce3 ; record 1052
	dw $c0f5 ; record 1053
	dw $e36a ; record 1054
	dw $e364 ; record 1055
	dw $5461 ; record 1056
	dw $c0e5 ; record 1057
	dw $e36a ; record 1058
	dw $5c03 ; record 1059
	dw $00e4 ; record 1060
	dw $e06e ; record 1061
	dw $60f8 ; record 1062
	dw $03e8 ; record 1063
	dw $0000 ; record 1064
	dw $0000 ; record 1065
	dw $e700 ; record 1066
	dw $ffff ; record 1067
	dw $ff00 ; record 1068
	dw $f0ea ; record 1069
	dw $3ee1 ; record 1070
	dw $7f00 ; record 1071
	dw $00af ; record 1072
	dw $00ff ; record 1073
	dw $fee3 ; record 1074
	dw $03e0 ; record 1075
	dw $e2f0 ; record 1076
	dw $bf18 ; record 1077
	dw $1c00 ; record 1078
	dw $9c00 ; record 1079
	dw $9e00 ; record 1080
	dw $e0fe ; record 1081
	dw $3a9f ; record 1082
	dw $e2e0 ; record 1083
	dw $fedf ; record 1084
	dw $d9e2 ; record 1085
	dw $d800 ; record 1086
	dw $e0fe ; record 1087
	dw $e1c0 ; record 1088
	dw $019f ; record 1089
	dw $8100 ; record 1090
	dw $c100 ; record 1091
	dw $e4fe ; record 1092
	dw $e1b0 ; record 1093
	dw $ef8c ; record 1094
	dw $dd00 ; record 1095
	dw $fd00 ; record 1096
	dw $e0fe ; record 1097
	dw $00ad ; record 1098
	dw $4a8d ; record 1099
	dw $e2b0 ; record 1100
	dw $f2f9 ; record 1101
	dw $8ce2 ; record 1102
	dw $e2fe ; record 1103
	dw $e3f0 ; record 1104
	dw $fefb ; record 1105
	dw $11e0 ; record 1106
	dw $fe63 ; record 1107
	dw $80e2 ; record 1108
	dw $f2e1 ; record 1109
	dw $fbe1 ; record 1110
	dw $e094 ; record 1111
	dw $e1fe ; record 1112
	dw $e390 ; record 1113
	dw $fef2 ; record 1114
	dw $f8e5 ; record 1115
	dw $eb63 ; record 1116
	dw $e055 ; record 1117
	dw $003f ; record 1118
	dw $007e ; record 1119
	dw $f0e7 ; record 1120
	dw $e000 ; record 1121
	dw $e060 ; record 1122
	dw $e1fe ; record 1123
	dw $0000 ; record 1124
	dw $2a1f ; record 1125
	dw $e0fe ; record 1126
	dw $fe1b ; record 1127
	dw $99e0 ; record 1128
	dw $e0fe ; record 1129
	dw $3598 ; record 1130
	dw $6ce0 ; record 1131
	dw $a9e1 ; record 1132
	dw $64d8 ; record 1133
	dw $5ce0 ; record 1134
	dw $00e3 ; record 1135
	dw $e668 ; record 1136
	dw $dec1 ; record 1137
	dw $19e0 ; record 1138
	dw $153a ; record 1139
	dw $8de0 ; record 1140
	dw $eafe ; record 1141
	dw $0000 ; record 1142
	dw $fefc ; record 1143
	dw $64e2 ; record 1144
	dw $91e3 ; record 1145
	dw $f58c ; record 1146
	dw $6ac0 ; record 1147
	dw $64e3 ; record 1148
	dw $61e3 ; record 1149
	dw $c0e5 ; record 1150
	dw $e36a ; record 1151
	dw $6a03 ; record 1152
	dw $e45c ; record 1153
	dw $6e00 ; record 1154
	dw $f8e0 ; record 1155
	dw $e860 ; record 1156
	dw $0000 ; record 1157
	dw $0000 ; record 1158
	dw $e700 ; record 1159
	dw $ffff ; record 1160
	dw $ff00 ; record 1161
	dw $f0ea ; record 1162
	dw $fce1 ; record 1163
	dw $fe00 ; record 1164
	dw $feaa ; record 1165
	dw $c6e0 ; record 1166
	; $57bb, 1066 bytes (records:2)
; 533 records x 2 bytes
	dw $e0fe ; record 0
	dw $f0fe ; record 1
	dw $7ce2 ; record 2
	dw $e6f0 ; record 3
	dw $2ec6 ; record 4
	dw $e2e0 ; record 5
	dw $00c6 ; record 6
	dw $fee6 ; record 7
	dw $f6e0 ; record 8
	dw $e0fe ; record 9
	dw $e3e0 ; record 10
	dw $e6ce ; record 11
	dw $cee3 ; record 12
	dw $de00 ; record 13
	dw $e0c6 ; record 14
	dw $e1b0 ; record 15
	dw $0066 ; record 16
	dw $67b9 ; record 17
	dw $e6fe ; record 18
	dw $e1a0 ; record 19
	dw $0033 ; record 20
	dw $fe37 ; record 21
	dw $b6e0 ; record 22
	dw $fe4a ; record 23
	dw $f6e0 ; record 24
	dw $e2a0 ; record 25
	dw $fef0 ; record 26
	dw $88e2 ; record 27
	dw $f0e1 ; record 28
	dw $e290 ; record 29
	dw $0e17 ; record 30
	dw $3e00 ; record 31
	dw $e2fe ; record 32
	dw $f60e ; record 33
	dw $70e0 ; record 34
	dw $f2ed ; record 35
	dw $88ed ; record 36
	dw $e164 ; record 37
	dw $e376 ; record 38
	dw $e160 ; record 39
	dw $5600 ; record 40
	dw $eee2 ; record 41
	dw $f0e7 ; record 42
	dw $dee3 ; record 43
	dw $7612 ; record 44
	dw $cee0 ; record 45
	dw $e070 ; record 46
	dw $e1e0 ; record 47
	dw $32f8 ; record 48
	dw $f2e0 ; record 49
	dw $d0e1 ; record 50
	dw $4ae5 ; record 51
	dw $e166 ; record 52
	dw $fe66 ; record 53
	dw $00e6 ; record 54
	dw $e23a ; record 55
	dw $e136 ; record 56
	dw $fe77 ; record 57
	dw $1de0 ; record 58
	dw $6e33 ; record 59
	dw $f0e2 ; record 60
	dw $3000 ; record 61
	dw $e0fe ; record 62
	dw $e55c ; record 63
	dw $e16c ; record 64
	dw $68d2 ; record 65
	dw $3fe1 ; record 66
	dw $e2fe ; record 67
	dw $c7d4 ; record 68
	dw $fe80 ; record 69
	dw $00e2 ; record 70
	dw $0000 ; record 71
	dw $0000 ; record 72
	dw $ffe7 ; record 73
	dw $00ff ; record 74
	dw $eaff ; record 75
	dw $e1f0 ; record 76
	dw $00fc ; record 77
	dw $aafe ; record 78
	dw $e0fe ; record 79
	dw $fec6 ; record 80
	dw $fee0 ; record 81
	dw $e2f0 ; record 82
	dw $f07c ; record 83
	dw $c6e6 ; record 84
	dw $e02e ; record 85
	dw $c6e2 ; record 86
	dw $e600 ; record 87
	dw $e0fe ; record 88
	dw $fef6 ; record 89
	dw $e0e0 ; record 90
	dw $cee3 ; record 91
	dw $e3e6 ; record 92
	dw $00ce ; record 93
	dw $c6de ; record 94
	dw $b0e0 ; record 95
	dw $66e1 ; record 96
	dw $b900 ; record 97
	dw $fe67 ; record 98
	dw $a0e6 ; record 99
	dw $33e1 ; record 100
	dw $3700 ; record 101
	dw $e0fe ; record 102
	dw $4ab6 ; record 103
	dw $e0fe ; record 104
	dw $a0f6 ; record 105
	dw $f0e2 ; record 106
	dw $e2fe ; record 107
	dw $e188 ; record 108
	dw $90f0 ; record 109
	dw $7fe2 ; record 110
	dw $001f ; record 111
	dw $003f ; record 112
	dw $007f ; record 113
	dw $fe71 ; record 114
	dw $7de0 ; record 115
	dw $8001 ; record 116
	dw $00e2 ; record 117
	dw $8000 ; record 118
	dw $c000 ; record 119
	dw $e4fe ; record 120
	dw $ff10 ; record 121
	dw $64ed ; record 122
	dw $76e1 ; record 123
	dw $60e3 ; record 124
	dw $00e1 ; record 125
	dw $e256 ; record 126
	dw $e7ee ; record 127
	dw $e3f0 ; record 128
	dw $de25 ; record 129
	dw $e076 ; record 130
	dw $70ce ; record 131
	dw $e0e0 ; record 132
	dw $f8e1 ; record 133
	dw $e032 ; record 134
	dw $e1f2 ; record 135
	dw $d094 ; record 136
	dw $66e5 ; record 137
	dw $66e1 ; record 138
	dw $e6fe ; record 139
	dw $3a00 ; record 140
	dw $36e2 ; record 141
	dw $77e1 ; record 142
	dw $fe3a ; record 143
	dw $33e0 ; record 144
	dw $e26e ; record 145
	dw $00f0 ; record 146
	dw $fe30 ; record 147
	dw $5ce0 ; record 148
	dw $0ee5 ; record 149
	dw $e164 ; record 150
	dw $0078 ; record 151
	dw $6070 ; record 152
	dw $fee0 ; record 153
	dw $66e1 ; record 154
	dw $d0e1 ; record 155
	dw $00c3 ; record 156
	dw $e562 ; record 157
	dw $0000 ; record 158
	dw $e700 ; record 159
	dw $ffff ; record 160
	dw $ff00 ; record 161
	dw $f0ea ; record 162
	dw $fce1 ; record 163
	dw $fe00 ; record 164
	dw $feaa ; record 165
	dw $c6e0 ; record 166
	dw $e0fe ; record 167
	dw $f0fe ; record 168
	dw $7ce2 ; record 169
	dw $e6f0 ; record 170
	dw $2ec6 ; record 171
	dw $e2e0 ; record 172
	dw $00c6 ; record 173
	dw $fee6 ; record 174
	dw $f6e0 ; record 175
	dw $e0fe ; record 176
	dw $e3e0 ; record 177
	dw $e6ce ; record 178
	dw $cee3 ; record 179
	dw $de00 ; record 180
	dw $e0c6 ; record 181
	dw $e1b0 ; record 182
	dw $0066 ; record 183
	dw $67b9 ; record 184
	dw $e6fe ; record 185
	dw $e1a0 ; record 186
	dw $0033 ; record 187
	dw $fe37 ; record 188
	dw $b6e0 ; record 189
	dw $fe4a ; record 190
	dw $f6e0 ; record 191
	dw $e2a0 ; record 192
	dw $fef0 ; record 193
	dw $88e2 ; record 194
	dw $f0e1 ; record 195
	dw $e290 ; record 196
	dw $1f7f ; record 197
	dw $3f00 ; record 198
	dw $7f00 ; record 199
	dw $7100 ; record 200
	dw $e0fe ; record 201
	dw $0f7d ; record 202
	dw $e280 ; record 203
	dw $0000 ; record 204
	dw $0080 ; record 205
	dw $fec0 ; record 206
	dw $10e4 ; record 207
	dw $edff ; record 208
	dw $e164 ; record 209
	dw $e376 ; record 210
	dw $e160 ; record 211
	dw $5600 ; record 212
	dw $eee2 ; record 213
	dw $f0e7 ; record 214
	dw $25e3 ; record 215
	dw $76de ; record 216
	dw $cee0 ; record 217
	dw $e070 ; record 218
	dw $e1e0 ; record 219
	dw $32f8 ; record 220
	dw $f2e0 ; record 221
	dw $94e1 ; record 222
	dw $e5d0 ; record 223
	dw $e166 ; record 224
	dw $fe66 ; record 225
	dw $00e6 ; record 226
	dw $e23a ; record 227
	dw $e136 ; record 228
	dw $3a77 ; record 229
	dw $e0fe ; record 230
	dw $6e33 ; record 231
	dw $f0e2 ; record 232
	dw $3000 ; record 233
	dw $e0fe ; record 234
	dw $e55c ; record 235
	dw $0fa9 ; record 236
	dw $e06c ; record 237
	dw $e166 ; record 238
	dw $5c7f ; record 239
	dw $1fe0 ; record 240
	dw $ea66 ; record 241
	dw $0080 ; record 242
	dw $e264 ; record 243
	dw $0000 ; record 244
	dw $e700 ; record 245
	dw $ffff ; record 246
	dw $ff00 ; record 247
	dw $f0ea ; record 248
	dw $fce1 ; record 249
	dw $fe00 ; record 250
	dw $feaa ; record 251
	dw $c6e0 ; record 252
	dw $e0fe ; record 253
	dw $f0fe ; record 254
	dw $7ce2 ; record 255
	dw $e6f0 ; record 256
	dw $2ec6 ; record 257
	dw $e2e0 ; record 258
	dw $00c6 ; record 259
	dw $fee6 ; record 260
	dw $f6e0 ; record 261
	dw $e0fe ; record 262
	dw $e3e0 ; record 263
	dw $e6ce ; record 264
	dw $cee3 ; record 265
	dw $de00 ; record 266
	dw $e0c6 ; record 267
	dw $e1b0 ; record 268
	dw $0066 ; record 269
	dw $67b9 ; record 270
	dw $e6fe ; record 271
	dw $e1a0 ; record 272
	dw $0033 ; record 273
	dw $fe37 ; record 274
	dw $b6e0 ; record 275
	dw $fe4a ; record 276
	dw $f6e0 ; record 277
	dw $e2a0 ; record 278
	dw $fef0 ; record 279
	dw $88e2 ; record 280
	dw $f0e1 ; record 281
	dw $e290 ; record 282
	dw $01ff ; record 283
	dw $0300 ; record 284
	dw $0700 ; record 285
	dw $0f00 ; record 286
	dw $1700 ; record 287
	dw $001f ; record 288
	dw $803b ; record 289
	dw $80e2 ; record 290
	dw $e8fe ; record 291
	dw $edff ; record 292
	dw $e164 ; record 293
	dw $7644 ; record 294
	dw $60e3 ; record 295
	dw $00e1 ; record 296
	dw $e256 ; record 297
	dw $e7ee ; record 298
	dw $e3f0 ; record 299
	dw $76de ; record 300
	dw $09e0 ; record 301
	dw $70ce ; record 302
	dw $e0e0 ; record 303
	dw $f8e1 ; record 304
	dw $e032 ; record 305
	dw $e1f2 ; record 306
	dw $e5d0 ; record 307
	dw $e166 ; record 308
	dw $66a5 ; record 309
	dw $e6fe ; record 310
	dw $3a00 ; record 311
	dw $36e2 ; record 312
	dw $77e1 ; record 313
	dw $e0fe ; record 314
	dw $ce33 ; record 315
	dw $e26e ; record 316
	dw $00f0 ; record 317
	dw $fe30 ; record 318
	dw $5ce0 ; record 319
	dw $73e5 ; record 320
	dw $2500 ; record 321
	dw $fe7f ; record 322
	dw $03e2 ; record 323
	dw $e2fe ; record 324
	dw $e164 ; record 325
	dw $fec0 ; record 326
	dw $62e2 ; record 327
	dw $00e5 ; record 328
	dw $0000 ; record 329
	dw $ff7f ; record 330
	dw $00ff ; record 331
	dw $f300 ; record 332
	dw $fb00 ; record 333
	dw $e0fe ; record 334
	dw $dbed ; record 335
	dw $e0fe ; record 336
	dw $00fb ; record 337
	dw $e1f0 ; record 338
	dw $00c7 ; record 339
	dw $eaef ; record 340
	dw $e0fe ; record 341
	dw $fe6d ; record 342
	dw $ede0 ; record 343
	dw $e2f0 ; record 344
	dw $001e ; record 345
	dw $e2be ; record 346
	dw $e0fe ; record 347
	dw $feb0 ; record 348
	dw $d0e2 ; record 349
	dw $d2e1 ; record 350
	dw $fbe1 ; record 351
	dw $6300 ; record 352
	dw $fe5c ; record 353
	dw $c0e2 ; record 354
	dw $3de1 ; record 355
	dw $7d00 ; record 356
	dw $e0fe ; record 357
	dw $fe61 ; record 358
	dw $aae2 ; record 359
	dw $e1b0 ; record 360
	dw $fef0 ; record 361
	dw $80e2 ; record 362
	dw $e0fe ; record 363
	dw $b0e0 ; record 364
	dw $84e2 ; record 365
	dw $00af ; record 366
	dw $00cd ; record 367
	dw $fefd ; record 368
	dw $cde2 ; record 369
	dw $e2a0 ; record 370
	dw $4be7 ; record 371
	dw $f700 ; record 372
	dw $e0fe ; record 373
	dw $feb3 ; record 374
	dw $80e2 ; record 375
	dw $9ee1 ; record 376
	dw $e2a0 ; record 377
	dw $30a9 ; record 378
	dw $e2fe ; record 379
	dw $e170 ; record 380
	dw $fecc ; record 381
	dw $fce6 ; record 382
	dw $e066 ; record 383
	dw $bbf3 ; record 384
	dw $c300 ; record 385
	dw $e6fe ; record 386
	dw $0000 ; record 387
	dw $64cf ; record 388
	dw $6fe0 ; record 389
	dw $6454 ; record 390
	dw $60e2 ; record 391
	dw $00e1 ; record 392
	dw $e46a ; record 393
	dw $5eb0 ; record 394
	dw $9ee2 ; record 395
	dw $e0e0 ; record 396
	dw $6a54 ; record 397
	dw $fae3 ; record 398
	dw $00e5 ; record 399
	dw $e46a ; record 400
	dw $5e61 ; record 401
	dw $3de2 ; record 402
	dw $e0c0 ; record 403
	dw $e011 ; record 404
	dw $e06c ; record 405
	dw $e166 ; record 406
	dw $e35c ; record 407
	dw $6600 ; record 408
	dw $fee0 ; record 409
	dw $f4e9 ; record 410
	dw $e4c1 ; record 411
	dw $e1fe ; record 412
	dw $e364 ; record 413
	dw $90b3 ; record 414
	dw $6ae0 ; record 415
	dw $30e3 ; record 416
	dw $3e00 ; record 417
	dw $feca ; record 418
	dw $1ee0 ; record 419
	dw $e080 ; record 420
	dw $6cfc ; record 421
	dw $60e0 ; record 422
	dw $00e7 ; record 423
	dw $0000 ; record 424
	dw $0000 ; record 425
	dw $ffbf ; record 426
	dw $8ff1 ; record 427
	dw $bafa ; record 428
	dw $fecf ; record 429
	dw $fbe3 ; record 430
	dw $f5ff ; record 431
	dw $7887 ; record 432
	dw $c8ff ; record 433
	dw $ec3b ; record 434
	dw $fdeb ; record 435
	dw $fe3c ; record 436
	dw $efe3 ; record 437
	dw $1cd7 ; record 438
	dw $ffe3 ; record 439
	dw $bfb9 ; record 440
	dw $fda7 ; record 441
	dw $f7ad ; record 442
	dw $fbbd ; record 443
	dw $e2fa ; record 444
	dw $ff7b ; record 445
	dw $9c63 ; record 446
	dw $1eff ; record 447
	dw $9f70 ; record 448
	dw $9877 ; record 449
	dw $7fff ; record 450
	dw $719c ; record 451
	dw $779e ; record 452
	dw $ff98 ; record 453
	dw $ffde ; record 454
	dw $ef10 ; record 455
	dw $3cff ; record 456
	dw $3fe1 ; record 457
	dw $31ef ; record 458
	dw $ffbf ; record 459
	dw $e33a ; record 460
	dw $ee3f ; record 461
	dw $fe33 ; record 462
	dw $11e0 ; record 463
	dw $ffff ; record 464
	dw $fb88 ; record 465
	dw $5b4c ; record 466
	dw $6bec ; record 467
	dw $ffbc ; record 468
	dw $fceb ; record 469
	dw $fc2b ; record 470
	dw $37ef ; record 471
	dw $13ec ; record 472
	dw $ffbf ; record 473
	dw $ada7 ; record 474
	dw $aff3 ; record 475
	dw $fef1 ; record 476
	dw $bfe3 ; record 477
	dw $7dff ; record 478
	dw $9e61 ; record 479
	dw $dcff ; record 480
	dw $fe23 ; record 481
	dw $ff6e ; record 482
	dw $7fb1 ; record 483
	dw $739c ; record 484
	dw $7e8e ; record 485
	dw $7ea3 ; record 486
	dw $9def ; record 487
	dw $8e71 ; record 488
	dw $ff00 ; record 489
	dw $ffec ; record 490
	dw $3fff ; record 491
	dw $ff7f ; record 492
	dw $3fcf ; record 493
	dw $fe3d ; record 494
	dw $3cce ; record 495
	dw $e0fc ; record 496
	dw $3fff ; record 497
	dw $ff3f ; record 498
	dw $c7ff ; record 499
	dw $e71c ; record 500
	dw $fffd ; record 501
	dw $ff06 ; record 502
	dw $3c87 ; record 503
	dw $fdc7 ; record 504
	dw $fd06 ; record 505
	dw $c6ff ; record 506
	dw $e21d ; record 507
	dw $91ff ; record 508
	dw $e93f ; record 509
	dw $ffeb ; record 510
	dw $ed3d ; record 511
	dw $7d57 ; record 512
	dw $c5ff ; record 513
	dw $dd7f ; record 514
	dw $667f ; record 515
	dw $22dd ; record 516
	dw $14ff ; record 517
	dw $9e75 ; record 518
	dw $e5fe ; record 519
	dw $f7ff ; record 520
	dw $8cef ; record 521
	dw $ff73 ; record 522
	dw $d17c ; record 523
	dw $7b3e ; record 524
	dw $18f7 ; record 525
	dw $e4fe ; record 526
	dw $3798 ; record 527
	dw $ffc8 ; record 528
	dw $e0ff ; record 529
	dw $a010 ; record 530
	dw $f0eb ; record 531
	dw $6cff ; record 532
	; $5be5, 44 bytes (records:2)
; 22 records x 2 bytes
	dw $5ced ; record 0
	dw $cfe9 ; record 1
	dw $e16c ; record 2
	dw $e25c ; record 3
	dw $e1f8 ; record 4
	dw $ff03 ; record 5
	dw $00ff ; record 6
	dw $0000 ; record 7
	dw $ff07 ; record 8
	dw $00ff ; record 9
	dw $eaff ; record 10
	dw $fff0 ; record 11
	dw $fff0 ; record 12
	dw $fff0 ; record 13
	dw $fff0 ; record 14
	dw $ff00 ; record 15
	dw $ffff ; record 16
	dw $ffff ; record 17
	dw $ffff ; record 18
	dw $ffff ; record 19
	dw $00fd ; record 20
	dw $0000 ; record 21
Func_16_5c11:
	ld a, [wGameMode] ; $5c11
	cp a, $09 ; $5c14
	ret nz ; $5c16
	ld a, [$c8b9] ; $5c17
	cp a, $01 ; $5c1a
	jr nz, Label_16_5c1f ; $5c1c
	ret ; $5c1e
Label_16_5c1f:
	cp a, $02 ; $5c1f
	jr nz, Label_16_5c34 ; $5c21
	ld a, [wMatchWinLoseFlag] ; $5c23
	cp a, $ff ; $5c26
	jr z, Label_16_5c2e ; $5c28
	ld a, $ff ; $5c2a
	jr Label_16_5c30 ; $5c2c
Label_16_5c2e:
	ld a, $01 ; $5c2e
Label_16_5c30:
	ld [wMatchWinLoseFlag], a ; $5c30
	ret ; $5c33
Label_16_5c34:
	ret ; $5c34
RunMatchStatsScreen:
	call DisableLCDSafely ; $5c35
	farcall FarPtr_01_0a ; $5c38
	wram_bank $03 ; $5c3b
	ld a, $01 ; $5c41
	ld [$d801], a ; $5c43
	call InitMatchStatsScreen ; $5c46
	call LoadMatchResultPalettes ; $5c49
	ld a, $01 ; $5c4c
	ld hl, $43f6 ; $5c4e
	call RegisterFrameTask ; $5c51
	call EnableLCD ; $5c54
	ld c, $10 ; $5c57
	call Func_00_1d2e ; $5c59
	call Func_00_1da4 ; $5c5c
Label_16_5c5f:
	call PrintMatchSetScores ; $5c5f
	ldh a, [hInputPressed] ; $5c62
	bit 5, a ; $5c64
	jr nz, Label_16_5c75 ; $5c66
	bit 0, a ; $5c68
	jr nz, Label_16_5c7f ; $5c6a
	bit 1, a ; $5c6c
	jr nz, Label_16_5c7f ; $5c6e
	call AdvanceFrame ; $5c70
	jr Label_16_5c5f ; $5c73
Label_16_5c75:
	ld c, $40 ; $5c75
	call Func_00_1d20 ; $5c77
	call Func_00_1da4 ; $5c7a
	xor a, a ; $5c7d
	ret ; $5c7e
Label_16_5c7f:
	ld c, $20 ; $5c7f
	call Func_00_1d20 ; $5c81
	call Func_00_1da4 ; $5c84
	ld a, $ff ; $5c87
	ret ; $5c89
InitMatchStatsScreen:
	ld c, $23 ; $5c8a
	farcall FarPtr_LoadScreenAssetRecord ; $5c8c
	ld de, $a000 ; $5c8f
	ld c, $00 ; $5c92
	ld b, $08 ; $5c94
	farcall FarPtr_39_64 ; $5c96
	ld a, $00 ; $5c99
	ld d, $04 ; $5c9b
	farcall FarPtr_18_02 ; $5c9d
	ld a, $00 ; $5ca0
	ld d, $05 ; $5ca2
	farcall FarPtr_18_02 ; $5ca4
	ld a, $00 ; $5ca7
	ld d, $06 ; $5ca9
	farcall FarPtr_18_02 ; $5cab
	ld a, $00 ; $5cae
	ld d, $07 ; $5cb0
	farcall FarPtr_18_02 ; $5cb2
	wram_bank $03 ; $5cb5
	call Func_16_5f92 ; $5cbb
	call Func_16_4dfe ; $5cbe
	ld de, $d600 ; $5cc1
	ld b, $14 ; $5cc4
	ld c, $02 ; $5cc6
	ld h, $08 ; $5cc8
	farcall FarPtr_39_0c ; $5cca
	call Func_16_5cdc ; $5ccd
	ld c, $01 ; $5cd0
	call Func_16_5fe7 ; $5cd2
	call PrintMatchStatistics ; $5cd5
	farcall FarPtr_Func_39_4325 ; $5cd8
	ret ; $5cdb
Func_16_5cdc:
	ld de, $002f ; $5cdc
	call Func_00_24ef ; $5cdf
	jr z, Label_16_5d16 ; $5ce2
	ld de, $d481 ; $5ce4
	ld b, $03 ; $5ce7
	ld c, $03 ; $5ce9
	ld h, $0c ; $5ceb
	farcall FarPtr_39_0c ; $5ced
	ld de, $d484 ; $5cf0
	ld b, $03 ; $5cf3
	ld c, $03 ; $5cf5
	ld h, $0d ; $5cf7
	farcall FarPtr_39_0c ; $5cf9
	ld de, $d48d ; $5cfc
	ld b, $03 ; $5cff
	ld c, $03 ; $5d01
	ld h, $0e ; $5d03
	farcall FarPtr_39_0c ; $5d05
	ld de, $d490 ; $5d08
	ld b, $03 ; $5d0b
	ld c, $03 ; $5d0d
	ld h, $0f ; $5d0f
	farcall FarPtr_39_0c ; $5d11
	jr Label_16_5d2e ; $5d14
Label_16_5d16:
	ld de, $d482 ; $5d16
	ld b, $03 ; $5d19
	ld c, $03 ; $5d1b
	ld h, $0c ; $5d1d
	farcall FarPtr_39_0c ; $5d1f
	ld de, $d48e ; $5d22
	ld b, $03 ; $5d25
	ld c, $03 ; $5d27
	ld h, $0e ; $5d29
	farcall FarPtr_39_0c ; $5d2b
Label_16_5d2e:
	ret ; $5d2e
PrintMatchStatistics:
	call Func_16_5f61 ; $5d2f
	ld de, $002f ; $5d32
	call Func_00_24ef ; $5d35
	jr z, Label_16_5d3f ; $5d38
	call PrintDoublesMatchStats ; $5d3a
	jr Label_16_5d42 ; $5d3d
Label_16_5d3f:
	call PrintSinglesMatchStats ; $5d3f
Label_16_5d42:
	ret ; $5d42
PrintSinglesMatchStats:
	ld a, [wCharacter1ServiceAces] ; $5d43
	ld h, $00 ; $5d46
	ld l, a ; $5d48
	ld bc, $d810 ; $5d49
	ld de, $d163 ; $5d4c
	farcall FarPtr_PrintNumberRightAligned ; $5d4f
	ld a, [wCharacter1SmashAces] ; $5d52
	ld h, $00 ; $5d55
	ld l, a ; $5d57
	ld bc, $d810 ; $5d58
	ld de, $d183 ; $5d5b
	farcall FarPtr_PrintNumberRightAligned ; $5d5e
	ld a, [wCharacter1ReturnAces] ; $5d61
	ld h, $00 ; $5d64
	ld l, a ; $5d66
	ld bc, $d810 ; $5d67
	ld de, $d1a3 ; $5d6a
	farcall FarPtr_PrintNumberRightAligned ; $5d6d
	ld a, [wCharacter1LobShotWinners] ; $5d70
	ld h, $00 ; $5d73
	ld l, a ; $5d75
	ld bc, $d810 ; $5d76
	ld de, $d1c3 ; $5d79
	farcall FarPtr_PrintNumberRightAligned ; $5d7c
	ld a, [wCharacter1DropShotWinners] ; $5d7f
	ld h, $00 ; $5d82
	ld l, a ; $5d84
	ld bc, $d810 ; $5d85
	ld de, $d1e3 ; $5d88
	farcall FarPtr_PrintNumberRightAligned ; $5d8b
	ld a, [wCharacter1DoubleFaults] ; $5d8e
	ld h, $00 ; $5d91
	ld l, a ; $5d93
	ld bc, $d810 ; $5d94
	ld de, $d203 ; $5d97
	farcall FarPtr_PrintNumberRightAligned ; $5d9a
	ld a, [wCharacter2ServiceAces] ; $5d9d
	ld h, $00 ; $5da0
	ld l, a ; $5da2
	ld bc, $d810 ; $5da3
	ld de, $d170 ; $5da6
	farcall FarPtr_PrintNumberRightAligned ; $5da9
	ld a, [wCharacter2SmashAces] ; $5dac
	ld h, $00 ; $5daf
	ld l, a ; $5db1
	ld bc, $d810 ; $5db2
	ld de, $d190 ; $5db5
	farcall FarPtr_PrintNumberRightAligned ; $5db8
	ld a, [wCharacter2ReturnAces] ; $5dbb
	ld h, $00 ; $5dbe
	ld l, a ; $5dc0
	ld bc, $d810 ; $5dc1
	ld de, $d1b0 ; $5dc4
	farcall FarPtr_PrintNumberRightAligned ; $5dc7
	ld a, [wCharacter2LobShotWinners] ; $5dca
	ld h, $00 ; $5dcd
	ld l, a ; $5dcf
	ld bc, $d810 ; $5dd0
	ld de, $d1d0 ; $5dd3
	farcall FarPtr_PrintNumberRightAligned ; $5dd6
	ld a, [wCharacter2DropShotWinners] ; $5dd9
	ld h, $00 ; $5ddc
	ld l, a ; $5dde
	ld bc, $d810 ; $5ddf
	ld de, $d1f0 ; $5de2
	farcall FarPtr_PrintNumberRightAligned ; $5de5
	ld a, [wCharacter2DoubleFaults] ; $5de8
	ld h, $00 ; $5deb
	ld l, a ; $5ded
	ld bc, $d810 ; $5dee
	ld de, $d210 ; $5df1
	farcall FarPtr_PrintNumberRightAligned ; $5df4
	ret ; $5df7
PrintDoublesMatchStats:
	ld a, [wCharacter1ServiceAces] ; $5df8
	ld h, $00 ; $5dfb
	ld l, a ; $5dfd
	ld bc, $d810 ; $5dfe
	ld de, $d162 ; $5e01
	farcall FarPtr_PrintNumberRightAligned ; $5e04
	ld a, [wCharacter1SmashAces] ; $5e07
	ld h, $00 ; $5e0a
	ld l, a ; $5e0c
	ld bc, $d810 ; $5e0d
	ld de, $d182 ; $5e10
	farcall FarPtr_PrintNumberRightAligned ; $5e13
	ld a, [wCharacter1ReturnAces] ; $5e16
	ld h, $00 ; $5e19
	ld l, a ; $5e1b
	ld bc, $d810 ; $5e1c
	ld de, $d1a2 ; $5e1f
	farcall FarPtr_PrintNumberRightAligned ; $5e22
	ld a, [wCharacter1LobShotWinners] ; $5e25
	ld h, $00 ; $5e28
	ld l, a ; $5e2a
	ld bc, $d810 ; $5e2b
	ld de, $d1c2 ; $5e2e
	farcall FarPtr_PrintNumberRightAligned ; $5e31
	ld a, [wCharacter1DropShotWinners] ; $5e34
	ld h, $00 ; $5e37
	ld l, a ; $5e39
	ld bc, $d810 ; $5e3a
	ld de, $d1e2 ; $5e3d
	farcall FarPtr_PrintNumberRightAligned ; $5e40
	ld a, [wCharacter1DoubleFaults] ; $5e43
	ld h, $00 ; $5e46
	ld l, a ; $5e48
	ld bc, $d810 ; $5e49
	ld de, $d202 ; $5e4c
	farcall FarPtr_PrintNumberRightAligned ; $5e4f
	ld a, [wCharacter3ServiceAces] ; $5e52
	ld h, $00 ; $5e55
	ld l, a ; $5e57
	ld bc, $d810 ; $5e58
	ld de, $d165 ; $5e5b
	farcall FarPtr_PrintNumberRightAligned ; $5e5e
	ld a, [wCharacter3SmashAces] ; $5e61
	ld h, $00 ; $5e64
	ld l, a ; $5e66
	ld bc, $d810 ; $5e67
	ld de, $d185 ; $5e6a
	farcall FarPtr_PrintNumberRightAligned ; $5e6d
	ld a, [wCharacter3ReturnAces] ; $5e70
	ld h, $00 ; $5e73
	ld l, a ; $5e75
	ld bc, $d810 ; $5e76
	ld de, $d1a5 ; $5e79
	farcall FarPtr_PrintNumberRightAligned ; $5e7c
	ld a, [wCharacter3LobShotWinners] ; $5e7f
	ld h, $00 ; $5e82
	ld l, a ; $5e84
	ld bc, $d810 ; $5e85
	ld de, $d1c5 ; $5e88
	farcall FarPtr_PrintNumberRightAligned ; $5e8b
	ld a, [wCharacter3DropShotWinners] ; $5e8e
	ld h, $00 ; $5e91
	ld l, a ; $5e93
	ld bc, $d810 ; $5e94
	ld de, $d1e5 ; $5e97
	farcall FarPtr_PrintNumberRightAligned ; $5e9a
	ld a, [wCharacter3DoubleFaults] ; $5e9d
	ld h, $00 ; $5ea0
	ld l, a ; $5ea2
	ld bc, $d810 ; $5ea3
	ld de, $d205 ; $5ea6
	farcall FarPtr_PrintNumberRightAligned ; $5ea9
	ld a, [wCharacter2ServiceAces] ; $5eac
	ld h, $00 ; $5eaf
	ld l, a ; $5eb1
	ld bc, $d810 ; $5eb2
	ld de, $d16f ; $5eb5
	farcall FarPtr_PrintNumberRightAligned ; $5eb8
	ld a, [wCharacter2SmashAces] ; $5ebb
	ld h, $00 ; $5ebe
	ld l, a ; $5ec0
	ld bc, $d810 ; $5ec1
	ld de, $d18f ; $5ec4
	farcall FarPtr_PrintNumberRightAligned ; $5ec7
	ld a, [wCharacter2ReturnAces] ; $5eca
	ld h, $00 ; $5ecd
	ld l, a ; $5ecf
	ld bc, $d810 ; $5ed0
	ld de, $d1af ; $5ed3
	farcall FarPtr_PrintNumberRightAligned ; $5ed6
	ld a, [wCharacter2LobShotWinners] ; $5ed9
	ld h, $00 ; $5edc
	ld l, a ; $5ede
	ld bc, $d810 ; $5edf
	ld de, $d1cf ; $5ee2
	farcall FarPtr_PrintNumberRightAligned ; $5ee5
	ld a, [wCharacter2DropShotWinners] ; $5ee8
	ld h, $00 ; $5eeb
	ld l, a ; $5eed
	ld bc, $d810 ; $5eee
	ld de, $d1ef ; $5ef1
	farcall FarPtr_PrintNumberRightAligned ; $5ef4
	ld a, [wCharacter2DoubleFaults] ; $5ef7
	ld h, $00 ; $5efa
	ld l, a ; $5efc
	ld bc, $d810 ; $5efd
	ld de, $d20f ; $5f00
	farcall FarPtr_PrintNumberRightAligned ; $5f03
	ld a, [wCharacter4ServiceAces] ; $5f06
	ld h, $00 ; $5f09
	ld l, a ; $5f0b
	ld bc, $d810 ; $5f0c
	ld de, $d172 ; $5f0f
	farcall FarPtr_PrintNumberRightAligned ; $5f12
	ld a, [wCharacter4SmashAces] ; $5f15
	ld h, $00 ; $5f18
	ld l, a ; $5f1a
	ld bc, $d810 ; $5f1b
	ld de, $d192 ; $5f1e
	farcall FarPtr_PrintNumberRightAligned ; $5f21
	ld a, [wCharacter4ReturnAces] ; $5f24
	ld h, $00 ; $5f27
	ld l, a ; $5f29
	ld bc, $d810 ; $5f2a
	ld de, $d1b2 ; $5f2d
	farcall FarPtr_PrintNumberRightAligned ; $5f30
	ld a, [wPlayer4LobShotWinners] ; $5f33
	ld h, $00 ; $5f36
	ld l, a ; $5f38
	ld bc, $d810 ; $5f39
	ld de, $d1d2 ; $5f3c
	farcall FarPtr_PrintNumberRightAligned ; $5f3f
	ld a, [wCharacter4DropShotWinners] ; $5f42
	ld h, $00 ; $5f45
	ld l, a ; $5f47
	ld bc, $d810 ; $5f48
	ld de, $d1f2 ; $5f4b
	farcall FarPtr_PrintNumberRightAligned ; $5f4e
	ld a, [wCharacter4DoubleFaults] ; $5f51
	ld h, $00 ; $5f54
	ld l, a ; $5f56
	ld bc, $d810 ; $5f57
	ld de, $d212 ; $5f5a
	farcall FarPtr_PrintNumberRightAligned ; $5f5d
	ret ; $5f60
Func_16_5f61:
	ld de, $d561 ; $5f61
	ld b, $05 ; $5f64
	ld c, $06 ; $5f66
	ld h, $00 ; $5f68
	farcall FarPtr_39_0c ; $5f6a
	ld de, $d56e ; $5f6d
	ld b, $05 ; $5f70
	ld c, $06 ; $5f72
	ld h, $00 ; $5f74
	farcall FarPtr_39_0c ; $5f76
	ld de, $d161 ; $5f79
	ld b, $05 ; $5f7c
	ld c, $06 ; $5f7e
	ld h, $20 ; $5f80
	farcall FarPtr_39_0c ; $5f82
	ld de, $d16e ; $5f85
	ld b, $05 ; $5f88
	ld c, $06 ; $5f8a
	ld h, $20 ; $5f8c
	farcall FarPtr_39_0c ; $5f8e
	ret ; $5f91
Func_16_5f92:
	ld de, $002f ; $5f92
	call Func_00_24ef ; $5f95
	ret nz ; $5f98
	ld hl, $d240 ; $5f99
	ld de, $d080 ; $5f9c
	ld b, $08 ; $5f9f
	ld c, $04 ; $5fa1
	farcall FarPtr_39_0a ; $5fa3
	ld hl, $d24c ; $5fa6
	ld de, $d08c ; $5fa9
	ld b, $08 ; $5fac
	ld c, $04 ; $5fae
	farcall FarPtr_39_0a ; $5fb0
	ld hl, $d640 ; $5fb3
	ld de, $d480 ; $5fb6
	ld b, $08 ; $5fb9
	ld c, $04 ; $5fbb
	farcall FarPtr_39_0a ; $5fbd
	ld hl, $d64c ; $5fc0
	ld de, $d48c ; $5fc3
	ld b, $08 ; $5fc6
	ld c, $04 ; $5fc8
	farcall FarPtr_39_0a ; $5fca
	ret ; $5fcd
PrintMatchSetScores:
	ld a, [wPlayer1SetsWon] ; $5fce
	ld h, $00 ; $5fd1
	ld l, a ; $5fd3
	ld de, $1c48 ; $5fd4
	farcall FarPtr_39_66 ; $5fd7
	ld a, [wPlayer2SetsWon] ; $5fda
	ld h, $00 ; $5fdd
	ld l, a ; $5fdf
	ld de, $8448 ; $5fe0
	farcall FarPtr_39_66 ; $5fe3
	ret ; $5fe6
Func_16_5fe7:
	ld a, c ; $5fe7
	or a, a ; $5fe8
	jr nz, Label_16_5ff9 ; $5fe9
	ld a, [wGameMode] ; $5feb
	cp a, $09 ; $5fee
	jr nz, Label_16_5ff9 ; $5ff0
	ld a, [$c8b9] ; $5ff2
	cp a, $02 ; $5ff5
	jr z, Label_16_6036 ; $5ff7
Label_16_5ff9:
	ld a, [wPlayer1CurrentMainCharacter] ; $5ff9
	ld d, a ; $5ffc
	ld a, [$ca0c] ; $5ffd
	ld b, a ; $6000
	ld c, $00 ; $6001
	call Func_16_6073 ; $6003
	ld a, [wPlayer2CurrentMainCharacter] ; $6006
	ld d, a ; $6009
	ld a, [$ca8c] ; $600a
	ld b, a ; $600d
	ld c, $02 ; $600e
	call Func_16_6073 ; $6010
	ld de, $002f ; $6013
	call Func_00_24ef ; $6016
	jr z, Label_16_6035 ; $6019
	ld a, [wPlayer1CurrentPartnerCharacter] ; $601b
	ld d, a ; $601e
	ld a, [$ca4c] ; $601f
	ld b, a ; $6022
	ld c, $01 ; $6023
	call Func_16_6073 ; $6025
	ld a, [wPlayer2CurrentPartnerCharacter] ; $6028
	ld d, a ; $602b
	ld a, [$cacc] ; $602c
	ld b, a ; $602f
	ld c, $03 ; $6030
	call Func_16_6073 ; $6032
Label_16_6035:
	ret ; $6035
Label_16_6036:
	ld a, [wPlayer1CurrentMainCharacter] ; $6036
	ld d, a ; $6039
	ld a, [$ca0c] ; $603a
	ld b, a ; $603d
	ld c, $02 ; $603e
	call Func_16_6073 ; $6040
	ld a, [wPlayer2CurrentMainCharacter] ; $6043
	ld d, a ; $6046
	ld a, [$ca8c] ; $6047
	ld b, a ; $604a
	ld c, $00 ; $604b
	call Func_16_6073 ; $604d
	ld de, $002f ; $6050
	call Func_00_24ef ; $6053
	jr z, Label_16_6072 ; $6056
	ld a, [wPlayer1CurrentPartnerCharacter] ; $6058
	ld d, a ; $605b
	ld a, [$ca4c] ; $605c
	ld b, a ; $605f
	ld c, $03 ; $6060
	call Func_16_6073 ; $6062
	ld a, [wPlayer2CurrentPartnerCharacter] ; $6065
	ld d, a ; $6068
	ld a, [$cacc] ; $6069
	ld b, a ; $606c
	ld c, $01 ; $606d
	call Func_16_6073 ; $606f
Label_16_6072:
	ret ; $6072
Func_16_6073:
	push de ; $6073
	push bc ; $6074
	ld a, c ; $6075
	add a, $04 ; $6076
	ld d, a ; $6078
	ld a, b ; $6079
	farcall FarPtr_18_02 ; $607a
	pop bc ; $607d
	pop de ; $607e
	ld b, d ; $607f
	ld a, c ; $6080
	add a, a ; $6081
	ld hl, $60b7 ; $6082
	add a, l ; $6085
	ld l, a ; $6086
	jr nc, Label_16_608a ; $6087
	inc h ; $6089
Label_16_608a:
	ld a, [hl+] ; $608a
	ld d, [hl] ; $608b
	ld e, a ; $608c
	push de ; $608d
	ld a, c ; $608e
	cp a, $02 ; $608f
	jr z, Label_16_6099 ; $6091
	cp a, $03 ; $6093
	jr z, Label_16_6099 ; $6095
	jr Label_16_609d ; $6097
Label_16_6099:
	ld c, $00 ; $6099
	jr Label_16_60b2 ; $609b
Label_16_609d:
	ld a, [$d801] ; $609d
	or a, a ; $60a0
	jr z, Label_16_60a7 ; $60a1
	ld c, $00 ; $60a3
	jr Label_16_60b2 ; $60a5
Label_16_60a7:
	ld c, $01 ; $60a7
	ld a, [wMatchWinLoseFlag] ; $60a9
	cp a, $ff ; $60ac
	jr nz, Label_16_60b2 ; $60ae
	ld c, $02 ; $60b0
Label_16_60b2:
	pop de ; $60b2
	call Func_16_60c0 ; $60b3
	ret ; $60b6
	; $60b7, 9 bytes (records:2)
; 4 records x 2 bytes
	dw $8c00 ; record 0
	dw $8d00 ; record 1
	dw $8e00 ; record 2
	dw $8f00 ; record 3
	db $c9
Func_16_60c0:
	ld a, c ; $60c0
	or a, a ; $60c1
	jr z, Label_16_60c8 ; $60c2
	call Func_16_60d5 ; $60c4
	ret ; $60c7
Label_16_60c8:
	cp a, $20 ; $60c8
	jr c, Label_16_60d1 ; $60ca
	ld a, b ; $60cc
	farcall FarPtr_02_36 ; $60cd
	ld b, a ; $60d0
Label_16_60d1:
	call Func_16_6955 ; $60d1
	ret ; $60d4
Func_16_60d5:
	ld a, b ; $60d5
	add a, a ; $60d6
	and a, $07 ; $60d7
	ld b, a ; $60d9
	ld a, c ; $60da
	cp a, $01 ; $60db
	ld a, b ; $60dd
	jr z, Label_16_60e1 ; $60de
	inc a ; $60e0
Label_16_60e1:
	ld hl, $60f1 ; $60e1
	add a, a ; $60e4
	add a, l ; $60e5
	ld l, a ; $60e6
	jr nc, Label_16_60ea ; $60e7
	inc h ; $60e9
Label_16_60ea:
	ld a, [hl+] ; $60ea
	ld h, [hl] ; $60eb
	ld l, a ; $60ec
	call DecompressData ; $60ed
	ret ; $60f0
	; $60f1, 195 bytes (records:2)
; 97 records x 2 bytes
	dw $6101 ; record 0
	dw $6214 ; record 1
	dw $6315 ; record 2
	dw $6422 ; record 3
	dw $6536 ; record 4
	dw $6634 ; record 5
	dw $6727 ; record 6
	dw $684a ; record 7
	dw $ff7f ; record 8
	dw $8000 ; record 9
	dw $807f ; record 10
	dw $817e ; record 11
	dw $e1fe ; record 12
	dw $7cff ; record 13
	dw $7c82 ; record 14
	dw $7982 ; record 15
	dw $00ff ; record 16
	dw $ff9b ; record 17
	dw $b737 ; record 18
	dw $5b64 ; record 19
	dw $6f48 ; record 20
	dw $bfcf ; record 21
	dw $bffb ; record 22
	dw $ffff ; record 23
	dw $00e1 ; record 24
	dw $f8fb ; record 25
	dw $04f7 ; record 26
	dw $ffbf ; record 27
	dw $f704 ; record 28
	dw $fefc ; record 29
	dw $f0fe ; record 30
	dw $a5e3 ; record 31
	dw $72ff ; record 32
	dw $18d5 ; record 33
	dw $08eb ; record 34
	dw $0cf9 ; record 35
	dw $fff5 ; record 36
	dw $7d04 ; record 37
	dw $bb06 ; record 38
	dw $8586 ; record 39
	dw $8579 ; record 40
	dw $7bfb ; record 41
	dw $fe87 ; record 42
	dw $9ee0 ; record 43
	dw $ad42 ; record 44
	dw $b24d ; record 45
	dw $5fff ; record 46
	dw $5fb2 ; record 47
	dw $fffd ; record 48
	dw $fff0 ; record 49
	dw $ffe8 ; record 50
	dw $f8ff ; record 51
	dw $c4ff ; record 52
	dw $e0ff ; record 53
	dw $9aff ; record 54
	dw $fffb ; record 55
	dw $bd9e ; record 56
	dw $7fe0 ; record 57
	dw $1dff ; record 58
	dw $3eff ; record 59
	dw $ffff ; record 60
	dw $ff44 ; record 61
	dw $ff00 ; record 62
	dw $ff1c ; record 63
	dw $ff6c ; record 64
	dw $dbff ; record 65
	dw $dfc2 ; record 66
	dw $ebe2 ; record 67
	dw $ebe2 ; record 68
	dw $f6ff ; record 69
	dw $f675 ; record 70
	dw $fc7d ; record 71
	dw $fe65 ; record 72
	dw $ff4b ; record 73
	dw $f2fe ; record 74
	dw $b31f ; record 75
	dw $ce7f ; record 76
	dw $d17e ; record 77
	dw $7fff ; record 78
	dw $7f90 ; record 79
	dw $7f8c ; record 80
	dw $7fd0 ; record 81
	dw $ffb1 ; record 82
	dw $887f ; record 83
	dw $84ff ; record 84
	dw $80ff ; record 85
	dw $41ff ; record 86
	dw $ffff ; record 87
	dw $ffc1 ; record 88
	dw $ffb0 ; record 89
	dw $9f8e ; record 90
	dw $ebd9 ; record 91
	dw $0043 ; record 92
	dw $e0c8 ; record 93
	dw $ac30 ; record 94
	dw $90e0 ; record 95
	dw $90df ; record 96
	db $ff
	; $61b4, 777 bytes (records:2)
; 388 records x 2 bytes
	dw $639f ; record 0
	dw $9dff ; record 1
	dw $13fe ; record 2
	dw $03fe ; record 3
	dw $feff ; record 4
	dw $fe05 ; record 5
	dw $fc39 ; record 6
	dw $c85b ; record 7
	dw $ffad ; record 8
	dw $6d88 ; record 9
	dw $f50a ; record 10
	dw $cf1a ; record 11
	dw $b41e ; record 12
	dw $04ff ; record 13
	dw $6389 ; record 14
	dw $7184 ; record 15
	dw $7882 ; record 16
	dw $ff81 ; record 17
	dw $807c ; record 18
	dw $ff7e ; record 19
	dw $4f00 ; record 20
	dw $be61 ; record 21
	dw $ffff ; record 22
	dw $fa17 ; record 23
	dw $f293 ; record 24
	dw $f76d ; record 25
	dw $ff2d ; record 26
	dw $bf64 ; record 27
	dw $ff24 ; record 28
	dw $9500 ; record 29
	dw $aaf4 ; record 30
	dw $ea7f ; record 31
	dw $e7b7 ; record 32
	dw $c95c ; record 33
	dw $b0b7 ; record 34
	dw $e0a9 ; record 35
	dw $b3fe ; record 36
	dw $d5e0 ; record 37
	dw $a912 ; record 38
	dw $c932 ; record 39
	dw $91e6 ; record 40
	dw $c6ff ; record 41
	dw $6249 ; record 42
	dw $b2a5 ; record 43
	dw $98d5 ; record 44
	dw $01ff ; record 45
	dw $0000 ; record 46
	dw $0000 ; record 47
	dw $ffff ; record 48
	dw $fc00 ; record 49
	dw $fc7e ; record 50
	dw $f97d ; record 51
	dw $ff7d ; record 52
	dw $7bf9 ; record 53
	dw $7af2 ; record 54
	dw $76f3 ; record 55
	dw $76f5 ; record 56
	dw $ffff ; record 57
	dw $5b00 ; record 58
	dw $bcc0 ; record 59
	dw $7f83 ; record 60
	dw $fd00 ; record 61
	dw $feff ; record 62
	dw $7ee6 ; record 63
	dw $7f00 ; record 64
	dw $bf00 ; record 65
	dw $df00 ; record 66
	dw $00df ; record 67
	dw $00ef ; record 68
	dw $fef7 ; record 69
	dw $ffe0 ; record 70
	dw $ff00 ; record 71
	dw $de9f ; record 72
	dw $5e4f ; record 73
	dw $6ecf ; record 74
	dw $2ea7 ; record 75
	dw $e7ff ; record 76
	dw $d736 ; record 77
	dw $d736 ; record 78
	dw $f516 ; record 79
	dw $ff74 ; record 80
	dw $74e7 ; record 81
	dw $6cc7 ; record 82
	dw $5c8d ; record 83
	dw $3693 ; record 84
	dw $aebf ; record 85
	dw $dd62 ; record 86
	dw $fe41 ; record 87
	dw $c840 ; record 88
	dw $ffe7 ; record 89
	dw $c8fe ; record 90
	dw $dfe0 ; record 91
	dw $fbc0 ; record 92
	dw $fb00 ; record 93
	dw $fd00 ; record 94
	dw $fefe ; record 95
	dw $fce0 ; record 96
	dw $f900 ; record 97
	dw $df03 ; record 98
	dw $261f ; record 99
	dw $7fff ; record 100
	dw $16d7 ; record 101
	dw $36d3 ; record 102
	dw $3ab3 ; record 103
	dw $777b ; record 104
	dw $fb7a ; record 105
	dw $fefa ; record 106
	dw $5be1 ; record 107
	dw $bfda ; record 108
	dw $e296 ; record 109
	dw $bfff ; record 110
	dw $ee40 ; record 111
	dw $9f60 ; record 112
	dw $803f ; record 113
	dw $ff40 ; record 114
	dw $7df8 ; record 115
	dw $3fbf ; record 116
	dw $01fd ; record 117
	dw $07f7 ; record 118
	dw $c9ff ; record 119
	dw $701f ; record 120
	dw $90ff ; record 121
	dw $6cdf ; record 122
	dw $ffff ; record 123
	dw $93bb ; record 124
	dw $ffc8 ; record 125
	dw $ffc9 ; record 126
	dw $ffe0 ; record 127
	dw $d0ff ; record 128
	dw $01fe ; record 129
	dw $01fe ; record 130
	dw $8eff ; record 131
	dw $ffff ; record 132
	dw $fff4 ; record 133
	dw $9a8b ; record 134
	dw $eacb ; record 135
	dw $eaab ; record 136
	dw $a3f7 ; record 137
	dw $17f6 ; record 138
	dw $e0fe ; record 139
	dw $f667 ; record 140
	dw $ce47 ; record 141
	dw $fdfb ; record 142
	dw $fe7d ; record 143
	dw $fce1 ; record 144
	dw $fc7d ; record 145
	dw $fe7e ; record 146
	dw $fefe ; record 147
	dw $ffe0 ; record 148
	dw $6d00 ; record 149
	dw $b33d ; record 150
	dw $3d47 ; record 151
	dw $01bf ; record 152
	dw $80fb ; record 153
	dw $84fb ; record 154
	dw $feff ; record 155
	dw $00e1 ; record 156
	dw $03ff ; record 157
	dw $3807 ; record 158
	dw $1878 ; record 159
	dw $98bd ; record 160
	dw $ffd9 ; record 161
	dw $5a49 ; record 162
	dw $6acb ; record 163
	dw $2ba9 ; record 164
	dw $00ff ; record 165
	dw $8fff ; record 166
	dw $1fde ; record 167
	dw $3f3e ; record 168
	dw $3f7e ; record 169
	dw $ff3e ; record 170
	dw $be3f ; record 171
	dw $bebf ; record 172
	dw $be3f ; record 173
	dw $00ff ; record 174
	dw $0000 ; record 175
	dw $ff00 ; record 176
	dw $00ff ; record 177
	dw $7982 ; record 178
	dw $01bf ; record 179
	dw $1fcf ; record 180
	dw $d2ff ; record 181
	dw $e23f ; record 182
	dw $e33f ; record 183
	dw $a67f ; record 184
	dw $d67f ; record 185
	dw $e0f0 ; record 186
	dw $04ff ; record 187
	dw $e0fe ; record 188
	dw $fe08 ; record 189
	dw $e9e0 ; record 190
	dw $bfff ; record 191
	dw $ff16 ; record 192
	dw $00ff ; record 193
	dw $ff00 ; record 194
	dw $e5fe ; record 195
	dw $fb80 ; record 196
	dw $60ff ; record 197
	dw $e0f0 ; record 198
	dw $c691 ; record 199
	dw $e05f ; record 200
	dw $ef39 ; record 201
	dw $25fc ; record 202
	dw $43fe ; record 203
	dw $e0fe ; record 204
	dw $fe47 ; record 205
	dw $ff99 ; record 206
	dw $977f ; record 207
	dw $ad7f ; record 208
	dw $d67f ; record 209
	dw $e27f ; record 210
	dw $76ff ; record 211
	dw $67cb ; record 212
	dw $45df ; record 213
	dw $07ef ; record 214
	dw $dbf9 ; record 215
	dw $7ffc ; record 216
	dw $e2cf ; record 217
	dw $e1de ; record 218
	dw $e1f8 ; record 219
	dw $c09f ; record 220
	dw $98ff ; record 221
	dw $e43f ; record 222
	dw $fa0f ; record 223
	dw $fa07 ; record 224
	dw $ff03 ; record 225
	dw $f3ed ; record 226
	dw $19dd ; record 227
	dw $00ff ; record 228
	dw $3a9b ; record 229
	dw $39ff ; record 230
	dw $17fe ; record 231
	dw $11fe ; record 232
	dw $2df2 ; record 233
	dw $fff0 ; record 234
	dw $e06b ; record 235
	dw $b6d9 ; record 236
	dw $56f9 ; record 237
	dw $d6b9 ; record 238
	dw $8fff ; record 239
	dw $8b35 ; record 240
	dw $8977 ; record 241
	dw $8573 ; record 242
	dw $ff73 ; record 243
	dw $728b ; record 244
	dw $768b ; record 245
	dw $748d ; record 246
	dw $748f ; record 247
	dw $efff ; record 248
	dw $1fe0 ; record 249
	dw $2f90 ; record 250
	dw $7f88 ; record 251
	dw $ff10 ; record 252
	dw $d8ce ; record 253
	dw $23af ; record 254
	dw $13d6 ; record 255
	dw $0ded ; record 256
	dw $7dff ; record 257
	dw $837c ; record 258
	dw $c398 ; record 259
	dw $a718 ; record 260
	dw $ff00 ; record 261
	dw $c1ff ; record 262
	dw $fb5a ; record 263
	dw $e56f ; record 264
	dw $81bd ; record 265
	dw $d9ff ; record 266
	dw $a996 ; record 267
	dw $c936 ; record 268
	dw $b1e6 ; record 269
	dw $ff86 ; record 270
	dw $1e41 ; record 271
	dw $3e81 ; record 272
	dw $7e81 ; record 273
	dw $3e81 ; record 274
	dw $8def ; record 275
	dw $8b74 ; record 276
	dw $c476 ; record 277
	dw $66e2 ; record 278
	dw $6495 ; record 279
	dw $97ff ; record 280
	dw $ff6c ; record 281
	dw $db00 ; record 282
	dw $ed2f ; record 283
	dw $ff2b ; record 284
	dw $19fb ; record 285
	dw $1cf4 ; record 286
	dw $37db ; record 287
	dw $20ef ; record 288
	dw $efff ; record 289
	dw $ff30 ; record 290
	dw $fe00 ; record 291
	dw $ff03 ; record 292
	dw $ff03 ; record 293
	dw $027a ; record 294
	dw $86bd ; record 295
	dw $c4fd ; record 296
	dw $42df ; record 297
	dw $bdff ; record 298
	dw $ff61 ; record 299
	dw $4100 ; record 300
	dw $413e ; record 301
	dw $ff9e ; record 302
	dw $9ea1 ; record 303
	dw $dea1 ; record 304
	dw $4e61 ; record 305
	dw $4ed1 ; record 306
	dw $d10f ; record 307
	dw $ff6e ; record 308
	dw $0000 ; record 309
	dw $0000 ; record 310
	dw $ffff ; record 311
	dw $fc00 ; record 312
	dw $f97d ; record 313
	dw $f97d ; record 314
	dw $ff7b ; record 315
	dw $73e2 ; record 316
	dw $4f86 ; record 317
	dw $3f99 ; record 318
	dw $7fe0 ; record 319
	dw $ffdf ; record 320
	dw $8000 ; record 321
	dw $00ff ; record 322
	dw $e6fe ; record 323
	dw $ff81 ; record 324
	dw $ffff ; record 325
	dw $0900 ; record 326
	dw $04ff ; record 327
	dw $02ff ; record 328
	dw $fdff ; record 329
	dw $fe01 ; record 330
	dw $39e0 ; record 331
	dw $d6ff ; record 332
	dw $ffe7 ; record 333
	dw $ff00 ; record 334
	dw $be1f ; record 335
	dw $c081 ; record 336
	dw $fe5d ; record 337
	dw $fe63 ; record 338
	dw $9dff ; record 339
	dw $63fe ; record 340
	dw $a1f6 ; record 341
	dw $a0b8 ; record 342
	dw $ff7f ; record 343
	dw $7f98 ; record 344
	dw $7f85 ; record 345
	dw $7f8e ; record 346
	dw $7ff4 ; record 347
	dw $a5ff ; record 348
	dw $a267 ; record 349
	dw $cb67 ; record 350
	dw $866a ; record 351
	dw $ffff ; record 352
	dw $fc87 ; record 353
	dw $f80b ; record 354
	dw $f80f ; record 355
	dw $f017 ; record 356
	dw $ddff ; record 357
	dw $aff3 ; record 358
	dw $bd60 ; record 359
	dw $7a81 ; record 360
	dw $de03 ; record 361
	dw $e3b1 ; record 362
	dw $30bf ; record 363
	dw $e0df ; record 364
	dw $e0fa ; record 365
	dw $d7c0 ; record 366
	dw $36ff ; record 367
	dw $16d7 ; record 368
	dw $16f3 ; record 369
	dw $12f1 ; record 370
	dw $fff9 ; record 371
	dw $559c ; record 372
	dw $e57c ; record 373
	dw $a33e ; record 374
	dw $cb3e ; record 375
	dw $5aff ; record 376
	dw $5ada ; record 377
	dw $5bd9 ; record 378
	dw $5dd8 ; record 379
	dw $ff8c ; record 380
	dw $cf5e ; record 381
	dw $a76f ; record 382
	dw $a76f ; record 383
	dw $7f77 ; record 384
	dw $c6ff ; record 385
	dw $42fb ; record 386
	dw $057b ; record 387
	db $d4
	; $64bd, 777 bytes (records:2)
; 388 records x 2 bytes
	dw $2be3 ; record 0
	dw $20ff ; record 1
	dw $b093 ; record 2
	dw $dc8d ; record 3
	dw $efcb ; record 4
	dw $ffde ; record 5
	dw $ade1 ; record 6
	dw $efe1 ; record 7
	dw $7ff3 ; record 8
	dw $fa01 ; record 9
	dw $03ff ; record 10
	dw $00fe ; record 11
	dw $63fb ; record 12
	dw $0e6c ; record 13
	dw $ffc5 ; record 14
	dw $65fe ; record 15
	dw $d9fe ; record 16
	dw $c9fe ; record 17
	dw $4b5e ; record 18
	dw $6eff ; record 19
	dw $a6a5 ; record 20
	dw $ae65 ; record 21
	dw $2ea9 ; record 22
	dw $ff97 ; record 23
	dw $9077 ; record 24
	dw $9076 ; record 25
	dw $8979 ; record 26
	dw $e67b ; record 27
	dw $7fff ; record 28
	dw $3e9a ; record 29
	dw $4283 ; record 30
	dw $00ff ; record 31
	dw $ff8c ; record 32
	dw $17d9 ; record 33
	dw $ff30 ; record 34
	dw $65e8 ; record 35
	dw $db24 ; record 36
	dw $13ff ; record 37
	dw $10f6 ; record 38
	dw $18ef ; record 39
	dw $00ff ; record 40
	dw $fffb ; record 41
	dw $95f2 ; record 42
	dw $77d0 ; record 43
	dw $ab78 ; record 44
	dw $5728 ; record 45
	dw $1cff ; record 46
	dw $e4ed ; record 47
	dw $02fb ; record 48
	dw $00ff ; record 49
	dw $ffa9 ; record 50
	dw $c96e ; record 51
	dw $456e ; record 52
	dw $c556 ; record 53
	dw $cbce ; record 54
	dw $6e7f ; record 55
	dw $3cad ; record 56
	dw $32e1 ; record 57
	dw $00ff ; record 58
	dw $0000 ; record 59
	dw $ff00 ; record 60
	dw $00ff ; record 61
	dw $4399 ; record 62
	dw $0fa6 ; record 63
	dw $1fc8 ; record 64
	dw $d0ff ; record 65
	dw $a13f ; record 66
	dw $a23f ; record 67
	dw $c17f ; record 68
	dw $ff7f ; record 69
	dw $00ff ; record 70
	dw $c09d ; record 71
	dw $f872 ; record 72
	dw $fc2a ; record 73
	dw $25ff ; record 74
	dw $25fc ; record 75
	dw $4afe ; record 76
	dw $b2fe ; record 77
	dw $ffff ; record 78
	dw $00ff ; record 79
	dw $7f3f ; record 80
	dw $3f9f ; record 81
	dw $1f5f ; record 82
	dw $5fff ; record 83
	dw $5f9f ; record 84
	dw $a93f ; record 85
	dw $bf23 ; record 86
	dw $df60 ; record 87
	dw $00ff ; record 88
	dw $fefd ; record 89
	dw $feff ; record 90
	dw $3fe6 ; record 91
	dw $7f7e ; record 92
	dw $7fc1 ; record 93
	dw $7fc0 ; record 94
	dw $7fa0 ; record 95
	dw $fe80 ; record 96
	dw $ffe2 ; record 97
	dw $7fa4 ; record 98
	dw $7fc7 ; record 99
	dw $ff4d ; record 100
	dw $ffc5 ; record 101
	dw $66ff ; record 102
	dw $84ff ; record 103
	dw $05fd ; record 104
	dw $09fd ; record 105
	dw $fffb ; record 106
	dw $fb32 ; record 107
	dw $e3ce ; record 108
	dw $47db ; record 109
	dw $7f7f ; record 110
	dw $56ff ; record 111
	dw $8fff ; record 112
	dw $1ffb ; record 113
	dw $1ff7 ; record 114
	dw $fdff ; record 115
	dw $fe00 ; record 116
	dw $4fe0 ; record 117
	dw $f39e ; record 118
	dw $fd86 ; record 119
	dw $ff80 ; record 120
	dw $c05f ; record 121
	dw $f067 ; record 122
	dw $fc7d ; record 123
	dw $fef3 ; record 124
	dw $f9ff ; record 125
	dw $89fe ; record 126
	dw $927c ; record 127
	dw $a478 ; record 128
	dw $ff71 ; record 129
	dw $63a8 ; record 130
	dw $67d0 ; record 131
	dw $40df ; record 132
	dw $7ebc ; record 133
	dw $c2ff ; record 134
	dw $f57f ; record 135
	dw $0503 ; record 136
	dw $04f9 ; record 137
	dw $fff1 ; record 138
	dw $f309 ; record 139
	dw $f70b ; record 140
	dw $770c ; record 141
	dw $678e ; record 142
	dw $b4ff ; record 143
	dw $8107 ; record 144
	dw $01ff ; record 145
	dw $c1ff ; record 146
	dw $ffff ; record 147
	dw $7fb3 ; record 148
	dw $1f73 ; record 149
	dw $ffe3 ; record 150
	dw $ff07 ; record 151
	dw $1f7f ; record 152
	dw $ebff ; record 153
	dw $d3fe ; record 154
	dw $c7fe ; record 155
	dw $e07e ; record 156
	dw $cfff ; record 157
	dw $8ffe ; record 158
	dw $87fe ; record 159
	dw $c3fe ; record 160
	dw $e3fe ; record 161
	dw $7f81 ; record 162
	dw $e1fe ; record 163
	dw $e180 ; record 164
	dw $e1f6 ; record 165
	dw $00ff ; record 166
	dw $67ce ; record 167
	dw $3f1f ; record 168
	dw $ffff ; record 169
	dw $56e5 ; record 170
	dw $00e0 ; record 171
	dw $53bf ; record 172
	dw $5fe0 ; record 173
	dw $fffa ; record 174
	dw $ffe4 ; record 175
	dw $fec8 ; record 176
	dw $d3e0 ; record 177
	dw $e032 ; record 178
	dw $03ff ; record 179
	dw $03fe ; record 180
	dw $07fe ; record 181
	dw $0ffe ; record 182
	dw $05fe ; record 183
	dw $3a3f ; record 184
	dw $00e3 ; record 185
	dw $0000 ; record 186
	dw $df00 ; record 187
	dw $00ff ; record 188
	dw $7fbf ; record 189
	dw $feff ; record 190
	dw $9fe6 ; record 191
	dw $f73f ; record 192
	dw $00ff ; record 193
	dw $ffff ; record 194
	dw $fbe2 ; record 195
	dw $effc ; record 196
	dw $fff0 ; record 197
	dw $c5de ; record 198
	dw $87b7 ; record 199
	dw $00ff ; record 200
	dw $fefc ; record 201
	dw $f0ff ; record 202
	dw $e3f9 ; record 203
	dw $a3f7 ; record 204
	dw $d137 ; record 205
	dw $ff5b ; record 206
	dw $fdf9 ; record 207
	dw $fd35 ; record 208
	dw $00ff ; record 209
	dw $fe7f ; record 210
	dw $fff9 ; record 211
	dw $e8fe ; record 212
	dw $e1c2 ; record 213
	dw $7ffe ; record 214
	dw $7efe ; record 215
	dw $ffff ; record 216
	dw $fd7e ; record 217
	dw $8d7e ; record 218
	dw $c21c ; record 219
	dw $6c67 ; record 220
	dw $0fff ; record 221
	dw $1fdc ; record 222
	dw $3fec ; record 223
	dw $3fa9 ; record 224
	dw $ffa1 ; record 225
	dw $f67f ; record 226
	dw $f37e ; record 227
	dw $fb7c ; record 228
	dw $0c7c ; record 229
	dw $fdff ; record 230
	dw $fe34 ; record 231
	dw $ff0e ; record 232
	dw $fd25 ; record 233
	dw $ff13 ; record 234
	dw $02fe ; record 235
	dw $0cff ; record 236
	dw $81ff ; record 237
	dw $ff3f ; record 238
	dw $d3fe ; record 239
	dw $3fe0 ; record 240
	dw $1f7e ; record 241
	dw $9fbe ; record 242
	dw $4fde ; record 243
	dw $5eff ; record 244
	dw $ee4f ; record 245
	dw $ee27 ; record 246
	dw $7bf1 ; record 247
	dw $fbf9 ; record 248
	dw $fa7b ; record 249
	dw $e2fe ; record 250
	dw $7bf9 ; record 251
	dw $7df8 ; record 252
	dw $fffc ; record 253
	dw $fb7e ; record 254
	dw $3dfc ; record 255
	dw $1efc ; record 256
	dw $cffe ; record 257
	dw $ffff ; record 258
	dw $ff2f ; record 259
	dw $ff07 ; record 260
	dw $fff3 ; record 261
	dw $ff3b ; record 262
	dw $c67f ; record 263
	dw $883f ; record 264
	dw $893f ; record 265
	dw $487f ; record 266
	dw $3fef ; record 267
	dw $bf81 ; record 268
	dw $67c7 ; record 269
	dw $a7e2 ; record 270
	dw $33f6 ; record 271
	dw $f6af ; record 272
	dw $fa13 ; record 273
	dw $cd5b ; record 274
	dw $fbe0 ; record 275
	dw $e0fe ; record 276
	dw $fdeb ; record 277
	dw $44fa ; record 278
	dw $fee3 ; record 279
	dw $fc7f ; record 280
	dw $f07e ; record 281
	dw $ff79 ; record 282
	dw $77e3 ; record 283
	dw $00ff ; record 284
	dw $bf11 ; record 285
	dw $df90 ; record 286
	dw $107f ; record 287
	dw $389f ; record 288
	dw $787f ; record 289
	dw $fcff ; record 290
	dw $e059 ; record 291
	dw $32fa ; record 292
	dw $f8e1 ; record 293
	dw $e02d ; record 294
	dw $ff40 ; record 295
	dw $ff20 ; record 296
	dw $fb21 ; record 297
	dw $11ff ; record 298
	dw $e0f0 ; record 299
	dw $e6e3 ; record 300
	dw $9e8f ; record 301
	dw $4f9f ; record 302
	dw $c19e ; record 303
	dw $fde0 ; record 304
	dw $e04b ; record 305
	dw $e036 ; record 306
	dw $0000 ; record 307
	dw $0000 ; record 308
	dw $ffff ; record 309
	dw $8400 ; record 310
	dw $8579 ; record 311
	dw $8a73 ; record 312
	dw $ff73 ; record 313
	dw $678a ; record 314
	dw $6794 ; record 315
	dw $6f95 ; record 316
	dw $6f9a ; record 317
	dw $ffff ; record 318
	dw $8100 ; record 319
	dw $0eff ; record 320
	dw $34ff ; record 321
	dw $fff7 ; record 322
	dw $ef4b ; record 323
	dw $ded4 ; record 324
	dw $df7f ; record 325
	dw $f168 ; record 326
	dw $ffff ; record 327
	dw $8000 ; record 328
	dw $1eff ; record 329
	dw $e5ff ; record 330
	dw $fff1 ; record 331
	dw $803f ; record 332
	dw $00ff ; record 333
	dw $e0ef ; record 334
	dw $9c1d ; record 335
	dw $ffff ; record 336
	dw $0100 ; record 337
	dw $01fe ; record 338
	dw $81fe ; record 339
	dw $fffe ; record 340
	dw $7e41 ; record 341
	dw $3ea1 ; record 342
	dw $1ed1 ; record 343
	dw $0ee9 ; record 344
	dw $9cff ; record 345
	dw $986e ; record 346
	dw $9a6c ; record 347
	dw $8d69 ; record 348
	dw $ff61 ; record 349
	dw $7b85 ; record 350
	dw $7b86 ; record 351
	dw $439e ; record 352
	dw $1faa ; record 353
	dw $b0ff ; record 354
	dw $ace6 ; record 355
	dw $b6ed ; record 356
	dw $7af2 ; record 357
	dw $fff7 ; record 358
	dw $fd3f ; record 359
	dw $f73f ; record 360
	dw $ef4d ; record 361
	dw $c753 ; record 362
	dw $3bff ; record 363
	dw $ff43 ; record 364
	dw $7c00 ; record 365
	dw $7c80 ; record 366
	dw $ff03 ; record 367
	dw $00ff ; record 368
	dw $02f8 ; record 369
	dw $01bc ; record 370
	dw $42fd ; record 371
	dw $b5ff ; record 372
	dw $6b86 ; record 373
	dw $df62 ; record 374
	dw $151a ; record 375
	dw $ffc4 ; record 376
	dw $268f ; record 377
	dw $06ed ; record 378
	dw $863d ; record 379
	dw $469d ; record 380
	dw $feff ; record 381
	dw $fa17 ; record 382
	dw $d573 ; record 383
	dw $ff39 ; record 384
	dw $ff69 ; record 385
	dw $28fa ; record 386
	dw $64f3 ; record 387
	db $ff
	; $67c6, 399 bytes (records:2)
; 199 records x 2 bytes
	dw $de00 ; record 0
	dw $ff41 ; record 1
	dw $c07f ; record 2
	dw $c05f ; record 3
	dw $e03f ; record 4
	dw $e02f ; record 5
	dw $96ff ; record 6
	dw $cff0 ; record 7
	dw $bbfc ; record 8
	dw $e6f8 ; record 9
	dw $ff8e ; record 10
	dw $4777 ; record 11
	dw $81fc ; record 12
	dw $807f ; record 13
	dw $007f ; record 14
	dw $1fff ; record 15
	dw $47c0 ; record 16
	dw $1fb0 ; record 17
	dw $fd40 ; record 18
	dw $ff01 ; record 19
	dw $a61d ; record 20
	dw $f6f5 ; record 21
	dw $2eb9 ; record 22
	dw $0ee9 ; record 23
	dw $d1ff ; record 24
	dw $a11e ; record 25
	dw $453e ; record 26
	dw $8b7e ; record 27
	dw $fffe ; record 28
	dw $70b6 ; record 29
	dw $0cfb ; record 30
	dw $689b ; record 31
	dw $489f ; record 32
	dw $afff ; record 33
	dw $af48 ; record 34
	dw $b758 ; record 35
	dw $ff10 ; record 36
	dw $ff00 ; record 37
	dw $83d9 ; record 38
	dw $b0c7 ; record 39
	dw $80ff ; record 40
	dw $bf9f ; record 41
	dw $aeff ; record 42
	dw $fdea ; record 43
	dw $dfd4 ; record 44
	dw $ff94 ; record 45
	dw $ff00 ; record 46
	dw $87b6 ; record 47
	dw $fbf9 ; record 48
	dw $88eb ; record 49
	dw $0c79 ; record 50
	dw $f4ff ; record 51
	dw $ef06 ; record 52
	dw $fd0b ; record 53
	dw $ff14 ; record 54
	dw $ff00 ; record 55
	dw $fe3d ; record 56
	dw $e0cf ; record 57
	dw $06f1 ; record 58
	dw $7e01 ; record 59
	dw $c1ff ; record 60
	dw $211e ; record 61
	dw $918e ; record 62
	dw $ffc6 ; record 63
	dw $0000 ; record 64
	dw $0000 ; record 65
	dw $ffff ; record 66
	dw $f200 ; record 67
	dw $e477 ; record 68
	dw $e477 ; record 69
	dw $ff6f ; record 70
	dw $6fe8 ; record 71
	dw $6fc8 ; record 72
	dw $5fc8 ; record 73
	dw $5fd3 ; record 74
	dw $ffef ; record 75
	dw $0000 ; record 76
	dw $feff ; record 77
	dw $07e3 ; record 78
	dw $7aff ; record 79
	dw $f8f7 ; record 80
	dw $81be ; record 81
	dw $e1f0 ; record 82
	dw $ff20 ; record 83
	dw $ff45 ; record 84
	dw $49ff ; record 85
	dw $8aff ; record 86
	dw $9aff ; record 87
	dw $9afe ; record 88
	dw $fffe ; record 89
	dw $00ff ; record 90
	dw $fc09 ; record 91
	dw $fcc5 ; record 92
	dw $3e65 ; record 93
	dw $e3ff ; record 94
	dw $d33e ; record 95
	dw $d33e ; record 96
	dw $f51e ; record 97
	dw $dffe ; record 98
	dw $5cdd ; record 99
	dw $50d7 ; record 100
	dw $fedf ; record 101
	dw $dbe0 ; record 102
	dw $f753 ; record 103
	dw $5fdc ; record 104
	dw $fed0 ; record 105
	dw $ffe0 ; record 106
	dw $ff01 ; record 107
	dw $9f01 ; record 108
	dw $03fb ; record 109
	dw $3fbd ; record 110
	dw $f7c1 ; record 111
	dw $f3e1 ; record 112
	dw $2fe0 ; record 113
	dw $e7ff ; record 114
	dw $fc3d ; record 115
	dw $c654 ; record 116
	dw $c574 ; record 117
	dw $ffaa ; record 118
	dw $c684 ; record 119
	dw $7f8e ; record 120
	dw $57fd ; record 121
	dw $35d7 ; record 122
	dw $bcff ; record 123
	dw $3cf5 ; record 124
	dw $3ce9 ; record 125
	dw $3aa9 ; record 126
	dw $ffb3 ; record 127
	dw $c97a ; record 128
	dw $c97a ; record 129
	dw $b57c ; record 130
	dw $d03c ; record 131
	dw $5fff ; record 132
	dw $5fc8 ; record 133
	dw $6fc8 ; record 134
	dw $6fe4 ; record 135
	dw $7fc2 ; record 136
	dw $8d67 ; record 137
	dw $975d ; record 138
	dw $af30 ; record 139
	dw $8260 ; record 140
	dw $ffe5 ; record 141
	dw $ff00 ; record 142
	dw $ff80 ; record 143
	dw $7f70 ; record 144
	dw $3fbf ; record 145
	dw $2cff ; record 146
	dw $17ea ; record 147
	dw $0df0 ; record 148
	dw $83fc ; record 149
	dw $ffff ; record 150
	dw $fc7d ; record 151
	dw $e12e ; record 152
	dw $f81f ; record 153
	dw $f1ed ; record 154
	dw $ed7f ; record 155
	dw $d50c ; record 156
	dw $e51c ; record 157
	dw $653c ; record 158
	dw $e0bc ; record 159
	dw $29ff ; record 160
	dw $53ba ; record 161
	dw $937a ; record 162
	dw $ded6 ; record 163
	dw $ff40 ; record 164
	dw $40ff ; record 165
	dw $60af ; record 166
	dw $3097 ; record 167
	dw $5c8d ; record 168
	dw $c3ff ; record 169
	dw $f067 ; record 170
	dw $ff79 ; record 171
	dw $c100 ; record 172
	dw $ffe1 ; record 173
	dw $39b1 ; record 174
	dw $0eee ; record 175
	dw $05fd ; record 176
	dw $02fb ; record 177
	dw $7eff ; record 178
	dw $b102 ; record 179
	dw $ff89 ; record 180
	dw $de00 ; record 181
	dw $ff1f ; record 182
	dw $10f0 ; record 183
	dw $1ffe ; record 184
	dw $1575 ; record 185
	dw $8baf ; record 186
	dw $d5ff ; record 187
	dw $af45 ; record 188
	dw $ff25 ; record 189
	dw $0700 ; record 190
	dw $f72e ; record 191
	dw $7e3f ; record 192
	dw $fe7f ; record 193
	dw $3fe2 ; record 194
	dw $1f7e ; record 195
	dw $03be ; record 196
	dw $00ff ; record 197
	dw $0000 ; record 198
	db $00
Func_16_6955:
	ld a, b ; $6955
	and a, $1f ; $6956
	add a, a ; $6958
	ld hl, $6968 ; $6959
	add a, l ; $695c
	ld l, a ; $695d
	jr nc, Label_16_6961 ; $695e
	inc h ; $6960
Label_16_6961:
	ld a, [hl+] ; $6961
	ld h, [hl] ; $6962
	ld l, a ; $6963
	call DecompressData ; $6964
	ret ; $6967
	; $6968, 163 bytes (records:2)
; 81 records x 2 bytes
	dw $69a8 ; record 0
	dw $6a46 ; record 1
	dw $6ae9 ; record 2
	dw $6b7b ; record 3
	dw $6c20 ; record 4
	dw $6ca6 ; record 5
	dw $6d3a ; record 6
	dw $6dca ; record 7
	dw $6e53 ; record 8
	dw $6ee0 ; record 9
	dw $6f73 ; record 10
	dw $7006 ; record 11
	dw $70a7 ; record 12
	dw $7148 ; record 13
	dw $71e5 ; record 14
	dw $727b ; record 15
	dw $7310 ; record 16
	dw $73b2 ; record 17
	dw $7449 ; record 18
	dw $74dc ; record 19
	dw $7555 ; record 20
	dw $7555 ; record 21
	dw $7555 ; record 22
	dw $75d3 ; record 23
	dw $766d ; record 24
	dw $7709 ; record 25
	dw $77a4 ; record 26
	dw $7846 ; record 27
	dw $78e4 ; record 28
	dw $796f ; record 29
	dw $7a14 ; record 30
	dw $7ab6 ; record 31
	dw $ffff ; record 32
	dw $8b00 ; record 33
	dw $9718 ; record 34
	dw $af30 ; record 35
	dw $ff20 ; record 36
	dw $60af ; record 37
	dw $40cf ; record 38
	dw $40ee ; record 39
	dw $41f5 ; record 40
	dw $ffff ; record 41
	dw $ff00 ; record 42
	dw $d71f ; record 43
	dw $ef10 ; record 44
	dw $bf20 ; record 45
	dw $27f3 ; record 46
	dw $3fbf ; record 47
	dw $ff7f ; record 48
	dw $e0ff ; record 49
	dw $ff00 ; record 50
	dw $9891 ; record 51
	dw $6c49 ; record 52
	dw $24b5 ; record 53
	dw $e6bd ; record 54
	dw $f3ff ; record 55
	dw $fbf2 ; record 56
	dw $fffa ; record 57
	dw $b3fe ; record 58
	dw $ff43 ; record 59
	dw $07b7 ; record 60
	dw $0ff7 ; record 61
	dw $0fff ; record 62
	dw $0fae ; record 63
	dw $aeff ; record 64
	dw $dc1f ; record 65
	dw $e47f ; record 66
	dw $fc7f ; record 67
	dw $ffff ; record 68
	dw $fff8 ; record 69
	dw $ffb0 ; record 70
	dw $ff60 ; record 71
	dw $fff0 ; record 72
	dw $38ff ; record 73
	dw $c4ff ; record 74
	dw $78ff ; record 75
	dw $ffff ; record 76
	dw $fffe ; record 77
	dw $fe3f ; record 78
	dw $fe1f ; record 79
	dw $fe0f ; record 80
	db $2f
	; $6a0b, 611 bytes (records:2)
; 305 records x 2 bytes
	dw $fffe ; record 0
	dw $fe7d ; record 1
	dw $fc8d ; record 2
	dw $fef7 ; record 3
	dw $7fc8 ; record 4
	dw $c4fd ; record 5
	dw $e0fe ; record 6
	dw $3fa0 ; record 7
	dw $1fdc ; record 8
	dw $03fa ; record 9
	dw $f39f ; record 10
	dw $ff07 ; record 11
	dw $6100 ; record 12
	dw $e09f ; record 13
	dw $e1fe ; record 14
	dw $fb18 ; record 15
	dw $06ff ; record 16
	dw $e095 ; record 17
	dw $00ff ; record 18
	dw $fe65 ; record 19
	dw $ffc5 ; record 20
	dw $45fe ; record 21
	dw $87fe ; record 22
	dw $09fe ; record 23
	dw $09fc ; record 24
	dw $f81f ; record 25
	dw $f031 ; record 26
	dw $00ff ; record 27
	dw $0000 ; record 28
	dw $ff00 ; record 29
	dw $00ff ; record 30
	dw $0783 ; record 31
	dw $1f8c ; record 32
	dw $3f90 ; record 33
	dw $a0ff ; record 34
	dw $a03f ; record 35
	dw $c07f ; record 36
	dw $c37f ; record 37
	dw $7f7f ; record 38
	dw $00ff ; record 39
	dw $ff09 ; record 40
	dw $ff04 ; record 41
	dw $fe02 ; record 42
	dw $ffe0 ; record 43
	dw $ff01 ; record 44
	dw $ff79 ; record 45
	dw $8fa7 ; record 46
	dw $00ff ; record 47
	dw $99ff ; record 48
	dw $65fc ; record 49
	dw $59fc ; record 50
	dw $a9f8 ; record 51
	dw $fffc ; record 52
	dw $fc45 ; record 53
	dw $fce5 ; record 54
	dw $be93 ; record 55
	dw $7ea4 ; record 56
	dw $a7ff ; record 57
	dw $cb7c ; record 58
	dw $8c7c ; record 59
	dw $8879 ; record 60
	dw $ff7a ; record 61
	dw $71d7 ; record 62
	dw $77fe ; record 63
	dw $13b6 ; record 64
	dw $01fd ; record 65
	dw $ffff ; record 66
	dw $ff00 ; record 67
	dw $0f00 ; record 68
	dw $cfe0 ; record 69
	dw $ff10 ; record 70
	dw $c0df ; record 71
	dw $e06f ; record 72
	dw $b0ee ; record 73
	dw $0e6b ; record 74
	dw $fbff ; record 75
	dw $f50e ; record 76
	dw $050e ; record 77
	dw $6f76 ; record 78
	dw $ff8e ; record 79
	dw $74bd ; record 80
	dw $de4d ; record 81
	dw $aaff ; record 82
	dw $3bf6 ; record 83
	dw $cfff ; record 84
	dw $f81b ; record 85
	dw $bb49 ; record 86
	dw $857c ; record 87
	dw $ff04 ; record 88
	dw $0782 ; record 89
	dw $0381 ; record 90
	dw $00ff ; record 91
	dw $d1df ; record 92
	dw $7fef ; record 93
	dw $eed1 ; record 94
	dw $ccf1 ; record 95
	dw $01e0 ; record 96
	dw $0ef9 ; record 97
	dw $b6ff ; record 98
	dw $ff84 ; record 99
	dw $6b00 ; record 100
	dw $35ee ; record 101
	dw $fff6 ; record 102
	dw $ecd9 ; record 103
	dw $88e9 ; record 104
	dw $1851 ; record 105
	dw $30a1 ; record 106
	dw $c10f ; record 107
	dw $ffe0 ; record 108
	dw $0000 ; record 109
	dw $0000 ; record 110
	dw $ffff ; record 111
	dw $ff00 ; record 112
	dw $bf7f ; record 113
	dw $9c7f ; record 114
	dw $ff3e ; record 115
	dw $1897 ; record 116
	dw $109f ; record 117
	dw $129a ; record 118
	dw $1797 ; record 119
	dw $f0ac ; record 120
	dw $ffe0 ; record 121
	dw $fee0 ; record 122
	dw $e800 ; record 123
	dw $00e0 ; record 124
	dw $e0fa ; record 125
	dw $ffff ; record 126
	dw $00ff ; record 127
	dw $fefd ; record 128
	dw $fcf9 ; record 129
	dw $f871 ; record 130
	dw $d1ff ; record 131
	dw $f130 ; record 132
	dw $b110 ; record 133
	dw $d190 ; record 134
	dw $ffd0 ; record 135
	dw $7fdf ; record 136
	dw $7fbb ; record 137
	dw $7d9d ; record 138
	dw $7adf ; record 139
	dw $ffdf ; record 140
	dw $df7b ; record 141
	dw $987f ; record 142
	dw $e0fe ; record 143
	dw $ff87 ; record 144
	dw $cfff ; record 145
	dw $a5ff ; record 146
	dw $cffd ; record 147
	dw $cffa ; record 148
	dw $fffb ; record 149
	dw $ffcf ; record 150
	dw $ff48 ; record 151
	dw $ff40 ; record 152
	dw $fef7 ; record 153
	dw $39ff ; record 154
	dw $b1fe ; record 155
	dw $f7fe ; record 156
	dw $fdfe ; record 157
	dw $fffe ; record 158
	dw $fef5 ; record 159
	dw $fe31 ; record 160
	dw $fe33 ; record 161
	dw $7ff8 ; record 162
	dw $98fb ; record 163
	dw $fe1f ; record 164
	dw $9ce3 ; record 165
	dw $9e1f ; record 166
	dw $ff1f ; record 167
	dw $00bf ; record 168
	dw $ff40 ; record 169
	dw $ff50 ; record 170
	dw $8b60 ; record 171
	dw $38e0 ; record 172
	dw $fffb ; record 173
	dw $9544 ; record 174
	dw $00e1 ; record 175
	dw $fe3d ; record 176
	dw $f031 ; record 177
	dw $fe7e ; record 178
	dw $71e3 ; record 179
	dw $f1f0 ; record 180
	dw $fff0 ; record 181
	dw $0000 ; record 182
	dw $0000 ; record 183
	dw $ffff ; record 184
	dw $8000 ; record 185
	dw $9f7f ; record 186
	dw $e67f ; record 187
	dw $ff73 ; record 188
	dw $07fc ; record 189
	dw $07f4 ; record 190
	dw $0ff9 ; record 191
	dw $7ffb ; record 192
	dw $ffff ; record 193
	dw $8800 ; record 194
	dw $10ff ; record 195
	dw $33ff ; record 196
	dw $ffff ; record 197
	dw $fe64 ; record 198
	dw $b8ab ; record 199
	dw $70d7 ; record 200
	dw $ffdf ; record 201
	dw $ffff ; record 202
	dw $0100 ; record 203
	dw $e1fe ; record 204
	dw $19fe ; record 205
	dw $ffbe ; record 206
	dw $06f5 ; record 207
	dw $06ff ; record 208
	dw $06fd ; record 209
	dw $e4cd ; record 210
	dw $94ff ; record 211
	dw $977e ; record 212
	dw $9b7c ; record 213
	dw $9e78 ; record 214
	dw $ff7a ; record 215
	dw $798b ; record 216
	dw $7f87 ; record 217
	dw $7d84 ; record 218
	dw $7e83 ; record 219
	dw $67ff ; record 220
	dw $a3f0 ; record 221
	dw $736c ; record 222
	dw $af74 ; record 223
	dw $ffa8 ; record 224
	dw $d0f7 ; record 225
	dw $e8ef ; record 226
	dw $e8be ; record 227
	dw $f9ff ; record 228
	dw $b5ff ; record 229
	dw $0b3e ; record 230
	dw $3bde ; record 231
	dw $a98e ; record 232
	dw $ff2e ; record 233
	dw $5e7d ; record 234
	dw $fee9 ; record 235
	dw $febd ; record 236
	dw $fed1 ; record 237
	dw $8aff ; record 238
	dw $897f ; record 239
	dw $847f ; record 240
	dw $877f ; record 241
	dw $ff7f ; record 242
	dw $7ec2 ; record 243
	dw $7fb1 ; record 244
	dw $1f8f ; record 245
	dw $00ff ; record 246
	dw $ffff ; record 247
	dw $7f01 ; record 248
	dw $bf00 ; record 249
	dw $fe80 ; record 250
	dw $ffc0 ; record 251
	dw $0de0 ; record 252
	dw $8630 ; record 253
	dw $e0ce ; record 254
	dw $00ff ; record 255
	dw $71ff ; record 256
	dw $f51e ; record 257
	dw $d59e ; record 258
	dw $e59e ; record 259
	dw $ff3e ; record 260
	dw $3ead ; record 261
	dw $7e57 ; record 262
	dw $f6e5 ; record 263
	dw $00ff ; record 264
	dw $0000 ; record 265
	dw $ff00 ; record 266
	dw $00ff ; record 267
	dw $0381 ; record 268
	dw $1f8f ; record 269
	dw $7fbf ; record 270
	dw $ff7d ; record 271
	dw $e2fe ; record 272
	dw $7ff8 ; record 273
	dw $00ff ; record 274
	dw $ffff ; record 275
	dw $fee8 ; record 276
	dw $e0f3 ; record 277
	dw $c100 ; record 278
	dw $f1e0 ; record 279
	dw $fdf8 ; record 280
	dw $fdfe ; record 281
	dw $feff ; record 282
	dw $0fe2 ; record 283
	dw $c0fe ; record 284
	dw $c07f ; record 285
	dw $ff7f ; record 286
	dw $7fc7 ; record 287
	dw $7efc ; record 288
	dw $38db ; record 289
	dw $18ef ; record 290
	dw $ffdf ; record 291
	dw $b748 ; record 292
	dw $0020 ; record 293
	dw $e3cf ; record 294
	dw $ff10 ; record 295
	dw $30ff ; record 296
	dw $30ff ; record 297
	dw $02fd ; record 298
	dw $03ff ; record 299
	dw $ff03 ; record 300
	dw $03fe ; record 301
	dw $fbfe ; record 302
	dw $e7fe ; record 303
	dw $fd4e ; record 304
	db $ff
	; $6c6e, 581 bytes (records:2)
; 290 records x 2 bytes
	dw $ffc6 ; record 0
	dw $fdc4 ; record 1
	dw $7b04 ; record 2
	dw $df02 ; record 3
	dw $dffe ; record 4
	dw $d7e0 ; record 5
	dw $eb10 ; record 6
	dw $8678 ; record 7
	dw $810e ; record 8
	dw $03e7 ; record 9
	dw $0782 ; record 10
	dw $e0a2 ; record 11
	dw $e3fe ; record 12
	dw $ff1f ; record 13
	dw $ef00 ; record 14
	dw $80bf ; record 15
	dw $f066 ; record 16
	dw $e092 ; record 17
	dw $7f82 ; record 18
	dw $ff82 ; record 19
	dw $02fb ; record 20
	dw $06fd ; record 21
	dw $0ce5 ; record 22
	dw $38b9 ; record 23
	dw $c10f ; record 24
	dw $ffe0 ; record 25
	dw $0000 ; record 26
	dw $0000 ; record 27
	dw $ffff ; record 28
	dw $8800 ; record 29
	dw $911f ; record 30
	dw $961f ; record 31
	dw $ff3e ; record 32
	dw $3cab ; record 33
	dw $30b7 ; record 34
	dw $60af ; record 35
	dw $60df ; record 36
	dw $ffff ; record 37
	dw $7100 ; record 38
	dw $8fff ; record 39
	dw $fcdf ; record 40
	dw $fb01 ; record 41
	dw $00ff ; record 42
	dw $e5fe ; record 43
	dw $fe85 ; record 44
	dw $fe43 ; record 45
	dw $ffc3 ; record 46
	dw $41fe ; record 47
	dw $c17e ; record 48
	dw $a17e ; record 49
	dw $a17e ; record 50
	dw $3eff ; record 51
	dw $4ce3 ; record 52
	dw $48b3 ; record 53
	dw $14ab ; record 54
	dw $fffb ; record 55
	dw $b354 ; record 56
	dw $af7c ; record 57
	dw $df3c ; record 58
	dw $bf3c ; record 59
	dw $dafe ; record 60
	dw $f0e0 ; record 61
	dw $f00e ; record 62
	dw $f305 ; record 63
	dw $df08 ; record 64
	dw $28ff ; record 65
	dw $1edc ; record 66
	dw $0ffb ; record 67
	dw $0ff7 ; record 68
	dw $ffe1 ; record 69
	dw $d13e ; record 70
	dw $711e ; record 71
	dw $291e ; record 72
	dw $6bde ; record 73
	dw $8eff ; record 74
	dw $8c7d ; record 75
	dw $087f ; record 76
	dw $02fb ; record 77
	dw $ffbf ; record 78
	dw $ff40 ; record 79
	dw $df40 ; record 80
	dw $bc40 ; record 81
	dw $ae61 ; record 82
	dw $21df ; record 83
	dw $3096 ; record 84
	dw $188b ; record 85
	dw $e5aa ; record 86
	dw $803f ; record 87
	dw $1fef ; record 88
	dw $3fe0 ; record 89
	dw $9c80 ; record 90
	dw $fde1 ; record 91
	dw $fb04 ; record 92
	dw $04ff ; record 93
	dw $00fd ; record 94
	dw $1eef ; record 95
	dw $1ed1 ; record 96
	dw $1fa7 ; record 97
	dw $493e ; record 98
	dw $ff7c ; record 99
	dw $0000 ; record 100
	dw $0000 ; record 101
	dw $ff7f ; record 102
	dw $8f00 ; record 103
	dw $bf1f ; record 104
	dw $ff7f ; record 105
	dw $e2fe ; record 106
	dw $fe7f ; record 107
	dw $f07f ; record 108
	dw $ff7f ; record 109
	dw $ff00 ; record 110
	dw $e4ff ; record 111
	dw $e0f9 ; record 112
	dw $e0f5 ; record 113
	dw $e0f3 ; record 114
	dw $fd00 ; record 115
	dw $fffe ; record 116
	dw $fffe ; record 117
	dw $fefd ; record 118
	dw $fcfd ; record 119
	dw $fc09 ; record 120
	dw $f809 ; record 121
	dw $09ff ; record 122
	dw $a0f8 ; record 123
	dw $a17f ; record 124
	dw $963f ; record 125
	dw $ff3e ; record 126
	dw $1c9b ; record 127
	dw $389f ; record 128
	dw $68af ; record 129
	dw $40d7 ; record 130
	dw $ffff ; record 131
	dw $0f50 ; record 132
	dw $f7ff ; record 133
	dw $fff1 ; record 134
	dw $fec0 ; record 135
	dw $e2d5 ; record 136
	dw $fb01 ; record 137
	dw $fde4 ; record 138
	dw $f906 ; record 139
	dw $fff8 ; record 140
	dw $8ce9 ; record 141
	dw $0efd ; record 142
	dw $0afb ; record 143
	dw $0aff ; record 144
	dw $ffff ; record 145
	dw $ffca ; record 146
	dw $fb0a ; record 147
	dw $ef0a ; record 148
	dw $ff48 ; record 149
	dw $40d7 ; record 150
	dw $64ab ; record 151
	dw $3293 ; record 152
	dw $1e8e ; record 153
	dw $812f ; record 154
	dw $8003 ; record 155
	dw $a201 ; record 156
	dw $02e0 ; record 157
	dw $e0fe ; record 158
	dw $e1a7 ; record 159
	dw $0edf ; record 160
	dw $007f ; record 161
	dw $80bf ; record 162
	dw $e0a2 ; record 163
	dw $f90e ; record 164
	dw $0cff ; record 165
	dw $08e9 ; record 166
	dw $18e9 ; record 167
	dw $10d1 ; record 168
	dw $1fa1 ; record 169
	dw $4130 ; record 170
	dw $ff60 ; record 171
	dw $0000 ; record 172
	dw $0000 ; record 173
	dw $ff5f ; record 174
	dw $a000 ; record 175
	dw $c07f ; record 176
	dw $e0fe ; record 177
	dw $fe80 ; record 178
	dw $efe4 ; record 179
	dw $00ff ; record 180
	dw $ff00 ; record 181
	dw $e5fe ; record 182
	dw $ff07 ; record 183
	dw $ff38 ; record 184
	dw $ffff ; record 185
	dw $2100 ; record 186
	dw $11f0 ; record 187
	dw $11f0 ; record 188
	dw $f8ff ; record 189
	dw $f809 ; record 190
	dw $fc09 ; record 191
	dw $fcf5 ; record 192
	dw $f70d ; record 193
	dw $fffc ; record 194
	dw $fe7f ; record 195
	dw $dae3 ; record 196
	dw $f766 ; record 197
	dw $ff52 ; record 198
	dw $48fd ; record 199
	dw $48f7 ; record 200
	dw $ffc0 ; record 201
	dw $fffe ; record 202
	dw $d9ff ; record 203
	dw $7fc3 ; record 204
	dw $dd80 ; record 205
	dw $ff1c ; record 206
	dw $fe32 ; record 207
	dw $e0d1 ; record 208
	dw $0338 ; record 209
	dw $01fe ; record 210
	dw $fffe ; record 211
	dw $fffe ; record 212
	dw $0ee9 ; record 213
	dw $06f5 ; record 214
	dw $3ed7 ; record 215
	dw $2cbd ; record 216
	dw $f5ff ; record 217
	dw $df74 ; record 218
	dw $f760 ; record 219
	dw $fb78 ; record 220
	dw $ff78 ; record 221
	dw $7cfd ; record 222
	dw $7ffe ; record 223
	dw $7fbb ; record 224
	dw $3fbe ; record 225
	dw $ffef ; record 226
	dw $d700 ; record 227
	dw $a130 ; record 228
	dw $18e4 ; record 229
	dw $81bd ; record 230
	dw $fefd ; record 231
	dw $e0a2 ; record 232
	dw $7cf9 ; record 233
	dw $68a9 ; record 234
	dw $18f1 ; record 235
	dw $e17f ; record 236
	dw $4130 ; record 237
	dw $8160 ; record 238
	dw $01c0 ; record 239
	dw $e085 ; record 240
	dw $0000 ; record 241
	dw $ff00 ; record 242
	dw $00ff ; record 243
	dw $1f90 ; record 244
	dw $1f90 ; record 245
	dw $1f88 ; record 246
	dw $88ff ; record 247
	dw $840f ; record 248
	dw $830f ; record 249
	dw $8407 ; record 250
	dw $ef0e ; record 251
	dw $00ff ; record 252
	dw $ff00 ; record 253
	dw $e1fe ; record 254
	dw $ff02 ; record 255
	dw $ff05 ; record 256
	dw $1aff ; record 257
	dw $e7f8 ; record 258
	dw $fff0 ; record 259
	dw $2100 ; record 260
	dw $e0ff ; record 261
	dw $f021 ; record 262
	dw $f011 ; record 263
	dw $fc19 ; record 264
	dw $ff2d ; record 265
	dw $dbe4 ; record 266
	dw $7fea ; record 267
	dw $8b52 ; record 268
	dw $9718 ; record 269
	dw $18ff ; record 270
	dw $309f ; record 271
	dw $30af ; record 272
	dw $20af ; record 273
	dw $9f93 ; record 274
	dw $8f38 ; record 275
	dw $8f1f ; record 276
	dw $d308 ; record 277
	dw $fce2 ; record 278
	dw $bfe4 ; record 279
	dw $c0ff ; record 280
	dw $00ff ; record 281
	dw $12fb ; record 282
	dw $06f5 ; record 283
	dw $fff9 ; record 284
	dw $f90e ; record 285
	dw $f70e ; record 286
	dw $f50e ; record 287
	dw $fb04 ; record 288
	dw $06ff ; record 289
	db $fb
	; $6eb3, 1484 bytes (records:2)
; 742 records x 2 bytes
	dw $bf02 ; record 0
	dw $bf3f ; record 1
	dw $df60 ; record 2
	dw $40ff ; record 3
	dw $40ff ; record 4
	dw $40df ; record 5
	dw $60bf ; record 6
	dw $f5af ; record 7
	dw $a570 ; record 8
	dw $ffe0 ; record 9
	dw $e9ce ; record 10
	dw $00ff ; record 11
	dw $82bb ; record 12
	dw $7bff ; record 13
	dw $f546 ; record 14
	dw $fb06 ; record 15
	dw $eb0e ; record 16
	dw $3f0e ; record 17
	dw $3ed5 ; record 18
	dw $3ea5 ; record 19
	dw $00ff ; record 20
	dw $0000 ; record 21
	dw $ff00 ; record 22
	dw $00ff ; record 23
	dw $0f84 ; record 24
	dw $1f88 ; record 25
	dw $7fb8 ; record 26
	dw $d0ff ; record 27
	dw $907f ; record 28
	dw $987f ; record 29
	dw $967f ; record 30
	dw $ef77 ; record 31
	dw $00ff ; record 32
	dw $ff00 ; record 33
	dw $e1fe ; record 34
	dw $ff02 ; record 35
	dw $ff0d ; record 36
	dw $37fd ; record 37
	dw $dff1 ; record 38
	dw $ffc1 ; record 39
	dw $1d00 ; record 40
	dw $feef ; record 41
	dw $fe03 ; record 42
	dw $fe01 ; record 43
	dw $ade6 ; record 44
	dw $af71 ; record 45
	dw $60ff ; record 46
	dw $60bf ; record 47
	dw $78a3 ; record 48
	dw $64bb ; record 49
	dw $ffff ; record 50
	dw $ed78 ; record 51
	dw $bf64 ; record 52
	dw $7f6e ; record 53
	dw $fe01 ; record 54
	dw $cffe ; record 55
	dw $c7e0 ; record 56
	dw $df18 ; record 57
	dw $fd20 ; record 58
	dw $ff1c ; record 59
	dw $2cff ; record 60
	dw $1cff ; record 61
	dw $fe01 ; record 62
	dw $fe81 ; record 63
	dw $ff9d ; record 64
	dw $6bfe ; record 65
	dw $bf72 ; record 66
	dw $f72a ; record 67
	dw $ef12 ; record 68
	dw $12ff ; record 69
	dw $02fb ; record 70
	dw $3eaf ; record 71
	dw $349c ; record 72
	dw $ff97 ; record 73
	dw $8f11 ; record 74
	dw $891a ; record 75
	dw $850b ; record 76
	dw $820c ; record 77
	dw $06dd ; record 78
	dw $e0a5 ; record 79
	dw $eb1c ; record 80
	dw $9f08 ; record 81
	dw $00e2 ; record 82
	dw $fdff ; record 83
	dw $c6e0 ; record 84
	dw $f5e1 ; record 85
	dw $f906 ; record 86
	dw $d71e ; record 87
	dw $ff1e ; record 88
	dw $3cb9 ; record 89
	dw $6041 ; record 90
	dw $c081 ; record 91
	dw $8081 ; record 92
	dw $ff03 ; record 93
	dw $0000 ; record 94
	dw $0000 ; record 95
	dw $ffff ; record 96
	dw $8a00 ; record 97
	dw $8b0e ; record 98
	dw $8b0e ; record 99
	dw $ff1e ; record 100
	dw $1f93 ; record 101
	dw $1f96 ; record 102
	dw $1c99 ; record 103
	dw $1897 ; record 104
	dw $ffff ; record 105
	dw $8100 ; record 106
	dw $86ff ; record 107
	dw $b9fe ; record 108
	dw $dffc ; record 109
	dw $e0cf ; record 110
	dw $007f ; record 111
	dw $feff ; record 112
	dw $0de2 ; record 113
	dw $fdfc ; record 114
	dw $fe85 ; record 115
	dw $43e0 ; record 116
	dw $a37e ; record 117
	dw $d33e ; record 118
	dw $ff3e ; record 119
	dw $1ed3 ; record 120
	dw $309f ; record 121
	dw $30af ; record 122
	dw $66e8 ; record 123
	dw $eeff ; record 124
	dw $fa21 ; record 125
	dw $ff22 ; record 126
	dw $bf65 ; record 127
	dw $fb23 ; record 128
	dw $23ff ; record 129
	dw $e1dc ; record 130
	dw $03f8 ; record 131
	dw $04f9 ; record 132
	dw $fffb ; record 133
	dw $ff03 ; record 134
	dw $ff05 ; record 135
	dw $ff03 ; record 136
	dw $eb03 ; record 137
	dw $1eff ; record 138
	dw $0eeb ; record 139
	dw $0efb ; record 140
	dw $0cfd ; record 141
	dw $7f7b ; record 142
	dw $f708 ; record 143
	dw $fd8a ; record 144
	dw $fb04 ; record 145
	dw $de04 ; record 146
	dw $ffe0 ; record 147
	dw $ff20 ; record 148
	dw $af60 ; record 149
	dw $9f20 ; record 150
	dw $9730 ; record 151
	dw $18d7 ; record 152
	dw $1c8d ; record 153
	dw $e0ae ; record 154
	dw $aa03 ; record 155
	dw $ffe3 ; record 156
	dw $ef00 ; record 157
	dw $0cef ; record 158
	dw $10f7 ; record 159
	dw $e39e ; record 160
	dw $06f7 ; record 161
	dw $fff9 ; record 162
	dw $e908 ; record 163
	dw $d108 ; record 164
	dw $a118 ; record 165
	dw $ff30 ; record 166
	dw $0001 ; record 167
	dw $0000 ; record 168
	dw $ff00 ; record 169
	dw $00ff ; record 170
	dw $1f8c ; record 171
	dw $7fb0 ; record 172
	dw $7fc1 ; record 173
	dw $81ff ; record 174
	dw $927f ; record 175
	dw $9a7f ; record 176
	dw $977e ; record 177
	dw $df76 ; record 178
	dw $00ff ; record 179
	dw $ff00 ; record 180
	dw $fe08 ; record 181
	dw $14e0 ; record 182
	dw $fff7 ; record 183
	dw $f39a ; record 184
	dw $616d ; record 185
	dw $20bf ; record 186
	dw $00ff ; record 187
	dw $07df ; record 188
	dw $03fe ; record 189
	dw $01fe ; record 190
	dw $e2fe ; record 191
	dw $fe81 ; record 192
	dw $41ff ; record 193
	dw $dbfe ; record 194
	dw $df72 ; record 195
	dw $bf70 ; record 196
	dw $ff60 ; record 197
	dw $26b1 ; record 198
	dw $21ac ; record 199
	dw $309f ; record 200
	dw $139b ; record 201
	dw $97ff ; record 202
	dw $fd15 ; record 203
	dw $f300 ; record 204
	dw $e704 ; record 205
	dw $ff08 ; record 206
	dw $10ef ; record 207
	dw $07f7 ; record 208
	dw $0bef ; record 209
	dw $80ff ; record 210
	dw $bfff ; record 211
	dw $a380 ; record 212
	dw $d53e ; record 213
	dw $eb3c ; record 214
	dw $ff08 ; record 215
	dw $0afd ; record 216
	dw $02fb ; record 217
	dw $04fb ; record 218
	dw $00ff ; record 219
	dw $bfff ; record 220
	dw $8f40 ; record 221
	dw $8b18 ; record 222
	dw $8708 ; record 223
	dw $ff0c ; record 224
	dw $0485 ; record 225
	dw $0383 ; record 226
	dw $0180 ; record 227
	dw $0080 ; record 228
	dw $ffff ; record 229
	dw $ff00 ; record 230
	dw $ff40 ; record 231
	dw $5f80 ; record 232
	dw $ffc0 ; record 233
	dw $20bf ; record 234
	dw $007f ; record 235
	dw $8cbf ; record 236
	dw $c05f ; record 237
	dw $ffff ; record 238
	dw $fb00 ; record 239
	dw $b542 ; record 240
	dw $7586 ; record 241
	dw $ff0c ; record 242
	dw $2cd9 ; record 243
	dw $28b9 ; record 244
	dw $68d9 ; record 245
	dw $4c5d ; record 246
	dw $ff03 ; record 247
	dw $0000 ; record 248
	dw $0000 ; record 249
	dw $ffff ; record 250
	dw $8500 ; record 251
	dw $8507 ; record 252
	dw $880f ; record 253
	dw $ff0f ; record 254
	dw $1f88 ; record 255
	dw $1f93 ; record 256
	dw $1e93 ; record 257
	dw $3c95 ; record 258
	dw $ff7f ; record 259
	dw $4b00 ; record 260
	dw $8cff ; record 261
	dw $00ff ; record 262
	dw $e0fe ; record 263
	dw $c0ef ; record 264
	dw $3fff ; record 265
	dw $f77f ; record 266
	dw $59e1 ; record 267
	dw $69f8 ; record 268
	dw $f8ff ; record 269
	dw $f809 ; record 270
	dw $f811 ; record 271
	dw $f0d1 ; record 272
	dw $ff31 ; record 273
	dw $d1b0 ; record 274
	dw $a710 ; record 275
	dw $a63c ; record 276
	dw $ab3c ; record 277
	dw $3fff ; record 278
	dw $38ab ; record 279
	dw $38ae ; record 280
	dw $39ad ; record 281
	dw $ffaf ; record 282
	dw $ee3b ; record 283
	dw $ff7b ; record 284
	dw $bf00 ; record 285
	dw $ef80 ; record 286
	dw $f0ff ; record 287
	dw $00ff ; record 288
	dw $c0df ; record 289
	dw $a06f ; record 290
	dw $ffdf ; record 291
	dw $7ed0 ; record 292
	dw $f1d1 ; record 293
	dw $a918 ; record 294
	dw $5938 ; record 295
	dw $ccff ; record 296
	dw $34d5 ; record 297
	dw $2cbd ; record 298
	dw $76f5 ; record 299
	dw $ffcb ; record 300
	dw $f77a ; record 301
	dw $b67a ; record 302
	dw $ff13 ; record 303
	dw $d771 ; record 304
	dw $10ff ; record 305
	dw $08ef ; record 306
	dw $08bb ; record 307
	dw $7cfd ; record 308
	dw $ff83 ; record 309
	dw $ff07 ; record 310
	dw $7f00 ; record 311
	dw $9ff1 ; record 312
	dw $ffc0 ; record 313
	dw $02ff ; record 314
	dw $01fd ; record 315
	dw $00ff ; record 316
	dw $07f7 ; record 317
	dw $fe7f ; record 318
	dw $e099 ; record 319
	dw $82bf ; record 320
	dw $42fb ; record 321
	dw $467d ; record 322
	dw $ffb7 ; record 323
	dw $f986 ; record 324
	dw $e90c ; record 325
	dw $b118 ; record 326
	dw $ff38 ; record 327
	dw $0001 ; record 328
	dw $0000 ; record 329
	dw $ff00 ; record 330
	dw $00ff ; record 331
	dw $3fa2 ; record 332
	dw $7fa2 ; record 333
	dw $7fc5 ; record 334
	dw $c6ff ; record 335
	dw $8b7e ; record 336
	dw $8f7c ; record 337
	dw $9678 ; record 338
	dw $ff7e ; record 339
	dw $00ff ; record 340
	dw $ff28 ; record 341
	dw $ff30 ; record 342
	dw $ffce ; record 343
	dw $f7df ; record 344
	dw $de31 ; record 345
	dw $ff00 ; record 346
	dw $e2fe ; record 347
	dw $f889 ; record 348
	dw $897f ; record 349
	dw $85fc ; record 350
	dw $85fc ; record 351
	dw $83fe ; record 352
	dw $e0fe ; record 353
	dw $41ff ; record 354
	dw $9ffe ; record 355
	dw $9d70 ; record 356
	dw $aa7e ; record 357
	dw $ff63 ; record 358
	dw $45df ; record 359
	dw $45fd ; record 360
	dw $43de ; record 361
	dw $62af ; record 362
	dw $bfff ; record 363
	dw $f73e ; record 364
	dw $ff0e ; record 365
	dw $de00 ; record 366
	dw $ff1f ; record 367
	dw $f1ed ; record 368
	dw $64be ; record 369
	dw $24ff ; record 370
	dw $20ee ; record 371
	dw $d5ff ; record 372
	dw $4111 ; record 373
	dw $c17e ; record 374
	dw $a17e ; record 375
	dw $ff7e ; record 376
	dw $be21 ; record 377
	dw $fed1 ; record 378
	dw $fef3 ; record 379
	dw $9ecd ; record 380
	dw $75ff ; record 381
	dw $a610 ; record 382
	dw $9d32 ; record 383
	dw $9b31 ; record 384
	dw $ff10 ; record 385
	dw $1897 ; record 386
	dw $188f ; record 387
	dw $088b ; record 388
	dw $0c85 ; record 389
	dw $ffff ; record 390
	dw $ee00 ; record 391
	dw $b50e ; record 392
	dw $ff80 ; record 393
	dw $ed00 ; record 394
	dw $a4fb ; record 395
	dw $f0e1 ; record 396
	dw $9efe ; record 397
	dw $ebe0 ; record 398
	dw $f512 ; record 399
	dw $06ff ; record 400
	dw $3cf9 ; record 401
	dw $20a1 ; record 402
	dw $60c1 ; record 403
	dw $1f41 ; record 404
	dw $8140 ; record 405
	dw $ffc0 ; record 406
	dw $0000 ; record 407
	dw $0000 ; record 408
	dw $ff7f ; record 409
	dw $d000 ; record 410
	dw $907f ; record 411
	dw $807f ; record 412
	dw $e4fe ; record 413
	dw $a0ff ; record 414
	dw $ff7f ; record 415
	dw $0000 ; record 416
	dw $00ff ; record 417
	dw $f5ff ; record 418
	dw $fe20 ; record 419
	dw $30e0 ; record 420
	dw $e0fe ; record 421
	dw $ef28 ; record 422
	dw $00ff ; record 423
	dw $035f ; record 424
	dw $13fe ; record 425
	dw $09fe ; record 426
	dw $e0fe ; record 427
	dw $fe05 ; record 428
	dw $f7e0 ; record 429
	dw $fe07 ; record 430
	dw $dca0 ; record 431
	dw $e0e0 ; record 432
	dw $b87f ; record 433
	dw $ff3f ; record 434
	dw $1fd7 ; record 435
	dw $49eb ; record 436
	dw $29b7 ; record 437
	dw $21df ; record 438
	dw $38ff ; record 439
	dw $34ef ; record 440
	dw $34ff ; record 441
	dw $2ce7 ; record 442
	dw $fff7 ; record 443
	dw $d7d7 ; record 444
	dw $d8ef ; record 445
	dw $e8af ; record 446
	dw $e8bf ; record 447
	dw $07fd ; record 448
	dw $e0d8 ; record 449
	dw $fc1d ; record 450
	dw $ece5 ; record 451
	dw $e47d ; record 452
	dw $ddff ; record 453
	dw $d574 ; record 454
	dw $fd74 ; record 455
	dw $ff7c ; record 456
	dw $ff01 ; record 457
	dw $41ee ; record 458
	dw $70b7 ; record 459
	dw $188f ; record 460
	dw $0c85 ; record 461
	dw $83ef ; record 462
	dw $8007 ; record 463
	dw $a501 ; record 464
	dw $e8e0 ; record 465
	dw $f8f7 ; record 466
	dw $9ffe ; record 467
	dw $00e0 ; record 468
	dw $0eff ; record 469
	dw $007f ; record 470
	dw $c7d3 ; record 471
	dw $ffff ; record 472
	dw $ed00 ; record 473
	dw $f574 ; record 474
	dw $f504 ; record 475
	dw $ff0c ; record 476
	dw $0ce9 ; record 477
	dw $18d1 ; record 478
	dw $7061 ; record 479
	dw $c081 ; record 480
	dw $ff03 ; record 481
	dw $0000 ; record 482
	dw $0000 ; record 483
	dw $ffff ; record 484
	dw $9800 ; record 485
	dw $a33f ; record 486
	dw $fd7f ; record 487
	dw $ff7d ; record 488
	dw $1396 ; record 489
	dw $379f ; record 490
	dw $30af ; record 491
	dw $20af ; record 492
	dw $ffff ; record 493
	dw $0000 ; record 494
	dw $87ff ; record 495
	dw $3aff ; record 496
	dw $bffd ; record 497
	dw $e0cf ; record 498
	dw $803f ; record 499
	dw $00ff ; record 500
	dw $e1fe ; record 501
	dw $ff79 ; record 502
	dw $fdfc ; record 503
	dw $fdfc ; record 504
	dw $7ffe ; record 505
	dw $7ffe ; record 506
	dw $7eff ; record 507
	dw $7eff ; record 508
	dw $7ebf ; record 509
	dw $20bf ; record 510
	dw $ffb3 ; record 511
	dw $a328 ; record 512
	dw $bf2c ; record 513
	dw $c07f ; record 514
	dw $ff7f ; record 515
	dw $fefc ; record 516
	dw $fae0 ; record 517
	dw $00e0 ; record 518
	dw $04e3 ; record 519
	dw $1ce3 ; record 520
	dw $fcff ; record 521
	dw $e0d5 ; record 522
	dw $e1ff ; record 523
	dw $ff00 ; record 524
	dw $3ebf ; record 525
	dw $3efd ; record 526
	dw $ffff ; record 527
	dw $fb3e ; record 528
	dw $15fc ; record 529
	dw $2dfa ; record 530
	dw $ffe4 ; record 531
	dw $ec37 ; record 532
	dw $e85b ; record 533
	dw $7fff ; record 534
	dw $62bf ; record 535
	dw $aeff ; record 536
	dw $ae22 ; record 537
	dw $9533 ; record 538
	dw $9731 ; record 539
	dw $b318 ; record 540
	dw $188b ; record 541
	dw $e2d9 ; record 542
	dw $e1aa ; record 543
	dw $bf40 ; record 544
	dw $e1a2 ; record 545
	dw $fff0 ; record 546
	dw $00ff ; record 547
	dw $c8b5 ; record 548
	dw $02fb ; record 549
	dw $0eed ; record 550
	dw $f1ff ; record 551
	dw $d118 ; record 552
	dw $d110 ; record 553
	dw $a130 ; record 554
	dw $0330 ; record 555
	dw $00ff ; record 556
	dw $0000 ; record 557
	dw $7f00 ; record 558
	dw $00ff ; record 559
	dw $7fc0 ; record 560
	dw $7fc0 ; record 561
	dw $fe80 ; record 562
	dw $ffe2 ; record 563
	dw $7f81 ; record 564
	dw $7f83 ; record 565
	dw $00ff ; record 566
	dw $ff00 ; record 567
	dw $01ff ; record 568
	dw $0eff ; record 569
	dw $33ff ; record 570
	dw $5ff8 ; record 571
	dw $ffe0 ; record 572
	dw $c85f ; record 573
	dw $f83f ; record 574
	dw $00ff ; record 575
	dw $fc45 ; record 576
	dw $a3ff ; record 577
	dw $53be ; record 578
	dw $e91e ; record 579
	dw $f90e ; record 580
	dw $ff0e ; record 581
	dw $06f5 ; record 582
	dw $06fd ; record 583
	dw $7e85 ; record 584
	dw $7cc5 ; record 585
	dw $cbff ; record 586
	dw $eb7c ; record 587
	dw $df78 ; record 588
	dw $ef38 ; record 589
	dw $ff48 ; record 590
	dw $61de ; record 591
	dw $21bf ; record 592
	dw $f88f ; record 593
	dw $7077 ; record 594
	dw $f3ff ; record 595
	dw $fb0c ; record 596
	dw $df04 ; record 597
	dw $6f18 ; record 598
	dw $ff68 ; record 599
	dw $e8ff ; record 600
	dw $68ff ; record 601
	dw $06fb ; record 602
	dw $02fb ; record 603
	dw $3fff ; record 604
	dw $7fc2 ; record 605
	dw $df82 ; record 606
	dw $abc2 ; record 607
	dw $ffb2 ; record 608
	dw $befb ; record 609
	dw $b6fd ; record 610
	dw $21df ; record 611
	dw $02be ; record 612
	dw $dfff ; record 613
	dw $bb60 ; record 614
	dw $8479 ; record 615
	dw $830d ; record 616
	dw $ff06 ; record 617
	dw $0382 ; record 618
	dw $00ff ; record 619
	dw $9877 ; record 620
	dw $f1ee ; record 621
	dw $ffff ; record 622
	dw $fa05 ; record 623
	dw $ff07 ; record 624
	dw $f080 ; record 625
	dw $ff07 ; record 626
	dw $1fef ; record 627
	dw $00ff ; record 628
	dw $cc7d ; record 629
	dw $74b5 ; record 630
	dw $f9ff ; record 631
	dw $e90c ; record 632
	dw $d108 ; record 633
	dw $e118 ; record 634
	dw $0f30 ; record 635
	dw $a061 ; record 636
	dw $00ff ; record 637
	dw $0000 ; record 638
	dw $ff00 ; record 639
	dw $00ff ; record 640
	dw $1c8b ; record 641
	dw $1b93 ; record 642
	dw $3f9c ; record 643
	dw $b0ff ; record 644
	dw $a03f ; record 645
	dw $a07f ; record 646
	dw $c07f ; record 647
	dw $ff7f ; record 648
	dw $00ff ; record 649
	dw $007f ; record 650
	dw $f8f2 ; record 651
	dw $ff0e ; record 652
	dw $01f7 ; record 653
	dw $00ff ; record 654
	dw $e2fe ; record 655
	dw $00ff ; record 656
	dw $3097 ; record 657
	dw $6bff ; record 658
	dw $e508 ; record 659
	dw $550c ; record 660
	dw $bb06 ; record 661
	dw $df86 ; record 662
	dw $c253 ; record 663
	dw $e24f ; record 664
	dw $dcc0 ; record 665
	dw $dce0 ; record 666
	dw $ff7f ; record 667
	dw $7fe0 ; record 668
	dw $7fcc ; record 669
	dw $7bd6 ; record 670
	dw $77a6 ; record 671
	dw $aeeb ; record 672
	dw $da37 ; record 673
	dw $1ee1 ; record 674
	dw $e0d2 ; record 675
	dw $ff1c ; record 676
	dw $ff0e ; record 677
	dw $1ee7 ; record 678
	dw $1eef ; record 679
	dw $3bef ; record 680
	dw $2be2 ; record 681
	dw $e6ff ; record 682
	dw $f62d ; record 683
	dw $fe1d ; record 684
	dw $fe13 ; record 685
	dw $fe0b ; record 686
	dw $e0fc ; record 687
	dw $fe13 ; record 688
	dw $379b ; record 689
	dw $3396 ; record 690
	dw $ef91 ; record 691
	dw $901f ; record 692
	dw $881f ; record 693
	dw $e0fe ; record 694
	dw $0f84 ; record 695
	dw $dfff ; record 696
	dw $1600 ; record 697
	dw $0ced ; record 698
	dw $a6e1 ; record 699
	dw $3fe2 ; record 700
	dw $ff40 ; record 701
	dw $405f ; record 702
	dw $ff9f ; record 703
	dw $0500 ; record 704
	dw $15fe ; record 705
	dw $fcff ; record 706
	dw $ec39 ; record 707
	dw $f831 ; record 708
	dw $e041 ; record 709
	dw $1f41 ; record 710
	dw $81c0 ; record 711
	dw $ff80 ; record 712
	dw $0000 ; record 713
	dw $0000 ; record 714
	dw $ffff ; record 715
	dw $9f00 ; record 716
	dw $9f1f ; record 717
	dw $9e1f ; record 718
	dw $ff1f ; record 719
	dw $1f88 ; record 720
	dw $1f90 ; record 721
	dw $1f91 ; record 722
	dw $1e9e ; record 723
	dw $ffd7 ; record 724
	dw $ff00 ; record 725
	dw $e0ff ; record 726
	dw $f907 ; record 727
	dw $00e0 ; record 728
	dw $ffff ; record 729
	dw $fff8 ; record 730
	dw $4fde ; record 731
	dw $00ff ; record 732
	dw $fcf9 ; record 733
	dw $fffb ; record 734
	dw $fefe ; record 735
	dw $3fe1 ; record 736
	dw $1ffe ; record 737
	dw $0dfe ; record 738
	dw $feff ; record 739
	dw $3195 ; record 740
	dw $20ae ; record 741
	; $747f, 168 bytes (records:2)
; 84 records x 2 bytes
	dw $20bf ; record 0
	dw $f7be ; record 1
	dw $dd7f ; record 2
	dw $dd41 ; record 3
	dw $00e2 ; record 4
	dw $9fb1 ; record 5
	dw $fff7 ; record 6
	dw $fe9f ; record 7
	dw $fffe ; record 8
	dw $ba00 ; record 9
	dw $7f86 ; record 10
	dw $7dff ; record 11
	dw $35df ; record 12
	dw $0def ; record 13
	dw $fc99 ; record 14
	dw $fffd ; record 15
	dw $ef66 ; record 16
	dw $f74a ; record 17
	dw $ff12 ; record 18
	dw $fb12 ; record 19
	dw $069f ; record 20
	dw $06f5 ; record 21
	dw $3efd ; record 22
	dw $e3da ; record 23
	dw $e3d4 ; record 24
	dw $ff9f ; record 25
	dw $ff40 ; record 26
	dw $f600 ; record 27
	dw $ff06 ; record 28
	dw $fa00 ; record 29
	dw $04ff ; record 30
	dw $03fb ; record 31
	dw $00ff ; record 32
	dw $01fc ; record 33
	dw $ffe7 ; record 34
	dw $ff0f ; record 35
	dw $6500 ; record 36
	dw $e53e ; record 37
	dw $e5be ; record 38
	dw $beff ; record 39
	dw $3e69 ; record 40
	dw $7ea9 ; record 41
	dw $fee9 ; record 42
	dw $0011 ; record 43
	dw $e0b8 ; record 44
	dw $0000 ; record 45
	dw $ef00 ; record 46
	dw $00ff ; record 47
	dw $7fff ; record 48
	dw $eafe ; record 49
	dw $fb00 ; record 50
	dw $eeff ; record 51
	dw $eaff ; record 52
	dw $ff00 ; record 53
	dw $fefe ; record 54
	dw $cfe9 ; record 55
	dw $c07f ; record 56
	dw $7fff ; record 57
	dw $3fa0 ; record 58
	dw $1fd0 ; record 59
	dw $5fff ; record 60
	dw $3fb7 ; record 61
	dw $de27 ; record 62
	dw $fb27 ; record 63
	dw $ff03 ; record 64
	dw $e1cd ; record 65
	dw $e2fe ; record 66
	dw $ffff ; record 67
	dw $e9ff ; record 68
	dw $f5ce ; record 69
	dw $fdc6 ; record 70
	dw $fffe ; record 71
	dw $fec1 ; record 72
	dw $fe01 ; record 73
	dw $fe07 ; record 74
	dw $fe3b ; record 75
	dw $fbff ; record 76
	dw $ddf2 ; record 77
	dw $fd74 ; record 78
	dw $ec7a ; record 79
	dw $ff61 ; record 80
	dw $309f ; record 81
	dw $188f ; record 82
	dw $0c85 ; record 83
	; $7527, 1576 bytes (bytes:4)
	db $83, $07, $ff, $80 ; 0x00
	db $01, $81, $03, $ff ; 0x04
	db $00, $fd, $fe, $ff ; 0x08
	db $f9, $02, $fd, $01 ; 0x0c
	db $ff, $00, $7f, $0e ; 0x10
	db $f7, $cd, $e1, $7e ; 0x14
	db $a2, $e0, $6b, $62 ; 0x18
	db $fd, $86, $ff, $79 ; 0x1c
	db $0c, $d1, $18, $61 ; 0x20
	db $70, $81, $c0, $01 ; 0x24
	db $01, $b7, $e0, $00 ; 0x28
	db $00, $00, $ff, $ff ; 0x2c
	db $00, $ff, $7f, $c0 ; 0x30
	db $7f, $c1, $7f, $ff ; 0x34
	db $c6, $7f, $c9, $7c ; 0x38
	db $d3, $78, $d7, $70 ; 0x3c
	db $dc, $f0, $e0, $fd ; 0x40
	db $e1, $ff, $00, $00 ; 0x44
	db $e6, $e0, $00, $7e ; 0x48
	db $fd, $7e, $e0, $e0 ; 0x4c
	db $fe, $03, $fe, $83 ; 0x50
	db $fe, $63, $ff, $fe ; 0x54
	db $93, $3e, $cb, $1e ; 0x58
	db $eb, $0e, $d7, $3f ; 0x5c
	db $70, $d6, $70, $d0 ; 0x60
	db $79, $cf, $cc, $e0 ; 0x64
	db $fe, $e3, $ff, $81 ; 0x68
	db $ff, $81, $ff, $9e ; 0x6c
	db $fe, $2f, $e0, $ff ; 0x70
	db $5f, $c0, $5e, $c0 ; 0x74
	db $5b, $c3, $42, $e7 ; 0x78
	db $fb, $eb, $0e, $fe ; 0x7c
	db $e1, $cb, $1e, $93 ; 0x80
	db $3e, $63, $66, $ca ; 0x84
	db $e0, $03, $fe, $d8 ; 0x88
	db $e5, $d0, $e1, $ff ; 0x8c
	db $7f, $ae, $e0, $7f ; 0x90
	db $ff, $99, $c3, $bd ; 0x94
	db $81, $99, $c3, $a7 ; 0x98
	db $e1, $f2, $99, $e1 ; 0x9c
	db $03, $a2, $e0, $fc ; 0xa0
	db $e5, $ff, $fe, $ff ; 0xa4
	db $00, $00, $00, $00 ; 0xa8
	db $ff, $ff, $00, $a1 ; 0xac
	db $3f, $a2, $7f, $c4 ; 0xb0
	db $7f, $fd, $c9, $fe ; 0xb4
	db $e0, $93, $7f, $96 ; 0xb8
	db $7d, $ff, $00, $ff ; 0xbc
	db $81, $ff, $00, $ff ; 0xc0
	db $c3, $ff, $ff, $ff ; 0xc4
	db $ef, $7e, $a5, $db ; 0xc8
	db $00, $f5, $e0, $00 ; 0xcc
	db $85, $fc, $df, $45 ; 0xd0
	db $fe, $23, $fe, $93 ; 0xd4
	db $fe, $e0, $c9, $fe ; 0xd8
	db $ff, $69, $be, $9a ; 0xdc
	db $78, $97, $79, $ff ; 0xe0
	db $71, $ff, $f7, $39 ; 0xe4
	db $db, $39, $fe, $5c ; 0xe8
	db $ef, $3c, $ff, $fb ; 0xec
	db $28, $db, $c3, $ff ; 0xf0
	db $24, $ff, $66, $fe ; 0xf4
	db $fe, $e0, $7e, $db ; 0xf8
	db $c3, $bd, $81, $ff ; 0xfc
	db $81, $ff, $59, $1e ; 0x100
	db $e9, $9e, $ff, $8e ; 0x104
	db $ef, $9c, $ff, $db ; 0x108
	db $9c, $7f, $3a, $f7 ; 0x10c
	db $3c, $df, $14, $ff ; 0x110
	db $bd, $06, $f7, $4f ; 0x114
	db $bf, $7f, $87, $07 ; 0x118
	db $ff, $83, $07, $82 ; 0x11c
	db $02, $81, $03, $ff ; 0x120
	db $00, $3b, $bd, $81 ; 0x124
	db $ce, $e0, $ff, $e7 ; 0x128
	db $e7, $c8, $e0, $a2 ; 0x12c
	db $e2, $ff, $bd, $60 ; 0x130
	db $ef, $f2, $fd, $fe ; 0x134
	db $e1, $e0, $ff, $c1 ; 0x138
	db $e0, $41, $40, $81 ; 0x13c
	db $c0, $ff, $00, $00 ; 0x140
	db $00, $00, $ff, $ff ; 0x144
	db $00, $88, $0f, $88 ; 0x148
	db $1f, $90, $1f, $ff ; 0x14c
	db $91, $1f, $f2, $7e ; 0x150
	db $d3, $1e, $ab, $4e ; 0x154
	db $ff, $ff, $00, $00 ; 0x158
	db $ff, $00, $ff, $e0 ; 0x15c
	db $ff, $ff, $50, $1f ; 0x160
	db $ef, $0f, $3f, $80 ; 0x164
	db $cf, $e0, $ff, $ff ; 0x168
	db $00, $81, $c0, $41 ; 0x16c
	db $c0, $61, $f0, $ff ; 0x170
	db $d1, $90, $79, $9c ; 0x174
	db $d5, $14, $ad, $34 ; 0x178
	db $ff, $db, $4e, $db ; 0x17c
	db $6e, $e6, $26, $dd ; 0x180
	db $17, $ff, $af, $17 ; 0x184
	db $f2, $48, $d7, $60 ; 0x188
	db $ff, $70, $ff, $7f ; 0x18c
	db $ff, $56, $46, $fb ; 0x190
	db $52, $bf, $3f, $ff ; 0x194
	db $4f, $60, $bf, $82 ; 0x198
	db $fd, $02, $ff, $00 ; 0x19c
	db $ff, $ed, $e4, $bd ; 0x1a0
	db $24, $ed, $a4, $f5 ; 0x1a4
	db $f4, $ff, $cf, $1e ; 0x1a8
	db $f5, $86, $7b, $86 ; 0x1ac
	db $fb, $02, $ff, $fe ; 0x1b0
	db $70, $b7, $71, $97 ; 0x1b4
	db $79, $9a, $78, $3f ; 0x1b8
	db $8b, $7c, $85, $7e ; 0x1bc
	db $83, $7f, $a5, $e0 ; 0x1c0
	db $a1, $e0, $ef, $7f ; 0x1c4
	db $00, $ff, $ff, $f8 ; 0x1c8
	db $e4, $00, $ff, $02 ; 0x1cc
	db $fb, $ff, $06, $fc ; 0x1d0
	db $e0, $fe, $fd, $06 ; 0x1d4
	db $e9, $0e, $0f, $d1 ; 0x1d8
	db $1e, $ff, $00, $00 ; 0x1dc
	db $00, $00, $ff, $ff ; 0x1e0
	db $00, $a4, $3d, $a9 ; 0x1e4
	db $3a, $a9, $3a, $ff ; 0x1e8
	db $a5, $3c, $ff, $7f ; 0x1ec
	db $80, $7f, $bf, $7f ; 0x1f0
	db $ff, $ff, $00, $08 ; 0x1f4
	db $cf, $58, $af, $d8 ; 0x1f8
	db $2f, $ff, $c8, $2f ; 0x1fc
	db $b0, $9f, $78, $ff ; 0x200
	db $06, $ff, $ff, $ff ; 0x204
	db $00, $09, $f8, $09 ; 0x208
	db $fc, $09, $fc, $fd ; 0x20c
	db $05, $fe, $e4, $dc ; 0x210
	db $7d, $9b, $7a, $cf ; 0x214
	db $7a, $ff, $b5, $70 ; 0x218
	db $9f, $10, $9f, $32 ; 0x21c
	db $bb, $7a, $ff, $df ; 0x220
	db $40, $e1, $ff, $58 ; 0x224
	db $5f, $bf, $8f, $ff ; 0x228
	db $ff, $88, $ff, $00 ; 0x22c
	db $ff, $80, $fe, $80 ; 0x230
	db $ff, $ff, $01, $07 ; 0x234
	db $fe, $85, $fe, $41 ; 0x238
	db $7e, $ff, $e1, $7e ; 0x23c
	db $61, $7e, $d1, $de ; 0x240
	db $b1, $9e, $ff, $69 ; 0x244
	db $4e, $ff, $40, $df ; 0x248
	db $40, $ae, $62, $ff ; 0x24c
	db $9d, $3c, $83, $03 ; 0x250
	db $80, $01, $81, $03 ; 0x254
	db $fc, $da, $e0, $fe ; 0x258
	db $e0, $fe, $00, $fd ; 0x25c
	db $01, $76, $06, $f7 ; 0x260
	db $fe, $ff, $99, $a2 ; 0x264
	db $e0, $e9, $4e, $fb ; 0x268
	db $1e, $bf, $bd, $3e ; 0x26c
	db $c1, $e0, $01, $00 ; 0x270
	db $fe, $e0, $80, $03 ; 0x274
	db $ff, $00, $00, $00 ; 0x278
	db $00, $ff, $ff, $00 ; 0x27c
	db $93, $1f, $95, $3c ; 0x280
	db $a9, $3a, $ff, $a8 ; 0x284
	db $3f, $aa, $3d, $af ; 0x288
	db $3f, $b0, $3f, $ff ; 0x28c
	db $ff, $00, $81, $ff ; 0x290
	db $40, $7f, $20, $bf ; 0x294
	db $ff, $20, $ff, $a0 ; 0x298
	db $7f, $fc, $ff, $03 ; 0x29c
	db $ff, $ff, $ff, $00 ; 0x2a0
	db $01, $80, $81, $c0 ; 0x2a4
	db $41, $e0, $df, $39 ; 0x2a8
	db $fc, $15, $fe, $03 ; 0x2ac
	db $fe, $e0, $cc, $7f ; 0x2b0
	db $ff, $9f, $7f, $9f ; 0x2b4
	db $72, $e6, $76, $9b ; 0x2b8
	db $1b, $bd, $8f, $fe ; 0x2bc
	db $e0, $9f, $17, $38 ; 0x2c0
	db $ff, $ff, $e0, $44 ; 0x2c4
	db $ff, $db, $18, $ef ; 0x2c8
	db $2d, $ff, $2d, $ff ; 0x2cc
	db $2c, $ff, $ef, $a4 ; 0x2d0
	db $83, $fe, $df, $7e ; 0x2d4
	db $6b, $72, $ff, $fd ; 0x2d8
	db $e0, $cb, $c8, $ff ; 0x2dc
	db $d0, $bd, $d8, $ff ; 0x2e0
	db $ff, $12, $bb, $38 ; 0x2e4
	db $b7, $30, $9f, $30 ; 0x2e8
	db $ff, $97, $10, $8b ; 0x2ec
	db $18, $87, $0f, $81 ; 0x2f0
	db $03, $ff, $ff, $00 ; 0x2f4
	db $db, $19, $ff, $03 ; 0x2f8
	db $f7, $17, $ff, $de ; 0x2fc
	db $1e, $bf, $3e, $fa ; 0x300
	db $f8, $fd, $f3, $ff ; 0x304
	db $ff, $00, $fd, $04 ; 0x308
	db $ef, $1e, $dd, $1e ; 0x30c
	db $ff, $f9, $3c, $c9 ; 0x310
	db $7c, $85, $fc, $85 ; 0x314
	db $fe, $03, $ff, $00 ; 0x318
	db $00, $00, $00, $ef ; 0x31c
	db $ff, $00, $88, $0f ; 0x320
	db $fe, $e4, $1f, $98 ; 0x324
	db $3f, $ff, $e0, $7f ; 0x328
	db $ff, $00, $19, $f4 ; 0x32c
	db $19, $f4, $ff, $13 ; 0x330
	db $f7, $0c, $ff, $08 ; 0x334
	db $ff, $10, $ff, $ff ; 0x338
	db $20, $ff, $ff, $00 ; 0x33c
	db $81, $80, $81, $80 ; 0x340
	db $ff, $c1, $e0, $31 ; 0x344
	db $f8, $09, $fc, $05 ; 0x348
	db $fc, $ff, $09, $fc ; 0x34c
	db $80, $7f, $84, $7f ; 0x350
	db $c2, $7f, $ff, $f9 ; 0x354
	db $7f, $f6, $0f, $b6 ; 0x358
	db $33, $ef, $0b, $ff ; 0x35c
	db $df, $49, $38, $ff ; 0x360
	db $5f, $df, $bf, $b5 ; 0x364
	db $ff, $ed, $99, $e6 ; 0x368
	db $ce, $71, $e0, $3f ; 0x36c
	db $f0, $ff, $3a, $d9 ; 0x370
	db $31, $f8, $c1, $e0 ; 0x374
	db $f1, $f8, $ff, $49 ; 0x378
	db $7c, $85, $fe, $83 ; 0x37c
	db $fe, $73, $7e, $ff ; 0x380
	db $ed, $fe, $bf, $64 ; 0x384
	db $9e, $10, $95, $11 ; 0x388
	db $ff, $8f, $1f, $87 ; 0x38c
	db $07, $8f, $1f, $93 ; 0x390
	db $3f, $ff, $ff, $00 ; 0x394
	db $ff, $1f, $ff, $17 ; 0x398
	db $7f, $95, $7f, $af ; 0x39c
	db $8d, $db, $c3, $f3 ; 0x3a0
	db $f8, $cf, $a2, $e0 ; 0x3a4
	db $ff, $f1, $d0, $f9 ; 0x3a8
	db $5c, $ed, $64, $bb ; 0x3ac
	db $86, $ff, $7d, $00 ; 0x3b0
	db $ff, $00, $bf, $80 ; 0x3b4
	db $ff, $00, $00, $00 ; 0x3b8
	db $00, $f7, $ff, $00 ; 0x3bc
	db $80, $fe, $e4, $87 ; 0x3c0
	db $0f, $98, $3f, $ff ; 0x3c4
	db $a0, $7f, $ff, $00 ; 0x3c8
	db $10, $1f, $00, $3f ; 0x3cc
	db $ff, $1d, $3f, $3f ; 0x3d0
	db $22, $bf, $e0, $7f ; 0x3d4
	db $ec, $ff, $1f, $fc ; 0x3d8
	db $ff, $00, $21, $f0 ; 0x3dc
	db $11, $f0, $ef, $d1 ; 0x3e0
	db $f8, $e9, $38, $fe ; 0x3e4
	db $e0, $78, $e9, $f8 ; 0x3e8
	db $df, $c0, $7f, $d2 ; 0x3ec
	db $7f, $80, $fe, $e8 ; 0x3f0
	db $0f, $fc, $df, $07 ; 0x3f4
	db $ff, $02, $ff, $00 ; 0x3f8
	db $fe, $e3, $fe, $01 ; 0x3fc
	db $bf, $fe, $e9, $fc ; 0x400
	db $e5, $fe, $03, $fe ; 0x404
	db $e0, $01, $7f, $fe ; 0x408
	db $71, $06, $f9, $02 ; 0x40c
	db $fd, $02, $d4, $e1 ; 0x410
	db $ff, $c0, $7f, $e0 ; 0x414
	db $7f, $98, $3f, $87 ; 0x418
	db $0f, $fd, $80, $d9 ; 0x41c
	db $e0, $01, $fe, $01 ; 0x420
	db $ff, $01, $ff, $ff ; 0x424
	db $06, $fe, $1b, $fc ; 0x428
	db $e7, $f0, $3b, $7c ; 0x42c
	db $ff, $ff, $00, $fd ; 0x430
	db $02, $ff, $02, $7b ; 0x434
	db $02, $ff, $f5, $86 ; 0x438
	db $e9, $18, $d1, $10 ; 0x43c
	db $d1, $30, $03, $ff ; 0x440
	db $00, $00, $00, $00 ; 0x444
	db $ff, $ff, $00, $f0 ; 0x448
	db $5f, $b0, $1f, $e9 ; 0x44c
	db $0f, $ff, $f7, $0f ; 0x450
	db $fd, $07, $b5, $07 ; 0x454
	db $fb, $4f, $ff, $ff ; 0x458
	db $00, $02, $fe, $7f ; 0x45c
	db $ff, $8f, $ff, $ff ; 0x460
	db $07, $ff, $83, $ff ; 0x464
	db $31, $ff, $ec, $ff ; 0x468
	db $ff, $ff, $00, $39 ; 0x46c
	db $28, $39, $ec, $d5 ; 0x470
	db $e4, $ff, $ed, $fe ; 0x474
	db $f3, $fe, $e3, $fe ; 0x478
	db $dd, $fe, $ff, $cb ; 0x47c
	db $5f, $b7, $7f, $cf ; 0x480
	db $7f, $fe, $7f, $ff ; 0x484
	db $fb, $7c, $ff, $78 ; 0x488
	db $f7, $78, $ff, $70 ; 0x48c
	db $ff, $da, $e7, $ff ; 0x490
	db $d3, $f7, $f3, $9f ; 0x494
	db $3f, $ff, $e8, $0d ; 0x498
	db $ff, $00, $bf, $40 ; 0x49c
	db $5f, $c0, $ff, $f7 ; 0x4a0
	db $e6, $fd, $d6, $fd ; 0x4a4
	db $fc, $93, $c6, $ff ; 0x4a8
	db $7d, $00, $ff, $36 ; 0x4ac
	db $ff, $14, $ff, $00 ; 0x4b0
	db $ff, $fe, $70, $b6 ; 0x4b4
	db $71, $d7, $79, $bb ; 0x4b8
	db $78, $ff, $dd, $3e ; 0x4bc
	db $be, $7e, $fb, $7d ; 0x4c0
	db $ff, $00, $ff, $ef ; 0x4c4
	db $f0, $f9, $fc, $f7 ; 0x4c8
	db $ff, $5b, $f3, $ff ; 0x4cc
	db $5e, $77, $bd, $3f ; 0x4d0
	db $4f, $1f, $ff, $00 ; 0x4d4
	db $ff, $f7, $00, $c9 ; 0x4d8
	db $1c, $ff, $fe, $1f ; 0x4dc
	db $fa, $ff, $0b, $fa ; 0x4e0
	db $fd, $fe, $25, $8c ; 0x4e4
	db $ff, $00, $00, $00 ; 0x4e8
	db $00, $ff, $ff, $00 ; 0x4ec
	db $84, $0f, $88, $1f ; 0x4f0
	db $f8, $7f, $ff, $90 ; 0x4f4
	db $7f, $80, $7f, $83 ; 0x4f8
	db $7f, $87, $7f, $ff ; 0x4fc
	db $ff, $00, $fd, $ed ; 0x500
	db $7f, $fb, $5f, $df ; 0x504
	db $bf, $60, $ff, $80 ; 0x508
	db $ff, $c1, $ff, $ff ; 0x50c
	db $e0, $00, $ff, $21 ; 0x510
	db $e0, $a1, $e0, $e1 ; 0x514
	db $e0, $3b, $f8, $ff ; 0x518
	db $0b, $f8, $c5, $fc ; 0x51c
	db $f5, $fe, $df, $7f ; 0x520
	db $ff, $e7, $7e, $cb ; 0x524
	db $7a, $cd, $7b, $f6 ; 0x528
	db $7d, $ff, $be, $3e ; 0x52c
	db $af, $7f, $db, $5b ; 0x530
	db $7f, $ee, $ff, $bf ; 0x534
	db $3b, $df, $9e, $e9 ; 0x538
	db $1f, $d0, $ff, $ff ; 0x53c
	db $e0, $3f, $e0, $ff ; 0x540
	db $f0, $ff, $b9, $3c ; 0x544
	db $ff, $d3, $38, $ad ; 0x548
	db $3a, $d7, $e6, $6f ; 0x54c
	db $ce, $ff, $3f, $fe ; 0x550
	db $3f, $fa, $6f, $ea ; 0x554
	db $ff, $48, $ff, $ff ; 0x558
	db $4d, $db, $63, $ad ; 0x55c
	db $61, $9b, $7c, $f7 ; 0x560
	db $9e, $7f, $9f, $a2 ; 0x564
	db $e0, $7c, $ff, $f7 ; 0x568
	db $1f, $df, $ff, $20 ; 0x56c
	db $fe, $e4, $bf, $96 ; 0x570
	db $e0, $bf, $80, $ff ; 0x574
	db $ff, $00, $ff, $ca ; 0x578
	db $ff, $b2, $bd, $26 ; 0x57c
	db $ff, $df, $ce, $7d ; 0x580
	db $1e, $df, $1e, $bf ; 0x584
	db $3e, $03, $ff, $00 ; 0x588
	db $00, $00, $00, $ff ; 0x58c
	db $ff, $00, $81, $01 ; 0x590
	db $8f, $1f, $91, $3f ; 0x594
	db $f7, $a0, $7f, $c0 ; 0x598
	db $fe, $e2, $ff, $00 ; 0x59c
	db $6e, $ff, $ff, $9b ; 0x5a0
	db $97, $ac, $8f, $50 ; 0x5a4
	db $df, $20, $ff, $fd ; 0x5a8
	db $00, $fe, $e0, $ff ; 0x5ac
	db $00, $c1, $c0, $e1 ; 0x5b0
	db $f0, $bf, $19, $fc ; 0x5b4
	db $05, $fe, $03, $fe ; 0x5b8
	db $fc, $e1, $82, $ff ; 0x5bc
	db $7f, $82, $7f, $85 ; 0x5c0
	db $7d, $8b, $78, $8b ; 0x5c4
	db $ff, $7b, $df, $7c ; 0x5c8
	db $87, $7d, $c7, $7d ; 0x5cc
	db $02, $ff, $ff, $06 ; 0x5d0
	db $ff, $99, $fd, $6f ; 0x5d4
	db $70, $7b, $ff, $03 ; 0x5d8
	db $ff, $84, $ff, $86 ; 0x5dc
	db $ff, $86, $01, $fd ; 0x5e0
	db $fe, $fe, $e1, $f1 ; 0x5e4
	db $fe, $61, $3e, $e5 ; 0x5e8
	db $fe, $ff, $e7, $be ; 0x5ec
	db $e7, $bc, $87, $7d ; 0x5f0
	db $a7, $7c, $ff, $c5 ; 0x5f4
	db $7c, $c3, $7e, $c2 ; 0x5f8
	db $7e, $87, $7d, $f9 ; 0x5fc
	db $84, $a2, $e0, $dc ; 0x600
	db $e0, $00, $7f, $40 ; 0x604
	db $ff, $00, $ff, $cf ; 0x608
	db $30, $4e, $10, $bd ; 0x60c
	db $83, $ff, $00, $ff ; 0x610
	db $ab, $3c, $c9, $78 ; 0x614
	db $4f, $7a, $95, $fe ; 0x618
	db $ff, $f9, $7e, $b5 ; 0x61c
	db $ee, $25, $fe, $ff ; 0x620
	db $00, $00, $00, $00 ; 0x624
	ds 1201, $ff ; $7b4f, fill
