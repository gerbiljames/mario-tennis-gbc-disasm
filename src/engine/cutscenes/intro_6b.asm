RunIntroCutscene:
	xor a ; $402a
	ld [wCutsceneStep], a ; $402b
	ld [wCutsceneStepTimer], a ; $402e
	ld [wIntroCutsceneCheck], a ; $4031
	ld [wCutsceneScrollX], a ; $4034
	ld [wIntroCutsceneSubState], a ; $4037
	ldh [hShowDebugConsole], a ; $403a
	ld hl, rLCDC ; $403c
	res 3, [hl] ; $403f
	sound BGM_INTRO ; $4041
	ld a, $01 ; $4043
	ld hl, CheckIntroSkipInput ; $4045
	call RegisterFrameTask ; $4048
	call DispatchCutsceneStateInit ; $404b
	ld c, $7f ; $404e
	call BeginFadeOut ; $4050
	call WaitFadeEnd ; $4053
	call ClearFrameTasks ; $4056
	ld hl, rIE ; $4059
	res 1, [hl] ; $405c
	xor a ; $405e
	ldh [hShowDebugConsole], a ; $405f
	ld hl, rLCDC ; $4061
	res 3, [hl] ; $4064
	call ClearDebugTextBuffer ; $4066
	ret ; $4069
DispatchCutsceneStateInit:
	ld a, [wCutsceneStep] ; $406a
	ld l, a ; $406d
	ld h, $00 ; $406e
	add hl, hl ; $4070
	ld de, IntroCutsceneStateTable_6b ; $4071
	add hl, de ; $4074
	ld a, [hl+] ; $4075
	ld h, [hl] ; $4076
	ld l, a ; $4077
	ld a, [hl+] ; $4078
	ld h, [hl] ; $4079
	ld l, a ; $407a
	jp hl ; $407b
.loop:
	ld a, [wIntroCutsceneCheck] ; $407c
	or a ; $407f
	jr nz, .done ; $4080
	call AdvanceFrame ; $4082
	ld a, [wCutsceneStep] ; $4085
	ld l, a ; $4088
	ld h, $00 ; $4089
	add hl, hl ; $408b
	ld de, IntroCutsceneStateTable_6b ; $408c
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
.loopB:
	ld a, [wCutsceneStep] ; $4099
	ld l, a ; $409c
	ld h, $00 ; $409d
	add hl, hl ; $409f
	ld de, IntroCutsceneStateTable_6b ; $40a0
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
.loop2:
	ld a, [wCutsceneStep] ; $40af
	inc a ; $40b2
	ld [wCutsceneStep], a ; $40b3
	ld a, [wIntroCutsceneCheck] ; $40b6
	or a ; $40b9
	jr z, DispatchCutsceneStateInit ; $40ba
.done:
	ret ; $40bc
IntroCutsceneStateTable_6b:
	; $40bd, 36 bytes (records:2)
	dw IntroCutsceneState00_6b ; record 0
	dw IntroCutsceneState15_6b ; record 1
	dw IntroCutsceneState01_6b ; record 2
	dw IntroCutsceneState02_6b ; record 3
	dw IntroCutsceneState03_6b ; record 4
	dw IntroCutsceneState04_6b ; record 5
	dw IntroCutsceneState05_6b ; record 6
	dw IntroCutsceneState06_6b ; record 7
	dw IntroCutsceneState07_6b ; record 8
	dw IntroCutsceneState13_6b ; record 9
	dw IntroCutsceneState08_6b ; record 10
	dw IntroCutsceneState09_6b ; record 11
	dw IntroCutsceneState10_6b ; record 12
	dw IntroCutsceneState16_6b ; record 13
	dw IntroCutsceneState17_6b ; record 14
	dw IntroCutsceneState18_6b ; record 15
	dw IntroCutsceneState19_6b ; record 16
	dw IntroCutsceneState14_6b ; record 17
IntroCutsceneState00_6b:
	; $40e1, 6 bytes (records:2)
	dw IntroCutsceneState00Init_6b ; record 0
	dw IntroCutsceneState00Update_6b ; record 1
	dw IntroCutsceneState00Exit_6b ; record 2
IntroCutsceneState01_6b:
	; $40e7, 6 bytes (records:2)
	dw IntroCutsceneState01Init_6b ; record 0
	dw IntroCutsceneState01Update_6b ; record 1
	dw IntroCutsceneState01Exit_6b ; record 2
IntroCutsceneState02_6b:
	; $40ed, 6 bytes (records:2)
	dw IntroCutsceneState02Init_6b ; record 0
	dw IntroCutsceneState02Update_6b ; record 1
	dw IntroCutsceneState02Exit_6b ; record 2
IntroCutsceneState03_6b:
	; $40f3, 6 bytes (records:2)
	dw IntroCutsceneState03Init_6b ; record 0
	dw IntroCutsceneState03Update_6b ; record 1
	dw IntroCutsceneState03Exit_6b ; record 2
IntroCutsceneState04_6b:
	; $40f9, 6 bytes (records:2)
	dw IntroCutsceneState04Init_6b ; record 0
	dw IntroCutsceneState04Update_6b ; record 1
	dw IntroCutsceneState04Exit_6b ; record 2
IntroCutsceneState05_6b:
	; $40ff, 6 bytes (records:2)
	dw IntroCutsceneState05Init_6b ; record 0
	dw IntroCutsceneState05Update_6b ; record 1
	dw IntroCutsceneState05Exit_6b ; record 2
IntroCutsceneState06_6b:
	; $4105, 6 bytes (records:2)
	dw IntroCutsceneState06Init_6b ; record 0
	dw IntroCutsceneState06Update_6b ; record 1
	dw IntroCutsceneState06Exit_6b ; record 2
IntroCutsceneState07_6b:
	; $410b, 6 bytes (records:2)
	dw IntroCutsceneState07Init_6b ; record 0
	dw IntroCutsceneState07Update_6b ; record 1
	dw IntroCutsceneState07Exit_6b ; record 2
IntroCutsceneState08_6b:
	; $4111, 6 bytes (records:2)
	dw IntroCutsceneState08Init_6b ; record 0
	dw IntroCutsceneState08Update_6b ; record 1
	dw IntroCutsceneState08Exit_6b ; record 2
IntroCutsceneState09_6b:
	; $4117, 6 bytes (records:2)
	dw IntroCutsceneState09Init_6b ; record 0
	dw IntroCutsceneState09Update_6b ; record 1
	dw IntroCutsceneState09Exit_6b ; record 2
IntroCutsceneState10_6b:
	; $411d, 6 bytes (records:2)
	dw IntroCutsceneState10Init_6b ; record 0
	dw IntroCutsceneState10Update_6b ; record 1
	dw IntroCutsceneState10Exit_6b ; record 2
IntroCutsceneState11_6b:
	; $4123, 6 bytes (records:2)
	dw Unused_6b_IntroCutsceneState11Init ; record 0
	dw Unused_6b_IntroCutsceneState11Update ; record 1
	dw Unused_6b_IntroCutsceneState11Exit ; record 2
IntroCutsceneState12_6b:
	; $4129, 6 bytes (records:2)
	dw Unused_6b_IntroCutsceneState12Init ; record 0
	dw Unused_6b_IntroCutsceneState12Update ; record 1
	dw Unused_6b_IntroCutsceneState12Exit ; record 2
IntroCutsceneState13_6b:
	; $412f, 6 bytes (records:2)
	dw IntroCutsceneState13Init_6b ; record 0
	dw IntroCutsceneState13Update_6b ; record 1
	dw IntroCutsceneState13Exit_6b ; record 2
IntroCutsceneState14_6b:
	; $4135, 6 bytes (records:2)
	dw IntroCutsceneState14Init_6b ; record 0
	dw IntroCutsceneState14Update_6b ; record 1
	dw IntroCutsceneState14Exit_6b ; record 2
IntroCutsceneState15_6b:
	; $413b, 6 bytes (records:2)
	dw IntroCutsceneState15Init_6b ; record 0
	dw IntroCutsceneState15Update_6b ; record 1
	dw IntroCutsceneState15Exit_6b ; record 2
IntroCutsceneState16_6b:
	; $4141, 6 bytes (records:2)
	dw IntroCutsceneState16Init_6b ; record 0
	dw IntroCutsceneState16Update_6b ; record 1
	dw IntroCutsceneState16Exit_6b ; record 2
IntroCutsceneState17_6b:
	; $4147, 6 bytes (records:2)
	dw IntroCutsceneState17Init_6b ; record 0
	dw IntroCutsceneState17Update_6b ; record 1
	dw IntroCutsceneState17Exit_6b ; record 2
IntroCutsceneState18_6b:
	; $414d, 6 bytes (records:2)
	dw IntroCutsceneState18Init_6b ; record 0
	dw IntroCutsceneState18Update_6b ; record 1
	dw IntroCutsceneState18Exit_6b ; record 2
IntroCutsceneState19_6b:
	; $4153, 6 bytes (records:2)
	dw IntroCutsceneState19Init_6b ; record 0
	dw IntroCutsceneState19Update_6b ; record 1
	dw IntroCutsceneState19Exit_6b ; record 2
Unused_6b_UpdateHandler_6b:
	jp DispatchCutsceneStateInit.loop ; $4159
IntroCutsceneState14Exit_6b:
	jp DispatchCutsceneStateInit.loop2 ; $415c
Unused_6b_ExitHandler_6b:
	xor a ; $415f
	ld [wCutsceneStepTimer], a ; $4160
	jp DispatchCutsceneStateInit.loop2 ; $4163
IntroCutsceneState14Init_6b:
	ld a, $01 ; $4166
	ld [wIntroCutsceneCheck], a ; $4168
	jp DispatchCutsceneStateInit.loop ; $416b
IntroCutsceneState14Update_6b:
	jp DispatchCutsceneStateInit.loop ; $416e
IntroCutsceneState15Init_6b:
	xor a ; $4171
	ld [wCutsceneStepTimer], a ; $4172
	jp DispatchCutsceneStateInit.loop ; $4175
IntroCutsceneState15Exit_6b:
	xor a ; $4178
	ld [wCutsceneStepTimer], a ; $4179
	jp DispatchCutsceneStateInit.loop2 ; $417c
IntroCutsceneState15Update_6b:
	ld a, [wCutsceneStepTimer] ; $417f
	inc a ; $4182
	ld [wCutsceneStepTimer], a ; $4183
	cp $0a ; $4186
	jp z, DispatchCutsceneStateInit.loopB ; $4188
	jp DispatchCutsceneStateInit.loop ; $418b
IntroCutsceneState00Init_6b:
	call InitCutsceneSceneC ; $418e
	call LoadIntroTilesAndPalette ; $4191
	xor a ; $4194
	ld [wCameraY], a ; $4195
	ld a, $24 ; $4198
	ld [wCameraY + 1], a ; $419a
	xor a ; $419d
	ld [wCutsceneStepTimer], a ; $419e
	ld [wCutsceneSpriteAnimFrame], a ; $41a1
	ld [wCutsceneSpriteAX], a ; $41a4
	ld [wCutsceneSpriteAnimTick], a ; $41a7
	xor a ; $41aa
	ld [wCameraY], a ; $41ab
	ld a, $24 ; $41ae
	ld [wCameraY + 1], a ; $41b0
	ld de, $015c ; $41b3
	ld hl, wCutsceneScrollAccum ; $41b6
	ld a, e ; $41b9
	ld [hl+], a ; $41ba
	ld [hl], d ; $41bb
	ld de, $0120 ; $41bc
	ld hl, wIntroCutsceneScrollY ; $41bf
	ld a, e ; $41c2
	ld [hl+], a ; $41c3
	ld [hl], d ; $41c4
	call EnableLCD ; $41c5
	script_fade_in $20 ; $41c8
	call WaitFadeEnd ; $41cd
	jp DispatchCutsceneStateInit.loop ; $41d0
IntroCutsceneState00Exit_6b:
	ld c, $0a ; $41d3
	call BeginFadeOut ; $41d5
	call WaitFadeEnd ; $41d8
	call ClearFrameTasks ; $41db
	ld a, $01 ; $41de
	ld hl, CheckIntroSkipInput ; $41e0
	call RegisterFrameTask ; $41e3
	xor a ; $41e6
	ldh [hScrollX], a ; $41e7
	ldh [hScrollY], a ; $41e9
	ld [wCameraX], a ; $41eb
	ld [wCameraX + 1], a ; $41ee
	ld [wCameraY], a ; $41f1
	ld [wCameraY + 1], a ; $41f4
	jp DispatchCutsceneStateInit.loop2 ; $41f7
; Instruction-identical to IntroCutsceneState19Update_6b (in this bank); a change here belongs in every copy.
	twin_named intro_cutscene_state00_update, IntroCutsceneState00Update_6b ; $41fa
IntroCutsceneState01Init_6b:
	call DisableLCDSafely ; $421f
	xor a ; $4222
	ld [wCutsceneScrollX], a ; $4223
	ld [wCutsceneStepTimer], a ; $4226
	ld a, $d0 ; $4229
	ld [wCutsceneSpriteAX], a ; $422b
	ld a, $28 ; $422e
	ld [wCutsceneSpriteAY], a ; $4230
	ld a, $30 ; $4233
	ld [wCutsceneSpriteBX], a ; $4235
	ld a, $28 ; $4238
	ld [wCutsceneSpriteBY], a ; $423a
	ld c, SCREENASSET_IntroRallies ; $423d
	farcall LoadScreenAssetRecord ; $423f
	call LoadCutsceneTileset ; $4242
	push_wram_bank WRAM_SCREEN ; $4245
	ld h, $8a ; $424e
	ld de, wShadowAttrmap + 11 * TILEMAP_WIDTH ; $4250
	ld b, $20 ; $4253
	ld c, $01 ; $4255
	farcall FillTilemapRect ; $4257
	pop_wram_bank ; $425a
	farcall QueueWram3MapToVRAM ; $425f
	wram_bank WRAM_STAGING ; $4262
	ld_slot hl, DataPtr_IntroSwingTiles ; $4268
	ld de, wDecompBuffer ; $426b
	call DecompressDataFromBank ; $426e
	ld hl, wDecompBuffer ; $4271
	ld de, vTiles2 ; $4274
	ld c, $80 ; $4277
	call QueueVRAMCopy ; $4279
	ld hl, wTextTileBuffer ; $427c
	ld de, vTiles1 ; $427f
	ld c, wTextTileBuffer_SIZE / 16 ; $4282
	call QueueVRAMCopy ; $4284
	wram_bank WRAM_SCREEN ; $4287
	ld_slot hl, DataPtr_IntroSwingTilemap ; $428d
	ld de, wScreenScratch ; $4290
	call DecompressDataFromBank ; $4293
	ld_slot hl, DataPtr_IntroSwingAttrmap ; $4296
	ld de, wRulesScreenAnimFrame ; $4299
	call DecompressDataFromBank ; $429c
	ld a, $01 ; $429f
	ld hl, QueueCutsceneSpriteGroupA ; $42a1
	call RegisterFrameTask ; $42a4
	call EnableLCD ; $42a7
	script_fade_in $40 ; $42aa
	jp DispatchCutsceneStateInit.loop ; $42af
Palettes_6b_00:
	INCLUDE "data/bank_06b/Palettes_6b_00.asm" ; $42b2, 64 bytes (palettes)
IntroCutsceneState01Exit_6b:
	ld hl, QueueCutsceneSpriteGroupA ; $42f2
	call UnregisterFrameTask ; $42f5
	xor a ; $42f8
	ld [wCutsceneStepTimer], a ; $42f9
	ld [wCutsceneScrollX], a ; $42fc
	ldh [hScrollX], a ; $42ff
	jp DispatchCutsceneStateInit.loop2 ; $4301
IntroCutsceneState01Update_6b:
	ld a, [wCutsceneScrollX] ; $4304
	add $03 ; $4307
	ld [wCutsceneScrollX], a ; $4309
	ldh [hScrollX], a ; $430c
	ld a, [wCutsceneStepTimer] ; $430e
	inc a ; $4311
	ld [wCutsceneStepTimer], a ; $4312
	cp $69 ; $4315
	jr z, .timerExpired ; $4317
	ld a, [wCutsceneSpriteAX] ; $4319
	inc a ; $431c
	ld [wCutsceneSpriteAX], a ; $431d
	jp DispatchCutsceneStateInit.loop ; $4320
.timerExpired:
	jp DispatchCutsceneStateInit.loopB ; $4323
IntroCutsceneState02Init_6b:
	push_wram_bank WRAM_SCREEN ; $4326
	ld hl, wIntroCharactersTilemap + 4 * TILEMAP_WIDTH ; $432f
	ld de, vBGMap0 + 4 * TILEMAP_WIDTH ; $4332
	ld c, 5 * TILEMAP_WIDTH / 16 ; $4335
	call QueueVRAMCopy ; $4337
	ld hl, wIntroCharactersAttrmap + 4 * TILEMAP_WIDTH ; $433a
	ld de, vBGMap0 + 4 * TILEMAP_WIDTH + VRAM_BANK1 ; $433d
	ld c, 5 * TILEMAP_WIDTH / 16 ; $4340
	call QueueVRAMCopy ; $4342
	call AdvanceFrame ; $4345
	ld hl, wIntroCharactersTilemap + 9 * TILEMAP_WIDTH ; $4348
	ld de, vBGMap0 + 9 * TILEMAP_WIDTH ; $434b
	ld c, 5 * TILEMAP_WIDTH / 16 ; $434e
	call QueueVRAMCopy ; $4350
	ld hl, wIntroCharactersAttrmap + 9 * TILEMAP_WIDTH ; $4353
	ld de, vBGMap0 + 9 * TILEMAP_WIDTH + VRAM_BANK1 ; $4356
	ld c, 5 * TILEMAP_WIDTH / 16 ; $4359
	call QueueVRAMCopy ; $435b
	pop_wram_bank ; $435e
	ld hl, IntroCutsceneState02InitPalette_6b ; $4363
	ld_bg_pals de, 0, 8 ; $4366
	call LoadPalettesImmediate ; $4369
	jp DispatchCutsceneStateInit.loop ; $436c
IntroCutsceneState02InitPalette_6b:
	INCLUDE "data/bank_06b/IntroCutsceneState02InitPalette_6b.asm" ; $436f, 64 bytes (palettes)
IntroCutsceneState02Exit_6b:
	ld c, $06 ; $43af
	call BeginFadeOut ; $43b1
	call WaitFadeEnd ; $43b4
	xor a ; $43b7
	ld [wCutsceneStepTimer], a ; $43b8
	jp DispatchCutsceneStateInit.loop2 ; $43bb
IntroCutsceneState02Update_6b:
	ld a, [wCutsceneStepTimer] ; $43be
	inc a ; $43c1
	ld [wCutsceneStepTimer], a ; $43c2
	cp $1e ; $43c5
	jr z, .timerExpired ; $43c7
	jp DispatchCutsceneStateInit.loop ; $43c9
.timerExpired:
	jp DispatchCutsceneStateInit.loopB ; $43cc
IntroCutsceneState03Init_6b:
	call DisableLCDSafely ; $43cf
	ld c, SCREENASSET_IntroRallies2 ; $43d2
	farcall LoadScreenAssetRecord ; $43d4
	push_wram_bank WRAM_SCREEN ; $43d7
	ld h, $8a ; $43e0
	ld de, wShadowAttrmap + 11 * TILEMAP_WIDTH ; $43e2
	ld b, $20 ; $43e5
	ld c, $01 ; $43e7
	farcall FillTilemapRect ; $43e9
	pop_wram_bank ; $43ec
	farcall QueueWram3MapToVRAM ; $43f1
	wram_bank WRAM_STAGING ; $43f4
	ld_slot hl, DataPtr_IntroCloseupTiles ; $43fa
	ld de, wDecompBuffer ; $43fd
	call DecompressDataFromBank ; $4400
	ld hl, wDecompBuffer ; $4403
	ld de, vTiles2 ; $4406
	ld c, $80 ; $4409
	call QueueVRAMCopy ; $440b
	ld hl, wTextTileBuffer ; $440e
	ld de, vTiles1 ; $4411
	ld c, wTextTileBuffer_SIZE / 16 ; $4414
	call QueueVRAMCopy ; $4416
	wram_bank WRAM_SCREEN ; $4419
	ld_slot hl, DataPtr_IntroCloseupTilemap ; $441f
	ld de, wScreenScratch ; $4422
	call DecompressDataFromBank ; $4425
	ld_slot hl, DataPtr_IntroCloseupAttrmap ; $4428
	ld de, wRulesScreenAnimFrame ; $442b
	call DecompressDataFromBank ; $442e
	ld a, $01 ; $4431
	ld hl, QueueCutsceneSpriteGroupB ; $4433
	call RegisterFrameTask ; $4436
	ld a, $a0 ; $4439
	ld [wCutsceneSpriteBX], a ; $443b
	ld a, $28 ; $443e
	ld [wCutsceneSpriteBY], a ; $4440
	xor a ; $4443
	ld [wIntroCutsceneSubState], a ; $4444
	call EnableLCD ; $4447
	script_fade_in $7f ; $444a
	call WaitFadeEnd ; $444f
	jp DispatchCutsceneStateInit.loop ; $4452
IntroCutsceneState03Exit_6b:
	ld hl, QueueCutsceneSpriteGroupB ; $4455
	call UnregisterFrameTask ; $4458
	xor a ; $445b
	ld [wCutsceneStepTimer], a ; $445c
	ld [wIntroCutsceneSubState], a ; $445f
	ldh [hScrollX], a ; $4462
	jp DispatchCutsceneStateInit.loop2 ; $4464
IntroCutsceneState03Update_6b:
	ld a, [wCutsceneStepTimer] ; $4467
	inc a ; $446a
	ld [wCutsceneStepTimer], a ; $446b
	cp $7d ; $446e
	jp z, DispatchCutsceneStateInit.loopB ; $4470
	ld a, [wIntroCutsceneSubState] ; $4473
	sub $03 ; $4476
	ld [wIntroCutsceneSubState], a ; $4478
	ldh [hScrollX], a ; $447b
	ld a, [wCutsceneSpriteBX] ; $447d
	dec a ; $4480
	ld [wCutsceneSpriteBX], a ; $4481
	jp DispatchCutsceneStateInit.loop ; $4484
IntroCutsceneState04Init_6b:
	push_wram_bank WRAM_SCREEN ; $4487
	ld hl, wIntroCharactersTilemap + 4 * TILEMAP_WIDTH ; $4490
	ld de, vBGMap0 + 4 * TILEMAP_WIDTH ; $4493
	ld c, 5 * TILEMAP_WIDTH / 16 ; $4496
	call QueueVRAMCopy ; $4498
	ld hl, wIntroCharactersAttrmap + 4 * TILEMAP_WIDTH ; $449b
	ld de, vBGMap0 + 4 * TILEMAP_WIDTH + VRAM_BANK1 ; $449e
	ld c, 5 * TILEMAP_WIDTH / 16 ; $44a1
	call QueueVRAMCopy ; $44a3
	call AdvanceFrame ; $44a6
	ld hl, wIntroCharactersTilemap + 9 * TILEMAP_WIDTH ; $44a9
	ld de, vBGMap0 + 9 * TILEMAP_WIDTH ; $44ac
	ld c, 5 * TILEMAP_WIDTH / 16 ; $44af
	call QueueVRAMCopy ; $44b1
	ld hl, wIntroCharactersAttrmap + 9 * TILEMAP_WIDTH ; $44b4
	ld de, vBGMap0 + 9 * TILEMAP_WIDTH + VRAM_BANK1 ; $44b7
	ld c, 5 * TILEMAP_WIDTH / 16 ; $44ba
	call QueueVRAMCopy ; $44bc
	pop_wram_bank ; $44bf
	ld hl, IntroCutsceneState04InitPalettes ; $44c4
	ld_bg_pals de, 0, 8 ; $44c7
	call LoadPalettesImmediate ; $44ca
	jp DispatchCutsceneStateInit.loop ; $44cd
IntroCutsceneState04InitPalettes:
	INCLUDE "data/bank_06b/IntroCutsceneState04InitPalettes.asm" ; $44d0, 64 bytes (palettes)
IntroCutsceneState04Exit_6b:
	ld c, $06 ; $4510
	call BeginFadeOut ; $4512
	call WaitFadeEnd ; $4515
	xor a ; $4518
	ld [wCutsceneStepTimer], a ; $4519
	jp DispatchCutsceneStateInit.loop2 ; $451c
IntroCutsceneState04Update_6b:
	ld a, [wCutsceneStepTimer] ; $451f
	inc a ; $4522
	ld [wCutsceneStepTimer], a ; $4523
	cp $1e ; $4526
	jp z, DispatchCutsceneStateInit.loopB ; $4528
	jp DispatchCutsceneStateInit.loop ; $452b
IntroCutsceneState05Init_6b:
	call DisableLCDSafely ; $452e
	ld c, SCREENASSET_IntroRallies3 ; $4531
	farcall LoadScreenAssetRecord ; $4533
	push_wram_bank WRAM_SCREEN ; $4536
	ld h, $8a ; $453f
	ld de, wShadowAttrmap + 8 * TILEMAP_WIDTH ; $4541
	ld b, $20 ; $4544
	ld c, $01 ; $4546
	farcall FillTilemapRect ; $4548
	ld h, $8a ; $454b
	ld de, wShadowAttrmap + 14 * TILEMAP_WIDTH ; $454d
	ld b, $20 ; $4550
	ld c, $01 ; $4552
	farcall FillTilemapRect ; $4554
	pop_wram_bank ; $4557
	farcall QueueWram3MapToVRAM ; $455c
	ld c, SCREENASSET_IntroRallies4 ; $455f
	farcall LoadScreenAssetRecord ; $4561
	ld a, $08 ; $4564
	ldh [rSTAT], a ; $4566
	ld hl, rIE ; $4568
	set 1, [hl] ; $456b
	ld a, $44 ; $456d
	ld [wRasterScrollStartLY], a ; $456f
	ld a, $78 ; $4572
	ld [wRasterScrollEndLY], a ; $4574
	xor a ; $4577
	ld [wRasterScrollX], a ; $4578
	ld a, $01 ; $457b
	ld hl, UpdateCutsceneScroll ; $457d
	call RegisterFrameTask ; $4580
	ld a, $a0 ; $4583
	ld [wCutsceneSpriteBX], a ; $4585
	ld a, $40 ; $4588
	ld [wCutsceneSpriteBY], a ; $458a
	ld a, $c0 ; $458d
	ld [wCutsceneSpriteAX], a ; $458f
	ld a, $10 ; $4592
	ld [wCutsceneSpriteAY], a ; $4594
	ld a, $01 ; $4597
	ld hl, QueueCutsceneSpriteGroupA ; $4599
	call RegisterFrameTask ; $459c
	ld a, $01 ; $459f
	ld hl, QueueCutsceneSpriteGroupB ; $45a1
	call RegisterFrameTask ; $45a4
	call EnableLCD ; $45a7
	script_fade_in $10 ; $45aa
	call WaitFadeEnd ; $45af
	jp DispatchCutsceneStateInit.loop ; $45b2
IntroCutsceneState05Exit_6b:
	ld hl, rIE ; $45b5
	res 1, [hl] ; $45b8
	push_wram_bank WRAM_SCREEN ; $45ba
	ld hl, wShadowTilemap + 3 * TILEMAP_WIDTH ; $45c3
	ld de, vBGMap0 + 3 * TILEMAP_WIDTH ; $45c6
	ld c, 6 * TILEMAP_WIDTH / 16 ; $45c9
	call QueueVRAMCopy ; $45cb
	ld hl, wShadowAttrmap + 3 * TILEMAP_WIDTH ; $45ce
	ld de, vBGMap0 + 3 * TILEMAP_WIDTH + VRAM_BANK1 ; $45d1
	ld c, 6 * TILEMAP_WIDTH / 16 ; $45d4
	call QueueVRAMCopy ; $45d6
	pop_wram_bank ; $45d9
	ld hl, QueueCutsceneSpriteGroupA ; $45de
	call UnregisterFrameTask ; $45e1
	ld hl, UpdateCutsceneScroll ; $45e4
	call UnregisterFrameTask ; $45e7
	xor a ; $45ea
	ldh [hScrollX], a ; $45eb
	call AdvanceFrame ; $45ed
	push_wram_bank WRAM_SCREEN ; $45f0
	ld hl, wShadowTilemap + 9 * TILEMAP_WIDTH ; $45f9
	ld de, vBGMap0 + 9 * TILEMAP_WIDTH ; $45fc
	ld c, 6 * TILEMAP_WIDTH / 16 ; $45ff
	call QueueVRAMCopy ; $4601
	ld hl, wShadowAttrmap + 9 * TILEMAP_WIDTH ; $4604
	ld de, vBGMap0 + 9 * TILEMAP_WIDTH + VRAM_BANK1 ; $4607
	ld c, 6 * TILEMAP_WIDTH / 16 ; $460a
	call QueueVRAMCopy ; $460c
	pop_wram_bank ; $460f
	ld hl, QueueCutsceneSpriteGroupB ; $4614
	call UnregisterFrameTask ; $4617
	call AdvanceFrame ; $461a
	jp DispatchCutsceneStateInit.loop2 ; $461d
IntroCutsceneState05Update_6b:
	ld a, [wCutsceneStepTimer] ; $4620
	inc a ; $4623
	ld [wCutsceneStepTimer], a ; $4624
	cp $60 ; $4627
	jp z, DispatchCutsceneStateInit.loopB ; $4629
	ld a, [wCutsceneSpriteAX] ; $462c
	inc a ; $462f
	ld [wCutsceneSpriteAX], a ; $4630
	ld a, [wCutsceneSpriteBX] ; $4633
	dec a ; $4636
	ld [wCutsceneSpriteBX], a ; $4637
	jp DispatchCutsceneStateInit.loop ; $463a
IntroCutsceneState06Init_6b:
	xor a ; $463d
	ld [wCutsceneStepTimer], a ; $463e
	jp DispatchCutsceneStateInit.loop ; $4641
IntroCutsceneState06Exit_6b:
	ld c, $10 ; $4644
	call BeginFadeOut ; $4646
	call WaitFadeEnd ; $4649
	jp DispatchCutsceneStateInit.loop2 ; $464c
IntroCutsceneState06Update_6b:
	ld a, [wCutsceneStepTimer] ; $464f
	inc a ; $4652
	ld [wCutsceneStepTimer], a ; $4653
	cp $64 ; $4656
	jp z, DispatchCutsceneStateInit.loopB ; $4658
	jp DispatchCutsceneStateInit.loop ; $465b
IntroCutsceneState07Init_6b:
	call InitTitleSceneGraphics ; $465e
	call DecompressIntroTitleTiles ; $4661
	xor a ; $4664
	ld [wCutsceneStepTimer], a ; $4665
	ld [wCutsceneSpriteAX], a ; $4668
	ld [wCutsceneSpriteAY], a ; $466b
	ld [wCutsceneSpriteBX], a ; $466e
	ld [wCutsceneSpriteBY], a ; $4671
	call EnableLCD ; $4674
	script_fade_in $08 ; $4677
	call WaitFadeEnd ; $467c
	ld a, $01 ; $467f
	ld hl, IntroSequenceTimerTask ; $4681
	call RegisterFrameTask ; $4684
	jp DispatchCutsceneStateInit.loop ; $4687
IntroCutsceneState07Exit_6b:
	call ClearFrameTasks ; $468a
	ld a, $01 ; $468d
	ld hl, CheckIntroSkipInput ; $468f
	call RegisterFrameTask ; $4692
	xor a ; $4695
	ldh [hScrollX], a ; $4696
	ldh [hScrollY], a ; $4698
	ld [wCameraX], a ; $469a
	ld [wCameraX + 1], a ; $469d
	ld [wCameraY], a ; $46a0
	ld [wCameraY + 1], a ; $46a3
	jp DispatchCutsceneStateInit.loop2 ; $46a6
IntroCutsceneState07Update_6b:
	ld a, [wCameraX + 1] ; $46a9
	cp $40 ; $46ac
	jp nz, .checkCutsceneStepTimer ; $46ae
	ld a, [wCutsceneStepTimer] ; $46b1
	inc a ; $46b4
	ld [wCutsceneStepTimer], a ; $46b5
	cp $29 ; $46b8
	jp z, DispatchCutsceneStateInit.loopB ; $46ba
	jp DispatchCutsceneStateInit.loop ; $46bd
.checkCutsceneStepTimer:
	ld a, [wCutsceneStepTimer] ; $46c0
	cp $01 ; $46c3
	jr z, .eq01 ; $46c5
	inc a ; $46c7
	ld [wCutsceneStepTimer], a ; $46c8
	jp DispatchCutsceneStateInit.loop ; $46cb
.eq01:
	ld a, [wCameraX + 1] ; $46ce
	ld h, a ; $46d1
	ld a, [wCameraX] ; $46d2
	ld l, a ; $46d5
	ld bc, $0020 ; $46d6
	add hl, bc ; $46d9
	ld a, h ; $46da
	ld [wCameraX + 1], a ; $46db
	ld a, l ; $46de
	ld [wCameraX], a ; $46df
	jp DispatchCutsceneStateInit.loop ; $46e2
IntroCutsceneState13Init_6b:
	xor a ; $46e5
	ldh [hScrollY], a ; $46e6
	ldh [hScrollX], a ; $46e8
	ld [wCutsceneStepTimer], a ; $46ea
	push_wram_bank WRAM_TEXT ; $46ed
	ld hl, IntroCutsceneState13InitPalettes_6b ; $46f6
	ld_bg_pals de, 0, 8 ; $46f9
	call LoadPaletteShadow ; $46fc
	ld hl, wWindowShadowTilemap + 6 * TILEMAP_WIDTH ; $46ff
	ld de, vBGMap0 + 6 * TILEMAP_WIDTH ; $4702
	ld c, 8 * TILEMAP_WIDTH / 16 ; $4705
	call QueueVRAMCopy ; $4707
	ld hl, wWindowShadowAttrmap + 6 * TILEMAP_WIDTH ; $470a
	ld de, vBGMap0 + 6 * TILEMAP_WIDTH + VRAM_BANK1 ; $470d
	ld c, 8 * TILEMAP_WIDTH / 16 ; $4710
	call QueueVRAMCopy ; $4712
	call AdvanceFrame ; $4715
	ld hl, wWindowShadowTilemap + 4 * TILEMAP_WIDTH ; $4718
	ld de, vBGMap0 + 4 * TILEMAP_WIDTH ; $471b
	ld c, 2 * TILEMAP_WIDTH / 16 ; $471e
	call QueueVRAMCopy ; $4720
	ld hl, wWindowShadowAttrmap + 4 * TILEMAP_WIDTH ; $4723
	ld de, vBGMap0 + 4 * TILEMAP_WIDTH + VRAM_BANK1 ; $4726
	ld c, 2 * TILEMAP_WIDTH / 16 ; $4729
	call QueueVRAMCopy ; $472b
	call AdvanceFrame ; $472e
	pop_wram_bank ; $4731
	jp DispatchCutsceneStateInit.loop ; $4736
IntroCutsceneState13Exit_6b:
	ld c, $10 ; $4739
	call BeginFadeOut ; $473b
	call WaitFadeEnd ; $473e
	call DisableLCDSafely ; $4741
	xor a ; $4744
	ld [wCutsceneStepTimer], a ; $4745
	jp DispatchCutsceneStateInit.loop2 ; $4748
IntroCutsceneState13Update_6b:
	ld a, [wCutsceneStepTimer] ; $474b
	inc a ; $474e
	ld [wCutsceneStepTimer], a ; $474f
	cp $64 ; $4752
	jp z, DispatchCutsceneStateInit.loopB ; $4754
	jp DispatchCutsceneStateInit.loop ; $4757
IntroCutsceneState13InitPalettes_6b:
	INCLUDE "data/bank_06b/IntroCutsceneState13InitPalettes_6b.asm" ; $475a, 64 bytes (palettes)
IntroCutsceneState08Init_6b:
	call DisableLCDSafely ; $479a
	ld c, SCREENASSET_IntroWave ; $479d
	farcall LoadScreenAssetRecord ; $479f
	farcall QueueWram3MapToVRAM ; $47a2
	xor a ; $47a5
	ld [wCutsceneStepTimer], a ; $47a6
	ld a, $b0 ; $47a9
	ld [wCutsceneScrollX], a ; $47ab
	ld a, $01 ; $47ae
	ld hl, ScrollCutsceneXRightTask ; $47b0
	call RegisterFrameTask ; $47b3
	call EnableLCD ; $47b6
	script_fade_in $10 ; $47b9
	call WaitFadeEnd ; $47be
	jp DispatchCutsceneStateInit.loop ; $47c1
IntroCutsceneState08Exit_6b:
	ld c, $0a ; $47c4
	call BeginFadeOut ; $47c6
	call WaitFadeEnd ; $47c9
	ld hl, ScrollCutsceneXRightTask ; $47cc
	call UnregisterFrameTask ; $47cf
	xor a ; $47d2
	ldh [hScrollX], a ; $47d3
	jp DispatchCutsceneStateInit.loop2 ; $47d5
IntroCutsceneState08Update_6b:
	ld a, [wCutsceneStepTimer] ; $47d8
	inc a ; $47db
	ld [wCutsceneStepTimer], a ; $47dc
	cp $2c ; $47df
	jp z, DispatchCutsceneStateInit.loopB ; $47e1
	jp DispatchCutsceneStateInit.loop ; $47e4
IntroCutsceneState09Init_6b:
	call DisableLCDSafely ; $47e7
	ld c, SCREENASSET_IntroDive ; $47ea
	farcall LoadScreenAssetRecord ; $47ec
	farcall QueueWram3MapToVRAM ; $47ef
	ld a, $94 ; $47f2
	ld [wCutsceneScrollX], a ; $47f4
	ldh [hScrollX], a ; $47f7
	xor a ; $47f9
	ld [wCutsceneStepTimer], a ; $47fa
	ld a, $01 ; $47fd
	ld hl, ScrollCutsceneXLeftTask ; $47ff
	call RegisterFrameTask ; $4802
	call EnableLCD ; $4805
	script_fade_in $10 ; $4808
	call WaitFadeEnd ; $480d
	jp DispatchCutsceneStateInit.loop ; $4810
IntroCutsceneState09Exit_6b:
	ld c, $0a ; $4813
	call BeginFadeOut ; $4815
	call WaitFadeEnd ; $4818
	ld hl, ScrollCutsceneXLeftTask ; $481b
	call UnregisterFrameTask ; $481e
	xor a ; $4821
	ldh [hScrollX], a ; $4822
	jp DispatchCutsceneStateInit.loop2 ; $4824
IntroCutsceneState09Update_6b:
	ld a, [wCutsceneStepTimer] ; $4827
	inc a ; $482a
	ld [wCutsceneStepTimer], a ; $482b
	cp $2b ; $482e
	jp z, DispatchCutsceneStateInit.loopB ; $4830
	jp DispatchCutsceneStateInit.loop ; $4833
IntroCutsceneState10Init_6b:
	call DisableLCDSafely ; $4836
	ld c, SCREENASSET_IntroGirlSwing ; $4839
	farcall LoadScreenAssetRecord ; $483b
	farcall QueueWram3MapToVRAM ; $483e
	ld a, $a8 ; $4841
	ld [wCutsceneScrollX], a ; $4843
	ldh [hScrollX], a ; $4846
	xor a ; $4848
	ld [wCutsceneStepTimer], a ; $4849
	ld a, $01 ; $484c
	ld hl, ScrollCutsceneLeftTask ; $484e
	call RegisterFrameTask ; $4851
	call EnableLCD ; $4854
	script_fade_in $10 ; $4857
	call WaitFadeEnd ; $485c
	jp DispatchCutsceneStateInit.loop ; $485f
IntroCutsceneState10Exit_6b:
	ld c, $0a ; $4862
	call BeginFadeOut ; $4864
	call WaitFadeEnd ; $4867
	ld hl, ScrollCutsceneLeftTask ; $486a
	call UnregisterFrameTask ; $486d
	xor a ; $4870
	ldh [hScrollX], a ; $4871
	jp DispatchCutsceneStateInit.loop2 ; $4873
IntroCutsceneState10Update_6b:
	ld a, [wCutsceneStepTimer] ; $4876
	inc a ; $4879
	ld [wCutsceneStepTimer], a ; $487a
	cp $2b ; $487d
	jp z, DispatchCutsceneStateInit.loopB ; $487f
	jp DispatchCutsceneStateInit.loop ; $4882
Unused_6b_IntroCutsceneState11Init:
	call DisableLCDSafely ; $4885
	ld c, SCREENASSET_DecompressIntroTitleTilesPtrs ; $4888
	farcall LoadScreenAssetRecord ; $488a
	ld a, $01 ; $488d
	ldh [hShowDebugConsole], a ; $488f
	ld hl, rLCDC ; $4891
	set 3, [hl] ; $4894
	wram_bank WRAM_SCREEN ; $4896
	ld hl, wShadowTilemap ; $489c
	ld de, vBGMap1 ; $489f
	ld c, TILEMAP_AREA / 16 ; $48a2
	call QueueVRAMCopy ; $48a4
	ld hl, wShadowAttrmap ; $48a7
	ld de, vBGMap1 + VRAM_BANK1 ; $48aa
	ld c, TILEMAP_AREA / 16 ; $48ad
	call QueueVRAMCopy ; $48af
	call Unused_6b_InitCutsceneSceneB ; $48b2
	call LoadIntroTilesAndPalette ; $48b5
	call EnableLCD ; $48b8
	script_fade_in $20 ; $48bb
	call WaitFadeEnd ; $48c0
	xor a ; $48c3
	ld [wCutsceneStepTimer], a ; $48c4
	jp DispatchCutsceneStateInit.loop ; $48c7
Unused_6b_IntroCutsceneState11Exit:
	ld a, $00 ; $48ca
	ldh [hShowDebugConsole], a ; $48cc
	ld hl, rLCDC ; $48ce
	res 3, [hl] ; $48d1
	ld hl, Palette_6b_1 ; $48d3
	ld_bg_pals de, 0, 8 ; $48d6
	call LoadPaletteShadow ; $48d9
	xor a ; $48dc
	ld [wCutsceneStepTimer], a ; $48dd
	jp DispatchCutsceneStateInit.loop2 ; $48e0
Unused_6b_IntroCutsceneState11Update:
	ld a, [wCutsceneStepTimer] ; $48e3
	inc a ; $48e6
	ld [wCutsceneStepTimer], a ; $48e7
	cp $70 ; $48ea
	jp z, DispatchCutsceneStateInit.loopB ; $48ec
	jp DispatchCutsceneStateInit.loop ; $48ef
Unused_6b_IntroCutsceneState12Init:
	xor a ; $48f2
	ld [wCutsceneStepTimer], a ; $48f3
	ld [wCutsceneSpriteAY], a ; $48f6
	xor a ; $48f9
	ld [wCameraY], a ; $48fa
	ld a, $24 ; $48fd
	ld [wCameraY + 1], a ; $48ff
	ld a, $00 ; $4902
	ld [wCutsceneSpriteAnimTick], a ; $4904
	ld [wCutsceneSpriteAnimFrame], a ; $4907
	ld de, $015c ; $490a
	ld hl, wCutsceneScrollAccum ; $490d
	ld a, e ; $4910
	ld [hl+], a ; $4911
	ld [hl], d ; $4912
	ld de, $0120 ; $4913
	ld hl, wIntroCutsceneScrollY ; $4916
	ld a, e ; $4919
	ld [hl+], a ; $491a
	ld [hl], d ; $491b
	jp DispatchCutsceneStateInit.loop ; $491c
Unused_6b_IntroCutsceneState12Exit:
	ld c, $04 ; $491f
	call BeginFadeOut ; $4921
	call WaitFadeEnd ; $4924
	jp DispatchCutsceneStateInit.loop2 ; $4927
Unused_6b_IntroCutsceneState12Update:
	ld a, [wCutsceneSpriteAY] ; $492a
	cp $0a ; $492d
	jr z, .checkCutsceneStepTimer ; $492f
	inc a ; $4931
	ld [wCutsceneSpriteAY], a ; $4932
	call QueueScrollingSprite ; $4935
	jp DispatchCutsceneStateInit.loop ; $4938
.checkCutsceneStepTimer:
	ld a, [wCutsceneStepTimer] ; $493b
	inc a ; $493e
	ld [wCutsceneStepTimer], a ; $493f
	cp $80 ; $4942
	jp z, DispatchCutsceneStateInit.loopB ; $4944
	cp $64 ; $4947
	jr nc, .updateCutsceneScrollY ; $4949
	call AdvanceSpriteAnimTimer ; $494b
.updateCutsceneScrollY:
	call UpdateCutsceneScrollY ; $494e
	call UpdateCutsceneScrollX ; $4951
	call SetCameraYFromScrollPos ; $4954
	call QueueScrollingSprite ; $4957
	call QueueCutsceneAnimatedSprites ; $495a
	jp DispatchCutsceneStateInit.loop ; $495d
IntroCutsceneState16Init_6b:
	call DisableLCDSafely ; $4960
	call InitCutsceneSceneA ; $4963
	call LoadIntroTilesAndPalette ; $4966
	ld a, $02 ; $4969
	ldh [hShowDebugConsole], a ; $496b
	ld hl, rLCDC ; $496d
	set 3, [hl] ; $4970
	wram_bank WRAM_STAGING ; $4972
	ld_slot hl, DataPtr_IntroGreatestPlayerTiles ; $4978
	ld de, wDecompBuffer ; $497b
	call DecompressDataFromBank ; $497e
	ld hl, wDecompBuffer ; $4981
	ld de, vTiles2 ; $4984
	ld c, $80 ; $4987
	call QueueVRAMCopy ; $4989
	ld hl, wTextTileBuffer ; $498c
	ld de, vTiles1 ; $498f
	ld c, wTextTileBuffer_SIZE / 16 ; $4992
	call QueueVRAMCopy ; $4994
	ld_slot hl, DataPtr_IntroGreatestPlayerTilemap ; $4997
	ld de, wDecompBuffer ; $499a
	call DecompressDataFromBank ; $499d
	ld_slot hl, DataPtr_IntroGreatestPlayerAttrmap ; $49a0
	ld de, wDecompBuffer + 64 * TILE_SIZE ; $49a3
	call DecompressDataFromBank ; $49a6
	ld hl, wDecompBuffer ; $49a9
	ld de, vBGMap1 ; $49ac
	ld c, $40 ; $49af
	call QueueVRAMCopy ; $49b1
	ld hl, wDecompBuffer + 64 * TILE_SIZE ; $49b4
	ld de, vBGMap1 + VRAM_BANK1 ; $49b7
	ld c, $40 ; $49ba
	call QueueVRAMCopy ; $49bc
	ld hl, IntroCutsceneState16InitPalettes_6b ; $49bf
	ld_bg_pals de, 0, 8 ; $49c2
	call LoadPaletteShadow ; $49c5
	wram_bank WRAM_STAGING ; $49c8
	ld_slot hl, DataPtr_IntroCharactersTiles ; $49ce
	ld de, wDecompBuffer ; $49d1
	call DecompressDataFromBank ; $49d4
	ld hl, wDecompBuffer ; $49d7
	ld de, vTiles2 + VRAM_BANK1 ; $49da
	ld c, $80 ; $49dd
	call QueueVRAMCopy ; $49df
	ld hl, wTextTileBuffer ; $49e2
	ld de, vTiles1 + VRAM_BANK1 ; $49e5
	ld c, wTextTileBuffer_SIZE / 16 ; $49e8
	call QueueVRAMCopy ; $49ea
	wram_bank WRAM_ACTORS ; $49ed
	ld_slot hl, DataPtr_IntroCharactersTilemap ; $49f3
	ld de, wIntroCharactersTilemap ; $49f6
	call DecompressDataFromBank ; $49f9
	ld_slot hl, DataPtr_IntroCharactersAttrmap ; $49fc
	ld de, wIntroCharactersAttrmap ; $49ff
	call DecompressDataFromBank ; $4a02
	wram_bank WRAM_TEXT ; $4a05
	ld_slot hl, DataPtr_IntroCharactersTilemap2 ; $4a0b
	ld de, wWindowShadowTilemap ; $4a0e
	call DecompressDataFromBank ; $4a11
	ld_slot hl, DataPtr_IntroCharactersAttrmap2 ; $4a14
	ld de, wWindowShadowAttrmap ; $4a17
	call DecompressDataFromBank ; $4a1a
	wram_bank WRAM_STAGING ; $4a1d
	ld hl, CutsceneSceneAGfx0 ; $4a23
	ld de, wDecompBuffer ; $4a26
	call DecompressData ; $4a29
	xor a ; $4a2c
	ldh [hScrollX], a ; $4a2d
	ldh [hScrollY], a ; $4a2f
	ld [wCutsceneStepTimer], a ; $4a31
	call EnableLCD ; $4a34
	script_fade_in $08 ; $4a37
	call WaitFadeEnd ; $4a3c
	jp DispatchCutsceneStateInit.loop ; $4a3f
