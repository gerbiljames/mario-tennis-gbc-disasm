SECTION "ROM Bank $6b", ROMX[$4000], BANK[$6b]

	farptr RunIntroCutscene ; $4000
	farptr RunTitleScreen ; $4002
DataPtr_TitleScreenTilemap:
	dw TitleScreenTilemap ; $4004
DataPtr_TitleScreenAttrmap:
	dw TitleScreenAttrmap ; $4006
DataPtr_TitleScreenPalettes:
	dw TitleScreenPalettes ; $4008
	farptr DecompressIntroTitleTiles ; $400a
	farptr DecompressIntroTitleTilesAlias1, DecompressIntroTitleTiles ; $400c
	farptr DecompressIntroTitleTilesAlias2, DecompressIntroTitleTiles ; $400e
	farptr DecompressIntroTitleTilesAlias3, DecompressIntroTitleTiles ; $4010
	farptr ShowIntroLogoScreen ; $4012
	farptr ScrollOutIntroLogo ; $4014
	farptr LoadIntroTilesAndPalette ; $4016
	farptr QueueIntroSpriteBlock ; $4018
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
RunIntroCutscene:
	xor a, a ; $402a
	ld [wCutsceneStep], a ; $402b
	ld [wCutsceneStepTimer], a ; $402e
	ld [wIntroCutsceneCheck], a ; $4031
	ld [wCutsceneScrollX], a ; $4034
	ld [$cb43], a ; $4037
	ldh [hShowDebugConsole], a ; $403a
	ld hl, rLCDC ; $403c
	res 3, [hl] ; $403f
	sound $01 ; $4041
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
	xor a, a ; $405e
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
	or a, a ; $407f
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
	or a, a ; $40b9
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
	dw IntroCutsceneState11Init_6b ; record 0
	dw IntroCutsceneState11Update_6b ; record 1
	dw IntroCutsceneState11Exit_6b ; record 2
IntroCutsceneState12_6b:
	; $4129, 6 bytes (records:2)
	dw IntroCutsceneState12Init_6b ; record 0
	dw IntroCutsceneState12Update_6b ; record 1
	dw IntroCutsceneState12Exit_6b ; record 2
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
Unused_6b_UpdateHandler_4159:
	jp DispatchCutsceneStateInit.loop ; $4159
IntroCutsceneState14Exit_6b:
	jp DispatchCutsceneStateInit.loop2 ; $415c
Unused_6b_ExitHandler_415f:
	xor a, a ; $415f
	ld [wCutsceneStepTimer], a ; $4160
	jp DispatchCutsceneStateInit.loop2 ; $4163
IntroCutsceneState14Init_6b:
	ld a, $01 ; $4166
	ld [wIntroCutsceneCheck], a ; $4168
	jp DispatchCutsceneStateInit.loop ; $416b
IntroCutsceneState14Update_6b:
	jp DispatchCutsceneStateInit.loop ; $416e
IntroCutsceneState15Init_6b:
	xor a, a ; $4171
	ld [wCutsceneStepTimer], a ; $4172
	jp DispatchCutsceneStateInit.loop ; $4175
IntroCutsceneState15Exit_6b:
	xor a, a ; $4178
	ld [wCutsceneStepTimer], a ; $4179
	jp DispatchCutsceneStateInit.loop2 ; $417c
IntroCutsceneState15Update_6b:
	ld a, [wCutsceneStepTimer] ; $417f
	inc a ; $4182
	ld [wCutsceneStepTimer], a ; $4183
	cp a, $0a ; $4186
	jp z, DispatchCutsceneStateInit.loopB ; $4188
	jp DispatchCutsceneStateInit.loop ; $418b
IntroCutsceneState00Init_6b:
	call InitCutsceneSceneC ; $418e
	call LoadIntroTilesAndPalette ; $4191
	xor a, a ; $4194
	ld [wCameraY], a ; $4195
	ld a, $24 ; $4198
	ld [wCameraY + 1], a ; $419a
	xor a, a ; $419d
	ld [wCutsceneStepTimer], a ; $419e
	ld [$cb4c], a ; $41a1
	ld [$cb44], a ; $41a4
	ld [$cb4d], a ; $41a7
	xor a, a ; $41aa
	ld [wCameraY], a ; $41ab
	ld a, $24 ; $41ae
	ld [wCameraY + 1], a ; $41b0
	ld de, $015c ; $41b3
	ld hl, $cb48 ; $41b6
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
	xor a, a ; $41e6
	ldh [hScrollX], a ; $41e7
	ldh [hScrollY], a ; $41e9
	ld [wCameraX], a ; $41eb
	ld [wCameraX + 1], a ; $41ee
	ld [wCameraY], a ; $41f1
	ld [wCameraY + 1], a ; $41f4
	jp DispatchCutsceneStateInit.loop2 ; $41f7
IntroCutsceneState00Update_6b:
	ld a, [wCutsceneStepTimer] ; $41fa
	inc a ; $41fd
	ld [wCutsceneStepTimer], a ; $41fe
	cp a, $80 ; $4201
	jp z, DispatchCutsceneStateInit.loopB ; $4203
	cp a, $64 ; $4206
	jr nc, .updateCutsceneScrollY ; $4208
	call AdvanceSpriteAnimTimer ; $420a
.updateCutsceneScrollY:
	call UpdateCutsceneScrollY ; $420d
	call UpdateCutsceneScrollX ; $4210
	call SetCameraYFromScrollPos ; $4213
	call QueueScrollingSprite ; $4216
	call QueueCutsceneAnimatedSprites ; $4219
	jp DispatchCutsceneStateInit.loop ; $421c
IntroCutsceneState01Init_6b:
	call DisableLCDSafely ; $421f
	xor a, a ; $4222
	ld [wCutsceneScrollX], a ; $4223
	ld [wCutsceneStepTimer], a ; $4226
	ld a, $d0 ; $4229
	ld [$cb44], a ; $422b
	ld a, $28 ; $422e
	ld [$cb45], a ; $4230
	ld a, $30 ; $4233
	ld [$cb46], a ; $4235
	ld a, $28 ; $4238
	ld [$cb47], a ; $423a
	ld c, $16 ; $423d
	farcall LoadScreenAssetRecord ; $423f
	call LoadCutsceneTileset ; $4242
	ldh a, [hWramBank] ; $4245
	push af ; $4247
	wram_bank $03 ; $4248
	ld h, $8a ; $424e
	ld de, $d560 ; $4250
	ld b, $20 ; $4253
	ld c, $01 ; $4255
	farcall FillTilemapRect ; $4257
	pop af ; $425a
	wram_bank ; $425b
	farcall QueueWram3MapToVRAM ; $425f
	wram_bank $01 ; $4262
	ld hl, IntroCutsceneState01InitGfx0 ; $4268 -> DataPtr_IntroSwingTiles
	ld de, $d000 ; $426b
	call DecompressDataFromBank ; $426e
	ld hl, $d000 ; $4271
	ld de, $9000 ; $4274
	ld c, $80 ; $4277
	call QueueVRAMCopy ; $4279
	ld hl, $d800 ; $427c
	ld de, $8800 ; $427f
	ld c, $80 ; $4282
	call QueueVRAMCopy ; $4284
	wram_bank $03 ; $4287
	ld hl, IntroCutsceneState01InitGfx1 ; $428d -> DataPtr_IntroSwingTilemap
	ld de, w3_d800 ; $4290
	call DecompressDataFromBank ; $4293
	ld hl, IntroCutsceneState01InitGfx2 ; $4296 -> DataPtr_IntroSwingAttrmap
	ld de, wRulesScreenAnimFrame ; $4299
	call DecompressDataFromBank ; $429c
	ld a, $01 ; $429f
	ld hl, QueueCutsceneSpriteGroupA ; $42a1
	call RegisterFrameTask ; $42a4
	call EnableLCD ; $42a7
	script_fade_in $40 ; $42aa
	jp DispatchCutsceneStateInit.loop ; $42af
Palettes_6b_42b2:
	INCLUDE "data/bank_06b/palettes_42b2.asm" ; $42b2, 64 bytes (palettes)
IntroCutsceneState01Exit_6b:
	ld hl, QueueCutsceneSpriteGroupA ; $42f2
	call UnregisterFrameTask ; $42f5
	xor a, a ; $42f8
	ld [wCutsceneStepTimer], a ; $42f9
	ld [wCutsceneScrollX], a ; $42fc
	ldh [hScrollX], a ; $42ff
	jp DispatchCutsceneStateInit.loop2 ; $4301
IntroCutsceneState01Update_6b:
	ld a, [wCutsceneScrollX] ; $4304
	add a, $03 ; $4307
	ld [wCutsceneScrollX], a ; $4309
	ldh [hScrollX], a ; $430c
	ld a, [wCutsceneStepTimer] ; $430e
	inc a ; $4311
	ld [wCutsceneStepTimer], a ; $4312
	cp a, $69 ; $4315
	jr z, .label_6b_4099 ; $4317
	ld a, [$cb44] ; $4319
	inc a ; $431c
	ld [$cb44], a ; $431d
	jp DispatchCutsceneStateInit.loop ; $4320
.label_6b_4099:
	jp DispatchCutsceneStateInit.loopB ; $4323
IntroCutsceneState02Init_6b:
	ldh a, [hWramBank] ; $4326
	push af ; $4328
	wram_bank $03 ; $4329
	ld hl, wShortTextBuffer ; $432f
	ld de, $9880 ; $4332
	ld c, $0a ; $4335
	call QueueVRAMCopy ; $4337
	ld hl, $dc80 ; $433a
	ld de, $b880 ; $433d
	ld c, $0a ; $4340
	call QueueVRAMCopy ; $4342
	call AdvanceFrame ; $4345
	ld hl, $d920 ; $4348
	ld de, $9920 ; $434b
	ld c, $0a ; $434e
	call QueueVRAMCopy ; $4350
	ld hl, $dd20 ; $4353
	ld de, $b920 ; $4356
	ld c, $0a ; $4359
	call QueueVRAMCopy ; $435b
	pop af ; $435e
	wram_bank ; $435f
	ld hl, Palette_6b_436f ; $4363
	ld de, $0008 ; $4366
	call LoadPalettesImmediate ; $4369
	jp DispatchCutsceneStateInit.loop ; $436c
Palette_6b_436f:
	INCLUDE "data/bank_06b/palettes_436f.asm" ; $436f, 64 bytes (palettes)
IntroCutsceneState02Exit_6b:
	ld c, $06 ; $43af
	call BeginFadeOut ; $43b1
	call WaitFadeEnd ; $43b4
	xor a, a ; $43b7
	ld [wCutsceneStepTimer], a ; $43b8
	jp DispatchCutsceneStateInit.loop2 ; $43bb
IntroCutsceneState02Update_6b:
	ld a, [wCutsceneStepTimer] ; $43be
	inc a ; $43c1
	ld [wCutsceneStepTimer], a ; $43c2
	cp a, $1e ; $43c5
	jr z, .label_6b_4099 ; $43c7
	jp DispatchCutsceneStateInit.loop ; $43c9
.label_6b_4099:
	jp DispatchCutsceneStateInit.loopB ; $43cc
IntroCutsceneState03Init_6b:
	call DisableLCDSafely ; $43cf
	ld c, $17 ; $43d2
	farcall LoadScreenAssetRecord ; $43d4
	ldh a, [hWramBank] ; $43d7
	push af ; $43d9
	wram_bank $03 ; $43da
	ld h, $8a ; $43e0
	ld de, $d560 ; $43e2
	ld b, $20 ; $43e5
	ld c, $01 ; $43e7
	farcall FillTilemapRect ; $43e9
	pop af ; $43ec
	wram_bank ; $43ed
	farcall QueueWram3MapToVRAM ; $43f1
	wram_bank $01 ; $43f4
	ld hl, IntroCutsceneState03InitGfx0 ; $43fa -> DataPtr_IntroCloseupTiles
	ld de, $d000 ; $43fd
	call DecompressDataFromBank ; $4400
	ld hl, $d000 ; $4403
	ld de, $9000 ; $4406
	ld c, $80 ; $4409
	call QueueVRAMCopy ; $440b
	ld hl, $d800 ; $440e
	ld de, $8800 ; $4411
	ld c, $80 ; $4414
	call QueueVRAMCopy ; $4416
	wram_bank $03 ; $4419
	ld hl, IntroCutsceneState03InitGfx1 ; $441f -> DataPtr_IntroCloseupTilemap
	ld de, w3_d800 ; $4422
	call DecompressDataFromBank ; $4425
	ld hl, IntroCutsceneState03InitGfx2 ; $4428 -> DataPtr_IntroCloseupAttrmap
	ld de, wRulesScreenAnimFrame ; $442b
	call DecompressDataFromBank ; $442e
	ld a, $01 ; $4431
	ld hl, QueueCutsceneSpriteGroupB ; $4433
	call RegisterFrameTask ; $4436
	ld a, $a0 ; $4439
	ld [$cb46], a ; $443b
	ld a, $28 ; $443e
	ld [$cb47], a ; $4440
	xor a, a ; $4443
	ld [$cb43], a ; $4444
	call EnableLCD ; $4447
	script_fade_in $7f ; $444a
	call WaitFadeEnd ; $444f
	jp DispatchCutsceneStateInit.loop ; $4452
IntroCutsceneState03Exit_6b:
	ld hl, QueueCutsceneSpriteGroupB ; $4455
	call UnregisterFrameTask ; $4458
	xor a, a ; $445b
	ld [wCutsceneStepTimer], a ; $445c
	ld [$cb43], a ; $445f
	ldh [hScrollX], a ; $4462
	jp DispatchCutsceneStateInit.loop2 ; $4464
IntroCutsceneState03Update_6b:
	ld a, [wCutsceneStepTimer] ; $4467
	inc a ; $446a
	ld [wCutsceneStepTimer], a ; $446b
	cp a, $7d ; $446e
	jp z, DispatchCutsceneStateInit.loopB ; $4470
	ld a, [$cb43] ; $4473
	sub a, $03 ; $4476
	ld [$cb43], a ; $4478
	ldh [hScrollX], a ; $447b
	ld a, [$cb46] ; $447d
	dec a ; $4480
	ld [$cb46], a ; $4481
	jp DispatchCutsceneStateInit.loop ; $4484
IntroCutsceneState04Init_6b:
	ldh a, [hWramBank] ; $4487
	push af ; $4489
	wram_bank $03 ; $448a
	ld hl, wShortTextBuffer ; $4490
	ld de, $9880 ; $4493
	ld c, $0a ; $4496
	call QueueVRAMCopy ; $4498
	ld hl, $dc80 ; $449b
	ld de, $b880 ; $449e
	ld c, $0a ; $44a1
	call QueueVRAMCopy ; $44a3
	call AdvanceFrame ; $44a6
	ld hl, $d920 ; $44a9
	ld de, $9920 ; $44ac
	ld c, $0a ; $44af
	call QueueVRAMCopy ; $44b1
	ld hl, $dd20 ; $44b4
	ld de, $b920 ; $44b7
	ld c, $0a ; $44ba
	call QueueVRAMCopy ; $44bc
	pop af ; $44bf
	wram_bank ; $44c0
	ld hl, IntroCutsceneState04InitPalettes ; $44c4
	ld de, $0008 ; $44c7
	call LoadPalettesImmediate ; $44ca
	jp DispatchCutsceneStateInit.loop ; $44cd
IntroCutsceneState04InitPalettes:
	INCLUDE "data/bank_06b/palettes_44d0.asm" ; $44d0, 64 bytes (palettes)
IntroCutsceneState04Exit_6b:
	ld c, $06 ; $4510
	call BeginFadeOut ; $4512
	call WaitFadeEnd ; $4515
	xor a, a ; $4518
	ld [wCutsceneStepTimer], a ; $4519
	jp DispatchCutsceneStateInit.loop2 ; $451c
IntroCutsceneState04Update_6b:
	ld a, [wCutsceneStepTimer] ; $451f
	inc a ; $4522
	ld [wCutsceneStepTimer], a ; $4523
	cp a, $1e ; $4526
	jp z, DispatchCutsceneStateInit.loopB ; $4528
	jp DispatchCutsceneStateInit.loop ; $452b
IntroCutsceneState05Init_6b:
	call DisableLCDSafely ; $452e
	ld c, $18 ; $4531
	farcall LoadScreenAssetRecord ; $4533
	ldh a, [hWramBank] ; $4536
	push af ; $4538
	wram_bank $03 ; $4539
	ld h, $8a ; $453f
	ld de, $d500 ; $4541
	ld b, $20 ; $4544
	ld c, $01 ; $4546
	farcall FillTilemapRect ; $4548
	ld h, $8a ; $454b
	ld de, $d5c0 ; $454d
	ld b, $20 ; $4550
	ld c, $01 ; $4552
	farcall FillTilemapRect ; $4554
	pop af ; $4557
	wram_bank ; $4558
	farcall QueueWram3MapToVRAM ; $455c
	ld c, $19 ; $455f
	farcall LoadScreenAssetRecord ; $4561
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
	ld hl, UpdateCutsceneScroll ; $457d
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
	ldh a, [hWramBank] ; $45ba
	push af ; $45bc
	wram_bank $03 ; $45bd
	ld hl, w3_d060 ; $45c3
	ld de, $9860 ; $45c6
	ld c, $0c ; $45c9
	call QueueVRAMCopy ; $45cb
	ld hl, $d460 ; $45ce
	ld de, $b860 ; $45d1
	ld c, $0c ; $45d4
	call QueueVRAMCopy ; $45d6
	pop af ; $45d9
	wram_bank ; $45da
	ld hl, QueueCutsceneSpriteGroupA ; $45de
	call UnregisterFrameTask ; $45e1
	ld hl, UpdateCutsceneScroll ; $45e4
	call UnregisterFrameTask ; $45e7
	xor a, a ; $45ea
	ldh [hScrollX], a ; $45eb
	call AdvanceFrame ; $45ed
	ldh a, [hWramBank] ; $45f0
	push af ; $45f2
	wram_bank $03 ; $45f3
	ld hl, $d120 ; $45f9
	ld de, $9920 ; $45fc
	ld c, $0c ; $45ff
	call QueueVRAMCopy ; $4601
	ld hl, $d520 ; $4604
	ld de, $b920 ; $4607
	ld c, $0c ; $460a
	call QueueVRAMCopy ; $460c
	pop af ; $460f
	wram_bank ; $4610
	ld hl, QueueCutsceneSpriteGroupB ; $4614
	call UnregisterFrameTask ; $4617
	call AdvanceFrame ; $461a
	jp DispatchCutsceneStateInit.loop2 ; $461d
IntroCutsceneState05Update_6b:
	ld a, [wCutsceneStepTimer] ; $4620
	inc a ; $4623
	ld [wCutsceneStepTimer], a ; $4624
	cp a, $60 ; $4627
	jp z, DispatchCutsceneStateInit.loopB ; $4629
	ld a, [$cb44] ; $462c
	inc a ; $462f
	ld [$cb44], a ; $4630
	ld a, [$cb46] ; $4633
	dec a ; $4636
	ld [$cb46], a ; $4637
	jp DispatchCutsceneStateInit.loop ; $463a
IntroCutsceneState06Init_6b:
	xor a, a ; $463d
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
	cp a, $64 ; $4656
	jp z, DispatchCutsceneStateInit.loopB ; $4658
	jp DispatchCutsceneStateInit.loop ; $465b
IntroCutsceneState07Init_6b:
	call InitTitleSceneGraphics ; $465e
	call DecompressIntroTitleTiles ; $4661
	xor a, a ; $4664
	ld [wCutsceneStepTimer], a ; $4665
	ld [$cb44], a ; $4668
	ld [$cb45], a ; $466b
	ld [$cb46], a ; $466e
	ld [$cb47], a ; $4671
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
	xor a, a ; $4695
	ldh [hScrollX], a ; $4696
	ldh [hScrollY], a ; $4698
	ld [wCameraX], a ; $469a
	ld [wCameraX + 1], a ; $469d
	ld [wCameraY], a ; $46a0
	ld [wCameraY + 1], a ; $46a3
	jp DispatchCutsceneStateInit.loop2 ; $46a6
IntroCutsceneState07Update_6b:
	ld a, [wCameraX + 1] ; $46a9
	cp a, $40 ; $46ac
	jp nz, .checkCutsceneStepTimer ; $46ae
	ld a, [wCutsceneStepTimer] ; $46b1
	inc a ; $46b4
	ld [wCutsceneStepTimer], a ; $46b5
	cp a, $29 ; $46b8
	jp z, DispatchCutsceneStateInit.loopB ; $46ba
	jp DispatchCutsceneStateInit.loop ; $46bd
.checkCutsceneStepTimer:
	ld a, [wCutsceneStepTimer] ; $46c0
	cp a, $01 ; $46c3
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
	xor a, a ; $46e5
	ldh [hScrollY], a ; $46e6
	ldh [hScrollX], a ; $46e8
	ld [wCutsceneStepTimer], a ; $46ea
	ldh a, [hWramBank] ; $46ed
	push af ; $46ef
	wram_bank $05 ; $46f0
	ld hl, Palettes_6b_475a ; $46f6
	ld de, $0008 ; $46f9
	call LoadPaletteShadow ; $46fc
	ld hl, $d0c0 ; $46ff
	ld de, $98c0 ; $4702
	ld c, $10 ; $4705
	call QueueVRAMCopy ; $4707
	ld hl, $d4c0 ; $470a
	ld de, $b8c0 ; $470d
	ld c, $10 ; $4710
	call QueueVRAMCopy ; $4712
	call AdvanceFrame ; $4715
	ld hl, $d080 ; $4718
	ld de, $9880 ; $471b
	ld c, $04 ; $471e
	call QueueVRAMCopy ; $4720
	ld hl, $d480 ; $4723
	ld de, $b880 ; $4726
	ld c, $04 ; $4729
	call QueueVRAMCopy ; $472b
	call AdvanceFrame ; $472e
	pop af ; $4731
	wram_bank ; $4732
	jp DispatchCutsceneStateInit.loop ; $4736
IntroCutsceneState13Exit_6b:
	ld c, $10 ; $4739
	call BeginFadeOut ; $473b
	call WaitFadeEnd ; $473e
	call DisableLCDSafely ; $4741
	xor a, a ; $4744
	ld [wCutsceneStepTimer], a ; $4745
	jp DispatchCutsceneStateInit.loop2 ; $4748
IntroCutsceneState13Update_6b:
	ld a, [wCutsceneStepTimer] ; $474b
	inc a ; $474e
	ld [wCutsceneStepTimer], a ; $474f
	cp a, $64 ; $4752
	jp z, DispatchCutsceneStateInit.loopB ; $4754
	jp DispatchCutsceneStateInit.loop ; $4757
Palettes_6b_475a:
	INCLUDE "data/bank_06b/palettes_475a.asm" ; $475a, 64 bytes (palettes)
IntroCutsceneState08Init_6b:
	call DisableLCDSafely ; $479a
	ld c, $1c ; $479d
	farcall LoadScreenAssetRecord ; $479f
	farcall QueueWram3MapToVRAM ; $47a2
	xor a, a ; $47a5
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
	xor a, a ; $47d2
	ldh [hScrollX], a ; $47d3
	jp DispatchCutsceneStateInit.loop2 ; $47d5
IntroCutsceneState08Update_6b:
	ld a, [wCutsceneStepTimer] ; $47d8
	inc a ; $47db
	ld [wCutsceneStepTimer], a ; $47dc
	cp a, $2c ; $47df
	jp z, DispatchCutsceneStateInit.loopB ; $47e1
	jp DispatchCutsceneStateInit.loop ; $47e4
IntroCutsceneState09Init_6b:
	call DisableLCDSafely ; $47e7
	ld c, $1d ; $47ea
	farcall LoadScreenAssetRecord ; $47ec
	farcall QueueWram3MapToVRAM ; $47ef
	ld a, $94 ; $47f2
	ld [wCutsceneScrollX], a ; $47f4
	ldh [hScrollX], a ; $47f7
	xor a, a ; $47f9
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
	xor a, a ; $4821
	ldh [hScrollX], a ; $4822
	jp DispatchCutsceneStateInit.loop2 ; $4824
IntroCutsceneState09Update_6b:
	ld a, [wCutsceneStepTimer] ; $4827
	inc a ; $482a
	ld [wCutsceneStepTimer], a ; $482b
	cp a, $2b ; $482e
	jp z, DispatchCutsceneStateInit.loopB ; $4830
	jp DispatchCutsceneStateInit.loop ; $4833
IntroCutsceneState10Init_6b:
	call DisableLCDSafely ; $4836
	ld c, $1e ; $4839
	farcall LoadScreenAssetRecord ; $483b
	farcall QueueWram3MapToVRAM ; $483e
	ld a, $a8 ; $4841
	ld [wCutsceneScrollX], a ; $4843
	ldh [hScrollX], a ; $4846
	xor a, a ; $4848
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
	xor a, a ; $4870
	ldh [hScrollX], a ; $4871
	jp DispatchCutsceneStateInit.loop2 ; $4873
IntroCutsceneState10Update_6b:
	ld a, [wCutsceneStepTimer] ; $4876
	inc a ; $4879
	ld [wCutsceneStepTimer], a ; $487a
	cp a, $2b ; $487d
	jp z, DispatchCutsceneStateInit.loopB ; $487f
	jp DispatchCutsceneStateInit.loop ; $4882
IntroCutsceneState11Init_6b:
	call DisableLCDSafely ; $4885
	ld c, $20 ; $4888
	farcall LoadScreenAssetRecord ; $488a
	ld a, $01 ; $488d
	ldh [hShowDebugConsole], a ; $488f
	ld hl, rLCDC ; $4891
	set 3, [hl] ; $4894
	wram_bank $03 ; $4896
	ld hl, $d000 ; $489c
	ld de, $9c00 ; $489f
	ld c, $40 ; $48a2
	call QueueVRAMCopy ; $48a4
	ld hl, $d400 ; $48a7
	ld de, $bc00 ; $48aa
	ld c, $40 ; $48ad
	call QueueVRAMCopy ; $48af
	call InitCutsceneSceneB ; $48b2
	call LoadIntroTilesAndPalette ; $48b5
	call EnableLCD ; $48b8
	script_fade_in $20 ; $48bb
	call WaitFadeEnd ; $48c0
	xor a, a ; $48c3
	ld [wCutsceneStepTimer], a ; $48c4
	jp DispatchCutsceneStateInit.loop ; $48c7
IntroCutsceneState11Exit_6b:
	ld a, $00 ; $48ca
	ldh [hShowDebugConsole], a ; $48cc
	ld hl, rLCDC ; $48ce
	res 3, [hl] ; $48d1
	ld hl, Palette_6b_5d25 ; $48d3
	ld de, $0008 ; $48d6
	call LoadPaletteShadow ; $48d9
	xor a, a ; $48dc
	ld [wCutsceneStepTimer], a ; $48dd
	jp DispatchCutsceneStateInit.loop2 ; $48e0
IntroCutsceneState11Update_6b:
	ld a, [wCutsceneStepTimer] ; $48e3
	inc a ; $48e6
	ld [wCutsceneStepTimer], a ; $48e7
	cp a, $70 ; $48ea
	jp z, DispatchCutsceneStateInit.loopB ; $48ec
	jp DispatchCutsceneStateInit.loop ; $48ef
IntroCutsceneState12Init_6b:
	xor a, a ; $48f2
	ld [wCutsceneStepTimer], a ; $48f3
	ld [$cb45], a ; $48f6
	xor a, a ; $48f9
	ld [wCameraY], a ; $48fa
	ld a, $24 ; $48fd
	ld [wCameraY + 1], a ; $48ff
	ld a, $00 ; $4902
	ld [$cb4d], a ; $4904
	ld [$cb4c], a ; $4907
	ld de, $015c ; $490a
	ld hl, $cb48 ; $490d
	ld a, e ; $4910
	ld [hl+], a ; $4911
	ld [hl], d ; $4912
	ld de, $0120 ; $4913
	ld hl, wIntroCutsceneScrollY ; $4916
	ld a, e ; $4919
	ld [hl+], a ; $491a
	ld [hl], d ; $491b
	jp DispatchCutsceneStateInit.loop ; $491c
IntroCutsceneState12Exit_6b:
	ld c, $04 ; $491f
	call BeginFadeOut ; $4921
	call WaitFadeEnd ; $4924
	jp DispatchCutsceneStateInit.loop2 ; $4927
IntroCutsceneState12Update_6b:
	ld a, [$cb45] ; $492a
	cp a, $0a ; $492d
	jr z, .checkCutsceneStepTimer ; $492f
	inc a ; $4931
	ld [$cb45], a ; $4932
	call QueueScrollingSprite ; $4935
	jp DispatchCutsceneStateInit.loop ; $4938
.checkCutsceneStepTimer:
	ld a, [wCutsceneStepTimer] ; $493b
	inc a ; $493e
	ld [wCutsceneStepTimer], a ; $493f
	cp a, $80 ; $4942
	jp z, DispatchCutsceneStateInit.loopB ; $4944
	cp a, $64 ; $4947
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
	wram_bank $01 ; $4972
	ld hl, IntroCutsceneState16InitGfx0 ; $4978 -> DataPtr_IntroGreatestPlayerTiles
	ld de, $d000 ; $497b
	call DecompressDataFromBank ; $497e
	ld hl, $d000 ; $4981
	ld de, $9000 ; $4984
	ld c, $80 ; $4987
	call QueueVRAMCopy ; $4989
	ld hl, $d800 ; $498c
	ld de, $8800 ; $498f
	ld c, $80 ; $4992
	call QueueVRAMCopy ; $4994
	ld hl, IntroCutsceneState16InitGfx1 ; $4997 -> DataPtr_IntroGreatestPlayerTilemap
	ld de, $d000 ; $499a
	call DecompressDataFromBank ; $499d
	ld hl, IntroCutsceneState16InitGfx2 ; $49a0 -> DataPtr_IntroGreatestPlayerAttrmap
	ld de, $d400 ; $49a3
	call DecompressDataFromBank ; $49a6
	ld hl, $d000 ; $49a9
	ld de, $9c00 ; $49ac
	ld c, $40 ; $49af
	call QueueVRAMCopy ; $49b1
	ld hl, $d400 ; $49b4
	ld de, $bc00 ; $49b7
	ld c, $40 ; $49ba
	call QueueVRAMCopy ; $49bc
	ld hl, Palettes_6b_4a58 ; $49bf
	ld de, $0008 ; $49c2
	call LoadPaletteShadow ; $49c5
	wram_bank $01 ; $49c8
	ld hl, IntroCutsceneState16InitGfx3 ; $49ce -> DataPtr_IntroCharactersTiles
	ld de, $d000 ; $49d1
	call DecompressDataFromBank ; $49d4
	ld hl, $d000 ; $49d7
	ld de, $b000 ; $49da
	ld c, $80 ; $49dd
	call QueueVRAMCopy ; $49df
	ld hl, $d800 ; $49e2
	ld de, $a800 ; $49e5
	ld c, $80 ; $49e8
	call QueueVRAMCopy ; $49ea
	wram_bank $04 ; $49ed
	ld hl, IntroCutsceneState16InitGfx4 ; $49f3 -> DataPtr_IntroCharactersTilemap
	ld de, $d800 ; $49f6
	call DecompressDataFromBank ; $49f9
	ld hl, IntroCutsceneState16InitGfx5 ; $49fc -> DataPtr_IntroCharactersAttrmap
	ld de, $dc00 ; $49ff
	call DecompressDataFromBank ; $4a02
	wram_bank $05 ; $4a05
	ld hl, IntroCutsceneState16InitGfx6 ; $4a0b -> DataPtr_IntroCharactersTilemap2
	ld de, $d000 ; $4a0e
	call DecompressDataFromBank ; $4a11
	ld hl, IntroCutsceneState16InitGfx7 ; $4a14 -> DataPtr_IntroCharactersAttrmap2
	ld de, $d400 ; $4a17
	call DecompressDataFromBank ; $4a1a
	wram_bank $01 ; $4a1d
	ld hl, CutsceneSceneAGfx0 ; $4a23
	ld de, $d000 ; $4a26
	call DecompressData ; $4a29
	xor a, a ; $4a2c
	ldh [hScrollX], a ; $4a2d
	ldh [hScrollY], a ; $4a2f
	ld [wCutsceneStepTimer], a ; $4a31
	call EnableLCD ; $4a34
	script_fade_in $08 ; $4a37
	call WaitFadeEnd ; $4a3c
	jp DispatchCutsceneStateInit.loop ; $4a3f
IntroCutsceneState16Update_6b:
	ld a, [wCutsceneStepTimer] ; $4a42
	inc a ; $4a45
	ld [wCutsceneStepTimer], a ; $4a46
	cp a, $70 ; $4a49
	jp z, DispatchCutsceneStateInit.loopB ; $4a4b
	jp DispatchCutsceneStateInit.loop ; $4a4e
IntroCutsceneState16Exit_6b:
	xor a, a ; $4a51
	ld [wCutsceneStepTimer], a ; $4a52
	jp DispatchCutsceneStateInit.loop2 ; $4a55
Palettes_6b_4a58:
	INCLUDE "data/bank_06b/palettes_4a58.asm" ; $4a58, 64 bytes (palettes)
IntroCutsceneState17Init_6b:
	wram_bank $04 ; $4a98
	ld hl, wTextArgStringQueue + 16 ; $4a9e
	ld de, $9cc0 ; $4aa1
	ld c, $10 ; $4aa4
	call QueueVRAMCopy ; $4aa6
	ld hl, $dcc0 ; $4aa9
	ld de, $bcc0 ; $4aac
	ld c, $10 ; $4aaf
	call QueueVRAMCopy ; $4ab1
	call AdvanceFrame ; $4ab4
	ld hl, wShortTextBuffer ; $4ab7
	ld de, $9c80 ; $4aba
	ld c, $04 ; $4abd
	call QueueVRAMCopy ; $4abf
	ld hl, $dc80 ; $4ac2
	ld de, $bc80 ; $4ac5
	ld c, $04 ; $4ac8
	call QueueVRAMCopy ; $4aca
	call AdvanceFrame ; $4acd
	ld hl, Palettes_6b_4c00 ; $4ad0
	ld de, $0107 ; $4ad3
	call LoadPaletteShadow ; $4ad6
	xor a, a ; $4ad9
	ld [wCutsceneStepTimer], a ; $4ada
	jp DispatchCutsceneStateInit.loop ; $4add
IntroCutsceneState17Update_6b:
	ld a, [wCutsceneStepTimer] ; $4ae0
	inc a ; $4ae3
	ld [wCutsceneStepTimer], a ; $4ae4
	cp a, $70 ; $4ae7
	jp z, DispatchCutsceneStateInit.loopB ; $4ae9
	jp DispatchCutsceneStateInit.loop ; $4aec
IntroCutsceneState17Exit_6b:
	jp DispatchCutsceneStateInit.loop2 ; $4aef
IntroCutsceneState18Init_6b:
	ld hl, Palettes_6b_756f ; $4af2
	ld de, $0008 ; $4af5
	call LoadPaletteShadow ; $4af8
	wram_bank $05 ; $4afb
	ld hl, $d260 ; $4b01
	ld de, $9e60 ; $4b04
	ld c, $10 ; $4b07
	call QueueVRAMCopy ; $4b09
	ld hl, $d660 ; $4b0c
	ld de, $be60 ; $4b0f
	ld c, $10 ; $4b12
	call QueueVRAMCopy ; $4b14
	call AdvanceFrame ; $4b17
	ld hl, $d160 ; $4b1a
	ld de, $9d60 ; $4b1d
	ld c, $10 ; $4b20
	call QueueVRAMCopy ; $4b22
	ld hl, $d560 ; $4b25
	ld de, $bd60 ; $4b28
	ld c, $10 ; $4b2b
	call QueueVRAMCopy ; $4b2d
	call AdvanceFrame ; $4b30
	ld a, $48 ; $4b33
	ld [$cb44], a ; $4b35
	ldh [hScrollY], a ; $4b38
	ld a, $08 ; $4b3a
	ld hl, ApplyScrollYFromWram ; $4b3c
	call RegisterFrameTask ; $4b3f
	ld hl, $d060 ; $4b42
	ld de, $9c60 ; $4b45
	ld c, $10 ; $4b48
	call QueueVRAMCopy ; $4b4a
	ld hl, $d460 ; $4b4d
	ld de, $bc60 ; $4b50
	ld c, $10 ; $4b53
	call QueueVRAMCopy ; $4b55
	call AdvanceFrame ; $4b58
	ld hl, $d000 ; $4b5b
	ld de, $9c00 ; $4b5e
	ld c, $08 ; $4b61
	call QueueVRAMCopy ; $4b63
	ld hl, $d400 ; $4b66
	ld de, $bc00 ; $4b69
	ld c, $08 ; $4b6c
	call QueueVRAMCopy ; $4b6e
	ld hl, Palettes_6b_4c00 ; $4b71
	ld de, $0107 ; $4b74
	call LoadPaletteShadow ; $4b77
	call AdvanceFrame ; $4b7a
	wram_bank $01 ; $4b7d
	ld hl, $d000 ; $4b83
	ld de, $9000 ; $4b86
	ld c, $20 ; $4b89
	call QueueVRAMCopy ; $4b8b
	call AdvanceFrame ; $4b8e
	ld hl, $d200 ; $4b91
	ld de, $9200 ; $4b94
	ld c, $20 ; $4b97
	call QueueVRAMCopy ; $4b99
	call AdvanceFrame ; $4b9c
	ld hl, $d400 ; $4b9f
	ld de, $9400 ; $4ba2
	ld c, $20 ; $4ba5
	call QueueVRAMCopy ; $4ba7
	call AdvanceFrame ; $4baa
	ld hl, $d600 ; $4bad
	ld de, $9600 ; $4bb0
	ld c, $20 ; $4bb3
	call QueueVRAMCopy ; $4bb5
	call AdvanceFrame ; $4bb8
	ld hl, $d800 ; $4bbb
	ld de, $8800 ; $4bbe
	ld c, $20 ; $4bc1
	call QueueVRAMCopy ; $4bc3
	call AdvanceFrame ; $4bc6
	xor a, a ; $4bc9
	ld [wCutsceneStepTimer], a ; $4bca
	jp DispatchCutsceneStateInit.loop ; $4bcd
IntroCutsceneState18Update_6b:
	ld a, [$cb44] ; $4bd0
	sub a, $04 ; $4bd3
	ld [$cb44], a ; $4bd5
	ldh [hScrollY], a ; $4bd8
	jp z, DispatchCutsceneStateInit.loopB ; $4bda
	ld a, [wCutsceneStepTimer] ; $4bdd
	or a, a ; $4be0
	jr nz, .checkCutsceneStepTimer ; $4be1
.checkCutsceneStepTimer:
	ld a, [wCutsceneStepTimer] ; $4be3
	inc a ; $4be6
	ld [wCutsceneStepTimer], a ; $4be7
	jp DispatchCutsceneStateInit.loop ; $4bea
IntroCutsceneState18Exit_6b:
	ld hl, ApplyScrollYFromWram ; $4bed
	call UnregisterFrameTask ; $4bf0
	wram_bank $03 ; $4bf3
	ld a, $00 ; $4bf9
	ldh [hShowDebugConsole], a ; $4bfb
	jp DispatchCutsceneStateInit.loop2 ; $4bfd
Palettes_6b_4c00:
	INCLUDE "data/bank_06b/palettes_4c00.asm" ; $4c00, 56 bytes (palettes)
IntroCutsceneState19Init_6b:
	ld hl, Palette_6b_5d25 ; $4c38
	ld de, $0008 ; $4c3b
	call LoadPaletteShadow ; $4c3e
	xor a, a ; $4c41
	ld [wCutsceneStepTimer], a ; $4c42
	ld [$cb45], a ; $4c45
	xor a, a ; $4c48
	ld [wCameraY], a ; $4c49
	ld a, $24 ; $4c4c
	ld [wCameraY + 1], a ; $4c4e
	ld a, $00 ; $4c51
	ld [$cb4d], a ; $4c53
	ld [$cb4c], a ; $4c56
	ld de, $015c ; $4c59
	ld hl, $cb48 ; $4c5c
	ld a, e ; $4c5f
	ld [hl+], a ; $4c60
	ld [hl], d ; $4c61
	ld de, $0120 ; $4c62
	ld hl, wIntroCutsceneScrollY ; $4c65
	ld a, e ; $4c68
	ld [hl+], a ; $4c69
	ld [hl], d ; $4c6a
	jp DispatchCutsceneStateInit.loop ; $4c6b
IntroCutsceneState19Exit_6b:
	ld c, $04 ; $4c6e
	call BeginFadeOut ; $4c70
	call WaitFadeEnd ; $4c73
	jp DispatchCutsceneStateInit.loop2 ; $4c76
IntroCutsceneState19Update_6b:
	ld a, [wCutsceneStepTimer] ; $4c79
	inc a ; $4c7c
	ld [wCutsceneStepTimer], a ; $4c7d
	cp a, $80 ; $4c80
	jp z, DispatchCutsceneStateInit.loopB ; $4c82
	cp a, $64 ; $4c85
	jr nc, .updateCutsceneScrollY ; $4c87
	call AdvanceSpriteAnimTimer ; $4c89
.updateCutsceneScrollY:
	call UpdateCutsceneScrollY ; $4c8c
	call UpdateCutsceneScrollX ; $4c8f
	call SetCameraYFromScrollPos ; $4c92
	call QueueScrollingSprite ; $4c95
	call QueueCutsceneAnimatedSprites ; $4c98
	jp DispatchCutsceneStateInit.loop ; $4c9b
UpdateCutsceneScrollX:
	ld a, [wCutsceneStepTimer] ; $4c9e
	ld hl, CutsceneScrollXTable ; $4ca1
	add a, l ; $4ca4
	ld l, a ; $4ca5
	jr nc, .read ; $4ca6
	inc h ; $4ca8
.read:
	ld e, [hl] ; $4ca9
	ld hl, wIntroCutsceneScrollY ; $4caa
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
	ld [wIntroCutsceneScrollY + 1], a ; $4cb9
	ld a, l ; $4cbc
	ld [wIntroCutsceneScrollY], a ; $4cbd
	ret ; $4cc0
CutsceneScrollXTable:
	INCBIN "data/bank_06b/d_4cc1.bin" ; $4cc1, 160 bytes
UpdateCutsceneScrollY:
	ld a, [wCutsceneStepTimer] ; $4d61
	ld hl, CutsceneScrollYTable ; $4d64
	add a, l ; $4d67
	ld l, a ; $4d68
	jr nc, .read ; $4d69
	inc h ; $4d6b
.read:
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
CutsceneScrollYTable:
	INCBIN "data/bank_06b/d_4d84.bin" ; $4d84, 169 bytes
QueueCutsceneAnimatedSprites:
	ld a, [wCutsceneStepTimer] ; $4e2d
	cp a, $20 ; $4e30
	ret c ; $4e32
	ld a, [wCutsceneStepTimer] ; $4e33
	sub a, $20 ; $4e36
	add a, a ; $4e38
	ld hl, CutsceneAnimatedSprites2 ; $4e39
	add a, l ; $4e3c
	ld l, a ; $4e3d
	jr nc, .read ; $4e3e
	inc h ; $4e40
.read:
	ld a, [hl+] ; $4e41
	ld d, [hl] ; $4e42
	ld e, a ; $4e43
	call ApplyCutsceneScrollToSpriteX ; $4e44
	ld c, $40 ; $4e47
	ld b, $09 ; $4e49
	ld hl, SpriteTemplate_6b_4e8e ; $4e4b
	call QueueSpriteTemplate ; $4e4e
	ld a, [wCutsceneStepTimer] ; $4e51
	sub a, $20 ; $4e54
	add a, a ; $4e56
	ld hl, CutsceneAnimatedSprites1 ; $4e57
	add a, l ; $4e5a
	ld l, a ; $4e5b
	jr nc, .readB ; $4e5c
	inc h ; $4e5e
.readB:
	ld a, [hl+] ; $4e5f
	ld d, [hl] ; $4e60
	ld e, a ; $4e61
	call ApplyCutsceneScrollToSpriteX ; $4e62
	ld c, $44 ; $4e65
	ld b, $09 ; $4e67
	ld hl, SpriteTemplate_6b_4e97 ; $4e69
	call QueueSpriteTemplate ; $4e6c
	ld a, [wCutsceneStepTimer] ; $4e6f
	sub a, $20 ; $4e72
	add a, a ; $4e74
	ld hl, CutsceneAnimatedSprites0 ; $4e75
	add a, l ; $4e78
	ld l, a ; $4e79
	jr nc, .read2 ; $4e7a
	inc h ; $4e7c
.read2:
	ld a, [hl+] ; $4e7d
	ld d, [hl] ; $4e7e
	ld e, a ; $4e7f
	call ApplyCutsceneScrollToSpriteX ; $4e80
	ld c, $48 ; $4e83
	ld b, $09 ; $4e85
	ld hl, SpriteTemplate_6b_4ea0 ; $4e87
	call QueueSpriteTemplate ; $4e8a
	ret ; $4e8d
SpriteTemplate_6b_4e8e:
	; $4e8e, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
SpriteTemplate_6b_4e97:
	; $4e97, 9 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite_end
SpriteTemplate_6b_4ea0:
	; $4ea0, 5 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite_end
CutsceneAnimatedSprites0:
	INCBIN "data/bank_06b/d_4ea5.bin" ; $4ea5, 240 bytes
CutsceneAnimatedSprites1:
	INCBIN "data/bank_06b/d_4f95.bin" ; $4f95, 216 bytes
CutsceneAnimatedSprites2:
	INCBIN "data/bank_06b/d_506d.bin" ; $506d, 288 bytes
ApplyCutsceneScrollToSpriteX:
	push bc ; $518d
	push hl ; $518e
	ld c, d ; $518f
	ld b, e ; $5190
	ld hl, wIntroCutsceneScrollY ; $5191
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
.loop:
	ldh a, [hInputRisingEdge] ; $51a5
	bit PADB_A, a ; $51a7
	jr nz, .done ; $51a9
	jr .loop ; $51ab
.done:
	ret ; $51ad
ShowIntroLogoScreen:
	call DisableLCDSafely ; $51ae
	ld c, $15 ; $51b1
	farcall LoadScreenAssetRecord ; $51b3
	farcall QueueWram3MapToVRAM ; $51b6
	xor a, a ; $51b9
	ldh [hScrollX], a ; $51ba
	ldh [hScrollY], a ; $51bc
	ld [wCutsceneStepTimer], a ; $51be
	ld a, $d8 ; $51c1
	ldh [hScrollY], a ; $51c3
	sound $65 ; $51c5
	call EnableLCD ; $51c7
	script_fade_in $20 ; $51ca
	call WaitFadeEnd ; $51cf
.loop:
	call AdvanceFrame ; $51d2
	ld a, [wCutsceneStepTimer] ; $51d5
	inc a ; $51d8
	ld [wCutsceneStepTimer], a ; $51d9
	cp a, $3c ; $51dc
	jr z, .clearCutsceneStepTimer ; $51de
	jr .loop ; $51e0
.clearCutsceneStepTimer:
	xor a, a ; $51e2
	ld [wCutsceneStepTimer], a ; $51e3
	ret ; $51e6
ScrollOutIntroLogo:
	ld a, $40 ; $51e7
	ldh [hScrollY], a ; $51e9
.loop:
	call AdvanceFrame ; $51eb
	ld a, [wCutsceneStepTimer] ; $51ee
	inc a ; $51f1
	ld [wCutsceneStepTimer], a ; $51f2
	cp a, $3e ; $51f5
	jr z, .eq3e ; $51f7
	jr .loop ; $51f9
.eq3e:
	ld c, $10 ; $51fb
	call BeginFadeOut ; $51fd
	call WaitFadeEnd ; $5200
	call DisableLCDSafely ; $5203
	xor a, a ; $5206
	ldh [hScrollY], a ; $5207
	ret ; $5209
LoadCutsceneTileset:
	ld b, $4d ; $520a
	ld c, $06 ; $520c
	ld de, $a000 ; $520e
	farcall LoadCompressedTileBlock ; $5211
	ld b, $4e ; $5214
	ld c, $0a ; $5216
	ld de, $a060 ; $5218
	farcall LoadCompressedTileBlock ; $521b
	ld b, $4f ; $521e
	ld c, $10 ; $5220
	ld de, $a100 ; $5222
	farcall LoadCompressedTileBlock ; $5225
	ld b, $50 ; $5228
	ld c, $06 ; $522a
	ld de, $a200 ; $522c
	farcall LoadCompressedTileBlock ; $522f
	ld b, $51 ; $5232
	ld c, $12 ; $5234
	ld de, $a260 ; $5236
	farcall LoadCompressedTileBlock ; $5239
	ld b, $52 ; $523c
	ld c, $10 ; $523e
	ld de, $a380 ; $5240
	farcall LoadCompressedTileBlock ; $5243
	ld b, $53 ; $5246
	ld c, $02 ; $5248
	ld de, $a480 ; $524a
	farcall LoadCompressedTileBlock ; $524d
	ld hl, Palettes_6b_525a ; $5250
	ld de, $0802 ; $5253
	call LoadPaletteShadow ; $5256
	ret ; $5259
Palettes_6b_525a:
	INCLUDE "data/bank_06b/palettes_525a.asm" ; $525a, 16 bytes (palettes)
QueueCutsceneSpriteGroupA:
	ld hl, SpriteTemplate_6b_52b6 ; $526a
	ld a, [$cb44] ; $526d
	ld d, $10 ; $5270
	add a, d ; $5272
	ld d, a ; $5273
	ld a, [$cb45] ; $5274
	ld e, a ; $5277
	call ApplyCutsceneBobOffset ; $5278
	ld c, $00 ; $527b
	ld b, $08 ; $527d
	call QueueSpriteTemplate ; $527f
	ld hl, SpriteTemplate_6b_52c3 ; $5282
	ld a, [$cb44] ; $5285
	ld d, $08 ; $5288
	add a, d ; $528a
	ld d, a ; $528b
	ld a, [$cb45] ; $528c
	ld e, $10 ; $528f
	add a, e ; $5291
	ld e, a ; $5292
	call ApplyCutsceneBobOffset ; $5293
	ld c, $06 ; $5296
	ld b, $08 ; $5298
	call QueueSpriteTemplate ; $529a
	ld hl, SpriteTemplate_6b_52d8 ; $529d
	ld a, [$cb44] ; $52a0
	ld d, a ; $52a3
	ld a, [$cb45] ; $52a4
	ld e, $20 ; $52a7
	add a, e ; $52a9
	ld e, a ; $52aa
	call ApplyCutsceneBobOffset ; $52ab
	ld c, $10 ; $52ae
	ld b, $08 ; $52b0
	call QueueSpriteTemplate ; $52b2
	ret ; $52b5
SpriteTemplate_6b_52b6:
	; $52b6, 13 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite $10, $18, $04, $00
	oam_sprite_end
SpriteTemplate_6b_52c3:
	; $52c3, 21 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite $10, $18, $04, $00
	oam_sprite $10, $20, $06, $00
	oam_sprite $10, $28, $08, $00
	oam_sprite_end
SpriteTemplate_6b_52d8:
	; $52d8, 33 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite $10, $18, $04, $00
	oam_sprite $10, $20, $06, $00
	oam_sprite $10, $28, $08, $00
	oam_sprite $10, $30, $0a, $00
	oam_sprite $10, $38, $0c, $00
	oam_sprite $10, $40, $0e, $00
	oam_sprite_end
QueueCutsceneSpriteGroupB:
	ld hl, SpriteTemplate_6b_5360 ; $52f9
	ld a, [$cb46] ; $52fc
	ld d, $18 ; $52ff
	add a, d ; $5301
	ld d, a ; $5302
	ld a, [$cb47] ; $5303
	ld e, a ; $5306
	call ApplyCutsceneBobOffset ; $5307
	ld c, $20 ; $530a
	ld b, $09 ; $530c
	call QueueSpriteTemplate ; $530e
	ld hl, SpriteTemplate_6b_536d ; $5311
	ld a, [$cb46] ; $5314
	ld d, $08 ; $5317
	add a, d ; $5319
	ld d, a ; $531a
	ld a, [$cb47] ; $531b
	ld e, $10 ; $531e
	add a, e ; $5320
	ld e, a ; $5321
	call ApplyCutsceneBobOffset ; $5322
	ld c, $26 ; $5325
	ld b, $09 ; $5327
	call QueueSpriteTemplate ; $5329
	ld hl, SpriteTemplate_6b_5392 ; $532c
	ld a, [$cb46] ; $532f
	ld d, a ; $5332
	ld a, [$cb47] ; $5333
	ld e, $20 ; $5336
	add a, e ; $5338
	ld e, a ; $5339
	call ApplyCutsceneBobOffset ; $533a
	ld c, $38 ; $533d
	ld b, $09 ; $533f
	call QueueSpriteTemplate ; $5341
	ld hl, SpriteTemplate_6b_53b3 ; $5344
	ld a, [$cb46] ; $5347
	ld d, $48 ; $534a
	add a, d ; $534c
	ld d, a ; $534d
	ld a, [$cb47] ; $534e
	ld e, $20 ; $5351
	add a, e ; $5353
	ld e, a ; $5354
	call ApplyCutsceneBobOffset ; $5355
	ld c, $48 ; $5358
	ld b, $09 ; $535a
	call QueueSpriteTemplate ; $535c
	ret ; $535f
SpriteTemplate_6b_5360:
	; $5360, 13 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite $10, $18, $04, $00
	oam_sprite_end
SpriteTemplate_6b_536d:
	; $536d, 37 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite $10, $18, $04, $00
	oam_sprite $10, $20, $06, $00
	oam_sprite $10, $28, $08, $00
	oam_sprite $10, $30, $0a, $00
	oam_sprite $10, $38, $0c, $00
	oam_sprite $10, $40, $0e, $00
	oam_sprite $10, $48, $10, $00
	oam_sprite_end
SpriteTemplate_6b_5392:
	; $5392, 33 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite $10, $18, $04, $00
	oam_sprite $10, $20, $06, $00
	oam_sprite $10, $28, $08, $00
	oam_sprite $10, $30, $0a, $00
	oam_sprite $10, $38, $0c, $00
	oam_sprite $10, $40, $0e, $00
	oam_sprite_end
SpriteTemplate_6b_53b3:
	; $53b3, 5 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite_end
ApplyCutsceneBobOffset:
	push hl ; $53b8
	ld a, [wCutsceneStepTimer] ; $53b9
	and a, $0f ; $53bc
	ld hl, CutsceneBobOffsetTable ; $53be
	add a, l ; $53c1
	ld l, a ; $53c2
	jr nc, .readOffset ; $53c3
	inc h ; $53c5
.readOffset:
	ld a, [hl] ; $53c6
	add a, e ; $53c7
	ld e, a ; $53c8
	pop hl ; $53c9
	ret ; $53ca
CutsceneBobOffsetTable:
	; $53cb, 16 bytes (bytes:16)
	db $00, $00, $00, $01, $02, $03, $03, $04, $04, $04, $03, $03, $02, $01, $00, $00 ; 0x00
UpdateCutsceneScroll:
	ld a, [wCutsceneScrollX] ; $53db
	add a, $03 ; $53de
	ld [wCutsceneScrollX], a ; $53e0
	ldh [hScrollX], a ; $53e3
	ld a, [$cb43] ; $53e5
	sub a, $03 ; $53e8
	ld [$cb43], a ; $53ea
	ld [$cb01], a ; $53ed
	ret ; $53f0
CheckIntroSkipInput:
	ldh a, [hInputRisingEdge] ; $53f1
	and a, $09 ; $53f3
	ret z ; $53f5
	ld a, $01 ; $53f6
	ld [wIntroCutsceneCheck], a ; $53f8
	ret ; $53fb
InitCutsceneSceneA:
	call DisableLCDSafely ; $53fc
	farcall InitSceneScroll ; $53ff
	farcall InitTextWindows ; $5402
	wram_bank $01 ; $5405
	ld hl, CutsceneSceneAGfx0 ; $540b
	ld de, $d000 ; $540e
	call DecompressData ; $5411
	ld hl, $d000 ; $5414
	ld de, $9000 ; $5417
	ld c, $80 ; $541a
	call QueueVRAMCopy ; $541c
	ld hl, $d800 ; $541f
	ld de, $8800 ; $5422
	ld c, $80 ; $5425
	call QueueVRAMCopy ; $5427
	wram_bank $02 ; $542a
	ld hl, CutsceneSceneAGfx1 ; $5430
	ld de, $d000 ; $5433
	call DecompressData ; $5436
	wram_bank $03 ; $5439
	ld hl, CutsceneSceneAGfx2 ; $543f
	ld de, $d000 ; $5442
	call DecompressData ; $5445
	xor a, a ; $5448
	ld [wCameraY], a ; $5449
	ld [wCameraX], a ; $544c
	ld a, $24 ; $544f
	ld [wCameraY + 1], a ; $5451
	ld a, $01 ; $5454
	farcall CopyScrolledSceneTilemapToVram ; $5456
	xor a, a ; $5459
	ld [wCameraY + 1], a ; $545a
	ret ; $545d
InitCutsceneSceneB:
	call DisableLCDSafely ; $545e
	farcall InitSceneScroll ; $5461
	farcall InitTextWindows ; $5464
	wram_bank $01 ; $5467
	ld hl, CutsceneSceneAGfx0 ; $546d
	ld de, $d000 ; $5470
	call DecompressData ; $5473
	ld hl, $d000 ; $5476
	ld de, $9000 ; $5479
	ld c, $80 ; $547c
	call QueueVRAMCopy ; $547e
	ld hl, $d800 ; $5481
	ld de, $8800 ; $5484
	ld c, $80 ; $5487
	call QueueVRAMCopy ; $5489
	wram_bank $02 ; $548c
	ld hl, CutsceneSceneBGfx1 ; $5492
	ld de, $d000 ; $5495
	call DecompressData ; $5498
	wram_bank $03 ; $549b
	ld hl, CutsceneSceneBGfx0 ; $54a1
	ld de, $d000 ; $54a4
	call DecompressData ; $54a7
	xor a, a ; $54aa
	ld [wCameraY], a ; $54ab
	ld a, $24 ; $54ae
	ld [wCameraY + 1], a ; $54b0
	ld a, $01 ; $54b3
	farcall CopyScrolledSceneTilemapToVram ; $54b5
	ret ; $54b8
InitCutsceneSceneC:
	call DisableLCDSafely ; $54b9
	farcall InitSceneScroll ; $54bc
	farcall InitTextWindows ; $54bf
	wram_bank $01 ; $54c2
	ld hl, CutsceneSceneAGfx0 ; $54c8
	ld de, $d000 ; $54cb
	call DecompressData ; $54ce
	ld hl, $d000 ; $54d1
	ld de, $9000 ; $54d4
	ld c, $80 ; $54d7
	call QueueVRAMCopy ; $54d9
	ld hl, $d800 ; $54dc
	ld de, $8800 ; $54df
	ld c, $80 ; $54e2
	call QueueVRAMCopy ; $54e4
	wram_bank $02 ; $54e7
	ld hl, CutsceneSceneBGfx1 ; $54ed
	ld de, $d000 ; $54f0
	call DecompressData ; $54f3
	wram_bank $03 ; $54f6
	ld hl, CutsceneSceneBGfx0 ; $54fc
	ld de, $d000 ; $54ff
	call DecompressData ; $5502
	ld hl, Palette_6b_5d25 ; $5505
	ld de, $0008 ; $5508
	call LoadPaletteShadow ; $550b
	xor a, a ; $550e
	ld [wCameraY], a ; $550f
	ld a, $24 ; $5512
	ld [wCameraY + 1], a ; $5514
	ld a, $01 ; $5517
	farcall CopyScrolledSceneTilemapToVram ; $5519
	ret ; $551c
CutsceneSceneAGfx0:
	INCBIN "data/bank_06b/d_551d.bin" ; $551d, 1210 bytes
CutsceneSceneBGfx0:
	INCBIN "data/bank_06b/d_59d7.bin" ; $59d7, 512 bytes
CutsceneSceneBGfx1:
	INCBIN "data/bank_06b/d_5bd7.bin" ; $5bd7, 334 bytes
Palette_6b_5d25:
	INCLUDE "data/bank_06b/palettes_5d25.asm" ; $5d25, 64 bytes (palettes)
CutsceneSceneAGfx1:
	INCBIN "data/bank_06b/d_5d65.bin" ; $5d65, 323 bytes
CutsceneSceneAGfx2:
	INCBIN "data/bank_06b/d_5ea8.bin" ; $5ea8, 461 bytes
LoadIntroTilesAndPalette:
	ld b, $54 ; $6075
	ld c, $10 ; $6077
	ld de, $a000 ; $6079
	farcall LoadCompressedTileBlock ; $607c
	ld b, $55 ; $607f
	ld c, $10 ; $6081
	ld de, $a100 ; $6083
	farcall LoadCompressedTileBlock ; $6086
	ld b, $56 ; $6089
	ld c, $10 ; $608b
	ld de, $a200 ; $608d
	farcall LoadCompressedTileBlock ; $6090
	ld b, $57 ; $6093
	ld c, $10 ; $6095
	ld de, $a300 ; $6097
	farcall LoadCompressedTileBlock ; $609a
	ld b, $58 ; $609d
	ld c, $04 ; $609f
	ld de, $a400 ; $60a1
	farcall LoadCompressedTileBlock ; $60a4
	ld b, $59 ; $60a7
	ld c, $04 ; $60a9
	ld de, $a440 ; $60ab
	farcall LoadCompressedTileBlock ; $60ae
	ld b, $5a ; $60b1
	ld c, $04 ; $60b3
	ld de, $a480 ; $60b5
	farcall LoadCompressedTileBlock ; $60b8
	ld hl, Palettes_6b_60c5 ; $60bb
	ld de, $0802 ; $60be
	call LoadPaletteShadow ; $60c1
	ret ; $60c4
Palettes_6b_60c5:
	INCLUDE "data/bank_06b/palettes_60c5.asm" ; $60c5, 16 bytes (palettes)
SetCameraYFromScrollPos:
	ld hl, wIntroCutsceneScrollY ; $60d5
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
	ld [wCameraY], a ; $60f0
	ld a, d ; $60f3
	ld [wCameraY + 1], a ; $60f4
	ret ; $60f7
QueueScrollingSprite:
	ld hl, wIntroCutsceneScrollY ; $60f8
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
	call QueueIntroSpriteBlock ; $6111
	ret ; $6114
AdvanceSpriteAnimTimer:
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
QueueIntroSpriteBlock:
	ld hl, IntroSpriteBlockTable ; $6126
	ld a, c ; $6129
	add a, l ; $612a
	ld l, a ; $612b
	jr nc, .read ; $612c
	inc h ; $612e
.read:
	ld c, [hl] ; $612f
	ld hl, SpriteTemplate_6b_613d ; $6130
	ld b, $08 ; $6133
	call QueueSpriteTemplate ; $6135
	ret ; $6138
IntroSpriteBlockTable:
	; $6139, 4 bytes (bytes:4)
	db $00, $10, $20, $30 ; 0x00
SpriteTemplate_6b_613d:
	; $613d, 33 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $20, $08, $02, $00
	oam_sprite $10, $10, $04, $00
	oam_sprite $20, $10, $06, $00
	oam_sprite $10, $18, $08, $00
	oam_sprite $20, $18, $0a, $00
	oam_sprite $10, $20, $0c, $00
	oam_sprite $20, $20, $0e, $00
	oam_sprite_end
Data_6b_615e:
	; $615e, 30 bytes (bytes:16)
	db $fa, $40, $cb, $fe, $14, $38, $16, $fa, $23, $c3, $b7, $28, $10, $fa, $23, $c3 ; 0x00
	db $67, $fa, $22, $c3, $6f, $7c, $ea, $23, $c3, $7d, $ea, $22, $c3, $c9 ; 0x10
InitTitleSceneGraphics:
	call DisableLCDSafely ; $617c
	farcall InitSceneScroll ; $617f
	farcall InitTextWindows ; $6182
	wram_bank $01 ; $6185
	ld hl, TitleSceneGraphicsGfx0 ; $618b
	ld de, $d000 ; $618e
	call DecompressData ; $6191
	ld hl, $d000 ; $6194
	ld de, $b000 ; $6197
	ld c, $80 ; $619a
	call QueueVRAMCopy ; $619c
	ld hl, $d800 ; $619f
	ld de, $a800 ; $61a2
	ld c, $80 ; $61a5
	call QueueVRAMCopy ; $61a7
	wram_bank $02 ; $61aa
	ld hl, TitleSceneGraphicsGfx2 ; $61b0
	ld de, $d000 ; $61b3
	call DecompressData ; $61b6
	wram_bank $03 ; $61b9
	ld hl, TitleSceneGraphicsGfx1 ; $61bf
	ld de, $d000 ; $61c2
	call DecompressData ; $61c5
	ld hl, Palette_6b_7043 ; $61c8
	ld de, $0008 ; $61cb
	call LoadPaletteShadow ; $61ce
	ld a, $20 ; $61d1
	ld [wCameraX + 1], a ; $61d3
	xor a, a ; $61d6
	ld [wCameraX], a ; $61d7
	ld [wCameraY], a ; $61da
	ld [wCameraY + 1], a ; $61dd
	ld a, $01 ; $61e0
	farcall CopyScrolledSceneTilemapToVram ; $61e2
	ret ; $61e5
TitleSceneGraphicsGfx0:
	INCBIN "data/bank_06b/d_61e6.bin" ; $61e6, 2628 bytes
IntroCutsceneState01InitGfx0:
	db $c0 ; $6c2a
	db $cd ; $6c2b
IntroCutsceneState01InitGfx1:
	db $ff ; $6c2c
	db $f8 ; $6c2d
IntroCutsceneState01InitGfx2:
	INCBIN "data/bank_06b/d_6c2e.bin" ; $6c2e, 4 bytes
IntroCutsceneState03InitGfx0:
	db $0c ; $6c32
	db $ff ; $6c33
IntroCutsceneState03InitGfx1:
	db $12 ; $6c34
	db $d0 ; $6c35
IntroCutsceneState03InitGfx2:
	INCBIN "data/bank_06b/d_6c36.bin" ; $6c36, 134 bytes
TitleSceneGraphicsGfx1:
	INCBIN "data/bank_06b/d_6cbc.bin" ; $6cbc, 84 bytes
DecompressIntroTitleTiles0:
	db $0f ; $6d10
	db $10 ; $6d11
IntroCutsceneState16InitGfx0:
	db $00 ; $6d12
	db $11 ; $6d13
IntroCutsceneState16InitGfx1:
	db $00 ; $6d14
	db $00 ; $6d15
IntroCutsceneState16InitGfx2:
	INCBIN "data/bank_06b/d_6d16.bin" ; $6d16, 4 bytes
IntroCutsceneState16InitGfx3:
	db $b7 ; $6d1a
	db $b8 ; $6d1b
IntroCutsceneState16InitGfx4:
	db $b9 ; $6d1c
	db $ba ; $6d1d
IntroCutsceneState16InitGfx5:
	INCBIN "data/bank_06b/d_6d1e.bin" ; $6d1e, 4 bytes
IntroCutsceneState16InitGfx6:
	db $5f ; $6d22
	db $60 ; $6d23
IntroCutsceneState16InitGfx7:
	INCBIN "data/bank_06b/d_6d24.bin" ; $6d24, 491 bytes
TitleSceneGraphicsGfx2:
	INCBIN "data/bank_06b/d_6f0f.bin" ; $6f0f, 308 bytes
Palette_6b_7043:
	INCLUDE "data/bank_06b/palettes_7043.asm" ; $7043, 64 bytes (palettes)
IntroSequenceTimerTask:
	ld a, [$cb44] ; $7083
	inc a ; $7086
	ld [$cb44], a ; $7087
	cp a, $5a ; $708a
	jr nz, .compare ; $708c
	ld a, $01 ; $708e
	ld hl, CycleBgPalettes4To7Task ; $7090
	call RegisterFrameTask ; $7093
.compare:
	cp a, $aa ; $7096
	jr nz, .compare2 ; $7098
	ld a, $01 ; $709a
	ld hl, AnimateBgPalette1Task ; $709c
	call RegisterFrameTask ; $709f
.compare2:
	cp a, $01 ; $70a2
	jr nz, .done ; $70a4
	ld a, $01 ; $70a6
	ld hl, AnimateBgPalettes2And3Task ; $70a8
	call RegisterFrameTask ; $70ab
.done:
	ret ; $70ae
Palettes_6b_70af:
	INCLUDE "data/bank_06b/palettes_70af.asm" ; $70af, 128 bytes (palettes)
Palettes_6b_712f:
	INCLUDE "data/bank_06b/palettes_712f.asm" ; $712f, 128 bytes (palettes)
Palettes_6b_71af:
	INCLUDE "data/bank_06b/palettes_71af.asm" ; $71af, 128 bytes (palettes)
Palettes_6b_722f:
	INCLUDE "data/bank_06b/palettes_722f.asm" ; $722f, 128 bytes (palettes)
AnimateBgPalette1Task:
	ldh a, [hVBlankCounter] ; $72af
	and a, $03 ; $72b1
	cp a, $03 ; $72b3
	ret nz ; $72b5
	ld a, [$cb45] ; $72b6
	inc a ; $72b9
	ld [$cb45], a ; $72ba
	cp a, $10 ; $72bd
	jr nc, .ge10 ; $72bf
	sla a ; $72c1
	sla a ; $72c3
	sla a ; $72c5
	ld hl, Palettes_6b_70af ; $72c7
	add a, l ; $72ca
	ld l, a ; $72cb
	jr nc, .loadPalettesImmediate ; $72cc
	inc h ; $72ce
.loadPalettesImmediate:
	ld de, $0101 ; $72cf
	call LoadPalettesImmediate ; $72d2
	ret ; $72d5
.ge10:
	ld hl, AnimateBgPalette1Task ; $72d6
	call UnregisterFrameTask ; $72d9
	ret ; $72dc
AnimateBgPalettes2And3Task:
	ldh a, [hVBlankCounter] ; $72dd
	and a, $03 ; $72df
	cp a, $03 ; $72e1
	ret nz ; $72e3
	ld a, [$cb46] ; $72e4
	inc a ; $72e7
	ld [$cb46], a ; $72e8
	cp a, $10 ; $72eb
	jr nc, .ge10 ; $72ed
	sla a ; $72ef
	sla a ; $72f1
	sla a ; $72f3
	push af ; $72f5
	ld hl, Palettes_6b_712f ; $72f6
	add a, l ; $72f9
	ld l, a ; $72fa
	jr nc, .loadPalettesImmediate ; $72fb
	inc h ; $72fd
.loadPalettesImmediate:
	ld de, $0201 ; $72fe
	call LoadPalettesImmediate ; $7301
	pop af ; $7304
	ld hl, Palettes_6b_71af ; $7305
	add a, l ; $7308
	ld l, a ; $7309
	jr nc, .loadPalettesImmediate2 ; $730a
	inc h ; $730c
.loadPalettesImmediate2:
	ld de, $0301 ; $730d
	call LoadPalettesImmediate ; $7310
	ret ; $7313
.ge10:
	ld hl, AnimateBgPalettes2And3Task ; $7314
	call UnregisterFrameTask ; $7317
	ret ; $731a
CycleBgPalettes4To7Task:
	ldh a, [hVBlankCounter] ; $731b
	and a, $03 ; $731d
	cp a, $03 ; $731f
	ret nz ; $7321
	ld a, [$cb47] ; $7322
	inc a ; $7325
	ld [$cb47], a ; $7326
	cp a, $10 ; $7329
	jr nc, .compare ; $732b
	sla a ; $732d
	sla a ; $732f
	sla a ; $7331
	ld hl, Palettes_6b_722f ; $7333
	add a, l ; $7336
	ld l, a ; $7337
	jr nc, .loadPalettesImmediate ; $7338
	inc h ; $733a
.loadPalettesImmediate:
	ld de, $0404 ; $733b
	call LoadPalettesImmediate ; $733e
	ret ; $7341
.compare:
	cp a, $20 ; $7342
	jr c, .lt20 ; $7344
	ld b, a ; $7346
	ld a, $20 ; $7347
	sub a, b ; $7349
	sla a ; $734a
	sla a ; $734c
	sla a ; $734e
	ld hl, Palettes_6b_722f ; $7350
	add a, l ; $7353
	ld l, a ; $7354
	jr nc, .loadPalettesImmediate2 ; $7355
	inc h ; $7357
.loadPalettesImmediate2:
	ld de, $0404 ; $7358
	call LoadPalettesImmediate ; $735b
	ret ; $735e
.lt20:
	ld hl, CycleBgPalettes4To7Task ; $735f
	call UnregisterFrameTask ; $7362
	ret ; $7365
ScrollCutsceneXRightTask:
	ld a, [wCutsceneStepTimer] ; $7366
	cp a, $10 ; $7369
	jr nc, .done ; $736b
	ld hl, ScrollCutsceneXRightTaskTable ; $736d
	add a, l ; $7370
	ld l, a ; $7371
	jr nc, .read ; $7372
	inc h ; $7374
.read:
	ld a, [hl] ; $7375
	ld b, a ; $7376
	ld a, [wCutsceneScrollX] ; $7377
	add a, b ; $737a
	ld [wCutsceneScrollX], a ; $737b
	ldh [hScrollX], a ; $737e
.done:
	ret ; $7380
ScrollCutsceneXRightTaskTable:
	; $7381, 20 bytes (bytes:16)
	db $0a, $0a, $0a, $0a, $0a, $0a, $01, $01, $00, $00, $00, $00, $00, $00, $00, $00 ; 0x00
	db $00, $00, $00, $00 ; 0x10
ScrollCutsceneXLeftTask:
	ld a, [wCutsceneStepTimer] ; $7395
	cp a, $10 ; $7398
	jr nc, .done ; $739a
	ld hl, ScrollCutsceneXLeftTaskTable ; $739c
	add a, l ; $739f
	ld l, a ; $73a0
	jr nc, .read ; $73a1
	inc h ; $73a3
.read:
	ld a, [hl] ; $73a4
	ld b, a ; $73a5
	ld a, [wCutsceneScrollX] ; $73a6
	sub a, b ; $73a9
	ld [wCutsceneScrollX], a ; $73aa
	ldh [hScrollX], a ; $73ad
.done:
	ret ; $73af
ScrollCutsceneXLeftTaskTable:
	; $73b0, 20 bytes (bytes:16)
	db $0a, $0a, $0a, $0a, $0a, $0a, $08, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; 0x00
	db $00, $00, $00, $00 ; 0x10
ScrollCutsceneLeftTask:
	ld a, [wCutsceneStepTimer] ; $73c4
	cp a, $10 ; $73c7
	jr nc, .done ; $73c9
	ld hl, ScrollCutsceneLeftTaskTable ; $73cb
	add a, l ; $73ce
	ld l, a ; $73cf
	jr nc, .read ; $73d0
	inc h ; $73d2
.read:
	ld a, [hl] ; $73d3
	ld b, a ; $73d4
	ld a, [wCutsceneScrollX] ; $73d5
	sub a, b ; $73d8
	ld [wCutsceneScrollX], a ; $73d9
	ldh [hScrollX], a ; $73dc
.done:
	ret ; $73de
ScrollCutsceneLeftTaskTable:
	; $73df, 19 bytes (bytes:16)
	db $0a, $0a, $0a, $0a, $0a, $0a, $0a, $02, $01, $00, $00, $00, $00, $00, $00, $00 ; 0x00
	db $00, $00, $00 ; 0x10
DecompressIntroTitleTiles:
	ldh a, [hWramBank] ; $73f2
	push af ; $73f4
	wram_bank $01 ; $73f5
	ld hl, DecompressIntroTitleTiles0 ; $73fb -> DataPtr_IntroAwesomeTiles
	ld de, $d000 ; $73fe
	call DecompressDataFromBank ; $7401
	ld hl, $d000 ; $7404
	ld de, $9000 ; $7407
	ld c, $80 ; $740a
	call QueueVRAMCopy ; $740c
	ld hl, $d800 ; $740f
	ld de, $8800 ; $7412
	ld c, $80 ; $7415
	call QueueVRAMCopy ; $7417
	wram_bank $05 ; $741a
	ld hl, DecompressIntroTitleTiles1 ; $7420
	ld de, $d000 ; $7423
	call DecompressData ; $7426
	ld hl, DecompressIntroTitleTiles2 ; $7429
	ld de, $d400 ; $742c
	call DecompressData ; $742f
	pop af ; $7432
	wram_bank ; $7433
	ret ; $7437
DecompressIntroTitleTiles1:
	INCBIN "data/bank_06b/d_7438.bin" ; $7438, 221 bytes
DecompressIntroTitleTiles2:
	INCBIN "data/bank_06b/d_7515.bin" ; $7515, 84 bytes
ApplyScrollYFromWram:
	ld a, [$cb44] ; $7569
	ldh [hScrollY], a ; $756c
	ret ; $756e
Palettes_6b_756f:
	INCLUDE "data/bank_06b/palettes_756f.asm" ; $756f, 64 bytes (palettes)
RunTitleScreen:
	call ClearFrameTasks ; $75af
	wram_bank $03 ; $75b2
	xor a, a ; $75b8
	ldh [hScrollX], a ; $75b9
	ldh [hScrollY], a ; $75bb
	ld [w3_d800], a ; $75bd
	ld [wResultScreenMode], a ; $75c0
	ld [w3_d802], a ; $75c3
	ld a, $98 ; $75c6
	ld [w3_d800], a ; $75c8
	ld c, $7f ; $75cb
	call BeginFadeOut ; $75cd
	call WaitFadeEnd ; $75d0
	call DisableLCDSafely ; $75d3
	ld c, $7f ; $75d6
	call BeginFadeOut ; $75d8
	call WaitFadeEnd ; $75db
	ld c, $1f ; $75de
	farcall LoadScreenAssetRecord ; $75e0
	farcall QueueWram3MapToVRAM ; $75e3
	ld c, $14 ; $75e6
	ld b, $5b ; $75e8
	ld de, $a000 ; $75ea
	farcall LoadCompressedTileBlock ; $75ed
	ld c, $14 ; $75f0
	ld b, $5c ; $75f2
	ld de, $a200 ; $75f4
	farcall LoadCompressedTileBlock ; $75f7
	ld c, $14 ; $75fa
	ld b, $5d ; $75fc
	ld de, $a400 ; $75fe
	farcall LoadCompressedTileBlock ; $7601
	ld c, $14 ; $7604
	ld b, $5e ; $7606
	ld de, $a600 ; $7608
	farcall LoadCompressedTileBlock ; $760b
	ld c, $14 ; $760e
	ld b, $5f ; $7610
	ld de, $8000 ; $7612
	farcall LoadCompressedTileBlock ; $7615
	ld c, $14 ; $7618
	ld b, $60 ; $761a
	ld de, $8200 ; $761c
	farcall LoadCompressedTileBlock ; $761f
	ld c, $14 ; $7622
	ld b, $61 ; $7624
	ld de, $8400 ; $7626
	farcall LoadCompressedTileBlock ; $7629
	ld c, $14 ; $762c
	ld b, $62 ; $762e
	ld de, $8600 ; $7630
	farcall LoadCompressedTileBlock ; $7633
	ld hl, Palettes_6b_794f ; $7636
	ld de, $0801 ; $7639
	call LoadPaletteShadow ; $763c
	ld a, $01 ; $763f
	ld hl, QueueTitleSprite ; $7641
	call RegisterFrameTask ; $7644
	sound $02 ; $7647
	call EnableLCD ; $7649
	script_fade_in $04 ; $764c
	call WaitFadeEnd ; $7651
	wram_bank $03 ; $7654
	ld a, $9f ; $765a
	ld [w3_d800], a ; $765c
.loop:
	call StepTitleSpriteAnimation ; $765f
	call AdvanceFrame ; $7662
	ldh a, [hInputRisingEdge] ; $7665
	bit PADB_A, a ; $7667
	jr nz, .playSfx ; $7669
	bit 3, a ; $766b
	jr nz, .playSfx ; $766d
	ldh a, [hVBlankCounter] ; $766f
	and a, $07 ; $7671
	jr nz, .loop ; $7673
	ld a, [w3_d800] ; $7675
	inc a ; $7678
	ld [w3_d800], a ; $7679
	jr z, .playSfx2 ; $767c
	jr .loop ; $767e
.playSfx:
	sound $00 ; $7680
	sound $60 ; $7682
	call ClearFrameTasks ; $7684
	ld c, $10 ; $7687
	call BeginFadeOut ; $7689
	call WaitFadeEnd ; $768c
	xor a, a ; $768f
	ret ; $7690
	sound $00 ; $7691
	call ClearFrameTasks ; $7693
	ld c, $20 ; $7696
	call BeginFadeOut ; $7698
	call WaitFadeEnd ; $769b
	ld hl, rIE ; $769e
	res 1, [hl] ; $76a1
	ld a, $01 ; $76a3
	ret ; $76a5
.playSfx2:
	sound $00 ; $76a6
	call ClearFrameTasks ; $76a8
	ld c, $08 ; $76ab
	call BeginFadeOut ; $76ad
	call WaitFadeEnd ; $76b0
	ld a, $ff ; $76b3
	ret ; $76b5
QueueTitleSprite:
	ldh a, [hWramBank] ; $76b6
	push af ; $76b8
	wram_bank $03 ; $76b9
	ld a, [wResultScreenMode] ; $76bf
	ld hl, TitleSpriteTable0 ; $76c2
	add a, l ; $76c5
	ld l, a ; $76c6
	jr nc, .read ; $76c7
	inc h ; $76c9
.read:
	ld c, [hl] ; $76ca
	ld a, [wResultScreenMode] ; $76cb
	ld hl, TitleSpriteTable1 ; $76ce
	add a, l ; $76d1
	ld l, a ; $76d2
	jr nc, .readB ; $76d3
	inc h ; $76d5
.readB:
	ld b, [hl] ; $76d6
	ld de, $2858 ; $76d7
	ld hl, SpriteTemplate_6b_76f6 ; $76da
	call QueueSpriteTemplate ; $76dd
	pop af ; $76e0
	wram_bank ; $76e1
	ret ; $76e5
TitleSpriteTable0:
	; $76e6, 8 bytes (bytes:8)
	db $00, $20, $40, $60, $00, $20, $40, $60 ; 0x00
TitleSpriteTable1:
	; $76ee, 8 bytes (bytes:8)
	db $08, $08, $08, $08, $00, $00, $00, $00 ; 0x00
SpriteTemplate_6b_76f6:
	; $76f6, 41 bytes (sprite_template)
	oam_sprite $10, $08, $00, $00
	oam_sprite $10, $10, $02, $00
	oam_sprite $10, $18, $04, $00
	oam_sprite $10, $20, $06, $00
	oam_sprite $10, $28, $08, $00
	oam_sprite $10, $30, $0a, $00
	oam_sprite $10, $38, $0c, $00
	oam_sprite $10, $40, $0e, $00
	oam_sprite $10, $48, $10, $00
	oam_sprite $10, $50, $12, $00
	oam_sprite_end
StepTitleSpriteAnimation:
	ld a, [w3_d802] ; $771f
	or a, a ; $7722
	jr z, .zero ; $7723
	inc a ; $7725
	ld [w3_d802], a ; $7726
	cp a, $10 ; $7729
	jr nz, .done ; $772b
	xor a, a ; $772d
	ld [w3_d802], a ; $772e
	ret ; $7731
.zero:
	ldh a, [hVBlankCounter] ; $7732
	and a, $07 ; $7734
	cp a, $07 ; $7736
	jr nz, .done ; $7738
	ld a, [wResultScreenMode] ; $773a
	inc a ; $773d
	and a, $07 ; $773e
	ld [wResultScreenMode], a ; $7740
	cp a, $07 ; $7743
	jr nz, .done ; $7745
	ld a, $01 ; $7747
	ld [w3_d802], a ; $7749
.done:
	ret ; $774c
	ret ; $774d
TitleScreenTilemap:
	INCBIN "data/bank_06b/lz_774e.bin" ; $774e, 292 bytes
TitleScreenAttrmap:
	INCBIN "data/bank_06b/lz_7872.bin" ; $7872, 157 bytes
TitleScreenPalettes:
	INCLUDE "data/bank_06b/palettes_790f.asm" ; $790f, 64 bytes (palettes)
Palettes_6b_794f:
	INCLUDE "data/bank_06b/palettes_794f.asm" ; $794f, 8 bytes (palettes)
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
	; $7fd8, 40 bytes fill to bank end (linker-padded)
