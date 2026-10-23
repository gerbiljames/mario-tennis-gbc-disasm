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
	ld c, 128 ; $40a6
	call QueueVRAMCopy ; $40a8
	ld hl, wDecompBufferHigh ; $40ab
	ld de, vTiles1 + VRAM_BANK1 ; $40ae
	ld c, wDecompBufferHigh_SIZE / 16 ; $40b1
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
	screen_asset Placeholder0, DataPtr_Unused_3a_FillerSlot_401c, DataPtr_Unused_3a_FillerSlot_401e, DataPtr_Unused_3a_FillerSlot_4020, DataPtr_Unused_3a_FillerSlot_4022 ; record 0
	screen_asset ExhibitionSetup, DataPtr_ExhibitionSetupTiles, DataPtr_ExhibitionSetupTilemap, DataPtr_ExhibitionSetupAttrmap, DataPtr_ExhibitionSetupPalettes ; record 1
	screen_asset Placeholder2, DataPtr_Unused_3d_FillerSlot_4012, DataPtr_Unused_3d_FillerSlot_4014, DataPtr_Unused_3d_FillerSlot_4016, DataPtr_Unused_3d_FillerSlot_4018 ; record 2
	screen_asset Placeholder3, DataPtr_Unused_3a_FillerSlot_401c, DataPtr_Unused_3a_FillerSlot_401e, DataPtr_Unused_3a_FillerSlot_4020, DataPtr_Unused_3a_FillerSlot_4022 ; record 3
	screen_asset JapanesePlayMode, DataPtr_JapanesePlayModeTiles, DataPtr_JapanesePlayModeTilemap, DataPtr_JapanesePlayModeAttrmap, DataPtr_JapanesePlayModePalettes ; record 4
	screen_asset CharacterSelect, DataPtr_CharacterSelectTiles, DataPtr_CharacterSelectTilemap, DataPtr_CharacterSelectAttrmap, DataPtr_CharacterSelectPalettes ; record 5
	screen_asset NameEntry, DataPtr_CharacterSelectTiles, DataPtr_NameEntryTilemap, DataPtr_NameEntryAttrmap, DataPtr_CharacterSelectPalettes ; record 6
	screen_asset CharSelectAlt, DataPtr_CharacterSelectTiles, DataPtr_CharSelectAltTilemap, DataPtr_CharSelectAltAttrmap, DataPtr_CharacterSelectPalettes ; record 7
	screen_asset Placeholder8, DataPtr_Unused_3a_FillerSlot_4004, DataPtr_Unused_3a_FillerSlot_4006, DataPtr_Unused_3a_FillerSlot_4008, DataPtr_Unused_3a_FillerSlot_400a ; record 8
	screen_asset QueueWram3MapToVRAMPtrs, FarPtr_QueueWram3MapToVRAMAlias1, FarPtr_QueueWram3MapToVRAMAlias2, FarPtr_QueueWram3MapToVRAMAlias3, FarPtr_QueueWram3MapToVRAMAlias4 ; record 9
	screen_asset Placeholder10, DataPtr_Unused_3a_FillerSlot_4004, DataPtr_Unused_3a_FillerSlot_400c, DataPtr_Unused_3a_FillerSlot_400e, DataPtr_Unused_3a_FillerSlot_400a ; record 10
	screen_asset Placeholder11, DataPtr_Unused_3a_FillerSlot_4004, DataPtr_Unused_3a_FillerSlot_4010, DataPtr_Unused_3a_FillerSlot_4012, DataPtr_Unused_3a_FillerSlot_400a ; record 11
	screen_asset ExhibitionRecords, DataPtr_ExhibitionRecordsTiles, DataPtr_ExhibitionRecordsTilemap, DataPtr_ExhibitionRecordsAttrmap, DataPtr_ExhibitionRecordsPalettes ; record 12
	screen_asset N64Tournament, DataPtr_N64TournamentTiles, DataPtr_N64TournamentTilemap, DataPtr_N64TournamentAttrmap, DataPtr_N64TournamentPalettes ; record 13
	screen_asset N64Tournament2, DataPtr_N64TournamentTiles, DataPtr_N64TournamentTilemap2, DataPtr_N64TournamentAttrmap2, DataPtr_N64TournamentPalettes ; record 14
	screen_asset N64TnmtData, DataPtr_N64TnmtDataTiles, DataPtr_N64TnmtDataTilemap, DataPtr_N64TnmtDataAttrmap, DataPtr_N64TnmtDataPalettes ; record 15
	screen_asset WarningScreen, DataPtr_WarningScreenTiles, DataPtr_WarningScreenTilemap, DataPtr_WarningScreenAttrmap, DataPtr_WarningScreenPalettes ; record 16
	screen_asset LinkingScreen, DataPtr_LinkingScreenTiles, DataPtr_LinkingScreenTilemap, DataPtr_LinkingScreenAttrmap, DataPtr_LinkingScreenPalettes ; record 17
	screen_asset N64RingShotPoints, DataPtr_N64RingShotPointsTiles, DataPtr_N64RingShotPointsTilemap, DataPtr_N64RingShotPointsAttrmap, DataPtr_N64RingShotPointsPalettes ; record 18
	screen_asset MatchWinLose, DataPtr_MatchResultTiles, DataPtr_MatchWinLoseTilemap, DataPtr_MatchWinLoseAttrmap, DataPtr_MatchResultPalettes ; record 19
	screen_asset MatchWinLoseVersus, DataPtr_MatchResultTiles, DataPtr_MatchWinLoseVersusTilemap, DataPtr_MatchWinLoseVersusAttrmap, DataPtr_MatchResultPalettes ; record 20
	screen_asset CompanyLogos, DataPtr_CompanyLogosTiles, DataPtr_CompanyLogosTilemap, DataPtr_CompanyLogosAttrmap, DataPtr_CompanyLogosPalettes ; record 21
	screen_asset IntroRallies, DataPtr_IntroRalliesTiles, DataPtr_IntroRalliesTilemap, DataPtr_IntroRalliesAttrmap, DataPtr_IntroRalliesPalettes ; record 22
	screen_asset IntroRallies2, DataPtr_IntroRalliesTiles, DataPtr_IntroRalliesTilemap2, DataPtr_IntroRalliesAttrmap2, DataPtr_IntroRalliesPalettes ; record 23
	screen_asset IntroRallies3, DataPtr_IntroRalliesTiles, DataPtr_IntroRalliesTilemap3, DataPtr_IntroRalliesAttrmap3, DataPtr_IntroRalliesPalettes ; record 24
	screen_asset IntroRallies4, DataPtr_IntroRalliesTiles, DataPtr_IntroRalliesTilemap4, DataPtr_IntroRalliesAttrmap4, DataPtr_IntroRalliesPalettes ; record 25
	screen_asset IntroAlexSwing, DataPtr_IntroAlexSwingTiles, DataPtr_IntroAlexSwingTilemap, DataPtr_IntroAlexSwingAttrmap, DataPtr_IntroAlexSwingPalettes ; record 26
	screen_asset IntroNinaSwing, DataPtr_IntroNinaSwingTiles, DataPtr_IntroNinaSwingTilemap, DataPtr_IntroNinaSwingAttrmap, DataPtr_IntroNinaSwingPalettes ; record 27
	screen_asset IntroWave, DataPtr_IntroWaveTiles, DataPtr_IntroWaveTilemap, DataPtr_IntroWaveAttrmap, DataPtr_IntroWavePalettes ; record 28
	screen_asset IntroDive, DataPtr_IntroDiveTiles, DataPtr_IntroDiveTilemap, DataPtr_IntroDiveAttrmap, DataPtr_IntroDivePalettes ; record 29
	screen_asset IntroGirlSwing, DataPtr_IntroGirlSwingTiles, DataPtr_IntroGirlSwingTilemap, DataPtr_IntroGirlSwingAttrmap, DataPtr_IntroGirlSwingPalettes ; record 30
	screen_asset TitleScreen, DataPtr_TitleScreenTiles, DataPtr_TitleScreenTilemap, DataPtr_TitleScreenAttrmap, DataPtr_TitleScreenPalettes ; record 31
	screen_asset LoadIntroAwesomeOpponentsCaptionPtrs, FarPtr_LoadIntroAwesomeOpponentsCaption, FarPtr_LoadIntroAwesomeOpponentsCaptionAlias1, FarPtr_LoadIntroAwesomeOpponentsCaptionAlias2, FarPtr_LoadIntroAwesomeOpponentsCaptionAlias3 ; record 32
	screen_asset EquipmentSelect, DataPtr_EquipmentSelectTiles, DataPtr_EquipmentSelectTilemap, DataPtr_EquipmentSelectAttrmap, DataPtr_EquipmentSelectPalettes ; record 33
	screen_asset LinkError, DataPtr_LinkErrorTiles, DataPtr_LinkErrorTilemap, DataPtr_LinkErrorAttrmap, DataPtr_LinkErrorPalettes ; record 34
	screen_asset MatchStats, DataPtr_MatchResultTiles, DataPtr_MatchStatsTilemap, DataPtr_MatchStatsAttrmap, DataPtr_MatchResultPalettes ; record 35
	screen_asset CourtDiagram, DataPtr_CourtDiagramTiles, DataPtr_CourtDiagramTilemap, DataPtr_CourtDiagramAttrmap, DataPtr_CourtDiagramPalettes ; record 36
	screen_asset VarsityTeamChart, DataPtr_VarsityTeamChartTiles, DataPtr_VarsityTeamChartTilemap, DataPtr_VarsityTeamChartAttrmap, DataPtr_VarsityTeamChartPalettes ; record 37
	screen_asset VarsityTeamChart2, DataPtr_VarsityTeamChartTiles, DataPtr_VarsityTeamChartTilemap2, DataPtr_VarsityTeamChartAttrmap2, DataPtr_VarsityTeamChartPalettes ; record 38
	screen_asset IntroGreatestPlayer, DataPtr_IntroGreatestPlayerTiles, DataPtr_IntroGreatestPlayerTilemap, DataPtr_IntroGreatestPlayerAttrmap, DataPtr_IntroGreatestPlayerPalettes ; record 39
	screen_asset Placeholder40, DataPtr_Unused_6d_FillerSlot_4028, DataPtr_Unused_6d_FillerSlot_402a, DataPtr_Unused_6d_FillerSlot_402c, DataPtr_Unused_6d_FillerSlot_402e ; record 40
	screen_asset TournamentBracketSingles, DataPtr_TournamentBracketTiles, DataPtr_TournamentBracketSinglesTilemap, DataPtr_TournamentBracketSinglesAttrmap, DataPtr_TournamentBracketPalettes ; record 41
	screen_asset TournamentBracketDoubles, DataPtr_TournamentBracketTiles, DataPtr_TournamentBracketDoublesTilemap, DataPtr_TournamentBracketDoublesAttrmap, DataPtr_TournamentBracketPalettes ; record 42
	screen_asset MarioMiniGames, DataPtr_MarioMiniGamesTiles, DataPtr_MarioMiniGamesTilemap, DataPtr_MarioMiniGamesAttrmap, DataPtr_MarioMiniGamesPalettes ; record 43
	screen_asset VictoryCutscene, DataPtr_VictoryCutsceneTiles, DataPtr_VictoryCutsceneTilemap, DataPtr_VictoryCutsceneAttrmap, DataPtr_VictoryCutscenePalettes ; record 44
	screen_asset VictoryCutscene2, DataPtr_VictoryCutsceneTiles, DataPtr_VictoryCutsceneTilemap2, DataPtr_VictoryCutsceneAttrmap2, DataPtr_VictoryCutscenePalettes ; record 45
	screen_asset VictoryCutscene3, DataPtr_VictoryCutsceneTiles, DataPtr_VictoryCutsceneTilemap3, DataPtr_VictoryCutsceneAttrmap3, DataPtr_VictoryCutscenePalettes ; record 46
	screen_asset VictoryCutscene4, DataPtr_VictoryCutsceneTiles, DataPtr_VictoryCutsceneTilemap4, DataPtr_VictoryCutsceneAttrmap4, DataPtr_VictoryCutscenePalettes ; record 47
	screen_asset VictoryCutscene5, DataPtr_VictoryCutsceneTiles, DataPtr_VictoryCutsceneTilemap5, DataPtr_VictoryCutsceneAttrmap5, DataPtr_VictoryCutscenePalettes ; record 48
	screen_asset VictoryCutscene6, DataPtr_VictoryCutsceneTiles, DataPtr_VictoryCutsceneTilemap6, DataPtr_VictoryCutsceneAttrmap6, DataPtr_VictoryCutscenePalettes ; record 49
	screen_asset AwardsCeremonyCutscene, DataPtr_AwardsCeremonyCutsceneTiles, DataPtr_AwardsCeremonyCutsceneTilemap, DataPtr_AwardsCeremonyCutsceneAttrmap, DataPtr_AwardsCeremonyCutscenePalettes ; record 50
	screen_asset AwardsCeremonyCutscene2, DataPtr_AwardsCeremonyCutsceneTiles, DataPtr_AwardsCeremonyCutsceneTilemap2, DataPtr_AwardsCeremonyCutsceneAttrmap2, DataPtr_AwardsCeremonyCutscenePalettes ; record 51
	screen_asset AwardsCeremonyCutscene3, DataPtr_AwardsCeremonyCutsceneTiles, DataPtr_AwardsCeremonyCutsceneTilemap3, DataPtr_AwardsCeremonyCutsceneAttrmap3, DataPtr_AwardsCeremonyCutscenePalettes ; record 52
	screen_asset AwardsCeremonyCutscene4, DataPtr_AwardsCeremonyCutsceneTiles, DataPtr_AwardsCeremonyCutsceneTilemap4, DataPtr_AwardsCeremonyCutsceneAttrmap4, DataPtr_AwardsCeremonyCutscenePalettes ; record 53
	screen_asset AwardsCeremonyCutscene5, DataPtr_AwardsCeremonyCutsceneTiles, DataPtr_AwardsCeremonyCutsceneTilemap5, DataPtr_AwardsCeremonyCutsceneAttrmap5, DataPtr_AwardsCeremonyCutscenePalettes ; record 54
	screen_asset AwardsCeremonyCutscene6, DataPtr_AwardsCeremonyCutsceneTiles, DataPtr_AwardsCeremonyCutsceneTilemap6, DataPtr_AwardsCeremonyCutsceneAttrmap6, DataPtr_AwardsCeremonyCutscenePalettes ; record 55
	screen_asset DreamMatchEpilogue, DataPtr_DreamMatchEpilogueTilesAlias4, DataPtr_DreamMatchEpilogueTilemap, DataPtr_DreamMatchEpilogueAttrmap, DataPtr_DreamMatchEpiloguePalettes ; record 56
	screen_asset DreamMatchEpilogue2, DataPtr_DreamMatchEpilogueTilesAlias4, DataPtr_DreamMatchEpilogueTilemap2, DataPtr_DreamMatchEpilogueAttrmap2, DataPtr_DreamMatchEpiloguePalettes ; record 57
	screen_asset DreamMatchEpilogue3, DataPtr_DreamMatchEpilogueTilesAlias4, DataPtr_DreamMatchEpilogueTilemap3, DataPtr_DreamMatchEpilogueAttrmap3, DataPtr_DreamMatchEpiloguePalettes ; record 58
	screen_asset DreamMatchEpilogue4, DataPtr_DreamMatchEpilogueTilesAlias4, DataPtr_DreamMatchEpilogueTilemap4, DataPtr_DreamMatchEpilogueAttrmap4, DataPtr_DreamMatchEpiloguePalettes ; record 59
	screen_asset DreamMatchEpilogue5, DataPtr_DreamMatchEpilogueTilesAlias4, DataPtr_DreamMatchEpilogueTilemap5, DataPtr_DreamMatchEpilogueAttrmap5, DataPtr_DreamMatchEpiloguePalettes ; record 60
	screen_asset DreamMatchEpilogue6, DataPtr_DreamMatchEpilogueTilesAlias4, DataPtr_DreamMatchEpilogueTilemap6, DataPtr_DreamMatchEpilogueAttrmap6, DataPtr_DreamMatchEpiloguePalettes ; record 61
	screen_asset ChampionMedal, DataPtr_ChampionMedalTiles, DataPtr_ChampionMedalTilemap, DataPtr_ChampionMedalAttrmap, DataPtr_ChampionMedalPalettes ; record 62
	screen_asset ChampionMedal2, DataPtr_ChampionMedalTiles, DataPtr_ChampionMedalTilemap2, DataPtr_ChampionMedalAttrmap2, DataPtr_ChampionMedalPalettes ; record 63
	screen_asset ChampionMedal3, DataPtr_ChampionMedalTiles, DataPtr_ChampionMedalTilemap3, DataPtr_ChampionMedalAttrmap3, DataPtr_ChampionMedalPalettes ; record 64
	screen_asset ChampionMedal4, DataPtr_ChampionMedalTiles, DataPtr_ChampionMedalTilemap4, DataPtr_ChampionMedalAttrmap4, DataPtr_ChampionMedalPalettes ; record 65
	screen_asset ChampionMedal5, DataPtr_ChampionMedalTiles, DataPtr_ChampionMedalTilemap5, DataPtr_ChampionMedalAttrmap5, DataPtr_ChampionMedalPalettes ; record 66
	screen_asset ChampionMedal6, DataPtr_ChampionMedalTiles, DataPtr_ChampionMedalTilemap6, DataPtr_ChampionMedalAttrmap6, DataPtr_ChampionMedalPalettes ; record 67
	screen_asset RulesScreen, DataPtr_RulesScreenTiles, DataPtr_RulesScreenTilemap, DataPtr_RulesScreenAttrmap, DataPtr_RulesScreenPalettes ; record 68
	screen_asset DreamMatchEpilogueTilesPtrs, DataPtr_DreamMatchEpilogueTiles, DataPtr_DreamMatchEpilogueTilesAlias1, DataPtr_DreamMatchEpilogueTilesAlias2, DataPtr_DreamMatchEpilogueTilesAlias3 ; record 69
QueueWram3MapToVRAM:
	wram_bank WRAM_SCREEN ; $4325
	ld hl, wShadowTilemap ; $432b
	ld de, vBGMap0 ; $432e
	ld c, TILEMAP_AREA / 16 ; $4331
	call QueueVRAMCopy ; $4333
	ld hl, wShadowAttrmap ; $4336
	ld de, vBGMap0 + VRAM_BANK1 ; $4339
	ld c, TILEMAP_AREA / 16 ; $433c
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
	ld hl, AnimatedTileFrameLists ; $437d
	add_hl_a ; $4380
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
	add_hl_a ; $4391
	ld a, [hl+] ; $4396
	ld h, [hl] ; $4397
	ld l, a ; $4398
	wram_bank WRAM_STAGING ; $4399
	ld de, wDecompBuffer ; $439f
	call DecompressDataFromBank ; $43a2
	ld hl, wDecompBuffer ; $43a5
	ld de, vTiles2 tile $2e + VRAM_BANK1 ; $43a8
	ld c, 2 ; $43ab
	call QueueVRAMCopy ; $43ad
	ld hl, wDecompBuffer tile 2 ; $43b0
	ld de, vTiles2 tile $3e + VRAM_BANK1 ; $43b3
	ld c, 2 ; $43b6
	call QueueVRAMCopy ; $43b8
.frameB:
	ld a, [wAnimatedTileSet] ; $43bb
	and $03 ; $43be
	add a ; $43c0
	ld hl, AnimatedTilesSecondStripFrameLists ; $43c1
	add_hl_a ; $43c4
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
	add_hl_a ; $43d5
	ld a, [hl+] ; $43da
	ld h, [hl] ; $43db
	ld l, a ; $43dc
	ld de, wDecompBuffer tile 16 ; $43dd
	call DecompressDataFromBank ; $43e0
	ld hl, wDecompBuffer tile 16 ; $43e3
	ld de, vTiles2 tile $4e + VRAM_BANK1 ; $43e6
	ld c, 2 ; $43e9
	call QueueVRAMCopy ; $43eb
	ld hl, wDecompBuffer tile 18 ; $43ee
	ld de, vTiles2 tile $5e + VRAM_BANK1 ; $43f1
	ld c, 2 ; $43f4
	call QueueVRAMCopy ; $43f6
.done:
	pop_wram_bank ; $43f9
	pop hl ; $43fe
	pop de ; $43ff
	pop bc ; $4400
	pop af ; $4401
	ret ; $4402
AnimatedTileFrameLists:
	; $4403, 8 bytes (records:2)
	dw TennisBallAnimFrames ; record 0
	dw StarAnimFrames ; record 1
	dw MushroomAnimFrames ; record 2
	dw InvertedStarAnimFrames ; record 3
AnimatedTilesSecondStripFrameLists:
	; $440b, 8 bytes (records:2)
	dw $ffff ; record 0
	dw $ffff ; record 1
	dw InvertedStarAnimFrames ; record 2
	dw MushroomAnimFrames ; record 3
; UpdateAnimatedTiles masks the frame with `and $0f`, so records 16-31 here and in
; StarAnimFrames are never read; they point at filler slots.
TennisBallAnimFrames:
	; $4413, 64 bytes (32 records x 1 slot words)
	dslot DataPtr_TennisBallAnimFrame00 ; record 0
	dslot DataPtr_TennisBallAnimFrame01 ; record 1
	dslot DataPtr_TennisBallAnimFrame02 ; record 2
	dslot DataPtr_TennisBallAnimFrame03 ; record 3
	dslot DataPtr_TennisBallAnimFrame04 ; record 4
	dslot DataPtr_TennisBallAnimFrame05 ; record 5
	dslot DataPtr_TennisBallAnimFrame06 ; record 6
	dslot DataPtr_TennisBallAnimFrame07 ; record 7
	dslot DataPtr_TennisBallAnimFrame08 ; record 8
	dslot DataPtr_TennisBallAnimFrame09 ; record 9
	dslot DataPtr_TennisBallAnimFrame10 ; record 10
	dslot DataPtr_TennisBallAnimFrame11 ; record 11
	dslot DataPtr_TennisBallAnimFrame12 ; record 12
	dslot DataPtr_TennisBallAnimFrame13 ; record 13
	dslot DataPtr_TennisBallAnimFrame14 ; record 14
	dslot DataPtr_TennisBallAnimFrame15 ; record 15
	dslot DataPtr_Unused_6d_FillerSlot_4052 ; record 16
	dslot DataPtr_Unused_6d_FillerSlot_4054 ; record 17
	dslot DataPtr_Unused_6d_FillerSlot_4056 ; record 18
	dslot DataPtr_Unused_6d_FillerSlot_4058 ; record 19
	dslot DataPtr_Unused_6d_FillerSlot_405a ; record 20
	dslot DataPtr_Unused_6d_FillerSlot_405c ; record 21
	dslot DataPtr_Unused_6d_FillerSlot_405e ; record 22
	dslot DataPtr_Unused_6d_FillerSlot_4060 ; record 23
	dslot DataPtr_Unused_6d_FillerSlot_4062 ; record 24
	dslot DataPtr_Unused_6d_FillerSlot_4064 ; record 25
	dslot DataPtr_Unused_6d_FillerSlot_4066 ; record 26
	dslot DataPtr_Unused_6d_FillerSlot_4068 ; record 27
	dslot DataPtr_Unused_6d_FillerSlot_406a ; record 28
	dslot DataPtr_Unused_6d_FillerSlot_406c ; record 29
	dslot DataPtr_Unused_6d_FillerSlot_406e ; record 30
	dslot DataPtr_Unused_6d_FillerSlot_4070 ; record 31
StarAnimFrames:
	; $4453, 64 bytes (32 records x 1 slot words)
	dslot DataPtr_StarAnimFrame00 ; record 0
	dslot DataPtr_StarAnimFrame01 ; record 1
	dslot DataPtr_StarAnimFrame02 ; record 2
	dslot DataPtr_StarAnimFrame03 ; record 3
	dslot DataPtr_StarAnimFrame04 ; record 4
	dslot DataPtr_StarAnimFrame05 ; record 5
	dslot DataPtr_StarAnimFrame06 ; record 6
	dslot DataPtr_StarAnimFrame07 ; record 7
	dslot DataPtr_StarAnimFrame08 ; record 8
	dslot DataPtr_StarAnimFrame09 ; record 9
	dslot DataPtr_StarAnimFrame10 ; record 10
	dslot DataPtr_StarAnimFrame11 ; record 11
	dslot DataPtr_StarAnimFrame12 ; record 12
	dslot DataPtr_StarAnimFrame13 ; record 13
	dslot DataPtr_StarAnimFrame14 ; record 14
	dslot DataPtr_StarAnimFrame15 ; record 15
	dslot DataPtr_Unused_3f_FillerSlot_4056 ; record 16
	dslot DataPtr_Unused_3f_FillerSlot_4058 ; record 17
	dslot DataPtr_Unused_3f_FillerSlot_405a ; record 18
	dslot DataPtr_Unused_3f_FillerSlot_405c ; record 19
	dslot DataPtr_Unused_3f_FillerSlot_405e ; record 20
	dslot DataPtr_Unused_3f_FillerSlot_4060 ; record 21
	dslot DataPtr_Unused_3f_FillerSlot_4062 ; record 22
	dslot DataPtr_Unused_3f_FillerSlot_4064 ; record 23
	dslot DataPtr_Unused_3f_FillerSlot_4066 ; record 24
	dslot DataPtr_Unused_3f_FillerSlot_4068 ; record 25
	dslot DataPtr_Unused_3f_FillerSlot_406a ; record 26
	dslot DataPtr_Unused_3f_FillerSlot_406c ; record 27
	dslot DataPtr_Unused_3f_FillerSlot_406e ; record 28
	dslot DataPtr_Unused_3f_FillerSlot_4070 ; record 29
	dslot DataPtr_Unused_3f_FillerSlot_4072 ; record 30
	dslot DataPtr_Unused_3f_FillerSlot_4074 ; record 31
MushroomAnimFrames:
	; $4493, 32 bytes (16 records x 1 slot words)
	dslot DataPtr_MushroomAnimFrame00 ; record 0
	dslot DataPtr_MushroomAnimFrame01 ; record 1
	dslot DataPtr_MushroomAnimFrame02 ; record 2
	dslot DataPtr_MushroomAnimFrame03 ; record 3
	dslot DataPtr_MushroomAnimFrame04 ; record 4
	dslot DataPtr_MushroomAnimFrame05 ; record 5
	dslot DataPtr_MushroomAnimFrame06 ; record 6
	dslot DataPtr_MushroomAnimFrame07 ; record 7
	dslot DataPtr_MushroomAnimFrame08 ; record 8
	dslot DataPtr_MushroomAnimFrame09 ; record 9
	dslot DataPtr_MushroomAnimFrame10 ; record 10
	dslot DataPtr_MushroomAnimFrame11 ; record 11
	dslot DataPtr_MushroomAnimFrame12 ; record 12
	dslot DataPtr_MushroomAnimFrame13 ; record 13
	dslot DataPtr_MushroomAnimFrame14 ; record 14
	dslot DataPtr_MushroomAnimFrame15 ; record 15
InvertedStarAnimFrames:
	; $44b3, 32 bytes (16 records x 1 slot words)
	dslot DataPtr_InvertedStarAnimFrame00 ; record 0
	dslot DataPtr_InvertedStarAnimFrame01 ; record 1
	dslot DataPtr_InvertedStarAnimFrame02 ; record 2
	dslot DataPtr_InvertedStarAnimFrame03 ; record 3
	dslot DataPtr_InvertedStarAnimFrame04 ; record 4
	dslot DataPtr_InvertedStarAnimFrame05 ; record 5
	dslot DataPtr_InvertedStarAnimFrame06 ; record 6
	dslot DataPtr_InvertedStarAnimFrame07 ; record 7
	dslot DataPtr_InvertedStarAnimFrame08 ; record 8
	dslot DataPtr_InvertedStarAnimFrame09 ; record 9
	dslot DataPtr_InvertedStarAnimFrame10 ; record 10
	dslot DataPtr_InvertedStarAnimFrame11 ; record 11
	dslot DataPtr_InvertedStarAnimFrame12 ; record 12
	dslot DataPtr_InvertedStarAnimFrame13 ; record 13
	dslot DataPtr_InvertedStarAnimFrame14 ; record 14
	dslot DataPtr_InvertedStarAnimFrame15 ; record 15
LoadCornerBracketCursorGfx:
	push de ; $44d3
	wram_bank WRAM_STAGING ; $44d4
	ld hl, CornerBracketCursorGfx ; $44da
	ld de, wDecompBuffer ; $44dd
	call DecompressData ; $44e0
	ld hl, wDecompBuffer ; $44e3
	pop de ; $44e6
	ld c, CornerBracketCursorGfx_SIZE / 16 ; $44e7
	call QueueVRAMCopy ; $44e9
	ld hl, CornerBracketCursorPalette ; $44ec
	ld_obj_pals de, 0, 1 ; $44ef
	call LoadPaletteShadow ; $44f2
	ret ; $44f5
CornerBracketCursorGfx:
	INCBIN "data/engine/menus/common/lz_CornerBracketCursorGfx.bin" ; $44f6, 32 bytes
	INCLUDE "data/engine/menus/common/lz_CornerBracketCursorGfx.inc" ; DEF CornerBracketCursorGfx_SIZE EQU its decoded length, generated from the .bin by make
CornerBracketCursorPalette:
	INCLUDE "data/engine/menus/common/CornerBracketCursorPalette.asm" ; $4516, 8 bytes (palettes)
Unused_39_LoadFixedBgPalette0:
	ld_bg_pals de, 0, 1 ; $451e
	ld hl, FixedBgPalette0Palette ; $4521
	call LoadPaletteShadow ; $4524
	ret ; $4527
FixedBgPalette0Palette:
	INCLUDE "data/engine/menus/common/FixedBgPalette0Palette.asm" ; $4528, 8 bytes (palettes)
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
