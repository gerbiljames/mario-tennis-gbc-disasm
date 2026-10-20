Court1MapScripts_14:
	; $4fac, 14 bytes (map_tree)
	dw Court1EntryPoints_14 ; slot 0 EntryPoints
	dw Court1ExitTriggers_14 ; slot 1 ExitTriggers
	dw Court1Actors_14 ; slot 2 Actors
	dw Court1NpcScripts_14 ; slot 3 NpcScripts
	dw Court1FacingScripts_14 ; slot 4 FacingScripts
	dw Court1TileTriggers_14 ; slot 5 TileTriggers
	dw Court1InitScript_14 ; slot 6 InitScript
Court1Actors_14:
	; $4fba, 136 bytes (map_actors)
	map_actor $0000, ActorScript_14_2, 11.0, 21.0, FACE_LEFT, OBJ_TOURNAMENT_STAFF, ANIM_WALK, $00, COURT1_TOURNAMENT_STAFF_1
	map_actor $0000, ActorScript_14_2, 17.0, 35.0, FACE_DOWN, OBJ_TOURNAMENT_STAFF, ANIM_WALK, $00, COURT1_TOURNAMENT_STAFF_2
	map_actor $0000, ActorScript_14_2, 35.0, 25.0, FACE_LEFT, OBJ_STUDENT_SIDE_PART_BOY, ANIM_WALK, $03, COURT1_STUDENT_SIDE_PART_BOY_1
	map_actor $0000, ActorScript_14_2, 35.0, 28.0, FACE_LEFT, OBJ_STUDENT_PONYTAIL_GIRL, ANIM_WALK, $03, COURT1_STUDENT_PONYTAIL_GIRL
	map_actor $0000, ActorScript_14_2, 14.0, 13.0, FACE_RIGHT, OBJ_STUDENT_SIDE_PART_BOY, ANIM_WALK, $00, COURT1_STUDENT_SIDE_PART_BOY_2
	map_actor $0000, ActorScript_14_2, 15.0, 15.0, FACE_RIGHT, OBJ_STUDENT_SIDE_PART_BOY, ANIM_WALK, $06, COURT1_STUDENT_SIDE_PART_BOY_3
	map_actor $0000, ActorScript_14_2, 14.0, 17.0, FACE_RIGHT, OBJ_STUDENT_PIGTAILS_GIRL, ANIM_WALK, $03, COURT1_STUDENT_PIGTAILS_GIRL_1
	map_actor $0000, ActorScript_14_2, 35.0, 15.0, FACE_LEFT, OBJ_STUDENT_CAP_BOY, ANIM_WALK, $00, COURT1_STUDENT_CAP_BOY
	map_actor $0000, ActorScript_14_2, 33.0, 17.0, FACE_LEFT, OBJ_STUDENT_PIGTAILS_GIRL, ANIM_WALK, $04, COURT1_STUDENT_PIGTAILS_GIRL_2
	map_actor_end
Court1EntryPoints_14:
	; $5042, 17 bytes (map_entries)
	map_entry $01, FACE_RIGHT, 3.0, 21.0, $0000, COURT_1_FROM_TOURNAMENT
	map_entry $02, FACE_RIGHT, 3.0, 37.0, $0000, COURT_1_FROM_TOURNAMENT_COURTYARD
	db $ff
Court1ExitTriggers_14:
	; $5053, 17 bytes (map_scripts:exit)
	map_script $01, FACEMASK_ANY, $0000, MapScriptNop_14, STORYLOC_TOURNAMENT, ENTRY_TOURNAMENT_FROM_COURT_1, COURT_1_TO_TOURNAMENT
	map_script $02, FACEMASK_ANY, $0000, MapScriptNop_14, STORYLOC_TOURNAMENT_COURTYARD, ENTRY_TOURNAMENT_COURTYARD_FROM_COURT_1, COURT_1_TO_TOURNAMENT_COURTYARD
	db $ff
Court1Npc03_14:
	script_set_text Text_Court1StaffCourtNumberOne ; $5064
	script_speak ACTOR_COURT1_TOURNAMENT_STAFF_1 ; $506a
	ret ; $506f
Court1Npc04_14:
	script_set_text Text_Court1StaffGalleryEntrance ; $5070
	script_speak ACTOR_COURT1_TOURNAMENT_STAFF_2 ; $5076
	ret ; $507b
Court1Npc05_14:
	ld a, [wMapSceneStage] ; $507c
	add a ; $507f
	ld_hl_indexed Court1Npc05TextIds ; $5080
	ld a, [hl+] ; $5087
	ld h, [hl] ; $5088
	ld l, a ; $5089
	farcall InitDialogueTextCursor ; $508a
	script_speak ACTOR_COURT1_STUDENT_SIDE_PART_BOY_1 ; $508d
	ret ; $5092
Court1Npc05TextIds:
	; $5093, 14 bytes (text_ids)
	table_width 2
	dw Text_Court1FanAcademyFactoryTalk ; record 0
	dw Text_Court1FanAcademyFactoryTalk ; record 1
	dw Text_Court1FanSemifinalsAcademyFactory ; record 2
	dw Text_Court1FanFinalAcademyVsFactory ; record 3
	dw Text_Court1FanAcademyFactoryTalk ; record 4
	dw Text_Court1FanUnionLostDoubles ; record 5
	dw Text_Court1FanDoublesFinalAcademyVsFactory ; record 6
	assert_table_length NUM_ISLANDOPENSTAGES
Court1Npc06_14:
	ld a, [wMapSceneStage] ; $50a1
	add a ; $50a4
	ld_hl_indexed Court1Npc06TextIds ; $50a5
	ld a, [hl+] ; $50ac
	ld h, [hl] ; $50ad
	ld l, a ; $50ae
	farcall InitDialogueTextCursor ; $50af
	script_speak ACTOR_COURT1_STUDENT_PONYTAIL_GIRL ; $50b2
	ret ; $50b7
Court1Npc06TextIds:
	; $50b8, 14 bytes (text_ids)
	table_width 2
	dw Text_Court1UnionFanDontUnderestimate ; record 0
	dw Text_Court1UnionFanLostOpeningRound ; record 1
	dw Text_Court1UnionFanLostAgainSemis ; record 2
	dw Text_Court1UnionFanLostAgainFinal ; record 3
	dw Text_Court1UnionFanDontUnderestimate ; record 4
	dw Text_Court1UnionFanCountingOnUnion ; record 5
	dw Text_Court1UnionFanLostAgainDoublesFinal ; record 6
	assert_table_length NUM_ISLANDOPENSTAGES
Court1NpcScripts_14:
	; $50c6, 33 bytes (map_scripts)
	map_script ACTOR_COURT1_TOURNAMENT_STAFF_1, FACEMASK_ANY, $0000, Court1Npc03_14, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_COURT1_TOURNAMENT_STAFF_2, FACEMASK_ANY, $0000, Court1Npc04_14, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_COURT1_STUDENT_SIDE_PART_BOY_1, FACEMASK_ANY, $0000, Court1Npc05_14, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_COURT1_STUDENT_PONYTAIL_GIRL, FACEMASK_ANY, $0000, Court1Npc06_14, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	db $ff
Court1FacingScripts_14:
	; $50e7, 9 bytes (map_scripts)
	map_script $01, FACEMASK_ANY, $0000, Court1Facing01_14, $00, $00
	db $ff
Court1Facing01_14:
	ret ; $50f0
Court1TileTriggers_14:
	; $50f1, 9 bytes (map_scripts)
	map_script $01, FACEMASK_ANY, $0000, Court1Tile01_14, $00, $00
	db $ff
Court1Tile01_14:
	ret ; $50fa
Court1InitScript_14:
	call InitCourt1SceneVariant ; $50fb
	call LoadPlayerPartnerObjDefs_14 ; $50fe
	call Court1EntryWalkIn ; $5101
	ret ; $5104
InitCourt1SceneVariant:
	ld a, ISLANDOPENSTAGE_SINGLES_ROUND1 ; $5105
	ld [wMapSceneStage], a ; $5107
	test_flag FLAG_DOUBLES ; $510a
	jr nz, .doubles ; $510d
	test_flag FLAG_WON_ISLAND_OPEN_SINGLES_SEMIFINAL ; $510f
	jr z, .checkRound2 ; $5112
	ld a, ISLANDOPENSTAGE_SINGLES_FINAL ; $5114
	ld [wMapSceneStage], a ; $5116
	script_respawn_actors Court1ActorsAlt_14 ; $5119
	farcall BeginCutsceneScriptMode ; $5121
	ret ; $5124
.checkRound2:
	test_flag FLAG_WON_ISLAND_OPEN_SINGLES_ROUND_2 ; $5125
	jr z, .checkRound1 ; $5128
	ld a, ISLANDOPENSTAGE_SINGLES_SEMIFINAL ; $512a
	ld [wMapSceneStage], a ; $512c
	ret ; $512f
.checkRound1:
	test_flag FLAG_WON_ISLAND_OPEN_SINGLES_ROUND_1 ; $5130
	jr z, .keepRound1 ; $5133
	ld a, ISLANDOPENSTAGE_SINGLES_ROUND2 ; $5135
	ld [wMapSceneStage], a ; $5137
.keepRound1:
	ret ; $513a
.doubles:
	test_flag FLAG_WON_ISLAND_OPEN_DOUBLES_SEMIFINAL ; $513b
	jr z, .doublesCheckRound1 ; $513e
	ld a, ISLANDOPENSTAGE_DOUBLES_FINAL ; $5140
	ld [wMapSceneStage], a ; $5142
	script_respawn_actors Court1ActorsAlt_14 ; $5145
	farcall BeginCutsceneScriptMode ; $514d
	ret ; $5150
.doublesCheckRound1:
	test_flag FLAG_WON_ISLAND_OPEN_DOUBLES_ROUND_1 ; $5151
	jr z, .done ; $5154
	ld a, ISLANDOPENSTAGE_DOUBLES_SEMIFINAL ; $5156
	ld [wMapSceneStage], a ; $5158
	ret ; $515b
.done:
	ld a, ISLANDOPENSTAGE_DOUBLES_ROUND1 ; $515c
	ld [wMapSceneStage], a ; $515e
	ret ; $5161
Court1ActorsAlt_14:
	; $5162, 66 bytes (map_actors)
	map_actor $0000, ActorScript_14_2, 11.0, 21.0, FACE_LEFT, OBJ_TOURNAMENT_STAFF, ANIM_WALK, $00, COURT1_ALT_TOURNAMENT_STAFF_1
	map_actor $0000, ActorScript_14_2, 17.0, 35.0, FACE_DOWN, OBJ_TOURNAMENT_STAFF, ANIM_WALK, $00, COURT1_ALT_TOURNAMENT_STAFF_2
	map_actor $0000, ActorScript_14_2, 27.0, 35.0, FACE_DOWN, OBJ_STUDENT_SIDE_PART_BOY, ANIM_WALK, $03, COURT1_ALT_STUDENT_SIDE_PART_BOY
	map_actor $0000, ActorScript_14_2, 29.0, 35.0, FACE_DOWN, OBJ_STUDENT_PONYTAIL_GIRL, ANIM_WALK, $03, COURT1_ALT_STUDENT_PONYTAIL_GIRL
	map_actor_end
Court1EntryWalkIn:
	ld a, [wStoryModeEntryPoint] ; $51a4
	cp STORYENTRY_NONE ; $51a7
	jp z, .done ; $51a9
	test_flag FLAG_DOUBLES ; $51ac
	jr z, .playerWalkIn ; $51af
	script_set_speed ACTOR_PARTNER, 7.96875 ; $51b1
	script_move_angle ACTOR_PARTNER, FACE_LEFT, 2.0 ; $51b9
	script_wait_move ACTOR_PARTNER ; $51c3
	script_face ACTOR_PARTNER, FACE_RIGHT ; $51c8
	script_set_speed ACTOR_PARTNER, 0.5 ; $51cf
.playerWalkIn:
	script_set_speed ACTOR_PLAYER, 0.5 ; $51d7
	script_move_angle ACTOR_PLAYER, FACE_RIGHT, 2.0 ; $51df
.done:
	ret ; $51e9
	twin load_player_partner_obj_defs, 14 ; $51ea LoadPlayerPartnerObjDefs_14
IslandSkyMapScripts_14:
	; $5221, 14 bytes (map_tree)
	dw IslandSkyEntryPoints_14 ; slot 0 EntryPoints
	dw IslandSkyExitTriggers_14 ; slot 1 ExitTriggers
	dw IslandSkyActors_14 ; slot 2 Actors
	dw IslandSkyNpcScripts_14 ; slot 3 NpcScripts
	dw IslandSkyFacingScripts_14 ; slot 4 FacingScripts
	dw IslandSkyTileTriggers_14 ; slot 5 TileTriggers
	dw IslandSkyInitScript_14 ; slot 6 InitScript
IslandSkyActors_14:
	; $522f, 66 bytes (map_actors)
	map_actor $0000, ActorScript_14_2, 6.0, 39.0, FACE_DOWN, OBJ_HEADMASTER, ANIM_WALK, $00, ISLAND_SKY_HEADMASTER
	map_actor $0000, ActorScript_14_2, 6.0, 39.0, FACE_DOWN, OBJ_KEVIN_SWEATS, ANIM_WALK, $00, ISLAND_SKY_KEVIN_SWEATS
	map_actor $0000, ActorScript_14_2, 6.0, 39.0, FACE_DOWN, OBJ_MARK_SWEATS, ANIM_WALK, $00, ISLAND_SKY_MARK_SWEATS
	map_actor $0000, ActorScript_14_2, 6.0, 39.0, FACE_DOWN, OBJ_EMILY_SWEATS, ANIM_WALK, $00, ISLAND_SKY_EMILY_SWEATS
	map_actor_end
IslandSkyEntryPoints_14:
	; $5271, 49 bytes (map_entries)
	map_entry $01, FACE_DOWN, 12.0, 18.0, $0000, ISLAND_SKY_TO_ISLAND_OPEN
	map_entry $02, FACE_UP, 6.0, 39.0, $0000, ISLAND_SKY_HOME_FROM_ISLAND_OPEN
	map_entry $08, FACE_DOWN, 6.0, 39.0, $0000, ISLAND_SKY_VICTORY_FIREWORKS
	map_entry $0c, FACE_DOWN, 6.0, 39.0, $0000, ISLAND_SKY_CREDITS_TO_ISLAND_OPEN
	map_entry $0e, FACE_DOWN, 12.0, 11.0, $0000, ISLAND_SKY_HOME_FROM_PEACHS_CASTLE
	map_entry $0f, FACE_DOWN, 12.0, 18.0, $0000, ISLAND_SKY_TO_PEACHS_CASTLE
	entry_id ISLAND_SKY_CREDITS_TO_PEACHS_CASTLE, $0d
	db $ff
IslandSkyExitTriggers_14:
	; $52a2, 9 bytes (map_scripts:exit)
	map_script $01, FACEMASK_ANY, $0000, MapScriptNop_14, STORYLOC_RESTAURANT_PLAZA, ENTRY_RESTAURANT_PLAZA_FROM_TRAINING_COURT, ISLAND_SKY_DONE
	db $ff
Unused_14_StubNop:
	ret ; $52ab
IslandSkyNpcScripts_14:
	; $52ac, 9 bytes (map_scripts)
	map_script ACTOR_ISLAND_SKY_HEADMASTER, FACEMASK_ANY, $0000, Text_DefineAce, $00, $00
	db $ff
IslandSkyFacingScripts_14:
	db $ff ; $52b5
IslandSkyTileTriggers_14:
	db $ff ; $52b6
IslandSkyInitScript_14:
	script_set_position ACTOR_ISLAND_SKY_HEADMASTER, 63.0, 63.0 ; $52b7
	script_set_position ACTOR_ISLAND_SKY_KEVIN_SWEATS, 63.0, 63.0 ; $52c2
	script_set_position ACTOR_ISLAND_SKY_MARK_SWEATS, 63.0, 63.0 ; $52cd
	script_set_position ACTOR_ISLAND_SKY_EMILY_SWEATS, 63.0, 63.0 ; $52d8
	ld a, [wStoryModeEntryPoint] ; $52e3
	cp ENTRY_ISLAND_SKY_HOME_FROM_ISLAND_OPEN ; $52e6
	jp z, IslandSkyHomeFromIslandOpenScene ; $52e8
	cp ENTRY_ISLAND_SKY_VICTORY_FIREWORKS ; $52eb
	jp z, IslandSkyVictoryFireworksScene ; $52ed
	cp ENTRY_ISLAND_SKY_HOME_FROM_PEACHS_CASTLE ; $52f0
	jp z, IslandSkyHomeFromPeachsCastleScene ; $52f2
	cp ENTRY_ISLAND_SKY_TO_PEACHS_CASTLE ; $52f5
	jp z, IslandSkyToPeachsCastleScene ; $52f7
	cp ENTRY_ISLAND_SKY_CREDITS_TO_PEACHS_CASTLE ; $52fa
	jp z, IslandSkyToPeachsCastleScene ; $52fc
	jp .loadScene ; $52ff
	ret ; $5302
.loadScene:
	set_flag FLAG_ISLAND_SKY_SCENE_ACTIVE ; $5303
	call DisableLCDSafely ; $5306
	call LoadPlaneFrontObjGfx_14 ; $5309
	call LoadWaterSplashObjGfx_14 ; $530c
	call EnableLCD ; $530f
	ld a, $50 ; $5312
	ld [wCutscenePlaneX], a ; $5314
	ld a, $88 ; $5317
	ld [wCutscenePlaneY], a ; $5319
	frame_task QueuePlaneSpriteByHeight_14 ; $531c
	test_flag FLAG_DOUBLES ; $5324
	jp z, .setPlayerObjDef ; $5327
	script_null_script ACTOR_PARTNER ; $532a
	script_set_position ACTOR_PARTNER, 63.0, 63.0 ; $532f
	ld a, [wStoryPartnerGender] ; $533a
	ld d, OBJ_HARRY_B ; $533d
	add d ; $533f
	ld d, a ; $5340
	script_get_actor_state ACTOR_ISLAND_SKY_MARK_SWEATS ; $5341
	ld c, l ; $5346
	ld b, h ; $5347
	farcall LoadActorObjectDefIfValid ; $5348
	script_set_anim ACTOR_ISLAND_SKY_MARK_SWEATS, ANIM_WALK ; $534b
.setPlayerObjDef:
	ld a, [wStoryMainGender] ; $5352
	ld d, OBJ_ALEX_B ; $5355
	add d ; $5357
	ld d, a ; $5358
	script_get_actor_state ACTOR_PLAYER ; $5359
	ld c, l ; $535e
	ld b, h ; $535f
	farcall LoadActorObjectDefIfValid ; $5360
	script_set_anim ACTOR_PLAYER, ANIM_WALK ; $5363
	script_set_actor_mode ACTOR_PLAYER, ACTORMODE_HIDDEN ; $536a
	ld a, [wStoryModeEntryPoint] ; $5371
	cp ENTRY_ISLAND_SKY_CREDITS_TO_ISLAND_OPEN ; $5374
	jr nz, .fadeIn ; $5376
	script_set_position ACTOR_PLAYER, 6.0, 39.0 ; $5378
	xor a ; $5383
	ld [wStoryModeShowLocationName], a ; $5384
	script_fade_in 4 ; $5387
	call WaitFadeEnd ; $538c
	ld a, $3b ; $538f
	ld [wCutscenePlaneX], a ; $5391
	ld a, $a8 ; $5394
	ld [wCutscenePlaneY], a ; $5396
	jp .afterFlight ; $5399
.fadeIn:
	xor a ; $539c
	ld [wStoryModeShowLocationName], a ; $539d
	script_fade_in 6 ; $53a0
	call WaitFadeEnd ; $53a5
	sound SFX_FIREWORK_LAUNCH ; $53a8
	script_wait_frames 60 ; $53aa
	script_set_position ACTOR_PLAYER, 6.0, 39.0 ; $53b1
	ld h, $08 ; $53bc
.levelFlightLoop:
	script_wait_frames 6 ; $53be
	call PlayPlaneMoveSfx_14 ; $53c5
	ld a, [wCutscenePlaneY] ; $53c8
	inc a ; $53cb
	ld [wCutscenePlaneY], a ; $53cc
	dec h ; $53cf
	jr nz, .levelFlightLoop ; $53d0
	ld h, $08 ; $53d2
.shallowFlightLoop:
	script_wait_frames 5 ; $53d4
	call PlayPlaneMoveSfx_14 ; $53db
	ld a, h ; $53de
	and $01 ; $53df
	jr z, .shallowFlightStep ; $53e1
	ld a, [wCutscenePlaneX] ; $53e3
	dec a ; $53e6
	ld [wCutscenePlaneX], a ; $53e7
.shallowFlightStep:
	ld a, [wCutscenePlaneY] ; $53ea
	inc a ; $53ed
	ld [wCutscenePlaneY], a ; $53ee
	dec h ; $53f1
	jr nz, .shallowFlightLoop ; $53f2
	ld h, $08 ; $53f4
.steepFlightLoop:
	script_wait_frames 4 ; $53f6
	call PlayPlaneMoveSfx_14 ; $53fd
	ld a, [wCutscenePlaneX] ; $5400
	dec a ; $5403
	ld [wCutscenePlaneX], a ; $5404
	ld a, [wCutscenePlaneY] ; $5407
	inc a ; $540a
	ld [wCutscenePlaneY], a ; $540b
	dec h ; $540e
	jr nz, .steepFlightLoop ; $540f
	script_player_speed 0.5625 ; $5411
	script_move_player_to_actor ACTOR_PLAYER ; $5417
	ld h, $1c ; $541e
.boardFlightLoop:
	script_wait_frames 3 ; $5420
	call PlayPlaneMoveSfx_14 ; $5427
	ld a, h ; $542a
	and $01 ; $542b
	jr z, .boardFlightStep ; $542d
	ld a, [wCutscenePlaneX] ; $542f
	dec a ; $5432
	ld [wCutscenePlaneX], a ; $5433
.boardFlightStep:
	ld a, [wCutscenePlaneY] ; $5436
	inc a ; $5439
	ld [wCutscenePlaneY], a ; $543a
	dec h ; $543d
	jr nz, .boardFlightLoop ; $543e
.afterFlight:
	ld h, $00 ; $5440
.approachLoop:
	script_wait_frames 3 ; $5442
	inc h ; $5449
	call PlayPlaneMoveSfx_14 ; $544a
	ld a, [wCutscenePlaneY] ; $544d
	inc a ; $5450
	ld [wCutscenePlaneY], a ; $5451
	and $03 ; $5454
	cp $03 ; $5456
	jr nz, .approachStep ; $5458
	ld a, [wCutscenePlaneX] ; $545a
	dec a ; $545d
	ld [wCutscenePlaneX], a ; $545e
.approachStep:
	ld a, [wCutscenePlaneX] ; $5461
	cp $20 ; $5464
	jr nz, .approachLoop ; $5466
	ld h, $08 ; $5468
.landLoop:
	script_wait_frames 4 ; $546a
	call PlayPlaneMoveSfx_14 ; $5471
	ld a, [wCutscenePlaneY] ; $5474
	inc a ; $5477
	ld [wCutscenePlaneY], a ; $5478
	dec h ; $547b
	jr nz, .landLoop ; $547c
	sound SFX_PLANE ; $547e
	ld h, $08 ; $5480
.touchdownLoop:
	script_wait_frames 6 ; $5482
	ld a, [wCutscenePlaneY] ; $5489
	inc a ; $548c
	ld [wCutscenePlaneY], a ; $548d
	dec h ; $5490
	jr nz, .touchdownLoop ; $5491
	sound SFX_FIREWORK_SPARKLE ; $5493
	ld h, $04 ; $5495
.rollLoop:
	script_wait_frames 8 ; $5497
	ld a, [wCutscenePlaneY] ; $549e
	inc a ; $54a1
	ld [wCutscenePlaneY], a ; $54a2
	dec h ; $54a5
	jr nz, .rollLoop ; $54a6
	ld a, [wStoryModeEntryPoint] ; $54a8
	cp ENTRY_ISLAND_SKY_CREDITS_TO_ISLAND_OPEN ; $54ab
	jr z, .landingScene ; $54ad
	test_flag FLAG_DOUBLES ; $54af
	jr z, .singlesArrivalCheck ; $54b2
	test_flag FLAG_REACHED_ISLAND_OPEN_DOUBLES ; $54b4
	jp z, .landingScene ; $54b7
	jr .toCourtyard ; $54ba
.singlesArrivalCheck:
	test_flag FLAG_REACHED_ISLAND_OPEN_SINGLES ; $54bc
	jr z, .landingScene ; $54bf
.toCourtyard:
	script_fade_out 4 ; $54c1
	call WaitFadeEnd ; $54c6
	call ClearFrameTasks ; $54c9
	ld a, STORYLOC_TOURNAMENT_COURTYARD ; $54cc
	ld [wStoryModeCurrentLocation], a ; $54ce
	ld a, ENTRY_TOURNAMENT_COURTYARD_FROM_ISLAND_SKY ; $54d1
	ld [wStoryModeEntryPoint], a ; $54d3
	ld a, EXITTRIGGER_DIRECT ; $54d6
	ld [wUnusedExitTriggerIdMirror], a ; $54d8
	ld [wStoryModeExitTriggerRequest], a ; $54db
	ret ; $54de
.landingScene:
	ld a, $40 ; $54df
	ld [wCutsceneObjX], a ; $54e1
	ld a, $00 ; $54e4
	ld [wCutsceneObjY], a ; $54e6
	xor a ; $54e9
	ld [wCutsceneObjPhase], a ; $54ea
	ld a, $10 ; $54ed
	ld [wCutsceneObjRiseTimer], a ; $54ef
	ld a, $00 ; $54f2
	ld [wCutsceneObjHalt], a ; $54f4
	frame_task UpdateWaterSplash0_14 ; $54f7
	script_wait_frames 10 ; $54ff
	ld a, $50 ; $5506
	ld [wCutsceneObjX + 1], a ; $5508
	ld a, $02 ; $550b
	ld [wCutsceneObjY + 1], a ; $550d
	xor a ; $5510
	ld [wCutsceneObjPhase + 1], a ; $5511
	ld a, $10 ; $5514
	ld [wCutsceneObjRiseTimer + 1], a ; $5516
	ld a, $00 ; $5519
	ld [wCutsceneObjHalt + 1], a ; $551b
	frame_task UpdateWaterSplash1_14 ; $551e
	script_wait_frames 80 ; $5526
	script_set_position ACTOR_ISLAND_SKY_HEADMASTER, 6.0, 41.0 ; $552d
	script_set_position ACTOR_ISLAND_SKY_KEVIN_SWEATS, 6.0, 41.0 ; $5538
	script_set_position ACTOR_ISLAND_SKY_MARK_SWEATS, 6.0, 41.0 ; $5543
	script_set_position ACTOR_ISLAND_SKY_EMILY_SWEATS, 6.0, 41.0 ; $554e
	script_set_actor_script ACTOR_ISLAND_SKY_HEADMASTER, ActorScript_14_1 ; $5559
	script_wait_frames 30 ; $5564
	script_set_actor_script ACTOR_ISLAND_SKY_KEVIN_SWEATS, ActorScript_14_1 ; $556b
	script_wait_frames 30 ; $5576
	script_set_actor_script ACTOR_ISLAND_SKY_MARK_SWEATS, ActorScript_14_1 ; $557d
	script_wait_frames 30 ; $5588
	script_set_actor_script ACTOR_ISLAND_SKY_EMILY_SWEATS, ActorScript_14_1 ; $558f
	script_wait_frames 80 ; $559a
	script_set_position ACTOR_PLAYER, 6.0, 41.0 ; $55a1
	script_set_actor_mode ACTOR_PLAYER, ACTORMODE_VISIBLE ; $55ac
	script_face ACTOR_PLAYER, FACE_DOWN ; $55b3
	script_wait_frames 30 ; $55ba
	script_move_target ACTOR_PLAYER, 11.0, 41.0 ; $55c1
	script_wait_move ACTOR_PLAYER ; $55cc
	script_face ACTOR_PLAYER, FACE_UP ; $55d1
	script_wait_frames 30 ; $55d8
	script_set_anim ACTOR_PLAYER, ANIM_BOUNCE ; $55df
	script_wait_idle ACTOR_PLAYER ; $55e6
	ld a, [wStoryModeEntryPoint] ; $55eb
	cp ENTRY_ISLAND_SKY_CREDITS_TO_ISLAND_OPEN ; $55ee
	jr nz, .toDormRoom ; $55f0
	ld a, $01 ; $55f2
	ld [wCutsceneObjHalt], a ; $55f4
	ld [wCutsceneObjHalt + 1], a ; $55f7
	ld a, EXIT_ISLAND_SKY_DONE ; $55fa
	ld [wUnusedExitTriggerIdMirror], a ; $55fc
	ld [wStoryModeExitTriggerRequest], a ; $55ff
	ret ; $5602
.toDormRoom:
	script_move_target ACTOR_PLAYER, 11.0, 39.0 ; $5603
	script_wait_move ACTOR_PLAYER ; $560e
	script_set_actor_mode ACTOR_PLAYER, ACTORMODE_HIDDEN ; $5613
	script_fade_out 4 ; $561a
	call WaitFadeEnd ; $561f
	call WaitFadeEnd ; $5622
	call ClearFrameTasks ; $5625
	ld a, STORYLOC_DORM_ROOM ; $5628
	ld [wStoryModeCurrentLocation], a ; $562a
	ld a, ENTRY_DORM_ROOM_ISLAND_OPEN_ARRIVAL ; $562d
	ld [wStoryModeEntryPoint], a ; $562f
	ld a, EXITTRIGGER_DIRECT ; $5632
	ld [wUnusedExitTriggerIdMirror], a ; $5634
	ld [wStoryModeExitTriggerRequest], a ; $5637
	ret ; $563a
