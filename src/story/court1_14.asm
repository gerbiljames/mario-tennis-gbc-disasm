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
	map_actor $0000, ActorScript_14_2, 11.0, 21.0, FACE_LEFT, OBJ_WALK_6F_07, ANIM_WALK, $00, COURT1_WALK_6F_07_1
	map_actor $0000, ActorScript_14_2, 17.0, 35.0, FACE_DOWN, OBJ_WALK_6F_07, ANIM_WALK, $00, COURT1_WALK_6F_07_2
	map_actor $0000, ActorScript_14_2, 35.0, 25.0, FACE_LEFT, OBJ_WALK_72_02, ANIM_WALK, $03, COURT1_WALK_72_02_1
	map_actor $0000, ActorScript_14_2, 35.0, 28.0, FACE_LEFT, OBJ_WALK_71_05, ANIM_WALK, $03, COURT1_WALK_71_05
	map_actor $0000, ActorScript_14_2, 14.0, 13.0, FACE_RIGHT, OBJ_WALK_72_02, ANIM_WALK, $00, COURT1_WALK_72_02_2
	map_actor $0000, ActorScript_14_2, 15.0, 15.0, FACE_RIGHT, OBJ_WALK_72_02, ANIM_WALK, $06, COURT1_WALK_72_02_3
	map_actor $0000, ActorScript_14_2, 14.0, 17.0, FACE_RIGHT, OBJ_WALK_72_03, ANIM_WALK, $03, COURT1_WALK_72_03_1
	map_actor $0000, ActorScript_14_2, 35.0, 15.0, FACE_LEFT, OBJ_WALK_71_06, ANIM_WALK, $00, COURT1_WALK_71_06
	map_actor $0000, ActorScript_14_2, 33.0, 17.0, FACE_LEFT, OBJ_WALK_72_03, ANIM_WALK, $04, COURT1_WALK_72_03_2
	map_actor_end
Court1EntryPoints_14:
	; $5042, 17 bytes (map_entries)
	map_entry $01, FACE_RIGHT, 3.0, 21.0, $0000
	map_entry $02, FACE_RIGHT, 3.0, 37.0, $0000
	db $ff
Court1ExitTriggers_14:
	; $5053, 17 bytes (map_scripts:exit)
	map_script $01, FACEMASK_ANY, $0000, MapScriptNop_14, STORYLOC_TOURNAMENT, $04
	map_script $02, FACEMASK_ANY, $0000, MapScriptNop_14, STORYLOC_TOURNAMENT_COURTYARD, $01
	db $ff
Court1Npc03_14:
	script_set_text Text_1f_132 ; $5064
	script_speak ACTOR_COURT1_WALK_6F_07_1 ; $506a
	ret ; $506f
Court1Npc04_14:
	script_set_text Text_1f_133 ; $5070
	script_speak ACTOR_COURT1_WALK_6F_07_2 ; $5076
	ret ; $507b
Court1Npc05_14:
	ld a, [wMapSceneStage] ; $507c
	add a ; $507f
	ld_hl_indexed Court1Npc05TextIds ; $5080
	ld a, [hl+] ; $5087
	ld h, [hl] ; $5088
	ld l, a ; $5089
	farcall InitDialogueTextCursor ; $508a
	script_speak ACTOR_COURT1_WALK_72_02_1 ; $508d
	ret ; $5092
Court1Npc05TextIds:
	; $5093, 14 bytes (text_ids)
	dw Text_1f_134 ; record 0
	dw Text_1f_134 ; record 1
	dw Text_1f_137 ; record 2
	dw Text_1f_139 ; record 3
	dw Text_1f_134 ; record 4
	dw Text_1f_141 ; record 5
	dw Text_1f_143 ; record 6
Court1Npc06_14:
	ld a, [wMapSceneStage] ; $50a1
	add a ; $50a4
	ld_hl_indexed Court1Npc06TextIds ; $50a5
	ld a, [hl+] ; $50ac
	ld h, [hl] ; $50ad
	ld l, a ; $50ae
	farcall InitDialogueTextCursor ; $50af
	script_speak ACTOR_COURT1_WALK_71_05 ; $50b2
	ret ; $50b7
Court1Npc06TextIds:
	; $50b8, 14 bytes (text_ids)
	dw Text_1f_135 ; record 0
	dw Text_1f_136 ; record 1
	dw Text_1f_138 ; record 2
	dw Text_1f_140 ; record 3
	dw Text_1f_135 ; record 4
	dw Text_1f_142 ; record 5
	dw Text_1f_144 ; record 6
Court1NpcScripts_14:
	; $50c6, 33 bytes (map_scripts)
	map_script ACTOR_COURT1_WALK_6F_07_1, FACEMASK_ANY, $0000, Court1Npc03_14, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_COURT1_WALK_6F_07_2, FACEMASK_ANY, $0000, Court1Npc04_14, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_COURT1_WALK_72_02_1, FACEMASK_ANY, $0000, Court1Npc05_14, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
	map_script ACTOR_COURT1_WALK_71_05, FACEMASK_ANY, $0000, Court1Npc06_14, NPC_FACE_PLAYER | NPC_RESTORE_FACING, $00
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
	call LoadCourtPlayerPartnerObjDefs_14 ; $50fe
	call Court1EntryWalkIn ; $5101
	ret ; $5104
InitCourt1SceneVariant:
	ld a, ISLANDOPENSTAGE_SINGLES_ROUND1 ; $5105
	ld [wMapSceneStage], a ; $5107
	test_flag FLAG_DOUBLES ; $510a
	jr nz, .doubles ; $510d
	test_flag FLAG_WON_ISLAND_OPEN_SINGLES_SEMIFINAL ; $510f
	jr z, .stage1 ; $5112
	ld a, ISLANDOPENSTAGE_SINGLES_FINAL ; $5114
	ld [wMapSceneStage], a ; $5116
	ldh a, [hRomBank] ; $5119
	ld hl, Court1ActorsAlt_14 ; $511b
	farcall ScriptRespawnLocationActors ; $511e
	farcall BeginCutsceneScriptMode ; $5121
	ret ; $5124
.stage1:
	test_flag FLAG_WON_ISLAND_OPEN_SINGLES_ROUND_2 ; $5125
	jr z, .stage2 ; $5128
	ld a, ISLANDOPENSTAGE_SINGLES_SEMIFINAL ; $512a
	ld [wMapSceneStage], a ; $512c
	ret ; $512f
.stage2:
	test_flag FLAG_WON_ISLAND_OPEN_SINGLES_ROUND_1 ; $5130
	jr z, .stage3 ; $5133
	ld a, ISLANDOPENSTAGE_SINGLES_ROUND2 ; $5135
	ld [wMapSceneStage], a ; $5137
.stage3:
	ret ; $513a
.doubles:
	test_flag FLAG_WON_ISLAND_OPEN_DOUBLES_SEMIFINAL ; $513b
	jr z, .doublesStage2 ; $513e
	ld a, ISLANDOPENSTAGE_DOUBLES_FINAL ; $5140
	ld [wMapSceneStage], a ; $5142
	ldh a, [hRomBank] ; $5145
	ld hl, Court1ActorsAlt_14 ; $5147
	farcall ScriptRespawnLocationActors ; $514a
	farcall BeginCutsceneScriptMode ; $514d
	ret ; $5150
.doublesStage2:
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
	map_actor $0000, ActorScript_14_2, 11.0, 21.0, FACE_LEFT, OBJ_WALK_6F_07, ANIM_WALK, $00, COURT1_ALT_WALK_6F_07_1
	map_actor $0000, ActorScript_14_2, 17.0, 35.0, FACE_DOWN, OBJ_WALK_6F_07, ANIM_WALK, $00, COURT1_ALT_WALK_6F_07_2
	map_actor $0000, ActorScript_14_2, 27.0, 35.0, FACE_DOWN, OBJ_WALK_72_02, ANIM_WALK, $03, COURT1_ALT_WALK_72_02
	map_actor $0000, ActorScript_14_2, 29.0, 35.0, FACE_DOWN, OBJ_WALK_71_05, ANIM_WALK, $03, COURT1_ALT_WALK_71_05
	map_actor_end
Court1EntryWalkIn:
	ld a, [wStoryModeEntryPoint] ; $51a4
	cp STORYENTRY_NONE ; $51a7
	jp z, .done ; $51a9
	test_flag FLAG_DOUBLES ; $51ac
	jr z, .walkOff ; $51af
	script_set_speed ACTOR_PARTNER, $00ff ; $51b1
	script_move_angle ACTOR_PARTNER, FACE_LEFT, $0200 ; $51b9
	script_wait_move ACTOR_PARTNER ; $51c3
	script_face ACTOR_PARTNER, FACE_RIGHT ; $51c8
	script_set_speed ACTOR_PARTNER, $0010 ; $51cf
.walkOff:
	script_set_speed ACTOR_PLAYER, $0010 ; $51d7
	script_move_angle ACTOR_PLAYER, FACE_RIGHT, $0200 ; $51df
.done:
	ret ; $51e9
; Instruction-identical to SetPlayerPartnerActorSprites (one copy per bank); a change here belongs in every copy.
	twin_named load_court_player_partner_obj_defs, LoadCourtPlayerPartnerObjDefs_14 ; $51ea
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
	map_actor $0000, ActorScript_14_2, 6.0, 39.0, FACE_DOWN, OBJ_WALK_75_06, ANIM_WALK, $00, ISLAND_SKY_WALK_75_06
	map_actor $0000, ActorScript_14_2, 6.0, 39.0, FACE_DOWN, OBJ_WALK_74_08, ANIM_WALK, $00, ISLAND_SKY_WALK_74_08
	map_actor $0000, ActorScript_14_2, 6.0, 39.0, FACE_DOWN, OBJ_WALK_74_07, ANIM_WALK, $00, ISLAND_SKY_WALK_74_07
	map_actor $0000, ActorScript_14_2, 6.0, 39.0, FACE_DOWN, OBJ_WALK_74_06, ANIM_WALK, $00, ISLAND_SKY_WALK_74_06
	map_actor_end
IslandSkyEntryPoints_14:
	; $5271, 49 bytes (map_entries)
	map_entry $01, FACE_DOWN, 12.0, 18.0, $0000
	map_entry $02, FACE_UP, 6.0, 39.0, $0000
	map_entry $08, FACE_DOWN, 6.0, 39.0, $0000
	map_entry $0c, FACE_DOWN, 6.0, 39.0, $0000
	map_entry $0e, FACE_DOWN, 12.0, 11.0, $0000
	map_entry $0f, FACE_DOWN, 12.0, 18.0, $0000
	db $ff
IslandSkyExitTriggers_14:
	; $52a2, 9 bytes (map_scripts:exit)
	map_script $01, FACEMASK_ANY, $0000, MapScriptNop_14, STORYLOC_RESTAURANT_PLAZA, $06
	db $ff
Unused_14_StubNop:
	ret ; $52ab
IslandSkyNpcScripts_14:
	; $52ac, 9 bytes (map_scripts)
	map_script ACTOR_ISLAND_SKY_WALK_75_06, FACEMASK_ANY, $0000, Text_35_48, $00, $00
	db $ff
IslandSkyFacingScripts_14:
	ds 1, $ff ; $52b5, fill
IslandSkyTileTriggers_14:
	ds 1, $ff ; $52b6, fill
IslandSkyInitScript_14:
	script_set_position ACTOR_ISLAND_SKY_WALK_75_06, 63.0, 63.0 ; $52b7
	script_set_position ACTOR_ISLAND_SKY_WALK_74_08, 63.0, 63.0 ; $52c2
	script_set_position ACTOR_ISLAND_SKY_WALK_74_07, 63.0, 63.0 ; $52cd
	script_set_position ACTOR_ISLAND_SKY_WALK_74_06, 63.0, 63.0 ; $52d8
	ld a, [wStoryModeEntryPoint] ; $52e3
	cp $02 ; $52e6
	jp z, IslandSkyEntry02Scene ; $52e8
	cp $08 ; $52eb
	jp z, IslandSkyInitScript_14.scriptRespawnLocationActors ; $52ed
	cp $0e ; $52f0
	jp z, IslandSkyEntry0eScene ; $52f2
	cp $0f ; $52f5
	jp z, IslandSkyEntry0fAnd0dScene ; $52f7
	cp $0d ; $52fa
	jp z, IslandSkyEntry0fAnd0dScene ; $52fc
	jp .loadScene ; $52ff
	ret ; $5302
.loadScene:
	set_flag FLAG_ISLAND_SKY_SCENE_ACTIVE ; $5303
	call DisableLCDSafely ; $5306
	call LoadPlaneObjGfx_14 ; $5309
	call LoadWaterSplashObjGfx_14 ; $530c
	call EnableLCD ; $530f
	ld a, $50 ; $5312
	ld [wMapSceneStage], a ; $5314
	ld a, $88 ; $5317
	ld [wMapSceneStage2], a ; $5319
	ld a, $01 ; $531c
	ld hl, QueuePlaneSpriteByHeight_14 ; $531e
	call RegisterFrameTask ; $5321
	test_flag FLAG_DOUBLES ; $5324
	jp z, .setPlayerObjDef ; $5327
	script_null_script ACTOR_PARTNER ; $532a
	script_set_position ACTOR_PARTNER, 63.0, 63.0 ; $532f
	ld a, [wStoryModeGenderOfPartnerCharacter] ; $533a
	ld d, OBJ_HARRY_B ; $533d
	add d ; $533f
	ld d, a ; $5340
	script_get_actor_state ACTOR_ISLAND_SKY_WALK_74_07 ; $5341
	ld c, l ; $5346
	ld b, h ; $5347
	farcall LoadActorObjectDefIfValid ; $5348
	script_set_anim ACTOR_ISLAND_SKY_WALK_74_07, ANIM_WALK ; $534b
.setPlayerObjDef:
	ld a, [wStoryModeGenderOfMainCharacter] ; $5352
	ld d, OBJ_ALEX_B ; $5355
	add d ; $5357
	ld d, a ; $5358
	script_get_actor_state ACTOR_PLAYER ; $5359
	ld c, l ; $535e
	ld b, h ; $535f
	farcall LoadActorObjectDefIfValid ; $5360
	script_set_anim ACTOR_PLAYER, ANIM_WALK ; $5363
	script_set_active ACTOR_PLAYER, $00 ; $536a
	ld a, [wStoryModeEntryPoint] ; $5371
	cp $0c ; $5374
	jr nz, .fadeIn ; $5376
	script_set_position ACTOR_PLAYER, 6.0, 39.0 ; $5378
	xor a ; $5383
	ld [wStoryModeShowLocationName], a ; $5384
	script_fade_in $04 ; $5387
	call WaitFadeEnd ; $538c
	ld a, $3b ; $538f
	ld [wMapSceneStage], a ; $5391
	ld a, $a8 ; $5394
	ld [wMapSceneStage2], a ; $5396
	jp .afterFlight ; $5399
.fadeIn:
	xor a ; $539c
	ld [wStoryModeShowLocationName], a ; $539d
	script_fade_in $06 ; $53a0
	call WaitFadeEnd ; $53a5
	sound SFX_FIREWORK_LAUNCH ; $53a8
	script_wait_frames 60 ; $53aa
	script_set_position ACTOR_PLAYER, 6.0, 39.0 ; $53b1
	ld h, $08 ; $53bc
.planeLoop:
	script_wait_frames 6 ; $53be
	call PlayPlaneMoveSfx_14 ; $53c5
	ld a, [wMapSceneStage2] ; $53c8
	inc a ; $53cb
	ld [wMapSceneStage2], a ; $53cc
	dec h ; $53cf
	jr nz, .planeLoop ; $53d0
	ld h, $08 ; $53d2
.planeLoop2:
	script_wait_frames 5 ; $53d4
	call PlayPlaneMoveSfx_14 ; $53db
	ld a, h ; $53de
	and $01 ; $53df
	jr z, .advanceStage ; $53e1
	ld a, [wMapSceneStage] ; $53e3
	dec a ; $53e6
	ld [wMapSceneStage], a ; $53e7
.advanceStage:
	ld a, [wMapSceneStage2] ; $53ea
	inc a ; $53ed
	ld [wMapSceneStage2], a ; $53ee
	dec h ; $53f1
	jr nz, .planeLoop2 ; $53f2
	ld h, $08 ; $53f4
.checkStage:
	script_wait_frames 4 ; $53f6
	call PlayPlaneMoveSfx_14 ; $53fd
	ld a, [wMapSceneStage] ; $5400
	dec a ; $5403
	ld [wMapSceneStage], a ; $5404
	ld a, [wMapSceneStage2] ; $5407
	inc a ; $540a
	ld [wMapSceneStage2], a ; $540b
	dec h ; $540e
	jr nz, .checkStage ; $540f
	script_player_speed $0012 ; $5411
	script_move_player_to_actor ACTOR_PLAYER ; $5417
	ld h, $1c ; $541e
.descend:
	script_wait_frames 3 ; $5420
	call PlayPlaneMoveSfx_14 ; $5427
	ld a, h ; $542a
	and $01 ; $542b
	jr z, .landed ; $542d
	ld a, [wMapSceneStage] ; $542f
	dec a ; $5432
	ld [wMapSceneStage], a ; $5433
.landed:
	ld a, [wMapSceneStage2] ; $5436
	inc a ; $5439
	ld [wMapSceneStage2], a ; $543a
	dec h ; $543d
	jr nz, .descend ; $543e
.afterFlight:
	ld h, $00 ; $5440
.placeActors:
	script_wait_frames 3 ; $5442
	inc h ; $5449
	call PlayPlaneMoveSfx_14 ; $544a
	ld a, [wMapSceneStage2] ; $544d
	inc a ; $5450
	ld [wMapSceneStage2], a ; $5451
	and $03 ; $5454
	cp $03 ; $5456
	jr nz, .placeDoubles ; $5458
	ld a, [wMapSceneStage] ; $545a
	dec a ; $545d
	ld [wMapSceneStage], a ; $545e
.placeDoubles:
	ld a, [wMapSceneStage] ; $5461
	cp $20 ; $5464
	jr nz, .placeActors ; $5466
	ld h, $08 ; $5468
.walkOff:
	script_wait_frames 4 ; $546a
	call PlayPlaneMoveSfx_14 ; $5471
	ld a, [wMapSceneStage2] ; $5474
	inc a ; $5477
	ld [wMapSceneStage2], a ; $5478
	dec h ; $547b
	jr nz, .walkOff ; $547c
	sound SFX_PLANE ; $547e
	ld h, $08 ; $5480
.speak:
	script_wait_frames 6 ; $5482
	ld a, [wMapSceneStage2] ; $5489
	inc a ; $548c
	ld [wMapSceneStage2], a ; $548d
	dec h ; $5490
	jr nz, .speak ; $5491
	sound SFX_FIREWORK_SPARKLE ; $5493
	ld h, $04 ; $5495
.speakDoubles:
	script_wait_frames 8 ; $5497
	ld a, [wMapSceneStage2] ; $549e
	inc a ; $54a1
	ld [wMapSceneStage2], a ; $54a2
	dec h ; $54a5
	jr nz, .speakDoubles ; $54a6
	ld a, [wStoryModeEntryPoint] ; $54a8
	cp $0c ; $54ab
	jr z, .setLocation ; $54ad
	test_flag FLAG_DOUBLES ; $54af
	jr z, .fadeOut ; $54b2
	test_flag FLAG_REACHED_ISLAND_OPEN_DOUBLES ; $54b4
	jp z, .setLocation ; $54b7
	jr .transition ; $54ba
.fadeOut:
	test_flag FLAG_REACHED_ISLAND_OPEN_SINGLES ; $54bc
	jr z, .setLocation ; $54bf
.transition:
	ld c, $04 ; $54c1
	call BeginFadeOut ; $54c3
	call WaitFadeEnd ; $54c6
	call ClearFrameTasks ; $54c9
	ld a, STORYLOC_TOURNAMENT_COURTYARD ; $54cc
	ld [wStoryModeCurrentLocation], a ; $54ce
	ld a, $04 ; $54d1
	ld [wStoryModeEntryPoint], a ; $54d3
	ld a, $ff ; $54d6
	ld [wUnusedExitTriggerIdMirror], a ; $54d8
	ld [wStoryModeExitTriggerRequest], a ; $54db
	ret ; $54de
.setLocation:
	ld a, $40 ; $54df
	ld [wCutsceneObjX], a ; $54e1
	ld a, $00 ; $54e4
	ld [wCutsceneObjY], a ; $54e6
	xor a ; $54e9
	ld [wCutsceneObjPhase], a ; $54ea
	ld a, $10 ; $54ed
	ld [wCutsceneObjRiseTimer], a ; $54ef
	ld a, $00 ; $54f2
	ld [wCutsceneObjActive], a ; $54f4
	ld a, $01 ; $54f7
	ld hl, UpdateWaterSplash0_14 ; $54f9
	call RegisterFrameTask ; $54fc
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
	ld [wCutsceneObjActive + 1], a ; $551b
	ld a, $01 ; $551e
	ld hl, UpdateWaterSplash1_14 ; $5520
	call RegisterFrameTask ; $5523
	script_wait_frames 80 ; $5526
	script_set_position ACTOR_ISLAND_SKY_WALK_75_06, 6.0, 41.0 ; $552d
	script_set_position ACTOR_ISLAND_SKY_WALK_74_08, 6.0, 41.0 ; $5538
	script_set_position ACTOR_ISLAND_SKY_WALK_74_07, 6.0, 41.0 ; $5543
	script_set_position ACTOR_ISLAND_SKY_WALK_74_06, 6.0, 41.0 ; $554e
	script_set_actor_script ACTOR_ISLAND_SKY_WALK_75_06, ActorScript_14_1 ; $5559
	script_wait_frames 30 ; $5564
	script_set_actor_script ACTOR_ISLAND_SKY_WALK_74_08, ActorScript_14_1 ; $556b
	script_wait_frames 30 ; $5576
	script_set_actor_script ACTOR_ISLAND_SKY_WALK_74_07, ActorScript_14_1 ; $557d
	script_wait_frames 30 ; $5588
	script_set_actor_script ACTOR_ISLAND_SKY_WALK_74_06, ActorScript_14_1 ; $558f
	script_wait_frames 80 ; $559a
	script_set_position ACTOR_PLAYER, 6.0, 41.0 ; $55a1
	script_set_active ACTOR_PLAYER, $02 ; $55ac
	script_face ACTOR_PLAYER, FACE_DOWN ; $55b3
	script_wait_frames 30 ; $55ba
	script_move_target ACTOR_PLAYER, 11.0, 41.0 ; $55c1
	script_wait_move ACTOR_PLAYER ; $55cc
	script_face ACTOR_PLAYER, FACE_UP ; $55d1
	script_wait_frames 30 ; $55d8
	script_set_anim ACTOR_PLAYER, ANIM_BOUNCE ; $55df
	script_wait_idle ACTOR_PLAYER ; $55e6
	ld a, [wStoryModeEntryPoint] ; $55eb
	cp $0c ; $55ee
	jr nz, .done ; $55f0
	ld a, $01 ; $55f2
	ld [wCutsceneObjActive], a ; $55f4
	ld [wCutsceneObjActive + 1], a ; $55f7
	ld a, $01 ; $55fa
	ld [wUnusedExitTriggerIdMirror], a ; $55fc
	ld [wStoryModeExitTriggerRequest], a ; $55ff
	ret ; $5602
.done:
	script_move_target ACTOR_PLAYER, 11.0, 39.0 ; $5603
	script_wait_move ACTOR_PLAYER ; $560e
	script_set_active ACTOR_PLAYER, $00 ; $5613
	ld c, $04 ; $561a
	call BeginFadeOut ; $561c
	call WaitFadeEnd ; $561f
	call WaitFadeEnd ; $5622
	call ClearFrameTasks ; $5625
	ld a, STORYLOC_DORM_ROOM ; $5628
	ld [wStoryModeCurrentLocation], a ; $562a
	ld a, $09 ; $562d
	ld [wStoryModeEntryPoint], a ; $562f
	ld a, $ff ; $5632
	ld [wUnusedExitTriggerIdMirror], a ; $5634
	ld [wStoryModeExitTriggerRequest], a ; $5637
	ret ; $563a
