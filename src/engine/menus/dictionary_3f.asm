TennisDictionaryScreen:
	push af ; $407a
	wram_bank WRAM_SCENE ; $407b
	pop af ; $4081
	ld [wTennisDictMode], a ; $4082
	cp $00 ; $4085
	jr z, .eq00 ; $4087
	cp $01 ; $4089
	jr z, .eq01 ; $408b
	cp $02 ; $408d
	jr z, .eq02 ; $408f
	cp $03 ; $4091
	jr z, .eq03 ; $4093
	cp $04 ; $4095
	jr z, .eq04 ; $4097
	cp $05 ; $4099
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
	ld [wTennisDictSingleEntry], a ; $40b7
	ld a, $1f ; $40ba
	jr .store ; $40bc
.store:
	ld [wTennisDictCategoryMask], a ; $40be
	xor a ; $40c1
	ld [wTennisDictSpritePhase], a ; $40c2
	ld [wTennisDictFlags], a ; $40c5
	ld [wTennisDictScrollTop], a ; $40c8
	ld [wTennisDictCursorRow], a ; $40cb
	ld [wTennisDictScrollTimer], a ; $40ce
	ld a, $08 ; $40d1
	ld [wTennisDictSpriteTimer], a ; $40d3
	ld a, $00 ; $40d6
	ld [wTennisDictAnimState], a ; $40d8
	ld a, $b4 ; $40db
	ld [wTennisDictAnimTimer], a ; $40dd
	call LoadTennisDictionaryScreen ; $40e0
	wram_bank WRAM_SCENE ; $40e3
	xor a ; $40e9
	ld [wTennisDictSingleEntry], a ; $40ea
	ld a, [wTennisDictMode] ; $40ed
	cp $06 ; $40f0
	jr z, .disableLCDSafely ; $40f2
	call AdvanceFrame ; $40f4
	call DrawTennisDictionaryList ; $40f7
	ld a, [wTennisDictMode] ; $40fa
	cp $05 ; $40fd
	jr nz, .disableLCDSafely ; $40ff
	ld a, $01 ; $4101
	ld [wTennisDictSingleEntry], a ; $4103
.disableLCDSafely:
	call DisableLCDSafely ; $4106
	farcall LoadMenuTilesA ; $4109
	call EnableLCD ; $410c
	sound BGM_DICTIONARY ; $410f
	call AdvanceFrame ; $4111
	script_fade_in $10 ; $4114
	call WaitFadeEnd ; $4119
	ld a, $1d ; $411c
	ld hl, UpdateTennisDictionarySprites ; $411e
	call RegisterFrameTask ; $4121
	wram_bank WRAM_SCENE ; $4124
	ld a, [wTennisDictMode] ; $412a
	cp $06 ; $412d
	jr nz, .checkTennisDictFlags ; $412f
	wram_bank WRAM_SCENE ; $4131
	ld a, [wTennisDictFlags] ; $4137
	res 0, a ; $413a
	ld [wTennisDictFlags], a ; $413c
	call EndTennisDictionaryAnim ; $413f
	wait_frames $01 ; $4142
	ld a, $02 ; $4146
	jr .loop ; $4148
.checkTennisDictFlags:
	ld a, [wTennisDictFlags] ; $414a
	set 1, a ; $414d
	ld [wTennisDictFlags], a ; $414f
	ld a, $08 ; $4152
.loop:
	call AdvanceFrame ; $4154
	cp $04 ; $4157
	jp z, .showTennisDictionaryPageDefault ; $4159
	cp $10 ; $415c
	jp z, .showTennisDictionaryPageChar6 ; $415e
	cp $08 ; $4161
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
	cp $01 ; $417b
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
	xor a ; $41a1
	ld [wCameraX], a ; $41a2
	wram_bank WRAM_SCENE ; $41a5
	ld a, [wTennisDictCursorRow] ; $41ab
	ld b, a ; $41ae
	xor a ; $41af
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
	xor a ; $41ed
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
	wram_bank WRAM_SCENE ; $4211
	ld a, [wTennisDictFlags] ; $4217
	res 1, a ; $421a
	ld [wTennisDictFlags], a ; $421c
	script_fade_in $10 ; $421f
	call WaitFadeEnd ; $4224
	ld a, $02 ; $4227
	ret ; $4229
	add hl, de ; $422a
	ld a, h ; $422b
	cp b ; $422c
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
	xor a ; $4242
	ret ; $4243
ResetTennisDictionaryScroll:
	wram_bank WRAM_SCENE ; $4244
	xor a ; $424a
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
	wram_bank WRAM_STAGING ; $425f
	ld_slot hl, DataPtr_TennisDictionaryListTiles ; $4265
	ld de, wDecompBuffer ; $4268
	call DecompressDataFromBank ; $426b
	ld hl, wDecompBuffer ; $426e
	ld de, vTiles2 + VRAM_BANK1 ; $4271
	ld c, $80 ; $4274
	call QueueVRAMCopy ; $4276
	ld hl, wTextTileBuffer ; $4279
	ld de, vTiles1 + VRAM_BANK1 ; $427c
	ld c, wTextTileBuffer_SIZE / 16 ; $427f
	call QueueVRAMCopy ; $4281
	ld hl, TennisDictionaryPalettesDefault ; $4284
	ld_bg_pals de, 0, 8 ; $4287
	call LoadPalettesMasterOnly ; $428a
	wram_bank WRAM_COURT_PLANES ; $428d
	ld hl, TennisDictionaryListDataDefault ; $4293
	ld de, wScreenAttrmap ; $4296
	call DecompressData ; $4299
	call ClearTennisDictionaryTilemap ; $429c
	ret ; $429f
LoadTennisDictionaryAssetsChar6:
	wram_bank WRAM_STAGING ; $42a0
	ld_slot hl, DataPtr_TennisDictionaryTiles ; $42a6
	ld de, wDecompBuffer ; $42a9
	call DecompressDataFromBank ; $42ac
	ld hl, wDecompBuffer ; $42af
	ld de, vTiles2 + VRAM_BANK1 ; $42b2
	ld c, $80 ; $42b5
	call QueueVRAMCopy ; $42b7
	ld hl, wTextTileBuffer ; $42ba
	ld de, vTiles1 + VRAM_BANK1 ; $42bd
	ld c, wTextTileBuffer_SIZE / 16 ; $42c0
	call QueueVRAMCopy ; $42c2
	ld hl, TennisDictionaryPalettesChar6 ; $42c5
	ld_bg_pals de, 0, 8 ; $42c8
	call LoadPalettesMasterOnly ; $42cb
	wram_bank WRAM_COURT_PLANES ; $42ce
	ld hl, TennisDictionaryListDataChar6 ; $42d4
	ld de, wScreenAttrmap ; $42d7
	call DecompressData ; $42da
	ret ; $42dd
ClearTennisDictionaryTilemap:
	wram_bank WRAM_COURT_PLANES ; $42de
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
	wram_bank WRAM_SCENE ; $42fe
	ld a, [wTennisDictMode] ; $4304
	cp $06 ; $4307
	jr nz, .ne06 ; $4309
	ld a, $21 ; $430b
	jr .store ; $430d
.ne06:
	ld a, $0d ; $430f
.store:
	ldh [hScrollX], a ; $4311
	ld [wCameraX + 1], a ; $4313
	xor a ; $4316
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
	wram_bank WRAM_STAGING ; $4331
	ld hl, TennisDictionaryTiles8000 ; $4337
	ld de, wDecompBuffer ; $433a
	call DecompressData ; $433d
	ld hl, wDecompBuffer ; $4340
	ld de, vTiles0 ; $4343
	ld c, TennisDictionaryTiles8000_SIZE / 16 ; $4346
	call QueueVRAMCopy ; $4348
	ld hl, TennisDictionaryTiles8200 ; $434b
	ld de, wDecompBuffer ; $434e
	call DecompressData ; $4351
	ld hl, wDecompBuffer ; $4354
	ld de, vTiles0 + $20 * TILE_SIZE ; $4357
	ld c, TennisDictionaryTiles8200_SIZE / 16 ; $435a
	call QueueVRAMCopy ; $435c
	ld hl, TennisDictionaryTiles8400 ; $435f
	ld de, wDecompBuffer ; $4362
	call DecompressData ; $4365
	ld hl, wDecompBuffer ; $4368
	ld de, vTiles0 + $40 * TILE_SIZE ; $436b
	ld c, TennisDictionaryTiles8400_SIZE / 16 ; $436e
	call QueueVRAMCopy ; $4370
	ld hl, TennisDictionaryTilesA000 ; $4373
	ld de, wDecompBuffer ; $4376
	call DecompressData ; $4379
	ld hl, wDecompBuffer ; $437c
	ld de, vTiles0 + VRAM_BANK1 ; $437f
	ld c, TennisDictionaryTilesA000_SIZE / 16 ; $4382
	call QueueVRAMCopy ; $4384
	ld hl, TennisDictionaryTilesA200 ; $4387
	ld de, wDecompBuffer ; $438a
	call DecompressData ; $438d
	ld hl, wDecompBuffer ; $4390
	ld de, vTiles0 + $20 * TILE_SIZE + VRAM_BANK1 ; $4393
	ld c, TennisDictionaryTilesA200_SIZE / 16 ; $4396
	call QueueVRAMCopy ; $4398
	ld hl, TennisDictionaryTilesA400 ; $439b
	ld de, wDecompBuffer ; $439e
	call DecompressData ; $43a1
	ld hl, wDecompBuffer ; $43a4
	ld de, vTiles0 + $40 * TILE_SIZE + VRAM_BANK1 ; $43a7
	ld c, TennisDictionaryTilesA400_SIZE / 16 ; $43aa
	call QueueVRAMCopy ; $43ac
	ld hl, TennisDictionaryPalettes ; $43af
	ld_obj_pals de, 0, 8 ; $43b2
	call LoadPalettesMasterOnly ; $43b5
	wram_bank WRAM_SCENE ; $43b8
	ld a, [wTennisDictMode] ; $43be
	cp $06 ; $43c1
	jr nz, .loadTennisDictionaryAssetsDefault ; $43c3
	call LoadTennisDictionaryAssetsChar6 ; $43c5
	jr .decompressData ; $43c8
.loadTennisDictionaryAssetsDefault:
	call LoadTennisDictionaryAssetsDefault ; $43ca
.decompressData:
	wram_bank WRAM_SCREEN ; $43cd
	ld hl, TennisDictionaryListData ; $43d3
	ld de, wShadowTilemap ; $43d6
	call DecompressData ; $43d9
	wram_bank WRAM_SCREEN ; $43dc
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
	wram_bank WRAM_SCENE ; $43fd
	ld a, [wTennisDictMode] ; $4403
	ld c, a ; $4406
	wram_bank WRAM_SCREEN ; $4407
	inc c ; $440d
	ld b, $20 ; $440e
	xor a ; $4410
.loopB:
	add b ; $4411
	dec c ; $4412
	jr nz, .loopB ; $4413
	ld c, $0b ; $4415
	ld hl, wShadowTilemap + 2 * TILEMAP_WIDTH + 18 ; $4417
.loop2:
	ld [hl+], a ; $441a
	inc a ; $441b
	dec c ; $441c
	jr nz, .loop2 ; $441d
	add $05 ; $441f
	ld c, $0b ; $4421
	ld hl, wShadowTilemap + 4 * TILEMAP_WIDTH + 18 ; $4423
.loop3:
	ld [hl+], a ; $4426
	inc a ; $4427
	dec c ; $4428
	jr nz, .loop3 ; $4429
	wram_bank WRAM_SCENE ; $442b
	call EnableLCD ; $4431
	wram_bank WRAM_SCENE ; $4434
	farcall UpdateSceneScroll ; $443a
	call DisableLCDSafely ; $443d
	wram_bank WRAM_SCREEN ; $4440
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
	INCBIN "data/bank_03f/lz_TennisDictionaryListDataChar6.bin" ; $44bf, 130 bytes
TennisDictionaryListDataDefault:
	INCBIN "data/bank_03f/lz_TennisDictionaryListDataDefault.bin" ; $4541, 91 bytes
TennisDictionaryListData:
	INCBIN "data/bank_03f/lz_TennisDictionaryListData.bin" ; $459c, 367 bytes
TennisDictionaryListDataAlt:
	INCBIN "data/bank_03f/lz_TennisDictionaryListDataAlt.bin" ; $470b, 163 bytes
TennisDictionaryPalettesChar6:
	INCLUDE "data/bank_03f/TennisDictionaryPalettesChar6.asm" ; $47ae, 72 bytes (palettes)
TennisDictionaryPalettesDefault:
	INCLUDE "data/bank_03f/TennisDictionaryPalettesDefault.asm" ; $47f6, 72 bytes (palettes)
TennisDictionaryTiles8000:
	INCBIN "data/bank_03f/lz_TennisDictionaryTiles8000.bin" ; $483e, 287 bytes
	INCLUDE "data/bank_03f/lz_TennisDictionaryTiles8000.inc" ; DEF TennisDictionaryTiles8000_SIZE EQU its decoded length, generated from the .bin by make
TennisDictionaryTiles8200:
	INCBIN "data/bank_03f/lz_TennisDictionaryTiles8200.bin" ; $495d, 322 bytes
	INCLUDE "data/bank_03f/lz_TennisDictionaryTiles8200.inc" ; DEF TennisDictionaryTiles8200_SIZE EQU its decoded length, generated from the .bin by make
TennisDictionaryTiles8400:
	INCBIN "data/bank_03f/lz_TennisDictionaryTiles8400.bin" ; $4a9f, 310 bytes
	INCLUDE "data/bank_03f/lz_TennisDictionaryTiles8400.inc" ; DEF TennisDictionaryTiles8400_SIZE EQU its decoded length, generated from the .bin by make
TennisDictionaryTilesA000:
	INCBIN "data/bank_03f/lz_TennisDictionaryTilesA000.bin" ; $4bd5, 180 bytes
	INCLUDE "data/bank_03f/lz_TennisDictionaryTilesA000.inc" ; DEF TennisDictionaryTilesA000_SIZE EQU its decoded length, generated from the .bin by make
TennisDictionaryTilesA200:
	INCBIN "data/bank_03f/lz_TennisDictionaryTilesA200.bin" ; $4c89, 258 bytes
	INCLUDE "data/bank_03f/lz_TennisDictionaryTilesA200.inc" ; DEF TennisDictionaryTilesA200_SIZE EQU its decoded length, generated from the .bin by make
TennisDictionaryTilesA400:
	INCBIN "data/bank_03f/lz_TennisDictionaryTilesA400.bin" ; $4d8b, 174 bytes
	INCLUDE "data/bank_03f/lz_TennisDictionaryTilesA400.inc" ; DEF TennisDictionaryTilesA400_SIZE EQU its decoded length, generated from the .bin by make
TennisDictionaryPalettes:
	INCLUDE "data/bank_03f/TennisDictionaryPalettes.asm" ; $4e39, 48 bytes (palettes)
EndTennisDictionaryAnim:
	ld a, [wTennisDictAnimState] ; $4e69
	cp $03 ; $4e6c
	jr nc, .done ; $4e6e
	ld a, $04 ; $4e70
	ld [wTennisDictAnimState], a ; $4e72
	ld a, $ff ; $4e75
	ld [wTennisDictAnimTimer], a ; $4e77
.done:
	ret ; $4e7a
StartTennisDictionaryAnim:
	ld a, $b4 ; $4e7b
	ld [wTennisDictAnimTimer], a ; $4e7d
	ldh a, [hVBlankCounter] ; $4e80
	and $03 ; $4e82
	cp $03 ; $4e84
	jr nz, .store ; $4e86
	xor a ; $4e88
.store:
	ld [wTennisDictAnimState], a ; $4e89
	ret ; $4e8c
UpdateTennisDictionarySprites:
	ldh a, [hWramBank] ; $4e8d
	push af ; $4e8f
	push af ; $4e90
	push bc ; $4e91
	push de ; $4e92
	push hl ; $4e93
	wram_bank WRAM_SCENE ; $4e94
	test_flag FLAG_TEXT_WAITING_FOR_BUTTON ; $4e9a
	jr z, .notTextWaitingForButton ; $4e9d
	sound SFX_MENU_SELECT ; $4e9f
	call StartTennisDictionaryAnim ; $4ea1
.notTextWaitingForButton:
	ld a, [wTennisDictAnimState] ; $4ea4
	cp $04 ; $4ea7
	jr nz, .compare ; $4ea9
	ld a, [wTennisDictAnimTimer] ; $4eab
	dec a ; $4eae
	ld [wTennisDictAnimTimer], a ; $4eaf
	jr nz, .checkTennisDictMode ; $4eb2
	ld a, $03 ; $4eb4
	ld [wTennisDictAnimState], a ; $4eb6
	jr .checkTennisDictMode ; $4eb9
.compare:
	cp $03 ; $4ebb
	jr nz, .ne03 ; $4ebd
	jr .checkTennisDictMode ; $4ebf
.ne03:
	ld a, [wTennisDictAnimTimer] ; $4ec1
	dec a ; $4ec4
	ld [wTennisDictAnimTimer], a ; $4ec5
	jr nz, .checkTennisDictMode ; $4ec8
	ld a, $04 ; $4eca
	ld [wTennisDictAnimState], a ; $4ecc
	ld a, $ff ; $4ecf
	ld [wTennisDictAnimTimer], a ; $4ed1
.checkTennisDictMode:
	ld a, [wTennisDictMode] ; $4ed4
	cp $06 ; $4ed7
	jp nz, .checkTennisDictFlags ; $4ed9
	ld a, [wTennisDictSpriteTimer] ; $4edc
	dec a ; $4edf
	ld [wTennisDictSpriteTimer], a ; $4ee0
	jr nz, .countLeft ; $4ee3
	ld a, $08 ; $4ee5
	ld [wTennisDictSpriteTimer], a ; $4ee7
	ld a, [wTennisDictSpritePhase] ; $4eea
	inc a ; $4eed
	cp $10 ; $4eee
	jr nz, .store ; $4ef0
	xor a ; $4ef2
.store:
	ld [wTennisDictSpritePhase], a ; $4ef3
.countLeft:
	ld hl, TennisDictionarySprites1 ; $4ef6
	ld a, [wTennisDictAnimState] ; $4ef9
	add a ; $4efc
	add a ; $4efd
	add a ; $4efe
	add a ; $4eff
	add l ; $4f00
	ld l, a ; $4f01
	jr nc, .gotPtr ; $4f02
	inc h ; $4f04
.gotPtr:
	ld a, [wTennisDictSpritePhase] ; $4f05
	add l ; $4f08
	ld l, a ; $4f09
	jr nc, .read ; $4f0a
	inc h ; $4f0c
.read:
	ld a, [hl] ; $4f0d
	add a ; $4f0e
	add a ; $4f0f
	add a ; $4f10
	push af ; $4f11
	pop af ; $4f12
	ld hl, TennisDictionarySprites2 ; $4f13
	add l ; $4f16
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
	ld_xy de, $90, $7d ; $4f26
	jr .queueSpriteTemplate ; $4f29
.bit1Clear:
	ld_xy de, $80, $7d ; $4f2b
.queueSpriteTemplate:
	push hl ; $4f2e
	ld hl, UpdateTennisDictionarySprites_SpriteTemplate2 ; $4f2f
	call QueueSpriteTemplate ; $4f32
	pop hl ; $4f35
	ld a, [hl+] ; $4f36
	ld c, a ; $4f37
	ld a, [hl+] ; $4f38
	ld b, a ; $4f39
	ld a, [wTennisDictFlags] ; $4f3a
	bit 1, a ; $4f3d
	jr z, .bit1Clear2 ; $4f3f
	ld_xy de, $88, $6d ; $4f41
	jr .queueSpriteTemplate2 ; $4f44
.bit1Clear2:
	ld_xy de, $78, $6d ; $4f46
.queueSpriteTemplate2:
	push hl ; $4f49
	ld hl, UpdateTennisDictionarySprites_SpriteTemplate3 ; $4f4a
	call QueueSpriteTemplate ; $4f4d
	pop hl ; $4f50
	ld a, [hl+] ; $4f51
	ld c, a ; $4f52
	ld a, [hl+] ; $4f53
	ld b, a ; $4f54
	ld a, [wTennisDictFlags] ; $4f55
	bit 1, a ; $4f58
	jr z, .bit1Clear3 ; $4f5a
	ld_xy de, $88, $7d ; $4f5c
	jr .queueSpriteTemplate3 ; $4f5f
.bit1Clear3:
	ld_xy de, $78, $7d ; $4f61
.queueSpriteTemplate3:
	push hl ; $4f64
	ld hl, UpdateTennisDictionarySprites_SpriteTemplate3 ; $4f65
	call QueueSpriteTemplate ; $4f68
	pop hl ; $4f6b
	ld a, [hl+] ; $4f6c
	ld c, a ; $4f6d
	ld a, [hl+] ; $4f6e
	ld b, a ; $4f6f
	ld a, [wTennisDictFlags] ; $4f70
	bit 1, a ; $4f73
	jr z, .bit1Clear4 ; $4f75
	ld_xy de, $88, $8d ; $4f77
	jr .queueSpriteTemplate4 ; $4f7a
.bit1Clear4:
	ld_xy de, $78, $8d ; $4f7c
.queueSpriteTemplate4:
	ld hl, UpdateTennisDictionarySprites_SpriteTemplate3 ; $4f7f
	call QueueSpriteTemplate ; $4f82
.checkTennisDictFlags:
	ld a, [wTennisDictFlags] ; $4f85
	bit 1, a ; $4f88
	jr z, .restore ; $4f8a
	ld a, [wTennisDictFlags] ; $4f8c
	bit 0, a ; $4f8f
	jr nz, .checkTennisDictCursorRow ; $4f91
	ld a, [wTennisDictScrollTimer] ; $4f93
	inc a ; $4f96
	ld [wTennisDictScrollTimer], a ; $4f97
.checkTennisDictCursorRow:
	ld a, [wTennisDictCursorRow] ; $4f9a
	ld b, a ; $4f9d
	inc b ; $4f9e
	ld a, $14 ; $4f9f
	ld e, $10 ; $4fa1
	sub e ; $4fa3
.loop:
	add e ; $4fa4
	dec b ; $4fa5
	jr nz, .loop ; $4fa6
	add e ; $4fa8
	add $14 ; $4fa9
	ld e, a ; $4fab
	ld hl, TennisDictionarySprites0 ; $4fac
	ld a, [wTennisDictScrollTimer] ; $4faf
	and $0f ; $4fb2
	add l ; $4fb4
	ld l, a ; $4fb5
	jr nc, .read2 ; $4fb6
	inc h ; $4fb8
.read2:
	ld a, [hl] ; $4fb9
	add $0a ; $4fba
	ld d, a ; $4fbc
	ld hl, UpdateTennisDictionarySprites_SpriteTemplate1 ; $4fbd
	ld_oam bc, OAM_BANK1 | 3, $28 ; $4fc0
	call QueueSpriteTemplate ; $4fc3
	ld a, [wTennisDictFlags] ; $4fc6
	bit 2, a ; $4fc9
	jr z, .checkTennisDictFlags2 ; $4fcb
	ld hl, UpdateTennisDictionarySprites_SpriteTemplate0 ; $4fcd
	ld_xy de, $18, $10 ; $4fd0
	ld_oam bc, OAM_BANK1 | 5, $34 ; $4fd3
	call QueueSpriteTemplate ; $4fd6
.checkTennisDictFlags2:
	ld a, [wTennisDictFlags] ; $4fd9
	bit 3, a ; $4fdc
	jr z, .restore ; $4fde
	ld hl, UpdateTennisDictionarySprites_SpriteTemplate0 ; $4fe0
	ld_xy de, $88, $10 ; $4fe3
	ld_oam bc, OAM_BANK1 | 5, $3a ; $4fe6
	call QueueSpriteTemplate ; $4fe9
.restore:
	pop hl ; $4fec
	pop de ; $4fed
	pop bc ; $4fee
	pop af ; $4fef
	pop_wram_bank ; $4ff0
	ret ; $4ff5
TennisDictionarySprites0:
	; $4ff6, 16 bytes (bytes:16)
	db $00, $01, $01, $02, $03, $04, $06, $08, $06, $04, $03, $02, $01, $01, $00, $00 ; 0x00
UpdateTennisDictionarySprites_SpriteTemplate0:
	; $5006, 25 bytes (sprite_template)
	oam_sprite $00, $00, $00, $00
	oam_sprite $10, $00, $20, $00
	oam_sprite $00, $08, $02, $00
	oam_sprite $10, $08, $22, $00
	oam_sprite $00, $10, $04, $00
	oam_sprite $10, $10, $24, $00
	oam_sprite_end
UpdateTennisDictionarySprites_SpriteTemplate1:
	; $501f, 9 bytes (sprite_template)
	oam_sprite $00, $00, $00, $00
	oam_sprite $00, $08, $02, $00
	oam_sprite_end
TennisDictionarySprites1:
	INCBIN "data/bank_03f/TennisDictionarySprites1.bin" ; $5028, 80 bytes
TennisDictionarySprites2:
	INCBIN "data/bank_03f/TennisDictionarySprites2.bin" ; $5078, 88 bytes
UpdateTennisDictionarySprites_SpriteTemplate2:
	; $50d0, 9 bytes (sprite_template)
	oam_sprite $00, $00, $00, $00
	oam_sprite $00, $08, $02, $00
	oam_sprite_end
UpdateTennisDictionarySprites_SpriteTemplate3:
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
	wram_bank WRAM_SCENE ; $50f7
	ld hl, SelectionMaskGrid_3f ; $50fd
	ld c, $00 ; $5100
	ld a, [wTennisDictCategoryMask] ; $5102
	ld d, a ; $5105
.loop:
	ld a, [hl+] ; $5106
	cp $00 ; $5107
	jr z, .loop ; $5109
	cp $40 ; $510b
	jr z, .eq40 ; $510d
	and d ; $510f
	jr z, .loop ; $5110
	inc c ; $5112
	jr .loop ; $5113
.eq40:
	ld a, c ; $5115
	ld [wTennisDictEntryCount], a ; $5116
	ret ; $5119
FindTennisDictionaryListEnd:
	wram_bank WRAM_SCENE ; $511a
	ld hl, SelectionMaskGrid_3f ; $5120
	ld c, $00 ; $5123
.loop:
	ld a, [hl+] ; $5125
	cp $40 ; $5126
	jr nz, .loop ; $5128
	dec hl ; $512a
	ld a, h ; $512b
	ld [wTennisDictListEnd], a ; $512c
	ld a, l ; $512f
	ld [wTennisDictListEnd + 1], a ; $5130
	ret ; $5133
GetTennisDictionaryEntryIndex:
	ld d, $00 ; $5134
	ld c, a ; $5136
	inc c ; $5137
	ld hl, SelectionMaskGrid_3f ; $5138
.loop:
	ld a, [hl+] ; $513b
	cp $00 ; $513c
	jr z, .loop ; $513e
	inc d ; $5140
	and b ; $5141
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
	ld hl, SelectionMaskGrid_3f ; $514e
.loop:
	ld a, [hl+] ; $5151
	cp $00 ; $5152
	jr z, .loop ; $5154
	inc d ; $5156
	and b ; $5157
	jr z, .loop ; $5158
	dec c ; $515a
	jr nz, .loop ; $515b
	cp $01 ; $515d
	jr z, .eq01 ; $515f
	cp $02 ; $5161
	jr z, .eq02 ; $5163
	cp $04 ; $5165
	jr z, .eq04 ; $5167
	cp $08 ; $5169
	jr z, .eq08 ; $516b
	ld a, $04 ; $516d
	ret ; $516f
.eq01:
	xor a ; $5170
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
	wram_bank WRAM_SCENE ; $517b
	ld a, [wTennisDictEntryCount] ; $5181
	ld d, a ; $5184
	ld a, [wTennisDictCursorRow] ; $5185
	ld c, a ; $5188
	ld a, [wTennisDictScrollTop] ; $5189
	add c ; $518c
	cp d ; $518d
	jr c, .done ; $518e
	sub d ; $5190
.done:
	ret ; $5191
ScrollTennisDictionaryToPrevLetter:
	wram_bank WRAM_SCENE ; $5192
	ld hl, SelectionMaskGrid_3f ; $5198
	call GetTennisDictionarySelectedIndex ; $519b
	ld b, a ; $519e
	ld c, a ; $519f
	inc b ; $51a0
	xor a ; $51a1
	ld [wTennisDictCursorRow], a ; $51a2
	ld a, [wTennisDictCategoryMask] ; $51a5
	ld e, a ; $51a8
	jr WrapTennisDictionaryScanToEnd.loop ; $51a9
WrapTennisDictionaryScanToEnd:
	push af ; $51ab
	ld a, [wTennisDictEntryCount] ; $51ac
	dec a ; $51af
	ld c, a ; $51b0
	ld a, [wTennisDictListEnd] ; $51b1
	ld h, a ; $51b4
	ld a, [wTennisDictListEnd + 1] ; $51b5
	ld l, a ; $51b8
	dec hl ; $51b9
	pop af ; $51ba
	ret ; $51bb
.loop:
	ld a, [hl+] ; $51bc
	and e ; $51bd
	jr z, .loop ; $51be
	dec b ; $51c0
	jr nz, .loop ; $51c1
	dec hl ; $51c3
.loopB:
	ld a, [hl-] ; $51c4
	ld d, a ; $51c5
	and e ; $51c6
	jr z, .countDone ; $51c7
	dec c ; $51c9
.countDone:
	ld a, d ; $51ca
	cp $40 ; $51cb
	jr z, .wrapTennisDictionaryScanToEnd ; $51cd
	cp $00 ; $51cf
	jr nz, .loopB ; $51d1
	jr .loop2 ; $51d3
.wrapTennisDictionaryScanToEnd:
	call WrapTennisDictionaryScanToEnd ; $51d5
.loop2:
	ld a, [hl-] ; $51d8
	cp $40 ; $51d9
	jr nz, .ne40 ; $51db
	call WrapTennisDictionaryScanToEnd ; $51dd
.ne40:
	and e ; $51e0
	jr z, .loop2 ; $51e1
	dec c ; $51e3
.loop3:
	ld a, [hl-] ; $51e4
	ld d, a ; $51e5
	and e ; $51e6
	jr z, .countDone2 ; $51e7
	dec c ; $51e9
.countDone2:
	ld a, d ; $51ea
	cp $40 ; $51eb
	jr z, .wrapTennisDictionaryScanToEnd2 ; $51ed
	cp $00 ; $51ef
	jr nz, .loop3 ; $51f1
	inc hl ; $51f3
	inc c ; $51f4
	jr .loop4 ; $51f5
.wrapTennisDictionaryScanToEnd2:
	call WrapTennisDictionaryScanToEnd ; $51f7
	inc hl ; $51fa
.loop4:
	ld a, [hl+] ; $51fb
	cp $40 ; $51fc
	jr nz, .ne402 ; $51fe
	ld c, $00 ; $5200
	ld hl, SelectionMaskGrid_3f ; $5202
	jr .loop4 ; $5205
.ne402:
	and e ; $5207
	jr z, .loop4 ; $5208
	ld a, c ; $520a
	ld [wTennisDictScrollTop], a ; $520b
	ret ; $520e
ScrollTennisDictionaryToNextLetter:
	wram_bank WRAM_SCENE ; $520f
	ld hl, SelectionMaskGrid_3f ; $5215
	ld a, [wTennisDictEntryCount] ; $5218
	ld b, a ; $521b
	ld a, [wTennisDictCursorRow] ; $521c
	ld c, a ; $521f
	ld a, [wTennisDictScrollTop] ; $5220
	add c ; $5223
	cp b ; $5224
	jr c, .carry ; $5225
	sub b ; $5227
.carry:
	ld b, a ; $5228
	ld d, a ; $5229
	inc b ; $522a
	xor a ; $522b
	ld [wTennisDictCursorRow], a ; $522c
	ld a, [wTennisDictCategoryMask] ; $522f
	ld e, a ; $5232
.loop:
	ld a, [hl+] ; $5233
	and e ; $5234
	jr z, .loop ; $5235
	dec b ; $5237
	jr nz, .loop ; $5238
.loopB:
	ld a, [hl+] ; $523a
	cp $00 ; $523b
	jr z, .eq00 ; $523d
	ld c, a ; $523f
	and e ; $5240
	jr z, .eq002 ; $5241
	inc d ; $5243
.eq002:
	ld a, c ; $5244
	cp $40 ; $5245
	jr nz, .loopB ; $5247
	ld hl, SelectionMaskGrid_3f ; $5249
	ld d, $ff ; $524c
.eq00:
	inc d ; $524e
.loop2:
	ld a, [hl+] ; $524f
	cp $40 ; $5250
	jr nz, .ne40 ; $5252
	ld hl, SelectionMaskGrid_3f ; $5254
	ld d, $00 ; $5257
.ne40:
	and e ; $5259
	jr z, .loop2 ; $525a
	ld a, d ; $525c
	ld [wTennisDictScrollTop], a ; $525d
	ret ; $5260
DrawTennisDictionaryList:
	farcall PrepareGlyphBuffer ; $5261
	wram_bank WRAM_SCREEN ; $5264
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
	wram_bank WRAM_SCENE ; $5285
	ld c, $00 ; $528b
	ld a, [wTennisDictScrollTop] ; $528d
	ld b, a ; $5290
	inc b ; $5291
	ld hl, SelectionMaskGrid_3f ; $5292
	ld a, [wTennisDictCategoryMask] ; $5295
	ld e, a ; $5298
.skipEntry:
	inc c ; $5299
.scanTopLoop:
	ld a, [hl+] ; $529a
	cp $00 ; $529b
	jr z, .scanTopLoop ; $529d
	and e ; $529f
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
	wram_bank WRAM_SCREEN ; $52ad
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
	ld [wTextRowWidth], a ; $52c6
	ld a, $36 ; $52c9
	ld hl, wTextRowColumn ; $52cb
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
	cp $00 ; $52d7
	jr z, .scanLoop ; $52d9
	cp $40 ; $52db
	jr nz, .checkMask ; $52dd
	ld hl, SelectionMaskGrid_3f ; $52df
	ld c, $00 ; $52e2
	jr .nextEntry ; $52e4
.checkMask:
	and e ; $52e6
	jr z, .nextEntry ; $52e7
	dec c ; $52e9
	push hl ; $52ea
	ld hl, $10f0 ; $52eb
	ld a, c ; $52ee
	add l ; $52ef
	ld l, a ; $52f0
	jr nc, .haveEntry ; $52f1
	inc h ; $52f3
.haveEntry:
	inc c ; $52f4
	inc b ; $52f5
	push de ; $52f6
	push bc ; $52f7
	ld de, wShadowTilemap + 6 * TILEMAP_WIDTH + 16 ; $52f8
.rowLoop:
	ld a, $80 ; $52fb
	add e ; $52fd
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
	cp $06 ; $531d
	jr nz, .nextEntry ; $531f
	farcall RestoreShadowTilemap ; $5321
	call DrawTennisDictionaryLetterLabels ; $5324
	call QueueTennisDictionaryGlyphTiles ; $5327
	call QueueTennisDictionaryListRows ; $532a
	wram_bank WRAM_SCENE ; $532d
	ret ; $5333
