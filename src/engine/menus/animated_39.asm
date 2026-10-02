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
	wram_bank WRAM_STAGING ; $4090
	push hl ; $4096
	ld a, [hl+] ; $4097
	ld h, [hl] ; $4098
	ld l, a ; $4099
	ld de, wDecompBuffer ; $409a
	call DecompressDataFromBank ; $409d
	ld hl, wDecompBuffer ; $40a0
	ld de, vTiles2 + VRAM_BANK1 ; $40a3
	ld c, $80 ; $40a6
	call QueueVRAMCopy ; $40a8
	ld hl, wTextTileBuffer ; $40ab
	ld de, vTiles1 + VRAM_BANK1 ; $40ae
	ld c, $80 ; $40b1
	call QueueVRAMCopy ; $40b3
	pop hl ; $40b6
	inc hl ; $40b7
	inc hl ; $40b8
	push hl ; $40b9
	ld a, [hl+] ; $40ba
	ld h, [hl] ; $40bb
	ld l, a ; $40bc
	wram_bank WRAM_SCREEN ; $40bd
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
	wram_bank WRAM_STAGING ; $40dc
	ld de, wDecompBuffer ; $40e2
	ld bc, $0040 ; $40e5
	call CopyDataFromBank ; $40e8
	ld hl, wDecompBuffer ; $40eb
	ld_bg_pals de, 0, 8 ; $40ee
	call LoadPaletteShadow ; $40f1
	ret ; $40f4
ScreenAssetRecordTable:
	; $40f5, 560 bytes (70 records x 4 slot words)
	screen_asset MatchTypeMenu, DataPtr_NameEntryTilemapAlias9, DataPtr_NameEntryTilemapAlias10, DataPtr_NameEntryTilemapAlias11, DataPtr_NameEntryTilemapAlias12 ; record 0
	screen_asset ExhibitionSetup, DataPtr_ExhibitionSetupTiles, DataPtr_ExhibitionSetupTilemap, DataPtr_ExhibitionSetupAttrmap, DataPtr_ExhibitionSetupPalettes ; record 1
	screen_asset MainMenu, DataPtr_MainMenuGfx5, DataPtr_MainMenuGfx5Alias1, DataPtr_MainMenuGfx5Alias2, DataPtr_MainMenuGfx5Alias3 ; record 2
	screen_asset MatchTypeMenuAlt, DataPtr_NameEntryTilemapAlias9, DataPtr_NameEntryTilemapAlias10, DataPtr_NameEntryTilemapAlias11, DataPtr_NameEntryTilemapAlias12 ; record 3
	screen_asset JapanesePlayMode, DataPtr_JapanesePlayModeTiles, DataPtr_JapanesePlayModeTilemap, DataPtr_JapanesePlayModeAttrmap, DataPtr_JapanesePlayModePalettes ; record 4
	screen_asset CharacterSelect, DataPtr_CharacterSelectTiles, DataPtr_CharacterSelectTilemap, DataPtr_CharacterSelectAttrmap, DataPtr_CharacterSelectPalettes ; record 5
	screen_asset NameEntry, DataPtr_CharacterSelectTiles, DataPtr_NameEntryTilemapAlias8, DataPtr_NameEntryAttrmap, DataPtr_CharacterSelectPalettes ; record 6
	screen_asset CharSelectAlt, DataPtr_CharacterSelectTiles, DataPtr_CharSelectAltTilemap, DataPtr_CharSelectAltAttrmap, DataPtr_CharacterSelectPalettes ; record 7
	screen_asset NameEntryVariant1, DataPtr_NameEntryTilemap, DataPtr_NameEntryTilemapAlias1, DataPtr_NameEntryTilemapAlias2, DataPtr_NameEntryTilemapAlias3 ; record 8
	screen_asset QueueWram3MapToVRAMPtrs, FarPtr_QueueWram3MapToVRAMAlias1, FarPtr_QueueWram3MapToVRAMAlias2, FarPtr_QueueWram3MapToVRAMAlias3, FarPtr_QueueWram3MapToVRAMAlias4 ; record 9
	screen_asset NameEntryVariant2, DataPtr_NameEntryTilemap, DataPtr_NameEntryTilemapAlias4, DataPtr_NameEntryTilemapAlias5, DataPtr_NameEntryTilemapAlias3 ; record 10
	screen_asset NameEntryVariant3, DataPtr_NameEntryTilemap, DataPtr_NameEntryTilemapAlias6, DataPtr_NameEntryTilemapAlias7, DataPtr_NameEntryTilemapAlias3 ; record 11
	screen_asset ExhibitionMenu, DataPtr_ExhibitionMenuTiles, DataPtr_ExhibitionMenuTilemap, DataPtr_ExhibitionMenuAttrmap, DataPtr_ExhibitionMenuPalettes ; record 12
	screen_asset N64Tournament, DataPtr_N64TournamentTiles, DataPtr_N64TournamentTilemap, DataPtr_N64TournamentAttrmap, DataPtr_N64TournamentPalettes ; record 13
	screen_asset N64Tournament2, DataPtr_N64TournamentTiles, DataPtr_N64TournamentTilemap2, DataPtr_N64TournamentAttrmap2, DataPtr_N64TournamentPalettes ; record 14
	screen_asset ModeSelect, DataPtr_ModeSelectTiles, DataPtr_ModeSelectTilemap, DataPtr_ModeSelectAttrmap, DataPtr_ModeSelectPalettes ; record 15
	screen_asset WarningScreen, DataPtr_WarningScreenTiles, DataPtr_WarningScreenTilemap, DataPtr_WarningScreenAttrmap, DataPtr_WarningScreenPalettes ; record 16
	screen_asset LinkingScreen, DataPtr_LinkingScreenTiles, DataPtr_LinkingScreenTilemap, DataPtr_LinkingScreenAttrmap, DataPtr_LinkingScreenPalettes ; record 17
	screen_asset RingShotHud, DataPtr_RingShotHudTiles, DataPtr_RingShotHudTilemap, DataPtr_RingShotHudAttrmap, DataPtr_RingShotHudPalettes ; record 18
	screen_asset MatchStats, DataPtr_MatchStatsTiles, DataPtr_MatchStatsTilemap, DataPtr_MatchStatsAttrmap, DataPtr_MatchStatsPalettes ; record 19
	screen_asset MatchStats2, DataPtr_MatchStatsTiles, DataPtr_MatchStatsTilemap2, DataPtr_MatchStatsAttrmap2, DataPtr_MatchStatsPalettes ; record 20
	screen_asset CompanyLogos, DataPtr_CompanyLogosTiles, DataPtr_CompanyLogosTilemap, DataPtr_CompanyLogosAttrmap, DataPtr_CompanyLogosPalettes ; record 21
	screen_asset IntroRallies, DataPtr_IntroRalliesTiles, DataPtr_IntroRalliesTilemap, DataPtr_IntroRalliesAttrmap, DataPtr_IntroRalliesPalettes ; record 22
	screen_asset IntroRallies2, DataPtr_IntroRalliesTiles, DataPtr_IntroRalliesTilemap2, DataPtr_IntroRalliesAttrmap2, DataPtr_IntroRalliesPalettes ; record 23
	screen_asset IntroRallies3, DataPtr_IntroRalliesTiles, DataPtr_IntroRalliesTilemap3, DataPtr_IntroRalliesAttrmap3, DataPtr_IntroRalliesPalettes ; record 24
	screen_asset IntroRallies4, DataPtr_IntroRalliesTiles, DataPtr_IntroRalliesTilemap4, DataPtr_IntroRalliesAttrmap4, DataPtr_IntroRalliesPalettes ; record 25
	screen_asset IntroSwing, DataPtr_IntroSwingTiles, DataPtr_IntroSwingTilemap, DataPtr_IntroSwingAttrmap, DataPtr_IntroSwingPalettes ; record 26
	screen_asset IntroCloseup, DataPtr_IntroCloseupTiles, DataPtr_IntroCloseupTilemap, DataPtr_IntroCloseupAttrmap, DataPtr_IntroCloseupPalettes ; record 27
	screen_asset IntroWave, DataPtr_IntroWaveTiles, DataPtr_IntroWaveTilemap, DataPtr_IntroWaveAttrmap, DataPtr_IntroWavePalettes ; record 28
	screen_asset IntroDive, DataPtr_IntroDiveTiles, DataPtr_IntroDiveTilemap, DataPtr_IntroDiveAttrmap, DataPtr_IntroDivePalettes ; record 29
	screen_asset IntroGirlSwing, DataPtr_IntroGirlSwingTiles, DataPtr_IntroGirlSwingTilemap, DataPtr_IntroGirlSwingAttrmap, DataPtr_IntroGirlSwingPalettes ; record 30
	screen_asset TitleScreen, DataPtr_TitleScreenTiles, DataPtr_TitleScreenTilemap, DataPtr_TitleScreenAttrmap, DataPtr_TitleScreenPalettes ; record 31
	screen_asset DecompressIntroTitleTilesPtrs, FarPtr_DecompressIntroTitleTiles, FarPtr_DecompressIntroTitleTilesAlias1, FarPtr_DecompressIntroTitleTilesAlias2, FarPtr_DecompressIntroTitleTilesAlias3 ; record 32
	screen_asset EquipmentSelect, DataPtr_EquipmentSelectTiles, DataPtr_EquipmentSelectTilemap, DataPtr_EquipmentSelectAttrmap, DataPtr_EquipmentSelectPalettes ; record 33
	screen_asset LinkError, DataPtr_LinkErrorTiles, DataPtr_LinkErrorTilemap, DataPtr_LinkErrorAttrmap, DataPtr_LinkErrorPalettes ; record 34
	screen_asset MatchStats3, DataPtr_MatchStatsTiles, DataPtr_MatchStatsTilemap3, DataPtr_MatchStatsAttrmap3, DataPtr_MatchStatsPalettes ; record 35
	screen_asset CourtDiagram, DataPtr_CourtDiagramTiles, DataPtr_CourtDiagramTilemap, DataPtr_CourtDiagramAttrmap, DataPtr_CourtDiagramPalettes ; record 36
	screen_asset VarsityTeamChart, DataPtr_VarsityTeamChartTiles, DataPtr_VarsityTeamChartTilemap, DataPtr_VarsityTeamChartAttrmap, DataPtr_VarsityTeamChartPalettes ; record 37
	screen_asset VarsityTeamChart2, DataPtr_VarsityTeamChartTiles, DataPtr_VarsityTeamChartTilemap2, DataPtr_VarsityTeamChartAttrmap2, DataPtr_VarsityTeamChartPalettes ; record 38
	screen_asset IntroGreatestPlayer, DataPtr_IntroGreatestPlayerTiles, DataPtr_IntroGreatestPlayerTilemap, DataPtr_IntroGreatestPlayerAttrmap, DataPtr_IntroGreatestPlayerPalettes ; record 39
	screen_asset IntroCharacterIcon, DataPtr_IntroCharacterIcon00, DataPtr_IntroCharacterIcon00Alias1, DataPtr_IntroCharacterIcon00Alias2, DataPtr_IntroCharacterIcon00Alias3 ; record 40
	screen_asset TournamentBracketSingles, DataPtr_TournamentBracketTiles, DataPtr_TournamentBracketSinglesTilemap, DataPtr_TournamentBracketSinglesAttrmap, DataPtr_TournamentBracketPalettes ; record 41
	screen_asset TournamentBracketDoubles, DataPtr_TournamentBracketTiles, DataPtr_TournamentBracketDoublesTilemap, DataPtr_TournamentBracketDoublesAttrmap, DataPtr_TournamentBracketPalettes ; record 42
	screen_asset MarioMiniGames, DataPtr_MarioMiniGamesTiles, DataPtr_MarioMiniGamesTilemap, DataPtr_MarioMiniGamesAttrmap, DataPtr_MarioMiniGamesPalettes ; record 43
	screen_asset VictoryCutscene, DataPtr_VictoryCutsceneTiles, DataPtr_VictoryCutsceneTilemap, DataPtr_VictoryCutsceneAttrmap, DataPtr_VictoryCutscenePalettes ; record 44
	screen_asset VictoryCutscene2, DataPtr_VictoryCutsceneTiles, DataPtr_VictoryCutsceneTilemap2, DataPtr_VictoryCutsceneAttrmap2, DataPtr_VictoryCutscenePalettes ; record 45
	screen_asset VictoryCutscene3, DataPtr_VictoryCutsceneTiles, DataPtr_VictoryCutsceneTilemap3, DataPtr_VictoryCutsceneAttrmap3, DataPtr_VictoryCutscenePalettes ; record 46
	screen_asset VictoryCutscene4, DataPtr_VictoryCutsceneTiles, DataPtr_VictoryCutsceneTilemap4, DataPtr_VictoryCutsceneAttrmap4, DataPtr_VictoryCutscenePalettes ; record 47
	screen_asset VictoryCutscene5, DataPtr_VictoryCutsceneTiles, DataPtr_VictoryCutsceneTilemap5, DataPtr_VictoryCutsceneAttrmap5, DataPtr_VictoryCutscenePalettes ; record 48
	screen_asset VictoryCutscene6, DataPtr_VictoryCutsceneTiles, DataPtr_VictoryCutsceneTilemap6, DataPtr_VictoryCutsceneAttrmap6, DataPtr_VictoryCutscenePalettes ; record 49
	screen_asset ShopCutscene, DataPtr_ShopCutsceneTiles, DataPtr_ShopCutsceneTilemap, DataPtr_ShopCutsceneAttrmap, DataPtr_ShopCutscenePalettes ; record 50
	screen_asset ShopCutscene2, DataPtr_ShopCutsceneTiles, DataPtr_ShopCutsceneTilemap2, DataPtr_ShopCutsceneAttrmap2, DataPtr_ShopCutscenePalettes ; record 51
	screen_asset ShopCutscene3, DataPtr_ShopCutsceneTiles, DataPtr_ShopCutsceneTilemap3, DataPtr_ShopCutsceneAttrmap3, DataPtr_ShopCutscenePalettes ; record 52
	screen_asset ShopCutscene4, DataPtr_ShopCutsceneTiles, DataPtr_ShopCutsceneTilemap4, DataPtr_ShopCutsceneAttrmap4, DataPtr_ShopCutscenePalettes ; record 53
	screen_asset ShopCutscene5, DataPtr_ShopCutsceneTiles, DataPtr_ShopCutsceneTilemap5, DataPtr_ShopCutsceneAttrmap5, DataPtr_ShopCutscenePalettes ; record 54
	screen_asset ShopCutscene6, DataPtr_ShopCutsceneTiles, DataPtr_ShopCutsceneTilemap6, DataPtr_ShopCutsceneAttrmap6, DataPtr_ShopCutscenePalettes ; record 55
	screen_asset AwardCeremony, DataPtr_AwardCeremonyTilesAlias4, DataPtr_AwardCeremonyTilemap, DataPtr_AwardCeremonyAttrmap, DataPtr_AwardCeremonyPalettes ; record 56
	screen_asset AwardCeremony2, DataPtr_AwardCeremonyTilesAlias4, DataPtr_AwardCeremonyTilemap2, DataPtr_AwardCeremonyAttrmap2, DataPtr_AwardCeremonyPalettes ; record 57
	screen_asset AwardCeremony3, DataPtr_AwardCeremonyTilesAlias4, DataPtr_AwardCeremonyTilemap3, DataPtr_AwardCeremonyAttrmap3, DataPtr_AwardCeremonyPalettes ; record 58
	screen_asset AwardCeremony4, DataPtr_AwardCeremonyTilesAlias4, DataPtr_AwardCeremonyTilemap4, DataPtr_AwardCeremonyAttrmap4, DataPtr_AwardCeremonyPalettes ; record 59
	screen_asset AwardCeremony5, DataPtr_AwardCeremonyTilesAlias4, DataPtr_AwardCeremonyTilemap5, DataPtr_AwardCeremonyAttrmap5, DataPtr_AwardCeremonyPalettes ; record 60
	screen_asset AwardCeremony6, DataPtr_AwardCeremonyTilesAlias4, DataPtr_AwardCeremonyTilemap6, DataPtr_AwardCeremonyAttrmap6, DataPtr_AwardCeremonyPalettes ; record 61
	screen_asset ChampionMedal, DataPtr_ChampionMedalTiles, DataPtr_ChampionMedalTilemap, DataPtr_ChampionMedalAttrmap, DataPtr_ChampionMedalPalettes ; record 62
	screen_asset ChampionMedal2, DataPtr_ChampionMedalTiles, DataPtr_ChampionMedalTilemap2, DataPtr_ChampionMedalAttrmap2, DataPtr_ChampionMedalPalettes ; record 63
	screen_asset ChampionMedal3, DataPtr_ChampionMedalTiles, DataPtr_ChampionMedalTilemap3, DataPtr_ChampionMedalAttrmap3, DataPtr_ChampionMedalPalettes ; record 64
	screen_asset ChampionMedal4, DataPtr_ChampionMedalTiles, DataPtr_ChampionMedalTilemap4, DataPtr_ChampionMedalAttrmap4, DataPtr_ChampionMedalPalettes ; record 65
	screen_asset ChampionMedal5, DataPtr_ChampionMedalTiles, DataPtr_ChampionMedalTilemap5, DataPtr_ChampionMedalAttrmap5, DataPtr_ChampionMedalPalettes ; record 66
	screen_asset ChampionMedal6, DataPtr_ChampionMedalTiles, DataPtr_ChampionMedalTilemap6, DataPtr_ChampionMedalAttrmap6, DataPtr_ChampionMedalPalettes ; record 67
	screen_asset RulesScreen, DataPtr_RulesScreenTiles, DataPtr_RulesScreenTilemap, DataPtr_RulesScreenAttrmap, DataPtr_RulesScreenPalettes ; record 68
	screen_asset AwardCeremonyTilesPtrs, DataPtr_AwardCeremonyTiles, DataPtr_AwardCeremonyTilesAlias1, DataPtr_AwardCeremonyTilesAlias2, DataPtr_AwardCeremonyTilesAlias3 ; record 69
QueueWram3MapToVRAM:
	wram_bank WRAM_SCREEN ; $4325
	ld hl, wShadowTilemap ; $432b
	ld de, vBGMap0 ; $432e
	ld c, $40 ; $4331
	call QueueVRAMCopy ; $4333
	ld hl, wShadowAttrmap ; $4336
	ld de, vBGMap0 + VRAM_BANK1 ; $4339
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
	ld a, [wAnimatedTileTimer] ; $4349
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
	ld [wAnimatedTileTimer], a ; $435f
	or a ; $4362
	jp nz, .done ; $4363
	wram_bank WRAM_COURT_PLANES ; $4366
	ld a, [wAnimatedTileFrame] ; $436c
	inc a ; $436f
	ld [wAnimatedTileFrame], a ; $4370
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
	wram_bank WRAM_STAGING ; $4399
	ld de, wDecompBuffer ; $439f
	call DecompressDataFromBank ; $43a2
	ld hl, wDecompBuffer ; $43a5
	ld de, vTiles2 + $2e * TILE_SIZE + VRAM_BANK1 ; $43a8
	ld c, $02 ; $43ab
	call QueueVRAMCopy ; $43ad
	ld hl, wDecompBuffer + 2 * TILE_SIZE ; $43b0
	ld de, vTiles2 + $3e * TILE_SIZE + VRAM_BANK1 ; $43b3
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
	ld de, wDecompBuffer + 16 * TILE_SIZE ; $43dd
	call DecompressDataFromBank ; $43e0
	ld hl, wDecompBuffer + 16 * TILE_SIZE ; $43e3
	ld de, vTiles2 + $4e * TILE_SIZE + VRAM_BANK1 ; $43e6
	ld c, $02 ; $43e9
	call QueueVRAMCopy ; $43eb
	ld hl, wDecompBuffer + 18 * TILE_SIZE ; $43ee
	ld de, vTiles2 + $5e * TILE_SIZE + VRAM_BANK1 ; $43f1
	ld c, $02 ; $43f4
	call QueueVRAMCopy ; $43f6
.done:
	pop_wram_bank ; $43f9
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
	; $4413, 64 bytes (32 records x 1 slot words)
	dslot DataPtr_IntroCharacterIcon00Alias4 ; record 0
	dslot DataPtr_IntroCharacterIcon01 ; record 1
	dslot DataPtr_IntroCharacterIcon02 ; record 2
	dslot DataPtr_IntroCharacterIcon03 ; record 3
	dslot DataPtr_IntroCharacterIcon04 ; record 4
	dslot DataPtr_IntroCharacterIcon05 ; record 5
	dslot DataPtr_IntroCharacterIcon06 ; record 6
	dslot DataPtr_IntroCharacterIcon07 ; record 7
	dslot DataPtr_IntroCharacterIcon08 ; record 8
	dslot DataPtr_IntroCharacterIcon09 ; record 9
	dslot DataPtr_IntroCharacterIcon10 ; record 10
	dslot DataPtr_IntroCharacterIcon11 ; record 11
	dslot DataPtr_IntroCharacterIcon12 ; record 12
	dslot DataPtr_IntroCharacterIcon13 ; record 13
	dslot DataPtr_IntroCharacterIcon14 ; record 14
	dslot DataPtr_IntroCharacterIcon15 ; record 15
	dslot DataPtr_CourtSelectGfx5 ; record 16
	dslot DataPtr_CourtSelectGfx5Alias1 ; record 17
	dslot DataPtr_CourtSelectGfx5Alias2 ; record 18
	dslot DataPtr_CourtSelectGfx5Alias3 ; record 19
	dslot DataPtr_CourtSelectGfx5Alias4 ; record 20
	dslot DataPtr_CourtSelectGfx5Alias5 ; record 21
	dslot DataPtr_CourtSelectGfx5Alias6 ; record 22
	dslot DataPtr_CourtSelectGfx5Alias7 ; record 23
	dslot DataPtr_CourtSelectGfx5Alias8 ; record 24
	dslot DataPtr_CourtSelectGfx5Alias9 ; record 25
	dslot DataPtr_CourtSelectGfx5Alias10 ; record 26
	dslot DataPtr_CourtSelectGfx5Alias11 ; record 27
	dslot DataPtr_CourtSelectGfx5Alias12 ; record 28
	dslot DataPtr_CourtSelectGfx5Alias13 ; record 29
	dslot DataPtr_CourtSelectGfx5Alias14 ; record 30
	dslot DataPtr_CourtSelectGfx5Alias15 ; record 31
AnimatedTilesTable2:
	; $4453, 64 bytes (32 records x 1 slot words)
	dslot DataPtr_BracketCharIcon03 ; record 0
	dslot DataPtr_BracketCharIcon04 ; record 1
	dslot DataPtr_BracketCharIcon05 ; record 2
	dslot DataPtr_BracketCharIcon06 ; record 3
	dslot DataPtr_BracketCharIcon07 ; record 4
	dslot DataPtr_BracketCharIcon08 ; record 5
	dslot DataPtr_BracketCharIcon09 ; record 6
	dslot DataPtr_BracketCharIcon10 ; record 7
	dslot DataPtr_BracketCharIcon11 ; record 8
	dslot DataPtr_BracketCharIcon12 ; record 9
	dslot DataPtr_BracketCharIcon13 ; record 10
	dslot DataPtr_BracketCharIcon14 ; record 11
	dslot DataPtr_BracketCharIcon15 ; record 12
	dslot DataPtr_BracketExtraIcon0 ; record 13
	dslot DataPtr_BracketExtraIcon1 ; record 14
	dslot DataPtr_BracketExtraIcon2 ; record 15
	dslot DataPtr_MinigameLevelSelectGfx2 ; record 16
	dslot DataPtr_MinigameLevelSelectGfx2Alias1 ; record 17
	dslot DataPtr_MinigameLevelSelectGfx2Alias2 ; record 18
	dslot DataPtr_MinigameLevelSelectGfx2Alias3 ; record 19
	dslot DataPtr_MinigameLevelSelectGfx2Alias4 ; record 20
	dslot DataPtr_MinigameLevelSelectGfx2Alias5 ; record 21
	dslot DataPtr_MinigameLevelSelectGfx2Alias6 ; record 22
	dslot DataPtr_MinigameLevelSelectGfx2Alias7 ; record 23
	dslot DataPtr_MinigameLevelSelectGfx2Alias8 ; record 24
	dslot DataPtr_MinigameLevelSelectGfx2Alias9 ; record 25
	dslot DataPtr_MinigameLevelSelectGfx2Alias10 ; record 26
	dslot DataPtr_MinigameLevelSelectGfx2Alias11 ; record 27
	dslot DataPtr_MinigameLevelSelectGfx2Alias12 ; record 28
	dslot DataPtr_MinigameLevelSelectGfx2Alias13 ; record 29
	dslot DataPtr_MinigameLevelSelectGfx2Alias14 ; record 30
	dslot DataPtr_MinigameLevelSelectGfx2Alias15 ; record 31
AnimatedTilesTable3:
	; $4493, 32 bytes (16 records x 1 slot words)
	dslot DataPtr_CharRosterIcon00 ; record 0
	dslot DataPtr_CharRosterIcon01 ; record 1
	dslot DataPtr_CharRosterIcon02 ; record 2
	dslot DataPtr_CharRosterIcon03 ; record 3
	dslot DataPtr_CharRosterIcon04 ; record 4
	dslot DataPtr_CharRosterIcon05 ; record 5
	dslot DataPtr_CharRosterIcon06 ; record 6
	dslot DataPtr_CharRosterIcon07 ; record 7
	dslot DataPtr_CharRosterIcon08 ; record 8
	dslot DataPtr_CharRosterIcon09 ; record 9
	dslot DataPtr_CharRosterIcon10 ; record 10
	dslot DataPtr_CharRosterIcon11 ; record 11
	dslot DataPtr_CharRosterIcon12 ; record 12
	dslot DataPtr_CharRosterIcon13 ; record 13
	dslot DataPtr_CharRosterIcon14 ; record 14
	dslot DataPtr_CharRosterIcon15 ; record 15
AnimatedTilesTable4:
	; $44b3, 32 bytes (16 records x 1 slot words)
	dslot DataPtr_CharRosterIcon16 ; record 0
	dslot DataPtr_CharRosterIcon17 ; record 1
	dslot DataPtr_CharRosterIcon18 ; record 2
	dslot DataPtr_CharRosterIcon19 ; record 3
	dslot DataPtr_CharRosterIcon20 ; record 4
	dslot DataPtr_CharRosterIcon21 ; record 5
	dslot DataPtr_CharRosterIcon22 ; record 6
	dslot DataPtr_CharRosterIcon23 ; record 7
	dslot DataPtr_CharRosterIcon24 ; record 8
	dslot DataPtr_CharRosterIcon25 ; record 9
	dslot DataPtr_CharRosterIcon26 ; record 10
	dslot DataPtr_CharRosterIcon27 ; record 11
	dslot DataPtr_CharRosterIcon28 ; record 12
	dslot DataPtr_CharRosterIcon29 ; record 13
	dslot DataPtr_CharRosterIcon30 ; record 14
	dslot DataPtr_CharRosterIcon31 ; record 15
LoadFixedTileBlockAndPalette:
	push de ; $44d3
	wram_bank WRAM_STAGING ; $44d4
	ld hl, FixedTileBlockAndPalette ; $44da
	ld de, wDecompBuffer ; $44dd
	call DecompressData ; $44e0
	ld hl, wDecompBuffer ; $44e3
	pop de ; $44e6
	ld c, FixedTileBlockAndPalette_SIZE / 16 ; $44e7
	call QueueVRAMCopy ; $44e9
	ld hl, FixedTileBlockPalette ; $44ec
	ld_obj_pals de, 0, 1 ; $44ef
	call LoadPaletteShadow ; $44f2
	ret ; $44f5
FixedTileBlockAndPalette:
	INCBIN "data/bank_039/lz_FixedTileBlockAndPalette.bin" ; $44f6, 32 bytes
	INCLUDE "data/bank_039/lz_FixedTileBlockAndPalette.inc" ; DEF FixedTileBlockAndPalette_SIZE EQU its decoded length, generated from the .bin by make
FixedTileBlockPalette:
	INCLUDE "data/bank_039/FixedTileBlockPalette.asm" ; $4516, 8 bytes (palettes)
Unused_39_LoadFixedBgPalette0:
	ld_bg_pals de, 0, 1 ; $451e
	ld hl, FixedBgPalette0Palette ; $4521
	call LoadPaletteShadow ; $4524
	ret ; $4527
FixedBgPalette0Palette:
	INCLUDE "data/bank_039/FixedBgPalette0Palette.asm" ; $4528, 8 bytes (palettes)
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
