INCLUDE "hardware.inc"
INCLUDE "macros.inc"
INCLUDE "ram_constants.asm"

SECTION "ROM Bank $6b", ROMX[$4000], BANK[$6b]

FarPtr_6b_00:
	dw Func_6b_402a ; $4000
FarPtr_6b_02:
	dw Func_6b_75af ; $4002
DataPtr_TitleScreenTilemap:
	dw TitleScreenTilemap ; $4004
DataPtr_TitleScreenAttrmap:
	dw TitleScreenAttrmap ; $4006
DataPtr_TitleScreenPalettes:
	dw TitleScreenPalettes ; $4008
FarPtr_Func_6b_73f2:
	dw Func_6b_73f2 ; $400a
FarPtr_Func_6b_73f2Alias1:
	dw Func_6b_73f2 ; $400c
FarPtr_Func_6b_73f2Alias2:
	dw Func_6b_73f2 ; $400e
FarPtr_Func_6b_73f2Alias3:
	dw Func_6b_73f2 ; $4010
FarPtr_6b_12:
	dw Func_6b_51ae ; $4012
FarPtr_6b_14:
	dw Func_6b_51e7 ; $4014
FarPtr_6b_16:
	dw Func_6b_6075 ; $4016
FarPtr_6b_18:
	dw Func_6b_6126 ; $4018
DataPtr_AwardCeremonyTilemap:
	dw AwardCeremonyTilemap ; $401a
DataPtr_AwardCeremonyAttrmap:
	dw AwardCeremonyAttrmap ; $401c
DataPtr_AwardCeremonyTilemap2:
	dw AwardCeremonyTilemap2 ; $401e
DataPtr_AwardCeremonyAttrmap2:
	dw AwardCeremonyAttrmap2 ; $4020
DataPtr_AwardCeremonyTilemap3:
	dw AwardCeremonyTilemap3 ; $4022
DataPtr_AwardCeremonyAttrmap3:
	dw AwardCeremonyAttrmap3 ; $4024
DataPtr_AwardCeremonyTilemap4:
	dw AwardCeremonyTilemap4 ; $4026
DataPtr_AwardCeremonyAttrmap4:
	dw AwardCeremonyAttrmap4 ; $4028
Func_6b_402a:
	xor a, a ; $402a
	ld [$cb3f], a ; $402b
	ld [$cb40], a ; $402e
	ld [wIntroCutsceneCheck], a ; $4031
	ld [$cb42], a ; $4034
	ld [$cb43], a ; $4037
	ldh [$ff98], a ; $403a
	ld hl, rLCDC ; $403c
	res 3, [hl] ; $403f
	sound $01 ; $4041
	ld a, $01 ; $4043
	ld hl, $53f1 ; $4045
	call RegisterFrameTask ; $4048
	call Func_6b_406a ; $404b
	ld c, $7f ; $404e
	call Func_00_1d20 ; $4050
	call Func_00_1da4 ; $4053
	call ClearFrameTasks ; $4056
	ld hl, rIE ; $4059
	res 1, [hl] ; $405c
	xor a, a ; $405e
	ldh [$ff98], a ; $405f
	ld hl, rLCDC ; $4061
	res 3, [hl] ; $4064
	call Func_00_188b ; $4066
	ret ; $4069
Func_6b_406a:
	ld a, [$cb3f] ; $406a
	ld l, a ; $406d
	ld h, $00 ; $406e
	add hl, hl ; $4070
	ld de, $40bd ; $4071
	add hl, de ; $4074
	ld a, [hl+] ; $4075
	ld h, [hl] ; $4076
	ld l, a ; $4077
	ld a, [hl+] ; $4078
	ld h, [hl] ; $4079
	ld l, a ; $407a
	jp hl ; $407b
Label_6b_407c:
	ld a, [wIntroCutsceneCheck] ; $407c
	or a, a ; $407f
	jr nz, Label_6b_40bc ; $4080
	call Func_00_2631 ; $4082
	ld a, [$cb3f] ; $4085
	ld l, a ; $4088
	ld h, $00 ; $4089
	add hl, hl ; $408b
	ld de, $40bd ; $408c
	add hl, de ; $408f
	ld a, [hl+] ; $4090
	ld h, [hl] ; $4091
	ld l, a ; $4092
	inc hl ; $4093
	inc hl ; $4094
	ld a, [hl+] ; $4095
	ld h, [hl] ; $4096
	ld l, a ; $4097
	jp hl ; $4098
Label_6b_4099:
	ld a, [$cb3f] ; $4099
	ld l, a ; $409c
	ld h, $00 ; $409d
	add hl, hl ; $409f
	ld de, $40bd ; $40a0
	add hl, de ; $40a3
	ld a, [hl+] ; $40a4
	ld h, [hl] ; $40a5
	ld l, a ; $40a6
	inc hl ; $40a7
	inc hl ; $40a8
	inc hl ; $40a9
	inc hl ; $40aa
	ld a, [hl+] ; $40ab
	ld h, [hl] ; $40ac
	ld l, a ; $40ad
	jp hl ; $40ae
Label_6b_40af:
	ld a, [$cb3f] ; $40af
	inc a ; $40b2
	ld [$cb3f], a ; $40b3
	ld a, [wIntroCutsceneCheck] ; $40b6
	or a, a ; $40b9
	jr z, Func_6b_406a ; $40ba
Label_6b_40bc:
	ret ; $40bc
	INCBIN "data/bank_06b/d_40bd.bin" ; $40bd, 156 bytes
Unused_6b_UpdateHandler_4159:
	jp Label_6b_407c ; $4159
	jp Label_6b_40af ; $415c
Unused_6b_ExitHandler_415f:
	xor a, a ; $415f
	ld [$cb40], a ; $4160
	jp Label_6b_40af ; $4163
	ld a, $01 ; $4166
	ld [wIntroCutsceneCheck], a ; $4168
	jp Label_6b_407c ; $416b
	jp Label_6b_407c ; $416e
	xor a, a ; $4171
	ld [$cb40], a ; $4172
	jp Label_6b_407c ; $4175
	xor a, a ; $4178
	ld [$cb40], a ; $4179
	jp Label_6b_40af ; $417c
	ld a, [$cb40] ; $417f
	inc a ; $4182
	ld [$cb40], a ; $4183
	cp a, $0a ; $4186
	jp z, Label_6b_4099 ; $4188
	jp Label_6b_407c ; $418b
	call Func_6b_54b9 ; $418e
	call Func_6b_6075 ; $4191
	xor a, a ; $4194
	ld [$c322], a ; $4195
	ld a, $24 ; $4198
	ld [$c323], a ; $419a
	xor a, a ; $419d
	ld [$cb40], a ; $419e
	ld [$cb4c], a ; $41a1
	ld [$cb44], a ; $41a4
	ld [$cb4d], a ; $41a7
	xor a, a ; $41aa
	ld [$c322], a ; $41ab
	ld a, $24 ; $41ae
	ld [$c323], a ; $41b0
	ld de, $015c ; $41b3
	ld hl, $cb48 ; $41b6
	ld a, e ; $41b9
	ld [hl+], a ; $41ba
	ld [hl], d ; $41bb
	ld de, $0120 ; $41bc
	ld hl, $cb4a ; $41bf
	ld a, e ; $41c2
	ld [hl+], a ; $41c3
	ld [hl], d ; $41c4
	call EnableLCD ; $41c5
	ld c, $20 ; $41c8
	call Func_00_1d2e ; $41ca
	call Func_00_1da4 ; $41cd
	jp Label_6b_407c ; $41d0
	ld c, $0a ; $41d3
	call Func_00_1d20 ; $41d5
	call Func_00_1da4 ; $41d8
	call ClearFrameTasks ; $41db
	ld a, $01 ; $41de
	ld hl, $53f1 ; $41e0
	call RegisterFrameTask ; $41e3
	xor a, a ; $41e6
	ldh [$ff8b], a ; $41e7
	ldh [$ff8a], a ; $41e9
	ld [$c320], a ; $41eb
	ld [$c321], a ; $41ee
	ld [$c322], a ; $41f1
	ld [$c323], a ; $41f4
	jp Label_6b_40af ; $41f7
	ld a, [$cb40] ; $41fa
	inc a ; $41fd
	ld [$cb40], a ; $41fe
	cp a, $80 ; $4201
	jp z, Label_6b_4099 ; $4203
	cp a, $64 ; $4206
	jr nc, Label_6b_420d ; $4208
	call Func_6b_6115 ; $420a
Label_6b_420d:
	call Func_6b_4d61 ; $420d
	call Func_6b_4c9e ; $4210
	call Func_6b_60d5 ; $4213
	call Func_6b_60f8 ; $4216
	call Func_6b_4e2d ; $4219
	jp Label_6b_407c ; $421c
	call DisableLCDSafely ; $421f
	xor a, a ; $4222
	ld [$cb42], a ; $4223
	ld [$cb40], a ; $4226
	ld a, $d0 ; $4229
	ld [$cb44], a ; $422b
	ld a, $28 ; $422e
	ld [$cb45], a ; $4230
	ld a, $30 ; $4233
	ld [$cb46], a ; $4235
	ld a, $28 ; $4238
	ld [$cb47], a ; $423a
	ld c, $16 ; $423d
	farcall FarPtr_LoadScreenAssetRecord ; $423f
	call Func_6b_520a ; $4242
	ldh a, [hWramBank] ; $4245
	push af ; $4247
	wram_bank $03 ; $4248
	ld h, $8a ; $424e
	ld de, $d560 ; $4250
	ld b, $20 ; $4253
	ld c, $01 ; $4255
	farcall FarPtr_39_0c ; $4257
	pop af ; $425a
	wram_bank ; $425b
	farcall FarPtr_Func_39_4325 ; $425f
	wram_bank $01 ; $4262
	ld hl, $6c2a ; $4268 -> DataPtr_IntroSwingTiles
	ld de, $d000 ; $426b
	call DecompressDataFromBank ; $426e
	ld hl, $d000 ; $4271
	ld de, $9000 ; $4274
	ld c, $80 ; $4277
	call Func_00_0480 ; $4279
	ld hl, $d800 ; $427c
	ld de, $8800 ; $427f
	ld c, $80 ; $4282
	call Func_00_0480 ; $4284
	wram_bank $03 ; $4287
	ld hl, $6c2c ; $428d -> DataPtr_IntroSwingTilemap
	ld de, $d800 ; $4290
	call DecompressDataFromBank ; $4293
	ld hl, $6c2e ; $4296 -> DataPtr_IntroSwingAttrmap
	ld de, $dc00 ; $4299
	call DecompressDataFromBank ; $429c
	ld a, $01 ; $429f
	ld hl, $526a ; $42a1
	call RegisterFrameTask ; $42a4
	call EnableLCD ; $42a7
	ld c, $40 ; $42aa
	call Func_00_1d2e ; $42ac
	jp Label_6b_407c ; $42af
Palettes_6b_42b2:
	; $42b2, 64 bytes (palettes)
; GBC palettes (BGR555), 4 colors each
	dw $18c6, $294a, $294a, $294a ; pal 0: #313131 #525252 #525252 #525252
	dw $7e08, $7d84, $6940, $5100 ; pal 1: #4183ff #2062ff #0052d5 #0041a4
	dw $7fff, $4252, $214a, $0000 ; pal 2: #ffffff #949483 #525241 #000000
	dw $294a, $294a, $294a, $294a ; pal 3: #525252 #525252 #525252 #525252
	dw $294a, $294a, $294a, $294a ; pal 4: #525252 #525252 #525252 #525252
	dw $294a, $294a, $294a, $294a ; pal 5: #525252 #525252 #525252 #525252
	dw $294a, $294a, $294a, $294a ; pal 6: #525252 #525252 #525252 #525252
	dw $294a, $294a, $294a, $294a ; pal 7: #525252 #525252 #525252 #525252
	ld hl, $526a ; $42f2
	call Func_00_1bcb ; $42f5
	xor a, a ; $42f8
	ld [$cb40], a ; $42f9
	ld [$cb42], a ; $42fc
	ldh [$ff8b], a ; $42ff
	jp Label_6b_40af ; $4301
	ld a, [$cb42] ; $4304
	add a, $03 ; $4307
	ld [$cb42], a ; $4309
	ldh [$ff8b], a ; $430c
	ld a, [$cb40] ; $430e
	inc a ; $4311
	ld [$cb40], a ; $4312
	cp a, $69 ; $4315
	jr z, Label_6b_4323 ; $4317
	ld a, [$cb44] ; $4319
	inc a ; $431c
	ld [$cb44], a ; $431d
	jp Label_6b_407c ; $4320
Label_6b_4323:
	jp Label_6b_4099 ; $4323
	ldh a, [hWramBank] ; $4326
	push af ; $4328
	wram_bank $03 ; $4329
	ld hl, wShortTextBuffer ; $432f
	ld de, $9880 ; $4332
	ld c, $0a ; $4335
	call Func_00_0480 ; $4337
	ld hl, $dc80 ; $433a
	ld de, $b880 ; $433d
	ld c, $0a ; $4340
	call Func_00_0480 ; $4342
	call Func_00_2631 ; $4345
	ld hl, $d920 ; $4348
	ld de, $9920 ; $434b
	ld c, $0a ; $434e
	call Func_00_0480 ; $4350
	ld hl, $dd20 ; $4353
	ld de, $b920 ; $4356
	ld c, $0a ; $4359
	call Func_00_0480 ; $435b
	pop af ; $435e
	wram_bank ; $435f
	ld hl, $436f ; $4363
	ld de, $0008 ; $4366
	call Func_00_05b5 ; $4369
	jp Label_6b_407c ; $436c
	INCBIN "data/bank_06b/d_436f.bin" ; $436f, 64 bytes
	ld c, $06 ; $43af
	call Func_00_1d20 ; $43b1
	call Func_00_1da4 ; $43b4
	xor a, a ; $43b7
	ld [$cb40], a ; $43b8
	jp Label_6b_40af ; $43bb
	ld a, [$cb40] ; $43be
	inc a ; $43c1
	ld [$cb40], a ; $43c2
	cp a, $1e ; $43c5
	jr z, Label_6b_43cc ; $43c7
	jp Label_6b_407c ; $43c9
Label_6b_43cc:
	jp Label_6b_4099 ; $43cc
	call DisableLCDSafely ; $43cf
	ld c, $17 ; $43d2
	farcall FarPtr_LoadScreenAssetRecord ; $43d4
	ldh a, [hWramBank] ; $43d7
	push af ; $43d9
	wram_bank $03 ; $43da
	ld h, $8a ; $43e0
	ld de, $d560 ; $43e2
	ld b, $20 ; $43e5
	ld c, $01 ; $43e7
	farcall FarPtr_39_0c ; $43e9
	pop af ; $43ec
	wram_bank ; $43ed
	farcall FarPtr_Func_39_4325 ; $43f1
	wram_bank $01 ; $43f4
	ld hl, $6c32 ; $43fa -> DataPtr_IntroCloseupTiles
	ld de, $d000 ; $43fd
	call DecompressDataFromBank ; $4400
	ld hl, $d000 ; $4403
	ld de, $9000 ; $4406
	ld c, $80 ; $4409
	call Func_00_0480 ; $440b
	ld hl, $d800 ; $440e
	ld de, $8800 ; $4411
	ld c, $80 ; $4414
	call Func_00_0480 ; $4416
	wram_bank $03 ; $4419
	ld hl, $6c34 ; $441f -> DataPtr_IntroCloseupTilemap
	ld de, $d800 ; $4422
	call DecompressDataFromBank ; $4425
	ld hl, $6c36 ; $4428 -> DataPtr_IntroCloseupAttrmap
	ld de, $dc00 ; $442b
	call DecompressDataFromBank ; $442e
	ld a, $01 ; $4431
	ld hl, $52f9 ; $4433
	call RegisterFrameTask ; $4436
	ld a, $a0 ; $4439
	ld [$cb46], a ; $443b
	ld a, $28 ; $443e
	ld [$cb47], a ; $4440
	xor a, a ; $4443
	ld [$cb43], a ; $4444
	call EnableLCD ; $4447
	ld c, $7f ; $444a
	call Func_00_1d2e ; $444c
	call Func_00_1da4 ; $444f
	jp Label_6b_407c ; $4452
	ld hl, $52f9 ; $4455
	call Func_00_1bcb ; $4458
	xor a, a ; $445b
	ld [$cb40], a ; $445c
	ld [$cb43], a ; $445f
	ldh [$ff8b], a ; $4462
	jp Label_6b_40af ; $4464
	ld a, [$cb40] ; $4467
	inc a ; $446a
	ld [$cb40], a ; $446b
	cp a, $7d ; $446e
	jp z, Label_6b_4099 ; $4470
	ld a, [$cb43] ; $4473
	sub a, $03 ; $4476
	ld [$cb43], a ; $4478
	ldh [$ff8b], a ; $447b
	ld a, [$cb46] ; $447d
	dec a ; $4480
	ld [$cb46], a ; $4481
	jp Label_6b_407c ; $4484
	ldh a, [hWramBank] ; $4487
	push af ; $4489
	wram_bank $03 ; $448a
	ld hl, wShortTextBuffer ; $4490
	ld de, $9880 ; $4493
	ld c, $0a ; $4496
	call Func_00_0480 ; $4498
	ld hl, $dc80 ; $449b
	ld de, $b880 ; $449e
	ld c, $0a ; $44a1
	call Func_00_0480 ; $44a3
	call Func_00_2631 ; $44a6
	ld hl, $d920 ; $44a9
	ld de, $9920 ; $44ac
	ld c, $0a ; $44af
	call Func_00_0480 ; $44b1
	ld hl, $dd20 ; $44b4
	ld de, $b920 ; $44b7
	ld c, $0a ; $44ba
	call Func_00_0480 ; $44bc
	pop af ; $44bf
	wram_bank ; $44c0
	ld hl, $44d0 ; $44c4
	ld de, $0008 ; $44c7
	call Func_00_05b5 ; $44ca
	jp Label_6b_407c ; $44cd
	INCBIN "data/bank_06b/d_44d0.bin" ; $44d0, 64 bytes
	ld c, $06 ; $4510
	call Func_00_1d20 ; $4512
	call Func_00_1da4 ; $4515
	xor a, a ; $4518
	ld [$cb40], a ; $4519
	jp Label_6b_40af ; $451c
	ld a, [$cb40] ; $451f
	inc a ; $4522
	ld [$cb40], a ; $4523
	cp a, $1e ; $4526
	jp z, Label_6b_4099 ; $4528
	jp Label_6b_407c ; $452b
	call DisableLCDSafely ; $452e
	ld c, $18 ; $4531
	farcall FarPtr_LoadScreenAssetRecord ; $4533
	ldh a, [hWramBank] ; $4536
	push af ; $4538
	wram_bank $03 ; $4539
	ld h, $8a ; $453f
	ld de, $d500 ; $4541
	ld b, $20 ; $4544
	ld c, $01 ; $4546
	farcall FarPtr_39_0c ; $4548
	ld h, $8a ; $454b
	ld de, $d5c0 ; $454d
	ld b, $20 ; $4550
	ld c, $01 ; $4552
	farcall FarPtr_39_0c ; $4554
	pop af ; $4557
	wram_bank ; $4558
	farcall FarPtr_Func_39_4325 ; $455c
	ld c, $19 ; $455f
	farcall FarPtr_LoadScreenAssetRecord ; $4561
	ld a, $08 ; $4564
	ldh [rSTAT], a ; $4566
	ld hl, rIE ; $4568
	set 1, [hl] ; $456b
	ld a, $44 ; $456d
	ld [$cb02], a ; $456f
	ld a, $78 ; $4572
	ld [$cb03], a ; $4574
	xor a, a ; $4577
	ld [$cb01], a ; $4578
	ld a, $01 ; $457b
	ld hl, $53db ; $457d
	call RegisterFrameTask ; $4580
	ld a, $a0 ; $4583
	ld [$cb46], a ; $4585
	ld a, $40 ; $4588
	ld [$cb47], a ; $458a
	ld a, $c0 ; $458d
	ld [$cb44], a ; $458f
	ld a, $10 ; $4592
	ld [$cb45], a ; $4594
	ld a, $01 ; $4597
	ld hl, $526a ; $4599
	call RegisterFrameTask ; $459c
	ld a, $01 ; $459f
	ld hl, $52f9 ; $45a1
	call RegisterFrameTask ; $45a4
	call EnableLCD ; $45a7
	ld c, $10 ; $45aa
	call Func_00_1d2e ; $45ac
	call Func_00_1da4 ; $45af
	jp Label_6b_407c ; $45b2
	ld hl, rIE ; $45b5
	res 1, [hl] ; $45b8
	ldh a, [hWramBank] ; $45ba
	push af ; $45bc
	wram_bank $03 ; $45bd
	ld hl, $d060 ; $45c3
	ld de, $9860 ; $45c6
	ld c, $0c ; $45c9
	call Func_00_0480 ; $45cb
	ld hl, $d460 ; $45ce
	ld de, $b860 ; $45d1
	ld c, $0c ; $45d4
	call Func_00_0480 ; $45d6
	pop af ; $45d9
	wram_bank ; $45da
	ld hl, $526a ; $45de
	call Func_00_1bcb ; $45e1
	ld hl, $53db ; $45e4
	call Func_00_1bcb ; $45e7
	xor a, a ; $45ea
	ldh [$ff8b], a ; $45eb
	call Func_00_2631 ; $45ed
	ldh a, [hWramBank] ; $45f0
	push af ; $45f2
	wram_bank $03 ; $45f3
	ld hl, $d120 ; $45f9
	ld de, $9920 ; $45fc
	ld c, $0c ; $45ff
	call Func_00_0480 ; $4601
	ld hl, $d520 ; $4604
	ld de, $b920 ; $4607
	ld c, $0c ; $460a
	call Func_00_0480 ; $460c
	pop af ; $460f
	wram_bank ; $4610
	ld hl, $52f9 ; $4614
	call Func_00_1bcb ; $4617
	call Func_00_2631 ; $461a
	jp Label_6b_40af ; $461d
	ld a, [$cb40] ; $4620
	inc a ; $4623
	ld [$cb40], a ; $4624
	cp a, $60 ; $4627
	jp z, Label_6b_4099 ; $4629
	ld a, [$cb44] ; $462c
	inc a ; $462f
	ld [$cb44], a ; $4630
	ld a, [$cb46] ; $4633
	dec a ; $4636
	ld [$cb46], a ; $4637
	jp Label_6b_407c ; $463a
	xor a, a ; $463d
	ld [$cb40], a ; $463e
	jp Label_6b_407c ; $4641
	ld c, $10 ; $4644
	call Func_00_1d20 ; $4646
	call Func_00_1da4 ; $4649
	jp Label_6b_40af ; $464c
	ld a, [$cb40] ; $464f
	inc a ; $4652
	ld [$cb40], a ; $4653
	cp a, $64 ; $4656
	jp z, Label_6b_4099 ; $4658
	jp Label_6b_407c ; $465b
	call Func_6b_617c ; $465e
	call Func_6b_73f2 ; $4661
	xor a, a ; $4664
	ld [$cb40], a ; $4665
	ld [$cb44], a ; $4668
	ld [$cb45], a ; $466b
	ld [$cb46], a ; $466e
	ld [$cb47], a ; $4671
	call EnableLCD ; $4674
	ld c, $08 ; $4677
	call Func_00_1d2e ; $4679
	call Func_00_1da4 ; $467c
	ld a, $01 ; $467f
	ld hl, $7083 ; $4681
	call RegisterFrameTask ; $4684
	jp Label_6b_407c ; $4687
	call ClearFrameTasks ; $468a
	ld a, $01 ; $468d
	ld hl, $53f1 ; $468f
	call RegisterFrameTask ; $4692
	xor a, a ; $4695
	ldh [$ff8b], a ; $4696
	ldh [$ff8a], a ; $4698
	ld [$c320], a ; $469a
	ld [$c321], a ; $469d
	ld [$c322], a ; $46a0
	ld [$c323], a ; $46a3
	jp Label_6b_40af ; $46a6
	ld a, [$c321] ; $46a9
	cp a, $40 ; $46ac
	jp nz, Label_6b_46c0 ; $46ae
	ld a, [$cb40] ; $46b1
	inc a ; $46b4
	ld [$cb40], a ; $46b5
	cp a, $29 ; $46b8
	jp z, Label_6b_4099 ; $46ba
	jp Label_6b_407c ; $46bd
Label_6b_46c0:
	ld a, [$cb40] ; $46c0
	cp a, $01 ; $46c3
	jr z, Label_6b_46ce ; $46c5
	inc a ; $46c7
	ld [$cb40], a ; $46c8
	jp Label_6b_407c ; $46cb
Label_6b_46ce:
	ld a, [$c321] ; $46ce
	ld h, a ; $46d1
	ld a, [$c320] ; $46d2
	ld l, a ; $46d5
	ld bc, $0020 ; $46d6
	add hl, bc ; $46d9
	ld a, h ; $46da
	ld [$c321], a ; $46db
	ld a, l ; $46de
	ld [$c320], a ; $46df
	jp Label_6b_407c ; $46e2
	xor a, a ; $46e5
	ldh [$ff8a], a ; $46e6
	ldh [$ff8b], a ; $46e8
	ld [$cb40], a ; $46ea
	ldh a, [hWramBank] ; $46ed
	push af ; $46ef
	wram_bank $05 ; $46f0
	ld hl, Palettes_6b_475a ; $46f6
	ld de, $0008 ; $46f9
	call LoadPaletteShadow ; $46fc
	ld hl, $d0c0 ; $46ff
	ld de, $98c0 ; $4702
	ld c, $10 ; $4705
	call Func_00_0480 ; $4707
	ld hl, $d4c0 ; $470a
	ld de, $b8c0 ; $470d
	ld c, $10 ; $4710
	call Func_00_0480 ; $4712
	call Func_00_2631 ; $4715
	ld hl, $d080 ; $4718
	ld de, $9880 ; $471b
	ld c, $04 ; $471e
	call Func_00_0480 ; $4720
	ld hl, $d480 ; $4723
	ld de, $b880 ; $4726
	ld c, $04 ; $4729
	call Func_00_0480 ; $472b
	call Func_00_2631 ; $472e
	pop af ; $4731
	wram_bank ; $4732
	jp Label_6b_407c ; $4736
	ld c, $10 ; $4739
	call Func_00_1d20 ; $473b
	call Func_00_1da4 ; $473e
	call DisableLCDSafely ; $4741
	xor a, a ; $4744
	ld [$cb40], a ; $4745
	jp Label_6b_40af ; $4748
	ld a, [$cb40] ; $474b
	inc a ; $474e
	ld [$cb40], a ; $474f
	cp a, $64 ; $4752
	jp z, Label_6b_4099 ; $4754
	jp Label_6b_407c ; $4757
Palettes_6b_475a:
	; $475a, 64 bytes (palettes)
; GBC palettes (BGR555), 4 colors each
	dw $7f00, $7f60, $7fe0, $0000 ; pal 0: #00c5ff #00deff #00ffff #000000
	dw $7f00, $6bff, $7d8a, $0000 ; pal 1: #00c5ff #ffffd5 #5262ff #000000
	dw $0240, $7e9f, $7f00, $0000 ; pal 2: #009400 #ffa4ff #00c5ff #000000
	dw $6bff, $0280, $7f00, $0000 ; pal 3: #ffffd5 #00a400 #00c5ff #000000
	dw $025f, $6bff, $7f00, $0000 ; pal 4: #ff9400 #ffffd5 #00c5ff #000000
	dw $294a, $294a, $294a, $294a ; pal 5: #525252 #525252 #525252 #525252
	dw $7fff, $4252, $214a, $0000 ; pal 6: #ffffff #949483 #525241 #000000
	dw $294a, $294a, $294a, $294a ; pal 7: #525252 #525252 #525252 #525252
	call DisableLCDSafely ; $479a
	ld c, $1c ; $479d
	farcall FarPtr_LoadScreenAssetRecord ; $479f
	farcall FarPtr_Func_39_4325 ; $47a2
	xor a, a ; $47a5
	ld [$cb40], a ; $47a6
	ld a, $b0 ; $47a9
	ld [$cb42], a ; $47ab
	ld a, $01 ; $47ae
	ld hl, $7366 ; $47b0
	call RegisterFrameTask ; $47b3
	call EnableLCD ; $47b6
	ld c, $10 ; $47b9
	call Func_00_1d2e ; $47bb
	call Func_00_1da4 ; $47be
	jp Label_6b_407c ; $47c1
	ld c, $0a ; $47c4
	call Func_00_1d20 ; $47c6
	call Func_00_1da4 ; $47c9
	ld hl, $7366 ; $47cc
	call Func_00_1bcb ; $47cf
	xor a, a ; $47d2
	ldh [$ff8b], a ; $47d3
	jp Label_6b_40af ; $47d5
	ld a, [$cb40] ; $47d8
	inc a ; $47db
	ld [$cb40], a ; $47dc
	cp a, $2c ; $47df
	jp z, Label_6b_4099 ; $47e1
	jp Label_6b_407c ; $47e4
	call DisableLCDSafely ; $47e7
	ld c, $1d ; $47ea
	farcall FarPtr_LoadScreenAssetRecord ; $47ec
	farcall FarPtr_Func_39_4325 ; $47ef
	ld a, $94 ; $47f2
	ld [$cb42], a ; $47f4
	ldh [$ff8b], a ; $47f7
	xor a, a ; $47f9
	ld [$cb40], a ; $47fa
	ld a, $01 ; $47fd
	ld hl, $7395 ; $47ff
	call RegisterFrameTask ; $4802
	call EnableLCD ; $4805
	ld c, $10 ; $4808
	call Func_00_1d2e ; $480a
	call Func_00_1da4 ; $480d
	jp Label_6b_407c ; $4810
	ld c, $0a ; $4813
	call Func_00_1d20 ; $4815
	call Func_00_1da4 ; $4818
	ld hl, $7395 ; $481b
	call Func_00_1bcb ; $481e
	xor a, a ; $4821
	ldh [$ff8b], a ; $4822
	jp Label_6b_40af ; $4824
	ld a, [$cb40] ; $4827
	inc a ; $482a
	ld [$cb40], a ; $482b
	cp a, $2b ; $482e
	jp z, Label_6b_4099 ; $4830
	jp Label_6b_407c ; $4833
	call DisableLCDSafely ; $4836
	ld c, $1e ; $4839
	farcall FarPtr_LoadScreenAssetRecord ; $483b
	farcall FarPtr_Func_39_4325 ; $483e
	ld a, $a8 ; $4841
	ld [$cb42], a ; $4843
	ldh [$ff8b], a ; $4846
	xor a, a ; $4848
	ld [$cb40], a ; $4849
	ld a, $01 ; $484c
	ld hl, $73c4 ; $484e
	call RegisterFrameTask ; $4851
	call EnableLCD ; $4854
	ld c, $10 ; $4857
	call Func_00_1d2e ; $4859
	call Func_00_1da4 ; $485c
	jp Label_6b_407c ; $485f
	ld c, $0a ; $4862
	call Func_00_1d20 ; $4864
	call Func_00_1da4 ; $4867
	ld hl, $73c4 ; $486a
	call Func_00_1bcb ; $486d
	xor a, a ; $4870
	ldh [$ff8b], a ; $4871
	jp Label_6b_40af ; $4873
	ld a, [$cb40] ; $4876
	inc a ; $4879
	ld [$cb40], a ; $487a
	cp a, $2b ; $487d
	jp z, Label_6b_4099 ; $487f
	jp Label_6b_407c ; $4882
Unused_6b_State11_Init:
	call DisableLCDSafely ; $4885
	ld c, $20 ; $4888
	farcall FarPtr_LoadScreenAssetRecord ; $488a
	ld a, $01 ; $488d
	ldh [$ff98], a ; $488f
	ld hl, rLCDC ; $4891
	set 3, [hl] ; $4894
	wram_bank $03 ; $4896
	ld hl, $d000 ; $489c
	ld de, $9c00 ; $489f
	ld c, $40 ; $48a2
	call Func_00_0480 ; $48a4
	ld hl, $d400 ; $48a7
	ld de, $bc00 ; $48aa
	ld c, $40 ; $48ad
	call Func_00_0480 ; $48af
	call Func_6b_545e ; $48b2
	call Func_6b_6075 ; $48b5
	call EnableLCD ; $48b8
	ld c, $20 ; $48bb
	call Func_00_1d2e ; $48bd
	call Func_00_1da4 ; $48c0
	xor a, a ; $48c3
	ld [$cb40], a ; $48c4
	jp Label_6b_407c ; $48c7
Unused_6b_State11_Exit:
	ld a, $00 ; $48ca
	ldh [$ff98], a ; $48cc
	ld hl, rLCDC ; $48ce
	res 3, [hl] ; $48d1
	ld hl, $5d25 ; $48d3
	ld de, $0008 ; $48d6
	call LoadPaletteShadow ; $48d9
	xor a, a ; $48dc
	ld [$cb40], a ; $48dd
	jp Label_6b_40af ; $48e0
Unused_6b_State11_Update:
	ld a, [$cb40] ; $48e3
	inc a ; $48e6
	ld [$cb40], a ; $48e7
	cp a, $70 ; $48ea
	jp z, Label_6b_4099 ; $48ec
	jp Label_6b_407c ; $48ef
Unused_6b_State12_Init:
	xor a, a ; $48f2
	ld [$cb40], a ; $48f3
	ld [$cb45], a ; $48f6
	xor a, a ; $48f9
	ld [$c322], a ; $48fa
	ld a, $24 ; $48fd
	ld [$c323], a ; $48ff
	ld a, $00 ; $4902
	ld [$cb4d], a ; $4904
	ld [$cb4c], a ; $4907
	ld de, $015c ; $490a
	ld hl, $cb48 ; $490d
	ld a, e ; $4910
	ld [hl+], a ; $4911
	ld [hl], d ; $4912
	ld de, $0120 ; $4913
	ld hl, $cb4a ; $4916
	ld a, e ; $4919
	ld [hl+], a ; $491a
	ld [hl], d ; $491b
	jp Label_6b_407c ; $491c
Unused_6b_State12_Exit:
	ld c, $04 ; $491f
	call Func_00_1d20 ; $4921
	call Func_00_1da4 ; $4924
	jp Label_6b_40af ; $4927
Unused_6b_State12_Update:
	ld a, [$cb45] ; $492a
	cp a, $0a ; $492d
	jr z, Label_6b_493b ; $492f
	inc a ; $4931
	ld [$cb45], a ; $4932
	call Func_6b_60f8 ; $4935
	jp Label_6b_407c ; $4938
Label_6b_493b:
	ld a, [$cb40] ; $493b
	inc a ; $493e
	ld [$cb40], a ; $493f
	cp a, $80 ; $4942
	jp z, Label_6b_4099 ; $4944
	cp a, $64 ; $4947
	jr nc, Label_6b_494e ; $4949
	call Func_6b_6115 ; $494b
Label_6b_494e:
	call Func_6b_4d61 ; $494e
	call Func_6b_4c9e ; $4951
	call Func_6b_60d5 ; $4954
	call Func_6b_60f8 ; $4957
	call Func_6b_4e2d ; $495a
	jp Label_6b_407c ; $495d
	call DisableLCDSafely ; $4960
	call Func_6b_53fc ; $4963
	call Func_6b_6075 ; $4966
	ld a, $02 ; $4969
	ldh [$ff98], a ; $496b
	ld hl, rLCDC ; $496d
	set 3, [hl] ; $4970
	wram_bank $01 ; $4972
	ld hl, $6d12 ; $4978 -> DataPtr_IntroGreatestPlayerTiles
	ld de, $d000 ; $497b
	call DecompressDataFromBank ; $497e
	ld hl, $d000 ; $4981
	ld de, $9000 ; $4984
	ld c, $80 ; $4987
	call Func_00_0480 ; $4989
	ld hl, $d800 ; $498c
	ld de, $8800 ; $498f
	ld c, $80 ; $4992
	call Func_00_0480 ; $4994
	ld hl, $6d14 ; $4997 -> DataPtr_IntroGreatestPlayerTilemap
	ld de, $d000 ; $499a
	call DecompressDataFromBank ; $499d
	ld hl, $6d16 ; $49a0 -> DataPtr_IntroGreatestPlayerAttrmap
	ld de, $d400 ; $49a3
	call DecompressDataFromBank ; $49a6
	ld hl, $d000 ; $49a9
	ld de, $9c00 ; $49ac
	ld c, $40 ; $49af
	call Func_00_0480 ; $49b1
	ld hl, $d400 ; $49b4
	ld de, $bc00 ; $49b7
	ld c, $40 ; $49ba
	call Func_00_0480 ; $49bc
	ld hl, Palettes_6b_4a58 ; $49bf
	ld de, $0008 ; $49c2
	call LoadPaletteShadow ; $49c5
	wram_bank $01 ; $49c8
	ld hl, $6d1a ; $49ce -> DataPtr_IntroCharactersTiles
	ld de, $d000 ; $49d1
	call DecompressDataFromBank ; $49d4
	ld hl, $d000 ; $49d7
	ld de, $b000 ; $49da
	ld c, $80 ; $49dd
	call Func_00_0480 ; $49df
	ld hl, $d800 ; $49e2
	ld de, $a800 ; $49e5
	ld c, $80 ; $49e8
	call Func_00_0480 ; $49ea
	wram_bank $04 ; $49ed
	ld hl, $6d1c ; $49f3 -> DataPtr_IntroCharactersTilemap
	ld de, $d800 ; $49f6
	call DecompressDataFromBank ; $49f9
	ld hl, $6d1e ; $49fc -> DataPtr_6d_1e
	ld de, $dc00 ; $49ff
	call DecompressDataFromBank ; $4a02
	wram_bank $05 ; $4a05
	ld hl, $6d22 ; $4a0b -> DataPtr_IntroCharactersTilemap2
	ld de, $d000 ; $4a0e
	call DecompressDataFromBank ; $4a11
	ld hl, $6d24 ; $4a14 -> DataPtr_6d_24
	ld de, $d400 ; $4a17
	call DecompressDataFromBank ; $4a1a
	wram_bank $01 ; $4a1d
	ld hl, $551d ; $4a23
	ld de, $d000 ; $4a26
	call DecompressData ; $4a29
	xor a, a ; $4a2c
	ldh [$ff8b], a ; $4a2d
	ldh [$ff8a], a ; $4a2f
	ld [$cb40], a ; $4a31
	call EnableLCD ; $4a34
	ld c, $08 ; $4a37
	call Func_00_1d2e ; $4a39
	call Func_00_1da4 ; $4a3c
	jp Label_6b_407c ; $4a3f
	ld a, [$cb40] ; $4a42
	inc a ; $4a45
	ld [$cb40], a ; $4a46
	cp a, $70 ; $4a49
	jp z, Label_6b_4099 ; $4a4b
	jp Label_6b_407c ; $4a4e
	xor a, a ; $4a51
	ld [$cb40], a ; $4a52
	jp Label_6b_40af ; $4a55
Palettes_6b_4a58:
	; $4a58, 64 bytes (palettes)
; GBC palettes (BGR555), 4 colors each
	dw $7fff, $4252, $214a, $0000 ; pal 0: #ffffff #949483 #525241 #000000
	dw $214a, $4252, $214a, $0000 ; pal 1: #525241 #949483 #525241 #000000
	dw $214a, $4252, $214a, $0000 ; pal 2: #525241 #949483 #525241 #000000
	dw $214a, $4252, $4252, $0000 ; pal 3: #525241 #949483 #949483 #000000
	dw $214a, $4252, $4252, $0000 ; pal 4: #525241 #949483 #949483 #000000
	dw $214a, $214a, $4252, $0000 ; pal 5: #525241 #525241 #949483 #000000
	dw $294a, $294a, $294a, $294a ; pal 6: #525252 #525252 #525252 #525252
	dw $294a, $294a, $294a, $294a ; pal 7: #525252 #525252 #525252 #525252
	wram_bank $04 ; $4a98
	ld hl, $d8c0 ; $4a9e
	ld de, $9cc0 ; $4aa1
	ld c, $10 ; $4aa4
	call Func_00_0480 ; $4aa6
	ld hl, $dcc0 ; $4aa9
	ld de, $bcc0 ; $4aac
	ld c, $10 ; $4aaf
	call Func_00_0480 ; $4ab1
	call Func_00_2631 ; $4ab4
	ld hl, wShortTextBuffer ; $4ab7
	ld de, $9c80 ; $4aba
	ld c, $04 ; $4abd
	call Func_00_0480 ; $4abf
	ld hl, $dc80 ; $4ac2
	ld de, $bc80 ; $4ac5
	ld c, $04 ; $4ac8
	call Func_00_0480 ; $4aca
	call Func_00_2631 ; $4acd
	ld hl, Palettes_6b_4c00 ; $4ad0
	ld de, $0107 ; $4ad3
	call LoadPaletteShadow ; $4ad6
	xor a, a ; $4ad9
	ld [$cb40], a ; $4ada
	jp Label_6b_407c ; $4add
	ld a, [$cb40] ; $4ae0
	inc a ; $4ae3
	ld [$cb40], a ; $4ae4
	cp a, $70 ; $4ae7
	jp z, Label_6b_4099 ; $4ae9
	jp Label_6b_407c ; $4aec
	jp Label_6b_40af ; $4aef
	ld hl, Palettes_6b_756f ; $4af2
	ld de, $0008 ; $4af5
	call LoadPaletteShadow ; $4af8
	wram_bank $05 ; $4afb
	ld hl, $d260 ; $4b01
	ld de, $9e60 ; $4b04
	ld c, $10 ; $4b07
	call Func_00_0480 ; $4b09
	ld hl, $d660 ; $4b0c
	ld de, $be60 ; $4b0f
	ld c, $10 ; $4b12
	call Func_00_0480 ; $4b14
	call Func_00_2631 ; $4b17
	ld hl, $d160 ; $4b1a
	ld de, $9d60 ; $4b1d
	ld c, $10 ; $4b20
	call Func_00_0480 ; $4b22
	ld hl, $d560 ; $4b25
	ld de, $bd60 ; $4b28
	ld c, $10 ; $4b2b
	call Func_00_0480 ; $4b2d
	call Func_00_2631 ; $4b30
	ld a, $48 ; $4b33
	ld [$cb44], a ; $4b35
	ldh [$ff8a], a ; $4b38
	ld a, $08 ; $4b3a
	ld hl, $7569 ; $4b3c
	call RegisterFrameTask ; $4b3f
	ld hl, $d060 ; $4b42
	ld de, $9c60 ; $4b45
	ld c, $10 ; $4b48
	call Func_00_0480 ; $4b4a
	ld hl, $d460 ; $4b4d
	ld de, $bc60 ; $4b50
	ld c, $10 ; $4b53
	call Func_00_0480 ; $4b55
	call Func_00_2631 ; $4b58
	ld hl, $d000 ; $4b5b
	ld de, $9c00 ; $4b5e
	ld c, $08 ; $4b61
	call Func_00_0480 ; $4b63
	ld hl, $d400 ; $4b66
	ld de, $bc00 ; $4b69
	ld c, $08 ; $4b6c
	call Func_00_0480 ; $4b6e
	ld hl, Palettes_6b_4c00 ; $4b71
	ld de, $0107 ; $4b74
	call LoadPaletteShadow ; $4b77
	call Func_00_2631 ; $4b7a
	wram_bank $01 ; $4b7d
	ld hl, $d000 ; $4b83
	ld de, $9000 ; $4b86
	ld c, $20 ; $4b89
	call Func_00_0480 ; $4b8b
	call Func_00_2631 ; $4b8e
	ld hl, $d200 ; $4b91
	ld de, $9200 ; $4b94
	ld c, $20 ; $4b97
	call Func_00_0480 ; $4b99
	call Func_00_2631 ; $4b9c
	ld hl, $d400 ; $4b9f
	ld de, $9400 ; $4ba2
	ld c, $20 ; $4ba5
	call Func_00_0480 ; $4ba7
	call Func_00_2631 ; $4baa
	ld hl, $d600 ; $4bad
	ld de, $9600 ; $4bb0
	ld c, $20 ; $4bb3
	call Func_00_0480 ; $4bb5
	call Func_00_2631 ; $4bb8
	ld hl, $d800 ; $4bbb
	ld de, $8800 ; $4bbe
	ld c, $20 ; $4bc1
	call Func_00_0480 ; $4bc3
	call Func_00_2631 ; $4bc6
	xor a, a ; $4bc9
	ld [$cb40], a ; $4bca
	jp Label_6b_407c ; $4bcd
	ld a, [$cb44] ; $4bd0
	sub a, $04 ; $4bd3
	ld [$cb44], a ; $4bd5
	ldh [$ff8a], a ; $4bd8
	jp z, Label_6b_4099 ; $4bda
	ld a, [$cb40] ; $4bdd
	or a, a ; $4be0
	jr nz, Label_6b_4be3 ; $4be1
Label_6b_4be3:
	ld a, [$cb40] ; $4be3
	inc a ; $4be6
	ld [$cb40], a ; $4be7
	jp Label_6b_407c ; $4bea
	ld hl, $7569 ; $4bed
	call Func_00_1bcb ; $4bf0
	wram_bank $03 ; $4bf3
	ld a, $00 ; $4bf9
	ldh [$ff98], a ; $4bfb
	jp Label_6b_40af ; $4bfd
Palettes_6b_4c00:
	; $4c00, 56 bytes (palettes)
; GBC palettes (BGR555), 4 colors each
	dw $5902, $7fff, $0090, $0000 ; pal 0: #1041b4 #ffffff #832000 #000000
	dw $191f, $035f, $5902, $0000 ; pal 1: #ff4131 #ffd500 #1041b4 #000000
	dw $5902, $7fff, $331f, $0000 ; pal 2: #1041b4 #ffffff #ffc562 #000000
	dw $191f, $7fff, $331f, $0000 ; pal 3: #ff4131 #ffffff #ffc562 #000000
	dw $191f, $0090, $331f, $0000 ; pal 4: #ff4131 #832000 #ffc562 #000000
	dw $294a, $294a, $294a, $294a ; pal 5: #525252 #525252 #525252 #525252
	dw $294a, $294a, $294a, $294a ; pal 6: #525252 #525252 #525252 #525252
	ld hl, $5d25 ; $4c38
	ld de, $0008 ; $4c3b
	call LoadPaletteShadow ; $4c3e
	xor a, a ; $4c41
	ld [$cb40], a ; $4c42
	ld [$cb45], a ; $4c45
	xor a, a ; $4c48
	ld [$c322], a ; $4c49
	ld a, $24 ; $4c4c
	ld [$c323], a ; $4c4e
	ld a, $00 ; $4c51
	ld [$cb4d], a ; $4c53
	ld [$cb4c], a ; $4c56
	ld de, $015c ; $4c59
	ld hl, $cb48 ; $4c5c
	ld a, e ; $4c5f
	ld [hl+], a ; $4c60
	ld [hl], d ; $4c61
	ld de, $0120 ; $4c62
	ld hl, $cb4a ; $4c65
	ld a, e ; $4c68
	ld [hl+], a ; $4c69
	ld [hl], d ; $4c6a
	jp Label_6b_407c ; $4c6b
	ld c, $04 ; $4c6e
	call Func_00_1d20 ; $4c70
	call Func_00_1da4 ; $4c73
	jp Label_6b_40af ; $4c76
	ld a, [$cb40] ; $4c79
	inc a ; $4c7c
	ld [$cb40], a ; $4c7d
	cp a, $80 ; $4c80
	jp z, Label_6b_4099 ; $4c82
	cp a, $64 ; $4c85
	jr nc, Label_6b_4c8c ; $4c87
	call Func_6b_6115 ; $4c89
Label_6b_4c8c:
	call Func_6b_4d61 ; $4c8c
	call Func_6b_4c9e ; $4c8f
	call Func_6b_60d5 ; $4c92
	call Func_6b_60f8 ; $4c95
	call Func_6b_4e2d ; $4c98
	jp Label_6b_407c ; $4c9b
Func_6b_4c9e:
	ld a, [$cb40] ; $4c9e
	ld hl, $4cc1 ; $4ca1
	add a, l ; $4ca4
	ld l, a ; $4ca5
	jr nc, Label_6b_4ca9 ; $4ca6
	inc h ; $4ca8
Label_6b_4ca9:
	ld e, [hl] ; $4ca9
	ld hl, $cb4a ; $4caa
	ld a, [hl+] ; $4cad
	ld h, [hl] ; $4cae
	ld l, a ; $4caf
	ld d, $00 ; $4cb0
	ld a, l ; $4cb2
	sub a, e ; $4cb3
	ld l, a ; $4cb4
	ld a, h ; $4cb5
	sbc a, d ; $4cb6
	ld h, a ; $4cb7
	ld a, h ; $4cb8
	ld [$cb4b], a ; $4cb9
	ld a, l ; $4cbc
	ld [$cb4a], a ; $4cbd
	ret ; $4cc0
	INCBIN "data/bank_06b/d_4cc1.bin" ; $4cc1, 160 bytes
Func_6b_4d61:
	ld a, [$cb40] ; $4d61
	ld hl, $4d84 ; $4d64
	add a, l ; $4d67
	ld l, a ; $4d68
	jr nc, Label_6b_4d6c ; $4d69
	inc h ; $4d6b
Label_6b_4d6c:
	ld e, [hl] ; $4d6c
	ld hl, $cb48 ; $4d6d
	ld a, [hl+] ; $4d70
	ld h, [hl] ; $4d71
	ld l, a ; $4d72
	ld d, $00 ; $4d73
	ld a, l ; $4d75
	sub a, e ; $4d76
	ld l, a ; $4d77
	ld a, h ; $4d78
	sbc a, d ; $4d79
	ld h, a ; $4d7a
	ld a, h ; $4d7b
	ld [$cb49], a ; $4d7c
	ld a, l ; $4d7f
	ld [$cb48], a ; $4d80
	ret ; $4d83
	INCBIN "data/bank_06b/d_4d84.bin" ; $4d84, 169 bytes
Func_6b_4e2d:
	ld a, [$cb40] ; $4e2d
	cp a, $20 ; $4e30
	ret c ; $4e32
	ld a, [$cb40] ; $4e33
	sub a, $20 ; $4e36
	add a, a ; $4e38
	ld hl, $506d ; $4e39
	add a, l ; $4e3c
	ld l, a ; $4e3d
	jr nc, Label_6b_4e41 ; $4e3e
	inc h ; $4e40
Label_6b_4e41:
	ld a, [hl+] ; $4e41
	ld d, [hl] ; $4e42
	ld e, a ; $4e43
	call Func_6b_518d ; $4e44
	ld c, $40 ; $4e47
	ld b, $09 ; $4e49
	ld hl, $4e8e ; $4e4b
	call QueueSpriteTemplate ; $4e4e
	ld a, [$cb40] ; $4e51
	sub a, $20 ; $4e54
	add a, a ; $4e56
	ld hl, $4f95 ; $4e57
	add a, l ; $4e5a
	ld l, a ; $4e5b
	jr nc, Label_6b_4e5f ; $4e5c
	inc h ; $4e5e
Label_6b_4e5f:
	ld a, [hl+] ; $4e5f
	ld d, [hl] ; $4e60
	ld e, a ; $4e61
	call Func_6b_518d ; $4e62
	ld c, $44 ; $4e65
	ld b, $09 ; $4e67
	ld hl, $4e97 ; $4e69
	call QueueSpriteTemplate ; $4e6c
	ld a, [$cb40] ; $4e6f
	sub a, $20 ; $4e72
	add a, a ; $4e74
	ld hl, $4ea5 ; $4e75
	add a, l ; $4e78
	ld l, a ; $4e79
	jr nc, Label_6b_4e7d ; $4e7a
	inc h ; $4e7c
Label_6b_4e7d:
	ld a, [hl+] ; $4e7d
	ld d, [hl] ; $4e7e
	ld e, a ; $4e7f
	call Func_6b_518d ; $4e80
	ld c, $48 ; $4e83
	ld b, $09 ; $4e85
	ld hl, $4ea0 ; $4e87
	call QueueSpriteTemplate ; $4e8a
	ret ; $4e8d
	INCBIN "data/bank_06b/d_4e8e.bin" ; $4e8e, 767 bytes
Func_6b_518d:
	push bc ; $518d
	push hl ; $518e
	ld c, d ; $518f
	ld b, e ; $5190
	ld hl, $cb4a ; $5191
	ld a, [hl+] ; $5194
	ld d, [hl] ; $5195
	ld e, a ; $5196
	ld h, $00 ; $5197
	ld l, b ; $5199
	ld a, l ; $519a
	sub a, e ; $519b
	ld l, a ; $519c
	ld a, h ; $519d
	sbc a, d ; $519e
	ld h, a ; $519f
	ld e, l ; $51a0
	ld d, c ; $51a1
	pop hl ; $51a2
	pop bc ; $51a3
	ret ; $51a4
Label_6b_51a5:
	ldh a, [$ff94] ; $51a5
	bit 0, a ; $51a7
	jr nz, Label_6b_51ad ; $51a9
	jr Label_6b_51a5 ; $51ab
Label_6b_51ad:
	ret ; $51ad
Func_6b_51ae:
	call DisableLCDSafely ; $51ae
	ld c, $15 ; $51b1
	farcall FarPtr_LoadScreenAssetRecord ; $51b3
	farcall FarPtr_Func_39_4325 ; $51b6
	xor a, a ; $51b9
	ldh [$ff8b], a ; $51ba
	ldh [$ff8a], a ; $51bc
	ld [$cb40], a ; $51be
	ld a, $d8 ; $51c1
	ldh [$ff8a], a ; $51c3
	sound $65 ; $51c5
	call EnableLCD ; $51c7
	ld c, $20 ; $51ca
	call Func_00_1d2e ; $51cc
	call Func_00_1da4 ; $51cf
Label_6b_51d2:
	call Func_00_2631 ; $51d2
	ld a, [$cb40] ; $51d5
	inc a ; $51d8
	ld [$cb40], a ; $51d9
	cp a, $3c ; $51dc
	jr z, Label_6b_51e2 ; $51de
	jr Label_6b_51d2 ; $51e0
Label_6b_51e2:
	xor a, a ; $51e2
	ld [$cb40], a ; $51e3
	ret ; $51e6
Func_6b_51e7:
	ld a, $40 ; $51e7
	ldh [$ff8a], a ; $51e9
Label_6b_51eb:
	call Func_00_2631 ; $51eb
	ld a, [$cb40] ; $51ee
	inc a ; $51f1
	ld [$cb40], a ; $51f2
	cp a, $3e ; $51f5
	jr z, Label_6b_51fb ; $51f7
	jr Label_6b_51eb ; $51f9
Label_6b_51fb:
	ld c, $10 ; $51fb
	call Func_00_1d20 ; $51fd
	call Func_00_1da4 ; $5200
	call DisableLCDSafely ; $5203
	xor a, a ; $5206
	ldh [$ff8a], a ; $5207
	ret ; $5209
Func_6b_520a:
	ld b, $4d ; $520a
	ld c, $06 ; $520c
	ld de, $a000 ; $520e
	farcall FarPtr_39_10 ; $5211
	ld b, $4e ; $5214
	ld c, $0a ; $5216
	ld de, $a060 ; $5218
	farcall FarPtr_39_10 ; $521b
	ld b, $4f ; $521e
	ld c, $10 ; $5220
	ld de, $a100 ; $5222
	farcall FarPtr_39_10 ; $5225
	ld b, $50 ; $5228
	ld c, $06 ; $522a
	ld de, $a200 ; $522c
	farcall FarPtr_39_10 ; $522f
	ld b, $51 ; $5232
	ld c, $12 ; $5234
	ld de, $a260 ; $5236
	farcall FarPtr_39_10 ; $5239
	ld b, $52 ; $523c
	ld c, $10 ; $523e
	ld de, $a380 ; $5240
	farcall FarPtr_39_10 ; $5243
	ld b, $53 ; $5246
	ld c, $02 ; $5248
	ld de, $a480 ; $524a
	farcall FarPtr_39_10 ; $524d
	ld hl, Palettes_6b_525a ; $5250
	ld de, $0802 ; $5253
	call LoadPaletteShadow ; $5256
	ret ; $5259
Palettes_6b_525a:
	; $525a, 16 bytes (palettes)
; GBC palettes (BGR555), 4 colors each
	dw $569f, $73ff, $115f, $0000 ; pal 0: #ffa4ac #ffffe6 #ff5220 #000000
	dw $331f, $77ff, $025f, $0000 ; pal 1: #ffc562 #ffffee #ff9400 #000000
	ld hl, $52b6 ; $526a
	ld a, [$cb44] ; $526d
	ld d, $10 ; $5270
	add a, d ; $5272
	ld d, a ; $5273
	ld a, [$cb45] ; $5274
	ld e, a ; $5277
	call Func_6b_53b8 ; $5278
	ld c, $00 ; $527b
	ld b, $08 ; $527d
	call QueueSpriteTemplate ; $527f
	ld hl, $52c3 ; $5282
	ld a, [$cb44] ; $5285
	ld d, $08 ; $5288
	add a, d ; $528a
	ld d, a ; $528b
	ld a, [$cb45] ; $528c
	ld e, $10 ; $528f
	add a, e ; $5291
	ld e, a ; $5292
	call Func_6b_53b8 ; $5293
	ld c, $06 ; $5296
	ld b, $08 ; $5298
	call QueueSpriteTemplate ; $529a
	ld hl, $52d8 ; $529d
	ld a, [$cb44] ; $52a0
	ld d, a ; $52a3
	ld a, [$cb45] ; $52a4
	ld e, $20 ; $52a7
	add a, e ; $52a9
	ld e, a ; $52aa
	call Func_6b_53b8 ; $52ab
	ld c, $10 ; $52ae
	ld b, $08 ; $52b0
	call QueueSpriteTemplate ; $52b2
	ret ; $52b5
	INCBIN "data/bank_06b/d_52b6.bin" ; $52b6, 67 bytes
	ld hl, $5360 ; $52f9
	ld a, [$cb46] ; $52fc
	ld d, $18 ; $52ff
	add a, d ; $5301
	ld d, a ; $5302
	ld a, [$cb47] ; $5303
	ld e, a ; $5306
	call Func_6b_53b8 ; $5307
	ld c, $20 ; $530a
	ld b, $09 ; $530c
	call QueueSpriteTemplate ; $530e
	ld hl, $536d ; $5311
	ld a, [$cb46] ; $5314
	ld d, $08 ; $5317
	add a, d ; $5319
	ld d, a ; $531a
	ld a, [$cb47] ; $531b
	ld e, $10 ; $531e
	add a, e ; $5320
	ld e, a ; $5321
	call Func_6b_53b8 ; $5322
	ld c, $26 ; $5325
	ld b, $09 ; $5327
	call QueueSpriteTemplate ; $5329
	ld hl, $5392 ; $532c
	ld a, [$cb46] ; $532f
	ld d, a ; $5332
	ld a, [$cb47] ; $5333
	ld e, $20 ; $5336
	add a, e ; $5338
	ld e, a ; $5339
	call Func_6b_53b8 ; $533a
	ld c, $38 ; $533d
	ld b, $09 ; $533f
	call QueueSpriteTemplate ; $5341
	ld hl, $53b3 ; $5344
	ld a, [$cb46] ; $5347
	ld d, $48 ; $534a
	add a, d ; $534c
	ld d, a ; $534d
	ld a, [$cb47] ; $534e
	ld e, $20 ; $5351
	add a, e ; $5353
	ld e, a ; $5354
	call Func_6b_53b8 ; $5355
	ld c, $48 ; $5358
	ld b, $09 ; $535a
	call QueueSpriteTemplate ; $535c
	ret ; $535f
	INCBIN "data/bank_06b/d_5360.bin" ; $5360, 88 bytes
Func_6b_53b8:
	push hl ; $53b8
	ld a, [$cb40] ; $53b9
	and a, $0f ; $53bc
	ld hl, $53cb ; $53be
	add a, l ; $53c1
	ld l, a ; $53c2
	jr nc, Label_6b_53c6 ; $53c3
	inc h ; $53c5
Label_6b_53c6:
	ld a, [hl] ; $53c6
	add a, e ; $53c7
	ld e, a ; $53c8
	pop hl ; $53c9
	ret ; $53ca
	INCBIN "data/bank_06b/d_53cb.bin" ; $53cb, 16 bytes
	ld a, [$cb42] ; $53db
	add a, $03 ; $53de
	ld [$cb42], a ; $53e0
	ldh [$ff8b], a ; $53e3
	ld a, [$cb43] ; $53e5
	sub a, $03 ; $53e8
	ld [$cb43], a ; $53ea
	ld [$cb01], a ; $53ed
	ret ; $53f0
	ldh a, [$ff94] ; $53f1
	and a, $09 ; $53f3
	ret z ; $53f5
	ld a, $01 ; $53f6
	ld [wIntroCutsceneCheck], a ; $53f8
	ret ; $53fb
Func_6b_53fc:
	call DisableLCDSafely ; $53fc
	farcall FarPtr_0a_6a ; $53ff
	farcall FarPtr_05_00 ; $5402
	wram_bank $01 ; $5405
	ld hl, $551d ; $540b
	ld de, $d000 ; $540e
	call DecompressData ; $5411
	ld hl, $d000 ; $5414
	ld de, $9000 ; $5417
	ld c, $80 ; $541a
	call Func_00_0480 ; $541c
	ld hl, $d800 ; $541f
	ld de, $8800 ; $5422
	ld c, $80 ; $5425
	call Func_00_0480 ; $5427
	wram_bank $02 ; $542a
	ld hl, $5d65 ; $5430
	ld de, $d000 ; $5433
	call DecompressData ; $5436
	wram_bank $03 ; $5439
	ld hl, $5ea8 ; $543f
	ld de, $d000 ; $5442
	call DecompressData ; $5445
	xor a, a ; $5448
	ld [$c322], a ; $5449
	ld [$c320], a ; $544c
	ld a, $24 ; $544f
	ld [$c323], a ; $5451
	ld a, $01 ; $5454
	farcall FarPtr_0a_76 ; $5456
	xor a, a ; $5459
	ld [$c323], a ; $545a
	ret ; $545d
Func_6b_545e:
	call DisableLCDSafely ; $545e
	farcall FarPtr_0a_6a ; $5461
	farcall FarPtr_05_00 ; $5464
	wram_bank $01 ; $5467
	ld hl, $551d ; $546d
	ld de, $d000 ; $5470
	call DecompressData ; $5473
	ld hl, $d000 ; $5476
	ld de, $9000 ; $5479
	ld c, $80 ; $547c
	call Func_00_0480 ; $547e
	ld hl, $d800 ; $5481
	ld de, $8800 ; $5484
	ld c, $80 ; $5487
	call Func_00_0480 ; $5489
	wram_bank $02 ; $548c
	ld hl, $5bd7 ; $5492
	ld de, $d000 ; $5495
	call DecompressData ; $5498
	wram_bank $03 ; $549b
	ld hl, $59d7 ; $54a1
	ld de, $d000 ; $54a4
	call DecompressData ; $54a7
	xor a, a ; $54aa
	ld [$c322], a ; $54ab
	ld a, $24 ; $54ae
	ld [$c323], a ; $54b0
	ld a, $01 ; $54b3
	farcall FarPtr_0a_76 ; $54b5
	ret ; $54b8
Func_6b_54b9:
	call DisableLCDSafely ; $54b9
	farcall FarPtr_0a_6a ; $54bc
	farcall FarPtr_05_00 ; $54bf
	wram_bank $01 ; $54c2
	ld hl, $551d ; $54c8
	ld de, $d000 ; $54cb
	call DecompressData ; $54ce
	ld hl, $d000 ; $54d1
	ld de, $9000 ; $54d4
	ld c, $80 ; $54d7
	call Func_00_0480 ; $54d9
	ld hl, $d800 ; $54dc
	ld de, $8800 ; $54df
	ld c, $80 ; $54e2
	call Func_00_0480 ; $54e4
	wram_bank $02 ; $54e7
	ld hl, $5bd7 ; $54ed
	ld de, $d000 ; $54f0
	call DecompressData ; $54f3
	wram_bank $03 ; $54f6
	ld hl, $59d7 ; $54fc
	ld de, $d000 ; $54ff
	call DecompressData ; $5502
	ld hl, $5d25 ; $5505
	ld de, $0008 ; $5508
	call LoadPaletteShadow ; $550b
	xor a, a ; $550e
	ld [$c322], a ; $550f
	ld a, $24 ; $5512
	ld [$c323], a ; $5514
	ld a, $01 ; $5517
	farcall FarPtr_0a_76 ; $5519
	ret ; $551c
	INCBIN "data/bank_06b/d_551d.bin" ; $551d, 2904 bytes
Func_6b_6075:
	ld b, $54 ; $6075
	ld c, $10 ; $6077
	ld de, $a000 ; $6079
	farcall FarPtr_39_10 ; $607c
	ld b, $55 ; $607f
	ld c, $10 ; $6081
	ld de, $a100 ; $6083
	farcall FarPtr_39_10 ; $6086
	ld b, $56 ; $6089
	ld c, $10 ; $608b
	ld de, $a200 ; $608d
	farcall FarPtr_39_10 ; $6090
	ld b, $57 ; $6093
	ld c, $10 ; $6095
	ld de, $a300 ; $6097
	farcall FarPtr_39_10 ; $609a
	ld b, $58 ; $609d
	ld c, $04 ; $609f
	ld de, $a400 ; $60a1
	farcall FarPtr_39_10 ; $60a4
	ld b, $59 ; $60a7
	ld c, $04 ; $60a9
	ld de, $a440 ; $60ab
	farcall FarPtr_39_10 ; $60ae
	ld b, $5a ; $60b1
	ld c, $04 ; $60b3
	ld de, $a480 ; $60b5
	farcall FarPtr_39_10 ; $60b8
	ld hl, Palettes_6b_60c5 ; $60bb
	ld de, $0802 ; $60be
	call LoadPaletteShadow ; $60c1
	ret ; $60c4
Palettes_6b_60c5:
	; $60c5, 16 bytes (palettes)
; GBC palettes (BGR555), 4 colors each
	dw $7c1f, $033f, $01af, $0000 ; pal 0: #ff00ff #ffcd00 #7b6a00 #000000
	dw $7f4e, $7f73, $7fb9, $7fff ; pal 1: #73d5ff #9cdeff #cdeeff #ffffff
Func_6b_60d5:
	ld hl, $cb4a ; $60d5
	ld a, [hl+] ; $60d8
	ld d, [hl] ; $60d9
	ld e, a ; $60da
	sla e ; $60db
	rl d ; $60dd
	sla e ; $60df
	rl d ; $60e1
	sla e ; $60e3
	rl d ; $60e5
	sla e ; $60e7
	rl d ; $60e9
	sla e ; $60eb
	rl d ; $60ed
	ld a, e ; $60ef
	ld [$c322], a ; $60f0
	ld a, d ; $60f3
	ld [$c323], a ; $60f4
	ret ; $60f7
Func_6b_60f8:
	ld hl, $cb4a ; $60f8
	ld a, [hl+] ; $60fb
	ld d, [hl] ; $60fc
	ld e, a ; $60fd
	ld hl, $cb48 ; $60fe
	ld a, [hl+] ; $6101
	ld h, [hl] ; $6102
	ld l, a ; $6103
	ld a, l ; $6104
	sub a, e ; $6105
	ld l, a ; $6106
	ld a, h ; $6107
	sbc a, d ; $6108
	ld h, a ; $6109
	ld e, l ; $610a
	ld a, [$cb4c] ; $610b
	ld c, a ; $610e
	ld d, $40 ; $610f
	call Func_6b_6126 ; $6111
	ret ; $6114
Func_6b_6115:
	ld a, [$cb4d] ; $6115
	inc a ; $6118
	ld [$cb4d], a ; $6119
	and a, $30 ; $611c
	rrca ; $611e
	rrca ; $611f
	rrca ; $6120
	rrca ; $6121
	ld [$cb4c], a ; $6122
	ret ; $6125
Func_6b_6126:
	ld hl, $6139 ; $6126
	ld a, c ; $6129
	add a, l ; $612a
	ld l, a ; $612b
	jr nc, Label_6b_612f ; $612c
	inc h ; $612e
Label_6b_612f:
	ld c, [hl] ; $612f
	ld hl, $613d ; $6130
	ld b, $08 ; $6133
	call QueueSpriteTemplate ; $6135
	ret ; $6138
	INCBIN "data/bank_06b/d_6139.bin" ; $6139, 67 bytes
Func_6b_617c:
	call DisableLCDSafely ; $617c
	farcall FarPtr_0a_6a ; $617f
	farcall FarPtr_05_00 ; $6182
	wram_bank $01 ; $6185
	ld hl, $61e6 ; $618b
	ld de, $d000 ; $618e
	call DecompressData ; $6191
	ld hl, $d000 ; $6194
	ld de, $b000 ; $6197
	ld c, $80 ; $619a
	call Func_00_0480 ; $619c
	ld hl, $d800 ; $619f
	ld de, $a800 ; $61a2
	ld c, $80 ; $61a5
	call Func_00_0480 ; $61a7
	wram_bank $02 ; $61aa
	ld hl, $6f0f ; $61b0
	ld de, $d000 ; $61b3
	call DecompressData ; $61b6
	wram_bank $03 ; $61b9
	ld hl, $6cbc ; $61bf
	ld de, $d000 ; $61c2
	call DecompressData ; $61c5
	ld hl, $7043 ; $61c8
	ld de, $0008 ; $61cb
	call LoadPaletteShadow ; $61ce
	ld a, $20 ; $61d1
	ld [$c321], a ; $61d3
	xor a, a ; $61d6
	ld [$c320], a ; $61d7
	ld [$c322], a ; $61da
	ld [$c323], a ; $61dd
	ld a, $01 ; $61e0
	farcall FarPtr_0a_76 ; $61e2
	ret ; $61e5
	INCBIN "data/bank_06b/d_61e6.bin" ; $61e6, 3741 bytes
	ld a, [$cb44] ; $7083
	inc a ; $7086
	ld [$cb44], a ; $7087
	cp a, $5a ; $708a
	jr nz, Label_6b_7096 ; $708c
	ld a, $01 ; $708e
	ld hl, $731b ; $7090
	call RegisterFrameTask ; $7093
Label_6b_7096:
	cp a, $aa ; $7096
	jr nz, Label_6b_70a2 ; $7098
	ld a, $01 ; $709a
	ld hl, $72af ; $709c
	call RegisterFrameTask ; $709f
Label_6b_70a2:
	cp a, $01 ; $70a2
	jr nz, Label_6b_70ae ; $70a4
	ld a, $01 ; $70a6
	ld hl, $72dd ; $70a8
	call RegisterFrameTask ; $70ab
Label_6b_70ae:
	ret ; $70ae
	INCBIN "data/bank_06b/d_70af.bin" ; $70af, 512 bytes
	ldh a, [$ff8c] ; $72af
	and a, $03 ; $72b1
	cp a, $03 ; $72b3
	ret nz ; $72b5
	ld a, [$cb45] ; $72b6
	inc a ; $72b9
	ld [$cb45], a ; $72ba
	cp a, $10 ; $72bd
	jr nc, Label_6b_72d6 ; $72bf
	sla a ; $72c1
	sla a ; $72c3
	sla a ; $72c5
	ld hl, $70af ; $72c7
	add a, l ; $72ca
	ld l, a ; $72cb
	jr nc, Label_6b_72cf ; $72cc
	inc h ; $72ce
Label_6b_72cf:
	ld de, $0101 ; $72cf
	call Func_00_05b5 ; $72d2
	ret ; $72d5
Label_6b_72d6:
	ld hl, $72af ; $72d6
	call Func_00_1bcb ; $72d9
	ret ; $72dc
	ldh a, [$ff8c] ; $72dd
	and a, $03 ; $72df
	cp a, $03 ; $72e1
	ret nz ; $72e3
	ld a, [$cb46] ; $72e4
	inc a ; $72e7
	ld [$cb46], a ; $72e8
	cp a, $10 ; $72eb
	jr nc, Label_6b_7314 ; $72ed
	sla a ; $72ef
	sla a ; $72f1
	sla a ; $72f3
	push af ; $72f5
	ld hl, $712f ; $72f6
	add a, l ; $72f9
	ld l, a ; $72fa
	jr nc, Label_6b_72fe ; $72fb
	inc h ; $72fd
Label_6b_72fe:
	ld de, $0201 ; $72fe
	call Func_00_05b5 ; $7301
	pop af ; $7304
	ld hl, $71af ; $7305
	add a, l ; $7308
	ld l, a ; $7309
	jr nc, Label_6b_730d ; $730a
	inc h ; $730c
Label_6b_730d:
	ld de, $0301 ; $730d
	call Func_00_05b5 ; $7310
	ret ; $7313
Label_6b_7314:
	ld hl, $72dd ; $7314
	call Func_00_1bcb ; $7317
	ret ; $731a
	ldh a, [$ff8c] ; $731b
	and a, $03 ; $731d
	cp a, $03 ; $731f
	ret nz ; $7321
	ld a, [$cb47] ; $7322
	inc a ; $7325
	ld [$cb47], a ; $7326
	cp a, $10 ; $7329
	jr nc, Label_6b_7342 ; $732b
	sla a ; $732d
	sla a ; $732f
	sla a ; $7331
	ld hl, $722f ; $7333
	add a, l ; $7336
	ld l, a ; $7337
	jr nc, Label_6b_733b ; $7338
	inc h ; $733a
Label_6b_733b:
	ld de, $0404 ; $733b
	call Func_00_05b5 ; $733e
	ret ; $7341
Label_6b_7342:
	cp a, $20 ; $7342
	jr c, Label_6b_735f ; $7344
	ld b, a ; $7346
	ld a, $20 ; $7347
	sub a, b ; $7349
	sla a ; $734a
	sla a ; $734c
	sla a ; $734e
	ld hl, $722f ; $7350
	add a, l ; $7353
	ld l, a ; $7354
	jr nc, Label_6b_7358 ; $7355
	inc h ; $7357
Label_6b_7358:
	ld de, $0404 ; $7358
	call Func_00_05b5 ; $735b
	ret ; $735e
Label_6b_735f:
	ld hl, $731b ; $735f
	call Func_00_1bcb ; $7362
	ret ; $7365
	ld a, [$cb40] ; $7366
	cp a, $10 ; $7369
	jr nc, Label_6b_7380 ; $736b
	ld hl, $7381 ; $736d
	add a, l ; $7370
	ld l, a ; $7371
	jr nc, Label_6b_7375 ; $7372
	inc h ; $7374
Label_6b_7375:
	ld a, [hl] ; $7375
	ld b, a ; $7376
	ld a, [$cb42] ; $7377
	add a, b ; $737a
	ld [$cb42], a ; $737b
	ldh [$ff8b], a ; $737e
Label_6b_7380:
	ret ; $7380
	INCBIN "data/bank_06b/d_7381.bin" ; $7381, 20 bytes
	ld a, [$cb40] ; $7395
	cp a, $10 ; $7398
	jr nc, Label_6b_73af ; $739a
	ld hl, $73b0 ; $739c
	add a, l ; $739f
	ld l, a ; $73a0
	jr nc, Label_6b_73a4 ; $73a1
	inc h ; $73a3
Label_6b_73a4:
	ld a, [hl] ; $73a4
	ld b, a ; $73a5
	ld a, [$cb42] ; $73a6
	sub a, b ; $73a9
	ld [$cb42], a ; $73aa
	ldh [$ff8b], a ; $73ad
Label_6b_73af:
	ret ; $73af
	INCBIN "data/bank_06b/d_73b0.bin" ; $73b0, 20 bytes
	ld a, [$cb40] ; $73c4
	cp a, $10 ; $73c7
	jr nc, Label_6b_73de ; $73c9
	ld hl, $73df ; $73cb
	add a, l ; $73ce
	ld l, a ; $73cf
	jr nc, Label_6b_73d3 ; $73d0
	inc h ; $73d2
Label_6b_73d3:
	ld a, [hl] ; $73d3
	ld b, a ; $73d4
	ld a, [$cb42] ; $73d5
	sub a, b ; $73d8
	ld [$cb42], a ; $73d9
	ldh [$ff8b], a ; $73dc
Label_6b_73de:
	ret ; $73de
	INCBIN "data/bank_06b/d_73df.bin" ; $73df, 19 bytes
Func_6b_73f2:
	ldh a, [hWramBank] ; $73f2
	push af ; $73f4
	wram_bank $01 ; $73f5
	ld hl, $6d10 ; $73fb -> DataPtr_IntroAwesomeTiles
	ld de, $d000 ; $73fe
	call DecompressDataFromBank ; $7401
	ld hl, $d000 ; $7404
	ld de, $9000 ; $7407
	ld c, $80 ; $740a
	call Func_00_0480 ; $740c
	ld hl, $d800 ; $740f
	ld de, $8800 ; $7412
	ld c, $80 ; $7415
	call Func_00_0480 ; $7417
	wram_bank $05 ; $741a
	ld hl, $7438 ; $7420
	ld de, $d000 ; $7423
	call DecompressData ; $7426
	ld hl, $7515 ; $7429
	ld de, $d400 ; $742c
	call DecompressData ; $742f
	pop af ; $7432
	wram_bank ; $7433
	ret ; $7437
	INCBIN "data/bank_06b/d_7438.bin" ; $7438, 305 bytes
	ld a, [$cb44] ; $7569
	ldh [$ff8a], a ; $756c
	ret ; $756e
Palettes_6b_756f:
	; $756f, 64 bytes (palettes)
; GBC palettes (BGR555), 4 colors each
	dw $0000, $0000, $0000, $0000 ; pal 0: #000000 #000000 #000000 #000000
	dw $0000, $0000, $0000, $0000 ; pal 1: #000000 #000000 #000000 #000000
	dw $0000, $0000, $0000, $0000 ; pal 2: #000000 #000000 #000000 #000000
	dw $0000, $0000, $0000, $0000 ; pal 3: #000000 #000000 #000000 #000000
	dw $0000, $0000, $0000, $0000 ; pal 4: #000000 #000000 #000000 #000000
	dw $0000, $0000, $0000, $0000 ; pal 5: #000000 #000000 #000000 #000000
	dw $0000, $0000, $0000, $0000 ; pal 6: #000000 #000000 #000000 #000000
	dw $0000, $0000, $0000, $0000 ; pal 7: #000000 #000000 #000000 #000000
Func_6b_75af:
	call ClearFrameTasks ; $75af
	wram_bank $03 ; $75b2
	xor a, a ; $75b8
	ldh [$ff8b], a ; $75b9
	ldh [$ff8a], a ; $75bb
	ld [$d800], a ; $75bd
	ld [$d801], a ; $75c0
	ld [$d802], a ; $75c3
	ld a, $98 ; $75c6
	ld [$d800], a ; $75c8
	ld c, $7f ; $75cb
	call Func_00_1d20 ; $75cd
	call Func_00_1da4 ; $75d0
	call DisableLCDSafely ; $75d3
	ld c, $7f ; $75d6
	call Func_00_1d20 ; $75d8
	call Func_00_1da4 ; $75db
	ld c, $1f ; $75de
	farcall FarPtr_LoadScreenAssetRecord ; $75e0
	farcall FarPtr_Func_39_4325 ; $75e3
	ld c, $14 ; $75e6
	ld b, $5b ; $75e8
	ld de, $a000 ; $75ea
	farcall FarPtr_39_10 ; $75ed
	ld c, $14 ; $75f0
	ld b, $5c ; $75f2
	ld de, $a200 ; $75f4
	farcall FarPtr_39_10 ; $75f7
	ld c, $14 ; $75fa
	ld b, $5d ; $75fc
	ld de, $a400 ; $75fe
	farcall FarPtr_39_10 ; $7601
	ld c, $14 ; $7604
	ld b, $5e ; $7606
	ld de, $a600 ; $7608
	farcall FarPtr_39_10 ; $760b
	ld c, $14 ; $760e
	ld b, $5f ; $7610
	ld de, $8000 ; $7612
	farcall FarPtr_39_10 ; $7615
	ld c, $14 ; $7618
	ld b, $60 ; $761a
	ld de, $8200 ; $761c
	farcall FarPtr_39_10 ; $761f
	ld c, $14 ; $7622
	ld b, $61 ; $7624
	ld de, $8400 ; $7626
	farcall FarPtr_39_10 ; $7629
	ld c, $14 ; $762c
	ld b, $62 ; $762e
	ld de, $8600 ; $7630
	farcall FarPtr_39_10 ; $7633
	ld hl, Palettes_6b_794f ; $7636
	ld de, $0801 ; $7639
	call LoadPaletteShadow ; $763c
	ld a, $01 ; $763f
	ld hl, $76b6 ; $7641
	call RegisterFrameTask ; $7644
	sound $02 ; $7647
	call EnableLCD ; $7649
	ld c, $04 ; $764c
	call Func_00_1d2e ; $764e
	call Func_00_1da4 ; $7651
	wram_bank $03 ; $7654
	ld a, $9f ; $765a
	ld [$d800], a ; $765c
Label_6b_765f:
	call Func_6b_771f ; $765f
	call Func_00_2631 ; $7662
	ldh a, [$ff94] ; $7665
	bit 0, a ; $7667
	jr nz, Label_6b_7680 ; $7669
	bit 3, a ; $766b
	jr nz, Label_6b_7680 ; $766d
	ldh a, [$ff8c] ; $766f
	and a, $07 ; $7671
	jr nz, Label_6b_765f ; $7673
	ld a, [$d800] ; $7675
	inc a ; $7678
	ld [$d800], a ; $7679
	jr z, Label_6b_76a6 ; $767c
	jr Label_6b_765f ; $767e
Label_6b_7680:
	sound $00 ; $7680
	sound $60 ; $7682
	call ClearFrameTasks ; $7684
	ld c, $10 ; $7687
	call Func_00_1d20 ; $7689
	call Func_00_1da4 ; $768c
	xor a, a ; $768f
	ret ; $7690
	sound $00 ; $7691
	call ClearFrameTasks ; $7693
	ld c, $20 ; $7696
	call Func_00_1d20 ; $7698
	call Func_00_1da4 ; $769b
	ld hl, rIE ; $769e
	res 1, [hl] ; $76a1
	ld a, $01 ; $76a3
	ret ; $76a5
Label_6b_76a6:
	sound $00 ; $76a6
	call ClearFrameTasks ; $76a8
	ld c, $08 ; $76ab
	call Func_00_1d20 ; $76ad
	call Func_00_1da4 ; $76b0
	ld a, $ff ; $76b3
	ret ; $76b5
	ldh a, [hWramBank] ; $76b6
	push af ; $76b8
	wram_bank $03 ; $76b9
	ld a, [$d801] ; $76bf
	ld hl, $76e6 ; $76c2
	add a, l ; $76c5
	ld l, a ; $76c6
	jr nc, Label_6b_76ca ; $76c7
	inc h ; $76c9
Label_6b_76ca:
	ld c, [hl] ; $76ca
	ld a, [$d801] ; $76cb
	ld hl, $76ee ; $76ce
	add a, l ; $76d1
	ld l, a ; $76d2
	jr nc, Label_6b_76d6 ; $76d3
	inc h ; $76d5
Label_6b_76d6:
	ld b, [hl] ; $76d6
	ld de, $2858 ; $76d7
	ld hl, $76f6 ; $76da
	call QueueSpriteTemplate ; $76dd
	pop af ; $76e0
	wram_bank ; $76e1
	ret ; $76e5
	INCBIN "data/bank_06b/d_76e6.bin" ; $76e6, 57 bytes
Func_6b_771f:
	ld a, [$d802] ; $771f
	or a, a ; $7722
	jr z, Label_6b_7732 ; $7723
	inc a ; $7725
	ld [$d802], a ; $7726
	cp a, $10 ; $7729
	jr nz, Label_6b_774c ; $772b
	xor a, a ; $772d
	ld [$d802], a ; $772e
	ret ; $7731
Label_6b_7732:
	ldh a, [$ff8c] ; $7732
	and a, $07 ; $7734
	cp a, $07 ; $7736
	jr nz, Label_6b_774c ; $7738
	ld a, [$d801] ; $773a
	inc a ; $773d
	and a, $07 ; $773e
	ld [$d801], a ; $7740
	cp a, $07 ; $7743
	jr nz, Label_6b_774c ; $7745
	ld a, $01 ; $7747
	ld [$d802], a ; $7749
Label_6b_774c:
	ret ; $774c
	ret ; $774d
TitleScreenTilemap:
	INCBIN "data/bank_06b/lz_774e.bin" ; $774e, 292 bytes
TitleScreenAttrmap:
	INCBIN "data/bank_06b/lz_7872.bin" ; $7872, 157 bytes
TitleScreenPalettes:
	; $790f, 64 bytes (palettes)
; GBC palettes (BGR555), 4 colors each
	dw $0242, $0000, $7fff, $021f ; pal 0: #109400 #000000 #ffffff #ff8300
	dw $0242, $0000, $7fff, $20df ; pal 1: #109400 #000000 #ffffff #ff3141
	dw $0242, $0000, $021f, $20df ; pal 2: #109400 #000000 #ff8300 #ff3141
	dw $0242, $0000, $68c8, $20df ; pal 3: #109400 #000000 #4131d5 #ff3141
	dw $0242, $0000, $7fff, $68c8 ; pal 4: #109400 #000000 #ffffff #4131d5
	dw $0242, $0000, $7fff, $035f ; pal 5: #109400 #000000 #ffffff #ffd500
	dw $0242, $0000, $035f, $68c8 ; pal 6: #109400 #000000 #ffd500 #4131d5
	dw $7fff, $7f0c, $68c8, $0000 ; pal 7: #ffffff #62c5ff #4131d5 #000000
Palettes_6b_794f:
	; $794f, 8 bytes (palettes)
; GBC palettes (BGR555), 4 colors each
	dw $7fff, $025f, $015f, $001f ; pal 0: #ffffff #ff9400 #ff5200 #ff0000
AwardCeremonyTilemap:
	INCBIN "data/bank_06b/lz_7957.bin" ; $7957, 293 bytes
AwardCeremonyAttrmap:
	INCBIN "data/bank_06b/lz_7a7c.bin" ; $7a7c, 114 bytes
AwardCeremonyTilemap2:
	INCBIN "data/bank_06b/lz_7aee.bin" ; $7aee, 292 bytes
AwardCeremonyAttrmap2:
	INCBIN "data/bank_06b/lz_7c12.bin" ; $7c12, 125 bytes
AwardCeremonyTilemap3:
	INCBIN "data/bank_06b/lz_7c8f.bin" ; $7c8f, 296 bytes
AwardCeremonyAttrmap3:
	INCBIN "data/bank_06b/lz_7db7.bin" ; $7db7, 120 bytes
AwardCeremonyTilemap4:
	INCBIN "data/bank_06b/lz_7e2f.bin" ; $7e2f, 296 bytes
AwardCeremonyAttrmap4:
	INCBIN "data/bank_06b/lz_7f57.bin" ; $7f57, 129 bytes
	ds 40, $ff ; $7fd8, fill
