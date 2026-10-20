CheckAwardsCeremonyRivalSceneDone:
	test_flag FLAG_DOUBLES ; $5f7a
	jr z, .singles ; $5f7d
	ld a, $00 ; $5f7f
	test_flag FLAG_AWARDS_CEREMONY_SEEN_DOUBLES ; $5f81
	jr z, .done ; $5f84
	ld a, $01 ; $5f86
	jr .done ; $5f88
.singles:
	ld a, $00 ; $5f8a
	test_flag FLAG_AWARDS_CEREMONY_SEEN_SINGLES ; $5f8c
	jr z, .done ; $5f8f
	ld a, $01 ; $5f91
.done:
	ret ; $5f93
TournamentMapScripts_0f:
	; $5f94, 14 bytes (map_tree)
	dw TournamentEntryPoints_0f ; slot 0 EntryPoints
	dw TournamentExitTriggers_0f ; slot 1 ExitTriggers
	dw TournamentActors_0f ; slot 2 Actors
	dw TournamentNpcScripts_0f ; slot 3 NpcScripts
	dw TournamentFacingScripts_0f ; slot 4 FacingScripts
	dw TournamentTileTriggers_0f ; slot 5 TileTriggers
	dw TournamentInitScript_0f ; slot 6 InitScript
TournamentActors_0f:
	; $5fa2, 206 bytes (map_actors)
	map_actor $0000, ActorScript_0f_09, 39.0, 17.0, FACE_LEFT, OBJ_TOURNAMENT_STAFF, ANIM_WALK, $00, TOURNAMENT_STAFF_1
	map_actor $0000, ActorScript_0f_09, 19.0, 15.0, FACE_DOWN, OBJ_TOURNAMENT_STAFF, ANIM_WALK, $00, TOURNAMENT_STAFF_2
	map_actor $0000, ActorScript_0f_09, 1.0, 12.0, FACE_RIGHT, OBJ_TOURNAMENT_STAFF, ANIM_WALK, $00, TOURNAMENT_STAFF_3
	map_actor $0000, ActorScript_0f_09, 35.0, 17.0, FACE_UP, OBJ_KEVIN_SWEATS, ANIM_WALK, $00, TOURNAMENT_KEVIN_SWEATS
	map_actor $0000, ActorScript_0f_11, 35.0, 23.0, FACE_UP, OBJ_MARK_SWEATS, ANIM_WALK, $00, TOURNAMENT_MARK_SWEATS
	map_actor $0000, ActorScript_0f_09, 33.0, 17.0, FACE_RIGHT, OBJ_EMILY_SWEATS, ANIM_WALK, $00, TOURNAMENT_EMILY_SWEATS
	map_actor $0000, ActorScript_0f_09, 41.0, 23.0, FACE_LEFT, OBJ_SPIKE, ANIM_WALK, $00, TOURNAMENT_SPIKE
	map_actor $0000, ActorScript_0f_09, 17.0, 21.0, FACE_DOWN, OBJ_SAMMI, ANIM_WALK, $00, TOURNAMENT_SAMMI
	map_actor $0000, ActorScript_0f_09, 25.0, 19.0, FACE_DOWN, OBJ_ELDEN, ANIM_WALK, $00, TOURNAMENT_ELDEN
	map_actor $0000, ActorScript_0f_09, 23.0, 19.0, FACE_DOWN, OBJ_A_COZ, ANIM_WALK, $00, TOURNAMENT_A_COZ
	map_actor $0000, ActorScript_0f_09, 15.0, 19.0, FACE_DOWN, OBJ_B_COZ, ANIM_WALK, $00, TOURNAMENT_B_COZ
	map_actor $0000, ActorScript_0f_09, 25.0, 21.0, FACE_DOWN, OBJ_SEAN, ANIM_WALK, $00, TOURNAMENT_SEAN
	map_actor $0000, ActorScript_0f_09, 23.0, 21.0, FACE_DOWN, OBJ_FRANK, ANIM_WALK, $00, TOURNAMENT_FRANK
	map_actor $0000, ActorScript_0f_09, 17.0, 19.0, FACE_DOWN, OBJ_ELLIS, ANIM_WALK, $00, TOURNAMENT_ELLIS
	map_actor_end
TournamentEntryPoints_0f:
	; $6070, 65 bytes (map_entries)
	map_entry $01, FACE_DOWN, 14.0, 9.0, $0000, TOURNAMENT_FROM_CENTER_COURT_WEST
	map_entry $02, FACE_DOWN, 42.0, 9.0, $0000, TOURNAMENT_FROM_CENTER_COURT_EAST
	map_entry $03, FACE_RIGHT, 5.0, 11.0, $0000, TOURNAMENT_FROM_COURT_2
	map_entry $04, FACE_LEFT, 51.0, 11.0, $0000, TOURNAMENT_FROM_COURT_1
	map_entry $05, FACE_UP, 28.0, 35.0, $0000, TOURNAMENT_FROM_TOURNAMENT_COURTYARD
	map_entry $0a, FACE_DOWN, 37.0, 17.0, $0000, TOURNAMENT_AFTER_ROUND_SINGLES
	map_entry $0b, FACE_DOWN, 35.0, 17.0, $0000, TOURNAMENT_AFTER_ROUND_DOUBLES
	map_entry $0f, FACE_UP, 27.0, 49.0, $0000, TOURNAMENT_ARRIVAL
	db $ff
TournamentExitTriggers_0f:
	; $60b1, 41 bytes (map_scripts:exit)
	map_script $01, FACEMASK_ANY, $0000, TournamentExit_0f, STORYLOC_CENTER_COURT, ENTRY_CENTER_COURT_FROM_TOURNAMENT_WEST, TOURNAMENT_TO_CENTER_COURT_WEST
	map_script $02, FACEMASK_ANY, $0000, TournamentExit_0f, STORYLOC_CENTER_COURT, ENTRY_CENTER_COURT_FROM_TOURNAMENT_EAST, TOURNAMENT_TO_CENTER_COURT_EAST
	map_script $03, FACEMASK_ANY, $0000, TournamentExit_0f, STORYLOC_COURT_2, ENTRY_COURT_2_FROM_TOURNAMENT, TOURNAMENT_TO_COURT_2
	map_script $04, FACEMASK_ANY, $0000, TournamentExit_0f, STORYLOC_COURT_1, ENTRY_COURT_1_FROM_TOURNAMENT, TOURNAMENT_TO_COURT_1
	map_script $05, FACEMASK_ANY, $0000, TournamentExit_0f, STORYLOC_TOURNAMENT_COURTYARD, ENTRY_TOURNAMENT_COURTYARD_FROM_TOURNAMENT, TOURNAMENT_TO_TOURNAMENT_COURTYARD
	db $ff
TournamentExit_0f:
	clear_flag FLAG_ISLAND_OPEN_IN_PROGRESS ; $60da
	ret ; $60dd
TournamentNpc0ASammi_0f:
	script_set_text Text_SammiIntroPlayYouFirst ; $60de
	script_speak_restore ACTOR_TOURNAMENT_ELDEN ; $60e4
	farcall RunDialogueYesNoPrompt ; $60e9
	farcall ScriptCloseDialogueWindow ; $60ec
	script_wait_frames 5 ; $60ef
	and a ; $60f6
	jr z, .speak ; $60f7
	farcall AdvanceDialogueTextCursor ; $60f9
.speak:
	script_speak ACTOR_TOURNAMENT_ELDEN ; $60fc
	ret ; $6101
TournamentNpcScripts_0f:
	; $6102, 105 bytes (map_scripts)
	map_script ACTOR_TOURNAMENT_KEVIN_SWEATS, FACEMASK_ANY, $0000, Text_KevinSeededYoureUpNow, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_TOURNAMENT_MARK_SWEATS, FACEMASK_ANY, $0000, Text_MarkSeedingPressure, NPC_FACE_PLAYER | NPC_RESTORE_FACING | NPC_FREEZE, $00
	map_script ACTOR_TOURNAMENT_EMILY_SWEATS, FACEMASK_ANY, $0000, Text_EmilyFirstRoundRhythm, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_TOURNAMENT_SPIKE, FACEMASK_ANY, $0000, Text_SpikeIntroSeededPlayer, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_TOURNAMENT_SAMMI, FACEMASK_ANY, $0000, TournamentNpc0ASammi_0f, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_TOURNAMENT_ELDEN, FACEMASK_ANY, $0000, Text_EldenIntroBeatACoz, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_TOURNAMENT_A_COZ, FACEMASK_ANY, $0000, Text_ACozIntroDominateRoundOne, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_TOURNAMENT_B_COZ, FACEMASK_ANY, $0000, Text_BCozIntroUntilMyBrother, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_TOURNAMENT_SEAN, FACEMASK_ANY, $0000, Text_SeanIntroSteadyStroke, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_TOURNAMENT_FRANK, FACEMASK_ANY, $0000, Text_FrankIntroNotOnlyCostellos, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_TOURNAMENT_ELLIS, FACEMASK_ANY, $0000, Text_EllisIntroBCozFeelMight, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_TOURNAMENT_STAFF_1, FACEMASK_ANY, $0000, TournamentNpc03_0f, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_TOURNAMENT_STAFF_2, FACEMASK_ANY, $0000, TournamentNpc04_0f, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	db $ff
TournamentFacingScripts_0f:
	; $616b, 9 bytes (map_scripts)
	map_script $01, FACEMASK_ANY, $0000, ShowTournamentChartFacing_0f, $00, $00
	db $ff
ShowTournamentChartFacing_0f:
	xor a ; $6174
	ldh [hBGColumnBlitPending], a ; $6175
	ldh [hBGRowBlitPending], a ; $6177
	ldh [hScrollY], a ; $6179
	ldh [hScrollX], a ; $617b
	ld [wCameraX + 1], a ; $617d
	ld [wCameraY + 1], a ; $6180
	call ClearFrameTasks ; $6183
	call GetIslandOpenRoundParams ; $6186
	ld d, RANKINGBOARD_SILENT ; $6189
	farcall ShowRankingBoard ; $618b
	ld hl, wStoryModePlayersXPosition ; $618e
	ld de, wStoryModeSpawnPosition ; $6191
	ld bc, wStoryModeSpawnPosition_SIZE ; $6194
	call CopyMemoryBC ; $6197
	ld a, STORYENTRY_NONE ; $619a
	ld [wStoryModeEntryPoint], a ; $619c
	ld [wUnusedExitTriggerIdMirror], a ; $619f
	ld [wStoryModeExitTriggerRequest], a ; $61a2
	ret ; $61a5
TournamentTileTriggers_0f:
	; $61a6, 17 bytes (map_scripts)
	map_script $0e, FACEMASK_ANY, $0000, TournamentRoundCallTileDoubles_0f, $00, $00
	map_script $0f, FACEMASK_ANY, $0000, TournamentRoundCallTileSingles_0f, $00, $00
	db $ff
TournamentRoundCallTileDoubles_0f:
	ld a, $01 ; $61b7
	ld [wMapSceneStage2], a ; $61b9
	script_null_script ACTOR_PARTNER ; $61bc
	script_set_actor_script ACTOR_PLAYER, ActorScript_0f_01 ; $61c1
	script_set_actor_script ACTOR_PARTNER, ActorScript_0f_02 ; $61cc
	script_wait_actor_script ACTOR_PLAYER ; $61d7
	call IslandOpenRoundCallCutscene ; $61dc
	ret ; $61df
ActorScript_0f_01:
	; $61e0, 11 bytes (actor_script)
	as_set_target 17.0, 21.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_halt
ActorScript_0f_02:
	; $61eb, 11 bytes (actor_script)
	as_set_target 15.0, 21.0
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_halt
TournamentRoundCallTileSingles_0f:
	ld a, $00 ; $61f6
	ld [wMapSceneStage2], a ; $61f8
	script_set_actor_script ACTOR_PLAYER, ActorScript_0f_02 ; $61fb
	script_wait_actor_script ACTOR_PLAYER ; $6206
	call IslandOpenRoundCallCutscene ; $620b
	ret ; $620e
TournamentInitScript_0f:
	frame_task UpdatePlayerPairDrawModes_0f ; $620f
	ld a, [wStoryModeEntryPoint] ; $6217
	cp STORYENTRY_NONE ; $621a
	jr z, .inProgress ; $621c
	clear_flag FLAG_ISLAND_OPEN_IN_PROGRESS ; $621e
.inProgress:
	test_flag FLAG_ISLAND_OPEN_IN_PROGRESS ; $6221
	jp z, .notInProgress ; $6224
	call ComputeIslandOpenRound ; $6227
	ld a, [wMapSceneStage] ; $622a
	and a ; $622d
	jr nz, .laterRound ; $622e
	script_respawn_actors IslandOpenRoundActors_0f ; $6230
	ld hl, IslandOpenRoundNpcScripts_0f ; $6238
	ld de, wMapNpcScriptsPtr - wStoryModeCurrentLocation ; $623b
	farcall WriteStoryStateWord ; $623e
	farcall BeginCutsceneScriptMode ; $6241
	script_set_position ACTOR_ISLAND_OPEN_ROUND_KEVIN_SWEATS, 28.0, 28.0 ; $6244
	script_set_position ACTOR_ISLAND_OPEN_ROUND_EMILY_SWEATS, 28.0, 31.0 ; $624f
	script_set_position ACTOR_ISLAND_OPEN_ROUND_MARK_SWEATS, 29.0, 33.0 ; $625a
	script_face ACTOR_ISLAND_OPEN_ROUND_KEVIN_SWEATS, FACE_DOWN ; $6265
	script_face ACTOR_ISLAND_OPEN_ROUND_EMILY_SWEATS, FACE_DOWN ; $626c
	script_face ACTOR_ISLAND_OPEN_ROUND_MARK_SWEATS, FACE_LEFT ; $6273
	test_flag FLAG_DOUBLES ; $627a
	jr z, .setObjectDefs ; $627d
	script_set_position ACTOR_ISLAND_OPEN_ROUND_MARK_SWEATS, 63.0, 63.0 ; $627f
.setObjectDefs:
	call SetPlayerAndPartnerObjectDefs ; $628a
	ret ; $628d
.laterRound:
	test_flag FLAG_DOUBLES ; $628e
	jr nz, .doubles ; $6291
	script_respawn_actors IslandOpenRoundActorsSingles_0f ; $6293
	ld hl, IslandOpenRoundNpcScriptsSingles_0f ; $629b
	ld de, wMapNpcScriptsPtr - wStoryModeCurrentLocation ; $629e
	farcall WriteStoryStateWord ; $62a1
	farcall BeginCutsceneScriptMode ; $62a4
	call SetPlayerAndPartnerObjectDefs ; $62a7
	script_face ACTOR_ISLAND_OPEN_ROUND_SINGLES_KEVIN_SWEATS, FACE_RIGHT ; $62aa
	script_set_position ACTOR_ISLAND_OPEN_ROUND_SINGLES_EMILY_SWEATS, 39.0, 19.0 ; $62b1
	script_face ACTOR_ISLAND_OPEN_ROUND_SINGLES_EMILY_SWEATS, FACE_LEFT ; $62bc
	ret ; $62c3
.doubles:
	script_respawn_actors IslandOpenRoundActorsDoubles_0f ; $62c4
	ld hl, IslandOpenRoundNpcScriptsDoubles_0f ; $62cc
	ld de, wMapNpcScriptsPtr - wStoryModeCurrentLocation ; $62cf
	farcall WriteStoryStateWord ; $62d2
	farcall BeginCutsceneScriptMode ; $62d5
	call SetPlayerAndPartnerObjectDefs ; $62d8
	script_face_toward ACTOR_PLAYER, ACTOR_ISLAND_OPEN_ROUND_DOUBLES_EMILY_SWEATS ; $62db
	script_face ACTOR_ISLAND_OPEN_ROUND_DOUBLES_KEVIN_SWEATS, FACE_RIGHT ; $62e3
	ret ; $62ea
.notInProgress:
	ld a, [wStoryModeEntryPoint] ; $62eb
	cp ENTRY_TOURNAMENT_ARRIVAL ; $62ee
	jr nz, .checkAfterRoundSingles ; $62f0
	call IslandOpenArrivalCutscene ; $62f2
	ret ; $62f5
.checkAfterRoundSingles:
	cp ENTRY_TOURNAMENT_AFTER_ROUND_SINGLES ; $62f6
	jr nz, .checkAfterRoundDoubles ; $62f8
	call IslandOpenSinglesMatchReturn ; $62fa
	ret ; $62fd
.checkAfterRoundDoubles:
	cp ENTRY_TOURNAMENT_AFTER_ROUND_DOUBLES ; $62fe
	jr nz, .walkIn ; $6300
	call IslandOpenDoublesMatchReturn ; $6302
	ret ; $6305
.walkIn:
	call LoadIslandOpenRoundNpcs ; $6306
	call SetPlayerAndPartnerObjectDefs ; $6309
	call WalkActorsInFromEntryPoint_0f ; $630c
	ret ; $630f
UpdatePlayerPairDrawModes_0f:
	ld a, $00 ; $6310
	call SetActorDrawModeFromSceneTile_0f ; $6312
	test_flag FLAG_DOUBLES ; $6315
	ret z ; $6318
	ld a, $02 ; $6319
	call SetActorDrawModeFromSceneTile_0f ; $631b
	ret ; $631e
SetActorDrawModeFromSceneTile_0f:
	ld h, a ; $631f
	ld l, $00 ; $6320
	push af ; $6322
	wram_bank WRAM_ACTORS ; $6323
	srl h ; $6329
	rr l ; $632b
	srl h ; $632d
	rr l ; $632f
	ld bc, wActors ; $6331
	add hl, bc ; $6334
	ld b, h ; $6335
	ld c, l ; $6336
	ld hl, ACTORF_X ; $6337
	add hl, bc ; $633a
	ld a, [hl+] ; $633b
	ld h, [hl] ; $633c
	ld l, a ; $633d
	ld de, -80 ; $633e
	add hl, de ; $6341
	ld d, h ; $6342
	ld hl, ACTORF_Y ; $6343
	add hl, bc ; $6346
	ld a, [hl+] ; $6347
	add $40 ; $6348
	ld a, [hl] ; $634a
	adc $00 ; $634b
	ld e, a ; $634d
	dec e ; $634e
	pop af ; $634f
	or a ; $6350
	jr z, .readCell ; $6351
	dec e ; $6353
	dec e ; $6354
.readCell:
	push de ; $6355
	call ReadSceneTilemapTile_0f ; $6356
	pop de ; $6359
	and $87 ; $635a
	cp $05 ; $635c
	jr nz, .checkRight ; $635e
	wram_bank WRAM_ACTORS ; $6360
	ld hl, ACTORF_MODE ; $6366
	add hl, bc ; $6369
	ld a, [hl] ; $636a
	xor $01 ; $636b
	ld [hl], a ; $636d
	ret ; $636e
.checkRight:
	inc d ; $636f
	call ReadSceneTilemapTile_0f ; $6370
	and $07 ; $6373
	cp $05 ; $6375
	jr nz, .notOnTile ; $6377
	wram_bank WRAM_ACTORS ; $6379
	ld hl, ACTORF_MODE ; $637f
	add hl, bc ; $6382
	ld a, [hl] ; $6383
	xor $01 ; $6384
	ld [hl], a ; $6386
	ret ; $6387
.notOnTile:
	wram_bank WRAM_ACTORS ; $6388
	ld hl, ACTORF_MODE ; $638e
	add hl, bc ; $6391
	ld a, ACTORMODE_VISIBLE ; $6392
	ld [hl], a ; $6394
	ret ; $6395
; SetActorDrawModeFromSceneTile_0f without the push af / pop af / or a / jr z that makes the live one skip on a zero argument. Nothing calls it.
Unused_0f_SetActorDrawModeFromSceneTileSingle:
	ld h, a ; $6396
	ld l, $00 ; $6397
	wram_bank WRAM_ACTORS ; $6399
	srl h ; $639f
	rr l ; $63a1
	srl h ; $63a3
	rr l ; $63a5
	ld bc, wActors ; $63a7
	add hl, bc ; $63aa
	ld b, h ; $63ab
	ld c, l ; $63ac
	ld hl, ACTORF_X ; $63ad
	add hl, bc ; $63b0
	ld a, [hl+] ; $63b1
	ld h, [hl] ; $63b2
	ld l, a ; $63b3
	ld de, -80 ; $63b4
	add hl, de ; $63b7
	ld d, h ; $63b8
	ld hl, ACTORF_Y ; $63b9
	add hl, bc ; $63bc
	ld a, [hl+] ; $63bd
	add $40 ; $63be
	ld a, [hl] ; $63c0
	adc $00 ; $63c1
	ld e, a ; $63c3
	dec e ; $63c4
	dec e ; $63c5
	dec e ; $63c6
	push de ; $63c7
	call ReadSceneTilemapTile_0f ; $63c8
	pop de ; $63cb
	and $87 ; $63cc
	cp $05 ; $63ce
	jr nz, .checkRight ; $63d0
	wram_bank WRAM_ACTORS ; $63d2
	ld hl, ACTORF_MODE ; $63d8
	add hl, bc ; $63db
	ld a, [hl] ; $63dc
	xor $01 ; $63dd
	ld [hl], a ; $63df
	ret ; $63e0
.checkRight:
	inc d ; $63e1
	call ReadSceneTilemapTile_0f ; $63e2
	and $07 ; $63e5
	cp $05 ; $63e7
	jr nz, .done ; $63e9
	wram_bank WRAM_ACTORS ; $63eb
	ld hl, ACTORF_MODE ; $63f1
	add hl, bc ; $63f4
	ld a, [hl] ; $63f5
	xor $01 ; $63f6
	ld [hl], a ; $63f8
	ret ; $63f9
.done:
	wram_bank WRAM_ACTORS ; $63fa
	ld hl, ACTORF_MODE ; $6400
	add hl, bc ; $6403
	ld a, ACTORMODE_VISIBLE ; $6404
	ld [hl], a ; $6406
	ret ; $6407
	twin read_scene_tilemap_tile, 0f ; $6408 ReadSceneTilemapTile_0f
IslandOpenArrivalCutscene:
	set_flag FLAG_ISLAND_OPEN_IN_PROGRESS ; $6426
	script_respawn_actors IslandOpenRoundActors_0f ; $6429
	ld hl, IslandOpenRoundNpcScripts_0f ; $6431
	ld de, wMapNpcScriptsPtr - wStoryModeCurrentLocation ; $6434
	farcall WriteStoryStateWord ; $6437
	farcall BeginCutsceneScriptMode ; $643a
	call ReplacePartnerWithStandInActor ; $643d
	script_player_speed 7.96875 ; $6440
	script_move_player 28.0, 37.0 ; $6446
	farcall WaitPlayerMoveDone ; $6450
	script_fade_in 4 ; $6453
	call WaitFadeEnd ; $6458
	script_player_speed 0.75 ; $645b
	script_move_player 28.0, 27.0 ; $6461
	script_move_target ACTOR_ISLAND_OPEN_ROUND_KEVIN_SWEATS, 28.0, 28.0 ; $646b
	script_move_target ACTOR_ISLAND_OPEN_ROUND_EMILY_SWEATS, 28.0, 31.0 ; $6476
	script_move_target ACTOR_ISLAND_OPEN_ROUND_MARK_SWEATS, 29.0, 33.0 ; $6481
	script_move_target ACTOR_PLAYER, 27.0, 33.0 ; $648c
	script_wait_move ACTOR_PLAYER ; $6497
	script_wait_frames 40 ; $649c
	script_face ACTOR_ISLAND_OPEN_ROUND_KEVIN_SWEATS, FACE_DOWN ; $64a3
	script_set_text Text_IslandOpenArrivalPlaceAmazing ; $64aa
	script_face ACTOR_PLAYER, FACE_DOWN ; $64b0
	script_wait_frames 40 ; $64b7
	script_face ACTOR_PLAYER, FACE_LEFT ; $64be
	script_wait_frames 40 ; $64c5
	script_face ACTOR_PLAYER, FACE_UP ; $64cc
	script_wait_frames 40 ; $64d3
	script_face ACTOR_PLAYER, FACE_RIGHT ; $64da
	script_wait_frames 40 ; $64e1
	script_face ACTOR_PLAYER, FACE_DOWN ; $64e8
	script_wait_frames 40 ; $64ef
	script_set_anim ACTOR_PLAYER, ANIM_BOUNCE ; $64f6
	script_wait_idle ACTOR_PLAYER ; $64fd
	script_face ACTOR_ISLAND_OPEN_ROUND_EMILY_SWEATS, FACE_RIGHT ; $6502
	script_face ACTOR_ISLAND_OPEN_ROUND_EMILY_SWEATS, FACE_DOWN ; $6509
	script_face ACTOR_ISLAND_OPEN_ROUND_MARK_SWEATS, FACE_LEFT ; $6510
	script_wait_frames 20 ; $6517
	script_set_anim ACTOR_ISLAND_OPEN_ROUND_EMILY_SWEATS, ANIM_SHAKE ; $651e
	script_wait_idle ACTOR_ISLAND_OPEN_ROUND_EMILY_SWEATS ; $6525
	script_speak ACTOR_ISLAND_OPEN_ROUND_EMILY_SWEATS ; $652a
	script_face ACTOR_PLAYER, FACE_UP ; $652f
	script_wait_frames 40 ; $6536
	script_set_anim ACTOR_PLAYER, ANIM_NOD ; $653d
	script_wait_idle ACTOR_PLAYER ; $6544
	script_set_anim ACTOR_ISLAND_OPEN_ROUND_KEVIN_SWEATS, ANIM_BOUNCE ; $6549
	script_wait_idle ACTOR_ISLAND_OPEN_ROUND_KEVIN_SWEATS ; $6550
	script_speak ACTOR_ISLAND_OPEN_ROUND_KEVIN_SWEATS ; $6555
	script_set_anim ACTOR_PLAYER, ANIM_BOUNCE ; $655a
	script_wait_idle ACTOR_PLAYER ; $6561
	test_flag FLAG_DOUBLES ; $6566
	jr nz, .doubles ; $6569
	script_set_anim ACTOR_ISLAND_OPEN_ROUND_MARK_SWEATS, ANIM_NOD ; $656b
	script_wait_idle ACTOR_ISLAND_OPEN_ROUND_MARK_SWEATS ; $6572
	script_speak ACTOR_ISLAND_OPEN_ROUND_MARK_SWEATS ; $6577
	set_flag FLAG_REACHED_ISLAND_OPEN_SINGLES ; $657c
	jr .walkOn ; $657f
	ret ; $6581
.doubles:
	farcall AdvanceDialogueTextCursor ; $6582
	script_set_anim ACTOR_ISLAND_OPEN_ROUND_EMILY_SWEATS, ANIM_NOD ; $6585
	script_wait_idle ACTOR_ISLAND_OPEN_ROUND_EMILY_SWEATS ; $658c
	script_speak ACTOR_ISLAND_OPEN_ROUND_EMILY_SWEATS ; $6591
	script_follow ACTOR_ISLAND_OPEN_ROUND_MARK_SWEATS, ACTOR_PLAYER ; $6596
	set_flag FLAG_REACHED_ISLAND_OPEN_DOUBLES ; $65a3
.walkOn:
	script_player_speed 0.75 ; $65a6
	script_move_player 28.0, 29.0 ; $65ac
	farcall WaitPlayerMoveDone ; $65b6
	ld a, ISLANDOPENROUND_ROUND1 ; $65b9
	ld [wMapSceneStage], a ; $65bb
	farcall SaveStorySlotWithTimer ; $65be
	ret ; $65c1
IslandOpenRoundActors_0f:
	; $65c2, 52 bytes (map_actors)
	map_actor $0000, ActorScript_0f_09, 28.0, 44.0, FACE_UP, OBJ_KEVIN_SWEATS, ANIM_WALK, $00, ISLAND_OPEN_ROUND_KEVIN_SWEATS
	map_actor $0000, ActorScript_0f_09, 28.0, 47.0, FACE_UP, OBJ_EMILY_SWEATS, ANIM_WALK, $00, ISLAND_OPEN_ROUND_EMILY_SWEATS
	map_actor $0000, ActorScript_0f_09, 29.0, 49.0, FACE_UP, OBJ_MARK_SWEATS, ANIM_WALK, $00, ISLAND_OPEN_ROUND_MARK_SWEATS
	map_actor_end
IslandOpenRoundNpcScripts_0f:
	; $65f6, 25 bytes (map_scripts)
	map_script ACTOR_ISLAND_OPEN_ROUND_KEVIN_SWEATS, FACEMASK_ANY, $0000, Text_KevinSweatsSpecialMatches, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_ISLAND_OPEN_ROUND_EMILY_SWEATS, FACEMASK_ANY, $0000, Text_EmilySweatsAStandsForAcademy, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_ISLAND_OPEN_ROUND_MARK_SWEATS, FACEMASK_ANY, $0000, Text_MarkSweatsStayOutOfTrouble, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	db $ff
ComputeIslandOpenRound:
	test_flag FLAG_DOUBLES ; $660f
	jr nz, .doubles ; $6612
	test_flag FLAG_WON_ISLAND_OPEN_SINGLES_SEMIFINAL ; $6614
	jr z, .checkRound2 ; $6617
	ld a, ISLANDOPENROUND_FINAL ; $6619
	ld [wMapSceneStage], a ; $661b
	ret ; $661e
.checkRound2:
	test_flag FLAG_WON_ISLAND_OPEN_SINGLES_ROUND_2 ; $661f
	jr z, .checkRound1 ; $6622
	ld a, ISLANDOPENROUND_SEMIFINAL ; $6624
	ld [wMapSceneStage], a ; $6626
	ret ; $6629
.checkRound1:
	test_flag FLAG_WON_ISLAND_OPEN_SINGLES_ROUND_1 ; $662a
	jr z, .round1 ; $662d
	ld a, ISLANDOPENROUND_ROUND2 ; $662f
	ld [wMapSceneStage], a ; $6631
	ret ; $6634
.round1:
	ld a, ISLANDOPENROUND_ROUND1 ; $6635
	ld [wMapSceneStage], a ; $6637
	ret ; $663a
.doubles:
	test_flag FLAG_WON_ISLAND_OPEN_DOUBLES_SEMIFINAL ; $663b
	jr z, .doublesCheckRound1 ; $663e
	ld a, ISLANDOPENROUND_FINAL ; $6640
	ld [wMapSceneStage], a ; $6642
	ret ; $6645
.doublesCheckRound1:
	test_flag FLAG_WON_ISLAND_OPEN_DOUBLES_ROUND_1 ; $6646
	jr z, .round1 ; $6649
	ld a, ISLANDOPENROUND_SEMIFINAL ; $664b
	ld [wMapSceneStage], a ; $664d
	ret ; $6650
LoadIslandOpenRoundNpcs:
	ld a, ISLANDOPENROUND_ROUND1 ; $6651
	ld [wMapSceneStage], a ; $6653
	test_flag FLAG_DOUBLES ; $6656
	jr nz, LoadIslandOpenRoundNpcsDoubles ; $6659
	ld a, BEHAVIOR_TRIGGER | 15 << 4 ; $665b
	map_cell 14, 20 ; $665d
	farcall WriteBehaviorMapCell ; $6661
	test_flag FLAG_WON_ISLAND_OPEN_SINGLES_SEMIFINAL ; $6664
	jr z, .checkRound2 ; $6667
	script_respawn_actors IslandOpenFinalActors_0f ; $6669
	ld hl, IslandOpenFinalNpcScripts_0f ; $6671
	ld de, wMapNpcScriptsPtr - wStoryModeCurrentLocation ; $6674
	farcall WriteStoryStateWord ; $6677
	ld a, ISLANDOPENROUND_FINAL ; $667a
	ld [wMapSceneStage], a ; $667c
	ret ; $667f
.checkRound2:
	test_flag FLAG_WON_ISLAND_OPEN_SINGLES_ROUND_2 ; $6680
	jr z, .checkRound1 ; $6683
	script_respawn_actors IslandOpenSemifinalActors_0f ; $6685
	ld hl, IslandOpenSemifinalNpcScripts_0f ; $668d
	ld de, wMapNpcScriptsPtr - wStoryModeCurrentLocation ; $6690
	farcall WriteStoryStateWord ; $6693
	ld a, ISLANDOPENROUND_SEMIFINAL ; $6696
	ld [wMapSceneStage], a ; $6698
	ret ; $669b
.checkRound1:
	test_flag FLAG_WON_ISLAND_OPEN_SINGLES_ROUND_1 ; $669c
	jr z, .done ; $669f
	script_respawn_actors IslandOpenRound2Actors_0f ; $66a1
	ld hl, IslandOpenRound2NpcScripts_0f ; $66a9
	ld de, wMapNpcScriptsPtr - wStoryModeCurrentLocation ; $66ac
	farcall WriteStoryStateWord ; $66af
	ld a, ISLANDOPENROUND_ROUND2 ; $66b2
	ld [wMapSceneStage], a ; $66b4
.done:
	ret ; $66b7
LoadIslandOpenRoundNpcsDoubles:
	ld a, BEHAVIOR_TRIGGER | 14 << 4 ; $66b8
	map_cell 14, 20 ; $66ba
	farcall WriteBehaviorMapCell ; $66be
	ld a, BEHAVIOR_TRIGGER | 14 << 4 ; $66c1
	map_cell 16, 20 ; $66c3
	farcall WriteBehaviorMapCell ; $66c7
	test_flag FLAG_WON_ISLAND_OPEN_DOUBLES_SEMIFINAL ; $66ca
	jr z, .checkRound1 ; $66cd
	script_respawn_actors IslandOpenFinalActorsDoubles_0f ; $66cf
	ld hl, IslandOpenFinalNpcScriptsDoubles_0f ; $66d7
	ld de, wMapNpcScriptsPtr - wStoryModeCurrentLocation ; $66da
	farcall WriteStoryStateWord ; $66dd
	ld a, ISLANDOPENROUND_FINAL ; $66e0
	ld [wMapSceneStage], a ; $66e2
	ret ; $66e5
.checkRound1:
	test_flag FLAG_WON_ISLAND_OPEN_DOUBLES_ROUND_1 ; $66e6
	jr z, .round1 ; $66e9
	script_respawn_actors IslandOpenSemifinalActorsDoubles_0f ; $66eb
	ld hl, IslandOpenSemifinalNpcScriptsDoubles_0f ; $66f3
	ld de, wMapNpcScriptsPtr - wStoryModeCurrentLocation ; $66f6
	farcall WriteStoryStateWord ; $66f9
	ld a, ISLANDOPENROUND_SEMIFINAL ; $66fc
	ld [wMapSceneStage], a ; $66fe
	ret ; $6701
.round1:
	script_respawn_actors IslandOpenRound1ActorsDoubles_0f ; $6702
	ld hl, IslandOpenRound1NpcScriptsDoubles_0f ; $670a
	ld de, wMapNpcScriptsPtr - wStoryModeCurrentLocation ; $670d
	farcall WriteStoryStateWord ; $6710
	ret ; $6713
IslandOpenRound2Actors_0f:
	; $6714, 206 bytes (map_actors)
	map_actor $0000, ActorScript_0f_09, 39.0, 17.0, FACE_LEFT, OBJ_TOURNAMENT_STAFF, ANIM_WALK, $00, ISLAND_OPEN_ROUND2_TOURNAMENT_STAFF_1
	map_actor $0000, ActorScript_0f_09, 19.0, 15.0, FACE_DOWN, OBJ_TOURNAMENT_STAFF, ANIM_WALK, $00, ISLAND_OPEN_ROUND2_TOURNAMENT_STAFF_2
	map_actor $0000, ActorScript_0f_09, 1.0, 11.0, FACE_RIGHT, OBJ_TOURNAMENT_STAFF, ANIM_WALK, $00, ISLAND_OPEN_ROUND2_TOURNAMENT_STAFF_3
	map_actor $0000, ActorScript_0f_09, 25.0, 21.0, FACE_DOWN, OBJ_KEVIN_SWEATS, ANIM_WALK, $00, ISLAND_OPEN_ROUND2_KEVIN_SWEATS
	map_actor $0000, ActorScript_0f_09, 25.0, 19.0, FACE_DOWN, OBJ_MARK_SWEATS, ANIM_WALK, $00, ISLAND_OPEN_ROUND2_MARK_SWEATS
	map_actor $0000, ActorScript_0f_09, 17.0, 19.0, FACE_DOWN, OBJ_EMILY_SWEATS, ANIM_WALK, $00, ISLAND_OPEN_ROUND2_EMILY_SWEATS
	map_actor $0000, ActorScript_0f_09, 29.0, 17.0, FACE_RIGHT, OBJ_SAMMI, ANIM_WALK, $00, ISLAND_OPEN_ROUND2_SAMMI
	map_actor $0000, ActorScript_0f_09, 17.0, 21.0, FACE_DOWN, OBJ_SPIKE, ANIM_WALK, $00, ISLAND_OPEN_ROUND2_SPIKE
	map_actor $0000, ActorScript_0f_09, 41.0, 25.0, FACE_LEFT, OBJ_ELDEN, ANIM_WALK, $00, ISLAND_OPEN_ROUND2_ELDEN
	map_actor $0000, ActorScript_0f_09, 23.0, 19.0, FACE_DOWN, OBJ_A_COZ, ANIM_WALK, $00, ISLAND_OPEN_ROUND2_A_COZ
	map_actor $0000, ActorScript_0f_09, 15.0, 19.0, FACE_DOWN, OBJ_B_COZ, ANIM_WALK, $00, ISLAND_OPEN_ROUND2_B_COZ
	map_actor $0000, ActorScript_0f_09, 29.0, 21.0, FACE_DOWN, OBJ_SEAN, ANIM_WALK, $00, ISLAND_OPEN_ROUND2_SEAN
	map_actor $0000, ActorScript_0f_09, 23.0, 21.0, FACE_DOWN, OBJ_FRANK, ANIM_WALK, $00, ISLAND_OPEN_ROUND2_FRANK
	map_actor $0000, ActorScript_0f_08, 41.0, 19.0, FACE_DOWN, OBJ_ELLIS, ANIM_WALK, $00, ISLAND_OPEN_ROUND2_ELLIS
	map_actor_end
IslandOpenRound2NpcScripts_0f:
	; $67e2, 105 bytes (map_scripts)
	map_script ACTOR_ISLAND_OPEN_ROUND2_KEVIN_SWEATS, FACEMASK_ANY, $0000, Text_KevinRoundTwoYouPlaySpike, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_ISLAND_OPEN_ROUND2_MARK_SWEATS, FACEMASK_ANY, $0000, Text_MarkRoundTwoPlayACoz, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_ISLAND_OPEN_ROUND2_EMILY_SWEATS, FACEMASK_ANY, $0000, Text_EmilyRoundTwoNotGonnaLose, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_ISLAND_OPEN_ROUND2_SAMMI, FACEMASK_ANY, $0000, Text_SammiRoundTwoLostToPlayer, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_ISLAND_OPEN_ROUND2_SPIKE, FACEMASK_ANY, $0000, Text_SpikeRoundTwoSeededNoThreat, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_ISLAND_OPEN_ROUND2_ELDEN, FACEMASK_ANY, $0000, Text_EldenRoundTwoAvengeHonor, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_ISLAND_OPEN_ROUND2_A_COZ, FACEMASK_ANY, $0000, Text_ACozRoundTwoLoseToNoOne, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_ISLAND_OPEN_ROUND2_B_COZ, FACEMASK_ANY, $0000, Text_BCozRoundTwoPlaceholder, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_ISLAND_OPEN_ROUND2_SEAN, FACEMASK_ANY, $0000, Text_SeanRoundTwoPlaceholder, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_ISLAND_OPEN_ROUND2_FRANK, FACEMASK_ANY, $0000, Text_FrankRoundTwoPlaceholder, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_ISLAND_OPEN_ROUND2_ELLIS, FACEMASK_ANY, $0000, Text_EllisRoundTwoPlaceholder, NPC_FACE_PLAYER | NPC_RESTORE_FACING | NPC_FREEZE, $00
	map_script ACTOR_ISLAND_OPEN_ROUND2_TOURNAMENT_STAFF_1, FACEMASK_ANY, $0000, TournamentNpc03_0f, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_ISLAND_OPEN_ROUND2_TOURNAMENT_STAFF_2, FACEMASK_ANY, $0000, TournamentNpc04_0f, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	db $ff
IslandOpenSemifinalActors_0f:
	; $684b, 206 bytes (map_actors)
	map_actor $0000, ActorScript_0f_09, 39.0, 17.0, FACE_LEFT, OBJ_TOURNAMENT_STAFF, ANIM_WALK, $00, ISLAND_OPEN_SEMIFINAL_TOURNAMENT_STAFF_1
	map_actor $0000, ActorScript_0f_09, 19.0, 15.0, FACE_DOWN, OBJ_TOURNAMENT_STAFF, ANIM_WALK, $00, ISLAND_OPEN_SEMIFINAL_TOURNAMENT_STAFF_2
	map_actor $0000, ActorScript_0f_09, 1.0, 11.0, FACE_RIGHT, OBJ_TOURNAMENT_STAFF, ANIM_WALK, $00, ISLAND_OPEN_SEMIFINAL_TOURNAMENT_STAFF_3
	map_actor $0000, ActorScript_0f_09, 23.0, 21.0, FACE_DOWN, OBJ_KEVIN_SWEATS, ANIM_WALK, $00, ISLAND_OPEN_SEMIFINAL_KEVIN_SWEATS
	map_actor $0000, ActorScript_0f_11, 35.0, 23.0, FACE_UP, OBJ_MARK_SWEATS, ANIM_WALK, $00, ISLAND_OPEN_SEMIFINAL_MARK_SWEATS
	map_actor $0000, ActorScript_0f_09, 29.0, 17.0, FACE_RIGHT, OBJ_SAMMI, ANIM_WALK, $00, ISLAND_OPEN_SEMIFINAL_SAMMI
	map_actor $0000, ActorScript_0f_09, 41.0, 23.0, FACE_LEFT, OBJ_SPIKE, ANIM_WALK, $00, ISLAND_OPEN_SEMIFINAL_SPIKE
	map_actor $0000, ActorScript_0f_09, 17.0, 21.0, FACE_DOWN, OBJ_EMILY_SWEATS, ANIM_WALK, $00, ISLAND_OPEN_SEMIFINAL_EMILY_SWEATS
	map_actor $0000, ActorScript_0f_09, 41.0, 25.0, FACE_LEFT, OBJ_ELDEN, ANIM_WALK, $00, ISLAND_OPEN_SEMIFINAL_ELDEN
	map_actor $0000, ActorScript_0f_09, 25.0, 21.0, FACE_DOWN, OBJ_A_COZ, ANIM_WALK, $00, ISLAND_OPEN_SEMIFINAL_A_COZ
	map_actor $0000, ActorScript_0f_10, 7.0, 31.0, FACE_DOWN, OBJ_B_COZ, ANIM_WALK, $00, ISLAND_OPEN_SEMIFINAL_B_COZ
	map_actor $0000, ActorScript_0f_09, 29.0, 19.0, FACE_RIGHT, OBJ_SEAN, ANIM_WALK, $00, ISLAND_OPEN_SEMIFINAL_SEAN
	map_actor $0000, ActorScript_0f_09, 5.0, 33.0, FACE_DOWN, OBJ_FRANK, ANIM_WALK, $00, ISLAND_OPEN_SEMIFINAL_FRANK
	map_actor $0000, ActorScript_0f_08, 41.0, 19.0, FACE_DOWN, OBJ_ELLIS, ANIM_WALK, $00, ISLAND_OPEN_SEMIFINAL_ELLIS
	map_actor_end
IslandOpenSemifinalNpcScripts_0f:
	; $6919, 105 bytes (map_scripts)
	map_script ACTOR_ISLAND_OPEN_SEMIFINAL_KEVIN_SWEATS, FACEMASK_ANY, $0000, Text_KevinSemifinalEmilyOpponent, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_ISLAND_OPEN_SEMIFINAL_MARK_SWEATS, FACEMASK_ANY, $0000, Text_MarkSemifinalPressureGotToMe, NPC_FACE_PLAYER | NPC_RESTORE_FACING | NPC_FREEZE, $00
	map_script ACTOR_ISLAND_OPEN_SEMIFINAL_SAMMI, FACEMASK_ANY, $0000, Text_SammiSemifinalLostToPlayer, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_ISLAND_OPEN_SEMIFINAL_SPIKE, FACEMASK_ANY, $0000, Text_SpikeSemifinalSilence, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_ISLAND_OPEN_SEMIFINAL_EMILY_SWEATS, FACEMASK_ANY, $0000, Text_EmilySemifinalYoureMyOpponent, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_ISLAND_OPEN_SEMIFINAL_ELDEN, FACEMASK_ANY, $0000, Text_EldenSemifinalHaveRevenge, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_ISLAND_OPEN_SEMIFINAL_A_COZ, FACEMASK_ANY, $0000, Text_ACozSemifinalPlayKevin, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_ISLAND_OPEN_SEMIFINAL_B_COZ, FACEMASK_ANY, $0000, Text_BCozSemifinalEmilyWasGood, NPC_FACE_PLAYER | NPC_RESTORE_FACING | NPC_FREEZE, $00
	map_script ACTOR_ISLAND_OPEN_SEMIFINAL_SEAN, FACEMASK_ANY, $0000, Text_SeanSemifinalUnionLost, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_ISLAND_OPEN_SEMIFINAL_FRANK, FACEMASK_ANY, $0000, Text_FrankSemifinalACozOnlyLeft, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_ISLAND_OPEN_SEMIFINAL_ELLIS, FACEMASK_ANY, $0000, Text_EllisSemifinalThoughtSpikeWins, NPC_FACE_PLAYER | NPC_RESTORE_FACING | NPC_FREEZE, $00
	map_script ACTOR_ISLAND_OPEN_SEMIFINAL_TOURNAMENT_STAFF_1, FACEMASK_ANY, $0000, TournamentNpc03_0f, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_ISLAND_OPEN_SEMIFINAL_TOURNAMENT_STAFF_2, FACEMASK_ANY, $0000, TournamentNpc04_0f, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	db $ff
IslandOpenFinalActors_0f:
	; $6982, 206 bytes (map_actors)
	map_actor $0000, ActorScript_0f_09, 39.0, 17.0, FACE_LEFT, OBJ_TOURNAMENT_STAFF, ANIM_WALK, $00, ISLAND_OPEN_FINAL_TOURNAMENT_STAFF_1
	map_actor $0000, ActorScript_0f_09, 19.0, 15.0, FACE_DOWN, OBJ_TOURNAMENT_STAFF, ANIM_WALK, $00, ISLAND_OPEN_FINAL_TOURNAMENT_STAFF_2
	map_actor $0000, ActorScript_0f_09, 14.0, 4.0, FACE_RIGHT, OBJ_TOURNAMENT_STAFF, ANIM_WALK, $00, ISLAND_OPEN_FINAL_TOURNAMENT_STAFF_3
	map_actor $0000, ActorScript_0f_09, 35.0, 17.0, FACE_UP, OBJ_KEVIN_SWEATS, ANIM_WALK, $00, ISLAND_OPEN_FINAL_KEVIN_SWEATS
	map_actor $0000, ActorScript_0f_11, 35.0, 23.0, FACE_UP, OBJ_MARK_SWEATS, ANIM_WALK, $00, ISLAND_OPEN_FINAL_MARK_SWEATS
	map_actor $0000, ActorScript_0f_09, 29.0, 17.0, FACE_RIGHT, OBJ_SAMMI, ANIM_WALK, $00, ISLAND_OPEN_FINAL_SAMMI
	map_actor $0000, ActorScript_0f_09, 41.0, 23.0, FACE_LEFT, OBJ_SPIKE, ANIM_WALK, $00, ISLAND_OPEN_FINAL_SPIKE
	map_actor $0000, ActorScript_0f_09, 17.0, 21.0, FACE_DOWN, OBJ_A_COZ, ANIM_WALK, $00, ISLAND_OPEN_FINAL_A_COZ
	map_actor $0000, ActorScript_0f_09, 33.0, 17.0, FACE_RIGHT, OBJ_EMILY_SWEATS, ANIM_WALK, $00, ISLAND_OPEN_FINAL_EMILY_SWEATS
	map_actor $0000, ActorScript_0f_09, 41.0, 25.0, FACE_LEFT, OBJ_ELDEN, ANIM_WALK, $00, ISLAND_OPEN_FINAL_ELDEN
	map_actor $0000, ActorScript_0f_10, 7.0, 31.0, FACE_DOWN, OBJ_B_COZ, ANIM_WALK, $00, ISLAND_OPEN_FINAL_B_COZ
	map_actor $0000, ActorScript_0f_09, 29.0, 19.0, FACE_RIGHT, OBJ_SEAN, ANIM_WALK, $00, ISLAND_OPEN_FINAL_SEAN
	map_actor $0000, ActorScript_0f_09, 5.0, 33.0, FACE_DOWN, OBJ_FRANK, ANIM_WALK, $00, ISLAND_OPEN_FINAL_FRANK
	map_actor $0000, ActorScript_0f_08, 41.0, 19.0, FACE_DOWN, OBJ_ELLIS, ANIM_WALK, $00, ISLAND_OPEN_FINAL_ELLIS
	map_actor_end
IslandOpenFinalNpcScripts_0f:
	; $6a50, 105 bytes (map_scripts)
	map_script ACTOR_ISLAND_OPEN_FINAL_KEVIN_SWEATS, FACEMASK_ANY, $0000, Text_KevinFinalOpponentACoz, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_ISLAND_OPEN_FINAL_MARK_SWEATS, FACEMASK_ANY, $0000, Text_MarkFinalPressureGotToMe, NPC_FACE_PLAYER | NPC_RESTORE_FACING | NPC_FREEZE, $00
	map_script ACTOR_ISLAND_OPEN_FINAL_SAMMI, FACEMASK_ANY, $0000, Text_SammiFinalLostToPlayer, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_ISLAND_OPEN_FINAL_SPIKE, FACEMASK_ANY, $0000, Text_SpikeFinalSilence, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_ISLAND_OPEN_FINAL_A_COZ, FACEMASK_ANY, $0000, Text_ACozFinalUpsetOverEmily, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_ISLAND_OPEN_FINAL_EMILY_SWEATS, FACEMASK_ANY, $0000, Text_EmilyFinalJustDoYourBest, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_ISLAND_OPEN_FINAL_ELDEN, FACEMASK_ANY, $0000, Text_EldenFinalHaveRevenge, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_ISLAND_OPEN_FINAL_B_COZ, FACEMASK_ANY, $0000, Text_BCozFinalEmilyWasGood, NPC_FACE_PLAYER | NPC_RESTORE_FACING | NPC_FREEZE, $00
	map_script ACTOR_ISLAND_OPEN_FINAL_SEAN, FACEMASK_ANY, $0000, Text_SeanFinalUnionLost, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_ISLAND_OPEN_FINAL_FRANK, FACEMASK_ANY, $0000, Text_FrankFinalACozOnlyLeft, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_ISLAND_OPEN_FINAL_ELLIS, FACEMASK_ANY, $0000, Text_EllisFinalThoughtSpikeWins, NPC_FACE_PLAYER | NPC_RESTORE_FACING | NPC_FREEZE, $00
	map_script ACTOR_ISLAND_OPEN_FINAL_TOURNAMENT_STAFF_1, FACEMASK_ANY, $0000, TournamentNpc03_0f, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_ISLAND_OPEN_FINAL_TOURNAMENT_STAFF_2, FACEMASK_ANY, $0000, TournamentNpc04_0f, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	db $ff
IslandOpenRound1ActorsDoubles_0f:
	; $6ab9, 192 bytes (map_actors)
	map_actor $0000, ActorScript_0f_09, 39.0, 17.0, FACE_LEFT, OBJ_TOURNAMENT_STAFF, ANIM_WALK, $00, ISLAND_OPEN_ROUND1_DOUBLES_TOURNAMENT_STAFF_1
	map_actor $0000, ActorScript_0f_09, 19.0, 15.0, FACE_DOWN, OBJ_TOURNAMENT_STAFF, ANIM_WALK, $00, ISLAND_OPEN_ROUND1_DOUBLES_TOURNAMENT_STAFF_2
	map_actor $0000, ActorScript_0f_09, 1.0, 11.0, FACE_RIGHT, OBJ_TOURNAMENT_STAFF, ANIM_WALK, $00, ISLAND_OPEN_ROUND1_DOUBLES_TOURNAMENT_STAFF_3
	map_actor $0000, ActorScript_0f_09, 35.0, 17.0, FACE_UP, OBJ_KEVIN_SWEATS, ANIM_WALK, $00, ISLAND_OPEN_ROUND1_DOUBLES_KEVIN_SWEATS
	map_actor $0000, ActorScript_0f_11, 35.0, 23.0, FACE_RIGHT, OBJ_EMILY_SWEATS, ANIM_WALK, $00, ISLAND_OPEN_ROUND1_DOUBLES_EMILY_SWEATS
	map_actor $0000, ActorScript_0f_09, 41.0, 23.0, FACE_LEFT, OBJ_SPIKE, ANIM_WALK, $00, ISLAND_OPEN_ROUND1_DOUBLES_SPIKE
	map_actor $0000, ActorScript_0f_09, 41.0, 25.0, FACE_LEFT, OBJ_ELDEN, ANIM_WALK, $00, ISLAND_OPEN_ROUND1_DOUBLES_ELDEN
	map_actor $0000, ActorScript_0f_09, 15.0, 19.0, FACE_DOWN, OBJ_SAMMI, ANIM_WALK, $00, ISLAND_OPEN_ROUND1_DOUBLES_SAMMI
	map_actor $0000, ActorScript_0f_09, 17.0, 19.0, FACE_DOWN, OBJ_SEAN, ANIM_WALK, $00, ISLAND_OPEN_ROUND1_DOUBLES_SEAN
	map_actor $0000, ActorScript_0f_09, 23.0, 19.0, FACE_UP, OBJ_A_COZ, ANIM_WALK, $00, ISLAND_OPEN_ROUND1_DOUBLES_A_COZ
	map_actor $0000, ActorScript_0f_07, 25.0, 16.75, FACE_LEFT, OBJ_B_COZ, ANIM_WALK, $00, ISLAND_OPEN_ROUND1_DOUBLES_B_COZ
	map_actor $0000, ActorScript_0f_09, 23.0, 21.0, FACE_DOWN, OBJ_ELLIS, ANIM_WALK, $00, ISLAND_OPEN_ROUND1_DOUBLES_ELLIS
	map_actor $0000, ActorScript_0f_09, 25.0, 21.0, FACE_DOWN, OBJ_FRANK, ANIM_WALK, $05, ISLAND_OPEN_ROUND1_DOUBLES_EDGAR
	map_actor_end
IslandOpenRound1NpcScriptsDoubles_0f:
	; $6b79, 97 bytes (map_scripts)
	map_script ACTOR_ISLAND_OPEN_ROUND1_DOUBLES_KEVIN_SWEATS, FACEMASK_ANY, $0000, Text_KevinDoublesRoundOnePlayUnion, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_ISLAND_OPEN_ROUND1_DOUBLES_EMILY_SWEATS, FACEMASK_ANY, $0000, Text_EmilyDoublesRoundOneUnionFirst, NPC_FACE_PLAYER | NPC_RESTORE_FACING | NPC_FREEZE, $00
	map_script ACTOR_ISLAND_OPEN_ROUND1_DOUBLES_SPIKE, FACEMASK_ANY, $0000, Text_SpikeDoublesRoundOneIntro, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_ISLAND_OPEN_ROUND1_DOUBLES_ELDEN, FACEMASK_ANY, $0000, Text_EldenDoublesRoundOnePlayOurTeam, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_ISLAND_OPEN_ROUND1_DOUBLES_SAMMI, FACEMASK_ANY, $0000, IslandOpenRound1DoublesNpc0ASammi_0f, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_ISLAND_OPEN_ROUND1_DOUBLES_SEAN, FACEMASK_ANY, $0000, IslandOpenRound1DoublesNpc0BSean_0f, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_ISLAND_OPEN_ROUND1_DOUBLES_A_COZ, FACEMASK_ANY, $0000, Text_ACozDoublesRoundOneBornToFight, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_ISLAND_OPEN_ROUND1_DOUBLES_B_COZ, FACEMASK_ANY, $0000, IslandOpenRound1DoublesNpc0DBCoz_0f, NPC_FACE_PLAYER | NPC_RESTORE_FACING | NPC_FREEZE, $00
	map_script ACTOR_ISLAND_OPEN_ROUND1_DOUBLES_ELLIS, FACEMASK_ANY, $0000, Text_EllisDoublesRoundOneBadFeeling, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_ISLAND_OPEN_ROUND1_DOUBLES_EDGAR, FACEMASK_ANY, $0000, Text_EdgarDoublesRoundOneWildBrother, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_ISLAND_OPEN_ROUND1_DOUBLES_TOURNAMENT_STAFF_1, FACEMASK_ANY, $0000, TournamentNpc03_0f, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_ISLAND_OPEN_ROUND1_DOUBLES_TOURNAMENT_STAFF_2, FACEMASK_ANY, $0000, TournamentNpc04_0f, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	db $ff
IslandOpenRound1DoublesNpc0ASammi_0f:
	script_set_text Text_SammiDoublesRoundOneIntro ; $6bda
	script_speak_restore ACTOR_ISLAND_OPEN_ROUND1_DOUBLES_SAMMI ; $6be0
	farcall RunDialogueYesNoPrompt ; $6be5
	farcall ScriptCloseDialogueWindow ; $6be8
	script_wait_frames 5 ; $6beb
	and a ; $6bf2
	jr z, .speak ; $6bf3
	farcall AdvanceDialogueTextCursor ; $6bf5
.speak:
	script_speak ACTOR_ISLAND_OPEN_ROUND1_DOUBLES_SAMMI ; $6bf8
	ret ; $6bfd
IslandOpenRound1DoublesNpc0BSean_0f:
	script_set_text Text_SeanDoublesRoundOneIntro ; $6bfe
	script_speak_restore ACTOR_ISLAND_OPEN_ROUND1_DOUBLES_SEAN ; $6c04
	farcall RunDialogueYesNoPrompt ; $6c09
	farcall ScriptCloseDialogueWindow ; $6c0c
	script_wait_frames 5 ; $6c0f
	and a ; $6c16
	jr z, .speak ; $6c17
	farcall AdvanceDialogueTextCursor ; $6c19
.speak:
	script_speak ACTOR_ISLAND_OPEN_ROUND1_DOUBLES_SEAN ; $6c1c
	ret ; $6c21
IslandOpenRound1DoublesNpc0DBCoz_0f:
	script_set_text Text_BCozDoublesRoundOneTimeToPlay ; $6c22
	script_speak_restore ACTOR_ISLAND_OPEN_ROUND1_DOUBLES_B_COZ ; $6c28
	farcall RunDialogueYesNoPrompt ; $6c2d
	farcall ScriptCloseDialogueWindow ; $6c30
	script_wait_frames 5 ; $6c33
	and a ; $6c3a
	jr z, .speak ; $6c3b
	farcall AdvanceDialogueTextCursor ; $6c3d
.speak:
	script_speak ACTOR_ISLAND_OPEN_ROUND1_DOUBLES_B_COZ ; $6c40
	ret ; $6c45
IslandOpenSemifinalActorsDoubles_0f:
	; $6c46, 192 bytes (map_actors)
	map_actor $0000, ActorScript_0f_09, 39.0, 17.0, FACE_LEFT, OBJ_TOURNAMENT_STAFF, ANIM_WALK, $00, ISLAND_OPEN_SEMIFINAL_DOUBLES_TOURNAMENT_STAFF_1
	map_actor $0000, ActorScript_0f_09, 19.0, 15.0, FACE_DOWN, OBJ_TOURNAMENT_STAFF, ANIM_WALK, $00, ISLAND_OPEN_SEMIFINAL_DOUBLES_TOURNAMENT_STAFF_2
	map_actor $0000, ActorScript_0f_09, 1.0, 11.0, FACE_RIGHT, OBJ_TOURNAMENT_STAFF, ANIM_WALK, $00, ISLAND_OPEN_SEMIFINAL_DOUBLES_TOURNAMENT_STAFF_3
	map_actor $0000, ActorScript_0f_09, 23.0, 21.0, FACE_DOWN, OBJ_KEVIN_SWEATS, ANIM_WALK, $00, ISLAND_OPEN_SEMIFINAL_DOUBLES_KEVIN_SWEATS
	map_actor $0000, ActorScript_0f_09, 25.0, 21.0, FACE_DOWN, OBJ_EMILY_SWEATS, ANIM_WALK, $00, ISLAND_OPEN_SEMIFINAL_DOUBLES_EMILY_SWEATS
	map_actor $0000, ActorScript_0f_09, 29.0, 17.0, FACE_RIGHT, OBJ_SAMMI, ANIM_WALK, $00, ISLAND_OPEN_SEMIFINAL_DOUBLES_SAMMI
	map_actor $0000, ActorScript_0f_09, 29.0, 21.0, FACE_DOWN, OBJ_SEAN, ANIM_WALK, $00, ISLAND_OPEN_SEMIFINAL_DOUBLES_SEAN
	map_actor $0000, ActorScript_0f_09, 15.0, 19.0, FACE_DOWN, OBJ_SPIKE, ANIM_WALK, $00, ISLAND_OPEN_SEMIFINAL_DOUBLES_SPIKE
	map_actor $0000, ActorScript_0f_09, 17.0, 19.0, FACE_DOWN, OBJ_ELDEN, ANIM_WALK, $00, ISLAND_OPEN_SEMIFINAL_DOUBLES_ELDEN
	map_actor $0000, ActorScript_0f_09, 23.0, 19.0, FACE_UP, OBJ_A_COZ, ANIM_WALK, $00, ISLAND_OPEN_SEMIFINAL_DOUBLES_A_COZ
	map_actor $0000, ActorScript_0f_07, 25.0, 16.75, FACE_LEFT, OBJ_B_COZ, ANIM_WALK, $00, ISLAND_OPEN_SEMIFINAL_DOUBLES_B_COZ
	map_actor $0000, ActorScript_0f_09, 41.0, 19.0, FACE_UP, OBJ_ELLIS, ANIM_WALK, $00, ISLAND_OPEN_SEMIFINAL_DOUBLES_ELLIS
	map_actor $0000, ActorScript_0f_11, 37.0, 25.0, FACE_DOWN, OBJ_FRANK, ANIM_WALK, $05, ISLAND_OPEN_SEMIFINAL_DOUBLES_EDGAR
	map_actor_end
IslandOpenSemifinalNpcScriptsDoubles_0f:
	; $6d06, 97 bytes (map_scripts)
	map_script ACTOR_ISLAND_OPEN_SEMIFINAL_DOUBLES_KEVIN_SWEATS, FACEMASK_ANY, $0000, Text_KevinDoublesSemifinalPlayEmpire, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_ISLAND_OPEN_SEMIFINAL_DOUBLES_EMILY_SWEATS, FACEMASK_ANY, $0000, Text_EmilyDoublesSemifinalTeamwork, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_ISLAND_OPEN_SEMIFINAL_DOUBLES_SAMMI, FACEMASK_ANY, $0000, IslandOpenSemifinalDoublesNpc08Sammi_0f, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_ISLAND_OPEN_SEMIFINAL_DOUBLES_SEAN, FACEMASK_ANY, $0000, Text_SeanDoublesSemifinalBetterToLose, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_ISLAND_OPEN_SEMIFINAL_DOUBLES_SPIKE, FACEMASK_ANY, $0000, Text_SpikeDoublesSemifinalCantWait, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_ISLAND_OPEN_SEMIFINAL_DOUBLES_ELDEN, FACEMASK_ANY, $0000, Text_EldenDoublesSemifinalLendCourage, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_ISLAND_OPEN_SEMIFINAL_DOUBLES_A_COZ, FACEMASK_ANY, $0000, Text_ACozDoublesSemifinalTruePower, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_ISLAND_OPEN_SEMIFINAL_DOUBLES_B_COZ, FACEMASK_ANY, $0000, IslandOpenSemifinalDoublesNpc0DBCoz_0f, NPC_FACE_PLAYER | NPC_RESTORE_FACING | NPC_FREEZE, $00
	map_script ACTOR_ISLAND_OPEN_SEMIFINAL_DOUBLES_ELLIS, FACEMASK_ANY, $0000, Text_EllisDoublesSemifinalGutWasRight, NPC_FACE_PLAYER | NPC_RESTORE_FACING | NPC_FREEZE, $00
	map_script ACTOR_ISLAND_OPEN_SEMIFINAL_DOUBLES_EDGAR, FACEMASK_ANY, $0000, Text_EdgarDoublesSemifinalMonsters, NPC_FACE_PLAYER | NPC_RESTORE_FACING | NPC_FREEZE, $00
	map_script ACTOR_ISLAND_OPEN_SEMIFINAL_DOUBLES_TOURNAMENT_STAFF_1, FACEMASK_ANY, $0000, TournamentNpc03_0f, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_ISLAND_OPEN_SEMIFINAL_DOUBLES_TOURNAMENT_STAFF_2, FACEMASK_ANY, $0000, TournamentNpc04_0f, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	db $ff
IslandOpenSemifinalDoublesNpc08Sammi_0f:
	script_set_text Text_SammiDoublesSemifinalWeLost ; $6d67
	script_speak_restore ACTOR_ISLAND_OPEN_SEMIFINAL_DOUBLES_SAMMI ; $6d6d
	farcall RunDialogueYesNoPrompt ; $6d72
	farcall ScriptCloseDialogueWindow ; $6d75
	script_wait_frames 5 ; $6d78
	and a ; $6d7f
	jr z, .speak ; $6d80
	farcall AdvanceDialogueTextCursor ; $6d82
.speak:
	script_speak ACTOR_ISLAND_OPEN_SEMIFINAL_DOUBLES_SAMMI ; $6d85
	ret ; $6d8a
IslandOpenSemifinalDoublesNpc0DBCoz_0f:
	script_set_text Text_BCozDoublesSemifinalIsItTime ; $6d8b
	script_speak_restore ACTOR_ISLAND_OPEN_SEMIFINAL_DOUBLES_B_COZ ; $6d91
	farcall RunDialogueYesNoPrompt ; $6d96
	farcall ScriptCloseDialogueWindow ; $6d99
	script_wait_frames 5 ; $6d9c
	and a ; $6da3
	jr z, .speak ; $6da4
	farcall AdvanceDialogueTextCursor ; $6da6
.speak:
	script_speak ACTOR_ISLAND_OPEN_SEMIFINAL_DOUBLES_B_COZ ; $6da9
	ret ; $6dae
IslandOpenFinalActorsDoubles_0f:
	; $6daf, 192 bytes (map_actors)
	map_actor $0000, ActorScript_0f_09, 39.0, 17.0, FACE_LEFT, OBJ_TOURNAMENT_STAFF, ANIM_WALK, $00, ISLAND_OPEN_FINAL_DOUBLES_TOURNAMENT_STAFF_1
	map_actor $0000, ActorScript_0f_09, 19.0, 15.0, FACE_DOWN, OBJ_TOURNAMENT_STAFF, ANIM_WALK, $00, ISLAND_OPEN_FINAL_DOUBLES_TOURNAMENT_STAFF_2
	map_actor $0000, ActorScript_0f_09, 14.0, 4.0, FACE_RIGHT, OBJ_TOURNAMENT_STAFF, ANIM_WALK, $00, ISLAND_OPEN_FINAL_DOUBLES_TOURNAMENT_STAFF_3
	map_actor $0000, ActorScript_0f_09, 35.0, 17.0, FACE_DOWN, OBJ_KEVIN_SWEATS, ANIM_WALK, $00, ISLAND_OPEN_FINAL_DOUBLES_KEVIN_SWEATS
	map_actor $0000, ActorScript_0f_09, 35.0, 19.0, FACE_UP, OBJ_EMILY_SWEATS, ANIM_WALK, $00, ISLAND_OPEN_FINAL_DOUBLES_EMILY_SWEATS
	map_actor $0000, ActorScript_0f_09, 41.0, 23.0, FACE_LEFT, OBJ_SPIKE, ANIM_WALK, $00, ISLAND_OPEN_FINAL_DOUBLES_SPIKE
	map_actor $0000, ActorScript_0f_09, 41.0, 25.0, FACE_LEFT, OBJ_ELDEN, ANIM_WALK, $00, ISLAND_OPEN_FINAL_DOUBLES_ELDEN
	map_actor $0000, ActorScript_0f_09, 15.0, 19.0, FACE_DOWN, OBJ_A_COZ, ANIM_WALK, $00, ISLAND_OPEN_FINAL_DOUBLES_A_COZ
	map_actor $0000, ActorScript_0f_09, 17.0, 19.0, FACE_DOWN, OBJ_B_COZ, ANIM_WALK, $00, ISLAND_OPEN_FINAL_DOUBLES_B_COZ
	map_actor $0000, ActorScript_0f_09, 29.0, 17.0, FACE_RIGHT, OBJ_SAMMI, ANIM_WALK, $00, ISLAND_OPEN_FINAL_DOUBLES_SAMMI
	map_actor $0000, ActorScript_0f_09, 29.0, 21.0, FACE_DOWN, OBJ_SEAN, ANIM_WALK, $00, ISLAND_OPEN_FINAL_DOUBLES_SEAN
	map_actor $0000, ActorScript_0f_09, 41.0, 21.0, FACE_DOWN, OBJ_ELLIS, ANIM_WALK, $00, ISLAND_OPEN_FINAL_DOUBLES_ELLIS
	map_actor $0000, ActorScript_0f_11, 36.0, 24.0, FACE_DOWN, OBJ_FRANK, ANIM_WALK, $05, ISLAND_OPEN_FINAL_DOUBLES_EDGAR
	map_actor_end
IslandOpenFinalNpcScriptsDoubles_0f:
	; $6e6f, 97 bytes (map_scripts)
	map_script ACTOR_ISLAND_OPEN_FINAL_DOUBLES_KEVIN_SWEATS, FACEMASK_ANY, $0000, Text_KevinDoublesFinalPlayCostellos, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_ISLAND_OPEN_FINAL_DOUBLES_EMILY_SWEATS, FACEMASK_ANY, $0000, Text_EmilyDoublesFinalBCozPower, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_ISLAND_OPEN_FINAL_DOUBLES_SPIKE, FACEMASK_ANY, $0000, Text_SpikeDoublesFinalSilence, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_ISLAND_OPEN_FINAL_DOUBLES_ELDEN, FACEMASK_ANY, $0000, Text_EldenDoublesFinalNewChapter, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_ISLAND_OPEN_FINAL_DOUBLES_A_COZ, FACEMASK_ANY, $0000, Text_ACozDoublesFinalLoseToNoOne, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_ISLAND_OPEN_FINAL_DOUBLES_B_COZ, FACEMASK_ANY, $0000, IslandOpenFinalDoublesNpc0BBCoz_0f, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_ISLAND_OPEN_FINAL_DOUBLES_SAMMI, FACEMASK_ANY, $0000, IslandOpenFinalDoublesNpc0CSammi_0f, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_ISLAND_OPEN_FINAL_DOUBLES_SEAN, FACEMASK_ANY, $0000, Text_SeanDoublesFinalBetterToLose, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_ISLAND_OPEN_FINAL_DOUBLES_ELLIS, FACEMASK_ANY, $0000, Text_EllisDoublesFinalWorstNightmare, NPC_FACE_PLAYER | NPC_RESTORE_FACING | NPC_FREEZE, $00
	map_script ACTOR_ISLAND_OPEN_FINAL_DOUBLES_EDGAR, FACEMASK_ANY, $0000, Text_EdgarDoublesFinalWildAnimals, NPC_FACE_PLAYER | NPC_RESTORE_FACING | NPC_FREEZE, $00
	map_script ACTOR_ISLAND_OPEN_FINAL_DOUBLES_TOURNAMENT_STAFF_1, FACEMASK_ANY, $0000, TournamentNpc03_0f, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_ISLAND_OPEN_FINAL_DOUBLES_TOURNAMENT_STAFF_2, FACEMASK_ANY, $0000, TournamentNpc04_0f, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	db $ff
IslandOpenFinalDoublesNpc0CSammi_0f:
	script_set_text Text_SammiDoublesFinalWeLost ; $6ed0
	script_speak_restore ACTOR_ISLAND_OPEN_FINAL_DOUBLES_SAMMI ; $6ed6
	farcall RunDialogueYesNoPrompt ; $6edb
	farcall ScriptCloseDialogueWindow ; $6ede
	script_wait_frames 5 ; $6ee1
	and a ; $6ee8
	jr z, .speak ; $6ee9
	farcall AdvanceDialogueTextCursor ; $6eeb
.speak:
	script_speak ACTOR_ISLAND_OPEN_FINAL_DOUBLES_SAMMI ; $6eee
	ret ; $6ef3
IslandOpenFinalDoublesNpc0BBCoz_0f:
	script_set_text Text_BCozDoublesFinalIsNextFinal ; $6ef4
	script_speak_restore ACTOR_ISLAND_OPEN_FINAL_DOUBLES_B_COZ ; $6efa
	farcall RunDialogueYesNoPrompt ; $6eff
	farcall ScriptCloseDialogueWindow ; $6f02
	script_wait_frames 5 ; $6f05
	and a ; $6f0c
	jr z, .speak ; $6f0d
	farcall AdvanceDialogueTextCursor ; $6f0f
.speak:
	script_speak ACTOR_ISLAND_OPEN_FINAL_DOUBLES_B_COZ ; $6f12
	ret ; $6f17
