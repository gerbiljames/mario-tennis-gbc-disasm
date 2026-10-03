WaterSpriteModeHooks_10:
	; $4bd8, 16 bytes (mode_hooks)
	dw Unused_10_WaterSpriteHook_Frame ; record 0
	dw Unused_10_WaterSpriteHook_PointStart ; record 1
	dw Unused_10_WaterSpriteHook_PointEnd ; record 2
	dw RetStub ; record 3
	dw Unused_10_WaterSpriteHook_BallHit ; record 4
	dw Unused_10_WaterSpriteHook_Bounce ; record 5
	dw Unused_10_WaterSpriteHook_RallyTick ; record 6
	dw RetStub ; record 7
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
Test2InitScriptMinigamePointTable_10:
	; $4c13, 184 bytes (court_positions)
; court_positions pos0, pos1, pos2, pos3, role0, role1, role2, role3
	court_positions $00, $03, $09, $09, $00, $01, $09, $09 ; point 0
	court_positions $03, $00, $09, $09, $01, $00, $09, $09 ; point 1
	court_positions $01, $02, $09, $09, $00, $01, $09, $09 ; point 2
	court_positions $02, $01, $09, $09, $01, $00, $09, $09 ; point 3
	court_positions $03, $00, $09, $09, $00, $01, $09, $09 ; point 4
	court_positions $00, $03, $09, $09, $01, $00, $09, $09 ; point 5
	court_positions $02, $01, $09, $09, $00, $01, $09, $09 ; point 6
	court_positions $01, $02, $09, $09, $01, $00, $09, $09 ; point 7
	court_positions $ff, $f0, $94, $e6, $03, $57, $21, $b4 ; point 8
	court_positions $c2, $7e, $b7, $72, $20, $1d, $7a, $b7 ; point 9
	court_positions $28, $19, $21, $b2, $c2, $2a, $56, $5f ; point 10
	court_positions $13, $21, $b2, $c2, $7b, $22, $72, $e5 ; point 11
	court_positions $d5, $62, $6b, $11, $04, $0f, $cd, $ce ; point 12
	court_positions $1a, $d1, $e1, $21, $b0, $c2, $2a, $56 ; point 13
	court_positions $5f, $1b, $7a, $b3, $28, $0c, $21, $b0 ; point 14
	court_positions $c2, $7b, $22, $72, $3e, $01, $ea, $b5 ; point 15
	court_positions $c2, $c9, $21, $54, $4c, $cd, $cb, $1b ; point 16
	court_positions $af, $ea, $b5, $c2, $c9, $cf, $74, $11 ; point 17
	court_positions $58, $02, $21, $b0, $c2, $7b, $22, $72 ; point 18
	court_positions $21, $b2, $c2, $af, $22, $22, $22, $22 ; point 19
	court_positions $3e, $01, $21, $54, $4c, $cd, $6a, $1b ; point 20
	court_positions $cd, $31, $26, $fa, $b5, $c2, $b7, $20 ; point 21
	court_positions $f7, $cf, $75, $cd, $25, $27, $78, $c9 ; point 22
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
	map_entry $01, FACE_DOWN, 9.0, 9.0, $0000
	db $ff
DevelopmentExitTriggers_10:
	; $4cf6, 9 bytes (map_scripts:exit)
	map_script $01, FACEMASK_ANY, $0000, MapScriptNop_10, STORYLOC_DEVELOPMENT, $01
	db $ff
DevelopmentRespawnActors_10:
	ld c, $10 ; $4cff
	call BeginFadeOut ; $4d01
	call WaitFadeEnd ; $4d04
	ldh a, [hRomBank] ; $4d07
	ld hl, DevelopmentRespawnActorList_10 ; $4d09
	farcall ScriptRespawnLocationActors ; $4d0c
	script_fade_in $10 ; $4d0f
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
	ld c, $10 ; $4d70
	call BeginFadeOut ; $4d72
	call WaitFadeEnd ; $4d75
	ldh a, [hRomBank] ; $4d78
	ld hl, DevelopmentActors_10 ; $4d7a
	farcall ScriptRespawnLocationActors ; $4d7d
	script_fade_in $10 ; $4d80
	call WaitFadeEnd ; $4d85
	ret ; $4d88
Unused_10_SpeakCheckedChest:
	farcall BeginCutsceneScriptMode ; $4d89
	script_set_text Text_30_1 ; $4d8c
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
DevelopmentFacing01_10:
	farcall BeginCutsceneScriptMode ; $4e39
	script_fade_in $10 ; $4e3c
	script_set_text Text_31_131 ; $4e41
	script_speak ACTOR_PLAYER ; $4e47
	farcall EndCutsceneScriptMode ; $4e4c
	ret ; $4e4f
DevelopmentTileTriggers_10:
	; $4e50, 9 bytes (map_scripts)
	map_script $01, FACEMASK_ANY, $0000, DevelopmentTile01_10, $00, $00
	db $ff
DevelopmentTile01_10:
	farcall BeginCutsceneScriptMode ; $4e59
	script_set_text Text_31_128 ; $4e5c
	script_speak ACTOR_PLAYER ; $4e62
	farcall EndCutsceneScriptMode ; $4e67
	ret ; $4e6a
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
	map_entry $01, FACE_DOWN, 255.0, 255.0, $0000
	db $ff
MainMenuExitTriggers_10:
	; $4e8d, 41 bytes (map_scripts:exit)
	map_script $01, FACEMASK_ANY, $0000, MapScriptNop_10, STORYLOC_ACADEMY_ENTRANCE, $0f
	map_script $02, FACEMASK_ANY, $0000, MapScriptNop_10, STORYLOC_DORM_ROOM, $01
	map_script $03, FACEMASK_ANY, $0000, MapScriptNop_10, STORYLOC_TEST_2, $01
	map_script $04, FACEMASK_ANY, $0000, MapScriptNop_10, STORYLOC_ACADEMY_WING, $0f
	map_script $05, FACEMASK_ANY, $0000, MapScriptNop_10, STORYLOC_PEACHS_CASTLE, $0f
	db $ff
MainMenuNpcScripts_10:
	ds 1, $ff ; $4eb6, fill
MainMenuFacingScripts_10:
	ds 1, $ff ; $4eb7, fill
MainMenuTileTriggers_10:
	ds 1, $ff ; $4eb8, fill
MainMenuInitScript_10:
	script_set_position ACTOR_PLAYER, 63.0, 63.0 ; $4eb9
	call RunTitleAndMainMenuLoop ; $4ec4
	farcall TestStorySlotFlagA ; $4ec7
	call SetMusicMuted ; $4eca
	ret ; $4ecd
ApplyMatchTypeSettings:
	ld hl, MatchTypeSettingsTable0 ; $4ece
	ld a, [wMatchFormatSets] ; $4ed1
	add l ; $4ed4
	ld l, a ; $4ed5
	jr nc, .readSets ; $4ed6
	inc h ; $4ed8
.readSets:
	ld a, [hl] ; $4ed9
	ld [wMatchTypeNumberOfSets], a ; $4eda
	ld hl, MatchTypeSettingsTable1 ; $4edd
	ld a, [wMatchFormatGames] ; $4ee0
	add l ; $4ee3
	ld l, a ; $4ee4
	jr nc, .readGames ; $4ee5
	inc h ; $4ee7
.readGames:
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
MatchTypeSettingsTable0:
	; $4f08, 3 bytes (bytes:16)
	db $01, $03, $05 ; 0x00
MatchTypeSettingsTable1:
	db $02 ; $4f0b
	db $06 ; $4f0c
RunTitleAndMainMenuLoop:
	call ClearFrameTasks ; $4f0d
	sound BGM_NONE ; $4f10
	call ResumeBGM ; $4f12
	ld a, [wStoryModeEntryPoint] ; $4f15
	cp $0a ; $4f18
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
	ld c, $7f ; $4f58
	call BeginFadeOut ; $4f5a
	call WaitFadeEnd ; $4f5d
	call DisableLCDSafely ; $4f60
	ld a, MENUSLIDE_FORWARD ; $4f63
	ld [wMenuSlideDirection], a ; $4f65
.redrawMenu:
	call DisableLCDSafely ; $4f68
	farcall LoadMenuFontGfx ; $4f6b
	farcall ResetScreenAndTextWindows ; $4f6e
	call EnableLCD ; $4f71
	script_fade_in $10 ; $4f74
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
	add l ; $4fbd
	ld l, a ; $4fbe
	jr nc, .done ; $4fbf
	inc h ; $4fc1
.done:
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
	script_fade_in $10 ; $4ffe
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
	ld c, $01 ; $5035
	farcall SaveStoryReturnPoint ; $5037
	farcall SaveStorySlotWithTimer ; $503a
	farcall EndCutsceneScriptMode ; $503d
	ret ; $5040
.backToTitle:
	ld a, $03 ; $5041
	ld [wAnimatedTilePeriod], a ; $5043
	ld c, $10 ; $5046
	call BeginFadeOut ; $5048
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
	script_fade_in $10 ; $506b
	jp RunTitleAndMainMenuLoop.menuLoop ; $5070
.newStorySlot:
	call ResetGameTimer ; $5073
	farcall GenerateUniqueStorySaveSignature ; $5076
	farcall SaveStorySlotWithTimer ; $5079
	test_flag FLAG_DEBUG_SKIP_LOCATION_EXIT ; $507c
	jr nz, .exitToLocation3 ; $507f
	ld a, $01 ; $5081
	ld [wUnusedExitTriggerIdMirror], a ; $5083
	ld [wStoryModeExitTriggerRequest], a ; $5086
	ret ; $5089
.exitToLocation3:
	ld a, $03 ; $508a
	ld [wUnusedExitTriggerIdMirror], a ; $508c
	ld [wStoryModeExitTriggerRequest], a ; $508f
	ret ; $5092
.resetScreen:
	call DisableLCDSafely ; $5093
	farcall ResetScreenAndTextWindows ; $5096
	call EnableLCD ; $5099
	script_fade_in $10 ; $509c
	call WaitFadeEnd ; $50a1
.clearMatchState:
	xor a ; $50a4
	ld [wSaveAndQuitRequest], a ; $50a5
	ld [wKeepMatchStatsFlag], a ; $50a8
	call RestoreGameTimer ; $50ab
	farcall SaveStorySlotWithTimer ; $50ae
	call GetStoryContinueDestination ; $50b1
	ld [wMatchSelectSubState], a ; $50b4
	cp $04 ; $50b7
	jr z, .continueStory ; $50b9
	farcall RunPlayAlonePartnerMenu ; $50bb
	cp $ff ; $50be
	jr nz, .continueStory ; $50c0
	ld a, MENUSLIDE_BACK ; $50c2
	ld [wMenuSlideDirection], a ; $50c4
	jp RunTitleAndMainMenuLoop.menuLoop ; $50c7
.continueStory:
	call GetStoryContinueDestination ; $50ca
	ld [wMatchSelectSubState], a ; $50cd
	call RestoreGameTimer ; $50d0
	ld a, GAMEMODE_NONE ; $50d3
	ld [wGameMode], a ; $50d5
	clear_flag FLAG_ISLAND_SKY_SCENE_ACTIVE ; $50d8
	ld b, STORYLOC_DORM_ROOM ; $50db
	ld c, $01 ; $50dd
	farcall SaveStoryReturnPoint ; $50df
	farcall SaveStorySlotWithTimer ; $50e2
	test_flag FLAG_DEBUG_SKIP_LOCATION_EXIT ; $50e5
	jr nz, .loadSlot ; $50e8
	ld a, [wMatchSelectSubState] ; $50ea
	ld a, a ; $50ed
	ld [wUnusedExitTriggerIdMirror], a ; $50ee
	ld [wStoryModeExitTriggerRequest], a ; $50f1
	ret ; $50f4
.loadSlot:
	ld a, $03 ; $50f5
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
	script_fade_in $10 ; $512e
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
	ld c, $10 ; $5151
	call BeginFadeOut ; $5153
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
	script_fade_in $10 ; $5185
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
	script_fade_in $10 ; $51a2
	farcall RunCourtSelect9Menu ; $51a7
	cp $ff ; $51aa
	jr nz, .linkFlow ; $51ac
	ld a, MENUSLIDE_BACK ; $51ae
	ld [wMenuSlideDirection], a ; $51b0
	jp z, .savedDataFlow ; $51b3
.exhibitionFlow:
	call EnableLCD ; $51b6
	script_fade_in $10 ; $51b9
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
	script_fade_in $10 ; $520e
	jp RunTitleAndMainMenuLoop.menuLoop ; $5213
