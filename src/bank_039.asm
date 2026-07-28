SECTION "ROM Bank $39", ROMX[$4000], BANK[$39]

	farptr LoadScreenAssetRecord ; $4000
	farptr QueueWram3MapToVRAM ; $4002
	farptr UpdateAnimatedTiles ; $4004
	farptr LoadFixedTileBlockAndPalette ; $4006
	farptr LoadFixedBgPalette0 ; $4008
	farptr CopyTilemapRect ; $400a
	farptr FillTilemapRect ; $400c
	farptr LoadIndexedPalette ; $400e
	farptr LoadCompressedTileBlock ; $4010
	farptr LoadFixedPaletteSet ; $4012
	farptr ApplySpriteWaveOffset ; $4014
	farptr ApplySpriteBobOffset ; $4016
	farptr LoadMenuArrowSpriteTiles ; $4018
	farptr QueueStackedSpritePair ; $401a
	farptr LoadStadiumBgGraphics ; $401c
	farptr FlushWram3MapRows ; $401e
	farptr RestoreMenuBgAndDrawPanel ; $4020
	farptr ResetScreenAndTextWindows ; $4022
	farptr InitMenuBgScroll ; $4024
	farptr LoadMenuSpritePalettePair ; $4026
	farptr TickMenuBgScroll ; $4028
	farptr LoadMenuFontTiles ; $402a
	farptr QueueWram3MapToVRAMAlias1, QueueWram3MapToVRAM ; $402c
	farptr QueueWram3MapToVRAMAlias2, QueueWram3MapToVRAM ; $402e
	farptr QueueWram3MapToVRAMAlias3, QueueWram3MapToVRAM ; $4030
	farptr QueueWram3MapToVRAMAlias4, QueueWram3MapToVRAM ; $4032
DataPtr_SharedMenuGfx17:
	dw SharedMenuGfx17 ; $4034
DataPtr_SharedMenuGfx17Alias1:
	dw SharedMenuGfx17 ; $4036
DataPtr_SharedMenuGfx17Alias2:
	dw SharedMenuGfx17 ; $4038
DataPtr_SharedMenuGfx17Alias3:
	dw SharedMenuGfx17 ; $403a
DataPtr_SharedMenuGfx17Alias4:
	dw SharedMenuGfx17 ; $403c
DataPtr_SharedMenuGfx17Alias5:
	dw SharedMenuGfx17 ; $403e
DataPtr_SharedMenuGfx17Alias6:
	dw SharedMenuGfx17 ; $4040
DataPtr_SharedMenuGfx17Alias7:
	dw SharedMenuGfx17 ; $4042
DataPtr_SharedMenuGfx17Alias8:
	dw SharedMenuGfx17 ; $4044
DataPtr_SharedMenuGfx17Alias9:
	dw SharedMenuGfx17 ; $4046
DataPtr_SharedMenuGfx17Alias10:
	dw SharedMenuGfx17 ; $4048
DataPtr_SharedMenuGfx17Alias11:
	dw SharedMenuGfx17 ; $404a
DataPtr_SharedMenuGfx17Alias12:
	dw SharedMenuGfx17 ; $404c
DataPtr_SharedMenuGfx17Alias13:
	dw SharedMenuGfx17 ; $404e
DataPtr_SharedMenuGfx17Alias14:
	dw SharedMenuGfx17 ; $4050
DataPtr_SharedMenuGfx17Alias15:
	dw SharedMenuGfx17 ; $4052
DataPtr_SharedMenuGfx17Alias16:
	dw SharedMenuGfx17 ; $4054
DataPtr_SharedMenuGfx17Alias17:
	dw SharedMenuGfx17 ; $4056
DataPtr_NameEntryGfx:
	dw NameEntryGfx ; $4058
DataPtr_CharacterSelectGfx:
	dw CharacterSelectGfx ; $405a
DataPtr_NumberSpriteGfxWideGfx:
	dw NumberSpriteGfxWideGfx ; $405c
DataPtr_StatLabelTiles:
	dw StatLabelTiles ; $405e
	farptr FillMenuGridCellTile ; $4060
	farptr MoveMinigameGridCursor ; $4062
	farptr InitNumberSpriteGfx ; $4064
	farptr DrawDecimalNumberSprites_39 ; $4066
	farptr ResetCheatCodeBuffer ; $4068
	farptr UpdateCheatCodeEntry ; $406a
DataPtr_RacketShoesChoiceGfx0:
	dw RacketShoesChoiceGfx0 ; $406c
DataPtr_RacketShoesChoiceGfx1:
	dw RacketShoesChoiceGfx1 ; $406e
DataPtr_MenuArrowGfx0:
	dw MenuArrowGfx0 ; $4070
DataPtr_MenuArrowGfx1:
	dw MenuArrowGfx1 ; $4072
DataPtr_MenuArrowGfx2:
	dw MenuArrowGfx2 ; $4074
DataPtr_MenuArrowGfx3:
	dw MenuArrowGfx3 ; $4076
DataPtr_CharGridGfx2:
	dw CharGridGfx2 ; $4078
DataPtr_DigitFontTiles:
	dw DigitFontTiles ; $407a
	farptr FillIncrementingBytes ; $407c
LoadScreenAssetRecord:
	ld hl, ScreenAssetRecordTable ; $407e
	ld b, $00 ; $4081
	sla c ; $4083
	rl b ; $4085
	sla c ; $4087
	rl b ; $4089
	sla c ; $408b
	rl b ; $408d
	add hl, bc ; $408f
	wram_bank $01 ; $4090
	push hl ; $4096
	ld a, [hl+] ; $4097
	ld h, [hl] ; $4098
	ld l, a ; $4099
	ld de, $d000 ; $409a
	call DecompressDataFromBank ; $409d
	ld hl, $d000 ; $40a0
	ld de, $b000 ; $40a3
	ld c, $80 ; $40a6
	call QueueVRAMCopy ; $40a8
	ld hl, $d800 ; $40ab
	ld de, $a800 ; $40ae
	ld c, $80 ; $40b1
	call QueueVRAMCopy ; $40b3
	pop hl ; $40b6
	inc hl ; $40b7
	inc hl ; $40b8
	push hl ; $40b9
	ld a, [hl+] ; $40ba
	ld h, [hl] ; $40bb
	ld l, a ; $40bc
	wram_bank $03 ; $40bd
	ld de, wShadowTilemap ; $40c3
	call DecompressDataFromBank ; $40c6
	pop hl ; $40c9
	inc hl ; $40ca
	inc hl ; $40cb
	push hl ; $40cc
	ld a, [hl+] ; $40cd
	ld h, [hl] ; $40ce
	ld l, a ; $40cf
	ld de, wShadowAttrmap ; $40d0
	call DecompressDataFromBank ; $40d3
	pop hl ; $40d6
	inc hl ; $40d7
	inc hl ; $40d8
	ld a, [hl+] ; $40d9
	ld h, [hl] ; $40da
	ld l, a ; $40db
	wram_bank $01 ; $40dc
	ld de, $d000 ; $40e2
	ld bc, $0040 ; $40e5
	call CopyDataFromBank ; $40e8
	ld hl, $d000 ; $40eb
	ld de, $0008 ; $40ee
	call LoadPaletteShadow ; $40f1
	ret ; $40f4
ScreenAssetRecordTable:
	; $40f5, 560 bytes (70 records x 4 slot words)
	dslot DataPtr_NameEntryTilemapAlias9, DataPtr_NameEntryTilemapAlias10, DataPtr_NameEntryTilemapAlias11, DataPtr_NameEntryTilemapAlias12 ; record 0
	dslot DataPtr_ExhibitionSetupTiles, DataPtr_ExhibitionSetupTilemap, DataPtr_ExhibitionSetupAttrmap, DataPtr_ExhibitionSetupPalettes ; record 1
	dslot DataPtr_MainMenuGfx5, DataPtr_MainMenuGfx5Alias1, DataPtr_MainMenuGfx5Alias2, DataPtr_MainMenuGfx5Alias3 ; record 2
	dslot DataPtr_NameEntryTilemapAlias9, DataPtr_NameEntryTilemapAlias10, DataPtr_NameEntryTilemapAlias11, DataPtr_NameEntryTilemapAlias12 ; record 3
	dslot DataPtr_JapanesePlayModeTiles, DataPtr_JapanesePlayModeTilemap, DataPtr_JapanesePlayModeAttrmap, DataPtr_JapanesePlayModePalettes ; record 4
	dslot DataPtr_CharacterSelectTiles, DataPtr_CharacterSelectTilemap, DataPtr_CharacterSelectAttrmap, DataPtr_CharacterSelectPalettes ; record 5
	dslot DataPtr_CharacterSelectTiles, DataPtr_NameEntryTilemapAlias8, DataPtr_NameEntryAttrmap, DataPtr_CharacterSelectPalettes ; record 6
	dslot DataPtr_CharacterSelectTiles, DataPtr_CharSelectAltTilemap, DataPtr_CharSelectAltAttrmap, DataPtr_CharacterSelectPalettes ; record 7
	dslot DataPtr_NameEntryTilemap, DataPtr_NameEntryTilemapAlias1, DataPtr_NameEntryTilemapAlias2, DataPtr_NameEntryTilemapAlias3 ; record 8
	dslot FarPtr_QueueWram3MapToVRAMAlias1, FarPtr_QueueWram3MapToVRAMAlias2, FarPtr_QueueWram3MapToVRAMAlias3, FarPtr_QueueWram3MapToVRAMAlias4 ; record 9
	dslot DataPtr_NameEntryTilemap, DataPtr_NameEntryTilemapAlias4, DataPtr_NameEntryTilemapAlias5, DataPtr_NameEntryTilemapAlias3 ; record 10
	dslot DataPtr_NameEntryTilemap, DataPtr_NameEntryTilemapAlias6, DataPtr_NameEntryTilemapAlias7, DataPtr_NameEntryTilemapAlias3 ; record 11
	dslot DataPtr_ExhibitionMenuTiles, DataPtr_ExhibitionMenuTilemap, DataPtr_ExhibitionMenuAttrmap, DataPtr_ExhibitionMenuPalettes ; record 12
	dslot DataPtr_N64TournamentTiles, DataPtr_N64TournamentTilemap, DataPtr_N64TournamentAttrmap, DataPtr_N64TournamentPalettes ; record 13
	dslot DataPtr_N64TournamentTiles, DataPtr_N64TournamentTilemap2, DataPtr_N64TournamentAttrmap2, DataPtr_N64TournamentPalettes ; record 14
	dslot DataPtr_ModeSelectTiles, DataPtr_ModeSelectTilemap, DataPtr_ModeSelectAttrmap, DataPtr_ModeSelectPalettes ; record 15
	dslot DataPtr_WarningScreenTiles, DataPtr_WarningScreenTilemap, DataPtr_WarningScreenAttrmap, DataPtr_WarningScreenPalettes ; record 16
	dslot DataPtr_LinkingScreenTiles, DataPtr_LinkingScreenTilemap, DataPtr_LinkingScreenAttrmap, DataPtr_LinkingScreenPalettes ; record 17
	dslot DataPtr_RingShotHudTiles, DataPtr_RingShotHudTilemap, DataPtr_RingShotHudAttrmap, DataPtr_RingShotHudPalettes ; record 18
	dslot DataPtr_MatchStatsTiles, DataPtr_MatchStatsTilemap, DataPtr_MatchStatsAttrmap, DataPtr_MatchStatsPalettes ; record 19
	dslot DataPtr_MatchStatsTiles, DataPtr_MatchStatsTilemap2, DataPtr_MatchStatsAttrmap2, DataPtr_MatchStatsPalettes ; record 20
	dslot DataPtr_CompanyLogosTiles, DataPtr_CompanyLogosTilemap, DataPtr_CompanyLogosAttrmap, DataPtr_CompanyLogosPalettes ; record 21
	dslot DataPtr_IntroRalliesTiles, DataPtr_IntroRalliesTilemap, DataPtr_IntroRalliesAttrmap, DataPtr_IntroRalliesPalettes ; record 22
	dslot DataPtr_IntroRalliesTiles, DataPtr_IntroRalliesTilemap2, DataPtr_IntroRalliesAttrmap2, DataPtr_IntroRalliesPalettes ; record 23
	dslot DataPtr_IntroRalliesTiles, DataPtr_IntroRalliesTilemap3, DataPtr_IntroRalliesAttrmap3, DataPtr_IntroRalliesPalettes ; record 24
	dslot DataPtr_IntroRalliesTiles, DataPtr_IntroRalliesTilemap4, DataPtr_IntroRalliesAttrmap4, DataPtr_IntroRalliesPalettes ; record 25
	dslot DataPtr_IntroSwingTiles, DataPtr_IntroSwingTilemap, DataPtr_IntroSwingAttrmap, DataPtr_IntroSwingPalettes ; record 26
	dslot DataPtr_IntroCloseupTiles, DataPtr_IntroCloseupTilemap, DataPtr_IntroCloseupAttrmap, DataPtr_IntroCloseupPalettes ; record 27
	dslot DataPtr_IntroWaveTiles, DataPtr_IntroWaveTilemap, DataPtr_IntroWaveAttrmap, DataPtr_IntroWavePalettes ; record 28
	dslot DataPtr_IntroDiveTiles, DataPtr_IntroDiveTilemap, DataPtr_IntroDiveAttrmap, DataPtr_IntroDivePalettes ; record 29
	dslot DataPtr_IntroGirlSwingTiles, DataPtr_IntroGirlSwingTilemap, DataPtr_IntroGirlSwingAttrmap, DataPtr_IntroGirlSwingPalettes ; record 30
	dslot DataPtr_TitleScreenTiles, DataPtr_TitleScreenTilemap, DataPtr_TitleScreenAttrmap, DataPtr_TitleScreenPalettes ; record 31
	dslot FarPtr_DecompressIntroTitleTiles, FarPtr_DecompressIntroTitleTilesAlias1, FarPtr_DecompressIntroTitleTilesAlias2, FarPtr_DecompressIntroTitleTilesAlias3 ; record 32
	dslot DataPtr_EquipmentSelectTiles, DataPtr_EquipmentSelectTilemap, DataPtr_EquipmentSelectAttrmap, DataPtr_EquipmentSelectPalettes ; record 33
	dslot DataPtr_LinkErrorTiles, DataPtr_LinkErrorTilemap, DataPtr_LinkErrorAttrmap, DataPtr_LinkErrorPalettes ; record 34
	dslot DataPtr_MatchStatsTiles, DataPtr_MatchStatsTilemap3, DataPtr_MatchStatsAttrmap3, DataPtr_MatchStatsPalettes ; record 35
	dslot DataPtr_CourtDiagramTiles, DataPtr_CourtDiagramTilemap, DataPtr_CourtDiagramAttrmap, DataPtr_CourtDiagramPalettes ; record 36
	dslot DataPtr_VarsityTeamChartTiles, DataPtr_VarsityTeamChartTilemap, DataPtr_VarsityTeamChartAttrmap, DataPtr_VarsityTeamChartPalettes ; record 37
	dslot DataPtr_VarsityTeamChartTiles, DataPtr_VarsityTeamChartTilemap2, DataPtr_VarsityTeamChartAttrmap2, DataPtr_VarsityTeamChartPalettes ; record 38
	dslot DataPtr_IntroGreatestPlayerTiles, DataPtr_IntroGreatestPlayerTilemap, DataPtr_IntroGreatestPlayerAttrmap, DataPtr_IntroGreatestPlayerPalettes ; record 39
	dslot DataPtr_IntroCharacterIcon00, DataPtr_IntroCharacterIcon00Alias1, DataPtr_IntroCharacterIcon00Alias2, DataPtr_IntroCharacterIcon00Alias3 ; record 40
	dslot DataPtr_TournamentBracketTiles, DataPtr_TournamentBracketSinglesTilemap, DataPtr_TournamentBracketSinglesAttrmap, DataPtr_TournamentBracketPalettes ; record 41
	dslot DataPtr_TournamentBracketTiles, DataPtr_TournamentBracketDoublesTilemap, DataPtr_TournamentBracketDoublesAttrmap, DataPtr_TournamentBracketPalettes ; record 42
	dslot DataPtr_MarioMiniGamesTiles, DataPtr_MarioMiniGamesTilemap, DataPtr_MarioMiniGamesAttrmap, DataPtr_MarioMiniGamesPalettes ; record 43
	dslot DataPtr_VictoryCutsceneTiles, DataPtr_VictoryCutsceneTilemap, DataPtr_VictoryCutsceneAttrmap, DataPtr_VictoryCutscenePalettes ; record 44
	dslot DataPtr_VictoryCutsceneTiles, DataPtr_VictoryCutsceneTilemap2, DataPtr_VictoryCutsceneAttrmap2, DataPtr_VictoryCutscenePalettes ; record 45
	dslot DataPtr_VictoryCutsceneTiles, DataPtr_VictoryCutsceneTilemap3, DataPtr_VictoryCutsceneAttrmap3, DataPtr_VictoryCutscenePalettes ; record 46
	dslot DataPtr_VictoryCutsceneTiles, DataPtr_VictoryCutsceneTilemap4, DataPtr_VictoryCutsceneAttrmap4, DataPtr_VictoryCutscenePalettes ; record 47
	dslot DataPtr_VictoryCutsceneTiles, DataPtr_VictoryCutsceneTilemap5, DataPtr_VictoryCutsceneAttrmap5, DataPtr_VictoryCutscenePalettes ; record 48
	dslot DataPtr_VictoryCutsceneTiles, DataPtr_VictoryCutsceneTilemap6, DataPtr_VictoryCutsceneAttrmap6, DataPtr_VictoryCutscenePalettes ; record 49
	dslot DataPtr_ShopCutsceneTiles, DataPtr_ShopCutsceneTilemap, DataPtr_ShopCutsceneAttrmap, DataPtr_ShopCutscenePalettes ; record 50
	dslot DataPtr_ShopCutsceneTiles, DataPtr_ShopCutsceneTilemap2, DataPtr_ShopCutsceneAttrmap2, DataPtr_ShopCutscenePalettes ; record 51
	dslot DataPtr_ShopCutsceneTiles, DataPtr_ShopCutsceneTilemap3, DataPtr_ShopCutsceneAttrmap3, DataPtr_ShopCutscenePalettes ; record 52
	dslot DataPtr_ShopCutsceneTiles, DataPtr_ShopCutsceneTilemap4, DataPtr_ShopCutsceneAttrmap4, DataPtr_ShopCutscenePalettes ; record 53
	dslot DataPtr_ShopCutsceneTiles, DataPtr_ShopCutsceneTilemap5, DataPtr_ShopCutsceneAttrmap5, DataPtr_ShopCutscenePalettes ; record 54
	dslot DataPtr_ShopCutsceneTiles, DataPtr_ShopCutsceneTilemap6, DataPtr_ShopCutsceneAttrmap6, DataPtr_ShopCutscenePalettes ; record 55
	dslot DataPtr_AwardCeremonyTilesAlias4, DataPtr_AwardCeremonyTilemap, DataPtr_AwardCeremonyAttrmap, DataPtr_AwardCeremonyPalettes ; record 56
	dslot DataPtr_AwardCeremonyTilesAlias4, DataPtr_AwardCeremonyTilemap2, DataPtr_AwardCeremonyAttrmap2, DataPtr_AwardCeremonyPalettes ; record 57
	dslot DataPtr_AwardCeremonyTilesAlias4, DataPtr_AwardCeremonyTilemap3, DataPtr_AwardCeremonyAttrmap3, DataPtr_AwardCeremonyPalettes ; record 58
	dslot DataPtr_AwardCeremonyTilesAlias4, DataPtr_AwardCeremonyTilemap4, DataPtr_AwardCeremonyAttrmap4, DataPtr_AwardCeremonyPalettes ; record 59
	dslot DataPtr_AwardCeremonyTilesAlias4, DataPtr_AwardCeremonyTilemap5, DataPtr_AwardCeremonyAttrmap5, DataPtr_AwardCeremonyPalettes ; record 60
	dslot DataPtr_AwardCeremonyTilesAlias4, DataPtr_AwardCeremonyTilemap6, DataPtr_AwardCeremonyAttrmap6, DataPtr_AwardCeremonyPalettes ; record 61
	dslot DataPtr_ChampionMedalTiles, DataPtr_ChampionMedalTilemap, DataPtr_ChampionMedalAttrmap, DataPtr_ChampionMedalPalettes ; record 62
	dslot DataPtr_ChampionMedalTiles, DataPtr_ChampionMedalTilemap2, DataPtr_ChampionMedalAttrmap2, DataPtr_ChampionMedalPalettes ; record 63
	dslot DataPtr_ChampionMedalTiles, DataPtr_ChampionMedalTilemap3, DataPtr_ChampionMedalAttrmap3, DataPtr_ChampionMedalPalettes ; record 64
	dslot DataPtr_ChampionMedalTiles, DataPtr_ChampionMedalTilemap4, DataPtr_ChampionMedalAttrmap4, DataPtr_ChampionMedalPalettes ; record 65
	dslot DataPtr_ChampionMedalTiles, DataPtr_ChampionMedalTilemap5, DataPtr_ChampionMedalAttrmap5, DataPtr_ChampionMedalPalettes ; record 66
	dslot DataPtr_ChampionMedalTiles, DataPtr_ChampionMedalTilemap6, DataPtr_ChampionMedalAttrmap6, DataPtr_ChampionMedalPalettes ; record 67
	dslot DataPtr_RulesScreenTiles, DataPtr_RulesScreenTilemap, DataPtr_RulesScreenAttrmap, DataPtr_RulesScreenPalettes ; record 68
	dslot DataPtr_AwardCeremonyTiles, DataPtr_AwardCeremonyTilesAlias1, DataPtr_AwardCeremonyTilesAlias2, DataPtr_AwardCeremonyTilesAlias3 ; record 69
QueueWram3MapToVRAM:
	wram_bank $03 ; $4325
	ld hl, wShadowTilemap ; $432b
	ld de, $9800 ; $432e
	ld c, $40 ; $4331
	call QueueVRAMCopy ; $4333
	ld hl, wShadowAttrmap ; $4336
	ld de, $b800 ; $4339
	ld c, $40 ; $433c
	call QueueVRAMCopy ; $433e
	ret ; $4341
UpdateAnimatedTiles:
	push af ; $4342
	push bc ; $4343
	push de ; $4344
	push hl ; $4345
	ldh a, [hWramBank] ; $4346
	push af ; $4348
	ld a, [$cb0a] ; $4349
	inc a ; $434c
	ld c, a ; $434d
	ld a, [wAnimatedTilePeriod] ; $434e
	ld b, a ; $4351
	ld a, c ; $4352
	add a ; $4353
	jr nc, .countUp ; $4354
	ld a, b ; $4356
	dec a ; $4357
	jr .storeCounter ; $4358
.countUp:
	rra ; $435a
	cp b ; $435b
	jr c, .storeCounter ; $435c
	xor a ; $435e
.storeCounter:
	ld [$cb0a], a ; $435f
	or a ; $4362
	jp nz, .done ; $4363
	wram_bank $02 ; $4366
	ld a, [$cb09] ; $436c
	inc a ; $436f
	ld [$cb09], a ; $4370
	and $0f ; $4373
	rlca ; $4375
	push af ; $4376
	ld a, [wAnimatedTileSet] ; $4377
	and $03 ; $437a
	add a ; $437c
	ld hl, UpdateAnimatedTilesTable ; $437d
	add l ; $4380
	ld l, a ; $4381
	jr nc, .readFrameTableA ; $4382
	inc h ; $4384
.readFrameTableA:
	ld a, [hl+] ; $4385
	ld h, [hl] ; $4386
	ld l, a ; $4387
	ld a, h ; $4388
	ld b, l ; $4389
	and b ; $438a
	cp $ff ; $438b
	jr z, .frameB ; $438d
	pop af ; $438f
	push af ; $4390
	add l ; $4391
	ld l, a ; $4392
	jr nc, .readFrameA ; $4393
	inc h ; $4395
.readFrameA:
	ld a, [hl+] ; $4396
	ld h, [hl] ; $4397
	ld l, a ; $4398
	wram_bank $01 ; $4399
	ld de, $d000 ; $439f
	call DecompressDataFromBank ; $43a2
	ld hl, $d000 ; $43a5
	ld de, $b2e0 ; $43a8
	ld c, $02 ; $43ab
	call QueueVRAMCopy ; $43ad
	ld hl, $d020 ; $43b0
	ld de, $b3e0 ; $43b3
	ld c, $02 ; $43b6
	call QueueVRAMCopy ; $43b8
.frameB:
	ld a, [wAnimatedTileSet] ; $43bb
	and $03 ; $43be
	add a ; $43c0
	ld hl, AnimatedTilesTable0 ; $43c1
	add l ; $43c4
	ld l, a ; $43c5
	jr nc, .readFrameTableB ; $43c6
	inc h ; $43c8
.readFrameTableB:
	ld a, [hl+] ; $43c9
	ld h, [hl] ; $43ca
	ld l, a ; $43cb
	pop af ; $43cc
	ld c, a ; $43cd
	ld a, h ; $43ce
	and l ; $43cf
	cp $ff ; $43d0
	jr z, .done ; $43d2
	ld a, c ; $43d4
	add l ; $43d5
	ld l, a ; $43d6
	jr nc, .readFrameB ; $43d7
	inc h ; $43d9
.readFrameB:
	ld a, [hl+] ; $43da
	ld h, [hl] ; $43db
	ld l, a ; $43dc
	ld de, $d100 ; $43dd
	call DecompressDataFromBank ; $43e0
	ld hl, $d100 ; $43e3
	ld de, $b4e0 ; $43e6
	ld c, $02 ; $43e9
	call QueueVRAMCopy ; $43eb
	ld hl, $d120 ; $43ee
	ld de, $b5e0 ; $43f1
	ld c, $02 ; $43f4
	call QueueVRAMCopy ; $43f6
.done:
	pop af ; $43f9
	wram_bank ; $43fa
	pop hl ; $43fe
	pop de ; $43ff
	pop bc ; $4400
	pop af ; $4401
	ret ; $4402
UpdateAnimatedTilesTable:
	; $4403, 8 bytes (records:2)
	dw AnimatedTilesTable1 ; record 0
	dw AnimatedTilesTable2 ; record 1
	dw AnimatedTilesTable3 ; record 2
	dw AnimatedTilesTable4 ; record 3
AnimatedTilesTable0:
	; $440b, 8 bytes (records:2)
	dw $ffff ; record 0
	dw $ffff ; record 1
	dw AnimatedTilesTable4 ; record 2
	dw AnimatedTilesTable3 ; record 3
AnimatedTilesTable1:
	; $4413, 64 bytes (records:2)
	dw $6d32 ; record 0
	dw $6d34 ; record 1
	dw $6d36 ; record 2
	dw $6d38 ; record 3
	dw $6d3a ; record 4
	dw $6d3c ; record 5
	dw $6d3e ; record 6
	dw $6d40 ; record 7
	dw $6d42 ; record 8
	dw $6d44 ; record 9
	dw $6d46 ; record 10
	dw $6d48 ; record 11
	dw $6d4a ; record 12
	dw $6d4c ; record 13
	dw $6d4e ; record 14
	dw $6d50 ; record 15
	dw $6d52 ; record 16
	dw $6d54 ; record 17
	dw $6d56 ; record 18
	dw $6d58 ; record 19
	dw $6d5a ; record 20
	dw $6d5c ; record 21
	dw $6d5e ; record 22
	dw $6d60 ; record 23
	dw $6d62 ; record 24
	dw $6d64 ; record 25
	dw $6d66 ; record 26
	dw $6d68 ; record 27
	dw $6d6a ; record 28
	dw $6d6c ; record 29
	dw $6d6e ; record 30
	dw $6d70 ; record 31
AnimatedTilesTable2:
	; $4453, 64 bytes (records:2)
	dw $3f36 ; record 0
	dw $3f38 ; record 1
	dw $3f3a ; record 2
	dw $3f3c ; record 3
	dw $3f3e ; record 4
	dw $3f40 ; record 5
	dw $3f42 ; record 6
	dw $3f44 ; record 7
	dw $3f46 ; record 8
	dw $3f48 ; record 9
	dw $3f4a ; record 10
	dw $3f4c ; record 11
	dw $3f4e ; record 12
	dw $3f50 ; record 13
	dw $3f52 ; record 14
	dw $3f54 ; record 15
	dw $3f56 ; record 16
	dw $3f58 ; record 17
	dw $3f5a ; record 18
	dw $3f5c ; record 19
	dw $3f5e ; record 20
	dw $3f60 ; record 21
	dw $3f62 ; record 22
	dw $3f64 ; record 23
	dw $3f66 ; record 24
	dw $3f68 ; record 25
	dw $3f6a ; record 26
	dw $3f6c ; record 27
	dw $3f6e ; record 28
	dw $3f70 ; record 29
	dw $3f72 ; record 30
	dw $3f74 ; record 31
AnimatedTilesTable3:
	; $4493, 32 bytes (records:2)
	dw $1848 ; record 0
	dw $184a ; record 1
	dw $184c ; record 2
	dw $184e ; record 3
	dw $1850 ; record 4
	dw $1852 ; record 5
	dw $1854 ; record 6
	dw $1856 ; record 7
	dw $1858 ; record 8
	dw $185a ; record 9
	dw $185c ; record 10
	dw $185e ; record 11
	dw $1860 ; record 12
	dw $1862 ; record 13
	dw $1864 ; record 14
	dw $1866 ; record 15
AnimatedTilesTable4:
	; $44b3, 32 bytes (records:2)
	dw $1868 ; record 0
	dw $186a ; record 1
	dw $186c ; record 2
	dw $186e ; record 3
	dw $1870 ; record 4
	dw $1872 ; record 5
	dw $1874 ; record 6
	dw $1876 ; record 7
	dw $1878 ; record 8
	dw $187a ; record 9
	dw $187c ; record 10
	dw $187e ; record 11
	dw $1880 ; record 12
	dw $1882 ; record 13
	dw $1884 ; record 14
	dw $1886 ; record 15
LoadFixedTileBlockAndPalette:
	push de ; $44d3
	wram_bank $01 ; $44d4
	ld hl, FixedTileBlockAndPalette ; $44da
	ld de, $d000 ; $44dd
	call DecompressData ; $44e0
	ld hl, $d000 ; $44e3
	pop de ; $44e6
	ld c, $04 ; $44e7
	call QueueVRAMCopy ; $44e9
	ld hl, Palette_39_4516 ; $44ec
	ld de, $0801 ; $44ef
	call LoadPaletteShadow ; $44f2
	ret ; $44f5
FixedTileBlockAndPalette:
	INCBIN "data/bank_039/d_44f6.bin" ; $44f6, 32 bytes
Palette_39_4516:
	INCLUDE "data/bank_039/palettes_4516.asm" ; $4516, 8 bytes (palettes)
LoadFixedBgPalette0:
	ld de, $0001 ; $451e
	ld hl, Palette_39_4528 ; $4521
	call LoadPaletteShadow ; $4524
	ret ; $4527
Palette_39_4528:
	INCLUDE "data/bank_039/palettes_4528.asm" ; $4528, 8 bytes (palettes)
CopyTilemapRect:
	push af ; $4530
	push bc ; $4531
	push de ; $4532
	push hl ; $4533
.rowLoop:
	push bc ; $4534
	push hl ; $4535
	push de ; $4536
.colLoop:
	ld a, [hl+] ; $4537
	push hl ; $4538
	ld h, d ; $4539
	ld l, e ; $453a
	ld [hl+], a ; $453b
	ld d, h ; $453c
	ld e, l ; $453d
	pop hl ; $453e
	dec b ; $453f
	jr nz, .colLoop ; $4540
	pop de ; $4542
	pop hl ; $4543
	ld bc, $0020 ; $4544
	add hl, bc ; $4547
	push hl ; $4548
	ld h, d ; $4549
	ld l, e ; $454a
	add hl, bc ; $454b
	ld d, h ; $454c
	ld e, l ; $454d
	pop hl ; $454e
	pop bc ; $454f
	dec c ; $4550
	jr nz, .rowLoop ; $4551
	pop hl ; $4553
	pop de ; $4554
	pop bc ; $4555
	pop af ; $4556
	ret ; $4557
FillTilemapRect:
	push af ; $4558
	push bc ; $4559
	push de ; $455a
	push hl ; $455b
.rowLoop:
	push bc ; $455c
	push hl ; $455d
	push de ; $455e
.colLoop:
	ld a, h ; $455f
	push hl ; $4560
	ld h, d ; $4561
	ld l, e ; $4562
	ld [hl+], a ; $4563
	ld d, h ; $4564
	ld e, l ; $4565
	pop hl ; $4566
	dec b ; $4567
	jr nz, .colLoop ; $4568
	pop de ; $456a
	pop hl ; $456b
	ld bc, $0020 ; $456c
	push hl ; $456f
	ld h, d ; $4570
	ld l, e ; $4571
	add hl, bc ; $4572
	ld d, h ; $4573
	ld e, l ; $4574
	pop hl ; $4575
	pop bc ; $4576
	dec c ; $4577
	jr nz, .rowLoop ; $4578
	pop hl ; $457a
	pop de ; $457b
	pop bc ; $457c
	pop af ; $457d
	ret ; $457e
LoadIndexedPalette:
	ld e, c ; $457f
	ld d, $00 ; $4580
	sla e ; $4582
	rl d ; $4584
	sla e ; $4586
	rl d ; $4588
	sla e ; $458a
	rl d ; $458c
	ld hl, IndexedPalettes ; $458e
	add hl, de ; $4591
	ld d, b ; $4592
	ld e, $01 ; $4593
	call LoadPaletteShadow ; $4595
	ret ; $4598
IndexedPalettes:
	INCLUDE "data/bank_039/palettes_4599.asm" ; $4599, 200 bytes (palettes)
LoadFixedPaletteSet:
	ld hl, FixedPaletteSetPalettes ; $4661
	ld de, $0904 ; $4664
	call LoadPaletteShadow ; $4667
	ret ; $466a
FixedPaletteSetPalettes:
	INCLUDE "data/bank_039/palettes_466b.asm" ; $466b, 32 bytes (palettes)
LoadCompressedTileBlock:
	ldh a, [hWramBank] ; $468b
	push af ; $468d
	ld a, b ; $468e
	add a ; $468f
	ld hl, TileBlockPtrs_39 ; $4690
	add l ; $4693
	ld l, a ; $4694
	jr nc, .readPtr ; $4695
	inc h ; $4697
.readPtr:
	ld a, [hl+] ; $4698
	ld h, [hl] ; $4699
	ld l, a ; $469a
	push de ; $469b
	push bc ; $469c
	wram_bank $01 ; $469d
	ld de, $d000 ; $46a3
	call DecompressDataFromBank ; $46a6
	pop bc ; $46a9
	pop de ; $46aa
	ld hl, $d000 ; $46ab
	call QueueVRAMCopy ; $46ae
	pop af ; $46b1
	wram_bank ; $46b2
	ret ; $46b6
TileBlockPtrs_39:
	; $46b7, 244 bytes (122 records x 1 slot words)
	dslot DataPtr_ObjectSceneAGfx0 ; record 0
	dslot DataPtr_ObjectSceneAGfx1 ; record 1
	dslot DataPtr_ObjectSceneAGfx2 ; record 2
	dslot DataPtr_ObjectSceneBGfx0 ; record 3
	dslot DataPtr_ObjectSceneBGfx1 ; record 4
	dslot DataPtr_ObjectSceneBGfx2 ; record 5
	dslot DataPtr_Screen0Gfx ; record 6
	dslot DataPtr_Screen1ObjGfx ; record 7
	dslot DataPtr_Screen2ObjGfx ; record 8
	dslot DataPtr_MatchWinLoseGfx ; record 9
	dslot DataPtr_CharSelectMiscGfx ; record 10
	dslot DataPtr_SharedMenuGfx17Alias11 ; record 11
	dslot DataPtr_SharedMenuGfx17Alias12 ; record 12
	dslot DataPtr_SharedMenuGfx17Alias13 ; record 13
	dslot DataPtr_SharedMenuGfx17Alias14 ; record 14
	dslot DataPtr_SharedMenuGfx17Alias15 ; record 15
	dslot DataPtr_SharedMenuGfx17Alias16 ; record 16
	dslot DataPtr_SharedMenuGfx17Alias17 ; record 17
	dslot DataPtr_NameEntryGfx ; record 18
	dslot DataPtr_CharacterSelectGfx ; record 19
	dslot DataPtr_NumberSpriteGfxWideGfx ; record 20
	dslot DataPtr_StatLabelTiles ; record 21
	dslot DataPtr_MugshotTiles ; record 22
	dslot DataPtr_MenuArrowGfx0 ; record 23
	dslot DataPtr_MenuArrowGfx1 ; record 24
	dslot DataPtr_MenuArrowGfx2 ; record 25
	dslot DataPtr_MenuArrowGfx3 ; record 26
	dslot DataPtr_SharedMenuGfx27 ; record 27
	dslot DataPtr_MainMenuGfx0 ; record 28
	dslot DataPtr_SharedMenuGfx29 ; record 29
	dslot DataPtr_SharedMenuGfx30 ; record 30
	dslot DataPtr_MainMenuGfx1 ; record 31
	dslot DataPtr_MainMenuGfx2 ; record 32
	dslot DataPtr_MainMenuGfx3 ; record 33
	dslot DataPtr_MainMenuGfx4 ; record 34
	dslot DataPtr_SharedMenuGfx35 ; record 35
	dslot DataPtr_SharedMenuGfx36 ; record 36
	dslot DataPtr_SharedMenuGfx37 ; record 37
	dslot DataPtr_SharedMenuGfx38 ; record 38
	dslot DataPtr_SharedMenuGfx39 ; record 39
	dslot DataPtr_SharedMenuGfx40 ; record 40
	dslot DataPtr_SharedMenuGfx41 ; record 41
	dslot DataPtr_SavedDataSourceGfx0 ; record 42
	dslot DataPtr_SavedDataSourceGfx1 ; record 43
	dslot DataPtr_SavedDataSourceGfx2 ; record 44
	dslot DataPtr_SavedDataSourceGfx3 ; record 45
	dslot DataPtr_EraseSavedDataGfx0 ; record 46
	dslot DataPtr_EraseSavedDataGfx1 ; record 47
	dslot DataPtr_EraseSavedDataGfx2 ; record 48
	dslot DataPtr_EraseSavedDataGfx3 ; record 49
	dslot DataPtr_EraseSavedDataGfx4 ; record 50
	dslot DataPtr_MinigameSelectGfx0 ; record 51
	dslot DataPtr_MinigameSelectGfx1 ; record 52
	dslot DataPtr_MinigameSelectGfx2 ; record 53
	dslot DataPtr_MinigameSelectGfx3 ; record 54
	dslot DataPtr_MinigameSelectGfx4 ; record 55
	dslot DataPtr_MinigameSelectGfx5 ; record 56
	dslot DataPtr_N64RecordTypeGfx0 ; record 57
	dslot DataPtr_N64RecordTypeGfx1 ; record 58
	dslot DataPtr_N64TransferItemGfx0 ; record 59
	dslot DataPtr_N64TransferItemGfx1 ; record 60
	dslot DataPtr_N64TransferItemGfx2 ; record 61
	dslot DataPtr_MainMenuGfx5Alias4 ; record 62
	dslot DataPtr_SharedMenuGfx63 ; record 63
	dslot DataPtr_CourtSelectGfx0 ; record 64
	dslot DataPtr_SharedMenuGfx65 ; record 65
	dslot DataPtr_SavedDataSourceGfx4 ; record 66
	dslot DataPtr_N64RecordTypeGfx2 ; record 67
	dslot DataPtr_N64TransferItemGfx3 ; record 68
	dslot DataPtr_EraseDataConfirmGfx0 ; record 69
	dslot DataPtr_EraseDataConfirmGfx1 ; record 70
	dslot DataPtr_MinigameSelectGfx6 ; record 71
	dslot DataPtr_SharedMenuGfx72 ; record 72
	dslot DataPtr_NumberSpriteGfx ; record 73
	dslot DataPtr_RacketShoesChoiceGfx0 ; record 74
	dslot DataPtr_RacketShoesChoiceGfx1 ; record 75
	dslot DataPtr_RacketShoesChoiceGfx2 ; record 76
	dslot DataPtr_CutsceneGfx0 ; record 77
	dslot DataPtr_CutsceneGfx1 ; record 78
	dslot DataPtr_CutsceneGfx2 ; record 79
	dslot DataPtr_CutsceneGfx3 ; record 80
	dslot DataPtr_CutsceneGfx4 ; record 81
	dslot DataPtr_CutsceneGfx5 ; record 82
	dslot DataPtr_CutsceneGfx6 ; record 83
	dslot DataPtr_IntroGfx0 ; record 84
	dslot DataPtr_IntroGfx1 ; record 85
	dslot DataPtr_IntroGfx2 ; record 86
	dslot DataPtr_IntroGfx3 ; record 87
	dslot DataPtr_IntroGfx4 ; record 88
	dslot DataPtr_IntroGfx5 ; record 89
	dslot DataPtr_IntroGfx6 ; record 90
	dslot DataPtr_TitleGfx0 ; record 91
	dslot DataPtr_TitleGfx1 ; record 92
	dslot DataPtr_TitleGfx2 ; record 93
	dslot DataPtr_TitleGfx3 ; record 94
	dslot DataPtr_TitleGfx4 ; record 95
	dslot DataPtr_TitleGfx5 ; record 96
	dslot DataPtr_TitleGfx6 ; record 97
	dslot DataPtr_TitleGfx7 ; record 98
	dslot DataPtr_SharedMenuGfx99 ; record 99
	dslot DataPtr_CharGridGfx1 ; record 100
	dslot DataPtr_CourtSelectGfx1 ; record 101
	dslot DataPtr_CourtSelectGfx2 ; record 102
	dslot DataPtr_CourtSelectGfx3 ; record 103
	dslot DataPtr_CourtSelectGfx4 ; record 104
	dslot DataPtr_TournamentBracketGfx ; record 105
	dslot DataPtr_CourtSelectGfx5Alias16 ; record 106
	dslot DataPtr_CourtSelectGfx6 ; record 107
	dslot DataPtr_CourtSelectGfx7 ; record 108
	dslot DataPtr_CourtSelectGfx8 ; record 109
	dslot DataPtr_CourtSelectGfx9 ; record 110
	dslot DataPtr_SharedMenuGfx111 ; record 111
	dslot DataPtr_MinigameLevelSelectGfx0 ; record 112
	dslot DataPtr_MinigameLevelSelectIconGfx ; record 113
	dslot DataPtr_MinigameLevelSelectGfx1 ; record 114
	dslot DataPtr_N64TransferItemGfx4 ; record 115
	dslot DataPtr_N64TransferItemGfx5 ; record 116
	dslot DataPtr_CharGridGfx2 ; record 117
	dslot DataPtr_SavedDataSourceGfx5 ; record 118
	dslot DataPtr_MinigameLevelSelectGfx2Alias16 ; record 119
	dslot DataPtr_SavedDataTypeSelectGfx ; record 120
	dslot DataPtr_DigitFontTiles ; record 121
SharedMenuGfx17:
	INCBIN "data/bank_039/lz_47ab.bin" ; $47ab, 79 bytes
NameEntryGfx:
	INCBIN "data/bank_039/lz_47fa.bin" ; $47fa, 15 bytes
CharacterSelectGfx:
	INCBIN "data/bank_039/lz_4809.bin" ; $4809, 42 bytes
NumberSpriteGfxWideGfx:
	INCBIN "data/bank_039/lz_4833.bin" ; $4833, 240 bytes
StatLabelTiles:
	INCBIN "data/bank_039/lz_4923.bin" ; $4923, 243 bytes
LoadMenuArrowSpriteTiles:
	ld c, $04 ; $4a16
	ld b, $17 ; $4a18
	push de ; $4a1a
	call LoadCompressedTileBlock ; $4a1b
	pop hl ; $4a1e
	ld de, $0040 ; $4a1f
	add hl, de ; $4a22
	ld d, h ; $4a23
	ld e, l ; $4a24
	ld c, $04 ; $4a25
	ld b, $18 ; $4a27
	push de ; $4a29
	call LoadCompressedTileBlock ; $4a2a
	pop hl ; $4a2d
	ld de, $0040 ; $4a2e
	add hl, de ; $4a31
	ld d, h ; $4a32
	ld e, l ; $4a33
	ld c, $04 ; $4a34
	ld b, $19 ; $4a36
	push de ; $4a38
	call LoadCompressedTileBlock ; $4a39
	pop hl ; $4a3c
	ld de, $0040 ; $4a3d
	add hl, de ; $4a40
	ld d, h ; $4a41
	ld e, l ; $4a42
	ld c, $04 ; $4a43
	ld b, $1a ; $4a45
	push de ; $4a47
	call LoadCompressedTileBlock ; $4a48
	pop hl ; $4a4b
	ld de, $0040 ; $4a4c
	add hl, de ; $4a4f
	ld d, h ; $4a50
	ld e, l ; $4a51
	ret ; $4a52
QueueStackedSpritePair:
	push af ; $4a53
	push bc ; $4a54
	push de ; $4a55
	push hl ; $4a56
	ld a, h ; $4a57
	add a ; $4a58
	add a ; $4a59
	add c ; $4a5a
	ld c, a ; $4a5b
	push af ; $4a5c
	push bc ; $4a5d
	push de ; $4a5e
	push hl ; $4a5f
	call QueueSprite ; $4a60
	pop hl ; $4a63
	pop de ; $4a64
	pop bc ; $4a65
	pop af ; $4a66
	ld a, $08 ; $4a67
	add d ; $4a69
	ld d, a ; $4a6a
	inc c ; $4a6b
	inc c ; $4a6c
	call QueueSprite ; $4a6d
	pop hl ; $4a70
	pop de ; $4a71
	pop bc ; $4a72
	pop af ; $4a73
	ret ; $4a74
ApplySpriteWaveOffset:
	ldh a, [hVBlankCounter] ; $4a75
	and $3f ; $4a77
	add LOW(Data_39_4a84) ; $4a79
	ld l, a ; $4a7b
	adc HIGH(Data_39_4a84) ; $4a7c
	sub l ; $4a7e
	ld h, a ; $4a7f
	ld a, [hl] ; $4a80
	add e ; $4a81
	ld e, a ; $4a82
	ret ; $4a83
Data_39_4a84:
	; $4a84, 64 bytes (bytes:16)
	db $00, $00, $00, $01, $01, $01, $02, $02, $02, $03, $03, $03, $03, $03, $03, $03 ; 0x00
	db $03, $03, $03, $03, $03, $03, $03, $03, $02, $02, $02, $01, $01, $01, $00, $00 ; 0x10
	db $00, $00, $00, $ff, $ff, $ff, $fe, $fe, $fe, $fd, $fd, $fd, $fd, $fd, $fd, $fd ; 0x20
	db $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fe, $fe, $fe, $ff, $ff, $ff, $00, $00 ; 0x30
ApplySpriteBobOffset:
	ldh a, [hVBlankCounter] ; $4ac4
	and $3f ; $4ac6
	add LOW(Data_39_4ad3) ; $4ac8
	ld l, a ; $4aca
	adc HIGH(Data_39_4ad3) ; $4acb
	sub l ; $4acd
	ld h, a ; $4ace
	ld a, [hl] ; $4acf
	add e ; $4ad0
	ld e, a ; $4ad1
	ret ; $4ad2
Data_39_4ad3:
	; $4ad3, 64 bytes (bytes:16)
	db $00, $00, $00, $00, $00, $01, $01, $01, $01, $01, $01, $01, $02, $02, $02, $02 ; 0x00
	db $02, $02, $02, $02, $02, $02, $01, $01, $01, $01, $01, $00, $00, $00, $00, $00 ; 0x10
	db $00, $00, $00, $00, $00, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $fe, $fe, $fe, $fe ; 0x20
	db $fe, $fe, $fe, $fe, $fe, $fe, $ff, $ff, $ff, $ff, $ff, $00, $00, $00, $00, $00 ; 0x30
InitMenuBgScroll:
	ld a, $01 ; $4b13
	ld [wMenuBgScrollAttr], a ; $4b15
	ld a, $01 ; $4b18
	ld [wMenuBgScrollAttr + 1], a ; $4b1a
	xor a ; $4b1d
	ld [wMenuBgScrollX], a ; $4b1e
	ld a, $40 ; $4b21
	ld [wMenuBgScrollY], a ; $4b23
	add $86 ; $4b26
	ld [wMenuBgScrollY + 1], a ; $4b28
	ld a, $00 ; $4b2b
	ld [wMenuBgScrollTile], a ; $4b2d
	ld a, $00 ; $4b30
	ld [wMenuBgScrollTile + 1], a ; $4b32
	xor a ; $4b35
	ld [wMenuBgScrollLane], a ; $4b36
	ret ; $4b39
LoadMenuSpritePalettePair:
	push bc ; $4b3a
	ld a, c ; $4b3b
	add $08 ; $4b3c
	ld d, a ; $4b3e
	ld e, $01 ; $4b3f
	ld hl, MenuSpritePalettePairPalettes ; $4b41
	call LoadPaletteShadow ; $4b44
	pop bc ; $4b47
	ld a, b ; $4b48
	add $08 ; $4b49
	ld d, a ; $4b4b
	ld e, $01 ; $4b4c
	ld hl, MenuSpritePalettePairPalettes ; $4b4e
	call LoadPaletteShadow ; $4b51
	ret ; $4b54
	; $4b55, 16 bytes (records:2)
	dw $0004 ; record 0
	dw $00af ; record 1
	dw $015f ; record 2
	dw $031f ; record 3
	dw $1088 ; record 4
	dw $1133 ; record 5
	dw $11df ; record 6
	dw $139f ; record 7
MenuSpritePalettePairPalettes:
	; $4b65, 8 bytes (records:2)
	dw $0000 ; record 0
	dw $018f ; record 1
	dw $031f ; record 2
	dw $031f ; record 3
TickMenuBgScroll:
	ld a, [wMenuBgScrollY] ; $4b6d
	dec a ; $4b70
	cp $b0 ; $4b71
	jr nz, .wrapped1 ; $4b73
	ld a, $a0 ; $4b75
.wrapped1:
	ld [wMenuBgScrollY], a ; $4b77
	ld a, [wMenuBgScrollY + 1] ; $4b7a
	dec a ; $4b7d
	cp $b0 ; $4b7e
	jr nz, .wrapped2 ; $4b80
	ld a, $a0 ; $4b82
.wrapped2:
	ld [wMenuBgScrollY + 1], a ; $4b84
	ld a, [wMenuBgScrollLane] ; $4b87
	or a ; $4b8a
	jr nz, .secondSprite ; $4b8b
	ld a, [wMenuBgScrollY] ; $4b8d
	ld d, a ; $4b90
	ld a, [wMenuBgScrollTile] ; $4b91
	ld c, a ; $4b94
	ld a, [wMenuBgScrollAttr] ; $4b95
	ld b, a ; $4b98
	ld a, [wMenuBgScrollX] ; $4b99
	ld e, a ; $4b9c
	ld a, $01 ; $4b9d
	ld [wMenuBgScrollLane], a ; $4b9f
	jr .queueSprite ; $4ba2
.secondSprite:
	ld a, [wMenuBgScrollY + 1] ; $4ba4
	ld d, a ; $4ba7
	ld a, [wMenuBgScrollTile + 1] ; $4ba8
	ld c, a ; $4bab
	ld a, [wMenuBgScrollAttr + 1] ; $4bac
	ld b, a ; $4baf
	ld a, [wMenuBgScrollX] ; $4bb0
	ld e, a ; $4bb3
	xor a ; $4bb4
	ld [wMenuBgScrollLane], a ; $4bb5
.queueSprite:
	ld hl, SpriteTemplate_39_4bbf ; $4bb8
	call QueueSpriteTemplate ; $4bbb
	ret ; $4bbe
SpriteTemplate_39_4bbf:
	; $4bbf, 41 bytes (sprite_template)
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
LoadMenuFontTiles:
	ld b, $11 ; $4be8
	ld c, $10 ; $4bea
	ld de, $9000 ; $4bec
	farcall LoadCompressedTileBlock ; $4bef
	ret ; $4bf2
ResetScreenAndTextWindows:
	ldh [hScrollX], a ; $4bf3
	ldh [hScrollY], a ; $4bf5
	ld [wCameraX], a ; $4bf7
	ld [wCameraX + 1], a ; $4bfa
	ld [wCameraY], a ; $4bfd
	ld [wCameraY + 1], a ; $4c00
	farcall LoadStadiumBgGraphics ; $4c03
	farcall ResetTextWindowState ; $4c06
	ld b, $11 ; $4c09
	ld c, $10 ; $4c0b
	ld de, $9000 ; $4c0d
	farcall LoadCompressedTileBlock ; $4c10
	wram_bank $05 ; $4c13
	ld a, $03 ; $4c19
	ld [wShadowTilemapBank], a ; $4c1b
	ld a, $00 ; $4c1e
	ld [wWindowTileAttr], a ; $4c20
	ld d, $00 ; $4c23
	ld e, $0f ; $4c25
	ld b, $14 ; $4c27
	ld c, $03 ; $4c29
	farcall CreateWindowFromScreenRect ; $4c2b
	farcall DrawTextWindowFrame ; $4c2e
	farcall RedrawWindowRows ; $4c31
	farcall QueueWram3MapToVRAM ; $4c34
	ret ; $4c37
LoadStadiumBgGraphics:
	ldh a, [hWramBank] ; $4c38
	push af ; $4c3a
	wram_bank $01 ; $4c3b
	ld hl, $3c08 ; $4c41 -> DataPtr_StadiumTiles
	ld de, $d000 ; $4c44
	call DecompressDataFromBank ; $4c47
	ld hl, $d000 ; $4c4a
	ld de, $b000 ; $4c4d
	ld c, $80 ; $4c50
	call QueueVRAMCopy ; $4c52
	ld hl, $d800 ; $4c55
	ld de, $a800 ; $4c58
	ld c, $80 ; $4c5b
	call QueueVRAMCopy ; $4c5d
	wram_bank $03 ; $4c60
	ld hl, $3c0a ; $4c66 -> DataPtr_StadiumTilemap
	ld de, wShadowTilemap ; $4c69
	call DecompressDataFromBank ; $4c6c
	ld hl, $3c0a ; $4c6f -> DataPtr_StadiumTilemap
	ld de, wScreenScratch ; $4c72
	call DecompressDataFromBank ; $4c75
	ld hl, $3c0c ; $4c78 -> DataPtr_StadiumAttrmap
	ld de, wShadowAttrmap ; $4c7b
	call DecompressDataFromBank ; $4c7e
	ld hl, $3c0c ; $4c81 -> DataPtr_StadiumAttrmap
	ld de, wRulesScreenAnimFrame ; $4c84
	call DecompressDataFromBank ; $4c87
	wram_bank $01 ; $4c8a
	ld hl, $3c0e ; $4c90 -> DataPtr_StadiumPalettes
	ld de, $d000 ; $4c93
	ld bc, $0040 ; $4c96
	call CopyDataFromBank ; $4c99
	ld hl, $d000 ; $4c9c
	ld de, $0008 ; $4c9f
	call LoadPaletteShadow ; $4ca2
	pop af ; $4ca5
	wram_bank ; $4ca6
	ret ; $4caa
FlushWram3MapRows:
	push af ; $4cab
	push bc ; $4cac
	push de ; $4cad
	push hl ; $4cae
	ldh a, [hWramBank] ; $4caf
	push af ; $4cb1
	wram_bank $03 ; $4cb2
	ld a, b ; $4cb8
	or a ; $4cb9
	jr nz, .mode1 ; $4cba
	ld c, $04 ; $4cbc
	ld hl, wShadowTilemap ; $4cbe
	ld de, $9800 ; $4cc1
	call QueueVRAMCopy ; $4cc4
	ld c, $04 ; $4cc7
	ld hl, wShadowAttrmap ; $4cc9
	ld de, $b800 ; $4ccc
	call QueueVRAMCopy ; $4ccf
	ld c, $06 ; $4cd2
	ld hl, wShadowTilemap + 3 * TILEMAP_WIDTH ; $4cd4
	ld de, $9860 ; $4cd7
	call QueueVRAMCopy ; $4cda
	ld c, $06 ; $4cdd
	ld hl, wShadowAttrmap + 3 * TILEMAP_WIDTH ; $4cdf
	ld de, $b860 ; $4ce2
	call QueueVRAMCopy ; $4ce5
	call AdvanceFrame ; $4ce8
	ld c, $06 ; $4ceb
	ld hl, wShadowTilemap + 7 * TILEMAP_WIDTH ; $4ced
	ld de, $98e0 ; $4cf0
	call QueueVRAMCopy ; $4cf3
	ld c, $06 ; $4cf6
	ld hl, wShadowAttrmap + 7 * TILEMAP_WIDTH ; $4cf8
	ld de, $b8e0 ; $4cfb
	call QueueVRAMCopy ; $4cfe
	ld c, $06 ; $4d01
	ld hl, wShadowTilemap + 11 * TILEMAP_WIDTH ; $4d03
	ld de, $9960 ; $4d06
	call QueueVRAMCopy ; $4d09
	ld c, $06 ; $4d0c
	ld hl, wShadowAttrmap + 11 * TILEMAP_WIDTH ; $4d0e
	ld de, $b960 ; $4d11
	call QueueVRAMCopy ; $4d14
	jp .done ; $4d17
.mode1:
	cp $01 ; $4d1a
	jr nz, .mode2 ; $4d1c
	ld c, $04 ; $4d1e
	ld hl, wShadowTilemap ; $4d20
	ld de, $9800 ; $4d23
	call QueueVRAMCopy ; $4d26
	ld c, $04 ; $4d29
	ld hl, wShadowAttrmap ; $4d2b
	ld de, $b800 ; $4d2e
	call QueueVRAMCopy ; $4d31
	ld c, $06 ; $4d34
	ld hl, wShadowTilemap + 4 * TILEMAP_WIDTH ; $4d36
	ld de, $9880 ; $4d39
	call QueueVRAMCopy ; $4d3c
	ld c, $06 ; $4d3f
	ld hl, wShadowAttrmap + 4 * TILEMAP_WIDTH ; $4d41
	ld de, $b880 ; $4d44
	call QueueVRAMCopy ; $4d47
	call AdvanceFrame ; $4d4a
	ld c, $06 ; $4d4d
	ld hl, wShadowTilemap + 10 * TILEMAP_WIDTH ; $4d4f
	ld de, $9940 ; $4d52
	call QueueVRAMCopy ; $4d55
	ld c, $06 ; $4d58
	ld hl, wShadowAttrmap + 10 * TILEMAP_WIDTH ; $4d5a
	ld de, $b940 ; $4d5d
	call QueueVRAMCopy ; $4d60
	jr .done ; $4d63
.mode2:
	cp $02 ; $4d65
	jr nz, .mode3 ; $4d67
	ld c, $04 ; $4d69
	ld hl, wShadowTilemap ; $4d6b
	ld de, $9800 ; $4d6e
	call QueueVRAMCopy ; $4d71
	ld c, $04 ; $4d74
	ld hl, wShadowAttrmap ; $4d76
	ld de, $b800 ; $4d79
	call QueueVRAMCopy ; $4d7c
	ld c, $06 ; $4d7f
	ld hl, wShadowTilemap + 4 * TILEMAP_WIDTH ; $4d81
	ld de, $9880 ; $4d84
	call QueueVRAMCopy ; $4d87
	ld c, $06 ; $4d8a
	ld hl, wShadowAttrmap + 4 * TILEMAP_WIDTH ; $4d8c
	ld de, $b880 ; $4d8f
	call QueueVRAMCopy ; $4d92
	call AdvanceFrame ; $4d95
	ld c, $06 ; $4d98
	ld hl, wShadowTilemap + 9 * TILEMAP_WIDTH ; $4d9a
	ld de, $9920 ; $4d9d
	call QueueVRAMCopy ; $4da0
	ld c, $06 ; $4da3
	ld hl, wShadowAttrmap + 9 * TILEMAP_WIDTH ; $4da5
	ld de, $b920 ; $4da8
	call QueueVRAMCopy ; $4dab
	jr .done ; $4dae
.mode3:
	ld c, $04 ; $4db0
	ld hl, wShadowTilemap ; $4db2
	ld de, $9800 ; $4db5
	call QueueVRAMCopy ; $4db8
	ld c, $04 ; $4dbb
	ld hl, wShadowAttrmap ; $4dbd
	ld de, $b800 ; $4dc0
	call QueueVRAMCopy ; $4dc3
	call AdvanceFrame ; $4dc6
	ld c, $06 ; $4dc9
	ld hl, wShadowTilemap + 7 * TILEMAP_WIDTH ; $4dcb
	ld de, $98e0 ; $4dce
	call QueueVRAMCopy ; $4dd1
	ld c, $06 ; $4dd4
	ld hl, wShadowAttrmap + 7 * TILEMAP_WIDTH ; $4dd6
	ld de, $b8e0 ; $4dd9
	call QueueVRAMCopy ; $4ddc
	jr .done ; $4ddf
.done:
	pop af ; $4de1
	wram_bank ; $4de2
	pop hl ; $4de6
	pop de ; $4de7
	pop bc ; $4de8
	pop af ; $4de9
	ret ; $4dea
RestoreMenuBgAndDrawPanel:
	push af ; $4deb
	push bc ; $4dec
	push de ; $4ded
	push hl ; $4dee
	push af ; $4def
	push bc ; $4df0
	push de ; $4df1
	push hl ; $4df2
	ld hl, wScreenScratch ; $4df3
	ld de, wShadowTilemap ; $4df6
	ld b, $14 ; $4df9
	ld c, $10 ; $4dfb
	call CopyTilemapRect ; $4dfd
	ld hl, wRulesScreenAnimFrame ; $4e00
	ld de, wShadowAttrmap ; $4e03
	ld b, $14 ; $4e06
	ld c, $10 ; $4e08
	call CopyTilemapRect ; $4e0a
	pop hl ; $4e0d
	pop de ; $4e0e
	pop bc ; $4e0f
	pop af ; $4e10
	ld a, b ; $4e11
	add a ; $4e12
	ld hl, TilemapAssemblyDispatch_39 ; $4e13
	add l ; $4e16
	ld l, a ; $4e17
	jr nc, .readTable ; $4e18
	inc h ; $4e1a
.readTable:
	ld a, [hl+] ; $4e1b
	ld h, [hl] ; $4e1c
	ld l, a ; $4e1d
	ld a, c ; $4e1e
	add a ; $4e1f
	add l ; $4e20
	ld l, a ; $4e21
	jr nc, .readEntry ; $4e22
	inc h ; $4e24
.readEntry:
	ld a, [hl+] ; $4e25
	ld h, [hl] ; $4e26
	ld l, a ; $4e27
.rectLoop:
	push hl ; $4e28
	ld a, [hl+] ; $4e29
	ld b, [hl] ; $4e2a
	ld c, a ; $4e2b
	push bc ; $4e2c
	inc hl ; $4e2d
	ld a, [hl+] ; $4e2e
	ld d, [hl] ; $4e2f
	ld e, a ; $4e30
	inc hl ; $4e31
	ld a, [hl+] ; $4e32
	or a ; $4e33
	jr z, .done ; $4e34
	ld c, [hl] ; $4e36
	ld b, a ; $4e37
	pop hl ; $4e38
	push bc ; $4e39
	push hl ; $4e3a
	push de ; $4e3b
	call CopyTilemapRect ; $4e3c
	pop de ; $4e3f
	ld hl, $0400 ; $4e40
	add hl, de ; $4e43
	ld d, h ; $4e44
	ld e, l ; $4e45
	pop hl ; $4e46
	ld bc, $0400 ; $4e47
	add hl, bc ; $4e4a
	pop bc ; $4e4b
	call CopyTilemapRect ; $4e4c
	pop hl ; $4e4f
	ld a, $06 ; $4e50
	add l ; $4e52
	ld l, a ; $4e53
	jr nc, .nextRect ; $4e54
	inc h ; $4e56
.nextRect:
	jr .rectLoop ; $4e57
.done:
	pop hl ; $4e59
	pop hl ; $4e5a
	pop hl ; $4e5b
	pop de ; $4e5c
	pop bc ; $4e5d
	pop af ; $4e5e
	ret ; $4e5f
TilemapAssemblyDispatch_39:
	; $4e60, 8034 bytes (tilemap_dispatch)
	dw .l2_0 ; 0
	dw .l2_1 ; 1
	dw .l2_2 ; 2
	dw .l2_3 ; 3
	dw .l2_4 ; 4
	dw .l2_5 ; 5
	dw .l2_6 ; 6
	dw .l2_7 ; 7
	dw .l2_8 ; 8
	dw .l2_9 ; 9
	dw .l2_10 ; 10
	dw .l2_11 ; 11
	dw .l2_12 ; 12
	dw .l2_12 ; 13
	dw .l2_12 ; 14
	dw .l2_12 ; 15
	dw .l2_12 ; 16
	dw .l2_13 ; 17
	dw .l2_14 ; 18
	dw .l2_15 ; 19
	dw .l2_16 ; 20
	dw .l2_17 ; 21
	dw .l2_18 ; 22
	dw .l2_19 ; 23
.l2_0:
	dw .rl_0
	dw .rl_0
	dw .rl_0
	dw .rl_1
	dw .rl_2
	dw .rl_3
	dw .rl_4
	dw .rl_5
	dw .rl_6
	dw .rl_7
	dw .rl_8
	dw .rl_9
	dw .rl_10
	dw .rl_11
	dw .rl_12
	dw .rl_13
.l2_1:
	dw .rl_13
	dw .rl_14
	dw .rl_15
	dw .rl_16
	dw .rl_17
	dw .rl_18
	dw .rl_19
	dw .rl_20
	dw .rl_21
	dw .rl_22
.l2_2:
	dw .rl_0
	dw .rl_0
	dw .rl_0
	dw .rl_23
	dw .rl_24
	dw .rl_25
	dw .rl_26
	dw .rl_27
	dw .rl_28
	dw .rl_29
	dw .rl_30
	dw .rl_31
	dw .rl_32
	dw .rl_33
	dw .rl_34
	dw .rl_34
.l2_3:
	dw .rl_34
	dw .rl_35
	dw .rl_36
	dw .rl_37
	dw .rl_38
	dw .rl_39
	dw .rl_40
	dw .rl_41
	dw .rl_42
	dw .rl_43
	dw .rl_0
	dw .rl_0
.l2_4:
	dw .rl_0
	dw .rl_0
	dw .rl_0
	dw .rl_44
	dw .rl_45
	dw .rl_46
	dw .rl_47
	dw .rl_48
	dw .rl_49
	dw .rl_50
	dw .rl_51
	dw .rl_52
	dw .rl_53
	dw .rl_54
	dw .rl_55
	dw .rl_55
.l2_5:
	dw .rl_54
	dw .rl_55
	dw .rl_56
	dw .rl_57
	dw .rl_58
	dw .rl_59
	dw .rl_60
	dw .rl_61
	dw .rl_62
	dw .rl_63
	dw .rl_64
	dw .rl_0
	dw .rl_0
	dw .rl_0
.l2_6:
	dw .rl_0
	dw .rl_0
	dw .rl_0
	dw .rl_65
	dw .rl_66
	dw .rl_67
	dw .rl_68
	dw .rl_69
	dw .rl_70
	dw .rl_71
	dw .rl_72
	dw .rl_73
	dw .rl_74
	dw .rl_74
.l2_7:
	dw .rl_74
	dw .rl_75
	dw .rl_76
	dw .rl_77
	dw .rl_78
	dw .rl_79
	dw .rl_80
	dw .rl_81
	dw .rl_82
	dw .rl_0
	dw .rl_0
.l2_8:
	dw .rl_0
	dw .rl_0
	dw .rl_0
	dw .rl_83
	dw .rl_84
	dw .rl_85
	dw .rl_86
	dw .rl_87
	dw .rl_88
	dw .rl_89
	dw .rl_90
	dw .rl_91
	dw .rl_92
	dw .rl_93
	dw .rl_94
	dw .rl_95
.l2_9:
	dw .rl_94
	dw .rl_95
	dw .rl_96
	dw .rl_97
	dw .rl_98
	dw .rl_99
	dw .rl_100
	dw .rl_101
	dw .rl_102
	dw .rl_103
	dw .rl_0
	dw .rl_0
	dw .rl_0
.l2_10:
	dw .rl_0
	dw .rl_0
	dw .rl_0
	dw .rl_104
	dw .rl_105
	dw .rl_106
	dw .rl_107
	dw .rl_108
	dw .rl_109
	dw .rl_110
	dw .rl_111
	dw .rl_112
	dw .rl_113
.l2_11:
	dw .rl_114
	dw .rl_115
	dw .rl_116
	dw .rl_117
	dw .rl_118
	dw .rl_119
	dw .rl_120
	dw .rl_121
	dw .rl_122
	dw .rl_123
	dw .rl_124
.l2_12:
	dw .rl_0
	dw .rl_0
	dw .rl_0
	dw .rl_125
	dw .rl_126
	dw .rl_127
	dw .rl_128
	dw .rl_129
	dw .rl_130
	dw .rl_131
	dw .rl_132
	dw .rl_133
	dw .rl_134
	dw .rl_134
	dw .rl_134
	dw .rl_134
	dw .rl_134
.l2_13:
	dw .rl_134
	dw .rl_135
	dw .rl_136
	dw .rl_137
	dw .rl_138
	dw .rl_139
	dw .rl_140
	dw .rl_141
	dw .rl_142
	dw .rl_143
	dw .rl_144
	dw .rl_144
	dw .rl_144
	dw .rl_144
.l2_14:
	dw .rl_0
	dw .rl_0
	dw .rl_0
	dw .rl_144
	dw .rl_145
	dw .rl_146
	dw .rl_147
	dw .rl_148
	dw .rl_149
	dw .rl_150
	dw .rl_151
	dw .rl_152
	dw .rl_153
	dw .rl_154
	dw .rl_155
	dw .rl_156
	dw .rl_157
.l2_15:
	dw .rl_158
	dw .rl_159
	dw .rl_160
	dw .rl_161
	dw .rl_162
	dw .rl_163
	dw .rl_164
	dw .rl_165
	dw .rl_166
	dw .rl_167
	dw .rl_168
	dw .rl_169
	dw .rl_170
	dw .rl_171
.l2_16:
	dw .rl_0
	dw .rl_0
	dw .rl_0
	dw .rl_172
	dw .rl_173
	dw .rl_174
	dw .rl_175
	dw .rl_176
	dw .rl_177
	dw .rl_178
	dw .rl_179
	dw .rl_180
	dw .rl_181
	dw .rl_182
	dw .rl_183
	dw .rl_184
	dw .rl_184
.l2_17:
	dw .rl_184
	dw .rl_185
	dw .rl_186
	dw .rl_187
	dw .rl_188
	dw .rl_189
	dw .rl_190
	dw .rl_191
	dw .rl_192
	dw .rl_193
	dw .rl_194
	dw .rl_195
	dw .rl_195
	dw .rl_195
.l2_18:
	dw .rl_0
	dw .rl_0
	dw .rl_0
	dw .rl_195
	dw .rl_196
	dw .rl_197
	dw .rl_198
	dw .rl_199
	dw .rl_200
	dw .rl_201
	dw .rl_202
	dw .rl_203
	dw .rl_204
	dw .rl_205
	dw .rl_206
	dw .rl_206
	dw .rl_206
.l2_19:
	dw .rl_205
	dw .rl_206
	dw .rl_207
	dw .rl_208
	dw .rl_209
	dw .rl_210
	dw .rl_211
	dw .rl_212
	dw .rl_213
	dw .rl_0
	dw .rl_0
	dw .rl_0
	dw .rl_0
	dw .rl_0
	dw .rl_0
	dw .rl_0
	dw $6dc2
	dw $6dc2
	dw $6dc2
	dw $6dc2
	dw $6dc2
	dw $6dc2
.rl_0:
	tilemap_rect_end
.rl_1:
	tilemap_rect $db80, $d000, $14, $01
	tilemap_rect $daa0, $d070, $05, $03
	tilemap_rect_end
.rl_2:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d06d, $05, $03
	tilemap_rect $da40, $d0f4, $03, $03
	tilemap_rect_end
.rl_3:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d06a, $05, $03
	tilemap_rect $daa5, $d070, $05, $03
	tilemap_rect $daa0, $d070, $03, $03
	tilemap_rect_end
.rl_4:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d067, $05, $03
	tilemap_rect $daa5, $d06d, $05, $03
	tilemap_rect $da40, $d0ee, $03, $03
	tilemap_rect $da43, $d0f4, $03, $03
	tilemap_rect $daaf, $d173, $05, $03
	tilemap_rect_end
.rl_5:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d064, $05, $03
	tilemap_rect $daa5, $d06a, $05, $03
	tilemap_rect $daaa, $d070, $05, $03
	tilemap_rect $da40, $d0eb, $03, $03
	tilemap_rect $da43, $d0f1, $03, $03
	tilemap_rect $daaf, $d170, $05, $03
	tilemap_rect_end
.rl_6:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d062, $05, $03
	tilemap_rect $daa5, $d068, $05, $03
	tilemap_rect $daaa, $d06e, $05, $03
	tilemap_rect $da40, $d0e8, $03, $03
	tilemap_rect $da43, $d0ee, $03, $03
	tilemap_rect $da46, $d0f4, $03, $03
	tilemap_rect $daaf, $d16d, $05, $03
	tilemap_rect $dab4, $d173, $05, $03
	tilemap_rect_end
.rl_7:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d061, $05, $03
	tilemap_rect $daa5, $d067, $05, $03
	tilemap_rect $daaa, $d06d, $05, $03
	tilemap_rect $da40, $d0e5, $03, $03
	tilemap_rect $da43, $d0eb, $03, $03
	tilemap_rect $da46, $d0f1, $03, $03
	tilemap_rect $daaf, $d16a, $05, $03
	tilemap_rect $dab4, $d170, $05, $03
	tilemap_rect $dab9, $d176, $05, $03
	tilemap_rect_end
.rl_8:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d061, $05, $03
	tilemap_rect $daa5, $d067, $05, $03
	tilemap_rect $daaa, $d06d, $05, $03
	tilemap_rect $da40, $d0e3, $03, $03
	tilemap_rect $da43, $d0e9, $03, $03
	tilemap_rect $da46, $d0ef, $03, $03
	tilemap_rect $daaf, $d167, $05, $03
	tilemap_rect $dab4, $d16d, $05, $03
	tilemap_rect $dab9, $d173, $05, $03
	tilemap_rect_end
.rl_9:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d061, $05, $03
	tilemap_rect $daa5, $d067, $05, $03
	tilemap_rect $daaa, $d06d, $05, $03
	tilemap_rect $da40, $d0e2, $03, $03
	tilemap_rect $da43, $d0e8, $03, $03
	tilemap_rect $da46, $d0ee, $03, $03
	tilemap_rect $daaf, $d164, $05, $03
	tilemap_rect $dab4, $d16a, $05, $03
	tilemap_rect $dab9, $d170, $05, $03
	tilemap_rect_end
.rl_10:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d061, $05, $03
	tilemap_rect $daa5, $d067, $05, $03
	tilemap_rect $daaa, $d06d, $05, $03
	tilemap_rect $da40, $d0e2, $03, $03
	tilemap_rect $da43, $d0e8, $03, $03
	tilemap_rect $da46, $d0ee, $03, $03
	tilemap_rect $daaf, $d162, $05, $03
	tilemap_rect $dab4, $d168, $05, $03
	tilemap_rect $dab9, $d16e, $05, $03
	tilemap_rect_end
.rl_11:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d061, $05, $03
	tilemap_rect $daa5, $d067, $05, $03
	tilemap_rect $daaa, $d06d, $05, $03
	tilemap_rect $da40, $d0e2, $03, $03
	tilemap_rect $da43, $d0e8, $03, $03
	tilemap_rect $da46, $d0ee, $03, $03
	tilemap_rect $daaf, $d161, $05, $03
	tilemap_rect $dab4, $d167, $05, $03
	tilemap_rect $dab9, $d16d, $05, $03
	tilemap_rect_end
.rl_12:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d061, $05, $03
	tilemap_rect $daa5, $d067, $05, $03
	tilemap_rect $daaa, $d06d, $05, $03
	tilemap_rect $da40, $d0e2, $03, $03
	tilemap_rect $da43, $d0e8, $03, $03
	tilemap_rect $da46, $d0ee, $03, $03
	tilemap_rect $daaf, $d161, $05, $03
	tilemap_rect $dab4, $d167, $05, $03
	tilemap_rect $dab9, $d16d, $05, $03
	tilemap_rect_end
.rl_13:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d061, $05, $03
	tilemap_rect $daa5, $d067, $05, $03
	tilemap_rect $daaa, $d06d, $05, $03
	tilemap_rect $da40, $d0e2, $03, $03
	tilemap_rect $da43, $d0e8, $03, $03
	tilemap_rect $da46, $d0ee, $03, $03
	tilemap_rect $daaf, $d161, $05, $03
	tilemap_rect $dab4, $d167, $05, $03
	tilemap_rect $dab9, $d16d, $05, $03
	tilemap_rect_end
.rl_14:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d060, $05, $03
	tilemap_rect $daa5, $d066, $05, $03
	tilemap_rect $daaa, $d06c, $05, $03
	tilemap_rect $da40, $d0e2, $03, $03
	tilemap_rect $da43, $d0e8, $03, $03
	tilemap_rect $da46, $d0ee, $03, $03
	tilemap_rect $daaf, $d161, $05, $03
	tilemap_rect $dab4, $d167, $05, $03
	tilemap_rect $dab9, $d16d, $05, $03
	tilemap_rect_end
.rl_15:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d05e, $05, $03
	tilemap_rect $daa5, $d064, $05, $03
	tilemap_rect $daaa, $d06a, $05, $03
	tilemap_rect $da40, $d0e1, $03, $03
	tilemap_rect $da43, $d0e7, $03, $03
	tilemap_rect $da46, $d0ed, $03, $03
	tilemap_rect $daaf, $d161, $05, $03
	tilemap_rect $dab4, $d167, $05, $03
	tilemap_rect $dab9, $d16d, $05, $03
	tilemap_rect_end
.rl_16:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d05b, $05, $03
	tilemap_rect $daa5, $d061, $05, $03
	tilemap_rect $daaa, $d067, $05, $03
	tilemap_rect $da40, $d0df, $03, $03
	tilemap_rect $da43, $d0e5, $03, $03
	tilemap_rect $da46, $d0eb, $03, $03
	tilemap_rect $daaf, $d161, $05, $03
	tilemap_rect $dab4, $d167, $05, $03
	tilemap_rect $dab9, $d16d, $05, $03
	tilemap_rect_end
.rl_17:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa5, $d05e, $05, $03
	tilemap_rect $daaa, $d064, $05, $03
	tilemap_rect $da40, $d0dc, $03, $03
	tilemap_rect $da43, $d0e2, $03, $03
	tilemap_rect $da46, $d0e8, $03, $03
	tilemap_rect $daaf, $d160, $05, $03
	tilemap_rect $dab4, $d166, $05, $03
	tilemap_rect $dab9, $d16c, $05, $03
	tilemap_rect_end
.rl_18:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa5, $d05b, $05, $03
	tilemap_rect $daaa, $d061, $05, $03
	tilemap_rect $da40, $d0d9, $03, $03
	tilemap_rect $da43, $d0df, $03, $03
	tilemap_rect $da46, $d0e5, $03, $03
	tilemap_rect $daaf, $d15e, $05, $03
	tilemap_rect $dab4, $d164, $05, $03
	tilemap_rect $dab9, $d16a, $05, $03
	tilemap_rect_end
.rl_19:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daaa, $d05e, $05, $03
	tilemap_rect $da43, $d0dc, $03, $03
	tilemap_rect $da46, $d0e2, $03, $03
	tilemap_rect $daaf, $d15b, $05, $03
	tilemap_rect $dab4, $d161, $05, $03
	tilemap_rect $dab9, $d167, $05, $03
	tilemap_rect_end
.rl_20:
	tilemap_rect $db80, $d000, $14, $01
	tilemap_rect $daaa, $d05b, $05, $03
	tilemap_rect $da46, $d0df, $03, $03
	tilemap_rect $dab4, $d15e, $05, $03
	tilemap_rect $dab9, $d164, $05, $03
	tilemap_rect_end
.rl_21:
	tilemap_rect $db80, $d000, $14, $01
	tilemap_rect $da46, $d0dc, $03, $03
	tilemap_rect $dab4, $d15b, $05, $03
	tilemap_rect $dab9, $d161, $05, $03
	tilemap_rect_end
.rl_22:
	tilemap_rect $dab9, $d15e, $05, $03
	tilemap_rect_end
.rl_23:
	tilemap_rect $db80, $d000, $14, $01
	tilemap_rect $daa0, $d072, $05, $03
	tilemap_rect_end
.rl_24:
	tilemap_rect $db80, $d000, $14, $01
	tilemap_rect $daa0, $d06f, $05, $03
	tilemap_rect $daa5, $d078, $05, $03
	tilemap_rect $daaa, $d0f5, $05, $03
	tilemap_rect_end
.rl_25:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d06c, $05, $03
	tilemap_rect $daa5, $d075, $05, $03
	tilemap_rect $daaa, $d0f2, $05, $03
	tilemap_rect_end
.rl_26:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d069, $05, $03
	tilemap_rect $daa5, $d072, $05, $03
	tilemap_rect $daaa, $d0ef, $05, $03
	tilemap_rect $daaf, $d0f8, $05, $03
	tilemap_rect $dab4, $d173, $05, $03
	tilemap_rect_end
.rl_27:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d066, $05, $03
	tilemap_rect $daa5, $d06f, $05, $03
	tilemap_rect $daaa, $d0ec, $05, $03
	tilemap_rect $daaf, $d0f5, $05, $03
	tilemap_rect $dab4, $d170, $05, $03
	tilemap_rect_end
.rl_28:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d064, $05, $03
	tilemap_rect $daa5, $d06d, $05, $03
	tilemap_rect $daaa, $d0e9, $05, $03
	tilemap_rect $daaf, $d0f2, $05, $03
	tilemap_rect $dab4, $d16d, $05, $03
	tilemap_rect $dab9, $d173, $05, $03
	tilemap_rect_end
.rl_29:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d063, $05, $03
	tilemap_rect $daa5, $d06c, $05, $03
	tilemap_rect $daaa, $d0e6, $05, $03
	tilemap_rect $daaf, $d0ef, $05, $03
	tilemap_rect $dab4, $d16a, $05, $03
	tilemap_rect $dab9, $d170, $05, $03
	tilemap_rect $db54, $d176, $05, $03
	tilemap_rect_end
.rl_30:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d063, $05, $03
	tilemap_rect $daa5, $d06c, $05, $03
	tilemap_rect $daaa, $d0e4, $05, $03
	tilemap_rect $daaf, $d0ed, $05, $03
	tilemap_rect $dab4, $d167, $05, $03
	tilemap_rect $dab9, $d16d, $05, $03
	tilemap_rect $db54, $d173, $05, $03
	tilemap_rect_end
.rl_31:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d063, $05, $03
	tilemap_rect $daa5, $d06c, $05, $03
	tilemap_rect $daaa, $d0e3, $05, $03
	tilemap_rect $daaf, $d0ec, $05, $03
	tilemap_rect $dab4, $d164, $05, $03
	tilemap_rect $dab9, $d16a, $05, $03
	tilemap_rect $db54, $d170, $05, $03
	tilemap_rect_end
.rl_32:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d063, $05, $03
	tilemap_rect $daa5, $d06c, $05, $03
	tilemap_rect $daaa, $d0e3, $05, $03
	tilemap_rect $daaf, $d0ec, $05, $03
	tilemap_rect $dab4, $d162, $05, $03
	tilemap_rect $dab9, $d168, $05, $03
	tilemap_rect $db54, $d16e, $05, $03
	tilemap_rect_end
.rl_33:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d063, $05, $03
	tilemap_rect $daa5, $d06c, $05, $03
	tilemap_rect $daaa, $d0e3, $05, $03
	tilemap_rect $daaf, $d0ec, $05, $03
	tilemap_rect $dab4, $d161, $05, $03
	tilemap_rect $dab9, $d167, $05, $03
	tilemap_rect $db54, $d16d, $05, $03
	tilemap_rect_end
.rl_34:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d063, $05, $03
	tilemap_rect $daa5, $d06c, $05, $03
	tilemap_rect $daaa, $d0e3, $05, $03
	tilemap_rect $daaf, $d0ec, $05, $03
	tilemap_rect $dab4, $d161, $05, $03
	tilemap_rect $dab9, $d167, $05, $03
	tilemap_rect $db54, $d16d, $05, $03
	tilemap_rect_end
.rl_35:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d062, $05, $03
	tilemap_rect $daa5, $d06b, $05, $03
	tilemap_rect $daaa, $d0e3, $05, $03
	tilemap_rect $daaf, $d0ec, $05, $03
	tilemap_rect $dab4, $d161, $05, $03
	tilemap_rect $dab9, $d167, $05, $03
	tilemap_rect $db54, $d16d, $05, $03
	tilemap_rect_end
.rl_36:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d060, $05, $03
	tilemap_rect $daa5, $d069, $05, $03
	tilemap_rect $daaa, $d0e2, $05, $03
	tilemap_rect $daaf, $d0eb, $05, $03
	tilemap_rect $dab4, $d161, $05, $03
	tilemap_rect $dab9, $d167, $05, $03
	tilemap_rect $db54, $d16d, $05, $03
	tilemap_rect_end
.rl_37:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d05d, $05, $03
	tilemap_rect $daa5, $d066, $05, $03
	tilemap_rect $daaa, $d0e0, $05, $03
	tilemap_rect $daaf, $d0e9, $05, $03
	tilemap_rect $dab4, $d160, $05, $03
	tilemap_rect $dab9, $d166, $05, $03
	tilemap_rect $db54, $d16c, $05, $03
	tilemap_rect_end
.rl_38:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d05d, $05, $03
	tilemap_rect $daa5, $d066, $05, $03
	tilemap_rect $daaa, $d0e0, $05, $03
	tilemap_rect $daaf, $d0e9, $05, $03
	tilemap_rect $dab4, $d160, $05, $03
	tilemap_rect $dab9, $d166, $05, $03
	tilemap_rect $db54, $d16c, $05, $03
	tilemap_rect_end
.rl_39:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d05a, $05, $03
	tilemap_rect $daa5, $d063, $05, $03
	tilemap_rect $daaa, $d0dd, $05, $03
	tilemap_rect $daaf, $d0e6, $05, $03
	tilemap_rect $dab4, $d15e, $05, $03
	tilemap_rect $dab9, $d164, $05, $03
	tilemap_rect $db54, $d16a, $05, $03
	tilemap_rect_end
.rl_40:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa5, $d060, $05, $03
	tilemap_rect $daaa, $d0da, $05, $03
	tilemap_rect $daaf, $d0e3, $05, $03
	tilemap_rect $dab4, $d15b, $05, $03
	tilemap_rect $dab9, $d161, $05, $03
	tilemap_rect $db54, $d167, $05, $03
	tilemap_rect_end
.rl_41:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa5, $d05d, $05, $03
	tilemap_rect $daaf, $d0e0, $05, $03
	tilemap_rect $dab9, $d15e, $05, $03
	tilemap_rect $db54, $d164, $05, $03
	tilemap_rect_end
.rl_42:
	tilemap_rect $db80, $d000, $14, $01
	tilemap_rect $daaf, $d0dd, $05, $03
	tilemap_rect $dab9, $d15b, $05, $03
	tilemap_rect $db54, $d161, $05, $03
	tilemap_rect_end
.rl_43:
	tilemap_rect $db80, $d000, $14, $01
	tilemap_rect $db54, $d15e, $05, $03
	tilemap_rect_end
.rl_44:
	tilemap_rect $db80, $d000, $14, $01
	tilemap_rect $da40, $d071, $03, $03
	tilemap_rect_end
.rl_45:
	tilemap_rect $db80, $d000, $14, $01
	tilemap_rect $da40, $d06e, $03, $03
	tilemap_rect $da43, $d074, $03, $03
	tilemap_rect_end
.rl_46:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $da40, $d06b, $03, $03
	tilemap_rect $da43, $d071, $03, $03
	tilemap_rect $da46, $d077, $03, $03
	tilemap_rect $da49, $d0f1, $03, $03
	tilemap_rect_end
.rl_47:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $da40, $d068, $03, $03
	tilemap_rect $da43, $d06e, $03, $03
	tilemap_rect $da46, $d074, $03, $03
	tilemap_rect $da49, $d0ee, $03, $03
	tilemap_rect $da4c, $d0f4, $03, $03
	tilemap_rect $da52, $d174, $03, $03
	tilemap_rect_end
.rl_48:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $da40, $d065, $03, $03
	tilemap_rect $da43, $d06b, $03, $03
	tilemap_rect $da46, $d071, $03, $03
	tilemap_rect $da49, $d0eb, $03, $03
	tilemap_rect $da4c, $d0f1, $03, $03
	tilemap_rect $da52, $d171, $03, $03
	tilemap_rect $da55, $d177, $03, $03
	tilemap_rect_end
.rl_49:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $da40, $d063, $03, $03
	tilemap_rect $da43, $d069, $03, $03
	tilemap_rect $da46, $d06f, $03, $03
	tilemap_rect $da49, $d0e8, $03, $03
	tilemap_rect $da4c, $d0ee, $03, $03
	tilemap_rect $da4f, $d0f4, $03, $03
	tilemap_rect $da52, $d16e, $03, $03
	tilemap_rect $da55, $d174, $03, $03
	tilemap_rect $da58, $d17a, $03, $03
	tilemap_rect_end
.rl_50:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $da40, $d062, $03, $03
	tilemap_rect $da43, $d068, $03, $03
	tilemap_rect $da46, $d06e, $03, $03
	tilemap_rect $da49, $d0e5, $03, $03
	tilemap_rect $da4c, $d0eb, $03, $03
	tilemap_rect $da4f, $d0f1, $03, $03
	tilemap_rect $da52, $d16b, $03, $03
	tilemap_rect $da55, $d171, $03, $03
	tilemap_rect $da58, $d177, $03, $03
	tilemap_rect_end
.rl_51:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $da40, $d062, $03, $03
	tilemap_rect $da43, $d068, $03, $03
	tilemap_rect $da46, $d06e, $03, $03
	tilemap_rect $da49, $d0e3, $03, $03
	tilemap_rect $da4c, $d0e9, $03, $03
	tilemap_rect $da4f, $d0ef, $03, $03
	tilemap_rect $da52, $d168, $03, $03
	tilemap_rect $da55, $d16e, $03, $03
	tilemap_rect $da58, $d174, $03, $03
	tilemap_rect_end
.rl_52:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $da40, $d062, $03, $03
	tilemap_rect $da43, $d068, $03, $03
	tilemap_rect $da46, $d06e, $03, $03
	tilemap_rect $da49, $d0e2, $03, $03
	tilemap_rect $da4c, $d0e8, $03, $03
	tilemap_rect $da4f, $d0ee, $03, $03
	tilemap_rect $da52, $d165, $03, $03
	tilemap_rect $da55, $d16b, $03, $03
	tilemap_rect $da58, $d171, $03, $03
	tilemap_rect_end
.rl_53:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $da40, $d062, $03, $03
	tilemap_rect $da43, $d068, $03, $03
	tilemap_rect $da46, $d06e, $03, $03
	tilemap_rect $da49, $d0e2, $03, $03
	tilemap_rect $da4c, $d0e8, $03, $03
	tilemap_rect $da4f, $d0ee, $03, $03
	tilemap_rect $da52, $d163, $03, $03
	tilemap_rect $da55, $d169, $03, $03
	tilemap_rect $da58, $d16f, $03, $03
	tilemap_rect_end
.rl_54:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $da40, $d062, $03, $03
	tilemap_rect $da43, $d068, $03, $03
	tilemap_rect $da46, $d06e, $03, $03
	tilemap_rect $da49, $d0e2, $03, $03
	tilemap_rect $da4c, $d0e8, $03, $03
	tilemap_rect $da4f, $d0ee, $03, $03
	tilemap_rect $da52, $d162, $03, $03
	tilemap_rect $da55, $d168, $03, $03
	tilemap_rect $da58, $d16e, $03, $03
	tilemap_rect_end
.rl_55:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $da40, $d061, $03, $03
	tilemap_rect $da43, $d067, $03, $03
	tilemap_rect $da46, $d06d, $03, $03
	tilemap_rect $da49, $d0e2, $03, $03
	tilemap_rect $da4c, $d0e8, $03, $03
	tilemap_rect $da4f, $d0ee, $03, $03
	tilemap_rect $da52, $d162, $03, $03
	tilemap_rect $da55, $d168, $03, $03
	tilemap_rect $da58, $d16e, $03, $03
	tilemap_rect_end
.rl_56:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $da40, $d05f, $03, $03
	tilemap_rect $da43, $d065, $03, $03
	tilemap_rect $da46, $d06b, $03, $03
	tilemap_rect $da49, $d0e2, $03, $03
	tilemap_rect $da4c, $d0e8, $03, $03
	tilemap_rect $da4f, $d0ee, $03, $03
	tilemap_rect $da52, $d162, $03, $03
	tilemap_rect $da55, $d168, $03, $03
	tilemap_rect $da58, $d16e, $03, $03
	tilemap_rect_end
.rl_57:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $da40, $d05c, $03, $03
	tilemap_rect $da43, $d062, $03, $03
	tilemap_rect $da46, $d068, $03, $03
	tilemap_rect $da49, $d0e1, $03, $03
	tilemap_rect $da4c, $d0e7, $03, $03
	tilemap_rect $da4f, $d0ed, $03, $03
	tilemap_rect $da52, $d162, $03, $03
	tilemap_rect $da55, $d168, $03, $03
	tilemap_rect $da58, $d16e, $03, $03
	tilemap_rect_end
.rl_58:
	tilemap_rect $db80, $d000, $14, $01
	tilemap_rect $da43, $d05f, $03, $03
	tilemap_rect $da46, $d065, $03, $03
	tilemap_rect $da49, $d0df, $03, $03
	tilemap_rect $da4c, $d0e5, $03, $03
	tilemap_rect $da4f, $d0eb, $03, $03
	tilemap_rect $da52, $d161, $03, $03
	tilemap_rect $da55, $d167, $03, $03
	tilemap_rect $da58, $d16d, $03, $03
	tilemap_rect_end
.rl_59:
	tilemap_rect $db80, $d000, $14, $01
	tilemap_rect $da43, $d05c, $03, $03
	tilemap_rect $da46, $d062, $03, $03
	tilemap_rect $da49, $d0dc, $03, $03
	tilemap_rect $da4c, $d0e2, $03, $03
	tilemap_rect $da4f, $d0e8, $03, $03
	tilemap_rect $da52, $d15f, $03, $03
	tilemap_rect $da55, $d165, $03, $03
	tilemap_rect $da58, $d16b, $03, $03
	tilemap_rect_end
.rl_60:
	tilemap_rect $da46, $d05f, $03, $03
	tilemap_rect $da4c, $d0df, $03, $03
	tilemap_rect $da4f, $d0e5, $03, $03
	tilemap_rect $da52, $d15c, $03, $03
	tilemap_rect $da55, $d162, $03, $03
	tilemap_rect $da58, $d168, $03, $03
	tilemap_rect_end
.rl_61:
	tilemap_rect $da4c, $d0dc, $03, $03
	tilemap_rect $da4f, $d0e2, $03, $03
	tilemap_rect $da55, $d15f, $03, $03
	tilemap_rect $da58, $d165, $03, $03
	tilemap_rect_end
.rl_62:
	tilemap_rect $da4f, $d0df, $03, $03
	tilemap_rect $da55, $d15c, $03, $03
	tilemap_rect $da58, $d162, $03, $03
	tilemap_rect_end
.rl_63:
	tilemap_rect $da58, $d15f, $03, $03
	tilemap_rect_end
.rl_64:
	tilemap_rect_end
.rl_65:
	tilemap_rect $db80, $d000, $14, $01
	tilemap_rect $da40, $d091, $03, $03
	tilemap_rect_end
.rl_66:
	tilemap_rect $db80, $d000, $14, $01
	tilemap_rect $da40, $d08e, $03, $03
	tilemap_rect $da43, $d094, $03, $03
	tilemap_rect_end
.rl_67:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $da40, $d08b, $03, $03
	tilemap_rect $da43, $d091, $03, $03
	tilemap_rect_end
.rl_68:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $da40, $d088, $03, $03
	tilemap_rect $da43, $d08e, $03, $03
	tilemap_rect $daa0, $d133, $03, $03
	tilemap_rect_end
.rl_69:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $da40, $d085, $03, $03
	tilemap_rect $da43, $d08b, $03, $03
	tilemap_rect $da46, $d091, $03, $03
	tilemap_rect $daa0, $d130, $03, $03
	tilemap_rect_end
.rl_70:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $da40, $d083, $03, $03
	tilemap_rect $da43, $d089, $03, $03
	tilemap_rect $da46, $d08f, $03, $03
	tilemap_rect $daa0, $d12d, $03, $03
	tilemap_rect_end
.rl_71:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $da40, $d082, $03, $03
	tilemap_rect $da43, $d088, $03, $03
	tilemap_rect $da46, $d08e, $03, $03
	tilemap_rect $daa0, $d12a, $05, $03
	tilemap_rect_end
.rl_72:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $da40, $d082, $03, $03
	tilemap_rect $da43, $d088, $03, $03
	tilemap_rect $da46, $d08e, $03, $03
	tilemap_rect $daa0, $d128, $05, $03
	tilemap_rect_end
.rl_73:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $da40, $d082, $03, $03
	tilemap_rect $da43, $d088, $03, $03
	tilemap_rect $da46, $d08e, $03, $03
	tilemap_rect $daa0, $d127, $05, $03
	tilemap_rect_end
.rl_74:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $da40, $d082, $03, $03
	tilemap_rect $da43, $d088, $03, $03
	tilemap_rect $da46, $d08e, $03, $03
	tilemap_rect $daa0, $d127, $05, $03
	tilemap_rect_end
.rl_75:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $da40, $d081, $03, $03
	tilemap_rect $da43, $d087, $03, $03
	tilemap_rect $da46, $d08d, $03, $03
	tilemap_rect $daa0, $d127, $05, $03
	tilemap_rect_end
.rl_76:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $da40, $d07f, $03, $03
	tilemap_rect $da43, $d085, $03, $03
	tilemap_rect $da46, $d08b, $03, $03
	tilemap_rect $daa0, $d127, $05, $03
	tilemap_rect_end
.rl_77:
	tilemap_rect $db80, $d000, $14, $01
	tilemap_rect $da40, $d07c, $03, $03
	tilemap_rect $da43, $d082, $03, $03
	tilemap_rect $da46, $d088, $03, $03
	tilemap_rect $daa0, $d126, $05, $03
	tilemap_rect_end
.rl_78:
	tilemap_rect $db80, $d000, $14, $01
	tilemap_rect $da43, $d07f, $03, $03
	tilemap_rect $da46, $d085, $03, $03
	tilemap_rect $daa0, $d124, $05, $03
	tilemap_rect_end
.rl_79:
	tilemap_rect $da43, $d07c, $03, $03
	tilemap_rect $da46, $d082, $03, $03
	tilemap_rect $daa0, $d121, $05, $03
	tilemap_rect_end
.rl_80:
	tilemap_rect $da46, $d07f, $03, $03
	tilemap_rect $daa0, $d11e, $05, $03
	tilemap_rect_end
.rl_81:
	tilemap_rect $da46, $d07c, $03, $03
	tilemap_rect $daa0, $d11b, $05, $03
	tilemap_rect_end
.rl_82:
	tilemap_rect $daa0, $d118, $05, $03
	tilemap_rect_end
.rl_83:
	tilemap_rect $db80, $d000, $14, $01
	tilemap_rect $da40, $d094, $03, $03
	tilemap_rect_end
.rl_84:
	tilemap_rect $db80, $d000, $14, $01
	tilemap_rect $da40, $d091, $03, $03
	tilemap_rect_end
.rl_85:
	tilemap_rect $db80, $d000, $14, $01
	tilemap_rect $da40, $d08e, $03, $03
	tilemap_rect $da43, $d094, $03, $03
	tilemap_rect_end
.rl_86:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $da40, $d08b, $03, $03
	tilemap_rect $da43, $d091, $03, $03
	tilemap_rect_end
.rl_87:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $da40, $d088, $03, $03
	tilemap_rect $da43, $d08e, $03, $03
	tilemap_rect_end
.rl_88:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $da40, $d085, $03, $03
	tilemap_rect $da43, $d08b, $03, $03
	tilemap_rect $da46, $d091, $03, $03
	tilemap_rect $daa0, $d132, $05, $03
	tilemap_rect_end
.rl_89:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $da40, $d083, $03, $03
	tilemap_rect $da43, $d089, $03, $03
	tilemap_rect $da46, $d08f, $03, $03
	tilemap_rect $daa0, $d12f, $05, $03
	tilemap_rect_end
.rl_90:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $da40, $d082, $03, $03
	tilemap_rect $da43, $d088, $03, $03
	tilemap_rect $da46, $d08e, $03, $03
	tilemap_rect $daa0, $d12c, $05, $03
	tilemap_rect $daa5, $d134, $05, $03
	tilemap_rect_end
.rl_91:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $da40, $d082, $03, $03
	tilemap_rect $da43, $d088, $03, $03
	tilemap_rect $da46, $d08e, $03, $03
	tilemap_rect $daa0, $d129, $05, $03
	tilemap_rect $daa5, $d131, $05, $03
	tilemap_rect_end
.rl_92:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $da40, $d082, $03, $03
	tilemap_rect $da43, $d088, $03, $03
	tilemap_rect $da46, $d08e, $03, $03
	tilemap_rect $daa0, $d126, $05, $03
	tilemap_rect $daa5, $d12e, $05, $03
	tilemap_rect_end
.rl_93:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $da40, $d082, $03, $03
	tilemap_rect $da43, $d088, $03, $03
	tilemap_rect $da46, $d08e, $03, $03
	tilemap_rect $daa0, $d124, $05, $03
	tilemap_rect $daa5, $d12c, $05, $03
	tilemap_rect_end
.rl_94:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $da40, $d082, $03, $03
	tilemap_rect $da43, $d088, $03, $03
	tilemap_rect $da46, $d08e, $03, $03
	tilemap_rect $daa0, $d123, $05, $03
	tilemap_rect $daa5, $d12b, $05, $03
	tilemap_rect_end
.rl_95:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $da40, $d081, $03, $03
	tilemap_rect $da43, $d087, $03, $03
	tilemap_rect $da46, $d08d, $03, $03
	tilemap_rect $daa0, $d123, $05, $03
	tilemap_rect $daa5, $d12b, $05, $03
	tilemap_rect_end
.rl_96:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $da40, $d07f, $03, $03
	tilemap_rect $da43, $d085, $03, $03
	tilemap_rect $da46, $d08b, $03, $03
	tilemap_rect $daa0, $d123, $05, $03
	tilemap_rect $daa5, $d12b, $05, $03
	tilemap_rect_end
.rl_97:
	tilemap_rect $db80, $d000, $14, $01
	tilemap_rect $da43, $d082, $03, $03
	tilemap_rect $da46, $d088, $03, $03
	tilemap_rect $daa0, $d122, $05, $03
	tilemap_rect $daa5, $d12a, $05, $03
	tilemap_rect_end
.rl_98:
	tilemap_rect $db80, $d000, $14, $01
	tilemap_rect $da43, $d07f, $03, $03
	tilemap_rect $da46, $d085, $03, $03
	tilemap_rect $daa0, $d120, $05, $03
	tilemap_rect $daa5, $d128, $05, $03
	tilemap_rect_end
.rl_99:
	tilemap_rect $da46, $d082, $03, $03
	tilemap_rect $daa0, $d11d, $05, $03
	tilemap_rect $daa5, $d125, $05, $03
	tilemap_rect_end
.rl_100:
	tilemap_rect $da46, $d07f, $03, $03
	tilemap_rect $daa0, $d11a, $05, $03
	tilemap_rect $daa5, $d122, $05, $03
	tilemap_rect_end
.rl_101:
	tilemap_rect $daa0, $d117, $05, $03
	tilemap_rect $daa5, $d11f, $05, $03
	tilemap_rect_end
.rl_102:
	tilemap_rect $daa5, $d11c, $05, $03
	tilemap_rect_end
.rl_103:
	tilemap_rect $daa5, $d119, $05, $03
	tilemap_rect_end
.rl_104:
	tilemap_rect $db80, $d000, $14, $01
	tilemap_rect $daa0, $d0f3, $05, $03
	tilemap_rect_end
.rl_105:
	tilemap_rect $db80, $d000, $14, $01
	tilemap_rect $daa0, $d0f0, $05, $03
	tilemap_rect_end
.rl_106:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d0ed, $05, $03
	tilemap_rect $daa5, $d0f6, $05, $03
	tilemap_rect_end
.rl_107:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d0ea, $05, $03
	tilemap_rect $daa5, $d0f3, $05, $03
	tilemap_rect_end
.rl_108:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d0e7, $05, $03
	tilemap_rect $daa5, $d0f0, $05, $03
	tilemap_rect_end
.rl_109:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d0e4, $05, $03
	tilemap_rect $daa5, $d0ed, $05, $03
	tilemap_rect $daaa, $d0f6, $05, $03
	tilemap_rect_end
.rl_110:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d0e2, $05, $03
	tilemap_rect $daa5, $d0ea, $05, $03
	tilemap_rect $daaa, $d0f3, $05, $03
	tilemap_rect_end
.rl_111:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d0e1, $05, $03
	tilemap_rect $daa5, $d0e8, $05, $03
	tilemap_rect $daaa, $d0f0, $05, $03
	tilemap_rect_end
.rl_112:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d0e1, $05, $03
	tilemap_rect $daa5, $d0e7, $05, $03
	tilemap_rect $daaa, $d0ee, $05, $03
	tilemap_rect_end
.rl_113:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d0e1, $05, $03
	tilemap_rect $daa5, $d0e7, $05, $03
	tilemap_rect $daaa, $d0ed, $05, $03
	tilemap_rect_end
.rl_114:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d0e1, $05, $03
	tilemap_rect $daa5, $d0e7, $05, $03
	tilemap_rect $daaa, $d0ed, $05, $03
	tilemap_rect_end
.rl_115:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d0e0, $05, $03
	tilemap_rect $daa5, $d0e7, $05, $03
	tilemap_rect $daaa, $d0ed, $05, $03
	tilemap_rect_end
.rl_116:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d0de, $05, $03
	tilemap_rect $daa5, $d0e6, $05, $03
	tilemap_rect $daaa, $d0ed, $05, $03
	tilemap_rect_end
.rl_117:
	tilemap_rect $db80, $d000, $14, $01
	tilemap_rect $daa0, $d0db, $05, $03
	tilemap_rect $daa5, $d0e4, $05, $03
	tilemap_rect $daaa, $d0ec, $05, $03
	tilemap_rect_end
.rl_118:
	tilemap_rect $db80, $d000, $14, $01
	tilemap_rect $daa0, $d0d8, $05, $03
	tilemap_rect $daa5, $d0e1, $05, $03
	tilemap_rect $daaa, $d0ea, $05, $03
	tilemap_rect_end
.rl_119:
	tilemap_rect $daa5, $d0de, $05, $03
	tilemap_rect $daaa, $d0e7, $05, $03
	tilemap_rect_end
.rl_120:
	tilemap_rect $daa5, $d0db, $05, $03
	tilemap_rect $daaa, $d0e4, $05, $03
	tilemap_rect_end
.rl_121:
	tilemap_rect $daaa, $d0e1, $05, $03
	tilemap_rect_end
.rl_122:
	tilemap_rect $daaa, $d0de, $05, $03
	tilemap_rect_end
.rl_123:
	tilemap_rect $daaa, $d0db, $05, $03
	tilemap_rect_end
.rl_124:
	tilemap_rect $daaa, $d0d8, $05, $03
	tilemap_rect_end
.rl_125:
	tilemap_rect $db80, $d000, $14, $01
	tilemap_rect $daa0, $d0f5, $05, $03
	tilemap_rect_end
.rl_126:
	tilemap_rect $db80, $d000, $14, $01
	tilemap_rect $daa0, $d0f2, $05, $03
	tilemap_rect_end
.rl_127:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d0ef, $05, $03
	tilemap_rect_end
.rl_128:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d0ec, $05, $03
	tilemap_rect $daa5, $d0f8, $05, $03
	tilemap_rect_end
.rl_129:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d0e9, $05, $03
	tilemap_rect $daa5, $d0f5, $05, $03
	tilemap_rect_end
.rl_130:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d0e6, $05, $03
	tilemap_rect $daa5, $d0f2, $05, $03
	tilemap_rect_end
.rl_131:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d0e4, $05, $03
	tilemap_rect $daa5, $d0ef, $05, $03
	tilemap_rect_end
.rl_132:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d0e3, $05, $03
	tilemap_rect $daa5, $d0ed, $05, $03
	tilemap_rect_end
.rl_133:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d0e3, $05, $03
	tilemap_rect $daa5, $d0ec, $05, $03
	tilemap_rect_end
.rl_134:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d0e3, $05, $03
	tilemap_rect $daa5, $d0ec, $05, $03
	tilemap_rect_end
.rl_135:
	tilemap_rect $db80, $d000, $14, $01
	tilemap_rect $daa0, $d0e2, $05, $03
	tilemap_rect $daa5, $d0ec, $05, $03
	tilemap_rect_end
.rl_136:
	tilemap_rect $db80, $d000, $14, $01
	tilemap_rect $daa0, $d0e0, $05, $03
	tilemap_rect $daa5, $d0eb, $05, $03
	tilemap_rect_end
.rl_137:
	tilemap_rect $daa0, $d0dd, $05, $03
	tilemap_rect $daa5, $d0e9, $05, $03
	tilemap_rect_end
.rl_138:
	tilemap_rect $daa0, $d0da, $05, $03
	tilemap_rect $daa5, $d0e6, $05, $03
	tilemap_rect_end
.rl_139:
	tilemap_rect $daa0, $d0d7, $05, $03
	tilemap_rect $daa5, $d0e3, $05, $03
	tilemap_rect_end
.rl_140:
	tilemap_rect $daa5, $d0e0, $05, $03
	tilemap_rect_end
.rl_141:
	tilemap_rect $daa5, $d0dd, $05, $03
	tilemap_rect_end
.rl_142:
	tilemap_rect $daa5, $d0da, $05, $03
	tilemap_rect_end
.rl_143:
	tilemap_rect_end
.rl_144:
	tilemap_rect $db80, $d000, $14, $01
	tilemap_rect $daa0, $d096, $05, $03
	tilemap_rect_end
.rl_145:
	tilemap_rect $db80, $d000, $14, $01
	tilemap_rect $daa0, $d093, $05, $03
	tilemap_rect_end
.rl_146:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d090, $05, $03
	tilemap_rect $daa5, $d097, $05, $03
	tilemap_rect $daaa, $d136, $05, $03
	tilemap_rect_end
.rl_147:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d08d, $05, $03
	tilemap_rect $daa5, $d094, $05, $03
	tilemap_rect $daaa, $d133, $05, $03
	tilemap_rect_end
.rl_148:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d08a, $05, $03
	tilemap_rect $daa5, $d091, $05, $03
	tilemap_rect $daaa, $d130, $05, $03
	tilemap_rect $daaf, $d137, $05, $03
	tilemap_rect_end
.rl_149:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d087, $05, $03
	tilemap_rect $daa5, $d08e, $05, $03
	tilemap_rect $daaa, $d12d, $05, $03
	tilemap_rect $daaf, $d134, $05, $03
	tilemap_rect_end
.rl_150:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d085, $05, $03
	tilemap_rect $daa5, $d08c, $05, $03
	tilemap_rect $daaa, $d12a, $05, $03
	tilemap_rect $daaf, $d131, $05, $03
	tilemap_rect_end
.rl_151:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d084, $05, $03
	tilemap_rect $daa5, $d08b, $05, $03
	tilemap_rect $daaa, $d127, $05, $03
	tilemap_rect $daaf, $d12e, $05, $03
	tilemap_rect_end
.rl_152:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d084, $05, $03
	tilemap_rect $daa5, $d08b, $05, $03
	tilemap_rect $daaa, $d125, $05, $03
	tilemap_rect $daaf, $d12c, $05, $03
	tilemap_rect_end
.rl_153:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d084, $05, $03
	tilemap_rect $daa5, $d08b, $05, $03
	tilemap_rect $daaa, $d124, $05, $03
	tilemap_rect $daaf, $d12b, $05, $03
	tilemap_rect_end
.rl_154:
	tilemap_rect_end
.rl_155:
	tilemap_rect_end
.rl_156:
	tilemap_rect_end
.rl_157:
	tilemap_rect_end
.rl_158:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d084, $05, $03
	tilemap_rect $daa5, $d08b, $05, $03
	tilemap_rect $daaa, $d124, $05, $03
	tilemap_rect $daaf, $d12b, $05, $03
	tilemap_rect_end
.rl_159:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d083, $05, $03
	tilemap_rect $daa5, $d08a, $05, $03
	tilemap_rect $daaa, $d124, $05, $03
	tilemap_rect $daaf, $d12b, $05, $03
	tilemap_rect_end
.rl_160:
	tilemap_rect $db80, $d000, $14, $01
	tilemap_rect $daa0, $d081, $05, $03
	tilemap_rect $daa5, $d088, $05, $03
	tilemap_rect $daaa, $d124, $05, $03
	tilemap_rect $daaf, $d12b, $05, $03
	tilemap_rect_end
.rl_161:
	tilemap_rect $db80, $d000, $14, $01
	tilemap_rect $daa0, $d07e, $05, $03
	tilemap_rect $daa5, $d085, $05, $03
	tilemap_rect $daaa, $d123, $05, $03
	tilemap_rect $daaf, $d12a, $05, $03
	tilemap_rect_end
.rl_162:
	tilemap_rect $daa0, $d07b, $05, $03
	tilemap_rect $daa5, $d082, $05, $03
	tilemap_rect $daaa, $d121, $05, $03
	tilemap_rect $daaf, $d128, $05, $03
	tilemap_rect_end
.rl_163:
	tilemap_rect $daa0, $d078, $05, $03
	tilemap_rect $daa5, $d07f, $05, $03
	tilemap_rect $daaa, $d11e, $05, $03
	tilemap_rect $daaf, $d125, $05, $03
	tilemap_rect_end
.rl_164:
	tilemap_rect $daa5, $d07c, $05, $03
	tilemap_rect $daaa, $d11b, $05, $03
	tilemap_rect $daaf, $d122, $05, $03
	tilemap_rect_end
.rl_165:
	tilemap_rect $daaf, $d11f, $05, $03
	tilemap_rect_end
.rl_166:
	tilemap_rect $daaf, $d11c, $05, $03
	tilemap_rect_end
.rl_167:
	tilemap_rect_end
.rl_168:
	tilemap_rect_end
.rl_169:
	tilemap_rect_end
.rl_170:
	tilemap_rect_end
.rl_171:
	tilemap_rect_end
.rl_172:
	tilemap_rect $db80, $d000, $14, $01
	tilemap_rect $daa0, $d073, $05, $03
	tilemap_rect_end
.rl_173:
	tilemap_rect $db80, $d000, $14, $01
	tilemap_rect $daa0, $d070, $05, $03
	tilemap_rect $daa5, $d076, $05, $03
	tilemap_rect_end
.rl_174:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d06d, $05, $03
	tilemap_rect $daa5, $d073, $05, $03
	tilemap_rect $daaf, $d0f3, $05, $03
	tilemap_rect $dab4, $d0f9, $05, $03
	tilemap_rect_end
.rl_175:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d06a, $05, $03
	tilemap_rect $daa5, $d070, $05, $03
	tilemap_rect $daaa, $d076, $05, $03
	tilemap_rect $daaf, $d0f0, $05, $03
	tilemap_rect $dab4, $d0f6, $05, $03
	tilemap_rect_end
.rl_176:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d067, $05, $03
	tilemap_rect $daa5, $d06d, $05, $03
	tilemap_rect $daaa, $d073, $05, $03
	tilemap_rect $daaf, $d0ed, $05, $03
	tilemap_rect $dab4, $d0f3, $05, $03
	tilemap_rect $dab9, $d0f9, $05, $03
	tilemap_rect $db54, $d173, $05, $03
	tilemap_rect_end
.rl_177:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d064, $05, $03
	tilemap_rect $daa5, $d06a, $05, $03
	tilemap_rect $daaa, $d070, $05, $03
	tilemap_rect $daaf, $d0ea, $05, $03
	tilemap_rect $dab4, $d0f0, $05, $03
	tilemap_rect $dab9, $d0f6, $05, $03
	tilemap_rect $db54, $d170, $05, $03
	tilemap_rect $db59, $d176, $05, $03
	tilemap_rect_end
.rl_178:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d062, $05, $03
	tilemap_rect $daa5, $d068, $05, $03
	tilemap_rect $daaa, $d06e, $05, $03
	tilemap_rect $daaf, $d0e7, $05, $03
	tilemap_rect $dab4, $d0ed, $05, $03
	tilemap_rect $dab9, $d0f3, $05, $03
	tilemap_rect $db54, $d16d, $05, $03
	tilemap_rect $db59, $d173, $05, $03
	tilemap_rect $da5b, $d179, $05, $03
	tilemap_rect_end
.rl_179:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d061, $05, $03
	tilemap_rect $daa5, $d067, $05, $03
	tilemap_rect $daaa, $d06d, $05, $03
	tilemap_rect $daaf, $d0e4, $05, $03
	tilemap_rect $dab4, $d0ea, $05, $03
	tilemap_rect $dab9, $d0f0, $05, $03
	tilemap_rect $db54, $d16a, $05, $03
	tilemap_rect $db59, $d170, $05, $03
	tilemap_rect $da5b, $d176, $05, $03
	tilemap_rect_end
.rl_180:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d061, $05, $03
	tilemap_rect $daa5, $d067, $05, $03
	tilemap_rect $daaa, $d06d, $05, $03
	tilemap_rect $daaf, $d0e2, $05, $03
	tilemap_rect $dab4, $d0e8, $05, $03
	tilemap_rect $dab9, $d0ee, $05, $03
	tilemap_rect $db54, $d167, $05, $03
	tilemap_rect $db59, $d16d, $05, $03
	tilemap_rect $da5b, $d173, $05, $03
	tilemap_rect_end
.rl_181:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d061, $05, $03
	tilemap_rect $daa5, $d067, $05, $03
	tilemap_rect $daaa, $d06d, $05, $03
	tilemap_rect $daaf, $d0e1, $05, $03
	tilemap_rect $dab4, $d0e7, $05, $03
	tilemap_rect $dab9, $d0ed, $05, $03
	tilemap_rect $db54, $d164, $05, $03
	tilemap_rect $db59, $d16a, $05, $03
	tilemap_rect $da5b, $d170, $05, $03
	tilemap_rect_end
.rl_182:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d061, $05, $03
	tilemap_rect $daa5, $d067, $05, $03
	tilemap_rect $daaa, $d06d, $05, $03
	tilemap_rect $daaf, $d0e1, $05, $03
	tilemap_rect $dab4, $d0e7, $05, $03
	tilemap_rect $dab9, $d0ed, $05, $03
	tilemap_rect $db54, $d162, $05, $03
	tilemap_rect $db59, $d168, $05, $03
	tilemap_rect $da5b, $d16e, $05, $03
	tilemap_rect_end
.rl_183:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d061, $05, $03
	tilemap_rect $daa5, $d067, $05, $03
	tilemap_rect $daaa, $d06d, $05, $03
	tilemap_rect $daaf, $d0e1, $05, $03
	tilemap_rect $dab4, $d0e7, $05, $03
	tilemap_rect $dab9, $d0ed, $05, $03
	tilemap_rect $db54, $d161, $05, $03
	tilemap_rect $db59, $d167, $05, $03
	tilemap_rect $da5b, $d16d, $05, $03
	tilemap_rect_end
.rl_184:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d060, $05, $03
	tilemap_rect $daa5, $d066, $05, $03
	tilemap_rect $daaa, $d06c, $05, $03
	tilemap_rect $daaf, $d0e1, $05, $03
	tilemap_rect $dab4, $d0e7, $05, $03
	tilemap_rect $dab9, $d0ed, $05, $03
	tilemap_rect $db54, $d161, $05, $03
	tilemap_rect $db59, $d167, $05, $03
	tilemap_rect $da5b, $d16d, $05, $03
	tilemap_rect_end
.rl_185:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d05e, $05, $03
	tilemap_rect $daa5, $d064, $05, $03
	tilemap_rect $daaa, $d06a, $05, $03
	tilemap_rect $daaf, $d0e0, $05, $03
	tilemap_rect $dab4, $d0e6, $05, $03
	tilemap_rect $dab9, $d0ec, $05, $03
	tilemap_rect $db54, $d161, $05, $03
	tilemap_rect $db59, $d167, $05, $03
	tilemap_rect $da5b, $d16d, $05, $03
	tilemap_rect_end
.rl_186:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $daa0, $d05b, $05, $03
	tilemap_rect $daa5, $d061, $05, $03
	tilemap_rect $daaa, $d067, $05, $03
	tilemap_rect $daaf, $d0de, $05, $03
	tilemap_rect $dab4, $d0e4, $05, $03
	tilemap_rect $dab9, $d0ea, $05, $03
	tilemap_rect $db54, $d160, $05, $03
	tilemap_rect $db59, $d166, $05, $03
	tilemap_rect $da5b, $d16c, $05, $03
	tilemap_rect_end
.rl_187:
	tilemap_rect $db80, $d000, $14, $01
	tilemap_rect $daa0, $d058, $05, $03
	tilemap_rect $daa5, $d05e, $05, $03
	tilemap_rect $daaa, $d064, $05, $03
	tilemap_rect $daaf, $d0db, $05, $03
	tilemap_rect $dab4, $d0e1, $05, $03
	tilemap_rect $dab9, $d0e7, $05, $03
	tilemap_rect $db54, $d15e, $05, $03
	tilemap_rect $db59, $d164, $05, $03
	tilemap_rect $da5b, $d16a, $05, $03
	tilemap_rect_end
.rl_188:
	tilemap_rect $daa5, $d05b, $05, $03
	tilemap_rect $daaa, $d061, $05, $03
	tilemap_rect $daaf, $d0d8, $05, $03
	tilemap_rect $dab4, $d0de, $05, $03
	tilemap_rect $dab9, $d0e4, $05, $03
	tilemap_rect $db54, $d15b, $05, $03
	tilemap_rect $db59, $d161, $05, $03
	tilemap_rect $da5b, $d167, $05, $03
	tilemap_rect_end
.rl_189:
	tilemap_rect $daaa, $d05e, $05, $03
	tilemap_rect $dab4, $d0db, $05, $03
	tilemap_rect $dab9, $d0e1, $05, $03
	tilemap_rect $db54, $d158, $05, $03
	tilemap_rect $db59, $d15e, $05, $03
	tilemap_rect $da5b, $d164, $05, $03
	tilemap_rect_end
.rl_190:
	tilemap_rect $dab9, $d0de, $05, $03
	tilemap_rect $db59, $d15b, $05, $03
	tilemap_rect $da5b, $d161, $05, $03
	tilemap_rect_end
.rl_191:
	tilemap_rect $da5b, $d15e, $05, $03
	tilemap_rect_end
.rl_192:
	tilemap_rect $da5b, $d15b, $05, $03
	tilemap_rect_end
.rl_193:
	tilemap_rect $da5b, $d158, $05, $03
	tilemap_rect_end
.rl_194:
	tilemap_rect_end
.rl_195:
	tilemap_rect $db80, $d000, $14, $01
	tilemap_rect $da40, $d091, $03, $03
	tilemap_rect_end
.rl_196:
	tilemap_rect $db80, $d000, $14, $01
	tilemap_rect $da40, $d08e, $03, $03
	tilemap_rect_end
.rl_197:
	tilemap_rect $db80, $d000, $14, $01
	tilemap_rect $da40, $d08b, $03, $03
	tilemap_rect $da43, $d091, $03, $03
	tilemap_rect_end
.rl_198:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $da40, $d088, $03, $03
	tilemap_rect $da43, $d08e, $03, $03
	tilemap_rect $da46, $d094, $03, $03
	tilemap_rect_end
.rl_199:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $da40, $d085, $03, $03
	tilemap_rect $da43, $d08b, $03, $03
	tilemap_rect $da46, $d091, $03, $03
	tilemap_rect $da49, $d134, $03, $03
	tilemap_rect_end
.rl_200:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $da40, $d083, $03, $03
	tilemap_rect $da43, $d089, $03, $03
	tilemap_rect $da46, $d08f, $03, $03
	tilemap_rect $da49, $d131, $03, $03
	tilemap_rect $da4f, $d137, $03, $03
	tilemap_rect_end
.rl_201:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $da40, $d082, $03, $03
	tilemap_rect $da43, $d088, $03, $03
	tilemap_rect $da46, $d08e, $03, $03
	tilemap_rect $da49, $d12e, $03, $03
	tilemap_rect $da4f, $d134, $03, $03
	tilemap_rect_end
.rl_202:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $da40, $d082, $03, $03
	tilemap_rect $da43, $d088, $03, $03
	tilemap_rect $da46, $d08e, $03, $03
	tilemap_rect $da49, $d12b, $03, $03
	tilemap_rect $da4f, $d131, $03, $03
	tilemap_rect_end
.rl_203:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $da40, $d082, $03, $03
	tilemap_rect $da43, $d088, $03, $03
	tilemap_rect $da46, $d08e, $03, $03
	tilemap_rect $da49, $d128, $03, $03
	tilemap_rect $da4f, $d12e, $03, $03
	tilemap_rect_end
.rl_204:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $da40, $d082, $03, $03
	tilemap_rect $da43, $d088, $03, $03
	tilemap_rect $da46, $d08e, $03, $03
	tilemap_rect $da49, $d126, $03, $03
	tilemap_rect $da4f, $d12c, $03, $03
	tilemap_rect_end
.rl_205:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $da40, $d082, $03, $03
	tilemap_rect $da43, $d088, $03, $03
	tilemap_rect $da46, $d08e, $03, $03
	tilemap_rect $da49, $d125, $03, $03
	tilemap_rect $da4f, $d12b, $03, $03
	tilemap_rect_end
.rl_206:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $da40, $d081, $03, $03
	tilemap_rect $da43, $d087, $03, $03
	tilemap_rect $da46, $d08d, $03, $03
	tilemap_rect $da49, $d125, $03, $03
	tilemap_rect $da4f, $d12b, $03, $03
	tilemap_rect_end
.rl_207:
	tilemap_rect $db60, $d000, $14, $02
	tilemap_rect $da40, $d07f, $03, $03
	tilemap_rect $da43, $d085, $03, $03
	tilemap_rect $da46, $d08b, $03, $03
	tilemap_rect $da49, $d125, $03, $03
	tilemap_rect $da4f, $d12b, $03, $03
	tilemap_rect_end
.rl_208:
	tilemap_rect $db80, $d000, $14, $01
	tilemap_rect $da40, $d07c, $03, $03
	tilemap_rect $da43, $d082, $03, $03
	tilemap_rect $da46, $d088, $03, $03
	tilemap_rect $da49, $d124, $03, $03
	tilemap_rect $da4f, $d12a, $03, $03
	tilemap_rect_end
.rl_209:
	tilemap_rect $db80, $d000, $14, $01
	tilemap_rect $da40, $d079, $03, $03
	tilemap_rect $da43, $d07f, $03, $03
	tilemap_rect $da46, $d085, $03, $03
	tilemap_rect $da49, $d122, $03, $03
	tilemap_rect $da4f, $d128, $03, $03
	tilemap_rect_end
.rl_210:
	tilemap_rect $da43, $d07c, $03, $03
	tilemap_rect $da46, $d082, $03, $03
	tilemap_rect $da49, $d11f, $03, $03
	tilemap_rect $da4f, $d125, $03, $03
	tilemap_rect_end
.rl_211:
	tilemap_rect $da46, $d07f, $03, $03
	tilemap_rect $da49, $d11c, $03, $03
	tilemap_rect $da4f, $d122, $03, $03
	tilemap_rect_end
.rl_212:
	tilemap_rect $da49, $d119, $03, $03
	tilemap_rect $da4f, $d11f, $03, $03
	tilemap_rect_end
.rl_213:
	tilemap_rect $da4f, $d11c, $03, $03
	tilemap_rect_end
FillMenuGridCellTile:
	push af ; $6dc2
	push bc ; $6dc3
	push de ; $6dc4
	push hl ; $6dc5
	ld d, c ; $6dc6
	ld e, b ; $6dc7
	ld b, $03 ; $6dc8
	ld c, $03 ; $6dca
	ld a, d ; $6dcc
	or a ; $6dcd
	jr z, .zero ; $6dce
	ld h, $0c ; $6dd0
	jr .step2 ; $6dd2
.zero:
	ld h, $0d ; $6dd4
.step2:
	push hl ; $6dd6
	ld hl, FillMenuGridCellTileTable ; $6dd7
	ld a, e ; $6dda
	add a ; $6ddb
	add l ; $6ddc
	ld l, a ; $6ddd
	jr nc, .read ; $6dde
	inc h ; $6de0
.read:
	ld a, [hl+] ; $6de1
	ld d, [hl] ; $6de2
	ld e, a ; $6de3
	pop hl ; $6de4
	farcall FillTilemapRect ; $6de5
	pop hl ; $6de8
	pop de ; $6de9
	pop bc ; $6dea
	pop af ; $6deb
	ret ; $6dec
FillMenuGridCellTileTable:
	; $6ded, 12 bytes (records:2)
	dw $d482 ; record 0
	dw $d488 ; record 1
	dw $d48e ; record 2
	dw $d525 ; record 3
	dw $d52b ; record 4
	dw $d52b ; record 5
MoveMinigameGridCursor:
	ld a, [wMenuCursorY] ; $6df9
	or a ; $6dfc
	jr nz, .checkMenuInputPressed ; $6dfd
	ld a, [wMenuInputPressed] ; $6dff
	bit PADB_RIGHT, a ; $6e02
	jr nz, .checkMenuCursorX ; $6e04
	bit 5, a ; $6e06
	jr nz, .checkMenuCursorX2 ; $6e08
	bit 6, a ; $6e0a
	jr nz, .checkMenuCursorX3 ; $6e0c
	bit 7, a ; $6e0e
	jr nz, .checkMenuCursorX3 ; $6e10
	xor a ; $6e12
	jp .done ; $6e13
.checkMenuCursorX:
	ld a, [wMenuCursorX] ; $6e16
	inc a ; $6e19
	add a ; $6e1a
	jr nc, .noCarry ; $6e1b
	ld a, $03 ; $6e1d
	dec a ; $6e1f
	jr .store ; $6e20
.noCarry:
	rra ; $6e22
	cp $03 ; $6e23
	jr c, .store ; $6e25
	xor a ; $6e27
.store:
	ld [wMenuCursorX], a ; $6e28
	ld a, $01 ; $6e2b
	jp .done ; $6e2d
.checkMenuCursorX2:
	ld a, [wMenuCursorX] ; $6e30
	dec a ; $6e33
	add a ; $6e34
	jr nc, .noCarry2 ; $6e35
	ld a, $03 ; $6e37
	dec a ; $6e39
	jr .store2 ; $6e3a
.noCarry2:
	rra ; $6e3c
	cp $03 ; $6e3d
	jr c, .store2 ; $6e3f
	xor a ; $6e41
.store2:
	ld [wMenuCursorX], a ; $6e42
	ld a, $01 ; $6e45
	jr .done ; $6e47
.checkMenuCursorX3:
	ld a, [wMenuCursorX] ; $6e49
	ld hl, MoveMinigameGridCursorTable0 ; $6e4c
	add l ; $6e4f
	ld l, a ; $6e50
	jr nc, .read ; $6e51
	inc h ; $6e53
.read:
	ld a, [hl] ; $6e54
	ld [wMenuCursorX], a ; $6e55
	ld a, [wMenuCursorY] ; $6e58
	xor $01 ; $6e5b
	ld [wMenuCursorY], a ; $6e5d
	ld a, $01 ; $6e60
	jr .done ; $6e62
.checkMenuInputPressed:
	ld a, [wMenuInputPressed] ; $6e64
	bit PADB_RIGHT, a ; $6e67
	jr nz, .checkMenuCursorX4 ; $6e69
	bit 5, a ; $6e6b
	jr nz, .checkMenuCursorX5 ; $6e6d
	bit 6, a ; $6e6f
	jr nz, .checkMenuCursorX6 ; $6e71
	bit 7, a ; $6e73
	jr nz, .checkMenuCursorX6 ; $6e75
	xor a ; $6e77
	jr .done ; $6e78
.checkMenuCursorX4:
	ld a, [wMenuCursorX] ; $6e7a
	or a ; $6e7d
	jr z, .zero ; $6e7e
	xor a ; $6e80
	jr .store3 ; $6e81
.zero:
	ld a, $02 ; $6e83
.store3:
	ld [wMenuCursorX], a ; $6e85
	ld a, $01 ; $6e88
	jr .done ; $6e8a
.checkMenuCursorX5:
	ld a, [wMenuCursorX] ; $6e8c
	or a ; $6e8f
	jr z, .zero2 ; $6e90
	xor a ; $6e92
	jr .store4 ; $6e93
.zero2:
	ld a, $02 ; $6e95
.store4:
	ld [wMenuCursorX], a ; $6e97
	ld a, $01 ; $6e9a
	jr .done ; $6e9c
.checkMenuCursorX6:
	ld a, [wMenuCursorX] ; $6e9e
	ld hl, MoveMinigameGridCursorTable1 ; $6ea1
	add l ; $6ea4
	ld l, a ; $6ea5
	jr nc, .readB ; $6ea6
	inc h ; $6ea8
.readB:
	ld a, [hl] ; $6ea9
	ld [wMenuCursorX], a ; $6eaa
	ld a, [wMenuCursorY] ; $6ead
	xor $01 ; $6eb0
	ld [wMenuCursorY], a ; $6eb2
	ld a, $01 ; $6eb5
	jr .done ; $6eb7
.done:
	ret ; $6eb9
MoveMinigameGridCursorTable0:
	; $6eba, 3 bytes (bytes:3)
	db $00, $02, $02 ; 0x00
MoveMinigameGridCursorTable1:
	; $6ebd, 3 bytes (bytes:3)
	db $00, $02, $02 ; 0x00
InitNumberSpriteGfx:
	push af ; $6ec0
	push bc ; $6ec1
	push de ; $6ec2
	push hl ; $6ec3
	ld hl, $cb64 ; $6ec4
	ld bc, $0007 ; $6ec7
	call ClearBytes ; $6eca
	xor a ; $6ecd
	ld [wDigitSpriteTileBase], a ; $6ece
	ld [wDigitSpriteAttr], a ; $6ed1
	pop hl ; $6ed4
	pop de ; $6ed5
	pop bc ; $6ed6
	pop af ; $6ed7
	ld a, $08 ; $6ed8
	ld [wDigitSpriteAttr], a ; $6eda
	ld a, $00 ; $6edd
	ld [wDigitSpriteTileBase], a ; $6edf
	ld a, c ; $6ee2
	or a ; $6ee3
	jr nz, InitNumberSpriteGfxWide ; $6ee4
	push bc ; $6ee6
	ld b, $49 ; $6ee7
	ld c, $14 ; $6ee9
	farcall LoadCompressedTileBlock ; $6eeb
	pop bc ; $6eee
	ld hl, Palette_39_6f08 ; $6eef
	ld d, b ; $6ef2
	ld e, $01 ; $6ef3
	call LoadPaletteShadow ; $6ef5
	ret ; $6ef8
InitNumberSpriteGfxWide:
	push bc ; $6ef9
	ld b, $14 ; $6efa
	ld c, $18 ; $6efc
	farcall LoadCompressedTileBlock ; $6efe
	pop bc ; $6f01
	ld c, $0c ; $6f02
	farcall LoadIndexedPalette ; $6f04
	ret ; $6f07
Palette_39_6f08:
	INCLUDE "data/bank_039/palettes_6f08.asm" ; $6f08, 8 bytes (palettes)
DrawDecimalNumberSprites_39:
	push af ; $6f10
	push bc ; $6f11
	push de ; $6f12
	push hl ; $6f13
	ldh a, [hWramBank] ; $6f14
	push af ; $6f16
	wram_bank $02 ; $6f17
	push de ; $6f1d
	ld de, $cb64 ; $6f1e
	ld a, $00 ; $6f21
	call FormatDecimalNumber ; $6f23
	pop de ; $6f26
	ld b, $00 ; $6f27
	ld hl, $cb64 ; $6f29
.lenLoop:
	ld a, [hl] ; $6f2c
	or a ; $6f2d
	jr z, .atEnd ; $6f2e
	inc b ; $6f30
	inc hl ; $6f31
	jr .lenLoop ; $6f32
.atEnd:
	dec hl ; $6f34
.digitLoop:
	ld a, [hl-] ; $6f35
	sub $30 ; $6f36
	ld c, a ; $6f38
	call DrawDigitSprite_39 ; $6f39
	ld a, d ; $6f3c
	sub $08 ; $6f3d
	ld d, a ; $6f3f
	dec b ; $6f40
	jr z, .done ; $6f41
	jr .digitLoop ; $6f43
.done:
	pop af ; $6f45
	wram_bank ; $6f46
	pop hl ; $6f4a
	pop de ; $6f4b
	pop bc ; $6f4c
	pop af ; $6f4d
	ret ; $6f4e
DrawDigitSprite_39:
	push af ; $6f4f
	push bc ; $6f50
	push de ; $6f51
	push hl ; $6f52
	ld a, [wDigitSpriteTileBase] ; $6f53
	ld b, a ; $6f56
	ld a, c ; $6f57
	add a ; $6f58
	add b ; $6f59
	ld c, a ; $6f5a
	ld a, [wDigitSpriteAttr] ; $6f5b
	ld b, a ; $6f5e
	call QueueSprite ; $6f5f
	pop hl ; $6f62
	pop de ; $6f63
	pop bc ; $6f64
	pop af ; $6f65
	ret ; $6f66
UpdateCheatCodeEntry:
	ldh a, [hWramBank] ; $6f67
	push af ; $6f69
	wram_bank $01 ; $6f6a
	ld a, [$cb71] ; $6f70
	or a ; $6f73
	jr nz, .restore ; $6f74
	ldh a, [hInputRisingEdge] ; $6f76
	bit PADB_A, a ; $6f78
	jr z, .zero ; $6f7a
	ld c, $00 ; $6f7c
.loop:
	ld hl, $d000 ; $6f7e
	ld a, c ; $6f81
	add l ; $6f82
	ld l, a ; $6f83
	jr nc, .read ; $6f84
	inc h ; $6f86
.read:
	ld d, [hl] ; $6f87
	ld a, c ; $6f88
	ld hl, CheatCodeEntryTable ; $6f89
	add l ; $6f8c
	ld l, a ; $6f8d
	jr nc, .readB ; $6f8e
	inc h ; $6f90
.readB:
	ld a, [hl] ; $6f91
	cp d ; $6f92
	jr nz, .restore ; $6f93
	inc c ; $6f95
	ld a, c ; $6f96
	cp $20 ; $6f97
	jr nz, .loop ; $6f99
	call TriggerCheatUnlock ; $6f9b
	ld a, $01 ; $6f9e
	ld [$cb71], a ; $6fa0
	jr .restore ; $6fa3
.zero:
	ldh a, [hInputRisingEdge] ; $6fa5
	or a ; $6fa7
	jr z, .restore ; $6fa8
	ld b, a ; $6faa
	ld a, [$cb1a] ; $6fab
	and $1f ; $6fae
	ld hl, $d000 ; $6fb0
	add l ; $6fb3
	ld l, a ; $6fb4
	jr nc, .store ; $6fb5
	inc h ; $6fb7
.store:
	ld [hl], b ; $6fb8
	ld a, [$cb1a] ; $6fb9
	inc a ; $6fbc
	ld [$cb1a], a ; $6fbd
.restore:
	pop af ; $6fc0
	wram_bank ; $6fc1
	ret ; $6fc5
CheatCodeEntryTable:
	; $6fc6, 33 bytes (bytes:16)
	db $80, $80, $10, $10, $40, $40, $20, $04, $04, $04, $10, $80, $80, $20, $20, $40 ; 0x00
	db $40, $10, $04, $20, $80, $80, $10, $10, $40, $40, $20, $04, $04, $00, $00, $00 ; 0x10
	db $00 ; 0x20
ResetCheatCodeBuffer:
	ldh a, [hWramBank] ; $6fe7
	push af ; $6fe9
	wram_bank $01 ; $6fea
	xor a ; $6ff0
	ld [$cb1a], a ; $6ff1
	ld hl, $d000 ; $6ff4
	ld bc, $0020 ; $6ff7
	call ClearBytes ; $6ffa
	pop af ; $6ffd
	wram_bank ; $6ffe
	ret ; $7002
TriggerCheatUnlock:
	sound $65 ; $7003
	farcall ApplyUnlockEverythingCheat ; $7005
	ret ; $7008
RacketShoesChoiceGfx0:
	INCBIN "data/bank_039/lz_7009.bin" ; $7009, 178 bytes
RacketShoesChoiceGfx1:
	INCBIN "data/bank_039/lz_70bb.bin" ; $70bb, 194 bytes
MenuArrowGfx0:
	INCBIN "data/bank_039/lz_717d.bin" ; $717d, 57 bytes
MenuArrowGfx1:
	INCBIN "data/bank_039/lz_71b6.bin" ; $71b6, 50 bytes
MenuArrowGfx2:
	INCBIN "data/bank_039/lz_71e8.bin" ; $71e8, 59 bytes
MenuArrowGfx3:
	INCBIN "data/bank_039/lz_7223.bin" ; $7223, 58 bytes
CharGridGfx2:
	INCBIN "data/bank_039/lz_725d.bin" ; $725d, 241 bytes
DigitFontTiles:
	INCBIN "data/bank_039/lz_734e.bin" ; $734e, 249 bytes
	ret ; $7447
	push af ; $7448
	push bc ; $7449
	push de ; $744a
	push hl ; $744b
	pop hl ; $744c
	pop de ; $744d
	pop bc ; $744e
	pop af ; $744f
	ret ; $7450
	push af ; $7451
	push bc ; $7452
	push de ; $7453
	push hl ; $7454
	pop hl ; $7455
	pop de ; $7456
	pop bc ; $7457
	pop af ; $7458
	ret ; $7459
FillIncrementingBytes:
	ld a, b ; $745a
	ld [hl+], a ; $745b
	inc b ; $745c
	dec c ; $745d
	ld a, c ; $745e
	or a ; $745f
	jr nz, FillIncrementingBytes ; $7460
	ret ; $7462
	; $7463, 2973 bytes fill to bank end (linker-padded)
