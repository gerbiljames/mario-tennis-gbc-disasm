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
DataPtr_3f_78:
	dw Lz_3f_7b90 ; $4078
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
	script_fade_in $10 ; $4114
	call WaitFadeEnd ; $4119
	ld a, $1d ; $411c
	ld hl, Func_3f_4e8d ; $411e
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
	call WaitFramesCmd ; $4142
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
	call RestorePalettesFromMaster ; $4178
	cp a, $01 ; $417b
	jp nz, Label_3f_4154 ; $417d
	push af ; $4180
	ld c, $10 ; $4181
	call BeginFadeOut ; $4183
	call WaitFadeEnd ; $4186
	pop af ; $4189
	call Func_3f_4244 ; $418a
	ld hl, Func_3f_4e8d ; $418d
	call UnregisterFrameTask ; $4190
	ret ; $4193
Func_3f_4194:
	ld c, $10 ; $4194
	call BeginFadeOut ; $4196
	call WaitFadeEnd ; $4199
	ld a, $0d ; $419c
	ld [$c321], a ; $419e
	xor a, a ; $41a1
	ld [wCameraX], a ; $41a2
	wram_bank $06 ; $41a5
	ld a, [$cb2e] ; $41ab
	ld b, a ; $41ae
	xor a, a ; $41af
	call Func_3f_54c8 ; $41b0
	farcall FarPtr_UpdateSceneScroll ; $41b3
	call AdvanceFrame ; $41b6
	call DisableLCDSafely ; $41b9
	call Func_3f_425f ; $41bc
	ld a, $01 ; $41bf
	farcall FarPtr_CopyScrolledSceneTilemapToVram ; $41c1
	call EnableLCD ; $41c4
	call Func_3f_5417 ; $41c7
	call Func_3f_5261 ; $41ca
	ld a, [$cb37] ; $41cd
	set 1, a ; $41d0
	ld [$cb37], a ; $41d2
	script_fade_in $10 ; $41d5
	call WaitFadeEnd ; $41da
	ld a, $08 ; $41dd
	ret ; $41df
Func_3f_41e0:
	ld c, $10 ; $41e0
	call BeginFadeOut ; $41e2
	call WaitFadeEnd ; $41e5
	ld a, $21 ; $41e8
	ld [$c321], a ; $41ea
	xor a, a ; $41ed
	ld [wCameraX], a ; $41ee
	call Func_3f_5468 ; $41f1
	ld a, [$cb2e] ; $41f4
	ld b, a ; $41f7
	ld a, $01 ; $41f8
	call Func_3f_54c8 ; $41fa
	farcall FarPtr_UpdateSceneScroll ; $41fd
	call AdvanceFrame ; $4200
	call DisableLCDSafely ; $4203
	call Func_3f_42a0 ; $4206
	ld a, $01 ; $4209
	farcall FarPtr_CopyScrolledSceneTilemapToVram ; $420b
	call EnableLCD ; $420e
	wram_bank $06 ; $4211
	ld a, [$cb37] ; $4217
	res 1, a ; $421a
	ld [$cb37], a ; $421c
	script_fade_in $10 ; $421f
	call WaitFadeEnd ; $4224
	ld a, $02 ; $4227
	ret ; $4229
	add hl, de ; $422a
	ld a, h ; $422b
	cp a, b ; $422c
	jr nc, Label_3f_4239 ; $422d
	ld a, l ; $422f
	ld [wCameraX], a ; $4230
	ld a, h ; $4233
	ld [$c321], a ; $4234
	jr Label_3f_423f ; $4237
Label_3f_4239:
	farcall FarPtr_UpdateSceneScroll ; $4239
	ld a, $01 ; $423c
	ret ; $423e
Label_3f_423f:
	farcall FarPtr_UpdateSceneScroll ; $423f
	xor a, a ; $4242
	ret ; $4243
Func_3f_4244:
	wram_bank $06 ; $4244
	xor a, a ; $424a
	ldh [hScrollX], a ; $424b
	ld [$c321], a ; $424d
	ld [wCameraX], a ; $4250
	ldh [hScrollY], a ; $4253
	ld hl, wCameraY ; $4255
	ld [hl+], a ; $4258
	ld [hl+], a ; $4259
	ldh [hBGColumnBlitPending], a ; $425a
	ldh [hBGRowBlitPending], a ; $425c
	ret ; $425e
Func_3f_425f:
	wram_bank $01 ; $425f
	ld hl, $3a02 ; $4265 -> DataPtr_TennisDictionaryListTiles
	ld de, $d000 ; $4268
	call DecompressDataFromBank ; $426b
	ld hl, $d000 ; $426e
	ld de, $b000 ; $4271
	ld c, $80 ; $4274
	call QueueVRAMCopy ; $4276
	ld hl, $d800 ; $4279
	ld de, $a800 ; $427c
	ld c, $80 ; $427f
	call QueueVRAMCopy ; $4281
	ld hl, $47f6 ; $4284
	ld de, $0008 ; $4287
	call LoadPalettesMasterOnly ; $428a
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
	call QueueVRAMCopy ; $42b7
	ld hl, $d800 ; $42ba
	ld de, $a800 ; $42bd
	ld c, $80 ; $42c0
	call QueueVRAMCopy ; $42c2
	ld hl, $47ae ; $42c5
	ld de, $0008 ; $42c8
	call LoadPalettesMasterOnly ; $42cb
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
	ldh [hScrollX], a ; $4311
	ld [$c321], a ; $4313
	xor a, a ; $4316
	ld [wCameraX], a ; $4317
	ldh [hScrollY], a ; $431a
	ld hl, wCameraY ; $431c
	ld [hl+], a ; $431f
	ld [hl+], a ; $4320
	ldh [hBGColumnBlitPending], a ; $4321
	ldh [hBGRowBlitPending], a ; $4323
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
	call QueueVRAMCopy ; $4348
	ld hl, $495d ; $434b
	ld de, $d000 ; $434e
	call DecompressData ; $4351
	ld hl, $d000 ; $4354
	ld de, $8200 ; $4357
	ld c, $20 ; $435a
	call QueueVRAMCopy ; $435c
	ld hl, $4a9f ; $435f
	ld de, $d000 ; $4362
	call DecompressData ; $4365
	ld hl, $d000 ; $4368
	ld de, $8400 ; $436b
	ld c, $20 ; $436e
	call QueueVRAMCopy ; $4370
	ld hl, $4bd5 ; $4373
	ld de, $d000 ; $4376
	call DecompressData ; $4379
	ld hl, $d000 ; $437c
	ld de, $a000 ; $437f
	ld c, $20 ; $4382
	call QueueVRAMCopy ; $4384
	ld hl, $4c89 ; $4387
	ld de, $d000 ; $438a
	call DecompressData ; $438d
	ld hl, $d000 ; $4390
	ld de, $a200 ; $4393
	ld c, $20 ; $4396
	call QueueVRAMCopy ; $4398
	ld hl, $4d8b ; $439b
	ld de, $d000 ; $439e
	call DecompressData ; $43a1
	ld hl, $d000 ; $43a4
	ld de, $a400 ; $43a7
	ld c, $20 ; $43aa
	call QueueVRAMCopy ; $43ac
	ld hl, $4e39 ; $43af
	ld de, $0808 ; $43b2
	call LoadPalettesMasterOnly ; $43b5
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
	farcall FarPtr_UpdateSceneScroll ; $443a
	call DisableLCDSafely ; $443d
	wram_bank $03 ; $4440
	ld a, $01 ; $4446
	farcall FarPtr_CopyScrolledSceneTilemapToVram ; $4448
	call EnableLCD ; $444b
	ret ; $444e
	; $444f, 2586 bytes (records:2)
	dw $d066 ; record 0
	dw $000a ; record 1
	dw $d0a6 ; record 2
	dw $000a ; record 3
	dw $d165 ; record 4
	dw $0001 ; record 5
	dw $d1a5 ; record 6
	dw $0001 ; record 7
	dw $d1e5 ; record 8
	dw $0001 ; record 9
	dw $d225 ; record 10
	dw $0001 ; record 11
	dw $d265 ; record 12
	dw $0001 ; record 13
	dw $d2a5 ; record 14
	dw $0001 ; record 15
	dw $d2e5 ; record 16
	dw $0001 ; record 17
	dw $d325 ; record 18
	dw $0001 ; record 19
	dw $d365 ; record 20
	dw $0001 ; record 21
	dw $d3a5 ; record 22
	dw $0001 ; record 23
	dw $d052 ; record 24
	dw $000a ; record 25
	dw $d092 ; record 26
	dw $000a ; record 27
	dw $d10f ; record 28
	dw $0010 ; record 29
	dw $d14f ; record 30
	dw $0010 ; record 31
	dw $d18f ; record 32
	dw $0010 ; record 33
	dw $d1cf ; record 34
	dw $0010 ; record 35
	dw $d20f ; record 36
	dw $0010 ; record 37
	dw $d24f ; record 38
	dw $0010 ; record 39
	dw $d28f ; record 40
	dw $0010 ; record 41
	dw $d2cf ; record 42
	dw $0010 ; record 43
	dw $d30f ; record 44
	dw $0010 ; record 45
	dw $d34f ; record 46
	dw $0010 ; record 47
	dw $d38f ; record 48
	dw $0010 ; record 49
	dw $d3cf ; record 50
	dw $0010 ; record 51
	dw $d050 ; record 52
	dw $0001 ; record 53
	dw $d05e ; record 54
	dw $0001 ; record 55
	dw $0acd ; record 56
	dw $e9ff ; record 57
	dw $0c0c ; record 58
	dw $e2fb ; record 59
	dw $e6fe ; record 60
	dw $0b0b ; record 61
	dw $0b4f ; record 62
	dw $0c0c ; record 63
	dw $fe2c ; record 64
	dw $eaec ; record 65
	dw $08e0 ; record 66
	dw $e7ff ; record 67
	dw $c09e ; record 68
	dw $0ced ; record 69
	dw $0e0a ; record 70
	dw $c908 ; record 71
	dw $a8e1 ; record 72
	dw $0be2 ; record 73
	dw $0c01 ; record 74
	dw $e0c0 ; record 75
	dw $eefe ; record 76
	dw $fac0 ; record 77
	dw $ea70 ; record 78
	dw $e280 ; record 79
	dw $ffc0 ; record 80
	dw $e840 ; record 81
	dw $fe00 ; record 82
	dw $ddf3 ; record 83
	dw $40eb ; record 84
	dw $26f9 ; record 85
	dw $1be8 ; record 86
	dw $c0e2 ; record 87
	dw $c0ff ; record 88
	dw $c0ff ; record 89
	dw $0aff ; record 90
	dw $fcc0 ; record 91
	dw $5b4c ; record 92
	dw $4cc8 ; record 93
	dw $ffc0 ; record 94
	dw $ef80 ; record 95
	dw $dfc0 ; record 96
	dw $ffc0 ; record 97
	dw $c000 ; record 98
	dw $c0ff ; record 99
	dw $c0ff ; record 100
	dw $c0ff ; record 101
	dw $c0ff ; record 102
	dw $c0ff ; record 103
	dw $c0ff ; record 104
	dw $c0ff ; record 105
	dw $00ff ; record 106
	dw $ffc0 ; record 107
	dw $ffc0 ; record 108
	dw $ffc0 ; record 109
	dw $ffc0 ; record 110
	dw $ffc0 ; record 111
	dw $ffc0 ; record 112
	dw $97c0 ; record 113
	dw $f1bf ; record 114
	dw $c000 ; record 115
	dw $d2ff ; record 116
	dw $feeb ; record 117
	dw $c0ef ; record 118
	dw $0068 ; record 119
	dw $0000 ; record 120
	dw $080d ; record 121
	dw $e9ff ; record 122
	dw $0c0c ; record 123
	dw $eaf1 ; record 124
	dw $e2ed ; record 125
	dw $eeee ; record 126
	dw $f8f9 ; record 127
	dw $c002 ; record 128
	dw $0ee2 ; record 129
	dw $e7ff ; record 130
	dw $ffc0 ; record 131
	dw $ffc0 ; record 132
	dw $ffca ; record 133
	dw $ff40 ; record 134
	dw $ffff ; record 135
	dw $c000 ; record 136
	dw $ffff ; record 137
	dw $c0ff ; record 138
	dw $c0ff ; record 139
	dw $c0ff ; record 140
	dw $c0ff ; record 141
	dw $c0ff ; record 142
	dw $c0ff ; record 143
	dw $00ff ; record 144
	dw $ffc0 ; record 145
	dw $ffc0 ; record 146
	dw $ffc0 ; record 147
	dw $ffc0 ; record 148
	dw $ffc0 ; record 149
	dw $ffc0 ; record 150
	dw $ffff ; record 151
	dw $ffc0 ; record 152
	dw $ff00 ; record 153
	dw $c0ff ; record 154
	dw $ffff ; record 155
	dw $c0ff ; record 156
	dw $c0ff ; record 157
	dw $c0ff ; record 158
	dw $c0ff ; record 159
	dw $c0ff ; record 160
	dw $00ff ; record 161
	dw $9540 ; record 162
	dw $effe ; record 163
	dw $fcca ; record 164
	dw $0000 ; record 165
	dw $fd00 ; record 166
	dw $ff6a ; record 167
	dw $1be9 ; record 168
	dw $4b1c ; record 169
	dw $4d4c ; record 170
	dw $fe1d ; record 171
	dw $e7ff ; record 172
	dw $7c7b ; record 173
	dw $1e7d ; record 174
	dw $2322 ; record 175
	dw $9e33 ; record 176
	dw $ebfe ; record 177
	dw $7624 ; record 178
	dw $0077 ; record 179
	dw $e7ff ; record 180
	dw $eac0 ; record 181
	dw $ff2b ; record 182
	dw $5b2c ; record 183
	dw $5d2d ; record 184
	dw $0040 ; record 185
	dw $4342 ; record 186
	dw $44ff ; record 187
	dw $4641 ; record 188
	dw $4847 ; record 189
	dw $4a49 ; record 190
	dw $bf8b ; record 191
	dw $8d2d ; record 192
	dw $322e ; record 193
	dw $1817 ; record 194
	dw $ebfe ; record 195
	dw $fb34 ; record 196
	dw $8786 ; record 197
	dw $f7c0 ; record 198
	dw $6c6b ; record 199
	dw $506d ; record 200
	dw $ff51 ; record 201
	dw $5352 ; record 202
	dw $5554 ; record 203
	dw $5756 ; record 204
	dw $5958 ; record 205
	dw $5aff ; record 206
	dw $9c9b ; record 207
	dw $2e9d ; record 208
	dw $1935 ; record 209
	dw $f71a ; record 210
	dw $2c27 ; record 211
	dw $fe2b ; record 212
	dw $28e6 ; record 213
	dw $361a ; record 214
	dw $dd98 ; record 215
	dw $8084 ; record 216
	dw $c0f6 ; record 217
	dw $c2c1 ; record 218
	dw $eaff ; record 219
	dw $d6d5 ; record 220
	dw $80ce ; record 221
	dw $2de1 ; record 222
	dw $e7e6 ; record 223
	dw $e172 ; record 224
	dw $e024 ; record 225
	dw $f9f8 ; record 226
	dw $372f ; record 227
	dw $3418 ; record 228
	dw $c099 ; record 229
	dw $d4f7 ; record 230
	dw $e826 ; record 231
	dw $e21b ; record 232
	dw $d3dd ; record 233
	dw $e180 ; record 234
	dw $f62e ; record 235
	dw $72f7 ; record 236
	dw $5be1 ; record 237
	dw $7f5c ; record 238
	dw $fa5d ; record 239
	dw $38fb ; record 240
	dw $361a ; record 241
	dw $c09a ; record 242
	dw $fcff ; record 243
	dw $e8c0 ; record 244
	dw $e180 ; record 245
	dw $6665 ; record 246
	dw $6867 ; record 247
	dw $6a69 ; record 248
	dw $2416 ; record 249
	dw $6ee0 ; record 250
	dw $806f ; record 251
	dw $9be0 ; record 252
	dw $ffc0 ; record 253
	dw $ec80 ; record 254
	dw $c2ed ; record 255
	dw $60bf ; record 256
	dw $6261 ; record 257
	dw $6463 ; record 258
	dw $802f ; record 259
	dw $9ce0 ; record 260
	dw $c0dc ; record 261
	dw $80ff ; record 262
	dw $29eb ; record 263
	dw $393a ; record 264
	dw $e5fe ; record 265
	dw $2a39 ; record 266
	dw $18c7 ; record 267
	dw $9d34 ; record 268
	dw $ffc0 ; record 269
	dw $eb00 ; record 270
	dw $ebfe ; record 271
	dw $9e36 ; record 272
	dw $c0bc ; record 273
	dw $00ff ; record 274
	dw $17eb ; record 275
	dw $7018 ; record 276
	dw $ba71 ; record 277
	dw $1ce2 ; record 278
	dw $1de5 ; record 279
	dw $c100 ; record 280
	dw $c09f ; record 281
	dw $80ff ; record 282
	dw $80ed ; record 283
	dw $8281 ; record 284
	dw $83bf ; record 285
	dw $853f ; record 286
	dw $1f19 ; record 287
	dw $803b ; record 288
	dw $c8e1 ; record 289
	dw $c0fc ; record 290
	dw $80ff ; record 291
	dw $90ed ; record 292
	dw $9291 ; record 293
	dw $9493 ; record 294
	dw $9795 ; record 295
	dw $2625 ; record 296
	dw $803c ; record 297
	dw $c9a1 ; record 298
	dw $ffc0 ; record 299
	dw $ed00 ; record 300
	dw $ffa0 ; record 301
	dw $a2a1 ; record 302
	dw $a4a3 ; record 303
	dw $a6a5 ; record 304
	dw $3da7 ; record 305
	dw $00f2 ; record 306
	dw $cae1 ; record 307
	dw $ffc0 ; record 308
	dw $ed00 ; record 309
	dw $b1b0 ; record 310
	dw $b3b2 ; record 311
	dw $b45f ; record 312
	dw $b6b5 ; record 313
	dw $3eb7 ; record 314
	dw $a100 ; record 315
	dw $c0cb ; record 316
	dw $fcff ; record 317
	dw $cd80 ; record 318
	dw $a028 ; record 319
	dw $c4c3 ; record 320
	dw $c6c5 ; record 321
	dw $e5c7 ; record 322
	dw $80f2 ; record 323
	dw $ccc1 ; record 324
	dw $ffc0 ; record 325
	dw $cd80 ; record 326
	dw $d1d0 ; record 327
	dw $d3d2 ; record 328
	dw $d45f ; record 329
	dw $d6d5 ; record 330
	dw $d8d7 ; record 331
	dw $8180 ; record 332
	dw $c0cd ; record 333
	dw $ac97 ; record 334
	dw $e0d8 ; record 335
	dw $eaff ; record 336
	dw $d9d8 ; record 337
	dw $d000 ; record 338
	dw $80ce ; record 339
	dw $3b96 ; record 340
	dw $3cbb ; record 341
	dw $ff3d ; record 342
	dw $3eed ; record 343
	dw $4342 ; record 344
	dw $ecff ; record 345
	dw $0144 ; record 346
	dw $40cf ; record 347
	dw $0089 ; record 348
	dw $0000 ; record 349
	dw $2d7d ; record 350
	dw $e9ff ; record 351
	dw $1c1b ; record 352
	dw $acab ; record 353
	dw $eead ; record 354
	dw $9fe8 ; record 355
	dw $dcdb ; record 356
	dw $1edd ; record 357
	dw $ff00 ; record 358
	dw $c0fb ; record 359
	dw $2bea ; record 360
	dw $2cff ; record 361
	dw $bcbb ; record 362
	dw $e0bd ; record 363
	dw $e2e1 ; record 364
	dw $ffe3 ; record 365
	dw $e5e4 ; record 366
	dw $e7e6 ; record 367
	dw $e9e8 ; record 368
	dw $ebea ; record 369
	dw $ece7 ; record 370
	dw $2eed ; record 371
	dw $ffc0 ; record 372
	dw $e9c0 ; record 373
	dw $cccb ; record 374
	dw $ffcd ; record 375
	dw $f1f0 ; record 376
	dw $f3f2 ; record 377
	dw $f5f4 ; record 378
	dw $f7f6 ; record 379
	dw $f83f ; record 380
	dw $faf9 ; record 381
	dw $fcfb ; record 382
	dw $c0fd ; record 383
	dw $80ff ; record 384
	dw $37e9 ; record 385
	dw $c1c0 ; record 386
	dw $ffc2 ; record 387
	dw $d5ea ; record 388
	dw $c0d6 ; record 389
	dw $40ff ; record 390
	dw $09e9 ; record 391
	dw $f1d4 ; record 392
	dw $e4ca ; record 393
	dw $d3c0 ; record 394
	dw $ffc0 ; record 395
	dw $ffc0 ; record 396
	dw $ffc0 ; record 397
	dw $ffc0 ; record 398
	dw $c000 ; record 399
	dw $c0ff ; record 400
	dw $c0ff ; record 401
	dw $c0ff ; record 402
	dw $c0ff ; record 403
	dw $c0ff ; record 404
	dw $c0ff ; record 405
	dw $c0ff ; record 406
	dw $00ff ; record 407
	dw $ffc0 ; record 408
	dw $ffc0 ; record 409
	dw $ffc0 ; record 410
	dw $ffc0 ; record 411
	dw $ffc0 ; record 412
	dw $ffc0 ; record 413
	dw $ffc0 ; record 414
	dw $ffc0 ; record 415
	dw $c07c ; record 416
	dw $c0ff ; record 417
	dw $2dff ; record 418
	dw $d02b ; record 419
	dw $d2d1 ; record 420
	dw $eaff ; record 421
	dw $d873 ; record 422
	dw $c0d9 ; record 423
	dw $beff ; record 424
	dw $3b68 ; record 425
	dw $3d3c ; record 426
	dw $edff ; record 427
	dw $3e01 ; record 428
	dw $fcc0 ; record 429
	dw $0000 ; record 430
	dw $d600 ; record 431
	dw $9c42 ; record 432
	dw $525b ; record 433
	dw $8422 ; record 434
	dw $8008 ; record 435
	dw $8408 ; record 436
	dw $5208 ; record 437
	dw $9c22 ; record 438
	dw $c25b ; record 439
	dw $5f59 ; record 440
	dw $df03 ; record 441
	dw $5002 ; record 442
	dw $df42 ; record 443
	dw $926b ; record 444
	dw $023a ; record 445
	dw $0029 ; record 446
	dw $4400 ; record 447
	dw $c262 ; record 448
	dw $4059 ; record 449
	dw $0049 ; record 450
	dw $8239 ; record 451
	dw $4059 ; record 452
	dw $8049 ; record 453
	dw $8008 ; record 454
	dw $9c08 ; record 455
	dw $945b ; record 456
	dw $843a ; record 457
	dw $ff08 ; record 458
	dw $5c03 ; record 459
	dw $b743 ; record 460
	dw $960d ; record 461
	dw $0c32 ; record 462
	dw $0011 ; record 463
	dw $b700 ; record 464
	dw $960d ; record 465
	dw $0c32 ; record 466
	dw $d611 ; record 467
	dw $9c42 ; record 468
	dw $525b ; record 469
	dw $8422 ; record 470
	dw $8008 ; record 471
	dw $8408 ; record 472
	dw $5208 ; record 473
	dw $5c22 ; record 474
	dw $5c43 ; record 475
	dw $b743 ; record 476
	dw $460d ; record 477
	dw $ff00 ; record 478
	dw $7303 ; record 479
	dw $c911 ; record 480
	dw $5f0d ; record 481
	dw $1416 ; record 482
	dw $d10a ; record 483
	dw $9c21 ; record 484
	dw $d65b ; record 485
	dw $0042 ; record 486
	dw $5f00 ; record 487
	dw $ff16 ; record 488
	dw $5403 ; record 489
	dw $0001 ; record 490
	dw $9c00 ; record 491
	dw $d65b ; record 492
	dw $8a42 ; record 493
	dw $c022 ; record 494
	dw $1f11 ; record 495
	dw $8400 ; record 496
	dw $1f08 ; record 497
	dw $f32a ; record 498
	dw $5f03 ; record 499
	dw $8416 ; record 500
	dw $1f08 ; record 501
	dw $f32a ; record 502
	dw $fd03 ; record 503
	dw $ff00 ; record 504
	dw $00ff ; record 505
	dw $0001 ; record 506
	dw $0107 ; record 507
	dw $ff0f ; record 508
	dw $1f06 ; record 509
	dw $3f08 ; record 510
	dw $301f ; record 511
	dw $601f ; record 512
	dw $3fff ; record 513
	dw $3f71 ; record 514
	dw $3f60 ; record 515
	dw $3f70 ; record 516
	dw $ef71 ; record 517
	dw $792f ; record 518
	dw $3837 ; record 519
	dw $e0f0 ; record 520
	dw $001c ; record 521
	dw $ff3e ; record 522
	dw $ff1c ; record 523
	dw $ff22 ; record 524
	dw $fff1 ; record 525
	dw $ff08 ; record 526
	dw $04ff ; record 527
	dw $82ff ; record 528
	dw $e27f ; record 529
	dw $f11f ; record 530
	dw $ff9f ; record 531
	dw $4ff1 ; record 532
	dw $8ff9 ; record 533
	dw $cff9 ; record 534
	dw $c97e ; record 535
	dw $bfdf ; record 536
	dw $bfc5 ; record 537
	dw $ff01 ; record 538
	dw $e1a2 ; record 539
	dw $00c0 ; record 540
	dw $e0ef ; record 541
	dw $f0c0 ; record 542
	dw $fe20 ; record 543
	dw $f8e1 ; record 544
	dw $fc10 ; record 545
	dw $08bf ; record 546
	dw $90f8 ; record 547
	dw $60f0 ; record 548
	dw $8be0 ; record 549
	dw $80e0 ; record 550
	dw $fefc ; record 551
	dw $82e2 ; record 552
	dw $38fd ; record 553
	dw $371f ; record 554
	dw $1f1f ; record 555
	dw $ff0c ; record 556
	dw $070f ; record 557
	dw $030f ; record 558
	dw $0d1f ; record 559
	dw $1c37 ; record 560
	dw $3fbf ; record 561
	dw $3f18 ; record 562
	dw $3718 ; record 563
	dw $f81c ; record 564
	dw $6fe1 ; record 565
	dw $38ff ; record 566
	dw $307f ; record 567
	dw $74df ; record 568
	dw $7cdf ; record 569
	dw $ff07 ; record 570
	dw $8ffe ; record 571
	dw $9efa ; record 572
	dw $7cf4 ; record 573
	dw $9cf0 ; record 574
	dw $f8ff ; record 575
	dw $e43e ; record 576
	dw $cefb ; record 577
	dw $1ef3 ; record 578
	dw $fff1 ; record 579
	dw $f91f ; record 580
	dw $f95f ; record 581
	dw $fc2f ; record 582
	dw $fc27 ; record 583
	dw $177f ; record 584
	dw $0fff ; record 585
	dw $48ff ; record 586
	dw $47ff ; record 587
	dw $ed22 ; record 588
	dw $8ae6 ; record 589
	dw $c0e3 ; record 590
	dw $fe80 ; record 591
	dw $02e5 ; record 592
	dw $03f7 ; record 593
	dw $0703 ; record 594
	dw $07cf ; record 595
	dw $0303 ; record 596
	dw $0c33 ; record 597
	dw $fee0 ; record 598
	dw $18e1 ; record 599
	dw $df0f ; record 600
	dw $0f18 ; record 601
	dw $070e ; record 602
	dw $fe0c ; record 603
	dw $0ee2 ; record 604
	dw $ff07 ; record 605
	dw $0b1e ; record 606
	dw $1f3f ; record 607
	dw $a0ff ; record 608
	dw $e1ff ; record 609
	dw $ffdf ; record 610
	dw $feff ; record 611
	dw $86fc ; record 612
	dw $e2fe ; record 613
	dw $fe43 ; record 614
	dw $43ff ; record 615
	dw $4bfe ; record 616
	dw $63fe ; record 617
	dw $61fe ; record 618
	dw $ffff ; record 619
	dw $df71 ; record 620
	dw $df77 ; record 621
	dw $d9ff ; record 622
	dw $56ff ; record 623
	dw $ff1f ; record 624
	dw $ff50 ; record 625
	dw $fff8 ; record 626
	dw $e200 ; record 627
	dw $ef80 ; record 628
	dw $e17e ; record 629
	dw $e01f ; record 630
	dw $f040 ; record 631
	dw $e070 ; record 632
	dw $c1f7 ; record 633
	dw $ff80 ; record 634
	dw $f880 ; record 635
	dw $f8ff ; record 636
	dw $85ff ; record 637
	dw $89ff ; record 638
	dw $8bff ; record 639
	dw $0dfe ; record 640
	dw $8047 ; record 641
	dw $c0f4 ; record 642
	dw $9a80 ; record 643
	dw $80cb ; record 644
	dw $00ed ; record 645
	dw $0000 ; record 646
	dw $00fd ; record 647
	dw $fcff ; record 648
	dw $1f38 ; record 649
	dw $1f37 ; record 650
	dw $0f18 ; record 651
	dw $0cff ; record 652
	dw $0f07 ; record 653
	dw $1f03 ; record 654
	dw $370d ; record 655
	dw $bf1c ; record 656
	dw $183f ; record 657
	dw $183f ; record 658
	dw $1c37 ; record 659
	dw $e1f8 ; record 660
	dw $ff6f ; record 661
	dw $7f38 ; record 662
	dw $df30 ; record 663
	dw $df74 ; record 664
	dw $077c ; record 665
	dw $feff ; record 666
	dw $fa0f ; record 667
	dw $f41e ; record 668
	dw $f07c ; record 669
	dw $ff9c ; record 670
	dw $3ef8 ; record 671
	dw $fbe4 ; record 672
	dw $f3ce ; record 673
	dw $f11e ; record 674
	dw $1fff ; record 675
	dw $5ff9 ; record 676
	dw $2ff9 ; record 677
	dw $27fc ; record 678
	dw $7ffc ; record 679
	dw $ff17 ; record 680
	dw $ff0f ; record 681
	dw $ff48 ; record 682
	dw $a047 ; record 683
	dw $8ded ; record 684
	dw $fe80 ; record 685
	dw $c0e2 ; record 686
	dw $fe80 ; record 687
	dw $80e5 ; record 688
	dw $60fd ; record 689
	dw $01e1 ; record 690
	dw $00ff ; record 691
	dw $0107 ; record 692
	dw $060f ; record 693
	dw $081f ; record 694
	dw $ff3f ; record 695
	dw $301f ; record 696
	dw $601f ; record 697
	dw $713f ; record 698
	dw $603f ; record 699
	dw $3fff ; record 700
	dw $3f70 ; record 701
	dw $2f79 ; record 702
	dw $3e79 ; record 703
	dw $ff39 ; record 704
	dw $301e ; record 705
	dw $1c1f ; record 706
	dw $3e00 ; record 707
	dw $ff1c ; record 708
	dw $22ff ; record 709
	dw $f1ff ; record 710
	dw $08ff ; record 711
	dw $04ff ; record 712
	dw $ffff ; record 713
	dw $7f82 ; record 714
	dw $1fe2 ; record 715
	dw $9ff1 ; record 716
	dw $4ff1 ; record 717
	dw $f9ff ; record 718
	dw $f98f ; record 719
	dw $7ecf ; record 720
	dw $ffc9 ; record 721
	dw $f785 ; record 722
	dw $01ff ; record 723
	dw $20ff ; record 724
	dw $c0e1 ; record 725
	dw $e000 ; record 726
	dw $fbc0 ; record 727
	dw $20f0 ; record 728
	dw $e1fe ; record 729
	dw $10f8 ; record 730
	dw $08fc ; record 731
	dw $eff8 ; record 732
	dw $f090 ; record 733
	dw $e060 ; record 734
	dw $e676 ; record 735
	dw $0024 ; record 736
	dw $ff7e ; record 737
	dw $db24 ; record 738
	dw $c57e ; record 739
	dw $617f ; record 740
	dw $383f ; record 741
	dw $1fff ; record 742
	dw $071c ; record 743
	dw $070c ; record 744
	dw $0306 ; record 745
	dw $fb03 ; record 746
	dw $0101 ; record 747
	dw $ec00 ; record 748
	dw $0c1f ; record 749
	dw $078f ; record 750
	dw $ff9b ; record 751
	dw $f70f ; record 752
	dw $679d ; record 753
	dw $4ffc ; record 754
	dw $0ff8 ; record 755
	dw $f8ff ; record 756
	dw $fc1f ; record 757
	dw $e4ff ; record 758
	dw $08ff ; record 759
	dw $ff3f ; record 760
	dw $3f08 ; record 761
	dw $3f10 ; record 762
	dw $3f14 ; record 763
	dw $071c ; record 764
	dw $feef ; record 765
	dw $fa8f ; record 766
	dw $009e ; record 767
	dw $9ee0 ; record 768
	dw $3ff8 ; record 769
	dw $e6ff ; record 770
	dw $cff9 ; record 771
	dw $0ff9 ; record 772
	dw $0ff9 ; record 773
	dw $7ffc ; record 774
	dw $fc57 ; record 775
	dw $e03f ; record 776
	dw $f03f ; record 777
	dw $001f ; record 778
	dw $93e1 ; record 779
	dw $44fe ; record 780
	dw $f704 ; record 781
	dw $e905 ; record 782
	dw $1c01 ; record 783
	dw $16e0 ; record 784
	dw $03e3 ; record 785
	dw $01f9 ; record 786
	dw $e1fe ; record 787
	dw $e77e ; record 788
	dw $1f38 ; record 789
	dw $3f77 ; record 790
	dw $ffdf ; record 791
	dw $877c ; record 792
	dw $87ff ; record 793
	dw $c7ff ; record 794
	dw $e77d ; record 795
	dw $7cfb ; record 796
	dw $808f ; record 797
	dw $17e0 ; record 798
	dw $0ffc ; record 799
	dw $9ffc ; record 800
	dw $f80f ; record 801
	dw $68ff ; record 802
	dw $807f ; record 803
	dw $80ea ; record 804
	dw $80df ; record 805
	dw $00d3 ; record 806
	dw $0000 ; record 807
	dw $00fd ; record 808
	dw $f6ff ; record 809
	dw $0303 ; record 810
	dw $0707 ; record 811
	dw $0303 ; record 812
	dw $d3ff ; record 813
	dw $f07f ; record 814
	dw $d07f ; record 815
	dw $707f ; record 816
	dw $7f3f ; record 817
	dw $0f38 ; record 818
	dw $0f18 ; record 819
	dw $070e ; record 820
	dw $fe0c ; record 821
	dw $ffe2 ; record 822
	dw $070e ; record 823
	dw $0b1e ; record 824
	dw $1f3f ; record 825
	dw $a0ff ; record 826
	dw $ffff ; record 827
	dw $ffe1 ; record 828
	dw $f8ff ; record 829
	dw $85ff ; record 830
	dw $ffff ; record 831
	dw $ff89 ; record 832
	dw $fe8b ; record 833
	dw $fe47 ; record 834
	dw $fe43 ; record 835
	dw $4bff ; record 836
	dw $63fe ; record 837
	dw $61fe ; record 838
	dw $71ff ; record 839
	dw $ffdf ; record 840
	dw $df77 ; record 841
	dw $d9ff ; record 842
	dw $56ff ; record 843
	dw $50ff ; record 844
	dw $e37e ; record 845
	dw $ffe0 ; record 846
	dw $80c0 ; record 847
	dw $0080 ; record 848
	dw $9b80 ; record 849
	dw $fce8 ; record 850
	dw $e1f2 ; record 851
	dw $e1ee ; record 852
	dw $80c0 ; record 853
	dw $40e0 ; record 854
	dw $70f0 ; record 855
	dw $e0ff ; record 856
	dw $24e0 ; record 857
	dw $7e00 ; record 858
	dw $db24 ; record 859
	dw $7f7e ; record 860
	dw $7fc5 ; record 861
	dw $3f61 ; record 862
	dw $1f38 ; record 863
	dw $a01c ; record 864
	dw $dfe0 ; record 865
	dw $0306 ; record 866
	dw $0103 ; record 867
	dw $6b01 ; record 868
	dw $38e8 ; record 869
	dw $ff1f ; record 870
	dw $1f37 ; record 871
	dw $0f18 ; record 872
	dw $078c ; record 873
	dw $0f9b ; record 874
	dw $f7ff ; record 875
	dw $679d ; record 876
	dw $4ffc ; record 877
	dw $0ff8 ; record 878
	dw $fff8 ; record 879
	dw $fc1f ; record 880
	dw $e4ff ; record 881
	dw $08ff ; record 882
	dw $083f ; record 883
	dw $3fff ; record 884
	dw $3f10 ; record 885
	dw $3f14 ; record 886
	dw $071c ; record 887
	dw $fffe ; record 888
	dw $fa0f ; record 889
	dw $f41e ; record 890
	dw $f07c ; record 891
	dw $f89e ; record 892
	dw $3fff ; record 893
	dw $f9e6 ; record 894
	dw $f9cf ; record 895
	dw $f90f ; record 896
	dw $ff0f ; record 897
	dw $57fc ; record 898
	dw $3ffc ; record 899
	dw $3fe0 ; record 900
	dw $1ff0 ; record 901
	dw $ff3f ; record 902
	dw $ff0f ; record 903
	dw $fe48 ; record 904
	dw $2044 ; record 905
	dw $86e9 ; record 906
	dw $64e5 ; record 907
	dw $e3fe ; record 908
	dw $e96a ; record 909
	dw $fe01 ; record 910
	dw $f8e0 ; record 911
	dw $03e3 ; record 912
	dw $fe01 ; record 913
	dw $fee1 ; record 914
	dw $e77e ; record 915
	dw $1f38 ; record 916
	dw $3f77 ; record 917
	dw $7fd8 ; record 918
	dw $ff84 ; record 919
	dw $87ff ; record 920
	dw $c7ff ; record 921
	dw $e77d ; record 922
	dw $8f7c ; record 923
	dw $80fe ; record 924
	dw $17e0 ; record 925
	dw $0ffc ; record 926
	dw $9ffc ; record 927
	dw $fff8 ; record 928
	dw $68fb ; record 929
	dw $807f ; record 930
	dw $9cea ; record 931
	dw $3ef8 ; record 932
	dw $fbe4 ; record 933
	dw $ceff ; record 934
	dw $1ef3 ; record 935
	dw $1ff1 ; record 936
	dw $5ff9 ; record 937
	dw $dff9 ; record 938
	dw $fc2f ; record 939
	dw $fc27 ; record 940
	dw $8017 ; record 941
	dw $ffe1 ; record 942
	dw $e447 ; record 943
	dw $cda0 ; record 944
	dw $eb7c ; record 945
	dw $e5c0 ; record 946
	dw $80c9 ; record 947
	dw $73d2 ; record 948
	dw $303f ; record 949
	dw $1f75 ; record 950
	dw $e1fe ; record 951
	dw $8018 ; record 952
	dw $fed4 ; record 953
	dw $86fc ; record 954
	dw $e2fe ; record 955
	dw $431d ; record 956
	dw $d180 ; record 957
	dw $fff0 ; record 958
	dw $80ff ; record 959
	dw $80f3 ; record 960
	dw $00c7 ; record 961
	dw $0000 ; record 962
	dw $00fd ; record 963
	dw $feff ; record 964
	dw $0001 ; record 965
	dw $0103 ; record 966
	dw $030f ; record 967
	dw $1fff ; record 968
	dw $3f0c ; record 969
	dw $3f10 ; record 970
	dw $7817 ; record 971
	dw $ef2f ; record 972
	dw $3f70 ; record 973
	dw $3f6c ; record 974
	dw $e1fc ; record 975
	dw $3b7c ; record 976
	dw $ff6c ; record 977
	dw $3e37 ; record 978
	dw $3417 ; record 979
	dw $f01f ; record 980
	dw $f800 ; record 981
	dw $f0ff ; record 982
	dw $08fe ; record 983
	dw $e6ff ; record 984
	dw $19ff ; record 985
	dw $ffff ; record 986
	dw $ff05 ; record 987
	dw $3fc2 ; record 988
	dw $0ff2 ; record 989
	dw $67f9 ; record 990
	dw $fdff ; record 991
	dw $fd17 ; record 992
	dw $fe27 ; record 993
	dw $de77 ; record 994
	dw $5f75 ; record 995
	dw $65bf ; record 996
	dw $01bf ; record 997
	dw $a0ff ; record 998
	dw $80e5 ; record 999
	dw $e0fe ; record 1000
	dw $c0ff ; record 1001
	dw $c080 ; record 1002
	dw $e080 ; record 1003
	dw $e040 ; record 1004
	dw $b5c0 ; record 1005
	dw $eec0 ; record 1006
	dw $80e6 ; record 1007
	dw $e081 ; record 1008
	dw $0707 ; record 1009
	dw $e37c ; record 1010
	dw $af02 ; record 1011
	dw $0300 ; record 1012
	dw $0700 ; record 1013
	dw $e0fe ; record 1014
	dw $f803 ; record 1015
	dw $0fe4 ; record 1016
	dw $00d3 ; record 1017
	dw $ee0b ; record 1018
	dw $60e0 ; record 1019
	dw $04e0 ; record 1020
	dw $e35c ; record 1021
	dw $0018 ; record 1022
	dw $3077 ; record 1023
	dw $e000 ; record 1024
	dw $e0fe ; record 1025
	dw $00a0 ; record 1026
	dw $fec0 ; record 1027
	dw $7fe0 ; record 1028
	dw $00e0 ; record 1029
	dw $00f0 ; record 1030
	dw $07b0 ; record 1031
	dw $c0b8 ; record 1032
	dw $12ff ; record 1033
	dw $eac0 ; record 1034
	dw $caf0 ; record 1035
	dw $c0e0 ; record 1036
	dw $00e8 ; record 1037
	dw $ffc0 ; record 1038
	dw $ff80 ; record 1039
	dw $c0de ; record 1040
	dw $0175 ; record 1041
	dw $fac0 ; record 1042
	dw $8002 ; record 1043
	dw $06f2 ; record 1044
	dw $02c0 ; record 1045
	dw $e300 ; record 1046
	dw $ff00 ; record 1047
	dw $ffff ; record 1048
	dw $ffff ; record 1049
	dw $ffff ; record 1050
	dw $00f5 ; record 1051
	dw $0000 ; record 1052
	dw $00fd ; record 1053
	dw $fcff ; record 1054
	dw $1f32 ; record 1055
	dw $3f70 ; record 1056
	dw $1f39 ; record 1057
	dw $1eff ; record 1058
	dw $1f07 ; record 1059
	dw $370f ; record 1060
	dw $371d ; record 1061
	dw $ff1c ; record 1062
	dw $386f ; record 1063
	dw $386f ; record 1064
	dw $7cc7 ; record 1065
	dw $7ccf ; record 1066
	dw $cfff ; record 1067
	dw $6f78 ; record 1068
	dw $7f38 ; record 1069
	dw $df30 ; record 1070
	dw $ff74 ; record 1071
	dw $7cdf ; record 1072
	dw $fe07 ; record 1073
	dw $fd0f ; record 1074
	dw $f21f ; record 1075
	dw $3eff ; record 1076
	dw $dff0 ; record 1077
	dw $3dfe ; record 1078
	dw $f8e7 ; record 1079
	dw $ffcf ; record 1080
	dw $0ff8 ; record 1081
	dw $0ffc ; record 1082
	dw $53fe ; record 1083
	dw $21f7 ; record 1084
	dw $feff ; record 1085
	dw $ff27 ; record 1086
	dw $e719 ; record 1087
	dw $c33d ; record 1088
	dw $df7f ; record 1089
	dw $7ee3 ; record 1090
	dw $0000 ; record 1091
	dw $9d80 ; record 1092
	dw $80e4 ; record 1093
	dw $ff00 ; record 1094
	dw $80c0 ; record 1095
	dw $80c0 ; record 1096
	dw $c060 ; record 1097
	dw $e030 ; record 1098
	dw $fede ; record 1099
	dw $60e1 ; record 1100
	dw $c0c0 ; record 1101
	dw $e680 ; record 1102
	dw $00e5 ; record 1103
	dw $ff00 ; record 1104
	dw $0f0f ; record 1105
	dw $1916 ; record 1106
	dw $302f ; record 1107
	dw $203f ; record 1108
	dw $5fff ; record 1109
	dw $6f60 ; record 1110
	dw $9f70 ; record 1111
	dw $bfe0 ; record 1112
	dw $ffc0 ; record 1113
	dw $6659 ; record 1114
	dw $372a ; record 1115
	dw $1b15 ; record 1116
	dw $0f09 ; record 1117
	dw $06ff ; record 1118
	dw $0006 ; record 1119
	dw $1c00 ; record 1120
	dw $2a1c ; record 1121
	dw $ff36 ; record 1122
	dw $e2de ; record 1123
	dw $c6ba ; record 1124
	dw $8c74 ; record 1125
	dw $18e8 ; record 1126
	dw $d0ff ; record 1127
	dw $b030 ; record 1128
	dw $a870 ; record 1129
	dw $f858 ; record 1130
	dw $0608 ; record 1131
	dw $e1f6 ; record 1132
	dw $e0e0 ; record 1133
	dw $fd44 ; record 1134
	dw $ffff ; record 1135
	dw $ffff ; record 1136
	dw $ffff ; record 1137
	dw $c3be ; record 1138
	dw $01ff ; record 1139
	dw $0200 ; record 1140
	dw $0501 ; record 1141
	dw $0a02 ; record 1142
	dw $3f04 ; record 1143
	dw $0814 ; record 1144
	dw $0814 ; record 1145
	dw $1028 ; record 1146
	dw $e3fe ; record 1147
	dw $e1f4 ; record 1148
	dw $227e ; record 1149
	dw $00e2 ; record 1150
	dw $0f70 ; record 1151
	dw $708f ; record 1152
	dw $1070 ; record 1153
	dw $fee8 ; record 1154
	dw $cb8a ; record 1155
	dw $00f8 ; record 1156
	dw $f804 ; record 1157
	dw $08f4 ; record 1158
	dw $fc04 ; record 1159
	dw $f2fe ; record 1160
	dw $c160 ; record 1161
	dw $001f ; record 1162
	dw $1f20 ; record 1163
	dw $102f ; record 1164
	dw $20f9 ; record 1165
	dw $f2fe ; record 1166
	dw $c140 ; record 1167
	dw $00f0 ; record 1168
	dw $f00e ; record 1169
	dw $eff1 ; record 1170
	dw $0e0e ; record 1171
	dw $0101 ; record 1172
	dw $d833 ; record 1173
	dw $0080 ; record 1174
	dw $1f40 ; record 1175
	dw $a080 ; record 1176
	dw $5040 ; record 1177
	dw $6820 ; record 1178
	dw $58e5 ; record 1179
	dw $00e5 ; record 1180
	dw $0000 ; record 1181
	dw $00fd ; record 1182
	dw $f6ff ; record 1183
	dw $0303 ; record 1184
	dw $0707 ; record 1185
	dw $0303 ; record 1186
	dw $73ef ; record 1187
	dw $303f ; record 1188
	dw $fe1f ; record 1189
	dw $18e1 ; record 1190
	dw $180f ; record 1191
	dw $0fef ; record 1192
	dw $070e ; record 1193
	dw $fe0c ; record 1194
	dw $0ee2 ; record 1195
	dw $1e07 ; record 1196
	dw $0bff ; record 1197
	dw $1f3f ; record 1198
	dw $a0ff ; record 1199
	dw $e1ff ; record 1200
	dw $efff ; record 1201
	dw $feff ; record 1202
	dw $86fc ; record 1203
	dw $e2fe ; record 1204
	dw $fe43 ; record 1205
	dw $ff43 ; record 1206
	dw $4bfe ; record 1207
	dw $63fe ; record 1208
	dw $61fe ; record 1209
	dw $71ff ; record 1210
	dw $dfff ; record 1211
	dw $df77 ; record 1212
	dw $dbff ; record 1213
	dw $50ff ; record 1214
	dw $5fff ; record 1215
	dw $ff53 ; record 1216
	dw $fff7 ; record 1217
	dw $a0ff ; record 1218
	dw $80ed ; record 1219
	dw $e2fe ; record 1220
	dw $c0ff ; record 1221
	dw $e080 ; record 1222
	dw $e040 ; record 1223
	dw $f0c0 ; record 1224
	dw $03f0 ; record 1225
	dw $e0e0 ; record 1226
	dw $f780 ; record 1227
	dw $ffff ; record 1228
	dw $ffff ; record 1229
	dw $ffff ; record 1230
	dw $ffff ; record 1231
	dw $fbfc ; record 1232
	dw $0a7f ; record 1233
	dw $0504 ; record 1234
	dw $0202 ; record 1235
	dw $0101 ; record 1236
	dw $f8d7 ; record 1237
	dw $80ff ; record 1238
	dw $7000 ; record 1239
	dw $8f80 ; record 1240
	dw $7070 ; record 1241
	dw $ed0f ; record 1242
	dw $950f ; record 1243
	dw $04d2 ; record 1244
	dw $fe08 ; record 1245
	dw $f4e1 ; record 1246
	dw $0408 ; record 1247
	dw $f8db ; record 1248
	dw $75f8 ; record 1249
	dw $20d2 ; record 1250
	dw $fe10 ; record 1251
	dw $2fe1 ; record 1252
	dw $f710 ; record 1253
	dw $1f20 ; record 1254
	dw $551f ; record 1255
	dw $01d4 ; record 1256
	dw $0e00 ; record 1257
	dw $df01 ; record 1258
	dw $0ef1 ; record 1259
	dw $f00e ; record 1260
	dw $35f0 ; record 1261
	dw $50d2 ; record 1262
	dw $1f20 ; record 1263
	dw $40a0 ; record 1264
	dw $8040 ; record 1265
	dw $3780 ; record 1266
	dw $00f6 ; record 1267
	dw $0000 ; record 1268
	dw $014b ; record 1269
	dw $7fff ; record 1270
	dw $121f ; record 1271
	dw $0000 ; record 1272
	dw $014b ; record 1273
	dw $7e5f ; record 1274
	dw $7ec0 ; record 1275
	dw $281c ; record 1276
	dw $7fe0 ; record 1277
	dw $00ff ; record 1278
	dw $7d80 ; record 1279
	dw $0000 ; record 1280
	dw $7fe0 ; record 1281
	dw $6bff ; record 1282
	dw $7ece ; record 1283
	dw $0000 ; record 1284
	dw $7fe0 ; record 1285
	dw $00ff ; record 1286
	dw VarsityTeamChartTilemap ; record 1287
	dw $0000 ; record 1288
	dw $7fe0 ; record 1289
	dw $165f ; record 1290
	dw $03ff ; record 1291
	dw $0000 ; record 1292
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
	ldh a, [hVBlankCounter] ; $4e80
	and a, $03 ; $4e82
	cp a, $03 ; $4e84
	jr nz, Label_3f_4e89 ; $4e86
	xor a, a ; $4e88
Label_3f_4e89:
	ld [$cb38], a ; $4e89
	ret ; $4e8c
Func_3f_4e8d:
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
	ld hl, SpriteTemplate_3f_50d0 ; $4f2f
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
	ld hl, SpriteTemplate_3f_50d9 ; $4f4a
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
	ld hl, SpriteTemplate_3f_50d9 ; $4f65
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
	ld hl, SpriteTemplate_3f_50d9 ; $4f7f
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
	ld hl, SpriteTemplate_3f_501f ; $4fbd
	ld bc, $0b28 ; $4fc0
	call QueueSpriteTemplate ; $4fc3
	ld a, [$cb37] ; $4fc6
	bit 2, a ; $4fc9
	jr z, Label_3f_4fd9 ; $4fcb
	ld hl, SpriteTemplate_3f_5006 ; $4fcd
	ld de, $1810 ; $4fd0
	ld bc, $0d34 ; $4fd3
	call QueueSpriteTemplate ; $4fd6
Label_3f_4fd9:
	ld a, [$cb37] ; $4fd9
	bit 3, a ; $4fdc
	jr z, Label_3f_4fec ; $4fde
	ld hl, SpriteTemplate_3f_5006 ; $4fe0
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
	INCBIN "data/bank_03f/d_4ff6.bin" ; $4ff6, 16 bytes
SpriteTemplate_3f_5006:
	; $5006, 25 bytes (sprite_template)
	oam_sprite $00, $00, $00, $00
	oam_sprite $10, $00, $20, $00
	oam_sprite $00, $08, $02, $00
	oam_sprite $10, $08, $22, $00
	oam_sprite $00, $10, $04, $00
	oam_sprite $10, $10, $24, $00
	oam_sprite_end
SpriteTemplate_3f_501f:
	; $501f, 9 bytes (sprite_template)
	oam_sprite $00, $00, $00, $00
	oam_sprite $00, $08, $02, $00
	oam_sprite_end
	INCBIN "data/bank_03f/d_5028.bin" ; $5028, 168 bytes
SpriteTemplate_3f_50d0:
	; $50d0, 9 bytes (sprite_template)
	oam_sprite $00, $00, $00, $00
	oam_sprite $00, $08, $02, $00
	oam_sprite_end
SpriteTemplate_3f_50d9:
	; $50d9, 17 bytes (sprite_template)
	oam_sprite $00, $00, $00, $00
	oam_sprite $00, $08, $02, $00
	oam_sprite $00, $10, $04, $00
	oam_sprite $00, $18, $06, $00
	oam_sprite_end
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
	farcall FarPtr_PrepareGlyphBuffer ; $5261
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
	ld hl, wGlyphPenX ; $52bb
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
	ld a, [wShadowTilemapBank] ; $5306
	push af ; $5309
	ld a, $03 ; $530a
	ld [wShadowTilemapBank], a ; $530c
	ld a, c ; $530f
	ld c, $0c ; $5310
	farcall FarPtr_RenderProportionalTextAt ; $5312
	ld c, a ; $5315
	pop af ; $5316
	ld [wShadowTilemapBank], a ; $5317
	pop de ; $531a
	pop hl ; $531b
	ld a, b ; $531c
	cp a, $06 ; $531d
	jr nz, Label_3f_52d5 ; $531f
	farcall FarPtr_RestoreShadowTilemap ; $5321
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
	farcall FarPtr_RenderTextToBuffer64 ; $536c
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
	farcall FarPtr_RenderTextToBuffer64 ; $5382
	ld a, $06 ; $5385
	ld [$d040], a ; $5387
Label_3f_538a:
	ld hl, $d050 ; $538a
	ld de, $9830 ; $538d
	ld c, $01 ; $5390
	call QueueVRAMCopy ; $5392
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
	call QueueVRAMCopy ; $5521
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
	call QueueVRAMCopy ; $5536
	wram_bank $06 ; $5539
	ret ; $553f
	INCBIN "data/bank_03f/d_5540.bin" ; $5540, 72 bytes
Func_3f_5588:
	push bc ; $5588
	push af ; $5589
	wram_bank $06 ; $558a
	ldh a, [hInputRisingEdge] ; $5590
	bit PADB_A, a ; $5592
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
	bit PADB_UP, a ; $55ac
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
	ldh a, [hInputRisingEdge] ; $5611
	bit PADB_A, a ; $5613
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
	farcall FarPtr_ResetTextWindowsAndRestoreMap ; $564f
	ld a, $05 ; $5652
	ld [wShadowTilemapBank], a ; $5654
	pop hl ; $5657
	ld d, $00 ; $5658
	ld e, $06 ; $565a
	ld b, $14 ; $565c
	ld c, $05 ; $565e
	farcall FarPtr_CreateDialogueWindow ; $5660
	push hl ; $5663
	xor a, a ; $5664
	farcall FarPtr_AddTextIdOffset ; $5665
	ld b, $00 ; $5668
	farcall FarPtr_SetWindowTextId ; $566a
	pop hl ; $566d
	ld a, [wMessageSpeed] ; $566e
	push af ; $5671
	xor a, a ; $5672
	ld a, $80 ; $5673
	ld [wMessageSpeed], a ; $5675
	xor a, a ; $5678
	set_flag $04, 3 ; $5679
	farcall FarPtr_RedrawWindowText ; $567c
	clear_flag $04, 3 ; $567f
	pop af ; $5682
	ld [wMessageSpeed], a ; $5683
	xor a, a ; $5686
	farcall FarPtr_RestoreTilemapUnderWindow ; $5687
	farcall FarPtr_RedrawWindowRowsSafe ; $568a
	farcall FarPtr_CloseWindowAlt ; $568d
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
	bit PADB_UP, a ; $56c0
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
	call QueueVRAMCopy ; $575a
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
	call QueueVRAMCopy ; $5770
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
	call QueueVRAMCopy ; $5786
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
	call QueueVRAMCopy ; $57a0
	ld hl, $d0f0 ; $57a3
	ld de, $98f0 ; $57a6
	ld c, $01 ; $57a9
	call QueueVRAMCopy ; $57ab
	ld hl, $d130 ; $57ae
	ld de, $9930 ; $57b1
	ld c, $01 ; $57b4
	call QueueVRAMCopy ; $57b6
	ld hl, $d170 ; $57b9
	ld de, $9970 ; $57bc
	ld c, $01 ; $57bf
	call QueueVRAMCopy ; $57c1
	ld hl, $d1b0 ; $57c4
	ld de, $99b0 ; $57c7
	ld c, $01 ; $57ca
	call QueueVRAMCopy ; $57cc
	ld hl, $d1f0 ; $57cf
	ld de, $99f0 ; $57d2
	ld c, $01 ; $57d5
	call QueueVRAMCopy ; $57d7
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
Lz_3f_7b90:
	INCBIN "data/bank_03f/lz_7b90.bin" ; $7b90, 185 bytes
	ds 951, $ff ; $7c49, fill
