InitStoryMatchSettings:
	farcall InitDefaultMatchSettings ; $4931
	ld a, [wStoryModeMainCharacterOverworldSprite] ; $4934
	ld [wMatchPlayerChar], a ; $4937
	xor a ; $493a
	ld [wMatchIsDoubles], a ; $493b
	add $02 ; $493e
	ld [wOnCourtCharCount], a ; $4940
	ld a, MATCHLIST_SINGLES ; $4943
	ld [wCurrentMinigameStoryMatch], a ; $4945
	ld a, CHAR_MARK ; $4948
	ld [wMatchOpponentChar], a ; $494a
	ld a, COURT_GRASS ; $494d
	ld [wCurrentlyUsedCourt], a ; $494f
	ld a, $01 ; $4952
	ld [wMatchTypeNumberOfSets], a ; $4954
	ld a, $02 ; $4957
	ld [wMatchTypeNumberOfGames], a ; $4959
	ld a, MATCHCONTEXT_STORY ; $495c
	ld [wMatchContext], a ; $495e
	ret ; $4961
RunStoryMatch:
	ld c, $10 ; $4962
	call BeginFadeOut ; $4964
	call WaitFadeEnd ; $4967
	call AssignStoryMatchCharacters ; $496a
	farcall RunMatch ; $496d
	ld a, [wSaveAndQuitRequest] ; $4970
	or a ; $4973
	jr z, .matchAborted ; $4974
	farcall SaveStorySlotWithTimer ; $4976
	ld a, STORYLOC_MAIN_MENU ; $4979
	ld [wStoryModeCurrentLocation], a ; $497b
	ld a, $01 ; $497e
	ld [wStoryModeEntryPoint], a ; $4980
	ld a, $ff ; $4983
	ld [wUnusedExitTriggerIdMirror], a ; $4985
	ld [wStoryModeExitTriggerRequest], a ; $4988
	ret ; $498b
.matchAborted:
	xor a ; $498c
	ld [wKeepMatchStatsFlag], a ; $498d
	ret ; $4990
RestoreOverworldAfterMatch:
	ld c, $10 ; $4991
	call BeginFadeOut ; $4993
	call WaitFadeEnd ; $4996
	farcall LoadStoryObjPalettes ; $4999
	call DisableLCDSafely ; $499c
	farcall LoadMenuFontGfx ; $499f
	call EnableLCD ; $49a2
	xor a ; $49a5
	ld [wMatchContext], a ; $49a6
	ret ; $49a9
AssignStoryMatchCharacters:
	ld b, CHAR_STORY_MAIN ; $49aa
	ld c, $00 ; $49ac
	farcall InitCa00RecordFromCharId ; $49ae
	ld a, [wMatchOpponentChar] ; $49b1
	ld b, a ; $49b4
	ld c, $02 ; $49b5
	farcall InitCa00RecordFromCharId ; $49b7
	ld a, [wMatchIsDoubles] ; $49ba
	or a ; $49bd
	jr z, .done ; $49be
	ld b, CHAR_STORY_PARTNER ; $49c0
	ld c, $01 ; $49c2
	farcall InitCa00RecordFromCharId ; $49c4
	ld a, [wMatchOpponentChar] ; $49c7
	ld hl, DoublesPartnerTable_0a ; $49ca
	add l ; $49cd
	ld l, a ; $49ce
	jr nc, .read ; $49cf
	inc h ; $49d1
.read:
	ld b, [hl] ; $49d2
	ld c, $03 ; $49d3
	farcall InitCa00RecordFromCharId ; $49d5
.done:
	ret ; $49d8
DoublesPartnerTable_0a:
	; $49d9, 104 bytes: the doubles partner of each opponent id, 0 = none
	db CHAR_HARRY ; CHAR_ALEX
	db CHAR_KATE ; CHAR_NINA
	db CHAR_ALEX ; CHAR_HARRY
	db CHAR_NINA ; CHAR_KATE
	db CHAR_JOY ; CHAR_ALLIE
	db CHAR_ALLIE ; CHAR_JOY
	db CHAR_PAM ; CHAR_BRIAN
	db CHAR_BRIAN ; CHAR_PAM
	db CHAR_BETH ; CHAR_BOB
	db CHAR_BOB ; CHAR_BETH
	db CHAR_CURT ; CHAR_FAY
	db CHAR_FAY ; CHAR_CURT
	db CHAR_MARK ; CHAR_MARK
	db CHAR_SAMMI ; CHAR_SEAN
	db CHAR_SEAN ; CHAR_SAMMI
	db CHAR_SPIKE ; CHAR_ELDEN
	db CHAR_ELDEN ; CHAR_SPIKE
	db CHAR_KEVIN ; CHAR_EMILY
	db CHAR_A_COZ ; CHAR_B_COZ
	db CHAR_B_COZ ; CHAR_A_COZ
	db CHAR_EMILY ; CHAR_KEVIN
	db CHAR_KEVIN ; CHAR_UNUSED_15
	db CHAR_LUIGI ; CHAR_UNUSED_16
	db CHAR_UNUSED_16 ; CHAR_LUIGI
	db CHAR_BABY_MARIO ; CHAR_DK
	db CHAR_DK ; CHAR_BABY_MARIO
	db CHAR_WALUIGI ; CHAR_MARIO
	db CHAR_MARIO ; CHAR_WALUIGI
	db CHAR_BOWSER ; CHAR_YOSHI
	db CHAR_YOSHI ; CHAR_BOWSER
	db CHAR_PEACH ; CHAR_WARIO
	db CHAR_WARIO ; CHAR_PEACH
	db CHAR_RANKER_34 ; CHAR_RANKER_32
	db CHAR_RANKER_35 ; CHAR_RANKER_33
	db CHAR_RANKER_32 ; CHAR_RANKER_34
	db CHAR_RANKER_33 ; CHAR_RANKER_35
	db CHAR_RANKER_37 ; CHAR_RANKER_36
	db CHAR_RANKER_36 ; CHAR_RANKER_37
	db CHAR_RANKER_39 ; CHAR_RANKER_38
	db CHAR_RANKER_38 ; CHAR_RANKER_39
	db CHAR_RANKER_41 ; CHAR_RANKER_40
	db CHAR_RANKER_40 ; CHAR_RANKER_41
	db CHAR_RANKER_43 ; CHAR_RANKER_42
	db CHAR_RANKER_42 ; CHAR_RANKER_43
	db CHAR_RANKER_45 ; CHAR_RANKER_44
	db CHAR_RANKER_44 ; CHAR_RANKER_45
	db CHAR_RANKER_47 ; CHAR_RANKER_46
	db CHAR_RANKER_46 ; CHAR_RANKER_47
	db CHAR_EMILY_2 ; CHAR_KEVIN_2
	db CHAR_KEVIN_2 ; CHAR_EMILY_2
	db CHAR_ELLIS ; CHAR_MARK_2
	db CHAR_MARK_2 ; CHAR_ELLIS
	db CHAR_EDGAR ; CHAR_FRANK
	db CHAR_FRANK ; CHAR_EDGAR
	db $00 ; $36
	db $00 ; $37
	db $00 ; $38
	db $00 ; $39
	db $00 ; $3a
	db $00 ; $3b
	db $00 ; $3c
	db $00 ; $3d
	db $00 ; $3e
	db $00 ; $3f
	db $00 ; $40
	db $00 ; $41
	db $00 ; $42
	db $00 ; $43
	db $00 ; $44
	db $00 ; $45
	db $00 ; $46
	db $00 ; $47
	db $00 ; $48
	db $00 ; $49
	db $00 ; $4a
	db $00 ; $4b
	db $00 ; $4c
	db $00 ; $4d
	db $00 ; $4e
	db $00 ; $4f
	db $00 ; $50
	db $00 ; $51
	db $00 ; $52
	db $00 ; $53
	db $00 ; $54
	db $00 ; $55
	db $00 ; $56
	db $00 ; $57
	db $00 ; $58
	db $00 ; $59
	db $00 ; $5a
	db $00 ; $5b
	db $00 ; $5c
	db $00 ; $5d
	db CHAR_DREAM_DOUBLES_HARD_PARTNER ; CHAR_DREAM_DOUBLES_HARD
	db CHAR_DREAM_DOUBLES_INTENSE_PARTNER ; CHAR_DREAM_DOUBLES_INTENSE
	db CHAR_DREAM_DOUBLES_MAX_PARTNER ; CHAR_DREAM_DOUBLES_MAX
	db CHAR_DREAM_DOUBLES_HARD ; CHAR_DREAM_DOUBLES_HARD_PARTNER
	db CHAR_DREAM_DOUBLES_INTENSE ; CHAR_DREAM_DOUBLES_INTENSE_PARTNER
	db CHAR_DREAM_DOUBLES_MAX ; CHAR_DREAM_DOUBLES_MAX_PARTNER
	db $00 ; $64
	db $00 ; $65
	db $00 ; $66
	db $00 ; $67
SetMatchDoublesMode:
	ld [wMatchIsDoubles], a ; $4a41
	sla a ; $4a44
	add $02 ; $4a46
	ld [wOnCourtCharCount], a ; $4a48
	ret ; $4a4b
Unused_0a_SetStoryMatchOpponent:
	ld [wMatchOpponentChar], a ; $4a4c
	ret ; $4a4f
Unused_0a_SetCurrentlyUsedCourt:
	ld [wCurrentlyUsedCourt], a ; $4a50
	ret ; $4a53
Unused_0a_SetMatchNumberOfSets:
	ld [wMatchTypeNumberOfSets], a ; $4a54
	ret ; $4a57
Unused_0a_SetMatchNumberOfGames:
	ld [wMatchTypeNumberOfGames], a ; $4a58
	ret ; $4a5b
LoadMatchSettingsFromTable:
	ld de, SinglesMatchSettingsTable_0a ; $4a5c
	ld a, [wCurrentMinigameStoryMatch] ; $4a5f
	cp MATCHLIST_DOUBLES ; $4a62
	ld a, $00 ; $4a64
	jr nz, .haveTable ; $4a66
	inc a ; $4a68
	ld de, DoublesMatchSettingsTable_0a ; $4a69
.haveTable:
	call SetMatchDoublesMode ; $4a6c
	ld a, [wCurrentMinigameStoryMatch + 1] ; $4a6f
	ld l, a ; $4a72
	ld h, $00 ; $4a73
	add hl, hl ; $4a75
	add hl, hl ; $4a76
	add l ; $4a77
	ld l, a ; $4a78
	jr nc, .readEntry ; $4a79
	inc h ; $4a7b
.readEntry:
	add hl, de ; $4a7c
	ld a, [hl+] ; $4a7d
	ld [wGameMode], a ; $4a7e
	ld a, [hl+] ; $4a81
	ld [wMatchOpponentChar], a ; $4a82
	ld a, [hl+] ; $4a85
	ld [wCurrentlyUsedCourt], a ; $4a86
	test_flag FLAG_DEBUG_KEEP_MATCH_SETTINGS ; $4a89
	jr nz, .minigameDefaults ; $4a8c
	ld a, [hl+] ; $4a8e
	ld e, a ; $4a8f
	and $0f ; $4a90
	ld [wMatchTypeNumberOfGames], a ; $4a92
	ld a, e ; $4a95
	swap a ; $4a96
	and $0f ; $4a98
	ld [wMatchTypeNumberOfSets], a ; $4a9a
	ld a, [hl] ; $4a9d
	ld [wMatchBGM], a ; $4a9e
	ret ; $4aa1
.minigameDefaults:
	ld a, $02 ; $4aa2
	ld [wMatchTypeNumberOfGames], a ; $4aa4
	ld a, $01 ; $4aa7
	ld [wMatchTypeNumberOfSets], a ; $4aa9
	inc hl ; $4aac
	ld a, [hl] ; $4aad
	ld [wMatchBGM], a ; $4aae
	ret ; $4ab1
SinglesMatchSettingsTable_0a:
	; $4ab2, 125 bytes (match_settings)
; 25 records x 5 bytes
; match_settings mode, opponent, court, sets, games, bgm
	match_settings GAMEMODE_PRACTICE_MATCH, CHAR_RANKER_36, COURT_HARD, 3, 6, BGM_PRACTICE_MATCH ; STORYMATCH_JUNIOR_PRACTICE
	match_settings GAMEMODE_RANKING_MATCH, CHAR_RANKER_35, COURT_HARD, 3, 6, BGM_JUNIOR_RANKING ; STORYMATCH_JUNIOR_4
	match_settings GAMEMODE_RANKING_MATCH, CHAR_RANKER_34, COURT_HARD, 3, 6, BGM_JUNIOR_RANKING ; STORYMATCH_JUNIOR_3
	match_settings GAMEMODE_RANKING_MATCH, CHAR_RANKER_33, COURT_HARD, 3, 6, BGM_JUNIOR_RANKING ; STORYMATCH_JUNIOR_2
	match_settings GAMEMODE_RANKING_MATCH, CHAR_RANKER_32, COURT_HARD, 3, 6, BGM_JUNIOR_RANKING ; STORYMATCH_JUNIOR_1
	match_settings GAMEMODE_PRACTICE_MATCH, CHAR_RANKER_44, COURT_CLAY, 3, 6, BGM_PRACTICE_MATCH ; STORYMATCH_SENIOR_PRACTICE
	match_settings GAMEMODE_RANKING_MATCH, CHAR_RANKER_43, COURT_CLAY, 3, 6, BGM_SENIOR_RANKING ; STORYMATCH_SENIOR_4
	match_settings GAMEMODE_RANKING_MATCH, CHAR_RANKER_42, COURT_CLAY, 3, 6, BGM_SENIOR_RANKING ; STORYMATCH_SENIOR_3
	match_settings GAMEMODE_RANKING_MATCH, CHAR_RANKER_41, COURT_CLAY, 3, 6, BGM_SENIOR_RANKING ; STORYMATCH_SENIOR_2
	match_settings GAMEMODE_RANKING_MATCH, CHAR_RANKER_40, COURT_CLAY, 3, 6, BGM_SENIOR_RANKING ; STORYMATCH_SENIOR_1
	match_settings GAMEMODE_PRACTICE_MATCH, CHAR_FRANK, COURT_COMPOSITION, 3, 6, BGM_PRACTICE_MATCH ; STORYMATCH_VARSITY_PRACTICE
	match_settings GAMEMODE_RANKING_MATCH, CHAR_ELLIS, COURT_COMPOSITION, 3, 6, BGM_VARSITY_RANKING ; STORYMATCH_VARSITY_4
	match_settings GAMEMODE_NONE, CHAR_ALEX, COURT_HARD, 1, 2, BGM_VARSITY_RANKING ; STORYMATCH_VARSITY_3
	match_settings GAMEMODE_NONE, CHAR_ALEX, COURT_HARD, 1, 2, BGM_VARSITY_RANKING ; STORYMATCH_VARSITY_2
	match_settings GAMEMODE_NONE, CHAR_ALEX, COURT_HARD, 1, 2, BGM_VARSITY_RANKING ; STORYMATCH_VARSITY_1
	match_settings GAMEMODE_PRACTICE_MATCH, CHAR_FRANK, COURT_GRASS, 5, 6, BGM_PRACTICE_MATCH ; match $0f
	match_settings GAMEMODE_ISLAND_OPEN, CHAR_SAMMI, COURT_GRASS_ISLAND_OPEN, 5, 6, BGM_ISLAND_OPEN ; STORYMATCH_ISLAND_OPEN_ROUND_1
	match_settings GAMEMODE_ISLAND_OPEN, CHAR_SPIKE, COURT_GRASS_ISLAND_OPEN, 5, 6, BGM_ISLAND_OPEN ; STORYMATCH_ISLAND_OPEN_ROUND_2
	match_settings GAMEMODE_ISLAND_OPEN, CHAR_EMILY, COURT_GRASS_ISLAND_OPEN, 5, 6, BGM_ISLAND_OPEN_SEMIFINAL ; STORYMATCH_ISLAND_OPEN_SEMIFINAL
	match_settings GAMEMODE_ISLAND_OPEN, CHAR_A_COZ, COURT_CENTER, 5, 6, BGM_ISLAND_OPEN_FINAL ; STORYMATCH_ISLAND_OPEN_FINAL
	match_settings GAMEMODE_PRACTICE_MATCH, CHAR_FRANK, COURT_GRASS, 5, 6, BGM_PRACTICE_MATCH ; match $14
	match_settings GAMEMODE_NONE, CHAR_ALEX, COURT_HARD, 1, 2, BGM_DREAM_MATCH ; match $15
	match_settings GAMEMODE_DREAM_MATCH, CHAR_DREAM_MAX, COURT_CASTLE, 5, 6, BGM_DREAM_MATCH ; STORYMATCH_DREAM_MAX
	match_settings GAMEMODE_DREAM_MATCH, CHAR_DREAM_INTENSE, COURT_CASTLE, 5, 6, BGM_DREAM_MATCH ; STORYMATCH_DREAM_INTENSE
	match_settings GAMEMODE_DREAM_MATCH, CHAR_DREAM_HARD, COURT_CASTLE, 5, 6, BGM_DREAM_MATCH ; STORYMATCH_DREAM_HARD
DoublesMatchSettingsTable_0a:
	; $4b2f, 125 bytes (match_settings)
; 25 records x 5 bytes
; match_settings mode, opponent, court, sets, games, bgm
	match_settings GAMEMODE_PRACTICE_MATCH, CHAR_RANKER_39, COURT_HARD, 3, 6, BGM_PRACTICE_MATCH ; STORYMATCH_JUNIOR_PRACTICE
	match_settings GAMEMODE_NONE, CHAR_ALEX, COURT_HARD, 3, 6, BGM_JUNIOR_RANKING ; STORYMATCH_JUNIOR_4
	match_settings GAMEMODE_RANKING_MATCH, CHAR_RANKER_36, COURT_HARD, 3, 6, BGM_JUNIOR_RANKING ; STORYMATCH_JUNIOR_3
	match_settings GAMEMODE_RANKING_MATCH, CHAR_RANKER_33, COURT_HARD, 3, 6, BGM_JUNIOR_RANKING ; STORYMATCH_JUNIOR_2
	match_settings GAMEMODE_RANKING_MATCH, CHAR_RANKER_32, COURT_HARD, 3, 6, BGM_JUNIOR_RANKING ; STORYMATCH_JUNIOR_1
	match_settings GAMEMODE_PRACTICE_MATCH, CHAR_RANKER_46, COURT_CLAY, 3, 6, BGM_PRACTICE_MATCH ; STORYMATCH_SENIOR_PRACTICE
	match_settings GAMEMODE_NONE, CHAR_ALEX, COURT_HARD, 3, 6, BGM_SENIOR_RANKING ; STORYMATCH_SENIOR_4
	match_settings GAMEMODE_RANKING_MATCH, CHAR_RANKER_44, COURT_CLAY, 3, 6, BGM_SENIOR_RANKING ; STORYMATCH_SENIOR_3
	match_settings GAMEMODE_RANKING_MATCH, CHAR_RANKER_42, COURT_CLAY, 3, 6, BGM_SENIOR_RANKING ; STORYMATCH_SENIOR_2
	match_settings GAMEMODE_RANKING_MATCH, CHAR_RANKER_40, COURT_CLAY, 3, 6, BGM_SENIOR_RANKING ; STORYMATCH_SENIOR_1
	match_settings GAMEMODE_PRACTICE_MATCH, CHAR_FRANK, COURT_COMPOSITION, 3, 6, BGM_PRACTICE_MATCH ; STORYMATCH_VARSITY_PRACTICE
	match_settings GAMEMODE_NONE, CHAR_ALEX, COURT_HARD, 1, 2, BGM_VARSITY_RANKING ; STORYMATCH_VARSITY_4
	match_settings GAMEMODE_NONE, CHAR_ALEX, COURT_HARD, 1, 2, BGM_VARSITY_RANKING ; STORYMATCH_VARSITY_3
	match_settings GAMEMODE_RANKING_MATCH, CHAR_MARK_2, COURT_COMPOSITION, 3, 6, BGM_VARSITY_RANKING ; STORYMATCH_VARSITY_2
	match_settings GAMEMODE_RANKING_MATCH, CHAR_KEVIN_2, COURT_COMPOSITION, 3, 6, BGM_VARSITY_RANKING ; STORYMATCH_VARSITY_1
	match_settings GAMEMODE_PRACTICE_MATCH, CHAR_FRANK, COURT_GRASS, 5, 6, BGM_PRACTICE_MATCH ; match $0f
	match_settings GAMEMODE_NONE, CHAR_ALEX, COURT_HARD, 1, 2, BGM_ISLAND_OPEN ; STORYMATCH_ISLAND_OPEN_ROUND_1
	match_settings GAMEMODE_ISLAND_OPEN, CHAR_SAMMI, COURT_GRASS_ISLAND_OPEN, 5, 6, BGM_ISLAND_OPEN ; STORYMATCH_ISLAND_OPEN_ROUND_2
	match_settings GAMEMODE_ISLAND_OPEN, CHAR_SPIKE, COURT_GRASS_ISLAND_OPEN, 5, 6, BGM_ISLAND_OPEN_SEMIFINAL ; STORYMATCH_ISLAND_OPEN_SEMIFINAL
	match_settings GAMEMODE_ISLAND_OPEN, CHAR_A_COZ, COURT_CENTER, 5, 6, BGM_ISLAND_OPEN_FINAL ; STORYMATCH_ISLAND_OPEN_FINAL
	match_settings GAMEMODE_PRACTICE_MATCH, CHAR_FRANK, COURT_GRASS, 5, 6, BGM_PRACTICE_MATCH ; match $14
	match_settings GAMEMODE_NONE, CHAR_ALEX, COURT_HARD, 1, 2, BGM_DREAM_MATCH ; match $15
	match_settings GAMEMODE_DREAM_MATCH, CHAR_DREAM_DOUBLES_MAX, COURT_CASTLE, 5, 6, BGM_DREAM_MATCH ; STORYMATCH_DREAM_MAX
	match_settings GAMEMODE_DREAM_MATCH, CHAR_DREAM_DOUBLES_INTENSE, COURT_CASTLE, 5, 6, BGM_DREAM_MATCH ; STORYMATCH_DREAM_INTENSE
	match_settings GAMEMODE_DREAM_MATCH, CHAR_DREAM_DOUBLES_HARD, COURT_CASTLE, 5, 6, BGM_DREAM_MATCH ; STORYMATCH_DREAM_HARD
RunClearStatusSetupMenu:
	push bc ; $4bac
	push de ; $4bad
	push hl ; $4bae
	ldh a, [hWramBank] ; $4baf
	push af ; $4bb1
	call ClearFrameTasks ; $4bb2
	call DisableLCDSafely ; $4bb5
	farcall LoadMenuFontGfx ; $4bb8
	call EnableLCD ; $4bbb
	wram_bank WRAM_CHAR1 ; $4bbe
	ld hl, wClearStatusMode ; $4bc4
	ld c, $02 ; $4bc7
	call ClearMemory16 ; $4bc9
	farcall ResetTextWindowState ; $4bcc
	call ClearBgTilemaps ; $4bcf
	ld d, $00 ; $4bd2
	ld e, $0b ; $4bd4
	ld b, $14 ; $4bd6
	ld c, $07 ; $4bd8
	farcall CreateWindowFromScreenRect ; $4bda
	ld [wClearStatusWindowId], a ; $4bdd
	farcall DrawTextWindowFrame ; $4be0
	script_fade_in $10 ; $4be3
	call WaitFadeEnd ; $4be8
	wram_bank WRAM_CHAR1 ; $4beb
.modeMenu:
	ld a, [wClearStatusWindowId] ; $4bf1
	farcall DrawTextWindowFrame ; $4bf4
	ld hl, Text_34_232 ; $4bf7
	ld de, wWindowShadowTilemap + 12 * TILEMAP_WIDTH + 1 ; $4bfa
	farcall RenderProportionalTextAt ; $4bfd
	ld a, [wClearStatusWindowId] ; $4c00
	farcall RedrawWindowRows ; $4c03
	ld hl, Text_34_215 ; $4c06
	ld d, $01 ; $4c09
	ld e, $00 ; $4c0b
	farcall CreateMenuWindowFromText ; $4c0d
	farcall RestoreShadowTilemap ; $4c10
	farcall RenderMenuWindowText ; $4c13
	farcall RunMenuSelection ; $4c16
	ld [wClearStatusMode], a ; $4c19
	ld a, [wMenuWindowId] ; $4c1c
	farcall CloseWindow ; $4c1f
	ld a, [wClearStatusMode] ; $4c22
	cp $ff ; $4c25
	jr nz, .checkMode ; $4c27
	ld a, $08 ; $4c29
	ld [wClearStatusResultCode], a ; $4c2b
	jp .done ; $4c2e
.checkMode:
	or a ; $4c31
	jp z, .defaultDoubles ; $4c32
	ld a, $01 ; $4c35
	ld [wClearStatusResultCode], a ; $4c37
	jp .done ; $4c3a
.defaultDoubles:
	test_flag FLAG_DOUBLES ; $4c3d
	jr nz, .doubles ; $4c40
	xor a ; $4c42
	jr .storeDoubles ; $4c43
.doubles:
	ld a, $01 ; $4c45
.storeDoubles:
	ld [wClearStatusDoubles], a ; $4c47
.formatMenu:
	ld a, [wClearStatusWindowId] ; $4c4a
	farcall DrawTextWindowFrame ; $4c4d
	ld hl, Text_34_228 ; $4c50
	ld de, wWindowShadowTilemap + 12 * TILEMAP_WIDTH + 1 ; $4c53
	farcall RenderProportionalTextAt ; $4c56
	ld a, [wClearStatusWindowId] ; $4c59
	farcall RedrawWindowRows ; $4c5c
	ld hl, Text_34_217 ; $4c5f
	ld d, $03 ; $4c62
	ld e, $00 ; $4c64
	farcall CreateMenuWindowFromText ; $4c66
	farcall RestoreShadowTilemap ; $4c69
	farcall RenderMenuWindowText ; $4c6c
	farcall RunMenuSelection ; $4c6f
	ld [wClearStatusFormat], a ; $4c72
	ld a, [wMenuWindowId] ; $4c75
	farcall CloseWindow ; $4c78
	ld a, [wClearStatusFormat] ; $4c7b
	cp $ff ; $4c7e
	jp z, .modeMenu ; $4c80
.setsMenu:
	ld a, [wClearStatusWindowId] ; $4c83
	farcall DrawTextWindowFrame ; $4c86
	ld hl, Text_34_229 ; $4c89
	ld de, wWindowShadowTilemap + 12 * TILEMAP_WIDTH + 1 ; $4c8c
	farcall RenderProportionalTextAt ; $4c8f
	ld a, [wClearStatusWindowId] ; $4c92
	farcall RedrawWindowRows ; $4c95
	ld hl, Text_34_218 ; $4c98
	ld d, $05 ; $4c9b
	ld e, $00 ; $4c9d
	farcall CreateMenuWindowFromText ; $4c9f
	farcall RestoreShadowTilemap ; $4ca2
	farcall RenderMenuWindowText ; $4ca5
	farcall RunMenuSelection ; $4ca8
	ld [wClearStatusClass], a ; $4cab
	ld a, [wMenuWindowId] ; $4cae
	farcall CloseWindow ; $4cb1
	ld a, [wClearStatusClass] ; $4cb4
	cp $ff ; $4cb7
	jp z, .formatMenu ; $4cb9
	ld a, [wClearStatusWindowId] ; $4cbc
	farcall DrawTextWindowFrame ; $4cbf
	ld hl, $10e6 ; $4cc2
	ld a, [wClearStatusFormat] ; $4cc5
	add l ; $4cc8
	ld l, a ; $4cc9
	jr nc, .drawSetsOption ; $4cca
	inc h ; $4ccc
.drawSetsOption:
	ld de, wWindowShadowTilemap + 12 * TILEMAP_WIDTH + 1 ; $4ccd
	farcall RenderProportionalTextAt ; $4cd0
	ld a, [wClearStatusWindowId] ; $4cd3
	farcall RedrawWindowRows ; $4cd6
	ld a, [wClearStatusDoubles] ; $4cd9
	or a ; $4cdc
	jp nz, .setsCancel ; $4cdd
	ld hl, $10db ; $4ce0
	jr .checkSets ; $4ce3
.setsCancel:
	ld hl, $10df ; $4ce5
.checkSets:
	ld a, [wClearStatusFormat] ; $4ce8
	or a ; $4ceb
	jr z, .storeSets ; $4cec
	ld a, [wClearStatusClass] ; $4cee
	inc a ; $4cf1
	add l ; $4cf2
	ld l, a ; $4cf3
	jr nc, .storeSets ; $4cf4
	inc h ; $4cf6
.storeSets:
	ld d, $07 ; $4cf7
	ld e, $00 ; $4cf9
	farcall CreateMenuWindowFromText ; $4cfb
	farcall RestoreShadowTilemap ; $4cfe
	farcall RenderMenuWindowText ; $4d01
	farcall RunMenuSelection ; $4d04
	ld [wClearStatusRank], a ; $4d07
	ld a, [wMenuWindowId] ; $4d0a
	farcall CloseWindow ; $4d0d
	ld a, [wClearStatusRank] ; $4d10
	cp $ff ; $4d13
	jp z, .setsMenu ; $4d15
	call ApplyClearStatusFlags ; $4d18
	call GetClearStatusResultCode ; $4d1b
.done:
	ld hl, wClearStatusResultCode ; $4d1e
	ld b, [hl] ; $4d21
	pop_wram_bank ; $4d22
	ld a, b ; $4d27
	pop hl ; $4d28
	pop de ; $4d29
	pop bc ; $4d2a
	ret ; $4d2b
ClearBgTilemaps:
	call DisableLCDSafely ; $4d2c
	wram_bank WRAM_COURT_PLANES ; $4d2f
	ld a, $00 ; $4d35
	ld hl, wScreenAttrmap ; $4d37
	ld bc, $0500 ; $4d3a
	call FillMemoryFast ; $4d3d
	wram_bank WRAM_SCREEN ; $4d40
	ld a, $20 ; $4d46
	ld hl, wShadowTilemap ; $4d48
	ld bc, $0500 ; $4d4b
	call FillMemoryFast ; $4d4e
	wram_bank WRAM_SCREEN ; $4d51
	ld hl, wShadowTilemap ; $4d57
	ld de, vBGMap0 ; $4d5a
	ld c, $24 ; $4d5d
	call QueueVRAMCopy ; $4d5f
	wram_bank WRAM_COURT_PLANES ; $4d62
	ld hl, wScreenAttrmap ; $4d68
	ld de, vBGMap0 + VRAM_BANK1 ; $4d6b
	ld c, $24 ; $4d6e
	call QueueVRAMCopy ; $4d70
	call EnableLCD ; $4d73
	ret ; $4d76
FillMemoryFast:
	ld e, a ; $4d77
.fillLoop:
	ld [hl], e ; $4d78
	inc hl ; $4d79
	dec bc ; $4d7a
	ld a, c ; $4d7b
	or b ; $4d7c
	jr nz, .fillLoop ; $4d7d
	ret ; $4d7f
ApplyClearStatusFlags:
	ld a, [wClearStatusMode] ; $4d80
	or a ; $4d83
	ret nz ; $4d84
	clear_flag FLAG_DOUBLES ; $4d85
	ld a, [wClearStatusDoubles] ; $4d88
	or a ; $4d8b
	jr z, .checkDoubles ; $4d8c
	set_flag FLAG_DOUBLES ; $4d8e
.checkDoubles:
	call SetTrainingCourtClearFlags ; $4d91
	ld a, [wClearStatusDoubles] ; $4d94
	or a ; $4d97
	jr nz, .setFlags ; $4d98
.doubles:
	call SetSinglesRankingClearFlags ; $4d9a
	jr .done ; $4d9d
.setFlags:
	ld a, [wClearStatusFormat] ; $4d9f
	or a ; $4da2
	jr z, .doubles ; $4da3
	call SetDoublesRankingClearFlags ; $4da5
.done:
	ret ; $4da8
SetTrainingCourtClearFlags:
	ld c, $1c ; $4da9
	ld de, $1800 ; $4dab
.clearLoop:
	push de ; $4dae
	call ClearGameFlag ; $4daf
	pop de ; $4db2
	ld hl, $0020 ; $4db3
	add hl, de ; $4db6
	ld d, h ; $4db7
	ld e, l ; $4db8
	dec c ; $4db9
	jr nz, .clearLoop ; $4dba
	ld a, [wClearStatusClass] ; $4dbc
	or a ; $4dbf
	ret z ; $4dc0
	ld hl, TrainingCourtLevel1ClearFlags_0a ; $4dc1
.setListA:
	ld a, [hl+] ; $4dc4
	ld d, [hl] ; $4dc5
	ld e, a ; $4dc6
	inc hl ; $4dc7
	ld a, d ; $4dc8
	and d ; $4dc9
	cp $ff ; $4dca
	jr z, .checkSecondList ; $4dcc
	call SetGameFlag ; $4dce
	jr .setListA ; $4dd1
.checkSecondList:
	ld a, [wClearStatusClass] ; $4dd3
	cp $01 ; $4dd6
	ret z ; $4dd8
	ld hl, TrainingCourtLevel2ClearFlags_0a ; $4dd9
.setListB:
	ld a, [hl+] ; $4ddc
	ld d, [hl] ; $4ddd
	ld e, a ; $4dde
	inc hl ; $4ddf
	ld a, d ; $4de0
	and d ; $4de1
	cp $ff ; $4de2
	jr z, .done ; $4de4
	call SetGameFlag ; $4de6
	jr .setListB ; $4de9
.done:
	ret ; $4deb
TrainingCourtClearFlagListPtrs_0a:
	; $4dec, 6 bytes (records:2)
	dw $0000 ; record 0
	dw TrainingCourtLevel1ClearFlags_0a ; record 1
	dw TrainingCourtLevel2ClearFlags_0a ; record 2
TrainingCourtLevel1ClearFlags_0a:
	; $4df2, 14 bytes (flag_ids)
	flag_id FLAG_CLEARED_SERVICE_MATCH_1 ; 0
	flag_id FLAG_CLEARED_SERVICE_PRACTICE_1 ; 1
	flag_id FLAG_CLEARED_NET_GAME_MATCH_1 ; 2
	flag_id FLAG_CLEARED_NET_GAME_PRACTICE_1 ; 3
	flag_id FLAG_CLEARED_STROKE_MATCH_1 ; 4
	flag_id FLAG_CLEARED_STROKE_PRACTICE_1 ; 5
	dw $ffff ; 6: end
TrainingCourtLevel2ClearFlags_0a:
	; $4e00, 14 bytes (flag_ids)
	flag_id FLAG_CLEARED_SERVICE_MATCH_2 ; 0
	flag_id FLAG_CLEARED_SERVICE_PRACTICE_2 ; 1
	flag_id FLAG_CLEARED_NET_GAME_MATCH_2 ; 2
	flag_id FLAG_CLEARED_NET_GAME_PRACTICE_2 ; 3
	flag_id FLAG_CLEARED_STROKE_MATCH_2 ; 4
	flag_id FLAG_CLEARED_STROKE_PRACTICE_2 ; 5
	dw $ffff ; 6: end
