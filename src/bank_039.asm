SECTION "ROM Bank $39", ROMX[$4000], BANK[$39]

FarPtr_LoadScreenAssetRecord:
	dw LoadScreenAssetRecord ; $4000
FarPtr_QueueWram3MapToVRAM:
	dw QueueWram3MapToVRAM ; $4002
FarPtr_39_04:
	dw Func_39_4342 ; $4004
FarPtr_39_06:
	dw Func_39_44d3 ; $4006
FarPtr_39_08:
	dw Func_39_451e ; $4008
FarPtr_CopyTilemapRect:
	dw CopyTilemapRect ; $400a
FarPtr_FillTilemapRect:
	dw FillTilemapRect ; $400c
FarPtr_LoadIndexedPalette:
	dw LoadIndexedPalette ; $400e
FarPtr_LoadCompressedTileBlock:
	dw LoadCompressedTileBlock ; $4010
FarPtr_39_12:
	dw Func_39_4661 ; $4012
FarPtr_39_14:
	dw Func_39_4a75 ; $4014
FarPtr_ApplySpriteBobOffset:
	dw ApplySpriteBobOffset ; $4016
FarPtr_39_18:
	dw Func_39_4a16 ; $4018
FarPtr_39_1a:
	dw Func_39_4a53 ; $401a
FarPtr_39_1c:
	dw Func_39_4c38 ; $401c
FarPtr_FlushWram3MapRows:
	dw FlushWram3MapRows ; $401e
FarPtr_RestoreMenuBgAndDrawPanel:
	dw RestoreMenuBgAndDrawPanel ; $4020
FarPtr_ResetScreenAndTextWindows:
	dw ResetScreenAndTextWindows ; $4022
FarPtr_InitMenuBgScroll:
	dw InitMenuBgScroll ; $4024
FarPtr_39_26:
	dw Func_39_4b3a ; $4026
FarPtr_TickMenuBgScroll:
	dw TickMenuBgScroll ; $4028
FarPtr_39_2a:
	dw Func_39_4be8 ; $402a
FarPtr_QueueWram3MapToVRAMAlias1:
	dw QueueWram3MapToVRAM ; $402c
FarPtr_QueueWram3MapToVRAMAlias2:
	dw QueueWram3MapToVRAM ; $402e
FarPtr_QueueWram3MapToVRAMAlias3:
	dw QueueWram3MapToVRAM ; $4030
FarPtr_QueueWram3MapToVRAMAlias4:
	dw QueueWram3MapToVRAM ; $4032
DataPtr_Lz_39_47ab:
	dw Lz_39_47ab ; $4034
DataPtr_Lz_39_47abAlias1:
	dw Lz_39_47ab ; $4036
DataPtr_Lz_39_47abAlias2:
	dw Lz_39_47ab ; $4038
DataPtr_Lz_39_47abAlias3:
	dw Lz_39_47ab ; $403a
DataPtr_Lz_39_47abAlias4:
	dw Lz_39_47ab ; $403c
DataPtr_Lz_39_47abAlias5:
	dw Lz_39_47ab ; $403e
DataPtr_Lz_39_47abAlias6:
	dw Lz_39_47ab ; $4040
DataPtr_Lz_39_47abAlias7:
	dw Lz_39_47ab ; $4042
DataPtr_Lz_39_47abAlias8:
	dw Lz_39_47ab ; $4044
DataPtr_Lz_39_47abAlias9:
	dw Lz_39_47ab ; $4046
DataPtr_Lz_39_47abAlias10:
	dw Lz_39_47ab ; $4048
DataPtr_Lz_39_47abAlias11:
	dw Lz_39_47ab ; $404a
DataPtr_Lz_39_47abAlias12:
	dw Lz_39_47ab ; $404c
DataPtr_Lz_39_47abAlias13:
	dw Lz_39_47ab ; $404e
DataPtr_Lz_39_47abAlias14:
	dw Lz_39_47ab ; $4050
DataPtr_Lz_39_47abAlias15:
	dw Lz_39_47ab ; $4052
DataPtr_Lz_39_47abAlias16:
	dw Lz_39_47ab ; $4054
DataPtr_Lz_39_47abAlias17:
	dw Lz_39_47ab ; $4056
DataPtr_39_58:
	dw Lz_39_47fa ; $4058
DataPtr_39_5a:
	dw Lz_39_4809 ; $405a
DataPtr_39_5c:
	dw Lz_39_4833 ; $405c
DataPtr_StatLabelTiles:
	dw StatLabelTiles ; $405e
FarPtr_39_60:
	dw Func_39_6dc2 ; $4060
FarPtr_39_62:
	dw Func_39_6df9 ; $4062
FarPtr_39_64:
	dw Func_39_6ec0 ; $4064
FarPtr_DrawDecimalNumberSprites_39:
	dw DrawDecimalNumberSprites_39 ; $4066
FarPtr_39_68:
	dw Func_39_6fe7 ; $4068
FarPtr_39_6a:
	dw Func_39_6f67 ; $406a
DataPtr_39_6c:
	dw Lz_39_7009 ; $406c
DataPtr_39_6e:
	dw Lz_39_70bb ; $406e
DataPtr_39_70:
	dw Lz_39_717d ; $4070
DataPtr_39_72:
	dw Lz_39_71b6 ; $4072
DataPtr_39_74:
	dw Lz_39_71e8 ; $4074
DataPtr_39_76:
	dw Lz_39_7223 ; $4076
DataPtr_39_78:
	dw Lz_39_725d ; $4078
DataPtr_DigitFontTiles:
	dw DigitFontTiles ; $407a
FarPtr_39_7c:
	dw Func_39_745a ; $407c
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
	ld de, $d000 ; $40c3
	call DecompressDataFromBank ; $40c6
	pop hl ; $40c9
	inc hl ; $40ca
	inc hl ; $40cb
	push hl ; $40cc
	ld a, [hl+] ; $40cd
	ld h, [hl] ; $40ce
	ld l, a ; $40cf
	ld de, $d400 ; $40d0
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
	dslot DataPtr_Lz_3a_53fbAlias9, DataPtr_Lz_3a_53fbAlias10, DataPtr_Lz_3a_53fbAlias11, DataPtr_Lz_3a_53fbAlias12 ; record 0
	dslot DataPtr_ExhibitionSetupTiles, DataPtr_ExhibitionSetupTilemap, DataPtr_ExhibitionSetupAttrmap, DataPtr_ExhibitionSetupPalettes ; record 1
	dslot DataPtr_Lz_3d_4830, DataPtr_Lz_3d_4830Alias1, DataPtr_Lz_3d_4830Alias2, DataPtr_Lz_3d_4830Alias3 ; record 2
	dslot DataPtr_Lz_3a_53fbAlias9, DataPtr_Lz_3a_53fbAlias10, DataPtr_Lz_3a_53fbAlias11, DataPtr_Lz_3a_53fbAlias12 ; record 3
	dslot DataPtr_JapanesePlayModeTiles, DataPtr_JapanesePlayModeTilemap, DataPtr_JapanesePlayModeAttrmap, DataPtr_JapanesePlayModePalettes ; record 4
	dslot DataPtr_3c_70, DataPtr_3c_72, DataPtr_3c_74, DataPtr_3c_76 ; record 5
	dslot DataPtr_3c_70, DataPtr_Lz_3a_53fbAlias8, DataPtr_3a_16, DataPtr_3c_76 ; record 6
	dslot DataPtr_3c_70, DataPtr_3a_18, DataPtr_3a_1a, DataPtr_3c_76 ; record 7
	dslot DataPtr_Lz_3a_53fb, DataPtr_Lz_3a_53fbAlias1, DataPtr_Lz_3a_53fbAlias2, DataPtr_Lz_3a_53fbAlias3 ; record 8
	dslot FarPtr_QueueWram3MapToVRAMAlias1, FarPtr_QueueWram3MapToVRAMAlias2, FarPtr_QueueWram3MapToVRAMAlias3, FarPtr_QueueWram3MapToVRAMAlias4 ; record 9
	dslot DataPtr_Lz_3a_53fb, DataPtr_Lz_3a_53fbAlias4, DataPtr_Lz_3a_53fbAlias5, DataPtr_Lz_3a_53fbAlias3 ; record 10
	dslot DataPtr_Lz_3a_53fb, DataPtr_Lz_3a_53fbAlias6, DataPtr_Lz_3a_53fbAlias7, DataPtr_Lz_3a_53fbAlias3 ; record 11
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
	dslot FarPtr_Func_6b_73f2, FarPtr_Func_6b_73f2Alias1, FarPtr_Func_6b_73f2Alias2, FarPtr_Func_6b_73f2Alias3 ; record 32
	dslot DataPtr_EquipmentSelectTiles, DataPtr_EquipmentSelectTilemap, DataPtr_EquipmentSelectAttrmap, DataPtr_EquipmentSelectPalettes ; record 33
	dslot DataPtr_LinkErrorTiles, DataPtr_LinkErrorTilemap, DataPtr_LinkErrorAttrmap, DataPtr_LinkErrorPalettes ; record 34
	dslot DataPtr_MatchStatsTiles, DataPtr_MatchStatsTilemap3, DataPtr_MatchStatsAttrmap3, DataPtr_MatchStatsPalettes ; record 35
	dslot DataPtr_CourtDiagramTiles, DataPtr_CourtDiagramTilemap, DataPtr_CourtDiagramAttrmap, DataPtr_CourtDiagramPalettes ; record 36
	dslot DataPtr_VarsityTeamChartTiles, DataPtr_VarsityTeamChartTilemap, DataPtr_VarsityTeamChartAttrmap, DataPtr_VarsityTeamChartPalettes ; record 37
	dslot DataPtr_VarsityTeamChartTiles, DataPtr_VarsityTeamChartTilemap2, DataPtr_VarsityTeamChartAttrmap2, DataPtr_VarsityTeamChartPalettes ; record 38
	dslot DataPtr_IntroGreatestPlayerTiles, DataPtr_IntroGreatestPlayerTilemap, DataPtr_IntroGreatestPlayerAttrmap, DataPtr_IntroGreatestPlayerPalettes ; record 39
	dslot DataPtr_Lz_6d_6ac8, DataPtr_Lz_6d_6ac8Alias1, DataPtr_Lz_6d_6ac8Alias2, DataPtr_Lz_6d_6ac8Alias3 ; record 40
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
	ld hl, $d000 ; $432b
	ld de, $9800 ; $432e
	ld c, $40 ; $4331
	call QueueVRAMCopy ; $4333
	ld hl, $d400 ; $4336
	ld de, $b800 ; $4339
	ld c, $40 ; $433c
	call QueueVRAMCopy ; $433e
	ret ; $4341
Func_39_4342:
	push af ; $4342
	push bc ; $4343
	push de ; $4344
	push hl ; $4345
	ldh a, [hWramBank] ; $4346
	push af ; $4348
	ld a, [$cb0a] ; $4349
	inc a ; $434c
	ld c, a ; $434d
	ld a, [$cb0c] ; $434e
	ld b, a ; $4351
	ld a, c ; $4352
	add a, a ; $4353
	jr nc, Label_39_435a ; $4354
	ld a, b ; $4356
	dec a ; $4357
	jr Label_39_435f ; $4358
Label_39_435a:
	rra ; $435a
	cp a, b ; $435b
	jr c, Label_39_435f ; $435c
	xor a, a ; $435e
Label_39_435f:
	ld [$cb0a], a ; $435f
	or a, a ; $4362
	jp nz, Label_39_43f9 ; $4363
	wram_bank $02 ; $4366
	ld a, [$cb09] ; $436c
	inc a ; $436f
	ld [$cb09], a ; $4370
	and a, $0f ; $4373
	rlca ; $4375
	push af ; $4376
	ld a, [$cb0b] ; $4377
	and a, $03 ; $437a
	add a, a ; $437c
	ld hl, $4403 ; $437d
	add a, l ; $4380
	ld l, a ; $4381
	jr nc, Label_39_4385 ; $4382
	inc h ; $4384
Label_39_4385:
	ld a, [hl+] ; $4385
	ld h, [hl] ; $4386
	ld l, a ; $4387
	ld a, h ; $4388
	ld b, l ; $4389
	and a, b ; $438a
	cp a, $ff ; $438b
	jr z, Label_39_43bb ; $438d
	pop af ; $438f
	push af ; $4390
	add a, l ; $4391
	ld l, a ; $4392
	jr nc, Label_39_4396 ; $4393
	inc h ; $4395
Label_39_4396:
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
Label_39_43bb:
	ld a, [$cb0b] ; $43bb
	and a, $03 ; $43be
	add a, a ; $43c0
	ld hl, $440b ; $43c1
	add a, l ; $43c4
	ld l, a ; $43c5
	jr nc, Label_39_43c9 ; $43c6
	inc h ; $43c8
Label_39_43c9:
	ld a, [hl+] ; $43c9
	ld h, [hl] ; $43ca
	ld l, a ; $43cb
	pop af ; $43cc
	ld c, a ; $43cd
	ld a, h ; $43ce
	and a, l ; $43cf
	cp a, $ff ; $43d0
	jr z, Label_39_43f9 ; $43d2
	ld a, c ; $43d4
	add a, l ; $43d5
	ld l, a ; $43d6
	jr nc, Label_39_43da ; $43d7
	inc h ; $43d9
Label_39_43da:
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
Label_39_43f9:
	pop af ; $43f9
	wram_bank ; $43fa
	pop hl ; $43fe
	pop de ; $43ff
	pop bc ; $4400
	pop af ; $4401
	ret ; $4402
	; $4403, 208 bytes (records:2)
	dw $4413 ; record 0
	dw $4453 ; record 1
	dw $4493 ; record 2
	dw $44b3 ; record 3
	dw $ffff ; record 4
	dw $ffff ; record 5
	dw $44b3 ; record 6
	dw $4493 ; record 7
	dw $6d32 ; record 8
	dw $6d34 ; record 9
	dw $6d36 ; record 10
	dw $6d38 ; record 11
	dw $6d3a ; record 12
	dw $6d3c ; record 13
	dw $6d3e ; record 14
	dw $6d40 ; record 15
	dw $6d42 ; record 16
	dw $6d44 ; record 17
	dw $6d46 ; record 18
	dw $6d48 ; record 19
	dw $6d4a ; record 20
	dw $6d4c ; record 21
	dw $6d4e ; record 22
	dw $6d50 ; record 23
	dw $6d52 ; record 24
	dw $6d54 ; record 25
	dw $6d56 ; record 26
	dw $6d58 ; record 27
	dw $6d5a ; record 28
	dw $6d5c ; record 29
	dw $6d5e ; record 30
	dw $6d60 ; record 31
	dw $6d62 ; record 32
	dw $6d64 ; record 33
	dw $6d66 ; record 34
	dw $6d68 ; record 35
	dw $6d6a ; record 36
	dw $6d6c ; record 37
	dw $6d6e ; record 38
	dw $6d70 ; record 39
	dw $3f36 ; record 40
	dw $3f38 ; record 41
	dw $3f3a ; record 42
	dw $3f3c ; record 43
	dw $3f3e ; record 44
	dw $3f40 ; record 45
	dw $3f42 ; record 46
	dw $3f44 ; record 47
	dw $3f46 ; record 48
	dw $3f48 ; record 49
	dw $3f4a ; record 50
	dw $3f4c ; record 51
	dw $3f4e ; record 52
	dw $3f50 ; record 53
	dw $3f52 ; record 54
	dw $3f54 ; record 55
	dw $3f56 ; record 56
	dw $3f58 ; record 57
	dw $3f5a ; record 58
	dw $3f5c ; record 59
	dw $3f5e ; record 60
	dw $3f60 ; record 61
	dw $3f62 ; record 62
	dw $3f64 ; record 63
	dw $3f66 ; record 64
	dw $3f68 ; record 65
	dw $3f6a ; record 66
	dw $3f6c ; record 67
	dw $3f6e ; record 68
	dw $3f70 ; record 69
	dw $3f72 ; record 70
	dw $3f74 ; record 71
	dw $1848 ; record 72
	dw $184a ; record 73
	dw $184c ; record 74
	dw $184e ; record 75
	dw $1850 ; record 76
	dw $1852 ; record 77
	dw $1854 ; record 78
	dw $1856 ; record 79
	dw $1858 ; record 80
	dw $185a ; record 81
	dw $185c ; record 82
	dw $185e ; record 83
	dw $1860 ; record 84
	dw $1862 ; record 85
	dw $1864 ; record 86
	dw $1866 ; record 87
	dw $1868 ; record 88
	dw $186a ; record 89
	dw $186c ; record 90
	dw $186e ; record 91
	dw $1870 ; record 92
	dw $1872 ; record 93
	dw $1874 ; record 94
	dw $1876 ; record 95
	dw $1878 ; record 96
	dw $187a ; record 97
	dw $187c ; record 98
	dw $187e ; record 99
	dw $1880 ; record 100
	dw $1882 ; record 101
	dw $1884 ; record 102
	dw $1886 ; record 103
Func_39_44d3:
	push de ; $44d3
	wram_bank $01 ; $44d4
	ld hl, $44f6 ; $44da
	ld de, $d000 ; $44dd
	call DecompressData ; $44e0
	ld hl, $d000 ; $44e3
	pop de ; $44e6
	ld c, $04 ; $44e7
	call QueueVRAMCopy ; $44e9
	ld hl, $4516 ; $44ec
	ld de, $0801 ; $44ef
	call LoadPaletteShadow ; $44f2
	ret ; $44f5
	INCBIN "data/bank_039/d_44f6.bin" ; $44f6, 40 bytes
Func_39_451e:
	ld de, $0001 ; $451e
	ld hl, $4528 ; $4521
	call LoadPaletteShadow ; $4524
	ret ; $4527
	INCBIN "data/bank_039/d_4528.bin" ; $4528, 8 bytes
CopyTilemapRect:
	push af ; $4530
	push bc ; $4531
	push de ; $4532
	push hl ; $4533
Label_39_4534:
	push bc ; $4534
	push hl ; $4535
	push de ; $4536
Label_39_4537:
	ld a, [hl+] ; $4537
	push hl ; $4538
	ld h, d ; $4539
	ld l, e ; $453a
	ld [hl+], a ; $453b
	ld d, h ; $453c
	ld e, l ; $453d
	pop hl ; $453e
	dec b ; $453f
	jr nz, Label_39_4537 ; $4540
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
	jr nz, Label_39_4534 ; $4551
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
Label_39_455c:
	push bc ; $455c
	push hl ; $455d
	push de ; $455e
Label_39_455f:
	ld a, h ; $455f
	push hl ; $4560
	ld h, d ; $4561
	ld l, e ; $4562
	ld [hl+], a ; $4563
	ld d, h ; $4564
	ld e, l ; $4565
	pop hl ; $4566
	dec b ; $4567
	jr nz, Label_39_455f ; $4568
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
	jr nz, Label_39_455c ; $4578
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
	ld hl, $4599 ; $458e
	add hl, de ; $4591
	ld d, b ; $4592
	ld e, $01 ; $4593
	call LoadPaletteShadow ; $4595
	ret ; $4598
	; $4599, 200 bytes (palettes)
; GBC palettes (BGR555), 4 colors each
	dw $0000, $294a, $5294, $7fff ; pal 0: #000000 #525252 #a4a4a4 #ffffff
	dw $0000, $00c8, $00f2, $7fff ; pal 1: #000000 #413100 #943900 #ffffff
	dw $0000, $2940, $5280, $7fff ; pal 2: #000000 #005252 #00a4a4 #ffffff
	dw $0000, $05c0, $16a6, $77bf ; pal 3: #000000 #007308 #31ac29 #ffeeee
	dw $0100, $7fff, $011f, $1018 ; pal 4: #004100 #ffffff #ff4100 #c50020
	dw $0000, $016f, $02ff, $7fff ; pal 5: #000000 #7b5a00 #ffbd00 #ffffff
	dw $0000, $01e7, $07ce, $7fff ; pal 6: #000000 #397b00 #73f608 #ffffff
	dw $0000, $3563, $6aa6, $7fff ; pal 7: #000000 #185a6a #31acd5 #ffffff
	dw $0000, $00f0, $01df, $7fff ; pal 8: #000000 #833900 #ff7300 #ffffff
	dw $0000, $1c16, $349f, $7fff ; pal 9: #000000 #b40039 #ff206a #ffffff
	dw $0000, $4160, $7ec0, $7fff ; pal 10: #000000 #005a83 #00b4ff #ffffff
	dw $7bde, $6318, $4a52, $318c ; pal 11: #f6f6f6 #c5c5c5 #949494 #626262
	dw $5ad6, $0880, $0000, $7fff ; pal 12: #b4b4b4 #002010 #000000 #ffffff
	dw $2bff, $0ef7, $03ff, $0000 ; pal 13: #ffff52 #bdbd18 #ffff00 #000000
	dw $2bff, $0108, $0210, $0000 ; pal 14: #ffff52 #414100 #838300 #000000
	dw $5ad6, $9e40, $0000, $7fff ; pal 15: #b4b4b4 #009439 #000000 #ffffff
	dw $3def, $00df, $0000, $7fff ; pal 16: #7b7b7b #ff3100 #000000 #ffffff
	dw $0000, $0000, $0000, $0000 ; pal 17: #000000 #000000 #000000 #000000
	dw $0000, $0000, $0000, $0000 ; pal 18: #000000 #000000 #000000 #000000
	dw $0000, $0000, $0000, $0000 ; pal 19: #000000 #000000 #000000 #000000
	dw $0000, $0000, $0000, $0000 ; pal 20: #000000 #000000 #000000 #000000
	dw $0000, $0000, $0000, $0000 ; pal 21: #000000 #000000 #000000 #000000
	dw $0000, $0000, $0000, $0000 ; pal 22: #000000 #000000 #000000 #000000
	dw $0000, $0000, $0000, $0000 ; pal 23: #000000 #000000 #000000 #000000
	dw $6280, $0000, $001f, $02df ; pal 24: #00a4c5 #000000 #ff0000 #ffb400
Func_39_4661:
	ld hl, $466b ; $4661
	ld de, $0904 ; $4664
	call LoadPaletteShadow ; $4667
	ret ; $466a
	; $466b, 32 bytes (palettes)
; GBC palettes (BGR555), 4 colors each
	dw $0100, $7fff, $011f, $1018 ; pal 0: #004100 #ffffff #ff4100 #c50020
	dw $0100, $7fff, $011f, $7d40 ; pal 1: #004100 #ffffff #ff4100 #0052ff
	dw $0100, $7fff, $011f, $0200 ; pal 2: #004100 #ffffff #ff4100 #008300
	dw $0100, $7fff, $011f, $4010 ; pal 3: #004100 #ffffff #ff4100 #830083
LoadCompressedTileBlock:
	ldh a, [hWramBank] ; $468b
	push af ; $468d
	ld a, b ; $468e
	add a, a ; $468f
	ld hl, TileBlockPtrs_39 ; $4690
	add a, l ; $4693
	ld l, a ; $4694
	jr nc, Label_39_4698 ; $4695
	inc h ; $4697
Label_39_4698:
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
	dslot DataPtr_1b_2e ; record 0
	dslot DataPtr_1b_30 ; record 1
	dslot DataPtr_1b_32 ; record 2
	dslot DataPtr_1b_34 ; record 3
	dslot DataPtr_1b_36 ; record 4
	dslot DataPtr_1b_38 ; record 5
	dslot DataPtr_1b_3a ; record 6
	dslot DataPtr_1b_3c ; record 7
	dslot DataPtr_1b_3e ; record 8
	dslot DataPtr_18_92 ; record 9
	dslot DataPtr_18_94 ; record 10
	dslot DataPtr_Lz_39_47abAlias11 ; record 11
	dslot DataPtr_Lz_39_47abAlias12 ; record 12
	dslot DataPtr_Lz_39_47abAlias13 ; record 13
	dslot DataPtr_Lz_39_47abAlias14 ; record 14
	dslot DataPtr_Lz_39_47abAlias15 ; record 15
	dslot DataPtr_Lz_39_47abAlias16 ; record 16
	dslot DataPtr_Lz_39_47abAlias17 ; record 17
	dslot DataPtr_39_58 ; record 18
	dslot DataPtr_39_5a ; record 19
	dslot DataPtr_39_5c ; record 20
	dslot DataPtr_StatLabelTiles ; record 21
	dslot DataPtr_MugshotTiles ; record 22
	dslot DataPtr_39_70 ; record 23
	dslot DataPtr_39_72 ; record 24
	dslot DataPtr_39_74 ; record 25
	dslot DataPtr_39_76 ; record 26
	dslot DataPtr_3c_22 ; record 27
	dslot DataPtr_3c_24 ; record 28
	dslot DataPtr_3c_26 ; record 29
	dslot DataPtr_3c_28 ; record 30
	dslot DataPtr_3c_2a ; record 31
	dslot DataPtr_3c_2c ; record 32
	dslot DataPtr_3c_2e ; record 33
	dslot DataPtr_3c_30 ; record 34
	dslot DataPtr_3c_32 ; record 35
	dslot DataPtr_3c_34 ; record 36
	dslot DataPtr_3c_36 ; record 37
	dslot DataPtr_3c_38 ; record 38
	dslot DataPtr_3c_3a ; record 39
	dslot DataPtr_3c_3c ; record 40
	dslot DataPtr_3c_3e ; record 41
	dslot DataPtr_3c_40 ; record 42
	dslot DataPtr_3c_42 ; record 43
	dslot DataPtr_3c_44 ; record 44
	dslot DataPtr_3c_46 ; record 45
	dslot DataPtr_3c_48 ; record 46
	dslot DataPtr_3c_4a ; record 47
	dslot DataPtr_3c_4c ; record 48
	dslot DataPtr_3c_4e ; record 49
	dslot DataPtr_3c_50 ; record 50
	dslot DataPtr_3c_52 ; record 51
	dslot DataPtr_3c_54 ; record 52
	dslot DataPtr_3c_56 ; record 53
	dslot DataPtr_3c_58 ; record 54
	dslot DataPtr_3c_5a ; record 55
	dslot DataPtr_3c_5c ; record 56
	dslot DataPtr_3c_5e ; record 57
	dslot DataPtr_3c_60 ; record 58
	dslot DataPtr_3d_08 ; record 59
	dslot DataPtr_3d_0a ; record 60
	dslot DataPtr_3d_0c ; record 61
	dslot DataPtr_Lz_3d_4830Alias4 ; record 62
	dslot DataPtr_3d_1c ; record 63
	dslot DataPtr_3d_1e ; record 64
	dslot DataPtr_3d_20 ; record 65
	dslot DataPtr_3d_22 ; record 66
	dslot DataPtr_3d_24 ; record 67
	dslot DataPtr_3d_26 ; record 68
	dslot DataPtr_3d_28 ; record 69
	dslot DataPtr_3d_2a ; record 70
	dslot DataPtr_3d_2c ; record 71
	dslot DataPtr_3d_2e ; record 72
	dslot DataPtr_3d_42 ; record 73
	dslot DataPtr_39_6c ; record 74
	dslot DataPtr_39_6e ; record 75
	dslot DataPtr_3d_58 ; record 76
	dslot DataPtr_6c_1c ; record 77
	dslot DataPtr_6c_1e ; record 78
	dslot DataPtr_6c_20 ; record 79
	dslot DataPtr_6c_22 ; record 80
	dslot DataPtr_6c_24 ; record 81
	dslot DataPtr_6c_26 ; record 82
	dslot DataPtr_6c_28 ; record 83
	dslot DataPtr_6c_52 ; record 84
	dslot DataPtr_6c_54 ; record 85
	dslot DataPtr_6c_56 ; record 86
	dslot DataPtr_6c_58 ; record 87
	dslot DataPtr_6c_5a ; record 88
	dslot DataPtr_6c_5c ; record 89
	dslot DataPtr_6c_5e ; record 90
	dslot DataPtr_6d_00 ; record 91
	dslot DataPtr_6d_02 ; record 92
	dslot DataPtr_6d_04 ; record 93
	dslot DataPtr_6d_06 ; record 94
	dslot DataPtr_6d_08 ; record 95
	dslot DataPtr_6d_0a ; record 96
	dslot DataPtr_6d_0c ; record 97
	dslot DataPtr_6d_0e ; record 98
	dslot DataPtr_3d_62 ; record 99
	dslot DataPtr_3d_30 ; record 100
	dslot DataPtr_3f_16 ; record 101
	dslot DataPtr_3f_18 ; record 102
	dslot DataPtr_3f_1a ; record 103
	dslot DataPtr_3f_1c ; record 104
	dslot DataPtr_3f_2a ; record 105
	dslot DataPtr_Lz_6d_6f2eAlias16 ; record 106
	dslot DataPtr_6d_74 ; record 107
	dslot DataPtr_6d_76 ; record 108
	dslot DataPtr_6d_78 ; record 109
	dslot DataPtr_6d_7a ; record 110
	dslot DataPtr_6d_7c ; record 111
	dslot DataPtr_6d_84 ; record 112
	dslot DataPtr_6d_86 ; record 113
	dslot DataPtr_6d_88 ; record 114
	dslot DataPtr_3e_42 ; record 115
	dslot DataPtr_3e_44 ; record 116
	dslot DataPtr_39_78 ; record 117
	dslot DataPtr_3e_46 ; record 118
	dslot DataPtr_Lz_3f_7af7Alias16 ; record 119
	dslot DataPtr_3f_78 ; record 120
	dslot DataPtr_DigitFontTiles ; record 121
Lz_39_47ab:
	INCBIN "data/bank_039/lz_47ab.bin" ; $47ab, 79 bytes
Lz_39_47fa:
	INCBIN "data/bank_039/lz_47fa.bin" ; $47fa, 15 bytes
Lz_39_4809:
	INCBIN "data/bank_039/lz_4809.bin" ; $4809, 42 bytes
Lz_39_4833:
	INCBIN "data/bank_039/lz_4833.bin" ; $4833, 240 bytes
StatLabelTiles:
	INCBIN "data/bank_039/lz_4923.bin" ; $4923, 243 bytes
Func_39_4a16:
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
Func_39_4a53:
	push af ; $4a53
	push bc ; $4a54
	push de ; $4a55
	push hl ; $4a56
	ld a, h ; $4a57
	add a, a ; $4a58
	add a, a ; $4a59
	add a, c ; $4a5a
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
	add a, d ; $4a69
	ld d, a ; $4a6a
	inc c ; $4a6b
	inc c ; $4a6c
	call QueueSprite ; $4a6d
	pop hl ; $4a70
	pop de ; $4a71
	pop bc ; $4a72
	pop af ; $4a73
	ret ; $4a74
Func_39_4a75:
	ldh a, [hVBlankCounter] ; $4a75
	and a, $3f ; $4a77
	add a, $84 ; $4a79
	ld l, a ; $4a7b
	adc a, $4a ; $4a7c
	sub a, l ; $4a7e
	ld h, a ; $4a7f
	ld a, [hl] ; $4a80
	add a, e ; $4a81
	ld e, a ; $4a82
	ret ; $4a83
	INCBIN "data/bank_039/d_4a84.bin" ; $4a84, 64 bytes
ApplySpriteBobOffset:
	ldh a, [hVBlankCounter] ; $4ac4
	and a, $3f ; $4ac6
	add a, $d3 ; $4ac8
	ld l, a ; $4aca
	adc a, $4a ; $4acb
	sub a, l ; $4acd
	ld h, a ; $4ace
	ld a, [hl] ; $4acf
	add a, e ; $4ad0
	ld e, a ; $4ad1
	ret ; $4ad2
	INCBIN "data/bank_039/d_4ad3.bin" ; $4ad3, 64 bytes
InitMenuBgScroll:
	ld a, $01 ; $4b13
	ld [$cb17], a ; $4b15
	ld a, $01 ; $4b18
	ld [$cb18], a ; $4b1a
	xor a, a ; $4b1d
	ld [$cb14], a ; $4b1e
	ld a, $40 ; $4b21
	ld [$cb12], a ; $4b23
	add a, $86 ; $4b26
	ld [$cb13], a ; $4b28
	ld a, $00 ; $4b2b
	ld [$cb15], a ; $4b2d
	ld a, $00 ; $4b30
	ld [$cb16], a ; $4b32
	xor a, a ; $4b35
	ld [$cb19], a ; $4b36
	ret ; $4b39
Func_39_4b3a:
	push bc ; $4b3a
	ld a, c ; $4b3b
	add a, $08 ; $4b3c
	ld d, a ; $4b3e
	ld e, $01 ; $4b3f
	ld hl, $4b65 ; $4b41
	call LoadPaletteShadow ; $4b44
	pop bc ; $4b47
	ld a, b ; $4b48
	add a, $08 ; $4b49
	ld d, a ; $4b4b
	ld e, $01 ; $4b4c
	ld hl, $4b65 ; $4b4e
	call LoadPaletteShadow ; $4b51
	ret ; $4b54
	; $4b55, 24 bytes (records:2)
	dw $0004 ; record 0
	dw $00af ; record 1
	dw $015f ; record 2
	dw $031f ; record 3
	dw $1088 ; record 4
	dw $1133 ; record 5
	dw $11df ; record 6
	dw $139f ; record 7
	dw $0000 ; record 8
	dw $018f ; record 9
	dw $031f ; record 10
	dw $031f ; record 11
TickMenuBgScroll:
	ld a, [$cb12] ; $4b6d
	dec a ; $4b70
	cp a, $b0 ; $4b71
	jr nz, Label_39_4b77 ; $4b73
	ld a, $a0 ; $4b75
Label_39_4b77:
	ld [$cb12], a ; $4b77
	ld a, [$cb13] ; $4b7a
	dec a ; $4b7d
	cp a, $b0 ; $4b7e
	jr nz, Label_39_4b84 ; $4b80
	ld a, $a0 ; $4b82
Label_39_4b84:
	ld [$cb13], a ; $4b84
	ld a, [$cb19] ; $4b87
	or a, a ; $4b8a
	jr nz, Label_39_4ba4 ; $4b8b
	ld a, [$cb12] ; $4b8d
	ld d, a ; $4b90
	ld a, [$cb15] ; $4b91
	ld c, a ; $4b94
	ld a, [$cb17] ; $4b95
	ld b, a ; $4b98
	ld a, [$cb14] ; $4b99
	ld e, a ; $4b9c
	ld a, $01 ; $4b9d
	ld [$cb19], a ; $4b9f
	jr Label_39_4bb8 ; $4ba2
Label_39_4ba4:
	ld a, [$cb13] ; $4ba4
	ld d, a ; $4ba7
	ld a, [$cb16] ; $4ba8
	ld c, a ; $4bab
	ld a, [$cb18] ; $4bac
	ld b, a ; $4baf
	ld a, [$cb14] ; $4bb0
	ld e, a ; $4bb3
	xor a, a ; $4bb4
	ld [$cb19], a ; $4bb5
Label_39_4bb8:
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
Func_39_4be8:
	ld b, $11 ; $4be8
	ld c, $10 ; $4bea
	ld de, $9000 ; $4bec
	farcall FarPtr_LoadCompressedTileBlock ; $4bef
	ret ; $4bf2
ResetScreenAndTextWindows:
	ldh [hScrollX], a ; $4bf3
	ldh [hScrollY], a ; $4bf5
	ld [wCameraX], a ; $4bf7
	ld [$c321], a ; $4bfa
	ld [wCameraY], a ; $4bfd
	ld [$c323], a ; $4c00
	farcall FarPtr_39_1c ; $4c03
	farcall FarPtr_ResetTextWindowState ; $4c06
	ld b, $11 ; $4c09
	ld c, $10 ; $4c0b
	ld de, $9000 ; $4c0d
	farcall FarPtr_LoadCompressedTileBlock ; $4c10
	wram_bank $05 ; $4c13
	ld a, $03 ; $4c19
	ld [wShadowTilemapBank], a ; $4c1b
	ld a, $00 ; $4c1e
	ld [wWindowTileAttr], a ; $4c20
	ld d, $00 ; $4c23
	ld e, $0f ; $4c25
	ld b, $14 ; $4c27
	ld c, $03 ; $4c29
	farcall FarPtr_CreateWindowFromScreenRect ; $4c2b
	farcall FarPtr_DrawTextWindowFrame ; $4c2e
	farcall FarPtr_RedrawWindowRows ; $4c31
	farcall FarPtr_QueueWram3MapToVRAM ; $4c34
	ret ; $4c37
Func_39_4c38:
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
	ld de, $d000 ; $4c69
	call DecompressDataFromBank ; $4c6c
	ld hl, $3c0a ; $4c6f -> DataPtr_StadiumTilemap
	ld de, $d800 ; $4c72
	call DecompressDataFromBank ; $4c75
	ld hl, $3c0c ; $4c78 -> DataPtr_3c_0c
	ld de, $d400 ; $4c7b
	call DecompressDataFromBank ; $4c7e
	ld hl, $3c0c ; $4c81 -> DataPtr_3c_0c
	ld de, $dc00 ; $4c84
	call DecompressDataFromBank ; $4c87
	wram_bank $01 ; $4c8a
	ld hl, $3c0e ; $4c90 -> DataPtr_3c_0e
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
	or a, a ; $4cb9
	jr nz, Label_39_4d1a ; $4cba
	ld c, $04 ; $4cbc
	ld hl, $d000 ; $4cbe
	ld de, $9800 ; $4cc1
	call QueueVRAMCopy ; $4cc4
	ld c, $04 ; $4cc7
	ld hl, $d400 ; $4cc9
	ld de, $b800 ; $4ccc
	call QueueVRAMCopy ; $4ccf
	ld c, $06 ; $4cd2
	ld hl, $d060 ; $4cd4
	ld de, $9860 ; $4cd7
	call QueueVRAMCopy ; $4cda
	ld c, $06 ; $4cdd
	ld hl, $d460 ; $4cdf
	ld de, $b860 ; $4ce2
	call QueueVRAMCopy ; $4ce5
	call AdvanceFrame ; $4ce8
	ld c, $06 ; $4ceb
	ld hl, $d0e0 ; $4ced
	ld de, $98e0 ; $4cf0
	call QueueVRAMCopy ; $4cf3
	ld c, $06 ; $4cf6
	ld hl, $d4e0 ; $4cf8
	ld de, $b8e0 ; $4cfb
	call QueueVRAMCopy ; $4cfe
	ld c, $06 ; $4d01
	ld hl, $d160 ; $4d03
	ld de, $9960 ; $4d06
	call QueueVRAMCopy ; $4d09
	ld c, $06 ; $4d0c
	ld hl, $d560 ; $4d0e
	ld de, $b960 ; $4d11
	call QueueVRAMCopy ; $4d14
	jp Label_39_4de1 ; $4d17
Label_39_4d1a:
	cp a, $01 ; $4d1a
	jr nz, Label_39_4d65 ; $4d1c
	ld c, $04 ; $4d1e
	ld hl, $d000 ; $4d20
	ld de, $9800 ; $4d23
	call QueueVRAMCopy ; $4d26
	ld c, $04 ; $4d29
	ld hl, $d400 ; $4d2b
	ld de, $b800 ; $4d2e
	call QueueVRAMCopy ; $4d31
	ld c, $06 ; $4d34
	ld hl, $d080 ; $4d36
	ld de, $9880 ; $4d39
	call QueueVRAMCopy ; $4d3c
	ld c, $06 ; $4d3f
	ld hl, $d480 ; $4d41
	ld de, $b880 ; $4d44
	call QueueVRAMCopy ; $4d47
	call AdvanceFrame ; $4d4a
	ld c, $06 ; $4d4d
	ld hl, $d140 ; $4d4f
	ld de, $9940 ; $4d52
	call QueueVRAMCopy ; $4d55
	ld c, $06 ; $4d58
	ld hl, $d540 ; $4d5a
	ld de, $b940 ; $4d5d
	call QueueVRAMCopy ; $4d60
	jr Label_39_4de1 ; $4d63
Label_39_4d65:
	cp a, $02 ; $4d65
	jr nz, Label_39_4db0 ; $4d67
	ld c, $04 ; $4d69
	ld hl, $d000 ; $4d6b
	ld de, $9800 ; $4d6e
	call QueueVRAMCopy ; $4d71
	ld c, $04 ; $4d74
	ld hl, $d400 ; $4d76
	ld de, $b800 ; $4d79
	call QueueVRAMCopy ; $4d7c
	ld c, $06 ; $4d7f
	ld hl, $d080 ; $4d81
	ld de, $9880 ; $4d84
	call QueueVRAMCopy ; $4d87
	ld c, $06 ; $4d8a
	ld hl, $d480 ; $4d8c
	ld de, $b880 ; $4d8f
	call QueueVRAMCopy ; $4d92
	call AdvanceFrame ; $4d95
	ld c, $06 ; $4d98
	ld hl, $d120 ; $4d9a
	ld de, $9920 ; $4d9d
	call QueueVRAMCopy ; $4da0
	ld c, $06 ; $4da3
	ld hl, $d520 ; $4da5
	ld de, $b920 ; $4da8
	call QueueVRAMCopy ; $4dab
	jr Label_39_4de1 ; $4dae
Label_39_4db0:
	ld c, $04 ; $4db0
	ld hl, $d000 ; $4db2
	ld de, $9800 ; $4db5
	call QueueVRAMCopy ; $4db8
	ld c, $04 ; $4dbb
	ld hl, $d400 ; $4dbd
	ld de, $b800 ; $4dc0
	call QueueVRAMCopy ; $4dc3
	call AdvanceFrame ; $4dc6
	ld c, $06 ; $4dc9
	ld hl, $d0e0 ; $4dcb
	ld de, $98e0 ; $4dce
	call QueueVRAMCopy ; $4dd1
	ld c, $06 ; $4dd4
	ld hl, $d4e0 ; $4dd6
	ld de, $b8e0 ; $4dd9
	call QueueVRAMCopy ; $4ddc
	jr Label_39_4de1 ; $4ddf
Label_39_4de1:
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
	ld hl, $d800 ; $4df3
	ld de, $d000 ; $4df6
	ld b, $14 ; $4df9
	ld c, $10 ; $4dfb
	call CopyTilemapRect ; $4dfd
	ld hl, $dc00 ; $4e00
	ld de, $d400 ; $4e03
	ld b, $14 ; $4e06
	ld c, $10 ; $4e08
	call CopyTilemapRect ; $4e0a
	pop hl ; $4e0d
	pop de ; $4e0e
	pop bc ; $4e0f
	pop af ; $4e10
	ld a, b ; $4e11
	add a, a ; $4e12
	ld hl, $4e60 ; $4e13
	add a, l ; $4e16
	ld l, a ; $4e17
	jr nc, Label_39_4e1b ; $4e18
	inc h ; $4e1a
Label_39_4e1b:
	ld a, [hl+] ; $4e1b
	ld h, [hl] ; $4e1c
	ld l, a ; $4e1d
	ld a, c ; $4e1e
	add a, a ; $4e1f
	add a, l ; $4e20
	ld l, a ; $4e21
	jr nc, Label_39_4e25 ; $4e22
	inc h ; $4e24
Label_39_4e25:
	ld a, [hl+] ; $4e25
	ld h, [hl] ; $4e26
	ld l, a ; $4e27
Label_39_4e28:
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
	or a, a ; $4e33
	jr z, Label_39_4e59 ; $4e34
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
	add a, l ; $4e52
	ld l, a ; $4e53
	jr nc, Label_39_4e57 ; $4e54
	inc h ; $4e56
Label_39_4e57:
	jr Label_39_4e28 ; $4e57
Label_39_4e59:
	pop hl ; $4e59
	pop hl ; $4e5a
	pop hl ; $4e5b
	pop de ; $4e5c
	pop bc ; $4e5d
	pop af ; $4e5e
	ret ; $4e5f
	; $4e60, 636 bytes (records:2)
	dw $4e90 ; record 0
	dw $4eb0 ; record 1
	dw $4ec4 ; record 2
	dw $4ee4 ; record 3
	dw $4efc ; record 4
	dw $4f1c ; record 5
	dw $4f38 ; record 6
	dw $4f54 ; record 7
	dw $4f6a ; record 8
	dw $4f8a ; record 9
	dw $4fa4 ; record 10
	dw $4fbe ; record 11
	dw $4fd4 ; record 12
	dw $4fd4 ; record 13
	dw $4fd4 ; record 14
	dw $4fd4 ; record 15
	dw $4fd4 ; record 16
	dw $4ff6 ; record 17
	dw $5012 ; record 18
	dw $5034 ; record 19
	dw $5050 ; record 20
	dw $5072 ; record 21
	dw $508e ; record 22
	dw $50b0 ; record 23
	dw $50dc ; record 24
	dw $50dc ; record 25
	dw $50dc ; record 26
	dw $50e2 ; record 27
	dw $50f4 ; record 28
	dw $510c ; record 29
	dw $512a ; record 30
	dw $5154 ; record 31
	dw $5184 ; record 32
	dw $51c0 ; record 33
	dw $5202 ; record 34
	dw $5244 ; record 35
	dw $5286 ; record 36
	dw $52c8 ; record 37
	dw $530a ; record 38
	dw $534c ; record 39
	dw $534c ; record 40
	dw $538e ; record 41
	dw $53d0 ; record 42
	dw $5412 ; record 43
	dw $5454 ; record 44
	dw $5490 ; record 45
	dw $54cc ; record 46
	dw $54fc ; record 47
	dw $5520 ; record 48
	dw $553e ; record 49
	dw $50dc ; record 50
	dw $50dc ; record 51
	dw $50dc ; record 52
	dw $554a ; record 53
	dw $555c ; record 54
	dw $557a ; record 55
	dw $5598 ; record 56
	dw $55c2 ; record 57
	dw $55ec ; record 58
	dw $561c ; record 59
	dw $5652 ; record 60
	dw $5688 ; record 61
	dw $56be ; record 62
	dw $56f4 ; record 63
	dw $572a ; record 64
	dw $572a ; record 65
	dw $572a ; record 66
	dw $5760 ; record 67
	dw $5796 ; record 68
	dw $57cc ; record 69
	dw $5802 ; record 70
	dw $5838 ; record 71
	dw $586e ; record 72
	dw $589e ; record 73
	dw $58c2 ; record 74
	dw $58e0 ; record 75
	dw $50dc ; record 76
	dw $50dc ; record 77
	dw $50dc ; record 78
	dw $50dc ; record 79
	dw $50dc ; record 80
	dw $58f2 ; record 81
	dw $5904 ; record 82
	dw $591c ; record 83
	dw $5940 ; record 84
	dw $5970 ; record 85
	dw $59a6 ; record 86
	dw $59e8 ; record 87
	dw $5a2a ; record 88
	dw $5a6c ; record 89
	dw $5aae ; record 90
	dw $5af0 ; record 91
	dw $5b32 ; record 92
	dw $5b32 ; record 93
	dw $5af0 ; record 94
	dw $5b32 ; record 95
	dw $5b74 ; record 96
	dw $5bb6 ; record 97
	dw $5bf8 ; record 98
	dw $5c34 ; record 99
	dw $5c70 ; record 100
	dw $5c9a ; record 101
	dw $5cb8 ; record 102
	dw $5cd0 ; record 103
	dw $5cdc ; record 104
	dw $50dc ; record 105
	dw $50dc ; record 106
	dw $50dc ; record 107
	dw $50dc ; record 108
	dw $50dc ; record 109
	dw $50dc ; record 110
	dw $5ce2 ; record 111
	dw $5cf4 ; record 112
	dw $5d0c ; record 113
	dw $5d24 ; record 114
	dw $5d42 ; record 115
	dw $5d66 ; record 116
	dw $5d8a ; record 117
	dw $5dae ; record 118
	dw $5dd2 ; record 119
	dw $5df6 ; record 120
	dw $5df6 ; record 121
	dw $5df6 ; record 122
	dw $5e1a ; record 123
	dw $5e3e ; record 124
	dw $5e62 ; record 125
	dw $5e86 ; record 126
	dw $5ea4 ; record 127
	dw $5ebc ; record 128
	dw $5ece ; record 129
	dw $5ee0 ; record 130
	dw $50dc ; record 131
	dw $50dc ; record 132
	dw $50dc ; record 133
	dw $50dc ; record 134
	dw $50dc ; record 135
	dw $5eec ; record 136
	dw $5efe ; record 137
	dw $5f10 ; record 138
	dw $5f28 ; record 139
	dw $5f40 ; record 140
	dw $5f58 ; record 141
	dw $5f7c ; record 142
	dw $5fa0 ; record 143
	dw $5fca ; record 144
	dw $5ff4 ; record 145
	dw $601e ; record 146
	dw $6048 ; record 147
	dw $6072 ; record 148
	dw $6048 ; record 149
	dw $6072 ; record 150
	dw $609c ; record 151
	dw $60c6 ; record 152
	dw $60ea ; record 153
	dw $610e ; record 154
	dw $6126 ; record 155
	dw $613e ; record 156
	dw $6150 ; record 157
	dw $615c ; record 158
	dw $50dc ; record 159
	dw $50dc ; record 160
	dw $50dc ; record 161
	dw $50dc ; record 162
	dw $50dc ; record 163
	dw $50dc ; record 164
	dw $6168 ; record 165
	dw $617a ; record 166
	dw $618c ; record 167
	dw $61a4 ; record 168
	dw $61bc ; record 169
	dw $61d4 ; record 170
	dw $61f2 ; record 171
	dw $6210 ; record 172
	dw $622e ; record 173
	dw $624c ; record 174
	dw $626a ; record 175
	dw $6288 ; record 176
	dw $62a6 ; record 177
	dw $62c4 ; record 178
	dw $62e2 ; record 179
	dw $6300 ; record 180
	dw $6312 ; record 181
	dw $6324 ; record 182
	dw $6330 ; record 183
	dw $633c ; record 184
	dw $6348 ; record 185
	dw $50dc ; record 186
	dw $50dc ; record 187
	dw $50dc ; record 188
	dw $6354 ; record 189
	dw $6366 ; record 190
	dw $6378 ; record 191
	dw $638a ; record 192
	dw $63a2 ; record 193
	dw $63ba ; record 194
	dw $63d2 ; record 195
	dw $63ea ; record 196
	dw $6402 ; record 197
	dw $641a ; record 198
	dw $641a ; record 199
	dw $641a ; record 200
	dw $641a ; record 201
	dw $641a ; record 202
	dw $641a ; record 203
	dw $6432 ; record 204
	dw $644a ; record 205
	dw $6462 ; record 206
	dw $6474 ; record 207
	dw $6486 ; record 208
	dw $6498 ; record 209
	dw $64a4 ; record 210
	dw $64b0 ; record 211
	dw $64bc ; record 212
	dw $64c2 ; record 213
	dw $64c2 ; record 214
	dw $64c2 ; record 215
	dw $64c2 ; record 216
	dw $50dc ; record 217
	dw $50dc ; record 218
	dw $50dc ; record 219
	dw $64c2 ; record 220
	dw $64d4 ; record 221
	dw $64e6 ; record 222
	dw $6504 ; record 223
	dw $6522 ; record 224
	dw $6546 ; record 225
	dw $656a ; record 226
	dw $658e ; record 227
	dw $65b2 ; record 228
	dw $65d6 ; record 229
	dw $65fa ; record 230
	dw $6600 ; record 231
	dw $6606 ; record 232
	dw $660c ; record 233
	dw $6612 ; record 234
	dw $6636 ; record 235
	dw $665a ; record 236
	dw $667e ; record 237
	dw $66a2 ; record 238
	dw $66c0 ; record 239
	dw $66de ; record 240
	dw $66f6 ; record 241
	dw $6702 ; record 242
	dw $670e ; record 243
	dw $6714 ; record 244
	dw $671a ; record 245
	dw $6720 ; record 246
	dw $6726 ; record 247
	dw $50dc ; record 248
	dw $50dc ; record 249
	dw $50dc ; record 250
	dw $672c ; record 251
	dw $673e ; record 252
	dw $6756 ; record 253
	dw $677a ; record 254
	dw $67a4 ; record 255
	dw $67da ; record 256
	dw $6816 ; record 257
	dw $6858 ; record 258
	dw $689a ; record 259
	dw $68dc ; record 260
	dw $691e ; record 261
	dw $6960 ; record 262
	dw $69a2 ; record 263
	dw $69a2 ; record 264
	dw $69a2 ; record 265
	dw $69e4 ; record 266
	dw $6a26 ; record 267
	dw $6a68 ; record 268
	dw $6aaa ; record 269
	dw $6ae0 ; record 270
	dw $6b0a ; record 271
	dw $6b22 ; record 272
	dw $6b2e ; record 273
	dw $6b3a ; record 274
	dw $6b46 ; record 275
	dw $6b4c ; record 276
	dw $6b4c ; record 277
	dw $6b4c ; record 278
	dw $50dc ; record 279
	dw $50dc ; record 280
	dw $50dc ; record 281
	dw $6b4c ; record 282
	dw $6b5e ; record 283
	dw $6b70 ; record 284
	dw $6b88 ; record 285
	dw $6ba6 ; record 286
	dw $6bca ; record 287
	dw $6bf4 ; record 288
	dw $6c1e ; record 289
	dw $6c48 ; record 290
	dw $6c72 ; record 291
	dw $6c9c ; record 292
	dw $6cc6 ; record 293
	dw $6cc6 ; record 294
	dw $6cc6 ; record 295
	dw $6c9c ; record 296
	dw $6cc6 ; record 297
	dw $6cf0 ; record 298
	dw $6d1a ; record 299
	dw $6d44 ; record 300
	dw $6d6e ; record 301
	dw $6d8c ; record 302
	dw $6da4 ; record 303
	dw $6db6 ; record 304
	dw $50dc ; record 305
	dw $50dc ; record 306
	dw $50dc ; record 307
	dw $50dc ; record 308
	dw $50dc ; record 309
	dw $50dc ; record 310
	dw $50dc ; record 311
	dw Func_39_6dc2 ; record 312
	dw Func_39_6dc2 ; record 313
	dw Func_39_6dc2 ; record 314
	dw Func_39_6dc2 ; record 315
	dw Func_39_6dc2 ; record 316
	dw Func_39_6dc2 ; record 317
	; $50dc, 7398 bytes (bytes:6)
	db $00, $00, $00, $00, $00, $00 ; 0x00
	db $80, $db, $00, $d0, $14, $01 ; 0x06
	db $a0, $da, $70, $d0, $05, $03 ; 0x0c
	db $00, $00, $00, $00, $00, $00 ; 0x12
	db $60, $db, $00, $d0, $14, $02 ; 0x18
	db $a0, $da, $6d, $d0, $05, $03 ; 0x1e
	db $40, $da, $f4, $d0, $03, $03 ; 0x24
	db $00, $00, $00, $00, $00, $00 ; 0x2a
	db $60, $db, $00, $d0, $14, $02 ; 0x30
	db $a0, $da, $6a, $d0, $05, $03 ; 0x36
	db $a5, $da, $70, $d0, $05, $03 ; 0x3c
	db $a0, $da, $70, $d0, $03, $03 ; 0x42
	db $00, $00, $00, $00, $00, $00 ; 0x48
	db $60, $db, $00, $d0, $14, $02 ; 0x4e
	db $a0, $da, $67, $d0, $05, $03 ; 0x54
	db $a5, $da, $6d, $d0, $05, $03 ; 0x5a
	db $40, $da, $ee, $d0, $03, $03 ; 0x60
	db $43, $da, $f4, $d0, $03, $03 ; 0x66
	db $af, $da, $73, $d1, $05, $03 ; 0x6c
	db $00, $00, $00, $00, $00, $00 ; 0x72
	db $60, $db, $00, $d0, $14, $02 ; 0x78
	db $a0, $da, $64, $d0, $05, $03 ; 0x7e
	db $a5, $da, $6a, $d0, $05, $03 ; 0x84
	db $aa, $da, $70, $d0, $05, $03 ; 0x8a
	db $40, $da, $eb, $d0, $03, $03 ; 0x90
	db $43, $da, $f1, $d0, $03, $03 ; 0x96
	db $af, $da, $70, $d1, $05, $03 ; 0x9c
	db $00, $00, $00, $00, $00, $00 ; 0xa2
	db $60, $db, $00, $d0, $14, $02 ; 0xa8
	db $a0, $da, $62, $d0, $05, $03 ; 0xae
	db $a5, $da, $68, $d0, $05, $03 ; 0xb4
	db $aa, $da, $6e, $d0, $05, $03 ; 0xba
	db $40, $da, $e8, $d0, $03, $03 ; 0xc0
	db $43, $da, $ee, $d0, $03, $03 ; 0xc6
	db $46, $da, $f4, $d0, $03, $03 ; 0xcc
	db $af, $da, $6d, $d1, $05, $03 ; 0xd2
	db $b4, $da, $73, $d1, $05, $03 ; 0xd8
	db $00, $00, $00, $00, $00, $00 ; 0xde
	db $60, $db, $00, $d0, $14, $02 ; 0xe4
	db $a0, $da, $61, $d0, $05, $03 ; 0xea
	db $a5, $da, $67, $d0, $05, $03 ; 0xf0
	db $aa, $da, $6d, $d0, $05, $03 ; 0xf6
	db $40, $da, $e5, $d0, $03, $03 ; 0xfc
	db $43, $da, $eb, $d0, $03, $03 ; 0x102
	db $46, $da, $f1, $d0, $03, $03 ; 0x108
	db $af, $da, $6a, $d1, $05, $03 ; 0x10e
	db $b4, $da, $70, $d1, $05, $03 ; 0x114
	db $b9, $da, $76, $d1, $05, $03 ; 0x11a
	db $00, $00, $00, $00, $00, $00 ; 0x120
	db $60, $db, $00, $d0, $14, $02 ; 0x126
	db $a0, $da, $61, $d0, $05, $03 ; 0x12c
	db $a5, $da, $67, $d0, $05, $03 ; 0x132
	db $aa, $da, $6d, $d0, $05, $03 ; 0x138
	db $40, $da, $e3, $d0, $03, $03 ; 0x13e
	db $43, $da, $e9, $d0, $03, $03 ; 0x144
	db $46, $da, $ef, $d0, $03, $03 ; 0x14a
	db $af, $da, $67, $d1, $05, $03 ; 0x150
	db $b4, $da, $6d, $d1, $05, $03 ; 0x156
	db $b9, $da, $73, $d1, $05, $03 ; 0x15c
	db $00, $00, $00, $00, $00, $00 ; 0x162
	db $60, $db, $00, $d0, $14, $02 ; 0x168
	db $a0, $da, $61, $d0, $05, $03 ; 0x16e
	db $a5, $da, $67, $d0, $05, $03 ; 0x174
	db $aa, $da, $6d, $d0, $05, $03 ; 0x17a
	db $40, $da, $e2, $d0, $03, $03 ; 0x180
	db $43, $da, $e8, $d0, $03, $03 ; 0x186
	db $46, $da, $ee, $d0, $03, $03 ; 0x18c
	db $af, $da, $64, $d1, $05, $03 ; 0x192
	db $b4, $da, $6a, $d1, $05, $03 ; 0x198
	db $b9, $da, $70, $d1, $05, $03 ; 0x19e
	db $00, $00, $00, $00, $00, $00 ; 0x1a4
	db $60, $db, $00, $d0, $14, $02 ; 0x1aa
	db $a0, $da, $61, $d0, $05, $03 ; 0x1b0
	db $a5, $da, $67, $d0, $05, $03 ; 0x1b6
	db $aa, $da, $6d, $d0, $05, $03 ; 0x1bc
	db $40, $da, $e2, $d0, $03, $03 ; 0x1c2
	db $43, $da, $e8, $d0, $03, $03 ; 0x1c8
	db $46, $da, $ee, $d0, $03, $03 ; 0x1ce
	db $af, $da, $62, $d1, $05, $03 ; 0x1d4
	db $b4, $da, $68, $d1, $05, $03 ; 0x1da
	db $b9, $da, $6e, $d1, $05, $03 ; 0x1e0
	db $00, $00, $00, $00, $00, $00 ; 0x1e6
	db $60, $db, $00, $d0, $14, $02 ; 0x1ec
	db $a0, $da, $61, $d0, $05, $03 ; 0x1f2
	db $a5, $da, $67, $d0, $05, $03 ; 0x1f8
	db $aa, $da, $6d, $d0, $05, $03 ; 0x1fe
	db $40, $da, $e2, $d0, $03, $03 ; 0x204
	db $43, $da, $e8, $d0, $03, $03 ; 0x20a
	db $46, $da, $ee, $d0, $03, $03 ; 0x210
	db $af, $da, $61, $d1, $05, $03 ; 0x216
	db $b4, $da, $67, $d1, $05, $03 ; 0x21c
	db $b9, $da, $6d, $d1, $05, $03 ; 0x222
	db $00, $00, $00, $00, $00, $00 ; 0x228
	db $60, $db, $00, $d0, $14, $02 ; 0x22e
	db $a0, $da, $61, $d0, $05, $03 ; 0x234
	db $a5, $da, $67, $d0, $05, $03 ; 0x23a
	db $aa, $da, $6d, $d0, $05, $03 ; 0x240
	db $40, $da, $e2, $d0, $03, $03 ; 0x246
	db $43, $da, $e8, $d0, $03, $03 ; 0x24c
	db $46, $da, $ee, $d0, $03, $03 ; 0x252
	db $af, $da, $61, $d1, $05, $03 ; 0x258
	db $b4, $da, $67, $d1, $05, $03 ; 0x25e
	db $b9, $da, $6d, $d1, $05, $03 ; 0x264
	db $00, $00, $00, $00, $00, $00 ; 0x26a
	db $60, $db, $00, $d0, $14, $02 ; 0x270
	db $a0, $da, $61, $d0, $05, $03 ; 0x276
	db $a5, $da, $67, $d0, $05, $03 ; 0x27c
	db $aa, $da, $6d, $d0, $05, $03 ; 0x282
	db $40, $da, $e2, $d0, $03, $03 ; 0x288
	db $43, $da, $e8, $d0, $03, $03 ; 0x28e
	db $46, $da, $ee, $d0, $03, $03 ; 0x294
	db $af, $da, $61, $d1, $05, $03 ; 0x29a
	db $b4, $da, $67, $d1, $05, $03 ; 0x2a0
	db $b9, $da, $6d, $d1, $05, $03 ; 0x2a6
	db $00, $00, $00, $00, $00, $00 ; 0x2ac
	db $60, $db, $00, $d0, $14, $02 ; 0x2b2
	db $a0, $da, $60, $d0, $05, $03 ; 0x2b8
	db $a5, $da, $66, $d0, $05, $03 ; 0x2be
	db $aa, $da, $6c, $d0, $05, $03 ; 0x2c4
	db $40, $da, $e2, $d0, $03, $03 ; 0x2ca
	db $43, $da, $e8, $d0, $03, $03 ; 0x2d0
	db $46, $da, $ee, $d0, $03, $03 ; 0x2d6
	db $af, $da, $61, $d1, $05, $03 ; 0x2dc
	db $b4, $da, $67, $d1, $05, $03 ; 0x2e2
	db $b9, $da, $6d, $d1, $05, $03 ; 0x2e8
	db $00, $00, $00, $00, $00, $00 ; 0x2ee
	db $60, $db, $00, $d0, $14, $02 ; 0x2f4
	db $a0, $da, $5e, $d0, $05, $03 ; 0x2fa
	db $a5, $da, $64, $d0, $05, $03 ; 0x300
	db $aa, $da, $6a, $d0, $05, $03 ; 0x306
	db $40, $da, $e1, $d0, $03, $03 ; 0x30c
	db $43, $da, $e7, $d0, $03, $03 ; 0x312
	db $46, $da, $ed, $d0, $03, $03 ; 0x318
	db $af, $da, $61, $d1, $05, $03 ; 0x31e
	db $b4, $da, $67, $d1, $05, $03 ; 0x324
	db $b9, $da, $6d, $d1, $05, $03 ; 0x32a
	db $00, $00, $00, $00, $00, $00 ; 0x330
	db $60, $db, $00, $d0, $14, $02 ; 0x336
	db $a0, $da, $5b, $d0, $05, $03 ; 0x33c
	db $a5, $da, $61, $d0, $05, $03 ; 0x342
	db $aa, $da, $67, $d0, $05, $03 ; 0x348
	db $40, $da, $df, $d0, $03, $03 ; 0x34e
	db $43, $da, $e5, $d0, $03, $03 ; 0x354
	db $46, $da, $eb, $d0, $03, $03 ; 0x35a
	db $af, $da, $61, $d1, $05, $03 ; 0x360
	db $b4, $da, $67, $d1, $05, $03 ; 0x366
	db $b9, $da, $6d, $d1, $05, $03 ; 0x36c
	db $00, $00, $00, $00, $00, $00 ; 0x372
	db $60, $db, $00, $d0, $14, $02 ; 0x378
	db $a5, $da, $5e, $d0, $05, $03 ; 0x37e
	db $aa, $da, $64, $d0, $05, $03 ; 0x384
	db $40, $da, $dc, $d0, $03, $03 ; 0x38a
	db $43, $da, $e2, $d0, $03, $03 ; 0x390
	db $46, $da, $e8, $d0, $03, $03 ; 0x396
	db $af, $da, $60, $d1, $05, $03 ; 0x39c
	db $b4, $da, $66, $d1, $05, $03 ; 0x3a2
	db $b9, $da, $6c, $d1, $05, $03 ; 0x3a8
	db $00, $00, $00, $00, $00, $00 ; 0x3ae
	db $60, $db, $00, $d0, $14, $02 ; 0x3b4
	db $a5, $da, $5b, $d0, $05, $03 ; 0x3ba
	db $aa, $da, $61, $d0, $05, $03 ; 0x3c0
	db $40, $da, $d9, $d0, $03, $03 ; 0x3c6
	db $43, $da, $df, $d0, $03, $03 ; 0x3cc
	db $46, $da, $e5, $d0, $03, $03 ; 0x3d2
	db $af, $da, $5e, $d1, $05, $03 ; 0x3d8
	db $b4, $da, $64, $d1, $05, $03 ; 0x3de
	db $b9, $da, $6a, $d1, $05, $03 ; 0x3e4
	db $00, $00, $00, $00, $00, $00 ; 0x3ea
	db $60, $db, $00, $d0, $14, $02 ; 0x3f0
	db $aa, $da, $5e, $d0, $05, $03 ; 0x3f6
	db $43, $da, $dc, $d0, $03, $03 ; 0x3fc
	db $46, $da, $e2, $d0, $03, $03 ; 0x402
	db $af, $da, $5b, $d1, $05, $03 ; 0x408
	db $b4, $da, $61, $d1, $05, $03 ; 0x40e
	db $b9, $da, $67, $d1, $05, $03 ; 0x414
	db $00, $00, $00, $00, $00, $00 ; 0x41a
	db $80, $db, $00, $d0, $14, $01 ; 0x420
	db $aa, $da, $5b, $d0, $05, $03 ; 0x426
	db $46, $da, $df, $d0, $03, $03 ; 0x42c
	db $b4, $da, $5e, $d1, $05, $03 ; 0x432
	db $b9, $da, $64, $d1, $05, $03 ; 0x438
	db $00, $00, $00, $00, $00, $00 ; 0x43e
	db $80, $db, $00, $d0, $14, $01 ; 0x444
	db $46, $da, $dc, $d0, $03, $03 ; 0x44a
	db $b4, $da, $5b, $d1, $05, $03 ; 0x450
	db $b9, $da, $61, $d1, $05, $03 ; 0x456
	db $00, $00, $00, $00, $00, $00 ; 0x45c
	db $b9, $da, $5e, $d1, $05, $03 ; 0x462
	db $00, $00, $00, $00, $00, $00 ; 0x468
	db $80, $db, $00, $d0, $14, $01 ; 0x46e
	db $a0, $da, $72, $d0, $05, $03 ; 0x474
	db $00, $00, $00, $00, $00, $00 ; 0x47a
	db $80, $db, $00, $d0, $14, $01 ; 0x480
	db $a0, $da, $6f, $d0, $05, $03 ; 0x486
	db $a5, $da, $78, $d0, $05, $03 ; 0x48c
	db $aa, $da, $f5, $d0, $05, $03 ; 0x492
	db $00, $00, $00, $00, $00, $00 ; 0x498
	db $60, $db, $00, $d0, $14, $02 ; 0x49e
	db $a0, $da, $6c, $d0, $05, $03 ; 0x4a4
	db $a5, $da, $75, $d0, $05, $03 ; 0x4aa
	db $aa, $da, $f2, $d0, $05, $03 ; 0x4b0
	db $00, $00, $00, $00, $00, $00 ; 0x4b6
	db $60, $db, $00, $d0, $14, $02 ; 0x4bc
	db $a0, $da, $69, $d0, $05, $03 ; 0x4c2
	db $a5, $da, $72, $d0, $05, $03 ; 0x4c8
	db $aa, $da, $ef, $d0, $05, $03 ; 0x4ce
	db $af, $da, $f8, $d0, $05, $03 ; 0x4d4
	db $b4, $da, $73, $d1, $05, $03 ; 0x4da
	db $00, $00, $00, $00, $00, $00 ; 0x4e0
	db $60, $db, $00, $d0, $14, $02 ; 0x4e6
	db $a0, $da, $66, $d0, $05, $03 ; 0x4ec
	db $a5, $da, $6f, $d0, $05, $03 ; 0x4f2
	db $aa, $da, $ec, $d0, $05, $03 ; 0x4f8
	db $af, $da, $f5, $d0, $05, $03 ; 0x4fe
	db $b4, $da, $70, $d1, $05, $03 ; 0x504
	db $00, $00, $00, $00, $00, $00 ; 0x50a
	db $60, $db, $00, $d0, $14, $02 ; 0x510
	db $a0, $da, $64, $d0, $05, $03 ; 0x516
	db $a5, $da, $6d, $d0, $05, $03 ; 0x51c
	db $aa, $da, $e9, $d0, $05, $03 ; 0x522
	db $af, $da, $f2, $d0, $05, $03 ; 0x528
	db $b4, $da, $6d, $d1, $05, $03 ; 0x52e
	db $b9, $da, $73, $d1, $05, $03 ; 0x534
	db $00, $00, $00, $00, $00, $00 ; 0x53a
	db $60, $db, $00, $d0, $14, $02 ; 0x540
	db $a0, $da, $63, $d0, $05, $03 ; 0x546
	db $a5, $da, $6c, $d0, $05, $03 ; 0x54c
	db $aa, $da, $e6, $d0, $05, $03 ; 0x552
	db $af, $da, $ef, $d0, $05, $03 ; 0x558
	db $b4, $da, $6a, $d1, $05, $03 ; 0x55e
	db $b9, $da, $70, $d1, $05, $03 ; 0x564
	db $54, $db, $76, $d1, $05, $03 ; 0x56a
	db $00, $00, $00, $00, $00, $00 ; 0x570
	db $60, $db, $00, $d0, $14, $02 ; 0x576
	db $a0, $da, $63, $d0, $05, $03 ; 0x57c
	db $a5, $da, $6c, $d0, $05, $03 ; 0x582
	db $aa, $da, $e4, $d0, $05, $03 ; 0x588
	db $af, $da, $ed, $d0, $05, $03 ; 0x58e
	db $b4, $da, $67, $d1, $05, $03 ; 0x594
	db $b9, $da, $6d, $d1, $05, $03 ; 0x59a
	db $54, $db, $73, $d1, $05, $03 ; 0x5a0
	db $00, $00, $00, $00, $00, $00 ; 0x5a6
	db $60, $db, $00, $d0, $14, $02 ; 0x5ac
	db $a0, $da, $63, $d0, $05, $03 ; 0x5b2
	db $a5, $da, $6c, $d0, $05, $03 ; 0x5b8
	db $aa, $da, $e3, $d0, $05, $03 ; 0x5be
	db $af, $da, $ec, $d0, $05, $03 ; 0x5c4
	db $b4, $da, $64, $d1, $05, $03 ; 0x5ca
	db $b9, $da, $6a, $d1, $05, $03 ; 0x5d0
	db $54, $db, $70, $d1, $05, $03 ; 0x5d6
	db $00, $00, $00, $00, $00, $00 ; 0x5dc
	db $60, $db, $00, $d0, $14, $02 ; 0x5e2
	db $a0, $da, $63, $d0, $05, $03 ; 0x5e8
	db $a5, $da, $6c, $d0, $05, $03 ; 0x5ee
	db $aa, $da, $e3, $d0, $05, $03 ; 0x5f4
	db $af, $da, $ec, $d0, $05, $03 ; 0x5fa
	db $b4, $da, $62, $d1, $05, $03 ; 0x600
	db $b9, $da, $68, $d1, $05, $03 ; 0x606
	db $54, $db, $6e, $d1, $05, $03 ; 0x60c
	db $00, $00, $00, $00, $00, $00 ; 0x612
	db $60, $db, $00, $d0, $14, $02 ; 0x618
	db $a0, $da, $63, $d0, $05, $03 ; 0x61e
	db $a5, $da, $6c, $d0, $05, $03 ; 0x624
	db $aa, $da, $e3, $d0, $05, $03 ; 0x62a
	db $af, $da, $ec, $d0, $05, $03 ; 0x630
	db $b4, $da, $61, $d1, $05, $03 ; 0x636
	db $b9, $da, $67, $d1, $05, $03 ; 0x63c
	db $54, $db, $6d, $d1, $05, $03 ; 0x642
	db $00, $00, $00, $00, $00, $00 ; 0x648
	db $60, $db, $00, $d0, $14, $02 ; 0x64e
	db $a0, $da, $63, $d0, $05, $03 ; 0x654
	db $a5, $da, $6c, $d0, $05, $03 ; 0x65a
	db $aa, $da, $e3, $d0, $05, $03 ; 0x660
	db $af, $da, $ec, $d0, $05, $03 ; 0x666
	db $b4, $da, $61, $d1, $05, $03 ; 0x66c
	db $b9, $da, $67, $d1, $05, $03 ; 0x672
	db $54, $db, $6d, $d1, $05, $03 ; 0x678
	db $00, $00, $00, $00, $00, $00 ; 0x67e
	db $60, $db, $00, $d0, $14, $02 ; 0x684
	db $a0, $da, $62, $d0, $05, $03 ; 0x68a
	db $a5, $da, $6b, $d0, $05, $03 ; 0x690
	db $aa, $da, $e3, $d0, $05, $03 ; 0x696
	db $af, $da, $ec, $d0, $05, $03 ; 0x69c
	db $b4, $da, $61, $d1, $05, $03 ; 0x6a2
	db $b9, $da, $67, $d1, $05, $03 ; 0x6a8
	db $54, $db, $6d, $d1, $05, $03 ; 0x6ae
	db $00, $00, $00, $00, $00, $00 ; 0x6b4
	db $60, $db, $00, $d0, $14, $02 ; 0x6ba
	db $a0, $da, $60, $d0, $05, $03 ; 0x6c0
	db $a5, $da, $69, $d0, $05, $03 ; 0x6c6
	db $aa, $da, $e2, $d0, $05, $03 ; 0x6cc
	db $af, $da, $eb, $d0, $05, $03 ; 0x6d2
	db $b4, $da, $61, $d1, $05, $03 ; 0x6d8
	db $b9, $da, $67, $d1, $05, $03 ; 0x6de
	db $54, $db, $6d, $d1, $05, $03 ; 0x6e4
	db $00, $00, $00, $00, $00, $00 ; 0x6ea
	db $60, $db, $00, $d0, $14, $02 ; 0x6f0
	db $a0, $da, $5d, $d0, $05, $03 ; 0x6f6
	db $a5, $da, $66, $d0, $05, $03 ; 0x6fc
	db $aa, $da, $e0, $d0, $05, $03 ; 0x702
	db $af, $da, $e9, $d0, $05, $03 ; 0x708
	db $b4, $da, $60, $d1, $05, $03 ; 0x70e
	db $b9, $da, $66, $d1, $05, $03 ; 0x714
	db $54, $db, $6c, $d1, $05, $03 ; 0x71a
	db $00, $00, $00, $00, $00, $00 ; 0x720
	db $60, $db, $00, $d0, $14, $02 ; 0x726
	db $a0, $da, $5d, $d0, $05, $03 ; 0x72c
	db $a5, $da, $66, $d0, $05, $03 ; 0x732
	db $aa, $da, $e0, $d0, $05, $03 ; 0x738
	db $af, $da, $e9, $d0, $05, $03 ; 0x73e
	db $b4, $da, $60, $d1, $05, $03 ; 0x744
	db $b9, $da, $66, $d1, $05, $03 ; 0x74a
	db $54, $db, $6c, $d1, $05, $03 ; 0x750
	db $00, $00, $00, $00, $00, $00 ; 0x756
	db $60, $db, $00, $d0, $14, $02 ; 0x75c
	db $a0, $da, $5a, $d0, $05, $03 ; 0x762
	db $a5, $da, $63, $d0, $05, $03 ; 0x768
	db $aa, $da, $dd, $d0, $05, $03 ; 0x76e
	db $af, $da, $e6, $d0, $05, $03 ; 0x774
	db $b4, $da, $5e, $d1, $05, $03 ; 0x77a
	db $b9, $da, $64, $d1, $05, $03 ; 0x780
	db $54, $db, $6a, $d1, $05, $03 ; 0x786
	db $00, $00, $00, $00, $00, $00 ; 0x78c
	db $60, $db, $00, $d0, $14, $02 ; 0x792
	db $a5, $da, $60, $d0, $05, $03 ; 0x798
	db $aa, $da, $da, $d0, $05, $03 ; 0x79e
	db $af, $da, $e3, $d0, $05, $03 ; 0x7a4
	db $b4, $da, $5b, $d1, $05, $03 ; 0x7aa
	db $b9, $da, $61, $d1, $05, $03 ; 0x7b0
	db $54, $db, $67, $d1, $05, $03 ; 0x7b6
	db $00, $00, $00, $00, $00, $00 ; 0x7bc
	db $60, $db, $00, $d0, $14, $02 ; 0x7c2
	db $a5, $da, $5d, $d0, $05, $03 ; 0x7c8
	db $af, $da, $e0, $d0, $05, $03 ; 0x7ce
	db $b9, $da, $5e, $d1, $05, $03 ; 0x7d4
	db $54, $db, $64, $d1, $05, $03 ; 0x7da
	db $00, $00, $00, $00, $00, $00 ; 0x7e0
	db $80, $db, $00, $d0, $14, $01 ; 0x7e6
	db $af, $da, $dd, $d0, $05, $03 ; 0x7ec
	db $b9, $da, $5b, $d1, $05, $03 ; 0x7f2
	db $54, $db, $61, $d1, $05, $03 ; 0x7f8
	db $00, $00, $00, $00, $00, $00 ; 0x7fe
	db $80, $db, $00, $d0, $14, $01 ; 0x804
	db $54, $db, $5e, $d1, $05, $03 ; 0x80a
	db $00, $00, $00, $00, $00, $00 ; 0x810
	db $80, $db, $00, $d0, $14, $01 ; 0x816
	db $40, $da, $71, $d0, $03, $03 ; 0x81c
	db $00, $00, $00, $00, $00, $00 ; 0x822
	db $80, $db, $00, $d0, $14, $01 ; 0x828
	db $40, $da, $6e, $d0, $03, $03 ; 0x82e
	db $43, $da, $74, $d0, $03, $03 ; 0x834
	db $00, $00, $00, $00, $00, $00 ; 0x83a
	db $60, $db, $00, $d0, $14, $02 ; 0x840
	db $40, $da, $6b, $d0, $03, $03 ; 0x846
	db $43, $da, $71, $d0, $03, $03 ; 0x84c
	db $46, $da, $77, $d0, $03, $03 ; 0x852
	db $49, $da, $f1, $d0, $03, $03 ; 0x858
	db $00, $00, $00, $00, $00, $00 ; 0x85e
	db $60, $db, $00, $d0, $14, $02 ; 0x864
	db $40, $da, $68, $d0, $03, $03 ; 0x86a
	db $43, $da, $6e, $d0, $03, $03 ; 0x870
	db $46, $da, $74, $d0, $03, $03 ; 0x876
	db $49, $da, $ee, $d0, $03, $03 ; 0x87c
	db $4c, $da, $f4, $d0, $03, $03 ; 0x882
	db $52, $da, $74, $d1, $03, $03 ; 0x888
	db $00, $00, $00, $00, $00, $00 ; 0x88e
	db $60, $db, $00, $d0, $14, $02 ; 0x894
	db $40, $da, $65, $d0, $03, $03 ; 0x89a
	db $43, $da, $6b, $d0, $03, $03 ; 0x8a0
	db $46, $da, $71, $d0, $03, $03 ; 0x8a6
	db $49, $da, $eb, $d0, $03, $03 ; 0x8ac
	db $4c, $da, $f1, $d0, $03, $03 ; 0x8b2
	db $52, $da, $71, $d1, $03, $03 ; 0x8b8
	db $55, $da, $77, $d1, $03, $03 ; 0x8be
	db $00, $00, $00, $00, $00, $00 ; 0x8c4
	db $60, $db, $00, $d0, $14, $02 ; 0x8ca
	db $40, $da, $63, $d0, $03, $03 ; 0x8d0
	db $43, $da, $69, $d0, $03, $03 ; 0x8d6
	db $46, $da, $6f, $d0, $03, $03 ; 0x8dc
	db $49, $da, $e8, $d0, $03, $03 ; 0x8e2
	db $4c, $da, $ee, $d0, $03, $03 ; 0x8e8
	db $4f, $da, $f4, $d0, $03, $03 ; 0x8ee
	db $52, $da, $6e, $d1, $03, $03 ; 0x8f4
	db $55, $da, $74, $d1, $03, $03 ; 0x8fa
	db $58, $da, $7a, $d1, $03, $03 ; 0x900
	db $00, $00, $00, $00, $00, $00 ; 0x906
	db $60, $db, $00, $d0, $14, $02 ; 0x90c
	db $40, $da, $62, $d0, $03, $03 ; 0x912
	db $43, $da, $68, $d0, $03, $03 ; 0x918
	db $46, $da, $6e, $d0, $03, $03 ; 0x91e
	db $49, $da, $e5, $d0, $03, $03 ; 0x924
	db $4c, $da, $eb, $d0, $03, $03 ; 0x92a
	db $4f, $da, $f1, $d0, $03, $03 ; 0x930
	db $52, $da, $6b, $d1, $03, $03 ; 0x936
	db $55, $da, $71, $d1, $03, $03 ; 0x93c
	db $58, $da, $77, $d1, $03, $03 ; 0x942
	db $00, $00, $00, $00, $00, $00 ; 0x948
	db $60, $db, $00, $d0, $14, $02 ; 0x94e
	db $40, $da, $62, $d0, $03, $03 ; 0x954
	db $43, $da, $68, $d0, $03, $03 ; 0x95a
	db $46, $da, $6e, $d0, $03, $03 ; 0x960
	db $49, $da, $e3, $d0, $03, $03 ; 0x966
	db $4c, $da, $e9, $d0, $03, $03 ; 0x96c
	db $4f, $da, $ef, $d0, $03, $03 ; 0x972
	db $52, $da, $68, $d1, $03, $03 ; 0x978
	db $55, $da, $6e, $d1, $03, $03 ; 0x97e
	db $58, $da, $74, $d1, $03, $03 ; 0x984
	db $00, $00, $00, $00, $00, $00 ; 0x98a
	db $60, $db, $00, $d0, $14, $02 ; 0x990
	db $40, $da, $62, $d0, $03, $03 ; 0x996
	db $43, $da, $68, $d0, $03, $03 ; 0x99c
	db $46, $da, $6e, $d0, $03, $03 ; 0x9a2
	db $49, $da, $e2, $d0, $03, $03 ; 0x9a8
	db $4c, $da, $e8, $d0, $03, $03 ; 0x9ae
	db $4f, $da, $ee, $d0, $03, $03 ; 0x9b4
	db $52, $da, $65, $d1, $03, $03 ; 0x9ba
	db $55, $da, $6b, $d1, $03, $03 ; 0x9c0
	db $58, $da, $71, $d1, $03, $03 ; 0x9c6
	db $00, $00, $00, $00, $00, $00 ; 0x9cc
	db $60, $db, $00, $d0, $14, $02 ; 0x9d2
	db $40, $da, $62, $d0, $03, $03 ; 0x9d8
	db $43, $da, $68, $d0, $03, $03 ; 0x9de
	db $46, $da, $6e, $d0, $03, $03 ; 0x9e4
	db $49, $da, $e2, $d0, $03, $03 ; 0x9ea
	db $4c, $da, $e8, $d0, $03, $03 ; 0x9f0
	db $4f, $da, $ee, $d0, $03, $03 ; 0x9f6
	db $52, $da, $63, $d1, $03, $03 ; 0x9fc
	db $55, $da, $69, $d1, $03, $03 ; 0xa02
	db $58, $da, $6f, $d1, $03, $03 ; 0xa08
	db $00, $00, $00, $00, $00, $00 ; 0xa0e
	db $60, $db, $00, $d0, $14, $02 ; 0xa14
	db $40, $da, $62, $d0, $03, $03 ; 0xa1a
	db $43, $da, $68, $d0, $03, $03 ; 0xa20
	db $46, $da, $6e, $d0, $03, $03 ; 0xa26
	db $49, $da, $e2, $d0, $03, $03 ; 0xa2c
	db $4c, $da, $e8, $d0, $03, $03 ; 0xa32
	db $4f, $da, $ee, $d0, $03, $03 ; 0xa38
	db $52, $da, $62, $d1, $03, $03 ; 0xa3e
	db $55, $da, $68, $d1, $03, $03 ; 0xa44
	db $58, $da, $6e, $d1, $03, $03 ; 0xa4a
	db $00, $00, $00, $00, $00, $00 ; 0xa50
	db $60, $db, $00, $d0, $14, $02 ; 0xa56
	db $40, $da, $61, $d0, $03, $03 ; 0xa5c
	db $43, $da, $67, $d0, $03, $03 ; 0xa62
	db $46, $da, $6d, $d0, $03, $03 ; 0xa68
	db $49, $da, $e2, $d0, $03, $03 ; 0xa6e
	db $4c, $da, $e8, $d0, $03, $03 ; 0xa74
	db $4f, $da, $ee, $d0, $03, $03 ; 0xa7a
	db $52, $da, $62, $d1, $03, $03 ; 0xa80
	db $55, $da, $68, $d1, $03, $03 ; 0xa86
	db $58, $da, $6e, $d1, $03, $03 ; 0xa8c
	db $00, $00, $00, $00, $00, $00 ; 0xa92
	db $60, $db, $00, $d0, $14, $02 ; 0xa98
	db $40, $da, $5f, $d0, $03, $03 ; 0xa9e
	db $43, $da, $65, $d0, $03, $03 ; 0xaa4
	db $46, $da, $6b, $d0, $03, $03 ; 0xaaa
	db $49, $da, $e2, $d0, $03, $03 ; 0xab0
	db $4c, $da, $e8, $d0, $03, $03 ; 0xab6
	db $4f, $da, $ee, $d0, $03, $03 ; 0xabc
	db $52, $da, $62, $d1, $03, $03 ; 0xac2
	db $55, $da, $68, $d1, $03, $03 ; 0xac8
	db $58, $da, $6e, $d1, $03, $03 ; 0xace
	db $00, $00, $00, $00, $00, $00 ; 0xad4
	db $60, $db, $00, $d0, $14, $02 ; 0xada
	db $40, $da, $5c, $d0, $03, $03 ; 0xae0
	db $43, $da, $62, $d0, $03, $03 ; 0xae6
	db $46, $da, $68, $d0, $03, $03 ; 0xaec
	db $49, $da, $e1, $d0, $03, $03 ; 0xaf2
	db $4c, $da, $e7, $d0, $03, $03 ; 0xaf8
	db $4f, $da, $ed, $d0, $03, $03 ; 0xafe
	db $52, $da, $62, $d1, $03, $03 ; 0xb04
	db $55, $da, $68, $d1, $03, $03 ; 0xb0a
	db $58, $da, $6e, $d1, $03, $03 ; 0xb10
	db $00, $00, $00, $00, $00, $00 ; 0xb16
	db $80, $db, $00, $d0, $14, $01 ; 0xb1c
	db $43, $da, $5f, $d0, $03, $03 ; 0xb22
	db $46, $da, $65, $d0, $03, $03 ; 0xb28
	db $49, $da, $df, $d0, $03, $03 ; 0xb2e
	db $4c, $da, $e5, $d0, $03, $03 ; 0xb34
	db $4f, $da, $eb, $d0, $03, $03 ; 0xb3a
	db $52, $da, $61, $d1, $03, $03 ; 0xb40
	db $55, $da, $67, $d1, $03, $03 ; 0xb46
	db $58, $da, $6d, $d1, $03, $03 ; 0xb4c
	db $00, $00, $00, $00, $00, $00 ; 0xb52
	db $80, $db, $00, $d0, $14, $01 ; 0xb58
	db $43, $da, $5c, $d0, $03, $03 ; 0xb5e
	db $46, $da, $62, $d0, $03, $03 ; 0xb64
	db $49, $da, $dc, $d0, $03, $03 ; 0xb6a
	db $4c, $da, $e2, $d0, $03, $03 ; 0xb70
	db $4f, $da, $e8, $d0, $03, $03 ; 0xb76
	db $52, $da, $5f, $d1, $03, $03 ; 0xb7c
	db $55, $da, $65, $d1, $03, $03 ; 0xb82
	db $58, $da, $6b, $d1, $03, $03 ; 0xb88
	db $00, $00, $00, $00, $00, $00 ; 0xb8e
	db $46, $da, $5f, $d0, $03, $03 ; 0xb94
	db $4c, $da, $df, $d0, $03, $03 ; 0xb9a
	db $4f, $da, $e5, $d0, $03, $03 ; 0xba0
	db $52, $da, $5c, $d1, $03, $03 ; 0xba6
	db $55, $da, $62, $d1, $03, $03 ; 0xbac
	db $58, $da, $68, $d1, $03, $03 ; 0xbb2
	db $00, $00, $00, $00, $00, $00 ; 0xbb8
	db $4c, $da, $dc, $d0, $03, $03 ; 0xbbe
	db $4f, $da, $e2, $d0, $03, $03 ; 0xbc4
	db $55, $da, $5f, $d1, $03, $03 ; 0xbca
	db $58, $da, $65, $d1, $03, $03 ; 0xbd0
	db $00, $00, $00, $00, $00, $00 ; 0xbd6
	db $4f, $da, $df, $d0, $03, $03 ; 0xbdc
	db $55, $da, $5c, $d1, $03, $03 ; 0xbe2
	db $58, $da, $62, $d1, $03, $03 ; 0xbe8
	db $00, $00, $00, $00, $00, $00 ; 0xbee
	db $58, $da, $5f, $d1, $03, $03 ; 0xbf4
	db $00, $00, $00, $00, $00, $00 ; 0xbfa
	db $00, $00, $00, $00, $00, $00 ; 0xc00
	db $80, $db, $00, $d0, $14, $01 ; 0xc06
	db $40, $da, $91, $d0, $03, $03 ; 0xc0c
	db $00, $00, $00, $00, $00, $00 ; 0xc12
	db $80, $db, $00, $d0, $14, $01 ; 0xc18
	db $40, $da, $8e, $d0, $03, $03 ; 0xc1e
	db $43, $da, $94, $d0, $03, $03 ; 0xc24
	db $00, $00, $00, $00, $00, $00 ; 0xc2a
	db $60, $db, $00, $d0, $14, $02 ; 0xc30
	db $40, $da, $8b, $d0, $03, $03 ; 0xc36
	db $43, $da, $91, $d0, $03, $03 ; 0xc3c
	db $00, $00, $00, $00, $00, $00 ; 0xc42
	db $60, $db, $00, $d0, $14, $02 ; 0xc48
	db $40, $da, $88, $d0, $03, $03 ; 0xc4e
	db $43, $da, $8e, $d0, $03, $03 ; 0xc54
	db $a0, $da, $33, $d1, $03, $03 ; 0xc5a
	db $00, $00, $00, $00, $00, $00 ; 0xc60
	db $60, $db, $00, $d0, $14, $02 ; 0xc66
	db $40, $da, $85, $d0, $03, $03 ; 0xc6c
	db $43, $da, $8b, $d0, $03, $03 ; 0xc72
	db $46, $da, $91, $d0, $03, $03 ; 0xc78
	db $a0, $da, $30, $d1, $03, $03 ; 0xc7e
	db $00, $00, $00, $00, $00, $00 ; 0xc84
	db $60, $db, $00, $d0, $14, $02 ; 0xc8a
	db $40, $da, $83, $d0, $03, $03 ; 0xc90
	db $43, $da, $89, $d0, $03, $03 ; 0xc96
	db $46, $da, $8f, $d0, $03, $03 ; 0xc9c
	db $a0, $da, $2d, $d1, $03, $03 ; 0xca2
	db $00, $00, $00, $00, $00, $00 ; 0xca8
	db $60, $db, $00, $d0, $14, $02 ; 0xcae
	db $40, $da, $82, $d0, $03, $03 ; 0xcb4
	db $43, $da, $88, $d0, $03, $03 ; 0xcba
	db $46, $da, $8e, $d0, $03, $03 ; 0xcc0
	db $a0, $da, $2a, $d1, $05, $03 ; 0xcc6
	db $00, $00, $00, $00, $00, $00 ; 0xccc
	db $60, $db, $00, $d0, $14, $02 ; 0xcd2
	db $40, $da, $82, $d0, $03, $03 ; 0xcd8
	db $43, $da, $88, $d0, $03, $03 ; 0xcde
	db $46, $da, $8e, $d0, $03, $03 ; 0xce4
	db $a0, $da, $28, $d1, $05, $03 ; 0xcea
	db $00, $00, $00, $00, $00, $00 ; 0xcf0
	db $60, $db, $00, $d0, $14, $02 ; 0xcf6
	db $40, $da, $82, $d0, $03, $03 ; 0xcfc
	db $43, $da, $88, $d0, $03, $03 ; 0xd02
	db $46, $da, $8e, $d0, $03, $03 ; 0xd08
	db $a0, $da, $27, $d1, $05, $03 ; 0xd0e
	db $00, $00, $00, $00, $00, $00 ; 0xd14
	db $60, $db, $00, $d0, $14, $02 ; 0xd1a
	db $40, $da, $82, $d0, $03, $03 ; 0xd20
	db $43, $da, $88, $d0, $03, $03 ; 0xd26
	db $46, $da, $8e, $d0, $03, $03 ; 0xd2c
	db $a0, $da, $27, $d1, $05, $03 ; 0xd32
	db $00, $00, $00, $00, $00, $00 ; 0xd38
	db $60, $db, $00, $d0, $14, $02 ; 0xd3e
	db $40, $da, $81, $d0, $03, $03 ; 0xd44
	db $43, $da, $87, $d0, $03, $03 ; 0xd4a
	db $46, $da, $8d, $d0, $03, $03 ; 0xd50
	db $a0, $da, $27, $d1, $05, $03 ; 0xd56
	db $00, $00, $00, $00, $00, $00 ; 0xd5c
	db $60, $db, $00, $d0, $14, $02 ; 0xd62
	db $40, $da, $7f, $d0, $03, $03 ; 0xd68
	db $43, $da, $85, $d0, $03, $03 ; 0xd6e
	db $46, $da, $8b, $d0, $03, $03 ; 0xd74
	db $a0, $da, $27, $d1, $05, $03 ; 0xd7a
	db $00, $00, $00, $00, $00, $00 ; 0xd80
	db $80, $db, $00, $d0, $14, $01 ; 0xd86
	db $40, $da, $7c, $d0, $03, $03 ; 0xd8c
	db $43, $da, $82, $d0, $03, $03 ; 0xd92
	db $46, $da, $88, $d0, $03, $03 ; 0xd98
	db $a0, $da, $26, $d1, $05, $03 ; 0xd9e
	db $00, $00, $00, $00, $00, $00 ; 0xda4
	db $80, $db, $00, $d0, $14, $01 ; 0xdaa
	db $43, $da, $7f, $d0, $03, $03 ; 0xdb0
	db $46, $da, $85, $d0, $03, $03 ; 0xdb6
	db $a0, $da, $24, $d1, $05, $03 ; 0xdbc
	db $00, $00, $00, $00, $00, $00 ; 0xdc2
	db $43, $da, $7c, $d0, $03, $03 ; 0xdc8
	db $46, $da, $82, $d0, $03, $03 ; 0xdce
	db $a0, $da, $21, $d1, $05, $03 ; 0xdd4
	db $00, $00, $00, $00, $00, $00 ; 0xdda
	db $46, $da, $7f, $d0, $03, $03 ; 0xde0
	db $a0, $da, $1e, $d1, $05, $03 ; 0xde6
	db $00, $00, $00, $00, $00, $00 ; 0xdec
	db $46, $da, $7c, $d0, $03, $03 ; 0xdf2
	db $a0, $da, $1b, $d1, $05, $03 ; 0xdf8
	db $00, $00, $00, $00, $00, $00 ; 0xdfe
	db $a0, $da, $18, $d1, $05, $03 ; 0xe04
	db $00, $00, $00, $00, $00, $00 ; 0xe0a
	db $80, $db, $00, $d0, $14, $01 ; 0xe10
	db $40, $da, $94, $d0, $03, $03 ; 0xe16
	db $00, $00, $00, $00, $00, $00 ; 0xe1c
	db $80, $db, $00, $d0, $14, $01 ; 0xe22
	db $40, $da, $91, $d0, $03, $03 ; 0xe28
	db $00, $00, $00, $00, $00, $00 ; 0xe2e
	db $80, $db, $00, $d0, $14, $01 ; 0xe34
	db $40, $da, $8e, $d0, $03, $03 ; 0xe3a
	db $43, $da, $94, $d0, $03, $03 ; 0xe40
	db $00, $00, $00, $00, $00, $00 ; 0xe46
	db $60, $db, $00, $d0, $14, $02 ; 0xe4c
	db $40, $da, $8b, $d0, $03, $03 ; 0xe52
	db $43, $da, $91, $d0, $03, $03 ; 0xe58
	db $00, $00, $00, $00, $00, $00 ; 0xe5e
	db $60, $db, $00, $d0, $14, $02 ; 0xe64
	db $40, $da, $88, $d0, $03, $03 ; 0xe6a
	db $43, $da, $8e, $d0, $03, $03 ; 0xe70
	db $00, $00, $00, $00, $00, $00 ; 0xe76
	db $60, $db, $00, $d0, $14, $02 ; 0xe7c
	db $40, $da, $85, $d0, $03, $03 ; 0xe82
	db $43, $da, $8b, $d0, $03, $03 ; 0xe88
	db $46, $da, $91, $d0, $03, $03 ; 0xe8e
	db $a0, $da, $32, $d1, $05, $03 ; 0xe94
	db $00, $00, $00, $00, $00, $00 ; 0xe9a
	db $60, $db, $00, $d0, $14, $02 ; 0xea0
	db $40, $da, $83, $d0, $03, $03 ; 0xea6
	db $43, $da, $89, $d0, $03, $03 ; 0xeac
	db $46, $da, $8f, $d0, $03, $03 ; 0xeb2
	db $a0, $da, $2f, $d1, $05, $03 ; 0xeb8
	db $00, $00, $00, $00, $00, $00 ; 0xebe
	db $60, $db, $00, $d0, $14, $02 ; 0xec4
	db $40, $da, $82, $d0, $03, $03 ; 0xeca
	db $43, $da, $88, $d0, $03, $03 ; 0xed0
	db $46, $da, $8e, $d0, $03, $03 ; 0xed6
	db $a0, $da, $2c, $d1, $05, $03 ; 0xedc
	db $a5, $da, $34, $d1, $05, $03 ; 0xee2
	db $00, $00, $00, $00, $00, $00 ; 0xee8
	db $60, $db, $00, $d0, $14, $02 ; 0xeee
	db $40, $da, $82, $d0, $03, $03 ; 0xef4
	db $43, $da, $88, $d0, $03, $03 ; 0xefa
	db $46, $da, $8e, $d0, $03, $03 ; 0xf00
	db $a0, $da, $29, $d1, $05, $03 ; 0xf06
	db $a5, $da, $31, $d1, $05, $03 ; 0xf0c
	db $00, $00, $00, $00, $00, $00 ; 0xf12
	db $60, $db, $00, $d0, $14, $02 ; 0xf18
	db $40, $da, $82, $d0, $03, $03 ; 0xf1e
	db $43, $da, $88, $d0, $03, $03 ; 0xf24
	db $46, $da, $8e, $d0, $03, $03 ; 0xf2a
	db $a0, $da, $26, $d1, $05, $03 ; 0xf30
	db $a5, $da, $2e, $d1, $05, $03 ; 0xf36
	db $00, $00, $00, $00, $00, $00 ; 0xf3c
	db $60, $db, $00, $d0, $14, $02 ; 0xf42
	db $40, $da, $82, $d0, $03, $03 ; 0xf48
	db $43, $da, $88, $d0, $03, $03 ; 0xf4e
	db $46, $da, $8e, $d0, $03, $03 ; 0xf54
	db $a0, $da, $24, $d1, $05, $03 ; 0xf5a
	db $a5, $da, $2c, $d1, $05, $03 ; 0xf60
	db $00, $00, $00, $00, $00, $00 ; 0xf66
	db $60, $db, $00, $d0, $14, $02 ; 0xf6c
	db $40, $da, $82, $d0, $03, $03 ; 0xf72
	db $43, $da, $88, $d0, $03, $03 ; 0xf78
	db $46, $da, $8e, $d0, $03, $03 ; 0xf7e
	db $a0, $da, $23, $d1, $05, $03 ; 0xf84
	db $a5, $da, $2b, $d1, $05, $03 ; 0xf8a
	db $00, $00, $00, $00, $00, $00 ; 0xf90
	db $60, $db, $00, $d0, $14, $02 ; 0xf96
	db $40, $da, $81, $d0, $03, $03 ; 0xf9c
	db $43, $da, $87, $d0, $03, $03 ; 0xfa2
	db $46, $da, $8d, $d0, $03, $03 ; 0xfa8
	db $a0, $da, $23, $d1, $05, $03 ; 0xfae
	db $a5, $da, $2b, $d1, $05, $03 ; 0xfb4
	db $00, $00, $00, $00, $00, $00 ; 0xfba
	db $60, $db, $00, $d0, $14, $02 ; 0xfc0
	db $40, $da, $7f, $d0, $03, $03 ; 0xfc6
	db $43, $da, $85, $d0, $03, $03 ; 0xfcc
	db $46, $da, $8b, $d0, $03, $03 ; 0xfd2
	db $a0, $da, $23, $d1, $05, $03 ; 0xfd8
	db $a5, $da, $2b, $d1, $05, $03 ; 0xfde
	db $00, $00, $00, $00, $00, $00 ; 0xfe4
	db $80, $db, $00, $d0, $14, $01 ; 0xfea
	db $43, $da, $82, $d0, $03, $03 ; 0xff0
	db $46, $da, $88, $d0, $03, $03 ; 0xff6
	db $a0, $da, $22, $d1, $05, $03 ; 0xffc
	db $a5, $da, $2a, $d1, $05, $03 ; 0x1002
	db $00, $00, $00, $00, $00, $00 ; 0x1008
	db $80, $db, $00, $d0, $14, $01 ; 0x100e
	db $43, $da, $7f, $d0, $03, $03 ; 0x1014
	db $46, $da, $85, $d0, $03, $03 ; 0x101a
	db $a0, $da, $20, $d1, $05, $03 ; 0x1020
	db $a5, $da, $28, $d1, $05, $03 ; 0x1026
	db $00, $00, $00, $00, $00, $00 ; 0x102c
	db $46, $da, $82, $d0, $03, $03 ; 0x1032
	db $a0, $da, $1d, $d1, $05, $03 ; 0x1038
	db $a5, $da, $25, $d1, $05, $03 ; 0x103e
	db $00, $00, $00, $00, $00, $00 ; 0x1044
	db $46, $da, $7f, $d0, $03, $03 ; 0x104a
	db $a0, $da, $1a, $d1, $05, $03 ; 0x1050
	db $a5, $da, $22, $d1, $05, $03 ; 0x1056
	db $00, $00, $00, $00, $00, $00 ; 0x105c
	db $a0, $da, $17, $d1, $05, $03 ; 0x1062
	db $a5, $da, $1f, $d1, $05, $03 ; 0x1068
	db $00, $00, $00, $00, $00, $00 ; 0x106e
	db $a5, $da, $1c, $d1, $05, $03 ; 0x1074
	db $00, $00, $00, $00, $00, $00 ; 0x107a
	db $a5, $da, $19, $d1, $05, $03 ; 0x1080
	db $00, $00, $00, $00, $00, $00 ; 0x1086
	db $80, $db, $00, $d0, $14, $01 ; 0x108c
	db $a0, $da, $f3, $d0, $05, $03 ; 0x1092
	db $00, $00, $00, $00, $00, $00 ; 0x1098
	db $80, $db, $00, $d0, $14, $01 ; 0x109e
	db $a0, $da, $f0, $d0, $05, $03 ; 0x10a4
	db $00, $00, $00, $00, $00, $00 ; 0x10aa
	db $60, $db, $00, $d0, $14, $02 ; 0x10b0
	db $a0, $da, $ed, $d0, $05, $03 ; 0x10b6
	db $a5, $da, $f6, $d0, $05, $03 ; 0x10bc
	db $00, $00, $00, $00, $00, $00 ; 0x10c2
	db $60, $db, $00, $d0, $14, $02 ; 0x10c8
	db $a0, $da, $ea, $d0, $05, $03 ; 0x10ce
	db $a5, $da, $f3, $d0, $05, $03 ; 0x10d4
	db $00, $00, $00, $00, $00, $00 ; 0x10da
	db $60, $db, $00, $d0, $14, $02 ; 0x10e0
	db $a0, $da, $e7, $d0, $05, $03 ; 0x10e6
	db $a5, $da, $f0, $d0, $05, $03 ; 0x10ec
	db $00, $00, $00, $00, $00, $00 ; 0x10f2
	db $60, $db, $00, $d0, $14, $02 ; 0x10f8
	db $a0, $da, $e4, $d0, $05, $03 ; 0x10fe
	db $a5, $da, $ed, $d0, $05, $03 ; 0x1104
	db $aa, $da, $f6, $d0, $05, $03 ; 0x110a
	db $00, $00, $00, $00, $00, $00 ; 0x1110
	db $60, $db, $00, $d0, $14, $02 ; 0x1116
	db $a0, $da, $e2, $d0, $05, $03 ; 0x111c
	db $a5, $da, $ea, $d0, $05, $03 ; 0x1122
	db $aa, $da, $f3, $d0, $05, $03 ; 0x1128
	db $00, $00, $00, $00, $00, $00 ; 0x112e
	db $60, $db, $00, $d0, $14, $02 ; 0x1134
	db $a0, $da, $e1, $d0, $05, $03 ; 0x113a
	db $a5, $da, $e8, $d0, $05, $03 ; 0x1140
	db $aa, $da, $f0, $d0, $05, $03 ; 0x1146
	db $00, $00, $00, $00, $00, $00 ; 0x114c
	db $60, $db, $00, $d0, $14, $02 ; 0x1152
	db $a0, $da, $e1, $d0, $05, $03 ; 0x1158
	db $a5, $da, $e7, $d0, $05, $03 ; 0x115e
	db $aa, $da, $ee, $d0, $05, $03 ; 0x1164
	db $00, $00, $00, $00, $00, $00 ; 0x116a
	db $60, $db, $00, $d0, $14, $02 ; 0x1170
	db $a0, $da, $e1, $d0, $05, $03 ; 0x1176
	db $a5, $da, $e7, $d0, $05, $03 ; 0x117c
	db $aa, $da, $ed, $d0, $05, $03 ; 0x1182
	db $00, $00, $00, $00, $00, $00 ; 0x1188
	db $60, $db, $00, $d0, $14, $02 ; 0x118e
	db $a0, $da, $e1, $d0, $05, $03 ; 0x1194
	db $a5, $da, $e7, $d0, $05, $03 ; 0x119a
	db $aa, $da, $ed, $d0, $05, $03 ; 0x11a0
	db $00, $00, $00, $00, $00, $00 ; 0x11a6
	db $60, $db, $00, $d0, $14, $02 ; 0x11ac
	db $a0, $da, $e0, $d0, $05, $03 ; 0x11b2
	db $a5, $da, $e7, $d0, $05, $03 ; 0x11b8
	db $aa, $da, $ed, $d0, $05, $03 ; 0x11be
	db $00, $00, $00, $00, $00, $00 ; 0x11c4
	db $60, $db, $00, $d0, $14, $02 ; 0x11ca
	db $a0, $da, $de, $d0, $05, $03 ; 0x11d0
	db $a5, $da, $e6, $d0, $05, $03 ; 0x11d6
	db $aa, $da, $ed, $d0, $05, $03 ; 0x11dc
	db $00, $00, $00, $00, $00, $00 ; 0x11e2
	db $80, $db, $00, $d0, $14, $01 ; 0x11e8
	db $a0, $da, $db, $d0, $05, $03 ; 0x11ee
	db $a5, $da, $e4, $d0, $05, $03 ; 0x11f4
	db $aa, $da, $ec, $d0, $05, $03 ; 0x11fa
	db $00, $00, $00, $00, $00, $00 ; 0x1200
	db $80, $db, $00, $d0, $14, $01 ; 0x1206
	db $a0, $da, $d8, $d0, $05, $03 ; 0x120c
	db $a5, $da, $e1, $d0, $05, $03 ; 0x1212
	db $aa, $da, $ea, $d0, $05, $03 ; 0x1218
	db $00, $00, $00, $00, $00, $00 ; 0x121e
	db $a5, $da, $de, $d0, $05, $03 ; 0x1224
	db $aa, $da, $e7, $d0, $05, $03 ; 0x122a
	db $00, $00, $00, $00, $00, $00 ; 0x1230
	db $a5, $da, $db, $d0, $05, $03 ; 0x1236
	db $aa, $da, $e4, $d0, $05, $03 ; 0x123c
	db $00, $00, $00, $00, $00, $00 ; 0x1242
	db $aa, $da, $e1, $d0, $05, $03 ; 0x1248
	db $00, $00, $00, $00, $00, $00 ; 0x124e
	db $aa, $da, $de, $d0, $05, $03 ; 0x1254
	db $00, $00, $00, $00, $00, $00 ; 0x125a
	db $aa, $da, $db, $d0, $05, $03 ; 0x1260
	db $00, $00, $00, $00, $00, $00 ; 0x1266
	db $aa, $da, $d8, $d0, $05, $03 ; 0x126c
	db $00, $00, $00, $00, $00, $00 ; 0x1272
	db $80, $db, $00, $d0, $14, $01 ; 0x1278
	db $a0, $da, $f5, $d0, $05, $03 ; 0x127e
	db $00, $00, $00, $00, $00, $00 ; 0x1284
	db $80, $db, $00, $d0, $14, $01 ; 0x128a
	db $a0, $da, $f2, $d0, $05, $03 ; 0x1290
	db $00, $00, $00, $00, $00, $00 ; 0x1296
	db $60, $db, $00, $d0, $14, $02 ; 0x129c
	db $a0, $da, $ef, $d0, $05, $03 ; 0x12a2
	db $00, $00, $00, $00, $00, $00 ; 0x12a8
	db $60, $db, $00, $d0, $14, $02 ; 0x12ae
	db $a0, $da, $ec, $d0, $05, $03 ; 0x12b4
	db $a5, $da, $f8, $d0, $05, $03 ; 0x12ba
	db $00, $00, $00, $00, $00, $00 ; 0x12c0
	db $60, $db, $00, $d0, $14, $02 ; 0x12c6
	db $a0, $da, $e9, $d0, $05, $03 ; 0x12cc
	db $a5, $da, $f5, $d0, $05, $03 ; 0x12d2
	db $00, $00, $00, $00, $00, $00 ; 0x12d8
	db $60, $db, $00, $d0, $14, $02 ; 0x12de
	db $a0, $da, $e6, $d0, $05, $03 ; 0x12e4
	db $a5, $da, $f2, $d0, $05, $03 ; 0x12ea
	db $00, $00, $00, $00, $00, $00 ; 0x12f0
	db $60, $db, $00, $d0, $14, $02 ; 0x12f6
	db $a0, $da, $e4, $d0, $05, $03 ; 0x12fc
	db $a5, $da, $ef, $d0, $05, $03 ; 0x1302
	db $00, $00, $00, $00, $00, $00 ; 0x1308
	db $60, $db, $00, $d0, $14, $02 ; 0x130e
	db $a0, $da, $e3, $d0, $05, $03 ; 0x1314
	db $a5, $da, $ed, $d0, $05, $03 ; 0x131a
	db $00, $00, $00, $00, $00, $00 ; 0x1320
	db $60, $db, $00, $d0, $14, $02 ; 0x1326
	db $a0, $da, $e3, $d0, $05, $03 ; 0x132c
	db $a5, $da, $ec, $d0, $05, $03 ; 0x1332
	db $00, $00, $00, $00, $00, $00 ; 0x1338
	db $60, $db, $00, $d0, $14, $02 ; 0x133e
	db $a0, $da, $e3, $d0, $05, $03 ; 0x1344
	db $a5, $da, $ec, $d0, $05, $03 ; 0x134a
	db $00, $00, $00, $00, $00, $00 ; 0x1350
	db $80, $db, $00, $d0, $14, $01 ; 0x1356
	db $a0, $da, $e2, $d0, $05, $03 ; 0x135c
	db $a5, $da, $ec, $d0, $05, $03 ; 0x1362
	db $00, $00, $00, $00, $00, $00 ; 0x1368
	db $80, $db, $00, $d0, $14, $01 ; 0x136e
	db $a0, $da, $e0, $d0, $05, $03 ; 0x1374
	db $a5, $da, $eb, $d0, $05, $03 ; 0x137a
	db $00, $00, $00, $00, $00, $00 ; 0x1380
	db $a0, $da, $dd, $d0, $05, $03 ; 0x1386
	db $a5, $da, $e9, $d0, $05, $03 ; 0x138c
	db $00, $00, $00, $00, $00, $00 ; 0x1392
	db $a0, $da, $da, $d0, $05, $03 ; 0x1398
	db $a5, $da, $e6, $d0, $05, $03 ; 0x139e
	db $00, $00, $00, $00, $00, $00 ; 0x13a4
	db $a0, $da, $d7, $d0, $05, $03 ; 0x13aa
	db $a5, $da, $e3, $d0, $05, $03 ; 0x13b0
	db $00, $00, $00, $00, $00, $00 ; 0x13b6
	db $a5, $da, $e0, $d0, $05, $03 ; 0x13bc
	db $00, $00, $00, $00, $00, $00 ; 0x13c2
	db $a5, $da, $dd, $d0, $05, $03 ; 0x13c8
	db $00, $00, $00, $00, $00, $00 ; 0x13ce
	db $a5, $da, $da, $d0, $05, $03 ; 0x13d4
	db $00, $00, $00, $00, $00, $00 ; 0x13da
	db $00, $00, $00, $00, $00, $00 ; 0x13e0
	db $80, $db, $00, $d0, $14, $01 ; 0x13e6
	db $a0, $da, $96, $d0, $05, $03 ; 0x13ec
	db $00, $00, $00, $00, $00, $00 ; 0x13f2
	db $80, $db, $00, $d0, $14, $01 ; 0x13f8
	db $a0, $da, $93, $d0, $05, $03 ; 0x13fe
	db $00, $00, $00, $00, $00, $00 ; 0x1404
	db $60, $db, $00, $d0, $14, $02 ; 0x140a
	db $a0, $da, $90, $d0, $05, $03 ; 0x1410
	db $a5, $da, $97, $d0, $05, $03 ; 0x1416
	db $aa, $da, $36, $d1, $05, $03 ; 0x141c
	db $00, $00, $00, $00, $00, $00 ; 0x1422
	db $60, $db, $00, $d0, $14, $02 ; 0x1428
	db $a0, $da, $8d, $d0, $05, $03 ; 0x142e
	db $a5, $da, $94, $d0, $05, $03 ; 0x1434
	db $aa, $da, $33, $d1, $05, $03 ; 0x143a
	db $00, $00, $00, $00, $00, $00 ; 0x1440
	db $60, $db, $00, $d0, $14, $02 ; 0x1446
	db $a0, $da, $8a, $d0, $05, $03 ; 0x144c
	db $a5, $da, $91, $d0, $05, $03 ; 0x1452
	db $aa, $da, $30, $d1, $05, $03 ; 0x1458
	db $af, $da, $37, $d1, $05, $03 ; 0x145e
	db $00, $00, $00, $00, $00, $00 ; 0x1464
	db $60, $db, $00, $d0, $14, $02 ; 0x146a
	db $a0, $da, $87, $d0, $05, $03 ; 0x1470
	db $a5, $da, $8e, $d0, $05, $03 ; 0x1476
	db $aa, $da, $2d, $d1, $05, $03 ; 0x147c
	db $af, $da, $34, $d1, $05, $03 ; 0x1482
	db $00, $00, $00, $00, $00, $00 ; 0x1488
	db $60, $db, $00, $d0, $14, $02 ; 0x148e
	db $a0, $da, $85, $d0, $05, $03 ; 0x1494
	db $a5, $da, $8c, $d0, $05, $03 ; 0x149a
	db $aa, $da, $2a, $d1, $05, $03 ; 0x14a0
	db $af, $da, $31, $d1, $05, $03 ; 0x14a6
	db $00, $00, $00, $00, $00, $00 ; 0x14ac
	db $60, $db, $00, $d0, $14, $02 ; 0x14b2
	db $a0, $da, $84, $d0, $05, $03 ; 0x14b8
	db $a5, $da, $8b, $d0, $05, $03 ; 0x14be
	db $aa, $da, $27, $d1, $05, $03 ; 0x14c4
	db $af, $da, $2e, $d1, $05, $03 ; 0x14ca
	db $00, $00, $00, $00, $00, $00 ; 0x14d0
	db $60, $db, $00, $d0, $14, $02 ; 0x14d6
	db $a0, $da, $84, $d0, $05, $03 ; 0x14dc
	db $a5, $da, $8b, $d0, $05, $03 ; 0x14e2
	db $aa, $da, $25, $d1, $05, $03 ; 0x14e8
	db $af, $da, $2c, $d1, $05, $03 ; 0x14ee
	db $00, $00, $00, $00, $00, $00 ; 0x14f4
	db $60, $db, $00, $d0, $14, $02 ; 0x14fa
	db $a0, $da, $84, $d0, $05, $03 ; 0x1500
	db $a5, $da, $8b, $d0, $05, $03 ; 0x1506
	db $aa, $da, $24, $d1, $05, $03 ; 0x150c
	db $af, $da, $2b, $d1, $05, $03 ; 0x1512
	db $00, $00, $00, $00, $00, $00 ; 0x1518
	db $00, $00, $00, $00, $00, $00 ; 0x151e
	db $00, $00, $00, $00, $00, $00 ; 0x1524
	db $00, $00, $00, $00, $00, $00 ; 0x152a
	db $00, $00, $00, $00, $00, $00 ; 0x1530
	db $60, $db, $00, $d0, $14, $02 ; 0x1536
	db $a0, $da, $84, $d0, $05, $03 ; 0x153c
	db $a5, $da, $8b, $d0, $05, $03 ; 0x1542
	db $aa, $da, $24, $d1, $05, $03 ; 0x1548
	db $af, $da, $2b, $d1, $05, $03 ; 0x154e
	db $00, $00, $00, $00, $00, $00 ; 0x1554
	db $60, $db, $00, $d0, $14, $02 ; 0x155a
	db $a0, $da, $83, $d0, $05, $03 ; 0x1560
	db $a5, $da, $8a, $d0, $05, $03 ; 0x1566
	db $aa, $da, $24, $d1, $05, $03 ; 0x156c
	db $af, $da, $2b, $d1, $05, $03 ; 0x1572
	db $00, $00, $00, $00, $00, $00 ; 0x1578
	db $80, $db, $00, $d0, $14, $01 ; 0x157e
	db $a0, $da, $81, $d0, $05, $03 ; 0x1584
	db $a5, $da, $88, $d0, $05, $03 ; 0x158a
	db $aa, $da, $24, $d1, $05, $03 ; 0x1590
	db $af, $da, $2b, $d1, $05, $03 ; 0x1596
	db $00, $00, $00, $00, $00, $00 ; 0x159c
	db $80, $db, $00, $d0, $14, $01 ; 0x15a2
	db $a0, $da, $7e, $d0, $05, $03 ; 0x15a8
	db $a5, $da, $85, $d0, $05, $03 ; 0x15ae
	db $aa, $da, $23, $d1, $05, $03 ; 0x15b4
	db $af, $da, $2a, $d1, $05, $03 ; 0x15ba
	db $00, $00, $00, $00, $00, $00 ; 0x15c0
	db $a0, $da, $7b, $d0, $05, $03 ; 0x15c6
	db $a5, $da, $82, $d0, $05, $03 ; 0x15cc
	db $aa, $da, $21, $d1, $05, $03 ; 0x15d2
	db $af, $da, $28, $d1, $05, $03 ; 0x15d8
	db $00, $00, $00, $00, $00, $00 ; 0x15de
	db $a0, $da, $78, $d0, $05, $03 ; 0x15e4
	db $a5, $da, $7f, $d0, $05, $03 ; 0x15ea
	db $aa, $da, $1e, $d1, $05, $03 ; 0x15f0
	db $af, $da, $25, $d1, $05, $03 ; 0x15f6
	db $00, $00, $00, $00, $00, $00 ; 0x15fc
	db $a5, $da, $7c, $d0, $05, $03 ; 0x1602
	db $aa, $da, $1b, $d1, $05, $03 ; 0x1608
	db $af, $da, $22, $d1, $05, $03 ; 0x160e
	db $00, $00, $00, $00, $00, $00 ; 0x1614
	db $af, $da, $1f, $d1, $05, $03 ; 0x161a
	db $00, $00, $00, $00, $00, $00 ; 0x1620
	db $af, $da, $1c, $d1, $05, $03 ; 0x1626
	db $00, $00, $00, $00, $00, $00 ; 0x162c
	db $00, $00, $00, $00, $00, $00 ; 0x1632
	db $00, $00, $00, $00, $00, $00 ; 0x1638
	db $00, $00, $00, $00, $00, $00 ; 0x163e
	db $00, $00, $00, $00, $00, $00 ; 0x1644
	db $00, $00, $00, $00, $00, $00 ; 0x164a
	db $80, $db, $00, $d0, $14, $01 ; 0x1650
	db $a0, $da, $73, $d0, $05, $03 ; 0x1656
	db $00, $00, $00, $00, $00, $00 ; 0x165c
	db $80, $db, $00, $d0, $14, $01 ; 0x1662
	db $a0, $da, $70, $d0, $05, $03 ; 0x1668
	db $a5, $da, $76, $d0, $05, $03 ; 0x166e
	db $00, $00, $00, $00, $00, $00 ; 0x1674
	db $60, $db, $00, $d0, $14, $02 ; 0x167a
	db $a0, $da, $6d, $d0, $05, $03 ; 0x1680
	db $a5, $da, $73, $d0, $05, $03 ; 0x1686
	db $af, $da, $f3, $d0, $05, $03 ; 0x168c
	db $b4, $da, $f9, $d0, $05, $03 ; 0x1692
	db $00, $00, $00, $00, $00, $00 ; 0x1698
	db $60, $db, $00, $d0, $14, $02 ; 0x169e
	db $a0, $da, $6a, $d0, $05, $03 ; 0x16a4
	db $a5, $da, $70, $d0, $05, $03 ; 0x16aa
	db $aa, $da, $76, $d0, $05, $03 ; 0x16b0
	db $af, $da, $f0, $d0, $05, $03 ; 0x16b6
	db $b4, $da, $f6, $d0, $05, $03 ; 0x16bc
	db $00, $00, $00, $00, $00, $00 ; 0x16c2
	db $60, $db, $00, $d0, $14, $02 ; 0x16c8
	db $a0, $da, $67, $d0, $05, $03 ; 0x16ce
	db $a5, $da, $6d, $d0, $05, $03 ; 0x16d4
	db $aa, $da, $73, $d0, $05, $03 ; 0x16da
	db $af, $da, $ed, $d0, $05, $03 ; 0x16e0
	db $b4, $da, $f3, $d0, $05, $03 ; 0x16e6
	db $b9, $da, $f9, $d0, $05, $03 ; 0x16ec
	db $54, $db, $73, $d1, $05, $03 ; 0x16f2
	db $00, $00, $00, $00, $00, $00 ; 0x16f8
	db $60, $db, $00, $d0, $14, $02 ; 0x16fe
	db $a0, $da, $64, $d0, $05, $03 ; 0x1704
	db $a5, $da, $6a, $d0, $05, $03 ; 0x170a
	db $aa, $da, $70, $d0, $05, $03 ; 0x1710
	db $af, $da, $ea, $d0, $05, $03 ; 0x1716
	db $b4, $da, $f0, $d0, $05, $03 ; 0x171c
	db $b9, $da, $f6, $d0, $05, $03 ; 0x1722
	db $54, $db, $70, $d1, $05, $03 ; 0x1728
	db $59, $db, $76, $d1, $05, $03 ; 0x172e
	db $00, $00, $00, $00, $00, $00 ; 0x1734
	db $60, $db, $00, $d0, $14, $02 ; 0x173a
	db $a0, $da, $62, $d0, $05, $03 ; 0x1740
	db $a5, $da, $68, $d0, $05, $03 ; 0x1746
	db $aa, $da, $6e, $d0, $05, $03 ; 0x174c
	db $af, $da, $e7, $d0, $05, $03 ; 0x1752
	db $b4, $da, $ed, $d0, $05, $03 ; 0x1758
	db $b9, $da, $f3, $d0, $05, $03 ; 0x175e
	db $54, $db, $6d, $d1, $05, $03 ; 0x1764
	db $59, $db, $73, $d1, $05, $03 ; 0x176a
	db $5b, $da, $79, $d1, $05, $03 ; 0x1770
	db $00, $00, $00, $00, $00, $00 ; 0x1776
	db $60, $db, $00, $d0, $14, $02 ; 0x177c
	db $a0, $da, $61, $d0, $05, $03 ; 0x1782
	db $a5, $da, $67, $d0, $05, $03 ; 0x1788
	db $aa, $da, $6d, $d0, $05, $03 ; 0x178e
	db $af, $da, $e4, $d0, $05, $03 ; 0x1794
	db $b4, $da, $ea, $d0, $05, $03 ; 0x179a
	db $b9, $da, $f0, $d0, $05, $03 ; 0x17a0
	db $54, $db, $6a, $d1, $05, $03 ; 0x17a6
	db $59, $db, $70, $d1, $05, $03 ; 0x17ac
	db $5b, $da, $76, $d1, $05, $03 ; 0x17b2
	db $00, $00, $00, $00, $00, $00 ; 0x17b8
	db $60, $db, $00, $d0, $14, $02 ; 0x17be
	db $a0, $da, $61, $d0, $05, $03 ; 0x17c4
	db $a5, $da, $67, $d0, $05, $03 ; 0x17ca
	db $aa, $da, $6d, $d0, $05, $03 ; 0x17d0
	db $af, $da, $e2, $d0, $05, $03 ; 0x17d6
	db $b4, $da, $e8, $d0, $05, $03 ; 0x17dc
	db $b9, $da, $ee, $d0, $05, $03 ; 0x17e2
	db $54, $db, $67, $d1, $05, $03 ; 0x17e8
	db $59, $db, $6d, $d1, $05, $03 ; 0x17ee
	db $5b, $da, $73, $d1, $05, $03 ; 0x17f4
	db $00, $00, $00, $00, $00, $00 ; 0x17fa
	db $60, $db, $00, $d0, $14, $02 ; 0x1800
	db $a0, $da, $61, $d0, $05, $03 ; 0x1806
	db $a5, $da, $67, $d0, $05, $03 ; 0x180c
	db $aa, $da, $6d, $d0, $05, $03 ; 0x1812
	db $af, $da, $e1, $d0, $05, $03 ; 0x1818
	db $b4, $da, $e7, $d0, $05, $03 ; 0x181e
	db $b9, $da, $ed, $d0, $05, $03 ; 0x1824
	db $54, $db, $64, $d1, $05, $03 ; 0x182a
	db $59, $db, $6a, $d1, $05, $03 ; 0x1830
	db $5b, $da, $70, $d1, $05, $03 ; 0x1836
	db $00, $00, $00, $00, $00, $00 ; 0x183c
	db $60, $db, $00, $d0, $14, $02 ; 0x1842
	db $a0, $da, $61, $d0, $05, $03 ; 0x1848
	db $a5, $da, $67, $d0, $05, $03 ; 0x184e
	db $aa, $da, $6d, $d0, $05, $03 ; 0x1854
	db $af, $da, $e1, $d0, $05, $03 ; 0x185a
	db $b4, $da, $e7, $d0, $05, $03 ; 0x1860
	db $b9, $da, $ed, $d0, $05, $03 ; 0x1866
	db $54, $db, $62, $d1, $05, $03 ; 0x186c
	db $59, $db, $68, $d1, $05, $03 ; 0x1872
	db $5b, $da, $6e, $d1, $05, $03 ; 0x1878
	db $00, $00, $00, $00, $00, $00 ; 0x187e
	db $60, $db, $00, $d0, $14, $02 ; 0x1884
	db $a0, $da, $61, $d0, $05, $03 ; 0x188a
	db $a5, $da, $67, $d0, $05, $03 ; 0x1890
	db $aa, $da, $6d, $d0, $05, $03 ; 0x1896
	db $af, $da, $e1, $d0, $05, $03 ; 0x189c
	db $b4, $da, $e7, $d0, $05, $03 ; 0x18a2
	db $b9, $da, $ed, $d0, $05, $03 ; 0x18a8
	db $54, $db, $61, $d1, $05, $03 ; 0x18ae
	db $59, $db, $67, $d1, $05, $03 ; 0x18b4
	db $5b, $da, $6d, $d1, $05, $03 ; 0x18ba
	db $00, $00, $00, $00, $00, $00 ; 0x18c0
	db $60, $db, $00, $d0, $14, $02 ; 0x18c6
	db $a0, $da, $60, $d0, $05, $03 ; 0x18cc
	db $a5, $da, $66, $d0, $05, $03 ; 0x18d2
	db $aa, $da, $6c, $d0, $05, $03 ; 0x18d8
	db $af, $da, $e1, $d0, $05, $03 ; 0x18de
	db $b4, $da, $e7, $d0, $05, $03 ; 0x18e4
	db $b9, $da, $ed, $d0, $05, $03 ; 0x18ea
	db $54, $db, $61, $d1, $05, $03 ; 0x18f0
	db $59, $db, $67, $d1, $05, $03 ; 0x18f6
	db $5b, $da, $6d, $d1, $05, $03 ; 0x18fc
	db $00, $00, $00, $00, $00, $00 ; 0x1902
	db $60, $db, $00, $d0, $14, $02 ; 0x1908
	db $a0, $da, $5e, $d0, $05, $03 ; 0x190e
	db $a5, $da, $64, $d0, $05, $03 ; 0x1914
	db $aa, $da, $6a, $d0, $05, $03 ; 0x191a
	db $af, $da, $e0, $d0, $05, $03 ; 0x1920
	db $b4, $da, $e6, $d0, $05, $03 ; 0x1926
	db $b9, $da, $ec, $d0, $05, $03 ; 0x192c
	db $54, $db, $61, $d1, $05, $03 ; 0x1932
	db $59, $db, $67, $d1, $05, $03 ; 0x1938
	db $5b, $da, $6d, $d1, $05, $03 ; 0x193e
	db $00, $00, $00, $00, $00, $00 ; 0x1944
	db $60, $db, $00, $d0, $14, $02 ; 0x194a
	db $a0, $da, $5b, $d0, $05, $03 ; 0x1950
	db $a5, $da, $61, $d0, $05, $03 ; 0x1956
	db $aa, $da, $67, $d0, $05, $03 ; 0x195c
	db $af, $da, $de, $d0, $05, $03 ; 0x1962
	db $b4, $da, $e4, $d0, $05, $03 ; 0x1968
	db $b9, $da, $ea, $d0, $05, $03 ; 0x196e
	db $54, $db, $60, $d1, $05, $03 ; 0x1974
	db $59, $db, $66, $d1, $05, $03 ; 0x197a
	db $5b, $da, $6c, $d1, $05, $03 ; 0x1980
	db $00, $00, $00, $00, $00, $00 ; 0x1986
	db $80, $db, $00, $d0, $14, $01 ; 0x198c
	db $a0, $da, $58, $d0, $05, $03 ; 0x1992
	db $a5, $da, $5e, $d0, $05, $03 ; 0x1998
	db $aa, $da, $64, $d0, $05, $03 ; 0x199e
	db $af, $da, $db, $d0, $05, $03 ; 0x19a4
	db $b4, $da, $e1, $d0, $05, $03 ; 0x19aa
	db $b9, $da, $e7, $d0, $05, $03 ; 0x19b0
	db $54, $db, $5e, $d1, $05, $03 ; 0x19b6
	db $59, $db, $64, $d1, $05, $03 ; 0x19bc
	db $5b, $da, $6a, $d1, $05, $03 ; 0x19c2
	db $00, $00, $00, $00, $00, $00 ; 0x19c8
	db $a5, $da, $5b, $d0, $05, $03 ; 0x19ce
	db $aa, $da, $61, $d0, $05, $03 ; 0x19d4
	db $af, $da, $d8, $d0, $05, $03 ; 0x19da
	db $b4, $da, $de, $d0, $05, $03 ; 0x19e0
	db $b9, $da, $e4, $d0, $05, $03 ; 0x19e6
	db $54, $db, $5b, $d1, $05, $03 ; 0x19ec
	db $59, $db, $61, $d1, $05, $03 ; 0x19f2
	db $5b, $da, $67, $d1, $05, $03 ; 0x19f8
	db $00, $00, $00, $00, $00, $00 ; 0x19fe
	db $aa, $da, $5e, $d0, $05, $03 ; 0x1a04
	db $b4, $da, $db, $d0, $05, $03 ; 0x1a0a
	db $b9, $da, $e1, $d0, $05, $03 ; 0x1a10
	db $54, $db, $58, $d1, $05, $03 ; 0x1a16
	db $59, $db, $5e, $d1, $05, $03 ; 0x1a1c
	db $5b, $da, $64, $d1, $05, $03 ; 0x1a22
	db $00, $00, $00, $00, $00, $00 ; 0x1a28
	db $b9, $da, $de, $d0, $05, $03 ; 0x1a2e
	db $59, $db, $5b, $d1, $05, $03 ; 0x1a34
	db $5b, $da, $61, $d1, $05, $03 ; 0x1a3a
	db $00, $00, $00, $00, $00, $00 ; 0x1a40
	db $5b, $da, $5e, $d1, $05, $03 ; 0x1a46
	db $00, $00, $00, $00, $00, $00 ; 0x1a4c
	db $5b, $da, $5b, $d1, $05, $03 ; 0x1a52
	db $00, $00, $00, $00, $00, $00 ; 0x1a58
	db $5b, $da, $58, $d1, $05, $03 ; 0x1a5e
	db $00, $00, $00, $00, $00, $00 ; 0x1a64
	db $00, $00, $00, $00, $00, $00 ; 0x1a6a
	db $80, $db, $00, $d0, $14, $01 ; 0x1a70
	db $40, $da, $91, $d0, $03, $03 ; 0x1a76
	db $00, $00, $00, $00, $00, $00 ; 0x1a7c
	db $80, $db, $00, $d0, $14, $01 ; 0x1a82
	db $40, $da, $8e, $d0, $03, $03 ; 0x1a88
	db $00, $00, $00, $00, $00, $00 ; 0x1a8e
	db $80, $db, $00, $d0, $14, $01 ; 0x1a94
	db $40, $da, $8b, $d0, $03, $03 ; 0x1a9a
	db $43, $da, $91, $d0, $03, $03 ; 0x1aa0
	db $00, $00, $00, $00, $00, $00 ; 0x1aa6
	db $60, $db, $00, $d0, $14, $02 ; 0x1aac
	db $40, $da, $88, $d0, $03, $03 ; 0x1ab2
	db $43, $da, $8e, $d0, $03, $03 ; 0x1ab8
	db $46, $da, $94, $d0, $03, $03 ; 0x1abe
	db $00, $00, $00, $00, $00, $00 ; 0x1ac4
	db $60, $db, $00, $d0, $14, $02 ; 0x1aca
	db $40, $da, $85, $d0, $03, $03 ; 0x1ad0
	db $43, $da, $8b, $d0, $03, $03 ; 0x1ad6
	db $46, $da, $91, $d0, $03, $03 ; 0x1adc
	db $49, $da, $34, $d1, $03, $03 ; 0x1ae2
	db $00, $00, $00, $00, $00, $00 ; 0x1ae8
	db $60, $db, $00, $d0, $14, $02 ; 0x1aee
	db $40, $da, $83, $d0, $03, $03 ; 0x1af4
	db $43, $da, $89, $d0, $03, $03 ; 0x1afa
	db $46, $da, $8f, $d0, $03, $03 ; 0x1b00
	db $49, $da, $31, $d1, $03, $03 ; 0x1b06
	db $4f, $da, $37, $d1, $03, $03 ; 0x1b0c
	db $00, $00, $00, $00, $00, $00 ; 0x1b12
	db $60, $db, $00, $d0, $14, $02 ; 0x1b18
	db $40, $da, $82, $d0, $03, $03 ; 0x1b1e
	db $43, $da, $88, $d0, $03, $03 ; 0x1b24
	db $46, $da, $8e, $d0, $03, $03 ; 0x1b2a
	db $49, $da, $2e, $d1, $03, $03 ; 0x1b30
	db $4f, $da, $34, $d1, $03, $03 ; 0x1b36
	db $00, $00, $00, $00, $00, $00 ; 0x1b3c
	db $60, $db, $00, $d0, $14, $02 ; 0x1b42
	db $40, $da, $82, $d0, $03, $03 ; 0x1b48
	db $43, $da, $88, $d0, $03, $03 ; 0x1b4e
	db $46, $da, $8e, $d0, $03, $03 ; 0x1b54
	db $49, $da, $2b, $d1, $03, $03 ; 0x1b5a
	db $4f, $da, $31, $d1, $03, $03 ; 0x1b60
	db $00, $00, $00, $00, $00, $00 ; 0x1b66
	db $60, $db, $00, $d0, $14, $02 ; 0x1b6c
	db $40, $da, $82, $d0, $03, $03 ; 0x1b72
	db $43, $da, $88, $d0, $03, $03 ; 0x1b78
	db $46, $da, $8e, $d0, $03, $03 ; 0x1b7e
	db $49, $da, $28, $d1, $03, $03 ; 0x1b84
	db $4f, $da, $2e, $d1, $03, $03 ; 0x1b8a
	db $00, $00, $00, $00, $00, $00 ; 0x1b90
	db $60, $db, $00, $d0, $14, $02 ; 0x1b96
	db $40, $da, $82, $d0, $03, $03 ; 0x1b9c
	db $43, $da, $88, $d0, $03, $03 ; 0x1ba2
	db $46, $da, $8e, $d0, $03, $03 ; 0x1ba8
	db $49, $da, $26, $d1, $03, $03 ; 0x1bae
	db $4f, $da, $2c, $d1, $03, $03 ; 0x1bb4
	db $00, $00, $00, $00, $00, $00 ; 0x1bba
	db $60, $db, $00, $d0, $14, $02 ; 0x1bc0
	db $40, $da, $82, $d0, $03, $03 ; 0x1bc6
	db $43, $da, $88, $d0, $03, $03 ; 0x1bcc
	db $46, $da, $8e, $d0, $03, $03 ; 0x1bd2
	db $49, $da, $25, $d1, $03, $03 ; 0x1bd8
	db $4f, $da, $2b, $d1, $03, $03 ; 0x1bde
	db $00, $00, $00, $00, $00, $00 ; 0x1be4
	db $60, $db, $00, $d0, $14, $02 ; 0x1bea
	db $40, $da, $81, $d0, $03, $03 ; 0x1bf0
	db $43, $da, $87, $d0, $03, $03 ; 0x1bf6
	db $46, $da, $8d, $d0, $03, $03 ; 0x1bfc
	db $49, $da, $25, $d1, $03, $03 ; 0x1c02
	db $4f, $da, $2b, $d1, $03, $03 ; 0x1c08
	db $00, $00, $00, $00, $00, $00 ; 0x1c0e
	db $60, $db, $00, $d0, $14, $02 ; 0x1c14
	db $40, $da, $7f, $d0, $03, $03 ; 0x1c1a
	db $43, $da, $85, $d0, $03, $03 ; 0x1c20
	db $46, $da, $8b, $d0, $03, $03 ; 0x1c26
	db $49, $da, $25, $d1, $03, $03 ; 0x1c2c
	db $4f, $da, $2b, $d1, $03, $03 ; 0x1c32
	db $00, $00, $00, $00, $00, $00 ; 0x1c38
	db $80, $db, $00, $d0, $14, $01 ; 0x1c3e
	db $40, $da, $7c, $d0, $03, $03 ; 0x1c44
	db $43, $da, $82, $d0, $03, $03 ; 0x1c4a
	db $46, $da, $88, $d0, $03, $03 ; 0x1c50
	db $49, $da, $24, $d1, $03, $03 ; 0x1c56
	db $4f, $da, $2a, $d1, $03, $03 ; 0x1c5c
	db $00, $00, $00, $00, $00, $00 ; 0x1c62
	db $80, $db, $00, $d0, $14, $01 ; 0x1c68
	db $40, $da, $79, $d0, $03, $03 ; 0x1c6e
	db $43, $da, $7f, $d0, $03, $03 ; 0x1c74
	db $46, $da, $85, $d0, $03, $03 ; 0x1c7a
	db $49, $da, $22, $d1, $03, $03 ; 0x1c80
	db $4f, $da, $28, $d1, $03, $03 ; 0x1c86
	db $00, $00, $00, $00, $00, $00 ; 0x1c8c
	db $43, $da, $7c, $d0, $03, $03 ; 0x1c92
	db $46, $da, $82, $d0, $03, $03 ; 0x1c98
	db $49, $da, $1f, $d1, $03, $03 ; 0x1c9e
	db $4f, $da, $25, $d1, $03, $03 ; 0x1ca4
	db $00, $00, $00, $00, $00, $00 ; 0x1caa
	db $46, $da, $7f, $d0, $03, $03 ; 0x1cb0
	db $49, $da, $1c, $d1, $03, $03 ; 0x1cb6
	db $4f, $da, $22, $d1, $03, $03 ; 0x1cbc
	db $00, $00, $00, $00, $00, $00 ; 0x1cc2
	db $49, $da, $19, $d1, $03, $03 ; 0x1cc8
	db $4f, $da, $1f, $d1, $03, $03 ; 0x1cce
	db $00, $00, $00, $00, $00, $00 ; 0x1cd4
	db $4f, $da, $1c, $d1, $03, $03 ; 0x1cda
	db $00, $00, $00, $00, $00, $00 ; 0x1ce0
Func_39_6dc2:
	push af ; $6dc2
	push bc ; $6dc3
	push de ; $6dc4
	push hl ; $6dc5
	ld d, c ; $6dc6
	ld e, b ; $6dc7
	ld b, $03 ; $6dc8
	ld c, $03 ; $6dca
	ld a, d ; $6dcc
	or a, a ; $6dcd
	jr z, Label_39_6dd4 ; $6dce
	ld h, $0c ; $6dd0
	jr Label_39_6dd6 ; $6dd2
Label_39_6dd4:
	ld h, $0d ; $6dd4
Label_39_6dd6:
	push hl ; $6dd6
	ld hl, $6ded ; $6dd7
	ld a, e ; $6dda
	add a, a ; $6ddb
	add a, l ; $6ddc
	ld l, a ; $6ddd
	jr nc, Label_39_6de1 ; $6dde
	inc h ; $6de0
Label_39_6de1:
	ld a, [hl+] ; $6de1
	ld d, [hl] ; $6de2
	ld e, a ; $6de3
	pop hl ; $6de4
	farcall FarPtr_FillTilemapRect ; $6de5
	pop hl ; $6de8
	pop de ; $6de9
	pop bc ; $6dea
	pop af ; $6deb
	ret ; $6dec
	; $6ded, 12 bytes (records:2)
	dw $d482 ; record 0
	dw $d488 ; record 1
	dw $d48e ; record 2
	dw $d525 ; record 3
	dw $d52b ; record 4
	dw $d52b ; record 5
Func_39_6df9:
	ld a, [wMenuCursorY] ; $6df9
	or a, a ; $6dfc
	jr nz, Label_39_6e64 ; $6dfd
	ld a, [wMenuInputPressed] ; $6dff
	bit 4, a ; $6e02
	jr nz, Label_39_6e16 ; $6e04
	bit 5, a ; $6e06
	jr nz, Label_39_6e30 ; $6e08
	bit 6, a ; $6e0a
	jr nz, Label_39_6e49 ; $6e0c
	bit 7, a ; $6e0e
	jr nz, Label_39_6e49 ; $6e10
	xor a, a ; $6e12
	jp Label_39_6eb9 ; $6e13
Label_39_6e16:
	ld a, [wMenuCursorX] ; $6e16
	inc a ; $6e19
	add a, a ; $6e1a
	jr nc, Label_39_6e22 ; $6e1b
	ld a, $03 ; $6e1d
	dec a ; $6e1f
	jr Label_39_6e28 ; $6e20
Label_39_6e22:
	rra ; $6e22
	cp a, $03 ; $6e23
	jr c, Label_39_6e28 ; $6e25
	xor a, a ; $6e27
Label_39_6e28:
	ld [wMenuCursorX], a ; $6e28
	ld a, $01 ; $6e2b
	jp Label_39_6eb9 ; $6e2d
Label_39_6e30:
	ld a, [wMenuCursorX] ; $6e30
	dec a ; $6e33
	add a, a ; $6e34
	jr nc, Label_39_6e3c ; $6e35
	ld a, $03 ; $6e37
	dec a ; $6e39
	jr Label_39_6e42 ; $6e3a
Label_39_6e3c:
	rra ; $6e3c
	cp a, $03 ; $6e3d
	jr c, Label_39_6e42 ; $6e3f
	xor a, a ; $6e41
Label_39_6e42:
	ld [wMenuCursorX], a ; $6e42
	ld a, $01 ; $6e45
	jr Label_39_6eb9 ; $6e47
Label_39_6e49:
	ld a, [wMenuCursorX] ; $6e49
	ld hl, $6eba ; $6e4c
	add a, l ; $6e4f
	ld l, a ; $6e50
	jr nc, Label_39_6e54 ; $6e51
	inc h ; $6e53
Label_39_6e54:
	ld a, [hl] ; $6e54
	ld [wMenuCursorX], a ; $6e55
	ld a, [wMenuCursorY] ; $6e58
	xor a, $01 ; $6e5b
	ld [wMenuCursorY], a ; $6e5d
	ld a, $01 ; $6e60
	jr Label_39_6eb9 ; $6e62
Label_39_6e64:
	ld a, [wMenuInputPressed] ; $6e64
	bit 4, a ; $6e67
	jr nz, Label_39_6e7a ; $6e69
	bit 5, a ; $6e6b
	jr nz, Label_39_6e8c ; $6e6d
	bit 6, a ; $6e6f
	jr nz, Label_39_6e9e ; $6e71
	bit 7, a ; $6e73
	jr nz, Label_39_6e9e ; $6e75
	xor a, a ; $6e77
	jr Label_39_6eb9 ; $6e78
Label_39_6e7a:
	ld a, [wMenuCursorX] ; $6e7a
	or a, a ; $6e7d
	jr z, Label_39_6e83 ; $6e7e
	xor a, a ; $6e80
	jr Label_39_6e85 ; $6e81
Label_39_6e83:
	ld a, $02 ; $6e83
Label_39_6e85:
	ld [wMenuCursorX], a ; $6e85
	ld a, $01 ; $6e88
	jr Label_39_6eb9 ; $6e8a
Label_39_6e8c:
	ld a, [wMenuCursorX] ; $6e8c
	or a, a ; $6e8f
	jr z, Label_39_6e95 ; $6e90
	xor a, a ; $6e92
	jr Label_39_6e97 ; $6e93
Label_39_6e95:
	ld a, $02 ; $6e95
Label_39_6e97:
	ld [wMenuCursorX], a ; $6e97
	ld a, $01 ; $6e9a
	jr Label_39_6eb9 ; $6e9c
Label_39_6e9e:
	ld a, [wMenuCursorX] ; $6e9e
	ld hl, $6ebd ; $6ea1
	add a, l ; $6ea4
	ld l, a ; $6ea5
	jr nc, Label_39_6ea9 ; $6ea6
	inc h ; $6ea8
Label_39_6ea9:
	ld a, [hl] ; $6ea9
	ld [wMenuCursorX], a ; $6eaa
	ld a, [wMenuCursorY] ; $6ead
	xor a, $01 ; $6eb0
	ld [wMenuCursorY], a ; $6eb2
	ld a, $01 ; $6eb5
	jr Label_39_6eb9 ; $6eb7
Label_39_6eb9:
	ret ; $6eb9
	INCBIN "data/bank_039/d_6eba.bin" ; $6eba, 6 bytes
Func_39_6ec0:
	push af ; $6ec0
	push bc ; $6ec1
	push de ; $6ec2
	push hl ; $6ec3
	ld hl, $cb64 ; $6ec4
	ld bc, $0007 ; $6ec7
	call ClearBytes ; $6eca
	xor a, a ; $6ecd
	ld [$cb6b], a ; $6ece
	ld [$cb6c], a ; $6ed1
	pop hl ; $6ed4
	pop de ; $6ed5
	pop bc ; $6ed6
	pop af ; $6ed7
	ld a, $08 ; $6ed8
	ld [$cb6c], a ; $6eda
	ld a, $00 ; $6edd
	ld [$cb6b], a ; $6edf
	ld a, c ; $6ee2
	or a, a ; $6ee3
	jr nz, Label_39_6ef9 ; $6ee4
	push bc ; $6ee6
	ld b, $49 ; $6ee7
	ld c, $14 ; $6ee9
	farcall FarPtr_LoadCompressedTileBlock ; $6eeb
	pop bc ; $6eee
	ld hl, $6f08 ; $6eef
	ld d, b ; $6ef2
	ld e, $01 ; $6ef3
	call LoadPaletteShadow ; $6ef5
	ret ; $6ef8
Label_39_6ef9:
	push bc ; $6ef9
	ld b, $14 ; $6efa
	ld c, $18 ; $6efc
	farcall FarPtr_LoadCompressedTileBlock ; $6efe
	pop bc ; $6f01
	ld c, $0c ; $6f02
	farcall FarPtr_LoadIndexedPalette ; $6f04
	ret ; $6f07
	INCBIN "data/bank_039/d_6f08.bin" ; $6f08, 8 bytes
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
Label_39_6f2c:
	ld a, [hl] ; $6f2c
	or a, a ; $6f2d
	jr z, Label_39_6f34 ; $6f2e
	inc b ; $6f30
	inc hl ; $6f31
	jr Label_39_6f2c ; $6f32
Label_39_6f34:
	dec hl ; $6f34
Label_39_6f35:
	ld a, [hl-] ; $6f35
	sub a, $30 ; $6f36
	ld c, a ; $6f38
	call DrawDigitSprite_39 ; $6f39
	ld a, d ; $6f3c
	sub a, $08 ; $6f3d
	ld d, a ; $6f3f
	dec b ; $6f40
	jr z, Label_39_6f45 ; $6f41
	jr Label_39_6f35 ; $6f43
Label_39_6f45:
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
	ld a, [$cb6b] ; $6f53
	ld b, a ; $6f56
	ld a, c ; $6f57
	add a, a ; $6f58
	add a, b ; $6f59
	ld c, a ; $6f5a
	ld a, [$cb6c] ; $6f5b
	ld b, a ; $6f5e
	call QueueSprite ; $6f5f
	pop hl ; $6f62
	pop de ; $6f63
	pop bc ; $6f64
	pop af ; $6f65
	ret ; $6f66
Func_39_6f67:
	ldh a, [hWramBank] ; $6f67
	push af ; $6f69
	wram_bank $01 ; $6f6a
	ld a, [$cb71] ; $6f70
	or a, a ; $6f73
	jr nz, Label_39_6fc0 ; $6f74
	ldh a, [hInputRisingEdge] ; $6f76
	bit 0, a ; $6f78
	jr z, Label_39_6fa5 ; $6f7a
	ld c, $00 ; $6f7c
Label_39_6f7e:
	ld hl, $d000 ; $6f7e
	ld a, c ; $6f81
	add a, l ; $6f82
	ld l, a ; $6f83
	jr nc, Label_39_6f87 ; $6f84
	inc h ; $6f86
Label_39_6f87:
	ld d, [hl] ; $6f87
	ld a, c ; $6f88
	ld hl, $6fc6 ; $6f89
	add a, l ; $6f8c
	ld l, a ; $6f8d
	jr nc, Label_39_6f91 ; $6f8e
	inc h ; $6f90
Label_39_6f91:
	ld a, [hl] ; $6f91
	cp a, d ; $6f92
	jr nz, Label_39_6fc0 ; $6f93
	inc c ; $6f95
	ld a, c ; $6f96
	cp a, $20 ; $6f97
	jr nz, Label_39_6f7e ; $6f99
	call Func_39_7003 ; $6f9b
	ld a, $01 ; $6f9e
	ld [$cb71], a ; $6fa0
	jr Label_39_6fc0 ; $6fa3
Label_39_6fa5:
	ldh a, [hInputRisingEdge] ; $6fa5
	or a, a ; $6fa7
	jr z, Label_39_6fc0 ; $6fa8
	ld b, a ; $6faa
	ld a, [$cb1a] ; $6fab
	and a, $1f ; $6fae
	ld hl, $d000 ; $6fb0
	add a, l ; $6fb3
	ld l, a ; $6fb4
	jr nc, Label_39_6fb8 ; $6fb5
	inc h ; $6fb7
Label_39_6fb8:
	ld [hl], b ; $6fb8
	ld a, [$cb1a] ; $6fb9
	inc a ; $6fbc
	ld [$cb1a], a ; $6fbd
Label_39_6fc0:
	pop af ; $6fc0
	wram_bank ; $6fc1
	ret ; $6fc5
	INCBIN "data/bank_039/d_6fc6.bin" ; $6fc6, 33 bytes
Func_39_6fe7:
	ldh a, [hWramBank] ; $6fe7
	push af ; $6fe9
	wram_bank $01 ; $6fea
	xor a, a ; $6ff0
	ld [$cb1a], a ; $6ff1
	ld hl, $d000 ; $6ff4
	ld bc, $0020 ; $6ff7
	call ClearBytes ; $6ffa
	pop af ; $6ffd
	wram_bank ; $6ffe
	ret ; $7002
Func_39_7003:
	sound $65 ; $7003
	farcall FarPtr_ApplyUnlockEverythingCheat ; $7005
	ret ; $7008
Lz_39_7009:
	INCBIN "data/bank_039/lz_7009.bin" ; $7009, 178 bytes
Lz_39_70bb:
	INCBIN "data/bank_039/lz_70bb.bin" ; $70bb, 194 bytes
Lz_39_717d:
	INCBIN "data/bank_039/lz_717d.bin" ; $717d, 57 bytes
Lz_39_71b6:
	INCBIN "data/bank_039/lz_71b6.bin" ; $71b6, 50 bytes
Lz_39_71e8:
	INCBIN "data/bank_039/lz_71e8.bin" ; $71e8, 59 bytes
Lz_39_7223:
	INCBIN "data/bank_039/lz_7223.bin" ; $7223, 58 bytes
Lz_39_725d:
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
Func_39_745a:
	ld a, b ; $745a
	ld [hl+], a ; $745b
	inc b ; $745c
	dec c ; $745d
	ld a, c ; $745e
	or a, a ; $745f
	jr nz, Func_39_745a ; $7460
	ret ; $7462
	ds 2973, $ff ; $7463, fill
