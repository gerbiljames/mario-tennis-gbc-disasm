SECTION "ROM Bank $3f", ROMX[$4000], BANK[$3f]

FarPtr_3f_00:
	dw Func_3f_407a ; $4000
DataPtr_HardCourtLabelTiles:
	dw HardCourtLabelTiles ; $4002
DataPtr_ClayCourtLabelTiles:
	dw ClayCourtLabelTiles ; $4004
DataPtr_GrassCourtLabelTiles:
	dw GrassCourtLabelTiles ; $4006
DataPtr_CompositionCourtLabelTiles:
	dw CompositionCourtLabelTiles ; $4008
DataPtr_3f_0a:
	dw Lz_3f_5af5 ; $400a
DataPtr_3f_0c:
	dw Lz_3f_5bc7 ; $400c
DataPtr_3f_0e:
	dw Lz_3f_5ca5 ; $400e
DataPtr_3f_10:
	dw Lz_3f_5da0 ; $4010
DataPtr_3f_12:
	dw Lz_3f_5e92 ; $4012
DataPtr_3f_14:
	dw Lz_3f_5f7d ; $4014
DataPtr_3f_16:
	dw Lz_3f_6034 ; $4016
DataPtr_3f_18:
	dw Lz_3f_60cb ; $4018
DataPtr_3f_1a:
	dw Lz_3f_616f ; $401a
DataPtr_3f_1c:
	dw Lz_3f_6219 ; $401c
DataPtr_VarsityTeamChartTiles:
	dw VarsityTeamChartTiles ; $401e
DataPtr_VarsityTeamChartTilemap:
	dw VarsityTeamChartTilemap ; $4020
DataPtr_VarsityTeamChartAttrmap:
	dw VarsityTeamChartAttrmap ; $4022
DataPtr_VarsityTeamChartPalettes:
	dw VarsityTeamChartPalettes ; $4024
DataPtr_VarsityTeamChartTilemap2:
	dw VarsityTeamChartTilemap2 ; $4026
DataPtr_VarsityTeamChartAttrmap2:
	dw VarsityTeamChartAttrmap2 ; $4028
DataPtr_3f_2a:
	dw Lz_3f_6bdd ; $402a
DataPtr_MugshotTiles:
	dw MugshotTiles ; $402c
DataPtr_TournamentBracketTiles:
	dw TournamentBracketTiles ; $402e
DataPtr_3f_30:
	dw Lz_3f_74b3 ; $4030
DataPtr_3f_32:
	dw Lz_3f_74d2 ; $4032
DataPtr_3f_34:
	dw Lz_3f_75a4 ; $4034
DataPtr_3f_36:
	dw Lz_3f_7679 ; $4036
DataPtr_3f_38:
	dw Lz_3f_76c3 ; $4038
DataPtr_3f_3a:
	dw Lz_3f_770e ; $403a
DataPtr_3f_3c:
	dw Lz_3f_7757 ; $403c
DataPtr_3f_3e:
	dw Lz_3f_779d ; $403e
DataPtr_3f_40:
	dw Lz_3f_77e0 ; $4040
DataPtr_3f_42:
	dw Lz_3f_7826 ; $4042
DataPtr_3f_44:
	dw Lz_3f_7870 ; $4044
DataPtr_3f_46:
	dw Lz_3f_78ba ; $4046
DataPtr_3f_48:
	dw Lz_3f_7904 ; $4048
DataPtr_3f_4a:
	dw Lz_3f_794f ; $404a
DataPtr_3f_4c:
	dw Lz_3f_7998 ; $404c
DataPtr_3f_4e:
	dw Lz_3f_79db ; $404e
DataPtr_3f_50:
	dw Lz_3f_7a1d ; $4050
DataPtr_3f_52:
	dw Lz_3f_7a63 ; $4052
DataPtr_3f_54:
	dw Lz_3f_7aad ; $4054
DataPtr_Lz_3f_7af7:
	dw Lz_3f_7af7 ; $4056
DataPtr_Lz_3f_7af7Alias1:
	dw Lz_3f_7af7 ; $4058
DataPtr_Lz_3f_7af7Alias2:
	dw Lz_3f_7af7 ; $405a
DataPtr_Lz_3f_7af7Alias3:
	dw Lz_3f_7af7 ; $405c
DataPtr_Lz_3f_7af7Alias4:
	dw Lz_3f_7af7 ; $405e
DataPtr_Lz_3f_7af7Alias5:
	dw Lz_3f_7af7 ; $4060
DataPtr_Lz_3f_7af7Alias6:
	dw Lz_3f_7af7 ; $4062
DataPtr_Lz_3f_7af7Alias7:
	dw Lz_3f_7af7 ; $4064
DataPtr_Lz_3f_7af7Alias8:
	dw Lz_3f_7af7 ; $4066
DataPtr_Lz_3f_7af7Alias9:
	dw Lz_3f_7af7 ; $4068
DataPtr_Lz_3f_7af7Alias10:
	dw Lz_3f_7af7 ; $406a
DataPtr_Lz_3f_7af7Alias11:
	dw Lz_3f_7af7 ; $406c
DataPtr_Lz_3f_7af7Alias12:
	dw Lz_3f_7af7 ; $406e
DataPtr_Lz_3f_7af7Alias13:
	dw Lz_3f_7af7 ; $4070
DataPtr_Lz_3f_7af7Alias14:
	dw Lz_3f_7af7 ; $4072
DataPtr_Lz_3f_7af7Alias15:
	dw Lz_3f_7af7 ; $4074
DataPtr_Lz_3f_7af7Alias16:
	dw Lz_3f_7af7 ; $4076
	db $90 ; $4078
	db $7b ; $4079
Func_3f_407a:
	push af ; $407a
	wram_bank $06 ; $407b
	pop af ; $4081
	ld [$cb34], a ; $4082
	cp a, $00 ; $4085
	jr z, Label_3f_40a1 ; $4087
	cp a, $01 ; $4089
	jr z, Label_3f_40a5 ; $408b
	cp a, $02 ; $408d
	jr z, Label_3f_40a9 ; $408f
	cp a, $03 ; $4091
	jr z, Label_3f_40ad ; $4093
	cp a, $04 ; $4095
	jr z, Label_3f_40b1 ; $4097
	cp a, $05 ; $4099
	jr z, Label_3f_40b5 ; $409b
	ld a, $1f ; $409d
	jr Label_3f_40be ; $409f
Label_3f_40a1:
	ld a, $01 ; $40a1
	jr Label_3f_40be ; $40a3
Label_3f_40a5:
	ld a, $02 ; $40a5
	jr Label_3f_40be ; $40a7
Label_3f_40a9:
	ld a, $04 ; $40a9
	jr Label_3f_40be ; $40ab
Label_3f_40ad:
	ld a, $08 ; $40ad
	jr Label_3f_40be ; $40af
Label_3f_40b1:
	ld a, $10 ; $40b1
	jr Label_3f_40be ; $40b3
Label_3f_40b5:
	ld a, $01 ; $40b5
	ld [$cb33], a ; $40b7
	ld a, $1f ; $40ba
	jr Label_3f_40be ; $40bc
Label_3f_40be:
	ld [$cb32], a ; $40be
	xor a, a ; $40c1
	ld [$cb3a], a ; $40c2
	ld [$cb37], a ; $40c5
	ld [$cb2d], a ; $40c8
	ld [$cb2e], a ; $40cb
	ld [$cb3e], a ; $40ce
	ld a, $08 ; $40d1
	ld [$cb39], a ; $40d3
	ld a, $00 ; $40d6
	ld [$cb38], a ; $40d8
	ld a, $b4 ; $40db
	ld [$cb3d], a ; $40dd
	call Func_3f_42fe ; $40e0
	wram_bank $06 ; $40e3
	xor a, a ; $40e9
	ld [$cb33], a ; $40ea
	ld a, [$cb34] ; $40ed
	cp a, $06 ; $40f0
	jr z, Label_3f_4106 ; $40f2
	call AdvanceFrame ; $40f4
	call Func_3f_5261 ; $40f7
	ld a, [$cb34] ; $40fa
	cp a, $05 ; $40fd
	jr nz, Label_3f_4106 ; $40ff
	ld a, $01 ; $4101
	ld [$cb33], a ; $4103
Label_3f_4106:
	call DisableLCDSafely ; $4106
	farcall FarPtr_01_04 ; $4109
	call EnableLCD ; $410c
	sound $05 ; $410f
	call AdvanceFrame ; $4111
	ld c, $10 ; $4114
	call Func_00_1d2e ; $4116
	call Func_00_1da4 ; $4119
	ld a, $1d ; $411c
	ld hl, $4e8d ; $411e
	call RegisterFrameTask ; $4121
	wram_bank $06 ; $4124
	ld a, [$cb34] ; $412a
	cp a, $06 ; $412d
	jr nz, Label_3f_414a ; $412f
	wram_bank $06 ; $4131
	ld a, [$cb37] ; $4137
	res 0, a ; $413a
	ld [$cb37], a ; $413c
	call Func_3f_4e69 ; $413f
	call Func_00_2725 ; $4142
	db $01 ; $4145 inline arg
	ld a, $02 ; $4146
	jr Label_3f_4154 ; $4148
Label_3f_414a:
	ld a, [$cb37] ; $414a
	set 1, a ; $414d
	ld [$cb37], a ; $414f
	ld a, $08 ; $4152
Label_3f_4154:
	call AdvanceFrame ; $4154
	cp a, $04 ; $4157
	jp z, Label_3f_4170 ; $4159
	cp a, $10 ; $415c
	jp z, Label_3f_4175 ; $415e
	cp a, $08 ; $4161
	jp z, Label_3f_416b ; $4163
	call Func_3f_5588 ; $4166
	jr Label_3f_4178 ; $4169
Label_3f_416b:
	call Func_3f_55ff ; $416b
	jr Label_3f_4178 ; $416e
Label_3f_4170:
	call Func_3f_4194 ; $4170
	jr Label_3f_4178 ; $4173
Label_3f_4175:
	call Func_3f_41e0 ; $4175
Label_3f_4178:
	call Func_00_05f4 ; $4178
	cp a, $01 ; $417b
	jp nz, Label_3f_4154 ; $417d
	push af ; $4180
	ld c, $10 ; $4181
	call Func_00_1d20 ; $4183
	call Func_00_1da4 ; $4186
	pop af ; $4189
	call Func_3f_4244 ; $418a
	ld hl, $4e8d ; $418d
	call UnregisterFrameTask ; $4190
	ret ; $4193
Func_3f_4194:
	ld c, $10 ; $4194
	call Func_00_1d20 ; $4196
	call Func_00_1da4 ; $4199
	ld a, $0d ; $419c
	ld [$c321], a ; $419e
	xor a, a ; $41a1
	ld [$c320], a ; $41a2
	wram_bank $06 ; $41a5
	ld a, [$cb2e] ; $41ab
	ld b, a ; $41ae
	xor a, a ; $41af
	call Func_3f_54c8 ; $41b0
	farcall FarPtr_0a_70 ; $41b3
	call AdvanceFrame ; $41b6
	call DisableLCDSafely ; $41b9
	call Func_3f_425f ; $41bc
	ld a, $01 ; $41bf
	farcall FarPtr_0a_76 ; $41c1
	call EnableLCD ; $41c4
	call Func_3f_5417 ; $41c7
	call Func_3f_5261 ; $41ca
	ld a, [$cb37] ; $41cd
	set 1, a ; $41d0
	ld [$cb37], a ; $41d2
	ld c, $10 ; $41d5
	call Func_00_1d2e ; $41d7
	call Func_00_1da4 ; $41da
	ld a, $08 ; $41dd
	ret ; $41df
Func_3f_41e0:
	ld c, $10 ; $41e0
	call Func_00_1d20 ; $41e2
	call Func_00_1da4 ; $41e5
	ld a, $21 ; $41e8
	ld [$c321], a ; $41ea
	xor a, a ; $41ed
	ld [$c320], a ; $41ee
	call Func_3f_5468 ; $41f1
	ld a, [$cb2e] ; $41f4
	ld b, a ; $41f7
	ld a, $01 ; $41f8
	call Func_3f_54c8 ; $41fa
	farcall FarPtr_0a_70 ; $41fd
	call AdvanceFrame ; $4200
	call DisableLCDSafely ; $4203
	call Func_3f_42a0 ; $4206
	ld a, $01 ; $4209
	farcall FarPtr_0a_76 ; $420b
	call EnableLCD ; $420e
	wram_bank $06 ; $4211
	ld a, [$cb37] ; $4217
	res 1, a ; $421a
	ld [$cb37], a ; $421c
	ld c, $10 ; $421f
	call Func_00_1d2e ; $4221
	call Func_00_1da4 ; $4224
	ld a, $02 ; $4227
	ret ; $4229
	INCBIN "data/bank_03f/d_422a.bin" ; $422a, 26 bytes
Func_3f_4244:
	wram_bank $06 ; $4244
	xor a, a ; $424a
	ldh [$ff8b], a ; $424b
	ld [$c321], a ; $424d
	ld [$c320], a ; $4250
	ldh [$ff8a], a ; $4253
	ld hl, $c322 ; $4255
	ld [hl+], a ; $4258
	ld [hl+], a ; $4259
	ldh [$ffb9], a ; $425a
	ldh [$ffb8], a ; $425c
	ret ; $425e
Func_3f_425f:
	wram_bank $01 ; $425f
	ld hl, $3a02 ; $4265 -> DataPtr_TennisDictionaryListTiles
	ld de, $d000 ; $4268
	call DecompressDataFromBank ; $426b
	ld hl, $d000 ; $426e
	ld de, $b000 ; $4271
	ld c, $80 ; $4274
	call Func_00_0480 ; $4276
	ld hl, $d800 ; $4279
	ld de, $a800 ; $427c
	ld c, $80 ; $427f
	call Func_00_0480 ; $4281
	ld hl, $47f6 ; $4284
	ld de, $0008 ; $4287
	call Func_00_05e1 ; $428a
	wram_bank $02 ; $428d
	ld hl, $4541 ; $4293
	ld de, $d000 ; $4296
	call DecompressData ; $4299
	call Func_3f_42de ; $429c
	ret ; $429f
Func_3f_42a0:
	wram_bank $01 ; $42a0
	ld hl, $3a00 ; $42a6 -> DataPtr_TennisDictionaryTiles
	ld de, $d000 ; $42a9
	call DecompressDataFromBank ; $42ac
	ld hl, $d000 ; $42af
	ld de, $b000 ; $42b2
	ld c, $80 ; $42b5
	call Func_00_0480 ; $42b7
	ld hl, $d800 ; $42ba
	ld de, $a800 ; $42bd
	ld c, $80 ; $42c0
	call Func_00_0480 ; $42c2
	ld hl, $47ae ; $42c5
	ld de, $0008 ; $42c8
	call Func_00_05e1 ; $42cb
	wram_bank $02 ; $42ce
	ld hl, $44bf ; $42d4
	ld de, $d000 ; $42d7
	call DecompressData ; $42da
	ret ; $42dd
Func_3f_42de:
	wram_bank $02 ; $42de
	ld c, $0e ; $42e4
	ld hl, $4487 ; $42e6
Label_3f_42e9:
	push bc ; $42e9
	ld a, [hl+] ; $42ea
	ld e, a ; $42eb
	ld a, [hl+] ; $42ec
	ld d, a ; $42ed
	ld a, [hl+] ; $42ee
	ld c, a ; $42ef
	ld a, [hl+] ; $42f0
	ld b, a ; $42f1
	push hl ; $42f2
	ld h, d ; $42f3
	ld l, e ; $42f4
	call ClearBytes ; $42f5
	pop hl ; $42f8
	pop bc ; $42f9
	dec c ; $42fa
	jr nz, Label_3f_42e9 ; $42fb
	ret ; $42fd
Func_3f_42fe:
	wram_bank $06 ; $42fe
	ld a, [$cb34] ; $4304
	cp a, $06 ; $4307
	jr nz, Label_3f_430f ; $4309
	ld a, $21 ; $430b
	jr Label_3f_4311 ; $430d
Label_3f_430f:
	ld a, $0d ; $430f
Label_3f_4311:
	ldh [$ff8b], a ; $4311
	ld [$c321], a ; $4313
	xor a, a ; $4316
	ld [$c320], a ; $4317
	ldh [$ff8a], a ; $431a
	ld hl, $c322 ; $431c
	ld [hl+], a ; $431f
	ld [hl+], a ; $4320
	ldh [$ffb9], a ; $4321
	ldh [$ffb8], a ; $4323
	call DisableLCDSafely ; $4325
	call ClearFrameTasks ; $4328
	call Func_3f_50f7 ; $432b
	call Func_3f_511a ; $432e
	wram_bank $01 ; $4331
	ld hl, $483e ; $4337
	ld de, $d000 ; $433a
	call DecompressData ; $433d
	ld hl, $d000 ; $4340
	ld de, $8000 ; $4343
	ld c, $20 ; $4346
	call Func_00_0480 ; $4348
	ld hl, $495d ; $434b
	ld de, $d000 ; $434e
	call DecompressData ; $4351
	ld hl, $d000 ; $4354
	ld de, $8200 ; $4357
	ld c, $20 ; $435a
	call Func_00_0480 ; $435c
	ld hl, $4a9f ; $435f
	ld de, $d000 ; $4362
	call DecompressData ; $4365
	ld hl, $d000 ; $4368
	ld de, $8400 ; $436b
	ld c, $20 ; $436e
	call Func_00_0480 ; $4370
	ld hl, $4bd5 ; $4373
	ld de, $d000 ; $4376
	call DecompressData ; $4379
	ld hl, $d000 ; $437c
	ld de, $a000 ; $437f
	ld c, $20 ; $4382
	call Func_00_0480 ; $4384
	ld hl, $4c89 ; $4387
	ld de, $d000 ; $438a
	call DecompressData ; $438d
	ld hl, $d000 ; $4390
	ld de, $a200 ; $4393
	ld c, $20 ; $4396
	call Func_00_0480 ; $4398
	ld hl, $4d8b ; $439b
	ld de, $d000 ; $439e
	call DecompressData ; $43a1
	ld hl, $d000 ; $43a4
	ld de, $a400 ; $43a7
	ld c, $20 ; $43aa
	call Func_00_0480 ; $43ac
	ld hl, $4e39 ; $43af
	ld de, $0808 ; $43b2
	call Func_00_05e1 ; $43b5
	wram_bank $06 ; $43b8
	ld a, [$cb34] ; $43be
	cp a, $06 ; $43c1
	jr nz, Label_3f_43ca ; $43c3
	call Func_3f_42a0 ; $43c5
	jr Label_3f_43cd ; $43c8
Label_3f_43ca:
	call Func_3f_425f ; $43ca
Label_3f_43cd:
	wram_bank $03 ; $43cd
	ld hl, $459c ; $43d3
	ld de, $d000 ; $43d6
	call DecompressData ; $43d9
	wram_bank $03 ; $43dc
	ld c, $0e ; $43e2
	ld hl, $4487 ; $43e4
Label_3f_43e7:
	push bc ; $43e7
	ld a, [hl+] ; $43e8
	ld e, a ; $43e9
	ld a, [hl+] ; $43ea
	ld d, a ; $43eb
	ld a, [hl+] ; $43ec
	ld c, a ; $43ed
	ld a, [hl+] ; $43ee
	ld b, a ; $43ef
	push hl ; $43f0
	ld h, d ; $43f1
	ld l, e ; $43f2
	ld a, $20 ; $43f3
	call Func_3f_50ea ; $43f5
	pop hl ; $43f8
	pop bc ; $43f9
	dec c ; $43fa
	jr nz, Label_3f_43e7 ; $43fb
	wram_bank $06 ; $43fd
	ld a, [$cb34] ; $4403
	ld c, a ; $4406
	wram_bank $03 ; $4407
	inc c ; $440d
	ld b, $20 ; $440e
	xor a, a ; $4410
Label_3f_4411:
	add a, b ; $4411
	dec c ; $4412
	jr nz, Label_3f_4411 ; $4413
	ld c, $0b ; $4415
	ld hl, $d052 ; $4417
Label_3f_441a:
	ld [hl+], a ; $441a
	inc a ; $441b
	dec c ; $441c
	jr nz, Label_3f_441a ; $441d
	add a, $05 ; $441f
	ld c, $0b ; $4421
	ld hl, $d092 ; $4423
Label_3f_4426:
	ld [hl+], a ; $4426
	inc a ; $4427
	dec c ; $4428
	jr nz, Label_3f_4426 ; $4429
	wram_bank $06 ; $442b
	call EnableLCD ; $4431
	wram_bank $06 ; $4434
	farcall FarPtr_0a_70 ; $443a
	call DisableLCDSafely ; $443d
	wram_bank $03 ; $4440
	ld a, $01 ; $4446
	farcall FarPtr_0a_76 ; $4448
	call EnableLCD ; $444b
	ret ; $444e
	INCBIN "data/bank_03f/d_444f.bin" ; $444f, 2586 bytes
Func_3f_4e69:
	ld a, [$cb38] ; $4e69
	cp a, $03 ; $4e6c
	jr nc, Label_3f_4e7a ; $4e6e
	ld a, $04 ; $4e70
	ld [$cb38], a ; $4e72
	ld a, $ff ; $4e75
	ld [$cb3d], a ; $4e77
Label_3f_4e7a:
	ret ; $4e7a
Func_3f_4e7b:
	ld a, $b4 ; $4e7b
	ld [$cb3d], a ; $4e7d
	ldh a, [$ff8c] ; $4e80
	and a, $03 ; $4e82
	cp a, $03 ; $4e84
	jr nz, Label_3f_4e89 ; $4e86
	xor a, a ; $4e88
Label_3f_4e89:
	ld [$cb38], a ; $4e89
	ret ; $4e8c
	ldh a, [hWramBank] ; $4e8d
	push af ; $4e8f
	push af ; $4e90
	push bc ; $4e91
	push de ; $4e92
	push hl ; $4e93
	wram_bank $06 ; $4e94
	test_flag $03, 1 ; $4e9a
	jr z, Label_3f_4ea4 ; $4e9d
	sound $5f ; $4e9f
	call Func_3f_4e7b ; $4ea1
Label_3f_4ea4:
	ld a, [$cb38] ; $4ea4
	cp a, $04 ; $4ea7
	jr nz, Label_3f_4ebb ; $4ea9
	ld a, [$cb3d] ; $4eab
	dec a ; $4eae
	ld [$cb3d], a ; $4eaf
	jr nz, Label_3f_4ed4 ; $4eb2
	ld a, $03 ; $4eb4
	ld [$cb38], a ; $4eb6
	jr Label_3f_4ed4 ; $4eb9
Label_3f_4ebb:
	cp a, $03 ; $4ebb
	jr nz, Label_3f_4ec1 ; $4ebd
	jr Label_3f_4ed4 ; $4ebf
Label_3f_4ec1:
	ld a, [$cb3d] ; $4ec1
	dec a ; $4ec4
	ld [$cb3d], a ; $4ec5
	jr nz, Label_3f_4ed4 ; $4ec8
	ld a, $04 ; $4eca
	ld [$cb38], a ; $4ecc
	ld a, $ff ; $4ecf
	ld [$cb3d], a ; $4ed1
Label_3f_4ed4:
	ld a, [$cb34] ; $4ed4
	cp a, $06 ; $4ed7
	jp nz, Label_3f_4f85 ; $4ed9
	ld a, [$cb39] ; $4edc
	dec a ; $4edf
	ld [$cb39], a ; $4ee0
	jr nz, Label_3f_4ef6 ; $4ee3
	ld a, $08 ; $4ee5
	ld [$cb39], a ; $4ee7
	ld a, [$cb3a] ; $4eea
	inc a ; $4eed
	cp a, $10 ; $4eee
	jr nz, Label_3f_4ef3 ; $4ef0
	xor a, a ; $4ef2
Label_3f_4ef3:
	ld [$cb3a], a ; $4ef3
Label_3f_4ef6:
	ld hl, $5028 ; $4ef6
	ld a, [$cb38] ; $4ef9
	add a, a ; $4efc
	add a, a ; $4efd
	add a, a ; $4efe
	add a, a ; $4eff
	add a, l ; $4f00
	ld l, a ; $4f01
	jr nc, Label_3f_4f05 ; $4f02
	inc h ; $4f04
Label_3f_4f05:
	ld a, [$cb3a] ; $4f05
	add a, l ; $4f08
	ld l, a ; $4f09
	jr nc, Label_3f_4f0d ; $4f0a
	inc h ; $4f0c
Label_3f_4f0d:
	ld a, [hl] ; $4f0d
	add a, a ; $4f0e
	add a, a ; $4f0f
	add a, a ; $4f10
	push af ; $4f11
	pop af ; $4f12
	ld hl, $5078 ; $4f13
	add a, l ; $4f16
	ld l, a ; $4f17
	jr nc, Label_3f_4f1b ; $4f18
	inc h ; $4f1a
Label_3f_4f1b:
	ld a, [hl+] ; $4f1b
	ld c, a ; $4f1c
	ld a, [hl+] ; $4f1d
	ld b, a ; $4f1e
	ld a, [$cb37] ; $4f1f
	bit 1, a ; $4f22
	jr z, Label_3f_4f2b ; $4f24
	ld de, $907d ; $4f26
	jr Label_3f_4f2e ; $4f29
Label_3f_4f2b:
	ld de, $807d ; $4f2b
Label_3f_4f2e:
	push hl ; $4f2e
	ld hl, $50d0 ; $4f2f
	call QueueSpriteTemplate ; $4f32
	pop hl ; $4f35
	ld a, [hl+] ; $4f36
	ld c, a ; $4f37
	ld a, [hl+] ; $4f38
	ld b, a ; $4f39
	ld a, [$cb37] ; $4f3a
	bit 1, a ; $4f3d
	jr z, Label_3f_4f46 ; $4f3f
	ld de, $886d ; $4f41
	jr Label_3f_4f49 ; $4f44
Label_3f_4f46:
	ld de, $786d ; $4f46
Label_3f_4f49:
	push hl ; $4f49
	ld hl, $50d9 ; $4f4a
	call QueueSpriteTemplate ; $4f4d
	pop hl ; $4f50
	ld a, [hl+] ; $4f51
	ld c, a ; $4f52
	ld a, [hl+] ; $4f53
	ld b, a ; $4f54
	ld a, [$cb37] ; $4f55
	bit 1, a ; $4f58
	jr z, Label_3f_4f61 ; $4f5a
	ld de, $887d ; $4f5c
	jr Label_3f_4f64 ; $4f5f
Label_3f_4f61:
	ld de, $787d ; $4f61
Label_3f_4f64:
	push hl ; $4f64
	ld hl, $50d9 ; $4f65
	call QueueSpriteTemplate ; $4f68
	pop hl ; $4f6b
	ld a, [hl+] ; $4f6c
	ld c, a ; $4f6d
	ld a, [hl+] ; $4f6e
	ld b, a ; $4f6f
	ld a, [$cb37] ; $4f70
	bit 1, a ; $4f73
	jr z, Label_3f_4f7c ; $4f75
	ld de, $888d ; $4f77
	jr Label_3f_4f7f ; $4f7a
Label_3f_4f7c:
	ld de, $788d ; $4f7c
Label_3f_4f7f:
	ld hl, $50d9 ; $4f7f
	call QueueSpriteTemplate ; $4f82
Label_3f_4f85:
	ld a, [$cb37] ; $4f85
	bit 1, a ; $4f88
	jr z, Label_3f_4fec ; $4f8a
	ld a, [$cb37] ; $4f8c
	bit 0, a ; $4f8f
	jr nz, Label_3f_4f9a ; $4f91
	ld a, [$cb3e] ; $4f93
	inc a ; $4f96
	ld [$cb3e], a ; $4f97
Label_3f_4f9a:
	ld a, [$cb2e] ; $4f9a
	ld b, a ; $4f9d
	inc b ; $4f9e
	ld a, $14 ; $4f9f
	ld e, $10 ; $4fa1
	sub a, e ; $4fa3
Label_3f_4fa4:
	add a, e ; $4fa4
	dec b ; $4fa5
	jr nz, Label_3f_4fa4 ; $4fa6
	add a, e ; $4fa8
	add a, $14 ; $4fa9
	ld e, a ; $4fab
	ld hl, $4ff6 ; $4fac
	ld a, [$cb3e] ; $4faf
	and a, $0f ; $4fb2
	add a, l ; $4fb4
	ld l, a ; $4fb5
	jr nc, Label_3f_4fb9 ; $4fb6
	inc h ; $4fb8
Label_3f_4fb9:
	ld a, [hl] ; $4fb9
	add a, $0a ; $4fba
	ld d, a ; $4fbc
	ld hl, $501f ; $4fbd
	ld bc, $0b28 ; $4fc0
	call QueueSpriteTemplate ; $4fc3
	ld a, [$cb37] ; $4fc6
	bit 2, a ; $4fc9
	jr z, Label_3f_4fd9 ; $4fcb
	ld hl, $5006 ; $4fcd
	ld de, $1810 ; $4fd0
	ld bc, $0d34 ; $4fd3
	call QueueSpriteTemplate ; $4fd6
Label_3f_4fd9:
	ld a, [$cb37] ; $4fd9
	bit 3, a ; $4fdc
	jr z, Label_3f_4fec ; $4fde
	ld hl, $5006 ; $4fe0
	ld de, $8810 ; $4fe3
	ld bc, $0d3a ; $4fe6
	call QueueSpriteTemplate ; $4fe9
Label_3f_4fec:
	pop hl ; $4fec
	pop de ; $4fed
	pop bc ; $4fee
	pop af ; $4fef
	pop af ; $4ff0
	wram_bank ; $4ff1
	ret ; $4ff5
	INCBIN "data/bank_03f/d_4ff6.bin" ; $4ff6, 244 bytes
Func_3f_50ea:
	push af ; $50ea
	push bc ; $50eb
	push de ; $50ec
	push hl ; $50ed
Label_3f_50ee:
	ld [hl+], a ; $50ee
	dec c ; $50ef
	jr nz, Label_3f_50ee ; $50f0
	pop hl ; $50f2
	pop de ; $50f3
	pop bc ; $50f4
	pop af ; $50f5
	ret ; $50f6
Func_3f_50f7:
	wram_bank $06 ; $50f7
	ld hl, $539e ; $50fd
	ld c, $00 ; $5100
	ld a, [$cb32] ; $5102
	ld d, a ; $5105
Label_3f_5106:
	ld a, [hl+] ; $5106
	cp a, $00 ; $5107
	jr z, Label_3f_5106 ; $5109
	cp a, $40 ; $510b
	jr z, Label_3f_5115 ; $510d
	and a, d ; $510f
	jr z, Label_3f_5106 ; $5110
	inc c ; $5112
	jr Label_3f_5106 ; $5113
Label_3f_5115:
	ld a, c ; $5115
	ld [$cb2f], a ; $5116
	ret ; $5119
Func_3f_511a:
	wram_bank $06 ; $511a
	ld hl, $539e ; $5120
	ld c, $00 ; $5123
Label_3f_5125:
	ld a, [hl+] ; $5125
	cp a, $40 ; $5126
	jr nz, Label_3f_5125 ; $5128
	dec hl ; $512a
	ld a, h ; $512b
	ld [$cb30], a ; $512c
	ld a, l ; $512f
	ld [$cb31], a ; $5130
	ret ; $5133
Func_3f_5134:
	ld d, $00 ; $5134
	ld c, a ; $5136
	inc c ; $5137
	ld hl, $539e ; $5138
Label_3f_513b:
	ld a, [hl+] ; $513b
	cp a, $00 ; $513c
	jr z, Label_3f_513b ; $513e
	inc d ; $5140
	and a, b ; $5141
	jr z, Label_3f_513b ; $5142
	dec c ; $5144
	jr nz, Label_3f_513b ; $5145
	dec d ; $5147
	ld a, d ; $5148
	ret ; $5149
Func_3f_514a:
	ld d, $00 ; $514a
	ld c, a ; $514c
	inc c ; $514d
	ld hl, $539e ; $514e
Label_3f_5151:
	ld a, [hl+] ; $5151
	cp a, $00 ; $5152
	jr z, Label_3f_5151 ; $5154
	inc d ; $5156
	and a, b ; $5157
	jr z, Label_3f_5151 ; $5158
	dec c ; $515a
	jr nz, Label_3f_5151 ; $515b
	cp a, $01 ; $515d
	jr z, Label_3f_5170 ; $515f
	cp a, $02 ; $5161
	jr z, Label_3f_5172 ; $5163
	cp a, $04 ; $5165
	jr z, Label_3f_5175 ; $5167
	cp a, $08 ; $5169
	jr z, Label_3f_5178 ; $516b
	ld a, $04 ; $516d
	ret ; $516f
Label_3f_5170:
	xor a, a ; $5170
	ret ; $5171
Label_3f_5172:
	ld a, $01 ; $5172
	ret ; $5174
Label_3f_5175:
	ld a, $02 ; $5175
	ret ; $5177
Label_3f_5178:
	ld a, $03 ; $5178
	ret ; $517a
Func_3f_517b:
	wram_bank $06 ; $517b
	ld a, [$cb2f] ; $5181
	ld d, a ; $5184
	ld a, [$cb2e] ; $5185
	ld c, a ; $5188
	ld a, [$cb2d] ; $5189
	add a, c ; $518c
	cp a, d ; $518d
	jr c, Label_3f_5191 ; $518e
	sub a, d ; $5190
Label_3f_5191:
	ret ; $5191
Func_3f_5192:
	wram_bank $06 ; $5192
	ld hl, $539e ; $5198
	call Func_3f_517b ; $519b
	ld b, a ; $519e
	ld c, a ; $519f
	inc b ; $51a0
	xor a, a ; $51a1
	ld [$cb2e], a ; $51a2
	ld a, [$cb32] ; $51a5
	ld e, a ; $51a8
	jr Label_3f_51bc ; $51a9
Func_3f_51ab:
	push af ; $51ab
	ld a, [$cb2f] ; $51ac
	dec a ; $51af
	ld c, a ; $51b0
	ld a, [$cb30] ; $51b1
	ld h, a ; $51b4
	ld a, [$cb31] ; $51b5
	ld l, a ; $51b8
	dec hl ; $51b9
	pop af ; $51ba
	ret ; $51bb
Label_3f_51bc:
	ld a, [hl+] ; $51bc
	and a, e ; $51bd
	jr z, Label_3f_51bc ; $51be
	dec b ; $51c0
	jr nz, Label_3f_51bc ; $51c1
	dec hl ; $51c3
Label_3f_51c4:
	ld a, [hl-] ; $51c4
	ld d, a ; $51c5
	and a, e ; $51c6
	jr z, Label_3f_51ca ; $51c7
	dec c ; $51c9
Label_3f_51ca:
	ld a, d ; $51ca
	cp a, $40 ; $51cb
	jr z, Label_3f_51d5 ; $51cd
	cp a, $00 ; $51cf
	jr nz, Label_3f_51c4 ; $51d1
	jr Label_3f_51d8 ; $51d3
Label_3f_51d5:
	call Func_3f_51ab ; $51d5
Label_3f_51d8:
	ld a, [hl-] ; $51d8
	cp a, $40 ; $51d9
	jr nz, Label_3f_51e0 ; $51db
	call Func_3f_51ab ; $51dd
Label_3f_51e0:
	and a, e ; $51e0
	jr z, Label_3f_51d8 ; $51e1
	dec c ; $51e3
Label_3f_51e4:
	ld a, [hl-] ; $51e4
	ld d, a ; $51e5
	and a, e ; $51e6
	jr z, Label_3f_51ea ; $51e7
	dec c ; $51e9
Label_3f_51ea:
	ld a, d ; $51ea
	cp a, $40 ; $51eb
	jr z, Label_3f_51f7 ; $51ed
	cp a, $00 ; $51ef
	jr nz, Label_3f_51e4 ; $51f1
	inc hl ; $51f3
	inc c ; $51f4
	jr Label_3f_51fb ; $51f5
Label_3f_51f7:
	call Func_3f_51ab ; $51f7
	inc hl ; $51fa
Label_3f_51fb:
	ld a, [hl+] ; $51fb
	cp a, $40 ; $51fc
	jr nz, Label_3f_5207 ; $51fe
	ld c, $00 ; $5200
	ld hl, $539e ; $5202
	jr Label_3f_51fb ; $5205
Label_3f_5207:
	and a, e ; $5207
	jr z, Label_3f_51fb ; $5208
	ld a, c ; $520a
	ld [$cb2d], a ; $520b
	ret ; $520e
Func_3f_520f:
	wram_bank $06 ; $520f
	ld hl, $539e ; $5215
	ld a, [$cb2f] ; $5218
	ld b, a ; $521b
	ld a, [$cb2e] ; $521c
	ld c, a ; $521f
	ld a, [$cb2d] ; $5220
	add a, c ; $5223
	cp a, b ; $5224
	jr c, Label_3f_5228 ; $5225
	sub a, b ; $5227
Label_3f_5228:
	ld b, a ; $5228
	ld d, a ; $5229
	inc b ; $522a
	xor a, a ; $522b
	ld [$cb2e], a ; $522c
	ld a, [$cb32] ; $522f
	ld e, a ; $5232
Label_3f_5233:
	ld a, [hl+] ; $5233
	and a, e ; $5234
	jr z, Label_3f_5233 ; $5235
	dec b ; $5237
	jr nz, Label_3f_5233 ; $5238
Label_3f_523a:
	ld a, [hl+] ; $523a
	cp a, $00 ; $523b
	jr z, Label_3f_524e ; $523d
	ld c, a ; $523f
	and a, e ; $5240
	jr z, Label_3f_5244 ; $5241
	inc d ; $5243
Label_3f_5244:
	ld a, c ; $5244
	cp a, $40 ; $5245
	jr nz, Label_3f_523a ; $5247
	ld hl, $539e ; $5249
	ld d, $ff ; $524c
Label_3f_524e:
	inc d ; $524e
Label_3f_524f:
	ld a, [hl+] ; $524f
	cp a, $40 ; $5250
	jr nz, Label_3f_5259 ; $5252
	ld hl, $539e ; $5254
	ld d, $00 ; $5257
Label_3f_5259:
	and a, e ; $5259
	jr z, Label_3f_524f ; $525a
	ld a, d ; $525c
	ld [$cb2d], a ; $525d
	ret ; $5260
Func_3f_5261:
	farcall FarPtr_05_8c ; $5261
	wram_bank $03 ; $5264
	ld c, $0e ; $526a
	ld hl, $4487 ; $526c
Label_3f_526f:
	push bc ; $526f
	ld a, [hl+] ; $5270
	ld e, a ; $5271
	ld a, [hl+] ; $5272
	ld d, a ; $5273
	ld a, [hl+] ; $5274
	ld c, a ; $5275
	ld a, [hl+] ; $5276
	ld b, a ; $5277
	push hl ; $5278
	ld h, d ; $5279
	ld l, e ; $527a
	ld a, $20 ; $527b
	call Func_3f_50ea ; $527d
	pop hl ; $5280
	pop bc ; $5281
	dec c ; $5282
	jr nz, Label_3f_526f ; $5283
	wram_bank $06 ; $5285
	ld c, $00 ; $528b
	ld a, [$cb2d] ; $528d
	ld b, a ; $5290
	inc b ; $5291
	ld hl, $539e ; $5292
	ld a, [$cb32] ; $5295
	ld e, a ; $5298
Label_3f_5299:
	inc c ; $5299
Label_3f_529a:
	ld a, [hl+] ; $529a
	cp a, $00 ; $529b
	jr z, Label_3f_529a ; $529d
	and a, e ; $529f
	jr z, Label_3f_5299 ; $52a0
	dec b ; $52a2
	jr nz, Label_3f_5299 ; $52a3
	dec c ; $52a5
	dec hl ; $52a6
	ld b, $00 ; $52a7
	push af ; $52a9
	push bc ; $52aa
	push de ; $52ab
	push hl ; $52ac
	wram_bank $03 ; $52ad
	pop hl ; $52b3
	pop de ; $52b4
	pop bc ; $52b5
	pop af ; $52b6
	push af ; $52b7
	push bc ; $52b8
	push de ; $52b9
	push hl ; $52ba
	ld hl, $c3b7 ; $52bb
	ld de, $1b00 ; $52be
	ld a, e ; $52c1
	ld [hl+], a ; $52c2
	ld [hl], d ; $52c3
	ld a, $0c ; $52c4
	ld [$c3b9], a ; $52c6
	ld a, $36 ; $52c9
	ld hl, $c3ba ; $52cb
	ld [hl+], a ; $52ce
	ld [hl+], a ; $52cf
	ld [hl+], a ; $52d0
	pop hl ; $52d1
	pop de ; $52d2
	pop bc ; $52d3
	pop af ; $52d4
Label_3f_52d5:
	inc c ; $52d5
Label_3f_52d6:
	ld a, [hl+] ; $52d6
	cp a, $00 ; $52d7
	jr z, Label_3f_52d6 ; $52d9
	cp a, $40 ; $52db
	jr nz, Label_3f_52e6 ; $52dd
	ld hl, $539e ; $52df
	ld c, $00 ; $52e2
	jr Label_3f_52d5 ; $52e4
Label_3f_52e6:
	and a, e ; $52e6
	jr z, Label_3f_52d5 ; $52e7
	dec c ; $52e9
	push hl ; $52ea
	ld hl, $10f0 ; $52eb
	ld a, c ; $52ee
	add a, l ; $52ef
	ld l, a ; $52f0
	jr nc, Label_3f_52f4 ; $52f1
	inc h ; $52f3
Label_3f_52f4:
	inc c ; $52f4
	inc b ; $52f5
	push de ; $52f6
	push bc ; $52f7
	ld de, $d0d0 ; $52f8
Label_3f_52fb:
	ld a, $80 ; $52fb
	add a, e ; $52fd
	ld e, a ; $52fe
	jr nc, Label_3f_5302 ; $52ff
	inc d ; $5301
Label_3f_5302:
	dec b ; $5302
	jr nz, Label_3f_52fb ; $5303
	pop bc ; $5305
	ld a, [$c3b3] ; $5306
	push af ; $5309
	ld a, $03 ; $530a
	ld [$c3b3], a ; $530c
	ld a, c ; $530f
	ld c, $0c ; $5310
	farcall FarPtr_05_1c ; $5312
	ld c, a ; $5315
	pop af ; $5316
	ld [$c3b3], a ; $5317
	pop de ; $531a
	pop hl ; $531b
	ld a, b ; $531c
	cp a, $06 ; $531d
	jr nz, Label_3f_52d5 ; $531f
	farcall FarPtr_05_18 ; $5321
	call Func_3f_5334 ; $5324
	call Func_3f_5749 ; $5327
	call Func_3f_578f ; $532a
	wram_bank $06 ; $532d
	ret ; $5333
Func_3f_5334:
	call Func_3f_517b ; $5334
	ld b, a ; $5337
	inc b ; $5338
	ld a, [$cb32] ; $5339
	ld e, a ; $533c
	ld hl, $539e ; $533d
	ld d, $00 ; $5340
Label_3f_5342:
	ld a, [hl+] ; $5342
	cp a, $00 ; $5343
	jr nz, Label_3f_534a ; $5345
	inc d ; $5347
	jr Label_3f_5342 ; $5348
Label_3f_534a:
	and a, e ; $534a
	jr z, Label_3f_5342 ; $534b
	dec b ; $534d
	jr nz, Label_3f_5342 ; $534e
	wram_bank $03 ; $5350
	ld a, d ; $5356
	dec a ; $5357
	cp a, $ff ; $5358
	jr nz, Label_3f_535e ; $535a
	ld a, $16 ; $535c
Label_3f_535e:
	ld hl, $148f ; $535e
	add a, l ; $5361
	ld l, a ; $5362
	jr nc, Label_3f_5366 ; $5363
	inc h ; $5365
Label_3f_5366:
	push de ; $5366
	ld c, $40 ; $5367
	ld de, $d050 ; $5369
	farcall FarPtr_05_72 ; $536c
	pop de ; $536f
	ld a, d ; $5370
	inc a ; $5371
	cp a, $17 ; $5372
	jr nz, Label_3f_5377 ; $5374
	xor a, a ; $5376
Label_3f_5377:
	ld hl, $148f ; $5377
	add a, l ; $537a
	ld l, a ; $537b
	jr nc, Label_3f_537f ; $537c
	inc h ; $537e
Label_3f_537f:
	ld de, $d05e ; $537f
	farcall FarPtr_05_72 ; $5382
	ld a, $06 ; $5385
	ld [$d040], a ; $5387
Label_3f_538a:
	ld hl, $d050 ; $538a
	ld de, $9830 ; $538d
	ld c, $01 ; $5390
	call Func_00_0480 ; $5392
	or a, a ; $5395
	jr nz, Label_3f_539d ; $5396
	call AdvanceFrame ; $5398
	jr Label_3f_538a ; $539b
Label_3f_539d:
	ret ; $539d
	INCBIN "data/bank_03f/d_539e.bin" ; $539e, 121 bytes
Func_3f_5417:
	wram_bank $06 ; $5417
	ld c, $00 ; $541d
	ld hl, $539e ; $541f
	ld a, [$cb32] ; $5422
	ld e, a ; $5425
	ld a, [$cb2e] ; $5426
	call Func_3f_5453 ; $5429
	ld b, a ; $542c
	or a, a ; $542d
	jr z, Label_3f_5442 ; $542e
Label_3f_5430:
	ld a, [hl+] ; $5430
	and a, e ; $5431
	jr z, Label_3f_5435 ; $5432
	inc c ; $5434
Label_3f_5435:
	cp a, $40 ; $5435
	jr z, Label_3f_5442 ; $5437
	cp a, $00 ; $5439
	jr nz, Label_3f_5430 ; $543b
	dec b ; $543d
	jr nz, Label_3f_5430 ; $543e
	jr Label_3f_544a ; $5440
Label_3f_5442:
	xor a, a ; $5442
	ld [$cb2e], a ; $5443
	ld [$cb2d], a ; $5446
	ret ; $5449
Label_3f_544a:
	xor a, a ; $544a
	ld [$cb2e], a ; $544b
	ld a, c ; $544e
	ld [$cb2d], a ; $544f
	ret ; $5452
Func_3f_5453:
	push hl ; $5453
	ld hl, $545f ; $5454
	add a, l ; $5457
	ld l, a ; $5458
	jr nc, Label_3f_545c ; $5459
	inc h ; $545b
Label_3f_545c:
	ld a, [hl] ; $545c
	pop hl ; $545d
	ret ; $545e
	INCBIN "data/bank_03f/d_545f.bin" ; $545f, 9 bytes
Func_3f_5468:
	wram_bank $06 ; $5468
	ld a, [$cb32] ; $546e
	ld b, a ; $5471
	call Func_3f_517b ; $5472
	ld b, a ; $5475
	inc b ; $5476
	ld c, $00 ; $5477
	ld hl, $539e ; $5479
	ld a, [$cb32] ; $547c
	ld e, a ; $547f
Label_3f_5480:
	ld a, [hl+] ; $5480
	and a, e ; $5481
	jr z, Label_3f_5489 ; $5482
	dec b ; $5484
	jr nz, Label_3f_5480 ; $5485
	jr Label_3f_5499 ; $5487
Label_3f_5489:
	cp a, $40 ; $5489
	jr z, Label_3f_5494 ; $548b
	cp a, $00 ; $548d
	jr nz, Label_3f_5480 ; $548f
	inc c ; $5491
	jr Label_3f_5480 ; $5492
Label_3f_5494:
	xor a, a ; $5494
	ld [$cb2e], a ; $5495
	ret ; $5498
Label_3f_5499:
	ld a, c ; $5499
	call Func_3f_54a1 ; $549a
	ld [$cb2e], a ; $549d
	ret ; $54a0
Func_3f_54a1:
	push hl ; $54a1
	ld hl, $54ad ; $54a2
	add a, l ; $54a5
	ld l, a ; $54a6
	jr nc, Label_3f_54aa ; $54a7
	inc h ; $54a9
Label_3f_54aa:
	ld a, [hl] ; $54aa
	pop hl ; $54ab
	ret ; $54ac
	INCBIN "data/bank_03f/d_54ad.bin" ; $54ad, 27 bytes
Func_3f_54c8:
	or a, a ; $54c8
	jr z, Label_3f_54d0 ; $54c9
	ld hl, $5540 ; $54cb
	jr Label_3f_54d3 ; $54ce
Label_3f_54d0:
	ld hl, $5564 ; $54d0
Label_3f_54d3:
	wram_bank $03 ; $54d3
	ld de, $cfb3 ; $54d9
	ld c, b ; $54dc
	inc b ; $54dd
Label_3f_54de:
	ld a, $80 ; $54de
	add a, e ; $54e0
	ld e, a ; $54e1
	jr nc, Label_3f_54e5 ; $54e2
	inc d ; $54e4
Label_3f_54e5:
	dec b ; $54e5
	jr nz, Label_3f_54de ; $54e6
	ld a, c ; $54e8
	push af ; $54e9
	add a, a ; $54ea
	add a, a ; $54eb
	add a, l ; $54ec
	ld l, a ; $54ed
	jr nc, Label_3f_54f1 ; $54ee
	inc h ; $54f0
Label_3f_54f1:
	ld a, [hl+] ; $54f1
	ld [de], a ; $54f2
	inc de ; $54f3
	ld a, [hl+] ; $54f4
	ld [de], a ; $54f5
	ld a, $3f ; $54f6
	add a, e ; $54f8
	ld e, a ; $54f9
	jr nc, Label_3f_54fd ; $54fa
	inc d ; $54fc
Label_3f_54fd:
	ld a, [hl+] ; $54fd
	ld [de], a ; $54fe
	inc de ; $54ff
	ld a, [hl] ; $5500
	ld [de], a ; $5501
	pop af ; $5502
	ld hl, $cff0 ; $5503
	ld de, $97f0 ; $5506
	add a, a ; $5509
	ld b, a ; $550a
	inc b ; $550b
Label_3f_550c:
	ld a, $40 ; $550c
	add a, l ; $550e
	ld l, a ; $550f
	jr nc, Label_3f_5513 ; $5510
	inc h ; $5512
Label_3f_5513:
	ld a, $20 ; $5513
	add a, e ; $5515
	ld e, a ; $5516
	jr nc, Label_3f_551a ; $5517
	inc d ; $5519
Label_3f_551a:
	dec b ; $551a
	jr nz, Label_3f_550c ; $551b
	ld c, $01 ; $551d
	push de ; $551f
	push hl ; $5520
	call Func_00_0480 ; $5521
	pop hl ; $5524
	pop de ; $5525
	ld a, $40 ; $5526
	add a, l ; $5528
	ld l, a ; $5529
	jr nc, Label_3f_552d ; $552a
	inc h ; $552c
Label_3f_552d:
	ld a, $20 ; $552d
	add a, e ; $552f
	ld e, a ; $5530
	jr nc, Label_3f_5534 ; $5531
	inc d ; $5533
Label_3f_5534:
	ld c, $01 ; $5534
	call Func_00_0480 ; $5536
	wram_bank $06 ; $5539
	ret ; $553f
	INCBIN "data/bank_03f/d_5540.bin" ; $5540, 72 bytes
Func_3f_5588:
	push bc ; $5588
	push af ; $5589
	wram_bank $06 ; $558a
	ldh a, [$ff94] ; $5590
	bit 0, a ; $5592
	jr z, Label_3f_559e ; $5594
	pop af ; $5596
	sound $5f ; $5597
	ld a, $04 ; $5599
	push af ; $559b
	jr Label_3f_55fc ; $559c
Label_3f_559e:
	bit 1, a ; $559e
	jr z, Label_3f_55aa ; $55a0
	pop af ; $55a2
	sound $62 ; $55a3
	ld a, $01 ; $55a5
	push af ; $55a7
	jr Label_3f_55fc ; $55a8
Label_3f_55aa:
	ldh a, [hInputPressed] ; $55aa
	bit 6, a ; $55ac
	jr z, Label_3f_55d1 ; $55ae
	ld a, [$cb2e] ; $55b0
	ld b, a ; $55b3
	dec a ; $55b4
	cp a, $ff ; $55b5
	jr z, Label_3f_55fc ; $55b7
	ld [$cb2e], a ; $55b9
	push af ; $55bc
	xor a, a ; $55bd
	call Func_3f_54c8 ; $55be
	pop af ; $55c1
	sound $5e ; $55c2
	ld a, [$cb2e] ; $55c4
	ld b, a ; $55c7
	ld a, $01 ; $55c8
	call Func_3f_54c8 ; $55ca
	ld a, $01 ; $55cd
	jr Label_3f_55fc ; $55cf
Label_3f_55d1:
	bit 7, a ; $55d1
	jr z, Label_3f_55f6 ; $55d3
	ld a, [$cb2e] ; $55d5
	ld b, a ; $55d8
	inc a ; $55d9
	cp a, $09 ; $55da
	jr z, Label_3f_55fc ; $55dc
	ld [$cb2e], a ; $55de
	push af ; $55e1
	xor a, a ; $55e2
	call Func_3f_54c8 ; $55e3
	pop af ; $55e6
	sound $5e ; $55e7
	ld a, [$cb2e] ; $55e9
	ld b, a ; $55ec
	ld a, $01 ; $55ed
	call Func_3f_54c8 ; $55ef
	ld a, $01 ; $55f2
	jr Label_3f_55fc ; $55f4
Label_3f_55f6:
	bit 5, a ; $55f6
	jr z, Label_3f_55fc ; $55f8
	jr Label_3f_55fc ; $55fa
Label_3f_55fc:
	pop af ; $55fc
	pop bc ; $55fd
	ret ; $55fe
Func_3f_55ff:
	push bc ; $55ff
	push af ; $5600
	wram_bank $06 ; $5601
	ld a, [$cb37] ; $5607
	res 2, a ; $560a
	res 3, a ; $560c
	ld [$cb37], a ; $560e
	ldh a, [$ff94] ; $5611
	bit 0, a ; $5613
	jp z, Label_3f_56a4 ; $5615
	sound $5f ; $5618
	call Func_3f_4e7b ; $561a
	ld a, [$cb37] ; $561d
	set 0, a ; $5620
	ld [$cb37], a ; $5622
	ld a, [$cb32] ; $5625
	ld b, a ; $5628
	ld a, [$cb33] ; $5629
	cp a, $01 ; $562c
	jr z, Label_3f_5640 ; $562e
	call Func_3f_517b ; $5630
	call Func_3f_5134 ; $5633
	ld hl, $1430 ; $5636
	add a, l ; $5639
	ld l, a ; $563a
	jr nc, Label_3f_563e ; $563b
	inc h ; $563d
Label_3f_563e:
	jr Label_3f_564e ; $563e
Label_3f_5640:
	call Func_3f_517b ; $5640
	call Func_3f_514a ; $5643
	ld hl, $14a9 ; $5646
	add a, l ; $5649
	ld l, a ; $564a
	jr nc, Label_3f_564e ; $564b
	inc h ; $564d
Label_3f_564e:
	push hl ; $564e
	farcall FarPtr_05_5c ; $564f
	ld a, $05 ; $5652
	ld [$c3b3], a ; $5654
	pop hl ; $5657
	ld d, $00 ; $5658
	ld e, $06 ; $565a
	ld b, $14 ; $565c
	ld c, $05 ; $565e
	farcall FarPtr_05_06 ; $5660
	push hl ; $5663
	xor a, a ; $5664
	farcall FarPtr_05_44 ; $5665
	ld b, $00 ; $5668
	farcall FarPtr_05_0e ; $566a
	pop hl ; $566d
	ld a, [wMessageSpeed] ; $566e
	push af ; $5671
	xor a, a ; $5672
	ld a, $80 ; $5673
	ld [wMessageSpeed], a ; $5675
	xor a, a ; $5678
	set_flag $04, 3 ; $5679
	farcall FarPtr_05_60 ; $567c
	clear_flag $04, 3 ; $567f
	pop af ; $5682
	ld [wMessageSpeed], a ; $5683
	xor a, a ; $5686
	farcall FarPtr_05_6a ; $5687
	farcall FarPtr_05_64 ; $568a
	farcall FarPtr_05_66 ; $568d
	wram_bank $06 ; $5690
	ld a, [$cb37] ; $5696
	res 0, a ; $5699
	ld [$cb37], a ; $569b
	call Func_3f_4e69 ; $569e
	jp Label_3f_5746 ; $56a1
Label_3f_56a4:
	bit 1, a ; $56a4
	jr z, Label_3f_56be ; $56a6
	pop af ; $56a8
	sound $62 ; $56a9
	ld a, [$cb34] ; $56ab
	cp a, $06 ; $56ae
	jr z, Label_3f_56b8 ; $56b0
	ld a, $01 ; $56b2
	push af ; $56b4
	jp Label_3f_5746 ; $56b5
Label_3f_56b8:
	ld a, $10 ; $56b8
	push af ; $56ba
	jp Label_3f_5746 ; $56bb
Label_3f_56be:
	ldh a, [hInputPressed] ; $56be
	bit 6, a ; $56c0
	jr z, Label_3f_56ea ; $56c2
	sound $5e ; $56c4
	ld a, [$cb2e] ; $56c6
	dec a ; $56c9
	cp a, $ff ; $56ca
	jr z, Label_3f_56d6 ; $56cc
	ld [$cb2e], a ; $56ce
	call Func_3f_5334 ; $56d1
	jr Label_3f_5746 ; $56d4
Label_3f_56d6:
	ld a, [$cb2d] ; $56d6
	dec a ; $56d9
	cp a, $ff ; $56da
	jr nz, Label_3f_56e2 ; $56dc
	ld a, [$cb2f] ; $56de
	dec a ; $56e1
Label_3f_56e2:
	ld [$cb2d], a ; $56e2
	call Func_3f_5261 ; $56e5
	jr Label_3f_5746 ; $56e8
Label_3f_56ea:
	bit 7, a ; $56ea
	jr z, Label_3f_5714 ; $56ec
	sound $5e ; $56ee
	ld a, [$cb2e] ; $56f0
	inc a ; $56f3
	cp a, $06 ; $56f4
	jr nc, Label_3f_5700 ; $56f6
	ld [$cb2e], a ; $56f8
	call Func_3f_5334 ; $56fb
	jr Label_3f_5746 ; $56fe
Label_3f_5700:
	ld a, [$cb2f] ; $5700
	ld b, a ; $5703
	ld a, [$cb2d] ; $5704
	inc a ; $5707
	cp a, b ; $5708
	jr nz, Label_3f_570c ; $5709
	xor a, a ; $570b
Label_3f_570c:
	ld [$cb2d], a ; $570c
	call Func_3f_5261 ; $570f
	jr Label_3f_5746 ; $5712
Label_3f_5714:
	bit 5, a ; $5714
	jr z, Label_3f_572d ; $5716
	ld a, [$cb37] ; $5718
	set 2, a ; $571b
	ld [$cb37], a ; $571d
	sound $5e ; $5720
	call AdvanceFrame ; $5722
	call Func_3f_5192 ; $5725
	call Func_3f_5261 ; $5728
	jr Label_3f_5746 ; $572b
Label_3f_572d:
	bit 4, a ; $572d
	jr z, Label_3f_5746 ; $572f
	ld a, [$cb37] ; $5731
	set 3, a ; $5734
	ld [$cb37], a ; $5736
	sound $5e ; $5739
	call AdvanceFrame ; $573b
	call Func_3f_520f ; $573e
	call Func_3f_5261 ; $5741
	jr Label_3f_5746 ; $5744
Label_3f_5746:
	pop af ; $5746
	pop bc ; $5747
	ret ; $5748
Func_3f_5749:
	ldh a, [hWramBank] ; $5749
	push af ; $574b
	wram_bank $07 ; $574c
	ld hl, $d660 ; $5752
	ld de, $8b60 ; $5755
	ld c, $18 ; $5758
	call Func_00_0480 ; $575a
	push af ; $575d
	ldh a, [rLCDC] ; $575e
	bit 7, a ; $5760
	jr z, Label_3f_5767 ; $5762
	call AdvanceFrame ; $5764
Label_3f_5767:
	pop af ; $5767
	ld hl, $d7e0 ; $5768
	ld de, $8ce0 ; $576b
	ld c, $18 ; $576e
	call Func_00_0480 ; $5770
	push af ; $5773
	ldh a, [rLCDC] ; $5774
	bit 7, a ; $5776
	jr z, Label_3f_577d ; $5778
	call AdvanceFrame ; $577a
Label_3f_577d:
	pop af ; $577d
	ld hl, $d960 ; $577e
	ld de, $8e60 ; $5781
	ld c, $18 ; $5784
	call Func_00_0480 ; $5786
	pop af ; $5789
	wram_bank ; $578a
	ret ; $578e
Func_3f_578f:
	ldh a, [hWramBank] ; $578f
	push af ; $5791
	wram_bank $05 ; $5792
	ld hl, $d0b0 ; $5798
	ld de, $98b0 ; $579b
	ld c, $01 ; $579e
	call Func_00_0480 ; $57a0
	ld hl, $d0f0 ; $57a3
	ld de, $98f0 ; $57a6
	ld c, $01 ; $57a9
	call Func_00_0480 ; $57ab
	ld hl, $d130 ; $57ae
	ld de, $9930 ; $57b1
	ld c, $01 ; $57b4
	call Func_00_0480 ; $57b6
	ld hl, $d170 ; $57b9
	ld de, $9970 ; $57bc
	ld c, $01 ; $57bf
	call Func_00_0480 ; $57c1
	ld hl, $d1b0 ; $57c4
	ld de, $99b0 ; $57c7
	ld c, $01 ; $57ca
	call Func_00_0480 ; $57cc
	ld hl, $d1f0 ; $57cf
	ld de, $99f0 ; $57d2
	ld c, $01 ; $57d5
	call Func_00_0480 ; $57d7
	push af ; $57da
	ldh a, [rLCDC] ; $57db
	bit 7, a ; $57dd
	jr z, Label_3f_57e4 ; $57df
	call AdvanceFrame ; $57e1
Label_3f_57e4:
	pop af ; $57e4
	pop af ; $57e5
	wram_bank ; $57e6
	ret ; $57ea
HardCourtLabelTiles:
	INCBIN "data/bank_03f/lz_57eb.bin" ; $57eb, 193 bytes
ClayCourtLabelTiles:
	INCBIN "data/bank_03f/lz_58ac.bin" ; $58ac, 200 bytes
GrassCourtLabelTiles:
	INCBIN "data/bank_03f/lz_5974.bin" ; $5974, 195 bytes
CompositionCourtLabelTiles:
	INCBIN "data/bank_03f/lz_5a37.bin" ; $5a37, 190 bytes
Lz_3f_5af5:
	INCBIN "data/bank_03f/lz_5af5.bin" ; $5af5, 210 bytes
Lz_3f_5bc7:
	INCBIN "data/bank_03f/lz_5bc7.bin" ; $5bc7, 222 bytes
Lz_3f_5ca5:
	INCBIN "data/bank_03f/lz_5ca5.bin" ; $5ca5, 251 bytes
Lz_3f_5da0:
	INCBIN "data/bank_03f/lz_5da0.bin" ; $5da0, 242 bytes
Lz_3f_5e92:
	INCBIN "data/bank_03f/lz_5e92.bin" ; $5e92, 235 bytes
Lz_3f_5f7d:
	INCBIN "data/bank_03f/lz_5f7d.bin" ; $5f7d, 183 bytes
Lz_3f_6034:
	INCBIN "data/bank_03f/lz_6034.bin" ; $6034, 151 bytes
Lz_3f_60cb:
	INCBIN "data/bank_03f/lz_60cb.bin" ; $60cb, 164 bytes
Lz_3f_616f:
	INCBIN "data/bank_03f/lz_616f.bin" ; $616f, 170 bytes
Lz_3f_6219:
	INCBIN "data/bank_03f/lz_6219.bin" ; $6219, 196 bytes
VarsityTeamChartTiles:
	INCBIN "data/bank_03f/lz_62dd.bin" ; $62dd, 1314 bytes
VarsityTeamChartTilemap:
	INCBIN "data/bank_03f/lz_67ff.bin" ; $67ff, 325 bytes
VarsityTeamChartAttrmap:
	INCBIN "data/bank_03f/lz_6944.bin" ; $6944, 141 bytes
VarsityTeamChartPalettes:
	; $69d1, 64 bytes (palettes)
; GBC palettes (BGR555), 4 colors each
	dw $67f9, $0000, $0098, $031f ; pal 0: #cdffcd #000000 #c52000 #ffc500
	dw $0000, $0000, $0000, $0000 ; pal 1: #000000 #000000 #000000 #000000
	dw $0c63, $0220, $5294, $7ffd ; pal 2: #181818 #008b00 #a4a4a4 #eeffff
	dw $0000, $67f9, $0098, $031f ; pal 3: #000000 #cdffcd #c52000 #ffc500
	dw $0c63, $7e80, $5294, $7ffd ; pal 4: #181818 #00a4ff #a4a4a4 #eeffff
	dw $67f9, $0000, $0098, $031f ; pal 5: #cdffcd #000000 #c52000 #ffc500
	dw $0000, $4e16, $73ff, $67f9 ; pal 6: #000000 #b4839c #ffffe6 #cdffcd
	dw $0000, $3140, $7ff6, $7e80 ; pal 7: #000000 #005262 #b4ffff #00a4ff
VarsityTeamChartTilemap2:
	INCBIN "data/bank_03f/lz_6a11.bin" ; $6a11, 317 bytes
VarsityTeamChartAttrmap2:
	INCBIN "data/bank_03f/lz_6b4e.bin" ; $6b4e, 143 bytes
Lz_3f_6bdd:
	INCBIN "data/bank_03f/lz_6bdd.bin" ; $6bdd, 38 bytes
MugshotTiles:
	INCBIN "data/bank_03f/lz_6c03.bin" ; $6c03, 1000 bytes
TournamentBracketTiles:
	INCBIN "data/bank_03f/lz_6feb.bin" ; $6feb, 1224 bytes
Lz_3f_74b3:
	INCBIN "data/bank_03f/lz_74b3.bin" ; $74b3, 31 bytes
Lz_3f_74d2:
	INCBIN "data/bank_03f/lz_74d2.bin" ; $74d2, 210 bytes
Lz_3f_75a4:
	INCBIN "data/bank_03f/lz_75a4.bin" ; $75a4, 213 bytes
Lz_3f_7679:
	INCBIN "data/bank_03f/lz_7679.bin" ; $7679, 74 bytes
Lz_3f_76c3:
	INCBIN "data/bank_03f/lz_76c3.bin" ; $76c3, 75 bytes
Lz_3f_770e:
	INCBIN "data/bank_03f/lz_770e.bin" ; $770e, 73 bytes
Lz_3f_7757:
	INCBIN "data/bank_03f/lz_7757.bin" ; $7757, 70 bytes
Lz_3f_779d:
	INCBIN "data/bank_03f/lz_779d.bin" ; $779d, 67 bytes
Lz_3f_77e0:
	INCBIN "data/bank_03f/lz_77e0.bin" ; $77e0, 70 bytes
Lz_3f_7826:
	INCBIN "data/bank_03f/lz_7826.bin" ; $7826, 74 bytes
Lz_3f_7870:
	INCBIN "data/bank_03f/lz_7870.bin" ; $7870, 74 bytes
Lz_3f_78ba:
	INCBIN "data/bank_03f/lz_78ba.bin" ; $78ba, 74 bytes
Lz_3f_7904:
	INCBIN "data/bank_03f/lz_7904.bin" ; $7904, 75 bytes
Lz_3f_794f:
	INCBIN "data/bank_03f/lz_794f.bin" ; $794f, 73 bytes
Lz_3f_7998:
	INCBIN "data/bank_03f/lz_7998.bin" ; $7998, 67 bytes
Lz_3f_79db:
	INCBIN "data/bank_03f/lz_79db.bin" ; $79db, 66 bytes
Lz_3f_7a1d:
	INCBIN "data/bank_03f/lz_7a1d.bin" ; $7a1d, 70 bytes
Lz_3f_7a63:
	INCBIN "data/bank_03f/lz_7a63.bin" ; $7a63, 74 bytes
Lz_3f_7aad:
	INCBIN "data/bank_03f/lz_7aad.bin" ; $7aad, 74 bytes
Lz_3f_7af7:
	INCBIN "data/bank_03f/lz_7af7.bin" ; $7af7, 153 bytes
	INCBIN "data/bank_03f/d_7b90.bin" ; $7b90, 185 bytes
	ds 951, $ff ; $7c49, fill
