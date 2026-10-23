RunIntroCutscene:
	xor a ; $402a
	ld [wCutsceneStep], a ; $402b
	ld [wCutsceneStepTimer], a ; $402e
	ld [wIntroCutsceneDone], a ; $4031
	ld [wCutsceneScrollX], a ; $4034
	ld [wCutsceneReverseScrollX], a ; $4037
	ldh [hBGViewMode], a ; $403a
	ld hl, rLCDC ; $403c
	res B_LCDC_BG_MAP, [hl] ; $403f
	sound BGM_INTRO ; $4041
	frame_task CheckIntroSkipInput ; $4043
	call DispatchCutsceneStateInit ; $404b
	script_fade_out 127 ; $404e
	call WaitFadeEnd ; $4053
	call ClearFrameTasks ; $4056
	ld hl, rIE ; $4059
	res B_IE_STAT, [hl] ; $405c
	xor a ; $405e
	ldh [hBGViewMode], a ; $405f
	ld hl, rLCDC ; $4061
	res B_LCDC_BG_MAP, [hl] ; $4064
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
.runUpdate:
	ld a, [wIntroCutsceneDone] ; $407c
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
.runExit:
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
.nextState:
	ld a, [wCutsceneStep] ; $40af
	inc a ; $40b2
	ld [wCutsceneStep], a ; $40b3
	ld a, [wIntroCutsceneDone] ; $40b6
	or a ; $40b9
	jr z, DispatchCutsceneStateInit ; $40ba
.done:
	ret ; $40bc
IntroCutsceneStateTable_6b:
	; $40bd, 36 bytes (records:2)
	dw IntroCutsceneOpeningToss_6b ; record 0
	dw IntroCutscenePause_6b ; record 1
	dw IntroCutsceneAlexRally_6b ; record 2
	dw IntroCutsceneAlexSwing_6b ; record 3
	dw IntroCutsceneNinaRally_6b ; record 4
	dw IntroCutsceneNinaSwing_6b ; record 5
	dw IntroCutsceneBothRally_6b ; record 6
	dw IntroCutsceneRallyFadeOut_6b ; record 7
	dw IntroCutsceneOpponentsPan_6b ; record 8
	dw IntroCutsceneOpponentsCaption_6b ; record 9
	dw IntroCutsceneWave_6b ; record 10
	dw IntroCutsceneDive_6b ; record 11
	dw IntroCutsceneGirlSwing_6b ; record 12
	dw IntroCutsceneGreatestPlayer_6b ; record 13
	dw IntroCutsceneMarioReveal_6b ; record 14
	dw IntroCutsceneMarioCloseupScroll_6b ; record 15
	dw IntroCutsceneClosingToss_6b ; record 16
	dw IntroCutsceneEnd_6b ; record 17
IntroCutsceneOpeningToss_6b:
	; $40e1, 6 bytes (records:2)
	dw IntroCutsceneOpeningTossInit_6b ; record 0
	dw IntroCutsceneOpeningTossUpdate_6b ; record 1
	dw IntroCutsceneOpeningTossExit_6b ; record 2
IntroCutsceneAlexRally_6b:
	; $40e7, 6 bytes (records:2)
	dw IntroCutsceneAlexRallyInit_6b ; record 0
	dw IntroCutsceneAlexRallyUpdate_6b ; record 1
	dw IntroCutsceneAlexRallyExit_6b ; record 2
IntroCutsceneAlexSwing_6b:
	; $40ed, 6 bytes (records:2)
	dw IntroCutsceneAlexSwingInit_6b ; record 0
	dw IntroCutsceneAlexSwingUpdate_6b ; record 1
	dw IntroCutsceneAlexSwingExit_6b ; record 2
IntroCutsceneNinaRally_6b:
	; $40f3, 6 bytes (records:2)
	dw IntroCutsceneNinaRallyInit_6b ; record 0
	dw IntroCutsceneNinaRallyUpdate_6b ; record 1
	dw IntroCutsceneNinaRallyExit_6b ; record 2
IntroCutsceneNinaSwing_6b:
	; $40f9, 6 bytes (records:2)
	dw IntroCutsceneNinaSwingInit_6b ; record 0
	dw IntroCutsceneNinaSwingUpdate_6b ; record 1
	dw IntroCutsceneNinaSwingExit_6b ; record 2
IntroCutsceneBothRally_6b:
	; $40ff, 6 bytes (records:2)
	dw IntroCutsceneBothRallyInit_6b ; record 0
	dw IntroCutsceneBothRallyUpdate_6b ; record 1
	dw IntroCutsceneBothRallyExit_6b ; record 2
IntroCutsceneRallyFadeOut_6b:
	; $4105, 6 bytes (records:2)
	dw IntroCutsceneRallyFadeOutInit_6b ; record 0
	dw IntroCutsceneRallyFadeOutUpdate_6b ; record 1
	dw IntroCutsceneRallyFadeOutExit_6b ; record 2
IntroCutsceneOpponentsPan_6b:
	; $410b, 6 bytes (records:2)
	dw IntroCutsceneOpponentsPanInit_6b ; record 0
	dw IntroCutsceneOpponentsPanUpdate_6b ; record 1
	dw IntroCutsceneOpponentsPanExit_6b ; record 2
IntroCutsceneWave_6b:
	; $4111, 6 bytes (records:2)
	dw IntroCutsceneWaveInit_6b ; record 0
	dw IntroCutsceneWaveUpdate_6b ; record 1
	dw IntroCutsceneWaveExit_6b ; record 2
IntroCutsceneDive_6b:
	; $4117, 6 bytes (records:2)
	dw IntroCutsceneDiveInit_6b ; record 0
	dw IntroCutsceneDiveUpdate_6b ; record 1
	dw IntroCutsceneDiveExit_6b ; record 2
IntroCutsceneGirlSwing_6b:
	; $411d, 6 bytes (records:2)
	dw IntroCutsceneGirlSwingInit_6b ; record 0
	dw IntroCutsceneGirlSwingUpdate_6b ; record 1
	dw IntroCutsceneGirlSwingExit_6b ; record 2
Unused_6b_IntroCutsceneStateA:
	; $4123, 6 bytes (records:2)
	dw Unused_6b_IntroCutsceneStateAInit ; record 0
	dw Unused_6b_IntroCutsceneStateAUpdate ; record 1
	dw Unused_6b_IntroCutsceneStateAExit ; record 2
Unused_6b_IntroCutsceneStateB:
	; $4129, 6 bytes (records:2)
	dw Unused_6b_IntroCutsceneStateBInit ; record 0
	dw Unused_6b_IntroCutsceneStateBUpdate ; record 1
	dw Unused_6b_IntroCutsceneStateBExit ; record 2
IntroCutsceneOpponentsCaption_6b:
	; $412f, 6 bytes (records:2)
	dw IntroCutsceneOpponentsCaptionInit_6b ; record 0
	dw IntroCutsceneOpponentsCaptionUpdate_6b ; record 1
	dw IntroCutsceneOpponentsCaptionExit_6b ; record 2
IntroCutsceneEnd_6b:
	; $4135, 6 bytes (records:2)
	dw IntroCutsceneEndInit_6b ; record 0
	dw IntroCutsceneEndUpdate_6b ; record 1
	dw IntroCutsceneEndExit_6b ; record 2
IntroCutscenePause_6b:
	; $413b, 6 bytes (records:2)
	dw IntroCutscenePauseInit_6b ; record 0
	dw IntroCutscenePauseUpdate_6b ; record 1
	dw IntroCutscenePauseExit_6b ; record 2
IntroCutsceneGreatestPlayer_6b:
	; $4141, 6 bytes (records:2)
	dw IntroCutsceneGreatestPlayerInit_6b ; record 0
	dw IntroCutsceneGreatestPlayerUpdate_6b ; record 1
	dw IntroCutsceneGreatestPlayerExit_6b ; record 2
IntroCutsceneMarioReveal_6b:
	; $4147, 6 bytes (records:2)
	dw IntroCutsceneMarioRevealInit_6b ; record 0
	dw IntroCutsceneMarioRevealUpdate_6b ; record 1
	dw IntroCutsceneMarioRevealExit_6b ; record 2
IntroCutsceneMarioCloseupScroll_6b:
	; $414d, 6 bytes (records:2)
	dw IntroCutsceneMarioCloseupScrollInit_6b ; record 0
	dw IntroCutsceneMarioCloseupScrollUpdate_6b ; record 1
	dw IntroCutsceneMarioCloseupScrollExit_6b ; record 2
IntroCutsceneClosingToss_6b:
	; $4153, 6 bytes (records:2)
	dw IntroCutsceneClosingTossInit_6b ; record 0
	dw IntroCutsceneClosingTossUpdate_6b ; record 1
	dw IntroCutsceneClosingTossExit_6b ; record 2
Unused_6b_UpdateHandler:
	jp DispatchCutsceneStateInit.runUpdate ; $4159
IntroCutsceneEndExit_6b:
	jp DispatchCutsceneStateInit.nextState ; $415c
Unused_6b_ExitHandler:
	xor a ; $415f
	ld [wCutsceneStepTimer], a ; $4160
	jp DispatchCutsceneStateInit.nextState ; $4163
IntroCutsceneEndInit_6b:
	ld a, $01 ; $4166
	ld [wIntroCutsceneDone], a ; $4168
	jp DispatchCutsceneStateInit.runUpdate ; $416b
IntroCutsceneEndUpdate_6b:
	jp DispatchCutsceneStateInit.runUpdate ; $416e
IntroCutscenePauseInit_6b:
	xor a ; $4171
	ld [wCutsceneStepTimer], a ; $4172
	jp DispatchCutsceneStateInit.runUpdate ; $4175
IntroCutscenePauseExit_6b:
	xor a ; $4178
	ld [wCutsceneStepTimer], a ; $4179
	jp DispatchCutsceneStateInit.nextState ; $417c
IntroCutscenePauseUpdate_6b:
	ld a, [wCutsceneStepTimer] ; $417f
	inc a ; $4182
	ld [wCutsceneStepTimer], a ; $4183
	cp $0a ; $4186
	jp z, DispatchCutsceneStateInit.runExit ; $4188
	jp DispatchCutsceneStateInit.runUpdate ; $418b
IntroCutsceneOpeningTossInit_6b:
	call InitIntroOpeningToss ; $418e
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
	ld hl, wIntroBallY ; $41b6
	ld a, e ; $41b9
	ld [hl+], a ; $41ba
	ld [hl], d ; $41bb
	ld de, $0120 ; $41bc
	ld hl, wIntroCutsceneScrollY ; $41bf
	ld a, e ; $41c2
	ld [hl+], a ; $41c3
	ld [hl], d ; $41c4
	call EnableLCD ; $41c5
	script_fade_in 32 ; $41c8
	call WaitFadeEnd ; $41cd
	jp DispatchCutsceneStateInit.runUpdate ; $41d0
IntroCutsceneOpeningTossExit_6b:
	script_fade_out 10 ; $41d3
	call WaitFadeEnd ; $41d8
	call ClearFrameTasks ; $41db
	frame_task CheckIntroSkipInput ; $41de
	xor a ; $41e6
	ldh [hScrollX], a ; $41e7
	ldh [hScrollY], a ; $41e9
	ld [wCameraX], a ; $41eb
	ld [wCameraX + 1], a ; $41ee
	ld [wCameraY], a ; $41f1
	ld [wCameraY + 1], a ; $41f4
	jp DispatchCutsceneStateInit.nextState ; $41f7
	twin_named intro_cutscene_opening_toss_update, IntroCutsceneOpeningTossUpdate_6b ; $41fa
IntroCutsceneAlexRallyInit_6b:
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
	rect_size $20, $01 ; $4253
	farcall FillTilemapRect ; $4257
	pop_wram_bank ; $425a
	farcall QueueWram3MapToVRAM ; $425f
	wram_bank WRAM_STAGING ; $4262
	ld_slot hl, DataPtr_IntroAlexSwingTiles ; $4268
	ld de, wDecompBuffer ; $426b
	call DecompressDataFromBank ; $426e
	ld hl, wDecompBuffer ; $4271
	ld de, vTiles2 ; $4274
	ld c, 128 ; $4277
	call QueueVRAMCopy ; $4279
	ld hl, wDecompBufferHigh ; $427c
	ld de, vTiles1 ; $427f
	ld c, wDecompBufferHigh_SIZE / 16 ; $4282
	call QueueVRAMCopy ; $4284
	wram_bank WRAM_SCREEN ; $4287
	ld_slot hl, DataPtr_IntroAlexSwingTilemap ; $428d
	ld de, wIntroSwingTilemap ; $4290
	call DecompressDataFromBank ; $4293
	ld_slot hl, DataPtr_IntroAlexSwingAttrmap ; $4296
	ld de, wIntroSwingAttrmap ; $4299
	call DecompressDataFromBank ; $429c
	frame_task QueueIntroAlexSprite ; $429f
	call EnableLCD ; $42a7
	script_fade_in 64 ; $42aa
	jp DispatchCutsceneStateInit.runUpdate ; $42af
Unused_6b_IntroCutsceneAlexRallyPalettes:
	INCLUDE "data/engine/cutscenes/Unused_6b_IntroCutsceneAlexRallyPalettes.asm" ; $42b2, 64 bytes (palettes)
IntroCutsceneAlexRallyExit_6b:
	ld hl, QueueIntroAlexSprite ; $42f2
	call UnregisterFrameTask ; $42f5
	xor a ; $42f8
	ld [wCutsceneStepTimer], a ; $42f9
	ld [wCutsceneScrollX], a ; $42fc
	ldh [hScrollX], a ; $42ff
	jp DispatchCutsceneStateInit.nextState ; $4301
IntroCutsceneAlexRallyUpdate_6b:
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
	jp DispatchCutsceneStateInit.runUpdate ; $4320
.timerExpired:
	jp DispatchCutsceneStateInit.runExit ; $4323
IntroCutsceneAlexSwingInit_6b:
	push_wram_bank WRAM_SCREEN ; $4326
	ld hl, wIntroSwingTilemap + 4 * TILEMAP_WIDTH ; $432f
	ld de, vBGMap0 + 4 * TILEMAP_WIDTH ; $4332
	ld c, 5 * TILEMAP_WIDTH / 16 ; $4335
	call QueueVRAMCopy ; $4337
	ld hl, wIntroSwingAttrmap + 4 * TILEMAP_WIDTH ; $433a
	ld de, vBGMap0 + 4 * TILEMAP_WIDTH + VRAM_BANK1 ; $433d
	ld c, 5 * TILEMAP_WIDTH / 16 ; $4340
	call QueueVRAMCopy ; $4342
	call AdvanceFrame ; $4345
	ld hl, wIntroSwingTilemap + 9 * TILEMAP_WIDTH ; $4348
	ld de, vBGMap0 + 9 * TILEMAP_WIDTH ; $434b
	ld c, 5 * TILEMAP_WIDTH / 16 ; $434e
	call QueueVRAMCopy ; $4350
	ld hl, wIntroSwingAttrmap + 9 * TILEMAP_WIDTH ; $4353
	ld de, vBGMap0 + 9 * TILEMAP_WIDTH + VRAM_BANK1 ; $4356
	ld c, 5 * TILEMAP_WIDTH / 16 ; $4359
	call QueueVRAMCopy ; $435b
	pop_wram_bank ; $435e
	ld hl, IntroCutsceneAlexSwingInitPalette_6b ; $4363
	ld_bg_pals de, 0, 8 ; $4366
	call LoadPalettesImmediate ; $4369
	jp DispatchCutsceneStateInit.runUpdate ; $436c
IntroCutsceneAlexSwingInitPalette_6b:
	INCLUDE "data/engine/cutscenes/IntroCutsceneAlexSwingInitPalette_6b.asm" ; $436f, 64 bytes (palettes)
	twin_named intro_cutscene_alex_swing_exit, IntroCutsceneAlexSwingExit_6b ; $43af
IntroCutsceneAlexSwingUpdate_6b:
	ld a, [wCutsceneStepTimer] ; $43be
	inc a ; $43c1
	ld [wCutsceneStepTimer], a ; $43c2
	cp $1e ; $43c5
	jr z, .timerExpired ; $43c7
	jp DispatchCutsceneStateInit.runUpdate ; $43c9
.timerExpired:
	jp DispatchCutsceneStateInit.runExit ; $43cc
IntroCutsceneNinaRallyInit_6b:
	call DisableLCDSafely ; $43cf
	ld c, SCREENASSET_IntroRallies2 ; $43d2
	farcall LoadScreenAssetRecord ; $43d4
	push_wram_bank WRAM_SCREEN ; $43d7
	ld h, $8a ; $43e0
	ld de, wShadowAttrmap + 11 * TILEMAP_WIDTH ; $43e2
	rect_size $20, $01 ; $43e5
	farcall FillTilemapRect ; $43e9
	pop_wram_bank ; $43ec
	farcall QueueWram3MapToVRAM ; $43f1
	wram_bank WRAM_STAGING ; $43f4
	ld_slot hl, DataPtr_IntroNinaSwingTiles ; $43fa
	ld de, wDecompBuffer ; $43fd
	call DecompressDataFromBank ; $4400
	ld hl, wDecompBuffer ; $4403
	ld de, vTiles2 ; $4406
	ld c, 128 ; $4409
	call QueueVRAMCopy ; $440b
	ld hl, wDecompBufferHigh ; $440e
	ld de, vTiles1 ; $4411
	ld c, wDecompBufferHigh_SIZE / 16 ; $4414
	call QueueVRAMCopy ; $4416
	wram_bank WRAM_SCREEN ; $4419
	ld_slot hl, DataPtr_IntroNinaSwingTilemap ; $441f
	ld de, wIntroSwingTilemap ; $4422
	call DecompressDataFromBank ; $4425
	ld_slot hl, DataPtr_IntroNinaSwingAttrmap ; $4428
	ld de, wIntroSwingAttrmap ; $442b
	call DecompressDataFromBank ; $442e
	frame_task QueueIntroNinaSprite ; $4431
	ld a, $a0 ; $4439
	ld [wCutsceneSpriteBX], a ; $443b
	ld a, $28 ; $443e
	ld [wCutsceneSpriteBY], a ; $4440
	xor a ; $4443
	ld [wCutsceneReverseScrollX], a ; $4444
	call EnableLCD ; $4447
	script_fade_in 127 ; $444a
	call WaitFadeEnd ; $444f
	jp DispatchCutsceneStateInit.runUpdate ; $4452
IntroCutsceneNinaRallyExit_6b:
	ld hl, QueueIntroNinaSprite ; $4455
	call UnregisterFrameTask ; $4458
	xor a ; $445b
	ld [wCutsceneStepTimer], a ; $445c
	ld [wCutsceneReverseScrollX], a ; $445f
	ldh [hScrollX], a ; $4462
	jp DispatchCutsceneStateInit.nextState ; $4464
IntroCutsceneNinaRallyUpdate_6b:
	ld a, [wCutsceneStepTimer] ; $4467
	inc a ; $446a
	ld [wCutsceneStepTimer], a ; $446b
	cp $7d ; $446e
	jp z, DispatchCutsceneStateInit.runExit ; $4470
	ld a, [wCutsceneReverseScrollX] ; $4473
	sub $03 ; $4476
	ld [wCutsceneReverseScrollX], a ; $4478
	ldh [hScrollX], a ; $447b
	ld a, [wCutsceneSpriteBX] ; $447d
	dec a ; $4480
	ld [wCutsceneSpriteBX], a ; $4481
	jp DispatchCutsceneStateInit.runUpdate ; $4484
IntroCutsceneNinaSwingInit_6b:
	push_wram_bank WRAM_SCREEN ; $4487
	ld hl, wIntroSwingTilemap + 4 * TILEMAP_WIDTH ; $4490
	ld de, vBGMap0 + 4 * TILEMAP_WIDTH ; $4493
	ld c, 5 * TILEMAP_WIDTH / 16 ; $4496
	call QueueVRAMCopy ; $4498
	ld hl, wIntroSwingAttrmap + 4 * TILEMAP_WIDTH ; $449b
	ld de, vBGMap0 + 4 * TILEMAP_WIDTH + VRAM_BANK1 ; $449e
	ld c, 5 * TILEMAP_WIDTH / 16 ; $44a1
	call QueueVRAMCopy ; $44a3
	call AdvanceFrame ; $44a6
	ld hl, wIntroSwingTilemap + 9 * TILEMAP_WIDTH ; $44a9
	ld de, vBGMap0 + 9 * TILEMAP_WIDTH ; $44ac
	ld c, 5 * TILEMAP_WIDTH / 16 ; $44af
	call QueueVRAMCopy ; $44b1
	ld hl, wIntroSwingAttrmap + 9 * TILEMAP_WIDTH ; $44b4
	ld de, vBGMap0 + 9 * TILEMAP_WIDTH + VRAM_BANK1 ; $44b7
	ld c, 5 * TILEMAP_WIDTH / 16 ; $44ba
	call QueueVRAMCopy ; $44bc
	pop_wram_bank ; $44bf
	ld hl, IntroCutsceneNinaSwingInitPalettes ; $44c4
	ld_bg_pals de, 0, 8 ; $44c7
	call LoadPalettesImmediate ; $44ca
	jp DispatchCutsceneStateInit.runUpdate ; $44cd
IntroCutsceneNinaSwingInitPalettes:
	INCLUDE "data/engine/cutscenes/IntroCutsceneNinaSwingInitPalettes.asm" ; $44d0, 64 bytes (palettes)
	twin_named intro_cutscene_alex_swing_exit, IntroCutsceneNinaSwingExit_6b ; $4510
IntroCutsceneNinaSwingUpdate_6b:
	ld a, [wCutsceneStepTimer] ; $451f
	inc a ; $4522
	ld [wCutsceneStepTimer], a ; $4523
	cp $1e ; $4526
	jp z, DispatchCutsceneStateInit.runExit ; $4528
	jp DispatchCutsceneStateInit.runUpdate ; $452b
IntroCutsceneBothRallyInit_6b:
	call DisableLCDSafely ; $452e
	ld c, SCREENASSET_IntroRallies3 ; $4531
	farcall LoadScreenAssetRecord ; $4533
	push_wram_bank WRAM_SCREEN ; $4536
	ld h, $8a ; $453f
	ld de, wShadowAttrmap + 8 * TILEMAP_WIDTH ; $4541
	rect_size $20, $01 ; $4544
	farcall FillTilemapRect ; $4548
	ld h, $8a ; $454b
	ld de, wShadowAttrmap + 14 * TILEMAP_WIDTH ; $454d
	rect_size $20, $01 ; $4550
	farcall FillTilemapRect ; $4554
	pop_wram_bank ; $4557
	farcall QueueWram3MapToVRAM ; $455c
	ld c, SCREENASSET_IntroRallies4 ; $455f
	farcall LoadScreenAssetRecord ; $4561
	ld a, STAT_MODE_0 ; $4564
	ldh [rSTAT], a ; $4566
	ld hl, rIE ; $4568
	set B_IE_STAT, [hl] ; $456b
	ld a, $44 ; $456d
	ld [wRasterScrollStartLY], a ; $456f
	ld a, $78 ; $4572
	ld [wRasterScrollEndLY], a ; $4574
	xor a ; $4577
	ld [wRasterScrollX], a ; $4578
	frame_task UpdateCutsceneScroll ; $457b
	ld a, $a0 ; $4583
	ld [wCutsceneSpriteBX], a ; $4585
	ld a, $40 ; $4588
	ld [wCutsceneSpriteBY], a ; $458a
	ld a, $c0 ; $458d
	ld [wCutsceneSpriteAX], a ; $458f
	ld a, $10 ; $4592
	ld [wCutsceneSpriteAY], a ; $4594
	frame_task QueueIntroAlexSprite ; $4597
	frame_task QueueIntroNinaSprite ; $459f
	call EnableLCD ; $45a7
	script_fade_in 16 ; $45aa
	call WaitFadeEnd ; $45af
	jp DispatchCutsceneStateInit.runUpdate ; $45b2
IntroCutsceneBothRallyExit_6b:
	ld hl, rIE ; $45b5
	res B_IE_STAT, [hl] ; $45b8
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
	ld hl, QueueIntroAlexSprite ; $45de
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
	ld hl, QueueIntroNinaSprite ; $4614
	call UnregisterFrameTask ; $4617
	call AdvanceFrame ; $461a
	jp DispatchCutsceneStateInit.nextState ; $461d
IntroCutsceneBothRallyUpdate_6b:
	ld a, [wCutsceneStepTimer] ; $4620
	inc a ; $4623
	ld [wCutsceneStepTimer], a ; $4624
	cp $60 ; $4627
	jp z, DispatchCutsceneStateInit.runExit ; $4629
	ld a, [wCutsceneSpriteAX] ; $462c
	inc a ; $462f
	ld [wCutsceneSpriteAX], a ; $4630
	ld a, [wCutsceneSpriteBX] ; $4633
	dec a ; $4636
	ld [wCutsceneSpriteBX], a ; $4637
	jp DispatchCutsceneStateInit.runUpdate ; $463a
IntroCutsceneRallyFadeOutInit_6b:
	xor a ; $463d
	ld [wCutsceneStepTimer], a ; $463e
	jp DispatchCutsceneStateInit.runUpdate ; $4641
IntroCutsceneRallyFadeOutExit_6b:
	script_fade_out 16 ; $4644
	call WaitFadeEnd ; $4649
	jp DispatchCutsceneStateInit.nextState ; $464c
	twin_named intro_cutscene_rally_fade_out_update, IntroCutsceneRallyFadeOutUpdate_6b ; $464f
IntroCutsceneOpponentsPanInit_6b:
	call InitIntroOpponentsPanorama ; $465e
	call LoadIntroAwesomeOpponentsCaption ; $4661
	xor a ; $4664
	ld [wCutsceneStepTimer], a ; $4665
	ld [wCutsceneSpriteAX], a ; $4668
	ld [wCutsceneSpriteAY], a ; $466b
	ld [wCutsceneSpriteBX], a ; $466e
	ld [wCutsceneSpriteBY], a ; $4671
	call EnableLCD ; $4674
	script_fade_in 8 ; $4677
	call WaitFadeEnd ; $467c
	frame_task IntroSequenceTimerTask ; $467f
	jp DispatchCutsceneStateInit.runUpdate ; $4687
IntroCutsceneOpponentsPanExit_6b:
	call ClearFrameTasks ; $468a
	frame_task CheckIntroSkipInput ; $468d
	xor a ; $4695
	ldh [hScrollX], a ; $4696
	ldh [hScrollY], a ; $4698
	ld [wCameraX], a ; $469a
	ld [wCameraX + 1], a ; $469d
	ld [wCameraY], a ; $46a0
	ld [wCameraY + 1], a ; $46a3
	jp DispatchCutsceneStateInit.nextState ; $46a6
IntroCutsceneOpponentsPanUpdate_6b:
	ld a, [wCameraX + 1] ; $46a9
	cp $40 ; $46ac
	jp nz, .checkCutsceneStepTimer ; $46ae
	ld a, [wCutsceneStepTimer] ; $46b1
	inc a ; $46b4
	ld [wCutsceneStepTimer], a ; $46b5
	cp $29 ; $46b8
	jp z, DispatchCutsceneStateInit.runExit ; $46ba
	jp DispatchCutsceneStateInit.runUpdate ; $46bd
.checkCutsceneStepTimer:
	ld a, [wCutsceneStepTimer] ; $46c0
	cp $01 ; $46c3
	jr z, .scrollCamera ; $46c5
	inc a ; $46c7
	ld [wCutsceneStepTimer], a ; $46c8
	jp DispatchCutsceneStateInit.runUpdate ; $46cb
.scrollCamera:
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
	jp DispatchCutsceneStateInit.runUpdate ; $46e2
IntroCutsceneOpponentsCaptionInit_6b:
	xor a ; $46e5
	ldh [hScrollY], a ; $46e6
	ldh [hScrollX], a ; $46e8
	ld [wCutsceneStepTimer], a ; $46ea
	push_wram_bank WRAM_TEXT ; $46ed
	ld hl, IntroCutsceneOpponentsCaptionInitPalettes_6b ; $46f6
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
	jp DispatchCutsceneStateInit.runUpdate ; $4736
IntroCutsceneOpponentsCaptionExit_6b:
	script_fade_out 16 ; $4739
	call WaitFadeEnd ; $473e
	call DisableLCDSafely ; $4741
	xor a ; $4744
	ld [wCutsceneStepTimer], a ; $4745
	jp DispatchCutsceneStateInit.nextState ; $4748
	twin_named intro_cutscene_rally_fade_out_update, IntroCutsceneOpponentsCaptionUpdate_6b ; $474b
IntroCutsceneOpponentsCaptionInitPalettes_6b:
	INCLUDE "data/engine/cutscenes/IntroCutsceneOpponentsCaptionInitPalettes_6b.asm" ; $475a, 64 bytes (palettes)
IntroCutsceneWaveInit_6b:
	call DisableLCDSafely ; $479a
	ld c, SCREENASSET_IntroWave ; $479d
	farcall LoadScreenAssetRecord ; $479f
	farcall QueueWram3MapToVRAM ; $47a2
	xor a ; $47a5
	ld [wCutsceneStepTimer], a ; $47a6
	ld a, $b0 ; $47a9
	ld [wCutsceneScrollX], a ; $47ab
	frame_task ScrollCutsceneXRightTask ; $47ae
	call EnableLCD ; $47b6
	script_fade_in 16 ; $47b9
	call WaitFadeEnd ; $47be
	jp DispatchCutsceneStateInit.runUpdate ; $47c1
IntroCutsceneWaveExit_6b:
	script_fade_out 10 ; $47c4
	call WaitFadeEnd ; $47c9
	ld hl, ScrollCutsceneXRightTask ; $47cc
	call UnregisterFrameTask ; $47cf
	xor a ; $47d2
	ldh [hScrollX], a ; $47d3
	jp DispatchCutsceneStateInit.nextState ; $47d5
IntroCutsceneWaveUpdate_6b:
	ld a, [wCutsceneStepTimer] ; $47d8
	inc a ; $47db
	ld [wCutsceneStepTimer], a ; $47dc
	cp $2c ; $47df
	jp z, DispatchCutsceneStateInit.runExit ; $47e1
	jp DispatchCutsceneStateInit.runUpdate ; $47e4
IntroCutsceneDiveInit_6b:
	call DisableLCDSafely ; $47e7
	ld c, SCREENASSET_IntroDive ; $47ea
	farcall LoadScreenAssetRecord ; $47ec
	farcall QueueWram3MapToVRAM ; $47ef
	ld a, $94 ; $47f2
	ld [wCutsceneScrollX], a ; $47f4
	ldh [hScrollX], a ; $47f7
	xor a ; $47f9
	ld [wCutsceneStepTimer], a ; $47fa
	frame_task ScrollCutsceneXLeftTask ; $47fd
	call EnableLCD ; $4805
	script_fade_in 16 ; $4808
	call WaitFadeEnd ; $480d
	jp DispatchCutsceneStateInit.runUpdate ; $4810
IntroCutsceneDiveExit_6b:
	script_fade_out 10 ; $4813
	call WaitFadeEnd ; $4818
	ld hl, ScrollCutsceneXLeftTask ; $481b
	call UnregisterFrameTask ; $481e
	xor a ; $4821
	ldh [hScrollX], a ; $4822
	jp DispatchCutsceneStateInit.nextState ; $4824
	twin_named intro_cutscene_dive_update, IntroCutsceneDiveUpdate_6b ; $4827
IntroCutsceneGirlSwingInit_6b:
	call DisableLCDSafely ; $4836
	ld c, SCREENASSET_IntroGirlSwing ; $4839
	farcall LoadScreenAssetRecord ; $483b
	farcall QueueWram3MapToVRAM ; $483e
	ld a, $a8 ; $4841
	ld [wCutsceneScrollX], a ; $4843
	ldh [hScrollX], a ; $4846
	xor a ; $4848
	ld [wCutsceneStepTimer], a ; $4849
	frame_task ScrollCutsceneLeftTask ; $484c
	call EnableLCD ; $4854
	script_fade_in 16 ; $4857
	call WaitFadeEnd ; $485c
	jp DispatchCutsceneStateInit.runUpdate ; $485f
IntroCutsceneGirlSwingExit_6b:
	script_fade_out 10 ; $4862
	call WaitFadeEnd ; $4867
	ld hl, ScrollCutsceneLeftTask ; $486a
	call UnregisterFrameTask ; $486d
	xor a ; $4870
	ldh [hScrollX], a ; $4871
	jp DispatchCutsceneStateInit.nextState ; $4873
	twin_named intro_cutscene_dive_update, IntroCutsceneGirlSwingUpdate_6b ; $4876
Unused_6b_IntroCutsceneStateAInit:
	call DisableLCDSafely ; $4885
	ld c, SCREENASSET_LoadIntroAwesomeOpponentsCaptionPtrs ; $4888
	farcall LoadScreenAssetRecord ; $488a
	ld a, BGVIEW_DEBUG_CONSOLE ; $488d
	ldh [hBGViewMode], a ; $488f
	ld hl, rLCDC ; $4891
	set B_LCDC_BG_MAP, [hl] ; $4894
	wram_bank WRAM_SCREEN ; $4896
	ld hl, wShadowTilemap ; $489c
	ld de, vBGMap1 ; $489f
	ld c, TILEMAP_AREA / 16 ; $48a2
	call QueueVRAMCopy ; $48a4
	ld hl, wShadowAttrmap ; $48a7
	ld de, vBGMap1 + VRAM_BANK1 ; $48aa
	ld c, TILEMAP_AREA / 16 ; $48ad
	call QueueVRAMCopy ; $48af
	call Unused_6b_InitIntroOpeningTossNoPalette ; $48b2
	call LoadIntroTilesAndPalette ; $48b5
	call EnableLCD ; $48b8
	script_fade_in 32 ; $48bb
	call WaitFadeEnd ; $48c0
	xor a ; $48c3
	ld [wCutsceneStepTimer], a ; $48c4
	jp DispatchCutsceneStateInit.runUpdate ; $48c7
Unused_6b_IntroCutsceneStateAExit:
	ld a, BGVIEW_NORMAL ; $48ca
	ldh [hBGViewMode], a ; $48cc
	ld hl, rLCDC ; $48ce
	res B_LCDC_BG_MAP, [hl] ; $48d1
	ld hl, IntroBallTossPalettes ; $48d3
	ld_bg_pals de, 0, 8 ; $48d6
	call LoadPaletteShadow ; $48d9
	xor a ; $48dc
	ld [wCutsceneStepTimer], a ; $48dd
	jp DispatchCutsceneStateInit.nextState ; $48e0
Unused_6b_IntroCutsceneStateAUpdate:
	ld a, [wCutsceneStepTimer] ; $48e3
	inc a ; $48e6
	ld [wCutsceneStepTimer], a ; $48e7
	cp $70 ; $48ea
	jp z, DispatchCutsceneStateInit.runExit ; $48ec
	jp DispatchCutsceneStateInit.runUpdate ; $48ef
Unused_6b_IntroCutsceneStateBInit:
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
	ld hl, wIntroBallY ; $490d
	ld a, e ; $4910
	ld [hl+], a ; $4911
	ld [hl], d ; $4912
	ld de, $0120 ; $4913
	ld hl, wIntroCutsceneScrollY ; $4916
	ld a, e ; $4919
	ld [hl+], a ; $491a
	ld [hl], d ; $491b
	jp DispatchCutsceneStateInit.runUpdate ; $491c
Unused_6b_IntroCutsceneStateBExit:
	script_fade_out 4 ; $491f
	call WaitFadeEnd ; $4924
	jp DispatchCutsceneStateInit.nextState ; $4927
Unused_6b_IntroCutsceneStateBUpdate:
	ld a, [wCutsceneSpriteAY] ; $492a
	cp $0a ; $492d
	jr z, .checkCutsceneStepTimer ; $492f
	inc a ; $4931
	ld [wCutsceneSpriteAY], a ; $4932
	call QueueIntroSpinningBall ; $4935
	jp DispatchCutsceneStateInit.runUpdate ; $4938
.checkCutsceneStepTimer:
	ld a, [wCutsceneStepTimer] ; $493b
	inc a ; $493e
	ld [wCutsceneStepTimer], a ; $493f
	cp $80 ; $4942
	jp z, DispatchCutsceneStateInit.runExit ; $4944
	cp $64 ; $4947
	jr nc, .updateBallY ; $4949
	call AdvanceIntroBallSpinFrame ; $494b
.updateBallY:
	call UpdateIntroBallY ; $494e
	call UpdateIntroScrollY ; $4951
	call SetCameraYFromScrollPos ; $4954
	call QueueIntroSpinningBall ; $4957
	call QueueCutsceneAnimatedSprites ; $495a
	jp DispatchCutsceneStateInit.runUpdate ; $495d
IntroCutsceneGreatestPlayerInit_6b:
	call DisableLCDSafely ; $4960
	call InitIntroClosingToss ; $4963
	call LoadIntroTilesAndPalette ; $4966
	ld a, BGVIEW_KEEP_MAP ; $4969
	ldh [hBGViewMode], a ; $496b
	ld hl, rLCDC ; $496d
	set B_LCDC_BG_MAP, [hl] ; $4970
	wram_bank WRAM_STAGING ; $4972
	ld_slot hl, DataPtr_IntroGreatestPlayerTiles ; $4978
	ld de, wDecompBuffer ; $497b
	call DecompressDataFromBank ; $497e
	ld hl, wDecompBuffer ; $4981
	ld de, vTiles2 ; $4984
	ld c, 128 ; $4987
	call QueueVRAMCopy ; $4989
	ld hl, wDecompBufferHigh ; $498c
	ld de, vTiles1 ; $498f
	ld c, wDecompBufferHigh_SIZE / 16 ; $4992
	call QueueVRAMCopy ; $4994
	ld_slot hl, DataPtr_IntroGreatestPlayerTilemap ; $4997
	ld de, wDecompBuffer ; $499a
	call DecompressDataFromBank ; $499d
	ld_slot hl, DataPtr_IntroGreatestPlayerAttrmap ; $49a0
	ld de, wDecompBuffer + TILEMAP_AREA ; $49a3
	call DecompressDataFromBank ; $49a6
	ld hl, wDecompBuffer ; $49a9
	ld de, vBGMap1 ; $49ac
	ld c, TILEMAP_AREA / 16 ; $49af
	call QueueVRAMCopy ; $49b1
	ld hl, wDecompBuffer + TILEMAP_AREA ; $49b4
	ld de, vBGMap1 + VRAM_BANK1 ; $49b7
	ld c, TILEMAP_AREA / 16 ; $49ba
	call QueueVRAMCopy ; $49bc
	ld hl, IntroCutsceneGreatestPlayerInitPalettes_6b ; $49bf
	ld_bg_pals de, 0, 8 ; $49c2
	call LoadPaletteShadow ; $49c5
	wram_bank WRAM_STAGING ; $49c8
	ld_slot hl, DataPtr_IntroMarioTiles ; $49ce
	ld de, wDecompBuffer ; $49d1
	call DecompressDataFromBank ; $49d4
	ld hl, wDecompBuffer ; $49d7
	ld de, vTiles2 + VRAM_BANK1 ; $49da
	ld c, 128 ; $49dd
	call QueueVRAMCopy ; $49df
	ld hl, wDecompBufferHigh ; $49e2
	ld de, vTiles1 + VRAM_BANK1 ; $49e5
	ld c, wDecompBufferHigh_SIZE / 16 ; $49e8
	call QueueVRAMCopy ; $49ea
	wram_bank WRAM_ACTORS ; $49ed
	ld_slot hl, DataPtr_IntroMarioTilemap ; $49f3
	ld de, wIntroMarioTilemap ; $49f6
	call DecompressDataFromBank ; $49f9
	ld_slot hl, DataPtr_IntroMarioAttrmap ; $49fc
	ld de, wIntroMarioAttrmap ; $49ff
	call DecompressDataFromBank ; $4a02
	wram_bank WRAM_TEXT ; $4a05
	ld_slot hl, DataPtr_IntroMarioTilemap2 ; $4a0b
	ld de, wWindowShadowTilemap ; $4a0e
	call DecompressDataFromBank ; $4a11
	ld_slot hl, DataPtr_IntroMarioAttrmap2 ; $4a14
	ld de, wWindowShadowAttrmap ; $4a17
	call DecompressDataFromBank ; $4a1a
	wram_bank WRAM_STAGING ; $4a1d
	ld hl, IntroBallTossTiles ; $4a23
	ld de, wDecompBuffer ; $4a26
	call DecompressData ; $4a29
	xor a ; $4a2c
	ldh [hScrollX], a ; $4a2d
	ldh [hScrollY], a ; $4a2f
	ld [wCutsceneStepTimer], a ; $4a31
	call EnableLCD ; $4a34
	script_fade_in 8 ; $4a37
	call WaitFadeEnd ; $4a3c
	jp DispatchCutsceneStateInit.runUpdate ; $4a3f
