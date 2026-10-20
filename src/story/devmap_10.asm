WaterSpriteModeHooks_10:
	; $4bd8, 16 bytes (mode_hooks)
	table_width 2
	dw Unused_10_WaterSpriteHook_Frame ; MODEHOOK_PER_FRAME
	dw Unused_10_WaterSpriteHook_PointStart ; MODEHOOK_POINT_START
	dw Unused_10_WaterSpriteHook_PointEnd ; MODEHOOK_POINT_END
	dw RetStub ; MODEHOOK_MINIGAME_START
	dw Unused_10_WaterSpriteHook_BallHit ; MODEHOOK_BALL_HIT
	dw Unused_10_WaterSpriteHook_Bounce ; MODEHOOK_BOUNCE
	dw Unused_10_WaterSpriteHook_RallyTick ; MODEHOOK_RALLY_TICK
	dw RetStub ; MODEHOOK_DRAW
	assert_table_length NUM_MODEHOOKS
Unused_10_WaterSpriteHook_Frame:
	ret ; $4be8
Unused_10_WaterSpriteHook_RallyTick:
	ret ; $4be9
Unused_10_WaterSpriteHook_Bounce:
	ret ; $4bea
Unused_10_WaterSpriteHook_BallHit:
	ld a, [wRallyLength] ; $4beb
	cp $02 ; $4bee
	jr c, .done ; $4bf0
	ld a, MATCHABORT_POINT ; $4bf2
	ld [wMatchAbortFlag], a ; $4bf4
	ld hl, wTotalPointsScoredInCurrentGame ; $4bf7
	inc [hl] ; $4bfa
.done:
	ret ; $4bfb
Unused_10_WaterSpriteHook_PointStart:
	ret ; $4bfc
Unused_10_WaterSpriteHook_PointEnd:
	ld a, [wTotalPointsScoredInCurrentGame] ; $4bfd
	bit 0, a ; $4c00
	ret nz ; $4c02
	ld a, [wCharacter1ServiceAces] ; $4c03
	ld hl, wCharacter2ServiceAces ; $4c06
	cp [hl] ; $4c09
	jr nz, .storeMatchAbortFlag ; $4c0a
	ret ; $4c0c
.storeMatchAbortFlag:
	ld a, MATCHABORT_MATCH ; $4c0d
	ld [wMatchAbortFlag], a ; $4c0f
	ret ; $4c12
Unused_10_WaterSpriteMinigamePointTable:
	; $4c13, 64 bytes (court_positions)
; court_positions pos0, pos1, pos2, pos3, role0, role1, role2, role3
	court_positions COURTPOS_NEAR_RIGHT, COURTPOS_FAR_LEFT, COURTPOS_NONE, COURTPOS_NONE, SERVEROLE_SERVER, SERVEROLE_RECEIVER, SERVEROLE_NONE, SERVEROLE_NONE ; point 0
	court_positions COURTPOS_FAR_LEFT, COURTPOS_NEAR_RIGHT, COURTPOS_NONE, COURTPOS_NONE, SERVEROLE_RECEIVER, SERVEROLE_SERVER, SERVEROLE_NONE, SERVEROLE_NONE ; point 1
	court_positions COURTPOS_NEAR_LEFT, COURTPOS_FAR_RIGHT, COURTPOS_NONE, COURTPOS_NONE, SERVEROLE_SERVER, SERVEROLE_RECEIVER, SERVEROLE_NONE, SERVEROLE_NONE ; point 2
	court_positions COURTPOS_FAR_RIGHT, COURTPOS_NEAR_LEFT, COURTPOS_NONE, COURTPOS_NONE, SERVEROLE_RECEIVER, SERVEROLE_SERVER, SERVEROLE_NONE, SERVEROLE_NONE ; point 3
	court_positions COURTPOS_FAR_LEFT, COURTPOS_NEAR_RIGHT, COURTPOS_NONE, COURTPOS_NONE, SERVEROLE_SERVER, SERVEROLE_RECEIVER, SERVEROLE_NONE, SERVEROLE_NONE ; point 4
	court_positions COURTPOS_NEAR_RIGHT, COURTPOS_FAR_LEFT, COURTPOS_NONE, COURTPOS_NONE, SERVEROLE_RECEIVER, SERVEROLE_SERVER, SERVEROLE_NONE, SERVEROLE_NONE ; point 5
	court_positions COURTPOS_FAR_RIGHT, COURTPOS_NEAR_LEFT, COURTPOS_NONE, COURTPOS_NONE, SERVEROLE_SERVER, SERVEROLE_RECEIVER, SERVEROLE_NONE, SERVEROLE_NONE ; point 6
	court_positions COURTPOS_NEAR_LEFT, COURTPOS_FAR_RIGHT, COURTPOS_NONE, COURTPOS_NONE, SERVEROLE_RECEIVER, SERVEROLE_SERVER, SERVEROLE_NONE, SERVEROLE_NONE ; point 7
	; $4c53, 1 bytes (fill)
	ds 1, $ff
Unused_10_SwingContestCountTask:
	ldh a, [hInputRisingEdge] ; $4c54
	and PADF_A | PADF_B ; $4c56
	ld d, a ; $4c58
	ld hl, wUnusedSwingProtoPrevInput ; $4c59
	ld a, [hl] ; $4c5c
	or a ; $4c5d
	ld [hl], d ; $4c5e
	jr nz, .tick ; $4c5f
	ld a, d ; $4c61
	or a ; $4c62
	jr z, .tick ; $4c63
	ld hl, wUnusedSwingProtoSwings ; $4c65
	ld a, [hl+] ; $4c68
	ld d, [hl] ; $4c69
	ld e, a ; $4c6a
	inc de ; $4c6b
	ld hl, wUnusedSwingProtoSwings ; $4c6c
	ld a, e ; $4c6f
	ld [hl+], a ; $4c70
	ld [hl], d ; $4c71
	push hl ; $4c72
	push de ; $4c73
	ld h, d ; $4c74
	ld l, e ; $4c75
	ld_cell de, $0f, $04 ; $4c76
	call PrintHexWord ; $4c79
	pop de ; $4c7c
	pop hl ; $4c7d
.tick:
	ld hl, wUnusedSwingProtoTimer ; $4c7e
	ld a, [hl+] ; $4c81
	ld d, [hl] ; $4c82
	ld e, a ; $4c83
	dec de ; $4c84
	ld a, d ; $4c85
	or e ; $4c86
	jr z, .finish ; $4c87
	ld hl, wUnusedSwingProtoTimer ; $4c89
	ld a, e ; $4c8c
	ld [hl+], a ; $4c8d
	ld [hl], d ; $4c8e
	ld a, $01 ; $4c8f
	ld [wUnusedSwingProtoRunning], a ; $4c91
	ret ; $4c94
.finish:
	ld hl, Unused_10_SwingContestCountTask ; $4c95
	call UnregisterFrameTask ; $4c98
	xor a ; $4c9b
	ld [wUnusedSwingProtoRunning], a ; $4c9c
	ret ; $4c9f
Unused_10_SwingContestPrototype:
	sound SFX_COUNTDOWN ; $4ca0
	ld de, $0258 ; $4ca2
	ld hl, wUnusedSwingProtoTimer ; $4ca5
	ld a, e ; $4ca8
	ld [hl+], a ; $4ca9
	ld [hl], d ; $4caa
	ld hl, wUnusedSwingProtoSwings ; $4cab
	xor a ; $4cae
	ld [hl+], a ; $4caf
	ld [hl+], a ; $4cb0
	ld [hl+], a ; $4cb1
	ld [hl+], a ; $4cb2
	frame_task Unused_10_SwingContestCountTask ; $4cb3
.wait:
	call AdvanceFrame ; $4cbb
	ld a, [wUnusedSwingProtoRunning] ; $4cbe
	or a ; $4cc1
	jr nz, .wait ; $4cc2
	sound SFX_COUNTDOWN_GO ; $4cc4
	wait_frames 120 ; $4cc6
	ret ; $4cca
DevelopmentMapScripts_10:
	; $4ccb, 14 bytes (map_tree)
	dw DevelopmentEntryPoints_10 ; slot 0 EntryPoints
	dw DevelopmentExitTriggers_10 ; slot 1 ExitTriggers
	dw DevelopmentActors_10 ; slot 2 Actors
	dw DevelopmentNpcScripts_10 ; slot 3 NpcScripts
	dw DevelopmentFacingScripts_10 ; slot 4 FacingScripts
	dw DevelopmentTileTriggers_10 ; slot 5 TileTriggers
	dw DevelopmentInitScript_10 ; slot 6 InitScript
DevelopmentActors_10:
	; $4cd9, 10 bytes (map_actors)
	map_actor_end
DevelopmentRespawnActorList_10:
	; $4ce3, 10 bytes (map_actors)
	map_actor_end
DevelopmentEntryPoints_10:
	; $4ced, 9 bytes (map_entries)
	map_entry $01, FACE_DOWN, 9.0, 9.0, $0000, DEVELOPMENT_START
	db $ff
DevelopmentExitTriggers_10:
	; $4cf6, 9 bytes (map_scripts:exit)
	map_script $01, FACEMASK_ANY, $0000, MapScriptNop_10, STORYLOC_DEVELOPMENT, ENTRY_DEVELOPMENT_START, DEVELOPMENT_RELOAD
	db $ff
DevelopmentRespawnActors_10:
	script_fade_out 16 ; $4cff
	call WaitFadeEnd ; $4d04
	script_respawn_actors DevelopmentRespawnActorList_10 ; $4d07
	script_fade_in 16 ; $4d0f
	call WaitFadeEnd ; $4d14
	ret ; $4d17
Unused_10_DevelopmentMoveActorsAndExit:
	script_move_target $03, 1.0, 1.0 ; $4d18
	script_wait_move $03 ; $4d23
	script_move_target $07, 1.0, 1.0 ; $4d28
	script_wait_move $07 ; $4d33
	script_move_target $0b, 1.0, 1.0 ; $4d38
	script_wait_move $0b ; $4d43
	script_move_target $10, 1.0, 1.0 ; $4d48
	script_wait_move $10 ; $4d53
	ld hl, wStoryModePlayersXPosition ; $4d58
	ld de, wStoryModeSpawnPosition ; $4d5b
	ld bc, wStoryModeSpawnPosition_SIZE ; $4d5e
	call CopyMemoryBC ; $4d61
	ld a, STORYENTRY_NONE ; $4d64
	ld [wStoryModeEntryPoint], a ; $4d66
	ld [wUnusedExitTriggerIdMirror], a ; $4d69
	ld [wStoryModeExitTriggerRequest], a ; $4d6c
	ret ; $4d6f
DevelopmentRespawnActorsAlt_10:
	script_fade_out 16 ; $4d70
	call WaitFadeEnd ; $4d75
	script_respawn_actors DevelopmentActors_10 ; $4d78
	script_fade_in 16 ; $4d80
	call WaitFadeEnd ; $4d85
	ret ; $4d88
Unused_10_SpeakCheckedChest:
	farcall BeginCutsceneScriptMode ; $4d89
	script_set_text Text_DevMapCheckedChest ; $4d8c
	script_speak ACTOR_PLAYER ; $4d92
	farcall EndCutsceneScriptMode ; $4d97
	ret ; $4d9a
Unused_10_StubNop0:
	ret ; $4d9b
Unused_10_StubNop1:
	ret ; $4d9c
Unused_10_StubNop2:
	ret ; $4d9d
Unused_10_StubNop3:
	ret ; $4d9e
Unused_10_StubNop4:
	ret ; $4d9f
Unused_10_StubNop5:
	ret ; $4da0
Unused_10_StubNop6:
	ret ; $4da1
Unused_10_StubNop7:
	ret ; $4da2
Unused_10_StubNop8:
	ret ; $4da3
Unused_10_StubNop9:
	ret ; $4da4
Unused_10_StubNop10:
	ret ; $4da5
Unused_10_RequestExitTrigger0e:
	ld a, $0e ; $4da6
	ld [wUnusedExitTriggerIdMirror], a ; $4da8
	ld [wStoryModeExitTriggerRequest], a ; $4dab
	ret ; $4dae
DevelopmentNpcScripts_10:
	; $4daf, 129 bytes (map_scripts)
	map_script $03, FACEMASK_ANY, $0000, DevelopmentRespawnActors_10, $00, $00
	map_script $04, FACEMASK_ANY, $0000, DevelopmentRespawnActors_10, $00, $00
	map_script $05, FACEMASK_ANY, $0000, DevelopmentRespawnActors_10, $00, $00
	map_script $06, FACEMASK_ANY, $0000, DevelopmentRespawnActors_10, $00, $00
	map_script $07, FACEMASK_ANY, $0000, DevelopmentRespawnActors_10, $00, $00
	map_script $08, FACEMASK_ANY, $0000, DevelopmentRespawnActors_10, $00, $00
	map_script $09, FACEMASK_ANY, $0000, DevelopmentRespawnActors_10, $00, $00
	map_script $0a, FACEMASK_ANY, $0000, DevelopmentRespawnActors_10, $00, $00
	map_script $0b, FACEMASK_ANY, $0000, DevelopmentRespawnActorsAlt_10, $00, $00
	map_script $0c, FACEMASK_ANY, $0000, DevelopmentRespawnActorsAlt_10, $00, $00
	map_script $0d, FACEMASK_ANY, $0000, DevelopmentRespawnActorsAlt_10, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script $0e, FACEMASK_ANY, $0000, DevelopmentRespawnActorsAlt_10, $00, $00
	map_script $0f, FACEMASK_ANY, $0000, DevelopmentRespawnActorsAlt_10, $00, $00
	map_script $10, FACEMASK_ANY, $0000, DevelopmentRespawnActorsAlt_10, $00, $00
	map_script $11, FACEMASK_ANY, $0000, DevelopmentRespawnActorsAlt_10, $00, $00
	map_script $12, FACEMASK_ANY, $0000, DevelopmentRespawnActorsAlt_10, $00, $00
	db $ff
DevelopmentFacingScripts_10:
	; $4e30, 9 bytes (map_scripts)
	map_script $01, FACEMASK_ANY, $0000, DevelopmentFacing01_10, $00, $00
	db $ff
	twin_named development_facing01, DevelopmentFacing01_10 ; $4e39
DevelopmentTileTriggers_10:
	; $4e50, 9 bytes (map_scripts)
	map_script $01, FACEMASK_ANY, $0000, DevelopmentTile01_10, $00, $00
	db $ff
	twin_named development_tile01, DevelopmentTile01_10 ; $4e59
DevelopmentInitScript_10:
	ret ; $4e6b
MainMenuMapScripts_10:
	; $4e6c, 14 bytes (map_tree)
	dw MainMenuEntryPoints_10 ; slot 0 EntryPoints
	dw MainMenuExitTriggers_10 ; slot 1 ExitTriggers
	dw MainMenuActors_10 ; slot 2 Actors
	dw MainMenuNpcScripts_10 ; slot 3 NpcScripts
	dw MainMenuFacingScripts_10 ; slot 4 FacingScripts
	dw MainMenuTileTriggers_10 ; slot 5 TileTriggers
	dw MainMenuInitScript_10 ; slot 6 InitScript
MainMenuActors_10:
	; $4e7a, 10 bytes (map_actors)
	map_actor_end
MainMenuEntryPoints_10:
	; $4e84, 9 bytes (map_entries)
	map_entry $01, FACE_DOWN, 255.0, 255.0, $0000, MAIN_MENU_FROM_STORY
	entry_id MAIN_MENU_INIT, $02
	entry_id MAIN_MENU_TITLE, $0a
	db $ff
MainMenuExitTriggers_10:
	; $4e8d, 41 bytes (map_scripts:exit)
	map_script $01, FACEMASK_ANY, $0000, MapScriptNop_10, STORYLOC_ACADEMY_ENTRANCE, ENTRY_ACADEMY_ENTRANCE_NEW_GAME, MAIN_MENU_NEW_GAME
	map_script $02, FACEMASK_ANY, $0000, MapScriptNop_10, STORYLOC_DORM_ROOM, ENTRY_DORM_ROOM_CONTINUE, MAIN_MENU_CONTINUE
	map_script $03, FACEMASK_ANY, $0000, MapScriptNop_10, STORYLOC_TEST_2, ENTRY_TEST_2_SETUP_MENU, MAIN_MENU_TEST_2
	map_script $04, FACEMASK_ANY, $0000, MapScriptNop_10, STORYLOC_ACADEMY_WING, ENTRY_ACADEMY_WING_ISLAND_OPEN_WON, MAIN_MENU_CONTINUE_ISLAND_OPEN_WON
	map_script $05, FACEMASK_ANY, $0000, MapScriptNop_10, STORYLOC_PEACHS_CASTLE, ENTRY_PEACHS_CASTLE_FIRST_VISIT, MAIN_MENU_CONTINUE_TO_PEACHS_CASTLE
	db $ff
MainMenuNpcScripts_10:
	db $ff ; $4eb6
MainMenuFacingScripts_10:
	db $ff ; $4eb7
MainMenuTileTriggers_10:
	db $ff ; $4eb8
MainMenuInitScript_10:
	script_set_position ACTOR_PLAYER, 63.0, 63.0 ; $4eb9
	call RunTitleAndMainMenuLoop ; $4ec4
	farcall TestStorySlotMusicMuted ; $4ec7
	call SetMusicMuted ; $4eca
	ret ; $4ecd
ApplyMatchTypeSettings:
	ld hl, SetsPerMatchChoices ; $4ece
	ld a, [wMatchFormatSets] ; $4ed1
	add_hl_a ; $4ed4
	ld a, [hl] ; $4ed9
	ld [wMatchTypeNumberOfSets], a ; $4eda
	ld hl, GamesPerSetChoices ; $4edd
	ld a, [wMatchFormatGames] ; $4ee0
	add_hl_a ; $4ee3
	ld a, [hl] ; $4ee8
	ld [wMatchTypeNumberOfGames], a ; $4ee9
	ld a, [wMatchFormatDoubles] ; $4eec
	ld [wMatchIsDoubles], a ; $4eef
	or a ; $4ef2
	jr z, .singles ; $4ef3
	ld a, $04 ; $4ef5
	ld [wOnCourtCharCount], a ; $4ef7
	set_flag FLAG_DOUBLES ; $4efa
	jr .done ; $4efd
.singles:
	ld a, $02 ; $4eff
	ld [wOnCourtCharCount], a ; $4f01
	clear_flag FLAG_DOUBLES ; $4f04
.done:
	ret ; $4f07
SetsPerMatchChoices:
	; $4f08, 3 bytes (bytes:16)
	db $01, $03, $05 ; 0x00
GamesPerSetChoices:
	db $02 ; $4f0b
	db $06 ; $4f0c
RunTitleAndMainMenuLoop:
	call ClearFrameTasks ; $4f0d
	sound BGM_NONE ; $4f10
	call ResumeBGM ; $4f12
	ld a, [wStoryModeEntryPoint] ; $4f15
	cp ENTRY_MAIN_MENU_TITLE ; $4f18
	jr nz, .newGame ; $4f1a
	call ClearFrameTasks ; $4f1c
	sound BGM_NONE ; $4f1f
	call ResumeBGM ; $4f21
	xor a ; $4f24
	ld [wCheatUnlockTriggered], a ; $4f25
.intro:
	farcall ShowIntroLogoScreen ; $4f28
	farcall ScrollOutIntroLogo ; $4f2b
	farcall RunIntroCutscene ; $4f2e
.titleScreen:
	farcall RunTitleScreen ; $4f31
	cp $ff ; $4f34
	jr z, .intro ; $4f36
	cp $01 ; $4f38
	jr z, .intro ; $4f3a
.newGame:
	farcall InitDefaultMatchSettings ; $4f3c
	xor a ; $4f3f
	ld [wMainMenuCursor], a ; $4f40
	ld [wSavedDataMenuCursor], a ; $4f43
	ld [wN64TransferMenuCursor], a ; $4f46
	ld [wSubMenuCursor], a ; $4f49
	ld [wMatchFormatDoubles], a ; $4f4c
	ld [wMatchFormatGames], a ; $4f4f
	ld [wMatchFormatSets], a ; $4f52
	call EnableLCD ; $4f55
	script_fade_out 127 ; $4f58
	call WaitFadeEnd ; $4f5d
	call DisableLCDSafely ; $4f60
	ld a, MENUSLIDE_FORWARD ; $4f63
	ld [wMenuSlideDirection], a ; $4f65
.redrawMenu:
	call DisableLCDSafely ; $4f68
	farcall LoadMenuFontGfx ; $4f6b
	farcall ResetScreenAndTextWindows ; $4f6e
	call EnableLCD ; $4f71
	script_fade_in 16 ; $4f74
	call WaitFadeEnd ; $4f79
.menuLoop:
	xor a ; $4f7c
	ld [wUnusedMenuCursor], a ; $4f7d
	ld [wSavedDataMenuCursor], a ; $4f80
	ld [wN64TransferMenuCursor], a ; $4f83
	ld [wSubMenuCursor], a ; $4f86
	ld [wMatchFormatDoubles], a ; $4f89
	ld [wMatchFormatGames], a ; $4f8c
	ld [wMatchFormatSets], a ; $4f8f
	ld [wAnimatedTileSet], a ; $4f92
	ldh [hScrollX], a ; $4f95
	ldh [hScrollY], a ; $4f97
	ld [wCameraX], a ; $4f99
	ld [wCameraX + 1], a ; $4f9c
	ld [wCameraY], a ; $4f9f
	ld [wCameraY + 1], a ; $4fa2
	ld a, $03 ; $4fa5
	ld [wAnimatedTilePeriod], a ; $4fa7
	call ResumeBGM ; $4faa
	call InitSerialLink ; $4fad
	farcall RunMainMenu ; $4fb0
	cp $ff ; $4fb3
	jp z, .titleScreen ; $4fb5
	ld e, a ; $4fb8
	ld hl, MatchSelectHandlersB_10 ; $4fb9
	add a ; $4fbc
	add_hl_a ; $4fbd
	ld a, [hl+] ; $4fc2
	ld h, [hl] ; $4fc3
	ld l, a ; $4fc4
	jp hl ; $4fc5
MatchSelectHandlersB_10:
	; $4fc6, 18 bytes (records:2)
	dw MatchSelectHandlersBHandler0 ; record 0
	dw MatchSelectHandlersBHandler0 ; record 1
	dw MatchSelectHandlersBHandler0 ; record 2
	dw MatchSelectHandlersBHandler3 ; record 3
	dw RunMinigameModeFlow ; record 4
	dw MatchSelectHandlersBHandler5 ; record 5
	dw RunSavedDataMenuFlow ; record 6
	dw MatchSelectHandlersBHandler7 ; record 7
	dw RunEraseSavedDataFlow ; record 8
MatchSelectHandlersBHandler0:
	ld a, e ; $4fd8
	cp $ff ; $4fd9
	jr z, .backToTitle ; $4fdb
	and $7f ; $4fdd
	ld [wCurrentStorySlot], a ; $4fdf
	farcall CheckStorySlot ; $4fe2
	cp $fe ; $4fe5
	jr z, .backToTitle ; $4fe7
	farcall ApplyPendingExpAwards ; $4fe9
	or a ; $4fec
	jr z, .checkMatchResult ; $4fed
	call DisableLCDSafely ; $4fef
	farcall ResetScreenAndTextWindows ; $4ff2
	call EnableLCD ; $4ff5
	ld a, [wSaveAndQuitRequest] ; $4ff8
	or a ; $4ffb
	jr nz, .checkMatchResult ; $4ffc
	script_fade_in 16 ; $4ffe
	call WaitFadeEnd ; $5003
.checkMatchResult:
	ld a, [wSaveAndQuitRequest] ; $5006
	or a ; $5009
	jp z, .clearMatchState ; $500a
	ld c, $00 ; $500d
	farcall ShowMatchResultsScreen ; $500f
	push af ; $5012
	call RestoreGameTimer ; $5013
	pop af ; $5016
	or a ; $5017
	jp z, .resetScreen ; $5018
	cp $ff ; $501b
	jp z, RunTitleAndMainMenuLoop.redrawMenu ; $501d
	xor a ; $5020
	ld [wSaveAndQuitRequest], a ; $5021
	farcall SaveStorySlotWithTimer ; $5024
	ld a, [wKeepMatchStatsFlag] ; $5027
	or a ; $502a
	jr z, .restoreReturnPoint ; $502b
	jp MatchSelectRunMatch ; $502d
.restoreReturnPoint:
	farcall RestoreStoryReturnPoint ; $5030
	ld b, STORYLOC_DORM_ROOM ; $5033
	ld c, ENTRY_DORM_ROOM_CONTINUE ; $5035
	farcall SaveStoryReturnPoint ; $5037
	farcall SaveStorySlotWithTimer ; $503a
	farcall EndCutsceneScriptMode ; $503d
	ret ; $5040
.backToTitle:
	ld a, $03 ; $5041
	ld [wAnimatedTilePeriod], a ; $5043
	script_fade_out 16 ; $5046
	call WaitFadeEnd ; $504b
	ld a, e ; $504e
	ld [wCurrentStorySlot], a ; $504f
	farcall RunNewGameSetup ; $5052
	cp $ff ; $5055
	jp nz, .newStorySlot ; $5057
	ld a, MENUSLIDE_BACK ; $505a
	ld [wMenuSlideDirection], a ; $505c
	call DisableLCDSafely ; $505f
	farcall LoadMenuFontGfx ; $5062
	farcall ResetScreenAndTextWindows ; $5065
	call EnableLCD ; $5068
	script_fade_in 16 ; $506b
	jp RunTitleAndMainMenuLoop.menuLoop ; $5070
.newStorySlot:
	call ResetGameTimer ; $5073
	farcall GenerateUniqueStorySaveSignature ; $5076
	farcall SaveStorySlotWithTimer ; $5079
	test_flag FLAG_DEBUG_SKIP_LOCATION_EXIT ; $507c
	jr nz, .exitToLocation3 ; $507f
	ld a, EXIT_MAIN_MENU_NEW_GAME ; $5081
	ld [wUnusedExitTriggerIdMirror], a ; $5083
	ld [wStoryModeExitTriggerRequest], a ; $5086
	ret ; $5089
.exitToLocation3:
	ld a, EXIT_MAIN_MENU_TEST_2 ; $508a
	ld [wUnusedExitTriggerIdMirror], a ; $508c
	ld [wStoryModeExitTriggerRequest], a ; $508f
	ret ; $5092
.resetScreen:
	call DisableLCDSafely ; $5093
	farcall ResetScreenAndTextWindows ; $5096
	call EnableLCD ; $5099
	script_fade_in 16 ; $509c
	call WaitFadeEnd ; $50a1
.clearMatchState:
	xor a ; $50a4
	ld [wSaveAndQuitRequest], a ; $50a5
	ld [wKeepMatchStatsFlag], a ; $50a8
	call RestoreGameTimer ; $50ab
	farcall SaveStorySlotWithTimer ; $50ae
	call GetStoryContinueDestination ; $50b1
	ld [wStoryContinueExitId], a ; $50b4
	cp EXIT_MAIN_MENU_CONTINUE_ISLAND_OPEN_WON ; $50b7
	jr z, .continueStory ; $50b9
	farcall RunPlayAlonePartnerMenu ; $50bb
	cp $ff ; $50be
	jr nz, .continueStory ; $50c0
	ld a, MENUSLIDE_BACK ; $50c2
	ld [wMenuSlideDirection], a ; $50c4
	jp RunTitleAndMainMenuLoop.menuLoop ; $50c7
.continueStory:
	call GetStoryContinueDestination ; $50ca
	ld [wStoryContinueExitId], a ; $50cd
	call RestoreGameTimer ; $50d0
	ld a, GAMEMODE_NONE ; $50d3
	ld [wGameMode], a ; $50d5
	clear_flag FLAG_ISLAND_SKY_SCENE_ACTIVE ; $50d8
	ld b, STORYLOC_DORM_ROOM ; $50db
	ld c, ENTRY_DORM_ROOM_CONTINUE ; $50dd
	farcall SaveStoryReturnPoint ; $50df
	farcall SaveStorySlotWithTimer ; $50e2
	test_flag FLAG_DEBUG_SKIP_LOCATION_EXIT ; $50e5
	jr nz, .loadSlot ; $50e8
	ld a, [wStoryContinueExitId] ; $50ea
	ld a, a ; $50ed
	ld [wUnusedExitTriggerIdMirror], a ; $50ee
	ld [wStoryModeExitTriggerRequest], a ; $50f1
	ret ; $50f4
.loadSlot:
	ld a, EXIT_MAIN_MENU_TEST_2 ; $50f5
	ld [wUnusedExitTriggerIdMirror], a ; $50f7
	ld [wStoryModeExitTriggerRequest], a ; $50fa
	ret ; $50fd
MatchSelectHandlersBHandler3:
	ld a, STORYSLOT_NONE ; $50fe
	ld [wCurrentStorySlot], a ; $5100
	farcall ReadExhibitionSaveBlock ; $5103
	bit 7, a ; $5106
	jr nz, .noSlot ; $5108
	ld a, [wSaveAndQuitRequest] ; $510a
	or a ; $510d
	jr z, .noSlot ; $510e
	ld c, $00 ; $5110
	farcall ShowMatchResultsScreen ; $5112
	or a ; $5115
	jr z, .startStory ; $5116
	cp $ff ; $5118
	jp z, RunTitleAndMainMenuLoop.redrawMenu ; $511a
	ld a, [wKeepMatchStatsFlag] ; $511d
	or a ; $5120
	jp nz, .optionsFlow ; $5121
.startStory:
	call DisableLCDSafely ; $5124
	farcall ResetScreenAndTextWindows ; $5127
	call EnableLCD ; $512a
	push af ; $512d
	script_fade_in 16 ; $512e
	call WaitFadeEnd ; $5133
	pop af ; $5136
.noSlot:
	xor a ; $5137
	ld [wVictoryScoreTableAlt], a ; $5138
	ld a, STORYSLOT_NONE ; $513b
	ld [wCurrentStorySlot], a ; $513d
	farcall InitStoryModeState ; $5140
	farcall InitDefaultMatchSettings ; $5143
	farcall WriteExhibitionSaveBlock ; $5146
.eraseFlow:
	farcall RunMatchFormatSelect ; $5149
	cp $ff ; $514c
	jp z, RunTitleAndMainMenuLoop.menuLoop ; $514e
	script_fade_out 16 ; $5151
	call WaitFadeEnd ; $5156
.savedDataFlow:
	ld a, [wMatchFormatDoubles] ; $5159
	ld b, a ; $515c
	farcall RunExhibitionCharSelectScreen ; $515d
	call CopyExhibitionCharSlotIds ; $5160
	push af ; $5163
	call ClearFrameTasks ; $5164
	call DisableLCDSafely ; $5167
	farcall LoadMenuFontGfx ; $516a
	farcall ResetScreenAndTextWindows ; $516d
	xor a ; $5170
	ld [wLinkPartnerCourtMask], a ; $5171
	ld [wUnlockedCourtMask], a ; $5174
	farcall ComputeUnlockedCourtFlags ; $5177
	farcall LoadCourtSelectGraphics ; $517a
	pop af ; $517d
	cp $ff ; $517e
	jr nz, .minigameFlow ; $5180
	call EnableLCD ; $5182
	script_fade_in 16 ; $5185
	ld a, MENUSLIDE_BACK ; $518a
	ld [wMenuSlideDirection], a ; $518c
	jr .eraseFlow ; $518f
.minigameFlow:
	ld a, MENUSLIDE_FORWARD ; $5191
	ld [wMenuSlideDirection], a ; $5193
	farcall StubNop_3e ; $5196
	ld a, [wUnlockedCourtMask] ; $5199
	or a ; $519c
	jr z, .exhibitionFlow ; $519d
	call EnableLCD ; $519f
	script_fade_in 16 ; $51a2
	farcall RunCourtSelect9Menu ; $51a7
	cp $ff ; $51aa
	jr nz, .linkFlow ; $51ac
	ld a, MENUSLIDE_BACK ; $51ae
	ld [wMenuSlideDirection], a ; $51b0
	jp z, .savedDataFlow ; $51b3
.exhibitionFlow:
	call EnableLCD ; $51b6
	script_fade_in 16 ; $51b9
	farcall RunCourtSelect4Menu ; $51be
	cp $ff ; $51c1
	jr nz, .linkFlow ; $51c3
	ld a, MENUSLIDE_BACK ; $51c5
	ld [wMenuSlideDirection], a ; $51c7
	jp z, .savedDataFlow ; $51ca
.linkFlow:
	ld d, a ; $51cd
	wram_bank WRAM_ACTORS ; $51ce
	ld a, d ; $51d4
	ld [wCurrentlyUsedCourt], a ; $51d5
	call ApplyMatchTypeSettings ; $51d8
.optionsFlow:
	ld a, STORYSLOT_NONE ; $51db
	ld [wCurrentStorySlot], a ; $51dd
	xor a ; $51e0
	ld [wSaveAndQuitRequest], a ; $51e1
	farcall WriteExhibitionSaveBlock ; $51e4
	ld a, GAMEMODE_EXHIBITION ; $51e7
	ld [wGameMode], a ; $51e9
	farcall RunMatch ; $51ec
	ld a, [wSaveAndQuitRequest] ; $51ef
	or a ; $51f2
	jr z, .done ; $51f3
	ld a, $01 ; $51f5
	ld [wVictoryScoreTableAlt], a ; $51f7
	farcall WriteExhibitionSaveBlock ; $51fa
.done:
	ld a, MENUSLIDE_FORWARD ; $51fd
	ld [wMenuSlideDirection], a ; $51ff
	call DisableLCDSafely ; $5202
	farcall LoadMenuFontGfx ; $5205
	farcall ResetScreenAndTextWindows ; $5208
	call EnableLCD ; $520b
	script_fade_in 16 ; $520e
	jp RunTitleAndMainMenuLoop.menuLoop ; $5213
