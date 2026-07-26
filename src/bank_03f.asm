SECTION "ROM Bank $3f", ROMX[$4000], BANK[$3f]

	farptr TennisDictionaryScreen ; $4000
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
TennisDictionaryScreen:
	push af ; $407a
	wram_bank $06 ; $407b
	pop af ; $4081
	ld [wTennisDictMode], a ; $4082
	cp a, $00 ; $4085
	jr z, .eq00 ; $4087
	cp a, $01 ; $4089
	jr z, .eq01 ; $408b
	cp a, $02 ; $408d
	jr z, .eq02 ; $408f
	cp a, $03 ; $4091
	jr z, .eq03 ; $4093
	cp a, $04 ; $4095
	jr z, .eq04 ; $4097
	cp a, $05 ; $4099
	jr z, .eq05 ; $409b
	ld a, $1f ; $409d
	jr .store ; $409f
.eq00:
	ld a, $01 ; $40a1
	jr .store ; $40a3
.eq01:
	ld a, $02 ; $40a5
	jr .store ; $40a7
.eq02:
	ld a, $04 ; $40a9
	jr .store ; $40ab
.eq03:
	ld a, $08 ; $40ad
	jr .store ; $40af
.eq04:
	ld a, $10 ; $40b1
	jr .store ; $40b3
.eq05:
	ld a, $01 ; $40b5
	ld [$cb33], a ; $40b7
	ld a, $1f ; $40ba
	jr .store ; $40bc
.store:
	ld [wTennisDictCategoryMask], a ; $40be
	xor a, a ; $40c1
	ld [$cb3a], a ; $40c2
	ld [wTennisDictFlags], a ; $40c5
	ld [wTennisDictScrollTop], a ; $40c8
	ld [wTennisDictCursorRow], a ; $40cb
	ld [$cb3e], a ; $40ce
	ld a, $08 ; $40d1
	ld [$cb39], a ; $40d3
	ld a, $00 ; $40d6
	ld [$cb38], a ; $40d8
	ld a, $b4 ; $40db
	ld [$cb3d], a ; $40dd
	call LoadTennisDictionaryScreen ; $40e0
	wram_bank $06 ; $40e3
	xor a, a ; $40e9
	ld [$cb33], a ; $40ea
	ld a, [wTennisDictMode] ; $40ed
	cp a, $06 ; $40f0
	jr z, .disableLCDSafely ; $40f2
	call AdvanceFrame ; $40f4
	call DrawTennisDictionaryList ; $40f7
	ld a, [wTennisDictMode] ; $40fa
	cp a, $05 ; $40fd
	jr nz, .disableLCDSafely ; $40ff
	ld a, $01 ; $4101
	ld [$cb33], a ; $4103
.disableLCDSafely:
	call DisableLCDSafely ; $4106
	farcall LoadMenuTilesA ; $4109
	call EnableLCD ; $410c
	sound $05 ; $410f
	call AdvanceFrame ; $4111
	script_fade_in $10 ; $4114
	call WaitFadeEnd ; $4119
	ld a, $1d ; $411c
	ld hl, UpdateTennisDictionarySprites ; $411e
	call RegisterFrameTask ; $4121
	wram_bank $06 ; $4124
	ld a, [wTennisDictMode] ; $412a
	cp a, $06 ; $412d
	jr nz, .checkTennisDictFlags ; $412f
	wram_bank $06 ; $4131
	ld a, [wTennisDictFlags] ; $4137
	res 0, a ; $413a
	ld [wTennisDictFlags], a ; $413c
	call EndTennisDictionaryAnim ; $413f
	call WaitFramesCmd ; $4142
	db $01 ; $4145 inline arg
	ld a, $02 ; $4146
	jr .loop ; $4148
.checkTennisDictFlags:
	ld a, [wTennisDictFlags] ; $414a
	set 1, a ; $414d
	ld [wTennisDictFlags], a ; $414f
	ld a, $08 ; $4152
.loop:
	call AdvanceFrame ; $4154
	cp a, $04 ; $4157
	jp z, .showTennisDictionaryPageDefault ; $4159
	cp a, $10 ; $415c
	jp z, .showTennisDictionaryPageChar6 ; $415e
	cp a, $08 ; $4161
	jp z, .handleTennisDictionaryListInput ; $4163
	call HandleTennisDictionaryIndexInput ; $4166
	jr .restorePalettesFromMaster ; $4169
.handleTennisDictionaryListInput:
	call HandleTennisDictionaryListInput ; $416b
	jr .restorePalettesFromMaster ; $416e
.showTennisDictionaryPageDefault:
	call ShowTennisDictionaryPageDefault ; $4170
	jr .restorePalettesFromMaster ; $4173
.showTennisDictionaryPageChar6:
	call ShowTennisDictionaryPageChar6 ; $4175
.restorePalettesFromMaster:
	call RestorePalettesFromMaster ; $4178
	cp a, $01 ; $417b
	jp nz, .loop ; $417d
	push af ; $4180
	ld c, $10 ; $4181
	call BeginFadeOut ; $4183
	call WaitFadeEnd ; $4186
	pop af ; $4189
	call ResetTennisDictionaryScroll ; $418a
	ld hl, UpdateTennisDictionarySprites ; $418d
	call UnregisterFrameTask ; $4190
	ret ; $4193
ShowTennisDictionaryPageDefault:
	ld c, $10 ; $4194
	call BeginFadeOut ; $4196
	call WaitFadeEnd ; $4199
	ld a, $0d ; $419c
	ld [wCameraX + 1], a ; $419e
	xor a, a ; $41a1
	ld [wCameraX], a ; $41a2
	wram_bank $06 ; $41a5
	ld a, [wTennisDictCursorRow] ; $41ab
	ld b, a ; $41ae
	xor a, a ; $41af
	call DrawTennisDictionaryIndexCursor ; $41b0
	farcall UpdateSceneScroll ; $41b3
	call AdvanceFrame ; $41b6
	call DisableLCDSafely ; $41b9
	call LoadTennisDictionaryAssetsDefault ; $41bc
	ld a, $01 ; $41bf
	farcall CopyScrolledSceneTilemapToVram ; $41c1
	call EnableLCD ; $41c4
	call SetTennisDictionaryListFromIndexRow ; $41c7
	call DrawTennisDictionaryList ; $41ca
	ld a, [wTennisDictFlags] ; $41cd
	set 1, a ; $41d0
	ld [wTennisDictFlags], a ; $41d2
	script_fade_in $10 ; $41d5
	call WaitFadeEnd ; $41da
	ld a, $08 ; $41dd
	ret ; $41df
ShowTennisDictionaryPageChar6:
	ld c, $10 ; $41e0
	call BeginFadeOut ; $41e2
	call WaitFadeEnd ; $41e5
	ld a, $21 ; $41e8
	ld [wCameraX + 1], a ; $41ea
	xor a, a ; $41ed
	ld [wCameraX], a ; $41ee
	call SetTennisDictionaryIndexRowFromList ; $41f1
	ld a, [wTennisDictCursorRow] ; $41f4
	ld b, a ; $41f7
	ld a, $01 ; $41f8
	call DrawTennisDictionaryIndexCursor ; $41fa
	farcall UpdateSceneScroll ; $41fd
	call AdvanceFrame ; $4200
	call DisableLCDSafely ; $4203
	call LoadTennisDictionaryAssetsChar6 ; $4206
	ld a, $01 ; $4209
	farcall CopyScrolledSceneTilemapToVram ; $420b
	call EnableLCD ; $420e
	wram_bank $06 ; $4211
	ld a, [wTennisDictFlags] ; $4217
	res 1, a ; $421a
	ld [wTennisDictFlags], a ; $421c
	script_fade_in $10 ; $421f
	call WaitFadeEnd ; $4224
	ld a, $02 ; $4227
	ret ; $4229
	add hl, de ; $422a
	ld a, h ; $422b
	cp a, b ; $422c
	jr nc, .updateSceneScroll ; $422d
	ld a, l ; $422f
	ld [wCameraX], a ; $4230
	ld a, h ; $4233
	ld [wCameraX + 1], a ; $4234
	jr .updateSceneScroll2 ; $4237
.updateSceneScroll:
	farcall UpdateSceneScroll ; $4239
	ld a, $01 ; $423c
	ret ; $423e
.updateSceneScroll2:
	farcall UpdateSceneScroll ; $423f
	xor a, a ; $4242
	ret ; $4243
ResetTennisDictionaryScroll:
	wram_bank $06 ; $4244
	xor a, a ; $424a
	ldh [hScrollX], a ; $424b
	ld [wCameraX + 1], a ; $424d
	ld [wCameraX], a ; $4250
	ldh [hScrollY], a ; $4253
	ld hl, wCameraY ; $4255
	ld [hl+], a ; $4258
	ld [hl+], a ; $4259
	ldh [hBGColumnBlitPending], a ; $425a
	ldh [hBGRowBlitPending], a ; $425c
	ret ; $425e
LoadTennisDictionaryAssetsDefault:
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
	ld hl, TennisDictionaryPalettesDefault ; $4284
	ld de, $0008 ; $4287
	call LoadPalettesMasterOnly ; $428a
	wram_bank $02 ; $428d
	ld hl, TennisDictionaryListDataDefault ; $4293
	ld de, $d000 ; $4296
	call DecompressData ; $4299
	call ClearTennisDictionaryTilemap ; $429c
	ret ; $429f
LoadTennisDictionaryAssetsChar6:
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
	ld hl, TennisDictionaryPalettesChar6 ; $42c5
	ld de, $0008 ; $42c8
	call LoadPalettesMasterOnly ; $42cb
	wram_bank $02 ; $42ce
	ld hl, TennisDictionaryListDataChar6 ; $42d4
	ld de, $d000 ; $42d7
	call DecompressData ; $42da
	ret ; $42dd
ClearTennisDictionaryTilemap:
	wram_bank $02 ; $42de
	ld c, $0e ; $42e4
	ld hl, TennisDictionaryClearList2 ; $42e6
.loop:
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
	jr nz, .loop ; $42fb
	ret ; $42fd
LoadTennisDictionaryScreen:
	wram_bank $06 ; $42fe
	ld a, [wTennisDictMode] ; $4304
	cp a, $06 ; $4307
	jr nz, .ne06 ; $4309
	ld a, $21 ; $430b
	jr .store ; $430d
.ne06:
	ld a, $0d ; $430f
.store:
	ldh [hScrollX], a ; $4311
	ld [wCameraX + 1], a ; $4313
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
	call CountTennisDictionaryEntries ; $432b
	call FindTennisDictionaryListEnd ; $432e
	wram_bank $01 ; $4331
	ld hl, TennisDictionaryTiles8000 ; $4337
	ld de, $d000 ; $433a
	call DecompressData ; $433d
	ld hl, $d000 ; $4340
	ld de, $8000 ; $4343
	ld c, $20 ; $4346
	call QueueVRAMCopy ; $4348
	ld hl, TennisDictionaryTiles8200 ; $434b
	ld de, $d000 ; $434e
	call DecompressData ; $4351
	ld hl, $d000 ; $4354
	ld de, $8200 ; $4357
	ld c, $20 ; $435a
	call QueueVRAMCopy ; $435c
	ld hl, TennisDictionaryTiles8400 ; $435f
	ld de, $d000 ; $4362
	call DecompressData ; $4365
	ld hl, $d000 ; $4368
	ld de, $8400 ; $436b
	ld c, $20 ; $436e
	call QueueVRAMCopy ; $4370
	ld hl, TennisDictionaryTilesA000 ; $4373
	ld de, $d000 ; $4376
	call DecompressData ; $4379
	ld hl, $d000 ; $437c
	ld de, $a000 ; $437f
	ld c, $20 ; $4382
	call QueueVRAMCopy ; $4384
	ld hl, TennisDictionaryTilesA200 ; $4387
	ld de, $d000 ; $438a
	call DecompressData ; $438d
	ld hl, $d000 ; $4390
	ld de, $a200 ; $4393
	ld c, $20 ; $4396
	call QueueVRAMCopy ; $4398
	ld hl, TennisDictionaryTilesA400 ; $439b
	ld de, $d000 ; $439e
	call DecompressData ; $43a1
	ld hl, $d000 ; $43a4
	ld de, $a400 ; $43a7
	ld c, $20 ; $43aa
	call QueueVRAMCopy ; $43ac
	ld hl, TennisDictionaryPalettes ; $43af
	ld de, $0808 ; $43b2
	call LoadPalettesMasterOnly ; $43b5
	wram_bank $06 ; $43b8
	ld a, [wTennisDictMode] ; $43be
	cp a, $06 ; $43c1
	jr nz, .loadTennisDictionaryAssetsDefault ; $43c3
	call LoadTennisDictionaryAssetsChar6 ; $43c5
	jr .step2 ; $43c8
.loadTennisDictionaryAssetsDefault:
	call LoadTennisDictionaryAssetsDefault ; $43ca
.step2:
	wram_bank $03 ; $43cd
	ld hl, TennisDictionaryListData ; $43d3
	ld de, $d000 ; $43d6
	call DecompressData ; $43d9
	wram_bank $03 ; $43dc
	ld c, $0e ; $43e2
	ld hl, TennisDictionaryClearList2 ; $43e4
.loop:
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
	call FillBytes_3f ; $43f5
	pop hl ; $43f8
	pop bc ; $43f9
	dec c ; $43fa
	jr nz, .loop ; $43fb
	wram_bank $06 ; $43fd
	ld a, [wTennisDictMode] ; $4403
	ld c, a ; $4406
	wram_bank $03 ; $4407
	inc c ; $440d
	ld b, $20 ; $440e
	xor a, a ; $4410
.loopB:
	add a, b ; $4411
	dec c ; $4412
	jr nz, .loopB ; $4413
	ld c, $0b ; $4415
	ld hl, $d052 ; $4417
.loopBB:
	ld [hl+], a ; $441a
	inc a ; $441b
	dec c ; $441c
	jr nz, .loopBB ; $441d
	add a, $05 ; $441f
	ld c, $0b ; $4421
	ld hl, $d092 ; $4423
.loopBBB:
	ld [hl+], a ; $4426
	inc a ; $4427
	dec c ; $4428
	jr nz, .loopBBB ; $4429
	wram_bank $06 ; $442b
	call EnableLCD ; $4431
	wram_bank $06 ; $4434
	farcall UpdateSceneScroll ; $443a
	call DisableLCDSafely ; $443d
	wram_bank $03 ; $4440
	ld a, $01 ; $4446
	farcall CopyScrolledSceneTilemapToVram ; $4448
	call EnableLCD ; $444b
	ret ; $444e
TennisDictionaryClearList:
	; $444f, 56 bytes (records:4)
; 14 records x 4 bytes
	dw $d066, $000a ; record 0
	dw $d0a6, $000a ; record 1
	dw $d165, $0001 ; record 2
	dw $d1a5, $0001 ; record 3
	dw $d1e5, $0001 ; record 4
	dw $d225, $0001 ; record 5
	dw $d265, $0001 ; record 6
	dw $d2a5, $0001 ; record 7
	dw $d2e5, $0001 ; record 8
	dw $d325, $0001 ; record 9
	dw $d365, $0001 ; record 10
	dw $d3a5, $0001 ; record 11
	dw $d052, $000a ; record 12
	dw $d092, $000a ; record 13
TennisDictionaryClearList2:
	; $4487, 56 bytes (records:4)
; 14 records x 4 bytes
	dw $d10f, $0010 ; record 0
	dw $d14f, $0010 ; record 1
	dw $d18f, $0010 ; record 2
	dw $d1cf, $0010 ; record 3
	dw $d20f, $0010 ; record 4
	dw $d24f, $0010 ; record 5
	dw $d28f, $0010 ; record 6
	dw $d2cf, $0010 ; record 7
	dw $d30f, $0010 ; record 8
	dw $d34f, $0010 ; record 9
	dw $d38f, $0010 ; record 10
	dw $d3cf, $0010 ; record 11
	dw $d050, $0001 ; record 12
	dw $d05e, $0001 ; record 13
TennisDictionaryListDataChar6:
	INCBIN "data/bank_03f/lz_44bf.bin" ; $44bf, 130 bytes
TennisDictionaryListDataDefault:
	INCBIN "data/bank_03f/lz_4541.bin" ; $4541, 91 bytes
TennisDictionaryListData:
	INCBIN "data/bank_03f/lz_459c.bin" ; $459c, 530 bytes
TennisDictionaryPalettesChar6:
	; $47ae, 72 bytes (palettes)
; GBC palettes (BGR555), 4 colors each
	dw $42d6, $5b9c, $2252, $0884 ; pal 0: #b4b483 #e6e6b4 #949441 #202010
	dw $0880, $0884, $2252, $5b9c ; pal 1: #002010 #202010 #949441 #e6e6b4
	dw $59c2, $035f, $02df, $4250 ; pal 2: #1073b4 #ffd500 #ffb400 #839483
	dw $6bdf, $3a92, $2902, $0000 ; pal 3: #fff6d5 #94a473 #104152 #000000
	dw $6244, $59c2, $4940, $3900 ; pal 4: #2094c5 #1073b4 #005294 #004173
	dw $5982, $4940, $0880, $0880 ; pal 5: #1062b4 #005294 #002010 #002010
	dw $5b9c, $3a94, $0884, $03ff ; pal 6: #e6e6b4 #a4a473 #202010 #ffff00
	dw $435c, $0db7, $3296, $110c ; pal 7: #e6d583 #bd6a18 #b4a462 #624120
	dw $0000, $0db7, $3296, $110c ; pal 8: #000000 #bd6a18 #b4a462 #624120
TennisDictionaryPalettesDefault:
	; $47f6, 72 bytes (palettes)
; GBC palettes (BGR555), 4 colors each
	dw $42d6, $5b9c, $2252, $0884 ; pal 0: #b4b483 #e6e6b4 #949441 #202010
	dw $0880, $0884, $2252, $435c ; pal 1: #002010 #202010 #949441 #e6d583
	dw $435c, $0db7, $0046, $03ff ; pal 2: #e6d583 #bd6a18 #311000 #ffff00
	dw $1173, $0dc9, $165f, $0a14 ; pal 3: #9c5a20 #4a7318 #ff9429 #a48310
	dw $21d1, $5b9c, $42d6, $0000 ; pal 4: #8b7341 #e6e6b4 #b4b483 #000000
	dw $165f, $03ff, $0154, $0000 ; pal 5: #ff9429 #ffff00 #a45200 #000000
	dw $5b9c, $42d6, $228a, $11c0 ; pal 6: #e6e6b4 #b4b483 #52a441 #007320
	dw $001f, $0884, $2a1f, $03f3 ; pal 7: #ff0000 #202010 #ff8352 #9cff00
	dw $165f, $0884, $2a1f, $03f3 ; pal 8: #ff9429 #202010 #ff8352 #9cff00
TennisDictionaryTiles8000:
	INCBIN "data/bank_03f/lz_483e.bin" ; $483e, 287 bytes
TennisDictionaryTiles8200:
	INCBIN "data/bank_03f/lz_495d.bin" ; $495d, 322 bytes
TennisDictionaryTiles8400:
	INCBIN "data/bank_03f/lz_4a9f.bin" ; $4a9f, 310 bytes
TennisDictionaryTilesA000:
	INCBIN "data/bank_03f/lz_4bd5.bin" ; $4bd5, 180 bytes
TennisDictionaryTilesA200:
	INCBIN "data/bank_03f/lz_4c89.bin" ; $4c89, 258 bytes
TennisDictionaryTilesA400:
	INCBIN "data/bank_03f/lz_4d8b.bin" ; $4d8b, 174 bytes
TennisDictionaryPalettes:
	; $4e39, 48 bytes (palettes)
; GBC palettes (BGR555), 4 colors each
	dw $014b, $7fff, $121f, $0000 ; pal 0: #5a5200 #ffffff #ff8320 #000000
	dw $014b, $7e5f, $7ec0, $281c ; pal 1: #5a5200 #ff94ff #00b4ff #e60052
	dw $7fe0, $00ff, $7d80, $0000 ; pal 2: #00ffff #ff3900 #0062ff #000000
	dw $7fe0, $6bff, $7ece, $0000 ; pal 3: #00ffff #ffffd5 #73b4ff #000000
	dw $7fe0, $00ff, $67ff, $0000 ; pal 4: #00ffff #ff3900 #ffffcd #000000
	dw $7fe0, $165f, $03ff, $0000 ; pal 5: #00ffff #ff9429 #ffff00 #000000
EndTennisDictionaryAnim:
	ld a, [$cb38] ; $4e69
	cp a, $03 ; $4e6c
	jr nc, .done ; $4e6e
	ld a, $04 ; $4e70
	ld [$cb38], a ; $4e72
	ld a, $ff ; $4e75
	ld [$cb3d], a ; $4e77
.done:
	ret ; $4e7a
StartTennisDictionaryAnim:
	ld a, $b4 ; $4e7b
	ld [$cb3d], a ; $4e7d
	ldh a, [hVBlankCounter] ; $4e80
	and a, $03 ; $4e82
	cp a, $03 ; $4e84
	jr nz, .store ; $4e86
	xor a, a ; $4e88
.store:
	ld [$cb38], a ; $4e89
	ret ; $4e8c
UpdateTennisDictionarySprites:
	ldh a, [hWramBank] ; $4e8d
	push af ; $4e8f
	push af ; $4e90
	push bc ; $4e91
	push de ; $4e92
	push hl ; $4e93
	wram_bank $06 ; $4e94
	test_flag FLAG_TEXT_WAITING_FOR_BUTTON ; $4e9a
	jr z, .notTextWaitingForButton ; $4e9d
	sound $5f ; $4e9f
	call StartTennisDictionaryAnim ; $4ea1
.notTextWaitingForButton:
	ld a, [$cb38] ; $4ea4
	cp a, $04 ; $4ea7
	jr nz, .compare ; $4ea9
	ld a, [$cb3d] ; $4eab
	dec a ; $4eae
	ld [$cb3d], a ; $4eaf
	jr nz, .checkTennisDictMode ; $4eb2
	ld a, $03 ; $4eb4
	ld [$cb38], a ; $4eb6
	jr .checkTennisDictMode ; $4eb9
.compare:
	cp a, $03 ; $4ebb
	jr nz, .ne03 ; $4ebd
	jr .checkTennisDictMode ; $4ebf
.ne03:
	ld a, [$cb3d] ; $4ec1
	dec a ; $4ec4
	ld [$cb3d], a ; $4ec5
	jr nz, .checkTennisDictMode ; $4ec8
	ld a, $04 ; $4eca
	ld [$cb38], a ; $4ecc
	ld a, $ff ; $4ecf
	ld [$cb3d], a ; $4ed1
.checkTennisDictMode:
	ld a, [wTennisDictMode] ; $4ed4
	cp a, $06 ; $4ed7
	jp nz, .checkTennisDictFlags ; $4ed9
	ld a, [$cb39] ; $4edc
	dec a ; $4edf
	ld [$cb39], a ; $4ee0
	jr nz, .step3 ; $4ee3
	ld a, $08 ; $4ee5
	ld [$cb39], a ; $4ee7
	ld a, [$cb3a] ; $4eea
	inc a ; $4eed
	cp a, $10 ; $4eee
	jr nz, .store ; $4ef0
	xor a, a ; $4ef2
.store:
	ld [$cb3a], a ; $4ef3
.step3:
	ld hl, Data_3f_5028 ; $4ef6
	ld a, [$cb38] ; $4ef9
	add a, a ; $4efc
	add a, a ; $4efd
	add a, a ; $4efe
	add a, a ; $4eff
	add a, l ; $4f00
	ld l, a ; $4f01
	jr nc, .step4 ; $4f02
	inc h ; $4f04
.step4:
	ld a, [$cb3a] ; $4f05
	add a, l ; $4f08
	ld l, a ; $4f09
	jr nc, .read ; $4f0a
	inc h ; $4f0c
.read:
	ld a, [hl] ; $4f0d
	add a, a ; $4f0e
	add a, a ; $4f0f
	add a, a ; $4f10
	push af ; $4f11
	pop af ; $4f12
	ld hl, Data_3f_5078 ; $4f13
	add a, l ; $4f16
	ld l, a ; $4f17
	jr nc, .readB ; $4f18
	inc h ; $4f1a
.readB:
	ld a, [hl+] ; $4f1b
	ld c, a ; $4f1c
	ld a, [hl+] ; $4f1d
	ld b, a ; $4f1e
	ld a, [wTennisDictFlags] ; $4f1f
	bit 1, a ; $4f22
	jr z, .bit1Clear ; $4f24
	ld de, $907d ; $4f26
	jr .queueSpriteTemplate ; $4f29
.bit1Clear:
	ld de, $807d ; $4f2b
.queueSpriteTemplate:
	push hl ; $4f2e
	ld hl, SpriteTemplate_3f_50d0 ; $4f2f
	call QueueSpriteTemplate ; $4f32
	pop hl ; $4f35
	ld a, [hl+] ; $4f36
	ld c, a ; $4f37
	ld a, [hl+] ; $4f38
	ld b, a ; $4f39
	ld a, [wTennisDictFlags] ; $4f3a
	bit 1, a ; $4f3d
	jr z, .bit1Clear2 ; $4f3f
	ld de, $886d ; $4f41
	jr .queueSpriteTemplate2 ; $4f44
.bit1Clear2:
	ld de, $786d ; $4f46
.queueSpriteTemplate2:
	push hl ; $4f49
	ld hl, SpriteTemplate_3f_50d9 ; $4f4a
	call QueueSpriteTemplate ; $4f4d
	pop hl ; $4f50
	ld a, [hl+] ; $4f51
	ld c, a ; $4f52
	ld a, [hl+] ; $4f53
	ld b, a ; $4f54
	ld a, [wTennisDictFlags] ; $4f55
	bit 1, a ; $4f58
	jr z, .bit1Clear3 ; $4f5a
	ld de, $887d ; $4f5c
	jr .queueSpriteTemplate3 ; $4f5f
.bit1Clear3:
	ld de, $787d ; $4f61
.queueSpriteTemplate3:
	push hl ; $4f64
	ld hl, SpriteTemplate_3f_50d9 ; $4f65
	call QueueSpriteTemplate ; $4f68
	pop hl ; $4f6b
	ld a, [hl+] ; $4f6c
	ld c, a ; $4f6d
	ld a, [hl+] ; $4f6e
	ld b, a ; $4f6f
	ld a, [wTennisDictFlags] ; $4f70
	bit 1, a ; $4f73
	jr z, .bit1Clear4 ; $4f75
	ld de, $888d ; $4f77
	jr .queueSpriteTemplate4 ; $4f7a
.bit1Clear4:
	ld de, $788d ; $4f7c
.queueSpriteTemplate4:
	ld hl, SpriteTemplate_3f_50d9 ; $4f7f
	call QueueSpriteTemplate ; $4f82
.checkTennisDictFlags:
	ld a, [wTennisDictFlags] ; $4f85
	bit 1, a ; $4f88
	jr z, .restore ; $4f8a
	ld a, [wTennisDictFlags] ; $4f8c
	bit 0, a ; $4f8f
	jr nz, .checkTennisDictCursorRow ; $4f91
	ld a, [$cb3e] ; $4f93
	inc a ; $4f96
	ld [$cb3e], a ; $4f97
.checkTennisDictCursorRow:
	ld a, [wTennisDictCursorRow] ; $4f9a
	ld b, a ; $4f9d
	inc b ; $4f9e
	ld a, $14 ; $4f9f
	ld e, $10 ; $4fa1
	sub a, e ; $4fa3
.loop:
	add a, e ; $4fa4
	dec b ; $4fa5
	jr nz, .loop ; $4fa6
	add a, e ; $4fa8
	add a, $14 ; $4fa9
	ld e, a ; $4fab
	ld hl, Data_3f_4ff6 ; $4fac
	ld a, [$cb3e] ; $4faf
	and a, $0f ; $4fb2
	add a, l ; $4fb4
	ld l, a ; $4fb5
	jr nc, .readBB ; $4fb6
	inc h ; $4fb8
.readBB:
	ld a, [hl] ; $4fb9
	add a, $0a ; $4fba
	ld d, a ; $4fbc
	ld hl, SpriteTemplate_3f_501f ; $4fbd
	ld bc, $0b28 ; $4fc0
	call QueueSpriteTemplate ; $4fc3
	ld a, [wTennisDictFlags] ; $4fc6
	bit 2, a ; $4fc9
	jr z, .checkTennisDictFlags2 ; $4fcb
	ld hl, SpriteTemplate_3f_5006 ; $4fcd
	ld de, $1810 ; $4fd0
	ld bc, $0d34 ; $4fd3
	call QueueSpriteTemplate ; $4fd6
.checkTennisDictFlags2:
	ld a, [wTennisDictFlags] ; $4fd9
	bit 3, a ; $4fdc
	jr z, .restore ; $4fde
	ld hl, SpriteTemplate_3f_5006 ; $4fe0
	ld de, $8810 ; $4fe3
	ld bc, $0d3a ; $4fe6
	call QueueSpriteTemplate ; $4fe9
.restore:
	pop hl ; $4fec
	pop de ; $4fed
	pop bc ; $4fee
	pop af ; $4fef
	pop af ; $4ff0
	wram_bank ; $4ff1
	ret ; $4ff5
Data_3f_4ff6:
	; $4ff6, 16 bytes (bytes:16)
	db $00, $01, $01, $02, $03, $04, $06, $08, $06, $04, $03, $02, $01, $01, $00, $00 ; 0x00
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
Data_3f_5028:
	INCBIN "data/bank_03f/d_5028.bin" ; $5028, 80 bytes
Data_3f_5078:
	INCBIN "data/bank_03f/d_5078.bin" ; $5078, 88 bytes
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
FillBytes_3f:
	push af ; $50ea
	push bc ; $50eb
	push de ; $50ec
	push hl ; $50ed
.loop:
	ld [hl+], a ; $50ee
	dec c ; $50ef
	jr nz, .loop ; $50f0
	pop hl ; $50f2
	pop de ; $50f3
	pop bc ; $50f4
	pop af ; $50f5
	ret ; $50f6
CountTennisDictionaryEntries:
	wram_bank $06 ; $50f7
	ld hl, SelectionMaskGrid_3f_539e ; $50fd
	ld c, $00 ; $5100
	ld a, [wTennisDictCategoryMask] ; $5102
	ld d, a ; $5105
.loop:
	ld a, [hl+] ; $5106
	cp a, $00 ; $5107
	jr z, .loop ; $5109
	cp a, $40 ; $510b
	jr z, .eq40 ; $510d
	and a, d ; $510f
	jr z, .loop ; $5110
	inc c ; $5112
	jr .loop ; $5113
.eq40:
	ld a, c ; $5115
	ld [wTennisDictEntryCount], a ; $5116
	ret ; $5119
FindTennisDictionaryListEnd:
	wram_bank $06 ; $511a
	ld hl, SelectionMaskGrid_3f_539e ; $5120
	ld c, $00 ; $5123
.loop:
	ld a, [hl+] ; $5125
	cp a, $40 ; $5126
	jr nz, .loop ; $5128
	dec hl ; $512a
	ld a, h ; $512b
	ld [$cb30], a ; $512c
	ld a, l ; $512f
	ld [$cb31], a ; $5130
	ret ; $5133
GetTennisDictionaryEntryIndex:
	ld d, $00 ; $5134
	ld c, a ; $5136
	inc c ; $5137
	ld hl, SelectionMaskGrid_3f_539e ; $5138
.loop:
	ld a, [hl+] ; $513b
	cp a, $00 ; $513c
	jr z, .loop ; $513e
	inc d ; $5140
	and a, b ; $5141
	jr z, .loop ; $5142
	dec c ; $5144
	jr nz, .loop ; $5145
	dec d ; $5147
	ld a, d ; $5148
	ret ; $5149
GetTennisDictionaryEntryCategory:
	ld d, $00 ; $514a
	ld c, a ; $514c
	inc c ; $514d
	ld hl, SelectionMaskGrid_3f_539e ; $514e
.loop:
	ld a, [hl+] ; $5151
	cp a, $00 ; $5152
	jr z, .loop ; $5154
	inc d ; $5156
	and a, b ; $5157
	jr z, .loop ; $5158
	dec c ; $515a
	jr nz, .loop ; $515b
	cp a, $01 ; $515d
	jr z, .eq01 ; $515f
	cp a, $02 ; $5161
	jr z, .eq02 ; $5163
	cp a, $04 ; $5165
	jr z, .eq04 ; $5167
	cp a, $08 ; $5169
	jr z, .eq08 ; $516b
	ld a, $04 ; $516d
	ret ; $516f
.eq01:
	xor a, a ; $5170
	ret ; $5171
.eq02:
	ld a, $01 ; $5172
	ret ; $5174
.eq04:
	ld a, $02 ; $5175
	ret ; $5177
.eq08:
	ld a, $03 ; $5178
	ret ; $517a
GetTennisDictionarySelectedIndex:
	wram_bank $06 ; $517b
	ld a, [wTennisDictEntryCount] ; $5181
	ld d, a ; $5184
	ld a, [wTennisDictCursorRow] ; $5185
	ld c, a ; $5188
	ld a, [wTennisDictScrollTop] ; $5189
	add a, c ; $518c
	cp a, d ; $518d
	jr c, .done ; $518e
	sub a, d ; $5190
.done:
	ret ; $5191
ScrollTennisDictionaryToPrevLetter:
	wram_bank $06 ; $5192
	ld hl, SelectionMaskGrid_3f_539e ; $5198
	call GetTennisDictionarySelectedIndex ; $519b
	ld b, a ; $519e
	ld c, a ; $519f
	inc b ; $51a0
	xor a, a ; $51a1
	ld [wTennisDictCursorRow], a ; $51a2
	ld a, [wTennisDictCategoryMask] ; $51a5
	ld e, a ; $51a8
	jr WrapTennisDictionaryScanToEnd.loop ; $51a9
WrapTennisDictionaryScanToEnd:
	push af ; $51ab
	ld a, [wTennisDictEntryCount] ; $51ac
	dec a ; $51af
	ld c, a ; $51b0
	ld a, [$cb30] ; $51b1
	ld h, a ; $51b4
	ld a, [$cb31] ; $51b5
	ld l, a ; $51b8
	dec hl ; $51b9
	pop af ; $51ba
	ret ; $51bb
.loop:
	ld a, [hl+] ; $51bc
	and a, e ; $51bd
	jr z, .loop ; $51be
	dec b ; $51c0
	jr nz, .loop ; $51c1
	dec hl ; $51c3
.loopB:
	ld a, [hl-] ; $51c4
	ld d, a ; $51c5
	and a, e ; $51c6
	jr z, .step ; $51c7
	dec c ; $51c9
.step:
	ld a, d ; $51ca
	cp a, $40 ; $51cb
	jr z, .wrapTennisDictionaryScanToEnd ; $51cd
	cp a, $00 ; $51cf
	jr nz, .loopB ; $51d1
	jr .loopBB ; $51d3
.wrapTennisDictionaryScanToEnd:
	call WrapTennisDictionaryScanToEnd ; $51d5
.loopBB:
	ld a, [hl-] ; $51d8
	cp a, $40 ; $51d9
	jr nz, .ne40 ; $51db
	call WrapTennisDictionaryScanToEnd ; $51dd
.ne40:
	and a, e ; $51e0
	jr z, .loopBB ; $51e1
	dec c ; $51e3
.loopBBB:
	ld a, [hl-] ; $51e4
	ld d, a ; $51e5
	and a, e ; $51e6
	jr z, .step3 ; $51e7
	dec c ; $51e9
.step3:
	ld a, d ; $51ea
	cp a, $40 ; $51eb
	jr z, .wrapTennisDictionaryScanToEnd2 ; $51ed
	cp a, $00 ; $51ef
	jr nz, .loopBBB ; $51f1
	inc hl ; $51f3
	inc c ; $51f4
	jr .loopBBBB ; $51f5
.wrapTennisDictionaryScanToEnd2:
	call WrapTennisDictionaryScanToEnd ; $51f7
	inc hl ; $51fa
.loopBBBB:
	ld a, [hl+] ; $51fb
	cp a, $40 ; $51fc
	jr nz, .ne402 ; $51fe
	ld c, $00 ; $5200
	ld hl, SelectionMaskGrid_3f_539e ; $5202
	jr .loopBBBB ; $5205
.ne402:
	and a, e ; $5207
	jr z, .loopBBBB ; $5208
	ld a, c ; $520a
	ld [wTennisDictScrollTop], a ; $520b
	ret ; $520e
ScrollTennisDictionaryToNextLetter:
	wram_bank $06 ; $520f
	ld hl, SelectionMaskGrid_3f_539e ; $5215
	ld a, [wTennisDictEntryCount] ; $5218
	ld b, a ; $521b
	ld a, [wTennisDictCursorRow] ; $521c
	ld c, a ; $521f
	ld a, [wTennisDictScrollTop] ; $5220
	add a, c ; $5223
	cp a, b ; $5224
	jr c, .step ; $5225
	sub a, b ; $5227
.step:
	ld b, a ; $5228
	ld d, a ; $5229
	inc b ; $522a
	xor a, a ; $522b
	ld [wTennisDictCursorRow], a ; $522c
	ld a, [wTennisDictCategoryMask] ; $522f
	ld e, a ; $5232
.loop:
	ld a, [hl+] ; $5233
	and a, e ; $5234
	jr z, .loop ; $5235
	dec b ; $5237
	jr nz, .loop ; $5238
.loopB:
	ld a, [hl+] ; $523a
	cp a, $00 ; $523b
	jr z, .eq00 ; $523d
	ld c, a ; $523f
	and a, e ; $5240
	jr z, .step2 ; $5241
	inc d ; $5243
.step2:
	ld a, c ; $5244
	cp a, $40 ; $5245
	jr nz, .loopB ; $5247
	ld hl, SelectionMaskGrid_3f_539e ; $5249
	ld d, $ff ; $524c
.eq00:
	inc d ; $524e
.loopBB:
	ld a, [hl+] ; $524f
	cp a, $40 ; $5250
	jr nz, .ne40 ; $5252
	ld hl, SelectionMaskGrid_3f_539e ; $5254
	ld d, $00 ; $5257
.ne40:
	and a, e ; $5259
	jr z, .loopBB ; $525a
	ld a, d ; $525c
	ld [wTennisDictScrollTop], a ; $525d
	ret ; $5260
DrawTennisDictionaryList:
	farcall PrepareGlyphBuffer ; $5261
	wram_bank $03 ; $5264
	ld c, $0e ; $526a
	ld hl, TennisDictionaryClearList2 ; $526c
.clearLoop:
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
	call FillBytes_3f ; $527d
	pop hl ; $5280
	pop bc ; $5281
	dec c ; $5282
	jr nz, .clearLoop ; $5283
	wram_bank $06 ; $5285
	ld c, $00 ; $528b
	ld a, [wTennisDictScrollTop] ; $528d
	ld b, a ; $5290
	inc b ; $5291
	ld hl, SelectionMaskGrid_3f_539e ; $5292
	ld a, [wTennisDictCategoryMask] ; $5295
	ld e, a ; $5298
.skipEntry:
	inc c ; $5299
.scanTopLoop:
	ld a, [hl+] ; $529a
	cp a, $00 ; $529b
	jr z, .scanTopLoop ; $529d
	and a, e ; $529f
	jr z, .skipEntry ; $52a0
	dec b ; $52a2
	jr nz, .skipEntry ; $52a3
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
.nextEntry:
	inc c ; $52d5
.scanLoop:
	ld a, [hl+] ; $52d6
	cp a, $00 ; $52d7
	jr z, .scanLoop ; $52d9
	cp a, $40 ; $52db
	jr nz, .checkMask ; $52dd
	ld hl, SelectionMaskGrid_3f_539e ; $52df
	ld c, $00 ; $52e2
	jr .nextEntry ; $52e4
.checkMask:
	and a, e ; $52e6
	jr z, .nextEntry ; $52e7
	dec c ; $52e9
	push hl ; $52ea
	ld hl, $10f0 ; $52eb
	ld a, c ; $52ee
	add a, l ; $52ef
	ld l, a ; $52f0
	jr nc, .haveEntry ; $52f1
	inc h ; $52f3
.haveEntry:
	inc c ; $52f4
	inc b ; $52f5
	push de ; $52f6
	push bc ; $52f7
	ld de, $d0d0 ; $52f8
.rowLoop:
	ld a, $80 ; $52fb
	add a, e ; $52fd
	ld e, a ; $52fe
	jr nc, .nextRow ; $52ff
	inc d ; $5301
.nextRow:
	dec b ; $5302
	jr nz, .rowLoop ; $5303
	pop bc ; $5305
	ld a, [wShadowTilemapBank] ; $5306
	push af ; $5309
	ld a, $03 ; $530a
	ld [wShadowTilemapBank], a ; $530c
	ld a, c ; $530f
	ld c, $0c ; $5310
	farcall RenderProportionalTextAt ; $5312
	ld c, a ; $5315
	pop af ; $5316
	ld [wShadowTilemapBank], a ; $5317
	pop de ; $531a
	pop hl ; $531b
	ld a, b ; $531c
	cp a, $06 ; $531d
	jr nz, .nextEntry ; $531f
	farcall RestoreShadowTilemap ; $5321
	call DrawTennisDictionaryLetterLabels ; $5324
	call QueueTennisDictionaryGlyphTiles ; $5327
	call QueueTennisDictionaryListRows ; $532a
	wram_bank $06 ; $532d
	ret ; $5333
DrawTennisDictionaryLetterLabels:
	call GetTennisDictionarySelectedIndex ; $5334
	ld b, a ; $5337
	inc b ; $5338
	ld a, [wTennisDictCategoryMask] ; $5339
	ld e, a ; $533c
	ld hl, SelectionMaskGrid_3f_539e ; $533d
	ld d, $00 ; $5340
.loop:
	ld a, [hl+] ; $5342
	cp a, $00 ; $5343
	jr nz, .ne00 ; $5345
	inc d ; $5347
	jr .loop ; $5348
.ne00:
	and a, e ; $534a
	jr z, .loop ; $534b
	dec b ; $534d
	jr nz, .loop ; $534e
	wram_bank $03 ; $5350
	ld a, d ; $5356
	dec a ; $5357
	cp a, $ff ; $5358
	jr nz, .neff ; $535a
	ld a, $16 ; $535c
.neff:
	ld hl, $148f ; $535e
	add a, l ; $5361
	ld l, a ; $5362
	jr nc, .step3 ; $5363
	inc h ; $5365
.step3:
	push de ; $5366
	ld c, $40 ; $5367
	ld de, $d050 ; $5369
	farcall RenderTextToBuffer64 ; $536c
	pop de ; $536f
	ld a, d ; $5370
	inc a ; $5371
	cp a, $17 ; $5372
	jr nz, .ne17 ; $5374
	xor a, a ; $5376
.ne17:
	ld hl, $148f ; $5377
	add a, l ; $537a
	ld l, a ; $537b
	jr nc, .renderTextToBuffer64 ; $537c
	inc h ; $537e
.renderTextToBuffer64:
	ld de, $d05e ; $537f
	farcall RenderTextToBuffer64 ; $5382
	ld a, $06 ; $5385
	ld [$d040], a ; $5387
.loopB:
	ld hl, $d050 ; $538a
	ld de, $9830 ; $538d
	ld c, $01 ; $5390
	call QueueVRAMCopy ; $5392
	or a, a ; $5395
	jr nz, .done ; $5396
	call AdvanceFrame ; $5398
	jr .loopB ; $539b
.done:
	ret ; $539d
SelectionMaskGrid_3f_539e:
	INCBIN "data/bank_03f/d_539e.bin" ; $539e, 121 bytes
SetTennisDictionaryListFromIndexRow:
	wram_bank $06 ; $5417
	ld c, $00 ; $541d
	ld hl, SelectionMaskGrid_3f_539e ; $541f
	ld a, [wTennisDictCategoryMask] ; $5422
	ld e, a ; $5425
	ld a, [wTennisDictCursorRow] ; $5426
	call GetTennisDictionaryRowFirstLetter ; $5429
	ld b, a ; $542c
	or a, a ; $542d
	jr z, .clearTennisDictCursorRow ; $542e
.loop:
	ld a, [hl+] ; $5430
	and a, e ; $5431
	jr z, .compare ; $5432
	inc c ; $5434
.compare:
	cp a, $40 ; $5435
	jr z, .clearTennisDictCursorRow ; $5437
	cp a, $00 ; $5439
	jr nz, .loop ; $543b
	dec b ; $543d
	jr nz, .loop ; $543e
	jr .clearTennisDictCursorRow2 ; $5440
.clearTennisDictCursorRow:
	xor a, a ; $5442
	ld [wTennisDictCursorRow], a ; $5443
	ld [wTennisDictScrollTop], a ; $5446
	ret ; $5449
.clearTennisDictCursorRow2:
	xor a, a ; $544a
	ld [wTennisDictCursorRow], a ; $544b
	ld a, c ; $544e
	ld [wTennisDictScrollTop], a ; $544f
	ret ; $5452
GetTennisDictionaryRowFirstLetter:
	push hl ; $5453
	ld hl, Data_3f_545f ; $5454
	add a, l ; $5457
	ld l, a ; $5458
	jr nc, .read ; $5459
	inc h ; $545b
.read:
	ld a, [hl] ; $545c
	pop hl ; $545d
	ret ; $545e
Data_3f_545f:
	; $545f, 9 bytes (bytes:9)
	db $00, $03, $06, $0b, $0c, $0f, $12, $15, $16 ; 0x00
SetTennisDictionaryIndexRowFromList:
	wram_bank $06 ; $5468
	ld a, [wTennisDictCategoryMask] ; $546e
	ld b, a ; $5471
	call GetTennisDictionarySelectedIndex ; $5472
	ld b, a ; $5475
	inc b ; $5476
	ld c, $00 ; $5477
	ld hl, SelectionMaskGrid_3f_539e ; $5479
	ld a, [wTennisDictCategoryMask] ; $547c
	ld e, a ; $547f
.loop:
	ld a, [hl+] ; $5480
	and a, e ; $5481
	jr z, .compare ; $5482
	dec b ; $5484
	jr nz, .loop ; $5485
	jr .getTennisDictionaryLetterRow ; $5487
.compare:
	cp a, $40 ; $5489
	jr z, .clearTennisDictCursorRow ; $548b
	cp a, $00 ; $548d
	jr nz, .loop ; $548f
	inc c ; $5491
	jr .loop ; $5492
.clearTennisDictCursorRow:
	xor a, a ; $5494
	ld [wTennisDictCursorRow], a ; $5495
	ret ; $5498
.getTennisDictionaryLetterRow:
	ld a, c ; $5499
	call GetTennisDictionaryLetterRow ; $549a
	ld [wTennisDictCursorRow], a ; $549d
	ret ; $54a0
GetTennisDictionaryLetterRow:
	push hl ; $54a1
	ld hl, Data_3f_54ad ; $54a2
	add a, l ; $54a5
	ld l, a ; $54a6
	jr nc, .read ; $54a7
	inc h ; $54a9
.read:
	ld a, [hl] ; $54aa
	pop hl ; $54ab
	ret ; $54ac
Data_3f_54ad:
	; $54ad, 27 bytes (bytes:16)
	db $00, $00, $00, $01, $01, $01, $02, $02, $02, $03, $03, $03, $04, $04, $04, $05 ; 0x00
	db $05, $05, $06, $06, $06, $07, $07, $07, $08, $08, $08 ; 0x10
DrawTennisDictionaryIndexCursor:
	or a, a ; $54c8
	jr z, .compactTiles ; $54c9
	ld hl, Data_3f_5540 ; $54cb
	jr .gotTiles ; $54ce
.compactTiles:
	ld hl, Data_3f_5564 ; $54d0
.gotTiles:
	wram_bank $03 ; $54d3
	ld de, $cfb3 ; $54d9
	ld c, b ; $54dc
	inc b ; $54dd
.rowLoop:
	ld a, $80 ; $54de
	add a, e ; $54e0
	ld e, a ; $54e1
	jr nc, .nextRow ; $54e2
	inc d ; $54e4
.nextRow:
	dec b ; $54e5
	jr nz, .rowLoop ; $54e6
	ld a, c ; $54e8
	push af ; $54e9
	add a, a ; $54ea
	add a, a ; $54eb
	add a, l ; $54ec
	ld l, a ; $54ed
	jr nc, .readEntry ; $54ee
	inc h ; $54f0
.readEntry:
	ld a, [hl+] ; $54f1
	ld [de], a ; $54f2
	inc de ; $54f3
	ld a, [hl+] ; $54f4
	ld [de], a ; $54f5
	ld a, $3f ; $54f6
	add a, e ; $54f8
	ld e, a ; $54f9
	jr nc, .secondRow ; $54fa
	inc d ; $54fc
.secondRow:
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
.vramRowLoop:
	ld a, $40 ; $550c
	add a, l ; $550e
	ld l, a ; $550f
	jr nc, .advanceDest ; $5510
	inc h ; $5512
.advanceDest:
	ld a, $20 ; $5513
	add a, e ; $5515
	ld e, a ; $5516
	jr nc, .nextVramRow ; $5517
	inc d ; $5519
.nextVramRow:
	dec b ; $551a
	jr nz, .vramRowLoop ; $551b
	ld c, $01 ; $551d
	push de ; $551f
	push hl ; $5520
	call QueueVRAMCopy ; $5521
	pop hl ; $5524
	pop de ; $5525
	ld a, $40 ; $5526
	add a, l ; $5528
	ld l, a ; $5529
	jr nc, .secondQueueDest ; $552a
	inc h ; $552c
.secondQueueDest:
	ld a, $20 ; $552d
	add a, e ; $552f
	ld e, a ; $5530
	jr nc, .queueSecond ; $5531
	inc d ; $5533
.queueSecond:
	ld c, $01 ; $5534
	call QueueVRAMCopy ; $5536
	wram_bank $06 ; $5539
	ret ; $553f
Data_3f_5540:
	; $5540, 36 bytes (bytes:16)
	db $76, $77, $86, $87, $78, $79, $88, $89, $7a, $7b, $8a, $8b, $7c, $7d, $8c, $8d ; 0x00
	db $7e, $7f, $8e, $8f, $a8, $a9, $b8, $b9, $aa, $ab, $ba, $bb, $ac, $ad, $bc, $bd ; 0x10
	db $ae, $af, $be, $bf ; 0x20
Data_3f_5564:
	; $5564, 36 bytes (bytes:16)
	db $96, $84, $97, $84, $98, $84, $99, $84, $9a, $84, $9b, $84, $9c, $84, $9d, $84 ; 0x00
	db $9e, $84, $9f, $84, $c8, $84, $c9, $84, $ca, $84, $cb, $84, $cc, $84, $cd, $84 ; 0x10
	db $ce, $84, $cf, $84 ; 0x20
HandleTennisDictionaryIndexInput:
	push bc ; $5588
	push af ; $5589
	wram_bank $06 ; $558a
	ldh a, [hInputRisingEdge] ; $5590
	bit PADB_A, a ; $5592
	jr z, .step ; $5594
	pop af ; $5596
	sound $5f ; $5597
	ld a, $04 ; $5599
	push af ; $559b
	jr .restore ; $559c
.step:
	bit 1, a ; $559e
	jr z, .bit1Clear ; $55a0
	pop af ; $55a2
	sound $62 ; $55a3
	ld a, $01 ; $55a5
	push af ; $55a7
	jr .restore ; $55a8
.bit1Clear:
	ldh a, [hInputPressed] ; $55aa
	bit PADB_UP, a ; $55ac
	jr z, .checkTennisDictCursorRow ; $55ae
	ld a, [wTennisDictCursorRow] ; $55b0
	ld b, a ; $55b3
	dec a ; $55b4
	cp a, $ff ; $55b5
	jr z, .restore ; $55b7
	ld [wTennisDictCursorRow], a ; $55b9
	push af ; $55bc
	xor a, a ; $55bd
	call DrawTennisDictionaryIndexCursor ; $55be
	pop af ; $55c1
	sound $5e ; $55c2
	ld a, [wTennisDictCursorRow] ; $55c4
	ld b, a ; $55c7
	ld a, $01 ; $55c8
	call DrawTennisDictionaryIndexCursor ; $55ca
	ld a, $01 ; $55cd
	jr .restore ; $55cf
.checkTennisDictCursorRow:
	bit 7, a ; $55d1
	jr z, .positive ; $55d3
	ld a, [wTennisDictCursorRow] ; $55d5
	ld b, a ; $55d8
	inc a ; $55d9
	cp a, $09 ; $55da
	jr z, .restore ; $55dc
	ld [wTennisDictCursorRow], a ; $55de
	push af ; $55e1
	xor a, a ; $55e2
	call DrawTennisDictionaryIndexCursor ; $55e3
	pop af ; $55e6
	sound $5e ; $55e7
	ld a, [wTennisDictCursorRow] ; $55e9
	ld b, a ; $55ec
	ld a, $01 ; $55ed
	call DrawTennisDictionaryIndexCursor ; $55ef
	ld a, $01 ; $55f2
	jr .restore ; $55f4
.positive:
	bit 5, a ; $55f6
	jr z, .restore ; $55f8
	jr .restore ; $55fa
.restore:
	pop af ; $55fc
	pop bc ; $55fd
	ret ; $55fe
HandleTennisDictionaryListInput:
	push bc ; $55ff
	push af ; $5600
	wram_bank $06 ; $5601
	ld a, [wTennisDictFlags] ; $5607
	res 2, a ; $560a
	res 3, a ; $560c
	ld [wTennisDictFlags], a ; $560e
	ldh a, [hInputRisingEdge] ; $5611
	bit PADB_A, a ; $5613
	jp z, .step3 ; $5615
	sound $5f ; $5618
	call StartTennisDictionaryAnim ; $561a
	ld a, [wTennisDictFlags] ; $561d
	set 0, a ; $5620
	ld [wTennisDictFlags], a ; $5622
	ld a, [wTennisDictCategoryMask] ; $5625
	ld b, a ; $5628
	ld a, [$cb33] ; $5629
	cp a, $01 ; $562c
	jr z, .getTennisDictionarySelectedIndex ; $562e
	call GetTennisDictionarySelectedIndex ; $5630
	call GetTennisDictionaryEntryIndex ; $5633
	ld hl, $1430 ; $5636
	add a, l ; $5639
	ld l, a ; $563a
	jr nc, .getTennisDictionarySelectedIndex2 ; $563b
	inc h ; $563d
.getTennisDictionarySelectedIndex2:
	jr .resetTextWindowsAndRestoreMap ; $563e
.getTennisDictionarySelectedIndex:
	call GetTennisDictionarySelectedIndex ; $5640
	call GetTennisDictionaryEntryCategory ; $5643
	ld hl, $14a9 ; $5646
	add a, l ; $5649
	ld l, a ; $564a
	jr nc, .resetTextWindowsAndRestoreMap ; $564b
	inc h ; $564d
.resetTextWindowsAndRestoreMap:
	push hl ; $564e
	farcall ResetTextWindowsAndRestoreMap ; $564f
	ld a, $05 ; $5652
	ld [wShadowTilemapBank], a ; $5654
	pop hl ; $5657
	ld d, $00 ; $5658
	ld e, $06 ; $565a
	ld b, $14 ; $565c
	ld c, $05 ; $565e
	farcall CreateDialogueWindow ; $5660
	push hl ; $5663
	xor a, a ; $5664
	farcall AddTextIdOffset ; $5665
	ld b, $00 ; $5668
	farcall SetWindowTextId ; $566a
	pop hl ; $566d
	ld a, [wMessageSpeed] ; $566e
	push af ; $5671
	xor a, a ; $5672
	ld a, $80 ; $5673
	ld [wMessageSpeed], a ; $5675
	xor a, a ; $5678
	set_flag FLAG_TEXT_RENDER_ACTIVE ; $5679
	farcall RedrawWindowText ; $567c
	clear_flag FLAG_TEXT_RENDER_ACTIVE ; $567f
	pop af ; $5682
	ld [wMessageSpeed], a ; $5683
	xor a, a ; $5686
	farcall RestoreTilemapUnderWindow ; $5687
	farcall RedrawWindowRowsSafe ; $568a
	farcall CloseWindowAlt ; $568d
	wram_bank $06 ; $5690
	ld a, [wTennisDictFlags] ; $5696
	res 0, a ; $5699
	ld [wTennisDictFlags], a ; $569b
	call EndTennisDictionaryAnim ; $569e
	jp .restore ; $56a1
.step3:
	bit 1, a ; $56a4
	jr z, .bit1Clear ; $56a6
	pop af ; $56a8
	sound $62 ; $56a9
	ld a, [wTennisDictMode] ; $56ab
	cp a, $06 ; $56ae
	jr z, .eq06 ; $56b0
	ld a, $01 ; $56b2
	push af ; $56b4
	jp .restore ; $56b5
.eq06:
	ld a, $10 ; $56b8
	push af ; $56ba
	jp .restore ; $56bb
.bit1Clear:
	ldh a, [hInputPressed] ; $56be
	bit PADB_UP, a ; $56c0
	jr z, .step6 ; $56c2
	sound $5e ; $56c4
	ld a, [wTennisDictCursorRow] ; $56c6
	dec a ; $56c9
	cp a, $ff ; $56ca
	jr z, .checkTennisDictScrollTop ; $56cc
	ld [wTennisDictCursorRow], a ; $56ce
	call DrawTennisDictionaryLetterLabels ; $56d1
	jr .restore ; $56d4
.checkTennisDictScrollTop:
	ld a, [wTennisDictScrollTop] ; $56d6
	dec a ; $56d9
	cp a, $ff ; $56da
	jr nz, .store ; $56dc
	ld a, [wTennisDictEntryCount] ; $56de
	dec a ; $56e1
.store:
	ld [wTennisDictScrollTop], a ; $56e2
	call DrawTennisDictionaryList ; $56e5
	jr .restore ; $56e8
.step6:
	bit 7, a ; $56ea
	jr z, .positive ; $56ec
	sound $5e ; $56ee
	ld a, [wTennisDictCursorRow] ; $56f0
	inc a ; $56f3
	cp a, $06 ; $56f4
	jr nc, .checkTennisDictEntryCount ; $56f6
	ld [wTennisDictCursorRow], a ; $56f8
	call DrawTennisDictionaryLetterLabels ; $56fb
	jr .restore ; $56fe
.checkTennisDictEntryCount:
	ld a, [wTennisDictEntryCount] ; $5700
	ld b, a ; $5703
	ld a, [wTennisDictScrollTop] ; $5704
	inc a ; $5707
	cp a, b ; $5708
	jr nz, .store2 ; $5709
	xor a, a ; $570b
.store2:
	ld [wTennisDictScrollTop], a ; $570c
	call DrawTennisDictionaryList ; $570f
	jr .restore ; $5712
.positive:
	bit 5, a ; $5714
	jr z, .bit5Clear ; $5716
	ld a, [wTennisDictFlags] ; $5718
	set 2, a ; $571b
	ld [wTennisDictFlags], a ; $571d
	sound $5e ; $5720
	call AdvanceFrame ; $5722
	call ScrollTennisDictionaryToPrevLetter ; $5725
	call DrawTennisDictionaryList ; $5728
	jr .restore ; $572b
.bit5Clear:
	bit 4, a ; $572d
	jr z, .restore ; $572f
	ld a, [wTennisDictFlags] ; $5731
	set 3, a ; $5734
	ld [wTennisDictFlags], a ; $5736
	sound $5e ; $5739
	call AdvanceFrame ; $573b
	call ScrollTennisDictionaryToNextLetter ; $573e
	call DrawTennisDictionaryList ; $5741
	jr .restore ; $5744
.restore:
	pop af ; $5746
	pop bc ; $5747
	ret ; $5748
QueueTennisDictionaryGlyphTiles:
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
	jr z, .restore ; $5762
	call AdvanceFrame ; $5764
.restore:
	pop af ; $5767
	ld hl, $d7e0 ; $5768
	ld de, $8ce0 ; $576b
	ld c, $18 ; $576e
	call QueueVRAMCopy ; $5770
	push af ; $5773
	ldh a, [rLCDC] ; $5774
	bit 7, a ; $5776
	jr z, .restore2 ; $5778
	call AdvanceFrame ; $577a
.restore2:
	pop af ; $577d
	ld hl, $d960 ; $577e
	ld de, $8e60 ; $5781
	ld c, $18 ; $5784
	call QueueVRAMCopy ; $5786
	pop af ; $5789
	wram_bank ; $578a
	ret ; $578e
QueueTennisDictionaryListRows:
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
	jr z, .restore ; $57df
	call AdvanceFrame ; $57e1
.restore:
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
	; $7c49, 951 bytes fill to bank end (linker-padded)
