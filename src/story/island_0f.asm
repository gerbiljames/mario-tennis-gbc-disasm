CheckAwardsCeremonyRivalSceneDone:
	test_flag FLAG_DOUBLES ; $5f7a
	jr z, .zero ; $5f7d
	ld a, $00 ; $5f7f
	test_flag FLAG_AWARDS_CEREMONY_SEEN_DOUBLES ; $5f81
	jr z, .done ; $5f84
	ld a, $01 ; $5f86
	jr .done ; $5f88
.zero:
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
	map_actor $0000, ActorScript_0f_09, $2700, $1100, FACE_LEFT, OBJ_WALK_6F_07, ANIM_WALK, $00, TOURNAMENT_WALK_6F_07_1
	map_actor $0000, ActorScript_0f_09, $1300, $0f00, FACE_DOWN, OBJ_WALK_6F_07, ANIM_WALK, $00, TOURNAMENT_WALK_6F_07_2
	map_actor $0000, ActorScript_0f_09, $0100, $0c00, FACE_RIGHT, OBJ_WALK_6F_07, ANIM_WALK, $00, TOURNAMENT_WALK_6F_07_3
	map_actor $0000, ActorScript_0f_09, $2300, $1100, FACE_UP, OBJ_WALK_74_08, ANIM_WALK, $00, TOURNAMENT_WALK_74_08
	map_actor $0000, ActorScript_0f_11, $2300, $1700, FACE_UP, OBJ_WALK_74_07, ANIM_WALK, $00, TOURNAMENT_WALK_74_07
	map_actor $0000, ActorScript_0f_09, $2100, $1100, FACE_RIGHT, OBJ_WALK_74_06, ANIM_WALK, $00, TOURNAMENT_WALK_74_06
	map_actor $0000, ActorScript_0f_09, $2900, $1700, FACE_LEFT, OBJ_SPIKE, ANIM_WALK, $00, TOURNAMENT_SPIKE
	map_actor $0000, ActorScript_0f_09, $1100, $1500, FACE_DOWN, OBJ_SAMMI, ANIM_WALK, $00, TOURNAMENT_SAMMI
	map_actor $0000, ActorScript_0f_09, $1900, $1300, FACE_DOWN, OBJ_ELDEN, ANIM_WALK, $00, TOURNAMENT_ELDEN
	map_actor $0000, ActorScript_0f_09, $1700, $1300, FACE_DOWN, OBJ_A_COZ, ANIM_WALK, $00, TOURNAMENT_A_COZ
	map_actor $0000, ActorScript_0f_09, $0f00, $1300, FACE_DOWN, OBJ_B_COZ, ANIM_WALK, $00, TOURNAMENT_B_COZ
	map_actor $0000, ActorScript_0f_09, $1900, $1500, FACE_DOWN, OBJ_SEAN, ANIM_WALK, $00, TOURNAMENT_SEAN
	map_actor $0000, ActorScript_0f_09, $1700, $1500, FACE_DOWN, OBJ_WALK_6F_00, ANIM_WALK, $00, TOURNAMENT_WALK_6F_00
	map_actor $0000, ActorScript_0f_09, $1100, $1300, FACE_DOWN, OBJ_WALK_6F_01, ANIM_WALK, $00, TOURNAMENT_WALK_6F_01
	map_actor_end
TournamentEntryPoints_0f:
	; $6070, 65 bytes (map_entries)
	map_entry $01, FACE_DOWN, $0e00, $0900, $0000
	map_entry $02, FACE_DOWN, $2a00, $0900, $0000
	map_entry $03, FACE_RIGHT, $0500, $0b00, $0000
	map_entry $04, FACE_LEFT, $3300, $0b00, $0000
	map_entry $05, FACE_UP, $1c00, $2300, $0000
	map_entry $0a, FACE_DOWN, $2500, $1100, $0000
	map_entry $0b, FACE_DOWN, $2300, $1100, $0000
	map_entry $0f, FACE_UP, $1b00, $3100, $0000
	db $ff
TournamentExitTriggers_0f:
	; $60b1, 41 bytes (map_scripts:exit)
	map_script $01, FACEMASK_ANY, $0000, TournamentExit_0f, STORYLOC_CENTER_COURT, $01
	map_script $02, FACEMASK_ANY, $0000, TournamentExit_0f, STORYLOC_CENTER_COURT, $02
	map_script $03, FACEMASK_ANY, $0000, TournamentExit_0f, STORYLOC_COURT_2, $01
	map_script $04, FACEMASK_ANY, $0000, TournamentExit_0f, STORYLOC_COURT_1, $01
	map_script $05, FACEMASK_ANY, $0000, TournamentExit_0f, STORYLOC_TOURNAMENT_COURTYARD, $03
	db $ff
TournamentExit_0f:
	clear_flag FLAG_ISLAND_OPEN_IN_PROGRESS ; $60da
	ret ; $60dd
TournamentNpc0A_0f:
	script_set_text Text_1f_163 ; $60de
	ld a, $0b ; $60e4
	farcall ScriptShowSpeakerDialogueRestoreBG ; $60e6
	farcall RunDialogueYesNoPrompt ; $60e9
	farcall ScriptCloseDialogueWindow ; $60ec
	script_wait_frames $05 ; $60ef
	and a ; $60f6
	jr z, .speak ; $60f7
	farcall AdvanceDialogueTextCursor ; $60f9
.speak:
	script_speak ACTOR_TOURNAMENT_ELDEN ; $60fc
	ret ; $6101
TournamentNpcScripts_0f:
	; $6102, 105 bytes (map_scripts)
	map_script ACTOR_TOURNAMENT_WALK_74_08, FACEMASK_ANY, $0000, Text_1f_159, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_TOURNAMENT_WALK_74_07, FACEMASK_ANY, $0000, Text_1f_160, NPC_FACE_PLAYER | NPC_RESTORE_FACING | NPC_FREEZE, $00
	map_script ACTOR_TOURNAMENT_WALK_74_06, FACEMASK_ANY, $0000, Text_1f_161, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_TOURNAMENT_SPIKE, FACEMASK_ANY, $0000, Text_1f_162, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_TOURNAMENT_SAMMI, FACEMASK_ANY, $0000, TournamentNpc0A_0f, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_TOURNAMENT_ELDEN, FACEMASK_ANY, $0000, Text_1f_166, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_TOURNAMENT_A_COZ, FACEMASK_ANY, $0000, Text_1f_167, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_TOURNAMENT_B_COZ, FACEMASK_ANY, $0000, Text_1f_168, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_TOURNAMENT_SEAN, FACEMASK_ANY, $0000, Text_1f_169, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_TOURNAMENT_WALK_6F_00, FACEMASK_ANY, $0000, Text_1f_170, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_TOURNAMENT_WALK_6F_01, FACEMASK_ANY, $0000, Text_1f_171, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_TOURNAMENT_WALK_6F_07_1, FACEMASK_ANY, $0000, TournamentNpc03_0f, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_TOURNAMENT_WALK_6F_07_2, FACEMASK_ANY, $0000, TournamentNpc04_0f, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	db $ff
TournamentFacingScripts_0f:
	; $616b, 9 bytes (map_scripts)
	map_script $01, FACEMASK_ANY, $0000, TournamentFacing01_0f, $00, $00
	db $ff
TournamentFacing01_0f:
	xor a ; $6174
	ldh [hBGColumnBlitPending], a ; $6175
	ldh [hBGRowBlitPending], a ; $6177
	ldh [hScrollY], a ; $6179
	ldh [hScrollX], a ; $617b
	ld [wCameraX + 1], a ; $617d
	ld [wCameraY + 1], a ; $6180
	call ClearFrameTasks ; $6183
	call GetIslandOpenRoundParams ; $6186
	ld d, $03 ; $6189
	farcall ShowRankingBoard ; $618b
	ld hl, wStoryModePlayersXPosition ; $618e
	ld de, wStoryModeSpawnPosition ; $6191
	ld bc, $0005 ; $6194
	call CopyMemoryBC ; $6197
	ld a, STORYENTRY_NONE ; $619a
	ld [wStoryModeEntryPoint], a ; $619c
	ld [wUnusedExitTriggerIdMirror], a ; $619f
	ld [wStoryModeExitTriggerRequest], a ; $61a2
	ret ; $61a5
TournamentTileTriggers_0f:
	; $61a6, 17 bytes (map_scripts)
	map_script $0e, FACEMASK_ANY, $0000, TournamentTile0E_0f, $00, $00
	map_script $0f, FACEMASK_ANY, $0000, TournamentTile0F_0f, $00, $00
	db $ff
TournamentTile0E_0f:
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
	as_set_target $1100, $1500
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_halt
ActorScript_0f_02:
	; $61eb, 11 bytes (actor_script)
	as_set_target $0f00, $1500
	as_wait_move
	as_set_field ACTORF_HEADING, FACE_DOWN
	as_halt
TournamentTile0F_0f:
	ld a, $00 ; $61f6
	ld [wMapSceneStage2], a ; $61f8
	script_set_actor_script ACTOR_PLAYER, ActorScript_0f_02 ; $61fb
	script_wait_actor_script ACTOR_PLAYER ; $6206
	call IslandOpenRoundCallCutscene ; $620b
	ret ; $620e
TournamentInitScript_0f:
	ld a, $01 ; $620f
	ld hl, UpdateTournamentActorDrawModes_0f ; $6211
	call RegisterFrameTask ; $6214
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
	jr nz, .singles ; $622e
	ldh a, [hRomBank] ; $6230
	ld hl, IslandOpenRoundActors_0f ; $6232
	farcall ScriptRespawnLocationActors ; $6235
	ld hl, IslandOpenRoundNpcScripts_0f ; $6238
	ld de, wMapNpcScriptsPtr - wStoryModeCurrentLocation ; $623b
	farcall WriteStoryStateWord ; $623e
	farcall BeginCutsceneScriptMode ; $6241
	script_set_position ACTOR_ISLAND_OPEN_ROUND_WALK_74_08, $1c00, $1c00 ; $6244
	script_set_position ACTOR_ISLAND_OPEN_ROUND_WALK_74_06, $1c00, $1f00 ; $624f
	script_set_position ACTOR_ISLAND_OPEN_ROUND_WALK_74_07, $1d00, $2100 ; $625a
	script_face ACTOR_ISLAND_OPEN_ROUND_WALK_74_08, FACE_DOWN ; $6265
	script_face ACTOR_ISLAND_OPEN_ROUND_WALK_74_06, FACE_DOWN ; $626c
	script_face ACTOR_ISLAND_OPEN_ROUND_WALK_74_07, FACE_LEFT ; $6273
	test_flag FLAG_DOUBLES ; $627a
	jr z, .setObjectDefs ; $627d
	script_set_position ACTOR_ISLAND_OPEN_ROUND_WALK_74_07, $3f00, $3f00 ; $627f
.setObjectDefs:
	call SetPlayerAndPartnerObjectDefs ; $628a
	ret ; $628d
.singles:
	test_flag FLAG_DOUBLES ; $628e
	jr nz, .doubles ; $6291
	ldh a, [hRomBank] ; $6293
	ld hl, IslandOpenRoundActorsSingles_0f ; $6295
	farcall ScriptRespawnLocationActors ; $6298
	ld hl, IslandOpenRoundNpcScriptsSingles_0f ; $629b
	ld de, wMapNpcScriptsPtr - wStoryModeCurrentLocation ; $629e
	farcall WriteStoryStateWord ; $62a1
	farcall BeginCutsceneScriptMode ; $62a4
	call SetPlayerAndPartnerObjectDefs ; $62a7
	script_face ACTOR_ISLAND_OPEN_ROUND_SINGLES_WALK_74_08, FACE_RIGHT ; $62aa
	script_set_position ACTOR_ISLAND_OPEN_ROUND_SINGLES_WALK_74_06, $2700, $1300 ; $62b1
	script_face ACTOR_ISLAND_OPEN_ROUND_SINGLES_WALK_74_06, FACE_LEFT ; $62bc
	ret ; $62c3
.doubles:
	ldh a, [hRomBank] ; $62c4
	ld hl, IslandOpenRoundActorsDoubles_0f ; $62c6
	farcall ScriptRespawnLocationActors ; $62c9
	ld hl, IslandOpenRoundNpcScriptsDoubles_0f ; $62cc
	ld de, wMapNpcScriptsPtr - wStoryModeCurrentLocation ; $62cf
	farcall WriteStoryStateWord ; $62d2
	farcall BeginCutsceneScriptMode ; $62d5
	call SetPlayerAndPartnerObjectDefs ; $62d8
	script_face_toward ACTOR_PLAYER, ACTOR_ISLAND_OPEN_ROUND_DOUBLES_WALK_74_06 ; $62db
	script_face ACTOR_ISLAND_OPEN_ROUND_DOUBLES_WALK_74_08, FACE_RIGHT ; $62e3
	ret ; $62ea
.notInProgress:
	ld a, [wStoryModeEntryPoint] ; $62eb
	cp $0f ; $62ee
	jr nz, .placeActors ; $62f0
	call IslandOpenArrivalCutscene ; $62f2
	ret ; $62f5
.placeActors:
	cp $0a ; $62f6
	jr nz, .placeActorsDoubles ; $62f8
	call IslandOpenSinglesMatchReturn ; $62fa
	ret ; $62fd
.placeActorsDoubles:
	cp $0b ; $62fe
	jr nz, .done ; $6300
	call IslandOpenDoublesMatchReturn ; $6302
	ret ; $6305
.done:
	call LoadIslandOpenRoundNpcs ; $6306
	call SetPlayerAndPartnerObjectDefs ; $6309
	call WalkActorsInFromEntryPoint_0f ; $630c
	ret ; $630f
UpdateTournamentActorDrawModes_0f:
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
	ld de, $ffb0 ; $633e
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
	jr nz, .checkBelow ; $635e
	wram_bank WRAM_ACTORS ; $6360
	ld hl, ACTORF_MODE ; $6366
	add hl, bc ; $6369
	ld a, [hl] ; $636a
	xor $01 ; $636b
	ld [hl], a ; $636d
	ret ; $636e
.checkBelow:
	inc d ; $636f
	call ReadSceneTilemapTile_0f ; $6370
	and $07 ; $6373
	cp $05 ; $6375
	jr nz, .actorLoop ; $6377
	wram_bank WRAM_ACTORS ; $6379
	ld hl, ACTORF_MODE ; $637f
	add hl, bc ; $6382
	ld a, [hl] ; $6383
	xor $01 ; $6384
	ld [hl], a ; $6386
	ret ; $6387
.actorLoop:
	wram_bank WRAM_ACTORS ; $6388
	ld hl, ACTORF_MODE ; $638e
	add hl, bc ; $6391
	ld a, $02 ; $6392
	ld [hl], a ; $6394
	ret ; $6395
; SetActorDrawModeFromSceneTile_0f without the push af / pop af / or a / jr z that makes the live one skip on a zero argument. Nothing calls it.
UnusedSetActorDrawModeFromSceneTileSingle_0f:
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
	ld de, $ffb0 ; $63b4
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
	jr nz, .nextActor ; $63d0
	wram_bank WRAM_ACTORS ; $63d2
	ld hl, ACTORF_MODE ; $63d8
	add hl, bc ; $63db
	ld a, [hl] ; $63dc
	xor $01 ; $63dd
	ld [hl], a ; $63df
	ret ; $63e0
.nextActor:
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
	ld a, $02 ; $6404
	ld [hl], a ; $6406
	ret ; $6407
; Instruction-identical to ReadSceneTilemapTile_10 (one copy per bank); a change here belongs in every copy.
	twin read_scene_tilemap_tile, 0f ; $6408 ReadSceneTilemapTile_0f
IslandOpenArrivalCutscene:
	set_flag FLAG_ISLAND_OPEN_IN_PROGRESS ; $6426
	ldh a, [hRomBank] ; $6429
	ld hl, IslandOpenRoundActors_0f ; $642b
	farcall ScriptRespawnLocationActors ; $642e
	ld hl, IslandOpenRoundNpcScripts_0f ; $6431
	ld de, wMapNpcScriptsPtr - wStoryModeCurrentLocation ; $6434
	farcall WriteStoryStateWord ; $6437
	farcall BeginCutsceneScriptMode ; $643a
	call ReplacePartnerWithStandInActor ; $643d
	script_player_speed $00ff ; $6440
	script_move_player $1c00, $2500 ; $6446
	farcall WaitPlayerMoveDone ; $6450
	script_fade_in $04 ; $6453
	call WaitFadeEnd ; $6458
	script_player_speed $0018 ; $645b
	script_move_player $1c00, $1b00 ; $6461
	script_move_target ACTOR_ISLAND_OPEN_ROUND_WALK_74_08, $1c00, $1c00 ; $646b
	script_move_target ACTOR_ISLAND_OPEN_ROUND_WALK_74_06, $1c00, $1f00 ; $6476
	script_move_target ACTOR_ISLAND_OPEN_ROUND_WALK_74_07, $1d00, $2100 ; $6481
	script_move_target ACTOR_PLAYER, $1b00, $2100 ; $648c
	script_wait_move ACTOR_PLAYER ; $6497
	script_wait_frames $28 ; $649c
	script_face ACTOR_ISLAND_OPEN_ROUND_WALK_74_08, FACE_DOWN ; $64a3
	script_set_text Text_1f_21 ; $64aa
	script_face ACTOR_PLAYER, FACE_DOWN ; $64b0
	script_wait_frames $28 ; $64b7
	script_face ACTOR_PLAYER, FACE_LEFT ; $64be
	script_wait_frames $28 ; $64c5
	script_face ACTOR_PLAYER, FACE_UP ; $64cc
	script_wait_frames $28 ; $64d3
	script_face ACTOR_PLAYER, FACE_RIGHT ; $64da
	script_wait_frames $28 ; $64e1
	script_face ACTOR_PLAYER, FACE_DOWN ; $64e8
	script_wait_frames $28 ; $64ef
	script_set_anim ACTOR_PLAYER, ANIM_BOUNCE ; $64f6
	script_wait_idle ACTOR_PLAYER ; $64fd
	script_face ACTOR_ISLAND_OPEN_ROUND_WALK_74_06, FACE_RIGHT ; $6502
	script_face ACTOR_ISLAND_OPEN_ROUND_WALK_74_06, FACE_DOWN ; $6509
	script_face ACTOR_ISLAND_OPEN_ROUND_WALK_74_07, FACE_LEFT ; $6510
	script_wait_frames $14 ; $6517
	script_set_anim ACTOR_ISLAND_OPEN_ROUND_WALK_74_06, ANIM_SHAKE ; $651e
	script_wait_idle ACTOR_ISLAND_OPEN_ROUND_WALK_74_06 ; $6525
	script_speak ACTOR_ISLAND_OPEN_ROUND_WALK_74_06 ; $652a
	script_face ACTOR_PLAYER, FACE_UP ; $652f
	script_wait_frames $28 ; $6536
	script_set_anim ACTOR_PLAYER, ANIM_NOD ; $653d
	script_wait_idle ACTOR_PLAYER ; $6544
	script_set_anim ACTOR_ISLAND_OPEN_ROUND_WALK_74_08, ANIM_BOUNCE ; $6549
	script_wait_idle ACTOR_ISLAND_OPEN_ROUND_WALK_74_08 ; $6550
	script_speak ACTOR_ISLAND_OPEN_ROUND_WALK_74_08 ; $6555
	script_set_anim ACTOR_PLAYER, ANIM_BOUNCE ; $655a
	script_wait_idle ACTOR_PLAYER ; $6561
	test_flag FLAG_DOUBLES ; $6566
	jr nz, .doubles ; $6569
	script_set_anim ACTOR_ISLAND_OPEN_ROUND_WALK_74_07, ANIM_NOD ; $656b
	script_wait_idle ACTOR_ISLAND_OPEN_ROUND_WALK_74_07 ; $6572
	script_speak ACTOR_ISLAND_OPEN_ROUND_WALK_74_07 ; $6577
	set_flag FLAG_REACHED_ISLAND_OPEN_SINGLES ; $657c
	jr .walkOn ; $657f
	ret ; $6581
.doubles:
	farcall AdvanceDialogueTextCursor ; $6582
	script_set_anim $04, ANIM_NOD ; $6585
	script_wait_idle $04 ; $658c
	script_speak $04 ; $6591
	script_get_actor_state $05 ; $6596
	ld c, l ; $659b
	ld b, h ; $659c
	ld de, wActors ; $659d
	farcall AttachActorStepMover ; $65a0
	set_flag FLAG_REACHED_ISLAND_OPEN_DOUBLES ; $65a3
.walkOn:
	script_player_speed $0018 ; $65a6
	script_move_player $1c00, $1d00 ; $65ac
	farcall WaitPlayerMoveDone ; $65b6
	ld a, ISLANDOPENROUND_ROUND1 ; $65b9
	ld [wMapSceneStage], a ; $65bb
	farcall SaveStorySlotWithTimer ; $65be
	ret ; $65c1
IslandOpenRoundActors_0f:
	; $65c2, 52 bytes (map_actors)
	map_actor $0000, ActorScript_0f_09, $1c00, $2c00, FACE_UP, OBJ_WALK_74_08, ANIM_WALK, $00, ISLAND_OPEN_ROUND_WALK_74_08
	map_actor $0000, ActorScript_0f_09, $1c00, $2f00, FACE_UP, OBJ_WALK_74_06, ANIM_WALK, $00, ISLAND_OPEN_ROUND_WALK_74_06
	map_actor $0000, ActorScript_0f_09, $1d00, $3100, FACE_UP, OBJ_WALK_74_07, ANIM_WALK, $00, ISLAND_OPEN_ROUND_WALK_74_07
	map_actor_end
IslandOpenRoundNpcScripts_0f:
	; $65f6, 25 bytes (map_scripts)
	map_script $03, FACEMASK_ANY, $0000, Text_1f_25, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script $04, FACEMASK_ANY, $0000, Text_1f_26, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script $05, FACEMASK_ANY, $0000, Text_1f_27, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
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
	jr z, .round0 ; $662d
	ld a, ISLANDOPENROUND_ROUND2 ; $662f
	ld [wMapSceneStage], a ; $6631
	ret ; $6634
.round0:
	ld a, ISLANDOPENROUND_ROUND1 ; $6635
	ld [wMapSceneStage], a ; $6637
	ret ; $663a
.doubles:
	test_flag FLAG_WON_ISLAND_OPEN_DOUBLES_SEMIFINAL ; $663b
	jr z, .doublesCheckRound2 ; $663e
	ld a, ISLANDOPENROUND_FINAL ; $6640
	ld [wMapSceneStage], a ; $6642
	ret ; $6645
.doublesCheckRound2:
	test_flag FLAG_WON_ISLAND_OPEN_DOUBLES_ROUND_1 ; $6646
	jr z, .round0 ; $6649
	ld a, ISLANDOPENROUND_SEMIFINAL ; $664b
	ld [wMapSceneStage], a ; $664d
	ret ; $6650
LoadIslandOpenRoundNpcs:
	ld a, ISLANDOPENROUND_ROUND1 ; $6651
	ld [wMapSceneStage], a ; $6653
	test_flag FLAG_DOUBLES ; $6656
	jr nz, LoadIslandOpenRoundNpcsDoubles ; $6659
	ld a, $f1 ; $665b
	ld d, $0e ; $665d
	ld e, $14 ; $665f
	farcall WriteBehaviorMapCell ; $6661
	test_flag FLAG_WON_ISLAND_OPEN_SINGLES_SEMIFINAL ; $6664
	jr z, .round2 ; $6667
	ldh a, [hRomBank] ; $6669
	ld hl, IslandOpenFinalActors_0f ; $666b
	farcall ScriptRespawnLocationActors ; $666e
	ld hl, IslandOpenFinalNpcScripts_0f ; $6671
	ld de, wMapNpcScriptsPtr - wStoryModeCurrentLocation ; $6674
	farcall WriteStoryStateWord ; $6677
	ld a, ISLANDOPENROUND_FINAL ; $667a
	ld [wMapSceneStage], a ; $667c
	ret ; $667f
.round2:
	test_flag FLAG_WON_ISLAND_OPEN_SINGLES_ROUND_2 ; $6680
	jr z, .round1 ; $6683
	ldh a, [hRomBank] ; $6685
	ld hl, IslandOpenSemifinalActors_0f ; $6687
	farcall ScriptRespawnLocationActors ; $668a
	ld hl, IslandOpenSemifinalNpcScripts_0f ; $668d
	ld de, wMapNpcScriptsPtr - wStoryModeCurrentLocation ; $6690
	farcall WriteStoryStateWord ; $6693
	ld a, ISLANDOPENROUND_SEMIFINAL ; $6696
	ld [wMapSceneStage], a ; $6698
	ret ; $669b
.round1:
	test_flag FLAG_WON_ISLAND_OPEN_SINGLES_ROUND_1 ; $669c
	jr z, .done ; $669f
	ldh a, [hRomBank] ; $66a1
	ld hl, IslandOpenRound2Actors_0f ; $66a3
	farcall ScriptRespawnLocationActors ; $66a6
	ld hl, IslandOpenRound2NpcScripts_0f ; $66a9
	ld de, wMapNpcScriptsPtr - wStoryModeCurrentLocation ; $66ac
	farcall WriteStoryStateWord ; $66af
	ld a, ISLANDOPENROUND_ROUND2 ; $66b2
	ld [wMapSceneStage], a ; $66b4
.done:
	ret ; $66b7
LoadIslandOpenRoundNpcsDoubles:
	ld a, $e1 ; $66b8
	ld d, $0e ; $66ba
	ld e, $14 ; $66bc
	farcall WriteBehaviorMapCell ; $66be
	ld a, $e1 ; $66c1
	ld d, $10 ; $66c3
	ld e, $14 ; $66c5
	farcall WriteBehaviorMapCell ; $66c7
	test_flag FLAG_WON_ISLAND_OPEN_DOUBLES_SEMIFINAL ; $66ca
	jr z, .round2 ; $66cd
	ldh a, [hRomBank] ; $66cf
	ld hl, IslandOpenFinalActorsDoubles_0f ; $66d1
	farcall ScriptRespawnLocationActors ; $66d4
	ld hl, IslandOpenFinalNpcScriptsDoubles_0f ; $66d7
	ld de, wMapNpcScriptsPtr - wStoryModeCurrentLocation ; $66da
	farcall WriteStoryStateWord ; $66dd
	ld a, ISLANDOPENROUND_FINAL ; $66e0
	ld [wMapSceneStage], a ; $66e2
	ret ; $66e5
.round2:
	test_flag FLAG_WON_ISLAND_OPEN_DOUBLES_ROUND_1 ; $66e6
	jr z, .round1 ; $66e9
	ldh a, [hRomBank] ; $66eb
	ld hl, IslandOpenSemifinalActorsDoubles_0f ; $66ed
	farcall ScriptRespawnLocationActors ; $66f0
	ld hl, IslandOpenSemifinalNpcScriptsDoubles_0f ; $66f3
	ld de, wMapNpcScriptsPtr - wStoryModeCurrentLocation ; $66f6
	farcall WriteStoryStateWord ; $66f9
	ld a, ISLANDOPENROUND_SEMIFINAL ; $66fc
	ld [wMapSceneStage], a ; $66fe
	ret ; $6701
.round1:
	ldh a, [hRomBank] ; $6702
	ld hl, IslandOpenRound1ActorsDoubles_0f ; $6704
	farcall ScriptRespawnLocationActors ; $6707
	ld hl, IslandOpenRound1NpcScriptsDoubles_0f ; $670a
	ld de, wMapNpcScriptsPtr - wStoryModeCurrentLocation ; $670d
	farcall WriteStoryStateWord ; $6710
	ret ; $6713
IslandOpenRound2Actors_0f:
	; $6714, 206 bytes (map_actors)
	map_actor $0000, ActorScript_0f_09, $2700, $1100, FACE_LEFT, OBJ_WALK_6F_07, ANIM_WALK, $00, ISLAND_OPEN_ROUND2_WALK_6F_07_1
	map_actor $0000, ActorScript_0f_09, $1300, $0f00, FACE_DOWN, OBJ_WALK_6F_07, ANIM_WALK, $00, ISLAND_OPEN_ROUND2_WALK_6F_07_2
	map_actor $0000, ActorScript_0f_09, $0100, $0b00, FACE_RIGHT, OBJ_WALK_6F_07, ANIM_WALK, $00, ISLAND_OPEN_ROUND2_WALK_6F_07_3
	map_actor $0000, ActorScript_0f_09, $1900, $1500, FACE_DOWN, OBJ_WALK_74_08, ANIM_WALK, $00, ISLAND_OPEN_ROUND2_WALK_74_08
	map_actor $0000, ActorScript_0f_09, $1900, $1300, FACE_DOWN, OBJ_WALK_74_07, ANIM_WALK, $00, ISLAND_OPEN_ROUND2_WALK_74_07
	map_actor $0000, ActorScript_0f_09, $1100, $1300, FACE_DOWN, OBJ_WALK_74_06, ANIM_WALK, $00, ISLAND_OPEN_ROUND2_WALK_74_06
	map_actor $0000, ActorScript_0f_09, $1d00, $1100, FACE_RIGHT, OBJ_SAMMI, ANIM_WALK, $00, ISLAND_OPEN_ROUND2_SAMMI
	map_actor $0000, ActorScript_0f_09, $1100, $1500, FACE_DOWN, OBJ_SPIKE, ANIM_WALK, $00, ISLAND_OPEN_ROUND2_SPIKE
	map_actor $0000, ActorScript_0f_09, $2900, $1900, FACE_LEFT, OBJ_ELDEN, ANIM_WALK, $00, ISLAND_OPEN_ROUND2_ELDEN
	map_actor $0000, ActorScript_0f_09, $1700, $1300, FACE_DOWN, OBJ_A_COZ, ANIM_WALK, $00, ISLAND_OPEN_ROUND2_A_COZ
	map_actor $0000, ActorScript_0f_09, $0f00, $1300, FACE_DOWN, OBJ_B_COZ, ANIM_WALK, $00, ISLAND_OPEN_ROUND2_B_COZ
	map_actor $0000, ActorScript_0f_09, $1d00, $1500, FACE_DOWN, OBJ_SEAN, ANIM_WALK, $00, ISLAND_OPEN_ROUND2_SEAN
	map_actor $0000, ActorScript_0f_09, $1700, $1500, FACE_DOWN, OBJ_WALK_6F_00, ANIM_WALK, $00, ISLAND_OPEN_ROUND2_WALK_6F_00
	map_actor $0000, ActorScript_0f_08, $2900, $1300, FACE_DOWN, OBJ_WALK_6F_01, ANIM_WALK, $00, ISLAND_OPEN_ROUND2_WALK_6F_01
	map_actor_end
IslandOpenRound2NpcScripts_0f:
	; $67e2, 105 bytes (map_scripts)
	map_script $06, FACEMASK_ANY, $0000, Text_1f_182, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script $07, FACEMASK_ANY, $0000, Text_1f_183, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script $08, FACEMASK_ANY, $0000, Text_1f_184, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script $09, FACEMASK_ANY, $0000, Text_1f_185, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script $0a, FACEMASK_ANY, $0000, Text_1f_186, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script $0b, FACEMASK_ANY, $0000, Text_1f_187, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script $0c, FACEMASK_ANY, $0000, Text_1f_188, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script $0d, FACEMASK_ANY, $0000, Text_1f_189, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script $0e, FACEMASK_ANY, $0000, Text_1f_190, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script $0f, FACEMASK_ANY, $0000, Text_1f_191, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script $10, FACEMASK_ANY, $0000, Text_1f_192, NPC_FACE_PLAYER | NPC_RESTORE_FACING | NPC_FREEZE, $00
	map_script $03, FACEMASK_ANY, $0000, TournamentNpc03_0f, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script $04, FACEMASK_ANY, $0000, TournamentNpc04_0f, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	db $ff
IslandOpenSemifinalActors_0f:
	; $684b, 206 bytes (map_actors)
	map_actor $0000, ActorScript_0f_09, $2700, $1100, FACE_LEFT, OBJ_WALK_6F_07, ANIM_WALK, $00, ISLAND_OPEN_SEMIFINAL_WALK_6F_07_1
	map_actor $0000, ActorScript_0f_09, $1300, $0f00, FACE_DOWN, OBJ_WALK_6F_07, ANIM_WALK, $00, ISLAND_OPEN_SEMIFINAL_WALK_6F_07_2
	map_actor $0000, ActorScript_0f_09, $0100, $0b00, FACE_RIGHT, OBJ_WALK_6F_07, ANIM_WALK, $00, ISLAND_OPEN_SEMIFINAL_WALK_6F_07_3
	map_actor $0000, ActorScript_0f_09, $1700, $1500, FACE_DOWN, OBJ_WALK_74_08, ANIM_WALK, $00, ISLAND_OPEN_SEMIFINAL_WALK_74_08
	map_actor $0000, ActorScript_0f_11, $2300, $1700, FACE_UP, OBJ_WALK_74_07, ANIM_WALK, $00, ISLAND_OPEN_SEMIFINAL_WALK_74_07
	map_actor $0000, ActorScript_0f_09, $1d00, $1100, FACE_RIGHT, OBJ_SAMMI, ANIM_WALK, $00, ISLAND_OPEN_SEMIFINAL_SAMMI
	map_actor $0000, ActorScript_0f_09, $2900, $1700, FACE_LEFT, OBJ_SPIKE, ANIM_WALK, $00, ISLAND_OPEN_SEMIFINAL_SPIKE
	map_actor $0000, ActorScript_0f_09, $1100, $1500, FACE_DOWN, OBJ_WALK_74_06, ANIM_WALK, $00, ISLAND_OPEN_SEMIFINAL_WALK_74_06
	map_actor $0000, ActorScript_0f_09, $2900, $1900, FACE_LEFT, OBJ_ELDEN, ANIM_WALK, $00, ISLAND_OPEN_SEMIFINAL_ELDEN
	map_actor $0000, ActorScript_0f_09, $1900, $1500, FACE_DOWN, OBJ_A_COZ, ANIM_WALK, $00, ISLAND_OPEN_SEMIFINAL_A_COZ
	map_actor $0000, ActorScript_0f_10, $0700, $1f00, FACE_DOWN, OBJ_B_COZ, ANIM_WALK, $00, ISLAND_OPEN_SEMIFINAL_B_COZ
	map_actor $0000, ActorScript_0f_09, $1d00, $1300, FACE_RIGHT, OBJ_SEAN, ANIM_WALK, $00, ISLAND_OPEN_SEMIFINAL_SEAN
	map_actor $0000, ActorScript_0f_09, $0500, $2100, FACE_DOWN, OBJ_WALK_6F_00, ANIM_WALK, $00, ISLAND_OPEN_SEMIFINAL_WALK_6F_00
	map_actor $0000, ActorScript_0f_08, $2900, $1300, FACE_DOWN, OBJ_WALK_6F_01, ANIM_WALK, $00, ISLAND_OPEN_SEMIFINAL_WALK_6F_01
	map_actor_end
IslandOpenSemifinalNpcScripts_0f:
	; $6919, 105 bytes (map_scripts)
	map_script $06, FACEMASK_ANY, $0000, Text_25_4, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script $07, FACEMASK_ANY, $0000, Text_25_5, NPC_FACE_PLAYER | NPC_RESTORE_FACING | NPC_FREEZE, $00
	map_script $08, FACEMASK_ANY, $0000, Text_25_6, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script $09, FACEMASK_ANY, $0000, Text_25_7, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script $0a, FACEMASK_ANY, $0000, Text_25_8, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script $0b, FACEMASK_ANY, $0000, Text_25_9, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script $0c, FACEMASK_ANY, $0000, Text_25_10, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script $0d, FACEMASK_ANY, $0000, Text_25_11, NPC_FACE_PLAYER | NPC_RESTORE_FACING | NPC_FREEZE, $00
	map_script $0e, FACEMASK_ANY, $0000, Text_25_12, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script $0f, FACEMASK_ANY, $0000, Text_25_13, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script $10, FACEMASK_ANY, $0000, Text_25_14, NPC_FACE_PLAYER | NPC_RESTORE_FACING | NPC_FREEZE, $00
	map_script $03, FACEMASK_ANY, $0000, TournamentNpc03_0f, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script $04, FACEMASK_ANY, $0000, TournamentNpc04_0f, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	db $ff
IslandOpenFinalActors_0f:
	; $6982, 206 bytes (map_actors)
	map_actor $0000, ActorScript_0f_09, $2700, $1100, FACE_LEFT, OBJ_WALK_6F_07, ANIM_WALK, $00, ISLAND_OPEN_FINAL_WALK_6F_07_1
	map_actor $0000, ActorScript_0f_09, $1300, $0f00, FACE_DOWN, OBJ_WALK_6F_07, ANIM_WALK, $00, ISLAND_OPEN_FINAL_WALK_6F_07_2
	map_actor $0000, ActorScript_0f_09, $0e00, $0400, FACE_RIGHT, OBJ_WALK_6F_07, ANIM_WALK, $00, ISLAND_OPEN_FINAL_WALK_6F_07_3
	map_actor $0000, ActorScript_0f_09, $2300, $1100, FACE_UP, OBJ_WALK_74_08, ANIM_WALK, $00, ISLAND_OPEN_FINAL_WALK_74_08
	map_actor $0000, ActorScript_0f_11, $2300, $1700, FACE_UP, OBJ_WALK_74_07, ANIM_WALK, $00, ISLAND_OPEN_FINAL_WALK_74_07
	map_actor $0000, ActorScript_0f_09, $1d00, $1100, FACE_RIGHT, OBJ_SAMMI, ANIM_WALK, $00, ISLAND_OPEN_FINAL_SAMMI
	map_actor $0000, ActorScript_0f_09, $2900, $1700, FACE_LEFT, OBJ_SPIKE, ANIM_WALK, $00, ISLAND_OPEN_FINAL_SPIKE
	map_actor $0000, ActorScript_0f_09, $1100, $1500, FACE_DOWN, OBJ_A_COZ, ANIM_WALK, $00, ISLAND_OPEN_FINAL_A_COZ
	map_actor $0000, ActorScript_0f_09, $2100, $1100, FACE_RIGHT, OBJ_WALK_74_06, ANIM_WALK, $00, ISLAND_OPEN_FINAL_WALK_74_06
	map_actor $0000, ActorScript_0f_09, $2900, $1900, FACE_LEFT, OBJ_ELDEN, ANIM_WALK, $00, ISLAND_OPEN_FINAL_ELDEN
	map_actor $0000, ActorScript_0f_10, $0700, $1f00, FACE_DOWN, OBJ_B_COZ, ANIM_WALK, $00, ISLAND_OPEN_FINAL_B_COZ
	map_actor $0000, ActorScript_0f_09, $1d00, $1300, FACE_RIGHT, OBJ_SEAN, ANIM_WALK, $00, ISLAND_OPEN_FINAL_SEAN
	map_actor $0000, ActorScript_0f_09, $0500, $2100, FACE_DOWN, OBJ_WALK_6F_00, ANIM_WALK, $00, ISLAND_OPEN_FINAL_WALK_6F_00
	map_actor $0000, ActorScript_0f_08, $2900, $1300, FACE_DOWN, OBJ_WALK_6F_01, ANIM_WALK, $00, ISLAND_OPEN_FINAL_WALK_6F_01
	map_actor_end
IslandOpenFinalNpcScripts_0f:
	; $6a50, 105 bytes (map_scripts)
	map_script $06, FACEMASK_ANY, $0000, Text_25_15, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script $07, FACEMASK_ANY, $0000, Text_25_16, NPC_FACE_PLAYER | NPC_RESTORE_FACING | NPC_FREEZE, $00
	map_script $08, FACEMASK_ANY, $0000, Text_25_17, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script $09, FACEMASK_ANY, $0000, Text_25_18, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script $0a, FACEMASK_ANY, $0000, Text_25_19, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script $0b, FACEMASK_ANY, $0000, Text_25_20, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script $0c, FACEMASK_ANY, $0000, Text_25_21, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script $0d, FACEMASK_ANY, $0000, Text_25_22, NPC_FACE_PLAYER | NPC_RESTORE_FACING | NPC_FREEZE, $00
	map_script $0e, FACEMASK_ANY, $0000, Text_25_23, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script $0f, FACEMASK_ANY, $0000, Text_25_24, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script $10, FACEMASK_ANY, $0000, Text_25_25, NPC_FACE_PLAYER | NPC_RESTORE_FACING | NPC_FREEZE, $00
	map_script $03, FACEMASK_ANY, $0000, TournamentNpc03_0f, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script $04, FACEMASK_ANY, $0000, TournamentNpc04_0f, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	db $ff
IslandOpenRound1ActorsDoubles_0f:
	; $6ab9, 192 bytes (map_actors)
	map_actor $0000, ActorScript_0f_09, $2700, $1100, FACE_LEFT, OBJ_WALK_6F_07, ANIM_WALK, $00, ISLAND_OPEN_ROUND1_DOUBLES_WALK_6F_07_1
	map_actor $0000, ActorScript_0f_09, $1300, $0f00, FACE_DOWN, OBJ_WALK_6F_07, ANIM_WALK, $00, ISLAND_OPEN_ROUND1_DOUBLES_WALK_6F_07_2
	map_actor $0000, ActorScript_0f_09, $0100, $0b00, FACE_RIGHT, OBJ_WALK_6F_07, ANIM_WALK, $00, ISLAND_OPEN_ROUND1_DOUBLES_WALK_6F_07_3
	map_actor $0000, ActorScript_0f_09, $2300, $1100, FACE_UP, OBJ_WALK_74_08, ANIM_WALK, $00, ISLAND_OPEN_ROUND1_DOUBLES_WALK_74_08
	map_actor $0000, ActorScript_0f_11, $2300, $1700, FACE_RIGHT, OBJ_WALK_74_06, ANIM_WALK, $00, ISLAND_OPEN_ROUND1_DOUBLES_WALK_74_06
	map_actor $0000, ActorScript_0f_09, $2900, $1700, FACE_LEFT, OBJ_SPIKE, ANIM_WALK, $00, ISLAND_OPEN_ROUND1_DOUBLES_SPIKE
	map_actor $0000, ActorScript_0f_09, $2900, $1900, FACE_LEFT, OBJ_ELDEN, ANIM_WALK, $00, ISLAND_OPEN_ROUND1_DOUBLES_ELDEN
	map_actor $0000, ActorScript_0f_09, $0f00, $1300, FACE_DOWN, OBJ_SAMMI, ANIM_WALK, $00, ISLAND_OPEN_ROUND1_DOUBLES_SAMMI
	map_actor $0000, ActorScript_0f_09, $1100, $1300, FACE_DOWN, OBJ_SEAN, ANIM_WALK, $00, ISLAND_OPEN_ROUND1_DOUBLES_SEAN
	map_actor $0000, ActorScript_0f_09, $1700, $1300, FACE_UP, OBJ_A_COZ, ANIM_WALK, $00, ISLAND_OPEN_ROUND1_DOUBLES_A_COZ
	map_actor $0000, ActorScript_0f_07, $1900, $10c0, FACE_LEFT, OBJ_B_COZ, ANIM_WALK, $00, ISLAND_OPEN_ROUND1_DOUBLES_B_COZ
	map_actor $0000, ActorScript_0f_09, $1700, $1500, FACE_DOWN, OBJ_WALK_6F_01, ANIM_WALK, $00, ISLAND_OPEN_ROUND1_DOUBLES_WALK_6F_01
	map_actor $0000, ActorScript_0f_09, $1900, $1500, FACE_DOWN, OBJ_WALK_6F_00, ANIM_WALK, $05, ISLAND_OPEN_ROUND1_DOUBLES_WALK_6F_00
	map_actor_end
IslandOpenRound1NpcScriptsDoubles_0f:
	; $6b79, 97 bytes (map_scripts)
	map_script $06, FACEMASK_ANY, $0000, Text_25_26, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script $07, FACEMASK_ANY, $0000, Text_25_27, NPC_FACE_PLAYER | NPC_RESTORE_FACING | NPC_FREEZE, $00
	map_script $08, FACEMASK_ANY, $0000, Text_25_28, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script $09, FACEMASK_ANY, $0000, Text_25_29, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script $0a, FACEMASK_ANY, $0000, IslandOpenRound1DoublesNpc0A_0f, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script $0b, FACEMASK_ANY, $0000, IslandOpenRound1DoublesNpc0B_0f, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script $0c, FACEMASK_ANY, $0000, Text_25_36, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script $0d, FACEMASK_ANY, $0000, IslandOpenRound1DoublesNpc0D_0f, NPC_FACE_PLAYER | NPC_RESTORE_FACING | NPC_FREEZE, $00
	map_script $0e, FACEMASK_ANY, $0000, Text_25_40, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script $0f, FACEMASK_ANY, $0000, Text_25_41, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script $03, FACEMASK_ANY, $0000, TournamentNpc03_0f, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script $04, FACEMASK_ANY, $0000, TournamentNpc04_0f, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	db $ff
IslandOpenRound1DoublesNpc0A_0f:
	script_set_text Text_25_30 ; $6bda
	ld a, $0a ; $6be0
	farcall ScriptShowSpeakerDialogueRestoreBG ; $6be2
	farcall RunDialogueYesNoPrompt ; $6be5
	farcall ScriptCloseDialogueWindow ; $6be8
	script_wait_frames $05 ; $6beb
	and a ; $6bf2
	jr z, .speak ; $6bf3
	farcall AdvanceDialogueTextCursor ; $6bf5
.speak:
	script_speak ACTOR_TOURNAMENT_SAMMI ; $6bf8
	ret ; $6bfd
; Instruction-identical to IslandOpenFinalDoublesNpc0B_0f (in this bank); a change here belongs in every copy.
IslandOpenRound1DoublesNpc0B_0f:
	script_set_text Text_25_33 ; $6bfe
	ld a, $0b ; $6c04
	farcall ScriptShowSpeakerDialogueRestoreBG ; $6c06
	farcall RunDialogueYesNoPrompt ; $6c09
	farcall ScriptCloseDialogueWindow ; $6c0c
	script_wait_frames $05 ; $6c0f
	and a ; $6c16
	jr z, .speak ; $6c17
	farcall AdvanceDialogueTextCursor ; $6c19
.speak:
	script_speak ACTOR_TOURNAMENT_ELDEN ; $6c1c
	ret ; $6c21
; Instruction-identical to IslandOpenSemifinalDoublesNpc0D_0f (in this bank); a change here belongs in every copy.
IslandOpenRound1DoublesNpc0D_0f:
	script_set_text Text_25_37 ; $6c22
	ld a, $0d ; $6c28
	farcall ScriptShowSpeakerDialogueRestoreBG ; $6c2a
	farcall RunDialogueYesNoPrompt ; $6c2d
	farcall ScriptCloseDialogueWindow ; $6c30
	script_wait_frames $05 ; $6c33
	and a ; $6c3a
	jr z, .speak ; $6c3b
	farcall AdvanceDialogueTextCursor ; $6c3d
.speak:
	script_speak ACTOR_TOURNAMENT_B_COZ ; $6c40
	ret ; $6c45
IslandOpenSemifinalActorsDoubles_0f:
	; $6c46, 192 bytes (map_actors)
	map_actor $0000, ActorScript_0f_09, $2700, $1100, FACE_LEFT, OBJ_WALK_6F_07, ANIM_WALK, $00, ISLAND_OPEN_SEMIFINAL_DOUBLES_WALK_6F_07_1
	map_actor $0000, ActorScript_0f_09, $1300, $0f00, FACE_DOWN, OBJ_WALK_6F_07, ANIM_WALK, $00, ISLAND_OPEN_SEMIFINAL_DOUBLES_WALK_6F_07_2
	map_actor $0000, ActorScript_0f_09, $0100, $0b00, FACE_RIGHT, OBJ_WALK_6F_07, ANIM_WALK, $00, ISLAND_OPEN_SEMIFINAL_DOUBLES_WALK_6F_07_3
	map_actor $0000, ActorScript_0f_09, $1700, $1500, FACE_DOWN, OBJ_WALK_74_08, ANIM_WALK, $00, ISLAND_OPEN_SEMIFINAL_DOUBLES_WALK_74_08
	map_actor $0000, ActorScript_0f_09, $1900, $1500, FACE_DOWN, OBJ_WALK_74_06, ANIM_WALK, $00, ISLAND_OPEN_SEMIFINAL_DOUBLES_WALK_74_06
	map_actor $0000, ActorScript_0f_09, $1d00, $1100, FACE_RIGHT, OBJ_SAMMI, ANIM_WALK, $00, ISLAND_OPEN_SEMIFINAL_DOUBLES_SAMMI
	map_actor $0000, ActorScript_0f_09, $1d00, $1500, FACE_DOWN, OBJ_SEAN, ANIM_WALK, $00, ISLAND_OPEN_SEMIFINAL_DOUBLES_SEAN
	map_actor $0000, ActorScript_0f_09, $0f00, $1300, FACE_DOWN, OBJ_SPIKE, ANIM_WALK, $00, ISLAND_OPEN_SEMIFINAL_DOUBLES_SPIKE
	map_actor $0000, ActorScript_0f_09, $1100, $1300, FACE_DOWN, OBJ_ELDEN, ANIM_WALK, $00, ISLAND_OPEN_SEMIFINAL_DOUBLES_ELDEN
	map_actor $0000, ActorScript_0f_09, $1700, $1300, FACE_UP, OBJ_A_COZ, ANIM_WALK, $00, ISLAND_OPEN_SEMIFINAL_DOUBLES_A_COZ
	map_actor $0000, ActorScript_0f_07, $1900, $10c0, FACE_LEFT, OBJ_B_COZ, ANIM_WALK, $00, ISLAND_OPEN_SEMIFINAL_DOUBLES_B_COZ
	map_actor $0000, ActorScript_0f_09, $2900, $1300, FACE_UP, OBJ_WALK_6F_01, ANIM_WALK, $00, ISLAND_OPEN_SEMIFINAL_DOUBLES_WALK_6F_01
	map_actor $0000, ActorScript_0f_11, $2500, $1900, FACE_DOWN, OBJ_WALK_6F_00, ANIM_WALK, $05, ISLAND_OPEN_SEMIFINAL_DOUBLES_WALK_6F_00
	map_actor_end
IslandOpenSemifinalNpcScriptsDoubles_0f:
	; $6d06, 97 bytes (map_scripts)
	map_script $06, FACEMASK_ANY, $0000, Text_25_42, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script $07, FACEMASK_ANY, $0000, Text_25_43, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script $08, FACEMASK_ANY, $0000, IslandOpenSemifinalDoublesNpc08_0f, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script $09, FACEMASK_ANY, $0000, Text_25_47, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script $0a, FACEMASK_ANY, $0000, Text_25_48, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script $0b, FACEMASK_ANY, $0000, Text_25_49, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script $0c, FACEMASK_ANY, $0000, Text_25_50, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script $0d, FACEMASK_ANY, $0000, IslandOpenSemifinalDoublesNpc0D_0f, NPC_FACE_PLAYER | NPC_RESTORE_FACING | NPC_FREEZE, $00
	map_script $0e, FACEMASK_ANY, $0000, Text_25_54, NPC_FACE_PLAYER | NPC_RESTORE_FACING | NPC_FREEZE, $00
	map_script $0f, FACEMASK_ANY, $0000, Text_25_55, NPC_FACE_PLAYER | NPC_RESTORE_FACING | NPC_FREEZE, $00
	map_script $03, FACEMASK_ANY, $0000, TournamentNpc03_0f, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script $04, FACEMASK_ANY, $0000, TournamentNpc04_0f, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	db $ff
IslandOpenSemifinalDoublesNpc08_0f:
	script_set_text Text_25_44 ; $6d67
	ld a, $08 ; $6d6d
	farcall ScriptShowSpeakerDialogueRestoreBG ; $6d6f
	farcall RunDialogueYesNoPrompt ; $6d72
	farcall ScriptCloseDialogueWindow ; $6d75
	script_wait_frames $05 ; $6d78
	and a ; $6d7f
	jr z, .speak ; $6d80
	farcall AdvanceDialogueTextCursor ; $6d82
.speak:
	script_speak ACTOR_TOURNAMENT_WALK_74_06 ; $6d85
	ret ; $6d8a
; Instruction-identical to IslandOpenRound1DoublesNpc0D_0f (in this bank); a change here belongs in every copy.
IslandOpenSemifinalDoublesNpc0D_0f:
	script_set_text Text_25_51 ; $6d8b
	ld a, $0d ; $6d91
	farcall ScriptShowSpeakerDialogueRestoreBG ; $6d93
	farcall RunDialogueYesNoPrompt ; $6d96
	farcall ScriptCloseDialogueWindow ; $6d99
	script_wait_frames $05 ; $6d9c
	and a ; $6da3
	jr z, .speak ; $6da4
	farcall AdvanceDialogueTextCursor ; $6da6
.speak:
	script_speak ACTOR_TOURNAMENT_B_COZ ; $6da9
	ret ; $6dae
IslandOpenFinalActorsDoubles_0f:
	; $6daf, 192 bytes (map_actors)
	map_actor $0000, ActorScript_0f_09, $2700, $1100, FACE_LEFT, OBJ_WALK_6F_07, ANIM_WALK, $00, ISLAND_OPEN_FINAL_DOUBLES_WALK_6F_07_1
	map_actor $0000, ActorScript_0f_09, $1300, $0f00, FACE_DOWN, OBJ_WALK_6F_07, ANIM_WALK, $00, ISLAND_OPEN_FINAL_DOUBLES_WALK_6F_07_2
	map_actor $0000, ActorScript_0f_09, $0e00, $0400, FACE_RIGHT, OBJ_WALK_6F_07, ANIM_WALK, $00, ISLAND_OPEN_FINAL_DOUBLES_WALK_6F_07_3
	map_actor $0000, ActorScript_0f_09, $2300, $1100, FACE_DOWN, OBJ_WALK_74_08, ANIM_WALK, $00, ISLAND_OPEN_FINAL_DOUBLES_WALK_74_08
	map_actor $0000, ActorScript_0f_09, $2300, $1300, FACE_UP, OBJ_WALK_74_06, ANIM_WALK, $00, ISLAND_OPEN_FINAL_DOUBLES_WALK_74_06
	map_actor $0000, ActorScript_0f_09, $2900, $1700, FACE_LEFT, OBJ_SPIKE, ANIM_WALK, $00, ISLAND_OPEN_FINAL_DOUBLES_SPIKE
	map_actor $0000, ActorScript_0f_09, $2900, $1900, FACE_LEFT, OBJ_ELDEN, ANIM_WALK, $00, ISLAND_OPEN_FINAL_DOUBLES_ELDEN
	map_actor $0000, ActorScript_0f_09, $0f00, $1300, FACE_DOWN, OBJ_A_COZ, ANIM_WALK, $00, ISLAND_OPEN_FINAL_DOUBLES_A_COZ
	map_actor $0000, ActorScript_0f_09, $1100, $1300, FACE_DOWN, OBJ_B_COZ, ANIM_WALK, $00, ISLAND_OPEN_FINAL_DOUBLES_B_COZ
	map_actor $0000, ActorScript_0f_09, $1d00, $1100, FACE_RIGHT, OBJ_SAMMI, ANIM_WALK, $00, ISLAND_OPEN_FINAL_DOUBLES_SAMMI
	map_actor $0000, ActorScript_0f_09, $1d00, $1500, FACE_DOWN, OBJ_SEAN, ANIM_WALK, $00, ISLAND_OPEN_FINAL_DOUBLES_SEAN
	map_actor $0000, ActorScript_0f_09, $2900, $1500, FACE_DOWN, OBJ_WALK_6F_01, ANIM_WALK, $00, ISLAND_OPEN_FINAL_DOUBLES_WALK_6F_01
	map_actor $0000, ActorScript_0f_11, $2400, $1800, FACE_DOWN, OBJ_WALK_6F_00, ANIM_WALK, $05, ISLAND_OPEN_FINAL_DOUBLES_WALK_6F_00
	map_actor_end
IslandOpenFinalNpcScriptsDoubles_0f:
	; $6e6f, 97 bytes (map_scripts)
	map_script $06, FACEMASK_ANY, $0000, Text_25_56, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script $07, FACEMASK_ANY, $0000, Text_25_57, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script $08, FACEMASK_ANY, $0000, Text_25_58, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script $09, FACEMASK_ANY, $0000, Text_25_59, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script $0a, FACEMASK_ANY, $0000, Text_25_60, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script $0b, FACEMASK_ANY, $0000, IslandOpenFinalDoublesNpc0B_0f, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script $0c, FACEMASK_ANY, $0000, IslandOpenFinalDoublesNpc0C_0f, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script $0d, FACEMASK_ANY, $0000, Text_25_67, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script $0e, FACEMASK_ANY, $0000, Text_25_68, NPC_FACE_PLAYER | NPC_RESTORE_FACING | NPC_FREEZE, $00
	map_script $0f, FACEMASK_ANY, $0000, Text_25_69, NPC_FACE_PLAYER | NPC_RESTORE_FACING | NPC_FREEZE, $00
	map_script $03, FACEMASK_ANY, $0000, TournamentNpc03_0f, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script $04, FACEMASK_ANY, $0000, TournamentNpc04_0f, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	db $ff
IslandOpenFinalDoublesNpc0C_0f:
	script_set_text Text_25_64 ; $6ed0
	ld a, $0c ; $6ed6
	farcall ScriptShowSpeakerDialogueRestoreBG ; $6ed8
	farcall RunDialogueYesNoPrompt ; $6edb
	farcall ScriptCloseDialogueWindow ; $6ede
	script_wait_frames $05 ; $6ee1
	and a ; $6ee8
	jr z, .speak ; $6ee9
	farcall AdvanceDialogueTextCursor ; $6eeb
.speak:
	script_speak ACTOR_TOURNAMENT_A_COZ ; $6eee
	ret ; $6ef3
; Instruction-identical to IslandOpenRound1DoublesNpc0B_0f (in this bank); a change here belongs in every copy.
IslandOpenFinalDoublesNpc0B_0f:
	script_set_text Text_25_61 ; $6ef4
	ld a, $0b ; $6efa
	farcall ScriptShowSpeakerDialogueRestoreBG ; $6efc
	farcall RunDialogueYesNoPrompt ; $6eff
	farcall ScriptCloseDialogueWindow ; $6f02
	script_wait_frames $05 ; $6f05
	and a ; $6f0c
	jr z, .speak ; $6f0d
	farcall AdvanceDialogueTextCursor ; $6f0f
.speak:
	script_speak ACTOR_TOURNAMENT_ELDEN ; $6f12
	ret ; $6f17
